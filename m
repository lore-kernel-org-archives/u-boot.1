Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03F0C30653
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 10:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7DD388829;
	Wed,  3 Jul 2024 12:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="Iwito3gv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2EC988811; Wed,  3 Jul 2024 12:13:11 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B8F088815
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 12:13:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 105A9148A92A; Wed,  3 Jul 2024 12:13:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1720001586; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=e9kSROuTq0ytcmHnyGlmmpZNR1JHdlE44O/EJ+2ZpjI=;
 b=Iwito3gvLhCW7RIOA4BXdvsd1CPBPHpa2hyU4apzBOLcVh73uOuBusVj8FTwhH1u1cFiQn
 v8GrrLneuI5XXhyJiokqvU+p51/fo1GgHyIZRCCdc2uf+DNmuhA54i3RDJHw+/kRqg2BWk
 Ebj6MPifLoU83aLOEY5E3AEoKav46bMxbo/2E5zz5a8sk1M6iX5RrOSzi2wIwpJNfwyGV9
 SaFy10bDACrqgsYux2ojB7vy2xe4iZXNIS9k3pxEwDMyZbzzrC/I0g1dVQt4GD0GE7Ry8e
 hT1xNxyMWPki5xrRAG61QRe25j3rzkQ8ADnyqgGkzpmmR7cTvR/ldIl7XWOLWQ==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Heiko Schocher <hs@denx.de>,
 Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/4] fs: ubifs: Add volume mounted check
Date: Wed,  3 Jul 2024 12:12:58 +0200
Message-Id: <20240703101258.1670825-5-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240703101258.1670825-1-ada@thorsis.com>
References: <20240703101258.1670825-1-ada@thorsis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Safety guard in the U-Boot filesystem glue code, because these functions
are called from different parts of the codebase.  For generic filesystem
handling this should have been checked in blk_get_device_part_str()
already.  Commands from cmd/ubifs.c should also check this before
calling those functions, but you never know?!

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 fs/ubifs/ubifs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
index 506e29958c3..9722cc440ab 100644
--- a/fs/ubifs/ubifs.c
+++ b/fs/ubifs/ubifs.c
@@ -573,6 +573,11 @@ int ubifs_ls(const char *filename)
 	unsigned long inum;
 	int ret = 0;
 
+	if (!ubifs_is_mounted()) {
+		debug("UBIFS not mounted, use ubifsmount to mount volume first!\n");
+		return -1;
+	}
+
 	inum = ubifs_findfile(ubifs_sb, (char *)filename);
 	if (!inum) {
 		ret = -1;
@@ -613,6 +618,11 @@ int ubifs_exists(const char *filename)
 {
 	unsigned long inum;
 
+	if (!ubifs_is_mounted()) {
+		debug("UBIFS not mounted, use ubifsmount to mount volume first!\n");
+		return -1;
+	}
+
 	inum = ubifs_findfile(ubifs_sb, (char *)filename);
 
 	return inum != 0;
@@ -624,6 +634,11 @@ int ubifs_size(const char *filename, loff_t *size)
 	struct inode *inode;
 	int err = 0;
 
+	if (!ubifs_is_mounted()) {
+		debug("UBIFS not mounted, use ubifsmount to mount volume first!\n");
+		return -1;
+	}
+
 	inum = ubifs_findfile(ubifs_sb, (char *)filename);
 	if (!inum) {
 		err = -1;
@@ -827,6 +842,11 @@ int ubifs_read(const char *filename, void *buf, loff_t offset,
 	int count;
 	int last_block_size = 0;
 
+	if (!ubifs_is_mounted()) {
+		debug("UBIFS not mounted, use ubifsmount to mount volume first!\n");
+		return -1;
+	}
+
 	*actread = 0;
 
 	if (offset & (PAGE_SIZE - 1)) {
-- 
2.39.2


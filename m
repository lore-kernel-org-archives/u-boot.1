Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC27D10BE5
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 06:42:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D79A889066;
	Sat, 26 Oct 2024 08:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="orqfohpH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBF738903B; Sat, 26 Oct 2024 08:41:08 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB48B88EC0
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 08:41:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.c.hoisthospitality.com (unknown [87.215.50.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 0325C426DA; 
 Sat, 26 Oct 2024 06:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729924861;
 bh=Ea3wEZVljo5X2spYqMM4kfMcwDeHAoODNrJPjfdugyc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=orqfohpHEeF8cjEO8n0ETPYUdbGPG5KOASjUsO5CCXlk/ZDTMPL7iDtQUWGkVl5Xo
 ZK58W7UjRpT5s6avGlnbZFOdHWOr8YxEIRqmRtK8o7grqSAlSFxzPS3Sy9/3XAxC+3
 YVitCQYWS501tACJZ4Ntxi3kEw6miuGzPLcaMeraQq5VHK6feaQv30L6ENZYcbjv7t
 WPjEJJDcaAmnLAneglgXGiJR7lUSeJ+fWeFndjNLC39CH6NQxjCXQ0Hfhraa8OsdlF
 wM5KlwykVM8i5RDLiW5vb7By6pu51+115BGQipzOmL7KixXoYf+J0iGdEkez+b8N1j
 y5/OacByo2+VA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/5] fs: ext4: free directory node in ext4fs_exists()
Date: Sat, 26 Oct 2024 08:40:45 +0200
Message-ID: <20241026064048.370062-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The directory retrieved in ext4fs_exists() should be freed to avoid a
memory leak.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/ext4/ext4fs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
index 15587e92e3e..21714149ef5 100644
--- a/fs/ext4/ext4fs.c
+++ b/fs/ext4/ext4fs.c
@@ -209,12 +209,17 @@ int ext4fs_exists(const char *filename)
 {
 	struct ext2fs_node *dirnode = NULL;
 	int filetype;
+	int ret;
 
 	if (!filename)
 		return 0;
 
-	return ext4fs_find_file1(filename, &ext4fs_root->diropen, &dirnode,
-				 &filetype);
+	ret = ext4fs_find_file1(filename, &ext4fs_root->diropen, &dirnode,
+				&filetype);
+	if (dirnode)
+		ext4fs_free_node(dirnode, &ext4fs_root->diropen);
+
+	return ret;
 }
 
 int ext4fs_size(const char *filename, loff_t *size)
-- 
2.45.2


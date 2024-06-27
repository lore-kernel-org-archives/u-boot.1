Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56531C30659
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 17:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8274B884F9;
	Thu, 27 Jun 2024 19:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E37FB87F9F; Thu, 27 Jun 2024 19:06:49 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C649988247
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 19:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEBAC367;
 Thu, 27 Jun 2024 10:07:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.6.198])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EAFB73F766;
 Thu, 27 Jun 2024 10:06:45 -0700 (PDT)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] bootstd: cros: store partition type in an efi_guid_t
Date: Thu, 27 Jun 2024 19:06:29 +0200
Message-ID: <20240627170629.2696427-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The scan_part() function uses a struct uuid to store the little-endian
partition type GUID, but this structure should be used only to contain a
big-endian UUID. Use an efi_guid_t instead.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 boot/bootmeth_cros.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index f015f2e1c75..1f83c14aeab 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -148,7 +148,7 @@ static int scan_part(struct udevice *blk, int partnum,
 {
 	struct blk_desc *desc = dev_get_uclass_plat(blk);
 	struct vb2_keyblock *hdr;
-	struct uuid type;
+	efi_guid_t type;
 	ulong num_blks;
 	int ret;
 
@@ -161,7 +161,7 @@ static int scan_part(struct udevice *blk, int partnum,
 
 	/* Check for kernel partition type */
 	log_debug("part %x: type=%s\n", partnum, info->type_guid);
-	if (uuid_str_to_bin(info->type_guid, (u8 *)&type, UUID_STR_FORMAT_GUID))
+	if (uuid_str_to_bin(info->type_guid, type.b, UUID_STR_FORMAT_GUID))
 		return log_msg_ret("typ", -EINVAL);
 
 	if (memcmp(&cros_kern_type, &type, sizeof(type)))
-- 
2.43.0


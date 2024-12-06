Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C37E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 11:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05B7D89481;
	Fri,  6 Dec 2024 12:36:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5085089190; Fri,  6 Dec 2024 08:59:02 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1DA3D89078
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 08:59:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F1F811FB;
 Thu,  5 Dec 2024 23:59:27 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.0.135])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6EF3F3F58B;
 Thu,  5 Dec 2024 23:58:58 -0800 (PST)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: qemu: fix update_info declaration
Date: Fri,  6 Dec 2024 08:58:53 +0100
Message-ID: <20241206075853.1819633-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Dec 2024 12:36:33 +0100
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

Add a missing comma in the update_info structure declaration.

This fixes the following build error when building with
EFI_RUNTIME_UPDATE_CAPSULE or EFI_CAPSULE_ON_DISK:

  board/emulation/qemu-arm/qemu-arm.c:52:9: error: request for member ‘images’ in something not a structure or union

Fixes: cccea18813c4 ("efi_loader: add the number of image entries in efi_capsule_update_info")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc: Tom Rini <trini@konsulko.com>
---
 board/emulation/qemu-arm/qemu-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
index 6095cb02b23..e0e18b4dfea 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -48,7 +48,7 @@ struct efi_fw_image fw_images[] = {
 };
 
 struct efi_capsule_update_info update_info = {
-	.num_images = ARRAY_SIZE(fw_images)
+	.num_images = ARRAY_SIZE(fw_images),
 	.images = fw_images,
 };
 
-- 
2.45.2


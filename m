Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259DAC02190
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 13:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AFD3820B0;
	Thu, 30 Jan 2025 14:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE340820DE; Thu, 30 Jan 2025 14:37:06 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 96A2B81F69
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 14:37:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76024497;
 Thu, 30 Jan 2025 05:37:29 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C780D3F63F;
 Thu, 30 Jan 2025 05:37:02 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
	Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] env: fat: Avoid writing to read-only location
Date: Thu, 30 Jan 2025 13:36:46 +0000
Message-Id: <20250130133646.2177194-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
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

The env_fat_get_dev_part() function mostly returns a fixed string, set
via some Kconfig variable. However when the first character is a colon,
that means that the boot device number is determined at runtime, and
patched in. This requires altering the string.

So far this was done via some ugly and actually illegal direct write to
the .rodata string storage. We got away with this because U-Boot maps
everything as read/write/execute so far.

A proposed patch set actually enforces read-only (and no-execute)
permissions in the page tables, so this routine now causes an exception:
=======================
Loading Environment from FAT... "Synchronous Abort" handler, esr 0x9600004f, far 0xfffb7d4c
elr: 000000004a054228 lr : 000000004a05421c (reloc)
elr: 00000000fff7c228 lr : 00000000fff7c21c
.....
=======================

Rewrite the routine to do away with the dodgy string manipulation,
instead allocate the string in the r/w .data section, where we can
safely manipulate it.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi,

found when naively testing Ilias' series on some Allwinner board.
I am sure there are better ways to implement this (probably as many as
there are developers), but this works for me.
This does away with the optimisation of doing the manipulation only
once, but I am not sure that's really worthwhile?

Cheers,
Andre

 env/fat.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/env/fat.c b/env/fat.c
index b04b1d9c315..1ad301eaaff 100644
--- a/env/fat.c
+++ b/env/fat.c
@@ -41,14 +41,12 @@ __weak const char *env_fat_get_intf(void)
 __weak char *env_fat_get_dev_part(void)
 {
 #ifdef CONFIG_MMC
-	static char *part_str;
-
-	if (!part_str) {
-		part_str = CONFIG_ENV_FAT_DEVICE_AND_PART;
-		if (!strcmp(CONFIG_ENV_FAT_INTERFACE, "mmc") && part_str[0] == ':') {
-			part_str = "0" CONFIG_ENV_FAT_DEVICE_AND_PART;
-			part_str[0] += mmc_get_env_dev();
-		}
+	/* reserve one more char for the manipulation below */
+	static char part_str[] = CONFIG_ENV_FAT_DEVICE_AND_PART "\0";
+
+	if (!strcmp(CONFIG_ENV_FAT_INTERFACE, "mmc") && part_str[0] == ':') {
+		part_str[0] = '0' + mmc_get_env_dev();
+		strcpy(&part_str[1], CONFIG_ENV_FAT_DEVICE_AND_PART);
 	}
 
 	return part_str;
-- 
2.25.1


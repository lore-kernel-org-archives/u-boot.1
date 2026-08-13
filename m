Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44EDC5CFCF
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 12:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBDE560832;
	Thu, 13 Aug 2026 12:36:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8B-kL-ZKMFye; Thu, 13 Aug 2026 12:36:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BDD4A6085D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786624603;
	bh=nL60D6cnmE9W1NPIe1ahHFlaeZ7Y1V3RdjMseBRdBR8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SSPS50Rf+N/zxeFmIFZBLCRti+6y+7jFeM++cfdrorLyQ+RL9pRwOemLkmO2UeyWq
	 Mhcw7MataapjF30vRmt2bd2PyoHSvFOf6UcOFttvsExmPzmX78NyBgkOHopLO0Kf3t
	 baPCnXvyKMH8ysdfuFSQzSRWpTO5ApIXveNdLELSvecQvt7q+NAib+65Mw6fShpgg6
	 DRRgCv6WVsAcnYWzV4Dw0hDjLC2GX/ilTqcCp3I2C9YcHOiYJtPlR/vLLnXv+zMbhn
	 k5LWVpXvaNcTGw0LivL2OZhf28m+0OWQCnbQAHejpTPJapCcXuPVjoipAz6KEdYLcB
	 mEyygSL3UVxfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDD4A6085D;
	Thu, 13 Aug 2026 12:36:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A5DC1B8
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 12:36:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7C645403BE
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 12:36:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VNNLxkLnGALv for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 12:36:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=pbiel7@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 633E2400AC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 633E2400AC
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 633E2400AC
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 12:36:41 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so15134815e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786624599; x=1787229399;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nL60D6cnmE9W1NPIe1ahHFlaeZ7Y1V3RdjMseBRdBR8=;
 b=tHz7tYjTBPgtHjr5hbIWzXfkwkJuvBAl/KbXx1BBWUzE+kTAkUhm++U5oLnYzkd0cK
 50EdR0agUxpnQIE4oIPyKLCJfoVD05+zFK4jB46sIEK2Ln+jnjuhKC7K+vsQeuk0dN1z
 FyiAgzph9MJee9xv6eTnyiOVU4jiREGcGgur8rNJT4kLfeyLgxe4LqQ3VNHtk5HRgWlW
 M2q06Y+1CN9hUgmrEYImEtYAU5ghJVACsfXlu82gK5aTZTBrBpAODCifhdb/fEoXx+8V
 KzsRFEl1liDvJ5XRab+vGrqoTj07YdyCdAUFqEDCv53Lei/buSL/n+/t6Gobm14Zrsr3
 XzVw==
X-Gm-Message-State: AOJu0Yx9PKS4oFUR/EvRgcMavpjZEdz4V5hjswo1hOCIC4STn6MjFvqF
 QRkx5teMXmiVJVsE2CnlSXYv41N8o+z7KJ9o0ra41hmVtj7hPdTIfCsY7oy/JATU
X-Gm-Gg: AR+sD10QyBd8m/kioTIUv0y/BWM/9U1SqJSEw3TM36a5U45rZhlfzcpYtbhzWCZxR99
 QxKLpGrIEIifQMoy3CRsQ1LyzmSY+w0AGydd4iJTXQBf3wjH1dKa7lSS+R0LZEVckb19vWW6aGl
 R5b6glka+/3l9cQZ1Y2gfVd73WpqW/06oJNn/MFxKO26MAdrXTUGS7GwKjvbTuxFtYcnPRZt8qC
 9zb+7cA7yFXBWfy/HYFu370YQDymwkHnzk5yMmyALdD8hEATdGeZEFRRoUuA+Kq3Ml6LmzToNbk
 v2GY7EA2GdjqZWnqBJ2+N7+/5+V0tp82aWuvbDLk4F8PtxC+qAU3M4VeUvng8b5457Qe6exI4Le
 /ui6G3rXvJDNVqRiVx6ROhu7s4ZtkBX4qKpqep12hfdheYbaUeyztmS+NhFXb/Zh4DNrPM8k62t
 YN3JPYEPBJ0Ja2nD22gX8ZARl+zJbU86I81BAVbrrVHw7RWhV7/xUXKmFeQgTe2qetaNdnWmyGf
 DorscjpFJ9uFqasuGyOF+SFzqfQSnG9NiCzPWxdx/urVPtDjJWhVWbTS7mxLIYrT1xIX7jYAoa2
 tnBNzpT8pSsTvp+e2ojU+vpS
X-Received: by 2002:a05:600c:c0d8:b0:499:84ff:b16 with SMTP id
 5b1f17b1804b1-49984ff0b4amr23456485e9.14.1786624599287; 
 Thu, 13 Aug 2026 05:36:39 -0700 (PDT)
Received: from localhost (89-73-120-30.dynamic.play.pl. [89.73.120.30])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4815a561296sm6796061f8f.4.2026.08.13.05.36.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 05:36:38 -0700 (PDT)
From: Patryk Biel <pbiel7@gmail.com>
Date: Thu, 13 Aug 2026 14:36:31 +0200
Subject: [PATCH] arm: mach-k3: j721e: make get_boot_device() available
 outside xPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-up-j721e-get-boot-device-v1-1-fb50a5a328d0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAE66fWoC/x3MQQqDMBBG4avIrB1wIjbVq0gXav6m48JIYkUQ7
 25w+RbfOykhKhJ1xUkRuyYNSw4pC5p+w+LB6nKTqcyrekvN/5VnawTssfEYwsYuswlsxbXS1tL
 IAMp8jfjq8az7z3XdZBzHxGoAAAA=
X-Change-ID: 20260813-up-j721e-get-boot-device-71d9193151ae
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patryk Biel <pbiel7@gmail.com>
X-Mailer: b4 0.14.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786624599; x=1787229399;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nL60D6cnmE9W1NPIe1ahHFlaeZ7Y1V3RdjMseBRdBR8=;
 b=UZ0P4PDU4Ni+D2bPfXPFBUuUog1agvUxaATjB3DiKJh6Bu+EhpA9fi4eUoGYbmnRFu
 jWOkj5iRR0pu9Ij2c2aGkr4EekLXc3NbyFOiefinOrBQ0PHmB5Qfr3Y7rIKRmqcMx4Sk
 BOhc+uIeUihSlGvmNda23PGV2JUc7DYnGe7M7s67LVba4rdVJJNvLkVUVjXyU2Si8ku9
 4nB5+fW2aSDmnL2vFFHLKneIfVBiDmZijK+u76Q0H8Fy/3jUAcnC/V3FaoX089dgrluj
 ULfWqpNIGyFQs9zwQ6Hgl9rvB9GkVTd/rIpcBdYtAarbvYD5yDBSCeglkzTlao6pFk44
 Jn2g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=UZ0P4PDU
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

J721E/J7200 decodes the ROM-selected boot media in j721e_init.c,
which is built only for xPL. This keeps spl_boot_device() working, but
leaves U-Boot proper without the get_boot_device() implementation
declared by the common K3 hardware header. Board code that uses the
helper to select the environment or boot targets therefore cannot link.

Move the existing primary and backup boot-media decoding into a new
boot.c and build it unconditionally for J721E and J7200. Keep
spl_boot_device() as a wrapper around get_boot_device(), preserving the
existing xPL result while making the same decode available outside xPL.

Tested on: J7200X-PM2-SOM rev E8

Signed-off-by: Patryk Biel <pbiel7@gmail.com>
---
This follows the existing J721S2 layout and only moves the existing
J721E/J7200 boot-media decoding out of the xPL-only init file.
---
 arch/arm/mach-k3/j7200/Makefile     |  1 +
 arch/arm/mach-k3/j721e/Makefile     |  1 +
 arch/arm/mach-k3/j721e/boot.c       | 76 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/j721e/j721e_init.c | 69 +--------------------------------
 4 files changed, 79 insertions(+), 68 deletions(-)

diff --git a/arch/arm/mach-k3/j7200/Makefile b/arch/arm/mach-k3/j7200/Makefile
index 6d3ff36e363c259481fd92aeee7b8ea894b0905e..c62d745bf8ea4e851c4e650b36d828140bdc0cf5 100644
--- a/arch/arm/mach-k3/j7200/Makefile
+++ b/arch/arm/mach-k3/j7200/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_OF_SYSTEM_SETUP) += ../j721e/j721e_fdt.o
 obj-$(CONFIG_XPL_BUILD) += ../j721e/j721e_init.o
+obj-y += ../j721e/boot.o
diff --git a/arch/arm/mach-k3/j721e/Makefile b/arch/arm/mach-k3/j721e/Makefile
index e4b0e5a8193e5aedfcdc977385572a3cb52aed75..d45b76d01f0bd805656c63071a3aa3e4106608ed 100644
--- a/arch/arm/mach-k3/j721e/Makefile
+++ b/arch/arm/mach-k3/j721e/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_OF_SYSTEM_SETUP) += j721e_fdt.o
 obj-$(CONFIG_XPL_BUILD) += j721e_init.o
+obj-y += boot.o
diff --git a/arch/arm/mach-k3/j721e/boot.c b/arch/arm/mach-k3/j721e/boot.c
new file mode 100644
index 0000000000000000000000000000000000000000..10ed1c607c71e25740733dad64f45b21a3668f38
--- /dev/null
+++ b/arch/arm/mach-k3/j721e/boot.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <asm/io.h>
+#include <asm/arch/hardware.h>
+#include <asm/arch/spl.h>
+
+static u32 __get_backup_bootmedia(u32 main_devstat)
+{
+	u32 bkup_boot = (main_devstat & MAIN_DEVSTAT_BKUP_BOOTMODE_MASK) >>
+			MAIN_DEVSTAT_BKUP_BOOTMODE_SHIFT;
+
+	switch (bkup_boot) {
+	case BACKUP_BOOT_DEVICE_USB:
+		return BOOT_DEVICE_DFU;
+	case BACKUP_BOOT_DEVICE_UART:
+		return BOOT_DEVICE_UART;
+	case BACKUP_BOOT_DEVICE_ETHERNET:
+		return BOOT_DEVICE_ETHERNET;
+	case BACKUP_BOOT_DEVICE_MMC2:
+	{
+		u32 port = (main_devstat & MAIN_DEVSTAT_BKUP_MMC_PORT_MASK) >>
+			    MAIN_DEVSTAT_BKUP_MMC_PORT_SHIFT;
+		if (port == 0x0)
+			return BOOT_DEVICE_MMC1;
+		return BOOT_DEVICE_MMC2;
+	}
+	case BACKUP_BOOT_DEVICE_SPI:
+		return BOOT_DEVICE_SPI;
+	case BACKUP_BOOT_DEVICE_I2C:
+		return BOOT_DEVICE_I2C;
+	}
+
+	return BOOT_DEVICE_RAM;
+}
+
+static u32 __get_primary_bootmedia(u32 main_devstat, u32 wkup_devstat)
+{
+	u32 bootmode = (wkup_devstat & WKUP_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
+			WKUP_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
+
+	bootmode |= (main_devstat & MAIN_DEVSTAT_BOOT_MODE_B_MASK) <<
+			BOOT_MODE_B_SHIFT;
+
+	if (bootmode == BOOT_DEVICE_OSPI || bootmode == BOOT_DEVICE_QSPI ||
+	    bootmode == BOOT_DEVICE_XSPI)
+		bootmode = BOOT_DEVICE_SPI;
+
+	if (bootmode == BOOT_DEVICE_MMC2) {
+		u32 port = (main_devstat &
+			    MAIN_DEVSTAT_PRIM_BOOTMODE_MMC_PORT_MASK) >>
+			   MAIN_DEVSTAT_PRIM_BOOTMODE_PORT_SHIFT;
+		if (port == 0x0)
+			bootmode = BOOT_DEVICE_MMC1;
+	}
+
+	return bootmode;
+}
+
+u32 get_boot_device(void)
+{
+	u32 wkup_devstat = readl(CTRLMMR_WKUP_DEVSTAT);
+	u32 main_devstat;
+	u32 bootindex = *(u32 *)(CONFIG_SYS_K3_BOOT_PARAM_TABLE_INDEX);
+
+	if (wkup_devstat & WKUP_DEVSTAT_MCU_ONLY_MASK) {
+		printf("ERROR: MCU only boot is not yet supported\n");
+		return BOOT_DEVICE_RAM;
+	}
+
+	/* MAIN CTRL MMR can only be read if MCU ONLY is 0 */
+	main_devstat = readl(CTRLMMR_MAIN_DEVSTAT);
+
+	if (bootindex == K3_PRIMARY_BOOTMODE)
+		return __get_primary_bootmedia(main_devstat, wkup_devstat);
+	else
+		return __get_backup_bootmedia(main_devstat);
+}
diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/j721e/j721e_init.c
index f9af0288cf668a139947e228b93d38fefbbbfceb..a9224045b9f5cb25d288e631a6d971bf95634b6f 100644
--- a/arch/arm/mach-k3/j721e/j721e_init.c
+++ b/arch/arm/mach-k3/j721e/j721e_init.c
@@ -438,59 +438,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 	}
 }
 
-static u32 __get_backup_bootmedia(u32 main_devstat)
-{
-	u32 bkup_boot = (main_devstat & MAIN_DEVSTAT_BKUP_BOOTMODE_MASK) >>
-			MAIN_DEVSTAT_BKUP_BOOTMODE_SHIFT;
-
-	switch (bkup_boot) {
-	case BACKUP_BOOT_DEVICE_USB:
-		return BOOT_DEVICE_DFU;
-	case BACKUP_BOOT_DEVICE_UART:
-		return BOOT_DEVICE_UART;
-	case BACKUP_BOOT_DEVICE_ETHERNET:
-		return BOOT_DEVICE_ETHERNET;
-	case BACKUP_BOOT_DEVICE_MMC2:
-	{
-		u32 port = (main_devstat & MAIN_DEVSTAT_BKUP_MMC_PORT_MASK) >>
-			    MAIN_DEVSTAT_BKUP_MMC_PORT_SHIFT;
-		if (port == 0x0)
-			return BOOT_DEVICE_MMC1;
-		return BOOT_DEVICE_MMC2;
-	}
-	case BACKUP_BOOT_DEVICE_SPI:
-		return BOOT_DEVICE_SPI;
-	case BACKUP_BOOT_DEVICE_I2C:
-		return BOOT_DEVICE_I2C;
-	}
-
-	return BOOT_DEVICE_RAM;
-}
-
-static u32 __get_primary_bootmedia(u32 main_devstat, u32 wkup_devstat)
-{
-
-	u32 bootmode = (wkup_devstat & WKUP_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
-			WKUP_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
-
-	bootmode |= (main_devstat & MAIN_DEVSTAT_BOOT_MODE_B_MASK) <<
-			BOOT_MODE_B_SHIFT;
-
-	if (bootmode == BOOT_DEVICE_OSPI || bootmode == BOOT_DEVICE_QSPI ||
-	    bootmode == BOOT_DEVICE_XSPI)
-		bootmode = BOOT_DEVICE_SPI;
-
-	if (bootmode == BOOT_DEVICE_MMC2) {
-		u32 port = (main_devstat &
-			    MAIN_DEVSTAT_PRIM_BOOTMODE_MMC_PORT_MASK) >>
-			   MAIN_DEVSTAT_PRIM_BOOTMODE_PORT_SHIFT;
-		if (port == 0x0)
-			bootmode = BOOT_DEVICE_MMC1;
-	}
-
-	return bootmode;
-}
-
 u32 spl_spi_boot_bus(void)
 {
 	u32 wkup_devstat = readl(CTRLMMR_WKUP_DEVSTAT);
@@ -504,19 +451,5 @@ u32 spl_spi_boot_bus(void)
 
 u32 spl_boot_device(void)
 {
-	u32 wkup_devstat = readl(CTRLMMR_WKUP_DEVSTAT);
-	u32 main_devstat;
-
-	if (wkup_devstat & WKUP_DEVSTAT_MCU_ONLY_MASK) {
-		printf("ERROR: MCU only boot is not yet supported\n");
-		return BOOT_DEVICE_RAM;
-	}
-
-	/* MAIN CTRL MMR can only be read if MCU ONLY is 0 */
-	main_devstat = readl(CTRLMMR_MAIN_DEVSTAT);
-
-	if (bootindex == K3_PRIMARY_BOOTMODE)
-		return __get_primary_bootmedia(main_devstat, wkup_devstat);
-	else
-		return __get_backup_bootmedia(main_devstat);
+	return get_boot_device();
 }

---
base-commit: 5a92645e1f9020d24d19e03fff2ae63f30080770
change-id: 20260813-up-j721e-get-boot-device-71d9193151ae

Best regards,
-- 
Patryk Biel <pbiel7@gmail.com>


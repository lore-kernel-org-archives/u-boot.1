Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7462EC282EC
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 01:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5411482102;
	Sat, 15 Mar 2025 02:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gr30n+lm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 356D9820FE; Sat, 15 Mar 2025 02:28:56 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13E0982105
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 02:28:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-47691d82bfbso15655891cf.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 18:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742002133; x=1742606933; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=o86Lo1mk4Qb2SWgD+xZeXTP5CvEgqIX0daLHKxjnlM4=;
 b=gr30n+lm5EcARfq7SvPgEX63JEfSjLJposQ/xt1qzaDiilwCWqWeVL9VclDelgLYHd
 2VvuXPlTEBrXGFkAqG/KEu2gTWMQz0IufHGxlt0dHpUzFcmEHWBMqJsUicJ1q/XOQqP2
 yagyEKNl8xejXnwM9WZR+nowgMMiOxpmO1St8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742002133; x=1742606933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o86Lo1mk4Qb2SWgD+xZeXTP5CvEgqIX0daLHKxjnlM4=;
 b=KltT3/qfthl2YbpRMdlo0ah/c5hhdwsbZ1CTzQPrWvPlSfaPj8dwxXtylgzFWRuL/Z
 2fzRS+/F6i9v5FIaJ0TOGVCZD6zKgUqS7BO+zy5LasI3laR7xCPCBxWabqpR4AQ6JjVo
 /YTL5KiTmdjT/ccBN9KlaMGWYdPOaDldenJARZ4bZcPbu6J4LvpQr0eYpedGHwW4iOSQ
 VnJ6mAYRt1vAGBzk65K/MD7+46/pYu4lOEOM7Zhek/PkP5wAbuIy9iqktv/eaF94i2Lu
 BcWqO9NcPrcP+PpkV+0kyX434O43twWbhVrfQbKyQHpR6mUO5Pjgu9zbwvSIUa/vKlpG
 P4sA==
X-Gm-Message-State: AOJu0Yxj0SfkRR6Tiv0mOOjR8o5XQq0IeuuRQO8OEBMhZZWd4R/3n/qA
 LKERk2zT0fs96J5AhP4dKZ+wDNJLGxxH7TIeq6PKAFoZLpTWswRkrmuTvsLyO8oxuSN92YhdbLs
 /
X-Gm-Gg: ASbGncsRJtje0xoeHdn6keW71JeLuU607tQ5FUrCVwwecx7zyNUbGalLa5FMCdshSTs
 QNW1pRlURH3X5OBVdC9MhTZAgn6/DZGy3dAqpXBSQUqBQ2eh8TszY0f/knOWKxFnsVm85Z4I+2o
 g1Yn4HEp62wYObjHLyEmNv/GJxbbKBUBVo7XWSjvbPDizT1wzCJIGxCBZqEyYoxS1KfLY4hlgHV
 LR1MucRE6p7JlpIslnL/BOFuWRF+4YbyVlsZD3COdZHbCZ0W+Z80gWol7N79Tl9r7Wb78ks59Qd
 0ArSUUSdKfAEjOFcesoytx1kzIrwuF0LdcZZS+rgvcJnabDpAWuafYB0d1E=
X-Google-Smtp-Source: AGHT+IFBoA0+qn+w2RvyhUeUT9tgvG8dGPRrzq2rcTuPw1o+18QX2G4laN0AsCbUWkmmcidiw1iczw==
X-Received: by 2002:ac8:7d44:0:b0:476:7cc2:3f57 with SMTP id
 d75a77b69052e-476c8124545mr64155641cf.10.1742002132993; 
 Fri, 14 Mar 2025 18:28:52 -0700 (PDT)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb63cb11sm29321991cf.22.2025.03.14.18.28.51
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 18:28:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Kconfig: Do not "select OF_SEPARATE"
Date: Fri, 14 Mar 2025 19:28:49 -0600
Message-ID: <20250315012849.399336-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As the code is today, we get a warning about "select" statements on
"choice" options not doing anything. In the case of OF_SEPARATE this is
the default so we do not need to do anything here normally to enforce
this.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/Kconfig                  | 3 ---
 arch/arm/mach-nexell/Kconfig      | 1 -
 board/emulation/qemu-sbsa/Kconfig | 1 -
 3 files changed, 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 071fbf1fb202..447f7992fa53 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -648,7 +648,6 @@ config ARCH_MVEBU
 	select SPL_TIMER if SPL
 	select TIMER if !ARM64
 	select OF_CONTROL
-	select OF_SEPARATE
 	select SPI
 	imply CMD_DM
 
@@ -1110,7 +1109,6 @@ config ARCH_SNAPDRAGON
 	select GPIO_EXTRA_HEADER
 	select MSM_SMEM
 	select OF_CONTROL
-	select OF_SEPARATE
 	select SMEM
 	select SPMI
 	select BOARD_LATE_INIT
@@ -1183,7 +1181,6 @@ config ARCH_SUNXI
 	select DM_SERIAL
 	select OF_BOARD_SETUP
 	select OF_CONTROL
-	select OF_SEPARATE
 	select PINCTRL
 	select SPECIFY_CONSOLE_INDEX
 	select SPL_SEPARATE_BSS if SPL
diff --git a/arch/arm/mach-nexell/Kconfig b/arch/arm/mach-nexell/Kconfig
index 16324e15206f..b43dd5a5c258 100644
--- a/arch/arm/mach-nexell/Kconfig
+++ b/arch/arm/mach-nexell/Kconfig
@@ -4,7 +4,6 @@ config ARCH_S5P4418
 	bool "Nexell S5P4418 SoC"
 	select CPU_V7A
 	select OF_CONTROL
-	select OF_SEPARATE
 	select NX_GPIO
 	select DM_SERIAL
 	select PL01X_SERIAL
diff --git a/board/emulation/qemu-sbsa/Kconfig b/board/emulation/qemu-sbsa/Kconfig
index 728cecae6b3c..9ea6303ec9ca 100644
--- a/board/emulation/qemu-sbsa/Kconfig
+++ b/board/emulation/qemu-sbsa/Kconfig
@@ -30,7 +30,6 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	select HAS_ROM
 	select MTD
 	select OF_LIBFDT_OVERLAY
-	select OF_SEPARATE
 	select PCI
 	select PCIE_ECAM_GENERIC
 	select SYS_PCI_64BIT
-- 
2.43.0


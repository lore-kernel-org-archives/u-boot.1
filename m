Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC352C282EC
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 01:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD28382132;
	Sat, 15 Mar 2025 02:29:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="meeRkRKl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B119820F5; Sat, 15 Mar 2025 02:29:15 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3066D8210A
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 02:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6dd420f82e2so37131876d6.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 18:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742002148; x=1742606948; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iMJuvP54afgNJ5Dt7BIupUEMXLuX/uciHXcTG+qmiy8=;
 b=meeRkRKlKPj3ch1ILR8fy4Pq1G3zu8ecuUn9pZUaX395NeKCpqpXcKY27U74SCZaFj
 KrC0JhPBo+nRNI4+NesnbD+bYGAtry+/QT/GBClHnp4xwvURZUricXb4Xy5sqXLBgr95
 X2N6EjeJoVEcaED0qUD3dopJ4tLp3pAGPzTSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742002148; x=1742606948;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iMJuvP54afgNJ5Dt7BIupUEMXLuX/uciHXcTG+qmiy8=;
 b=VBZ2yWO52SzVjtqGiKH+1QS+7SncIxN0FgDExcoWFV4rGQQVQhANbOJL0GFe+q4Rla
 z7E6vOhl8fJ9tVRf2JViNRUjhsfyuiTVYEPJfYLyIjQmCdu1k3OmWTZwdpCqq2MXSVFA
 Hp6YxjpW6X3ZypAYNz387IeTr83JJeZNnIa2YzzUxRhGvU/lyJFRSakyfxDIC5nifSyE
 grThuV0Xp/Wfe5B5cta22pFCP2It9oEOcCZBejoZbihTT3C5snlY/w9jVkOZt7MFJSZ0
 GycvZzF7lh5/amaT/DvMW+pSwknMa61zsQyUUXFqVDlCJdOKbwnCw8XPPNdfZBLI+q0i
 xS5Q==
X-Gm-Message-State: AOJu0YzLuugfKqMF9RFZ6E2cMElAY85H1Fp2ZdhL7BMk6kZvtQS4EljZ
 pZKnGwU7n3KJai+/IK1ggf7YvA5k5rNnJcFg6cAHBRijaiGFWWSvE28r3ID1tH14UzgQNkj89YG
 y
X-Gm-Gg: ASbGncsD4ELIRP9xW88EoFZ1sbon+XtNYd1LMMS/Ydod5SMQ/tt1PFju5EkPCpc4F1N
 /HQCKwVZ8zVcqeUMy2t58QNYTAmW7dZZGFycLGvptnEx3svMqWr1ZXTQkSYYh4aN2u5uOvRxGNT
 M0p60/y1g/4BWOm0mSoEoIE6VsVEg7L8SAhgGEFmVYHMO3MITjFo+LEiUbOkQt+Aikx+gZkkUla
 s+SdtCLRP55MR8EiLbAt7vWWEV1KsPawf6qN+IjLKnbasRjX5p6a+CZ/0Iw+N5cAD8mox1ANfe5
 L7f5zTo8/mbpdtMiv+5es6RS7ik1FSlyvrn5GPIR9Akei4EB
X-Google-Smtp-Source: AGHT+IEkHgot7g6k/FXwuesF2VbR5F53De2HpHt45LzE6ubOlXl39/HmW6x3KqQ61NhLjRnuQWOF1w==
X-Received: by 2002:a05:6214:d88:b0:6d8:9062:6616 with SMTP id
 6a1803df08f44-6eaf674d16amr14635806d6.7.1742002148333; 
 Fri, 14 Mar 2025 18:29:08 -0700 (PDT)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade209a06sm30458436d6.4.2025.03.14.18.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 18:29:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Chris Packham <judge.packham@gmail.com>
Subject: [PATCH] ARM: mvebu: Correct SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR usage
Date: Fri, 14 Mar 2025 19:29:05 -0600
Message-ID: <20250315012905.399405-1-trini@konsulko.com>
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

As the code is today, we get a warning about "select" statements on
"choice" options not doing anything. However, it also works as intended
because SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is the default option
within that choice statement. To guard against future regressions, make
the choice statement in common/spl/Kconfig have an explicit default if
MVEBU_SPL_BOOT_DEVICE_MMC.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stefan Roese <sr@denx.de>
Cc: "Marek Behún" <kabel@kernel.org>
Cc: Chris Packham <judge.packham@gmail.com>
---
 arch/arm/mach-mvebu/Kconfig | 1 -
 common/spl/Kconfig          | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index adb816982f87..c4be5d6e93e0 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -394,7 +394,6 @@ config MVEBU_SPL_BOOT_DEVICE_MMC
 	imply SPL_LIBDISK_SUPPORT
 	imply SPL_MMC
 	select SUPPORT_EMMC_BOOT if SPL_MMC
-	select SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR if SPL_MMC
 	select SPL_BOOTROM_SUPPORT
 
 config MVEBU_SPL_BOOT_DEVICE_SATA
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 97f542fcc8a5..c4715de0a582 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -538,6 +538,7 @@ if SPL_SYS_MMCSD_RAW_MODE
 
 choice
 	prompt "Method for locating next phase of boot (e.g. U-Boot)"
+	default SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR if MVEBU_SPL_BOOT_DEVICE_MMC
 
 config SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
 	bool "MMC raw mode: by sector"
-- 
2.43.0


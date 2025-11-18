Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A10CCD19A
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 06:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB44483C96;
	Tue, 18 Nov 2025 07:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B8rncRQp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA4C83C65; Tue, 18 Nov 2025 07:40:43 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CDF483C65
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 07:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-78802ac22abso50044487b3.3
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 22:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763448040; x=1764052840; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+95E36MhdVPRUqMxz3267fMa8ZrtEFnTD7qHSXOqqD8=;
 b=B8rncRQp4NiXNv6ZhgybyrtBiljLvycT0os2mUQXAvcdlBFuuGOg8qEm/sd09r3Lm/
 Te7eWReoIF+dDgbHVTdkYfduxEVl3WHC26ztcVtpBVS6pXmDyFInuuuNxbsb9iilqex0
 HvRqC85/ah3nxYDy0vf2DfplLq8arqJfnMtE8O/GyK+OLzTEtJ7N4XbXKogo2HktzNXI
 TD5P2Uu1c5M3pSPQlsPWCbVjf2PolO6R0ygSoYcDgGgh91JUV6jcXcQzwHmMdzyM0XVB
 if7DURC85tZMnIYccyyzBgrG/IG+sQUNVqlC2cJAGwhAFJuVrKq0vzQUuqhej3a/uqjv
 tYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763448040; x=1764052840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+95E36MhdVPRUqMxz3267fMa8ZrtEFnTD7qHSXOqqD8=;
 b=N3nkY9XH7EkuIsogYqc/e+MyPU6Uew9t2b/Urm7DNQw8b7RJkitnFx9G8g9bTu2cG5
 thx9LapkLjQCBeYtCXH/d4LVxYjsnkt6oGGlPuo09tFPdPfWw54TTgI9AbXLYmlifENm
 aEnqZ+tTIif2BUqH02Qw1jYeIXvvuehkqxl2HuuGFbTHxv9WRx6MwHHTVnr7qPssfdMD
 y/h0koHICTCoWs8CGvBoaZmgLcXp6pLe/zWC/wpKO+iH0t/MKdud3KqAPokfzHUrSQug
 TDce3fFBILOv5sIxnE6j3tohW2Brb8mnEfsGRhVBG6qyNuHUSYCgRYfrCwHzPIG2iijy
 rX3A==
X-Gm-Message-State: AOJu0YwhOq5Fq1DCAGhJGkEbv2qniij0gCKjqbJJdb+TtPQuSqnjV3ap
 ESbCf0f+Oju3zjVRoHvxLyqgX2eGMoFZ6OXnp5apEr3PVlufTgruG5i8Te8K
X-Gm-Gg: ASbGncs6yCGyYqIbsLu02C9YVRSS46DLl7Eg7P21S/rgP40WpuVAD/x0DdadnyfJWsX
 p2kYiIsj4aALZbf+AHqGqO2IqqOWNkw9WLVe9ZAySSABZbGKxRDyYwEwNTtr4MzXpR379o7Gdn7
 pk7ZBgL2SuBRYHAn69GYo9by0ynbGEgh05N8stIQPNazxMQFQjknp1tUGToCKCdFRXkAHt4HedK
 uwQfpUYUd3xRBwdXC2nsh7As0cFIhppoxYauTxy+lepBjnfeUTPF3gzUP2vaAqv5UrKy2lLtUjc
 ktdsv0EjwFfdwkXPnrtw3zcy+Zf0tsW4S66vEfXp4hVJAv/CBudl1kundcAJMxORhUNLhCCiKur
 39blh6+swwAjaOZy4mCerxsPoqfh79soGMrXVwdKQjD0doVnC4pnQbVqMSagoaNBmCeKq2+Cnzt
 wnceSvtXsMA4uE+xA=
X-Google-Smtp-Source: AGHT+IHGJV3KTDb31G0r8A6CxeFExGFxU6D+e6aV23DAcY1nDWwu8SGggWbBSVJPjc/SGTkJ+tb+tQ==
X-Received: by 2002:a05:690c:4b13:b0:786:506c:3cc0 with SMTP id
 00721157ae682-78929e5966fmr126713107b3.29.1763448039985; 
 Mon, 17 Nov 2025 22:40:39 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78822128160sm49781967b3.32.2025.11.17.22.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 22:40:39 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Philip Molloy <Philip.Molloy@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Philip Molloy <philip.molloy@analog.com>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH 02/12] mach-sc5xx: Rename SC_BOOT_MODE
Date: Tue, 18 Nov 2025 01:39:35 -0500
Message-ID: <20251118064000.14613-3-malysagreg@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251118064000.14613-1-malysagreg@gmail.com>
References: <20251118064000.14613-1-malysagreg@gmail.com>
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

The symbol SC_BOOT_MODE was named incorrectly and inconsistently with
its usage. The selected boot mode is set only by hardware and cannot be
adjusted through software (apart from the use of FORCE_BMODE to instruct
the boot rom to ignore the hardware setting when loading uboot proper,
but this cannot change how SPL is loaded).

This symbol actually controlled the BCODE (easily confused with BMODE,
shorthand for boot mode), so this renames it to SC_BCODE and updates the
help text to reflect its actual usage: the BCODE is an SoC- and boot
mode-specific setting that affects how the boot rom configures QSPI or
OSPI in order to read an LDR file from the associated peripheral.

Reported-by: Philip Molloy <Philip.Molloy@analog.com>
Signed-off-by: Greg Malysa <malysagreg@gmail.com>

---

Changes in v2:
- New

 arch/arm/mach-sc5xx/Kconfig   | 14 ++++++++------
 arch/arm/mach-sc5xx/config.mk |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index 70c7e5e0631..170177f4e10 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -153,14 +153,16 @@ config ADI_IMAGE
 	  The image built by the ADI ADSP Linux build system.
 	  Is one of tiny, minimal, full.
 
-config SC_BOOT_MODE
-	int "SC5XX boot mode select"
+config SC_BCODE
+	int "SC5XX SPI BCODE select"
 	default 1
-	range 0 7
+	range 0 15
 	help
-	  Mode 0: do nothing, just idle
-	  Mode 1: boot ldr out of serial flash
-	  Mode 7: boot ldr over uart
+	  This sets the BCODE option for the generated LDR file. The BCODE
+	  is only used in SPI boots (QSPI/OSPI) but is set with no impact
+	  in other boot modes so that one LDR file may be reused from any
+	  boot media. The interpretation of this value is SoC and boot mode
+	  specific, so you must refer to the HRM to interpret it.
 
 config SC_BOOT_SPI_BUS
 	int "sc5xx spi boot bus"
diff --git a/arch/arm/mach-sc5xx/config.mk b/arch/arm/mach-sc5xx/config.mk
index 266d2e3a777..b4eb1c42810 100644
--- a/arch/arm/mach-sc5xx/config.mk
+++ b/arch/arm/mach-sc5xx/config.mk
@@ -14,5 +14,5 @@ endif
 
 INPUTS-y += u-boot.ldr
 
-LDR_FLAGS += --bcode=$(CONFIG_SC_BOOT_MODE)
+LDR_FLAGS += --bcode=$(CONFIG_SC_BCODE)
 LDR_FLAGS += --use-vmas
-- 
2.49.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03154D3E79D
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 08:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14D8D83C94;
	Thu, 11 Dec 2025 09:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eiaYxpWV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D703F83C7B; Thu, 11 Dec 2025 09:05:51 +0100 (CET)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FD8A83B48
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64476c85854so633312d50.0
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 00:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765440347; x=1766045147; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfUQhzCv25i6BceUHfSlRIYi9sz+xUxh6DispgmRo/s=;
 b=eiaYxpWVnxkQlcR2HrSML9HuAJbRuGqwdgXBdS0B/EBcgzgMx67RODVbSKZLPpocK6
 Z/E7DMC7k1UOt0i2lUTXT4a7IQwF1bwMvp0Oa2x/Hn0qUOLt0uHkNjoZ/M2glHHDeRtF
 koOEIi5gppiOt2y822aK+PncbPEH7O264aInvqN8Db1I5Ako8Gp32Q7hY9lmHcNQCyfI
 srnD+LkoTcFfbrPWFCoLnKqVZGMl+9K6pJKQsUOGmtt2iiEe/6eU1hSmQz+oO4YeKc6g
 dOFbuUdO0FbT3IBmBWy5lh5N/sXBJQ7hLSS5CO17HDn6J3ITE/gQS933L6nTu3Yy/2bs
 WCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765440347; x=1766045147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lfUQhzCv25i6BceUHfSlRIYi9sz+xUxh6DispgmRo/s=;
 b=HqjFNVJ/tCGUlnjBq5xhUf9CyrLxvDXrzAZJ9MTVerQterXVP9vjeTxwY8noWq8CYu
 M6xdBOobXiiXDTd614gPtPhhyyJlarCvW0VTjMTKrDIcFKTMRHg3uCRiEdbANrd5XDFE
 puP7+4ZkYCZnMgh2MXYDNpChkIFAvrVgC26VPTSkx8NiAi/AI0RhfxOD1WJOqjwcCk9G
 yRiSe4Ro+EhPes6wdUX9VrD884JS94oYgKEbPitppBe99lF4gWahpAMpTt2hbdUmWUb5
 Avp7BGcuR/WogW5RwI2zMYqthyNTqOAYtaJN8Mh/C+TBmmKutWLYSoKGWVzl6H9wp31M
 8O7g==
X-Gm-Message-State: AOJu0YzJ7S6T/AArUhrUhXKwQSTpAzg5VgZgODiy5Zgahr/ZUHNQMK/t
 aG/JTXI9ovv21rstBPLF6h96vJ3yZVCIuk8QwFOLTgoyg8qGHPABFet7CAya
X-Gm-Gg: AY/fxX5OB0GfuEYdSkGYeyDBNx1pywTj6ekVMIbnCh0Jxve6MJZwJBLE0j+vxMYoBDd
 b9SJqO74X5y72q4b8wOS4K1Yhupf39Aq5UutTXnTQaMJPn+HcfM6rh+bHVAOnGR7y6xNa3+8/kO
 PrwZ77+tRw/SX+AOwCVRIEdP2O/8Mbao+5TWNl7amSgrUQWBC2V81ZAREDotM/KtLjGpRKYjP9v
 GVD7p4p2c34HAu3li+B4Sf5cIltT82I4IsAtvgAZEHJAtAdOzGCW34oVGPhr5rf78LuCYbtHhpW
 GIOLEVGzzV/lqwz796lqJ4DiSogLC1pZmAkoUdoagwL9t7P2NVjTqbRHnYRSZWA+B23hyCXU8ns
 b2qg1QbtQXpxkMahpCRgY462w1Kia0tQ+4iDDbuuUap6Rm1VQL99BDe94+o/JhKcGteekSEDHfo
 mgHVlqOGGOYC06ZmMbl3DvrUyRYg==
X-Google-Smtp-Source: AGHT+IFkMiGcLKPw0osvwppY4SRMNZ2Rn1wU7v4GC1exiBZvUVZAzZeacSsFuzEsaBmmkH+D4jLIbA==
X-Received: by 2002:a05:690c:6102:b0:78e:1aa5:e97f with SMTP id
 00721157ae682-78e1aa5ec9bmr4729607b3.41.1765440346790; 
 Thu, 11 Dec 2025 00:05:46 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78d69d83a85sm7256657b3.28.2025.12.11.00.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 00:05:46 -0800 (PST)
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
Date: Thu, 11 Dec 2025 03:03:53 -0500
Message-ID: <20251211080414.5363-3-malysagreg@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251211080414.5363-1-malysagreg@gmail.com>
References: <20251211080414.5363-1-malysagreg@gmail.com>
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

(no changes since v2)

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


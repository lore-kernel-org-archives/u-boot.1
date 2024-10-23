Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF5FCF5386
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F7FB89341;
	Wed, 23 Oct 2024 15:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="F4Njzpbw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E50089379; Wed, 23 Oct 2024 15:29:42 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D96F28936A
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4314a26002bso75027905e9.0
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729690174; x=1730294974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r89WCchYnGI6BgzDG9MdlXzKq/Cdf2qHdtrU8P8PCTM=;
 b=F4Njzpbw9ecW+rO4b65qN402lgIPSj4C+fvkKJkSQxoJF5WVDd8CXeJjwkocsoB7jJ
 A+wYxO4A+KiJfPBUiUxp3BPHS6FACBHg4JdhrRi0QJibEE7M4fCetwyWuVt1jm0VqRTP
 3HV0Hlf/mtRifXBX8HJJ0epWUd3oCx0AS7D0DhizyA4gS3rS16IQkne0PhdYgW1GGRy/
 0rSuBD262JgHQ6pDKOOx8rs3Nj4pAYQBMx3+s0p8WnDAaF6oY0lChEmfJm+jr64EGVfA
 zqLpKNuFnquZqOfpR67pQATNkaA19tfokTQxAEic39OYWmQwXvXGcgSnnEpoOe3Tyiu5
 lXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729690174; x=1730294974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r89WCchYnGI6BgzDG9MdlXzKq/Cdf2qHdtrU8P8PCTM=;
 b=TLny1ZemAGwAt1JfGuoOkCM9kAzEDkcZ9nSHj3Xqqj7R/kL5ph6i2kCrHk8oDaAT9e
 2HR6okTTX1abZQCGHhix+Vbc936oCrMkOgr7CCYX9Or1Qts38Mm9v0RhGkeXiYPjJTJv
 87aUYdhb40bW566Zeaf3GaYtHgwgVkCUNmzKVN9XGzRKZ+pK4G5Q/BKtZlPuocta+kwv
 mcuphKsMW6MNS6oBE6biXH2y1FmfSQ9wFUrnx/5clUb03grN90V5tmK0FjkiGlA5UGNM
 F+XUe9rn6ufpA6xQi3Y6+TB5kaVqMcMCzwScY+nZv5YDxVViOzKWKZR/kT3lbsRr6sin
 HPYQ==
X-Gm-Message-State: AOJu0YwIujz+6wvHCzjKz/jYOmWSQe6n09dACLMraVuHe/d8ThZ5DCV1
 cdlrl4t41L6++PTCi/1MG+AMcpwT8qzhK3U1TedQ4HBY25AAtqtICgrT97tlWiPGOSSNcdpyXHo
 L
X-Google-Smtp-Source: AGHT+IECYuUZdNmXzx0bkc6neBGNcgB91+zLHUyKlu3H+ySqq+sSCnSAolphhWXf/MdkERBQgNcl9Q==
X-Received: by 2002:a05:600c:4ece:b0:431:5f1c:8362 with SMTP id
 5b1f17b1804b1-431841b914bmr17619915e9.35.1729690174270; 
 Wed, 23 Oct 2024 06:29:34 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:29:33 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 34/37] arm: mach-bcm283x: Enable ARMV8_MULTIENTRY
Date: Wed, 23 Oct 2024 15:20:17 +0200
Message-ID: <20241023132116.970117-35-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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

On FDT platforms the APs are brought out of reset using the spin-table
as defined in the DT. On ACPI enabled platforms there's no FDT, thus
enable the ARMV8_MULTIENTRY and BLOBLIST to use the ACPI parking
protocol instead.

TEST: - APs enter Linux when run on qemu-system-aarch64 -machine raspi4b
      -	APs on real hardware do not enter Linux, but continue spinning in
        their ACPI parking protocol spinloop. To be investigated.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-bcm283x/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-bcm283x/Kconfig b/arch/arm/mach-bcm283x/Kconfig
index 0ef8156c64..d9303e8c28 100644
--- a/arch/arm/mach-bcm283x/Kconfig
+++ b/arch/arm/mach-bcm283x/Kconfig
@@ -27,6 +27,10 @@ config BCM2837_64B
 	select DRIVER_GICV2
 	select ARM64
 	select CPU_ARMV8
+	select ARMV8_MULTIENTRY if GENERATE_ACPI_TABLE
+	select BLOBLIST if GENERATE_ACPI_TABLE
+	select BLOBLIST_ALLOC if GENERATE_ACPI_TABLE
+	select BLOBLIST_TABLES if GENERATE_ACPI_TABLE
 
 config BCM2711
 	bool "Broadcom BCM2711 SoC support"
@@ -47,6 +51,10 @@ config BCM2711_64B
 	select DRIVER_GICV2
 	select ARM64
 	select CPU_ARMV8
+	select ARMV8_MULTIENTRY if GENERATE_ACPI_TABLE
+	select BLOBLIST if GENERATE_ACPI_TABLE
+	select BLOBLIST_ALLOC if GENERATE_ACPI_TABLE
+	select BLOBLIST_TABLES if GENERATE_ACPI_TABLE
 
 menu "Broadcom BCM283X family"
 	depends on ARCH_BCM283X
@@ -213,6 +221,9 @@ config SYS_SOC
 config SYS_CONFIG_NAME
 	default "rpi"
 
+config BLOBLIST_SIZE_RELOC
+	default 0x20000
+
 source "board/raspberrypi/rpi/Kconfig"
 
 endmenu
-- 
2.46.2


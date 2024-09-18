Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D8FCDD540
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 15:28:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEB4288FC8;
	Wed, 18 Sep 2024 17:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Gr99tGSG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B555F88FC5; Wed, 18 Sep 2024 17:23:08 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D428288FCB
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 17:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a8b155b5e9eso973481766b.1
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 08:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726672985; x=1727277785; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R5uZgEJzyxq6TtRnJ+3B1re591kg/hzq4hJZEz4khow=;
 b=Gr99tGSGDlrxei9tmxJ74cH2M0PEzeQeJizsyi99x2jp1wOYoAs7ynXQqS0inpIcNf
 3GyqzW5nnZ/ewQ0OZxL1kkM8fuaHCA04g9PQPeqGtin5AkVwfSeYD/RQ+jQIls+y6mMn
 EAu5zCSjwDK+WGFHnvPNsyFZErPHbTa2E+znzabPjU6ANaydwLx2RCSx5FyVxO1AIqkC
 8pziqOGNmPrL/V9c01nJ45da1Omg6O8qAgpi46eNPNJB1QEe4IZ7aDOyK8xb/1STdriB
 CZRomveYmBl9uG+AlNRlKf+SUNHO4JTUt4TWPSViSD4ZrdkFg+mr3xRkMF6jqnp4Tp4a
 izDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726672985; x=1727277785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R5uZgEJzyxq6TtRnJ+3B1re591kg/hzq4hJZEz4khow=;
 b=SeyCdZR2Z40R/sRNN8hLBLI3ZzxTMjqOi4J8pLW0ByQeqhmZqsFniRKmhCRliZaSlJ
 DieH3qfCQH+C4YvWPOCmKwKJ0vocITgTAuJ/t7jz/09ULDPnhVK6Yr4GHmoEhotLo0L6
 skp/Pleu7lyPtkFq9NGFjeNLi7Qm2ssm5CdPtg+mFRlWYd27bTYsk9kGC0HQqMr8MHRf
 Sm2BvhjVnEK2//sox55bBmi02RoN8EunRbJhvihTYlPbGL2UeWiPR3G+5g80KbMZsaTU
 4p0bnyHoSuQjG2anl1CRYQoPNrqWuFleS1n1e+878qJT1DnYx3eadKCCph3JcKDiQWbZ
 ZBOw==
X-Gm-Message-State: AOJu0YxR3Z/ShSJZFQDK+hRyn25ABQt2FJ+E1Niwe7keupwgjRmySib9
 0HepwWQ82q8ecD3XQsjq3k5eJ8+S+4QBq8NC1IX38diAucg1Z9UcfIagYgfdJtHFWzvpG8uTQO8
 8
X-Google-Smtp-Source: AGHT+IFc1MVRFrvAs0456DPosFgMSiSB9IkC3mTAimcqBBxhviQw1MtWABv9N/oHURHNdpXtr736nA==
X-Received: by 2002:a17:907:72cb:b0:a8d:60e2:396b with SMTP id
 a640c23a62f3a-a9029678bf3mr2455188966b.65.1726672985219; 
 Wed, 18 Sep 2024 08:23:05 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 08:23:04 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 33/35] arm: mach-bcm283x: Enable ARMV8_MULTIENTRY
Date: Wed, 18 Sep 2024 17:20:37 +0200
Message-ID: <20240918152136.3395170-34-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
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
index fad900d965..b7f337ef49 100644
--- a/arch/arm/mach-bcm283x/Kconfig
+++ b/arch/arm/mach-bcm283x/Kconfig
@@ -28,6 +28,10 @@ config BCM2837_64B
 	select DRIVER_GICV2
 	select ARM64
 	select CPU_ARMV8
+	select ARMV8_MULTIENTRY if GENERATE_ACPI_TABLE
+	select BLOBLIST if GENERATE_ACPI_TABLE
+	select BLOBLIST_ALLOC if GENERATE_ACPI_TABLE
+	select BLOBLIST_TABLES if GENERATE_ACPI_TABLE
 
 config BCM2711
 	bool "Broadcom BCM2711 SoC support"
@@ -49,6 +53,10 @@ config BCM2711_64B
 	select DRIVER_GICV2
 	select ARM64
 	select CPU_ARMV8
+	select ARMV8_MULTIENTRY if GENERATE_ACPI_TABLE
+	select BLOBLIST if GENERATE_ACPI_TABLE
+	select BLOBLIST_ALLOC if GENERATE_ACPI_TABLE
+	select BLOBLIST_TABLES if GENERATE_ACPI_TABLE
 
 menu "Broadcom BCM283X family"
 	depends on ARCH_BCM283X
@@ -215,6 +223,9 @@ config SYS_SOC
 config SYS_CONFIG_NAME
 	default "rpi"
 
+config BLOBLIST_SIZE_RELOC
+	default 0x20000
+
 source "board/raspberrypi/rpi/Kconfig"
 
 endmenu
-- 
2.46.0


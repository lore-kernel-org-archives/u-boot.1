Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FEFC83F05
	for <u-boot@archiver.kernel.org>; Sun,  6 Jul 2025 03:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B32D82FAB;
	Sun,  6 Jul 2025 05:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VQkFHSsT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C6A782F00; Sat,  5 Jul 2025 22:57:24 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78864809A5
 for <u-boot@lists.denx.de>; Sat,  5 Jul 2025 22:57:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vtpieter@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ae0ccfd5ca5so294670466b.3
 for <u-boot@lists.denx.de>; Sat, 05 Jul 2025 13:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751749042; x=1752353842; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7pu7dQDhnR66mSGMBbS/PkOM6H+4Grd+LLO2nR6WjSw=;
 b=VQkFHSsTXFZ+afPiUCsn6EVjc72sGqCBT7Vej+0+Ol65OMhna0kLEHhesGLsuV1msm
 2TSlwqdjVcOv0hrVX86VS7NJNs/gWlmc9cwUY8b8LGGs3ySXZmapO1wya9uJXkMeFWQD
 AIkunkIPpRmwo2Hff7p62L7mOaQk52gcW8FVFwPL1lgo0njpFvD/mT0n5+qzhbS7/DCy
 rrJdrrUhG6G+ujkuectlk+1bzL4Fn6RbXFZvhBDKJA4O9zDqixbdWuB4GC7O3+PrjmGk
 6SUMCHdi0yVgXSVwPnhcybVNMF9MWarA4DroWf0JRvJdwRm6NsM1asIEwxio38Sp+1iq
 mr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751749042; x=1752353842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7pu7dQDhnR66mSGMBbS/PkOM6H+4Grd+LLO2nR6WjSw=;
 b=kndzrCIK80wU9iq10BDTEaRGroceOd1qmxoKcjkfeW9PiRPJrqywrzhHFeBbCXOMV+
 4PX9xEhed+QgtFA8B7rPd1OEnHath7KgvKfW01s128WkBlAKEgFBqVGPkz15EGbMkcgR
 Ww63tqq8K4y5In2Jr1+SqDkGvINyhziwbXcfVjWHQIewx6lfi/2sJkR9Coqlr80WNLfB
 cEHGzjJ9xDmr8jQ7SRd531LWxlokt7E5bCvQ5uv0GOCO102TGBLBfSGZLq+qq8HTgQBc
 a5sLyA6Y79+ZTvveHKXj/Lr6u2wpSX2Ba9qN38/dYF1d6fyYftRwDx6d+G4QKmAwO8g3
 NaCw==
X-Gm-Message-State: AOJu0Yyh35PRRXFs4s76h+LXUUwGmBfduyc1b7Xu1BiBFlABEt43lHo7
 xhNSRDwOsxruZW8jcgdSF+vn76Lh0LM+zaPYARXOcZ/uNEqvIHl0aHm9/+adgRguwEM=
X-Gm-Gg: ASbGncv9npS6a1trjYV3v9OPGm+TMKbCrxwdVCKEZ4DCcD67c4u0Y0cMiUjVwJ16G81
 1KxuiO4PZp8RF8/dXpOus7mRoACcG0GnTH8ePg19DPVJRPT6zibWkUhX3hSab0XtP1NC/Zv068B
 yyj3j9MluAGfYbZsEB5QMY5Cwmwv9qj8GKtKUNvLykcRatgZmUmSsS6d33v/WqwQqFzbgQE71TR
 eZDxEEJndxCLmDNIoI+VZEAE0sMlg7czB6cf3152qM66fKKHBl/e7Jk7LlT6Fmu9102OwRzjHoz
 S68M+lSmqFsQYsiJIzIH/xEWr5B0lF1oZTMxErHTFqRCu59piIG6ISix0vkoK2ZTT6utH5YeHtM
 =
X-Google-Smtp-Source: AGHT+IF+xwVdKNWGTDPRkVSdkfdREUQJKbOjZgR8XRJsvSBOp5ECQCw82ZPHAEsgixBMUNRG4q6csw==
X-Received: by 2002:a17:907:96a7:b0:adb:1eee:a083 with SMTP id
 a640c23a62f3a-ae3fe7f78eamr599028066b.47.1751749041522; 
 Sat, 05 Jul 2025 13:57:21 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.cern.ch. [2001:1458:202:99::100:4b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f66e6f51sm399423666b.8.2025.07.05.13.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Jul 2025 13:57:21 -0700 (PDT)
From: vtpieter@gmail.com
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH v4 2/5] drivers: fpga/firmware: add Kconfig dependencies
Date: Sat,  5 Jul 2025 22:57:03 +0200
Message-ID: <20250705205710.792370-3-vtpieter@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250705205710.792370-1-vtpieter@gmail.com>
References: <20250705205710.792370-1-vtpieter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 06 Jul 2025 05:50:01 +0200
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

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

FPGA_SOCFPGA requires ARCH_SOCFPGA cause socfpga.c contains
arch/arm/mach-socfpga/* include macros.

ZYNQMP_FIRMWARE requires ARCH_ZYNQMP cause firmware-zynqmp.c contains
arch/arm/mach-zynqmp/* include macros.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 drivers/firmware/Kconfig | 1 +
 drivers/fpga/Kconfig     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 8789b1ea141..f3302d34354 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -29,6 +29,7 @@ config TI_SCI_PROTOCOL
 
 config ZYNQMP_FIRMWARE
 	bool "ZynqMP Firmware interface"
+	depends on ARCH_ZYNQMP
 	select FIRMWARE
 	help
 	  Firmware interface driver is used by different
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 62cb77b098c..9456ca3149a 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -15,6 +15,7 @@ config FPGA_ALTERA
 
 config FPGA_SOCFPGA
 	bool "Enable Gen5 and Arria10 common FPGA drivers"
+	depends on ARCH_SOCFPGA
 	select FPGA_ALTERA
 	help
 	  Say Y here to enable the Gen5 and Arria10 common FPGA driver
-- 
2.48.1


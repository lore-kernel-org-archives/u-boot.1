Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFF6C83F34
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 01:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2A8183577;
	Fri, 18 Jul 2025 03:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t2Fzk4Ud";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B74408357D; Fri, 18 Jul 2025 03:15:31 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 986B883560
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 03:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-73e64e87d49so963216a34.2
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 18:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752801328; x=1753406128; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fn6jSzvvR8D3vPenBKYku92iMDybh/meC2QKmuXitVk=;
 b=t2Fzk4UdkKDla3efhCNhWkXZHNCuzYXtVTjq9b6EUkqEL7xOLJM4QyDCYHmAUcRs6/
 K0JgQBVPvbui7rinp1GkgtXIyTvrO/MXZMMsw5WdvoNzjEuUFyMXCFocBfxYwTwjSsEP
 nqCPThyihviLddAQHCM9nNtlwD7GrtVCr8UF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752801328; x=1753406128;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fn6jSzvvR8D3vPenBKYku92iMDybh/meC2QKmuXitVk=;
 b=wfk7yLRAKcHhuX46T/rybvujnafhabdoDYjT/q4Sepul3CHDd04tbgw2Kll5Dxypr6
 r3INjc+qeOj4w6j+2/2YwgOhSJOYtL86LISPUNuvsd/wwUeZuoFkr/aoaoGNa+CvIMBt
 XNbpI5hMWpMDr79ILWfXYu4cbI+P/Ky0r/bPl2142+J+QUnjTBYenQB3gP+1rjgJk8Ge
 0RCi3CcrUUTtn6B3p/R48bySoL8dl4nXZZ6CSptOWvczg1aIBLRRcL1211OdFWIejClk
 US6DEEvVe3M4do6Gt4TW0TvDJr2PWb6FFju7mNV3qIbUEdBigKolExArVjYTNOzIPz/B
 Tu4A==
X-Gm-Message-State: AOJu0YzRkjoczFK8q0KJ/VdxJPRPl7QBD71ZhgM7mbeCIEtIBPUnUEjd
 0qFkOoQPNi/nA+g67MjxBgsi2MuJOobAdpe1LIBiGZqahUQczeWf0KdLTzJevSd1m1WRtRGXOf6
 jwgequ+g=
X-Gm-Gg: ASbGnctkCQowOm+42Lhzao8hvuOllZuYr9VLjO16YZb3e9cHToXdRIqYlQwOKTSjrqU
 zKSg8Qx5aN8enC5n+t4VQZLIvd7KEjQIAF0On1FtFWn5MC0/Y4T2bdU8g6q91/2by40qh6/lD9a
 F1aW63avJBcaGle9LeJbHq/Y0Av19CLPXCUFuePjXyuGH4Xg401CD8OArmJ/i1yJ8aXCclzA4qx
 WGTYiZHttrXd0tOT7E4VuXQJTXulnHbzzNviTWEkegUX7oQf74+ui4Y1B/BM8b/pWTOh10vqoju
 kB5aqiDGVXrzydybdA/yjRoRXtbHB6/0Caz9/rw7gTcsnGH8iDlK+MmmXkXOMf8Yop9+QNCZtec
 M7Vy0fBUZeWrwQBqujAssxwEzZoafvzNExUbsjb28wX/iX/f0s+8ExihdkIQ=
X-Google-Smtp-Source: AGHT+IEJuijJ3u8in3FFhqXdOEiBI7SSSZ086zHDmwlWF30B37O75+DLasb8FeGUWkuZmPnuwehN5w==
X-Received: by 2002:a9d:3e55:0:b0:735:b9db:5939 with SMTP id
 46e09a7af769-73e6619e35dmr6229744a34.10.1752801328174; 
 Thu, 17 Jul 2025 18:15:28 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83be2689sm215773a34.63.2025.07.17.18.15.27
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 18:15:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] pci: Tighten some PCI controller dependencies
Date: Thu, 17 Jul 2025 19:15:26 -0600
Message-ID: <20250718011526.1333863-1-trini@konsulko.com>
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

A large number of PCI controllers cannot build without access to some
platform specific header files. Express those requirements in Kconfig as
well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/pci/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 8ffd88c722d9..b8568267ff8a 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -183,6 +183,7 @@ config SYS_FSL_PCI_VER_3_X
 config PCIE_FSL
 	bool "FSL PowerPC PCIe support"
 	select SYS_FSL_PCI_VER_3_X if ARCH_T2080 || ARCH_T4240
+	depends on PPC
 	help
 	  Say Y here if you want to enable PCIe controller support on FSL
 	  PowerPC MPC85xx, MPC86xx, B series, P series and T series SoCs.
@@ -190,6 +191,7 @@ config PCIE_FSL
 
 config PCI_MPC85XX
 	bool "MPC85XX PowerPC PCI support"
+	depends on MPC85xx
 	help
 	  Say Y here if you want to enable PCI controller support on FSL
 	  PowerPC MPC85xx SoC.
@@ -265,6 +267,7 @@ config PCIE_LAYERSCAPE
 
 config PCIE_LAYERSCAPE_RC
 	bool "Layerscape PCIe Root Complex mode support"
+	depends on ARM
 	select PCIE_LAYERSCAPE
 	help
 	  Enable Layerscape PCIe Root Complex mode driver support. The Layerscape
@@ -286,6 +289,7 @@ config PCI_IOMMU_EXTRA_MAPPINGS
 
 config PCIE_LAYERSCAPE_EP
 	bool "Layerscape PCIe Endpoint mode support"
+	depends on ARM
 	select PCIE_LAYERSCAPE
 	select PCI_ENDPOINT
 	help
@@ -296,6 +300,7 @@ config PCIE_LAYERSCAPE_EP
 
 config PCIE_LAYERSCAPE_GEN4
 	bool "Layerscape Gen4 PCIe support"
+	depends on ARM
 	help
 	  Support PCIe Gen4 on NXP Layerscape SoCs, which may have one or
 	  several PCIe controllers. The PCIe controller can work in RC or
-- 
2.43.0


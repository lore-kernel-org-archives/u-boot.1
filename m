Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C04C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 542F484285;
	Wed,  6 Aug 2025 16:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UMA56Jb8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A54BF83A71; Wed,  6 Aug 2025 16:56:17 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65D2183A9F
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-30babf43ddaso8840fac.3
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 07:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754492169; x=1755096969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HewG/pv+UduyB9oKR/041t32m0BxN+FHNYuWozPumSI=;
 b=UMA56Jb8YO859I80MXvaTeJ8deCXEMLS8D3ZL1TFQj7oyuMJco39Ce7wGXk3rhiy0U
 rfF+vzje74n/PWYiavgWVJfTpe8SnpQEKkz141MUDz9wSl9yNo0bfZEZafDeS1WfJbLE
 NPKixqQVKS7YK0VEWbQewCtGAgIymTNMwsVWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754492169; x=1755096969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HewG/pv+UduyB9oKR/041t32m0BxN+FHNYuWozPumSI=;
 b=J0pxaKysVTNk2cYBGn/nwB4KlzjvS4TDOcSzqy6L9Bndgq2XRIc+HykLNf07jLHLSM
 J5mo9/Y6QCizxgvFaJ2JbPO9kUP2oSW4bj+3E7DBgc+pwjlOUFPUUn4lWKHfdUcEIBvI
 yY9d1/klJRXkHC7nlH4Vsz8If9YBbscaESBcCvNqToC1+Qm+QLvZi0gqe3+D0IL8/F3N
 4t0t1Mw38XhAqyO5Pkry/0c29A5WBHOOgXe0Hrw/SZI7Mesjqi2XvP+dtXjBYP8r8Gzo
 DbD7kbS6+Esh1ZcsDP/zmp1SAmU4tSfXmcg44Xd72uEJnvLiTJa1qDlIBkfMxJ9H0kiM
 iVig==
X-Gm-Message-State: AOJu0Yxek1JUn+G5gM3RTYlhlskAflCI4o/LXUmES1DyDu73+CEBVugv
 gkkaSiLwsf8gcbPHCRvVwrHMnlFulxD9HKvBXKPNKA1k2wgrTZNDJXKOVbEqOsxdqNi67tNy20r
 2uObqufM=
X-Gm-Gg: ASbGncvKbXVxZMe5RS9GzvcFSspgk0r/7YL5rRHX84NebKKm5laJ2XYuzYONWH85h47
 JXR9q2SNBxzXv+BXjlLcz7rWAS9A1/E7ESl1egH+pwB36b1Xm6E46NOiSgQnh7+N5lqTsvTdKPN
 bMzHgy8TAuNandmcn9lNUYEP8ZzydywLa3r7sYTkdy0o5fgH1sOEGNJoqBozfS/jr4LFoR/IkmP
 o9biilqclClJtkFWxi21zN5Pdbzc5aYCFjd8AXdP80QOP15WjMMh8MzmbTb4Yra0jLe9sRIRoEe
 7lKqmrbkBdCxIIs9laRqiZqiZYUs/GQeylZbGJVcpWPa8TPiadDUT8UAlPr/2dS6YSt+r4oL5r4
 Wg3tljI4E4qBZCy2i2QQQjxqFtP0Av52xpxeQGismf0gISZF1NGUm0Oc9TiIJp50IEBVQDg==
X-Google-Smtp-Source: AGHT+IGR1DtvqFwzji7C9b+TwgMEKkM0pAE1XDf8WOKdEp/U87c2P7TNj1mXm2F6Jb9ESuUaZVaIog==
X-Received: by 2002:a05:6870:c0ce:b0:2d6:af0:8d8e with SMTP id
 586e51a60fabf-30be28e2272mr1825685fac.2.1754492169073; 
 Wed, 06 Aug 2025 07:56:09 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30ba8228a79sm1925391fac.35.2025.08.06.07.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 07:56:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH 5/7] usb: host: Tighten USB host driver dependencies
Date: Wed,  6 Aug 2025 08:55:59 -0600
Message-ID: <20250806145601.1664563-5-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806145601.1664563-1-trini@konsulko.com>
References: <20250806145601.1664563-1-trini@konsulko.com>
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

A few of the USB host drivers cannot build without access to some
platform specific header files. Express those requirements in Kconfig as
well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marek.vasut@mailbox.org>
---
 drivers/usb/host/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 5c9e8fc9d15e..2cf687fc4f3b 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -121,8 +121,9 @@ config USB_XHCI_DRA7XX_INDEX
 
 config USB_XHCI_FSL
 	bool "Support for NXP Layerscape on-chip xHCI USB controller"
-	default y if ARCH_LS1021A || FSL_LSCH3 || FSL_LSCH2
+	depends on ARCH_LS1021A || FSL_LSCH3 || FSL_LSCH2
 	depends on !SPL_NO_USB
+	default y
 	help
 	  Enables support for the on-chip xHCI controller on NXP Layerscape SoCs.
 
@@ -286,7 +287,8 @@ config USB_EHCI_TEGRA
 
 config USB_EHCI_ZYNQ
 	bool "Support for Xilinx Zynq on-chip EHCI USB controller"
-	default y if ARCH_ZYNQ
+	depends on ARCH_ZYNQ
+	default y
 	select USB_EHCI_IS_TDI
 	---help---
 	  Enable support for Zynq on-chip EHCI USB controller
@@ -303,6 +305,7 @@ config EHCI_HCD_INIT_AFTER_RESET
 
 config USB_EHCI_FSL
 	bool  "Support for FSL on-chip EHCI USB controller"
+	depends on PPC
 	select EHCI_HCD_INIT_AFTER_RESET
 	select SYS_FSL_USB_INTERNAL_UTMI_PHY if MPC85xx && \
 		!(ARCH_B4860 || ARCH_B4420 || ARCH_P4080 || ARCH_P1020 || ARCH_P2020)
@@ -362,6 +365,7 @@ config USB_OHCI_GENERIC
 
 config USB_OHCI_DA8XX
 	bool "Support for da850 OHCI USB controller"
+	depends on ARCH_DAVINCI
 	help
 	  Enable support for the da850 USB controller.
 
-- 
2.43.0


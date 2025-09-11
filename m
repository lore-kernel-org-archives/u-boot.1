Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73E3CAC587
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 21:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 374FA83443;
	Thu, 11 Sep 2025 23:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hsQMDPUG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AA368341A; Thu, 11 Sep 2025 23:54:22 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D458833E9
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 23:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-88432e1af6dso92926839f.2
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 14:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757627659; x=1758232459; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j/VaY29KpxBJtm8NKvH39Z0g1/9dzDIczm6Jv6sQb0c=;
 b=hsQMDPUGBslt4AkWOe90RpEGxn4LRgGiGw49X612+DApKdIBAakNlbIDHtPDF6+x1f
 m6Pmmv1ldiepgbDshZV1YSTIhHkjLvn1+KElprNxewQRPpqVobI6VL+Fyic2kmTB4x94
 JAnWMYwKa+Is1U9SuU+tFZ2mwRL9Xa83ZDBys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757627659; x=1758232459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j/VaY29KpxBJtm8NKvH39Z0g1/9dzDIczm6Jv6sQb0c=;
 b=CzrsovDB2lZXqUvWgCq8F9x1gNqL4huvTdwQKSwetpx5akAWEgXUB6nsK80g52aVtL
 3T9O720DAb4Al1IgLk4nsoBLcXJ3zuOcPfpr36cqBvVkI+xF0qywR8MUvNftD/2wEHYV
 GtNQ/7f/QNzFehOnZJRR0InM+CYyuhxVXaRlpQGhogLDyGlQch2ke8fyC1ET9/qoTHgQ
 2xfvkegd33WtxkvSAlLY2sbejyX3xXbhVBnywrO7OEGC9NYPQ1U1NM8NOFkqSqYqLTuO
 /iAbArpQwmeZe4/mEeXpanSECLBHp80ad3NEFUBRLF5uy0hq8FrqBv2JTqavBf+o2uU1
 5iPg==
X-Gm-Message-State: AOJu0YwUrbT8MD2qD5WyfGxWvFZLYCm7DrUxa3IgXiy0JxV1zJcjYcVI
 i3JXEkR1NXb8sOFR+3RxG93w9r2mVT40bs4Azhwsc1UtIWnXPTfGSG7QHBPeKl1VtXlZpbknGAR
 Tm6KyHW8=
X-Gm-Gg: ASbGncuhFwI8TiCidhAxpBz7SPGgT6kHgP7KXfYLyV0pDHcSiRCznn8J/Z8PvgBq+Rn
 ytBcQCVwV+/A/z2QRpEo1hSFNEiFzSjBS46ANttJpNBHVLrIIs99NyBmxRFD+rpR0B7gjotzEkK
 xhycMfeflmCF9VKYNr8ORrJQqa+VIXnT4IZ8QctVUFD9Q/xh/+l836Dbn6zePDxvREHZ1EcgqY6
 upRX0/+ObDaAAOnA0bLKxJbaQoBYTbak9Rd97DjZCAeUGbO5i7Efxx539yqmwWYkyUwHvUzq32o
 cBiJUgWLCr7wp4C6A7FcbCN56JgEr6grlGOUt3Q8jNUXEzcrOcflBwDsSZ1LVQhhnF7NAn3FqjK
 dWW7wOMKlr+hF2UD6EyhlzwPq8fQ7AIHaQg52RSGsY5rp9r6hYqtWUmZZL/Dw7xBfG4dUsg==
X-Google-Smtp-Source: AGHT+IHV6rGFPpTD8fASgKLqvER8gw0WBOycb6dHeYnClUj7eK6kwNLLc2M+QsWwGsOPQEo04J8sDg==
X-Received: by 2002:a05:6602:2dcb:b0:887:7a86:93e with SMTP id
 ca18e2360f4ac-890343323b9mr129058939f.11.1757627659073; 
 Thu, 11 Sep 2025 14:54:19 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-88f2a7db2f1sm101517639f.0.2025.09.11.14.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 14:54:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH v2 5/6] usb: host: Tighten USB host driver dependencies
Date: Thu, 11 Sep 2025 15:50:22 -0600
Message-ID: <20250911215404.3955132-6-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911215404.3955132-1-trini@konsulko.com>
References: <20250911215404.3955132-1-trini@konsulko.com>
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

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Add Marek's tag
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


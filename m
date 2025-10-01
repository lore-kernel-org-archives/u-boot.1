Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A69ECCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 13:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E918C83526;
	Wed,  1 Oct 2025 15:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YxoWiLa+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 039818344E; Wed,  1 Oct 2025 15:21:25 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F26F83544
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 15:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b457d93c155so354969166b.1
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 06:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759324883; x=1759929683; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JgKJ7pjPU+lj3lMpo+rSMpu6l2G+S4W7MhNmjrZblSs=;
 b=YxoWiLa+ou6w8OAKiLxpxFyiITMzm9qm6FvkwBqkLtHNiwp2dQhKvG7znLLXKJtBNY
 4CV0hcF1s7PWVLQhIPABxkXbZSq546me+2p3Nsn2wwTHpWKVhTc8luzl7WO5fyb+DXpH
 ewqKOjy58SouJt4oIDb28rFBEyVChZ7w5rqPZ7DDikrJ270de4fAKpWc8U9aoXqV4iiS
 15y1RDZfdgISnAUonDL0rolghcNwD+bpE2fcR3/OKQyD24/x6nmbiV2DiU7STnp3E1d7
 gJxY0cQqbJiW7rNUdvdlO5Prcrb1cprZCaSbVQCV74VRkETq3L2V0l37luP/RkjEs+3n
 rtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759324883; x=1759929683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JgKJ7pjPU+lj3lMpo+rSMpu6l2G+S4W7MhNmjrZblSs=;
 b=aLN5sthtvEONtohWCjCGvXiNZmHUKq9okInIebJFc2jQ3il7ihHtLuWJnmgtBoTKDf
 0LQyWqvDHRvRNIzPRgjGHjxICspBaeRywcgGNE0ndpTJwlNUaDpfRw6sXtt7lMnkOjNM
 rM+BCBRnjhqhPtlzOn+FdQE4tbDytyeyLDqitcnZ0BhtD+8m+cC0wAQPuPAwadD0NBnS
 /u5KwJ7eQ04IfIGBe3dxtD4FG1SbW0R+vBhCJSJzgTOuzp/pHcVpyDfY776q76ENc/FW
 71xmv/g9Fw0ygunwLVWnx1axI+WYceuYnb5LWH5CLZ9PdsO5Ze17Meac5ZV1cOCxx/fH
 HKjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrCUzrM8T59HKD/VqBI2KWM6csBK1hQfhNjKNxZ5GA9fUQ2CJs2G8YdzW+jd1jqArNtJAyh8c=@lists.denx.de
X-Gm-Message-State: AOJu0Yxv7WzcrMMwmjOpDmQjZfxPAZdmbjjXAGcUn0Gc5OwEV2oNxRp/
 edMKgxUfRhFZu0VYlyE+jXHCCtI3VaLvaXjSL3e+YWaHrFX8eHtlxBtW
X-Gm-Gg: ASbGncv65+uMsXhVN4R1bI+Q1BXdncNlV108gZAZOgVRx+Ak3ljaWzndz2Cctl7Yvx4
 XcLR+kgvs4eLWg+WcvR8hughRpkQevVOOz+T0uWhQdw7zzc1y7RtR1qIJakQXiMHYsKDUP3BWMd
 Fgg/oscnt0VT/+FjzkPVAo0eEcbshMlP81NyvbvTjzztEvyvOWy0folzjrxv3Rz3zzT+/4Uc+ni
 swdgzn53bhBMS3iXlHQMpkhXuLkfBcUWf+U5BpDujuICfBOhkR2Maigw/MX1+4OWtVifBz9IGn5
 27KwyGG7QK2y30g2tMlmIxoxOQ/04amJ1V/10u5iH2Dw6v+scNyzpdjqAIc77kuVv6jdIdtGAWQ
 MlsHrd/fEnx7o0ScuOCiGSV6l8BLQYGuyQg8LpUlytKg3LN0OBCPrqQzbUY7EaWXxICljEqEpr6
 dRirDxQmDcLOFUAiQyMwUWIHWCCkKOYy7aHdArQFg+sIpbUOixi1BADj1Of85TDA==
X-Google-Smtp-Source: AGHT+IFgXb/Y7GrUZPnaZH7g4M9Y9IeyCRMt1iYqWVQr4G2jF3JPYw7UUFoya2GgsUgPUSl58Y9GIQ==
X-Received: by 2002:a17:907:6d0b:b0:b46:d05d:fcba with SMTP id
 a640c23a62f3a-b46e60316d3mr417787466b.33.1759324882687; 
 Wed, 01 Oct 2025 06:21:22 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b401d3d4124sm566956766b.75.2025.10.01.06.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 06:21:22 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 2/4] configs: colibri-*: enable USB Gadget OS Descriptors
 for fastboot
Date: Wed,  1 Oct 2025 15:21:05 +0200
Message-ID: <20251001132111.1490516-3-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001132111.1490516-1-ghidoliemanuele@gmail.com>
References: <20251001132111.1490516-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

USB OS Descriptors are used to install and configure the device without
requiring any user interaction on OS which support them (e.g. Windows).
Enable them in order to improve the user experience when fastboot is used.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 configs/colibri-imx6ull-emmc_defconfig | 1 +
 configs/colibri-imx6ull_defconfig      | 1 +
 configs/colibri_imx6_defconfig         | 1 +
 configs/colibri_imx7_defconfig         | 1 +
 configs/colibri_imx7_emmc_defconfig    | 1 +
 5 files changed, 5 insertions(+)

diff --git a/configs/colibri-imx6ull-emmc_defconfig b/configs/colibri-imx6ull-emmc_defconfig
index f1c6373c31e6..439ddeb8f0bc 100644
--- a/configs/colibri-imx6ull-emmc_defconfig
+++ b/configs/colibri-imx6ull-emmc_defconfig
@@ -90,5 +90,6 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Toradex"
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_USB_GADGET_OS_DESCRIPTORS=y
 CONFIG_CI_UDC=y
 CONFIG_IMX_WATCHDOG=y
diff --git a/configs/colibri-imx6ull_defconfig b/configs/colibri-imx6ull_defconfig
index 26e9b565bd51..1c400f9534d4 100644
--- a/configs/colibri-imx6ull_defconfig
+++ b/configs/colibri-imx6ull_defconfig
@@ -108,5 +108,6 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Toradex"
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_USB_GADGET_OS_DESCRIPTORS=y
 CONFIG_CI_UDC=y
 CONFIG_IMX_WATCHDOG=y
diff --git a/configs/colibri_imx6_defconfig b/configs/colibri_imx6_defconfig
index 1aea1d40c4e6..0f5abb51f766 100644
--- a/configs/colibri_imx6_defconfig
+++ b/configs/colibri_imx6_defconfig
@@ -119,6 +119,7 @@ CONFIG_SPL_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Toradex"
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_USB_GADGET_OS_DESCRIPTORS=y
 CONFIG_CI_UDC=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_IMX_WATCHDOG=y
diff --git a/configs/colibri_imx7_defconfig b/configs/colibri_imx7_defconfig
index 6c24f59b28c4..5a415120bead 100644
--- a/configs/colibri_imx7_defconfig
+++ b/configs/colibri_imx7_defconfig
@@ -106,6 +106,7 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Toradex"
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_USB_GADGET_OS_DESCRIPTORS=y
 CONFIG_CI_UDC=y
 CONFIG_IMX_WATCHDOG=y
 CONFIG_WDT=y
diff --git a/configs/colibri_imx7_emmc_defconfig b/configs/colibri_imx7_emmc_defconfig
index e23cc9935427..bae43fe45aa7 100644
--- a/configs/colibri_imx7_emmc_defconfig
+++ b/configs/colibri_imx7_emmc_defconfig
@@ -91,6 +91,7 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Toradex"
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_USB_GADGET_OS_DESCRIPTORS=y
 CONFIG_CI_UDC=y
 CONFIG_IMX_WATCHDOG=y
 CONFIG_WDT=y
-- 
2.43.0


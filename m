Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A17C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 23:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38C2087AE8;
	Thu, 26 Oct 2023 01:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P1J5WRie";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B46A587AE8; Thu, 26 Oct 2023 01:05:11 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B38EC87A5F
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 01:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7788db95652so21904485a.2
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 16:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698275103; x=1698879903; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EyySBYg80J1jtPmLKIgVLYG5Fk11OL28zBrXIMQjjyE=;
 b=P1J5WRie78OTOO0aE0Gj8bxMjzI81KPDwJq/iHD6nLuNAq/f+5Ca6CTN7rq/9HISGO
 qf1maLoXchR+SRqyZYJK+8XFK3yKHux1Iy5s/h2mSkOq/wlrlv8xAQ7tmH3C2fYru4Xo
 MRDfyZZdQs9Gpejso/+poleh4hOTwtR1zf6+MsbQAx7ba7X07P+tz5kOwIS2QgWxH3cb
 1wFwv4A40/rBJm1+h4BH6Eoi2RjJd0pQxJI3Q+gLTuDF1JTXBAlFx1NruPJPPYH5X5At
 def/oKFFY2wi2IdwtRGOgjwZrgHlDI9qRtgLF9tN5SRgB15BwzMgdHcQ2UMN7KobWfOn
 Oj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698275103; x=1698879903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EyySBYg80J1jtPmLKIgVLYG5Fk11OL28zBrXIMQjjyE=;
 b=LULj4SHK5DTjxZpfjM4fvSTDsPNYQRSyo3xVwawxu0ETRr7jLt5Z0jOCJggWo9CCZK
 kDVKe5+nJf+62/+LQsxtOsuJ7YNAw6nqZLrC6IfKQjYVQ4s4DLXzOKBsSj5996xK2/+r
 9bOpHC944NDfYBTETardpPjXn4CacFLNfuyqcutw5Stwyc6YejPRGnOFCj5V4GluNVGI
 w9O1oQZPwf8DMHX2oOEqoBGKFIIG3CEWA6ZgEbgXsNJZInzX3df0tFr8bzLIYNaaJvJy
 K7YI6GEzMYrWd6V6eIbsiEsBYlUbevZNOY0rqGD6zs/eNop7r5oqR6u1aFzjmumEjnnw
 eMMQ==
X-Gm-Message-State: AOJu0Yy/qLtPWuzKfnQabn6PHLzJ/j1/0Wa4EO9wYJ/ysNRF+Mwd7cz+
 KABx2NYlBhAwxjQ3XlWEbQXJjcLoMeQ=
X-Google-Smtp-Source: AGHT+IFyIf8IzAFhyHxRlzmAIN+Pa74Wufr3F2qMIZR17mc3b5nRZZe8X9w79GxxAf95/msFDQwFKg==
X-Received: by 2002:a05:620a:40c2:b0:779:f0a1:3128 with SMTP id
 g2-20020a05620a40c200b00779f0a13128mr6633655qko.63.1698275103117; 
 Wed, 25 Oct 2023 16:05:03 -0700 (PDT)
Received: from aford-System-Version.lan
 ([2601:447:d002:5be:449a:a220:d0aa:3d6a])
 by smtp.gmail.com with ESMTPSA id
 a24-20020a05620a103800b00767da10efb6sm4559567qkk.97.2023.10.25.16.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:05:02 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: sbabic@denx.de, aford@beaconembedded.com, Adam Ford <aford173@gmail.com>
Subject: [PATCH 2/5] configs: imx8mm_beacon: Enable fastboot downloading
Date: Wed, 25 Oct 2023 18:04:53 -0500
Message-Id: <20231025230456.7924-2-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231025230456.7924-1-aford173@gmail.com>
References: <20231025230456.7924-1-aford173@gmail.com>
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

Fastboot is necessary to use UUU enhanced functions, so enable it.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 configs/imx8mm_beacon_defconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configs/imx8mm_beacon_defconfig b/configs/imx8mm_beacon_defconfig
index 031470c169..886d912650 100644
--- a/configs/imx8mm_beacon_defconfig
+++ b/configs/imx8mm_beacon_defconfig
@@ -86,6 +86,11 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MM=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x42800000
+CONFIG_FASTBOOT_BUF_SIZE=0x20000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=2
 CONFIG_MXC_GPIO=y
 CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
@@ -142,6 +147,5 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_SDP_LOADADDR=0x40400000
-CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_IMX_WATCHDOG=y
-- 
2.40.1


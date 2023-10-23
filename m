Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7D2C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 12:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93550878F2;
	Mon, 23 Oct 2023 14:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t9pPvw8Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0212878C0; Mon, 23 Oct 2023 14:41:54 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A0BB8782C
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 14:41:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c503dbe50dso48774691fa.1
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 05:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698064907; x=1698669707; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lfS0T2H76Qdru7gYN5qzW3GDdD6skpw7X5W3gkKjwGg=;
 b=t9pPvw8ZPpoowebzEDukrCf43pQ7jh1K4osCKf3TTiHGPaR3APlmIJEGtFILI/F+BA
 fB3EY9zqJeA3Y8Hb2XqG1grQ6pDCYuBfeZKlasZGV/V8M7iRBgQrg8mM1hwf1WASr/pT
 VxAquvlhHxgx/2fdT93wDIr7ZusRU6nUTXCbE8VGtKP/EpphIOw+GEav/z22a+0f+xsH
 Y14diEN5zuUoJIBuuJM5fiNjYAUKWBBu5EbKm4EEicZ4e5J084JWSS0zbzMPHYLb7Mru
 qPCdqkQnbUsX/FtKHCvQF5cor+pJ1EEeEi9sD6fSLKa4J9JQeVUBndu22aHzLc0zl9Jk
 tVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698064907; x=1698669707;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfS0T2H76Qdru7gYN5qzW3GDdD6skpw7X5W3gkKjwGg=;
 b=ZkoA5FoOr75nt6Y1p87tAhUAQBLW479R5Poz+ZL1SlptpX4lpw4mEBsCrI6eI6bxg+
 D4I9dm0lL/TAyYHP+Qea8EX6gBAUNOq4bZbvKUntt2K4443XeLEWuklIRGYivYnSFOxY
 xvvTPH3n0lPuVJgdHAWa9kVI/W//aB9mmVG/5ZVOIrUxFs2yN9JBngT0DDMx+7JVhI+7
 gz3k0i/UTqiPN2EX5KazC7V0fJjTJwZTlH+g2622C8eHrTWRIr1ZtHLzoW/eKWn6q41h
 GLTkpK4YrDSSeYavxFqTSkD5Oyaf95giEgsZ3Ft/meTo+l7oVEUvCnP3Oo+DPNF2yZa2
 wP4A==
X-Gm-Message-State: AOJu0YzH1Z4ycK8xwjRHBjIKu58hAbqFSu09qOH9h9Da0GxR7imeREKW
 yx+eI65E1r9uVKvAaaMzzhLHOw==
X-Google-Smtp-Source: AGHT+IHttdxiQX2SBZoQtfaOmdlIscrmQw5n29ah8C3W2PsriABzQEne616Mxijjc7JB+i3d0+sBKg==
X-Received: by 2002:a2e:a543:0:b0:2bd:d34:f892 with SMTP id
 e3-20020a2ea543000000b002bd0d34f892mr6590997ljn.3.1698064907388; 
 Mon, 23 Oct 2023 05:41:47 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:982:cbb0:a36e:a5d9:26ae:74b1])
 by smtp.gmail.com with ESMTPSA id
 h14-20020a05600c314e00b003fbe4cecc3bsm14230609wmo.16.2023.10.23.05.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 05:41:46 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 23 Oct 2023 14:41:36 +0200
Subject: [PATCH 3/4] configs: meson64: add alternate USB DFU boot target
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-usb-dfu-boot-v1-3-df9d121c67c1@linaro.org>
References: <20231023-usb-dfu-boot-v1-0-df9d121c67c1@linaro.org>
In-Reply-To: <20231023-usb-dfu-boot-v1-0-df9d121c67c1@linaro.org>
To: Christian Hewitt <christianshewitt@gmail.com>, 
 Vyacheslav Bocharov <adeep@lexina.in>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2243;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=tHu01qz5Fe2UUwEyrfr1+NhVK+wMngiROaN1YhSFWjE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlNmoHRHPolEPcfGqUkS7UQlgWg7ESyiqEaSomR
 +LLG24poyKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTZqBwAKCRB33NvayMhJ
 0ezWEADM9ojFF8mWBtni5CIBf40hfMAU+H/mSK77BGw0KjS5UjCxD7o3yTFXR82qdSODIF7jHbN
 re8t2GDWe0Wm2eVyh3uO42SAhadX3kNl4lAuWN1engxwLt7BA5r15bekXQVs8q2MsAyLSkUL6Cy
 mBFspz49B+HO3sYdHi2myiDq+tepj+SYr0o0jG6bEGBVOBB0XCLCh4nB3QqsZnoDkGr7eZOQxqd
 Ywlk3aGnFii/jf8oTFL7+TiTD3qsheualArayGwItRBemypn1kfAPJTvYAPx9iRZuhxsTl6mCqM
 EqogKSLH1qXW7mqj11kfUI2CYT4NT4BoPd43Vpifp1K56zTbEtSMR5PTKUYnyMlWldUnPiSKvQA
 +Ld39eBzHmDYvhVetdbU4jRcF84epLq+IoVXSgxQSlLzgciTI+Abazo9kxDTs+9I4Ca/XvocCA1
 OOd04XApYHtqL9fWZosK1ddLk0xczVgqoOGC7KUyNTQptWYjeE63+MOmY1I0376gBqmGD9HhrUZ
 nchndapHVIMbAevycU6GkKOmFB7FE45Kp8jCBDwbGd2tirLlNPsvREHBg+3uqMCUiBWGooTgj5a
 BA+0MGXl0TydVGSG28pr7rvvn1u1UiQe3STTZ4wtuLTTaK6uu9IBeXE74qW6/xzj5YwWZVzTZoH
 ljpRvKMxOKgGVBA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add boot over DFU RAM as an alternate to running script at
a fixed address like done today.

The main culprit is that it's not possible to do that
on G12A/Sm1 platforms due to changes in the USB boot protocol.

With this, U-Boot will present a DFU device with a ram slot where
the Host could write a fitImage or legacy U-Boot image, then with the
detach command boot will continue trying to boot the uploaded image.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/configs/meson64.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/configs/meson64.h b/include/configs/meson64.h
index a64817ec9b..efab9a624d 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -53,6 +53,30 @@
 #define BOOTENV_DEV_NAME_ROMUSB(devtypeu, devtypel, instance)	\
 		"romusb "
 
+/*
+ * Fallback to "USB DFU" boot if script is not at scriptaddr
+ *
+ * DFU will expose the kernel_addr_r memory range as DFU entry,
+ * then with `dfu-util --detach`, booting the uploaded image
+ * will be attempted:
+ * $ dfu-util -a 0 -D fitImage
+ * $ dfu-util -a 0 -e
+ */
+#if CONFIG_IS_ENABLED(USB_GADGET) && CONFIG_IS_ENABLED(DFU_RAM)
+	#define BOOTENV_DEV_USB_DFU(devtypeu, devtypel, instance) \
+		"bootcmd_usbdfu=" \
+			"if test \"${boot_source}\" = \"usb\"; then " \
+				"dfu 0 ram 0 60;" \
+				"bootm ${kernel_addr_r};" \
+			"fi\0"
+
+	#define BOOTENV_DEV_NAME_USB_DFU(devtypeu, devtypel, instance) \
+		"usbdfu "
+#else
+	#define BOOTENV_DEV_USB_DFU(devtypeu, devtypel, instance)
+	#define BOOTENV_DEV_NAME_USB_DFU(devtypeu, devtypel, instance)
+#endif
+
 #ifdef CONFIG_CMD_USB
 #define BOOT_TARGET_DEVICES_USB(func) func(USB, usb, 0)
 #else
@@ -74,6 +98,7 @@
 #ifndef BOOT_TARGET_DEVICES
 #define BOOT_TARGET_DEVICES(func) \
 	func(ROMUSB, romusb, na)  \
+	func(USB_DFU, usbdfu, na)  \
 	func(MMC, mmc, 0) \
 	func(MMC, mmc, 1) \
 	func(MMC, mmc, 2) \
@@ -109,6 +134,7 @@
 	"fdtoverlay_addr_r=" FDTOVERLAY_ADDR_R "\0" \
 	"ramdisk_addr_r=" RAMDISK_ADDR_R "\0" \
 	"fdtfile=amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
+	"dfu_alt_info=fitimage ram " KERNEL_ADDR_R " 0x4000000 \0" \
 	BOOTENV
 #endif
 

-- 
2.34.1


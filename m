Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9BBCCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 05:51:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D27D783700;
	Mon, 27 Oct 2025 06:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CbeJ5ivi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9F6B83849; Mon, 27 Oct 2025 06:51:13 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDC3A836F0
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 06:51:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c2846c961fso2442158a34.2
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 22:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761544270; x=1762149070; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPeJi4JjQVWnfvsxCCBCAM+oRKvDd767KgxxKfeN/j0=;
 b=CbeJ5ivi11dX8XEHIh9kTF53laJrfsi9i0BRsAlfP+WCWXfOnx+BCT5IxpvEuDgt4r
 iNo9QYBJEXowDpDPEphl/E8B4aTW7NpfgCo1MbnswJnMBuB6fM7Ci1yLFXbHI3HA8zUP
 CvpXGKaemsOCN8yz4h+pfFPfqeHOalmmYyTFgOTfkPjiwU42nZDgHl3VnFQ41oQSF+Cz
 h0Kvh0PJw8IU+3ZdHr6jT65lYetDgUpLvcsI34T0oFhec+/vMi8XWFBeWkxiNmt8/Jgm
 A39ctMmBK8FgNpOfr7EmCrUJEzQXp4arvc9XgaRLIYOfSj47EemO5LmKXo7d0rn32oV0
 3MGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761544270; x=1762149070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jPeJi4JjQVWnfvsxCCBCAM+oRKvDd767KgxxKfeN/j0=;
 b=IaCTYrLLqY7SwjPYjgdrxIP79nH+Cs4Wl90WH6JqRPSWa8YUoRpdrupcH1QxIIs7Ij
 rr6be+jO4H6gAhqgbtMRGWCgsIw82bpXMiRfsJEviSI54vJgmqFqHODQQjkdxcyB0X6b
 kgx2Ixh5YW7J9Gv3V+BBqsppjnJL2Yix+7sM1XdIJJNX8xNqOeRzQ4rcs20WOu8bsP8U
 gQOHd4i+DKYbSARpbXxo2Vy38bmSkxAY5Jgg0Jtj5NFjoolMZWpDd65Gz+xtrvcARlZb
 eyjV2KwLGrtpLUPbYDtGHJCuh83ajoHqqKO0wbBWNB2PuPW6xXjXwIcZLCLVEDIiAS0w
 G4pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGkdW2SIlurNRNyKM7lopDGmCMnnIVzHj++rz3hnCGFXHgG9fJh1HBD27WonstwTI3VRzHpy4=@lists.denx.de
X-Gm-Message-State: AOJu0YxEjUOrwT88T95VkxUcd0iA1eS28bZPtAh6g49VDSYhEVe82s28
 IFA5vElAkEXRxXM20nbcM0YZIhKwYAh4gvdzDoWXdYH27imAbQHzK2gJe/XRXzJVkVc=
X-Gm-Gg: ASbGncvQpnOxx+zcYdwEbXsNhf6gGPrXFv+gVE6UnJpIl5FxZMJq/BAWOJt9cDOG+CS
 fYx/5f4j+RwKB5/CmzhVIQNBCBqrC7qnKdwNUCj7/997pZCdJL2v1s/5dmjkvS6BYc8dMyvCJPL
 +p8DR3gtQ56fYWucwG5qpXA9Xw+PgQiHLNZGfMQoY9T3/DxuNxKIvSeYyitze7PufaW5MGTRE2V
 KDrrUbpR4ch2bzJvItJIpG729wDOTySKjPJ54E5kxl+jfiiT3mRtFH/hfEF9x+A2KU5aisQ3cbV
 onZt4mw6YGguglbdDWRBcv7WzikP9wkM/XWxzqAPqBwDVa2ji9/6jCR0Da1xbSY/VK93o6J6RlS
 qjOaVh8bvkBEWreybYDFfwcKcM9Sg9RCyq5jE7zfvtHgYKlSvYdvSXI5dZ5bsRl1Nq0VrakpAia
 J3GD3IOxl2Rm3vkkeMmJ2qZldTNGkhzaE=
X-Google-Smtp-Source: AGHT+IF9jQT8kW48VvIopHgLaWBs3PviTaaQK9OrsSesdwiqkWwXx7LjzZFgasnIMNuamen5rvQ1xg==
X-Received: by 2002:a05:6830:3105:b0:795:99bb:f719 with SMTP id
 46e09a7af769-7c51b03d914mr8403910a34.23.1761544270460; 
 Sun, 26 Oct 2025 22:51:10 -0700 (PDT)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c53013645dsm1958401a34.14.2025.10.26.22.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Oct 2025 22:51:09 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	u-boot@lists.denx.de
Subject: [PATCH 5/5] board: samsung: e850-96: Load firmwares over USB on USB
 boot
Date: Mon, 27 Oct 2025 00:51:05 -0500
Message-Id: <20251027055105.720-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251027055105.720-1-semen.protsenko@linaro.org>
References: <20251027055105.720-1-semen.protsenko@linaro.org>
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

During USB boot it's expected that the bootloader (U-Boot) should
download LDFW and TZSW firmware binaries over USB, using corresponding
SMC call. Once it's done, the Boot ROM code can release the USB block,
so that it can be used in U-Boot (e.g. for flashing images to eMMC using
DFU or fastboot). Otherwise USB wouldn't be accessible in U-Boot, and
any attempt to access USB PHY or DWC3 registers will lead to abort.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 board/samsung/e850-96/e850-96.c | 36 +++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/board/samsung/e850-96/e850-96.c b/board/samsung/e850-96/e850-96.c
index 3cf98a01b703..3aa4992a36d5 100644
--- a/board/samsung/e850-96/e850-96.c
+++ b/board/samsung/e850-96/e850-96.c
@@ -11,6 +11,7 @@
 #include <net.h>
 #include <usb.h>
 #include <asm/io.h>
+#include "bootdev.h"
 #include "fw.h"
 #include "pmic.h"
 
@@ -31,6 +32,10 @@
 #define EMMC_DEV_NUM			0
 #define EMMC_ESP_PART			1
 
+/* Firmware size */
+#define LDFW_MAX_SIZE			SZ_4M
+#define SP_MAX_SIZE			SZ_1M
+
 struct efi_fw_image fw_images[] = {
 	{
 		.image_type_id = E850_96_FWBL1_IMAGE_GUID,
@@ -127,11 +132,34 @@ static void setup_ethaddr(void)
 		eth_env_set_enetaddr("ethaddr", mac_addr);
 }
 
+static void load_firmware_usb(void)
+{
+	int err;
+
+	printf("Loading LDFW firmware (over USB)...\n");
+	err = load_image_usb(USB_DN_IMAGE_LDFW, LDFW_NWD_ADDR, LDFW_MAX_SIZE);
+	if (err) {
+		printf("ERROR: LDFW loading failed (%d)\n", err);
+		return;
+	}
+
+	err = init_ldfw(LDFW_NWD_ADDR);
+	if (err) {
+		printf("ERROR: LDFW init failed (%d)\n", err);
+		/* Do not return, still need to download SP */
+	}
+
+	printf("Loading SP firmware (over USB)...\n");
+	err = load_image_usb(USB_DN_IMAGE_SP, LDFW_NWD_ADDR, SP_MAX_SIZE);
+	if (err)
+		printf("ERROR: SP loading failed (%d)\n", err);
+}
+
 /*
  * Call this in board_late_init() to avoid probing block devices before
  * efi_init_early().
  */
-void load_firmware(void)
+static void load_firmware_blk(void)
 {
 	const char *ifname;
 	ulong dev, part;
@@ -175,7 +203,11 @@ int board_late_init(void)
 {
 	setup_serial();
 	setup_ethaddr();
-	load_firmware();
+
+	if (bootdev_is_usb())
+		load_firmware_usb();
+	else
+		load_firmware_blk();
 
 	return 0;
 }
-- 
2.39.5


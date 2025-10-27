Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10B5CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 06:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8366883885;
	Mon, 27 Oct 2025 07:15:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U6wLbegi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A04B88384E; Mon, 27 Oct 2025 07:15:01 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66104832AD
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 07:14:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c532d70cfaso1277118a34.1
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 23:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761545698; x=1762150498; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fMLOVNQvRr5GxQFng9nYuFElzOK0mukE9IsNuwMojY0=;
 b=U6wLbegi//fVVK388y4cQURNfGMwjjnhXaeFOfI31KqElGcU6L9iHaAvgsOZ1qoJNu
 eSdklqyZUlwr/ruZbKtQB+1C9uxoQfJk1vtO4QQzPXmGERsaYx+SHmQMgGf7QCXSpNaQ
 RYCJYazOhOLqdNLAcrhEi5StS03EJ1QCYZ9Hr0osJ5Lh9w9LrpQ1Lzw0nxb0gPoThDD7
 QeiP6ByuoQBk32rWjAhpT9TRTT5HimxV399Tjf0/L3t16+qApj6kQeGPCzFFNuaNhB6N
 1r60tEGsyauSyjjoj0zJAv0KNr0teN2Tn8njDEuPFaxKj+WoPjBfJjkWZ9EeNZissDK2
 RA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761545698; x=1762150498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fMLOVNQvRr5GxQFng9nYuFElzOK0mukE9IsNuwMojY0=;
 b=i/BVr/iNGfZ4piMg4aABXjHHTSjgBXfnC37JaZpIO7uuJyukHvOCFwaXFRYH8EMQJQ
 w19TSOc8AgDd646sTCLh2czUoX/KeSLVKkiaHSYrPaReaZWUnQ8k+o9jbvx3ZJYEnP1J
 0ZGnVJFSuM5PY0kjOE+RKfCd5DNmNAkZNHnUwwCq4Znl5dvzNWSNSghcIkr9YsMt6P8W
 7nQ/UAl9xcH8CjnmZxBNCEDC/UR/OXd+naIt9KRQKuD3hXTW1PmO6XxF/0oKpaTFyCTR
 tnG9RvzYWE82fKvfBM3YwK9jdFeYEJTz9FDM/UoXNFBy7patjFFQzBv3CQZEZy2pze6m
 rPIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrjSdbgBfz+7v4pvvCcxclLPQAbXYHZjCkt4w/tWvOtIwZbT/v9vGN/i1At9v5x2C8IytOJxs=@lists.denx.de
X-Gm-Message-State: AOJu0YwtxvO+CzSeuJUzx6wQPUNfoe5cag0f7R4883aEjbBJMftNPWi2
 Tm73fyuegSdfAiAN+vrdw5aklP3rJ9zX4y/jlf//JUDL+nyJBUEWetfs2oWLgk+AUMM=
X-Gm-Gg: ASbGncs44cygtJc3Z6AcBZZJgWLxPOgmSQgkX+JRkmeF7Mxvr51ktP75JGa3FLrdLe4
 y750jAJMsi74XSUVHu/B6x8wzyoTAmw+kgu58yIrPAJsdtfadXtDaTE7p9BxkI5ItQB+hjo0eDz
 FPon1n1jFOvM13f6NZQPnXg5hcVttIa1Fu5cfOJoeqTJhOb+CkZoy2Ym5ileT4NvI77Blzo0opp
 Oe/e7anSJvDae8U2U/IEORu9zbzeYelc7285nco4qDlryhrEJSv+sw3SrECyisMpMCVqEafPgrb
 iIuNq9dB0dtNcHvdcdssUo7JNSJG3QSj4ZojkWQ5LE3YJGHW9OOZiN7BFl3UqyM93Id588uKxBZ
 BMNvfa269hpcjwmPIZoDuq4dkbhNvGX+10HBDddMj8mJLbCZEMGR1/Vllqt+kuC4j07sXswpVYd
 nRZf+E3yCeVskSsfP2JEtw
X-Google-Smtp-Source: AGHT+IEnRl5Zwb3vjbonPgfJq8psYF3BZEOxQcDl29Js6itbL8cdexX+h37IEFfExMwjIlYbOvf1iQ==
X-Received: by 2002:a05:6830:6ea9:b0:7c3:e07f:5681 with SMTP id
 46e09a7af769-7c3e07f6152mr9278102a34.10.1761545698102; 
 Sun, 26 Oct 2025 23:14:58 -0700 (PDT)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c5302222a1sm1995853a34.31.2025.10.26.23.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Oct 2025 23:14:57 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 5/5] board: samsung: e850-96: Load firmwares over USB on
 USB boot
Date: Mon, 27 Oct 2025 01:14:52 -0500
Message-Id: <20251027061452.21165-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251027061452.21165-1-semen.protsenko@linaro.org>
References: <20251027061452.21165-1-semen.protsenko@linaro.org>
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
Changes in v2:
  - (none)

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


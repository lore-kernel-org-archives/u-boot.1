Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5720BC44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 20:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A76C6089D;
	Wed, 22 Jul 2026 20:43:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BiHFDXjz80wx; Wed, 22 Jul 2026 20:43:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6BD316071E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784753015;
	bh=jY4VNVf6XSr//v7Bx69c24YBuzLdK3Gp2IXMXfLpom0=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ODB0pw7lF9WCogFQfvQGNzy/X5x22ecdI1853WY0p4AYv977qeHXjPJaOC38YYHdM
	 vSdUtUzXBHMNb/Y5gTLCKH3LQkanCfaBBzv2ParUvrTfjlYUH6OdFtYes+KjHzYOjp
	 4RRLUDUWL9KXmsofQsaxx0M5VXvC3YVvcxZ8n+sQMY5VNpQc46EOOzYPlna2YzoBSi
	 0to3AzJpFx1oNeBUc7MaamJjs1gjJpoMCEnTIJ2qYDCebRvb5DFj5Zl93IJyO9GwLD
	 CciX4e5KbdjKy2mflUQbl78B/YrQl7B+cVwohv7riIW3I3mM++rKmaLm5VeXTCe1AV
	 36IZYmOQJWiTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BD316071E;
	Wed, 22 Jul 2026 20:43:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A431E1B8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:43:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 872A780BCC
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:43:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pJ03vhkUIrfQ for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 20:43:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:31::2;
 helo=mail-wm2-x02.google.com; envelope-from=ccaione@baylibre.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7369980BB7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7369980BB7
Received: from mail-wm2-x02.google.com (mail-wm2-x02.google.com
 [IPv6:2a00:1450:4864:31::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7369980BB7
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:43:32 +0000 (UTC)
Received: by mail-wm2-x02.google.com with SMTP id
 5b1f17b1804b1-49242309566so26152565e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784753010; x=1785357810;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jY4VNVf6XSr//v7Bx69c24YBuzLdK3Gp2IXMXfLpom0=;
 b=XqRa52G8ihpaj6Kk6cb2Tjr0hnV59rIGG+HNwvv+bfqGPMRnUh11+TI5aVaUFeyglq
 6C1q18VA3zyniYybrhHlDzaFQY+egtAyJBAM5E0ai7kj7w6IU+so0lcRUg+m7HRA+OJr
 PqEbT1MuPBPygcCeBUCMooYx+zUz0fh3rLUT4y7wrIs5XCP9Fks2mFUCly/g8EI+9e33
 O79754Va9vXYr13pHLvKc3Ls2UoCSvZqg2DgBuBhdxxABItRScRMVhbs/E6CvCs3kKg7
 tjcsQe8UqnIEeogP79TUdisGF8Xnm4CxX0vczPHxYvWrTbpPQCOV36N3ToeNs6IvbTjD
 /Sgg==
X-Gm-Message-State: AOJu0YyjEYryNoY6+tX4pMe09eS+iKCY3sLLsEK17NokMF5bP1fpFh1E
 BM+MT5DM05chFMC81PwmKO3slLK85jIy2pXbjbJ3b1KAHwlmtBaXekSIgpZVmtKf8mw=
X-Gm-Gg: AR+sD11M9rkwTde6Y7ZNr8LEhXYldxPwLus6weFCYX2xIoeMb5Z4ioiCbeJoHjN6Lfy
 TCoEcsUoThjIVM6yHKRGHZsfyoUmva8UFlVYLhgbW66TUGQfWyM+P/XEKQmy0uBrVsoG1bWk4VQ
 PQOwGPHuQ0vek/sFSrs6Qo8mAyEqq6FhnoQs460vUwnO6oJ5nJLiPQU7v1NofXRnOZWP2mQA4Yp
 6/dr50VxHssg2zg8BZ/QdD+MzB5KyozLdhihxq6SSjFkRIkxdx0qmVt03/CP79j1mH1mtEHM5Iy
 HFKE9/USrtDqvKs3VsNtcMDh30n09pZ+EiDXWlbjscpFTX9JFQUzUfCtYacBBI976hxfMoOQBxE
 pFVngFI4BcDRYMxu6lT+lll09nP0LXxR7UHqqV1skdk1+kazAWn3tgkgpnMYJLLVsyZuUtYZ8cb
 zMhfzMmPrTWTQmU8+yNSyi7nex/GZwix8bblRYHpe1LAhKPw9iah1Q7QVF7kU=
X-Received: by 2002:a05:600c:2105:b0:495:69bd:17f7 with SMTP id
 5b1f17b1804b1-49573cf1544mr1387065e9.32.1784753010147; 
 Wed, 22 Jul 2026 13:43:30 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b4e8885sm60775195e9.0.2026.07.22.13.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 13:43:29 -0700 (PDT)
Date: Wed, 22 Jul 2026 22:43:03 +0200
Subject: [PATCH RFC v2 1/5] fastboot: factor out the USB session runner
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-ccaione-upstream-spl-fastboot-v2-1-2ba3f71c42bc@baylibre.com>
References: <20260722-ccaione-upstream-spl-fastboot-v2-0-2ba3f71c42bc@baylibre.com>
In-Reply-To: <20260722-ccaione-upstream-spl-fastboot-v2-0-2ba3f71c42bc@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Sam Day <me@samcday.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784753010; x=1785357810;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jY4VNVf6XSr//v7Bx69c24YBuzLdK3Gp2IXMXfLpom0=;
 b=hma/QW2vHQQUNNPB3Dje+3P3HJtAgf5Aa/1tnzkFSJumPnPB5vUpAUILYUxW7zyMmz
 6gcwtGihXlbNWnyAvEPcCbnkubLibA+4vaQ8f+LYxHBrmM1s86Bcj2BBfueeoaWiO4Lr
 tRtfL6x99gvZKn+UaJ/7xHUEpm8xN1LbTfaGyXgYu6BShHWZWVzp1smTStFbjE1Co+Qx
 meQ5zfU8AaZhef00UnpYWVFwhjpC61S58FEzgNvOCzQzZjSRnl/aQ+7O2i5jcftxb1+C
 6lcYFOJC3Mzb/TsVGOqU2b2LU+1luqkogdlIrOYJ+uQP1kxAidehKzcVxZ0S3gQ4ae4Y
 yp1A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hma/QW2v
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Carlo Caione via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Carlo Caione <ccaione@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The fastboot command currently owns USB gadget setup, protocol
initialization, the service loop and teardown. This prevents callers
which do not use the command line from starting USB fastboot without
duplicating the same session lifecycle.

Move that lifecycle into fastboot_usb_start() and leave cmd/fastboot.c
responsible only for argument parsing and transport selection.
Initialize network sessions in their transport path so their existing
behavior is preserved.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 cmd/fastboot.c            | 60 +++++++------------------------------------
 drivers/fastboot/Makefile |  1 +
 drivers/fastboot/fb_usb.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 include/fastboot.h        | 10 ++++++++
 4 files changed, 85 insertions(+), 51 deletions(-)

diff --git a/cmd/fastboot.c b/cmd/fastboot.c
index f3929f88dfa..b12f9ea0ac4 100644
--- a/cmd/fastboot.c
+++ b/cmd/fastboot.c
@@ -7,12 +7,9 @@
  * Rob Herring <robh@kernel.org>
  */
 #include <command.h>
-#include <console.h>
-#include <g_dnl.h>
 #include <fastboot.h>
 #include <net.h>
-#include <usb.h>
-#include <watchdog.h>
+#include <vsprintf.h>
 #include <linux/printk.h>
 #include <linux/stringify.h>
 
@@ -63,7 +60,6 @@ static int do_fastboot_usb(int argc, char *const argv[],
 {
 	int controller_index;
 	char *usb_controller;
-	struct udevice *udc;
 	char *endp;
 	int ret;
 
@@ -82,48 +78,9 @@ static int do_fastboot_usb(int argc, char *const argv[],
 		return CMD_RET_FAILURE;
 	}
 
-	ret = udc_device_get_by_index(controller_index, &udc);
-	if (ret) {
-		pr_err("USB init failed: %d\n", ret);
-		return CMD_RET_FAILURE;
-	}
-
-	g_dnl_clear_detach();
-	ret = g_dnl_register("usb_dnl_fastboot");
-	if (ret)
-		return ret;
-
-	if (!g_dnl_board_usb_cable_connected()) {
-		puts("\rUSB cable not detected.\n" \
-		     "Command exit.\n");
-		ret = CMD_RET_FAILURE;
-		goto exit;
-	}
-
-	while (1) {
-		if (g_dnl_detach())
-			break;
-		if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
-			if (tstc()) {
-				getchar();
-				puts("\rOperation aborted.\n");
-				break;
-			}
-		} else if (ctrlc()) {
-			break;
-		}
-		schedule();
-		dm_usb_gadget_handle_interrupts(udc);
-	}
-
-	ret = CMD_RET_SUCCESS;
-
-exit:
-	udc_device_put(udc);
-	g_dnl_unregister();
-	g_dnl_clear_detach();
+	ret = fastboot_usb_start(controller_index, (void *)buf_addr, buf_size);
 
-	return ret;
+	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
 }
 
 static int do_fastboot(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -167,13 +124,14 @@ NXTARG:
 		return CMD_RET_USAGE;
 	}
 
-	fastboot_init((void *)buf_addr, buf_size);
-
 #if CONFIG_IS_ENABLED(NET_LEGACY)
-	if (!strcmp(argv[1], "udp"))
-		return do_fastboot_udp(argc, argv, buf_addr, buf_size);
-	if (!strcmp(argv[1], "tcp"))
+	if (!strcmp(argv[1], "udp") || !strcmp(argv[1], "tcp")) {
+		fastboot_init((void *)buf_addr, buf_size);
+		if (!strcmp(argv[1], "udp"))
+			return do_fastboot_udp(argc, argv, buf_addr, buf_size);
+
 		return do_fastboot_tcp(argc, argv, buf_addr, buf_size);
+	}
 #endif
 	if (!strcmp(argv[1], "usb")) {
 		argv++;
diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
index a341af076d1..32e8e072c88 100644
--- a/drivers/fastboot/Makefile
+++ b/drivers/fastboot/Makefile
@@ -3,6 +3,7 @@
 obj-y += fb_common.o
 obj-y += fb_getvar.o
 obj-y += fb_command.o
+obj-$(CONFIG_USB_FUNCTION_FASTBOOT) += fb_usb.o
 obj-$(CONFIG_FASTBOOT_FLASH_BLOCK) += fb_block.o
 # MMC reuses block implementation
 obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
diff --git a/drivers/fastboot/fb_usb.c b/drivers/fastboot/fb_usb.c
new file mode 100644
index 00000000000..08aba7b5c12
--- /dev/null
+++ b/drivers/fastboot/fb_usb.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2008 - 2009 Windriver, <www.windriver.com>
+ * Author: Tom Rix <Tom.Rix@windriver.com>
+ *
+ * (C) Copyright 2014 Linaro, Ltd.
+ * Rob Herring <robh@kernel.org>
+ */
+
+#include <console.h>
+#include <fastboot.h>
+#include <g_dnl.h>
+#include <usb.h>
+#include <u-boot/schedule.h>
+#include <linux/errno.h>
+#include <linux/printk.h>
+
+int fastboot_usb_start(int controller_index, void *buf_addr, u32 buf_size)
+{
+	struct udevice *udc;
+	int ret;
+
+	ret = udc_device_get_by_index(controller_index, &udc);
+	if (ret) {
+		pr_err("USB init failed: %d\n", ret);
+		return ret;
+	}
+
+	fastboot_init(buf_addr, buf_size);
+	g_dnl_clear_detach();
+
+	ret = g_dnl_register("usb_dnl_fastboot");
+	if (ret)
+		goto err_put;
+
+	if (!g_dnl_board_usb_cable_connected()) {
+		puts("\rUSB cable not detected.\n");
+		ret = -ENODEV;
+		goto err_unregister;
+	}
+
+	while (!g_dnl_detach()) {
+		if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
+			if (tstc()) {
+				getchar();
+				puts("\rOperation aborted.\n");
+				break;
+			}
+		} else if (ctrlc()) {
+			break;
+		}
+		schedule();
+		dm_usb_gadget_handle_interrupts(udc);
+	}
+
+	ret = 0;
+
+err_unregister:
+	g_dnl_unregister();
+	g_dnl_clear_detach();
+err_put:
+	udc_device_put(udc);
+
+	return ret;
+}
diff --git a/include/fastboot.h b/include/fastboot.h
index b106d617749..b7b661b9591 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -125,6 +125,16 @@ void fastboot_set_progress_callback(void (*progress)(const char *msg));
  */
 void fastboot_init(void *buf_addr, u32 buf_size);
 
+/**
+ * fastboot_usb_start() - run a USB fastboot session
+ *
+ * @controller_index: USB gadget controller index
+ * @buf_addr: Pointer to download buffer, or NULL for default
+ * @buf_size: Size of download buffer, or zero for default
+ * Return: 0 on success, or a negative error code
+ */
+int fastboot_usb_start(int controller_index, void *buf_addr, u32 buf_size);
+
 /**
  * fastboot_boot() - Execute fastboot boot command
  *

-- 
2.55.0


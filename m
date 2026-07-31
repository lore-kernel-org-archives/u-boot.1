Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10A0C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 08:30:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCFFF80E13;
	Fri, 31 Jul 2026 08:30:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JGevOK4e582h; Fri, 31 Jul 2026 08:30:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B350C80FB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785486603;
	bh=gZaU3DCBhpN4Fg1gQrLrHxT8K0UvZSN7AaIw2mlvmD4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gjdh0y8y/sMq2TBNy+jgfJd1nuURen4J9R0QnGyUOEQbGhNEE2TrRr43pA/f9pr0f
	 CGkG2Bt9Te/IAr71k3xXrIUdbmvTiIaEfD5SIhtU5VN1aLfMpfVCE4XJLNQiuPmTZt
	 eL2kXsj7nXB7ucflynaDBo534MU+7kkes2LKGByyUtsq4FiKm6tk9tn5022qPpPOln
	 3loVYyEQ8OncUOLJuNnSNZclkwkbL9dXuL76kGMwMqN6Ymn6ceNnGmhM92YlUlyylC
	 KzRwa5BsutemG4IoRxK9K9DiIWj+Ax/BcBDkydTth/vjxlqROg7FaeaRDxLCDSvlWh
	 Jr/WIl61EUWaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B350C80FB0;
	Fri, 31 Jul 2026 08:30:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B159526E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:30:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A33E580DEF
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:30:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bGEuZ5KqRvnj for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 08:29:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 57F2380D44
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 57F2380D44
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 57F2380D44
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:29:58 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-69c7ab350e9so1137496a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 01:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785486596; x=1786091396;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gZaU3DCBhpN4Fg1gQrLrHxT8K0UvZSN7AaIw2mlvmD4=;
 b=Zzgyin/+WtKvZ5B3zgKTkZ7NYMvYpnF8T0JitGcpPMaX/dOZlaFWIXwM6NJdeIbyDU
 q2OCpwjayxNQUtT2qRrpc6Gu7hP8MYVDg19JWMKXtCDX08TMnNz1c0OcFb9dZEKtii4X
 lP3ogKl+0Yi39laSjVW6Y1h+s7ZFsS3Q2wlGcjXFrem4gxJ2yHaeZB0aqHnmONN376eN
 zSuGvptQeP7jit7JV4OH1zY93JXSjnbPPiSZc42aZVIt0YeFdnbf98r2DwKIVBO6H4y8
 iGWuHVdc0JXJfm0aEKXkTn/z2o5Pxk1rHhDQTAcd/o3gpraMnPkSjxeBw2Ad/XkUKvE0
 lglQ==
X-Gm-Message-State: AOJu0Yz6OCALpGbN4yzC72hWv/2IwDqfnJLUnA3OisQ3F5zPIpEkwdeV
 WS9DGRyJBoeM/VhoGGgGNzUX965SHkmHh90ZT+r9QTNuRPlUh/LNdgGhBPDLWDsSZ+c=
X-Gm-Gg: AR+sD11nF8N77TVCHeM2qFeqJiHHJzBnPXI//R+zUP7avKtxnwLsX1EQMrsWw/OqJHI
 fe+iPj6809Ij7zKV+8MTOe43OeJss+wkZBrACi4Kaw6qFHNWpZLo5Y4Q7z9UbiefpUjIxef0oly
 cgU6jWXVUCc1wGssQTfM0VJUW1ZJwW2jg2V56QhM5PsMO0MBSHn4G/Tmhf+0lf6Plo79LFuaOOB
 JOxqYC3CIBZXQIeOYiwuIDca3AT3SfYjBshHZVNHcGtuQUWHSbrfabuIv9jnRqND209yN65o+tg
 XL6lTD0PAO96ETL+O0tH8kQhfmOu1y9dSCY+A1oyhO+8wPn03Ph0ysWkvreBNOUywiTo9RMgAaa
 1zHjq63sZgwPMZtpQMyLeKoGopgES4x6tHKY1QFxw704hY4F3rUP+BwT9PrGb/Sos2uSRdo67aS
 6bNeKSEEM5v0/33uBUTRwzoAwmzruCF9G/UOv1QFF4k0otl9hPlZ3wYXur7GWVy4v6hRMp2LzUA
 TDCx0yCBikhjRkFkp1VuBFuvdH36i5FxYGTeiP24lVODzAYhN4MGnWuWmcTUTiGYCIYfcLnxaY5
 ecCwT1wqw78=
X-Received: by 2002:a05:6402:1908:b0:69c:4051:69e5 with SMTP id
 4fb4d7f45d1cf-6a098cf9a66mr572571a12.28.1785486596337; 
 Fri, 31 Jul 2026 01:29:56 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.pool212171.interbusiness.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a09c661641sm583646a12.29.2026.07.31.01.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 01:29:55 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 31 Jul 2026 10:29:37 +0200
Subject: [PATCH RFC v3 1/5] fastboot: factor out the USB session runner
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ccaione-upstream-spl-fastboot-v3-1-dbea3ff4529e@baylibre.com>
References: <20260731-ccaione-upstream-spl-fastboot-v3-0-dbea3ff4529e@baylibre.com>
In-Reply-To: <20260731-ccaione-upstream-spl-fastboot-v3-0-dbea3ff4529e@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785486596; x=1786091396;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gZaU3DCBhpN4Fg1gQrLrHxT8K0UvZSN7AaIw2mlvmD4=;
 b=CQJ+grpi/72SX6UBIW0d9FKWvB71KEstvzkK5aCvcIzShOF3WGrPDDgeX666XacXTc
 ySc9sHtNFvtQxkx0qGBCjczIDy5ckdjPQSVdQUpezYl47x8RQiej27kMW8TEI+5mqQXo
 ppKSHKWNFFPj4xxSzwKR3wM5DtQekTTHMBCfoydTJ/xYnoO2PCcPXNex1SUZVW/GSnkI
 gGsysi6y5EU8OfHGSSo+18UJkapInxPKdBEhdJ66TBdvBDI9zhgK4mo2uBLzxz2Lm97x
 E9H+hzNdF84myM8LU62OwesncOjVT92Quy0XVkQZLgmo1NYvlPgO5FntCdpr6TVITLOX
 11Zg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=CQJ+grpi
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The fastboot command currently owns USB gadget setup, protocol
initialization, the service loop and teardown. This prevents callers
which do not use the command line from starting USB fastboot without
duplicating the same session lifecycle.

Move that lifecycle into fastboot_usb_run() and leave cmd/fastboot.c
responsible only for argument parsing and transport selection.
Initialize network sessions in their transport path so their existing
behavior is preserved.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 cmd/fastboot.c            | 53 ++++-----------------------------------
 drivers/fastboot/Makefile |  1 +
 drivers/fastboot/fb_usb.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 include/fastboot.h        | 10 ++++++++
 4 files changed, 79 insertions(+), 48 deletions(-)

diff --git a/cmd/fastboot.c b/cmd/fastboot.c
index f3929f88dfa..ace877b6e28 100644
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
 
@@ -27,6 +24,7 @@ static int do_fastboot_udp(int argc, char *const argv[],
 		return CMD_RET_FAILURE;
 	}
 
+	fastboot_init((void *)buf_addr, buf_size);
 	err = net_loop(FASTBOOT_UDP);
 
 	if (err < 0) {
@@ -47,6 +45,7 @@ static int do_fastboot_tcp(int argc, char *const argv[],
 		return CMD_RET_FAILURE;
 	}
 
+	fastboot_init((void *)buf_addr, buf_size);
 	err = net_loop(FASTBOOT_TCP);
 
 	if (err < 0) {
@@ -63,7 +62,6 @@ static int do_fastboot_usb(int argc, char *const argv[],
 {
 	int controller_index;
 	char *usb_controller;
-	struct udevice *udc;
 	char *endp;
 	int ret;
 
@@ -82,48 +80,9 @@ static int do_fastboot_usb(int argc, char *const argv[],
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
+	ret = fastboot_usb_run(controller_index, (void *)buf_addr, buf_size);
 
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
-
-	return ret;
+	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
 }
 
 static int do_fastboot(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -167,8 +126,6 @@ NXTARG:
 		return CMD_RET_USAGE;
 	}
 
-	fastboot_init((void *)buf_addr, buf_size);
-
 #if CONFIG_IS_ENABLED(NET_LEGACY)
 	if (!strcmp(argv[1], "udp"))
 		return do_fastboot_udp(argc, argv, buf_addr, buf_size);
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
index 00000000000..ecb27f28362
--- /dev/null
+++ b/drivers/fastboot/fb_usb.c
@@ -0,0 +1,63 @@
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
+int fastboot_usb_run(int controller_index, void *buf_addr, u32 buf_size)
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
+err_unregister:
+	g_dnl_unregister();
+	g_dnl_clear_detach();
+err_put:
+	udc_device_put(udc);
+
+	return ret;
+}
diff --git a/include/fastboot.h b/include/fastboot.h
index b106d617749..f02d2559f2b 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -125,6 +125,16 @@ void fastboot_set_progress_callback(void (*progress)(const char *msg));
  */
 void fastboot_init(void *buf_addr, u32 buf_size);
 
+/**
+ * fastboot_usb_run() - run a USB fastboot session
+ *
+ * @controller_index: USB gadget controller index
+ * @buf_addr: Pointer to download buffer, or NULL for default
+ * @buf_size: Size of download buffer, or zero for default
+ * Return: 0 on success, or a negative error code
+ */
+int fastboot_usb_run(int controller_index, void *buf_addr, u32 buf_size);
+
 /**
  * fastboot_boot() - Execute fastboot boot command
  *

-- 
2.55.0


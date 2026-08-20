Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957D2C5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 18:09:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BF0F80F0B;
	Thu, 20 Aug 2026 18:09:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XQZ8aQKay-7I; Thu, 20 Aug 2026 18:09:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787249342;
	bh=uaybY7nknxTC+Dm/PjfOXMSVBj+qaoHp8TeeSdjtdPo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WByzSY7r7RvvL9lGoTdZQsCkar3UnNda/+uVFmo8Fl1bVf8Q/O5I769bP50dJSH+j
	 72BybUCuGD7uv7WjL1j9ubIS+u0t5SdR5LLZ7I4LcqsAkQNGScbJquRpDdfy/uYCT8
	 kZzOyfQkq4pPwOBKwIqbDmVU/3PI88wURqLzMCAgpoBf3pE2BFIKyDW2nxDD7N7Wjj
	 6Z7iIGMtB5zmKME4rEXrCSPZpZxP9UiBxshciS72aVRWk456UVVvBj4dpih/fIV8gs
	 nwCMCODk77J3fW99hCYm/hUUysskPIlSsc68I70/SCQaQXUPcucS21IRl4p7meljEM
	 sG+b2cS8OcQVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CBE780F00;
	Thu, 20 Aug 2026 18:09:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 020B7279
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:09:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D7E2B80F00
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:09:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lEcF33VgDfpl for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 18:09:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Cejcmqm5
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DCF5980EFC
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:08:58 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47f71156e1aso101065f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787249337; x=1787854137;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uaybY7nknxTC+Dm/PjfOXMSVBj+qaoHp8TeeSdjtdPo=;
 b=Cejcmqm5/pFu/GiwTry/4HdvjVs8bjt25kYYuBLEJEevnPTNR049QMGudOyd37KGD1
 8MSzfskf37SI8eBEsX5CW3q3SGKuUeyfZPc3jHnHlz+sh9vskzQDjNihfyjCZAPtZPYR
 x6cPakRbcUboNHT9GwYN4Xp9dHKYzG4Qs5EzpT4KK9lBl/eWmDane6e6UDGQb0y+H2r6
 24vggYiNrupm2CTjc+vtDX4WrrugJ4raKU1WDLBEA3Dd4TIBrIxCUPhSdngGt6dqy3kJ
 OapO5mnUVFhhpUNbGl4tqsbltsJJRDxF2O/Na4i7DuwJsVIcjsTs08ay+ttwtDv7R+yC
 CXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787249337; x=1787854137;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uaybY7nknxTC+Dm/PjfOXMSVBj+qaoHp8TeeSdjtdPo=;
 b=m6uSRQV8uYKKmuo/T8j7WmnVbQWbsPAjCzrYPeppkioeWKe/kmuCFOWrBjtVysqCgE
 q20OpNijwbGOiyDIZfeNQL4Zu2iXBYE1c5o+sOG/UnYB5MyhBH+eGwnPSYPbXG4O+UZn
 zz87+7K3TAfDBJrCxvk7PwC8lc0L8kfzoS+j0utYiAieN70ssRdk9AprQNypUlRZSVFN
 Xu2j1qzSsAPjCyfKuuz0JyRz5Q55KGwzHRN8+dSsFW0XOryHQYSQNT6NmR3J5J0Ad9uS
 2Es3HpjF20XXQqe/vf+o3Ss2QrsBCBe2/Libz8DtHw46HRkEw64J6IVePnMQR7Im+VEP
 xFUg==
X-Gm-Message-State: AFuF++lHCvF5qORhW7Zl5LQZamC9hhC+tdWcKlkCwEROj2qNhshZQ0M/
 c9/c2CNAMTBXixnhmMYhzOm8G7qyysZObfru46pqOn3f+971DgJU5GSrBMx9jH+JwkA=
X-Gm-Gg: AR+sD10NM7pz4hGASs0CUrrXPL0SFCblm9HJotFXTVoVfjgR5f1SZY9J9Llx9efDjhT
 /jkqSygzm/TTr/9WeGXwNVdR3aYdT49e38/7MlaSeCvjoHEIJt3CfVKXbxC0oe3FKIk1ZiyM3KP
 aPWlcf31D4gSvEs+pXCCFkwket/EHujcKPxL4+LVbR27nTtIPKQJNmCbLGDyA8+hbdsw042pVR7
 m/Xg3bcIwfadzqQL2FkYD3GdnCPzAlZtciXIz+BHBO9Miqyl/4O+qUtiFZMLD1/gGoBdkLinBr3
 enNIoaS9yl+/sgjVIdwMVjOjAPSmTJn8mBk6Q7Ii7d8xG9z0bZ6r0p1lyd5wx/hbhS90qT4G68P
 mm3CFZtml+auGda2Uut9p/YfSzHw62LDh64ZM7kn1OwtWRszw/o4YNKB7wYR4RYX0e960YEsVU+
 5SkkOK/Ebm/zwBvbY6GAaS46UR8a66o1TOngnCwyqPFQhvjI0nRxR5hZgiX5OH1l72nepjUO78h
 0Gy0n6TW/WWGjWCyuxXriaXQoRrGS8nT7b1hc+KMUpV7zuu8TRJc08Y1tY7wku053OClsFhERxs
 8Ba1TA==
X-Received: by 2002:a05:6000:2502:b0:481:5276:e4e3 with SMTP id
 ffacd0b85a97d-482c0b908fcmr1012385f8f.19.1787249336500; 
 Thu, 20 Aug 2026 11:08:56 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.retail.telecomitalia.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14c33b3sm13443810f8f.27.2026.08.20.11.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 11:08:56 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 20 Aug 2026 20:08:25 +0200
Subject: [PATCH v4 1/5] fastboot: factor out the USB session runner
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-ccaione-upstream-spl-fastboot-v4-1-57e5ef71c74d@baylibre.com>
References: <20260820-ccaione-upstream-spl-fastboot-v4-0-57e5ef71c74d@baylibre.com>
In-Reply-To: <20260820-ccaione-upstream-spl-fastboot-v4-0-57e5ef71c74d@baylibre.com>
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
 Marek Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.16.0
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
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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


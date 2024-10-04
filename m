Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4D8CFA775
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 12:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5D8C88F95;
	Fri,  4 Oct 2024 14:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LsiwWcYD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88D0588E7A; Fri,  4 Oct 2024 14:47:05 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F4BA88CD9
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 14:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37cc846fbc4so1614149f8f.2
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 05:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728046018; x=1728650818; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vn2+BfheutMf+l9eZe69ihwSZBxCdMOQTK106+Jm50Y=;
 b=LsiwWcYDfdQnv7KzRN57whywXQwEKGbINYxhJ45fm9OQBVWnfFMNROoo3U+eC/dmFE
 RUzLCsef7K9jKy0id7cg4LvdNw0iN2XmMoBzzopvxj0IdvSm0+GEq0jsWhMbzNsGtFsM
 j3jZ7PpxIj+8OK2fantOKyryr1Jx6QXox1/UBqo5eQBNsHMXk49/4cI20y622QujP92E
 bj/O2cgnCt0hwndLXSDyEqhgYWXn35hTC9CCeg29UWBSZV1lX4uw5/7kHXV2n/OrTYzy
 La9XHVKCfdWH6koa2bJdDoeQpbRXloFakTKxhFf/cGL2JXKmS2YZnC0HscsPby1F39/p
 6Eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728046018; x=1728650818;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vn2+BfheutMf+l9eZe69ihwSZBxCdMOQTK106+Jm50Y=;
 b=uqJ8wZ/8eew5FPmsgmbM1lP1S98LEZnAgyLR6243vNSyoWYzHVqe2zRol2sKrJuTp5
 iO+1Y0DYOun7Ay9K5fqBwXLe0o1eGt5jn29ewKgCneeW4/1UOULU8+Y8TGsJ1PhhgWLs
 KSlWyemInj3EObcgPohHKSI1FRnAPy9JM45A4OQQEhEk/9xlwlzRcamz1Npb2thNH95J
 KhYANVY4kUQb4GdbMGD+1qBdwc25KIMhe071RRrI9UFaan9YQeE4gem0mQsqZYSp9EbC
 qOGK1TIx74FgvcfLoFIeAfFurj8cSUB5H9GTL6cjIOQkzbaw0AXs9zs5QXLU/PAZ5V8Y
 7tvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWITBhMSSiSbxud9kJ1g5E3FJJiBSj2l2xBm3Imrk74bPifK7iJp4aVfv7rgMX3MikJxOJX3Qg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1Mwa2wwmWBjVVdGznDxKgzeE5zSo/leh4BCfXraq1GXJt5K8e
 9xfjR2ENUiv8tNPrQ+ZYAlvx+6aqM3OWJs/AAja50PPo+/aawDiUBtIdAGg2HF0=
X-Google-Smtp-Source: AGHT+IFGxcmDuO2LEviHT3zi5gO6hP2SwSu+b8kYA/JNYFGyvP4U4BVrnCv7UHt+zkgQaQ+0Lr7caA==
X-Received: by 2002:a5d:4587:0:b0:37c:d2c7:70a5 with SMTP id
 ffacd0b85a97d-37d0eae68demr1682233f8f.57.1728046017877; 
 Fri, 04 Oct 2024 05:46:57 -0700 (PDT)
Received: from [192.168.2.2] ([82.195.86.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d082d116asm3177348f8f.90.2024.10.04.05.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 05:46:57 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 04 Oct 2024 14:46:50 +0200
Subject: [PATCH v2 1/4] board/qualcomm: introduce phone config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-qcom-phones-v2-1-c7ab67ac3043@linaro.org>
References: <20241004-qcom-phones-v2-0-c7ab67ac3043@linaro.org>
In-Reply-To: <20241004-qcom-phones-v2-0-c7ab67ac3043@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3156;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=oaxI/EQz3tOWK4aTm6eAN5u+sr/5yFWJiMS39p/B9h4=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBm/+O99EHIDPkb2geiMmBYbaNUfXVpbX+f6ZdHG
 bYrDabJpfuJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZv/jvQAKCRAFgzErGV9k
 thJ1EACHy6OGsqshwi1XEtWkUEfPNiXQf31vHhk5U+Egjxd7HgwZW6ClutpFIvHk1NOLlY9iiVm
 zswTcx5muhGPaPAaZS2SwVVCPHNNqxzpr9gBIGIFGHTLhi/r9oI1VYqPxog7L6o6ZzkeHFmRzuK
 SAfAnjdH+2G7eM/ppdhgpg0j7A2Zme+ZNXb7/LOeTAatEyjbhVA6Tqoe5CMkbYAXCnbaN7LJCX7
 5mam5NKXlIzA6LXHBAZmWLV3bh7P7dd9N9sGFFCMZr0ooi3O0iWx8Cfg3DG3M5tYsGLqbkzhSb/
 1GtUpDBAfy7Rgh7s1o8V3NeZg9Uja6xdQ0VFMmgWCS/4/qvvxk9qXT0OGNJdTb2nrtwWlbFBA7I
 6yfan5s8AZQAN5QbvzF/TyJGSRHKAHRiIQY0Up9lmCST58CCwdeeLnFL/JO29h33ZJ3p+ElUC1J
 QOES1sAFc3Mk/0REnepYWufHncQgY2fdsrgT6JNAuTsNJSrZOjBRavqcvOy1NEXyytZaRgTkXvz
 AvR6qruedJQGqshhNA6DquRWw7nMuLG0r6eeiYePOjKPq0n++u9HwxaLKaVycAl0k3YBxE0BeBX
 6qLMTuyDZ3giLuQ/VbEFaujCH2OZCvm229IwpFhK4n/gjZMrfNSttoCHJ5b+5u6Hjh6YWjf8k+H
 OR4x5oZ6XVcM4Ew==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Phones don't have keyboards! Introduce a phone-specific config fragment
and associated environment file to make U-Boot more useful on these
devices. This allows for navigating via the buttons and enabling
various USB gadget modes or displaying info about U-Boot.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 board/qualcomm/qcom-phone.config | 12 ++++++++++
 board/qualcomm/qcom-phone.env    | 49 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/board/qualcomm/qcom-phone.config b/board/qualcomm/qcom-phone.config
new file mode 100644
index 000000000000..388d4c3e7398
--- /dev/null
+++ b/board/qualcomm/qcom-phone.config
@@ -0,0 +1,12 @@
+# Settings for phones
+CONFIG_USE_DEFAULT_ENV_FILE=y
+CONFIG_DEFAULT_ENV_FILE="board/qualcomm/qcom-phone.env"
+CONFIG_PANIC_HANG=y
+CONFIG_CMD_PAUSE=y
+CONFIG_BOOTSTD=y
+CONFIG_BOOT_RETRY=y
+CONFIG_BOOT_RETRY_TIME=1
+CONFIG_BUTTON_REMAP_PHONE_KEYS=y
+
+# Many phones don't actually define a serial port in their DTS
+# CONFIG_REQUIRE_SERIAL_CONSOLE is not set
diff --git a/board/qualcomm/qcom-phone.env b/board/qualcomm/qcom-phone.env
new file mode 100644
index 000000000000..2a0791c888c6
--- /dev/null
+++ b/board/qualcomm/qcom-phone.env
@@ -0,0 +1,49 @@
+bootdelay=0
+bootretry=1
+stdin=serial,button-kbd
+stdout=serial,vidconsole
+stderr=serial,vidconsole
+
+# Fastboot is keen to use the address from kconfig, but we
+# allocate its buffer at runtime.
+fastboot=fastboot -l $fastboot_addr_r usb 0
+
+# Shortcut to enable USB serial gadget and disable bootretry
+serial_gadget=setenv stdin serial,button-kbd,usbacm; \
+	setenv stdout serial,vidconsole,usbacm; \
+	setenv stderr serial,vidconsole,usbacm; \
+	setenv bootretry -1; \
+	echo Enabled U-Boot console serial gadget
+
+# bootretry will run this command over and over, if we fail once
+# then bail out to the boot menu instead (with a pause to read
+# the error message)
+bootcmd=bootefi bootmgr; pause; run menucmd
+
+# When entering the menu (either from button press or failed boot)
+# remap bootcmd so it will re-open the menu and we won't get stuck
+# at the console with no way to type
+menucmd=setenv bootcmd run menucmd; bootmenu -1
+
+# Pause is used so the output can be read on the display
+bootmenu_0=Boot=bootefi bootmgr; pause
+bootmenu_1=Enable serial console gadget=run serial_gadget
+bootmenu_2=Enable USB mass storage=ums 0 scsi 0
+bootmenu_3=Reset device=reset
+bootmenu_4=Dump clocks=clk dump; pause
+bootmenu_5=Dump environment=printenv; pause
+bootmenu_6=Board info=bdinfo; pause
+bootmenu_7=Dump bootargs=fdt print /chosen bootargs; pause
+bootmenu_8=Enable fastboot mode=run fastboot
+# Disabling bootretry means we'll just drop the shell
+bootmenu_9=Drop to shell=setenv bootretry -1
+
+# Allow holding the power button while U-Boot loads to enter
+# the boot menu
+button_cmd_0_name=pwrkey
+button_cmd_0=run menucmd
+
+# Hold volume down to drop to a shell with the USB serial gadget
+# enabled for debugging
+button_cmd_1_name=Volume down
+button_cmd_1=run serial_gadget

-- 
2.46.2


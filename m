Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E373BC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 12:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F2EA81335;
	Tue, 11 Mar 2025 13:31:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e0l8azmK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B0A38083E; Tue, 11 Mar 2025 13:31:35 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 355B2807D7
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 13:31:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso59105125e9.1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 05:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741696293; x=1742301093; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z/3ClAUq5OeyZrPp0KPwDjqnSKUyusmhbhdHu/gu5JI=;
 b=e0l8azmKrb+J9Y2TBKyxd1shxxYU3QDyM5EOB84bGPa0eyPNty5Un20sE1fFFBEgwh
 MJDCvCUPKUMGReRzVynWvUPQ1c5VzB6EJVyUy5sY/uRkAAf1voNqR52s03MtZJYnyFTs
 hKXPVM48Q8xDng2L75Dw7bvLr7mLia0ieTS3R+ed6J1o0GY0kG2pee2ntBu+5QtwjDnl
 nGMmHlK40ZNWcglLEsuufcQS3pbgW1tJUz+rb65XP8jaw4sIJ62o9fVNKtjZvDn0qkVC
 focXBJqBMaY7gDrXn0fj2MKviBzEOO7sTGr80N5qX7zs4oyJz0X8h01P6JUJM4viFwaY
 MHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741696293; x=1742301093;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z/3ClAUq5OeyZrPp0KPwDjqnSKUyusmhbhdHu/gu5JI=;
 b=XFws1lr/LzJIlmJXqDTALzNwhYW3lX/FG5YD3Ob2kjDHUIfCSdVNxlBz0srMTJRWK/
 A2EgNlfjR7zHLM+8EjtgphfxR0zoTkxPtcBwKyyf6g6qgVXV3tAIlHdCt762Ki1SJAly
 I2DzJpyMi+ypwSh1T76IxrMDMkz8k0riX0p22MA1O1IWP1jRwnDtCT63uoztBxqdaGrY
 rtU1dMc2eBlk5JOdEhyMSvQ38XZSwNAQ8NLVmw8iP7EiRg1TwmLzZ1iB6+xD9zONils8
 sByPmOFcyMYggOBkaspFEAcVgkLFZYbJzYJgbVpUWXAkWVE6FShqh4I5XaH7CSVzhfe2
 5GbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjzmcSeBBTUhUuXFUADM1fYmKodFDEmLWGC67kfs2YmUQKiy7fyYzZSN+chjN64ESl71DJrxc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/RUBCzsdUS2FonqcK1tj0dukGhETa7q71fvs7FfsnxcqIhdZP
 qAbzbhTP/7+v4cZsJyWZxPVgDb+pzdH5gBW3Ww3t44ys/esQR5lQ7xPdMPxqMMLkTvL84sV44hi
 ENLA=
X-Gm-Gg: ASbGnct8/38BssLXmfQa6/X+S3lzDeWZ8Kp28U9mefx0yliLP90IBodp+2T85b6VOxr
 PWwqnaGu5E4DvKLBTKlJF2T8qiAJ2CizGwLz7hurDvlHRyppmCJQk3T5p2rEgNDplqEIs1Cubvh
 FEbm5tNclFBejOiZRZI02cu3kbOcOO3iFNfhDMoDhmDV65nxprHSGlraedQCOJZG0L/mA1E07ON
 WzODryKHKPCt+8wDSSTRqnkZdIZrTtxJE68f77akgDUzG5OoF/gYbN0AG4d1PfH1f7UY2fp2+AX
 KfanJpT6PmZi5s/thnQFZaGK+SiTnWB1CQ/kZ+Xdi7SSnmQPMnzFt5z++f3/5lphpapFknRK
X-Google-Smtp-Source: AGHT+IEfrAH9EhS3k7fSAx8He8PsvlhZ7AxsAhcyvD1cWiz9lPg9eZ2SRJTNQW1RxhJfAqc0AUe68g==
X-Received: by 2002:adf:9b84:0:b0:390:d82d:6d4f with SMTP id
 ffacd0b85a97d-39132db8b85mr12407344f8f.52.1741696292549; 
 Tue, 11 Mar 2025 05:31:32 -0700 (PDT)
Received: from toyger.rex.connolly.tech
 ([2a0a:ef40:1d11:ab01:f578:9a7d:3957:bef9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2f44sm17788586f8f.76.2025.03.11.05.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:31:31 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 11 Mar 2025 12:31:16 +0000
Subject: [PATCH v2 1/4] board/qualcomm: introduce phone config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-qcom-phones-v2-1-83dcd88a6a87@linaro.org>
References: <20250311-qcom-phones-v2-0-83dcd88a6a87@linaro.org>
In-Reply-To: <20250311-qcom-phones-v2-0-83dcd88a6a87@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3538;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=OimZ0f6C9wAt4PuxYJ8WzRz9KXKlABRuVoGG3PNW+LY=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn0C0higldwAIWVC18P3ddQtAdtl1EDsCpnw4HP
 ZRAqqfDHNKJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ9AtIQAKCRAFgzErGV9k
 tmcfEACJFNhs3jvYDPdACNHjymmXPWID0d8r/c8UfBhcXEE2p89R/YROOVg/LlAzn4/DxJ6LZd7
 zWdpfTovGPqE63RvtqL5dd/IWKvKfvxGyKCxpt6cbcrsX9E8YU2skVUf/7ojMYG2nbtK7cMBFpg
 FCRWKIbaRjqlbeF6343WUev6FEnO1UYD8xXjvo0yN+iBHb/Y0OrC6Tg5+0v5FluzplL56iIeOGj
 pTlXvUamGqiMgyhB0UKXuEuZ9iDdJq7q0u0k8tW0+sMkGTV8VeqOgLBIRafPEqgIN4BDk3zR8Bl
 RwAgAf1ZKqZzZIOw38cQ8UR4DSV55M4Um1VyKoAicasCNPecoWCrVdipqLB78B7QtzPDbWjPdRI
 IWgCB/dMJZNGjE5TEvOaIPY1TJ2mN3BOWSrPvffYE8bdTBtotD5ynFhrpnSOkcv7SfSJTnVXvli
 qKx/O9s29nO5vbmHZwpps/72Y9xRKi8rAew6mHWLKzC/U1IvtOdB4PvYGbcl7laA5q6Rk0ImTco
 vBWPIyRwFjqc9LeboHbdFVCOkbWfQzjYZgq66HYPEupHKY7gr5CnU7cC7aU7N45XpfrIjVkN3EJ
 Wf/m5h0Hqf1J46Xks8+vD9W0edsqQ849i2Xl5PFXhApkENyqqSt0BnPwwSyVlu6a20u7xDnGPRx
 nuB/CYuf/vroOpw==
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 board/qualcomm/qcom-phone.config | 17 ++++++++++++++
 board/qualcomm/qcom-phone.env    | 49 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/board/qualcomm/qcom-phone.config b/board/qualcomm/qcom-phone.config
new file mode 100644
index 0000000000000000000000000000000000000000..a2aa882285b61746a243a7a1c7c384f33839f1b2
--- /dev/null
+++ b/board/qualcomm/qcom-phone.config
@@ -0,0 +1,17 @@
+# Settings for phones
+CONFIG_DEFAULT_ENV_FILE="board/qualcomm/qcom-phone.env"
+# Hang on panic so the error message can be read
+CONFIG_PANIC_HANG=y
+# We use pause in various places to allow text to be read
+# before it scrolls off the screen
+CONFIG_CMD_PAUSE=y
+CONFIG_BOOT_RETRY=y
+CONFIG_BOOT_RETRY_TIME=1
+CONFIG_BUTTON_REMAP_PHONE_KEYS=y
+CONFIG_RETRY_BOOTCMD=y
+CONFIG_FASTBOOT_BUF_ADDR=0x1A000000
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_USB_FUNCTION_ACM=y
+
+# Many phones don't actually define a serial port in their DTS
+# CONFIG_REQUIRE_SERIAL_CONSOLE is not set
diff --git a/board/qualcomm/qcom-phone.env b/board/qualcomm/qcom-phone.env
new file mode 100644
index 0000000000000000000000000000000000000000..2a0791c888c62b9f2257448358dd196a02e4b6fb
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
2.48.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C09C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C14C68171B;
	Mon, 31 Mar 2025 14:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d1LZ+FLg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF35481E6C; Mon, 31 Mar 2025 14:23:47 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD30581703
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c1ef4ae3aso230669f8f.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743423825; x=1744028625; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=we7PibkephOQgPlnnIohr624gD+OOIg7UHnG+7S2GSc=;
 b=d1LZ+FLg2fdJ4Yi2GNr9sSZHy/sobDenlmS+7hNcu+YJlTVgCUIQED1H5tfiTMeE2N
 q9ThRy0vVfFqIzIaCoeAHwNzcCrmiKD9NlKg2goOv3t49ydK6f2dkeWhx8d0u7yMRKmt
 QOO3qhUjxFvPa1EFb1MjUp9Uf2TiYfO1bOAevc+n5muepWJ2jGd49sPk1jwH0fFieNxB
 ESF5BOxf6xjxvPCK3Nv1AndAIBehqNAu3GO3eMh4i4cHxRenYQG7TgdsIUuiwDabfrgy
 Q8UzUomUMTaezgWEQlH1taQQB3Y3QuYekGjcinv1JJTkFv/cyRiCXqSa2YZnH+7oV0Fm
 9jRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743423825; x=1744028625;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=we7PibkephOQgPlnnIohr624gD+OOIg7UHnG+7S2GSc=;
 b=YzcNQb8BXDmpVCIpe4Je6ak1m1SnqeDGune+LjKeNo44uTqK4jRgMqdJN9Xi8LQNMG
 GcFUmsiZs/fzo54RURPDLy4XvHyupPZxKLzU+Q/uTFsqNebHpRjJ5ZTKEek1R/BUYPna
 BKeJv0ZGVB7KN5AvBiEZK3JSvr6OB9Eo4FzhwS/8ptbvegaIYLq0Ph/KXf663DyZHE4e
 Fl3WeJTzHMhnXeRNcOzyEk7+tCdC5J/YKe9z6dVMmJpRso3i+EzpZ71P12hrsiiTN1j0
 8nhxi5NfTvMm1w8FRiHSQ5lGPVqrJOFhGoDRhXgZcYUFYKlKotkntgVq5kDexgxOLx2p
 CxAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg8atWtrt7tyPgwAga0ZcUNEdnXc5AdEFf9XbWRsANBW+U9Ufy9Pi7+q5c44R93X9LlQnPRUU=@lists.denx.de
X-Gm-Message-State: AOJu0YwH5MmJ6j96CZT2KgEI+tnKlFfgC9x0FwUzkYsXsor+ZYxUtajT
 6x/J/XrtuXoABbaufHi4BAlDTnQe21i1raiIduFIUtDdLe6/n9hfSpN0VBsMxMA=
X-Gm-Gg: ASbGncsZI+CjcLVOwW7ii6piP7AUDJkcenlZyqgOROkkQfoxrfROGoPaUh5QHE9HKkZ
 32iK/m3aP2HBDrrANHvNypeYODf48kxhM8BbSQRMkJdmGy+iuoVL+sP303hhwWeDvtXEbIxC9JS
 vLk8ryWpsjN6XigcFiwpTXPveT7LH/kukvw8BsQZOJX9fY20aezHfcOys62oQZkm/klwTxU4Yxy
 7L7xEBxzLumV/5pRdTIXDCvF/2c2L5u9146VgzkA/vBX1nizWOsXRWQmNi4LPMCgeOOv0JbagZl
 ITTbF8jkF3v5pJ6MKQbEBglJchWr7PKY+74G4Wg5BJ0AgjmBITr16RAPENiaEbXooCEpWg/heUc
 wz/oajZH9dgXZ
X-Google-Smtp-Source: AGHT+IEP0sRk5/nhDcapYS1Tuu1Uzcq0bsFUxTTJzFIZAtR4/7IhVMcfBJfCDNI/b5OyC7zpMoDl+A==
X-Received: by 2002:adf:b652:0:b0:39c:1f02:44d8 with SMTP id
 ffacd0b85a97d-39c1f024554mr1353608f8f.4.1743423825008; 
 Mon, 31 Mar 2025 05:23:45 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b60a9ddsm11315562f8f.0.2025.03.31.05.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:23:44 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 31 Mar 2025 14:23:18 +0200
Subject: [PATCH v4 1/6] board/qualcomm: introduce phone config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-qcom-phones-v4-1-f52e57d3b8c6@linaro.org>
References: <20250331-qcom-phones-v4-0-f52e57d3b8c6@linaro.org>
In-Reply-To: <20250331-qcom-phones-v4-0-f52e57d3b8c6@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Danila Tikhonov <danila@jiaxyga.com>, 
 Jens Reidel <adrian@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4059;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ZSSOLzZkZoQcy0pdLHHbFaldbtKdpjA4S1ZYfRGANHQ=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn6olMVx5ubDgOfKXfzLNH6DYNnVDobEQ7SbOg0
 jCRkC1JPWKJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+qJTAAKCRAFgzErGV9k
 tk4+D/94Dw0Bu2vdD8IMpuToB/ySNxuO0BWuHIm6OSjiCeuns4cvdR9Nomkkbhg7oEK/5J+E75I
 HrZlPMUCFkXUHqqMf80/kKpVIM8Tgei6FH/qzkkT5wOojd2Z+tXhKHZxOs92eEakH7jDCoJMBio
 cB4TQDngeaiJkDSILMO+5+3sKB985urT1H+kB0pZMsrJzB3iCVjSoveqPm5IfjN1bsr2TUwKFmG
 CayoSNgd7aYDCoEoQMvrIB8nzy8L1JjoUhrHK+amaF91xB5iCKdjuFjEbvthTnfiqJ/J4FOO3Wm
 I566ViUvkWL185YEqhX7aWDzoYfjsGoq+d9FEDM6FtEZ0OxPMdc2ZtL/IQ9nlLUMz8RnNiwVM/t
 yhyFVI6UEThNOLSmnLis4Ca4uFank0dCJijLQOQWGMCnxeuAFHGAWnyoBGKqMLNjLodbEygUYNg
 PtdbrtcUl+H2p+4xemFFwmjqiF2CW0KCrinldEi5Zp/mDOnyp02WZADwhr6Ve0+cnjfcXHpvZnX
 j8Vh3UNzs83Hfqo+Y1tIQ+78MR5BMKMBs6JyvcSeLeSZuT+JNzP4rIdwy3uAfiOuRWMf4qz68qH
 Ry3mxgyz/R8YC9dk7qtGPxofoazRc8uN7bhpkVdUno6MPM2hUJXcSXKQBUant/apRUNIpQUJVSx
 OJo9zwyYCgUeaVA==
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
Tested-by: Danila Tikhonov <danila@jiaxyga.com> # google-sunfish
Tested-by: Jens Reidel <adrian@mainlining.org> # xiaomi-davinci
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 board/qualcomm/qcom-phone.config | 29 +++++++++++++++++++++++++
 board/qualcomm/qcom-phone.env    | 47 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/board/qualcomm/qcom-phone.config b/board/qualcomm/qcom-phone.config
new file mode 100644
index 0000000000000000000000000000000000000000..913c91757c1d77b79b5997597917f9ac002049fb
--- /dev/null
+++ b/board/qualcomm/qcom-phone.config
@@ -0,0 +1,29 @@
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
+CONFIG_CMD_UMS_ABORT_KEYED=y
+
+# Record all console output and let it be dumped via fastboot
+CONFIG_CONSOLE_RECORD=y
+CONFIG_CONSOLE_RECORD_INIT_F=y
+CONFIG_CONSOLE_RECORD_OUT_SIZE=0x6000
+CONFIG_FASTBOOT_CMD_OEM_CONSOLE=y
+
+# Only MMC is supported by fastboot currently, but this is still useful.
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_OEM_RUN=y
+
+# Many phones don't actually define a serial port in their DTS
+# CONFIG_REQUIRE_SERIAL_CONSOLE is not set
diff --git a/board/qualcomm/qcom-phone.env b/board/qualcomm/qcom-phone.env
new file mode 100644
index 0000000000000000000000000000000000000000..6750b6daaed8695faa2fbe1546c1582713f7d56f
--- /dev/null
+++ b/board/qualcomm/qcom-phone.env
@@ -0,0 +1,47 @@
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
+# Always probe for UFS storage, though it should be done by board code.
+preboot=scsi scan
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
+bootmenu_2=Enable USB mass storage=echo "Press any key to exit UMS mode"; ums 0 scsi 0
+bootmenu_3=Enable fastboot mode=run fastboot
+# Disabling bootretry means we'll just drop the shell
+bootmenu_4=Drop to shell=setenv bootretry -1
+bootmenu_5=Reset device=reset
+bootmenu_6=Dump clocks=clk dump; pause
+bootmenu_7=Dump environment=printenv; pause
+bootmenu_8=Board info=bdinfo; pause
+bootmenu_9=Dump bootargs=fdt print /chosen bootargs; pause
+
+# Allow holding the power button while U-Boot loads to enter
+# the boot menu
+button_cmd_0_name=Volume Down
+button_cmd_0=run menucmd

-- 
2.49.0


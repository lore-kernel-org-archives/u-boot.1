Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE280C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:11:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 194F48766D;
	Tue, 21 Nov 2023 18:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fp75jqNK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A64287646; Tue, 21 Nov 2023 18:09:46 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 838758762E
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4083f613275so27896825e9.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700586578; x=1701191378; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cuDyH9qQjoeTYInpWsRWSX0M+bQu/2nDBUa8uJVGGY0=;
 b=fp75jqNKCEIR+uMEWiU3IQy72ZauXzNHWScxOk9zK6yGvFT753qlxDL0QFjfnlM/By
 aS4weqDvd8+koy4T3ux0fhYt+E3sssmMDjji/iC9rctfh8OItE6Rre2paQOcNPxyeE/q
 +yAFjycoeG0+OiTqbcvhMFbpqkIEeAF7U3xUpcK0ZDLMNT9PbtfIV7HSULeq+zhIK0iN
 Uw1+fY8ftGn6YyeGp4GSNftJ2B+inLTFYFoTHWUODXd8gRQxJKd66d91uQ0bgfGJmymY
 OhOa7ePBCLdt2VPPbW8NakyZCBvRntETs/Hiu/gcOE93BU0UYuSG0iQE1+vio2NfQMwR
 XcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700586578; x=1701191378;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cuDyH9qQjoeTYInpWsRWSX0M+bQu/2nDBUa8uJVGGY0=;
 b=aTXIRikUbLQXhyrKJ0se4VjpASSJyIp6SzLV3IfsLlwPa6AduWskrLzIemTMO/Z4kP
 yUY4dLZrgKukgfMPmb2BnzE2+tOj3D98VDymlwI0ndWb84cSt80FNEr7dWKkpdunS/WR
 T6d6fM1HJmJZA51wA03QZ0ALyzoLvaCGHoiUYQNQW6C1Kk9F2veyEHS+vVUaY9JE0Xho
 8QT6x2pzmaB3O76frRM957DCS9sUb21lUksG2YMSEzISxnROWstg1moh62HcftSB6Dmw
 z/kyQkZP7/OBAucg2ufUA0NS+celOBvsJYU/6xJN7EKt06Mt6tzAguWEABif8mQ1vLqZ
 AT+A==
X-Gm-Message-State: AOJu0YxIxvP30ok3q2X0DLUw/B6zegKB70mbgj42AFg2Iq2Hn8nN6EXt
 P/mdI5akClkXfXnOBXhOM5B+fg==
X-Google-Smtp-Source: AGHT+IFw959PFW9ClGB4Dolmj0ORArMBjuxp7KKrUWHoD7fKAcKKIbmoq1cZJ/SiP61QpVN36ZJXTg==
X-Received: by 2002:a05:600c:3555:b0:408:c6eb:9a87 with SMTP id
 i21-20020a05600c355500b00408c6eb9a87mr8791573wmq.24.1700586578006; 
 Tue, 21 Nov 2023 09:09:38 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b003fefb94ccc9sm17345812wmo.11.2023.11.21.09.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:09:37 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 21 Nov 2023 17:09:32 +0000
Subject: [PATCH 09/21] configs: add dragonboard410c_chainloaded_defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-b4-qcom-common-target-v1-9-9492198e0c15@linaro.org>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
In-Reply-To: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=3115;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Q3bKO4YYPhoolM04FTyJ4iGxI6rASlcW35wdWZMbels=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSYJ27hn0P419/rVmw9fC6/1tnz9wcNny+t9x1uRL+a/
 iTxWNmvjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRY7UM/4zF33N4K+UdPvHQ
 nGfDQalvip+OOqx6Vdu/ZYdPzY5zbtMZGeZFKR84dOPfr9nHWF44nHyXGHbEbepWlYZlk2b2dO9
 5tuMeAA==
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

Revive support for booting db410c using the Linux kernel header, this
allows for testing the board more easily via `fastboot`.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 board/qualcomm/dragonboard410c/MAINTAINERS    |  1 +
 configs/dragonboard410c_chainloaded_defconfig | 75 +++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/board/qualcomm/dragonboard410c/MAINTAINERS b/board/qualcomm/dragonboard410c/MAINTAINERS
index e78f5b2d6421..653b91b44377 100644
--- a/board/qualcomm/dragonboard410c/MAINTAINERS
+++ b/board/qualcomm/dragonboard410c/MAINTAINERS
@@ -4,4 +4,5 @@ S:	Maintained
 F:	board/qualcomm/dragonboard410c/
 F:	include/configs/dragonboard410c.h
 F:	configs/dragonboard410c_defconfig
+F:	configs/dragonboard410c_chainloaded_defconfig
 F:	doc/board/qualcomm/dragonboard410c.rst
diff --git a/configs/dragonboard410c_chainloaded_defconfig b/configs/dragonboard410c_chainloaded_defconfig
new file mode 100644
index 000000000000..d6860f546e9e
--- /dev/null
+++ b/configs/dragonboard410c_chainloaded_defconfig
@@ -0,0 +1,75 @@
+CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=19000000
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_TARGET_QCOM=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_SYS_MALLOC_LEN=0x802000
+CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0x0
+CONFIG_DEFAULT_DEVICE_TREE="dragonboard410c"
+CONFIG_SYS_BOARD="dragonboard410c"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 410C"
+CONFIG_SYS_LOAD_ADDR=0x80080000
+CONFIG_REMAKE_ELF=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_FIT=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_PREBOOT=y
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_MISC_INIT_R=y
+CONFIG_LINUX_KERNEL_IMAGE_HEADER=y
+CONFIG_SYS_PROMPT="dragonboard410c => "
+CONFIG_SYS_MAXARGS=64
+CONFIG_SYS_CBSIZE=512
+CONFIG_SYS_PBSIZE=548
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_MD5SUM=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+CONFIG_BOOTP_BOOTFILESIZE=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIMER=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_CLK=y
+CONFIG_CLK_QCOM_APQ8016=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x91000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_MSM_GPIO=y
+CONFIG_QCOM_PMIC_GPIO=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_MSM=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_QCOM_APQ8016=y
+CONFIG_PINCONF=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_QCOM=y
+CONFIG_MSM_SERIAL=y
+CONFIG_SPMI_MSM=y
+CONFIG_BUTTON_QCOM_PMIC=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_MSM=y
+CONFIG_USB_ULPI_VIEWPORT=y
+CONFIG_USB_ULPI=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_ETHER_ASIX88179=y
+CONFIG_USB_ETHER_MCS7830=y
+CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
+CONFIG_USB_GADGET_PRODUCT_NUM=0xd00d
+CONFIG_CI_UDC=y

-- 
2.42.1


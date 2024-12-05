Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938D8E7716D
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 13:56:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF7DD88F2E;
	Thu,  5 Dec 2024 14:55:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="UOErjwm6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2C3D88C98; Thu,  5 Dec 2024 14:55:00 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4767489504
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 14:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5EA7A40005;
 Thu,  5 Dec 2024 13:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1733406893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AKnDGtWKZnOcyX7cCD/DdlNQooB0t7R5wRpfdwcqgYY=;
 b=UOErjwm6OUy6VhHdWy4lv0vbVl/memjzDtkJLaaOLSBtzsP/rxuYXtAm1F3kUi+byQOW6J
 c4vwlV+2CeYRMevwrOE3OkEzW8N/Gi6F6ee0dJQ0/MgFEsDlMN9oL88/1eY2vZKdHf448e
 W6Jf0mtbzWXM/djnMb76LjMwovxHod5IyemdmRUU82wUFonWq5e8Y87AUP8y0NCzxOueuv
 zNOQ7nqboLn+ZuIsrUS08OB/g8dqrIkPZXSxQ2udLsCU1ABZQO3fMOqt40EVco+FG5U07+
 /RGS0fpcXkdD0XGbW/gVDEy4G+R/tC2Q1/dkHJKPFN86vLq603AY+HRloklFvQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 05 Dec 2024 14:54:19 +0100
Subject: [PATCH v2 13/13] imx8mp_evk: Enable display support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-ge-mainline-display-support-v2-13-4683bb4388dc@bootlin.com>
References: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
In-Reply-To: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>, 
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-Sasl: miquel.raynal@bootlin.com
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

There is now support for the display pipeline using one LCD interface,
the LDB bridge and of course the related media power domain controls.

This is untested as I do not have the EVK but should be enough to use
the display, using bmp, lcdputs and co. For console-like commands, it
might be also needed to enable the VIDEO_CONSOLE explicitly using:

     setenv stdout serial,vidconsole0

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 configs/imx8mp_evk_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 5369f8b84a4172434dcef142c854d06e3437caf1..a3cdf0f3cb237d7b555a2dca741deee21b771e8c 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -31,6 +31,7 @@ CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="imx8mp-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
+# CONFIG_CONSOLE_MUX is not set
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x26000
 CONFIG_SPL_BOARD_INIT=y
@@ -60,6 +61,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
+# CONFIG_CMD_CLS is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
@@ -112,6 +114,7 @@ CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_IMX8M_POWER_DOMAIN=y
 CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
+CONFIG_IMX8MP_MEDIAMIX_BLKCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_PCA9450=y
 CONFIG_SPL_DM_PMIC_PCA9450=y
@@ -139,4 +142,8 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="FSL"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_VIDEO=y
+CONFIG_VIDEO_BRIDGE=y
+CONFIG_IMX_LDB=y
+CONFIG_IMX_LCDIF=y
 CONFIG_IMX_WATCHDOG=y

-- 
2.47.0


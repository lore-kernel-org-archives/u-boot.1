Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DF9E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 19:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D75A3800D0;
	Fri, 10 Jan 2025 20:11:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eJgTtOEb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9533A801F5; Fri, 10 Jan 2025 20:11:50 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71A7380050
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 20:11:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-540254357c8so2234383e87.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 11:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736536308; x=1737141108; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XUS2GeSio0d1EOOCKF9MbJtNtCC7l6NlQ3z1RIqyCqg=;
 b=eJgTtOEbTLSJUWFYzg+WkrqfxV2/CypiZNA7B9APc8RHqH65CfUvUU3wcjO5skeklE
 I/Zq9pt8x4zuht/aXPBqFby/SRJXOBYPJDzP4+ZD9bfMUYMinjRVm3ijjo3GagCbAOp1
 Tgz05CPJYR16BNKZo2FEmVrxnCuw8+6Z2VfPcrcCyg2/r4LxvjCkqTjR0WivFU9Y6Qph
 O7tFZIqZe5HXZm6KNnjrEwv4SUI7gzLYFqKRlWrsZ8hbKmbF30TDHhfki/5XwIUzxOqz
 NPpKkRyyI52litgrfeEWkrDBixIfaqb+Qk+ICNCvk5qyhALGer1KdX51M9RwTbkWMlXS
 KXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736536308; x=1737141108;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XUS2GeSio0d1EOOCKF9MbJtNtCC7l6NlQ3z1RIqyCqg=;
 b=XqdZNckar3uRyzLYKZGAH7ifqCURW1CPkKrA8WxHXf3waOMBC585jkJ1r+mdcUgix3
 f6AgO3vLyRY50SxQMcBZgc7FoGBmG4j/fZWQFqpci1799St/8QI9LJFcRQqbO+ac8ZGB
 3nLRNrr6wuT2v0kMoL/s91N0Qj1qfTj2K5zXf+V3gvSwAAzWyO7RxVmfkYgDZXgoryYO
 t0O2BFHzqy0sMUw1kTthelwZNlfzX5m3BX1XGhviwbQin8JgHzcJuSiN48iJR3M/cjK6
 eTQo5fxbQ5SKafK2BKF5GnW6L9mrhczXNPCttcOvOyk+eo3++8yRy03ftwguUa+BUuL/
 4k3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcQbqIoCX9r2qrEx8iQLyn1ImVJnf7Hb9rN9D2vXUH5/AcFgB9rnKfY9FLgKZ7fORLF6fA0T8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx60ww84h580Ww2k0yR+viLpMPWFd/D0DhLS99vwkvHySg1ve3a
 lTWnqH8RGuXQnzMIKzSqORiHcfrroglvIvbEged+wFFPOMn+Box0d4BJL26A5gw01EOH6J7HIe4
 YTqPvFYQ4Y2KEkq3ztYzQ3eQ6kmQ=
X-Gm-Gg: ASbGncuGgBtM5enDwFa+HJlBYVs/Gffs6yEK4K78Lh571Dypxy5+pcJYeGZzhVtVOXD
 8JcfdDrHghf8GZLCxlCfv3yRlR/lcCy/XkRYR+eWn50zUa9vJLaNbO7iRYJmkBTB+yi0upQ==
X-Google-Smtp-Source: AGHT+IE+7vViQ4fK/bBC2GEFORPYkclIdCsTIX2lSHIRms1vLSDQuZ5VXIsoIR7C84cp8gLuEvpRHLSnVJ7wawtez8U=
X-Received: by 2002:a05:6512:6cc:b0:53e:350a:729e with SMTP id
 2adb3069b0e04-542845b94d0mr4259955e87.35.1736536307559; Fri, 10 Jan 2025
 11:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
 <20250110-ge-mainline-display-support-v3-13-d2c0acea6feb@bootlin.com>
In-Reply-To: <20250110-ge-mainline-display-support-v3-13-d2c0acea6feb@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 10 Jan 2025 16:11:36 -0300
X-Gm-Features: AbW1kvYiVdbV_62VQwm9wvgYXOUfCwKTLl9F4wwQhl5miP0QPXiNQij_n5EiSTY
Message-ID: <CAOMZO5AdTLF867Zo7wp_SCQSeDRZihkqTi04aXN-hcDyNBiiRA@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] imx8mp_evk: Enable display support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Peng Fan <peng.fan@nxp.com>, 
 Mario Six <mario.six@gdsys.cc>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jan 10, 2025 at 3:43=E2=80=AFPM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> There is now support for the display pipeline using one LCD interface,
> the LDB bridge and of course the related media power domain controls.
>
> This is untested as I do not have the EVK but should be enough to use
> the display, using bmp, lcdputs and co. For console-like commands, it

Hmm, this cannot work. The upstream imx8mp-evk.dts does not have the
LDB enabled.


> might be also needed to enable the VIDEO_CONSOLE explicitly using:
>
>      setenv stdout serial,vidconsole0
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  configs/imx8mp_evk_defconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
> index 5369f8b84a4172434dcef142c854d06e3437caf1..a3cdf0f3cb237d7b555a2dca7=
41deee21b771e8c 100644
> --- a/configs/imx8mp_evk_defconfig
> +++ b/configs/imx8mp_evk_defconfig
> @@ -31,6 +31,7 @@ CONFIG_OF_SYSTEM_SETUP=3Dy
>  CONFIG_DEFAULT_FDT_FILE=3D"imx8mp-evk.dtb"
>  CONFIG_SYS_CBSIZE=3D2048
>  CONFIG_SYS_PBSIZE=3D2074
> +# CONFIG_CONSOLE_MUX is not set
>  CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x26000
>  CONFIG_SPL_BOARD_INIT=3Dy
> @@ -60,6 +61,7 @@ CONFIG_CMD_USB=3Dy
>  CONFIG_CMD_USB_SDP=3Dy
>  CONFIG_CMD_USB_MASS_STORAGE=3Dy
>  CONFIG_CMD_CACHE=3Dy
> +# CONFIG_CMD_CLS is not set
>  CONFIG_CMD_REGULATOR=3Dy
>  CONFIG_CMD_EXT4_WRITE=3Dy
>  CONFIG_OF_CONTROL=3Dy
> @@ -112,6 +114,7 @@ CONFIG_PINCTRL_IMX8M=3Dy
>  CONFIG_POWER_DOMAIN=3Dy
>  CONFIG_IMX8M_POWER_DOMAIN=3Dy
>  CONFIG_IMX8MP_HSIOMIX_BLKCTRL=3Dy
> +CONFIG_IMX8MP_MEDIAMIX_BLKCTRL=3Dy
>  CONFIG_DM_PMIC=3Dy
>  CONFIG_DM_PMIC_PCA9450=3Dy
>  CONFIG_SPL_DM_PMIC_PCA9450=3Dy
> @@ -139,4 +142,8 @@ CONFIG_USB_GADGET=3Dy
>  CONFIG_USB_GADGET_MANUFACTURER=3D"FSL"
>  CONFIG_USB_GADGET_VENDOR_NUM=3D0x0525
>  CONFIG_USB_GADGET_PRODUCT_NUM=3D0xa4a5
> +CONFIG_VIDEO=3Dy
> +CONFIG_VIDEO_BRIDGE=3Dy
> +CONFIG_IMX_LDB=3Dy
> +CONFIG_IMX_LCDIF=3Dy
>  CONFIG_IMX_WATCHDOG=3Dy
>
> --
> 2.47.0
>

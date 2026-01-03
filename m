Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544D5C2A063
	for <u-boot@archiver.kernel.org>; Sun,  4 Jan 2026 00:37:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A75A783AB7;
	Sun,  4 Jan 2026 01:37:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SdjFIXnp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 816A683B49; Sat,  3 Jan 2026 18:34:36 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC24183B1E
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 18:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a0d67f1877so169061695ad.2
 for <u-boot@lists.denx.de>; Sat, 03 Jan 2026 09:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767461672; x=1768066472; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2SNh2F3BECWSaFKbD07/xqaorh0vycM++poM2V6+84A=;
 b=SdjFIXnpY3FSsn0kuA+kvPRtdSL9gafFCx1nPZLA9vpnydlB7dukTMIxsFLP9zoU23
 zr+hGz1sBoU2ovPA8yozn3LYcE8kU7myQON2gHOvuTPnROPX09SZIAbnejSoqWFYdTRM
 EkJ+KpnVpk1H+KMcpqAPV+3H4jA/s1sv1q5l6AHrq/xpAIccdCUbG1uxzLxPcK3Bq+l2
 uF2vDpa5t70QR0i4M2QVXghrILSTBLfk65Ys/OSONLCGRaeawKIaLbCZoLPoUuSTRF8W
 PVeEMgfoXsn+U30hgjFOQQCBbLjiIqJw0g47cj62jSDqjzJbqIIXOQ5E2YQw18MkKWdG
 1dIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767461672; x=1768066472;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2SNh2F3BECWSaFKbD07/xqaorh0vycM++poM2V6+84A=;
 b=pLpUD1XvgXSGkuqiHHlih7/YX5uWYjRATpQT9l3AhDLBFLHkPrc1Dscr/yKy6Dm1FE
 MhLDbHYxqjZg+RYDgSG4LgkfLQmC/zS7SqDNYa0+hyXJVYOVI3oX4uCaLqHV6UoMVoFj
 gSTTKHryB0pZqzbqbiIcd5XW1UgorLUa1hJGv36I5V+bBKkrJvcDa+iaH3duKeOcFhjB
 POBsZPpFlrQXJcEOvg8UZ6mpm3vahr7umRSqyCs+AtYhiFQuTLijjQp6JBz2im1OS+SG
 AbJh+nR6mm6yXCCS/p9+18we6DjV5epXaquF4V/jExp2PY7avj+8ijjlEEAcGGq7OcMU
 vzEw==
X-Gm-Message-State: AOJu0Yxpsfhcv0vzw15RiS4Xe2BdCiWoEYpTVPrzmMure5ZJz4JYR4sE
 uBEsxSCUc0+IwMQYuEnG7emSXtWkad+qZ3vw1tWKjkMlEEEuqtiT8qXy
X-Gm-Gg: AY/fxX6jMK9nPds73DftBZ9ikUizhUU7Q9gi5rlK7w6j72XilWHE4QRFbfGZAsoDNhK
 svBu5qvLivQkt3gdZ7FHZqjw1LTEtdbMNJ1Gc/f5YOa4YHUsQgGRXlmWdQMY7V5pxiR16PQcdzO
 tnJ/+PJsUDzAoxEQj/td57GS9NNDVoGgf/lydoOvi6cwqb4nWNtjN8aXkpN/8WqSrL3Y9/zGOZO
 MfddXDODXz8W6ObITUIEwn6+Q5bNlVOQ7WTdNZYk2Y8rv83GGBUsxNQkIzJY8DjoxEtvPRmWDBW
 vY0naRXPx7nJHiK9KcwMn8nYt7brio2X9COlURzwMgQBB9zGFC867zKS2V0suiqxQO34B1xcZp0
 V+v414WPX9XQoR6OjcEnAULsvAOoeMYm2/1Gm7tVz2VW7dueWY7uAmwQ4JC4V8MiRqYFYKf0Tzi
 8h5a8JYIblHr+UPymwQ/GOGy4qV34TIDlu50iJVG+6tksFGLHCIoTyeAdpoAvhYMwPPClO
X-Google-Smtp-Source: AGHT+IEGOUySMosSP459eTtozrnM7+Kzwj4R3IJX2+duP8bc6RYAa5TNZ0lB1tcRFEpSUPJGS/kJvg==
X-Received: by 2002:a17:902:e881:b0:29e:a615:f508 with SMTP id
 d9443c01a7336-2a2f272c883mr421748625ad.28.1767461672068; 
 Sat, 03 Jan 2026 09:34:32 -0800 (PST)
Received: from google.com (61-230-44-212.dynamic-ip.hinet.net. [61.230.44.212])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d4cbcfsm414422475ad.50.2026.01.03.09.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jan 2026 09:34:31 -0800 (PST)
Date: Sun, 4 Jan 2026 01:34:28 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: j.ne@posteo.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Peter Geis <pgwipeout@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH next] board: amediatech: Add X96Q support
Message-ID: <aVlTJPeB5HmvmerJ@google.com>
References: <20251231-x96q-v1-1-316d703b8f03@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251231-x96q-v1-1-316d703b8f03@posteo.net>
X-Mailman-Approved-At: Sun, 04 Jan 2026 01:37:37 +0100
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

Hi J.,

On Wed, Dec 31, 2025 at 08:45:03PM +0100, J. Neuschäfer via B4 Relay wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> The X96Q is a set-top box with an H313 SoC, AXP305 PMIC, 1 or 2 GiB RAM,
> 8 or 16 GiB eMMC flash, 2x USB A, Micro-SD, HDMI, Ethernet, audio/video
> output, and infrared input.
> 
>   https://x96mini.com/products/x96q-tv-box-android-10-set-top-box
> 
> This commit adds a defconfig and some documentation. The devicetree is
> already in dts/upstream.
> 
> The CONFIG_DRAM_SUNXI_* settings are chosen such that the register
> values in the DRAM PHY's MMIO space are as close as possible to those
> observed when booting with the preinstalled vendor U-Boot.
> 
> ---

Please remove the --- separator above the Signed-off-by tag. git am
treats everything after the first --- as comments, which will cause
your sign-off to be stripped from the final commit message.

Regards,
Kuan-Wei

> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
>  configs/x96q_defconfig         | 46 ++++++++++++++++++++++++++++++++++
>  doc/board/amediatech/index.rst |  9 +++++++
>  doc/board/amediatech/x96q.rst  | 57 ++++++++++++++++++++++++++++++++++++++++++
>  doc/board/index.rst            |  1 +
>  4 files changed, 113 insertions(+)
> 
> diff --git a/configs/x96q_defconfig b/configs/x96q_defconfig
> new file mode 100644
> index 00000000000..650fecca624
> --- /dev/null
> +++ b/configs/x96q_defconfig
> @@ -0,0 +1,46 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_SUNXI=y
> +CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun50i-h313-x96q"
> +CONFIG_SPL=y
> +
> +CONFIG_DRAM_CLK=600
> +CONFIG_DRAM_SUNXI_DX_ODT=0x03030303
> +CONFIG_DRAM_SUNXI_DX_DRI=0x0e0e0e0e
> +CONFIG_DRAM_SUNXI_CA_DRI=0x1f12
> +CONFIG_DRAM_SUNXI_TPR0=0xc0001002
> +CONFIG_DRAM_SUNXI_TPR2=0x00000100
> +CONFIG_DRAM_SUNXI_TPR10=0x002f0107
> +CONFIG_DRAM_SUNXI_TPR11=0xddddcccc
> +CONFIG_DRAM_SUNXI_TPR12=0xeddc7665
> +
> +CONFIG_MACH_SUN50I_H616=y
> +CONFIG_SUNXI_DRAM_H616_DDR3_1333=y    # DDR3 is correct, but vendor uboot mentions 600 MHz DRAM CLK
> +#CONFIG_MMC_SUNXI_SLOT_EXTRA=2
> +CONFIG_R_I2C_ENABLE=y
> +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_SYS_I2C_LEGACY=y
> +CONFIG_SYS_I2C_MVTWSI=y
> +CONFIG_SYS_I2C_SLAVE=0x7f
> +CONFIG_SYS_I2C_SPEED=400000
> +CONFIG_SUPPORT_EMMC_BOOT=y
> +CONFIG_AXP305_POWER=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_OHCI_HCD=y
> +
> +CONFIG_SPL_USE_TINY_PRINTF_POINTER_SUPPORT=y
> +CONFIG_CMD_UFETCH=y
> +#CONFIG_SPL_PAYLOAD="u-boot.img"
> +#CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x60
> +
> +CONFIG_CMD_CAT=y
> +
> +#CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=60   # os = 0, uboot not detected
> +#CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=61   # e59f002c e5810000 f57ff04f f57ff06f (4a0000cc)
> +#CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=62   # a9431e66 a9442668 a9452e6a a946366c (4a0002cc)
> +#CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=64   # 52800000 91008081 79400025 34000080 (4a0006cc)
> +#CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=96   # 340007c0 f9401673 eb1302ff 54000760 (4a006acc)
> +#CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=112  # f9003fe0 f94047e0 6b1c001f 54fffcc0 (4a0162cc)
> +
> +CONFIG_SUN8I_EMAC=y
> +CONFIG_FIT_BEST_MATCH=y
> diff --git a/doc/board/amediatech/index.rst b/doc/board/amediatech/index.rst
> new file mode 100644
> index 00000000000..7bc42833ec0
> --- /dev/null
> +++ b/doc/board/amediatech/index.rst
> @@ -0,0 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Amediatech
> +==========
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   x96q
> diff --git a/doc/board/amediatech/x96q.rst b/doc/board/amediatech/x96q.rst
> new file mode 100644
> index 00000000000..27485c1b363
> --- /dev/null
> +++ b/doc/board/amediatech/x96q.rst
> @@ -0,0 +1,57 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +U-Boot for the Amediatech X96Q set-top box
> +==========================================
> +
> +Quick Start
> +-----------
> +
> +- Get and Build the ARM Trusted Firmware (TF-A)
> +- Build U-Boot
> +- Write U-Boot to a microSD card
> +- Boot
> +
> +Get and Build the ARM Trusted Firmware (TF-A)
> +---------------------------------------------
> +
> +.. code-block:: bash
> +
> +    $ echo "Downloading and building TF-A..."
> +    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
> +    $ cd trusted-firmware-a
> +
> +Then build TF-A:
> +
> +.. code-block:: bash
> +
> +    $ export CROSS_COMPILE=aarch64-linux-gnu-
> +    $ make PLAT=sun50i_h616 bl31
> +    $ cp build/sun50i_h616/release/bl31.bin ../
> +
> +Build U-Boot
> +------------
> +
> +.. code-block:: bash
> +
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make x96q_defconfig
> +    $ make
> +
> +After the build succeeds, you will obtain the final ``u-boot-sunxi-with-spl.bin``
> +image, which you can then write to a microSD card.
> +
> +Write U-Boot to a microSD card
> +------------------------------
> +
> +You can then flash U-Boot to the microSD card (replace ``/dev/sdX`` with the
> +card's device file):
> +
> +.. code-block:: bash
> +
> +    $ dd if=u-boot-sunxi-with-spl.bin of=/dev/sdX bs=8k seek=1
> +
> +Boot
> +----
> +
> +When the X96Q is booted with the prepared microSD card inserted, it should boot
> +into the freshly installed U-Boot.
> diff --git a/doc/board/index.rst b/doc/board/index.rst
> index 7870f1bc246..767e1831912 100644
> --- a/doc/board/index.rst
> +++ b/doc/board/index.rst
> @@ -9,6 +9,7 @@ Board-specific doc
>     acer/index
>     actions/index
>     advantech/index
> +   amediatech/index
>     andestech/index
>     allwinner/index
>     amlogic/index
> 
> ---
> base-commit: 8f520c0d5656196ec4912c837cc156a399350c33
> change-id: 20251231-x96q-998c1376ebbf
> 
> Best regards,
> -- 
> J. Neuschäfer <j.ne@posteo.net>
> 
> 
> 

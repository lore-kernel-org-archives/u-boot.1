Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E46C2A063
	for <u-boot@archiver.kernel.org>; Sun,  4 Jan 2026 00:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E382E83C28;
	Sun,  4 Jan 2026 01:37:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c6fboVrd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4390C83B49; Sat,  3 Jan 2026 18:39:50 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AABB283B1E
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 18:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7b9215e55e6so7851835b3a.2
 for <u-boot@lists.denx.de>; Sat, 03 Jan 2026 09:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767461986; x=1768066786; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+9TzYaXnPYWxiVq61MTc0R/arGOEMImqHMrLdRwRhWQ=;
 b=c6fboVrdmq0mNanW7+NyNstsSMO6/ZHlVvPkR4j+5KK9JdwBcGQX9lQAbYhgFUbdIN
 V9E6nivjMgnw2g8E6m+r/lRxySzf5kn8sZRP6hEmxfr0GrbnHF+ru8f05snrXdtTLtjq
 80SKkcrZ+Lfkq+4x2fdu3I6xUjCSM5r60BJsMKka7tXzdWWikBJTzLxh531WpFYzlTwt
 dukG2A0NHyiJXVcutHKh7LuOy5akH6cy9BOSg5vrOHjVTTnKUPGaAXmVQv54bonnOYpI
 lQDezV1gIRdtG2oimPqTxm6oDeMeHlUePEHbPuKqHkogAFG2okWuZMcQlPkPAxoxSXIb
 MhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767461986; x=1768066786;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+9TzYaXnPYWxiVq61MTc0R/arGOEMImqHMrLdRwRhWQ=;
 b=a3ltW0LSuBBcGxpZFdeZGCqAZA9rJOpCahIpO0okxeC8wrQxeLWnGSN2xTRXP8L3B3
 NBL6IIrvTUG6tdSLEf53RgH4paXOnMjXFwT72gN0scpxAsSHt1ZCCmvortFwQ/6XyVBY
 B6O43o2UqnZbCGdlZkGNPwi62jVwXknbKqlDQtGgOxScHUFSiO8Nzxm2yaMwbE1sGuz/
 keaConydCxRWNssualmz+rUYYXwkXrm0PSMuxCzGnjpjD+i6Euk8EvR+F+4Ld7FbGi25
 nvKdeFzxi0uiwKdT92wPzWajlqwDaSuJhDu+6kj6D7INrdJrrCRL98exqd+1UQu7cqM3
 tFKQ==
X-Gm-Message-State: AOJu0YzBh0SxHXI2YkirC/eu+fr2h5Aty9gIN7FMJY3X/r0xsRETabGk
 NC9GLikULRFb9nPEIvaejeUqp0gA9QV+/7K4MpOOghrzcXImamFkweJM5nYTvQ==
X-Gm-Gg: AY/fxX7HNI7eHwPw+Y/TuHr1eog3j7gYtB0LeEDiOsBuKBEq4r+QCCdVg2vomvnkdzH
 JPsMTWTxR4btPH2Zv6/WER+kM63qxnT+MmXShXT4BmOu6LvmFEnap07aEHlAX05MQCRZgo85FY/
 4NSAVFjogXz4lsyRLEq+bGd5mD47nw4wiR99JMJrQ2s/1En+nY0ob/1S43RBx6HKiGpcP4Vt9GZ
 VNUbXePqU02i+Ac5pnZBHno1Rueq+O518/1irQMu6RVl8vefhzalcfla7UoOpsn5u+WK1GLa8X5
 NSn31D05yxF50yc/aA/vlpZVdUpzV855zhJTbdNGe8gqXPapzpgBQF/pBN3e50L5Zzi8bZJhzFQ
 AXcqmrIulTIVRbofeWC63PHWi0TiyixjD4khgnxHbZImCJxuUO9wGwdZxPRx9okJXDgZbtxUd2U
 Eo+d3+2yioaUJNfkDe0rPS7ycj9PeYshdSypM3Nh0d584jyVv2hmcVZfmu/1pwBlX/aQiY
X-Google-Smtp-Source: AGHT+IFzAIcd1iUps1CNcbNRPodvR4MK03MsNg+cwsKZEe1ZmdHXqfGepA2f74ruD7/bFlegS9hUfg==
X-Received: by 2002:a05:6a00:2f8b:b0:801:f1a4:6dc with SMTP id
 d2e1a72fcca58-801f1a407bcmr24988974b3a.15.1767461985963; 
 Sat, 03 Jan 2026 09:39:45 -0800 (PST)
Received: from google.com (61-230-44-212.dynamic-ip.hinet.net. [61.230.44.212])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7a93ab3csm43371219b3a.7.2026.01.03.09.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jan 2026 09:39:45 -0800 (PST)
Date: Sun, 4 Jan 2026 01:39:42 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: j.ne@posteo.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Peter Geis <pgwipeout@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH next] board: amediatech: Add X96Q support
Message-ID: <aVlUXjnsCWlV3l0Y@google.com>
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

GPL-2.0+ has been deprecated as a SPDX license identifier.
GPL-2.0-or-later should be used instead [1].

[1]: https://lore.kernel.org/u-boot/20251212142859.GQ303283@bill-the-cat

Regards,
Kuan-Wei

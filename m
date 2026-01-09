Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1DDD1A618
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 13:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E678584337;
	Fri,  9 Jan 2026 14:08:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V34inhC5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8F7184121; Fri,  9 Jan 2026 09:25:48 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D536584248
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 09:25:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so43288725e9.2
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 00:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767947145; x=1768551945; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=HoZL168knfaLxWRizjMRtUHXkGZurDeyuoTlS8pUzlk=;
 b=V34inhC5SSSQTAHO4iPgABoKOpzK63cUmp464LbjzHH1Y101xfvZUrd/hWMf/E353Q
 maDYZljbr/YfYuB1CC5ykl8jCeViNbV2RBVH11Fh09yKfQ8H5oaP7EmnT64wEUQU0i5p
 8LWY0GwBJF/UVTQ0IcoMqn48OCFWL4O5y88WJoiRIJaa7lKW0N9oxHJg9G9lShHHpWhm
 rTkmI/WZpEutymdXBj/SX/MVfTUAvP/0OQ/13Gm0AZ+Km+cmfIXiPaVeR33Z8a4tKXuI
 NGIMtD9cHbiRcaxs5r4lnWYPMedpyWKS8sb10VO9YA6GqHP/Oldl81jXYrVfeupogH2/
 vO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767947145; x=1768551945;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HoZL168knfaLxWRizjMRtUHXkGZurDeyuoTlS8pUzlk=;
 b=fKtgD9OmxQzko1CMtBhYyLyFempSfBuAHK8UM6HfJdmPeHZ8IvLRytLBoQdQbDWl8M
 8w7rtyqRB/4vEknvcbyYGVE4rr7tfFa5GC9XS2H8NDXB3nZHd0F+hv2WDItvAhI+PRff
 h+Rnuf3e9Ly60yKdKiV4R5QdjOBjhtTe9VsWcDf7nYXxjCQFmLcUOVWR9XZdO5hbILu0
 dtm/f+/+wUC3U7Pr82qmJUAGJ/3f+ZFZX3a/fXIdiTYlbEPxy5C2svQ81v0MUYu0qdRu
 wG869p85HlNK4dFiweYDcT0x+AuzMA6FZCoKYgH+cx5joSvdn7qrdVT6jAU2DzXdtH97
 nO1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfj1ttRYnJoB7S/aUY3DWXlyw3IizgVJ+Umf6OOiB0v0iNQOXFo0fDseLBe0i5Heaxtp3KT98=@lists.denx.de
X-Gm-Message-State: AOJu0YwmFRgf+f9g5NkNe049hrYCZPyLJTlcupd9Q/o42v/TLUadT2B0
 vfZ2yRbBPafMEoULokie+Y8X7kDkT1Xpib159NTs2F1hXLRz2PMmw9cgEaQjNyB1rbk=
X-Gm-Gg: AY/fxX72aGkZfJbFFj+gUqK4A885An8NzDiNJHYiquARR+LO83WcYQDM3Ill72eKLpg
 mCS77Z0JQTOyguEu40iBPh6W1FWGD/+J9armmAjRahmKaca0w+C9MPEKGcvMflgmxp64b2ZC6nd
 oXdQja33u0FXnl6S9YyPrAusJw4SYp50gq/H0Ahxbi14Ura7STCV+TxOEzuOcXEScJxO053Ovmm
 /7OtUu9eiLpy94bdTNSLKjBsIj85aZtzxFwpRHtw1dKmUEnI69P61bXyTuXAaJr6XK9u/IZyJ7X
 lWONV4ZBxzFj8exFT6QGVTTNv25goJ/GeRM9Vk7IPkxgXcHclppaOF/MUlzdJIXeAeuw0/kDkoQ
 IE5EkYGfYPuGAnHKxEIXlgnlvB+7AcF44yf849lni0xgfuBS2by1Jk4UPid8uQ4Zd49fJdCfvM0
 WemVKwqzi/5jEcIUsTFGBzJNIv1Wr5jD4A8IMnJzhzuqJZYhKaiO7VG9wgrY4x2LU=
X-Google-Smtp-Source: AGHT+IFNXqxvyRWymYYPZYjJgYjrXfEtGC1HblNfAQuaoN9k3V7x6Zq5t7smmLAYvklLOJO4sWAB5A==
X-Received: by 2002:a05:600c:a48:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-47d84b08652mr101909115e9.8.1767947145013; 
 Fri, 09 Jan 2026 00:25:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d283:7a7e:4c57:678d?
 ([2a01:e0a:3d9:2080:d283:7a7e:4c57:678d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f4184cbsm206735055e9.6.2026.01.09.00.25.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 00:25:44 -0800 (PST)
Message-ID: <6e470409-7a6a-447c-9ec3-ef08e6132c87@linaro.org>
Date: Fri, 9 Jan 2026 09:25:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 1/3] spl: Make UFS available for SPL builds
To: Alexey Charkov <alchark@gmail.com>, u-boot@lists.denx.de,
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>,
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Xuhui Lin
 <xuhui.lin@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Dhruva Gole <d-gole@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, Joseph Chen <chenjh@rock-chips.com>
References: <20260108-rk3576-ufs-v4-0-e8e67649f3f8@gmail.com>
 <20260108-rk3576-ufs-v4-1-e8e67649f3f8@gmail.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260108-rk3576-ufs-v4-1-e8e67649f3f8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 09 Jan 2026 14:07:59 +0100
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 1/8/26 18:49, Alexey Charkov wrote:
> Add minimal infrastructure to build SPL images with support for UFS
> storage devices. This also pulls in SCSI support and charset functions,
> which are dependencies of the UFS code.
> 
> With this, only a fixed offset is supported for loading the next image,
> which should be specified in CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR as the
> number of 4096-byte sectors into the UFS block device.
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>   MAINTAINERS                |  1 +
>   arch/arm/include/asm/spl.h |  1 +
>   common/spl/Kconfig         | 29 +++++++++++++++++++++++++++
>   common/spl/Makefile        |  1 +
>   common/spl/spl_ufs.c       | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/Makefile           |  1 +
>   drivers/scsi/Makefile      |  3 +++
>   lib/Makefile               |  1 +
>   8 files changed, 86 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 27ce73d83f48..ca31e57f018a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1861,6 +1861,7 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
>   M:	Bhupesh Sharma <bhupesh.linux@gmail.com>
>   M:	Neha Malcom Francis <n-francis@ti.com>
>   S:	Maintained
> +F:	common/spl/spl_ufs.c
>   F:	drivers/ufs/
>   
>   UPL
> diff --git a/arch/arm/include/asm/spl.h b/arch/arm/include/asm/spl.h
> index ee79a19c05c9..dd462ea6ad82 100644
> --- a/arch/arm/include/asm/spl.h
> +++ b/arch/arm/include/asm/spl.h
> @@ -30,6 +30,7 @@ enum {
>   	BOOT_DEVICE_XIP,
>   	BOOT_DEVICE_BOOTROM,
>   	BOOT_DEVICE_SMH,
> +	BOOT_DEVICE_UFS,
>   	BOOT_DEVICE_NONE
>   };
>   #endif
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 4f4119f5806c..6a82260dd010 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1612,6 +1612,35 @@ config SPL_THERMAL
>   	  automatic power-off when the temperature gets too high or low. Other
>   	  devices may be discrete but connected on a suitable bus.
>   
> +config SPL_UFS_SUPPORT
> +	bool "Support loading from UFS"
> +	select SPL_LOAD_BLOCK
> +	help
> +	  Enable support for UFS in SPL. This allows
> +	  use of UFS devices such as hard drives and flash drivers for
> +	  loading U-Boot.
> +
> +config SPL_UFS_RAW_U_BOOT_DEVNUM
> +	int "SCSI device number of the UFS device to load U-Boot from"
> +	depends on SPL_UFS_SUPPORT
> +	default 0
> +	help
> +	  UFS devices are usually configured with multiple LUNs, which present
> +	  themselves as sequentially numbered SCSI devices. Usually one would
> +	  get a default LUN 0 taking up most of the space on the device, with
> +	  a number of smaller LUNs following it. This option controls which of
> +	  them the SPL will attempt to load U-Boot from. Note that this is the
> +	  SCSI device number, which might differ from the UFS LUN if you have
> +	  multiple SCSI devices attached and recognized by the SPL.
> +
> +config SPL_UFS_RAW_U_BOOT_SECTOR
> +	hex "Address on the UFS to load U-Boot from"
> +	depends on SPL_UFS_SUPPORT
> +	default 0x800 if ARCH_ROCKCHIP
> +	help
> +	  Address on the block device to load U-Boot from,
> +	  Units: UFS sectors (1 sector = 4096 bytes).
> +
>   config SPL_WATCHDOG
>   	bool "Support watchdog drivers"
>   	imply SPL_WDT if !HW_WATCHDOG
> diff --git a/common/spl/Makefile b/common/spl/Makefile
> index 4c9482bd3096..e18f3cf09484 100644
> --- a/common/spl/Makefile
> +++ b/common/spl/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_$(PHASE_)DFU) += spl_dfu.o
>   obj-$(CONFIG_$(PHASE_)SPI_LOAD) += spl_spi.o
>   obj-$(CONFIG_$(PHASE_)RAM_SUPPORT) += spl_ram.o
>   obj-$(CONFIG_$(PHASE_)USB_SDP_SUPPORT) += spl_sdp.o
> +obj-$(CONFIG_$(PHASE_)UFS_SUPPORT) += spl_ufs.o
>   endif
>   
>   obj-$(CONFIG_$(PHASE_)UPL) += spl_upl.o
> diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
> new file mode 100644
> index 000000000000..6b035db13c41
> --- /dev/null
> +++ b/common/spl/spl_ufs.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2025 Alexey Charkov <alchark@gmail.com>
> + */
> +
> +#include <spl.h>
> +#include <spl_load.h>
> +#include <scsi.h>
> +#include <errno.h>
> +#include <image.h>
> +#include <linux/compiler.h>
> +#include <log.h>
> +
> +static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size, void *buf)
> +{
> +	struct blk_desc *bd = load->priv;
> +	lbaint_t sector = off >> bd->log2blksz;
> +	lbaint_t count = size >> bd->log2blksz;
> +
> +	return blk_dread(bd, sector, count, buf) << bd->log2blksz;
> +}
> +
> +static int spl_ufs_load_image(struct spl_image_info *spl_image,
> +			      struct spl_boot_device *bootdev)
> +{
> +	int err = -ENOSYS;
> +	struct blk_desc *bd;
> +	struct spl_load_info load;
> +	int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
> +	unsigned long sector = CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR;
> +
> +	/* try to recognize storage devices immediately */
> +	scsi_scan(false);
> +	bd = blk_get_devnum_by_uclass_id(UCLASS_SCSI, devnum);
> +	if (!bd)
> +		return -ENODEV;
> +
> +	spl_load_init(&load, spl_ufs_load_read, bd, bd->blksz);
> +	err = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
> +	if (err) {
> +		puts("spl_ufs_load_image: ufs block read error\n");
> +		log_debug("(error=%d)\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +SPL_LOAD_IMAGE_METHOD("UFS", 0, BOOT_DEVICE_UFS, spl_ufs_load_image);
> diff --git a/drivers/Makefile b/drivers/Makefile
> index de993ae42ac7..43d0ba332818 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -73,6 +73,7 @@ obj-$(CONFIG_SPL_USB_HOST) += usb/host/
>   obj-$(CONFIG_SPL_SATA) += ata/ scsi/
>   obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
>   obj-$(CONFIG_SPL_THERMAL) += thermal/
> +obj-$(CONFIG_SPL_UFS_SUPPORT) += scsi/ ufs/
>   
>   endif
>   endif
> diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
> index b76de1b22a8b..c9af60d5d03c 100644
> --- a/drivers/scsi/Makefile
> +++ b/drivers/scsi/Makefile
> @@ -16,4 +16,7 @@ ifdef CONFIG_XPL_BUILD
>   ifdef CONFIG_SPL_SATA
>   obj-$(CONFIG_SCSI) += scsi.o scsi-uclass.o
>   endif
> +ifdef CONFIG_SPL_UFS_SUPPORT
> +obj-$(CONFIG_SCSI) += scsi.o scsi-uclass.o
> +endif
>   endif
> diff --git a/lib/Makefile b/lib/Makefile
> index 70667f3728c2..d0ffabc2b476 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -147,6 +147,7 @@ else
>   obj-$(CONFIG_$(PHASE_)SPRINTF) += vsprintf.o
>   endif
>   obj-$(CONFIG_$(PHASE_)STRTO) += strto.o
> +obj-$(CONFIG_$(PHASE_)UFS_SUPPORT) += charset.o
>   else
>   # Main U-Boot always uses the full printf support
>   obj-y += vsprintf.o strto.o
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

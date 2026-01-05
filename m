Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D704C79FA3
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 16:45:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1409883F1F;
	Mon,  5 Jan 2026 17:42:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FKSEv8RF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A997C83E88; Mon,  5 Jan 2026 16:22:06 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7884C83E62
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 16:22:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b7cee045187so7467266b.0
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 07:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767626524; x=1768231324; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=WdsdI27wUo0CSVZ5FBsH0QWNk725TbYqkuUkeVl20zQ=;
 b=FKSEv8RF26wzvJUH8BGA70HtuOvlNAujCdAI8oXMjtAaBBoLPVEfnqPjusj8hLq2/b
 Ca4APsRqvu9tiRCg81/oV8D9vInwcsOsJ65vJyK/ba6Q49JNi7vApmTNQStYo2SBLWoi
 kPy2Hmh+JM54xEe7+0QDfzM2iC8FidAA9KmvbZzOmkEqCuIrfghGYi9FXEeLEiJXgJhQ
 Ut6D4IIS68DIkL0YXImZvwR8MYDyujiz8Ei4pU2gRnAsyUBK6VqQiCTND/pOo9IscMdR
 EJ/6RlwSx2XmhLw9x5DlcqcklCiSn4SCdrxzhxV4ucF/SuUO7QLFetEq+PGOTdZJfhtD
 OCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767626524; x=1768231324;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WdsdI27wUo0CSVZ5FBsH0QWNk725TbYqkuUkeVl20zQ=;
 b=NseU4Nkh3D4wwsnWUVLmpPMXiIUXyuT+gXjGGEiv5CZ3K1Nsx+NB//+rRB9RYnsiix
 kHJN1biB1nv8xCoW+GRG0qmciy7cK1SJH2Zhfc2jLR0gbkDjAMp0fbcSE3mZ5rGdouzE
 iAy3Oqqtpderxs3picnhw5P5ZCLY50ulXLu+VK272yPMkFu9P5ea6HTcRjR5Gg8dcg+m
 SQASzVCOajSjS1swFLcprWE/byThcR0jXmw/FDnNnN4993RPVhHPcYGBln5HAxbx8cWI
 +u3oA1l+hT+/PzkW7l9DtqVOgrVv3d7o/t8oQD9tbxH0aE72G+G5s/4zwGGkl1t8/1LH
 uMsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0UNDVsUxUR3ETggCo4QTDCQdmhy2svQKhhlHiYnVjuw7uQqILClwN7G8LHLKyDTVKj1EKC8c=@lists.denx.de
X-Gm-Message-State: AOJu0YzG6PDFSeVmuA+20IbYcc5+9+i/Lus6xBCfuZJCJ9ydljpJ1Z3f
 9VQRGiPpOuJu2FInVJd0XHoLo79anjpQBG0EmpKAqAvWIdILgG6AMm56bCSLwoxDRjE=
X-Gm-Gg: AY/fxX5zEWcv6sjvoMrouFIn5LHf12qCLvM9Tsokx5A3omvQvRGeShprzocdUGyGdq4
 C3P5ZjiXICJcDV5Go0cROui9kyVueYgI/hGo2cl+HLZ/veJCFopNuMQzUTVD9wowLnohxudUqGW
 b3RyihfQgvyjVfmZVCDcsNQdeMkkfqGIr/5YsNvB5PQYU+GP6YQTb8bdMxx3HlT7x/LI7/R6xjm
 xmWExQ22D2KZAOhJFc1YUj9R+arDbo0lIB7qNUCe+ke4urk3vZvBnImLsXA07tzFPeHwpZb+0Ww
 9eyfIDOgSuBtDONarQgW1hIrLM0JBU9jj42mUXy5WYcgKfaCUlVDefPKrhOZwiiP8LakxmDMCB0
 w0x+got/OZDwk+Le6mzXWIPBx1vF+R1HVIZVjQT3EqcuGc/KlkGZyXMUA6++ypbULcc5r1h11Tv
 l4LRdL927EfghIUlfT6CArLC/tKMd60L2kDiD+NttMbHZiagCeijciw08vLgo8Um8=
X-Google-Smtp-Source: AGHT+IFinUM6uCLU2e0HgFbJNhtlkfPRhKBPklhH9C/KiTpfCKwnkKFz6TNhSN64A1ZEhivj0aYjVA==
X-Received: by 2002:a17:907:7f1e:b0:b46:57fd:8443 with SMTP id
 a640c23a62f3a-b83e25ba06bmr871969066b.24.1767626523536; 
 Mon, 05 Jan 2026 07:22:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d4c1:5589:eadb:1033?
 ([2a01:e0a:3d9:2080:d4c1:5589:eadb:1033])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842673b53dsm14795966b.37.2026.01.05.07.22.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 07:22:03 -0800 (PST)
Message-ID: <6fa0a9f7-1733-41cc-8fb0-211605634a2d@linaro.org>
Date: Mon, 5 Jan 2026 16:22:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/3] spl: Make UFS available for SPL builds
To: Alexey Charkov <alchark@gmail.com>, u-boot@lists.denx.de,
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Yao Zi <me@ziyao.cc>, Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heiko Schocher <hs@nabladev.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Xuhui Lin
 <xuhui.lin@rock-chips.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Johan Jonker <jbx6244@gmail.com>, Dhruva Gole <d-gole@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Huan Zhou <me@per1cycle.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Finley Xiao <finley.xiao@rock-chips.com>, Joseph Chen <chenjh@rock-chips.com>
References: <20260105-rk3576-ufs-v2-0-caba979a0d6b@gmail.com>
 <20260105-rk3576-ufs-v2-1-caba979a0d6b@gmail.com>
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
In-Reply-To: <20260105-rk3576-ufs-v2-1-caba979a0d6b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 05 Jan 2026 17:42:42 +0100
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

On 1/5/26 16:05, Alexey Charkov wrote:
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
>   common/spl/Kconfig         | 48 ++++++++++++++++++++++++++++++++++
>   common/spl/Makefile        |  1 +
>   common/spl/spl_ufs.c       | 65 ++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/Makefile           |  1 +
>   drivers/scsi/Makefile      |  3 +++
>   lib/Makefile               |  1 +
>   8 files changed, 121 insertions(+)
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
> index 4f4119f5806c..1ed7f56598f6 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1612,6 +1612,54 @@ config SPL_THERMAL
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
> +config SPL_UFS_BOUNCE_BUF
> +	bool "Use a bounce buffer for UFS loading"
> +	depends on SPL_UFS_SUPPORT
> +	default y if ARCH_ROCKCHIP
> +	help
> +	  On some platforms the UFS host controller may be unable to load all
> +	  image segments directly to their required memory locations (e.g. due
> +	  to DMA constraints). This option enables an interim bounce buffer in
> +	  system RAM to let such platforms boot directly from UFS, at a cost of
> +	  an additional memory move while loading the image.

Can't this be replaced by the SCSI bounce buffer ?

> +
> +config SPL_UFS_BOUNCE_BUF_ADDR
> +	hex "Memory address of the bounce buffer for UFS loading"
> +	depends on SPL_UFS_BOUNCE_BUF
> +	default SYS_LOAD_ADDR
> +	help
> +	  Address of a memory region to use as the interim bounce buffer when
> +	  loading images from UFS.
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
> index 000000000000..3952bc4be0a2
> --- /dev/null
> +++ b/common/spl/spl_ufs.c
> @@ -0,0 +1,65 @@
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
> +	ulong bounce_buf_addr = config_opt_enabled(CONFIG_SPL_UFS_BOUNCE_BUF,
> +						   CONFIG_SPL_UFS_BOUNCE_BUF_ADDR, 0);
> +	struct blk_desc *bd = load->priv;
> +	lbaint_t sector = off >> bd->log2blksz;
> +	lbaint_t count = size >> bd->log2blksz;
> +	void *bounce_buf;
> +	ulong ret;
> +
> +	if (IS_ENABLED(CONFIG_SPL_UFS_BOUNCE_BUF)) {
> +		bounce_buf = map_sysmem(ALIGN(bounce_buf_addr, ARCH_DMA_MINALIGN), size);
> +		ret = blk_dread(bd, sector, count, bounce_buf);
> +		if (ret <= 0)
> +			return ret;
> +
> +		ret <<= bd->log2blksz;
> +		memmove(buf, bounce_buf, ret);
> +
> +		return ret;
> +	} else {
> +		return blk_dread(bd, sector, count, buf) << bd->log2blksz;
> +	}
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


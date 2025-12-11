Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEEAD41C09
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D0AA83CB1;
	Thu, 11 Dec 2025 11:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="scWUBWeu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 795708389A; Thu, 11 Dec 2025 08:36:11 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB04280325
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 08:36:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42e2e2eccd2so362822f8f.1
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 23:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765438568; x=1766043368; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=M4rEywrgYXDR9yDGsTJS6XNynx3Qe+2SrhyMLvmCFYE=;
 b=scWUBWeuypP08D4BRa2qctSg0B7EgCeRf2ZtkP2BniAPtBJjrjUE9gmUNFEOZrrkkJ
 OJX5+NC7ixemmuZ2lbh6TaxHBDV/B3471EdywcSNTeTrVqJLBIjjYNmazy4rK9blwGg8
 NBLobKC9Va7l/5DaLp3Aid4Q8oaCf0GYYTV92Khi9CZLuj+WwCvDMBxnQIYNZDBhFBqo
 aTadyTykqf7ia1EEYQSdua0TVXP/LjASREqsMkrDI9YgbO9Z9ao2BajtcH+jngmyldAJ
 sGT+Cds2SJ54i5bai/57FPa/b0qYmbTcgjMCo8a0OZVKYf4uKHR1il9HGWY4+7l4Be+j
 fBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765438568; x=1766043368;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M4rEywrgYXDR9yDGsTJS6XNynx3Qe+2SrhyMLvmCFYE=;
 b=UzGFugzuhs3OvRs5edlZFcnU18h4Jm+hQ8gTq3Fl9TlEH44xynb8lRu9vVwdz5epdW
 W0qBradu9JyRf8IWVhiff+P301OzHg4c0sI3e125I763pEvQxB8hmdzYZyNJ6mgBrlFX
 ZWbWfGxpN7IVxIuBD1wJ1MDlGITHz/0/VZfKlzQczxJX0ePzM9PVXEdMOtpRHwQifPXd
 /8wSSmnsOOUv+yTwITjzuxbZfWgSRg5Cqe7v0L7wGtUAwd3ERhegzbFw37RiQ+YkVBI3
 9b3dqBhwY8QA2IeDD2L9Tnd35qDzcdta65C3E7x02T8Zc+JIUcNuAphwHbeXFJs8txD+
 Jx/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu4uPVvqo7IT29Ss3XEErT/gtwAmsq5uIkXsp60IQrgXq0HyNgC/7KedGUPmW5zQJ+vZAcUo4=@lists.denx.de
X-Gm-Message-State: AOJu0YwpI45+FCgbEViAsbkxes4eEGlaynygD20ND1VzcLTA0XEvDHca
 bgDF/1gT20I6v2Gh+PWSoY7Rys1M1yVfi+GXnHY8+tZZ0VZFCuDyhKFEjJcRc/83F/I=
X-Gm-Gg: AY/fxX6LgNr9LEvj0wYATOxRhnoyIEwc4ahHTfzk3yvlCEXtPF5KFhmErlwQIdOIj6Y
 hxukm6v3WcP77G4Ga14PNPveZadszcbeRgPLtZhQQTMkhAmuNcHbRMKerd+I33PVObmryJz11Nd
 +uee/O/bTnzqvTe5qHeKmIpB4oHIKnyHr18zZX5OxFHKy9gZ+mRcpwjd7QgOQ0lD0a+Rs2Q8tUl
 ZzK0iwwfmWRqc+vRUzvwJFXU0v6VwffQqLH/QicekWBQynH756bb7F4+wJbTuRSdrrXOO6c14Lo
 HvF2p7kSez2jdFKvWtKSD/1kzF9/bRd1MAM3NPxTavLjWUrGkWg8HA+JnYDgKoF+xIRjDUjXWy8
 KUoImx+W6MwFXASUZR8lmwUBcazkAv5zI/XyM+9N5yNrQd+nNYaqDWB17p67r9i42mF6m57L34h
 sCZWLh0eLvsq09NRQ7LW3OZYXworsJxug60BW6HsZKja6bETE0vKy3FN51JS7A
X-Google-Smtp-Source: AGHT+IGyZ7clIyahu8uhrf4v6LW550obCSQ+2DayeRFzLs4Ej+4bsg3bSt02zQCJesBgXJILMEP48A==
X-Received: by 2002:a5d:5f43:0:b0:42b:3e0a:649e with SMTP id
 ffacd0b85a97d-42fa39ce2c0mr5672613f8f.13.1765438567609; 
 Wed, 10 Dec 2025 23:36:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:1fdc:8c26:84af:4a6?
 ([2a01:e0a:3d9:2080:1fdc:8c26:84af:4a6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b85fcesm4119630f8f.25.2025.12.10.23.36.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 23:36:07 -0800 (PST)
Message-ID: <06a02ccb-e694-4463-83b1-cdc281408972@linaro.org>
Date: Thu, 11 Dec 2025 08:36:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/4] spl: Make UFS available for SPL builds
To: Alexey Charkov <alchark@gmail.com>, u-boot@lists.denx.de,
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Walle <mwalle@kernel.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut@mailbox.org>, Anshul Dalal <anshuld@ti.com>,
 Andre Przywara <andre.przywara@arm.com>, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anurag Dutta
 <a-dutta@ti.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Johan Jonker <jbx6244@gmail.com>, Dhruva Gole <d-gole@ti.com>,
 Yifeng Zhao <yifeng.zhao@rock-chips.com>, Sam Edwards <cfsworks@gmail.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Greg Malysa <malysagreg@gmail.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Heiko Schocher <hs@nabladev.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Randolph <randolph@andestech.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Huan Zhou
 <me@per1cycle.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, Joseph Chen
 <chenjh@rock-chips.com>, Ian Roberts <ian.roberts@timesys.com>
References: <20251210-rk3576-ufs-v1-0-a3f9e76eb66e@gmail.com>
 <20251210-rk3576-ufs-v1-2-a3f9e76eb66e@gmail.com>
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
In-Reply-To: <20251210-rk3576-ufs-v1-2-a3f9e76eb66e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Dec 2025 11:05:15 +0100
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

Hi,

On 12/10/25 21:10, Alexey Charkov wrote:
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
>   common/spl/Kconfig         | 16 +++++++++++++++
>   common/spl/Makefile        |  1 +
>   common/spl/spl_ufs.c       | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/Makefile           |  1 +
>   drivers/scsi/Makefile      |  3 +++
>   lib/Makefile               |  1 +
>   8 files changed, 73 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c9853f409920..c58805a724b9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1860,6 +1860,7 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
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
> index a43271671648..aa198ee44a3f 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1608,6 +1608,22 @@ config SPL_THERMAL
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
> +config SPL_UFS_RAW_U_BOOT_SECTOR
> +	hex "Address on the UFS to load U-Boot from"
> +	depends on SPL_UFS_SUPPORT
> +	default 0x800 if ARCH_ROCKCHIP
> +	help
> +	  Address on the block device to load U-Boot from，
> +	  Units: UFS sectors (1 sector = 4096 bytes).

The UFS are usually configured with multiple LUNs, so I would expect to at least
have the LUN parameter in case we use the sector address to load the payload.

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
> index 000000000000..3a5fcd4ed7a8
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
> +static ulong h_spl_load_read(struct spl_load_info *load, ulong off,
> +			     ulong size, void *buf)

What a weird function name, please rename to spl_ufs_load_read

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
> +	unsigned long sector = CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR;
> +
> +	/* try to recognize storage devices immediately */
> +	scsi_scan(false);
> +	bd = blk_get_devnum_by_uclass_id(UCLASS_SCSI, 0);
> +	if (!bd)
> +		return -ENODEV;
> +
> +	spl_load_init(&load, h_spl_load_read, bd, bd->blksz);
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

Thanks,
Neil

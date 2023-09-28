Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA04CE7AF1
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 03:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0BA586D09;
	Thu, 28 Sep 2023 05:05:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="QMD2csI6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60B8A86D09; Thu, 28 Sep 2023 05:05:44 +0200 (CEST)
Received: from mail-m12830.netease.com (mail-m12830.netease.com
 [103.209.128.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3659C86B3B
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 05:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=QMD2csI6JbsdIfV0IZFCcHxGWmvI5M6pjkb/PenRBnSnny73jPGKx+RJ15wSWFFUnlhn5ZQwL5TtCVf9mPg7/ZPOg/HN8pTBe4a63xLN1p51C1vhSLDAIOElDx50Qmeq7JPHTgDYsc8sj9DgF+m4bsXKRl/l8e6NF8rp23Ot/XI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=fet2HkauHQ+NVWKJbyyh0c0sLYLeJ1ilmn7VqWp4k+k=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 03FE4400286;
 Thu, 28 Sep 2023 11:04:00 +0800 (CST)
Message-ID: <c6612d08-9bd4-bb80-2470-544925a136eb@rock-chips.com>
Date: Thu, 28 Sep 2023 11:04:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/3] mtd: nand: raw: rockchip_nfc: add
 NAND_SKIP_BBTSCAN option
Content-Language: en-US
To: Johan Jonker <jbx6244@gmail.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, michael@amarulasolutions.com, 
 dario.binacchi@amarulasolutions.com, u-boot@lists.denx.de
References: <cbbaecb0-19fc-018d-df63-c5f265156024@gmail.com>
 <58111810-f29d-ee4b-dbc3-3b30864f2a95@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <58111810-f29d-ee4b-dbc3-3b30864f2a95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ05JS1ZPGB9PTR8dQ09DTkNVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5DTUtIVUpLS1VKQl
 kG
X-HM-Tid: 0a8ad9be497d2eb3kusn03fe4400286
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pk06SDo*FTwxTSsPFy4YTTkX
 KRgaCRdVSlVKTUJOQ0xLSU9KQkhPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIT0JDNwY+
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


On 2023/8/24 21:28, Johan Jonker wrote:
> On Rockchip SoCs the first boot stages are written on NAND
> with help of manufacturer software that uses a different format
> then the MTD framework. Skip the automatic BBT scan with the
> NAND_SKIP_BBTSCAN option to be able to pass the driver probe
> function and to let the original data unchanged.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/mtd/nand/raw/Kconfig        | 9 +++++++++
>   drivers/mtd/nand/raw/rockchip_nfc.c | 3 +++
>   2 files changed, 12 insertions(+)
>
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index d624589a892b..72547f00fbec 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -611,6 +611,15 @@ config ROCKCHIP_NAND
>   	    NFC v800: RK3308, RV1108
>   	    NFC v900: PX30, RK3326
>
> +config ROCKCHIP_NAND_SKIP_BBTSCAN
> +	bool "Skip the automatic BBT scan with Rockchip NAND controllers"
> +	depends on ROCKCHIP_NAND
> +	default n
> +	help
> +	  Skip the automatic BBT scan with the NAND_SKIP_BBTSCAN
> +	  option when data content is not in MTD format or
> +	  must remain unchanged.
> +
>   config TEGRA_NAND
>   	bool "Support for NAND controller on Tegra SoCs"
>   	depends on ARCH_TEGRA
> diff --git a/drivers/mtd/nand/raw/rockchip_nfc.c b/drivers/mtd/nand/raw/rockchip_nfc.c
> index 6ad51df4acff..df6742c2f9bb 100644
> --- a/drivers/mtd/nand/raw/rockchip_nfc.c
> +++ b/drivers/mtd/nand/raw/rockchip_nfc.c
> @@ -981,6 +981,9 @@ static int rk_nfc_nand_chip_init(ofnode node, struct rk_nfc *nfc, int devnum)
>   	chip->bbt_options = NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
>   	chip->options |= NAND_NO_SUBPAGE_WRITE | NAND_USE_BOUNCE_BUFFER;
>
> +	if (IS_ENABLED(CONFIG_ROCKCHIP_NAND_SKIP_BBTSCAN))
> +		chip->options |= NAND_SKIP_BBTSCAN;
> +
>   	rk_nfc_hw_init(nfc);
>   	ret = nand_scan_ident(mtd, nsels, NULL);
>   	if (ret)
> --
> 2.30.2
>

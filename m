Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22258C5474A
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 04:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53AA788A2E;
	Wed, 28 Aug 2024 06:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724818227;
	bh=OQDblche73X54wcHsLolzAllQqWycJvhdSvwYtayy5c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0NwDLwFgBRUUESuWCBOsxhoyAaV2uOM11qHqbTseFiwubkgzsvQzg02bhuudSL407
	 aSXn3rcpzjEmGQ7qocCTEwjE2xpVXmdLIZsliZ2jLA/VDEV3TSGWjVuYwiKgi4JfSJ
	 iprdgmZYVH0OLQ/NOd7GdEznQtRPvIMCHWOd3OT5DBJhMgpF3ujf19AcDzfpB417bP
	 firaIyfsmuBtt/C8tO6Q4gYe2r5kNit2froSTjknNOVg2cG8SJQhI0gPtWARBFzEjf
	 4VtLN5gPqegmoaObNji6bj2xtvM8QfMx+T7AC7enmlwTcBbQQ1XTmMS10Ui8uV9u7b
	 UpkzF1phvccLw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4642D88892;
 Wed, 28 Aug 2024 06:10:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724818226;
 bh=OQDblche73X54wcHsLolzAllQqWycJvhdSvwYtayy5c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=LDqF7xSduHm641rMtSeDrGpboUS9C6b8IFXKOGntSriIbm9Et0VSE5dxWrDB9QWUo
 Lnn07IkcQYJ9EvILXvkJAkmKYcnlUThCb1nGnsyWj1uiBwHWCorH+f6dkepzNNQfXF
 cYP/YnRav6AjziigZsIRotXsVK4pieaUCb22QfxfQVwuORfrU4oKR850iNp6ZaBcza
 8WDhGVdDD8OaSnTyLhwKFwP0XeGIQ5wF4HY11Lih/yY9hEk3n6IMqpyoMSm9oavjbs
 FpEsUi9tsvWYdIH7mYU6jD9L2qp3N/lnK9JZviVjM8yl36W3PboDW4aO1ubS9ciWL6
 qbqY38D50IhmA==
Message-ID: <9fb1c645-a5f0-48de-beb7-6351290db079@denx.de>
Date: Wed, 28 Aug 2024 05:38:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] mmc: Add more debugging for SPL
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson
 <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20240828014538.3322013-1-sjg@chromium.org>
 <20240828014538.3322013-14-sjg@chromium.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240828014538.3322013-14-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/28/24 3:45 AM, Simon Glass wrote:
> When MMC booting fails it is sometimes hard to figure out what went
> wrong as there is no error code. It isn't even clear which MMC device
> was chosen, since SPL can have its own numbering.
> 
> Add some debugging to help with this.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   common/spl/spl_mmc.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> index 3fd81608e9f..c0e8d407e5d 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -50,6 +50,7 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
>   	ret = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
>   	if (ret) {
>   		puts("mmc_load_image_raw_sector: mmc block read error\n");
> +		log_debug("(error=%d)\n", ret);
>   		return ret;
>   	}
>   
> @@ -76,6 +77,12 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
>   	int ret;
>   
>   #if CONFIG_IS_ENABLED(DM_MMC)
> +	struct udevice *dev;
> +	struct uclass *uc;
> +
> +	log_debug("Selecting MMC dev %d; seqs:\n", mmc_dev);
> +	uclass_id_foreach_dev(UCLASS_MMC, dev, uc)
> +		log_debug("%d: %s\n", dev_seq(dev), dev->name);
>   	ret = mmc_init_device(mmc_dev);
>   #else
>   	ret = mmc_initialize(NULL);
> @@ -91,6 +98,10 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
>   		       mmc_dev, ret);
>   		return ret;
>   	}
> +#if CONFIG_IS_ENABLED(DM_MMC)

if (CONFIG_IS_ENABLED(...)) ?

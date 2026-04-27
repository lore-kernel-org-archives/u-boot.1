Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641BEFF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 11:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D78F483693;
	Mon, 27 Apr 2026 13:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="WqFGaV9P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FE3483AA9; Mon, 27 Apr 2026 13:04:12 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 31AEB80433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 13:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE4681684;
 Mon, 27 Apr 2026 04:04:03 -0700 (PDT)
Received: from [10.41.150.145] (e142021.arm.com [10.41.150.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43FF83F763;
 Mon, 27 Apr 2026 04:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777287849; bh=WVXcnRKPn0WDKd+lYX1fHpK9pERZW4fS+veXdeGIHDc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WqFGaV9P9oATIl5L+vRXFqLCNhGPII+x8HukuTSX5OgrJW17VyMHeRbiHWhhe2cpt
 22hyPmgxF3kO3dWAwurpw73Cf1tkzX6GrrldP7TNa8AsoMdymPa860kTz2CQC9pklK
 ShHqnpEcoP+tH081SG1zcsVHbpw/GNM7eSrufSjM=
Message-ID: <5a801a04-1ceb-4c51-b205-8659be0ebdbf@arm.com>
Date: Mon, 27 Apr 2026 13:04:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] pinctrl: sunxi: add I2C3 mux for D1/T113-s3
 (PG10/PG11)
To: Lukas Schmid <lukas.schmid@netcube.li>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.denx.de
References: <20260325192628.750398-1-lukas.schmid@netcube.li>
 <20260325192628.750398-3-lukas.schmid@netcube.li>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260325192628.750398-3-lukas.schmid@netcube.li>
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

Hi,

On 3/25/26 20:26, Lukas Schmid wrote:
> Boards based on the Allwinner D1/T113-s3, such as the
> NetCube Systems Nagami, can expose a third I2C controller
> on PG10/PG11. However, the sun20i_d1 pinctrl function table
> lacked an entry for this mux.
> 
> Add the "i2c3" function with mux value 3 on PG10/PG11, allowing device
> trees to enable the I2C3 controller.
> 
> Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>   drivers/pinctrl/sunxi/pinctrl-sunxi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index fd357ab0d4e..a8632aeaf8f 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -603,6 +603,7 @@ static const struct sunxi_pinctrl_function sun20i_d1_pinctrl_functions[] = {
>   	{ "gpio_in",	0 },
>   	{ "gpio_out",	1 },
>   	{ "i2c0",	4 },	/* PB10-PB11 */
> +	{ "i2c3",	3 },	/* PG10-PG11 */
>   	{ "mmc0",	2 },	/* PF0-PF5 */
>   	{ "mmc1",	2 },	/* PG0-PG5 */
>   	{ "mmc2",	3 },	/* PC2-PC7 */


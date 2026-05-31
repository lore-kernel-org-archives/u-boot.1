Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A4BCD6E57
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 21:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DE48846DF;
	Sun, 31 May 2026 23:18:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="HcVluWde";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 651FF846FA; Sun, 31 May 2026 23:18:23 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A651840ED
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 23:18:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cd95=D5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1780262300;
 bh=b0ee79tno3HoThlwF1UhWM9JSYAsHCG3CcYYJCyU0JE=;
 b=HcVluWdeZLhkxv/M12cFtcXn01Vh0t+uBh5Sc+zU2GQAkdPMTwk/ZmC/GFTXPkd+ewCxUyWKK
 mPrKcoYvrttoNhLybHokKU+M/DfpF2FAsLQv5Tpdlodj71XB6/kM2tZp6Ln29SB8r5PxcJzu5Xy
 A68XYunJOKuEbhBsekbHoaVwQGNWCJVqqdVByI+QspwD3t/dHPBxM9BEfQuAogWu1mTC4uaGsPj
 n7oH8s3xiZgJQ1mmToRkjNLVFg9pPAScFddL5JoqjrBuE+bqlPLCd+aDbLz/q8G56C4Mkhd782K
 ptXlxkE73XB+mE3MkjKpOWcFk4U2gLdlnCcN/Dug4m2Q==
X-Forward-Email-ID: 6a1ca598611a3f33823c6cee
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.8.16
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <5526c464-6953-485e-a770-ae7ef05fc580@kwiboo.se>
Date: Sun, 31 May 2026 23:18:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/12] rockchip: spl-boot-order: add usb boot option
To: Johan Jonker <jbx6244@gmail.com>
Cc: "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "philipp.tomsich@vrull.eu" <philipp.tomsich@vrull.eu>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "hl@rock-chips.com" <hl@rock-chips.com>,
 "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
 "w.egorov@phytec.de" <w.egorov@phytec.de>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "heiko@sntech.de" <heiko@sntech.de>,
 "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
 "lukma@denx.de" <lukma@denx.de>, "marex@denx.de" <marex@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
References: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
 <d001285d-c059-497c-b4b3-79f71f52741d@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <d001285d-c059-497c-b4b3-79f71f52741d@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Johan,

On 5/31/2026 11:04 PM, Johan Jonker wrote:
> Add usb boot option to spl-boot-order.c
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  arch/arm/mach-rockchip/spl-boot-order.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
> index 6572dde29f65..cd17af13f41b 100644
> --- a/arch/arm/mach-rockchip/spl-boot-order.c
> +++ b/arch/arm/mach-rockchip/spl-boot-order.c
> @@ -76,6 +76,9 @@ static int spl_node_to_boot_device(int node)
>  	if (!uclass_find_device_by_of_offset(UCLASS_SPI_FLASH, node, &parent))
>  		return BOOT_DEVICE_SPI;
> 
> +	if (!uclass_get_device_by_of_offset(UCLASS_USB, node, &parent))

Please use uclass_find_device_by_of_offset() like the other ones. There
should be no need to probe the device here, with find() here the probe
happen a little bit later when the boot device method is run.

Regards,
Jonas

> +		return BOOT_DEVICE_USB;
> +
>  	return -1;
>  }
> 
> --
> 2.39.5
> 


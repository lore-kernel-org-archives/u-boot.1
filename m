Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23D5C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 14:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F12728826E;
	Thu, 16 May 2024 16:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="xHZT9b87";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59A2788297; Thu, 16 May 2024 16:00:45 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04DFD8824A
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 16:00:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ba09=MU=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1715868026;
 bh=u40XVseBvIxf6QKjKJR3N99S3r0utVcfQguhnvUlJBY=;
 b=xHZT9b87bTnNHkDh7wI4AcRKQ+fl4ut89EhKjO8X0+aNHtn980lRhpdKHtuOs9PYxPyihZqwz
 aio/EP6c6NDY8+KYI4zbJzPoBvAMSF8jkMr+CGvkDBQpuZIVFnC7WFGyK2AhMhqXWtf1egUz5+8
 lUVIUgHAxJejJNRxKatCP+GuqJCcRtEbeK0vRWJVdwVawVcuNOgTwB90ige159DF5BK4+S5Au6a
 Rv2xroepaMDQ+i3V7m97P96+8lEDE6ZfM6sCUDN3q8jUvZTCP+BHUbeHqzLFlyjQh03Qvo5ydWb
 M7BQiRU09qVlj9MRCtWHPQYxhOuB4o70aOee1P/S4c8w==
Message-ID: <b6ba47d2-be93-40e8-a1b7-1bd593a933b7@kwiboo.se>
Date: Thu, 16 May 2024 16:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] clk: boston: Allow to get regmap from parent
 device
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, Paul Burton
 <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Sumit Garg
 <sumit.garg@linaro.org>, u-boot@lists.denx.de
References: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
 <20240516-boston-v2-9-77938800d1dd@flygoat.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240516-boston-v2-9-77938800d1dd@flygoat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6646117861b373473707304e
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

Hi Jiaxun,

On 2024-05-16 13:40, Jiaxun Yang wrote:
> In upstream devicetree, clk_boston is a child of syscon node
> and there is no "regmap" property for clk_boston node.
> 
> Try to check parent device first to look for syscon.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v2: Move syscon_get_regmap to probe
> ---
>  drivers/clk/clk_boston.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/clk_boston.c b/drivers/clk/clk_boston.c
> index 030ff7cc58ec..1985bb0ec334 100644
> --- a/drivers/clk/clk_boston.c
> +++ b/drivers/clk/clk_boston.c
> @@ -12,6 +12,7 @@
>  #include <linux/printk.h>
>  
>  struct clk_boston {
> +	struct udevice *syscon;
>  	struct regmap *regmap;
>  };
>  
> @@ -58,23 +59,33 @@ const struct clk_ops clk_boston_ops = {
>  	.get_rate = clk_boston_get_rate,
>  };
>  
> -static int clk_boston_of_to_plat(struct udevice *dev)
> +static int clk_boston_probe(struct udevice *dev)
>  {
>  	struct clk_boston *state = dev_get_plat(dev);
> -	struct udevice *syscon;
> -	int err;
>  
> -	err = uclass_get_device_by_phandle(UCLASS_SYSCON, dev,
> -					   "regmap", &syscon);
> -	if (err) {
> -		pr_err("unable to find syscon device\n");
> -		return err;
> +	state->regmap = syscon_get_regmap(state->syscon);
> +	if (IS_ERR(state->regmap)) {
> +		pr_err("unable to find regmap\n");
> +		return PTR_ERR(state->regmap);
>  	}
>  
> -	state->regmap = syscon_get_regmap(syscon);
> -	if (!state->regmap) {
> -		pr_err("unable to find regmap\n");
> -		return -ENODEV;
> +	return 0;
> +}
> +
> +static int clk_boston_of_to_plat(struct udevice *dev)
> +{
> +	struct clk_boston *state = dev_get_plat(dev);
> +	int err;
> +
> +	if (dev->parent && device_get_uclass_id(dev->parent) == UCLASS_SYSCON) {
> +		state->syscon = dev->parent;
> +	} else {
> +		err = uclass_get_device_by_phandle(UCLASS_SYSCON, dev,
> +						   "regmap", &state->syscon);

This will trigger a probe of the referenced regmap phandle. To simplify
and avoid probing devices at of_to_plat() stage, you can probably just
rename of_to_plat() to probe() and skip of_to_plat() stage completely.

Regards,
Jonas

> +		if (err) {
> +			pr_err("unable to find syscon device\n");
> +			return err;
> +		}
>  	}
>  
>  	return 0;
> @@ -92,6 +103,8 @@ U_BOOT_DRIVER(clk_boston) = {
>  	.id = UCLASS_CLK,
>  	.of_match = clk_boston_match,
>  	.of_to_plat = clk_boston_of_to_plat,
> +	.probe = clk_boston_probe,
>  	.plat_auto	= sizeof(struct clk_boston),
>  	.ops = &clk_boston_ops,
> +	.flags = DM_FLAG_PRE_RELOC,
>  };
> 


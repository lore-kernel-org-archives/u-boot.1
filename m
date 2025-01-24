Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A08BC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 15:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3695780C91;
	Fri, 24 Jan 2025 16:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737732382;
	bh=g8Pcg3hri8bX0YXR5ej12phSEQwb4HyoZ6NbtIMJd5E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z8u7nyDm7BMNgCl+37ad+Jd0EAN7YbveImM2TG3kEsyqbd1XMIgHQ4xKphRj6SN4e
	 9GT2hMe1H+3FTwUZ2nBNv0CjCmPjCJk5uQD/jQJK+kACmUhBybn+WQ0KKs5Ebc34+g
	 Ft7WmABCc44d0bI1YCk5ValfVqFVs6S+oZ8cD0b/T0piC2zIW+ghIW0+ee2GFLpMQK
	 GYMbgbmiUVimBl7YQYZtekrkcqhEdYkaO5iBGQtiCcuImr5YkeBvx/VeBt00hBrVDO
	 vWOxuZmYafuUhTjGnAa4JlnRDkRwdDz9nNGb3rLLIUlLaE55wI8TjCWur7dAXbu3P9
	 4TCVDJSNepJXg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CE4A80C6F; Fri, 24 Jan 2025 16:26:21 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C67280C59
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:26:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="eE/Z7reO"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EA139101CAF4E; Fri, 24 Jan 2025 16:26:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737732378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8Pcg3hri8bX0YXR5ej12phSEQwb4HyoZ6NbtIMJd5E=;
 b=eE/Z7reOojq1o/tf8sX636KxSRuvRvdKATMlJHOybKYtXSBak1qSty7rDvRmnA6PT2NN0Q
 fopfxd7X+pWyu3NdRrNoX1z0TzPhLPm7aeySR81YLsDkzUvepmRJqqApeiNL/ixDarMJjQ
 /xI120Q9t55di4eqzp6+RlS9lHz8Mfvx0qPYLDJJ0eDbV+JM012AmGnNP9KLfrkrIqS8yN
 PDgdAXMeG6W5HS1pt4C+S/xf2TbfRVGp7LZNmmDuWudngOhSpg9EYjHdsYOzhY+0QtSF3f
 omJyBCxcq+mSrHuzS55RIVw08pY7LitW8E72+FRVoDdYmiaKWC0DjWYBAI4hEg==
Message-ID: <876e506c-fbfc-402a-b952-a28cd13b609b@denx.de>
Date: Fri, 24 Jan 2025 15:14:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/20] clk: scmi: check the clock state/parent/rate
 control permissions
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Alice Guo
 <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-8-93b28a514dea@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250115-imx95-v1-8-93b28a514dea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/15/25 2:28 PM, Alice Guo wrote:

[...]

> +static int scmi_clk_get_permissions(struct udevice *dev, int clkid, u32 *perm)
> +{
> +	u32 version;
> +	int ret;
> +
> +	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK, &version);
> +	if (ret) {
> +		debug("get SCMI clock management protocol version failed\n");
> +		return ret;
> +	}
> +
> +	if (version >= CLOCK_PROTOCOL_VERSION_3_0) {

if (version < CLOCK_PROTOCOL_VERSION_3_0)
   return -EINVAL;

> +		struct scmi_clk_get_permissions_in in = {
> +			.clock_id = clkid,
> +		};

[...]

> +static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
> +{
> +	struct clk_scmi *clkscmi;
> +	struct clk *c;
> +	int ret;
> +
> +	if (CONFIG_IS_ENABLED(CLK_CCF)) {

Either do this to reduce indent:

if (!CONFIG_IS_ENABLED(CLK_CCF))
   return -ENOTSUPP;

Or even better, introduce dedicated clock ops structure for the CCF 
variant with these extra callbacks .

> +		ret = clk_get_by_id(clk->id, &c);
> +		if (ret)
> +			return ret;
> +
> +		clkscmi = container_of(c, struct clk_scmi, clk);
> +
> +		if (clkscmi->ctrl_flags & SUPPORT_CLK_PARENT_CONTROL)
> +			return __scmi_clk_set_parent(clk, parent);
> +
> +		/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
> +		debug("SCMI CLOCK: the clock's parent cannot be changed by the agent.\n");
> +		return 0;
> +	}
> +
> +	return -ENOTSUPP;
> +}

[...]

> @@ -858,6 +861,27 @@ struct scmi_clk_parent_set_out {
>   	s32 status;
>   };
>   
> +/**
> + * @clock_id:	Identifier for the clock device.
> + */
> +struct scmi_clk_get_permissions_in {
> +	u32 clock_id;
> +};
> +
> +/**
> + * @status:	Negative 32-bit integers are used to return error status codes.
> + * @permissions:	Bit[31] Clock state control, Bit[30] Clock parent control,
> + * 					Bit[29] Clock rate control, Bits[28:0] Reserved, must be zero

Please make sure the indent is consistent (it seems there are too many 
tabs here) and does not overflow 80 characters line length .

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EA7C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 09:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8F7081D6A;
	Wed, 28 May 2025 11:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1748424870;
	bh=vZtzC/ejli+ccm/hwFcc8nWpcoroTQ+YfwUhuGT0D7Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=TJqXwyJYGQHBXQSxW6lZT7fd5mvXOSMRs9IzifbnWhnGQ5StLzT5bhYEWiXeawZ4R
	 Aaj/hSsatm7h/lpG0vBQnzZlLYU4I7p3cr7+2fwi069Uet/AlgW2rh5nVDnbb9+I0+
	 SjMvXZRftSMjaUo3j14tLBj4EVa/P5LJ7iPW1DUotNf3yl6bIEevyHK+ygQKIBNAhP
	 7vMIA/see71UJTlweyUWXK16M8rWPes/DSygFg8+7YfBuyxDldWqJ2vbXqUGcoa0To
	 SgXpaW6ZsnBKYehdSNN4pS8qGpB0QF699VgwCZPd+K5GFe/ugt90JDrjS3Letr/UTf
	 5KDkqNPIO0eZA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9635782991; Wed, 28 May 2025 11:34:29 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A5D08070C
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 11:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="K792rWSk"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 187E11039728C; 
 Wed, 28 May 2025 11:34:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1748424866;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=vZtzC/ejli+ccm/hwFcc8nWpcoroTQ+YfwUhuGT0D7Y=;
 b=K792rWSkXJyxvnFScaWzbwJd7RSQ5lNQ3g49H6PyK+ykINWy4RFyCxOCyU7my0eAv1cSvZ
 tvv9561FM01ZjaYncL2NSxhf8X6qpn9NW3OVBYxARmSKfMmE1RXBw6mBjf4Ev1DJFJ7az0
 folouUPiAs9Wh4LpS8RNFvHjcZ1C40mI3kY6R5cYiSI2xNirvY38JsHi01luIVdOLABINI
 AGgbYGz1lQpaPdWe9HT2TQAchmGZ8CArLdAHcrt+xJpGE2MyFDr8C/+jSuaMv8b9pXtg4U
 onb9iwddyVbtjmZytLb2afoHonlD+0DblV0MoEXe1IC1mqs/WzPrcPisdr1ibQ==
Message-ID: <0f2037cd-3bfc-bc50-79e0-e84d8bf6766b@denx.de>
Date: Wed, 28 May 2025 11:34:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: mux: Fix the crash when the i2c-arbitrator node is
 present
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: michal.simek@amd.com, trini@konsulko.com, git@amd.com
References: <20250528031255.1762438-1-venkatesh.abbarapu@amd.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250528031255.1762438-1-venkatesh.abbarapu@amd.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Venkatesh,

On 28.05.25 05:12, Venkatesh Yadav Abbarapu wrote:
> Observing the crash when we add the i2c-arbitrator node in the device

Which crash?

> tree as per the DT bindings. The issue is with the child node of
> i2c-arbitrator@72 i.e., i2c@f1950000->i2c-arbitrator@72->i2c-arb, as the
> arbitrator uses the uclass of mux(UCLASS_I2C_MUX) and the mux uclass driver
> checks for the "reg" property using the i2c_mux_child_post_bind() function,
> if it won't find the "reg" property it will return -EINVAL which is leading
> to the crash.
> So, add the logic to check whether the  child node has the "reg" property,
> if the "reg" property exists then read the "reg" and update the channel.
> 
> https://www.kernel.org/doc/Documentation/devicetree/bindings/i2c/i2c-arb.txt
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/i2c/muxes/i2c-mux-uclass.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-uclass.c b/drivers/i2c/muxes/i2c-mux-uclass.c
> index d1999d21feb..b18999c1fe3 100644
> --- a/drivers/i2c/muxes/i2c-mux-uclass.c
> +++ b/drivers/i2c/muxes/i2c-mux-uclass.c
> @@ -40,11 +40,14 @@ static int i2c_mux_child_post_bind(struct udevice *dev)
>   	struct i2c_mux_bus *plat = dev_get_parent_plat(dev);
>   	int channel;
>   
> -	channel = dev_read_u32_default(dev, "reg", -1);

Shouldn;t this function return -1 (the default value), if property "reg" is
not present? (And also if dev_ofnode(dev) is not valid?)

Seems we should look into this function and may fix the problem there?

Aha, this comes from

drivers/core/read.c
int dev_read_u32_default(const struct udevice *dev, const char *propname,
                          int def)
{
         return ofnode_read_u32_default(dev_ofnode(dev), propname, def);
}

with drivers/core/ofnode.c
u32 ofnode_read_u32_default(ofnode node, const char *propname, u32 def)
{
         assert(ofnode_valid(node));
         ofnode_read_u32_index(node, propname, 0, &def);

         return def;
}

added Simon.

@Simon: may proper fix would be to check in ofnode_read_u32_default()
         if propname exists, and if not return default value?
         May also return with default value if node is not valid?

         What do you think?

         Thanks!


> -	if (channel < 0)
> -		return -EINVAL;
> -	plat->channel = channel;
> +	ofnode node = dev_ofnode(dev);
>   
> +	if (ofnode_has_property(node, "reg")) {

If we fix it in this code, you can here simply return immediately
if "reg" propertyis missing, so you can save the identation level,
and patch looks cleaner.

> +		channel = dev_read_u32_default(dev, "reg", -1);
> +		if (channel < 0)
> +			return -EINVAL;
> +		plat->channel = channel;
> +	}
>   	return 0;
>   }
>   
> 

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

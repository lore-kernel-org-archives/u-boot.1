Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D50C7EE2A
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 03:43:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F70981F66;
	Tue, 24 Jun 2025 05:43:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1750736585;
	bh=3Pbxg+xFt1isDpwN8PnCS2L1qDgGRq/QFpH5vph7pnI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=VtcJ5wsGDNVkZmRHGDqU2H7rJmhC2juWUBZoaAO0LeWw0vECIEsO47c4LoNnW0urz
	 sKNpHSmJ/pljyJ0tq5ONuJ9DmW4YN5MuZCZjpNsOOYXqLZKNV36tzbXj2pU9qTC4Uw
	 Z9cyKgLNCC45oKpacQPYRkH1dxkW7jztWDgyAeAuPkAKJ9FX16WOXh24k7GOLn5ukc
	 urZ0irE4PojjyqMM4WjFtuCmBpvXFUKkS4eabTTk2ydlNppuSKpzCZvpkRDD2lC9jI
	 /gA/ZonLlZl7nBPF3wiCCpUoqZ8rNzyl6a2BdKlz+dXimdCHcqwjUixQOyPYALJ5TD
	 xWVACrvYeS4cw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E88E982B20; Tue, 24 Jun 2025 05:43:03 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94B9D81E13
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 05:43:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="QlzOx1AM"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1E115101E92B1; 
 Tue, 24 Jun 2025 05:42:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1750736580;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=3Pbxg+xFt1isDpwN8PnCS2L1qDgGRq/QFpH5vph7pnI=;
 b=QlzOx1AMSccEhblnEQxGCtmXqc8zhfXNZJAFFzrFycDP6BQxrx7Hp/dlaVApfi+FIXSLT3
 SUEoFFM/cejlm6srOg7+1qESFG5nfmxRYe3Ws/pu81sC0OJyfbvYOwqpC6JnBKdzT6hxjT
 y45+CGMArU50LT63wS1qx83vi6GKsBsZT6fG9LcpYsaSSgMH5rH3DL1u8INa1Y2EpnXIwg
 BWJqP5MOiG4PPW7HEnNKYDcfElC8myGZexCTdrQ9ziSHzOviO62N1qDE9Eu1yfpk5Fvugc
 O6bw2Dho6RJHRnOd14EFC/08zMya0u6ddS3bGqwJZmENjJFkFCWyAcXOiBgBCw==
Message-ID: <76349303-7fe3-392f-f272-004c3e173206@denx.de>
Date: Tue, 24 Jun 2025 05:43:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] i2c: mux: Fix the crash when the i2c-arbitrator node
 is present
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, trini@konsulko.com
Cc: michal.simek@amd.com, sjg@chromium.org, git@amd.com, u-boot@lists.denx.de
References: <20250623080607.100895-1-venkatesh.abbarapu@amd.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250623080607.100895-1-venkatesh.abbarapu@amd.com>
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

Hello Venkatesh Yadav Abbarapu,

On 23.06.25 10:06, Venkatesh Yadav Abbarapu wrote:
> Observing the crash when we add the i2c-arbitrator node in the device
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
> Changes in v2:
> - Return immediately if "reg" property is missing for arbitrator case.
> ---
>   drivers/i2c/muxes/i2c-mux-uclass.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Heiko Schocher <hs@denx.de>

@Tom: The fix looks valid for me, but I am unsure if it is not to
       late for 2025.07. What do you think?

Thanks!

> diff --git a/drivers/i2c/muxes/i2c-mux-uclass.c b/drivers/i2c/muxes/i2c-mux-uclass.c
> index d1999d21feb..012881de05b 100644
> --- a/drivers/i2c/muxes/i2c-mux-uclass.c
> +++ b/drivers/i2c/muxes/i2c-mux-uclass.c
> @@ -40,6 +40,11 @@ static int i2c_mux_child_post_bind(struct udevice *dev)
>   	struct i2c_mux_bus *plat = dev_get_parent_plat(dev);
>   	int channel;
>   
> +	ofnode node = dev_ofnode(dev);
> +
> +	if (!ofnode_has_property(node, "reg"))
> +		return 0;
> +
>   	channel = dev_read_u32_default(dev, "reg", -1);
>   	if (channel < 0)
>   		return -EINVAL;
> 

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

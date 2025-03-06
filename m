Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E905EC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 05:53:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DE08808A2;
	Thu,  6 Mar 2025 06:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741240425;
	bh=pOTDBvdP7K/S7bRpBAKhoFRJFynsRPHycYdYD7wkH0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=N47ehj98PAv7jD08Jnw26cnPqHKv9BxKaUp76Vnjjg86RGrAZA4fNceBFYbldMbqQ
	 UBuTgALI4vXq7SA5WijoIoPHHZLAd2NMki0mSx+1Rl8A0LzhbX8hL/OiWn7+CVtS3b
	 hYu6xYeJ6ls1t6O4PMejz9dpWj162Th69SJCw0PZydA09Fm2r80Efnjb937mSH41Gg
	 3W42nWbegvQU/EzkI32fO0CHFqwjsCA0j9g0wNG9Z3RYYtzQ07wr1k2tCVXiqT2FAD
	 XEq9Km7GVAZv9A6EpbwmJo+/5iMkchBuKbTIa/J66c2VBGmbM1TgZmcBCmC0zkeeE/
	 /fsLWM5doFAuw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D49F9810DC; Thu,  6 Mar 2025 06:53:43 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDF0580805
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 06:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="TAPe+0TT"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1D55A10382C18; Thu,  6 Mar 2025 06:53:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741240420;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=pOTDBvdP7K/S7bRpBAKhoFRJFynsRPHycYdYD7wkH0o=;
 b=TAPe+0TT9GXScNdAnjTmk10l0hOtdw+6k2gaFzApKsugXXMlTHc6ERFzlHMoo53UEvgE+m
 0iXgOwKmp9OM89DSOYZoORziK0pniA+mMxI4Hi7OI4Anx97FN3NbIvSIWoimHNyOxnx92A
 EUbQpdxe8tSTg8SWIUS0tMdIRXamUBBYOn7lJGiipu2ki3dx/7sQdDMNMthUewyl+X91Gv
 /vwSrpPCoUX+otHkaEVb5Gk6QNVFpfc8fHqDj6g1/zC1O1Wq7Ib/KDy8pIfJh7mUHkWO5Z
 sg/66PhI3NKH5K2GFoKG7Va2nzWhHZQAwcyPE4DIwHaAcu1AjqfMTyS46GWpiw==
Message-ID: <a72c58ba-d607-5d24-730c-ab8db718ec8b@denx.de>
Date: Thu, 6 Mar 2025 06:54:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH RFC/RFT 2/3] i2c: omap24xx_i2c: support
 CONFIG_I2C_REPEATED_START in DM_I2C xfer
Content-Language: en-US
To: Aniket Limaye <a-limaye@ti.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 virag.david003@gmail.com, marcel.ziswiler@toradex.com, w.egorov@phytec.de,
 j-keerthy@ti.com, u-kumar1@ti.com
References: <20250304220546.866602-1-a-limaye@ti.com>
 <20250304220546.866602-3-a-limaye@ti.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250304220546.866602-3-a-limaye@ti.com>
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

Hello Aniket,

On 04.03.25 23:04, Aniket Limaye wrote:
> Repeated Start Condition (Sr) can be used to transfer multiple i2c msgs
> without sending a Stop condition (P). So far, the driver default was to
> always send a Stop condition after every i2c msg.
> 
> Add support for a config option (CONFIG_I2C_REPEATED_START) to disable
> sending the Stop condition by default. If this config is enabled, Stop
> condition will be sent only if explicitly requested in the msg flags OR
> if it is the last msg in the transfer.
> 
> Consequently, handle the Repeated Start condition (Sr) in the next msg
> by not calling the wait_for_bb() check since it will simply timeout in
> the absence of a stop condition (BB will be 1 until Stop is programmed)
> 
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
>   drivers/i2c/omap24xx_i2c.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/omap24xx_i2c.c b/drivers/i2c/omap24xx_i2c.c
> index 0d044121d27..d3256ab666d 100644
> --- a/drivers/i2c/omap24xx_i2c.c
> +++ b/drivers/i2c/omap24xx_i2c.c
> @@ -1074,21 +1074,31 @@ static int omap_i2c_xfer(struct udevice *bus, struct i2c_msg *msg, int nmsgs)
>   	u16 i2c_con_reg = 0;
>   
>   	debug("i2c_xfer: %d messages\n", nmsgs);
> -	for (; nmsgs > 0; nmsgs--, msg++) {
> +	for (int i = 0; i < nmsgs; i++, msg++) {
>   		debug("i2c_xfer: chip=0x%x, len=0x%x, read=0x%x\n",
>   		      msg->addr, msg->len, (msg->flags & I2C_M_RD));
>   
> -		/* Wait until bus not busy */
> -		if (wait_for_bb(priv->regs, priv->ip_rev, priv->waitdelay))
> -			return -EREMOTEIO;
> +		/* If previous msg sent a Stop or if this is the first msg
> +		 * Wait until bus not busy
> +		 */

Nitpick: I would like more

		/*
		 * If previous msg sent a Stop or if this is the first msg

but unsure if we have here a strict rule...

> +		if ((i2c_con_reg & I2C_CON_STP) || (i == 0)) {
> +			if (wait_for_bb(priv->regs, priv->ip_rev, priv->waitdelay))
> +				return -EREMOTEIO;
> +		}

You do not need the {} brackets here

>   
> -		/* Set Controller mode with Start and Stop bit */
> -		i2c_con_reg = I2C_CON_EN | I2C_CON_MST | I2C_CON_STT | I2C_CON_STP;
> +		/* Set Controller mode with Start bit */
> +		i2c_con_reg = I2C_CON_EN | I2C_CON_MST | I2C_CON_STT;
>   		/* Set Transmitter/Receiver mode if it is a write/read msg */
>   		if (msg->flags & I2C_M_RD)
>   			i2c_con_reg &= ~I2C_CON_TRX;
>   		else
>   			i2c_con_reg |= I2C_CON_TRX;
> +		/* Send Stop condition (P) by default */
> +		if (!IS_ENABLED(CONFIG_I2C_REPEATED_START))
> +			i2c_con_reg |= I2C_CON_STP;
> +		/* Send Stop if explicitly requested or if this is the last msg */
> +		if ((msg->flags & I2C_M_STOP) || (i == nmsgs - 1))
> +			i2c_con_reg |= I2C_CON_STP;
>   
>   		ret = __omap24_i2c_xfer_msg(priv->regs, priv->ip_rev, priv->waitdelay,
>   					    msg->addr, msg->buf, msg->len,
> 

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

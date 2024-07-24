Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8258C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 10:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CFDE888AA;
	Wed, 24 Jul 2024 12:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721818623;
	bh=BaTX+G/GIR8swIf730+X1nG1RCY4Z3r5WOESB4wIteo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fd9F/R264WejMeRn7zNnDk6h+LImub88iD+bB3ZeXP52mplY2L7J+CQcEOQ5XJ1O6
	 cWzzYLlycYKqnNgEFuw+6IHcQfRrf02eUkrZ2uCw/vTdCOYm8sKbpyzRofm2pyScXv
	 RMKJHxsmQqJTnm/G3ZpLHBX7xMbu/4pHKwmSzdbi+TCDJDV2w8DspiaBaqC1WHP9Q+
	 yF0J/7PhWzau+Pet2KPQ0O0EZddNVrfJBq+Us6FKubuPzxuxr9xrHqnucJPgebfV8P
	 jxwHWpjnJlJMZ0G9ldU8QpL/zYEesydSYwgIuPln5K7ydvLTk2Ky8tik/IK+AwjXyP
	 Bb2gJY7Xj5oRw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D865888886;
 Wed, 24 Jul 2024 12:56:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721818620;
 bh=BaTX+G/GIR8swIf730+X1nG1RCY4Z3r5WOESB4wIteo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=byY1zDNtsXWYSmrHJNTu8i1jUD61Hx+Kb5UIGXF/SG2COtybJwURKkv/R62ttGBt9
 FXBxr85FofudfCWsA1t4aKtyrqPee+mKQBt2Q5XhlNS8L25b5SstfhITC5OKLydEB0
 MPlMVHERz0BT3vjbGZTPTNXELOz7SSSyV+UV0BLSeP4u4hT3gYcpsKDaPZhD1GLcW3
 1yE9xhq4qNDyoBVl+rk9AQdZe183N77807fitlglG1kWQyVBBb5tfv2mF5PwInOw0+
 zCM/Ngkk9q7JnWUVj+Prnt18OiAoEnDA4y8yCxvB9N6Gif0syU0kFYwdABUkQvmQiB
 78Bw4khrwNyaQ==
Message-ID: <7b97413c-2786-417d-adbc-b8b7a2511de0@denx.de>
Date: Wed, 24 Jul 2024 12:11:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] i2c: imx_lpi2c: Replace hard-coded bus speed value
 with bus->speed_hz
To: fedorross@gmail.com, u-boot@lists.denx.de
Cc: Fedor Ross <fedor.ross@ifm.com>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>
References: <20240724095943.214967-1-fedor.ross@ifm.com>
 <20240724095943.214967-2-fedor.ross@ifm.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240724095943.214967-2-fedor.ross@ifm.com>
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

On 7/24/24 11:59 AM, fedorross@gmail.com wrote:
> From: Fedor Ross <fedor.ross@ifm.com>
> 
> Instead of using the hard-coded bus speed value I2C_SPEED_STANDARD_RATE,
> use the actual configured bus speed. This way the bus speed doesn't
> change suddenly after calling the imx_lpi2c_probe_chip() function for
> example.
> 
> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Marek Vasut <marex@denx.de>
> ---
>   drivers/i2c/imx_lpi2c.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/imx_lpi2c.c b/drivers/i2c/imx_lpi2c.c
> index 3c43f61d819..7b10b2b252d 100644
> --- a/drivers/i2c/imx_lpi2c.c
> +++ b/drivers/i2c/imx_lpi2c.c
> @@ -163,6 +163,7 @@ static int bus_i2c_receive(struct udevice *bus, u8 *rxbuf, int len)
>   static int bus_i2c_start(struct udevice *bus, u8 addr, u8 dir)
>   {
>   	lpi2c_status_t result;
> +	struct dm_i2c_bus *i2c = dev_get_uclass_priv(bus);
>   	struct imx_lpi2c_bus *i2c_bus = dev_get_priv(bus);
>   	struct imx_lpi2c_reg *regs = (struct imx_lpi2c_reg *)(i2c_bus->base);
>   	u32 val;
> @@ -172,7 +173,7 @@ static int bus_i2c_start(struct udevice *bus, u8 addr, u8 dir)
>   		debug("i2c: start check busy bus: 0x%x\n", result);
>   
>   		/* Try to init the lpi2c then check the bus busy again */
> -		bus_i2c_init(bus, I2C_SPEED_STANDARD_RATE);
> +		bus_i2c_init(bus, i2c->speed_hz);

Drop the second parameter of bus_i2c_init(). In bus_i2c_init(), do:

struct dm_i2c_bus *i2c = dev_get_uclass_priv(bus);
int speed = i2c->speed_hz;

That should clean the proliferation of "speed" variable.

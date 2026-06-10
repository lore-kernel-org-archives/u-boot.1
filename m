Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0A7CD98C7
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 10:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30131807C4;
	Wed, 10 Jun 2026 12:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="ae7GEB9y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ADE083FEC; Wed, 10 Jun 2026 12:35:08 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4006280086
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 12:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 485FD11763C; Wed, 10 Jun 2026 12:35:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1781087705;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Hp6MX2GD7C5X5UzQZwoF1BDIUy5qWPG4Ywa+do0ItIg=;
 b=ae7GEB9yPNMKj2Ww0vEY2ryB5K33JSQmWMcVuDj1EyLvB63ydVZnQ0dnykrTJW0I68d9ry
 D6UyR/QrY3I2unEtWGGWw65CZTnWVqUTcPWux9iXyZF3FmtVjd8AI9FIXWpCGdCbNSOc8c
 h3WcOhrCAj3biV7MkZ5+4H2Wq9l+MBdBHu9fG9gqWDFCPmo04jUfzXEudCHrxHLYYWqE32
 4EM4NnoP233aMYlafOaqwu3VdDavv+D6l6+4qTPwJ6MzaqUsCn+o/Jy/0AsFFcXltMSJyL
 9PiUhNf7oe0glbwSOcxolYVT/yrkvoKwFPXHpTUtatZhegIf0vw7QxkVOyRYww==
Message-ID: <8ba6ddb8-6bf3-1993-556f-5a744fbdde74@nabladev.com>
Date: Wed, 10 Jun 2026 12:34:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: designware: fix i2c probe error
Content-Language: en-US
To: Coben Han <cobenhan@mediastek.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, wojciech.szamocki@nokia.com, bigunclemax@gmail.com,
 peng.fan@nxp.com
References: <20260530152422.1004068-1-cobenhan@mediastek.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260530152422.1004068-1-cobenhan@mediastek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Coben,

On 30.05.26 17:24, Coben Han wrote:
> Probing i2c slave device just needs its device address.
> 
> A certain type of chipsets such as RTC S35390A have no offset,
> which means address length should be 0.
> 
> But the current designware_i2c_probe_chip function requires
> offset 0 and its length 1.
> 
> This causes the designware-i2c to be initialized again and again.
> 
> Furthermore, after booting into kernel, the designware-i2c kernel
> driver complains its controller timeout.
> 
> This patch fixes this misbehaviour in such way that  only device
> address is issued, no reinitialization needs when target device
> not detected, the designware-i2c kernel driver continues working.
> 
> Signed-off-by: Coben Han <cobenhan@mediastek.com>
> ---
>   drivers/i2c/designware_i2c.c | 52 +++++++++++++++++++++++++++++-------
>   1 file changed, 42 insertions(+), 10 deletions(-)

Sounds valid to me, it would be good to have some Tested by tags
from other users, that this change does not break.

> 
> diff --git a/drivers/i2c/designware_i2c.c b/drivers/i2c/designware_i2c.c
> index 8ad716f410e..a7d3b609aca 100644
> --- a/drivers/i2c/designware_i2c.c
> +++ b/drivers/i2c/designware_i2c.c
> @@ -672,18 +672,50 @@ static int dw_i2c_write(struct i2c_adapter *adap, u8 dev, uint addr,
>   }
>   
>   /* dw_i2c_probe - Probe the i2c chip */
> -static int dw_i2c_probe(struct i2c_adapter *adap, u8 dev)
> +static int designware_i2c_probe_chip(struct udevice *bus, uint chip_addr, uint chip_flags)
>   {
> -	struct i2c_regs *i2c_base = i2c_get_base(adap);
> -	u32 tmp;
> -	int ret;
> +	struct dw_i2c *i2c = dev_get_priv(bus);
> +	struct i2c_regs *i2c_base = i2c->regs;
> +	u32 start_time, ic_status;
> +	int ret = 0;
>   
> -	/*
> -	 * Try to read the first location of the chip.
> -	 */
> -	ret = __dw_i2c_read(i2c_base, dev, 0, 1, (uchar *)&tmp, 1);
> -	if (ret)
> -		dw_i2c_init(adap, adap->speed, adap->slaveaddr);
> +	if (i2c_wait_for_bb(i2c_base) < 0)
> +		return 1;

Why not returning -ETIMEDOUT ? (or better the return code from i2c_wait_for_bb()
which -ETIMEDOUT, but may in future it changes...

> +
> +	dw_i2c_enable(i2c_base, false);
> +	writel(chip_addr, &i2c_base->ic_tar);
> +	dw_i2c_enable(i2c_base, true);
> +
> +	writel(IC_STOP, &i2c_base->ic_cmd_data);
> +
> +	start_time = get_timer(0);
> +	while (1) {
> +		ic_status = readl(&i2c_base->ic_status);
> +
> +		if ((ic_status & IC_STATUS_TFE) && !(ic_status & IC_STATUS_MA))
> +			break;
> +
> +		if (readl(&i2c_base->ic_raw_intr_stat) & IC_TX_ABRT) {
> +			readl(&i2c_base->ic_clr_tx_abrt);
> +			ret = -EREMOTEIO;
> +			break;
> +		}
> +
> +		if (get_timer(start_time) > I2C_BYTE_TO) {
> +			ret = -ETIMEDOUT;
> +			break;
> +		}
> +	}
> +
> +	start_time = get_timer(0);
> +	while (1) {
> +		if ((readl(&i2c_base->ic_raw_intr_stat) & IC_STOP_DET)) {
> +			readl(&i2c_base->ic_clr_stop_det);
> +			break;
> +		} else if (get_timer(start_time) > I2C_STOPDET_TO) {
> +			break;
> +		}
> +	}
>   
>   	return ret;
>   }
> 

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic

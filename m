Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE9BC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 12:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC67981298;
	Thu,  6 Mar 2025 13:49:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BVSXMme3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BB01812C8; Thu,  6 Mar 2025 13:49:10 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 266A5805D7
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 13:49:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 526Cn3ZQ3716396
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 6 Mar 2025 06:49:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741265343;
 bh=mf1/C+yC3qxDWVAY2hoj3g6dl7b94Jf94v61TR5JQw8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=BVSXMme3YV2qS3pLvkBz1O9HkTzZfNBWsEms2bf0RWfCiXfIFH+ymie1nIz+ynJUl
 Ri/CscnJTzQVkB+yG3WQsl2lvMFGN9uIxGIcEgCLk1JTqKbV7+TAzvpFRdFPITBIi7
 2w4dz/4M5+vY63Z2LEc2tn2RcIadI5QQGTp3Qd/Y=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 526Cn2mh017535;
 Thu, 6 Mar 2025 06:49:02 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Mar 2025 06:49:02 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Mar 2025 06:49:02 -0600
Received: from [10.24.72.128] (psdkl-workstation0.dhcp.ti.com [10.24.72.128])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 526Cmwjs036141; 
 Thu, 6 Mar 2025 06:48:59 -0600
Message-ID: <1f9ab8df-7767-4087-9d1e-90c4d38d2a89@ti.com>
Date: Thu, 6 Mar 2025 18:18:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT 2/3] i2c: omap24xx_i2c: support
 CONFIG_I2C_REPEATED_START in DM_I2C xfer
To: <hs@denx.de>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <marek.vasut+renesas@mailbox.org>,
 <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
 <virag.david003@gmail.com>, <marcel.ziswiler@toradex.com>,
 <w.egorov@phytec.de>, <j-keerthy@ti.com>, <u-kumar1@ti.com>
References: <20250304220546.866602-1-a-limaye@ti.com>
 <20250304220546.866602-3-a-limaye@ti.com>
 <a72c58ba-d607-5d24-730c-ab8db718ec8b@denx.de>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <a72c58ba-d607-5d24-730c-ab8db718ec8b@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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



On 06/03/25 11:24, Heiko Schocher wrote:
> Hello Aniket,
> 
> On 04.03.25 23:04, Aniket Limaye wrote:
>> Repeated Start Condition (Sr) can be used to transfer multiple i2c msgs
>> without sending a Stop condition (P). So far, the driver default was to
>> always send a Stop condition after every i2c msg.
>>
>> Add support for a config option (CONFIG_I2C_REPEATED_START) to disable
>> sending the Stop condition by default. If this config is enabled, Stop
>> condition will be sent only if explicitly requested in the msg flags OR
>> if it is the last msg in the transfer.
>>
>> Consequently, handle the Repeated Start condition (Sr) in the next msg
>> by not calling the wait_for_bb() check since it will simply timeout in
>> the absence of a stop condition (BB will be 1 until Stop is programmed)
>>
>> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
>> ---
>>   drivers/i2c/omap24xx_i2c.c | 22 ++++++++++++++++------
>>   1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/i2c/omap24xx_i2c.c b/drivers/i2c/omap24xx_i2c.c
>> index 0d044121d27..d3256ab666d 100644
>> --- a/drivers/i2c/omap24xx_i2c.c
>> +++ b/drivers/i2c/omap24xx_i2c.c
>> @@ -1074,21 +1074,31 @@ static int omap_i2c_xfer(struct udevice *bus, 
>> struct i2c_msg *msg, int nmsgs)
>>       u16 i2c_con_reg = 0;
>>       debug("i2c_xfer: %d messages\n", nmsgs);
>> -    for (; nmsgs > 0; nmsgs--, msg++) {
>> +    for (int i = 0; i < nmsgs; i++, msg++) {
>>           debug("i2c_xfer: chip=0x%x, len=0x%x, read=0x%x\n",
>>                 msg->addr, msg->len, (msg->flags & I2C_M_RD));
>> -        /* Wait until bus not busy */
>> -        if (wait_for_bb(priv->regs, priv->ip_rev, priv->waitdelay))
>> -            return -EREMOTEIO;
>> +        /* If previous msg sent a Stop or if this is the first msg
>> +         * Wait until bus not busy
>> +         */
> 
> Nitpick: I would like more
> 
>          /*
>           * If previous msg sent a Stop or if this is the first msg
> 
> but unsure if we have here a strict rule...
> 

Sure, will do.

>> +        if ((i2c_con_reg & I2C_CON_STP) || (i == 0)) {
>> +            if (wait_for_bb(priv->regs, priv->ip_rev, priv->waitdelay))
>> +                return -EREMOTEIO;
>> +        }
> 
> You do not need the {} brackets here
> 

Right... didn't catch that
Will update in the patch series

>> -        /* Set Controller mode with Start and Stop bit */
>> -        i2c_con_reg = I2C_CON_EN | I2C_CON_MST | I2C_CON_STT | 
>> I2C_CON_STP;
>> +        /* Set Controller mode with Start bit */
>> +        i2c_con_reg = I2C_CON_EN | I2C_CON_MST | I2C_CON_STT;
>>           /* Set Transmitter/Receiver mode if it is a write/read msg */
>>           if (msg->flags & I2C_M_RD)
>>               i2c_con_reg &= ~I2C_CON_TRX;
>>           else
>>               i2c_con_reg |= I2C_CON_TRX;
>> +        /* Send Stop condition (P) by default */
>> +        if (!IS_ENABLED(CONFIG_I2C_REPEATED_START))
>> +            i2c_con_reg |= I2C_CON_STP;
>> +        /* Send Stop if explicitly requested or if this is the last 
>> msg */
>> +        if ((msg->flags & I2C_M_STOP) || (i == nmsgs - 1))
>> +            i2c_con_reg |= I2C_CON_STP;
>>           ret = __omap24_i2c_xfer_msg(priv->regs, priv->ip_rev, 
>> priv->waitdelay,
>>                           msg->addr, msg->buf, msg->len,
>>
> 
> Thanks!
> 
> bye,
> Heiko

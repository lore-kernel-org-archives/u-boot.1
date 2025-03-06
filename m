Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959E8C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 12:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3185981249;
	Thu,  6 Mar 2025 13:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wCixZ6hj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97BBA81276; Thu,  6 Mar 2025 13:47:26 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80DCA80F9E
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 13:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 526ClFgT3716021
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Mar 2025 06:47:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741265235;
 bh=ExRwRizJxEwd8PMMnzKHmfctvc8VyC7HYnCI6hz4DbM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=wCixZ6hjGyX1TPmmXUAwNGQMziDBY8HJhAASkvxsjNrMPcHBvhBfh+HqcPnJ4TAVG
 fKyJhUjR9n/Y10mgEQZaOq4LjxA1/0JePxuJ2Ny0TcuEhayYbXxCedT72fwfVaNK49
 TM++vv5FZvvi3BEy0wgxc1gxZUfa49rPZ/JG8Rs0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 526ClFGA065701
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 6 Mar 2025 06:47:15 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Mar 2025 06:47:15 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Mar 2025 06:47:14 -0600
Received: from [10.24.72.128] (psdkl-workstation0.dhcp.ti.com [10.24.72.128])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 526ClBAN108733; 
 Thu, 6 Mar 2025 06:47:12 -0600
Message-ID: <bd5bcab2-fe71-438f-82cc-01f46a767a21@ti.com>
Date: Thu, 6 Mar 2025 18:17:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT 1/3] i2c: omap24xx_i2c: Use new function
 __omap24_i2c_xfer_msg()
To: <hs@denx.de>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <marek.vasut+renesas@mailbox.org>,
 <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
 <virag.david003@gmail.com>, <marcel.ziswiler@toradex.com>,
 <w.egorov@phytec.de>, <j-keerthy@ti.com>, <u-kumar1@ti.com>
References: <20250304220546.866602-1-a-limaye@ti.com>
 <20250304220546.866602-2-a-limaye@ti.com>
 <46397665-b8c7-813b-be2f-f43a21c6bc3c@denx.de>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <46397665-b8c7-813b-be2f-f43a21c6bc3c@denx.de>
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

Hello Heiko,

On 06/03/25 11:21, Heiko Schocher wrote:
> Hello Aniket,
> 
> On 04.03.25 23:04, Aniket Limaye wrote:
>> Remove __omap24_i2c_read/write() usage from omap_i2c_xfer() in favour of
>> the more flexible __omap24_i2c_xfer_msg().
>> Consequently, these are also no longer needed when DM_I2C is enabled.
>>
>> New function __omap24_i2c_xfer_msg() will take care of individual read
>> OR write transfers with a target device. It goes through below sequence:
>> - Program the provided Target Chip address (OMAP_I2C_SA_REG)
>> - Program the provided Data len (OMAP_I2C_CNT_REG)
>> - Program the provided Control register flags (OMAP_I2C_CON_REG)
>> - Read from or Write to the provided Data buffer (OMAP_I2C_DATA_REG)
>>
>> For a detailed programming guide, refer to the TRM[0] (12.1.3.4 I2C
>> Programming Guide).
>>
>> This patch by itself should be a transparent change. However this is
>> needed for implementing a proper Repeated Start (Sr) functionality for
>> i2c_msgs.
>>
>> Previous implementation for omap_i2c_xfer called __omap24_i2c_read/write
>> functions, with hardcoded addr=0 and alen=0 for each i2c_msg. Each of
>> these calls would program the registers always with a Stop bit set, not
>> allowing for a repeated start between i2c_msgs in the same xfer().
>>
>> [0]: https://www.ti.com/lit/zip/spruj28 (TRM)
>>
>> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
>> ---
>>   drivers/i2c/omap24xx_i2c.c | 139 ++++++++++++++++++++++++++++++++-----
>>   1 file changed, 121 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/i2c/omap24xx_i2c.c b/drivers/i2c/omap24xx_i2c.c
>> index ebe472e20cd..0d044121d27 100644
>> --- a/drivers/i2c/omap24xx_i2c.c
>> +++ b/drivers/i2c/omap24xx_i2c.c
>> @@ -535,6 +535,107 @@ pr_exit:
>>       return res;
>>   }
>> +static int __omap24_i2c_xfer_msg(void __iomem *i2c_base, int ip_rev, 
>> int waitdelay,
>> +                 uchar chip, uchar *buffer, int len, u16 i2c_con_reg)
>> +{
>> +    int i;
>> +    u16 status;
>> +    int i2c_error = 0;
>> +    int timeout = I2C_TIMEOUT;
>> +
>> +    if (len < 0) {
>> +        puts("I2C xfer: data len < 0\n");
>> +        return 1;
>> +    }
>> +
>> +    if (!buffer) {
>> +        puts("I2C xfer: NULL pointer passed\n");
>> +        return 1;
>> +    }
>> +
>> +    if (!(i2c_con_reg & I2C_CON_EN)) {
>> +        puts("I2C xfer: I2C_CON_EN not set\n");
>> +        return 1;
>> +    }
> 
> Can we use here (and above) a negative error code? Later you only
> check in omap_i2c_xfer() if returncode is ! 0 and return "-EREMOTEIO"
> may, you can return here better codes and simply return than this
> error codes from omap_i2c_xfer()  >
> And may you change the strings from the puts call to a more driver specifc
> string ... so its clear from which i2c driver the error message comes...
> please fix this globally in your patchset.
> 

yeah that makes sense, will update the function with proper error codes 
and error prints.

>> +
>> +    /* Set slave address */
>> +    omap_i2c_write_reg(i2c_base, ip_rev, chip, OMAP_I2C_SA_REG);
>> +    /* Read/Write len bytes data */
>> +    omap_i2c_write_reg(i2c_base, ip_rev, len, OMAP_I2C_CNT_REG);
>> +    /* Configure the I2C_CON register */
>> +    omap_i2c_write_reg(i2c_base, ip_rev, i2c_con_reg, OMAP_I2C_CON_REG);
>> +
>> +    /* read/write data bytewise */
>> +    for (i = 0; i < len; i++) {
>> +        status = wait_for_event(i2c_base, ip_rev, waitdelay);
>> +        /* Ignore I2C_STAT_RRDY in transmitter mode */
>> +        if (i2c_con_reg & I2C_CON_TRX)
>> +            status &= ~I2C_STAT_RRDY;
>> +        else
>> +            status &= ~I2C_STAT_XRDY;
>> +
>> +        /* Try to identify bus that is not padconf'd for I2C */
>> +        if (status == I2C_STAT_XRDY) {
>> +            i2c_error = 2;
>> +            printf("I2C xfer: pads on bus probably not configured 
>> (status=0x%x)\n",
>> +                   status);
>> +            goto xfer_exit;
>> +        }
>> +        if (status == 0 || (status & I2C_STAT_NACK)) {
>> +            i2c_error = 1;
>> +            printf("I2C xfer: error waiting for ACK (status=0x%x)\n",
>> +                   status);
>> +            goto xfer_exit;
>> +        }
>> +        if (status & I2C_STAT_XRDY) {
>> +            /* Transmit data */
>> +            omap_i2c_write_reg(i2c_base, ip_rev,
>> +                       buffer[i], OMAP_I2C_DATA_REG);
>> +            omap_i2c_write_reg(i2c_base, ip_rev,
>> +                       I2C_STAT_XRDY, OMAP_I2C_STAT_REG);
>> +        }
>> +        if (status & I2C_STAT_RRDY) {
>> +            /* Receive data */
>> +            *buffer++ = omap_i2c_read_reg(i2c_base, ip_rev,
>> +                            OMAP_I2C_DATA_REG);
>> +            omap_i2c_write_reg(i2c_base, ip_rev,
>> +                       I2C_STAT_RRDY, OMAP_I2C_STAT_REG);
>> +        }
>> +    }
>> +
>> +    /*
>> +     * poll ARDY bit for making sure that last byte really has been
>> +     * transferred on the bus.
>> +     */
>> +    do {
>> +        status = wait_for_event(i2c_base, ip_rev, waitdelay);
>> +    } while (!(status & I2C_STAT_ARDY) && timeout--);
>> +    if (timeout <= 0) {
>> +        puts("I2C xfer: timed out on last byte!\n");
>> +        i2c_error = 1;
>> +        goto xfer_exit;
>> +    } else {
>> +        omap_i2c_write_reg(i2c_base, ip_rev, I2C_STAT_ARDY, 
>> OMAP_I2C_STAT_REG);
>> +    }
>> +
>> +    /* If Stop bit set, flush FIFO. */
>> +    if (i2c_con_reg & I2C_CON_STP)
>> +        goto xfer_exit;
>> +
>> +    return 0;
>> +
>> +xfer_exit:
>> +    flush_fifo(i2c_base, ip_rev);
>> +    omap_i2c_write_reg(i2c_base, ip_rev, 0xFFFF, OMAP_I2C_STAT_REG);
>> +    return i2c_error;
>> +}
>> +
>> +#if !CONFIG_IS_ENABLED(DM_I2C)
>> +/*
>> + * The legacy I2C functions. These need to get removed once
>> + * all users of this driver are converted to DM.
>> + */
>> +
>>   /*
>>    * i2c_read: Function now uses a single I2C read transaction with 
>> bulk transfer
>>    *           of the requested number of bytes (note that the 'i2c 
>> md' command
>> @@ -836,11 +937,6 @@ wr_exit:
>>       return i2c_error;
>>   }
>> -#if !CONFIG_IS_ENABLED(DM_I2C)
>> -/*
>> - * The legacy I2C functions. These need to get removed once
>> - * all users of this driver are converted to DM.
>> - */
>>   static void __iomem *omap24_get_base(struct i2c_adapter *adap)
>>   {
>>       switch (adap->hwadapnr) {
>> @@ -975,23 +1071,30 @@ static int omap_i2c_xfer(struct udevice *bus, 
>> struct i2c_msg *msg, int nmsgs)
>>   {
>>       struct omap_i2c *priv = dev_get_priv(bus);
>>       int ret;
>> +    u16 i2c_con_reg = 0;
>>       debug("i2c_xfer: %d messages\n", nmsgs);
>>       for (; nmsgs > 0; nmsgs--, msg++) {
>> -        debug("i2c_xfer: chip=0x%x, len=0x%x\n", msg->addr, msg->len);
>> -        if (msg->flags & I2C_M_RD) {
>> -            ret = __omap24_i2c_read(priv->regs, priv->ip_rev,
>> -                        priv->waitdelay,
>> -                        msg->addr, 0, 0, msg->buf,
>> -                        msg->len);
>> -        } else {
>> -            ret = __omap24_i2c_write(priv->regs, priv->ip_rev,
>> -                         priv->waitdelay,
>> -                         msg->addr, 0, 0, msg->buf,
>> -                         msg->len);
>> -        }
>> +        debug("i2c_xfer: chip=0x%x, len=0x%x, read=0x%x\n",
>> +              msg->addr, msg->len, (msg->flags & I2C_M_RD));
>> +
>> +        /* Wait until bus not busy */
>> +        if (wait_for_bb(priv->regs, priv->ip_rev, priv->waitdelay))
>> +            return -EREMOTEIO;
>> +
>> +        /* Set Controller mode with Start and Stop bit */
>> +        i2c_con_reg = I2C_CON_EN | I2C_CON_MST | I2C_CON_STT | 
>> I2C_CON_STP;
>> +        /* Set Transmitter/Receiver mode if it is a write/read msg */
>> +        if (msg->flags & I2C_M_RD)
>> +            i2c_con_reg &= ~I2C_CON_TRX;
>> +        else
>> +            i2c_con_reg |= I2C_CON_TRX;
>> +
>> +        ret = __omap24_i2c_xfer_msg(priv->regs, priv->ip_rev, 
>> priv->waitdelay,
>> +                        msg->addr, msg->buf, msg->len,
>> +                        i2c_con_reg);
>>           if (ret) {
>> -            debug("i2c_write: error sending\n");
>> +            debug("i2c_xfer: error sending\n");
>>               return -EREMOTEIO;
>>           }
>>       }
>>
> 
> Thanks!
> 
> bye,
> Heiko


Thanks,
Aniket

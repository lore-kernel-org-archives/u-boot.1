Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF0CCCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 05:56:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B646383C08;
	Wed, 12 Nov 2025 06:56:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="EId62fkq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 947C783C0C; Wed, 12 Nov 2025 06:56:55 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A394E83AB4
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 06:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1D011109BFD; Wed, 12 Nov 2025 06:56:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1762927012;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=oVJGB9sTu1uuaRVjnGhUKjtDYqLZON2MACtM7w++ctM=;
 b=EId62fkq0Qd2/GHaT2nwXxQfsPgejXQzVyvaCa9gifLHGdCAN2NguG+VVX2UunwLlF/yVM
 jQwoZE715v+DF4yRtjLOdzx7ZNJU3E4Vt5AfRA7I4hLY7xyS+EwF5DFpyNrZH9ngwn+t+0
 Tlohn8TcM4UTO0Z9KHJ6Qa+N9WmWUAOBa9RncTTIoO9i0SkmoELQtutSvtWYPPE0fEguVp
 9xsXXsWMKfgmXDoRFYzugKTPz3V5bF7ht1eR4xwi/0HFjIgoxzaprY/JTgEFml9p5pIS0M
 uHNhxjHQbp2blMUY1PJREDRpbxwaXng8r6vy6eldoO+i0oaRldL8WWIMI1gF0A==
Message-ID: <2a59fdc6-304b-4a36-4ae5-b1b6b4fd58f3@nabladev.com>
Date: Wed, 12 Nov 2025 06:57:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/3] rockchip: i2c: fix incorrect STOP flag for the
 interrupt enable register
Content-Language: en-US
To: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Wadim Egorov <w.egorov@phytec.de>, Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
References: <20251107-rk-i2c-illegal-v1-0-3e5fea13a899@cherry.de>
 <20251107-rk-i2c-illegal-v1-1-3e5fea13a899@cherry.de>
 <0af76f64-9315-4c75-b097-98dfbf8d7a01@rock-chips.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <0af76f64-9315-4c75-b097-98dfbf8d7a01@rock-chips.com>
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

Hello Kever Yang

On 11.11.25 15:06, Kever Yang wrote:
> 
> On 2025/11/7 19:39, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> I2C_CON_STOP is a flag to be used for the con register, where it is bit
>> 4 to send the STOP condition.
>>
>> To enable the interrupt the controller sends to tell it's finished
>> sending the STOP condition, it's the ien register at bit 5.
>>
>> Let's use the proper offset.
>>
>> My hunch is that enabling the interrupt is useless as the interrupt
>> status register is always up-to-date and enabling the interrupt is just
>> so that the interrupt is available via the GIC. However, U-Boot has no
>> interrupt support and the logic was working well before this patch. This
>> is just so people aren't side-tracked when debugging I2C issues on
>> Rockchip by checking all writes are proper.
>>
>> Fixes: 3437469985df ("rockchip: Add I2C driver")
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Rockchip vendor U-Boot has  the same fixes.

Thanks for clarifying!

> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

So you pick up this series?

Thanks!

bye,
Heiko
> 
> 
> Thanks,
> - Kever
>> ---
>>   drivers/i2c/rk_i2c.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/rk_i2c.c b/drivers/i2c/rk_i2c.c
>> index fa167268ae7..fe09e75d3fb 100644
>> --- a/drivers/i2c/rk_i2c.c
>> +++ b/drivers/i2c/rk_i2c.c
>> @@ -137,7 +137,7 @@ static int rk_i2c_send_stop_bit(struct rk_i2c *i2c)
>>       writel(I2C_IPD_ALL_CLEAN, &regs->ipd);
>>       writel(I2C_CON_EN | I2C_CON_STOP, &regs->con);
>> -    writel(I2C_CON_STOP, &regs->ien);
>> +    writel(I2C_STOPIEN, &regs->ien);
>>       start = get_timer(0);
>>       while (1) {
>>

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic

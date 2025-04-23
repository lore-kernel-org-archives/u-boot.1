Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED43C369D1
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 14:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61FCE82054;
	Wed, 23 Apr 2025 16:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="UqQ7+m0j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K0EeG4Xm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BEB180FA8; Wed, 23 Apr 2025 09:17:40 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5122680BA8
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 09:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martin.kaistra@linutronix.de
Message-ID: <2a5c6fbb-1788-40f7-9c35-9deeb67b0234@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1745392657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sf59H9+12BDq22+dfko5Wkiw1lzuG7jex4iDc89I1Xs=;
 b=UqQ7+m0jfvJnpIgUKX1bsgL9JOdBOpEl5NaAjaI4dcuXmlzSDfZ3SwT9XCponsV0j+8xNt
 tc0yKzrU5UzYYYmnC1W3ZIRifK0pZBODsDveieLKjn7ZO8LiJjaTmlG8v+kTfugdxHZtr7
 wxdilW/oTE/onOHUpVzxAhizTBa6WTa9GzypuPv4JYJZLchru49dSXTvP8jYNxNHYts6s7
 QMH4udh3Ow11epGJjThD5XpsKT47ennPpzZXvSaGiz7m5Dfp8y4KyunBY+QYOKqRG6Pj79
 LF0LwDso2U1nQ/1H8I4PZ+GCwusDj067qTClbaOJbTxp1RR6rjkUp3t8eYq2Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1745392657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sf59H9+12BDq22+dfko5Wkiw1lzuG7jex4iDc89I1Xs=;
 b=K0EeG4XmEtzZYU7nB3mVxjltcSYkY9vELqqHVbcoJgFYrlAmmc86bJN+rDAZadyN/MetI/
 IML4WhgUrNB9MECA==
Date: Wed, 23 Apr 2025 09:17:37 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] net: gem: ignore tx_clk if MII is used
To: "Katakam, Harini" <harini.katakam@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "Simek, Michal" <michal.simek@amd.com>,
 "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
References: <20250415150400.136723-1-martin.kaistra@linutronix.de>
 <SJ2PR12MB87391F3A43374B5C2844CFD09EBB2@SJ2PR12MB8739.namprd12.prod.outlook.com>
Content-Language: de-DE
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <SJ2PR12MB87391F3A43374B5C2844CFD09EBB2@SJ2PR12MB8739.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 23 Apr 2025 16:25:16 +0200
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

Hi Harini,

Am 22.04.25 um 18:17 schrieb Katakam, Harini:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Martin
> 
>> -----Original Message-----
>> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Martin Kaistra
>> Sent: Tuesday, April 15, 2025 8:34 PM
>> To: u-boot@lists.denx.de
>> Cc: joe.hershberger@ni.com; rfried.dev@gmail.com; Simek, Michal
>> <michal.simek@amd.com>
>> Subject: [PATCH] net: gem: ignore tx_clk if MII is used
>>
>> If the MII interface is used, the PHY is the clock master, thus don't set the clock
> 
> Can you please describe your HW configuration?

on my HW the PS GEM is connected to a MII-to-RMII converter which is then 
connected via RMII to the PHY.

The linux driver (drivers/net/ethernet/cadence/macb_main.c) has a similar 
exception for MII mode in macb_set_tx_clk().

Thanks,
Martin

> Based on the spec,
> 1. In 10/100 GMII mode, tx_clk will run at either 2.5 MHz or 25 MHz as
> determined by the external PHY MII clock input.
> 2. When using gigabit mode, the transmit clock must be sourced from a
> 125 MHz reference clock.
> 3. In RMII mode, tx_clk should be connected to the rmii_tx_clk outputs.
> In both cases 2 and 3, the MAC is the clock master.
> 
> If you are using a HW connection such as Zynq:
> PS GEM - GMII to RGMII/SGMII shim - External PHY,
> then the I understand that you'll get such an error message and that should
> be removed. But I'm not sure if this applies to MII type.
> 
> Regards,
> Harini
> 
>> rate. On Zynq-7000, this will prevent the following
>> error:
>>    zynq_gem ethernet@e000b000: failed to set tx clock rate 25000000
>>
>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>> ---
>>   drivers/net/zynq_gem.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c index
>> 461805ae53f..703e22479d2 100644
>> --- a/drivers/net/zynq_gem.c
>> +++ b/drivers/net/zynq_gem.c
>> @@ -567,12 +567,14 @@ static int zynq_gem_init(struct udevice *dev)
>>        }
>>   #endif
>>
>> -     ret = clk_get_rate(&priv->tx_clk);
>> -     if (ret != clk_rate) {
>> -             ret = clk_set_rate(&priv->tx_clk, clk_rate);
>> -             if (IS_ERR_VALUE(ret)) {
>> -                     dev_err(dev, "failed to set tx clock rate %ld\n", clk_rate);
>> -                     return ret;
>> +     if (priv->interface != PHY_INTERFACE_MODE_MII) {
>> +             ret = clk_get_rate(&priv->tx_clk);
>> +             if (ret != clk_rate) {
>> +                     ret = clk_set_rate(&priv->tx_clk, clk_rate);
>> +                     if (IS_ERR_VALUE(ret)) {
>> +                             dev_err(dev, "failed to set tx clock rate %ld\n",
>> clk_rate);
>> +                             return ret;
>> +                     }
>>                }
>>        }
>>
>> --
>> 2.39.5
> 



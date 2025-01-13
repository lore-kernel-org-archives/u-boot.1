Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF1BC02184
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 12:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94175805DA;
	Mon, 13 Jan 2025 13:36:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736771766;
	bh=j5sQCtOeXI2ZWtejF9nvDaryNz0K14Atpaf7U3om/DY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vd+SMP9R9vvRgVlrJLu6c+NyzpCfbKoGCzHkvzWOnhfUnjGX0e780FkPYROOn/S0c
	 XJAdQho3nBMdKdsyj1xScJMvQ7pUNvH4xsGvJQXPr5uyspDCTtAq5Cr6giQB9R40g4
	 VlYlq9vjX+bJ013FKTBxF/0xQek3uUW2seUJTPDVJGaUGdpMhLbD1h6z2gcanEK4Jg
	 q2RX1hiqjkC4CxtOSUvsSDc+YFFYGpxBZImgMJhywhhAqRD/lnwJ36HhwWJ1EnTMwD
	 d7ycVPAomuXJzGGI/9NS0qmIwegD50HwJdu0+Zp1wxt4R2565t+/M6BwSZtzt1ZMw7
	 RnWAmx+rnlrHg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D283805E7; Mon, 13 Jan 2025 13:36:05 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D751801CF
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 13:36:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="NURXS0qo"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9C0C110408F8C; Mon, 13 Jan 2025 13:35:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736771761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j5sQCtOeXI2ZWtejF9nvDaryNz0K14Atpaf7U3om/DY=;
 b=NURXS0qoBqSaw1EkADC4SlxHnPaxKLBxNZIIGTTer/Y5M8pALyy/pwQzM4aGS42mhCOPot
 uCOtaVc9JIkAScWem+eQwTgj42TL7LR7ZzmHSVrCvVIyE1R9vJDE6dnr36zQs+CWubXRZ6
 Zftft8JcQXQrS5eh0/BPWPp2q8t0Lh3qs53Q3fPz5y19VrLlx/1iScWGCD/R1d4xt2kXOU
 oEVZ0v/aJdjd7StPr8JKlNSeCfTYRo8gHNK578CDAzT0eZEbwRtr98FJFerNIMmowbBU0N
 4uZykx6hraon9PoqrNoWigL8xePTvh7oWfyPHqslgbY4qgmCwJfllByHfdD7Gg==
Message-ID: <1d26afaf-01c2-4490-9f7e-590794520470@denx.de>
Date: Mon, 13 Jan 2025 13:16:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] usb: dwc3: core: Fix timeout check
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: trini@konsulko.com, mkorpershoek@baylibre.com, caleb.connolly@linaro.org, 
 neil.armstrong@linaro.org, u-boot@lists.denx.de
References: <20250110074306.3897847-1-quic_varada@quicinc.com>
 <7f7962fb-1772-418d-b06e-97ea33099ade@denx.de>
 <Z4S0+YLNHJ1j4j+g@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <Z4S0+YLNHJ1j4j+g@hu-varada-blr.qualcomm.com>
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

On 1/13/25 7:38 AM, Varadarajan Narayanan wrote:
> On Sun, Jan 12, 2025 at 09:48:41PM +0100, Marek Vasut wrote:
>> On 1/10/25 8:43 AM, Varadarajan Narayanan wrote:
>>> dwc3_core_init loops 'timeout' times to check if the IP block is out
>>> of reset using 'while (timeout--)'. If there is some issue and
>>> the block doesn't come out of reset, the loop will run till
>>> 'timeout' becomes zero and the post decrement operator would set
>>> timeout to 0xffffffff. Though the IP block is not out reset, the
>>> subsequent if check 'if !timeout' would fail as timeout is not
>>> equal to zero and the function proceeds with the initialization.
>>>
>>> Make this a pre decrement to address this.
>>>
>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Does the following patch work too ? It removes all the fragile open-coded
>> polling
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index a35b8c2f646..7e7017d4be7 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -29,6 +29,7 @@
>>   #include <linux/usb/ch9.h>
>>   #include <linux/usb/gadget.h>
>>   #include <linux/bitfield.h>
>> +#include <linux/iopoll.h>
>>   #include <linux/math64.h>
>>   #include <linux/time.h>
>>
>> @@ -587,7 +588,6 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
>>    */
>>   static int dwc3_core_init(struct dwc3 *dwc)
>>   {
>> -	unsigned long		timeout;
>>   	u32			hwparams4 = dwc->hwparams.hwparams4;
>>   	u32			reg;
>>   	int			ret;
>> @@ -610,17 +610,12 @@ static int dwc3_core_init(struct dwc3 *dwc)
>>   	}
>>
>>   	/* issue device SoftReset too */
>> -	timeout = 5000;
>>   	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
>> -	while (timeout--) {
>> -		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
>> -		if (!(reg & DWC3_DCTL_CSFTRST))
>> -			break;
>> -	};
>> -
>> -	if (!timeout) {
>> +	ret = read_poll_timeout(dwc3_readl, reg,
>> +				!(reg & DWC3_DCTL_CSFTRST),
>> +				1, 5000, dwc->regs, DWC3_DCTL);
>> +	if (ret) {
>>   		dev_err(dwc->dev, "Reset Timed Out\n");
>> -		ret = -ETIMEDOUT;
>>   		goto err0;
>>   	}
> 
> This worked too.
> 
> Tested-By: Varadarajan Narayanan <quic_varada@quicinc.com>
Please send a V2 patch like that , including the TB , thanks !

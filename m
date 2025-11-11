Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF804CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 10:29:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 532DE83EC9;
	Tue, 11 Nov 2025 11:29:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bQj/LnxV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D04B83F56; Tue, 11 Nov 2025 11:29:34 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 121C183968
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 11:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so47124555e9.1
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 02:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762856971; x=1763461771; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iLQLaAYoF5sBEMqynPRbqYUuXnmPm7GhyIu6xJejd50=;
 b=bQj/LnxV2bI9R4li+yfm3yPIVWVpglJGqeHaKvf0RJanWftE7H8o649qa7QRo6RcOn
 4GP2E+mhf48ppt8c9QzJSAUCEMQod1+ulpxnZRKRu7Z9j9ENJ6ij+sihKUN2oyH+hHW9
 g9A/4F6VpPfNS2oGqBY1Mv5IgS4sDA0S+81nmaqqCwUIBgdXFmgnWiWuB2qvyOmqA8au
 9MhkAiJcxzr+th+g2x9rE8iFuhnQkrikbJaRpCqfMYAU538s9YixlVthTKVwScnziUsp
 Uxwt6MYZBB5/17mEAKuaHNrCVzUOrc6lbyrG4FkNJ8jxGKd5lx2GWkNHGpmnI8IgQcSD
 1a/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762856971; x=1763461771;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iLQLaAYoF5sBEMqynPRbqYUuXnmPm7GhyIu6xJejd50=;
 b=JOk7WCe1s383jxXJ6M9ZlZ82hlX+wzAoaj4jfN3DtpIvMONtnqAQpA8dldb/W4u9N/
 qYNyQU3fx6sWBnc99wel/KCO8EtI68LKVWOZn96ZYEJPeedUBXY03zo+MKMy5NwhqoW7
 SUE/gvNOUk//5uyGLHu1GJHlrbIiyVgnzohXG+4ijPSs3QjvbbuD+wl7MlBWa38bCKqY
 r2NsVjdQg8V2XqUfkkZ6VCYr3g6IwqMl3B9Pj0nZAtKwBPdYJIbyUH03F8UPtbW8fdPW
 8MpeN7HjHRphG2b4xFO478MNXLUZa3loGw2b9C4KcQ2Ka9RCvvpfFHu4SrtsZog8UgDL
 4qaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHkPCRoUwIobzkjnkGW/7ZYQAeomSQNwwd5v4PCV5Dkhy6YQWahcxWj2AILhcFIvsXgOOEOVA=@lists.denx.de
X-Gm-Message-State: AOJu0YwJe1V9ihLQh3mUKdFtseAmYBaeB9pndpgvaKS4sX67CeAkmoq4
 RXf40jvZ8WllsToJBA4R1ni4RW3TItevj9D1Uaws28+4WhsIiv5o66zmkXxgd4mJG55MhLqONlU
 DSRe1oIU=
X-Gm-Gg: ASbGncvs859UyuCv3A2LSabGTsJwByQV5BhksOr7minYzTdClO5nIo4Au5AH3/bAvdl
 TPpIQCDyYjUQCNB68/9PJ463PqIXtaXxxoQ6psHQrPQGHqC4o/8BG/QvNFJ4gpKTDRZOo83xUvi
 rZK0mBler3lWJWMYetjvJrfJZVSIOD4Tb/fl0Wj/o1vztzYwEL5FDzokxe3i5VkR+rORE/0Qb3E
 dzkXaQujnA3IZoZVTYRI9muaQ/jSlyQnM5L7tN39NHZib37oDFMfea/1AOc/4NNNrn+69OAKTjL
 m5nJWMUOUXVKcaxShToxH8/rjooViRzZBdR99rA4zcTtnMxeX5otZZ6vXLQnBHX+zMfYMMWcvNX
 SmO/sDvjnKVU9FogR1CQhADgJONz0OtxWjlQonyOoIE+dYYaXzlxIG0rfhIfohGgQ7VpBjQK/Pa
 iguZUPAx4=
X-Google-Smtp-Source: AGHT+IEn1W72Y+A7EDG6TFeN1YT4LKeKnIb9TGtVi9vbzkRZtg2xKTdtGJZ/gIprybNseuKahLLK/A==
X-Received: by 2002:a05:600c:474c:b0:475:da13:256b with SMTP id
 5b1f17b1804b1-4777329777amr103063405e9.38.1762856970946; 
 Tue, 11 Nov 2025 02:29:30 -0800 (PST)
Received: from [192.168.0.39] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778164b7fdsm17154125e9.3.2025.11.11.02.29.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 02:29:30 -0800 (PST)
Message-ID: <36ad560d-48d6-4ffb-bcde-b031bdcc3f33@linaro.org>
Date: Tue, 11 Nov 2025 12:29:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mtd: rawnand: atmel: set pmecc data setup time
To: Zixun LI <admin@hifiphile.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
References: <20251106-pmecc-v1-0-a1f3cf430be9@hifiphile.com>
 <20251106-pmecc-v1-1-a1f3cf430be9@hifiphile.com>
 <e0a9b9af-330c-4504-8ef3-ba4c3433ce4f@linaro.org>
 <20251107-condone-percolate-51ec103f3ef4@thorsis.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20251107-condone-percolate-51ec103f3ef4@thorsis.com>
Content-Type: text/plain; charset=UTF-8
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



On 11/7/25 13:01, Alexander Dahl wrote:
> Hello Eugen,
> 
> Am Fri, Nov 07, 2025 at 12:52:05PM +0200 schrieb Eugen Hristev:
>> Hello Zixun, Alexander,
>>
>> On 11/6/25 13:12, Zixun LI wrote:
>>> Setup the pmecc data setup time as 3 clock cycles for 133MHz as
>>> recommended by the datasheet.
>>>
>>> Backported from Linux: f552a7c7 ("mtd: rawnand: atmel: set pmecc data
>>> setup time")
>>
>> Maybe use 12 digits commit hash ? I cannot find this commit in Linux
> 
> v6.16-rc4-10-gf552a7c7e0a14 aka
> f552a7c7e0a14215cb8a6fd89e60fa3932a74786 from July 2025.
> 
>>
>>>
>>> Fixes: a490e1b7c017c ("nand: atmel: Add pmecc driver")
>>>
>>> Signed-off-by: Zixun LI <admin@hifiphile.com>
>>> ---
>>>  drivers/mtd/nand/raw/atmel/pmecc.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
>>> index e500a0fe3f8671ff08195c94c3383696a7731eb3..7c4e9bd5f9967b119239adf2b39e683ea62b71fd 100644
>>> --- a/drivers/mtd/nand/raw/atmel/pmecc.c
>>> +++ b/drivers/mtd/nand/raw/atmel/pmecc.c
>>> @@ -142,6 +142,7 @@ struct atmel_pmecc_caps {
>>>  	int nstrengths;
>>>  	int el_offset;
>>>  	bool correct_erased_chunks;
>>> +	bool clk_ctrl;
>>>  };
>>>  
>>>  struct atmel_pmecc_user_conf_cache {
>>> @@ -840,6 +841,10 @@ atmel_pmecc_create(struct udevice *dev,
>>>  
>>>  	pmecc->regs.timing = 0;
>>>  
>>> +	/* pmecc data setup time */
>>> +	if (caps->clk_ctrl)
>>> +		writel(PMECC_CLK_133MHZ, pmecc->regs.base + ATMEL_PMECC_CLK);
>>> +
>>>  	/* Disable all interrupts before registering the PMECC handler. */
>>>  	writel(0xffffffff, pmecc->regs.base + ATMEL_PMECC_IDR);
>>>  	atmel_pmecc_reset(pmecc);
>>> @@ -884,6 +889,7 @@ static struct atmel_pmecc_caps at91sam9g45_caps = {
>>>  	.strengths = atmel_pmecc_strengths,
>>>  	.nstrengths = 5,
>>>  	.el_offset = 0x8c,
>>> +	.clk_ctrl = true,
>>
>> This appears to be done only for sam9g45.
>>
>> So, Alexander, this should not impact sam9x60 .
> 
> Yes it should.  According to arch/arm/boot/dts/microchip/sam9x60.dtsi
> the compatible used on sam9x60 is "atmel,at91sam9g45-pmecc", see:
> 
> 	pmecc: ecc-engine@ffffe000 {
> 			compatible = "microchip,sam9x60-pmecc", "atmel,at91sam9g45-pmecc";
> 			reg = <0xffffe000 0x300>,
> 					<0xffffe600 0x100>;
> 	};
> 

Yes it looks you are right. sam9x60 does not have a dedicated caps but
reusing the sam9g45 one, and I missed that.

Thanks

>> I looked a bit in the Linux driver and this appears to be just as bad:
>> 133 Mhz clock config hardcoded. I would expect this clock to be taken
>> from a clock input and not hardcoded. But oh well, if this clock is to
>> be changed in another device, it would be exposed somewhere...
> 
> I did not look into that deeply, but if it is like you said, someone
> should.  This sounds bad.
> 
> Greets
> Alex
> 
>>
>> Eugen
>>
>>>  };
>>>  
>>>  static struct atmel_pmecc_caps sama5d4_caps = {
>>>
>>


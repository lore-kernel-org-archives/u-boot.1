Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59F8C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 11:29:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0319A88744;
	Mon, 19 Aug 2024 13:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uXZPKVwK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8F2E88A2C; Mon, 19 Aug 2024 13:29:00 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B7FC88622
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 13:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ef23d04541so50859831fa.2
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 04:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724066938; x=1724671738; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E4TreXS25XtZ6y/n8nTYdXvWAv9wqdJRcBPh16oLhMg=;
 b=uXZPKVwKaxDvf2rKoFbcYn6VrkvTwZ5MgP2KNvdLxxFp9YPV8tYYpx6mWM91ayyWKn
 R0khTMJG9tPHLUVlUJFzFt7HedM76uVzTNiyZI2CEYqs5qihOGrOfDU9Ebuxv/QCq7tu
 6qSG7zTWynBPHhIjwinZI2+sRdS8oVUSjJNUr+JSAsRrFnsk1ZOvZunHxBCalGmYfDhP
 RuMZ1c1s0mrh6Jk0mSlnhidq4ESqZEIrEDOBUlAulnD6/skjcRPwnvXdLPuR/MK8/7vr
 zltnt/QCIoGEuoDCGjmZkT75GCX4vJDsjFHfj1lR5SoOLiya9FG8MBZtqvivS3uZQVIt
 eAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724066938; x=1724671738;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E4TreXS25XtZ6y/n8nTYdXvWAv9wqdJRcBPh16oLhMg=;
 b=r9qEAv1oyWMjUrhpqJswrAKG1yhc1JWIt9eqh8yYiGR8J/68RYOOySFqXBBndM+vo0
 j2SLviLzODd7pPieGuUNZRMi94+UlCUDU7iaxGn/MOTyJLjSZic2yWMzuzLlDfQJxq35
 Bag+qzLAYCZdTZ9pV7BmO3cE3BSHv0JcWSlbGUO7CH1towqgDtthNcVOlbTsAU4JLx8V
 hj3w8QJ4dAQ5NEnAfbo3WtTzFrX4x2kgUsjyv9jgDIrg+Wx7u+SZqMxwhTyKQQ+sebFU
 jJg4gqTwJNnx1ZEPu2is7p0qXvXePzEYxskcD2lxFr+N+lLkeBMzIfwrUUybt3YSz38g
 5svg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0o2edMoiIRMcF981CjiWoH5sWhRlYu8YSNn+ilslJtE0wmHvHgnaQ1VYQMhXnb6orClQg1vXJhjIQE3ej8zMtM+wW1A==
X-Gm-Message-State: AOJu0Ywu7dVi+rqSfPqxDQ0Ebi4s4/YxcmDeJgz0X0lVHVhTj7aEixlc
 CIjzeXtz+a8f6/e3lvSLimCPFXaZ0/VcKzcer7OlT38Q12r2nWS0erwAP8Ki+Ec=
X-Google-Smtp-Source: AGHT+IFdk0KGUCpmRycojn6cpb0ed+IKMAdc23bi+MDOD8P/r6Lg0wfe1I6cHwUpnMPV0LaG1ChwPA==
X-Received: by 2002:a05:651c:504:b0:2ec:568e:336e with SMTP id
 38308e7fff4ca-2f3be575a3cmr72412091fa.1.1724066937470; 
 Mon, 19 Aug 2024 04:28:57 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::676e? ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebbdfa375sm5507766a12.41.2024.08.19.04.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 04:28:57 -0700 (PDT)
Message-ID: <4ca6cb11-f616-4842-b253-21a7ba8253d7@linaro.org>
Date: Mon, 19 Aug 2024 13:28:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: usb: ehci: Fix db410c usb reset not working
To: Marek Vasut <marex@denx.de>,
 "JianfengA.Zhu@sony.com" <JianfengA.Zhu@sony.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "trini@konsulko.com" <trini@konsulko.com>
Cc: "Jacky.Cao@sony.com" <Jacky.Cao@sony.com>,
 "u-boot-qcom@groups.io" <u-boot-qcom@groups.io>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <OSQPR04MB77401D18913B397B768EC042908C2@OSQPR04MB7740.apcprd04.prod.outlook.com>
 <6d338e52-2817-4612-8592-f67cbf942b48@denx.de>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <6d338e52-2817-4612-8592-f67cbf942b48@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 19/08/2024 13:21, Marek Vasut wrote:
> On 8/19/24 4:05 AM, JianfengA.Zhu@sony.com wrote:
>> usb reset not working error log
>> ====================================================================
>> dragonboard410c => usb reset
>> resetting USB...
>> Bus usb@78d9000: Port not available.
>> dragonboard410c =>
>> ====================================================================
>>
>> After commit ed8fbd2889fc ("dts: msm8916: replace with upstream DTS")
>> msm8916_usbphy will be defined as a child device of usb@78d9000. usb 
>> reset
>> will first call usb_stop, and msm8916_usbphy as child dev will be unbind
>> in usb_stop, and there is no bind operation in do_usb_start 
>> afterwards, so
>> the msm8916_usbphy uclass cannot be found. This causes ehci_msm probe to
>> fail.
>>
>> Detailed calling process
>> ====================================================================
>> usb reset:
>> |-> usb_stop (drivers/usb/host/usb-uclass.c)
>> .|-> device_find_first_child
>> . |-> device_unbind(rh); <== (unbind msm8916_usbphy)
>> |-> do_usb_start
>>   |-> usb_init (drivers/usb/host/usb-uclass.c)
>>    |-> device_probe(bus);
>>     |-> ehci_usb_probe
>>      |-> generic_setup_phy <== err couldn't find msm8916_usbphy
>> ====================================================================
>>
>> Fix: rebind the msm8916_usbphy driver during ehci_usb_probe if the
>> msm8916_usbphy uclass has been removed.
>>
>> Signed-off-by: Jianfeng Zhu <JianfengA.Zhu@sony.com>
>> Reviewed-by: Jacky Cao <Jacky.Cao@sony.com>
>> Reviewed-by: Toyama, Yoshihiro <Yoshihiro.Toyama@sony.com>
>> ---
>>   drivers/usb/host/ehci-msm.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
>> index ff336082e3..7cb3ae0849 100644
>> --- a/drivers/usb/host/ehci-msm.c
>> +++ b/drivers/usb/host/ehci-msm.c
>> @@ -47,6 +47,8 @@ static const struct ehci_ops msm_ehci_ops = {
>>       .init_after_reset = msm_init_after_reset
>>   };
>> +static int ehci_usb_of_bind(struct udevice *dev);
>> +
>>   static int ehci_usb_probe(struct udevice *dev)
>>   {
>>       struct msm_ehci_priv *p = dev_get_priv(dev);
>> @@ -54,6 +56,7 @@ static int ehci_usb_probe(struct udevice *dev)
>>       struct usb_plat *plat = dev_get_plat(dev);
>>       struct ehci_hccr *hccr;
>>       struct ehci_hcor *hcor;
>> +    struct udevice *phydev;
>>       int ret;
>>       ret = clk_get_by_name(dev, "core", &p->core_clk);
>> @@ -80,6 +83,10 @@ static int ehci_usb_probe(struct udevice *dev)
>>       hcor = (struct ehci_hcor *)((phys_addr_t)hccr +
>>               HC_LENGTH(ehci_readl(&(hccr)->cr_capbase)));
>> +    ret = uclass_get_device_by_name(UCLASS_PHY, "msm8916_usbphy", 
>> &phydev);
> 
> Thanks for looking into this.
> 
> Caleb, do you know why generic_setup_phy() started failing now ? Can it 
> be fixed to handle this platform instead ?

I'm not sure, but I do agree that it doesn't seem like this patch 
addresses the root cause.

Jianfeng: could you run the usb reset command with log level 8 and paste 
a log? That might reveal where the FDT lookup goes wrong.

Kind regards,


-- 
// Caleb (they/them)

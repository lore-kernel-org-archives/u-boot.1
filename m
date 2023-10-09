Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726A6E95A97
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 23:40:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 945EF8640F;
	Tue, 10 Oct 2023 01:40:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SBj6iqp/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FE4A8642D; Tue, 10 Oct 2023 01:40:17 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C606863E3
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 01:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-66b024d26e2so25764726d6.0
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 16:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696894812; x=1697499612; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OVvs86DBZhHVA/PAdgyYiiYZBwSNY41SJneeV2xq9oQ=;
 b=SBj6iqp/tugVcnO1zlkMZCbr1RdJXUQ/JalrGhuN9bAlT7cxynfnJyCEk6hU7ATZRy
 YaZlZmpoA7NIxfnyTEdHqmzSYV0FHwOgZzkRntDRopONBj4lzHHHK1sqUa2/K87IHCa9
 r9460F2tNhDWbMI77mBKT6rtg3OS43Kr341nLuZw82op8lJRhInRgkbgdjG84SfTFKn4
 TyAfv57kIFVAsmYhG/V+RvI2baIbJzafP5FIcY2+GyAV0u+vjNxf+mc49NHkbtyoLMOO
 q3qXuCUaCx3G7t9TMG7ZAxuHBz7VJQET58PQiGrPlhOnAlqNDNGsWUI4C965+JACgk6x
 SLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696894812; x=1697499612;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OVvs86DBZhHVA/PAdgyYiiYZBwSNY41SJneeV2xq9oQ=;
 b=f5VqnqbXWXmaTy+ZAynUBJbf3q/NUPC0nz2hTiT3Grd8L9mBpb1J5xHxIcbsPm6Cjr
 VvqnY6kPkMxWJMu4AJoDmPJIDFbQpLm0s/dvoZJHtmqfDJAHtyoreLXK+CfGlm4oGA0j
 fvFuKQT5c8bVQmBx0tXqwGAfaxTt5TzpXq20fl3sCHLAKTOEVZKc4xKGEvag3F7YclAT
 uWbUQeHMZJAkCTPVp0V7v/XvHU1Ow4WQoCkj2kKplpOp3bgMIt3PrlkSm2kE89E8WKE+
 7mYne8J7aLVg6BoZDlnHsmFqZoe41pE4WQiS7KQywJX637mmXghoGxkbDWmrSAKzQ1Wu
 P8KQ==
X-Gm-Message-State: AOJu0YzV/H2pe146WcOCgimrQApXObfph/WLkRdsPZQYSjLubHUcruSB
 GSZEUnseVoCPoM9HpcLB1Zw=
X-Google-Smtp-Source: AGHT+IE7d1h2sqZNS2j6Wj34bXZX7Z66XCi5CgnECAyYXttKla6o6oaJSlVWj1ltWj/oh3Qsau1/Lg==
X-Received: by 2002:a05:6214:627:b0:63c:f325:bb03 with SMTP id
 a7-20020a056214062700b0063cf325bb03mr19537556qvx.8.1696894812052; 
 Mon, 09 Oct 2023 16:40:12 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 d16-20020a0caa10000000b0065b17b925d0sm4278692qvb.38.2023.10.09.16.40.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 16:40:11 -0700 (PDT)
Message-ID: <2ffb2d81-9c63-2ce3-ccba-3d5461008a51@gmail.com>
Date: Mon, 9 Oct 2023 19:40:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 07/25] tegra: Change #ifdef for nop
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Warren <twarren@nvidia.com>
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230924203953.1829820-8-sjg@chromium.org>
 <20230925004346.GP305624@bill-the-cat>
 <CAPnjgZ3ieXXhidSeqzMuPBCgy9UrvOt5zSMO671t1KG9zWAGxQ@mail.gmail.com>
 <cad8dcca-eaa5-872b-db9a-86f5438b120c@gmail.com>
 <CAPnjgZ38gfWghmejpQFkJ9y9F8fdC-Wo-YSHT_4_cu8dW1UDGw@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPnjgZ38gfWghmejpQFkJ9y9F8fdC-Wo-YSHT_4_cu8dW1UDGw@mail.gmail.com>
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

On 10/9/23 11:32, Simon Glass wrote:
> Hi Sean,
> 
> On Sat, 7 Oct 2023 at 17:21, Sean Anderson <seanga2@gmail.com> wrote:
>>
>> On 10/7/23 19:10, Simon Glass wrote:
>>> Hi Tom.
>>>
>>> On Sun, 24 Sept 2023 at 18:43, Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>> On Sun, Sep 24, 2023 at 02:39:25PM -0600, Simon Glass wrote:
>>>>
>>>>> This code is normally compiled for Tegra, but sandbox can also compile
>>>>> it. We should not use UNIT_TEST as a synonym for SANDBOX, since it is
>>>>> possible to disable UNIT_TEST for sandbox.
>>>>>
>>>>> Correct the condition.
>>>>>
>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>> ---
>>>>>
>>>>>    include/k210/pll.h | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/include/k210/pll.h b/include/k210/pll.h
>>>>> index fd16a89cb203..6dd60b2eb4fc 100644
>>>>> --- a/include/k210/pll.h
>>>>> +++ b/include/k210/pll.h
>>>>> @@ -13,7 +13,7 @@ struct k210_pll_config {
>>>>>         u8 od;
>>>>>    };
>>>>>
>>>>> -#ifdef CONFIG_UNIT_TEST
>>>>> +#ifdef CONFIG_SANDBOX
>>>>>    TEST_STATIC int k210_pll_calc_config(u32 rate, u32 rate_in,
>>>>>                                      struct k210_pll_config *best);
>>>>>    #ifndef nop
>>>>
>>>> Tegra? Do you mean sifive?  That's where CLK_K210 stuff is... but it
>>>
>>> Oh yes, I got confused.
>>>
>>>> also seems wrong, you can run unit test on real hardware, and this is a
>>>> test that could (should?) be run on that platform.
>>>
>>> Only if it enables UNIT_TEST. You cannot run unit tests without that.
>>> The current tests are designed for sandbox.
>>
>> FWIW I have run this test on actual hardware. My intent here was to allow
>> unit tests to access functions which would otherwise be declared static.
> 
> Er, with or without UNIT_TEST enabled? How can it even build if this
> declaration is only for sandbox?

With UNIT_TEST of course. Although since this is a forward-declaration, the
UNIT_TEST ifdef isn't really even necessary. If it's on actual hardware, nop
should already be defined. So maybe this should be something like

#if CONFIG_SANDBOX
#define nop()
#endif

--Sean


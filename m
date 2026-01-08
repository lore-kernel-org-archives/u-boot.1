Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96429D1D48A
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 20:44:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25AB6842DB;
	Thu,  8 Jan 2026 21:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d/Pj8YTF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F8A3842F2; Thu,  8 Jan 2026 21:44:08 +0100 (CET)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D111841DA
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 21:44:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-b7a72874af1so672300466b.3
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 12:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767905046; x=1768509846; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8kr7SaGzlD8N+b61d29xO0qW9mUD0AYgMWF2CBd6QfY=;
 b=d/Pj8YTFTHUmb7rn97w0gP9UKYR/GzdBgNdtz46NBStvEyiZbVX9MGJRWpl2WHs2Gs
 V8ufjHJpdi93GI4uCKYYY6ZY4Rty5ykxF7dFkbeqFwAxFCrfimsIrL5i76ewtGzIP6su
 sqAIhXBXzPMd45tWjhUgjXeIGTli+eAjceneggb4ugcAIoomqWI3JKmYwcFWmnBYC+pE
 9+d94e6RcGGmwm3tfcsnfQkqcPzR/Ko0UBOOIiYCv+frCS5Rpf4tzt1a//CUxYdIH0MN
 KKAt0+uP4/WQGQE3BiTqLWOVRstpDDn/P4HPqQkC0ctOIIj8ue9NTTyI9tdQMsqtKNTE
 JNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767905046; x=1768509846;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8kr7SaGzlD8N+b61d29xO0qW9mUD0AYgMWF2CBd6QfY=;
 b=cJw26JARzmrCzs+XyPwpnkM6DmZncTRKZCbjWXlAibo5DiE7LuYoWi2yYLIx0VUYge
 dj8cBybZ46cn39uJvTP4YDEHJB/D+XpqvwAZQQrMG9gdkUQET+S0h4D1BGhbQdJYlfjH
 KUjgJakzFJSP3SsL9TzAyhADs/BzOSyJYfKehhddGHYanznkA5NbW7ywauQkyj4dHEH2
 tmUuqZZJWGP8ffzMEdspzfwFXKmLiT+w3z3ub4ukg0Cgx1C28zkZPnC9DntKcD2kq19m
 BzzvWPvGZkRw6gVCqPEPKJk2Z2HO48Dz/PG8f5dbEnCTYFA8nqVdaST3PJDvNbsN+zk7
 w8vw==
X-Gm-Message-State: AOJu0YyFIALLQCzN4kco6X4BCeRDYICgfiEcd0UF06O3iH7vhG/b14sc
 wqX222VMsU5Z/F1LVkUrDLprcM6tjgRcuz/D6D4Jdk9PnUYBd03V4wCkJnmRAxBdYCQ=
X-Gm-Gg: AY/fxX7LPlV3/9NNgZiY4ytKfXVbpwsZNWQU7LY9V9v+pLRCpODbzqFl/YpIX4Il7l+
 d2DK3U+LsLSVUAUtNsK6fgYSFpGetU4pqRm3wqWuLh0Umm97FFLTCXTKaJRHu+6mDAtBY0pN5yM
 YpnWfn4goqDh7RyLC3KixtxHw5/Mcd+7Mten1/3mjorXy3+BOYZ3WKXuJf4jD5yS+QuElOCywmX
 HfyTb6lQE8lKgtH8gIS3gWIGZVcvTdNpMS2cGB6lZRoAUgkrMUmOmKCwMPwz1Fkk9aWrL1rK8S+
 pPoNAHdQgD63FekSumGy0M3rveABnh3nRLkji6IC/VG6Vl1vz5qjI5u4JortItH4/hQL7gf3T7C
 TAnXN/vCE+K5rHCe090te5OL3CmFI4AGshgIfsjeilIjBSIAgZpldqit7W1wCWhfcIrKNTsCrAB
 /8WzXkQq/GqhEnrWs2T+m3tatD/WLk282kFoB8wgoYeXQLM9K9Umk=
X-Google-Smtp-Source: AGHT+IE3OoKIQfKC3EafdzvPUjBDb5i0z8X94YSX+FQ7GoWbUBgFFt8Z4edMDGQYZGuSh37QadCcHA==
X-Received: by 2002:a17:907:72cf:b0:b73:9368:ad5e with SMTP id
 a640c23a62f3a-b8444f7084emr704064166b.34.1767905045867; 
 Thu, 08 Jan 2026 12:44:05 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a27c760sm932835966b.24.2026.01.08.12.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:44:05 -0800 (PST)
Message-ID: <23321b6c-535a-4b75-b218-f49185de91ff@linaro.org>
Date: Thu, 8 Jan 2026 21:44:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ufs: uclass: fix potential unitialised use
Content-Language: en-US
To: Marek Vasut <marek.vasut@mailbox.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260108191626.3119582-1-casey.connolly@linaro.org>
 <4780165d-9e32-4628-b457-299972a21fa8@mailbox.org>
 <27fd1b95-798f-497b-98f3-2697ad0a6cda@linaro.org>
 <f0eed6c7-54fb-45aa-be22-c1d84c0ebb75@mailbox.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <f0eed6c7-54fb-45aa-be22-c1d84c0ebb75@mailbox.org>
Content-Type: text/plain; charset=UTF-8
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



On 08/01/2026 21:34, Marek Vasut wrote:
> On 1/8/26 9:09 PM, Casey Connolly wrote:
>>
>>
>> On 08/01/2026 20:55, Marek Vasut wrote:
>>> On 1/8/26 8:16 PM, Casey Connolly wrote:
>>>> When host_ref_clk_freq is 0, err will be returned before being set.
>>>> Assign a default value to fix the warning.
>>>
>>> Indeed, nice find.
>>>
>>>> +++ b/drivers/ufs/ufs-uclass.c
>>>> @@ -1854,9 +1854,9 @@ enum ufs_ref_clk_freq
>>>> ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba, struct
>>>>    }
>>>>      static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
>>>>    {
>>>> -    int err;
>>>> +    int err = 0;
>>>>        struct clk *ref_clk;
>>>>        u32 host_ref_clk_freq;
>>>>        u32 dev_ref_clk_freq;
>>> There is another weird piece in this function, look at this:
>>>
>>> ""
>>> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
>>> index 3c8e4299259..da46b3ebdfd 100644
>>> --- a/drivers/ufs/ufs-uclass.c
>>> +++ b/drivers/ufs/ufs-uclass.c
>>> @@ -1868,12 +1868,11 @@ static int ufshcd_set_dev_ref_clk(struct ufs_hba
>>> *hba)
>>>          }
>>>
>>>          host_ref_clk_freq = ufshcd_parse_dev_ref_clk_freq(hba,
>>> ref_clk);
>>> -       if (host_ref_clk_freq == REF_CLK_FREQ_INVAL)
>>> +       if (host_ref_clk_freq == REF_CLK_FREQ_INVAL) {
>>>                  dev_err(hba->dev,
>>>                          "invalid ref_clk setting = %ld\n",
>>> clk_get_rate(ref_clk));
>>> -
>>> -       if (host_ref_clk_freq == REF_CLK_FREQ_INVAL)
>>> -               goto out;
>>> +               return -EINVAL; // I think we want to bail with error ?
>>
>> I don't think we need to error out here, Qualcomm platforms don't have
>> this ref clk wired up properly yet but somehow things are working ok.>
>> +       }
> This will print a warning. If on qualcomm platforms the UFS is working
> and these clock are not needed, then this should be fixed, likely by
> making the clock optional, or using fixed-clock in DT ?

I think the warning is what we want, it will be fixed properly once we
get a driver for rpmhcc which is what provides the ref clk. As for why
UFS works despite this I have no idea but I'd rather assume it's a lucky
accident.

Kind regards,

-- 
// Casey (she/her)


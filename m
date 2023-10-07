Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029B8E95A67
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:30:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 939D086940;
	Sun,  8 Oct 2023 01:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="am4JKZCe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 913EC8691E; Sun,  8 Oct 2023 01:21:47 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10FD486D7E
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a507c72d3eso40848177b3.3
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696720875; x=1697325675; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rPVoGvvuxCPmkm5o4rHHoIF9w779Rl/VMef2UpN+yDw=;
 b=am4JKZCelkDx8L5/8lkl3pJpcw6mrDwCLhotWnfiUq4gYoK1/AAYNg2t8ABuW3pfbc
 MJPvBUrno/U8oJQvRaZFNy0Z21rI1yCHJ3N+htptuhT8lE7AILHvixJj5rd/I9SS78tJ
 ilL+8pW4YYiyCgIUWgik006mMIJt2v+TQq7vtUmVg1BX6WFjAbhZ1t2rqHh7gfE+8nsR
 BwS2RjTLv4UKe58JnjbJE3px2bf/WQoE7aj3YPP7vw/UWKxlYN/IVlAsOZGC/r6c10+O
 zeN9g4+Ba9DPAOvzhb2pjkRFMYEuSQtqRENdFQK+Pruz0DmgXE4GZHbps1ishoJscTsn
 auxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720875; x=1697325675;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rPVoGvvuxCPmkm5o4rHHoIF9w779Rl/VMef2UpN+yDw=;
 b=UlgA4BTjvhZKKFju5rRNrjaIT07aep3DPcmF3Nvtc28xPehyBSV36fZH8TeQtLK+nq
 Ttoyt8SxJLlZA6zxgch7ZD+yy7vXRysiWdaGEhcfOaBW4ukHywBnW1bvvXEwGbO8+N2M
 Gze6XopXxsT09OL02OaA1ZBIig9S75Qvl1dqD5BonbyxvS85XXQ9Wi56ZOm0rq2Q+8vF
 O0u3CQghx9eoq6T0GUQoW6RhkhwPKtZdEZqRhU9j6CL9PiCAq/y7sE6bWio9AQ7MJx3Q
 OJ8LTCLghiHdSorBMfni3iW8e+48skvLnN5j/jTicyGRvKKyhL7mVAajqNNapIbws56H
 J4/g==
X-Gm-Message-State: AOJu0YxogXvbz61dJokjeDfykwm2iZqzMhilw8Ea32pW/HinZJHZhhPY
 PoogJcwTmoMOa0DcAr6DWtM=
X-Google-Smtp-Source: AGHT+IELtIFbLYypiXjDjrQiODz7B3DmJ5zZqY7ePvV4HJV9VsiV7PGh+t5BKV9u8WZSIHUrf+cspQ==
X-Received: by 2002:a0d:e8c5:0:b0:59b:50ed:82ec with SMTP id
 r188-20020a0de8c5000000b0059b50ed82ecmr12548711ywe.17.1696720875301; 
 Sat, 07 Oct 2023 16:21:15 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 u18-20020a0cdd12000000b0065b12c7a48dsm2567018qvk.133.2023.10.07.16.21.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Oct 2023 16:21:14 -0700 (PDT)
Message-ID: <cad8dcca-eaa5-872b-db9a-86f5438b120c@gmail.com>
Date: Sat, 7 Oct 2023 19:21:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 07/25] tegra: Change #ifdef for nop
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>,
 Tom Warren <twarren@nvidia.com>
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230924203953.1829820-8-sjg@chromium.org>
 <20230925004346.GP305624@bill-the-cat>
 <CAPnjgZ3ieXXhidSeqzMuPBCgy9UrvOt5zSMO671t1KG9zWAGxQ@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPnjgZ3ieXXhidSeqzMuPBCgy9UrvOt5zSMO671t1KG9zWAGxQ@mail.gmail.com>
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

On 10/7/23 19:10, Simon Glass wrote:
> Hi Tom.
> 
> On Sun, 24 Sept 2023 at 18:43, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Sun, Sep 24, 2023 at 02:39:25PM -0600, Simon Glass wrote:
>>
>>> This code is normally compiled for Tegra, but sandbox can also compile
>>> it. We should not use UNIT_TEST as a synonym for SANDBOX, since it is
>>> possible to disable UNIT_TEST for sandbox.
>>>
>>> Correct the condition.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>>   include/k210/pll.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/k210/pll.h b/include/k210/pll.h
>>> index fd16a89cb203..6dd60b2eb4fc 100644
>>> --- a/include/k210/pll.h
>>> +++ b/include/k210/pll.h
>>> @@ -13,7 +13,7 @@ struct k210_pll_config {
>>>        u8 od;
>>>   };
>>>
>>> -#ifdef CONFIG_UNIT_TEST
>>> +#ifdef CONFIG_SANDBOX
>>>   TEST_STATIC int k210_pll_calc_config(u32 rate, u32 rate_in,
>>>                                     struct k210_pll_config *best);
>>>   #ifndef nop
>>
>> Tegra? Do you mean sifive?  That's where CLK_K210 stuff is... but it
> 
> Oh yes, I got confused.
> 
>> also seems wrong, you can run unit test on real hardware, and this is a
>> test that could (should?) be run on that platform.
> 
> Only if it enables UNIT_TEST. You cannot run unit tests without that.
> The current tests are designed for sandbox.

FWIW I have run this test on actual hardware. My intent here was to allow
unit tests to access functions which would otherwise be declared static.

--Sean

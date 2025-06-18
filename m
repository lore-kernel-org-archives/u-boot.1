Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74CEC71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 18:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17C4882B18;
	Wed, 18 Jun 2025 20:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oQt44pi/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5831182C2F; Wed, 18 Jun 2025 20:01:37 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10CC682B0F
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 20:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6099d89a19cso4187893a12.2
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 11:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750269694; x=1750874494; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vY6F8xOIsKwh89nYHPGalkSh1lEd71EmZ3isCEFGQnc=;
 b=oQt44pi/VIGv76NgliaNwvUgf+SeBNQh/7qNzcGFi3cJPFmKTu1XpkppibS3Z9eGVb
 QURErambUccMV8mEsyuhhUQLiUjm4sJ9wLkKJbFjLAAszbMDoL9gCxbf8KISrq6kov7k
 aWeari8QDZd+qvOCiaqTq2x8ZreCDCOf5PIxEc4cYkPMkEBGErW8rO/iflI/ovLcIyC8
 0oOW2fn2W3+Tl9FtMUEnk9m9zNXJd4CbYnha8ZkFFxHXrGNhhwURShtctu87uekng6HE
 OfukxpmEcFYpsU0vz7BUQkDFG7h44IhZRcOWdwQXPKlMOImBi5uVjIv3wdEziR/wu4wC
 Q6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750269694; x=1750874494;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vY6F8xOIsKwh89nYHPGalkSh1lEd71EmZ3isCEFGQnc=;
 b=OH4WRIHALF9q0mXfdCpB9G63JzoE+WQTumqoZQBHn5Za3uArrofIZu/BZf6IXQQuMW
 g/uJeyw6VFVpN7jAH7Y06e5iqljP/6Je2KSV9tAHApftii/gFPjo8uu0xxlm5bS7Fsau
 Ri5Q1ChAMQK0cqBvt/gzWJ0A4FYNPdoPS+o2tJZbITTITWhDolMWWVt/4h1CqTRg1hE0
 R5or4rAKtfoC2lucGJpIs5HB3saU8E4uOWQMp8ohUCJymeuqxxDERpPqOUrMuk2IZUJZ
 pzXYLiqbLCB0LIjbyfPkEqE1A+q1txYlacZ3DNCegQtHiUMze/WF5n6KcExvItoDdbFq
 OoIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxidZZqZK4/sP+WNlZAgBsVxaDlQp5/WMyRhTkcyXUiqCJ+vGjQO0GNE8hl/IEQAA3RvhFWqQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx89vz45c5TJFSFSuEapb6Wj67wYX9En42X36t0cyRbFsMBx5ul
 tQlNlpie4bEKVy4ExOA+0s4WYcAHmbxdZZNqEjThp0upvMsdkjFMx+5ZSR2pq9+JAeI=
X-Gm-Gg: ASbGnctcr60whumnTKZewD9QkDp2sEUfvNv/3SLyjFey22rMwQ82SLXwkgBPfeAj454
 mVcspUwriP+T09Xm/kLU6OK4uqbHD8S/9gA/zOcpVcQbG1A0CWiChsk08BR9HRl0Igc6YZi1/1c
 +yUgxhDZiE3Hp39+D7JfOpHkSsWS4pqiHyab571dAdNFh6EooklnY4z/hh4P1DWl3Zv1RtJ55Zc
 mMlrdN+8KoW6D9rGnez/fPascBLNXxoHuZrhh/00HrHUP3ZP2QNH2CV2fkwqSyO7E350s4238v0
 +cBBgV4OgCNfSbj3N7A4gsID5wziykBKqRGXeTCR/cJm3NTPIOTcDJPO3/Kb8K5PNMcGlVPMg50
 eaMbn1yBd/vZ9y6OZIuvxKmsXR7Q6i8wKsvu+6R7neglZQ2D0t8Y=
X-Google-Smtp-Source: AGHT+IE7T3RfxZkK9vub8jF5xyFmIs2RA+Aj/E75UgcRbhDdEGdDmym1SZOvN5JEma4oXGKZ2gtZ7Q==
X-Received: by 2002:a05:6402:1e90:b0:606:eb8e:d975 with SMTP id
 4fb4d7f45d1cf-608d00a61fbmr16676173a12.0.1750269694298; 
 Wed, 18 Jun 2025 11:01:34 -0700 (PDT)
Received: from [192.168.23.225] (ip-037-024-206-101.um08.pools.vodafone-ip.de.
 [37.24.206.101]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6097bf50ab5sm4358941a12.43.2025.06.18.11.01.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 11:01:33 -0700 (PDT)
Message-ID: <dcf32b9c-d8ea-404a-942c-a72dbeccc18f@linaro.org>
Date: Wed, 18 Jun 2025 20:01:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk/qcom: sm8250: Fix variable name of msm_clk_data
To: Luca Weiss <luca.weiss@fairphone.com>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>, Sean Anderson
 <seanga2@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250611-qcom-clk-variable-names-v1-0-37615b74daad@fairphone.com>
 <20250611-qcom-clk-variable-names-v1-2-37615b74daad@fairphone.com>
 <267f957f-f74d-40f9-a65a-da00ea12810c@minlexx.ru>
 <DAL7BBN0YH1Y.1HOHC7JM44TFF@fairphone.com>
 <6857eb08-c3d8-4a02-b8c0-b608977ffea1@linaro.org>
 <DAONZND9ACD3.35GQ47V0IVE46@fairphone.com>
 <DAPM3N6M8HZK.3139OVRBRU92O@fairphone.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <DAPM3N6M8HZK.3139OVRBRU92O@fairphone.com>
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



On 6/18/25 13:11, Luca Weiss wrote:
> On Tue Jun 17, 2025 at 10:27 AM CEST, Luca Weiss wrote:
>> On Fri Jun 13, 2025 at 6:55 PM CEST, Casey Connolly wrote:
>>>
>>>
>>> On 6/13/25 08:45, Luca Weiss wrote:
>>>> On Thu Jun 12, 2025 at 5:49 PM CEST, Alexey Minnekhanov wrote:
>>>>> On 11.06.2025 15:08, Luca Weiss wrote:
>>>>>> Update the variable name to sm8250_gcc_data as it's in the sc7280
>>>>>> driver.
>>>>>
>>>>> Hi!
>>>>> But why are you mentioning sc7280 here, while fixing clock-sm8250.c ?
>>>>
>>>> Copy paste from the other patch :'(
>>>>
>>>> Will fix, thanks for spotting!
>>>
>>> I'll fix this while applying, np (already picked this patch up...)
>>
>> Thank you!
> 
> Quick process question, how do I find out if a patch has been
> accepted/applied? Am I supposed to check patchwork, or are there
> b4-ty-style emails for it?

I will be sending b4 ty emails, I have made the mistake lately of 
leaving some things that ought to be done during review until the point 
where I pick the patches, and I want to make sure CI is passing and 
everything applies before sending those.

I'm hoping to get better at it this cycle...>
> I'm trying to keep track of patches in my inbox that are still
> outstanding with labels, so it's basically about when I can mark it as
> accepted.

You can check patchwork or see what's pushed to the snapdragon custodian 
branch

https://source.denx.de/u-boot/custodians/u-boot-snapdragon

Kind regards,

> 
> Regards
> Luca
> 
>>
>>>
>>> Thanks>
>>>>>
>>>>>> ---
>>>>>>     drivers/clk/qcom/clock-sm8250.c | 4 ++--
>>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/clk/qcom/clock-sm8250.c b/drivers/clk/qcom/clock-sm8250.c
>>>>>
>>>>>
>>>>> ---
>>>>> Regards,
>>>>> Alexey Minnekhanov
>>>>
> 

-- 
Casey (she/they)


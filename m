Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798B5C71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 16:55:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00B5482D34;
	Fri, 13 Jun 2025 18:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xyYpBxmD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 682F182D34; Fri, 13 Jun 2025 18:55:34 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8514882CA0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 18:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a548a73ff2so2307812f8f.0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 09:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749833729; x=1750438529; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lC/poenttV//20AiVnBeMfS1YhXw2SW5fK4YDCTs4CU=;
 b=xyYpBxmDmW09hZ5psBwrYCf9cVI+x4/J8nHd4QTK1+NirZ3/dRp1XAxSOGEzrCXhU5
 qMGxcq1bNCUdTLr7e+4SvCHIutp35QL1Vs/DFuRc+lD7yP+/jyLEkPLlevxNPdjAHEqM
 snrkA72sSeqF1EJOsSITQlU4xTpd8MD+3Ns8h7SZMVdbdTsE6jHuJTyrKdex/yxbsiLG
 Oa6OGc322M5gCrCD/fRNAPhpSGXgdmdNcDWUPt8yB+vUWKAAwqdhVBjPvUJl58Go4ECx
 gkG5so+jB4cbMbvDMZi6HB9hlRK4fZ/49W19sw9Kkf1XrWoRKiP8iVXkZnz6f1v+Bfms
 +Lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749833729; x=1750438529;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lC/poenttV//20AiVnBeMfS1YhXw2SW5fK4YDCTs4CU=;
 b=tiQPxyaThYu8MPxzzwzzvHf6E1eNQXTbdv6j8GhfsDCD8RQCD2UmIx4u2vDMwXzNik
 1TZQ9B9EhYksf7jKfTSN0gOjwu9RsCdWPuaS8t9tOdsE3T8OhXngnba3bB2LU9jCxddW
 eIntUU8QbwLmmr0a2Pgug6ggwgbUNtspvRv8O2YCAuAz962oed/dcOXtisZRmQpPTrp4
 h8NG5ZZssAnFMyioJC6wZTD4UieoY4vORrfN54mv3Kcsb2A6b8/7yJG2FEbwJ0ki1C+G
 V+aRaSKkWH/YlAbiL9Wd1zNgpCBqx44tNI0a/NTLxk/DTafCvqE75AhVZe+3J8V52RK6
 rUvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZYTk9DN5Bb7vaGEWleEDqtJhDlGUYWfhpEXwbO/8E8eFazgODo96dvDVhub94iS6KX8sEvCs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1TspFQGRjGflkh6VyKMKaCRVTQGtJJfv6LMVo6nrN9w0gzl8T
 8FuB5ZXcaKBLZM9g4d7y0Y10rLN3TA+NWyJ4xK2/iQuDLXkTCm6T3ykfVvmVF9ZMvUs=
X-Gm-Gg: ASbGnctJbwnVZDQCU+w77ES1bZMdfWP6VGjhVh8ysVbTp8HRJNNlqfIr5Fj4w6nCP7y
 4EUs3AL1r3hHZgICoNBchSjb3aG9Fsd4uK/WcBoBlFLc/JrDIzRG79DQwaQ9POF65KFykjwwLtK
 uE0UNQLsS0A1XZMnKeTVCgAa1c+qkpKP1btl7ePzE5aK69qJnV9DEKvOBXwEhut64P92U1QbhQG
 XZEkNOWi62/OMcedF//94eOmRVEixUkkSNipuRCpJUuoaLNWcNVqIiJCLNf+lCXVXZ2c5VdSxpr
 ZKOD/O4W2YJ7/RYmW4KVacybzxbxmBo+m0FHagXpUMCeddRqAyXJ1cKjXPs+9SGnWGUP0fo+cLe
 O/fJShYBAtEZXtOHkx+lyGOi2JVeAccq2Z791
X-Google-Smtp-Source: AGHT+IE2UnpAiClIyqzj7nS9r59fbp2FmjIZYGn5LUt8HnMxvXVdKuUN2JX5g8lPuO+TJ8NTatH17A==
X-Received: by 2002:a05:6000:22c1:b0:3a3:7115:5e7a with SMTP id
 ffacd0b85a97d-3a572e8a191mr470063f8f.42.1749833728895; 
 Fri, 13 Jun 2025 09:55:28 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:19e6:b5d7:f8b4:a927?
 ([2a01:170:117e:fc:19e6:b5d7:f8b4:a927])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b09148sm2953520f8f.58.2025.06.13.09.55.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Jun 2025 09:55:28 -0700 (PDT)
Message-ID: <6857eb08-c3d8-4a02-b8c0-b608977ffea1@linaro.org>
Date: Fri, 13 Jun 2025 18:55:26 +0200
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
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <DAL7BBN0YH1Y.1HOHC7JM44TFF@fairphone.com>
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



On 6/13/25 08:45, Luca Weiss wrote:
> On Thu Jun 12, 2025 at 5:49 PM CEST, Alexey Minnekhanov wrote:
>> On 11.06.2025 15:08, Luca Weiss wrote:
>>> Update the variable name to sm8250_gcc_data as it's in the sc7280
>>> driver.
>>
>> Hi!
>> But why are you mentioning sc7280 here, while fixing clock-sm8250.c ?
> 
> Copy paste from the other patch :'(
> 
> Will fix, thanks for spotting!

I'll fix this while applying, np (already picked this patch up...)

Thanks>
>>
>>> ---
>>>    drivers/clk/qcom/clock-sm8250.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/clk/qcom/clock-sm8250.c b/drivers/clk/qcom/clock-sm8250.c
>>
>>
>> ---
>> Regards,
>> Alexey Minnekhanov
> 

-- 
Casey (she/they)


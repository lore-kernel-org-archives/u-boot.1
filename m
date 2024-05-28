Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F4DC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 16:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78FE3882B4;
	Tue, 28 May 2024 18:27:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KUHDhGwl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A05588549; Tue, 28 May 2024 18:27:23 +0200 (CEST)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF4FB87E96
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 18:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso106694166b.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 09:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716913640; x=1717518440; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hXmAQOHBLbGEwqVNfymi5CC0CJ/S1IDwhSQs7u4Urus=;
 b=KUHDhGwldBkDBTedDk0g7M+B31wYoBjJ2nAuCFb7QfHT7RI99fKf4DP/pSQFq4bF6Y
 ALHJ/9zuFTPKRgsFVj5IUpMqVwL2pSXw/1t+av2obx6w8vhh3ei/15RZtxB8JP4ooxup
 hSrk3ReAHKTKFbl8W75yXgKwJsGuudR1Y1b4Uw0eYVXGty3SGhLiKIKl1g0n7vSCzGGG
 /E6G4adQzi1QpMeKFqcxJo4j9gtD5K7yH+O4IYxglg6khkxk/Qp9qB9uVrs6Fabm/jST
 KUVwVQW3++9b7HBzn2m9QMHdFIYJVn0nOufuDMf5J6nBgGM/5P4w5rt5+sw7rQ73PpFp
 U0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716913640; x=1717518440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hXmAQOHBLbGEwqVNfymi5CC0CJ/S1IDwhSQs7u4Urus=;
 b=VJsXqobzrw2cKf4OIhcbxj6JeQ7INNxS87vBgOZL3yrAIls+fxyLoeyBRR/Kx1ihq5
 GnTD6QoXO7xhMeMDcxqKRuNnfP5PJdTPaclMUXILG+Yhj5suiaRyIwct7JdRmrgX0Zka
 91LfWrjboSOdQWQgWdJK5vo28iMUR2eQWfjl+2fUIDrOLaf3DdclvRxcI7uSb6MZ+stA
 BJNWzuS6zj7KRpja7Mx0vnwsAa7DpeJQBBCwO1mBNsXzTiN1zpcFqkcCINqBVWqoOUdl
 rLAkUvtNRZmnsiQU7TZGukxZzOJcE6ZMdhZURLd8jK2//8YIwTBy1BoB6KQI16hqTqJr
 UHHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp2Jmm5UGSm77e1JKd52Eof8Gr+QYBqeMqQCC9c9fmXLjrr+CLsU+Owvj0ZlT6L7M41dLxRjfQ+eQDFRC0Nmpp+wu7wQ==
X-Gm-Message-State: AOJu0YwmOfGhJ9tYJHloAWIuuAT4Ib3Hw4MZyty+sXEC3tPghbxQD5yd
 mapYt8mcVPJyXvlNT4czKkKhdqNcwJcMzj0FxGu2DfDJGebXCUyq/A3pKfHP8vc=
X-Google-Smtp-Source: AGHT+IEAE/0nc0pjnj8ljqrEZvSNPg7S2jBaLXAuJG/m37b7//gyeWwyTPYXU9qEQ9h123wo6hZz9A==
X-Received: by 2002:a17:906:1db2:b0:a51:8d60:215a with SMTP id
 a640c23a62f3a-a62641dff4cmr906363966b.27.1716913640286; 
 Tue, 28 May 2024 09:27:20 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8bb3? ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a631220b5b4sm189795566b.5.2024.05.28.09.27.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 09:27:19 -0700 (PDT)
Message-ID: <ba1e4253-fcca-4d37-8cb1-810a51caea58@linaro.org>
Date: Tue, 28 May 2024 18:27:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] dfu: add scsi backend
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
 <20240527-b4-qcom-capsule-updates-v2-1-47583d7ad428@linaro.org>
 <87le3ugv33.fsf@baylibre.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <87le3ugv33.fsf@baylibre.com>
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



On 28/05/2024 11:10, Mattijs Korpershoek wrote:
> Hi Caleb,
> 
> Thank you for the patch.
> 
> On lun., mai 27, 2024 at 19:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> 
>> This is extremely similar to the MMC backend, but there are some notable
>> differences.
>>
>> Works with a DFU string like
>>
>>      scsi 4=u-boot-bin part 11
>>
>> Where "4" is the SCSI dev number (sequential LUN across all SCSI devices)
>> and "11" is the partition number >>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   doc/usage/dfu.rst      |  31 ++++
>>   drivers/dfu/Kconfig    |   7 +
>>   drivers/dfu/Makefile   |   1 +
>>   drivers/dfu/dfu.c      |   5 +-
>>   drivers/dfu/dfu_scsi.c | 437 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   include/dfu.h          |  26 +++
>>   6 files changed, 506 insertions(+), 1 deletion(-)
> 
> I reviewed this here [1]. I could not find any response on that thread.
> Could you please respond there or address the remarks for v3, please?


Hi Mattijs,

So sorry about that, will address your feedback in v3.

Thanks,
> 
> [1] https://lore.kernel.org/r/87o7a94pe1.fsf@baylibre.com
> 
>>
>> diff --git a/doc/usage/dfu.rst b/doc/usage/dfu.rst
>> index 8cc09c308d82..dc4f8d672f99 100644
>> --- a/doc/usage/dfu.rst
>> +++ b/doc/usage/dfu.rst
>> @@ -166,8 +166,38 @@ mmc
> 
> [...]
> 
>> -- 
>> 2.45.0

-- 
// Caleb (they/them)

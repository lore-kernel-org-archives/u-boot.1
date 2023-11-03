Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FB0C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 13:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B1FA86F56;
	Fri,  3 Nov 2023 14:31:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HTgPS16Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5228B86F81; Fri,  3 Nov 2023 14:31:40 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DCF386F35
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 14:31:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32f78dcf036so1923477f8f.0
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 06:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699018296; x=1699623096; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mYDpuhK8kmv5UTyAi9/NmEHUcBnrCsAkAjSF5VlRnik=;
 b=HTgPS16QYAKk2t7ERQk2WyA/0K6pcki5zddh2vybkLhBS3A3HcTHtdH9rqSezDvl9E
 b9fJDP2C7jMTWM37P0t5xbE7kjCMBoD8OWanOkMmrUyPMW9fDgCENbdtAp8XxzAc5vtw
 aDSsnAr31nDqZEwFabsvp48S4OPQ8ts67F7s9oZRn5Qp+PgJDbEEKTP0oTFJW18wZ4Lm
 3CS1m4ErM40vFY0HGqVdnmZ44yzw88MPYGwfEinnXm7penPQ8cA5ago5EdXNY+FoOwG2
 JDlX84xTiem18cQJecTcF3e3U4lmqN3qm8aUrIQiH3a0gX38CRDue+UCgDOA+Lh7zTI3
 T/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699018296; x=1699623096;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mYDpuhK8kmv5UTyAi9/NmEHUcBnrCsAkAjSF5VlRnik=;
 b=qgq7mFft0FgfFB3me55BCzYF3X6tbv/so7sMEVoJ+xEg6SVTmGbiIwBTDz933quOT7
 BYAhpz5TNdz/BT19x/GfoMYFfpr75CJ2V4tPOfvMl4A3QnOvpdnG5BwzKRmTzQMovmXV
 dxngticJQEY11LGjegp096P4qMWRnJrvqJvME7wusuVpAudaoFqea4abIgXglfxS0l4s
 9Abytd4AndeLOOEKBDpycxztN45rYenqwXiYmZF0YuHkjGOudpO6HH2YBtZMjXM1eY7L
 cTaIT7JFd13IRsabghXVj6Z5aGWQYRkLmXFnQ2GvEn1BcmA1nWNIuhgvKDldinWnGxAl
 sM0Q==
X-Gm-Message-State: AOJu0YzAQyNbNuygGhMfnNiWHaeswCBRHXGZl9ZBJNAJb3/3R+lGAzOy
 +Tw0dI7+0riLsh5D2U0q6/xcjw==
X-Google-Smtp-Source: AGHT+IGRgVqDHcug2X24SycsD9l/ckaRj5+5e5bLpJQqyy4Puk2xjhZJDYRixCJnPAdsNpOva/YDlQ==
X-Received: by 2002:a05:6000:1846:b0:32d:8a7c:6efc with SMTP id
 c6-20020a056000184600b0032d8a7c6efcmr3222642wri.9.1699018295776; 
 Fri, 03 Nov 2023 06:31:35 -0700 (PDT)
Received: from [192.168.1.7] (host-92-25-138-185.as13285.net. [92.25.138.185])
 by smtp.gmail.com with ESMTPSA id
 k17-20020adfb351000000b003143c9beeaesm1890275wrd.44.2023.11.03.06.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Nov 2023 06:31:35 -0700 (PDT)
Message-ID: <8f74ab2e-2111-4fb0-8cac-7be1566cfe0c@linaro.org>
Date: Fri, 3 Nov 2023 13:31:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update Qualcomm maintainer
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@lists.denx.de
References: <20231031-b4-qcom-maintainer-v1-1-d905d73d8cab@linaro.org>
 <CAFA6WYP=RU2o4mYdmqYLnOxXLFgnp1L0S5oPYNgXsBPtaOhyUQ@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYP=RU2o4mYdmqYLnOxXLFgnp1L0S5oPYNgXsBPtaOhyUQ@mail.gmail.com>
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



On 02/11/2023 11:49, Sumit Garg wrote:
> On Tue, 31 Oct 2023 at 20:49, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> As Ramon has been inactive for some time now, add myself and Neil
>> Armstrong to maintain Qualcomm efforts going forwards.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>> I greatly appreciate the work done by Ramon Fried in keeping Qualcomm
>> support alive in U-Boot the last few years. However it's clear that
>> he hasn't been very active for some time now.
>>
>> I am currently working on a large cleanup effort to modernise Qualcomm
>> support and enable several new reference platforms. To better facilitate
>> this and to handle Qualcomm support going forwards, make myself maintainer
>> of ARM SNAPDRAGON as well as my colleague Neil Armstrong (Amlogic
>> maintainer).
> 
> Thanks Caleb and Neil for stepping up here. Although I won't be doing
> any major development in the near future, I would like to keep an eye
> on the Qcom platforms I maintain as of now. So you can add me as a
> reviewer here if that's fine with you.

Definitely, I'll include you. Thanks Sumit
> 
> -Sumit
> 
>>
>> I hope Ramon continues to participate in discussions and reviews going
>> forward.
>> ---
>> base-commit: cbba1b7766bd93d74e28202c46e69095ac13760b
>>
>> // Caleb (they/them)
>> ---
>>  MAINTAINERS | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index cde778bc4d3d..be3666d14047 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -567,7 +567,8 @@ S:  Supported
>>  F:     arch/arm/dts/am335x-sancloud*
>>
>>  ARM SNAPDRAGON
>> -M:     Ramon Fried <rfried.dev@gmail.com>
>> +M:     Caleb Connolly <caleb.connolly@linaro.org>
>> +M:     Neil Armstrong <neil.armstrong@linaro.org>
>>  S:     Maintained
>>  F:     arch/arm/mach-snapdragon/
>>  F:     drivers/gpio/msm_gpio.c
>>

-- 
// Caleb (they/them)

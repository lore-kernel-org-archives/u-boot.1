Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38544C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 19:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75A2F88BAE;
	Fri, 19 Jul 2024 21:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZJRHxGcC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1655C88BFF; Fri, 19 Jul 2024 21:45:24 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3E0B88BA9
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 21:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5a1c49632deso1352048a12.2
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721418321; x=1722023121; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=irCNOI97C1dmpwFS67+p8hLNmzpy+cqA7K43B2G38uQ=;
 b=ZJRHxGcCDzXs/kThJvygY+VxOMkH/TGSYzbrAiQ7nZCl+NhCof1G+b1t5+twfLiQW4
 AXq+If/AJGx0GzHVkZY0pbOOae7ctowER2M2dwznlcx6g7/A2US/EThHy8KtSckeguqS
 EAJ4s9a9LvkeZoCIE/dsEUq2jqRwz6EHHR4yp0sLd85FJ8CwuGHtPp461xdUsI4bHFqS
 P2By13ZeVnZpdbzoSRsrGxdzq2+gUPrtpzRiVrSRzH4X76CaQnSrVW2kQyBxfUMc+M9Z
 FK739xDyzAu230kBqBh9jl4js+WNDMdYMr2OCsYGn0S/DF1ZwI+5NaWa7DGzEh3z0uHE
 dViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721418321; x=1722023121;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=irCNOI97C1dmpwFS67+p8hLNmzpy+cqA7K43B2G38uQ=;
 b=LwbQTILywFUGjLGu5Rha94d/p1AYaRcoNd+SaJPSh32w8afCQdVmXppKW1ub8CdJYu
 wTXL9puBGXiQKYEaR+rUEJRtMvN+lJAr2phlwsLAZYBu32kZU/71WeOjLmu+vDwcobxZ
 +CsLYbPYZoWTtqKxnCbvjp+TBxGKoyodHl/Nu3jNFVHrUS8Z5IhV7y6SqskKTMlihBTB
 +2mMjbkfgFjkSv5Uaymss3VCg+OnfCctl3XKqlBFe8c/a14Y8yFSuux51/fo7oZkiNUO
 IWbz8D/d4Eo7WXexhSdf//s4/maeJOdAMv99qBUZ1IcYJuMhQzmdgAdci12xCNE7M5C1
 mbjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVusj32XGoeFXTzbr+Hsk30Z8oCymdc+5XgdY5Y+kLG8QP020lBdRXx8TyPdqwU1RbFUmK9dWEYGWpuFCV29tt/uCE4LA==
X-Gm-Message-State: AOJu0YyC/PrFZy6N4YYIlMbi8yszT9BHx3B67FCuzVLRqrK/o1AlbWET
 pAWlN028GN4eIpFGtB4CeJMNjlbInH51krYnokqBBWAd0+2yNxbO55w56zvcz9A=
X-Google-Smtp-Source: AGHT+IEv4W9a5hnyK5ihZVUYHaQbRHheS4ApukCZI4pQeaLKHongVUs2lXcYnGjN9FcvbF4pI0X75Q==
X-Received: by 2002:a50:c34c:0:b0:5a1:2735:2378 with SMTP id
 4fb4d7f45d1cf-5a1273523fbmr4063778a12.30.1721418321277; 
 Fri, 19 Jul 2024 12:45:21 -0700 (PDT)
Received: from [192.168.2.186] ([90.187.152.45])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30c7d32c6sm1600958a12.90.2024.07.19.12.45.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 12:45:20 -0700 (PDT)
Message-ID: <73e4df07-274e-4ceb-9d80-a3b54cc1e960@linaro.org>
Date: Fri, 19 Jul 2024 21:45:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/24] soc: qcom: cmd-db: adjust probe for U-Boot
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
 <20240715-b4-qcom-rpmh-v6-6-0c948a25d018@linaro.org>
 <CAFLszTgz-SOFR+aV7f45+pfByLztAYU1kvFPZof665=QwjjoPQ@mail.gmail.com>
 <c1f036a4-a080-428f-84fd-c44f968d44bf@linaro.org>
 <CAFLszTj-1Pok7mJRGfR5fV20JMp5Hoe0r+4=p0S=NwtxQ0Gdgg@mail.gmail.com>
 <893fc8be-e4aa-46a1-9dd7-774a7f8faa69@linaro.org>
 <CAFLszTgYdSdPv5AhCOZBx0fh1292KAtZ9KBxTE3DVW5PnP6+oA@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTgYdSdPv5AhCOZBx0fh1292KAtZ9KBxTE3DVW5PnP6+oA@mail.gmail.com>
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



On 19/07/2024 17:04, Simon Glass wrote:
> Hi Caleb,
> 
> On Tue, 16 Jul 2024 at 08:16, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>>
>>
>> On 16/07/2024 09:04, Simon Glass wrote:
>>> Hi Caleb,
>>>
>>> On Mon, 15 Jul 2024 at 22:42, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>>
>>>>
>>>>
>>>> On 15/07/2024 13:39, Simon Glass wrote:
>>>>> On Mon, 15 Jul 2024 at 11:08, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>>>>
>>>>>> Integrate cmd-db into the U-Boot driver model.
>>>>>>
>>>>>> This is just a wrapper around an in-memory database, so we just need to
>>>>>> get the address and validate that cmd-db is there.
>>>>>>
>>>>>> Since cmd_db_header will be stored in the .data section we can skip
>>>>>> bind if it's already set.
>>>>>>
>>>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>>>> ---
>>>>>> To: Simon Glass <sjg@chromium.org>
>>>>>> ---
>>>>>>     drivers/soc/qcom/cmd-db.c | 72 +++++++++++++++--------------------------------
>>>>>>     include/soc/qcom/cmd-db.h |  3 --
>>>>>>     2 files changed, 23 insertions(+), 52 deletions(-)
>>>>>>
>>>>>
>>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>>
>>>> Thanks
>>>>>
>>>>> BTW, this is a MISC driver. Does it implement the read() operation?
>>>>
>>>> No, the API (as defined in the header file) takes a string and returns a
>>>> database entry. cmd-db users don't have an easily available handle to
>>>> the node / udevice regardless.
>>>
>>> OK. The closest thing might be UCLASS_SYSINFO, but it is designed for
>>> inside U-Boot and uses an int instead of a string for lookup.
>>
>> Right, I don't think we'll be able to find a more optimum solution here.
> 
> OK
> 
>>>
>>> Could you use the devicetree for this information? What sort of info is it?
>>
>> It maps resource names (e.g. "ldoa1" - the LDO1 regulator on PMIC A) to
>> the address of the resource on the RPMh co-processor.
>>
>> We need to support existing (upstream) devicetree, since this has
>> already been around for many years.
> 
> OK., Has this problem been resolved in more recent platforms?

What problem?
> 
> Regards,
> Simon

-- 
// Caleb (they/them)

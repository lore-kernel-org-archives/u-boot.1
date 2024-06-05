Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86634C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 12:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D96D688313;
	Wed,  5 Jun 2024 14:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sRsyaCg8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF85A88354; Wed,  5 Jun 2024 14:29:31 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD34787AD2
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 14:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a62ef52e837so258334766b.3
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 05:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717590569; x=1718195369; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DgGQiXn93DPT+ejAfIEi0oMWq8HVOf+FMz09y6/cbQ4=;
 b=sRsyaCg8lCm3H1BxHNbVogc6bnhYY+UDGmo0FDY3r77Lfyn18kCxJicinDC4x9pa1h
 GU8DgpgEAuWB0L1cvJiZvdzU12h+63vogCUvURhxe94cHH4N3x65WLIZagTeTznuryRN
 cxojrDaAfN/kEsiy58kstTQjc3HIA48paeb/ctcNtC8M+J8ZZmyby8fMLTKPGWjlWQKQ
 KikT9LCddLAUDe1++iGDa6LL8DNqg6P8PJrkMHe7wrn6WfC/d8PvU0Sj4daC79+QBiv2
 QFdF56tqF1jd5m3ct4hj3xTyQeBwc6FNb+mqjmXrZbYFe24kybae8NNzKeG77NECWh8G
 S4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717590569; x=1718195369;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DgGQiXn93DPT+ejAfIEi0oMWq8HVOf+FMz09y6/cbQ4=;
 b=RPfqfoTUefO//Bk2GNpCZ26/apSeivIO8bapP4iHSYz3r+lYhBzoTTDHccGRqCrA7+
 3km68Nh7BCI12tecTWjgkQtVFOpVTJ1QClKl83DDUftHYwc1BvnuTlq6Gum80is8M7FV
 EKagP0sXx4CarNDbiJzIgLOTRMhWV5hYCvOVueOP376Ya8rSragCa/WFtU+CtkAVB6FJ
 fIy1vMcBdrBq2YkjDkOe3O5gCnCeFpEE4Z62r2umRxKjnEkZ3QQ62Yj/YJrLIZwjnHqr
 BIfufsuUyKACt9pBHFHvrWJcW4qtIq92qVk1FVRk4zwPko5Hur7bs1joKcci8Hlh7tLL
 1C4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3zNNHexAwKyd/vcHCBz6Y+np37dQUFILhPaxHpsYF4313+dl6VOPxbaXpi7Xwp6qU93903WnbS5COAk730/0GYRrIgw==
X-Gm-Message-State: AOJu0Yw4IzZfoIqSJHCQWvHoDto4EI7nN5hQ0W6MYH3cnTTbFrzVHVOn
 dpyv3ENWvm70bQ6EnfcFLZeVXvonKmwSRuIK/8We7MypPGxW6Wye9odViOzX/2Q=
X-Google-Smtp-Source: AGHT+IHk6HFhiyosa8XJbEx2GaC6ovN8xLUWi6VRF5JFTR9w54hCFPY58FO6WKo+vcSjYb8r6RxCjg==
X-Received: by 2002:a17:906:2318:b0:a68:e58b:2c35 with SMTP id
 a640c23a62f3a-a699f56bd3cmr147987466b.31.1717590569127; 
 Wed, 05 Jun 2024 05:29:29 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8090? ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68bc80212dsm612741166b.82.2024.06.05.05.29.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 05:29:27 -0700 (PDT)
Message-ID: <8e4f962b-77c5-4eb7-8147-cd00a73b4172@linaro.org>
Date: Wed, 5 Jun 2024 14:29:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] tools: add genguid tool
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <20240531-b4-dynamic-uuid-v3-6-ca4a4865db00@linaro.org>
 <eb3681f0-ecb9-4775-9093-5640aa408f50@gmx.de>
 <CAC_iWj+s67woD-USmT3+hDq7yO9K_G=WS1DG-oJMM1byPb3JNQ@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAC_iWj+s67woD-USmT3+hDq7yO9K_G=WS1DG-oJMM1byPb3JNQ@mail.gmail.com>
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



On 05/06/2024 11:25, Ilias Apalodimas wrote:
> Hi Heinrich
> 
> On Wed, 5 Jun 2024 at 09:36, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>>
>> On 5/31/24 15:50, Caleb Connolly wrote:
>>> Add a tool that can generate GUIDs that match those generated internally
>>> by U-Boot for capsule update fw_images.
>>>
>>> Dynamic UUIDs in U-Boot work by taking a namespace UUID and hashing it
>>> with the board model, compatible, and fw_image name.
>>>
>>> This tool accepts the same inputs and will produce the same GUID as
>>> U-Boot would at runtime.
>>
>> This functionality should be integrated into the mkeficapsule.
>>
>> Just pass the device-tree into mkeficapsule and generate the GUIDs
>> whereever they are needed.
> 
> I like the idea of moving this mkeficapsule which is already part of
> distro packages but,  isn't it easier to pass the compatible string
> node and the namespace?

Yeah, we only need the first entry in the compatible property, so 
parsing the whole DT is a bit overkill.

I can look at combining these tools, can mkeficapsule generate a capsule 
for multiple images?

Would we want it to work such that you provide the namespace GUID, 
compatible, and image names, and have it generate a capsule with the 
right image GUIDs?

Or would it be simple enough to just incorporate the functionality of 
genguid?

Kind regards,
> 
> Thanks
> /Ilias
>>
>> Best regards
>>
>> Heinrich
> 
> [...]
> 
> Thanks
> /Ilias

-- 
// Caleb (they/them)

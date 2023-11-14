Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80296C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 16:12:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0E0387250;
	Tue, 14 Nov 2023 17:12:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ASNaaJpl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A38387240; Tue, 14 Nov 2023 17:12:37 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DD88868AE
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 17:12:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2c50305c5c4so83505221fa.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 08:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699978353; x=1700583153; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vr9tA38737bd0F0e7imq2tPGA3ifN7FfeN7V+J6va2Y=;
 b=ASNaaJplQdnNdSRVFq4nepPNj2Kt8vGgwP6u4q33yR2hMs70ofIfBXvCxFlEK6VtXh
 2VoXmpgVbfwZMiY+iztUDVIERcjQjcvW1m+2v+O0b18Yc2ssexboqu4kyzilY+KVp0EJ
 Gs29Pv9UTpQV4pw4nU1RqPbG9xD7BZNZ+5KLR5wJghtaqhmzH9GKrNLKRMi/289f6s3u
 nrkhZhsGeNtHKqmXHRhAL5ZTMQlgAxcyLoy9RoHOVPJjteWFYV9riIMlweUSur3TJzZW
 DTM61OLuwvPKhg2+O1iM0I0VDHBy9WARd9P/ji4DzXXz/3uce3enL/fsQ7dX3L+O4U/C
 vazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699978353; x=1700583153;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vr9tA38737bd0F0e7imq2tPGA3ifN7FfeN7V+J6va2Y=;
 b=dPIDQkl51GSVFj/AmU0XenoOuujPArM99Q0z+c1gT3UbCbijZZmHQcyc7/W4My6b1F
 JLPjPVIDqPU4q39R8Q2DNnneOqQ8PXcbDm7uCGJ4tdAbwDjItZxOCEnyi0L+pYiVppyI
 JII3ZJI7WCC9DDwoUedRaQVB8UY0TWiYeJ2Y65ZvB72pqV+4Crdbc4h4MhcAV1iHcizt
 cLeMH3XXOLgJ1ON/OHafGS/Rrv8NWJ4fahnmkQ5iJAZjjVep/3e9OCCUckH/1ogw/dTK
 7FQky/KjpVkI4E0Z7f7jmN73b1CGFWq6HmwjJsCZUEWDHCJvGwRgu7zqjUx/jd7WVxi7
 +uQQ==
X-Gm-Message-State: AOJu0YxItWOuV1eOsovUwihG4GK5KcYzmh38yx5mrw0Eq0QitaIIUBqT
 LLfkMHuqh/dR/20V5wVkMxakLQ==
X-Google-Smtp-Source: AGHT+IGDz7KvMTCUI4+jLoFqIHOOGEBrXMR5lAv3sBFodW6KweQ5F2wDhTp7Wf/xiWbfjQwolNx0eQ==
X-Received: by 2002:a2e:be8b:0:b0:2bc:f5a0:cc25 with SMTP id
 a11-20020a2ebe8b000000b002bcf5a0cc25mr2338504ljr.2.1699978352795; 
 Tue, 14 Nov 2023 08:12:32 -0800 (PST)
Received: from [192.168.1.7] ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 fm14-20020a05600c0c0e00b003fee8793911sm11799771wmb.44.2023.11.14.08.12.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 08:12:32 -0800 (PST)
Message-ID: <2e183cd8-d7fe-4946-92ab-74dd79df772f@linaro.org>
Date: Tue, 14 Nov 2023 16:12:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: avoid using deprecated sphinx function
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20231114-b4-sphinx-deprecation-v1-1-41687254ad8e@linaro.org>
 <20231114154612.GR6601@bill-the-cat>
 <43bd03c9-9485-4446-9a67-6c6bd8fb324a@gmx.de>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <43bd03c9-9485-4446-9a67-6c6bd8fb324a@gmx.de>
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



On 14/11/2023 15:58, Heinrich Schuchardt wrote:
> On 11/14/23 16:46, Tom Rini wrote:
>> On Tue, Nov 14, 2023 at 03:18:02PM +0000, Caleb Connolly wrote:
>>
>>> The execfile_() function in sphinx has been removed after being
>>> deprecated for some time. Follow what sphinx upstream does in [1] to
>>> avoid using this function. This fixes "make htmldocs" on at least Arch
>>> Linux but likely other distros too.
> 
> Hello Caleb,
> 
> Did you set up an environment as described in
> https://docs.u-boot.org/en/latest/build/documentation.html?

No, I used the version of the sphinx library included in my
distribution... Certainly this would have been a good place to check ><
> 
> Or did you try to build with other versions of packages than those
> described in doc/sphinx/requirements.txt?
> 
> It would well make sense to rework our requirements as the Sphinx 3.4.3
> we are using is getting dated.
> 
> Best regards
> 
> Heinrich
> 
>>>
>>> [1]:
>>> https://github.com/sphinx-doc/sphinx/commit/9ced1e355ad6baecd4e755a598a54877dc0aad44
>>>
>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>> ---
>>> base-commit: 92b27528d777ce85362af45e7d2974a6c856219b
>>
>> I think we should cherry-pick:
>> commit 0283189e8f3d0917e2ac399688df85211f48447b
>> Author: Jonathan Corbet <corbet@lwn.net>
>> Date:   Wed Jan 4 10:47:39 2023 -0700
>>
>>      docs: Fix the docs build with Sphinx 6.0
>>
>> from the kernel, to keep the file in-sync. That's the only commit to
>> load_config.py since I believe we synced last, but there might be other
>> changes in Documentation/sphinx/ to grab as well.

Ah, I wasn't aware that this was pulled from Linux, that makes a lot
more sense then :)
>>
> 

-- 
// Caleb (they/them)

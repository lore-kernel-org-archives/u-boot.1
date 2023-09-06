Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A37EB8FAD
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 05:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A96E86546;
	Wed,  6 Sep 2023 07:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lQ4GiXjq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEBB286546; Wed,  6 Sep 2023 07:04:12 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6BCB8666B
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 07:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-27183f4ccc1so1878639a91.2
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 22:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693976648; x=1694581448; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RcL6va75VjgehcXyrlC2rr10HaOMJXz3I5t6kDsqW2M=;
 b=lQ4GiXjqZt7PAPsuDEDightk5zfjRoo2JH4IHazU2DGQvJ0VQmCwOKA+7vZYu0i3Lr
 BgM1TxkI0BWi7UObXJgF40wyMd+5R7LVB2PKvJXSq98oEuhB26OOd1frVn77VUl5oA0e
 SEcnmobOta378rACuGZoStUR6puPH4V/FB4tOVXKrmqw3y7kwp+zA1HFzUvQExYpQ+uY
 d5090icDyKkz3y3Ux3BF60PYK5UAG/ghizl4G3sft7NLtNEj1/yIEnOjLZXQDRWTU1eu
 CprHf89dzlGf6CelSCIeHTkU/gMys6lrPn54ZnJ1PPB6IOgWzXv8PuGcCaVJABwPS5F6
 8dkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693976648; x=1694581448;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RcL6va75VjgehcXyrlC2rr10HaOMJXz3I5t6kDsqW2M=;
 b=NTrPDIPsVjsbmRshYieRo5CCPaL5/U2Nz488HNG0r4K9mvtqVw4EFENreORp9mFVic
 O1qFkkjJAVr0M+y/MlhvmKYc4TCpD+Mg2jcSdBh8FbPBq4srJlx7QEBQYK7Q5AFh6NIG
 ZCg4Ib0r2zG3M2blux/m4t4QLlU7YqhWXh4O0fzOs9sQc5lX6ZNFilNupoYXiGDPzgsq
 txrtE1dk6aXRuFUnQVkuZqZFhXs6cE9LEbY7qsyUA4cRwAaGrf49tkLcwW/KCprrYpSz
 4N/+G/aYwBp6QmgrrwV8sqRLnkNJjvHfkI49egwDkGgi6tK+zrePSXmLFX+MpcIrESIT
 E0lg==
X-Gm-Message-State: AOJu0YxJ9ntciBDF31ujyzuXfNPaFUwpViGVIz3Ip/UfYqpBsKr/QHCK
 x+Q5bp7Zy91w33XXbd1SQa8=
X-Google-Smtp-Source: AGHT+IHajMSdZBBxDeIZuB8EIwVTUe2O9GDA0Mf47F+kcnSijnggISqkx5AYMvSYyTuuxx5vBuTiLg==
X-Received: by 2002:a17:90a:17ec:b0:26d:2198:6117 with SMTP id
 q99-20020a17090a17ec00b0026d21986117mr11704818pja.13.1693976648013; 
 Tue, 05 Sep 2023 22:04:08 -0700 (PDT)
Received: from ?IPV6:2001:470:ec7b:2:65:b591:d36f:9c78?
 ([2001:470:ec7b:2:65:b591:d36f:9c78])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a17090ace8e00b00263f8915aa3sm11709117pju.31.2023.09.05.22.04.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 22:04:07 -0700 (PDT)
Message-ID: <bd2a0c45-9d6a-494b-9ffd-f32fdec21027@gmail.com>
Date: Wed, 6 Sep 2023 10:34:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Adjust gitignore for /build
To: Simon Glass <sjg@chromium.org>, Rong Tao <rtoax@foxmail.com>
Cc: Maxim Cournoyer <maxim.cournoyer@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Rong Tao
 <rongtao@cestc.cn>, u-boot@lists.denx.de
References: <tencent_055CBAA884BC568E56211618940881653D0A@qq.com>
 <CAPnjgZ37OL8XjMu1eOYPYR8OdmEp52tMwbVfJ5+j8_fCE7WRig@mail.gmail.com>
Content-Language: en-US, tr, en-GB
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <CAPnjgZ37OL8XjMu1eOYPYR8OdmEp52tMwbVfJ5+j8_fCE7WRig@mail.gmail.com>
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

On 2023-09-04 22:18 +05:30, Simon Glass wrote:
> Hi Rong,
> 
> On Sun, 3 Sept 2023 at 20:50, Rong Tao <rtoax@foxmail.com> wrote:
>>
>> From: Rong Tao <rongtao@cestc.cn>
>>
>> /build-* can't ignore /build.
> 
> How does that directory get created?

Most likely `make O=build` as an attempt to do out-of-tree builds? FWIW,
I manually create and use build/$board/ directories for build outputs,
but adding "build" to .git/info/exclude is an easy enough alternative.

>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>> ---
>>  .gitignore | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/.gitignore b/.gitignore
>> index 002f95de4feb..9697f0088f80 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -35,7 +35,7 @@
>>  *.tab.[ch]
>>
>>  # Build tree
>> -/build-*
>> +/build*
>>
>>  #
>>  # Top-level generic files
>> --
>> 2.41.0
>>
> 
> Regards,
> Simon

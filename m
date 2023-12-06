Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEFDC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 13:00:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A2A48721A;
	Wed,  6 Dec 2023 14:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iVkuNP6W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2056876FB; Wed,  6 Dec 2023 14:00:57 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C4688721A
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 14:00:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40859dee28cso67252285e9.0
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 05:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701867655; x=1702472455; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cCq17RLvNSN7LWh8G8ko0gMuw4cQAy8n4NADEbfi1Zo=;
 b=iVkuNP6W/D19G2q09Z7JOx7XBC2c2mvL3n3D8GIzLpZ6MybzHLarzrKGuGPdKgZm3R
 jD9gJmHK1h/A3pQ+G5cld0EHUzOvQoG80tdTS8Yg/KqsY6WfUkYS/cqYgu6OzUET9qUa
 7qFyOiy+tiyCzvf6mAuSjkB6Ugv2LyQyKR83orNUZklXMsz/7OZ89K5qPK2hA+gWGGnp
 qW785PeBa/EvIzAk9+FecTD7q6yMevePzSPbeuQj3cJf4Nk3uyoDvbDAsN1SriQXpYj9
 M++h1J1z9/zNC+CE6qfxKITQ1DCcN9hgYlXYAnr+AFVCH62UasWT3oDxkcHyYRsumIIk
 N/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701867655; x=1702472455;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cCq17RLvNSN7LWh8G8ko0gMuw4cQAy8n4NADEbfi1Zo=;
 b=BbIP2RvTtiiCSATHK+CKS+Jwrlio8QubOBygCxNrF5+PPgJOV+lkCyNCxIj6uptK1P
 OMgumWEbKi7lQ9Awq0IIvpePQSYbuoy8Rlx2kYttap2nXqEsa4EHyfmaYljHCrM6srOa
 I+paSu4vGM5qm9xwF2xrp8pYyIRLRqH7HdoGyUAbrfpH5+KWV7plR4LqWDjll+PVg/yp
 WMyOH9f6DQaS5tdQtcng7YI5j/pQvEpFBdg8Tj7KgE3V0o5wPnXrS36q/HRT4VnHnV4A
 l2gTkpEnosoz2BLcxndSRww9YiWsEoN+nUOUIQ6yeHeTN65N6VEXzlrLYbAqBcOekEX9
 8alA==
X-Gm-Message-State: AOJu0YzS6yB0eFtUuMMu1MVzv2Sqjjccb4A64+HSnhXe5+57C6WN3b/D
 pzMjRH3zwbUvvtRw77Lo1Hio+A==
X-Google-Smtp-Source: AGHT+IEgJnHr1dDYMfD8YiDmBt+Z3E2yqKFerGk6Mc7D6/cZQIr6W6hr4V7PmOz7+3RNnmZj8DVOGw==
X-Received: by 2002:a05:600c:21c9:b0:40b:5e22:97b with SMTP id
 x9-20020a05600c21c900b0040b5e22097bmr586928wmj.106.1701867654674; 
 Wed, 06 Dec 2023 05:00:54 -0800 (PST)
Received: from [192.168.1.15] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a05600c199400b0040b36ad5413sm21895019wmq.46.2023.12.06.05.00.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 05:00:54 -0800 (PST)
Message-ID: <80bb2d7b-31e3-43a2-b1f7-f18e66c0a0da@linaro.org>
Date: Wed, 6 Dec 2023 13:00:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] Qualcomm generic board support
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski
 <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
 <CAPnjgZ03MEK_PeuaXcR1VuC-_tBmQmrzq3bo-jS3Jd22+rSgww@mail.gmail.com>
 <CAFA6WYOQX64jArOAV1W-8=174pru78SotGNVhjYth8qu=Swa=Q@mail.gmail.com>
 <CAPnjgZ0y9VF5Mpx2VVtDnR6NFhs7mi=aAaByV4jqgDvUwZH60g@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAPnjgZ0y9VF5Mpx2VVtDnR6NFhs7mi=aAaByV4jqgDvUwZH60g@mail.gmail.com>
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

Hi Simon,

>>>> - gzip u-boot::
>>>>
>>>>        gzip u-boot-nodtb.bin
>>>>
>>>> - Append dtb to gzipped u-boot::
>>>>
>>>>         cat u-boot-nodtb.bin.gz
>>>> <linux-tree>/arch/arm64/boot/dts/qcom/your-board.dtb >
>>>> u-boot-nodtb.bin.gz-dtb
>>>
>>> What is this?? Who or what uses a gzipped image with a single DT attached?
>>
>> The gzipped image is loaded by Qcom proprietary bootloaders (ABL or
>> LK). It is the usual way Linux is booted on these platforms. U-boot is
>> being brought into this chain to leverage standardized EFI boot
>> processes.
> 
> LK is Little kernel, I believe. That is an open source project, right?
> But I suppose it is BSD licensed so in fact the code is not available?
> Is ABL obsolete?
> 
> I'm not sure that it matters in any case. We should be able to
> standardise the U-Boot part and let the private projects implement
> that, for a seamless boot.

Realistically we aren't in a position to change the bootflow on Qualcomm
boards. This may well change in the future, but for now this is the best
we can do.

On a personal note, I work on a project called postmarketOS, we try to
run upstream Linux and a fully FOSS userspace on phones. I support a few
Qualcomm devices there, and currently the biggest annoyance has been the
bootloader. We can't change it, most OEMs don't care, we're stuck with it.

Below is the MR prototyping UEFI booting postmarketOS with systemd-boot
and U-Boot. This will let us do kernel rollbacks, multi-boot with other
distros, and all the fun things that UEFI gets us. Only because of the
bringup work done here, and (until someone finds an exploit) this is
possible only using the boot mechanism explained by Sumit above.

https://gitlab.com/postmarketOS/pmaports/-/merge_requests/4599

> 
> What you have written above is not a good way for U-Boot to be
> packaged or invoked.

I agree, of course it would be great to have U-Boot be a first-class
citizen on Qualcomm devices, but supporting this (admittedly very wonky)
bootflow doesn't exclude that possibility. I very much hope we'll see
some better options for devices going forwards.
> 
-- 
// Caleb (they/them)

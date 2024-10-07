Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0B7CFB43F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 13:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B171188B3F;
	Mon,  7 Oct 2024 15:31:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bOsRW4CI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2A2288CBF; Mon,  7 Oct 2024 15:31:15 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9731288AE4
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 15:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2facf48157dso43599041fa.2
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 06:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728307873; x=1728912673; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OitCTedIlIlJ19e0OU5Mk1mSU43pDxWZ/EQgxXkbLSk=;
 b=bOsRW4CIbQS8jd0jxyNYSxb+fU6fpiwQYRz08vwJvmXiUtaLxdhFhl3qcWWde+X3s+
 G0MMO8XXvf0BUPZEbGaJy/ri4qgjIjRniPzCuYdA8umWqtqRMK3xfhj4LpUxXUDT3zsc
 fvi/5xXFqAwGJPWQPEHrOetuSraID7toFTyyIYmerqulHVsDpoTOA9iMTzDI9tIa6dUk
 cOilnBNLpArlF7m+cCWm8VAG6EiXH6QizQC7BR/re3ob7kPEXDkzc0ULwuNJ8hYf2xrc
 UttE15m9x4bv8g4yfcjs5Xfu8N76wBtsumv46cC1pbcnSAUFGyIozrhwdlsgCCyCnOGq
 Tk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728307873; x=1728912673;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OitCTedIlIlJ19e0OU5Mk1mSU43pDxWZ/EQgxXkbLSk=;
 b=oRO3asJabCSMieJrtKJkyyscQWXtg7wXKqthfy1Nb/Fqe5f7NeKsfY+9Jtr6aTsQkW
 i7OjOZa4w6SktfprRR2mTIeSZwywProobnh7i5B3+l0yLuMtPuuKluCaXdaLjIC6ICC9
 ZAn+31uDRTJGUigsfc4/eso4kV8H3h4d7h50iypTp6Za1mAjlNfNcAIH+UqTkWC2y+yD
 dRutxU3WxQlEkQnzi+h0DNFJvOZM+Oxb0vl4iLD+Ebe4k9rh0mtXhJKWfz9S6FfZYoEU
 5ky7T2xXP+ein6xiUZSjdXCBdrNK6PlLt1qQlJE0f78ZFjTqJWbxjRA5JTzwCDLbn8QI
 YcbA==
X-Gm-Message-State: AOJu0YwT1dQlYu7ZE3ZKQsp78G/WUAAhGB0JP8mlYgKOn/XIw7kD8Dt/
 euumrwGPjHcIOY6CcEEstZQ8eRtMWUpA2sdPTv9JOc8EsNGDMkUEZlKuqXqi16cs6MAI+oSRDyB
 bop/dIA==
X-Google-Smtp-Source: AGHT+IE1jgMyorX12mxXrEyI9l+pqZ55KdHjr5C6jpaVDqnDUOE0B/hof0YDwmay3q3Tt+VZu0yXjQ==
X-Received: by 2002:a05:651c:b0d:b0:2f6:1d35:1491 with SMTP id
 38308e7fff4ca-2faf3c136dbmr60929831fa.15.1728307872434; 
 Mon, 07 Oct 2024 06:31:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6f4b:a50f:5140:7b75?
 ([2a01:e0a:3cb:7bb0:6f4b:a50f:5140:7b75])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c8e0594921sm3251629a12.8.2024.10.07.06.31.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 06:31:12 -0700 (PDT)
Message-ID: <e6fed00d-55b4-4055-a175-45c3d7edcd9c@linaro.org>
Date: Mon, 7 Oct 2024 15:31:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/29] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <20241004183043.GI4737@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241004183043.GI4737@bill-the-cat>
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



On 10/4/24 20:30, Tom Rini wrote:
> On Thu, Oct 03, 2024 at 05:22:46PM +0200, Jerome Forissier wrote:
> 
>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
>> stack [2] [3] as an alternative to the current implementation in net/,
>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
>> reasons for doing so are:
>> - Make the support of HTTPS in the wget command easier. Javier T. and
>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
>> so. With that it becomes possible to fetch and launch a distro installer
>> such as Debian etc. using a secure, authenticated connection directly
>> from the U-Boot shell. Several use cases:
>>   * Authentication: prevent MITM attack (third party replacing the
>> binary with a different one)
>>   * Confidentiality: prevent third parties from grabbing a copy of the
>> image as it is being downloaded
>>   * Allow connection to servers that do not support plain HTTP anymore
>> (this is becoming more and more common on the Internet these days)
>> - Possibly benefit from additional features implemented in lwIP
>> - Less code to maintain in U-Boot
>>
>> Prior to applying this series, the lwIP stack needs to be added as a
>> Git subtree with the following command:
>>
>>  $ git subtree add --squash --prefix lib/lwip/lwip \
>>    https://github.com/lwip-tcpip/lwip.git  STABLE-2_2_0_RELEASE 
> 
> So, assuming the outstanding questions raised on v11 are easy enough to
> resolve, I think v12 should be posted with being merged in mind (and so
> no TESTING patches, etc, since I'll "b4 shazam -SM" it. Thanks for
> working on this so hard!

Sure. Thanks for reviewing and testing!

-- 
Jerome

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1283FC3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 08:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 546D888498;
	Fri, 26 Jul 2024 10:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O4SzxoXM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5786688365; Fri, 26 Jul 2024 10:38:14 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B655884CC
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 10:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5a1f9bc80e3so1264758a12.2
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721983092; x=1722587892; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RXDepogP0K00yrZpowXJUbQISGtm4VSn30xZVPGh8tk=;
 b=O4SzxoXMXjl5BaFoGoL4AYag1KDzBPs0utG/r9nWJL6FJXuzCoL0xzbVQxsjjVr+FY
 brPFbqOtvrPtciGbrC8e+bLJQEoXCUHnjcbZvm+heU2uPjRGgxawi+jIRgmzR9KdACfU
 aaaSfBBStO7yVUpYxK4e2kC+NPPKAdMJLQaLTEv4+7+yFcpqrNHUwlK/mmytRHv3PT9n
 aejc/PM612bX/g33ly9k54MOvhM4LxwUZOCykUoHxeu+GFn9ebLifQfkF1p8wYlpfvlj
 P4ZxUgQxt+BKymPUEhLmwEfdQlSbLjdKAyP5l0+SNadHYA9EknLWgw/XJypsRkhul9vB
 g59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721983092; x=1722587892;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RXDepogP0K00yrZpowXJUbQISGtm4VSn30xZVPGh8tk=;
 b=fBlM2Up9qQ3VTB8PLg8HtzX0satirtqiY/P8kB9Ol6Ym2GRSkSZYXXdrNKt84YXW5z
 hAx4W7++HeIZBUtTfKUozEfBa+a8m/8KFtgDenhwRW2VjICeyr1Cvle9EdFehjsfj4Tv
 dWA0ACqwiawUO+JckOignmj+0mMoY5Vmi/5DH+8drrE0cGGsPTPCrMVq8WatVtmJqB2X
 eVk+QP1wAMQlQWWG9mAu1y4YLb9Uobd9mYiKRUUV6WtO/nmn1zl0kAFbhqLHZbquXuNX
 NjV9SF+yU00qF+RYJACyqCdpL86cHfw/CilIQlQceBJzApYaceof3lMRFoadlvixypD0
 6S8A==
X-Gm-Message-State: AOJu0YzkZ5yycMEwlpQeWeUnETDKM1aZQPqFm8njoumQoNUo+kb7tgnC
 0QZJqqV0P7XAdMOcd6woncMMgrrimRlXIo/WQPvcoUPMAP3YFSUOTX+Z0g4HFMA=
X-Google-Smtp-Source: AGHT+IHLsI2Hsmem+yAVrKKQSW9L3dbP4D9gqvXIEILyMHe329qjOYTkMpXfIEcI9rGWT6CtKjFW3g==
X-Received: by 2002:a05:6402:40d3:b0:5af:758a:693b with SMTP id
 4fb4d7f45d1cf-5af758a6c48mr669374a12.4.1721983091433; 
 Fri, 26 Jul 2024 01:38:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:ef99:2dfc:dad:83fa?
 ([2a01:e0a:3cb:7bb0:ef99:2dfc:dad:83fa])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5af65c0fedcsm220619a12.55.2024.07.26.01.38.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 01:38:11 -0700 (PDT)
Message-ID: <aa88e746-922f-4aba-8cf6-a8d0b5f0568a@linaro.org>
Date: Fri, 26 Jul 2024 10:38:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/20] net: eth-uclass: add function eth_start_udev()
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Fabio Estevam <festevam@denx.de>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <c012639090f4a45f004768b8e7840e3e81867ca1.1721910373.git.jerome.forissier@linaro.org>
 <20240725182732.GC989285@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240725182732.GC989285@bill-the-cat>
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



On 7/25/24 20:27, Tom Rini wrote:
> On Thu, Jul 25, 2024 at 02:57:27PM +0200, Jerome Forissier wrote:
> 
>> Add a function to start a given etwork device, and update eth_init()
> 
> Typo, "network".

Fixed in v6.
 
>> to use it.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> 
> And this is where most of the tiny and acceptable growth comes from in
> the legacy network case.
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> 
> But, does the lwIP side end up calling this too then, and so the need to
> split this out and not have it be static?

Yes, eth_start_udev() is called by new_netif() in net/lwip/net-lwip.c.

Thanks,
-- 
Jerome

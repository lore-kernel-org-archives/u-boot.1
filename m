Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B0606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sKAqz/rW;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SrfDRrLR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D0EA40AAC;
	Wed, 11 Nov 2026 13:14:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F3OwAJ73agFz; Wed, 11 Nov 2026 13:14:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8DA1D40B13
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794402877;
	b=dbbPRxyolubmKxvFATxOcNsdpz/WwxxmarLSlvDBSzotKqHU6OLkZkZuhypmc4ZUB3iN
	 uUbxvN1MN6LOT+vDg35VhinlXSgXT+B+23zBQl2rF4uvqf/xt894SCQi/UxKz6fWvN5TD
	 SX/6wRvv7i5pwjcxzma4St51oPPVhjl1IrpIFquMKTqcbwf2OzbVWY7IaOxP57sUoGT3b
	 38NWM9oxrlRV2zbUERnaFEDoeI6DKfOIzxsuSY9tuAgOIsKvr4TtgrbUFT2H36gGW7n5s
	 gtUjrvkN86w+zUu/UP3MIiPdkAKQT0bjT+M8YJx7LNN7UUY/VeFMEfO6N37PwQlyyxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794402877;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9B2Z9ZTsmqZaUMeqgTQwsZ5kcNEx9/NdqHW4ndkjLWU=;
	b=oDvW+rO7kJlz3tV9+uuIXy7pce8x+IttMu39M19XzJq/Dj1oljqhZ0TAajI4k90CEoa6
	 gBNvqulojRe1FtHceK8OgO68GBHzFVQIBF1vJc0QUO08ZRTA/AWqINo+qzedL/ndqiEvv
	 qTQMsLgz/sbXPDXh0lwpnA8EuFf1DjIH7m9ua774uxhrV7vPMduIJ3kx2G9UHMGERCqLE
	 loggiTU9c5M/w2T1ZZOVwmLIFiyIbOTKyaaDH6bgEmZEdTQ2HYiPR9tJoSyg6e7MA5K+q
	 syAE2vcjKtySmUEsVAH78jynSwCxawMygHrdbog3b0UjSDxrSOysJVgCDSrEtSHEf0A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794402877;
	bh=9B2Z9ZTsmqZaUMeqgTQwsZ5kcNEx9/NdqHW4ndkjLWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sKAqz/rWeq8N7G61rWxun/J47N4cuBZ8vwnDRZaa+d6D/J4rMZ7FefmY1HSQ+ERuV
	 uXRw4L1oe2UjAFzLIjGR6PlW7035a07TwlMaH/3AQUyJt8x/JXMOYDRqXrdbktJN2r
	 bcEn4h5CznIJaGLNl7BSaYcL/5KyWqde3vnmGNKs1at1JQWar7zFQM4+ENIDbK57GS
	 RCK9WAQsZA88O7GvHqBT515rsi/HwpGudTyhq/3r7Nsnhe4EgjDT+ClgC3q+rZlvSc
	 Ci5YwODsw82Xpq1Z7Ilfz9iIlyO1d63yMyIQYJJPDbmvmKIjEOE21rfJz7rmjzK7Gm
	 w0CmQEZPJdqig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DA1D40B13;
	Wed, 11 Nov 2026 13:14:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 55262E09
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:08:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 46C5680E10
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:08:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3s8jMgsdcJGS for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 13:08:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 32FCD80CB9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=SrfDRrLR
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 32FCD80CB9
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:08:34 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c408e21e8acso3810466b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 05:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794402512; x=1795007312;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9B2Z9ZTsmqZaUMeqgTQwsZ5kcNEx9/NdqHW4ndkjLWU=;
 b=SrfDRrLRasIKGM47+fQ8NwLJ0p2uCUXnCDI6Aoye7lQ9WdowVCJ74kkql0NGXreMQD
 QIKIZDoNZrpmWqsBU9ZAPJXze7QjgNzFQHB0h0MNprNdkqOu3KbkizDGe55YNmI9bY7S
 J0RwLrAjSA7C9eDkhMtwepPhV0vZ17jj3OrgnHRtYMj33MqLkWRsIyfFJsxy17aElbXW
 aiIMzuAkEAWNmNHa7zrvTuhKb7xx34y/42PBdVMLXs7pULb6ZGdAHlDnfWuLgtcV4jeV
 yElgiyJk1glwPT7AwStFZZDESQazcB0OeP88egbBslCra4Rofhei1uP/nTrYmKdffx6r
 6+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794402512; x=1795007312;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9B2Z9ZTsmqZaUMeqgTQwsZ5kcNEx9/NdqHW4ndkjLWU=;
 b=EqsQ16lQ1sa84iZroV1mNdHo6BP3U9g7DWqGOTNSenDnEIssJQFYgdSQFzR0rQF3Y4
 1sxQ0qEuR9Tkwwi+9znXUUldjnHB71d8jG+TuRxhjuWW4gPEdd6ddNVMrIx8Ywm6ZnqP
 kBrCtyD2snE2vIVUdZiLL7/mfEtUgj/C6b4CQLZVzJF5c1CY1WPCWyMTUfAvD0TGqYp1
 HDg/gjrDogSnbf4mxOFUiD8halDz4RTgZqc7BCKffb5GRy7xskuUmculYwfo3N7YF03h
 TPu9os+W/tjmPy9yHuNdWE7Hflk7kdQzKM9shTe+5anj1hjtGUzNakkNa6PxWg5LmyXh
 A6Bw==
X-Gm-Message-State: APuU4Z85xTCSZy9bB7eRtHYWtrThMYYfKd+fHl9NdemtxECQV9NfZUu5
 h7vbsFHIAgI0pypIxTd+z12DxAOP/q82viRG9AafCgOARYHOy9ptGbeYqhlliqxebqnKoF1KADI
 Lwiea
X-Gm-Gg: AYBFou2tt22yA1qSHK0HimuSE00WvQDAjJJZmKQezkFLbX6wOtOIQ8ycYhBk+KE+9s5
 E4FxmYuH12Bq+2SLOMDoW0xAAXT1ziHKAGf++Fhi5RYv15MgsnH61ZoVWMqNMbws13Hc5v2FvZm
 yTn7+rW0ZNH6Utay2AmaA0St82lLvBRfqCpChRh7h3lHeHl/DfTiubKNb5MY/WYkP5s35EZrsFA
 lSGV5SYtQ14QYL6+kjzosRxdM55IMeEoXHGBsw3KgzVWfuXyvelPvNdJjBc5MmyXN889wFODx0m
 ICJHdmY9K0wzE9Wq7tBbkmMv4ujz9LyaNL9DvGKBGhRx6HqAOD3ykcG1wyP5fBHfnVqFTQi+ORK
 rRTdzSe3Y4K1sr6NtRCNngBcjUA8M3lCc1FaQbhV4nE77anUVuUtF696nV4hlR5CKSN8YFkmeov
 54OMj+0HajeYXv3sIhf39T9pAdvEXl/rpceFXAia6bOC27pQleesMCJ7Q+sWUEmLbppLZDuOX1D
 IGiozptm7751H7y6eCNDbCQcYBjMwPLY5jCm8CCVR2EImp57qwDEzqPPjHt15m/SPlCReAqIP7y
 7+Ui+xyiRzeNGzdaBxL7gh6+iW3SZaH5KK1faHgmdxG/kKr1IJ8ypxBEOYPElw==
X-Received: by 2002:a17:906:ad87:b0:c41:8e21:4d62 with SMTP id
 a640c23a62f3a-c50668577cdmr200071466b.1.1794402512016; 
 Wed, 11 Nov 2026 05:08:32 -0800 (PST)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c505d78581dsm146208966b.80.2026.11.11.05.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 05:08:29 -0800 (PST)
Date: Wed, 11 Nov 2026 14:08:27 +0100
From: Anders Roxell <anders.roxell@linaro.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, michal.simek@amd.com,
 lukma@nabladev.com, alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com
Subject: Re: [PATCH v11 00/30] usb: dwc3: part 2, make the resynced code work
Message-ID: <avRoy3ghzzRPHWnu@monster>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
 <205058d0-f257-49ce-be85-19c44bc6c5a7@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <205058d0-f257-49ce-be85-19c44bc6c5a7@mailbox.org>
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:14:06 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-10 16:18, Marek Vasut wrote:
> On 11/7/26 8:21 AM, Anders Roxell wrote:
> 

[ ... ]

> > 
> > The rest is build tested only.
> I would like to move this series forward, so let me get input on the status.
> Below are the vendors which use DWC3 core that I could find in tree, can I
> get a go/no-go on this series from each of you ? I hope the CC is complete,
> if not, please add the missing people.


Hi Marek,

I have v12 of part 2 ready, with the review comments you had on a
few patches in v11 of part 2. Part 1 did not change. Do you want me
to send v12? Or do you want to merge v11, and I send follow-up patches
with the fixes once it is merged?

The fixes do not change what the code does, so the v11 tests still
hold.

Cheers,
Anders

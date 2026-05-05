Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613F2CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 13:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A64D684933;
	Tue,  5 May 2026 15:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XZV9Fndi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F32384933; Tue,  5 May 2026 15:20:18 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECC8E84910
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 15:20:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488b150559bso36147675e9.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 06:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777987215; x=1778592015; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CdUkheSEnYnOelVIuLKqzFFN2ftm/yuS7g2+Q1que40=;
 b=XZV9Fndi5lAbbkZOjHYFt+Zqzhs8tNTIe1Uhe6Roa26hXquJ2S5AMNwdmybfdDDDla
 HCUQI2P2L/dZu8KE0n8ei2BdhMjNbbxotmC+yG7mXC+lqsMafReIvZT43asqvXfFTY7V
 xX9VFwja+BDXa9Z1tr2HAoEYr1HlI4Ykj1Zs7jutPyfW/IY7s8whBuVGBunlqA2phlD1
 Xe5oqEr7ijMDdz+2f1UJgcRPDlJTBaTz4wxTMftp+hjuDn4Nc3PoVJZH78p7F8VHSNwQ
 S4xr0q/Q6l+kTf1FSSWJC5lfQw1cNh6Iru/GSc8YXaZSqye3cpTxMZZLRopPOJ4SaDKd
 SRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777987215; x=1778592015;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CdUkheSEnYnOelVIuLKqzFFN2ftm/yuS7g2+Q1que40=;
 b=UCiNnVTiEaDidrQS4WWm0cO2YxcROclfaNplXAoUZrGdacet0tEU6qmBnH4n8gKCY2
 f2OCbquFdx/CLt/m1+1FoNsdfgYeHBwpflo7+Gtvio2JEHLqB72cgckzMcx5SETiUYrw
 MrWMmjRl9l4tTj6VUpK5rJU04sQBZjV1/8/PTls1WtgD/WhebYX3bDkA7K4zFgJNj1X4
 oRDZt3HyQRUYshKiDYy5Atur4uQxxbXcQrBPf+mreOj0lHCmD7Mnuc1WPSCzCRRwE0YM
 Rz+Jw1/iMzuxUhUuxASVlXrJ89T3gDef/GyhRZaVbstuqiaow9rOsgKYdBq2ojlCtao2
 rI+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xErNvem8vJLzdvxPsVtf8qFi+G22DTbZ/bf27F0s+hiS95/pXwyyoz9+GxSO6VqLxCGZU80E=@lists.denx.de
X-Gm-Message-State: AOJu0Yzivaly3dtYB6mDoREAW68I6GbqopQfq2jaBsBI8vfGQcqIsy3a
 V1rAFXGGRCGpMWzrLv0A2OZwRbo9CdfzYWnEfBWJ3vhnKyDNIr3SHbhXgJ06eL2OH7IXPxR3gvx
 Pr588SqI=
X-Gm-Gg: AeBDieuwjsuQpyfUJFKxhAQcQ7awMNkMTNqzRe8xd7bu94F4M7gn7BvE+aroDgw3QPh
 Xto1I5wdWr8j3bwilNMndNQN2t5QqbjXE9eAfu4iJJ4CbHc4J/Ao/ulX6VAmLgtMnN+L7W9pJrA
 A2dZUhP9i15UWPQt7G+vgR9MJ4tbSwmGhK9HozvLFH1xFjlqQ46B+pOTtoI3/EqzYeSWml71ZkR
 YRhKPD4sUF+f2nbQbs6Pj70bIa+Ou2Q7u+f6rBU93qgdAHsphB3/olLxHFdn6BwEtK8RSy00br7
 pWWKYk6T2x3q+rWcTDygzDblcxXQjPKmlSDTCubC+MrqnQzbm9drfxmHNB9ZhW3gAsObwaMhgGi
 BibddHw22badM6s9N/A3qny6QM5wSKNuqxhK4+liYau9jyVo2bbE/S2yBHAiBbsn6dtz90xsxMW
 Nh8vME22PfTQbbwiobWZHzHPGgT3qChFBRroCH4LfJ1dzveEleexjMvgITFjt5xlHhSTkPBsdme
 TZ+
X-Received: by 2002:a05:600c:8906:b0:48a:5574:3a5b with SMTP id
 5b1f17b1804b1-48a9867a7dfmr166386555e9.27.1777987215116; 
 Tue, 05 May 2026 06:20:15 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82307f7csm406640695e9.12.2026.05.05.06.20.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 06:20:14 -0700 (PDT)
Message-ID: <c2612a4e-48a2-465e-a338-68e542bde723@linaro.org>
Date: Tue, 5 May 2026 15:20:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Qualcomm: rpmh and regulator fixes
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
References: <20260413-casey-qcom-geni-rpmh-fixes-v1-0-2a83a67ac0f1@linaro.org>
 <afRBNIa6wsFXU2VS@sumit-xelite>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <afRBNIa6wsFXU2VS@sumit-xelite>
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



On 01/05/2026 07:59, Sumit Garg wrote:
> Hi Casey,
> 
> On Mon, Apr 13, 2026 at 01:06:13PM +0200, Casey Connolly wrote:
>> The RPMh API is frustratingly complicated and lacks public
>> documentation. With the Linux drivers being the only available sources
>> but are highly asynchronous and thus hard to translate to U-Boot.
> 
> There is new source of synchronous RPMh upstream driver which is being
> pushed to upstream OP-TEE project here [1]. I agree U-Boot single
> threaded execution model requires drivers to be simplified coming from
> highly asynchronous Linux context.

ahh, that's a nice reference to have but still a big hard to follow.

I think this might be a case where it makes sense to diverge more from
Linux. The OP-TEE driver also seems to be asynchronous (just not IRQ
driven).

There's definitely a bunch more unsolved bugs with the U-Boot driver,
restricting it to just handle one cmd per request and only ever use a
single TCS at least we know it works in that configuration. Obviously
not really ideal.

> 
> [1] https://github.com/OP-TEE/optee_os/pull/7796
> 
>>
>> The main issue seems to relate to sending multiple commands in a single
>> TCS request, currently this is only done by the interconnect driver and
>> while this may not be the underlying cause it seems to be safer to avoid
>> this for now.
> 
> Can you share which particular peripheral is being tested here to
> reproduce the issues you are facing?

The repro is just booting Linux on sm8650 HDK after U-Boot's ICC driver
has sent votes. Linux will either hang during rpmh regulator probing or
get RPMh IRQ spammed and then crash.

I spent a bit of time in Trace32 but it didn't seem like I was gonna get
anywhere with that with my current knowledge. If you could advise (maybe
off-list?) on how to actually debug RPMh requests that would be amazing!
Perhaps I should revisit hansei.py? But yeah it would help a lot to get
some pointers on that.

> 
>>
>> Adjust the bcm-voter driver to avoid sending multiple commands per
>> write, and additionally adjust how we send RPMh requests as well as
>> improve the cleanup we do prior to booting the OS.
>>
> 
> Aswin,
> 
> Is there something you can help Casey with this multiple RPMh requests
> issue?
> 
>> Lastly, add a missing piece to the rpmh regulator driver to ensure
>> that when a supply gets enabled we also propagate a vote to its parent
>> supply. This seems to have been missed from the original port (perhaps
>> because the Linux regulator core handles this automatically?) but it is
>> necessary for some peripherals on some boards to work (e.g. to ensure
>> that the spms supplier for an LDO gets enabled).
>>
> 
> Again it will be better if you list down the specific peripherals here.
> 
> -Sumit
> 
>> ---
>> Casey Connolly (3):
>>       soc/qcom: rpmh: properly fix synchronous requests
>>       soc/qcom: rpmh: only allow rpmh writes of a single command
>>       power: regulator: qcom-rpmh: propagate votes to parent supplies
>>
>>  drivers/interconnect/qcom/bcm-voter.c         | 16 +++---
>>  drivers/power/regulator/qcom-rpmh-regulator.c | 35 +++++++++++++-
>>  drivers/soc/qcom/rpmh-rsc.c                   | 70 ++++++++++++++++++++-------
>>  drivers/soc/qcom/rpmh.c                       |  6 +++
>>  4 files changed, 102 insertions(+), 25 deletions(-)
>> ---
>> base-commit: c704af3c8b0f37929bce8c2a4bba27d6e89919c7
>>
>> // Casey (she/they)
>>

-- 
// Casey (she/her)


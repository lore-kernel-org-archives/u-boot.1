Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E40606A336
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ck+KEFcw;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P7MGA0Wn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AC9580DD8;
	Wed, 18 Nov 2026 13:45:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nzeqAz3BR28f; Wed, 18 Nov 2026 13:45:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 22AD680D1F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795009549;
	b=rjoeWhP7dG1HC27ecIwR6sHG0GsNkXriq4jCiFeY9OaxBaVZEBnUBspnX5BYug8rcew/
	 NHLJ8f4SF8nUGP//YDh/+qov4IvaHhReKBCV21K/nN/ONra94QOUVxAIeyQYcNfRy/+Wj
	 ZkfMF6XQ5AD57IqiaEg4wstXamZZk3HSewzi7XHb2Jcdi8skTHNGfYN+3rRz2YGjqmgFi
	 x/O30vSsgOozStJDWJodR7PVCTk/P9v6y9bcE3oqt0p+GeuyYK4BUVRv2AHdH6ADeW1Iq
	 s1Gkj9RasdjwNDjD3oT1xXT1KG3MqCMHmUplLkuXppJdLT5e80IcmeBTYYz/05NOAwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795009549;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GQn0sPMFAuXgHuvpfbqp62rP8q8HylLNpeSCC+b+hDI=;
	b=VEiG0Hlaw24/3YWF6TSQ4fXA4zy26yn5BTTLoDbw9XTnCfyoPqHaF7Ieh71M8ySGcX7h
	 +Kj/nwvD8rklhAduK1eJgYEo95a/Is8zBf5CqIeRmjoUhBXXB8R24AHpZHpThmjkWeetU
	 2Ytr574P+0cgYMiEypgTACh4FUP5gvSCsm808EgprhxzL4zA4dmkuqy2Cp/AyyKSDDjXv
	 clooU7sc+taFRITkghuvyfTvE/XwBTLGRZ2of29oPvalMJp0ZVtuUWWKs86E94Qod+gOH
	 BJ7uj98xg1yCzRlwDEftel8Mi0Aio+Y7+1i4Aay9UU+S7/VTN4XK0xf58kMBzhH2PtQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795009549;
	bh=GQn0sPMFAuXgHuvpfbqp62rP8q8HylLNpeSCC+b+hDI=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ck+KEFcwkU/trMrJJ/D7/kT41DxTm056lLTStkHH2qZV9BL+dUIbCZPjjYLMrozJT
	 QiNETndnq+AdBGuHI6SX2XngYFE6Jfj9Vo1EJesFxG6f0Kw7gHCjQBTf5HQ5zYXlB+
	 HYKvZAamsLpT3TXWUJsgY7V0ygcFs/cFF+rNdUO8dXm6j5XZDO7gnFQB4HAKy7hVw3
	 NHLTmQn0MA7IblN+uNEcP/cWT/KqpZwK1uLnfx6b4p6IK0FVurDK/mWJSYU3QR79Xd
	 R6WVhzIhbJ2CiY6Qzxy7fpP10kCV7nyvfb3cVRJ9DcbcvkkER2vwe0akv5X72sezsl
	 EvPYRRAe8qdng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22AD680D1F;
	Wed, 18 Nov 2026 13:45:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 82539977
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:45:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 747AF401E9
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:45:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y8Uw7vL1-f-1 for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:45:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 578BE40060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=alpernebiyasak@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=P7MGA0Wn
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 578BE40060
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:45:46 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4bb6057b333so4913175e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795009544; x=1795614344;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GQn0sPMFAuXgHuvpfbqp62rP8q8HylLNpeSCC+b+hDI=;
 b=P7MGA0WnO9qB0KGrYHWYQqObd2aiVdHeqNE3b9LCWQmCwtg3CWaE1WV9ii6u9sYlrF
 0cl1dC/wGN/j0ERbY5Kx7kH7EXqPmcmpHbiatOfZ9nF7njO3aFGvDVdcFnyofJv8dRpa
 AzxhZAITIv1rpf2RzYYaH7qoaGQ+1ngM+HYjmsS91vJK26iDld2UrxeMjuRLFIrvOGYX
 WrUQYhlu6vE1L2+cUiWloaq4I4EJcUwbHDCLIa90kLcfd4YLRPL+YiRIfrkiRHgw+sc9
 f8YZEXeCIldYp4yFzwMIZ3zARgXQh5oIIK3DbkWAq913LkTnRWC/I0K17+DoHbVt6FkV
 s6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795009544; x=1795614344;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GQn0sPMFAuXgHuvpfbqp62rP8q8HylLNpeSCC+b+hDI=;
 b=AHsXMlUrfhT4tQS+EXgy4ZgawGmsnT1tgfZy/BY/bD6+OgURdf3EQMDhLDbv03e6Uz
 OtviBWGe9uTFKZgG0M55fiaxbBadlq00+OHQxiKg7BB8neKejeB+200r/d0L48piqIVg
 7gJBkm/6YZobSCwEf4p/Hrlzga2ttSA1vhSRLQJySFBSazDz/ueaGfNQI/bHiWR6Es1v
 8b5l3Dn38GV5S9K4K/gosGXrU63kDrMPg4PX7IHJrMtLZHL0lyFo4lGwZSDIjbYMqkDH
 3ob4rZsZjC1I3/1jaZI/+2bSpOlWrXP8HCMmcZP2LiaqIWxfXEp79ECuHpcxD/hyfv6l
 +/Tw==
X-Gm-Message-State: APuU4Z8lRNX7tjCANESmhAM83ZZyS9m0p7AbOvuTrE3jL3j0Ba1mZf2L
 Y5hzegHW0LMBNcxvTob6OQH3XK96MWlaxTimfKGbRzfJtaJ2EL+LO60VUKcbS2BL
X-Gm-Gg: AYBFou0SACdvj5gJ6IPPuS5EKzD7sDzSymwV/tGKOF6EQeXLbPLZ8nRXm0iCwOn0hRq
 HUHuM3sONKVj7UMixkFMWklAlq7l8AzcGPWX8CmcCcH0+WzlFGrIcgt0BlDOZRiytBtpbqx601Z
 hQ91yXVjuoWkD9/a9jgJUqGuD6R8/Mh4glxAXCpuvfEwWXWfuEhspu6lmbDT9gdU9CC07cNntyE
 SNoiQezZIYO/KbC4RYQBB5sudH/EVv6d66mrrmpThpVCJhle/lCNVMCb4w5C3BsTx9GRP/ugRV+
 Feggtc3YyyKLzesGQoUBWZGLFEyR5EG1dXZaCw5vK+FGPW4ffQfbe2tfd3NEr0xkNlHrzpG4XIY
 agH5FWAbHkz0EIULTrpYa97OTeSPqNi/ooBms5E4Z466XjZykYdWMD7v+nXP27w5FbSgq1FGQob
 9S1xi7srCykFMqU01LCL/diAvoRG0xm+K9TAVKWzH1kTCetTiLsaw6Q11/B6kCZhCLA73S80hY9
 pqWBBuxQ/VapjMph31bKoFsUF1iHm5s/3k61XlFUZK2SVkhrbf+dFJkLgD0kHalCjd5oKNPwlGP
 bQAvi20EOFxDC5zf4qasq+mbOnikcoDaZsjyD3rv
X-Received: by 2002:a05:600c:a07:b0:4a2:1a:a11d with SMTP id
 5b1f17b1804b1-4bb7d57770fmr53479295e9.0.1795009543956; 
 Wed, 18 Nov 2026 05:45:43 -0800 (PST)
Received: from [192.168.0.13] ([178.233.26.179])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65560ab70sm5328406f8f.30.2026.11.18.05.45.42
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 05:45:42 -0800 (PST)
Message-ID: <ee124480-6356-474c-92ca-6f27de77be7f@gmail.com>
Date: Wed, 18 Nov 2026 16:45:41 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: Remove spring board
To: u-boot@lists.u-boot-project.org
References: <20261113172043.1235725-1-trini@konsulko.com>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Content-Language: en-US, tr, en-GB
In-Reply-To: <20261113172043.1235725-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 2026-11-13 20:20 +03:00, Tom Rini wrote:
> This board no longer has an active maintainer. Furthermore, as it seems
> unlikely there are active users of this platform, remove it now instead
> of waiting.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> If someone would like to pick this up instead, that's fine.
> 
> Cc: Jaehoon Chung <jh80.chung@samsung.com>

Can we postpone removing this for a while? I recently managed to get one
of these (HP Chromebook 11 G1) in non-working condition, though I don't
know how broken it is, it might just need a re-flashing if I'm lucky.

We had support for it in Nura (formerly postmarketOS) with the stock
firmware until a few months ago, the maintainer there is trying to
re-introduce it [1]. A big concern is boot files being too big to fit
into the 8MiB stock firmware limit, I was thinking of overcoming that by
chainloading U-Boot from stock firmware (and then replacing it wholly).

[1] https://gitlab.nura.eco/nura/pmaports/-/merge_requests/9721

> ---
>  arch/arm/dts/Makefile              |   1 -
>  arch/arm/dts/exynos5250-spring.dts | 702 -----------------------------
>  arch/arm/mach-exynos/Kconfig       |   8 -
>  board/samsung/smdk5250/Kconfig     |  13 -
>  board/samsung/smdk5250/MAINTAINERS |   6 -
>  configs/spring_defconfig           | 102 -----
>  include/configs/spring.h           |  13 -
>  7 files changed, 845 deletions(-)
>  delete mode 100644 arch/arm/dts/exynos5250-spring.dts
>  delete mode 100644 configs/spring_defconfig
>  delete mode 100644 include/configs/spring.h

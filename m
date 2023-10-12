Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2E1CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 11:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B9EB86E22;
	Thu, 12 Oct 2023 13:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OPa65Asn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AAEB86DB5; Thu, 12 Oct 2023 13:19:18 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDBA286E2F
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 13:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso1718799a12.0
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 04:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697109540; x=1697714340; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rdU40PxLeoGAJVSJmCjVjE0n5kR98vuf34bTjJ9QAlU=;
 b=OPa65AsnvHk/0OAw1eiIdPFMbC3GcCUMPyMwpFxwY3P63rpakO9Jexk8Aa6OqCDzoF
 8aHxVCfzoBFtRSzw0MpWz7jv0QayNGWZKOMy6oBIs875xjPay2TfvdPqPbYUgz8r52eY
 49uM5l7qP8YyreLtLPLs+2QXCwr7aYLnYcMxyfh6wCTPFB7B/nAPmVLGzfGEk/pgRbfI
 yFB8B2MJVazFOHZ20ALAB6JxVrlbLsodsjnUKZ18YPWOkfYexeax6aJrvuTg3nQ0LN/W
 moF/WA5awomKEwp+cNCHq3mrUPalUSCg4NaSEUDBWjg9tBoBLXC/R0nZ0ShN0o+b5ITq
 evEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697109540; x=1697714340;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rdU40PxLeoGAJVSJmCjVjE0n5kR98vuf34bTjJ9QAlU=;
 b=LVZZ75DZaAzAw36wRxeC6JJtbPk3P/oGK2tMFrXPcB3g6ttiuUU1RdcfWDJsQhL9FK
 V/8VbLsCEW45kbFnHNW/5BSE+rN4zineyTRl6kTY3wMO07U2WM6OiCW3fuHYCsnQlZi8
 +ZnTEX4YaiBCs5wYYmynHPma0Vd5h9kRx1YnGz3Zv6ToRuoDdteaKVttGm2JkNl/mvqg
 ciP2DewKvgZ1OWVkc3+3Fu0QYc0CDShM/wEEsdrxeupqcnBUAcvwS18GvHov47itnpKz
 4EKTWyUtsLFV46u3mYhlLfipiN5jIcnahvK8kqb8meUEbsoVI3q948tn93AjpY44lWZG
 QaFw==
X-Gm-Message-State: AOJu0YxG7f7B471PjklPBXJ4wA7Gc3xlsjQbX6aQJP3WDWc6l4JiApb6
 ZuHZOlIMXv3eL8BlVPqWm+o=
X-Google-Smtp-Source: AGHT+IE/8jsBWI0+4MfYnl0KiOo8tjbyTgW9A/0Vu1j1v39Dt6FAP6nz4qYgSD9gszbA6y8njuv84w==
X-Received: by 2002:a05:6402:5207:b0:53e:264d:be1f with SMTP id
 s7-20020a056402520700b0053e264dbe1fmr437316edd.2.1697109539874; 
 Thu, 12 Oct 2023 04:18:59 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a05640207c100b005311e934765sm9979748edy.27.2023.10.12.04.18.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 04:18:59 -0700 (PDT)
Message-ID: <e5ea6ffc-afe2-1002-5806-113d05c0cb24@gmail.com>
Date: Thu, 12 Oct 2023 13:18:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] dm: prepare rkmtd UCLASS
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, u-boot@lists.denx.de,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 dario.binacchi@amarulasolutions.com
References: <9dd66b67-e372-fcb9-ed38-7ad24d83edbb@gmail.com>
 <c2acc0c6-0a8b-f4e1-7877-73fa5eef404b@gmail.com>
 <CAPnjgZ2EMus-Q9DY+-7dn-P5+VSLELd8nnp4NOxR0XxHzZfamw@mail.gmail.com>
Content-Language: en-US
From: Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <CAPnjgZ2EMus-Q9DY+-7dn-P5+VSLELd8nnp4NOxR0XxHzZfamw@mail.gmail.com>
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



On 10/2/23 03:16, Simon Glass wrote:
> Hi Johan,
> 
> On Thu, 28 Sept 2023 at 12:51, Johan Jonker <jbx6244@gmail.com> wrote:
>>
>> Prepare a rkmtd UCLASS in use for writing Rockchip boot blocks
>> in combination with existing userspace tools and rockusb command.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
>> ---
>>  disk/part.c                | 4 ++++
>>  drivers/block/blk-uclass.c | 1 +
>>  include/dm/uclass-id.h     | 1 +
>>  3 files changed, 6 insertions(+)
>>
> 
> A new uclass should have a sandbox test and a header file or some
> other docs describing it.

Hi Simon, Mark,

Found by git bisect. This serie worked fine till this patch was applied:

blk: Add bounce buffer support to read/write operations
https://source.denx.de/u-boot/u-boot/-/commit/75191f75bce45f3b9aff607c88f17778d3805c61

On Rockchip boards CONFIG_BOUNCE_BUFFER is selected by CONFIG_MMC_DW.
These DW controllers have there own DMA interface.
However Rockchip boards CONFIG_DM_DMA is not enabled.
A virtual disk driver doesn't work with that extra buffer.

This patch is there. What route should we take to get rid of it.

Please advise,

Johan



> 
> REgards,
> Simon

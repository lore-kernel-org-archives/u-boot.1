Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33DEC5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 03:20:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77A108752B;
	Fri,  8 Mar 2024 04:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Ymqab64B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0043C87DCC; Fri,  8 Mar 2024 04:20:35 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8248D841BC
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 04:20:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ED6B63F6B1
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 03:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709868031;
 bh=3ay33hWbqhkAoI4T4yyfj6pkj3guqMaWSyeSSyxhXTo=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Ymqab64Bm+iohb9Aj9L1UIzdG+jbcGpdH9A+Ycy89W8JcJ0Eq8blgXkjW0ZkasHxC
 u+r+uBo+VKt29GffC5Oqh3Jdvu/xJKvz1mJWIZrS2NNpz7cCmqH1UhONZuoIFl4389
 yQ1rdDuks0enBIEHkCi3fYaq3dT4FAyZlGvQXfYFSL1CYNLxtJp+67ewIQAAAv0kl0
 oM+kwEIlEv2F7FgyhsrCDlE3jpOWgO0ndLCGUw1gVNyKiFCWhjwUvx1kYPJJyy10lu
 rU4V/GVHW1Gjl5aq+JgxKZOjdcV4/uQwAQsXxtrnPAqVTBpbPOsFdv8G0dPHq+3rVI
 PZ9TztIpXhBNQ==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33e43979853so848623f8f.1
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 19:20:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709868031; x=1710472831;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3ay33hWbqhkAoI4T4yyfj6pkj3guqMaWSyeSSyxhXTo=;
 b=dKBblXCZYhQW+ureCor4kP0WDmIM6H8j1un+EQ+b3NyoXR9bMI8Iel3JAPdOJyRO9a
 Tyz39lEmIVU3nL9/1NGNA56cDGD5CrezVnH8pNJmyTMB/GWhHCtjufxlgHClLONcg/Zf
 aZ5WKH8kZ8DP7EKRDNvXfBga2MmzVDIjdd6vSFcxN0fkbkMOGMi62lvJtRiTwnw+bFDa
 fxDGMRBaxzXRM+CELJj3IePMX5Lf8OcEEUsuoiQ99rT2upznsyjbudHDHSpxEk0tGJZ5
 6CYPCN2ttyxHOJpvjCnhv+KIkuLr0zUHfwf73p6fIDfR6L9Bm25ZstpCMzzPtFpsv2JN
 Y1dQ==
X-Gm-Message-State: AOJu0Ywk8hA8JCHrAI7zOkO96xdwZXKj87Cpvok202HAHk/5y6iQnpig
 /zIz1cyjw3xxLzqZbNgX/G7u0VihI42eZFSaEUwlHtyLQwdCXkquBkic6kwfxW8ZzQuj2VOgynM
 PqtG92/dbIOYhxQ0Oggir4XZK+e/TwoOyVJa/8YmVzHgXL1Tq7XrOxRoKqa7uLatU2cE=
X-Received: by 2002:a5d:554d:0:b0:33e:6760:6def with SMTP id
 g13-20020a5d554d000000b0033e67606defmr2315512wrw.56.1709868030009; 
 Thu, 07 Mar 2024 19:20:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGM2EKJr/wXN7uGT1HN4xBjbH24oEcGvxBcHWaV3rX64AzYc/Wvjf4OTQqzNTA5fg9Cipt5xA==
X-Received: by 2002:a5d:554d:0:b0:33e:6760:6def with SMTP id
 g13-20020a5d554d000000b0033e67606defmr2315471wrw.56.1709868027778; 
 Thu, 07 Mar 2024 19:20:27 -0800 (PST)
Received: from ?IPV6:2a00:20:9:393f:4294:78eb:608e:9569?
 ([2a00:20:9:393f:4294:78eb:608e:9569])
 by smtp.gmail.com with ESMTPSA id
 cr14-20020a05600004ee00b0033dd06e628asm21672581wrb.27.2024.03.07.19.20.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 19:20:27 -0800 (PST)
Message-ID: <f76541f4-503f-432f-9cfe-a74b78523c3b@canonical.com>
Date: Fri, 8 Mar 2024 04:20:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/5] board: starfive: support Milk-V Mars board
Content-Language: en-US
To: E Shattow <lucent@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
 <20240303130122.29983-4-heinrich.schuchardt@canonical.com>
 <CANV2PTMcS800x8OTuDbv8orqUD=-frNpa+0dHu4=L__D_Rmk_g@mail.gmail.com>
 <CANV2PTMtPggmS0hxxuovDfUnSAGM7tDXSewQ-eRTmd_+xR_L-g@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CANV2PTMtPggmS0hxxuovDfUnSAGM7tDXSewQ-eRTmd_+xR_L-g@mail.gmail.com>
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

On 3/8/24 03:06, E Shattow wrote:
> P.S. Found the longer description at 
> https://github.com/milkv-mars/mars-buildroot-sdk/commit/d381610c92827de01b25843786012351b3f35519 <https://github.com/milkv-mars/mars-buildroot-sdk/commit/d381610c92827de01b25843786012351b3f35519> as follows: "if configured as 24c04, its address will occupy 0x51, conflicting with the RTC chip pcf85063 on the IO-Board. Refer to: Documentation/misc-devices/eeprom.rst". What does that even mean, it is for Raspberry Pi Compute IO carrier only?

According to
https://ww1.microchip.com/downloads/en/devicedoc/doc0180.pdf
the chips differ in how their address lines are used. Either they select 
a chip or a memory address.

The chip is at reg 0x50. So it could be that if you read the upper 
memory of atmel,24c04 it would use reg 0x51.

https://datasheets.raspberrypi.com/cm4io/cm4io-datasheet.pdf says the 
CM4IO board has an RTC at address 0x51.

Together with the commit message this really sounds like the smaller 
chip size is faked due to incompatibility.

As you mentioned to have access to a CM module I would like to know what 
its serial number looks like to understand what if it can be used to 
detect if we are running U-Boot on full board or a CM module.

For my Milk-V board I have:

MARS-V11-2340-D008E000-xxxxxxxx

Best regards

Heinrich








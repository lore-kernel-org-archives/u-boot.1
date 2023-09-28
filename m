Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F7ACE7AFD
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 06:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38A4C86A26;
	Thu, 28 Sep 2023 08:26:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YakAN6Pk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D75E286CC1; Thu, 28 Sep 2023 08:26:54 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACC54864C3
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 08:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B6B6B3F214
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 06:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1695882410;
 bh=dFT4c7M8IZja6gV7Ywibr31+H2PeBJUlhC0R2+R5lQ0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=YakAN6PkvTy2fNYDWi7A7Y3e/MPF7jD1lhs4HBlYt3bHfzgUkOdFmMeDozEUwk2ea
 Syc9emXDz5kcRqU38+7IiT5VB7THgOIbgEhzTSquUGcgPF7n6ZrlBYcsTjDPCqCVaP
 EqoA203DipMzrdFKPLweERK2ZtDyfTFXkxX5/FTD9yc2KH1Q1GsUSpUAlbyS8BrTb5
 aIoxaohq+ciI72yVQdMNkkY+t85MZbYLv6hpXD5eryOknTTo8vWKe8mZkVzT5xM+3A
 gOXdAWRxkwQdz1J958MXXVBzmk0ssTtYN4UZ/JIFG5I/IhXMyWtSbes68J9HBgWfzF
 1s9or9WesmKkw==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31f3cfe7269so9723779f8f.2
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 23:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695882410; x=1696487210;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dFT4c7M8IZja6gV7Ywibr31+H2PeBJUlhC0R2+R5lQ0=;
 b=EcGoYbrs7QvKQo5+DqD3L+sCgoGSOlslEfeycoik8Q994BONO+xRtQEjtMfXRvTAU6
 xIYyphOjALmo5mp5uzrfUyr5x9zjs3p/VHtn3s06Q0l7oew7hdqz6d8VBEoQ/iS0UIdy
 UBM2QgylYMVlVrjs6nzUn1cr3NFwoaIkCX0X+1lXi08Al6K+VyJ2+k7BfEZJm6s1tCsu
 lhxg13vK/hCdT8ayooDmVii/H5ql9mjPIqIZbRQgEaxR/hPcDSXHZ/qGq8gMw/5FXh/J
 UpUMQUWloEeutjcvYsLwrJ+ExZHtNAOhc8nzuQl1PzrBn2T3Aro6Fyg/bbMU70IGKqh9
 3b1A==
X-Gm-Message-State: AOJu0YzW2loCY+LgT/dsU9qro4db5pn0wUqkDdW195dYuA8NE5UhCQzp
 SHe4RYJ458WtWIH9kGWQaJNd0tW05sLay1OvJhdThJlg+UgHQstfLHh2DdhABcE+yZJyZj242+e
 YdLzZwf2i9u4TsEb09lGD83sy+vJOC4Q=
X-Received: by 2002:a5d:674d:0:b0:317:636b:fcb1 with SMTP id
 l13-20020a5d674d000000b00317636bfcb1mr273472wrw.27.1695882410310; 
 Wed, 27 Sep 2023 23:26:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFeZrWelDaSp7qGB9TEjDkQ5AlZpVdXNRQzCvgLr4xxQ1d2X80vZizQmD6nZcvcua/oT3Ffw==
X-Received: by 2002:a5d:674d:0:b0:317:636b:fcb1 with SMTP id
 l13-20020a5d674d000000b00317636bfcb1mr273456wrw.27.1695882409845; 
 Wed, 27 Sep 2023 23:26:49 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 f7-20020adff8c7000000b00317afc7949csm18923234wrq.50.2023.09.27.23.26.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 23:26:49 -0700 (PDT)
Message-ID: <14f689af-b727-4f5b-b2cf-73676f14167c@canonical.com>
Date: Thu, 28 Sep 2023 08:26:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SSE instructions
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
References: <CAPnjgZ0vKO0YYpQyr_C35bY41un59AdZcY45OT3+ydxkCr7BOA@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ0vKO0YYpQyr_C35bY41un59AdZcY45OT3+ydxkCr7BOA@mail.gmail.com>
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

On 9/28/23 04:41, Simon Glass wrote:
> Hi Bin,
> 
> U-Boot 64-bit on x86 disables sse, but when enabling Truetype I get a
> compiler error:
> 
> drivers/video/console_truetype.c: In function 'frac':
> drivers/video/console_truetype.c:30:15: error: SSE register return
> with SSE disabled
> 30 | static double frac(double val)
> 
> Do you know how to enable SSE for 64-bit?

How could this occur if x86 disables SSE? There must be some 
inconsistency in how this module is built.

We a need a clarification of the used ABI per architecture and write 
this into our documentation.

The RISC-V profile specification does not foresee float and double in 
S-mode (see RVA20S64 and RVAS22S64 profiles in 
https://github.com/riscv/riscv-profiles/blob/main/profiles.adoc#52-rva20s64-profile).

We should convert drivers/video/console_truetype.c to use integers 
(where low bits are used for the fractional part) instead of float and 
double to make the driver compatible to non-x86 platforms.

Best regards

Heinrich

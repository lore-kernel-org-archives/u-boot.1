Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC29D44167
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 15:46:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A1F8894C5;
	Tue, 19 Nov 2024 16:46:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="luoCOQHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEF04894F9; Tue, 19 Nov 2024 16:46:49 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA7CF89417
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 16:46:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso46602975e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 07:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732031207; x=1732636007; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=J5gf+O4OQ4mWJszoR0HItWEZQ9XKcXD+GywprTq1Q2I=;
 b=luoCOQHqRvm6/PmQ9TTvzlN/dG3ya4o7YqxDUzdZOC4+ep9ADFjQcR6RJH2M+wmGHQ
 rYy5bA/uQKI+0+JghYemLPXOd7YOjyCrMDKBbVJG7407acptAWlpdAD6MAFAN/+4gJ81
 W3Chgxh1Qb8lRZlpImipQoqGf7CdFndA28bKZRiNGWFXzS68jdMOqTKkf9lJTKc4qF1g
 TIpPvcNe/jcDcCKC3kP5Yb2Ky+N1uDM2qF6Mim17KfPmTlI94/Si/A3O6r+rPmEZrQ+M
 XcEgfxifnWiR1aflsZXZ2zJ8AQ+nQBOFvmEWTQ8Eh0zXx+aFixTa7EW6nFtokzNmw9qk
 0jQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732031207; x=1732636007;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J5gf+O4OQ4mWJszoR0HItWEZQ9XKcXD+GywprTq1Q2I=;
 b=bwGPBP5CTwxxzWLk2LMG7qKD5YBr1k/s8MH7xshtO1V7kvN0e6UYxwwHvONKQqw8lv
 q+p5IfFsgeTLyJkCvlSgiImVn0WQzX7Pl/4hONr/Cev7Vu1uxLAqnHN0Gpfebc9slk3G
 BmdS0WqAlLx+kS+saZUpKT5nHrS6O1pM0LjpDisfbkjt0m9tPJMH3deYrWiaVIwiuTjF
 8of5BwL7+WUHQ4WSUp8xjq13TM7EcJDvdKC4EJ6CULpeG3LST5Bup0RogMnfnaORwhUS
 QKyp5SerOmkXUw0XOpSR4qlDnKX7h7lrpXUdqzIqbAYcl8aWv5KK1LwvtQYc0hab/7RU
 Deqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsVILsFDTWXhEWHSseCabM4kRPkom3WBZ/aRXAchM2W8DbuKFOsLUIBBPCsiIpUZUDM0bewYM=@lists.denx.de
X-Gm-Message-State: AOJu0YxeVs3rW4bxZE/ZO3YCeQLV2qE71auoSVsmoHJqtKwhhmMBHpma
 c8BZFamXa0uW6ZRlsqM5pcxJiiJSbg2yj0K3W0l7xqyF1Uclj4rTevoMdreyjv4=
X-Google-Smtp-Source: AGHT+IFj0XvBV5Q8O3CLF35DjUzt82I91+UnACLSBWwdvgQYSX7EcVH1wuhyR8+2KTIjeYXFFad2Hg==
X-Received: by 2002:a05:600c:1da5:b0:431:5c7b:e939 with SMTP id
 5b1f17b1804b1-432df74fdedmr170418935e9.18.1732031207323; 
 Tue, 19 Nov 2024 07:46:47 -0800 (PST)
Received: from [192.168.0.71] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da244c69sm204902005e9.2.2024.11.19.07.46.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 07:46:47 -0800 (PST)
Message-ID: <442a29af-c0b5-4ef1-9b38-51d96b0fe6c0@linaro.org>
Date: Tue, 19 Nov 2024 17:46:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] collected fallout of porting an ATSAMA5D2 based board
From: Eugen Hristev <eugen.hristev@linaro.org>
To: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 Benedikt Spranger <b.spranger@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, u-boot@lists.denx.de
References: <20241018083006.10349-1-b.spranger@linutronix.de>
 <20241018083006.10349-2-b.spranger@linutronix.de>
 <0c9225d8-9cd2-407e-aea8-baf31efcac34@linaro.org>
Content-Language: en-US
In-Reply-To: <0c9225d8-9cd2-407e-aea8-baf31efcac34@linaro.org>
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



On 11/12/24 15:45, Eugen Hristev wrote:
> 
> 
> On 10/18/24 11:30, Benedikt Spranger wrote:
>> Hi,
>>
>> while porting an ATSAMA5D2 based board (booting from NAND flash with UBI)
>> I stumbled over generic, NAND- and UBI related asperity:
>>
>> 1. tiny-printf does not handle NULL arguments to '%s' in a proper way
>> 2. vtbl_check() has an useless debug output due to a typo
>> 3. NAND: An informative output fails badly, if the NAND vendor is unknown
>> 4. the nand_atmel driver lacks a vital initialisation
>>
>> OK, you might say the nand_atmel NAND driver is obsolete, but it was the
>> only solution to get booting from NAND running. The new DM based NAND driver
>> refused to do anything usefull, so I dropped it after spending a couple of
>> days debugging it:
>>
>> <RANT>brilliant!</RANT>
>>
>> regards
>>     Benedikt Spranger
>>
>> Benedikt Spranger (5):
>>   tiny-printf: Handle NULL pointer argument to %s
>>   drivers/mtd/ubispl/ubispl.c: Fix error message
>>   mtd: nand: raw: Fix potential NULL pointer dereference
>>   mtd: nand: Update NAND manufacturer Ids
>>   mtd: nand: raw: atmel_nand: Add missing nand_scan_ident()
>>
>>  drivers/mtd/nand/raw/atmel_nand.c |  4 ++++
>>  drivers/mtd/nand/raw/nand_base.c  |  8 ++++----
>>  drivers/mtd/nand/raw/nand_ids.c   | 22 ++++++++++++----------
>>  drivers/mtd/ubispl/ubispl.c       |  2 +-
>>  include/linux/mtd/rawnand.h       | 23 +++++++++++++----------
>>  lib/tiny-printf.c                 |  2 +-
>>  6 files changed, 35 insertions(+), 26 deletions(-)
>>
> 
> Coming back to these patches I had a look and except a typo , it looks good.
> I can take these through at91 tree or maybe Michael you want to have a
> look as they touch the MTD/NAND drivers ?
> 
> Thanks,
> Eugen


I have applied patches 1 and 2 to u-boot-at91/next .
The other three would need a resubmit .

Eugen

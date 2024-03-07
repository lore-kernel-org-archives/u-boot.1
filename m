Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD572C54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 19:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CCB2878E9;
	Thu,  7 Mar 2024 20:35:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fQ9tmoWA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82D5B87D80; Thu,  7 Mar 2024 20:35:39 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87DEB87D14
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 20:35:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-512f3e75391so1017422e87.2
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 11:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709840137; x=1710444937; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NrFAcIHk2eeRifLF8DO6GpzCU1taK52Z98PRnlL3rBo=;
 b=fQ9tmoWAU62XpHQ8FrcvSvvRLx2+E60d7omxvduOCgUnWDRbQjWPVj7RgIJHcecyI8
 KiqJ1yJXeaRSAJuJR79+dfgc950VdI7QwRVSfnVoPlRyWKlFoug1t4z3Z/szR9ljCSQY
 TN5IcTggx5tLwad6XJRe91sFBQcplSJ1YgKCnzmcB3JH4gEmu01kxRtg9d3QCBu9k/a2
 ubwqVodt4TV0CD2ClCh/7OS3O90ge3zQMY93x0x07+7iypQjormDAVuB+zmRUHKBpdTI
 qweFMvMmvCZwriBgy+k/YjXJS5y2VOEKqy5+5p9QwsV8SfKzbOYHgbmlxNa30LVCEUjV
 qxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709840137; x=1710444937;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NrFAcIHk2eeRifLF8DO6GpzCU1taK52Z98PRnlL3rBo=;
 b=vZDjyUii+af+GNWoqTxxYgvvs59vOMQjRcZr/I1a0geY3d3NJhBINAjvdbxuprC0AW
 0+G2hHjGxzPfNPt3U1DqmltpD4CC39x0GFQVQB2qe5wPxlviyd4ZdfftYWcKPEujasaf
 NPbRXQzBcH99urJNW1p3JDIDdnEkBdSNKi8qLZ9xq5OzhCcuw8yDvwAxFn9nXbN6G3Di
 luyfdtndOeqhfqk7VV3r2VVlFswOGWWYwfzDf+oniN3SwV9DIMWT/fqBoy0SHwdJKu7J
 UcR0qRAG0N8k1XJsyxv9fT5kQMaIJNOfl6IzzjXcjYP/avOdrkVI+HqWXE41XS+GK15Y
 GGWg==
X-Gm-Message-State: AOJu0YyjBEcTf53gNbAoxfMU7e8OmHIIvXvl9f6l+Mnyeu03RoNBl3/F
 PihOlWIBhUsg3c5yqNfoL4Nc+pUcDag2tJckPu/oAZCxQ+veE9YL0lEhPLJdxvi4fA==
X-Google-Smtp-Source: AGHT+IFmZcTvsaX7zow6KDaxqgl1Xxc35BvY0yC3zMenapcWqTc4my12/gBdToF/qOuZIyQ1tWg64A==
X-Received: by 2002:a19:e006:0:b0:513:55f2:7a3 with SMTP id
 x6-20020a19e006000000b0051355f207a3mr2071967lfg.39.1709840136417; 
 Thu, 07 Mar 2024 11:35:36 -0800 (PST)
Received: from [192.168.1.6] (109-252-14-191.nat.spd-mgts.ru. [109.252.14.191])
 by smtp.gmail.com with ESMTPSA id
 w9-20020a19c509000000b00513202d4174sm3143854lfe.116.2024.03.07.11.35.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 11:35:35 -0800 (PST)
Message-ID: <1fbcf398-ee89-49b3-b514-1c36b6ee04ec@gmail.com>
Date: Thu, 7 Mar 2024 22:35:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cmd: add FDT setup for bootelf by flag
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
References: <20240226183553.11615-1-Maxim.Moskalets@kaspersky.com>
 <20240307124126.GA4077069@bill-the-cat>
Cc: u-boot@lists.denx.de, Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
From: "Maxim M. Moskalets" <maximmosk4@gmail.com>
In-Reply-To: <20240307124126.GA4077069@bill-the-cat>
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

On 07.03.2024 15:41, Tom Rini wrote:
> On Mon, Feb 26, 2024 at 09:35:53PM +0300, Maxim Moskalets wrote:
>
>> From: Maxim Moskalets <maximmosk4@gmail.com>
>>
>> Added the ability to use FDT for ELF applications, required to run some
>> OS. To make FDT setup, you need to set the -d fdt_addr_r cmd option for
>> bootelf command.
>>
>> Signed-off-by: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
>>
>> Cc: Tom Rini <trini@konsulko.com>
>> ---
>>   cmd/elf.c | 27 ++++++++++++++++++++++++---
>>   1 file changed, 24 insertions(+), 3 deletions(-)
> This breaks building on a number of platforms such as
> xilinx_zynqmp_mini_nand_single.
>
There's an unresolved reference to LMB functions. This code compiles
without a patch (i.e. it is not disabled by the preprocessor or externally),
but when linking, since this function is not called, it is discarded
(you can check on a clean build with the command
aarch64-linux-gnu-objdump -d u-boot | grep image_setup_libfdt).
I think it's worth fixing this bug too.

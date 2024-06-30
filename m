Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B15C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 30 Jun 2024 10:40:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29E908862E;
	Sun, 30 Jun 2024 12:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aErINuRy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9CE58862F; Sun, 30 Jun 2024 12:40:36 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE24D8862D
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 12:40:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5295e488248so2598190e87.2
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 03:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719744034; x=1720348834; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7dJOpH7tDGxPs7YZQPp11lE1fpMNiT8oPKcIUDvPtKM=;
 b=aErINuRyCYOPwA+ZUn6nKVD29EDDi/ODBgyFu8uNBUKQKe2R2AOBkR+1B8EClTSgba
 EuiFKysJkz4bmxyWOWvQr5o/5sOumqMjZUDC7WSBOoAOJJ9f5eFcfNIDesITbG4QTApM
 5p1Mnje6qBoqnYLBnxWzejtonmLvDo6ybMeq9qoBd2HS5g1p5EALj5xcRckFsM4gu2S6
 ho1AK6XBSN9u32fin6AIYOY8feRfWjY7RBn2C7mgzNkFZMm43625eKivBBqMFB/vPTQE
 fUFQuLBbnkDd23GS/dGVCq1Bd81cjhILQT7SDWkZynDmjR72dIgclT+ch2wrhABiBK7i
 Z7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719744034; x=1720348834;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7dJOpH7tDGxPs7YZQPp11lE1fpMNiT8oPKcIUDvPtKM=;
 b=r4Lf1xsveIwJAm2jBq7zRxPObq5HD5S/E8vIEMUEA/0wojyWHd0jdbFiziET2qbXx2
 FCOTsZF3M95pvnCGDN5Uer+vSN4MYt20b1hZsjOm5drEJjCYEE/AC0BwOXl8Xy/llOHR
 k6S3w8byhna7dbDEXDePN2yzfo8eyVjuKYiI9etAu0AgVMsltMqcDxQ66b1GVU6kLw4a
 aIHGlLdCjf6GyY+SNw+BGWHnv88NySCxE2I6QwmFphVEDsjNlM5H4K81mgnksAnspnKt
 FnGk+9nRNcIlaetSJSZ56zw/x1rXJmwjAIIVyokEIHtyiCj7mTN17QcUrEPI3+8dvA/h
 sg2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXFqfad+WLsYG/sZ0/4+7NqmpNiq/SLcgjn7avguZ503s/Z6F94WSi8bQtGOi9rh6Ed24GP2kRoQvuWhoZIsHpe3ne9A==
X-Gm-Message-State: AOJu0YwtX3VAyZFGl8Gh49XopFRYDMsJNixx9FHuM0A7F4HB3MGAPnfF
 TMrkARdA3xmsy2InTZ0rBTbEX+Ei3+9kSPJ0smFUgTxv0juf9XUAwISH8Q==
X-Google-Smtp-Source: AGHT+IHURCDBfQSKKCW8bViDG3CgXtOdEMwpbR3bqD0X5RLZT3qFltphcB5SlQetqk/v7Nsacemtnw==
X-Received: by 2002:a05:6512:1056:b0:52c:8596:5976 with SMTP id
 2adb3069b0e04-52e82701398mr2024263e87.55.1719744033883; 
 Sun, 30 Jun 2024 03:40:33 -0700 (PDT)
Received: from [192.168.1.6] (109-252-15-116.nat.spd-mgts.ru. [109.252.15.116])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52e7ab10393sm909392e87.89.2024.06.30.03.40.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jun 2024 03:40:33 -0700 (PDT)
Message-ID: <e668226c-d70a-4369-a910-b5b955a0a6b9@gmail.com>
Date: Sun, 30 Jun 2024 13:40:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: add resize for FDT in bootelf
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, u-boot@lists.denx.de,
 Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
References: <20240628083411.19843-1-Maxim.Moskalets@kaspersky.com>
 <CAFLszTgWusENqmRi7ehDAqK+dJsCV_Y-cAAprQ9vbragBwdFWg@mail.gmail.com>
Content-Language: en-US
From: "Maxim M. Moskalets" <maximmosk4@gmail.com>
In-Reply-To: <CAFLszTgWusENqmRi7ehDAqK+dJsCV_Y-cAAprQ9vbragBwdFWg@mail.gmail.com>
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

Hi Simon,

On 29.06.2024 09:56, Simon Glass wrote:
> Hi Maxim,
>
> On Fri, 28 Jun 2024 at 09:34, Maxim Moskalets <maximmosk4@gmail.com> wrote:
>> In some FDTs, there is not enough free memory to add nodes, so this
>> operation fails.
>>
>> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
>> ---
>>   cmd/elf.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/cmd/elf.c b/cmd/elf.c
>> index 32b7462f92..673c6c3051 100644
>> --- a/cmd/elf.c
>> +++ b/cmd/elf.c
>> @@ -68,6 +68,8 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>                  log_debug("Setting up FDT at 0x%08lx ...\n", fdt_addr);
>>                  flush();
>>
>> +               fdt_set_totalsize((void *)fdt_addr,
>> +                               fdt_totalsize(fdt_addr) + CONFIG_SYS_FDT_PAD);
>>                  if (image_setup_libfdt(&img, (void *)fdt_addr, NULL))
>>                          return 1;
>>          }
>> --
>> 2.39.2
>>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Would you mind adding some docs for this comment in doc/usage/cmd/elf.rst ?
I added the documentation, but since it's not relevant to this patch, 
it's in the
[PATCH] doc: add bootelf command documentation

Regards,
Maxim
> You can also use the 'fdt addr <addr> <size>' to expand the FDT.
>
> Regards,
> Simon


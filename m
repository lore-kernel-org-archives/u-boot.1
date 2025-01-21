Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96965C02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 13:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0E95805C5;
	Tue, 21 Jan 2025 14:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jko/a6Jv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EBDB80763; Tue, 21 Jan 2025 14:15:43 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23A8580326
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 14:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so3002867f8f.2
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 05:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737465340; x=1738070140; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E4NYAFTUiWyHZZ5rCoJoch9dCceAc44D/MbJpiVMmas=;
 b=Jko/a6JvUD1Qx6mo1HGVKZndaC+64O53t4uUJEj2ovJODMn4g6qCi7hzE4UZzV8EfI
 ofmJT42ELuqZX9cWhiVyB9gYiU8lNVCaMmwHytxq/RBnMF5RXObIBNBTQ3N5tHXupFUL
 enOq/JG7bWWIemq/Qumwa/3WQ7OfujuYdZDd44zYh2VYwwQe2VDcGH7KxYknbqMTagk+
 L0VUDxMGE+ckhMPfMFt3zpYHL+WFXBYnVfJ+oeqt7Cb6GwJJQIX1ruW++bYZ28V7GpNs
 sxsGQH3fIH32TkWBslomMrteKq1sI2HeAZZ1vCtfKMAM5rI7cuWxJ3d7tV1uh2UXV3o2
 8gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737465340; x=1738070140;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E4NYAFTUiWyHZZ5rCoJoch9dCceAc44D/MbJpiVMmas=;
 b=ds9eWFdujgQR3UO42beql0lLDu1RDKLbcV+WpCjhgo8e7Fi5/8JY6ykND9NqTncLti
 8hxrvd7d0lGeDXF3q8tc/NBBKm9suR3SpnqtarkKDMmHrvpZF/PopjrmUc88D0d6JSJ0
 eYR8Ps6IbHvQxZbIlfkqP8Z0+xt3lAzFcrovChPhj8YlolYK1fvWnRDWEOxnFsW6o+2E
 VWex+LiRJCNNThNLNOVlGpQSdbottL6Dz/zz/LmlIj4oE5shTTDwND4XqsZc8MCxVPpO
 LOfiZ8YFOMgiW4oVOPS6s0vQjFM5z53O67ijv/0VWwRgLhdmEO+fRquZvpL02WvTjVnH
 CA7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4eWGYd+aDsEUqIk3YH2tFuLLrp9r/exqrMc4ih8W9aZnroexrnbOr948lAWRsjCwHgxobF3w=@lists.denx.de
X-Gm-Message-State: AOJu0Yxi7KLSJG2dWnHInJ7AtOhz2WCKn/WTMW/7NbadF46mEba+Pq5M
 Xcn6QzuoCFjslbUGHqVTR+TLnkFuQqxmyyE0K/oKOHxaphUQ3v+sAYwu8HrxHKinv9A/v7rZELO
 jolrTnQ==
X-Gm-Gg: ASbGncvq2QS8sKQPhN4ktPQvBqL+PexME1CpZ+cVSN2n7Y3hs7vjCyNkUFpdp5qe16w
 K5ywn9i2k1TSLUSENJs3pc2tIIkuzYTdzLAHJ75/Zah3hO8JKwkjaz+RPFGbJrWlAdtfpQiUoJ7
 7xmM4fNf/jgII7756oWYjhh4i1JURgbAp4Z4NrvYWjowXveKzmNakyegS6lloM+mAZHQyn4IA5I
 KbKqIz2ctglGoZoqhsdzl1VlRsNIM2DmXNIX020dXPZ6cCJMsOxNQvrDftlXBph9kL+vU43mcER
 sO4vZ08=
X-Google-Smtp-Source: AGHT+IHbdHUylEOClDxhg1hh3xDP60hs//7Lg9b9v4AZ4SQ0RtnMqNG1OC+li8SkwMta764535LN1A==
X-Received: by 2002:adf:f048:0:b0:385:edd1:2245 with SMTP id
 ffacd0b85a97d-38bf5675819mr11104524f8f.30.1737465340578; 
 Tue, 21 Jan 2025 05:15:40 -0800 (PST)
Received: from [192.168.7.95] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf327556dsm13320214f8f.71.2025.01.21.05.15.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 05:15:40 -0800 (PST)
Message-ID: <13765dd9-c958-47f6-8076-f10b93561cca@linaro.org>
Date: Tue, 21 Jan 2025 14:15:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] Introduce coroutines framework
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>
References: <cover.1737380886.git.jerome.forissier@linaro.org>
 <e17799b6938d4afe08b80fc20b70f4d3a81db848.1737380886.git.jerome.forissier@linaro.org>
 <24dc7f4c-62bb-46e4-b7d7-6c3aa472c36f@amd.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <24dc7f4c-62bb-46e4-b7d7-6c3aa472c36f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Michal,

On 1/21/25 12:44, Michal Simek wrote:
> 
> 
> On 1/20/25 14:50, Jerome Forissier wrote:
>> Adds the COROUTINES Kconfig symbol which introduces a new internal API
>> for coroutines support. As explained in the Kconfig file, this is meant
>> to provide some kind of cooperative multi-tasking with the goal to
>> improve performance by overlapping lengthy operations.
>>
>> The API as well as the implementation is very much inspired from libaco
>> [1]. The reference implementation is simplified to remove all things
>> not needed in U-Boot, the coding style is updated, and the aco_ prefix
>> is replaced by co_.
>>
>> I believe the stack handling could be simplified: the stack of the main
>> coroutine could probably probably be used by the secondary coroutines
>> instead of allocating a new stack dynamically.
>>
>> Only i386, x86_64 and aarch64 are supported at the moment. Other
>> architectures need to provide a _co_switch() function in assembly.
>>
>> Only aarch64 has been tested.
> 
> I can't see the reason why to keep x86 around if it is not tested.

OK, I'll drop x86 in v2.
 
> Licenses should be cleared for all files.

I will add "SPDX-License-Identifier: Apache-2.0 OR GPL-2.0-or-later"
to the coroutines C implementation (include/coroutines.h and
lib/coroutines.c) since it originates from libaco which is Apache-2.0
then was modified by me for U-Boot. I will add GPL-2.0-or-later to
arch/arm/cpu/armv8/co_switch.S since it is a new file written by me.


> Also I think this mostly should target full u-boot and not really TPL/SPL as of today.

I agree, but why do you think it targets xPL? efi_init_obj_list() is
called as a result of "printenv -e" in the main U-Boot for example.
I mentioned in the cover letter that I think coroutines could be
beneficial in other places too.

> 
> I have applied this patch to measure time difference on kv260 and kd240 and pretty much the time is the same.
> 
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index 94160f4bd86c..18d2260b8c11 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -258,6 +258,7 @@ extern int udelay_yield;
>  efi_status_t efi_init_obj_list(void)
>  {
>         efi_status_t ret = EFI_SUCCESS;
> +       ulong t0, t1;
>  #if CONFIG_IS_ENABLED(COROUTINES)
>         struct co_stack *stk = NULL;
>         struct co *main_co = NULL;
> @@ -272,6 +273,7 @@ efi_status_t efi_init_obj_list(void)
>         /* Set up console modes */
>         efi_setup_console_size();
> 
> +       t0 = timer_get_us();
>  #if CONFIG_IS_ENABLED(COROUTINES)
>         main_co = co_create(NULL, NULL, 0, NULL, NULL);
>         if (!main_co) {
> @@ -333,6 +335,9 @@ efi_status_t efi_init_obj_list(void)
>                         efi_obj_list_initialized = ret;
>         }
>  #endif
> +       t1 = timer_get_us();
> +
> +       printf("time counted %ld\n", t1 - t0);
> 
>         /* Initialize variable services */
>         ret = efi_init_variables();
> 
> Please correct me if you have measured it differently.

That's fine. Do you have a SD card inserted in your board?
If not, the efi_disks_register() call is very quick and
therefore it makes little difference if it's run
sequentially or in parallel with efi_tcg2_register().

Thanks,
-- 
Jerome

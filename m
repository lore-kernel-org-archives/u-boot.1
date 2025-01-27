Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8B3C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 10:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 274D181119;
	Mon, 27 Jan 2025 11:32:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MbbN9l57";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 887E08111F; Mon, 27 Jan 2025 11:32:29 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F37981115
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 11:32:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-386329da1d9so2144134f8f.1
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 02:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737973946; x=1738578746; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hSkfV4al2Y1AOuFpePi+ro1PcytQy284aVfla7MsSl0=;
 b=MbbN9l57NpN29X44Ib9sr7Xk+8a94LVe8p3+Eolxq26DBvU8slcwv6uN5aaGk9Zrq9
 TGXE2hQn67v/WwaQ32R4CtiZYaOolEgI+9YuqjJQzIIwBcB2SKOvMPi7owxNrd2ivoNq
 SSA8p6F3dKrCH+hWA8P3Ayg2xCFhtXW0hRoMuydrU81lgQQ+ExNreF4YW4VsIIfrZ7KC
 fkAe/baYStYTRlgPwjoYRx2rPlfR3svCu2ghtezp+gf+Mie8fiSDOWWKa7hK5I5ophHL
 rrwcHse4VxLdFx2jkmY4egUUwRvD6RQ1TB5spfGMIMGQvNA9nfQTN1hk82+U/H7Ue0fb
 CLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737973946; x=1738578746;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hSkfV4al2Y1AOuFpePi+ro1PcytQy284aVfla7MsSl0=;
 b=Jj+Awj2koCC9xn1LPtXFAn8b1yqgN3mRr58EYHgk1BT2h7DstBIPuUhBr/bkjyBfzq
 6OZPQU5gwUED6wgz4EpWy2QN+BGtEs3t/xXCQryA9Km08n4PGF6Qor+f0EGntmqdxNF/
 tteCVpDunFpL8Mi4lSkNMniYjKg2OUBEHGGeM2EWTHalP8jnCVUd5R5N3Xgs8h6gm5Ua
 fbQk0COujRiCmaVWTL+TTo7trY45OXD32vRWJftghD5EdNZlRzk8yzlsfojwOGodFOMM
 mroDnTGMRM9sJjop2UzBOKQVS4t7DCsdLtTo0YUnXamK/zIbSI+eC5AqoBzDg5l/Vltw
 d21A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQESaEQOd7042jrBrjTqGzppPl3k8VKmvH2QXscXq24HURPG8a3lSMgOhmurvIvIjNchrKots=@lists.denx.de
X-Gm-Message-State: AOJu0YzvXTJoGIJuYiFKFpnEVZwCRdNfHVAUUS/3Cuo/gcPv5azUy+I+
 Vdt1uU9aiCt6NkIV+fHQ07sRQljxWtTdOmosAE1lhyNoKrIwQV1GPdjCXq7RUEg=
X-Gm-Gg: ASbGnctbuE7Hkzljb+4IAzIBV9x9Nv8uTPf3ytdwMhbqWukekuz0uCF6+hPLhYXE0Hj
 eAxRachsPxBT6HxyMNpONCfjXFNlzjZRCgBJtKWevePHzADH2zsio2AAyw91rjSfyE5k+k33hua
 eaIEnlZzMQDA1FWz9gG8xYmRXnKBu65XeBvK2HeWk8tsJbO0rPlUXCMTBn26Mj6H97/oaFwTjJF
 3zPxZYr8b0FkjrzSM3Gj1llyNQToUbGjTCQGWPqTA6g24ZdUKTkriBgC1vqxBebIbblzvoSAfWx
 Jv3M4oqYY4FTsZYfcgbTrqT1gEWDdnenAS5gzCgPAy5c6549pNgXOTD5WGz3
X-Google-Smtp-Source: AGHT+IEClpw3OhtNlwG+wQ4D8+RuupB5oTX3a2mEnUbtHreOR/GA9kJ4wtVPOekln3QR+afwZYPbMQ==
X-Received: by 2002:a05:6000:1863:b0:38a:8d32:274e with SMTP id
 ffacd0b85a97d-38bf56551famr32724784f8f.5.1737973946473; 
 Mon, 27 Jan 2025 02:32:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:cc93:6dd0:3ebd:6dc5?
 ([2a01:e0a:3cb:7bb0:cc93:6dd0:3ebd:6dc5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d7a7sm10913235f8f.32.2025.01.27.02.32.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 02:32:26 -0800 (PST)
Message-ID: <0ded07f8-3afd-4d26-b3de-cd94c9a57ff9@linaro.org>
Date: Mon, 27 Jan 2025 11:32:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] common: board: make initcalls static
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
References: <cover.1737709089.git.jerome.forissier@linaro.org>
 <564c3f3b7f70c893b2c6b6dfc89a226b90d411de.1737709089.git.jerome.forissier@linaro.org>
 <f9bfd3d8-dd30-4f4e-a73d-ab9082f832a8@denx.de>
 <38bb1c47-8001-4415-a421-ff1b501f0105@linaro.org>
 <77906c5f-3d67-4c43-9e22-c8ea74695146@denx.de>
 <bebd3427-2d20-43ad-b682-ed02858db546@linaro.org>
 <4c2a3f99-4af2-4c5c-ba63-9a90018b51bd@denx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <4c2a3f99-4af2-4c5c-ba63-9a90018b51bd@denx.de>
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



On 1/25/25 00:58, Marek Vasut wrote:
> On 1/24/25 6:23 PM, Jerome Forissier wrote:
>>
>>
>> On 1/24/25 17:23, Marek Vasut wrote:
>>> On 1/24/25 4:57 PM, Jerome Forissier wrote:
>>>>
>>>>
>>>> On 1/24/25 11:35, Marek Vasut wrote:
>>>>> On 1/24/25 10:10 AM, Jerome Forissier wrote:
>>>>>> +#define INITCALL(_call) \
>>>>>> +    do { \
>>>>>> +        if (_call()) { \
>>>>>> +            printf("%s(): initcall %s() failed\n", __func__, \
>>>>>> +                   #_call); \
>>>>>> +            hang(); \
>>>>>> +        } \
>>>>>> +    } while (0)
>>>>>
>>>>> Can this be turned into some static inline function too , so typechecking would be retained ? Maybe the function can be passed in a function pointer to call ?
>>>>
>>>>
>>>> Doing the below totally kills the space gain (-160 bytes instead of -2281
>>>> on zynqmp_kria_defconfig, with LTO).
>>>
>>> Does the compiler not inline the functions perhaps ?
>>
>> It does. inline vs __always_inline makes no difference. The assembly
>> code is pretty difficult to understand in any case (macro or static
>> inline function). There are pieces of called functions all over the
>> place inside initcall_run_f() which is to be expected with LTO I
>> suppose.
>>
>>>
>>>> And it prevents from printing the
>>>> function name in case of error, which is nicer than an address
>>>> (especially with relocation at play).
>>> That function name can be passed in using __func__ as a parameter.
>>
>> True. That being said, the type-checking argument does not seem
>> decisive here, and although I too prefer to use static inline
>> functions over macros when possible, it looks like we have no choice
>> in this case.
> Can you try this kind of thing (might need some tweaking):
> 
> "
> static void check_and_fail(int *ret) {
>   if (*ret) {
>     printf("failed\n");
>     hang();
>   }
> }
> 
> static inline void INITCALL(int (*_call)(void))
> {
>   int ret __attribute__((__cleanup__(check_and_fail))) = _call();
> }
> "
> 
> (maybe it really is the passing of pointer to _call() function into the INITCALL() function which confuses gcc into not inlining this right, but let's find out)

It seems to be working as expected (size-wise). Comparing the macro
version with yours, without LTO then with LTO:

$ ../linux/scripts/bloat-o-meter /tmp/u-boot.macro /tmp/u-boot.inlinefn
add/remove: 2/0 grow/shrink: 1/2 up/down: 1386/-1700 (-314)
Function                                     old     new   delta
initcall_run_f                                 -    1316   +1316
check_and_fail.isra                            -      64     +64
version_string                                70      76      +6
board_init_r                                 836     664    -172
board_init_f                                1572      44   -1528
Total: Before=1121213, After=1120899, chg -0.03%

$ ../linux/scripts/bloat-o-meter /tmp/u-boot.macro.lto /tmp/u-boot.inlinefn.lto
add/remove: 5/3 grow/shrink: 2/3 up/down: 11418/-11072 (346)
Function                                     old     new   delta
initcall_run_r                                 -    7532   +7532
initcall_run_f                                 -    3540   +3540
add_to_list.lto_priv                           -     248    +248
zynqmp_power                                   -      48     +48
check_and_fail.isra                            -      32     +32
__func__                                     975     987     +12
version_string                                70      76      +6
__func__.lto_priv                           3700    3688     -12
zynqmp_power.lto_priv                         48       -     -48
add_to_list                                  248       -    -248
get_mem_top                                  568       -    -568
board_init_f                                2880      56   -2824
board_init_r                                7424      52   -7372
Total: Before=1068190, After=1068536, chg +0.03%

But note that the two are not equivalent since yours doesn't print
the initcall name in case of failure.

Regards,
-- 
Jerome

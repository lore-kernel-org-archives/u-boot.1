Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0703C02181
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 00:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0EB080A52;
	Sat, 25 Jan 2025 01:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737763408;
	bh=2eRclDA/JZpIqsfaqlxB9b7lHPLKpn9fh9W4g/dW2vg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NtEWh1lu2WHut40bJi7LjbohcOG0/SH8Ze96oPCHlpKSLTsPbE956Auv/pJgxXOY1
	 QAZ7EEbnhFieLOAMnXyUkXl/8ieLkrOIID/Mgkm8RIbaumYxoO1mFbz+Y0vOSP1TwF
	 lnC2Whax6QmtLdqhYBz0RkK4xXbPXnu2T4QPHB5slHSjv651ZfUpgk3YqnPcX3PmyC
	 QbM0E1EZLyBeuQhLMd/cZtZBG7/MjF6acNY3MHXMIpKM/OR/vvCCFKTHdScIGOv+gd
	 dRDiY4rq0BMtm/+piWra+bSTDiBqz2UbKLjJkM77mbY2EMGYVetuwZQDVZRjSwFppI
	 aJ3vfUGbAxtrA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A418980ADB; Sat, 25 Jan 2025 01:03:27 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8462E80A45
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 01:03:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="T00W/Uo3"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 965721048EF60; Sat, 25 Jan 2025 01:03:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737763403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2eRclDA/JZpIqsfaqlxB9b7lHPLKpn9fh9W4g/dW2vg=;
 b=T00W/Uo31QKqdCk7NtbuqXFqPYcLQKNtVjt2+9IX9JaIWaZHaeuoNDGoCYfL8bDJvVtcNz
 51F92E0WoiTZQI2ZKhUK0uJEkMdBhgU4Ab+Pvo5xeTJGrz1y8p+NfA2KWKsfBvOPXFA7C6
 96ZIlLUOQ/xazcXS2jYBCHwGCoHtSH53H8xNqinf4C9qdPrE2ILJpA2D5t61G2/KZhQmIe
 xoL6rrIIg7xHTu5hT+Xwv4WWLDO7Hg1ZJbAhXW1xRUilfOZ1/9q6XEKRnIp1PWkzdPgCsQ
 wGDFyYrBLyGngfioNNvgseOuDWM0nlnngeoeJfRCfUbzcvivW12EOwQkU97FyQ==
Message-ID: <4c2a3f99-4af2-4c5c-ba63-9a90018b51bd@denx.de>
Date: Sat, 25 Jan 2025 00:58:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] common: board: make initcalls static
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <bebd3427-2d20-43ad-b682-ed02858db546@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/24/25 6:23 PM, Jerome Forissier wrote:
> 
> 
> On 1/24/25 17:23, Marek Vasut wrote:
>> On 1/24/25 4:57 PM, Jerome Forissier wrote:
>>>
>>>
>>> On 1/24/25 11:35, Marek Vasut wrote:
>>>> On 1/24/25 10:10 AM, Jerome Forissier wrote:
>>>>> +#define INITCALL(_call) \
>>>>> +    do { \
>>>>> +        if (_call()) { \
>>>>> +            printf("%s(): initcall %s() failed\n", __func__, \
>>>>> +                   #_call); \
>>>>> +            hang(); \
>>>>> +        } \
>>>>> +    } while (0)
>>>>
>>>> Can this be turned into some static inline function too , so typechecking would be retained ? Maybe the function can be passed in a function pointer to call ?
>>>
>>>
>>> Doing the below totally kills the space gain (-160 bytes instead of -2281
>>> on zynqmp_kria_defconfig, with LTO).
>>
>> Does the compiler not inline the functions perhaps ?
> 
> It does. inline vs __always_inline makes no difference. The assembly
> code is pretty difficult to understand in any case (macro or static
> inline function). There are pieces of called functions all over the
> place inside initcall_run_f() which is to be expected with LTO I
> suppose.
> 
>>
>>> And it prevents from printing the
>>> function name in case of error, which is nicer than an address
>>> (especially with relocation at play).
>> That function name can be passed in using __func__ as a parameter.
> 
> True. That being said, the type-checking argument does not seem
> decisive here, and although I too prefer to use static inline
> functions over macros when possible, it looks like we have no choice
> in this case.
Can you try this kind of thing (might need some tweaking):

"
static void check_and_fail(int *ret) {
   if (*ret) {
     printf("failed\n");
     hang();
   }
}

static inline void INITCALL(int (*_call)(void))
{
   int ret __attribute__((__cleanup__(check_and_fail))) = _call();
}
"

(maybe it really is the passing of pointer to _call() function into the 
INITCALL() function which confuses gcc into not inlining this right, but 
let's find out)

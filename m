Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E43C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 16:24:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5133680AE2;
	Fri, 24 Jan 2025 17:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737735848;
	bh=9+qMZh7jnSHazgxlArrJ5Q7UYAn4LlL0RLOb5sJOqHs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nMAglyQwF9UtSJooFab28EonQeZCCbxq03Ff+ZYs1hAwlKo3SUuQpf4RIwmM9T7/o
	 wbO1Ix7tcvWxp9iTUgFB0nFQ7I7bBgRGecVmFh55qwcmEwIPONrPLKm1mKFIElGilR
	 jL4x9SFHbJ5OE54cdfA5InLLpMPOB49l2MAjps7FOR+tA6dBTt/IvvXuZLpfRGydD3
	 8zDFn4cs3MXdSVT6lKZdwoiZZZ2VdFD1JjyQKekM5v4j2lY+FT9dDXM6mqvu6x8FLl
	 1Chu17AIy/6OXf2a/xn0wl3RpkYkcEyfRTzumtGheQAb4/HzegVGbI790kA7QbJ/s9
	 3ELsd0ivjL6/Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33DFC80AE6; Fri, 24 Jan 2025 17:24:07 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FBF680A52
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 17:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="PI+lUPVl"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A4BE510408F83; Fri, 24 Jan 2025 17:24:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737735844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+qMZh7jnSHazgxlArrJ5Q7UYAn4LlL0RLOb5sJOqHs=;
 b=PI+lUPVlCk5obbFpeR2svOTjoBTrRQCJOU3fqe8ZACLfLx6btJYCu0dWzEW8xRYJJuBSwm
 jsnr7B6NLyZydj3XchPiiNq5Jxr7HPdQf2teTFaeeuWtnj5+NB9OkcDFQqirzOLqzRBA8K
 atGJwF/u9On64ujz/yJ+aXlnHwLJjcmDWZqCFnSPuesrNObS5Ryx5fRlGgaEBFKAJA2/Nk
 brZGRPD3Bt8mV7WL8CedEm8czPNn1qt5Y+xy10LsufofK6NjF7Y5ntpb1U6+MH2dNkieqh
 Re39eHV8kG70kGia8RWn0chitGCWXMXTQNshfyvf77SR49Opd4g1oHzdHep7QA==
Message-ID: <77906c5f-3d67-4c43-9e22-c8ea74695146@denx.de>
Date: Fri, 24 Jan 2025 17:23:59 +0100
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <38bb1c47-8001-4415-a421-ff1b501f0105@linaro.org>
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

On 1/24/25 4:57 PM, Jerome Forissier wrote:
> 
> 
> On 1/24/25 11:35, Marek Vasut wrote:
>> On 1/24/25 10:10 AM, Jerome Forissier wrote:
>>> +#define INITCALL(_call) \
>>> +    do { \
>>> +        if (_call()) { \
>>> +            printf("%s(): initcall %s() failed\n", __func__, \
>>> +                   #_call); \
>>> +            hang(); \
>>> +        } \
>>> +    } while (0)
>>
>> Can this be turned into some static inline function too , so typechecking would be retained ? Maybe the function can be passed in a function pointer to call ?
> 
> 
> Doing the below totally kills the space gain (-160 bytes instead of -2281
> on zynqmp_kria_defconfig, with LTO).

Does the compiler not inline the functions perhaps ?

> And it prevents from printing the
> function name in case of error, which is nicer than an address
> (especially with relocation at play).
That function name can be passed in using __func__ as a parameter.

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255E7C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 10:54:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CE5280F96;
	Tue, 25 Feb 2025 11:54:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740480867;
	bh=YcZsZ53WCU1glY5yNQKXxxeFT1Aya6qjPHRXgrtmFPg=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=mF7J2cWNRlbAcrELWGCHm/6o8/f5Riezr9a5nCSB8ZvW4Q7LDQwqPorBABQPXY9Tk
	 CMiG4+sg63XoileT5Qryn9brbAr/Vky3+0WsduHqL9Nw1dODguHYbgTVdRyJ4DyXC9
	 wE1VV9BbXfLmBtFjJzxOZRlaYu+FfSnE52bl7yEcv0krrOuF5Nj0TkREl5qWgiqd5n
	 Df3r2B8phTVO+HwYXCXRv+cZ4lB9KqUGDGFlcBvG6+ZLQxGF4IdZNxHTwzMgpxtsSR
	 L7RZfmwguxwyRE6cZIWPFFchzzXnoV7/IqKoZ79sa6NAo88VKpAILURKAH+tG9fFZ5
	 i7bLT3OgdXtMQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 223D580F9E; Tue, 25 Feb 2025 11:54:26 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C531B80F92
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 11:54:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="K7vpobQp"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D217110382D2E; Tue, 25 Feb 2025 11:54:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740480862; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YcZsZ53WCU1glY5yNQKXxxeFT1Aya6qjPHRXgrtmFPg=;
 b=K7vpobQpjb1RlImGiHWzFlumLgrdTf6ZX3iqj22c5qaDOphdvoR3v9oR6beLDF9BBrzDBr
 6qJC+G0iTJQMc3VV6ZLibts0lwI2sIVuzGy8JvW5dvKW5yzTljy7FdU9T0MrcsMldc4roN
 Mf/uCFa9ICdeHXCiYw1+6G9pYe20kAdO7S5/2QiUqxFvnys4n5AOAViTT9s71wTG8M+iW1
 wnDffn2VERmhMvjflQWUNu7/ovk1fI/Xlmt2Y+F1WLDIrQUuGMA4Bc42u4Ql+FXnP8ltDA
 CYv0RdMTH/DymZMCt+bQ+meqbd6UbKJh3kFE76RPvzfwRnuFEdlmtn8PA0PRcg==
Message-ID: <f6cb2ae7-5e28-2020-96f5-c83ef73ef939@denx.de>
Date: Tue, 25 Feb 2025 11:54:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de
References: <20250225023913.GK1233568@bill-the-cat>
 <176357bb-258b-2523-66e9-d94a51064f17@denx.de>
 <f1503afd-e299-4320-a60b-0eb2c57799c9@cherry.de>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <f1503afd-e299-4320-a60b-0eb2c57799c9@cherry.de>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Quentin,

On 25.02.25 11:48, Quentin Schulz wrote:
> Hi Heiko,
> 
> On 2/25/25 7:06 AM, Heiko Schocher wrote:
>> Hello Tom,
>>
>> On 25.02.25 03:39, Tom Rini wrote:
>>> Here's the latest report. Getting closer with the led change. I do wish
>>> it was easier to test fixes here.
>>
>> Yes...
>>
>>> ---------- Forwarded message ---------
>>> From: <scan-admin@coverity.com>
>>> Date: Mon, Feb 24, 2025, 5:05 PM
>>> Subject: New Defects reported by Coverity Scan for Das U-Boot
>>> To: <tom.rini@gmail.com>
>>>
>>>
>>> Hi,
>>>
>>> Please find the latest report on new defect(s) introduced to Das U-Boot
>>> found with Coverity Scan.
>>>
>>> 1 new defect(s) introduced to Das U-Boot found with Coverity Scan.
>>> 2 defect(s), reported by Coverity Scan earlier, were marked fixed in the
>>> recent build analyzed by Coverity Scan.
>>>
>>> New defect(s) Reported-by: Coverity Scan
>>> Showing 1 of 1 defect(s)
>>>
>>>
>>> ** CID 542488:  Control flow issues  (NO_EFFECT)
>>> /drivers/led/led-uclass.c: 277 in led_get_function_name()
>>>
>>>
>>> ________________________________________________________________________________________________________ 
>>>
>>> *** CID 542488:  Control flow issues  (NO_EFFECT)
>>> /drivers/led/led-uclass.c: 277 in led_get_function_name()
>>> 271                     return uc_plat->label;
>>> 272
>>> 273             /* Now try to detect function label name */
>>> 274             func = dev_read_string(dev, "function");
>>> 275             cp = dev_read_u32(dev, "color", &color);
>>> 276             // prevent coverity scan error CID 541279: (TAINTED_SCALAR)
>>>>>>      CID 542488:  Control flow issues  (NO_EFFECT)
>>>>>>      This less-than-zero comparison of an unsigned value is never true.
>>> "color < 0U".
>>> 277             if (color < LED_COLOR_ID_WHITE || color >= LED_COLOR_ID_MAX)
>>> 278                     cp = -EINVAL;
>>
>> So I simply remove this check ... and add a comment that LED_COLOR_ID_WHITE
>> must be 0...
>>
> 
> It's part of the binding from the kernel, I assume it's safe to assume it'll be 0?

Yes it is.

> Also, this is guaranteed by the fact color is a u32 in led_get_function_name, so it cannot be < 0.

Posted a fix, see:

http://patchwork.ozlabs.org/project/uboot/patch/20250225094923.71364-1-hs@denx.de/

added a comment @LED_COLOR_ID_WHITE definition, so in case someone wants
to move LED_COLOR_ID_WHITE to another value... may it helps.

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

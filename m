Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055E0C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 11:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FED288709;
	Fri, 12 Jul 2024 13:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="e8sfV0/H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29EAE8871F; Fri, 12 Jul 2024 13:56:05 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C2FF87DEB
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 13:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1720785359; x=1721390159; i=xypron.glpk@gmx.de;
 bh=8XtFDOPdz+v6ehv32qQ0lkL9a2XQ8s2lO8sjUu5Og0M=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=e8sfV0/Hb7l+TAUFjVCBE733iyUEyq1/bKzzg7eCTBVVOOPGLQSHfuIbm7QlAFRt
 oZ6qU5h/cJv7OvUecaQb3zU+tcwjZzPr1sCMXQhzBw/NIRLuQrtdJn8wKnkboUhRc
 pa30LosHBDn1OgUq8/BHFD97+l9v7+IAB/M0tYhhI3Gm+pSRgDZfXgDIgdfKp37LF
 jRc51y8iysuHzIEcZDDzTpzn28fPgXHJDueGAOC7MD7DiINiaYyTWwyK7bVh+OMIo
 /pYLk9lQzGnWY/31RyMpbQ3ctwjRohvjvq1s+Pj8354YvuJ4wtzMVjnxENG7p/HHe
 UF2afiWBRh/Is251rw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.93.80]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAwXh-1sczKA3CKv-002vQy; Fri, 12
 Jul 2024 13:55:59 +0200
Message-ID: <40f5e668-e477-4685-9cfa-90f01f3e73c4@gmx.de>
Date: Fri, 12 Jul 2024 13:55:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fat: fat2rtc: Sanitize timestamps
To: Richard Weinberger <richard@sigma-star.at>
Cc: Richard Weinberger <richard@nod.at>, ilias.apalodimas@linaro.org,
 sjg@chromium.org, christian.taedcke@weidmueller.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at, upstream@sigma-star.at, u-boot@lists.denx.de
References: <20240712082454.8752-1-richard@nod.at>
 <E6A299D7-6DA8-4FA7-8864-BB6F346B4394@gmx.de>
 <2549250.Sgy9Pd6rRy@somecomputer>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <2549250.Sgy9Pd6rRy@somecomputer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1iRI7f7YvtDoiyFi/t6yIFt+zcGkmQxDTfXA0DKtBclqU5M0587
 KWdhGU0vLxud6TK80YNIedmzv/DtJz6ApghPKsyxhwgZNGQ+sUKoaTfHYO8Lo8B7iPYtZez
 +80fB+iBjeL6/qDlmecdku3gcMpv2RLhluVxaMxDfNBS1qli+NpK+bCdl7Tul6eLMfolf6m
 vDItbjqrgmJfKMrql+LuQ==
UI-OutboundReport: notjunk:1;M01:P0:axk/KfzXfF0=;ylp6pIta22x9W3D2AUIy1dLQlGO
 mdIfVGgQ6/K+IuTs2z+/RtZ+UlhDTLkZXXTo/UeIni5U6v9UE0KdpKI2DW6FhHvzlJWkG/rUz
 hC+XMgMciCKN/AQJGDkVc1JAEx+rSJj/zkqEjSZzyDXSLdyVT0/ZIv7FUrR2aXGiXi0e1XIdb
 ejVhf79zqcmWfUKG2Tn7Z554CvVjnPmT3mPwwtBPF8JaLeeZf2g5ufTBksKI2w26gnCH1CkGv
 oae0pZ5qzYpYvFcpYO1S1u3Xw8GsHCApXh+8AWnn2ZgKMj8UTCAucO0ZivU9Edno8xqQCI0RB
 +98aUQ5/T8wnnCu7vLGXFUb8oikMQfoWgdsbVxSqSvpgsTdk0F2D5Gf194+zkGBQexKKBuGws
 FlX2hdqfxU1zE9Yxsi/3/TjpsspZBMFUgg5Mr3pTGDGumvo/S+hloNRbk1SDYiCj6m0YHB6FM
 ++vJ7zcIFQ9Ve/rnqRItdoh1cyzkMwvCIfEf7/AM9oNKeKHx7UPW/4ho4PT338b9mZYMyEqJX
 I20kM3Vq+ZaV0HciRXb4IZL8oGzNpTjI2xdR8Ty+FAlo2UiG1kAA3eP8k/FaA/7mbUOxQvEpA
 +CMLBUq+yL7JHr6PPb+KMQ+DKYuYGkGudaQvQcCJ34fjTIHhbVA66jZjPRAqW7SvZhpe9UmXs
 zaIOqBR8kWpT0rQUQYKY0wWbZo1DV77LGo3aJUcHOzy4P+CRTmOtG8K8jhn5tDD9HfPuK/pnu
 Pyn0AwmFWhHEVEV2vZLnED7rWy1dOX95XsHJJ0u7yj4IP9yxvlB06keJgsgQwmDUxK5JMDKoY
 SXpNB5pGOU+m/N0dXeQvilEg==
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

On 12.07.24 11:51, Richard Weinberger wrote:
> Am Freitag, 12. Juli 2024, 11:46:08 CEST schrieb 'Heinrich Schuchardt' v=
ia upstream:
>> Am 12. Juli 2024 10:24:54 MESZ schrieb Richard Weinberger <richard@nod.=
at>:
>>> Make sure that tm_mday and tm_mon are within the expected
>>> range. Upper layers such as rtc_calc_weekday() will use
>>> them as lookup keys for arrays and this can cause out of
>>> bounds memory accesses.
>>
>> rtc_calc_weekday() might receive invalid input from other sources. Shou=
ldn't the function always validate its input before array access?
>
> It depends on the overall design.
> Functions like strlen() also assume that you provide a valid string,
> so rtc_calc_weekday() can assume too that the passed rtc_time structure =
contains valid data.
>
> In doubt, let's fix both FAT and rtc_calc_weekday().

Other source locations where the content of struct rtc_time is not
(fully) validated before calling rtc_calc_weekday are

mc146818_get()
mk_date()

to name a few.

Other RTC drivers might also be placing garbage in a struct rtc_time, e.g.

omap_rtc_get()
m41t62_update_rtc_time()

Best regards

Heinrich

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F231E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 16:14:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D28F802B4;
	Thu, 19 Dec 2024 17:13:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=writeme.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=writeme.com header.i=sinan@writeme.com header.b="JfV2SaZy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A2A580196; Thu, 19 Dec 2024 17:13:57 +0100 (CET)
Received: from mout.gmx.com (mout.gmx.com [74.208.4.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 401878022B
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 17:13:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=writeme.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sinan@writeme.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=writeme.com;
 s=s1089575; t=1734624825; x=1735229625; i=sinan@writeme.com;
 bh=BRrs2EUFIcEYSHiJhRp4ffYRCbSZ/QzdCH0tjCLO2HI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=JfV2SaZyb2GhW0UPKq88ZLArki8seo/BrQUEDsj6hSK9MWoCrPIMoAiO4lHc4IAU
 qNqrdRhB1L2xIt3is68Ft1xeB0AzyIUvcH1+7L7POLnBt8Y6TuRdtdtZnvxISAJuN
 LRLFn9O9ycwxQw+qNnTnIHx4WVQ6Qz8Q6Qa3srsyZ5xRhkZzyScxJ3uumpaDxhIpB
 cg28RNPqDwvMwGWLg3umGE8/yiJJ3qze/EwAg/de8wKJZ8qqdJ07FK9OD1o6sVNvf
 3Qzdz+7FvaYO8GIxluCQuXwJuhXeCPfMClsusP/mpvRcBhixrjONNb8YzDA/f7Zdc
 qM7XGZObHdxOHm34yA==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [192.168.4.12] ([208.111.77.233]) by smtp.mail.com (mrgmxus003
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0MSLD3-1t0uLC10IN-00LkPb;
 Thu, 19 Dec 2024 17:13:45 +0100
Message-ID: <08d47536-b375-4524-bb2c-8ecfdeff8bbd@writeme.com>
Date: Thu, 19 Dec 2024 11:13:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] gpio: mpc8xxx: Preserve pre-init state of outputs
To: =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
 Sinan Akman <sinan@writeme.com>
Cc: Mario Six <mario.six@gdsys.cc>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20241215-mpc83xx-misc-v1-0-8cd6daae4f93@posteo.net>
 <20241215-mpc83xx-misc-v1-4-8cd6daae4f93@posteo.net>
 <30176d01-b244-47ac-82c9-8ee2b1f44a6b@writeme.com> <Z2Qac5yDvhhJV8Pu@probook>
Content-Language: en-US
From: Sinan Akman <sinan@writeme.com>
In-Reply-To: <Z2Qac5yDvhhJV8Pu@probook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HUOXSg8AzxGlLFIluHJHHQUjz00aPNg08wWESrQp6VbWtOBLh/V
 x3/l7eo5sqt+wMAI8yjqvh7V/JAI2xdkR2AeNqToBAjyOyjw7cmjjZovfbBk7RnSIFpZA8E
 r12lud+VX00D8astv+OI9MyD7uufWmLh6fPyCtm5VIhqML7wruYS7wDeYtOV4vHm+NsPzpe
 sGL5nyQMJWsxnMAsBGQ+A==
UI-OutboundReport: notjunk:1;M01:P0:TvXTVP5gi6o=;36ziiun4WsVJXp9rQU6upnWRzzX
 YmGrMSxSbgpwPvqWbABcDLo6RCAByX/qYyqyySmn7T4+0bJ03vA47v92o8WZhgesvLpZysEKh
 Euaj8QdeJjT84tljEHndWWT9bB7rqnYKFxyuMnPtct29QHKI+oJUKLCM92aNGgaAM7O0JQdNe
 CCw1sG7TvDhFPabrO3b9NyMT7sPXNYoVcOsmnRBQwhhpBEqEfP6e1VcMJ3ImFKr/ch0y/AMrD
 MpAve3kVjpPFrSl2ejUYwZwuRXvQukvthsltO/ogLgcbGepWGTziw8Uown/02o6SoCk7Fhvmk
 xLKDSpnyXh0uBt7l4h8uxsngZ9V8OoZAvHqRmYWBv9oLNuTAwm5MopWW6CLUqARb5rGnvKMm+
 0ssjeaLNOD8GBbLFSqpLAr4Od2DQQGnsrpG07y1W79kzR6E/m0U3XLFk6PEbnWe9DgD6/NfAV
 rPyFPpEEJHQLdOXicud5O3EIePa38obEcq+QaSWowuhwlm39bADEYH/cm9MazzcwlcwWSihRK
 ykWocD2iMkWR4HJvhvjPCoGL/LB3NxUKPAjuiFSBVb4KTy0y7/mgqTvCRaVeM98W7Wv+8VsP/
 +oIPPvNSVmsUVyIuWXQPZlZRnyji6jv3AfDWbHw1s6l/EbO9C5fdloFgialgnaheSBt3Q0s7W
 JsJZty3T5oehmKCZvvaA09lfLUaGUhGBb0mMBvKUdGB3wDLGtb0IHRX3JgVVLbFqvSKCYntIw
 YPcWLmuS/UKBgiPlB855Z6Trd2sqZlgPLFFCRQSXIcevcXQT5LCoZ8/S3xBllc6NLiDHURlyx
 RDexRiF27E2gNB9aMlWuJM5eGJ+yqxPmil056UA/iFtKsZvLDEXSkJ/GcDEtGHN5vGLLnwraW
 qUHwTOkbh3XZGqQYqpzLtcezdVG/F7ZsU69pW1hFi3ajXwl5DBBuiewVtAsHKHZ2XCJmKPMpr
 4cznqraETjlebml01ZlK8j8riRRQa5ZGYTqfMNk/xF+9yN+z3tkNFGarnSd6qxhfDpTiBijjw
 ZUCnhuPLe0y6yFS86wPXACkrsAogk/BQr2NBGJgVp/ZaSqLoOTts5iHVJAQvQRGJid80DpNB2
 Oh8hw0eD5gRqyCyIj/PrDqWqvxRBi15hk1BJgPnBV8JAVCZzVLb/emgVZe+N7WEEzwpVOhQJ0
 =
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

On 2024-12-19 08:06, J. Neusch=C3=A4fer wrote:
> On Wed, Dec 18, 2024 at 02:20:21PM -0500, Sinan Akman wrote:
>> Hi
>>
>> On 2024-12-15 10:18, J. Neusch=C3=A4fer via B4 Relay wrote:
>>> From: "J. Neusch=C3=A4fer"<j.ne@posteo.net>
>>>
>>> The mpc8xxx_gpio driver contains a workaround for certain chips
>>> where the previously written state of outputs cannot be read back
>>> from the GPIO data (GPDAT) register (MPC8572/MPC8536). This workaround
>>> consists of tracking the state of GPDAT in a "shadow register" (i.e. a
>>> software variable). The shadow register is initialized to zero.
>>>
>>> This results in a problem w.r.t. outputs that are configured to a
>>> high (1) state before U-Boot runs, but not touched by U-Boot itself:
>>> Due to the zero-initialization, these GPIOs end up being set to zero,
>>> the first time that any other output is set.
>>>
>>> To avoid such issues initialize the GPDAT shadow register to the value
>>> previously held by any outputs, if possible. On MPC8572/MPC8536 this
>>> should make no difference,
>>
>>  =C2=A0Did you test this on a MPC83xx board ?
>
> Yes, on MPC8314E. I'll mention it in the commit message.

yes please do, thanks.

Reviewed-by: Sinan Akman  <sinan@writeme.com>

>
> I did not test it on MPC85xx, though.
>
>
>   -- jn


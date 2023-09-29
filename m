Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C649E743F2
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 08:03:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8270A8652B;
	Fri, 29 Sep 2023 10:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Ellk9zTx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB9D286813; Fri, 29 Sep 2023 10:03:02 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E68558644E
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 10:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695974564; x=1696579364; i=xypron.glpk@gmx.de;
 bh=SAZNQxO/gOQl8+ekC21jllzW26XoPV4yNQjLH/GzfPE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Ellk9zTxWOACmDWE+N+FuE2SxIwui1ayI97FCWeICNeCY7RoDTZ+zgawqxjRKpc2VZRUiM4OOry
 jMlmZIwNuPPNMh5/Nz/CSS8vJpoKa6Z7cbliT/3Q5XntZba5S3drR1WWx1lromRNLy4wofplr4S/n
 5F9p82ddwexy1k/35CKwfO3z243tmCs58x3otyCBRWlwR7OpmijP9XKKnk1pE6lZHTnbqfh18hcps
 1/3SU0Aj0MOJQRlq2MHdHo8Y7+v0pe9lhB013PgNtkCErODyWFsX4SzUIY2nkSuT88BQ4reQdnZLg
 r9m8/+1YHo/1u1KrYu8fDpIXaRN2eyyeEePA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2V4J-1rmWs71MZb-013t5Z; Fri, 29
 Sep 2023 10:02:44 +0200
Message-ID: <9ec16f73-117c-42c8-bb97-fdfdecacfbc9@gmx.de>
Date: Fri, 29 Sep 2023 10:02:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spl: Jump to image at end of board_init_r
Content-Language: en-US
To: Ferass El Hafidi <vitali64pmemail@protonmail.com>
Cc: Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
References: <20230927214415.2224768-1-jonas@kwiboo.se>
 <b99750c4-973f-48f4-9c3b-166f0e5e832c@gmx.de>
 <CVV8MYJATGY1.17IBLLQ28R1YF@flaptop>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CVV8MYJATGY1.17IBLLQ28R1YF@flaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UrRkxPds+80f/sknQjWDTkYN4CBsTWmRslKvkNpGI0XW3x6tiAM
 lzYA/sCh2yFNxFooJWBZSWmyRPIE9uSCbid842xbkHtd37S7hc5q/5Yur5U+MKyvqP/JTr1
 leVLrSeDvWW9MemgGGSGeksYkrFIDCMjMcQ8R6oCkW4Y8aJTG3pj8BjpLxVekXZn9+ReGNf
 A83iaqE5nYsxVMChVHm4g==
UI-OutboundReport: notjunk:1;M01:P0:vj6YSv3WKl0=;SS+5YtbK2bikqQwVnO21g/k8ULu
 gaRwkN/K0VbO5KaT952iOK2sFG1E/bvpE5V02++mf28BWnXip9mBvlLFka8l1UXVKWB7Qt/4P
 jvY9eZGgP1Lt5EDPoj5fvqYBnVaW/MB7hhQk3GxHXnHxwVN+P6BNj+sLcn9lsY/I0zBk2dfV6
 SD7XK6p91PuYAstP76s1Hw8XmEgDM8xBqIsvUTx8JPpdQZU+wOojDjU1jgKTG58zrdF3E281Q
 Y+2WL+CZ5i5tbeN9jbtGVeDXNJvkrmHL/PE928FuisDQKVuUjbFkxA38N5JoIiSXsBx+Fv1GL
 1fYMgJz5iuCrcdbYWB5wggSV8aaQSu+IlWEb0jr8tbYUAKf0Xx0wdb4pOWjKmSQHS+k+1p+rE
 SDgMSezmjgjahn+oj0zC8EjQuhWLAoJIzc+ViVmf+EHGvpVSkpHXE2q7tI1E2h+iIhLF9jpGA
 tJN+8r9DHgM/vlxrZV7BrDoLa3Il54ZTYWj8cdWWPDZQujHuFdv04fTzT2VJu1mThwylNFU70
 h3OLsDr1kQr4pAoP5e0ypRzr0r+e7K/2V+QxcTWxERfOKq6RMKPCxRQzNFznP03ZWaD5rnzqt
 db780l284SlB078nxLcdFnyGZ75uXil134XeBr6I8DPhuSHlsfyb2+4maGvTppeeapvvBtSXJ
 IRa2TsXvOc4zNSEMO2DjaBBe3eMljBVV8MvWMT/cDSL/itpj3x+KX4o0+S8qY3WuPdx47YQix
 NLbN+N7Z5WSW6/EseL5na6o24wCXrqBYw2zoqlm5B86Eryw56i+iDROUEccsSDqLON00KmwNc
 CWmtHqKOK8RA/8zCDrH34cAL4/DtHECqMJRdzkzthfLKwsVOYdS/g40c0sFR1GQnzlLU57Z/2
 TPCrVMreOKyZzm8wJB4sY7JWa8JsMu5NkOYUPO1O0X9RtBXuESO6l1LdF0RFSCbhrtEaBBsoJ
 1vYWlMXytIJkxCSzKvTQXn3xqMM=
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

On 9/29/23 09:55, Ferass El Hafidi wrote:
> Hi Heinrich,
>
> On Fri Sep 29, 2023 at 2:57 AM CEST, Heinrich Schuchardt wrote:
>> In SPL we are fighting for every byte of binary size.
>>
>> What is the impact of this change on the code size?
>>
>> I would expect that your increasing it; especially if only one of the
>> CONFIG_OPTIONS is enabled.
>>
>> If so, NAK to this patch despite all elegance.
>
> Would you prefer removing `spl_board_prepare_for_boot()` instead?
> A handful of boards make use for it so I'd say this is a bug if it never
> gets ran on those.
>
> Or would it be better if it was enabled with a CONFIG_ option?

We should understand the implications of your patch on the code size. If
it leads to binary code growth, we should evaluate alternatives.

Best regards

Heinrich

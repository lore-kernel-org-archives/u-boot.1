Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35F9C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 11:40:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31C3C877DC;
	Tue, 12 Dec 2023 12:40:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ph5Meewo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3B20877D3; Tue, 12 Dec 2023 12:40:29 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB8B2877DE
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 12:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702381223; x=1702986023; i=xypron.glpk@gmx.de;
 bh=9emXFJAkHd3RV1Khc/dO8mKaIyvwPRqG+950sP7u+go=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
 In-Reply-To;
 b=ph5MeewoBwbkUAFTUoY4juZoIEjc9au0D7jwXcQ7oWgfltAWgIC9MunLW78Vbzxr
 RzNcsb3Gdg4uava/Cyy0s2KhFYVemZ8iYDz+hCoZMAXaQnYGotlJxP9RetTf7f+vk
 qon/2cvtkt3tdxCG2ipm7WbSyhZqCgXGzBBa1Lt3N84b+V+BRwOZgSTY/DS1+yAr9
 QB954Kg/Q0bixDmE68YLnilAVksQ8F0EH+1xzGaYVMQObzEyX4I9qbWIOQ7Z52bCk
 3LjzBsTpUyogcQF/WBBoAO2MqzWrWPPEFc6V4sUD46UVuppqFNJTpu9fiWs+5XG1+
 /XIFDjJVVGRTwRdCQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9Mtg-1rIdGt1CNw-015JjS; Tue, 12
 Dec 2023 12:40:23 +0100
Message-ID: <4f39df6f-2871-428e-8977-36a89b6cdc7c@gmx.de>
Date: Tue, 12 Dec 2023 12:40:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Enable setexpr command to print cpu-list like
 bitmaps
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: lukas.funke-oss@weidmueller.com
Cc: Simon Glass <sjg@chromium.org>, Lukas Funke
 <lukas.funke@weidmueller.com>, Bin Meng <bmeng.cn@gmail.com>,
 Roland Gaudig <roland.gaudig@weidmueller.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, u-boot@lists.denx.de
References: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
 <7e505616-9053-48f6-a282-c6ce8a09a531@gmx.de>
In-Reply-To: <7e505616-9053-48f6-a282-c6ce8a09a531@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PKyLfavxHeQ/H8JoPxfxUPbko2P8O+o0KWl1q73bbPZKDQBR0rS
 E2aGjIpuLfcKTnCTvaOvIXnjQK469M7dVKwvptbUSndZzUqBpgA9AxDN2L54LE6OrftY7LC
 icu/38N3+FJBbP5vdC0ktTbiJ9ZxKdkGXWm1fKRj+wkQyNpeJIoplgkyeHGMqXus/pvwgXc
 ENhA7uvJ16FmN3FkYAnJA==
UI-OutboundReport: notjunk:1;M01:P0:AUM/dwkhEsw=;7DtE545xtnyW7wi+9S19SkqNfai
 6vHucA53e8tJ7WtJdh5w5kguYTw5qfkKBJMCS8Y3oCsosuXZrHN870U+X/RM6gFsHi8LrVOl7
 pMUZmwjH+f3xi9GZenrwAQs0u4VEJRfr0JDpcxJh/5BO78vZnhfgkD7YFkoV8/iOXdZH24DRR
 TsYD5qJ/+KUpvv76f5zEND+gdcoxUMzuRwR/KuvaB8AYknyLbF/TE0EIBHJO6EzRpmJ9zwMmu
 3kkViN+ARG43Ezl7TvtJ680J4AYE22sVy9HozefWwF+44ATvsww2HSooRhVU1VDz4rsjUgsiy
 A8vp84Bu7AUZNWti7AFsqjRyj/U/0ygn9UuDcJJ3C2Klss1fQcwlBoB58hRyL12Wb6Wt+RG6w
 kVkApHO+DkvRprD91a3wQtqk2wgDJR483VkfsDv0qBo3WEiKT/zi9OzQRl6qv1aS/z3wTCRvl
 MvmNCU3SRz3rGYVD7EdWY+k8Hp5u6I78U9o1GrqQJb4MLQqElF/gmEzZNRL528XFQN/WnGUuZ
 1VVT08HxVXAwwJnymb8Xm1QHpZO1Cja+bHB+4YYk+x/DycICNEbYMW3DF/j+3iZ56r3lHS+/e
 2Rqz6cdilKcQDZILGki++Jl2whqRWimRnW+R4fZTJMIOciqmUM/uiEYicrfa7zqSx5Z4p4rCp
 sEFPL2Msjdp/qsqy5vDkdz2xw7OJmWf/GY+l5zmNbUjotQ7L1rRIkhxQciQnvCYch/mR0awbo
 8HhmYHXRWrbKL59oaUz5HRTb9ipVDrT9KyDLAiRNCp8yYdOME/92rlBZ8MiCut5XWLaqYrWN3
 OKBoYuhePqlSv1v8O2pyZGjlGEWoyUhVAyLZBWLAKHV3X46SdtxsQHtTn8TuUM0y4+HJ6C1rL
 O/uohnqo1jRB25dW6RjmaitJD2ortY1F7DqLTd/q9osx+ExuIx02Ya4mQmHUNSSN6AxxPG1Wq
 lhD/isAlx+U014kt+Z33a41MLIc=
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

On 12.12.23 11:13, Heinrich Schuchardt wrote:
> On 12.12.23 09:52, lukas.funke-oss@weidmueller.com wrote:
>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>
>>
>> This series enables the 'setexpr' command to print "cpu list"-like
>> bitmaps based on the printk format specifier [1].
>>
>> One use-case is to pass cpu list [2] based kernel parameter like
>> 'isolcpu', 'nohz_full', irq affinity or RCU related CPU parameter to
>> the kernel via a separate firmware variable without exposing the
>> 'bootargs' variable to directly.
>>
>> Example:
>>
>> setexpr isolcpu_bootarg=3D%32pbl $myCPUisolation
>
> I applied your patches on top of origin/next but your example simply
> does not work:
>
> =3D> setenv myCPUisolation 123456789abcdef0
> =3D> setexpr isolcpu_bootarg=3D%32pbl $myCPUisolation
> ## Error: illegal character '=3D'in variable name "isolcpu_bootarg=3D%32=
pbl"
>
> This produces some output:
>
> =3D> setexpr a fmt '%32pbl' 64; echo $a
> 6
>
> But the result is completely unexpected. Number arguments in U-Boot are
> always hexadecimal. So the output should be
>
> 2,5-6

doc/usage/cmd/setexpr.rst

has an example showing this.

     =3D> setexpr foo fmt 0x%08x 63
     =3D> echo $foo
     0x00000063
     =3D>

You provide a use case for %pbl but not an reason why you want to
support %pb. If you wanted to use the output in a device-tree
manipulation the %pb output would have to be big-endian formatted.

Best regards

Heinrcih

>
>> && env set bootargs "$isolcpu_bootarg"
>> && bootm
>>
>> [1] https://www.kernel.org/doc/Documentation/printk-formats.txt
>> [2]
>> https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.ht=
ml
>>
>>
>> Changes in v2:
>> - Add bitmap format specifier to documentation
>>
>> Lukas Funke (6):
>> =C2=A0=C2=A0 sandbox: add generic find_next_zero_bit implementation
>> =C2=A0=C2=A0 linux: bitmap.h: add 'for_each_set_bitrange' iteration mac=
ro
>> =C2=A0=C2=A0 test: cmd: setexptr: Add tests for bitmap string format
>> =C2=A0=C2=A0 doc: printf() codes: Add bitmap format specifier
>> =C2=A0=C2=A0 lib: vsprintf: enable '%*pb[l]' format specifier
>> =C2=A0=C2=A0 cmd: printf: forward '%p' format string specifier
>>
>> =C2=A0 arch/sandbox/include/asm/bitops.h | 16 ++++++-
>> =C2=A0 cmd/printf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 29 ++++++++++++
>> =C2=A0 doc/develop/printf.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++
>> =C2=A0 include/linux/bitmap.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +++
>> =C2=A0 lib/vsprintf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 75 ++=
+++++++++++++++++++++++++++++
>> =C2=A0 test/cmd/setexpr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++++
>> =C2=A0 6 files changed, 140 insertions(+), 2 deletions(-)
>>
>


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272ABC4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 13:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62765876CC;
	Tue, 12 Dec 2023 14:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tDqaUVZ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1511A8718A; Tue, 12 Dec 2023 14:09:50 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4231876CC
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 14:09:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702386583; x=1702991383; i=xypron.glpk@gmx.de;
 bh=vcCPWkmL3ZfcjwPgXRlH26BuiUrxaLE7s0DgJOvsSsw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=tDqaUVZ3/Lif4walUvMzWCWcpaUwQyZ777WsRbtOaEmdOM/fDb5fBxrMWFDuAWGa
 aWsitF+yddQJqvCadYDfYCBJCO1eLd12UgA8ZRFzUfgqHA6wOO9pQus4txtRWFWeH
 FSannnwW3Dnc+GD3dS/iysjEQpqEOSwvDFdchK9h3DTYuONyMcltKG6Lxum7Iexoh
 ofvMnxszUsJpzKOyRYAlJXhuqidXBbu7SQ9GWzedV7tUCiI7kdB4XcxXIJ0+8X0bm
 xrdOzv23Gnq1JsVKLflxh4TII6x4+nYQMUHm/0kMZuVk5NDDIYNOlvQJvFXXtWkW8
 cEniuET5KhPKpbJeLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2f9b-1rCl0C03bD-0047vm; Tue, 12
 Dec 2023 14:09:43 +0100
Message-ID: <06e44317-5907-4b64-bdbf-ebdefd199655@gmx.de>
Date: Tue, 12 Dec 2023 14:09:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Enable setexpr command to print cpu-list like
 bitmaps
Content-Language: en-US
To: Lukas Funke <lukas.funke-oss@weidmueller.com>
Cc: Simon Glass <sjg@chromium.org>, Lukas Funke
 <lukas.funke@weidmueller.com>, Bin Meng <bmeng.cn@gmail.com>,
 Roland Gaudig <roland.gaudig@weidmueller.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, u-boot@lists.denx.de
References: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
 <7e505616-9053-48f6-a282-c6ce8a09a531@gmx.de>
 <4f39df6f-2871-428e-8977-36a89b6cdc7c@gmx.de>
 <5f58d016-58d2-4e73-8fb3-503313f91496@weidmueller.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <5f58d016-58d2-4e73-8fb3-503313f91496@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sUqyNEOJbLyAXgoyCc7GxsFcEwWKgsETATXogUGghZGXDvBs3Ty
 b0mBazwM72QmINKPtYDScQpy/XmnP2HN6HoJwtMpeNIr+kT4HFr9iiuFombSL+/ybpN3QbR
 JY2orV/9V8ieNXhhWEivyxADRYOau0VQ8NkzMihc6YTqOb/9OZ+NIzNaWXuCLLNhtOMnsf3
 pSm22ZymtHSLUDimH04Zg==
UI-OutboundReport: notjunk:1;M01:P0:02CcT4m3C5U=;8bKhTYi15BndiyuNPkNFV19dBeU
 pD3z8pHFX+EgZXaENufb4XB3EgZUFI9HTb3YSyqObpXW2GVMgLVzV7ZsZkrG07jkYWRDQsBaK
 w+Wdes846zlpThza6fVvF/iu72f+xWW2eVV2EFQ6942AS0TpW0nqZBA5WjuhfI1B++hNiENI5
 a60515jFDTIqoCNHE2jLTs38zmEZztAUgVNvPSZRzguZZZ25L0EAGUJnSJ051uhaSrWhGsvly
 /U9UwBV85HbIO7Oft3JiqixQ9bWO3JOHhT2c+So0fRHJC3FneeIyRCUXMJxuVnFg9aqHc87v3
 TVMO5FOq5JAwmS0jMP0vbMHig6YSoNxNbWGRPET4xLWL8EjgKpWCakI//1B23er+SAAFnqGyF
 L587zhJ3rlpVMWr48UpskeM87cl10kMmHqvNL0BgFjIvR1UWdJPwI/266zo4i9EvCvxhxPubk
 LgGotz/eOgbJ/6ozEo+AE0u5a5v7L9ZTK6S+SiOi81yo1NeZbnk6rS5YfK8sHy2FR8oOQH4PL
 W5TGWyy1xNL+LrI7MMbCvcTldWsnpA/rbeQf6U3UzRlC2nIQyzGZjq3mNR7cr1/Yo4aKgnUrj
 MiMs5Qu0/HOX3FNwFFuNHIXDvRAyV+gcpbCNApyD1dUY28taTFMMTFwQzlaMOXsS92xNe6GR0
 rxuHRXIRUoc0F0TsWPxxKekDXuPctWXc1wAexIxE9VbW/ECN05n2djreedadV8WdA07hGDd03
 IYFydfaE+QbE8TT4xR5wHHn1WfJJZ1XEFvifCZGvJFY3xO0doE5gxZJItqQ2zcnqsRzB7mUH/
 +Hf9uPapewxmzP0pviaUXWUtwmI3HV5VqaTjdamqDJIMKtjb1bQhJ55Uu3rXfCH3jvDC1l1b8
 o1RBAv3hTsFiQ4Z4xxpMJNcKwqXaAqpInVKXi3S8eVVBBqSysNKe1gJ3eUXHPiNpxlENj236b
 Y+R21k/kx5xxOvlZcqgP3PyfaOU=
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

On 12.12.23 12:56, Lukas Funke wrote:
> On 12.12.2023 12:40, Heinrich Schuchardt wrote:
>> On 12.12.23 11:13, Heinrich Schuchardt wrote:
>>> On 12.12.23 09:52, lukas.funke-oss@weidmueller.com wrote:
>>>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>>>
>>>>
>>>> This series enables the 'setexpr' command to print "cpu list"-like
>>>> bitmaps based on the printk format specifier [1].
>>>>
>>>> One use-case is to pass cpu list [2] based kernel parameter like
>>>> 'isolcpu', 'nohz_full', irq affinity or RCU related CPU parameter to
>>>> the kernel via a separate firmware variable without exposing the
>>>> 'bootargs' variable to directly.
>>>>
>>>> Example:
>>>>
>>>> setexpr isolcpu_bootarg=3D%32pbl $myCPUisolation
>>>
>>> I applied your patches on top of origin/next but your example simply
>>> does not work:
>>>
>>> =3D> setenv myCPUisolation 123456789abcdef0
>>> =3D> setexpr isolcpu_bootarg=3D%32pbl $myCPUisolation
>>> ## Error: illegal character '=3D'in variable name "isolcpu_bootarg=3D%=
32pbl"
>>>
>>> This produces some output:
>>>
>>> =3D> setexpr a fmt '%32pbl' 64; echo $a
>>> 6
>>>
>>> But the result is completely unexpected. Number arguments in U-Boot ar=
e
>>> always hexadecimal. So the output should be
>>>
>>> 2,5-6
>>
>> doc/usage/cmd/setexpr.rst
>>
>> has an example showing this.
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 =3D> setexpr foo fmt 0x%08x 63
>> =C2=A0=C2=A0=C2=A0=C2=A0 =3D> echo $foo
>> =C2=A0=C2=A0=C2=A0=C2=A0 0x00000063
>> =C2=A0=C2=A0=C2=A0=C2=A0 =3D>
>>
>> You provide a use case for %pbl but not an reason why you want to
>> support %pb. If you wanted to use the output in a device-tree
>> manipulation the %pb output would have to be big-endian formatted.
>
> I added it to be consistent with the kernel printk. Currently there is
> no use case for it. Shall we remove the %pb or leave it in for consisten=
cy?

As long as we don't know if usage requires big-endian or little-endian I
would keep it out.

Looking at the %pbl use case: What sources of the value to convert do
you envision? When the argument is a pointer, e.g.

   setexpr a fmt '%128pbl' *$fdtcontroladdr

you seem to expect that the 32bit tuples are stored in low endian order.

Please, test the output of a 64bit number on a big-endian system. You
must not assume a unsigned long long to be stored as 32bit tuples in low
endian order here.

The output does not match what is in memory. This needs to be fixed:

=3D> setexpr a fmt '%128pbl' *0x8bae060; echo $a
64,66,69-72,74,76,79,82,85-87,89,91-92,94,96-98,108,110,112,114,117,119,12=
1,123,125,127
=3D> setexpr a fmt '%128pb' *0x8bae060; echo $a
feedf00d,deadbeef,00000000,00000000
=3D> mm.l 8bae060
08bae060: edfe0dd0 ?
08bae064: 92ac0000 ?
08bae068: 78000000 ?
08bae06c: 208a0000 ?

Here is another wrong output:

   =3D>  setexpr a fmt '%128pb' 0x92acd00dfeed; echo $a
   feedf00d,deadbeef,000092ac,d00dfeed

Expected output is

   00000000,00000000,000092ac,d00dfeed

A buffer overrun occurs. You are reading memory after the u64 value that
you create internally. To do it correctly you need to copy the u64 value
into a 128 bit buffer that has been zeroed out.

Best regards

Heinrich

>
> Best regards
> Lukas
>
>>
>> Best regards
>>
>> Heinrcih
>>
>>>
>>>> && env set bootargs "$isolcpu_bootarg"
>>>> && bootm
>>>>
>>>> [1] https://www.kernel.org/doc/Documentation/printk-formats.txt
>>>> [2]
>>>> https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.=
html
>>>>
>>>>
>>>> Changes in v2:
>>>> - Add bitmap format specifier to documentation
>>>>
>>>> Lukas Funke (6):
>>>> =C2=A0=C2=A0 sandbox: add generic find_next_zero_bit implementation
>>>> =C2=A0=C2=A0 linux: bitmap.h: add 'for_each_set_bitrange' iteration m=
acro
>>>> =C2=A0=C2=A0 test: cmd: setexptr: Add tests for bitmap string format
>>>> =C2=A0=C2=A0 doc: printf() codes: Add bitmap format specifier
>>>> =C2=A0=C2=A0 lib: vsprintf: enable '%*pb[l]' format specifier
>>>> =C2=A0=C2=A0 cmd: printf: forward '%p' format string specifier
>>>>
>>>> =C2=A0 arch/sandbox/include/asm/bitops.h | 16 ++++++-
>>>> =C2=A0 cmd/printf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 29 ++++++++++++
>>>> =C2=A0 doc/develop/printf.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++
>>>> =C2=A0 include/linux/bitmap.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +++
>>>> =C2=A0 lib/vsprintf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 75
>>>> +++++++++++++++++++++++++++++++
>>>> =C2=A0 test/cmd/setexpr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++++
>>>> =C2=A0 6 files changed, 140 insertions(+), 2 deletions(-)
>>>>
>>>
>>
>


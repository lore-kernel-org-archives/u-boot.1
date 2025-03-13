Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F664C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 15:30:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A1D780F9C;
	Thu, 13 Mar 2025 16:30:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="smCyB9SE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1AC280FF7; Thu, 13 Mar 2025 16:30:06 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45E2180540
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 16:30:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1741879783; x=1742484583; i=xypron.glpk@gmx.de;
 bh=ZrXozHv2W5M1yYNWYENnk50+6mPTKA0lh14PnvtvGJ8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=smCyB9SEAtq8K59tPkPkwh8L9GynUHtNAGuMUV9NCGpSprC6uq6ZMYmjUvgBfoqY
 ckxqZ7NZvIba90Lm7qH0UfyAhjSZUIJU2FreoivxCbF10ZAXJqN0Cvj2SuQXD0zC2
 nuldoCc1ga3G9ChTOjb/bFMDrp+z47bWnCdT3R05lY2iGw7V/bnjUKWJJCwsic1gC
 uRR7i/o7of1NDYDXxaHzfttEm596rtmxM7fM57v3yLS7GZjcUlMFe8jfbxUzw59xO
 wVFifQ5iq2Xi7C9J9AX5VoQ1WYhMKAWO5wnP8jUpncp6DeqVq7vsnVJITnKPmbqqS
 2qEO2q/4tXx+qEZg2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N49lD-1tAmgQ2FFJ-016smf; Thu, 13
 Mar 2025 16:29:43 +0100
Message-ID: <7bee2059-2378-4d5f-a2db-ea46fd6badef@gmx.de>
Date: Thu, 13 Mar 2025 16:29:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] fs: exfat: Fix conversion overflow errors
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20250308201533.1315951-1-marex@denx.de>
 <20250308201533.1315951-9-marex@denx.de>
 <393a7b06-402a-48b0-8ed4-5dcaa7ab9383@cherry.de>
 <a7b192b6-48b8-4878-a6dd-563dbb9bdb06@denx.de>
 <20250310214904.GO2640854@bill-the-cat>
 <e8cba3ce-d9a8-4bf0-8a98-dc1b8f8f49a3@denx.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <e8cba3ce-d9a8-4bf0-8a98-dc1b8f8f49a3@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iI89vGbhIuxIoljBkPWSYVMlScyUoMql20w/60HqSs/D/WI5JQN
 tTgnt0gxUnZwSCx6HuG901l7vNh1eYTySEB7GDDaY6axeErFmJGLGpDZ40bdyBzbEe5wHgA
 uZbwFeR8nW3L0bt+iQdtVkljt1Kd7SlGS6NKpb2SxYAodbke3Js+V5tnAwDbMbMyMcElZeX
 7dKIEXGUyUTeVCsIjeonA==
UI-OutboundReport: notjunk:1;M01:P0:x0J4klkLDOc=;aJbYkeSpHmZzbNPZz+pT5kPdja+
 fDQAqePvGDbBDny/TVTDV5ZihJ4sgEcpCoiloTCOcl0a9Ff8KsVHG5A3Ye8jSAt+d0jKBzvuw
 O1kK7qVkWlSArtpN2r+oeVcuYMO7vG4Es4jvVpauWuLbq7IzfXAbP8wss5qDi1G33BhiCEaCQ
 0CLy1fOuf3MqMqJCGbshm/VSb20vf35QvNmddn90e8YPfz7HrieLsXDRLScJK7lKg8vQEE3VZ
 wd5l5QRh7JSIZwmND9KqOx/AueThz6JL+kOVuJrmvhfEh4Lzq9GEsLzTLkIuhHrr96fpC0zSI
 XnfMo1SLTQdyrE46GgV91hQ8pQpbkF5I+fOo171u/nWKCF57cf31Pvl9uWiSGqqej6JvkAtgI
 BZ8wi9XJhfz8zPRXLKxbOIUzp1O7Goc0dAW+vNKIg/tziw2ICzJ5qAYNPmMaeuCazUF/t7LvI
 btogz6GezD/0WfNcYXT8Pe8fLRbxCkoGb3WIB8lrIcTGsHv9uKFtMBX8ondBtKSC6QtY+BZls
 IJawk1pw6KyAi7Z10H4+DnLh37G2124FnSUJjkkmWE5W+tdWYUopOnr0zci3N+KQFvNgdQdif
 KZ84k200wv2h9k8CYHFOnfCzSiYPuNWRDCI8PYfann9RT1hSy0sM0txiw91XpqzPcY++rRm/a
 NAvsEJ7Ujem8ujWDFp5XkKv4IHJAVKQBiAYxV3rvUVwbvVSwuaMnPnn2Eu6kdHc/hqTQXDa9T
 3/nIh4EFAOLktFKYIBBldeTo0Z+o/CnFXGt6zoqdcRqo66hie1Sdvgg4/Az4vW0IziLiZtGDX
 s5C+MsCrs5PHW+BWPyS5aYYTpAwzE/GrZk5o457zR2Ze7HkceC8wgdpyBg87rYXI1sSdO4sBK
 08O8G+NuHOa4Mo6JwuXcZPnMxIDmLWKns2x+Zdb1YAPUTLZhMTGb7Za6F7O4PnvR7heY2lS23
 uEb2uu0EEOO3DuS7t4fw7vKyCjyORvaWkwwKQTBN1NP91rA+S2yylCTk2FhR3ihjCkt2y6FZF
 o0ENauPrrf55Znp1IaKAHkb2pf9SsgfuJIMPgSx7aaXnAo24PpdVOroownJxZlh1Lb42/bH0T
 qeFE08dzYmv3Mh/Kx1uFwgfJHlDdqUOF14FNpKzlyXEkI/u0DDu1oLzYyOV0eZHGKd4AbTwEh
 08ccfk9QHAiw/lI0zB2FP/sFWHGm60RYBE3UQnTTMq0QU7YIst9Yr9fCFMQH4dG/FZyHno8/G
 4LsxWf1u8KTDU7fx0O+gcJh++BE+eh16Dabr7D4LfZnWcu+KmM9Qloz434854TTeRZl8/JiGL
 te1wCHRBsmPtwYYt6ZMDjXCaE1PQvNUnaQeXU44cWzwkNNFxylC78pqGxrwaiTMiJOUHdU1lA
 eOcg5LQfjONuQDzoy42f1d2cwFum5lmd/74Kl8ZFLE9+d11AKlyRT3wB9LyjNbkgpqqqHljJH
 sVIuIVW9h/EFG5nhNPb0xT/baESo=
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

On 11.03.25 00:33, Marek Vasut wrote:
> On 3/10/25 10:49 PM, Tom Rini wrote:
>> On Mon, Mar 10, 2025 at 10:03:37PM +0100, Marek Vasut wrote:
>>> On 3/10/25 12:17 PM, Quentin Schulz wrote:
>>>> Hi Marek,
>>>
>>> Hi,
>>>
>>>> On 3/8/25 9:12 PM, Marek Vasut wrote:
>>>>> Fix the following conversion overflow errors. The input field is
>>>>> already
>>>>> limited to 3/2/1 bits using the bitwise and, move the parenthesis
>>>>> around
>>>>> to avoid the bogus warning:
>>>>>
>>>>> "
>>>>> fs/exfat/utf.c: In function =E2=80=98utf8_to_wchar=E2=80=99:
>>>>> fs/exfat/utf.c:165:23: warning: overflow in conversion from =E2=80=
=98int=E2=80=99 to
>>>>> =E2=80=98wchar_t=E2=80=99 {aka =E2=80=98short unsigned int=E2=80=99}=
 changes value from =E2=80=98(int)(short
>>>>> unsigned int)*input << 18 & 1835008=E2=80=99 to =E2=80=980=E2=80=99 =
[-Woverflow]
>>>>> =C2=A0=C2=A0=C2=A0 165 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *wc =3D ((wchar_t) =
input[0] & 0x07) << 18;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>>>>> fs/exfat/utf.c:170:23: warning: overflow in conversion from =E2=80=
=98int=E2=80=99 to
>>>>> =E2=80=98wchar_t=E2=80=99 {aka =E2=80=98short unsigned int=E2=80=99}=
 changes value from =E2=80=98(int)(short
>>>>> unsigned int)*input << 24 & 50331648=E2=80=99 to =E2=80=980=E2=80=99=
 [-Woverflow]
>>>>> =C2=A0=C2=A0=C2=A0 170 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *wc =3D ((wchar_t) =
input[0] & 0x03) << 24;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>>>>> fs/exfat/utf.c:175:23: warning: overflow in conversion from =E2=80=
=98int=E2=80=99 to
>>>>> =E2=80=98wchar_t=E2=80=99 {aka =E2=80=98short unsigned int=E2=80=99}=
 changes value from =E2=80=98(int)(short
>>>>> unsigned int)*input << 30 & 1073741824=E2=80=99 to =E2=80=980=E2=80=
=99 [-Woverflow]
>>>>> =C2=A0=C2=A0=C2=A0 175 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *wc =3D ((wchar_t) =
input[0] & 0x01) << 30;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>>>>> "
>>>>>
>>>>
>>>> Since this doesn't seem to be U-Boot-specific, any chance to open a
>>>> Pull
>>>> Request on the project so we may be able to not carry this patch when
>>>> upgrading (yes, the last commit in the branch was two years ago, but =
it
>>>> seems the maintainer is still active on issues).
>>>>
>>>> Considering that wchar_t is an unsigned short int and that USHRT_MAX =
is
>>>> 0xffff (so 2B or 16b)...
>>> In fact, this error does not even appear in upstream , because
>>> upstream does
>>> not use -fshort-wchar compiler flag . U-Boot does use this compiler
>>> flags
>>> since 4a85663ec7ed ("kbuild: Enable -fshort-wchar") .
>>>
>>> So I wonder if this might be the right fix here instead:
>>>
>>> diff --git a/fs/exfat/Makefile b/fs/exfat/Makefile
>>> index 550c0683d65..8ca112cf0e9 100644
>>> --- a/fs/exfat/Makefile
>>> +++ b/fs/exfat/Makefile
>>> @@ -1,6 +1,9 @@
>>> =C2=A0 # SPDX-License-Identifier: GPL-2.0+
>>> =C2=A0 #
>>>
>>> +# The utf.o does really need 32bit wchar_t
>>> +CFLAGS_REMOVE_utf.o :=3D -fshort-wchar
>>> +
>>> =C2=A0 obj-$(CONFIG_FS_EXFAT) +=3D \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cluster.o \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io.o \
>>
>> Your initial approach is right I think, I'm not sure it's a good idea
>> to mix and match that flag throughout the codebase.
>
> The -fshort-wchar is needed only because of EFI , so I wonder if we
> should somehow isolate the EFI code which needs this stuff instead, and
> drop the flag throughout the codebase instead ? Heinrich ?
>
> Or maybe EFI should switch to something else that is not wchar_t , so
> other users can use wchar_t unrestricted ?

We already changed all L"" strings to u"".

But the compiler complains about printf("%ls\n", (u16 *)buf); without
-fshort-wchar.

So we cannot do without the flag.

In fs/exfat/Makefile you should be able to disable the flag with
CFLAGS_REMOVE_* and AFLAGS_REMOVE_*

Best regards

Heinrich

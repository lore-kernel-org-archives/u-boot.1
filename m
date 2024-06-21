Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBDDC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 13:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 863E48845A;
	Fri, 21 Jun 2024 15:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VwTK6j2f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 308C68834D; Fri, 21 Jun 2024 15:16:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A051D87FBC
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 15:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718975798; x=1719580598; i=xypron.glpk@gmx.de;
 bh=8ss6sNycVkxuzUVWcoiLXxc9qIxSssIziNEksw7Ka5o=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=VwTK6j2fBqQ3vRmZ949epe8Fvvgia8WS6TgAjhussiFomKgFBnR59GJI200GtIN/
 v12Fh8ksVQToHJfY+BUMshfj5SQ1NAjvLjuUgVttHF1uBAjotAcMuT1lGdGjWaFRz
 aOGzjndV8quY4DNae6iZymr32QuNjsZpzJ0l6FzlUUZuqi1W9NZ86AKey24vw00a3
 ijU2b+5Y1Py+1F8Q4VR9MnbAjd2DtTUmXp1kJdBjIsYDf5ZFQfbQKwAu20eLnmZzH
 6Qw8pQubDkcxo/AI+ZICydh5G9pbSBBDFyw6rXesnfQA8Hxc2eVoko5xlSByZKf3e
 mxho8nESn8KScwR01w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHXFr-1s77SR2KSf-00FLo8; Fri, 21
 Jun 2024 15:16:38 +0200
Message-ID: <129e9ff8-0d25-4f01-b357-bf9c5b84e675@gmx.de>
Date: Fri, 21 Jun 2024 15:16:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] efi: CapsuleUpdate: support for dynamic UUIDs
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <ZnLk_pXstP2dlRGo@debian>
 <CAC_iWjL_rytosTAcsW2-3fmwVhjTgkMRAB0LwPuNpq73K=YmcQ@mail.gmail.com>
 <ZnVEALsxt2b9s-cI@debian>
 <CAC_iWjJp6wVqDhW_kJ0Pd77Y+NpbuzoOOYqiQX5Gna2TXRN0Gg@mail.gmail.com>
 <CAC_iWjL-HN21rrravFukfDm03UeJjSvnfSRD1-Cm=cJJxXzTug@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjL-HN21rrravFukfDm03UeJjSvnfSRD1-Cm=cJJxXzTug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d65wCT29Ft3bbWltkGJGP7hHSpLkGiYSRsu/6tHJJxx29/MRNUv
 wYM3ulmGufnGO5cqVc6zCbUpXgSj/seAmYaLll/9VRE7S+uWig/u3LpECuiSQQl/Mx3gNZE
 0Bzcqu8J2pHxWI5dokLzeq+RtcGClcT7R+9+cBg+1Lt0JHnBjy+uvJxpT/N7mAPIWKzfeti
 nE9MaR4jWLw5pIlpw/UwA==
UI-OutboundReport: notjunk:1;M01:P0:OlG45bKmr8g=;p9GRii4k/3uL4B75Ig9EHEcSkeX
 q7kW04Z+cHGBTIbuBoGBrJwiHGoD4w7kRP9B1IRDkcxA00GLsq8QIkz0loOwQkZ7OSMSqOI6U
 nroGogQUdDZNWuxSsmYZXUz4vXhTuUTAAMWvsqwHAUmK/zz+Z64o7ANiIu7ji1Fbng/CFjdiP
 esKhnGSGi65HHbxau1O0CTBsvd4HI365P9EYYp6SKvAyzEq5xCJcO0ahY4mzuYj2mND6IYRqK
 TUna19mhrbNLljkZ6ab2bJ2B6r554Y0FZlkD/Mng8mPoxnghq9Jsh8pjo3un2Q2QWA+ribASZ
 yXqykXlJnD+f7ER0ueePl3aJran82Py+AW1TTCnKDO1nugAf7s7EooFjagSffEsgdKSPyvDKN
 tPJRPzqlXlTnjjIJ5FZPrY7VhYEiDtIQUaa94FeVqtVRe89XUmSYiruQwJjmbXG4PBRSqWsJQ
 YC194X7zFlI474k4durxCMVBoPIYPc2wOXqfojZb0XmASmQJbtx4NivMIlECBGg03iy/8DjHy
 Zf4wevmPQRJI1sw+NEX5j51hZlL94ea94z7Ws6jZo5bDNehvPLOl3TSOnr+Jx90UXz9LXnzhQ
 bLdsoT4ch/hK1xwc0WgdsC4Y67zfYmcDZGxzJjMzSS5kXDryJFnFyx1asqKWQU81uSy0f53CQ
 Gt1YT7d92+2QRAjyCw0k1l7gbyWHOTshweRojNiNgOeLgAE0CQoILWRwCgWkDahWPvABdh9dI
 h51mOkxQK9VuDTTtPQf4wbQXcBiLtRYxgTmoOM7fjj1jweICODD/GHWr818KUEpOkTfZBwvhy
 g5M5/6nAKvuXkZY7BBX7EYG+Ofk8XWzwI3qZPMYiW7BDY=
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

On 21.06.24 13:25, Ilias Apalodimas wrote:
> On Fri, 21 Jun 2024 at 14:01, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Vincent,
>>
>> [...]
>>
>>>>>    $ uuid -d 935FE837-FAC8-4394-C008-737D8852C60D
>>>>>    encode: STR:     935fe837-fac8-4394-c008-737d8852c60d
>>>>>            SIV:     195894493536133784175416063449172723213
>>>>>    decode: variant: reserved (Microsoft GUID)
>>>>>            version: 4 (random data based)
>>>>>            content: 93:5F:E8:37:FA:C8:03:94:00:08:73:7D:88:52:C6:0D
>>>>>                     (no semantics: random data only)
>>>>>
>>>>> A reserved Microsoft GUID variant does not look right.
>>>>
>>>> This seems like an existing bug. RFC4122 defines the MS reserved GUID=
s
>>>> in the variant as
>>>> 1     1     0    Reserved, Microsoft Corporation backward
>>>> compatibility and the existing UUID_VARIANT_MASK is defined as 0xc0..=
.
>>>
>>> I think the variant mask 0xc0 is correct:
>>>
>>> - The variant field is in the top three bits of the "clock seq high an=
d
>>>    reserved" byte, but...
>>> - The variant we want is 1 0 x (do not care for bit 5, a.k.a. "Msb2").
>>>
>>> With the mask 0xc0 we can clear the top two bits as we set the top mos=
t bit just
>>> after anyway.
>>>
>>> ...the mask needs to be used correctly, though; see below.
>>
>> Ah yes, the current code is using it in clrsetbits_8, which inverts it
>> internally, so it's indeed correct.
>>
>>>
>>>>
>>>> The patch below should work for you (on top of Calebs')
>>>>
>>>> diff --git a/include/uuid.h b/include/uuid.h
>>>> index b38b20d957ef..78ed5839d2d6 100644
>>>> --- a/include/uuid.h
>>>> +++ b/include/uuid.h
>>>> @@ -81,7 +81,7 @@ struct uuid {
>>>>   #define UUID_VERSION_SHIFT     12
>>>>   #define UUID_VERSION           0x4
>>>>
>>>> -#define UUID_VARIANT_MASK      0xc0
>>>> +#define UUID_VARIANT_MASK      0xb0
>>>>   #define UUID_VARIANT_SHIFT     7
>>>>   #define UUID_VARIANT           0x1
>>>>
>>>> diff --git a/lib/uuid.c b/lib/uuid.c
>>>> index 89911b06ccc0..73251eaa397e 100644
>>>> --- a/lib/uuid.c
>>>> +++ b/lib/uuid.c
>>>> @@ -411,9 +411,9 @@ void gen_uuid_v5(const struct uuid *namespace,
>>>> struct uuid *uuid, ...)
>>>>          memcpy(uuid, hash, sizeof(*uuid));
>>>>
>>>>          /* Configure variant/version bits */
>>>> -       tmp =3D be32_to_cpu(uuid->time_hi_and_version);
>>>> +       tmp =3D uuid->time_hi_and_version;
>>>
>>> Not caring for the endianness at all does not look right.
>>> Indeed, while this does work on my side in little-endian, this does no=
t work on
>>> on big-endian simulators.
>>
>> Yes, we need the conversions
>>
>>> Also, this is a 16b quantity, not 32b; we need to redefine tmp to uint=
16_t and
>>> use the be16 functions.
>>>
>>
>> Yep I already pointed that out earlier.
>>
>>>>          tmp =3D (tmp & ~UUID_VERSION_MASK) | (5 << UUID_VERSION_SHIF=
T);
>>>> -       uuid->time_hi_and_version =3D cpu_to_be32(tmp);
>>>> +       uuid->time_hi_and_version =3D tmp;
>>>>
>>>>          uuid->clock_seq_hi_and_reserved &=3D UUID_VARIANT_MASK;
>>>
>>> We need to mask with ~UUID_VARIANT_MASK, I think.
>>>
>>>>          uuid->clock_seq_hi_and_reserved |=3D UUID_VARIANT << UUID_VA=
RIANT_SHIFT;
>>>>
>>>> Can you give it a shot?
>>>
>>> This does indeed work on my little-endian machines, but not on big-end=
ian
>>> simulators.
>>> For testing on big-endian, I suggest using only genguid as the sandbox=
 will not
>>> help there:
>>>
>>>    $ make sandbox_defconfig
>>>    $ make tools-only
>>>    $ ./tools/genguid 2a5aa852-b856-4d97-baa9-5c5f4421551f \
>>>          -c "qcom,qrb4210-rb2" \
>>>          QUALCOMM-UBOOT
>>>
>>> ...and feed the resulting UUID to `uuid -d'.
>>> (The genguid command is the online help example.)
>>>
>>>> What I am afraid of is breaking existing use cases using a different
>>>> variant mask....
>>>> If that's the case we might need to keep the buggy existing
>>>> UUID_VARIANT_MASK and use the new one only on v5 and newer code
>>>
>>> I tried to debug further and I suspect that:
>>>
>>> - Operations on 8b clock_seq_hi_and_reserved might need further casts.
>>>
>>> - My understanding is that we are generating the v5 UUID as big-endian=
 in
>>>    memory; if this is indeed the case, genguid should not print it wit=
h the GUID
>>>    byte order.
>>
>> RFC4122 says that
>> "put name space ID in network byte order so it hashes the same no
>> matter what endian machine we're on "
>> the EFI spec says
>> "It should also be noted that TimeLow, TimeMid, TimeHighAndVersion
>> =EF=AC=81elds in the EFI are encoded as little endian. The following ta=
ble
>> de=EF=AC=81nes the format of an EFI GUID (128 bits)."
>>
>> Which is lovely....
>>
>
> But this brings up something that Heinrich also mentioned. Since the
> efi spec and RFC4122 interpret the endianess differently, how do you
> expect uuid -d to work?

The binary format does depend on endianness:

$ echo -n -e
"\\xF8\\x1D\\x4F\\xAE\\x7D\\xEC\\x51\\xD0\\xA7\\x65\\x00\\xA0\\xC9\\x1E\\x=
6B\\xF6"
\
 > | uuid -d -F BIN -
encode: STR:     f81d4fae-7dec-51d0-a765-00a0c91e6bf6
         SIV:     329800735698586931527096882168799849462
decode: variant: DCE 1.1, ISO/IEC 11578:1996
         version: 5 (name based, SHA-1)
         content: F8:1D:4F:AE:7D:EC:01:D0:27:65:00:A0:C9:1E:6B:F6
                  (not decipherable: truncated SHA-1 message digest only)

Best regards

Heinrich

>
> Thanks
> /Ilias
>> I'll send a patch with the changes
>>
>> Regards
>> /Ilias
>>>
>>> For the moment I am unable to make the code work in all the following =
cases:
>>>
>>> - genguid on little-endian
>>> - genguid on big-endian
>>> - sandbox ESRT on little-endian
>>>
>>> I will let you and Caleb know if I make any progress.
>>>
>>> Best regards,
>>> Vincent.
>>>
>>>>
>>>> Thanks
>>>> /Ilias


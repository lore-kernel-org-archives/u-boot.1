Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003D1C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 11:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 009FF880A3;
	Fri, 21 Jun 2024 13:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="FI4Cd3uz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28E7B8815E; Fri, 21 Jun 2024 13:01:01 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0976388013
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 13:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718967656; x=1719572456; i=xypron.glpk@gmx.de;
 bh=csiNWgtU3AwDDhah7C9DgQggrW37mNqyuvfDpwq0EBc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=FI4Cd3uz/J3ncAJpN1qwCKqciQGfAs5QlePKufDgIMxHLr5eh+p5hiR8o76F/vtp
 cAvXXCfMXrFhXCnRTTk4hAhIg6ii2T8Ajrn7BIlrBqovPWtO5ncj/cxKzDXgZJunY
 VFQlxNke9GFz1pS4iWi/CJorBQgNHudvNlJF+fdRPqPBihQkktqs4Rn/Xz+DzwCCt
 3u9TlNzW4QNQj0SWJ+rFKmTs2fKOFFVyM3XLkEiY8rP0ydS3swEbjLFd2CCGj7f0I
 gdqwtwtA9IaKOqaeuwunzT6QKdQGihRuGeyzyQs4X30tIuyv4YCvbMT71Kuvs7eOI
 5ilvMg/IIDIr23IlNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1ML9yc-1s3Uph3az4-00YJzg; Fri, 21
 Jun 2024 13:00:55 +0200
Message-ID: <b2f16a9c-e916-4fbc-9f9c-87b23c0277a5@gmx.de>
Date: Fri, 21 Jun 2024 13:00:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] efi: CapsuleUpdate: support for dynamic UUIDs
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <Vincent.Stehle@arm.com>
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <ZnLk_pXstP2dlRGo@debian>
 <CAC_iWjL_rytosTAcsW2-3fmwVhjTgkMRAB0LwPuNpq73K=YmcQ@mail.gmail.com>
 <ZnVEALsxt2b9s-cI@debian>
Content-Language: en-US
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <ZnVEALsxt2b9s-cI@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:06vGso9NOZoqNTviCC2a1QYJOGa+fysf7MZBIGr2HOtsuZfsuds
 MK8CEgzXbj43uCw6QF7499C69S+cRySkl2SlR9GXNzFawpuXIMBeT/+e3RCQh9q5nQDKwqQ
 X0zzHqmcyDVZa9/nuEVrb5d5NA6mHU4saOwtmN1KSRTxiGLiKXOcCFtbeZtr0YPEVP7mnLe
 h9oIdVGWX5sKtL4JL9vQg==
UI-OutboundReport: notjunk:1;M01:P0:cJXsMEAbp2M=;pTbEsIIrwNMRBdLIt+Y2rux8Sq2
 /0JJ6MHfCxRdqBqFJbuLCrLKpHAfgG4nK7a9hzyFrY6bBqldULZ2kkNQ81zexKr4tR0rKu1cZ
 6XkfTmo9np6AhzRoIvJVosIQJwncSiHgXG30iPI4sx4hzHJVnkErbkvg1R6bQRtfiYZJZKr80
 8wdogu8eoHTaX97NYNqvCwQodzDoUPPb9SfbEvrPhznouwvF/NYkppic3GJRJNnG3OdZBHqzk
 DGgti7Ylx2CRqhIiHjKYQ/Ol/mbhIYp3RIUb807mpiuYa/6XaUeOHvjkU8fAglF1oVeQ8WHk2
 9yQloYfrDw2Jx9WQiBwhhKNAjXLwaOMobmlrxGtZ0ANL2S1yQQXjLBtRollR+8YU6UTz7GR+T
 N0FV0mwcM/8j3OqG5vRnA8CBcCRh0GypP3YT8qpEcvXkdexflupWPFqWZLhVfHBoT1yrjfy7v
 v/qn/IZp8yA5y7/X7Go+6gwO21sXtr2DyAOoH3gs/Q2sknci0lDS+pAM9iVfl/CYhmVhJcz72
 +rFX2+NR4F8lfjyPrWwd6R/OciXNUjGGD8uHyZgwybT8P6fRoyhUlUQ9+74w4YdX/qZYhZza8
 H/TQTSw5CfBlvuhMFG+Q7XgJk+TBYyEV7VSr6iJYwPmsDdZ92Tlh1QEDO/MoOIIpafKtjHcq4
 k33IdjMAFXtmIoWSKo6EjMJCvSrxUwQkAGjtDglgXQikrYUT9t5YnujAa9jWZIJNLVqavb4U/
 cdjvlbfE1+hOjL/aNlpthnQT4dq8Xq55uu9hzxf/fWx7UHXgBZSkSg271ls+NccwKhdLKxzxZ
 yYEa6SFU6Jh0aMwSuZMYnY4FkgIVQN1P5IRRtMqtFSA90=
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

On 21.06.24 11:12, Vincent Stehl=C3=A9 wrote:
> On Wed, Jun 19, 2024 at 10:15:32PM +0300, Ilias Apalodimas wrote:
>> All=C3=B4 Vincent,
>
> Hi Ilias :)
>
>>
>> Thanks for testing!
>>
>> On Wed, 19 Jun 2024 at 17:02, Vincent Stehl=C3=A9 <vincent.stehle@arm.c=
om> wrote:
>>>
>>> On Fri, May 31, 2024 at 03:50:34PM +0200, Caleb Connolly wrote:
>>>> As more boards adopt support for the EFI CapsuleUpdate mechanism, the=
re
>>>> is a growing issue of being able to target updates to them properly. =
The
>>>> current mechanism of hardcoding UUIDs for each board at compile time =
is
>>>> unsustainable, and maintaining lists of GUIDs is similarly cumbersome=
.
>>>>
>>>> In this series, I propose that we adopt v5 GUIDs, these are generated
>>>> by using a well-known salt GUID as well as board specific information
>>>> (like the model/revision), these are hashed together and the result i=
s
>>>> truncated to form a new UUID.
>>>
>>> Dear Caleb,
>>>
>>> Thank you for working on this proposal, this looks very useful.
>>> Indeed, we found out during SystemReady certifications that it is easy=
 for
>>> unique ids to be inadvertently re-used, making them thus non-unique.
>>>
>>> I have a doubt regarding the format of the generated UUIDs, which end =
up in the
>>> ESRT, though.
>>>
>>> Here is a quick experiment on the sandbox booting with a DTB using the=
 efidebug
>>> command.
>>>
>>> With the patch series, rebased on the master branch:
>>>
>>>    $ make sandbox_defconfig
>>>    $ make
>>>    $ ./u-boot --default_fdt
>>>    ...
>>>    U-Boot 2024.07-rc4-00028-g1c96225b0b3 (Jun 19 2024 - 15:29:04 +0200=
)
>>>    ...
>>>    Model: sandbox
>>>    ...
>>>    Hit any key to stop autoboot:  0
>>>    =3D> efidebug capsule esrt
>>>    ...
>>>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>    ESRT: fw_resource_count=3D2
>>>    ESRT: fw_resource_count_max=3D2
>>>    ESRT: fw_resource_version=3D1
>>>    [entry 0]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>    ESRT: fw_class=3DFD5DB83C-12F3-A46B-80A9-E3007C7FF56E
>>>    ...
>>>    [entry 1]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>    ESRT: fw_class=3D935FE837-FAC8-4394-C008-737D8852C60D
>>>    ...
>>>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>>    $ uuid -d FD5DB83C-12F3-A46B-80A9-E3007C7FF56E
>>>    encode: STR:     fd5db83c-12f3-a46b-80a9-e3007c7ff56e
>>>            SIV:     336781303264349553179461347850802165102
>>>    decode: variant: DCE 1.1, ISO/IEC 11578:1996
>>>            version: 10 (unknown)
>>>            content: FD:5D:B8:3C:12:F3:04:6B:00:A9:E3:00:7C:7F:F5:6E
>>>                     (not decipherable: unknown UUID version)
>>>
>>> Version 10 does not look right.
>>
>> So, this seems to be an endianess problem.
>> Looking at RFC4122 only the space ID needs to be in BE.
>>
>>>
>>>    $ uuid -d 935FE837-FAC8-4394-C008-737D8852C60D
>>>    encode: STR:     935fe837-fac8-4394-c008-737d8852c60d
>>>            SIV:     195894493536133784175416063449172723213
>>>    decode: variant: reserved (Microsoft GUID)
>>>            version: 4 (random data based)
>>>            content: 93:5F:E8:37:FA:C8:03:94:00:08:73:7D:88:52:C6:0D
>>>                     (no semantics: random data only)
>>>
>>> A reserved Microsoft GUID variant does not look right.
>>
>> This seems like an existing bug. RFC4122 defines the MS reserved GUIDs
>> in the variant as
>> 1     1     0    Reserved, Microsoft Corporation backward
>> compatibility and the existing UUID_VARIANT_MASK is defined as 0xc0...
>
> I think the variant mask 0xc0 is correct:
>
> - The variant field is in the top three bits of the "clock seq high and
>    reserved" byte, but...
> - The variant we want is 1 0 x (do not care for bit 5, a.k.a. "Msb2").
>
> With the mask 0xc0 we can clear the top two bits as we set the top most =
bit just
> after anyway.
>
> ...the mask needs to be used correctly, though; see below.
>
>>
>> The patch below should work for you (on top of Calebs')
>>
>> diff --git a/include/uuid.h b/include/uuid.h
>> index b38b20d957ef..78ed5839d2d6 100644
>> --- a/include/uuid.h
>> +++ b/include/uuid.h
>> @@ -81,7 +81,7 @@ struct uuid {
>>   #define UUID_VERSION_SHIFT     12
>>   #define UUID_VERSION           0x4
>>
>> -#define UUID_VARIANT_MASK      0xc0
>> +#define UUID_VARIANT_MASK      0xb0
>>   #define UUID_VARIANT_SHIFT     7
>>   #define UUID_VARIANT           0x1
>>
>> diff --git a/lib/uuid.c b/lib/uuid.c
>> index 89911b06ccc0..73251eaa397e 100644
>> --- a/lib/uuid.c
>> +++ b/lib/uuid.c
>> @@ -411,9 +411,9 @@ void gen_uuid_v5(const struct uuid *namespace,
>> struct uuid *uuid, ...)
>>          memcpy(uuid, hash, sizeof(*uuid));
>>
>>          /* Configure variant/version bits */
>> -       tmp =3D be32_to_cpu(uuid->time_hi_and_version);
>> +       tmp =3D uuid->time_hi_and_version;
>
> Not caring for the endianness at all does not look right.
> Indeed, while this does work on my side in little-endian, this does not =
work on
> on big-endian simulators.
> Also, this is a 16b quantity, not 32b; we need to redefine tmp to uint16=
_t and
> use the be16 functions.
>
>>          tmp =3D (tmp & ~UUID_VERSION_MASK) | (5 << UUID_VERSION_SHIFT)=
;
>> -       uuid->time_hi_and_version =3D cpu_to_be32(tmp);
>> +       uuid->time_hi_and_version =3D tmp;
>>
>>          uuid->clock_seq_hi_and_reserved &=3D UUID_VARIANT_MASK;
>
> We need to mask with ~UUID_VARIANT_MASK, I think.
>
>>          uuid->clock_seq_hi_and_reserved |=3D UUID_VARIANT << UUID_VARI=
ANT_SHIFT;
>>
>> Can you give it a shot?
>
> This does indeed work on my little-endian machines, but not on big-endia=
n
> simulators.
> For testing on big-endian, I suggest using only genguid as the sandbox w=
ill not
> help there:
>
>    $ make sandbox_defconfig
>    $ make tools-only
>    $ ./tools/genguid 2a5aa852-b856-4d97-baa9-5c5f4421551f \
>          -c "qcom,qrb4210-rb2" \
>          QUALCOMM-UBOOT
>
> ...and feed the resulting UUID to `uuid -d'.
> (The genguid command is the online help example.)
>
>> What I am afraid of is breaking existing use cases using a different
>> variant mask....
>> If that's the case we might need to keep the buggy existing
>> UUID_VARIANT_MASK and use the new one only on v5 and newer code
>
> I tried to debug further and I suspect that:
>
> - Operations on 8b clock_seq_hi_and_reserved might need further casts.
>
> - My understanding is that we are generating the v5 UUID as big-endian i=
n
>    memory; if this is indeed the case, genguid should not print it with =
the GUID
>    byte order.

The current specification is in RFC 9562, 4.1, "Variant field"

"The variant field consists of a variable number of the most significant
bits of octet 8 of the UUID.

...

Specifically for UUIDs in this document, bits 64 and 65 of the UUID
(bits 0 and 1 of octet 8) MUST be set to 1 and 0 as specified in row 2
of Table 1."

This reference to byte 8 does not depend on endianness.

U-Boot's include/uuid.h has:

     /* This is structure is in big-endian */
     struct uuid {

The field time_hi_and_version needs to be stored in big-endian fashion.


tools/genguid uses UUID_STR_FORMAT_GUID which prints low-endian which is
typical in the EFI context but not understood by 'uuid -d'. Maybe we
should add a parameter for the output format.

Best regards

Heinrich

>
> For the moment I am unable to make the code work in all the following ca=
ses:
>
> - genguid on little-endian
> - genguid on big-endian
> - sandbox ESRT on little-endian
>
> I will let you and Caleb know if I make any progress.
>
> Best regards,
> Vincent.
>
>>
>> Thanks
>> /Ilias


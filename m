Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44582C83F1A
	for <u-boot@archiver.kernel.org>; Sat, 12 Jul 2025 07:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43BFF800D7;
	Sat, 12 Jul 2025 09:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qGLyLZ9r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECEC280194; Sat, 12 Jul 2025 09:15:22 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9418C80050
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 09:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1752304514; x=1752909314; i=xypron.glpk@gmx.de;
 bh=NMIigUyc7x9h9UOF+S94DmoH4p8RvC598Jk41oBSWfw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=qGLyLZ9rGFbAcE3mVLI3tFYSES08gSb4cKwhWJaxmnykhYf+btpVLmes+NBpo83S
 xZUpM7wAgiK9lanftmvT90xoYRgYp663w0pB1wlvLrXbgb3Kfa/1UXUqMYaVYeM/O
 FEc44k6x9QH2pbOeCHcXVuQyLqD16bM6OeSUHtql9HXYoC0ryfgLakz8Epj3Q4zWe
 A2kD7V9OlIxxYMNKeEUVi/Vl8vhv6cADaHSWjnXVigM2mOTAaVSZK2Lp44WB6cr2p
 +5ItAo2DIILzqeTR8xbulfMJ1cCV4+Q8r1YjseXgjryMu5pAvqZ4/XuG9f4n1viCM
 2og6Qu72lZnsBjjM3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.107] ([46.114.111.97]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCKFu-1uRAnL1jta-002HyP; Sat, 12
 Jul 2025 09:15:13 +0200
Message-ID: <9dd21288-3e95-49ee-8d55-624f8839c3e7@gmx.de>
Date: Sat, 12 Jul 2025 09:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/5] efi: add EFI_SYSTEM_TABLE_POINTER for debug
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Paul Liu <paul.liu@linaro.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20250703062811.72871-1-paulliu@debian.org>
 <20250703062811.72871-2-paulliu@debian.org>
 <1e2e7d6d-2704-467a-b2a0-58a99600378f@gmx.de>
 <CALG-KHyh2zaOWtyrQiCxp7OxnJHmUnBkyKrV761y-88=RNu8Sg@mail.gmail.com>
 <3DCBE6CC-1427-4923-97AC-6FA12CA858C0@gmx.de>
 <76a73a10-6b14-49a6-b791-646d372f9ae1@gmx.de>
Content-Language: en-US
In-Reply-To: <76a73a10-6b14-49a6-b791-646d372f9ae1@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+ek/vdxpf8S8YexTPzvpZeAnf4YzfKNPceRpZUnIYo58eAwViow
 WfEXxtZnz/Z+JO6kU41fb+m41xwr0qS9jSSb87Q/Yr719IllwFqHnuZN4DbpxYDP2W0YBql
 fHTHkV0+ZerXLRD+qvM1qeNxP/2gHWVFG3zMzMCvK7p0MXUCvNi3hpnm1v4Y+z5nGUZ2exk
 RBAZQihFcXRbgI9v4akIA==
UI-OutboundReport: notjunk:1;M01:P0:K+OMvo/klxE=;iJHgI3MV0fddEVB9Qlih7ianyIG
 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
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

On 7/12/25 02:17, Heinrich Schuchardt wrote:
> On 7/11/25 22:55, Heinrich Schuchardt wrote:
>> Am 4. Juli 2025 13:59:53 MESZ schrieb Paul Liu<paul.liu@linaro.org>:
>>> Hi Heinrich, Ilias,
>>>
>>> Sorry for the late reply. I'm a bit worried about this change. This
>>> structure (efi_system_table_pointer), is not packed.
>>> So its actual size is a bit larger. The crc32 field is not at the end =
of
>>> the structure. Actually there are 4 bytes padding after it. But the=20
>>> CRC32
>>> function is calculating the crc sum on the whole structure. So it migh=
t
>>> produce random value if we don't zero those padding bytes.
>> Thanks for highlighting this.
>>
>> Structures in UEFI are typically packed.
>>
>> Should padding bytes really be included in the crc32?
>>
>> We should add a test of the crc32 tohttps://github.com/trini/u-boot/=20
>> blob/master/lib/efi_loader/dbginfodump.c so that we can compare U-Boot=
=20
>> to EDK2.
>>
>> Best regards
>>
>> Heinrich
>=20
>=20
> EDK II only zeros out the crc32 field.
>=20
> BaseTools/Scripts/efi_debugging.py has this logic:
>=20
> if system_table_pointer.Signature =3D=3D efi_system_table_signature:
>  =C2=A0=C2=A0=C2=A0 buf1 =3D bytearray(system_table_pointer)[:16]
>  =C2=A0=C2=A0=C2=A0 crc32_value =3D zlib.crc32(buf1)
>  =C2=A0=C2=A0=C2=A0 crc32_value =3D zlib.crc32(b'\0' * (sizeof(EFI_SYSTE=
M_TABLE_POINTER)=20
> - len(buf1)), crc32_value)
>  =C2=A0=C2=A0=C2=A0 if crc32_value =3D=3D system_table_pointer.Crc32:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break
>=20
> sizeof(EFI_SYSTEM_TABLE_POINTER) evaluates to 24. So it includes padding=
=20
> bytes. The logic calculates the crc32 as if the padding bytes were zero.
>=20
> In contrast to your contribution EDK II uses BootServicesData for=20
> storing the system table pointer.
>=20
> Here is a dump of what I saw on EDK II:
>=20
> System Table Pointer @ 0x000000017fc00000
> 49 42 49 20 53 59 53 54 18 e0 ff 7f 01 00 00 00 56 d8 89 d0 00 00 00 00
>=20
> The crc32 contains the trailing NULs.
>=20
> So you are right we should zero out the padding bytes.
>=20
> Best regards
>=20
> Heinrich

I have opened an issue https://mantis.uefi.org/mantis/view.php?id=3D2521:

0002521: CRC32 field of System Table Pointer not well defined

The UEFI spec has this sentence concerning structure=20
EFI_SYSTEM_TABLE_POINTER:
"The 32-bit CRC of the entire structure is calculated assuming the Crc32=
=20
field is zero. This value is then written to the Crc32 field."

EDK II has implemented the structure as non-packed. Using the GCC=20
compiler this implies on 64-bit systems that sizeof() reports the=20
structure size as 24 bytes including 4 padding bytes after CRC32. These=20
padding bytes are not zeroed out by the EDK II code and could take=20
random values.

MdeModulePkg/Core/Dxe/Misc/DebugImageInfo.c hence produces a random=20
Crc32 in CoreUpdateDebugTableCrc32():
gBS->CalculateCrc32 ((VOID *)mDebugTable, sizeof=20
(EFI_SYSTEM_TABLE_POINTER), &mDebugTable->Crc32);

BaseTools/Scripts/efi_debugging.py:1824 calculates the CRC32 as if the=20
padding bytes were zero even if they are not non-zero. This may lead to=20
not finding the System Table Pointer at all.

The specification should explicitly state how the Crc32 field is to be=20
calculated in the presence of padding bytes.

My suggestion would be change the specification to define the structure=20
as packed so that we don't have to worry about any padding bytes:

"Eventual padding bytes after the Crc32 field are not considered in the=20
calculation of the Crc32 value."

Best regards

Heinrich

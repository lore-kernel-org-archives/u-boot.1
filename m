Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943D8C83F1B
	for <u-boot@archiver.kernel.org>; Sat, 12 Jul 2025 00:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79A4B8277D;
	Sat, 12 Jul 2025 02:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="D26Hwt/r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0CEB8277D; Sat, 12 Jul 2025 02:17:42 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D7BB803DF
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 02:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1752279459; x=1752884259; i=xypron.glpk@gmx.de;
 bh=kk2KqawOuv1Mvb9kr//TsfKfYpL5pYR4z9KpRkCp/eA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=D26Hwt/rRWDVTdLMRMAoLc8q7knWQL40R7uacQqG1ZyCyratlHpE3wqN6wvlJ7n6
 B6QArpnlwT1J8xS4xyE30PSmdmCyvvFk29GaQgwUUP8HLyMbsfZnBZQ7ERqx/NOWW
 900z3AKFzoilg03kjMH2jP+qM6WTIAgH9TgxRDEqVMONAa6Gg64njwBhy80aVuEMP
 7OugggYPgE+Iv8jv3rc0oAON07B7Zq258OV1wEWEW+5GSQsy66oAUNaxx0lAdPDcM
 S4tFKrsOjZe2KqediTBl3xCOoxC47YKDDBzZesLzVjcI480YlL+Yo/CzAwElszGML
 zB6y5Vq2A/DPi0+M+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.107] ([46.114.111.97]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtOGa-1uvlL23Wco-00sN0q; Sat, 12
 Jul 2025 02:17:38 +0200
Message-ID: <76a73a10-6b14-49a6-b791-646d372f9ae1@gmx.de>
Date: Sat, 12 Jul 2025 02:17:20 +0200
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
Content-Language: en-US
In-Reply-To: <3DCBE6CC-1427-4923-97AC-6FA12CA858C0@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9Km25GWQiOAW6Pf/VLf0TUZ7l1Hko70MlKZPqG6/3A7gtIrWINw
 8f2ZA0O0aw24raX6rYd6fMnfJeWjfaZTOhE3k3h75dhqSP6AfLfBgLtsIel/5SwHCwt8O1k
 fwbhFUSaj9WVMFu0VioIjQzfFpiOSIAgDObTbFgzwiw2jXhTjxDVdzzhnOVqIpywsviowMk
 vNW18l+ScIxm5sU+Jwg7g==
UI-OutboundReport: notjunk:1;M01:P0:mhCuiBqI3Fk=;dFc20JV1s932IjogjWq1p6GOAuR
 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
 oiDso=
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

On 7/11/25 22:55, Heinrich Schuchardt wrote:
> Am 4. Juli 2025 13:59:53 MESZ schrieb Paul Liu<paul.liu@linaro.org>:
>> Hi Heinrich, Ilias,
>>
>> Sorry for the late reply. I'm a bit worried about this change. This
>> structure (efi_system_table_pointer), is not packed.
>> So its actual size is a bit larger. The crc32 field is not at the end o=
f
>> the structure. Actually there are 4 bytes padding after it. But the CRC=
32
>> function is calculating the crc sum on the whole structure. So it might
>> produce random value if we don't zero those padding bytes.
> Thanks for highlighting this.
>=20
> Structures in UEFI are typically packed.
>=20
> Should padding bytes really be included in the crc32?
>=20
> We should add a test of the crc32 tohttps://github.com/trini/u-boot/blob=
/master/lib/efi_loader/dbginfodump.c so that we can compare U-Boot to EDK2=
.
>=20
> Best regards
>=20
> Heinrich


EDK II only zeros out the crc32 field.

BaseTools/Scripts/efi_debugging.py has this logic:

if system_table_pointer.Signature =3D=3D efi_system_table_signature:
     buf1 =3D bytearray(system_table_pointer)[:16]
     crc32_value =3D zlib.crc32(buf1)
     crc32_value =3D zlib.crc32(b'\0' * (sizeof(EFI_SYSTEM_TABLE_POINTER)=
=20
- len(buf1)), crc32_value)
     if crc32_value =3D=3D system_table_pointer.Crc32:
         break

sizeof(EFI_SYSTEM_TABLE_POINTER) evaluates to 24. So it includes padding=
=20
bytes. The logic calculates the crc32 as if the padding bytes were zero.

In contrast to your contribution EDK II uses BootServicesData for=20
storing the system table pointer.

Here is a dump of what I saw on EDK II:

System Table Pointer @ 0x000000017fc00000
49 42 49 20 53 59 53 54 18 e0 ff 7f 01 00 00 00 56 d8 89 d0 00 00 00 00

The crc32 contains the trailing NULs.

So you are right we should zero out the padding bytes.

Best regards

Heinrich

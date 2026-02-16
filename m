Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5444BE7BD91
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 11:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D03DE83AB7;
	Mon, 16 Feb 2026 12:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cCfSY8/0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64E6483C6C; Mon, 16 Feb 2026 12:39:23 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 404A78063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 12:39:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1771241950; x=1771846750; i=xypron.glpk@gmx.de;
 bh=rAQ/+cjOS+5oe9IbCn1VaaA5h1THmZFAXqJGaWzDWp8=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=cCfSY8/0Rr6VumU8QDcACiv7h3fo1ig/g/LIJq2jvtVbmfvPZjsnklRynOcjDzYW
 vEWKhaBvCdWLo56pOf5zHdaedqoK/nv9K7Li3HMwjHgHvAU/qmyO52CxImCP84g+c
 iBcR1g3fTYROinf9acXGhuPEHqW1wav9U75IuhS/iwWaexg44G2QcwRQb28dbNwK6
 OSseA8ynJC5zJZkJO1TUUMS7OZRFIMaP9P6ahvtvMLGg/7n4zJDC5Basrcejd799N
 ex+BEqkoYkGE6kEfqSzqewD5QNM+G7q/a8BbiqJdHZbjC1kMszsoV7NH27SsKi43P
 2Qb7ZKRABxqgbjEHjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([46.114.242.81]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M6DWs-1vpm90010K-003PaE; Mon, 16 Feb 2026 12:39:10 +0100
Date: Mon, 16 Feb 2026 12:39:05 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Michal Simek <michal.simek@amd.com>,
 =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: Shantur Rathore <i@shantur.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, git@amd.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v8 4/4] efi_vars: Implement SPI Flash store
User-Agent: Thunderbird for Android
In-Reply-To: <e5c63fcb-c88b-4550-bf5c-de46a66db0a2@amd.com>
References: <cover.1770825377.git.michal.simek@amd.com>
 <35ddf2fe394ee55c66f349dc5cc33fe1dda8f864.1770825377.git.michal.simek@amd.com>
 <1508c7be-0700-43ec-adfa-29ea16081b2f@gmx.de>
 <e5c63fcb-c88b-4550-bf5c-de46a66db0a2@amd.com>
Message-ID: <E2042B0B-0842-4FC0-B4A8-49D195E5A532@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vfhVlilq6CldjmhKQJTDuNLchB8xQ11XPb/0OTQnV6a3oEL9lsJ
 fRbkyWS1J2CO2zk/RxL06RbFTgSohnU8TWvUQTIBW0pvo21ewjD1/VGaGJBNi/ZOyOWH8UC
 AScyqysE8qN0Z1afOwq+DqUcQGYIH2PuiZfk165N1YzldGZTSa2GUEw2sWdwfEBJglkos8W
 f/x8YrTOL0sp07VmDcO2Q==
UI-OutboundReport: notjunk:1;M01:P0:RXz+5cSi4JA=;cih7WoeF+Kpjua8+ZRijK6l/yAx
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

Am 16=2E Februar 2026 08:24:19 MEZ schrieb Michal Simek <michal=2Esimek@amd=
=2Ecom>:
>
>
>On 2/15/26 09:48, Heinrich Schuchardt wrote:
>> On 2/11/26 16:56, Michal Simek wrote:
>>> From: Shantur Rathore <i@shantur=2Ecom>
>>>=20
>>> Currently U-Boot uses ESP as storage for EFI variables=2E
>>> Devices with SPI Flash are used for storing environment with this
>>> commit we allow EFI variables to be stored on SPI Flash=2E
>>>=20
>>> https://github=2Ecom/rhboot/efivar
>>> is not updated to support this location that's why you can mimic it by
>>> running:
>>> dd if=3D/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11=
e818c3130c \
>>> =C2=A0=C2=A0=C2=A0 of=3D/tmp/vars skip=3D4 bs=3D1
>>> flashcp /tmp/vars /dev/mtdX
>>>=20
>>> where mtdX should match location defined by
>>> CONFIG_EFI_VARIABLE_SF_OFFSET/CONFIG_EFI_VAR_BUF_SIZE=2E
>>>=20
>>> Signed-off-by: Shantur Rathore <i@shantur=2Ecom>
>>> Signed-off-by: Michal Simek <michal=2Esimek@amd=2Ecom>
>>> Tested-by: Neil Armstrong <neil=2Earmstrong@linaro=2Eorg> # on AML-S90=
5D3-CC
>>> Acked-by: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>>>=20
>>> ---
>>>=20
>>> Changes in v8:
>>> - Add missing EFI_VARIABLE_SF_STORE dependency to EFI_VARIABLE_SF_DEVI=
CE_INDEX
>>>=20
>>> Changes in v7:
>>> - sed -i 's/efi_var_from/efi_var_from_storage/g'
>>>=20
>>> Changes in v6:
>>> - sed -i 's/efi_var_read/efi_var_from/g'
>>> - sed -i 's/efi_var_write/efi_var_to_storage/g'
>>>=20
>>> Changes in v4:
>>> - Extend Kconfig description
>>> - Extend commit message and describe efivar missing part
>>> - use unify methods for reading/writing variable
>>>=20
>>> Changes in v3:
>>> - Fixed compiler warnings=2E
>>>=20
>>> Changes in v2:
>>> - Refactored efi_var_file to move common parts out as requested
>>> - Changed ifdefs to use CONFIG_IS_DEFINED
>>> - Fixed typos
>>>=20
>>> =C2=A0 lib/efi_loader/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 35 +++++=
++++++++-
>>> =C2=A0 lib/efi_loader/Makefile=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>> =C2=A0 lib/efi_loader/efi_var_sf=2Ec | 92 ++++++++++++++++++++++++++++=
+++++++++
>>> =C2=A0 3 files changed, 127 insertions(+), 1 deletion(-)
>>> =C2=A0 create mode 100644 lib/efi_loader/efi_var_sf=2Ec
>>>=20
>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>>> index 579eed658801=2E=2E0f6f927ddaf1 100644
>>> --- a/lib/efi_loader/Kconfig
>>> +++ b/lib/efi_loader/Kconfig
>>> @@ -124,6 +124,24 @@ config EFI_VARIABLE_FILE_STORE
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Select this option if you w=
ant non-volatile UEFI variables to be
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stored as file /ubootefi=2E=
var on the EFI system partition=2E
>>> +config EFI_VARIABLE_SF_STORE
>>> +=C2=A0=C2=A0=C2=A0 bool "Store non-volatile UEFI variables in SPI Fla=
sh"
>>> +=C2=A0=C2=A0=C2=A0 depends on SPI_FLASH
>>> +=C2=A0=C2=A0=C2=A0 help
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Select this option if you want non-vol=
atile UEFI variables to be
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stored in SPI Flash=2E
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Define CONFIG_EFI_VARIABLE_SF_OFFSET a=
s offset in SPI Flash to use as
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the storage for variables=2E CONFIG_EF=
I_VAR_BUF_SIZE defines the space
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 needed=2E
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Note that SPI Flash devices have a lim=
ited number of program/erase
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cycles=2E Frequent updates to UEFI var=
iables may cause excessive wear
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and can permanently damage the flash d=
evice, particularly on SPI NAND
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or low-end SPI NOR parts without wear =
leveling=2E This option should be
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 used with care on such systems, and is=
 not recommended for platforms
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 where UEFI variables are updated frequ=
ently=2E
>>> +
>>> =C2=A0 config EFI_MM_COMM_TEE
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "UEFI variables storage service vi=
a the trusted world"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on OPTEE
>>> @@ -153,7 +171,7 @@ endchoice
>>> =C2=A0 config EFI_RT_VOLATILE_STORE
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Allow variable runtime services i=
n volatile storage (e=2Eg RAM)"
>>> -=C2=A0=C2=A0=C2=A0 depends on EFI_VARIABLE_FILE_STORE
>>> +=C2=A0=C2=A0=C2=A0 depends on EFI_VARIABLE_FILE_STORE || EFI_VARIABLE=
_SF_STORE
>>=20
>> Hello Michal,
>>=20
>> If the backend store is SPI flash, we should not publish the variable "=
RTStorageVolatile" at runtime as currently defined=2E
>>=20
>> For the background see this commit for the efivar library:
>>=20
>> https://github=2Ecom/rhboot/efivar/commit/68daa04654acbe1bbaa17ebfc23c3=
71b39e69c6b
>>=20
>> The first three patches look correct to me and I will add them to a mer=
ge request for efi-next=2E
>
>Do I read it that when I don't allow to select EFI_RT_VOLATILE_STORE you =
will be fine with the patch itself?

This was my only concern=2E

Maybe setting the file name to /dev/mtd/by-name/<partition name> would wor=
k with efivar=2E But I have not tested it=2E

In U-Boot we could replace EFI_VARIABLE_SF_DEVICE_INDEX, SIZE, and OFFSET =
by a partition name, too=2E That way it would be the common device-tree for=
 U-Boot and Linux controlling the placement of the variables store=2E

>
>
>> The usage of efi_var_mem_ins() and efi_var_mem_del() when SetVariable()=
 does not change anything is not flash-friendly=2E Michal, do you want to h=
ave a look at this area?
>
>That's known limitation describe in EFI_VARIABLE_SF_STORE Kconfig Note=2E

This could be a topic for future work=2E=20

Best regards

Heinrich


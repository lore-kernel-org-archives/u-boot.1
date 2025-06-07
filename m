Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56B0C5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 10:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEE4F82A9E;
	Sat,  7 Jun 2025 12:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="IFMuwrBV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8FC582ADA; Sat,  7 Jun 2025 12:09:31 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8216582A65
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 12:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1749290966; x=1749895766; i=xypron.glpk@gmx.de;
 bh=21UruVUByXql1QozJRYGLbAqcnPwiZB+Eq5CeUSDD0s=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=IFMuwrBVLoI9obpO9/7FOkaotu71azj+yTvEfFiA7kGPW0o+ZL7kV2jV1RFm/4Z8
 GWEaCjxHuLNnqZDi7kMeN45yGpQELpaTg6qXu+3v5kYsMkryloxig4dOJ2fI+W0nG
 S5T9znf4W7ewcbzP0fR4bGeFj5PVtk/DGR8hpzdeu/JQaxgZ1TKUY27g/C2dVgl4P
 tcX16fZ8FDBbOU5G4C5PiKBfrSsVswBapBYLNVOJWA8anavyWtbbjphMF+x65P1sf
 E0I8GnfuFtNfFhxUO4TK1rJvI6Y2U1fsU+mQnVZqnAJTA43lYDsza1XM4owN3EWhw
 /hjL3f1UuDdtlh3Oxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.175.200]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvPJ-1uEJpQ3UX7-00YB5q; Sat, 07
 Jun 2025 12:09:25 +0200
Message-ID: <601502a1-8de6-45b3-af5d-7f88ddcbd7d0@gmx.de>
Date: Sat, 7 Jun 2025 12:09:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] efi: add EFI_SYSTEM_TABLE_POINTER for debug
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20250529040520.3799600-1-paulliu@debian.org>
 <20250529040520.3799600-2-paulliu@debian.org>
 <8985ca13-e999-43d0-b9a5-ba31ab1125a3@gmx.de>
Content-Language: en-US
In-Reply-To: <8985ca13-e999-43d0-b9a5-ba31ab1125a3@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c6YGHmzX4ew6ylMp2ed3bu7p1q/1roj/Xn885z0eapG7CAW+OPq
 hF+TYvI9Phpoyhg8quP1kr96JiS69dbt/qLPU+g+hvDc7QbxjXuU7HlN/+v50nV9IUIT7b5
 cKXQxiMAGnL2QiM8uc503a9hi935A6ugW1rvinrWdT5je5DE75VF0iasMpZMqN4uFxBfOfu
 X34Hivd01LbR/WDpATUoA==
UI-OutboundReport: notjunk:1;M01:P0:Pfr4zuL19po=;C4yjeGg/MsbQJJbjftIn1oipo+B
 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
 xk4bD/D
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

On 6/7/25 11:39, Heinrich Schuchardt wrote:
> On 5/29/25 06:05, Ying-Chun Liu (PaulLiu) wrote:
>> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
>>
>> Add EFI_SYSTEM_TABLE_POINTER structure for remote debugger to locate
>> the address of EFI_SYSTEM_TABLE.
>>
>> This feature is described in UEFI SPEC version 2.10. Section 18.4.2.
>> The implementation ensures support for hardware-assisted debugging and
>> provides a standardized mechanism for debuggers to discover the EFI
>> system table.
>>
>> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Peter Robinson <pbrobinson@gmail.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> ---
>> V2: add Kconfig options to turn on/off this feature.
>> V3: make efi_initialize_system_table_pointer() do the job as described.
>> V4: use efi_alloc_aligned_pages() for system_table_pointer.
>> ---
>> =C2=A0 include/efi_api.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 +++++++++++++++
>> =C2=A0 include/efi_loader.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 ++
>> =C2=A0 lib/efi_loader/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 7 +++++++
>> =C2=A0 lib/efi_loader/efi_boottime.c | 37 +++++++++++++++++++++++++++++=
++++++
>> =C2=A0 lib/efi_loader/efi_setup.c=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++++++
>> =C2=A0 5 files changed, 70 insertions(+)
>>
>> diff --git a/include/efi_api.h b/include/efi_api.h
>> index eb61eafa028..6c4c1a0cc7b 100644
>> --- a/include/efi_api.h
>> +++ b/include/efi_api.h
>> @@ -259,6 +259,22 @@ struct efi_capsule_result_variable_header {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efi_status_t capsule_status;
>> =C2=A0 } __packed;
>> +/**
>> + * struct efi_system_table_pointer - struct to store the pointer of=20
>> system
>> + * table.
>> + * @signature: The signature of this struct.
>> + * @efi_system_table_base: The physical address of System Table.
>> + * @crc32: CRC32 checksum
>> + *
>> + * This struct is design for hardware debugger to search through=20
>> memory to
>> + * get the address of EFI System Table.
>> + */
>> +struct efi_system_table_pointer {
>> +=C2=A0=C2=A0=C2=A0 u64 signature;
>> +=C2=A0=C2=A0=C2=A0 efi_physical_addr_t efi_system_table_base;
>> +=C2=A0=C2=A0=C2=A0 u32 crc32;
>> +};
>> +
>> =C2=A0 struct efi_memory_range {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efi_physical_addr_t=C2=A0=C2=A0=C2=A0 ad=
dress;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 length;
>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>> index 8f9f2bcf1cb..8f065244d8e 100644
>> --- a/include/efi_loader.h
>> +++ b/include/efi_loader.h
>> @@ -646,6 +646,8 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb);
>> =C2=A0 efi_status_t efi_root_node_register(void);
>> =C2=A0 /* Called by bootefi to initialize runtime */
>> =C2=A0 efi_status_t efi_initialize_system_table(void);
>> +/* Called by bootefi to initialize debug */
>> +efi_status_t efi_initialize_system_table_pointer(void);
>> =C2=A0 /* efi_runtime_detach() - detach unimplemented runtime functions=
 */
>> =C2=A0 void efi_runtime_detach(void);
>> =C2=A0 /* efi_convert_pointer() - convert pointer to virtual address */
>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>> index 7f02a83e2a2..d878fc9021d 100644
>> --- a/lib/efi_loader/Kconfig
>> +++ b/lib/efi_loader/Kconfig
>> @@ -71,6 +71,13 @@ config EFI_SECURE_BOOT
>> =C2=A0 config EFI_SIGNATURE_SUPPORT
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>> +config EFI_DEBUG_SUPPORT_TABLE
>> +=C2=A0=C2=A0=C2=A0 bool "EFI Debug Support Table"
>> +=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Select this option if you want to setup=
 the EFI Debug Support
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Table which is used by the debug agent =
or an external debugger to
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 determine loaded image information in a=
 quiescent manner.
>> +
>> =C2=A0 menu "UEFI services"
>> =C2=A0 config EFI_GET_TIME
>> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/=20
>> efi_boottime.c
>> index dbebb37dc04..16e921781e9 100644
>> --- a/lib/efi_loader/efi_boottime.c
>> +++ b/lib/efi_loader/efi_boottime.c
>> @@ -4001,6 +4001,8 @@ struct efi_system_table __efi_runtime_data=20
>> systab =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .tables =3D NULL,
>> =C2=A0 };
>> +struct efi_system_table_pointer __efi_runtime_data * systab_pointer =
=3D=20
>> NULL;
>> +
>> =C2=A0 /**
>> =C2=A0=C2=A0 * efi_initialize_system_table() - Initialize system table
>> =C2=A0=C2=A0 *
>> @@ -4035,3 +4037,38 @@ efi_status_t efi_initialize_system_table(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> +
>> +/**
>> + * efi_initialize_system_table() - Initialize system table pointer
>> + *
>> + * Return:=C2=A0=C2=A0=C2=A0 status code
>> + */
>> +efi_status_t efi_initialize_system_table_pointer(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 const int size_4MB =3D 0x00400000;
>> +=C2=A0=C2=A0=C2=A0 u64 addr;
>> +=C2=A0=C2=A0=C2=A0 u32 crc32_value;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Allocate configuration table array */
>> +=C2=A0=C2=A0=C2=A0 addr =3D (u64)efi_alloc_aligned_pages(sizeof(struct=
=20
>> efi_system_table_pointer),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EFI_=
RUNTIME_SERVICES_DATA,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size=
_4MB);
>=20
> We expect the code to compile after each individual step. Function=20
> efi_alloc_aligned_pages() does not exist when this step is applied.

Sorry this function exits. But it does not work correctly on the sandbox=
=20
as the LMB memory start is not 4 MiB aligned. I will send a series for thi=
s.

>=20
> Even if I apply all patches your code does not compile on 32bit systems:
>=20
> +lib/efi_loader/efi_boottime.c:4072:16: error: cast from pointer to=20
> integer of different size [-Werror=3Dpointer-to-int-cast]
> + 4072 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D (u64)e=
fi_alloc_aligned_pages(sizeof(struct=20
> efi_system_table_pointer),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>=20
> Use (uintptr_t) here.
>=20
> Best regards
>=20
> Heinrich
>=20
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!addr) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_err("Installing EFI sys=
tem table pointer failed\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return EFI_OUT_OF_RESOURCES=
;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 systab_pointer =3D (struct efi_system_table_pointer=
 *)addr;
>> +=C2=A0=C2=A0=C2=A0 memset(systab_pointer, 0, sizeof(struct efi_system_=
table_pointer));
>> +
>> +=C2=A0=C2=A0=C2=A0 systab_pointer->signature =3D EFI_SYSTEM_TABLE_SIGN=
ATURE;
>> +=C2=A0=C2=A0=C2=A0 systab_pointer->efi_system_table_base =3D=20
>> (efi_physical_addr_t)&systab;
>> +
>> +=C2=A0=C2=A0=C2=A0 crc32_value =3D crc32(0,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (const unsigned char *)systab_pointer,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 sizeof(struct efi_system_table_pointer));
>> +=C2=A0=C2=A0=C2=A0 systab_pointer->crc32 =3D crc32_value;
>> +
>> +=C2=A0=C2=A0=C2=A0 return EFI_SUCCESS;
>> +}
>> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
>> index 48f91da5df7..a6b37d994f6 100644
>> --- a/lib/efi_loader/efi_setup.c
>> +++ b/lib/efi_loader/efi_setup.c
>> @@ -278,6 +278,14 @@ efi_status_t efi_init_obj_list(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D EFI_SUCCESS)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> +=C2=A0=C2=A0=C2=A0 /* Initialize system table pointer */
>> +=C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT_TABLE)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D efi_initialize_syst=
em_table_pointer();
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D EFI_SUCCESS) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_EFI_ECPT)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D efi_ecpt=
_register();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D EFI=
_SUCCESS)
>=20


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255C6C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 20:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75C6782A46;
	Fri, 25 Apr 2025 22:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="DYYSfECZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 379D782A55; Fri, 25 Apr 2025 22:31:22 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A34DD82A3B
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 22:31:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1745613077; x=1746217877; i=xypron.glpk@gmx.de;
 bh=nZQIoBvEbyKJf9IqxqJQDwofOZrt41MNuaREJenXcME=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DYYSfECZ/MtTl8pJA2D6MhdfMSD33SyStYYD40X9SK1LTVfZBWlIssC15q/KPpPT
 SnrQf6/YU8qYD9ugekjzFO6Ug+5LEdu7y0BXy7dNLUx8Tyu9am6V9YNV/nZI7uW7G
 wsvCZ8XkRupheqGPHTz4AEwY3ZbBVHa2i80w3x5qpkKafoG1oafv0Qt59dX9sj1NS
 gqfPznvzyyrnY0yYwVWjZ/GWSdHBU6/pBVrtb3jN5HK6eIBdfS/sOsN6uuO+fcMg0
 IS3cybqWfJGd4vTbpQi35AI1Ex8f1QWE/bxbRSITqFnur+LngG6BcSCjIjko4k0UV
 2U+vqYAuN7s0VecvsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUj2-1uySON0ras-016p9s; Fri, 25
 Apr 2025 22:31:17 +0200
Message-ID: <ff4da769-1b8f-4c53-a311-12eeecc859e1@gmx.de>
Date: Fri, 25 Apr 2025 22:31:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
To: Paul Liu <paul.liu@linaro.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20250424201927.2027257-1-paulliu@debian.org>
 <20250424201927.2027257-3-paulliu@debian.org>
 <5b1181bf-1398-409c-b710-dc07e4eaa9d7@gmx.de>
 <CALG-KHz+spRA68RyzCUhWM4m_D2VoVLmiKJz85thuUbKyu6gOA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CALG-KHz+spRA68RyzCUhWM4m_D2VoVLmiKJz85thuUbKyu6gOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k0rx9w2CNu8QIe3MxV1v4Qm55CO60Jdl0Eeg2q/2hqc20Py6oCX
 dpb0dTZBopMI0w65rrpgDoJusdPphod9Sy8I2biRbxax23dYeWBuYgw8H8JisX2q/UbXSHq
 M3ft1NaJhvlUWVLzrc+2XW8DQjaAwvbBGKoZQLA/femJXejCe5+MpFpnlpL2qwEQRkxHiV8
 EXRoY7ukavEglwMhBsBzw==
UI-OutboundReport: notjunk:1;M01:P0:MsqTYNquWuw=;tRNslSUlVWuUIDrM+puP1zIpMY/
 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
 53ylKzHT5QjXvIf8kBpLcg=
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

On 4/25/25 21:05, Paul Liu wrote:
>=20
>=20
> On Thu, 24 Apr 2025 at 23:02, Heinrich Schuchardt <xypron.glpk@gmx.de=20
> <mailto:xypron.glpk@gmx.de>> wrote:
>=20
>     On 24.04.25 22:19, Ying-Chun Liu (PaulLiu) wrote:
>      > From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org
>     <mailto:paul.liu@linaro.org>>
>      >
>      > EFI_DEBUG_IMAGE_INFO_TABLE is used to store EFI_LOADED_IMAGE for
>      > debug purpose. This commit adds the table to the
>     EFI_CONFIGURATION_TABLE.
>      >
>      > This feature is described in UEFI Spec version 2.10. Section 18.4=
.
>      >
>      > Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org
>     <mailto:paul.liu@linaro.org>>
>      > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de
>     <mailto:xypron.glpk@gmx.de>>
>      > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org
>     <mailto:ilias.apalodimas@linaro.org>>
>      > ---
>      >=C2=A0 =C2=A0include/efi_api.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 24 ++++++++++++++++++++++++
>      >=C2=A0 =C2=A0lib/efi_loader/efi_boottime.c | 16 ++++++++++++++++
>      >=C2=A0 =C2=A02 files changed, 40 insertions(+)
>      >
>      > diff --git a/include/efi_api.h b/include/efi_api.h
>      > index 5017d9037cd..0f4245091f1 100644
>      > --- a/include/efi_api.h
>      > +++ b/include/efi_api.h
>      > @@ -238,6 +238,10 @@ enum efi_reset_type {
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0EFI_GUID(0xcce33c35, 0x74ac, 0x4087, 0x=
bc, 0xe7, \
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x8b, 0x29=
, 0xb0, 0x2e, 0xeb, 0x27)
>      >
>      > +#define EFI_DEBUG_IMAGE_INFO_TABLE_GUID \
>      > +=C2=A0 =C2=A0 =C2=A0EFI_GUID(0x49152e77, 0x1ada, 0x4764, 0xb7, 0=
xa2, \
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x7a, 0xfe, 0xf=
e, 0xd9, 0x5e, 0x8b)
>      > +
>      >=C2=A0 =C2=A0struct efi_conformance_profiles_table {
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0u16 version;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0u16 number_of_profiles;
>      > @@ -564,6 +568,26 @@ struct efi_loaded_image {
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0efi_status_t (EFIAPI *unload)(efi_handl=
e_t image_handle);
>      >=C2=A0 =C2=A0};
>      >
>      > +#define EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS 0x01
>      > +#define EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED=C2=A0 =C2=A0 =C2=A00=
x02
>      > +
>=20
>     All structures and unions and their elements should be describe
>     according to
>     https://docs.kernel.org/doc-guide/kernel-doc.html#structure-union-
>     and-enumeration-documentation <https://docs.kernel.org/doc-guide/
>     kernel-doc.html#structure-union-and-enumeration-documentation>
>=20
>      > +struct efi_debug_image_info_normal {
>      > +=C2=A0 =C2=A0 =C2=A0u32 image_info_type;
>      > +=C2=A0 =C2=A0 =C2=A0struct efi_loaded_image *loaded_image_protoc=
ol_instance;
>      > +=C2=A0 =C2=A0 =C2=A0efi_handle_t image_handle;
>      > +};
>=20
>     What are the assumptions about alignment?
>     Should this structure be marked as packed like most UEFI structures?
>=20
>=20
> Not aligned. This structure in EDK2 is not aligned, not packed. And it=
=20
> is really not packed because the size of this structure is larger. 4=20
> bytes are padded in the 64-bit environment I think.

All other structures in EDK II are packed. Did you look at the structure=
=20
in a debugger?

The compiler will assume that a pointer to "struct=20
efi_debug_image_info_normal *" points to a sizeof(uintptr_t) aligned=20
structure if no other indication is made.

Best regards

Heinrich

>=20
>      > +
>      > +union efi_debug_image_info {
>=20
>     Why do we need the union? The first field of struct
>     efi_debug_image_info_normal is image_info_type.
>=20
>=20
> I just copied it from the EDK2. But we can remove it. I think edk2 wants=
=20
> to support not only normal images. However, currently there is only a=20
> normal image.
> So it looks redundant.
> I will remove this union in the next version.
>=20
>      > +=C2=A0 =C2=A0 =C2=A0u32 *image_info_type;
>      > +=C2=A0 =C2=A0 =C2=A0struct efi_debug_image_info_normal *normal_i=
mage;
>      > +};
>      > +
>      > +struct efi_debug_image_info_table_header {
>      > +=C2=A0 =C2=A0 =C2=A0volatile u32 update_status;
>=20
>     Why is volatile needed here?
>=20
>=20
> The volatile is needed because we like the status to be updated=20
> immediately to the memory.
> If we are using a hardware jtag. And it stops the code at random places=
=20
> at the beginning. It might have paused=C2=A0just inside these logics.
> So this update_status is to tell the gdb python extensions to not=20
> referencing EFI tables because it is not ready yet.
> Thus this value cannot be optimized for updating later. And thus the=20
> volatile is needed.
>=20
>     Best regards
>=20
>     Heinrich
>=20
>      > +=C2=A0 =C2=A0 =C2=A0u32 table_size;
>      > +=C2=A0 =C2=A0 =C2=A0union efi_debug_image_info *efi_debug_image_=
info_table;
>      > +};
>      > +
>      >=C2=A0 =C2=A0#define EFI_DEVICE_PATH_PROTOCOL_GUID \
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0EFI_GUID(0x09576e91, 0x6d3f, 0x11d2, \
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x8e, 0x39=
, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
>      > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/
>     efi_boottime.c
>      > index 366bc0d2b1d..e2665459e44 100644
>      > --- a/lib/efi_loader/efi_boottime.c
>      > +++ b/lib/efi_loader/efi_boottime.c
>      > @@ -4038,6 +4038,16 @@ efi_status_t efi_initialize_system_table(v=
oid)
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
>      >=C2=A0 =C2=A0}
>      >
>=20
>=20
>=20
>      > +struct efi_debug_image_info_table_header __efi_runtime_data
>=20
>=20
>=20
>      > +efi_m_debug_info_table_header =3D {
>      > +=C2=A0 =C2=A0 =C2=A00,
>      > +=C2=A0 =C2=A0 =C2=A00,
>      > +=C2=A0 =C2=A0 =C2=A0NULL
>      > +};
>      > +
>      > +const efi_guid_t efi_debug_image_info_table_guid =3D
>      > +=C2=A0 =C2=A0 =C2=A0EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
>      > +
>      >=C2=A0 =C2=A0/**
>      >=C2=A0 =C2=A0 * efi_initialize_system_table() - Initialize system =
table
>      >=C2=A0 =C2=A0 *
>      > @@ -4053,6 +4063,8 @@ efi_status_t
>     efi_initialize_system_table_pointer(void)
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 addr;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 aligned_addr;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 crc32_value;
>      > +=C2=A0 =C2=A0 =C2=A0efi_guid_t debug_image_info_table_guid =3D
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0efi_debug_image_=
info_table_guid;
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Allocate configuration table array *=
/
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D efi_allocate_pages(EFI_ALLOCATE=
_ANY_PAGES,
>      > @@ -4077,5 +4089,9 @@ efi_status_t
>     efi_initialize_system_table_pointer(void)
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(const unsigned char *)systab_pointer,
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(struct efi_system_table_pointer));
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0systab_pointer->crc32 =3D crc32_value;
>      > +
>      > +=C2=A0 =C2=A0 =C2=A0ret =3D
>     efi_install_configuration_table(&debug_image_info_table_guid,
>      > +                                        =20
>      =C2=A0&efi_m_debug_info_table_header);
>      > +
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
>      >=C2=A0 =C2=A0}
>=20


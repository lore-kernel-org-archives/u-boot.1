Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0BBC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 22:02:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91A46809D4;
	Fri, 25 Apr 2025 00:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="NxEV8Txk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0E7D80F9C; Fri, 25 Apr 2025 00:02:41 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EF148082A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 00:02:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1745532158; x=1746136958; i=xypron.glpk@gmx.de;
 bh=TjhBEm4u354OQ39ALTaXMJO4zn3DfgucX5YH/7LRh64=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=NxEV8TxkxYSMHSViJWBvi7+k1qXGXQmtVgz/fh+4aHYpahKtMdl4J2hzwLVhfUNK
 LBlgU6+MwrFA5bgN8tLysC30bVFjFqWg3h/VZxtPkZAhuRKXUn0Q6cdSFAOe9x1Df
 cvLIR8MJp2L68s+WSMQNqImUHDSP++2SZX8VpEwEyi8RarcVFeDnuvbHFTMEGJuW3
 mxbs/dBSnpOFFWBNWG3o6FM/dC3lbR3zWkKGxg6cOAAVIdEEdF0SKS2ry4vf3AVmo
 YAAFx6oINfG3KwfST946kxUKucYDvrusI+DsZHVR9PBUnyh3eepQ0kXxwRQkODlAQ
 7wbZvVzdzqD317N4iw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsIv-1uzcoD1zK3-018CNX; Fri, 25
 Apr 2025 00:02:38 +0200
Message-ID: <5b1181bf-1398-409c-b710-dc07e4eaa9d7@gmx.de>
Date: Fri, 25 Apr 2025 00:02:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20250424201927.2027257-1-paulliu@debian.org>
 <20250424201927.2027257-3-paulliu@debian.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250424201927.2027257-3-paulliu@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3sVXPC2BZOVjbwP1iIQhqjjoieyEau6c+ifSFDOwx6/3SMR2WZw
 ZTeNRb1MAGzrA4T69P7Q6elqs2fgLkAJQsk1Udoxw3M89NOz125Y4JPEK10jCnAuwquNj2K
 MmlnZSaSRxDRA8n3I1u/GldKIVl1V1GHCv3GXUUGM5JwB2ic63mbUJfyVZxyiKrZXTpzTZW
 II+L497CnXzkJh8GYDjJQ==
UI-OutboundReport: notjunk:1;M01:P0:wZXetwsOpzU=;uHOWJtjMLK9U7w5y/GafPMITO+o
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

On 24.04.25 22:19, Ying-Chun Liu (PaulLiu) wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
>=20
> EFI_DEBUG_IMAGE_INFO_TABLE is used to store EFI_LOADED_IMAGE for
> debug purpose. This commit adds the table to the EFI_CONFIGURATION_TABLE=
.
>=20
> This feature is described in UEFI Spec version 2.10. Section 18.4.
>=20
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   include/efi_api.h             | 24 ++++++++++++++++++++++++
>   lib/efi_loader/efi_boottime.c | 16 ++++++++++++++++
>   2 files changed, 40 insertions(+)
>=20
> diff --git a/include/efi_api.h b/include/efi_api.h
> index 5017d9037cd..0f4245091f1 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -238,6 +238,10 @@ enum efi_reset_type {
>   	EFI_GUID(0xcce33c35, 0x74ac, 0x4087, 0xbc, 0xe7, \
>   		 0x8b, 0x29, 0xb0, 0x2e, 0xeb, 0x27)
>  =20
> +#define EFI_DEBUG_IMAGE_INFO_TABLE_GUID \
> +	EFI_GUID(0x49152e77, 0x1ada, 0x4764, 0xb7, 0xa2, \
> +		 0x7a, 0xfe, 0xfe, 0xd9, 0x5e, 0x8b)
> +
>   struct efi_conformance_profiles_table {
>   	u16 version;
>   	u16 number_of_profiles;
> @@ -564,6 +568,26 @@ struct efi_loaded_image {
>   	efi_status_t (EFIAPI *unload)(efi_handle_t image_handle);
>   };
>  =20
> +#define EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS 0x01
> +#define EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED     0x02
> +

All structures and unions and their elements should be describe according =
to
https://docs.kernel.org/doc-guide/kernel-doc.html#structure-union-and-enum=
eration-documentation

> +struct efi_debug_image_info_normal {
> +	u32 image_info_type;
> +	struct efi_loaded_image *loaded_image_protocol_instance;
> +	efi_handle_t image_handle;
> +};

What are the assumptions about alignment?
Should this structure be marked as packed like most UEFI structures?

> +
> +union efi_debug_image_info {

Why do we need the union? The first field of struct=20
efi_debug_image_info_normal is image_info_type.

> +	u32 *image_info_type;
> +	struct efi_debug_image_info_normal *normal_image;
> +};
> +
> +struct efi_debug_image_info_table_header {
> +	volatile u32 update_status;

Why is volatile needed here?

Best regards

Heinrich

> +	u32 table_size;
> +	union efi_debug_image_info *efi_debug_image_info_table;
> +};
> +
>   #define EFI_DEVICE_PATH_PROTOCOL_GUID \
>   	EFI_GUID(0x09576e91, 0x6d3f, 0x11d2, \
>   		 0x8e, 0x39, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index 366bc0d2b1d..e2665459e44 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -4038,6 +4038,16 @@ efi_status_t efi_initialize_system_table(void)
>   	return ret;
>   }
>  =20



> +struct efi_debug_image_info_table_header __efi_runtime_data



> +efi_m_debug_info_table_header =3D {
> +	0,
> +	0,
> +	NULL
> +};
> +
> +const efi_guid_t efi_debug_image_info_table_guid =3D
> +	EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
> +
>   /**
>    * efi_initialize_system_table() - Initialize system table
>    *
> @@ -4053,6 +4063,8 @@ efi_status_t efi_initialize_system_table_pointer(v=
oid)
>   	u64 addr;
>   	u64 aligned_addr;
>   	u32 crc32_value;
> +	efi_guid_t debug_image_info_table_guid =3D
> +		efi_debug_image_info_table_guid;
>  =20
>   	/* Allocate configuration table array */
>   	ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> @@ -4077,5 +4089,9 @@ efi_status_t efi_initialize_system_table_pointer(v=
oid)
>   			    (const unsigned char *)systab_pointer,
>   			    sizeof(struct efi_system_table_pointer));
>   	systab_pointer->crc32 =3D crc32_value;
> +
> +	ret =3D efi_install_configuration_table(&debug_image_info_table_guid,
> +					      &efi_m_debug_info_table_header);
> +
>   	return ret;
>   }


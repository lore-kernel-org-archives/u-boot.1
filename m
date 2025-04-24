Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8DEC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 21:46:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C63D809D4;
	Thu, 24 Apr 2025 23:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dLCoblce";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C042D812BC; Thu, 24 Apr 2025 23:46:03 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FFD38082A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 23:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1745531159; x=1746135959; i=xypron.glpk@gmx.de;
 bh=MUXnoiHh+KMut5U20lZjpnKbzSt6e07S3SdgCyHvJ90=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dLCoblcekIG0/hoqWynLdU7cvH446BYJOw1zSQlPpHOlJBf9w2XTQvTDVnS3clSh
 zQuDZ2b8R3EE4hh7RvDvLjrqWSSpd9S5jJxEw88iitAS0XteB0EGZQqWOz8bsdgCC
 htNBvYdmGqG3L3JjMVY4pSXUsO9p1lBDLcxYyO2/jC20kjnqx7w2uQ/WfEEYKIFa3
 4l/VTthdLY8FH1siqGRvx6ipBakAslKYNY0vcBbci5+1vQDo/MzFc7C7amfShom8/
 ts+nj0aG3NVZqBoxWPe5z5FFKmuXybCjYG5kjawjpAwJg0RmnAeoTPnZHkVj08vMk
 dkDdSRcVc3NKAGGGPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWih0-1uah6F2xEu-00HlPh; Thu, 24
 Apr 2025 23:45:59 +0200
Message-ID: <a63e9349-6a1a-4c52-992b-6da3ed83ab6b@gmx.de>
Date: Thu, 24 Apr 2025 23:45:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] efi: add EFI_SYSTEM_TABLE_POINTER for debug
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20250424201927.2027257-1-paulliu@debian.org>
 <20250424201927.2027257-2-paulliu@debian.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250424201927.2027257-2-paulliu@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SjFUBiFLWQbO1THVqniaaaqdw9bdbxQiLHX7v0gu+hJdPSdQzU4
 75WrHt1cPVoEv36+XP8XnAYvutR1BKdurmaY1OfT77rxaMqc9Gqo4WCDNGQWKhuvpatM2tm
 8deBv5uij1h+F2SL10r1/XaSole8EIJ4wdr2mgCu+vy2dskY2s74f1Mukfx4SJmCoohv/1m
 mtN9Yj9Ejz2BmxkeD4ybg==
UI-OutboundReport: notjunk:1;M01:P0:WhbH+AjWeHA=;hxuUk4Cf0UKvRMnFOTHwIsGl8DV
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
> Add EFI_SYSTEM_TABLE_POINTER structure for debugger to locate
> the address of EFI_SYSTEM_TABLE.
>=20
> This feature is described in UEFI SPEC version 2.10. Section 18.4.2.

Hello Ying-Chun,

Thank you for your contribution.

Unfortunately it is not clear what your use case is. The reason for=20
implementing a feature should be mentioned in the commit message.=20
Cover-letters for a patch series are the right place to describe=20
overarching topics.

The relevant information needed to debug U-Boot is the u-boot.map file=20
and the relocation address. On arm64 the relocation address can be found=
=20
via the global data structure pointed to by register x18.

Once you have the relocation offset, you can determine the system table=20
address via the u-boot.map file.

If you need information about loaded EFI images, you could enable debug=20
messages using U-Boot's log command.

>=20
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> V2: add Kconfig options to turn on/off this feature.
> ---
>   include/efi_api.h             |  6 +++++
>   include/efi_loader.h          |  2 ++
>   lib/efi_loader/Kconfig        |  7 ++++++
>   lib/efi_loader/efi_boottime.c | 44 +++++++++++++++++++++++++++++++++++
>   lib/efi_loader/efi_setup.c    |  9 +++++++
>   5 files changed, 68 insertions(+)
>=20
> diff --git a/include/efi_api.h b/include/efi_api.h
> index eb61eafa028..5017d9037cd 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -259,6 +259,12 @@ struct efi_capsule_result_variable_header {
>   	efi_status_t capsule_status;
>   } __packed;
>  =20
> +struct efi_system_table_pointer {
> +	u64 signature;
> +	efi_physical_addr_t efi_system_table_base;
> +	u32 crc32;
> +};
> +
>   struct efi_memory_range {
>   	efi_physical_addr_t	address;
>   	u64			length;
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 1d75d97ebbc..370bc042f70 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -615,6 +615,8 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb);
>   efi_status_t efi_root_node_register(void);
>   /* Called by bootefi to initialize runtime */
>   efi_status_t efi_initialize_system_table(void);
> +/* Called by bootefi to initialize debug */
> +efi_status_t efi_initialize_system_table_pointer(void);
>   /* efi_runtime_detach() - detach unimplemented runtime functions */
>   void efi_runtime_detach(void);
>   /* efi_convert_pointer() - convert pointer to virtual address */
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index d4f6b56afaa..94a75981389 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -70,6 +70,13 @@ config EFI_SECURE_BOOT
>   config EFI_SIGNATURE_SUPPORT
>   	bool
>  =20
> +config EFI_DEBUG_SUPPORT_TABLE
> +	bool "EFI Debug Support Table"
> +	help
> +	  Select this option if you want to setup the EFI Debug Support
> +	  Table which is used by the debug agent or an external debugger to
> +	  determine loaded image information in a quiescent manner.
> +
>   menu "UEFI services"
>  =20
>   config EFI_GET_TIME
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index 5164cb15986..366bc0d2b1d 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -4001,6 +4001,8 @@ struct efi_system_table __efi_runtime_data systab =
=3D {
>   	.tables =3D NULL,
>   };
>  =20
> +struct efi_system_table_pointer __efi_runtime_data * systab_pointer =3D=
 NULL;
> +
>   /**
>    * efi_initialize_system_table() - Initialize system table
>    *
> @@ -4035,3 +4037,45 @@ efi_status_t efi_initialize_system_table(void)
>  =20
>   	return ret;
>   }
> +
> +/**
> + * efi_initialize_system_table() - Initialize system table
> + *
> + * Return:	status code
> + */
> +efi_status_t efi_initialize_system_table_pointer(void)

This function name seems to be a misnomer as you are setting up much=20
more with the next patches.

> +{
> +	efi_status_t ret;
> +	const int size_4MB =3D 0x00400000;
> +	int pages =3D efi_size_in_pages(sizeof(struct efi_system_table_pointer=
));
> +	int alignment_mask =3D size_4MB - 1;
> +	int real_pages =3D pages + efi_size_in_pages(size_4MB);
> +	u64 addr;
> +	u64 aligned_addr;
> +	u32 crc32_value;
> +
> +	/* Allocate configuration table array */
> +	ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> +				 EFI_RUNTIME_SERVICES_DATA,
> +				 real_pages,
> +				 &addr);
> +
> +	/* alignment to 4MB boundary */
> +	aligned_addr =3D (addr + alignment_mask) & ~alignment_mask;
> +
> +	systab_pointer =3D (struct efi_system_table_pointer *)aligned_addr;
> +	memset(systab_pointer, 0, sizeof(struct efi_system_table_pointer));
> +
> +	/*
> +	 * These entries will be set to NULL in ExitBootServices(). To avoid
> +	 * relocation in SetVirtualAddressMap(), set them dynamically.
> +	 */

This comment does not match the submitted code.

> +	systab_pointer->signature =3D EFI_SYSTEM_TABLE_SIGNATURE;
> +	systab_pointer->efi_system_table_base =3D (efi_physical_addr_t)&systab=
;
> +	systab_pointer->crc32 =3D 0;
> +	crc32_value =3D crc32(0,
> +			    (const unsigned char *)systab_pointer,
> +			    sizeof(struct efi_system_table_pointer));
> +	systab_pointer->crc32 =3D crc32_value;
> +	return ret;
> +}
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index aa59bc7779d..6be23ca43bf 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -259,6 +259,15 @@ efi_status_t efi_init_obj_list(void)
>   	if (ret !=3D EFI_SUCCESS)
>   		goto out;
>  =20
> +	/* Initialize system table */
> +	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT_TABLE)) {
> +		ret =3D efi_initialize_system_table_pointer();
> +		if (ret !=3D EFI_SUCCESS) {
> +			printf("EFI init system table pointer fail\n");

Maybe: "Installing EFI system table pointer failed\n".

Please, use log_error() and move the output to the appropriate place in=20
the efi_initialize_system_table_pointer() function.

Best regards

Heinrich

> +			goto out;
> +		}
> +	}
> +
>   	if (IS_ENABLED(CONFIG_EFI_ECPT)) {
>   		ret =3D efi_ecpt_register();
>   		if (ret !=3D EFI_SUCCESS)


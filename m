Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53509C5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 10:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3F97807B1;
	Sat,  7 Jun 2025 12:38:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jzJte0d7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF66828F8; Sat,  7 Jun 2025 12:38:50 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B848003E
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 12:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1749292727; x=1749897527; i=xypron.glpk@gmx.de;
 bh=sv1a4sevFB6tPOFH47/K2fHYXZXGZlzi2c2PxxieVbo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=jzJte0d7JCoAkhz7xdyjPzlmTv1bOBgmdvw22jqLrhNL3/ipd+ae31ziIxEnh5D7
 ikmY+JnJd+fo1bhrFb2se/xrhPGpKsIUzeo0nxrHQRe5bvwz3/tSCVlV8ALwLWU/J
 RNMW2yHd+QpaCPJbE+/guFkCcEHfdbLrTm2H3JoCPmvLN/SCOjwX5wcYhGFrzaLEx
 J+cOvQRZBjXalxQu++vnXXzas5u9baNx9YlfDaTyyb2/JRDZT74H4JDZwDUF/gNnB
 QLUX6LWTgIazrURdywgpt07UTjf4hFjbMAX3mjTAmzoqu4xZXXvGZOAnJigPGWct3
 CtqGehii3XrsE3jBEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.175.200]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Msq6C-1uhrm3123E-00zesD; Sat, 07
 Jun 2025 12:38:47 +0200
Message-ID: <c8ebc5ca-305f-4fad-949b-11d612edb609@gmx.de>
Date: Sat, 7 Jun 2025 12:38:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] efi: add EFI_SYSTEM_TABLE_POINTER for debug
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20250529040520.3799600-1-paulliu@debian.org>
 <20250529040520.3799600-2-paulliu@debian.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250529040520.3799600-2-paulliu@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nKytahqQ+aOwu4s2Z57yIBZ2vtx1sR/FdNd/7AiEk98FpxGbcdr
 jar53lup14SUldrBH73rJDIfQRCj7XNONrOl4Bvzgi6QZsO/adBLJHWeGYVrTbe4wH9B7N4
 pGiT26chuGHT+i1OcejKgLQFgx/A8BTeLYazPJpQg8XM3BeiGFU4TfkgrKb9ftBBREefE7Z
 /GAs51H/egcIosbKc2laA==
UI-OutboundReport: notjunk:1;M01:P0:yLFqJ0ehQHg=;JLvVEPSkbGGAL7uW2M/qfqCT529
 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
 zBfeVq0
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

On 5/29/25 06:05, Ying-Chun Liu (PaulLiu) wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
>=20
> Add EFI_SYSTEM_TABLE_POINTER structure for remote debugger to locate
> the address of EFI_SYSTEM_TABLE.
>=20
> This feature is described in UEFI SPEC version 2.10. Section 18.4.2.
> The implementation ensures support for hardware-assisted debugging and
> provides a standardized mechanism for debuggers to discover the EFI
> system table.
>=20
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
> V2: add Kconfig options to turn on/off this feature.
> V3: make efi_initialize_system_table_pointer() do the job as described.
> V4: use efi_alloc_aligned_pages() for system_table_pointer.
> ---
>   include/efi_api.h             | 16 +++++++++++++++
>   include/efi_loader.h          |  2 ++
>   lib/efi_loader/Kconfig        |  7 +++++++
>   lib/efi_loader/efi_boottime.c | 37 +++++++++++++++++++++++++++++++++++
>   lib/efi_loader/efi_setup.c    |  8 ++++++++
>   5 files changed, 70 insertions(+)
>=20
> diff --git a/include/efi_api.h b/include/efi_api.h
> index eb61eafa028..6c4c1a0cc7b 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -259,6 +259,22 @@ struct efi_capsule_result_variable_header {
>   	efi_status_t capsule_status;
>   } __packed;
>  =20
> +/**
> + * struct efi_system_table_pointer - struct to store the pointer of sys=
tem
> + * table.
> + * @signature: The signature of this struct.
> + * @efi_system_table_base: The physical address of System Table.
> + * @crc32: CRC32 checksum
> + *
> + * This struct is design for hardware debugger to search through memory=
 to
> + * get the address of EFI System Table.
> + */
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
> index 8f9f2bcf1cb..8f065244d8e 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -646,6 +646,8 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb);
>   efi_status_t efi_root_node_register(void);
>   /* Called by bootefi to initialize runtime */
>   efi_status_t efi_initialize_system_table(void);
> +/* Called by bootefi to initialize debug */
> +efi_status_t efi_initialize_system_table_pointer(void);
>   /* efi_runtime_detach() - detach unimplemented runtime functions */
>   void efi_runtime_detach(void);
>   /* efi_convert_pointer() - convert pointer to virtual address */
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 7f02a83e2a2..d878fc9021d 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -71,6 +71,13 @@ config EFI_SECURE_BOOT
>   config EFI_SIGNATURE_SUPPORT
>   	bool
>  =20
> +config EFI_DEBUG_SUPPORT_TABLE
> +	bool "EFI Debug Support Table"
> +	help
> +	  Select this option if you want to setup the EFI Debug Support
> +	  Table which is used by the debug agent or an external debugger to
> +	  determine loaded image information in a quiescent manner.

Please, mention that this also provides the EFI_SYSTEM_TABLE_POINTER.

The symbol should  be called CONFIG_EFI_DEBUG_SUPPORT as it selects more=
=20
than the EFI Debug Support Table.

> +
>   menu "UEFI services"
>  =20
>   config EFI_GET_TIME
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index dbebb37dc04..16e921781e9 100644
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
> @@ -4035,3 +4037,38 @@ efi_status_t efi_initialize_system_table(void)
>  =20
>   	return ret;
>   }
> +
> +/**
> + * efi_initialize_system_table() - Initialize system table pointer
> + *
> + * Return:	status code
> + */
> +efi_status_t efi_initialize_system_table_pointer(void)
> +{
> +	const int size_4MB =3D 0x00400000;
> +	u64 addr;
> +	u32 crc32_value;
> +
> +	/* Allocate configuration table array */
> +	addr =3D (u64)efi_alloc_aligned_pages(sizeof(struct efi_system_table_p=
ointer),
> +					    EFI_RUNTIME_SERVICES_DATA,
> +					    size_4MB);
> +
> +	if (!addr) {
> +		log_err("Installing EFI system table pointer failed\n");
> +		return EFI_OUT_OF_RESOURCES;
> +	}
> +
> +	systab_pointer =3D (struct efi_system_table_pointer *)addr;
> +	memset(systab_pointer, 0, sizeof(struct efi_system_table_pointer));
> +
> +	systab_pointer->signature =3D EFI_SYSTEM_TABLE_SIGNATURE;
> +	systab_pointer->efi_system_table_base =3D (efi_physical_addr_t)&systab=
;
> +
> +	crc32_value =3D crc32(0,
> +			    (const unsigned char *)systab_pointer,
> +			    sizeof(struct efi_system_table_pointer));
> +	systab_pointer->crc32 =3D crc32_value;
> +
> +	return EFI_SUCCESS;
> +}
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index 48f91da5df7..a6b37d994f6 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -278,6 +278,14 @@ efi_status_t efi_init_obj_list(void)
>   	if (ret !=3D EFI_SUCCESS)
>   		goto out;
>  =20
> +	/* Initialize system table pointer */
> +	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT_TABLE)) {

Please, put all code that is enabled by CONFIG_EFI_DEBUG_SUPPORT_TABLE=20
into a separate code module as it is not related to EFI boot services.

Best regards

Heinrich

> +		ret =3D efi_initialize_system_table_pointer();
> +		if (ret !=3D EFI_SUCCESS) {
> +			goto out;
> +		}
> +	}
> +
>   	if (IS_ENABLED(CONFIG_EFI_ECPT)) {
>   		ret =3D efi_ecpt_register();
>   		if (ret !=3D EFI_SUCCESS)


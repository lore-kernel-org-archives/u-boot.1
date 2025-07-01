Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595FDC83038
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 06:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80FCE81FEE;
	Tue,  1 Jul 2025 08:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Veh5kIO7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E567E82ADA; Tue,  1 Jul 2025 08:29:48 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63D7F8006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 08:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751351384; x=1751956184; i=xypron.glpk@gmx.de;
 bh=E2wLUCaaFJoqENuo25AZdcJ8ApAC4hJ1me0vaKfXbiA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Veh5kIO7RexL2eAPxhC3drvzJkaDDf3LSIuvIIDBy1qTR9wEIHe6aXr5WSZErY/F
 Gjvg3WF4Wxac7B4Gm47NN3ABQ+NFQHXM9VyLY45PbVuspPMyiswWqbSgWa7//eBH6
 JLzul6TK8P8XNkCMvfWCk6i//D6pdfr6WWQzjVbf2TDU8/Ttd/9V65P9qfdviXJb4
 DepXxRd14ntiVjAFCCsheEdiEtw11+CnKIfPgIWFhWct05Up0rlQrViiT003piXg4
 1VOPvkyUzx972PSE/F/LG7dff/mHNMjuK3ncIoA0m1Z3z4psEy5auBEPny7iE1MFM
 8y4Wb2ETnQQOKl152A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXXuB-1uD6TI3P0p-00NNx6; Tue, 01
 Jul 2025 08:29:43 +0200
Message-ID: <4d11d143-5262-49f4-8039-b7c8971c95a0@gmx.de>
Date: Tue, 1 Jul 2025 08:29:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/6] efi: add EFI_SYSTEM_TABLE_POINTER for debug
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20250701034926.83536-1-paulliu@debian.org>
 <20250701034926.83536-2-paulliu@debian.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250701034926.83536-2-paulliu@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uJiDn4Ne3Hj7WW3iBeHUq80TgwK1Ko+3YT/SZ0xaxP9QFKEAy93
 E66gWxX/hVXWlmILNlVCftkayL8MbTbn2ROQNKZFIueEE/st7yQ1sKpANrR0wPStPaBPSjL
 5YzOf6jPcuEfXxMi5prdcY/p0ic4dgxvpCFLsjTrJEz92n5K5IPFEqIouqwc9tMIRIeLkE8
 LdnoyJ+MO7mBAIap4xpqw==
UI-OutboundReport: notjunk:1;M01:P0:FkQxqvoTZPU=;g2q70+mz9E7diP++eVsFbK6/Tei
 /uuHpU5FQrmBddD5i2b6D/JH/OUCf7SDp5/Gckiqqppr9EGE795wHGfd3GO5C1lNE86HD3DK3
 EbuZTrFgq+R3TKT55Dl2NTr+oANHe8YpLh35UGeF6nEYH1+9KExiyG60/swanlkdTL0p3o8cA
 hVDxHcdIMQ18d0GhraF++vyB4SnoimTyxmTVPgErnHmutork3Mp+FZbeoWh8McIDeIEUvzBIE
 SWj5R0hE8GeE9hpQXNE97fc15y9NC0h/CcbY/m2L6bnpWzk45sGitkzDkzLIO0Amr3yt3QaKU
 BJuDjq7RMQIHcB4CSVD14oVw1d59JZVwqAFqt6/2SwMpHiz/yo1X1caBeJkpdwIETmuDeqOy7
 VGc/XdzSXbwPqmVGnY2jCUIbmZGXbsr4VDolQgKqEuO0Ho+BgMXWxOhg9d36UL0e9XamapcKl
 yml5HE/5dHAN6IyxpcbNSwRLjnS6mgFWATdIweDTXktUkdRTApmqlS0FJ2/yuvlPFkJwj9p/I
 K40gzMtOqZztsptbd0SA5JuS42ojCIicT2J+xJ9GSwzRkM3y9E2I9HFFoo6V8kMcXpJrPB3VH
 7pkjZTxXsr8zuIxDlBLzKvEzptEi9OmtAejvYZFzgwO/0HRsIxxx0ZBOoDaRwjKcx9tF6Oc16
 +rlJEweqZKALtH96A38cCbOBs20GgRBYt9SxARZKKyljggP16NsnTVLp6z14cXEQESifBLJK+
 sUqbzmw3R1jyKMxiM0Q9Ahvktap/cZPfMDM1T9j+hEIbTdWDke25GfzT4RMCXX3GTpZ0Tc0jm
 Jr1Wma7mLp3hy24tMmqbAPVRxV5OiWJrb8zWg2p+3/zG5LUEGFuo+sXojGeFB9YeTPPjTTNjX
 sZUwYKbajDhYdeQbh7/H4DV4MiKUocD9qAicJAgCrLmPfKQYnPc8meS2DQPEPXlF4UqCb4qPn
 fsCVO3vYAoutUlti8Ir0jGecnUlonYSbonDCeVTIM5znZRraMpaYYyLRo7oixjgUZ/6jUT25q
 XItZSUg+0Q3PLzKlBYzOK8vbl8809e89K//CB5D8+5pNpvneuogZbmlFwpyI2hbs2BTlHfxYv
 96Xk66avtfSoNtHAwIMo+eDFX9wHS4kYrCS9ABQ74KuL3HSwr3TD3ouJTbDeavAwcND68M7jA
 K9bNej+28wkyPoPEnZsLgcPYsuGRqbqqfvvNoRLYG/Z6EOcLEO3sGA1WMzluoND4LmqUDeKHY
 1Y7joB+oUPsbDxKIC/IXK4tGB2IMgKrUVMQzyenL5GTYPThZp4YGYzHHhFvUOpuIDTUL0Pgcw
 HAdlgk/U5LkQVEKGdcA5iS55XsjMz3Cj1ImlwOpOQK9xKCpFt9EvwYAxmGFvuNPzcty45LY/A
 ApxRDDB+3X6GeJVqjW7kydg9NejFoK2Y1CU2olIEPFZL5qa1+cyyu598GonPo3LLp8QqqIpRT
 8H0uZ8wRSy6awfA7pIm6HnusiOLccAMlI9CAIHJgtNi3nYvVGq9YqZaoQTSIl406QhxamrskC
 Tyh1S1crfE25mFhG+xK4/sh3NQZvzCPkKC4bc9JtL99flZcR6l3LD5eY+QSDf1fyHdnEzhPRk
 m/A/+lVgnybahfiR4JdrdhUQfW4Z33E5sTvjpYZDnx/B5upUSeJvwFALd9W6woEX5qJTk17Iq
 RUARWOZQrWyHvWxC5jNMDbE5xDz78ZjlErvbUesElOfu+weE56hJkYdnR3iAKXdhJccgGjiOO
 hCXsrSct1rpl05MqItiZUGlFrPeWkUzpXGAzpYeKy7EUwbOT+71ZJGa7noRXLXp+pAamjSYmP
 SM3eTw7iSmJjO3NTmy+dxmrL0B4Bus3EOOoTRHOaaQBoqvLQ/Er1tCFDB0r/geOoAa6yt27G3
 5ka/5zC856Pe5F2qV7BeColh4dVPB+3V/sswXsrHa7U/IUFgSIgC69WvV50T8HkId7gTmrbyX
 JDN6rpGjuKB6/zNHGR1I2mhpBAExxbpTQRMasAtdebDfkAiZEMQ0dK+gUbcTVDzP+4VFsTRAh
 Dn2c0x4zrp0NM1ITVI8FjO0wqrTO9FlIUkSQKCUKkZzjxAT+wFaXMR5C71ILG4g2BhcAbjND5
 CSOBgkz9AoTsKN3jhJ4xFFHnT0q0+65CmNnNmu8/ggJU4WFDim/egaxPGsMvD0x5pMR+GdiD9
 AxeFlqNJSnPp4xRUjlD/ujJKtpn7g2Ll5oJxfeYzFrlNebCZXjnZbGF4+QJ2jGdq30bxJxame
 WvvvJ0qP2Aee6kvL8Z9YH/1Wwbf9vR4MwfbcU984ggNHM2JjJr9qfa47fh+9MWGAmKcH+clmd
 E8HCgy+g0yhDj+dNyuIKSUf5xSN8vm7XbgBpAXelbcSoKLF5hwREf0GIAFpFMVt6n514ypcL5
 W2B5CIiy/TRe5SMiucfT7qMdhF2dJ8vFMlCxKJnwJZ7EEdOsPtb6rk8wKIR0WcNAbiKaiDO80
 UvnL5+yjXZWdZ1zh+QmXWMnPIcqP7ooR3cnllIGZ53ksyzFXZj7ZxJBSlTSrBit31jWbyc1X2
 0kaVvnNvWuyDIqN54pIPL49h1j8FXHoNj3y0CV7xY6T9NKt+6iIWNrTYeCnOTKttpjNPPmmaG
 MAGkjhb5D7Q8ofRDL4z9RjmyOj+o7VAy4hgNm+BZSg0V2t8f9eW9YKKOqNHa6aklEa/ZBrFMt
 Lagh9s3RqgZWO8Y6CQVQ0Bs8XxwykWUBbTSXXi0Mq7qB2MxymVFdHKRdPBrxXQj62qtEUCwuQ
 kJXJcyMuqNKkJwcCHe/te5K+c3Nv6bRDiI/LOKYCla32Eukozs0yrcO8j0f13r9yrseRKILq+
 oay++qG4Sk09blHJu/YO/8IxSb5YZDcL6/topGuVpM7dbR4zEhJPSBFSXULB1HeBNz9hcdzAf
 u+EohTdNcdEuPVr9CRoKNPhxmvWNHNyw22pA8VctHzfXmCzPaZ0ARlOI9SHSNj5/lXu6X8J6Q
 u49T3zy5VppA2pTI/Ohq1Cj9Um946YuPf0hU6mzbRJFCWKtzpa+aFUFNkJL4xNrv0kI4u1Ntl
 dW5BT6Q8N//KGmDl7FsuJvfITmssDJ4rZfYqIUrqf3IKj6en9BHi/w0fLceJpXSQQrQj9IPRK
 XvfsbwIEWgebSF2UgWYSCDiI2XzmI0jZU4gMse2V+DI0fNk5ib4ESX9nIKCQ4zpnE2WvyaEtX
 y+EiF9pTRxUwLLeG74Wan5kaZTGtQIjM/XcBuQoDuqO2Y3JxzGP/shZ3BbK777sGmymFw6m8U
 82tVBiNy+VzuU/gkA2FzNm9V54PycCuot5FCzX2j0sQlqcYT51L2e9L8ny6PY51nXWnj9Dyte
 hwqyYf56MmanIEvbGjYSM1hMvUIUdKejTTZipGerXGik8SP2mhyFy9jSDqp9NqzFDOm83HEhm
 tr0IujgI/dann0CKS+b1pxXkva2qknYQ+jYgLS0A1zktA2UdWzS1s1gehU04tE8OLBlwZX3Dr
 cX6GCIIO6mxt8YkCIdZ7h1UCtoAp4CPOBWZTycCPdiCRUwjkh5ELouaAg1TDJC41VgwS6qmha
 GW+nRGrwDifavg96B45ZwV5nxu2wzqNQiLfdsM7CV4Y/
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

On 01.07.25 05:49, Ying-Chun Liu (PaulLiu) wrote:
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
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
> V2: add Kconfig options to turn on/off this feature.
> V3: make efi_initialize_system_table_pointer() do the job as described.
> V4: use efi_alloc_aligned_pages() for system_table_pointer.
> V5: move the code into a separate module.
> V6: Use macros to replace size_4MB
> V7: Fix the code based on the review. Update license field.
> ---
>   include/efi_api.h                  | 16 ++++++++++++
>   include/efi_loader.h               |  2 ++
>   lib/efi_loader/Kconfig             |  8 ++++++
>   lib/efi_loader/Makefile            |  1 +
>   lib/efi_loader/efi_debug_support.c | 40 ++++++++++++++++++++++++++++++
>   lib/efi_loader/efi_setup.c         |  7 ++++++
>   6 files changed, 74 insertions(+)
>   create mode 100644 lib/efi_loader/efi_debug_support.c
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
> index 7f02a83e2a2..f9d75cbc3fd 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -71,6 +71,14 @@ config EFI_SECURE_BOOT
>   config EFI_SIGNATURE_SUPPORT
>   	bool
>  =20
> +config EFI_DEBUG_SUPPORT
> +	bool "EFI Debug Support"
> +	help
> +	  Select this option if you want to setup the EFI Debug Support
> +	  Table and the EFI_SYSTEM_TABLE_POINTER which is used by the debug
> +	  agent or an external debugger to determine loaded image information
> +	  in a quiescent manner.
> +
>   menu "UEFI services"
>  =20
>   config EFI_GET_TIME
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index cf050e5385d..51ccf1cd87e 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -70,6 +70,7 @@ obj-$(CONFIG_EFI_RISCV_BOOT_PROTOCOL) +=3D efi_riscv.o
>   obj-$(CONFIG_EFI_LOAD_FILE2_INITRD) +=3D efi_load_initrd.o
>   obj-$(CONFIG_EFI_SIGNATURE_SUPPORT) +=3D efi_signature.o
>   obj-$(CONFIG_EFI_ECPT) +=3D efi_conformance.o
> +obj-$(CONFIG_EFI_DEBUG_SUPPORT) +=3D efi_debug_support.o
>  =20
>   EFI_VAR_SEED_FILE :=3D $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
>   $(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
> diff --git a/lib/efi_loader/efi_debug_support.c b/lib/efi_loader/efi_deb=
ug_support.c
> new file mode 100644
> index 00000000000..c9773feaa5b
> --- /dev/null
> +++ b/lib/efi_loader/efi_debug_support.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * EFI debug support
> + *
> + * Copyright (c) 2025 Ying-Chun Liu, Linaro Ltd. <paul.liu@linaro.org>
> + */
> +
> +#include <efi_loader.h>
> +#include <linux/sizes.h>
> +#include <u-boot/crc.h>
> +
> +struct efi_system_table_pointer __efi_runtime_data * systab_pointer =3D=
 NULL;
> +
> +/**
> + * efi_initialize_system_table_pointer() - Initialize system table poin=
ter
> + *
> + * Return:	status code
> + */
> +efi_status_t efi_initialize_system_table_pointer(void)
> +{
> +	/* Allocate efi_system_table_pointer structure with 4MB alignment. */
> +	systab_pointer =3D efi_alloc_aligned_pages(sizeof(struct efi_system_ta=
ble_pointer),
> +						 EFI_RUNTIME_SERVICES_DATA,
> +						 SZ_4M);
> +
> +	if (!systab_pointer) {
> +		log_err("Installing EFI system table pointer failed\n");
> +		return EFI_OUT_OF_RESOURCES;
> +	}
> +
> +	memset(systab_pointer, 0, sizeof(struct efi_system_table_pointer));
> +
> +	systab_pointer->signature =3D EFI_SYSTEM_TABLE_SIGNATURE;
> +	systab_pointer->efi_system_table_base =3D (efi_physical_addr_t)&systab=
;
> +	systab_pointer->crc32 =3D crc32(0,
> +				      (const unsigned char *)systab_pointer,
> +				      sizeof(struct efi_system_table_pointer));
> +
> +	return EFI_SUCCESS;
> +}
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index 48f91da5df7..78c5059256a 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -278,6 +278,13 @@ efi_status_t efi_init_obj_list(void)
>   	if (ret !=3D EFI_SUCCESS)
>   		goto out;
>  =20
> +	/* Initialize system table pointer */
> +	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT)) {
> +		ret =3D efi_initialize_system_table_pointer();
> +		if (ret !=3D EFI_SUCCESS)
> +			goto out;
> +	}
> +
>   	if (IS_ENABLED(CONFIG_EFI_ECPT)) {
>   		ret =3D efi_ecpt_register();
>   		if (ret !=3D EFI_SUCCESS)

In the EFI shell I found:

RT_Data    00000000BDC00000-00000000BDC00FFF 0000000000000001=20
8000000000000008

And in gdb:

(gdb) p/x *(char[80]*)0x00000000bdc00000
$1 =3D {0x49, 0x42, 0x49, 0x20, 0x53, 0x59, 0x53, 0x54, 0xd0, 0xdf, 0x6b,=
=20
0xbf, 0x0, 0x0, 0x0, 0x0, 0x1d, 0x9a, 0x19, 0x33,
   0x0 <repeats 60 times>}

(gdb) p/x *(char[16]*)0xbf6bdfd0
$2 =3D {0x49, 0x42, 0x49, 0x20, 0x53, 0x59, 0x53, 0x54, 0x6e, 0x0, 0x2,=20
0x0, 0x78, 0x0, 0x0, 0x0}
(gdb) p *(char[16]*)0xbf6bdfd0
$3 =3D "IBI SYSTn\000\002\000x\000\000"

This matches EFI_SYSTEM_TABLE_SIGNATURE 0x5453595320494249.

Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC7BC8302F
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 07:17:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAD1681FEE;
	Tue,  1 Jul 2025 09:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="krjXZaDd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F40382ADA; Tue,  1 Jul 2025 09:17:53 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1EA38006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 09:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751354267; x=1751959067; i=xypron.glpk@gmx.de;
 bh=0R7KiLL1Us4mqORN0anrg2qus89R+POO+yHApUcryDk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=krjXZaDdY/Kt2Czxv3c8bE+xl0nS5BmeKpVEyN7d0AEeCq0cv0tjRobjoj+iBma9
 3z9eAW60QjTFKidkouPK9yQgqYY4cKvQqvZiLO163ZzNGvQ/k3X6tH/DInlOkieFR
 8eFYHwR36c7m5NRSRUu2xh3Bt6NClcEQs4cvvzTI/gTgwAdLpXCj4ESCfjJPa+O92
 tHckgy8OOiKEnlkRhXcSbFg+BkJ3uHJzHoxucLkJRUqM6Um43fqIlsVPPHWMBJIW9
 EV2T+jg3XS87sZrAaHsdowy9yBLBV2tlsl0+5SUzUpyAZRKNxYzj0lMsHvTRkggYk
 exTCfGlKrPpxpYVdjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMobU-1uG4rO3j6q-00Qee5; Tue, 01
 Jul 2025 09:17:46 +0200
Message-ID: <445c9cd7-e02c-4b5e-ac9e-16683d45368d@gmx.de>
Date: Tue, 1 Jul 2025 09:17:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/6] efi: selftest: add selftest for EFI_DEBUG_SUPPORT
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20250701034926.83536-1-paulliu@debian.org>
 <20250701034926.83536-6-paulliu@debian.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250701034926.83536-6-paulliu@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t+/B6s/o0rluriw5tJg2ApgRr86rlj1DGUgYW+X60YqYmKDp3NC
 +y4HBegvCvUki+cKAtGjmfqt41j7uqDQ3ud1u6Xxo11trRRKSBxuU3p5VPoX1WbUirI41mW
 qt7eSHN5twTlljuxWI1/LFaeZYCX9qj091ZHJHYF9nmutMztTNwBLF7CKX+k5AIa4h4VPhY
 Ikyv2UHxT+9A1dshKWffg==
UI-OutboundReport: notjunk:1;M01:P0:1PrhDDVhDq4=;CPFb2o6fM+TdoJMlz+SUquIuBAs
 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
 Ww==
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
> Add selftest to check the installed configuration table that has
> the correct GUID.
>=20
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> V7: add selftest for EFI_DEBUG_SUPPORT
> ---
>   lib/efi_selftest/Makefile                     |  2 +
>   lib/efi_selftest/efi_selftest_debug_support.c | 58 +++++++++++++++++++
>   2 files changed, 60 insertions(+)
>   create mode 100644 lib/efi_selftest/efi_selftest_debug_support.c
>=20
> diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
> index d78bf7d6191..842433f68aa 100644
> --- a/lib/efi_selftest/Makefile
> +++ b/lib/efi_selftest/Makefile
> @@ -78,6 +78,8 @@ endif
>  =20
>   obj-$(CONFIG_EFI_ESRT) +=3D efi_selftest_esrt.o
>  =20
> +obj-$(CONFIG_EFI_DEBUG_SUPPORT) +=3D efi_selftest_debug_support.o
> +
>   targets +=3D \
>   efi_miniapp_file_image_exception.h \
>   efi_miniapp_file_image_exit.h \
> diff --git a/lib/efi_selftest/efi_selftest_debug_support.c b/lib/efi_sel=
ftest/efi_selftest_debug_support.c
> new file mode 100644
> index 00000000000..9cfa44c05a2
> --- /dev/null
> +++ b/lib/efi_selftest/efi_selftest_debug_support.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * efi_selftest_debug_support
> + *
> + * Copyright (c) 2025 Ying-Chun Liu, Linaro Ltd. <paul.liu@linaro.org>
> + *
> + * Test the EFI_DEBUG_SUPPORT
> + */
> +
> +#include <efi_loader.h>
> +#include <efi_selftest.h>
> +
> +static const struct efi_system_table *local_systable;
> +
> +/**
> + * efi_st_debug_support_setup() - setup test
> + *
> + * @handle:	handle of the loaded image
> + * @systable:	system table
> + * Return:	status code
> + */
> +static int efi_st_debug_support_setup(const efi_handle_t img_handle,
> +				      const struct efi_system_table *systable)
> +{
> +	local_systable =3D systable;
> +
> +	return EFI_ST_SUCCESS;
> +}

Thanks for adding a unit test.

The setup function is not needed. You can access st_systable in the=20
execute function. The variable is set here:

lib/efi_selftest/efi_selftest.c:260:    st_systable =3D systab;

> +
> +/**
> + * efi_st_debug_support_execute() - execute test
> + *
> + * Test EFI_DEBUG_SUPPORT tables.
> + *
> + * Return:	status code
> + */
> +static int efi_st_debug_support_execute(void)
> +{
> +	struct efi_debug_image_info_table_header *efi_st_debug_info_table_head=
er =3D NULL;
> +	efi_guid_t efi_debug_image_info_table_guid =3D EFI_DEBUG_IMAGE_INFO_TA=
BLE_GUID;
> +
> +	/* find EFI_DEBUG_IMAGE_INFO_TABLE */

Please, use efi_st_get_config_table().

> +	for (int idx =3D 0; idx < local_systable->nr_tables; idx++)
> +		if (!guidcmp(&efi_debug_image_info_table_guid, &local_systable->table=
s[idx].guid))
> +			efi_st_debug_info_table_header =3D local_systable->tables[idx].table=
;
> +
> +	if (!efi_st_debug_info_table_header)

Please, add an error message, e.g.

efi_st_error("Missing EFI_DEBUG_IMAGE_INFO_TABLE\n");

If we would load EFI binaries like efi_selftest_miniapp_exit.efi here,=20
we could check that the table is correctly updated. But that can be=20
added later. My testing using dbginfodump.efi showed a reasonable content.

Best regards

Heinrich

> +		return EFI_ST_FAILURE;
> +
> +	return EFI_ST_SUCCESS;
> +}
> +
> +EFI_UNIT_TEST(debug_support) =3D {
> +	.name =3D "debug_support",
> +	.phase =3D EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
> +	.execute =3D efi_st_debug_support_execute,
> +	.setup =3D efi_st_debug_support_setup,
> +};


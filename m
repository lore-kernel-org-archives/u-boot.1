Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17E0C77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 07:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E631B81FEE;
	Thu,  3 Jul 2025 09:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="sbHRy7wj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF92282063; Thu,  3 Jul 2025 09:21:31 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DECB980194
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 09:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751527284; x=1752132084; i=xypron.glpk@gmx.de;
 bh=vknHKtTk39Kii7XUtTOriqUJ3seVnqnVY8Dl7xomxvk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=sbHRy7wjQoFZ2w/dDcsVHTT8qR2MY4BI5OQKlPUj00Z9DqgboilBUr7+6WARb2SY
 /CoQOz17XmB/j9zLyZ7GoS2TreRblNMhdB7EDPb/lZK8+y9TIcc1m4QYJvbV9EF/X
 kXmb1nRZ7wyBRi8pTdDT5xmTDC9nbvd024RKHy4Ka4raSsvgLzA2byivY+JP3iRv1
 jugJ9vy8qRmFDAcgshxCNRjgxWn2ux/B4Mq53pPCHfv601OUAK9JAvFv0IkK8kIn4
 LOEKiR7/MmjUK16Uc3Ddjyt7LyA5pXzv2sJR2mRd3UV9nBmLU9geE1Wh4UzslnHLr
 +YQmeJWsdWWGe/5JkQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSc1L-1u9KVp0zMX-00Qyq7; Thu, 03
 Jul 2025 09:21:24 +0200
Message-ID: <ac046147-c1f2-4600-b846-b530c0b07c85@gmx.de>
Date: Thu, 3 Jul 2025 09:21:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] efi: selftest: add selftest for EFI_DEBUG_SUPPORT
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20250703062811.72871-1-paulliu@debian.org>
 <20250703062811.72871-6-paulliu@debian.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250703062811.72871-6-paulliu@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8fUqXcn3SjyvRW7KeG5OUDcxzcYf/z1R882lJ2BuQ6qLedXen0Z
 gOf1edx6gair28MW1c5wN34B7xRlNgMPcna7OYR2ASTNSVssHtiTPVJKQzogWtzZkUruWNs
 Ss+U2NI0cl81g48H1tQcEHQmnMatkoiA7tHg7PBxqIWu94SYjDmEJSPp4NvS0uYhKKbvkVk
 33BuKy7kKny0tqh0jYDUA==
UI-OutboundReport: notjunk:1;M01:P0:xc9dUqlfzaA=;TpJl/ZuX0eHiyCe6YNICzyPlEm+
 +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
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

On 03.07.25 08:28, Ying-Chun Liu (PaulLiu) wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
>=20
> Add selftest to check the installed configuration table that has
> the correct GUID.
>=20
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
> V7: add selftest for EFI_DEBUG_SUPPORT
> V8: refine the selftest.
> ---
>   lib/efi_selftest/Makefile                     |  2 +
>   lib/efi_selftest/efi_selftest_debug_support.c | 40 +++++++++++++++++++
>   2 files changed, 42 insertions(+)
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
> index 00000000000..9ca8b3f82f5
> --- /dev/null
> +++ b/lib/efi_selftest/efi_selftest_debug_support.c
> @@ -0,0 +1,40 @@
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
> +	/* get EFI_DEBUG_IMAGE_INFO_TABLE */
> +	efi_st_debug_info_table_header =3D efi_st_get_config_table(&efi_debug_=
image_info_table_guid);
> +
> +	if (!efi_st_debug_info_table_header) {
> +		efi_st_error("Missing EFI_DEBUG_IMAGE_INFO_TABLE\n");
> +		return EFI_ST_FAILURE;
> +	}
> +
> +	return EFI_ST_SUCCESS;
> +}
> +
> +EFI_UNIT_TEST(debug_support) =3D {
> +	.name =3D "debug_support",
> +	.phase =3D EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
> +	.execute =3D efi_st_debug_support_execute,
> +};


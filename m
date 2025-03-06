Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC2FC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 15:16:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA44580F4C;
	Thu,  6 Mar 2025 16:16:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ItSiHVWU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B3A780FE1; Thu,  6 Mar 2025 16:16:55 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63325808A2
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 16:16:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1741274213; x=1741879013; i=xypron.glpk@gmx.de;
 bh=+BEhKnf+yRbtbdfhNpWnJx9r6RQwiVP0FN0JSY6+dwg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ItSiHVWUltgJh5MJFRHGlV7s5ciVe5IOZeY9zAuphvpaUfK0tPjJdCtKUZYVgFEg
 2h309uhuePlG+gSOzPgIAfwNKhTBTVQPJOccQDnV5bEAQA1wDZkAFI+d8euiZs1aJ
 gOriu7uxA3BljXvCeBOpI3yvrc+Pinnjfzp+oRvIy9hjP8rZYYpe+oYdVHD6UnTeb
 IFduCJSLm8uoljhgjVsAP9Il3+jqj3F21dCZEfd3jF7Yisc72ZsIZ0Siu7aFWaMbl
 /aHrW0fZgII7Lmtl/FkSa3vATqqx49QDlm1BmEM/8CpFnzOnVNe7YzT9byEVJ3klY
 HpE6C+h9Ss7ZNheYxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAfUo-1twlTA4Abg-004Yiu; Thu, 06
 Mar 2025 16:16:53 +0100
Message-ID: <9985f2c2-5ad3-403f-be76-46350e69138c@gmx.de>
Date: Thu, 6 Mar 2025 16:16:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Install the ACPI table from the bloblist
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250306143134.2549815-1-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250306143134.2549815-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wj3PGlpL3w/0sl8icySGpf+GDuWb73f0IAOpTQOBd7l0l/PzSSR
 ERkj20MD30Ov4ZclaCv2zRlz276Fm75m3UHZXoIcAdstGsYGwD51jLf4yxY95UZ7KbTSUnx
 0ASBywJegq4tPsjIdntrnMo+njeCIiVrCgCFTRfckA5lKwQbOK5dkdzEplD7y39uwrE1hqc
 bji/YUuLJ2WT0C1xK2jCQ==
UI-OutboundReport: notjunk:1;M01:P0:tAS+Lyk7JDI=;m90d/F9amx2mc+KJNGeRAunQbhZ
 /BAcThrsGyn1UChuKx0ouny+AlO1GF6GqLfki4p7AuxiMBejVwcoTlGZ5tcOilsZhbKuKNNqX
 ju87Ko2hlclZSe2GabJsGmP/KXH4miMR/E4tvrKmUZRVU7WdMzazbYbaJkagl1WIVDsvuaU+/
 PkSWu6lkZO8yPNyFxMYHvmNi4dhWlVXZAy5tPiX+552EkClEbuq8i1tkVn0kZyt0V+UC1EuX7
 eDNbeCeSaQRTAWGCJdEd/ufhfqFJIyHSRxA+3eltvKUKm1vEBKL27pH5rfQ2m9cK08AJVz0K9
 YvRmB/FkgID4MVOIWaAZn/W7uuJqdnyadqwc1sUlI0xcApTyqOH/hDSYHj0VIoLh4SoGbw0IT
 Bt8MsBe6NjrBjZ7Av+IkJfBZyW3drLebRQ4qovgLppvP6Yl55P+UEN/5R8rQCjzwniP71s9Vt
 JQOGjfluCD8U75zZgtb4ZyFgNLg7bLlIrOVy02JsjMS6wfuNZTTcDSkFGB5gS5nqtniZNIjfB
 O7Fx7EWtlljq9i5mRchP7EEA0u7KypnfejUpanzgA++Q+UanxYx0RGix9a7TvJ5b0g70bzLbh
 gfoqvA4wb7ovhGplAzoZrQ6DoE6KGI18aE7iY5nvJ9i28z3TuRazjr/asq/Qm2DoFZHUCk6+U
 dbz5Tx1zVQMMAGHAC3Ikb2LSuXhBSVMdEo70PgwC6yOqb2IyguhLvbC3XAdVt7iVJyMoqSai1
 Fd7S9ykFF8j+k87Kc3QyykJXPSfc5MFEWGasNsAb4RCo4cvBm0ac9REgZFe/HP+MLhH7vzfcS
 NVu4XtFbczm65ATIAecdm+9P3HNne1I/YAHv4f8QBlIiJh9jsuGG2nD6m7cjfDGweV25r2MSD
 cGh4Bm9uci32wN9ebkoV/fr6TGCkHLS9YYSKGGIH2cfzBHn6LI1RW/sw2kk0eKILSz8YXmgso
 9RNYDa0u820d99UNnB4s+HPve+CRxPG2C8ev9USOCT7Gy9YH343PMOR9tka53oQ5I73ifUVc7
 nlEk3xFTt02ooOiLY5Q2YfhKYBA/9hJnRm2OdgzEQijpsKU+RP4K94QcHtcEuxKCMEjebdmQ3
 4fTBiacLN4ria2rQ3un0pWM+HVZ2uwbZONbcwpc9FrUszVCdFnTv/h8jAT3UvFMygxeiMi8H2
 1Sq+eXyDtD99HY6/ZO47X6Ju7rMvDZjo14BUZixUAW2VrEKlM8oAXqDf07rjuPxH0T1e/w+rb
 Lwrpk04o4oZtXUgLqxb0iDsGY78yukgkPzzn1soRuEwswlLBzVfJuA0UYQIFlN5G2BmCfnA/A
 fNoOFjTR9pN4jpb4N1ErY67tppg30Im4lpXN5I7Sd3Qy0oLSnel6jv7RF7bDesYwo7vKvPVas
 jHFhXKAiv+znhRzZ5oREJu0uoGsihQ4cRmM9Z/AE7+spYIHFHFL/i7NFlp
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

On 06.03.25 15:31, Simon Glass wrote:
> When BLOBLIST_TABLES is used, the ACPI tables are not currently added to
> the list of EFI tables. While we don't want to create a new memory

EFI tables are added by InstallConfigurationTable().

It seems this patch is not about the list of EFI configuration tables
but about the EFI memory map.

Could you, please, update the commit message accordingly.

> region, we do want to tell EFI about the tables.
>
> Fix this by covering this case. At some point the non-bloblist code can
> likely be removed.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 3da59ee9579 ("efi_loader: Avoid mapping the ACPI tables twice")
> ---
>
>   lib/efi_loader/efi_acpi.c | 44 ++++++++++++++++++++++++++-------------
>   1 file changed, 30 insertions(+), 14 deletions(-)
>
> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> index ff305a6b13e..b8b3a3670da 100644
> --- a/lib/efi_loader/efi_acpi.c
> +++ b/lib/efi_loader/efi_acpi.c
> @@ -5,6 +5,9 @@
>    *  Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
>    */
>
> +#define LOG_CATEGORY LOGC_ACPI
> +
> +#include <bloblist.h>
>   #include <efi_loader.h>
>   #include <log.h>
>   #include <mapmem.h>
> @@ -32,25 +35,38 @@ efi_status_t efi_acpi_register(void)
>   	 * add_u_boot_and_runtime(). At some point that function could create=
 a
>   	 * more detailed map.
>   	 */
> -	if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
> -		return EFI_SUCCESS;
> -
> -	/* Mark space used for tables */
> -	start =3D ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
> -	end =3D ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
> -	ret =3D efi_add_memory_map(start, end - start, EFI_ACPI_RECLAIM_MEMORY=
);
> -	if (ret !=3D EFI_SUCCESS)
> -		return ret;
> -	if (gd->arch.table_start_high) {
> -		start =3D ALIGN_DOWN(gd->arch.table_start_high, EFI_PAGE_MASK);
> -		end =3D ALIGN(gd->arch.table_end_high, EFI_PAGE_MASK);
> +	if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
> +		int size;
> +		void *tab =3D bloblist_get_blob(BLOBLISTT_ACPI_TABLES, &size);

Why don't you set gd->arch.table_* in the bloblist case?
Wouldn't this be an easier fix?

Best regards

Heinrich

> +
> +		if (!tab)
> +			return EFI_NOT_FOUND;
> +		addr =3D map_to_sysmem(tab);
> +
> +		ret =3D efi_add_memory_map(addr, size,
> +					 EFI_ACPI_RECLAIM_MEMORY);
> +		if (ret !=3D EFI_SUCCESS)
> +			return ret;
> +	} else {
> +		/* Mark space used for tables */
> +		start =3D ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
> +		end =3D ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
>   		ret =3D efi_add_memory_map(start, end - start,
>   					 EFI_ACPI_RECLAIM_MEMORY);
>   		if (ret !=3D EFI_SUCCESS)
>   			return ret;
> -	}
> +		if (gd->arch.table_start_high) {
> +			start =3D ALIGN_DOWN(gd->arch.table_start_high,
> +					   EFI_PAGE_MASK);
> +			end =3D ALIGN(gd->arch.table_end_high, EFI_PAGE_MASK);
> +			ret =3D efi_add_memory_map(start, end - start,
> +						 EFI_ACPI_RECLAIM_MEMORY);
> +			if (ret !=3D EFI_SUCCESS)
> +				return ret;
> +		}
>
> -	addr =3D gd_acpi_start();
> +		addr =3D gd_acpi_start();
> +	}
>   	log_debug("EFI using ACPI tables at %lx\n", addr);
>
>   	/* And expose them to our EFI payload */


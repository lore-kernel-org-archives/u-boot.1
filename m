Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15BBC54FB9
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 11:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE4A7875B5;
	Tue, 21 Nov 2023 12:59:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="IPbEGrlW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F079187545; Tue, 21 Nov 2023 12:59:07 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD9E4875B8
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 12:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700567942; x=1701172742; i=xypron.glpk@gmx.de;
 bh=SxYLZRpTULJNT4octy56k8jxUJNYnifJE7zOUVc+HnQ=;
 h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:
 In-Reply-To;
 b=IPbEGrlWQl6yh2GueoFGLvkYHT/rQauIfTVE9lS5bPkOa162lzngc2jSsvDyAumb
 q95uJITFpuWltaNcOK3papCRxSS86rkAYdYxWKxAw99tZVXv2sKThFPy55riFRTEV
 NXMf6xjJFu0sNPgcLDBeMdPVDql+QPLkSiaPtv1wKWHBwVzA8HbkKVQ2+8Hl4rhB+
 p91izmMC3fBIh1neZBKEtTwmdZxCgUAenoDisYIUI9XgVJf1MAxmaVdszs3ov0S+s
 qVkiGDRTJ7G/yS2jf4ZhrssoczQjQxSRk4+ggm/GSQjF7rBerRJ+CkDGc4ZSlwhsG
 rMJ8OrSByYT5y0K7eQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhhN-1rDy7t07fT-00AqQs; Tue, 21
 Nov 2023 12:59:02 +0100
Message-ID: <f1cdc9cc-5c41-4d91-939c-2448b4d735d4@gmx.de>
Date: Tue, 21 Nov 2023 12:58:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 1/3] efi: Collect the ACPI tables in the app
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231112205516.183410-1-sjg@chromium.org>
 <20231112205516.183410-2-sjg@chromium.org>
Content-Language: en-US, de-DE
In-Reply-To: <20231112205516.183410-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g7YoaV9yuoVYsoyV9HNszQOAhpekkJCTx/Elh6OdibyuaiOlFYt
 VhDAnvPvKI7oFclLb7JUbRD96kR+u6R1ahJRyrGPeryhwfW9i8iFjX25yTq/PwrYuMGyGjK
 TpOI4ui++J8yBr6fF0jmjZkaxrXyagKLJXlMopj+IASz32p0OjVOi3UnMSxEPtuA5Lxfhh3
 uMauNxbuEILDkFKC5bYjw==
UI-OutboundReport: notjunk:1;M01:P0:SegqXWioTpg=;ilCfcPJ1UklqImOJtBbNwE+FW5m
 kQom2AcS078buNPj6L+Hdv6PIJdyk3wXq3eE25GBhpOKs1NmyDxkH/Z6u1tDV0C8mHZ7oT7TH
 KdDvYD4qUCeflrKuTiGHTQWhv9SPWHNIIwAgsTf6woqC126Xvym0LMxDVj1dYrYEhx4oPo+Eu
 YBBPyNnu+6xLJp9dXON3hDxpuKZnbgmhVpZKrZyzrP8rDCJ206S2TA1TyZivTXJqg3Ys5xmLL
 z8eb9HZBAgSOEVgpbYD+eDfuIkCrrJ+y12bxFKSGnIoYxAgXwuWc5TebGSqWi6sNvOtOxmE3j
 dE09w2NSj6wDBpug4nuEKkDgSgqttUSrlOfpyPJQIMQDxR6frUdJAgdJcNn5Zw3uor/BZ2BJB
 lORG9wsVNi+GXfk4hO6LqGSdXNqoHf/Nkqhc5f+P9lxCwiRgl0DDHGtR9ZI6jURG/oBT5jV7L
 2JL6kg5FjnfaWWuZmH1L5pLk8Pv4UmZ/TUeHoKmYm4FtEZP1dc+olKtRCZI7MPbd0+i7eBk4r
 0DvQsPLa2HgaH/Qii9uzl9MZMU4ec72LIq1D/8UHQM7KRiNreq4+Gd6Hqpq3cvkvkOnaccnfG
 9kA6RT7ffaYWyCOmLtWt/Kg4dOOHwK7x8b85C2XyuMFUhUqE+5YzvUsXBylPw4bADkAQYEbvq
 cNhYu/jLz3QmaWCJHbXX7sklyxLM2N0t5JvYXn316GTRraPl/27Y3/UOiw62whHP/2tsE9BNd
 X9KTiV/UVOhgsP23d5Xe9KfIf5f6fZ7pvoIABhG8lABKkHQG2+Gr644HktShUv/7YFkvUOyAB
 u1enLtqNZLiFKVuubUndudwQo1/Hm0IpqKeyDwb7AYn89fGpqlLbVGgEebS4U2FGwXJnOHtiQ
 frOqGosqwbZz2n8qfINHeKcHZDiu4t6+gcTPbLM5ps0lvAbNLre+wvgh68752B94Sqc9TCedU
 ZEdqnrxOO0LbPF8oxlCJWxGF7dM=
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

On 11/12/23 21:55, Simon Glass wrote:
> Locate these so that they can be displayed using the 'acpi' command.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   lib/efi/efi_app.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/lib/efi/efi_app.c b/lib/efi/efi_app.c
> index 2209410f35b5..c5eb816655ea 100644
> --- a/lib/efi/efi_app.c
> +++ b/lib/efi/efi_app.c
> @@ -12,18 +12,21 @@
>   #include <cpu_func.h>
>   #include <debug_uart.h>
>   #include <dm.h>
> +#include <efi.h>
> +#include <efi_api.h>
>   #include <errno.h>
>   #include <init.h>
>   #include <malloc.h>
> +#include <sysreset.h>
> +#include <uuid.h>
>   #include <asm/global_data.h>
>   #include <linux/err.h>
>   #include <linux/types.h>
> -#include <efi.h>
> -#include <efi_api.h>
> -#include <sysreset.h>
> +#include <asm/global_data.h>
>   #include <dm/device-internal.h>
>   #include <dm/lists.h>
>   #include <dm/root.h>
> +#include <mapmem.h>
>
>   DECLARE_GLOBAL_DATA_PTR;
>
> @@ -320,6 +323,19 @@ int dm_scan_other(bool pre_reloc_only)
>   	return 0;
>   }
>
> +static void scan_tables(struct efi_system_table *sys_table)
> +{
> +	efi_guid_t acpi =3D EFI_ACPI_TABLE_GUID;
> +	uint i;
> +
> +	for (i =3D 0; i < sys_table->nr_tables; i++) {
> +		struct efi_configuration_table *tab =3D &sys_table->tables[i];

In cmd/bootefi we have a static function get_config_table() I guess we
should export and move it to lib/.

> +
> +		if (!memcmp(&tab->guid, &acpi, sizeof(efi_guid_t)))
> +			gd_set_acpi_start(map_to_sysmem(tab->table));

return; could be added here to shorten the search.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> +	}
> +}
> +
>   /**
>    * efi_main() - Start an EFI image
>    *
> @@ -354,6 +370,8 @@ efi_status_t EFIAPI efi_main(efi_handle_t image,
>   		return ret;
>   	}
>
> +	scan_tables(priv->sys_table);
> +
>   	/*
>   	 * We could store the EFI memory map here, but it changes all the tim=
e,
>   	 * so this is only useful for debugging.


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DF9D13570
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 06:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFF1988FD9;
	Mon, 28 Oct 2024 07:57:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hnYsiZUo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF7E488FE3; Mon, 28 Oct 2024 07:57:25 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5E9A8887A
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 07:57:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730098640; x=1730703440; i=xypron.glpk@gmx.de;
 bh=+eTS6Z0vqjL0WYrkL0iOUxnGZ2YnjhoOJXOEdFlUE6A=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=hnYsiZUogHnBnC5arGvTlwsX2IaSI4wcAfQGcVPnia+fDs7N0/EMmjC0uXoQJCgj
 cHWP4KZO/1mhNY9WPLHAocCY0SROPzWKezl9t6oaDiXCLMsLeKBhlZ6GK7kxuIdx7
 GhiBK4SW6ZmhWATU889FngNXLDyGhOqeQUEi3EU/sP580M3EWIJSyrpd0GdyypK1R
 59wBN+OSB34BDa8OanObNTUmuwZsyqPcPDm7VRcRoSMZd1QlbWsy9pUVJvKyVaOG1
 zJLd3B5t4UytaTggWhwajkG0Di5r2Kg4yJslxywxuINOqLMcZo6/QA/P3xRFOn87R
 Pq1ta9ob0/XQ9yP6Xw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mn2W5-1tlULH0VLL-00pV8t; Mon, 28
 Oct 2024 07:57:20 +0100
Message-ID: <c0046b33-b224-4d87-90d9-6a78eeab0624@gmx.de>
Date: Mon, 28 Oct 2024 07:57:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] efi: add helper functions to insert pmem node for DT
 fixup
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20241025111411.165904-1-sughosh.ganu@linaro.org>
 <20241025111411.165904-5-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241025111411.165904-5-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yGaQqXtwaSa+NGL2lBwsOoTmqzIFB8ZH9hgYzKU/v9f9PdBn6AQ
 cwcgQI82tRUq/DrfNrDTRHcYk7erC40ytHSMA101JbWjqEEYJ62iL4AH4TJscVf46CuoVoA
 Hf5AgbGt1VSe50OBQVRSA/ITBiXBRiwp9tFnkwrQQhX6fxC4iNKSmfLn9s+IIuMt4qgYPmT
 0DN2jd+A6DIw4ASSTB9JQ==
UI-OutboundReport: notjunk:1;M01:P0:iSAXJHvBOHk=;jSWvG756DK5cR1m6H8RJcqvwHFo
 Yg15qMavXjbyGMRHdUZolWiL0eohKsgASQPivCE9b279ztIUiE55pu9vl2+2p0v9mTwz+/ZdX
 3w/jCp3t0LT3bTCG9J5VO//oGjXw6YbHxJyYSWsqpIWveCo7hDbrxdFpNX7doz3MkMZO3w2ik
 kPrx2ISSYRZ8jR0lkJXi5cXaBHRPknLHyZTuPO2BhuJ1PQSeLQeYF78GyBfUC3SUC1t+GNiuT
 YEki9jDktkyOIdTG4C2hD9oTAuRPWKl4W6+qU2x0ajwL0hNYB6SVLR0+L51af/HuQa8HrxUDl
 N6LMpOaC9SbhDRUNQfy2/KzG6wuI/wFkrXOIJ4pQBzSqPjWS/cEyvw38XLDMo49LH1dgCZpj5
 DeZerTntYyHIzpx0LccqYcQevFn7hVfgQbvM4DEJWE8LtD2qkWkMpZr3h1JCWLhtzxXZoHieM
 Wbbn+9Du9SjoCJSZKUVVXVDcU2iBJepKQBfbjp9yM2OfrqpcKkk7Q13tgrsKciWOst8grF0Va
 D9RHdJdJICQFeC/7vkxyQEOjLQ3Sr2eyVoa+kKc/pxQCEGzmdIOysQ6Zr2PzwSrk4ZL68pzkP
 yJcWyI1y9L839UycwVXlCNcKjJ/XYsUnfQAK4bGU13L858pcgMpC09EIsHUJyWyFhR77Jm0z8
 1KFajrpPAqivwKMcS+uqq452Thxm2MdvmMg0tmZOLr6XbiUKfIFWZ7sr0Qvki9BBoafhcOMiw
 imsYRhfLZqS+ndG4zd5f9zK9kQ4b7d9WwJDyAqvYWf5nRhcNwvwIcgLjPPX2QmZF+c+KhBK1U
 Jy6C7Fej7778L9Bz9CTEseSg==
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

On 10/25/24 13:14, Sughosh Ganu wrote:
> The EFI HTTP boot puts the iso installer image at some location in
> memory which needs to be reserved in the devicetree as persistent
> memory (pmem). Add helper functions which add this pmem node when the
> EFI_DT_FIXUP protocol's fixup callback is invoked.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   boot/image-fdt.c             |  9 +++++++++
>   include/efi_loader.h         | 17 +++++++++++++++++
>   lib/efi_loader/efi_bootmgr.c | 21 +++++++++++++++++++++
>   lib/efi_loader/efi_helper.c  | 12 ++++++++++++
>   4 files changed, 59 insertions(+)
>
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 8eda521693..b39e81ad30 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -11,6 +11,7 @@
>   #include <command.h>
>   #include <fdt_support.h>
>   #include <fdtdec.h>
> +#include <efi_loader.h>
>   #include <env.h>
>   #include <errno.h>
>   #include <image.h>
> @@ -648,6 +649,14 @@ int image_setup_libfdt(struct bootm_headers *images=
, void *blob, bool lmb)
>   	if (!ft_verify_fdt(blob))
>   		goto err;
>
> +	if (CONFIG_IS_ENABLED(EFI_HTTP_BOOT)) {
> +		fdt_ret =3D fdt_efi_pmem_setup(blob);

Having EFI_HTTP_BOOT is not the only way to load an image to memory. You
could have downloaded it via TFTP or taken it from a block device. So
this config check looks wrong. Why don't you check for the presence of
memory block devices here?

You need to check if the board is using ACPI, if yes, provide the ACPI
table.

Best regards

Heinrich

> +		if (fdt_ret) {
> +			printf("ERROR: HTTP boot pmem fixup failed\n");
> +			goto err;
> +		}
> +	}
> +
>   	/* after here we are using a livetree */
>   	if (!of_live_active() && CONFIG_IS_ENABLED(EVENT)) {
>   		struct event_ft_fixup fixup;
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index d450e304c6..031de18746 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -748,6 +748,15 @@ bool efi_varname_is_load_option(u16 *var_name16, in=
t *index);
>   efi_status_t efi_next_variable_name(efi_uintn_t *size, u16 **buf,
>   				    efi_guid_t *guid);
>
> +/**
> + * fdt_efi_pmem_setup() - Setup the pmem node in the devicetree
> + *
> + * @fdt:	Pointer to the devicetree
> + *
> + * Return:	0 on success, negative on failure
> + */
> +int fdt_efi_pmem_setup(void *fdt);
> +
>   /**
>    * efi_size_in_pages() - convert size in bytes to size in pages
>    *
> @@ -964,6 +973,14 @@ efi_status_t efi_set_load_options(efi_handle_t hand=
le,
>   				  void *load_options);
>   efi_status_t efi_bootmgr_load(efi_handle_t *handle, void **load_option=
s);
>
> +/**
> + * efi_bootmgr_pmem_setup() - Put a pmem node for UEFI HTTP installers
> + *
> + * @fdt:	Pointer to the DT blob
> + * Return:	status code
> + */
> +efi_status_t efi_bootmgr_pmem_setup(void *fdt);
> +
>   /**
>    * struct efi_image_regions - A list of memory regions
>    *
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 16f75555f6..1d9246be61 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -41,6 +41,8 @@ struct uridp_context {
>   	efi_handle_t mem_handle;
>   };
>
> +static struct uridp_context *uctx;
> +
>   const efi_guid_t efi_guid_bootmenu_auto_generated =3D
>   		EFICONFIG_AUTO_GENERATED_ENTRY_GUID;
>
> @@ -423,6 +425,7 @@ efi_status_t efi_bootmgr_release_uridp(struct uridp_=
context *ctx)
>
>   	efi_free_pool(ctx->loaded_dp);
>   	free(ctx);
> +	uctx =3D NULL;
>
>   	return ret =3D=3D EFI_SUCCESS ? ret2 : ret;
>   }
> @@ -443,6 +446,23 @@ static void EFIAPI efi_bootmgr_http_return(struct e=
fi_event *event,
>   	EFI_EXIT(ret);
>   }
>
> +/**
> + * efi_bootmgr_pmem_setup() - Put a pmem node for UEFI HTTP installers
> + *
> + * @fdt:	Pointer to the DT blob
> + * Return:	status code
> + */
> +efi_status_t efi_bootmgr_pmem_setup(void *fdt)
> +{
> +	if (!uctx) {
> +		log_warning("No EFI HTTP boot context found\n");
> +		return EFI_SUCCESS;
> +	}
> +
> +	return !fdt_fixup_pmem_region(fdt, uctx->image_addr, uctx->image_size)=
 ?
> +		EFI_SUCCESS : EFI_INVALID_PARAMETER;
> +}
> +
>   /**
>    * try_load_from_uri_path() - Handle the URI device path
>    *
> @@ -472,6 +492,7 @@ static efi_status_t try_load_from_uri_path(struct ef=
i_device_path_uri *uridp,
>   	if (!ctx)
>   		return EFI_OUT_OF_RESOURCES;
>
> +	uctx =3D ctx;
>   	s =3D env_get("loadaddr");
>   	if (!s) {
>   		log_err("Error: loadaddr is not set\n");
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 00167bd2a1..33cd8b9a50 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -242,6 +242,18 @@ int efi_unlink_dev(efi_handle_t handle)
>   	return 0;
>   }
>
> +/**
> + * fdt_efi_pmem_setup() - Setup the pmem node in the devicetree
> + *
> + * @fdt:	Pointer to the devicetree
> + *
> + * Return:	0 on success, negative on failure
> + */
> +int fdt_efi_pmem_setup(void *fdt)
> +{
> +	return efi_bootmgr_pmem_setup(fdt) =3D=3D EFI_SUCCESS ? 0 : -1;
> +}
> +
>   static int u16_tohex(u16 c)
>   {
>   	if (c >=3D '0' && c <=3D '9')


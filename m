Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE689D12D7F
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 08:03:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78F6B892ED;
	Mon, 11 Nov 2024 09:03:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="C17y1Vpe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21B38892E8; Mon, 11 Nov 2024 09:03:47 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1487E892E8
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 09:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731312223; x=1731917023; i=xypron.glpk@gmx.de;
 bh=zkZOjBUSXl8hrux+tyojmrvUkQFmVjZtYbdSWWWPXmM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=C17y1VpeHCfPSOWCscOgApb9BTBncSLH1tq8vktWt1OfUWb29PNnwhMtao2XorrG
 rW4GpmRm2T5Q+d0JZeVfsyKz1kr+K5G0z4hxLTkPSJxBjHr6qxkwBix+t4y11qA3m
 kTiniFOqtFHbHQFs5oQiO4zE72UhBi2+Isl4biD3wOX33muX44ya1BTxiTk4yGa9w
 dLGoy3AUgTcotup7if16CRZ2eTRyhWowLv08GpiUogHwpU9/I9jmsha+DRE3nLf1z
 G9H6/1UD3abAS26MFaSletrJSSLArBq1vKZnzMtGD8NhMg2flkaldzZkGakaJKQ1S
 xFLuwHwL0eHT80Lj8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MO9z7-1tPZnK28U5-00Sc5S; Mon, 11
 Nov 2024 09:03:43 +0100
Message-ID: <22d941ba-3452-4e10-ae59-642786f3d92c@gmx.de>
Date: Mon, 11 Nov 2024 09:03:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] efi: add helper functions to insert pmem node for DT
 fixup
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
References: <20241025111411.165904-1-sughosh.ganu@linaro.org>
 <20241025111411.165904-5-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241025111411.165904-5-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:apooT60+khVM6D6v7SrwS0yNkMdXfmgXRDY08MkuGk8VuL3rQx0
 oZlHWr7EjI6yOC+M+PJ4cFFZz6TWab6ElPM1hNmxWbbIL3+wnQe5KBsBlNL3kEWqc6L10T7
 fOC9dnLfXmQrgq+rCVQocU8PFTkTvRJ2Bz/wmOaa7Gvs3s+HCuhVJ4HuK6s4eTOeZGtqmtF
 d2pInIepU9DPPxhBQEwXA==
UI-OutboundReport: notjunk:1;M01:P0:GLt9h8r5gXA=;7YvK+V/LTqfSN3PSlemiJV48g23
 bfgTC+g/sp+jfB2D6zm39IAEBcz6+8IQG4BiZYTfAESpND7Ql5ZeeJ67tXUFW2iArXVlzPUS0
 AQRZKmqJx0XHQEbxaS2b5xb22kxDxX51r7MC6WuPfGqOcOjtp1ebdeUVMU889cFeKVuUkAMJk
 RTAPc8boOctTPg18kN4+yiuYRO6/QcLduDu4tMusdgxT2JqRHHj4fFzR3HUZuB/eZGUMSuh2K
 tMWy18rWEfCD1VxC/ieHKxIj7XrnnUyuJ5vLMlYQRc/fmmjeMTALSHsY4ZQmQww29OmtbzVzb
 3yuwFjiOkvOo8Qc8mIFbzi2qRTNF4Z2JvxT4p5uAZbLH3dhkH8cPHytQEPguIoPNnsCjoT65q
 +AHq47JAc1jwzDMTgXahUjUdv+bdre2zP8g8I4gt8J/hvRqfsKq7YoprQaz7gZGtAKZMedVYv
 aEJ9R8P1vnWbToVw03KKXg3Cqm2p3VB6gWIPwATbCQXcMwOdNoB9swEEQFEK5h4CoP/LvWzNM
 4Xtd2f9730EWKRkssYPdtjgmzPlyj0y50UOLtQ41sb6yO/rBrZuX8xQRH2mgHS1ug973GlEco
 KPTRSJTkXJHBd6ffm94KFN8cAetTJMqV0J+bYzD7fhivUJ6lFpFQn+a7pohAV+pi8I1hqXOdh
 XvllsnlGmUeHPh5LAk3mpM9vHGwLnrhPURbtzm16OkNYtTtbQWpY7D+TRzxUnTmYo4z0OcPYB
 jhoqrO5FInvbOA3By+6cVu8tRa+mKaM3pgsoqYfVHw5yO2yrb0fogmOSIXrzWH+QjqabXLb/M
 l1OZBxIlNXaTNuLwSA0RpaMg==
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

I can see no reason why pmem setup should depend on HTTP boot.

It should be possible to pass a memory block device to the kernel no
matter how it was created.

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


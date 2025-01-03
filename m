Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E57AE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 17:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82D3F80295;
	Fri,  3 Jan 2025 18:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="njHxG8Jw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 127AB802EF; Fri,  3 Jan 2025 18:01:16 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCB2A801A0
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 18:01:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735923667; x=1736528467; i=xypron.glpk@gmx.de;
 bh=jxLb5kLpPC8T2dPe4Hj1VhFeRybx2D8oj0LM0Shs1So=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=njHxG8Jwv6QJ6/RUOk6Ibddqi/ZHe78UqgSgC34fP9uC4EuWDc3OV6YoddEA6gPn
 yuwTC0+i6vfd+H7jycJS33q+vJZMnZvIDqljZegsJlw5q9BdWgWwE+Tox+0AMTCLX
 1oyAgbrfpmG9dT5iZQUEMeWgakYFErB2CS6m4OibvqdN5uzCp+EGyzvyltIjk6OEq
 POpvDlxl+8GVlU8NsQQVjvfwBE9nIi2h/h4b2mT27wZmC7I3Ubyjh0CSqyq2T6Ugr
 JH19e9cYrcrBZzsACpDUy4cN3sHpVb5awKP4T4MF6w0qlXg63mhtqwdoh6/BqrD9M
 eggrjocTf1oGgpdamg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.106] ([46.114.109.94]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgNcz-1tyOxo2k3z-00lazT; Fri, 03
 Jan 2025 18:01:07 +0100
Message-ID: <a6c7b22a-290c-44ee-acab-58409e675bc7@gmx.de>
Date: Fri, 3 Jan 2025 18:01:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] efi: add helper functions to insert pmem node for
 DT fixup
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Anton Antonov <Anton.Antonov@arm.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20241203163605.1482152-1-sughosh.ganu@linaro.org>
 <20241203163605.1482152-5-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241203163605.1482152-5-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YeIVXmhxB8KiQD9QtN4T7WTgtEJklgqo47C7dHnoX543QO6QDl3
 MOl84zdt3mqrN+tnegGnLyu7T6kwS/8H76rw2upZKz5saLuzu66rN/BBoCtFY/CSJrw0kDz
 J4IT9i+ZIkZ5JfwTlL9QUnuiZawc7MQ/FFn31lEM/3VprecBWMAkTaRtZ0VKkZjqBJ4OWGq
 bOCrXlmfuTn+50HQKlKaQ==
UI-OutboundReport: notjunk:1;M01:P0:mMdQiHo4LDo=;0lOTn0ZDzL3qyRL6bgPe3nWOZZT
 VOu+gg903UqDpCiA/wkZQ7j4H9L1Gn8DbAvAT1JUAgjqYyMjGX3SxagfhR93DeO+fb9ifJF/0
 /BqbhJpQ6T+825AZmv/q9ZwkR913PqYZv8eF3BK9lySJC5FOKmZoFVdC40C7kR8Kgua6Coo9H
 VD50i6nsulA9TxLmKYgqMUYD+Pa9DoXu3uzrjtvXyCuPX55NbyOSa9JY4Htz0q6rIYoE7aJ87
 pjQar8X8NuHkO/M7sEA78fMIt1iLTldRpjAixLjMABne6WW7Y4ZBuTsoef5wCTIittGmrNNWi
 HXR4ROS3miN473Sh21EevEt1+isN+mjG0G3G3EMfsedOKKpgqZBuHAcCQG4OC2YxpPIhxIz88
 L7ac3ThCjTRh51XhVpU6vZXuvtzm7uTg4O8vdifKbLkolLPOMO3kAUkaIisGZ4Rl4jVN2WY6x
 HwdksquMRnRYdsrUO34liUy6NMxuNv+X7eSbwGEU5tBbBQ8h4E2dn/DH85IcS5G6O3OjJgOGH
 BJiCRSkgIJFk0sPSvqiPWA6IRO5Ch512lAjD/EC+mVktR+i63/ybcwzks5INcub+fH9M1f5c2
 RWUMH61Hs5VhIq4m+Wbb+oFIq8KAVaNlkd5Bo44AYwcbiIwWqIefHkdN+jJuAdbqgy96nrYB0
 DjEGMwPKm8tMX9KE3ndkjivmGLEVkKl+8lOynqyE7j3kh2viOBkb2Jb7PSrD80a//oeSmIqla
 DTO79wB52ttSb2X7OyBmw8RmMo611f7wfhWgyR1VzThCqGImjwVPHGuK7VW1CuHrkVptfZmyv
 1iuDwc7FxCJ6xaMDeXX2TwJBdT/lnA3bmDZ8p8CL/xajcRu17kWDC4BK4uk6a4uU2xHwSXj7p
 jCdjBDZ+5uiyLYnnjEK4yz62MGeN1f8J20QYMiJBRpaFKRI40A9rpiz/V71vYasoLeOg5SEpK
 +OYERHKiBJoP2eyYgAqtcvu9YTsMdfXeVkQsFYQmjkMQu1YqarjEvXHTGuyiP6jNVoDWvma9w
 a02365j0eTTVGVd9XBxBOJQgE1DEBIt6PjL5JKte1MdmtbpACBpR1dXFHlVq1iW2tMhXVe9Y4
 9Hmk//GZ2AR+bkAy0m8S5VMcB4P0x9
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

On 03.12.24 17:36, Sughosh Ganu wrote:
> The EFI HTTP boot puts the iso installer image at some location in
> memory which needs to be reserved in the devicetree as persistent
> memory (pmem). Add helper functions which add this pmem node when the
> EFI_DT_FIXUP protocol's fixup callback is invoked.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Use log_err() to print the error message in image_setup_libfdt()
> * Remove "ERROR:" from the error print in image_setup_libfdt()
>
>   boot/image-fdt.c             |  9 +++++++++
>   include/efi_loader.h         | 17 +++++++++++++++++
>   lib/efi_loader/efi_bootmgr.c | 21 +++++++++++++++++++++
>   lib/efi_loader/efi_helper.c  | 12 ++++++++++++
>   4 files changed, 59 insertions(+)
>
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 3d5b6f9e2dc..de479d3ffa0 100644
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
> +		if (fdt_ret) {
> +			log_err("HTTP boot pmem fixup failed\n");
> +			goto err;
> +		}
> +	}
> +
>   	/* after here we are using a livetree */
>   	if (!of_live_active() && CONFIG_IS_ENABLED(EVENT)) {
>   		struct event_ft_fixup fixup;
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 24e40799eee..87b9a6e4da0 100644
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
> index b906e53e26e..db4eb6a7376 100644
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
> @@ -427,6 +429,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct=
 uridp_context *ctx)
>
>   	efi_free_pool(ctx->loaded_dp);
>   	free(ctx);
> +	uctx =3D NULL;
>
>   	return ret =3D=3D EFI_SUCCESS ? ret2 : ret;
>   }
> @@ -447,6 +450,23 @@ static void EFIAPI efi_bootmgr_http_return(struct e=
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

This function is called if CONFIG_EFI_HTTP_BOOT=3Dy. This configuration
setting allows booting via HTTP but does not require it. The warning
makes no sense when booting from a block device.

The image type is orthogonal to the way you load it. Pmem support in
Linux is not related to UEFI. Please, remove the dependency of pmem
support on UEFI HTTP boot.

If the object to be booted is a disk image, we can create a block device
in memory for it and then should be able to apply all standard boot
methods on it.

Best regards

Heinrich

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
> @@ -476,6 +496,7 @@ static efi_status_t try_load_from_uri_path(struct ef=
i_device_path_uri *uridp,
>   	if (!ctx)
>   		return EFI_OUT_OF_RESOURCES;
>
> +	uctx =3D ctx;
>   	s =3D env_get("loadaddr");
>   	if (!s) {
>   		log_err("Error: loadaddr is not set\n");
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index bf96f61d3d0..6fae37ad617 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -313,6 +313,18 @@ int efi_unlink_dev(efi_handle_t handle)
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


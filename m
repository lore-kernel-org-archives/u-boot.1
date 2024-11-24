Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDD0E668B3
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 14:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF08488F7B;
	Sun, 24 Nov 2024 15:43:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="flNrtzQA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F119F88FBA; Sun, 24 Nov 2024 15:43:21 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B870588E24
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 15:43:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732459396; x=1733064196; i=xypron.glpk@gmx.de;
 bh=lmaRmlMmu9K2LyFZnZGsk0itwfExLmKBC3PCJSw7SwQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=flNrtzQAyMaCAfedioBLZdjA3/SFQ+AfcrlOxOAy/fUvmRdU9riwKoo0tMwRradN
 /zgexOXnJtHk50y62sMn3ZEsax2Iadlia0Zf+OHlTpkcomRzIcl+ohe1Mt5l9EE3Z
 g/KZK9757eBRDr3KA+QtpU3hqC4g6MQLCnLSSkQtJCEQCOnOXWqKAinaOo9cDYpN2
 LhrtEyPvS/5jvZ+gMe3OX98PvFtsPIDhT6C5Xw+qvnP+mHedkreCztvSv0P4cXedg
 CnkLT4J0U91dX4hN9QvDKrwSyM5oQjybH+3XvJSfpHVR+/pYPqyP/jNy7vq25Eduh
 nPzIXMfWgBCyVd1pLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE6F-1sz3Ud3Ebr-00Rh9u; Sun, 24
 Nov 2024 15:43:16 +0100
Message-ID: <e1592ca0-03aa-4f83-848a-70c8979a9b2a@gmx.de>
Date: Sun, 24 Nov 2024 15:43:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] Add EFI handover support to bootm
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Matthew Garrett <mgarrett@aurora.tech>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, u-boot@lists.denx.de
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-2-mjg59@srcf.ucam.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241123195616.305687-2-mjg59@srcf.ucam.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9zniSshLecAC8BcEkaxzpf1yH4EA1cAEPN3DF1vGEz2JGdWBRpP
 nt8fL75sCDtXPejWPkQTGFKC/6PKhEgByX7dEGIUhbamP9YncqzAvw4qnyNDWpsUyqwa1YD
 X/OO2fKgnkTstOhWvGN5WXv6mBp862/ZEum2wh9/yKjcVrfSq3gWcu+HaavI3+tbzLAFoz4
 +rNrRP703LYljSds/baMw==
UI-OutboundReport: notjunk:1;M01:P0:aR/R5kV9oQg=;gdNfcXKg8gkEaVe4mtGFVRoG7pv
 J7jr986YXQs9AFdSDNQ4Wfd+9I6bBJyAOVUsY3ynW9mDAeyYjt+FRY8zyJJwdBxNwr+BneJsz
 Z7dhDucarqtRcyPB6lduxj3fmrfXhXsSTyaYc2yrblopa+HAZ8wHdWc9DBkl90yXAbMQlBzig
 7lOumY23p1fBSuGYZWaZUtTvg/XiFTXP0lLnpCRE/G2kVFdOmsm+y3SU2fqO3lNRLKfchBIeb
 UXljkyp25QP43YtEUYZ71863TDP09E8Ur/J9njN6b6PrQxbtvS4sKrjdXDfvQjcyT1iZaSxVd
 YaEB/caMFrfuuCUEWJe5GXxDVTsWoWiRdmNTiKGUvpxs2m258qNTRXEFKqxncXNZjnVsNR6ew
 z2KVs9zfYlkQcvCQXPIfurFPCE+ILbrpkiQgGHKbrIyWwZSCVDbHejxJ7c+VlKeTiESzHr+9r
 TD4SNVTKpIWEWlq2fVgXXkozCQIeng+7eOXzFicJO7ky/cjpM49qO5XgZCI+RE4gAJw9qkzl0
 DVaARwvnj29bdd3rB+cCcsekifZaBuFywyFBXu+wYybX8/mo0PVteGkslLgF7Sp8iD+/KawpD
 dOpK86SFSaE80M7TZVar5aYNGSUdcPrV5KFivS6iw1Yj/XPiVveq1YCcHpyrmakLZSCeM1zju
 USo4bCFOC9iMTU2uXtp+5xfhWqgnYMY0DGFUKoR9QUrKEqOqAjpEnVDkspIEoAoblPsiVcs/1
 s91lsvTLmwPyfDWcQAfkWBFkuiw1p7RN2T60wTz4oiRs1QFPnL2Ki7+TiZnrLfkcZD9XJ5sSo
 K1XoDBEIWE3gCLdQig7mqan66ucBfwjYEwMD5QFAQa4Bskz72sQE1V7zlcaJLl0pGO0axI+b/
 cAND5UPcHfv7IBrbbmcWLVCNNYDRBkUA0FNG9JjL8G0PgIF1nnJxXjZOX
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

On 11/23/24 20:55, Matthew Garrett wrote:
> From: Matthew Garrett <mgarrett@aurora.tech>
>
> We want to jump into the EFI stub in the kernel so it can perform
> appropriate init and call ExitBootServices. Add support for doing that,
> including ensuring that we copy the kernel to somewhere that's not
> currently being used by the firmware.
>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
>
> ---
>
>   arch/x86/lib/bootm.c | 49 ++++++++++++++++++++++++++++++--------------
>   boot/bootm.c         |  5 +++++
>   include/bootm.h      |  6 ++++++
>   include/efi.h        |  1 +
>   lib/efi/efi.c        |  1 +
>   lib/efi/efi_app.c    | 36 ++++++++++++++++++++++++++++++++
>   6 files changed, 83 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
> index 55f581836df..c4446b1f9c6 100644
> --- a/arch/x86/lib/bootm.c
> +++ b/arch/x86/lib/bootm.c
> @@ -150,6 +150,38 @@ error:
>   	return 1;
>   }
>
> +typedef void(*handover_func)(void *, struct efi_system_table *sys_table=
, struct
> +boot_params *params);
> +
> +int efi_boot(ulong setup_base, ulong entry, bool image_64bit)
> +{
> +	struct boot_params *params =3D (struct boot_params *)setup_base;
> +	struct setup_header *hdr =3D &params->hdr;
> +	struct efi_priv *priv =3D efi_get_priv();
> +	handover_func hf;
> +	int offset =3D 0;
> +
> +	if (IS_ENABLED(CONFIG_EFI_APP_64BIT)) {
> +		if (!image_64bit) {
> +			printf("## Can only boot 64-bit kernels\n");
> +			return 1;
> +		}
> +		offset =3D 512;
> +	} else if (image_64bit) {
> +		printf("# Can only boot 32-bit kernels\n");
> +		return 1;
> +	}
> +
> +	hdr->code32_start =3D (int)entry;
> +	hdr->type_of_loader =3D 0x80; /* U-Boot, from Linux Documentation/x86/=
boot.rst */
> +
> +	hf =3D (handover_func)(entry + hdr->handover_offset + offset);
> +	asm volatile ("cli");
> +	priv->loaded_image->image_base =3D (char *)entry;
> +	hf(priv->parent_image, priv->sys_table, params);
> +	return -EFAULT;
> +}
> +
>   int boot_linux_kernel(ulong setup_base, ulong entry, bool image_64bit)
>   {
>   	bootm_announce_and_cleanup();
> @@ -158,21 +190,8 @@ int boot_linux_kernel(ulong setup_base, ulong entry=
, bool image_64bit)
>   	timestamp_add_now(TS_U_BOOT_START_KERNEL);
>   #endif
>
> -	/*
> -	 * Exit EFI boot services just before jumping, after all console
> -	 * output, since the console won't be available afterwards.
> -	 */
> -	if (IS_ENABLED(CONFIG_EFI_APP)) {
> -		int ret;
> -
> -		ret =3D efi_store_memory_map(efi_get_priv());
> -		if (ret)
> -			return ret;
> -		printf("Exiting EFI boot services\n");
> -		ret =3D efi_call_exit_boot_services();
> -		if (ret)
> -			return ret;
> -	}
> +	if (IS_ENABLED(CONFIG_EFI_APP))
> +		return efi_boot(setup_base, entry, image_64bit)
>
>   	if (image_64bit) {
>   		if (!cpu_has_64bit()) {
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 16a43d519a8..d5caa4cdb31 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -49,6 +49,10 @@ __weak void board_quiesce_devices(void)
>   {
>   }
>
> +__weak void board_fixup_os(image_info_t *os)
> +{
> +}
> +
>   #if CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT)
>   /**
>    * image_get_kernel - verify legacy format kernel image
> @@ -999,6 +1003,7 @@ int bootm_run_states(struct bootm_info *bmi, int st=
ates)
>   	/* Load the OS */
>   	if (!ret && (states & BOOTM_STATE_LOADOS)) {
>   		iflag =3D bootm_disable_interrupts();
> +		board_fixup_os(&images->os);
>   		ret =3D bootm_load_os(images, 0);
>   		if (ret && ret !=3D BOOTM_ERR_OVERLAP)
>   			goto err;
> diff --git a/include/bootm.h b/include/bootm.h
> index 61160705215..b0d10123b53 100644
> --- a/include/bootm.h
> +++ b/include/bootm.h
> @@ -217,6 +217,12 @@ void arch_preboot_os(void);
>    */
>   void board_quiesce_devices(void);
>
> +/*
> + * boards should define this if they need to fix up the kernel before b=
oot
> + * (eg, by modifying the desired load address).
> + */
> +void board_fixup_os(image_info_t *os);
> +
>   /**
>    * switch_to_non_secure_mode() - switch to non-secure mode
>    */
> diff --git a/include/efi.h b/include/efi.h
> index c559fda3004..1d06230439f 100644
> --- a/include/efi.h
> +++ b/include/efi.h
> @@ -459,6 +459,7 @@ static inline struct efi_mem_desc *efi_get_next_mem_=
desc(
>    */
>   struct efi_priv {
>   	efi_handle_t parent_image;
> +	struct efi_loaded_image *loaded_image;
>   	struct efi_system_table *sys_table;
>   	struct efi_boot_services *boot;
>   	struct efi_runtime_services *run;
> diff --git a/lib/efi/efi.c b/lib/efi/efi.c
> index bcb34d67465..bb1d9e24f84 100644
> --- a/lib/efi/efi.c
> +++ b/lib/efi/efi.c
> @@ -113,6 +113,7 @@ int efi_init(struct efi_priv *priv, const char *bann=
er, efi_handle_t image,
>   		efi_puts(priv, "Failed to get loaded image protocol\n");
>   		return ret;
>   	}
> +	priv->loaded_image =3D loaded_image;
>   	priv->image_data_type =3D loaded_image->image_data_type;
>
>   	return 0;
> diff --git a/lib/efi/efi_app.c b/lib/efi/efi_app.c
> index 9b94a93ee4f..7c3ef9a7926 100644
> --- a/lib/efi/efi_app.c
> +++ b/lib/efi/efi_app.c
> @@ -14,6 +14,7 @@
>   #include <efi.h>
>   #include <efi_api.h>
>   #include <errno.h>
> +#include <image.h>
>   #include <init.h>
>   #include <malloc.h>
>   #include <sysreset.h>
> @@ -218,6 +219,41 @@ static int efi_sysreset_request(struct udevice *dev=
, enum sysreset_t type)
>   	return -EINPROGRESS;
>   }
>
> +/*
> + * Attempt to relocate the kernel to somewhere the firmware isn't using
> + */
> +#define PAGE_SIZE_BITS 12
> +void board_fixup_os(image_info_t *os)
> +{
> +	int pages;
> +	ulong load_addr;
> +	u64 addr;
> +	efi_status_t status;
> +	struct efi_priv *priv =3D efi_get_priv();
> +	struct efi_boot_services *boot =3D priv->boot;
> +
> +	pages =3D (os->image_len + ((1 << PAGE_SIZE_BITS) - 1)) >> PAGE_SIZE_B=
ITS;
> +
> +	addr =3D os->load;
> +
> +	/* Try to allocate at the preferred address */
> +	status =3D boot->allocate_pages(EFI_ALLOCATE_ADDRESS, EFI_LOADER_DATA,
> +				      pages, &addr);
> +	if (status =3D=3D EFI_SUCCESS)
> +		return;
> +
> +	/* That failed, so try allocating anywhere there's enough room */
> +	status =3D boot->allocate_pages(EFI_ALLOCATE_ANY_PAGES, EFI_LOADER_DAT=
A, pages, &addr);
> +	if (status =3D=3D EFI_SUCCESS) {
> +		/* Make sure bootm knows where we loaded the image */
> +		os->load =3D addr;
> +		return;
> +	}

Why don't you simply call LoadImage()?

Best regards

Heinrich

> +
> +	printf("Failed to alloc %lx bytes at %lx: %lx\n", os->image_len, load_=
addr,
> +	       status);
> +}
> +
>   static const struct udevice_id efi_sysreset_ids[] =3D {
>   	{ .compatible =3D "efi,reset" },
>   	{ }


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621DBE77188
	for <u-boot@archiver.kernel.org>; Sun, 22 Dec 2024 12:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2FE480562;
	Sun, 22 Dec 2024 13:50:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="EE02pi9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13D708056A; Sun, 22 Dec 2024 13:50:40 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6FA780435
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 13:50:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1734871831; x=1735476631; i=xypron.glpk@gmx.de;
 bh=vRsH0dro5sul0O2fXd8rtMbyIjWE/+aEhEBQePYxKFA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=EE02pi9xzeIEDV9kcl9NssY3umNRa9Thd3S9QoVZnuS/wblrOJLVpxogkbqpUae0
 ubVPq41hnFKmILMaSF4kZNHzuR164ThSuESxGv6RYqyY/Qk3ewfWXlSQHEM7xeXED
 D3k9hSw5k/r/HoldoC6O+T9IDp78pC85PDQ5ROEnXiPwBJNa6tfZdorZaS4GOQGcO
 jP2UNrJqB1XmnXBj1+iWfeM1+i5ksHlqGzfBtAOs21vOUaJdVkvjCU4H4moqn0wrB
 EpiVqL8AuPoX+mqDTiZ81nCeCmKF0Jq3tZysZq5TyT+MOmQ479KYPMGX0cLEc8H7I
 Kp3H2S0yXA17oY8Zxg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeCpb-1u0bdg1bKZ-00ZxYV; Sun, 22
 Dec 2024 13:50:31 +0100
Message-ID: <a7162ab5-ba6a-4b68-9b23-89a195195d51@gmx.de>
Date: Sun, 22 Dec 2024 13:50:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] efi_loader: Pass in the required parameters from
 EFI bootmeth
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Patrick Wildt
 <pwildt@google.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
References: <20241219023832.1098689-1-sjg@chromium.org>
 <20241219023832.1098689-7-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241219023832.1098689-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jxOp/kZ/kUL6dbiEnyCG9LwDih3Ul+EkB2EnBpat/Y+74m0KP6X
 pajmPcktnzXU7glEmUi1+p0i3vCrQUNXCFFn8C0uGeBSr2UmFAORzkTy487G61CBo/cVBS6
 GEOCI7p5FKVNvf28RyGb4rxPoI2dgraEjZA7DUueVeHwbsTCmS1oRLsJ7VbnsIhlLryOcFC
 iVZ67jHHjFdbL5G3EZFjw==
UI-OutboundReport: notjunk:1;M01:P0:JJ9lG8MY2nc=;/cQmQj6lAzcB6ZA05r0xjmJbFiM
 NtP1nMFwcw6Dl8BKOh0f2aGJRAai1vJUNCRIlRkEq6nLB0yzJTVYbfHH4LFDFfUXSFfVUVlm2
 7LDx8wtLMZMEby4qD61zgHDK5jquvOFdCfLqV0mAl38LDV9/HmAe29kHwXSd12k/Qm7C68U4w
 o0LDvvV3i4P/0+kmj51rc0udluJ+gYlTn00KLzTmwqBH7VUFSf7zNVjnxj5NbsMttlH3hfO6Q
 G6jcT8XxFXY2Oe4YuK8OZ+Nx13XfIqE/814b3JKC5pKAJGfrJ5YUmJ05sBgw2NfaxwRXVg50h
 s5xOYTkrJ/r58lAZ4Cl4cjnaFwuCaZ+ufhF9N24tfpNALs2dLbXJ0bSBlX0Fqph73btUlHwdM
 NxyXmM0LBjk4hQB2rj8VUaZsYoGhqtbbAUhIFLxX5/QMR698B5WmsRVR0PYdKCady8u9R9Ile
 Brvorf+sdiBXCjqU926hfJtzl3nQWw2+rnPEkUFh2g1/1nNvon0P1UpQErJzNFtolNknllhn1
 bF3CefVZn4IRSoHl2M9+VT3ILzASVTQS2wGk2pZksnng4/C9QI6Wraar6djXrQ/uFmgZ4986w
 PDC6KyqlocDO4jqnOtUAdezjjiisMPIcPtRPrS7TgyMU0LSKi2mEM9YccnLP+wmEBUOSZ2dkd
 HHaZF6022IZAYGe/2UxXsIALM0wiTzELC50AiOyXSodwRN3ybpISdZ03L+FclltZWWvwCAhMZ
 Q2SApTE8bdgIz+3InGGXLGYMiRhb7Dqd6UAhCjKKdarK0wzx1nNzE6h3Ici2jxEhF62G4dfO1
 bnHRGAyxdFQ6Cwbk3xsstn5kHh4g1Khpk1u/gepAAvGhKtiAAHU2lOYbuEtQT7dIJcYUk7CHm
 9mbISlJf7g6g8abECT63wUO2t0Lk84sEL35eTlosGAsR3745Hlqh4GVZc7m1x3aAzs3JdxPpb
 p7+WQBxM9QeOtP4IhXyCCOdeuvmD1dOFwQhL6PqVC7mDykxmPXRDqHUFoLiL1hsgh02vHAEXU
 srRS80Cbwd7p81Q5DGQVdUJv3m17UgoKgR7esuAYfU/9qCPVwZfC07+qLUqQqHmn/7RHCaJMu
 I5ZUXvGBYO71PZe9gQVSa5JmWZY26o
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

On 12/19/24 03:38, Simon Glass wrote:
> Rather than setting up the global variables and then making the call,
> pass them into function directly. This cleans up the code and makes it
> all a bit easier to understand.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Use efi_loader tag instead of efi
> - Drop unnecessary path removal
> - Fix 'require' typo
> - Move calculation of dev-name into a separate function

Please, split the patch into logical units.

>
>   boot/bootmeth_efi.c          | 49 +------------------------
>   include/efi_loader.h         | 10 +++++
>   lib/efi_loader/efi_bootbin.c | 71 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 83 insertions(+), 47 deletions(-)
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index f836aa655f5..fa7f66c9a0b 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -52,40 +52,6 @@ static bool bootmeth_uses_network(struct bootflow *bf=
low)
>   	    device_get_uclass_id(media) =3D=3D UCLASS_ETH;
>   }
>
> -static void set_efi_bootdev(struct blk_desc *desc, struct bootflow *bfl=
ow)
> -{
> -	const struct udevice *media_dev;
> -	int size =3D bflow->size;
> -	const char *dev_name;
> -	char devnum_str[9];
> -	char dirname[200];
> -	char *last_slash;
> -
> -	/*
> -	 * This is a horrible hack to tell EFI about this boot device. Once we
> -	 * unify EFI with the rest of U-Boot we can clean this up. The same ha=
ck
> -	 * exists in multiple places, e.g. in the fs, tftp and load commands.
> -	 *
> -	 * Once we can clean up the EFI code to make proper use of driver mode=
l,
> -	 * this can go away.
> -	 */
> -	media_dev =3D dev_get_parent(bflow->dev);
> -	snprintf(devnum_str, sizeof(devnum_str), "%x:%x",
> -		 desc ? desc->devnum : dev_seq(media_dev),
> -		 bflow->part);
> -
> -	strlcpy(dirname, bflow->fname, sizeof(dirname));
> -	last_slash =3D strrchr(dirname, '/');
> -	if (last_slash)
> -		*last_slash =3D '\0';
> -
> -	dev_name =3D device_get_uclass_id(media_dev) =3D=3D UCLASS_MASS_STORAG=
E ?
> -		 "usb" : blk_get_uclass_name(device_get_uclass_id(media_dev));
> -	log_debug("setting bootdev %s, %s, %s, %p, %x\n",
> -		  dev_name, devnum_str, bflow->fname, bflow->buf, size);
> -	efi_set_bootdev(dev_name, devnum_str, bflow->fname, bflow->buf, size);
> -}
> -
>   static int efiload_read_file(struct bootflow *bflow, ulong addr)
>   {
>   	struct blk_desc *desc =3D NULL;
> @@ -103,8 +69,6 @@ static int efiload_read_file(struct bootflow *bflow, =
ulong addr)
>   		return log_msg_ret("read", ret);
>   	bflow->buf =3D map_sysmem(addr, bflow->size);
>
> -	set_efi_bootdev(desc, bflow);
> -
>   	return 0;
>   }
>
> @@ -342,17 +306,8 @@ static int distro_efi_boot(struct udevice *dev, str=
uct bootflow *bflow)
>   		fdt =3D env_get_hex("fdt_addr_r", 0);
>   	}
>
> -	if (bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT) {
> -		log_debug("Booting with built-in fdt\n");
> -		if (efi_binary_run(map_sysmem(kernel, 0), bflow->size,
> -				   EFI_FDT_USE_INTERNAL))
> -			return log_msg_ret("run", -EINVAL);
> -	} else {
> -		log_debug("Booting with external fdt\n");
> -		if (efi_binary_run(map_sysmem(kernel, 0), bflow->size,
> -				   map_sysmem(fdt, 0)))
> -			return log_msg_ret("run", -EINVAL);
> -	}
> +	if (efi_bootflow_run(bflow))
> +		return log_msg_ret("run", -EINVAL);
>
>   	return 0;
>   }
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 9afbec35ebf..a9325b1a9d0 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -20,6 +20,7 @@
>   #include <linux/oid_registry.h>
>
>   struct blk_desc;
> +struct bootflow;
>   struct jmp_buf_data;
>
>   #if CONFIG_IS_ENABLED(EFI_LOADER)
> @@ -578,6 +579,15 @@ efi_status_t efi_install_fdt(void *fdt);
>   efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options);
>   /* Run loaded UEFI image with given fdt */
>   efi_status_t efi_binary_run(void *image, size_t size, void *fdt);
> +
> +/**
> + * efi_bootflow_run() - Run a bootflow containing an EFI application
> + *
> + * @bootflow: Bootflow to run
> + * Return: Status code, something went wrong
> + */
> +efi_status_t efi_bootflow_run(struct bootflow *bootflow);
> +
>   /* Initialize variable services */
>   efi_status_t efi_init_variables(void);
>   /* Notify ExitBootServices() is called */
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index 8332993f421..b5d15a723b4 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -6,13 +6,16 @@
>
>   #define LOG_CATEGORY LOGC_EFI
>
> +#include <bootflow.h>
>   #include <charset.h>
> +#include <dm.h>
>   #include <efi.h>
>   #include <efi_loader.h>
>   #include <env.h>
>   #include <image.h>
>   #include <log.h>
>   #include <malloc.h>
> +#include <mapmem.h>
>
>   static struct efi_device_path *bootefi_image_path;
>   static struct efi_device_path *bootefi_device_path;
> @@ -285,3 +288,71 @@ out:
>   	return ret;
>   }
>
> +/**
> + * calc_dev_name() - Calculate the device name to give to EFI
> + *
> + * If not supported, this shows an error.
> + *
> + * Return name, or NULL if not supported
> + */
> +static const char *calc_dev_name(struct bootflow *bflow)
> +{
> +	const struct udevice *media_dev;
> +
> +	media_dev =3D dev_get_parent(bflow->dev);
> +
> +	if (!bflow->blk) {
> +		log_err("Cannot boot EFI app on media '%s'\n",
> +			dev_get_uclass_name(media_dev));
> +
> +		return NULL;
> +	}
> +
> +	if (device_get_uclass_id(media_dev) =3D=3D UCLASS_MASS_STORAGE)
> +		return "usb";
> +
> +	return blk_get_uclass_name(device_get_uclass_id(media_dev));
> +}
> +
> +efi_status_t efi_bootflow_run(struct bootflow *bflow)
> +{
> +	struct efi_device_path *device, *image;
> +	const struct udevice *media_dev;
> +	struct blk_desc *desc =3D NULL;
> +	const char *dev_name;
> +	char devnum_str[9];
> +	efi_status_t ret;
> +	void *fdt;
> +
> +	media_dev =3D dev_get_parent(bflow->dev);
> +	if (bflow->blk) {
> +		desc =3D dev_get_uclass_plat(bflow->blk);

Where do you handle network devices?

Best regards

Heinrich

> +
> +		snprintf(devnum_str, sizeof(devnum_str), "%x:%x",
> +			 desc ? desc->devnum : dev_seq(media_dev), bflow->part);
> +	} else {
> +		*devnum_str =3D '\0';
> +	}
> +
> +	dev_name =3D calc_dev_name(bflow);
> +	log_debug("dev_name '%s' devnum_str '%s' fname '%s' media_dev '%s'\n",
> +		  dev_name, devnum_str, bflow->fname, media_dev->name);
> +	if (!dev_name)
> +		return EFI_UNSUPPORTED;
> +	ret =3D calculate_paths(dev_name, devnum_str, bflow->fname, &device,
> +			      &image);
> +	if (ret)
> +		return ret;
> +
> +	if (bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT) {
> +		log_debug("Booting with built-in fdt\n");
> +		fdt =3D EFI_FDT_USE_INTERNAL;
> +	} else {
> +		log_debug("Booting with external fdt\n");
> +		fdt =3D map_sysmem(bflow->fdt_addr, 0);
> +	}
> +	ret =3D _efi_binary_run(bflow->buf, bflow->size, fdt, device, image);
> +
> +	return ret;
> +}
> +


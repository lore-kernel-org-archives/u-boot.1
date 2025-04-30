Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8B7C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 07:04:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87CA182145;
	Wed, 30 Apr 2025 09:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="j3cK9EX6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 913F08272A; Wed, 30 Apr 2025 09:04:06 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E364809A5
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 09:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1745996644; x=1746601444; i=xypron.glpk@gmx.de;
 bh=vJpvkwnVrCD0LLgbA9zJ//iKeWcxjbsovED+8xm5Ui0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=j3cK9EX6snHyd+KjZr6ai5n/OXxE4Hn2J0eDDioWGURggV3WESWaX3pIF5G2cwJ6
 DG+2TdyKYfdID4TsHsv49UI1bgZaQt25Bm1SfKEFYG3GrkM3uvW3VyMcvYKbqoX7Y
 PaQEYJlkTnf0ijrjmUMo5kZTvnqXLkAsJIFhArV/PbqW7X8E/P7zcBIOowLdRBNQn
 a6+CGJ01GKBKjUGmg6WHWTr5SdtBINmHMEHNFdLeBokgmOThbAZLd+sJ9F5XeWz8Y
 u6/oTFNkuCInM6hyzO+Si7PpwTfeHCbrbvoXn6qphU//e8LSMm5grjQAKGDufos8f
 yyylAuQjUhek9D6jPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.108.68]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mirna-1ufo0N3uia-00hkKv; Wed, 30
 Apr 2025 09:04:04 +0200
Message-ID: <5516429f-074e-4ae6-bd7d-d49f020eae4a@gmx.de>
Date: Wed, 30 Apr 2025 09:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] efi_loader: bootbin: do not load an initrd if none
 is provided
To: Adriano Cordova <adrianox@gmail.com>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, trini@konsulko.com,
 o451686892@gmail.com, Adriano Cordova <adriano.cordova@canonical.com>,
 u-boot@lists.denx.de
References: <20250429132756.2105309-1-adriano.cordova@canonical.com>
 <20250429132756.2105309-2-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250429132756.2105309-2-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lxXqVF+euu8ydkUn5gqlvZ2FhvIyxUthU4yp2umOxfO2nK56G6o
 bIjXTslqkoVg7iYZFURV/m6KX1WHhZlxIPROLvgB8XWqH++Jl05y3uczuK3xDitQjj08Yuj
 zK1DymW4QOqwit8uTgZFOyWBKlX3A8lUa43hL182/TDUUQuVuP+Y5uhVBX/lxTgngu7FixC
 XeYFB/OWic8ZRA1RkWZ/w==
UI-OutboundReport: notjunk:1;M01:P0:BnOgl4BTv6U=;QFYgRqhayulIkZskn+LT6XbFVaA
 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
 NXqWkAdZNWns4JCC76eFoD97EMu0g+a4Kj
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

On 4/29/25 15:27, Adriano Cordova wrote:
> Do not try to create an initrd device path nor try to register
> an initrd with the EFI_LOAD_FILE2_PROTOCOL if none is provided.
>=20
> Handle initrd installation in efi_binary_run_dp with
> efi_install_initrd, imitating what is done for the fdt.
>=20
> Fixes: 36835a9105c ("efi_loader: binary_run: register an initrd")
> Reported-by: Weizhao Ouyang <o451686892@gmail.com>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> Tested-by: Weizhao Ouyang <o451686892@gmail.com>

I built and installed U-Boot for the StarFive VisionFive 2 based on=20
origin/master plus this series.

I created a FIT images using the its file listed below.

I loaded and tried to run the FIT image:

StarFive # load nvme 0:1 $kernel_addr_r initrd.itb
StarFive # bootm $kernel_addr_r

and saw the following failure:

## Transferring control to EFI (at address 00000000) ...
Card did not respond to voltage select! : -110
Booting /initrd.itb
Not a PE-COFF file
Loading image failed

We use the entry point instead of the load address when transferring=20
control to the EFI sub-system.

This bug was introduced by ecc7fdaa9ef1 ("bootm: Add a bootm command for=
=20
type IH_OS_EFI") and is not related to your patches but we still need to=
=20
fix it.

Afterwards I tried to boot into Ubuntu and got:

   Loading Linux 6.14.0-13-generic ...
   Loading initial ramdisk ...
   error: failed to install protocols.
   Loading device tree blob...

   Press any key to continue...

It seems that U-Boot did not uninstall the LoadFile2 protocol when=20
discovering that the EFI image was invalid. We should have a look at the=
=20
error handling.

The initrd for my test case can be created with:

echo 'hello world' > hello
echo hello | cpio -o -H newc > initrd

Best regards

Heinrich

/dts-v1/;

/ {
     description =3D "EFI FIT";
     #address-cells =3D <1>;

     images {
         initrddump {
             description =3D "initrddump";
             data =3D /incbin/("lib/efi_loader/initrddump.efi");
             type =3D "kernel";
             arch =3D "riscv";
             os =3D "efi";
             compression =3D "none";
             load =3D <0x58000000>;
             entry =3D <0x0>;
         };
         initrd {
             description =3D "initrd";
             data =3D /incbin/("initrd");
             type =3D "ramdisk";
             compression =3D "none";
             arch =3D "riscv";
             os =3D "efi";
             load =3D <0x60000000>;
         };
         fdt {
             description =3D "vf2";
             data =3D=20
/incbin/("dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.=
3b.dtb");
             type =3D "flat_dt";
             arch =3D "riscv";
             compression =3D "none";
             load =3D <0x68000000>;
         };
     };

     configurations {
         default =3D "config-initrddump";

         config-initrddump {
             description =3D "initrddump";
             kernel =3D "initrddump";
             ramdisk =3D "initrd";
             fdt =3D "fdt";
         };
     };
};







> ---
>=20
> Changes in v3:
>   - Do not clear images->initrd_start in boot/bootm.c, as this is
>     done in bootm_start().
>=20
> Changes in v2:
>   - Free initrd_dp
>=20
>   include/efi_loader.h         |  2 ++
>   lib/efi_loader/efi_bootbin.c |  7 +------
>   lib/efi_loader/efi_helper.c  | 29 +++++++++++++++++++++++++++++
>   3 files changed, 32 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 144b749278a..84e8cfe320e 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -597,6 +597,8 @@ efi_status_t efi_env_set_load_options(efi_handle_t h=
andle, const char *env_var,
>   void *efi_get_configuration_table(const efi_guid_t *guid);
>   /* Install device tree */
>   efi_status_t efi_install_fdt(void *fdt);
> +/* Install initrd */
> +efi_status_t efi_install_initrd(void *initrd, size_t initd_sz);
>   /* Execute loaded UEFI image */
>   efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options);
>   /* Run loaded UEFI image with given fdt */
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index d0f7da309ce..6a189c31ffa 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -220,7 +220,6 @@ static efi_status_t efi_binary_run_dp(void *image, s=
ize_t size, void *fdt,
>   				      struct efi_device_path *dp_img)
>   {
>   	efi_status_t ret;
> -	struct efi_device_path *dp_initrd;
>  =20
>   	/* Initialize EFI drivers */
>   	ret =3D efi_init_obj_list();
> @@ -234,11 +233,7 @@ static efi_status_t efi_binary_run_dp(void *image, =
size_t size, void *fdt,
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;
>  =20
> -	dp_initrd =3D efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd, init=
d_sz);
> -	if (!dp_initrd)
> -		return EFI_OUT_OF_RESOURCES;
> -
> -	ret =3D efi_initrd_register(dp_initrd);
> +	ret =3D efi_install_initrd(initrd, initd_sz);
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;
>  =20
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 3936139ca41..19fb5d03fec 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -622,6 +622,35 @@ efi_status_t efi_install_fdt(void *fdt)
>   	return EFI_SUCCESS;
>   }
>  =20
> +/**
> + * efi_install_initrd() - install initrd
> + *
> + * Install the initrd located at @initrd using the EFI_LOAD_FILE2
> + * protocol.
> + *
> + * @initrd:	address of initrd or NULL if none is provided
> + * @initrd_sz:	size of initrd
> + * Return:	status code
> + */
> +efi_status_t efi_install_initrd(void *initrd, size_t initd_sz)
> +{
> +	efi_status_t ret;
> +	struct efi_device_path *dp_initrd;
> +
> +	if (!initrd)
> +		return EFI_SUCCESS;
> +
> +	dp_initrd =3D efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd, init=
d_sz);
> +	if (!dp_initrd)
> +		return EFI_OUT_OF_RESOURCES;
> +
> +	ret =3D efi_initrd_register(dp_initrd);
> +	if (ret !=3D EFI_SUCCESS)
> +		efi_free_pool(dp_initrd);
> +
> +	return ret;
> +}
> +
>   /**
>    * do_bootefi_exec() - execute EFI binary
>    *


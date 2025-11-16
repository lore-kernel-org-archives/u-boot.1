Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEF9CEBF8A
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 08:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1330683A3D;
	Sun, 16 Nov 2025 09:57:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ju+Jgz+y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3275483A64; Sun, 16 Nov 2025 09:57:05 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D05BF83A32
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 09:57:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1763283408; x=1763888208; i=xypron.glpk@gmx.de;
 bh=s0UOGYu+ksVCiglpkBf6+2gU31+uW0TpWBg/HtDRiw4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ju+Jgz+yZglMKGulE2iJ8bFdUXwkH7bIskSVVAHDBmxdFjd+6yELMycfziVQ//Na
 w0C8sn1e1sw8XDfJCKhzHSUgb/6BUA+vlOOjf6YNX0EYQUjwlhlEhT4tJkuGtajiJ
 LaZRPikM8dOmjNDDZaX37av6hsZ9lrwKUbsJviGbRzd8OlhPz3Yi1XLdzcdZkdGTz
 LJMRY3LVRFRiJBblakV6ZNq6ImnL7SZ5a2JQpiLEqa9HQjAtE6L4r7aPQvOMLHr44
 QD9qiI4EPrFEnBo8c8n0TxJU0XuQB2TAgbnV11ELEA3jPicE0oIu8/XvOcIfhZMdP
 a7ONq4E3wvPQkQDRfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mel7v-1vuRc50dC1-00lCZa; Sun, 16
 Nov 2025 09:56:48 +0100
Message-ID: <ef8c97f0-50ee-49f5-910b-a63842799c87@gmx.de>
Date: Sun, 16 Nov 2025 09:56:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] boot/bootfdt: Add smbios3-entrypoint to FDT for
 non-EFI boots
To: Adriana Nicolae <adriana@arista.com>
Cc: trini@konsulko.com, sjg@chromium.org, ddrokosov@salutedevices.com,
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de,
 kojima.masahisa@socionext.com, richard@nod.at, semen.protsenko@linaro.org,
 joao.goncalves@toradex.com, u-boot@lists.denx.de
References: <20251115111535.39951-1-adriana@arista.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251115111535.39951-1-adriana@arista.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n6T9XW/gUpUn3ZUvOHOqM5wQCnZj+fp+ELPPuWl9gHAPqb4xi1A
 JDLe5ztV9o/T7BBqua5JH1IiQaxy8oisgU9No1vq4zUpj9p5SI9s3etzzq8FelIs7lOQrfx
 1CI4p+/cBVd74BRQ4daOglZ+5tN6/nyhY4qIvkdG5vNUTXF+h/4TTIrtIcUn010IhpjoYfZ
 05vROX4YOcgyAJHisZoKg==
UI-OutboundReport: notjunk:1;M01:P0:p+A/7V0SPlE=;gA+iVZzeWdjqr4FrLh3BwiJm2D4
 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
 Vn/JUCUZ2Hus4RbOKI4PLo4Vx7ZJDJF/j1N4mh
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

On 11/15/25 12:15, Adriana Nicolae wrote:
> From: adriana <adriana@arista.com>
>=20
> The Linux kernel can discover SMBIOS tables through two primary methods:
> 1. Via EFI tables, when using EFI boot;
> 2. Via the 'smbios3-entrypoint' property in the /chosen node of the
> device tree.
>=20
> When U-Boot boots a Linux kernel using a non-EFI command ("bootm",
> "bootz", or "booti"), the kernel relies on the device tree to detect
> the hardware. If SMBIOS tables are available in U-Boot, they should
> be passed to the kernel via this device tree property.
>=20
> This patch modifies boot_fdt_prepare(), to inject the SMBIOSv3 table
> address into the device tree if there is a table generated by U-boot.
> The "board_fdt_chosen_smbios" is weak in order to leave the possibilty
> for specific boards to select custom SMBIOS addresses.
>=20
> The changes in this patch are added in the context of supporting this
> device tree property in linux kernel:
> https://lkml.org/lkml/2025/10/24/1393
>=20
> Device tree schema was updated to include the "smbios3-entrypoint" node
> in pull request: https://github.com/devicetree-org/dt-schema/pull/177
>=20
> Signed-off-by: Adriana Nicolae <adriana@arista.com>
> ---
> Changes in v2:
>    - Renamed device tree property to "smbios3-entrypoint".
>    - Removed redundant check for CONFIG_SMBIOS, ifdef is needed as
>    "smbios_start" is not compiled on some platforms if !CONFIG_SMBIOS.
> ---
>   boot/fdt_support.c    | 57 +++++++++++++++++++++++++++++++++++++++++++
>   include/fdt_support.h | 10 ++++++++

Please, add a test.

>   2 files changed, 67 insertions(+)
>=20
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 92f2f534ee0..f3b8d6fc389 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -327,12 +327,54 @@ __weak const char *board_fdt_chosen_bootargs(const=
 struct fdt_property *fdt_ba)
>   	return env_get("bootargs");
>   }
>  =20
> +/**
> + * board_fdt_chosen_smbios - boards may override this function to provi=
de
> + *                           specific SMBIOS address
> + */
> +__weak phys_addr_t board_fdt_chosen_smbios(void)

Consider moving this function to lib/smbios.c. Then it will only be=20
compiled if CONFIG_GENERATE_SMBIOS_TABLE=3Dy.

> +{
> +	phys_addr_t ret =3D 0;

Addresses in the device-tree must be usable as pointers.
Using the virtual address space of the sandbox is incorrect.

> +	const struct smbios3_entry *entry;
> +
> +	/* Only provide SMBIOS address if EFI is not enabled */
> +	if (IS_ENABLED(CONFIG_EFI_LOADER))
> +		return 0;

This check looks conceptually wrong:

If CONFIG_EFI_LOADER=3Dy, we could still boot via the booti command=20
bypassing EFI. In this case we want to provide the SMBIOS address via=20
the /chosen node.

> +
> +	/* Only proceed if SMBIOS support is compiled in */
> +#ifdef CONFIG_GENERATE_SMBIOS_TABLE
> +	ret =3D gd->arch.smbios_start;

Here you need map_sysmem() to get the pointer to the entry point.

> +	if (!ret)
> +		return 0;
> +
> +	/* Verify this is SMBIOS 3 */
> +	entry =3D (struct smbios3_entry *)(uintptr_t)ret;
> +
> +	/* Check for "_SM3_" signature */
> +	if (memcmp(entry->anchor, "_SM3_", 5) !=3D 0) {
> +		printf("SMBIOS: Not version 3, skipping DTB injection\n");
> +		return 0;
> +	}
> +
> +	/* Verify entry point length and version */
> +	if (entry->length < sizeof(struct smbios3_entry)) {
> +		printf("SMBIOS: Invalid entry length %d\n", entry->length);
> +		return 0;
> +	}
> +
> +	printf("SMBIOS: Found version %d.%d at 0x%llx\n",
> +	       entry->major_ver, entry->minor_ver, (u64)ret);
> +#endif /* CONFIG_GENERATE_SMBIOS_TABLE */
> +
> +	return ret;
> +}
> +
>   int fdt_chosen(void *fdt)
>   {
>   	struct abuf buf =3D {};
>   	int   nodeoffset;
>   	int   err;
>   	const char *str;		/* used to set string properties */
> +	phys_addr_t smbiosaddr;	/* SMBIOS table address */
>  =20
>   	err =3D fdt_check_header(fdt);
>   	if (err < 0) {
> @@ -387,6 +429,21 @@ int fdt_chosen(void *fdt)
>   		return err;
>   	}
>  =20
> +	/* Inject SMBIOS address when we have a valid address.
> +	 * This is useful for systems using booti/bootm instead of bootefi.
> +	 * Failure to set this property is non-fatal, we only generate a
> +	 * warning.
> +	 */

Please, add

         if (CONFIG_IS_ENABLED(GENERATE_SMBIOS_TABLE))

to minimize the code size.

Best regards

Heinrich

> +	smbiosaddr =3D board_fdt_chosen_smbios();
> +	if (smbiosaddr) {
> +		err =3D fdt_setprop_u64(fdt, nodeoffset, "smbios3-entrypoint",
> +				      smbiosaddr);
> +		if (err < 0) {
> +			printf("WARNING: could not set smbios3-entrypoint %s.\n",
> +			       fdt_strerror(err));
> +		}
> +	}
> +
>   	return fdt_fixup_stdout(fdt, nodeoffset);
>   }
>  =20
> diff --git a/include/fdt_support.h b/include/fdt_support.h
> index 47b8b63d13d..ddb8a36cc71 100644
> --- a/include/fdt_support.h
> +++ b/include/fdt_support.h
> @@ -240,6 +240,16 @@ int board_rng_seed(struct abuf *buf);
>    */
>   const char *board_fdt_chosen_bootargs(const struct fdt_property *fdt_b=
a);
>  =20
> +/**
> + * board_fdt_chosen_smbios() - Provide SMBIOS address for /chosen node
> + *
> + * This function is called by fdt_chosen() to get the SMBIOS table addr=
ess
> + * that should be added to the /chosen node for non-UEFI boot scenarios=
.
> + *
> + * Return: Physical address of SMBIOS table, or 0 if not available
> + */
> +phys_addr_t board_fdt_chosen_smbios(void);
> +
>   /**
>    * ft_board_setup_ex() - Latest board-specific FDT changes
>    *


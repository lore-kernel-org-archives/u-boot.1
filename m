Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437A0F41810
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 16:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C291C83F14;
	Mon,  9 Mar 2026 17:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="S6a2W+Lq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B18A83F20; Mon,  9 Mar 2026 17:41:13 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9436A83952
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 17:41:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773074466; x=1773679266; i=xypron.glpk@gmx.de;
 bh=EERdKV6x5aOZlRzTNvrVb7KZbyY74A6+EthEjUOrOi0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=S6a2W+Lqyez2yUpYwRuq6bxQZJibEa03yyvXJGXIWG8wUvOsMOyV1bTpdpiCDRX2
 1NhN52QkfjfAGPqlIvs38O8EVCgdxE0rEmtkbyb0xolzAGqegE+uMU0JskBnK73GQ
 JpBnp8C+pzQf0b0IehTUV8KQyzF3cOKJEei6yee9fjLIAkAHugF30oZOyweDNDbrY
 VGHuemmjC2e4+Wcc7zqX5uPcI+UnBTx1bGUrayl3jjaO1zhk9X506Ju3tX3brxsUh
 TH0KGOOu/voD4MjKQCa2K6yoey4E7ut/aXZG/WXd9LQQ2VQwf5yq4xNUOBrDZjAbB
 e3d44nzR6V7pLI0wcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fmq-1vWnAg19Nw-00wEET; Mon, 09
 Mar 2026 17:41:06 +0100
Message-ID: <9b090f33-cc9d-44d5-b88e-92c0e8a6e6c3@gmx.de>
Date: Mon, 9 Mar 2026 17:41:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] cmd: efidebug: add ecpt command
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260305161349.2317130-1-vincent.stehle@arm.com>
 <20260309163638.2340548-3-vincent.stehle@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260309163638.2340548-3-vincent.stehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lg5afo4uwmgV/VX33sMdQb44ZJgqqUFoiSLh0BMiRUvGJODPhYo
 DYXJhnD1ubGzNyZhK/q5uL4hE740R+wDJ/WbfvkA7/mecsgByJCAnYDWykhXfuz9xGgLy2O
 +EAU98ucCvpsiiVbqa4JJltRBcHDESJw4TqXgMbPFVOq9V3Ua3o5xPY0vyx+9FCeo1oNzJm
 WtFdqtlOZxbTzfABiD1Gw==
UI-OutboundReport: notjunk:1;M01:P0:LjUK0aGXGq8=;rTqarrMWVhzJdW9jc585x0g37MN
 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
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

On 3/9/26 17:36, Vincent Stehl=C3=A9 wrote:
> Add an "efidebug ecpt" command, to print the conformance profiles in the
> ECPT:
>=20
>    =3D> efidebug ecpt
>    cce33c35-74ac-4087-bce7-8b29b02eeb27  EFI EBBR 2.1 Conformance Profil=
e
>=20
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>=20
> Changes in v2:
> - Change log level to error and adapt the printed message (suggested by
>    Heinrich)
> - Also in that case, return an error code
>=20
>   cmd/efidebug.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
>=20
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index 109496d9e95..7b733119c82 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -533,6 +533,47 @@ static int do_efi_show_defaults(struct cmd_tbl *cmd=
tp, int flag,
>   	return CMD_RET_SUCCESS;
>   }
>  =20
> +#if CONFIG_IS_ENABLED(EFI_ECPT)
> +/**
> + * do_efi_show_ecpt() - show UEFI conformance profiles in ECPT
> + *
> + * @cmdtp:	Command table
> + * @flag:	Command flag
> + * @argc:	Number of arguments
> + * @argv:	Argument array
> + * Return:	CMD_RET_SUCCESS on success,
> + *		CMD_RET_USAGE or CMD_RET_FAILURE on failure
> + *
> + * Implement efidebug "ecpt" sub-command.
> + * Show all the UEFI Conformance Profiles listed in the EFI Conformance=
 Profiles
> + * Table (ECPT).
> + */
> +static int do_efi_show_ecpt(struct cmd_tbl *cmdtp, int flag, int argc,
> +			    char *const argv[])
> +{
> +	const struct efi_conformance_profiles_table *ecpt;
> +	u16 n;
> +
> +	if (argc !=3D 1)
> +		return CMD_RET_USAGE;
> +
> +	ecpt =3D efi_get_configuration_table(&efi_ecpt_guid);
> +	if (!ecpt) {
> +		log_err("ECPT table missing\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	for (n =3D 0; n < ecpt->number_of_profiles; n++) {
> +		const efi_guid_t *guid =3D &ecpt->conformance_profiles[n];
> +
> +		printf("%pUl  %s\n", guid->b,
> +		       uuid_guid_get_str(guid->b) ?: "(unknown)");
> +	}
> +
> +	return CMD_RET_SUCCESS;
> +}
> +#endif /* CONFIG_IS_ENABLED(EFI_ECPT) */
> +
>   static const char * const efi_mem_type_string[] =3D {
>   	[EFI_RESERVED_MEMORY_TYPE] =3D "RESERVED",
>   	[EFI_LOADER_CODE] =3D "LOADER CODE",
> @@ -1586,6 +1627,10 @@ static struct cmd_tbl cmd_efidebug_sub[] =3D {
>   			 "", ""),
>   	U_BOOT_CMD_MKENT(defaults, CONFIG_SYS_MAXARGS, 1, do_efi_show_default=
s,
>   			 "", ""),
> +#if CONFIG_IS_ENABLED(EFI_ECPT)
> +	U_BOOT_CMD_MKENT(ecpt, CONFIG_SYS_MAXARGS, 1, do_efi_show_ecpt,
> +			 "", ""),
> +#endif
>   	U_BOOT_CMD_MKENT(images, CONFIG_SYS_MAXARGS, 1, do_efi_show_images,
>   			 "", ""),
>   	U_BOOT_CMD_MKENT(memmap, CONFIG_SYS_MAXARGS, 1, do_efi_show_memmap,
> @@ -1680,6 +1725,10 @@ U_BOOT_LONGHELP(efidebug,
>   	"  - show UEFI handles\n"
>   	"efidebug defaults\n"
>   	"  - show default EFI filename and PXE architecture\n"
> +#if CONFIG_IS_ENABLED(EFI_ECPT)
> +	"efidebug ecpt\n"
> +	"  - show conformance profiles in the ECPT\n"
> +#endif
>   	"efidebug images\n"
>   	"  - show loaded images\n"
>   	"efidebug memmap\n"


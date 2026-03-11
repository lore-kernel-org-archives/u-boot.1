Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324101125847
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 16:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B18128407E;
	Wed, 11 Mar 2026 17:21:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qhDikwoj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78D28840CC; Wed, 11 Mar 2026 17:21:28 +0100 (CET)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29EC38404A
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 17:21:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64ad79dfb6eso73777d50.0
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 09:21:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773246085; cv=none;
 d=google.com; s=arc-20240605;
 b=JY7P3Nxfejh2e1If7WGSBUaF9h+C/H1P6N5I/EZSmrI7ZvjaRn6PGgZ9/0yalbJ1zT
 c3+yphMXwBB9XUJwX/VtAfcehrJBx+GGM5cQ4yYoHXGk9WO4okW7xIfflwH/GiDCggws
 ks/A8D/DlROV/SaeWC8AoZsgT3RHxA8D4X9+f51lmkazXoGFO2yGefsIvyFaM5KIqsxt
 3VuFG6SjptIRqrR9OgMDsuR1ofcxNfb4TOFzoCw9BPjodwQLOcL+FfRtAaruYOc6mHjh
 0scH/KUsycu7jXhczmd+0FVVurVLjbJMjGU5+WzJ1TvfK0dbT/mr8Lxt77WXOsFQlDAY
 Sxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=b/wiXzqyKgZNjj3Kh6/hYfQY1emwMAN9mbR+7FhHE7Q=;
 fh=qVPXZENsT8HTjc1yhpZmugGERdHloY1MZQ2O3ZL3iu8=;
 b=Z6Efp8cgHsbw3Zz95SF0VogTAGKQtpUWJ+laZz1sCyKz90Oy0lzObT4pNQx8ww2bS9
 vA9SLoz6kbv+QmCfF0dBsYeOCwDp+X4T8p67LeHRqtoOOVMGxVmP6RO5eb5fHqfcx9Oc
 imZjsqYLIKgXDTviZzFn1AMtp6IEXRGBoFr5xVGAqReEWlp1flT+IR0T0oE0gYe1VOjI
 lMnt+K02NJIpadXg8z4atuCp5vU/nU/OmQLorupoXXwHjJNjia4VI9B23ghcBZ+0DVqV
 N4rriCZVROkuuSBvhYKNVZSYFoIzdo9o2fELk9iF+oiJ3z0tu1WBODDGu7DODc/B9s1y
 g32w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773246085; x=1773850885; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b/wiXzqyKgZNjj3Kh6/hYfQY1emwMAN9mbR+7FhHE7Q=;
 b=qhDikwojQyVGFcdDSkhDWBi+gHp225jrozGu2MIxMUN5XsVy0pyTJeH6ehMDqxbxfb
 Vs3jE/xJpz6j2h7jS4AXYhmAqloO845ABnGSyKN6Qk+Uc1z3R51K8j4RET4q4T5bWzfl
 YuM/YyeSiHg8eF/IPLb6y7FJmkKPho1EMNOVNrxq9GZH5riWyjlEe+FE38vGxzTkILXB
 813EIPqAzNHNRhN9+5fMnT7i6VhvNyFOjY/jdcFO7NiI80r5+WBHVNUjJ8OCyX1dHqOo
 LRDH8NiiBwh2z0lxMNFALnQHDx4kUF3o0sGv21UEQ6XOiEaXzlQWyTLCOXrMG7G/FDbt
 rWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773246085; x=1773850885;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b/wiXzqyKgZNjj3Kh6/hYfQY1emwMAN9mbR+7FhHE7Q=;
 b=uvC/8ZLlW/Qi+eM+41a4/o4LCiMKEJBGPYq1sRqW0IbwkOyuxn4u7znML9DZTzXwOe
 xh3153gJnIDp3GdEnuEljnToFsYrGbcNPzbDxY4N3ng/FKebFKVDoSZrpbYlHShKQqB4
 oLioxGaWSWYomXq/IZdl+HWiWIBnPpIt7vmT1H8sBwsmrz9hp+ee+0nvqqAjOgRa7I1x
 tWZ7zQPssMNUcilQczcZsx5dp9MEiulgqL7I2isJRZBIXIYgIHxYnSg531/6DpXIif4v
 cVKBh53O1qN+lYyMRGZbXBp2OF0Wt4QTuIoFNtP6Mdj4gRRSD5maKt8/Mb//IjyGEnQx
 nefQ==
X-Gm-Message-State: AOJu0YyfdC0sKi6beiRvMHpVjv/73X0Wp3rSebiJPuAPIlXqlRcDToBU
 exqSx+gaAm0Exfe2j2+aAUE05IjvU2yRCng0PL9q/8gqbkEmewD+wiek0tS/Q4g1W28lFJuPcnl
 cfvNykiWxbOsYAgT8/GvJnMwp91UyGDqNVm3F3rSbAA==
X-Gm-Gg: ATEYQzx5PnmrVQFYFPxYIHKU9gT4ZpbXslh6Wlw2dzdnmxAKwjzVL9DgfbSPF2AocfF
 yBWoV2cpU9THgk6dhBBZ+sW5P62W3gSDNX74duGfebNBwrfHqXY/w2VA5O80ZGy1aeD1WKbGnIu
 AymANULFVIM+qUodClCXRfzKKCSQ27xnt/UBRMvq+yr6RxAJ3z6yASG+hve7tIIyskDMMPyGdWR
 7R+tjBpG8tWTePqhQWz7+rK+oRp4WMHY4eRGmc0D15qH3g80gAENkqrobb9K3Rcz6v3l0/UiN9e
 qFn1rKUHstKm9zpY69ORDA5Ng9d3U5zPu5gwf3jBDiZJNL8pDIoNyAWV5JgRd+JNroKfB7M/eCP
 7BGgj+If2C/RyA+owhF4wHokKOBKkJc3WraCpfy/Cuva4zULfCaaPkZCRNQbwIRGxIFTPCgg84w
 oR3cWFpca46xAfwKZvCQosHIO1UFPci8CodTAP7+X/wBrX4tp4xpniasRDGxsbGJt0uCV/zRFJY
 /05mx+l08lQLdaIXUaHO9ph0zznpOfjp0e5bQu7iVIz7fPW1DjxAzy1XHh3TAdcvzZvHyDNIjvI
 1gRtxwhm020E8yd8yz+I7p96gEkMVPT4DpaAhJsKRw==
X-Received: by 2002:a05:690e:158a:20b0:64a:e0fc:1a70 with SMTP id
 956f58d0204a3-64d657d7e99mr2314155d50.63.1773246084605; Wed, 11 Mar 2026
 09:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260305161349.2317130-1-vincent.stehle@arm.com>
 <20260309163638.2340548-3-vincent.stehle@arm.com>
In-Reply-To: <20260309163638.2340548-3-vincent.stehle@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Mar 2026 18:20:48 +0200
X-Gm-Features: AaiRm5038bcseOxVNVYFVBLXJjBboTEFIRHVj19VqQqtr5_KZj1mMmk9i-agqlc
Message-ID: <CAC_iWjJ9epMEBfxi3rzgqSNQeiu87cxh8Tw4BbM52WAiyuWLQg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] cmd: efidebug: add ecpt command
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 9 Mar 2026 at 18:36, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> w=
rote:
>
> Add an "efidebug ecpt" command, to print the conformance profiles in the
> ECPT:
>
>   =3D> efidebug ecpt
>   cce33c35-74ac-4087-bce7-8b29b02eeb27  EFI EBBR 2.1 Conformance Profile
>
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>
> Changes in v2:
> - Change log level to error and adapt the printed message (suggested by
>   Heinrich)
> - Also in that case, return an error code
>
>  cmd/efidebug.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index 109496d9e95..7b733119c82 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -533,6 +533,47 @@ static int do_efi_show_defaults(struct cmd_tbl *cmdt=
p, int flag,
>         return CMD_RET_SUCCESS;
>  }
>
> +#if CONFIG_IS_ENABLED(EFI_ECPT)
> +/**
> + * do_efi_show_ecpt() - show UEFI conformance profiles in ECPT
> + *
> + * @cmdtp:     Command table
> + * @flag:      Command flag
> + * @argc:      Number of arguments
> + * @argv:      Argument array
> + * Return:     CMD_RET_SUCCESS on success,
> + *             CMD_RET_USAGE or CMD_RET_FAILURE on failure
> + *
> + * Implement efidebug "ecpt" sub-command.
> + * Show all the UEFI Conformance Profiles listed in the EFI Conformance =
Profiles
> + * Table (ECPT).
> + */
> +static int do_efi_show_ecpt(struct cmd_tbl *cmdtp, int flag, int argc,
> +                           char *const argv[])
> +{
> +       const struct efi_conformance_profiles_table *ecpt;
> +       u16 n;
> +
> +       if (argc !=3D 1)
> +               return CMD_RET_USAGE;
> +
> +       ecpt =3D efi_get_configuration_table(&efi_ecpt_guid);
> +       if (!ecpt) {
> +               log_err("ECPT table missing\n");
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       for (n =3D 0; n < ecpt->number_of_profiles; n++) {
> +               const efi_guid_t *guid =3D &ecpt->conformance_profiles[n]=
;
> +
> +               printf("%pUl  %s\n", guid->b,
> +                      uuid_guid_get_str(guid->b) ?: "(unknown)");
> +       }
> +
> +       return CMD_RET_SUCCESS;
> +}
> +#endif /* CONFIG_IS_ENABLED(EFI_ECPT) */
> +
>  static const char * const efi_mem_type_string[] =3D {
>         [EFI_RESERVED_MEMORY_TYPE] =3D "RESERVED",
>         [EFI_LOADER_CODE] =3D "LOADER CODE",
> @@ -1586,6 +1627,10 @@ static struct cmd_tbl cmd_efidebug_sub[] =3D {
>                          "", ""),
>         U_BOOT_CMD_MKENT(defaults, CONFIG_SYS_MAXARGS, 1, do_efi_show_def=
aults,
>                          "", ""),
> +#if CONFIG_IS_ENABLED(EFI_ECPT)
> +       U_BOOT_CMD_MKENT(ecpt, CONFIG_SYS_MAXARGS, 1, do_efi_show_ecpt,
> +                        "", ""),
> +#endif
>         U_BOOT_CMD_MKENT(images, CONFIG_SYS_MAXARGS, 1, do_efi_show_image=
s,
>                          "", ""),
>         U_BOOT_CMD_MKENT(memmap, CONFIG_SYS_MAXARGS, 1, do_efi_show_memma=
p,
> @@ -1680,6 +1725,10 @@ U_BOOT_LONGHELP(efidebug,
>         "  - show UEFI handles\n"
>         "efidebug defaults\n"
>         "  - show default EFI filename and PXE architecture\n"
> +#if CONFIG_IS_ENABLED(EFI_ECPT)
> +       "efidebug ecpt\n"
> +       "  - show conformance profiles in the ECPT\n"
> +#endif
>         "efidebug images\n"
>         "  - show loaded images\n"
>         "efidebug memmap\n"
> --
> 2.53.0
>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF4CD49C65
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 07:26:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BADA84131;
	Fri, 30 Jan 2026 08:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kSuHlda4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFEB88418A; Fri, 30 Jan 2026 08:26:25 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4802684101
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 08:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-79427f739b0so18242587b3.3
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 23:26:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769757981; cv=none;
 d=google.com; s=arc-20240605;
 b=L5s660/S6NEqlTXAN6Ij9dQ7L0L7oQbNxx2H83a9WGf5yp3e9WWffB9sfahwBJ3Q13
 HfHd7FfnSgPS1UqV88A4MSZ2we0A+nOEpmrUvWUyN7Y7YrA/xNt+krWF3IzUb/1bjuiS
 gv9jqqI5FpVgoNZyEDMqHgyhWPerJwv2dw0AZIoFrtK6ag/gdWJD1w9amV9gibpokyEF
 Pfs70re7IuXqdHOVX1e9ECAS43L+NPLPbzsRkIdjXwS8LmE+Xwgs2KV8YduHBgt50bgZ
 gMqlh8pCAGxv6BIaCK067fyzcn+MoNnxk4f3hKrOrNwsgPO7x8jd8WlB/XS8gZ8EaPTN
 cpFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZYTnHN1A024bfFySKV4Riyu7mzhGJ2L2QM0dCqpFsyQ=;
 fh=omMQb5rW44y7vyeSKMXjAMl+ucsSYPjf1R95uleYbSo=;
 b=PZpiOHCB4TuJuWJXLmzVgKwkGQouTrxk9xmxQ5LCwDKlmcty6Kqw31LilC2qp71KOa
 JLwjdD7SJykwgZc8NGDZvw5qBlcqHT5HA2fqdS5Udrc/oiR4x2AVqC/CsF5UV18xBuIC
 QYqEkLv/MqrpBIQkxZ1CNlzLLQyMfOWv8cnovyY39ujBB7bpfZkDuK6enh+CJzCG/CEW
 RMbCePjMKneN05fAC9h17VzwZjgn8V1fC95afGZPmjAiqMG29rrjgrL+Va9YBRjyIDzK
 7MfgEqkSDSpnh27Uj9ekc2mU3RykQvXyktgk4CMbaeGlNcZ0Q2adyRPdFoWS8F80UB9w
 N/Hw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769757981; x=1770362781; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZYTnHN1A024bfFySKV4Riyu7mzhGJ2L2QM0dCqpFsyQ=;
 b=kSuHlda4AxIOWg3EkpDfUD/Y62o2pYTH+H1a9s8OeJii2bYJIwX8HiBHJk7Aoztu6b
 nrqb1ccRQrUP1RoB/R/MrePWLMoFYCLn0g1rroHm1GgDfSiX7L1mVfaHG8qlEq/JBiWD
 d5Yla3ND/kYHdz/c09XjHP4Jr6aPrnyFPmGN3+Oa9SJv0mzxkUfKz4Ww+BRCd4LMrhdE
 1CZnWfu94pMvn1GnaAnJrHmuque6Gbexe5T+fH+eiFliAmOdsHmd5S/yMkL6wiN/yyOu
 As31zjOZGi4rYMuVb1xcz22cRTeqoL+jFaEf1MRLWV/ZoINcGE3lh0AxPUGGBilpTffj
 XHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769757981; x=1770362781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZYTnHN1A024bfFySKV4Riyu7mzhGJ2L2QM0dCqpFsyQ=;
 b=TO0jJ4sD88qerWZUHYI++e8c2ZxdbObgZ9A1+oKHFMPaNmu5IPGUfQQXboahJbM7oY
 oQK3SVNmtzdTPjRfvjty7k6/ozCXKRYFNJVV57ssrbO2Gd3a4KoN2CptLhGxJxDvNNw6
 a5H2g8HqLAxvI2dJe9fTNHC82/fWrTVBUZppSrRd/VmmSfeYb6uI6EB311lOu98ct0CM
 A/zJ6j4UnP7DVApefxtKUzpLO9DsqmKoxCMVb6R3p0UJpZoDscx8WWVHB19liAmm40Jv
 k3voKJ3Pcki7VOKnUOaasvW+w+cTVxk7Xcu/wFzyVYWnwS5SneKC2CBGs8uRMP/reDVJ
 17Pw==
X-Gm-Message-State: AOJu0YxFw5dswjstJZzQXjUEl5PTHy0EGuwaArgr2Zky+SRvFXwiHrU7
 OyoOdR4Y5yQm2DMuYHwXfILpJbcVia+wqX6QN1Z602fCcfAF2fr/2BVrCJhUl8VN02ATZ5YdYk9
 YX5USDlASFnQ82MRrS7XPFmMj4+h6/HmzVt0VRhOzgQENKHa8nzFj46NBKA==
X-Gm-Gg: AZuq6aKOX6AT7JwkrlC26A9cKLAUgaoifuJIkFJTjn9Y7/RRN0C9vpiNSw1UAzf8XjZ
 MpQxIgGKCEPZWzB1qI/wuXXo3k0wZISusqcNcUJ/iSl2k1XbbXeax12dOkDCIszdl9Wy4JNQhfr
 GHmh+AUlQQ44p/T+KVMsdAH1tb/W3iQ+rPxw4KT35DYMNdTs5JksJu/R3yV/heBS9OpFvilJg25
 z12xRCOifDaWWyGI9wcNBVKXC8A75c0+kyxaZZchwxbCW+vQhsVuL3QlkHM+ZU/W1TiEVi3orhP
 FdyJgCUytABJMqGAKJMzipaJbSc6BdzvC2NA0OPPIHio6Kaui7VX/sYafqqF5+00eY0Niqbs7yr
 WUbeJeuQbC079bnPPmoNFh6VhhjdTjDYaIyuknccc3m8x9cHXgwE4J9/HuIaugwPmc64Rh+KiMs
 sHfTXkdzoB9cz/5ALpBFFunVTgKoen4oYKz/n2w8eoxCDQRt4NavPJwNAQVgyENS8ogq+BnX/JA
 +MNCguvh1WXaoIEFV1hWnkLRMdCOlEWCLUILZgtCORdQTT45pyiruJoaja9EEnOgt3ERnxPO9hf
 WA8ON/irdqIfEorcKfYmmj22ePlH9s9sOWdqYKTEqkc=
X-Received: by 2002:a05:690c:6d8b:b0:792:7338:6981 with SMTP id
 00721157ae682-7949deb8288mr20356887b3.22.1769757980961; Thu, 29 Jan 2026
 23:26:20 -0800 (PST)
MIME-Version: 1.0
References: <20260123105814.1083834-1-vincent.stehle@arm.com>
In-Reply-To: <20260123105814.1083834-1-vincent.stehle@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 30 Jan 2026 09:25:45 +0200
X-Gm-Features: AZwV_QhWM1DRkbiF4uDPItFZLeZ-Cu2QPFmlWBiJkBhdygCbPUPtG3rQfHPo1NE
Message-ID: <CAC_iWjLtTBrm2AS4runbUDEgrKf+nALBBPYXcxozq=_dhU99aw@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: fix use after free in efi_exit() with tcg2
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <masahisa.kojima@linaro.org>
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

Thanks Vincent

I also tested that PCR4 remains unchanged after the patch.

On Fri, 23 Jan 2026 at 14:58, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> =
wrote:
>
> The efi_exit() function frees the loaded image memory by calling
> efi_delete_image(). However, when CONFIG_EFI_TCG2_PROTOCOL is enabled, th=
e
> image_obj->image_type structure member is accessed after the memory has
> been freed.
>
> Fix this by keeping a copy of image_type, as is already done for exit_jmp=
.
>
> Fixes: 8fc4e0b4273a ("efi_loader: add boot variable measurement")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> Hi,
>
> This can be verified with sandbox_defconfig + CONFIG_VALGRIND=3Dy and the
> following command:
>
>   valgrind --suppressions=3Dscripts/u-boot.supp \
>     ./u-boot -T -c "setenv efi_selftest start image return; \
>                     bootefi selftest"
>
> Best regards,
> Vincent.
>
>  lib/efi_loader/efi_boottime.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.=
c
> index ddc935d2240..0b3f2fd276c 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -3453,6 +3453,7 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t im=
age_handle,
>         struct efi_loaded_image_obj *image_obj =3D
>                 (struct efi_loaded_image_obj *)image_handle;
>         jmp_buf *exit_jmp;
> +       u16 image_type;
>
>         EFI_ENTRY("%p, %ld, %zu, %p", image_handle, exit_status,
>                   exit_data_size, exit_data);
> @@ -3496,13 +3497,14 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t =
image_handle,
>         }
>         /* efi_delete_image() frees image_obj. Copy before the call. */
>         exit_jmp =3D image_obj->exit_jmp;
> +       image_type =3D image_obj->image_type;
>         *image_obj->exit_status =3D exit_status;
> -       if (image_obj->image_type =3D=3D IMAGE_SUBSYSTEM_EFI_APPLICATION =
||
> +       if (image_type =3D=3D IMAGE_SUBSYSTEM_EFI_APPLICATION ||
>             exit_status !=3D EFI_SUCCESS)
>                 efi_delete_image(image_obj, loaded_image_protocol);
>
>         if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
> -               if (image_obj->image_type =3D=3D IMAGE_SUBSYSTEM_EFI_APPL=
ICATION) {
> +               if (image_type =3D=3D IMAGE_SUBSYSTEM_EFI_APPLICATION) {
>                         ret =3D efi_tcg2_measure_efi_app_exit();
>                         if (ret !=3D EFI_SUCCESS)
>                                 log_debug("tcg2 measurement fails (0x%lx)=
\n",
> --
> 2.51.0
>

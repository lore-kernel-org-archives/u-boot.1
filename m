Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6ED606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=azSZn9p9;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qxsWof8i
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32E4681226;
	Fri,  6 Nov 2026 13:05:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g2Km1SqauuBt; Fri,  6 Nov 2026 13:05:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7075481217
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793970324;
	b=B1zprL99WOIRWR02ZOIpM/9I7evi4c5neHRK6++5do3EiDju9Mk15ce0txVpne1oTZfO
	 9BHIokG2Azc4t4BRrOXxuqdxPVH7smxqRMPW7A1spPHC4z1MRamdKGnNzSCWSIIErRmKx
	 x97CYmaZJ2tInWDmmDlQfdPU0q2t8uOqCh8p4GQhfQBBswvhZukk4NaoXTdDWINqnlDno
	 2Z2Z//vY9ELAzxrn5kMvhJpTMwAc0ccVog5uEI1AYtLeOhGKbpefbjXMn8LVbsxdxF5EQ
	 Nn9rIE8vB5G7z+5Zp+DcqjY5NXUCKfQCUtp0TllQfs3DLCJ713B1nYjFV6OARK+DU7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793970324;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hpZmeMUravTbmBsUCPO2jq8WUdQVJMWvTA5eP0W5f5k=;
	b=ji1c4/IZNwu3GwHsLshUEgDpsHn86N3rS+0DYQ7NKxIS8ZAxvykvijLxLafQySbC/C6j
	 jC8Jr2jCIu9oKgCr5ISffCEyX9j0HHHBAyXoMNxDmWrI9pYMw7YWrXRSQl4VaBx2ub095
	 bcAF6oQLIxY6kXTwcIvcLjHZdHh6n1G+dKqz5wzE2DgyWaSqtSo1Dtq4BEad1Ho8uJgda
	 26BdDbc15lpUQzMaV454bdTT0t4rW1faxekqyLsCbaH0qPxfeKGuPvxuL+E05u9sFOHQU
	 f1Y52S4vCDULZOMX1ABwhke8UmsojFB1lqmIpS7wvtFa80iCsxSGs92tjWMzk+at9PA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793970324;
	bh=hpZmeMUravTbmBsUCPO2jq8WUdQVJMWvTA5eP0W5f5k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=azSZn9p9+riauCvWmYy5Ol8TCN35Q+gqWrFrg4rnKqaHjdD+WLstJRpsb4K067o2g
	 htWuohBeIrxjzUyoSRHtQtDN4b123AciU267p8j8Y5h4Slx3/x7sQpcm3/QCMGRz/o
	 BPcaPaJ3rNXZsBfQFuFaxkHgEjWZGuexVoPv1Kx/1cT8umHsd2l7IAyL6bj/q06ytj
	 1TSnCrT5mr+MLPbDFlgu9AdhdGXlixp8h1o+6AzVHdrkF2esqY03b268BVgTXbPNcl
	 YAwtnCq2s5jPbMbhPc5x3tysGff+6xAoG/Ln1P1C1FTyJ0fvuLDPJ7uZd156pFcL0B
	 CYIFd9HawyIhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7075481217;
	Fri,  6 Nov 2026 13:05:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EE7702AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:05:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DEE1E407D4
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:05:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dmj3Tje-nhJv for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 13:05:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D40CA4074E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112d; helo=mail-yw1-x112d.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=qxsWof8i
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D40CA4074E
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:05:21 +0000 (UTC)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8b0d126f631so4622707b3.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 05:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793970320; x=1794575120;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hpZmeMUravTbmBsUCPO2jq8WUdQVJMWvTA5eP0W5f5k=;
 b=qxsWof8i6/gTwJNs/PPsSLEVV9pQRBt8qE4PmeJjqpCxWdCUTvsKlO/NIGgWWyjqYX
 sqrnrhZPnCLGyuYSQVeAR1AwFjU6V3zXTKu09TyLT0JfwCTOQSyWDdvOp437MimEQBs7
 AbmitwFBvi6qN6zCBMcLmhroBFdLH0GlJJJ8t+PIb71OrvtjslK9kvUKAGc5h3D590y9
 jwyO2PeuzB4jOShBeKr6AsIM0mDgbK22mWwk4HrVXx4ed9bMc15rt+1wSq0mltgJpB9o
 X9tD+90+cwN3tIpAd3UXoFf9OcMCmXV1dGL+UrMjNHaWlAhOQxv19o0UTDDE5NPXijEZ
 wYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793970320; x=1794575120;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hpZmeMUravTbmBsUCPO2jq8WUdQVJMWvTA5eP0W5f5k=;
 b=o8G7V+EPZ1+7RXxU/pE/+Og+o+2/eyPuxwoYjhoRnJKF+jdR+SGU10Ox3CcHTfTydg
 ceSF63IJmrxZH+KAGCebctudgYQkD5JPh7airyseFpgENhMRTyWK65GCMFihLCljJG2y
 0F9NV53pj7MorqWCa48kkEuq8E57t+wndYxNPbGUfE3oSyAXFlc6WlBmli7K/FIuZy+Q
 aJslAjCtCtuOXzkJMnftkq/OY4jgp2zBES/hSb/C8hoLMDHNZTr0LXuMU7qCx8erQf2M
 z1FQAPydNby8aMu6aaRBSPEehSekP7mBxgvYJ3Jcby3yIWgFG4PyQDLG1Yqj/zW8pRAp
 7PpA==
X-Gm-Message-State: APuU4Z9PBWl4Zg+FLssaZF99ZBdlVAH9eIEB+le90fcy+XYQ7yz8HKxJ
 +RDjF+Usr3aBXM39INk0zO8SCJtSBbLn8tDgiUspt9GN4laxrNBCEUymghNu3/jIqOZivdEIewd
 uz/Ues9eRGNhyjuFXaIRuf3Y1RvmINpIvrE8VjPfXfQ==
X-Gm-Gg: AYBFou2vx4dR8EqEYErrQeNPpN++CeyJ8750hTh2gCo15lp8rG0buYT1mqtlFOmL0Dw
 9W6C0RrxhWUFxfXopFFDVuyxtIpHTFeobps7/2/dpUDI1ynX+VBDDZDHZR58lsP0aXMpAdDl7F4
 LvjZT06ogL9w0shtV8m6rcX9BPDrxDzI2b04JVAUKz2i6o7QSw7HpcyaUZJ3RVLA1hAzap5wUhf
 F4Wdk55hlDCr7Mo+jA5U7jhTnHeP5gGW+FtfF+TpclpjhLrpRmfZTBIJ/gfIqCfLybN+tpo2Mem
 PPoNNgVZyt7qaSYaZ8RkX4agzRwUlut20OL5trqrloQMWdraxE/qkTdy3quOqcrIJAgJ6uefNPf
 JL79suVjwDKAK2t9rKoYCrZfhNLwFWtdir1cTKx6o8BcyXJxV1zdbJ4JUvQpw0r0Tt+nHuLWpMx
 hCSPMyVv76vTcingHgC6imjSji/5yLzC5HhUCZqgY3r/IlUY+N2XGMJMEZ7M7XQxkp/WvDxLPJ9
 8YHid4Zt+kNlqEH7LAB2aecKS71MMjqd63/91YmnFEVg47rVl0ksHO2Z5zHeKYOLZ/27JIFlFoe
 ncWfkxnamYS5XPApzYHW9vKXB5CWqHmRit9Sz2Qvc8Iw6vSwJeX2yB52A0cXu3M0TrfghxVcDkf
 zVUcIKkhRUnS0gl9RQhjnO/iDJwvmtw7ICIMLFk6lIp+Gp3unkiVX1N3J/MvzMnG4K7lsDGX5/y
 Jb18BbwTc3e0vpJqJyk+DG+8tZuQAaGeAkH/A=
X-Received: by 2002:a05:690c:9304:b0:8b0:e030:8999 with SMTP id
 00721157ae682-8b34191655amr11956787b3.19.1793970319948; Fri, 06 Nov 2026
 05:05:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <ad3fd084-d61c-44e2-980f-c978ca1e1dbf@gmail.com>
 <73227aa2-9e4d-422e-8999-b873945828c9@gmail.com>
In-Reply-To: <73227aa2-9e4d-422e-8999-b873945828c9@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 6 Nov 2026 15:04:43 +0200
X-Gm-Features: AclHuK-s3XBxSa8C8g5ob1-PylZwmaarQD4u9wPq0CsaAJyPxQFPTbCXB44GeEs
Message-ID: <CAC_iWj+0_70nD0YD2sTgfaYJnUYm4ogy_91FKAJA=eR5pR-iEg@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] efi_loader: refuse a PE image of an unknown
 subsystem
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 at 18:13, Ana Bobillo <anabobillo3@gmail.com> wrote:
>
> From: Ana Bobillo <anabobillo3@gmail.com>
>
> efi_load_pe() loads an image whose Subsystem field is none of the UEFI
> image types as an application: efi_set_code_and_data_type() only logs
> "invalid image type". Such an image is then not measured by
> tcg2_measure_pe_image(), and efi_start_image() does not measure its
> invocation either, so with measured boot it runs without a trace in
> PCR 4.
>
> The UEFI specification defines subsystems 10, 11 and 12 for UEFI images,
> and LoadImage() returns EFI_UNSUPPORTED for an image type that is not
> supported. EDK2 does so in CoreLoadPeImage(). Do the same here, also
> for IMAGE_SUBSYSTEM_EFI_ROM, which was given a runtime driver's memory
> types but could not be measured either.
>
> Fixes: 36b41a3cedd6 ("efi_loader: allocate correct memory type for EFI image")
> Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>  lib/efi_loader/efi_image_loader.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> index 5a784bfb43a..a0879f18621 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -252,8 +252,10 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
>   * @loaded_image_info: image descriptor
>   * @image_type:                field Subsystem of the optional header for
>   *                     Windows specific field
> + * Return:             status code, EFI_UNSUPPORTED if @image_type is not
> + *                     one of the UEFI image types
>   */
> -static void efi_set_code_and_data_type(
> +static efi_status_t efi_set_code_and_data_type(
>                         struct efi_loaded_image *loaded_image_info,
>                         uint16_t image_type)
>  {
> @@ -267,17 +269,15 @@ static void efi_set_code_and_data_type(
>                 loaded_image_info->image_data_type = EFI_BOOT_SERVICES_DATA;
>                 break;
>         case IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER:
> -       case IMAGE_SUBSYSTEM_EFI_ROM:
>                 loaded_image_info->image_code_type = EFI_RUNTIME_SERVICES_CODE;
>                 loaded_image_info->image_data_type = EFI_RUNTIME_SERVICES_DATA;
>                 break;
>         default:
>                 log_err("invalid image type: %u\n", image_type);
> -               /* Let's assume it is an application */
> -               loaded_image_info->image_code_type = EFI_LOADER_CODE;
> -               loaded_image_info->image_data_type = EFI_LOADER_DATA;
> -               break;
> +               return EFI_UNSUPPORTED;
>         }
> +
> +       return EFI_SUCCESS;
>  }
>
>  /**
> @@ -1109,7 +1109,10 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
>                 IMAGE_NT_HEADERS64 *nt64 = (void *)nt;
>                 IMAGE_OPTIONAL_HEADER64 *opt = &nt64->OptionalHeader;
>                 image_base = opt->ImageBase;
> -               efi_set_code_and_data_type(loaded_image_info, opt->Subsystem);
> +               ret = efi_set_code_and_data_type(loaded_image_info,
> +                                                opt->Subsystem);
> +               if (ret != EFI_SUCCESS)
> +                       goto err;
>                 handle->image_type = opt->Subsystem;
>                 efi_reloc = efi_alloc_aligned_pages(virt_size,
>                                                     loaded_image_info->image_code_type,
> @@ -1126,7 +1129,10 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
>         } else if (nt->OptionalHeader.Magic == IMAGE_NT_OPTIONAL_HDR32_MAGIC) {
>                 IMAGE_OPTIONAL_HEADER32 *opt = &nt->OptionalHeader;
>                 image_base = opt->ImageBase;
> -               efi_set_code_and_data_type(loaded_image_info, opt->Subsystem);
> +               ret = efi_set_code_and_data_type(loaded_image_info,
> +                                                opt->Subsystem);
> +               if (ret != EFI_SUCCESS)
> +                       goto err;
>                 handle->image_type = opt->Subsystem;
>                 efi_reloc = efi_alloc_aligned_pages(virt_size,
>                                                     loaded_image_info->image_code_type,

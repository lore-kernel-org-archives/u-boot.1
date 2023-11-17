Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD8DC5AE4B
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 09:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE35B8718B;
	Fri, 17 Nov 2023 10:43:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="vHyrGFTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B9178718B; Fri, 17 Nov 2023 10:43:22 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD51386FFE
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 10:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9bf86b77a2aso251824866b.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 01:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700214187; x=1700818987;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0B1M/uJyHnCwyPu1+kqb9yMCixFmENPaV6B9FSiEHjQ=;
 b=vHyrGFTUHGwCARiC4kkbKrLBYwX51gQwrZ0o7WRjeUrdC3iUlz+M5RametLiCFXDqh
 zcv9rFIxyKLLPK2armRzDIcUkuRCiH/AT23AiLihndqwN92QNwCjFVnp7kTkm27QW0YC
 xXnvMe4hC0I5Wdy5vuevSLkCrR+cV1ji1nOz3NS0Kb85aoSUMHGMdgUsfoPSr0WALU+k
 BRWgv46/W3PasXwmOcl0eZGm+e22Ez+qQBwtBZ6mYSFFK/CJnZRWcMAEgJPDiFp/LkVR
 VhOz7hsC0QLJm2XbmDzhQE1uJkrc1fjG5i7fdAIV/dUQNrAIHk+M8fo/rDFAMMOUANpg
 ZqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700214187; x=1700818987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0B1M/uJyHnCwyPu1+kqb9yMCixFmENPaV6B9FSiEHjQ=;
 b=fOZylDZQMU8U7hR3fMHq1B4TGxdRNUt5vOZ0LLmvf4eB03yXblQ87v6p6DECjFUoFp
 1Nm6sp3mlfzxN1DNcok6eAqD1v4LufN9SXNrBij7JBr4zidCJyG6tVtSBSecdKuhj275
 Ut2tmHkwOBj0iKtiuJYWnXlKmn0wDPf45Xz9SI96k0h/ErYkqkbZi6GAVNE2odY/DYAX
 vzUc/c0MsUu1wnwLrrKlS2s5QVvpUzNbDvFoaf+Y8CY+ZmG81du3vUkW2Iw6s/hdHTG3
 BQjauH7NXV3wTiZWp7xRNaNVb+VSEi0XUrzAvFTZqy+PP1Amk2GEDXtGzqVJL1kBOeRa
 9Jlg==
X-Gm-Message-State: AOJu0YyHxqDSZY+PPJIyAxPnG44VAv5ATzRnGDw1mj/LyLl2gvyZkOML
 bR0bIWeHUWtSr3XomXTWN6O9L03KlTRP0qwctiAk5V8c
X-Google-Smtp-Source: AGHT+IG7GHYCtwXUpnR/dsq+E4rKBPYGHiyP/6Qb2d4vBi/0sQ6ymJqXRB3xN74yDlBnixVpuDby+Q==
X-Received: by 2002:a17:906:7d4:b0:9e4:7b7:267d with SMTP id
 m20-20020a17090607d400b009e407b7267dmr13573949ejc.52.1700214187018; 
 Fri, 17 Nov 2023 01:43:07 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com.
 [209.85.208.42]) by smtp.gmail.com with ESMTPSA id
 ox17-20020a170907101100b009920a690cd9sm592760ejb.59.2023.11.17.01.43.06
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 01:43:06 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-544455a4b56so2513792a12.1
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 01:43:06 -0800 (PST)
X-Received: by 2002:a05:6402:3483:b0:540:1bc0:65b2 with SMTP id
 v3-20020a056402348300b005401bc065b2mr17009081edc.10.1700214186014; Fri, 17
 Nov 2023 01:43:06 -0800 (PST)
MIME-Version: 1.0
References: <20231115183522.1.I4cbfd34d576c0ad66a74c6ec3e8024adabc73573@changeid>
In-Reply-To: <20231115183522.1.I4cbfd34d576c0ad66a74c6ec3e8024adabc73573@changeid>
From: Shantur Rathore <i@shantur.com>
Date: Fri, 17 Nov 2023 09:42:54 +0000
X-Gmail-Original-Message-ID: <CAHc5_t16xQfk=77iq=9T7QwiZUbRBOpzARcvUOqTwhEjAx7rSw@mail.gmail.com>
Message-ID: <CAHc5_t16xQfk=77iq=9T7QwiZUbRBOpzARcvUOqTwhEjAx7rSw@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Avoid freeing a non-allocated buffer
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, Nov 16, 2023 at 1:35=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> EFI applications can be very large and thus used to cause boot failures
> when malloc() space was exhausted.
>
> A recent changed fixed this by using the kernel_addr_r environment var
> as the address of the buffer. However, it still frees the buffer when
> the bootflow is discarded.
>
> Fix this by introducing a flag to indicate whether the buffer was
> allocated, or not.
>
> Note that kernel_addr_r is not the last word here. It might be better
> to use lmb to place images. But there is a lot of refactoring to do
> before we can remove the environment variables. The distro scripts rely
> on them so it is safe for bootstd to do so too.
>
> Fixes: 6a8c2f9781c bootstd: Avoid allocating memory for the EFI file
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reported by: Simon Glass <sjg@chromium.org>
> Reported by: Shantur Rathore <i@shantur.com>
Tested-by: Shantur Rathore <i@shantur.com>
> ---
>
>  boot/bootflow.c     | 3 ++-
>  boot/bootmeth_efi.c | 1 +
>  include/bootflow.h  | 5 ++++-
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/boot/bootflow.c b/boot/bootflow.c
> index 6922e7e0c4e7..1ea2966ae9a5 100644
> --- a/boot/bootflow.c
> +++ b/boot/bootflow.c
> @@ -467,7 +467,8 @@ void bootflow_free(struct bootflow *bflow)
>         free(bflow->name);
>         free(bflow->subdir);
>         free(bflow->fname);
> -       free(bflow->buf);
> +       if (!(bflow->flags & BOOTFLOWF_STATIC_BUF))
> +               free(bflow->buf);
>         free(bflow->os_name);
>         free(bflow->fdt_fname);
>         free(bflow->bootmeth_priv);
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index ae936c8daa18..9ba7734911e1 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -160,6 +160,7 @@ static int efiload_read_file(struct bootflow *bflow, =
ulong addr)
>         if (ret)
>                 return log_msg_ret("read", ret);
>         bflow->buf =3D map_sysmem(addr, bflow->size);
> +       bflow->flags |=3D BOOTFLOWF_STATIC_BUF;
>
>         set_efi_bootdev(desc, bflow);
>
> diff --git a/include/bootflow.h b/include/bootflow.h
> index 44d3741eacae..fede8f22a2b8 100644
> --- a/include/bootflow.h
> +++ b/include/bootflow.h
> @@ -43,9 +43,12 @@ enum bootflow_state_t {
>   *     and it is using the prior-stage FDT, which is the U-Boot control =
FDT.
>   *     This is only possible with the EFI bootmeth (distro-efi) and only=
 when
>   *     CONFIG_OF_HAS_PRIOR_STAGE is enabled
> + * @BOOTFLOWF_STATIC_BUF: Indicates that @bflow->buf is statically set, =
rather
> + *     than being allocated by malloc().
>   */
>  enum bootflow_flags_t {
>         BOOTFLOWF_USE_PRIOR_FDT =3D 1 << 0,
> +       BOOTFLOWF_STATIC_BUF    =3D 1 << 1,
>  };
>
>  /**
> @@ -72,7 +75,7 @@ enum bootflow_flags_t {
>   * @fname: Filename of bootflow file (allocated)
>   * @logo: Logo to display for this bootflow (BMP format)
>   * @logo_size: Size of the logo in bytes
> - * @buf: Bootflow file contents (allocated)
> + * @buf: Bootflow file contents (allocated unless @flags & BOOTFLOWF_STA=
TIC_BUF)
>   * @size: Size of bootflow file in bytes
>   * @err: Error number received (0 if OK)
>   * @os_name: Name of the OS / distro being booted, or NULL if not known
> --
> 2.43.0.rc0.421.g78406f8d94-goog
>

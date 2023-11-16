Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F1EC197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 11:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A540E8654D;
	Thu, 16 Nov 2023 12:02:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="PL/PK1z+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9546587206; Thu, 16 Nov 2023 12:02:43 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D25F80245
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 12:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5431614d90eso961857a12.1
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 03:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700132553; x=1700737353;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oO8gCuH2RoASkbDI42KgbpKEtc0AgHfyoLgT1HdILgk=;
 b=PL/PK1z+a2bzbKGgZcCPUJS25paZqcWVUa7UOH3XKNp5z6H5oSIw1MXLjXUAbEwBcd
 Nwpc+NA+EiYWh6nEm0lFINAv9/vrZN1dfuNpIF/nBNz165U77AXlvsxr8d7tezaY54T8
 29hN6RW1IgaXLC6wO7NBOV58nW8hKUp7Zx8qmkNHLNATRo9br60pe449Wh8j3Bh1EhKe
 mLdp4o+yM/UTAkRCjV5o5rZDnyFkT5VLST2953aCJDqEfXKXYrExhhCYQkboMkWfo7Jt
 fJ9/SrB6Sp0cdTyDN529ItxIvuE0oIZv61OuyeTUKdMsr4uHMTHH457F1HYtXryHi+S9
 ho9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700132553; x=1700737353;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oO8gCuH2RoASkbDI42KgbpKEtc0AgHfyoLgT1HdILgk=;
 b=Ae9HsCJe6s5JiqJ7j4r2vMmr8EIDVU1WmMFoCIIb7OcxryufBVAtXO0N1UM3URSQWD
 WKPyUcyu595FIH1PRiqXgxcj/zMUkWihkaCHBsqL6pGyuAt6Bg/1xulBOatdBVCjus+Y
 GEoGkNUg1+bPegibqqkfpdAYb7Ve6R11fd7KN/MDGOgmh+LCYyO0zL4QrM2mj/CxZd8f
 9ti9N8nru1Bpu3r/jAU0x0hsS/OYzRBvm+2tQt0totNYq4rK1GLZLMJn7oLdVu9qLkp2
 3j+PIiIE6AH3uW169lVIkrGDoSz7xau+sYatXmc8MQRoeqAtaXbgr0EZAD4VuMuH55iB
 vmig==
X-Gm-Message-State: AOJu0YyM5qZWp7A9qc9ZVfOnDSotmSPWp60FJRRUfVxhNPpNW961pTb9
 y495FHNiIPZqzH5mS84RdJL0mRhD26k4Pp4pk1yKw5bQ
X-Google-Smtp-Source: AGHT+IF4BQGFRSn8mbwcgXv2Jy58ygQJ2LRZ2jyDtuQogVGuZcfsFP69uAqSrU5XLGIFU+3SXAHdRg==
X-Received: by 2002:aa7:cf12:0:b0:526:9cfb:c12 with SMTP id
 a18-20020aa7cf12000000b005269cfb0c12mr10245794edy.38.1700132553095; 
 Thu, 16 Nov 2023 03:02:33 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com.
 [209.85.208.48]) by smtp.gmail.com with ESMTPSA id
 v2-20020a50d582000000b0053e3839fc79sm7514767edi.96.2023.11.16.03.02.32
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 03:02:32 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-53d8320f0easo950908a12.3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 03:02:32 -0800 (PST)
X-Received: by 2002:a50:fb97:0:b0:53d:d879:34f3 with SMTP id
 e23-20020a50fb97000000b0053dd87934f3mr12994894edq.1.1700132552331; Thu, 16
 Nov 2023 03:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20231115183522.1.I4cbfd34d576c0ad66a74c6ec3e8024adabc73573@changeid>
In-Reply-To: <20231115183522.1.I4cbfd34d576c0ad66a74c6ec3e8024adabc73573@changeid>
From: Shantur Rathore <i@shantur.com>
Date: Thu, 16 Nov 2023 11:02:21 +0000
X-Gmail-Original-Message-ID: <CAHc5_t3AC7WWcJSajL6o-Kr1p92BfcWxSdCb6K-LBP980wQQNA@mail.gmail.com>
Message-ID: <CAHc5_t3AC7WWcJSajL6o-Kr1p92BfcWxSdCb6K-LBP980wQQNA@mail.gmail.com>
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

Hi Simon,

Thanks for the patch.
Ater this patch, booting off USB works fine over USB disk.
Maybe you need the same flag for dhcp as well just after dhcp_run() here
https://github.com/u-boot/u-boot/blob/master/boot/bootmeth_efi.c#L356

Kind regards,
Shantur

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

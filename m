Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CED3C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 00:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40D9986F67;
	Fri, 17 Nov 2023 01:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="O2pihF7B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3630386D9A; Fri, 17 Nov 2023 01:36:34 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6469F8746C
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 01:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-507962561adso2154372e87.0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 16:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700181365; x=1700786165;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IvZf+/8FSjBKre8WabLsXf8/rtu1MkEH5hHXbGva9sE=;
 b=O2pihF7BG0mKPuhx+VZq5Oxcd/bUrc99fkvX3JgYWweqyt88/DYMlaHBkBZy0NDvWq
 wggRYyNN+L54gB1CBepHJSJ0PZELcF8ogwLbIqsfff7WUMsmBZD+osE/9ToH48I7xFOW
 6RPWG62gp0Suv7EEg3vDosyQLOAst45xL0S+0uP72/h9VRCaqcfToSsU2WrNyTdya7Xa
 ACwnxCz1O8QvTPbttwv5x0t8xcDHRGv92bQa282nY5ZkAJBYo7GepKCEKi8RpUdkjIx6
 5KnyX6IIUGo7H+eCdvl+f0htcIet4k1H41mL+DtlcaNofEXOnnXB6rD0/LHwzx7jYb5t
 Zb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700181365; x=1700786165;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IvZf+/8FSjBKre8WabLsXf8/rtu1MkEH5hHXbGva9sE=;
 b=UqDe725ztsPF6SN2dWtq79vee4bxUESUgcHyam8juJNUcEoMVs0/WW7Bteu7tXtJS4
 dSRv43tJoNS8iwPVyAIlXU1n7/eF/CljvAg7vD1s+nD8Y5eXuFQ1uCkQI1FRbd7LGDDc
 GjHSXGYDofZT5Xsv56dfcMhd08oCYLJsQQzs9rd9mZ45ogkCY0SKSgg3Jk+RSxaotdDm
 aK62LUoKzFpsf8zhyiuAsCpoa+zHei5XGzMV1fu2PAwfGiN4aEETt7lZbA/SN9BI43ll
 H13Rha9Cx3NFyFCM3NYZ3Jh3zcSChjBGYHhsjC32zTwjl6dDdYyoCELJ6+UW6KLVXBAW
 pH/g==
X-Gm-Message-State: AOJu0Yw39iVgkvnaZ5fwLHEVxl598gkOOaGedA6SOj/8MKIsMrSDF8rh
 JF5PI/Xt9iKiet8tq7KBUF3udNWo2jEjQ0Y3E1umng==
X-Google-Smtp-Source: AGHT+IHwNBLHu0S7tJ+bOWJjHiVWHAi0qdJoPZ624c0QSem4Zllju4h7eTMD6jFkppI51InBkiZkfQ==
X-Received: by 2002:a05:6512:3d18:b0:500:92f1:c341 with SMTP id
 d24-20020a0565123d1800b0050092f1c341mr16750324lfv.54.1700181365116; 
 Thu, 16 Nov 2023 16:36:05 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com.
 [209.85.167.45]) by smtp.gmail.com with ESMTPSA id
 x18-20020a056512131200b00507cf5fa20esm61010lfu.97.2023.11.16.16.36.04
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 16:36:04 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5099184f8a3so2130052e87.2
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 16:36:04 -0800 (PST)
X-Received: by 2002:ac2:511e:0:b0:508:1470:6168 with SMTP id
 q30-20020ac2511e000000b0050814706168mr12559994lfb.57.1700181363922; Thu, 16
 Nov 2023 16:36:03 -0800 (PST)
MIME-Version: 1.0
References: <20231115183522.1.I4cbfd34d576c0ad66a74c6ec3e8024adabc73573@changeid>
In-Reply-To: <20231115183522.1.I4cbfd34d576c0ad66a74c6ec3e8024adabc73573@changeid>
From: Shantur Rathore <i@shantur.com>
Date: Fri, 17 Nov 2023 00:35:52 +0000
X-Gmail-Original-Message-ID: <CAHc5_t2rC_ir-UqLt+tLJpyZqy3XUS5qttnu3zXgO19J0Jj7Xw@mail.gmail.com>
Message-ID: <CAHc5_t2rC_ir-UqLt+tLJpyZqy3XUS5qttnu3zXgO19J0Jj7Xw@mail.gmail.com>
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
Tested by: Shantur Rathore <i@shantur.com>
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

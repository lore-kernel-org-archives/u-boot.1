Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B069D5A6DF
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 06:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4172489BFC;
	Tue, 26 Nov 2024 07:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QAEsqNFh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E454589C0C; Tue, 26 Nov 2024 07:30:13 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A077D88F20
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:30:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3ea49cc8b88so846172b6e.2
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 22:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732602610; x=1733207410; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zx2iLAsA5xvdKCxXlZDoYprb/gcHfnFSnY2qFaC948Q=;
 b=QAEsqNFhfNq7LYKpbARzxmBMLea8hw8jY8+2BpGqr/YHp1WstgXjQg1SdaXA1z12lD
 CeJ1O2xF5YrZBax7mDSyutUFf46ZH1trZwQtsG7xT4/Fsan7lxz5On8cnqOcZDJgEFyI
 A1eTr+YET22zYoXc9RMMMdzgZ5/x3JcVuROVagMA7QBnU2iL5ZLY3Mi6at9WFaNfoMRr
 MNrfG6AnIZZR3lfs2Wqdleq7KrUkxsMjSvm7kjlcSd/+RcuQ1VprkvZ4bXVnew3k+AcZ
 Xn7QWNIKwBqLPsryZWvLKLBPX+aMLjyb9Lkat1P7n4KkutVN90XYMbUfKI1xZS19qUjr
 Gt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732602610; x=1733207410;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zx2iLAsA5xvdKCxXlZDoYprb/gcHfnFSnY2qFaC948Q=;
 b=kx7FO8mnvTQiwOMI2R4XfAfMruugMuoIO7Cw/Bv71pQQstT6Lce9HPGM1GdFSscDa3
 YP9K55bZrFd1wDWuWWDsfcVlczrfnlnTIV4RA6ijFNC6sHZk3ughYyxI3qbWgkokJJup
 quxAAOFyl1/icsO0H0fL+LdVc/ga69KBqxePZrj1rvgAyy3cZBFbFTKLTtbEeYr6ha9E
 1ll85VfzhjBn8KnMXLAV6ELEzNxSmTSTRUw5DyhJwOWnTuYk0Np8Nc3bXn0jPTdGgMyt
 4yuIwZl8RygjUScKIhw/N7MEpyUZ18FtsUYtcMr7OWpjM/SIa3UjxR5l9E52HvbyioKY
 GN6w==
X-Gm-Message-State: AOJu0YxE2r1ALeH00WdBXL6VjxHZIMeQTB3mmeEp6/mB9U3h3gHgz2Ic
 8WYru2jfgw+NNcD31tiiYGTewB6z+7hwpAIhn/aOB8G19n2dU8lv1lk0GU+4eg+zW5uoMNdh5EA
 Tk5DZ1KgZkGb2DROGjEnWXH7GjaeZBaU0lT0oNw==
X-Gm-Gg: ASbGnctxNGgZj3OdNYOPfZieV+sueVdMWY5AEEPbIdHUgnP3TbPn4XWSuuzW9pOOgsw
 SG79dG4agcm2Po/vQDHlulXHnC1vftQ==
X-Google-Smtp-Source: AGHT+IHmveivEZMWbu2VZbjgktHr9Sk62rGCgSHI+hQROzHCDGUe8/E5EeSUZIksXJudJYDHp0um0uQ7ZrZnMb/4Kds=
X-Received: by 2002:a05:6808:1a0f:b0:3ea:5222:f019 with SMTP id
 5614622812f47-3ea5222fe89mr4503800b6e.42.1732602605251; Mon, 25 Nov 2024
 22:30:05 -0800 (PST)
MIME-Version: 1.0
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-5-sjg@chromium.org>
In-Reply-To: <20241125204456.1525752-5-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 26 Nov 2024 08:29:29 +0200
Message-ID: <CAC_iWjLgPqvmvMjHQsY+dPrQ4cmz11KKSKEs87OHW7KEpBWR5g@mail.gmail.com>
Subject: Re: [PATCH 04/13] efi_loader: Update startimage_exit self-test to
 check error
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 25 Nov 2024 at 22:45, Simon Glass <sjg@chromium.org> wrote:
>
> Check for an error returned from the decompress() function, just in
> case.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  lib/efi_selftest/efi_selftest_startimage_exit.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_selftest/efi_selftest_startimage_exit.c b/lib/efi_selftest/efi_selftest_startimage_exit.c
> index b65a10b7a4b..8d119f054c5 100644
> --- a/lib/efi_selftest/efi_selftest_startimage_exit.c
> +++ b/lib/efi_selftest/efi_selftest_startimage_exit.c
> @@ -84,13 +84,15 @@ static efi_status_t decompress(u8 **image)
>  static int setup(const efi_handle_t handle,
>                  const struct efi_system_table *systable)
>  {
> +       efi_status_t ret;
> +
>         image_handle = handle;
>         boottime = systable->boottime;
>
>         /* Load the application image into memory */
> -       decompress(&image);
> +       ret = decompress(&image);
>
> -       return EFI_ST_SUCCESS;
> +       return ret;
>  }
>
>  /*
> --
> 2.43.0
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

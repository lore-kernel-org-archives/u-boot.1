Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACB5C369DC
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 06:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35AE881F66;
	Wed,  7 May 2025 08:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dkdtIXyT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8CC3820EB; Wed,  7 May 2025 08:46:32 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BE098007D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 08:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e733b858574so6117948276.2
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 23:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746600389; x=1747205189; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=urZN+fieSteTZLV5mTtQOupXrFjsf66WgkQgRXuCTJg=;
 b=dkdtIXyTKUDvj4HV10S1AoDnBkxNSz6a7VpLGPcpf/JOa4hN1DzFlHmTq6hp2APbOY
 OJipt3WjeQ0fMWTKX3WI4fl7rKaP8toNzQanhsGmebJQVi4EpeaoNyE8gG2Igd0nkyEs
 1xb531ngTZen1TxeWTVJq9es6vv53RD60Xav+1P22mH2WMX6VH8/wMbfJMnM2CIr5odH
 n48pHl16Ux/xQOmyytIkC7dEch5Ud3VkEwTZk/lF2lWCfocfk8Y4cf7xq+DFE6t1H5Zp
 jz3RJlw3MPFDX0o8r8f9Ks7+SqkEeDia1SU9n8ZJ/htXZQ96qI1zabNqkWpROTb9qR2n
 msIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746600389; x=1747205189;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=urZN+fieSteTZLV5mTtQOupXrFjsf66WgkQgRXuCTJg=;
 b=t8JPg4KBNjzDLcpRTEn8LwT441FTQc+ISnzcnp+RP+m0x0yZndGUqpQOorOl9HHWbq
 nmtptaBqnZqhBpKvYCk+QARct+iJQHiigViJ0m2PPGCLPiLCTXmUFiyYODpeYPgQTbF6
 hMYqEWXQeKyHRFYrADpRHE03iw+3grBEGeP+uqZQCjP+dF4ufqmHfiHFMw9JFLKez4hS
 pFHfwduuKk6WGPugEB9soXkG8dTyypNm0b+vTNS/sgzOP/LK4WNubgqI2ZnJ4pum724H
 lsN8WzUF0AVBvxkysjbPMdgHFI0btP0Eox5fbVMJOIJXPgmItlldxPDkVLZdjdsvypgn
 rlGQ==
X-Gm-Message-State: AOJu0YzPvpIoOMQCOk84QRCybeI8EjFgPSrVUOHC6smUMMCZm9+T+PCQ
 N/XLXMuFhlofc9ikQtW5ca8v4Mu2YKE1mTWuMrcRcPYIooYtVBFDwassUtQW/YA2Cn7U3V8mYFF
 cKHf5why/ROq871NaItTJcJLcKtfoKIQywRHcsnZ5rjXkvNYJYpc=
X-Gm-Gg: ASbGncsDUF/NCZfnFLzcMAjITp+henGyWzi3jlvndt6jSgJzoN1OpgJc/Jh65h6JFm6
 g8qGeLJsDgWETc/EKzKrcnQHvhiknGa0IytZsPfihs3jVD3rYOZyCo11KGwRrDvyDsxGJjSkq04
 RzwV2g/hjTsq2pQ3W4LQVmgW0=
X-Google-Smtp-Source: AGHT+IHy3RY0lecodFUnslQdWT2Yf1NZ5nVk+KFq+TFPON0Gur6olp41cNWXwLNEk2yqz3d46i6hmGHeydhRhVmW7Sk=
X-Received: by 2002:a05:6902:2508:b0:e5e:1389:cb2f with SMTP id
 3f1490d57ef6-e788173f801mr2523434276.45.1746600388967; Tue, 06 May 2025
 23:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250506123622.3216742-1-vincent.stehle@arm.com>
In-Reply-To: <20250506123622.3216742-1-vincent.stehle@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 7 May 2025 09:45:53 +0300
X-Gm-Features: ATxdqUEg4gRQXH8KTlCClHw3tEXkcs3-02Vk4H3CGqtHMd5ZgcbU5uk-ojrOgO0
Message-ID: <CAC_iWjLpapTEimHU-79QbzDcuJiV-0eHgeW+erHUCjM1VLmsTw@mail.gmail.com>
Subject: Re: [PATCH] cmd: nvedit: fix efi env -e -i command help
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maxim Uvarov <maxim.uvarov@linaro.org>
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

On Tue, 6 May 2025 at 15:36, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> w=
rote:
>
> The help string for the `setenv -e' command shows a comma being used as
> the separator between address and size for the -i option, which deals
> with UEFI Variables contents passed as a buffer in memory.
> This is no longer the case since commit 2b3fbcb59f41 ("efi_loader: use
> ':' as separator for setenv -i") and commit 8f0ac536d493 ("efi: change
> 'env -e -i' usage syntax"), which changed the separator from a comma to
> a colon.
> Therefore fix this last bit of the help string accordingly.
>
> While at it, fix the comment of function do_env_set_efi(), which also
> mentions a comma as separator.
>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  cmd/nvedit.c     | 2 +-
>  cmd/nvedit_efi.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/nvedit.c b/cmd/nvedit.c
> index 1f259801293..11c3cea882b 100644
> --- a/cmd/nvedit.c
> +++ b/cmd/nvedit.c
> @@ -1263,7 +1263,7 @@ U_BOOT_CMD_COMPLETE(
>         "      \"-rt\": set runtime attribute\n"
>         "      \"-at\": set time-based authentication attribute\n"
>         "      \"-a\": append-write\n"
> -       "      \"-i addr,size\": use <addr,size> as variable's value\n"
> +       "      \"-i addr:size\": use <addr,size> as variable's value\n"
>         "      \"-v\": verbose message\n"
>         "    - delete UEFI variable 'name' if 'value' not specified\n"
>  #endif
> diff --git a/cmd/nvedit_efi.c b/cmd/nvedit_efi.c
> index 32b7d049074..351ae47e870 100644
> --- a/cmd/nvedit_efi.c
> +++ b/cmd/nvedit_efi.c
> @@ -367,7 +367,7 @@ out:
>   *
>   * This function is for "env set -e" or "setenv -e" command:
>   *   =3D> env set -e [-guid guid][-nv][-bs][-rt][-at][-a][-v]
> - *                [-i address,size] var, or
> + *                [-i address:size] var, or
>   *                 var [value ...]
>   * Encode values specified and set given UEFI variable.
>   * If no value is specified, delete the variable.
> --
> 2.47.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA097E77184
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 08:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F30A380423;
	Sat, 21 Dec 2024 09:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hhb/so/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 439F3803E0; Sat, 21 Dec 2024 09:15:26 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05A1180423
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 09:15:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso2381509276.3
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 00:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734768923; x=1735373723; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j5sJRA2LIK5jOaQLpcw6iVs1Q0vrvURLXFmpwj2fc8s=;
 b=hhb/so/E9a3ICcJWxDNqjgS7H+7t95rgG3DzuKtve5V6mpemgQji4fUmx+9WAHHKel
 cm8btIrw+HHA+WSpoGQot34L6wlGwASRVNSelwYP5PCZ3iAV3tGD6iUYs8FYoIqtN+na
 4y3X9zA3fEmO0XsRe0Xo2kMnaMeUJX/AqhAqDhmZT6sPElIOOw3xjr5p0bHm4EDoimiV
 2Z4E8ERt18eE5sc3YDssPzjGvytcqzeKt/r8v9odod0Iykh0OTmR8S0wNTTX2izV/HMv
 YO+7iItSM3uZKj7aFhQICyphw7t/FFxZ5VPNFoiNGuGPTfGXOXfDjOLPUnTiTijd5/a7
 yhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734768923; x=1735373723;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j5sJRA2LIK5jOaQLpcw6iVs1Q0vrvURLXFmpwj2fc8s=;
 b=B1prK/dfROOqy1V5CF576SGsn4ltqlUMqLxsUovQ1mGhI6hzjUamgVqWcadnlNx9X7
 njkjV7AGgsB5ZgE0AFz4Z+XqK8F/YqRyof9hRFdJYeNXM/IPTNGK/GrndtXythsgFfki
 A/GDcCmsIyYbcg7mt4Rp8863m6zg3w1oGs5EGHw0xMf09R8XKUrx6Hln8g+1ZQRnEtyW
 eWTnlrgyeSBVGtodk3zx6BvV10TYx6ByTKQWDFeWfU6F7iP+qBXsPnLD6clr9fYRHbeh
 ZlRu+ijAkKiUgliW+FcyZ+mjrVAHIylvLwJSHBztRhtZLiHFfCHq6Yji8Rmz/mISbzCi
 egqw==
X-Gm-Message-State: AOJu0Yw43oLMSqwBC0mzGb8myEm95w6+FQgQ3IaCmEwJeNm+f7yGTexF
 NJjc+OGb9bfdSywcMvqCaOYV5RYml5zlHWi6l78rDKOWSAAkqmTFFEBbYJ/2a/84Mv67LaEay+P
 gENI3N7Yu3j0Xf9QvVOm0Z9Gn3A0RseLhRbN9Jg==
X-Gm-Gg: ASbGncvSc5vt7B5/EpEQ/jE55RKeFMCXsPbFwU0Lp68MxzwcEfSxab8jXkH6hJHUFkg
 w4LweRCv1qt8Pj9e/q54KEYG6+ZGAYtaM1JlE5A==
X-Google-Smtp-Source: AGHT+IFEpU/vQpsdjFuwcf9K1y32R6nQAbVXGDrnEyo6gqTLsbsjDkWCk2wM1rNsmxJzS3vSxubXqVbdB9xAZWwu10Q=
X-Received: by 2002:a05:6902:2386:b0:e4c:bd70:854c with SMTP id
 3f1490d57ef6-e538c403f2fmr5004764276.43.1734768922788; Sat, 21 Dec 2024
 00:15:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1734537135.git.jerome.forissier@linaro.org>
 <217af7ee46d45348bb825caafa20bd91f18ff957.1734537135.git.jerome.forissier@linaro.org>
In-Reply-To: <217af7ee46d45348bb825caafa20bd91f18ff957.1734537135.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 21 Dec 2024 10:14:46 +0200
Message-ID: <CAC_iWjL+-R1YK5GOYDmBTZVa_+WqzzDhJG+qPubi2LYGLAsx6g@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] board_init_f_r(): use static calls
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Jonas Karlman <jonas@kwiboo.se>
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

On Wed, 18 Dec 2024 at 17:54, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Replace the init_sequence_f_r function array by direct calls.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  common/board_f.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/common/board_f.c b/common/board_f.c
> index cebed85ed4d..f47275a2230 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -1016,8 +1016,8 @@ void board_init_f(ulong boot_flags)
>  /*
>   * For now this code is only used on x86.
>   *
> - * init_sequence_f_r is the list of init functions which are run when
> - * U-Boot is executing from Flash with a semi-limited 'C' environment.
> + * Run init functions which are run when U-Boot is executing from Flash with a
> + * semi-limited 'C' environment.
>   * The following limitations must be considered when implementing an
>   * '_f_r' function:
>   *  - 'static' variables are read-only
> @@ -1030,18 +1030,14 @@ void board_init_f(ulong boot_flags)
>   * NOTE: At present only x86 uses this route, but it is intended that
>   * all archs will move to this when generic relocation is implemented.
>   */
> -static const init_fnc_t init_sequence_f_r[] = {
> -#if !CONFIG_IS_ENABLED(X86_64)
> -       init_cache_f_r,
> -#endif
> -
> -       NULL,
> -};
> +static void initcall_run_f_r(void)
> +{
> +       CONFIG_IS_ENABLED(X86_64, (INITCALL(init_cache_f_r);))
> +}
>
>  void board_init_f_r(void)
>  {
> -       if (initcall_run_list(init_sequence_f_r))
> -               hang();
> +       initcall_run_f_r();
>
>         /*
>          * The pre-relocation drivers may be using memory that has now gone
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

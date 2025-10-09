Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E4DCCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 18:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3FF083CF7;
	Thu,  9 Oct 2025 20:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kaMDr3/P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADB8B83D01; Thu,  9 Oct 2025 20:34:39 +0200 (CEST)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A785B83CF5
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 20:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6353f2937f3so1679348d50.3
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760034875; x=1760639675; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9EmbxKJ3TAp9ncgziLHSiV25Fe4nqftdBp/zxfVPpQ=;
 b=kaMDr3/P2+UC8OcoUEFAXCGtym/OJEE9cVhesCjGj+Zc9G1q/KfqV6k1E/nggC/y90
 ahsqqAwZt0kP1YzVRpM/Ozm2RxeFBAya3nTmEKilpRldBc80AkGmQSB22zTYw3yP/YAw
 b9RT1jt9VzWUwVcaeG+uvgYfUPLw+CYu0sL2DVYk4+/nt2OQMZFE6Oun3yJOvLp/vbt9
 dypB5ntWS3XvPCE3M4y+9leqdV1clBB0tVkRrIXRqgBvSAr2AyY6SRNRIdZr9OPknNVy
 PwggqsdqQ6PpKKcG8ztJYnAQxcYU2CBfCqUCmUOtP2Q3Kyf4072IgcLu+9ZTiXpeEHJQ
 Iohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760034875; x=1760639675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f9EmbxKJ3TAp9ncgziLHSiV25Fe4nqftdBp/zxfVPpQ=;
 b=skcK5tdula4bjtbXXNkA1BW5Zeey1IgdgTMJ9SIXuVqR2DdX7ZJAuz4G21ghVR+Pxm
 +fTCQFyzeIVfPp0AIe96W8h62rOC9rNzzJxZvE197cCqTNPsSd3D56emsdJb4aSM9Ocs
 cSWdGSPk/1yHZuUCXiXNKVx4aPVLTT/GXT2Gmj+r/07kzua4vyFZCaZfoLXbt69KoflN
 OZ6s5cViVSRHpsmUHfIvN+fkRVwAwPR2iwDf2AOwkSDvqfU7LNvpNiayI8Pi0ZeeJh2y
 4c6jU3+ab6e9x6bZ0Y8HJ90jYi4eGwl+dsufflyHbsp8ucx9EjGy1/Kwpe8xk9oDOOEC
 8I+Q==
X-Gm-Message-State: AOJu0Yz1AgKUwI5tseTak99Mk3rnylMXK48tGI7jhoYjg+tJbznfWCrV
 GHcHaPP5vyoJUAaB9LSjq1jMep63jOGZlrKUsCs3y+GedN0u7uZfOKxQvSuCj/h/+Oo0zWaEKzo
 h5MRxMYLLcQqpNpQXvgryt8WvwkIqPLii0SCKZ10Q2A==
X-Gm-Gg: ASbGncsY6Aa6XSaJSB1EMKE0mR4ca+SHnMVbYf75eBhqjbsBOU+YCPfUq++oTohCNoh
 GJbOMgR8JTIdjK9sp88ZYgzks9s6N2+/nRpCuGLxnsPu2Ayt+1mxf+xnCm6Sov8+Jjn6ipuTGP8
 C6rY2eXZRd/OXGaFT2qKtpZ98T9t/17T1L85nynHxOQdTkJkYObkFfTi93cBm9sNau7IlXHdzIM
 8hF8iix7IvuRcopckajj2uZgtk90pdyXDFwqSlAY8kSt2l4jJDGtZQWbnHviFvCnloQBQ==
X-Google-Smtp-Source: AGHT+IHuzmBjh9e8VYUkTlvIHBhus5fVj/b5BTYT2RGuAVuhEURYHGPi0HKT9+S2GDZexrMEOQ41imjP89Duw7682i8=
X-Received: by 2002:a05:690e:164b:b0:636:13ab:b5b6 with SMTP id
 956f58d0204a3-63ccb85e78cmr7301325d50.13.1760034875391; Thu, 09 Oct 2025
 11:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20251009092959.260121-1-sjg@chromium.org>
 <20251009092959.260121-2-sjg@chromium.org>
In-Reply-To: <20251009092959.260121-2-sjg@chromium.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 9 Oct 2025 13:34:24 -0500
X-Gm-Features: AS18NWB8HAJWmShOmAEX6kE2-4p0I8w7RrN_FLLSdZYJGxhKTyjaPPn9YeWdrU8
Message-ID: <CAPLW+4mAKfrAj8pxWFZ2DDS=ux9ZQa7Cyi1mP+oMGCRMUuDfyw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] boot: Improve comments related to global bootmeths
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>, 
 Moritz Fischer <moritzf@google.com>
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

On Thu, Oct 9, 2025 at 4:30=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> Add a few comments about global bootmeths and first_glob_method
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>
> (no changes since v3)
>
> Changes in v3:
> - Drop the spacing changes
>
>  boot/bootflow.c        | 1 +
>  boot/bootmeth-uclass.c | 1 +
>  include/bootflow.h     | 3 ++-
>  test/boot/bootflow.c   | 2 +-
>  4 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/boot/bootflow.c b/boot/bootflow.c
> index d79f303486d..15df7069209 100644
> --- a/boot/bootflow.c
> +++ b/boot/bootflow.c
> @@ -344,6 +344,7 @@ static int bootflow_check(struct bootflow_iter *iter,=
 struct bootflow *bflow)
>         struct udevice *dev;
>         int ret;
>
> +       /* handle global bootmeths if needed */
>         if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && iter->doing_global) {
>                 bootflow_iter_set_dev(iter, NULL, 0);
>                 ret =3D bootmeth_get_bootflow(iter->method, bflow);
> diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
> index 188f6ea1895..bb2dd8447cf 100644
> --- a/boot/bootmeth-uclass.c
> +++ b/boot/bootmeth-uclass.c
> @@ -204,6 +204,7 @@ int bootmeth_setup_iter_order(struct bootflow_iter *i=
ter, bool include_global)
>                 goto err_order;
>         }
>
> +       /* start with the global bootmeths */
>         if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && include_global &&
>             iter->first_glob_method !=3D -1 && iter->first_glob_method !=
=3D count) {
>                 iter->cur_method =3D iter->first_glob_method;
> diff --git a/include/bootflow.h b/include/bootflow.h
> index 32422067723..2ef6eb25cf5 100644
> --- a/include/bootflow.h
> +++ b/include/bootflow.h
> @@ -250,7 +250,8 @@ enum bootflow_meth_flags_t {
>   * @cur_label: Current label being processed
>   * @num_methods: Number of bootmeth devices in @method_order
>   * @cur_method: Current method number, an index into @method_order
> - * @first_glob_method: First global method, if any, else -1
> + * @first_glob_method: Index of first global method within @method_order=
[], if
> + * any, else -1
>   * @cur_prio: Current priority being scanned
>   * @method_order: List of bootmeth devices to use, in order. The normal =
methods
>   *     appear first, then the global ones, if any
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index 8de5a310add..7cd83dc7443 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -401,7 +401,7 @@ static int bootflow_system(struct unit_test_state *ut=
s)
>         ut_assertok(device_probe(dev));
>         sandbox_set_fake_efi_mgr_dev(dev, true);
>
> -       /* We should get a single 'bootmgr' method right at the end */
> +       /* We should get a single 'bootmgr' method at the start */
>         bootstd_clear_glob();
>         ut_assertok(run_command("bootflow scan -lH", 0));
>         ut_assert_skip_to_line(
> --
> 2.43.0
>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8544CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E7584B95;
	Thu,  7 May 2026 18:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NNaAWZMc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE98B84B9E; Thu,  7 May 2026 18:49:53 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B547A84B02
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bc2301be8ecso196722966b.3
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 09:49:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778172591; cv=none;
 d=google.com; s=arc-20240605;
 b=N1vGQaavn4r8nnPmmIewHc0XcvIvjtCBuwojJGhgFJrrZxIMUnOWaw/7TFALMRZ6vB
 g6lgvfC7mIx663TFGNhrd6YjMM5ZC/1RB7kh2NGV5rm0W2RcZobnaNOW+65Yc7GUe3f8
 d3iX9qMJFqrcZdTIG/HYwXYJ0CqP4aYL8kdAQFMQnJRFiWMemxgfgMg9XSqdblSCzplq
 hA5R+upYc2J++9y62RP8nhcwsJwZmkYinoR12MVHTCfyz6ojdgkEENLiJgJTMv5lt+Vc
 dgy7ztevb7ktKVLPx7esIhFV9TZGbjulPkJz1s6K+ls4TAJPzfjUZgQ3e7rvuD1vZ0/H
 OiyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YzlE0zegef2YjEtK3mGsEjc5rEf4jwFq4ft9WUM4Z6A=;
 fh=uBghxOPWvItNDGnTET7CByJtKX0H+SusgDDX5tqV63M=;
 b=JtRl4PLBIH/eY3ATy2SIpVWHdmKWztpJ5xqQe4dmD7pd25fCIbKzUC3peTuhsZPgvJ
 n2GRb/XzOGn34BroefReOBsE/LQbTfUN367OpWNtOj5kPeEZ80AHtP7/bPq4ow75DCyd
 IfMi1AREw27fOv5n8yqUSybfDVF9Pi96DzBpQzphc1mjf1CbgeR3awi3JH0sKNaVUky1
 Lad6n8qVANbMlseGdy4XtL3SLcq0JGSKQDLsHWkNT/HkwPwhqmnsNOMXxbuFTK0f/AgO
 AOmjy/XbOvH2AprBN5YFic96An4rJkvaO15trFxJSYgnv4zwKK/cdbcwuyuRRY8gCsGd
 I2iw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778172591; x=1778777391; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YzlE0zegef2YjEtK3mGsEjc5rEf4jwFq4ft9WUM4Z6A=;
 b=NNaAWZMcacryyGGNtqimfFVYM31k1GrLKqwoVrHHO0MNea3+JEP9XnPPHE+xjzydxa
 DPM89tNowLjft5l0E0qi3z9D/t7hmDVdNUCCQkzGfK7tquE6HO0V+A/IOP3FS4qQ7hGC
 Gt//Cgs5Sw00K9iqVDLUmEmXaxEVa7apWn+GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778172591; x=1778777391;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YzlE0zegef2YjEtK3mGsEjc5rEf4jwFq4ft9WUM4Z6A=;
 b=WxtO2npqrd5n5pXXqISHnIlp0CYP/z/Fw37LtM5zSmKOzapB/wvVzYY2XcJNS8VaJl
 t6BsPU/aLPhWYh3vQCASnQCwpOxV0IsXXGpcsFKcdAcIhpwsYz7vZvd9adXS/Kzyc6og
 4memApyiyPlfi1KJAwd9etIYQfHac9GlDrLC3SCHQG51xV+4QnKd3zJFPcPXwQ8sVHY6
 Y+6DwmLRLEnqcPOQYQJV0OzFJUmfrCVIZnnHoSdp2e+SIeW7Qx/9oc+pqI2vSMjMBNBH
 MyblWyYcle+D8EFCSdPuYIV/Q/kLGW6f5I2eayXNjS28jo+M+zPStQ9k3SXQRzU81q8c
 L24w==
X-Gm-Message-State: AOJu0Ywpirr0UT7AbighD9giAUPeH88x3qHy9af5hcW2YxBzlJLTkJrY
 E13i6xfMJgBoxgmF+gytE3vOufO3pmBCahKFfvDeggM6H036TrZNMN8gLjVJpfFWSGwc61JFb7m
 gWHWvkYTBab/4dhNX5kIrDMpxa8i/Z6nWZ1pRZZ/q
X-Gm-Gg: AeBDiesxMdvk8Es++boo+ZKconvY0DR1hSr7vy/hnDUijiarQiza9njW185/bisUpEo
 wt45aUNtwgq0RDWKrS6OpONRPiT7tl7NkdJZKDvorM6Qo06PpsWhJh75SJnUPxxnFNrU+/zIFzf
 FeJIzbraQO27rDLB2RTtxkBHR3e/8mdQZyIQsXOf3oYdxJcfIu0NJrAjZbk9Yn6+DNsIq/kgDFI
 G6N//r1WYHUNuQI61d/5+u9ZQudSjs1zghE39NzEEwKhpVAF8JhcazoQj0jeCXLe7sRP9pWxQeU
 M8fkLQ==
X-Received: by 2002:a17:906:5181:10b0:bc6:6045:e0ed with SMTP id
 a640c23a62f3a-bc66045e7damr289791366b.33.1778172591051; Thu, 07 May 2026
 09:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260507120735.310325-1-ludwig.nussel@siemens.com>
 <20260507140624.v3.4.eb9898db9115ab0e26701a962ff8b41b199e78b2@changeid>
In-Reply-To: <20260507140624.v3.4.eb9898db9115ab0e26701a962ff8b41b199e78b2@changeid>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 10:49:38 -0600
X-Gm-Features: AVHnY4Iex2l2U_XLxrtxYKpP6HW77xESd71_DI6LNptQKyqpvSTH9RIm60XQznM
Message-ID: <CAFLszTgkgGh_o=_ACPkTPpeNw6O3qvM=ZDywranrZpgPn_c_wA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] iminfo: also verify signatures
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Yao Zi <me@ziyao.cc>
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

Hi Ludwig,

On 2026-05-07T12:06:22, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> iminfo: also verify signatures
>
> The iminfo command already verifies hashes of images. This change also
> verifies signatures of configurations if enabled.
>
> Adjusts error output slighly to be on stderr
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> boot/image-fit.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
>  cmd/bootm.c      |  7 +++++++
>  include/image.h  |  8 ++++++++
>  3 files changed, 69 insertions(+)

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -1512,6 +1512,60 @@ int fit_all_image_verify(const void *fit)
> +/**
> + * fit_all_configurations_verify - verify signatures of all configuratio=
ns
> + * @fit: pointer to the FIT format image header
> + *
> + * fit_all_configurations_verify() iterates over all configurations
> + * in the FIT and checks the signatures. Returns success if all
> + * configurations have valid signatures. See documentation at
> + * fit_config_verify_required_keys() or fit_config_verify_key().
> + *
> + * returns:
> + *     0, success
> + *     -ENOENT, no configurations present
> + *     <0, error

Please use kernel-doc style - 'Return:' rather than 'returns:' - also
'fit_all_configurations_verify' at the top should be
fit_all_configurations_verify()

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -1512,6 +1512,60 @@ int fit_all_image_verify(const void *fit)
> +#if FIT_IMAGE_ENABLE_VERIFY
> +int fit_all_configurations_verify(const void *fit)

The header in include/image.h declares this prototype under
CONFIG_IS_ENABLED(FIT_SIGNATURE) but here you guard the definition
with FIT_IMAGE_ENABLE_VERIFY. Please use one consistently -
CONFIG_IS_ENABLED(FIT_SIGNATURE) reads more naturally and matches the
neighbouring fit_config_verify()

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -1512,6 +1512,60 @@ int fit_all_image_verify(const void *fit)
> +             log_info("   %s ... ", fit_get_name(fit, noffset, NULL));
> +             /* fit_config_verify() prints results so we can be silent *=
/
> +             ret =3D fit_config_verify(fit, noffset);
> +             if (ret) {
> +                     r =3D ret;
> +                     log_err('FAIL\n');
> +                     continue;
> +             }
> +             /* valid config found */
> +             if (r =3D=3D -ENOENT)
> +                     r =3D 0;
> +
> +             log_info('OK\n');

The comment 'so we can be silent' contradicts the next lines, which
print FAIL/OK. Either drop it or rework - fit_config_verify() does
emit its own diagnostics on failure, which will interleave with the
FAIL line printed here.

> diff --git a/cmd/bootm.c b/cmd/bootm.c
> @@ -335,6 +335,13 @@ static int image_info(ulong addr)
> +             if (CONFIG_IS_ENABLED(FIT_SIGNATURE) &&
> +                 fit_all_configurations_verify(hdr) !=3D 0) {
> +                     puts("Signature verification failed!\n");
> +                     unmap_sysmem(hdr);
> +                     return CONFIG_IS_ENABLED(FIT_SIGNATURE_REQUIRED) =
=3D=3D 1;
> +             }

A FIT with no /configurations node (an images-only FIT, which is
valid) makes fit_all_configurations_verify() return -ENOENT and log
'Can't find configurations parent node' from inside the helper. That
ends up here as 'Signature verification failed!' which is misleading.
Please treat -ENOENT as 'nothing to do' in this caller, and don't
log_err inside the helper for that case.

Also, 'CONFIG_IS_ENABLED(FIT_SIGNATURE_REQUIRED) =3D=3D 1' is odd - the
macro already evaluates to 0 or 1, so just return it directly. Better
yet, make the success/failure path explicit rather than encoding
policy in the return value.

> Adjusts error output slighly to be on stderr

Typo: slighly -> slightly. Worth also mentioning that, for a
verification failure, the iminfo exit status is gated on
FIT_SIGNATURE_REQUIRED =E2=80=94 that is a non-obvious behaviour change.

Regards,
Simon

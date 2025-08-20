Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B665CA0EE4
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 12:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71B768211F;
	Wed, 20 Aug 2025 14:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W0uWqiQW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF40982B07; Wed, 20 Aug 2025 14:38:37 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9B79801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 14:38:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e93498d435cso3358784276.1
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 05:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755693514; x=1756298314; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HsZ7Ap4CZ+RKZxcUUEKd2KNVLjY3F2xNkLXq30DTXz8=;
 b=W0uWqiQWqgNxPzVCvRY+kdS/UQwLhy/GQohtfVgduRzAFxq7ub5uhjYEeY38xY0iZC
 s7r+8lWX+bIEvjiRZ48v1MlDJCyna++kXhZq8AiQraRiiNi8uJstjIxOyTbGX+gkVjK+
 9vgCdiNTkwWBtrLeYXS1lrAmAf9gN5OvWgZRkPuo4Aajc3sAZrpfwu2Kd43T/C0nf85q
 8UnNPsKHu9RxGQalD+c5ke80pwt5fhhYtUENDOiVfhPUHWXmeW7kG3WNO8IVwWdtOrxP
 x6NRS9qYruO4XqXKPJIxcyCvm7NLaMjUKmGSJQ8GyzwDuhsN1SyiyFlzoCicKNdveq70
 bUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755693514; x=1756298314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HsZ7Ap4CZ+RKZxcUUEKd2KNVLjY3F2xNkLXq30DTXz8=;
 b=OEHXNtVycZfJeDX7i8fRlAlLE5guAvnMDAmDnVFveibYs6lw3tDxZkj4m6tV/smTWs
 m8UUS5prv04RSjROg0J0NMJ6Xvtfc2GzuATNPb0rxjiXnT9NcEcqbvF+rLXWk85jMVcs
 hMPeYZsb6eTcUMSrMeqG1Zmj5vQa9W4AyXVd8DEotfjdwINf1aImurdj2EmZGzH0FCms
 FJLn2QG2jlVTNZGPI+CGhKASjgaWOh6+MD5cO1EYpz9asJFvTbsA+neqHimBRQXpBASl
 4WkkQireAVRx3Q/sZ9CGfjcYfdCmH+GuBSrzm0vRqTBtrrmeicfPtyVZfRjBjfYPPJQ/
 L/XQ==
X-Gm-Message-State: AOJu0YwX0Qe9TkXGPbn4/8O/8cz4pui+568QEsv7sgc3wmCivm/1hEIv
 C/Fxe9+LpCBPNqg9dsqDUoV8GIiC1rlCCsYH8LRaU3faSeMEQIzZbQ8/OMLYDbcHaMuSEoMLK+r
 7PoGwDevAzK/5rlgZgu4Pt3mf8NmWOQm6gKtHMAb38A==
X-Gm-Gg: ASbGncusn1fMs0Y7Zt+mK8wlq1bRqxNWKrulu/X5sm+Dt1ZCtAdj9rLf7hH5hMnh4lZ
 iq0UKE58YzFAY/vvwvFxZmNKLaFStYqT1UE8s/w4XmnCKGm+QjYlWw7v+EWk1qBdv/eaaUpXGFe
 aLKT5JK8bv/RImJnTHE7qL76prLo8HyXbWSadxxrMD4+CnfnWceneUEKs6QF5xHxXZgMRh2ARk6
 oeuHA==
X-Google-Smtp-Source: AGHT+IG6r+qKnKiA/PzWATWT6/ymWcusejUfJoxCJG2LwVzlv087BYwn9J2cCH/FG9lBVvdikc+oIZ7LrKSTZUabYts=
X-Received: by 2002:a05:6902:158f:b0:e93:4a43:577c with SMTP id
 3f1490d57ef6-e94f66495f4mr2844267276.36.1755693513582; Wed, 20 Aug 2025
 05:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250725155010.285831-1-abdellatif.elkhlifi@arm.com>
 <20250725155010.285831-15-abdellatif.elkhlifi@arm.com>
In-Reply-To: <20250725155010.285831-15-abdellatif.elkhlifi@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Aug 2025 15:37:57 +0300
X-Gm-Features: Ac12FXxEJveNxcum5-WXxXJkg6-FYvAAUZlmQzMVDaVZD-yBIQ8NC6SVHfRsoTk
Message-ID: <CAC_iWjLvr0CZeEGogR11a-fpJauaHRc1-WeYwV3dzRtGknogYg@mail.gmail.com>
Subject: Re: [PATCH v4 14/24] efi_loader: fwu: fwu_arm_psa: Skip accepting the
 payload after set_image()
To: abdellatif.elkhlifi@arm.com
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>
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

 ?

On Fri, 25 Jul 2025 at 18:50, <abdellatif.elkhlifi@arm.com> wrote:
>
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>
> Do not update the acceptance metadata bit after updating an image
>
> The update agent (secure world) is responsible of setting the acceptance

[...]

>
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index 234e3c1b3c0..1dac691d24d 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -696,17 +696,20 @@ static efi_status_t efi_capsule_update_firmware(
>                                 status = fwu_clear_accept_image(image_type_id,
>                                                                 update_index);
>                         }
> -                       ret = fwu_to_efi_error(status);
> -                       if (ret != EFI_SUCCESS) {
> -                               log_err("Unable to %s the accept bit for the image %pUs\n",
> -                                       fw_accept_os ? "clear" : "set",
> -                                       image_type_id);
> -                               goto out;
> -                       }
>
> -                       log_debug("%s the accepted bit for Image %pUs\n",
> -                                 fw_accept_os ? "Cleared" : "Set",
> -                                 image_type_id);
> +                       if (!IS_ENABLED(CONFIG_FWU_ARM_PSA)) {

The function above always returns EFI_SUCCESS if PSA is enabled

> +                               ret = fwu_to_efi_error(status);
> +                               if (ret != EFI_SUCCESS) {
> +                                       log_err("Unable to %s the accept bit for the image %pUs\n",
> +                                               fw_accept_os ? "clear" : "set",
> +                                               image_type_id);
> +                                       goto out;
> +                               }
> +
> +                               log_debug("%s the accepted bit for Image %pUs\n",
> +                                         fw_accept_os ? "Cleared" : "Set",
> +                                         image_type_id);

I don't think we need more ifdefery here. Just slightly tweak the %s
prints in case PSA is enabled.
Something like
log_debug("%s %s the accepted bit for image %pUs\n",
IS_ENABLED(CONFIG_FWU_ARM_PSA) ? "PSA will" : "", fw_accept_os ?
"Cleared" : "Set", etc etc

> +                       }
>                 }
>
>         }
> diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> index 7f085a0211f..46b6f9356a7 100644
> --- a/lib/fwu_updates/fwu.c
> +++ b/lib/fwu_updates/fwu.c
> @@ -1,6 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2022, Linaro Limited
> + *
> + * Copyright 2025 Arm Limited and/or its affiliates <open-source-office@arm.com>
> + *
> + * Author:
> + *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>   */

I've pinged Tom about the copyright updates, I don't think this is
such a big change that justifies it

>
>  #include <dm.h>
> @@ -586,6 +591,14 @@ out:
>   */
>  int fwu_accept_image(efi_guid_t *img_type_id, u32 bank)
>  {
> +       /*
> +        * In case of Arm PSA accepting images is either
[...]

Thanks
/Ilias

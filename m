Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D15CD13DA
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 05:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8384F8469F;
	Tue,  5 May 2026 07:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="smY00Kv+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A724846BE; Tue,  5 May 2026 07:44:53 +0200 (CEST)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C80098469F
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 07:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-65c6a2158d3so308828d50.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 22:44:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777959889; cv=none;
 d=google.com; s=arc-20240605;
 b=b6UluMSUF1k9P6/3PhNXzUeEu2ovnpE5qYLwyc8OANO3vdoeSCd294AeJzN/8ZHLJr
 FdHrd/EiGiX8/u19Gltp8frhRhp25Tpmjwu+VtEnHDxbXxsW7twNtfiJy6KXg/V/Uz2R
 bow2piPV3ROqkpVxa2+BCpEBkxitT3ZcHsE1DX3q701Sa37RMphadPn7pjhfyIy1vc6T
 YfqPR7KpwOAtxmN04QC7vC3hy4kTvOxFW24Y0U/TU9rOXq8ww7ZSJRun/inXmti68Xd7
 YncAe6heVaOsrr6BkT2O5fJFKVPEIeaULJFPCqvMnSiY3OqtcmTg6w/bG2OApf0PaYbE
 P8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ewOtjr4UZrfFRDIXVCzRs3CL4b5yTdTxIiGT/zc/TlA=;
 fh=Jg1GwjOEZ1S4lNqzrPlyRpppkKciiPaSkBs16SCT10U=;
 b=UZ7Pmgm7om8pSZRW80ldkV2kE+XI9fhAOiLhQWInLTlKKuhPkbTOhR1ae1/faSZNZr
 thjCEZC+56anOo9G83e2epwZWARQDuPaiCyOd4OcG8Fbon/17Yyrqhv0+fWbW+Dz5rmb
 oTVSSsj3WlGW3bj2k7WRkI5nivZgrkUjfrbAjQvny15fTp+oPcnn3mXSM7C9KqSR9SBa
 DCHT/kTkl/6pfz6EgXuD2waJabgncvYhZQsxjGQRrBGgwVLICTTisFtl/xw0BqLvBOuM
 eELs1o2xw3k4o1GXEFe2xkQTlwFZGGIqallwTwlsymUKi216OSIcLmlPfkLFHmyCctV1
 2vMA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777959889; x=1778564689; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ewOtjr4UZrfFRDIXVCzRs3CL4b5yTdTxIiGT/zc/TlA=;
 b=smY00Kv+pxaqbyhUxlDX5ZNoJE9g9GGvzM0mGHYfk+TMYMNel5+Pqg0if3f87m1AOD
 nh/mkyHr+/xhKk1yvqtfkmLFoYPvgJUVz6sgxWz4/rTaqP2neJmiDGDRqp/S+z6+aB9s
 D2h07zlnZ6c9Fv1nP3aDc7JhzZ8uif3AFf4sLcFe40tHqAJoKvb6aBLeQwv0wTUomLJH
 EStojEJyJcAo2QG0e2Dd8gZtVMZS4bC5bhz3g+liYtWa0UAW8NPK1MU2L6naTCmGFv2S
 gdmACmwbwMAUFQhU/Pwm2HXDvYdsGb9ZcB8hs3vAOqWrZgx0kV2Yv/jgveYh4ychKcR9
 PLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777959889; x=1778564689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ewOtjr4UZrfFRDIXVCzRs3CL4b5yTdTxIiGT/zc/TlA=;
 b=gbsk8VgN1Dn4Aude6pHRUkcVITE+DSpO/LF54746KpkaE+XJ1EPSxu65K+HjIjumJ/
 oQcn3jTvgCS30/JGvjmg8UREYNzecHyClS6BQVYilvExyP9yBQR/VsKBEPXfJdDildON
 WoWjV1fXs5wdRfK0E+X2iQ/WplaXT8zdOK/AZNuZbY/4bxsH7JZxc4tUNpAUGX+UvOez
 6n+YD6x30QbA/er8EYXU6MLdNsssTNaBu64oKoBv73ZQV6xfEify4Fo5lJ+wuBfNUrD1
 eRBV6RiPTc8aKzM2rBsZ1SCY2d360EkRrcROyE6Ec5GRnCYDj1dVgPKelqNtgXaRobQO
 cmbw==
X-Gm-Message-State: AOJu0YyuXHomMWTBE8TUEjzN9bYZKYkmjfCx1fu2rDV9d6Yrq8y4rmfO
 He1Yzuc7iGbnK8b3wOHM+9qOW9SlRq71WXN/1gS3iYfVEiBx4/K+6wpuOLn6irx0xSu+PlFtx7N
 htcRiYmF3EE6oc0t04WNZwxvgfRzKxtysC9aRQig0BA==
X-Gm-Gg: AeBDievRgPD7W/HdJTa/+qKlzjpkLcdRL9CfyJeG9VFJoHW6q0hHPsDkOgQTwTS9++h
 JdTYFB2HuPRKYzb8Cfhyd1P69wZAhmemku2/MnNDIjmAE4CknxqRep06sb1bNw4H+lwR8TO7RVP
 S4aVklaUJaZXIL9HVLUuI9SqYPDu2cNQRZ67Ly719lFWY1iNFhmz/cqqHOEF8VFSc9AiIZSpBgp
 TIyUr2Gpks38F5XKbcQ7Xl/avAALv8UOPKBuV5fQr/qIk5wRMU2KWH0q1j+ukUZvWn/6s+ZG+Yd
 PTU55951IxXIKjO0NAQylRxoY1+6eE0Dck+G73iBoSO/P6jqp5/Op4fQcuhxNuQpDrFSteerqn2
 kyt8OlOZ3PqpoOv2xfGlvh6gyrii2LPO3d12Vg8vq8v4NxP9vLwVD4/cg00uBlkp2XDnWiRRIXk
 OHBWCrU/yYYGA81LUATdodQA4WOsswYEXDEHDa2s1rZchMecl4yc6aSJ+uieunk2HHR84acL5Hx
 X+wY9pjUKXAMf8ql+QkWAXd/+jm0VavAZPsNmkagEz5s1td+/KNJbdE/LAvhh0+KC6ZQM+eS+xT
 LFK28k86OgF4OJkqET728JbBAnCg2iiUYsJ1yYSsiz4aKu70aR7UAZkAVtR/A8KIm8LLZ4VBPnY
 qdSntLrG+eZHR+NZ/
X-Received: by 2002:a05:690e:1517:b0:653:1c2a:94a5 with SMTP id
 956f58d0204a3-65c3d9d1914mr10538024d50.8.1777959889499; Mon, 04 May 2026
 22:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-6-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-6-b19301d1948a@cherry.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 May 2026 08:44:12 +0300
X-Gm-Features: AVHnY4JMTwU1EKR4ePfOWYHuLkuMWbBPtKBLye5N9d7Yr069c3K4Iu2Bd0Qd1no
Message-ID: <CAC_iWjJFQJQyoT=pWhVo=E7SK3tH+prB_t8k2B3mu1wUiGKYDQ@mail.gmail.com>
Subject: Re: [PATCH RFC next 06/18] Makefile: move deprecated-non-prototype to
 scripts/Makefile.extrawarn.u-boot
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Mon, 4 May 2026 at 16:20, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> This option is specific to U-Boot and was added back in
> commit 52ee1a0294e8 ("global: Disable deprecated-non-prototype warning
> with clang"). It was added next to other flags which are imported from
> the Linux kernel Makefile. This makes it unnecessarily hard to backport
> patches from that project since we'll always have a difference in the
> git context.
>
> So, move this to the new scripts/Makefile.extrawarn.u-boot file where we
> can store everything that is U-Boot-specific and lower the efforts for
> syncing with the Linux kernel for Makefile.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>  Makefile                          |  1 -
>  scripts/Makefile.extrawarn.u-boot | 18 ++++++++++++++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index a0e9406bc59..bfd4976a0d4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1007,7 +1007,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
>  # source of a reference will be _MergedGlobals and not on of the whitelisted names.
>  # See modpost pattern 2
>  KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
> -KBUILD_CFLAGS += $(call cc-disable-warning, deprecated-non-prototype)
>  else
>
>  # These warnings generated too much noise in a regular build.
> diff --git a/scripts/Makefile.extrawarn.u-boot b/scripts/Makefile.extrawarn.u-boot
> index 21872a5492b..0a9b49a30f0 100644
> --- a/scripts/Makefile.extrawarn.u-boot
> +++ b/scripts/Makefile.extrawarn.u-boot
> @@ -7,3 +7,21 @@
>  ifneq ($(findstring 3, $(KBUILD_EXTRA_WARN)),)
>  KBUILD_CFLAGS += $(call cc-option, -Wvla)
>  endif
> +
> +ifdef CONFIG_CC_IS_CLANG
> +# We have a number of places in the code which use the following syntax:
> +#
> +# void func(a, b, c)
> +#     int a; /* Does a */
> +#     something_t *b; /* Pointer to b */
> +#     int c; /* Does c */
> +# {
> +# ...
> +# }
> +#
> +# Which while not what we document as our coding style, this is also code
> +# which we have imported from other projects, and would like to re-sync
> +# with in the future. While the biggest example of this is the zlib code,
> +# there are other places as well. For now, we will silence this warning.
> +KBUILD_CFLAGS += $(call cc-disable-warning, deprecated-non-prototype)
> +endif
>
> --
> 2.54.0
>

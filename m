Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353A8F3ED54
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 14:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56C0784118;
	Sat, 11 Apr 2026 16:37:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R1bE2CHL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7622E84154; Sat, 11 Apr 2026 16:37:27 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B2B083DC9
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 16:37:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-66e6d9610d8so4253243a12.0
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 07:37:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775918245; cv=none;
 d=google.com; s=arc-20240605;
 b=UucWreAfDmba29GwuRk5yWDHQbOY/u1V3Nfb+CEt84nM2U0X31PafHDkSW3CIGMc0S
 E/h8FI6w8X2kJROFKDlogbiPDMUAgENx8Qy6+KtSt86m6onZZ5X+JOGmRQCKVpP5ZujV
 th0rxG2H5aU7M9K9K8LrE2wJe0P0U2/waZ0sGcwEbBcxm2rpAmJ3A0mMI014VbF4ru3E
 6EGiCRyEEinBalkY9hA9Ke+byq+Yq1PxLeSg94m0JIf+iuwFq2zwKKbrg+bphm52OM2B
 y0MwP/GE1BduSqW08K5iUBBQDH+7t6sMjiJoqsmKA8jOb9TmF7mFBkt8ZVey3XvJf3We
 BGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Rt80GfA6RakNRZ9Irm4POf15iOmJdRi6hJGdVbDTzXQ=;
 fh=Gd5+a9uUrr4s6WJjvIIOS89zSsxCc+V9mQKHqwrvrq0=;
 b=eyvxvcSNGIdopUoZL1OGoXZPGfYt5ao6loMDg8qaxBa5V2nwQgroBmDmzSwQTixd9b
 sMHRlrfkbvbFn2n7DzgZFjk8BflpfTnFK+e3qAGTDtIB9Xf+FMpwOBOMcdTsuClFYRWB
 yMtOSRPiYk5y+6Hx12qvp3tfKkro7eQIrFjCrggVSzzW2hHfWHcvRjbbmaxG/rKPZxkM
 LiNYtdoLL7Ts5o9RnJfQlTya18Wt/SdE5qevDQD3WwMek2LP5fxMhInK04Jfl26KVbya
 V0DheUHDE53+05Rk7t6qF7wnoP2lTfQQgB0zzhqi2lNjCGUY2vJ0wo5miN60C8JqX/3q
 611A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775918245; x=1776523045; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rt80GfA6RakNRZ9Irm4POf15iOmJdRi6hJGdVbDTzXQ=;
 b=R1bE2CHLoezs1LYlbJBpE8l8s4vI1MMHGIRJ548G9XzBtaZTICrQkeEONTMVKMdJ6R
 4cDrM9qQzlw2aGopU9uEaTd+sw85Zk58YsA0v6E94GFWahOU/QGwCu+XFkvUKJo88BMU
 owoRP2uMgcoOQg4LhmnMB46BVmhAHCxuhHH4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775918245; x=1776523045;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rt80GfA6RakNRZ9Irm4POf15iOmJdRi6hJGdVbDTzXQ=;
 b=Ab7oUosaf+I6lRJl3iDBvp7tBIlxzpgH497pi7cghvFAwAaRBPwHWgs157RyaLSi3j
 IxY1pKCRGrHBkZcYPEoH9tjA+hJ604nawonRSWNkB61isSMLIqwmf6annn35FNQs/nQZ
 GjPGR2pp2G/uGU09hkgg6TIQSeIdKqNLteUs77ST3Y9qKNrp76xIqOMNoaDKQThiR9xp
 bPYC7WVaQizyjwR4cRq4w4HEWXub7iL2q5gChWb7b5z3i4/zMPm7NjoOd6MwHX6HnUDa
 Xwj4dUxIuSh4t8Pu3mUbzxYfWtWCgL/d4PTQ4sRsSdTGWyzlc2q4wmQoa2YUqtAYijUl
 J/cw==
X-Gm-Message-State: AOJu0Yy/gmUkn/Bd2Pp0jo0EO4RPmzq6j86V+aXIvYqdICRsXoWax2Qc
 PlJmeAMphOUWFvRthtSE/LFFDgXFfSvhGASoq8dirM2xH3RbSxBxgzuUjoPkSyLduZoejuhbMa/
 Bz4G8cs/LEyUNt+axTaav5ucE/Eyf3eTh5Lgc36Tw
X-Gm-Gg: AeBDiev7lkYVI9vhIYSXO2iGgX2u9GxjhgicDGmL1VMvXfSUbuZisOAS6DdqVI+aDvD
 8G692Elkv7bsWIaJZlS/TUZTgQKSapFc0knKFTieqzvK38eXOBASpQ3szBOBOS84X57Xgisj74h
 YvDp718/de/KLTu2cCI1HsY1fvIHVQC8gD/cVgE5rMUpuwo0wqj6VUbNL5AyhB35jkYJR4JAQTf
 yWj1umE5LWzWY2u1IkN9rSiLrVwfORbYg74wHO7d+YC9IKUlCUOYFqTu8OZo4eIvZ+LyxIbOK3p
 37uSGg==
X-Received: by 2002:a17:907:168c:b0:b9c:cdd7:c8a8 with SMTP id
 a640c23a62f3a-b9d7279d638mr418706266b.48.1775918244870; Sat, 11 Apr 2026
 07:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
 <20260410-topic-am33-evm-oftree-v2026-01-v5-11-4b9c7aca0e3e@baylibre.com>
In-Reply-To: <20260410-topic-am33-evm-oftree-v2026-01-v5-11-4b9c7aca0e3e@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 08:37:10 -0600
X-Gm-Features: AQROBzCKu1gobAoMT1wrMYpGqSN6A7oms0pso1adNWAui87mZxsT0-B78xK03ns
Message-ID: <CAFLszTjbgkiXO_Tj4Whnz6hjo8XzeA9ohoY4vfcq=-4maq8NVQ@mail.gmail.com>
Subject: Re: [PATCH v5 11/12] dm: core: Split SIMPLE_PM_BUS into phases
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>, 
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>,
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>,
 Paul Barker <paul.barker@sancloud.com>, 
 "Andrew F. Davis" <afd@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>
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

Hi Markus,

On Fri, 10 Apr 2026 at 07:33, Markus Schneider-Pargmann (TI)
<msp@baylibre.com> wrote:
>
> Similar to SIMPLE_BUS, create a SPL_SIMPLE_PM_BUS additional to the
> SIMPLE_PM_BUS. Most boards will not need SIMPLE_PM_BUS in SPL.
>
> This is currently needed to reduce the SPL size for beagle bone black
> with OF_UPSTREAM enabled.
>
> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
> ---
>  drivers/core/Kconfig  | 8 ++++++++
>  drivers/core/Makefile | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
> index 5419bf65b5d653464f8bf958382ede30954d6402..0471e2977d0a993afcafee11874d43016d6738b4 100644
> --- a/drivers/core/Kconfig
> +++ b/drivers/core/Kconfig
> @@ -342,6 +342,14 @@ config SIMPLE_PM_BUS
>           Supports the 'simple-pm-bus' driver, which is used for busses that
>           have power domains and/or clocks which need to be enabled before use.
>
> +config SPL_SIMPLE_PM_BUS
> +       bool "Support simple-pm-bus driver in SPL"
> +       depends on SPL_DM && SPL_OF_CONTROL && SPL_CLK && SPL_POWER_DOMAIN
> +       help
> +         Supports the 'simple-pm-bus' driver, which is used for busses that
> +         have power domains and/or clocks which need to be enabled before use,
> +         in SPL.
> +
>  config OF_TRANSLATE
>         bool "Translate addresses using fdt_translate_address"
>         depends on DM && OF_CONTROL
> diff --git a/drivers/core/Makefile b/drivers/core/Makefile
> index a549890c22b997a8c3e7cd6ab08b2ed2ac7994b2..1073c26b2ed0009e15ccca0bac93a64d882f0df9 100644
> --- a/drivers/core/Makefile
> +++ b/drivers/core/Makefile
> @@ -7,7 +7,7 @@ obj-$(CONFIG_$(PHASE_)ACPIGEN) += acpi.o
>  obj-$(CONFIG_$(PHASE_)DEVRES) += devres.o
>  obj-$(CONFIG_$(PHASE_)DM_DEVICE_REMOVE)        += device-remove.o
>  obj-$(CONFIG_$(PHASE_)SIMPLE_BUS)      += simple-bus.o
> -obj-$(CONFIG_SIMPLE_PM_BUS)    += simple-pm-bus.o
> +obj-$(CONFIG_$(PHASE_)SIMPLE_PM_BUS)   += simple-pm-bus.o
>  obj-$(CONFIG_DM)       += dump.o
>  obj-$(CONFIG_$(PHASE_)REGMAP)  += regmap.o
>  obj-$(CONFIG_$(PHASE_)SYSCON)  += syscon-uclass.o
>
> --
> 2.53.0
>

I'm assuming that this doesn't affect any existing boards.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon

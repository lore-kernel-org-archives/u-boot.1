Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322C5C2FC0E
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 11:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A591786A93;
	Thu, 17 Aug 2023 13:55:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e6tXohIA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CC7886A97; Thu, 17 Aug 2023 13:55:42 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90B9486751
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 13:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fe27849e6aso11883930e87.1
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 04:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692273339; x=1692878139;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+wFcYeeD97FHoOYf5AVWTVUfFGmLGlXgGdO6ED3YxjE=;
 b=e6tXohIAz5PFqBy8t5BZgUzvNyaCHWAI3VPHLs0RH8Y3nzVBaAgVpKNawgp9i3Azs0
 Bx8UDEfiEEAkZzJl/nxe/ET6ywae3pTq03whNE+EJlBf/a/LG4dzL6T20PqXwh/JJxKL
 kRdmeLWVBSv7Dizu3SoDp/FiNPGzsKM+8liTgAFlhioah74UkVj2kkXt+ADMB6pnAHRQ
 CUmf8b48z8U0UGXpR/Gp0pL8fImJ3BsQYJ7h30YgLG9vdlSrp/KSigfMolE1I7xXrB84
 7fIAIOPn62C7+VN/kH3NfdA/+v1ckxW0EZQYCq0rJvSVisa+RY0+seaA0I3GgqS4729q
 dT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692273339; x=1692878139;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+wFcYeeD97FHoOYf5AVWTVUfFGmLGlXgGdO6ED3YxjE=;
 b=Q0BfV24Z9QfDl5HFlvBG5H/SGsHqQAlrd9xAITsMmAS62E+hzMBReKrAX/CU8rkSXH
 Axe5fzGGLJqhbNjLOFLN4DR1DcrCIvD8R//0rxBbD2+3EE1k3C1TO5ZRuKH74ePEyujo
 efmrSRgmao33L6kQCwbI5jTuA62NRH6HVNjwlYnKgkAfbdPIpGemD126Uw4IpXGmYrBt
 GiBNN7TqLuZ1/pheqOzrztZgz1tUlzG4O8MIv1fHbyOUiOzZVZoIIzK630HPVvzKt7o6
 No6/co2Ro2t+F1/3UggJZSVP+MpUAFcjIDTqALMZ45Rhw2UC5pCS5RSroV6i7lGOQpt1
 3Fcw==
X-Gm-Message-State: AOJu0YwntsCgIBvtXogOvrhjujhRZ0eNtJ/10Tl8vDmxvhk2Mp/Qwebb
 VoMr1+Gjguluy76pR1QKcS11qGn4wzbyekwdS62ceg==
X-Google-Smtp-Source: AGHT+IFHtonlPt/NjIZO0Pk4KQnRXLJIbA1wOVbCHwPYg96Tlaflxksy4Goq/VaX/uSKUpCYffpXqVjXDvyCTq6nAfA=
X-Received: by 2002:a05:6512:36cb:b0:4fe:7e1f:b044 with SMTP id
 e11-20020a05651236cb00b004fe7e1fb044mr3759109lfs.15.1692273338462; Thu, 17
 Aug 2023 04:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230817054856.2019253-1-sughosh.ganu@linaro.org>
 <20230817054856.2019253-3-sughosh.ganu@linaro.org>
In-Reply-To: <20230817054856.2019253-3-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 17 Aug 2023 14:55:02 +0300
Message-ID: <CAC_iWjJD7hJGiS--xP7B57YgQUkaPSvLHyz0m6L18Dix5+ywmA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] scripts/Makefile.lib: Add dtsi include files as
 deps for building DTB
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

On Thu, 17 Aug 2023 at 08:49, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> At the time of building the DTB, some dtsi files can be selected for
> inclusion. Have these dtsi files as dependencies for the DTB
> target. This also ensures generation or updating the dtsi files if
> need be.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * New patch which only sets the dependencies for the dtb build.
>
>  scripts/Makefile.lib | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 368b5a3e28..8c5e25c31c 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -334,7 +334,9 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
>                 ; \
>         sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
>
> -$(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
> +dtsi_include_list_deps = $(addprefix $(obj)/,$(subst $(quote),,$(dtsi_include_list)))
> +
> +$(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) FORCE
>         $(call if_changed_dep,dtc)
>
>  pre-tmp = $(subst $(comma),_,$(dot-target).pre.tmp)
> --
> 2.34.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

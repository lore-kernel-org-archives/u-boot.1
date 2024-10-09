Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615CACF0435
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 03:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2A5D89092;
	Wed,  9 Oct 2024 05:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qxg/ZM04";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDE468908F; Wed,  9 Oct 2024 03:52:55 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EFC88908F
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7163489149eso5483945a12.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438769; x=1729043569; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1LTUhVChqY1A3YF+eCtJh9lwZleBViQ/GFPxbHUzaSk=;
 b=Qxg/ZM04aQ3WHJ5KDLDrpZSR58YT7hab/y0WN7btJBrdHZ16gE00QxiV8hWVYe8hEU
 TA+7Kv9R9BxWcZQRzq/K20pa9Q2V4f5RliJTntKIAcTqED6DCOiCBzZVCX3n3aPyS2eS
 /xfHyjBf1WdPNrtpaqcFkOv0CtbGk+iAxg4Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438769; x=1729043569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1LTUhVChqY1A3YF+eCtJh9lwZleBViQ/GFPxbHUzaSk=;
 b=fTO9ASID7TQBS7hdD6Y2XZz5tQ6FgN0YV+hNN9Vy98OYUJwYSkPN6L8NTCQprUL6Tt
 A1tAFCndBPU3Uzi3cjKB3KW1jNF/PFnFRsIQY2XIaIheFNkRgUzV8as4iGh1BWaEf8Lf
 Yz1MnfjTFUZ/9iveh0b7tq2Y3wWMpo/sUjXOqwr4RcK/zJh+DoUoPxYduF8gWWguZE2T
 ber9feD+ye4s5qla1C/BYxcZLrDLFGSLov8k0VwEuNDbtOeFTHsanlA4ulJPFOYlbf3W
 pnYz6TJ43Lz8q+G9VG0hfrIdCz/ri41jzsBc/Gei2U3gWRp4ljWoDRrTmWW6Fiq7IIXv
 44sg==
X-Gm-Message-State: AOJu0YxYDbpizef0QwJlV9FoVTn+osGI++9Wy3d2S/DmcuBd0Zp7DfuI
 kiTnYviFnciPQ169A9CF3k49nVJ5UzXiqTz38kBn7yWdT72b8eMni8ixO0017a30suWYRyS+61x
 aJqb45YI5enxs++NLEPPq0o0srEb1Ub0gb5TC
X-Google-Smtp-Source: AGHT+IED2+SjihD7EDRS7L9hpBpmVpkDDb0YAEVI+6DM3qd8E8ZACx2eySyIyNyZbZL5P15u1VG4TRXwdNU8N9nqvsc=
X-Received: by 2002:a05:6a21:6e4a:b0:1d6:97f2:71b4 with SMTP id
 adf61e73a8af0-1d8a3be3888mr1592096637.1.1728438769164; Tue, 08 Oct 2024
 18:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <20241003215112.3103601-2-raymond.mao@linaro.org>
In-Reply-To: <20241003215112.3103601-2-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:52:35 -0600
Message-ID: <CAFLszTiu55MWujkRv3hvfSpQUzcHzf4yYzARhRMtYDpxL2ehjw@mail.gmail.com>
Subject: Re: [PATCH v8 01/27] CI: Exclude MbedTLS subtree for CONFIG checks
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sumit Garg <sumit.garg@linaro.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Sean Anderson <seanga2@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kongyang Liu <seashell11234455@gmail.com>, 
 Greg Malysa <greg.malysa@timesys.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 09 Oct 2024 05:28:26 +0200
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

On Thu, 3 Oct 2024 at 15:51, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Since MbedTLS is an external repo with its own coding style,
> exclude it from Azure and gitlab CI CONFIG checks.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes in v2
> - Initial patch.
> Changes in v3
> - None.
> Changes in v4
> - None.
> Changes in v5
> - None.
> Changes in v6
> - None.
> Changes in v7
> - None.
> Changes in v8
> - None.
>
>  .azure-pipelines.yml | 3 ++-
>  .gitlab-ci.yml       | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 93111eb6127..b66d49a62ba 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -76,7 +76,8 @@ stages:
>        # have no matches.
>        - script: git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
>                    :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
> -                  :^include/linux/kconfig.h :^tools/ :^dts/upstream/ &&
> +                  :^include/linux/kconfig.h :^tools/ :^dts/upstream/
> +                  :^lib/mbedtls/external :^lib/mbedtls/mbedtls_def_config.h &&
>                    exit 1 || exit 0
>
>    - job: docs
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 7d621031b85..2a52e15d0fe 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -159,7 +159,8 @@ check for new CONFIG symbols outside Kconfig:
>      # have no matches.
>      - git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
>          :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
> -        :^include/linux/kconfig.h :^tools/ :^dts/upstream/ &&
> +        :^include/linux/kconfig.h :^tools/ :^dts/upstream/
> +        :^lib/mbedtls/external :^lib/mbedtls/mbedtls_def_config.h &&
>          exit 1 || exit 0
>
>  # build documentation
> --
> 2.25.1
>

Reviewed-by: Simon Glass <sjg@chromium.org>

(since I queried this on an earlier revision)

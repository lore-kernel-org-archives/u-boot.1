Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9635BC25B5F
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 10:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21C758856C;
	Wed,  8 May 2024 12:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nQGsTsmg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47062885A1; Wed,  8 May 2024 12:14:42 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 617558843F
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 12:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a59cc765c29so770946566b.3
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 03:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715163280; x=1715768080; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ajTM3OBM1+1Yp0JPnCEAkNvq2ga+l9iWB5lAuz4TTUs=;
 b=nQGsTsmgov92cwefcHJorusJUJWBADKlzrHML6cSIjyAbt8O+9sHU9WkWMNXLb+71X
 1IdeDwNlqIZDYK7Dfdm3PYZicuZWBrFvrNIToIeUF2cuxW4vUk4VZ3e08ZvHG2d0cqtH
 wqieThB34jjhoLXsZBjULeDVqf8HaTOwbBkNVYz0pkvNXlFE0kSJp/DzJHoK43lRQEcX
 WS5El6jNRgsrGpR2oOoFMNUdUt9pJ7SmnBD9RdG0UNKePUZFKs9+MuMmPmlwM0R52QCF
 ZP3LK68kL2RpHLAzjeiDXVMHnYqvuNnHPGZxMFFnZFd8/Zxog92wh5YZ/kFmNAxzsTam
 mpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715163280; x=1715768080;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ajTM3OBM1+1Yp0JPnCEAkNvq2ga+l9iWB5lAuz4TTUs=;
 b=rhBXcvnWzQjMgGXwXsnTyQzu99pNCYus2Lj4py4SVvgA90tWOpzEU6BGQahPluyhpH
 hpsHjNtlujaTNn+CBe44q7gZ8rv0OuaQrPpwQ96gQp6z9aEelzdNeAQ7LiFxs2yyEpdP
 GaufCx5oDkjlEUShH2hsLDA2imdN+LvDZoXM6hP1CIkfXTiO1G7Sz2lBs1GmeZ4/poW5
 NshjVaiFL+3+/s+vM7B+e7K9mxi97aUPHkccsf0r1DhaCzMEfuHYcJJa43QvWZTL+Cvt
 vzSm/W/j00TSVbKnRZakTvuiQ0OOs0ML3+QshxPu7RMvlZgztCvLfSBbcnmBoyVJXsIz
 H0uA==
X-Gm-Message-State: AOJu0YzRfEy2g8JHyEcyK51EEpesSKJoBO0z68UWcm7Zxvv+bqORlJP7
 gPtWBvHYPVhnBOPzOONaOeuRq5NXXcnhBBPvI1iQJ328cMgHs+VRrM0pzenJw9rO33TL/+bIEKD
 qbcg6Oxm0YFuN4488rKlsu2QWVT8VvbPImtSKSw==
X-Google-Smtp-Source: AGHT+IH+bTvCQNgZcOta/5XQhur6q72jQB/hhGSmUUvBzBRpvZ8PtHv48ga4d+4CA8xWyezSrdXShIJFBp8CnVj80hk=
X-Received: by 2002:a17:906:6845:b0:a59:f380:1821 with SMTP id
 a640c23a62f3a-a59fb9f3540mr140551966b.69.1715163279906; Wed, 08 May 2024
 03:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-2-raymond.mao@linaro.org>
In-Reply-To: <20240507175132.1456512-2-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 8 May 2024 13:14:03 +0300
Message-ID: <CAC_iWjKK8RqpBz_S0pn_N=z=yXrDku5UQXce_s39C9qO1UJrUQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/28] CI: Exclude MbedTLS subtree for CONFIG checks
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Andrew Davis <afd@ti.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jesse Taube <mr.bossman075@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>, 
 Sergei Antonov <saproj@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, 
 Bin Meng <bmeng@tinylab.org>, Eddie James <eajames@linux.ibm.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Tue, 7 May 2024 at 20:52, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Since MbedTLS is an external repo with its own coding style,
> exclude it from Azure and gitlab CI CONFIG checks.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Initial patch.
>
>  .azure-pipelines.yml | 3 ++-
>  .gitlab-ci.yml       | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 27f69583c65..c8052771fa8 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -65,7 +65,8 @@ stages:
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
> index 165f765a833..a8f7f1940f3 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -156,7 +156,8 @@ check for new CONFIG symbols outside Kconfig:
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B3DC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 12:03:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C7FB8774E;
	Thu, 28 Dec 2023 13:03:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d4DcKxCP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7CFD87A35; Thu, 28 Dec 2023 13:03:32 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B79B8774E
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 13:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50e7aed08f4so2773334e87.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 04:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703765008; x=1704369808; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hedqUp2ogf8l6RLIdXQ6yk8zmoNyrw8t2xabdfAVsM4=;
 b=d4DcKxCPahXqqbv6MHhMoxq7pbY8b2aqr27sH3OYlhqDYNvmU4O77I/cey1o901j8E
 O9KAjzRbw8GkQldbvFKllW8YG+3KVHrrwK/cNqf8aj/jveKrXtOEsDajSLsM6bDRH07U
 TCsudx0mTi0jY0QQ2a0+VdeA+NzesxdAG7hsgPXt5kj8FKMBUKNJQa2Zgi5I9z+gbCtZ
 4gSAnapfayQG8Gk4ioZIQSpZCxV6Mi0hcHClc9+OcxGqRWuCTrEHGjFOvvaKDiLhg7pD
 RWfOP3i10yJX/ouFzIQuZDZR7kLwJKEKwCPkJqIIJomg6CPkfPYKcu0MEFtZqQFfY9cl
 XiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703765008; x=1704369808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hedqUp2ogf8l6RLIdXQ6yk8zmoNyrw8t2xabdfAVsM4=;
 b=tyEuvAxjiTdCBg88CAJYgAJWls2Df3rZpoXq3G10fbh1ygWvSSk95FVNamDbkj23/4
 A+3qV2TYYWTAL56w2w6b4tBMtRALJA5KVfWA2Tgp5DcpSORITiGR7a+SPTS2XNV/xZkT
 fNdxipaOSbMYGG550TJ4zMNe29YnCflvc+a85/E13jxhHeta9Y0VlTSdbW5bTFhTWDag
 A+Xu0hmi1QgXUCXM0B9M1UzN2WVsG/8pSkehXK/8U4hsCQ2Ce28VJzs2zvEsRW6kf1kJ
 g4pp4H4O9lTu7xproxW3T3oR+LbERwkMZ5v2Gfy6tLcQLYMqHeBo2ug4tO4qGszQsYzq
 ASzw==
X-Gm-Message-State: AOJu0YzKHHRsUd5KDoqVbWxujVpM5kSe/XZx+wcCVgYs7p607LpY7u8b
 +bCMqPdTpOaziW8fCuA3Iw1TVBtsiE6eJyxf6KHiKbZNS6mkMQ==
X-Google-Smtp-Source: AGHT+IErF2d+J8Xs176+dkns5eNkMPe2m7zXasK5RNInmjMdOs9GmKvcdwZtN1xfGagA7bEte/D0n7MhOze0qomUAR4=
X-Received: by 2002:ac2:4c8f:0:b0:50e:70b9:8600 with SMTP id
 d15-20020ac24c8f000000b0050e70b98600mr4197585lfl.0.1703765008599; Thu, 28 Dec
 2023 04:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-2-sumit.garg@linaro.org>
In-Reply-To: <20231228115804.3626579-2-sumit.garg@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Dec 2023 14:02:52 +0200
Message-ID: <CAC_iWjJJX+Vuicy__sxqc__9nqLHf8A7v6Lr56=wSLEpieai4g@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] CI: Exclude devicetree-rebasing subtree for CONFIG
 checks
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
 mibodhi@gmail.com
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

On Thu, 28 Dec 2023 at 13:58, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Since devicetree-rebasing is an external repo with its own coding style,
> exclude it from Azure and gitlab CI CONFIG checks.
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v3:
> --------------
> - Picked up review tag
>
> Changes in v2:
> --------------
> - Excluded gitab CI config check and added commit description.
>
>  .azure-pipelines.yml | 3 ++-
>  .gitlab-ci.yml       | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index d6f3fa423c6..f100c4493e6 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -65,7 +65,8 @@ stages:
>        # have no matches.
>        - script: git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
>                    :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
> -                  :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
> +                  :^include/linux/kconfig.h :^tools/ :^devicetree-rebasing/ &&
> +                  exit 1 || exit 0
>
>    - job: docs
>      displayName: 'Build documentation'
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index fee165198ae..96ca9f72bbc 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -161,7 +161,8 @@ check for new CONFIG symbols outside Kconfig:
>      # have no matches.
>      - git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
>          :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
> -        :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
> +        :^include/linux/kconfig.h :^tools/ :^devicetree-rebasing/ &&
> +        exit 1 || exit 0
>
>  # build documentation
>  docs:
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

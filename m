Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D073CCFC5F4
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 18:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B4E48925C;
	Thu, 10 Oct 2024 20:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GIkFTYuR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1CC6890FD; Thu, 10 Oct 2024 20:50:26 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D70D891A5
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 20:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e290554afb4so1284828276.0
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 11:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728586221; x=1729191021; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HKdHqzxrMGYfF7UF3F1x/bNOy6qJ2zX/nWmvj1ohPdY=;
 b=GIkFTYuRc83kwCIGQuBieeCyNOVahs6PcD1tKRRonl/iug8As/5zAwhnR8x3IPL/AR
 r9iIGZHnCq11EiLH9mj83gp/9dB5bFCdllawY/egEkdHFYnbuJ3q4x4C8Fjh3Hcivn/8
 QCP8yJqsw64vfbq7wxIP3dUVExJ4rcfqHjmxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728586221; x=1729191021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HKdHqzxrMGYfF7UF3F1x/bNOy6qJ2zX/nWmvj1ohPdY=;
 b=OBA6lqcGDk+WnLwfhnKwVxLIet1sJj7Jj+UDrMQGC0bpOV7vM/OkB4MUSGYl6/6xZx
 26rcroErYTKTQ2R6Uyvb29JkoRZGzJOBZ4EDozslCPVsf0BllHSrY5pH1l79Ey2Erioj
 iOhxAEb+yOoeTWpVi/6NDQmXR1bh1/0b+hsBmjkJgL/cWG1Lumym+2qHauSm3X93+Yf9
 +CqlpEgLyfGsz3Ivjhf5l7Q0YHYZgSy2aIrrJRhDVjOQhRM3dD8fXPXZ1cn8Ism2ZV/D
 DLyTgJhGG/sqo34MkLJDHz1IHzwdoucv4xFbTPeQCNCx+zZRTNuPeASbAb3x0hWAfb7Q
 0Nsg==
X-Gm-Message-State: AOJu0Yyxe0Pt3lA3AKk50Eu0JuP0tIr9+QvHowKh4+8Mf95FyT/5Q50i
 48itWIsufuiS100cWLU9ZGuqfhTZ+p2B8V7Tl5iM03VeTZVYoGWVpucgr6MUoKRhnrPGji6ylo2
 scPljt1hn5SNMBIOzn4UyAwmkfaR+/IxwhkZjUUA4e3Z1SY0=
X-Google-Smtp-Source: AGHT+IFysPKGXGnIyKDR4CDbHqGsMdeGHTubhjFReOSjFFPaUCKAm10pCm/Il/sbz0N5vs6rlL/5xp6iZaG3XFLlXgo=
X-Received: by 2002:a05:6902:2506:b0:e28:b560:acc5 with SMTP id
 3f1490d57ef6-e2916a32a08mr623320276.46.1728586221589; Thu, 10 Oct 2024
 11:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240815195746.749042-1-sjg@chromium.org>
 <20240815195746.749042-4-sjg@chromium.org>
In-Reply-To: <20240815195746.749042-4-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 10 Oct 2024 12:50:11 -0600
Message-ID: <CAFLszThRC=YvhPaiQD2bnvNFsGZZVexa3cx=NZ6PaBEdB-7Z2A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] RFC: CI: Skip building dtc for world builds
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sean Anderson <seanga2@gmail.com>
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

Hi Tom,

On Thu, 15 Aug 2024 at 13:58, Simon Glass <sjg@chromium.org> wrote:
>
> This is quite a significant waste of time in the world builds as dtc is
> built separately for each board. Skip this to speed up the builds.
>
> Unfortunately the newer dtc produces a lot of warnings, which causes CI
> to fail. I am not sure what we can do about this.

What do you think about this one?

We could install an older dtc in the container, perhaps?

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v3:
> - Drop patches previously applied
> - Add dtc patches
>
>  .azure-pipelines.yml | 2 +-
>  .gitlab-ci.yml       | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index e1b2f87b974..4bdf1daa59c 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -561,7 +561,7 @@ stages:
>            cat << "EOF" >> build.sh
>            if [[ "${BUILDMAN}" != "" ]]; then
>                ret=0;
> -              tools/buildman/buildman -o /tmp -PEWM ${BUILDMAN} ${OVERRIDE} || ret=$?;
> +              tools/buildman/buildman -o /tmp -PEWM --dtc-skip ${BUILDMAN} ${OVERRIDE} || ret=$?;
>                if [[ $ret -ne 0 ]]; then
>                    tools/buildman/buildman -o /tmp -seP ${BUILDMAN};
>                    exit $ret;
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 0a15b7352cd..b231b6cd5a4 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -104,7 +104,7 @@ build all 32bit ARM platforms:
>      - ret=0;
>        git config --global --add safe.directory "${CI_PROJECT_DIR}";
>        pip install -r tools/buildman/requirements.txt;
> -      ./tools/buildman/buildman -o /tmp -PEWM arm -x aarch64 || ret=$?;
> +      ./tools/buildman/buildman -o /tmp -PEWM --dtc-skip arm -x aarch64 || ret=$?;
>        if [[ $ret -ne 0 ]]; then
>          ./tools/buildman/buildman -o /tmp -seP;
>          exit $ret;
> @@ -118,7 +118,7 @@ build all 64bit ARM platforms:
>      - ret=0;
>        git config --global --add safe.directory "${CI_PROJECT_DIR}";
>        pip install -r tools/buildman/requirements.txt;
> -      ./tools/buildman/buildman -o /tmp -PEWM aarch64 || ret=$?;
> +      ./tools/buildman/buildman -o /tmp -PEWM --dtc-skip aarch64 || ret=$?;
>        if [[ $ret -ne 0 ]]; then
>          ./tools/buildman/buildman -o /tmp -seP;
>          exit $ret;
> @@ -129,7 +129,7 @@ build all PowerPC platforms:
>    script:
>      - ret=0;
>        git config --global --add safe.directory "${CI_PROJECT_DIR}";
> -      ./tools/buildman/buildman -o /tmp -P -E -W powerpc || ret=$?;
> +      ./tools/buildman/buildman -o /tmp -PEW --dtc-skip powerpc || ret=$?;
>        if [[ $ret -ne 0 ]]; then
>          ./tools/buildman/buildman -o /tmp -seP;
>          exit $ret;
> @@ -140,7 +140,7 @@ build all other platforms:
>    script:
>      - ret=0;
>        git config --global --add safe.directory "${CI_PROJECT_DIR}";
> -      ./tools/buildman/buildman -o /tmp -PEWM -x arm,powerpc || ret=$?;
> +      ./tools/buildman/buildman -o /tmp -PEWM --dtc-skip -x arm,powerpc || ret=$?;
>        if [[ $ret -ne 0 ]]; then
>          ./tools/buildman/buildman -o /tmp -seP;
>          exit $ret;
> --
> 2.34.1
>

Regards,
SImon

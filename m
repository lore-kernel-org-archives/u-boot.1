Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C20C71133
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 12:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45D3C86699;
	Fri, 25 Aug 2023 14:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ewqjeEqd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68DBF86898; Fri, 25 Aug 2023 14:00:31 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA3B186699
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 14:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52a23227567so1302493a12.0
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 05:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692964828; x=1693569628;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P2XyU53rKu+mJuXxMzv+NHCg7dhz+gAC/KP/6Ufihsg=;
 b=ewqjeEqdKL1CUJO0fYEtz5SaWWxLYtgUnMX2gTYt1Fe13pu30T3o/gWcHaOWtSun0S
 Vud4FA6s8KxfAvu/mMruaR+Vk90EeQL1N77chNr7ct7L0L3ssPbYDO9oQpgkWFNp7VTe
 jQmWyPRq+Oph6KY6JHItuomTnMFSMID8GicGsD0pFGo/OCbFme8rIMOVJD67C0crrutc
 VX3zq0A8TKtquQC1HmxNoxUOZF3z6qztJsz2GmtjGmg4u8iyXEKlkIm0VxYHg1E9vOO7
 1IPHDiVhRD6utcK3oMoC5TcN8PNcdqeqMjsnoHGe0ZYq+8J3zGXNxROkPb7AvW2BTrob
 cxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692964828; x=1693569628;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P2XyU53rKu+mJuXxMzv+NHCg7dhz+gAC/KP/6Ufihsg=;
 b=ZBgtsoVkQmcKqsFLlxogTbI3dYl9oWbm4r84nAhoXLzy55UyBfuxggq70eNVC3l6+V
 uz1AU9fg31osX1mYA9UNqfK/nvG3xlM0ST2PUYRZb/HzSmJwYF2eOc2TuJR8R47Q2k8z
 g37dddyQIJwHpd+Xi9nzxLNxvwKCyTgnMOpsPXGzqZC2f7j5mmjqXamUh+RXQaICs61o
 gPCQc7AgY6V6tpkCA9vooxgk80ZUoOsbq2oRLaKGqcRsL+xApJ31fLSrsZ8b+Ood57+S
 /5CiNgOA8zYdpE7mX5GKMy4Rf4b9ea8sDFVjJHjkAh4pja6pPQyWNWbSFvuxa1XVU6xN
 WIew==
X-Gm-Message-State: AOJu0YzRFlEesvA1chitm4Igbc5H7RxXPHzKi9xfCn8kpNmniyfmaiFY
 Rkgfdwf2+WmRuJETZSx2LALKfizDLuSUOp90fwpVAQ==
X-Google-Smtp-Source: AGHT+IEUU+b12qbTKWrOnbaO7xEZwcLqwrHjv6HUDXrDLq4X87ifQjkpjxKuXA4ReQEmAhk6GpCOVO75pmAa19yTFHg=
X-Received: by 2002:a50:fb83:0:b0:527:3a95:5bea with SMTP id
 e3-20020a50fb83000000b005273a955beamr12645725edq.32.1692964828189; Fri, 25
 Aug 2023 05:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230824195917.1687886-1-sjg@chromium.org>
 <20230824195917.1687886-7-sjg@chromium.org>
In-Reply-To: <20230824195917.1687886-7-sjg@chromium.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 25 Aug 2023 17:30:17 +0530
Message-ID: <CADg8p96y_rM7eMWzTD+4zNzjw4B-M-S9ja=rTO5Cw6iY1eFx7g@mail.gmail.com>
Subject: Re: [PATCH 06/19] FMU: Avoid showing an unselectable menu option
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Brandon Maier <brandon.maier@collins.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kautuk Consul <kconsul@ventanamicro.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
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

On Fri, 25 Aug 2023 at 01:29, Simon Glass <sjg@chromium.org> wrote:
>
> Use a menuconfig to avoid showing a menu which cannot be selected in many
> cases.
>
> This option should really go with the other 'Update support'.
>
> Perhaps we should even consider a top-level update/ directory?
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---

nit: s/FMU/FWU in the commit header.

Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>

-sughosh

>
>  lib/Kconfig             | 4 ----
>  lib/fwu_updates/Kconfig | 6 +++++-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 9addcfab3734..bfab2f3165a7 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1118,8 +1118,4 @@ config PHANDLE_CHECK_SEQ
>
>  endmenu
>
> -menu "FWU Multi Bank Updates"
> -
>  source lib/fwu_updates/Kconfig
> -
> -endmenu
> diff --git a/lib/fwu_updates/Kconfig b/lib/fwu_updates/Kconfig
> index 71f34793d926..be35ad29fa32 100644
> --- a/lib/fwu_updates/Kconfig
> +++ b/lib/fwu_updates/Kconfig
> @@ -1,4 +1,4 @@
> -config FWU_MULTI_BANK_UPDATE
> +menuconfig FWU_MULTI_BANK_UPDATE
>         bool "Enable FWU Multi Bank Update Feature"
>         depends on EFI_CAPSULE_ON_DISK
>         select PARTITION_TYPE_GUID
> @@ -10,6 +10,8 @@ config FWU_MULTI_BANK_UPDATE
>           multiple banks(copies) of the firmware images. One of the
>           bank is selected for updating all the firmware components
>
> +if FWU_MULTI_BANK_UPDATE
> +
>  config FWU_NUM_BANKS
>         int "Number of Banks defined by the platform"
>         depends on FWU_MULTI_BANK_UPDATE
> @@ -31,3 +33,5 @@ config FWU_TRIAL_STATE_CNT
>           With FWU Multi Bank Update feature enabled, number of times
>           the platform is allowed to boot in Trial State after an
>           update.
> +
> +endif
> --
> 2.42.0.rc1.204.g551eb34607-goog
>

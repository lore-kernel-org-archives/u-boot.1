Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65AFC77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 10:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 407EA82EC6;
	Fri, 27 Jun 2025 12:03:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E03BxhrK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 821DC82E9A; Fri, 27 Jun 2025 12:03:01 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24F6A82EC6
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 12:02:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ae0d758c3a2so284320566b.2
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 03:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751018576; x=1751623376; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7oY6l/FhHOnK+B+coeX603M0ApfncJfG2zROVxiG9wg=;
 b=E03BxhrKm2Yh29ST2AxlQ46fFoP4XRhgDKtEo0M85lTUubsyVJkcsfHpaL6dv+AJof
 yodUgDLZXl9z9lIuywABUYiOVnEXZv7Qc7j8mh2HLgFhUYITshy/DqyzWa7yx2UjXnE/
 E35Csq41zSpYqA3pcXHXZIrnzieo4yCMRp95M6xMa7yziZnfDjw4gWNy+/Q1LUPncrqt
 F8UonzdAqn6etCThNVdnMjsRqA9lD+dP/sfd2O5z8FxiCrpFTgIijhEYfpG7VI7s9zcM
 eX/Kl/onXzaRthGM9yAMFDQ0JXjS4Cqx4/NVUeDNrb4zVekuVrYaNlcslMeOwNd6b3K/
 +SPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751018576; x=1751623376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7oY6l/FhHOnK+B+coeX603M0ApfncJfG2zROVxiG9wg=;
 b=hA8wTROoff3/RKB6p7L7zPps2mM+i5D1HvlaIF3ikBd9+RAU2EVmzK75TfAeUDPaP7
 UXeJdj2XPsHpKZrWDpGg5hs8ZCs/x8dF9rSdoigE7+TELcgIGNLojjlD3rdRg6cG1a09
 TYBrGQqku/7naFJxiaTLKD2EAZG0+z60gjpuUJMDI8wol/PxnuuN9BI1DADgVFmyl030
 jF8OV9rv9DncNHQKURCaFr9kXtYqnPvJWMUmwHv0fcjbR5M/79mhmZ29XpMLApvW+VgQ
 btVjgZR7MGGtOZVKDKvxM5B07DwH20x28iKLfNUtPrOxvB+O0pKPC1JbrEzsTutUwxLq
 E0wA==
X-Gm-Message-State: AOJu0YzsShd9iwUNGYRHK9sXlnFlYSSftxhuoaGiVVF+quzEtPQCW9Sa
 Y6IAXHsdMZFlqyMoe2Px9dmaP9232Ep5sQznBGb5EIW5H0zNwAHUcc37RZ4Z3T/SYxpmdt0bC1h
 4g9XcPKbtTyTqyHmUhZt9j7G5pqaPeRo=
X-Gm-Gg: ASbGncvGQjHFTPE2KmThIBlGHRt/gCUppJhkMFs2vwIpEiE5N0LsVB8TEeQuiWHc0hb
 7DHJZhp1ZVU9CjlvoJFuCkfY3q7/ZsCp+jy/ozb4Jno8XQEsAcvvQxrMuhmlg02/FPXP1tgva/A
 W3fjMQ2PK0I0VUAONpbiVDfUlvGHaPz+muKpnWFbSmM4vpLO4OWLAJsnPkuo94RG4W9XbpZ/CW9
 ZYmqKhs2O5/SU4=
X-Google-Smtp-Source: AGHT+IHKqANFtKBwk9PN9eiLJW/sn/06QX17v+uiMTTFcYa1URB1p739QugfnkOu5vJitCBsLGWC+oL2z7j10Hcv78c=
X-Received: by 2002:a17:907:3f08:b0:ada:6adb:cca with SMTP id
 a640c23a62f3a-ae34fd3370cmr227288866b.6.1751018576224; Fri, 27 Jun 2025
 03:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <3f2984f62d6bda6a4a432b51047eddb70e35571f.1751014184.git.michal.simek@amd.com>
In-Reply-To: <3f2984f62d6bda6a4a432b51047eddb70e35571f.1751014184.git.michal.simek@amd.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 27 Jun 2025 11:02:45 +0100
X-Gm-Features: Ac12FXxGWaUMc93FU-rPrO91Cxm7y8qiLVunpmwoASbGoU8_VVnN0EEwSCGjgvY
Message-ID: <CALeDE9ORhMR6Zj=Ps+BBBLax67kLDxFPdWtr_V99Pyy+XhuTKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] cmd: Introduce CMD_HELP
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Fri, 27 Jun 2025 at 10:45, Michal Simek <michal.simek@amd.com> wrote:
>
> Add option to disable help command in size constrained systems to save some
> space.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

> ---
>
>  cmd/Kconfig  | 6 ++++++
>  cmd/Makefile | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index f21d27cb27f2..3f4221cb4d02 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -189,6 +189,12 @@ config CMD_FWU_METADATA
>         help
>           Command to read the metadata and dump it's contents
>
> +config CMD_HELP
> +       bool "help"
> +       default y

Maybe "default y if CMDLINE" as it also doesn't make sense if there's
no cmdline enabled.

> +       help
> +         Command to show help information about other commands.
> +
>  config CMD_HISTORY
>         bool "history"
>         depends on CMDLINE_EDITING
> diff --git a/cmd/Makefile b/cmd/Makefile
> index 80cf70b7fe8c..718eff4ed197 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -7,7 +7,7 @@ ifndef CONFIG_XPL_BUILD
>  # core command
>  obj-y += boot.o
>  obj-$(CONFIG_CMD_BOOTM) += bootm.o
> -obj-y += help.o
> +obj-$(CONFIG_CMD_HELP) += help.o
>  obj-y += panic.o
>  obj-y += version.o
>
> --
> 2.43.0
>
> base-commit: 8c20ef07b8939e5ea703224ad91a8669badaaae5

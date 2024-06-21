Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D1DC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 05:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9890F8826B;
	Fri, 21 Jun 2024 07:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qu49mS/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1443B882AD; Fri, 21 Jun 2024 07:33:21 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 951C688059
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 07:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6f971cb3c9cso852074a34.1
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 22:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718947997; x=1719552797; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OycmTPLKhpfabgha4t40dr9BJMmcQmI1jEnwAQGEpQc=;
 b=Qu49mS/s+37DfnmXDJTKbRdjf6d0TBvdBYcAm8+AJ/RFK0ygm5IeOZVFBzSl3d+SXg
 y88wxzMhmshXRLkK4stn30sRFmfC++OfyVIUUoiBwmqlu1Xqin2zG89fFf1Lzt0bBX/m
 JzJaQpg9GAh2gwGNh9jQDIaEov7OmixWjvAEwXHj2pKznH7hZiWariEtzsn7rSG67Rlm
 l5WXTc9N+Mx+Xt9zDFGLQyDJM/ND/v3S5v+yz0/fp8DLBImPaJHc2XaVpCB/bBE556/4
 FxOOPQMgwfkDQwaf1bGmun3p6nVR00Ce+oC55VB3Aa6xNa1POOtroFQp/jsCK2AReM30
 QhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718947997; x=1719552797;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OycmTPLKhpfabgha4t40dr9BJMmcQmI1jEnwAQGEpQc=;
 b=H6ZHFWg8n60IL3w8SCDRBv7uPhRjfoE5ujTXEOMFUVdcNmsS1bSea9dUjLQm+RI39I
 oJRf5xhjQCHl3qcZ9AZWY4csBOPE7w8+BU1cNrt4dV/Eyu1Xf6hkDUl1wOjecFcWlEsZ
 axbrFA2xgHy7zkdhMBV6iYNwP5Enyyma8MvJbECsoDvPqc1lAL4lVxEOBWH6HFQc8Acf
 SzeaE4BF3+Nt3CfypFnQQuliKsZg8gb3IMruOO3k5XORf2KZsER8AVvX2fcz18TBITVq
 X8qLk6F8oT10QMnV6UHKvSAsOGphOG/rNQHZRQ2s8CetzkITh4WqjiOJlvEWnjtrXFbj
 kInA==
X-Gm-Message-State: AOJu0YzzPuh/YXKIMxz87HUTaPRCARlU9ZhrjR97y+hT5lSQ9E09UxPi
 XhqsJTS9XzIIbonXIWQK6skofttrvj/tFl+rNllSzP8sjJdujMVktYgMEg5DiMBCzaZ0zS15DA/
 jcG2LnLsuXKw2x1LExWHkOouSpgZNBvwReORc/Q==
X-Google-Smtp-Source: AGHT+IE5FWI6T/5euUP5CR0k+AxbbYKZSSOikHVecZePjTaqwBGKIUL/aDBl7qRmp1CtcAdf1OR7Nu+44EUDTnfIu4k=
X-Received: by 2002:a05:6358:6f90:b0:1a1:f99f:47fc with SMTP id
 e5c5f4694b2df-1a1fd57e183mr956033555d.22.1718947996956; Thu, 20 Jun 2024
 22:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240620230625.1797397-1-sjg@chromium.org>
 <20240620230625.1797397-11-sjg@chromium.org>
In-Reply-To: <20240620230625.1797397-11-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 21 Jun 2024 08:32:40 +0300
Message-ID: <CAC_iWjKtOjR9evF81MhTVUKsn6OB5s=8O40+CZE-Y4+YfQO9GQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/18] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
 Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Sean Anderson <sean.anderson@seco.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi Simon,

On Fri, 21 Jun 2024 at 02:06, Simon Glass <sjg@chromium.org> wrote:
>
> It does not make sense to enable all SHA algorithms unless they are
> needed. It bloats the code and in this case, causes chromebook_link to
> fail to build. That board does use the TPM, but not with measured boot,
> nor EFI.
>
> Since EFI_TCG2_PROTOCOL already selects these options, we just need to
> add them to MEASURED_BOOT as well.
>
> Note that the original commit combines refactoring and new features,
> which makes it hard to see what is going on.
>
> Fixes: 97707f12fda tpm: Support boot measurements
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v2)

There was a discussion in the previous version, bout enabling these on
CMD_TPM as they are required.

Thanks
/Ilias
>
> Changes in v2:
> - Put the conditions under EFI_TCG2_PROTOCOL
> - Consider MEASURED_BOOT too
>
>  boot/Kconfig | 4 ++++
>  lib/Kconfig  | 4 ----
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 6f3096c15a6..b061891e109 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
>  config MEASURED_BOOT
>         bool "Measure boot images and configuration when booting without EFI"
>         depends on HASH && TPM_V2
> +       select SHA1
> +       select SHA256
> +       select SHA384
> +       select SHA512
>         help
>           This option enables measurement of the boot process when booting
>           without UEFI . Measurement involves creating cryptographic hashes
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 189e6eb31aa..568892fce44 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -438,10 +438,6 @@ config TPM
>         bool "Trusted Platform Module (TPM) Support"
>         depends on DM
>         imply DM_RNG
> -       select SHA1
> -       select SHA256
> -       select SHA384
> -       select SHA512
>         help
>           This enables support for TPMs which can be used to provide security
>           features for your board. The TPM can be connected via LPC or I2C
> --
> 2.34.1
>

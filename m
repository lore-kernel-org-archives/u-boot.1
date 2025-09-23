Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1175CAC5A5
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 18:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33EBF80C93;
	Tue, 23 Sep 2025 20:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W5jDTSP2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C4DA82ADA; Tue, 23 Sep 2025 20:32:52 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F320880107
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 20:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-62f4273a404so344136a12.0
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 11:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758652368; x=1759257168; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ggJYG3hGrZRVhnfgEtOBc6b789Qv8tSeDvkjg8D4zgw=;
 b=W5jDTSP2BhlOItvmKuRny3NrZMT+PUH2QMdW14DlDRGLLucaTjM5yINjT+ju7twYP2
 KbChvsrWhoZBTpKR2s3endSEp5l8MmUCUoZU+xCax0Q/Ai1Wxwr7+ULh38DgeMOiijpQ
 /0LizdRyZ3cbZbnNnUi9teIs+IU0Xeql0PY50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758652368; x=1759257168;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ggJYG3hGrZRVhnfgEtOBc6b789Qv8tSeDvkjg8D4zgw=;
 b=LpLESCOXT6NJbxiLTVZYEp6vMCHBSmwq9l+SrZ6S2i1fF4VVHjn3CZJeUUCfOSHBQ8
 7DX/HD1LnITI59yKLEvqvvUtofniKm8XzUAH3igpSEgKmDmEZ8mxdNlikbYGtsFoat53
 vkYMJxdpogDYEOvd3/IFNc58VYMIkcHdcMXAqbirXz2Z6Ct/y/qNtc7o1LhzChse2lE6
 rVsH+lAkOFFuSMr0I4UE/+ArOEl1MZJIdVTHSYPYhPM0wXNh5D2FZH2RgLvsLKTnsMsV
 cjp/bkJ4LcTgfgKymmvoC2zntXAO+CxJ5BBcm2uIFQ6IlgR+zTqLCRmwrlRx6ydbQL5n
 2eEA==
X-Gm-Message-State: AOJu0Yz5QURbBwP6thyLIQEtkaYrQV1fnC2VffzfdA//mTtzD/22XMxJ
 rjOHKWIQGypruVS+DJks0Ubo4RGKYPTAijuiNlwLsINd6Ao27rElbsdbIgGx/qfI6I1IOdRMnwy
 rtuI6KMaJb+GwmRhj6dWGnXbBprGoDjQniV4zvRubNEsAXElVlntNDQ==
X-Gm-Gg: ASbGncu2nExUrjvWDf00nCm4FHHlLh3ahDxt99tXwZpXn8Y03PUYHmXdILIFZgliMyL
 W4uzspFHRS3Lkyb78mF3hm4TMuZzt5xsTDu98J5CoVpxttoOTTgBnM8w41r9eA4BTCu5y31r+ZW
 l5n3uxWRU3ju/zutulPTe7xqY80OOaiGLMjBjZQD7bBw2GCX2RZyv3Wryu8mQ0SmpZ1kI5og9C9
 DLAyg==
X-Google-Smtp-Source: AGHT+IH55fQsB9yp5krHBLrP8dv+CEDsZMVqwJNeUIxp1PKZCvIHzCcjHVqXyqfAEbptiqTnezo98HVBeI2QF/KB2wI=
X-Received: by 2002:a17:906:f58d:b0:b04:5888:7a7d with SMTP id
 a640c23a62f3a-b301d300869mr307326866b.22.1758652368381; Tue, 23 Sep 2025
 11:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250923183053.786043-1-sjg@u-boot.org>
In-Reply-To: <20250923183053.786043-1-sjg@u-boot.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 23 Sep 2025 12:32:34 -0600
X-Gm-Features: AS18NWD3k38qfVtXtvNqVUqR6xtaaowLtHgxgyUBCqFklZ_Yq0kzMNzxqB63BRQ
Message-ID: <CAFLszTiS4StO5M_RkK-H0HCyj+P1D=9v7fJNw4JsdDQ3zg3O4w@mail.gmail.com>
Subject: Re: [PATCH 1/4] colibri-imx8x: Increase the boot delay
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi,

Sorry for the noise, please ignore this patch.

Regards,
SImon


On Tue, 23 Sept 2025 at 12:31, Simon Glass <sjg@u-boot.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> A delay of one second makes it hard for the lab to interrupt boot, thus
> causing test failures. Increase it to 5s
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  configs/colibri-imx8x_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configs/colibri-imx8x_defconfig b/configs/colibri-imx8x_defconfig
> index 3d576da05b3..210bb83d5f8 100644
> --- a/configs/colibri-imx8x_defconfig
> +++ b/configs/colibri-imx8x_defconfig
> @@ -24,7 +24,7 @@ CONFIG_REMAKE_ELF=y
>  CONFIG_FIT=y
>  CONFIG_FIT_VERBOSE=y
>  CONFIG_DISTRO_DEFAULTS=y
> -CONFIG_BOOTDELAY=1
> +CONFIG_BOOTDELAY=5
>  CONFIG_OF_SYSTEM_SETUP=y
>  CONFIG_USE_PREBOOT=y
>  CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile ${soc}-colibri-${fdt_board}.dtb"
> --
> 2.43.0
>
> base-commit: 136c959dd2d089710fb131956081d09b9da3bea4
> branch: labh

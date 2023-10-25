Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8FAC07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 12:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1948E87AA2;
	Wed, 25 Oct 2023 14:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ehjk0uzC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5580F87AA8; Wed, 25 Oct 2023 14:42:20 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B85E687A9B
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 14:42:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5079f9675c6so8819315e87.2
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 05:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698237733; x=1698842533; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+vKm2cOFn4Aimt/eirzulXenPCKc+XpXyyH5rnIqVKQ=;
 b=Ehjk0uzCF9YJbcLgYEJQRmOG6GruBNntQBlZabVXL9qHD4hS3b/8kayKPF99Ry1rp9
 UgRwZwixVpOS2CSpjwaZsdjiVHbKZd2xzKAxzVM4qylrofWLyaIRfn9puuIBWIWiprgX
 7Zuz3zmYFgAxiCiXwTO3uvTX+dGtaQdGypMKI3qV0LVER+G/1P6v3P2XYcLO/JAfgNl/
 pYTMEPAQkyG0ecHGtqqF3eL19dUvg98sFbJsgJvTKTIURx/cEfLJisFmHevH1nw/Wjk+
 8e4RQGiG+9wrH16hzeG2vON5QxptKUYNps+uot6O4J3cl9+00kSgnxmqxey8R5E2sKJS
 8nOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698237733; x=1698842533;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+vKm2cOFn4Aimt/eirzulXenPCKc+XpXyyH5rnIqVKQ=;
 b=WC9Oe4d/Or0+QC0AvvpXQfkheDpuqyjviuk1BWepBZ/YVCTOUlCXGjKraCanpjTqiM
 Vs+U8Rbt8Qjh1IwJii/TMMmFf5K9rzSqByQjx+hWNa8kirrto6Dig1kzHGvSQRe0JEPD
 5NPesukFlZYvsN523tgj0kx9ln+UVp28sjD/fMrCaWe528fZCRgTZ9Z+Nv6ZNENQXJV5
 JhHQGeUiRsWfF3i21/MbU/PnQjG2z37XDzrSjy3b/Rr1Jsdv5MybPLH+Uw0ZQ0vbfwzP
 JFrzbHLwcxx5L/OXdMm3o/NguqfpCGoh56KK/D3ODjpmXBeDpiRn5UEz9LO0T3E2emUl
 zkKA==
X-Gm-Message-State: AOJu0YwRlj3pXg/sfoFNI6eyFkBNC37T6kbLZuOMjoVlNRUHDQyIjh/S
 5Y7dYawZmCK1dHH38NMw6dnMY5NFM9Gk/fJLi77znA==
X-Google-Smtp-Source: AGHT+IExht86qkYa7Oz1IEyA81OXJRsLJlcISuvdPJOsdXH4x3ZEFDSE2H6Pzadc5iNanWjJWjidPmr91nWEBGtjcq0=
X-Received: by 2002:a05:6512:234e:b0:507:f0f2:57bd with SMTP id
 p14-20020a056512234e00b00507f0f257bdmr11337975lfu.66.1698237733064; Wed, 25
 Oct 2023 05:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231024154354.197524-1-eajames@linux.ibm.com>
 <20231024154354.197524-5-eajames@linux.ibm.com>
In-Reply-To: <20231024154354.197524-5-eajames@linux.ibm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 25 Oct 2023 15:41:36 +0300
Message-ID: <CAC_iWj+3ww08s=FnSFeAQW_tOFw3GL9pc_=MuvhrmDxDxGZe1Q@mail.gmail.com>
Subject: Re: [PATCH v14 4/8] bootm: Support boot measurement
To: Eddie James <eajames@linux.ibm.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, xypron.glpk@gmx.de
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

On Tue, 24 Oct 2023 at 18:44, Eddie James <eajames@linux.ibm.com> wrote:
>
> Add a configuration option to measure the boot through the bootm
> function. Add the measurement state to the booti and bootz paths
> as well.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes since v8:
>  - Added a configuration option to select to ignore any existing
>    event log. This would only be selected for systems that know
>    that U-Boot is the first stage bootloader. This is necessary
>    because the reserved memory region may persist through resets
>    and so U-Boot attempts to append to the previous boot's log.
>
> Changes since v6:
>  - Added comment for bootm_measure
>  - Fixed line length in bootm_measure
>
>  boot/Kconfig    | 32 +++++++++++++++++++++
>  boot/bootm.c    | 74 +++++++++++++++++++++++++++++++++++++++++++++++++
>  cmd/booti.c     |  1 +
>  cmd/bootm.c     |  2 ++
>  cmd/bootz.c     |  1 +
>  include/bootm.h | 11 ++++++++
>  include/image.h |  1 +
>  7 files changed, 122 insertions(+)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index a01e6cb8aa..abbc72f4cf 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -685,6 +685,38 @@ config LEGACY_IMAGE_FORMAT
>           loaded. If a board needs the legacy image format support in this
>           case, enable it here.
>
> +config MEASURED_BOOT
> +       bool "Measure boot images and configuration to TPM and event log"
> +       depends on HASH && TPM_V2

I know Simon reviewed this already, but don't we need to add !EFI here?
UEFI already supports measurements via the TCG protocol implementation.
But since EFI is 'default y' nowadays anyone minds if I change the
help & bool messages during merge?
Something along the lines of
bool "Measure boot images and configuration to TPM and event log when
booting without EFI"

[...]

Thanks
/Ilias

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FD7C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 13:21:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BCD18803F;
	Wed, 27 Mar 2024 14:21:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="he8e14wp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05FC887FCC; Wed, 27 Mar 2024 14:21:57 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCEC58803F
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 14:21:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-dc236729a2bso6457696276.0
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 06:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711545714; x=1712150514; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ybs85gXS1D4CCtv2QwXT/6ThGcM1/X5nMMdyucROD+4=;
 b=he8e14wpiU0vz1o3juxL8qz77B3opuiYQRgNw9O24zAh+ztWbTyfrYFrTP9e03oTfB
 MYRr4GyvdFmxPnBOJmQJW/E4RzIcIV4nYDDrlkORp1LQK+HTu00LweBR4GUo2JW4pFW/
 +N2s2BWG7IiMHBQJI+/KbwpQl/ASDiMEsBgF1xDDvI8I3WaAf+PekvTJR38GNVpJa2l7
 GcVysEivWbq6K4xQMVM8xQyLh9HEGuq6bKJGwwsZq3B3SW/MBUnChh37abv43KQbryG9
 JQ3MPA0wV/mxFjRJ4YZNo18lT+bZmP4I8/XkCXlENfQWkG25t4/13lQmszPRhBkZTvhN
 691Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711545714; x=1712150514;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ybs85gXS1D4CCtv2QwXT/6ThGcM1/X5nMMdyucROD+4=;
 b=A1KvTUmxeIqRiJxwGdgV8acebhKaVnZ9OZ6hld96rcfA11WCDGHuxreUH6hM10zLOU
 ij4OWtRBfzXVzwnL+uT1fY75ygOx8IEWrq0MQtd98tOzouJ0pEuKQ/9Vg1i6odiss2J9
 1Qfa1fhiXYAKBxdqlFrt+38yQAqCs1+Ls3wGNhhRfprD/0ZZ2CY3sI9ziN6B0WHF5YHR
 wMFRTsChMRq91HtAq21mSXHA3NunoeQ/M5oyb6zn6KauIg5CMP33lxMl40XoQDe+48kg
 gXaYv09TTR9/dhnqTVebAxtPFoVFuM+QaAcTlEJ0HexDqJrHHbYc9HT0M7OcQxw0yEmS
 bAPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBXMB0o10Vn7VwwPj13qcf1aSt3Tv0HgsuWd7g6NOQG6XQ1k5TZZmz5wD7NqefB4xbHr1IA3rKb0kpnSyQYFITJOIOYg==
X-Gm-Message-State: AOJu0YwXKDVHpoXpECPRgyccmjn0lT1gHS9sNEAlg7qOhaM60A8n4Rvu
 b/fK2ZtKKMGYKF9YkXsbSab7t3T6h0+IGkYLKByJn3oa9sTmioMzKe9/QuwdFudF49waPwdN5Uq
 c/m6DHa4m9hd3EZ3JEkg1BDmhnvUbknOz5bWxRw==
X-Google-Smtp-Source: AGHT+IHBfLp/ULfo/eh91/W64wdpMKDeTddqg03JStiSNaUsUgmnbaWBkCUYP32J29p29B1qN3PBTGvAuKUuZfSKuJE=
X-Received: by 2002:a25:bc87:0:b0:dc7:46b7:6d67 with SMTP id
 e7-20020a25bc87000000b00dc746b76d67mr3573394ybk.33.1711545713734; Wed, 27 Mar
 2024 06:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240327-imx93-of-v1-0-afab6b31422a@nxp.com>
 <20240327-imx93-of-v1-5-afab6b31422a@nxp.com>
In-Reply-To: <20240327-imx93-of-v1-5-afab6b31422a@nxp.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 27 Mar 2024 18:51:42 +0530
Message-ID: <CAFA6WYPb9wg128rYu_76d1vh2q47TfRgkF1e3LOaJfGMpGEaQg@mail.gmail.com>
Subject: Re: [PATCH 5/6] Makefile: tune the include order
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
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

Hi Peng,

On Wed, 27 Mar 2024 at 18:41, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> For OF_UPSTREAM support, the U-Boot headers under dt-bindings/ maybe
> different with OF_UPSTREAM headers. So let OF_UPSTREAM headers be
> included first when migrating to OF_UPSTREAM.

No, please don't do that. The current include order gives preference
to the U-Boot headers under dt-bindings/ such that we don't break
platforms which haven't converted to OF_UPSTREAM.

So while migrating to OF_UPSTREAM, you should just drop redundant
headers under dt-bindings/ instead.

-Sumit

>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index b80924241ec..b9c2d896c2e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -827,6 +827,7 @@ KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
>  # Use UBOOTINCLUDE when you must reference the include/ directory.
>  # Needed to be compatible with the O= option
>  UBOOTINCLUDE    := \
> +       -I$(srctree)/dts/upstream/include \
>         -Iinclude \
>         $(if $(KBUILD_SRC), -I$(srctree)/include) \
>         $(if $(CONFIG_$(SPL_)SYS_THUMB_BUILD), \
> @@ -835,8 +836,7 @@ UBOOTINCLUDE    := \
>                                 -I$(srctree)/arch/arm/thumb1/include), \
>                         -I$(srctree)/arch/arm/thumb1/include)) \
>         -I$(srctree)/arch/$(ARCH)/include \
> -       -include $(srctree)/include/linux/kconfig.h \
> -       -I$(srctree)/dts/upstream/include
> +       -include $(srctree)/include/linux/kconfig.h
>
>  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
>
> @@ -907,7 +907,7 @@ ifeq ($(CONFIG_USE_PRIVATE_LIBGCC),y)
>  PLATFORM_LIBGCC = arch/$(ARCH)/lib/lib.a
>  else
>  ifndef CONFIG_CC_IS_CLANG
> -PLATFORM_LIBGCC := -L $(shell dirname `$(CC) $(c_flags) -print-libgcc-file-name`) -lgcc
> +PLATFORM_LIBGCC := -L $(shell dirname `$(CC) $(c_flags) -print-libgcc-file-name`)
>  endif
>  endif
>  PLATFORM_LIBS += $(PLATFORM_LIBGCC)
>
> --
> 2.35.3
>

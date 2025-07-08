Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B696EC8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 11:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2570283123;
	Tue,  8 Jul 2025 13:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SuqiL7AF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7018183242; Tue,  8 Jul 2025 13:32:17 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 577338305C
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 13:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-70b4e497d96so37645437b3.2
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 04:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751974334; x=1752579134; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gnPLZC5+YFtd+H8kknRN1UriWBPGzRBujWsUC9NY7Qc=;
 b=SuqiL7AFNWRbgkSt24+tw6MoyGC1UskWTC7pwHxZ4lGZKWzKNgRkBoIboPCkbGuvFL
 zYAClk8xGgtcpJELrziOcdg2szT3hduLds1tc9c8jM7TJUctBR2vyxfkM9daginnxeJL
 HeOdxxIR9C+OC1Y7VLRBKR1rU7eSOkVDhIbdcdGM9an5KAcTxyHlDVwPZE4gXL/KGL2e
 T2HmmB8PfLIdpnHV+JdRekILLja+IdoysJ1AAaGcqSnYSrqJ0s7NhBWvEYQuoINSB5LP
 aiGgAQXObW5XgRcmRzs8oFj6vvA0TvdEXjkGgyfI/vd1ddVfl/1/S/ymiRsBdz0f+27F
 5lsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751974334; x=1752579134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gnPLZC5+YFtd+H8kknRN1UriWBPGzRBujWsUC9NY7Qc=;
 b=JuUi0JmTSgG0/wZjd9CilNMAV7Rn3SlTx+bukGAA1phWIkWzqpWHYu/YtVYYnlP6sf
 T7kcYq5JXQfk8EkXJ+i0t2xgdxKMSgtZIv13TEyJPmNb2Sgw3iR8tRGMvH2uHKB/jQ+V
 dx2g6cFpE5ICBs6doqoZOh2ZqRmZaKENMxiOnWoJTyebXlgHWXNOj6iSTEKJmDxxmw0f
 PGMfcwtFjEmGS9gf4t13bDHQpK4QZnHwS2RxVa/DynkkNUsD/kcNrtzLhL0chYdjV71d
 jAV/9ro+rHU9mcG0aGnFR/5EJZjc6FmR1Vh1l17VTxgce3pNspl8Y1Y3tQivCOVtfcx1
 9vkg==
X-Gm-Message-State: AOJu0YydsKi1f4Lzg/l7IEJfOHnc1xOH4C05+xwb/rk5jbXZwMDjl9pS
 Qo5dGd4/IoHZ8QlAruSETrGAcGEEFVr052DvZ2p5ALYJYwOfhgVy1gmYY6st5wDVcEeY4CtNdTO
 oQh1RwzPmrwFOXd5w364BHogC0N9g9BAFEOBjqcQPmN1UmUuFvvUq+jN23Q==
X-Gm-Gg: ASbGncttVtfsfG9nh/bwosfOhZeciGN5JfkxS/L7DKj0rcsGHdc6Tg1FR86Xz8afZs/
 yHwVI+tObdRRU2DfXMTmw7wyALgrV6kEzl8WpG4dE2HctFBJmtlDf3UTdFORlZXYBKhD/lhyJso
 4kapXX2z4HT/NHycxKIOK94Z9/88PMseW0FBkyZSAQ3fE=
X-Google-Smtp-Source: AGHT+IEEuAUPFcSg7cSTqBXG6ee9YQWHKPLXHjVnEYcb4tm22lpPt2tYEKBu6abC4qqSbp0KmY6RY22eo42AE/NwX1Y=
X-Received: by 2002:a05:690c:610a:b0:714:115:712f with SMTP id
 00721157ae682-7166b5d75bdmr219370697b3.6.1751974334014; Tue, 08 Jul 2025
 04:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250708103959.26129-1-pro@denx.de>
 <20250708103959.26129-2-pro@denx.de>
In-Reply-To: <20250708103959.26129-2-pro@denx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Jul 2025 14:31:37 +0300
X-Gm-Features: Ac12FXzwqJYqUhH4Xvg8GTAudh_D9sZi8Cdn3UIdfgIYkqx-8Y9oZb0Mw6l_sEE
Message-ID: <CAC_iWjKFBJRG290byhLj0cZjdLKhWOD+7NMZu5OY1sokgNb8Lw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] Makefile: Add size check for u-boot-with-spl.bin
To: Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Paul Kocialkowski <contact@paulk.fr>, 
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
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

Hi Philip,

On Tue, 8 Jul 2025 at 13:40, Philip Oberfichtner <pro@denx.de> wrote:
>
> Like other images, u-boot-with-spl.bin may be subject to size
> restrictions. Extend CONFIG_SPL_SIZE_LIMIT to handle this case.
>
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> ---
>
> Notes:
>     Changes in v4: none
>
>     Changes in v3:
>         Reuse existing SPL_SIZE_LIMIT instead of implementing a new option
>
>     Changes in v2: none
>
>  Makefile           | 1 +
>  common/spl/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index fa9ce756083..791c00713ec 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1545,6 +1545,7 @@ OBJCOPYFLAGS_u-boot-with-spl.bin = -I binary -O binary \
>                                    --pad-to=$(CONFIG_SPL_PAD_TO)
>  u-boot-with-spl.bin: $(SPL_IMAGE) $(SPL_PAYLOAD) FORCE
>         $(call if_changed,pad_cat)
> +       $(SPL_SIZE_CHECK)

There's a rule in the Makefile
ifneq ($(CONFIG_SPL_SIZE_LIMIT),0x0)
SPL_SIZE_CHECK = @$(call size_check,$@,$$(tools/spl_size_limit))
else
SPL_SIZE_CHECK =
endif

and

isn't this running?

Thanks
/Ilias

>
>  ifeq ($(CONFIG_ARCH_LPC32XX)$(CONFIG_SPL),yy)
>  MKIMAGEFLAGS_lpc32xx-spl.img = -T lpc32xximage -a $(CONFIG_SPL_TEXT_BASE)
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 9a17ccb2d3d..dcb25b593f1 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -43,7 +43,7 @@ config SPL_SIZE_LIMIT
>         default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
>         default 0x0
>         help
> -         Specifies the maximum length of the U-Boot SPL image.
> +         Specifies the maximum length of U-Boot SPL images.
>           If this value is zero, it is ignored.
>
>  config SPL_SIZE_LIMIT_SUBTRACT_GD
> --
> 2.39.5
>

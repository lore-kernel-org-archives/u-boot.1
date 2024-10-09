Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A96CF07A3
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 05:23:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EBF98904D;
	Thu, 10 Oct 2024 07:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ClaDU8/P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C38088770; Wed,  9 Oct 2024 17:32:46 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC8C188CA8
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 17:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e06ba441cso2707915b3a.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 08:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728487961; x=1729092761; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A0kreBFcOqs4PaVT77RR6ICgg9QK0eWztZH7Jmemssg=;
 b=ClaDU8/PvkcLQfP6AUchaeb8CbeLZWIzfVljiOXbnA4L/CPT0P4bXWS+HWCE3ca5Zg
 fZUp3Kr6GtucwT4JpeI6IZD781eWzrYDJ/ojjRv+8YQeL+cg/2szQq8N6LQfj6DF7FXG
 /tGdVuP8XG6NPyii1uXitafWizr4lFI/9rBgZGYm+sRP9nixElTS6XoqUG5NF4Gn71le
 E8S4/4XsGCqAnM2SZPTtQor22bDZARuLE+p9R1Xt0sptqsauQGrPsWVMRw793I5EL2Qc
 d32fN84t6CHVxHj6g69lp3pLMnPsOA9MeNl/CvOj/36btAtIB4gHL5WfWd1r5GNcu3t4
 APKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728487961; x=1729092761;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A0kreBFcOqs4PaVT77RR6ICgg9QK0eWztZH7Jmemssg=;
 b=gjoBnnnU5TUpyDPSyPad+7XhL+qAg/3d4lt0L2+W9/3plFbnqtjHRVjU84M72YFIQO
 FuneqF0NnT8MdMq8Cqkzr+mZu2iMHfCATivr9UdP4crxE9ThlJJQCan7hjP9Y0DUzZZX
 xPWsxBsWbpbAsjhAzpZS72UhFaIqJ2JCYFR3V9t1FLweenNQKMCeHx0lx9hBjHwszYMH
 u+bJGZ/q4KxLQ+wYix7/RnzQgf30Yeodz/+Kf5HFyiQaPqXYEESg+fTMbkz1r2cJ9h6y
 1hH1tUDfzj3MOqA2oq+ialGcoh0bVm1Xu89AXAIqxTmbxfGY5LMqlcfZWcQYhBcgzyQd
 NPSQ==
X-Gm-Message-State: AOJu0Yyh8+1BR9dBWMQ3v11uRVDMsXDofPxQC4SMILKwijF+3aUa8O+C
 vdBC32qWe9V7w25WG/L/LSfTlbkAiNi1U/MVH1AgQEHlDohmRO2ptj6ZIOd8KOLog4VJw7mTOX6
 r902wk5t/4Sc3RA/jUoU7GaItjPHYC12EptS8hg==
X-Google-Smtp-Source: AGHT+IE5NJIGqrLzRsQTV3KX4mTeg0wAXDoR2mvVnyU6HahPv+Z6dwl6Qi3U3tuKtZMqFWybmSMpZ9V/vpyCYk2M7Ds=
X-Received: by 2002:a05:6a00:816:b0:71e:19d0:2988 with SMTP id
 d2e1a72fcca58-71e1db85912mr4230863b3a.14.1728487961057; Wed, 09 Oct 2024
 08:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <20241003215112.3103601-4-raymond.mao@linaro.org>
 <20241009143824.GJ14210@bill-the-cat>
In-Reply-To: <20241009143824.GJ14210@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 9 Oct 2024 11:32:29 -0400
Message-ID: <CAEfUkUJXa55pJP-DypJy-FGhpkQiSFAS3QB+6s5+55PWmwbZ7Q@mail.gmail.com>
Subject: Re: [PATCH v8 03/27] lib: Adapt digest header files to MbedTLS
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Michal Simek <michal.simek@amd.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Sean Anderson <seanga2@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Marek Vasut <marex@denx.de>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Greg Malysa <greg.malysa@timesys.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
X-Mailman-Approved-At: Thu, 10 Oct 2024 07:23:03 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Wed, 9 Oct 2024 at 10:38, Tom Rini <trini@konsulko.com> wrote:

> On Thu, Oct 03, 2024 at 02:50:16PM -0700, Raymond Mao wrote:
>
> > Adapt digest header files to support both original libs and MbedTLS
> > by switching on/off MBEDTLS_LIB_CRYPTO.
> > Introduce <alg>_LEGACY kconfig for legacy hash implementations.
> > sha256.o should depend on SHA256 kconfig only but not SUPPORT_EMMC_RPMB,
> > SHA256 should be selected when SUPPORT_EMMC_RPMB is enabled instead.
> >
> > `IS_ENABLED` or `CONFIG_IS_ENABLED` is not applicable here, since
> > including <linux/kconfig.h> causes undefined reference on schedule()
> > with sandbox build, as <linux/kconfig.h> includes <generated/autoconf.h>
> > which enables `CONFIG_HW_WATCHDOG` and `CONFIG_WATCHDOG` but no
> schedule()
> > are defined in sandbox build,
> > Thus we use `#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)` instead.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> There's three platforms where we see something like:
>        arm: (for 1/1 boards) all +5651.0 data +112.0 rodata +139.0 text
> +5400.0
>             o4-imx6ull-nano: all +5651 data +112 rodata +139 text +5400
>                u-boot: add: 23/0, grow: 1/0 bytes: 1172/0 (1172)
>                  function                                   old     new
>  delta
>                  hash_command                               108     296
> +188
>                  sha1_finish                                  -     156
> +156
>                  static.sha1_update                           -     114
> +114
>                  hash_algo                                    -     112
> +112
>                  sha1_padding                                 -      64
>  +64
>                  hash_lookup_algo                             -      60
>  +60
>                  sha1_starts                                  -      52
>  +52
>                  crc16_ccitt_wd_buf                           -      36
>  +36
>                  sha256_csum_wd                               -      34
>  +34
>                  sha1_csum_wd                                 -      34
>  +34
>                  hash_finish_sha256                           -      34
>  +34
>                  hash_finish_sha1                             -      34
>  +34
>                  crc32_wd_buf                                 -      34
>  +34
>                  hash_finish_crc32                            -      28
>  +28
>                  hash_finish_crc16_ccitt                      -      28
>  +28
>                  hash_init_sha256                             -      22
>  +22
>                  hash_init_sha1                               -      22
>  +22
>                  hash_update_crc32                            -      20
>  +20
>                  hash_update_crc16_ccitt                      -      20
>  +20
>                  hash_init_crc32                              -      20
>  +20
>                  hash_init_crc16_ccitt                        -      20
>  +20
>                  hash_update_sha256                           -      16
>  +16
>                  hash_update_sha1                             -      16
>  +16
>                  sha1_update                                  -       8
>   +8
>
> This is because:
> > diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> > index 982e84dc3bc..5d7fd904950 100644
> > --- a/drivers/mmc/Kconfig
> > +++ b/drivers/mmc/Kconfig
> > @@ -119,6 +119,7 @@ config MMC_HW_PARTITIONING
> >  config SUPPORT_EMMC_RPMB
> >       bool "Support eMMC replay protected memory block (RPMB)"
> >       imply CMD_MMC_RPMB
> > +     select SHA256
> >       help
> >         Enable support for reading, writing and programming the
> >         key for the Replay Protection Memory Block partition in eMMC.
>
> Wasn't true / required before now, no hashing algorithms were enabled.
> This was fine because:
> [snip]
> > diff --git a/lib/Makefile b/lib/Makefile
> > index c4950b78a29..33755778283 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -50,7 +50,6 @@ obj-$(CONFIG_XXHASH) += xxhash.o
> >  obj-y += net_utils.o
> >  obj-$(CONFIG_PHYSMEM) += physmem.o
> >  obj-y += rc4.o
> > -obj-$(CONFIG_SUPPORT_EMMC_RPMB) += sha256.o
> >  obj-$(CONFIG_RBTREE) += rbtree.o
> >  obj-$(CONFIG_BITREVERSE) += bitrev.o
> >  obj-y += list_sort.o
>
> Got us the library access without bringing in everything else. And since
> two of the platforms that are hitting this now are "nano" this is an
> important thing to figure out how to continue to support. If there's
> just no way around it, we can likely live with the size increase, but
> I'd like to see this looked in to specifically first, thanks!
>
> To address this, I think there are two options.
1. Introduce SUPPORT_EMMC_RPMB into the MbedTLS sub makefile.
2. Make MBEDTLS_LIB_CRYPTO depends on !SUPPORT_EMMC_RPMB.
1) looks to be ugly, I prefer 2) if you agree.

Regards,
Raymond

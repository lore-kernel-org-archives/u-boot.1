Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30FBCF07A5
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 05:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1991B89092;
	Thu, 10 Oct 2024 07:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EPVAlZLp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B226B88DC1; Wed,  9 Oct 2024 19:33:09 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D12D88CC5
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 19:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20b7259be6fso79324715ad.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 10:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728495186; x=1729099986; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FcV3CmrZuVkTsrJkChPnrRlpk1pH9OFaxJwtCuC0XRw=;
 b=EPVAlZLpiKb6DZ5OOCuk+UNG5nmJ8nQ1E7EzDGdkCnIRpORHZUJ+CneTL9dFKT5x/R
 xK1GCC3h184HYOtjGbgHkx0qTd/nOfr56Vj4JWp5rkBYJgDBF7Q5Ofzc2T6n3swv7j4F
 QCSwsYR71Cgs1kE5EoDxL1+g30dEtLwpiAVe5f4vzjrog42T4wPnxdipIyP8me619KIx
 KM3koNQOkHpWPXoCJM9BYoTFvORB4j4lTeitlq83o/Vt6ZykW+PiCqZMSsRHaN29nWo3
 JaQM6nga34q/CIFUAJcUgz7NCow0uRIxzRhRVcfcS19pcrVLNZGf9O9yH9CmX7z8eiAj
 4T0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728495186; x=1729099986;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FcV3CmrZuVkTsrJkChPnrRlpk1pH9OFaxJwtCuC0XRw=;
 b=nmn512f8H0EiHkQBVZYw1eVvgIW7ucemOe36C5wY+sUOs55QQOzqyhjv9IgMkkzgyr
 Q5FRBVeIteo0mj8zHgRrhx0ko/jV4X9TVJoNuPtGYVDY4nhG6pUlsSgGKH0TdHUPd3k6
 IWAbp0T0/vrWcyfn6uoxfs//hbSYaGKWH0vgtiF58gi1vuT5y/x9mFAOpiDZPJ1ndUnI
 x+65cwvaiq9TPNOE6wKmuL1uBwV7h+4UQVOXJ9CAux5LIJrA9d5Ir3X1JzsV6QyRUGwt
 R7cfLtMsY+NgxskqHpkn9r9r6t5f8a19pPeVtkmEu84NFfA59bhuYsmbqYTQwZJ+rjtp
 Vgcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlGK47JvTejKbVQGNIcBjkQ7hv4zVho/BAafmKgpcxDNUpCuXWVfTXTFLNKVzW8KhSsn8TuwA=@lists.denx.de
X-Gm-Message-State: AOJu0YxKoN5s+NdAdRp8i9u0UAdUCWPVdgvlRGcARXuTGe5z9lcqyCwi
 zsBVQnbEjvBEENlVxv92AAWw1nW7QyF1I5NJpy1e+0wPb5Ex620FUuq0B5UyfljliNY+EaKkZLf
 Nluf9e7oGuI/CHYIrN6mdzII53ZB28pg2f4ctPQ==
X-Google-Smtp-Source: AGHT+IGnRC4b80APlPISMDg20daiXVMGT0SrkZSqJUIX/1fkaxs0PFrCynGSuUaTKosz4t6BPnWtqLmKZN0AgjOcVrs=
X-Received: by 2002:a17:902:ec8b:b0:20b:b26e:c149 with SMTP id
 d9443c01a7336-20c63741e46mr45374685ad.29.1728495185662; Wed, 09 Oct 2024
 10:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <20241003215112.3103601-4-raymond.mao@linaro.org>
 <20241009143824.GJ14210@bill-the-cat>
 <CAEfUkUJXa55pJP-DypJy-FGhpkQiSFAS3QB+6s5+55PWmwbZ7Q@mail.gmail.com>
In-Reply-To: <CAEfUkUJXa55pJP-DypJy-FGhpkQiSFAS3QB+6s5+55PWmwbZ7Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 9 Oct 2024 20:32:29 +0300
Message-ID: <CAC_iWj+dBpgCM-WaJBgRyXmn1jWO--tGRTXjAT0hJL5G0V8D0g@mail.gmail.com>
Subject: Re: [PATCH v8 03/27] lib: Adapt digest header files to MbedTLS
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, manish.pandey2@arm.com,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, 
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
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 10 Oct 2024 07:23:03 +0200
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

On Wed, 9 Oct 2024 at 18:32, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Tom,
>
> On Wed, 9 Oct 2024 at 10:38, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Thu, Oct 03, 2024 at 02:50:16PM -0700, Raymond Mao wrote:
>>
>> > Adapt digest header files to support both original libs and MbedTLS
>> > by switching on/off MBEDTLS_LIB_CRYPTO.
>> > Introduce <alg>_LEGACY kconfig for legacy hash implementations.
>> > sha256.o should depend on SHA256 kconfig only but not SUPPORT_EMMC_RPMB,
>> > SHA256 should be selected when SUPPORT_EMMC_RPMB is enabled instead.
>> >
>> > `IS_ENABLED` or `CONFIG_IS_ENABLED` is not applicable here, since
>> > including <linux/kconfig.h> causes undefined reference on schedule()
>> > with sandbox build, as <linux/kconfig.h> includes <generated/autoconf.h>
>> > which enables `CONFIG_HW_WATCHDOG` and `CONFIG_WATCHDOG` but no schedule()
>> > are defined in sandbox build,
>> > Thus we use `#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)` instead.
>> >
>> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>
>> There's three platforms where we see something like:
>>        arm: (for 1/1 boards) all +5651.0 data +112.0 rodata +139.0 text +5400.0
>>             o4-imx6ull-nano: all +5651 data +112 rodata +139 text +5400
>>                u-boot: add: 23/0, grow: 1/0 bytes: 1172/0 (1172)
>>                  function                                   old     new   delta
>>                  hash_command                               108     296    +188
>>                  sha1_finish                                  -     156    +156
>>                  static.sha1_update                           -     114    +114
>>                  hash_algo                                    -     112    +112
>>                  sha1_padding                                 -      64     +64
>>                  hash_lookup_algo                             -      60     +60
>>                  sha1_starts                                  -      52     +52
>>                  crc16_ccitt_wd_buf                           -      36     +36
>>                  sha256_csum_wd                               -      34     +34
>>                  sha1_csum_wd                                 -      34     +34
>>                  hash_finish_sha256                           -      34     +34
>>                  hash_finish_sha1                             -      34     +34
>>                  crc32_wd_buf                                 -      34     +34
>>                  hash_finish_crc32                            -      28     +28
>>                  hash_finish_crc16_ccitt                      -      28     +28
>>                  hash_init_sha256                             -      22     +22
>>                  hash_init_sha1                               -      22     +22
>>                  hash_update_crc32                            -      20     +20
>>                  hash_update_crc16_ccitt                      -      20     +20
>>                  hash_init_crc32                              -      20     +20
>>                  hash_init_crc16_ccitt                        -      20     +20
>>                  hash_update_sha256                           -      16     +16
>>                  hash_update_sha1                             -      16     +16
>>                  sha1_update                                  -       8      +8
>>
>> This is because:
>> > diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
>> > index 982e84dc3bc..5d7fd904950 100644
>> > --- a/drivers/mmc/Kconfig
>> > +++ b/drivers/mmc/Kconfig
>> > @@ -119,6 +119,7 @@ config MMC_HW_PARTITIONING
>> >  config SUPPORT_EMMC_RPMB
>> >       bool "Support eMMC replay protected memory block (RPMB)"
>> >       imply CMD_MMC_RPMB
>> > +     select SHA256
>> >       help
>> >         Enable support for reading, writing and programming the
>> >         key for the Replay Protection Memory Block partition in eMMC.
>>
>> Wasn't true / required before now, no hashing algorithms were enabled.
>> This was fine because:
>> [snip]
>> > diff --git a/lib/Makefile b/lib/Makefile
>> > index c4950b78a29..33755778283 100644
>> > --- a/lib/Makefile
>> > +++ b/lib/Makefile
>> > @@ -50,7 +50,6 @@ obj-$(CONFIG_XXHASH) += xxhash.o
>> >  obj-y += net_utils.o
>> >  obj-$(CONFIG_PHYSMEM) += physmem.o
>> >  obj-y += rc4.o
>> > -obj-$(CONFIG_SUPPORT_EMMC_RPMB) += sha256.o
>> >  obj-$(CONFIG_RBTREE) += rbtree.o
>> >  obj-$(CONFIG_BITREVERSE) += bitrev.o
>> >  obj-y += list_sort.o
>>
>> Got us the library access without bringing in everything else. And since
>> two of the platforms that are hitting this now are "nano" this is an
>> important thing to figure out how to continue to support. If there's
>> just no way around it, we can likely live with the size increase, but
>> I'd like to see this looked in to specifically first, thanks!
>>
> To address this, I think there are two options.
> 1. Introduce SUPPORT_EMMC_RPMB into the MbedTLS sub makefile.
> 2. Make MBEDTLS_LIB_CRYPTO depends on !SUPPORT_EMMC_RPMB.
> 1) looks to be ugly, I prefer 2) if you agree.

2 is not a good idea either. We can't just drop RPMB support when
mbedTLS is enabled

Thanks
/Ilias
>
> Regards,
> Raymond

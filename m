Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C96CE9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6904383CF2;
	Thu, 19 Feb 2026 14:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XW8jUVgR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5BAE83CF2; Thu, 19 Feb 2026 14:11:44 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0221983936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-65807298140so1321696a12.2
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 05:11:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771506696; cv=none;
 d=google.com; s=arc-20240605;
 b=ke4m1EXGB4XKilD7lVwivp+ohhe33vvKNWHoI6Ho2sEhTDwq+zlF0iC/qV1JSDOUW2
 V5r25nk8wVHCmdxljtC5Cecxwpdt0W1cCJ2avTq1fEX4sBnqRxQXtGYLVzN0IERc6qvb
 5qvTY4S8wjY7KploXhXzrydAIfCaOoUpz828Bdh6Ch7iIsVz/P7yXfdzxwm+Qwm3oGi6
 MPOWpKn+usfBkP3HKldlda+NhGkz+nX+Oljpm0oDU5rHy5t2ESItUMqhEHUXFfSmdMkM
 N62kFl3ptPo8k4eOoE/FVeCh5in5I1Nzotmut5km+ad34IFkBHCECW9KQyNv2NBPiaEe
 vsKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ETTfxr3fImS8YeqmeGWFbuZkgV+wdJE2CIVOsjfZecE=;
 fh=Mnr0XWigeKUQjHGXBbT1fApNoU0DnA+RcLfY43TYhRA=;
 b=W2vKU5UEYDMit9EEi6MRabZru+mWWYFM0+uAEtNAGf/QtVGgXY1JzRtHB8V2IWxwoK
 /Lk/R7xlUOHvMxXMa9MiNxy+XhAvlCaq8yKuwWGpI5FDChZ9qdt9E8XAMpQpc7N7giZA
 FUaLTDhblg9Xo1Kzsd427zsrdDVoCgrdHIoSr8e6SSFwm3RrN8Hm7Sv3AHlc9pccmUVD
 5Wa92SKXZP/ONSLcrz7T9bskRFKuhbSUMUUcUFSnANs81ebFhQGh/TyUSpyEOinKtcsM
 5/ko/FfmiORyCg3kg8B2+wECjWL5TgVi7TfDOOoIoOuJQMssl5SzKGnJ2rqD4aMme3jD
 ra3g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771506696; x=1772111496; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ETTfxr3fImS8YeqmeGWFbuZkgV+wdJE2CIVOsjfZecE=;
 b=XW8jUVgRW/1mi1NG7QpJ4RQKMdpjpau4TPXUzzNtI/0OcWvMQsIW6Y3RASG/BXNgjF
 ep6EDBfCWeMp1l+OLcLPo6L1an8msEhQNKk5Vupd8H1heMz780ywAbCrsrC063ySVf9E
 pcPwqWmOBYjuCJK1ZQNQeEYyiHgAE+ANLAngc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771506696; x=1772111496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ETTfxr3fImS8YeqmeGWFbuZkgV+wdJE2CIVOsjfZecE=;
 b=B3kxvQ/2QmzcX7nd40tc27UTGf1FgjxonWdq71PG4c0Erag/gM0kms6/SYY5SPetFN
 mwEQi79YTFlZtSdVgyN08A3a95Py0x4N1ccIGW8sMcsPE+vxEZZHeO7jzNTbX0XQNebo
 gTxf54g5mtUIfhSytLiWNy2HoOj7VJN9EpDpZ4xHXL2AQS/O1RsV4dZUelO1fANGImAq
 yrJFv7StFK4YEzujbZ7dsLXaZA8t+0cHl9IZQ9j87R2zXDIdrCJtJtLqujtaSOJJEK9s
 oaZMf5n8iY799g0LzD5NbPq8jvRmhG5SfmaQdmwzcYUB7R5zlSJAR7Ck99IhZIX4/Kik
 QqwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb6IZJCSj2NJow0RFJ2Hi3uN5mU76f9qxMbQaaTTB6MXsCMflDDFToI/Qoy9+LihnIOcwnSMA=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/JCYEgcRPR8UAx+n7m0yg1qLwHBR3ZFS7SYmez/P7xiOayaT8
 FArBoGo3uElwYab2W67Rtp6bx8SSRiUrSiVTkxRNuf/J7tA4o+L1f8Ntmbzl5uwm38SbO2pa1GS
 SiGWAsc7Xvigz/OeLVKT4HI/lFu68kBSGEQLXgxW+
X-Gm-Gg: AZuq6aJ9s6NuDDplGllA/6JqBVj0AVR04ZFpReOvSezkNH1b+Fw+Vj46SmLVH5IPr78
 q7PQd/+4tSIPeuG4yJCPpXQBwJs4Qca0OGIRxk7IrhVCMhIJhoXEpfeaTGvou/F6rX5UjNmMOLw
 l6biC01iHpgdYfH6i4bpjd1UWr6/XSkVr77FmzPWTV5iTx+hyY+Grc8gpkH1DVWFXcazHppJGKK
 lBv6OCSDeFPQaTeUH+UDzhwsfwgHAoVhDQNm4o4k64caSpUGXHdFPDsNHszXPHJJJ2IZIwPnGay
 pEqFpg==
X-Received: by 2002:a05:6402:234e:b0:65c:238b:8b1f with SMTP id
 4fb4d7f45d1cf-65c76a630e4mr3360265a12.22.1771506696333; Thu, 19 Feb 2026
 05:11:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
 <05cc2003b7e0951a80b0078b3824d14466979b3d.1771275704.git.daniel@makrotopia.org>
In-Reply-To: <05cc2003b7e0951a80b0078b3824d14466979b3d.1771275704.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 06:10:58 -0700
X-Gm-Features: AaiRm51GAqb4b6lzm5xOgkkXUtyXTgbP7Jk-c77F4yM6OWc6dPjJAHUTjX_4FoA
Message-ID: <CAFLszTh3FiMF+eCSxHq7b6hszKphWxyZZpeKrfPAAqEseLhNdg@mail.gmail.com>
Subject: Re: [RFC PATCH 11/20] test: boot: add image_loader unit tests
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Mike Looijmans <mike.looijmans@topic.nl>, Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de, 
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Daniel,

On Mon, 16 Feb 2026 at 14:23, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Add unit tests for the image_loader framework covering its core
> logic with a mock storage backend:
>
> - map() allocates, reads and records a region
> - map() returns cached pointer for already-mapped range
> - map() returns correct offset within a larger region
> - map() re-reads when extending a region to a larger size
> - map_to() reads to a specified address and records it
> - lookup() returns NULL for unmapped ranges
> - alloc_ptr advances with correct alignment
> - map() returns NULL when the translation table is full
> - cleanup() calls backend and resets state
> - map() with multiple disjoint regions
> - read beyond image size returns error
>
> Also fix IMAGE_LOADER_MAX_REGIONS Kconfig to depend on IMAGE_LOADER
> and default to 16 unconditionally (the previous 'default 0' fallback
> caused the regions array to be zero-sized when IMAGE_LOADER was
> enabled after initial defconfig generation).
>
> Register the new 'image_loader' test suite in test/cmd_ut.c so it
> can be run via 'ut image_loader'.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  boot/Kconfig             |   4 +-
>  test/boot/Makefile       |   2 +
>  test/boot/image_loader.c | 429 +++++++++++++++++++++++++++++++++++++++
>  test/cmd_ut.c            |   2 +
>  4 files changed, 435 insertions(+), 2 deletions(-)
>  create mode 100644 test/boot/image_loader.c
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 1f870c7d251..efc06f3cd1a 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1179,8 +1179,8 @@ config IMAGE_LOADER
>
>  config IMAGE_LOADER_MAX_REGIONS
>         int "Maximum number of mapped regions in image loader"
> -       default 16 if IMAGE_LOADER
> -       default 0
> +       depends on IMAGE_LOADER
> +       default 16
>         help
>           Maximum number of distinct image regions that can be mapped
>           into RAM simultaneously. 16 is sufficient for typical FIT

As Tom mentioned, this is in the wrong patch. But really we should
just remove it and use an alist

> diff --git a/test/boot/Makefile b/test/boot/Makefile
> index 89538d4f0a6..6fd349a65bc 100644
> --- a/test/boot/Makefile
> +++ b/test/boot/Makefile
> @@ -23,3 +23,5 @@ endif
>  obj-$(CONFIG_BOOTMETH_VBE) +=3D vbe_fixup.o
>
>  obj-$(CONFIG_UPL) +=3D upl.o
> +
> +obj-$(CONFIG_IMAGE_LOADER) +=3D image_loader.o
> diff --git a/test/boot/image_loader.c b/test/boot/image_loader.c
> new file mode 100644
> index 00000000000..dc4b0b4173a
> --- /dev/null
> +++ b/test/boot/image_loader.c
> @@ -0,0 +1,429 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Tests for image_loader framework
> + *
> + * Copyright (C) 2026 Daniel Golle <daniel@makrotopia.org>
> + */
> +
> +#include <image-loader.h>
> +#include <mapmem.h>
> +#include <malloc.h>
> +#include <asm/cache.h>
> +#include <test/test.h>
> +#include <test/ut.h>
> +
> +#define IMG_LOADER_TEST(_name, _flags) \
> +       UNIT_TEST(_name, _flags, image_loader)
> +
> +/* Synthetic image size used throughout the tests */
> +#define IMAGE_SIZE     4096
> +
> +/**
> + * struct mock_priv - private data for the mock storage backend
> + *
> + * @image:     pointer to synthetic image data in RAM
> + * @image_size:        size of the synthetic image
> + * @read_count:        number of times .read() was called
> + * @last_off:  offset from the most recent .read() call
> + * @last_size: size from the most recent .read() call
> + */
> +struct mock_priv {
> +       const void *image;
> +       size_t image_size;
> +       int read_count;
> +       ulong last_off;
> +       ulong last_size;
> +};
> +

[..]

> +/* Test: lookup() returns NULL for unmapped ranges */
> +static int image_loader_test_lookup_miss(struct unit_test_state *uts)
> +{
> +       struct image_loader ldr;
> +       struct mock_priv mock;
> +       u8 image[IMAGE_SIZE];
> +       void *p;
> +
> +       init_mock_loader(&ldr, &mock, image, IMAGE_SIZE, 0x1000000);
> +
> +       /* Nothing mapped yet =E2=80=94 should return NULL */
> +       p =3D image_loader_lookup(&ldr, 0, 64);
> +       ut_assertnull(p);

AI tends to write it like this, but you can just do:

ut_assertnull(image_loader_lookup(&ldr, 0, 64));

There are various examples of this in this patch.

The test declarations should immediately follow the } of the function
they refer to

image_loader_test_map_basic()
{
...
}
IMG_LOADER_TEST(image_loader_test_map_basic, 0);

Regards,
Simon

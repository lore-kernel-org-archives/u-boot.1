Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8846CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D87F86E54;
	Thu, 12 Oct 2023 05:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R28Xex/j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EA4486ECF; Thu, 12 Oct 2023 05:44:41 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF55286E9E
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5a7ba0828efso6807647b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082264; x=1697687064; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BJIbMIgE6z27K7MAQhOD4rpf/Ix7jWmwVX0iWJTFK4s=;
 b=R28Xex/jMWoJuUDmLZcyG5hTN6xOLEuZrERljEF0WjSFrJ+EfNF2VATVhBfG0+YVvT
 LeqmdOJIZVUfTB9gMS2YIm2C7A3Xj1B4A6wl7qvrD1irmiUt8Ju2pVzJ0H/8dcAkq9F7
 7g8i4Q86ES9TkSe8LK6DMD11pTir2d+6MmuoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082264; x=1697687064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BJIbMIgE6z27K7MAQhOD4rpf/Ix7jWmwVX0iWJTFK4s=;
 b=BYSP6g+bSQ23ClvmFAgHi7S7WIXGh5k0cSuKoFGlCx61+QEA4t9OYp//wkGdC/O7u/
 Nbp+PfYQdW/+ctt1mBtO7TX5nlq59e/qhmpB2NN/EFB7/8jM3LWLU99fu2JdgExx1xdr
 ckPLqcgl19sHb/1ihS62DcKVSsxcZvol2ylU/wl+OAFfMzWYsdduJDZTz41ya+AX8jTC
 psKJ14z9HcxEIo47ZP7Et/CtFQ0Lt9MWjPSFMnrXqRCbA7i4YPfJ6FkHmMtGdYLR2wSA
 15QUW5OEOabcYNGKKAFmquPOFtw19G0Z2cGPpx73QGewHu+yro0Xp6rkYXURWxVYfpvp
 LF+A==
X-Gm-Message-State: AOJu0YwZ4o+BkvpE6Tk2Jdz8eqN2GGoIpbjxT3qIYr2ISX94bKq0qRFl
 SkIty3K2a8KjsucTyNxPnwovSsBY5jeetpqVxEkRj4Xv66QhmS7+hN8=
X-Google-Smtp-Source: AGHT+IEjICH5P2pu48lYSUC8FF3d2ofke6oxt47zD+c2gdt1s0EfRL3QD2we4NeGpM9hdt7uDscaJwjwoLNuuVv/AF4=
X-Received: by 2002:a81:6f85:0:b0:569:e7cb:cd4e with SMTP id
 k127-20020a816f85000000b00569e7cbcd4emr21839969ywc.48.1697082263695; Wed, 11
 Oct 2023 20:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:31 -0700
Message-ID: <CAPnjgZ2WZ-6t=wWMXU7=OP+T_DUZm676a3WTd2YaOHUfqv65XA@mail.gmail.com>
Subject: Re: [PATCH 00/26] test: spl: Test some load methods
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 uboot-imx@nxp.com, 
 Anatolij Gustschin <agust@denx.de>, Fabio Estevam <festevam@denx.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Heiko Schocher <hs@denx.de>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Marek Vasut <marex@denx.de>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nitin Garg <nitin.garg@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Roger Quadros <rogerq@kernel.org>, Stefano Babic <sbabic@denx.de>,
 Vignesh R <vigneshr@ti.com>, Ye Li <ye.li@nxp.com>
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

Hi Sean,

On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>
> This series adds some tests for various SPL load methods, with the intent of
> helping debug v6 of [1]. With that in mind, notable omissions include NAND and
> ROMAPI, which both lack sandbox implementations, and OS_BOOT, which I have
> deferred due to its complexity. Semihosting is also omitted, but I think we can
> test that with qemu.
>
> In order to test all of these methods, we must first generate suitable images,
> possibly on filesystems. While other tests have historically generated these
> images using external tools (e.g. mkimage, mkfs, etc.), I have chosen to
> generate them on the fly. This is for a few reasons:
>
> - By removing external dependencies on pytest to create certain files, the tests
>   become self-contained. This makes them easier to iterate on and debug.
> - By generating tests at runtime, we can dynamically vary the content. This
>   helps detect test failures, as even if tests are loaded to the same location,
>   the expected content will be different.
> - We are not testing the image parsers themselves (e.g. spl_load_simple_fit or
>   fs_read) but rather the load methods (e.g. spl_mmc_load_image). It is
>   unnecessary to exercise full functionality or generate 100% correct images.
> - By reducing functionality to only what is necessary, the complexity of various
>   formats can often be greatly reduced.

This makes sense to me. Also the code to generate the images is
relatively small.

>
> This series depends on [2-3], which are small fixes identified through this
> patch set. The organization of patches in this series is as follows:
>
> - General fixes for bugs which are unlikely to be triggered outside of this
>   series
> - Changes to IMX8 container images to facilitate testing
> - General prep. work, particularly regarding linker issues
> - The tests themselves
>
> Mostly-passing CI at [4]; I have since fixed the typo/missing cast.
>
> [1] https://lore.kernel.org/all/20230731224304.111081-1-sean.anderson@seco.com/
> [2] https://lore.kernel.org/all/20230930204246.515254-1-seanga2@gmail.com/
> [3] https://lore.kernel.org/all/20231008014748.1987840-1-seanga2@gmail.com/
> [4] https://source.denx.de/u-boot/custodians/u-boot-clk/-/pipelines/18091
>
>
> Sean Anderson (26):
>   spl: legacy: Fix referencing _image_binary_end
>   spl: nor: Don't allocate header on stack
>   spl: fit: Fix entry point for SPL_LOAD_FIT_FULL
>   arm: imx: Fix i.MX8 container load address
>   arm: imx: Add newlines after error messages
>   arm: imx: Add function to validate i.MX8 containers
>   arm: imx: Check header before calling spl_load_imx_container
>   Move i.MX8 container image loading support to common/spl
>   spl: Allow enabling SPL_OF_REAL and SPL_OF_PLATDATA at the same time
>   lib: acpi: Fix linking SPL when ACPIGEN is enabled
>   fs: ext4: Fix building ext4 in SPL if write is enabled
>   fs: Compile in sandbox filesystem in SPL if it is enabled
>   net: Fix compiling SPL when fastboot is enabled
>   net: bootp: Move port numbers to header
>   net: bootp: Fall back to BOOTP from DHCP when unit testing
>   spl: Don't cache devices when UNIT_TEST is enabled
>   spl: Use map_sysmem where appropriate
>   test: spl: Split tests up and use some configs
>   test: spl: Fix spl_test_load not failing if fname doesn't exist
>   test: spl: Add functions to create images
>   test: spl: Add functions to create filesystems
>   test: spl: Add a test for spl_blk_load_image
>   test: spl: Add a test for the MMC load method
>   test: spl: Add a test for the NET load method
>   test: spl: Add a test for the NOR load method
>   test: spl: Add a test for the SPI load method
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Yeoman's work, that.

Regards,
Simon

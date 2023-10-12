Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409B4CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C04A86F22;
	Thu, 12 Oct 2023 05:46:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JbCgIoGR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E921E86D20; Thu, 12 Oct 2023 05:45:17 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A5C386F05
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-59f6492b415so4389527b3.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082297; x=1697687097; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T9S761Rx8x4pxRJPeRZHy66n55vxUlL5hvdEWcNDtUQ=;
 b=JbCgIoGRHrwwhZTxZ5y91ovxuu3XrcrHJXzuXOpod0xx9yNey3893VRGF5jZPY4u+5
 hehC4oViPdDflej2UcV94vce537yp6EFnG5/wzutU4QX6MhntY1nBKxh3PJx0aXTNUYc
 x1Gh522VRvSDtx4wGjcK8daKvmpzbGKaEnNtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082297; x=1697687097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T9S761Rx8x4pxRJPeRZHy66n55vxUlL5hvdEWcNDtUQ=;
 b=VPDngoPYW6fNRQg1jg3LeJERcgT0KWxhl0CgmOb+uL28N1GX9TEuOoSFGqLDDbH4Rl
 0Gz9po1dFFv0pwaWV7OlkzLHyB81icp1r+d7M7k+43FTEgSIZDr8izzeVJUfUspCDQ20
 HW6wsGvSrWPVVmVmFIF2d9JJRXu6LsDgeNghX+mc/Srv2PhKZU2TJoPqjIZANY+pEqQB
 j0Zv3xOyD5T9ykX2XK5DM+leJEowapATuV2CNimw1Iha1tcfkI/FnaB9wyLVcC91Xpje
 /ZIYqUpEoqc4EfX03uOe7wvVabNu+36OzTb/161wf4qZvWelaim69/85DuQkjFFqWKoy
 Q3+g==
X-Gm-Message-State: AOJu0YxX+UpTu2TibBAUEwgw0UAgHgChDWr0ekkNjMlzSVTa3+5RntHU
 79JyZ7Sz68cKPjdnXX3pB+FB/Wnri77aLi9e0g5Ngg==
X-Google-Smtp-Source: AGHT+IGSSFiMul0r2SoxEmuNpjo5rWo1bSbfhPyZDnyvOUB86g4h+7s6tcxd1XjlrkFqqePF5b1NkjXa1n2hX6BuBv0=
X-Received: by 2002:a81:a1d2:0:b0:5a7:c887:43bd with SMTP id
 y201-20020a81a1d2000000b005a7c88743bdmr4156349ywg.15.1697082296882; Wed, 11
 Oct 2023 20:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-24-seanga2@gmail.com>
In-Reply-To: <20231012015626.3487451-24-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:17 -0700
Message-ID: <CAPnjgZ04oO7dk0eHn0Dmqj5s7CXTLYMmhBPQjoop6s6pwsrubQ@mail.gmail.com>
Subject: Re: [PATCH 23/26] test: spl: Add a test for the MMC load method
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
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
> Add a test for the MMC load method. This shows the general shape of tests
> to come: The main test function calls do_spl_test_load with an appropriate
> callback to write the image to the medium.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  configs/sandbox_noinst_defconfig |  2 +
>  include/spl.h                    |  4 ++
>  include/test/spl.h               | 30 +++++++++++++++
>  test/image/Kconfig               |  1 +
>  test/image/spl_load.c            | 36 +++++++++++++++++
>  test/image/spl_load_fs.c         | 66 +++++++++++++++++++++++++++++---
>  6 files changed, 134 insertions(+), 5 deletions(-)
>
> diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
> index 11be2dccf7d..4f16d9860d2 100644
> --- a/configs/sandbox_noinst_defconfig
> +++ b/configs/sandbox_noinst_defconfig
> @@ -41,6 +41,8 @@ CONFIG_SPL_SYS_MALLOC=y
>  CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
>  CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xa000000
>  CONFIG_SPL_SYS_MALLOC_SIZE=0x4000000
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x0
>  CONFIG_SPL_ENV_SUPPORT=y
>  CONFIG_SPL_FS_EXT4=y
>  CONFIG_SPL_I2C=y
> diff --git a/include/spl.h b/include/spl.h
> index 7d30fb57dac..8229d40adab 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -673,6 +673,10 @@ static inline const char *spl_loader_name(const struct spl_image_loader *loader)
>         }
>  #endif
>
> +#define SPL_LOAD_IMAGE_GET(_priority, _boot_device, _method) \
> +       ll_entry_get(struct spl_image_loader, \
> +                    _boot_device ## _priority ## _method, spl_image_loader)
> +
>  /* SPL FAT image functions */
>  int spl_load_image_fat(struct spl_image_info *spl_image,
>                        struct spl_boot_device *bootdev,
> diff --git a/include/test/spl.h b/include/test/spl.h
> index 7ae32a1020b..cfb52c90855 100644
> --- a/include/test/spl.h
> +++ b/include/test/spl.h
> @@ -79,6 +79,36 @@ size_t create_image(void *dst, enum spl_test_image type,
>  int check_image_info(struct unit_test_state *uts, struct spl_image_info *info1,
>                      struct spl_image_info *info2);
>
> +/**
> + * typedef write_image_t - Callback for writing an image
> + * @uts: Current unit test state
> + * @img: Image to write
> + * @size: Size of @img
> + *
> + * Write @img to a location which will be read by a &struct spl_image_loader.
> + *
> + * Return: 0 on success or -1 on failure
> + */
> +typedef int write_image_t(struct unit_test_state *its, void *img, size_t size);
> +
> +/**
> + * do_spl_test_load() - Test loading with an SPL image loader
> + * @uts: Current unit test state
> + * @test_name: Name of the current test
> + * @type: Type of image to try loading
> + * @loader: The loader to test
> + * @write_image: Callback to write the image to the backing storage
> + *
> + * Test @loader, performing the common tasks of setting up the image and
> + * checking it was loaded correctly. The caller must supply a @write_image
> + * callback to write the image to a location which will be read by @loader.
> + *
> + * Return: 0 on success or -1 on failure

Do you mean 1 ?

Reviewed-by: Simon Glass <sjg@chromium.org>

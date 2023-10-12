Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BC0C41513
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 16:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED0AE86EB7;
	Thu, 12 Oct 2023 17:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fq0JZ5rE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC85686DDA; Thu, 12 Oct 2023 17:31:14 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABC5B86EBE
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 17:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99c3c8adb27so177608566b.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697124553; x=1697729353; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=38+kB2ly83sFE/+0NRi4/XSCAPX/WLasSYW/RlsU29U=;
 b=fq0JZ5rEpJ4E5SRfU8g+vBgVa3/+mJHsl1loB1wLAh3ODlK9H6+54w9kawpLwcsOi2
 A77OXT84c2UVXqCwFszYCLu6mbXojXxpsZmd/Qoii4+XXtgIXab62CIQUiaMp2txTrgt
 YngYCnceW89K5zrgXk76cnmX4igQM8CD4XT5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697124553; x=1697729353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=38+kB2ly83sFE/+0NRi4/XSCAPX/WLasSYW/RlsU29U=;
 b=HrtGgsW4LAsASgI16cnawzlqZSsc8A1ArH8dbCWYBI2GwFLM7RNOHCqMGGII9/h2y+
 S+6na+VzdtQ5mu/y7acjQ+IzbzbBJojaluJbpEyuMFqUe2jnRXspcW6hEnmywlOXaaC9
 LwLY+vtYEygwKCKkl4QFgX+qD2uHV+sw4lQAlC+z9bSDzaAIEl91eRsRj6mBAhiaUEUP
 91febHv8/Guyz2EYnw8ODuZaxF1hmvgbHESLcfDnlHu0Y2nd0sQBOmYzkaXHzGq9x/vH
 Xp8ASO9SyLkz4kNovq5tIZMoNnTEPILjPGtfPr1O0qfBfkfcw+/z3wDXZqvGqOxPDOtN
 Hrpw==
X-Gm-Message-State: AOJu0YxKDxCVxxM+k4ZZmqat6yjiY+HhTntzDDs1WxaXEEfH/2B1x1Q7
 cchp/giPRast8KaP45QZ0MrXLU2ajvJIjLbIGEew2/qEYckUwXiCR9k=
X-Google-Smtp-Source: AGHT+IGWh+hh0IImdGBTopY3P1GunAl/I6J5XJ70q5m1TSaxkKE1lWft1PY2IgJCMMwaAlZbgLMcUdkphF3BGnmSg5o=
X-Received: by 2002:a17:907:7703:b0:9b9:f46f:8921 with SMTP id
 kw3-20020a170907770300b009b9f46f8921mr15066779ejc.11.1697124553319; Thu, 12
 Oct 2023 08:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-26-seanga2@gmail.com>
 <CAPnjgZ3YcC+AO2TU2syYOYCzKHpRDY90Gpi_RmTLYW00WiN5aw@mail.gmail.com>
 <a2e0be4f-5305-a471-a0c7-5b31c6dc97a9@gmail.com>
In-Reply-To: <a2e0be4f-5305-a471-a0c7-5b31c6dc97a9@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 12 Oct 2023 08:28:55 -0700
Message-ID: <CAPnjgZ3kpC2M7GAsBADE4O83bbdhb6NvrE1NyEpMmuDvBDFNHg@mail.gmail.com>
Subject: Re: [PATCH 25/26] test: spl: Add a test for the NOR load method
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>
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

On Wed, 11 Oct 2023 at 21:16, Sean Anderson <seanga2@gmail.com> wrote:
>
> On 10/11/23 23:41, Simon Glass wrote:
> > Hi Sean,
> >
> > On Wed, 11 Oct 2023 at 18:57, Sean Anderson <seanga2@gmail.com> wrote:
> >>
> >> Add a test for the NOR load method. Since NOR is memory-mapped we can
> >> substitute a buffer instead. The only major complication is testing LZMA
> >> decompression.  It's too complex to implement LZMA compression in a test,
> >> so we just include some pre-compressed data.
> >
> > How about using the in-tree compression code?
>
> We have that for LZMA? From what I could tell we only have decompression
> in-tree.

Ah yes, OK.

>
> >>
> >> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> >> ---
> >>
> >>   arch/sandbox/include/asm/spl.h   |   1 +
> >>   configs/sandbox_noinst_defconfig |   2 +
> >>   configs/sandbox_spl_defconfig    |   2 +
> >>   include/configs/sandbox.h        |   3 +
> >>   include/test/spl.h               |   5 +
> >>   test/image/Makefile              |   1 +
> >>   test/image/spl_load.c            | 269 ++++++++++++++++++++++++++++++-
> >>   test/image/spl_load_nor.c        |  39 +++++
> >>   8 files changed, 316 insertions(+), 6 deletions(-)
> >>   create mode 100644 test/image/spl_load_nor.c
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> >>
> >> diff --git a/arch/sandbox/include/asm/spl.h b/arch/sandbox/include/asm/spl.h
> >> index ab9475567e0..cf16af5278a 100644
> >> --- a/arch/sandbox/include/asm/spl.h
> >> +++ b/arch/sandbox/include/asm/spl.h
> >> @@ -13,6 +13,7 @@ enum {
> >>          BOOT_DEVICE_BOARD,
> >>          BOOT_DEVICE_VBE,
> >>          BOOT_DEVICE_CPGMAC,
> >> +       BOOT_DEVICE_NOR,
> >>   };
> >>
> >>   /**
> >> diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
> >> index 57cbadedb7d..085cc30c1e2 100644
> >> --- a/configs/sandbox_noinst_defconfig
> >> +++ b/configs/sandbox_noinst_defconfig
> >> @@ -49,6 +49,7 @@ CONFIG_SPL_FS_EXT4=y
> >>   CONFIG_SPL_I2C=y
> >>   CONFIG_SPL_MMC_WRITE=y
> >>   CONFIG_SPL_NET=y
> >> +CONFIG_SPL_NOR_SUPPORT=y
> >>   CONFIG_SPL_RTC=y
> >>   CONFIG_CMD_CPU=y
> >>   CONFIG_CMD_LICENSE=y
> >> @@ -257,6 +258,7 @@ CONFIG_RSA_VERIFY_WITH_PKEY=y
> >>   CONFIG_TPM=y
> >>   CONFIG_LZ4=y
> >>   CONFIG_ZSTD=y
> >> +CONFIG_SPL_LZMA=y
> >>   CONFIG_ERRNO_STR=y
> >>   CONFIG_EFI_CAPSULE_ON_DISK=y
> >>   CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> >> diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
> >> index b578cc8e443..56072b15ad2 100644
> >> --- a/configs/sandbox_spl_defconfig
> >> +++ b/configs/sandbox_spl_defconfig
> >> @@ -41,6 +41,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x4000000
> >>   CONFIG_SPL_ENV_SUPPORT=y
> >>   CONFIG_SPL_FPGA=y
> >>   CONFIG_SPL_I2C=y
> >> +CONFIG_SPL_NOR_SUPPORT=y
> >>   CONFIG_SPL_RTC=y
> >>   CONFIG_CMD_CPU=y
> >>   CONFIG_CMD_LICENSE=y
> >> @@ -249,6 +250,7 @@ CONFIG_TPM=y
> >>   CONFIG_SPL_CRC8=y
> >>   CONFIG_LZ4=y
> >>   CONFIG_ZSTD=y
> >> +CONFIG_SPL_LZMA=y
> >>   CONFIG_ERRNO_STR=y
> >>   CONFIG_SPL_HEXDUMP=y
> >>   CONFIG_EFI_CAPSULE_ON_DISK=y
> >> diff --git a/include/configs/sandbox.h b/include/configs/sandbox.h
> >> index 4e5653dc886..2372485c84e 100644
> >> --- a/include/configs/sandbox.h
> >> +++ b/include/configs/sandbox.h
> >> @@ -18,4 +18,7 @@
> >>   #define CFG_SYS_BAUDRATE_TABLE {4800, 9600, 19200, 38400, 57600,\
> >>                                          115200}
> >>
> >> +/* Unused but necessary to build */
> >> +#define CFG_SYS_UBOOT_BASE     CONFIG_TEXT_BASE
> >> +
> >>   #endif
> >> diff --git a/include/test/spl.h b/include/test/spl.h
> >> index cfb52c90855..82325702d4a 100644
> >> --- a/include/test/spl.h
> >> +++ b/include/test/spl.h
> >> @@ -27,12 +27,14 @@ void generate_data(char *data, size_t size, const char *test_name);
> >>   /**
> >>    * enum spl_test_image - Image types for testing
> >>    * @LEGACY: "Legacy" uImages
> >> + * @LEGACY_LZMA: "Legacy" uImages, LZMA compressed
> >>    * @IMX8: i.MX8 Container images
> >>    * @FIT_INTERNAL: FITs with internal data
> >>    * @FIT_EXTERNAL: FITs with external data
> >>    */
> >>   enum spl_test_image {
> >>          LEGACY,
> >> +       LEGACY_LZMA,
> >>          IMX8,
> >>          FIT_INTERNAL,
> >>          FIT_EXTERNAL,
> >> @@ -118,6 +120,9 @@ int do_spl_test_load(struct unit_test_state *uts, const char *test_name,
> >>   static inline bool image_supported(enum spl_test_image type)
> >>   {
> >>          switch (type) {
> >> +       case LEGACY_LZMA:
> >> +               if (!IS_ENABLED(CONFIG_SPL_LZMA))
> >> +                       return false;
> >>          case LEGACY:
> >>                  return IS_ENABLED(CONFIG_SPL_LEGACY_IMAGE_FORMAT);
> >>          case IMX8:
> >> diff --git a/test/image/Makefile b/test/image/Makefile
> >> index ddbc39bf959..41b29995993 100644
> >> --- a/test/image/Makefile
> >> +++ b/test/image/Makefile
> >> @@ -5,4 +5,5 @@
> >>   obj-$(CONFIG_SPL_UT_LOAD) += spl_load.o
> >>   obj-$(CONFIG_SPL_UT_LOAD_FS) += spl_load_fs.o
> >>   obj-$(CONFIG_SPL_UT_LOAD_NET) += spl_load_net.o
> >> +obj-$(CONFIG_SPL_NOR_SUPPORT) += spl_load_nor.o
> >>   obj-$(CONFIG_SPL_UT_LOAD_OS) += spl_load_os.o
> >> diff --git a/test/image/spl_load.c b/test/image/spl_load.c
> >> index 06249044f9b..3f69e652630 100644
> >> --- a/test/image/spl_load.c
> >> +++ b/test/image/spl_load.c
> >> @@ -43,6 +43,7 @@ void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
> >>
> >>   /* Local flags for spl_image; start from the "top" to avoid conflicts */
> >>   #define SPL_IMX_CONTAINER      0x80000000
> >> +#define SPL_COMP_LZMA          0x40000000
> >>
> >>   void generate_data(char *data, size_t size, const char *test_name)
> >>   {
> >> @@ -79,7 +80,8 @@ static size_t create_legacy(void *dst, struct spl_image_info *spl_image,
> >>          image_set_os(hdr, spl_image->os);
> >>          image_set_arch(hdr, IH_ARCH_DEFAULT);
> >>          image_set_type(hdr, IH_TYPE_FIRMWARE);
> >> -       image_set_comp(hdr, IH_COMP_NONE);
> >> +       image_set_comp(hdr, spl_image->flags & SPL_COMP_LZMA ? IH_COMP_LZMA :
> >> +                                                              IH_COMP_NONE);
> >>          image_set_name(hdr, spl_image->name);
> >>          image_set_hcrc(hdr, crc32(0, (void *)hdr, sizeof(*hdr)));
> >>
> >> @@ -252,6 +254,8 @@ size_t create_image(void *dst, enum spl_test_image type,
> >>          info->flags = 0;
> >>
> >>          switch (type) {
> >> +       case LEGACY_LZMA:
> >> +               info->flags = SPL_COMP_LZMA;
> >>          case LEGACY:
> >>                  return create_legacy(dst, info, data_offset);
> >>          case IMX8:
> >> @@ -296,7 +300,7 @@ int check_image_info(struct unit_test_state *uts, struct spl_image_info *info1,
> >>                  ut_asserteq(info1->load_addr, info2->load_addr);
> >>                  if (info1->flags & SPL_IMX_CONTAINER)
> >>                          ut_asserteq(0, info2->size);
> >> -               else
> >> +               else if (!(info1->flags & SPL_COMP_LZMA))
> >>                          ut_asserteq(info1->size, info2->size);
> >>          } else {
> >>                  ut_asserteq(info1->load_addr - sizeof(struct legacy_img_hdr),
> >> @@ -369,6 +373,246 @@ SPL_IMG_TEST(spl_test_image, IMX8, 0);
> >>   SPL_IMG_TEST(spl_test_image, FIT_INTERNAL, 0);
> >>   SPL_IMG_TEST(spl_test_image, FIT_EXTERNAL, 0);
> >>
> >> +/*
> >> + * LZMA is too complex to generate on the fly, so let's use some data I put in
> >> + * the oven^H^H^H^H compressed earlier
> >
> > How would one create this data?
>
> Same as test/compression.c. I modified this test to hexdump the output of
> generate_data(plain, plain_size, "lzma") and then piped it to lzma. I massaged the
> output somewhat in vim (mostly to adjust the number of columns). You could probably
> script this, but it was a one-off thing.

OK thanks.



>
> --Sean
>
> >> + */
> >> +static const char lzma_compressed[] = {
> >> +       0x5d, 0x00, 0x00, 0x80, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> >> +       0xff, 0x00, 0x02, 0x05, 0x55, 0x4e, 0x82, 0xbc, 0xc2, 0x42, 0xf6, 0x88,
> >> +       0x6c, 0x99, 0xd6, 0x82, 0x48, 0xa6, 0x06, 0x67, 0xf8, 0x46, 0x7c, 0xe9,
> >> +       0x41, 0x79, 0xfe, 0x90, 0x0b, 0x31, 0x7b, 0x79, 0x91, 0xb8, 0x5f, 0x33,
> >> +       0x11, 0x04, 0xc3, 0x4f, 0xf5, 0x71, 0xd1, 0xfb, 0x94, 0x6b, 0x5f, 0x78,
> >> +       0xe2, 0xfa, 0x6a, 0x21, 0xb6, 0x1d, 0x11, 0x0e, 0x5b, 0x56, 0x6a, 0x5b,
> >> +       0xe9, 0x56, 0x5f, 0x8b, 0x87, 0x61, 0x96, 0x6d, 0xce, 0x66, 0xbb, 0xb6,
> >
> > [..]
Regards,
Simon

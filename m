Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2D5C41513
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 04:17:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54DBB86CE8;
	Thu, 12 Oct 2023 06:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fxQon1ih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26EE686E4B; Thu, 12 Oct 2023 06:16:32 +0200 (CEST)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E25886B0A
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 06:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-495d687b138so195879e0c.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 21:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697084187; x=1697688987; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pNaWSSGpxBaBXJWWR32lmuxAfLKJZc3jiZottTuyT/M=;
 b=fxQon1ihTq4MNWSSgCB/enUwLsH74tzZXxe5TPcWakVqO3jtFiuHAUYfP+1blZdfrs
 WCIpoWs+1cCghiUKmVrbBA+rmxTxxkuYwcBtRTAU1VdigdpkC0WLGqTS9S7W7giL32+L
 zKoh8uLNh0UQLGFD11Bg5OOzKREkl7V1Y2n9vkJbxSe5AwxgSlLUNFguvIJlJMkYOAJ4
 +vzGxYrqLtdJNcaP3Zalr62qwHyq+kEPIsvGJWtwRtB4uQQetC+BSPoAamuy13sfQoNY
 JkMStB86S7MuDGT40y5W32/W6/4juzVwZ3h8hhYKgWWyAcvsdx3QoaFGBtTW1V1y9r3K
 ze4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697084187; x=1697688987;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pNaWSSGpxBaBXJWWR32lmuxAfLKJZc3jiZottTuyT/M=;
 b=Z+ydcbLVMzS07Az9+LIeC19+wfJ5oEZh879GW3Ac7AC1ehsfxOcySuWOTqHLUuwTI2
 NFWrqPGhqhQAQoScN5tjr8FG/4t8lKxtPPcuZPFpX6uB9oF6dkK0y4oQtiDi9B8W9uPy
 Xc8iUBYeiG+ytrVUWv5NVaKkNWwTQLnZgGA8WKYnrK/IYeeOk53K2Dy0VPZrzhNxqgBY
 dVU/iEZpBj/r/KpkkHGHZX6VLGrdxjgCqJ9CHFG5gOnh9e3vNBWzF3+rZt4EMtMO+Z15
 fhsMeBUsKPpvzM85DaqSB7/afhbCUAjC+78s3pdStpMadBQ2LWL0eQENMbZPvfUlxPJq
 mhmQ==
X-Gm-Message-State: AOJu0Yx/grP1f9miYAq7jICXmraQNnKW31wBMzxcuaAvRExhB0hYk4s6
 HNI1LNzr33HwqSTRCVURLtA=
X-Google-Smtp-Source: AGHT+IGDGB4ckXD7vTq2g0Ps0z8g1/iJzK4N3PzJAhSJQJ7bdy8dv9yY8cKEIRlePCRHkgrunK/B2A==
X-Received: by 2002:a1f:df43:0:b0:48f:f026:27de with SMTP id
 w64-20020a1fdf43000000b0048ff02627demr14265579vkg.15.1697084186882; 
 Wed, 11 Oct 2023 21:16:26 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 a14-20020a0cca8e000000b00655e4f57732sm6216910qvk.35.2023.10.11.21.16.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 21:16:26 -0700 (PDT)
Message-ID: <a2e0be4f-5305-a471-a0c7-5b31c6dc97a9@gmail.com>
Date: Thu, 12 Oct 2023 00:16:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 25/26] test: spl: Add a test for the NOR load method
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-26-seanga2@gmail.com>
 <CAPnjgZ3YcC+AO2TU2syYOYCzKHpRDY90Gpi_RmTLYW00WiN5aw@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPnjgZ3YcC+AO2TU2syYOYCzKHpRDY90Gpi_RmTLYW00WiN5aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/11/23 23:41, Simon Glass wrote:
> Hi Sean,
> 
> On Wed, 11 Oct 2023 at 18:57, Sean Anderson <seanga2@gmail.com> wrote:
>>
>> Add a test for the NOR load method. Since NOR is memory-mapped we can
>> substitute a buffer instead. The only major complication is testing LZMA
>> decompression.  It's too complex to implement LZMA compression in a test,
>> so we just include some pre-compressed data.
> 
> How about using the in-tree compression code?

We have that for LZMA? From what I could tell we only have decompression
in-tree.

>>
>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
>> ---
>>
>>   arch/sandbox/include/asm/spl.h   |   1 +
>>   configs/sandbox_noinst_defconfig |   2 +
>>   configs/sandbox_spl_defconfig    |   2 +
>>   include/configs/sandbox.h        |   3 +
>>   include/test/spl.h               |   5 +
>>   test/image/Makefile              |   1 +
>>   test/image/spl_load.c            | 269 ++++++++++++++++++++++++++++++-
>>   test/image/spl_load_nor.c        |  39 +++++
>>   8 files changed, 316 insertions(+), 6 deletions(-)
>>   create mode 100644 test/image/spl_load_nor.c
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
>>
>> diff --git a/arch/sandbox/include/asm/spl.h b/arch/sandbox/include/asm/spl.h
>> index ab9475567e0..cf16af5278a 100644
>> --- a/arch/sandbox/include/asm/spl.h
>> +++ b/arch/sandbox/include/asm/spl.h
>> @@ -13,6 +13,7 @@ enum {
>>          BOOT_DEVICE_BOARD,
>>          BOOT_DEVICE_VBE,
>>          BOOT_DEVICE_CPGMAC,
>> +       BOOT_DEVICE_NOR,
>>   };
>>
>>   /**
>> diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
>> index 57cbadedb7d..085cc30c1e2 100644
>> --- a/configs/sandbox_noinst_defconfig
>> +++ b/configs/sandbox_noinst_defconfig
>> @@ -49,6 +49,7 @@ CONFIG_SPL_FS_EXT4=y
>>   CONFIG_SPL_I2C=y
>>   CONFIG_SPL_MMC_WRITE=y
>>   CONFIG_SPL_NET=y
>> +CONFIG_SPL_NOR_SUPPORT=y
>>   CONFIG_SPL_RTC=y
>>   CONFIG_CMD_CPU=y
>>   CONFIG_CMD_LICENSE=y
>> @@ -257,6 +258,7 @@ CONFIG_RSA_VERIFY_WITH_PKEY=y
>>   CONFIG_TPM=y
>>   CONFIG_LZ4=y
>>   CONFIG_ZSTD=y
>> +CONFIG_SPL_LZMA=y
>>   CONFIG_ERRNO_STR=y
>>   CONFIG_EFI_CAPSULE_ON_DISK=y
>>   CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
>> diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
>> index b578cc8e443..56072b15ad2 100644
>> --- a/configs/sandbox_spl_defconfig
>> +++ b/configs/sandbox_spl_defconfig
>> @@ -41,6 +41,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x4000000
>>   CONFIG_SPL_ENV_SUPPORT=y
>>   CONFIG_SPL_FPGA=y
>>   CONFIG_SPL_I2C=y
>> +CONFIG_SPL_NOR_SUPPORT=y
>>   CONFIG_SPL_RTC=y
>>   CONFIG_CMD_CPU=y
>>   CONFIG_CMD_LICENSE=y
>> @@ -249,6 +250,7 @@ CONFIG_TPM=y
>>   CONFIG_SPL_CRC8=y
>>   CONFIG_LZ4=y
>>   CONFIG_ZSTD=y
>> +CONFIG_SPL_LZMA=y
>>   CONFIG_ERRNO_STR=y
>>   CONFIG_SPL_HEXDUMP=y
>>   CONFIG_EFI_CAPSULE_ON_DISK=y
>> diff --git a/include/configs/sandbox.h b/include/configs/sandbox.h
>> index 4e5653dc886..2372485c84e 100644
>> --- a/include/configs/sandbox.h
>> +++ b/include/configs/sandbox.h
>> @@ -18,4 +18,7 @@
>>   #define CFG_SYS_BAUDRATE_TABLE {4800, 9600, 19200, 38400, 57600,\
>>                                          115200}
>>
>> +/* Unused but necessary to build */
>> +#define CFG_SYS_UBOOT_BASE     CONFIG_TEXT_BASE
>> +
>>   #endif
>> diff --git a/include/test/spl.h b/include/test/spl.h
>> index cfb52c90855..82325702d4a 100644
>> --- a/include/test/spl.h
>> +++ b/include/test/spl.h
>> @@ -27,12 +27,14 @@ void generate_data(char *data, size_t size, const char *test_name);
>>   /**
>>    * enum spl_test_image - Image types for testing
>>    * @LEGACY: "Legacy" uImages
>> + * @LEGACY_LZMA: "Legacy" uImages, LZMA compressed
>>    * @IMX8: i.MX8 Container images
>>    * @FIT_INTERNAL: FITs with internal data
>>    * @FIT_EXTERNAL: FITs with external data
>>    */
>>   enum spl_test_image {
>>          LEGACY,
>> +       LEGACY_LZMA,
>>          IMX8,
>>          FIT_INTERNAL,
>>          FIT_EXTERNAL,
>> @@ -118,6 +120,9 @@ int do_spl_test_load(struct unit_test_state *uts, const char *test_name,
>>   static inline bool image_supported(enum spl_test_image type)
>>   {
>>          switch (type) {
>> +       case LEGACY_LZMA:
>> +               if (!IS_ENABLED(CONFIG_SPL_LZMA))
>> +                       return false;
>>          case LEGACY:
>>                  return IS_ENABLED(CONFIG_SPL_LEGACY_IMAGE_FORMAT);
>>          case IMX8:
>> diff --git a/test/image/Makefile b/test/image/Makefile
>> index ddbc39bf959..41b29995993 100644
>> --- a/test/image/Makefile
>> +++ b/test/image/Makefile
>> @@ -5,4 +5,5 @@
>>   obj-$(CONFIG_SPL_UT_LOAD) += spl_load.o
>>   obj-$(CONFIG_SPL_UT_LOAD_FS) += spl_load_fs.o
>>   obj-$(CONFIG_SPL_UT_LOAD_NET) += spl_load_net.o
>> +obj-$(CONFIG_SPL_NOR_SUPPORT) += spl_load_nor.o
>>   obj-$(CONFIG_SPL_UT_LOAD_OS) += spl_load_os.o
>> diff --git a/test/image/spl_load.c b/test/image/spl_load.c
>> index 06249044f9b..3f69e652630 100644
>> --- a/test/image/spl_load.c
>> +++ b/test/image/spl_load.c
>> @@ -43,6 +43,7 @@ void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
>>
>>   /* Local flags for spl_image; start from the "top" to avoid conflicts */
>>   #define SPL_IMX_CONTAINER      0x80000000
>> +#define SPL_COMP_LZMA          0x40000000
>>
>>   void generate_data(char *data, size_t size, const char *test_name)
>>   {
>> @@ -79,7 +80,8 @@ static size_t create_legacy(void *dst, struct spl_image_info *spl_image,
>>          image_set_os(hdr, spl_image->os);
>>          image_set_arch(hdr, IH_ARCH_DEFAULT);
>>          image_set_type(hdr, IH_TYPE_FIRMWARE);
>> -       image_set_comp(hdr, IH_COMP_NONE);
>> +       image_set_comp(hdr, spl_image->flags & SPL_COMP_LZMA ? IH_COMP_LZMA :
>> +                                                              IH_COMP_NONE);
>>          image_set_name(hdr, spl_image->name);
>>          image_set_hcrc(hdr, crc32(0, (void *)hdr, sizeof(*hdr)));
>>
>> @@ -252,6 +254,8 @@ size_t create_image(void *dst, enum spl_test_image type,
>>          info->flags = 0;
>>
>>          switch (type) {
>> +       case LEGACY_LZMA:
>> +               info->flags = SPL_COMP_LZMA;
>>          case LEGACY:
>>                  return create_legacy(dst, info, data_offset);
>>          case IMX8:
>> @@ -296,7 +300,7 @@ int check_image_info(struct unit_test_state *uts, struct spl_image_info *info1,
>>                  ut_asserteq(info1->load_addr, info2->load_addr);
>>                  if (info1->flags & SPL_IMX_CONTAINER)
>>                          ut_asserteq(0, info2->size);
>> -               else
>> +               else if (!(info1->flags & SPL_COMP_LZMA))
>>                          ut_asserteq(info1->size, info2->size);
>>          } else {
>>                  ut_asserteq(info1->load_addr - sizeof(struct legacy_img_hdr),
>> @@ -369,6 +373,246 @@ SPL_IMG_TEST(spl_test_image, IMX8, 0);
>>   SPL_IMG_TEST(spl_test_image, FIT_INTERNAL, 0);
>>   SPL_IMG_TEST(spl_test_image, FIT_EXTERNAL, 0);
>>
>> +/*
>> + * LZMA is too complex to generate on the fly, so let's use some data I put in
>> + * the oven^H^H^H^H compressed earlier
> 
> How would one create this data?

Same as test/compression.c. I modified this test to hexdump the output of
generate_data(plain, plain_size, "lzma") and then piped it to lzma. I massaged the
output somewhat in vim (mostly to adjust the number of columns). You could probably
script this, but it was a one-off thing.

--Sean

>> + */
>> +static const char lzma_compressed[] = {
>> +       0x5d, 0x00, 0x00, 0x80, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +       0xff, 0x00, 0x02, 0x05, 0x55, 0x4e, 0x82, 0xbc, 0xc2, 0x42, 0xf6, 0x88,
>> +       0x6c, 0x99, 0xd6, 0x82, 0x48, 0xa6, 0x06, 0x67, 0xf8, 0x46, 0x7c, 0xe9,
>> +       0x41, 0x79, 0xfe, 0x90, 0x0b, 0x31, 0x7b, 0x79, 0x91, 0xb8, 0x5f, 0x33,
>> +       0x11, 0x04, 0xc3, 0x4f, 0xf5, 0x71, 0xd1, 0xfb, 0x94, 0x6b, 0x5f, 0x78,
>> +       0xe2, 0xfa, 0x6a, 0x21, 0xb6, 0x1d, 0x11, 0x0e, 0x5b, 0x56, 0x6a, 0x5b,
>> +       0xe9, 0x56, 0x5f, 0x8b, 0x87, 0x61, 0x96, 0x6d, 0xce, 0x66, 0xbb, 0xb6,
> 
> [..]
> 
> Regards,
> Simon


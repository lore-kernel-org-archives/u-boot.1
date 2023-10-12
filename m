Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560D7CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 04:14:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E0086E0F;
	Thu, 12 Oct 2023 06:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eWAI8cil";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7AF886DED; Thu, 12 Oct 2023 06:13:38 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BBEB86E2D
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 06:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7741b18a06aso36166585a.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 21:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083974; x=1697688774; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VYCmfoRTIWRvUSbqDfTw0ksfSggoOUJvHAk0BobC+bA=;
 b=eWAI8cils1HsAGI/2xun1Pr1b6TmZHMU93j89vByKMZVeqz9Bkbn0/mtowmqP1xvc8
 8j4Nt1se3VU8DA3U5O/0Ug0TOmHuIWTWc8FGphnzsMcmnBi7u+/9oFWBZ9ILv4lPJe9C
 tXyV2pM84ses3KvgVGWlRDaDysWkPfQ8rUvaqqs3U5ZxRKEn/ADuopLhOPt3+akG6KzS
 RrV6+0BybQdvshwV7HHETj17Bbj3BJhALyWEYkATABLwZaa6OM8prQ7u6Sj2381uk4AS
 svrsbyKjNmh9c0U323neisWpxxHbnn2beMJ6R0i8phDtt5dy2v26Lm90oYQ+M/+88Xva
 g6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083974; x=1697688774;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VYCmfoRTIWRvUSbqDfTw0ksfSggoOUJvHAk0BobC+bA=;
 b=fZG2FVU9waDOpzCErEJZsFEBPX9OVqR4fiX1X4qpv/4TxZXTiTGPHylJD/jI/GZLO3
 X36ucOZcrS6ddp3KSoozG4k0hPCNa9LoRCyU+nQivbBSyYOnyiiHNT88WEIfPjWh6mN5
 r98AUHEL0BTXolmZ+sajBWudipYdd/TF7utyfuFPsga3/n/3wIRJnbFJ8HhbFw5rO/9t
 yO8sGTswpQn8+mWshEpIF1Wam0ghimHc9YjzMo6L5/p5e+isuUYyn2JEoMaMTBRfbTpM
 ToJTnU4JL/SUk24w9vCVrFypFVvtUyS/ckc1zudvlt4b/a1AXIsyuxkNkKH9iWpSwBI4
 27gw==
X-Gm-Message-State: AOJu0YwtiMeuMD0I1FSt+MTp9OiiQJdPUdUczUO3pQ7F9vy3QdUqCvoU
 QAGY0SM1TLGETe6l9lSMjwI=
X-Google-Smtp-Source: AGHT+IHgafBE/eN5eyzojBrflpfS7UlbDJ7/iuxWPs9TYhAdOj96UkwOesQUo8KFy7zbBeE1jRNOLw==
X-Received: by 2002:a05:620a:63c9:b0:776:f5bb:f2e1 with SMTP id
 pw9-20020a05620a63c900b00776f5bbf2e1mr16193988qkn.26.1697083974139; 
 Wed, 11 Oct 2023 21:12:54 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 s27-20020a05620a031b00b00767d572d651sm5722296qkm.87.2023.10.11.21.12.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 21:12:53 -0700 (PDT)
Message-ID: <e39ec382-b685-c7ee-1f0c-417409ae37e6@gmail.com>
Date: Thu, 12 Oct 2023 00:12:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 23/26] test: spl: Add a test for the MMC load method
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-24-seanga2@gmail.com>
 <CAPnjgZ04oO7dk0eHn0Dmqj5s7CXTLYMmhBPQjoop6s6pwsrubQ@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPnjgZ04oO7dk0eHn0Dmqj5s7CXTLYMmhBPQjoop6s6pwsrubQ@mail.gmail.com>
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
> On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>>
>> Add a test for the MMC load method. This shows the general shape of tests
>> to come: The main test function calls do_spl_test_load with an appropriate
>> callback to write the image to the medium.
>>
>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
>> ---
>>
>>   configs/sandbox_noinst_defconfig |  2 +
>>   include/spl.h                    |  4 ++
>>   include/test/spl.h               | 30 +++++++++++++++
>>   test/image/Kconfig               |  1 +
>>   test/image/spl_load.c            | 36 +++++++++++++++++
>>   test/image/spl_load_fs.c         | 66 +++++++++++++++++++++++++++++---
>>   6 files changed, 134 insertions(+), 5 deletions(-)
>>
>> diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
>> index 11be2dccf7d..4f16d9860d2 100644
>> --- a/configs/sandbox_noinst_defconfig
>> +++ b/configs/sandbox_noinst_defconfig
>> @@ -41,6 +41,8 @@ CONFIG_SPL_SYS_MALLOC=y
>>   CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
>>   CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xa000000
>>   CONFIG_SPL_SYS_MALLOC_SIZE=0x4000000
>> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
>> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x0
>>   CONFIG_SPL_ENV_SUPPORT=y
>>   CONFIG_SPL_FS_EXT4=y
>>   CONFIG_SPL_I2C=y
>> diff --git a/include/spl.h b/include/spl.h
>> index 7d30fb57dac..8229d40adab 100644
>> --- a/include/spl.h
>> +++ b/include/spl.h
>> @@ -673,6 +673,10 @@ static inline const char *spl_loader_name(const struct spl_image_loader *loader)
>>          }
>>   #endif
>>
>> +#define SPL_LOAD_IMAGE_GET(_priority, _boot_device, _method) \
>> +       ll_entry_get(struct spl_image_loader, \
>> +                    _boot_device ## _priority ## _method, spl_image_loader)
>> +
>>   /* SPL FAT image functions */
>>   int spl_load_image_fat(struct spl_image_info *spl_image,
>>                         struct spl_boot_device *bootdev,
>> diff --git a/include/test/spl.h b/include/test/spl.h
>> index 7ae32a1020b..cfb52c90855 100644
>> --- a/include/test/spl.h
>> +++ b/include/test/spl.h
>> @@ -79,6 +79,36 @@ size_t create_image(void *dst, enum spl_test_image type,
>>   int check_image_info(struct unit_test_state *uts, struct spl_image_info *info1,
>>                       struct spl_image_info *info2);
>>
>> +/**
>> + * typedef write_image_t - Callback for writing an image
>> + * @uts: Current unit test state
>> + * @img: Image to write
>> + * @size: Size of @img
>> + *
>> + * Write @img to a location which will be read by a &struct spl_image_loader.
>> + *
>> + * Return: 0 on success or -1 on failure
>> + */
>> +typedef int write_image_t(struct unit_test_state *its, void *img, size_t size);
>> +
>> +/**
>> + * do_spl_test_load() - Test loading with an SPL image loader
>> + * @uts: Current unit test state
>> + * @test_name: Name of the current test
>> + * @type: Type of image to try loading
>> + * @loader: The loader to test
>> + * @write_image: Callback to write the image to the backing storage
>> + *
>> + * Test @loader, performing the common tasks of setting up the image and
>> + * checking it was loaded correctly. The caller must supply a @write_image
>> + * callback to write the image to a location which will be read by @loader.
>> + *
>> + * Return: 0 on success or -1 on failure
> 
> Do you mean 1 ?
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

Huh... I guess I do.

--Sean

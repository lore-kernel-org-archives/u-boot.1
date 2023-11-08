Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AF3C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 15:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA0318749B;
	Wed,  8 Nov 2023 16:37:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bj3bwrjj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7C0D870F5; Wed,  8 Nov 2023 16:37:22 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71CF68749D
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 16:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-41cd52c51abso44226251cf.2
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 07:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699457838; x=1700062638; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9VcA+Z9vK0cnQOK9y+hpzTFcOj5Vk/KAvb8J46DplPk=;
 b=bj3bwrjjv9Ib6gUP7J81QgQURvJInN+r7JeeN+WFCodkR2pS7RfRPZmHhE7/gqf8gK
 VKjMB/pZbuN4zwnOPY3/rXySntYQi1T7lNj/g2EgsecJiBF6FJ09+nJDriwS9AfPenbI
 wADibd7SxmyXv5VD2SU8fWuD9zItGzraUUdWCwcguVYuDCVQgd5wPbrCGo7VYQFluq+N
 wKQfpj+kvRrWU2WilxYxi6kWpkydfcUUlrNNyejMUX/NVZB/iyOv32SjQufMC5Y2OGRx
 weuraARVEANedZlZQrPy1OjNiUczORqMpuN0sswYmAQ8hzfWlhfU4erNlWFP/nqETN7m
 tRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699457838; x=1700062638;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9VcA+Z9vK0cnQOK9y+hpzTFcOj5Vk/KAvb8J46DplPk=;
 b=HnRfB1Gq0aUirA8SIQHKZ1DMgGHRvpRb8T2GWkxgXhphIcJulS7M3ogoWn2hHMiXCz
 LxGTQcWVya492XY/YhZHSS2HieFci3bXJ31hwkFeVGhDJ+1Py5IfKjsDxIxcceOnzkeP
 C5CplTstX1+oZTrS/wOaGGLob6Dimjhl40B+ugy+Yswp41eALn8s2T59LzaJew9SJYCk
 aokG3zFla4xw6fPUJ+VLqy1Z8ODcqly3NfjA+j9sI7Ey2VuQsJbQi9hbow4e7ZUs8lUc
 /633tWKlKINxx5XD3IYvOA4BAR8TU3UhRBg9KMyqXEjJ9ITlXjJ6pezV+8RGmqhQjZrD
 EC3w==
X-Gm-Message-State: AOJu0Yy2OYHqY8K2+dkIyvGvF5dgtEBfiLZRLQ/PBbzkhnqrL7J9nyRy
 WVqo3OdespUjjV7JlDGGDQk=
X-Google-Smtp-Source: AGHT+IH3zkyfiS0gsDVyzvELMeUSbb0mTGcJcgJMFNAftZkkrr17fZoXN5u+N+OwN5gmAc2gnWG+rw==
X-Received: by 2002:a05:622a:1483:b0:418:1fa1:4be3 with SMTP id
 t3-20020a05622a148300b004181fa14be3mr2070142qtx.47.1699457838095; 
 Wed, 08 Nov 2023 07:37:18 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 k16-20020ac84750000000b004033c3948f9sm995845qtp.42.2023.11.08.07.37.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 07:37:17 -0800 (PST)
Message-ID: <e990308b-a96e-372c-820f-23bea77c7610@gmail.com>
Date: Wed, 8 Nov 2023 10:37:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 15/25] spl: Convert ext to use spl_load
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, =?UTF-8?Q?Marek_Beh=c3=ban?=
 <marek.behun@nic.cz>, Marek Vasut <marex@denx.de>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Stefan Roese <sr@denx.de>,
 =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-16-seanga2@gmail.com>
 <CAPnjgZ3z7Y7DgGkgkSb5n1oKTu6SqX1tzngEzBkBV7Xc0w_ovA@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPnjgZ3z7Y7DgGkgkSb5n1oKTu6SqX1tzngEzBkBV7Xc0w_ovA@mail.gmail.com>
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

On 11/7/23 23:24, Simon Glass wrote:
> Hi Sean,
> 
> On Sun, 5 Nov 2023 at 19:26, Sean Anderson <seanga2@gmail.com> wrote:
>>
>> This converts the ext load method to use spl_load. As a consequence, it
>> also adds support for FIT and IMX images.
>>
>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
>> ---
>>
>> Changes in v6:
>> - Explicitly initialize load_info members
>>
>> Changes in v5:
>> - Rework to load header in spl_load
>>
>>   common/spl/spl_ext.c     | 36 ++++++++++++++++++------------------
>>   include/spl_load.h       |  1 +
>>   test/image/spl_load_fs.c |  9 ++++++---
>>   3 files changed, 25 insertions(+), 21 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> but nit below
> 
>>
>> diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
>> index af836ca15b8..d280b69c387 100644
>> --- a/common/spl/spl_ext.c
>> +++ b/common/spl/spl_ext.c
>> @@ -2,25 +2,35 @@
>>
>>   #include <common.h>
>>   #include <env.h>
>> -#include <mapmem.h>
>>   #include <part.h>
>>   #include <spl.h>
>> +#include <spl_load.h>
>>   #include <asm/u-boot.h>
>>   #include <ext4fs.h>
>>   #include <errno.h>
>>   #include <image.h>
>>
>> +static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
>> +                         ulong size, void *buf)
>> +{
>> +       int ret;
>> +       loff_t actlen;
>> +
>> +       ret = ext4fs_read(buf, file_offset, size, &actlen);
>> +       if (ret)
>> +               return ret;
>> +       return actlen;
>> +}
>> +
>>   int spl_load_image_ext(struct spl_image_info *spl_image,
>>                         struct spl_boot_device *bootdev,
>>                         struct blk_desc *block_dev, int partition,
>>                         const char *filename)
>>   {
>>          s32 err;
>> -       struct legacy_img_hdr *header;
>> -       loff_t filelen, actlen;
>> +       loff_t filelen;
>>          struct disk_partition part_info = {};
>> -
>> -       header = spl_get_load_buffer(-sizeof(*header), sizeof(*header));
>> +       struct spl_load_info load;
>>
>>          if (part_get_info(block_dev, partition, &part_info)) {
>>                  printf("spl: no partition table found\n");
>> @@ -42,20 +52,10 @@ int spl_load_image_ext(struct spl_image_info *spl_image,
>>                  puts("spl: ext4fs_open failed\n");
>>                  goto end;
>>          }
>> -       err = ext4fs_read((char *)header, 0, sizeof(struct legacy_img_hdr), &actlen);
>> -       if (err < 0) {
>> -               puts("spl: ext4fs_read failed\n");
>> -               goto end;
>> -       }
>>
>> -       err = spl_parse_image_header(spl_image, bootdev, header);
>> -       if (err < 0) {
>> -               puts("spl: ext: failed to parse image header\n");
>> -               goto end;
>> -       }
>> -
>> -       err = ext4fs_read(map_sysmem(spl_image->load_addr, filelen), 0, filelen,
>> -                         &actlen);
>> +       spl_set_bl_len(&load, 1);
>> +       load.read = spl_fit_read;
>> +       err = spl_load(spl_image, bootdev, &load, filelen, 0);
>>
>>   end:
>>   #ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
>> diff --git a/include/spl_load.h b/include/spl_load.h
>> index 406f8b577b2..65aa6bb4493 100644
>> --- a/include/spl_load.h
>> +++ b/include/spl_load.h
>> @@ -95,6 +95,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
>>    * inline if there is one caller, and extern otherwise.
>>    */
>>   #define SPL_LOAD_USERS \
>> +       IS_ENABLED(CONFIG_SPL_FS_EXT4) + \
>>          0
>>
>>   #if SPL_LOAD_USERS > 1
>> diff --git a/test/image/spl_load_fs.c b/test/image/spl_load_fs.c
>> index 59d0244d44b..01559e98c4f 100644
>> --- a/test/image/spl_load_fs.c
>> +++ b/test/image/spl_load_fs.c
>> @@ -422,20 +422,23 @@ static int spl_test_mmc(struct unit_test_state *uts, const char *test_name,
>>          spl_mmc_clear_cache();
>>          spl_fat_force_reregister();
>>
>> -       if (type == LEGACY &&
>> -           spl_test_mmc_fs(uts, test_name, type, create_ext2, false))
>> +       if (spl_test_mmc_fs(uts, test_name, type, create_ext2, false))
>>                  return CMD_RET_FAILURE;
>>
>> -       if (type != IMX8 &&
>> +       if (type != IMX8 && type != LEGACY_LZMA &&
>>              spl_test_mmc_fs(uts, test_name, type, create_fat, false))
>>                  return CMD_RET_FAILURE;
> 
> This is not a command.
> 
> How about:
> 
> if (type != IMX8 && type != LEGACY_LZMA &&
>     ut_assertok(spl_test_mmc_fs(...

There are already assertions in spl_test_mmc_fs. So if we fail here, we
already have something printed on the console.

--Sean

>>
>> +       if (type == LEGACY_LZMA)
>> +               return 0;
>> +
>>          return do_spl_test_load(uts, test_name, type,
>>                                  SPL_LOAD_IMAGE_GET(0, BOOT_DEVICE_MMC1,
>>                                                     spl_mmc_load_image),
>>                                  spl_test_mmc_write_image);
>>   }
>>   SPL_IMG_TEST(spl_test_mmc, LEGACY, DM_FLAGS);
>> +SPL_IMG_TEST(spl_test_mmc, LEGACY_LZMA, DM_FLAGS);
>>   SPL_IMG_TEST(spl_test_mmc, IMX8, DM_FLAGS);
>>   SPL_IMG_TEST(spl_test_mmc, FIT_EXTERNAL, DM_FLAGS);
>>   SPL_IMG_TEST(spl_test_mmc, FIT_INTERNAL, DM_FLAGS);
>> --
>> 2.37.1
>>
> 
> Regards,
> Simon


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55715C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 15:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC79587197;
	Wed,  8 Nov 2023 16:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="apoNOvtg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FB0C871DF; Wed,  8 Nov 2023 16:50:07 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE06787197
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 16:50:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-41cc44736f2so47566191cf.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 07:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699458599; x=1700063399; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MYuQqFI472mtHp8vWhO59MX/Yua5g1F9EpiulcRzkSM=;
 b=apoNOvtgpPT2U4IBAr0oLZowDiqb3yEPuoj0DdGlxXovWser149mZ0vQ7m/INZ+EPY
 mmoffJRy5gIwWl0C3Rjm3aDGhyFKsvlDBgF6lo7xjxD0NF7l/QOTFniCGPQ9UqVenr1B
 baO4QSsU1dlEHP1rPjpqOYl7wYTrGqwRqUA3GguQpJCfPsswZ1LXo7ROgLCC1whepXHF
 MGC5IR3/m69GPUOrprchkRh14LOToDTItDFTU/xpaoQwoiS3+bArcWdVEn7ryU6Cd97W
 kAnjA4UVN+dUCStew1toagh6c+LhS9We8VFuNCbb3oy6WFOWT4PwwAZkRYdOOKFFaDmf
 yITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699458599; x=1700063399;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MYuQqFI472mtHp8vWhO59MX/Yua5g1F9EpiulcRzkSM=;
 b=H58eQc/LuyoRGgn5BfcN2oiW52ZKhEItGHHFxAUPs4Xu2IeS+FwaX7WZu98vE3BV88
 UnooCxPYvwSF4bjxeiwnt5Qu/dSphn9oruj+zOmLwylpxSVgh/e5zo8y8XAUi/6yh+/y
 4TPZjSwcVN+S8ap11VeEGezdzF408Hz+QFYvWbUR70zr7J+SXfp9qvu8hvnzoc/oucZs
 TaDpuDoygp7WiQgKGawCyJFT5aTOo5ptodl4h7CcfW0DaqB71ZcOL1LpO/nRj1SsO4ko
 glzcAXIiGBSLJ4tt7skaZ8Gm7kf3ME/7DSxAnPA5XvQ3Nsep+7ytcfX1UHYcPec6ZT10
 fitg==
X-Gm-Message-State: AOJu0YzCU2Q/wG9le/TEu1tiOGYqR1aXL+cOuCeptkeWksR3G67rmN1D
 dd7Hzjmw+gyt2tUUNrArZNo=
X-Google-Smtp-Source: AGHT+IEWlEdRP9xmvNfZcXzjAubdAxW4xNwS1UFbXQZ8i6sPcnJ6qn6bWdEcEcqKaS8Dhg7d2ReNQA==
X-Received: by 2002:a05:6214:d88:b0:66d:2090:d22 with SMTP id
 e8-20020a0562140d8800b0066d20900d22mr2238013qve.35.1699458599533; 
 Wed, 08 Nov 2023 07:49:59 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 dw18-20020a0562140a1200b0066d1bae2326sm1197847qvb.57.2023.11.08.07.49.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 07:49:59 -0800 (PST)
Message-ID: <d7cd1df9-8de0-7810-c006-9b6737b8cf78@gmail.com>
Date: Wed, 8 Nov 2023 10:49:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 16/25] spl: Convert fat to spl_load
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, =?UTF-8?Q?Marek_Beh=c3=ban?=
 <marek.behun@nic.cz>, Marek Vasut <marex@denx.de>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Stefan Roese <sr@denx.de>
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-17-seanga2@gmail.com>
 <CAPnjgZ1m7MW+LcpQNJEaUfXLZ8Xq5843+ZdPyrKDtS-q9ztj=g@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPnjgZ1m7MW+LcpQNJEaUfXLZ8Xq5843+ZdPyrKDtS-q9ztj=g@mail.gmail.com>
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
>> This converts the fat loader to use spl_load. Some platforms are very
>> tight on space, so we take care to only include the code we really need.
>>
>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
>> ---
>>
>> (no changes since v5)
>>
>> Changes in v5:
>> - Rework to load header in spl_load
>>
>> Changes in v3:
>> - Fix failing on success
>>
>>   common/spl/spl_fat.c     | 56 +++++++++++++---------------------------
>>   include/spl_load.h       |  1 +
>>   test/image/spl_load_fs.c |  3 +--
>>   3 files changed, 20 insertions(+), 40 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> nits below
> 
>>
>> diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
>> index a0c34eba48f..569f2b32928 100644
>> --- a/common/spl/spl_fat.c
>> +++ b/common/spl/spl_fat.c
>> @@ -11,8 +11,8 @@
>>   #include <common.h>
>>   #include <env.h>
>>   #include <log.h>
>> -#include <mapmem.h>
>>   #include <spl.h>
>> +#include <spl_load.h>
>>   #include <asm/u-boot.h>
>>   #include <fat.h>
>>   #include <errno.h>
>> @@ -66,58 +66,38 @@ int spl_load_image_fat(struct spl_image_info *spl_image,
>>                         const char *filename)
>>   {
>>          int err;
>> -       struct legacy_img_hdr *header;
>> +       loff_t size;
>> +       struct spl_load_info load;
>>
>>          err = spl_register_fat_device(block_dev, partition);
>>          if (err)
>>                  goto end;
>>
>> -       header = spl_get_load_buffer(-sizeof(*header), sizeof(*header));
>> -
>> -       err = file_fat_read(filename, header, sizeof(struct legacy_img_hdr));
>> -       if (err <= 0)
>> -               goto end;
>> -
>> -       if (IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL) &&
>> -           image_get_magic(header) == FDT_MAGIC) {
>> -               err = file_fat_read(filename,
>> -                                   map_sysmem(CONFIG_SYS_LOAD_ADDR, 0), 0);
>> -               if (err <= 0)
>> -                       goto end;
>> -               err = spl_parse_image_header(spl_image, bootdev,
>> -                                            map_sysmem(CONFIG_SYS_LOAD_ADDR,
>> -                                                       err));
>> -               if (err == -EAGAIN)
>> -                       return err;
>> -               if (err == 0)
>> -                       err = 1;
>> -       } else if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
>> -           image_get_magic(header) == FDT_MAGIC) {
>> -               struct spl_load_info load;
>> -
>> -               debug("Found FIT\n");
>> -               load.read = spl_fit_read;
>> -               spl_set_bl_len(&load, ARCH_DMA_MINALIGN);
>> -               load.priv = (void *)filename;
>> -
>> -               return spl_load_simple_fit(spl_image, &load, 0, header);
>> -       } else {
>> -               err = spl_parse_image_header(spl_image, bootdev, header);
>> +       /*
>> +        * Avoid pulling in this function for other image types since we are
>> +        * very short on space on some boards.
>> +        */
>> +       if (IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL)) {
>> +               err = fat_size(filename, &size);
>>                  if (err)
>>                          goto end;
>> -
>> -               err = file_fat_read(filename, map_sysmem(spl_image->load_addr,
>> -                                                        spl_image->size), 0);
>> +       } else {
>> +               size = 0;
>>          }
>>
>> +       load.read = spl_fit_read;
>> +       spl_set_bl_len(&load, ARCH_DMA_MINALIGN);
>> +       load.priv = (void *)filename;
>> +       err = spl_load(spl_image, bootdev, &load, size, 0);
>> +
>>   end:
>>   #ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
>> -       if (err <= 0)
>> +       if (err < 0)
>>                  printf("%s: error reading image %s, err - %d\n",
>>                         __func__, filename, err);
> 
> Do we still need this sort of #ifdef? I thought printf() would melt
> away without SPL_LIBCOMMON_SUPPORT? I haven't looked though. Also it
> isn't related to your patch.

 From what I can tell, printf implementation is orthogonal to LIBCOMMON_SUPPORT.

--Sean

>>   #endif
>>
>> -       return (err <= 0);
>> +       return err;
>>   }
>>
>>   #if CONFIG_IS_ENABLED(OS_BOOT)
>> diff --git a/include/spl_load.h b/include/spl_load.h
>> index 65aa6bb4493..5e0460d956d 100644
>> --- a/include/spl_load.h
>> +++ b/include/spl_load.h
>> @@ -96,6 +96,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
>>    */
>>   #define SPL_LOAD_USERS \
>>          IS_ENABLED(CONFIG_SPL_FS_EXT4) + \
>> +       IS_ENABLED(CONFIG_SPL_FS_FAT) + \
>>          0
>>
>>   #if SPL_LOAD_USERS > 1
>> diff --git a/test/image/spl_load_fs.c b/test/image/spl_load_fs.c
>> index 01559e98c4f..333df2dfb53 100644
>> --- a/test/image/spl_load_fs.c
>> +++ b/test/image/spl_load_fs.c
>> @@ -425,8 +425,7 @@ static int spl_test_mmc(struct unit_test_state *uts, const char *test_name,
>>          if (spl_test_mmc_fs(uts, test_name, type, create_ext2, false))
>>                  return CMD_RET_FAILURE;
>>
>> -       if (type != IMX8 && type != LEGACY_LZMA &&
>> -           spl_test_mmc_fs(uts, test_name, type, create_fat, false))
>> +       if (spl_test_mmc_fs(uts, test_name, type, create_fat, false))
>>                  return CMD_RET_FAILURE;
>>
>>          if (type == LEGACY_LZMA)
>> --
>> 2.37.1
>>
> 
> Regards,
> Simon


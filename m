Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A04C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:19:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FF6387165;
	Wed,  8 Nov 2023 17:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T58GcJ8k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7826B87165; Wed,  8 Nov 2023 17:19:38 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E256C8714A
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-77896da2118so449259085a.1
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699460373; x=1700065173; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=As6/Yp6GR4OiqHwa2QY9gUigmEib6+r4cpgvr6fcCmE=;
 b=T58GcJ8kgcpD7AgN7IaF1Px6ijYRta4cMrmF9cXWZVGqoSDKz3Lkdw/7n2S63QJbXM
 9cdB3GwJuvEYUiHdMjJH0PTeZqogqXL/MpZfsok8j7cS+5x69fEH+ythFl+uzAGdZH8f
 IyiMwCJ2PadbnfK6vYSRFRk/yIsC8BR+GwKBMpZECZ/mCCAQ711zx9vi0/zZ8ZOWekfU
 eVtPzCRq8RSrbHOS03kiRK9IddXC8YcjfSm2DjLdbPb1dYC7qZ155uJC/KRmKc35BUnE
 2K+9d1woTEaxna9usG7rYcP2nVOL3rFcXLxtU6GP72/Edmjf7WpbZ2U6gRuMAJD1tGKh
 F5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699460373; x=1700065173;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=As6/Yp6GR4OiqHwa2QY9gUigmEib6+r4cpgvr6fcCmE=;
 b=teXLq/1VKt5ILWwAcPc34Wic5vnKLmPZl70RSDl8AI8vP4sGK+0t5Oe+cGR2UxkyOi
 xaaxxvgs3NnhrQvPI80eiRjjzoJxe+xFuXErEqp6tbl1R2Y54svDJmyHziQVoOkhdNI5
 Dn7Py6JOF4oxOTUdCbvBny3HW0X/quFY6Wb4uAvod5R4LS4KOIt/GVCqPPJJS44Sx5Ld
 hIvbH39Ou8Qd7VR6kNIL6/kdwRkztK1+jxEvKdr/FayK3uO7ma9f0Pc/j9Y06XcO9jWV
 rAkt44hjU2Tg3asiZHK4Pa1UXsA/SA5y5H/F6yJvfizuK8DpSALA7vvZ9wK4qCcmcLbd
 yKKg==
X-Gm-Message-State: AOJu0YyKIKjKtAkWL9iFFEtDa6SaxBsxKQuf42QesBKnbwPmClNlDjdP
 mSdLGRwNtW9nldYGnc4bQ6g=
X-Google-Smtp-Source: AGHT+IFsNFC1ii1QdnCqL6bti99qiBEWnS8n955kSOvQNGFP0Pvsm8M69UFvHvOBi1oi2veB5+aVaw==
X-Received: by 2002:a05:620a:2915:b0:775:9e64:f5be with SMTP id
 m21-20020a05620a291500b007759e64f5bemr2318842qkp.55.1699460373531; 
 Wed, 08 Nov 2023 08:19:33 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 i5-20020a05620a404500b0076f19b9e96fsm1186525qko.107.2023.11.08.08.19.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:19:32 -0800 (PST)
Message-ID: <ad31d30c-cacd-50d0-6b6b-d30e450c4bb3@gmail.com>
Date: Wed, 8 Nov 2023 11:19:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 06/25] spl: Remove dev from spl_load_info
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, =?UTF-8?Q?Marek_Beh=c3=ban?=
 <marek.behun@nic.cz>, Marek Vasut <marex@denx.de>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Stefan Roese <sr@denx.de>
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-7-seanga2@gmail.com>
 <CAPnjgZ3Zja4vqdy=DKwEv42bkhqP=O8OwWzVCBg=RSYb6hCgBQ@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPnjgZ3Zja4vqdy=DKwEv42bkhqP=O8OwWzVCBg=RSYb6hCgBQ@mail.gmail.com>
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

On 11/7/23 23:23, Simon Glass wrote:
> Hi Sean,
> 
> On Sun, 5 Nov 2023 at 19:26, Sean Anderson <seanga2@gmail.com> wrote:
>>
>> dev and priv server the same purpose, and are never set at the same time.
> 
> serve
> 
>> Remove dev and convert all users to priv. While we're at it, reorder bl_len
>> to be last for better alignment.
> 
> It's a bit unfortunate to drop the device, isn't it? But then, as
> before, this is self-contained so Is suppose it doesn't matter what we
> store.

The original goal was to have something like

struct spl_load load = SPL_LOAD_INFO(my_load_function, my_private_data);

but I had to cut it because it was resulting in too many unnecessary assignments.

--Sean

> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Regards,
> Simon
> 
> 
> 
>>
>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
>> ---
>>
>> Changes in v6:
>> - New
>>
>>   common/spl/spl_mmc.c       | 6 +++---
>>   common/spl/spl_spi.c       | 6 +++---
>>   drivers/usb/gadget/f_sdp.c | 6 +++---
>>   include/spl.h              | 4 +---
>>   4 files changed, 10 insertions(+), 12 deletions(-)
>>
>> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
>> index 6d9137c32e0..3d7551a7dae 100644
>> --- a/common/spl/spl_mmc.c
>> +++ b/common/spl/spl_mmc.c
>> @@ -65,7 +65,7 @@ static int mmc_load_legacy(struct spl_image_info *spl_image,
>>   static ulong h_spl_load_read(struct spl_load_info *load, ulong sector,
>>                               ulong count, void *buf)
>>   {
>> -       struct mmc *mmc = load->dev;
>> +       struct mmc *mmc = load->priv;
>>
>>          return blk_dread(mmc_get_blk_desc(mmc), sector, count, buf);
>>   }
>> @@ -105,7 +105,7 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
>>                  struct spl_load_info load;
>>
>>                  debug("Found FIT\n");
>> -               load.dev = mmc;
>> +               load.priv = mmc;
>>                  load.filename = NULL;
>>                  load.bl_len = mmc->read_bl_len;
>>                  load.read = h_spl_load_read;
>> @@ -114,7 +114,7 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
>>                     valid_container_hdr((void *)header)) {
>>                  struct spl_load_info load;
>>
>> -               load.dev = mmc;
>> +               load.priv = mmc;
>>                  load.filename = NULL;
>>                  load.bl_len = mmc->read_bl_len;
>>                  load.read = h_spl_load_read;
>> diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
>> index d83d70f2f33..af7a28e7c25 100644
>> --- a/common/spl/spl_spi.c
>> +++ b/common/spl/spl_spi.c
>> @@ -59,7 +59,7 @@ static int spi_load_image_os(struct spl_image_info *spl_image,
>>   static ulong spl_spi_fit_read(struct spl_load_info *load, ulong sector,
>>                                ulong count, void *buf)
>>   {
>> -       struct spi_flash *flash = load->dev;
>> +       struct spi_flash *flash = load->priv;
>>          ulong ret;
>>
>>          ret = spi_flash_read(flash, sector, count, buf);
>> @@ -151,7 +151,7 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
>>                          struct spl_load_info load;
>>
>>                          debug("Found FIT\n");
>> -                       load.dev = flash;
>> +                       load.priv = flash;
>>                          load.filename = NULL;
>>                          load.bl_len = 1;
>>                          load.read = spl_spi_fit_read;
>> @@ -162,7 +162,7 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
>>                             valid_container_hdr((void *)header)) {
>>                          struct spl_load_info load;
>>
>> -                       load.dev = flash;
>> +                       load.priv = flash;
>>                          load.filename = NULL;
>>                          load.bl_len = 1;
>>                          load.read = spl_spi_fit_read;
>> diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
>> index ee9384fb37e..1b16b7eb452 100644
>> --- a/drivers/usb/gadget/f_sdp.c
>> +++ b/drivers/usb/gadget/f_sdp.c
>> @@ -744,7 +744,7 @@ static ulong sdp_load_read(struct spl_load_info *load, ulong sector,
>>   {
>>          debug("%s: sector %lx, count %lx, buf %lx\n",
>>                __func__, sector, count, (ulong)buf);
>> -       memcpy(buf, (void *)(load->dev + sector), count);
>> +       memcpy(buf, (void *)(load->priv + sector), count);
>>          return count;
>>   }
>>
>> @@ -844,7 +844,7 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
>>                                  struct spl_load_info load;
>>
>>                                  debug("Found FIT\n");
>> -                               load.dev = header;
>> +                               load.priv = header;
>>                                  load.bl_len = 1;
>>                                  load.read = sdp_load_read;
>>                                  spl_load_simple_fit(spl_image, &load, 0,
>> @@ -857,7 +857,7 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
>>                              valid_container_hdr((void *)header)) {
>>                                  struct spl_load_info load;
>>
>> -                               load.dev = header;
>> +                               load.priv = header;
>>                                  load.bl_len = 1;
>>                                  load.read = sdp_load_read;
>>                                  spl_load_imx_container(spl_image, &load, 0);
>> diff --git a/include/spl.h b/include/spl.h
>> index 8ff20adc28e..951e136b9ea 100644
>> --- a/include/spl.h
>> +++ b/include/spl.h
>> @@ -285,16 +285,13 @@ static inline void *spl_image_fdt_addr(struct spl_image_info *info)
>>   /**
>>    * Information required to load data from a device
>>    *
>> - * @dev: Pointer to the device, e.g. struct mmc *
>>    * @priv: Private data for the device
>>    * @bl_len: Block length for reading in bytes
>>    * @filename: Name of the fit image file.
>>    * @read: Function to call to read from the device
>>    */
>>   struct spl_load_info {
>> -       void *dev;
>>          void *priv;
>> -       int bl_len;
>>          const char *filename;
>>          /**
>>           * read() - Read from device
>> @@ -307,6 +304,7 @@ struct spl_load_info {
>>           */
>>          ulong (*read)(struct spl_load_info *load, ulong sector, ulong count,
>>                        void *buf);
>> +       int bl_len;
>>   };
>>
>>   /*
>> --
>> 2.37.1
>>


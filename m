Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43097C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 16:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5D1D88445;
	Tue, 28 May 2024 18:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XrfmxyUx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B0B8884B4; Tue, 28 May 2024 18:12:18 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57C9C8841F
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 18:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 384B5400FA
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1716912735;
 bh=ywVxGyPAO3HfFgk953HkTAhw6ZDc1EraGUIzNsIkerY=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=XrfmxyUxxHFnM8vtLV/9daAY0zYTW4dZS8p8a+MltNUpJ3oCwTVQqT21mNz0wc420
 BmmhGsk/4q11g3EGc+n/gbtHQU8yJKlXvr7KOHCelBCm4zskVQMogv4KYNPRCpFHiU
 38Pk39ygrD3S7lCerJC6y+mDHSto2cJVDRXmZr68xUuu+dQOPTnmzX2o1ng/T3eFjs
 UdOmIFrNamqm5bAdEpfxTTYfQZ1AKinqf2T1d3yZ9VBDqqkYHPCTZ1NtrDDgJGLPxU
 nkDwVyfG5WH59TfEAlicz7692XW65wEChaK10H0qwevR+MA6q4VGxPMYqsMOeFkuBS
 2c05+1Mbmn0hQ==
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6265d3cb78so68862066b.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 09:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716912735; x=1717517535;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ywVxGyPAO3HfFgk953HkTAhw6ZDc1EraGUIzNsIkerY=;
 b=vl6Iylx9bRsaKTDTxZZsCv/cJbowQJTvSGemFhwdEO9VKIpJhRUMNgys8TL2XPlxd0
 mNHdjxBUej9qbYbq2mB5cmbq53rMpCaopEpCuP32sRH32ZpadpnaPY0q7kwS5jLgA1+E
 Htjoq6k8q5lTv4gpLquP3aobv5Carpysem31aSQeGPG3Tf5tC6xbxOBWJkQ6jaZNRJWs
 K/XQBR9MGznP1RhHmUsJQX0SO4vXhepcfzUcZ7UAdGORgioNY+Btj/bIgMOryNejj6Ml
 QlYriNUAWn5W1gT7gCiF0U0fZG40TcFjlkcphkPlEezRKWKHrldty/4zqxJ2qtfJ5K9d
 k0Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfa2LLV6W2HTSsdLeJbblfsf+noDSI26yP1UpyaWheDBrv1ZYCgF2s6En4TQkhJCA7CuikKkpG2iHMSrzWEBv/1LBmww==
X-Gm-Message-State: AOJu0Yz8w8PAq3rtnGdbS0yheZ8sJNr1PVmc7r9HT8cRfzQtjhBoEBLV
 WlrA+4IWhNmnErDkSTylF5zTrLsTgy7YIN4sH2mJOOZ5t4q6Wd70GvI48P3ZSatbw3kSqOYyehb
 Eq/ls02mXSXv3q2pqSGqE9Ya7elI4I/3OGc6jy+xABh3MID4AVW2FRKYChuo7DpZVfmY=
X-Received: by 2002:a17:906:478c:b0:a59:cdc9:6fdf with SMTP id
 a640c23a62f3a-a62641c4376mr863700766b.4.1716912734744; 
 Tue, 28 May 2024 09:12:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjyuLRoyCcpZAqaruy1RnuW+uuG/M0t8YDDmBLOqH0PiJI1oZftOAxlkO8iSn9hjvkYKlHUQ==
X-Received: by 2002:a17:906:478c:b0:a59:cdc9:6fdf with SMTP id
 a640c23a62f3a-a62641c4376mr863699266b.4.1716912734278; 
 Tue, 28 May 2024 09:12:14 -0700 (PDT)
Received: from ?IPV6:2a00:20:d00b:f75d:fdbe:9c2a:66b:5f2b?
 ([2a00:20:d00b:f75d:fdbe:9c2a:66b:5f2b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cda54c9sm623189066b.202.2024.05.28.09.12.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 09:12:13 -0700 (PDT)
Message-ID: <9bcf8dff-1c67-477c-b425-cbb79f5ecfc3@canonical.com>
Date: Tue, 28 May 2024 18:12:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] efi_loader: allow concatenation with contained end
 node
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, Bin Meng
 <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
 <20240528144252.179247-2-heinrich.schuchardt@canonical.com>
 <CAC_iWjJFiSrPZveDDhX7wW9J-gBiTCUw2jXpw9MG_+K3nsGaEA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjJFiSrPZveDDhX7wW9J-gBiTCUw2jXpw9MG_+K3nsGaEA@mail.gmail.com>
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

On 28.05.24 18:02, Ilias Apalodimas wrote:
> On Tue, 28 May 2024 at 17:43, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Allow appending a device-path to a device-path that contains an end node
>> as separator. We need this feature for creating boot options specifying
>> kernel, initrd, and dtb.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>>          update efi_dp_concat() instead of new function efi_dp_merge()
>> ---
>>   cmd/eficonfig.c                            |  6 +++---
>>   cmd/efidebug.c                             |  4 ++--
>>   include/efi_loader.h                       |  2 +-
>>   lib/efi_loader/efi_bootbin.c               |  2 +-
>>   lib/efi_loader/efi_bootmgr.c               |  2 +-
>>   lib/efi_loader/efi_boottime.c              |  2 +-
>>   lib/efi_loader/efi_device_path.c           | 20 +++++++++++++-------
>>   lib/efi_loader/efi_device_path_utilities.c |  2 +-
>>   8 files changed, 23 insertions(+), 17 deletions(-)
>>
>> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
>> index 0ba92c60e03..b13d9a3d2d9 100644
>> --- a/cmd/eficonfig.c
>> +++ b/cmd/eficonfig.c
>> @@ -531,7 +531,7 @@ struct efi_device_path *eficonfig_create_device_path(struct efi_device_path *dp_
>>          dp = efi_dp_shorten(dp_volume);
>>          if (!dp)
>>                  dp = dp_volume;
>> -       dp = efi_dp_concat(dp, &fp->dp, false);
>> +       dp = efi_dp_concat(dp, &fp->dp, 0);
>>          free(buf);
>>
>>          return dp;
>> @@ -1485,7 +1485,7 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
>>                          goto out;
>>                  }
>>                  initrd_dp = efi_dp_concat((const struct efi_device_path *)&id_dp,
>> -                                         dp, false);
>> +                                         dp, 0);
>>                  efi_free_pool(dp);
>>          }
>>
>> @@ -1496,7 +1496,7 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
>>          }
>>          final_dp_size = efi_dp_size(dp) + sizeof(END);
>>          if (initrd_dp) {
>> -               final_dp = efi_dp_concat(dp, initrd_dp, true);
>> +               final_dp = efi_dp_concat(dp, initrd_dp, 1);
>>                  final_dp_size += efi_dp_size(initrd_dp) + sizeof(END);
>>          } else {
>>                  final_dp = efi_dp_dup(dp);
>> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
>> index c2c525f2351..762027daf8a 100644
>> --- a/cmd/efidebug.c
>> +++ b/cmd/efidebug.c
>> @@ -697,7 +697,7 @@ struct efi_device_path *create_initrd_dp(const char *dev, const char *part,
>>                  short_fp = tmp_fp;
>>
>>          initrd_dp = efi_dp_concat((const struct efi_device_path *)&id_dp,
>> -                                 short_fp, false);
>> +                                 short_fp, 0);
>>
>>   out:
>>          efi_free_pool(tmp_dp);
>> @@ -917,7 +917,7 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
>>                  goto out;
>>          }
>>
>> -       final_fp = efi_dp_concat(file_path, initrd_dp, true);
>> +       final_fp = efi_dp_concat(file_path, initrd_dp, 1);
>>          if (!final_fp) {
>>                  printf("Cannot create final device path\n");
>>                  r = CMD_RET_FAILURE;
>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>> index 9600941aa32..ddf2e41a95c 100644
>> --- a/include/efi_loader.h
>> +++ b/include/efi_loader.h
>> @@ -946,7 +946,7 @@ struct efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
>>                                         const efi_guid_t *guid);
>>   struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
>>                                        const struct efi_device_path *dp2,
>> -                                     bool split_end_node);
>> +                                     size_t split_end_node);
>>   struct efi_device_path *search_gpt_dp_node(struct efi_device_path *device_path);
>>   efi_status_t efi_deserialize_load_option(struct efi_load_option *lo, u8 *data,
>>                                           efi_uintn_t *size);
>> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
>> index b7910f78fb6..a87006b3c0e 100644
>> --- a/lib/efi_loader/efi_bootbin.c
>> +++ b/lib/efi_loader/efi_bootbin.c
>> @@ -150,7 +150,7 @@ efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
>>                  msg_path = file_path;
>>          } else {
>>                  file_path = efi_dp_concat(bootefi_device_path,
>> -                                         bootefi_image_path, false);
>> +                                         bootefi_image_path, 0);
>>                  msg_path = bootefi_image_path;
>>                  log_debug("Loaded from disk\n");
>>          }
>> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
>> index 7da3139f917..b0bf21cf841 100644
>> --- a/lib/efi_loader/efi_bootmgr.c
>> +++ b/lib/efi_loader/efi_bootmgr.c
>> @@ -130,7 +130,7 @@ static efi_status_t try_load_from_file_path(efi_handle_t *fs_handles,
>>                  if (!dp)
>>                          continue;
>>
>> -               dp = efi_dp_concat(dp, fp, false);
>> +               dp = efi_dp_concat(dp, fp, 0);
>>                  if (!dp)
>>                          continue;
>>
>> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
>> index 1951291747c..630c5f52c4f 100644
>> --- a/lib/efi_loader/efi_boottime.c
>> +++ b/lib/efi_loader/efi_boottime.c
>> @@ -1816,7 +1816,7 @@ efi_status_t efi_setup_loaded_image(struct efi_device_path *device_path,
>>          if (device_path) {
>>                  info->device_handle = efi_dp_find_obj(device_path, NULL, NULL);
>>
>> -               dp = efi_dp_concat(device_path, file_path, false);
>> +               dp = efi_dp_concat(device_path, file_path, 0);
>>                  if (!dp) {
>>                          ret = EFI_OUT_OF_RESOURCES;
>>                          goto failure;
>> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
>> index aec224d8466..c8c8d54f733 100644
>> --- a/lib/efi_loader/efi_device_path.c
>> +++ b/lib/efi_loader/efi_device_path.c
>> @@ -276,10 +276,11 @@ struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
>>    *
>>    * @dp1:           First device path
>>    * @dp2:           Second device path
>> - * @split_end_node: If true the two device paths will be concatenated and
>> - *                  separated by an end node (DEVICE_PATH_SUB_TYPE_END).
>> - *                 If false the second device path will be concatenated to the
>> - *                 first one as-is.
>> + * @split_end_node:
>> + * * 0 to concatenate
>> + * * 1 to concatenate with end node added as separator
>> + * * size of dp1 excluding last end node to concatenate with end node as
>> + *   separator in case dp1 contains an end node
>>    *
>>    * Return:
>>    * concatenated device path or NULL. Caller must free the returned value
>> @@ -287,7 +288,7 @@ struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
>>   struct
>>   efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
>>                                 const struct efi_device_path *dp2,
>> -                              bool split_end_node)
>> +                              size_t split_end_node)
>>   {
>>          struct efi_device_path *ret;
>>          size_t end_size;
>> @@ -301,10 +302,15 @@ efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
>>                  ret = efi_dp_dup(dp1);
>>          } else {
>>                  /* both dp1 and dp2 are non-null */
>> -               unsigned sz1 = efi_dp_size(dp1);
>> -               unsigned sz2 = efi_dp_size(dp2);
>> +               size_t sz1;
>> +               size_t sz2 = efi_dp_size(dp2);
>>                  void *p;
>>
>> +               if (split_end_node < sizeof(struct efi_device_path))
> 
> Can we be more explicit here pls? Someone might misuse this in the future
> split_end_node < =1 ? And we can document we can use values up to
> sizeof(struct efi_device_path) if we ever need extra functionality

size_t split_end_node cannot be negative.

The case split_end_node == 0 is handled below. What are you missing?

Best regards

Heinrich

> 
>> +                       sz1 = efi_dp_size(dp1);
>> +               else
>> +                       sz1 = split_end_node;
>> +
>>                  if (split_end_node)
>>                          end_size = 2 * sizeof(END);
>>                  else
>> diff --git a/lib/efi_loader/efi_device_path_utilities.c b/lib/efi_loader/efi_device_path_utilities.c
>> index c95dbfa9b5f..ac250bbfcc9 100644
>> --- a/lib/efi_loader/efi_device_path_utilities.c
>> +++ b/lib/efi_loader/efi_device_path_utilities.c
>> @@ -76,7 +76,7 @@ static struct efi_device_path * EFIAPI append_device_path(
>>          const struct efi_device_path *src2)
>>   {
>>          EFI_ENTRY("%pD, %pD", src1, src2);
>> -       return EFI_EXIT(efi_dp_concat(src1, src2, false));
>> +       return EFI_EXIT(efi_dp_concat(src1, src2, 0));
>>   }
>>
>>   /*
>> --
>> 2.43.0
>>
> 
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


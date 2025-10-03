Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61697CAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 08:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E7DE8366F;
	Fri,  3 Oct 2025 10:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ut/IIPvb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E378583693; Fri,  3 Oct 2025 10:56:24 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED4718349B
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 10:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e4ad36541so21961325e9.0
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 01:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759481781; x=1760086581; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PUV75csm03/J1XSf8GrNfTc2Bv7o05WUtG9FM/gvP1U=;
 b=ut/IIPvbR0Z9c0FL5Eq6wJo7WABrUj+lqEErCWNUtMEAwIILS8udXL5yDkCQNXtnaQ
 qDsOXxsBcWuiCHgjMvxOjovAeCXGmTdkrgjyzph7PlCfZ0BNpxMlMnDz7+mGkEmWhHyc
 l53BHfr/pgbAnWhhCFHbSmGxfBs4ubTsgOiwFrEdXlEKUaCBAK7K2lGFzolaqu8p9xdT
 SELLinsKqqKNu+Av1FH3lpxO3ox50RqccG9Yr0jpDLzxH4zCVYwSM0o96zfO1ClI1x9Z
 U9JSq6FSM7KsF+LFMvcvuQC3CdmFIrRI7dlpwXA0MrU+jNhQvLxVHuAbEV1R3sZF4+H0
 rTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759481781; x=1760086581;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PUV75csm03/J1XSf8GrNfTc2Bv7o05WUtG9FM/gvP1U=;
 b=cmo6kNFCWyxAXQDsScOy1jHGmZ0mba+8zlFSLyTbG7kvDwy0IO6nc553q99++44+GP
 Gk+ZOlgU4+XOqCEqSygimPhLMGiCLkNtl3byIxezmS4+8o7Sn+nBPv685jBUeVcDb3iG
 +DZ2MguAKUrEbenKC+WfmxGPsysVUlIr10KFyJZf5FN2yi5oQ+60hF/4GKu5pMlmTq0m
 b4QLs2mKDuEHNeFN75Qf0jiTLdbaCm97JuO8W/7GVo3jkMbr45IHUdVCAqKTJ0UFOivS
 N6deScXUa6GAmJVQyPuBnNK53fH3JtZI91pbLY61S5A2jzUUkCpZF2+tzwzltOWCQCvy
 v3lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq/NalTntzFcUhEXR0dSU2IjEdxA2j6uSwoHpH0Vq9scs8Tr1l7qhk6Mp4RwZ8QNARyJb+TuQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4WVwWddCdWcEEKG1lF8MaH7Fv7OKgAY/uvlnGDX/pQ2Ug0O4p
 bwMXRqygQY6BSLia5nMEy0AVoqZEAzWnF977X4jVUkTh50dLq+BTR3oIWcf8CuEgfkc=
X-Gm-Gg: ASbGnctPsvLJSgSVTWSzS5uf2+JlgtHL+EblWS4KWXUaYUo+BMnIrBj7Sq8IbZ+TgGp
 hM3TGR2R79tZ9GEF8CynPTLHvh2lsOLPLPZwTcMr7NOmDTpMtAEAUjuD8WsMkHCrkQazSxCoT9H
 w6JSnQHTgLwv5xs/rlfOYh2Ay6EjSYmlq6JfsAkGCyNrJWy/QF45GBgEpJTatsLLJXAVwvK/cbG
 i0bIfPc9NoiUQw+uHzYmQPVKiBVtrrISnNkd+jsp47vZl3xeAGG0ZAN/T8tiMxBothG7/A8di7D
 G5OC5dyWuAwnNhMjgYI+1ASNvhei/1YPbFGd6N7cdNtZFb7ZNWTBBjQBYkLE0iynCcp6aF//dmY
 p9C7CcXozCQkeqgpN4VffzmcKR7NOtU/Iyyo8GIu8c3i74bvUJbbueSbkWYQ/3Bmwal5hwtcB+L
 7i1O4Yj1XIVnfzEAfQZ5LECgCeJHSXkA==
X-Google-Smtp-Source: AGHT+IHsz0ar94DG8Dy5RSUCJUQ5St9zL5CSGHH3LQ9W+2S+FCb6doMmA7d5W8c7BN0+drdtoT0jgg==
X-Received: by 2002:a05:600c:83ce:b0:46e:48f9:a17c with SMTP id
 5b1f17b1804b1-46e7110ee58mr13564365e9.9.1759481780931; 
 Fri, 03 Oct 2025 01:56:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:ebd:e301:a6dd:d590:166e:6c62?
 ([2a0a:ef40:ebd:e301:a6dd:d590:166e:6c62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a16e13sm120566115e9.15.2025.10.03.01.56.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Oct 2025 01:56:20 -0700 (PDT)
Message-ID: <e3236a32-3725-494b-bbe8-ff5535d73c2d@linaro.org>
Date: Fri, 3 Oct 2025 09:56:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs: semihosting: Fixup smh_flen and smh_read against
 overflow
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <sean.anderson@seco.com>,
 u-boot@lists.denx.de
References: <20251002-fs_semihosting-v2-1-c1783e4188d8@linaro.org>
 <d089398e-cf6f-486c-907f-c685a0876e47@gmx.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <d089398e-cf6f-486c-907f-c685a0876e47@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 03/10/2025 06:31, Heinrich Schuchardt wrote:
> On 10/2/25 16:32, Andrew Goodbody wrote:
>> The sys calls SYS_FLEN and SYS_READ were being used in a way that did
>> not allow for file sizes > 2^31. Fixing this required changing the
>> signatures of the functions smh_flen and smh_read to allow file
>> sizes up to 2^32 - 2 and also being able to return errors that could be
>> tested for.
>>
>> This issue was found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> 
> I applied this patch to origin/master and build qemu_arm_defconfig with 
> CONFIG_SEMIHOSTING=y. It seems you missed one occurence of smh_flen.
> 
> fs/semihostingfs.c: In function ‘smh_fs_size’:
> fs/semihostingfs.c:88:16: error: too few arguments to function 
> ‘smh_flen’; expected 2, have 1
>     88 |         size = smh_flen(fd);
>        |                ^~~~~~~~
> In file included from fs/semihostingfs.c:11:
> include/semihosting.h:131:5: note: declared here
>    131 | int smh_flen(long fd, size_t *size);
>        |     ^~~~~~~~
> 
> To fix the issue I applied this diff on top of your patch:
> 
> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
> index 71b6634b066..d2f065782d6 100644
> --- a/fs/semihostingfs.c
> +++ b/fs/semihostingfs.c
> @@ -79,17 +79,19 @@ static int smh_fs_write_at(const char *filename, 
> loff_t pos, void *buffer,
> 
>   int smh_fs_size(const char *filename, loff_t *result)
>   {
> -       long fd, size;
> +       long fd;
> +       size_t size;
> +       int ret;
> 
>          fd = smh_open(filename, MODE_READ | MODE_BINARY);
>          if (fd < 0)
>                  return fd;
> 
> -       size = smh_flen(fd);
> +       ret = smh_flen(fd, &size);
>          smh_close(fd);
> 
> -       if (size < 0)
> -               return size;
> +       if (ret)
> +               return ret;
> 
>          *result = size;
>          return 0;
> 
> With that correction the size command gives me these results for files 
> with size 3 GiB and 5 GiB on 32bit ARM:
> 
> => size hostfs - 3G ; echo $filesize
> c0000000
> => size hostfs - 5G ; echo $filesize
> 40000000
> 
> The incorrect result for 5G needs to be corrected in QEMU. QEMU should 
> return an error for files exceeding 0xfffffffe length on 32 bit systems.
> 
> On 64bit ARM everything is fine:
> 
> => size hostfs - 3 ; echo $filesize
> c0000000
> => size hostfs - 5 ; echo $filesize
> 140000000
> 
> For a missing file the error is correctly reported:
> => size hostfs - 2; echo $?
> 1
> 
> For a file without access writes $? is also set to $1 because opening 
> already fails:
> 
> $ ls r
> -r-------- 1 root root 10 Okt  3 07:25 r
> 
> => size hostfs - r; echo $?
> 1
> 
> Please, resubmit the patch.

Sorry, yes, will do.

Thanks,
Andrew

> Best regards
> 
> Heinrich
> 
>> ---
>> Changes in v2:
>> - Fixup smh_flen and smh_read to allow for > 2^31 byte files
>> - Link to v1: https://lore.kernel.org/r/20251002-fs_semihosting- 
>> v1-1-1124e6becc51@linaro.org
>> ---
>>   common/spl/spl_semihosting.c        | 13 +++++++------
>>   drivers/serial/serial_semihosting.c |  6 ++++--
>>   fs/semihostingfs.c                  | 13 +++++++------
>>   include/semihosting.h               | 13 +++++++------
>>   lib/semihosting.c                   | 25 +++++++++++++++++++------
>>   5 files changed, 44 insertions(+), 26 deletions(-)
>>
>> diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
>> index 
>> f36863fe48d25859ee9af67a67140893b6e9e262..fb578a274d0d937b2ed5bd13e505bcefd4491799 100644
>> --- a/common/spl/spl_semihosting.c
>> +++ b/common/spl/spl_semihosting.c
>> @@ -13,13 +13,14 @@ static ulong smh_fit_read(struct spl_load_info 
>> *load, ulong file_offset,
>>                 ulong size, void *buf)
>>   {
>>       long fd = *(long *)load->priv;
>> -    ulong ret;
>> +    long ret;
>> +    size_t bytes_read;
>>       if (smh_seek(fd, file_offset))
>>           return 0;
>> -    ret = smh_read(fd, buf, size);
>> -    return ret < 0 ? 0 : ret;
>> +    ret = smh_read(fd, buf, size, &bytes_read);
>> +    return ret < 0 ? 0 : bytes_read;
>>   }
>>   static int spl_smh_load_image(struct spl_image_info *spl_image,
>> @@ -27,7 +28,8 @@ static int spl_smh_load_image(struct spl_image_info 
>> *spl_image,
>>   {
>>       const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
>>       int ret;
>> -    long fd, len;
>> +    long fd;
>> +    size_t len;
>>       struct spl_load_info load;
>>       fd = smh_open(filename, MODE_READ | MODE_BINARY);
>> @@ -36,12 +38,11 @@ static int spl_smh_load_image(struct 
>> spl_image_info *spl_image,
>>           return fd;
>>       }
>> -    ret = smh_flen(fd);
>> +    ret = smh_flen(fd, &len);
>>       if (ret < 0) {
>>           log_debug("could not get length of image: %d\n", ret);
>>           goto out;
>>       }
>> -    len = ret;
>>       spl_load_init(&load, smh_fit_read, &fd, 1);
>>       ret = spl_load(spl_image, bootdev, &load, len, 0);
>> diff --git a/drivers/serial/serial_semihosting.c b/drivers/serial/ 
>> serial_semihosting.c
>> index 
>> 56a5ec72428afdd97eccad739a46189380ba3e76..017b1f8eda84f5c25e09be7e970d0ebfdbf2ace0 100644
>> --- a/drivers/serial/serial_semihosting.c
>> +++ b/drivers/serial/serial_semihosting.c
>> @@ -25,11 +25,12 @@ static int smh_serial_getc(struct udevice *dev)
>>   {
>>       char ch = 0;
>>       struct smh_serial_priv *priv = dev_get_priv(dev);
>> +    size_t bytes_read;
>>       if (priv->infd < 0)
>>           return smh_getc();
>> -    smh_read(priv->infd, &ch, sizeof(ch));
>> +    smh_read(priv->infd, &ch, sizeof(ch), &bytes_read);
>>       return ch;
>>   }
>> @@ -140,11 +141,12 @@ static void smh_serial_setbrg(void)
>>   static int smh_serial_getc(void)
>>   {
>>       char ch = 0;
>> +    size_t bytes_read;
>>       if (infd < 0)
>>           return smh_getc();
>> -    smh_read(infd, &ch, sizeof(ch));
>> +    smh_read(infd, &ch, sizeof(ch), &bytes_read);
>>       return ch;
>>   }
>> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
>> index 
>> 77e39ca407e4d240a1fd573497c5b6b908816454..71b6634b0660e32cc63f7fc60ec1af8d3248433a 100644
>> --- a/fs/semihostingfs.c
>> +++ b/fs/semihostingfs.c
>> @@ -23,7 +23,8 @@ int smh_fs_set_blk_dev(struct blk_desc *rbdd, struct 
>> disk_partition *info)
>>   static int smh_fs_read_at(const char *filename, loff_t pos, void 
>> *buffer,
>>                 loff_t maxsize, loff_t *actread)
>>   {
>> -    long fd, size, ret;
>> +    long fd, ret;
>> +    size_t size;
>>       fd = smh_open(filename, MODE_READ | MODE_BINARY);
>>       if (fd < 0)
>> @@ -34,19 +35,19 @@ static int smh_fs_read_at(const char *filename, 
>> loff_t pos, void *buffer,
>>           return ret;
>>       }
>>       if (!maxsize) {
>> -        size = smh_flen(fd);
>> +        ret = smh_flen(fd, &size);
>>           if (ret < 0) {
>>               smh_close(fd);
>> -            return size;
>> +            return ret;
>>           }
>>           maxsize = size;
>>       }
>> -    size = smh_read(fd, buffer, maxsize);
>> +    ret = smh_read(fd, buffer, maxsize, &size);
>>       smh_close(fd);
>> -    if (size < 0)
>> -        return size;
>> +    if (ret < 0)
>> +        return ret;
>>       *actread = size;
>>       return 0;
>> diff --git a/include/semihosting.h b/include/semihosting.h
>> index 
>> 4e844cbad87bb1ae6bb365f87f3e7a8aeea445f4..60535199b9532ce16620aea3ca1ea741c5b73766 100644
>> --- a/include/semihosting.h
>> +++ b/include/semihosting.h
>> @@ -95,12 +95,12 @@ long smh_open(const char *fname, enum 
>> smh_open_mode mode);
>>    * @fd: A file descriptor returned from smh_open()
>>    * @memp: Pointer to a buffer of memory of at least @len bytes
>>    * @len: The number of bytes to read
>> + * @read_len: Pointer which will be updated with actual bytes read on 
>> success,
>> + *  with 0 indicating %EOF
>>    *
>> - * Return:
>> - * * The number of bytes read on success, with 0 indicating %EOF
>> - * * A negative error on failure
>> + * Return: 0 on success or negative error on failure
>>    */
>> -long smh_read(long fd, void *memp, size_t len);
>> +long smh_read(long fd, void *memp, size_t len, size_t *read_len);
>>   /**
>>    * smh_write() - Write data to a file
>> @@ -124,10 +124,11 @@ long smh_close(long fd);
>>   /**
>>    * smh_flen() - Get the length of a file
>>    * @fd: A file descriptor returned from smh_open()
>> + * @size: Pointer which will be updated with length of file on success
>>    *
>> - * Return: The length of the file, in bytes, or a negative error on 
>> failure
>> + * Return: 0 on success or negative error on failure
>>    */
>> -long smh_flen(long fd);
>> +int smh_flen(long fd, size_t *size);
>>   /**
>>    * smh_seek() - Seek to a position in a file
>> diff --git a/lib/semihosting.c b/lib/semihosting.c
>> index 
>> 9be5bffd30124777c4f8110065e6cca5640312ac..a0f42d41e4a7ad95023c684f6824bfc677ad25cd 100644
>> --- a/lib/semihosting.c
>> +++ b/lib/semihosting.c
>> @@ -93,9 +93,9 @@ struct smh_rdwr_s {
>>       size_t len;
>>   };
>> -long smh_read(long fd, void *memp, size_t len)
>> +long smh_read(long fd, void *memp, size_t len, size_t *read_len)
>>   {
>> -    long ret;
>> +    size_t ret;
>>       struct smh_rdwr_s read;
>>       debug("%s: fd %ld, memp %p, len %zu\n", __func__, fd, memp, len);
>> @@ -105,9 +105,20 @@ long smh_read(long fd, void *memp, size_t len)
>>       read.len = len;
>>       ret = smh_trap(SYSREAD, &read);
>> -    if (ret < 0)
>> +    if (!ret) {
>> +        /* Success */
>> +        *read_len = len;
>> +        return 0;
>> +    } else if (ret == len) {
>> +        /* EOF */
>> +        *read_len = 0;
>> +        return 0;
>> +    } else {
>> +        /* Partial success */
>> +        *read_len = len - ret;
>>           return smh_errno();
>> -    return len - ret;
>> +    }
>> +
>>   }
>>   long smh_write(long fd, const void *memp, size_t len, ulong *written)
>> @@ -140,7 +151,7 @@ long smh_close(long fd)
>>       return 0;
>>   }
>> -long smh_flen(long fd)
>> +int smh_flen(long fd, size_t *size)
>>   {
>>       long ret;
>> @@ -149,7 +160,9 @@ long smh_flen(long fd)
>>       ret = smh_trap(SYSFLEN, &fd);
>>       if (ret == -1)
>>           return smh_errno();
>> -    return ret;
>> +
>> +    *size = (size_t)ret;
>> +    return 0;
>>   }
>>   long smh_seek(long fd, long pos)
>>
>> ---
>> base-commit: da47ddebd16a7e1047da8537fbf01558d2a89fcf
>> change-id: 20251002-fs_semihosting-85d697fbfcad
>>
>> Best regards,
> 


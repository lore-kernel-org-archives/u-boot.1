Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EABCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 21:53:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B48483F59;
	Fri, 10 Oct 2025 23:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="DqrHP5dZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A809783F7F; Fri, 10 Oct 2025 23:53:45 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28EE783F58
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 23:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 414153F7C4
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1760133222;
 bh=3kHtIUAecMfRh5SRIF4+fSTb9gkOqzIPl+AesmB0dHA=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=DqrHP5dZYW+EhGRH2yH8uTcvEtft/+qMj1DyHF8K244hDa6HwY0NlxCZCgvGlRkOX
 nSEGpK7lPe9nzj2zDpQzdEX5aZAwV7abqsDcEPDQSt/7+EsUgn517neAsA+mDnZ/pe
 UeCOwoV2fPVhaOCwtsGPmlikK6kQRLjEcJXvVyXck1VvzGWzyTNsXQnrqu7myShvqH
 ljNAAAsKGFudzklVtZfFvGJLAyaGDV7l0+yyi+NEhFm/T58YP3kfvs4wfe/AlC9vmt
 i7yKk7yyLYAEvtHLq6uisuWecjZzNuxaCWES4IE4YKm1mfgQUj9+cPsGttdDAAvN/8
 6fYaqeceHMW7G9iCjpNe0Wnrvb4Rh/1a1v6fOWltA2mzVHBVLA8HHuCE0RILJIeAUI
 LyYp74ZtQ8bjBvqxnR/LMWReanTQZAiTgpSSYytb48tgzn0YCL3kLsFvgwEs7vgQTm
 o7ZYGa9PWwC+ojgsutjoLArom4mJsUpX6uwYwwnmNOOji72fswdcUOqkJRmEnBSR2X
 KjeYwW23vSOnb76J6k1SqfjwcVX+3F8nwhLF0lCNJXUwurcNUZ5qySz4pPUYznHI6j
 uiei7Do21w8G8Sf2mrcDbYH5eGtp0YpbS8XtsmmQKIxgpW8CEmboWrgxSN8KnfXQhr
 Tyhdc3dRDqbqmJ51efE/okSQ=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e39567579so12531975e9.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 14:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760133222; x=1760738022;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3kHtIUAecMfRh5SRIF4+fSTb9gkOqzIPl+AesmB0dHA=;
 b=IWwIRmABb+mI5URvp5+oOBsgemGup7P3vrcjwjc1orHVrDIFpIokjVr0l7TXXIo6V/
 AGZIX74x+yJUJOc/Hmez2UkDMO+OSQbsuuFMwGHF2UA4LIht1cVuAuvwT3R9Lwbv/JzF
 RI6qh14A8n2578DoSnot+TYEHCmYRmJl70lwS7ImDThNQt4A849IcnEC3qSLLBYCFHIy
 vDAVmW1HV6cSz43v02S9L5R2R6TTgd5lOXfgFDkvPaK6s6iFf1gOoaMYU4c0y9ksaaUe
 MkNvwlB7Rmfllz4NjmBBmUzXD4VsiXuR4C9lKVVsPpfsYIxplgQhHd8kBHiJt57tYExk
 zhWQ==
X-Gm-Message-State: AOJu0Ywn0G+rjTkL0iR6nSlTulVQeQFZO3npopkRmaMqQpWSCTDjTxoj
 PPDVpDLNDPXgy6EWPBVgmv8zOfaPsG2YcXO0eSwnnajfMo6TE6MlvsOzsAHa3+3RWxg9bpfQzL8
 8nsXg9g23xYV/Vit2BcLTY7JAKST1ZLRVYOVC9jyUMN1JNMBt0dmgW1kQQFxrOKbA9jmdF4A=
X-Gm-Gg: ASbGncv/xd33ZpzeglxLDezf6wK8bjdXO+TTiXST2Jr2R4Qdh3ewkpdSjvDM5WAyPE3
 m9jRMFfp5Y/laosxIiVoxro/umNEE/hJNKNQGslDxKnNY5swUH67EmrrixjtKSsmTbBw+Dk9twm
 Ev00mncUUmtE0wbR1/v0hG8psA0fiOfEwUf3jvi+Z9kg2r2jO9LAzWhMV2i3VzgkTk9+IPn0C7b
 G80OuNPyOyOJJKP4Hd/mfPKjB5hNxl1WME6wTpjn82Jcg94NwrQL3+WQ+Y0gb2dwIvzoRX3PTqE
 8SM03QeRkavbhepItNdgKVsnQnUVnK4xydQs8jm3+AIV68AA6Csj10pmBPpQlAgFCCuXtwwyMNq
 pqw/47BE/YPFCpiXm9zvK
X-Received: by 2002:a05:600c:810a:b0:45f:2805:91df with SMTP id
 5b1f17b1804b1-46fa9af8338mr77230365e9.20.1760133221623; 
 Fri, 10 Oct 2025 14:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdvcyUhhre7bjkrWDXHrJNt/eZ0yafVO3gA8d327FstzgOQvGIKV8OWSeSffr7jimmoBaWXg==
X-Received: by 2002:a05:600c:810a:b0:45f:2805:91df with SMTP id
 5b1f17b1804b1-46fa9af8338mr77230235e9.20.1760133221075; 
 Fri, 10 Oct 2025 14:53:41 -0700 (PDT)
Received: from [192.168.103.116]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb48a5bf9sm65469385e9.18.2025.10.10.14.53.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 14:53:40 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <90736e19-2df6-4615-b2e1-a4db90df9f60@gmx.de>
Date: Fri, 10 Oct 2025 23:53:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fs: semihosting: Fixup smh_flen and smh_read against
 overflow
To: Sean Anderson <sean.anderson@seco.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251003-fs_semihosting-v3-1-5f6de9b7f225@linaro.org>
 <20251010203134.GA1187059@bill-the-cat>
 <f8fa81c6-8fc6-4f3c-bbbb-9f6c4be016ef@seco.com>
 <f19ae06f-1e63-4e1f-844f-d568fdd224d4@seco.com>
Content-Language: en-US
In-Reply-To: <f19ae06f-1e63-4e1f-844f-d568fdd224d4@seco.com>
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

On 10/10/25 23:05, Sean Anderson wrote:
> On 10/10/25 16:55, Sean Anderson wrote:
>> On 10/10/25 16:31, Tom Rini wrote:
>>> On Fri, Oct 03, 2025 at 10:03:57AM +0100, Andrew Goodbody wrote:
>>>
>>>> The sys calls SYS_FLEN and SYS_READ were being used in a way that did
>>>> not allow for file sizes > 2^31. Fixing this required changing the
>>>> signatures of the functions smh_flen and smh_read to allow file
>>>> sizes up to 2^32 - 2 and also being able to return errors that could be
>>>> tested for.
>>>>
>>>> This issue was found by Smatch.
>>
>> IMO this makes the API more awkward for no benefit, as no one actually
>> needs to read 2-4 GiB files (but no larger) with this interface. Aside
>> from this being unimaginably slow on real hardware and inferior to
>> virtio on emulated hardware, there are still other problems. Like, how
>> are you even going to address the RAM on a 32-bit system? U-Boot
>> (AFAIK) only does a linear mapping and most highmem systems will not
>> even have more than 1-2 GiB of memory without mapping over devices.
>>
>> I think a much cleaner solution is to just limit lengths to 2 GiB where
>> appropriate.

We should provide a spec compliant solution and not stick to some buggy 
past.

U-Boot supports function traces. Writing a trace file larger than 2 GiB 
should succeed.

ISO images may be loaded into RAM and booted via EFI from the RAM drive. 
ISO images may be larger than 2 GiB.

Artificially limiting ourselves to 2 GiB here is inappropriate.

Best regards

Heinrich

>>
>>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>>> ---
>>>> Changes in v3:
>>>> - V2 missed fixing up one use of smh_flen, fix it
>>>> - Link to v2: https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2fr%2f20251002%2dfs%5fsemihosting%2dv2%2d1%2dc1783e4188d8%40linaro.org&umid=65083f76-83f6-4254-a979-8e43c1e3a788&rct=1760129739&auth=d807158c60b7d2502abde8a2fc01f40662980862-31b6b7517dcc163c67b790b33a34a4f0a3f321b7
>>>>
>>>> Changes in v2:
>>>> - Fixup smh_flen and smh_read to allow for > 2^31 byte files
>>>> - Link to v1: https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2fr%2f20251002%2dfs%5fsemihosting%2dv1%2d1%2d1124e6becc51%40linaro.org&umid=65083f76-83f6-4254-a979-8e43c1e3a788&rct=1760129739&auth=d807158c60b7d2502abde8a2fc01f40662980862-38e52356997cde7f2ae1d272bd8f35d6bface016
>>>> ---
>>>>   common/spl/spl_semihosting.c        | 13 +++++++------
>>>>   drivers/serial/serial_semihosting.c |  6 ++++--
>>>>   fs/semihostingfs.c                  | 23 +++++++++++++----------
>>>>   include/semihosting.h               | 13 +++++++------
>>>>   lib/semihosting.c                   | 25 +++++++++++++++++++------
>>>>   5 files changed, 50 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
>>>> index f36863fe48d25859ee9af67a67140893b6e9e262..fb578a274d0d937b2ed5bd13e505bcefd4491799 100644
>>>> --- a/common/spl/spl_semihosting.c
>>>> +++ b/common/spl/spl_semihosting.c
>>>> @@ -13,13 +13,14 @@ static ulong smh_fit_read(struct spl_load_info *load, ulong file_offset,
>>>>   			  ulong size, void *buf)
>>>>   {
>>>>   	long fd = *(long *)load->priv;
>>>> -	ulong ret;
>>>> +	long ret;
>>>> +	size_t bytes_read;
>>>>   
>>>>   	if (smh_seek(fd, file_offset))
>>>>   		return 0;
>>>>   
>>>> -	ret = smh_read(fd, buf, size);
>>>> -	return ret < 0 ? 0 : ret;
>>>> +	ret = smh_read(fd, buf, size, &bytes_read);
>>>> +	return ret < 0 ? 0 : bytes_read;
>>>>   }
>>>>   
>>>>   static int spl_smh_load_image(struct spl_image_info *spl_image,
>>>> @@ -27,7 +28,8 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
>>>>   {
>>>>   	const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
>>>>   	int ret;
>>>> -	long fd, len;
>>>> +	long fd;
>>>> +	size_t len;
>>>>   	struct spl_load_info load;
>>>>   
>>>>   	fd = smh_open(filename, MODE_READ | MODE_BINARY);
>>>> @@ -36,12 +38,11 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
>>>>   		return fd;
>>>>   	}
>>>>   
>>>> -	ret = smh_flen(fd);
>>>> +	ret = smh_flen(fd, &len);
>>>>   	if (ret < 0) {
>>>>   		log_debug("could not get length of image: %d\n", ret);
>>>>   		goto out;
>>>>   	}
>>>> -	len = ret;
>>>>   
>>>>   	spl_load_init(&load, smh_fit_read, &fd, 1);
>>>>   	ret = spl_load(spl_image, bootdev, &load, len, 0);
>>>> diff --git a/drivers/serial/serial_semihosting.c b/drivers/serial/serial_semihosting.c
>>>> index 56a5ec72428afdd97eccad739a46189380ba3e76..017b1f8eda84f5c25e09be7e970d0ebfdbf2ace0 100644
>>>> --- a/drivers/serial/serial_semihosting.c
>>>> +++ b/drivers/serial/serial_semihosting.c
>>>> @@ -25,11 +25,12 @@ static int smh_serial_getc(struct udevice *dev)
>>>>   {
>>>>   	char ch = 0;
>>>>   	struct smh_serial_priv *priv = dev_get_priv(dev);
>>>> +	size_t bytes_read;
>>>>   
>>>>   	if (priv->infd < 0)
>>>>   		return smh_getc();
>>>>   
>>>> -	smh_read(priv->infd, &ch, sizeof(ch));
>>>> +	smh_read(priv->infd, &ch, sizeof(ch), &bytes_read);
>>>>   	return ch;
>>>>   }
>>>>   
>>>> @@ -140,11 +141,12 @@ static void smh_serial_setbrg(void)
>>>>   static int smh_serial_getc(void)
>>>>   {
>>>>   	char ch = 0;
>>>> +	size_t bytes_read;
>>>>   
>>>>   	if (infd < 0)
>>>>   		return smh_getc();
>>>>   
>>>> -	smh_read(infd, &ch, sizeof(ch));
>>>> +	smh_read(infd, &ch, sizeof(ch), &bytes_read);
>>>>   	return ch;
>>>>   }
>>>>   
>>>> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
>>>> index 77e39ca407e4d240a1fd573497c5b6b908816454..6a4d0aaaf2fdaf8da154e59677839a5c7a4889e9 100644
>>>> --- a/fs/semihostingfs.c
>>>> +++ b/fs/semihostingfs.c
>>>> @@ -23,7 +23,8 @@ int smh_fs_set_blk_dev(struct blk_desc *rbdd, struct disk_partition *info)
>>>>   static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>>>>   			  loff_t maxsize, loff_t *actread)
>>>>   {
>>>> -	long fd, size, ret;
>>>> +	long fd, ret;
>>>> +	size_t size;
>>>>   
>>>>   	fd = smh_open(filename, MODE_READ | MODE_BINARY);
>>>>   	if (fd < 0)
>>>> @@ -34,19 +35,19 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>>>>   		return ret;
>>>>   	}
>>>>   	if (!maxsize) {
>>>> -		size = smh_flen(fd);
>>>> +		ret = smh_flen(fd, &size);
>>>>   		if (ret < 0) {
>>>>   			smh_close(fd);
>>>> -			return size;
>>>> +			return ret;
>>>>   		}
>>>>   
>>>>   		maxsize = size;
>>>>   	}
>>>>   
>>>> -	size = smh_read(fd, buffer, maxsize);
>>>> +	ret = smh_read(fd, buffer, maxsize, &size);
>>>>   	smh_close(fd);
>>>> -	if (size < 0)
>>>> -		return size;
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>>   
>>>>   	*actread = size;
>>>>   	return 0;
>>>> @@ -78,17 +79,19 @@ static int smh_fs_write_at(const char *filename, loff_t pos, void *buffer,
>>>>   
>>>>   int smh_fs_size(const char *filename, loff_t *result)
>>>>   {
>>>> -	long fd, size;
>>>> +	long fd;
>>>> +	size_t size;
>>>> +	int ret;
>>>>   
>>>>   	fd = smh_open(filename, MODE_READ | MODE_BINARY);
>>>>   	if (fd < 0)
>>>>   		return fd;
>>>>   
>>>> -	size = smh_flen(fd);
>>>> +	ret = smh_flen(fd, &size);
>>>>   	smh_close(fd);
>>>>   
>>>> -	if (size < 0)
>>>> -		return size;
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>>   
>>>>   	*result = size;
>>>>   	return 0;
>>>> diff --git a/include/semihosting.h b/include/semihosting.h
>>>> index 4e844cbad87bb1ae6bb365f87f3e7a8aeea445f4..60535199b9532ce16620aea3ca1ea741c5b73766 100644
>>>> --- a/include/semihosting.h
>>>> +++ b/include/semihosting.h
>>>> @@ -95,12 +95,12 @@ long smh_open(const char *fname, enum smh_open_mode mode);
>>>>    * @fd: A file descriptor returned from smh_open()
>>>>    * @memp: Pointer to a buffer of memory of at least @len bytes
>>>>    * @len: The number of bytes to read
>>>> + * @read_len: Pointer which will be updated with actual bytes read on success,
>>>> + *  with 0 indicating %EOF
>>>>    *
>>>> - * Return:
>>>> - * * The number of bytes read on success, with 0 indicating %EOF
>>>> - * * A negative error on failure
>>>> + * Return: 0 on success or negative error on failure
>>>>    */
>>>> -long smh_read(long fd, void *memp, size_t len);
>>>> +long smh_read(long fd, void *memp, size_t len, size_t *read_len);
>>>>   
>>>>   /**
>>>>    * smh_write() - Write data to a file
>>>> @@ -124,10 +124,11 @@ long smh_close(long fd);
>>>>   /**
>>>>    * smh_flen() - Get the length of a file
>>>>    * @fd: A file descriptor returned from smh_open()
>>>> + * @size: Pointer which will be updated with length of file on success
>>>>    *
>>>> - * Return: The length of the file, in bytes, or a negative error on failure
>>>> + * Return: 0 on success or negative error on failure
>>>>    */
>>>> -long smh_flen(long fd);
>>>> +int smh_flen(long fd, size_t *size);
>>>>   
>>>>   /**
>>>>    * smh_seek() - Seek to a position in a file
>>>> diff --git a/lib/semihosting.c b/lib/semihosting.c
>>>> index 9be5bffd30124777c4f8110065e6cca5640312ac..a0f42d41e4a7ad95023c684f6824bfc677ad25cd 100644
>>>> --- a/lib/semihosting.c
>>>> +++ b/lib/semihosting.c
>>>> @@ -93,9 +93,9 @@ struct smh_rdwr_s {
>>>>   	size_t len;
>>>>   };
>>>>   
>>>> -long smh_read(long fd, void *memp, size_t len)
>>>> +long smh_read(long fd, void *memp, size_t len, size_t *read_len)
>>
>> But really we just need to make this return size_t.
>>
>>>>   {
>>>> -	long ret;
>>>> +	size_t ret;
>>>>   	struct smh_rdwr_s read;
>>>>   
>>>>   	debug("%s: fd %ld, memp %p, len %zu\n", __func__, fd, memp, len);
>>>> @@ -105,9 +105,20 @@ long smh_read(long fd, void *memp, size_t len)
>>>>   	read.len = len;
>>>>   
>>>>   	ret = smh_trap(SYSREAD, &read);
>>
>> This is a separate fix. Please break it out into another patch.
> 
> And actually, this is wrong since QEMU and OpenOCD both return -1 on error
> and set errno. So you need a fourth branch when ret == -1. So maybe we
> should just check for len > LONG_MAX on function entry and return
> -EOVERFLOW right away.
> 
>>>> -	if (ret < 0)
>>>> +	if (!ret) {
>>>> +		/* Success */
>>>> +		*read_len = len;
>>>> +		return 0;
>>>> +	} else if (ret == len) {
>>>> +		/* EOF */
>>>> +		*read_len = 0;
>>>> +		return 0;
>>>> +	} else {
>>>> +		/* Partial success */
>>>> +		*read_len = len - ret;
>>>>   		return smh_errno();
> 
> smh_errno() tends to only be set on failure. So if you call it on
> a short read you may get a spurious error.
> 
>>>> -	return len - ret;
>>>> +	}
>>>> +
>>>>   }
>>>>   
>>>>   long smh_write(long fd, const void *memp, size_t len, ulong *written)
>>>> @@ -140,7 +151,7 @@ long smh_close(long fd)
>>>>   	return 0;
>>>>   }
>>>>   
>>>> -long smh_flen(long fd)
>>>> +int smh_flen(long fd, size_t *size)
>>>>   {
>>>>   	long ret;
>>>>   
>>>> @@ -149,7 +160,9 @@ long smh_flen(long fd)
>>>>   	ret = smh_trap(SYSFLEN, &fd);
>>>>   	if (ret == -1)
>>
>> Just change this to
>>
>> 	if (ret < 0)
>> 		return ret == -1 ? smh_errno() : -EOVERFLOW;
>>
>> And now all the existing code works.
>>
>>>>   		return smh_errno();
>>>> -	return ret;
>>>> +
>>>> +	*size = (size_t)ret;
>>>> +	return 0;
>>
>>>>   }
>>>>   
>>>>   long smh_seek(long fd, long pos)
>>>>
>>>
>>> There was (as good thing!) much review and feedback on v1 and v2. Is
>>> everyone happy now with v3? Thanks!
>>>
>>
>> Sorry for the delay, I'm not working on U-Boot at $WORK at all right now
>> so I don't have much time for review.
>>
>> --Sean
> 


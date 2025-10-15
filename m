Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D7DCCD18E
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 09:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5F6F833C6;
	Wed, 15 Oct 2025 11:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jUm66oT1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89F1D833F6; Wed, 15 Oct 2025 11:02:21 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3590833BF
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 11:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso55440215e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 02:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760518938; x=1761123738; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zlcv1D0aYEKZx6ChQATS/EWMOQIp7adVEPyJedpXGQo=;
 b=jUm66oT1e5Pgflf3sR2SX0Lmzjvk8s+w9gCIEM1AZlH2t8BhfawVPJsvq3fTSm9a6X
 TtYmx00fCt+FWyNMuHv82u1ojCrohyKEp8kEZbMqTHtwUocQKLlx53t55/JZGjOhbuMf
 G7Bcpm+cDXh8CgAxjLT0VOhWs/GS3SIMun1lgLcgCNU+X3t2PRejvVYGsh1Gw0vbnTCX
 kyArESFaNGyEJzdmHuXvjXcevuwxvL5MiRB0JNGHEC6PVbVagxRL45cnhGSnAyKntBfO
 b0gGvc+jQqZe9JEKGMsgrG34ba/GVKl/EtwIvDthMKVEmTQ4ZsAU4lm1TQ5kCGliXr5r
 CzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760518938; x=1761123738;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zlcv1D0aYEKZx6ChQATS/EWMOQIp7adVEPyJedpXGQo=;
 b=nnKkyFxSOAHUB80+oCfnzsxeuJAFRF3dj7WH7Xh5fsCOzichyaCxIDg0ZH3ZkZ4dHs
 pZaeDfIzBS+n+7+HgoJyXf62ZBetYscEiLSgN7Xx2FlTL2ondcsXLhTZRKgg7Uy4gTsI
 G2udVvKxfxEAtERhrWl2ZzQIC7LJTXfKSA7bPjNM6fjEmgkzIovseWOO3gjOQ0d/e+vL
 kKKc6WgM1HqAxtnzs+fepqpNwYoeERBq5lKWppSooASNWQKUmX3e0xTxkP+QvP5WSXup
 YcfmVPeg9ZqhxpPgvnrtxMapfmLWV69StZryAZCBd3YUVSejUyveIb4tN1BWxlYg4yga
 Hu9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCULNRuPuYvDo2GYhWFGJ1OW0d14IS11fkBlhbt7b+sXy7IHocgllddVpXLzNxmGFMzDhujy7PM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8t/Row5nKRleq9AAQSF2P3T3qBJHWSe6u/lh3LAj//J9MMDF3
 kTUNb2MJKwkOJZ02G3suHtto0l0RNo8dNEvdMvrG26gW0mKFjh7EX5zWbqcft8iVlIo=
X-Gm-Gg: ASbGncsG10LOye03ZB1NpWpEtfcV5uOJy5KmFJkvNKHFQOEXVd5PiZb8n4nsd9bAdtK
 oCWJEeRbu6ZrwyhTPDbmW3tnvyp5Qjy53DcTBkBidW0vc0AsruCepPuraPZMT/Dy9mvrWBzcgPU
 sSMUQMcrhc8L2G2aYnNb6w2Vs4MnwxQ3081Kw60bevPwu0CcEfmbC60pNvXWoO01bwbvk5DcMrt
 cn2ZBcmVmxBrfzZbaC754wDgEpyvWop+6uySQaKA/MxuWmWn2JUVFiV+cVwYUqd27xsGjnx/XCU
 KAerU83Dk+XABGhyss8wG/gGQw+N6iD9ECzluxwNzXSJ+gdDidmgE9rQoDHcJ2hLt3yvvdGwF8x
 ve6W+RIcx38hYexXenWA/U0UoNBgmFfGUsVTCPgjDiNdd9GLsxatSb4XaQYHdeebbYX0sH3jsJ0
 8wHC18qX3huO3PU1EdgwQ47MynYYCEJ+GKaGo=
X-Google-Smtp-Source: AGHT+IHL/F8BykqcyL0x/h/wT/hk/kfTNROhNp4UMb2BXjyBoHCda5eneLkk25L2P7mJo+fpHKjfaQ==
X-Received: by 2002:a05:6000:40da:b0:403:8cc:db6b with SMTP id
 ffacd0b85a97d-4266e7d93b4mr19448813f8f.35.1760518938097; 
 Wed, 15 Oct 2025 02:02:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5?
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47101be0caasm17114505e9.3.2025.10.15.02.02.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:02:17 -0700 (PDT)
Message-ID: <3ebd6329-a5c7-4b32-b639-b014d2e289f6@linaro.org>
Date: Wed, 15 Oct 2025 10:02:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] fs: semihosting: Fixup smh_flen against overflow
To: Sean Anderson <sean.anderson@seco.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20251014-fs_semihosting-v4-0-6f2bc490175b@linaro.org>
 <20251014-fs_semihosting-v4-2-6f2bc490175b@linaro.org>
 <ac6c0dc1-2be7-48f5-8c2e-f90401411bef@seco.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <ac6c0dc1-2be7-48f5-8c2e-f90401411bef@seco.com>
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

On 14/10/2025 17:21, Sean Anderson wrote:
> On 10/14/25 12:03, Andrew Goodbody wrote:
>> The sys calls SYS_FLEN was being used in a way that did ot allow for
>> file sizes > 2^31. Fixing this required changing the signature of the
>> function to allow file sizes up to 2^32 - 2 and also being able to
>> return errors that could be tested for.
>>
>> This issue was found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   common/spl/spl_semihosting.c |  6 +++---
>>   fs/semihostingfs.c           | 14 ++++++++------
>>   include/semihosting.h        |  5 +++--
>>   lib/semihosting.c            |  6 ++++--
>>   4 files changed, 18 insertions(+), 13 deletions(-)
>>
>> diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
>> index cff6f5351e265136b3effe483fd5d641fdd109f8..fb578a274d0d937b2ed5bd13e505bcefd4491799 100644
>> --- a/common/spl/spl_semihosting.c
>> +++ b/common/spl/spl_semihosting.c
>> @@ -28,7 +28,8 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
>>   {
>>   	const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
>>   	int ret;
>> -	long fd, len;
>> +	long fd;
>> +	size_t len;
>>   	struct spl_load_info load;
>>   
>>   	fd = smh_open(filename, MODE_READ | MODE_BINARY);
>> @@ -37,12 +38,11 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
>>   		return fd;
>>   	}
>>   
>> -	ret = smh_flen(fd);
>> +	ret = smh_flen(fd, &len);
>>   	if (ret < 0) {
>>   		log_debug("could not get length of image: %d\n", ret);
>>   		goto out;
>>   	}
>> -	len = ret;
>>   
>>   	spl_load_init(&load, smh_fit_read, &fd, 1);
>>   	ret = spl_load(spl_image, bootdev, &load, len, 0);
>> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
>> index 15f58d578b65f7dbbadce19093546f5bdb46c0c3..6a4d0aaaf2fdaf8da154e59677839a5c7a4889e9 100644
>> --- a/fs/semihostingfs.c
>> +++ b/fs/semihostingfs.c
>> @@ -35,10 +35,10 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>>   		return ret;
>>   	}
>>   	if (!maxsize) {
>> -		size = smh_flen(fd);
>> +		ret = smh_flen(fd, &size);
>>   		if (ret < 0) {
>>   			smh_close(fd);
>> -			return size;
>> +			return ret;
>>   		}
>>   
>>   		maxsize = size;
>> @@ -79,17 +79,19 @@ static int smh_fs_write_at(const char *filename, loff_t pos, void *buffer,
>>   
>>   int smh_fs_size(const char *filename, loff_t *result)
>>   {
>> -	long fd, size;
>> +	long fd;
>> +	size_t size;
>> +	int ret;
>>   
>>   	fd = smh_open(filename, MODE_READ | MODE_BINARY);
>>   	if (fd < 0)
>>   		return fd;
>>   
>> -	size = smh_flen(fd);
>> +	ret = smh_flen(fd, &size);
>>   	smh_close(fd);
>>   
>> -	if (size < 0)
>> -		return size;
>> +	if (ret < 0)
>> +		return ret;
>>   
>>   	*result = size;
>>   	return 0;
>> diff --git a/include/semihosting.h b/include/semihosting.h
>> index 42832d86c711ff04e91b6b739c80629253f6d30a..60535199b9532ce16620aea3ca1ea741c5b73766 100644
>> --- a/include/semihosting.h
>> +++ b/include/semihosting.h
>> @@ -124,10 +124,11 @@ long smh_close(long fd);
>>   /**
>>    * smh_flen() - Get the length of a file
>>    * @fd: A file descriptor returned from smh_open()
>> + * @size: Pointer which will be updated with length of file on success
>>    *
>> - * Return: The length of the file, in bytes, or a negative error on failure
>> + * Return: 0 on success or negative error on failure
>>    */
>> -long smh_flen(long fd);
>> +int smh_flen(long fd, size_t *size);
>>   
>>   /**
>>    * smh_seek() - Seek to a position in a file
>> diff --git a/lib/semihosting.c b/lib/semihosting.c
>> index e49b16b0aa34ab04b6c8949a3e7cab539fdbef82..547a936e17f38204e840035a50f481e57d159592 100644
>> --- a/lib/semihosting.c
>> +++ b/lib/semihosting.c
>> @@ -154,7 +154,7 @@ long smh_close(long fd)
>>   	return 0;
>>   }
>>   
>> -long smh_flen(long fd)
>> +int smh_flen(long fd, size_t *size)
>>   {
>>   	long ret;
>>   
>> @@ -163,7 +163,9 @@ long smh_flen(long fd)
>>   	ret = smh_trap(SYSFLEN, &fd);
>>   	if (ret == -1)
>>   		return smh_errno();
>> -	return ret;
>> +
>> +	*size = (size_t)ret;
>> +	return 0;
>>   }
>>   
>>   long smh_seek(long fd, long pos)
>>
> 
> Nack, for reasons outlined on v3.
> 
> This should just be
> 
>      if (ret < 0)
>          return ret == -1 ? smh_errno() : -EOVERFLOW;
> 
> --Sean

I am not going to spend any more time on this. There is a real bug that 
is addressed by V1.
https://patchwork.ozlabs.org/project/uboot/patch/20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org/
Please consider applying that.

Andrew


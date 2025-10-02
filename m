Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99685CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 16:07:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F7CF835A2;
	Thu,  2 Oct 2025 18:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SENnQ6Si";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E77BD835AA; Thu,  2 Oct 2025 18:07:24 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E18E381D6A
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 18:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso914794f8f.1
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 09:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759421241; x=1760026041; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3jBUP7Kzmc2bNTJ96isQC754+ENbxYgsQicZfZ8w6rs=;
 b=SENnQ6SiHNzBbr10rTuUG3xwlbaO+NG8TcYmu83gmrA6Nd9KW7fElJ5J9seu3xhJtU
 KHLpo6rxrSnVTu4p5ufwJp2fJ8uIOijVw3sD0KxJmlK6RL9n2P23F1nbEfk06B28j1Bm
 d63OG4JBjD+JzYqh8xcaCbp3FIP0uJqw1QjoLaifSqU68RINGf0SAUi0oAmY0TC5XhTe
 J578+EAEjzp0lq2hdKE7S3NJ0TTjvrvICaLdiktnQtMJPvNknOBAAkK2sJWOg7zOCRY2
 0j7eKeGkLYSc3p0FqlelTA05a72eJJpBBXwWc05XGL84qM0Nl6MT/Kq6dVUD9nx/zv9+
 URDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759421241; x=1760026041;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3jBUP7Kzmc2bNTJ96isQC754+ENbxYgsQicZfZ8w6rs=;
 b=G3HCNLkG/DXpm9xrIwPKTD1iKeLGVGn0UaAbPkHZ4MPTO7cwovEYzIvmKmGbrbGg2U
 e/bhFaJeLuTecx/eJ7U/KK1FJDqGMumw9VrV3i3FItoVoEtQUSnjHOvE2BeC4OyiTPrq
 LKa231ORx/g+wRiXcH9IfkCxCl1QvbQQjX+Wj/pq+we/E9HnQOllaaad/GImhOPWTvo/
 lT6ooAAa8LhSI2FsToR1Ac+L+Oars6vkPO0pBSquz21p4g3qJv4CuufQ6Z9J9iUQN7mT
 BZdwCBdcW5dtUE8JCqXjo3L+1dXtYqlryG8GojVWB0gof0L+B24dvMtUPJXMOfuFAH8d
 q04Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX1HXtmM/gtzaA9pn9zvdbl8/yr7B4z+xSHC/2TIX4xTyxCFqWIfBRYcKcW9mJJY6gyVOO95A=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/AsL3ETFBxOX33QZfZzGP+BsWEtSlEgIr8Sjilyqus8CFIS9/
 tuhgEC+yyDCOD8s8zcU1t48UFelbLvwwOPJXCwAwX1xwgHWPiMvqSfqb8lPmoQsW9t/Rj1JP1sl
 dgOAu
X-Gm-Gg: ASbGncuKdbRl3sucknegcUCC9ND6kgh6Y8R3+M9zxrI4y89iui9YmSuT7Fs5TksOfhG
 oTZ7SVNOJnHaQwNbXW6gH0QX+3NVCSHKCAk5g60zlxQahzNsCNbYyFwiWwn7OZc4lDIvg/5SGtT
 WgMP8Yh1H3GQ/kA+kpULO/IDo6R2rplziucwy84d8ZOESy7itRZlOpvYvlODHBnUoVSc7a27Ng3
 nZrOgJxP4+TCaYzqKky85zH3IK4Y42VDK1C0d1pQTy5sPDIDgOEq55AptFqGi013iEDKbequMtC
 +cbTIeLuQLdFn0qGULHgOZxfO1XDAfM7PtDqAwNCoHSST9n7sUBGUbXKBsmLuDhP/zITTKdrLLZ
 S7zhLq/06loJUl+M5TZ7YzQlvzqqiTeTNCM2gtY6rsh0WrA+TjzEzpjCshTAie2WgaOl5OL0v+1
 zVDW/Xu/luQT+cdNy+uC0Bp+El92+xuw==
X-Google-Smtp-Source: AGHT+IH/ZXzrWKWDlGV0MR8BogE0sJbbgpmu3N2nT9hJsJ9FR8qwwgVrZ9pzgCoE1za6MjAUVN3x7A==
X-Received: by 2002:a05:6000:288b:b0:3e9:54d1:e708 with SMTP id
 ffacd0b85a97d-4255d2b325bmr2394888f8f.20.1759421241162; 
 Thu, 02 Oct 2025 09:07:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:ebd:e301:a21d:c610:1e27:3706?
 ([2a0a:ef40:ebd:e301:a21d:c610:1e27:3706])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8ab8fdsm4153181f8f.15.2025.10.02.09.07.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 09:07:20 -0700 (PDT)
Message-ID: <14a0a3ba-0e2c-427d-902a-c5553e851199@linaro.org>
Date: Thu, 2 Oct 2025 17:07:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs: semihosting: Fixup smh_flen and smh_read against
 overflow
To: Sean Anderson <sean.anderson@seco.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20251002-fs_semihosting-v2-1-c1783e4188d8@linaro.org>
 <081c49ae-f1ac-4119-8ef4-c4433131b983@seco.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <081c49ae-f1ac-4119-8ef4-c4433131b983@seco.com>
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

On 02/10/2025 16:42, Sean Anderson wrote:
> On 10/2/25 10:32, Andrew Goodbody wrote:
>> The sys calls SYS_FLEN and SYS_READ were being used in a way that did
>> not allow for file sizes > 2^31. Fixing this required changing the
>> signatures of the functions smh_flen and smh_read to allow file
>> sizes up to 2^32 - 2 and also being able to return errors that could be
>> tested for.
>>
>> This issue was found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>> Changes in v2:
>> - Fixup smh_flen and smh_read to allow for > 2^31 byte files
>> - Link to v1: https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2fr%2f20251002%2dfs%5fsemihosting%2dv1%2d1%2d1124e6becc51%40linaro.org&umid=ee8de4df-2479-48c7-83ae-b302789e6a41&rct=1759415558&auth=d807158c60b7d2502abde8a2fc01f40662980862-944860761829276b5cf613a133926bf7544353ff
>> ---
>>   common/spl/spl_semihosting.c        | 13 +++++++------
>>   drivers/serial/serial_semihosting.c |  6 ++++--
>>   fs/semihostingfs.c                  | 13 +++++++------
>>   include/semihosting.h               | 13 +++++++------
>>   lib/semihosting.c                   | 25 +++++++++++++++++++------
>>   5 files changed, 44 insertions(+), 26 deletions(-)
>>
>> diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
>> index f36863fe48d25859ee9af67a67140893b6e9e262..fb578a274d0d937b2ed5bd13e505bcefd4491799 100644
>> --- a/common/spl/spl_semihosting.c
>> +++ b/common/spl/spl_semihosting.c
>> @@ -13,13 +13,14 @@ static ulong smh_fit_read(struct spl_load_info *load, ulong file_offset,
>>   			  ulong size, void *buf)
>>   {
>>   	long fd = *(long *)load->priv;
>> -	ulong ret;
>> +	long ret;
>> +	size_t bytes_read;
>>   
>>   	if (smh_seek(fd, file_offset))
>>   		return 0;
>>   
>> -	ret = smh_read(fd, buf, size);
>> -	return ret < 0 ? 0 : ret;
>> +	ret = smh_read(fd, buf, size, &bytes_read);
>> +	return ret < 0 ? 0 : bytes_read;
>>   }
>>   
>>   static int spl_smh_load_image(struct spl_image_info *spl_image,
>> @@ -27,7 +28,8 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
>>   {
>>   	const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
>>   	int ret;
>> -	long fd, len;
>> +	long fd;
>> +	size_t len;
>>   	struct spl_load_info load;
>>   
>>   	fd = smh_open(filename, MODE_READ | MODE_BINARY);
>> @@ -36,12 +38,11 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
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
>> diff --git a/drivers/serial/serial_semihosting.c b/drivers/serial/serial_semihosting.c
>> index 56a5ec72428afdd97eccad739a46189380ba3e76..017b1f8eda84f5c25e09be7e970d0ebfdbf2ace0 100644
>> --- a/drivers/serial/serial_semihosting.c
>> +++ b/drivers/serial/serial_semihosting.c
>> @@ -25,11 +25,12 @@ static int smh_serial_getc(struct udevice *dev)
>>   {
>>   	char ch = 0;
>>   	struct smh_serial_priv *priv = dev_get_priv(dev);
>> +	size_t bytes_read;
>>   
>>   	if (priv->infd < 0)
>>   		return smh_getc();
>>   
>> -	smh_read(priv->infd, &ch, sizeof(ch));
>> +	smh_read(priv->infd, &ch, sizeof(ch), &bytes_read);
>>   	return ch;
>>   }
>>   
>> @@ -140,11 +141,12 @@ static void smh_serial_setbrg(void)
>>   static int smh_serial_getc(void)
>>   {
>>   	char ch = 0;
>> +	size_t bytes_read;
>>   
>>   	if (infd < 0)
>>   		return smh_getc();
>>   
>> -	smh_read(infd, &ch, sizeof(ch));
>> +	smh_read(infd, &ch, sizeof(ch), &bytes_read);
>>   	return ch;
>>   }
>>   
>> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
>> index 77e39ca407e4d240a1fd573497c5b6b908816454..71b6634b0660e32cc63f7fc60ec1af8d3248433a 100644
>> --- a/fs/semihostingfs.c
>> +++ b/fs/semihostingfs.c
>> @@ -23,7 +23,8 @@ int smh_fs_set_blk_dev(struct blk_desc *rbdd, struct disk_partition *info)
>>   static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>>   			  loff_t maxsize, loff_t *actread)
>>   {
>> -	long fd, size, ret;
>> +	long fd, ret;
>> +	size_t size;
>>   
>>   	fd = smh_open(filename, MODE_READ | MODE_BINARY);
>>   	if (fd < 0)
>> @@ -34,19 +35,19 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
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
>>   	}
>>   
>> -	size = smh_read(fd, buffer, maxsize);
>> +	ret = smh_read(fd, buffer, maxsize, &size);
>>   	smh_close(fd);
>> -	if (size < 0)
>> -		return size;
>> +	if (ret < 0)
>> +		return ret;
>>   
>>   	*actread = size;
>>   	return 0;
>> diff --git a/include/semihosting.h b/include/semihosting.h
>> index 4e844cbad87bb1ae6bb365f87f3e7a8aeea445f4..60535199b9532ce16620aea3ca1ea741c5b73766 100644
>> --- a/include/semihosting.h
>> +++ b/include/semihosting.h
>> @@ -95,12 +95,12 @@ long smh_open(const char *fname, enum smh_open_mode mode);
>>    * @fd: A file descriptor returned from smh_open()
>>    * @memp: Pointer to a buffer of memory of at least @len bytes
>>    * @len: The number of bytes to read
>> + * @read_len: Pointer which will be updated with actual bytes read on success,
>> + *  with 0 indicating %EOF
>>    *
>> - * Return:
>> - * * The number of bytes read on success, with 0 indicating %EOF
>> - * * A negative error on failure
>> + * Return: 0 on success or negative error on failure
>>    */
>> -long smh_read(long fd, void *memp, size_t len);
>> +long smh_read(long fd, void *memp, size_t len, size_t *read_len);
>>   
>>   /**
>>    * smh_write() - Write data to a file
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
>> index 9be5bffd30124777c4f8110065e6cca5640312ac..a0f42d41e4a7ad95023c684f6824bfc677ad25cd 100644
>> --- a/lib/semihosting.c
>> +++ b/lib/semihosting.c
>> @@ -93,9 +93,9 @@ struct smh_rdwr_s {
>>   	size_t len;
>>   };
>>   
>> -long smh_read(long fd, void *memp, size_t len)
>> +long smh_read(long fd, void *memp, size_t len, size_t *read_len)
>>   {
>> -	long ret;
>> +	size_t ret;
>>   	struct smh_rdwr_s read;
>>   
>>   	debug("%s: fd %ld, memp %p, len %zu\n", __func__, fd, memp, len);
>> @@ -105,9 +105,20 @@ long smh_read(long fd, void *memp, size_t len)
>>   	read.len = len;
>>   
>>   	ret = smh_trap(SYSREAD, &read);
>> -	if (ret < 0)
>> +	if (!ret) {
>> +		/* Success */
>> +		*read_len = len;
>> +		return 0;
>> +	} else if (ret == len) {
>> +		/* EOF */
>> +		*read_len = 0;
>> +		return 0;
>> +	} else {
>> +		/* Partial success */
>> +		*read_len = len - ret;
>>   		return smh_errno();
>> -	return len - ret;
>> +	}
>> +
>>   }
>>   
>>   long smh_write(long fd, const void *memp, size_t len, ulong *written)
>> @@ -140,7 +151,7 @@ long smh_close(long fd)
>>   	return 0;
>>   }
>>   
>> -long smh_flen(long fd)
>> +int smh_flen(long fd, size_t *size)
>>   {
>>   	long ret;
>>   
>> @@ -149,7 +160,9 @@ long smh_flen(long fd)
>>   	ret = smh_trap(SYSFLEN, &fd);
>>   	if (ret == -1)
>>   		return smh_errno();
>> -	return ret;
>> +
>> +	*size = (size_t)ret;
>> +	return 0;
> 
> This is completely wrong. long is 32-bits on 32-bit systems, so you
> cannot get the upper 64 bits just by casting to a size_t.
> 
> --Sean

FWIW I was not attempting to get to 64 bits in a 32 bit system. long is 
31 bits plus a sign bit. All I was attempting was to get to 32 bits.

Andrew


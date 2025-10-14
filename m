Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA3DCCD192
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 16:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 841768312A;
	Tue, 14 Oct 2025 18:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lifdc1+A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3535183303; Tue, 14 Oct 2025 18:03:17 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF6F9807B1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 18:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4256866958bso3150628f8f.1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 09:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760457793; x=1761062593; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=056/tVUdY6N1nDUlwjAKGMCLQCw0x4+vikv9Wucz8Ds=;
 b=lifdc1+AAHpMVGEW2G0M7lLlFjlaeiCDt/xwvjMiO0wxgbSNd0RTTHq1TtFVCw7HyO
 AmIm9Vok5CQPQSSwHOigSQnmDb74qqKu+LX+xFP56Npycc6eS2aKxNZ7Wavmonyo6l9N
 ziiqBq6PbqazpbTSXCNEdW08mSnOxQoXm8oOQlOTMJ2H2DWQFnAOfhafYlfIGu/3yVO/
 2OdGSASp5WVOU82fEzmQ1AgMtHXx1Tfia/x4gOooExiuJooUUR1g3H6dNKVSg4sbpqjj
 m+YlosFM4N/GBiBRcgXrsGA9T437fkgIXAIkeheYJGAO30XcAYWXIS0MNUvFVu1uYWr1
 Nw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760457793; x=1761062593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=056/tVUdY6N1nDUlwjAKGMCLQCw0x4+vikv9Wucz8Ds=;
 b=cETMg0qmykZy65k89AupTK2C1XDq5opcf5D3ModRW+W5521pPxwof6lvgEeblg691x
 28Q4DejFtGKqgYRSAgTMh5MbdKhm69svEXcyJkDtmFsG0mHZOlovQRpaD5/31scl/GEY
 LIcEI9wO7jfzH/kyEdEMl0R/rIGIjy59prn54o+fTP1uatBMdkC9BIiolPAv3ojHdzYK
 /olO2IbNpzDlMJiWXdg/WQbJwnaTuUf1OqoF3KncMCUELJhLQ4ewI19Lqe9BoMJe+Zn5
 MpGwDf8x2AwYp2pLc1FdK1XQ53ckQK/1GGDM02j2Fv/vxzueZlFlFoNWi/CUaUYGyXvD
 d5PQ==
X-Gm-Message-State: AOJu0YwySfHGlWjylatg9u0F4E/wNdTrkP8JXvzEA2dYgjc2SIp2MEzS
 AvERZJYE6v71IAeat1MCp7ETa5arS/CUo76AFErhq4tf8Z8yBqRspG1WGbPbR410G50=
X-Gm-Gg: ASbGncvE0ZWvUy7fj4W2fE2Qh3+sQ0sxkmuW8I9zhSm48rinCTOWz2DjTVQqz9yxXMY
 in8iKZywRW7F04tCRQ978GHqVlVTG3QqK8d6LVoCENWwrFTYi4TF5EsysCsKTN5+NWODL3J7fq5
 0ZQGtBB8PTveBcY8wB9MOPp8Q+wdS68Q/RfmTRn/ai1c3EzCKfRRJ1im+11plHq1y6UckB7HDtH
 t9nqbx9JCLWcWtnya0OmjdGqNzo3aU5PlMVc1LD5rSnhEEF1gCaGYVGhorXWqafHRtG8clVmuWj
 AsLx/LLNrjaS5UZDEhaxvVI4KiNyEfu9EN2Mgv3Tqom4drGTqbCfIHTYC/dzFGcKD6pWXRjvBWP
 i7l/to6362nkZdJ/v/NcOVq/Ty/fW6zWBlKaTfia8K8Rw6cgU3a1FHeWH6AWWhV7wKF2gtmAn33
 sF2emRFo/I4/wlyv+cuvu/04/x
X-Google-Smtp-Source: AGHT+IFr9XiLVFylWWu/dq4+5hldltlBfAeA5PpNWLDHTUFnMmnVF4mlvnWauNAsHp1Ey31ALj7wMQ==
X-Received: by 2002:a5d:5f91:0:b0:426:eef2:fa86 with SMTP id
 ffacd0b85a97d-426eef2faafmr2136414f8f.11.1760457792613; 
 Tue, 14 Oct 2025 09:03:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:fed:4601:216f:297d:c441:f2cf?
 ([2a0a:ef40:fed:4601:216f:297d:c441:f2cf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583424sm24011607f8f.21.2025.10.14.09.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 09:03:12 -0700 (PDT)
Message-ID: <a1ef5592-647e-421b-946e-2ceed6bb47e9@linaro.org>
Date: Tue, 14 Oct 2025 17:03:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fs: semihosting: Fixup smh_flen and smh_read against
 overflow
To: Sean Anderson <sean.anderson@seco.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
References: <20251003-fs_semihosting-v3-1-5f6de9b7f225@linaro.org>
 <20251010203134.GA1187059@bill-the-cat>
 <f8fa81c6-8fc6-4f3c-bbbb-9f6c4be016ef@seco.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <f8fa81c6-8fc6-4f3c-bbbb-9f6c4be016ef@seco.com>
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

On 10/10/2025 21:55, Sean Anderson wrote:
> On 10/10/25 16:31, Tom Rini wrote:
>> On Fri, Oct 03, 2025 at 10:03:57AM +0100, Andrew Goodbody wrote:
>>
>>> The sys calls SYS_FLEN and SYS_READ were being used in a way that did
>>> not allow for file sizes > 2^31. Fixing this required changing the
>>> signatures of the functions smh_flen and smh_read to allow file
>>> sizes up to 2^32 - 2 and also being able to return errors that could be
>>> tested for.
>>>
>>> This issue was found by Smatch.
> 
> IMO this makes the API more awkward for no benefit, as no one actually
> needs to read 2-4 GiB files (but no larger) with this interface. Aside
> from this being unimaginably slow on real hardware and inferior to
> virtio on emulated hardware, there are still other problems. Like, how
> are you even going to address the RAM on a 32-bit system? U-Boot
> (AFAIK) only does a linear mapping and most highmem systems will not
> even have more than 1-2 GiB of memory without mapping over devices.
> 
> I think a much cleaner solution is to just limit lengths to 2 GiB where
> appropriate.

The very slight increase in complexity in the API is a small price to 
pay for not arbitrarily limiting the file sizes that can be worked with. 
If this prevents someone in the future from having to dig in to the code 
to work out why the file size of their 3GB file is being mis-reported 
then it will be unquestionably worth it. IMO the cost vs benefit of this 
fix leans to the benefit side.

>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>> ---
>>> Changes in v3:
>>> - V2 missed fixing up one use of smh_flen, fix it
>>> - Link to v2: https://lore.kernel.org/r/20251002-fs_semihosting-v2-1-c1783e4188d8@linaro.org
>>>
>>> Changes in v2:
>>> - Fixup smh_flen and smh_read to allow for > 2^31 byte files
>>> - Link to v1: https://lore.kernel.org/r/20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org
>>> ---
>>>   common/spl/spl_semihosting.c        | 13 +++++++------
>>>   drivers/serial/serial_semihosting.c |  6 ++++--
>>>   fs/semihostingfs.c                  | 23 +++++++++++++----------
>>>   include/semihosting.h               | 13 +++++++------
>>>   lib/semihosting.c                   | 25 +++++++++++++++++++------
>>>   5 files changed, 50 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
>>> index f36863fe48d25859ee9af67a67140893b6e9e262..fb578a274d0d937b2ed5bd13e505bcefd4491799 100644
>>> --- a/common/spl/spl_semihosting.c
>>> +++ b/common/spl/spl_semihosting.c
>>> @@ -13,13 +13,14 @@ static ulong smh_fit_read(struct spl_load_info *load, ulong file_offset,
>>>   			  ulong size, void *buf)
>>>   {
>>>   	long fd = *(long *)load->priv;
>>> -	ulong ret;
>>> +	long ret;
>>> +	size_t bytes_read;
>>>   
>>>   	if (smh_seek(fd, file_offset))
>>>   		return 0;
>>>   
>>> -	ret = smh_read(fd, buf, size);
>>> -	return ret < 0 ? 0 : ret;
>>> +	ret = smh_read(fd, buf, size, &bytes_read);
>>> +	return ret < 0 ? 0 : bytes_read;
>>>   }
>>>   
>>>   static int spl_smh_load_image(struct spl_image_info *spl_image,
>>> @@ -27,7 +28,8 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
>>>   {
>>>   	const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
>>>   	int ret;
>>> -	long fd, len;
>>> +	long fd;
>>> +	size_t len;
>>>   	struct spl_load_info load;
>>>   
>>>   	fd = smh_open(filename, MODE_READ | MODE_BINARY);
>>> @@ -36,12 +38,11 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
>>>   		return fd;
>>>   	}
>>>   
>>> -	ret = smh_flen(fd);
>>> +	ret = smh_flen(fd, &len);
>>>   	if (ret < 0) {
>>>   		log_debug("could not get length of image: %d\n", ret);
>>>   		goto out;
>>>   	}
>>> -	len = ret;
>>>   
>>>   	spl_load_init(&load, smh_fit_read, &fd, 1);
>>>   	ret = spl_load(spl_image, bootdev, &load, len, 0);
>>> diff --git a/drivers/serial/serial_semihosting.c b/drivers/serial/serial_semihosting.c
>>> index 56a5ec72428afdd97eccad739a46189380ba3e76..017b1f8eda84f5c25e09be7e970d0ebfdbf2ace0 100644
>>> --- a/drivers/serial/serial_semihosting.c
>>> +++ b/drivers/serial/serial_semihosting.c
>>> @@ -25,11 +25,12 @@ static int smh_serial_getc(struct udevice *dev)
>>>   {
>>>   	char ch = 0;
>>>   	struct smh_serial_priv *priv = dev_get_priv(dev);
>>> +	size_t bytes_read;
>>>   
>>>   	if (priv->infd < 0)
>>>   		return smh_getc();
>>>   
>>> -	smh_read(priv->infd, &ch, sizeof(ch));
>>> +	smh_read(priv->infd, &ch, sizeof(ch), &bytes_read);
>>>   	return ch;
>>>   }
>>>   
>>> @@ -140,11 +141,12 @@ static void smh_serial_setbrg(void)
>>>   static int smh_serial_getc(void)
>>>   {
>>>   	char ch = 0;
>>> +	size_t bytes_read;
>>>   
>>>   	if (infd < 0)
>>>   		return smh_getc();
>>>   
>>> -	smh_read(infd, &ch, sizeof(ch));
>>> +	smh_read(infd, &ch, sizeof(ch), &bytes_read);
>>>   	return ch;
>>>   }
>>>   
>>> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
>>> index 77e39ca407e4d240a1fd573497c5b6b908816454..6a4d0aaaf2fdaf8da154e59677839a5c7a4889e9 100644
>>> --- a/fs/semihostingfs.c
>>> +++ b/fs/semihostingfs.c
>>> @@ -23,7 +23,8 @@ int smh_fs_set_blk_dev(struct blk_desc *rbdd, struct disk_partition *info)
>>>   static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>>>   			  loff_t maxsize, loff_t *actread)
>>>   {
>>> -	long fd, size, ret;
>>> +	long fd, ret;
>>> +	size_t size;
>>>   
>>>   	fd = smh_open(filename, MODE_READ | MODE_BINARY);
>>>   	if (fd < 0)
>>> @@ -34,19 +35,19 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>>>   		return ret;
>>>   	}
>>>   	if (!maxsize) {
>>> -		size = smh_flen(fd);
>>> +		ret = smh_flen(fd, &size);
>>>   		if (ret < 0) {
>>>   			smh_close(fd);
>>> -			return size;
>>> +			return ret;
>>>   		}
>>>   
>>>   		maxsize = size;
>>>   	}
>>>   
>>> -	size = smh_read(fd, buffer, maxsize);
>>> +	ret = smh_read(fd, buffer, maxsize, &size);
>>>   	smh_close(fd);
>>> -	if (size < 0)
>>> -		return size;
>>> +	if (ret < 0)
>>> +		return ret;
>>>   
>>>   	*actread = size;
>>>   	return 0;
>>> @@ -78,17 +79,19 @@ static int smh_fs_write_at(const char *filename, loff_t pos, void *buffer,
>>>   
>>>   int smh_fs_size(const char *filename, loff_t *result)
>>>   {
>>> -	long fd, size;
>>> +	long fd;
>>> +	size_t size;
>>> +	int ret;
>>>   
>>>   	fd = smh_open(filename, MODE_READ | MODE_BINARY);
>>>   	if (fd < 0)
>>>   		return fd;
>>>   
>>> -	size = smh_flen(fd);
>>> +	ret = smh_flen(fd, &size);
>>>   	smh_close(fd);
>>>   
>>> -	if (size < 0)
>>> -		return size;
>>> +	if (ret < 0)
>>> +		return ret;
>>>   
>>>   	*result = size;
>>>   	return 0;
>>> diff --git a/include/semihosting.h b/include/semihosting.h
>>> index 4e844cbad87bb1ae6bb365f87f3e7a8aeea445f4..60535199b9532ce16620aea3ca1ea741c5b73766 100644
>>> --- a/include/semihosting.h
>>> +++ b/include/semihosting.h
>>> @@ -95,12 +95,12 @@ long smh_open(const char *fname, enum smh_open_mode mode);
>>>    * @fd: A file descriptor returned from smh_open()
>>>    * @memp: Pointer to a buffer of memory of at least @len bytes
>>>    * @len: The number of bytes to read
>>> + * @read_len: Pointer which will be updated with actual bytes read on success,
>>> + *  with 0 indicating %EOF
>>>    *
>>> - * Return:
>>> - * * The number of bytes read on success, with 0 indicating %EOF
>>> - * * A negative error on failure
>>> + * Return: 0 on success or negative error on failure
>>>    */
>>> -long smh_read(long fd, void *memp, size_t len);
>>> +long smh_read(long fd, void *memp, size_t len, size_t *read_len);
>>>   
>>>   /**
>>>    * smh_write() - Write data to a file
>>> @@ -124,10 +124,11 @@ long smh_close(long fd);
>>>   /**
>>>    * smh_flen() - Get the length of a file
>>>    * @fd: A file descriptor returned from smh_open()
>>> + * @size: Pointer which will be updated with length of file on success
>>>    *
>>> - * Return: The length of the file, in bytes, or a negative error on failure
>>> + * Return: 0 on success or negative error on failure
>>>    */
>>> -long smh_flen(long fd);
>>> +int smh_flen(long fd, size_t *size);
>>>   
>>>   /**
>>>    * smh_seek() - Seek to a position in a file
>>> diff --git a/lib/semihosting.c b/lib/semihosting.c
>>> index 9be5bffd30124777c4f8110065e6cca5640312ac..a0f42d41e4a7ad95023c684f6824bfc677ad25cd 100644
>>> --- a/lib/semihosting.c
>>> +++ b/lib/semihosting.c
>>> @@ -93,9 +93,9 @@ struct smh_rdwr_s {
>>>   	size_t len;
>>>   };
>>>   
>>> -long smh_read(long fd, void *memp, size_t len)
>>> +long smh_read(long fd, void *memp, size_t len, size_t *read_len)
> 
> But really we just need to make this return size_t.
> 
>>>   {
>>> -	long ret;
>>> +	size_t ret;
>>>   	struct smh_rdwr_s read;
>>>   
>>>   	debug("%s: fd %ld, memp %p, len %zu\n", __func__, fd, memp, len);
>>> @@ -105,9 +105,20 @@ long smh_read(long fd, void *memp, size_t len)
>>>   	read.len = len;
>>>   
>>>   	ret = smh_trap(SYSREAD, &read);
> 
> This is a separate fix. Please break it out into another patch.

OK. V4 coming.

Andrew

>>> -	if (ret < 0)
>>> +	if (!ret) {
>>> +		/* Success */
>>> +		*read_len = len;
>>> +		return 0;
>>> +	} else if (ret == len) {
>>> +		/* EOF */
>>> +		*read_len = 0;
>>> +		return 0;
>>> +	} else {
>>> +		/* Partial success */
>>> +		*read_len = len - ret;
>>>   		return smh_errno();
>>> -	return len - ret;
>>> +	}
>>> +
>>>   }
>>>   
>>>   long smh_write(long fd, const void *memp, size_t len, ulong *written)
>>> @@ -140,7 +151,7 @@ long smh_close(long fd)
>>>   	return 0;
>>>   }
>>>   
>>> -long smh_flen(long fd)
>>> +int smh_flen(long fd, size_t *size)
>>>   {
>>>   	long ret;
>>>   
>>> @@ -149,7 +160,9 @@ long smh_flen(long fd)
>>>   	ret = smh_trap(SYSFLEN, &fd);
>>>   	if (ret == -1)
> 
> Just change this to
> 
> 	if (ret < 0)
> 		return ret == -1 ? smh_errno() : -EOVERFLOW;
> 
> And now all the existing code works.
> 
>>>   		return smh_errno();
>>> -	return ret;
>>> +
>>> +	*size = (size_t)ret;
>>> +	return 0;
> 
>>>   }
>>>   
>>>   long smh_seek(long fd, long pos)
>>>
>>
>> There was (as good thing!) much review and feedback on v1 and v2. Is
>> everyone happy now with v3? Thanks!
>>
> 
> Sorry for the delay, I'm not working on U-Boot at $WORK at all right now
> so I don't have much time for review.
> 
> --Sean


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2E3C83F1B
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 11:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D30E783242;
	Thu, 17 Jul 2025 13:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UpkA7AoR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA877833CC; Thu, 17 Jul 2025 13:15:18 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0377382CBB
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 13:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so1010496f8f.0
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 04:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752750915; x=1753355715; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RHS8wStGCBoJjZheOIHP5fb45g9eLNjEgEewjZ2/LIc=;
 b=UpkA7AoR7cxFp6Dm924wdNMbCkZqSDkglYMdI4qLn4qDfhV4yxxBE9JRwdSKBtB9NC
 ZykYYTV5DpbGIM5QKGVKMoJmdqGhU0ejloITJaI3NOGqt9XObr80Fm2HH5NuW6lO4dvx
 UfLKJPo/xk0SBdfkfAVcapwcvz9rpSAOAuOumkQSYJb4KLZW8yFuW8VR7II0PWEb5UvR
 4JfNLS6zFl6sSW1A6wMtjVrf0jTwrqRtnmXF7DimfCUUborogNQ5rj7ejhpBe4SwltkU
 6O20cd9jx2Vjxuwb1ivxAqg6v87scvlLDWniqecnVdWTn5CvHdQMXckDISufEgEagW6G
 9Gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752750915; x=1753355715;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RHS8wStGCBoJjZheOIHP5fb45g9eLNjEgEewjZ2/LIc=;
 b=eeygnFcPGetaoZ/tWQIX//41KtsN2rvXm+ZDWk0NKpuR+x9y/bulCGcUmBhtWkjwpD
 vnBcaoum3QFlhO/eXcjSKpPUaagtMc0nZswiMSfdxi2TIINMCaIC8CB7Ays0peQqmuuo
 DN0vVkxIRUOH9LK9TP0E1TeB2dIqRwnVAVLI9upAiz52icPvYk9ktLRlsrgUWPv+7OK6
 tIpNhsv2N32mv/+PO6r2wxQ7+fDm3rjepUOYhACO9gHDDtTP8nse8GCep62KFmYNF30W
 PIOgekSJNe9eNBV+tjrZKRUS4wgXjrRYzgx6tnoVv4mGTVKTvjKklm+fNgk3UyRq5d3z
 MtDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8QLXZ6l6XhytY5k9W+heNp0WhiY9dGRN6ZtiQK+VNZ7aVH/KxNZiJH6YJvIoiIRpX1DuaLwk=@lists.denx.de
X-Gm-Message-State: AOJu0Ywx+Yq0oHn/FkN/7a6J9ePrkSnOa5TXChjrgpXpLFRcx02Wavw4
 VlnstKRoJM6rbDzdmrUQHJ8dcSSshChS+48co/ppEidc3+1jTX3jdEbbCqEw/aKex/s=
X-Gm-Gg: ASbGncv8SII3ac4r7fcmHy6biCApw7+obrCEq+f60m1NeAoIQBm5VMRvb9KUabt5/xF
 U/rO80vvP/xHsvZoN36yv61YZ1EiLqbpk7wTQPo0Ti4mvyX5GhGXWCk+A4qH2y7EmBm9D6aAEnb
 MBELudJAvtZk4HlzTiL+QoC4AsTtotsmKhBmFRq7/alNDSg1UbU2TtIxjlogDBzZErtGJPlXaKi
 2LM/1nQJEPc+sfW2W/EJlUyRDT9OWy812RtZM0SegqlOptFXWABDKiJC7nqe+I5+ck/YqsVOXAr
 p1ZS+NUDuY6yL9nMAUZDmU1RDnwHwugMh7grWdGnn/j+9CF6OBRbHI2m+u2Dbfh5Oh8vKwk9pSu
 oTPknwal4OZsmSt7rUyCJL6TZ5pYo3xlQD4kRaBOSvz9iLIJlv+1oXM5d6Qakcqu4IKGTH9BMo8
 hfnw==
X-Google-Smtp-Source: AGHT+IEVE2ygOhMY7HFt8UiwkAqxqfNOuse9/mbdytu6agRuksJ5b8pS17HAuxeokRHNpQP/bu8VRQ==
X-Received: by 2002:a05:6000:2087:b0:3a5:1241:afde with SMTP id
 ffacd0b85a97d-3b613ab2ca0mr2424271f8f.9.1752750915187; 
 Thu, 17 Jul 2025 04:15:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:eb9:1701:f497:a590:bf80:45c8?
 ([2a0a:ef40:eb9:1701:f497:a590:bf80:45c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d289sm20771116f8f.55.2025.07.17.04.15.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 04:15:14 -0700 (PDT)
Message-ID: <6ead3248-7eb7-419c-a657-c53855113822@linaro.org>
Date: Thu, 17 Jul 2025 12:15:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Remove blk_find_first/next
To: Greg Malysa <malysagreg@gmail.com>, u-boot@lists.denx.de
Cc: Alexey Romanov <avromanov@salutedevices.com>, Heiko Schocher
 <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250717102012.10018-1-malysagreg@gmail.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250717102012.10018-1-malysagreg@gmail.com>
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

On 17/07/2025 11:19, Greg Malysa wrote:
> In [0], Andrew noted a code quality issue in the implementation of
> blk_find_first and blk_find_next. This led to the observation that the
> logic of these functions was also likely incorrect, and based on a quick
> check it seemed the functions were unused outside of test code, which
> did not exercise the potential failure case, so we felt they should be
> removed. In [1], a test patch which illustrates the failure in sandbox
> is provided for reference.
> 
> Because a more thorough check agrees that these functions are unused,
> they are currently incorrect, and fixed/removable flags on block devices
> prior to probe are unreliable, just remove these functions instead of
> fixing them. All potential users should have used blk_first_device_err
> instead anyway.
> 
> CI results at [2].
> 
> [0] https://patchwork.ozlabs.org/project/uboot/patch/20250714-blk-uclass-v1-1-d21428c5f762@linaro.org/
> [1] https://gist.github.com/gmalysa/b05e73a5c14bc18c5741a0e0e06a2992
> [2] https://gitlab.com/gmalysa/lnxdsp-u-boot/-/pipelines/1931210857
> 
> Signed-off-by: Greg Malysa <malysagreg@gmail.com>
> 
> ---
> 
>   drivers/block/blk-uclass.c | 24 --------------------
>   include/blk.h              | 45 -------------------------------------
>   test/dm/blk.c              | 46 +++-----------------------------------
>   3 files changed, 3 insertions(+), 112 deletions(-)
> 
> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
> index f3ac8db9464..73c24fd9176 100644
> --- a/drivers/block/blk-uclass.c
> +++ b/drivers/block/blk-uclass.c
> @@ -611,30 +611,6 @@ static int blk_flags_check(struct udevice *dev, enum blk_flag_t req_flags)
>   	return flags & req_flags ? 0 : 1;
>   }
>   
> -int blk_find_first(enum blk_flag_t flags, struct udevice **devp)
> -{
> -	int ret;
> -
> -	for (ret = uclass_find_first_device(UCLASS_BLK, devp);
> -	     *devp && !blk_flags_check(*devp, flags);
> -	     ret = uclass_find_next_device(devp))
> -		return 0;
> -
> -	return -ENODEV;
> -}
> -
> -int blk_find_next(enum blk_flag_t flags, struct udevice **devp)
> -{
> -	int ret;
> -
> -	for (ret = uclass_find_next_device(devp);
> -	     *devp && !blk_flags_check(*devp, flags);
> -	     ret = uclass_find_next_device(devp))
> -		return 0;
> -
> -	return -ENODEV;
> -}
> -
>   int blk_first_device_err(enum blk_flag_t flags, struct udevice **devp)
>   {
>   	for (uclass_first_device(UCLASS_BLK, devp);
> diff --git a/include/blk.h b/include/blk.h
> index 488d04cf32a..8d1b70cabd3 100644
> --- a/include/blk.h
> +++ b/include/blk.h
> @@ -781,51 +781,6 @@ int blk_first_device_err(enum blk_flag_t flags, struct udevice **devp);
>    */
>   int blk_next_device_err(enum blk_flag_t flags, struct udevice **devp);
>   
> -/**
> - * blk_find_first() - Return the first matching block device
> - * @flags: Indicates type of device to return
> - * @devp:	Returns pointer to device, or NULL on error
> - *
> - * The device is not prepared for use - this is an internal function.
> - * The function uclass_get_device_tail() can be used to probe the device.
> - *
> - * Note that some devices are considered removable until they have been probed
> - *
> - * @return 0 if found, -ENODEV if not found
> - */
> -int blk_find_first(enum blk_flag_t flags, struct udevice **devp);
> -
> -/**
> - * blk_find_next() - Return the next matching block device
> - * @flags: Indicates type of device to return
> - * @devp: On entry, pointer to device to lookup. On exit, returns pointer
> - * to the next device in the same uclass, or NULL if none
> - *
> - * The device is not prepared for use - this is an internal function.
> - * The function uclass_get_device_tail() can be used to probe the device.
> - *
> - * Note that some devices are considered removable until they have been probed
> - *
> - * @return 0 if found, -ENODEV if not found
> - */
> -int blk_find_next(enum blk_flag_t flags, struct udevice **devp);
> -
> -/**
> - * blk_foreach() - iterate through block devices
> - *
> - * This creates a for() loop which works through the available block devices in
> - * order from start to end.
> - *
> - * If for some reason the uclass cannot be found, this does nothing.
> - *
> - * @_flags: Indicates type of device to return
> - * @_pos: struct udevice * to hold the current device. Set to NULL when there
> - * are no more devices.
> - */
> -#define blk_foreach(_flags, _pos) \
> -	for (int _ret = blk_find_first(_flags, &_pos); !_ret && _pos; \
> -	     _ret = blk_find_next(_flags, &_pos))
> -
>   /**
>    * blk_foreach_probe() - Helper function to iteration through block devices
>    *
> diff --git a/test/dm/blk.c b/test/dm/blk.c
> index aa5cbc63777..1b928b27d9c 100644
> --- a/test/dm/blk.c
> +++ b/test/dm/blk.c
> @@ -229,30 +229,7 @@ static int dm_test_blk_flags(struct unit_test_state *uts)
>   {
>   	struct udevice *dev;
>   
> -	/* Iterate through devices without probing them */
> -	ut_assertok(blk_find_first(BLKF_BOTH, &dev));
> -	ut_assertnonnull(dev);
> -	ut_asserteq_str("mmc2.blk", dev->name);
> -
> -	ut_assertok(blk_find_next(BLKF_BOTH, &dev));
> -	ut_assertnonnull(dev);
> -	ut_asserteq_str("mmc1.blk", dev->name);
> -
> -	ut_assertok(blk_find_next(BLKF_BOTH, &dev));
> -	ut_assertnonnull(dev);
> -	ut_asserteq_str("mmc0.blk", dev->name);
> -
> -	ut_asserteq(-ENODEV, blk_find_next(BLKF_BOTH, &dev));
> -	ut_assertnull(dev);
> -
> -	/* All devices are removable until probed */
> -	ut_asserteq(-ENODEV, blk_find_first(BLKF_FIXED, &dev));
> -
> -	ut_assertok(blk_find_first(BLKF_REMOVABLE, &dev));
> -	ut_assertnonnull(dev);
> -	ut_asserteq_str("mmc2.blk", dev->name);
> -
> -	/* Now probe them and iterate again */
> +	/* Probe and look through block devices */
>   	ut_assertok(blk_first_device_err(BLKF_BOTH, &dev));
>   	ut_assertnonnull(dev);
>   	ut_asserteq_str("mmc2.blk", dev->name);
> @@ -289,30 +266,13 @@ static int dm_test_blk_flags(struct unit_test_state *uts)
>   }
>   DM_TEST(dm_test_blk_flags, UTF_SCAN_PDATA | UTF_SCAN_FDT);
>   
> -/* Test blk_foreach() and friend */
> +/* Test blk_foreach_probe() */
>   static int dm_test_blk_foreach(struct unit_test_state *uts)
>   {
>   	struct udevice *dev;
>   	int found;
>   
> -	/* Test blk_foreach() - use the 3rd bytes of the name (0/1/2) */
> -	found = 0;
> -	blk_foreach(BLKF_BOTH, dev)
> -		found |= 1 << dectoul(&dev->name[3], NULL);
> -	ut_asserteq(7, found);
> -
> -	/* All devices are removable until probed */
> -	found = 0;
> -	blk_foreach(BLKF_FIXED, dev)
> -		found |= 1 << dectoul(&dev->name[3], NULL);
> -	ut_asserteq(0, found);
> -
> -	found = 0;
> -	blk_foreach(BLKF_REMOVABLE, dev)
> -		found |= 1 << dectoul(&dev->name[3], NULL);
> -	ut_asserteq(7, found);
> -
> -	/* Now try again with the probing functions */
> +	/* The test device tree has two fixed and one removable block device(s) */
>   	found = 0;
>   	blk_foreach_probe(BLKF_BOTH, dev)
>   		found |= 1 << dectoul(&dev->name[3], NULL);

Reviewed-by: Andrew Goodbody <andrew.goodbody@linaro.org>

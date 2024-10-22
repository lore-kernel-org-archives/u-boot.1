Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2AFCDD0DD
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 19:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AF3688FA7;
	Tue, 22 Oct 2024 21:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XXa/xKpY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E963E88F4B; Tue, 22 Oct 2024 21:58:18 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C192788FA7
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 21:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4315855ec58so9761115e9.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 12:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729627095; x=1730231895; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dTyVuN+YOaLpv6/9rMX2eBRc0dnw178zzFQHnZiZbcE=;
 b=XXa/xKpYQ4/YqBmzEynmTY72GhNS5z+oKlq5aBQyLgHXQ7h9gSeK7RvPR4sP6dqqb2
 WKzvMjUSSMiA5kb7k6J9sdK7dnHMaP6Ho2IE1JeEvtQXBjaaRT/9vJa3QIKikljezZLL
 UhMdt2Biu/5LFomVAIlriGOyzCueQzU8gggp+pd5zTTrvq45gT/xpqomITMFKgcoT7io
 44r4xSAvq+bttgTBaGv80/q2CIaQPb6hncRcbb/xr209fxqQh7eLyb2FHfMop+MpAFTk
 qyr30BsWigqZ/MbuCbBsBp5RK3zCQzpZJCK7Jrlae7x0ZP0yPiD5YdRA2NmHsybfHMEL
 O0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729627095; x=1730231895;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dTyVuN+YOaLpv6/9rMX2eBRc0dnw178zzFQHnZiZbcE=;
 b=r9xZL8UyGtVEbmqLo+THtaiV/AhBElz4IU7uu47I7WgH9CfbZ0S6e22KDdeuhrug5J
 hj8DxLVU050Jyune+PhJAguyxqM9r+FVTVJQIfVbsbeFJx7qb7kpk/CfbRM27QOy2NjU
 F8RLBAyTFJWnEGe6h2XexN7vJVMgWFIoENK9Kxn2zVMfEH/jtaxnSdh86Z1N77o4Rcvf
 XZiTGX1dCIjxUJKyZW6ht2rXcAom85UTkaSGGwqMvpnmAeJdid7FqZYGBCHVjo6cAPZH
 sSLl0xi8FjiJ4kQlaBhqRZxuefPababKIo/NYv9q6q5mMxN+84HO+kIzErIGLlj2M9S/
 G7zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0aP64Am5IFrp253vDIv0zgncMNH4IwI7EfhrOm4Xgy7mfkjypRokhc3IhKxfhwvGlim5X32w=@lists.denx.de
X-Gm-Message-State: AOJu0YyO6FjC5MCLt+XsOCa6rv+QBtK8QExNF3UNgJB9VyCVM1KFtJMv
 o5nxOYQ2EPJRr602qGZaHy/kj2xS0TNLulD1icD95O7SFYs6d094
X-Google-Smtp-Source: AGHT+IEMocnRzPYFLx99sJle91ybPMt5eMU5myqOnVl9mUYhXQELaG5pOP+nDcUFdUrZr2aysMbgaw==
X-Received: by 2002:a5d:59a2:0:b0:37d:487e:4d9d with SMTP id
 ffacd0b85a97d-37efcf1c1cbmr26620f8f.8.1729627094905; 
 Tue, 22 Oct 2024 12:58:14 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66c725d1sm3594104a12.84.2024.10.22.12.58.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 12:58:13 -0700 (PDT)
Message-ID: <1b23c91e-df7e-42ad-bf3b-b62138c07c98@gmail.com>
Date: Tue, 22 Oct 2024 21:58:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rockchip: block: simplify rkmtd driver
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Heiko Schocher <hs@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
References: <20241018013015.127620-1-heinrich.schuchardt@canonical.com>
 <20241018013015.127620-2-heinrich.schuchardt@canonical.com>
 <4aef209c-cbed-4fac-b48a-4101e27e64f8@gmail.com>
 <CAFLszTgt_5rpKg2XUW_h5_AU5zYssiO7cLtTEaz8w0_Q8zVh4A@mail.gmail.com>
 <8bc4173f-ceb1-491f-bbdb-507a9ca96642@canonical.com>
Content-Language: en-US
From: Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <8bc4173f-ceb1-491f-bbdb-507a9ca96642@canonical.com>
Content-Type: text/plain; charset=UTF-8
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



On 10/21/24 15:35, Heinrich Schuchardt wrote:
> On 10/19/24 13:50, Simon Glass wrote:
>> Hi Johan,
>>
>> On Fri, 18 Oct 2024 at 07:33, Johan Jonker <jbx6244@gmail.com> wrote:
>>>
>>>
>>>
>>> On 10/18/24 03:30, Heinrich Schuchardt wrote:
>>>> By using blk_create_devicef() instead of blk_create_devicef() the driver
>>>> can be simplified and brought into line with other block device drivers.
>>>>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---

Tested-by: Johan Jonker <jbx6244@gmail.com>

>>>>   drivers/block/rkmtd.c | 21 ++-------------------
>>>>   1 file changed, 2 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/block/rkmtd.c b/drivers/block/rkmtd.c
>>>> index c55f052e51b..f84cacd7ead 100644
>>>> --- a/drivers/block/rkmtd.c
>>>> +++ b/drivers/block/rkmtd.c
>>>> @@ -794,36 +794,19 @@ int rkmtd_init_plat(struct udevice *dev)
>>>>        return 0;
>>>>   }
>>>>
>>>> -static void rkmtd_blk_kmalloc_release(struct udevice *dev, void *res)
>>>> -{
>>>> -     /* noop */
>>>> -}
>>>> -
>>>>   static int rkmtd_bind(struct udevice *dev)
>>>>   {
>>>>        struct rkmtd_dev *plat = dev_get_plat(dev);
>>>> -     char dev_name[30], *str;
>>>>        struct blk_desc *desc;
>>>>        struct udevice *bdev;
>>>>        int ret;
>>>>
>>>> -     snprintf(dev_name, sizeof(dev_name), "%s.%s", dev->name, "blk");
>>>> -
>>>
>>>> -     str = devres_alloc(rkmtd_blk_kmalloc_release, strlen(dev_name) + 1, GFP_KERNEL);
>>>
>>> Hi Heinrich, Simon,
>>>
>>> The function strdup() is not an exact replacement for the devres_alloc() function in relation to a device.
>>> It is in use for memory leak detection / device resource management.
>>> Not sure what the status of that devres project currently is? Also tracking in general in relation to EFI and blk-class.
>>>
>>> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/block/blk-uclass.c?ref_type=heads#L739
>>>
>>> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/block/rkmtd.c?ref_type=heads#L812
>>>
>>> Test for this driver are based on work done by Simon.
>>> https://source.denx.de/u-boot/u-boot/-/blob/master/test/dm/host.c?ref_type=heads#L71
>>>
>>> This rkmtd driver makes use of devm_kzalloc(). All the memory that rkmtd reserves is freed.
>>> But if I remember well somehow I was not able to free all memory on unbind and was not able to find the source, so I didn't include that last test.
>>> https://elixir.bootlin.com/u-boot/v2024.10/source/test/dm/rkmtd.c#L84
>>
>> Yes, you can use that API. But I think Heinrich's patch is correct,
>> and separate from your points here. Yes, blk_create_devicef()
>> strdup()s the name, but it sets a flag indicating that it has done so.
>> Then device_unbind() checks DM_FLAG_NAME_ALLOCED later. So the code
>> should be equivalent.
>>

>> Re the memory leak, I don't have any ideas, but test/dm/devres.c does
>> have some checks for some of that. I have often wondered about having
>> a way to store the filename and line (or just the line?) with every
>> allocation, so we can list out what is left at the end, since valgrind
>> doesn't work on target devices.

Please have a look at a little test patch below.
I'm out of ideas. All I reserve for RKMTD as memory is freed I think.
Also replaced a second devres_alloc() function with strdup() with the some result.
The difference with the host device is that it adds an GPT/EFI partition.
Maybe it add a few bytes while parsing the partitions?
Anyone able verify a partition on other block devices then RKMTD in a test?

Johan


>>
>> Regards,
>> Simon
> 
> Hello Johan,
> 
> I hope that Simon's comment clarifies how freeing the string resource works.
> 
> Do you have a device to test this patch?
> 
> Best regards
> 
> Heinrich

From b767850c66e51b4b4d2b8f9f9d314dd430b9a8d0 Mon Sep 17 00:00:00 2001
From: Johan Jonker <jbx6244@gmail.com>
Date: Tue, 22 Oct 2024 20:12:37 +0200
Subject: [PATCH v1] RKMTD memory leak test

To reproduce:
git clone --depth 1 https://source.denx.de/u-boot/u-boot.git
make sandbox_defconfig
make

./u-boot -T -c "ut dm dm_test_rkmtd"

Test: dm_test_rkmtd: rkmtd.c (flat tree)
test/dm/rkmtd.c:95, dm_test_rkmtd(): report:
mem_start: 2844096
mem_test1: 3374736
mem_exit: 2844128
diff: 32

Or inside U-boot:
./u-boot

ut dm dm_test_rkmtd

Test: dm_test_rkmtd: rkmtd.c (flat tree)
test/dm/rkmtd.c:95, dm_test_rkmtd(): report:
mem_start: 113040
mem_test1: 643824
mem_exit: 113216
diff: 176
---
 test/dm/rkmtd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/test/dm/rkmtd.c b/test/dm/rkmtd.c
index d1ca5d1acacb..ba8e211f60a2 100644
--- a/test/dm/rkmtd.c
+++ b/test/dm/rkmtd.c
@@ -29,11 +29,14 @@ static int dm_test_rkmtd(struct unit_test_state *uts)
 	struct rkmtd_dev *plat;
 	struct blk_desc *desc;
 	struct sector0 *sec0;
+	ulong mem_start, mem_exit, mem_test1;
 	int i;
 
 	ut_asserteq(-ENODEV, uclass_first_device_err(UCLASS_RKMTD, &dev));
 	ut_asserteq(-ENODEV, uclass_first_device_err(UCLASS_PARTITION, &part));
 
+	mem_start = ut_check_delta(0);
+
 	ut_assertok(rkmtd_create_device(label, &dev));
 
 	/* Check that the plat data has been allocated */
@@ -78,11 +81,19 @@ static int dm_test_rkmtd(struct unit_test_state *uts)
 	ut_asserteq(12, blk_dread(desc, 64, 12, read));
 	ut_asserteq_mem(write, read, RW_BUF_SIZE);
 
+	mem_test1 = ut_check_delta(0);
+
 	ut_assertok(rkmtd_detach(dev));
 
 	ut_asserteq(-ENODEV, blk_get_from_parent(dev, &blk));
 	ut_assertok(device_unbind(dev));
 
+	/* check there were no memory leaks */
+	//ut_asserteq(0, ut_check_delta(mem_start));
+
+	mem_exit = ut_check_delta(0);
+	ut_reportf("\nmem_start: %lu\nmem_test1: %lu\nmem_exit: %lu\ndiff: %lu\n", mem_start, mem_test1, mem_exit, mem_exit - mem_start);
+
 	return 0;
 }
 DM_TEST(dm_test_rkmtd, UTF_SCAN_FDT);
-- 
2.39.2

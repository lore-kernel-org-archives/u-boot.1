Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01713CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 21:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F26E839B1;
	Wed,  8 Oct 2025 23:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XLXPVBhD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80201839B7; Wed,  8 Oct 2025 23:23:26 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 637938394A
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 23:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 743963F6B1
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 21:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1759958602;
 bh=oSL4/vbYKP7g9zL5zmEUP9H4dAx+yg0xND+MLqJHr40=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=XLXPVBhD52ItVtA0JabybbQCU7cOmEJQYHc0exf+oROHukgs39qLluxm3XpSEU9nz
 yBc8/Vk870zK+CaM/4LTGYcvS1lX+yLsG5THCFGu/CQzvmG5skizqpqgzu1pZePSE9
 7UMJn/7x9UT4JuhcJgd4+J9ntUas16TJ96kRhIAfmjRIvXwP6MdkMZrRfP8aTR/aV9
 BCTAuzMeBC6yjD54qOr7tY1yQkrOLOqa35tePlxVE34fGpy2BZgrbq8/pFRmHCzk4V
 Gc7Hc3uCs3SGnSuUS72u/2QhCyre6XfpUeafLLe1rU3b5We/kl31qlcF120RpI1/DI
 3XdiBtqnA7Zm8bysyeceLpMF1eNqWSANL9T6dBeDI4eXuvtiieBvoS7fNaIQ8UfgdH
 hod4wC1xsfEJ9bBAn+attEN7C10gzHzh4cV56rv4atYcxHHUrykPB7OC5yNjpoD9NO
 FFDMsZIrfdOW2u5sbo6TqV/M3tnp4QS/G7L3+q5AmvRyTxKlhJToTy6WNGSJ3fttWu
 8c9vFeS62wRItrINtQoYbG8wblbun4dENvXqiT6Iy6l5rrgOPXtQWQkfsdGR3khmFz
 s/YREKG2wqtXyCZAcOZrPeo1AjsMExp2q30BQ0o3QBM48MZ54zkjW4sd8ZjKLgq4iA
 yAr9Z3WUsvsRSQElyYwek0Lo=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ecdf7b5c46so217457f8f.2
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 14:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759958602; x=1760563402;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oSL4/vbYKP7g9zL5zmEUP9H4dAx+yg0xND+MLqJHr40=;
 b=vCeWXBzFwaIuUWm8FrQ3UFqrucCV7J5DN5WgDTwWNwJ4l8B+4Ate2hai8K69NO2SdF
 n3yN5cu6m204Zy/ug2i9+It33xF2REJjQzdye9tON2gdvMUIurOJuhYGulrZSDsr/zzg
 aUIyK3exlFe3gDff1qhBulyTbnpTbyo7bfkBtoGT09FFoS9Tw1q6AWqHbpfzkwqeInHj
 RQQE/feOY5ol9OXhDKt4ljPlvdw5eioMVsbW27GDnVxqhEMgEtmgoH8Fws6MjY8pN7w/
 3NC7wfITv93qNYgfwN3lCmmon84jEZxjwsosR9JPe7J7pP3pT6MYP/moK1V5dAdWnYH0
 vcQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxEb1UFMCjPUt4SvI5JZKTOzuc/+7TV+MouHSGW5peU5Or8AJpQXibw30f4XHKPOoxDHBOwHg=@lists.denx.de
X-Gm-Message-State: AOJu0YwLACx1qp1wYATvXSni2bYkdOiJwWgJVeyU7JBbdH8neOMJsb2o
 0kXhUuV8JEVVW/a5e8MkL3VyWrHzzcofNrjQorAMcjRVUgY7SzmbWjYJUl2yuoTim75tlDXw7W3
 GgtbimcilNZRuQi6ma2AlcQdwoPASLtWCYWQvt21xPTiXjZGi1ZCqEqcaLTdWL+WiJg5hHn0=
X-Gm-Gg: ASbGncv89RlWu9Gn2O3fdyHwQErorKl6ab6C5WWUL0zyjytsy36hZTfWkySPvuhJ1ey
 WXqPF1Cpm6vSkl2JYjzrMz20jSgLfyDX6vTV1c4kKyjqNuzdslPRRa/aOllBeBmrlC543BG7XsZ
 JZphNLBVk8D5c6/gLJ3R19B4WfSJpsQtJtFyW9q/3nVRxyUanTb93xn4wJqplnnk1WScBKbEAUB
 0etuS5EZxur6feT3PQkxdRA/oXWcaO5dwbWEDYVx36Nn2yRvlWjKKlkiglZwFFc3Wjsj86aEofS
 qcTVlXH5rlF8h8OyYdMUkXGs3Omw74FRlqeqSO9x2opFLaaZTcFiecWE59MFNocFr7Jj4IQNaX1
 ZEn9+dHhR6Uc8UWlti+ccmHmQieCnyJa9nqOVdaL1wC0=
X-Received: by 2002:a05:6000:25c3:b0:3ec:e276:f3d5 with SMTP id
 ffacd0b85a97d-4266e8dabeamr3022979f8f.42.1759958601795; 
 Wed, 08 Oct 2025 14:23:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH7LnyJGmZ5gFGTxkSZpDKFHkNmmv93m4XfIL7DHUHHfqXqfxcGGIjMLxVpUYWtnFwx5GOrA==
X-Received: by 2002:a05:6000:25c3:b0:3ec:e276:f3d5 with SMTP id
 ffacd0b85a97d-4266e8dabeamr3022963f8f.42.1759958601313; 
 Wed, 08 Oct 2025 14:23:21 -0700 (PDT)
Received: from [192.168.103.116]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8b005dsm31090216f8f.25.2025.10.08.14.23.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 14:23:19 -0700 (PDT)
Message-ID: <6c36ea4b-a812-4fba-a72e-f2f951f07caa@canonical.com>
Date: Wed, 8 Oct 2025 23:23:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] virtio: blk: support block sizes exceeding 512
 bytes
To: Andre Przywara <andre.przywara@arm.com>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Tom Rini <trini@konsulko.com>, Cody Schuffelen <schuffelen@google.com>,
 Dmitrii Merkurev <dimorinny@google.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Debbie Horsfall <Debbie.Horsfall@arm.com>
References: <20250830203954.25775-1-heinrich.schuchardt@canonical.com>
 <20251008163954.6da0f778@donnerap.manchester.arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251008163954.6da0f778@donnerap.manchester.arm.com>
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

On 10/8/25 17:39, Andre Przywara wrote:
> On Sat, 30 Aug 2025 22:39:54 +0200
> Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
> 
> Hi Heinrich,
> 
>> QEMU allows to specify the logical block size via parameter
>> logical_block_size of a virtio-blk-device.
>>
>> The communication channel via virtqueues remains based on 512 byte blocks
>> even if the logical_block_size is larger.
>>
>> Consider the logical block size in the block device driver.
>>
>> Reported-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>> 	remove superfluous include linux/err.h
>> ---
>>   drivers/virtio/virtio_blk.c | 25 ++++++++++++++++++++++---
>>   1 file changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
>> index 2f999fc8bbe..4224e3c17f4 100644
>> --- a/drivers/virtio/virtio_blk.c
>> +++ b/drivers/virtio/virtio_blk.c
>> @@ -12,10 +12,17 @@
>>   #include <virtio_types.h>
>>   #include <virtio.h>
>>   #include <virtio_ring.h>
>> +#include <linux/log2.h>
>>   #include "virtio_blk.h"
>>   
>> +/**
>> + * struct virtio_blk_priv - private date for virtio block device
>> + */
>>   struct virtio_blk_priv {
>> +	/** @virtqueue - virtqueue to process */
>>   	struct virtqueue *vq;
>> +	/** @blksz_shift - log2 of block size divided by 512 */
>> +	u32 blksz_shift;
>>   };
>>   
>>   static const u32 feature[] = {
>> @@ -71,6 +78,8 @@ static ulong virtio_blk_do_req(struct udevice *dev, u64 sector,
>>   	u8 status;
>>   	int ret;
>>   
>> +	sector <<= priv->blksz_shift;
>> +	blkcnt <<= priv->blksz_shift;
>>   	virtio_blk_init_header_sg(dev, sector, type, &out_hdr, &hdr_sg);
>>   	sgs[num_out++] = &hdr_sg;
>>   
>> @@ -109,7 +118,7 @@ static ulong virtio_blk_do_req(struct udevice *dev, u64 sector,
>>   		;
>>   	log_debug("done\n");
>>   
>> -	return status == VIRTIO_BLK_S_OK ? blkcnt : -EIO;
>> +	return status == VIRTIO_BLK_S_OK ? blkcnt >> priv->blksz_shift : -EIO;
>>   }
>>   
>>   static ulong virtio_blk_read(struct udevice *dev, lbaint_t start,
>> @@ -177,15 +186,25 @@ static int virtio_blk_probe(struct udevice *dev)
>>   	struct blk_desc *desc = dev_get_uclass_plat(dev);
>>   	u64 cap;
>>   	int ret;
>> +	u32 blk_size;
>>   
>>   	ret = virtio_find_vqs(dev, 1, &priv->vq);
>>   	if (ret)
>>   		return ret;
>>   
>> -	desc->blksz = 512;
>> -	desc->log2blksz = 9;
>>   	virtio_cread(dev, struct virtio_blk_config, capacity, &cap);
>>   	desc->lba = cap;
>> +	if (!virtio_has_feature(dev, VIRTIO_BLK_F_BLK_SIZE)) {
> 
> Is that actually the right condition check? I would assume that we only
> query the blk_size field if the feature bit is *set*, not when it's
> cleared?
> We see a failure (virtio block device not registering), because blk_size is
> 0 on the Arm FVP fast model, which is fine I think because the feature bit
> is clear as well.
> 
> Cheers,
> Andre

Hello Andre,

Thanks for sharing your test results.

Looking at these QEMU lines, I think the evaluated feature flag is correct:

pc-bios/s390-ccw/virtio.h:163:
uint32_t blk_size; /* block size of device (if VIRTIO_BLK_F_BLK_SIZE) */

include/standard-headers/linux/virtio_blk.h:72-73:
/* block size of device (if VIRTIO_BLK_F_BLK_SIZE) */
__virtio32 blk_size;

virtio_has_feature() cannot detect a feature if is not in the feature 
set of the U-Boot driver. See function virtio_uclass_child_pre_probe():

     uc_priv->features = driver_features_legacy & device_features;

VIRTIO_BLK_F_BLK_SIZE is missing in the feature set of virtio_blk.
The not in front of virtio_has_feature() is wrong.

Could you, please, retest with this diff:

diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
index 4224e3c17f4..ec2e28b54f7 100644
--- a/drivers/virtio/virtio_blk.c
+++ b/drivers/virtio/virtio_blk.c
@@ -26,6 +26,7 @@ struct virtio_blk_priv {
  };

  static const u32 feature[] = {
+       VIRTIO_BLK_F_BLK_SIZE,
         VIRTIO_BLK_F_WRITE_ZEROES
  };

@@ -194,7 +195,7 @@ static int virtio_blk_probe(struct udevice *dev)

         virtio_cread(dev, struct virtio_blk_config, capacity, &cap);
         desc->lba = cap;
-       if (!virtio_has_feature(dev, VIRTIO_BLK_F_BLK_SIZE)) {
+       if (virtio_has_feature(dev, VIRTIO_BLK_F_BLK_SIZE)) {
                 virtio_cread(dev, struct virtio_blk_config, blk_size, 
&blk_size);
                 desc->blksz = blk_size;
                 if (!is_power_of_2(blk_size) || desc->blksz < 512)

Best regards

Heinrich

> 
>> +		virtio_cread(dev, struct virtio_blk_config, blk_size, &blk_size);
>> +		desc->blksz = blk_size;
>> +		if (!is_power_of_2(blk_size) || desc->blksz < 512)
>> +			return -EIO;
>> +	} else {
>> +		desc->blksz = 512;
>> +	}
>> +	desc->log2blksz = LOG2(desc->blksz);
>> +	priv->blksz_shift = desc->log2blksz - 9;
>> +	desc->lba >>= priv->blksz_shift;
>>   
>>   	return 0;
>>   }
> 


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A606F43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEACA83EEF;
	Fri, 17 Apr 2026 14:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernkonzept.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernkonzept.com header.i=@kernkonzept.com header.b="DYQATC8U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 588F7842B7; Fri, 17 Apr 2026 14:11:18 +0200 (CEST)
Received: from mx.kernkonzept.com (serv1.kernkonzept.com
 [IPv6:2a01:4f8:1c1c:b490::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 666B384297
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=kernkonzept.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=christian.poetzsch@kernkonzept.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
 Reply-To:Content-ID:Content-Description;
 bh=1ygcX85eAkW0DCOaJyRjB7RgfJssFZnvvzrp6NYdFBA=; b=DYQATC8U3frOQ1HksAM4hbE7VM
 HWHRrj8nrD3warP8b3rRkLvLxhQ1MORQgbFLypF8p4GGZj85ZDqoQcllHIb5P+XV2NO4SpXVnBvc6
 GlCLUcO7RNAcBBfQDSs/D4phAVSlwr4j8D9HuWAYu28j3dYvshMGCkdnUktt3+L0rFQsA0IOoo4P3
 ta8dkFferDdjwv3/rdrlNUCrYcnnvfL29GKvxqv8KK8sUMQItQhnurH4m7rk8UXre8NYZye0l1c04
 H9YT+EJZ9Wc9xqgoSUmdRLOtcJ4yK0bo3/ACPlzRhJCE8JLbVwOHQr9/aZLVwTFtcSUg56ufpSJiJ
 GraOwrZA==;
Received: from [10.22.3.169] by mx.kernkonzept.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim 4.98.2)
 id 1wDi2V-0000000GUgw-0F9D; Fri, 17 Apr 2026 14:11:15 +0200
Message-ID: <a0029e8e-523c-4f02-b5af-c8242df4cf60@kernkonzept.com>
Date: Fri, 17 Apr 2026 14:11:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: add support for SIZE_MAX & SEG_MAX features
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng
 <bmeng.cn@gmail.com>, Adam Lackorzynski <adam@l4re.org>
References: <20260327081858.311591-1-christian.poetzsch@kernkonzept.com>
 <CAFLszTjKtFM6RXE_ZoEFbpW1ZGPtLCcqzJeceaLGPYoTfGA9vQ@mail.gmail.com>
 <20260408191244.GA837666@bill-the-cat>
Content-Language: en-US
From: =?UTF-8?Q?Christian_P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>
Autocrypt: addr=christian.poetzsch@kernkonzept.com; keydata=
 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
 T5WSo993xA==
In-Reply-To: <20260408191244.GA837666@bill-the-cat>
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

Hi all,

On 4/8/26 9:12 PM, Tom Rini wrote:
> On Thu, Apr 02, 2026 at 01:41:11PM -0600, Simon Glass wrote:
>> Hi Christian,
>>
>> On 2026-03-27T08:18:58, Christian Pötzsch
>> <christian.poetzsch@kernkonzept.com> wrote:
>>> virtio: add support for SIZE_MAX & SEG_MAX features
>>> virtio: add support for SIZE_MAX & SEG_MAX features
>>>
>>> Some virtio implementations may forward the virtio requests directly to
>>> the underlying hw. The hw may have some restrictions in how many and how
>>> big the requests can be. Therefore, the corresponding virtio device will
>>> announce this limitations with the SIZE_MAX & SEG_MAX feature.
>>>
>>> Add support for those features. Split an io request into multiple virtio
>>> requests if more than seg_max segments would be used. Also split a
>>> single buffer request into multiple segments if the buffer is bigger
>>> then size_max.
>>>
>>> Signed-off-by: Christian Pötzsch <christian.poetzsch@kernkonzept.com>
>>> Signed-off-by: Adam Lackorzynski <adam@l4re.org>
>>
>>> diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
>>> @@ -119,7 +145,38 @@ static ulong virtio_blk_do_req(...)
>>> +err_free:
>>> +     for (i = 0; i < seg_cnt + 2; ++i)
>>> +             free(sgs[i]);
>>> +     free(sgs);
>>> +
>>> +     return status == VIRTIO_BLK_S_OK ? blkcnt : -EIO;
>>
>> The err_free label is reached from both the success path (fall-through
>> after virtqueue_get_buf()) and error paths (goto from malloc()
>> failure, virtqueue_add() failure, or unknown type). On error paths,
>> status is uninitialised, so the final check has undefined behaviour.
>> Please can you separate the success path from the error cleanup, e.g.
>> with an explicit return before the err_free label.
Right, the error case is not well defined. However, I can't return before the label, because than the two segments are leaked. At this point the virtio operation has finished, so the segment pointers need to be freed. In v2, I did initialize the status to error instead. Now, the error case is well defined too.

>>
>>> diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
>>> @@ -145,38 +145,38 @@ static ulong virtio_blk_do_req(...)
>>> +     while (i < blkcnt) {
>>> +             u32 blk_per_sg = min(blkcnt - i, seg_sec_cnt * priv->seg_max);
>>> +
>>> +             ret = virtio_blk_do_single_req(dev, sector + i, blk_per_sg,
>>> +                                            buffer + i * 512, type);
>>> +             if (!ret)
>>> +                     return ret;
>>
>> The error check is inverted. virtio_blk_do_single_req() returns blkcnt
>> (positive) on success and -EIO on failure, so if (!ret) only triggers
>> when ret is zero. I suspect you want if (ret < 0) here.
Correct, fixed it in v2.

>>
>> BTW please add a function comment for virtio_blk_do_single_req() so
>> all this is clearer.
Done in v2.

> 
> This is all true, and useful feedback.
> 
>>> diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
>>> @@ -67,50 +74,69 @@ static void virtio_blk_init_data_sg(...)
>>> +     // The virtio device may have constrains on the maximum segment size.
>>
>> U-Boot follows the Linux kernel coding style which prefers /* */
>> comments over //. Please can you convert these.
> 
> This hasn't been true for a number of years, Linux Kernel nor here.
> We've accepted C99-style comments (when not needing to be kernel-doc)
> for a long time now.
>
Thanks for the info Tom, I still converted the comments in v2.

Thanks
Chris

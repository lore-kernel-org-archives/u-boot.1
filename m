Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA5FC27C5E
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 11:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FD7188365;
	Wed,  5 Jun 2024 13:35:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Rzi1AJl8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5621588370; Wed,  5 Jun 2024 13:35:36 +0200 (CEST)
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90962881A2
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 13:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.alibaba.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hsiangkao@linux.alibaba.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1717587328; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=ZWyg5gjbp/D3xGfoUNQrIHrkZg4uCCgoy+S/mfqhArM=;
 b=Rzi1AJl8BiDrxq3SKEgumWQmdU3wprnEw4Z59uz3KHJbdIjgbZ+M8VCBd5YFqNy1BV6XXfvm3p+chbmZyC7E/0q+F5GPa4JPswJo8T2feneagXJ3wNrMXpPg6uMAPdHaWBkBegVdoKXmLY7tphDvAFvhQQYiMAlehJ62JVSHrNY=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R401e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067112;
 MF=hsiangkao@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0W7v662J_1717587326; 
Received: from 30.97.48.174(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0W7v662J_1717587326) by smtp.aliyun-inc.com;
 Wed, 05 Jun 2024 19:35:27 +0800
Message-ID: <e57884b8-701a-4ca5-adce-1b3a0b4b8b2e@linux.alibaba.com>
Date: Wed, 5 Jun 2024 19:35:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Several potential vulnerabilities in the filesystem
To: jianqiang wang <wjq.sec@gmail.com>, Huang Jianan <jnhuang95@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAMn3X6NjqGmCeVT-X_d_btDKQQJDzz7CnTzOb=62np75VumhDg@mail.gmail.com>
 <5b08ad9c-8ed3-4877-b95d-f5d0ca693fb0@linux.alibaba.com>
 <CAMn3X6MJiPdB9s=h8wyNQ-=LoWcOMghj3K1KOk-V-pMvyen2fw@mail.gmail.com>
 <0d843d6d-3561-4a03-9fa1-94152551f935@linux.alibaba.com>
 <CAMn3X6M-Lmmh9rH6k1E_+u2aOEyViwM9nb2f9=p_ZXD+s20d7A@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAMn3X6M-Lmmh9rH6k1E_+u2aOEyViwM9nb2f9=p_ZXD+s20d7A@mail.gmail.com>
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



On 2024/6/5 19:26, jianqiang wang wrote:
> Hi Xiang,
> 
> I just checked the second crash, the patch can solve this issue. Did
> you also look into the other two issues?

I'm only responsible for the EROFS project.

Thanks,
Gao Xiang

> 
> Best
> Jianqiang
> 
> Gao Xiang <hsiangkao@linux.alibaba.com> 于2024年6月5日周三 13:18写道：
>>
>> Hi Jianqiang,
>>
>> On 2024/6/5 19:00, jianqiang wang wrote:
>>> Hi,
>>>
>>> I do have the crafted image.
>>>
>>> payload_00500, payload_00763, payload_00846 can be used to reproduce
>>> 1,2,3 vulnerabilities respectively.
>>>
>>> Each image is a hard drive file and the vulnerabilities can be
>>> triggered by performing the following operations:
>>>
>>>       struct udevice *dev;
>>>       uclass_first_device_err(UCLASS_IDE, &dev);  //detect the block device
>>>
>>>       fs_set_blk_dev("ide","0:1", 0);
>>>       fs_ls("/");   //mount the first partition and list the root directory files
>>>
>>>       fs_set_blk_dev("ide","0:1", 0);
>>>       char buf[10];
>>>       buf[0] = 0;
>>>       buf[1] = 0;
>>>       buf[2] = 0;
>>>       buf[3] = 0;
>>>       loff_t actread = 0;
>>>       fs_read("/a.txt", (ulong)buf, 0, 5, &actread);
>>>       printf("fd actread %lld %x %x %x\n",actread,buf[0],buf[1],buf[2]);
>>>    read the /a.txt file
>>>
>>>
>>>       fs_set_blk_dev("ide","0:1", 0);
>>>       fs_read("/a.txt.ln", (ulong)buf, 0, 5, &actread);
>>>       printf("fd actread %lld %x %x %x\n",actread,buf[0],buf[1],buf[2]);
>>>    read the /a.txt.ln symbol file
>>>
>>>       fs_set_blk_dev("ide","0:1", 0);
>>>       fs_unlink("/a.txt.ln");  //unlink it
>>>
>>> The second and third may not trigger a crash however, can be observed
>>> by inserting logging before the memset/memcpy function.
>>
>> Sorry, I just found that this issue was already fixed in erofs-utils:
>> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?id=884866ca07817e97c59605a2fa858a0b732d3f3c
>>
>> Would you mind checking if the patch above fixes the issue?
>>
>> Hi Jianan,
>> Would you mind backporting this patch for u-boot?
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> Best regards
>>>
>>> Gao Xiang <hsiangkao@linux.alibaba.com> 于2024年6月5日周三 05:10写道：
>>>>
>>>>
>>>>
>>>> On 2024/6/5 06:53, jianqiang wang wrote:
>>>>> Hi Das U-Boot developers,
>>>>>
>>>>
>>>> ...
>>>>
>>>>>
>>>>> 2. in file fs/erofs/data.c, function z_erofs_read_one_data, the node
>>>>> data is read from the storage, however, without a proper check, the
>>>>> data can be corrupted. For example, the inode data is used in function
>>>>> z_erofs_read_data, map.m_llen will be calculated to a very large
>>>>> value, which means the length variable will be very large. It will
>>>>> cause a large memory clear with memset(buffer + end - offset, 0,
>>>>> length);
>>>>
>>>> Would you mind giving a reproducer or a crafted image to trigger
>>>> this?  Or it's your pure observation.
>>>>
>>>> Thanks,
>>>> Gao XIang
>>>>

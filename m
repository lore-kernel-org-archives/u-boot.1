Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DB3C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 23:18:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 707A388CB0;
	Wed, 24 Apr 2024 01:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713914317;
	bh=6pQ6+yc09R2WIUxP1MdXg0el5nqBkd3ks32KuBBnOOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w0dQZq89XCARcCqeET36joGKiH0P+MYJ57e5zGouRAq5GANj3nslLuUZP8VpOg6BI
	 v4bcdvVtRurbmzGqO37jv2JSpX8HB8UagqSwaIA0CAuHRn8obW1u6d4GonjE/AaBA6
	 nQLK8f6+uoQ4ab7cvsCk3gziTGXh0v5boaKyH2Pvwl5ZA4Uvwbs5KahQLGjhhZt5j4
	 P1qYMO5amkfgtKmPMjyne7H90jAyxLsfTYOFUHtRk5zz6/Q5Hrr53fIXWu9VxHP9QC
	 h0BsY1TLphRQQ8aNBV6hwLqO6rNvzfp7vfndhyQd7TdeZ4qE+b0ve6zIs3h80uXLfP
	 BWzf9ctEyFKtg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5817B88359;
 Wed, 24 Apr 2024 01:18:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713914316;
 bh=6pQ6+yc09R2WIUxP1MdXg0el5nqBkd3ks32KuBBnOOM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=zTb5RBlVz6Zb+9l66wOiI8x3qz2l2c87ltvM4FmcvVPAp9dogl3Q4+2bDeT/2o/tn
 g8r2qCMPgJo8uKwId3hStqdDuanHrrceVroPPudAZ8Q8MJTtn66eJ+pjbRmHdEp/HA
 mSuFZm/8hVUtXoXLs/5+nZ4x5qTbl248QgNfNbCOhdIDgAFXnmfbaFWPFgiU8z2nAv
 G0eFpK3ddFJh7DfWYKXGLvyfuMG9xacMLr2fGvZXKpUU5ew/ayTcsPz4KAG6gxWFgL
 yb1N9RYdIH7v595OLbmRiyTVbjEZBxWZW/50rEcSDyXAI7Ghb1C5mfblYGoJPQ7oYh
 d+T1+PbeqCu9A==
Message-ID: <c481eb6b-2e1a-4a98-a590-e51081e183ce@denx.de>
Date: Wed, 24 Apr 2024 00:31:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc2: Add in version 4xx compatibility
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>
Cc: u-boot@lists.denx.de,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Teik Heng Chong <teik.heng.chong@intel.com>,
 Tom Rini <trini@konsulko.com>
References: <20240326023208.3525-1-greg.malysa@timesys.com>
 <8e4d6360-8722-4358-b981-2b3405373861@denx.de>
 <CAAjXUap1DDPOSKQRc3-h0m5ybv_AHZePwW-vxRSeKW1STZp-0g@mail.gmail.com>
 <87r0f54qxo.fsf@baylibre.com>
 <CAAjXUaqYv1zTATXhU5GeOMpSCK-HMxvMW5_edbotZ8TUczcVMA@mail.gmail.com>
 <874jbs7dyn.fsf@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <874jbs7dyn.fsf@baylibre.com>
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

On 4/23/24 9:09 AM, Mattijs Korpershoek wrote:
> Hi Greg,
> 
> On ven., avril 19, 2024 at 15:21, Greg Malysa <greg.malysa@timesys.com> wrote:
> 
>> Hi Mattijs,
>>
>>> Please avoid top-posting when replying, it makes following the
>>> discussion more difficult:
>>> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions
>>
>> Will do. Sorry about that; I'm still learning about this approach to email.
> 
> No worries. There are quite some things to learn and we probably all did
> this wrong when starting. Thank you for taking the time to learn and to contribute!
> 
>>
>>> Looking at
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=65dc2e725286106f99c6f6b78e3d9c52c15f3a9c
>>>
>>> we can see that the following is added:
>>> #define DWC2_CORE_REV_MASK      0x0000ffff
>>>
>>> This makes me believe that the versioning follows a well known pattern.
>>
>> I can submit a v2 next week to bring it in line with the kernel's approach.
> 
> To me, it's fine as is.
> 
>>
>>> Note that this change is also part of:
>>> https://lore.kernel.org/all/20240328131811.94559-1-seashell11234455@gmail.com/
>>
>> Or if you prefer I can also drop our patch and we can pursue this
>> linked patch with both 4xx compatibility and the 420a reset handling.
> 
> I think the patch you submitted is fine by itself, but I'd let Marek
> decide since he is the maintainer for this part.
> 
> If you have access to the hardware that has a 4.20a dwc2 controller,
> maybe you can help testing the patch above patch as well?

+CC Liu on this thread, maybe it is best if the two of you figure out 
the best common approach that works for you both ?

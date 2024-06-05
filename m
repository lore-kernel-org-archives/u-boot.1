Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34283C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 03:10:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62B0C88193;
	Wed,  5 Jun 2024 05:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VTdxOdJC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99394881D6; Wed,  5 Jun 2024 05:10:44 +0200 (CEST)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B204588180
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 05:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.alibaba.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hsiangkao@linux.alibaba.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1717557037; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=HJj5Amtn/9MedPH+1hyaZ6tvyuX0INCfgVkB1qjwefU=;
 b=VTdxOdJCWcjmG7+9giJdlD0Hd7wu7yhpran93c0UAT7xM4ylF0IlyA1XzYcr+ConXu9wJxSPi25pkGkZEAD5atfmUFhDgU3mjIDf1K0D18ZYHAWwRMwTyS1leOBD02RZl9Jz3pSke2n5x6yin1F7u6weY3skuzRZMRPj+ND5TTk=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R811e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067113;
 MF=hsiangkao@linux.alibaba.com; NM=1; PH=DS; RN=2; SR=0;
 TI=SMTPD_---0W7spTLH_1717557035; 
Received: from 30.97.48.174(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0W7spTLH_1717557035) by smtp.aliyun-inc.com;
 Wed, 05 Jun 2024 11:10:35 +0800
Message-ID: <5b08ad9c-8ed3-4877-b95d-f5d0ca693fb0@linux.alibaba.com>
Date: Wed, 5 Jun 2024 11:10:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Several potential vulnerabilities in the filesystem
To: jianqiang wang <wjq.sec@gmail.com>, u-boot@lists.denx.de
References: <CAMn3X6NjqGmCeVT-X_d_btDKQQJDzz7CnTzOb=62np75VumhDg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAMn3X6NjqGmCeVT-X_d_btDKQQJDzz7CnTzOb=62np75VumhDg@mail.gmail.com>
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



On 2024/6/5 06:53, jianqiang wang wrote:
> Hi Das U-Boot developers,
> 

...

> 
> 2. in file fs/erofs/data.c, function z_erofs_read_one_data, the node
> data is read from the storage, however, without a proper check, the
> data can be corrupted. For example, the inode data is used in function
> z_erofs_read_data, map.m_llen will be calculated to a very large
> value, which means the length variable will be very large. It will
> cause a large memory clear with memset(buffer + end - offset, 0,
> length);

Would you mind giving a reproducer or a crafted image to trigger
this?  Or it's your pure observation.

Thanks,
Gao XIang


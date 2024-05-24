Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626D0C25B7C
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 16:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD0E488646;
	Fri, 24 May 2024 18:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qSffPACe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BE118865D; Fri, 24 May 2024 18:52:37 +0200 (CEST)
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BEC887DAB
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.alibaba.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hsiangkao@linux.alibaba.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1716569550; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=oEGxQAUE0MnIa16lz0T+YQTooC61PSJ4eiZXc9Khk/Q=;
 b=qSffPACe/HSCQzncsv4vfQ537Ka4tcT0q6AXG4C3PJjE7+cjvGnsQIrB/OGvOcFFKDAV+wmWEzn8VvNmrMfMMc6DWy6D3LPUYY8N2M+MHRHmpgaW9I9IlWJMNjD7FG0gAqlWh0sUox4K2ouBvKIpniAb3rFVEUap2CDwxymm3+M=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R461e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045075189;
 MF=hsiangkao@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0W77S4p8_1716569546; 
Received: from 192.168.2.4(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0W77S4p8_1716569546) by smtp.aliyun-inc.com;
 Sat, 25 May 2024 00:52:28 +0800
Message-ID: <a9f890d4-555b-488f-85f8-8b22fdfd257b@linux.alibaba.com>
Date: Sat, 25 May 2024 00:52:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] lib/lz4: update LZ4 decompressor module
To: Jonathan Liu <net147@gmail.com>, Huang Jianan <jnhuang95@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org
References: <20220226070551.9833-1-jnhuang95@gmail.com>
 <20220226070551.9833-3-jnhuang95@gmail.com>
 <CANwerB2SBe1+0sW1OXHEfSMA1z-vyAvLfAqVOKdsM-ap=KYbCA@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CANwerB2SBe1+0sW1OXHEfSMA1z-vyAvLfAqVOKdsM-ap=KYbCA@mail.gmail.com>
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

Hi,

On 2024/5/24 22:26, Jonathan Liu wrote:
> Hi Jianan,
> 
> On Sat, 26 Feb 2022 at 18:05, Huang Jianan <jnhuang95@gmail.com> wrote:
>>
>> Update the LZ4 compression module based on LZ4 v1.8.3 in order to
>> use the newest LZ4_decompress_safe_partial() which can now decode
>> exactly the nb of bytes requested.
>>
>> Signed-off-by: Huang Jianan <jnhuang95@gmail.com>
> 
> I noticed after this commit LZ4 decompression is slower.
> ulz4fn function call takes 1.209670 seconds with this commit.
> After reverting this commit, the ulz4fn function call takes 0.587032 seconds.
> 
> I am decompressing a LZ4 compressed kernel (compressed with lz4 v1.9.4
> using -9 option for maximum compression) on RK3399.
> 
> Any ideas why it is slower with this commit and how the performance
> regression can be fixed?

Just the quick glance, I think the issue may be due to memcpy/memmove
since it seems the main difference between these two codebases
(I'm not sure which LZ4 version the old codebase was based on) and
the new version mainly relies on memcpy/memmove instead of its own
versions.

Would you mind to check the assembly how memcpy/memset is generated
on your platform?

Thanks,
Gao Xiang

> 
> Thanks.
> 
> Regards,
> Jonathan

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C324C2FC14
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 09:15:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8512E86A75;
	Thu, 17 Aug 2023 11:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8221186A79; Thu, 17 Aug 2023 11:15:49 +0200 (CEST)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D7A4867F6
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 11:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.alibaba.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hsiangkao@linux.alibaba.com
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R941e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=hsiangkao@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0VpzJcqa_1692263739; 
Received: from 30.221.132.1(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VpzJcqa_1692263739) by smtp.aliyun-inc.com;
 Thu, 17 Aug 2023 17:15:40 +0800
Message-ID: <daa330d8-867d-d98b-29c3-e0cb208ff6fb@linux.alibaba.com>
Date: Thu, 17 Aug 2023 17:15:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] fs/erofs: avoid noisy messages
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Huang Jianan <jnhuang95@gmail.com>
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
References: <20230817070138.44258-1-heinrich.schuchardt@canonical.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230817070138.44258-1-heinrich.schuchardt@canonical.com>
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

Hi Heinrich,

On 2023/8/17 15:01, Heinrich Schuchardt wrote:
> The erofs file system creates noisy messages when it is not used:
> 
>      => host bind 0 disk.img
>      => part list host 0
>      cannot find valid erofs superblock
>      cannot find valid erofs superblock
> 
>      Partition Map for HOST device 0  --   Partition Type: EFI
> 
> If there is not erofs file system, this only deserves a debug message.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

There was already a patch to address that:
https://lore.kernel.org/u-boot/20230813142708.361456-13-sjg@chromium.org/

Anyway, I'm fine with either patch.  For this patch,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

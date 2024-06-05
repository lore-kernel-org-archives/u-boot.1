Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A47EC27C53
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 14:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5AE68836E;
	Wed,  5 Jun 2024 16:59:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="N7VnMW4Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 511EE87AD2; Wed,  5 Jun 2024 16:59:38 +0200 (CEST)
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 728A187666
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 16:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.alibaba.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hsiangkao@linux.alibaba.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1717599570; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=UKDGoGqR+vXsq35B+ekWWNLpAZgkfPuNDp+b7EgRVCI=;
 b=N7VnMW4Y/wQI1FqpvFdtm8iNiSNLOsjVN6lz+VrTxsCiTaOsvCmSrekr8rQG/X3KDqGjI8aguStJw3F2Ph0pVfFeiBuDO7aW5nNVeQyPkBNH19GJEz8TVMuR36A2wqBZweHpZ1aazpqxUaQu/WrHsvbSJGUPogcDZr58B73JTdI=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R591e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067110;
 MF=hsiangkao@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0W7vPktO_1717599567; 
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0W7vPktO_1717599567) by smtp.aliyun-inc.com;
 Wed, 05 Jun 2024 22:59:28 +0800
Message-ID: <cd4cb812-88a3-4cb6-ae92-dc20d706642b@linux.alibaba.com>
Date: Wed, 5 Jun 2024 22:59:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/erofs: fix an overflow issue of unmapped extents
To: Jianan Huang <jnhuang95@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: linux-erofs@lists.ozlabs.org, wjq.sec@gmail.com
References: <20240605140554.1883-1-jnhuang95@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240605140554.1883-1-jnhuang95@gmail.com>
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



On 2024/6/5 22:05, Jianan Huang wrote:
> Here the size should be `length - skip`, otherwise it could cause
> the destination buffer overflow.
> 
> Reported-by: jianqiang wang <wjq.sec@gmail.com>
> Fixes: 65cb73057b65 ("fs/erofs: add lz4 decompression support")
> Signed-off-by: Jianan Huang <jnhuang95@gmail.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA006C021A0
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 15:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2148B80BAE;
	Wed, 12 Feb 2025 16:33:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xc4n9Gug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85CE580C6F; Wed, 12 Feb 2025 16:33:22 +0100 (CET)
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4430809D0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 16:33:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.alibaba.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hsiangkao@linux.alibaba.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1739374396; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=XL8IDPZGBf7QrlZ+HcsVFr0MP1RcuEc5LblpFL8S14w=;
 b=xc4n9GugK0VMQxGWTtI08kTcaEpchzNmpX/wkuGCmT/btVcircomBCihY1ky3cxrEq0nFtuXGrw0EXMTNC0hYgbiK2420h+FugghW8q7F2ilJf1/nZIzf5UuTwDeaG5N+47qRvqRJbL4IglQ04scipiaOSKfY3CBGQC18IU2MHU=
Received: from 30.41.15.245(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0WPKeHaJ_1739374392 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 12 Feb 2025 23:33:13 +0800
Message-ID: <e16c4550-2a42-40d9-a57a-9be488f89381@linux.alibaba.com>
Date: Wed, 12 Feb 2025 23:33:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/erofs: fix an integer overflow in symlink resolution
To: Jonathan Bar Or <jonathanbaror@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 linux-erofs@lists.ozlabs.org
References: <20250212093057.3975104-1-hsiangkao@linux.alibaba.com>
 <CABMsoEFTGzKhFn7eB0cjg2peCd_DubF-X6Rpq2+1cRVm_J0Q0g@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CABMsoEFTGzKhFn7eB0cjg2peCd_DubF-X6Rpq2+1cRVm_J0Q0g@mail.gmail.com>
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



On 2025/2/12 22:17, Jonathan Bar Or wrote:
> This is good, but may I suggest using __builtin_add_overflow instead?

They are just the same.

erofs-utils follows the kernel style, mostly the kernel doesn't
directly use __builtin_add_overflow, instead it has a wrapper
check_add_overflow().

I could use __builtin_add_overflow for u-boot only.

Thanks,
Gao Xiang

> 
> Jonathan
> 

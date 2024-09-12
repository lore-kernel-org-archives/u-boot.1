Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5D1EEB574
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 09:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A493688F56;
	Thu, 12 Sep 2024 11:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726133082;
	bh=/C0LuO+d7YEGJMCp3OY/SZVXJChlPcqWdE7lHkjutPw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Asufy56MNd+f1mIUnmdAvofyzfytDCNo6ejGCoETUGdT9yx/VKdzTaLhG2RluFOuc
	 yncpTCj+nQB/e8OREs/+NLPBRrgFt232SVx02xyKaBHfHnGgmlWEnknuk0fNibrpK5
	 qu6f8G7ToZM8duhE51doKxgXlpYenHUeFBBUZZQ91ZEsznbhFIFB/pUaina8q9RnjM
	 aE94gMw8qcCa2u17YzfYXgikE2pI3I/4fYDCtVydhaGZTTSCb4RBj24AyjOgHIDw3K
	 GSUQuOQgwL0fXeZ/KlQuXCSrcro+RynYRpfk1fYr1WuekrguwwYH2cf3K4r2Q5lHIS
	 cU8V7NH4y0dIA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 236D688F3E;
 Thu, 12 Sep 2024 11:24:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726133080;
 bh=/C0LuO+d7YEGJMCp3OY/SZVXJChlPcqWdE7lHkjutPw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XI5Nb5Wl0Symw/kEzYTIV9PlEySyd0xHM3bim0atE3xEc5pehi55SikzwrVB92t18
 Rxcz+jtUFNnW3FKbMtUoHmncW5sqVxzJwEi6FRzuEV/CMyyner/6NYnlAKF8vZOw51
 vGQLg+qQYxBoDeoUUoUtllzZ7ZUtO9+EOw7M9veEKXfa+X/H5iDdfjBxHv3DIZ77yS
 Eq9Tf/PL5ZFDCfIbzcb/ZiHidGvdCi3TG1tUopcitpRO0TJiucD5YB5u45i3OGH+mB
 GsvUjJqSAL67dU+68FgmgSezM21R4mveApa32wC+98/lBmExaUtKQ1SkrDtn2adQy4
 13exdnBbrp/vQ==
Message-ID: <8c9f8dce-2455-468e-be42-6a53d7e48c9e@denx.de>
Date: Thu, 12 Sep 2024 11:23:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Fix chip erase timeout issue
To: Ye Li <ye.li@oss.nxp.com>, Ye Li <ye.li@nxp.com>,
 jagan@amarulasolutions.com, u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
References: <1726051530-56280-1-git-send-email-ye.li@nxp.com>
 <6c353eaa-1609-4a72-a557-0b81ee337c5f@denx.de>
 <45629459-5e0d-468a-ac6c-789dc11d44b3@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <45629459-5e0d-468a-ac6c-789dc11d44b3@oss.nxp.com>
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

On 9/12/24 10:48 AM, Ye Li wrote:

[...]

>>> +            timeout = max(CHIP_ERASE_2MB_READY_WAIT_JIFFIES,
>>> +                      CHIP_ERASE_2MB_READY_WAIT_JIFFIES *
>>> +                      (unsigned long)(mtd->size / SZ_2M));
>> Is the type cast needed ?
> 
> Yes. otherwise get below warning
> 
> 
> In file included from include/linux/bitops.h:22,
>                   from include/log.h:15,
>                   from drivers/mtd/spi/spi-nor-core.c:13:
> drivers/mtd/spi/spi-nor-core.c: In function ‘spi_nor_erase’:
> include/linux/kernel.h:190:24: warning: comparison of distinct pointer 
> types lacks a cast
>    190 |         (void) (&_max1 == &_max2);              \
>        |                        ^~
> drivers/mtd/spi/spi-nor-core.c:1042:35: note: in expansion of macro ‘max’
>   1042 |                         timeout = 
> max(CHIP_ERASE_2MB_READY_WAIT_JIFFIES,
>        |
mtd->size is uint64 , so you need to use do_div() :

u64 sz = mtd->size;
do_div(sz, SZ_2M);
timeout = CHIP_ERASE_2MB_READY_WAIT_JIFFIES * max(1ULL, sz);

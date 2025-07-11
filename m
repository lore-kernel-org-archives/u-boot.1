Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3387C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 14:05:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE291803DF;
	Fri, 11 Jul 2025 16:05:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AsG7qPLH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4C3B805D7; Fri, 11 Jul 2025 16:05:24 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1752E800D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 16:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56BE5JUS2052334;
 Fri, 11 Jul 2025 09:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752242719;
 bh=hFcl3CUHobrHNR00uNGbmw3C4v6hYSr1YkeGjbf88gg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=AsG7qPLHTp7L8EAVtynxE4KaqQunt1xYvt+vxubMfOjl1PMoP4/bXzvxaf6/C9dw7
 5ZiTJ6cefAHXclwqAkryGYoYEm0RmWeJiUCSy6aX5RlU3vro/bNn2nguTYJz87qxef
 7gJkFm8pf0PaRjR4XTv7Gqe56Oollul7jmlsklOk=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56BE5I2h2351871
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 11 Jul 2025 09:05:19 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 11
 Jul 2025 09:05:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 11 Jul 2025 09:05:18 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56BE5IZl3303431;
 Fri, 11 Jul 2025 09:05:18 -0500
Message-ID: <c3340193-af10-4dd1-b189-081641036940@ti.com>
Date: Fri, 11 Jul 2025 09:05:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-k3: am62*: am62*_init: Prohibit boot from UDA w/
 eMMC boot
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Anshul Dalal
 <anshuld@ti.com>
CC: Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>, Andrew Davis
 <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, U-Boot-Denx
 <u-boot@lists.denx.de>
References: <20250710171135.669838-1-jm@ti.com>
 <DB94N4OKVW9D.28H05SO50F2D4@ti.com>
 <CAOf5uwnTAwd0Aj8QzzJGtwvWXAfc+rNaAtcrYyUMt2BRHrJ0pQ@mail.gmail.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <CAOf5uwnTAwd0Aj8QzzJGtwvWXAfc+rNaAtcrYyUMt2BRHrJ0pQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Michael,

On 7/11/25 4:58 AM, Michael Nazzareno Trimarchi wrote:
> Hi
> 
> Could be html for my mobile. Some comments inline.
> 
> Il ven 11 lug 2025, 11:44 Anshul Dalal <anshuld@ti.com 
> <mailto:anshuld@ti.com>> ha scritto:
> 
>     On Thu Jul 10, 2025 at 10:41 PM IST, Judith Mendez wrote:
>      > This removes support from booting from UDA when in eMMC boot.
>      >
>      > When user selects eMMC boot [0], that is, boot from eMMC boot0 or
>      > boot1 HW partitions, we should not boot from eMMC UDA. The current
>      > logic confuses the end user and mixes two different boot modes.
>      >
> 
>     This is correct, we should not be changing the eMMC boot mode based on
>     what U-Boot config is enabled.
> 
>     The end user can always use MMCSD as the backup boot mode if they want
>     a fallback.
> 
>      > The logic was added for AM62A/AM62P with commit: 3b7893145e36, but
>      > this is not a clean solution and fix will come later for falcon boot.
>      >
>      > Logic was also added for AM62X with commit: 664593464634, but this
>      > logic is incorrect according to TRM [0] under Primary Boot Mode
>     Selection
>      > for 'eMMC Boot'.
>      >
>      > Fixes: 3b7893145e36 ("mach-k3: add eMMC FS boot support for
>     am62[ap]")
>      > Fixes: 664593464634 ("arm: mach-k3: am625: Relax emmc boot
>     condition")
>      > Signed-off-by: Judith Mendez <jm@ti.com <mailto:jm@ti.com>>
> 
>     Reviewed-by: Anshul Dalal <anshuld@ti.com <mailto:anshuld@ti.com>>
> 
> 
> First of all this is not a fix. A fix when you have something that is 
> not working . Then the commit was having a reason the boot0 and boot1 
> can have limited size that does not allow to have all the TI ecosystem 
> on boot partition and then you must use the the rest of emmc. Booting 
> from this scenario is totally fine

It is not working as expected, so it is a fix IMO, but will not fight on
that.

AND no, eMMC boot is not expected to boot from UDA. If you want to boot
from eMMC UDA, please use MMCSD boot which is the proper boot mode to
boot from eMMC UDA in RAW or FS mode.


> 
> Michael
> 
> 
> 
>     Thanks for the fix,
>     Anshul
> 


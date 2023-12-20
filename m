Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3EEC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 16:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3324D876C0;
	Wed, 20 Dec 2023 17:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1703088659;
	bh=mb/snHew8x+oBo4Wkwh6bIq2zKoDKNcS6OyuBS3C9WI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qGD4PJ0/GUtOPJrZ/2mb2J/Os5UtVGURabVnEtA5s0cQ3UN1YUeLMk4ZkwDmN9ddH
	 i/4wX5dVrPAwdqR2CB135bOMfypAWKIBRfAHEIt15LRQLiujUOQre/ZUjD9opZUUMK
	 sBR75pWtaMxI82hiihZMc8Wexh61hzQgcT6aTCe8Aq+TBCi42QxSHxz7KlmnPxo+Iw
	 y+vay2VP1Ujzcl0tKZoRWzWGh6UEKun+xWDA9uj4UA6w4TIRQ0af9BtWGCjccPYtgp
	 EERx0AIJw4eI8Qxjn9wa+D9wTFFf1AvtfCTyyVzrudcXEUXkanGbFj99jUzE03/okT
	 /YdhK+pITZdYA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0EEB686CF4;
 Wed, 20 Dec 2023 17:10:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1703088657;
 bh=mb/snHew8x+oBo4Wkwh6bIq2zKoDKNcS6OyuBS3C9WI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=i+7r+lM8VkCATkvjo4b1B0rxF4sbeBzfzc2lKr0Dgj86k5NsJFHw1xJRQ/T1MPER+
 m12O9RL0erpHM9+/l8M9UY7Dx5gqxvVihceIuWDnkgsq0K5LEaDZqAePCtzj6fxmoH
 3uuj1WXVuYFKnG0rIyzqiqpaVeFoH8o+IFnzBnax+jFPe0ke++IsP8ivIEIck7aJTX
 103WWn7Tq7x8ysKYkf57rCLPf0WBhSm1PEBYhjNWVpgc/4wxr2vDrKKsGrZRYwRjCU
 IpatsIEg7rB4nmL69Wy2+B0Q+DMDHUDldtCwWStfb8dUaaL1VipiF606p4os8eHi8Q
 VoxE0FvdzrNeA==
Message-ID: <c85be092-64de-4bac-842a-b7d1d4587d84@denx.de>
Date: Wed, 20 Dec 2023 17:10:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] drivers: misc: Add socfpga_dtreg driver for Intel
 SoCFPGA
Content-Language: en-US
To: "Lau, Wan Yee" <wan.yee.lau@intel.com>,
 "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Bin Meng <bmeng.cn@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>, Peng Fan <peng.fan@nxp.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@intel.com>,
 "Maniyam, Dinesh" <dinesh.maniyam@intel.com>,
 "Ng, Boon Khai" <boon.khai.ng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "Chong, Teik Heng" <teik.heng.chong@intel.com>,
 "Zamri, Muhammad Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>,
 "Lim, Jit Loon" <jit.loon.lim@intel.com>,
 "Tang, Sieu Mun" <sieu.mun.tang@intel.com>, Tom Rini <trini@konsulko.com>
References: <20231208083726.26906-1-wan.yee.lau@intel.com>
 <DM8PR11MB5592CA687BF05641806BA22BD297A@DM8PR11MB5592.namprd11.prod.outlook.com>
 <edccf82f-2c65-4f09-bd9d-f94765ae015d@denx.de>
 <MW3PR11MB4553AD65903767C338B8E43AB696A@MW3PR11MB4553.namprd11.prod.outlook.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <MW3PR11MB4553AD65903767C338B8E43AB696A@MW3PR11MB4553.namprd11.prod.outlook.com>
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

On 12/20/23 04:09, Lau, Wan Yee wrote:

Hi,

can you trim the CC list to relevant people ?

[...]

>>>> +++ b/drivers/misc/socfpga_dtreg.c
>>>> @@ -0,0 +1,117 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Copyright (C) 2023 Intel Corporation <www.intel.com>  */
>>>> +
>>>> +#include <asm/io.h>
>>>> +#include <common.h>
>>>> +#include <dm.h>
>>>> +#include <errno.h>
>>>
>>> Please move <asm/io.h> above to here
>>>
>>>> +#include <linux/sizes.h>
>>
>> A good starting point would be to have socfpga 64bit maintainer , without that ,
>> these patches are only being archived .
> 
> Hi,
> 
> Is only one socfpga 64bit maintainer needed or the whole socfpga 64bit maintainer need to be included for this driver?

U-Boot currently does not have any SoCFPGA 64bit maintainer, that needs 
to be fixed .

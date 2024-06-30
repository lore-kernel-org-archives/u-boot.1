Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5125BC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 30 Jun 2024 05:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22A8D8862D;
	Sun, 30 Jun 2024 07:24:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719725048;
	bh=+nrgutLwKq6xnfLeq+F1ekQfrU4RHHu5sH9BwHrEo0g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p/626c9A0H4P9O4JG5t5S1t+Gax24kfiayEt//WY3NS9avtnDLhV21K04HAyd8S7s
	 HjtBkyIMus54+ysQdUgCVjf7gWRAxMwgvfr4nKxezQXEGMKGVfxkLgTlboPTEp/Fds
	 ZC5alcMchW3zsxGufmcxXhFpt2NwkQ0w0nnzKRt+Mi3VizM/MxXvZEG2mUyR2l9/Fy
	 21UThtb7PJxoHp6Og/SmRSLjYT9iD8bhXsURzAksgO8rQIhZjWossear/jPWYL02QA
	 SjWRaYZ7Xdf89ZOkNmNthTzrMhDG2YW5jDXdTY0K0XJuY5J1ZEbeIdxMBd9i4S9Lzx
	 PZObDwCTQ702Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7562B88621;
 Sun, 30 Jun 2024 07:24:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719725045;
 bh=+nrgutLwKq6xnfLeq+F1ekQfrU4RHHu5sH9BwHrEo0g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JU8H2OBRR6HPEmNxz1dk+amOcVDPcFERBjaJXlpahEtQOPfDdmz8r+8wGmW9gRUtn
 CqCYOceRr/VB9JzBYLwjNNwZ8MxmTLuj/x8W/edmm4z4fuJohZup0UzNbPWfvG9kEV
 sGMf9hv5SD/kcKxhNVtIV0B5KYkRtPWbWtiXqZ8GDVCqk3/f5ES1/aV1mgQLaTZglA
 ck8+HTiNbhBwkA/6LctOMP3nAktBrOOzsj00cbJyEwdlp/HC3WpCGYeWcPZXIvxNx4
 /Hlgm+idaMsWOEcVoWtJQzNLXrB/QCHfhU3zEZb1nDdVTUPQbjPlrzR9ox2WPoPbaB
 3q9gIVKhWMKVw==
Message-ID: <197c6afd-b917-4e8e-ac5e-07f4fcf38117@denx.de>
Date: Sun, 30 Jun 2024 04:49:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: dwc2: Extract USB DWC2 register definitions
To: Kongyang Liu <seashell11234455@gmail.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Teik Heng Chong <teik.heng.chong@intel.com>,
 Tom Rini <trini@konsulko.com>
References: <20240522142311.17351-1-seashell11234455@gmail.com>
 <20240522142311.17351-2-seashell11234455@gmail.com>
 <292e66c6-5665-4d0e-8510-5789a7853786@denx.de>
 <CAOKwTdqeppqngwX2PFx7vLtnbv=hbfkL3cmW3nwRNa9psnWtsA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOKwTdqeppqngwX2PFx7vLtnbv=hbfkL3cmW3nwRNa9psnWtsA@mail.gmail.com>
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

On 6/27/24 1:33 PM, Kongyang Liu wrote:
> Marek Vasut <marex@denx.de> 于2024年6月23日周日 07:49写道：
>>
>> On 5/22/24 4:22 PM, Kongyang Liu wrote:
>>
>> Hi,
>>
>> sorry for the late reply.
>>
>>> diff --git a/drivers/usb/common/dwc2_core.c b/drivers/usb/common/dwc2_core.c
>>> new file mode 100644
>>> index 0000000000..2fa11fd59d
>>> --- /dev/null
>>> +++ b/drivers/usb/common/dwc2_core.c
>>> @@ -0,0 +1,53 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
>>> + */
>>> +
>>> +#include <linux/bitfield.h>
>>> +#include <linux/errno.h>
>>> +#include <linux/io.h>
>>> +#include <wait_bit.h>
>>> +
>>> +#include "dwc2_core.h"
>>> +
>>> +void dwc2_flush_tx_fifo(struct dwc2_core_regs *regs, const int num)
>>> +{
>>> +     int ret;
>>> +
>>> +     log_debug("Flush Tx FIFO %d\n", num);
>>> +
>>> +     /* Wait for AHB master IDLE state */
>>> +     ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHBIDLE, true, 1000, false);
>>
>> Just a quick design point, would it be possible to split this patch into
>> two, one which adds this .global_regs and changes the code accordingly,
>> and another which does the code refactoring/move ? That would make it
>> easier to review.
> 
> This patch only extracts the common parts of the host mode and gadget
> mode, without any code refactoring. Could you please describe more clearly
> how the patch should be split?

Sure, sorry for being unclear. There seems to be multiple types of 
changes that are combined in this patch:

1) Structure reorganization:
-	writel(DIEPMSK_INIT, &reg->diepmsk);
+	writel(DIEPMSK_INIT, &reg->device_regs.diepmsk);

2) Structure rename:
-	reg = (struct dwc2_usbotg_reg *)pdata->regs_otg;
+	reg = (struct dwc2_core_regs *)pdata->regs_otg;

3) Conversion from (1 << n) to BIT(n)
4) Macro rename:
5) Moving code around between files:
#define DWC2_HWCFG4_IDDIG_FILT_EN			(1 << 20)
#define GHWCFG4_IDDIG_FILT_EN			BIT(20)

It would be good to have those as separate patches (one type of clean up 
change per patch), otherwise it is really hard to review such a combined 
patch.

Thanks !

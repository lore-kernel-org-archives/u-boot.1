Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760C9C2BD09
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 23:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53D26881BC;
	Sun, 23 Jun 2024 01:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719100151;
	bh=wiAKnXSuQ+0jW8/Z9OVl8ZQSodsRVvCEV3sTRW0o81A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JtWzWUWISVXLXqOsaT0L++iY33nry4RDuLkJCDy+yMKFOUrhiUc2JXGEqYgByFwat
	 VYeW8WubvMespP0g3F27M75LBvI9R9PmAezC6/qARI3ku2Cko5MrXG9J89Q4cUhnlZ
	 uDLjpyEr0X05Dv68J78k97TczA3QzjNkBOnayz5HWl0M2nsJYacCitsMGm8l8yl+rK
	 SvSxZP4isbpO41TQ9kmeAkyTmSKw/86iUOIXRyMtrCjxgayO0b4TsrGOZu54dLgBrf
	 +EDeBrvdIt2oWBvrpOIdtdvklfRshKik4m9uIeWvimzRrYkWAR+mGfg6oVDUaZ0Zur
	 uam1i153Tt07w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AF3AD87B77;
 Sun, 23 Jun 2024 01:49:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719100149;
 bh=wiAKnXSuQ+0jW8/Z9OVl8ZQSodsRVvCEV3sTRW0o81A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=O7Ao0lfYb93391TtVa0B8qm0yGmEoZZK9r3t4JJWkRuQ17EQDtbsQsJWGSL4mePMa
 33fpY6ILPpz6Y24N1reTC+v00rIBedrS5AO9X5Ja9uItCceK58v4PRLGpx9IX4Rx5V
 fUxGqudVbEZ3wNNJlgYLzFX9WjDJejzRPe6PViQ4fEr9dgQk6smTiFEbxbwh2Lj1Sg
 w3CG8tGhy+NsrDHMdmJPGCkkYY4Dn/yXih8685kzwGdPyIIHvsrCmJlzv9gUBNuouU
 jaspeYRiAhWkLjfgHLwSLmPmn2Y2VEj4hFCBVzO2Oeoux4ChtmngnyARPq8O9LtJIr
 O3bFGkrG4APog==
Message-ID: <292e66c6-5665-4d0e-8510-5789a7853786@denx.de>
Date: Sun, 23 Jun 2024 01:14:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: dwc2: Extract USB DWC2 register definitions
To: Kongyang Liu <seashell11234455@gmail.com>, u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Teik Heng Chong <teik.heng.chong@intel.com>,
 Tom Rini <trini@konsulko.com>
References: <20240522142311.17351-1-seashell11234455@gmail.com>
 <20240522142311.17351-2-seashell11234455@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240522142311.17351-2-seashell11234455@gmail.com>
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

On 5/22/24 4:22 PM, Kongyang Liu wrote:

Hi,

sorry for the late reply.

> diff --git a/drivers/usb/common/dwc2_core.c b/drivers/usb/common/dwc2_core.c
> new file mode 100644
> index 0000000000..2fa11fd59d
> --- /dev/null
> +++ b/drivers/usb/common/dwc2_core.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <wait_bit.h>
> +
> +#include "dwc2_core.h"
> +
> +void dwc2_flush_tx_fifo(struct dwc2_core_regs *regs, const int num)
> +{
> +	int ret;
> +
> +	log_debug("Flush Tx FIFO %d\n", num);
> +
> +	/* Wait for AHB master IDLE state */
> +	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHBIDLE, true, 1000, false);

Just a quick design point, would it be possible to split this patch into 
two, one which adds this .global_regs and changes the code accordingly, 
and another which does the code refactoring/move ? That would make it 
easier to review.

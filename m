Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4FEE77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 15:39:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11C77801E8;
	Mon,  6 Jan 2025 16:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736177951;
	bh=pcMgjTutLJHcvJJhcrdFSmyhPtJZrXSNWds/I7UqR3c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zGPj0y6RNIc3IOHRhvIa1Pgi2VPNYHWCHy+K/HD61DUsWZ1eRR1+HMCz6+EVQnhXu
	 N7YP/LgcLbqHu3RGgbSAzXSMbNp/2qsYC/UiMJH2s+3e78MWDqmfcRjUQ7aqZ5GSqC
	 7N7/4YldgPpi249UYgIvcMD0DMUqQkJ8jGtuwtFRzwvM+cFuACEoncUStKaaIBIwbh
	 y64m9geFu8UXBwRthOZPjinINnUU6nP3CNORczsBq8laElaGOtyBTqCfgm5zLZOGcH
	 bLwYRKHvJwtqoiufCVYis4RMqQDlHxna16tKfS921W2w0K1OTDZj5T6qBwAlWy6/o6
	 SE9Uw7f6HBDMw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D0CB8021A; Mon,  6 Jan 2025 16:39:09 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C07DA801C3
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 16:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="XnE+iASx"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C69FC104811D1; Mon,  6 Jan 2025 16:39:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736177945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pcMgjTutLJHcvJJhcrdFSmyhPtJZrXSNWds/I7UqR3c=;
 b=XnE+iASx5tJSo2njpFWnf0xwcyYcqoXQi/298uHL/mzGiADPwoVZwU2p109Hov52r6QizL
 aFs81HxT+Ohgr4Nfo5B3Jutn7v+QUjcgBZfBEypwxuIGk/zBZ3aSbgaDAVwyB7RnTrKReo
 t9KuaQEbKD2kPR2J0b8pRWze1UjRVz32XxQTiuc22JZ8+hv+sAuNFfj2p+MjU88a98NsH8
 0QbYGyETYbtn0OulCHWJm7u9OHzSl1QIUnsEsd6febvGtO8lkIoOSsx/0aFI/F8OLaLJp8
 DrIANYkDKXN57sJ4t6KxOnC4pM970Jck+7SUROd8aOp9OPLNLZMQm7HNGIhXZQ==
Message-ID: <64b317fe-d5a2-4bc7-8c8a-fa608bccfa0b@denx.de>
Date: Mon, 6 Jan 2025 16:37:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] usb: dwc2: Unify flush and reset logic with v4.20a
 support
To: Junhui Liu <junhui.liu@pigmoral.tech>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, seashell11234455@gmail.com, pbrobinson@gmail.com
References: <18180fa5d7b286a0.3a5aa491c048ad05.6820f85a01d7931@Jude-Air.local>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <18180fa5d7b286a0.3a5aa491c048ad05.6820f85a01d7931@Jude-Air.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/6/25 10:14 AM, Junhui Liu wrote:
> Hi Marek,
> 
> On 05/01/2025 20:19, Marek Vasut wrote:
>> On 1/4/25 4:37 AM, Junhui Liu wrote:
>>> From: Kongyang Liu <seashell11234455@gmail.com>
>>>
>>> This patch merges flush and reset logic for both host and gadget code
>>> into a common set of functions, reducing duplication. It also adds support
>>> for the updated reset logic to compatible with core version since v4.20a.
>>>
>>> This patch mainly refers to the patch in the kernel.
>>> link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=65dc2e725286106f99c6f6b78e3d9c52c15f3a9c
>>
>> [...]
>>
>>> +++ b/drivers/usb/common/dwc2_core.c
>>> @@ -0,0 +1,115 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
>>
>> 2025 now .
> 
> You're right. It should be 2024-2025.
> 
>>
>> [...]
>>
>>> +int dwc2_flush_rx_fifo(struct dwc2_core_regs *regs)
>>> +{
>>> +	int ret;
>>> +
>>> +	log_debug("Flush Rx FIFO\n");
>>> +
>>> +	/* Wait for AHB master IDLE state */
>>> +	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHBIDLE, true, 1000, false);
>>> +	if (ret) {
>>> +		log_warning("%s: Waiting for GRSTCTL_AHBIDLE timeout\n", __func__);
>>> +		return ret;
>>> +	}
>>> +
>>> +	writel(GRSTCTL_RXFFLSH, &regs->global_regs.grstctl);
>>> +
>>> +	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_RXFFLSH, false, 1000, false);
>>> +	if (ret) {
>>> +		log_warning("%s: Waiting for GRSTCTL_RXFFLSH timeout\n", __func__);
>>> +		return ret;
>>> +	}
>>> +
>>> +	/* Wait for at least 3 PHY Clocks */
>>> +	udelay(1);
>> Shouldn't this delay be derived from the PHY clock frequency somehow ?
>> Are we sure 1us is always sufficient ?
> 
> According to the datasheet, the PHY clock can be selected to 6/30/48/60
> MHz depending on the speed mode. And 1us is sufficient even for 6MHz
> (twice the 3 PHY clock at 6MHz), so I think 1us is acceptable here.

Please add a code comment like that ^ .

> If we want to derive the delay dynamically from the PHY clock frequency,
> we would need to read the PHY clock and speed mode cfg from the register
> and calculate the appropriate delay. This would add complexity to the
> code. In the current situation, a fixed delay of 1 us is sufficient for
> all supported clock frequencies and keeps the implementation simpler.
Thanks for the clarification, add a code comment and that is all fine.

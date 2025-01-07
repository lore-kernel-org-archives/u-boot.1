Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEE8E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 12:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB54C805E2;
	Tue,  7 Jan 2025 13:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736254743;
	bh=HaIO0EIIFFN0B+lrNffUkIDZN5pN4yGb4EmyKYI5EaQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gMmZcDdiJvTFYM8CqUQDTeV1fHs3YshvmnitBwcbsnjMX6UYrzuVhiWzxnEyU1Zxt
	 RoC690Uoq6u8VxsiFGaNyaALw0gf5nWbhrJeUfE9/lorMgagrS4jLHWA/3CRHa8H4z
	 sGSaChewdcpnfp9TTylikXZkPeIk8l+CwlEeZXx9BGEDrGqeMS+waLMSuhAtKJJw18
	 tTS+Xt6wplZRu2as9jFugYIrkBJ/8mBUBUpN1UkdAx4C8aULNJr9no2NNM1Wn4NGPm
	 fBmrdxky+aiEnYTBkE7xDwu9v0qJvFXSsgfH03Tp5mHW+f2v2zhiVrdAsXtIJFI1LO
	 KOG5tVULXnp+g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CA59803DC; Tue,  7 Jan 2025 13:58:59 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21B9A80079
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 13:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="hXBaatvR"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A29CC1092A133; Tue,  7 Jan 2025 13:58:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736254734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HaIO0EIIFFN0B+lrNffUkIDZN5pN4yGb4EmyKYI5EaQ=;
 b=hXBaatvRaDEmop4yrbSFyuglJ3gXbyYop7YyRvpZt+6Nu+j5GZJ7ZU+R/kC3AYVtClaHNo
 JXQA/550pzr4wyRTdoH71Nl/bjb7PVSuRudCEkGBsS7nkLkUHYUPTxuFbUJqc1DGkkAP7P
 NTdMEtjkvYpWM764mNcCM8Vkn0w05a6du6oAzV7MvoTJMtEom34wDYkbvXXafUw3RjaWK3
 KRSTDBlV3G8jDQ5IuM1Te4dRpZBQ4hUB/40Xp3iVL6Kd29ae+zklGkQHz7BPcphWO8dT2T
 C5HUumJVoip2Mbtyjia7nzI7dVDuh2/mqW5LYy+ujwznEqq7iNKAPEGaGh32oQ==
Message-ID: <1a76b8af-e476-4f70-b482-1076bae91e6e@denx.de>
Date: Tue, 7 Jan 2025 13:57:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] usb: dwc2: Unify flush and reset logic with v4.20a
 support
To: Junhui Liu <junhui.liu@pigmoral.tech>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, seashell11234455@gmail.com, pbrobinson@gmail.com
References: <1818696fe57acd78.91ad175705e34eaa.3d66e6a504061c82@Mac>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <1818696fe57acd78.91ad175705e34eaa.3d66e6a504061c82@Mac>
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

On 1/7/25 1:39 PM, Junhui Liu wrote:
> 
> 
> On 06/01/2025 16:37, Marek Vasut wrote:
>> On 1/6/25 10:14 AM, Junhui Liu wrote:
>>> Hi Marek,
>>>
>>> On 05/01/2025 20:19, Marek Vasut wrote:
>>>> On 1/4/25 4:37 AM, Junhui Liu wrote:
>>>>> From: Kongyang Liu <seashell11234455@gmail.com>
>>>>>
>>>>> This patch merges flush and reset logic for both host and gadget code
>>>>> into a common set of functions, reducing duplication. It also adds support
>>>>> for the updated reset logic to compatible with core version since v4.20a.
>>>>>
>>>>> This patch mainly refers to the patch in the kernel.
>>>>> link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=65dc2e725286106f99c6f6b78e3d9c52c15f3a9c
>>>>
>>>> [...]
>>>>
>>>>> +++ b/drivers/usb/common/dwc2_core.c
>>>>> @@ -0,0 +1,115 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>>> +/*
>>>>> + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
>>>>
>>>> 2025 now .
>>>
>>> You're right. It should be 2024-2025.
>>>
>>>>
>>>> [...]
>>>>
>>>>> +int dwc2_flush_rx_fifo(struct dwc2_core_regs *regs)
>>>>> +{
>>>>> +	int ret;
>>>>> +
>>>>> +	log_debug("Flush Rx FIFO\n");
>>>>> +
>>>>> +	/* Wait for AHB master IDLE state */
>>>>> +	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHBIDLE, true, 1000, false);
>>>>> +	if (ret) {
>>>>> +		log_warning("%s: Waiting for GRSTCTL_AHBIDLE timeout\n", __func__);
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>>> +	writel(GRSTCTL_RXFFLSH, &regs->global_regs.grstctl);
>>>>> +
>>>>> +	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_RXFFLSH, false, 1000, false);
>>>>> +	if (ret) {
>>>>> +		log_warning("%s: Waiting for GRSTCTL_RXFFLSH timeout\n", __func__);
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>>> +	/* Wait for at least 3 PHY Clocks */
>>>>> +	udelay(1);
>>>> Shouldn't this delay be derived from the PHY clock frequency somehow ?
>>>> Are we sure 1us is always sufficient ?
>>>
>>> According to the datasheet, the PHY clock can be selected to 6/30/48/60
>>> MHz depending on the speed mode. And 1us is sufficient even for 6MHz
>>> (twice the 3 PHY clock at 6MHz), so I think 1us is acceptable here.
>>
>> Please add a code comment like that ^ .
> 
> OK, I will add comments in the next version.
Thank you

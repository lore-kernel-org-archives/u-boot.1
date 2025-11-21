Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B478CFC28B
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 14:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D43338393F;
	Fri, 21 Nov 2025 15:52:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="s9Rhu2mw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 905808394E; Fri, 21 Nov 2025 15:52:39 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A95F8391B
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 15:52:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dCdVV5fnfz9vLW;
 Fri, 21 Nov 2025 15:52:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763736755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6n7NkXS5X+x5jI7mcRWUyk6O4sXgMjAEWtND0q7HnxE=;
 b=s9Rhu2mwcO6TWR5YI901LrnnadhjWyuEEsY6JmesBPDPiYJTvcAGea5qHAAe6tMNQ61X9z
 bII5J3rabr6d8RlH0IWHW8qhqsGWqV1YW5gNxqPLMrTPUn6jxurRZ8nYbV8qniiBESycf1
 SBze7rFgJudxYmYLYeB8rAAC/WNGrJEor+T4cwdOEOT9Ab6lSGY25eUl7VHHlwklqWzbCl
 QS7CPgkFYfvqxd/w3Q6WtN3ezJCZ/3/prC/GynEoNR0yMnDLqWpLEuJ6me3mrpCUjkEMId
 kt6uU6kkl2OcX7/CgPE6vLnnAPT97OSFO6Ob2A+UghpwsXo7Fz/8i71iXAU+bQ==
Message-ID: <39057967-fc84-46e3-a250-53e877c242d0@mailbox.org>
Date: Fri, 21 Nov 2025 15:06:15 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/6] drivers: usb: dwc3: Add delay after core soft reset
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 ilias.apalodimas@linaro.org, rui.silva@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, mkorpershoek@kernel.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
 <20251119152530.4175628-3-balaji.selvanathan@oss.qualcomm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251119152530.4175628-3-balaji.selvanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: zyxk4txn5np37ntbi1bexqmx9gk34thq
X-MBO-RS-ID: 8e2b976f2c005d379cb
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

On 11/19/25 4:25 PM, Balaji Selvanathan wrote:
> Add a 100 ms delay after clearing the core soft reset bit to ensure
> the DWC3 controller has sufficient time to complete its reset
> sequence before subsequent register accesses.
> 
> Without this delay, USB initialization can fail on some Qualcomm
> platforms, particularly when using super-speed capable PHYs like
> the QMP USB3-DP Combo PHY on SC7280/QCM6490.
> 
> The change is taken from following upstream Linux implementation:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/core.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b0

Is this the correct commit ?

3d25d46a255a ("pmdomain: qcom: rpmhpd: Add rpmhpd support for SM8750")

It seems it is not, so which commit added that 100ms delay to Linux ?

> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   drivers/usb/dwc3/core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 847fa1f82c3..ff0bca0dd8e 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -94,6 +94,8 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
>   	reg &= ~DWC3_GCTL_CORESOFTRESET;
>   	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>   
> +	mdelay(100);
> +
Is this DWC3 specific or QCOM specific delay ?

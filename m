Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BE4C61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 09:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A13FD4070A;
	Thu, 27 Aug 2026 09:50:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IgTrH_e5hFE9; Thu, 27 Aug 2026 09:50:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787824248;
	bh=62uaUix2rhsWUXIw0dFD38Cbf1Z2otnkAPaFac8Rw2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yqg0SAoM4CSKnTfjt9XOPhezgdrdLEyBpmru/IGWUORe6jcSAJ3BhqhbEMtFXm1Z0
	 hluIwmoUSzc2Ra2I6yw/miD2uCSvC4okW2OimKXYn3XeCLdzxFDzVXHuer1XruBdo5
	 PrU3ffE+GuNeJJmYzs37HCjlIbPlBlYw3naXynQtebiJZLPjvON8w1O6iEKr9urKnq
	 XQ0/kfbogPenmW9L7j1JdLOgiBj6NGsaCMKTLXq4eJ6CfV+gbhgrEqxBVCn9dJY+3t
	 j9NlRLmSJSYbhUmIP2cwwTN1Lauq05aW3ksDZg6a/HV9bu1dtT3juwPvtwGXSlmEyX
	 Cb9scFgqX4eTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A6F7406EF;
	Thu, 27 Aug 2026 09:50:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1130B7AA
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 09:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EBAF780DF9
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 09:50:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xc4REdvDFcP7 for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 09:50:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=cq8ttJSD; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=XWYZnM0E
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF26E807EF
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 09:50:45 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hVxbR4FNczKmKJ;
 Thu, 27 Aug 2026 11:50:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787824243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62uaUix2rhsWUXIw0dFD38Cbf1Z2otnkAPaFac8Rw2U=;
 b=cq8ttJSDCMbu1Or4S5A7z/1yAIca96sZjbJx0z/w5l8S6uk6qytGyAg1yf1vqj1j5nuDmu
 K2pgSZGhRIpMfKassEBSELv3szYPTjkkDTrX+tDIMYJiqxztSKY9vlJhtxu7YRGTxWSN2v
 hqH/FFU+hjqcXr7gXjhy6colPxeo7t0RP2gPP8lMtUFVMGAWrB3i2PCbjdGP9Dm7sxV41N
 zssoN/cVhPrxiM2qT/xasc4G+6Gy6yRsN3mo2B3AD4HTzhOt4P+eFh2pyCC35j9RQcYJhc
 Dj7MCsX5jr8JyZ5mF1rX3VQ22k1kOHsr+wAGTNyXyT4oyWNwd/AKUiEKtJ2CVA==
Message-ID: <2cf31eb9-90d5-456a-b290-badf8dc9ead2@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787824241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62uaUix2rhsWUXIw0dFD38Cbf1Z2otnkAPaFac8Rw2U=;
 b=XWYZnM0EXgBraNkRZvuxJtHrc11fdgL4EczJtJC/TgO9Um1MmYwFgLFMmWTJ+LhOkRTy8E
 Rg4u0yiFHUy3naI/2SPYZ6kkW2QXzsQUlCw0STRpvcT/IJPeXphjJ4JyqaNRRy+X++Us/i
 yPBTlubJtxSHFI1oGPusWdpdmSAp2VcZ2bqmB59P14BZSzsojR0sCvBPCf9pjugT1yp1X4
 6yKlZ2MKVNHxQ4Qvvqnp+tvi2ZU/LKXnGGqxIGnU1D2ug7aB8GUri9y+0Oovz4xr797C7s
 S1u4fIkiJKOup1KYDhXK0JEkxD5Vva7JZnAlaY0wWSDvxjzn+u7VDO5q/z0y3w==
Date: Wed, 26 Aug 2026 14:28:14 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/6] usb: dwc3-generic: fix ref clock lookup indexing
 wrong clk_bulk array
To: Stefan Eichenberger <eichest@gmail.com>
Cc: francesco.dolcini@toradex.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, marek.vasut+usb@mailbox.org, alice.guo@nxp.com,
 antoine.gouby@toradex.com, stefan.eichenberger@toradex.com,
 emanuele.ghidoli@toradex.com, franz.schnyder@toradex.com,
 balaji.selvanathan@oss.qualcomm.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, mkorpershoek@kernel.org,
 xypron.glpk@gmx.de, casey.connolly@linaro.org,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev, sjg@chromium.org,
 ernest.vanhoecke@toradex.com, u-boot@lists.u-boot-project.org
References: <20260824183048.419198-1-eichest@gmail.com>
 <20260824183048.419198-3-eichest@gmail.com>
 <e8ad2e6c-1852-4ae3-bb4d-6b76b9a0aee2@mailbox.org>
 <ao6TLnwbzqc-TcFp@eichest-laptop>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ao6TLnwbzqc-TcFp@eichest-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: mjsjm1ureeeui38o88ai8oytt9mcez8m
X-MBO-RS-ID: 7d4c1286da66df0e66a
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/26/26 9:18 AM, Stefan Eichenberger wrote:
> On Tue, Aug 25, 2026 at 01:40:44AM +0200, Marek Vasut wrote:
>> On 8/24/26 8:29 PM, Stefan Eichenberger wrote:
>>> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>>>
>>> On Verdin iMX95, with a USB hub permanently attached to the DWC3 host
>>> port the hub itself enumerates fine but a USB stick plugged into it
>>> fails intermittently:
>>>
>>>     Verdin iMX95 # usb start
>>>     starting USB...
>>>     USB XHCI 1.10
>>>     Device not responding to set address.
>>>
>>>           USB device not accepting new address (error=80000000)
>>>     Bus usb@4c100000: 2 USB Device(s) found
>>>            scanning usb for storage devices... 0 Storage Device(s) found
>>>     Verdin iMX95 # usb reset
>>>     resetting USB...
>>>     USB XHCI 1.10
>>>     WARN endpoint is halted
>>>     WARN endpoint is halted
>>>     unable to get device descriptor (error=-22)
>>>
>>> Commit c6583354b7c1 ("usb: dwc3: Look up reference clock DT phandle in
>>> both controller DT nodes") added a fallback that searches the DWC3
>>> child node's "clock-names" for "ref"/"ref_clk" when it isn't found on
>>> the parent glue node, but always resolves the found index against
>>> glue->clks, a clk_bulk populated only from the parent glue node's own
>>> clock-names list. This is wrong since the child node's clock-names list
>>> is not guaranteed to be in the same order as the parent's, and indeed on
>>> Verdin iMX95 the child node has a different order than the parent node.
>>>
>>> Fix it by resolving the index against the child node's clk and ensure to
>>> enable the clock before using it.
>>>
>>> Fixes: c6583354b7c1 ("usb: dwc3: Look up reference clock DT phandle in both controller DT nodes")
>>> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>>> ---
>>>    drivers/usb/dwc3/dwc3-generic.c | 24 ++++++++++++++++++++++--
>>>    1 file changed, 22 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
>>> index 2356b3bc0aa..e16d236bd9d 100644
>>> --- a/drivers/usb/dwc3/dwc3-generic.c
>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>>> @@ -31,6 +31,7 @@ struct dwc3_generic_priv {
>>>    	struct dwc3 dwc3;
>>>    	struct phy_bulk phys;
>>>    	struct gpio_desc *ulpi_reset;
>>> +	struct clk ref_clk;
>>>    };
>>>    struct dwc3_generic_host_priv {
>>> @@ -76,9 +77,28 @@ static int dwc3_generic_probe(struct udevice *dev,
>>>    		index = ofnode_stringlist_search(node, "clock-names", "ref");
>>>    		if (index < 0)
>>>    			index = ofnode_stringlist_search(node, "clock-names", "ref_clk");
>>> -	}
>>> -	if (index >= 0)
>>> +		/*
>>> +		 * glue->clks was populated from the parent glue node's own
>>> +		 * clock-names list, which can differ in length/order from
>>> +		 * this child node's list (e.g. i.MX95: glue has "hsio",
>>> +		 * "suspend", the dwc3 child has "bus_early", "ref",
>>> +		 * "suspend"). Reusing this index against glue->clks would
>>> +		 * silently resolve to the wrong clock, so fetch it directly
>>> +		 * from this node instead.
>>> +		 */
>>> +		if (index >= 0) {
>>> +			if (!clk_get_by_index(dev, index, &priv->ref_clk)) {
>>
>> Would it be possible to call clk_get_by_name(dev, ...) and
>> clk_get_by_name(dev->parent, ...) instead, until one of them succeeds ? That
>> could make the code simpler.
>>
> 
> You are right, I try to rework that in the next version. Thanks for the
> suggestion. I will also remove/replace the debug() calls.
Excellent, thank you !

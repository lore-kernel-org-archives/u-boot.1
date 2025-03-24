Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D726C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 19:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61DA4805D7;
	Mon, 24 Mar 2025 20:48:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kaqT7F9B";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZnUdWeDs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83A12806FC; Mon, 24 Mar 2025 20:48:44 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B088280548
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 20:48:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZM3Ws3D21z9t7d;
 Mon, 24 Mar 2025 20:48:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742845721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fd8gEJCcWTiqCz3/DQR61krWy+3QuvaJ4VuhNBo0LlU=;
 b=kaqT7F9BhQ1MIATSz4VWeDQgqVIabay/qT5DiTn9/ozc6UkGE2O2xyCHXhVlIpXfuLeFIr
 KmYpaSn24o20TF3XH4Kq3qTJaX90j+cUff1v7BiuRpShQheHd76iAUUlrO3IEj41R56ufL
 2PGAr0BT/0AOFCph7x3HsMMAWUZVUsbNGNy9qGN6GPWRxr907aUdrlRnpNYU8OYJhxqs0a
 R/irMRdJr8PHvT925MNmAW7kE8TTTiMDUeTTmf8I3CK9xgsxA2/Nd6ZqRRGcStrvUxKPRr
 zWyyzbqFyXwKih7VLJ0gCTgqtuKsKSR/CQug4UrkWvyql/7pCZ9jTVd5gznxPg==
Message-ID: <55870d86-cee8-4628-844b-57a340fac4b3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742845719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fd8gEJCcWTiqCz3/DQR61krWy+3QuvaJ4VuhNBo0LlU=;
 b=ZnUdWeDsE4toGw1lr1MuTbdCZbkgpHVspxfPjlRa/tlxiI9tJj1BIwUnq+vCk+UVQbZKoy
 svLOmxdDaawVyHQfD0ToDkVhEIq/o4pS0H9iBFzXrHUAxD4KCWawU8r2rewu6opMnGIryM
 3/F4jrThNa9CiZ5Tjqk0GwuXdZ2CmC3SLrFS6Gvon4uELbpEyRf47d/6v1V0f/CRu7H3rA
 gIKcMba3s3KNNxpQFDT5FQTpbmLFVRibrCjZNza9VzhnGmrREJfjLG2RUdDMnUiD/fP8Sf
 1uVvV5xl1JBl1gjdd8qdYL0tAx836H6dHgib+e6evIM6c6+h21VfWEEo5qwS4Q==
Date: Mon, 24 Mar 2025 20:48:37 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/4] net: ravb: Add optional reset deassertion
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250319120401.8297-1-paul.barker.ct@bp.renesas.com>
 <20250319120401.8297-3-paul.barker.ct@bp.renesas.com>
 <fa596092-ac67-48c0-8178-1c78b86c9306@mailbox.org>
 <a299da4d-50d9-412f-8b89-70d82c68787b@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <a299da4d-50d9-412f-8b89-70d82c68787b@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 9z6cry1ie5yshw8iuepzpe89sipt9pd1
X-MBO-RS-ID: 6d3b6678f8784da19e1
X-Rspamd-Queue-Id: 4ZM3Ws3D21z9t7d
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

On 3/24/25 10:57 AM, Paul Barker wrote:
> On 24/03/2025 01:08, Marek Vasut wrote:
>> On 3/19/25 1:03 PM, Paul Barker wrote:
>>
>> [...]
>>
>>>    static int ravb_probe(struct udevice *dev)
>>>    {
>>> +	struct ravb_device_ops *device_ops =
>>> +		(struct ravb_device_ops *)dev_get_driver_data(dev);
>>>    	struct eth_pdata *pdata = dev_get_plat(dev);
>>>    	struct ravb_priv *eth = dev_get_priv(dev);
>>>    	struct mii_dev *mdiodev;
>>> @@ -648,16 +653,32 @@ static int ravb_probe(struct udevice *dev)
>>>    	if (ret)
>>>    		goto err_clk_enable;
>>>    
>>> +	if (device_ops->has_reset) {
>>> +		ret = reset_get_by_index(dev, 0, &eth->rst);
>>
>> Can devm_reset_control_get_optional() maybe be used here instead of the
>> flag ?
> 
> The Ethernet device tree nodes for RZ/G2{H,M,N,E} also contain a reset,
> so we can't use the _optional() function here to perform the reset only
> for RZ/G2L.
Does it pose a problem if we trigger a reset on RZ/G2(non-L) ?

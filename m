Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51348D65C7F
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 01:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56D1F83B49;
	Thu, 18 Dec 2025 02:34:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Dx4n7NHM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2260A83B55; Thu, 18 Dec 2025 02:34:54 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFAEF8367F
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 02:34:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dWtWY4xGXz9tRc;
 Thu, 18 Dec 2025 02:34:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766021689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=alyRLkz/Dhb4dzoe5mp7BQBX3Y+Gj9vtuDQCxJlmyhE=;
 b=Dx4n7NHMwMrElt6aHTJHKI9KYrA+KZnFKacuoKoGKGVutsZTMsvQUNVDcx87hWBs2D4XBE
 LBOQ04mVZZX/ha/+wN+iJwKVvZNzzSN6CJ5IWUjFpoIs9ub6HxFkl/Xs+lcpItVppMaqnE
 nw/Y3vN/4SazhQDuPl9/aMuddeqJw7nPd2rDiFv2iaQm2WlQ6vxV8LAjqOhEkO+WepFvSC
 onGke7cDg9m3fEE4TPNgr+7b3RnT40oY1sKXu+Hv4j3jQRqzeXO476dpMLEPOvGjRM/rqw
 wEamyJxpTPqTzGUwjTy/wWanEA7RzGyajSfBRBJoTGn92RTPugaz8Rc9YUjjxg==
Message-ID: <ca28c272-6119-43e5-b116-4b87a2d06da8@mailbox.org>
Date: Thu, 18 Dec 2025 02:34:46 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] usb: dwc3-generic: add support for exynos7870
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20251017-usb-dwc3-exynos7870-v1-0-fe46e2ed1908@disroot.org>
 <20251017-usb-dwc3-exynos7870-v1-2-fe46e2ed1908@disroot.org>
 <89608e43-92ab-41e1-b5c3-79ca01f0360f@mailbox.org>
 <8ab651a86f646035edfa06f7e79e45b1@disroot.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <8ab651a86f646035edfa06f7e79e45b1@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b8cbc46e7cff08afb55
X-MBO-RS-META: 985nhynonp6cf4f35kki688z4p4dptoe
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

On 12/16/25 6:08 PM, Kaustabh Chakraborty wrote:
> On 2025-12-16 11:13, Marek Vasut wrote:
>> On 10/17/25 5:30 PM, Kaustabh Chakraborty wrote:
>>> Exynos7870's DWC3 glue layer is quite simple, consisting of a few
>>> clocks, which is handled by this driver. Add the compatible string in
>>> here.
>>>
>>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>>> ---
>>>    drivers/usb/dwc3/dwc3-generic.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
>>> index 1967594f48ab40963463e6f17ed58ec45ce5867c..622847a9daf8e3c5cba4e4a9414b50e8a050df55 100644
>>> --- a/drivers/usb/dwc3/dwc3-generic.c
>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>>> @@ -710,6 +710,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
>>>    	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
>>>    	{ .compatible = "fsl,imx8mq-dwc3" },
>>>    	{ .compatible = "intel,tangier-dwc3" },
>>> +	{ .compatible = "samsung,exynos7870-dwusb3" },
>>>    	{ .compatible = "samsung,exynos850-dwusb3" },
>> Please keep the list sorted.
> 
> This is... already sorted?

Sorry, you're right.

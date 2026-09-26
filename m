Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4986AC9832A
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 23:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4C50810AE;
	Sat, 26 Sep 2026 23:41:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xytl2tuFBdY4; Sat, 26 Sep 2026 23:41:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E309F8109F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790466092;
	b=L74B7iK6XOZbpspr28OISJ0AVf0YuLfpEBUw1xnki262ncb2ejhXtY+apnsMVaQP/tsC
	 tinV3UVy5R8iTrtiDlaHNz1t82aQ8CT7K4oOnNvk3zxuOyp3Rcka0lF57beTJ00EBnocT
	 rjq30iZ8PeDfrBzQGjab26p/uD1zA28UEmZMRZe8gsu3b172cWgQFxRe+DnB7HZRJVrCR
	 oynRW3wDYrXlYQ/qV0v8oGiEkNwJhYibRXtRDUB2llCMQFJZ3nou/Vtv6kEuaKfiYhRT2
	 sIDtRbVkmNmumVL9YkvAFIrmMEWlKlkBHWOBV0gj5eyK/GKG80doYijHYaNJXvIPctg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790466092;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vuW0OXkme4oSoO9EICLyegze/Uo7ZyMQx2PitV0LDps=;
	b=id5gbAlw4o52e47cJ+ovEZBTvDVsQfgFT9boLk8gTSFIJYQ2/wFBCtyygfd0QBI6aTAD
	 Tno3ty52B9nH/wdp0Isl8+Gu8KnqFlDpBj37sEbpgpp0P+9BfRhfAFOquf4sdRbc+tEB7
	 qD02iKg+E7DzNAg3VK9seSI6eSqlbF7rDU2cs8+LpVsX8yzHQpLZt9OundoQCvZVKGe4d
	 tGH4wYvsTQdklRjmUVravApyZUXhwkpepBElxxxcmFL7Q1UCDbofuE7HM1j4yfX5QeUly
	 Fp8TSjsd5Xnjm/RTIocrCCbO4XYo2ikIa5uMVjjJkjUDrZlGoOu/9czFVw4Puigb68Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=UbBjODK+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790466092;
	bh=vuW0OXkme4oSoO9EICLyegze/Uo7ZyMQx2PitV0LDps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E6ppO9FGsy9hrnFAiR6S2UaCpIMRsPuw4WzTZQxXwuQkAR+Dgf71U4M9rsMEAkAqc
	 RUx+JIxqdONz5Ut7OaG0AdQMPaTEo4vEV1QRK5uRRIuftSMkZMuDxB+vCT5L5Af+zO
	 xe8GDi0aFezvCZ9a/d4fKKYWbNiGgCRTuo+13hNwTsrX7iJxz/kCcTtnKCiA2hbhaU
	 aTSFWIaGdkUbwMmXWT2B6+PsCgyb5thYIbYwxICPVXHbs8duH9RtRgbmLWcwyV8oRp
	 aYo0fGtDYNHB3iNgiCVlc8NuR6oHqXk1jC27IB2cDk/dpzLxE4zFx19nl0NLv63fks
	 s/Uf7qX3/C8ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E309F8109F;
	Sat, 26 Sep 2026 23:41:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 293CB335
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 23:41:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0EE618109F
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 23:41:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lpiTBmK4tJjG for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 23:41:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 82A028109E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790466089;
 b=IIuw+Tmz+y01jYeS4f2uEvIW6oBOX5WUi2iCxetmcEwH3Z/tSK/6CEMixnb5yZTj7lm0
 EHiWtHaGIvqw20mxZXfLcJCW/cyzGbLvMRsSgFdBnaDRlOnFKaz3oXaP8DdrVxNGepaD3
 cSLElfTaMJTG0vY3wguJcMwmzEnFRc/piRocKO3A7tAYN+4QjS6W5/4YBCscGvWWxcvmF
 e/CkZWztB9+mIXOMc0/r2B2LjWQq6uBzxS8Ik4i3I6h3vvYO7ppGmVEkQNA4KsGt9Ze6Z
 NT/9O2+89nKwEsUB6cGHfCu4WGuVpSlx0sFdnudxXrZE7dxituMWUod1Dw7wmOJ7nQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790466089;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=vuW0OXkme4oSoO9EICLyegze/Uo7ZyMQx2PitV0LDps=;
 b=XU2ifh5AbTeCuk29Aww7OQx7zRaq8zF7OxBTx4cN81AUAhY145cirMIihO6sZLD6kl2j
 VFqHL0K1V7LfVok2sisNp6JOmwyeRz1s9zziO4yc4FHyZi42lV4gDCQ699Yk3vAXDmfwn
 D3/kz+2ex29hgDwK7+BVs8iQ1julEB4ObOCiYWfB5m4EuPy7nyyvr73p83xYOeWxzNFXV
 +DGC/WhMJXXVfifjRIdYGHGxKJfIhYlA1EGVsBTTmaXT6O72qMQ7a2BK0znsXMAUgObd2
 kihMrACgbT/9ktvK0DFMH3J4FE57eCc6lzmMrxhWYa4acoLHMV7PG4cunUhi2D6AtBA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=UbBjODK+; 
 arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=UbBjODK+
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 82A028109E
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 23:41:26 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hskc21xgtzMlSj;
 Sun, 27 Sep 2026 01:41:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790466082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vuW0OXkme4oSoO9EICLyegze/Uo7ZyMQx2PitV0LDps=;
 b=UbBjODK+BG3a9c5obeY7VUQRMxSimDnthrbvhS26yBitxEyy9vbxA+AhIzEEkzubfqjbTV
 RV9V8uhnBW2ZbNsiMYPcZDglxDkbNMTt7qsc1fJQSBbVjz9uU07pd8/fQFlVQ2qQL59sIk
 gqCJekbZv5FEAI/QlABMC0eD+FC1lTttfci67pgK57brzxBedwO+mplzxmC2sFlKMvMTdO
 bREVoeS76QpWGwpRo8Q7kNbhboJC0d99Eu/bgqz/MV6PCX6jO66tZuQ4yamVV0cedEuwd/
 Z5lnywcw44xOcPcu9qDO312frB+wDupHEfDwuX8+n7VvsRBEl8D8n/DKhA9dGA==
Message-ID: <5883d25c-fa3c-49a0-a970-8b5b0fd35c16@mailbox.org>
Date: Sun, 27 Sep 2026 01:41:19 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] usb: dwc3-generic: fix ref clock lookup indexing wrong
 clk_bulk array
To: trini@konsulko.com, stefan.eichenberger@toradex.com
Cc: u-boot@lists.u-boot-project.org, Stefan Eichenberger <eichest@gmail.com>, 
 mkorpershoek@kernel.org, Tom.Hsieh@advantech.com,
 hayashi.kunihiko@socionext.com
References: <20260925091203.44385-1-eichest@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260925091203.44385-1-eichest@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: femikt3sd3igzgc5wjroew9fcup85hha
X-MBO-RS-ID: 045e6b99d2b27e2f32e
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

On 9/25/26 11:11 AM, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> On Verdin iMX95, with a USB hub permanently attached to the DWC3 host
> port the hub itself enumerates fine but a USB stick plugged into it
> fails intermittently:
> 
>    Verdin iMX95 # usb start
>    starting USB...
>    USB XHCI 1.10
>    Device not responding to set address.
> 
>          USB device not accepting new address (error=80000000)
>    Bus usb@4c100000: 2 USB Device(s) found
>           scanning usb for storage devices... 0 Storage Device(s) found
>    Verdin iMX95 # usb reset
>    resetting USB...
>    USB XHCI 1.10
>    WARN endpoint is halted
>    WARN endpoint is halted
>    unable to get device descriptor (error=-22)
> 
> Commit c6583354b7c1 ("usb: dwc3: Look up reference clock DT phandle in
> both controller DT nodes") added a fallback that searches the DWC3 child
> node's "clock-names" for "ref"/"ref_clk" when it isn't found on the
> parent glue node, but always resolves the found index against
> glue->clks, a clk_bulk populated only from the parent glue node's own
> clock-names list. This is wrong since the child node's clock-names list
> is not guaranteed to be in the same order as the parent's, and indeed on
> Verdin iMX95 the child node has a different order than the parent node.
> 
> Fix it by looking the reference clock up by name with clk_get_by_name(),
> trying the dwc3 device and then its parent glue device, so the clock is
> always resolved through the device that owns the node its name was found
> in. Also enable the clock before use and fail the probe if that does
> not work, and disable it again on the probe error paths and in
> dwc3_generic_remove() to keep the enable balanced.
> 
> Because of moving to clk_get_by_name() for receiving the reference
> clock, also ensure that the parent driver is a DWC3 glue driver before
> looking up the reference clock, since the parent could be a bus or root
> device with unrelated clocks.
> 
> Fixes: c6583354b7c1 ("usb: dwc3: Look up reference clock DT phandle in both controller DT nodes")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Tested-by: Tom Hsieh <Tom.Hsieh@advantech.com>
> 
> ---
> Changes in v3:
> - Ensure that dev->parent->driver is not NULL (Marek)
> - Return with an error if clk_enable fails. (Marek)
> - Balance the clk_enable() with a clk_disable() on the probe error
>    paths.
> Changes in v2:
> - Check if the parent driver is a DWC3 glue driver before looking up the
>    reference clock. I use driver->name as this should work with all
>    implementations used today and I hope this is more generic. (Marek)
> - Add Tested-by from Tom
> ---
>   drivers/usb/dwc3/dwc3-generic.c | 69 +++++++++++++++++++++++----------

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>

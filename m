Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C876606A32C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Iws9Tio8;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=diBmSsO6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EEC18129F;
	Wed, 18 Nov 2026 22:32:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RpBSSN2tTfv0; Wed, 18 Nov 2026 22:32:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9A68C81298
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795041164;
	b=pOgnVUjJleQTcrHEikeDdV7G6iwqzvjrlowqcKYtSrRDmlqGb9Ig1n1yX6vGB5ZVNlxc
	 L9rh0McogxHAYrsJIFJrOEviTu8ngnyU6UvWQM0fHSIMJZqGR5R0Rfjg6eJXszbWDsYnF
	 j8+Kd+xSmDvPIUeLL+0ZQuCnhYBNvPkI0U6J6GDItSL0GmBEQWnLFihrY+fCgrpURTdgP
	 Fdxn5eqE/1Z5zUVg21vpm6Hi1pqdJ2gON9qFGTqEVZLJybJg/Zjyc+HNy0VYs1uDZlCap
	 rVQgVbktjMyM+kJ5u8xpb3C2uw+ST0uVv0rpofsEWkEwLrp9J/6UlCO7uofl0+6GqYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795041164;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2Ri38WojHEtY03mmFtzxHw2D+kQegrWUAxnwQdwzf+I=;
	b=HDcFvFwGYNbRHDAOOcffM1eACvsNDaF8ymOnJPtzTX/2cZepbnHjrJFRHyb/Mw76fvyJ
	 1Al+6kE/WH+xxv4JYC6sGkJ6h8YtqYKtUPVovopVkyeqLu50HHTMHGmQl3/t8pLQ+1h16
	 X5eErSE1KWdwzV98RHrfek85S6m2yWB77o1+4/V99HqjI8ef07K7G87zL7H9peNkAMRMi
	 miGuBM5RoNwCYCNDurcwhCH7ZI3Hjz+bNkeBFfEUY5eGvwRBa2gl31C1It5fBbDr2CIiB
	 hRS744yRlFOgjylg3tCZXTcuInT2Gh8qZQpml88hYwt6NMAJrqGYFJ4KLVt6TQs2pAQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795041164;
	bh=2Ri38WojHEtY03mmFtzxHw2D+kQegrWUAxnwQdwzf+I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Iws9Tio8gs7xPiQOXcXULZ1eIPKvBv2eHlIfVLHHNrUhWKohUt3+cmRrAQ2ogPNRK
	 NRJM9zx5nfVc++cpbmlEvdgBbHvqvPhTD/1UY5SYUYMU56IbOz3ONiiqJqfbbrjknJ
	 1a7I+n9MP7cuBzJaoM1h1VNjvLhV+lr4/bKLQsMcxqnTqeYjrQ7enHBP6JaD3kMD2x
	 M8E3g7+XFL7NfUGP9LqpGfTH3bwjdXFj9lstpFzhbcs6i42XSRFPqYsHXjT445m9BK
	 Lp4KLi1dBRc0RQun4+aDK5lNc5VTJqS8QdkrP7MccZzbfzQKpgGA0b33/rnWs61wL4
	 cNHjZ1NEnhnyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A68C81298;
	Wed, 18 Nov 2026 22:32:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C415392
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 22:32:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 51BD54084A
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 22:32:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xLnM8jId5aLZ for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 22:32:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 422FD40722
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=diBmSsO6
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 422FD40722
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 22:32:40 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jVGZF4LGkzKvnM;
 Wed, 18 Nov 2026 23:32:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795041157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Ri38WojHEtY03mmFtzxHw2D+kQegrWUAxnwQdwzf+I=;
 b=diBmSsO6ZSEkUwv3JMX4lLQVr3f24yzmvV1wSR37j6oNX+gRdeIAGD5vQRBCd9jYvmA3zt
 cXa8MqHSm6d6rk6UaGX+QkPkGeLW0Kt/Uw1SMhF/Axpa26fAH3QoY4acprAOcueKyn4lDO
 ZVyJyg8E9z7ahhdh8pTmoeMCqrOh52S9t12LIZNuejAbk477p5K7QXbk2NCttNYiYV7TcV
 NtV5H3JJjlaorl9LxnNCOt64LxgXHUQxsZ3Aw9LCNrboHAhPvfLbNRu8xd7GUQKa2iFmRi
 J/eSC6o1r2dXFTdYEeJ8ftMwUeiktHvlQKrx+NpQeKm6Tzlo6675Xgo4J654zg==
Message-ID: <44727446-1c27-4056-b0f6-031707f3aa0c@mailbox.org>
Date: Wed, 18 Nov 2026 12:21:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: onboard-hub: Move usb-onboard-hub into drivers
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Alexey Charkov <alchark@flipper.net>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20261118072332.627163-1-marek.vasut+renesas@mailbox.org>
 <7bcca998-bc6d-471c-9534-5c218f79b460@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <7bcca998-bc6d-471c-9534-5c218f79b460@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c0ab1bddcfa04bee41a
X-MBO-RS-META: xbgf5aa9w93eibzakzpub657pk89rt8r
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 11:44 AM, Quentin Schulz wrote:

Hello Quentin,

>> diff --git a/common/Makefile b/common/Makefile
>> index d62ea34599e..ac6a2d1ae6a 100644
>> --- a/common/Makefile
>> +++ b/common/Makefile
>> @@ -35,7 +35,6 @@ obj-$(CONFIG_PHYLIB) += miiphyutil.o
>>   obj-$(CONFIG_USB_HOST) += usb.o usb_hub.o
>>   obj-$(CONFIG_USB_GADGET) += usb.o
>>   obj-$(CONFIG_USB_STORAGE) += usb_storage.o
>> -obj-$(CONFIG_USB_ONBOARD_HUB) += usb_onboard_hub.o
>>   # others
>>   obj-$(CONFIG_CONSOLE_MUX) += iomux.o
>> diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
>> index db8f35c10c4..e7d5356e521 100644
>> --- a/drivers/usb/common/Makefile
>> +++ b/drivers/usb/common/Makefile
>> @@ -9,6 +9,7 @@ obj-$(CONFIG_USB_GADGET_DWC2_OTG) += dwc2_core.o
>>   obj-$(CONFIG_USB_ISP1760) += usb_urb.o
>>   obj-$(CONFIG_USB_MUSB_HOST) += usb_urb.o
>>   obj-$(CONFIG_USB_MUSB_GADGET) += usb_urb.o
>> +obj-$(CONFIG_USB_ONBOARD_HUB) += usb_onboard_hub.o
>>   obj-$(CONFIG_USB_R8A66597_HCD) += usb_urb.o
>>   obj-$(CONFIG_USB_EHCI_FSL) += fsl-dt-fixup.o fsl-errata.o
>>   obj-$(CONFIG_USB_XHCI_FSL) += fsl-dt-fixup.o fsl-errata.o
>> diff --git a/common/usb_onboard_hub.c b/drivers/usb/common/ 
>> usb_onboard_hub.c
>> similarity index 100%
>> rename from common/usb_onboard_hub.c
>> rename to drivers/usb/common/usb_onboard_hub.c
> 
> I'm very confused by the various Makefiles at play to reach drivers/usb/ 
> common. It seems like the root Makefile unconditionally mark drivers/ 
> usb/common as buildable? But then drivers/Makefile has a bunch of 
> entries specific to SPL only. What's actually going on? I'm trying to 
> figure out if this move truly is equivalent to the current state or 
> whether there's now another Kconfig symbol in the dependency tree for 
> usb_onboard_hub.c to be built.
The Makefiles in general likely need a clean up, so if you have any 
specific concern, can you please send a patch ? Thank you !

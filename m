Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3950DFF6E9F
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 00:07:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0475C83FA3;
	Wed, 18 Mar 2026 01:07:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dcaUt4U2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RXEiKrOU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF0E383FAF; Wed, 18 Mar 2026 01:07:46 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D93183FAF
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 01:07:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fb8KX58Rfz9tW6;
 Wed, 18 Mar 2026 01:07:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773792464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1/nljHR/YbUQFR/DhYKFJi08ytNVK+y1cE/Qsqr0ay8=;
 b=dcaUt4U21MOalQCjPHB9eX2HHABfB0n9KOjzr6JbTegYcYQ9giLHPHHvCrwQkuSh720SnS
 z3BHpSN3bDTTinNOojvmM6RruBKTNZ5A42MIJWUQ/ZQ5KAFaybu7LA9qpi0YqYodsSnxQy
 s0m1csi+GAGNFWtfyemrsvzK0bkdf6UXMDcAOaNCzANZT+zeGQBI3sQfbWgVWa8zd76qFI
 SVdmdAcLvk7vUhc6wtTKbQbr2nbtQtS5dqoy7upF1D37Q3EOdGOQFOY5uNNLN0BMg5YmMl
 KWz4ahM7b51l6iXE17FGi0i42KsihcV6SpwEVOxoko4kDpBeqaQXbKvgHIXbXw==
Message-ID: <58699be1-5414-4749-9975-7fdf0064b1a3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773792463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1/nljHR/YbUQFR/DhYKFJi08ytNVK+y1cE/Qsqr0ay8=;
 b=RXEiKrOUzOeyVEy7MsCmYbQn0GfwZrydRP0rJIuE0AuO2T0dL6/k5TCce4Q29zCT1gOeHQ
 LQH7zDYuajj2qi3iEsaM4w42FBqZ3oDcFT8jOpqYgm8KTLhwHLw52IJGNl04XcCX6E5vmd
 a8ruI2VICS/DGRxKW21VDTgkugLKlKqh1wbu+tRXZvcyONwOWTCtcc23j7aPhr0GB3cFm5
 lxfz9mxRHRuusadrMdutOlTV3qcvTt+COkAC+7PthqDESe5hppnPuKZuLB0MUqbrTyP39S
 XXX4e/ijRWO2/5Y0hXkwNQTn9buEkyEaeUGaVlefuDOucCju4rR/n6O2cYKjjg==
Date: Tue, 17 Mar 2026 20:41:26 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] reset: Correct dependencies for RESET_RZG2L_USBPHY_CTRL
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260317012443.4162600-1-trini@konsulko.com>
 <ed88ec35-7d53-48df-a65b-7da1298e265b@mailbox.org>
 <20260317134008.GQ502704@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260317134008.GQ502704@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 39c169490c5d27af7ce
X-MBO-RS-META: iwppkmduxej156898rusxj8cabctytki
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

On 3/17/26 2:40 PM, Tom Rini wrote:
> On Tue, Mar 17, 2026 at 03:33:57AM +0100, Marek Vasut wrote:
>> On 3/17/26 2:24 AM, Tom Rini wrote:
>>> As exposed by "make randconfig", we have an issue with the dependencies
>>> for RESET_RZG2L_USBPHY_CTRL. As REGULATOR_RZG2L_USBPHY depends on
>>> DM_REGULATOR this symbol must also depend on it as well.
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>> ---
>>>    drivers/reset/Kconfig | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>>> index 66911199c8ba..3f0ec50510c0 100644
>>> --- a/drivers/reset/Kconfig
>>> +++ b/drivers/reset/Kconfig
>>> @@ -239,7 +239,7 @@ config RESET_AT91
>>>    config RESET_RZG2L_USBPHY_CTRL
>>>    	bool "Enable support for Renesas RZ/G2L USB 2.0 PHY control"
>>> -	depends on DM_RESET
>>> +	depends on DM_RESET && DM_REGULATOR
>>>    	select REGULATOR_RZG2L_USBPHY
>> But this already selects REGULATOR_RZG2L_USBPHY , which according to
>> drivers/power/regulator/Kconfig contains:
>>
>> 508 config REGULATOR_RZG2L_USBPHY
>> 509         bool "Enable driver for RZ/G2L USB PHY VBUS supply"
>> 510         depends on DM_REGULATOR
>>
>> which does depend on DM_REGULATOR transitively ?
> 
> That's why Kconfig complains about the unmet dependency. "randconfig"
> does some fun and apparently valid things.
That's the thing -- if RESET_RZG2L_USBPHY_CTRL depends on 
REGULATOR_RZG2L_USBPHY which depends on DM_REGULATOR, how can 
DM_REGULATOR be unset, while RESET_RZG2L_USBPHY_CTRL is set ?

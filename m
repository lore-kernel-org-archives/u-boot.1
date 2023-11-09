Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793C3C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 10:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 922EF87120;
	Thu,  9 Nov 2023 11:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="bVqyIIVx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71124871FC; Thu,  9 Nov 2023 11:43:19 +0100 (CET)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE0C786A4C
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 11:43:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 26F821BF20A;
 Thu,  9 Nov 2023 10:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1699526593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8gkOmniIdrfCJhKjqNaOaqFzw2iosADP2Bv8nlCRuvU=;
 b=bVqyIIVx4rj4AD0ZA1iAckTG857Km+gPxSdxJdmEFRHfRET80SfYdnriny2scEc2YjDOJx
 pIz3OV340buFfskm7TVcS2MgdY2Ef5lqtHt7BVhaVkVvwYpYjlPtNfYq50gaHef2CUhSUH
 0pmAS0EPYsecD44GmX/fSRNH+qCKGyAlULV7yFv8Sp3ZIjhIzZCFmUI25ONPm0vIsP/knz
 FgOzXYF7AGP3UZSmaysX6OggU9Gzr1kRnPrYcBDkSyyV7c0kdfBAixUz5Og77UV/3uIXM0
 6bdSfLWk8BfaDPT3u8uU2LgVlOjrgCjCm8aRmZLZB/QMMLJJVr7GMdrF7JC91w==
Message-ID: <a8ee2c00-4824-4e3f-804c-0472d152a53a@bootlin.com>
Date: Thu, 9 Nov 2023 11:43:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] board: ti: j721e: Add the missing part of exit
 retention for k3-ddrss (J7200)
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, nm@ti.com, thomas.petazzoni@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com
References: <20231107161802.855154-1-thomas.richard@bootlin.com>
 <20231107161802.855154-7-thomas.richard@bootlin.com>
 <20231107181853.GK6601@bill-the-cat>
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20231107181853.GK6601@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com
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

On 11/7/23 19:18, Tom Rini wrote:
> On Tue, Nov 07, 2023 at 05:18:00PM +0100, Thomas Richard wrote:
> 
>> Add the board specific part of the exit retention sequence for k3-ddrss
>>
>> Based on the work of Gregory CLEMENT <gregory.clement@bootlin.com>
>>
>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> 
> If this ends up being physical board design specific and so someone
> making a new design for this SoC with a custom board layout entirely
> needs something else, we should think harder about what's in
> board_is_resuming() vs what we document the function does. If however,
> this is generic to the SoC and will be needed, it should be folded in
> with the previous patch and the commit message expanded, and the
> documentation part of this series explain clearly what the functions are
> responsible for.
> 

Hi Tom,

Thanks for all these interesting feedback's.

From my point of view, board_is_resuming will work with all j7* SoCs and
all new designs for these SoCs.
This function only read and erase a scratchpad register in the PMIC A.
So it should be ok for all designs which have the PMIC@48.

For the function board_k3_ddrss_lpddr4_release_retention, it's a little
bit more tricky. The sequence is specific to the SOC, but the GPIOs used
are specific to the board.

Regards,

Thomas

-- 
Thomas Richard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


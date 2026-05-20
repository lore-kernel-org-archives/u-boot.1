Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04EFCD4F5E
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 07:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E89CC8460E;
	Wed, 20 May 2026 09:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="JgZP4//a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 059D884659; Wed, 20 May 2026 09:04:04 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ABDC844CF
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 09:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 9C3201A363B;
 Wed, 20 May 2026 07:04:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6D52E6070E;
 Wed, 20 May 2026 07:04:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 986C7107E8748; 
 Wed, 20 May 2026 09:03:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779260624; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=TMu5EvPVsTolwhhxeVbx81siyOlA5EJVl42tFPox/rE=;
 b=JgZP4//ak5t0L9aM2GNdiOVjA2YJvQ00TMb0fKQURnZvIfcRzRZRayQRlwDabxOpgx/6Sd
 NMA7Aq+UIfpToxgYLjsPsEaRHqjRiM39wOqV921NVr117LP7GSCHOAwz+K/a0TJs/xcagA
 medx7vt2wswB4K3e3HYyeWihP2n1FAz9NwRQkex6tDGQjUMY/2Te0lBiPIBDvTypxvcHTo
 T+FCYeYOAe2jm0OC13D2c9+B2/QVW6Ps9Gh2/Qo0JWZOpc7C22693OUsJRgEw6aRNN8E8i
 OTexFs85famBM6YeZZApSXiRSQhEPPvbMD2QOZrGcWJC+bFhTVeqeTp+oRNpJw==
Message-ID: <baf062ec-fcdf-4a97-828d-16fea43c6b54@bootlin.com>
Date: Wed, 20 May 2026 09:03:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] board: variscite: add support for the omap4_var_som
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Heiko Schocher <hs@nabladev.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Anshul Dalal
 <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Daniel Palmer <daniel@thingy.jp>, Andrew Davis <afd@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Rasmus Villemoes
 <ravi@prevas.dk>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>
References: <20260519-omap4-support-v1-0-b4a2a7435775@bootlin.com>
 <20260519-omap4-support-v1-6-b4a2a7435775@bootlin.com>
 <20260519140331.GY1858239@bill-the-cat>
 <da0b5c7c-ba6d-45c6-b7f3-6d1eab05f544@bootlin.com>
 <20260519150121.GZ1858239@bill-the-cat>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <20260519150121.GZ1858239@bill-the-cat>
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

Hi Tom

On 5/19/26 5:01 PM, Tom Rini wrote:
> On Tue, May 19, 2026 at 04:55:40PM +0200, Bastien Curutchet wrote:
>> Hi Tom
>>
>> On 5/19/26 4:03 PM, Tom Rini wrote:
>>> On Tue, May 19, 2026 at 08:45:43AM +0200, Bastien Curutchet wrote:
>>>
>>>> OMAP4 support is present but there isn't any board using it.
>>>>
>>>> Add minimal support for the Variscite OMAP4-SoM (debug console + boot
>>>> from SD card).
>>>> Use the ti/omap/omap4-var-stk-om44 device-tree from the Linux kernel. The
>>>> real representation of the SoM's hardware is located in
>>>> ti/omap/omap4-var-som-om44.dtsi included in it.
>>>>
>>>> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
>>> [snip]
>>>> diff --git a/board/variscite/omap4_var_som/MAINTAINERS b/board/variscite/omap4_var_som/MAINTAINERS
>>>> new file mode 100644
>>>> index 00000000000..802059ea521
>>>> --- /dev/null
>>>> +++ b/board/variscite/omap4_var_som/MAINTAINERS
>>>> @@ -0,0 +1,6 @@
>>>> +ARM OMAP4 VARISCITE VAR-SOM-OM44 MODULE
>>>> +M:	Bastien Curutchet <bastien.curutchet@bootlin.com>
>>>> +S:	Maintained
>>>> +F:	board/variscite/omap4_var_som
>>>> +F:	include/configs/omap4_var_som.h
>>>> +F:	configs/omap4_var_som_defconfig
>>>
>>> So this could all be caught with:
>>> N: omap4_var_som
>>>
>>
>> Ok
>>
>>> Which is my way of moving to the next topic, omap4 needs a maintainer
>>> too, if we're bringing it back.
>>>
>>
>> Ok, I can also add myself in the omap4 maintainer then.
> 
> Thanks!
> 

How should it appear ? Shall I create an ARM TI OMAP4 section next to 
the ARM TI one ?


Best regards,
Bastien

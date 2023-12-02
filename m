Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A1DC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:20:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AFCE876B8;
	Sat,  2 Dec 2023 19:20:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FXx6Xtdc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EnQGJN0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65EA6876A7; Sat,  2 Dec 2023 19:20:20 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D2FA876C4
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:20:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4SjJBT5sjDz9snv;
 Sat,  2 Dec 2023 19:20:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701541217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JCS+4CpN0taqsUahua2PMHvRfLWT5bZ84l5eyTkp0Hw=;
 b=FXx6Xtdc8GdzAarwjc/6AUcbVZ3dFOAfR+7T9DwRjSh0b0pdNG/SOLyMxgI9fERyyAxE+L
 n7qEesZdcyhOvNgtarfmb20hFTRlnl91vx7/PaT5zJb2tTeHzxuYNoynP9/JjCRQ/KqS53
 l0X8Cvw0vtiB3iSe+3nKim9pM/7JhtmfUhUHgjGoeyx7D7i5bZ1Y0v5P6EZg3XGkn65QLp
 MFmIB7QevMOSSv+r1fzhAqYDDQEvA/PwNm/S99PqmIVWnKELXv0Oq7ZW+bVYTm5l1nu+8u
 TLFLv1qvimu9EYKJO1R9FxtsSunEZ+m70neMx75Vh8djxKL+cztZD5MqT7P9sA==
Message-ID: <0150d0a2-75dc-41a3-93a9-e2c294b17e1f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701541216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JCS+4CpN0taqsUahua2PMHvRfLWT5bZ84l5eyTkp0Hw=;
 b=EnQGJN0+47N3/goxZctypJUhKnmvwsN5yp4zqM4xyXISTUIkhIYognIMB5JfDE0/AaIikr
 1VBG/+/tI8LqLZIYbvZNRtGO/POJ4AoYgsW6pwOWw+ktOebZuSJNao9NXd27rk3EOlS/BB
 qaMfR/gqezTgM9Cl2i0qH4QZOARIV+ltrVEtqUbUkSFT2KPazvLquhKn8zsw3tDNUoxLCu
 TMxNBZpckJBDc+yxsuRgErsO6JmD24SYQF3Ie5rl45ElS8G5U5dlooFy/a88bZlNN8WUch
 373EEGE9LwPUbuBG5XoM2IVqc8vkzN+w9Zk/uiGglmJskYaymZNEz0R2FRaB0g==
Date: Sat, 2 Dec 2023 19:20:13 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 5/5] sysreset: Support reset via Renesas RAA215300 PMIC
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20231115174025.12974-1-paul.barker.ct@bp.renesas.com>
 <20231115174025.12974-6-paul.barker.ct@bp.renesas.com>
 <6d47aaa8-543a-4420-973d-7a28941b475e@mailbox.org>
 <20231119205213.xyyuwvaluhmm2454@GBR-5CG2373LKG.adwin.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231119205213.xyyuwvaluhmm2454@GBR-5CG2373LKG.adwin.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: dbc470ef9f40b487c7d
X-MBO-RS-META: m133dhutrmr7o9e6kooyesm66kt9a979
X-Rspamd-Queue-Id: 4SjJBT5sjDz9snv
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

On 11/19/23 21:52, Paul Barker wrote:
> On Sun, Nov 19, 2023 at 09:17:40PM +0100, Marek Vasut wrote:
>> On 11/15/23 18:40, Paul Barker wrote:
>>> This patch allows us to reset the RZ/G2L board via the RAA215300 PMIC.
>>>
>>> Note that the RAA215300 documentation names the available reset types
>>> differently to u-boot:
>>>
>>>     - A "warm" reset via the RAA215300 PMIC will fully reset the SoC
>>>       (CPU & GPIOs), so this corresponds to SYSRESET_COLD.
>>>
>>>     - A "cold" reset via the RAA215300 PMIC will cycle all power supply
>>>       rails, so this corresponds to SYSRESET_POWER.
>>>
>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>> ---
>>>    board/renesas/rzg2l/rzg2l.c           |  8 ----
>>>    configs/renesas_rzg2l_smarc_defconfig |  2 +
>>>    drivers/power/pmic/raa215300.c        | 17 ++++++++
>>>    drivers/sysreset/Kconfig              |  6 +++
>>>    drivers/sysreset/Makefile             |  1 +
>>>    drivers/sysreset/sysreset_raa215300.c | 58 +++++++++++++++++++++++++++
>>>    6 files changed, 84 insertions(+), 8 deletions(-)
>>>    create mode 100644 drivers/sysreset/sysreset_raa215300.c
>>>
>>> diff --git a/board/renesas/rzg2l/rzg2l.c b/board/renesas/rzg2l/rzg2l.c
>>> index 73201a8c69e5..0f6d6e7f514f 100644
>>> --- a/board/renesas/rzg2l/rzg2l.c
>>> +++ b/board/renesas/rzg2l/rzg2l.c
>>> @@ -56,11 +56,3 @@ int board_init(void)
>>>    {
>>>    	return 0;
>>>    }
>>> -
>>> -void reset_cpu(void)
>>> -{
>>> -	/*
>>> -	 * TODO: Implement reset support once TrustedFirmware supports
>>> -	 * the appropriate call.
>>> -	 */
>>> -}
>>
>> Board change -- separate patch please.
> 
> Ok, this makes sense. I'll move this and the defconfig change into a
> separate patch.
> 
>>
>>> diff --git a/configs/renesas_rzg2l_smarc_defconfig b/configs/renesas_rzg2l_smarc_defconfig
>>> index b62eae4ee0a4..ba96e746df9e 100644
>>> --- a/configs/renesas_rzg2l_smarc_defconfig
>>> +++ b/configs/renesas_rzg2l_smarc_defconfig
>>> @@ -55,3 +55,5 @@ CONFIG_PMIC_RAA215300=y
>>>    CONFIG_DM_REGULATOR=y
>>>    CONFIG_DM_REGULATOR_FIXED=y
>>>    CONFIG_DM_REGULATOR_GPIO=y
>>> +CONFIG_SYSRESET=y
>>> +CONFIG_SYSRESET_RAA215300=y
>>> diff --git a/drivers/power/pmic/raa215300.c b/drivers/power/pmic/raa215300.c
>>> index 9c0b720994b2..7f68f95f25cf 100644
>>> --- a/drivers/power/pmic/raa215300.c
>>> +++ b/drivers/power/pmic/raa215300.c
>>> @@ -27,9 +27,26 @@ static const struct udevice_id raa215300_ids[] = {
>>>    	{ /* sentinel */ }
>>>    };
>>> +static int raa215300_bind(struct udevice *dev)
>>> +{
>>> +	struct driver *drv;
>>> +
>>> +	if (IS_ENABLED(CONFIG_SYSRESET_RAA215300)) {
>>> +		drv = lists_driver_lookup_name("raa215300_sysreset");
>>> +		if (!drv)
>>> +			return -ENOENT;
>>> +
>>> +		return device_bind(dev, drv, dev->name, NULL, dev_ofnode(dev),
>>> +				   NULL);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>
>> Driver change should be squashed in 4/5.
> 
> Moving this to the previous patch doesn't make sense to me - the
> sysreset driver needs to exist for this check to be meaningful.
> Conversely, adding the sysreset driver first then the pmic driver
> wouldn't make sense since the sysreset driver depends on the pmic
> driver. This seemed the neatest way to do things to me.

Can't you split this into 4 or so patches , add the bind() callbacks in 
first two, then the if (IS_ENABLED(...)) in next two ?

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5ECDE7B611
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 13:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8B5587540;
	Wed,  4 Oct 2023 15:38:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="AOQ04H6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62F008752B; Wed,  4 Oct 2023 15:38:33 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45B3186EE2
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 15:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4S0wkY3mngz9srB;
 Wed,  4 Oct 2023 15:38:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696426709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QcBYqL66UnzmSoGvvt8/UOmhLHPZTRogwIyT1f0nPOc=;
 b=AOQ04H6ZYmHcU+a0jOy63LCbpHtpQN5suXRbC8BQHndXNmJB6ECMpJ3qkabiCSPBuWB1wu
 ptE2eX52w105d9Qm8myoxNT18o0osMiuB+2/KdIcYy3YZ+9Bvy270FFBWWbik71KsB6Dmn
 EPoieZXqOUECf2qir8lViIbmfLioP0AYYP/xsuFgRA/7Fo1Pmbx0dqPfrYSDOGGOdTQl75
 NI9RUE8WrbhgpPCw46grdVzD/h4a6S1Y4CyYSfj6uv1/5ArgJNqGeODkyHWBajJzS/PdM/
 ObvZ8/D+t9/GecblMXB9fMqTCziB27rs6x8euox8K+dxzvTVf+hO9I2V6Cooow==
Message-ID: <c11b31f9-44c9-4b72-a9d4-c2d77eb3e9e2@mailbox.org>
Date: Wed, 4 Oct 2023 15:38:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 09/16] pinctrl: renesas: Add RZ/G2L PFC driver
Content-Language: en-US
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-10-paul.barker.ct@bp.renesas.com>
 <b0df977c-75ef-1579-506e-42e48ef2a06b@mailbox.org>
 <8d2eb729-977f-9fd8-669c-25520218880d@bp.renesas.com>
 <ebcddc10-e450-45e0-8f93-585ff440da4a@mailbox.org>
 <OS0PR01MB59226E628EF9E3D0159AB0BB86CBA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <OS0PR01MB59226E628EF9E3D0159AB0BB86CBA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 56256a8a512c327c12a
X-MBO-RS-META: ecwjkfqrdn8crkxiq3hm9417na6pm73w
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

On 10/4/23 14:56, Biju Das wrote:

[...]

>>>>> +		return -EINVAL;
>>>>> +	}
>>>>> +
>>>>> +	uc_priv->gpio_count = args.args[2];
>>>>> +	return rzg2l_pfc_enable(dev);
>>>>> +}
>>>>> +
>>>>> +U_BOOT_DRIVER(rzg2l_pfc_gpio) = {
>>>>> +	.name		= "rzg2l-pfc-gpio",
>>>>> +	.id		= UCLASS_GPIO,
>>>>> +	.ops		= &rzg2l_gpio_ops,
>>>>> +	.probe		= rzg2l_gpio_probe,
>>>>> +};
>>>>
>>>> Can you please split the GPIO and PFC drivers into separate files ?
>>>
>>> I assume you mean gpio and pinctrl here - the PFC handles both. I can
>>> move the gpio driver out to drivers/gpio.
>>
>> Thanks. R-Car already does it that way.
> 
> RCar has separate GPIO block and Pin control block
> So we have separate drivers.
> 
> On RZ/G2L we have only pinctrl block, ie, the reason it is
> integrated driver in linux.
> 
> If you make separate driver, how do you plan to share resources in u-boot. For eg: register/clock/reset??

Clock and reset are easy, just grab them twice, once in each driver.

Registers, well ... have a look at gen3_cpg_bind() in 
drivers/clk/renesas/clk-rcar-gen3.c . Specifically, see 
device_bind_with_driver_data() and how one common "superdriver" can get 
bound to an IP, and then instantiate and bind two "subdrivers" which 
each obtain resources claimed by the "superdriver" via (in this case) 
the 'info' parameter. That should work, right ?

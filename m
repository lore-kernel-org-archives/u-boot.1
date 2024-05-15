Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60669C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 06:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D647288199;
	Wed, 15 May 2024 08:28:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hhbO7QGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85944881B8; Wed, 15 May 2024 08:28:32 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CCC58817B
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 08:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=71b8=MS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1715754488;
 bh=RP2+QD794QJKAUd3/REfakEaUErqqAxUzIzbVw0kn4I=;
 b=hhbO7QGEMWZroR/L+yAHf9G3IhXbBIIIuVtFGPTr6uCxNpn93OX+ULC25VHM+3XVQyFHaiBx/
 jiNaiA4tZNdNnEqufnwmNCa9l1HctPJvGxtXLdsulRst+YeVSgdi5YfhwyRMjAA+0t9Dqt/YpHU
 75aHhfJT2QTV+ceDYXvkr8HfrdeIVStH2rewPKuINGJaTlPEfMcyUzVVHwCpTK0CLYU4CLTpkQ2
 ra0WAT83Fv1xTB5IJhuGYwIYZwKObWENGcY1pLHp0hIiUHhXlrCfCsL2EFWh9npcvlQbtSGxSP1
 2iDVacMozH6OIwQPEHpVdckq3c/gG3pjEsMTLeP99org==
Message-ID: <7170d875-5b38-4d7c-855c-f835c5a88add@kwiboo.se>
Date: Wed, 15 May 2024 08:28:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] syscon: Probe device first in syscon_get_regmap
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, paulburton@kernel.org,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de
References: <20240513-boston-v1-0-fac96938417e@flygoat.com>
 <20240513-boston-v1-9-fac96938417e@flygoat.com>
 <6bbce6d6-35a2-49f6-b9a1-36dbebfdb9e3@kwiboo.se>
 <c2881dc8-153b-4233-b123-a89cd596c4ec@app.fastmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <c2881dc8-153b-4233-b123-a89cd596c4ec@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 664455f596add9bdabf21e72
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

Hi Jiaxun,

On 2024-05-15 02:12, Jiaxun Yang wrote:
> 
> 
> 在2024年5月14日五月 下午3:50，Jonas Karlman写道：
>> Hi Jiaxun,
> [...]
>>> +		return ERR_PTR(ret);
>>
>> Please explain in more details what the issue this is trying to solve.
>>
>> Typically syscon_get_regmap() is called on a udevice returned from a
>> uclass_get_device call, and that should trigger a probe for the device
>> and its parents.
>>
>> Adding device_probe() here possible just hides an issue that exists
>> somewhere else. In what instance are you ending up with a call to
>> this function with a udevice that has not been probed?
> 
> Hi Jonas,
> 
> Thanks for the reply, my problem is in [PATCH 10/13] I'm using dev->parent
> directly to get parent device and then use that pointer to access
> syscon_get_regmap.

Looking at the driver model lifecycle docs and the clk_boston driver I
would suggest you to change from using the of_to_plat() ops and do same
in probe() ops instead.

That way your parent udevice will have been probed and you do not need
to manually probe it at of_to_plat() stage.

https://docs.u-boot.org/en/latest/develop/driver-model/design.html#driver-lifecycle

"""
If your device relies on its parent setting up a suitable address space,
so that dev_read_addr() works correctly, then make sure that the parent
device has its setup code in of_to_plat(). If it has it in the probe
method, then you cannot call dev_read_addr() from the child device's
of_to_plat() method. Move it to probe() instead.
"""

Moving your syscon_get_regmap() call from of_to_plat() to probe() should
make this syscon patch unnecessary.

Regards,
Jonas

> 
> There is no chance to invoke uclass_get_device_* as what we need is just
> the parent device.
> 
> I can think of two solution without touching syscon code here.
> 
> First would be performing uclass_get_device_by_ofnode against parent's
> ofnode, which seems a little bit overkilling.
> 
> Second would be trigger probing in dev_get_parent.
> 
> Thanks
> - Jiaxun
> 
>>
>> Also, please add a new test to test/dm/regmap.c if this solves a real
>> issue.
>>
>> Regards,
>> Jonas
>>
>>>  	priv = dev_get_uclass_priv(dev);
>>>  	return priv->regmap;
>>>  }
>>>
> 


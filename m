Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48D5C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:19:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 571F884BB8;
	Thu,  9 Jul 2026 15:19:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="qAAqGgIF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E820C84BBF; Thu,  9 Jul 2026 15:19:28 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C5BD84BA0
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 15:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4682=FE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: References: Cc:
 To: From: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1783603165;
 bh=xzv+Xd7YOoiJD6XfZs9T0Abh6d0000TRerIOSg+atQo=;
 b=qAAqGgIFUKbGdHSZbsb74C2FIjcC42cgsR4VBvLplqU2mDf9apcOejrtXfdWxr/MGVm7yTxHe
 uGHeJiS5UzCby7ZS/j20tVdzq3biWjNPyA58N6+UGw/YtOlD7ZpXFNSAH+62BBGvjW2tKtCOna0
 oof6z63Kc2fKcH8P1k4ghZrVq7Nfr3iX9rsSY+tlBrfLELAMh7RpOoS0+ZjWIJ9edp/U351CA6p
 VkpgNozxyhTxc4GoEizIc8RvkkIroxtzCT96ppAjWcAAClO4eUWd+sBU8Td+QOh5RZQZ9snvRWN
 w6z1DduldYz/WNrNf+PP9pEAqQzt3s0cWve6cQLrb8wQ==
X-Forward-Email-ID: 6a4f9fd9165b5075f21e0486
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <4fac9571-d543-4fc5-bf4a-38f096bfda48@kwiboo.se>
Date: Thu, 9 Jul 2026 15:19:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] Kconfig: i2c: Depend on correct xPL symbol
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>
Cc: Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-9-jonas@kwiboo.se>
 <20260709015247.GR749385@bill-the-cat>
 <f544cab6-1db6-481b-8f91-06cc2fb6829b@kwiboo.se>
Content-Language: en-US
In-Reply-To: <f544cab6-1db6-481b-8f91-06cc2fb6829b@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi again,

On 7/9/2026 9:12 AM, Jonas Karlman wrote:
> Hi Tom,
> 
> On 7/9/2026 3:52 AM, Tom Rini wrote:
>> On Wed, Jul 08, 2026 at 10:05:34PM +0000, Jonas Karlman wrote:
>>
>>> Change to depend on the xPL symbol instead of the SUPPORT_xPL symbol to
>>> only make the xPL_SYS_I2C_LEGACY symbols available when xPL is enabled.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>  drivers/i2c/Kconfig | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
>>> index ab5af17858c8..125dc84819e6 100644
>>> --- a/drivers/i2c/Kconfig
>>> +++ b/drivers/i2c/Kconfig
>>> @@ -78,14 +78,14 @@ config SYS_I2C_LEGACY
>>>  
>>>  config SPL_SYS_I2C_LEGACY
>>>  	bool "Enable legacy I2C subsystem and drivers in SPL"
>>> -	depends on SUPPORT_SPL && !SPL_DM_I2C
>>> +	depends on SPL && !SPL_DM_I2C
>>>  	help
>>>  	  Enable the legacy I2C subsystem and drivers in SPL.  This is useful
>>>  	  in some size constrained situations.
>>>  
>>>  config TPL_SYS_I2C_LEGACY
>>>  	bool "Enable legacy I2C subsystem and drivers in TPL"
>>> -	depends on SUPPORT_TPL && !SPL_DM_I2C
>>> +	depends on TPL && !TPL_DM_I2C
>>>  	help
>>>  	  Enable the legacy I2C subsystem and drivers in TPL.  This is useful
>>>  	  in some size constrained situations.
>>
>> Building on the last email, I think these might need to be
>> [ST]PL_FRAMEWORK not [ST]PL.
>>
> 
> I have mostly tested this series with additional changes that alias
> putc()/puts() to printch()/printascii() in xPL builds when
> common/console.o is unavailable and DEBUG_UART=y, patches that will
> be sent as a separate series.
> 
> It is possible such change may have hidden some latent issues, now
> trying to push a branch that contains changes that ends at the patches
> included in this series, but due to timeouts it was not possible prior
> to sending this reply.

The CI pipeline [1] has now passed successfully for branch ci-kconfig [2].

[1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/pipelines/30642
[2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/ci-kconfig

Regards,
Jonas

> 
> This patch can also be dropped if it causes any issues, I only added it
> after a search for SUPPORT_xPL and noticed that these depends seem to be
> incorrect. SUPPORT_xPL is used to tell if xPL can be enabled or not,
> not if xPL is enabled/disabled.
> 
> Regards,
> Jonas


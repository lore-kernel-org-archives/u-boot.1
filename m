Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA64E67816
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 23:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0EC388FFC;
	Sun,  3 Nov 2024 00:22:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="LX5Rk6Vm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56100885B3; Sun,  3 Nov 2024 00:22:11 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1891B88C86
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 00:22:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4e10=R6=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1730589721;
 bh=0nisEL+aH/XXFj669i/rIrESZi357cuTcXHvPUX/yLg=;
 b=LX5Rk6Vm4IXaNuiOtyGGNak7k0eLbF3njku4ssYYpxdErXLrRhR3NGLeTwJVsi0EOPH79VgSO
 1aSjHwH3Q/acNPeB2FQ0mLFq5M0IeFFpYgpa1vRA9CWHiLLL6+9UjlaRZ9Y4iqZJZvaZnsWct3N
 qIBrH2+4Kamhj5BFcbbi9oHXUdbZY7cyAYC4+pPQ3K4FBHjwT2+e37yO50ecF45aC/njKfIIPs5
 y8C2sO/aXJ7Tju5iZbeE5LL+gBFNx0boqLAxxEZdB9YNmo32Z9d4CwbtVDWLmlBRbGTAe5qwfG0
 MBJo1OYNKLXrx5SJF9womtB1rvzlwK/nmRUmq2DVLUuw==
Message-ID: <790533ea-92c5-4793-ab32-08b07f40b9d5@kwiboo.se>
Date: Sun, 3 Nov 2024 00:21:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] usb: tcpm: fusb302: add support for set_vbus()
 callback.
To: bigunclemax@gmail.com, Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Wang Jie <dave.wang@rock-chips.com>, u-boot@lists.denx.de
References: <20241101103501.21432-1-bigunclemax@gmail.com>
 <20241101103501.21432-3-bigunclemax@gmail.com>
 <mlcweqrj56o53wluowoz7n6fdn4xofx5gtmh6d2ufkpqq7xq34@7qfgnsw6j4ev>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <mlcweqrj56o53wluowoz7n6fdn4xofx5gtmh6d2ufkpqq7xq34@7qfgnsw6j4ev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 6726b416922720f2eae928e1
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

Hi Maksim,

On 2024-11-01 19:17, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Nov 01, 2024 at 01:34:51PM +0300, bigunclemax@gmail.com wrote:
>> From: Maksim Kiselev <bigunclemax@gmail.com>
>>
>> Add support for VBUS supply regulator.
>>
>> When our type-c port acts as a host(SRC), this regulator
>> used for control VBUS supply.
>>
>> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
>> ---
>>  drivers/usb/tcpm/fusb302.c | 44 +++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 43 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/tcpm/fusb302.c b/drivers/usb/tcpm/fusb302.c
>> index ee283782792..2a258d6429b 100644
>> --- a/drivers/usb/tcpm/fusb302.c
>> +++ b/drivers/usb/tcpm/fusb302.c
>> @@ -10,6 +10,7 @@
>>  #include <asm/gpio.h>
>>  #include <linux/delay.h>
>>  #include <linux/err.h>
>> +#include <power/regulator.h>
>>  #include <dm/device_compat.h>
>>  #include <usb/tcpm.h>
>>  #include "fusb302_reg.h"
>> @@ -50,10 +51,13 @@ struct fusb302_chip {
>>  
>>  	/* port status */
>>  	bool vconn_on;
>> +	bool vbus_on;
>>  	bool vbus_present;
>>  	enum typec_cc_polarity cc_polarity;
>>  	enum typec_cc_status cc1;
>>  	enum typec_cc_status cc2;
>> +
>> +	struct udevice *vbus;
>>  };
>>  
>>  static int fusb302_i2c_write(struct udevice *dev, u8 address, u8 data)
>> @@ -506,7 +510,28 @@ done:
>>  
>>  static int fusb302_set_vbus(struct udevice *dev, bool on, bool charge)
>>  {
>> -	return 0;
>> +	struct fusb302_chip *chip = dev_get_priv(dev);
>> +	int ret = 0;
>> +
>> +	if (chip->vbus_on == on) {
>> +		dev_dbg(dev, "vbus is already %s\n", on ? "On" : "Off");
>> +	} else {
>> +		if (CONFIG_IS_ENABLED(DM_REGULATOR) && chip->vbus) {
> 
> should be enough to check for chip->vbus, since the regulator
> device should be NULL when DM_REGULATOR is disabled. If due to
> some bug its not NULL regulator_set_enable would fail gracefully
> with -ENOSYS, so that somebody can debug the problem.
> 
>> +			if (on)
>> +				ret = regulator_set_enable(chip->vbus, true);
>> +			else
>> +				ret = regulator_set_enable(chip->vbus, false);
> 
> regulator_set_enable(chip->vbus, on);

Please use something like following:

  ret = regulator_set_enable_if_allowed(chip->vbus, on);
  if (ret && ret != -ENOSYS)

Should be safe when DM_REGULATOR disabled or when chip->vbus is NULL,
also work when regulator is always-on or already enabled.

> 
>> +			if (ret < 0) {
>> +				dev_dbg(dev, "cannot %s vbus regulator, ret=%d\n",
>> +					on ? "enable" : "disable", ret);
> 
> dev_err()?
> 
>> +				return ret;
>> +			}
>> +		}
>> +		chip->vbus_on = on;

vbus_on could probably be dropped, fixed and gpio regulators is
currently already reference counted. Or is the set_vbus ops not called
evenly and current state needs to be known?

>> +		dev_dbg(dev, "vbus := %s\n", on ? "On" : "Off");
>> +	}
>> +
>> +	return ret;
> 
> I suggest converting this to
> 
> int ret;
> 
> if (chip->vbus_on == on) {
>     dev_dbg(...);
>     return 0;
> }
> 
> ... remaining code without extra indent ...
> 
> Otherwise LGTM.
> 
> -- Sebastian
> 
> 
>>  }
>>  
>>  static int fusb302_pd_tx_flush(struct udevice *dev)
>> @@ -1293,6 +1318,22 @@ static int fusb302_get_connector_node(struct udevice *dev, ofnode *connector_nod
>>  	return 0;
>>  }
>>  
>> +static int fusb302_probe(struct udevice *dev)
>> +{
>> +	struct fusb302_chip *chip = dev_get_priv(dev);
>> +	int ret;
>> +
>> +	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
>> +		ret = device_get_supply_regulator(dev, "vbus-supply", &chip->vbus);
>> +		if (ret && ret != -ENOENT) {

You could probably just drop the DM_REGULATOR wrap and use:

  if (ret && ret != -ENOSYS && ret != -ENOENT) {

Regards,
Jonas

>> +			dev_err(dev, "Failed to get vbus-supply regulator\n");
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static struct dm_tcpm_ops fusb302_ops = {
>>  	.get_connector_node = fusb302_get_connector_node,
>>  	.init = fusb302_init,
>> @@ -1320,4 +1361,5 @@ U_BOOT_DRIVER(fusb302) = {
>>  	.of_match = fusb302_ids,
>>  	.ops = &fusb302_ops,
>>  	.priv_auto = sizeof(struct fusb302_chip),
>> +	.probe = fusb302_probe,
>>  };
>> -- 
>> 2.45.2
>>


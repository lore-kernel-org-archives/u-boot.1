Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC283C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 14:42:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49D85845A3;
	Thu,  7 Aug 2025 16:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D164C84514; Thu,  7 Aug 2025 16:12:59 +0200 (CEST)
Received: from mail.prodrive-technologies.com (mail.prodrive-technologies.com
 [212.61.153.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 028F183C62
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 16:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=prodrive-technologies.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=paul.geurts@prodrive-technologies.com
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Aug 2025
 16:11:14 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP01.bk.prodrive.nl (10.1.0.22) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Thu, 7 Aug 2025 16:11:14 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.96)
 (envelope-from <paul.geurts@prodrive-technologies.com>)
 id 1uk1Ks-001JqM-1C; Thu, 07 Aug 2025 16:11:14 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <primoz.fiser@norik.com>
CC: <jh80.chung@samsung.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
Subject: Re: [PATCH] power: pmic: pca9450: Add support for system reset
Date: Thu, 7 Aug 2025 16:11:12 +0200
Message-ID: <20250807141112.310426-1-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <81e88a5b-a033-4ee0-a895-35465955edce@norik.com>
References: <81e88a5b-a033-4ee0-a895-35465955edce@norik.com>
MIME-Version: 1.0
Reviewed-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 07 Aug 2025 16:42:48 +0200
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

Hi Primoz,

Primoz Fiser wrote:
>Hi Paul,
>
>On 4. 08. 25 19:30, Paul Geurts wrote:
>>> The family of PCA9450 PMICs have the ability to perform system resets.
>>> Restarting via PMIC is preferred method of restarting the system as all
>>> the peripherals are brought to a know state after a power-cycle. The
>>> PCA9450 features a cold restart procedure which is initiated by an I2C
>>> command 0x14 to the SW_RST register.
>>>
>>> Support in Linux for restarting via PCA9450 PMIC has been added by
>>> Linux commit 6157e62b07d9 ("regulator: pca9450: Add restart handler").
>>>
>>> Now add support for it also in the U-Boot via sysreset framework.
>>>
>>> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
>>> ---
>>>  drivers/power/pmic/pca9450.c | 42 ++++++++++++++++++++++++++++++++++++
>>>  include/power/pca9450.h      |  2 ++
>>>  2 files changed, 44 insertions(+)
>>>
>>> diff --git a/drivers/power/pmic/pca9450.c b/drivers/power/pmic/pca9450.c
>>> index 9d875f8bdbe8..abc39d0a1946 100644
>>> --- a/drivers/power/pmic/pca9450.c
>>> +++ b/drivers/power/pmic/pca9450.c
>>> @@ -7,15 +7,18 @@
>>>  #include <errno.h>
>>>  #include <dm.h>
>>>  #include <dm/device_compat.h>
>>> +#include <dm/lists.h>
>>>  #include <i2c.h>
>>>  #include <linux/err.h>
>>>  #include <log.h>
>>>  #include <asm/global_data.h>
>>>  #include <asm-generic/gpio.h>
>>> +#include <linux/delay.h>
>>>  #include <linux/printk.h>
>>>  #include <power/pmic.h>
>>>  #include <power/regulator.h>
>>>  #include <power/pca9450.h>
>>> +#include <sysreset.h>
>>>  
>>>  DECLARE_GLOBAL_DATA_PTR;
>>>  
>>> @@ -101,6 +104,14 @@ static int pca9450_probe(struct udevice *dev)
>>>  		}
>>>  	}
>>>  
>>> +	if (CONFIG_IS_ENABLED(SYSRESET)) {
>>> +		ret = device_bind_driver_to_node(dev, "pca9450_sysreset",
>>> +						 "pca9450_sysreset",
>>> +						 dev_ofnode(dev), NULL);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>>  	if (ofnode_read_bool(dev_ofnode(dev), "nxp,wdog_b-warm-reset"))
>>>  		reset_ctrl = PCA9450_PMIC_RESET_WDOG_B_CFG_WARM;
>>>  	else
>>> @@ -134,3 +145,34 @@ U_BOOT_DRIVER(pmic_pca9450) = {
>>>  	.ops = &pca9450_ops,
>>>  	.priv_auto = sizeof(struct pca9450_priv),
>>>  };
>>> +
>>> +#ifdef CONFIG_SYSRESET
>>> +static int pca9450_sysreset_request(struct udevice *dev, enum sysreset_t type)
>>> +{
>>> +	u8 cmd = PCA9450_SW_RST_COLD_RST;
>>> +
>>> +	if (type != SYSRESET_COLD)
>> 
>> The PCA9450 calls it "cold reset", but it is technically SYSRESET_POWER.
>> There is no option for it in the sysreset do_reset, but maybe there should be.
>
>Yeah, the default is SYSRESET_COLD.
>
>Additionally, there is only support for warm rst type (SYSRESET_WARM) in
>do_reset for now.
>
>I decided not to implement it to keep it as simple as possible and in
>sync with your Linux support.

Understandable. I think it's fine like this too.

>
>> 
>>> +		return -EPROTONOSUPPORT;
>>> +
>>> +	if (pmic_write(dev->parent, PCA9450_SW_RST, &cmd, 1)) {
>>> +		dev_err(dev, "reset command failed\n");
>>> +	} else {
>>> +		/* tRESTART is 250ms, delay 300ms just to be sure */
>>> +		mdelay(300);
>>> +		/* Should not get here, warn if we do */
>>> +		dev_warn(dev, "didn't respond to reset command\n");
>>> +	}
>>> +
>>> +	return -EINPROGRESS;
>>> +}
>>> +
>>> +static struct sysreset_ops pca9450_sysreset_ops = {
>>> +	.request	= pca9450_sysreset_request,
>> 
>> When using the PCA9450 to perform a cold reset, the CPU boot status shall
>> _always_ be POR, as that is what the CPU detects. This means the boot status
>> should also come from the PCA9450 when enabling CONFIG_SYSRESET option.
>> 
>> I think implementing pca9450_sysreset_ops.get_status() to read the
>> PWRON_STAT register should do the trick, but I am not that familiar with the
>> sysreset in U-Boot.
>
>You read my mind :)
>
>I have support for get_status() already prepared but I am waiting for
>this patch to get applied first.

I you get this patch applied, you will effectively break the boot status,
which would be regression in U-Boot. If you have the commit ready, I think
it should be a patch series.

>
>Your Reviewed-by tag would help here if possible?

Yeah will do.

>
>> 
>>> +};
>>> +
>>> +U_BOOT_DRIVER(pca9450_sysreset) = {
>>> +	.name		= "pca9450_sysreset",
>>> +	.id		= UCLASS_SYSRESET,
>>> +	.ops		= &pca9450_sysreset_ops,
>>> +};
>>> +#endif /* CONFIG_SYSRESET */
>>> diff --git a/include/power/pca9450.h b/include/power/pca9450.h
>>> index e5ab09fb8c83..9119ef793b1f 100644
>>> --- a/include/power/pca9450.h
>>> +++ b/include/power/pca9450.h
>>> @@ -75,4 +75,6 @@ enum {
>>>  #define PCA9450_PMIC_RESET_WDOG_B_CFG_WARM		0x40
>>>  #define PCA9450_PMIC_RESET_WDOG_B_CFG_COLD_LDO12	0x80
>>>  
>>> +#define PCA9450_SW_RST_COLD_RST		0x14
>>> +
>>>  #endif
>>>
>> 
>> Thanks for porting it to U-Boot :-)
>
>You're welcome.
>
>Thanks for adding support in Linux.
>
>BR,
>Primoz
>
>> 
>> br,
>> Paul
>
>-- 
>Primoz Fiser
>phone: +386-41-390-545
>email: primoz.fiser@norik.com
>--
>Norik systems d.o.o.
>Your embedded software partner
>Slovenia, EU
>phone: +386-41-540-545
>email: info@norik.com
>

br,
Paul


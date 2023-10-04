Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B35CE7B604
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 12:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4F2787445;
	Wed,  4 Oct 2023 14:26:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BuE8DNBt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F82F874AD; Wed,  4 Oct 2023 14:26:54 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF3A986EBC
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 14:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4S0v7t6tg6z9sqT;
 Wed,  4 Oct 2023 14:26:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696422410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SPXT3R4kn1erU8+RbnYCeeu3KRNmGvptR7M6D6m/Ahg=;
 b=BuE8DNBt+XA2RiKjvtSmCwrWzobXpPA+AuimpTBHPwK8D7Wur0em9TxvzbOEwsyb11zXH1
 WyA4kmDd+zCz0SF7iTdDYPDHKmgbcAeHl5MNkALgHKnleuJqw0VXh79oSTpNQMojfD4yb0
 os/JRV4IyqJWB+A7lMBYL6EM1iLV7ma5KyMY4HYrcSNW25arIB6NSkGwHv2ug838DRDLQ7
 kNBbN0IWswVY8R6CE+o93za+pmg2lAYvAbLJLy8kTw8672KOIYAqrXoTgbPjt/8X5uKcQ+
 srauJAw0hlht1sZ04IpzfRSBnNRTfr9JhnfVsPJ+q7WLWOkq8hcbqWE0Myxy2Q==
Message-ID: <8cd7a684-3e5e-4bd4-bab4-796502935d83@mailbox.org>
Date: Wed, 4 Oct 2023 14:26:49 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 10/16] serial: sh: Add RZ/G2L SCIF support
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-11-paul.barker.ct@bp.renesas.com>
 <94bd4c16-67c4-828d-7eb2-fe6a68df4800@mailbox.org>
 <68462bfa-c11a-8e21-7fc5-21bb9af9ccd9@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <68462bfa-c11a-8e21-7fc5-21bb9af9ccd9@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e4078b39b76dbb808d2
X-MBO-RS-META: 7uub5czx7sju8icdcth6ifm7tawqtp5x
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

On 10/4/23 10:48, Paul Barker wrote:
> On 03/10/2023 14:23, Marek Vasut wrote:
>> On 9/20/23 14:42, Paul Barker wrote:
>>> Extend the existing driver to support the SCIF serial ports on the
>>> Renesas RZ/G2L (R9A07G044) SoC. This also requires us to ensure that the
>>> relevant reset signal is de-asserted before we try to talk to the SCIF
>>> module.
>>>
>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>>> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> ---
>>>    arch/arm/mach-rmobile/Kconfig |  1 +
>>>    drivers/serial/serial_sh.c    | 32 ++++++++++++++++++++++++++++++--
>>>    drivers/serial/serial_sh.h    | 19 ++++++++++++++++++-
>>>    3 files changed, 49 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kconfig
>>> index 973e84fcf7ba..0ab22356aee5 100644
>>> --- a/arch/arm/mach-rmobile/Kconfig
>>> +++ b/arch/arm/mach-rmobile/Kconfig
>>> @@ -77,6 +77,7 @@ config RZG2L
>>>    	imply RENESAS_SDHI
>>>    	imply CLK_RZG2L
>>>    	imply PINCTRL_RZG2L
>>> +	imply SCIF_CONSOLE
>>>    	help
>>>    	  Enable support for the Renesas RZ/G2L family of SoCs, including the
>>>    	  the RZ/G2L itself (based on the R9A07G044 SoC).
>>> diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
>>> index 5e543dbf3d58..a2e9a57137a6 100644
>>> --- a/drivers/serial/serial_sh.c
>>> +++ b/drivers/serial/serial_sh.c
>>> @@ -17,6 +17,8 @@
>>>    #include <linux/compiler.h>
>>>    #include <dm/platform_data/serial_sh.h>
>>>    #include <linux/delay.h>
>>> +#include <dm/device_compat.h>
>>> +#include <reset.h>
>>>    #include "serial_sh.h"
>>>    
>>>    DECLARE_GLOBAL_DATA_PTR;
>>> @@ -79,8 +81,16 @@ sh_serial_setbrg_generic(struct uart_port *port, int clk, int baudrate)
>>>    
>>>    static void handle_error(struct uart_port *port)
>>>    {
>>> -	sci_in(port, SCxSR);
>>> -	sci_out(port, SCxSR, SCxSR_ERROR_CLEAR(port));
>>> +	/* The RZ/G2L datasheet says that error conditions are cleared by
>>> +	 * resetting the error bits in the FSR register to zero.
>>
>> Can you be more specific here ?
>>
>> It doesn't seem Linux sh-sci.c driver does anything special for G2L, so
>> is this special case really needed ?
> 
> On page 1268 of the datasheet (R01UH0914EJ0130 Rev.1.30):
> 
> "DR is cleared to 0 when DR = 1 is read and then 0 is written to the DR
> flag."
> 
> On page 1270:
> 
> "[Clearing condition]
> ● When 0 is written to ER after it has been read as 1"
> 
> So zeros must be written to clear these errors, not ones.
> 
> We have an open task to investigate the issue in the Linux driver and
> fix it.

Is the G2L UART broken in Linux ?
Does it misbehave in U-Boot ?

>>> +	 */
>>> +	if (IS_ENABLED(CONFIG_RZG2L)) {
>>> +		unsigned short status = sci_in(port, SCxSR);
>>> +		sci_out(port, SCxSR, status & ~SCIF_ERRORS);
>>> +	} else {
>>> +		sci_in(port, SCxSR);
>>> +		sci_out(port, SCxSR, SCxSR_ERROR_CLEAR(port));
>>> +	}
>>>    	sci_in(port, SCLSR);
>>>    	sci_out(port, SCLSR, 0x00);
>>>    }
>>> @@ -193,6 +203,23 @@ static int sh_serial_probe(struct udevice *dev)
>>>    	priv->type	= plat->type;
>>>    	priv->clk_mode	= plat->clk_mode;
>>>    
>>> +	if (IS_ENABLED(CONFIG_RZG2L)) {
>>> +		struct reset_ctl rst;
>>> +		int ret;
>>> +
>>> +		ret = reset_get_by_index(dev, 0, &rst);
>>> +		if (ret < 0) {
>>> +			dev_err(dev, "failed to get reset line\n");
>>> +			return ret;
>>> +		}
>>> +
>>> +		ret = reset_deassert(&rst);
>>> +		if (ret < 0) {
>>> +			dev_err(dev, "failed to de-assert reset line\n");
>>> +			return ret;
>>> +		}
>>> +	}
>>
>> devm_reset_control_get_optional() or something should do here too , right ?
>>
>> Note that R-Car does have SCIF reset too, so this can be generic code.
> 
> For R-Car systems the current behaviour is working and well tested, we
> concluded that we shouldn't change it so this reset de-assert was made
> RZ/G2L specific.

I can test on R-Car just fine, no worries.

SH R2Dplus is even tested in CI nightly.

> For RZ/G2L, de-asserting the reset is not optional.

Let's avoid special-cases like that.

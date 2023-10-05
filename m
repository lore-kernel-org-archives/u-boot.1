Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC55E92728
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 19:12:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9794B8611C;
	Thu,  5 Oct 2023 21:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Rj6Re8co";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 195B586BAA; Thu,  5 Oct 2023 21:11:58 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A31FC85095
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 21:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4S1h4n6C86z9sQT;
 Thu,  5 Oct 2023 21:11:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696533113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=24Lrxz4FKxIFNbmrxx4UjDSKoAM4k9DnFp90kJjxa3I=;
 b=Rj6Re8coIS6JlkKkQaX8TYBqxisX9uoeDulfyu8HQ0CuM1RKF7wLvhB39vn5jyxPMhGMvj
 FDraZM5s2ArUXGe6GvYhPDuG+lJ4QGcMdB+QQFMUDN6GFQFihKWyaZapkhoDlAPPN7HWw3
 hQyNcSVRZ+9eHYrvmeLh4mSz1G9qjvRXLDTotD5X2qOIHqiWf4I1o5rQ1HmzXlzkbIdK1I
 xwoz9Sh770Ol/UI/Zd6J2XFdE54Y6F7pUNOFy//dF4Kssk+pgH8BwOE92ND+AjebATFLaL
 N4s6G+doTtdN6zOnHawvh1ylPktT0lTswEXi6MdZNFCIcW+j56D+XM5sR3Z9+g==
Message-ID: <73888be3-cf25-47c7-81fb-c94398507acf@mailbox.org>
Date: Thu, 5 Oct 2023 21:11:51 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 11/16] mmc: renesas-sdhi: Initialize module on RZ/G2L
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-12-paul.barker.ct@bp.renesas.com>
 <2effddcd-af1c-966b-9548-54be82536e06@mailbox.org>
 <a2c354a5-f778-a4b1-b0e6-9550c55388e9@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <a2c354a5-f778-a4b1-b0e6-9550c55388e9@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9d835014a20ddd4550b
X-MBO-RS-META: qirpcef53gtcej46nzmjcfy4wgp6bhu6
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

On 10/5/23 18:35, Paul Barker wrote:
> On 03/10/2023 14:25, Marek Vasut wrote:
>> On 9/20/23 14:42, Paul Barker wrote:
>>> On the Renesas RZ/G2L SoC family, we must ensure that the required clock
>>> signals are enabled and the reset signal is de-asserted before we try to
>>> communicate with the SDHI module.
>>>
>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>>> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> ---
>>>    drivers/mmc/renesas-sdhi.c | 61 ++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 61 insertions(+)
>>>
>>> diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
>>> index 8e716f74491f..170c5dcc2ebe 100644
>>> --- a/drivers/mmc/renesas-sdhi.c
>>> +++ b/drivers/mmc/renesas-sdhi.c
>>> @@ -20,6 +20,7 @@
>>>    #include <linux/io.h>
>>>    #include <linux/sizes.h>
>>>    #include <power/regulator.h>
>>> +#include <reset.h>
>>>    #include <asm/unaligned.h>
>>>    #include "tmio-common.h"
>>>    
>>> @@ -964,6 +965,8 @@ static int renesas_sdhi_probe(struct udevice *dev)
>>>    	u32 quirks = dev_get_driver_data(dev);
>>>    	struct fdt_resource reg_res;
>>>    	DECLARE_GLOBAL_DATA_PTR;
>>> +	struct clk imclk2, aclk;
>>> +	struct reset_ctl rst;
>>>    	int ret;
>>>    
>>>    	priv->clk_get_rate = renesas_sdhi_clk_get_rate;
>>> @@ -1012,6 +1015,49 @@ static int renesas_sdhi_probe(struct udevice *dev)
>>>    		goto err_clkh;
>>>    	}
>>>    
>>> +	if (IS_ENABLED(CONFIG_RZG2L)) {
>>> +		/*
>>> +		 * On members of the RZ/G2L SoC family, we need to enable
>>> +		 * additional chip detect and bus clocks, then release the SDHI
>>> +		 * module from reset.
>>> +		 */
>>
>> This could use a separate function, and then, use bulk clock API via
>> clk_get_bulk() and co .
> 
> There are 4 clocks defined in the dtb: "core", "clkh", "cd", "aclk".
> 
> During probe, we want to enable "core", "cd" (aka "imclk2" in the
> datasheet) and "aclk" but not "clkh". The driver enables "clkh" later as
> needed for high speed modes. So I don't think we want to bulk enable
> everything here.

Aha, OK

> By "separate function", are you suggesting an entire separate probe
> function for RZ/G2L SDHI? Or just moving what's inside the
> if(IS_ENABLED(CONFIG_RZG2L)) into a new function which we can call from
> renesas_sdhi_probe()?

The later, to avoid this huge ifdef within the probe

if (IS_ENABLED(CONFIG_RZG2L))
    rzg2l_do_whatever_extra_stuff_is_needed();

Thanks !

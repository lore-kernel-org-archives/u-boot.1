Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C39FC021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 08:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A228480FE2;
	Thu, 27 Feb 2025 09:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dXfZ8EeT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CEFB80FF0; Thu, 27 Feb 2025 09:14:17 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB813801FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 09:14:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51R8E8Gl1713630
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Feb 2025 02:14:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740644048;
 bh=PHfvxUua4JCk1wGgd1gUOiBZDRvnIEwqrYmCG4+K0pw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=dXfZ8EeT/giRg6JHG2X3VNCmlfzyRsn6FBaj8Iz4LylLA+kHZD73AUMrEEm80mcJj
 NTtUCiVSQwTQWOfO+OG0NSf74bacRLlR65p8VAdfJThYA0Ow9TuFUM45aMTj0DIOwd
 6/+QAGDqhEiBwaCaAeSIjC/ikcuXFt1LxJv6A7RQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51R8E8BG016645
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Feb 2025 02:14:08 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Feb 2025 02:14:08 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Feb 2025 02:14:08 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51R8E733089782;
 Thu, 27 Feb 2025 02:14:07 -0600
Date: Thu, 27 Feb 2025 13:44:06 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
CC: Marek Vasut <marex@denx.de>, Siddharth Vadapalli <s-vadapalli@ti.com>, Tom
 Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] usb: dwc3: am62: Use UCLASS_NOP for glue driver
Message-ID: <20250227081406.zkfylkznmlg65nll@uda0492258>
References: <20250226-dwc3-am62-gadget-nop-v1-1-baff88b15ba0@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250226-dwc3-am62-gadget-nop-v1-1-baff88b15ba0@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Wed, Feb 26, 2025 at 03:47:11PM +0100, Mattijs Korpershoek wrote:

Hello Mattijs,

> The dwc3 driver allows SoC-specific configuration via the dwc3_glue_ops
> structure.
> These glue drivers usually just implement the .glue_configure function.

nitpick: Is there a reason behind an abrupt newline above? The sentence:
"These glue drivers..." could continue on the same line as the previous
sentence. Also, "These glue drivers..." is referring to glue drivers
which haven't been mentioned yet and it is the first time that they are
being referred to. It is not clear to me if there was more content in
between the first sentence and the second which accidentally got
removed.

> 
> For such glue drivers, we don't need to be a SIMPLE_BUS, since we
> don't interact with any child devices.

This sounds confusing. What does "we" refer to? The dwc3-am62.c driver
which is being modified in this patch is *the* glue driver itself.
"For such glue drivers" and "we don't need to be a SIMPLE_BUS" seem to
be referring to two different entities when they are probably the same.

"For such glue drivers" => dwc3-am62.c
"we don't need to be a SIMPLE_BUS" => Again dwc3-am62.c ?

Did you mean something like the following?
"Glue drivers don't need to be a SIMPLE_BUS since they don't interact
with any child devices"

> 
> Use UCLASS_NOP instead as done in the dwc3-generic-wrapper.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

The change made in the driver seems good to me, so with the above
questions addressed:

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

> ---
> This is a small cleanup intended for next.
> 
> This has been tested on AM62X SK EVM using:
> => fastboot usb 0
> 
> $ fastboot devices
> ????????????     Android Fastboot
> ---
>  drivers/usb/dwc3/dwc3-am62.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
> index 99519602eb2c66299445163fafcdb3e065c89eda..66164d0a80c0264bfc400426782324f8a57b8bd8 100644
> --- a/drivers/usb/dwc3/dwc3-am62.c
> +++ b/drivers/usb/dwc3/dwc3-am62.c
> @@ -116,7 +116,7 @@ static const struct udevice_id dwc3_am62_match[] = {
>  
>  U_BOOT_DRIVER(dwc3_am62_wrapper) = {
>  	.name	= "dwc3-am62",
> -	.id	= UCLASS_SIMPLE_BUS,
> +	.id	= UCLASS_NOP,
>  	.of_match = dwc3_am62_match,
>  	.bind = dwc3_glue_bind,
>  	.probe = dwc3_glue_probe,

Regards,
Siddharth.

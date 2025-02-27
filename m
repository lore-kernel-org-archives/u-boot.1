Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D093C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 10:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5DCC80FF0;
	Thu, 27 Feb 2025 11:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mf7zagt5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FD5F80F12; Thu, 27 Feb 2025 11:25:13 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE45A810F1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 11:25:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51RAP3Gr1737851
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 27 Feb 2025 04:25:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740651903;
 bh=Z0JqdZJmmRVy/c81Bu2xzLs/qi/YKLw6qeQvGw67w3A=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=mf7zagt5UnS+dYpdci+fO8Hn5vWE/4W1murpfL07JVd7r0/+lluUvJxfCzcvjCgcc
 K5Psh5aYoxf124fjEV9MUl3lXdMtbao3UiqgP5nhxRkc/iNX9Z9M7/BhjXGNGwn0DF
 hV9T3V2w2Fdy2LzRPECTcPKTlscB3EdKUvrwmSHE=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51RAP3T4037524;
 Thu, 27 Feb 2025 04:25:03 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Feb 2025 04:25:02 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Feb 2025 04:25:02 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51RAP1Pw109071;
 Thu, 27 Feb 2025 04:25:02 -0600
Date: Thu, 27 Feb 2025 15:55:01 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, Marek Vasut <marex@denx.de>, Tom
 Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] usb: dwc3: am62: Use UCLASS_NOP for glue driver
Message-ID: <20250227102501.ggyvyzbr63iurrcp@uda0492258>
References: <20250226-dwc3-am62-gadget-nop-v1-1-baff88b15ba0@baylibre.com>
 <20250227081406.zkfylkznmlg65nll@uda0492258>
 <871pvj1yh2.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871pvj1yh2.fsf@baylibre.com>
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

On Thu, Feb 27, 2025 at 11:19:37AM +0100, Mattijs Korpershoek wrote:
> Hi Siddharth,
> 
> Thank you for the the review.
> 
> On jeu., févr. 27, 2025 at 13:44, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
> 
> > On Wed, Feb 26, 2025 at 03:47:11PM +0100, Mattijs Korpershoek wrote:
> >
> > Hello Mattijs,
> >
> >> The dwc3 driver allows SoC-specific configuration via the dwc3_glue_ops
> >> structure.
> >> These glue drivers usually just implement the .glue_configure function.
> >
> > nitpick: Is there a reason behind an abrupt newline above? The sentence:
> > "These glue drivers..." could continue on the same line as the previous
> > sentence. Also, "These glue drivers..." is referring to glue drivers
> > which haven't been mentioned yet and it is the first time that they are
> > being referred to. It is not clear to me if there was more content in
> > between the first sentence and the second which accidentally got
> > removed.
> 
> I'll rephrase as:
> 
> """
> The dwc3 driver allows SoC-specific configuration via the dwc3_glue_ops
> structure. Glue drivers, which implement dwc3_glue_ops, usually just
> define the .glue_configure() function.
> """
> 
> Does that looks good ?

Yes.

> 
> >
> >> 
> >> For such glue drivers, we don't need to be a SIMPLE_BUS, since we
> >> don't interact with any child devices.
> >
> > This sounds confusing. What does "we" refer to? The dwc3-am62.c driver
> > which is being modified in this patch is *the* glue driver itself.
> > "For such glue drivers" and "we don't need to be a SIMPLE_BUS" seem to
> > be referring to two different entities when they are probably the same.
> >
> > "For such glue drivers" => dwc3-am62.c
> > "we don't need to be a SIMPLE_BUS" => Again dwc3-am62.c ?
> 
> I'll rephrase as:
> 
> """
> dwc3-am62 is such glue driver which does not need to be a SIMPLE_BUS
> since it does not interact with any child device.
> """
> 
> Is that okay ?

Yes.

> 
> >
> > Did you mean something like the following?
> > "Glue drivers don't need to be a SIMPLE_BUS since they don't interact
> > with any child devices"
> 
> I can't write that down, because that's not true. Some glue drivers (like
> dwc3-meson-g12a) need to be SIMPLE_BUS because they rely on
> .child_pre_probe() and .child_post_remove().

Understood. Thank you for clarifying and for rephrasing the commit
message above. Please feel free to add my Reviewed-by tag when posting
the v2 patch.


Regards,
Siddharth.

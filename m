Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8DFCA0EFC
	for <u-boot@archiver.kernel.org>; Sun, 24 Aug 2025 08:02:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A954582998;
	Sun, 24 Aug 2025 10:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sG6nkBX4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8FB582AE1; Sun, 24 Aug 2025 10:02:41 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02789828A2
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 10:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57O82UOU1043191;
 Sun, 24 Aug 2025 03:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756022550;
 bh=0nz0XorugURIepI9Kj2TGcu9kxXv0pNPqMUVlLQKGfE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=sG6nkBX4WbWbOd5u717OOWS0cl0oxH9/tsw9PFozMW27KqYGMViPTCjKqkTDtknqc
 Z4rGeLymr5tmD3LY6CHEB60gTiLTS5ypWQtmaf73AJOz7jSLcM3FccVq7iamZgnSkf
 ej3iMVDqY4gf5p2itueFWMTc5xVtVNknF2O3dUZg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57O82UFu689535
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Sun, 24 Aug 2025 03:02:30 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sun, 24
 Aug 2025 03:02:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sun, 24 Aug 2025 03:02:30 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57O82SNq2135734;
 Sun, 24 Aug 2025 03:02:29 -0500
Date: Sun, 24 Aug 2025 13:32:28 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Marek Vasut <marek.vasut@mailbox.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>, "vigneshr@ti.com"
 <vigneshr@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] usb: cdns3: Do not access memory after free
Message-ID: <6e5ccaaa-3ced-440a-abe7-439ef6e7f1db@ti.com>
References: <20250813-usb_cdns3-v1-1-3779912fe660@linaro.org>
 <b83f79a7-66e9-43b9-859e-ebb69e4d536b@nabladev.com>
 <0a4f4611-8858-4a38-be70-bf0947d689c1@linaro.org>
 <84535d73-7496-4fd3-8ecb-ac6830974d51@mailbox.org>
 <e2257066-ee97-44ff-9338-cec69f8c7f03@ti.com>
 <2ff9412a-795c-422b-9be4-576e64a7f395@mailbox.org>
 <63d6759a-a8be-41d6-8870-72bdc3856c05@ti.com>
 <bf35a459-29dc-48f8-a353-7f75493e959c@mailbox.org>
 <a6bb77e3-2702-469d-a684-0dce753e78b0@ti.com>
 <24dab90e-b15a-49d6-acbb-3302ae34ac1a@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <24dab90e-b15a-49d6-acbb-3302ae34ac1a@mailbox.org>
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

On Sat, Aug 23, 2025 at 02:21:18PM +0200, Marek Vasut wrote:
> On 8/23/25 4:07 AM, Siddharth Vadapalli wrote:
> 
> Hi,
> 
> > > > > > I was planning to test this patch but the change being made is only
> > > > > > applicable to Controller Versions:
> > > > > > 	#define DEV_VER_NXP_V1		0x00024502
> > > > > > 	#define DEV_VER_TI_V1		0x00024509
> > > > > > and not to:
> > > > > > 	#define DEV_VER_V2		0x0002450C
> > > > > > 	#define DEV_VER_V3		0x0002450d
> > > > > > 
> > > > > > Since I don't have an SoC and a Board with DEV_VER_TI_V1, I cannot test
> > > > > > it. However, the change looks correct to me.
> > > > > > 
> > > > > > Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > > > The change does indeed look correct.
> > > > > 
> > > > > Do you know who might still have that board and could test ? (and which
> > > > > board/soc is that) ?
> > > > 
> > > > None of the boards that I have worked with have a DEV_VER_TI_V1 version
> > > > of the controller. I also tried to use the Linux device-tree to check if
> > > > I could identify the SoC/board but I was unable to do so.
> > > Do you know which SoC is V2 and V3 ?
> > 
> > I spent more time on this and found out that J721E SR 1.0 has the
> > controller with DEV_VER_TI_V1 version but other revisions of J721E as
> > well as all of the following SoCs have DEV_VER_V3 version of the
> > controller:
> > AM64, AM68, AM69, J7200, J721S2, J722S, J742S2 and J784S4.
> > 
> > I will try to find an SR 1.0 J721E SoC and test the patch on it and
> > share the results here.
> This is awesome, thank you !

I was able to get an SR 1.0 J721E SoC and also the J721E
Common-Processor-Board for testing the patch.

Enabling debug info in the cdns3/gadget.c driver, I see:
	cdns-usb3-peripheral usb@6000000: Device Controller version: 00024509
	cdns-usb3-peripheral usb@6000000: USB Capabilities:: 09203324
	cdns-usb3-peripheral usb@6000000: On-Chip memory cnfiguration: 00000c34
which confirms the Controller Version.

However, the code changed by the current patch is only affecting the
execution of code associated with Workaround 2 which is described in
detail in the driver. I am summarizing it here for your reference:

Issue:
	Controller for OUT endpoints has shared on-chip buffers for all
	incoming packets. The buffer acts as a FIFO, due to which,
	missing a DMA descriptor for one packet will block subsequent
	transfers/packets meant for other Endpoints that were queued.

Workaround:
	If the Endpoint Status register indicates a Descriptor Miss,
	rearm the DMA transfer to complete the missed transfer.

In order to test the patch, I used USBACM for STDIO/STDOUT to check if I
could trigger the descriptor miss workaround. The command I ran was:
setenv stdio usbacm; setenv stdout usbacm;
/dev/ttyACM0 showed up on my PC and I was also able to access the U-Boot
prompt via ACM0. While it is functional, I didn't see the code
associated with the workaround being triggered. Reviewing the driver
again, I identified that the workaround is being disabled very early on
within "cdns3_wa2_gadget_ep_queue()" with the comment stating:

	 * If transfer was queued before DESCMISS appear than we
	 * can disable handling of DESCMISS interrupt. Driver assumes that it
	 * can disable special treatment for this endpoint.

Given the above, it doesn't seem easy to recreate the issue since I
would have to trigger a descriptor miss event prior to the very first
USB transfer for the Endpoint. Please let me know if you have any
suggestions for speeding up testing.

Regards,
Siddharth.

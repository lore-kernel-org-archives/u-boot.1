Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63178CA0EED
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 04:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8365483443;
	Fri, 29 Aug 2025 06:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ln8+71be";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FE4483487; Fri, 29 Aug 2025 06:22:44 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EE7B8341A
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 06:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57T4MaTq1721241;
 Thu, 28 Aug 2025 23:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756441356;
 bh=S4T0IfiKU/obHhqQEpwIQqFTU282xb02FuAhxmSaqoo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ln8+71be3lifD/V+890Cv0XIJWhrXpoanl3VuGCN5VwqRgcMR482x445qfcdO3+SL
 K6ZJmlB5LfQ0TvQFPFNXtj2r+AoafpdazRgLyGaPMtcJ5sfhjcqdUMOR5N5FEDVzsg
 UW2Kax4rOB8YHEAElhtCMLZthOl/VJpRF3RprBuQ=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57T4MZ9s3382732
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 28 Aug 2025 23:22:35 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 28
 Aug 2025 23:22:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 28 Aug 2025 23:22:35 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57T4MYrI1466725;
 Thu, 28 Aug 2025 23:22:34 -0500
Date: Fri, 29 Aug 2025 09:52:33 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Marek Vasut <marek.vasut@mailbox.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>, "vigneshr@ti.com"
 <vigneshr@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] usb: cdns3: Do not access memory after free
Message-ID: <f54f56aa-e355-4c18-8791-027a67fc8eb6@ti.com>
References: <0a4f4611-8858-4a38-be70-bf0947d689c1@linaro.org>
 <84535d73-7496-4fd3-8ecb-ac6830974d51@mailbox.org>
 <e2257066-ee97-44ff-9338-cec69f8c7f03@ti.com>
 <2ff9412a-795c-422b-9be4-576e64a7f395@mailbox.org>
 <63d6759a-a8be-41d6-8870-72bdc3856c05@ti.com>
 <bf35a459-29dc-48f8-a353-7f75493e959c@mailbox.org>
 <a6bb77e3-2702-469d-a684-0dce753e78b0@ti.com>
 <24dab90e-b15a-49d6-acbb-3302ae34ac1a@mailbox.org>
 <6e5ccaaa-3ced-440a-abe7-439ef6e7f1db@ti.com>
 <9833dfa9-562a-4f2d-ae65-d00bc4de2c92@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9833dfa9-562a-4f2d-ae65-d00bc4de2c92@mailbox.org>
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

On Thu, Aug 28, 2025 at 05:46:56PM +0200, Marek Vasut wrote:
> On 8/24/25 10:02 AM, Siddharth Vadapalli wrote:
> > On Sat, Aug 23, 2025 at 02:21:18PM +0200, Marek Vasut wrote:
> > > On 8/23/25 4:07 AM, Siddharth Vadapalli wrote:
> > > 
> > > Hi,
> > > 
> > > > > > > > I was planning to test this patch but the change being made is only
> > > > > > > > applicable to Controller Versions:
> > > > > > > > 	#define DEV_VER_NXP_V1		0x00024502
> > > > > > > > 	#define DEV_VER_TI_V1		0x00024509
> > > > > > > > and not to:
> > > > > > > > 	#define DEV_VER_V2		0x0002450C
> > > > > > > > 	#define DEV_VER_V3		0x0002450d
> > > > > > > > 
> > > > > > > > Since I don't have an SoC and a Board with DEV_VER_TI_V1, I cannot test
> > > > > > > > it. However, the change looks correct to me.
> > > > > > > > 
> > > > > > > > Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > > > > > The change does indeed look correct.
> > > > > > > 
> > > > > > > Do you know who might still have that board and could test ? (and which
> > > > > > > board/soc is that) ?
> > > > > > 
> > > > > > None of the boards that I have worked with have a DEV_VER_TI_V1 version
> > > > > > of the controller. I also tried to use the Linux device-tree to check if
> > > > > > I could identify the SoC/board but I was unable to do so.
> > > > > Do you know which SoC is V2 and V3 ?
> > > > 
> > > > I spent more time on this and found out that J721E SR 1.0 has the
> > > > controller with DEV_VER_TI_V1 version but other revisions of J721E as
> > > > well as all of the following SoCs have DEV_VER_V3 version of the
> > > > controller:
> > > > AM64, AM68, AM69, J7200, J721S2, J722S, J742S2 and J784S4.
> > > > 
> > > > I will try to find an SR 1.0 J721E SoC and test the patch on it and
> > > > share the results here.
> > > This is awesome, thank you !
> > 
> > I was able to get an SR 1.0 J721E SoC and also the J721E
> > Common-Processor-Board for testing the patch.
> > 
> > Enabling debug info in the cdns3/gadget.c driver, I see:
> > 	cdns-usb3-peripheral usb@6000000: Device Controller version: 00024509
> > 	cdns-usb3-peripheral usb@6000000: USB Capabilities:: 09203324
> > 	cdns-usb3-peripheral usb@6000000: On-Chip memory cnfiguration: 00000c34
> > which confirms the Controller Version.
> > 
> > However, the code changed by the current patch is only affecting the
> > execution of code associated with Workaround 2 which is described in
> > detail in the driver. I am summarizing it here for your reference:
> > 
> > Issue:
> > 	Controller for OUT endpoints has shared on-chip buffers for all
> > 	incoming packets. The buffer acts as a FIFO, due to which,
> > 	missing a DMA descriptor for one packet will block subsequent
> > 	transfers/packets meant for other Endpoints that were queued.
> > 
> > Workaround:
> > 	If the Endpoint Status register indicates a Descriptor Miss,
> > 	rearm the DMA transfer to complete the missed transfer.
> > 
> > In order to test the patch, I used USBACM for STDIO/STDOUT to check if I
> > could trigger the descriptor miss workaround. The command I ran was:
> > setenv stdio usbacm; setenv stdout usbacm;
> > /dev/ttyACM0 showed up on my PC and I was also able to access the U-Boot
> > prompt via ACM0. While it is functional, I didn't see the code
> > associated with the workaround being triggered. Reviewing the driver
> > again, I identified that the workaround is being disabled very early on
> > within "cdns3_wa2_gadget_ep_queue()" with the comment stating:
> > 
> > 	 * If transfer was queued before DESCMISS appear than we
> > 	 * can disable handling of DESCMISS interrupt. Driver assumes that it
> > 	 * can disable special treatment for this endpoint.
> > 
> > Given the above, it doesn't seem easy to recreate the issue since I
> > would have to trigger a descriptor miss event prior to the very first
> > USB transfer for the Endpoint. Please let me know if you have any
> > suggestions for speeding up testing.
> Can you maybe simply force-enable the workaround code and see if that itself
> works, without crashing ? If yes, then I would say let's apply this.

I did try it out when I wasn't able to trigger the workaround and I
didn't see a crash. It seemed to work without issues but I didn't
mention it since I felt that this wasn't the right way to test it.
Nevertheless, I can confirm that I did not see a crash when forcing the
workaround code to execute.

Regards,
Siddharth.

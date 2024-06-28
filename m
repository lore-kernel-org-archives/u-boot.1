Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051D8C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 17:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3896C884A7;
	Fri, 28 Jun 2024 19:40:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="efL/a+Bs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F410188254; Fri, 28 Jun 2024 19:40:13 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A673881EC
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 19:40:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45SHe9qs016648;
 Fri, 28 Jun 2024 12:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719596409;
 bh=JpNpNRpKyhPRw/OOEwm0ap71PHJLseAf2hEqkYdrBGE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=efL/a+BsmPTrihCrKBDBFlesH6yBlDtkcDq07tyTvxf9+c085t+NZDIWaMpt8tADu
 RhvCn/KDvQHR8Q/lRCKZWGsttebaLlD7MFr9Dewnyk/6afZ8DaCByXMvReRdl1EXBI
 XmhN2+2VpWlZJp/dFkh3i4EzpehypVHcrd/pAXkk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45SHe8da022098
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Jun 2024 12:40:09 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 12:40:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 12:40:08 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45SHe8AA053015;
 Fri, 28 Jun 2024 12:40:08 -0500
Date: Fri, 28 Jun 2024 12:40:08 -0500
From: Nishanth Menon <nm@ti.com>
To: Sebin Francis <sebin.francis@ti.com>
CC: Dhruva Gole <d-gole@ti.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>,
 <c-shilwant@ti.com>, <m-chawdhry@ti.com>, <vigneshr@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>,
 Vibhore Vardhan <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>
Subject: Re: [PATCH V3 0/4] Low Power Mode: Pakage TIFS Stub on BeaglePlay
Message-ID: <20240628174008.tjdhwvzj7mxaka6z@destruct>
References: <20240628093252.1864609-1-d-gole@ti.com>
 <20240628130323.vxy7rruh3bdcklxe@brownnose>
 <067d0bd4-867f-4d48-8852-f5d8e04ffc2a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <067d0bd4-867f-4d48-8852-f5d8e04ffc2a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 19:39-20240628, Sebin Francis wrote:
> 
> On 28/06/24 18:33, Nishanth Menon wrote:
> > On 15:02-20240628, Dhruva Gole wrote:
> > > This series includes the binman related changes required to package tIFS
> > > Stub to support Low Power Modes on BeaglePlay.
> > > Also, based on comments from previous patch [0] documentation has been
> > > added to describe small addition in boot flow as well as tispl image
> > > format.
> > > 
> > > I am aware that the new boot flow image will need to be updated in
> > > other places like am62a, am62p and even other boards that use am62x.
> > > However, I would like to keep this series beagleplay TIFSStub specific
> > > and so I will be sending a follow up series to update other places
> > > seperately if that's ok.

[...]
> > 
> > Maybe you can help clarify a bit. I understand from [1]
> > that you are betting on timing to keep tifs stub safe. But then, why
> > not plug in this firmware blob along with DM itself? that allows DM
> > to manage itself the way it wants to and control it's own memory map?
> > DM initialization itself takes a few ms, just because TFA is not
> > touching any part of DDR does not mean that we can assume system is
> > interference free, no? What if DM architecture changes such that PLL
> > initialization or some other long pole item is performed prior to
> > loading the tifs stub?
> 
> In Linux DT the address space in which FS stub is copied is part of DM
> firmware carve-out in DDR,
> so if fs stub can get corrupted then DM also can get corrupted.

OK - so the memory map we are copying to is already reserved in device
tree?

See this thread[1] - we are arguing here that the reserved region is
meant for bootloader to fill up and keep protected. DT itself from
kernel is shared between u-boot and kernel OF_UPSTREAM.

Now, the consumer of the binary is DM, the load area is already part of
carveout for DM, it sounds like it should have been packaged with DM
itself instead of making the packaging problem the problem that everyone
image creation system has to solve - not to mention signing etc..

Why not merge this with DM?


[1] https://lore.kernel.org/all/59c391a7-c6fe-4b04-891a-c6905ef29f20@ti.com/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

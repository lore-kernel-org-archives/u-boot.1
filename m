Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A535E6F06F
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 17:36:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8764D88FBB;
	Fri,  1 Nov 2024 18:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TeJxKMCO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C3BA89017; Fri,  1 Nov 2024 18:36:39 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC94288E3C
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 18:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A1HaXgk125219;
 Fri, 1 Nov 2024 12:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1730482593;
 bh=9IIpjX6jm5+lpJGeDMh4aXTc80A4YlDw8bHR2KP/CTM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=TeJxKMCODH2yXDMR8Bj2WpxR0Xby2ShJor1fYC8ethp5p+c3KMdjoYO9YpZWpelx9
 Dbm4DmLpI3gg5vgqj7kdU+BRMealNKvLeg5Mzd3nCN8k5nqn/QUcBWPITYqFG9oLxz
 FrzGN36VETIhZveUpfeZuVtjCZtAfPQ3UWZpsQ5I=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A1HaXmu010790
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Nov 2024 12:36:33 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Nov 2024 12:36:33 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Nov 2024 12:36:33 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A1HaXbI073354;
 Fri, 1 Nov 2024 12:36:33 -0500
Date: Fri, 1 Nov 2024 12:36:33 -0500
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Garrett Giordano <ggiordano@phytec.com>, <trini@konsulko.com>,
 <w.egorov@phytec.de>, <vaishnav.a@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <a-nandan@ti.com>, <nm@ti.com>,
 <sjg@chromium.org>, <a-bhatia1@ti.com>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
Subject: Re: [PATCH v2] arm: mach-k3: am62a7: Provide a way to obtain boot
 device for non SPLs
Message-ID: <20241101173633.kxva6hqdezyoozt6@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20241031162103.2835289-1-ggiordano@phytec.com>
 <72769d4e-9f13-499f-b20c-b1c454a60066@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <72769d4e-9f13-499f-b20c-b1c454a60066@ti.com>
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

On October 31, 2024 thus sayeth Andrew Davis:
> On 10/31/24 11:21 AM, Garrett Giordano wrote:
> > Introduce get_boot_device() to obtain the booting device. Make it also
> > available for non SPL builds so u-boot can also know the device it
> > is booting from.
> > 
> > Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
> > Reviewed-by: Bryan Brattlof <bb@ti.com>
> > ---
> 
> Seems similar enough to what has been done already for AM64x, might
> be good at some point to just do this for all the K3 SoCs. I wonder how
> much of the contents of these functions are common across them all..
> 

I was thinking the same thing. This will be helpful for all of the SoCs. 
The boodmode functions are very common however we'll most likely need to 
expand it to handle modes a specific SoC doesn't support.

~Bryan


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294B1C47DAF
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 14:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7990C87CBB;
	Fri, 19 Jan 2024 15:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nfEgQ6XR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 037F187CC1; Fri, 19 Jan 2024 15:45:25 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 595B987BE1
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 15:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40JEjKrT010451
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:45:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705675520;
 bh=/ElQJef4c3dm7tOpNLyhVrhT74GWfTnHfnJmoIVThtQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=nfEgQ6XRFa2OHUWtgRPKuaaTmSYW1L9XrLBF200NkAl1NMeQattWI/hecz7zmeH/b
 j4GktEDxXa+NBtVGG8sBbob9NdsygvLZIA/ZCWg3yzqkr2ndClMGia3ZFmpnS3d5BA
 jIkGtJLy2pkCiohNOUWebswFb8lIhD1tRuKfviAA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40JEjKct044893
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:45:20 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Jan 2024 08:45:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Jan 2024 08:45:20 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40JEjKVo000362;
 Fri, 19 Jan 2024 08:45:20 -0600
Date: Fri, 19 Jan 2024 08:45:19 -0600
From: Nishanth Menon <nm@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: Bhavya Kapoor <b-kapoor@ti.com>, <u-boot@lists.denx.de>, <jm@ti.com>,
 <m-chawdhry@ti.com>, <reidt@ti.com>, <n-francis@ti.com>
Subject: Re: [PATCH 0/2] arm: dts: Add Itap Delay Value For High Speed DDR
Message-ID: <20240119144519.7co3rol6iv5xf745@record>
References: <20240108051922.29044-1-b-kapoor@ti.com>
 <20240108140502.euuxmgutu4gcd7pn@bryanbrattlof.com>
 <8a17f24b-62d3-4535-8433-02d3ff261331@ti.com>
 <20240110132046.jazbhcf6o246u6br@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240110132046.jazbhcf6o246u6br@bryanbrattlof.com>
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

On 07:20-20240110, Bryan Brattlof wrote:
> On January 10, 2024 thus sayeth Bhavya Kapoor:
> > 
> > On 08/01/24 7:35 pm, Bryan Brattlof wrote:
> > > Hi Bhavya!
> > > 
> > > On January  8, 2024 thus sayeth Bhavya Kapoor:
> > > > This Series adds Itap Delay Value for DDR52 speed mode for eMMC in
> > > > J7200 SoC and for DDR50 speed mode for MMCSD in J721s2 SoC.
> > > > 
> > > > Bhavya Kapoor (2):
> > > >    arm: dts: k3-j7200-main: Add Itap Delay Value For DDR52 speed mode
> > > >    arm: dts: k3-j721s2-main: Add Itap Delay Value For DDR50 speed mode
> > > > 
> > > >   arch/arm/dts/k3-j7200-main.dtsi  | 1 +
> > > >   arch/arm/dts/k3-j721s2-main.dtsi | 1 +
> > > Because of the periodic syncs with the kernel, modifying these dt files
> > > in U-Boot will cause confusion. (Which node is correct why did we have
> > > to do this in U-Boot and not in the Kernel... bla bla bla) If they
> > > absolutely need to go in now please override these nodes in the
> > > *-u-boot.dtsi files with a comment so we can keep track of these changes
> > > during the next sync with Linux.
> > > 
> > > ~Bryan
> > 
> > Hi Bryan, Fyi, This patch went in kernel as well.
> > 
> > Can be tracked below-
> > 
> > https://lore.kernel.org/all/170266085077.3490141.14935960940418963459.b4-ty@ti.com/
> > 
> > So , kernel and uboot dt files will remain in sync.
> > 
> 
> Sorry I may be missing something. Why do we need these properties in 
> U-Boot now? Why not wait 2 weeks for the v6.8-rc1 tag in Linux and sync 
> everything all at once?

I agree. NAK for the series. Please get this part of dts sync.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

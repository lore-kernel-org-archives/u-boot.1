Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57286C4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 13:20:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A4ED87906;
	Wed, 10 Jan 2024 14:20:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jYJbyGmt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A436D87719; Wed, 10 Jan 2024 14:20:53 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E11F08791E
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 14:20:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40ADKl22073758
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 07:20:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704892847;
 bh=qoY6eu9O/sJYHfDaPLrQhBDY4XLxnbWr2KEdeaxDdtc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=jYJbyGmtKFDhKby8klre/I+CGUssor5xG/mc+tAApl9XoVE4uG1SeFk1JQ1X/y8Y0
 E1f8UugZQndjHCn3wPSQ5rElhUYsGp9RdIlenwXA5QX64SoLiyZSllEExWntNMZRQc
 +OIh7DaCLxuC9lW/fLOCBYERL3Q+mXUkCQsggJq4=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40ADKlRo053703
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 07:20:47 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Jan 2024 07:20:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Jan 2024 07:20:46 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40ADKkGp110780;
 Wed, 10 Jan 2024 07:20:46 -0600
Date: Wed, 10 Jan 2024 07:20:46 -0600
From: Bryan Brattlof <bb@ti.com>
To: Bhavya Kapoor <b-kapoor@ti.com>
CC: <u-boot@lists.denx.de>, <jm@ti.com>, <m-chawdhry@ti.com>, <reidt@ti.com>, 
 <n-francis@ti.com>
Subject: Re: [PATCH 0/2] arm: dts: Add Itap Delay Value For High Speed DDR
Message-ID: <20240110132046.jazbhcf6o246u6br@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240108051922.29044-1-b-kapoor@ti.com>
 <20240108140502.euuxmgutu4gcd7pn@bryanbrattlof.com>
 <8a17f24b-62d3-4535-8433-02d3ff261331@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <8a17f24b-62d3-4535-8433-02d3ff261331@ti.com>
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

On January 10, 2024 thus sayeth Bhavya Kapoor:
> 
> On 08/01/24 7:35 pm, Bryan Brattlof wrote:
> > Hi Bhavya!
> > 
> > On January  8, 2024 thus sayeth Bhavya Kapoor:
> > > This Series adds Itap Delay Value for DDR52 speed mode for eMMC in
> > > J7200 SoC and for DDR50 speed mode for MMCSD in J721s2 SoC.
> > > 
> > > Bhavya Kapoor (2):
> > >    arm: dts: k3-j7200-main: Add Itap Delay Value For DDR52 speed mode
> > >    arm: dts: k3-j721s2-main: Add Itap Delay Value For DDR50 speed mode
> > > 
> > >   arch/arm/dts/k3-j7200-main.dtsi  | 1 +
> > >   arch/arm/dts/k3-j721s2-main.dtsi | 1 +
> > Because of the periodic syncs with the kernel, modifying these dt files
> > in U-Boot will cause confusion. (Which node is correct why did we have
> > to do this in U-Boot and not in the Kernel... bla bla bla) If they
> > absolutely need to go in now please override these nodes in the
> > *-u-boot.dtsi files with a comment so we can keep track of these changes
> > during the next sync with Linux.
> > 
> > ~Bryan
> 
> Hi Bryan, Fyi, This patch went in kernel as well.
> 
> Can be tracked below-
> 
> https://lore.kernel.org/all/170266085077.3490141.14935960940418963459.b4-ty@ti.com/
> 
> So , kernel and uboot dt files will remain in sync.
> 

Sorry I may be missing something. Why do we need these properties in 
U-Boot now? Why not wait 2 weeks for the v6.8-rc1 tag in Linux and sync 
everything all at once?

~Bryan

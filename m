Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5FBC46CD3
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 12:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 708EF87650;
	Wed, 20 Dec 2023 13:52:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mBilnYZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B52A7876D5; Wed, 20 Dec 2023 13:52:38 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A6DA874D5
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:52:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BKCqKVa096463;
 Wed, 20 Dec 2023 06:52:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703076740;
 bh=uqdwUPlykc0H4ank25Zu7c682b1I0tqnTFyfnS9sh3k=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=mBilnYZmZXn2UV9RgIZiqAqqS+6lSM3+vsVrUlZ3oNfxwkEAh//eaim1jUJCiupnq
 EDNyb4dL9kM3lraYdzJaGLKablN21HDun45Fh88WvIRJWmLRJZbzZs6V10j6+sbcW2
 bkL3bbF66HGNhWFPeSU6OFPnvw4xVw7kzgkpIwww=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BKCqK41013710
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 Dec 2023 06:52:20 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Dec 2023 06:52:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Dec 2023 06:52:20 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BKCqKST064444;
 Wed, 20 Dec 2023 06:52:20 -0600
Date: Wed, 20 Dec 2023 06:52:20 -0600
From: Nishanth Menon <nm@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
CC: Tom Rini <trini@konsulko.com>, Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>, Joe
 Hershberger <joe.hershberger@ni.com>,
 Simon Glass <sjg@chromium.org>, <u-boot@lists.denx.de>, <srk@ti.com>,
 <r-gunasekaran@ti.com>
Subject: Re: [RFC PATCH 10/16] arm: dts: k3-am65-main: Add ICSSG IEP nodes
Message-ID: <20231220125220.ucobgoruw7vdjqx6@tumble>
References: <20231219103418.3445886-1-danishanwar@ti.com>
 <20231219103418.3445886-11-danishanwar@ti.com>
 <20231219174601.GA2513409@bill-the-cat>
 <8a4fe530-370d-469c-a518-f52b3e65658d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8a4fe530-370d-469c-a518-f52b3e65658d@ti.com>
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

On 10:17-20231220, MD Danish Anwar wrote:
> Hi Tom,
> 
> On 19/12/23 11:16 pm, Tom Rini wrote:
> > On Tue, Dec 19, 2023 at 04:04:12PM +0530, MD Danish Anwar wrote:
> > 
> >> The ICSSG IP on AM65x SoCs have two Industrial Ethernet Peripherals (IEPs)
> >> to manage/generate Industrial Ethernet functions such as time stamping.
> >> Each IEP sub-module is sourced from an internal clock mux that can be
> >> sourced from either of the IP instance's ICSSG_IEP_GCLK or ICSSG_ICLK.
> >> Add the IEP nodes for all the ICSSG instances.
> >>
> >> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> >> ---
> >>  arch/arm/dts/k3-am65-main.dtsi | 36 ++++++++++++++++++++++++++++++++++
> >>  1 file changed, 36 insertions(+)
> > 
> > What's the status of all of the DT side of this, upstream?
> > 
> 
> All of the DT patches are already part of upstream linux kernel except
> for patch 08/16. This patch is currently in linux-next and will be in
> linux in 6.8-rc1.
> 

NAK.

Send a sync at 6.8-rc1 and then start working - DONOT SEND patches
modifying SoC dtsi or evm files directly in u-boot.

I think you need to start talking to other folks in the team who have
have received the same feedback.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

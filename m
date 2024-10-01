Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBA4CE7D10
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 10:57:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6A0F89062;
	Tue,  1 Oct 2024 12:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="T7BZoIcG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFBFD890AE; Tue,  1 Oct 2024 12:57:56 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79FE989042
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 12:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 491Avns6113613;
 Tue, 1 Oct 2024 05:57:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1727780269;
 bh=0ilxDfe6gtqaXD2uFs0y7qdz8aadNnEphqYMKhfceYc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=T7BZoIcGzzbCTk9kSi99LAIqjLTSt+8US6VHW89JKgYN1Ob4s6HCiLMCL+xBpLRxz
 5iK3H9Sd1o4WQC1bh0t9uIW74Z5Gn2PRYb2mKWfO9t5lnB4C+sNGLSdQt5ZgWfmdfy
 G8InpKCq/jtOnJeS2NzSxxomcNfrm6R76PCZNI6A=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 491Avnjh072899
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 1 Oct 2024 05:57:49 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Oct 2024 05:57:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Oct 2024 05:57:49 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 491AvmDe107920;
 Tue, 1 Oct 2024 05:57:48 -0500
Date: Tue, 1 Oct 2024 16:27:47 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>, <u-boot@lists.denx.de>, Neha
 Malcom Francis <n-francis@ti.com>, Keerthy J <j-keerthy@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 6/7] arm: dts: j721s2: Add VTM node in R5
Message-ID: <20241001105747.3njnaxvcvqz7jrp4@uda0497581>
References: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
 <20240813-b4-upstream-j721s2-avs-v3-6-5115d93cdeb2@ti.com>
 <2c18e837-d3ce-46f6-9e26-9938d4c9aa00@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2c18e837-d3ce-46f6-9e26-9938d4c9aa00@ti.com>
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

Hi Udit,

On 08:47-20240815, Kumar, Udit wrote:
> 
> On 8/13/2024 11:40 AM, Manorit Chawdhry wrote:
> > Add bootph-pre-ram property to VTM node and the pmic node.
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >   arch/arm/dts/k3-j721s2-r5-common-proc-board.dts | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> > index e92b1917df4e..506ad9b7910d 100644
> > --- a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> > +++ b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> > @@ -10,3 +10,12 @@
> >   #include "k3-j721s2-ddr.dtsi"
> >   #include "k3-j721s2-common-proc-board-u-boot.dtsi"
> >   #include "k3-j721s2-r5.dtsi"
> > +
> > +&tps659411 {
> > +	bootph-pre-ram;
> > +};
> 
> Ok for now. but do you plan to add this bootph-pre-ram in Linux DT too ?
> 

Yes, it's taken as a part of the series that's being run parallely in
Linux [0]

[0]: https://lore.kernel.org/linux-arm-kernel/20240814-b4-upstream-bootph-all-v4-0-f2b462000f25@ti.com/

Regards,
Manorit

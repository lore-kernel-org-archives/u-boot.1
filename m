Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BECCE7CE7
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 08:45:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9211F89141;
	Tue,  1 Oct 2024 10:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PFBCrqTY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69E2789157; Tue,  1 Oct 2024 10:45:52 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F8FE890EE
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 10:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4918jlcs000507;
 Tue, 1 Oct 2024 03:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1727772347;
 bh=jXdtwwn8NfS+u9pxD9FXb2VOYA/CqbMHraFIhWzcZYQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=PFBCrqTYELAKTOnUnNmdcaf473n8XGRHpQxAi/LNyy1Z8yy5WU1dgO1917GMWUn/L
 fMo4tYx7/ianVE5nX61PuRkG1G7cMOjrcEIxWAcrYOHjMfslPTE/2+4cUimExiuj2f
 U7Isvmxa96ztjtYvWITufe/BoBWcDYYCJmeQO6jI=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4918jl7C106131
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 1 Oct 2024 03:45:47 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Oct 2024 03:45:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Oct 2024 03:45:46 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4918jklM046504;
 Tue, 1 Oct 2024 03:45:46 -0500
Date: Tue, 1 Oct 2024 14:15:45 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>, <u-boot@lists.denx.de>, Neha
 Malcom Francis <n-francis@ti.com>, Keerthy J <j-keerthy@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 3/7] arm: dts: k3-j7*-r5: Add MPU clock in clocks
 property
Message-ID: <20241001084545.deczxnqd6eqsazcy@uda0497581>
References: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
 <20240813-b4-upstream-j721s2-avs-v3-3-5115d93cdeb2@ti.com>
 <7be4c52f-bebc-4cdb-af39-f58dba729fd1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7be4c52f-bebc-4cdb-af39-f58dba729fd1@ti.com>
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

On 08:32-20240815, Kumar, Udit wrote:
> 
> On 8/13/2024 11:40 AM, Manorit Chawdhry wrote:
> > MPU clock had been missing. Distinguish multiple clocks with clock-names
> > and add MPU clock as well.
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >   arch/arm/dts/k3-am69-r5-sk.dts                 | 3 ++-
> >   arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 3 ++-
> >   arch/arm/dts/k3-j721e-r5.dtsi                  | 3 ++-
> >   arch/arm/dts/k3-j721s2-r5.dtsi                 | 3 ++-
> >   arch/arm/dts/k3-j784s4-r5-evm.dts              | 3 ++-
> >   5 files changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/dts/k3-am69-r5-sk.dts b/arch/arm/dts/k3-am69-r5-sk.dts
> > index f177f563527f..9bbf76d8bf35 100644
> > --- a/arch/arm/dts/k3-am69-r5-sk.dts
> > +++ b/arch/arm/dts/k3-am69-r5-sk.dts
> > @@ -26,7 +26,8 @@
> >   		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> >   				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
> >   		resets = <&k3_reset 202 0>;
> > -		clocks = <&k3_clks 61 0>;
> > +		clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
> 
> 
> Thanks for catching this
> 
> Could we think of having SOC specific R5 dt , So that we don't need to
> update such SOC information at each board level
> 
> Similar to what is done (k3-j721e-r5.dtsi)

Seems like a good idea but I believe that it could be a separate
activity regardless of this series, it can be taken up later. Current
series is putting it in the respective files so should be a non blocker.

Regards,
Manorit

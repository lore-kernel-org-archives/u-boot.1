Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1881C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 07:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9944E86456;
	Mon, 28 Aug 2023 09:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="thdlHbtf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5856686458; Mon, 28 Aug 2023 09:57:05 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 220FA86453
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 09:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37S7v08m052366;
 Mon, 28 Aug 2023 02:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693209420;
 bh=pOAVWytV4qFgRTYuXVFGqCqbQVlE1FbCZXJXml/avV8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=thdlHbtfln/XH9HKyf0DwQhqS1rkJXBs1BzcoxEYBKF+CGUIupL4Idkn+cJ9jipOG
 fyM6DPurry1NFo/9qjp27BDzccGPI2gmA0kOmVDF0Ry7R/uWTz9phGvjCeazQCOq7X
 ynZaitUYBejxIFmVs+e3PkzTT8ywjKbxGOVNB/74=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37S7v0nl093690
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Aug 2023 02:57:00 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Aug 2023 02:56:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Aug 2023 02:56:59 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37S7uwbv023714;
 Mon, 28 Aug 2023 02:56:59 -0500
Date: Mon, 28 Aug 2023 13:26:58 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v2 3/6] k3-j721s2: Sync from Linux tag v6.5-rc1
Message-ID: <20230828075658.ybxofhzayi5dbagy@ula0497581>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v2-0-a5f141be40bc@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v2-3-a5f141be40bc@ti.com>
 <3b853275-ac4d-f279-4e10-4cba8846de90@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3b853275-ac4d-f279-4e10-4cba8846de90@ti.com>
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

Hi Neha,

On 13:04-20230828, Neha Malcom Francis wrote:
> Hi Manorit
> 
> On 25/08/23 16:47, Manorit Chawdhry wrote:
> > The following commit syncs the device tree from Linux tag
> > v6.5-rc1 to U-boot and fixes the following to be compatible with
> > the future syncs -
> > 
> 
> [...]
> 
> > diff --git a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> > index c74e8e58ae81..022618b37c74 100644
> > --- a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> > +++ b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> > @@ -1,20 +1,19 @@
> >   // SPDX-License-Identifier: GPL-2.0
> >   /*
> > - * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
> 
> [...]
> 
> > +&cbass_mcu_wakeup {
> >   	sysctrler: sysctrler {
> >   		compatible = "ti,am654-system-controller";
> > -		mboxes= <&mcu_secproxy 4>, <&mcu_secproxy 5>, <&sa3_secproxy 5>;
> > +		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>, <&secure_proxy_sa3 5>;
> >   		mbox-names = "tx", "rx", "boot_notify";
> >   		bootph-pre-ram;
> >   	};
> > @@ -92,101 +67,17 @@
> >   		ti,host-id = <3>;
> >   		ti,secure-host;
> >   		mbox-names = "rx", "tx";
> > -		mboxes= <&mcu_secproxy 21>,
> > -			<&mcu_secproxy 23>;
> > +		mboxes= <&secure_proxy_mcu 21>,
> > +			<&secure_proxy_mcu 23>;
> >   		bootph-pre-ram;
> >   	};
> >   };
> 
> Sorry I didn't catch this earlier before the review tag. But dm_tifs can be
> moved to the root node, see review comments in [1]

Thanks for catching this, will be sending a v3 with the change.

Regards,
Manorit

> 
> >   /* Now include peripherals from each bus segment */
> > 
> 
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20230822185725.6718-1-reidt@ti.com/
> 
> -- 
> Thanking You
> Neha Malcom Francis

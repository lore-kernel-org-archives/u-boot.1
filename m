Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4432FC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 17:19:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAF9287A40;
	Thu, 28 Dec 2023 18:19:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CwfBbiGG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29EB787A7B; Thu, 28 Dec 2023 18:19:00 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 492E4879DF
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 18:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BSHIoRb123952;
 Thu, 28 Dec 2023 11:18:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703783930;
 bh=vKVqEOXnuIAtaOSMaPxoJDB5l5zLLF8A5O5LH3J9TNo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=CwfBbiGGb9fc2vADm+xtzLZDL21M9BctXslihNabr8ls58n50J9owwAEL7fF1nRsM
 Ahc4yva8xNwiVt2t0hw4AJ3idIx2ZVj9Oji91kGd0k5tTrQVHIJi9n/sMYjMYwyF7u
 DHFKUMmxEIMLDhCktDyreHZS+OXAWDFHWV8Mns78=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BSHIolm126646
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 28 Dec 2023 11:18:50 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Dec 2023 11:18:49 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Dec 2023 11:18:49 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BSHInUU100157;
 Thu, 28 Dec 2023 11:18:49 -0600
Date: Thu, 28 Dec 2023 11:18:49 -0600
From: Bryan Brattlof <bb@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Tom Rini <trini@konsulko.com>, UBoot Mailing List <u-boot@lists.denx.de>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Martyn
 Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 12/26] arm: dts: k3-am654: add needed regs to udmap nodes
Message-ID: <20231228171849.5u6bkfxh7qils2rw@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231221174412.210807-1-bb@ti.com>
 <20231221174412.210807-13-bb@ti.com>
 <20231227122517.ph565albc5ktut4l@blast>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20231227122517.ph565albc5ktut4l@blast>
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

On December 27, 2023 thus sayeth Nishanth Menon:
> On 11:43-20231221, Bryan Brattlof wrote:
> > Ethernet is one of a few IPs in U-Boot that depend on DMA to operate.
> > However there are a few missing registers ranges in the udmap nodes
> > need to properly setup DMA for the am65x.
> > 
> > A fix has been added to the Linux kernel[0] to add these ranges however
> > they have not made it to a Linux tag. To keep DMA operational until the
> > next DT sync from Linux, add these ranges to the *-u-boot.dtsi with a
> > note for our future selves.
> > 
> > [0] https://lore.kernel.org/r/20231213135138.929517-2-vigneshr@ti.com
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> >  arch/arm/dts/k3-am654-base-board-u-boot.dtsi | 32 ++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
> > index 9cd8c353c515b..645241da322a5 100644
> > --- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
> > +++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
> > @@ -260,3 +260,35 @@
> >  &mcu_r5fss0 {
> >  	ti,cluster-mode = <0>;
> >  };
> > +
> > +/* The DMA driver requires a few extra register ranges
> > + * which are missing for the am65x. A patch has been
> > + * sent and will be synced after the v6.8-rc1 linux
> > + * tag is published
> > + */
> 
> Please fix multi-line comment style:
> /*
>  * blah blah
>  */
> instead of
> /* blah blah
>  * more stuff
>  */

Ah yeah I can get all of the comments fixed up.

~Bryan

> > +&main_udmap {
> > +	reg = <0x0 0x31150000 0x0 0x100>,
> > +	      <0x0 0x34000000 0x0 0x100000>,
> > +	      <0x0 0x35000000 0x0 0x100000>,
> > +	      <0x0 0x30b00000 0x0 0x10000>,
> > +	      <0x0 0x30c00000 0x0 0x10000>,
> > +	      <0x0 0x30d00000 0x0 0x8000>;
> > +	reg-names = "gcfg", "rchanrt", "tchanrt",
> > +		    "tchan", "rchan", "rflow";
> > +};
> > +
> > +/* The DMA driver requires a few extra register ranges
> > + * which are missing for the am65x. A patch has been
> > + * sent and will be synced after the v6.8-rc1 linux
> > + * tag is published
> > + */
> 
> and here.
> 
> > +&mcu_udmap {
> > +	reg = <0x0 0x285c0000 0x0 0x100>,
> > +	      <0x0 0x2a800000 0x0 0x40000>,
> > +	      <0x0 0x2aa00000 0x0 0x40000>,
> > +	      <0x0 0x284a0000 0x0 0x4000>,
> > +	      <0x0 0x284c0000 0x0 0x4000>,
> > +	      <0x0 0x28400000 0x0 0x2000>;
> > +	reg-names = "gcfg", "rchanrt", "tchanrt",
> > +		    "tchan", "rchan", "rflow";
> > +};
> > -- 
> > 2.43.0
> > 
> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15557C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 09:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BB54881B8;
	Fri, 21 Jun 2024 11:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Yd4pcbmu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB82D8840F; Fri, 21 Jun 2024 11:45:47 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E1D788385
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 11:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45L9jhrx129175;
 Fri, 21 Jun 2024 04:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718963143;
 bh=UBKRM6hFeogRi8yQ/52rAfjz3d7us7S5vUbrvaSlrIw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Yd4pcbmuVhrrAwRFhfktV74R9fOpM3cBIKoCfLIpYQ09vkAOTRdmNh/P4VD6UljU2
 vXGfi2gXtXdQVC8RxPrQWbLCm40XSnvmWIdYt7+uc5UbVUim5kKSRnmCcFrB5FMvod
 AV8Jt00lYID3A+8fOUdUmmI7Kp3R1Mlva1A1ubyQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45L9jheq002122
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 21 Jun 2024 04:45:43 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 04:45:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 04:45:42 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45L9jgp8120454;
 Fri, 21 Jun 2024 04:45:42 -0500
Date: Fri, 21 Jun 2024 04:45:42 -0500
From: Bryan Brattlof <bb@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, Nishant Menon <nm@ti.com>,
 <c-shilwant@ti.com>, <m-chawdhry@ti.com>, <vigneshr@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>
Subject: Re: [PATCH v2] arm: dts: k3-am625-beagleplay: Package TIFS Stub
Message-ID: <20240621094542.e4dqved53z53q7an@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240618045610.271884-1-d-gole@ti.com>
 <20240619214448.saaw6w2iueolb6vd@bryanbrattlof.com>
 <20240621050802.45nrhsbrtr7ciaqh@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240621050802.45nrhsbrtr7ciaqh@dhruva>
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

On June 21, 2024 thus sayeth Dhruva Gole:
> Bryan,
> 
> On Jun 19, 2024 at 16:44:48 -0500, Bryan Brattlof wrote:
> > On June 18, 2024 thus sayeth Dhruva Gole:
> > > Add support for packaging the TIFS Stub as it's required for basic Low
> > > Power Modes like Deep Sleep.
> > > 
> > > Acked-by: Neha Malcom Francis <n-francis@ti.com>
> > > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > > ---
> > > 
> > > No changes from v1, just picked Neha's ack and rebased on master again.
> > > Link to v1:
> > > https://lore.kernel.org/u-boot/20240612062351.3690091-1-d-gole@ti.com/
> > > 
> > >  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 33 +++++++++++++++++++-
> > >  1 file changed, 32 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> > > index fb2032068d1c..5e2248a4a668 100644
> > > --- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> > > +++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> > > @@ -69,6 +69,23 @@
> > >  		};
> > >  	};
> > >  
> > > +	tifsstub-gp {
> > > +		filename = "tifsstub.bin_gp";
> > > +		ti-secure-rom {
> > > +			content = <&tifsstub_gp>;
> > > +			core = "secure";
> > > +			load = <0x60000>;
> > > +			sw-rev = <CONFIG_K3_X509_SWRV>;
> > > +			keyfile = "ti-degenerate-key.pem";
> > > +			tifsstub;
> > > +		};
> > > +		tifsstub_gp: tifsstub-gp.bin {
> > > +			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-gp.bin";
> > > +			type = "blob-ext";
> > > +			optional;
> > > +		};
> > > +	};
> > > +
> > >  	ti-spl_unsigned {
> > >  		filename = "tispl.bin_unsigned";
> > >  		pad-byte = <0xff>;
> > > @@ -105,6 +122,19 @@
> > >  					};
> > >  				};
> > >  
> > > +				tifsstub-gp {
> > > +					description = "tifsstub";
> > > +					type = "firmware";
> > > +					arch = "arm32";
> > > +					compression = "none";
> > > +					os = "tifsstub-gp";
> > > +					load = <0x9dc00000>;
> > > +					entry = <0x9dc00000>;
> > 
> > Is this stub position independent? Or is this address compiled in at 
> > build time? We have some variants of 62x that don't have these addresses 
> > backed by DRAM.
> 
> The stub is not position independent and is indeed fixed at build time.
> Can you talk more about these am62x variants that don't have the address
> backed by DRAM? What would be the suggested address range in those
> cases?
> 

We've always had a 'soft' limit of 512MB so you're correct this isn't an 
issue today and I haven't seen any 'u-boot shall support' language 
internally however there have been a few questions about minimum DDR 
capacities we can support. Some have asked about 256MB.

(This 512MB 'soft' limit is most likely why this stub and OP-TEE is 
where it is today)

>
> For BeaglePlay atleast I don't see an issue. So I don't think we'd have
> issues with this patch in particular?
>

No you're correct however knowing that this address location is compiled 
into other firmware means we would need to have separate firmware builds 
if we wanted this stub in another location and it's awkwardly in the 
middle of DRAM and not at the bottom like I would prefer. 

So while yes this is a board/ level decision because it's also dealing 
with mach-k3/ level firmware this is an unfortunate thing we're 
hard-coding. This is essentially hard-coding a 512MB minimum limit for 
the entire AM62x SoC family.

My question was trying to determine if we should/could add this address 
to Kconfig so we can pass in the address to tispl.bin here and somehow 
get this into board-cfg.yaml. (This will be some work for us)

All of that to say, I'm okay with this change however I wish there was a 
'there be dragons' trailer I could add to this

~Bryan

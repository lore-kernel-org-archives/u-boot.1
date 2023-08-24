Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0904C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 00:28:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 420368638B;
	Thu, 24 Aug 2023 02:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ri8vtHXF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CD1E8650F; Thu, 24 Aug 2023 02:28:10 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E21FF85DEA
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 02:28:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37O0S5x9040111;
 Wed, 23 Aug 2023 19:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692836885;
 bh=DqeVKrWqf5mAPJozrXy8ZyYghCpwHqdeUuMdf4YhPS8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Ri8vtHXFpUuKJc4rOoyxttC+mDePC1y7oRpIWNmeD5dPmn5TvLtpv91XglVR+coLp
 dzN5aRIEZjRPeuNZWTE+QC8c/VU7jKrH5zaprUHKtQrW7KldMOUvXOcST8lLF6y+Kj
 up8MB1z3HaG24NAUsaV71qw/x+dutKE2zZhSeP4o=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37O0S5Bl031549
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Aug 2023 19:28:05 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 19:28:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 19:28:04 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37O0S4UH000962;
 Wed, 23 Aug 2023 19:28:04 -0500
Date: Wed, 23 Aug 2023 19:28:04 -0500
From: Nishanth Menon <nm@ti.com>
To: reidt <reidt@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>
Subject: Re: [PATCH] arm: dts: j7200: dtb sync with Linux 6.5-rc1
Message-ID: <20230824002804.okaev4ubqhqtzfsb@pantomime>
References: <20230822185725.6718-1-reidt@ti.com>
 <20230822213616.dntb3hcxxfesachm@napped>
 <20230823200144.asgp3cqmlgdt7fmc@reidt-HP-Z2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230823200144.asgp3cqmlgdt7fmc@reidt-HP-Z2>
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

On 15:01-20230823, reidt wrote:
[...]

> > &mcu_ringacc {
> > 	bootph-pre-ram;
> > };
> > NOTE: you only need to override reg-names and reg in R5.dtsi not u-boot.dtsi.
> > 
> > &mcu_udmap {
> > 	bootph-pre-ram;
> > };
> 
> I saw you mentioned at [0] that mcu_ringacc (and I assume mcu_udmap)
> need to be retained for now. If moved to r5.dts, something breaks, as dhcp 
> fails then [1]. Should the full nodes remain for now until 6.6-rc1 sync? I'll
> still take them outside of mcu_navss.
> 
> [0] https://lore.kernel.org/all/20230816114445.c4c7rgdp5arhmiaq@polyester/
> [1] https://gist.github.com/Glockn/f0cf1ae8f8fd92e70f4e798c6221e81a

True.. But, I understand the overrides are only for the R5 usage
when DM is'nt around to support us. So, yes override it in R5 dts - Now
why without a A72 override it breaks is beyond me and I'd suggest poking
Vignesh or someone more knowledgable about DMA/CPSW for help there.

[..]

> > >  &wkup_i2c0 {
> > >  	bootph-pre-ram;
> > > +
> > > +	lp876441: lp876441@4c {
> > 
> > NAK. Why is this new stuff coming in -> should'nt be here.
> > 
> 
> This was left because &wkup_vtm0 uses &buck1_reg below which isn't apart
> of the kernel dt files.

Please send it upstream kernel. What breaks if we keep that out of tree?

My vague recollection is avs0 is mandatory for j7200?

> 
> > 
> > hbmc -> arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi: flash@0,0 weird
> > that does'nt throw a dtbs_check warning
> > 
> > WARNING: u-boot,mux-autoprobe -> this is'nt supported.
> > 
> 
> change these to bootph-pre-ram?

No, I was just surprised to see a new u-boot property.. dont really know
what it does. I doubt switching it to bootph-pre-ram will work there.

[...]
> > > -&wkup_i2c0 {
> > > -	bootph-pre-ram;
> > > -	lp876441: lp876441@4c {
> > > -		compatible = "ti,lp876441";
> > 
> > There is no such driver in linux kernel compatible space. might need a
> > ticket to implement the driver.
> > 
> 
> Interesting - I'll look into it. Makes me wonder about the buck1_reg for
> wkup_vtm0 and what's going on there.

Alright - checkout AVS0 - maybe Keerthy or someone can help guide.

[..]
> > >  };
> > >  
> > >  &wkup_vtm0 {
> > > +	compatible = "ti,am654-vtm", "ti,j721e-avs";
> > 
> > &wkup_vtm0 -> there is already stuff coming in from kernel. why
> > do we need to define our own compatible "ti,am654-vtm", "ti,j721e-avs"?
> > there is already compatible = "ti,j7200-vtm";  if we need to fix the
> > driver as part of the series, please do as a path in the series.
> > 
> 
> ti,j7200-vtm doesn't work and throws a "AVS init failed: -19", so i'll
> work on that. The compatible I used was taken from our TI u-boot 

Sounds like a driver fixup needed in u-boot to match up with the
compatible that was accepted in upstream kernel. Also the classic
reason why we are now insisting that the device tree come in from
kernel pristine.


[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

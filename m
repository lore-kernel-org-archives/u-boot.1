Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4191DC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 05:43:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A74387FF7;
	Fri, 21 Jun 2024 07:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wwS9sNBr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CAEB88059; Fri, 21 Jun 2024 07:43:44 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9367787FBC
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 07:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45L5hdeg130139;
 Fri, 21 Jun 2024 00:43:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718948619;
 bh=0nWoTJdSaSrVB9xi34cE6QwlN5dMg6Ok3a9SrknS2+w=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=wwS9sNBrFZ6EZ32B/2nmlmt1+5cxZrFiaq2uIo8ZLOZpGAptYphR5rG6qWpwdYRSx
 kP+ku3K1NRk7Ku2uiu8ocZHOjs8vksmAgMIdjcerIhxCzOwkeCElI2zCKiPSipssxX
 1c6eNix/HPMYbRfyLSHTaZ040EecJkQfTcKm3pFc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45L5hdlX107903
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 21 Jun 2024 00:43:39 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 00:43:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 00:43:38 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45L5hcAd007979;
 Fri, 21 Jun 2024 00:43:38 -0500
Date: Fri, 21 Jun 2024 11:13:37 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, <c-shilwant@ti.com>,
 <m-chawdhry@ti.com>, <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v2] arm: dts: k3-am625-beagleplay: Package TIFS Stub
Message-ID: <20240621054337.qqjftv72ofiinlhv@dhruva>
References: <20240618045610.271884-1-d-gole@ti.com>
 <20240619184736.lnxyxdy44opk5in3@erased>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240619184736.lnxyxdy44opk5in3@erased>
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

Nishanth,

On Jun 19, 2024 at 13:47:36 -0500, Nishanth Menon wrote:
> On 10:26-20240618, Dhruva Gole wrote:
> > Add support for packaging the TIFS Stub as it's required for basic Low
> > Power Modes like Deep Sleep.
> 
> What the heck is tifs stub?
> https://docs.u-boot.org/en/latest/search.html?q=tifs&check_keywords=yes&area=default
> I see no mention of the same?

I agree, documentation is lacking, will be sure to add that.

> > 
> > Acked-by: Neha Malcom Francis <n-francis@ti.com>
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > ---
> > 
> > No changes from v1, just picked Neha's ack and rebased on master again.
> > Link to v1:
> > https://lore.kernel.org/u-boot/20240612062351.3690091-1-d-gole@ti.com/
> > 
> >  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 33 +++++++++++++++++++-
> >  1 file changed, 32 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> > index fb2032068d1c..5e2248a4a668 100644
> > --- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> > +++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> > @@ -69,6 +69,23 @@
> >  		};
> >  	};
> >  
> > +	tifsstub-gp {
> > +		filename = "tifsstub.bin_gp";
> > +		ti-secure-rom {
> > +			content = <&tifsstub_gp>;
> > +			core = "secure";
> > +			load = <0x60000>;
> > +			sw-rev = <CONFIG_K3_X509_SWRV>;
> > +			keyfile = "ti-degenerate-key.pem";
> > +			tifsstub;
> > +		};
> > +		tifsstub_gp: tifsstub-gp.bin {
> > +			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-gp.bin";
> > +			type = "blob-ext";
> > +			optional;
> > +		};
> > +	};
> > +
> >  	ti-spl_unsigned {
> >  		filename = "tispl.bin_unsigned";
> >  		pad-byte = <0xff>;
> > @@ -105,6 +122,19 @@
> >  					};
> >  				};
> >  
> > +				tifsstub-gp {
> > +					description = "tifsstub";
> > +					type = "firmware";
> > +					arch = "arm32";
> > +					compression = "none";
> > +					os = "tifsstub-gp";
> > +					load = <0x9dc00000>;
> > +					entry = <0x9dc00000>;
> 
> two issues with this:
> a) if the tifsstub-gp is not automatically consumed by tifs by the time
> u-boot is up or kernel is up, this is going to get clobbered by OS
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts#n78
> Should be updated before this is done.

This won't be much of a concern, the TIFS Stub is loaded into the R5 ATCM as
soon as the DM R5 core comes up [0] : See the Deep Sleep Exit part, it
talks about this stub.

[0] https://software-dl.ti.com/processor-sdk-linux/esd/AM62AX/09_01_00/exports/docs/linux/Foundational_Components/Kernel/Kernel_Drivers/Power_Management/pm_sw_arch.html

> b) Documentation update - please always make sure you update
>   documentation when doing this kind of change
> https://docs.u-boot.org/en/latest/board/beagle/am62x_beagleplay.html#image-formats

Will do.

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

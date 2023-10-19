Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D609CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 17:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7758587447;
	Thu, 19 Oct 2023 19:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uDU6d10y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 678448749F; Thu, 19 Oct 2023 19:30:40 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2E47871BE
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 19:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39JHUWMN113499;
 Thu, 19 Oct 2023 12:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697736632;
 bh=tHpKZThmbXHp4rM7w4JTsCIxg7DWT4Cx6peSWw7BTZQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=uDU6d10yhUssNLkF36BF0fh9y62ieNe2K7VybVoS6uGNEq08Srf47InfWEDD8mRJZ
 0FCx0YgM3hHIk5MhGdiqXREkz0rXvSqGBylGVsvl1/KZuoJb2OoJaxnk/E7FnESIoz
 ylqKcPnP5us/ugS3Q0gepMpIrxcT4h4fxUMaIOAM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39JHUWPA000774
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 19 Oct 2023 12:30:32 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Oct 2023 12:30:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Oct 2023 12:30:32 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39JHUWRH018277;
 Thu, 19 Oct 2023 12:30:32 -0500
Date: Thu, 19 Oct 2023 12:30:32 -0500
From: Nishanth Menon <nm@ti.com>
To: Thomas Richard <thomas.richard@bootlin.com>, <praneeth@ti.com>, "Kumar,
 Udit" <u-kumar1@ti.com>
CC: <u-boot@lists.denx.de>, <thomas.petazzoni@bootlin.com>,
 <gregory.clement@bootlin.com>, <u-kumar1@ti.com>, Gowtham Tammana
 <g-tammana@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/9] DO NOT MERGE: arm: dts: k3-j7200-r5-common: Add pmic
 node for esm
Message-ID: <20231019173032.lta44hodykc3fwwo@enquirer>
References: <20231016141135.325698-1-thomas.richard@bootlin.com>
 <20231016141135.325698-2-thomas.richard@bootlin.com>
 <20231016162915.53tpyquivwltekdr@anagram>
 <311c04dc-8bd5-4300-b496-6dc41403481e@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <311c04dc-8bd5-4300-b496-6dc41403481e@bootlin.com>
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

On 14:42-20231019, Thomas Richard wrote:
> On 10/16/23 18:29, Nishanth Menon wrote:
> > On 16:11-20231016, Thomas Richard wrote:
> >> From: Gowtham Tammana <g-tammana@ti.com>
> >>
> >> Add pmic tps659413 node needed for ESM error event handling.
> >>
> >> Signed-off-by: Gowtham Tammana <g-tammana@ti.com>
> >> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> >> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> >> ---
> >>
> >>  arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 17 ++++++++++++++---
> >>  1 file changed, 14 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> >> index e62f9218e8..2bf0d5e3c0 100644
> >> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> >> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> >> @@ -249,13 +249,24 @@
> >>  
> >>  &wkup_i2c0 {
> >>  	bootph-pre-ram;
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&wkup_i2c0_pins_default>;
> >> +	clock-frequency = <400000>;
> >> +
> >> +	tps659413: tps659413@48 {
> >> +		compatible = "ti,tps659413";
> >> +		reg = <0x48>;
> >> +		bootph-pre-ram;
> >> +
> >> +		regulators_a: regulators {
> >> +			bootph-pre-ram;
> >> +		};
> >> +	};
> >> +
> >>  	lp876441: lp876441@4c {
> >>  		compatible = "ti,lp876441";
> >>  		reg = <0x4c>;
> >>  		bootph-pre-ram;
> >> -		pinctrl-names = "default";
> >> -		pinctrl-0 = <&wkup_i2c0_pins_default>;
> >> -		clock-frequency = <400000>;
> >>  
> >>  		regulators: regulators {
> >>  			bootph-pre-ram;
> >> -- 
> >> 2.39.2
> >>
> > 
> > Please send these changes upstream linux kernel.
> 
> Hi Nishanth,
> 
> I found this series
> (https://lore.kernel.org/all/20230810-tps6594-v6-0-2b2e2399e2ef@ti.com/)
> which includes a patch to create the two pmic nodes for j7200 target.
> It matches exactly my needs.
> 
> I found it was merged in TI linux kernel
> https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi?h=ti-linux-6.1.y&id=0b3a445305b24aafba567909dac75961a0e8908c)

I will skip commenting on TI vendor kernel and bootloader stuff.
> 
> 
> But referring to your answer
> (https://lore.kernel.org/all/169164472311.19570.17843597381384613605.b4-ty@ti.com/)
> this series will not be merged upstream as is.
> 
> Should I send a single patch to declare pmics only for J7200 ?
> Could I just send a minimal definition of the pmics, or should I send a
> full definition (including regulators) ?
> 

It will be good to discuss kernel patches in kernel.org mailing lists :)

But yeah - that series was pretty much close to getting merged before
I had to drop when testing I do failed. If we are doing it, we'd need
to do as a full definition (including regulators).. Though, I am
disappointed at TI dropping the ball on this (Udit/Praneeth: hint -
this is blocking additional progress).

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

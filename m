Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3030C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 06:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1057B88165;
	Thu,  9 May 2024 08:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TwcC8Y6a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50F478815B; Thu,  9 May 2024 08:27:14 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7CCE8815B
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 08:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4496R9Rb031635;
 Thu, 9 May 2024 01:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715236029;
 bh=VYaMdiAbJR+oXPJganYJYJYMCoHwesIKiX1EBs1DplQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=TwcC8Y6aYziQLQwYwBG0QlaI075C0j8GFXfLixCtW2HR0oRPtGftydx05wGNXDGYL
 XNHYDw/fg/1nUa0RP1Vfn5M6C1ZTbHxPsGaiJqYqv2F/zRHMXWti0e5ho0qfJaBRQj
 fx1cGK2yojrm53bPeunHaGSlZPElYZRS/S4a7y0c=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4496R9gg018378
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 May 2024 01:27:09 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 May 2024 01:27:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 May 2024 01:27:09 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4496R8e4053319;
 Thu, 9 May 2024 01:27:08 -0500
Date: Thu, 9 May 2024 11:57:07 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>, <u-boot@lists.denx.de>, Nishanth Menon
 <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>
Subject: Re: [PATCH 4/6] arch: arm: dts: k3-am68-sk-r5: Sync with J721s2 R5
 file
Message-ID: <20240509062707.cgoniskfs5bm2lyp@uda0497581>
References: <20240508-b4-upstream-j721s2-of-upstream-v1-0-ed0933172410@ti.com>
 <20240508-b4-upstream-j721s2-of-upstream-v1-4-ed0933172410@ti.com>
 <82dd9ec5-99c0-4e09-8ce9-e35c6dd98c36@ti.com>
 <20240509050745.h6tsoyofe6jptcf7@uda0497581>
 <20240509053429.hy7hjwbiqk7xra35@uda0497581>
 <4750f270-eddc-4597-bead-fc26fb390089@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4750f270-eddc-4597-bead-fc26fb390089@ti.com>
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

On 11:29-20240509, Neha Malcom Francis wrote:
> Hi Manorit
> 
> On 09/05/24 11:04, Manorit Chawdhry wrote:
> > Hi Neha,
> > 
> > On 10:37-20240509, Manorit Chawdhry wrote:
> > > Hi Neha,
> > > 
> > > On 16:09-20240508, Neha Malcom Francis wrote:
> > > > Hi Manorit,
> > > > 
> > > > On 08/05/24 12:56, Manorit Chawdhry wrote:
> > > > > Update the file with the required nodes from J721s2 R5 file to start
> > > > > using k3-am68-sk-r5 file for AM68.
> > > > > 
> > > > > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > > > > ---
> > > > 
> > > > What's the motivation behind this patch vs. squashing it into patch 5/6?
> > > > 
> > > 
> > > Could've squashed it ig, I think developed it in this order so this
> > > remained. Would squash it. Also realised that I should be putting that
> > > patch before the config split otherwise am68 boot would break again.
> > > Would take that up as well in v2. Thanks for the review!
> > > 
> > 
> > Though on second thoughts.. I think it's good as it tells that AM68 R5
> > DT had been missing some changes. If someone wants to track what changed
> > then ig it's better that they don't have to debug the merge commit which
> > ends up altering the contents of AM68 R5 DT ( in-case this patch ain't
> > there ) and people will have to manually check the diff as to what
> > altered. Do you think it's better to keep this patch with the following
> > reasoning?
> > 
> 
> Yes you can do that but I think this commit message is confusing. The "start
> using k3-am68-sk-r5 file for AM68" threw me off, maybe modify it to say that
> AM68 R5 DT is missing these changes and needs them why? After that grabbing
> the common bits into an SoC R5 file in patch 5/6 makes sense.
> 

Ah okay, I think I can explain better "start using k3-am68-sk-r5 file"
in the commit message itself along with telling the reasoning as to why
it wasn't failing previously as well along with your suggestions.
Thanks!

Regards,
Manorit

> 
> > Regards,
> > Manorit
> > 
> > > Regards,
> > > Manorit
> > > 
> > > > >    arch/arm/dts/k3-am68-sk-r5-base-board.dts | 5 ++++-
> > > > >    1 file changed, 4 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/arch/arm/dts/k3-am68-sk-r5-base-board.dts b/arch/arm/dts/k3-am68-sk-r5-base-board.dts
> > > > > index 695aadc287bd..038b08dc3e01 100644
> > > > > --- a/arch/arm/dts/k3-am68-sk-r5-base-board.dts
> > > > > +++ b/arch/arm/dts/k3-am68-sk-r5-base-board.dts
> > > > > @@ -24,7 +24,8 @@
> > > > >    		compatible = "ti,am654-rproc";
> > > > >    		reg = <0x0 0x00a90000 0x0 0x10>;
> > > > >    		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> > > > > -				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
> > > > > +				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
> > > > > +				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
> > > > >    		resets = <&k3_reset 202 0>;
> > > > >    		clocks = <&k3_clks 61 1>;
> > > > >    		assigned-clocks = <&k3_clks 61 1>, <&k3_clks 202 0>;
> > > > > @@ -54,10 +55,12 @@
> > > > >    &secure_proxy_mcu {
> > > > >    	bootph-pre-ram;
> > > > > +	status = "okay";
> > > > >    };
> > > > >    &secure_proxy_sa3 {
> > > > >    	bootph-pre-ram;
> > > > > +	status = "okay";
> > > > >    };
> > > > >    &cbass_mcu_wakeup {
> > > > > 
> > > > 
> > > > -- 
> > > > Thanking You
> > > > Neha Malcom Francis
> 
> -- 
> Thanking You
> Neha Malcom Francis

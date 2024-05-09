Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1ECC25B74
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 05:34:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AD568846C;
	Thu,  9 May 2024 07:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fWPAdBsm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4469B8847B; Thu,  9 May 2024 07:34:37 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E30E882A9
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 07:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4495YVhT089859;
 Thu, 9 May 2024 00:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715232871;
 bh=bftispK1VEmeqfinUBokeebrG2Sq0qOgYaXTBJt5uVw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=fWPAdBsmOpEYtJUogB/clgXM0aeUFbVUtseI6tAfiI+AEZDzr1YxMYXCg9PFfERSO
 j0H84mDZu/1wX10DsRZadcdafufYpSjQ9TZ4wP3JVA5+KJWGJi9enTB/lfRmRKJJCl
 RHbjUVcYOh7kVhYGk7H91Ssz9oQ6oT6t9futqS1U=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4495YVOg070239
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 May 2024 00:34:31 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 May 2024 00:34:30 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 May 2024 00:34:30 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4495YTi0104739;
 Thu, 9 May 2024 00:34:30 -0500
Date: Thu, 9 May 2024 11:04:29 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>, <u-boot@lists.denx.de>, Nishanth Menon
 <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>
Subject: Re: [PATCH 4/6] arch: arm: dts: k3-am68-sk-r5: Sync with J721s2 R5
 file
Message-ID: <20240509053429.hy7hjwbiqk7xra35@uda0497581>
References: <20240508-b4-upstream-j721s2-of-upstream-v1-0-ed0933172410@ti.com>
 <20240508-b4-upstream-j721s2-of-upstream-v1-4-ed0933172410@ti.com>
 <82dd9ec5-99c0-4e09-8ce9-e35c6dd98c36@ti.com>
 <20240509050745.h6tsoyofe6jptcf7@uda0497581>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240509050745.h6tsoyofe6jptcf7@uda0497581>
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

On 10:37-20240509, Manorit Chawdhry wrote:
> Hi Neha,
> 
> On 16:09-20240508, Neha Malcom Francis wrote:
> > Hi Manorit,
> > 
> > On 08/05/24 12:56, Manorit Chawdhry wrote:
> > > Update the file with the required nodes from J721s2 R5 file to start
> > > using k3-am68-sk-r5 file for AM68.
> > > 
> > > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > > ---
> > 
> > What's the motivation behind this patch vs. squashing it into patch 5/6?
> > 
> 
> Could've squashed it ig, I think developed it in this order so this
> remained. Would squash it. Also realised that I should be putting that
> patch before the config split otherwise am68 boot would break again.
> Would take that up as well in v2. Thanks for the review!
> 

Though on second thoughts.. I think it's good as it tells that AM68 R5
DT had been missing some changes. If someone wants to track what changed
then ig it's better that they don't have to debug the merge commit which
ends up altering the contents of AM68 R5 DT ( in-case this patch ain't
there ) and people will have to manually check the diff as to what
altered. Do you think it's better to keep this patch with the following
reasoning?

Regards,
Manorit

> Regards,
> Manorit
> 
> > >   arch/arm/dts/k3-am68-sk-r5-base-board.dts | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/dts/k3-am68-sk-r5-base-board.dts b/arch/arm/dts/k3-am68-sk-r5-base-board.dts
> > > index 695aadc287bd..038b08dc3e01 100644
> > > --- a/arch/arm/dts/k3-am68-sk-r5-base-board.dts
> > > +++ b/arch/arm/dts/k3-am68-sk-r5-base-board.dts
> > > @@ -24,7 +24,8 @@
> > >   		compatible = "ti,am654-rproc";
> > >   		reg = <0x0 0x00a90000 0x0 0x10>;
> > >   		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> > > -				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
> > > +				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
> > > +				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
> > >   		resets = <&k3_reset 202 0>;
> > >   		clocks = <&k3_clks 61 1>;
> > >   		assigned-clocks = <&k3_clks 61 1>, <&k3_clks 202 0>;
> > > @@ -54,10 +55,12 @@
> > >   &secure_proxy_mcu {
> > >   	bootph-pre-ram;
> > > +	status = "okay";
> > >   };
> > >   &secure_proxy_sa3 {
> > >   	bootph-pre-ram;
> > > +	status = "okay";
> > >   };
> > >   &cbass_mcu_wakeup {
> > > 
> > 
> > -- 
> > Thanking You
> > Neha Malcom Francis

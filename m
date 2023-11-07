Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AFAC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 05:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10DE586940;
	Tue,  7 Nov 2023 06:36:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jxKeYvOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8893C8695F; Tue,  7 Nov 2023 06:36:05 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AE1A86844
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 06:36:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A75ZsWU117711;
 Mon, 6 Nov 2023 23:35:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699335354;
 bh=VrNKgFixswWV8nfd6b2Vm63BMK4nxuBpehNgeX2As0s=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=jxKeYvOD0o6TY2VZXxlZOkSkaAgrFUAGJ6Ax/zOqGw3ujnpEiMljMdPW8Lh4ggapl
 /4paAg4uxVd2G+aTI95k6bhe4e+8ALCO/c8cIWtNnWOm4unb0eIwXPSIqqh0FTVvGM
 MBzn87443IeyvBXMuyOxSbrtc+G3zjcVxeQ5kDlo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A75Zsao001114
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Nov 2023 23:35:54 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Nov 2023 23:35:54 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Nov 2023 23:35:54 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A75ZrVu007519;
 Mon, 6 Nov 2023 23:35:53 -0600
Date: Tue, 7 Nov 2023 11:05:53 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Nishanth Menon <nm@ti.com>, <trini@konsulko.com>, Neha Malcom Francis
 <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Francesco Dolcini <francesco@dolcini.it>, <u-boot@lists.denx.de>
Subject: Re: [PATCH V2 2/2] arm: mach-k3: Move TI dummy keys out of board
 folder
Message-ID: <20231107053553.lu3pjckm5qvyimh3@ula0497581>
References: <20231104024511.3597476-1-nm@ti.com>
 <20231104024511.3597476-3-nm@ti.com>
 <0abbcaaf-412d-4d73-9d6f-834e472e1867@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0abbcaaf-412d-4d73-9d6f-834e472e1867@ti.com>
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

On 11:11-20231106, Andrew Davis wrote:
> On 11/3/23 9:45 PM, Nishanth Menon wrote:
> > This file is used to emulate customer keys on TI development board
> > ecosystems, move it out of board/ directory and into mach-k3. And
> > change the relative paths to absolute paths in the binman paths.
> > 
> > While at it, drop the reference in verdin-binman file which is
> > redundant.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> 
> Moving custMpk.pem looks good. But I don't know how .crt and .key
> are actually used right now, I'd guess they already get pulled in
> during FIT signing using relative paths so this might be okay.
> 
> Good to get an ACK from +Manorit to be sure though.
> 

I think the current yocto builds are not using the keys so should be
okay. I wasn't able to get the u-boot keys and ended up using the keys
in core-secdev. Might be a future action to actually use these keys,
they currently just help in Upstream and people don't have to go to
core-secdev for getting these.

Acked-by: Manorit Chawdhry <m-chawdhry@ti.com>

Regards,
Manorit

> Andrew
> 
> > New patch in series.
> > 
> >   arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi | 4 ----
> >   arch/arm/dts/k3-binman.dtsi                       | 2 +-
> >   {board/ti => arch/arm/mach-k3}/keys/custMpk.crt   | 0
> >   {board/ti => arch/arm/mach-k3}/keys/custMpk.key   | 0
> >   {board/ti => arch/arm/mach-k3}/keys/custMpk.pem   | 0
> >   5 files changed, 1 insertion(+), 5 deletions(-)
> >   rename {board/ti => arch/arm/mach-k3}/keys/custMpk.crt (100%)
> >   rename {board/ti => arch/arm/mach-k3}/keys/custMpk.key (100%)
> >   rename {board/ti => arch/arm/mach-k3}/keys/custMpk.pem (100%)
> > 
> > diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> > index ea22bfb9bad6..58fde95adf67 100644
> > --- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> > +++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> > @@ -5,10 +5,6 @@
> >   #include "k3-binman.dtsi"
> > -&custmpk_pem {
> > -	filename = "../../ti/keys/custMpk.pem";
> > -};
> > -
> >   #ifdef CONFIG_TARGET_VERDIN_AM62_R5
> >   &binman {
> > diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> > index b941726e6246..8d4b0b2454f6 100644
> > --- a/arch/arm/dts/k3-binman.dtsi
> > +++ b/arch/arm/dts/k3-binman.dtsi
> > @@ -13,7 +13,7 @@
> >   	custMpk {
> >   		filename = "custMpk.pem";
> >   		custmpk_pem: blob-ext {
> > -			filename = "../keys/custMpk.pem";
> > +			filename = "arch/arm/mach-k3/keys/custMpk.pem";
> >   		};
> >   	};
> > diff --git a/board/ti/keys/custMpk.crt b/arch/arm/mach-k3/keys/custMpk.crt
> > similarity index 100%
> > rename from board/ti/keys/custMpk.crt
> > rename to arch/arm/mach-k3/keys/custMpk.crt
> > diff --git a/board/ti/keys/custMpk.key b/arch/arm/mach-k3/keys/custMpk.key
> > similarity index 100%
> > rename from board/ti/keys/custMpk.key
> > rename to arch/arm/mach-k3/keys/custMpk.key
> > diff --git a/board/ti/keys/custMpk.pem b/arch/arm/mach-k3/keys/custMpk.pem
> > similarity index 100%
> > rename from board/ti/keys/custMpk.pem
> > rename to arch/arm/mach-k3/keys/custMpk.pem

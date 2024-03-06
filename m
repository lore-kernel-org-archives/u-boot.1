Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98735C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 20:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E42D58785E;
	Wed,  6 Mar 2024 21:56:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="e/JWtp+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB2AF877FB; Wed,  6 Mar 2024 21:56:33 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9982387C92
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 21:56:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 426KuSJU079622;
 Wed, 6 Mar 2024 14:56:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709758588;
 bh=UqFbMascdVuvipkc3oSIMi/bk89+DC4vfqdiyO0WKMI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=e/JWtp+PQuksndcGXkpQ1uFNFHqN7mUA61OgKKVh6dOpIjgxL4IgdJ3cAQJwqXn1v
 1bRE6wt9NuTWiC/Bq0Z/Xhoun0BUNuhusw7sBbL22TggHEK0CE3tG3lwPKPj48C0Yr
 84Uti4uwZV6nm//vYCjKbDHFCyhin9vNCfhCtUtY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 426KuSRG015559
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Mar 2024 14:56:28 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Mar 2024 14:56:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Mar 2024 14:56:28 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 426KuSkF060991;
 Wed, 6 Mar 2024 14:56:28 -0600
Date: Wed, 6 Mar 2024 14:56:28 -0600
From: Nishanth Menon <nm@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Aniket Limaye <a-limaye@ti.com>, <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>, <vaishnav.a@ti.com>,
 <a-nandan@ti.com>
Subject: Re: [PATCH 2/4] arm: dts: k3-j7200: Fix support for OSPI flash
Message-ID: <20240306205628.4ur422ntozd7bgr6@footbath>
References: <20240306063749.1411176-1-a-limaye@ti.com>
 <20240306063749.1411176-3-a-limaye@ti.com>
 <6777d0be-7610-4d54-bd32-1b41ebe94035@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6777d0be-7610-4d54-bd32-1b41ebe94035@ti.com>
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

On 18:47-20240306, Kumar, Udit wrote:
> 
> On 3/6/2024 12:07 PM, Aniket Limaye wrote:
> > - Add the missing bootph-all property in the flash subnode for ospi
> > - Add the missing overrides for the ospi node in the r5 devicetree
> 
> Please see , if you can add more on this why we are adding this
> 
> also, if this patch fixes some previous commit
> 
> > 
> > Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> > ---
> >   arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi | 4 ++++
> >   arch/arm/dts/k3-j7200-r5-common-proc-board.dts      | 5 +++++
> >   2 files changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
> > index 60ca6d21ab..c9fee0ea99 100644
> > --- a/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
> > +++ b/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
> > @@ -195,6 +195,10 @@
> >   &ospi0 {
> >   	bootph-all;

You should only use bootph-all property in leaf nodes - at least for
	kernel world.

> > +
> > +	flash@0 {
> > +		bootph-all;
> > +	};
> >   };
> 
> 
> Ideally this should come from kernel DT sync or with OF_UPSTREAM, whatever
> is applicable
> 
> As you are fixing broken OSPI boot.
> 
> Tom can suggest, if he is ok to pull in this fix for 2024.04 or we need to
> wait to get this change into kernel first.


Send this change for upstream kernel right away please.
> 
> 
> >   &serdes_ln_ctrl {
> > diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > index 018faaa13b..195637a836 100644
> > --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > @@ -83,3 +83,8 @@
> >   &wkup_vtm0 {
> >   	bootph-pre-ram;
> >   };
> > +
> > +&ospi0 {
> > +    reg = <0x0 0x47040000 0x0 0x100>,
> > +          <0x0 0x50000000 0x0 0x8000000>;
> > +};
> 
> With change in commit message,
> 
> Reviewed-by: Udit Kumar <u-kumar1@ti.com>
> 
> 
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

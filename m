Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80BAEB8FA5
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 05:19:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0490186963;
	Wed,  6 Sep 2023 07:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MoT4HT2b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C9B7866E1; Wed,  6 Sep 2023 07:18:49 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06B8186996
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 07:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3865IhVp021579;
 Wed, 6 Sep 2023 00:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693977523;
 bh=uie7RlsvmWr4FMSMWX52M3eIKopQqXJCfoGdQMVrBcA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=MoT4HT2bYYkwAtoniEo48PUpectfATxxoGPcUERw5BdgpUA+lavrjxtJ2842xkFep
 YXj23M8cclWgnQ3RrhHiNi2e6FuXXCHKcCC6msAA1kbNB6UAEzBSOegRbtnJz7r1MA
 od1s8r808zRj0kYCK4D2Ev+zzCwpNwFJ1Y0BMzq4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3865Ihec022343
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Sep 2023 00:18:43 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Sep 2023 00:18:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Sep 2023 00:18:42 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3865IfhY101288;
 Wed, 6 Sep 2023 00:18:41 -0500
Date: Wed, 6 Sep 2023 10:48:40 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, <u-boot@lists.denx.de>, Udit Kumar
 <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 2/2] binman: j721e: Add firewall configurations for atf
Message-ID: <20230906051840.3747bkybpqd2m4gg@ula0497581>
References: <20230905-binman-firewalling-v1-0-3894520bff8a@ti.com>
 <20230905-binman-firewalling-v1-2-3894520bff8a@ti.com>
 <72516776-1b6f-cd79-2e00-a28b920f722f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <72516776-1b6f-cd79-2e00-a28b920f722f@ti.com>
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

Hi Andrew,

On 10:22-20230905, Andrew Davis wrote:
> On 9/5/23 3:21 AM, Manorit Chawdhry wrote:
> > The following commits adds the configuration of firewalls required to
> > protect ATF and OP-TEE memory region from non-secure reads and
> > writes using master and slave firewalls present in our K3 SOCs.
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >   arch/arm/dts/k3-j721e-binman.dtsi | 161 ++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 161 insertions(+)
> > 
> > diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
> > index 4f566c21a9af..0569a592597e 100644
> > --- a/arch/arm/dts/k3-j721e-binman.dtsi
> > +++ b/arch/arm/dts/k3-j721e-binman.dtsi
> > @@ -330,6 +330,73 @@
> >   					ti-secure {
> >   						content = <&atf>;
> >   						keyfile = "custMpk.pem";
> > +						auth_in_place = <0xa02>;
> > +
> > +						// cpu_0_cpu_0_msmc Background Firewall - 0
> 
> I don't have a personal preference, but I see most comments in DTS
> are C style /* */.
> 
> Also it might be easier to understand if you put the comments right before
> the properties that they relate to, i.g.
> 
> firewall-0 {
> 	/* cpu_0_cpu_0_msmc */
> 	id = <257>;
> 	region = <0>;
> 	/* Background, Locked */
> 	control = <0x31a>;
> 	permissions = <0xc3ffff>;
> 	start_address = <0x0 0x0>;
> 	end_address = <0xff 0xffffffff>;
> };
> 
> For permissions, I wonder if it would be easier to read if we add
> some helper macros:
> 
> #define FWPRIVID_ALL 0xc3
> 
> #define FWPERM_SECURE_PRIV_WRITE      BIT(0)
> #define FWPERM_SECURE_PRIV_READ       BIT(1)
> #define FWPERM_SECURE_PRIV_CACHEABLE  BIT(2)
> #define FWPERM_SECURE_PRIV_DEBUG      BIT(3)
> #define FWPERM_SECURE_USER_WRITE      BIT(4)
> ...
> 
> Then you would have:
> 
> permissions = <FWPRIVID_ALL |

I think we'll have to do some shift here for the right calculations.

  #define FWPRIVID_SHIFT 8

  permissions = <(FWPRIVID_ALL << FWPRIVID_SHIFT)
>                FWPERM_SECURE_PRIV_WRITE |
>                FWPERM_SECURE_PRIV_READ |

Also, I would like to make FWPERM_SECURE_PRIV_RWCD too as it'll be
commonly used.

Would be sending another RFC with this change if you are fine with the
suggestions. Thank you for reviewing!

Regards,
Manorit

>                ...


> > ;
> 
> > +						firewall-0 {
> > +							id = <257>;
> > +							region = <0>;
> > +							control = <0x31a>;
> > +							permissions = <0xc3ffff>;
> > +							start_address = <0x0 0x0>;
> > +							end_address = <0xff 0xffffffff>;
> > +						};
> > +
> > +						// cpu_0_cpu_0_msmc Foreground Firewall
> > +						firewall-1 {
> > +							id = <257>;
> > +							region = <1>;
> > +							control = <0x1a>;
> > +							permissions = <0x0100ff>;
> > +							start_address = <0x0 0x70000000>;
> 
> This address might change if one moves ATF, might work to use CONFIG_K3_ATF_LOAD_ADDR?
> Not sure how you would get the end address as we don't really know ATF size..
> 
> Andrew

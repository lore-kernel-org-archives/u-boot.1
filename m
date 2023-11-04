Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2111CC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 02:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65CE987136;
	Sat,  4 Nov 2023 03:47:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Fwc5kjnA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6384E86FE8; Sat,  4 Nov 2023 03:46:43 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42CD1870A5
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 03:46:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A42kA1j116039;
 Fri, 3 Nov 2023 21:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699065970;
 bh=WQs1aaGRFw8jjdPbBCNbzG1si+3IJMB1/bvXfihSB/w=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Fwc5kjnA07hwj9dNRIJ3kl7IH1sdeq3EfpvSbHsntQYW6sDp1qDzaXLCFSKNFsOxv
 QsljX4RlNC8ZdknsTXvsbTHjw6pw3LGnYRho4Xzx/phvR2aRXbIhW6riIKXBSnnxPJ
 3A8TjES9tQ2KLloJISk0FKYanB6e4y0mwL2qD0Cw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A42kAOb108250
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 3 Nov 2023 21:46:10 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 Nov 2023 21:46:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 Nov 2023 21:46:10 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A42kAcn010830;
 Fri, 3 Nov 2023 21:46:10 -0500
Date: Fri, 3 Nov 2023 21:46:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH] arm: mach-k3: Move K3 degenerate keys out of board folder
Message-ID: <20231104024610.udwgum4ujntue3j3@statue>
References: <20231103224453.3264313-1-nm@ti.com>
 <688df26b-b7be-4fd7-9d49-2627bf75a302@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <688df26b-b7be-4fd7-9d49-2627bf75a302@ti.com>
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

On 18:31-20231103, Andrew Davis wrote:
[...]
> > diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> > index b489d8afbe36..a6d7c2df20e0 100644
> > --- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> > +++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> > @@ -10,7 +10,7 @@
> >   };
> >   &dkey_pem {
> > -	filename = "../../ti/keys/ti-degenerate-key.pem";
> > +	filename = "arch/arm/mach-k3/ti-degenerate-key.pem";
> >   };
> 
> You shouldn't need to modify dkey_pem here anymore if the path is now
> absolute, you can just drop this whole override node.
> 
> While here you might as well move the TI dummy key (custMpk.pem) over
> the same way.

True.. done in V2.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

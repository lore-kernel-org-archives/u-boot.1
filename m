Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2ACCD54AF
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 11:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A537E86AE1;
	Tue, 19 Sep 2023 13:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qYBGL+ez";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38B2C86B34; Tue, 19 Sep 2023 13:19:11 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC53D86ADA
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 13:19:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38JBJ2cl005691;
 Tue, 19 Sep 2023 06:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695122342;
 bh=QMFlYlbkuXUqJqMflA1D4PlbyV52BveKCNLHy+4rB9c=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=qYBGL+ez6dCiDAx2KPHijHTbD3koT0FDInNfoviSS+i2mrfe+48mGosxOMWyhJsio
 UL9+HO3sjlpW33A3eEX7/8pX4vKcluixshQKztnqE6PLpEP2Yv0tmBfrOxT6rxrifD
 dZ3kOWM2D99l3gC9ZrzLkb/X+j+0vsvXm0vo+YFQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38JBJ2I0026492
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Sep 2023 06:19:02 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 06:19:02 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 06:19:02 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38JBJ2RH059587;
 Tue, 19 Sep 2023 06:19:02 -0500
Date: Tue, 19 Sep 2023 06:19:02 -0500
From: Nishanth Menon <nm@ti.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "sjoerd@collabora.com"
 <sjoerd@collabora.com>, "a-govindraju@ti.com" <a-govindraju@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "g-vlaev@ti.com" <g-vlaev@ti.com>, "d-gole@ti.com" <d-gole@ti.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>, "sjg@chromium.org" <sjg@chromium.org>
Subject: Re: [PATCH v2 4/8] arm: dts: k3-am625-sk: Enable emmc in SPL
Message-ID: <20230919111902.5xuvptr4iqmgsmkr@quotable>
References: <20230406185542.1179073-1-sjoerd@collabora.com>
 <20230406185542.1179073-5-sjoerd@collabora.com>
 <4b593377588ba713229c6671edf0c0848a857bf4.camel@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b593377588ba713229c6671edf0c0848a857bf4.camel@siemens.com>
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

On 07:35-20230919, Sverdlin, Alexander wrote:
> Hello Sjoerd,
> 
> On Thu, 2023-04-06 at 20:55 +0200, Sjoerd Simons wrote:
> > sdhci0 on the k3-am625-sk is the emmc, enable this in SPL as well to
> > allow booting from that media.
> > 
> > Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> 
> thanks for the patch! I've tested the eMMC boot on AM625 SK
> and this was exactly the missing piece, with the patch it boots fine:
> 
> Tested-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

note: I have also posted https://lore.kernel.org/r/20230911162535.1044560-4-nm@ti.com

That should take care of this in the kernel sync next time around.

But, for next:

Reviewed-by: Nishanth Menon  <nm@ti.com>

> 
> > ---
> > 
> > (no changes since v1)
> > 
> >  arch/arm/dts/k3-am625-sk-u-boot.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> > index 0def84b4cf0..5f90a4b56f1 100644
> > --- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> > +++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> > @@ -92,6 +92,14 @@
> >         bootph-pre-ram;
> >  };
> >  
> > +&sdhci0 {
> > +       bootph-pre-ram;
> > +};
> > +
> > +&main_mmc0_pins_default {
> > +       bootph-pre-ram;
> > +};
> > +
> >  &sdhci1 {
> >         bootph-pre-ram;
> >  };
> 
> -- 
> Alexander Sverdlin
> Siemens AG
> www.siemens.com

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

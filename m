Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB77CD5BA7
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 12:08:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A65486B54;
	Tue, 19 Sep 2023 14:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SktgPpBd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14E87807BC; Tue, 19 Sep 2023 13:35:53 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4ED386AE8
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 13:35:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38JBZjNv121532;
 Tue, 19 Sep 2023 06:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695123345;
 bh=HFzIWAZL41FHWnRPEMBLxknO2f4I4FN6DzBdudiR9V4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=SktgPpBdv7e6fXWIayT9OZhamtq1fdeSeyNJzZz+DJtb+mjKm5MFK23JqaZFSwTZH
 jod66OsmdML3YPIPjdk6d3oyjy/XNH+I5s7KLSu6aUg23Bh16fF2TdO8QXxeoRdR6M
 nZwpuJP+X+5/jSCBw9mZbe0UlAKXe41+nUMzZlz4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38JBZjNf034842
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Sep 2023 06:35:45 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 06:33:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 06:33:08 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38JBX86s030344;
 Tue, 19 Sep 2023 06:33:08 -0500
Date: Tue, 19 Sep 2023 17:03:07 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "sjoerd@collabora.com"
 <sjoerd@collabora.com>, "a-govindraju@ti.com" <a-govindraju@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "g-vlaev@ti.com" <g-vlaev@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "sjg@chromium.org" <sjg@chromium.org>
Subject: Re: [PATCH v2 4/8] arm: dts: k3-am625-sk: Enable emmc in SPL
Message-ID: <20230919113307.gggr427iyee3olw5@dhruva>
References: <20230406185542.1179073-1-sjoerd@collabora.com>
 <20230406185542.1179073-5-sjoerd@collabora.com>
 <4b593377588ba713229c6671edf0c0848a857bf4.camel@siemens.com>
 <20230919111902.5xuvptr4iqmgsmkr@quotable>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230919111902.5xuvptr4iqmgsmkr@quotable>
X-Mailman-Approved-At: Tue, 19 Sep 2023 14:08:23 +0200
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

On Sep 19, 2023 at 06:19:02 -0500, Nishanth Menon wrote:
> On 07:35-20230919, Sverdlin, Alexander wrote:
> > Hello Sjoerd,
> > 
> > On Thu, 2023-04-06 at 20:55 +0200, Sjoerd Simons wrote:
> > > sdhci0 on the k3-am625-sk is the emmc, enable this in SPL as well to
> > > allow booting from that media.
> > > 
> > > Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > 
> > thanks for the patch! I've tested the eMMC boot on AM625 SK
> > and this was exactly the missing piece, with the patch it boots fine:
> > 
> > Tested-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> note: I have also posted https://lore.kernel.org/r/20230911162535.1044560-4-nm@ti.com
> 
> That should take care of this in the kernel sync next time around.
> 
> But, for next:
> 
> Reviewed-by: Nishanth Menon  <nm@ti.com>
> 

Reviewed-by: Dhruva Gole <d-gole@ti.com>

> > 
> > > ---
> > > 
> > > (no changes since v1)
> > > 
> > >  arch/arm/dts/k3-am625-sk-u-boot.dtsi | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> > > index 0def84b4cf0..5f90a4b56f1 100644
> > > --- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> > > +++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> > > @@ -92,6 +92,14 @@
> > >         bootph-pre-ram;
> > >  };
> > >  
> > > +&sdhci0 {
> > > +       bootph-pre-ram;
> > > +};
> > > +
> > > +&main_mmc0_pins_default {
> > > +       bootph-pre-ram;
> > > +};
> > > +
> > >  &sdhci1 {
> > >         bootph-pre-ram;
> > >  };
> > 
> > -- 
> > Alexander Sverdlin
> > Siemens AG
> > www.siemens.com
> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
> 

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

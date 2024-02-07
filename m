Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1392C4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 10:08:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BA1A878E2;
	Wed,  7 Feb 2024 11:08:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c4ub73Lm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A1B487BC3; Wed,  7 Feb 2024 11:08:26 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39282876AE
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 11:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 417A8MZA018263;
 Wed, 7 Feb 2024 04:08:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707300502;
 bh=i2oVmm983+DzBzNKjb/jFIEUdg7FyRqAaSKTjmkGZds=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=c4ub73LmKC0wrjzr6auA3ukaXT1hKy8aV7O6EE+A2DqfslUE72OCg4PJ6Cf6uDVeq
 wv7TqrReGaEdutmMUQa3Q7C3h67jg6AC746mu9p4UTlHR4i974S/agl/0heAq7xHnD
 NpAfirhHJDMORTGmNS49tp+UPn5Djc8b9Rasa4Y8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 417A8M9I023012
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 7 Feb 2024 04:08:22 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 04:08:22 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 04:08:21 -0600
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 417A8L93120643;
 Wed, 7 Feb 2024 04:08:21 -0600
Date: Wed, 7 Feb 2024 15:38:20 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>, <u-boot@lists.denx.de>, Neha
 Malcom Francis <n-francis@ti.com>, Keerthy J <j-keerthy@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 09/10] DONOTMERGE: arm: dts: j721s2: Fix Power domain for
 VTM node.
Message-ID: <20240207100820.e6xy5ci2pzewb5lq@uda0497581>
References: <20240206-b4-upstream-j721s2-avs-v1-0-b75043c59969@ti.com>
 <20240206-b4-upstream-j721s2-avs-v1-9-b75043c59969@ti.com>
 <092b59f2-681e-4ddf-9a09-d34a18d5efce@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <092b59f2-681e-4ddf-9a09-d34a18d5efce@ti.com>
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

Hi Udit,

On 19:37-20240206, Kumar, Udit wrote:
> 
> On 2/6/2024 5:51 PM, Manorit Chawdhry wrote:
> > Patch is sent to upstream linux [0].
> > 
> > [0]: https://lore.kernel.org/all/20240201-b4-upstream-j721s2-fix-vtm-devid-v2-0-85fd568b77e3@ti.com/
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >   arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi b/arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi
> > index 80aa33c58a45..a47cb557dd95 100644
> > --- a/arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi
> > +++ b/arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi
> > @@ -663,7 +663,7 @@
> >   		compatible = "ti,j7200-vtm";
> >   		reg = <0x00 0x42040000 0x0 0x350>,
> >   		      <0x00 0x42050000 0x0 0x350>;
> > -		power-domains = <&k3_pds 154 TI_SCI_PD_SHARED>;
> > +		power-domains = <&k3_pds 180 TI_SCI_PD_SHARED>;
> 
> I kind of disagree with this patch as Do not Merge, I understand you want to
> do this change as part of next sync.
> 
> But we got already node in u-boot for VTM with incorrect power-domain.
> 
> I am not sure, with incorrect power-domain, how AVS will be behave.
> 
> Here are my 2 cents
> 
> Either mark this patch part of series or Hold AVS till next sync
> 

Can mark the series for AVS as RFC till then ig, will see what to be
done for DT Sync.

Regards,
Manorit

> 
> >   		#thermal-sensor-cells = <1>;
> >   	};
> > 

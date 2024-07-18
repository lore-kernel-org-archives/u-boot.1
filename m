Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68945C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 11:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8EFB8874C;
	Thu, 18 Jul 2024 13:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NB+PkshG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CA3D88766; Thu, 18 Jul 2024 13:13:52 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB00B882BE
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 13:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46IBDlxo090537;
 Thu, 18 Jul 2024 06:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1721301227;
 bh=riceeyaN5lnsf1RYG2H6H9BUYVEv+VqVEVRHR1x7+AI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=NB+PkshG9T+r4pKvJfB3f8SXYSomOec02xrb9Ydhf/2TIRVkjfuzoEGXWHkL6WmuO
 AusQ8cGuUklCKXZOGaQBcOOIu4x19TuL+234W3KBvM1+4Jv8g6K7dOkYsf06IlEeQJ
 FTpOrvgKcZOqpw7Z0gVj0RtkYvGjSt5qCHf1HOmE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46IBDlR9095381
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 18 Jul 2024 06:13:47 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Jul 2024 06:13:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Jul 2024 06:13:46 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46IBDkU8013628;
 Thu, 18 Jul 2024 06:13:46 -0500
Date: Thu, 18 Jul 2024 06:13:46 -0500
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, <c-shilwant@ti.com>,
 <m-chawdhry@ti.com>, <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vibhore Vardhan
 <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>, Sebin Francis
 <sebin.francis@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, <t.remmet@phytec.de>,
 <mkorpershoek@baylibre.com>, Daniel Schultz <d.schultz@phytec.de>
Subject: Re: [PATCH V5 4/6] doc: ti: k3: Add TIFS Stub documentation
Message-ID: <20240718111346.ufzgxvg2g4ws755n@boasting>
References: <20240705164833.2386549-1-d-gole@ti.com>
 <20240705164833.2386549-5-d-gole@ti.com>
 <20240717184719.cbfclsbvvgbgxsif@dentist>
 <20240718103553.otv25om4hfvtza4u@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240718103553.otv25om4hfvtza4u@dhruva>
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

On 16:05-20240718, Dhruva Gole wrote:
> On Jul 17, 2024 at 13:47:19 -0500, Nishanth Menon wrote:
> > On 22:18-20240705, Dhruva Gole wrote:
> > > Add documentation to briefly explain the role of TIFS Stub in relevant
> > > K3 SoC's.
> > > This also sheds light on why TIFS Stub isn't package with the DM firmware
> > > itself.
> > > 
> > > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > > ---
> > >  doc/board/ti/k3.rst | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> > > index 67b066a07d3a..c80060662074 100644
> > > --- a/doc/board/ti/k3.rst
> > > +++ b/doc/board/ti/k3.rst
> > > @@ -193,6 +193,17 @@ online
> > >      device resources such as power, clock, interrupts, dma etc. This firmware
> > >      runs on a dedicated or multi-use microcontroller outside the security
> > >      enclave.
> > > +  * **TIFS Stub** - A small piece of code that helps restore the remaining
> > > +    context and resume the TIFS firmware when resuming from Low Power Modes
> > > +    like Suspend-to-RAM/ Deep Sleep. It is loaded into the ATCM (Tightly
> > > +    Coupled Memory 'A' of the DM R5) during DM startup. The reason it isn't
> > > +    merged with DM is because in HS devices we need to sign the tifs-stub with
> > > +    customer key. The DM cannot have a component signed using a customer key
> > > +    because a HS device customer owns the customer key and only customer
> > > +    has the access for the customer key. Since TIFS Stub signing has to happen
> > > +    from the customer side but DM is released by TI, we need to allow binman to
> > > +    sign the TIFS Stub and only then package it alongside other firmwares.
> > > +    This applies only to AM62x, AM62A and AM62P based devices.
> > 
> > This implies TI is hiding DM source - we are not. TIFS stub is prop
> > binary (the usual issues), but can you rephrase the description above? I
> > do not want to go and explicitly list out the devices this section has
> > either..
> 
> OK.
> I was trying to convey was the binary is provided by TI not that its
> hidden. But yes I will reword it to say:
> 
> .... but DM is released by TI or can be built independently by customers
> using the publicly available sources, we need to allow binman......
> 
> > 
> > Futher, the way it is introduced, did you check the documentation for
> > other SoCs? we dont want tifs stub section to punch in for other SoCs
> > which dont matter.
> 
> Yep, it appears wherever there's include::  ../ti/k3.rst,
> I will introduce few more tags between k3_rst_include_start_boot_sources
> and k3_rst_include_end_boot_sources to help with this. Does that make
> sense?

Yeah - looks like we might need more split up here. we want this to
appear only on relevant platforms.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

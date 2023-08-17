Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BFCEB64DD
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 11:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 649E586ADF;
	Thu, 17 Aug 2023 13:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="u0scpOky";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B66B486AE0; Thu, 17 Aug 2023 13:36:23 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFA1486ADB
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 13:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37HBaINa067671;
 Thu, 17 Aug 2023 06:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692272178;
 bh=oUYvfNEw1Ofbm8g08AnC/e4+ZyNPEYdA/TB8jrQXkcw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=u0scpOkybU/xgbXleuoRhou/M5XaLKKz8t0x78cHFtQpdiR/Mrt1T5spKZFmRHNHU
 35ZoW8Q9p1MQW33d5Q4SFRD/geqi2WIC5hKeIeJQ5XZ5wE3re2S8O1yhpIHztkaY9y
 6bHbbVZ0B0rt6n4BdVPqLxpEnUijz5Mo5hQgxyyQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37HBaIMp088700
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Aug 2023 06:36:18 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Aug 2023 06:36:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Aug 2023 06:36:18 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37HBaIk2090211;
 Thu, 17 Aug 2023 06:36:18 -0500
Date: Thu, 17 Aug 2023 06:36:18 -0500
From: Nishanth Menon <nm@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/3] k3-j721s2: Sync from linux-next tag next-20230815
Message-ID: <20230817113618.ssc6sfyzawdk5kis@ether>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v1-0-f4548452760a@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v1-1-f4548452760a@ti.com>
 <20230816114445.c4c7rgdp5arhmiaq@polyester>
 <787c1106-f4ec-383b-14cf-d055ceebf86b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <787c1106-f4ec-383b-14cf-d055ceebf86b@ti.com>
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

On 09:45-20230817, Kumar, Udit wrote:
> 
> On 8/16/2023 5:14 PM, Nishanth Menon wrote:
> > On 14:53-20230816, Manorit Chawdhry wrote:
> > > The following commit syncs the device tree from Linux tag
> > > next-20230815 to U-boot and fixes the following to be compatible with
> > > the future syncs -
> > [..]
> > +&mcu_timer0 {
> > +		/delete-property/ power-domains;
> > +		/delete-property/ assigned-clocks;
> > +		/delete-property/ assigned-clock-parents;
> > NAK - this should come in from R5 data.
> 
> Having clock data for R5 will not help atleast for  timer.
> 
> As timer is getting probed before the clk frame work comes up ,
> 

Well, u-boot framework is no different in AM625, is'nt it?
https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/k3-am625-sk-u-boot.dtsi#L28

it does work. tells me there is some thing we are'nt pinpointing here.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

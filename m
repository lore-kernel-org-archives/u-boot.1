Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8539C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 17:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29E0A87AD4;
	Thu, 28 Dec 2023 18:30:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Q6lklx51";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BD6D87AF6; Thu, 28 Dec 2023 18:30:43 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06C36879F1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 18:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BSHUZmY054244;
 Thu, 28 Dec 2023 11:30:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703784635;
 bh=CbDxk7z1miVYKx6Vlh96qyxOhyHHP7qzWUaOesgrewQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Q6lklx51u1XqC/4LgRUTor/eAPBtEBoloOYQE0zf6k1JuA56hj0G8o1VVQNDcjp8d
 mOtu/7Nc8jPpGZ3lRqHEtdSD0XJ4egFgLbm11lj3xLKP7r3zPcQdlHD64f1Wx+O9IK
 D6BbFp9pEQW4pgUGe48CajAsgkvmOVRN0k4LI15c=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BSHUZjQ051687
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 28 Dec 2023 11:30:35 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Dec 2023 11:30:35 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Dec 2023 11:30:35 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BSHUZ9e112551;
 Thu, 28 Dec 2023 11:30:35 -0600
Date: Thu, 28 Dec 2023 11:30:35 -0600
From: Bryan Brattlof <bb@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Tom Rini <trini@konsulko.com>, UBoot Mailing List <u-boot@lists.denx.de>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Martyn
 Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 26/26] arm: dts: k3-am654: convert bootph-pre-ram to
 bootph-all
Message-ID: <20231228173035.knbxe4bp2efu75de@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231221174412.210807-1-bb@ti.com>
 <20231221174412.210807-27-bb@ti.com>
 <20231227122906.4mdp3z73gsbmf6t7@judge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20231227122906.4mdp3z73gsbmf6t7@judge>
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

On December 27, 2023 thus sayeth Nishanth Menon:
> On 11:44-20231221, Bryan Brattlof wrote:
> [..]
> > diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
> > index a9b2d0d2a3036..770c7d129339f 100644
> > --- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
> > +++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
> [...]
> >  &wkup_uart0 {
> > -	bootph-pre-ram;
> > +	bootph-all;
> >  };
> 
> Consider moving this to r5 dts - there is no use in having this in
> u-boot. should be pre-ram?
> 
> >  
> >  &mcu_uart0 {
> > -	bootph-pre-ram;
> > +	bootph-all;
> >  };
> Same here:
> Consider moving this to r5 dts - there is no use in having this in
> u-boot. should be pre-ram?
> 

Oh good idea. I'll move these to the r5 dts

~Bryan

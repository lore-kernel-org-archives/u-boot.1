Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A277C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C997686470;
	Mon,  6 Nov 2023 17:50:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EkcDpWTb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F30B086FBE; Mon,  6 Nov 2023 17:50:53 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8329386335
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:50:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A6Goish057784;
 Mon, 6 Nov 2023 10:50:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699289444;
 bh=tgi1C+2WmtQBWiPEdVbq1YzZrMFX4g0mT/3NimsfKjI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=EkcDpWTbjh41Y+7VHj9nxYmm9Omp+sYBb2oqVT5ybqkLBu7wOikVHD2JFRQXS86KY
 i8PouLF5Dkz6w6LvQ5I9Jvf9hze/TrcY1i9s6eEW4Th19d3KwNCwOjgz8l71GcgS5T
 I4fHCEeQooRjQq2jlQoBLUiCmSW3uB7gSjLoSIMw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A6GoixN028650
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Nov 2023 10:50:44 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Nov 2023 10:50:44 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Nov 2023 10:50:44 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A6Goivd094509;
 Mon, 6 Nov 2023 10:50:44 -0600
Date: Mon, 6 Nov 2023 10:50:44 -0600
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sinthu Raja <sinthu.raja@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Reid Tonking <reidt@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCH V2 06/12] arm: mach-k3: Kconfig: Introduce a symbol to
 indicate J7200
Message-ID: <20231106165044.xrmlxoyfbnkmpb5v@revolt>
References: <20231104072150.3339-1-nm@ti.com> <20231104072150.3339-7-nm@ti.com>
 <8b80a570-d558-4f5a-9390-f4c8c8d8210f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8b80a570-d558-4f5a-9390-f4c8c8d8210f@ti.com>
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

On 10:45-20231106, Andrew Davis wrote:
> On 11/4/23 2:21 AM, Nishanth Menon wrote:
> > J7200 shares quite a few characteristics with J721E. However a few sets
> > are different. Introduce a Kconfig to differentiate the two to allow for
> > new boards to be introduced in a seamless manner.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >   arch/arm/mach-k3/Kconfig | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> > index 9168bf842dca..57e2dd966eb8 100644
> > --- a/arch/arm/mach-k3/Kconfig
> > +++ b/arch/arm/mach-k3/Kconfig
> > @@ -24,6 +24,11 @@ config SOC_K3_AM62A7
> >   endchoice
> > +if SOC_K3_J721E
> > +config SOC_K3_J721E_J7200
> 
> I'm sure you know how messy this is :(
> 
> We wanted to treat J7200 as a proper subset device of J721e but we
> also know that didn't happen. These two SoCs ended up more different
> than expected and although still very similar I believe continuing
> to try to support both under one name is not the right solution.
> 
> We will split out J7200 from J721e in TF-A[0] for similar reasons,
> might be time to do the same in u-boot.

Yes, I am aware. A follow on series to cleanup J7200 will be appreciated.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

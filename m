Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD80C7EE2A
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 05:30:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6C7A81FEE;
	Mon, 30 Jun 2025 07:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AcnI5I2D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE96382B20; Mon, 30 Jun 2025 07:30:49 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EA7E81E13
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 07:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55U5UWbJ2522282;
 Mon, 30 Jun 2025 00:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751261432;
 bh=OM8Zrzi7175noOj493X6mNFkVXIFN+LJmrpScqhIaFw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=AcnI5I2DFhZ3M9JZGKmGDZd603+Cx6flUfzdTqMO9bamPahl+Prop2sjZNvfDR6uk
 AX/YcyOSa7Q1wjL+WzzXBkmyHhww8wxxZYeC7e61UYChOqHNYEfBfPY+VIoR3TS/ZU
 bdLnEyhIfV0PK6HON/x7wES1O40dxxMK6p4MWlhQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55U5UWfj1265545
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 30 Jun 2025 00:30:32 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 30
 Jun 2025 00:30:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 30 Jun 2025 00:30:32 -0500
Received: from localhost (uda0497581-hp.dhcp.ti.com [172.24.227.253])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55U5UV3R3040972;
 Mon, 30 Jun 2025 00:30:31 -0500
Date: Mon, 30 Jun 2025 11:00:30 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Gokul Praveen <g-praveen@ti.com>
CC: <trini@konsulko.com>, <casey.connolly@linaro.org>,
 <tien.fong.chee@altera.com>, <sjg@chromium.org>,
 <patrick.rudolph@9elements.com>, <1425075683@qq.com>,
 <Oliver.Gaskell@analog.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/1] configs: KASLR OPTEE RNG support for K3 devices
Message-ID: <20250630053030.4jplhiaud5vu2rjl@uda0497581-HP>
References: <20250627092224.36325-1-g-praveen@ti.com>
 <20250627092224.36325-2-g-praveen@ti.com>
 <20250627102218.xtjlreu5qmpmfszr@uda0497581-HP>
 <a6e024ba-8642-4c58-a7b7-284c8cf448e5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a6e024ba-8642-4c58-a7b7-284c8cf448e5@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Gokul,

On 10:50-20250630, Gokul Praveen wrote:
> Hi Manorit,
> 
> On 27/06/25 15:52, Manorit Chawdhry wrote:
> > Hi Gokul,
> > 
> > On 14:52-20250627, Gokul wrote:
> > > From: Gokul Praveen <g-praveen@ti.com>
> > > 
> > > Add KASLR OPTEE RNG support across K3 devices by enabling the required
> > > configs.
> > > 
> > > Signed-off-by: Gokul Praveen <g-praveen@ti.com>
> > > ---
> > >   arch/arm/Kconfig | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > index 7282c4123b0..cd27e5a5422 100644
> > > --- a/arch/arm/Kconfig
> > > +++ b/arch/arm/Kconfig
> > > @@ -805,6 +805,9 @@ config ARCH_K3
> > >   	select REGEX
> > >   	select FIT_SIGNATURE if ARM64
> > >   	imply TI_SECURE_DEVICE
> > > +	imply DM_RNG
> > > +	imply TEE
> > > +	imply OPTEE
> > 
> > Does it get enabled for R5 based defconfigs too in .config? ARCH_K3 is
> > enabled for both R5 and ARM64 cores so wondering if we are ending up
> > enabling it for R5 too which might not be required ( or is it? )
> > 
> > Regards,
> > Manorit
> > 
> No,it does not get enabled for R5 actually.
> 

Thanks for checking!

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

Regards,
Manorit

> Regards
> Gokul
> > >   config ARCH_OMAP2PLUS
> > >   	bool "TI OMAP2+"
> > > -- 
> > > 2.34.1
> > > 

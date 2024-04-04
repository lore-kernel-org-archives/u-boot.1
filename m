Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14113CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 08:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9907E883E3;
	Thu,  4 Apr 2024 10:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sHzwXVYW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F989883E7; Thu,  4 Apr 2024 10:23:08 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 725FF88275
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 10:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4348N04k059365;
 Thu, 4 Apr 2024 03:23:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712218980;
 bh=MjLbfTpLLJSa3F5aJa0gLu/3IdIVP6UKtmw0av/+nTA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=sHzwXVYWbJX8Tf+/OFEjcKoAS5AdcDWZ1mIJ2UGz6bFfnSH3p5EFLVp1jjD/XKh9U
 DjCIi0y/hwaIwOAM4Haqgax/OgLgCO7SIS1rwv32i682El9712b47lQDvpzjCfyFqw
 B6L3iZwzl9EbmYP57WgIUSyhwhMQektfDKytT7vU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4348N0Xd056836
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Apr 2024 03:23:00 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 03:22:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 03:22:59 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4348Mx8O110678;
 Thu, 4 Apr 2024 03:22:59 -0500
Date: Thu, 4 Apr 2024 13:52:58 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Vibhore Vardhan
 <vibhore@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Francesco Dolcini
 <francesco@dolcini.it>
Subject: Re: [PATCH 2/2] arm: dts: k3: binman: am625: add support for signing
 TIFSSTUB Images
Message-ID: <20240404082258.4zwffzl56kc6neum@dhruva>
References: <20240403120309.4026170-1-d-gole@ti.com>
 <20240403120309.4026170-3-d-gole@ti.com>
 <967ef615-58f8-48e7-bb8e-1c9903e771db@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <967ef615-58f8-48e7-bb8e-1c9903e771db@ti.com>
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

Hi Neha!

On Apr 04, 2024 at 10:20:21 +0530, Neha Malcom Francis wrote:
> Hi Dhruva
> 
> On 03/04/24 17:33, Dhruva Gole wrote:
> > From: Kamlesh Gurudasani <kamlesh@ti.com>
> > 
> > Add support for signing of TIFSSTUB images for HSSE, HSFS and GP devices
> > and include them in tispl.bin and tispl.bin_unsigned.
> > 
> > Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > ---
> >   arch/arm/dts/k3-am625-sk-binman.dtsi | 141 ++++++++++++++++++++++++++-
> >   1 file changed, 139 insertions(+), 2 deletions(-)
> > 
[...]
> >   				dm {
> >   					ti-dm {
> >   						filename = "ti-dm.bin";
> > @@ -270,7 +406,8 @@
> >   				conf-0 {
> >   					description = "k3-am625-sk";
> >   					firmware = "atf";
> > -					loadables = "tee", "dm", "spl";
> > +					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
> > +						  "tifsstub-gp", "dm", "spl";
> >   					fdt = "fdt-0";
> >   				};
> >   			};
> 
> 
> If there are multiple boards that will support TIFSSTUB in future, I would
> prefer templating these out and putting them in k3-binman.dtsi. However

That's a great idea. From the next set of boards for which also need
binman TIFS Stub support we will keep in mind as you said below.
Currently amidst all the movement and cleanup I don't want to push out
too many changes at once.

I also have cleanup and OF_UPSTREAM changes for am62x pending which I
plan on posting sometime soon..

> considering there's a lot of movement currently (cleanup and OF_STREAM) in
> that file, you can maybe take this up when adding support for the next
> board.
> 
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

Thanks!

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

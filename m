Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65133C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 10:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D97EC88297;
	Thu, 18 Jul 2024 12:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RW7UIOpw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FC7488761; Thu, 18 Jul 2024 12:37:06 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2855488286
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 12:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46IAat9N089153;
 Thu, 18 Jul 2024 05:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1721299015;
 bh=GJ97xmN3EEcLsoGvpiRFMLWSKWD2NsafOn4o8G68rnA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=RW7UIOpwLSbIxyf5FIEnr4M4yGvvtak/FZykbqgs1LmytSzBW4/dl0S7Z4yA34Yc3
 G5IDCOGYuRYCE1BeE3tu+TSZ58vyWAZH3l3psFmaEHbRABwdCh9d6IJwVgT+riU/oD
 N1uuDIJyiGSOzCS597jWLcKAb9ymJEA6S1LiKLoQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46IAatZf077435
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 18 Jul 2024 05:36:55 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Jul 2024 05:36:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Jul 2024 05:36:54 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46IAarTU092815;
 Thu, 18 Jul 2024 05:36:54 -0500
Date: Thu, 18 Jul 2024 16:06:53 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, <c-shilwant@ti.com>,
 <m-chawdhry@ti.com>, <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vibhore Vardhan
 <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>, Sebin Francis
 <sebin.francis@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, <t.remmet@phytec.de>,
 <mkorpershoek@baylibre.com>, Daniel Schultz <d.schultz@phytec.de>
Subject: Re: [PATCH V5 0/6] Low Power Mode: Package TIFS Stub in BeaglePlay
Message-ID: <20240718103653.24tyg25rdcz4yr5m@dhruva>
References: <20240705164833.2386549-1-d-gole@ti.com>
 <20240717184907.5bmjwwn6tfmn3jfo@swarm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240717184907.5bmjwwn6tfmn3jfo@swarm>
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

On Jul 17, 2024 at 13:49:07 -0500, Nishanth Menon wrote:
> On 22:18-20240705, Dhruva Gole wrote:
> > This series includes the binman related changes required to package TIFS
> > Stub to support Low Power Modes on BeaglePlay.
> > It also documents the boot flow and tispl packaging details regarding
> > the same.
> > 
> > Changelog:
> > * Add more documentation around last time's discussion[1] on packaging TIFS
> >   Stub in DM.
> > 
> > Link to previous series:
> > https://lore.kernel.org/u-boot/20240704084207.2211801-1-d-gole@ti.com/
> > 
> > [1] https://lore.kernel.org/u-boot/20240705151753.7v3geqkupqu673x3@ambiance/
> > 
> > Thanks for the explanation given in [1] Sebin,
> > Cc: Sebin Francis <sebin.francis@ti.com>
> > 
> > Dhruva Gole (6):
> >   arm: dts: k3-am625-beagleplay: Package TIFS Stub
> >   doc: beagle: am62x_beagleplay: Update the boot flow to show TIFS Stub
> >   doc: beagle: am62x_beagleplay: Add TIFS Stub in image format
> >   doc: ti: k3: Add TIFS Stub documentation
> >   doc: ti: am62*: Mention TIFS Stub in img fmts and boot flow
> > 
> 	Please change the ordering of the patches:
> 
> MAINTAINERS: Include the TI docs under ARM TI
> doc: ti: k3: Add TIFS Stub documentation
> doc: ti: am62*: Mention TIFS Stub in img fmts and boot flow
> 
> then do the stuff for beagleplay - first fix, then add new stuff, NOT
> the other way around - yes, i claim that a feature added without
> documentation is a bug.

Understood, Will reorder and address other concerns in next revision.

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

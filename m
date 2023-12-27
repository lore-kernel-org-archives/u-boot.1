Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53723C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 12:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4C17879A7;
	Wed, 27 Dec 2023 13:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FXQ4J2IO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01F5C879A3; Wed, 27 Dec 2023 13:39:37 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63F3987866
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 13:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BRCdSfD098557;
 Wed, 27 Dec 2023 06:39:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703680768;
 bh=quaZlBsVJw6HeS5CgDQrQo4Lzj/lXUUSH5uEODsSjBo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=FXQ4J2IOJLAN3eadP2AFRjN1ZS0QsqPhQcYXYKu6cPHnhCmruhXd8H2qVitKnnfkP
 5q+P1EHYCxSy2P+NE6rsC+hizuJyE9HltUejGGbmCfTnYmx213DCtbC7uwnYTfuIGp
 jUeZl/IXCLQnMKLTPrZxsUsSl260PqBGbr2GfPaA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BRCdS9W091229
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Dec 2023 06:39:28 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Dec 2023 06:39:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Dec 2023 06:39:28 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BRCdSXd031636;
 Wed, 27 Dec 2023 06:39:28 -0600
Date: Wed, 27 Dec 2023 06:39:28 -0600
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>
CC: Bryan Brattlof <bb@ti.com>, UBoot Mailing List <u-boot@lists.denx.de>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Martyn
 Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 00/26] sync am65x device tree with Linux v6.7-rc1
Message-ID: <20231227123928.rt2wgr3qa7rw5jmf@imitate>
References: <20231221174412.210807-1-bb@ti.com>
 <20231221200056.GM2513409@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231221200056.GM2513409@bill-the-cat>
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

On 15:00-20231221, Tom Rini wrote:
> On Thu, Dec 21, 2023 at 11:43:46AM -0600, Bryan Brattlof wrote:
> 
> > Hello Everyone!
> > 
> > This series gets the am65x booting again along with syncing the device
> > tree files with v6.7-rc1 Linux.
> > 
> > The bulk of these patches unify the WKUP SPL board file with the arm64
> > files to make future syncs from Linux much easier. In the end the DTBs
> > should look a lot like what the DTBs look like for the am64x which
> > is fairly similar to the am65x.
> > 
> > For those interested in what UART boot looks like:
> >    https://paste.sr.ht/~bryanb/7df8a645dc548912cd806abd5ecab967ef3287bc
> > 
> > Thanks for reviewing and happy holidays
> > ~Bryan
> 
> For the series,
> Tested-by: Tom Rini <trini@konsulko.com>
> 
> Nishanth, does this path work for you?
> 

Other than the minor comments provided in the relevant patches,

The following files also need sync up with v6.7-rc1.

k3-am65-iot2050-common-pg2.dtsi
k3-am65-iot2050-common.dtsi
k3-am6528-iot2050-basic-common.dtsi
k3-am6548-iot2050-advanced-common.dtsi
k3-am6548-iot2050-advanced-m2.dts

Jan - could you look at syncing those once an update to this series is
posted? We could probably have a smoother v6.8-rc1 from then on.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

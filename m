Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DEDC4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 10:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32D8F87BC3;
	Wed,  7 Feb 2024 11:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DwIoKq0g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A287587CD2; Wed,  7 Feb 2024 11:05:57 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36678876AE
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 11:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 417A5roP069485;
 Wed, 7 Feb 2024 04:05:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707300353;
 bh=BKBHQveKlwLyPwPiaxGom6R9sxUxPWws4sP8e4iDP4E=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=DwIoKq0gF1nNNLtJO+09gtSRpJ86/m6OrxgmxdN6miTGqkVZeHl9nexTZvPpH0LYF
 hc3CUZ1vDoxJoqN3zFCmqWE/0W1RZipd0llBzUt/iq3Pyr1D1C7YtwYNhRvA/cn7Yb
 zIHSeVJI+c0hs5Yv2VtjBjI+mGJ9JJ7nQIGFPdr0=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 417A5rHV046498
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 7 Feb 2024 04:05:53 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 04:05:52 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 04:05:52 -0600
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 417A5qTt075268;
 Wed, 7 Feb 2024 04:05:52 -0600
Date: Wed, 7 Feb 2024 15:35:51 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>, <u-boot@lists.denx.de>, Neha
 Malcom Francis <n-francis@ti.com>, Keerthy J <j-keerthy@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 00/10] Add AVS support for J721S2
Message-ID: <20240207100551.p3uvhlz577jmi2ho@uda0497581>
References: <20240206-b4-upstream-j721s2-avs-v1-0-b75043c59969@ti.com>
 <20240206134549.GP1152441@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240206134549.GP1152441@bill-the-cat>
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

Hi Tom,

On 08:45-20240206, Tom Rini wrote:
> On Tue, Feb 06, 2024 at 05:51:07PM +0530, Manorit Chawdhry wrote:
> 
> > This series does the DT sync with Linux 6.8-rc1 as that has the pmic
> > nodes required for AVS support and then adds AVS Support for J721S2.
> > 
> > AVS Test for J721S2: https://gist.github.com/manorit2001/d7690ded6ef685aa8ffa5b16746cc529
> > Boot Test results: https://gist.github.com/manorit2001/6775d721b3df5a690497d94d012b93c4
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> > Manorit Chawdhry (10):
> >       arm: dts: k3-j721s2*: Sync with 6.8-rc1
> >       arm: dts: k3-am68*: Sync with 6.8-rc1
> 
> The starting point for this series should be to build on top of Sumit's
> OF_UPSTREAM series.
> 

I see that series is still under discussion and not yet merged ( hoping
am on the correct thread [0]). Do I have to rebase my commits on top of
that and try or do you think that series is gonna take time?

[0]:  https://lore.kernel.org/u-boot/20240206130040.GO1152441@bill-the-cat/ 

> >       DONOTMERGE: arm: dts: j721s2: Fix Power domain for VTM node.
> 
> And please make sure to mark the series as RFC if there's DONOTMERGE
> parts in it, thanks.

Sure, would convert it to an RFC series.

Regards,
Manorit
> 
> -- 
> Tom



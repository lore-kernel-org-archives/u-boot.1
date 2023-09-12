Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4C5CA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 06:48:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 339B586915;
	Tue, 12 Sep 2023 08:48:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nXqHx25p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18D8386CD0; Tue, 12 Sep 2023 08:48:03 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 230D586672
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 08:47:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38C6lt39084353;
 Tue, 12 Sep 2023 01:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694501275;
 bh=LZscIsquXW+by6Kf4syS3wBDr0tHgJX0L8MFwT1lHRI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=nXqHx25pRzVijNcRK+/9jqfOlFOZZoHHB/KjzuRZdbZc13eHRCGq3emAfIODkbR0X
 eSbhK7oTBcwqhMiwJ2K7+65zSH5WEy6lgpeugVonYTxL2a2iMx5jsk9ZGRKx1EesC2
 ISqqb2JolCwv+znaUxpkvAGjD/A3BypQJw4MPAKM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38C6ltDR005149
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Sep 2023 01:47:55 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 01:47:55 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 01:47:55 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38C6lsA7044455;
 Tue, 12 Sep 2023 01:47:54 -0500
Date: Tue, 12 Sep 2023 12:17:54 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Bryan
 <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Marcel Ziswiler <marcel@ziswiler.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>
Subject: Re: [PATCH 2/2] arm: dts: k3-am625: Sync with kernel v6.6-rc1
Message-ID: <20230912064754.gisep6zgbuhi7tsq@dhruva>
References: <20230911140256.945074-1-nm@ti.com>
 <20230911140256.945074-3-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230911140256.945074-3-nm@ti.com>
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

On Sep 11, 2023 at 09:02:56 -0500, Nishanth Menon wrote:
> Sync device tree with v6.6-rc1
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/dts/k3-am62-main.dtsi       |  52 ++++++++-
>  arch/arm/dts/k3-am62-mcu.dtsi        |  24 +++++
>  arch/arm/dts/k3-am62-verdin-dev.dtsi |  50 +++++++++
>  arch/arm/dts/k3-am62-verdin.dtsi     |  45 +++++++-
>  arch/arm/dts/k3-am62.dtsi            |   8 ++
>  arch/arm/dts/k3-am625-beagleplay.dts | 154 ++++++++++++++++++++++++++-
>  arch/arm/dts/k3-am625-sk.dts         |   2 +-
>  7 files changed, 325 insertions(+), 10 deletions(-)
> 

LGTM! Thanks for the sync up.

Reviewed-by: Dhruva Gole <d-gole@ti.com>

> 

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

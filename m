Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC38CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 16:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C364B883D3;
	Thu,  4 Apr 2024 18:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="w69yozjC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAC75883D6; Thu,  4 Apr 2024 18:37:23 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8EF488259
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 18:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 434GbFUb116221;
 Thu, 4 Apr 2024 11:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712248635;
 bh=g/BYYlgzEl/MrJrYNWb6uRvkb57dqaeuWur0+zEAvfQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=w69yozjC6e/LDkAB2GwwLRm04B6P8F4XjVS54e6FM2WOBKpBuTmXDrtCrxL6P1D7U
 fdYhNuMycUBVljr8HfPyqCj+x/bhPmv02N9o9aT4oCa/6K1/W3E+R6JtWoDETu8PEL
 GTg1ZVoiJ07vPCFVORSkY87hpnSyk290lOI4JCws=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 434GbF6Z088143
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Apr 2024 11:37:15 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 11:37:14 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 11:37:14 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 434GbE6c102873;
 Thu, 4 Apr 2024 11:37:14 -0500
Date: Thu, 4 Apr 2024 11:37:14 -0500
From: Bryan Brattlof <bb@ti.com>
To: Jayesh Choudhary <j-choudhary@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <jh80.chung@samsung.com>,
 <lukma@denx.de>, <seanga2@gmail.com>, <vaishnav.a@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <sumit.garg@linaro.org>,
 <vigneshr@ti.com>, <nm@ti.com>, <afd@ti.com>, <rogerq@kernel.org>,
 <r-gunasekaran@ti.com>
Subject: Re: [RFC PATCH 08/15] arm: mach-k3: j722s: introduce clock and
 device files for wkup spl
Message-ID: <20240404163714.p2wonpenkiz44cnd@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240404090039.87458-1-j-choudhary@ti.com>
 <20240404090039.87458-9-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240404090039.87458-9-j-choudhary@ti.com>
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

On April  4, 2024 thus sayeth Jayesh Choudhary:
> Include the clock and lpsc tree files needed for the wkup spl to
> initialize the proper PLLs and power domains to boot the SoC.
> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  arch/arm/mach-k3/r5/Makefile           |   1 +
>  arch/arm/mach-k3/r5/j722s/Makefile     |   6 +
>  arch/arm/mach-k3/r5/j722s/clk-data.c   | 312 +++++++++++++++++++++++++
>  arch/arm/mach-k3/r5/j722s/dev-data.c   |  69 ++++++
>  drivers/clk/ti/clk-k3.c                |   6 +
>  drivers/power/domain/ti-power-domain.c |   6 +
>  include/k3-clk.h                       |   1 +
>  include/k3-dev.h                       |   1 +
>  8 files changed, 402 insertions(+)
>  create mode 100644 arch/arm/mach-k3/r5/j722s/Makefile
>  create mode 100644 arch/arm/mach-k3/r5/j722s/clk-data.c
>  create mode 100644 arch/arm/mach-k3/r5/j722s/dev-data.c
> 

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan

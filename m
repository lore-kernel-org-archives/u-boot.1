Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5922C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 11:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 023978841E;
	Wed, 19 Jun 2024 13:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bbehB4RJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C51C88415; Wed, 19 Jun 2024 13:49:24 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0445B88415
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 13:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45JBnIBK106622;
 Wed, 19 Jun 2024 06:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718797758;
 bh=w7Hf8CMibq6OLNHazQ6Vilh47xtOyuF7DkEn4nDosds=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=bbehB4RJ4fSjqURNV9tj/jgji6katmvKL5bOP6mx1/6fPVAda8h1neZ8h+VBTSveO
 4a4W2iGoDdkW7V0yET3m7zF+qlO8aGLwHi+9rQHgh7k0ZrhSJw14z4m6d7G/YLxXfk
 hKEC+yH3bibQsTvDbdcbbnwoDs4+R5RC6JRU/APE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45JBnIUY022569
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Jun 2024 06:49:18 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Jun 2024 06:49:18 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Jun 2024 06:49:18 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45JBnHdC012367;
 Wed, 19 Jun 2024 06:49:17 -0500
Date: Wed, 19 Jun 2024 17:19:16 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/6] arm: mach-k3: Add default ATF location for AM62/AM62a
Message-ID: <20240619114916.72icpumb2tumsnbt@dhruva>
References: <20240214163009.983034-1-afd@ti.com>
 <20240214163009.983034-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240214163009.983034-2-afd@ti.com>
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

Hi,

On Feb 14, 2024 at 10:30:04 -0600, Andrew Davis wrote:
> There is a default ATF load address that is used for devices that have
> ATF running in SRAM. For AM62 and AM62a, ATF runs from DRAM. Instead
> of having to override the address in every defconfig, make add a
> default for these ATF in DRAM devices.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/mach-k3/Kconfig               | 5 +++--
>  configs/am62ax_evm_a53_defconfig       | 1 -
>  configs/am62x_beagleplay_a53_defconfig | 1 -
>  configs/am62x_evm_a53_defconfig        | 1 -
>  configs/phycore_am62x_a53_defconfig    | 1 -
>  configs/verdin-am62_a53_defconfig      | 1 -
>  6 files changed, 3 insertions(+), 7 deletions(-)
> 

Beagleplay stops booting completely with latest U-boot so I did a little
bisect and it seems like reverting this patch helps.

I am not sure what other implications there are of reverting this so I
don't suggest immediately dropping it, however some hints around what's
missing on beagleplay vs other platforms would be helpful.

Because other platforms based off the same SoC don't seem to be
affected.

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

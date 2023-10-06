Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0212E9371E
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 11:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00BAC86CCE;
	Fri,  6 Oct 2023 13:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KY+GfLfC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A93ED86CD5; Fri,  6 Oct 2023 13:19:42 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B46E786BDF
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 13:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 396BJc99098115;
 Fri, 6 Oct 2023 06:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696591178;
 bh=tVAAu5EVQfcipRtBRNsWzyfcJWrVzd49awsS3TSlZLk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=KY+GfLfCrgGqH6nKjdRXGRoaR6Cl5UIk94l8yzGniuftqJjFTOwZVwEQugBMK4eb5
 qawsZKf/PVEgPrOuGdW2B7XK0osQEiyBRtf0rE686xRsZHJ2qUE/qqh9TYA+3O3L72
 zq/+fguW1/Um4IpJ7jrsP5O2mw60PwgHMzLK9XfQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 396BJcNv006681
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 6 Oct 2023 06:19:38 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Oct 2023 06:19:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Oct 2023 06:19:38 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 396BJcFC056744;
 Fri, 6 Oct 2023 06:19:38 -0500
Date: Fri, 6 Oct 2023 06:19:38 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v7 2/7] Revert "arm: dts: k3-j7*: ddr: Update to 0.10
 version of DDR config tool"
Message-ID: <20231006111938.supnuvlgwfv5fmom@squatter>
References: <20231006-b4-upstream-j721s2-r5-pinmux-v7-0-5d31f765dd2c@ti.com>
 <20231006-b4-upstream-j721s2-r5-pinmux-v7-2-5d31f765dd2c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231006-b4-upstream-j721s2-r5-pinmux-v7-2-5d31f765dd2c@ti.com>
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

On 10:15-20231006, Manorit Chawdhry wrote:
> The update causes instability in am68-sk boards so revert the patch in
> the meantime till fix is available.
> 
> This reverts commit f1edf4bb6aa19732574ac23ca90cb9a0ba395ec1.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  arch/arm/dts/k3-j721e-ddr-evm-lp4-4266.dtsi  |  98 +++---
>  arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi | 464 +++++++++++++--------------
>  2 files changed, 281 insertions(+), 281 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-j721e-ddr-evm-lp4-4266.dtsi b/arch/arm/dts/k3-j721e-ddr-evm-lp4-4266.dtsi
> index a0285ce0520e..5a6f9b11b8e3 100644
> --- a/arch/arm/dts/k3-j721e-ddr-evm-lp4-4266.dtsi
> +++ b/arch/arm/dts/k3-j721e-ddr-evm-lp4-4266.dtsi

Sigh. Hope to see a fix some time.

Reviewed-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

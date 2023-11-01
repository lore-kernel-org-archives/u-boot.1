Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536BDC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 15:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F77D87747;
	Wed,  1 Nov 2023 16:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uZUamItQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7280587744; Wed,  1 Nov 2023 16:40:19 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A0BC87BBD
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 16:40:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A1FeDU1011627;
 Wed, 1 Nov 2023 10:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698853213;
 bh=OCwPCrOSpdazXOjiqgxsQtutHZLtX+9ckQ8f6O/uc/k=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=uZUamItQ2ukDBXhhNbie5EpfkFHZ672JAN2YKSdAkKJyySNp2iZ6qmT2FdQofyLDE
 4RHkWv6xIMVGCn6u4CTszWYngOWh+zoSLCV+EPQF7iwK2PwClxdked52ML49BRhDZK
 8Dgp2Y7lcxCy+vTzFLyW1pO+3wrWYfMRqFD7ffRw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A1FeDdi027455
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 1 Nov 2023 10:40:13 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 1
 Nov 2023 10:40:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 1 Nov 2023 10:40:12 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A1FeCrw071828;
 Wed, 1 Nov 2023 10:40:12 -0500
Date: Wed, 1 Nov 2023 10:40:12 -0500
From: Nishanth Menon <nm@ti.com>
To: Nitin Yadav <n-yadav@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <praneeth@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2 0/4] Add AM62x LP SK support
Message-ID: <20231101154012.z52alma2unwfw2f3@frugality>
References: <20231030110138.1347603-1-n-yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231030110138.1347603-1-n-yadav@ti.com>
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

On 16:31-20231030, Nitin Yadav wrote:
> This series adds support of AM62x LP SK. The AM62x LP SK board
> is similar to AM62x SK but has some significant changes that
> requires different set of device tree at each stage of bootloader.
> Also refactors to have common nodes at k3-am62x-r5-sk-common.dtsi
> and k3-am62x-sk-common-u-boot.dtsi for all am62x SoC varients.
> 
> Change Log:
> 
> V1 -> V2:
>  - Added deltas for board documentation.
>  - Updated commit messgae to include board schematics.
>  - Replace 'bootph-pre-ram' from 'bootph-all' in u-boot.dtsi
>  - Removed memory node from k3-am62-r5-lp-sk.dts
>  - Updated DDR part on k3-am62x-ddr-lp4-50-800-800.dtsi
>  - Squashed binman.dtsi into k3-am62-lp-sk-u-boot.dtsi
>  - Removed am62xlpsk.env environment, for now using am62.env
> 
> V1: https://lore.kernel.org/all/20230927082105.3729470-1-n-yadav@ti.com/
> 
> Nitin Yadav (4):
>   arm: dts: Refactor common dtsi file for R5 and A53 SPL
>   arm: dts: Add support for AM62x LP SK
>   board: ti: am62x: add am62x_lpsk_*_defconfigs fragments
>   doc: ti: Add AM62x LP SK Board information
> 
>  arch/arm/dts/Makefile                         |    2 +
>  arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi        |   32 +
>  arch/arm/dts/k3-am62-lp-sk.dts                |  231 ++
>  arch/arm/dts/k3-am62-r5-lp-sk.dts             |   12 +
>  arch/arm/dts/k3-am625-r5-sk.dts               |   94 +-
>  arch/arm/dts/k3-am625-sk-u-boot.dtsi          |  110 +-
>  arch/arm/dts/k3-am62x-ddr-lp4-50-800-800.dtsi | 2190 +++++++++++++++++
>  arch/arm/dts/k3-am62x-r5-sk-common.dtsi       |   96 +
>  arch/arm/dts/k3-am62x-sk-common-u-boot.dtsi   |  109 +
>  board/ti/am62x/am62x_lpsk_a53.config          |    5 +
>  board/ti/am62x/am62x_lpsk_r5.config           |    5 +
>  doc/board/ti/am62x_sk.rst                     |    8 +
>  12 files changed, 2696 insertions(+), 198 deletions(-)
>  create mode 100644 arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi
>  create mode 100644 arch/arm/dts/k3-am62-lp-sk.dts
>  create mode 100644 arch/arm/dts/k3-am62-r5-lp-sk.dts
>  create mode 100644 arch/arm/dts/k3-am62x-ddr-lp4-50-800-800.dtsi
>  create mode 100644 arch/arm/dts/k3-am62x-r5-sk-common.dtsi
>  create mode 100644 arch/arm/dts/k3-am62x-sk-common-u-boot.dtsi
>  create mode 100644 board/ti/am62x/am62x_lpsk_a53.config
>  create mode 100644 board/ti/am62x/am62x_lpsk_r5.config
> 
> -- 
> 2.25.1
> 


Both AM654 and AM62A need DT-sync:
https://gist.github.com/nmenon/a86f1384e62df1359d8da1cd42b5d4ad

Please consider fixing existing platforms to boot before we introduce
new ones.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

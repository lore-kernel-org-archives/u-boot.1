Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773A3C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 16:40:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3C66805C9;
	Mon, 28 Aug 2023 18:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LWq7AlCO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E899864BA; Mon, 28 Aug 2023 18:39:57 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF19580295
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 18:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37SGdqRu075176;
 Mon, 28 Aug 2023 11:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693240792;
 bh=J+S07FgQusWFDMsgc0bANNAOJHzuaYDR5wlyz0NRs14=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=LWq7AlCO++fyT4hBvP91pgyECDm/Uunetx3axcFKL3pTFyBP60/48GIK8/3+85WnB
 I7/K1SgBPljxmJIQkhhz7sZc4HiwOfIGMyE5QegPCMuECARuLSHXoXhFKzJlZJOR58
 i535fPK16YQk0KZsjOx9HLVQGFsIVcsRha1dEKG8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37SGdqbC012619
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Aug 2023 11:39:52 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Aug 2023 11:39:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Aug 2023 11:39:52 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37SGdqcU026365;
 Mon, 28 Aug 2023 11:39:52 -0500
Date: Mon, 28 Aug 2023 11:39:52 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v2 6/6] board: ti: j721s2: MAINTAINERS: Update the
 MAINTAINERS File.
Message-ID: <20230828163952.6rahky2zplbh2yqj@proclaim>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v2-0-a5f141be40bc@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v2-6-a5f141be40bc@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v2-6-a5f141be40bc@ti.com>
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

On 16:47-20230825, Manorit Chawdhry wrote:
> Update the MAINTAINERS file and propose a new MAINTAINER for j721s2 due
> to the previous MAINTAINER not being associated with TI.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  board/ti/j721s2/MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/board/ti/j721s2/MAINTAINERS b/board/ti/j721s2/MAINTAINERS
> index 323bd2353a7e..97a0581d0405 100644
> --- a/board/ti/j721s2/MAINTAINERS
> +++ b/board/ti/j721s2/MAINTAINERS
> @@ -1,7 +1,8 @@
>  J721S2 BOARD
> -M:	Aswath Govindraju <a-govindraju@ti.com>
> +M:	Manorit Chawdhry <m-chawdhry@ti.com>

Thank you for stepping up.

>  S:	Maintained
>  F:	board/ti/j721s2
> +F:	doc/board/ti/j721s2_evm.rst
>  F:	include/configs/j721s2_evm.h
>  F:	configs/j721s2_evm_r5_defconfig
>  F:	configs/j721s2_evm_a72_defconfig
> @@ -11,6 +12,6 @@ F:	arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi
>  F:	arch/arm/dts/k3-j721s2-som-p0.dtsi
>  F:	arch/arm/dts/k3-j721s2-common-proc-board.dts
>  F:	arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
> -F:	arch/arm/dts//k3-j721s2-r5-common-proc-board.dts
> +F:	arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
>  F:	arch/arm/dts/k3-j721s2-ddr.dtsi
>  F:	arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi


I suggest adding additional patch to include AM68 as well.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

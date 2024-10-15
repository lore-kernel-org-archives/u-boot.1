Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58196D216B7
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 14:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECB4B88009;
	Tue, 15 Oct 2024 16:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W5CoJ9A1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB39388113; Tue, 15 Oct 2024 16:38:24 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29B968657F
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 16:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49FEcIpF108146;
 Tue, 15 Oct 2024 09:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729003098;
 bh=BSeTLtuOOcKXDpHFmV5628SDdlgRRCZLGWgUXIuFQjw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=W5CoJ9A1GXjOFz56RyIdWQcZAinEptcHtq1LwNz7SfrPv333BVYCNUycMUMva6KAa
 AvJTq/3L6mpOQlhKIkX+g6EmxUO6IDHS3VihoDhiao9KTbKH6a539y5jlQkvNHsucz
 rENneCMA0YaZ88DZTaEWZ7P46Rreh+Y72OwGnaD4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49FEcIxn006370
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Oct 2024 09:38:18 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Oct 2024 09:38:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Oct 2024 09:38:17 -0500
Received: from [172.24.227.91] (psdkl-workstation0.dhcp.ti.com [172.24.227.91])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49FEcDvk108428;
 Tue, 15 Oct 2024 09:38:14 -0500
Message-ID: <dad4ebfb-e95b-4fe7-b38d-2ef52165bad3@ti.com>
Date: Tue, 15 Oct 2024 20:08:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] Add AVS support for J721S2
To: Manorit Chawdhry <m-chawdhry@ti.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis
 <afd@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>
References: <20241015-b4-upstream-j721s2-avs-v5-0-5c8087387dc5@ti.com>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <20241015-b4-upstream-j721s2-avs-v5-0-5c8087387dc5@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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



On 15/10/24 16:22, Manorit Chawdhry wrote:
> This series adds support for Adaptive voltage scaling on J721S2 device [0].
> 
> [0]: https://www.ti.com/lit/pdf/spruj28 (Section 5.2.4.1 AVS Support)
> 
> AVS Test for J721S2: https://gist.github.com/manorit2001/b2fd9f6764a863294d4aa0755c83c84f
> Boot Test results: https://gist.github.com/manorit2001/d44e035552cb19aadeb0d928d5cb5f26
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
> Changes in v5:
> * Nishanth
> - Update the commit message for defconfig update
> - Add MPU clock to all devicetree node
> 
> * Simon
> - Update the commit messages to be more helpful
> 
> - Link to v4: https://lore.kernel.org/r/20241004-b4-upstream-j721s2-avs-v4-0-6d71c6bab9f4@ti.com
> 
> ---
> Manorit Chawdhry (7):
>        power: pmic: tps65941: Add DM_PMIC dependency
>        drivers: misc: k3_avs: Check return code while programming AVS
>        arm: dts: k3-*-r5: Add MPU clock in clocks property
>        drivers: misc: k3_avs: Extract MPU clk and dev ID from DT
>        arm: mach-k3: j721s2_init: Initialize AVS Class 0
>        arm: dts: j721s2: Add VTM node in R5
>        configs: j721s2_evm_r5_defconfig: Add AVS Configs
> 

For the series,

Reviewed-by: Aniket Limaye <a-limaye@ti.com>

>   arch/arm/dts/k3-am62-r5-lp-sk.dts               |  3 +-
>   arch/arm/dts/k3-am625-r5-beagleplay.dts         |  3 +-
>   arch/arm/dts/k3-am625-r5-sk.dts                 |  3 +-
>   arch/arm/dts/k3-am62a7-r5-sk.dts                |  3 +-
>   arch/arm/dts/k3-am62p5-r5-sk.dts                |  3 +-
>   arch/arm/dts/k3-am642-r5-evm.dts                |  3 +-
>   arch/arm/dts/k3-am642-r5-sk.dts                 |  3 +-
>   arch/arm/dts/k3-am654-r5-base-board.dts         |  3 +-
>   arch/arm/dts/k3-am69-r5-sk.dts                  |  3 +-
>   arch/arm/dts/k3-j7200-r5-common-proc-board.dts  |  3 +-
>   arch/arm/dts/k3-j721e-r5.dtsi                   |  3 +-
>   arch/arm/dts/k3-j721s2-r5-common-proc-board.dts |  9 ++++++
>   arch/arm/dts/k3-j721s2-r5.dtsi                  |  3 +-
>   arch/arm/dts/k3-j722s-r5-evm.dts                |  3 +-
>   arch/arm/dts/k3-j784s4-r5-evm.dts               |  3 +-
>   arch/arm/mach-k3/j721s2/j721s2_init.c           | 10 +++++++
>   configs/am68_sk_r5_defconfig                    |  4 +++
>   configs/j721s2_evm_r5_defconfig                 |  6 ++++
>   drivers/misc/k3_avs.c                           | 40 ++++++++++++++++++++++++-
>   drivers/power/pmic/Kconfig                      |  1 +
>   20 files changed, 97 insertions(+), 15 deletions(-)
> ---
> base-commit: 28dc47038edc4e93f32d75a357131bcf01a18d85
> change-id: 20240130-b4-upstream-j721s2-avs-8c187d3fe26a
> 
> Best regards,

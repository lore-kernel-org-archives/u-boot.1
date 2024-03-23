Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58A9C6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 16:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5F80875FA;
	Sat, 23 Mar 2024 17:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="H6CzoAJa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 194B787CEA; Sat, 23 Mar 2024 17:07:51 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E403E87527
 for <u-boot@lists.denx.de>; Sat, 23 Mar 2024 17:07:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42NG7gte087881;
 Sat, 23 Mar 2024 11:07:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711210062;
 bh=RsgQMoByEkEk7btVaFlyFJdMrVnfS4VUuAn5TmLvu6c=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=H6CzoAJau5zHwkKFj0IPUf1WuX52PWcR8YDADpcY8/qNi87meC6NrsP8rki9++m6O
 2SEmo2WnoEnwnhjrkZ/1aDmr1vuSegmPnjxVE7gNe9rKl16V9Zz/btltRRer/h+vN9
 ynPoa/pVsOkE+50/TpofCPUh/26zoY3K2o26gHGk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42NG7gHu020633
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 23 Mar 2024 11:07:42 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 23
 Mar 2024 11:07:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 23 Mar 2024 11:07:41 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42NG7fNY037300;
 Sat, 23 Mar 2024 11:07:41 -0500
Message-ID: <357291fb-3a38-4d58-8078-628eb2e5f9a2@ti.com>
Date: Sat, 23 Mar 2024 11:07:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm: dts: k3-*-binman.dtsi: Clean up and templatize
 boot binaries
To: Neha Malcom Francis <n-francis@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <bb@ti.com>, <nm@ti.com>, <sumit.garg@linaro.org>
CC: <michal.simek@amd.com>, <marex@denx.de>, <neil.armstrong@linaro.org>,
 <vigneshr@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>, <u-kumar1@ti.com>
References: <20240322131011.1029620-1-n-francis@ti.com>
 <20240322131011.1029620-4-n-francis@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240322131011.1029620-4-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/22/24 8:10 AM, Neha Malcom Francis wrote:
> Clean up templatized boot binaries for all K3 boards. This includes
> modifying the k3-binman.dtsi to use SPL_BOARD_DTB, BOARD_DESCRIPTION and
> UBOOT_BOARD_DESCRIPTION from the files that include it to further reuse
> code.
> 
> All k3-<soc>-binman.dtsi will contain only templates. Only required boot
> binaries can be built from the templates in the boards' respective
> -u-boot.dtsi file (or k3-<board>-binman.dtsi if it exists). This allows
> clear distinction between the SoC common stuff vs. what is additionally
> needed to boot up a specific board.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  | 161 +---------
>   arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 291 +----------------
>   arch/arm/dts/k3-am625-r5-beagleplay.dts       |  39 ---
>   arch/arm/dts/k3-am625-sk-binman.dtsi          | 148 +--------
>   arch/arm/dts/k3-am625-sk-u-boot.dtsi          |  42 +++
>   .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 296 +-----------------
>   arch/arm/dts/k3-am62a-sk-binman.dtsi          | 146 +--------
>   arch/arm/dts/k3-am62a7-sk-u-boot.dtsi         |  42 +++
>   arch/arm/dts/k3-am642-evm-u-boot.dtsi         |  42 +++
>   arch/arm/dts/k3-am642-sk-u-boot.dtsi          |  42 +++
>   arch/arm/dts/k3-am64x-binman.dtsi             | 239 +-------------
>   arch/arm/dts/k3-am654-base-board-u-boot.dtsi  |  49 +++
>   arch/arm/dts/k3-am65x-binman.dtsi             | 144 +--------
>   .../arm/dts/k3-am68-sk-base-board-u-boot.dtsi |  26 ++
>   arch/arm/dts/k3-am69-sk-u-boot.dtsi           |  31 +-
>   arch/arm/dts/k3-binman.dtsi                   |  96 ++++++
>   arch/arm/dts/k3-j7200-binman.dtsi             | 145 +--------
>   .../k3-j7200-common-proc-board-u-boot.dtsi    |  40 +++
>   .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   | 154 +--------
>   arch/arm/dts/k3-j721e-binman.dtsi             | 262 +++-------------
>   .../k3-j721e-common-proc-board-u-boot.dtsi    |  84 +++++
>   arch/arm/dts/k3-j721e-r5-beagleboneai64.dts   |  91 +-----
>   arch/arm/dts/k3-j721e-sk-u-boot.dtsi          |  84 +++++
>   arch/arm/dts/k3-j721s2-binman.dtsi            | 231 +-------------
>   .../k3-j721s2-common-proc-board-u-boot.dtsi   |  42 +++
>   arch/arm/dts/k3-j784s4-binman.dtsi            | 154 +--------
>   arch/arm/dts/k3-j784s4-evm-u-boot.dtsi        |  42 +++
>   27 files changed, 858 insertions(+), 2305 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> index cca0f44b7d8..fc1898f1510 100644
> --- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> @@ -6,7 +6,11 @@
>    * Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
>    */
>   
> -#include "k3-binman.dtsi"
> +#define SPL_BOARD_DTB "spl/dts/k3-am625-beagleplay.dtb"
> +#define BOARD_DESCRIPTION "k3-am625-beagleplay"
> +#define UBOOT_BOARD_DESCRIPTION "U-Boot for AM625 BeaglePlay"
> +
> +#include "k3-am625-sk-binman.dtsi"

Why is the BeaglePlay board including the SK binman file? Looks
like you made `k3-am625-sk-binman.dtsi` into the SoC general
file, which is good, but you should probably also rename it
here to match: `k3-am625-binman.dtsi`.

Andrew

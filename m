Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BEAC6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 12:27:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A637288060;
	Tue, 26 Mar 2024 13:27:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tPGFUThK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B732588063; Tue, 26 Mar 2024 13:27:34 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAB7B8804D
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 13:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QCRNCm081394;
 Tue, 26 Mar 2024 07:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711456043;
 bh=8iOTdjVWq733ZNuONR8KJpU31ZRjjwYsbzNto8dD8Qs=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=tPGFUThKrgJxPw43KfO62UzH6DIztCuiPnEMH4t1jszEaNMasiwNHRXvsekLRT1kZ
 l/5Em5QSasLTX5GzzIwGJqpGnQM7au4ClI8tiwyDVPGfSplmYIJlNdjOk6cQ2WV7aJ
 PZFhB4Y37gGx7p3BbKOEQBo4ErO3yIltxOgyGRx0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QCRNhT016363
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Mar 2024 07:27:23 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 07:27:23 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 07:27:22 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QCRNU8084307;
 Tue, 26 Mar 2024 07:27:23 -0500
Date: Tue, 26 Mar 2024 07:27:23 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <bb@ti.com>, <sumit.garg@linaro.org>,
 <michal.simek@amd.com>, <marex@denx.de>, <neil.armstrong@linaro.org>,
 <afd@ti.com>, <vigneshr@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>,
 <u-kumar1@ti.com>
Subject: Re: [PATCH 3/4] arm: dts: k3-*-binman.dtsi: Clean up and templatize
 boot binaries
Message-ID: <20240326122723.f2dwxggu7yop7jf2@booted>
References: <20240322131011.1029620-1-n-francis@ti.com>
 <20240322131011.1029620-4-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240322131011.1029620-4-n-francis@ti.com>
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

On 18:40-20240322, Neha Malcom Francis wrote:
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
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  | 161 +---------
>  arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 291 +----------------
>  arch/arm/dts/k3-am625-r5-beagleplay.dts       |  39 ---
>  arch/arm/dts/k3-am625-sk-binman.dtsi          | 148 +--------
>  arch/arm/dts/k3-am625-sk-u-boot.dtsi          |  42 +++
>  .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 296 +-----------------
>  arch/arm/dts/k3-am62a-sk-binman.dtsi          | 146 +--------
>  arch/arm/dts/k3-am62a7-sk-u-boot.dtsi         |  42 +++
>  arch/arm/dts/k3-am642-evm-u-boot.dtsi         |  42 +++
>  arch/arm/dts/k3-am642-sk-u-boot.dtsi          |  42 +++
>  arch/arm/dts/k3-am64x-binman.dtsi             | 239 +-------------
>  arch/arm/dts/k3-am654-base-board-u-boot.dtsi  |  49 +++
>  arch/arm/dts/k3-am65x-binman.dtsi             | 144 +--------
>  .../arm/dts/k3-am68-sk-base-board-u-boot.dtsi |  26 ++
>  arch/arm/dts/k3-am69-sk-u-boot.dtsi           |  31 +-
>  arch/arm/dts/k3-binman.dtsi                   |  96 ++++++
>  arch/arm/dts/k3-j7200-binman.dtsi             | 145 +--------
>  .../k3-j7200-common-proc-board-u-boot.dtsi    |  40 +++
>  .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   | 154 +--------
>  arch/arm/dts/k3-j721e-binman.dtsi             | 262 +++-------------
>  .../k3-j721e-common-proc-board-u-boot.dtsi    |  84 +++++
>  arch/arm/dts/k3-j721e-r5-beagleboneai64.dts   |  91 +-----
>  arch/arm/dts/k3-j721e-sk-u-boot.dtsi          |  84 +++++
>  arch/arm/dts/k3-j721s2-binman.dtsi            | 231 +-------------
>  .../k3-j721s2-common-proc-board-u-boot.dtsi   |  42 +++
>  arch/arm/dts/k3-j784s4-binman.dtsi            | 154 +--------
>  arch/arm/dts/k3-j784s4-evm-u-boot.dtsi        |  42 +++
>  27 files changed, 858 insertions(+), 2305 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> index cca0f44b7d8..fc1898f1510 100644
> --- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> @@ -6,7 +6,11 @@
>   * Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
>   */
>  
> -#include "k3-binman.dtsi"
> +#define SPL_BOARD_DTB "spl/dts/k3-am625-beagleplay.dtb"
> +#define BOARD_DESCRIPTION "k3-am625-beagleplay"
> +#define UBOOT_BOARD_DESCRIPTION "U-Boot for AM625 BeaglePlay"
> +
> +#include "k3-am625-sk-binman.dtsi"

Drop the "sk" ?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73235D111A0
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 04:44:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6DA7890F8;
	Mon,  4 Nov 2024 05:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W2OrBxT6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D01F9890F8; Mon,  4 Nov 2024 05:44:05 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6E5D8915F
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 05:44:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A44hvmv120858;
 Sun, 3 Nov 2024 22:43:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1730695437;
 bh=Xhiw17fsh712o2lb0wXoR8fBoeRDDT04AJ2ZEmmQMyo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=W2OrBxT6cCETryFX2/9iPEnvQmUGE1n5x0j5X2tkd22n9NGTkj6J2cetSz9tAmBGm
 NY4sAx+vXkFWyc3OUodxDc2xYdsB+KHwOehqoCrKO8VurwQURbRqkb5q8v4B5hLBLJ
 DKzZv5jN+1NZVoHWFDr6oCG2gIELZcFESs3Ua2Qc=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A44hvQj091467
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 3 Nov 2024 22:43:57 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 3
 Nov 2024 22:43:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 3 Nov 2024 22:43:57 -0600
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A44hsPI117038;
 Sun, 3 Nov 2024 22:43:55 -0600
Message-ID: <c448ab28-9968-4222-97bd-ed5eacf35498@ti.com>
Date: Mon, 4 Nov 2024 10:13:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm: dts: k3-am642-phycore-som-binman: Add SoM
 overlays
To: Wadim Egorov <w.egorov@phytec.de>, <trini@konsulko.com>, <afd@ti.com>,
 <d-gole@ti.co>, <sjg@chromium.org>
CC: <d.schultz@phytec.de>, <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
References: <20241030164815.1763506-1-w.egorov@phytec.de>
 <20241030164815.1763506-6-w.egorov@phytec.de>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20241030164815.1763506-6-w.egorov@phytec.de>
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

On 30/10/24 22:18, Wadim Egorov wrote:
> Include SoM dt-overlays that handle variants of our SoMs into
> u-boot's FIT image.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>   arch/arm/dts/k3-am642-phycore-som-binman.dtsi | 54 ++++++++++++++++++-
>   1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
> index dd0967079b6..88d6c40e95c 100644
> --- a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
> +++ b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
> @@ -344,6 +344,54 @@
>   					description = "U-Boot for AM64 board";
>   				};
>   
> +				som-no-rtc {
> +					description = "k3-am6xx-phycore-disable-rtc";
> +					type = "flat_dt";
> +					compression = "none";
> +					load = <0x8F000000>;
> +					arch = "arm";
> +
> +					blob-ext {
> +						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-rtc.dtbo";
> +					};
> +				};
> +
> +				som-no-spi {
> +					description = "k3-am6xx-phycore-disable-spi-nor";
> +					type = "flat_dt";
> +					compression = "none";
> +					load = <0x8F001000>;
> +					arch = "arm";
> +
> +					blob-ext {
> +						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-spi-nor.dtbo";
> +					};
> +				};
> +
> +				som-no-eth {
> +					description = "k3-am6xx-phycore-disable-eth-phy";
> +					type = "flat_dt";
> +					compression = "none";
> +					load = <0x8F002000>;
> +					arch = "arm";
> +
> +					blob-ext {
> +						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-eth-phy.dtbo";
> +					};
> +				};
> +
> +				som-qspi {
> +					description = "k3-am6xx-phycore-qspi-nor";
> +					type = "flat_dt";
> +					compression = "none";
> +					load = <0x8F003000>;
> +					arch = "arm";
> +
> +					blob-ext {
> +						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-qspi-nor.dtbo";
> +					};
> +				};
> +
>   				fdt-0 {
>   					description = "k3-am642-phyboard-electra-rdk";
>   					type = "flat_dt";
> @@ -368,7 +416,11 @@
>   				conf-0 {
>   					description = "k3-am642-phyboard-electra-rdk";
>   					firmware = "uboot";
> -					loadables = "uboot";
> +					loadables = "uboot",
> +						    "som-no-rtc",
> +						    "som-no-spi",
> +						    "som-no-eth",
> +						    "som-qspi";
>   					fdt = "fdt-0";
>   				};
>   			};

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis

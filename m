Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1E1C48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 05:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54DA487F4B;
	Tue, 20 Feb 2024 06:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pFUqqIdC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9D1187F60; Tue, 20 Feb 2024 06:17:26 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8496087F3F
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 06:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41K5H6rt114324;
 Mon, 19 Feb 2024 23:17:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708406226;
 bh=HnEeoApseNvCbcVyeoJ4lmx2BLhd9Lo3S3HBOBHQNO8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=pFUqqIdCkS65GJCXYP9b5d+Cdltd8e8N1qhUJ7DmCcx0niECG2j2aXWONeHW87Rkc
 R2km2y+iQ+N+C6kf9UuSLbE0VefZdwzxqf1JK9pHaqEmqjVsfysuiLK2cEqoj2yOLF
 1fxD4PKwUeusQNEKR1bMFBDKtiUxr4tIiVLSluhg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41K5H6dm046542
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 19 Feb 2024 23:17:06 -0600
Received: from lewvowa01.ent.ti.com (10.180.75.79) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Feb 2024 23:17:06 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by lewvowa01.ent.ti.com
 (10.180.75.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Mon, 19 Feb
 2024 23:17:06 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Feb 2024 23:17:06 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41K5H4K5032457;
 Mon, 19 Feb 2024 23:17:05 -0600
Message-ID: <00d656a1-52f2-4f69-a2dc-6e98347780b2@ti.com>
Date: Tue, 20 Feb 2024 10:47:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3-am625-verdin-r5: Change CPU frequency to
 1000MHz
Content-Language: en-US
To: Vitor Soares <ivitro@gmail.com>, <marcel.ziswiler@toradex.com>,
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Vitor Soares <vitor.soares@toradex.com>
References: <20240219123408.22054-1-ivitro@gmail.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20240219123408.22054-1-ivitro@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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



On 19/02/24 18:04, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> The same U-Boot binary is compatible with multiple Verdin AM62 board
> variants. However, some of the SoC models can only operate at a maximum
> speed of 1 GHz.
> 
> Previously, the boards with lower-speed grades were running at
> overclocked speeds, leading to kernel complaints about unsupported
> configurations.
> 
> To resolve this issue, the operating speed has been decreased to the
> maximum allowable value across all Verdin AM62 board variants. As a
> result, there is a regression in overall boot time, increasing by around
> 200 milliseconds for the faster SoC variant.
> 

Patch as such is fine. But one way to avoid boot regression is to fixup
the clock freq using based on speed grade identified by
k3_get_speed_grade() and freq mapping table for each letter as show in
datasheet [0]

This may need VDD_CORE voltage information via PMIC driver. Even w/o
that could at least bump to 1.25Ghz safely.

[0] https://www.ti.com/lit/ds/symlink/am625.pdf
Table 7-1. Device Speed Grades


> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> ---
>  arch/arm/dts/k3-am625-verdin-r5.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/k3-am625-verdin-r5.dts b/arch/arm/dts/k3-am625-verdin-r5.dts
> index 305d199678..6b03e7405a 100644
> --- a/arch/arm/dts/k3-am625-verdin-r5.dts
> +++ b/arch/arm/dts/k3-am625-verdin-r5.dts
> @@ -23,7 +23,7 @@
>  		 */
>  		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>, <&k3_clks 157 20>;
>  		assigned-clock-parents = <&k3_clks 61 2>, <0>, <&k3_clks 157 22>;
> -		assigned-clock-rates = <200000000>, <1200000000>, <25000000>;
> +		assigned-clock-rates = <200000000>, <1000000000>, <25000000>;
>  		clocks = <&k3_clks 61 0>;
>  		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
>  				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,

-- 
Regards
Vignesh

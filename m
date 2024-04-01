Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575F9CD1288
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 17:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4DF787837;
	Mon,  1 Apr 2024 19:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZZKlk9Lm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CF668772A; Mon,  1 Apr 2024 19:04:44 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 724648830F
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 19:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 431H4eVE077537;
 Mon, 1 Apr 2024 12:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711991080;
 bh=MRjWe+Om3d4q7eXw5kHh8nEbDmaELdjOc3dc6LbpwWM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ZZKlk9LmB4d1tL2TgDwxdUJHPrM9jQCVG0eDPn7SB+wOHPAmCGXmnAq2eD0a3ggUi
 R//pesdI2NOw9BWj0pQOeVN9fzddNAjXPiXB7H+9qTdlSb3vbyzNj5Jp2umdv+Ojs3
 BEHcs9w1Erf9StkDG7EN7qjp195C++OLDEVygNt0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 431H4etK075380
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 1 Apr 2024 12:04:40 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Apr 2024 12:04:39 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Apr 2024 12:04:40 -0500
Received: from [10.249.129.130] ([10.249.129.130])
 by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 431H4auS124500;
 Mon, 1 Apr 2024 12:04:36 -0500
Message-ID: <931f832e-02ae-4610-a5e2-5c26c7d8a6fb@ti.com>
Date: Mon, 1 Apr 2024 22:34:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arch: arm: dts: k3-j721s2-r5: Override ospi and fss
 for 32-bit mode
To: Manorit Chawdhry <m-chawdhry@ti.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, Prasanth Mantena
 <p-mantena@ti.com>
References: <20240401-b4-upstream-j721s2-ospi-support-v1-0-20e4a0024db9@ti.com>
 <20240401-b4-upstream-j721s2-ospi-support-v1-2-20e4a0024db9@ti.com>
Content-Language: en-US
From: Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20240401-b4-upstream-j721s2-ospi-support-v1-2-20e4a0024db9@ti.com>
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


On 01/04/24 11:16, Manorit Chawdhry wrote:
> R5 being a 32-bit processor can't understand the 64-bit mapping being
> done in ospi node. Override the ospi node for 32-bit register ranges and
> the fss node ( the parent node of ospi ) to map the ranges for the
> updated child node correctly.
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   arch/arm/dts/k3-j721s2-r5-common-proc-board.dts | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> index 03bd680f4421..5c4b34915ccf 100644
> --- a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> @@ -86,3 +86,16 @@
>   &mcu_udmap {
>   	ti,sci = <&dm_tifs>;
>   };
> +
> +&ospi0 {
> +		reg = <0x0 0x47040000 0x0 0x100>,
> +			  <0x0 0x50000000 0x0 0x8000000>;
> +};
> +
> +&fss {
> +	/* fss node has 64 bit address regions mapped to it and since the ospi
> +	 * nodes is being override, override the fss node ranges as well
> +	 */
> +	ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x00068400>,
> +			 <0x0 0x50000000 0x0 0x50000000 0x0 0x08000000>;
> +};
>

Reviewed-by: Apurva Nandan <a-nandan@ti.com>

-- 
Thanks and regards,
Apurva Nandan,
Texas Instruments India.


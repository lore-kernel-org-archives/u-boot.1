Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56606C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 18:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6D2F87943;
	Tue,  2 Jan 2024 19:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TrRtFo84";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9BBD87952; Tue,  2 Jan 2024 19:51:15 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5285A8793C
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 19:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 402Ip7L0019513;
 Tue, 2 Jan 2024 12:51:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704221467;
 bh=lQMR05LaGdQWKFoDtlLB0wesInNjqyg6/jmlpuD2TJ8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=TrRtFo84BQC1WEtckJrrqo1Le64ChNBNN0jamQAzOOzk2N3x7XLOoQvk6a7oaLmc5
 6H1pg02O16tnrbVs1CbiF9s4PyB9/e8ZlA+zhV0D4rNHXc0HMTyjYQvN/lqp5tFaV1
 h8y3ORkvr6jOBtFMGAcDFTR7z041Z9N/ZYKmywPM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 402Ip7lA090717
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 2 Jan 2024 12:51:07 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jan 2024 12:51:07 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jan 2024 12:51:07 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 402Ip7aI119448;
 Tue, 2 Jan 2024 12:51:07 -0600
Date: Tue, 2 Jan 2024 12:51:07 -0600
From: Nishanth Menon <nm@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: Tom Rini <trini@konsulko.com>, UBoot Mailing List <u-boot@lists.denx.de>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Martyn
 Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon Glass
 <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2 12/26] arm: dts: k3-am654: add needed regs to udmap
 nodes
Message-ID: <20240102185107.flha2chakmeh7chk@quadrant>
References: <20231229174656.634065-28-bb@ti.com>
 <20231229174656.634065-40-bb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231229174656.634065-40-bb@ti.com>
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

On 11:47-20231229, Bryan Brattlof wrote:
> Ethernet is one of a few IPs in U-Boot that depend on DMA to operate.
> However there are a few missing registers ranges in the udmap nodes
> need to properly setup DMA for the am65x.
> 
> A fix has been added to the Linux kernel[0] to add these ranges however
> they have not made it to a Linux tag. To keep DMA operational until the
> next DT sync from Linux, add these ranges to the *-u-boot.dtsi with a
> note for our future selves.
> 
> [0] https://lore.kernel.org/r/20231213135138.929517-2-vigneshr@ti.com
> 
> Tested-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  arch/arm/dts/k3-am654-base-board-u-boot.dtsi | 34 ++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
> index a008af5b4a047..a24cb895e5578 100644
> --- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
> @@ -252,3 +252,37 @@
>  &mcu_r5fss0 {
>  	ti,cluster-mode = <0>;
>  };
> +
> +/*
> + * The DMA driver requires a few extra register ranges
> + * which are missing for the am65x. A patch has been
> + * sent and will be synced after the v6.8-rc1 linux
> + * tag is published
> + */
> +&main_udmap {
> +	reg = <0x0 0x31150000 0x0 0x100>,
> +	      <0x0 0x34000000 0x0 0x100000>,
> +	      <0x0 0x35000000 0x0 0x100000>,
> +	      <0x0 0x30b00000 0x0 0x10000>,
> +	      <0x0 0x30c00000 0x0 0x10000>,
> +	      <0x0 0x30d00000 0x0 0x8000>;
> +	reg-names = "gcfg", "rchanrt", "tchanrt",
> +		    "tchan", "rchan", "rflow";
> +};
> +
> +/*
> + * The DMA driver requires a few extra register ranges
> + * which are missing for the am65x. A patch has been
> + * sent and will be synced after the v6.8-rc1 linux
> + * tag is published
> + */
> +&mcu_udmap {
> +	reg = <0x0 0x285c0000 0x0 0x100>,
> +	      <0x0 0x2a800000 0x0 0x40000>,
> +	      <0x0 0x2aa00000 0x0 0x40000>,
> +	      <0x0 0x284a0000 0x0 0x4000>,
> +	      <0x0 0x284c0000 0x0 0x4000>,
> +	      <0x0 0x28400000 0x0 0x2000>;
> +	reg-names = "gcfg", "rchanrt", "tchanrt",
> +		    "tchan", "rchan", "rflow";
> +};

Hopefully we can get rid of this in 6.8-rc1 sync.

[...]
Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

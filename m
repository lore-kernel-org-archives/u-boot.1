Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A826C0218F
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 06:22:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1286A80F9E;
	Mon, 27 Jan 2025 07:22:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nxGK/BdB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F96E80FC4; Mon, 27 Jan 2025 07:22:12 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CF6680F96
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 07:22:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50R6M3QV1742515
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2025 00:22:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1737958923;
 bh=fiWftjm54osPkWhsovvP55K75BDJspjORKwH8CGV9QA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=nxGK/BdB+zH2uBIdycMxqNtlRyqc8yCafuBhfxZBiTZJJ634/YIfNg8sb4xBno2Ju
 2tUd8Hj2yMlFmaUm0CYwol4N4TbF6nBJ/odRK4r+DbEcwi8I6FEi+saY+euaIqSrFL
 AUwqSmWg0EwD+rFjBpsnQOPyf5IVo5VTUYK48qds=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50R6M3oF047623
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Jan 2025 00:22:03 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Jan 2025 00:22:02 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Jan 2025 00:22:02 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50R6M292026368;
 Mon, 27 Jan 2025 00:22:02 -0600
Date: Mon, 27 Jan 2025 11:52:01 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <trini@konsulko.com>, 
 <n-francis@ti.com>, <nmorrisson@phytec.com>, <d.schultz@phytec.de>,
 <sjg@chromium.org>
Subject: Re: [PATCH 1/3] arch: arm: dts: phyboard-electra-uboot.dtsi: Add
 bootph props to i2c
Message-ID: <20250127062201.yvjpnf3vf36c4mf2@lcpd911>
References: <20250127041612.985929-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250127041612.985929-1-w.egorov@phytec.de>
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

Hi Wadim,

On Jan 27, 2025 at 05:16:10 +0100, Wadim Egorov wrote:
> Add bootph-all properties to I2C0 nodes to ensure the bus and EEPROM
> are accessible across all stages. This enables reading the SoM
> configuration at any point during the boot process.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
> index 8f3c3a185ae..c68a48678a2 100644
> --- a/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
> @@ -72,6 +72,14 @@
>  	bootph-all;
>  };
>  
> +&main_i2c0 {
> +	bootph-all;
> +};
> +
> +&main_i2c0_pins_default {
> +	bootph-all;
> +};
> +

Can we not add the bootph-all property in the kernel DT nodes for this?
Also, I don't see main_i2c0 in the kernel DTS file for this[1] platform. Is
there a particular reason to not put it there?

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts


-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

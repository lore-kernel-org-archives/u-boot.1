Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB24C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 13:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08E9C80C93;
	Mon, 16 Jun 2025 15:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bAD0t/6h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A9C281760; Mon, 16 Jun 2025 15:57:33 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BA688070C
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 15:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55GDvPoh3828682;
 Mon, 16 Jun 2025 08:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750082245;
 bh=MsOAC2JTojsoMQJayVlmM+574w0En/jcVa7VQd3Un3o=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=bAD0t/6hOGVfqVEh7WZjelaOmzvhEBQ9ClekyMIqDK5OlqsKjGsUxNY5FRF9e1RIP
 A4UOojJe88cbqbNsVCzVxzZZjWBTrDUtKUTwlQFFjm9/xwN0tGRvez+d8ozbmriNwl
 3ejEdzjBmYlGX0ecpOQnnVbVxi/KRGfck/xsUxww=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55GDvPr32704120
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 16 Jun 2025 08:57:25 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 16
 Jun 2025 08:57:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 16 Jun 2025 08:57:24 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55GDvO8h4172981;
 Mon, 16 Jun 2025 08:57:24 -0500
Date: Mon, 16 Jun 2025 08:57:24 -0500
From: Bryan Brattlof <bb@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Sumit
 Garg <sumit.garg@kernel.org>, Robert Nelson <robertcnelson@gmail.com>, Tom
 Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Kevin Hilman
 <khilman@baylibre.com>, Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur
 <a-kaur@ti.com>, Kendall Willis <k-willis@ti.com>, Sebin Francis
 <sebin.francis@ti.com>, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v2 03/22] ram: k3-ddrss: Add support for DDR in
 self-refresh
Message-ID: <20250616135724.tutpbgb2wj7xdg43@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
 <20250613-topic-am62-ioddr-v2025-04-rc1-v2-3-3d233aaea355@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-3-3d233aaea355@baylibre.com>
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

On June 13, 2025 thus sayeth Markus Schneider-Pargmann:
> In IO+DDR the DDR is kept in self-refresh while the SoC cores are
> powered off completely. During boot the normal initialization routine of
> DDR is slightly different to exit self-refresh and keep the DDR contents.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  drivers/ram/k3-ddrss/k3-ddrss.c | 165 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 165 insertions(+)
> 
> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
> index ff87faf6a22419e54d3639817ad2b884a97a3911..d7ae6e9ef24d5aebdb61656e6ca797b1799ca0f6 100644
> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c

...

> +
> +static void k3_ddrss_lpm_resume(struct k3_ddrss_desc *ddrss)
> +{
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_CTL_160,
> +				 K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_MASK,
> +				 K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_ENTRY);
> +	while (!(readl(ddrss->ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_CTL_345) &
> +		 (1 << K3_DDRSS_CFG_DENALI_CTL_345_INT_STATUS_LOWPOWER_SHIFT)))
> +		;

Can we use the wait_for_bit_* logic here?

> +
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_CTL_353,
> +				 0,
> +				 1 << K3_DDRSS_CFG_DENALI_CTL_353_INT_ACK_LOWPOWER_SHIFT);
> +	while ((readl(ddrss->ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_CTL_169) &
> +		K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_MASK) !=
> +	       0x40 << K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_SHIFT)
> +		;

I know DRAM is so early on in the bringup that we'll probably have a 
debugger nearby already but just having an error message to grep for 
could really help if the controller never acknowledges this.

~Bryan

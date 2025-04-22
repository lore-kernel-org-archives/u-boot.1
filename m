Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A707BC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 10:19:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F50C80FEC;
	Tue, 22 Apr 2025 12:19:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wlFpcCdu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5120810E8; Tue, 22 Apr 2025 12:19:50 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E991C80F9C
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 12:19:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53MAJjlB1191528
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 05:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745317185;
 bh=l3wnaF3mvhQArWQzsxpFKSqk1/PWiR7FiAfOO0la9Ho=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=wlFpcCdulTp7zr8RrWR6BBVVwHUT2f6mSuMgiXUQIQZJHIb3z/6qYZiY1YlIbwOvO
 l4NDc4ftat91/LuQErAONo8kB+WgmvVW6xV5YzbfrLi5PAwQTvGvP12f65FyQfJpGe
 j8MS+p+sT1OEW2sj0BSUKOMJ661DJ5uvaSRaCDks=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53MAJj7Q072394
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Apr 2025 05:19:45 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 05:19:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 05:19:44 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53MAJhX5104446;
 Tue, 22 Apr 2025 05:19:44 -0500
Date: Tue, 22 Apr 2025 15:49:43 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Hrushikesh Salunke <h-salunke@ti.com>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <j-humphreys@ti.com>, <jm@ti.com>,
 <sjg@chromium.org>, <s-k6@ti.com>, <n-francis@ti.com>,
 <rogerq@kernel.org>, <danishanwar@ti.com>, <s-vadapalli@ti.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH 2/3] pci: pcie_cdns_ti: Enable PCIe root-complex mode in
 AM64 SoC
Message-ID: <cd91589d-0f4e-489d-9df6-1f144e08caad@ti.com>
References: <20250416120830.138965-1-h-salunke@ti.com>
 <20250416120830.138965-3-h-salunke@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250416120830.138965-3-h-salunke@ti.com>
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

On Wed, Apr 16, 2025 at 05:38:29PM +0530, Hrushikesh Salunke wrote:
> TI's AM64 SoC has single instance of PCIe Controller namely PCIe0 which
> is Cadence PCIe Controller. Add support to configure PCIe0 in Root-
> Complex mode of operation.
> 
> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

> ---
>  drivers/pci/pcie_cdns_ti.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/pcie_cdns_ti.c b/drivers/pci/pcie_cdns_ti.c
> index e5bcc6eb53e..9d1d123a18c 100644
> --- a/drivers/pci/pcie_cdns_ti.c
> +++ b/drivers/pci/pcie_cdns_ti.c
> @@ -835,11 +835,21 @@ static const struct pcie_cdns_ti_data j7200_pcie_rc_data = {
>  	.max_lanes = 2,
>  };
>  
> +static const struct pcie_cdns_ti_data am64_pcie_rc_data = {
> +	.mode = PCIE_MODE_RC,
> +	.quirk_detect_quiet_flag = true,
> +	.max_lanes = 1,
> +};
> +
>  static const struct udevice_id pcie_cdns_ti_ids[] = {
>  	{
>  		.compatible = "ti,j7200-pcie-host",
>  		.data = (ulong)&j7200_pcie_rc_data,
>  	},
> +	{
> +		.compatible = "ti,am64-pcie-host",
> +		.data = (ulong)&am64_pcie_rc_data,
> +	},
>  	{},
>  };

Regards,
Siddharth.

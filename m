Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE02C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 05:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C094C8811C;
	Fri, 10 May 2024 07:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nezhkaGp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67845881A6; Fri, 10 May 2024 07:46:19 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B571A880A1
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 07:46:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44A5kFvB079925;
 Fri, 10 May 2024 00:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715319975;
 bh=K3945RSuCv/LEwTazyzb5JpYc+qk2JuSLVd6FOlZ4oY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=nezhkaGpeYeq1crGlKVkNeVAftKRdyyPpGezb8cTKZiCurK9pZVjK1n4cIKeGRMJp
 zj2rkU1Y86FDcZ2/v03btrCNDQs1puImajWKnIuVsRura5eBEA3pbwhJiygMTxEr7p
 3MATjfHZAkIIRSCPVLFeh54xUvcxsNEuNR6+bIZA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44A5kEG2059468
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 10 May 2024 00:46:14 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 May 2024 00:46:14 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 May 2024 00:46:14 -0500
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193] (may be
 forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44A5kBDM112284;
 Fri, 10 May 2024 00:46:12 -0500
Message-ID: <0171842f-1d12-9af6-fc8f-021a6a2229e1@ti.com>
Date: Fri, 10 May 2024 11:16:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] remoteproc: k3-dsp: Enable C71x support for AM62A
Content-Language: en-US
To: Hari Nagalla <hnagalla@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <afd@ti.com>, <b-padhi@ti.com>, <u-boot@lists.denx.de>
CC: <u-kumar1@ti.com>, <praneeth@ti.com>
References: <20240509142037.32064-1-hnagalla@ti.com>
 <20240509142037.32064-2-hnagalla@ti.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20240509142037.32064-2-hnagalla@ti.com>
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



On 09/05/24 19:50, Hari Nagalla wrote:
> AM62A SoC has a single C71x DSP subsystem with analytics engine in
> main voltage domain. Extend support to AM62A with compatible strings.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh
> ---
>  drivers/remoteproc/ti_k3_dsp_rproc.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_dsp_rproc.c b/drivers/remoteproc/ti_k3_dsp_rproc.c
> index e790406324..ed13729c33 100644
> --- a/drivers/remoteproc/ti_k3_dsp_rproc.c
> +++ b/drivers/remoteproc/ti_k3_dsp_rproc.c
> @@ -339,7 +339,8 @@ static int k3_dsp_of_get_memories(struct udevice *dev)
>  	for (i = 0; i < dsp->num_mems; i++) {
>  		/* C71 cores only have a L1P Cache, there are no L1P SRAMs */
>  		if (((device_is_compatible(dev, "ti,j721e-c71-dsp")) ||
> -		     (device_is_compatible(dev, "ti,j721s2-c71-dsp"))) &&
> +		    (device_is_compatible(dev, "ti,j721s2-c71-dsp")) ||
> +		    (device_is_compatible(dev, "ti,am62a-c7xv-dsp"))) &&
>  		    !strcmp(mem_names[i], "l1pram")) {
>  			dsp->mem[i].bus_addr = FDT_ADDR_T_NONE;
>  			dsp->mem[i].dev_addr = FDT_ADDR_T_NONE;
> @@ -347,7 +348,14 @@ static int k3_dsp_of_get_memories(struct udevice *dev)
>  			dsp->mem[i].size = 0;
>  			continue;
>  		}
> -
> +		if (device_is_compatible(dev, "ti,am62a-c7xv-dsp") &&
> +		    !strcmp(mem_names[i], "l1dram")) {
> +			dsp->mem[i].bus_addr = FDT_ADDR_T_NONE;
> +			dsp->mem[i].dev_addr = FDT_ADDR_T_NONE;
> +			dsp->mem[i].cpu_addr = NULL;
> +			dsp->mem[i].size = 0;
> +			continue;
> +		}
>  		dsp->mem[i].bus_addr = dev_read_addr_size_name(dev, mem_names[i],
>  					  (fdt_addr_t *)&dsp->mem[i].size);
>  		if (dsp->mem[i].bus_addr == FDT_ADDR_T_NONE) {
> @@ -459,6 +467,7 @@ static const struct udevice_id k3_dsp_ids[] = {
>  	{ .compatible = "ti,j721e-c66-dsp", .data = (ulong)&c66_data, },
>  	{ .compatible = "ti,j721e-c71-dsp", .data = (ulong)&c71_data, },
>  	{ .compatible = "ti,j721s2-c71-dsp", .data = (ulong)&c71_data, },
> +	{ .compatible = "ti,am62a-c7xv-dsp", .data = (ulong)&c71_data, },
>  	{}
>  };
>  

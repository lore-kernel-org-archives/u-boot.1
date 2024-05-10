Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D2AC25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 12:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 298AB880E5;
	Fri, 10 May 2024 14:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="L6h19tfe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 798F3880E5; Fri, 10 May 2024 14:21:02 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 080C2880A8
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 14:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ACKw0T052695;
 Fri, 10 May 2024 07:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715343658;
 bh=EOqGD/5eDiASjLGClvex89RWtJN91ncb4cO3SDzGILQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=L6h19tfeDRrpc5o9xxDlkTMDmJ41k00m0BOiBRqmHGzKEMXvrgulIOjMiY3cvWT+J
 YUjwVFdHIS8rQ7cfmRDo3oFyRuEuLy8E8Jfq26Da/RcTIT6SLVwWWZ5UuwocOuJPr6
 M5tRhJyy86AfmhMy0oqZcWU+60G2QNGa5MnXQCx0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ACKweO019129
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 10 May 2024 07:20:58 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 May 2024 07:20:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 May 2024 07:20:58 -0500
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193] (may be
 forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ACKsrI088805;
 Fri, 10 May 2024 07:20:55 -0500
Message-ID: <5aa67dc0-c30f-a604-2432-b0f791f4981c@ti.com>
Date: Fri, 10 May 2024 17:50:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] remoteproc: k3-r5: Add support for R5F core on AM62A
 SoCs
Content-Language: en-US
To: Hari Nagalla <hnagalla@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <afd@ti.com>, <b-padhi@ti.com>, <u-boot@lists.denx.de>
CC: <u-kumar1@ti.com>, <praneeth@ti.com>
References: <20240509142037.32064-1-hnagalla@ti.com>
 <20240509142037.32064-3-hnagalla@ti.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20240509142037.32064-3-hnagalla@ti.com>
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
> AM62A has a R5F core in MCU voltage domain.
> Extend support for R5F remote proc driver on AM62A with compatible
> strings.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh

> ---
>  drivers/remoteproc/ti_k3_r5f_rproc.c | 29 ++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
> index 631e548dcc..35835b2d61 100644
> --- a/drivers/remoteproc/ti_k3_r5f_rproc.c
> +++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
> @@ -40,6 +40,8 @@
>  #define PROC_BOOT_CFG_FLAG_GEN_IGN_BOOTVECTOR		0x10000000
>  /* Available from J7200 SoCs onwards */
>  #define PROC_BOOT_CFG_FLAG_R5_MEM_INIT_DIS		0x00004000
> +#define PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE		0x00008000
> +
>  
>  /* R5 TI-SCI Processor Control Flags */
>  #define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT		0x00000001
> @@ -55,6 +57,8 @@
>  enum cluster_mode {
>  	CLUSTER_MODE_SPLIT = 0,
>  	CLUSTER_MODE_LOCKSTEP,
> +	CLUSTER_MODE_SINGLECPU,
> +	CLUSTER_MODE_SINGLECORE,
>  };
>  
>  /**
> @@ -65,6 +69,7 @@ enum cluster_mode {
>  struct k3_r5f_ip_data {
>  	bool tcm_is_double;
>  	bool tcm_ecc_autoinit;
> +	bool is_single_core;
>  };
>  
>  /**
> @@ -599,8 +604,10 @@ static int k3_r5f_rproc_configure(struct k3_r5f_core *core)
>  	/* Sanity check for Lockstep mode */
>  	lockstep_permitted = !!(sts &
>  				PROC_BOOT_STATUS_FLAG_R5_LOCKSTEP_PERMITTED);
> -	if (cluster->mode && is_primary_core(core) && !lockstep_permitted) {
> -		dev_err(core->dev, "LockStep mode not permitted on this device\n");
> +	if (cluster->mode == CLUSTER_MODE_LOCKSTEP && is_primary_core(core) &&
> +	    !lockstep_permitted) {
> +		dev_err(core->dev, "LockStep mode not permitted on this \
> +			device\n");
>  		ret = -EINVAL;
>  		goto out;
>  	}
> @@ -615,6 +622,9 @@ static int k3_r5f_rproc_configure(struct k3_r5f_core *core)
>  			clr_cfg |= PROC_BOOT_CFG_FLAG_R5_LOCKSTEP;
>  	}
>  
> +	if (core->ipdata->is_single_core)
> +		set_cfg = PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE;
> +
>  	if (core->atcm_enable)
>  		set_cfg |= PROC_BOOT_CFG_FLAG_R5_ATCM_EN;
>  	else
> @@ -853,11 +863,19 @@ static int k3_r5f_remove(struct udevice *dev)
>  static const struct k3_r5f_ip_data k3_data = {
>  	.tcm_is_double = false,
>  	.tcm_ecc_autoinit = false,
> +	.is_single_core = false,
>  };
>  
>  static const struct k3_r5f_ip_data j7200_j721s2_data = {
>  	.tcm_is_double = true,
>  	.tcm_ecc_autoinit = true,
> +	.is_single_core = false,
> +};
> +
> +static const struct k3_r5f_ip_data am62_data = {
> +	.tcm_is_double = false,
> +	.tcm_ecc_autoinit = false,
> +	.is_single_core = true,
>  };
>  
>  static const struct udevice_id k3_r5f_rproc_ids[] = {
> @@ -865,6 +883,7 @@ static const struct udevice_id k3_r5f_rproc_ids[] = {
>  	{ .compatible = "ti,j721e-r5f", .data = (ulong)&k3_data, },
>  	{ .compatible = "ti,j7200-r5f", .data = (ulong)&j7200_j721s2_data, },
>  	{ .compatible = "ti,j721s2-r5f", .data = (ulong)&j7200_j721s2_data, },
> +	{ .compatible = "ti,am62-r5f", .data = (ulong)&am62_data, },
>  	{}
>  };
>  
> @@ -887,6 +906,11 @@ static int k3_r5f_cluster_probe(struct udevice *dev)
>  	cluster->mode = dev_read_u32_default(dev, "ti,cluster-mode",
>  					     CLUSTER_MODE_LOCKSTEP);
>  
> +	if (device_is_compatible(dev, "ti,am62-r5fss")) {
> +		cluster->mode = CLUSTER_MODE_SINGLECORE;
> +		return 0;
> +	}
> +
>  	if (device_get_child_count(dev) != 2) {
>  		dev_err(dev, "Invalid number of R5 cores");
>  		return -EINVAL;
> @@ -903,6 +927,7 @@ static const struct udevice_id k3_r5fss_ids[] = {
>  	{ .compatible = "ti,j721e-r5fss"},
>  	{ .compatible = "ti,j7200-r5fss"},
>  	{ .compatible = "ti,j721s2-r5fss"},
> +	{ .compatible = "ti,am62-r5fss"},
>  	{}
>  };
>  

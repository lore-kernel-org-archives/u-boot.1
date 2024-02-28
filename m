Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FE4C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 06:25:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0874A87E50;
	Wed, 28 Feb 2024 07:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WlRoAdA6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08BF987E28; Wed, 28 Feb 2024 07:25:03 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A63187F95
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 07:25:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41S6OvFl031114;
 Wed, 28 Feb 2024 00:24:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709101497;
 bh=QyUvdQdW/JTnv/cScZzohbzusGalaawHBxpl0a1rGg0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=WlRoAdA66v3KV4n1F55QOFpvbCJoMo/+lsh74J/EzQzpY8DEBzQoGaZXWydo5lfYK
 NcnDE6hdiz6DrI5dH1Z+RHl9NIVcnXj23EYVvDDd+xSfyP7z+02LN/Wh1Q8o21roOA
 M2r1VeWPGRlaySCwQIwV7lF9s7BjdiosfBzAjHJc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41S6OvJ9032000
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 28 Feb 2024 00:24:57 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Feb 2024 00:24:57 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Feb 2024 00:24:57 -0600
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41S6Oudu013270;
 Wed, 28 Feb 2024 00:24:57 -0600
Date: Wed, 28 Feb 2024 11:54:56 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 4/6] arm: mach-k3: am62: Fixup TF-A/OP-TEE
 reserved-memory node in FDT
Message-ID: <20240228062456.2edu55i7jmnny66l@uda0497581>
References: <20240214163009.983034-1-afd@ti.com>
 <20240214163009.983034-5-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240214163009.983034-5-afd@ti.com>
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

Hi Andrew,

On 10:30-20240214, Andrew Davis wrote:
> The address we load TF-A and OP-TEE to is configurable by Kconfig
> CONFIG_K3_{ATF,OPTEE}_LOAD_ADDR, but the DT nodes reserving this memory
> are often statically defined. As these binaries are dynamically loadable,
> and in the case of OP-TEE may not even be loaded at all, hard-coding these
> addresses is not a hardware description, but rather a configuration.
> 
> If the address that U-Boot loaded TF-A or OP-TEE does not match the
> address in hard-coded in DT, then fix that node address. This also handles
> the case when no reserved memory for these is provided by DT, which is
> more correct as explained above.
> 
> Add this fixup function, and enable it for AM62.

Why are we doing it only for AM62? Assuming that this can help in other
devices as well as all the DTs ideally should have these reserved nodes
in DT?

Regards,
Manorit
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/mach-k3/am625_fdt.c  |  2 ++
>  arch/arm/mach-k3/common_fdt.c | 52 +++++++++++++++++++++++++++++++++++
>  arch/arm/mach-k3/common_fdt.h |  2 ++
>  3 files changed, 56 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/am625_fdt.c b/arch/arm/mach-k3/am625_fdt.c
> index 970dd3447de..b26186456f3 100644
> --- a/arch/arm/mach-k3/am625_fdt.c
> +++ b/arch/arm/mach-k3/am625_fdt.c
> @@ -43,6 +43,8 @@ int ft_system_setup(void *blob, struct bd_info *bd)
>  	fdt_fixup_cores_nodes_am625(blob, k3_get_core_nr());
>  	fdt_fixup_gpu_nodes_am625(blob, k3_has_gpu());
>  	fdt_fixup_pru_node_am625(blob, k3_has_pru());
> +	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
> +	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
>  
>  	return 0;
>  }
> diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
> index 645c4de42f7..3bdedd7b509 100644
> --- a/arch/arm/mach-k3/common_fdt.c
> +++ b/arch/arm/mach-k3/common_fdt.c
> @@ -112,3 +112,55 @@ int fdt_del_node_path(void *blob, const char *path)
>  
>  	return ret;
>  }
> +
> +int fdt_fixup_reserved(void *blob, const char *name,
> +		       unsigned int new_address, unsigned int new_size)
> +{
> +	int nodeoffset, subnode;
> +	int ret;
> +
> +	/* Find reserved-memory */
> +	nodeoffset = fdt_subnode_offset(blob, 0, "reserved-memory");
> +	if (nodeoffset < 0) {
> +		debug("Could not find reserved-memory node\n");
> +		return 0;
> +	}
> +
> +	/* Find existing matching subnode and remove it */
> +	fdt_for_each_subnode(subnode, blob, nodeoffset) {
> +		const char *node_name;
> +		fdt_addr_t addr;
> +		fdt_size_t size;
> +
> +		/* Name matching */
> +		node_name = fdt_get_name(blob, subnode, NULL);
> +		if (!name)
> +			return -EINVAL;
> +		if (!strncmp(node_name, name, strlen(name))) {
> +			/* Read out old size first */
> +			addr = fdtdec_get_addr_size(blob, subnode, "reg", &size);
> +			if (addr == FDT_ADDR_T_NONE)
> +				return -EINVAL;
> +			new_size = size;
> +
> +			/* Delete node */
> +			ret = fdt_del_node(blob, subnode);
> +			if (ret < 0)
> +				return ret;
> +
> +			/* Only one matching node */
> +			break;
> +		}
> +	}
> +
> +	struct fdt_memory carveout = {
> +		.start = new_address,
> +		.end = new_address + new_size - 1,
> +	};
> +	ret = fdtdec_add_reserved_memory(blob, name, &carveout, NULL, 0, NULL,
> +					 FDTDEC_RESERVED_MEMORY_NO_MAP);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> diff --git a/arch/arm/mach-k3/common_fdt.h b/arch/arm/mach-k3/common_fdt.h
> index 4d23ae638ca..52c07957483 100644
> --- a/arch/arm/mach-k3/common_fdt.h
> +++ b/arch/arm/mach-k3/common_fdt.h
> @@ -8,5 +8,7 @@
>  
>  int fdt_fixup_msmc_ram_k3(void *blob);
>  int fdt_del_node_path(void *blob, const char *path);
> +int fdt_fixup_reserved(void *blob, const char *name,
> +		       unsigned int new_address, unsigned int new_size);
>  
>  #endif /* _COMMON_FDT_H */
> -- 
> 2.39.2
> 

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60E2E8FDA6
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 10:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 302C4842FE;
	Fri, 26 Dec 2025 11:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dEyIlXjO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DB22842FE; Fri, 26 Dec 2025 11:51:19 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00BFB842F7
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 11:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6A2BD405AB;
 Fri, 26 Dec 2025 10:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00B2C4CEF7;
 Fri, 26 Dec 2025 10:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766746275;
 bh=IJofNc3vpWmgKJU1G0JEy7VfDhz/n4dKurGy2/xLHgw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dEyIlXjOe70oaB2/uwg6GUCMGdMNQHu/1qZgZSmbtZYsX5MaUSILcoT/QZCcGSv10
 t/nV0oCcjjTaGdzB003JIN4S+mHVU67OXfz302dgOEInuePtVISTSq7IGrprtB6lsw
 +Pd+ok60M0Am+gf7u8SppQr62CTPGh8IyMkxVRX1EXM/RVlIJZy9OGx+W63B+Iu0TM
 X1TPiyN1YbrscmMTAFXn01KclpbEVOsN2cY0uk+e5DBT1Xh5UqhOmU1B6hdMoKW2fF
 V1F+MLVjhwfofR6dKYdJ4W4KyeaJXE6LPn3TlVyqVk+3Fp7AQEBIQJ0qIuFI9KRJeB
 BJk0OHJYjr1lw==
Date: Fri, 26 Dec 2025 16:21:08 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, casey.connolly@linaro.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1] smem: msm: Fix memory-region lookup, direct <reg>
 mapping and update SMEM host count
Message-ID: <aU5onLOBb3f62VVB@sumit-xelite>
References: <20251112165851.1561418-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112165851.1561418-1-aswin.murugan@oss.qualcomm.com>
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

On Wed, Nov 12, 2025 at 10:28:51PM +0530, Aswin Murugan wrote:
> The SMEM driver was failing to resolve memory regions on some boards
> because `dev_of_offset()` + `fdtdec_lookup_phandle()` did not yield a
> valid DT node. Modernize the code to use driver-model/ofnode accessors
> and make the probe robust for both DT styles (direct `reg` vs
> `memory-region` phandle).
> 
> - qcom_smem_map_memory():
>   * Drop fdtdec path; use dev_read_phandle_with_args() +
>     ofnode_read_resource().
>   * Use dev_read_phandle_with_args() +
>     fnode_read_resource().
> 
> - qcom_smem_probe():
>   * Try dev_read_addr_size() first (map via <reg>), else fall back to
>     qcom_smem_map_memory() with "memory-region".
>   * Check "qcom,rpm-msg-ram" presence to add second region.
> 
> - Additionally, SMEM_HOST_COUNT is increased to support newer SMEM
>   versions that include more remote processors. This avoids failures
>   during processor ID checks.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  drivers/smem/msm_smem.c | 56 +++++++++++++++++++++++++++++------------
>  1 file changed, 40 insertions(+), 16 deletions(-)

There was an earlier effort from Casey to import SMEM driver here [1]
from Linux kernel. But unfortunately that patch-set didn't got reworked
to make into U-Boot mainline.

Casey, do you have any plans to respin the patch-set? Or it's fine for
others to take over that patch-set?

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=433987&state=*

-Sumit

> 
> diff --git a/drivers/smem/msm_smem.c b/drivers/smem/msm_smem.c
> index ccd145f9afb..b6b92d3530d 100644
> --- a/drivers/smem/msm_smem.c
> +++ b/drivers/smem/msm_smem.c
> @@ -88,7 +88,7 @@ DECLARE_GLOBAL_DATA_PTR;
>  #define SMEM_GLOBAL_HOST	0xfffe
>  
>  /* Max number of processors/hosts in a system */
> -#define SMEM_HOST_COUNT		10
> +#define SMEM_HOST_COUNT		25
>  
>  /**
>   * struct smem_proc_comm - proc_comm communication struct (legacy)
> @@ -821,23 +821,34 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
>  static int qcom_smem_map_memory(struct qcom_smem *smem, struct udevice *dev,
>  				const char *name, int i)
>  {
> -	struct fdt_resource r;
>  	int ret;
> -	int node = dev_of_offset(dev);
> +	struct ofnode_phandle_args args;
> +	struct resource r;
>  
> -	ret = fdtdec_lookup_phandle(gd->fdt_blob, node, name);
> -	if (ret < 0) {
> -		dev_err(dev, "No %s specified\n", name);
> +	if (!dev_read_prop(dev, name, NULL)) {
> +		dev_err(dev, "%s prop not found\n", name);
>  		return -EINVAL;
>  	}
>  
> -	ret = fdt_get_resource(gd->fdt_blob, ret, "reg", 0, &r);
> -	if (ret)
> -		return ret;
> +	ret = dev_read_phandle_with_args(dev, name, NULL, 0, 0, &args);
> +	if (ret) {
> +		dev_err(dev, "%s phandle read failed\n", name);
> +		return -EINVAL;
> +	}
>  
> +	if (!ofnode_valid(args.node)) {
> +		dev_err(dev, "Invalid node from phandle args\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = ofnode_read_resource(args.node, 0, &r);
> +	if (ret) {
> +		dev_err(dev, "Can't get mmap base address(%d)\n", ret);
> +		return ret;
> +	}
>  	smem->regions[i].aux_base = (u32)r.start;
> -	smem->regions[i].size = fdt_resource_size(&r);
> -	smem->regions[i].virt_base = devm_ioremap(dev, r.start, fdt_resource_size(&r));
> +	smem->regions[i].size = resource_size(&r);
> +	smem->regions[i].virt_base = devm_ioremap(dev, r.start, resource_size(&r));
>  	if (!smem->regions[i].virt_base)
>  		return -ENOMEM;
>  
> @@ -852,10 +863,14 @@ static int qcom_smem_probe(struct udevice *dev)
>  	int num_regions;
>  	u32 version;
>  	int ret;
> -	int node = dev_of_offset(dev);
> +	fdt_addr_t addr;
> +	fdt_size_t size;
> +
> +	if (__smem)
> +		return 0;
>  
>  	num_regions = 1;
> -	if (fdtdec_lookup_phandle(gd->fdt_blob, node, "qcomrpm-msg-ram") >= 0)
> +	if (dev_read_prop(dev, "qcom,rpm-msg-ram", NULL))
>  		num_regions++;
>  
>  	array_size = num_regions * sizeof(struct smem_region);
> @@ -866,9 +881,18 @@ static int qcom_smem_probe(struct udevice *dev)
>  	smem->dev = dev;
>  	smem->num_regions = num_regions;
>  
> -	ret = qcom_smem_map_memory(smem, dev, "memory-region", 0);
> -	if (ret)
> -		return ret;
> +	addr = dev_read_addr_size(dev, &size);
> +	if (addr == FDT_ADDR_T_NONE) {
> +		ret = qcom_smem_map_memory(smem, dev, "memory-region", 0);
> +		if (ret)
> +			return ret;
> +	} else {
> +		smem->regions[0].aux_base = (u32)addr;
> +		smem->regions[0].size = size;
> +		smem->regions[0].virt_base = devm_ioremap(dev, addr, size);
> +		if (!smem->regions[0].virt_base)
> +			return -ENOMEM;
> +	}
>  
>  	if (num_regions > 1) {
>  		ret = qcom_smem_map_memory(smem, dev,
> -- 
> 2.34.1
> 

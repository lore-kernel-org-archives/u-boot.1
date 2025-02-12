Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C299BC021A5
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 14:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B613880BAD;
	Wed, 12 Feb 2025 15:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="a/ghyNLM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C654980BAE; Wed, 12 Feb 2025 15:59:41 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9257809D0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 15:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51CExam43917322
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Feb 2025 08:59:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739372376;
 bh=708SvS6pybLEyIeyENmiUwG0lD1Mr+V1qTsqqv6f8kg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=a/ghyNLM4uOcshajsfNd3lzSRE81JryFKWI+BLBTrYp8KO/aqvbOEOM2k4idAOOeV
 LxN/iWQCvlW2FZlGMv6602IFqvwWOIwSKZVgCFFU5spCiIGqbAhnfHE+XaR91x28q/
 Wty0ri6JaQiMYfRn8r1oD6UzTzFwjXDOtstXaqO0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51CExaFV058712
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 12 Feb 2025 08:59:36 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Feb 2025 08:59:35 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Feb 2025 08:59:35 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51CExWSH048082;
 Wed, 12 Feb 2025 08:59:33 -0600
Message-ID: <9951c556-7049-4830-bdf8-52999017b954@ti.com>
Date: Wed, 12 Feb 2025 20:29:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2 v1] drivers: core: lists.c: Bind drivers using
 bootph* property in subnodes
To: Moteen Shah <m-shah@ti.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <vigneshr@ti.com>, <a-chavda@ti.com>, <u-kumar1@ti.com>
References: <20250212091820.213895-1-m-shah@ti.com>
 <20250212091820.213895-3-m-shah@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250212091820.213895-3-m-shah@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello Moteen

On 2/12/2025 2:48 PM, Moteen Shah wrote:
> Add a function to scan through all the subnodes of a given node
> recusively for bootph* property. If found, propagate it to all
> of its parent node up the hierarchy so as to bind the respective
> drivers of the nodes in the pre-relocation stage.
>
> The current model skips the node if there is no bootph* found in
> it, even if the property is present in one of the subnodes. The
> issue is tracked in [0].
>
> Signed-off-by: Moteen Shah <m-shah@ti.com>
>
> References:
> [0] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/21
>
> ---
>   drivers/core/lists.c | 88 +++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 86 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/core/lists.c b/drivers/core/lists.c
> index c7be504b6fc..5be556ea951 100644
> --- a/drivers/core/lists.c
> +++ b/drivers/core/lists.c
> @@ -17,6 +17,7 @@
>   #include <dm/platdata.h>
>   #include <dm/uclass.h>
>   #include <dm/util.h>
> +#include <fdt_support.h>
>   #include <fdtdec.h>
>   #include <linux/compiler.h>
>   
> @@ -196,6 +197,80 @@ static int driver_check_compatible(const struct udevice_id *of_match,
>   	return -ENOENT;
>   }
>   
> +/**
> + * scan_and_prop_bootph() - Check if a driver matches a compatible string
> + *
> + * @param of_node:	Parent node for child traversal
> + * @param fdt:	Blob to use
> + */
> +static int scan_and_prop_bootph(ofnode node, void *fdt)
> +{
> +	static int bootph_index = -1;
> +	static const char * const bootph_props[] = {
> +		"bootph-all",
> +		"bootph-some-ram",
> +		"bootph-pre-ram",
> +		"bootph-pre-sram",
> +	};
> +	int offset;
> +	int ret = -ENOENT;
> +	ofnode subnode;
> +
> +	/* Note the index where bootph-* was found and return success */
> +	for (int i = 0; i < ARRAY_SIZE(bootph_props); i++) {
> +		if (ofnode_read_bool(node, bootph_props[i])) {
> +			bootph_index = i;
> +			return 0;
> +		}
> +	}
> +
> +	ofnode_for_each_subnode(subnode, node) {
> +		if (!ofnode_valid(subnode))
> +			continue;
> +
> +		ret = scan_and_prop_bootph(subnode, fdt);
> +		if (ret != -ENOENT && ret)
> +			return ret;
> +
> +		/*
> +		 * Break the search if bootph-* is found in any of the subnodes.
> +		 * Breaking the loop early helps in avoiding unnecessary traversal
> +		 * of the sibling node given that bootph-* has been found in previous
> +		 * sibling node.
> +		 */
> +		if (!ret)
> +			break;
> +	}
> +
> +	/* If no bootph-* found then return no such entry */
> +	if (ret)
> +		return -ENOENT;
> +
> +	if (bootph_index != -1) {
> +		offset = ofnode_to_offset(node);
> +		if (offset < 0) {
> +			log_err("Failed to get offset %d\n", offset);
> +			return -EINVAL;
> +		}
> +
> +		ret = fdt_increase_size(fdt, 32);
> +		if (ret) {
> +			log_err("Cannot increase FDT size!\n");
> +			return ret;
> +		}

I understand you are trying to carry bootph to parent,so that parent can 
be probed.

In case, you are failing here then you need to tune memory map or in 
worse case you end up

not probing needed driver and hang.

then why not to override , we have u-boot specific DTs.



> +
> +		ret = fdt_setprop_empty(fdt, offset, bootph_props[bootph_index]);
> +		if (ret) {
> +			log_err("Failed to add bootph prop to node:%s ret=%d\n",
> +				ofnode_get_name(node), ret);
> +			return ret;
> +		}
> +		bootph_index = -1;
> +	}
> +
> +	return ret;
> +}
> +
>   int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
>   		   struct driver *drv, bool pre_reloc_only)
>   {
> @@ -205,6 +280,7 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
>   	struct driver *entry;
>   	struct udevice *dev;
>   	bool found = false;
> +	void *fdt = (void *)gd->fdt_blob;
>   	const char *name, *compat_list, *compat;
>   	int compat_length, i;
>   	int result = 0;
> @@ -256,8 +332,16 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
>   		if (pre_reloc_only) {
>   			if (!ofnode_pre_reloc(node) &&
>   			    !(entry->flags & DM_FLAG_PRE_RELOC)) {
> -				log_debug("Skipping device pre-relocation\n");
> -				return 0;
> +				if (IS_ENABLED(CONFIG_BIND_FROM_CHILD_BOOTPH)) {
> +					ret = scan_and_prop_bootph(node, fdt);
> +					if (ret) {
> +						log_debug("Skipping device pre-relocation\n");
> +						return 0;
> +					}
> +				} else {
> +					log_debug("Skipping device pre-relocation\n");
> +					return 0;
> +				}
>   			}
>   		}
>   

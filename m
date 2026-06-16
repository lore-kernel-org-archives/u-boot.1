Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B76ACD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 14:11:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFAF5848C5;
	Tue, 16 Jun 2026 16:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="hw12iEe0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D87EF848BF; Tue, 16 Jun 2026 16:11:33 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 49288848C5
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 16:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBC563612;
 Tue, 16 Jun 2026 07:11:25 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 923203F915; Tue, 16 Jun 2026 07:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1781619090; bh=CTt2PKDWSuYBZ11kMMTlneJTQJid/SPJ3fbFG/xQUaw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hw12iEe0VX14rAp7tIHxalyhhF6x8QAlE5XaLjBy5u9kz76MOdIshqF6KidkRMLY/
 wCpcyudfIZaqX2GGfH7QdObQ7ghEE5QHEQeTZctXD3md14Mnm8wysfa5Gci2L+mhbV
 +7gpoOx721m6HMwcIIdy3b88AyjzMG+o4Qyq8AQc=
Message-ID: <3dd4d423-4ce5-4bb7-8b67-2375d7eae6c9@arm.com>
Date: Tue, 16 Jun 2026 16:11:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: fdt: copy TF-A reserved memory into fdt passed to
 Linux
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <paulk@sys-base.io>,
 Cody Eksal <masterr3c0rd@epochal.quest>
References: <20260613204202.2360922-1-alexander.sverdlin@gmail.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260613204202.2360922-1-alexander.sverdlin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Alexander,

thanks for taking care of this upstream, and doing it in a generic (not 
Allwinner specific way)!
As you can see from that other reply, I am not a fan of those 
propagations from the control DT to something loaded, as this looks like 
a can of worms and I think that's unnecessary.
I might be talked into accepting this for the reserved memory regions, 
since they are somewhat crucial, and also generic.

On 6/13/26 22:41, Alexander Sverdlin wrote:
> Currently some ARM-based platforms reserve TF-A memory in their own ways:
> - Mediatek gets BL31 region via SMC call in ft_system_setup()
> - K3 uses CONFIG_K3_ATF_LOAD_ADDR, effectively in ft_system_setup()
> 
> And others like Allwinner simply forget to do it, which results in Linux
> overwriting TF-A and crashing.
> 
> Unfortunately seems that the things are not much better on TF-A side and
> there is no universal way to get the reserved memory region across
> platforms. But there is at least a most common way in TF-A, namely
> reserving  memory range in the FDT, in particular:
> - Allwinner	("tf-a@40000000" node)
> - ARM FPGA	("tf-a@80000000" node)
> - Xilinx	("tf-a" node)

Regardless of the general approach, as Paul already mentioned: the node 
names are by design arbitrary, and no meaning should be derived from 
them. So either we just copy all reserved nodes (why not?), or we look 
at the no-map property, which tells us that this region must not be 
mapped, to avoid speculation by the core into this memory area. Which 
would fault if this memory is secure-only. So all secure memory should 
have the no-map property, though not all no-map tagged regions must be 
secure-only.

One actual nice way of abstracting this is to look at U-Boot's Logical 
Memory Blocks (LMBs), which is U-Boot's crude way of dealing with memory 
regions. There is already code in place that puts no-map reserved 
regions from the control DT into those LMBs. If you type "bdinfo" on the 
U-Boot prompt, you should see them.
If you create reserved memory regions based on the LMBs, that would be 
even more generic.

> While this patch aims to improve the situation for Allwinner platforms,
> it's deliberately adding more generic code to pave the potential way of
> unification for other platforms.
> 
> Note that fdtdec_add_reserved_memory() has a check for an already existing
> carveout with exactly matching boundaries and will not create a duplicate
> even if the name doesn't match. It would not however detect an already
> existing bigger carveout fully containing the one requested.

Finding larger blocks should be quite easy, although there are 
theoretical corner cases which get nasty. I wonder if the LMB parsing 
code already solves that problem?

Cheers,
Andre

> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
> The patch has been developed to faciliate Allwinner A133 SoC support, where
> most of the work currently happens on TF-A [1] and Linux [2] sides, but
> I wanted to send this patch upfront to get the first feedback and because
> already supported H616 SoC would already benefit from the patch.
> 
> [1] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/49754
> [2] https://lore.kernel.org/all/20260605070923.3045073-1-alexander.sverdlin@gmail.com/
> [3] https://lore.kernel.org/all/b428d57ba5464f1226daf099877f4c25fa4fc191.camel@gmail.com/
> 
>   arch/arm/lib/bootm-fdt.c | 55 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm/lib/bootm-fdt.c b/arch/arm/lib/bootm-fdt.c
> index 2671f9a0ebf..19d917943c1 100644
> --- a/arch/arm/lib/bootm-fdt.c
> +++ b/arch/arm/lib/bootm-fdt.c
> @@ -14,7 +14,9 @@
>    * Copyright (C) 2001  Erik Mouw (J.A.K.Mouw@its.tudelft.nl)
>    */
>   
> +#include <dm/ofnode.h>
>   #include <fdt_support.h>
> +#include <linux/ioport.h>
>   #ifdef CONFIG_ARMV7_NONSEC
>   #include <asm/armv7.h>
>   #endif
> @@ -24,6 +26,52 @@
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> +static int tfa_copy_reserved_memory(void *new_blob)
> +{
> +#ifdef CONFIG_OF_CONTROL
> +	ofnode node, subnode;
> +
> +	/*
> +	 * TF-A for several platforms inserts its memory region as
> +	 * reserved-memory node
> +	 */
> +	node = ofnode_path("/reserved-memory");
> +	if (!ofnode_valid(node))
> +		return 0;
> +
> +	ofnode_for_each_subnode(subnode, node) {
> +		struct fdt_memory carveout;
> +		struct resource res;
> +		const char *name;
> +		int ret;
> +
> +		name = ofnode_get_name(subnode);
> +		if (!name)
> +			return -FDT_ERR_BADSTRUCTURE;
> +
> +		/* only handle TF-A reservations */
> +		if (strncmp(name, "tf-a", 4))
> +			continue;
> +
> +		/* check if this subnode has a reg property */
> +		ret = ofnode_read_resource(subnode, 0, &res);
> +		if (ret)
> +			continue;
> +
> +		carveout.start = res.start,
> +		carveout.end = res.end,
> +
> +		ret = fdtdec_add_reserved_memory(new_blob, "tf-a", &carveout,
> +						 NULL, 0, NULL,
> +						 FDTDEC_RESERVED_MEMORY_NO_MAP);
> +		if (ret < 0)
> +			return ret;
> +	}
> +#endif
> +
> +	return 0;
> +}
> +
>   #ifdef CONFIG_FMAN_ENET
>   __weak int fdt_update_ethernet_dt(void *blob)
>   {
> @@ -56,6 +104,13 @@ int arch_fixup_fdt(void *blob)
>   		return ret;
>   #endif
>   
> +	ret = tfa_copy_reserved_memory(blob);
> +	if (ret) {
> +		printf("ERROR: transfer of TF-A nodes to new fdt failed: %s\n",
> +		       fdt_strerror(ret));
> +		return ret;
> +	}
> +
>   #ifdef CONFIG_ARMV8_SPIN_TABLE
>   	ret = spin_table_update_dt(blob);
>   	if (ret)


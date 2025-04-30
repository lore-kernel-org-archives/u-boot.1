Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25697C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 15:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E7748215F;
	Wed, 30 Apr 2025 17:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W2ncnoOL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F97F82AEF; Wed, 30 Apr 2025 17:20:08 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89A298210E
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 17:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53UFK3VM3402096
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Apr 2025 10:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746026403;
 bh=Shc7WebMYiHUoalypOewbxoYLVbGo4ik5ad0CM5sOkU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=W2ncnoOLmeWj24vAHgm1QqF8+fZpJVH47ZZA1QO8oUo604sOf+YSKstoqGQmH4/ve
 o0N9iSZZfxXproH+CjZ/NMeQI0lcFaPXb1vYQF0rEm/Xl9DZtb+knUDq0s1Lyo3BsT
 nkSKcKpFs9swvZYBDYvigMDIlihL3r92ZpSueszM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53UFK38H022167
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Apr 2025 10:20:03 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Apr 2025 10:20:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Apr 2025 10:20:02 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53UFK2Xp108267;
 Wed, 30 Apr 2025 10:20:02 -0500
Date: Wed, 30 Apr 2025 10:20:02 -0500
From: Bryan Brattlof <bb@ti.com>
To: Aparna Patra <a-patra@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <afd@ti.com>,
 <d-gole@ti.com>, <vigneshr@ti.com>, <n-francis@ti.com>, <nm@ti.com>
Subject: Re: [PATCH 1/3] arm: mach-k3: am62a: Fixup CPU core, DSS, CAN-FD and
 Video-codec nodes in fdt
Message-ID: <20250430152002.juh2hmy6weph2jt5@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250430104236.2611089-1-a-patra@ti.com>
 <20250430104236.2611089-2-a-patra@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250430104236.2611089-2-a-patra@ti.com>
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

On April 30, 2025 thus sayeth Aparna Patra:
> AM62A SOC is available in multiple variants:
> -CPU cores (Cortex-A) AM62Ax1 (1 core),
>  AM62Ax2 (2 cores), AM62Ax4 (4 cores)
> -With and without DSS, CAN-FD & Video-codec support
> 
> Remove the relevant FDT nodes by reading the actual configuration
> from the SoC registers, with that change it is possible to have a single
> dts/dtb file handling the different variants at runtime.
> 
> Signed-off-by: Aparna Patra <a-patra@ti.com>
> ---
>  arch/arm/mach-k3/am62ax/am62a7_fdt.c          | 41 +++++++++++++++++++
>  .../arm/mach-k3/include/mach/am62a_hardware.h | 40 ++++++++++++++++++
>  2 files changed, 81 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/am62ax/am62a7_fdt.c b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
> index 7f764ab36b..56fd658202 100644
> --- a/arch/arm/mach-k3/am62ax/am62a7_fdt.c
> +++ b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
> @@ -8,8 +8,49 @@
>  
>  #include "../common_fdt.h"
>  
> +static void fdt_fixup_cores_wdt_nodes_am62a(void *blob, int core_nr)
> +{
> +	char node_path[32];
> +
> +	if (core_nr < 1)
> +		return;
> +
> +	for (; core_nr < 4; core_nr++) {
> +		snprintf(node_path, sizeof(node_path), "/cpus/cpu@%d", core_nr);
> +		fdt_del_node_path(blob, node_path);
> +		snprintf(node_path, sizeof(node_path), "/cpus/cpu-map/cluster0/core%d", core_nr);
> +		fdt_del_node_path(blob, node_path);
> +		snprintf(node_path, sizeof(node_path), "/bus@f0000/watchdog@e0%d0000", core_nr);
> +		fdt_del_node_path(blob, node_path);
> +	}
> +}
> +
> +static void fdt_fixup_dss_nodes_am62a(void *blob, bool has_dss)
> +{
> +	if (!has_dss) {
> +		fdt_del_node_path(blob, "/bus@f0000/dss@30200000");
> +		fdt_del_node_path(blob, "/bus@f0000/pinctrl@f4000/main-dss0-default-pins");

So for a little background on the upcoming paragraph[0]

I completely agree we should remove the dss{} node but don't think it's 
wise of us to start trying to unwind the allocation or configuration of 
the hardware when the hardware isn't there. 

In my eyes because we can't really trust the names for the memory 
carveouts, mailbox and, pinmux nodes as they are just describing their 
use and are fairly unstable as the boards age we would need to keep up 
with each node's bindings and follow all the pinmux, mboxes, 
memory-region phandles via their properties to undo all those nodes 
which leaves us making too many opinionated decisions on how best to do 
that in my opinion.

Anywho from that first link I'm trusting Andrew has a plan which from 
what I've seen could look something like an overlay[1] But time will 
tell.

~Bryan

[0] https://lore.kernel.org/all/20250419150451.v3jgtgp4yisou65u@bryanbrattlof.com/
[1] https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?id=95010a7c186b86f738615231016aa017ac527612


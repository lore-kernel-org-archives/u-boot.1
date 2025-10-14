Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15981CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 09:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C7D480422;
	Tue, 14 Oct 2025 11:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sSsB4ZoD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 009A48206E; Tue, 14 Oct 2025 11:59:52 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EDEC802C1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 11:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59E9xgK51041174;
 Tue, 14 Oct 2025 04:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760435982;
 bh=KBwvFWJx3s8V7Siqs+VGOJoIlO3RKW6ee2VF5g29rXk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=sSsB4ZoD6jyDnPpzAVVGKBon6QHQ1bVTK2FsfMOOwuwzLTPaNM7+VEVcZl8ZNy5JU
 lGihFNYDG2VUM2hHS/wTD3DMtmzbctp8WRjANchkGI8sx9JympiN6/Yj/HcwqrK/T1
 Pu+on7i2A63Ku8g2H+JR9zaBFrV8HDyAysHdwe7M=
Received: from DLEE203.ent.ti.com (dlee203.ent.ti.com [157.170.170.78])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59E9xgpn356800
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 14 Oct 2025 04:59:42 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Oct
 2025 04:59:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 04:59:41 -0500
Received: from [172.24.26.46] (lt5cd2489kgj.dhcp.ti.com [172.24.26.46])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59E9xZYk3607441;
 Tue, 14 Oct 2025 04:59:36 -0500
Message-ID: <d548843d-9342-43fa-8d18-f44105feff20@ti.com>
Date: Tue, 14 Oct 2025 15:29:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] remoteproc: Add support for i.MX8M[M/N/P/Q] and
 i.MX93
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, <u-boot@lists.denx.de>,
 <uboot-stm32@st-md-mailman.stormreply.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Fabio Estevam <festevam@gmail.com>, Stefano Babic
 <sbabic@nabladev.com>
CC: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Beleswar Padhi
 <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Andrew Davis <afd@ti.com>, Judith Mendez <jm@ti.com>,
 Ryan Eatmon <reatmon@ti.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Peng Fan <peng.fan@nxp.com>, <u-kumar1@ti.com>
References: <20251013-imx-rproc-v1-0-fb43a3fafcd0@nxp.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251013-imx-rproc-v1-0-fb43a3fafcd0@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Peng

On 10/13/2025 8:19 AM, Peng Fan (OSS) wrote:
> This patch series introduces remoteproc support for NXP i.MX8M and i.MX93
> platforms. Most of the i.MX-specific logic is ported from the Linux kernel to
> ensure compatibility and maintainability.
>
> The existing bootaux command in U-Boot only supports loading raw binary images.
> However, this approach fails when the remote processor firmware contains
> sections that must be loaded into both TCM and DDR. To address this limitation,
> need to use remoteproc framework ELF loader, enabling proper loading of
> segmented firmware images.


I am not sure, what problem you are facing to load fw having section in 
TCM and DDR both,  with current frame-work.

There are few drivers, using both TCM and DDR and working ok ref[0]

[0] 
https://elixir.bootlin.com/u-boot/v2025.10/source/drivers/remoteproc/ti_k3_r5f_rproc.c#L110 





>
> Patch Summary:
>
> Patches 1–2: Import memcpy_io and memset_io from the Linux kernel and enable
>               them in the remoteproc subsystem.
> Patches 3–11: Add platform-specific remoteproc support for i.MX8M and i.MX93.
> Patch 6: Temporarily adds Cortex-M nodes to x-u-boot.dtsi since they are not
>           yet available in the upstream Linux device tree. These nodes can be
> 	 removed once they are merged upstream.
>
> NXP internal R-b tags are kept, because the patches are directly
> cherry-picked from NXP LTS tree.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Peng Fan (11):
>        lib: Import iomem_copy from Linux Kernel
>        remoteproc: Extend device_to_virt with a is_iomem parameter
>        remoteproc: Add imx_rproc driver to support NXP i.MX8MP/N
>        remoteproc: imx_rproc: Support i.MX8MQ/M
>        remoteproc: imx_rproc: Add support for i.MX93 CM33
>        arm: dts: imx8m: Add remoteproc node
>        imx8mp: Enable remoteproc for i.MX8MP EVK
>        imx8mm: Enable remoteproc for i.MX8MM EVK
>        imx8mn: Enable remoteproc for i.MX8MN EVK
>        imx8mq: Enable remoteproc for i.MX8MQ EVK
>        imx93: Enable remoteproc for i.MX93-EVK/QSB/FRDM
>
>   MAINTAINERS                           |   1 +
>   arch/arm/dts/imx8mm-u-boot.dtsi       |   4 +
>   arch/arm/dts/imx8mn-u-boot.dtsi       |   4 +
>   arch/arm/dts/imx8mp-u-boot.dtsi       |   4 +
>   arch/arm/dts/imx8mq-u-boot.dtsi       |   4 +
>   arch/arm/mach-imx/imx8m/Kconfig       |  20 ++
>   arch/arm/mach-imx/imx9/Kconfig        |  12 ++
>   drivers/remoteproc/Kconfig            |   7 +
>   drivers/remoteproc/Makefile           |   1 +
>   drivers/remoteproc/imx_rproc.c        | 370 ++++++++++++++++++++++++++++++++++
>   drivers/remoteproc/imx_rproc.h        |  56 +++++
>   drivers/remoteproc/renesas_apmu.c     |   3 +-
>   drivers/remoteproc/rproc-elf-loader.c |  93 ++++++---
>   drivers/remoteproc/sandbox_testproc.c |   3 +-
>   drivers/remoteproc/stm32_copro.c      |   3 +-
>   drivers/remoteproc/ti_k3_dsp_rproc.c  |   2 +-
>   drivers/remoteproc/ti_k3_r5f_rproc.c  |   2 +-
>   include/asm-generic/io.h              |  37 ++++
>   include/remoteproc.h                  |   3 +-
>   lib/Makefile                          |   1 +
>   lib/iomem_copy.c                      | 136 +++++++++++++
>   21 files changed, 731 insertions(+), 35 deletions(-)
> ---
> base-commit: 48f21e66e360552c75d70a50421d0e0ed1f59e90
> change-id: 20251012-imx-rproc-383db752c3f7
>
> Best regards,

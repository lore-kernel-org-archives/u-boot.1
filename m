Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78210F588C2
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 12:56:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06090843F9;
	Mon, 20 Apr 2026 14:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f3lWDmWf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB870842F4; Mon, 20 Apr 2026 14:37:04 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8987E83C51
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 14:37:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CBEC1409D5;
 Mon, 20 Apr 2026 12:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC490C19425;
 Mon, 20 Apr 2026 12:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776688619;
 bh=vrT1jZIn7CtBlgfzzUESVvAYUCJHQC/+qG5Y35AkolQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f3lWDmWfTs38lqa8ktkVIUPdRhFGtd+uarDPrjURDRyyBnhfogrweocQ5yiTLVYyc
 LvN03Sojr8WVaQ/na0QsLsF2qZpf6fTzFNw6leDVrBIYJ3PrkFVic8lid2NADyPjvf
 E4HtxZ0+GyoCL1LeK3Lo20ZURTzLjVsB1n73l4TEsMp0HZJKpxGpF/LF1dDt56NCGM
 ictYDuA9NKh3rA/hPJF6nMOxSUMyamuNKm+LKJxa0vfofSVc7SQS0qqJnS9OViBHXQ
 N5YzjhrUuYew/hxqv5O0123ZiDybhepJ88krUCjGMBunION7yGXwvyyyIuULrSVcU0
 NRaR+XUDzlOnw==
Date: Mon, 20 Apr 2026 18:06:44 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 mkorpershoek@kernel.org, h-salunke@ti.com, alchark@gmail.com,
 dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com,
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com,
 wens@kernel.org, jamie.gibbons@microchip.com,
 david.wronek@mainlining.org, alexeymin@postmarketos.org,
 james.hilliard1@gmail.com, michael@amarulasolutions.com,
 richard.genoud@bootlin.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v2 1/9] dts: ipq5210-rdp504-u-boot: add override dtsi
Message-ID: <aeYd3P4ZtsmBWZJ3@sumit-xelite>
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260410091154.1001021-2-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410091154.1001021-2-varadarajan.narayanan@oss.qualcomm.com>
X-Mailman-Approved-At: Mon, 20 Apr 2026 14:54:39 +0200
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

On Fri, Apr 10, 2026 at 02:41:46PM +0530, Varadarajan Narayanan wrote:
> * Add initial support for the IPQ5210 MMC based RDP platforms.
> * Define memory layout statically.
> * Mark the nodes that would be needed for SPL.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
> v2: Remove sdhc as it is in kernel DT already
>     Move bootph-all to kernel DT - https://lore.kernel.org/linux-arm-msm/20260409-add_bootph-v1-1-cb2b5093f7d7@oss.qualcomm.com/T/#u
> ---
>  arch/arm/dts/ipq5210-rdp504-u-boot.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
> 

With below fixed:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi b/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
> new file mode 100644
> index 00000000000..5f0105d20de
> --- /dev/null
> +++ b/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IPQ5210 RDP504 board device tree source
> + *
> + * Copyright (c) 2025 The Linux Foundation. All rights reserved.

nit: 2026?

> + */
> +
> +/ {
> +	/* Will be removed when SMEM parsing is updated */
> +	memory@80000000 {
> +		bootph-all;
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x20000000>;
> +	};
> +};
> -- 
> 2.34.1
> 

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB61DC35FF3
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 500DD8191C;
	Wed, 19 Mar 2025 04:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742355131;
	bh=1oo6cZ2VYG/zZkwb9cQJOMEaaJCApC1aWdpuobVJfN4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ulu1ukBIk6lviKq6XO4GmTJS07F9o1OU58Yuo/Ru5IneluCvHMihOTEOpCJ4258CP
	 DQ+9rJ+oulDndFiFGATxpNgT7VmK1ZjbWce5HMOyieinNDOU7ZDZ1ThQUUy0a8U7UM
	 csoC+Nsf6veLeUo7IdgL0IWngxxUfYfuRAYKmpuTLYOBP2NyCqdw+fcflVdR9vYbUI
	 0aCVcKDcUgWZZSOMJLORuBmVP69R0Fb6wNfvqsDrENBFkYsmCu2BfEcsMnSZgwFDL0
	 1LAArgzSySPt20HjGLGvbCJU/RCBHT+/HuYT6z9m8ysTyb0OjYNi0pibQPRDGpLnnb
	 p2ctnOF8ebx8w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C63F8815D1; Wed, 19 Mar 2025 04:32:10 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7D7E8129F
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="FGRTCMLm"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0A067103BB5FD; Wed, 19 Mar 2025 04:32:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742355127; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=1oo6cZ2VYG/zZkwb9cQJOMEaaJCApC1aWdpuobVJfN4=;
 b=FGRTCMLmholAYyBlLSnPvMxw220KuJu80Hg6zL3Jds/D2SVttLRQZF2L1YpNAvf/1xR8mQ
 jv3ShYBShb69PQ4YZy5etlsQDIgBUf1qardQP01Oj50cPcYbApc0WzFy2F+Xa5eUUWjf1K
 VAfE+EvK6BuazWdtDgj/Z+60Hp5Tpt6lgb6t/pbw1AQYCt3h8sWxogm3j9qVPfeQlF4+nt
 clJFmzxwOweL8JoUNCWLnVsL8yWn84mD1cqBRhRPhTh3IqydEtfSXKtYfS1P0oSRywW00W
 1AHV0WgVNpO0VALXp4zfKyLKZIaO6+zfhIYCbCSBCdnJKnDmGAhYwGi3IcpEmw==
Message-ID: <e09f009d-4a00-45a7-9a33-dba22da6ca4b@denx.de>
Date: Wed, 19 Mar 2025 04:23:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] clk: Add clk_resolve_parent_clk() and fix up iMX
 clock drivers
To: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan
 <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com,
 Fabio Estevam <festevam@gmail.com>
References: <20250319031852.233537-1-marex@denx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250319031852.233537-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/19/25 4:17 AM, Marek Vasut wrote:
> Add clk_resolve_parent_clk() to resolve parent clock udevice name
> based on clock-names DT property. This is used in SoC clock drivers
> to look up the clock name in clock tables, which matches a clock
> name in DT clock-names property, and convert it into udevice name
> which is used by U-Boot clock framework to look up parent clock in
> e.g. clk_register() using uclass_get_device_by_name(UCLASS_CLK,
> parent_name, &parent);
> 
> Pass struct udevice pointer through the various iMX clock drivers.
> 
> Marek Vasut (24):
>    clk: Add clk_resolve_parent_clk()
>    clk: clk-mux: Fold clk_register_mux()
>    clk: clk-mux: Use struct udevice instead of struct device
>    clk: clk-mux: Resolve parent clock by name
>    clk: imx: Pass struct udevice into imx_clk_mux*()
>    clk: imx: Pass struct udevice to clk_register_mux()
>    clk: clk-gate: Use struct udevice instead of struct device
>    clk: clk-gate: Resolve parent clock by name
>    clk: imx: gate2: Use struct udevice instead of struct device
>    clk: imx: gate2: Resolve parent clock by name
>    clk: imx: Pass struct udevice into imx_clk_gate*()
>    clk: imx: Pass struct udevice to clk_register_gate*()
>    clk: clk-composite: Use struct udevice instead of struct device
>    clk: clk-composite: Resolve parent clock by name
>    clk: imx: Pass struct udevice into imx_clk_composite*()
>    clk: imx: Convert clock-osc-* back to osc_*
>    clk: imx: Pass struct udevice into imx_clk_pllv3*()
>    clk: imx: pllv3: Resolve parent clock by name
>    clk: clk-divider: Use struct udevice instead of struct device
>    clk: imx: Pass struct udevice into imx_clk_divider*()
>    clk: clk-divider: Resolve parent clock by name
>    clk: clk-fixed-factor: Use struct udevice instead of struct device
>    clk: clk-fixed-factor: Resolve parent clock by name
>    clk: imx: Pass struct udevice into imx_clk_fixed_factor*()
> 
>   drivers/clk/clk-composite.c        |   4 +-
>   drivers/clk/clk-divider.c          |   7 +-
>   drivers/clk/clk-fixed-factor.c     |   6 +-
>   drivers/clk/clk-gate.c             |   5 +-
>   drivers/clk/clk-mux.c              |  47 +---
>   drivers/clk/clk-uclass.c           |  18 ++
>   drivers/clk/imx/clk-composite-8m.c |   4 +-
>   drivers/clk/imx/clk-gate2.c        |   5 +-
>   drivers/clk/imx/clk-imx6q.c        |  66 +++---
>   drivers/clk/imx/clk-imx8mm.c       | 236 +++++++++----------
>   drivers/clk/imx/clk-imx8mn.c       | 230 +++++++++----------
>   drivers/clk/imx/clk-imx8mp.c       | 348 ++++++++++++++---------------
>   drivers/clk/imx/clk-imx8mq.c       | 226 +++++++++----------
>   drivers/clk/imx/clk-imx93.c        |   8 +-
>   drivers/clk/imx/clk-imxrt1020.c    |  38 ++--
>   drivers/clk/imx/clk-imxrt1050.c    |  70 +++---
>   drivers/clk/imx/clk-imxrt1170.c    |  30 +--
>   drivers/clk/imx/clk-pllv3.c        |   9 +-
>   drivers/clk/imx/clk.h              | 116 +++++-----
>   include/clk.h                      |   9 +
>   include/linux/clk-provider.h       |  10 +-
>   21 files changed, 754 insertions(+), 738 deletions(-)
Sigh, get maintainers missed Fabio, sorry, +CCed now.

Fabio, do you want me to resend this with you on CC?

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1641CD60CEF
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 05:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D0EA894F7;
	Tue, 19 Nov 2024 06:01:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="on2KyKtc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7CC2894F9; Tue, 19 Nov 2024 06:01:27 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A76178926F
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 06:01:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ51Ojq078439;
 Mon, 18 Nov 2024 23:01:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731992484;
 bh=WYO1Oqy6IjbuPLDW08R8XDhipb+oLyEf3gQbWHpcCho=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=on2KyKtcnrsYu5xaVb1Vi+OMNvEkDiXh36/8cPw5N3kZpUEwLKeLA7H+nWMVbzGuj
 C+MGRj5l6S93aU89r9/NMZif8GNRHUX9eZktNuUzLml5rVfH+lsaWkfjLBYs6CeHps
 V4JUnTGFS9b7fTdztpO5iqo0Nt70RTrQi2Vqns4M=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJ51O3x055711
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Nov 2024 23:01:24 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Nov 2024 23:01:23 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Nov 2024 23:01:23 -0600
Received: from localhost (uda0497581.dhcp.ti.com [172.24.227.240])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ51N5Z020054;
 Mon, 18 Nov 2024 23:01:23 -0600
Date: Tue, 19 Nov 2024 10:31:22 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <b-padhi@ti.com>, <sabiya.d@ti.com>,
 <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/5] Enable AVS support for AM68, AM69 and J784S4
Message-ID: <20241119050122.bilk6amwoufnnmux@uda0497581>
References: <20241118105714.1973573-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241118105714.1973573-1-n-francis@ti.com>
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

Hi Neha,

On 16:27-20241118, Neha Malcom Francis wrote:
> This series adds AVS support for AM68 SK, AM69 SK and J784S4 EVM.
> 
> Boot logs:
> https://gist.github.com/nehamalcom/db5dbf98357ebac46f648c24ad1a17e2
> 
> Neha Malcom Francis (4):
>   arm: dts: k3-j784s4-r5: Add VTM node to R5 stage
>   arm: dts: k3-am68-sk-r5-base-board: Add VTM node to R5 stage
>   arch: arm: mach-k3: j784s4_init: Probe AVS driver
>   configs: j784s4_evm_r5_defconfig: Enable AVS
> 
> Udit Kumar (1):
>   configs: am68_sk_r5: Add AVS Configs
> 
>  arch/arm/dts/k3-am68-sk-r5-base-board.dts |  5 +++++
>  arch/arm/dts/k3-j784s4-r5.dtsi            |  6 ++++++
>  arch/arm/mach-k3/j784s4/j784s4_init.c     | 10 ++++++++++
>  configs/am68_sk_r5_defconfig              |  3 ++-
>  configs/j784s4_evm_r5_defconfig           |  4 ++++
>  5 files changed, 27 insertions(+), 1 deletion(-)

For the series:

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

Regards,
Manorit

> 
> -- 
> 2.34.1
> 

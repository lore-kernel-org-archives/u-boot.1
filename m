Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28A9CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B47E8848F;
	Fri,  5 Apr 2024 10:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZjhIqXp5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63E2B88460; Fri,  5 Apr 2024 10:35:12 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 556348848F
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r-gunasekaran@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4358Z5g1037824;
 Fri, 5 Apr 2024 03:35:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712306105;
 bh=sGAmaxe0f8qTwmQ5nn5yCrXRNyIMggGmVi7dfmOeAiI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ZjhIqXp552ZP1z30x8BljwoM6PRMK5OeC4SrSFfDiGqyliUP4pnHjX4AwB8RxIxcm
 Gt/L4uej57Smrez0rOr+LR3QR47/fAwmzLIGK2k8xQxuy3lHCneuLi7y1RC6HTOyYk
 7PabkA+valzAj8HLwTVJz/TpC/dEA8sO7BMrO7E4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4358Z5re125418
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 5 Apr 2024 03:35:05 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Apr 2024 03:35:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Apr 2024 03:35:04 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4358Ytah017397;
 Fri, 5 Apr 2024 03:34:55 -0500
Message-ID: <a526abce-830a-c1bd-93a4-cf9b9b902a03@ti.com>
Date: Fri, 5 Apr 2024 14:04:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 4/5] net: ti: icssg: Add ICSSG ethernet driver
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Maxime Ripard <mripard@kernel.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Devarsh Thakkar <devarsht@ti.com>, Simon
 Glass <sjg@chromium.org>, Kamlesh Gurudasani <kamlesh@ti.com>, Christian
 Gmeiner <christian.gmeiner@gmail.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20240404070803.2455207-1-danishanwar@ti.com>
 <20240404070803.2455207-5-danishanwar@ti.com>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240404070803.2455207-5-danishanwar@ti.com>
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



On 4/4/24 12:38 PM, MD Danish Anwar wrote:
> This is the PRUSS Ethernet driver for TI AM654 SR2.0 and later SoCs with
> the ICSSG PRU Sub-system running EMAC firmware. ICSSG Subsystem supports
> two slices per instance. This driver caters to both slices / ports of
> the icssg subsystem.
> 
> Since it is not possible for Ethernet driver to register more than one
> port for a given instance, this patch introduces top level PRUETH as
> UCLASS_MISC and binds UCLASS_ETH to individual ports in order to support
> bringing up more than one Ethernet interface in U-Boot.
> 
> Since top level driver is UCLASS_MISC, board files would need to
> instantiate the driver explicitly.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  arch/arm/mach-k3/common.c     |  11 +
>  drivers/net/ti/Kconfig        |  13 +
>  drivers/net/ti/Makefile       |   1 +
>  drivers/net/ti/icssg_prueth.c | 685 ++++++++++++++++++++++++++++++++++
>  drivers/net/ti/icssg_prueth.h |   3 +
>  5 files changed, 713 insertions(+)
>  create mode 100644 drivers/net/ti/icssg_prueth.c
> 

Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

-- 
Regards,
Ravi

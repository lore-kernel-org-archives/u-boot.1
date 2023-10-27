Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49959C25B48
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 20:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 770ED87457;
	Fri, 27 Oct 2023 22:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="I7T+VBjf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9878387457; Fri, 27 Oct 2023 22:46:30 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C4CD87457
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 22:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39RKkLlk021488;
 Fri, 27 Oct 2023 15:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698439581;
 bh=iuVhvOHALgKACe0orNc+6LDh9JrbDP6FubtIjn1UQlw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=I7T+VBjfKx4142DCKo/wnpj+3S7Myh96cyZNlFa+tn5mkZDAoA5zHPHZqP0ciHggW
 nw++mQOGYD8KF56WzFXw/txcX5glmVTec0Y2nEnQgN5ypD78bdw5ivMJL2zAwNyIEo
 TMhSDYkNZeJmo7hKsC2o99Os2013rCap2ul0G5HM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39RKkLkJ055827
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 27 Oct 2023 15:46:21 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 27
 Oct 2023 15:46:20 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 27 Oct 2023 15:46:20 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39RKkKje092047;
 Fri, 27 Oct 2023 15:46:20 -0500
Date: Fri, 27 Oct 2023 15:46:20 -0500
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: <trini@konsulko.com>, <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>,
 <vigneshr@ti.com>, <srk@ti.com>, <marcel.ziswiler@toradex.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/3] arm: dts: k3-am6: Fix Ethernet/DMA
Message-ID: <20231027204620.oz5hemkw3wwhh3u6@latter>
References: <20231027134630.244886-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231027134630.244886-1-rogerq@kernel.org>
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

On 16:46-20231027, Roger Quadros wrote:
> Hi,
> 
> Since commit [1], Ethernet is broken on TI AM62 and AM64 platforms.
> 
> The commit [1] is not the culprit. It just unearths the problem by fixing
> the error check in k3-udma.c. This issue was silently being ignored earlier
> due to wrong error check. [NULL instead of FDT_ADDR_T_NONE].
> 
> Fix the issue by adding the necessary register spaces for the u-boot K3-UDMA
> driver for AM62 and AM64 platforms.
> 
> [1] - 5fecea171de3dd ("treewide: use dev_read_addr_*_ptr() where appropriate")
> 
> cheers,
> -roger
> 
> Roger Quadros (1):
>   arm: dts: k3-am625-verdin-wifi-dev-u-boot.dtsi: Fix DMA/Ethernet
> 
> Siddharth Vadapalli (2):
>   arm: dts: k3-am625-sk-u-boot.dtsi: Update main_bcdma and main_pktdma
>     nodes
>   arm: dts: k3-am642: Update main_bcdma and main_pktdma nodes
> 
>  arch/arm/dts/k3-am625-sk-u-boot.dtsi          | 27 +++++++++++++++++++
>  .../dts/k3-am625-verdin-wifi-dev-u-boot.dtsi  | 27 +++++++++++++++++++
>  arch/arm/dts/k3-am642-evm-u-boot.dtsi         | 27 +++++++++++++++++++
>  arch/arm/dts/k3-am642-sk-u-boot.dtsi          | 23 ++++++++++++++++
>  4 files changed, 104 insertions(+)
> 
> 
> base-commit: 351da15f71e3d70dbc63e90781b403415452d864
> -- 
> 2.34.1
> 


Thanks for this.

Reviewed-by: Nishanth Menon <nm@ti.com>

NOTE: These extra properties are already in discussion in Linux
community.

https://lore.kernel.org/linux-arm-kernel/20230810174356.3322583-1-vigneshr@ti.com/

Marcel, could the Toradex team confirm as well?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

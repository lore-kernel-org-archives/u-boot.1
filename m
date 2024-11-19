Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F9ED60CEF
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 04:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6477894FD;
	Tue, 19 Nov 2024 05:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SBWk6+M2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCD84894FD; Tue, 19 Nov 2024 05:57:39 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F947894FD
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ4vZIk076974;
 Mon, 18 Nov 2024 22:57:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731992255;
 bh=qkrupvtBiwvZFPlrQHv72Es2Mz2aP3XDDA1z02YeO7Y=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=SBWk6+M2xoBDp3UCP1M8aMKQ1s6m2mr+uaTnMDzPT7I6VOZjoib8Su+o0oh1ABcbJ
 2oRyJpHlnKf+aGfIARmiOMOtvTGYIriQA6rNc3l5RBOodXniEjYZf6rD46N4Sg5/Yd
 z6woGTNXU+zkChQ55jhPXFSNQmDHmgcJeac1F/ik=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ4vZHI082950;
 Mon, 18 Nov 2024 22:57:35 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Nov 2024 22:57:34 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Nov 2024 22:57:34 -0600
Received: from localhost (uda0497581.dhcp.ti.com [172.24.227.240])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ4vYRs012991;
 Mon, 18 Nov 2024 22:57:34 -0600
Date: Tue, 19 Nov 2024 10:27:33 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <b-padhi@ti.com>, <sabiya.d@ti.com>,
 <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/5] arm: dts: k3-am68-sk-r5-base-board: Add VTM node to
 R5 stage
Message-ID: <20241119045733.wqtmemrc52wpkflp@uda0497581>
References: <20241118105714.1973573-1-n-francis@ti.com>
 <20241118105714.1973573-3-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241118105714.1973573-3-n-francis@ti.com>
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
> Add the VTM node to the R5 boot stage so that AVS is correctly
> configured for AM68 SK.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  arch/arm/dts/k3-am68-sk-r5-base-board.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am68-sk-r5-base-board.dts b/arch/arm/dts/k3-am68-sk-r5-base-board.dts
> index 3b2d7af2e52..b61d22b3b4b 100644
> --- a/arch/arm/dts/k3-am68-sk-r5-base-board.dts
> +++ b/arch/arm/dts/k3-am68-sk-r5-base-board.dts
> @@ -10,3 +10,8 @@
>  #include "k3-j721s2-ddr.dtsi"
>  #include "k3-am68-sk-base-board-u-boot.dtsi"
>  #include "k3-j721s2-r5.dtsi"
> +
> +&wkup_vtm0 {
> +	bootph-pre-ram;
> +	vdd-supply-2 = <&tps62873a>;
> +};

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

Regards,
Manorit

> -- 
> 2.34.1
> 

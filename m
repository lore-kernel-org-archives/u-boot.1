Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7511AC36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 14:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6649B81E8C;
	Fri, 28 Mar 2025 15:18:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qHj9sF9i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB19F81E1C; Fri, 28 Mar 2025 15:18:52 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A039F8070C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 15:18:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52SEIlCB2730433
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Mar 2025 09:18:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1743171528;
 bh=yZ59Cqjou+qsrN7tLiRJH97ccpg136G1uvzuva5y+jc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=qHj9sF9iMFuQyXsoaftDkftoIwdu/mfCJ/o6RYHefquEjyEpORl4/35x75fIMTMaX
 fCVQskVAbbPtu93C82UtVX3hoq/6ODA2oCeD2Xwu/M/CzpEBcKQUoeAopAWyXfV+Iu
 EcCSMXdO4IBn+GjV6bV8TrNk+dh4zw6khK1ttZsk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52SEIlW6027357
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Mar 2025 09:18:47 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Mar 2025 09:18:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Mar 2025 09:18:47 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52SEIluj121113;
 Fri, 28 Mar 2025 09:18:47 -0500
Date: Fri, 28 Mar 2025 09:18:47 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, 
 <hnagalla@ti.com>, <j-choudhary@ti.com>, <bb@ti.com>,
 <vigneshr@ti.com>, <j-keerthy@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 3/3] DONOTMERGE: arm: dts: k3-j784s4-main: Add
 PBIST_14 node
Message-ID: <20250328141847.s333bjjqmzfi5dkj@remarry>
References: <20250328123127.497971-1-n-francis@ti.com>
 <20250328123127.497971-4-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250328123127.497971-4-n-francis@ti.com>
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

On 18:01-20250328, Neha Malcom Francis wrote:
> Add DT node for PBIST_14 that is responsible for triggering the PBIST
> self-tests for the MAIN_R5_2_x cores.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Linux dt-binding patch
> https://lore.kernel.org/all/20250328111439.374748-1-n-francis@ti.com/

Please hold off till the binding is closed out with Krystoff.

> 
> Changes since v2:
> - s/ti,bist-instance/ti,bist-under-test
> 
>  dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi b/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
> index 0160fe0da98..1a26f5e4ace 100644
> --- a/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
> +++ b/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
> @@ -113,6 +113,17 @@
>  			status = "disabled";
>  		};
>  	};
> +
> +	bist_main14: bist@33c0000 {
> +		compatible = "ti,j784s4-bist";
> +		reg = <0x00 0x033c0000 0x00 0x400>,
> +		      <0x00 0x0010c1a0 0x00 0x01c>;
> +		reg-names = "cfg", "ctrl_mmr";
> +		clocks = <&k3_clks 237 7>;
> +		power-domains = <&k3_pds 237 TI_SCI_PD_EXCLUSIVE>;
> +		bootph-pre-ram;
> +		ti,bist-under-test = <343>, <344>, <365>, <366>;
> +	};
>  };
>  
>  &scm_conf {
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

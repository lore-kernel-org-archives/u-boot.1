Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8516BC52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 12:47:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D921188842;
	Tue, 13 Aug 2024 14:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UBqyg6Wu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD02888997; Tue, 13 Aug 2024 14:47:38 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CE4987E30
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 14:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47DClImH089434;
 Tue, 13 Aug 2024 07:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723553238;
 bh=l7fwIWJ6PtgybPe00g+TR1xOAxF5Fwrhf5V5k8zwwyA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=UBqyg6WuZT86nXjQ6QEnkJcxGQVLvR7LWSKOZ3WO4hPOOASXhQRSoLxv71nurlX6y
 3mWbSH+GGFUik3cEv+E3M7hCk+KxZbRKRSKhT+zv772lB0DHno7Izj/1JhIEPw3Uwe
 6h54pqecvRiivr4rSIkmc4vOCdav6XSIGinxvv/Q=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47DClIxc097001
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Aug 2024 07:47:18 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 07:47:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 07:47:18 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47DClIH8111027;
 Tue, 13 Aug 2024 07:47:18 -0500
Date: Tue, 13 Aug 2024 07:47:18 -0500
From: Nishanth Menon <nm@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: Michal Simek <michal.simek@amd.com>, Marek =?utf-8?B?QmVow7pu?=
 <kabel@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, "Neha
 Malcom Francis" <n-francis@ti.com>, MD Danish Anwar <danishanwar@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Ravi Gunasekaran
 <r-gunasekaran@ti.com>, Udit Kumar <u-kumar1@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Jonas Karlman <jonas@kwiboo.se>, "Devarsh Thakkar" <devarsht@ti.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Wadim Egorov <w.egorov@phytec.de>, Dhruva Gole
 <d-gole@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, "Sumit
 Garg" <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v5 10/10] arm64: dts: ti: k3-am62x-sk-common: Add
 bootph-all property in phy_gmii_sel node
Message-ID: <20240813124718.4zpvz3ryhdexxqdr@sharpness>
References: <20240813105400.4054657-1-c-vankar@ti.com>
 <20240813105400.4054657-11-c-vankar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240813105400.4054657-11-c-vankar@ti.com>
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

On 16:24-20240813, Chintan Vankar wrote:
> Add missing bootph-all property for CPSW MAC's PHY node
> phy_gmii_sel.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> Link: https://lore.kernel.org/r/20240430085048.3143665-1-c-vankar@ti.com
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> 
> [ upstream commit: ba50141137fae205a731005e70687f4a52289050 ]
> 
> (cherry picked from commit 2bdd1743a9f6515efe7c3648a25d63b4a9ce4a10)
> ---
> 
> Link to v4:
> https://lore.kernel.org/r/20240812114945.3844224-1-c-vankar@ti.com/
> 
> Changes from v4 to v5:
> - Updated this patch with the cherry picked patch from
>   devicetree-rebasing repo as pointed out by Sumit.
> 
>  dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
> index 3c45782ab2b..96378b19c41 100644
> --- a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
> +++ b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
> @@ -128,6 +128,10 @@
>  	};
>  };
>  
> +&phy_gmii_sel {
> +	bootph-all;
> +};
> +


If you cannot wait for upstream dt sync, why not just do this in R5-sk
or u-boot.dtsi?


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

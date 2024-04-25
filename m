Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598DCC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 12:31:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6BC288F26;
	Thu, 25 Apr 2024 14:31:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="chR1NEHQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 621F188F37; Thu, 25 Apr 2024 14:31:20 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17F5E88F23
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 14:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id F308060DEB;
 Thu, 25 Apr 2024 12:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9183C113CC;
 Thu, 25 Apr 2024 12:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714048276;
 bh=U/jvgXZrE2kD80DSFUzvHjhBw1Jt8EBNkQDT+PDprOU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=chR1NEHQoxrz/rVtHiPIi8qATJHjEor0Z6+rGd7KthSlhnU6mEwFeXy8NAdWcGp06
 /b0ibDKZRtzelPvNhr04T1MK9v+VG7mmzFt971KS510M4UXD7woO+f/0KS04GVNQ6r
 wknw+3yEAMRLsRx5HVpC06H7jn2r1toC1ELKavcT5L1aLoRp4mLnUKyf/uZl7Xqs/E
 Gs/msXo6qijlNTSBL9JIivNViZYifvTRxIiAWuDyO6/B/hl7Sg430HSZ+kSGu2c4C6
 pl1FwEE33sP39Ev4C7JRr2+lUJx/3ujZhtUljRXlO46qKEHZWYOjj2DZK9+0JxrYOm
 Ez16vycyqXxoQ==
Message-ID: <5ac873d5-e485-47d3-b5de-f537c1fb88b1@kernel.org>
Date: Thu, 25 Apr 2024 15:31:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] arch: arm: dts: k3-am62-sk-u-boot: Add missing
 "bootph-all" property to phy_gmii_sel node
To: Chintan Vankar <c-vankar@ti.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, MD Danish Anwar <danishanwar@ti.com>,
 Udit Kumar <u-kumar1@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Bin Meng <bmeng@tinylab.org>, Sean Anderson <seanga2@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Nikhil M Jain <n-jain1@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Dhruva Gole
 <d-gole@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Andrew Davis <afd@ti.com>, Maxime Ripard <mripard@kernel.org>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240425120822.2048012-1-c-vankar@ti.com>
 <20240425120822.2048012-11-c-vankar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240425120822.2048012-11-c-vankar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 25/04/2024 15:08, Chintan Vankar wrote:
> Add "bootph-all" property to CPSW MAC's PHY node phy_gmii_sel.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
> 
> Changes from v1 to v2:
> - This patch is newly added in this series to enable CPSW MAC's PHY
>   node "phy_gmii_sel". As per discussion at here:
>   https://lore.kernel.org/r/20240112130127.rvvrhz7p4vmlyalh@smother/
>   changes made by this patch can be dropped in the future when the
>   DT-Sync is performed with am62-main.dtsi containing this change in
>   the Linux DT which will match U-Boot's DT.

I don't think bootph-all exists in am62-main.dtsi. It should come from
board.dts

> 
>  arch/arm/dts/k3-am625-sk-u-boot.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> index fa778b0ff4..e9a1afde95 100644
> --- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> @@ -46,3 +46,7 @@
>  &cpsw_port2 {
>  	status = "disabled";
>  };
> +
> +&phy_gmii_sel {
> +	bootph-all;
> +};

-- 
cheers,
-roger

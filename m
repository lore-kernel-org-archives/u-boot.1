Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1134FC2BA15
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 15:18:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87CEF880F5;
	Mon, 17 Jun 2024 17:18:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WpLbqhwg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6320688348; Mon, 17 Jun 2024 17:18:06 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D8CB87CDA
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 17:18:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45HFHu3n033111;
 Mon, 17 Jun 2024 10:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718637476;
 bh=2YIPx2WCkdVi7f1FN/0DhGQZES9rLcSO78VJ187GI1g=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=WpLbqhwgFRRRr7aJVG8pOYYf8/VCnKTM8KOf0w5suIjBoQ0cqf9AatTCzU9UqQScX
 vrw9Kizj/rSgMy796VUfEiYS010jHczvxlpVHJoQ0dOnl6Docb6h9fX7hDb15opD0B
 AUZNLf7Md/1AeytONnEePXEzTH7urjpm/XKRxLCs=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45HFHuFf080443
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Jun 2024 10:17:56 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Jun 2024 10:17:56 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Jun 2024 10:17:56 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45HFHum0049501;
 Mon, 17 Jun 2024 10:17:56 -0500
Date: Mon, 17 Jun 2024 10:17:56 -0500
From: Bryan Brattlof <bb@ti.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
CC: <u-boot@lists.denx.de>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Hari Nagalla
 <hnagalla@ti.com>, Apurva Nandan <a-nandan@ti.com>, Sean Anderson
 <seanga2@gmail.com>, Nishanth Menon <nm@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1] arm: mach-k3: j784s4: Fix MCU_CLKOUT0 parent clock mux
Message-ID: <20240617151756.nonsn4ns6ehs4stf@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240617092201.30245-1-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240617092201.30245-1-ghidoliemanuele@gmail.com>
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

On June 17, 2024 thus sayeth Emanuele Ghidoli:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> MCU_CLKOUT0 output can be driven by two different clock inputs:
> one at 25 MHz and another at 50 MHz. Currently, the 25 MHz input
> clock is not selectable due to a duplication of the 50 MHz clock input
> in the mux configuration. This commit corrects the parent clock mux
> configuration, making the 25 MHz input clock selectable.
> 
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> ---
>  arch/arm/mach-k3/r5/j784s4/clk-data.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Nice catch!

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan

> diff --git a/arch/arm/mach-k3/r5/j784s4/clk-data.c b/arch/arm/mach-k3/r5/j784s4/clk-data.c
> index feaa13ee266b..793bcac93245 100644
> --- a/arch/arm/mach-k3/r5/j784s4/clk-data.c
> +++ b/arch/arm/mach-k3/r5/j784s4/clk-data.c
> @@ -134,7 +134,7 @@ static const char * const emmcsd1_lb_clksel_out0_parents[] = {
>  
>  static const char * const mcu_clkout_mux_out0_parents[] = {
>  	"hsdiv4_16fft_mcu_2_hsdivout0_clk",
> -	"hsdiv4_16fft_mcu_2_hsdivout0_clk",
> +	"hsdiv4_16fft_mcu_2_hsdivout1_clk",
>  };
>  
>  static const char * const k3_pll_ctrl_wrap_main_0_sysclkout_clk_parents[] = {
> @@ -338,7 +338,7 @@ static const struct dev_clk soc_dev_clk_data[] = {
>  	DEV_CLK(149, 5, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
>  	DEV_CLK(157, 174, "mcu_clkout_mux_out0"),
>  	DEV_CLK(157, 175, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
> -	DEV_CLK(157, 176, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
> +	DEV_CLK(157, 176, "hsdiv4_16fft_mcu_2_hsdivout1_clk"),
>  	DEV_CLK(157, 179, "fss_mcu_0_hyperbus1p0_0_hpb_out_clk_p"),
>  	DEV_CLK(157, 180, "fss_mcu_0_hyperbus1p0_0_hpb_out_clk_n"),
>  	DEV_CLK(157, 224, "fss_mcu_0_ospi_0_ospi_oclk_clk"),
> -- 
> 2.34.1
> 

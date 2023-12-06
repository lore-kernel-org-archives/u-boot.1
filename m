Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA819C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 19:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09B3A87243;
	Wed,  6 Dec 2023 20:59:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="h8nGfXik";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FEA18746C; Wed,  6 Dec 2023 20:59:42 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF63387240
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 20:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B6Jxa8K097064;
 Wed, 6 Dec 2023 13:59:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701892776;
 bh=zZ62GVZifWxYv0acMrUwtrYCPkGhc6RB9Ig0h38gPGM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=h8nGfXikpVGIFH/kOd7vFtAV8H6BABANBto/nXKHMRCH89QdrNZgbE+MCeRr3Kb1D
 TCx9eHZElzyLF8c2rIPNvDrgHaNYM3m60bzARqaEsjoTUCEa23X9x9dqPZqI+VyvL4
 vGG5mLYvf4sNidK+BelgdjEAoDBThyHKcj+eoRkA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B6JxaWr077896
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Dec 2023 13:59:36 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Dec 2023 13:59:36 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Dec 2023 13:59:36 -0600
Received: from localhost (reidt-hp-z2.dhcp.ti.com [128.247.81.215])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B6JxaUb105189;
 Wed, 6 Dec 2023 13:59:36 -0600
Date: Wed, 6 Dec 2023 13:59:36 -0600
From: reidt <reidt@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: <trini@konsulko.com>, <nm@ti.com>, <u-boot@lists.denx.de>,
 <m-chawdhry@ti.com>, <bb@ti.com>, <a-nandan@ti.com>, <vishalm@ti.com>
Subject: Re: [PATCH 1/2] arm: mach-k3: j72xx: add new 'virtual' mux
Message-ID: <20231206195936.jqsioz65wa7td7b5@reidt-HP-Z2>
References: <20231201213320.1876892-1-reidt@ti.com>
 <20231201213320.1876892-2-reidt@ti.com>
 <aa7c9ee7-4643-4d2e-a553-8623f85c2ddc@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aa7c9ee7-4643-4d2e-a553-8623f85c2ddc@ti.com>
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

On 09:47-20231205, Kumar, Udit wrote:
> 
> On 12/2/2023 3:03 AM, Reid Tonking wrote:
> > From: Bryan Brattlof <bb@ti.com>
> > 
> > In order for the Cortex-A72s to operate at different frequencies other
> > than the default 2GHz, add in a new 'virtual' mux (a mux that does not
> > physically exist in the clock tree) that can be selected.
> > 
> > CC: Vishal Mahaveer <vishalm@ti.com>
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> > Signed-off-by: Reid Tonking <reidt@ti.com>
> > ---
> >   arch/arm/mach-k3/j7200/clk-data.c | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-k3/j7200/clk-data.c b/arch/arm/mach-k3/j7200/clk-data.c
> > index 9b45786a2d4..126627fff47 100644
> > --- a/arch/arm/mach-k3/j7200/clk-data.c
> > +++ b/arch/arm/mach-k3/j7200/clk-data.c
> > @@ -141,6 +141,11 @@ static const char * const k3_pll_ctrl_wrap_main_0_sysclkout_clk_parents[] = {
> >   	"hsdiv4_16fft_main_0_hsdivout0_clk",
> >   };
> > +static const char * const main_pll8_sel_extwave_out0_parents[] = {
> > +	"pllfracf_ssmod_16fft_main_8_foutvcop_clk",
> > +	"hsdiv0_16fft_main_8_hsdivout0_clk",
> > +};
> > +
> >   static const char * const mcu_obsclk_outmux_out0_parents[] = {
> >   	"mcu_obsclk_div_out0",
> >   	"gluelogic_hfosc0_clkout",
> > @@ -396,6 +401,7 @@ static const struct clk_data clk_list[] = {
> >   	CLK_DIV("hsdiv4_16fft_main_3_hsdivout2_clk", "pllfracf_ssmod_16fft_main_3_foutvcop_clk", 0x683088, 0, 7, 0, 0),
> >   	CLK_MUX_PLLCTRL("k3_pll_ctrl_wrap_main_0_sysclkout_clk", k3_pll_ctrl_wrap_main_0_sysclkout_clk_parents, 2, 0x410000, 0),
> >   	CLK_DIV("k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk", "k3_pll_ctrl_wrap_main_0_sysclkout_clk", 0x410118, 0, 5, 0, 0),
> > +	CLK_MUX("main_pll8_sel_extwave_out0", main_pll8_sel_extwave_out0_parents, 2, 0x688040, 0, 1, 0),
> >   	CLK_DIV("mcu_obsclk_div_out0", "wkup_obsclk_mux_out0", 0x43008000, 8, 4, 0, 0),
> >   	CLK_MUX("mcu_obsclk_outmux_out0", mcu_obsclk_outmux_out0_parents, 2, 0x43008000, 24, 1, 0),
> >   	CLK_PLL("pllfracf_ssmod_16fft_main_4_foutvcop_clk", "main_pll4_xref_sel_out0", 0x684000, 0),
> > @@ -545,11 +551,14 @@ static const struct dev_clk soc_dev_clk_data[] = {
> >   	DEV_CLK(288, 14, "board_0_hfosc1_clk_out"),
> >   	DEV_CLK(288, 15, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
> >   	DEV_CLK(288, 17, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
> > +	DEV_CLK(323, 0, "main_pll8_sel_extwave_out0"),
> > +	DEV_CLK(323, 1, "pllfracf_ssmod_16fft_main_8_foutvcop_clk"),
> > +	DEV_CLK(323, 2, "hsdiv0_16fft_main_8_hsdivout0_clk"),
> >   };
> >   const struct ti_k3_clk_platdata j7200_clk_platdata = {
> >   	.clk_list = clk_list,
> > -	.clk_list_cnt = 109,
> > +	.clk_list_cnt = 110,
> >   	.soc_dev_clk_data = soc_dev_clk_data,
> > -	.soc_dev_clk_data_cnt = 129,
> > +	.soc_dev_clk_data_cnt = 132,
> Can we think of using ARRAY_SIZE for these number clk_list_cnt and
> soc_dev_clk_data_cnt

Good idea - we use that method in dev-data.c too. I'll make that change

-Reid

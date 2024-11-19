Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28551D60079
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 08:18:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 764248952A;
	Tue, 19 Nov 2024 09:18:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kNluOuJ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E5588952A; Tue, 19 Nov 2024 09:18:18 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C02288DED
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 09:18:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ8IDKY004950;
 Tue, 19 Nov 2024 02:18:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732004293;
 bh=rMs5TeP7yVEferyo8Xmp1fJ0151jNCiHc8RD7xNx0tc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=kNluOuJ3X626SfOdxT89S2pDRsSJdxPYPGpzq1Dbq/JwHjpJKvGYbJg0tyBYK8Q3/
 audibaO38+1CuBMNi0x7p16ghUXY3ioF+99xkpCUmTmWhD6m8xkJrswK8grs92ZmVS
 Iy4NVFG7z2aZLQLRy4xAMXevHQWMZ34WelcKvUZ0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJ8IDFB079627
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Nov 2024 02:18:13 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Nov 2024 02:18:13 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Nov 2024 02:18:13 -0600
Received: from localhost (uda0497581.dhcp.ti.com [172.24.227.240])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ8ICKF120428;
 Tue, 19 Nov 2024 02:18:12 -0600
Date: Tue, 19 Nov 2024 13:48:12 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Aniket Limaye <a-limaye@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <nm@ti.com>, <n-francis@ti.com>
Subject: Re: [PATCH v4 4/5] arm: mach-k3: j721e-init.c: Add support for
 CONFIG_K3_OPP_LOW
Message-ID: <20241119081812.ercqfgfsghhgiss6@uda0497581>
References: <20241119003617.1871183-1-a-limaye@ti.com>
 <20241119003617.1871183-5-a-limaye@ti.com>
 <20241119061214.gcruepd4yimqgz2p@uda0497581>
 <cb780efa-ef28-49ea-9009-86424390d136@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cb780efa-ef28-49ea-9009-86424390d136@ti.com>
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

Hi Aniket,

On 13:02-20241119, Aniket Limaye wrote:
> Hi Manorit,
> 
> On 19/11/24 11:42, Manorit Chawdhry wrote:
> > Hi Aniket,
> > 
> > On 06:02-20241119, Aniket Limaye wrote:
> > > The default j7200 devicetree and k3_avs driver set 2GHz/1GHz frequency
> > > for A72/MSMC clks and the OPP_NOM voltage.
> > > 
> > > J7200 SOCs may support OPP_LOW Operating Performance Point:
> > > 1GHz/500MHz clks for A72/MSMC and OPP_LOW AVS voltage read from efuse.
> > > 
> > > Hence, add a config check in board_init_f() to select OPP_LOW specs:
> > > - Check if OPP_LOW AVS voltage read from efuse is valid.
> > > - Use the device IDs and clock IDs (TISCI docs [0]) to find the A72 and
> > >    MSMC clock frequencies in the devicetree.
> > > - Fixup the clock frequencies in devicetree as per OPP_LOW spec.
> > > 
> > > k3_avs driver programs the OPP_LOW AVS voltage for VDD_CPU through
> > > k3_avs_notify_freq() callback from clk_k3.
> > > 
> > > [0]: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html
> > > 
> > > Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> > > ---
> > [..]
> > > ---
> > >   arch/arm/mach-k3/j721e/j721e_init.c | 92 ++++++++++++++++++++++++++++-
> > >   1 file changed, 91 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/j721e/j721e_init.c
> > > index e9ed8cb267c..805b28af8e4 100644
> > > --- a/arch/arm/mach-k3/j721e/j721e_init.c
> > > +++ b/arch/arm/mach-k3/j721e/j721e_init.c
> > > @@ -19,6 +19,7 @@
> > 
> > [..]
> > > +#if defined(CONFIG_CPU_V7R) && defined(CONFIG_K3_AVS0)
> > > +static int get_clock_index_by_dev_id(ofnode node, u32 dev_id, u32 clk_id)
> > 
> > I think the following function can be re-usable by other K3 socs too,
> > can we put it in some common place instead of j721e_init? Maybe clk-k3.c
> > and exported from there?
> > 
> 
> Yeah that does make sense to do... There are already similar usages, I
> think, in other k3 platforms. Having said that I would like to take that up
> as a separate series since the DT index search is not directly related to
> OPP_LOW Perf Point setting for j7200.
> 
> Let me know if you think that the k3 DT clock index search belongs in the
> same series itself...

I mean you did make the function so I think might as well put it in the
correct location but it's a non blocker for me, was just a suggestion.
Would let you see how you want to do it.

> 
> > > +
> > > +static int fdt_fixup_a72ss_clock_frequency(void)
> > > +{
> > > +	int index, size;
> > > +	u32 *rates;
> > > +	ofnode node;
> > > +
> > > +	node = ofnode_by_compatible(ofnode_null(), "ti,am654-rproc");
> > > +	if (!ofnode_valid(node)) {
> > > +		printf("%s: A72 not found\n", __func__);
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	rates = fdt_getprop_w(ofnode_to_fdt(node), ofnode_to_offset(node),
> > > +			      "assigned-clock-rates", &size);
> > > +	if (!rates) {
> > > +		printf("%s: Wrong A72 assigned-clocks-rates configuration\n", __func__);
> > > +		return -1;
> > > +	}
> > > +
> > > +	/* Update A72 Clock Frequency to OPP_LOW spec */
> > > +	index = get_clock_index_by_dev_id(node,
> > > +					  DEV_A72SS0_CORE0_0_ID,
> > > +					  DEV_A72SS0_CORE0_0_ARM_CLK_CLK_ID);
> > > +	if (index < 0 || index >= (size / sizeof(u32))) {
> > 
> > When would we encounter the second if..?
> 
> Assuming you mean:
> 	index >= (size / sizeof(u32))
> 
> The RHS is the count of "assigned-clock-rates" in the node and the LHS
> (index) is the id of the "assigned-clocks".
> It's possible (and I see it in a few cases too) that count of
> "assigned-clocks" > count of "assigned-clock-rates". In that case the
> "index" here, even if parsed correctly, could turn out to be outside of the
> bounds of the array "rates". Which should be check against.

Ah okay, thanks for explaining!

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

Regards,
Manorit

> 
> Regards,
> Aniket
> 
> > 
> > > +		printf("%s: Wrong A72 assigned-clocks configuration\n", __func__);
> > > +		return -1;
> > > +	}
> > > +	rates[index] = cpu_to_fdt32(1000000000);
> > > +	printf("Changed A72 CPU frequency to %dHz in DT\n", 1000000000);
> > > +
> > > +	/* Update MSMC Clock Frequency to OPP_LOW spec */
> > > +	index = get_clock_index_by_dev_id(node,
> > > +					  DEV_A72SS0_CORE0_ID,
> > > +					  DEV_A72SS0_CORE0_MSMC_CLK_ID);
> > > +	if (index < 0 || index >= (size / sizeof(u32))) {
> > > +		printf("%s: Wrong A72 assigned-clocks configuration\n", __func__);
> > > +		return -1;
> > > +	}
> > > +	rates[index] = cpu_to_fdt32(500000000);
> > > +	printf("Changed MSMC frequency to %dHz in DT\n", 500000000);
> > > +
> > > +	return 0;
> > > +}
> > > +#endif
> > [..]
> > 
> > Regards,
> > Manorit

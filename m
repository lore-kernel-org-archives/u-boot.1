Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFF9D591C4
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 06:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDE98894F4;
	Tue, 19 Nov 2024 07:12:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZrQUso3D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFA77894B8; Tue, 19 Nov 2024 07:12:20 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E96B89500
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 07:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJ6CG5S3814587
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 19 Nov 2024 00:12:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731996736;
 bh=78kaMF1LHlXo3fWDyMvlSSrHB4yIV29bYsei3oN+uHo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ZrQUso3DjUQpndS0hrAgihrun2NAqr9eSzHoPLPSnaw4ngSx1+8y1RYCTtH8fJ6SM
 2g55HxGOYQmbxAfl1wJm1vOPomaC+ZIVPnPZkaiDwQie8v0iRgeUaXjwoVmIKa/dwk
 YizWUNwnfzY7WV1j9GazzLEKnFD4Va/pKTBCTGVw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ6CGHT000519;
 Tue, 19 Nov 2024 00:12:16 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Nov 2024 00:12:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Nov 2024 00:12:16 -0600
Received: from localhost (uda0497581.dhcp.ti.com [172.24.227.240])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ6CFTD101517;
 Tue, 19 Nov 2024 00:12:15 -0600
Date: Tue, 19 Nov 2024 11:42:14 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Aniket Limaye <a-limaye@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <nm@ti.com>, <n-francis@ti.com>
Subject: Re: [PATCH v4 4/5] arm: mach-k3: j721e-init.c: Add support for
 CONFIG_K3_OPP_LOW
Message-ID: <20241119061214.gcruepd4yimqgz2p@uda0497581>
References: <20241119003617.1871183-1-a-limaye@ti.com>
 <20241119003617.1871183-5-a-limaye@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241119003617.1871183-5-a-limaye@ti.com>
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

On 06:02-20241119, Aniket Limaye wrote:
> The default j7200 devicetree and k3_avs driver set 2GHz/1GHz frequency
> for A72/MSMC clks and the OPP_NOM voltage.
> 
> J7200 SOCs may support OPP_LOW Operating Performance Point:
> 1GHz/500MHz clks for A72/MSMC and OPP_LOW AVS voltage read from efuse.
> 
> Hence, add a config check in board_init_f() to select OPP_LOW specs:
> - Check if OPP_LOW AVS voltage read from efuse is valid.
> - Use the device IDs and clock IDs (TISCI docs [0]) to find the A72 and
>   MSMC clock frequencies in the devicetree.
> - Fixup the clock frequencies in devicetree as per OPP_LOW spec.
> 
> k3_avs driver programs the OPP_LOW AVS voltage for VDD_CPU through
> k3_avs_notify_freq() callback from clk_k3.
> 
> [0]: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html
> 
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
[..]
> ---
>  arch/arm/mach-k3/j721e/j721e_init.c | 92 ++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/j721e/j721e_init.c
> index e9ed8cb267c..805b28af8e4 100644
> --- a/arch/arm/mach-k3/j721e/j721e_init.c
> +++ b/arch/arm/mach-k3/j721e/j721e_init.c
> @@ -19,6 +19,7 @@

[..]
 
> +#if defined(CONFIG_CPU_V7R) && defined(CONFIG_K3_AVS0)
> +static int get_clock_index_by_dev_id(ofnode node, u32 dev_id, u32 clk_id)

I think the following function can be re-usable by other K3 socs too,
can we put it in some common place instead of j721e_init? Maybe clk-k3.c
and exported from there?

> +
> +static int fdt_fixup_a72ss_clock_frequency(void)
> +{
> +	int index, size;
> +	u32 *rates;
> +	ofnode node;
> +
> +	node = ofnode_by_compatible(ofnode_null(), "ti,am654-rproc");
> +	if (!ofnode_valid(node)) {
> +		printf("%s: A72 not found\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	rates = fdt_getprop_w(ofnode_to_fdt(node), ofnode_to_offset(node),
> +			      "assigned-clock-rates", &size);
> +	if (!rates) {
> +		printf("%s: Wrong A72 assigned-clocks-rates configuration\n", __func__);
> +		return -1;
> +	}
> +
> +	/* Update A72 Clock Frequency to OPP_LOW spec */
> +	index = get_clock_index_by_dev_id(node,
> +					  DEV_A72SS0_CORE0_0_ID,
> +					  DEV_A72SS0_CORE0_0_ARM_CLK_CLK_ID);
> +	if (index < 0 || index >= (size / sizeof(u32))) {

When would we encounter the second if..?

> +		printf("%s: Wrong A72 assigned-clocks configuration\n", __func__);
> +		return -1;
> +	}
> +	rates[index] = cpu_to_fdt32(1000000000);
> +	printf("Changed A72 CPU frequency to %dHz in DT\n", 1000000000);
> +
> +	/* Update MSMC Clock Frequency to OPP_LOW spec */
> +	index = get_clock_index_by_dev_id(node,
> +					  DEV_A72SS0_CORE0_ID,
> +					  DEV_A72SS0_CORE0_MSMC_CLK_ID);
> +	if (index < 0 || index >= (size / sizeof(u32))) {
> +		printf("%s: Wrong A72 assigned-clocks configuration\n", __func__);
> +		return -1;
> +	}
> +	rates[index] = cpu_to_fdt32(500000000);
> +	printf("Changed MSMC frequency to %dHz in DT\n", 500000000);
> +
> +	return 0;
> +}
> +#endif
[..]

Regards,
Manorit

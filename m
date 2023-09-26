Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F4EE7E629
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 11:57:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE7B686A24;
	Tue, 26 Sep 2023 13:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rixl6Wei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C70C86A94; Tue, 26 Sep 2023 13:57:16 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99E1A801B6
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 13:57:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6DiPQvnsZD++65shG/k1eIpCsBTzQXDwVo58l1Yui/toGHEMZxus8aPLVENtTORXhLAXyG6p5IrUjgviJ+6PgWwnPC1mkdeTcaozuSUqAXNf55zr2QID1KtqTJj19sRtt17FtANHGaxcUfiIdjwyadLlyxS8k/7HBxbEZMr3+kSxE5IYXJ3dlngBfKMzrkrGPp2WgIP9O1Lls20h9wpT30RoQhqISLwwcF6gVI1YOP6fK9oxHgIMSgncW0n5zpN4RU39FB3Hces96Q2TEaNhX3jEWe6MC8OVaWn+LPjt75aW4rUMCdGIIasKl0IATx7NjdjNLExtJucbLpr2N3Cyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2iwKO/aihJvHul5MUbANFmhpeF3P6VqmYTL+tseymU=;
 b=n3HEplY4i+FNC7FlBXQFmB9cCYsxHieGmVRtK91WtDC7Sk4rzqFnqCptqPRrlr8syQYYT4hbAE8dpTBpOoFns04ty1dZhNiHEK2/UusMzo5t+Nwu6pW5pT5KrYKheVZdFQKy1IgquaMMveoHkE15M1mQ+HYb403OWFrO9sZWLGYzq175WjSM/VyYt7dhX73wvn/D/SRZCdlJ0mGfnQcX2OR0dkJky9NVj89w4zQV/6SpGPvHjlXBzZyCm73Xcr6+IDCoHqMoy1M5dpsYO3jgp19IauQnTP26axPHdLJThJP6m3NQuMVEmCsEARy56koZO6W7FX+bEjH171rwi+IRiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2iwKO/aihJvHul5MUbANFmhpeF3P6VqmYTL+tseymU=;
 b=Rixl6Wei+cim3r8+0PQZQFhD5gJ1AUNF/RzmFxxYNo0Jf9QWgBtTAvf86KMqJkG7CQkUvW91q50gg0WNmPiFEveW3jeqlv02u+kVgxAkRfsplMmuPt6KP3zfWkHVKVqvECQ4zxEgGTazPRBsAGSOY1lKYnPye3omNNsP3oJMfcQ=
Received: from DS7PR03CA0072.namprd03.prod.outlook.com (2603:10b6:5:3bb::17)
 by MW4PR12MB7031.namprd12.prod.outlook.com (2603:10b6:303:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Tue, 26 Sep
 2023 11:57:08 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::e0) by DS7PR03CA0072.outlook.office365.com
 (2603:10b6:5:3bb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 11:57:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 11:57:08 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 06:56:52 -0500
Message-ID: <c66bed88-f993-4b13-99ab-3162e3b6b982@amd.com>
Date: Tue, 26 Sep 2023 13:56:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: zynq_gem: Update the MDC clock divisor in the probe
 function
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <git@xilinx.com>
References: <20230922045010.22852-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20230922045010.22852-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|MW4PR12MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c074f5-64a2-4d54-7426-08dbbe87b5b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IsOiK7Y47hCN5RTuq4s7+5rB80TyUvitHRhX0FlYxtPbpXWhpzgd3kI3h1MEJXoWTTDEgX1sEaVWTWEcUDTpmOL9yCA2h/3bkBjv07lE4HNL/25oG/5LV+xgtv8vapk6N+U9H+9ntrvSraigy7ugoOU+EK/6Iy10o8kqEFKYsyEd6Cf3Cto/JllD0U6la4dOr7hICuYuNdWzYDOMo+RN8yoVM2gdITev9v3q3REnOCFOBm9lyP0O6CXWnd5ZvT0I3hfWAYN6Ua+x8/D5FIR1nzjfao90IuW7N8KUQTPGOzP39CWkkRNOJiOCpku0dHj1faRS04gxUu3ovgE5m/AY5SBjAw2v5XDssFO51uYvzGlUbPXczukqXnCsVoo7cHacYtG0YKK3wHPpMA90OtNfHUaXEYBw2l7rdJIOkJyhcEeHxvyIl/z9a/GEc6NNkxjZ7szpCU2xiV7j/UPoDepaWxiLoMOPQoEBbmbqea4jMvX86+vJ/TfX6ts71juvTBbmrMlaIUuTMkPflggcWdIH4O907WNZETOdtuVsN45RPE+YPyO56rHJQzxzS3LNSgbCaQUAttSO3yFTcFAlEWMn42CIt3aUN/Fa2iI/JrZ5TH5dGBeKPCOxGpag+q9uFxZ1L84A/FMkeV13Uic0n/MnAtjWekJkvfgpoODz5BjfbExnUStQZoz86YxHPVHOXxvmgG5/dg0NEYuL/O3uH5AYX2oQPFweRrmqVQmovBBP6Gy4RRSGkDrIrzsPKkDG3hGf4A4WZeSYCdPGpwdJWW8Bv7UxDoo2Znk/J61TxqwpSo3dhV0wJgnKssV8KI/JuB03
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(53546011)(8936002)(44832011)(336012)(478600001)(70206006)(70586007)(31686004)(110136005)(54906003)(8676002)(316002)(83380400001)(16576012)(36860700001)(107886003)(40460700003)(16526019)(5660300002)(82740400003)(31696002)(40480700001)(4326008)(86362001)(2906002)(81166007)(41300700001)(26005)(2616005)(426003)(47076005)(36756003)(356005)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 11:57:08.0837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c074f5-64a2-4d54-7426-08dbbe87b5b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7031
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



On 9/22/23 06:50, Venkatesh Yadav Abbarapu wrote:
> MDC clock change needs to be done when the driver probe function
> is called as mdio is enabled at probe and not when the ethernet starts.
> Setup the MDC clock at the probe itself.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/net/zynq_gem.c | 73 +++++++++++++++++++++++-------------------
>   1 file changed, 40 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
> index f3cdfb0275..f7a7897d9c 100644
> --- a/drivers/net/zynq_gem.c
> +++ b/drivers/net/zynq_gem.c
> @@ -321,11 +321,38 @@ static int zynq_gem_setup_mac(struct udevice *dev)
>   	return 0;
>   }
>   
> +static u32 gem_mdc_clk_div(struct zynq_gem_priv *priv)
> +{
> +	u32 config;
> +	unsigned long pclk_hz;
> +
> +	pclk_hz = clk_get_rate(&priv->pclk);
> +	if (pclk_hz <= 20000000)
> +		config = GEM_MDC_SET(GEM_CLK_DIV8);
> +	else if (pclk_hz <= 40000000)
> +		config = GEM_MDC_SET(GEM_CLK_DIV16);
> +	else if (pclk_hz <= 80000000)
> +		config = GEM_MDC_SET(GEM_CLK_DIV32);
> +	else if (pclk_hz <= 120000000)
> +		config = GEM_MDC_SET(GEM_CLK_DIV48);
> +	else if (pclk_hz <= 160000000)
> +		config = GEM_MDC_SET(GEM_CLK_DIV64);
> +	else if (pclk_hz <= 240000000)
> +		config = GEM_MDC_SET(GEM_CLK_DIV96);
> +	else if (pclk_hz <= 320000000)
> +		config = GEM_MDC_SET(GEM_CLK_DIV128);
> +	else
> +		config = GEM_MDC_SET(GEM_CLK_DIV224);
> +
> +	return config;
> +}
> +
>   static int zynq_phy_init(struct udevice *dev)
>   {
> -	int ret;
> +	int ret, val;
>   	struct zynq_gem_priv *priv = dev_get_priv(dev);
>   	struct zynq_gem_regs *regs_mdio = priv->mdiobase;
> +	struct zynq_gem_regs *regs = priv->iobase;
>   	const u32 supported = SUPPORTED_10baseT_Half |
>   			SUPPORTED_10baseT_Full |
>   			SUPPORTED_100baseT_Half |
> @@ -333,6 +360,10 @@ static int zynq_phy_init(struct udevice *dev)
>   			SUPPORTED_1000baseT_Half |
>   			SUPPORTED_1000baseT_Full;
>   
> +	val = gem_mdc_clk_div(priv);
> +	if (val)
> +		writel(val, &regs->nwcfg);
> +
>   	/* Enable only MDIO bus */
>   	writel(ZYNQ_GEM_NWCTRL_MDEN_MASK, &regs_mdio->nwctrl);
>   
> @@ -360,35 +391,10 @@ static int zynq_phy_init(struct udevice *dev)
>   	return phy_config(priv->phydev);
>   }
>   
> -static u32 gem_mdc_clk_div(struct zynq_gem_priv *priv)
> -{
> -	u32 config;
> -	unsigned long pclk_hz;
> -
> -	pclk_hz = clk_get_rate(&priv->pclk);
> -	if (pclk_hz <= 20000000)
> -		config = GEM_MDC_SET(GEM_CLK_DIV8);
> -	else if (pclk_hz <= 40000000)
> -		config = GEM_MDC_SET(GEM_CLK_DIV16);
> -	else if (pclk_hz <= 80000000)
> -		config = GEM_MDC_SET(GEM_CLK_DIV32);
> -	else if (pclk_hz <= 120000000)
> -		config = GEM_MDC_SET(GEM_CLK_DIV48);
> -	else if (pclk_hz <= 160000000)
> -		config = GEM_MDC_SET(GEM_CLK_DIV64);
> -	else if (pclk_hz <= 240000000)
> -		config = GEM_MDC_SET(GEM_CLK_DIV96);
> -	else if (pclk_hz <= 320000000)
> -		config = GEM_MDC_SET(GEM_CLK_DIV128);
> -	else
> -		config = GEM_MDC_SET(GEM_CLK_DIV224);
> -
> -	return config;
> -}
>   
>   static int zynq_gem_init(struct udevice *dev)
>   {
> -	u32 i, nwconfig;
> +	u32 i, nwconfig, nwcfg;
>   	int ret;
>   	unsigned long clk_rate = 0;
>   	struct zynq_gem_priv *priv = dev_get_priv(dev);
> @@ -494,8 +500,7 @@ static int zynq_gem_init(struct udevice *dev)
>   		return -1;
>   	}
>   
> -	nwconfig = gem_mdc_clk_div(priv);
> -	nwconfig |= ZYNQ_GEM_NWCFG_INIT;
> +	nwconfig = ZYNQ_GEM_NWCFG_INIT;
>   
>   	/*
>   	 * Set SGMII enable PCS selection only if internal PCS/PMA
> @@ -509,19 +514,21 @@ static int zynq_gem_init(struct udevice *dev)
>   
>   	switch (priv->phydev->speed) {
>   	case SPEED_1000:
> -		writel(nwconfig | ZYNQ_GEM_NWCFG_SPEED1000,
> -		       &regs->nwcfg);
> +		nwconfig |= ZYNQ_GEM_NWCFG_SPEED1000;
>   		clk_rate = ZYNQ_GEM_FREQUENCY_1000;
>   		break;
>   	case SPEED_100:
> -		writel(nwconfig | ZYNQ_GEM_NWCFG_SPEED100,
> -		       &regs->nwcfg);
> +		nwconfig |= ZYNQ_GEM_NWCFG_SPEED100;
>   		clk_rate = ZYNQ_GEM_FREQUENCY_100;
>   		break;
>   	case SPEED_10:
>   		clk_rate = ZYNQ_GEM_FREQUENCY_10;
>   		break;
>   	}
> +	nwcfg = readl(&regs->nwcfg);
> +	nwcfg |= nwconfig;
> +	if (nwcfg)
> +		writel(nwcfg, &regs->nwcfg);
>   
>   #ifdef CONFIG_ARM64
>   	if (priv->interface == PHY_INTERFACE_MODE_SGMII &&

Applied.
M

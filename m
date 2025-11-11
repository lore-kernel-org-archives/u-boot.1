Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4283CCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 13:09:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FEE283FA5;
	Tue, 11 Nov 2025 14:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VhV/jXhu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7668983B5B; Tue, 11 Nov 2025 11:05:07 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDF8383AB4
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 11:05:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXWPGlHbkd+MxaagYWWEdcVryDcKWAIizCqCpt0YgefkeSTLQGIfd+3rGr4Ob3zfXN1Vd00thdzDeoCcVYc03ZerUqh0TzCESe4z6arjARAurhzfFjp5KW5aM2opHDF7cXpwNNNz300KrPzXqtzUWiccD7x2yYBZa0nCR3QJssv+hIigqy4BADrNWrZlTJjbm25/L6s36pqeykssUztU2uuNamyidV9KiOcJdMzb9ieDRCOzZJyy/0BAoDV/a3+OMpBd59xvuKSa7QN1+KL0YnPZi0fb16tfwsM+aguHKS389vVDaBWH/++ieZAak50ZEog88Jw5z/mTJviL32J+Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qx67cDDgqjcrd6RV2PvPstoX4oGcnJacvPkemSxWqig=;
 b=nHShCUwgG88LoVuVBmc9nPRyCNV1V0DBE8q3FTzbo2ldPKBKbUIHYQm4Skk72rrKV3ccDa2iPbHQ7EZVIdn5zHy89Bh30RELdiPI+UbyWRhV0XCQTvUe9ckWRtb0Q/zrhcOxcYQ2aRsVpgm5Y09Dhj9+ibd28EbrLCUUPxqHeLfJZWuVseT15nau5rAAiTECglrX5ELRBvEz2SIyLbyYmYyJrTDJxcX5Dh/mGcfKBzihPO8CMKEbDFPVXheV2UbiC+qjKbk6/FzGcPboIuHlwwuObGUtAg+8aOchxmq+rboxVdlTxfqYrda1uHc+Ec+tYhBflHa1P6EWRZYR5nTh8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qx67cDDgqjcrd6RV2PvPstoX4oGcnJacvPkemSxWqig=;
 b=VhV/jXhuxHUgPBE3jAKiuWLwdY5F8W0lHmcJ6VvYXBCzFHMI5758r5cBaX+u7A/RBTXdjD3wdTnGWGeWaBV+CEZbotHaD//M8ZIIunByirHjcwDF2VVx0u0ezGY/pD9ZQd2m2IKg5S1cxKDcaE0/1xTnw56+2sRIOqPOAts0Hos=
Received: from BL1PR13CA0122.namprd13.prod.outlook.com (2603:10b6:208:2bb::7)
 by MW4PR10MB6584.namprd10.prod.outlook.com (2603:10b6:303:226::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 10:05:01 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::7b) by BL1PR13CA0122.outlook.office365.com
 (2603:10b6:208:2bb::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 10:04:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 10:04:59 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 04:04:49 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 04:04:40 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 04:04:40 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ABA4duC738386;
 Tue, 11 Nov 2025 04:04:39 -0600
Date: Tue, 11 Nov 2025 15:34:38 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
CC: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Vishal Mahaveer
 <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, Sebin Francis
 <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, Akashdeep Kaur
 <a-kaur@ti.com>, <u-boot@lists.denx.de>, Anshul Dalal <anshuld@ti.com>,
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, Nathan Morrisson
 <nmorrisson@phytec.com>, Garrett Giordano <ggiordano@phytec.com>, "Judith
 Mendez" <jm@ti.com>, Aparna Patra <a-patra@ti.com>, Jayesh Choudhary
 <j-choudhary@ti.com>, Chintan Vankar <c-vankar@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, Devarsh Thakkar
 <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Andre Przywara
 <andre.przywara@arm.com>, =?utf-8?B?VGjDqW8=?= Lebrun
 <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v5 03/13] ram: k3-ddrss: Add support for DDR in
 self-refresh
Message-ID: <20251111100438.7wx76yhe34bdnj3x@lcpd911>
References: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-0-980ee0036c26@baylibre.com>
 <20251110-topic-am62-ioddr-v2025-04-rc1-v5-3-980ee0036c26@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-3-980ee0036c26@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|MW4PR10MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c7d8a1-f23b-4a1c-9717-08de2109c648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VxLfmPZu6yOXNwGWC16jkTG7xYov7Ai6Ln/Vcr5nj0unCnt7NhOyFyKgdpdP?=
 =?us-ascii?Q?cxbj5yw343gKMEGDJN3k8VeqzbF2LNYwN7JZsHXmWP7gaA+a8pqtnrV29z4n?=
 =?us-ascii?Q?R9evLlwvesu1Q0ltXaN9ItLxQgAv7H6OgkXfE3fb0A+tzRJjA9yH36HEdlz4?=
 =?us-ascii?Q?6+yuAbp6Dk/QjhGZFXhU5opkzaEdotkE4Zx7Hk20kmZZow8O5WxYFZIdWDNL?=
 =?us-ascii?Q?ZV2FJ47xgIgdhMGBUMy5VbrPeZjgni62AgYWyt+9a5eUO8LfpcIGXVqzdisg?=
 =?us-ascii?Q?j8CakJua/PKrBQ78p70NOtAASK3eQOzqLCOXKZfBbFcBObf2XQJKsKbAwBfy?=
 =?us-ascii?Q?3HOz72trAsz7B0lSM8bsd02zFYUX0nohHcg9Dibt/yA3pYML5vQTWHKu14hx?=
 =?us-ascii?Q?umX5+d3k3tC9RqBrZYmm0S6hBcEzkGafqzUJjZc8TzDGPTiQ4Vz7HzuZy2Vy?=
 =?us-ascii?Q?n86l59y9Io17+XZcxGQOlFmxYaRTvdutr4TjCPBjwvDUqK6PBlOKkxeJI4gM?=
 =?us-ascii?Q?qdRqcm4Tqbb5nswSsig/auEReX5x8HVaZoezbRtH4xqU2xtcfYQSUFhOg7NT?=
 =?us-ascii?Q?FQnsNqtN6dcQvxMtc/ljBUfs9T5WdiIDIm5Rn0pPmSZa83fWm2ndvQASPfEM?=
 =?us-ascii?Q?AOvEkO+vjL/a2JTCslEg9ckO3TRVQ9za9oIf3ujrvEXVGHSQbXTZ2LgF2RfR?=
 =?us-ascii?Q?Z16vOKatxnq30Q0It8d2oon4bIt4OYJX0oZVTzvMPunUzk8h73RLB7r31D2s?=
 =?us-ascii?Q?YcOg9T0rrmMTZpRUZ7NFl5AoBR2aYMUHGeu1mtxgxehUvviP70LSpBKRmEnG?=
 =?us-ascii?Q?gtISa0C0uhub4J9FRLQ5wfGw/gbfkVN6s93vAIn0Nx3RlDgdhiiMfmM3UmKT?=
 =?us-ascii?Q?r5yh0btrlpio6RU4IvHYjEpy/yFLbOyjXFEHGqM8AdPz1HJVd0XM/ZNCPNuf?=
 =?us-ascii?Q?O+KydYyJw2lG9rpawrMlGFsS/zdJqT3jIbQY3r0a8vlg1tWifSfeuP34atAi?=
 =?us-ascii?Q?UY59KYTaYZwZQ8jop3EMxT47efw9OWRBnKoUX5BVLnulnJbg8sKu4n9Asxc8?=
 =?us-ascii?Q?v6RN6Pf/MVFMOcpMaB1ggxYHG8AWQjch6n1n7MUX1o2qQvzCAr4qxfpuy3II?=
 =?us-ascii?Q?AA3GZ7Qyj0QpJBRyh/AIEdzr07nqUouhGmDGSF120e326QNnL8t537QuA5Wu?=
 =?us-ascii?Q?/lP016DbVHVfnfs1Tr6+i+eCpAFugGvEX0FKVBTgLMyb2c+3+tl/LxYQ7DM9?=
 =?us-ascii?Q?Xhy/9ddIvGTAFssDGX21im6SRdR6tIYIIs5Lm8DZeC3XqBs1sgqJgFM8U9zW?=
 =?us-ascii?Q?v4jZkxBQzxo+/wl6//PUXVmrN1pFTbEFuyJe3aFwwv740B5phAhh3Eo/Oqge?=
 =?us-ascii?Q?YoyzsjYqB1ezKD9ceMb1HD0E9UmPkflUhVmjH93zfIduNDkD20wniDGcNIbc?=
 =?us-ascii?Q?oPw5I1TZaUUsV2Jabqhrb9cE4r7eT5qSoUCBQtKd+FLxbf2NFfFlpUOY2qXR?=
 =?us-ascii?Q?Dj7AhmenPUiw9CSXwixfYCRZrT+syjhqPP3y4ZobtBZ2gWVSo5Gnj3sJLK4B?=
 =?us-ascii?Q?EXFHQjVte5NXx1/J8eg=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 10:04:59.7170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c7d8a1-f23b-4a1c-9717-08de2109c648
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6584
X-Mailman-Approved-At: Tue, 11 Nov 2025 14:08:29 +0100
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

On Nov 10, 2025 at 21:10:27 +0100, Markus Schneider-Pargmann (TI.com) wrote:
> In IO+DDR the DDR is kept in self-refresh while the SoC cores are
> powered off completely. During boot the normal initialization routine of
> DDR is slightly different to exit self-refresh and keep the DDR contents.
> 
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>  drivers/ram/k3-ddrss/k3-ddrss.c | 177 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 177 insertions(+)
> 
> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
> index 5144470b931384534e78fbfcea5e66b7083c9f07..5aca55129326ab4f369ae6e4f2c048df6e971eff 100644
> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
> @@ -57,6 +57,16 @@
>  #define DDRSS_V2A_INT_SET_REG_ECC2BERR_EN	BIT(4)
>  #define DDRSS_V2A_INT_SET_REG_ECCM1BERR_EN	BIT(5)
>  
> +#define K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL			0x430080d0
> +#define K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD		BIT(31)
> +#define K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RETENTION_MASK	GENMASK(3, 0)
> +
> +#define K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1			0x4301830c
> +#define K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE	BIT(0)
> +
> +#define K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT		0x43018318
> +#define K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
> +
>  #define SINGLE_DDR_SUBSYSTEM	0x1
>  #define MULTI_DDR_SUBSYSTEM	0x2
>  #define MAX_MULTI_DDR 4
> @@ -211,6 +221,32 @@ struct reginitdata {
>  #define DENALI_CTL_0_DRAM_CLASS_DDR4		0xA
>  #define DENALI_CTL_0_DRAM_CLASS_LPDDR4		0xB
>  
> +#define K3_DDRSS_CFG_DENALI_CTL_20				0x0050
> +#define K3_DDRSS_CFG_DENALI_CTL_20_PHY_INDEP_TRAIN_MODE		BIT(24)
> +#define K3_DDRSS_CFG_DENALI_CTL_21				0x0054
> +#define K3_DDRSS_CFG_DENALI_CTL_21_PHY_INDEP_INIT_MODE		BIT(8)
> +#define K3_DDRSS_CFG_DENALI_CTL_106				0x01a8
> +#define K3_DDRSS_CFG_DENALI_CTL_106_PWRUP_SREFRESH_EXIT		BIT(16)
> +#define K3_DDRSS_CFG_DENALI_CTL_160				0x0280
> +#define K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_MASK			GENMASK(14, 8)
> +#define K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_ENTRY		BIT(9)
> +#define K3_DDRSS_CFG_DENALI_CTL_169				0x02a4
> +#define K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_EXIT_EN_MASK	GENMASK(27, 24)
> +#define K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_ENTRY_EN_MASK	GENMASK(19, 16)
> +#define K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_MASK		GENMASK(14, 8)
> +#define K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_SHIFT		8
> +#define K3_DDRSS_CFG_DENALI_CTL_345				0x0564
> +#define K3_DDRSS_CFG_DENALI_CTL_345_INT_STATUS_LOWPOWER_SHIFT	16
> +#define K3_DDRSS_CFG_DENALI_CTL_353				0x0584
> +#define K3_DDRSS_CFG_DENALI_CTL_353_INT_ACK_LOWPOWER_SHIFT	16
> +#define K3_DDRSS_CFG_DENALI_PI_6				0x2018
> +#define K3_DDRSS_CFG_DENALI_PI_6_PI_DFI_PHYMSTR_STATE_SEL_R	BIT(8)
> +#define K3_DDRSS_CFG_DENALI_PI_146				0x2248
> +#define K3_DDRSS_CFG_DENALI_PI_150				0x2258
> +#define K3_DDRSS_CFG_DENALI_PI_150_PI_DRAM_INIT_EN		BIT(8)
> +#define K3_DDRSS_CFG_DENALI_PHY_1820				0x5C70
> +#define K3_DDRSS_CFG_DENALI_PHY_1820_SET_DFI_INPUT_2_SHIFT	16
> +
>  #define TH_OFFSET_FROM_REG(REG, SHIFT, offset) do {\
>  	char *i, *pstr = xstr(REG); offset = 0;\
>  	for (i = &pstr[SHIFT]; *i != '\0'; ++i) {\
> @@ -864,6 +900,132 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
>  	writel(val, base + DDRSS_ECC_CTRL_REG);
>  }
>  
> +static void k3_ddrss_reg_update_bits(void __iomem *addr, u32 offset, u32 mask, u32 set)
> +{
> +	u32 val = readl(addr + offset);
> +
> +	val &= ~mask;
> +	val |= set;
> +	writel(val, addr + offset);
> +}
> +
> +static void k3_ddrss_self_refresh_exit(struct k3_ddrss_desc *ddrss)
> +{
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_CTL_169,
> +				 K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_EXIT_EN_MASK |
> +				 K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_ENTRY_EN_MASK,
> +				 0x0);
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_PHY_1820,
> +				 0,
> +				 BIT(2) << K3_DDRSS_CFG_DENALI_PHY_1820_SET_DFI_INPUT_2_SHIFT);
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_CTL_106,
> +				 0,
> +				 K3_DDRSS_CFG_DENALI_CTL_106_PWRUP_SREFRESH_EXIT);
> +	writel(0, ddrss->ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_PI_146);
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_PI_150,
> +				 K3_DDRSS_CFG_DENALI_PI_150_PI_DRAM_INIT_EN,
> +				 0x0);
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_PI_6,
> +				 0,
> +				 K3_DDRSS_CFG_DENALI_PI_6_PI_DFI_PHYMSTR_STATE_SEL_R);
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_CTL_21,
> +				 K3_DDRSS_CFG_DENALI_CTL_21_PHY_INDEP_INIT_MODE,
> +				 0);
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_CTL_20,
> +				 0,
> +				 K3_DDRSS_CFG_DENALI_CTL_20_PHY_INDEP_TRAIN_MODE);
> +}
> +
> +static void k3_ddrss_lpm_resume(struct k3_ddrss_desc *ddrss)
> +{
> +	int ret;
> +	unsigned long timeout_start;
> +
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_CTL_160,
> +				 K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_MASK,
> +				 K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_ENTRY);
> +	ret = wait_for_bit_32(ddrss->ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_CTL_345,
> +			      (1 << K3_DDRSS_CFG_DENALI_CTL_345_INT_STATUS_LOWPOWER_SHIFT),
> +			      true, 5000, false);

Magic number 5000... It can be #defined out as a TIMEOUT

> +	if (ret)
> +		panic("Failed waiting for low power command %d\n", ret);
> +
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_CTL_353,
> +				 0,
> +				 1 << K3_DDRSS_CFG_DENALI_CTL_353_INT_ACK_LOWPOWER_SHIFT);
> +
> +	timeout_start = get_timer(0);
> +	while (1) {
> +		if (get_timer(timeout_start) > 5000)
> +			panic("Failed waiting for low power state\n");
> +
> +		if ((readl(ddrss->ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_CTL_169) &
> +		     K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_MASK) ==
> +		    0x40 << K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_SHIFT)
> +			break;
> +	}
> +}
> +
> +static void k3_ddrss_deassert_retention(struct k3_ddrss_desc *ddrss)
> +{
> +	int ret;
> +
> +	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
> +				 0x0,
> +				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD |
> +				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RETENTION_MASK,
> +				 0);
> +	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
> +				 0x0,
> +				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
> +				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD);
> +
> +	ret = wait_for_bit_32((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
> +			      K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
> +			      true, 5000, false);

Magic num, same comment as above

Reviewed-by: Dhruva Gole <d-gole@ti.com>



-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

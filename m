Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C261C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 07:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4254D84105;
	Mon, 29 Jun 2026 09:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="QfpsaXpx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5AB9841F2; Mon, 29 Jun 2026 09:29:48 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 197878056B
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 09:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlSW/KTB6fnMBKRjP6GJDIHmnuvy1KkalflQh0AMH0/1t15IuAbOwMedRcSKfU2fHLaj4Tt1/ChsdR8RjyQ74D61ZwAI8HzD08ip1wn3cN5xDCT1KT8MrqwtR2Z1u1ClqKSpNHQ3Hx2YcKLsbD8OeEmpR+NzEW7r9YUXsasy0mt75aFqVXvXqTnXomRyiQ3Jv/JsCgAEpaVhOeJN+Bk81GNYEWIJn5r/j0rAW4Ne9vFu0JD8a3CMXBE5/05CLMSGf1V+FmuJGb7NN39vRWQ9w+J+USayyMhJe5yi0MEiZ+TYeFrLylGqcJNkoVV6IIf4GTVzJlAN0/gQJseVNGyymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4C31v6xUjnq3EeGeGVf0cWSIdwJDCkvlo+/D0SQGphA=;
 b=K7Z9QY4pBuiEkmgYFWnNNd1vDvqOTV6ErnkOe5TFKQWmfO011obDj+bKEIETdgTjuyzASQVG1azJjHHJ73bxtW2npk6IkMgTSjwhRe0WxhOS56SzeGhM16xbmTbTDlvWBA08uM95YaPDim6ioYXEiuCFycEQeFTYd7xwzHPEhSENWyNyY3vg+en3D3xGvMx57h0lP64hNnSXFze7e5UzSO/20ZsutcuKCeDG07kPe8NKWoIAkm6tKbR9eTviEJLU4dDn1RuAb0HECpB92PiNoycH8epjWsooZIUvl6A14RKchrx6BR2dcKvy5xee5xCOlKhGPV/NFZPpdK16WWzNDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=amarulasolutions.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4C31v6xUjnq3EeGeGVf0cWSIdwJDCkvlo+/D0SQGphA=;
 b=QfpsaXpx0i+g+LQ/caS0nduum0J2AbUTPf5ET2XaQMUUEOxs92zPs65+RIxWOv98fB3AnLxiP/yKWt0B9/7cK+k5/W5+Nb+tfR5Aq9HJGrcUFAFzc4nr8MRyUgjAoFAznSEOGA/VHpMrYGMdOBycHd1kv9dU0Dzl76wFoH0SX91ZrRngLnzkJxfVJoThyi1HSmp39oZZFyCHLo0DccvyKOyUGf7ZAZTps2KWZJFZYOEHM1R2GlvSjFzdVaP+1DYm5qCfFtebhCuOrfL+Ap98d0lRLjFBiOq+eRE5/OErOZmLXIB4hf95FrOHtIDiyixI5VAGXegQBSM6BqhlVAhypQ==
Received: from DB8PR04CA0016.eurprd04.prod.outlook.com (2603:10a6:10:110::26)
 by PAVPR10MB7306.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 07:29:41 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:110:cafe::61) by DB8PR04CA0016.outlook.office365.com
 (2603:10a6:10:110::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 07:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 07:29:40 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 29 Jun
 2026 09:33:55 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 29 Jun
 2026 09:29:39 +0200
Message-ID: <8aab07b8-9a23-4c0d-a2f9-3943f6490a60@foss.st.com>
Date: Mon, 29 Jun 2026 09:29:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: dts: stm32: add U-Boot specific dtsi for
 stm32mp157f-dk2
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, <michael@amarulasolutions.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20260529153159.3944049-1-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260529153159.3944049-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FC:EE_|PAVPR10MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a05a472-3fa0-4214-3832-08ded5b02ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|6133799003|11063799006|18002099003|22082099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: KOm6+/EBUm2vFNl3jTJAD8NdfN/hkygUVDL2BxeSa8QikCJcbwgkpd95f9Z84zYxiUTz2t9S1yG4uSS3TDeetNQuuLY/EP7tIZx+VnG1tU9L8XRa25385hzu7yY/fBShhZbWxIajgfJY76mE/tjnOLyrk5QBOXAg5r/qZSi2c3VFUYEw417khMAX1SrSmys1CcX0uCLQQ+blOMPAZJ/Q26p8vULf3qilZnLRzeeZJsOmDM58gLrl7+xNQDPqRsmuX1VJ5fQTdPvbyD0/cqrOPba02VLibo5F7n69eEW+5qA4moOUfMMNEp4bIieP0CpOpfIbyGbn61dU7HfIC0pUwZFQ/GWz5NI8dvuoGj+y967OVNHTbDlw+VXppn6VC+NG8SlCpqqhpPfSV+KU6MQEDavxEIhJ+zqcLG0iAbsr6UR3yp4tNJDsmshdJgFrRv4wVILtk8A6zSdXvTBueYlM8+bxdmqzdS1PoAXtgwyQOA4jucZa2EqgpxtkrXWNJMDVC7fZfy/H4TLoDVcSrChxagA7CUSXS3fZ0o6zWKn3PgsXuYmOoKlM7WXi+2IdCavFPUmYOsLrLO/8ZZiO9vJvVSJZKFcM4g6+lAgiaErpaky+YSFSV2TwcAkFv0s1mlKNUBPONrclpJkipjWlLz7CWl6fz4uH6xUQmeH573IQg4o/JuccNxPlt65NJLDR2v+xAD3MIuGBBFi1SpMePtfgtw==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(6133799003)(11063799006)(18002099003)(22082099003)(56012099006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x+av0w7XlK7qJyDlUHpBgRg8olTRxmZfD+axTgZMiGCbIKxwaMIWO6vtADjLwSUyuVUzr8satGt9ots+rRYlfLXG4+qwt7Fc+LC5APny8BXXokJJ9XdPCBHz1ULTS5jm0++oCFbdtHjf7x/+Q5dIzQUzSFlaqeH5lMux/l53rXA5jsuHhqZdwgyxduvIxUCLQhGKUCfsp5rHj19O44LddqV0XU4KMj0c5XxfaX7dPvHa4aF6UxvIQ3iUmOs1oXG4ygt343qTL5vHRfoAcCpn67C43zjFEyMgs0KvxWEFT+T/qYJEO/zzG3MIeZrk1POkDVZry7Mi+WxYBLB+Ur8gaaNmDwqdIsR35zKdr2TAILouQxVgMV67DSkJjIbs8GBJjLe59lVTmm6CIQHalqPSag8Qw1RhLnlk71C0JSQ9xL5Hlgo6SUZkXJN8hSuOsach
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 07:29:40.7439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a05a472-3fa0-4214-3832-08ded5b02ec2
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7306
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



On 5/29/26 17:31, Dario Binacchi wrote:
> The STM32MP157F-DK2 board is a direct derivative of the STM32MP157C-DK2.
> As explained by ST [1], the "STM32MP157F-DK2 is assembled with latest
> STM32MP15 RevZ cut which is the only one available for new product now.
> The major differences in this 'F' variant SoC are the increased max
> frequency of the Cortex-A7 cores and the correction of some HW bugs
> (Device Rev.Z, see errata ES0438)".
> 
> On the software/architecture side, this variant utilizes SCMI (System
> Control and Management Interface) for secure world resource management.
> As a consequence, the underlying stm32mp15-scmi.dtsi explicitly deletes
> several fixed clock nodes (such as clk_hse, clk_hsi, clk_lse, clk_lsi,
> and clk_csi), making it impossible to include stm32mp157c-dk2-u-boot.dtsi
> without triggering compilation errors due to these missing clock labels.
> 
> So let's introduce a dedicated stm32mp157f-dk2-u-boot.dtsi that directly
> defines the fwu-mdata node. This provides the necessary FWU metadata
> configuration required to allow automatic A/B bank selection, supported
> for STM32MP15 boards by commit 560d8f32703f ("board: st: stm32mp15:
> support dynamic A/B bank bootup").
> 
> [1] https://community.st.com/t5/stm32-mpus-products-and-hardware/i-m-wondering-what-s-the-difference-point-between-stm32mp157c/td-p/213460
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
> Changes in v2:
> - Drop the inclusion of stm32mp157c-dk2-u-boot.dtsi to avoid compilation
>   errors caused by deleted clock nodes in stm32mp15-scmi.dtsi.
> - Directly define the fwu-mdata node in stm32mp157f-dk2-u-boot.dtsi to
>   properly support automatic A/B bank selection.
> 
>  arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi b/arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi
> new file mode 100644
> index 000000000000..77805417bfa9
> --- /dev/null
> +++ b/arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
> + */
> +
> +/ {
> +	fwu-mdata {
> +		compatible = "u-boot,fwu-mdata-gpt";
> +		fwu-mdata-store = <&sdmmc1>;
> +	};
> +};

Hi Dario

What about including stm32mp157c-dk2-u-boot.dtsi instead of defining fwu-mdata node ?

Thanks
Patrice

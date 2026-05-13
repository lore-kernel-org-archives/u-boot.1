Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD7BCD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 06:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC148838BB;
	Wed, 13 May 2026 08:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="RuVeZ3Jh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6021C83EEF; Wed, 13 May 2026 08:45:07 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F43F8341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 08:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bH8K3O8lD2T+UGLFJHBxGk4txE6vbiSEUhVfoTVRm3TB+irM28/Q5B8M1UInjHpWgze+3LtzLrZwMZge4zwto2lJ8TQymfrdl6QWm7nV9ROXrqdC7WYQMqWE7g7765X05lHby83rJimImQkmVkpcBI0MImFbgBWcfBPu30aKE39DGCV2CfNlYrv1dBNl1FW5jGamGHcp7Vgge/okDySETMrbXXGNMelC3v0Wu3oceWXLu/tgxBVS+ERP/jpmiQ+e1CQ27B7xMSzUZqSSOOVEMRqFHXuak4p7FT8JbYS0NbRnUFAqBpS/cwx/tTIJ9GuOW9h4/3CX1xTiahKeFNjZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oI/H8n9dz8hLdAys/UyqZWFRN5igMBS40Je/Qa0Jv4E=;
 b=t32Sod1ubT0748TCesW5hAU+LGGkgN6uiVnKXLLtCT23HnAkD8iDij7Cdpf+g9n7X42oehts+I4i4qfTcx84XpIWLM+OynjO1YcfGvLR+gJgsgFe+qDkgZFoIGlNkVnOyKL+DnGE7LkKReViwYQwbudB0rUrVS9vKyL4+gAfmuY8YByLI+z53yWSlEWSIiTI6+4vgvlTkcYbjk9k4O2duOaH8iMZ77TTe4G33fTE5kOhdngRaBXtd2aZ59hwnbeOw3cuw0Km0KH69J9y+t8jGRYeqyw+UVh+EC9P3lQ/eTEc3epEvojxJkFiPhKWf+fzChWVOzJ+mZlSiwA9lwmySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=amarulasolutions.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oI/H8n9dz8hLdAys/UyqZWFRN5igMBS40Je/Qa0Jv4E=;
 b=RuVeZ3Jh9pysaBPIKg8MYV3DF/VLJfssGO6irYhc3oBSg9KoGfEYQaTrBrrlXFUBvkNuJmna6Xf/xuHamKRYyx5gI5hN7iUzow3mhTL+KKEwwwYBDJs7To/Vslcuu9+0LypU3CwxYu1Xt9lHK85qjzKVow6BSfh//aJigPzROWbkzzmCk+x+58ta9txa4Xa0elZXW5Sw7bUuI45pWg1UPzqI37Spf2cXLpUvZPWiNxKu8UsYoWVfvBmGNAP28CTvIm8QcDueJR4iiahvULRIXNZOymEzRYBVpL2sEkwz4Pz2eRBUftwdAmBd6McOGVY+I+dqFr5qO/2vN46Hgq+jFg==
Received: from AS4PR09CA0022.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::14)
 by PA2PR10MB8909.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:425::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 06:44:58 +0000
Received: from AMS0EPF0000019E.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::6d) by AS4PR09CA0022.outlook.office365.com
 (2603:10a6:20b:5d4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 06:44:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF0000019E.mail.protection.outlook.com (10.167.16.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 06:44:58 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 13 May
 2026 08:48:24 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 13 May
 2026 08:44:57 +0200
Message-ID: <e901ee2b-5948-4f79-8442-fd6321e25568@foss.st.com>
Date: Wed, 13 May 2026 08:44:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32: add U-Boot specific dtsi for
 stm32mp157f-dk2
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20260512071157.564081-1-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260512071157.564081-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019E:EE_|PA2PR10MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7286c5-5c06-48bf-90f0-08deb0bb2693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: fGxGp9RmnLug8e+2atWjHHiRqYHCAMoJx0Qw3BfwDATuqto3YPsrgZ0C4hYfEXg4YNu03ugnGbWH0OdcbrFgyPiNCz5d9RWbyKz70Bx+E3rMCUf2sszfruX9qKiQ+nUPZdjnqK/0f478RBA1+fu4ThheKCAR8Q6Vd5wscRIC5APRR5Otnl+U9J2tvLgP+r7BtulKsV9o0h6HAt9zi/+201SEmCXSU3hZjQD+lA5Jt5QnF80reGsPMF5Cv4qp/ok2litUWQdB9LDITW4C67OKW4fBT1mpJSfTj1eE+7b13yqpHvklLgooe5pzu9eX7jMceSw/cD74JCEYK3G1oECeRGmk0IDIoxUfcvVHN4X+a6lzfvS9IECOF3vzTIl4mVdnya2nKE/iZ+R2Kmg+AsU9FjzZ1Zk3P8OwjB+jcCUOusZVveUYjzOIOspxFD5k4WKkx1KPhBJSncUYBibLBF7GeqS98JnAgCYHE6bTdeBEXkDc5bOTwa7GlsUgDDfA6P0iuTu/MR9wFGBhd54sF9Zn9lzW04lxm5crI3KxDd8okzg7rj2wAHqpxPR2hzbPTufchu8YeFMfQdUt6/65nrKIGLlcCDeJfoGAweYZPkA8yUGl1I24zSPOSRduFCvdXusEnQjR+1UtCBlCOwdFV1TsJApf1s3UHpuoqtuLEP9wUAk7fpQvuMGMHV/klJM29gMJw7Lcgo129Fg41UNmGZhzfM6Y9SK/GmMU5IrMmjHNBPs=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lEVfOLEVoxlbXsv3z+C+cs3bb30ygG6zo/+70yhb8x3Tzwy98TQp2Q91WRJRHwLWJEwWl0m1dgAwWGBexxrYNhlfNvxteakx4NaM2p+aj2Obg3rmhHQVJIHUzxGS0e2SCATK+kI9Tr12JfWHZYbiiQaQWQ+beMot5H2aiAlE7XwGJQWQoyDyqhehxTyvgxH2vu286Hh7E1CCSRP7nGJNibttGlCss0+8/HyVSO0xBIohcPcntYrZlTBn4rfPdS5AtbmO9W23RYB8M8RtGOufxBFOgaYYxR7vKz/EtNob6tMwcE9Pki8IIom2rCpnR8T49Pn4OgxXIpTnX8XEPiGXw0Xzg7AqavdQknz/Ji3YitjCOjN/JyFL7rEGbIz6tfeevOcJtnRQXF2gQpqwQbKq7aQXybJpKtHPraEuaGwLAhEse4GwgA3wgY9ONgc9tS15
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 06:44:58.4959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7286c5-5c06-48bf-90f0-08deb0bb2693
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8909
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



On 5/12/26 09:11, Dario Binacchi wrote:
> The STM32MP157F-DK2 board is a direct derivative of the STM32MP157C-DK2.
> As explained by ST [1], the "STM32MP157F-DK2 is assembled with latest
> STM32MP15 RevZ cut which is the only one available for new product now.
> The major differences in this 'F' variant SoC are the increased max
> frequency of the Cortex-A7 cores and the correction of some HW bugs
> (Device Rev.Z, see errata ES0438)".
> 
> Introducing arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi by including
> stm32mp157c-dk2-u-boot.dtsi allows inheriting U-Boot specific properties
> (e.g., bootph, fwumdata), avoiding code duplication and ensuring
> feature parity.
> 
> [1] https://community.st.com/t5/stm32-mpus-products-and-hardware/i-m-wondering-what-s-the-difference-point-between-stm32mp157c/td-p/213460
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
>  arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>  create mode 100644 arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi b/arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi
> new file mode 100644
> index 000000000000..456ba70ba9ca
> --- /dev/null
> +++ b/arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
> + */
> +
> +#include "stm32mp157c-dk2-u-boot.dtsi"


Hi Dario

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

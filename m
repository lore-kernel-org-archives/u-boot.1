Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21F7CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 09:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8F3984837;
	Mon,  1 Jun 2026 11:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="HCUMLmHy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AFA38484C; Mon,  1 Jun 2026 11:10:01 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49DEF846A3
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 11:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBKxbvKWb8LDYIL9hBonNe+RuLlsz2lyl5+pFThmffW6iIjPe2QGEbFAA+nJBxZTl5sjkzOTjsHG//L5LjKsVQpwQ9aXeycLINQ88WxT+P66Mn9ke0ulNkdoj+djQtXqNNAPlBcNVoK91uJ5AvECRYs7HqBhQc8w9/ZN63ujxtix6PGzNc5Wr2myuUZOmnsFawdfwaZzNOrbos+myvwOZKGgM3YdSEzcOE8pXneeaoUE/0OrW8zGTVAiBtYWF8m9DyOlY1mNPxVHt5YNzZyYsDS3gKK34vaMGKWrG6qx3LS/oR/laMawOecJ2UTUXVUw/kJJeKDYUwZLw+GtniVTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsAXktftZE+BxZHbaUkk9VEBHsuNIRwz62OGtC9qysA=;
 b=sfj8UH19IaNFwefyLTyIxeDU2t8xaYEhwAmTTvRKS+RhSLWrihN8VOOBbE97GzxpMY+FHhciNPw/l4mPkSNFkgPDDKD1DZ7GUhIB5E4Mj124uoJNkydFikAVLoTHtOtitu4EfdgqwptEpyOlXvojT0UfM/djrjYjUzoc/EcT9652NL5v67rJpqGRqsVit6SCbAum19PlxS5rfJSk+XthCL7C5DSzRDRIyuU9PPc0V12AXtuurQwvO+bymkJk4j7Sd77OBAt9qVM6eWvCyCeRo0c5oGDpnJIS3Iul3OyrKbmCCJezM3h03zpfLaz71Q1WZCzQ0hBnAII3wE+59Xsksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=amarulasolutions.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsAXktftZE+BxZHbaUkk9VEBHsuNIRwz62OGtC9qysA=;
 b=HCUMLmHy3jDru3qPMEyRNryPfG2tn4UZLl4wLnSKR3JFv1dU0IjzKc9RCtTJuOJLXQj4D2EknepKSUYrMtzi0+RzArk/T++1Tl8agwc4J9f7fb2Il8sS3uDfVaOK7CZ7i7AgwHTfnhCw0eAxFFxeVoyeQl/Z6h4TsUIUZ3dq+LceJ/DKFYP/5YdjPWJOcOs7/nkvv/XNPLu20QBVnpnvzCXtFzuwS/hcyRi8BiKLJv0u3+ggEQBc/ZjKJYlJc7zavEJGTk+zyZOJIHZAgRZMfV7Lf0+lSvEJnk/35Fvy12vn4N1FwMKprLMAhaWHsWzel17dGm9UC0xzPRgkcPuwsQ==
Received: from AS9P250CA0014.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:532::15)
 by VE1PR10MB3950.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:162::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 09:09:55 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:20b:532:cafe::15) by AS9P250CA0014.outlook.office365.com
 (2603:10a6:20b:532::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 09:09:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 09:09:52 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 1 Jun
 2026 11:14:00 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 1 Jun
 2026 11:09:51 +0200
Message-ID: <95b40948-c864-49d8-b861-f405d1e95dd2@foss.st.com>
Date: Mon, 1 Jun 2026 11:09:52 +0200
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
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6A:EE_|VE1PR10MB3950:EE_
X-MS-Office365-Filtering-Correlation-Id: 84729f48-f00e-409a-abe3-08debfbd8a93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0lvBRPNP3R9M7dqPuL4M0XS0HDaS+0GSiJJUgMMQMcvq38EFSRqfaRvuUNKWUC+XhW5Fez5OpyMEBe0H1Z/rZm58O9r54ZKO3DZDHz8mICw6Wz5hWa0ZwcBhA0ui+we1MfJWZgAKHFB7Eqi88lb1UkZjke9FC6atosadEAG9mXTJmaXsYV9a5MuMEf0bfcbOMzkoLqsUGU6gRMTY7VTQLQ7LTMUMHbLm+Z9S+tJS5UQyuoWBfrQ+K/CM6UhsX1guxPJCXWHP++RhpwqWzttllxibGp+vhLBGyyayep2bCv45QadJmcKN35VVEkN5vlRV6beKTlNZrdgao0Ufcz4vzbDMuIuZCWlyQGFtI9u5vnwx8m5iaJbYjrRyljm1i7o7ID8OFeaWcXbzhul3XDe8wkMJITB+sTYTrof5wOhjFdHz5H9vFibzPFgwVENoFtaY5xb1AdAIcs/kT/45a/OODM9fewlZjDrk6pW238mPQuFAZtj00VTkiE61qzfow4Elr8i6mXA63/YNCZFkEZCC5+vSLuMfBPFJohfUnlAmlKF9xgEihnXTsTV+jagcYqdsBasXaMGR37HxMfJ44YKQxBgEx44faCeeQG2MyiPE1J9YLt+Hz+d8Y3IbutNJh+JOG9/qR4ANtJg6pJXIKIFz2pjStU+FchykuJ6aXt4vifBFosQRiWeKhUZY6hP66yYEBpo+F0UfCYa2fPGAq+KgRG6ODBLoWw1Se8ewVms6gCU=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7MyE+MY9bLpXyBnwe1E06szNT6+hxlS2oxXcO12GvtPnMKzV/KEHdR5kyRWmCtFdeY4e6QVKwcqrmARND38aLnsS633jYzAmc9a0e2RoGSUjo4a5PBTwqXgNwWAeCe2bZpDgdNibkuos/ZJOi0bXJYVSmZpKuzbqf00VGjSJqLRenQj8k7zWtHz6eY9Vv0qfJs1BmaAzVLdrUf/0m0q1F1Gm4cCJ7r5LwCXqi9MyKwSx/tC5OuS+b92bf9fZa+XZKz5l76Uj5XFw/6NliDvkL93FtvB3+oGimlyrgT9gtLJCdl4CUPwizhMWSDvKYnX8OT294+fougVLpHpYjycAuYExl8vVKKlxZGUfQ1dqDMBExAA6V8m28HNAx6L+Iff6Snbe7HbMCkxLxDz4leqaMWRFMaoZMj0yvMMgY8Hawz0Krj39htF27fLM/eQmL5EJ
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 09:09:52.7031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84729f48-f00e-409a-abe3-08debfbd8a93
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3950
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

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

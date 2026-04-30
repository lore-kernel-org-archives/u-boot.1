Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93492CD13DE
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 17:30:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02145803C6;
	Thu, 30 Apr 2026 19:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Plx1rVQw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 502D383FB5; Thu, 30 Apr 2026 19:30:54 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F4D980086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 19:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEqrxEwpfMHGSDLJW3PURHJup2cau49CZUzm+nnXf55D6ByUAz/mB1h0R6XrxEU4HkHFn3X0uDj0ZfJT7xy5GnoZwQunp5dTfJu0OzJddJt0Q3Omf5CYLBY+0ycUkABZKsvQhHThAKeW5x/FEYR2tt8A74OPnxqRAr+ZP0VYLonS5rsqUXhYmZg0PT8Ph4gmxHKHFsK2k1BRzi+vGk0o/WBcT9nAX0n8ikPP+jh2Rdese4TRcr+0Xv3Tmz+uvrgO4zjx50VzfhSFKnP0X0/HTjQZrVPUbdrAXFVZDe5lGeOfFy4oGxRuxUWCFhL1nKYt8Sh5ofCTbDMypizeXBPjxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNpie8JTWy+kyB5ZUKKmY6idWFbi1lz9IsNyUR3Ic5U=;
 b=MBKOfA2Ov+Nd2O7n///X+ceTVvZXrS15y5aCe3X9tUWoMmrpFeInstFXkjDrXJzjs4OG3C6w+rgxYfd2jyCoy8dUJxfwXxog+yMw+079QAC6Kw6dfUYdTAYvkMtuac748QeOJpJQ/fKel4VhQhxEwTw1e7n4YpdgU4OIY80Dy3FuWnUJ6Gt3Q8zdPC922rPEpCXNLVXBaPjABmDNvrvTdkmJ0B+3JEc4zXvdMhr9zDQVRpT5PbnvnvfkObcRyS5FftK4QrmXQEM9xPoNDoF8/Iwo4uDGU1N2ShoRJVvZlhomHa6NzGb3Ybrb4o2Cs9Vcwvza3cnwfLJg6gHgduxsWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNpie8JTWy+kyB5ZUKKmY6idWFbi1lz9IsNyUR3Ic5U=;
 b=Plx1rVQwHpisoXG1NTVj+KpJcA+LknOjz386RoyOtZXJv8wohOgL/5ip4XZNX1ZpKSNsml7E0XMyEpEo1GKtRjuGOeKPaoJ5UXwdmcwwHZbOZEtV7DWYeBs4w2ELlQIilTil2fNs850fNInlPYoppHjdnSf5iiC2O1jV448+PYQ=
Received: from SJ0PR05CA0134.namprd05.prod.outlook.com (2603:10b6:a03:33d::19)
 by SJ5PPF912A858AF.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7b9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 17:30:49 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::2a) by SJ0PR05CA0134.outlook.office365.com
 (2603:10b6:a03:33d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.5 via Frontend Transport; Thu,
 30 Apr 2026 17:30:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 30 Apr 2026 17:30:48 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 12:30:48 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 12:30:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Apr 2026 12:30:40 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63UHUdI11600436;
 Thu, 30 Apr 2026 12:30:39 -0500
Message-ID: <f5e29a2c-70ec-4569-8204-333a0efb5eec@ti.com>
Date: Thu, 30 Apr 2026 12:30:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/20] arm: dts: k3-j7200: Remove background firewall on
 DDR
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof
 <bb@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary
 <j-choudhary@ti.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Udit Kumar
 <u-kumar1@ti.com>, Abhash Kumar <a-kumar2@ti.com>, Thomas Richard
 <thomas.richard@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, <u-boot@lists.denx.de>
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
 <20260430084414.1354490-20-richard.genoud@bootlin.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260430084414.1354490-20-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|SJ5PPF912A858AF:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ccdacb-5f73-4b61-0a61-08dea6de384e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: a2ZRMKtLH0Z0XILm1TlLNQ3NY7Apv6tGiyWj7J0+HXF2edMaJgzvofTQ9KNLWut4xwdQA6O0/Cz+toSWu2yOpvIx9WlPALjSXnJtprvrtGFIRppAFJgUyBiMi1M6CzksBsVKcIfUjkGqUiZI/DwXPznPeCUD7fJQYbSWKtJgwy0BNBcaFtp9UMuvy1JPROuOQfl7z48nLkyKe0KFgd16a4uYxlHGNbVQBjulwv41R6vwNoa6jnBlDCp1YXvhcJTN5MR5yipIH2MolLr3ED6d8Y9zvsL56W/3KtH/A6itb+qnYzS0b5HPk1N34daQBLQLlDyI1pXUAZzsVghuIA9on/Tv2cOFRVpT4ikNGwY8BXjmNezmIHZ8jg/8oznehZxulBrCzdgGp8HZpQJQScnpDH+KLSCtWhsz43NU5j8fXktMQUnFk/uDPb8MNkfSw3Lrgu83adyjiwI2o3aa1ZkkvCzpFp7n5+Pl5Iv4Quf/cOVDFOm/00J/eUHdAbCN1xLgVv9CpGaiuTfDg66NvjE/3B3zlOXXmFDgC2btF+qBdf/eUD7XgnLmxJJ1RaFF3/C+KD1XFR9yVr2mX4XevVFqV7ZDa8jwEBqfMawxFfahj43IoH86+m6POp3rSBhoSvEjH35rKU2soIXcw8h4i4aJ9/auXsk53Dv/2BhS5NuVOZTy5v6eshuVSEf6ZmFourIGEnNbAsRhAXo+lN6enHeu1AKjTQrc8P4OlIcrA5ei7DEtXMyjxPg81khX+CM2lPJcQmBk1cRPac78uwctpXN/wA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wx8wrpNrGAiX41oOMzmt9ZNZ2O+PxBT7BRieUByF0h8m8xSMP56ygF7NlByX/XJGsE5pfqJieb2YU1WqBu9k2KqdSG31napYqH8FG4/JC/g1TZYuhuB4CTBsM5y+kljohjwMjqXP+wGkE6ee6NioHIQxa2xS7t/rEsGpdJBuPe+6rWYVGVyrXUjKui5cZ8LdEqfBu4JpZZSs99ftG91frAQK+eJcCjWbehkfWpd+KUI3gfbFcy4y+vz5wRAUtO7wKFlo2UQp6cwMtPmr0pBFO/j6xep7aYiH/EGAE2Bzj0z2vDgyYhm8jG9s29nDeE/VqQiYuNfb9ab3pBiS2lKlt8xBsOXCLXeU/4OcrJsHDZOp8xAR014WmRPx3WgoW4wtOeOFGgCzTTouo9MNj7stuTPIm/Xd9SMuyKdWq+LSpi8z0v+GPzP6WRCxbJkegzew
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 17:30:48.9413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ccdacb-5f73-4b61-0a61-08dea6de384e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF912A858AF
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

On 4/30/26 3:44 AM, Richard Genoud (TI) wrote:
> From: Prasanth Babu Mantena <p-mantena@ti.com>
> 
> With updated TIFS version tag v11.02.06, the background firewall
> for DDR firewalls are applied by the TIFS. This removes the
> dependency of applying firewalls through binman.
> 

Does this then create a dependency on using a TIFS firmware
equal or newer than v11.02.06 when using a new U-Boot?

Andrew

> Remove background firewall on the whole DDR, as this
> background firewall is applied by the TIFS init for j7200
> and j784s4. Modify for j7200 only, as there are no firewalls applied
> for j784s4 from SPL.
> 
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> ---
>   arch/arm/dts/k3-j7200-binman.dtsi | 14 --------------
>   1 file changed, 14 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
> index b4e0ce8bfcf2..c2b86339d593 100644
> --- a/arch/arm/dts/k3-j7200-binman.dtsi
> +++ b/arch/arm/dts/k3-j7200-binman.dtsi
> @@ -294,13 +294,6 @@
>   							region = <2>;
>   						};
>   
> -						firewall-4762-0 {
> -							/* nb_slv2__mem0 Background Firewall - 0 */
> -							insert-template = <&firewall_bg_3>;
> -							id = <4762>;
> -							region = <0>;
> -						};
> -
>   						firewall-4762-1 {
>   							/* nb_slv2__mem0 Foreground Firewall */
>   							insert-template = <&firewall_armv8_optee_fg>;
> @@ -308,13 +301,6 @@
>   							region = <1>;
>   						};
>   
> -						firewall-4763-0 {
> -							/* nb_slv3__mem0 Background Firewall - 0 */
> -							insert-template = <&firewall_bg_3>;
> -							id = <4763>;
> -							region = <0>;
> -						};
> -
>   						firewall-4763-1 {
>   							/* nb_slv3__mem0 Foreground Firewall */
>   							insert-template = <&firewall_armv8_optee_fg>;


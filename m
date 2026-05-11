Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6581DCD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 09:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D67F8846BE;
	Mon, 11 May 2026 11:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="e2t8f3ow";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB8FA846CA; Mon, 11 May 2026 11:50:08 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D56B8341A
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDQg8Wl73fbSJKBbKnEZkNjA2C1r+1rNG51Nbiz2JIcjlhG+hPoAxlhm38YsoPkJZyjhMPBuYXng35OmzaN+5DkKptzVmhxkTnscFcp/YtBRVzM7gNH6JwWUm64RCC3eIpDRI6+rU9IaxrEtWLJxH7xR+PG+2sfVwjWeU0gWBwaO5wymOoVyW+PJQ9NVdZ4OJjpBK3vR9TrCRELQeyz+oUbmPi0bZNqgloxHphUqeGrsvvxADq6edZOzy1FXL0KOPdc/G9eZjkNXFjLAjWzCn+M5nbCuuKPrzjMxePXOKUe8vU03zVMYSq9g6h5gLtFqjgnTw4NHbCFZ6IM5wHonCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POCagjBc1dhED4uKSdo8onUDhBreOP2T53sr403l7E8=;
 b=CeLd/e2eZ2+mQ7QIjJVfZ1FLvZ1GTKGq6Nfri4xVxWTFzPz0G+xtxwrgvwZdm49DqhmqH219YkKXaJKXDew5deOHWaC3+ztet6gpzvvsJBmm1xRuUH9u2Qpovv3v6sh5mnyoTtnFEkUFe3WW477aGJ1IUL9SCEID0pvwLNVg2LPRYBqkEU9oyVTB07ZwSiKS9cMI17SiOOCzC1izDkzLxRTCfKiOiSiBe1FrBHW5kYn97NoH1stiDuPsI8ir5sEpS6dWex1SlRwJx8sKlayculNzRLYFPU9YYm5K87hHia75EAwGCqL2s648Lvc5vukcyC8ZHgq9ep1ImSLgaMddiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POCagjBc1dhED4uKSdo8onUDhBreOP2T53sr403l7E8=;
 b=e2t8f3ow+cqvLEtNKR2Q5zJFprn10geUR0bv26bkcs9ag3CmGKP/dY8O9RabioV8Gd7gn41Ji0kIVi6d6/y2NSVF0g+raLc6bpRjo8oHjZcm5JOjJloxwYCA5xv4BpcFKjQa3c4yG1ktw34PVWBnR7nIMos3soldNBwqAXSHw/I=
Received: from MN2PR15CA0009.namprd15.prod.outlook.com (2603:10b6:208:1b4::22)
 by BY5PR10MB4180.namprd10.prod.outlook.com (2603:10b6:a03:211::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 09:50:03 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::c5) by MN2PR15CA0009.outlook.office365.com
 (2603:10b6:208:1b4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 09:50:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 09:50:02 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 04:49:55 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 04:49:52 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 11 May 2026 04:49:52 -0500
Received: from [172.24.26.211] (lt5cg60819vj.dhcp.ti.com [172.24.26.211])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64B9nmlM3107993;
 Mon, 11 May 2026 04:49:49 -0500
Message-ID: <67f8cce0-a13f-475a-917d-82be137c8053@ti.com>
Date: Mon, 11 May 2026 15:19:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] configs: j784s4_evm_r5: enable TI_SCI_POWER_DOMAIN
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F .
 Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof
 <bb@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Abhash Kumar
 <a-kumar2@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, "Gregory
 CLEMENT" <gregory.clement@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, <u-boot@lists.denx.de>
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
 <20260430084414.1354490-2-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260430084414.1354490-2-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|BY5PR10MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc2cff3-c46a-4a3a-67a4-08deaf42ac44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KtpBvJEmyg4e7LS4t/ursi2RfRUQFuGhiUWZmI4gJ44vdO7TBfout9J/NIARwSV+Yt/ZjYaBEjdpStFYTBaHDSh42Q/2u75p/k8JdPtRtobIOTH30ZJ0uOYnwSdRWYeAa+zS9OoKOeQ4wyQo+Mi1dPWaCBmhYpncV9rUqMgASKJuKqxWfW33VQwjzG/fZaVBjD+NQjOuSzqOCP3Go30Ki7S4/a2mlKfmwzD96G8VQKLYqOXxD4QUNvZjBxZxDEf73UDGtche08PxRcEm6TPYnaAOpnGG2XsHJE1l3S2LzpH+uzM1fgHqIoiOlnIaiaSByGYBDaDyqSvZZ8+LZ3N8VOxlKHGyQFpaS6jfZrr+wrQrRFgjBZvYHwfGIpZ9Q0h+OK2Gn4PDTQuYKyokpApRsRkvFE/Y+DaychqoE5DqqlnwbpvD0OvtL04PHHsvV8QHjTSzlGwg790wEgyiMfLlspubQyyPVyQJyXXkfmwc51ln6UZDAJTi+xI4vXNCWcTB2A5XP/P4kPvaM8y8HXXKIDAYFaHoiRkuGRaFQsC7RVDuC2uzMjl7PexehvbfivTxNAeNi8yz30cveRiqYyNuPCXMZepEioq0Vrr4I2Eqk9ZKDA+iFPwIN8DvZaoCc197j/svj3B/pJvxkDNCzM9r/FfA/JpRDudvPB8+BpiGZ6SlebTtDFki3NZkPUJbboV7pIeSvuEovrU1b05xO9UQSmBbFZYtBmPdGQdk/R1zqkE=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0YnHyHJQPGzNToDKcaIyepd6cFj5vRVzUvjZHjPMxM2gRG09YqCkdZ4Jw28HimM/bc6ZKt77JpI9EnaHnB5frarN8NWHTHRvPbgQShi0nGunknRBY1+oCBkYDrBcJCYMTap7HUtWgRjKOYzEPWRi54aIq+olLQkItBDKkCrcfapwm8thMkrMtigI0W71MBIvxt+OB3w3lvXNYSGamdCPPnXQcl7rSENaDBsZ9A6ZfRR3MfbYrKcfsUdM0eQZhWHNxR6wtT9rK8dYUEtKCtRldPjZ1aNRCOWf+rRi4bCC22DaSDKQoRK3psG63upaRrQvNEyym0S1EHHEFPMNmE7pbOPMIjUfbbnji1CbXS2TstJl9kT25H3Tg/Cz8C6BgjvGDNGiSW2H4c35MyQyhIyh58YVuMvzHMWnR/dM73twQFRq3Xvx4io12aY1gnMnXecU
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 09:50:02.4934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc2cff3-c46a-4a3a-67a4-08deaf42ac44
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4180
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



On 4/30/2026 2:13 PM, Richard Genoud (TI) wrote:
> When resuming, we need the power domain driver to enable R5 cores.
> So, enable TI_SCI_POWER_DOMAIN driver in R5 configuration.
> 
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> ---
>  configs/j784s4_evm_r5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
> index 25ab6f17d175..35ac2287bcc7 100644
> --- a/configs/j784s4_evm_r5_defconfig
> +++ b/configs/j784s4_evm_r5_defconfig
> @@ -124,6 +124,7 @@ CONFIG_PINCTRL=y
>  CONFIG_SPL_PINCTRL=y
>  CONFIG_PINCTRL_SINGLE=y
>  CONFIG_POWER_DOMAIN=y
> +CONFIG_TI_SCI_POWER_DOMAIN=y
>  CONFIG_TI_POWER_DOMAIN=y

Wondering how this is helping, to deal with any power you have
CONFIG_TI_POWER_DOMAIN

>  CONFIG_DM_PMIC=y
>  CONFIG_PMIC_TPS65941=y


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAA8D3C925
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 15:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09AC383C08;
	Wed, 10 Dec 2025 16:48:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dc/Kcp0z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C476C83655; Wed, 10 Dec 2025 16:48:55 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA615836C8
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 16:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2xAShAYFbzFyqDnXi+e4hMGBRzRdjCx1kjXpNQwfWYBZD6R47xLA4gUvGbkwDb9FagSgFIy2HofHNc/N+MFCi6A47+HDQ4zBqCZvxQfnXeol7XvmzhOpp+W6iR//YvY4LLKZGDeWiRPaPA1Y8yuFKQhdWxPBwNgRUm9SlvwibCmX3ge6ioltFMjg99dNnDAO3gh6FFb2TDBsLVWk2oMHvXa/+rbS4j9UtI9JGwLdTdL/nqlxF4AADGLu4VSKfEn4GcdNI64jnk4+xAQ+wN6yG/BM5hOnBmHRm+GizVZjj8bXy2AM6gzeh3LhHpWLJtXXaAWRUYDX6wYfzhyW9JkBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKXXxGHsuu+H/0hsvj0ioTtjiEFTLNaEZDZFTvnTqdQ=;
 b=KLtxEVlL6h2As7F36/B64bf/J/arI4rITSk0JbZ7YH6627ePO5gpol6/x/hbsGiz6EYabkq3NQPAox4nQ8Jmk6nbtCZqMlaiSwL98gtIv0E72dz/XvdzQLNPMpsBYcAEuuWDNBJg3B8y02JDcrYq6nyocrq01Bvwwc44RjcAfeIVT/60geenyJBeaWrDzTj2AJ5uLeThQxbbesYvshSg1xEEDyLjKL1arDKFWS/YdSPY8V7E3FUYrgVU8tkL31QhdwCMUtMXGWNChT+t0Hcs+YUBIj8QnWbap5Sgg+4ui1a9Cjtg+pv9h3icBOOcGXZqvg40ULYzDgFqGRPsvDkCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKXXxGHsuu+H/0hsvj0ioTtjiEFTLNaEZDZFTvnTqdQ=;
 b=dc/Kcp0z9XAdFb+5+DSMPt8IGZx4ocFRbEZVnfk1oRvsfPESMwADERDR6xpUX63AHcJjbUoUhzWthF60ezjETbBFVlhDXErjrku2cf2jTrBzFz6K3wuFUtJ6baAVJNH8z5kpN9Qky0dFm0SKWTA3jHz3OD0h9YC4o54pItSxgeY=
Received: from MW4PR03CA0160.namprd03.prod.outlook.com (2603:10b6:303:8d::15)
 by PH0PR10MB5561.namprd10.prod.outlook.com (2603:10b6:510:f0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 15:48:49 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:8d:cafe::2c) by MW4PR03CA0160.outlook.office365.com
 (2603:10b6:303:8d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Wed,
 10 Dec 2025 15:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Wed, 10 Dec 2025 15:48:49 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 09:48:45 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 09:48:45 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Dec 2025 09:48:45 -0600
Received: from uda0271468c.dhcp.ti.com (uda0271468c.dhcp.ti.com
 [128.247.75.68])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BAFmjrs3199756;
 Wed, 10 Dec 2025 09:48:45 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 0/6] board: ti: Add 32k crystal initialization
Date: Wed, 10 Dec 2025 09:48:38 -0600
Message-ID: <20251210154845.3852231-1-vishalm@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|PH0PR10MB5561:EE_
X-MS-Office365-Filtering-Correlation-Id: b034a1e3-6731-4909-5f30-08de38039c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SXLfnZjsA7pfyuhAcxQiBAIaOshXmzjzESa+VNY1KdOZGlW3ZRHhN08mYiZ9?=
 =?us-ascii?Q?QidNC5kdjPU+Mnbt4e+bRpRLe2RmHMUpfD9AyJFifvzPRcEjKYsXhEpbxszQ?=
 =?us-ascii?Q?09hVPmLDWAMymA0gXva3NaUEK7q7o7n5Tt4sz00eKcLFyCq4x3//6TZXXX3r?=
 =?us-ascii?Q?cO4/vk2CMQAwHo73aNjMhJkBZaWehKPBsZ1dPYmr0EcN+YsAyoF1uCzREZa5?=
 =?us-ascii?Q?l/eHqbKtv3Vc5of1AZCpQexXmSrRT7TVRMAQwDdKvqecYWvuajbV8JANHKXP?=
 =?us-ascii?Q?ZGHjwxAxxcLtpkkz0LezavGMC03SFjCZj23TFBwt0hwhyZSpi6X6uyTy40OV?=
 =?us-ascii?Q?hbHXzP1FPipLkkfJpXCo5URVP/x6lK+oxCvfvNBrXzbwFcvkrQ4sJ2eRz8E6?=
 =?us-ascii?Q?U3kmqalHk5FmcDPMaRo29WarvFEz+zh3dyiXKsGcJ9uLyMDRH1l+MMWS5AiK?=
 =?us-ascii?Q?7WArOONt19BaSy9ceXZXbJ11qUXQTImwDH7ml2FgtZUqYpC/IYsnALqerPeU?=
 =?us-ascii?Q?ueMSxHKWjYtgjamZ/5ndRqOL9Q2Dez5wwTPl5cGdErqqZwxEFAT9EXMlh21m?=
 =?us-ascii?Q?Vlj5simXB2IqEnnW3qQ5KsAEwfl72wtdv15pLs894wacTb/LZ0EbugA31kNF?=
 =?us-ascii?Q?m4wWOXLcnanImDmFzAgO5uAwcwKd5LHbZKojDs/7YQUWYeeppPXQZJBjDMio?=
 =?us-ascii?Q?bs6FdFwOpP2JHq5qDjcQXclmrbOfTMqFONpInJIcuW8PtV00aZR9WKxD967b?=
 =?us-ascii?Q?tUu2m5JG1ofsy7kq2XkVPf3O72CBHz2PKUxIZuORnCud9n+H1nMyPrTMlOL9?=
 =?us-ascii?Q?vYsTokhCdzwuc1bqYbMvu/FiT6GuTtxIgIq7J7SL38JeTajf8mXlq8yv6piR?=
 =?us-ascii?Q?bqm6Lj197sNFEJODDkFaD2w2WFmn/7D0acqfEMpAgrk+lUsOTxCNHU6rCzbu?=
 =?us-ascii?Q?f3ayT1RfElX9/wDdcuIgMRRKqUe3qmOAgi8JdZ980UGmPv6y/L403r3vZv26?=
 =?us-ascii?Q?Gq96myMVwpXvFY2hTS6OhU22YQ8eSIGAAy9gA7RzCzMt3Rb3jO8XTVuKLuVL?=
 =?us-ascii?Q?RM1XBt/rPc2LOVzZsZn7JmNj/P15LkPLlQgCgyRCCiIBLfIoLV642EYpDNop?=
 =?us-ascii?Q?5oE4G80pahAZyJKnwdy++1S1r3FsZMX2gk1+T0DaloI5uYoWNwji+p+Vd0Ru?=
 =?us-ascii?Q?08CALsqg5TmKSPJeKTuxvhxgQPYkmtRv3NjbG++GPBqvftlfTG89/mLqkNLa?=
 =?us-ascii?Q?oLJ5XbXcX3r7ikpr/Az3OxEfHJEMmTKk/nvsirmA88Ch5kJmDl0c0GQqFRKI?=
 =?us-ascii?Q?And1tyse2zMV18nuWOxrLoAombu83I2jqDgdDsXHNWabcYDm2+jyw2c1lDpp?=
 =?us-ascii?Q?Z4FwhGFBIUocRVZ6jhUQ2RS5b9kvJL39Ln52vsY2TIOClNtId8FmNJQFzcBG?=
 =?us-ascii?Q?HzRhfx0KRG94fqLFikH7hOKca4zVrbGVA22pa1zpleof8mtUdzxACfo3PR+P?=
 =?us-ascii?Q?KtGA+eugnE0Q01nUdx7ijuSdRkh1PTHlhqU1m4MSQQ1zdvT0nKUoHFdsr3f1?=
 =?us-ascii?Q?fa7AbOPFeGcVuS/1DnM=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 15:48:49.0036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b034a1e3-6731-4909-5f30-08de38039c46
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5561
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

Add 32k crystal initialization support for am62x, am62ax and
am62px TI boards.

Vishal Mahaveer (6):
  board: ti: am62x: Add basic initialization for 32k crystal
  board: ti: am62ax: Add basic initialization for 32k crystal
  board: ti: am62px: Add basic initialization for 32k crystal
  configs: am62x_evm_a53_defconfig: Enable SPL_BOARD_INIT
  configs: am62ax_evm_a53_defconfig: Enable SPL_BOARD_INIT
  configs: am62px_evm_a53_defconfig: Enable SPL_BOARD_INIT

 board/ti/am62ax/evm.c            | 16 ++++++++++++++++
 board/ti/am62px/evm.c            | 13 +++++++++++++
 board/ti/am62x/evm.c             | 13 +++++++++++++
 configs/am62ax_evm_a53_defconfig |  1 +
 configs/am62px_evm_a53_defconfig |  1 +
 configs/am62x_evm_a53_defconfig  |  1 +
 6 files changed, 45 insertions(+)

-- 
2.34.1


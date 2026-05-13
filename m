Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE705CD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 04:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C262838BB;
	Wed, 13 May 2026 06:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fX2vG5sb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 868B3838BB; Wed, 13 May 2026 06:51:48 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8769280F0E
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 06:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5hXqJo8nnogejWa4jb/MEgtb+bWD+QPjzra+TAD4rvdYPKxVL4eO1v8U5tPdhqVw8Ay0gy6ytfYZJ1B+xxoKaw1hdRVoRO47hv78YkUeXvmOOo6slJFIzw569rXiqAxNodKJTX88OkYLkyCSvMe1AXrUYrwVcNoBspsoClixr2JDyZgEEAVhSwpXuROqeiDVT4I5X1zrxGTYKm1zR1+oKq1QL1DsvLrC5nAjd7KDRkL9hw2ERVvV2ybS8q/AezO0T/ilcIpxTfyVepPoKKaB7k6pAh+wOo17QWIU9R6lEYhGoPUzShUj2fUuPQ/T3CiVBy2nlYle6sEKj1jC+P+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GGuwzdVR8niArHyGXIBFIZuvJ6EBqXiyQuPUvL86rk=;
 b=mL/CQtWE1qnBm11G46QLZhvh2XMPDDlyLRB3/XYGg+HzmW7TVmhHqq9G8iNJj7P4gRxiXEIMAG6XtQllYiZ7cSf30s29D+VFoN+yo1VAUNvBYQcORNu49mN/n6Ke99xAb9II23QoUYqpV4Y1NwpqlkR3+80DHV6Uz0lANDUNFlFuGmxPxHcsT1hEo3ojIzUurRmgClPVhhFfeFIT2X985MpB90ddjyPhX77BArS2J+iYP3pgeJyPuP7bnmIo2t6byQsmdyvtqtK8lvsh2aZRCZ2WUwU0/0labY+jAzMwWSRbCvQCruyl6pl3E8HV463orKhkJq+nQ/ZE+GFo9ROnXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=phytec.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GGuwzdVR8niArHyGXIBFIZuvJ6EBqXiyQuPUvL86rk=;
 b=fX2vG5sbwJSpcbHtDbawQzS4RQoOlzyIZSvjA8Vd1wPrPlfZIN943Hjoj/LZ2s5nERemmngxASERGfNoPHJEzSCAkCsEaAws+DjENxSKQ+30n70bkLr0mIKX3ZR0pgvE4CZ2cxzHen2yRG90WdtzbmlK3+xoBQDEWMWbHXCmqkk=
Received: from CH5PR02CA0017.namprd02.prod.outlook.com (2603:10b6:610:1ed::19)
 by BN0PR10MB5048.namprd10.prod.outlook.com (2603:10b6:408:117::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 04:51:42 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::98) by CH5PR02CA0017.outlook.office365.com
 (2603:10b6:610:1ed::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Wed, 13
 May 2026 04:51:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 04:51:41 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 23:51:41 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 23:51:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 12 May 2026 23:51:41 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64D4peSF2970959;
 Tue, 12 May 2026 23:51:40 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 May 2026 10:21:39 +0530
Message-ID: <DIHA24WPD5RR.375NLCSWPLE4E@ti.com>
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Dhruva Gole <d-gole@ti.com>, Mark Kettenis
 <kettenis@openbsd.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 "Moteen Shah" <m-shah@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Chintan Vankar <c-vankar@ti.com>, Suhaas Joshi
 <s-joshi@ti.com>
Subject: Re: [PATCH master] mach-k3: enable mmu after reserved memory is
 unmapped
From: Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260512-am62_firewall_exception_fix-v1-1-4b274718bdac@ti.com>
In-Reply-To: <20260512-am62_firewall_exception_fix-v1-1-4b274718bdac@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|BN0PR10MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e262b40-da59-41ef-f932-08deb0ab5380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 46p24ZN0OEfeLZewHZnGZZ//Xh6lkrp4i+a2Bir4zN1ioxsctrqSvdygkmUyT7sekgoD+3rE3NHNFzl5wxBRpfuHjBXh22HlGxHyJ+sQTq4GoTAmyb76v4FCHb7kZTJ8cKi1tjrtTCh4ByMDQK3jC922OxRXA0lGUmu+byw/NizO2kh4G+61i2Zz6L/R3L4ZxptyrqnCWoRzS2JDWVhRUXnKLpWn2DkzPEohbVJDSD53zENblqIxXpEOoNBWF/ZuFHvhjBI3Qc1WLoEjna0ZYGmo1dDF1HmjnYks+RwJES+FFgGy8o515fu9mDCavcOqpTAFkOs2ioVnRuksabme37u8SFfCkg4URRYlkGHLRZoXKcZPay7ykYAniEU7qy1ku2liHDY8Q35D+muoFTtU8OPOhINcPOQVoTLEy2pjxDct7e8S94CfLsGLdY6BF1d4hRH5j/wM8rCK2WoXyVTEjCcJihnPSbJY3cigMOuGyqgGUfh2MDqSJhhfLrUVPrZnuuXHn+x8a1A9MHYhNqH5r49YNkO+akX3FkvFiYHN+/cybcFqGlbrTppz0+1argE7dBm3DO6HdRE3yjBmRHyweFl2As2BnWAZPmKjzTpOuwl3C4Z95a3150wSgD6/22U+LPFm+9ygoqzaWsxVEkCCfWTRhQZt4q5Tzy0bS5JGZ+r78pS1KrTE1Kc+8fq1xBVPYIhQNDb5CrE3oGAyq9fjokzuGyexbnhJ/viGU7wd/5E=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cpabapGgsJAuzgU80qbzTo0myffshNOALDnb0j/h5N4Y8tqS1SuowyivApugY3sHhNRM7SrnU4pHDXbSWBrVqS/QLd4pAmYP9spcc/Svut4PJ080K7k/YU4Pbsg+sBRMXWGnSMV4xBh8bKB2cKmc+xTwqBXKtPOyZngNSLmFNc5e+DE4PIQSu4qfRHXmb2UiOgZyOnA4lIXmXRXvZ/xp0b2reoSNeG7CLC9RtzI5KM4gKmobeJ5V+b+7CW9OHW8X73WpS4gmUH0v7JSt45IwO28TAg6qrXTpZ8CJtMA1FvQPYrX+L4KPOaz6JqNkH7Gy/5YsILu3MG8i286fYu3zvUyHkuCrjxXLb+SIFjEp3vrgtuRyjzGrNJ2E4fcDzg2NUFvzRypMkw9BuHWPw63vL7mW36ZKNnnFSDy0opK/j1eZ26QDmwBK9g5vpCS2fxkl
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 04:51:41.8960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e262b40-da59-41ef-f932-08deb0ab5380
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5048
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

On Tue May 12, 2026 at 4:33 PM IST, Anshul Dalal wrote:
> Currently the sequence to enable caches for the A53/A72 core on K3
> devices looks as follows:
>
>  1. Map entire DDR banks
>  2. Setup page tables and enable MMU (done by mmu_setup)
>  3. Unmap reserved-memory regions
>  4. Enable caches
>
> However there is a brief period of execution between #2 and #3 where the
> core can issue speculative accesses to the entire DDR space (including
> the reserved-memory regions) despite the caches being disabled.
>
> A firewall exception is triggered whenever such speculative access is
> made to secure DDR region of TFA or OP-TEE. This patch fixes the issue
> by re-ordering the sequence as follows:
>
>  1. Map entire DDR banks
>  2. Setup page tables
>  3. Unmap reserved-memory regions
>  4. Enable MMU
>  5. Enable caches
>
> Fixes: f1c694b8fdde ("mach-k3: map all banks using mem_map_from_dram_bank=
s")
> Signed-off-by: Anshul Dalal <anshuld@ti.com>

Forgot to add:

  Reported-by: Suhaas Joshi <s-joshi@ti.com>

--
Anshul Dalal <anshuld@ti.com>

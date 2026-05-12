Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A220CD484E
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 06:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E741F838BB;
	Tue, 12 May 2026 08:38:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mBIOAE2q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C8668341A; Tue, 12 May 2026 08:38:42 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E93658394E
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 08:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msFkHlKprz8lczfYtenjglS3iqzO12Wn4Q/DKsgE0ZeudXDDyd4/1TNfG4Hkec1bjZgOFpr+9Lbl8QUxroVgKlCxMTnAvZ/WEN4Lc6sAgekc6Hi+apZ7XtIkXOMr7S3oYVbHQkEt0qLMIc/zRpdmx02z2F5Rzob/lC6o1JX/UjWySUdF5eZ89v3FmU5xWs/CqvYULBaBVU6pMumm3PQTmDFFG1ABibcjkYxQc4fc+ZX1eGhAfMxLkR7V19/F6apmdYty7TLQF0tRwDXh9OI1Fq1KOWOicaz31nASjRX3F1IM99bD+NibWWu2nTrR1Gcbuj1IzGE6X9egPPjCinqV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2HBASC4Mx1UHj38euJ3tZ82YuhsbW5Uz6U0xVqODNk=;
 b=cD2kuXl2RM2Cw8rj0iRFqqtY+oSnduxfleAClYyMEUPwZq1usIuLniUC+2REEMIFHl+1jopixfsBaGNu1y09PdSDZXyTusI+HmA0DGZdqSABg0wttJWztq5g+15uEyuOkt13uy4h82lsGtcSkv9AvL66hYzqN5/6oP85xb9QMa7/6h8NUN58a7Uey3o8wd+pYfBCtgn7/RoSa7DOqnRyGine7u/wMGs5EoKs2/HkyBNvwJkLVEywc6aZnfWOReH/xRyY75ld5as99DY43rUENOH2RIn+nyID/D75RS3jfoJOA3W/w1nt2uB7Vi4Im26wUSLtRTTkfYXdGtJuV4amEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2HBASC4Mx1UHj38euJ3tZ82YuhsbW5Uz6U0xVqODNk=;
 b=mBIOAE2qLMSxkbUVjVrqXa4zQ1jJG/s1dU6BQ4J5lI4kvaJ0b0q81E0WHttsNRkAOG8ZoIh9gYb7jizCU8Rt2cAjzJn7vXGr72k8j+6ea+VOC0G6iZbKkK/7HjHQO0XT5Jur3By64EPMeBOrikBBsu/+bz3zV8BiP2p8nwPwKhk=
Received: from BL1P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::17)
 by DM3PPFC0AC38E58.namprd10.prod.outlook.com (2603:10b6:f:fc00::c47)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 06:38:33 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::a3) by BL1P223CA0012.outlook.office365.com
 (2603:10b6:208:2c4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 06:38:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 06:38:32 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 01:38:27 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 01:38:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 12 May 2026 01:38:26 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64C6cOhM889161;
 Tue, 12 May 2026 01:38:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] arm: mach-k3: j721s2: j784s4: Add errata i2378 workaround
From: Neha Malcom Francis <n-francis@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <m-chawdhry@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <gehariprasath@ti.com>
In-Reply-To: <20260508142507.1386946-1-n-francis@ti.com>
References: <20260508142507.1386946-1-n-francis@ti.com>
Date: Tue, 12 May 2026 12:08:20 +0530
Message-ID: <177856790073.1548005.12365612622473736852.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778567904; l=850;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=DE0mmWNp1k+WQg8DVWFZVImI8U47curdp/P4uGeTwGo=;
 b=tu0RoSIsgRPfDFFJ7n8vcJuCgkdVK1VdWzCa+1GgSLwraV2j28XCClDlfxCPVCr9jpnah/fYQ
 BiaOC/PL5cIAHE5Nu/HZwGqIx0+6yFC2K8C/FRvnaZQXUPcaL338Em4
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|DM3PPFC0AC38E58:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2a2af2-5a5a-4dd6-00bc-08deaff1165f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: a5C6+LBteRBBBUyyVQiW+Yv8CME2WmuV11WO2bzH+ICodWcKa1Kjjl+dZwfLoPXXwUArCkJnqGgzShbMHWPn9RT0Y7u/UQw9TdI0g1QVWleN6glEjKqefIW5PRUmYLORPkez5FkFaTSzciiTR4+FkKyXGebgP6vfFXFcdzDPtc9U8enJhpH4x5gaatQBL17U8TtDf2vHT5VeXOZY2O0Di5/sFlgF3QV76kQ92PJshx0X26+wxBSr/DPDL4Iuo3x4Hn9JeQ/RjPLZDCiG4x0FWvEflFkFbR3hHFR4elqm1VKlYfjliPcukacTpDGLijI71b7HN2iFBlCUYHS6WnThvBRd+qdeh9MPmQOXCVMQej16qvYGg8VVa0AYOjmxFK5KcdLBYmi+xs+RZFBBB66gwTvNtRzbtKx3IPuYaOLQBwU/aXFAHIUbh3QhiG/C9WxlNyJqZbGv3lqIxP5aPP96nGaBEMWiaK4gIMji8w71w0gDDTeoebxPFrWGQLhD3660KNuNmyaVWkqAZc7hpH48bB5ikPMb6RdFbb5i+VFpNpHoZa1tIAiMWTqfu/72ITECC1W0FL0v9s3yDw3H7Blp7UHF5vo8Gj9bStE8Jt71FCCyYoUEdHFPTkweS5Oj+Kxu2leYXipc8+8NrH2Q+S5CkmZRgEJEch6i11a2KzxM7eOdO/HpE7wH6cER49/syWjj4ibIGfe/0pJWBoFOM9Hj6JrC/Y5+1jiSc8+QXHG4SiU=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x77gsfjf1jX1Pl3dLuFsiowyNq6MRjndyszk1x2TQuNp036Ci/+U09i/RhN+CIScXQ4IsjAg+B4BpC+aPUNtIZ2SS1apbWmcWVOuC+T8mkQ7rUH/mDI/W/KXPcLX716db7B3NDnc45Pewq/6ln6q0jMULKE8Lj2y61VQON+oPC+gZs+qUZa2k9mKPC4PITUbPLtW6yisI0zArZhysnjwGDfsWWE3CYnPwkkbMUh5sy2+XywDm1BK+uNUG14yHrjJPYItZvBod5tdYyjmreK96meV+W42cRj2tll76GJels9ciFirm4F7Zu7rtCNMAZl8yYcgefLANSNBqNzISjFFBafkMdfjAlsQxqF7HZNC+0jQe/cT718MdFE18XJTrYMx+CenkyC1MFZYvdINImiLaTNthhGSv3TRThm9dP0cTNSeviaQNkk0CmxVLyfc4XM4
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 06:38:32.9306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2a2af2-5a5a-4dd6-00bc-08deaff1165f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC0AC38E58
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

On Fri, 08 May 2026 19:55:07 +0530, Neha Malcom Francis <n-francis@ti.com> wrote:
> The shadow copies of WAY_SELECT MSMC MMRs have incorrect reset values.
> The main copy has the correct reset value but MSMC functionality uses
> the shadow copy values. This incorrect reset value results in
> under-utilization of MSMC L3 data cache and snoop filter for DDR
> accesses.
> 
> The workaround is to write 0x00000303 to both MSMC MMRs after reset.
> This ensures that their shadow copies get the correct post-reset value.
> 
> Link: https://www.ti.com/lit/er/sprz530c/sprz530c.pdf
> Link: https://www.ti.com/lit/er/sprz536b/sprz536b.pdf
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>

Please ignore this patch. This errata workaround is better fixed in internal
firmware than here.

-- 
Neha Malcom Francis <n-francis@ti.com>

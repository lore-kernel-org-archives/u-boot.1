Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6379CD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 05:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF8AE83C51;
	Tue, 12 May 2026 07:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aoryhNnx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C35F2803C6; Tue, 12 May 2026 07:53:45 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC583803C6
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 07:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZQ+074OjWh81YzlP0jkFoUKwNJ1m3evbWZfEuPKHeHWQ3RkD4fdvzmxvL7JjLZtL9PXksTktRp6DWH7V/30DJmgTvAmJFwG/dkmtpWkvdKurI4kgxxLpRuWa6nAIUmXlm/WcKNim38265vhDEZS8h+JEEWI4KpQwd4dAE7H/dQQGYoYXxvVhSwAk2qe+dkTy3iWgIVRWIyzMx8YeWI9v/2O7om4BXMr7XRHM7kEoaimVnELRIM4d/Q8t5XXfe6jQSNH+vfFUQtCb0422tLHQ0Xw9oyF9RpZ08e4FRSJIJtcLPcIO6FQqO9NQy/K+YG1dIlclsD930OtdreguzFOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TILws9bC0//lPTn0uhTpVXog1z7w8sfR1G7SKDv+mZE=;
 b=HeXCFbNrGrsvEaeSfNMgfhfkG+b0mLTrPr2to3tIs8tgV4zds1J7833IyrV7o/UUp/WnfOsPXOCooDJIm9XRRODIzorvsUarH9t77V7cIq61qtv+iW2Nuvwj2jgjnO1rPV19zek5Y91dpqGQ/KHOBRrlM++bl4V2WbTVQC35OBNzsauWE9MazGGbKMGwlmWyxylS/F/8dAQo37hHkzfKyenOZylf5CpC918dG1bFVxWkJtxlYl8k9DaTsyLioJFq6pSz/zDwkqKLoKQTdjFar0TKO/NSqDiE066sK+BH5JLxnmTLLbNIN/rA6f4h+ypYYA6yCKyHPIN+e1JSSI3yog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TILws9bC0//lPTn0uhTpVXog1z7w8sfR1G7SKDv+mZE=;
 b=aoryhNnxf1qPyhqSpruVuo8sNSZ5aR9FPCnD+dAiBbCRKTEl9mB4IKTZzS5+uQiYXRMku4lWuxf11bmsLFMJhKxNJZdjCJ5aX1eh1YJpeWI7Z6BEfNvxugZIqddIem0WJOmRL7sxvUkP9P6C/rO5NJkZIWLaCXnuWFNTD9oO+mc=
Received: from BN0PR04CA0198.namprd04.prod.outlook.com (2603:10b6:408:e9::23)
 by SJ1PR10MB5977.namprd10.prod.outlook.com (2603:10b6:a03:488::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 05:53:38 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::c8) by BN0PR04CA0198.outlook.office365.com
 (2603:10b6:408:e9::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 05:53:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 05:53:37 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 00:53:36 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 00:53:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 12 May 2026 00:53:35 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64C5rYR4812821;
 Tue, 12 May 2026 00:53:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/4] Pass reset reason to Linux via FDT
From: Anshul Dalal <anshuld@ti.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
CC: <u-boot@lists.denx.de>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Tom Rini
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, Ye Li
 <ye.li@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, Bryan Brattlof <bb@ti.com>, Anshul Dalal
 <anshuld@ti.com>, Dhruva Gole <d-gole@ti.com>, Devarsh Thakkar
 <devarsht@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Moteen Shah
 <m-shah@ti.com>, Chintan Vankar <c-vankar@ti.com>, Ji Luo <ji.luo@nxp.com>,
 Richard Weinberger <richard@nod.at>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20260511201235.1066697-1-alexander.sverdlin@siemens.com>
References: <20260511201235.1066697-1-alexander.sverdlin@siemens.com>
Date: Tue, 12 May 2026 11:23:29 +0530
Message-ID: <177856520962.106112.6840715298573844869.b4-review@b4>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778565214; l=683;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=nE2M4Bi8qSI56PSfTXsalEsKVgHd6GEMmNs/AgesC7Y=;
 b=Uoqa0QB8Cd4F++HlyyfgtWRBDDZt72CjtIJTsUqQ9u74FbLlGQoNcHvmbB94nw3tpkTMVlqn1
 vymsDowxQW+D1whjxKqFy0evVtuo5XY4L/lQ79cbnvI+D6kWw/E0xds
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SJ1PR10MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: da4a7b25-dd0e-464e-6225-08deafeacfc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Sm4mAbyVtTYHAtDxGu/4GdFeokpAPzEX78B6L7k2ScjTOUxyeL7zXh5MxCbMsomFSIW92QK7Q1HhMgm0wPY+Z9NGGbl0ddhyE01qFsRske5Pe6wxf76ErTcOR+OuoBX3FT8HkEf7IVx0hjMfIP8Zd9UzsqPx/aPicdQ8+atcaurh/pLAy7lX6EU1iIrzyEGESbAwL0KYvtDoFjdCr8xOzE4EQKJpLRmhU9djSbedoET3ER5JBXdsDJDuMBfDAVIQCY6Yrjrfddf1m6gro9lwfFBAslKcsKvhWnJT5vuXzTscyg4n44qdqwBv+QZe2CCRkTukwxDMCCtOF2uUU0+zIkrWKGVmQyiG9YCPIiMKa+M1o3UcKGgaR7YMSCbXU3TmQnlDKva5rcTk2gBZSidy52LU34Boog07RloPuIb0yBmpqwmZ8GGFzdUAFYY+EdpbXQ7VWwdKDX/uD+4hxbugOFdaZFYeeEff8oa6FJYPnjc29kHlToSzbww9ihp9y6gzAkA2z9QsgdnDPGedEr0uU1m//Zqggh94HY5XvSbOX82xkXvrE5H/69O8KHXlel+J6RGhjPpzmMQO8yXIhjWIfcJ65N59BR98gW66rI8PkkruuK8mN0cbACecvrJGRPAAe4KluQ5Z5rjQ/7rYkcZAS2EhMZfp3wdTS+pD6OvSbxlrVlRasYEzt04Y/eLQuO5NV7PPKz+Sl/FIqwCHs3Yt63G2e0cpgBAM03pfz7qcaJQ=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qRnqoqhAZvKSGdKnIS32I7CcMcTPIC+gAoYP2KVfNXf52qY7UoSWr2sj5uFmJkypxGpZE9/7SMBLcimvvChp4zReh9nACA4NLSUYuihhC9HdfLjyZtOUlSsO3mNkJzPRM2NEwRkEQMS4t9UNkZCfQ88gezw/ZvpSu3+f7bwryfLmjxJte+9mVGQ0XFLLI1yVaBKSc7J83tzgfgjwPPvj9ZFyX16dYjlub9p5GCDsFbhrKfye+g8Qr4TS1YYVkhRwr6xxcu6XKJTuZmxUDK4onDq13ClhhMsZDAvqAcDss1AbiR5iTtCQTIdORk9lZW42VNDQMtt95q3bVMunRN62DsVLHG5/o/UgmGes8BzwLgteareurHYyorXrE0v1JsyeUDvUmAT4TS3OftdelTGh9z4d6gVFUNx3eMXsZn9+cTFkYYgrNBVBWU+j4ITWl+CD
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 05:53:37.4997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da4a7b25-dd0e-464e-6225-08deafeacfc4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5977
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

On Mon, 11 May 2026 22:12:29 +0200, A. Sverdlin <alexander.sverdlin@siemens.com> wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Make get_reset_reason() available on TI K3 AM62x and AM64x SoCs a model
> for further SoC/platform-specific implementations.
> 
> Introduce new CONFIG_RESET_REASON_FDT option and optionally populate reset
> reason in FDT passed to Linux under /chosen/reset-reason with a string
> returned by get_reset_reason().

Has this been aligned on with linux-dt folks? It might be better to propose a
DT binding to lock in a specification that U-Boot and other bootloaders can
conform to.

-- 
Anshul Dalal <anshuld@ti.com>

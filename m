Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3818BCA0ED1
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 11:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A02F83AA7;
	Fri, 15 Aug 2025 13:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="U5DoAHft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D150A83AB0; Fri, 15 Aug 2025 13:11:03 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::70c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CE8A83A6A
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 13:11:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F45Il16TS/C6ex4DHcs+4FkEM2WCpHjN/TNUNzvosqCFe0iM6UvLgZUDeGOLMjVURbMgcJk6WN5s2SsRIeaZ58ihR+5KRMctfi0j6QVvVKSNk/6BGNETteL/X414AhXWlkmg4bnXjR8HFcWg1wgWG1gQ181Xfd5799x/xKsZCjySWSd0tsx4HzTntnM/I5z83i4/9aLYIQ8+ijWoF5zY9c955zydGsGhoQbCiPtleVT41PmMSamTtduwJvMxi8tkd9xBSGzwQlovS4gNCcspAinXerm6VXHl2A8ZDDWZw/vnsvd0p5vX3tov52a3yrcdydbH7Zg4vP5DZv/eWogjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A89189rO8B4eayiFk0nAuagE4IUzYtDXW0/KoK+3J4I=;
 b=MMWRg62T0IMO/GSMLgHO1ypy2zC+y9dBrGP2FCwpPPgeKO9MF6EhWurbWOAuyRQOM/mPyag1ZXfpgaP76B0xMxeoWmGaRIP7z4UAACEEC/wVsRBIX9wYmCdJgozg6J0/x+X2YsNGA8Qmg0FYpmafyLwgoPRj2Gle4HzfYvad60s9RmMtYvrsc4OveH8GfCWNK3l27vrAoavbrx/ObR/MzwOK1By75JEj6BWJ9zOrnLZyXHfyesyQQAx0IVJe/afeVclbarcPDKMZmKoaRwn8DrWlTCNQ+N3BXaWI6x4Aa9rLDdQ/MWcC+OhROLvmKxyTjU2fskeLUI1CBlDVgNkztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A89189rO8B4eayiFk0nAuagE4IUzYtDXW0/KoK+3J4I=;
 b=U5DoAHftE4iaHHZUzXeG8l+vvivO+1szLEDR4FWktbEcWI5dOwJprYYzsaSxoRkoJIefgKh3bJxuY0O7HVWPgVWnyCd6K+EeUz1d/qGGUqQbxmZhZLsFht1mpNS+jPjZDb3t64lCGpTeP6a14PqhHg022nz78hiQWGeUN3UOF9HVV/Y81ks6loMD+jYuYzYDiAkhZJyoTorEES9jU6dKhRrozvutZ4qu++93Bj+pdeXUUDSekI3MSoIyoYQmatLrW7sNCRT3soFBAvFK7ovQ6b3P7LNsG1kHrz1VtUuEKvuX9KekiTArE777mMcksr10qBbcqjqBAiFuOz51SYKmjQ==
Received: from AM0PR02CA0196.eurprd02.prod.outlook.com (2603:10a6:20b:28e::33)
 by AM8P195MB0881.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1ca::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 11:10:59 +0000
Received: from AMS0EPF0000019A.eurprd05.prod.outlook.com
 (2603:10a6:20b:28e:cafe::8a) by AM0PR02CA0196.outlook.office365.com
 (2603:10a6:20b:28e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 11:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019A.mail.protection.outlook.com (10.167.16.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 11:10:59 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 15 Aug
 2025 13:10:59 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 15 Aug
 2025 13:10:58 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <d.schultz@phytec.de>, <ggiordano@phytec.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 1/4] board: phytec: common: Add PHYTEC_EEPROM_BUS to Kconfig
Date: Fri, 15 Aug 2025 13:10:48 +0200
Message-ID: <20250815111051.2277173-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250815111051.2277173-1-w.egorov@phytec.de>
References: <20250815111051.2277173-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019A:EE_|AM8P195MB0881:EE_
X-MS-Office365-Filtering-Correlation-Id: c017c1e8-e8bf-48b6-600e-08dddbec6a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qEdWmJVzxRrXIh18Cz8/YPz1VfKT9E5mR+b07lg45/TT6zbltlBZbdMecIUY?=
 =?us-ascii?Q?GNW7+qRA7o3R4t1J/18ys1C1tRmESDyhFMy0Fg0033S0Z44ssXPWLpQgwMAN?=
 =?us-ascii?Q?dZBpV8MH2gx5DlGrlp5PekEMlpLESxl3NjRYFAfCOOUTX3NAJVApIyyodphm?=
 =?us-ascii?Q?9dFOGwcdAq2UzoqBaTbNduxZIezngkc0vYTZvU5EPm8nhquQ7xx0yXcqsG7R?=
 =?us-ascii?Q?yJ5eC+N2wFm1KTpA3s0WOusqH8Fapy9m2T6EpDa5CJJCQN2LmpOcCVz44wSq?=
 =?us-ascii?Q?0T/QnlN34FJA3f7rbpOtQ2Vmk8ziidFxVS0yGteH0lfMSeRtYes3oW8HFfqF?=
 =?us-ascii?Q?iJ8aAmt9TM4ABwbDPRHB7YcKqwVqJKynbDGDZoxiTbnIowk5Oh1LZ3O0ze/1?=
 =?us-ascii?Q?9nDYKPCrdgpP4t2DMiRV7HHe0cCLWJTsfNa0HiRguOpyBhNdG0KrzrwVPOHa?=
 =?us-ascii?Q?WEi7KcUiQvw+VvwFF8HFtUtJWcnkGldCRYOOtkO0bNxLHGFMmADd0b73qRzN?=
 =?us-ascii?Q?L2I25HPGN9ahNZLz1k3hGBOhelvmfBlf+yh9q8tHv+KrxLf7svD+/wzNxQko?=
 =?us-ascii?Q?GIufwagR/ujpn2EBU4MGrGPoTi+1kXhR6MNuPTIP2FftWli+m8aRqG03QHy8?=
 =?us-ascii?Q?0AaruGrCFzP3PpwjLIeigzATLh2bXrKZLXXF5hJhecAhAF/D+PRYcRFyFZO0?=
 =?us-ascii?Q?/UPTq1DsfODoaBi8BpsMsrRIhy0acLsXzswjwDqswl4O26jNFDOOItz9u7Ak?=
 =?us-ascii?Q?+cEf9QsVNcdUAh2KMf0riZvIihmeGST8Vt2I8BAKICpVu+qbXUSw9VgezfrJ?=
 =?us-ascii?Q?/NFxh976m/p/NMwt64WJcWUvE30r/HFBpTHVekJJBA6MPnRaCH53RVdodu0n?=
 =?us-ascii?Q?74tI37Yq6EqZPjio1mUIO/5fIpp+Uni8zViEiEfGsnSiBTqqkEma+bI9BcX1?=
 =?us-ascii?Q?C5+mZDAbL8rDQFcCpiAWvGfmySo0r623CZxFxuoHW+DmUYwQ2QDu1scly9Gn?=
 =?us-ascii?Q?WwsswypHAHmWR2pmtsydRILYoJ8+5nw1Zdwp6jtzsk6iojQU3yOixZP367OE?=
 =?us-ascii?Q?OHeJlqhLh0H4Zbaw5f4/ArcdE3KFyk2+iIcMNryCbLGoEVGQz7fXcd7pzbZ5?=
 =?us-ascii?Q?egz1637JVO6HPrzNGWpXPcox86PpVterLdhLc8Q9SLPpq7UQxNioycjsfcZR?=
 =?us-ascii?Q?NWAN1FR0sEWn7vNHQ2nHeKfFbryi5qaUEtb42zNcUFi4HyCrXHBgIErZWIT+?=
 =?us-ascii?Q?PdeUHtyDpLIZOtjGDZ4K2SXm5tJid3lvSP+4+FEtdj4VD2t1m0FVLLknD2/X?=
 =?us-ascii?Q?QN7K3Q/8CSshy/XqBmgMR2Yi26zhIpaLMUZjZ1tTdFEJgi10t0FkuJCdjZxJ?=
 =?us-ascii?Q?TigOHemNlE3dlLyiUMvMgYmxDrcdlIpWE2pGjvh7jcO4dRF/Czw3ZC9QCxLG?=
 =?us-ascii?Q?hlV0U66kQsBuo9oiOG+Yuun9YssF8Un1W0cRds5A8pRmzc/eOIgDKgWLM9uY?=
 =?us-ascii?Q?70NVYxdDdnNSfxDucNg2iJPdOtYISywwUHka?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:10:59.9018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c017c1e8-e8bf-48b6-600e-08dddbec6a59
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P195MB0881
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

From: Dominik Haller <d.haller@phytec.de>

Add the option to choose a different bus number than 0 for the i2c eeprom
based som detection.

Signed-off-by: Dominik Haller <d.haller@phytec.de>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/common/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/board/phytec/common/Kconfig b/board/phytec/common/Kconfig
index 65451a3b20d..08d6e5f3683 100644
--- a/board/phytec/common/Kconfig
+++ b/board/phytec/common/Kconfig
@@ -59,3 +59,9 @@ config PHYTEC_AM64_SOM_DETECTION
 	help
 	   Support of I2C EEPROM based SoM detection. Supported
 	   for PHYTEC AM64x boards.
+
+config PHYTEC_EEPROM_BUS
+	int "Board EEPROM's I2C bus number"
+	range 0 8
+	default 0
+	depends on PHYTEC_SOM_DETECTION
-- 
2.48.1


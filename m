Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3140CA0ED1
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 11:11:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 775B183AAB;
	Fri, 15 Aug 2025 13:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="meO2iD/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB5F283ABA; Fri, 15 Aug 2025 13:11:05 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::700])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D53583AAE
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 13:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoCBy8P1OUJkLYstrQyIMnOvsLOWm/3q0tEMMW2LRKi04oSd6sqwWZjSwmAPfxO3GJKGVllKNuiWDuu2ayMgs3SxZd8srAshy+p66R0bzud3CGJ11uzNAwEZdfUPTXpov3fwsVvEIAstOqiNmVFsacznY4HADZxun/i3ybCcz8Kf4Qv7qzzm5fNI13j3tLvXmurimsDMEpvRZxml66g7GVoFDJPUAN9uHT0IYrXVQiLwFN2hIQnmCAkHCcLQ+f6TmUthlAhXC3+SNA4WS71Wq3fwIIZYO5dZe+NMSNGYcC7NuY3qRbjiAGt9kI0KG79rRQuEldlVI0lwYkryaEWpHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/ZhEq7c7bSJp1/Dk5a4t+/ndStwMBHHprL3r71mTs4=;
 b=RvdTlNg/NKzLkZlD0cjEes8O2aNjeE7i6MrhCXCXdg48gyXAPsN1xu5Ky9vecymOoFQWcUMaWdPFPJTCrokz0R3A5fThx7ALPhnMQxMVf9P5hiYdDO0oPAFlXnd7R/sFWJKDhPOdvfRdfQp1osGeY4Ym/YsHgnMJqpOojcGa3nGf0pEjsTAPbxDVL6tE/UidQUcT2U9TbxuqKrP7AWM7Js07uND6PfmV6wKPkDYyvsu1I6ag8rk/fDvQYdiZH1iTCXM+B724483pt+DtShXAHrt/lw9dXI6j8O5oZGzQ790WxAvYzTPhEfweYTpuppBGgKREdJhCHR/iZ8nUpCV9/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/ZhEq7c7bSJp1/Dk5a4t+/ndStwMBHHprL3r71mTs4=;
 b=meO2iD/1bO6lSaPn1G3QMAYm3u/pL9XuARehRl7yeYFnFwOOEd5sv01vVwGVwI/PdK04fmvaKiim/P+X0/pvGebyJZ6VwKwSpGz61RYeM+8U/3Bk0HR7vk+VoG3qmOfCVY/uZu1Us855rKS5uLgmA26R/wmK70zsHFeXhxEBN1eDNpwIaFKvxvs0uCCyit4amu74TS2kNKWtwtwAe4W9GjZgS+EcftIH1TNrA62M2P9u0s3fMALE7sud5u1ow4xLTMqtULB8+uJWJWYoOyrZo/4mWH4c8KA94KhGRBxb3rsODQZsePV+Q5QZKVHmfoSMuPxMuro6MGSheeBScLBo8w==
Received: from AM0PR02CA0180.eurprd02.prod.outlook.com (2603:10a6:20b:28e::17)
 by AS8P195MB1824.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:52f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 11:11:00 +0000
Received: from AMS0EPF0000019A.eurprd05.prod.outlook.com
 (2603:10a6:20b:28e:cafe::da) by AM0PR02CA0180.outlook.office365.com
 (2603:10a6:20b:28e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 11:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019A.mail.protection.outlook.com (10.167.16.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 11:11:00 +0000
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
Subject: [PATCH 2/4] board: phytec: common: k3: Use CONFIG_PHYTEC_EEPROM_BUS
Date: Fri, 15 Aug 2025 13:10:49 +0200
Message-ID: <20250815111051.2277173-3-w.egorov@phytec.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019A:EE_|AS8P195MB1824:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b7ff57-159e-4ed3-790e-08dddbec6a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?glPtJNFoB+/7aexoGnV54fhABSYAn8GYixgtYSeYBVmx9EjyJva9B3sHhrXA?=
 =?us-ascii?Q?oSxgq7Bn0ORWnERdQOi7jp6FYKAH/v64WhyO7twnLiTU26M33AM63ZNCoZWQ?=
 =?us-ascii?Q?J5EMnTvDRW7O3uBsb6EAik0h1R4KnndGZ4f8LvuHroWC1SOIUprjltOJl9/K?=
 =?us-ascii?Q?waAPTBorNoX1fVnb55lQcWU+akbwKTXOfzvX26cIDq1LXihXIRqBLClL+Tqd?=
 =?us-ascii?Q?qXYE4z2E4faXKbQO8YmDOR+lP4u9MaFmbO+K25VsRTmepQeMDHrtnOtLS2xO?=
 =?us-ascii?Q?h2AXe9Sct79pYZhvR5zUWe6Xyl/btRlKjZoGg9sOKLqmLfC7BqnoyJfiJ1h3?=
 =?us-ascii?Q?gWioENfPX0FjGsEBNX9O3loPPKzIuMSz/CuoqS7pH0Pm+IcC5EP7OEi5hdQ7?=
 =?us-ascii?Q?ktDHLbCXuy9Ig2d8B0Lcg0AyOM5N+rNi9ON0I1bX0q87GzydWjH/lxNGWXJd?=
 =?us-ascii?Q?/eHSR0CSRQHTKyZzLJdFaPxwQ7ylJHw+U3JvJ1VzTxtx1g2sXuEZf8EAIzgE?=
 =?us-ascii?Q?AYf3WmetYKQ7hb3eOu3k2KFkKqGA5eGKhnEuqvR00aO7Udg88CmqNxLGlTZT?=
 =?us-ascii?Q?IU0LuEP9tSNAB1I3mtt5Q+bJQzvyshHRhOpl+FFHIaAZWmvJACcaQ5jeieXM?=
 =?us-ascii?Q?4hJCxwdektLJFp+XxSg4s4kg4XOZQ5iuwfaPHFOKsGoE/bSApVpU86FG46AO?=
 =?us-ascii?Q?K+eRJubYz9FM/nH0V75B7K9a6xIDm0gLL3jLNor7u/fwcj6gT1iNml8e/aD0?=
 =?us-ascii?Q?XFyl/SmKSekS18bf5cIFmKuHFLW04ObsGSaes+gOjF1uQujW8rkGcZX/m+RS?=
 =?us-ascii?Q?0SV+nWWuOPaB9fIWDqbJJo63dGZ21NSA1SLsLPXgnH4XisqBC9C6xjMqGM7b?=
 =?us-ascii?Q?f+4eygJ+q8jPd7FStU+X6rLPEPvZOOEA8vLrfzUQtmuebbzPAfPImQlS1U+T?=
 =?us-ascii?Q?L0Ba/H5tCMYS3HkRBDh8YVbGzSfmg2sXY3lFWZdQ5p4lnwdAbR9rEhACcrvU?=
 =?us-ascii?Q?JCTIjpMBb26naF9rHVGy/m0mBZLk21MRpuWCHlyQ1aRXlJ5yPaMxbama9Xln?=
 =?us-ascii?Q?Fhde4o3ydtKYgRYSoFMtHAulHimVcASMfwKX8s5ojrucJ957/Oxzn2/UAyQQ?=
 =?us-ascii?Q?sUXas1CAWZMmuHpTd+pMrO5O8jpk1lMoOiwFlACkntAQrVe/hAp1kpspNa4i?=
 =?us-ascii?Q?Ek4QxHAC6b91RpHxaaG5P4H4ss/RHvglHGN7tzMnShuhX9xDrC9wPay4n2lb?=
 =?us-ascii?Q?iBQr3jyxI2sO2yhSQi14xDxRMq5au2ERZoW8nZoy1pDezsKM1XWNCIGPdNHa?=
 =?us-ascii?Q?Ds5gTu1NluM0pt5vKwjmnCgw/nT/TuzxDl2N51xN1WYeJAgrkxIIpQ632dta?=
 =?us-ascii?Q?8jKgFIaXBc+puhPmSoZ4s1jM1Y/HxdXUg7Oec+j7VbzPNkGKo0UozKEerdUt?=
 =?us-ascii?Q?a6Lloa95kWiPQodqOgo2w+VO/PTyDRjl5u0mzYL65VMzA/9Csuy4to5Fw/0x?=
 =?us-ascii?Q?f/t4ys0yrQLzL+0JqTclNRwzUpW2Jqp1zed3?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:11:00.1589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b7ff57-159e-4ed3-790e-08dddbec6a80
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1824
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

Use CONFIG_PHYTEC_EEPROM_BUS instead of the hard coded value for the i2c bus.

Signed-off-by: Dominik Haller <d.haller@phytec.de>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/common/k3/board.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
index 7f34d71d530..50d4a7c0d27 100644
--- a/board/phytec/common/k3/board.c
+++ b/board/phytec/common/k3/board.c
@@ -182,7 +182,7 @@ static void setup_mac_from_eeprom(void)
 	struct phytec_eeprom_data data;
 	int ret;
 
-	ret = phytec_eeprom_data_setup(&data, 0, EEPROM_ADDR);
+	ret = phytec_eeprom_data_setup(&data, CONFIG_PHYTEC_EEPROM_BUS, EEPROM_ADDR);
 	if (ret || !data.valid)
 		return;
 
@@ -245,7 +245,7 @@ static void fdt_apply_som_overlays(void *blob)
 
 	memcpy(fdt_copy, blob, fdt_size);
 
-	err = phytec_eeprom_data_setup(&data, 0, EEPROM_ADDR);
+	err = phytec_eeprom_data_setup(&data, CONFIG_PHYTEC_EEPROM_BUS, EEPROM_ADDR);
 	if (err)
 		goto fixup_error;
 
@@ -292,7 +292,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	fdt_apply_som_overlays(blob);
 	fdt_copy_fixed_partitions(blob);
 
-	ret = phytec_eeprom_data_setup(&data, 0, EEPROM_ADDR);
+	ret = phytec_eeprom_data_setup(&data, CONFIG_PHYTEC_EEPROM_BUS, EEPROM_ADDR);
 	if (ret || !data.valid)
 		return 0;
 
-- 
2.48.1


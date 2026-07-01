Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63176C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 07:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ADB284B37;
	Wed,  1 Jul 2026 09:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EI11Fxpl";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IHEmTzbK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A08F84A7C; Wed,  1 Jul 2026 09:50:42 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED2EF84B22
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 09:50:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6612uIIY2210128;
 Wed, 1 Jul 2026 02:50:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=N2ILppgGNn5gNZZ1jywKLtrEpTcqJODeIioVTEAA6
 9o=; b=EI11FxplVp5SkkXp4GDsW3hCkPL5J4ZRIrlbY4f+RZaaTb4MFFpLSDjxp
 N1AWheI56iBkL/5UXrlXZqobgE/gutYQQorW+uu4LP/nS2mOv+Uz1jKIRBk8ACeu
 ZD7gV04aOrG/gTX60PWvT6ANoaxTu0TsQlq5V6PB89Ok2JcY9q7kP+jY/dusk+Ki
 ECMwP/32Zxfg8ORhp3zWNVt/9JQvjq3odmxe3JLV2RWztP0BcLU+OTAuuDuuWE2L
 9h1V0CAzPkesQtQPwkc347JUDF5sI71xVwbsasWR9TiYhSpTi0ZY39xFiEKj5z7F
 fTA+atMDTypOkcMJ+G1fJOyzjP7bw==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011053.outbound.protection.outlook.com [52.101.62.53])
 by m0384305.ppops.net (PPS) with ESMTPS id 4f4cqjeb63-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 02:50:36 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtMDNSdsmS3Odhk0Ek2hHoHmfDOMl3Oid/tNjZ9EBXpUTxd5vdTsp+x3yOUFAv0a+hxtoZgxi9lwqOZjjEUioWR1IiUsjKmXDPu9Jl0+HcoWMSsTAGywIYYcWCCRYBbCviprmIrHm8ztLP6N44+GynesZjLje2nW0RQ/c8sc+GYSgUmYIFbenYlap8Oi9PL3HYi2uNmbmGx7C6WyuOX2nnJBcG7OR0MgtCt40s35M0S0u+3PiyHI7izjdlmp5NQ4O1+tZcRM8DZcUnCPnRw3ilW+SZIgrzMSz0jls715MniX3YuBxUEq18PWQoNZcLSakCxKbjTDG7mq90UJUUKwkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2ILppgGNn5gNZZ1jywKLtrEpTcqJODeIioVTEAA69o=;
 b=YwE0PS0CnLyIci2lIHsNPWhAMpXuZz/g4iE7gyD2YA7Ho7lCQ8aCUvggeMRrVpmgYlY5qOuADdmqf1opylbZ1j1leDQ9MVuno9OFWUgxiM7720VjKHS+1YLlSyt3LsgjpCuJ2JfZOg/kGHZ8wbSv1G+15+nxuGZrcqrYjyj2TUHcohYFBd5P6qdAQ1iwph7NaWQR8BcrfQUP3wcx6cgDvsXcyXcvalcn3PGK4MNthjq5OAMmYZbQ4BZtEur87ananweZ3hXbC37P5qvaCqI448cCse3cU0ykkkg1iTPlUL6FpkKXD71BmbGXxtyKUK/RjTy4DMU3hRrqM5yLNz4Rog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2ILppgGNn5gNZZ1jywKLtrEpTcqJODeIioVTEAA69o=;
 b=IHEmTzbKjZmBq48Hmafabn678ByrJU6vm8n5ZCINlYeXhaHYTSI8kNniabU7Ek5MsyNZ13UZO1XbkknLrmN8ptI76QU8sJMv0iK43tewCBwc7xGfkxKd0Wl2wfA9XLn83H80/6dvgkFiC9q3Mcjo66o9XHEcQtYegxb9mA25bRE=
Received: from PH7P220CA0048.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::19)
 by DS4PR10MB997551.namprd10.prod.outlook.com (2603:10b6:8:31a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 07:50:34 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:510:32b:cafe::57) by PH7P220CA0048.outlook.office365.com
 (2603:10b6:510:32b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 07:50:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Wed, 1 Jul 2026 07:50:33 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 1 Jul
 2026 02:50:32 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 1 Jul
 2026 02:50:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 1 Jul 2026 02:50:32 -0500
Received: from localhost (ula0502350.dhcp.ti.com [10.24.52.241])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6617oV9F857437;
 Wed, 1 Jul 2026 02:50:32 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <msp@baylibre.com>, <v-singh1@ti.com>, <anshuld@ti.com>, <afd@ti.com>,
 <m-chawdhry@ti.com>, <joao.goncalves@toradex.com>, <bb@ti.com>,
 <n-francis@ti.com>, <sebin.francis@ti.com>
Subject: [PATCH v2 2/4] arm: mach-k3: am62ax: Enable OF_SYSTEM_SETUP for AM62D2
Date: Wed, 1 Jul 2026 13:20:19 +0530
Message-ID: <20260701075021.3626094-3-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701075021.3626094-1-p-bhagat@ti.com>
References: <20260701075021.3626094-1-p-bhagat@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|DS4PR10MB997551:EE_
X-MS-Office365-Filtering-Correlation-Id: dd15af18-56f9-406d-9ea4-08ded7456e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YtxYVdoYg6kKBs6GGUDiUI0+kNFgmXo5gUe9WS8l99VkQZdKKkuG31U2Ay3hLMFv3wcBpGJrEKkJ6QtS030nr0MiZzgUS8TxbiZwSgAf2o21D5lhplwwZkSmgEVr4a/EzalXOnIzwc4LBnPsqMTmpkM4DYEf90eDOVcZv2Mlm6o+yeTlE59jD68AhdvdNLP32l+FeI4HgB963PUSQwA9+SL0SaluUX8UojylOBY+NTdVwhhZPhxZHt1tqYDHBANW6iGfbDDZtTV3WUk1LKjsONP4/p5pn78bNTNXGHcFMTKdJGhUYkJFyPsY5EWPcGFebxFIfK2bZIxWNIghUGN2cgfWHwaIzcnEXB15MWvdD9jiz5zVY/6ghxr2TimKV3eoQGfyLe1StRhbUHpStU/cPLowJTBt2y2s0l+dyQhziGzgH2GwSggykWrxJqMd8Xk210zdDmGWZ5MtCIv3aywqPLV3j7GL8T6+43gedgmN+B+UaqmzJU1rBy4RaMzLzmb55lyHf42O19cKd9OS69Tn/hylUzcOenXi7tLkkN5cEPnXhFFXK1yczGrk8TGoCclUH9t+ZDCJ0zKtn9hIAXUQmfsY7JJlDvR7sXBh5db2f8vZlr9CBTK2xS508dzp428+FarF4otrxOxiU0UjvTYBwCcT4cSq1s7DRetj74Q6oldPXLSbDCBSsfaehb/u3ufxlsEYuV3A/HcUiO0oBeGJGg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZdPNqCa/STuZC5Pvvc9la/vlUrJFB574dd7kScz1A73qO6wxgDvBlplrM57czstDEO8RnvWnLmFyYU85uUxyjPh9pYiLaaobrwDdC9HQo95uEIwN99U3IDmZGWU/S2T4KZ07FPZBYQOacALqOiXrZepDJV+IaxuBdn5aWoVtIeOLISp2hue9sKU5GI0ulYNDpcFBN7n2lfm5UwqzoDc6D79I3rjooounbinAavwvcEv45m649WFC911p5fOxgonGe4L0R4ueUFYYKPt0wuE+6D5vsCYwWvnXPHMPQfU1NEa7HzsTAh+M97rme2A2xBe9A0/X6Odkd4H6ew5tuNrbM8FDcjNsFSaBP3TSQRnZ1K8J/lhraLGOVj77MZqEtLWWn37XpD7Fz/pmxoWVyr/SuSeMgIdO2jbBbuRzvnk2q4YC9sORgGAZtXTmIz5vSqbe
X-Exchange-RoutingPolicyChecked: VafTC9oK3KPAYyNpTALKjx6dXqzU/rommdRzcMlT71yG9suEg5hcL2hcB7ZxOcmBuZcuzMDZQvF+PAJLztgPrlD2IKXLSIQi9ibAL0/UD2IWRwwPwoe1yJLqV6KRWTg0zbhktKkK7i7lg2LgGN61GEg/jBI2+awR2jF+bzdz4wDCFv57T3AcySQBFkYepnt+7T1HbAG9prxbeuplCThvgiB1l05NP3oKcd1+PZHAghf0PTzrECLzSKDRrGJf3aG8tPtUOCyAKTl5evFWy8HDdmvfHbSKRoZI5yg6WL00pIfkla189mVgoAIcxQUB0mYvPkjResUO/+g9aubDebNYBw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:50:33.7023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd15af18-56f9-406d-9ea4-08ded7456e6a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997551
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3OSBTYWx0ZWRfX6hCXPhMPSCr1
 limEjY2uQthVyI+Kh4t9t8NZPWPMZT/7o6U0czhyflzAqVxAvIT4YikN/+8Puh4a1Kl1ZAsRFyK
 K2IbPD5F/wdh6NqfgAv2p8f8Fmi8+uUME9opr7/+XqC7L+THCGaxEZZaf2orhxVgeJql3wy4HZD
 mjGth6hKh/Fb4LHfr+htcqNturPEUD7/aErOHS9wBFdFW+SAhwwcWRN+F9jt/hBIFJFo+TfRAkW
 7K1uxOuVbxax7Ht0UaaK5wMIHqHhtEJ1AybLVWaBZj+eARu4ka1YH+tvDEiEy5JPILwh6KWR65k
 kb3cx0ZB2vQ5siuT/kDe/kyveNIWEiY1cVSCnJLtbpA27Zs5MtVUv8dOXtY/NpwgbKoZJyErxpi
 21smCMuGGWtqT4CZJXuzvWjIpbjT8+8icd10EKYN1irzesmV97wqrPK+TrsSEU0QsP8THPxc1Z/
 GufHxAutFNkulZvvo7g==
X-Proofpoint-GUID: puC5T7SnWpTk7fS23kM-P1zRvtQCvNBP
X-Proofpoint-ORIG-GUID: puC5T7SnWpTk7fS23kM-P1zRvtQCvNBP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3OSBTYWx0ZWRfX6+I+O7Y9wuhE
 jZYFfZsSZbwuz4sqFH7yOMb5TvxsQ3mtROm3QizlO7LC1Q4Cb10cgu7bT8F+V9bDjQceOvyruOA
 vcUV4eblTOfjqa/rtqmBYDSxs4DHD7k=
X-Authority-Analysis: v=2.4 cv=M5N97Sws c=1 sm=1 tr=0 ts=6a44c6cc cx=c_pps
 a=9V9/KAGQR/RGwytZTnC4xw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=WwlyPk4QlTwj7Wax3LsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010079
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

Enable OF_SYSTEM_SETUP for AM62D2 to ensure FDT fixups are applied to
the dtb before passing to kernel.

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 arch/arm/mach-k3/am62ax/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-k3/am62ax/Kconfig b/arch/arm/mach-k3/am62ax/Kconfig
index 6a3969343ec..e7c2a2de9be 100644
--- a/arch/arm/mach-k3/am62ax/Kconfig
+++ b/arch/arm/mach-k3/am62ax/Kconfig
@@ -54,6 +54,7 @@ config TARGET_AM62D2_A53_EVM
 	bool "TI K3 based AM62D2 EVM running on A53"
 	select ARM64
 	select BINMAN
+	select OF_SYSTEM_SETUP
 	imply BOARD
 	imply SPL_BOARD
 	imply TI_I2C_BOARD_DETECT
-- 
2.34.1


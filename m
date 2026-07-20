Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CC4C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4744848BA;
	Mon, 20 Jul 2026 10:02:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RCC+KPls";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TvTFn8eJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0385C8488B; Mon, 20 Jul 2026 10:02:07 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B71284974
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66K6U58D3774467;
 Mon, 20 Jul 2026 03:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=JjEjRCy5uJiHjZUkWnngmWUzT3wjEIxGu53OVPuNY
 /4=; b=RCC+KPls5UlTgq8WKmjE4nu/nQAbljC59CbaYk+IySK66R6rre3cp7zon
 x5GDqmhg/Vvkyk/ddjliHj5+R16DIlq+j0y75Vp+03c1Q//z8IoTKBOW+klT1rIR
 Si0uUg4pHFMBdXbCBgbuWhXN1vZUYyZTI/OJpFSDbw06gYQubE8Gkc/GWrhTWyGy
 HpaQ74fMXRdTocmtVAEIig176SQgzr6qvu8TnTXLc8yCNjfcP0EVgs8k4RoH6oi/
 g8hnyMdfumJAI+2sH0MWZsY7jB7b9zLegggyDcCFg4PI+G35IuFEDOrOOeGet7JL
 VG3+wpyjDMaO//uaY6LNP6kajvtTw==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fguemmgxm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 03:01:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeLn0NE0u6OMcHWcZAqlVk/S15Fs4O5JUH3qNadA69hyyLUGZjdSmRX3e2qoDew6rR9Zomo7BtR9n6PXdDEhpTpbo9vFHrY7LYT8HqyjEt26sO7UJcolB1YE09PhecYFGYR1TjdgFdXrttgpDc0PMeEOSZgNP4Hb7UX31Qxp8s5ZySbnfhdgjoP3+eUOYA6E+ND4SJeXgDJNO7nMYbKIUexJc3IthG+TxVM9daqb4+c8c3UZ3z9H7qlYqVcAP1Xq1CyfwjQOYz8xKwT/BBkkdHRn/bqUAScezXVQerRZWCt2Pt07oGjLMob62xAPkpMuRmcHiWCrt7aQgyR9ivGdLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjEjRCy5uJiHjZUkWnngmWUzT3wjEIxGu53OVPuNY/4=;
 b=EdG3LcSS6r1rlo0KkLZLyQVPQ6QxR76xsR724FpVyneziQrsmLfpOcSuVqaP7yEzJoCjcRwSY9xjNuDZHSDEMW4iHajuw6AA5l7NgB70WEzUx1gAmWoB8dIIdlWhEVBcMcMrDlD0SPiYJ5G7aEL1T3/Sn5SGEEyIH2swZ1FL9aw3K+avstylKw/xXHPmuUMuj5hAvvr8mImHfxcaEvSTzbbzvuVMAPidzQy1CIv0Qc896Xr38i1ajxqs3PRFqsSvcujTFJ7id6eF9xnpBeLTIIVXUCzQ4amGhARucoADh5Hxsm6Za5ZoB6/1KTqODO4/BjgtSkGr4pY3813yEtnykA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjEjRCy5uJiHjZUkWnngmWUzT3wjEIxGu53OVPuNY/4=;
 b=TvTFn8eJj6DnG2Vi6CBemPlMxo6E0icAGnpD31p+QIsldkGobYt3hHXXJv+Bkw1aj8MKVImkWf6vNCdUCS6JcujiQ5MY9ja0RwVF8tOHA/evbqdmBoGuUxer2wsmSiS92B5CVhfC2LKAQ5xRl+IbfBtIzTL9ABGC39hYRWlB8B8=
Received: from BN9PR03CA0238.namprd03.prod.outlook.com (2603:10b6:408:f8::33)
 by IA1PR10MB5922.namprd10.prod.outlook.com (2603:10b6:208:3d6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 08:01:52 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::3f) by BN9PR03CA0238.outlook.office365.com
 (2603:10b6:408:f8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Mon,
 20 Jul 2026 08:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Mon, 20 Jul 2026 08:01:51 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 03:01:38 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 03:01:38 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 20 Jul 2026 03:01:38 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 66K81FFq2478591; Mon, 20 Jul 2026 03:01:34 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v5 5/7] arm: dts: k3-{j721s2/j722s/j784s4}-r5.dtsi: Enable HSM
 core
Date: Mon, 20 Jul 2026 13:31:12 +0530
Message-ID: <20260720080114.775206-6-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720080114.775206-1-b-padhi@ti.com>
References: <20260720080114.775206-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|IA1PR10MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2a4a54-11c1-4f77-d6ea-08dee6352812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|10067099003|56012099006|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IUVMRcS4nnmtrPS7pMB+yRuP7UKeVwvhva/U5bKYORh4/xen80ZxOSk6Y51qbBkNjvyOhl2sCOpDNAvfSnEOYKby4LhqUmUsdRWZTKsgBwFKWPIANlnrIhcLfquacUVXZJBnk8vw9jgPDTPcrtzu0GG/l+k0lLC1qjK1oe+l4j1cpMU0RvxS77Dic4MOZ8BeCIMk0oZ1qAM6KEPCG3AB/vQmMcg0p7pyepYjEtDeposRe4QeLBF5dLsfHGgkdrf44dLFEJrw2rjEzhSbbiwO8sm7mfQo5/X/j4VBApAMMJYjTNE7gkfJBFb+bK+5Bo2ElVx6crRssAU28rb5D8sUej9kTYSFmrzu2GS4FVD2zvDreTOknLiGBipdU3zgVvUpP8lU0FOYJU/c1zPYWeAwnOpW1OdcrJpTm1Zbb9ypzbDDwi8zdOGDR5yNp4fsLjiStfGbVwdWShpgWEatsHoAZgX7gX+AWOaB5IUXcGpsZpn24TAD4q0hw9ntH1y80UQR+6Nn/E+dH13NSsH9Wnh8IAZW4Cipi9E5d6uBfhlC/ZLWwiuz/6bwoAIAMZA8qKcn7nIyyR428ouGs2/7s/wPtoW/XM0Ot4q47ebk/evn/9nztpnRxj8GrY/+LjScr/VaqNViW+S8l1AZJORhSvTOCLiMCa9idQCI2ZbNOhvttHtqVQK0mc2UkZTDiLa+brXNJJfykSTKdlgfrToigYSIfg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(10067099003)(56012099006)(13003099007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z3JxFH+v98vVJc9KgqNtvAOrVMBFXrBdDQx53OPbX+sFraWZGzIYpGRW8vxHBrdJuqCk++R1XNNFTgsi4qan+62j2lqBt4xaoG6KVE7deCMKL7qVVvNxhIWpsuy/XfAgr5+0jW4KHciHIJVACIs9DpuX9VED/X3chsm6QjLdvecG9pKKGoEp5p4xOkAnEjZ3T9bu0nGHNScUat7KUi4kd1x2uLgBtvGuyPVsiQ0L6Adu8kwGMhznU5BoqXk00K9pD2yVR+BG2sRSx7xvKFOxEV/MxZ1FpkHEkmxYB+NHNE7kyGb+JXJJu7b2Rx7cJLk86dZD39IA0nZ7l1loKKqEOrBlkzC45UEM7YaD20R9hcCr89JnWdcSn0aVtxvoadEP5Y/lzl4CHkpcloLb6tJcwB54Ui2HFDX4FXZU1f+nWr27f+fOPsArqyC8T3+t3S0B
X-Exchange-RoutingPolicyChecked: KeRUDJeZTOAqJrK8VflLTLOjWoG0WfUORkaOZKrhPDpLUnn02TtIlHcvnzxQrXbY3zSY8D8dP6AMh6vvSlWPu73Q3WIVNC2LENWQNz8HIuKt/64GQJt0TLpODvzinpGS83hHhBuV6U/RSG3AcJwXhAjX12bQIlxfBQXn3UxSKygJRTpusMV0jWoCXF7Z12FiczADvhBo3sz7TZk0Y19NgZuEGSJ/k9a+Jh8O3fdTlqRY0VF8wX8smfDBeakEyD20Kzwr7DrTEFqbeCCjK0ApxIiDP7I+WZFVcJa0epLFVitVdzK1Svkn1T9OOAonmYpmiaIDrxoGtxQsnUqeO1P7sQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:01:51.1938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2a4a54-11c1-4f77-d6ea-08dee6352812
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5922
X-Authority-Analysis: v=2.4 cv=N4QZ0W9B c=1 sm=1 tr=0 ts=6a5dd5f3 cx=c_pps
 a=gBbgJzl4OEn/1oy4V0Rvig==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=cm27Pg_UAAAA:8 a=rkogX2Xzrmj8k-iabVcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX1IkeKHDEdKH0
 QLHH6tezD5GY5DvPqRRLrDdU6uHY6UXjmbkFtrM/C6LwQGiCBVDXmP4bUbdA8rZD9IZQboP1pHn
 5+0oY7HFbDxrI2N3lMBv/u3iGlsPUXU=
X-Proofpoint-ORIG-GUID: 566s39-Sy8l8sHmrb0YnvdOcuwZQMTlV
X-Proofpoint-GUID: 566s39-Sy8l8sHmrb0YnvdOcuwZQMTlV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX0y/uFJ7upj6G
 8iV/RLF6mpuzr3GUnW5LI8Pa/BGUuGxjdGobS8HcRMfaarKkRaSZU78Xd/dUntExN4orl0uI8mO
 kZfOLeu0ILZRU4eReKJJIpO0Ey7IuVya64xVVMrrMNeED4EsdLZTD+xHb0ZhM7JvXxYSsUspfbC
 +aN0gHmwYWlCige2z0638kF6ovnrHSxc1YzTeS2Lk6zyTR2kvTcnstH6iQJ5xtmfQABHWYzO6GD
 wVhI7y5bjMcpu3Renfy1Yx0rMKzhTkUJOvSRYa7jKG0NOIts/dSnMNyUDBwn5xL61bAyx+ZRtz5
 EyHJI8hbJ59DfD70jghaMzc8jkCJEG33f4uQSPAxzqQW3OChs+gTxqI06XQp0FxvEftDCAB+hGr
 uWTjRe4eAaOhettDhCaqLgGzikILUeVtVSKy5IUuTAsKoO66xYUUvbYYp4pdZXnOjvi1mqWohrl
 1PJ0S6uLxsy8YFAAFoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200088
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

The HSM M4F node is disabled by default in the device tree. Enable the
node here as we have to load and boot the core in R5 SPL stage. Assign
the alias of 'remoteproc2' to the hsm node. This assigns the sequence
number '2' to HSM core which can be used during rproc_load() and
rproc_start() calls.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v5: Changelog:
1. Add a comment calling out the usage of alias indexes in code.
2. Add R/B tags.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-10-b-padhi@ti.com/

v4: Changelog:
1. Changed node labels from 'hsm_m4fss' to 'hsm' to match with device
   tree definition.

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-9-b-padhi@ti.com/

v3: Changelog:
1. New patch. Enable HSM nodes from DT.

 arch/arm/dts/k3-j721s2-r5.dtsi | 10 ++++++++++
 arch/arm/dts/k3-j722s-r5.dtsi  | 10 ++++++++++
 arch/arm/dts/k3-j784s4-r5.dtsi |  9 +++++++++
 3 files changed, 29 insertions(+)

diff --git a/arch/arm/dts/k3-j721s2-r5.dtsi b/arch/arm/dts/k3-j721s2-r5.dtsi
index 7d4a6dc5301..abe64f2364e 100644
--- a/arch/arm/dts/k3-j721s2-r5.dtsi
+++ b/arch/arm/dts/k3-j721s2-r5.dtsi
@@ -8,9 +8,15 @@
 		tick-timer = &mcu_timer0;
 	};
 
+	/*
+	 * The remoteproc sequence numbers defined here are used as literal indices
+	 * in arch/arm/mach-k3/r5/common.c (e.g., rproc_load(1, ...), rproc_load(2, ...)).
+	 * Adding, removing, or reordering these aliases will break the code.
+	 */
 	aliases {
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a72_0;
+		remoteproc2 = &hsm;
 	};
 
 	a72_0: a72@0 {
@@ -102,3 +108,7 @@
 	ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x00068400>,
 			 <0x0 0x50000000 0x0 0x50000000 0x0 0x08000000>;
 };
+
+&hsm {
+	status = "okay";
+};
diff --git a/arch/arm/dts/k3-j722s-r5.dtsi b/arch/arm/dts/k3-j722s-r5.dtsi
index 06a63fb83ba..9ddb951e078 100644
--- a/arch/arm/dts/k3-j722s-r5.dtsi
+++ b/arch/arm/dts/k3-j722s-r5.dtsi
@@ -4,9 +4,15 @@
  */
 
 / {
+	/*
+	 * The remoteproc sequence numbers defined here are used as literal indices
+	 * in arch/arm/mach-k3/r5/common.c (e.g., rproc_load(1, ...), rproc_load(2, ...)).
+	 * Adding, removing, or reordering these aliases will break the code.
+	 */
 	aliases {
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a53_0;
+		remoteproc2 = &hsm;
 		serial0 = &wkup_uart0;
 		serial2 = &main_uart0;
 	};
@@ -82,3 +88,7 @@
 	reg = <0x00 0x0fc40000 0x00 0x100>,
 	      <0x00 0x60000000 0x00 0x08000000>;
 };
+
+&hsm {
+	status = "okay";
+};
diff --git a/arch/arm/dts/k3-j784s4-r5.dtsi b/arch/arm/dts/k3-j784s4-r5.dtsi
index 78444dc4e14..afbb8faca44 100644
--- a/arch/arm/dts/k3-j784s4-r5.dtsi
+++ b/arch/arm/dts/k3-j784s4-r5.dtsi
@@ -8,9 +8,15 @@
 		tick-timer = &mcu_timer0;
 	};
 
+	/*
+	 * The remoteproc sequence numbers defined here are used as literal indices
+	 * in arch/arm/mach-k3/r5/common.c (e.g., rproc_load(1, ...), rproc_load(2, ...)).
+	 * Adding, removing, or reordering these aliases will break the code.
+	 */
 	aliases {
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a72_0;
+		remoteproc2 = &hsm;
 	};
 
 	a72_0: a72@0 {
@@ -113,3 +119,6 @@
 	vdd-supply-2 = <&tps62873a>;
 };
 
+&hsm {
+	status = "okay";
+};
-- 
2.34.1


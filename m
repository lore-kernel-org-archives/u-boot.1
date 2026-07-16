Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2560C4450A
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 08:06:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CF2284D87;
	Thu, 16 Jul 2026 10:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ld1lQwp0";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="B5cJd8/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B21B84D8D; Thu, 16 Jul 2026 10:06:18 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94D2A84D77
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 10:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66G7Fqb11639604;
 Thu, 16 Jul 2026 03:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=nT8LEhaL1/6xYa+LHK7kf5J+gWSg6tId3vk8h2415
 nc=; b=Ld1lQwp09LeMqiBgIwcDRTAtFLNgoa5WcDe0o0q9Vno0xJomcqYV2Awea
 MlWuAcTNV/yuPIz2VYuA9U9KjZci1nV687srcaO5xtfKFwWD75D2EL187Ju2in1L
 NIdtCvlEVJpO4+vNwcwy5qZaDFBBSD785rSl9wc0/JR74XcCE4XyfH751ZPAX4q6
 CnVxS1L3w9GxyrLWpWWd8+5JjP+FitWgnin+E8UYq67/BL/DiPow5Dgej3csb+md
 /00stiwrHXasWD7QLOwjTHG/qqP7F5gkqTPwRUe7hw+06a9GWETsXTUUNpGWKigG
 2u2PsS+yynawgBM5o+uChXBvHybeg==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013069.outbound.protection.outlook.com
 [40.93.201.69])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fep5s9n94-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 03:06:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaJpPfQLdFsKprhqf9hGr0fnFzJCBoCIenXd9qSxvtWlEKmCtlW95RniLO0NZAjnlknUKrPJDAZZn3Mt/UXCtweoPutdp4uZwLf8OhFes+Ak6A4e5hxDBBZWf2XD0zDs6Ep1Lcvv7Akwx6DamG20AQJsLIrgMOIQVAySAtfaYugVLnkDwO54RlnuDwJfpXfaepjj/USFoLTW4FLOMKA7dTegavzPZwhJ2Io33Ctg0TAkEOjMQnzdsyCT2JeeMUXYV2TVeim9mgDj3iMfYEl9XJeDXpO4Q0rZ42JLiQiBf1kaEo9bDf1/kWIEEr8pwLmsLZPePxxcixQ+oiD60aUDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nT8LEhaL1/6xYa+LHK7kf5J+gWSg6tId3vk8h2415nc=;
 b=KYy8bVmfMI+4flJ0qxq5cyeL2SjjYPE6oPnSk5neCvB99/i+fyA2SFDYAm7l0FLQrgjUt6rAhK6Ywl6NjmCn8fpMQR/YEvnIYOZMNaHOhq6RM1cqGZ0ybV+da1XDgHXB4UKkEB/7LmWKNwzCHutFFSa02K8JxqIcYdJrIe/SnWzfJs5zIN51gN8lz0HBnqZQKtFBHMDabc4H9o6fWJ6mLrM2r/lWw04HoBhxoFKq1tYe2/OmyGAldEhAIoJ30uitS9a4hGpjHXOpq5Lz8Twf/ixLaR6BeDMTUTSJo7XjPhI8ewQ8JS7DR5X2orghT/CGRDfcYvnYA4YushRAAwVVCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nT8LEhaL1/6xYa+LHK7kf5J+gWSg6tId3vk8h2415nc=;
 b=B5cJd8/Des7PQ0FnROn/kxRd7u9kCQOG+OVGNwFNkX5Jdc4GWCIAzqEO8aBGNczZK4fJasYGz4vFZFvwdMgTgs6e1p0Ysybn4kWc2nQSZDscM36SabXu+pWnQU5+kCi1HiXJGcKIQs1Nu68B8vH2jiC6mBmDrq5b2P1HPPvncQ0=
Received: from BN0PR04CA0056.namprd04.prod.outlook.com (2603:10b6:408:e8::31)
 by DM3PPFEACE3F2B7.namprd10.prod.outlook.com (2603:10b6:f:fc00::c54)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 08:06:08 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:e8:cafe::4f) by BN0PR04CA0056.outlook.office365.com
 (2603:10b6:408:e8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 08:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Thu, 16 Jul 2026 08:06:06 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 03:05:58 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 03:05:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 16 Jul 2026 03:05:57 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66G85vIf278544;
 Thu, 16 Jul 2026 03:05:57 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, "Wadim
 Egorov" <w.egorov@phytec.de>, Chintan Vankar <c-vankar@ti.com>, Bryan
 Brattlof <bb@ti.com>, Anshul Dalal <anshuld@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v3 1/4] configs: am62ax_evm_r5_ethboot: Enable config options
 required for Ethernet boot
Date: Thu, 16 Jul 2026 13:35:50 +0530
Message-ID: <20260716080553.2664147-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716080553.2664147-1-c-vankar@ti.com>
References: <20260716080553.2664147-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DM3PPFEACE3F2B7:EE_
X-MS-Office365-Filtering-Correlation-Id: 9233f932-c0cb-49f1-ec2b-08dee31116a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|13003099007|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wARwVQsSgQvtRulUsRaEMZ5inkxMZ1KLSdK9gM1QagMZNEG3d1hxgEP6r+CbcogX4Yl3Iyea2J6ACytrt9F+uKmqpTmJsvLgn7Vh3UdXxxF54NgzjuovAADQLPCcHezG8wsdQo4qys1tCi1wjph/f0M6NbDesxjOwxN8XfESZdB1gvCNbMFM6ZB0Arz4oeL+crqDp3IQga68jqpWBH5/X0xdqtlU0xFLS8fdS1otJ9101gNxyhpgikIhC81AdpUMK1+s7DIsDktpe1sAmzpML9MensV1CbOABqMjVEY3ioB4c+zIGoLhUkgqi5r8YByTP79dWzULfQ3v8mmhqhTwvYX9un5v7SKnXPkBQiAtD4PDJthi5Uj+sxFw7Qiix/cgr17G3EaQ7uz/QOOqbumC75h1Y6ris8EWK3dFpfUy6K4Yl+Lxn+ffsl1IFdwL4QjOvPCfwwWV2sxLNsI0YtQxZcURETDMkYrfhP8PKcWO+LxrfsYIFu+ipdy4PbGk0PgavEuCvUVXgxC/FIAKjLzHSUTixoeFFApBKdCDy4dnan5RC/98EkcIjjtSRtaW5U7b2NGCJWcAxdP+jpXZOuOfJ0DoPHVtmZ3dBuRZgmjRxOyhAPtx22r5Rqh0wqqnnc9TPkgVkVBKYJdzXlTlBuHI97xernUsI8bg8UawHTfJGesr67gWHEBRnSMfDdlMko4t/7RtCgkhC4/t5bBIBYXgiQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(13003099007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VASfNATf2si+lKre6YFEc1zYiTrb4H+q/acI68NzqvIX+tgbhast1fdtZ2xEpp+n5b6yQ4Yay0cC1EWTtWw0xCU1FHeIqY0EzGDvZWtN4vZLyPYYsQMGQkkwMWorgNH7pDv+bCjhY/wiCM4V4YV33oK7TpLwJCsm4krwT7wVkyHYJXdCeuuy3st2VcODTOmcAsvb9GxoWLAPHjSEQOiic+gmGIUI6C0QJSpUvkHOYcXKEQfpSMnGccoM6N1vgDkEkBwBEnzXiEClm0ZWLn8mJRQ+KIHZws5OgzBoevWxYXv1lKtUKbg6DJawZX50jGL1jaIGhows2+AaUIJD6KN2DhFHi54cAJamxnsqw/g/tI5BWmNy2lfUb7cSn6KY7nn+LfJvOLwp+Z+CVE5Fd6SNNyNbPPaUqEU6CyVoX4zLbIsQDNmZhB9AzDiiyKFfTCkb
X-Exchange-RoutingPolicyChecked: eQuiy8xJhVw2TnIYlgC/iLDybeXTegzKh3Rcj/8fkOGsSo/eAE93DPWRQ1niNWbRNPrx8SwPm+iTT30llWbXpftMfkMXRK7stJayPfcHzYvjg/fmPn1uKU5qs/E7Gbp2OZA7Lw7TGzgrU2mmk0K6T/E9HjQgVQQD8zYmeZBT3bbu8+x5oaPgTiuzmgnor0GN6zQMsWn03dvW3nD25Lq/2TISMkaJ5SsD0wicRmn/hS8zVtWvet3/+Up13QV1ewZkGcWJexrX/ZwgAKRc9dnql68N9jdeaX5/41+I3w8foS26v0RLBUwIv/C4QB1BHgwfzRIEhmyA11a1f8Lq2frCVw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 08:06:06.5950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9233f932-c0cb-49f1-ec2b-08dee31116a5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEACE3F2B7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA4MSBTYWx0ZWRfX0IPjEV9S1gPC
 uBiMm/xyhvPGxImmyg3sQ5Mg0qMM74zds0X7vZwRhl1xw5Wcq2nHtb4xoIFFz0BRuGNB9uoOQST
 V0aqzmEfEcqHq/zvD+ovfgGmBIr3cm8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA4MSBTYWx0ZWRfXzmqia+lEwEN9
 bsOpx7L5h0sfiG7vcKimVrWPuwoCmSbuLlBDAtBtHmvpqimPPlO+ogWqqJex0bEVD70JaGei0Ww
 QX38IDXY/BHC65FrVoZy/NeQjzYjaA7b7qt6DukIw71x7Fxobq7LW2c22ct/smty4SYkAqyJZ2G
 x3xdD+6iv144WuZYkfTOsk6gWe/vJwAjYZfYDUwyK+kKKE23FUzvDxDM1CSw1tsII5HrP2222ws
 mPHIKlFP8/IpEkrtZPB50vqPAZy7OfXclSxDNdsJWqOkycy9ZLypj8XJxe3ekxejEC81GKMvTgt
 DKtiewHoZaZIuFiyl26KhF7Jl2D1SkDOFg6PqvVEtJpH4WZofhtMUIt1d4SiFno0Ot+Ghkr03t0
 k5iHF6Wufqs25Ae6iVyDKrf9ktikaZ4BCTOPPfBIt8+K8fJO7B9JvyC4INOdSfPqtcA4ormImWu
 FHrA7MTIavC+pI0RCsA==
X-Authority-Analysis: v=2.4 cv=Zrjd7d7G c=1 sm=1 tr=0 ts=6a5890f3 cx=c_pps
 a=/NeaHkXls/iJsjBnUIdqww==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=8v0gEZN7y-sznNg4SSsA:9
X-Proofpoint-GUID: gBT5YCmreoozPib56vjOaKDY8WPpmHzq
X-Proofpoint-ORIG-GUID: gBT5YCmreoozPib56vjOaKDY8WPpmHzq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160081
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

The R5 SPL SRAM size is limited and cannot accommodate both MMC boot and
Ethernet boot config options simultaneously. Add a dedicated defconfig
that enables the Ethernet boot on SK-AM62A-LP for R5 SPL stage.

Reviewed-by: Anshul Dalal <anshuld@ti.com>
Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v2:
https://lore.kernel.org/all/20260710102229.2980029-2-c-vankar@ti.com/

Changes from v2 to v3:
-> Removed duplicate config option from r5 defconfig file.
-> Added "Reviewed-by" and "Tested-by" tags from Anshul Dalal.

 configs/am62ax_evm_r5_ethboot_defconfig | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 configs/am62ax_evm_r5_ethboot_defconfig

diff --git a/configs/am62ax_evm_r5_ethboot_defconfig b/configs/am62ax_evm_r5_ethboot_defconfig
new file mode 100644
index 00000000000..8763f32c0dc
--- /dev/null
+++ b/configs/am62ax_evm_r5_ethboot_defconfig
@@ -0,0 +1,21 @@
+#include <configs/am62ax_evm_r5_defconfig>
+
+# CONFIG_NO_NET is not set
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_MMC=n
+CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_ETH=y
+CONFIG_SPL_I2C=y
+CONFIG_NET=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="AM62AX U-Boot R5 SPL"
+CONFIG_CMD_DHCP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_DMA_CHANNELS=y
+CONFIG_TI_K3_NAVSS_UDMA=y
+CONFIG_DM_I2C=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_TI_AM65_CPSW_NUSS=y
-- 
2.34.1


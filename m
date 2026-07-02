Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925B9C43327
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61EC584CB6;
	Thu,  2 Jul 2026 10:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qHQI9+s/";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ein/NtKY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6914B84CB6; Thu,  2 Jul 2026 10:13:09 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E718584C85
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6626bvsA1050905;
 Thu, 2 Jul 2026 03:13:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=vPJMKxA4Q6wj0WhOtuBTTI7oKBUqf9EMrht5j/ZdM
 b8=; b=qHQI9+s//WOGT9gw1IN9HqUVO7J/kbr5ETvX9V58JMEdM8pFPCqKdU45T
 1SSJkFpNcp71YmDQ5njOfdSSGuvla2jfKUNj8/Y+mcl5zEipFeeO1zgMbcuUV+sF
 eFpREMmGKj2cpL8nnup5G3y7TFlEKvgPPox6zOBNM+B1y5/ni9RPnADNntkqfjjR
 xi34yG5GUI0oUVsFap+mtw1bp7S3Osq+urE6pFXt3B56lQvYfpBClnslDlmJt1vF
 J68qN6PtzETGgswjMVdNzFmwSxNew+/GCAmhFjLD09MKkyEZrGLO3ptr/QUwSdhE
 nt3jqvIPdYPja7GvuL9de7d04lbeg==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013055.outbound.protection.outlook.com
 [40.93.201.55])
 by m0380145.ppops.net (PPS) with ESMTPS id 4f52486sfr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 03:13:01 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWDYazf1G/MX33Jwlc0/32ee3aXCA5reyfCerdWMdWnhY96aDfQoqaRBMOEFDZNI4MAgcLmO99l0PH/Pc6Ym+Qfkvm38A3+ZKfGrVnFfyMGjWW81+34PAG2bi8+JnqTD8sfXUQc3SuNqWiTnfHjXcWSGAdLd+tNNSEsssytcf7NT/cHZZUzDAUIcR46tiezYRgkg8Zx+fED+YIz45oqVq31s3nrtPb19oq+N6aG0zXt0YLE9gHslCKfV78LQ3x//5fZEHHkCPwWh4zFDq6CWbm43IEq8eClutgoqV1176/t9UoIJFInu10NSs9astC3WEXM8GA8Llk88iUP5P995Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPJMKxA4Q6wj0WhOtuBTTI7oKBUqf9EMrht5j/ZdMb8=;
 b=aY+rLh8lZpa7N/MvhZ8qflHAA0Yw9mLaa+OnRkEpj5sUBxt+9V8AHGl9Jj8CJDcEo1K02so+eix7m0ankVTrNAdwkWPFlalVdcOtzvy6XEugM6jaiFdp+/KYpyQGhW3Pt0iaM8kAlY5CM+INRM5n47G+86jCxUD9Ns4fpVIcIPHda/+q0hzluK2dl3PqRJPAdU4vGu6u1xr3lK2D4uYHo8ms3S/P/ayNItGxVBPb4j0svlE7VB8Ds+i9bDNjdV+7ZFkfvybF+WQILS12bAxeO8P/dyxj+JQx47HBNsy41bE0TIHBP4zw2emoCptTCo4rK7vkj0mvqmSrXswLhlEoqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPJMKxA4Q6wj0WhOtuBTTI7oKBUqf9EMrht5j/ZdMb8=;
 b=Ein/NtKYaGeura+uUvgQ/tPesHpSR1/MdS/cM/DprCWRn4SFtUEDEhlmw0SJ/1Bu1aCH67BEhK5RuQXEjL4Qr7pTctj6+BBUeQKzh+1CFOZ73ZNBQeWbtd4zVjMvyXbweSb/+63zIUwMUuNnsWb1D+cjVp8ccVb6vgvpxM0zoBM=
Received: from BLAPR03CA0001.namprd03.prod.outlook.com (2603:10b6:208:32b::6)
 by LV0PR10MB997660.namprd10.prod.outlook.com (2603:10b6:408:33c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 2 Jul
 2026 08:12:59 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:32b:cafe::24) by BLAPR03CA0001.outlook.office365.com
 (2603:10b6:208:32b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Thu, 2
 Jul 2026 08:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 08:12:59 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 2 Jul
 2026 03:12:58 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 2 Jul
 2026 03:12:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 2 Jul 2026 03:12:58 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6628CvKN2889430;
 Thu, 2 Jul 2026 03:12:58 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Chintan Vankar <c-vankar@ti.com>, Anshul Dalal
 <anshuld@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 2/3] configs: am62ax_evm_a53_ethboot: Enable config options
 required to enable Ethernet boot
Date: Thu, 2 Jul 2026 13:42:50 +0530
Message-ID: <20260702081251.2691159-3-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702081251.2691159-1-c-vankar@ti.com>
References: <20260702081251.2691159-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|LV0PR10MB997660:EE_
X-MS-Office365-Filtering-Correlation-Id: 4673f880-31de-4dd6-4c96-08ded811bae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pzdVCMJfl0Yba2WQt8ijVoCThVj5WQFdg556liYtsylDN3R3iwDv0x8UYbZD+krfSib+9lPWic9dM73RgzFvVYkZnc3jHJxCcGuxVGA/cIlCW8hvu9y6EtLBjro5aScOpf3cYal7polCNMeDOjAwEdUxwztvzjKpH2MTQrvmrXag7WcX7raPlk/uOkqtiIcjxHq9ADoATttzkWye6fBF+MxX3ElvGo9lfBElwT0yM4SgGmECEGR7eL+HhMjbPgWPVsuomm8o6rVD9i7jkeo58Z93Euw6sTZDlYUKiN2pun4c8gENfSSzvUbcglDUHTfPlu2XKWZl1i12GdVw0KyakUzzMmRTthBOfAg2xPSnE1AuRtQZtwKyki1Hls4BiE+rJ+imJQO9FLvrC/Y07st1eaIHpH6/jit92tYzj5+nijjcwGreYQgf84QymmG9z35ao9uZtI03nQjslb8c2AnnGCa6T+Pw0Olox3ET9WvjTx21AhyfO+KClAcjzqXem/Q5CMn0E7TDpIRpn5l8akG6hlZ4MoV7hTNYzZSPCYgcVx0/G01wHjUJq0YS7NnF2MKxdX+CiMN9/HflmA5HeqPncF96/G5GG37cX9mkTfgGkAmDJB/bqpDlzuQ6peYD754uj3XTzRU7L0Zr0e7xm6uh9OhhBw/jNsng/AngWqyj5Qc1Ago2rBINu88T52PiWsHVGytembBVp2/hY0YsKZPHeA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QjSTTg+UMlBehggVxWEV94ndHhWLQtAmiB3QK7Ze2RiuDi8nlZ5g0KZoBa0pDhHwtoawolJ86vVr+LPplSfxJKRcUqdA7w2w9djCGEzianS9niXn8P/qhXednPQiE6+6WqIFEW4SCATPyKxf1wdk53H/Y3Huwvpdj9RfKkbxiAuicjC6zLpHzhknLlji23h0TiG4fS/r7WDc4xDdo5+hpUa3sLzYpHALWRO8nK2EXOi1ggakzYzF8HxzCeyMDYsUWu0xWCU7xCOgOvTkLNx9yugQbBqgTn5MChS1tcm7mZzyEkYcaUiAksM2BUze4P0YQgBBunYFSod/0i1PCBlfZNj8U770yXHQk7lyIDunanrbmwcDGt5gkNsNA58zlBZlNW8vxqlUIWZrysps9gwyIo0sDcwr8PTnVQrjyw1KrwlI93iDBMYo/j827a+gjluG
X-Exchange-RoutingPolicyChecked: cVl6Xf5Lruf0yjNZbVyZ53fGk1lNxOruZa2gKGiV82XIXikd1sK+q14vqSgQT1otGI1hu8++929XyOzHTXQB5uMbqxmygZfvFC6nYvPkaru/bgtkc80YZ35onLAbbD4C+/ib04pOH/Hzyb3DiGPyzg3vR+giPoSoG8vixy+YGExfHQNVtGnIp1um/ghdRlxMk7ykkK8P7M1+RngksPXZwkafcwJbUG+1Ht7WhXKSyHvwdPoxYJCw+8Krz/8ySlLckwdEz2TyxMyUnCxXBU2NbbcgDxqsVcbL2MXwQajEfPphsGGZeBD1UA0l5csjl6Ew2/PxxHKAa2cPv4AJSFiwIQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 08:12:59.3665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4673f880-31de-4dd6-4c96-08ded811bae6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997660
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA4MyBTYWx0ZWRfX+NPGx/emJilg
 THZe5WilePe/4gvDEx1h61VoooTVd7QO0WO6QSUVjYJ+eZV+k5WxU4Y91dve1IT8np5ouCpSI/o
 NuY4+6cDB7ZQOxzGw26Rq2JmbsG33H3IrXg2AKaehywHxkVzBDKrdPFvFQg92L+7WOg0qIBQxEV
 7GRzG/MMEj4aNtgEeWyFiBTuJC4KWK9S98g9u6sfRgq3altZQY5MEPNq+00bbiI9EJRErNgjXIA
 Hit/0tahiInKWx5hWyWB2B4Py8s3YHLn5/xS4WYe7vLGCCCed8m9U0Wa90zUUupZHTpVO8KPMyF
 JUKeK98QONvJbhzKRSvos2hMgC26MATNATpKfMl+YQWQxjakONe126gZwPdEnzErnzht2YYpuKE
 0fOowWABz+UDKWxz3PUWRZA2nlpW/BLAun05rdo+IG7IPjMbVo7BHnlhQu9h3GMEtlHa5G9MP+G
 D5kJsRB3wYm5CekMNkw==
X-Proofpoint-GUID: lj5-cMlPWNnD6lmQDvppxjvmKPEz4g4Y
X-Proofpoint-ORIG-GUID: lj5-cMlPWNnD6lmQDvppxjvmKPEz4g4Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA4MyBTYWx0ZWRfX7efZFfZ7D2P5
 j7lkJAiZ0jkZKtDmlYh8M3Vp5YLorBYzWj85ta1a/db22Gq9bhqilaAmb6tWodXjrRUpi1dFyzl
 Atg9CbESiHPq1AMETaEUYA9UhuBDyJU=
X-Authority-Analysis: v=2.4 cv=EsTiaycA c=1 sm=1 tr=0 ts=6a461d8d cx=c_pps
 a=lT9N4OFqmOca6tf2P0aJdw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=QJ4Adldd-S0oywNWO8AA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020083
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

Enable config options required to enable Ethernet boot on SK-AM62A-LP.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 configs/am62ax_evm_a53_ethboot_defconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 configs/am62ax_evm_a53_ethboot_defconfig

diff --git a/configs/am62ax_evm_a53_ethboot_defconfig b/configs/am62ax_evm_a53_ethboot_defconfig
new file mode 100644
index 00000000000..a64542315fe
--- /dev/null
+++ b/configs/am62ax_evm_a53_ethboot_defconfig
@@ -0,0 +1,16 @@
+#include <configs/am62ax_evm_a53_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_AM62A7=y
+CONFIG_TARGET_AM62A7_A53_EVM=y
+CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62a7-sk"
+CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_ETH=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="AM62AX U-Boot A53 SPL"
+CONFIG_SPL_SYSCON=y
-- 
2.34.1


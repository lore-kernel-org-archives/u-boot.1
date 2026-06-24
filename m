Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44416CDE000
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 21:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E963849F3;
	Wed, 24 Jun 2026 23:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PHb40MtT";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="N5YhFz0g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB31A8460E; Wed, 24 Jun 2026 23:20:12 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ACA6847C3
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 23:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65OJshVI1056749;
 Wed, 24 Jun 2026 16:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=P6EmrwJ9cjzfa4Kp7NocaJZ+MSnxt0FE6mN18A0eS
 dA=; b=PHb40MtTEEWoiA++3ORR6AI6ZpgOfyRccPOqcOJ1txx7/6bGHnUk+iZME
 oavnIXPwAQwNrkFcat27SfmPvicrJlg6VXrfR+dQyMlyPGljbdPzfZ/MU0KTLDRK
 Z6XiwtC6MeFmJQGMv1CiLq5lUVdtFeP/68Z68joCwctxm1mHtUi1QP9+c2lqiB5I
 24/KkfDAaXyykP0ZBRO7km8YzM1DvS/fLil1wM2J+CciKwM06h0Tuj1GB62aTk7H
 8X+/+HUHTuQGaBZ/UAYA/fJsgGaK7J1ur85TCucExbB7zI257RKyHTGh860PCDSx
 XUZN5Li065DUuaSEVQ41A37O2g6TA==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013057.outbound.protection.outlook.com
 [40.93.196.57])
 by m0380145.ppops.net (PPS) with ESMTPS id 4f0e5ybu64-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 16:20:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZERJDT8agP+RsRX/xaOPQcrtqwgPz6m+prSymlpRgOqx5w+sOaj+N2y/DRGP/IeDv/MZ+KNIu7Bd52ECzgpm/eB9SqOu4+7TzNoclB8HSudeUBLKpf/Ta7pSwztYVg9kk+poXMGz5CV8r63dQvxApxkwfj4EJPE6Zc/NUk973zw1JqL2zZajqwRw0SN5qlkwZtZdb8TYZu9kHv+rTQKtDRgvwn7tU/IuZqhQ1HTnxSPzUdDcEJ7hYWqg9MSPbtuT6GeYP48HuR+TegxHWG+88RfhSOG3+ik02i0WJoY+QZfs9Keq14eINIXzHLJiqK5Ud9mhN7EruyZQ8R0jo+05tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6EmrwJ9cjzfa4Kp7NocaJZ+MSnxt0FE6mN18A0eSdA=;
 b=NCjn6/9ayyl4qgS+g7sr//knTTvTPJ/PESqoyoAHdihoxDUEeH6XFKM/tUq+vlDFIpuFaTL6AlscndrPQFOxI1z5WVXA01BPni0vX2LN13j038o1W1Ap64UzNVD5FFoe6cvsEN6iOhAOa/U6jXJwXNLo5CIHTcdcbz2imV1lPIyhs/mMSyQL1wfjwdhPmNzITZmPTKzEe2krLAlgvAl+7N8QarrURXm6MGryeTIjphT6VxDc0g7OHM7tjAlaNdHpCQtZzMpF96LQTqU3KJ5EbjuCZkoPlu6Bdh/XO+o0ayE9rNTY7NIlQvKhq3LtlyIXToy2jPIBNHVsfAxqmPL9Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6EmrwJ9cjzfa4Kp7NocaJZ+MSnxt0FE6mN18A0eSdA=;
 b=N5YhFz0gRmIIHUfbrLmw2aNgB1xvh69tsq8OSVeN/Q0h5B0rJz8haYNQuYWnKxptDHUo9u5gqyH4Izf7oVI2dZi4g5Aj7cx60r1rfVRnhYxAdj+M6VviqKmE0QJjFhJtNSLDAN3oYWDg3GboMxBAEyYZ955UKtbKOjCA6B1bRH0=
Received: from MN2PR03CA0002.namprd03.prod.outlook.com (2603:10b6:208:23a::7)
 by CH3PR10MB7611.namprd10.prod.outlook.com (2603:10b6:610:176::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 21:19:53 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::82) by MN2PR03CA0002.outlook.office365.com
 (2603:10b6:208:23a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Wed,
 24 Jun 2026 21:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 21:19:53 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 16:19:52 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 16:19:51 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 24 Jun 2026 16:19:51 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65OLJprG1851589;
 Wed, 24 Jun 2026 16:19:51 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv3 4/4] k3-am62-pocketbeagle2: add support for efi capsules
Date: Wed, 24 Jun 2026 16:19:49 -0500
Message-ID: <20260624211949.327905-5-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624211949.327905-1-rs@ti.com>
References: <20260624211949.327905-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|CH3PR10MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d4b56c5-3eb0-443e-1e39-08ded2365520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|921020|6133799003|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 1SNbBYtaA1Qa/SqWvtqv+HbP0gF21fWGSAu1WjLavchS7T3ebMVf6SPVafin2ZRVEfToqOmqd2muyYRsbYBHibXlqMj5/ysrHyDnfca1w9pHU11KHj01gTlSltr9Gr/xIN44NME8O5jeoOra5W3V0z2fNioZoU4kg9YRrpjZm5YtZxj8pvcTzwhkUtoMC2ttc7wFEsmWd9x2TFBnFQnPE8KI4mb110PKTYOlrTFy3TZTr++pEnJcDazIrJbezzu1lQ+7FbD2ss+aNXoNx5njSFZoED08VC2VvD+aczMimyFzQAsxHZMIjMeaertVZ13Ox9HJJ9ENnfPX99/B1v1lo6cx5fJNuIsqLFduP6t/98HgQSfQDZql/exvVqnB2A0Vtnar59IhH8cfPUvzQjXuGb+hosml1yjwihvKxVK7ncWtZ/VEqwwWgsLXCXtFAV1rgF4U/KE+cEUq1fyQr1dwtBpR4XLixb8hR+9z5qX1onRUEi8TMk2NUPN1/oPVvPfvY9ju2+c4lhVAl8lkaXe90mr272njuquCc6Y0r7sDef5rgzwk6OqPgd6VGn0SE4WT8QYRq6xoxG+APOKKp2zmZVGV7TfoTYtmkQOx8odyGhTsJoLONV8XTrENhDhdyB7/ox9d4B061bKLafmcsljeNKE9xteKU8DJVVsW+qIMFTTN+Gej3ivs+TRDjEl9s/yvLYq9uyI2JecEfcJVnlTsGw+UUK4mLIIuRhindecbtUpYzaydrZyH8YoJGiFuo3rk
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(921020)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3/ICu8XuKB1fcXmhu0fRT7jBZ+EW+RajgJaT0PC5SBOjtB228fqNaGc8RuQ+8Y5k4qQwSSzmU7Bn3NDS0t06StW+Bvep1pstEB2OEWgTRVQknaYgUcqCZtC1yweSAXHuwwx629PHE2klwQLUHCII38DTmYKb+aGWiJKyTVnOFdyPn9kI9Lsk2fwwd9uoD2WmKHtBxvbOzbHeSPdKHh5Z4dT1hjN6VD7TUSmRJpACwKcR8zuk5p/eSONmpvuPhUGwHAAf2iEBCi/1+xgO4XNjYSwfAD8ocw9lUAOH4/svniAZrUwyyhK3xTAufFsnrUpFyHcsgMPUgcTNv27aFoFD4rq2MT93YL9Mfpv8sWXvfAHFIlHrw7O224Uli0UAUr1iI21SSEGTm6rq7ftqDdrmYVU7l0t65NbHy63Iru5ZQJj7rA7hUtTqJuLGw9yUPdyj
X-Exchange-RoutingPolicyChecked: XPJjzIdDtGKo9jLYCMEbBDf6y1QaJpdCK95bEI00n88a6dz++mU+WsborUmkqHl2tQMg/DIn6hbtr/S15MfhrtA0asxfyTtTyUlNrdV6d3eZKlLHXBMozOZhzCptZ6SeMn57PAaP3FCz2qfiicxWaQW/advTMIdzAeFBVd1FzKkwE5VeahQ15G+WVJFY6aWCECnICQTkKTphsMipUgtFu6wzPFiuamwpVvnCukAYisD8NnXR97cm1C6sBr++ph506NQ6esCKIdtVdvTeOa0/Ylz79qlN7o6jAUW7laGzmfMBOWtM74oyimsXq2KNA/nTNReg9avSdBZjLEWbc2BHLg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 21:19:53.0239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4b56c5-3eb0-443e-1e39-08ded2365520
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7611
X-Authority-Analysis: v=2.4 cv=R6cz39RX c=1 sm=1 tr=0 ts=6a3c4a00 cx=c_pps
 a=u5eD0AXnJOl2BG6obV1kTA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=fGhLjsSNAAAA:8
 a=zziTSyxZXs25WCk4eZ0A:9 a=LYKFdyShAPKLkGq8p7WX:22
X-Proofpoint-ORIG-GUID: OwPHliHPAsDWHx4DC8GNcNKkiK23UN9V
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE3OCBTYWx0ZWRfX0WV992Dl5J0a
 WZzvPE5lWIVyvATgz0792mCA26e+/2vFtNZLPBiYzVqkDsY/1J/mWrtpZpLYuN3+hELt5HX+zB0
 JgIOTSgPbS1MoSucXhC0wYWn+WWqxl4=
X-Proofpoint-GUID: OwPHliHPAsDWHx4DC8GNcNKkiK23UN9V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE3OCBTYWx0ZWRfX9Dnqwm7ZEsj/
 RhjD3ZTA+A7Rg6J9Pu66YW4kMQrIB7WF4IfXvG81SQeT69hzEJnXgtF804HG3SODhtkalU1WhdG
 UN+9liwJkrk+iRlz4y5by6or0j51FSGULuJzIp1XQmcXDQ1LlbVNrjpl58U7DNz6C1hYfinjgu6
 WBoVKN8Q0sD5uETVNs7KHrpb0KtaB2cnRkefYlmJ5nZkhQdfyWCqS8t9wV+liqSktjUHPWp0wY4
 0fcDY2vOTj60DZh1LWsLBlpWwH5lUFmQBPno7iTWa0JA0JMxi/svxNVbdmLyPfYvqfUPyo+kuTq
 oKlcYzx1XP536v7h/dmX61PFHtGTLP5Jz54Yds+7ifz6KZS4ek5BcpaN7UR+9Wd7/r9JOIuenEo
 jbVRkP8VyP1gFkq6RQhClpYcr+zAfDJRezmshMlxWwIiViBCPeWHn+EHgsQIhSllWTpUQQqILrV
 NbUsreLzs1u0neGg1Zw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240178
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

From: Randolph Sapp <rs@ti.com>

Add support for EFI capsules for this device. One large caveat is that
the partition holding boot binaries cannot be the ESP partition due to
the following ROM limitations.

- The boot disk must be MBR
- The boot partition must be labeled 0x0c with a boot flag

A separate ESP partition should be provided for EFI capabilities.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
v3:
	- Remove unnecessary dfu_alt_info_ram variable
---
 .../arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi | 29 +++++++++++++++++++
 board/beagle/pocketbeagle2/pocketbeagle2.c    | 26 +++++++++++++++++
 configs/am62_pocketbeagle2_a53_defconfig      |  1 +
 include/configs/pocketbeagle2.h               | 25 ++++++++++++++++
 4 files changed, 81 insertions(+)

diff --git a/arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi b/arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi
index 452161115318..283e26380e48 100644
--- a/arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi
@@ -181,6 +181,17 @@
 		};
 	};
 };
+
+#include "k3-binman-capsule-r5.dtsi"
+
+// Capsule update GUIDs in string form. See pocketbeagle2.h
+#define POCKETBEAGLE2_TIBOOT3_IMAGE_GUID_STR "F0D53723-106E-5346-8A41-85EB2D07C720"
+
+&capsule_tiboot3 {
+	efi-capsule {
+		image-guid = POCKETBEAGLE2_TIBOOT3_IMAGE_GUID_STR;
+	};
+};
 #endif /* CONFIG_TARGET_AM62X_R5_POCKETBEAGLE2 */
 
 #if IS_ENABLED(CONFIG_TARGET_AM62X_A53_POCKETBEAGLE2)
@@ -304,4 +315,22 @@
 		};
 	};
 };
+
+#include "k3-binman-capsule.dtsi"
+
+// Capsule update GUIDs in string form. See pocketbeagle2.h
+#define POCKETBEAGLE2_SPL_IMAGE_GUID_STR "C73FDEA2-3964-58C8-8A25-E55102172E1D"
+#define POCKETBEAGLE2_UBOOT_IMAGE_GUID_STR "520E1012-DE6C-5992-B43A-95D53D8332F2"
+
+&capsule_tispl {
+	efi-capsule {
+		image-guid = POCKETBEAGLE2_SPL_IMAGE_GUID_STR;
+	};
+};
+
+&capsule_uboot {
+	efi-capsule {
+		image-guid = POCKETBEAGLE2_UBOOT_IMAGE_GUID_STR;
+	};
+};
 #endif /* CONFIG_TARGET_AM62X_A53_POCKETBEAGLE2 */
diff --git a/board/beagle/pocketbeagle2/pocketbeagle2.c b/board/beagle/pocketbeagle2/pocketbeagle2.c
index 8463d82ef9d8..b6a136a93c0a 100644
--- a/board/beagle/pocketbeagle2/pocketbeagle2.c
+++ b/board/beagle/pocketbeagle2/pocketbeagle2.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2025 Robert Nelson, BeagleBoard.org Foundation
  */
 
+#include <efi_loader.h>
 #include <env.h>
 #include <fdt_support.h>
 #include <spl.h>
@@ -22,6 +23,31 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = POCKETBEAGLE2_TIBOOT3_IMAGE_GUID,
+		.fw_name = u"POCKETBEAGLE2_TIBOOT3",
+		.image_index = 1,
+	},
+	{
+		.image_type_id = POCKETBEAGLE2_SPL_IMAGE_GUID,
+		.fw_name = u"POCKETBEAGLE2_SPL",
+		.image_index = 2,
+	},
+	{
+		.image_type_id = POCKETBEAGLE2_UBOOT_IMAGE_GUID,
+		.fw_name = u"POCKETBEAGLE2_UBOOT",
+		.image_index = 3,
+	}
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "mmc 1=tiboot3.bin fat 1 1;"
+		      "tispl.bin fat 1 1;u-boot.img fat 1 1",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+
 static int pocketbeagle2_get_ddr_size(void)
 {
 	// check config overrides first
diff --git a/configs/am62_pocketbeagle2_a53_defconfig b/configs/am62_pocketbeagle2_a53_defconfig
index 8964cb3b1955..7428926a8ba6 100644
--- a/configs/am62_pocketbeagle2_a53_defconfig
+++ b/configs/am62_pocketbeagle2_a53_defconfig
@@ -122,3 +122,4 @@ CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_LZO=y
 
 #include <configs/am62x_a53_usbdfu.config>
+#include <configs/k3_efi_capsule.config>
diff --git a/include/configs/pocketbeagle2.h b/include/configs/pocketbeagle2.h
index dd6956aa8b90..aed60d325742 100644
--- a/include/configs/pocketbeagle2.h
+++ b/include/configs/pocketbeagle2.h
@@ -8,6 +8,31 @@
 #ifndef __CONFIG_POCKETBEAGLE2_H
 #define __CONFIG_POCKETBEAGLE2_H
 
+/**
+ * define POCKETBEAGLE2_TIBOOT3_IMAGE_GUID - firmware GUID for PocketBeagle 2
+ *                                           tiboot3.bin
+ * define POCKETBEAGLE2_SPL_IMAGE_GUID     - firmware GUID for PocketBeagle 2 SPL
+ * define POCKETBEAGLE2_UBOOT_IMAGE_GUID   - firmware GUID for PocketBeagle 2 UBOOT
+ *
+ * These GUIDs are used in capsules updates to identify the corresponding
+ * firmware object.
+ *
+ * Board developers using this as a starting reference should
+ * define their own GUIDs to ensure that firmware repositories (like
+ * LVFS) do not confuse them.
+ */
+#define POCKETBEAGLE2_TIBOOT3_IMAGE_GUID                                   \
+	EFI_GUID(0xF0D53723, 0x106E, 0x5346, 0x8A, 0x41, 0x85, 0xEB, 0x2D, \
+		 0x07, 0xC7, 0x20)
+
+#define POCKETBEAGLE2_SPL_IMAGE_GUID                                       \
+	EFI_GUID(0xC73FDEA2, 0x3964, 0x58C8, 0x8A, 0x25, 0xE5, 0x51, 0x02, \
+		 0x17, 0x2E, 0x1D)
+
+#define POCKETBEAGLE2_UBOOT_IMAGE_GUID                                     \
+	EFI_GUID(0x520E1012, 0xDE6C, 0x5992, 0xB4, 0x3A, 0x95, 0xD5, 0x3D, \
+		 0x83, 0x32, 0xF2)
+
 /* Now for the remaining common defines */
 #include <configs/ti_armv7_common.h>
 
-- 
2.54.0


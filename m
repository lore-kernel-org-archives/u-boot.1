Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8FCCD98F6
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 23:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96E49849CE;
	Sat, 20 Jun 2026 01:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NJ5SZW2S";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="g+F6SQBA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5E1C849AA; Sat, 20 Jun 2026 01:17:46 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5C7F849BA
 for <u-boot@lists.denx.de>; Sat, 20 Jun 2026 01:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65JLY7AS095829;
 Fri, 19 Jun 2026 18:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=CEGEoz9LpgoLl/PDMTn+AxU9hrC2lPevafUqYs85M
 rM=; b=NJ5SZW2SIA5/275UhZo6c1ghnyOOTNl/u4NtZPDcaV8mLe5mah9w3d9Qt
 k+TL+Llbfgip7swq0FHzQc7O27mCmF6Ay/NHkqc0Oj+BAZJ5rSsAj5EX5FTx7b0y
 JC0vTQhpwezgX2n1L7FDXagfhrAJacngprwm591epUmy2riTPUu+jiPTNJhoRtke
 ldYuV7zQz7Ci83D1GknR3Ogtnxjgz5zuZ5Q2q2NQQHKfMYRVZCNqADVEFLknTjdw
 cp381HxGuGrD7KbTuGeBLNvQLM0IMbGmVye8fx4Looi/7v/x5zpHgUDAfDCCz+DA
 GGqjDkTacVKc2lK1LmQmK/VAenWWQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
 by m0380145.ppops.net (PPS) with ESMTPS id 4ew4s643k4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2026 18:17:33 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0cmhsbJHcQd0EN2HFGtFgX6RMWIxnre8rEqogn/SGpqrMxTfPKwDqmm+gLakgAR/OEBvOMYZ5GyrxKDkTSOKKQcW9mluh+J9iLknZGtFCvYRiAvUtH25c3M9hYfVj3RqaBjlAc3LbqyEChNBvpkLAk/qP4s2S8aU1Al91Sb4dyQUe70mKTyJm9zsILgnH3pXo28JIIeHQygtdz1PfUH56pHXEuPHTVXBKsCjD/juBT5V/YiFxdmr7g7tUSrJmP28jx9u0/DwUpCJmAahzBLY6uOQZGR8G4/jQy+J75+9f0zNxyCcMvi5FJxFH3JxSO9QUA0uUsQGk6AI/WrFiy1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEGEoz9LpgoLl/PDMTn+AxU9hrC2lPevafUqYs85MrM=;
 b=peM9RUC+8IAb+A6uT602M1SIbgeZ0LMs+DpBNjm+WMNGuJrHBARHFCIv2Pr79miOTKGPEztzOcRj0BUC9Sns9EDxGC27TwmzjpuwF9J8dhYVHxNngbcWcxP9E/rqEZD8Yix67Eg4/UrjeXgOIrxiqboRm/y9UkGo8Bo3vgAQunvoRfbMkGOXtKG2w8wmMi286Dp5/tJyWcSjcBtzp/tw2zJTZeYNif66gsI/rg6i5cKojPcUo2meV6vYYDecG1ltpmjAd4e/aufyq6erxJwhjkPMagBSyPlJAHnlIe98zPoG33Iu90gYz39wjAsDp5bNRf47oSIzi8Cr7P8Qf7Y9Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEGEoz9LpgoLl/PDMTn+AxU9hrC2lPevafUqYs85MrM=;
 b=g+F6SQBAZr+nVCKCRfdA2RdsLwFEDcHpCEsjVXB8Fn/0o+tvGWnGD8/3hRKoTFs+/XiBp2BQoUg7FJLDE39AweEXUG0niN+h5kMxhaBMXHCbDAXQYlbMB2hUzrSBczpd9OJWo+Ls2vAlVq0n0gIsf4BYfmYYGnPIsSPazU7o/r0=
Received: from BL1P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::11)
 by CH0PR10MB7437.namprd10.prod.outlook.com (2603:10b6:610:193::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 23:17:29 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::13) by BL1P222CA0006.outlook.office365.com
 (2603:10b6:208:2c7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Fri,
 19 Jun 2026 23:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 23:17:28 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 19 Jun
 2026 18:17:26 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 19 Jun
 2026 18:17:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 19 Jun 2026 18:17:25 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65JNHPGY3686026;
 Fri, 19 Jun 2026 18:17:25 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv2 5/5] k3-am62-pocketbeagle2: add support for efi capsules
Date: Fri, 19 Jun 2026 18:17:19 -0500
Message-ID: <20260619231719.3823195-6-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619231719.3823195-1-rs@ti.com>
References: <20260619231719.3823195-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|CH0PR10MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe8a567-af9d-4165-daee-08dece58ee41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|18002099003|22082099003|6133799003|3023799007|56012099006|921020;
X-Microsoft-Antispam-Message-Info: 2irzVakzH51gkvaQF5etx53fwLVPYgyldLWvXuTlvO2carnV1u6aanHiJ+gzy01Q/PNgfZthypriXz44im8M68oFHSt9MYPY+j4lwVLdJq3OQBlHVeyb0uwLxZ0B8lrL3XpqqMY+/msTyb+LqjuSp6RkiHG5EKe9AgvA6+uNanBniRi2qhTOWxdhaZIC18A3ZI+MyZS8SzWf5fcduiHeZOhfz1DW9EI485LXRIQe4cvd98b9Z1Nev4+gdCyUIz1sUS7Lyge5fEllxl2NTRiTY0v/rtZmJq+050sqwBwPp/Qdai5X8KyhPbEpk7xla6qcWVVnIYk1pfBHDGIa2zB+1pdQSrvuq5zSbVygpvgKWu3GKE+/I/nEg9YT31+MldE8knlRvNm4CQxl2k8zC/wAEmVir5XggVqn5a7mtWPvFOSnV+Wq+sP0QlrfJkXaiE1ZahMOM66UwwKtv3BhlYz5ma03n8ulcHTkQbgcYYyVMOqq5Pdqw9BcsvSIHCR2snbVEIvLoa2UcrmZnHGU62UOBUgtTwmCyRobUnPndarkYIDOI7QI3nYOu6SOT1Kk/ZZLjkJB7JUbYs36X6IN4hzOWel5wJ+9ciwA0uMf4MS24qEkTzTxRK9ZoAvwJezDjriq7/91zE8q/+6GHM6lnSmUhV3oFe7boHaWRBsg3v9RwsH3sQxxwt6sfCie5Ko23o5NtRfxxnDHrpwz1kzYu4HzyO6ECz4jGbWzSodJlT66u7hEHJKzqP6QvUzwe2Cv2M0J
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JX4OF8Wmal+icHzmFXA3qOFIB7KGHDkdZCElTJt/SUenhPGmaME3MEAi0j5hJgo2D3GRl6OdL3e4uMn6GefbPa5oUf5s2HdCFU09Yawtnykn+PKWmJC9QzCovuxbnQ0JzAkwwZY7Aibd4OvPwAe9Kk/BID1hPiVD9lH9vaxOsE5RLkBpsTuUnGVyKkukhVHkCGn5dz8jNpbMBCj/jibs5XIA7ygfinVZly/CkjX+F/5iELHxg7xkpUw0hPlWzrRfe/FOffptzYb9fsdtzWrIi7fRof5XQieXTlPoeV43PDIWeTRz2Oha3+ujn2zpbTDxY7ABouQLWdzwI8RAfuOdIF9wY9M4eWHQeqipmXkctiPhnWyZeTAelng+D4LPBX03yrVtTFTjIsY+0h2tPX/GsgnLkv58qN6tCt99g9My6Yjr2GIq4BFyoL64LwsLyGWM
X-Exchange-RoutingPolicyChecked: Hl+BQm+XXg4nMR+46LVkAWBtkBV2vzmhbLCeo2qOnLh2F3o25M7aNmAmcMqyvJM2ADjIbRX0TQIZfAe+sEI6qbr+LxY6GnURImlaaBxR6EpPfoeiDrMGjf5ZAOqPb93NXrtJ721B1fOeGPGRP7MJYRCFxGGWq8iTjzvEk/Q3LotOAJ/EQc8dpqwy0ueMgDaDlafQwke3rry3YEn9+q7EW0Qm0lo5ihr5Qn5xgGIhl0OoqoMK2UA+whC+o3NYnaoANqYkxfasrGz5Huonm6hMncIYA4Ub0nQAczMLzcusqpcaaqDcWtmlPE4wB0G7ITddVAMS2f0LUneFOx5/c/UU1A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 23:17:28.1739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe8a567-af9d-4165-daee-08dece58ee41
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7437
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMyBTYWx0ZWRfX2qCX6sV9o2wr
 vixDrNFjx9ZdMkrGu07wmyzix3bEfiJTEDEOmlXFDGaWjCEZmjwGRQSvj5vdxValZVK3Sl8ZkuO
 H9cOEwhCaH/Rzvuq6lurOwZX5/hmG74=
X-Proofpoint-ORIG-GUID: C45BPXgdUGcgTvzufGek4ZCH7jjfrB9N
X-Proofpoint-GUID: C45BPXgdUGcgTvzufGek4ZCH7jjfrB9N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMyBTYWx0ZWRfXyV1t19E9JbZm
 qWT2MkrjF1CKN6feiCdBWanuuD3ixkShaN3L8aG5Zqalq7ml27rMyvVn/7LQ9a3nxZvTv7uZEgq
 VXM8llMgvz33GDo9dPSV1iLDEYp9s36bNe/02QIVZNwk3AKdsnEcvR/P/HFAhbLbLUfSviGIFq/
 GvrSLXAp9YyZp4cC45zsK1NegTpYCA75vaidsaC4YN/fV08FvrFuyMJFD4PCGghfV8Rsw0OfFlM
 E9Jbclw5brlw8WWL+ccYmD6R3J/DDxse53+YyR+UgKrQFPtEQnU+H/cJORefhEf0WsL7Eo4qg2z
 ly9EE5teN+tvHMoQ29mt/PIraMIeQzvj+loaeyYL7X7z91gom5suL9pSSF/i/j3cyDkfC8z2OMO
 LKqAR3paZ/Q9zbCx+A1kG+AP8wdRNptkh/uRpkP/qq1b17sQN69XfiAJRR8Tc8nqC7bEffT6uBS
 4LX6eNn7UUmAt/xGJmg==
X-Authority-Analysis: v=2.4 cv=P6QKQCAu c=1 sm=1 tr=0 ts=6a35ce0e cx=c_pps
 a=PlHkPQd8QExaI989BnvVeQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=zziTSyxZXs25WCk4eZ0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190223
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
 .../arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi | 29 +++++++++++++++++++
 board/beagle/pocketbeagle2/pocketbeagle2.c    | 26 +++++++++++++++++
 board/beagle/pocketbeagle2/pocketbeagle2.env  |  4 +++
 configs/am62_pocketbeagle2_a53_defconfig      |  1 +
 include/configs/pocketbeagle2.h               | 25 ++++++++++++++++
 5 files changed, 85 insertions(+)

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
index ea8d21310752..3ec142b1776a 100644
--- a/board/beagle/pocketbeagle2/pocketbeagle2.c
+++ b/board/beagle/pocketbeagle2/pocketbeagle2.c
@@ -14,12 +14,38 @@
 #include <fdt_support.h>
 #include <spl.h>
 #include <asm/arch/k3-ddr.h>
+#include <efi_loader.h>
 
 #include "../../ti/common/board_detect.h"
 #include "pocketbeagle2_ddr.h"
 
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
diff --git a/board/beagle/pocketbeagle2/pocketbeagle2.env b/board/beagle/pocketbeagle2/pocketbeagle2.env
index 816f365083e7..930c5b466340 100644
--- a/board/beagle/pocketbeagle2/pocketbeagle2.env
+++ b/board/beagle/pocketbeagle2/pocketbeagle2.env
@@ -24,3 +24,7 @@ bootpart=1:2
 bootdir=/boot
 bootmeths=script extlinux efi pxe
 rd_spec=-
+
+dfu_alt_info_ram=
+	tispl.bin ram 0x82000000 0x200000;
+	u-boot.img ram 0x82f80000 0x400000
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


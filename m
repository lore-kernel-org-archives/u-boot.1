Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733B4C43602
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 07:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25F5C84B2B;
	Wed,  1 Jul 2026 09:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hSZB3Tyg";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="efiJV7K9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A42B084B50; Wed,  1 Jul 2026 09:50:48 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78E1984B20
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 09:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6612uNmQ2538124; Wed, 1 Jul 2026 02:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=dgyJbSDAhrBjYZTRHimSxa/bqtZecq0x3OdFfo5bg
 Lc=; b=hSZB3TygKggxupPEjDIvvPOqheKCqez//4xmC2ZvMeDAimb5sjoiuTh0C
 e2NKe2Ia8RRBn76RDXOXqwFs2GzbyVrmE/iKJv0T6ZCsGwsiDZFRjscVqIKPrml4
 JzUuBM/P/+P/s5/StdQ0uezgtWrYDRRi+MdZmipvmUoNojZiYJSpVuO0cCrWLBwQ
 EYLxMx7wCiTAXXx+sFpkCWbOtb8dgzAFtxabzj1So6d2UQhxcCk1gTXnSbZ0LVFP
 +pL+ilOxfW19Y/4VVGcuan1q7Q5t5YR5XCkQ01Mu9k7yANr9Dfc0fWd18IFggF80
 8qpYEr995imZ/WtVRKNomh6NmY2PA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f4nva2xj1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 02:50:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQmYZnZL2X4XB+F9nFzP/W81x+hq5mmBwhih29W5dam1DBqAwoxkhtMevcCslvcfSkOegLHVeaiOwmQ0LTGZC4z+mR2U3MGrxbU3zFDb8Yb9+3U9IXJxgGQNVsOFGxXJR/ijy9UimxLKQRRwTWU0hxR8hHj37dfCDMSjwgoJsTy1VuE9TiQH6IKk0bOsZ0H5hGZghXVaHP+w3B7+aPq9/YN68cz04agfj0KWbW97hoG8B/CJ6hnPXYJ7743CQymg8O1BHNxvra3Aubhyvn4kac4BcH6rk72dy5IEpL0SGYg6UVXx8kRW8hCBFH0M7MPGCRQHYxmg50WDheentO4rvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgyJbSDAhrBjYZTRHimSxa/bqtZecq0x3OdFfo5bgLc=;
 b=wQLak80Y9eSIjL7lIojYVw3LBUfDsZ8D045JHe8Q8jx6HC6+g3y37P7L5wL2RQcyVVBvlikJLxJINkhrsVOTw4lHmNvSOLKTVKY0fis3D5RvqRA9fLHUpqtOWbYSP1VQJ2C5h/F5fgCjd2n7u+zELypCxYplbiIe8jy88jBDSAnfBgsC1CfhAJ5iy4XUrOScQKeNwykThuQs20jB+iaJ1H7LT2fKStoKXnD+VZc8HvbyNL0UeX49DEXhleyOIJ9FVUnuazN9iR/wFVp8HGyXkQC/4RVYSX7XcbUa1L9Q8K7IGre/1HvOVpelBsTv0alxIaGt+QT2OqGdT7dc8Ru/yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgyJbSDAhrBjYZTRHimSxa/bqtZecq0x3OdFfo5bgLc=;
 b=efiJV7K9MNeaYD5z2a0n2ANYooxbALgxOyGDrBXozoKyMHvFt+a5ud+8E1DXYEKAA5+uVO4Yt7wRhHDY0gcDiHGqHdmh6DA2u22hsvozuCuitHUR4NlxuTKNL5Oa7acst5A/157qMsUplSiIE3ckMrehyzOaPTXmnE+NnPmkfms=
Received: from DS7P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::31) by
 IA4PR10MB8518.namprd10.prod.outlook.com (2603:10b6:208:56a::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Wed, 1 Jul 2026 07:50:41 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::a5) by DS7P222CA0025.outlook.office365.com
 (2603:10b6:8:2e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 07:50:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 07:50:39 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 1 Jul
 2026 02:50:28 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 1 Jul
 2026 02:50:28 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 1 Jul 2026 02:50:28 -0500
Received: from localhost (ula0502350.dhcp.ti.com [10.24.52.241])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6617oRmZ304675;
 Wed, 1 Jul 2026 02:50:27 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <msp@baylibre.com>, <v-singh1@ti.com>, <anshuld@ti.com>, <afd@ti.com>,
 <m-chawdhry@ti.com>, <joao.goncalves@toradex.com>, <bb@ti.com>,
 <n-francis@ti.com>, <sebin.francis@ti.com>
Subject: [PATCH v2 1/4] arm: mach-k3: Fix phandle corruption in fdt fixup
Date: Wed, 1 Jul 2026 13:20:18 +0530
Message-ID: <20260701075021.3626094-2-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701075021.3626094-1-p-bhagat@ti.com>
References: <20260701075021.3626094-1-p-bhagat@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|IA4PR10MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: 755af088-cb1d-4e05-b9a3-08ded74571b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|18002099003|22082099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: uu4G7eHDbCxgSN0bfXmwlsjbBgNmY+1Zf2wFs9xjokfCj4jtS9h4/qi462uvo8NTb5ZJ+4+dUdwZe7j4nlQYeC8mwewRhWd0itBqQwL8JsPlGi3Vgnd39ra9QDQEZEuqwxW7doOdN5RnXWBc5b+igxhuwwLB+fTk7clz10Tk500YlIoagWhmKIRquwqQdadFCvifVU1j9EOQqZ+fUncCs7ouulpqQPmQaiqw0UZYz29AElYXigCUDeMh35tKmPlAtNcNkc2cLhVKkIYlEY4Gj3plktxVlPP4TZMXARJyGXjtdy9cWMcN54EOrTxUzAbQWN2d8k0PERlDm8yjwAB6a3CvG8Xhp1sHrjsUZAdxtGlCRmhrovgtTXf44lmQDnDPRC2yRQ27EzRtH49yEiblXELHzzdQ+DdPdJc4Hy201oT1gHx9X/Ka5Uk174n/Q+CDxfFY0az6aN//FuKLSQ0bwxxVAmC6tJuQSA0r55OZFTdK8afU0NWj8n7zEXR3yNottsqBing1q1mhenHhSyehs3a/bVB6ztqt70PgvV1oyvNDI4A1Sd5yvUShImdgc6eukGr7v/tAff3sTTsbtOTddyx2tYGbB2taaopxc/0KR5c+oRKO7jFeO49rBp+eXyM1gGd1KEbbpTfC9Z+9TLrG4Q5RQLYID7N5TiQew0tiQ8L1+hUz5qximX/XKIKPEeOY4pIGRILMUBQ2/DiTA4pNIQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AvzRaA/JkiU1ydDQcs2pJEU7Vw3KWrBjj7/0JLhs6FjDZccBiZbcOGuli3KbEls1rcY+cmBYcTjqGq0n1GEPyPKW2X6H2VS7QUITOvXXSbp7yktunY/Y50rj1qavnVmS1akP+FpShUOxgEiWnbP7z/k80sd8mEnLTG4PwdkDMrCuvbbl8xInj5J0l3vftTXXPa/7Vb8j2L/DRP8ArAjAVHAQoyw4/DtE2C0fjWaHkdvdMnTnUo5uqSPWyZGgqZCxC3RrtluvfKx8DMpHTCjr/6Qb5Wc8pG9pppSyPyQ/lZ6pwbUlrpof//ZDxVZSZJJcze5wu0rwgYt3wi5IZBZCLNThsXvUOAVNWEpGZPxB4h9+f1XeXU8SMDkAaZR88KqiA+bl5zRKDchR08UDxR12aV4yPAPYigeRREawzYRuPyBZ5bbjY9lTm7+3DY2KLWOK
X-Exchange-RoutingPolicyChecked: jdLWkbHSQAxmLccDMur7JMdHnpPJwvL96j0aMd1/nSN9gbnOqPHOD1i8ET2ZBZSvmFNfqvrVseVmSsen+LieJsdtq5TNkVrcCCiM6pcaj7Wa6+yLUJA0OBPtr/RLmllIPZ0EmEx0qV2KLpoTa2WkifEqY3sJ/LlfDTIB2y9xtTTCyvVLMSSobrhZCYi0d/HaS5iH6y4GJ/8x0P5lKYeA6Pc6pmDmFaOW2F4zNgslmQ+dyi+sjVXu3I/JZn7Pvh1X2H6ui72b3W+TtsHPDZIfC37blgKTXvlUsTS7oNzAQHfzXshWQJWnw2DpbaTLmwF4Nhcqyz7h9klvUenywoPa5w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:50:39.2777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 755af088-cb1d-4e05-b9a3-08ded74571b8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8518
X-Proofpoint-GUID: Koi57DSBbpJ-OUCFHuxAxBIXWAS4OLzX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3OSBTYWx0ZWRfXyAVyhPRiQjxt
 ipqTr+HMUZJzIASz8RziQD0BhXrU6ekrgs8evxg/A6Q/eKonVG8JWSAjM6pPTIBueORk/l/L7Eg
 KEw1Veb2aZ2t6wl8JZ2ESNdd1oH0f62r0Cnz7X3ZWOc0XCs2YFr8JfN3o1HhYLb3reTOUZ1Y+TN
 L9hcUUUU+p21GaDt037/cGShyg+gfTvJ/5B0f1GZImzlYaDWwoAxUZF7evMZFGlrzSQ3gjuzeLa
 KEaXj7G9CoHYKS52Dc0/5l+duMsWIl7qDywNWsuO4XJHt/7lyq0fEQ9x5DVs93vc5+MXVqz8M/1
 MCm7wMVfSNSb5mutuEpGLcthEffpwCLCFOmsUQ/SlDEuec7qLZf09C+d1JYnHhP0i95y4BAyJPA
 g0SHFawa7HLfzPeEBYwyYOYp0ArLietXKsL7BCTRAY014yysvr31LWf3f0Lv8uAOQCjr6gGyq3a
 Kcr19MBCFT9Ze4g6ueA==
X-Authority-Analysis: v=2.4 cv=FqA1OWrq c=1 sm=1 tr=0 ts=6a44c6d3 cx=c_pps
 a=ikyLliMNhLjillvDIwfXbw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=EDDAqS7lIVQ_7pT73moA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3OSBTYWx0ZWRfX0Q167hCYuTZ7
 6DkhIwP05qe1g2LaFHk6bLZfI4FvgtdGZOQFRUaxh2nwCwPt65hYHFw1MoE4W+FHLtVT3eNkQEZ
 hbyaWXnoiR6olzfTWlLhhJIsKkWr3ug=
X-Proofpoint-ORIG-GUID: Koi57DSBbpJ-OUCFHuxAxBIXWAS4OLzX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010079
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

Fix phandle corruption in fdt_fixup_reserved_memory()

The original implementation used a delete/recreate approach:
- Find existing reserved memory node (e.g. tfa@80000000)
- Delete the entire node with fdt_del_node()
- Create new node with fdtdec_add_reserved_memory()

This worked fine for ATF and OPTEE nodes because no other device tree
nodes reference them via phandles but other nodes example DM are
referenced by R5 nodes.

If these nodes are deleted and recreated, it will not have any phandle
property but the nodes referencing it will still contain the old
phandle, causing initialization to fail.

Update nodes in-place instead of delete/recreate to update only the
"reg" property using fdt_setprop().

Fixes: 8b0fc29de0e3 ("arm: mach-k3: am62: Fixup TF-A/OP-TEE reserved-memory node in FDT")

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 arch/arm/mach-k3/common_fdt.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
index 39cb00c3f43..4b833f5fabe 100644
--- a/arch/arm/mach-k3/common_fdt.c
+++ b/arch/arm/mach-k3/common_fdt.c
@@ -119,7 +119,6 @@ static int fdt_fixup_reserved_memory(void *blob, const char *name,
 				     unsigned int new_size)
 {
 	int nodeoffset, subnode;
-	int ret;
 	struct fdt_memory carveout = {
 		.start = new_address,
 	};
@@ -129,43 +128,27 @@ static int fdt_fixup_reserved_memory(void *blob, const char *name,
 	if (nodeoffset < 0)
 		goto add_carveout;
 
-	/* Find existing matching subnode and remove it */
+	/* Find existing matching subnode and update it in place */
 	fdt_for_each_subnode(subnode, blob, nodeoffset) {
 		const char *node_name;
-		fdt_addr_t addr;
-		fdt_size_t size;
+		u64 reg[2];
 
 		/* Name matching */
 		node_name = fdt_get_name(blob, subnode, NULL);
 		if (!name)
 			return -EINVAL;
 		if (!strncmp(node_name, name, strlen(name))) {
-			/* Read out old size first */
-			addr = fdtdec_get_addr_size_auto_parent(
-				blob, nodeoffset, subnode, "reg", 0, &size,
-				false);
-			if (addr == FDT_ADDR_T_NONE)
-				return -EINVAL;
-			new_size = size;
-
-			/* Delete node */
-			ret = fdt_del_node(blob, subnode);
-			if (ret < 0)
-				return ret;
-
-			/* Only one matching node */
-			break;
+			/* Update the reg property in place */
+			reg[0] = cpu_to_fdt64(new_address);
+			reg[1] = cpu_to_fdt64(new_size);
+			return fdt_setprop(blob, subnode, "reg", reg, sizeof(reg));
 		}
 	}
 
 add_carveout:
 	carveout.end = new_address + new_size - 1;
-	ret = fdtdec_add_reserved_memory(blob, name, &carveout, NULL, 0, NULL,
+	return fdtdec_add_reserved_memory(blob, name, &carveout, NULL, 0, NULL,
 					 FDTDEC_RESERVED_MEMORY_NO_MAP);
-	if (ret < 0)
-		return ret;
-
-	return 0;
 }
 
 int fdt_fixup_reserved(void *blob)
-- 
2.34.1


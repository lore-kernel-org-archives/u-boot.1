Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB20C4451C
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 15:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22FF4849BC;
	Sat, 18 Jul 2026 17:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U9ErhNzL";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZMh4I8Q3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67CC7838D7; Sat, 18 Jul 2026 01:24:01 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57EDF84105
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 01:23:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66HNFhu03762455;
 Fri, 17 Jul 2026 18:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=GOFLNTbyw/e+u
 TDZLgSPm5DkXZ5QnvI9eR4075vYYrA=; b=U9ErhNzLNDCkZ9XCe2STO2l+9L1a2
 3X9recK71JgerpmOmiArQWUMHpHhvhg7KOelQytDnWSYZfxLrAWktT1QCqzRW4Nw
 eyxGpvXp1e4R2LSU2mi+jXqCgtnJ5sQYrJN6R+eKvj1N8JePaGEcCFT2b+gEevbS
 vT87UYDUioizDlatKDWtIaJEelaJzqsG5GIwcyH4Lf9rctgK6iBD5PnVtb9iFWA3
 2ZbA5dpkjjzsvvPweYPK3k28qLv/2VneimJ0IPtFIjMba53R9Xq9/mxfhQVmNLmq
 +K0RQDAwYabn/auP3hRuuag+8fmgAOpxBpbs8tB7d5Jq/dvueTJhM7ivQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011030.outbound.protection.outlook.com
 [40.93.194.30])
 by m0380145.ppops.net (PPS) with ESMTPS id 4ffks33tth-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 18:23:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvoDdesSkWYwv+EWa/pmcpcSPuQ0Ew8GKBJnTm1vUc1s07Ik6aEz1rl0WzWVl5g0pHjys02OtSZvKd2PNIRT5OZaiGHtoXqpAXCchFiZUIaaM6Ou1GaG84/pZFcWbKzA3Ae01G4wO67eZZFjutvfbyn6lc4+ABlibNG5TYH9kbPd5ZZF/KSKWBK+jNushm2bYf4Fo79ySDJoLtUzbUeP5DIF/GMXPVsxWdC/MIYmwEe2e9QKQg35qdY1XJlnNQr9Cq5b0xMHBOnha22dVDZdUZDiZDoWwVKncGtJUG7J/0uWJFi9pwHqBBopaAc5KORqKFnzUBTc+rHj4iwVN6iSbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOFLNTbyw/e+uTDZLgSPm5DkXZ5QnvI9eR4075vYYrA=;
 b=D8NqFUsfMu137o5ZUzmPudRixH5RNJ8g3L7vxZqoQ1eQSWCOLVn2Y40yIKRdQKxB8Oq9JqoM+RxqZOGHpbSK05hCDg+Nq75NSr3BVeta73hlLVZiLIrS2AV3OXsWL5VkEJebiBbgOteVmu7PToJ5g6geXXENMyqW9qxWjMUbR8FVC2je3jDUAaS9o+NtDmmWNnPIMMdqEScXtvcSzffQwRz5tWAQHKzwsKI06HNiq2CToidIb95lFYlSJKDXCfet1iKmrSdHZr0q+huO7LGuBlOuG8ZFGW/ojLqO9UyyBfD0hVZHr0Fc8+IEYK3dGuzVdpw3vijkLJGLTfFZAtvdxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOFLNTbyw/e+uTDZLgSPm5DkXZ5QnvI9eR4075vYYrA=;
 b=ZMh4I8Q3W62mkT1am+Wo7OsEb4IkJGz4o/mTVUlxlBk0v8GfaA1p67mF0r6YAQrMlyuVz2vHMij5QWkB3iscJalItzrvVLybXeR2NhXEVqTBUnxj4EenIo38v0sf0wMnvAYMtdnrlqbTJSZARjtBbj9tG3/R/pP3L10hFoaedP8=
Received: from DS7PR03CA0004.namprd03.prod.outlook.com (2603:10b6:5:3b8::9) by
 SJ0PR10MB6373.namprd10.prod.outlook.com (2603:10b6:a03:47d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 23:23:36 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::36) by DS7PR03CA0004.outlook.office365.com
 (2603:10b6:5:3b8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 23:23:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 23:23:33 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:33 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 18:23:33 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HNNX5X150064;
 Fri, 17 Jul 2026 18:23:33 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH 00/11] arm: mach-k3: introduce basic support for the AM62L
Date: Fri, 17 Jul 2026 18:23:30 -0500
Message-ID: <20260717-am62lx-v1-0-b9830633afb8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHK5WmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAyNT3cRcM6OcCl1zi+TkVDPjNBPjNDMloOKCotS0zAqwQdGxtbUAMCH
 qy1gAAAA=
X-Change-ID: 20241025-am62lx-78cce63f43f6
To: <u-boot@lists.denx.de>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Alice Guo
 <alice.guo@nxp.com>, Anshul Dalal <anshuld@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrew Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, "Kory Maincent
 (TI.com)" <kory.maincent@bootlin.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Daniel Golle <daniel@makrotopia.org>, "Rasmus
 Villemoes" <rv@rasmusvillemoes.dk>, Vignesh Raghavendra <vigneshr@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Dhruva Gole <d-gole@ti.com>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 George McCollister <george.mccollister@konsulko.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 "Swamil Jain" <s-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Shiva Tripathi <s-tripathi1@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "Aristo Chen" <aristo.chen@canonical.com>,
 Johan Jonker <jbx6244@gmail.com>, "Apurva Nandan" <a-nandan@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Hrushikesh Salunke
 <h-salunke@ti.com>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|SJ0PR10MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f729b90-4f71-4930-75ce-08dee45a6bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|82310400026|36860700016|18002099003|3023799007|13003099007|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: dPx/FpCM6C63CfNkFIEWAP/ge7zHgbPsc1p+k4Ywp1V2vUMVakPLucOGK3DA287X9oX1j5S1jRFfzBJvwroMlfoT6l+Xt9qUa3R9+t7Eq2cpxmlriAwxLrMb6O4WM7R9/ZLNkdzmFhFmFrKPddhh2K6GpFGiJf10CIjdoHV3XRaNkcVJ9ryjKdp6+4Q6rIrC9fRBtN38Wao+7gKlthFr+EBz2pYg0eXdcw84RvWzYWq7bscEBdOKO6OVk6/bDpLI2G/Cm19gxNxxV1pKJguhq7HK9g+JnBRz/SQ8ks0KyaWsNMlcY9JJGms9/6sUl5VcJ2A0Vmo72z3BKUn5+R/CXuUOoLVIbKGGOGhxR6UMLkb+ULsQmcrBH2Af14Mkmf4mFuX3nraQkWEGUtVsDkXAPcRa2u0kzwXiiFTPyZjkdpnr81TacHZ1YuNg16fP+sYjL9EBA7Lbj+md0UUKbePr/1zy+VCIDDwYRB25vzPuoyrIM/XtZSeEwP7VoqGZPMWgmGjylHl1AVWVpt5XZKGz28cKvN3aNI6WygqWbldSLIjn0S6Nq1jdaU4AosoQB4UsighmE11kQeP4IzI8fO0nCTUG5/59Vi3AThwBwGXSyuYurEVBJ8jdJndAZD5qo+6p17nZY3XUqUgMXuDEEeFstJC33E4vAS5vMXC1nBsKIRU=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(82310400026)(36860700016)(18002099003)(3023799007)(13003099007)(10067099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u1/u1p61Ix9wBImfBQ7ZoaXTTYAeLTPAGI7ste6jmn/h/QQyeEzCnBnjMbl6d4PJ2iLbKvk57caTUzIw6dQDTOY4xbUayMimJjBWcnfRGPZb4Oe5lHqMNjbOPzCfh4pa9nD7qqH+Ds5jAcdNYysrR7QzxrItb9OidBUpRLGT8Vf0pWA/dL6pKxyo0BHPhsJTY1z7uYaWXNvsqhfjb5wz+qJ9tBFVEgFFrOEXPOkinhMOjHY/f6BOlNEJp5F9MkT9S5RnJZcvs6pyHSAuI5jQiKZvLt+JXPy9eNVmK3l2cduADCWXMF6xzc25O7vArCrxpAl+pgn5iArhoQILmMufJ/aEzTLcaJWljtwgC9kUwar1bbs9oD3osmrg2tTO7eXejMnvbJ9aPPYRc1gTvVHUDciq1UI9S2QfeejMdpRYkSQ3D968oEhpAJ22qAIPI8I3
X-Exchange-RoutingPolicyChecked: REUSBU1Jy1ioUeILNVa4vP6Ddi4ZmOeD55t2cAscCwd92qM6Q0SN49G0XJtCwScxCsd2nkd+CYuWI/pRpZFoXtQbxaaY9/jX2RGkVC4q/5NUhS3igMgX8+RoW8l6HwMEfd1u3aVG0lB/d+wt+XcHe8N2ywhUgiZCSYMOq8SQPDtbgp0mp9FKlLj3fujdkHSZLgjDqmUyb212dpOjUZSes7/80VUtY/84AyIhEjnvK2zThfTZI6p08UdIu8wxeWr8ursAnuW+1haSOAnMfEWAXJHaU6e9a4VHFMOlfna+DKUx2c/ulCinFBfnpQxbIuMjpMnt/wInW1kTf89yHY2C+g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 23:23:33.8065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f729b90-4f71-4930-75ce-08dee45a6bbf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6373
X-Authority-Analysis: v=2.4 cv=e9Y2j6p/ c=1 sm=1 tr=0 ts=6a5ab97d cx=c_pps
 a=e/sPstj0vE6DIEdYTBOJlw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=qUjewLGzuT5_s0WiQqQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfX8+dVF3GLjARR
 z12s+THRlcw8cZCn/sYBa0rpTuVsieIClb7Gzsc6bryHIL6WLx1PtsMc3H8zMEMM7CULVkfVqAs
 TbEIQWP9e6/tmixaDGO1DbHbGReFMJGu2cGYs4aXAe0NJMFMSTP806VUEar2GqxFNtl+LcXstUm
 xUT5pwHahJY3AhVqDdeQXaFP5/C1Fbs80WIpSw1awsGHgrgyZN1B6cQ9uX8fu7fVYNm/sZMVOce
 hPVVuTz2vln1P57AXjRW7BspSzHPJ1icRaR1ioFMRl++EO2GPLoVD4n9omd5AZmkYfx4PHYdjG8
 oNP0G3QQ67GFZdmoGLzcf6dscPat0GfqBC6832ieQWAMfVtWcrz1qprIupu9loxqsLP/XUjC/nC
 iGckKfmyZSgU9Sy+Nmj7mrVRWgdz32o4gIPogzkJissFCbiDym329KXb5+QoQKyxR/H9KcpHdPe
 QiDngxKzeGdP1QDE7xA==
X-Proofpoint-GUID: 28gE7mJj5ate243yKq7HhC9z_Gkzu5_A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfX0ubFNLKt6D2y
 G5RjsA+osNgCp3OjWSTDkpa5f9s+RzkN47UMJN30JnNuvQtwzLZ69lNm//x/LDl44xxsnZlwprS
 S8wfjiwV4IXM+b1ydeWSCkiReOe4wZM=
X-Proofpoint-ORIG-GUID: 28gE7mJj5ate243yKq7HhC9z_Gkzu5_A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170241
X-Mailman-Approved-At: Sat, 18 Jul 2026 17:03:16 +0200
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

Hello Everyone,

This series adds the initial support TI's AM62L SoC family along with 
the AM62L-EVM reference board.

The AM62L is a lite, low power and performance optimized family of
application processors that are built for Linux application development.
AM62L is well suited for a wide range of general-purpose applications
with scalable ARM Cortex-A53 core performance and embedded features such
as: Multimedia DSI/DPI support, integrated ADC on chip, advanced lower
power management modes, and extensive security options for IP protection
with the built-in security features.

Additionally, the AM62Lx devices includes an extensive set of
peripherals that make it a well-suited for a broad range of industrial
applications while offering intelligent features and optimized power
architecture as well. In addition, the extensive set of peripherals
included in AM62Lx enables system-level connectivity, such as: USB,
MMC/SD, OSPI, CAN-FD and an ADC.

AM62L is a general purpose processor, however some of the applications
well suited for it include: Human Machine Interfaces (HMI), Medical
patient monitoring , Building automation, Smart secure gateways, Smart
Thermostats, EV charging stations, Smart Metering, Solar energy and
more.

Some highlights of AM62L SoC are:

- Single to Dual 64-bit Arm® Cortex®-A53 microprocessor subsystem up to
  1.25GHz Integrated Giga-bit Ethernet switch supporting up to a total
  of two external

- 16-bit DDR Subsystem that supports LPDDR4, DDR4 memory types.

- Display support: 1x display support over MIPI DSI (4 lanes DPHY) or
  DPI (24-bit RGB LVCMOS)

- Multiple low power modes support, ex: Deep sleep and Standby

- Support for secure boot, Trusted Execution Environment (TEE) &
  Cryptographic Acceleration

For more information check out our Technical Reference Manual (TRM)
which is located here:

    https://www.ti.com/lit/ug/sprujb4/sprujb4.pdf

Happy Hacking
~Bryan

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Anshul Dalal (1):
      firmware: scmi: switch to dev_ofnode during bind

Bryan Brattlof (9):
      tools: binman: extend ti_secure_rom to handle op-tee
      soc: add data to identify the am62lx
      boot/Kconfig: disable fit post processing for AM62L
      arm: mach-k3: Add initial am62lx SoC support
      board: ti: am62lx: add initial board files
      configs: am62lx_evm: add initial defconfig
      doc: ti: k3: fix pygments warning parsing device-tree
      doc: board: ti: correct path to tcl scripts
      doc: board: ti: am62lx_evm: add initial docs for the AM62L-EVM

Vignesh Raghavendra (1):
      arm: dts: k3-am62lx: Add binman support

 arch/arm/dts/k3-am62l3-evm-binman.dtsi          | 226 ++++++++++
 arch/arm/dts/k3-am62l3-evm-u-boot.dtsi          |  16 +
 arch/arm/mach-k3/Kconfig                        |  34 +-
 arch/arm/mach-k3/Makefile                       |   2 +
 arch/arm/mach-k3/am62lx/Kconfig                 |  23 ++
 arch/arm/mach-k3/am62lx/Makefile                |   7 +
 arch/arm/mach-k3/am62lx/am62l3_fdt.c            |  12 +
 arch/arm/mach-k3/am62lx/am62l3_init.c           |  58 +++
 arch/arm/mach-k3/am62lx/boot.c                  |  82 ++++
 arch/arm/mach-k3/am62lx/schema.yaml             | 427 +++++++++++++++++++
 arch/arm/mach-k3/include/mach/am62l_hardware.h  |  48 +++
 arch/arm/mach-k3/include/mach/am62l_spl.h       |  41 ++
 arch/arm/mach-k3/include/mach/hardware.h        |   6 +
 arch/arm/mach-k3/include/mach/spl.h             |   4 +
 board/ti/am62lx/Kconfig                         |  19 +
 board/ti/am62lx/MAINTAINERS                     |   8 +
 board/ti/am62lx/Makefile                        |   7 +
 board/ti/am62lx/am62lx.env                      |   8 +
 board/ti/am62lx/board-cfg.yaml                  |  32 ++
 board/ti/am62lx/evm.c                           |  19 +
 board/ti/am62lx/sec-cfg.yaml                    | 380 +++++++++++++++++
 boot/Kconfig                                    |   2 +-
 configs/am62lx_evm_defconfig                    | 148 +++++++
 doc/board/ti/am6254atl_sk.rst                   |  10 +-
 doc/board/ti/am62ax_sk.rst                      |  10 +-
 doc/board/ti/am62dx_evm.rst                     |  17 +-
 doc/board/ti/am62lx_evm.rst                     | 222 ++++++++++
 doc/board/ti/am62px_sk.rst                      |  12 +-
 doc/board/ti/am62x_sk.rst                       |   9 +-
 doc/board/ti/am64x_evm.rst                      |  17 +
 doc/board/ti/am65x_evm.rst                      |  10 +-
 doc/board/ti/img/am62lx_boot_diagram_phase1.svg | 450 ++++++++++++++++++++
 doc/board/ti/img/am62lx_boot_diagram_phase2.svg | 525 ++++++++++++++++++++++++
 doc/board/ti/img/am62lx_tiboot3.bin.svg         | 170 ++++++++
 doc/board/ti/img/am62lx_tispl.bin.svg           | 222 ++++++++++
 doc/board/ti/img/am62lx_u-boot.img.svg          | 143 +++++++
 doc/board/ti/j7200_evm.rst                      |  10 +-
 doc/board/ti/j721e_evm.rst                      |  10 +-
 doc/board/ti/j722s_evm.rst                      |  12 +-
 doc/board/ti/j784s4_evm.rst                     |  10 +-
 doc/board/ti/k3.rst                             |  39 +-
 drivers/firmware/scmi/scmi_agent-uclass.c       |   2 +-
 drivers/soc/soc_ti_k3.c                         |  11 +
 include/configs/am62l3_evm.h                    |  14 +
 tools/binman/btool/openssl.py                   |  11 +-
 tools/binman/etype/ti_secure_rom.py             |  32 +-
 tools/binman/etype/x509_cert.py                 |   4 +
 47 files changed, 3461 insertions(+), 120 deletions(-)
---
base-commit: a66e02d219bedaca5aa8abaeac279c634dd2587d
change-id: 20241025-am62lx-78cce63f43f6

Best regards,
--  
Bryan Brattlof <bb@ti.com>


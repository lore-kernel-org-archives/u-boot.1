Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B49CDE000
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 21:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C847847C8;
	Wed, 24 Jun 2026 23:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Urkgo0h7";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CJHMbiIl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0690849ED; Wed, 24 Jun 2026 23:20:12 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AC7F8460E
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 23:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65OJs7211056266;
 Wed, 24 Jun 2026 16:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=FjDSc9hxHc8Xz
 RU7Y8VkuLn5Sc4JBHgHJdAhy75hcJ0=; b=Urkgo0h7NMe6NfGKLLfVsoxe0et8y
 Y9Fwap/okRTBOYHwaT5qpV/0krghPv3xw+UXTQPunjcnDl+CBvj22FaO9VZOoTyh
 rgoElAlOTZLSZR9Ymz7XBOHorn8qR+9WZwVD5UoVQgZK3sg4yig02Gktf0kfuRE/
 cd/PAWcEhWtPbXsN8TfacxD92S2q3BE7d6rX9sIAr4+r0RtYeowbXgpLVBreAIGL
 pPpUEJvV6NG+MzY6tloCBuPjP/PY7mPD/eI8HcDYOReMBXBF/mtDxRCjIYs2eNt0
 mmJWyg9wsZFlqezzi/mgGHSND3H6vZgFmwxw0RlV4FL7XkEk1lNipUp/Q==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
 by m0380145.ppops.net (PPS) with ESMTPS id 4f0e5ybu66-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 16:19:59 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4aQFwlEaxy6Fn0V6Fpa2NwL0ymyAI/xF59/ucD4+GbzgWElIFIt/aQ5ZV8yLVdx4oXVgehhCEUQfHspeT2eKnV8B4ix16aygL30HTxTZ33QkUl3wLk4uHe9TTHiyUzffZ3Y9yCfu/jxOHw4rQbAnVzi0aheMD3L5ZjVktu2QPXFydExQ6j0Ef781lLE6iclxuu1DNlkvKNCwLXAB8vozOyWGTIzhH86CIZcUL6biCV5vQ1+FezBTNZxmIut1OvQijRHmOA1Vf7uOo6aeQfFBbXZ4M6x++vu/G8aEmULMfIFkLvIvbywyfFwjGZAGFHW1re4NPIh18H3BvJhneSDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjDSc9hxHc8XzRU7Y8VkuLn5Sc4JBHgHJdAhy75hcJ0=;
 b=QgqoYe83LpmfliAfSKZ4GstflTDHbrfEKgWFPamIHZ3d9bwWpUaF1RaBPcx/6zhfu2y3s2L0HsHr/QhUclERsHFyvfPBhQauzxR0cRA+lQ4yszZoO4bnnsmSiugCrHX0bwErBxgI7kZSlqlOcIXbAtl/zs8ygQUSQywAGEPPpBef1WWHBQB6ml5WFp6wD8McjhIPzKg/2d75KD2lUsufUGXXurUvm0Jp8QSL2BNt1q2UAaqR+zJ1mVq89gNnohF07tHu7w0hCeshoKVwIRarYAsySpruTJMNda7RpfebXI6jZaMTIkzDpWntqfDR2VZ2wlXSxngVqY04tQXWFHs0lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjDSc9hxHc8XzRU7Y8VkuLn5Sc4JBHgHJdAhy75hcJ0=;
 b=CJHMbiIlfTVr0sd3KCnoe7AN7iBCLYLjcZPsXv5VmqPgrq5R5dPeBTl1FVanYw1s1GaKx5d+1gsa/rjI/7j/cprrOxT9gILxVv/Ep0Q+jnhehK8Yrwms2Sr1cEKHin1zlIMrWwCh+09rz3DkBz3/peOoryjwVdJaw0A04PaZ00o=
Received: from CY8P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:930:6b::19)
 by MW4PR10MB5863.namprd10.prod.outlook.com (2603:10b6:303:18e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Wed, 24 Jun
 2026 21:19:52 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:930:6b:cafe::9b) by CY8P222CA0021.outlook.office365.com
 (2603:10b6:930:6b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Wed,
 24 Jun 2026 21:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 21:19:52 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 16:19:51 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 16:19:51 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 24 Jun 2026 16:19:51 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65OLJprC1851589;
 Wed, 24 Jun 2026 16:19:51 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv3 0/4] k3-am62-pocketbeagle2: add board and variant support
Date: Wed, 24 Jun 2026 16:19:45 -0500
Message-ID: <20260624211949.327905-1-rs@ti.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|MW4PR10MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 35bfb0c5-ada9-40a0-d42f-08ded236549c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|13003099007|18002099003|921020|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: xVc9sclb2snKeiBDtyl1g5tYBL/nppQ7sCzpp632o8e48JCcA5NlynysG7gDG58IyoemVR+DPVN8ZQrhDti1VH9LW9doEv+jrZiLISZvn18V94FPfnoL1Mkb49VmtiYF8eqBw6y3MJcdpC9XVDFQJGoZ7DSFPZA0goyWGuq/O6aDXLOxEqQQoLM7Und9b+sYgt0r8hXwiiurLaPkzHxnTZ7e08Wcmovzo9pU+Ou2zC7t4p53cagm1IA8XsHRQTmxbuuSQN+6BWvyZTstU2JT66XQF+NtlsCBoKiwJ1Ft38VNb/g1A+wi+uC3hv+LGIZzrxzQ+UVYrYHBVtSXVYSPXPMXDl4fMSupkBpzW/g3K/GKOZfRlqEF6vYqibz8pgfnJkWOPwuNT8Tb2DD15xG7HY7pnlREXxc+jKZtzAcHsaRhSC0xCT/ajiP7ZaMWA0VarVD+LnLBArQHajcAVMaNY7J6ysDkMsmp4dOxUD/qIM8x6vQSkeRDGChdC/CQOiPUga3+cbo/MjkrglfZKVLjhfXl8nQc5jCYBP/2jab7RCokZHPGlxNNykthZK76XbD1pPiKkp5VicFL0M5WzZ1NFqX2P15xQ+t8q+fV9MB2vhRcQ0TDYWLmYKK/DiLvpUhFAbtgN2QBuMvW9N2Acy/QMfMm+IWS93ifrgV0dsF+0R8M3cWiUO4aGy5oj74uLMIVhZHuaxEQ6QFrminfXE653fOcg2W9MLGVZSQiIyhMRe+gWFTdo3ID5K8SLt+u8vIK
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(13003099007)(18002099003)(921020)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kTiq0oSJqZiEJS8WO1B5GfOiALD9sKaP5b3clNEmmrjAXXSH7CcbTHmd2ZzF0wxYIAmfMQTNThpxi6+jbiIZe8mBw6ikCvIFgKi1JENOF/LFX4e4R4niPNiqGijEi5xDHb4wCbxkbWzHvU7K8QDRk707FRtLVU/CpV1ZRjgADW4u5QwCdMjKNCtf3cTZJxfolnKmku7xyP+0OCeie1DzJQirjKcGnYWhdvWX9bwNNahZOil8so4dnzwzzuAnukdwOdr9xW8EfyMK5SuhMLOUc0zFJ+XX+f1iU5+K/XRA/O6/np6BXSeTu7OykeW2xF3wGZBFm0z5KalZOFduYE7xFZRlQGIaossA8Ny0NeGY/erIL3bohjxpzXpoSXMh1IKSe9JGF+FZqNMvLh79tRobInQHKV+1uEIJLAvQIcpNhUAQ9YCIvkuhkS3sFDuZlt2G
X-Exchange-RoutingPolicyChecked: sADYxPWrc+Y4uzKTPtdPxfdz2T6pIZamXkKM56AvxkqHmr2YigdCEBK5afJ9xe3Q2RdVFoRJ6n8GUy4qnftYRS7wCHttbDI2Os1s6bqe3PxKn6lhBenqJ2wbSJWDn3JiHADReJIz519/USqJUi3Iguev88EZRd64Rj1MytsnJyYVoBZfMz7DEB966EnlSWPdFpVH7OW7lmZ9WFk3wrQgGlGovqPwCpP4tGLFKMg/4QYjkSzS6PB/hjnt3jNsoTwMl+bdadPV7+xNMF64fpG003TloHxk3dv7u1AuaxtZUJm5a7U3LcgicLYtzpvUq9yGJ8M9dKzuk4cFLzsvo+2RrQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 21:19:52.1908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bfb0c5-ada9-40a0-d42f-08ded236549c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5863
X-Authority-Analysis: v=2.4 cv=R6cz39RX c=1 sm=1 tr=0 ts=6a3c49ff cx=c_pps
 a=1kzZLs4G264k5kMmJ/E+Xg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=NEAV23lmAAAA:8 a=sozttTNsAAAA:8 a=fGhLjsSNAAAA:8
 a=FvgNnJ6L-cHGxMVQW6QA:9 a=LYKFdyShAPKLkGq8p7WX:22
X-Proofpoint-ORIG-GUID: _Ck76gu6FnIxlPKi0VuhptRmQad4oLd3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE3OCBTYWx0ZWRfX4xGNMQMcfqAY
 FF1gyKiMQDI3p5IS8jN88Wkzg2gEJRhgBuy3HkxkxIMDnzMS6ax0vk8baRR6c54HumBlAulQMYj
 YCDGFmoppoHtRLSXe5KoFGPFCI5LB4s=
X-Proofpoint-GUID: _Ck76gu6FnIxlPKi0VuhptRmQad4oLd3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE3OCBTYWx0ZWRfXwSHJwQQFP4ap
 XVtf6hQRpuLZSnCA5ztIrPWpZjA3iNoqEHJcFahZYq4yIkNDuCVJVHncMvQfvXk3QlFkQ6WFtD8
 60PA9Vfwp03RkNh4FvTP/BXtaWWKTE9yQGleUt+AdRfmLaqjua4jWhHqDzjZk+euj+2bjdRZBOe
 XJcc7YjhT4TLy8IWpJICMaqWLU+W1KHBSTAK3i3ec+eKlvAZmAOexDyznpEw+0tw1DsUKR4FPB8
 bO5+gWYKGYx2tlVqL39baHlDXLY9paZhcdr1T8t7y54d1m5GL6vUMbDSgRscoUWMURebx0JlohC
 pZAYT9sQULsHp60A4lQo4e5wcFhQ0F991fhhb36m3bHv+no1Vba0gOAjbNBVxLnA1yaf2u8RjKd
 4lsYD8QXPU4S5OI+8W7DcnK5NQFOiybEqvoNrUYnsybCAVNeBL61mZCOYeDnbvIlrTdEQHJ71DW
 y9ortJaKVuegW1wW0Uw==
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

Add initial board support for the PocketBeagle 2 from BeagleBoard.org. This is
based on the current official series from Robert Nelson [1] and work from Bryan
Brattlof [2] with some light modifications to protect against certain
configurations changes.

This borrows a lot from Phytec's current DDR fixup logic, as that seems to be
the most complete implementation of a dynamic DDR correction for K3 in tree
currently. Thanks Wadim Egorov and Dominik Haller for setting that up.

Now that the various memory issues have been resolved we can clearly see at
runtime that there's an issue with the current device. One of our reservations
overlaps with the u-boot stack. To get around this we'll need to change the
relocation address to something we know will not collide.

[1] https://github.com/beagleboard/u-boot/tree/v2026.01-am62-pocketbeagle2
[2] https://github.com/bryanbrattlof/beagleboot/tree/b4/pb2i

Bryan Brattlof (1):
  arm: mach-k3: am62: add &main_uart6 to clock and pwr tree

Randolph Sapp (3):
  k3-am62-pocketbeagle2: add initial board support
  k3-am62-pocketbeagle2: add support for 1GB variant
  k3-am62-pocketbeagle2: add support for efi capsules

 arch/arm/dts/Makefile                         |   1 +
 ...> k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi} |  92 ++---
 .../arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi | 336 ++++++++++++++++++
 arch/arm/dts/k3-am62-r5-pocketbeagle2.dts     |  35 ++
 arch/arm/mach-k3/am62x/Kconfig                |   1 +
 arch/arm/mach-k3/r5/am62x/clk-data.c          |  19 +-
 arch/arm/mach-k3/r5/am62x/dev-data.c          |   5 +-
 board/beagle/pocketbeagle2/Kconfig            |  86 +++++
 board/beagle/pocketbeagle2/MAINTAINERS        |  10 +
 board/beagle/pocketbeagle2/Makefile           |  11 +
 .../board-cfg.yaml                            |   0
 .../{beagleplay => pocketbeagle2}/pm-cfg.yaml |   0
 board/beagle/pocketbeagle2/pocketbeagle2.c    | 185 ++++++++++
 .../pocketbeagle2/pocketbeagle2.env}          |  20 +-
 .../beagle/pocketbeagle2/pocketbeagle2_ddr.h  |  50 +++
 .../pocketbeagle2}/rm-cfg.yaml                |   4 +-
 .../sec-cfg.yaml                              |   0
 ...onfig => am62_pocketbeagle2_a53_defconfig} |  25 +-
 ...config => am62_pocketbeagle2_r5_defconfig} |  16 +-
 doc/board/beagle/am62_pocketbeagle2.rst       | 279 +++++++++++++++
 doc/board/beagle/index.rst                    |   1 +
 include/configs/pocketbeagle2.h               |  39 ++
 22 files changed, 1132 insertions(+), 83 deletions(-)
 copy arch/arm/dts/{k3-am62x-sk-ddr4-1600MTs.dtsi => k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi} (97%)
 create mode 100644 arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-am62-r5-pocketbeagle2.dts
 create mode 100644 board/beagle/pocketbeagle2/Kconfig
 create mode 100644 board/beagle/pocketbeagle2/MAINTAINERS
 create mode 100644 board/beagle/pocketbeagle2/Makefile
 copy board/beagle/{beagleplay => pocketbeagle2}/board-cfg.yaml (100%)
 copy board/beagle/{beagleplay => pocketbeagle2}/pm-cfg.yaml (100%)
 create mode 100644 board/beagle/pocketbeagle2/pocketbeagle2.c
 copy board/{ti/am62x/am62x.env => beagle/pocketbeagle2/pocketbeagle2.env} (64%)
 create mode 100644 board/beagle/pocketbeagle2/pocketbeagle2_ddr.h
 copy board/{phytec/phycore_am62x => beagle/pocketbeagle2}/rm-cfg.yaml (99%)
 copy board/beagle/{beagleplay => pocketbeagle2}/sec-cfg.yaml (100%)
 copy configs/{am62x_beagleplay_a53_defconfig => am62_pocketbeagle2_a53_defconfig} (88%)
 copy configs/{am62x_beagleplay_r5_defconfig => am62_pocketbeagle2_r5_defconfig} (86%)
 create mode 100644 doc/board/beagle/am62_pocketbeagle2.rst
 create mode 100644 include/configs/pocketbeagle2.h

-- 
2.54.0


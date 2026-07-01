Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86EFC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 07:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35FDB84B22;
	Wed,  1 Jul 2026 09:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CMT0XBtT";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UMbmhmpl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E30184B2B; Wed,  1 Jul 2026 09:50:41 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEFC484A7C
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 09:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6612uQlN2538178; Wed, 1 Jul 2026 02:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=Xn9DN6jKn/4WG
 Dq4vd3S66jiHCS32qsOs7f7a/9zjiA=; b=CMT0XBtTkkPaNBSGNJPHvww4GenJC
 wRCkpNp88XwtCYxAZXY831ouQgl2kYXnJVwbaXN5JVcGBnZ+BFiqtd6TXbpKmi/V
 f8BAFMisIs0zRGo/mxYidmsm78TQnTRUiX5m08Eg3ibqoip7QF+1kVbiwUjuQZ7u
 Pm5Nsx+q1Hdlgf4XjG3qUohS/5my5b8WR3aD5NC2trReMWBJRJCdj6yqqSPM46Y3
 C0Bs+tJSmZmxvV7Ct9mCUOL4wR6N7b5zc/7rkiTOeZx4/CCj0/F6KlBdBJzQPMNF
 y8aUSJUD27HDYckNBT+8fnRJprjz3P8Td5GYdt2AxihoZBt+YDxURT1Fg==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f4nva2xgp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 02:50:34 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyrC77Jq7UTBd1VYH2HGP++GSvGHmB7hJz+O5J5rFsQRtsLshdxh9zxrMNpjBNkfgQbLiOmvGnAJIUyYeHJOqSX3Skg9BgM9S6J4yof7JyjuNvLSLLWCa7duwmKBtKafHtLEyBzhCzTIdMp873nhjBzXRff/DRzhuvoKgBY4oyHwMOLYnR7C6y/L3r0+R/I/h89ZYklf/IuYOrg2zULjdTjDopzs7ytLB67F5DT+VAvYIUX3zAWp9HVUrvfZJV98MjNSTG3A1Bw7E4c/DPvG3q4SCOS16xmCYfBGyZwWY6nC9DfJ6kcg9qnwplXlSmWdFbW+5bZetoJ/dFtfwyyjeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xn9DN6jKn/4WGDq4vd3S66jiHCS32qsOs7f7a/9zjiA=;
 b=qXXK+Z26d4i7ceYja5CHbb6PfhJmczWoBN7gQv1cN1+6mqo3kBxbcTj0whI1/Zw0QOqLO79uhzWkkB27DSl90VIrmJGar0hiPcWA7iUE8BXE8TBYyO/S8DZ/SxYEhACjr/OYjF9IOqpOpgah5eqG84lyVXf5PsIAe3G1wu7UtuPVAZrrzJEd/ypepEN4TJQWarVHGXNmkCbnqMrE94MSTwsHGSuYHOVwg8GSzW9MbrHIf5OoY2JpGcYp3TP0TBa4B3iJaV4g/vB9JUr+6GpvX4Q0CMEsy5vU8WNQGXi+opuhYqFpIN/4OvZeNyrz10tGyOJccd9+euJurt+XK29WDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xn9DN6jKn/4WGDq4vd3S66jiHCS32qsOs7f7a/9zjiA=;
 b=UMbmhmploDYcfpbJGL1xDeFhol8KgPo25VtCurbDwaOkXpEQKcNBH0Zdr+zu7iOgM23x5rP4Z+qpjxR69AXIbRRCczXRuQRVbSGvoyLwpp8j5eIsKG6fr9BBdIdXMVkUh2ZF5Yz3fltenj+qRENmMeTL/9hCxTktsvgrUyIKoW8=
Received: from PH7PR10CA0024.namprd10.prod.outlook.com (2603:10b6:510:23d::13)
 by PH0PR10MB4454.namprd10.prod.outlook.com (2603:10b6:510:3a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 07:50:29 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:510:23d:cafe::75) by PH7PR10CA0024.outlook.office365.com
 (2603:10b6:510:23d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 07:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Wed, 1 Jul 2026 07:50:28 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 1 Jul
 2026 02:50:25 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 1 Jul
 2026 02:50:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 1 Jul 2026 02:50:25 -0500
Received: from localhost (ula0502350.dhcp.ti.com [10.24.52.241])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6617oOL5857227;
 Wed, 1 Jul 2026 02:50:25 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <msp@baylibre.com>, <v-singh1@ti.com>, <anshuld@ti.com>, <afd@ti.com>,
 <m-chawdhry@ti.com>, <joao.goncalves@toradex.com>, <bb@ti.com>,
 <n-francis@ti.com>, <sebin.francis@ti.com>
Subject: [PATCH v2 0/4] Add DM firmware reserved memory support
Date: Wed, 1 Jul 2026 13:20:17 +0530
Message-ID: <20260701075021.3626094-1-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|PH0PR10MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 519c5727-94f7-4eba-aca5-08ded7456b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|13003099007|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: c0y3cHMn9iG1DIOSx0/x18njNj0qh2zsVMVii1HGhMqW/w3JXX4OCcpP3lHXCE4EAb4DHFjRqb4Yq+cAwxowQH81U2mvLWNYyQrAqzI/AkExNZ/nA5hMaPnkQbgZbMGTtHQzFiKwtZSMtBcFkNjAFx3EbR01DljcQSpZeDZlRuDD6JF+RaHojA6fmieZe2QeruvcZKJFzrnhWxWyoKbQkjTXIx80KHRcNhNt6gOzVVUiTav4R0zML4oeQhYfFiyzBr+GxDEE7inR3CXFPWjWEU9w+ZicYI0ZbcC0WozzWfHp+Zy4znHDEK34toFR2rkxifuIhWcMk7JBclCBD8aw5UEzrxRivyfAISl1kJuDeLzJ+nHn8i5mmCZKWGYhDCJZnm6/TZjqs/m0mI/WTkN476qzUB6g8Xuq1/I4ax55Kkk907bpaVm9iYT6T+hp6OZzclFBaex6eEeH5KScnmcAjuTOTCcaXk0xSZHQOGlY/jbUvqQAsU2NSrkGQHeLITD5p5BQGTTrJJ2o7FNEmFb7UNDSzh2Sbc8gcFHAz5vlr56Nj+r9iCfaxj6u3PtRz3p5+x1PxbTSU1p9oaLUBG/R5USuGaQrJqIrlS4hNfrOAj6Yp36gzpyfUZNnEJtwusO4HRNBuG+IYXGkt76MCAYn+yLLBT0YDUZKmbaSNPPPNMNyUA3XgR8ZtFVULL8u/BXkXiQUZvLE1/pGXw2Jvtb4eg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(13003099007)(18002099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p+krSc/2AnBUduJWLvZZQu7U1Y6e0p2uzattJ7AN8CROnyKeGkPVPY9mI63gzKVrdHgqmUGpC4NpHBf9Ygs2iA+2jBPq4yZwnf4/NrBr7T0r/9vJKM8SucbVaSI3yWn2zE7jM3pbKTPd2JykJbkPJFrfvef98YqwUaETiTnC7NfYTN9fwMR8m6zHUiu+ZYHF/rz6B7haCBq3GIJykQjVNDa6OhpIpojyeM/Qi4Ee/W/CaS2SawNCdZ1ek7uXqQh5BC5gSuVxUDzvKJGspgbLznaQb8xJA+euchUhR9SNKeA2H2VyeZA6qts4ItKmHxkqW5REyPNOYMFz4d/bMbpm9W8HHOYDBKrujW4I/JslPimbaCl1h00PdsmrzIwI2cZV8jALQeMOOuby/dlBt1fVp4hVMTiBN5zOqNfHwsmzfA8l4WLrfONsSHrbX8NXo7vw
X-Exchange-RoutingPolicyChecked: qzPcOX2SyRw7t101raPXFGikpcRlYgTJFA4K/x4FpTXujLHdYKoctQ+4E710TKmlrlS7DGVekx2rfXO4cqxGrXz5TgyxqAiOlf+p7FGhO4lxYkQt9fSf5M9HGbyo+TSNh0mgO7o5X1u1uwJbLU9C6ItbdTA/njJfmCyPq9VAk9tfd0+PbecN4JxvGKdfhAQnGNUqgaRcd5hZ8h7EaMddGJ0G6f/JPdhKqeMPD+TFPscTua2/2Q3a5OVwEhLeqSiSzdZidVWiVOFG9/4Do3JFfGGL7tPtt7sCBuMOKz/EMVAr0pb1Dq5O0f2uNEDhgECNVeDjMbFHTkIhTyTIU/0ljA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:50:28.7985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 519c5727-94f7-4eba-aca5-08ded7456b7d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4454
X-Proofpoint-GUID: zXzWpiTJfl_oeHiTnlq4vE0GgpePyG-m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3OSBTYWx0ZWRfXw/+LXYKzViUx
 oTGNRbXE1xYqSv0l9IzXkD69YsNE0GeIPbaLP2nXUNXttqdZLZ2jFVFNbj0EN/j3U7ATzt2D66n
 Yz1cmF0L7g6LvHg8L0qLqV0QkL5CkNMSw9OTdbh57qb0zK+liBp+jI5sbkiOXJUQS1w2qr/Xe4O
 aKOO13rhByyAM5GGARMwqarVd69iGuO5L7hBjSYvVgSjwBxNYpAl5VKTf708nlDak1F+9AfvKFD
 JXsyOFSFXbS7jK4Q1G30VZunp1yRp7wcfh0qxxbgGnCP+5rk+W0P7be6dfD9a8trjV+TjyTyOxk
 9gGJ70rT6HTlOVaZOSIYcX6rfXDm51+jrYpqy+VoU1DFVrKG4Kur4lafSWhA1gE91Cq3jjo9o6w
 Cc5aSfz870BSAtesl3DsWIJEw4iAWmCmgOz+6awGEe0eq4+SQAICXn33NmTz7dHDv3N3hLSH+Bs
 LfqQJnqH4+e47dGcSIQ==
X-Authority-Analysis: v=2.4 cv=FqA1OWrq c=1 sm=1 tr=0 ts=6a44c6ca cx=c_pps
 a=WfYMUjdTTdEkkNza/pHfSQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=qA62vmWQhObmOO9j8o4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3OSBTYWx0ZWRfX71hS0TIz5pNS
 5a7rCg+bD+PuQ9uWezzkDGl0ywaqVB2xzELlZl/MGCPlO7xp2d0HYD8k8wGvUbXA3bFWlrjKzmQ
 KkkokrpfATkaKwFS9YjoCXmqE5bFmvo=
X-Proofpoint-ORIG-GUID: zXzWpiTJfl_oeHiTnlq4vE0GgpePyG-m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1011
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

This series adds support for DM firmware reserved memory fixup in device
tree for K3 SoCs that use separate DM firmware (K3_DM_FW enabled).

The series includes:
1. Fix for phandle corruption in FDT reserved memory fixup
2. Enable OF_SYSTEM_SETUP for AM62D2 to allow device tree fixups
3. Add Kconfig options for DM firmware reserved memory for other K3 SoCs
4. Add DM reserved memory fixup implementation

The main issue being addressed is that the current reserved DDR carveout
for DM firmware in device tree is insufficient to accommodate the DM
firmware binary on AM62A7, and potentially other K3 SoCs in the future.

Currently, the size is only modified for AM62A7 SoC. For rest of SocS
existing values from device tree is taken.

For vendor boards, please verify boot and check for errors if any.

This series depends on dts update for effected devices. If "dm" node is
not found then the existing mechanism creates a new node with same
address, which cause memory overlap issue.

https://lore.kernel.org/all/20260630150919.457160-1-p-bhagat@ti.com/

Change log v1->v2:
- Extended DM firmware reserved memory Kconfig support from AM62A7 only
  to other K3 SoCs.
- Added memory configuration for all K3 SoCs
- Update fdt_fixup_reserved_memory() to remove redundant code.

v1
https://lore.kernel.org/all/178219072988.1099376.16053199642199625548.b4-review@b4/

Paresh Bhagat (4):
  arm: mach-k3: Fix phandle corruption in fdt fixup
  arm: mach-k3: am62ax: Enable OF_SYSTEM_SETUP for AM62D2
  arm: mack-k3: Kconfig: Add DM firmware reserved memory configs
  arm: mach-k3: Add DM reserved memory fixup

 arch/arm/mach-k3/Kconfig        | 21 ++++++++++++++
 arch/arm/mach-k3/am62ax/Kconfig |  1 +
 arch/arm/mach-k3/common_fdt.c   | 51 ++++++++++++++++-----------------
 3 files changed, 46 insertions(+), 27 deletions(-)

-- 
2.34.1


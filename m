Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1D3C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 10:23:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C69084A63;
	Fri, 10 Jul 2026 12:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HTCyIQht";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BNDZuAix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8507F8496E; Fri, 10 Jul 2026 12:22:56 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E76A8496E
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 12:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A83sIF3354930; Fri, 10 Jul 2026 05:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=99uV2b02ToEC6hBU9KJudYlQNhM551XQVtIgTtEFh
 /Q=; b=HTCyIQhtUAjQa0kxqi3xWX7Ps/9SuLnS3Q9LrNbmlZg6Oc+Srfi9HvHE/
 XIqRtIVO3JCDDEcTe7ElraSLGUroT05tEukxGGmL4mgN+m7ByEP44VCyEDGEV5Hd
 ca1HXiDkclC4IS9Qk9MUF/2ocCAkrDoyA8/t7fWL7V3T+VCvMKsdYQ2/kMPan3c6
 vehMOqcZjncXE742FGshH7dgsxlLHKqwN1A7EgcMize7EMMzSgiYmFKT4KvGcBMU
 LDL+hnCitud1E5ss1HUv9xcW1NC+KzmCDxoCLBZBf3WhzDsqFcRhipSMFY29c43N
 WpPTBhCC2Kg13cCk/68aPsDTKw9BQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013061.outbound.protection.outlook.com
 [40.93.201.61])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4faskvhn2x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 05:22:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlN2grEmUGvZ42Znkw8GmchWXKuU9tgC4hUnzzIgBsKjCjoZDGyYACM5Wk5SoQShut/0/aG6xzPRvFI52ZXL+uEkUOdx9fls0/0hXTG5dwgyDYY/9lEqNx1Cno8e22f3J+vTN+hrFeptBN6Z6DaShwSfZ6+fEsBmfNcEQeqrWVaQhsJxtfyCH3G4FRy359IdkncQs8t2yF4MQA7wuXr80nCSyyCbsKpnwSww9M9zTt1sXOL2N2Mases4mOCZJWUe3HHNWRt8eNtV7NDtJ0ZKVRZ7DID6kZEWUKRJk+TJau9j3oi15Y4qaydJxRHUPd7ufn55JZ2QOUpfAubDyNqIqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99uV2b02ToEC6hBU9KJudYlQNhM551XQVtIgTtEFh/Q=;
 b=UePxWTmi6z0TZh1bBIfBgCys9D0AP5SvUL8v/pAvYYhJhuQ5QfUDkaRiKQKBBNEfTqBs1/rugzwgh/wigYlfGcxHja1afadPZcLsfupSzs04rYKZSPcEEgc6psxnH5y+Fssvxb1K4BbPBcbzkgYFhhxtFvcLGxwWPACHSWWKlz4aeZSM4umzHMwNV33ztEx90dy1cH4UcbO9GHGk2bb520A9XQtB6eAw2+vXqMSt1D7/w7/GaBKdzNeLyvy6u0lCfR69vys6KW/QVrO9IEGVDvl2BfF7k2cWHtMxSjn9mpWkyJ82rtj44kBrjRCWdi5DA6i+na/xvGxkwaANaRf3Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99uV2b02ToEC6hBU9KJudYlQNhM551XQVtIgTtEFh/Q=;
 b=BNDZuAixTSZ1plCpKuCxkRec0jUB+Jk8vawS7otcTKRF/YfeGLGKaQWrok+SRH45JVySRWmoEnkysazKvAgp44hNqM58zRhgU7gpIDP25Jl8c6ZB5idz6nuf685AQOzzgFdUeWhTcD0uRAURKM5VfC4FiXa3/mNCublAj3ZB5Ag=
Received: from SJ0PR05CA0197.namprd05.prod.outlook.com (2603:10b6:a03:330::22)
 by PH3PPFE03343C9B.namprd10.prod.outlook.com (2603:10b6:518:1::7d0)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Fri, 10 Jul
 2026 10:22:48 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::7) by SJ0PR05CA0197.outlook.office365.com
 (2603:10b6:a03:330::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.3 via Frontend Transport; Fri, 10
 Jul 2026 10:22:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 10:22:46 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 05:22:38 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 05:22:37 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 10 Jul 2026 05:22:37 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66AAMaOk3465096;
 Fri, 10 Jul 2026 05:22:37 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Anshul Dalal
 <anshuld@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 3/3] arm: dts: k3-am62a7-sk-u-boot: Enable DM services for
 main_pktdma
Date: Fri, 10 Jul 2026 15:52:29 +0530
Message-ID: <20260710102229.2980029-4-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710102229.2980029-1-c-vankar@ti.com>
References: <20260710102229.2980029-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|PH3PPFE03343C9B:EE_
X-MS-Office365-Filtering-Correlation-Id: 336db2b8-b7aa-4c22-ac29-08dede6d2ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: IJbaUfhPTL4DyPI661+MJo+zttw5R192DDrl/um1t+cXeXceTrBV8Tbek3cs65z9MszFbiTRbFwX34Zuu8zY1fMuO+7INydYrT44nrtSdqFgri4N82XpILUpBYSCgGlkdz9G9LBokXmp3kYjxToGf6Gy/ExC1LGH+R/UugJ4PXgqcYBMqYqUgfcjUSdHdU7XiHGjCuI6mFiDKQ+IcRnbB9zUL+cbcHfDuSBY2JgaI2m7xMxxILp5Q5ubo4Z+fnCWZ2nvmBgfGQWwDwG7zA3BaCXjhCQ2NpCao9sP7u5LzBtcO1jiVHs7WRmqy9z0b9zO3OPmaSRkpiA5GcFi5JEezDzIzCI5QZljzo3ykEthCjb6fOzVJwD3UHmtYZObpw6zltxMwBgnk1thiAEGNvDQv4DbN7iULWM5PfFR2Gp8Tp4MeTxacoHQ6OuF+lAQzBBCiMFE5+KszN0swDCVAT6ffR8PwMtfxT3J6z07/7iN8x2H8qiexx8aFczKtNDUZZ4pVfbWu3TwlpLET4LycuI73f/mH0dLg9rKzntu4CkTuIcbdQwGQgo4uwFvNYi1GeaXdJgNH/oRlIQP8sd+v3TWNzZiTaDaAENHzuKZIRODzDK/umWk3MLYCT4SQImDD2sZgi/OiqUWunHRv1mlujx2vDfdqOcr3r3XlHteipexa1cPY7vQWYj4LKHxzXkzOJZ47LF/FSyMhe/Wm1VtkEgD3Q==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +xk0fKDwgh8MN2ptbdYcbuumypXZS1aPDDfu6AmPl1E8O+m5hK2o4eTwLSZI3F8g5ykMSqCRDAFTd3/rYT1sSRdkTTuXGD7L3rdN4rLlE2Eqng/GfehSM+/oX49R+rGZ7PHP0sKrSG3dhByJCZE6g5Fvc8Tx4lb5e0UeGg0pg8hU1IvYoPuFg/+w883yIp8HLYBKsvCfu79+dD4zu1EyWWHOUaOWVB0Yizev6xZ9/ynctibhkjuqwNgBZuVEBm0qCDZW54wHAnc4Y7OSbx9iunQ30iJMNCjvpy+hB8tabLrYBbPWyz+mbdLRQyizMVpuAkeTZHRKXj+JStWykwRY+++4/gt4vX0tz8oJTE1CLp+mLkgZGXffb1+OdZ7Ll3VopFyjgGCN9RwL5cNqzAhs+48qXydosrB0J4hiSClNYiR1dPlvJifj3RpabGncjjPS
X-Exchange-RoutingPolicyChecked: FOWYwU/1421PuXheHJXzc5KR0frMGd3NbCi+wu39xkrozjbO4WMEJky31MxJ2zSLDEzjX8O9xzAsBQlwhHPLdavw5GB5DeLwwp/Z34JrHJuoYOMECnvOOVzK7vrWxyR4bNyob9FjY2E3Xw1sm5ajDp6oJe0Keh5A0JbUXPHBhdC3OfKpOK6Qz1AWhGbnVWPG/0+NziLYR1nYOQJM9YA5SRE1gnSfFeK/1dskP1GV1g3D+X9XS9eUk9ZKic973RdF5qvFjcLw3vSMT5r5aQ8AYyvUfMkOko1+9kd1fBLZJYOtI01q0AJeL47Mne7qmozF3te+Q3g3Bvy13/bExGKP4Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:22:46.9245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 336db2b8-b7aa-4c22-ac29-08dede6d2ff4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFE03343C9B
X-Proofpoint-ORIG-GUID: Aim8c096FOMwCVgDK7avhvAaP1ttE6qO
X-Authority-Analysis: v=2.4 cv=AeOB2XXG c=1 sm=1 tr=0 ts=6a50c7fb cx=c_pps
 a=fvoc8Rb8ruZSznP819E46A==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=m0yEv8o74bc4KniaoOEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEwMSBTYWx0ZWRfX9nbKmnX1iyxp
 XHQ0XpcsS2gCELF0As2XFMrnLw5ZWvCXDr0WdxXXPsQ7tCLOpjS7LScP8ZT18c8dq8CJFy/YLc6
 EUppZevTjqgTEek/irhreHD9Qi6qWow=
X-Proofpoint-GUID: Aim8c096FOMwCVgDK7avhvAaP1ttE6qO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEwMSBTYWx0ZWRfXxVxb7u0Dg4nz
 7RSd9Xq5ZBYseIKWVSukMWnl4EpSlpWhe5tbsbMZaYMxZ9m2WMllR+k0YM4/Zr+knHbDvPahSry
 jQkxysLbNik8MJ5uNnK/jaYKVtGrHxgOtLAe4018JZHsX3ohk4mG9Qe8RQt1wY9UqykyLHhT2nD
 U55zku4O1st86c1fKKeRc8rYH4iuDJagNhvytEpB4ZRhrwFb8LFVrqgjylImYe/njC/Qq8EF+GE
 IWZ9Nc344GQy42HqE4aPsU6mEfnuMDx4IYutBP5vj99bUOQfES4nuQGbMeBH0dau5SGL7OBrGqp
 v6CkwiLC9maJ0y2+OdOQQ/MY7IXVtjo9hcr9LxYAeGEh2G8PWG3VanwhgNo4TuQgb5+VCrEkFbF
 tjvkU8TiOEconXt+w/fsAHlrljnlrNdnpABQ1x2tHy2/kIHlrlPhawuvaAJQQwuJxJBZka5v8qt
 CUTXa3feXnOc3pjjGJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100101
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

Enable DM services for main_pktdma during R5 SPL stage.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v1:
https://lore.kernel.org/all/20260702081251.2691159-4-c-vankar@ti.com/

Changes from v1 to v2:
- No changes.

 arch/arm/dts/k3-am62a7-r5-sk.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/k3-am62a7-r5-sk.dts b/arch/arm/dts/k3-am62a7-r5-sk.dts
index 4570ff6edbf..9c2a6bf89a9 100644
--- a/arch/arm/dts/k3-am62a7-r5-sk.dts
+++ b/arch/arm/dts/k3-am62a7-r5-sk.dts
@@ -42,3 +42,8 @@
 	status = "okay";
 	bootph-pre-ram;
 };
+
+&main_pktdma {
+	ti,sci = <&dm_tifs>;
+	bootph-all;
+};
-- 
2.34.1


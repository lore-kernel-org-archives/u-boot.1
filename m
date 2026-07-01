Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B53FC43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 07:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D44A984B2B;
	Wed,  1 Jul 2026 09:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TglTI/dM";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F8OSqkWi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A6D584B37; Wed,  1 Jul 2026 09:51:25 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3949F84B22
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 09:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6612uWUa2535170; Wed, 1 Jul 2026 02:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=uo8l0KGfFZ1R5Hr/LGSUQpJSw+76EUvOhFuasUMmq
 ow=; b=TglTI/dMns6oZJMbggZn7pdG5V7L0e5KHQzJ5ll1SK6sbQUoK8rNRInQl
 8YLSDhyT1Wj3ZRwWK4TtYju20rEAH76E0SZPpcevDauE9z9hD+KVW1IpS9vJFhb7
 rbMedcx/kTMAHYFr1BRhsTfJeHJQNikqMjkV2iN/Usg/y1Qfkcjvtqe4DZdb01rt
 24JWQQUTUnbdF14zKlxWD/+5prY9j+XTK4LIsEyerm06qxV/CTsgcGOQIZTpH/hE
 caI33N5TP6ZzOxrmBkW9vSCgLNNEiMz5ROeUK6pagMlVFuIqnO5z0IDfX36kzLvA
 p1RGSCSvMUvOBVnwM/+FrbzHOsFAQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f4cpvx900-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 02:51:20 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yifozhqx3TUidt1sn6Wj5181YKRIvtIOx/xgibtjUdPxM1rPWN2A9gY7iZtUB2N1nce7ruSgmwNVkeqy368JJj4i3GH++M4BOJOMD9O1LNPw2L9KC9iHwLYyFgpmEkK1WZhc6Z8A1b2feLd2tRxitBL+OxWSYI+n6/vBlUgBa2k++dd23O1ii1TZTiDS58emt0TjOq5pJRoyL0y5Y8I4Ahq7dbcopSClqDYptQgUNt3vbHFnavyz8G883b9E4GmxDVyS9SlBkJxxs22dWxjUz313491FtIHEaOYIvUs4Ak9hBo5tJ3bIHeYEvfG+WBL6jMYSUDczH3CmN3wka1evKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uo8l0KGfFZ1R5Hr/LGSUQpJSw+76EUvOhFuasUMmqow=;
 b=biS9hysvDIZNOpGcsvNx52i6YKxkVffgMf9WCl57qeNKQDJ7n1ofVIezaDXvpwJfaSNPXcRHq8ITGawkQtT+eNCpqJlOi4ej1qfOqDHSl7fky8B84KsvFysRweEcHle81g37tPFAgQumdNGp4HRCflerdYPZiZxFNWiSdA2zrZg3I6H6S5QN1Oh1usxfpGhuHXPqZYKa2WcQlrEc4in1c1yUAqkOagmPseLLutx8Tp6/sr8Ds8jODXLIHRxHt2oa2YLvPk/ix4DdgnMu7Vkeuw5aVYNP7dvTdgUuuvGgLQY9NS23FOsN3y3vYDlV9f7uLvZ2eRgR+Fayn7OsRJ2CxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uo8l0KGfFZ1R5Hr/LGSUQpJSw+76EUvOhFuasUMmqow=;
 b=F8OSqkWiDQ/DBWuF1gp4lEJust4btwwEht5IbRLSPGQRlDrtSukz6b7KZdgtgTTf09lCaCph5ajSR82wMNc39Qmqb9dHfUQOZ5cZxszlQp/4jLkgWZFUP+V5pKM1HaBUoGYewTmUChZILnNRNuQliI9hVi1G4OXIt7OkkNYB73c=
Received: from DS7PR06CA0003.namprd06.prod.outlook.com (2603:10b6:8:2a::27) by
 CH3PR10MB7780.namprd10.prod.outlook.com (2603:10b6:610:1b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 07:51:05 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::5d) by DS7PR06CA0003.outlook.office365.com
 (2603:10b6:8:2a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 07:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 07:51:04 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 1 Jul
 2026 02:50:35 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 1 Jul
 2026 02:50:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 1 Jul 2026 02:50:35 -0500
Received: from localhost (ula0502350.dhcp.ti.com [10.24.52.241])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6617oXkS304820;
 Wed, 1 Jul 2026 02:50:34 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <msp@baylibre.com>, <v-singh1@ti.com>, <anshuld@ti.com>, <afd@ti.com>,
 <m-chawdhry@ti.com>, <joao.goncalves@toradex.com>, <bb@ti.com>,
 <n-francis@ti.com>, <sebin.francis@ti.com>
Subject: [PATCH v2 3/4] arm: mack-k3: Kconfig: Add DM firmware reserved memory
 configs
Date: Wed, 1 Jul 2026 13:20:20 +0530
Message-ID: <20260701075021.3626094-4-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701075021.3626094-1-p-bhagat@ti.com>
References: <20260701075021.3626094-1-p-bhagat@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|CH3PR10MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e02e86c-b691-4aea-ac63-08ded74580b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: RJDv+N5yCNKfAml2HSZvvBR4f3hf/nQQi62ujHhrDPc6QT39+YU8qmh/KJ5yRnXHX2MlFzul4Yn5UqRTzzl73e412sRl2WajwSbQH/1w+EiEkMUTR5GB4O44pc2s1rI9AloH8v39XSg1Hv61+6QGJu2ONAh7XNagITRF4RMLyTehvyCS+sl06F2g+Q5ujdX75SDIqjpqlasL5KFCPHNbNGCAF07/N6U3VbKhwFVnFBs4OZotkst2U/pOXhtiumo+NCzBDxdISr+RvzN5WohvRFYkEeJcTLSHDLRrBuQ42MVwk6bTZOKHDZdxZlyBrb6/lSo8JFaruS2vgUKQajTGyLLn9uvGlgvJap8NlwadxI9UkpqH6S6KXxuzgubyl/J2ewKqaUPRq5n+IpaI+YiGHxCIY68Wr1i5O4G5iZPmn84o5V0igHc0xr242NHXRK827f6ydQ9Hv8M4A/FtvUoDYJQdInIr8a8HHidlPO/iGNshKQc5etgs1WxCZ4Hr/cOjCd8MRX1biywKoexLMmrrhZknuDxf0IPLkiYARhLOD6qLDn8McQnr8SJiDhwsSnHaIh+jUseQ3prdjpsNnHY5uIjuMh4KYro+jjJqWcHn1zbKGQPXIYSEt/nTI3+qUc4h1PQA102wU7ZQtSZ0LaQKAA3qUjVete6OVJTe4BhSkSIIxAPEpkqdM8mWyZojSTHmj9M6pmdJcE+KKvsD6LYjFg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +TYwC7ON/ctTjrtmhLs7sw7RTZuTacNi8GmHjeQIsfpixgpBocQpfCwOh6suCbpVt7A5Jvo6twgjb8B++FRcmubka6cvU6lMOdSg1O23mH2LtdD86NxxaUzy4qGisS7VVEZm+ZELxQWx5WtSa+pnocbFAFmd33+Oq8jk2KP+grZFz0So/piB91bGql+hA+ol/jTDZCq4klx/cXMoST57ehFZHUj+pSIWPK9I7kqkd+VfmzNUCKFA2gaKO8kv3Ac/DO3rv0GHm8CdyEfcFLJQLGRM24fC3aEE96RxSt/uBf8i/bWOjdhotW5Ai9WwURKmt5QhomUJcYFbjH651GgknYE7dt1gXpuWV9N3WMHwQNELVdi5eY3/Ef4ecdTD1YcsRxFzNyfZoclmD0ivr1GW7kA/Z+JtpaeCLTYxZZNlosHGtKwsHlnzPF1OYhe99DVl
X-Exchange-RoutingPolicyChecked: AsCLJdZ0UPvcV3TGz+cy5mjcgvmhJbno8YPhq1zcLsJ0gp7IvXIojQwh7NO/8xrOfG0NEEV7XcSSeAFDHPeclFwXGYk0cgo0VQBZ4pB2Tmzt3Q1SabrmgNLa10w7Sywiy/yJRGkC56Y7pc8C5szYROUuv7D3dFIG6Zpn61WeuIcXEb8fV0G4wG5Y6uHrj0XC2UGXOVFW6xj5oE9G9Fq29lJa6QiO8q88ulvR+1T63p6lpOSlav3eLClE574TW3EBAwEGXVgwPw6BV5Ie6hrJEepHU88b7y/ilUsrgSWlh5J2LC0FOdlxhWDyH1Oj1N8MFMjGzq2JsvnLcIxfGzl+wg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:51:04.4298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e02e86c-b691-4aea-ac63-08ded74580b6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7780
X-Authority-Analysis: v=2.4 cv=c6abhx9l c=1 sm=1 tr=0 ts=6a44c6f8 cx=c_pps
 a=BlIXLFXQXelmgi4pYy3AOQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=1w_dz1oCJ3nQoT3nqmsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3OSBTYWx0ZWRfX/SBxzioUE9e7
 RIq2nY5/lRY0TUMUsDCNcPrLBf91oyzRzyHmGXiA0+D3XI7FUWnegzg+/8zv9MWYUtYSi+8AxAh
 eXpVliXp/0s95oCbz8G+4VThS1xYLbY=
X-Proofpoint-GUID: 9uXesnvhneExmpUnLTexkrfaDoq76fRK
X-Proofpoint-ORIG-GUID: 9uXesnvhneExmpUnLTexkrfaDoq76fRK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3OSBTYWx0ZWRfX8odbbxkgX8dU
 2/Lu0SdQ+9izrRkapho4jtWrNHrvWYYc7iWVNX+WoRld5zPUNBTbtUaVvexTKmK322FIE+1HH5T
 10GYT7oxUoEz0Yn4bSstTyJYv3wEpesMaI6XGA8ZvDhCXCwqMijGYEN2cXsLhs+HoB267GTtLXl
 VgDVloJdkcjydYLXAAz4RABqUpqnW95/DoKWuD12coL8vTHI6fhNg/8Cow8rqDKDaWml95gpEj2
 c9QmQ/HE383qllnqPQb8k1vQQ79muvXIzMoMSjk5Cb27/0TYEDJGR5SUxgtu9kjw4R820zELpbG
 9HYfAdzQ2Wbg72ISTZAmw1NyfdscAf9tMd8g557XUjF/k7qCwlyFknNFl/PJMMKu9hmZYIsL+HM
 1nVXQk/QVM7Tqy2y5z+squWulRcjI4gNMbO8sYLuPKEacrVp8vQIP6mFDyW1Ey5mqbdfYgd5uE4
 0+aya0J8i2gbnZb1dlg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
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

Add Kconfig options for DM firmware reserved memory for K3 SOCs that
support DM firmware (K3_DM_FW enabled)
- K3_DM_FW_RESERVED_ADDR: DM firmware address
- K3_DM_FW_RESERVED_SIZE: DM firmware reserved size

These configs will be used to fixup the kernel device tree's reserved
memory node for DM. Currently the fixup is only done for AM62A7 SoC, as
K3_DM_FW_RESERVED_SIZE is being used to update DM reserved memory from
0xf0000 to 0x1f0000 as the current reserved carveout is insufficient to
accommodate the binary.

For other platforms, the addresses and sizes are based on the existing
device tree reserved memory. If needed for other SoCs, address and size
could be modified in Kconfig.

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 arch/arm/mach-k3/Kconfig | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index a32ed3a9683..1b6678e72b7 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -165,6 +165,27 @@ config K3_DM_FW
 	  bootloader, it makes RM and PM services not being available
 	  during R5 SPL execution time.
 
+config K3_DM_FW_RESERVED_ADDR
+	hex "Start address of DM firmware reserved memory region"
+	depends on !SOC_K3_AM642 && !SOC_K3_AM654
+	default 0x9c900000 if SOC_K3_AM62A7 || SOC_K3_AM62P5
+	default 0x9db00000 if SOC_K3_AM625
+	default 0xa0100000 if SOC_K3_J721E || SOC_K3_J7200 || SOC_K3_J721S2 || SOC_K3_J722S || SOC_K3_J784S4
+	help
+	  Start address of the DDR region reserved for DM firmware at runtime.
+	  Used only to fixup the kernel device-tree reserved-memory node.
+
+config K3_DM_FW_RESERVED_SIZE
+	hex "Reserved memory size for DM firmware"
+	depends on !SOC_K3_AM642 && !SOC_K3_AM654
+	default 0x1f00000 if SOC_K3_AM62A7
+	default 0xc00000 if SOC_K3_AM625
+	default 0x1e00000 if TARGET_VERDIN_AM62P_A53 || TARGET_VERDIN_AM62P_R5
+	default 0xf00000 if SOC_K3_AM62P5 || SOC_K3_J721E || SOC_K3_J7200 || SOC_K3_J721S2 || SOC_K3_J722S || SOC_K3_J784S4
+	help
+	  The runtime memory size reserved for DM firmware. This is the total
+	  DDR span needed for the DM firmware binary.
+
 config K3_X509_SWRV
 	int "SWRV for X509 certificate used for boot images"
 	default 1
-- 
2.34.1


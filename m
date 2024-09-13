Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A59FA3737
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:29:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 462D788AD7;
	Fri, 13 Sep 2024 11:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QljIZJdV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CED5B88AAA; Fri, 13 Sep 2024 11:29:20 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC72B887FA
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgKQla6s9hDlG3WoVXD8MN9WBKL6yrE6eQkyKJdfMeQXclOoLsAYzAS/PpVNvtuNbhxZpStHKXBlskYWfGacHgHy0od8XCFZ8dB78BXhotM1eZtDjO4gA/Fxbxv6eSgfXBSB+6+YVX/owufEM7r77OpUDpSWgeitV4dPL7GEI2ci+zc7csiFqR+IunPUPdO/0vY8ng+2yGOdepQ7EgJGVDOFHLd49Pizjdt79QswJVs9nu4CTMOTmBfIPksPjKN31IBglwFN48e0pkccyItlfgAtislPLOZSBpnndI78tcM9notFYsloOu7IQ65Xbn3Y7SXfWSaoOnaLgS4zqP4v6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxL45v9SkHXhqWisTAOZpAa/v588/UtJwZRO0UENJXs=;
 b=m7Uxc1kG9h/IjfU/zr87wogyxLtWkmZ0CWUXXo6PjBXoNxKloHuHB4Crkb/l17XRQltpdlE00SDvE7Ex0lqmsteyNS5+Kf1SiTP7JicG8deErfn8vWMtkNcPmq65g4fmDtX0LRtVcVschAfF/3HsyRkSPyF5x0+WUgbv0mG/2ZjoBDWRg9+w8AUWFfrZacst11a+Q7IZo9UB8Cqqmb1g8N1XqO1MuOrC+0V6ZHCg/7QQjnKVC3/CVbf7jSxnxac52iJOCEuGnPB576cG77OIt+cqNtu4ziRzERlgdqf95HU4A65wvlzLfZvGU/RCml0xJSVTaE0l5O+xszySqD157w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxL45v9SkHXhqWisTAOZpAa/v588/UtJwZRO0UENJXs=;
 b=QljIZJdVgDqPj9B5On69EKn+HAsLjqMgSEFlOcBHEYO3ye6xTw7LnThZdV27Cnpw58O2RDsbtrWIuSf///Y9ohDNTH5KglXj+27vP7qHmjOOnoXOmOb0XzsKQj6WDOvZE3rOL5Xxxn/uSDVD2UCOYq40ddYrLmBRjkSfsDVzIx8=
Received: from SA9PR11CA0025.namprd11.prod.outlook.com (2603:10b6:806:6e::30)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.20; Fri, 13 Sep
 2024 09:29:13 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::b9) by SA9PR11CA0025.outlook.office365.com
 (2603:10b6:806:6e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.27 via Frontend
 Transport; Fri, 13 Sep 2024 09:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 09:29:13 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 04:29:11 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/10] arm64: zynqmp: Fix gpio-line-name size for m-a2197
 platforms
Date: Fri, 13 Sep 2024 11:28:45 +0200
Message-ID: <33290fcbcd3ef19cae8ef036dca0f6dcc8080d5b.1726219714.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726219714.git.michal.simek@amd.com>
References: <cover.1726219714.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2421; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=eIIb/k6APbO3VpUesEgMZNXT7MpT0a3MABCqryHpA80=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQnrGevPdL5sdpkxh3H7c+2dWz71i3xkW1P8d8J2za9f
 ibPxx63sCOWhUGQiUFWTJFF2ubKmb2VM6YIXzwsBzOHlQlkCAMXpwBMJKCUYX4p95spX2Z8OSp9
 7psTU7j43TeCT80ZFkxeVPbQW+p4Qt+hZZOPes28Xe67iREA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb89165-ab99-4f5c-5d72-08dcd3d687c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aZnAcS9ZDueM9mLd9je+wraVTVHu9suoXruO+t1/WYwnnUVOq+Bz5OugPjxl?=
 =?us-ascii?Q?+K67gxxqYdsAKcFfecbkfMK70iVI4Kf7sFWO5lnK97hpXeFysSu638XmarhF?=
 =?us-ascii?Q?AaRw/aqQFXNvFCF9YA244Dubay8zaZ6aYSx8jpHMRhxVnQZe0r817W1UkwMI?=
 =?us-ascii?Q?hqqfzdJedzLtZfeGYeanzp8eTTnHRseD9ZNB/ujfL48C0xa9xv88OT2hhHsE?=
 =?us-ascii?Q?qqspQEH504itq87AxX+bSoMvhBq8YsRxajvkQJTVVqv7qkxJuzLMOdyJw432?=
 =?us-ascii?Q?tZwJNc3H14jLLmET+s6EhEVIbGOfM+yJY2Bj1LcM2Sq3s8OQfViOTi0nqAnQ?=
 =?us-ascii?Q?OypQO9jrtsX7bt9iVQynIwdEPKXpzv12t5Nj/vw0sf14k0JAsBERNhfX9zOC?=
 =?us-ascii?Q?QCjANZ1F/W3NHt32i5VZ5uTPmu824XROsINfkY7hpmhiMYpp0h0P269tyY4E?=
 =?us-ascii?Q?mJPQIXCVbJS/DcfHHV1q4JDszxXRzmcXlSoOkfzZGeOLCZrFmtuZ1yVFgFT0?=
 =?us-ascii?Q?zCndKJM7uAqZBLQYRKVN+qJFr7s8JJUYbNPnj3nhfduMqYFuhVvmoqH+lPhJ?=
 =?us-ascii?Q?GMFa6gRfWYWKvzgMUJCiSHsBNo6WYrBtEsCph9B7+pd6lkG6/GveXNwascW7?=
 =?us-ascii?Q?N36mCPEfv7aTx5n6ACzYglcIT2GMHUeJK8eihXBI3ePhlikwGzIfpH7ot932?=
 =?us-ascii?Q?sFIoCEUnoxQqZpbSp60UNpQnyHvU2jCU3mz3Dek9On0KiwR6pYd9CugYR1q4?=
 =?us-ascii?Q?S1qvl2KxY1KKjJrDdFGYf9VFBdiegHJvYODkn1jT+V5x/WRmLWmZX0UTX9PA?=
 =?us-ascii?Q?1/mXXFF1ZzQrPiEB6uMV+byen6C487jSsAX5dWAR99iE8qAzI6xrQ490BUO9?=
 =?us-ascii?Q?U09bne8KrAIP7HIwDzkhnlbHKNTIlaoUCJUXVos4REshUPs9NtUDgu2iP3tD?=
 =?us-ascii?Q?1S6b82/coNpyZwDkwWSAsoWO1qDlMWxWBusYj1UbpkJIksyP3hs/cN+kK4wv?=
 =?us-ascii?Q?YhPoYHXDvN314iP2RjTmt9PGxp4CfH6OFtRBWEX7vzwM1Q9huXn0k+yeluDf?=
 =?us-ascii?Q?4RwfJtsCeE9MWXoasixMCls2GT9A3M9F/34Ih4agmhHboirhFU3WzoXR5TTq?=
 =?us-ascii?Q?RqKAxPrc7jwFeZtuQ2PuzvPwHkYSCE7dGrLQubXO+xKlR+DScGs1CjZICbtf?=
 =?us-ascii?Q?HycpJpiWVESfP+IKkl2s8GAhab3Lvs9VW3/hn2qu72b3rfdls8W3D5tKd0L9?=
 =?us-ascii?Q?9J/nfjWeNg+c55GshO6jQHq44GrQwUkXsb4iW4nFn/83RmiGYDeFBwauh5TI?=
 =?us-ascii?Q?DHd3Ju3dljh35V8I6LM0KQBvpIcYlYVKTMD13F1euU6Wrxp+xBgEYe5csuww?=
 =?us-ascii?Q?pu4QtLIyahPbuJT5/E04aMLzGWbmfZ2MU09Jf3AJ5yf/ZoZmpNigNbAI6NGc?=
 =?us-ascii?Q?MbXeTG+V5sY1LFQI/uESU+Xe8mTCZ9Pq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:29:13.3241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb89165-ab99-4f5c-5d72-08dcd3d687c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897
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

There were 3 additional empty strings which shouldn't be there.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-m-a2197-01-revA.dts | 2 +-
 arch/arm/dts/zynqmp-m-a2197-02-revA.dts | 2 +-
 arch/arm/dts/zynqmp-m-a2197-03-revA.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
index f9299edca82f..a5b61a8ca84d 100644
--- a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
@@ -140,7 +140,7 @@
 		  "USB1_DIR", "USB1_DATA2", "USB1_NXT", "USB1_DATA0", "USB1_DATA1", /* 65 - 69 */
 		  "USB1_STP", "USB1_DATA3", "USB1_DATA4", "USB1_DATA5", "USB1_DATA6", /* 70 - 74 */
 		  "USB1_DATA7", "ETH_MDC", "ETH_MDIO", /* 75 - 77, MIO end and EMIO start */
-		  "", "", "", "", "", /* 78 - 79 */
+		  "", "", /* 78 - 79 */
 		  "", "", "", "", "", /* 80 - 84 */
 		  "", "", "", "", "", /* 85 -89 */
 		  "", "", "", "", "", /* 90 - 94 */
diff --git a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
index 0f61eca3e9cb..80829a120ecc 100644
--- a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
@@ -135,7 +135,7 @@
 		  "USB1_DIR", "USB1_DATA2", "USB1_NXT", "USB1_DATA0", "USB1_DATA1", /* 65 - 69 */
 		  "USB1_STP", "USB1_DATA3", "USB1_DATA4", "USB1_DATA5", "USB1_DATA6", /* 70 - 74 */
 		  "USB1_DATA7", "ETH_MDC", "ETH_MDIO", /* 75 - 77, MIO end and EMIO start */
-		  "", "", "", "", "", /* 78 - 79 */
+		  "", "", /* 78 - 79 */
 		  "", "", "", "", "", /* 80 - 84 */
 		  "", "", "", "", "", /* 85 -89 */
 		  "", "", "", "", "", /* 90 - 94 */
diff --git a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
index 19f294167f61..35a13f127d37 100644
--- a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
@@ -135,7 +135,7 @@
 		  "USB1_DIR", "USB1_DATA2", "USB1_NXT", "USB1_DATA0", "USB1_DATA1", /* 65 - 69 */
 		  "USB1_STP", "USB1_DATA3", "USB1_DATA4", "USB1_DATA5", "USB1_DATA6", /* 70 - 74 */
 		  "USB1_DATA7", "ETH_MDC", "ETH_MDIO", /* 75 - 77, MIO end and EMIO start */
-		  "", "", "", "", "", /* 78 - 79 */
+		  "", "", /* 78 - 79 */
 		  "", "", "", "", "", /* 80 - 84 */
 		  "", "", "", "", "", /* 85 -89 */
 		  "", "", "", "", "", /* 90 - 94 */
-- 
2.43.0


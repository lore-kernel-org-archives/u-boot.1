Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D832CDC188
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 12:37:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAD9E83F5D;
	Tue,  6 Jan 2026 13:37:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tbdqDNBG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 547FF83F63; Tue,  6 Jan 2026 13:37:47 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 923FB83F5C
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 13:37:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqer0foEU4OP7sOdnH6LwRgJwVp7l/FRtuaiIC54YvFABuyXS0JECYjMNadG/tCR2nql7/M15mN1kH1EfsfUcyvwYoJWnUEnaG3NSkmIg0oyltjGBhSm9c9S+2FFoPUACi74q7M2PAGA7O5JNvFZDFwhVQt5GR+BpqKhP1kM6i76e1xvIoFkt25CiYkXCtwP+G3tFvO0ZezbRFm+sA4z2kwo3NDNwNGSbw7m5LavLYwyBeSCv6Lr3FcTgUwqopvdBTuJqJ0uUuimNfJc3JWyyD5ZpAvO2WwOtk4x/PwtGBoON4nPobyhPAcdgfY95cH1lTMuDU8R4niHqjl50yXsPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hwjJDKFWfe9IKnd8Fykd8lQlG2mPiw354H0ashQq4Q=;
 b=W2ULyIuQ8Vi+ZhXbP+cHYpfglNPDiOp5gMJBzi/LZ/V2kCe+y09OhOpMvu/0L38yaT8LC4X03h5JM+liK7yebrkcXQs15Du72NK5unfOj8IEsvFzj+3NcsFESG2fi8o6inZvBNWA2+OJADDToJ4pbSeXA/jI95lecGEre9U7TFR2N+Zynq7tT6X5HbYiXFEkznp535dvxvwtRIDHI0ANIBY6fc3iNlTKclKJebVcEydLdCCg8svj2tcpgoRlPtNDGVPf+3/Qk4wKUys5gP2Y4L90l+s1sOUVj7DvNoof2QxH/e05122uj8WWu+P3bLZg7G3B0+46wjYer+CZZe6W0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hwjJDKFWfe9IKnd8Fykd8lQlG2mPiw354H0ashQq4Q=;
 b=tbdqDNBGkKdH8WGnAqLhdWSRdJPTf2Al+VFu3OPM8UWjLS8F/aPXk1u2bBRhzwUEFfHJ/5Qorgrzqh9o9C2IN36cIk6x6L4PvWVJrWrJ4UmVecYUKHcFElMjyKNSIy6UpijVZq3sOoprGXBh9iN1UtC6DSgggz0WxZISDcwUtvQ=
Received: from DS7PR05CA0043.namprd05.prod.outlook.com (2603:10b6:8:2f::22) by
 DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.2; Tue, 6 Jan 2026 12:37:34 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::c8) by DS7PR05CA0043.outlook.office365.com
 (2603:10b6:8:2f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via Frontend Transport; Tue, 6
 Jan 2026 12:37:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 12:37:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 06:37:33 -0600
Received: from xirengwts09.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 6 Jan 2026 06:37:33 -0600
From: Neal Frager <neal.frager@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <ricardo@foundries.io>, Neal Frager
 <neal.frager@amd.com>
Subject: [PATCH v1 1/1] board: zynqmp: allow env in fat/ext when booting out
 of qspi
Date: Tue, 6 Jan 2026 12:37:29 +0000
Message-ID: <20260106123729.1483656-1-neal.frager@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|DS7PR12MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a35d0c1-688f-450b-6324-08de4d205dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ITW1hRAqGjK4IG+A4qy6eqYeu6sAOmmt3yNKG0m8qLG14yrSNYgIvwCxvtIr?=
 =?us-ascii?Q?RoXxtszTPa/ZbKvOwxxOiDlp5EOe6XN3oAAXOkL7KjzIxjVPCOC+iNDvWJkT?=
 =?us-ascii?Q?+//nhiXf5zNDpyjLBBPDcIbuFOEwogVItrhavHv8KSFf72eSVJtJU2mKjfC2?=
 =?us-ascii?Q?MZZCqAj/7b1MK6myf9keluOK3+wD53H6r/4oODPwGI0AZnUoV3bft9wj2ISu?=
 =?us-ascii?Q?AD//SN9esioxx3kNMEdw+JLRwEmQuPH3bpSEtPnhAit8/L9aBTSZ4H9BQZkJ?=
 =?us-ascii?Q?CXPmLfK7kl0YR4VnVBk9mp89eipwQfU+uSBgfrxkp77HPF5yzlWT5UfkScnV?=
 =?us-ascii?Q?JXvlxwo6cwW6sCjRREd20nRNpV7QIXn7TI607WV3bgnm0dBpCQb2GoDmsjHd?=
 =?us-ascii?Q?ibTdCE9ZQBus5H3yfaJtDlOhPdmgt43gxUjCexiOa2WUwiwtL1eV8xJS2IvU?=
 =?us-ascii?Q?iic4+6C+5BderX1dQ8GaKO+nXmtIUjqoIwx1WPpLnbXJhv9BT0xGooh+Pw8s?=
 =?us-ascii?Q?6N+2Ol0O3ql2/SY+kJsHtgeJtE9OQYRCp9QqjEVE8hd9gCzPG6Mzw4NSVb3R?=
 =?us-ascii?Q?+EtEM8Txs2dDT9YGjLJKJU1RRJBIDPEhk8e5pAODWRlljsYR+l34X0zR2u2J?=
 =?us-ascii?Q?Ftb+8c6W8MWUCp+gF1BdM6fJy5LzuOtXYxaT+/MF0UiibQFjPxqb0KyjkDRI?=
 =?us-ascii?Q?pBFlp7vW1nywevqT6x06qMMhAIRWXYx07+pTeS3F/jWLHbdqXzOher6GFBv8?=
 =?us-ascii?Q?CxjIsm5CBxPhAb4E4HJKqJlkUcg3jjyH4QLeU9cxkvgQgpAqU5e6PPk1JjHh?=
 =?us-ascii?Q?WwiDx3bPYZWFkObNePp8rQD+uczMXNq1CqWNL8Aaq2glUyqVYXExgVGoU6p8?=
 =?us-ascii?Q?phE9TCd/mpSnD1S4w1efduE9exFhXioPwrhooo9HxCd94peq215NJQ3Wej+/?=
 =?us-ascii?Q?jUxjN/zj1cLg1QDNE3pt6ABNoG28vqFw8l3/QkIkxaUL/3YUbAh/NXW0lJuL?=
 =?us-ascii?Q?6/s+ORDmUpX+tllHUj7MG3n2Kme3FPtzmqY1TSclVrk8z4oD30bYGy8gTIxR?=
 =?us-ascii?Q?rYHGyw+rmgc5tjgfoUh+WsreMS8KVk6gK0FtrmiPTRXtAIed0xT3nYR8nJ9l?=
 =?us-ascii?Q?fj8R9HiO6YbZWt6O9bT1A/4YRYpGqq4Bp4op0wVHNc1awtiDqV/tv3bnqlcJ?=
 =?us-ascii?Q?7+17gCNVHg/YqRsna3l6x3+hZTT9O9bwkolLJ4ERvHHz72ywyk+J3OPOTXNg?=
 =?us-ascii?Q?+GMZyqNq2d0zNm5ItKhooikHWRSJI9MDjBSbxVrnx+YqVSkI5LavLMsZyk4S?=
 =?us-ascii?Q?9+KMJd3cRxMVkaqiDGf9n8yDL6d9rU5jGO4zbhG2Uz4KEcPlb3trJZZHJRM7?=
 =?us-ascii?Q?Nx1HbXiz/y6FLY/zD8AVX7M+dMwht63k4milfn92CPIE01MhsGY9Eb17pAAu?=
 =?us-ascii?Q?XwGXEHBycqYhTjuG2/So7gMWkZtrHGLGqvQiqnEAvpxKZ+3o566L0EKgoTv1?=
 =?us-ascii?Q?A+7q5wtDJ5yct3GXlDI5YtNL+H7wtCPQyvaNnUYJmkJuPTnWC8Fdqay+4P9E?=
 =?us-ascii?Q?zZXqyw16L5sFCzDd9Yg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 12:37:34.2539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a35d0c1-688f-450b-6324-08de4d205dee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960
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

Allow saving the environment in fat and in ext4 when bootmode is qspi.

Signed-off-by: Ricardo Salveti <ricardo@foundries.io>
Signed-off-by: Neal Frager <neal.frager@amd.com>
---
 board/xilinx/zynqmp/zynqmp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 3b28ba62374..769e52bcfb5 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -628,6 +628,10 @@ enum env_location env_get_location(enum env_operation op, int prio)
 	case QSPI_MODE_32BIT:
 		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
 			return ENVL_SPI_FLASH;
+		if (IS_ENABLED(CONFIG_ENV_IS_IN_FAT))
+			return ENVL_FAT;
+		if (IS_ENABLED(CONFIG_ENV_IS_IN_EXT4))
+			return ENVL_EXT4;
 		return ENVL_NOWHERE;
 	case JTAG_MODE:
 	default:
-- 
2.25.1


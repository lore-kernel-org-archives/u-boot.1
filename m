Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523D5C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 14:11:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC229807D7;
	Fri, 17 Jan 2025 15:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VyTu3GI+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1A878073F; Fri, 17 Jan 2025 10:28:29 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9175806D8
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 10:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsqSkY3YRyl7rfiM+wh+XJOEecQG9VDKBuOCPPrGF/0O5HYKgZx+ZWrkmi6FfLim3xlv5xlaoI1EVyZIVcka9KXQGSKXWWkBG+QiTd0Ko4tBq5u6YRLJHsJduiIl4F/UYF0/sphPos5gLyU/AIDNRWXLvdtoOHisyfbj0wcgEcFd+ZP/tFHfe/Vl79c4vnx5Ij6X+JFcbexQRu0UQE5nG85gyBFLKEcA7NSc4VrVBlvmAoC0Iv/6WMSHElMZHv911roPB9bYIy6v1jbrhw5r9T3YFFvRAjEf5RbWK/uP2GCMo4kzZIWKF4gYyIpP1RhutsarNSm5AtJ29tENQAYx+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MSON9Pm3oAXgOLg8Kxq7AWdv4C2+cGHWwzfWb+0lU0=;
 b=I1crZ2wEyDSBamzmEHYgjCyh2SlSZAmUpt/fCOl9pQ99YphhO/G8d2Vt8mVGN4U2GwN/S4tcxZrd8Q6r3mp0uFNbLyYftRbv73CjlwtQY1C95n+xA81kRW1U76dR6gmEkAdMXOOlBAzLyPYgW9oV+vyytpiFaQJj2wj/KTwDFtMPvUrHTUWMoGKPHEioNuTWDTpLvhJwzpWrNBrNRg5AigtZpz2X8TVn/HUU/I6YeppP1GOCK96Pez7SBwcH+TcEhhJMu4EEwtq/w2HElOEonld92a58yo+k3aMfjXVsAs/e9SuHlOPMgk6+hbfKd7hODhKE+emusA9JljTJHcbz/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MSON9Pm3oAXgOLg8Kxq7AWdv4C2+cGHWwzfWb+0lU0=;
 b=VyTu3GI+XHFAx3ZR42/YNlk2tKovEKQO/fdgwjswByqZnkpR1leiuvph+pJTNzYuS6P/wXivFFJg9MEXvmy4rXKyIDVuPokMWdciApk/c1SjFMA3lzBn16PUF3TPVp9XKDt7tCX9KzeL5bQ2lw/Wrnmc/xZ75seEdEReDu6F8jg=
Received: from SA0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:806:130::23)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 09:28:23 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::95) by SA0PR13CA0018.outlook.office365.com
 (2603:10b6:806:130::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.6 via Frontend Transport; Fri,
 17 Jan 2025 09:28:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 09:28:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 03:28:21 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 17 Jan 2025 03:28:20 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: Michal Simek <michal.simek@amd.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v2 2/3] fpga: improve loads usage information
Date: Fri, 17 Jan 2025 09:28:03 +0000
Message-ID: <20250117092815.2986832-3-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
In-Reply-To: <20250117092815.2986832-1-ibai.erkiaga-elorza@amd.com>
References: <20250117092815.2986832-1-ibai.erkiaga-elorza@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ibai.erkiaga-elorza@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: b74d9ce4-0e4b-4e16-2a24-08dd36d94925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rL9/pawdDHdgb8YJdIgHWFgcWzYmN/wadvAof/bgcwWDq8Cnk5TzoctOwTUO?=
 =?us-ascii?Q?KX7Sw08WUW19ZxqcounHkncDzQmyEldR4yYpbSvo5c/aap4pJKb8a10x6N+5?=
 =?us-ascii?Q?9hCmckvNzuv3iz/cAWry5J4rBJ+z8/ePmnAU+nHoHR9xTQT4yDxpPBhYdRY8?=
 =?us-ascii?Q?HKpH9pBt7cqJLazLswvXJvIbpUdCVEQXl3EcaP+/+gZ1KHL7vm/mOkbzT/Lu?=
 =?us-ascii?Q?Yp7oczOg4ilt5deMvdrg0kUIYzOPgMpv7g5JpqfOUd3stMfyUTq6DOp99OWQ?=
 =?us-ascii?Q?soyNnQ+soAF+RVURNspnJL3UcIjdPdE/iCss910fK5khAYo6l/+HeZ27Ug4O?=
 =?us-ascii?Q?JacTfJWJ6qF0Nrud6bkWHCKfGwh++ABVwQZRlOQ75hnzq0uvb6mlK1FazqVv?=
 =?us-ascii?Q?8t4iPlkPnOAOUM0btryG40SlZVzqOZd46zsiMgpQgF4Uga7gLS2dtVmqWBHm?=
 =?us-ascii?Q?1OadQ/KsQ8oI1TFpSQnvtMCPzx4E1Xv9BvXmmfArhMJ/yRMSCystDjfZu8xv?=
 =?us-ascii?Q?jV3uD3UmVl9ds+5Z1JgkU29nUikDuDbvg4zUqZnwvm6q4Yc/6k49SfbAcjwr?=
 =?us-ascii?Q?yxwT/xdiIQFXxxq8+7mOtqOIK6spFnumI4JpP/0wIBYDTiBPqgvUnAZYTSbE?=
 =?us-ascii?Q?m2Q+dd2/TNn978m7EfCn78xnlVF9b2bsWE+q3V5xQoELpjZWTPy7cO+xazWD?=
 =?us-ascii?Q?2ZURBPq8ZlodiyVXdtYMQZlciVLM1nomKj8saE3VFbtDRBhALpQX3DdL5INT?=
 =?us-ascii?Q?huUAfhn3UkKn450+/yMKDs/H70iWMeeVaILm+mUqstRX0kM+JynN0Nd6tsdo?=
 =?us-ascii?Q?zW40tvRKrT7E2Qtk7ExDXGkIRU2yRgmNAz4DwZp/JoPdM/Wvsx/GRe4f8Wfq?=
 =?us-ascii?Q?EzFIdpVsoRSOVXI0q3SypFwPl6q/TvOTFQsBJfIn1LZhT2i5z8Xvdj86qp5f?=
 =?us-ascii?Q?g9O27BskJ1U6e+Q3Am2WbmRB1nW8z9ejR2lXgnBdk81S/B3Te/denY2gNr64?=
 =?us-ascii?Q?GI/uoMjMqcyBHnNHJQHx6w0bvJpgPyX9uI1O4BOMf/p1jaF1taZHerstSgr2?=
 =?us-ascii?Q?pXgtPrMXwjgu0bvnMIn/8cDVCfFGkaZCDi12N1B0gZ9bM7PBYbjUrYtP96Hm?=
 =?us-ascii?Q?XeTmgCf92FFmeCiZ/GqfVWaxIYKJ//Jj/yTWFdPLqBLhzLmvDIn0XgPSWxR0?=
 =?us-ascii?Q?CvOP6dBBzGXH4LWvdbENUbhVOMB2NX0ULxdzk3gakSQhFpcVKtIAHN3qzh9J?=
 =?us-ascii?Q?X4KwjEjMsptQYv6vo8i3BDdUjOvtz/pWpNgrGDZeA35zfLuqNTECTBXd+wvc?=
 =?us-ascii?Q?mPI2R/ILZ3twegp2wmUxLxMqR580jZ9tbuF8s+jG+3YF4AYhQ/P1zCCYCShj?=
 =?us-ascii?Q?m8CF7XjyG5np1NdCW7xiaHfRuoxTSkTszLAW7gyjpIiHXakchuJLbwzMqEtM?=
 =?us-ascii?Q?Ql6/+HL3TwLwoN3fLwrrsr6lUidjw5wP+wPgwa7oqoPugzg9e/RGUls4Bc6z?=
 =?us-ascii?Q?gmt2ec5JiJ0+xfo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 09:28:21.8516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b74d9ce4-0e4b-4e16-2a24-08dd36d94925
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249
X-Mailman-Approved-At: Fri, 17 Jan 2025 15:10:41 +0100
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

Current usage information for loads command is too verbose and long for
a command usage prompt. This flag simplifies the text for readability
purposes.

Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
---

(no changes since v1)

 cmd/fpga.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/cmd/fpga.c b/cmd/fpga.c
index ae85ff201b8..91ccbee0fef 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -434,18 +434,13 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
 #endif
 #endif
 #if defined(CONFIG_CMD_FPGA_LOAD_SECURE)
-	 "fpga loads  <dev> <address> <size> <auth-OCM-0/DDR-1/noauth-2>\n"
-	 "            <enc-devkey(0)/userkey(1)/nenc(2> [Userkey address]\n"
-	 "            Loads the secure bistreams(authenticated/encrypted/both\n"
-	 "            authenticated and encrypted) of [size] from [address]\n"
-	 "            (Xilinx only)\n"
-	 "            -The auth-OCM/DDR flag specifies to perform authentication\n"
-	 "            in OCM or in DDR. 0 for OCM, 1 for DDR, 2 for no authentication\n"
-	 "            -The enc flag specifies which key to be used for decryption\n"
-	 "            0-device key, 1-user key, 2-no encryption.\n"
-	 "            -The optional Userkey address specifies from which address key\n"
-	 "            has to be used for decryption if user key is selected.\n"
-	 "            NOTE: the secure bitstream has to be created using Xilinx\n"
-	 "            bootgen tool only.\n"
+	 "fpga loads  <dev> <address> <size> <authflag> <encflag> [Userkey address]\n"
+	 "            Load device from memory buffer with secure bistream\n"
+	 "            (authenticated/encrypted/both)(Xilinx only)\n"
+	 "            -authflag: 0 for OCM, 1 for DDR, 2 for no authentication\n"
+	 "            (specifies where to perform authentication)\n"
+	 "            -encflag: 0 for device key, 1 for user key, 2 for no encryption\n"
+	 "            -Userkey address: address where user key is stored\n"
+	 "            NOTE: secure bitstream has to be created using Xilinx bootgen tool\n"
 #endif
 );
-- 
2.42.0.325.g3a06386e31


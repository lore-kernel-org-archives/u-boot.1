Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C61C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 07:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A53E82D06;
	Tue, 29 Jul 2025 09:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PtJkkDMf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C48B482D21; Tue, 29 Jul 2025 09:13:15 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C94EE82CBB
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOvR4H7MQfDH4PYRJCjxl3wCi7+Y41d9qVDBbZB5YB7PNH4QjJiXXQWEedokJ0+j9ym2/Bn4CZVV8MXHa7JHtSd5Riz0Wt3eTyb3pEaW9t60gdxowmBuq9sE4o0RkCo7hUWOCT+JAKvFzh37taKQwspynIp3qOE+SCZ8zqqF3sk61k6W40U6s7G+7TheaA5W7a+WWNr1I3HPdVix1QdH7UnBZ+X0qDZMNr59O6H8fZeJcZz3BzpYpgf6wo79n+rhUQzR6X7OBk8ZYNWg1DE5hxntO7oiwdVun9oSvTv4WfHq2x6Oa0fgjMGie5Zg/sH0U3+rJrG0SezwupHnN7SkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMmR/Y68DJPusPocC++/pLw3riMsMxNV78JWgjmGYks=;
 b=aOfq7VLs1PqK0N/kbwt6xgNvMmQSwcGULUakQnxQOx7DtfbtnMB4STfBgM7m0iGTZZivvGrHuQOYrft09QkmYq0RJENvh+hlmf8bdQy+s4+34pEhx4hHcpiNkOaWSvCvh1F+9kMrmRuBJGBKeGGPoVbmYMOsLEngBro5qbAzQZOuAUCZ09cPKYAFMouweuOVSqECUqHf0ARcDl6J95gQSB6JJZbl1f/Npa2i22Sdzvb/s11xZ4I6Ol4jJFsJRGnVuNMSQMR3qdagboghcfkUzb4wF68G6kq8VKGizME/nbbeMCT0UxgKNzvkGZRQz61bJlMAY+INx68IfN7QnO78QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMmR/Y68DJPusPocC++/pLw3riMsMxNV78JWgjmGYks=;
 b=PtJkkDMfIz5MKX8t0Y5RJuNbfjSTdtsIYI/SNNvu3YH+e/NOFgx/DlSLLQEc/recfyOKiwtn9RKVjxgMCvKCXCwiYoYg7NG4Kt6xr91mC4sd64T0W4/GHYUWRlA7Rc0TUIuQjAWA/XsBNsJhLaybev9Lwma29Pa9PH9IOdPUh7c=
Received: from BYAPR07CA0008.namprd07.prod.outlook.com (2603:10b6:a02:bc::21)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 07:13:07 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::55) by BYAPR07CA0008.outlook.office365.com
 (2603:10b6:a02:bc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.27 via Frontend Transport; Tue,
 29 Jul 2025 07:13:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 07:13:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Jul
 2025 02:13:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Jul
 2025 02:13:02 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 29 Jul 2025 02:13:01 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] cmd: bdinfo: Fix showing correct IP address based on current
 device
Date: Tue, 29 Jul 2025 09:12:54 +0200
Message-ID: <4aeb0244949ec18393e8b8d322f8a1809462f3ab.1753773172.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=JIG4toZPyFW1z4aPpcb4nFCcZb2fDdPDvBfn4cRqJMw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR0lJSfvJzGGaL78JiaYUDxib7E27EZD34p8HU8iekM4
 PY8xpPcUcrCIMbBICumyDKdScdhzbdrS8WWR+bDzGFlAhnCwMUpABPZn8zIcGfyjIWBS5J0a26k
 LL83zeTemiNndIq/tTatXiBakJe1S4bhn95iN4/Z6+rWdy3zkGMR3CL2xNmoeFZIL0fWhR6hfeW
 9DAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bba3a2a-90b9-434f-c28a-08ddce6f5e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2sIcjlXJp03lBUwCLwkCl4mZhgokXZRF7uvEafZJJlJOGURYoJgpYB5C55i+?=
 =?us-ascii?Q?N8GzQU7GTedQwZFilzFecCW1X7JHJ7Q0H/QX8zismRvB8wr6lDDWkaAiNlSV?=
 =?us-ascii?Q?E6s92HTQ3/QgYfCtDgOpFXIIT2eAUl0sZOaZGhOb8YjQ/f31RfBLnmLq/HvS?=
 =?us-ascii?Q?lODD0ioSHsxRvOLTwENWyemlpIlYnbGhnwdaWIpyPnhpW9ZOxNP0aPdwToU5?=
 =?us-ascii?Q?ZNSTHrXNQaDJOlfhVQufPyRPEg1Jow0JUUCwIcr72yoMuPU/ue2lXEwPVmU1?=
 =?us-ascii?Q?/gRTh1JvDsJGMizkKze3KGFrpgot0dDuxjSbgm7N//EuapBtf1DamrUeUFwr?=
 =?us-ascii?Q?xW3H4TH+BacYyS3Y4Q2kdKM77g1EkfizwegBsXJzQ95MG+r0ssaGKPBHU7Lt?=
 =?us-ascii?Q?zT4Ny78jz4SIC7jiTAsfTYsm0LoMihiTwTT7+H+8pUvwiPQUB0Dpmawi11M8?=
 =?us-ascii?Q?VkookGPPFG7yu/qpwT4Q+5Gm+F2n0LHOm6tB0d/MAZdf6Mnd7E1D3jQR8DZk?=
 =?us-ascii?Q?0Mv8jlUi6c4ykoOn86cjfPAeICVNr2bigt2+IQvx8JB7eYQKdWl3EDZkQQub?=
 =?us-ascii?Q?09NAf8WvryqP64oxDCyOTlfxWN2KCfu3eaS4YB8HT28WOO9Vnd26RNwAJY+d?=
 =?us-ascii?Q?p0VW9aKZawPVGNxyuueLGDxLTqx8uHpewmolULPN/TB8Nm9IvSkPeDw6p0zV?=
 =?us-ascii?Q?vKqXpi/hT88r8YI3HBK8pyBzYmIOAqLxuK2quake9r5ZZOCo1dm3QL6izEH7?=
 =?us-ascii?Q?PXBipWD5p+fVyqRiKPVB3WWezWmAgvZrljLrYkMXyQriBAo7iOWZi5w9eJY+?=
 =?us-ascii?Q?KneT5Khn0SOvOxFsT+uWYIR/if4nGvTKp4mtZHh0vkvdYd71tm9fhluIFvaq?=
 =?us-ascii?Q?V18iLwqW+TJZ2ccRl2AnPYup9UvLutYViTwX6IiAEjmwASA4m5MHQ4mVRMAh?=
 =?us-ascii?Q?6OjagiGTm8+c6hQ1TSVdg0zmmkB12kq+3REiz44i/QNLE9fWlfU08nxrYvO6?=
 =?us-ascii?Q?dNWuE4sFcCWktONV8+kqoxo8AHGdh7goSaIUgMx+TaH0Yy7CUL+218ymdRNC?=
 =?us-ascii?Q?mqQYgzzp+fdWKNa1XtjS1penAfcdhohsMeX2vSQdaE/1sTXMth7lihmc4A6t?=
 =?us-ascii?Q?Bx0c0Gqf5efiJfP3H1aeaWepBC5A7rtcQaPbKHnWNuqC4Vg/wRpLiKKoVyXw?=
 =?us-ascii?Q?BOmjMOJZr5yqo3R9m+lIVRI63TdvlTG4rt3EGGsa8kgWb9UC7XNtAv+CcieS?=
 =?us-ascii?Q?S1uIpk9/SJ9UoCMzRFmasyGsAnXPqHBrR8MGnui1w9cl5p6EXhrr5CCCH85D?=
 =?us-ascii?Q?539FoPs/XoReBjEThs39OG/GF6Qd83op147PISjajeI1bZ2OCTw8W9Vx/Im6?=
 =?us-ascii?Q?4AmAtNg8H6b1JfhsE4wL8Ffyqrokw+dFTWGUrEE4QTLt5Hz9KLlClqnjvFDm?=
 =?us-ascii?Q?n61l/916aQxJBKbtq37QocNs6xbwNRKpZE3VA1cxsYBCVUDLw2f9hdFwcziG?=
 =?us-ascii?Q?QoGIYAlh9Kbk4msmWFUFoWvXpevDr2L7sdi4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 07:13:06.8988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bba3a2a-90b9-434f-c28a-08ddce6f5e01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210
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

Use the same logic as is used for MAC address where bdi shows mac address
for current device where index (idx) is used to point to correct IP address
which is read and show.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 cmd/bdinfo.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index ae9e1923eacf..20c8c97f0cd1 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -46,6 +46,7 @@ void bdinfo_print_num_ll(const char *name, unsigned long long value)
 static void print_eth(void)
 {
 	const int idx = eth_get_dev_index();
+	char ipstr[] = "ipaddr\0\0";
 	uchar enetaddr[6];
 	char name[10];
 	int ret;
@@ -62,7 +63,11 @@ static void print_eth(void)
 		printf("%-12s= (not set)\n", name);
 	else
 		printf("%-12s= %pM\n", name, enetaddr);
-	printf("IP addr     = %s\n", env_get("ipaddr"));
+
+	if (idx > 0)
+		sprintf(ipstr, "ipaddr%d", idx);
+
+	printf("IP addr     = %s\n", env_get(ipstr));
 }
 
 void bdinfo_print_mhz(const char *name, unsigned long hz)
-- 
2.43.0

base-commit: 6f13cf94e46d7e0543bb44ed5528846cb966876a
branch: mbv-upstream-qemu

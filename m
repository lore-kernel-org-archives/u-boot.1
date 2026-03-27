Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9BE10ED640
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 10:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75B3D83DA7;
	Fri, 27 Mar 2026 11:11:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mj17Iy7W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A097183DBF; Fri, 27 Mar 2026 11:11:20 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECFF383C14
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 11:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9Aj+UCEATAW34JzMLaj5Rh4+rMZv/34TNwpLraZ70+N5zoYeyrMZ92hs5Q9PpNkgFhoTF7nkyFMES+zivmlz+i7kYwHaAhmWrxo8SoUlPstNztqdaAAgXIKvxXf6upTuwJHps02/0sSmoGImy8n04Fq3gEDPmGDiTqfse7cM8q2VF1dPzzWewO40AmgqJRwVKUuzgqXOlH5UmeJ7TnHL0MODvpAahgcqwTgeQE3H9UzOTJn2xJBdG/a9VFelhU+4+m5jjdlAkdpY6qCMgezMjlBjSZ01MJDc9fYQvEzvY8m2x6lqDoqDRkjPC6qDS7uYroETLT0Xwl5+MIuPvfhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZJvuIB3G8QRxku7xg9e7ZfCFkPSkjObRZcEt/D8FBI=;
 b=RuyfPfA4NxbIff18/Fh42KXkrEyna4pn22CDOv4qx7xa7WNQMLBoefhHTqt9azWRh9Kk6BZNcBzRAuZOzxN/y0s9Ji3WsRgkYzg8msS2dZt9kqgyQsb/9ZsRvofJ380sIKmOFUMgu+AjbpQfIIbRrYAIKgyYRSZRWCeil48MAsv+jGI3yH6Wb9LzGYTbn+ILP1WuAhJa55xjeTXVZwaWOGFMvRNN2TWmrY2IjiMHInixB1jLubP2WHN7BQ3TCCpDW6/VbccVtz4ZR+oGnxjPlegxgZAmxOaCT8tBLnEt+9jaYdOuTruhrfgO4DC+as2MbyDVuAc8UjGbjzE/u1VBxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZJvuIB3G8QRxku7xg9e7ZfCFkPSkjObRZcEt/D8FBI=;
 b=mj17Iy7W5jwLsJFDEe1Tk9e0ZmCNy2ZtqqV2OHmmeqQfVWEWLob5z3wTt6sVxVY3IA5j4vbvUqgXze2P3Dn0jLvs+qiE+/qqjZw3dTpGjYgCdFe9LakA09yP3MefHq59DY2F9jN3lwWSuWB5hQJfghNx69Yv7RMQMl3AJlqWtNE=
Received: from PH8P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::19)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 10:11:08 +0000
Received: from MW1PEPF00016160.namprd21.prod.outlook.com
 (2603:10b6:510:2db:cafe::d) by PH8P223CA0005.outlook.office365.com
 (2603:10b6:510:2db::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Fri,
 27 Mar 2026 10:11:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00016160.mail.protection.outlook.com (10.167.249.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.0 via Frontend Transport; Fri, 27 Mar 2026 10:11:07 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 05:11:02 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 05:11:00 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Lukasz Majewski <lukma@denx.de>, 
 Tom Rini <trini@konsulko.com>, Siva Durga Prasad Paladugu
 <siva.durga.prasad.paladugu@amd.com>
Subject: [PATCH] clk: versal: Fix out-of-bounds parent id for DUMMY_PARENT
Date: Fri, 27 Mar 2026 15:40:32 +0530
Message-ID: <20260327101053.900154-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016160:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 12cc7a8d-26da-40b3-069e-08de8be929cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: +b51zEgofoRu3rpqyesvDWm7CWirwcbO5Da6bTZ/BqhVfH09Vlp3OjNq7rlgy0zZQkn6g9iDctyT3G2qGwlM6T1TgVftoUwPnR4huhZTxok/1LsGGpeu/go5vgpbcZnVCLEyhVaBdnhEaeqvu/UnpAbXkSsbpg6GhmgDOMannx07xxPFoNgqKg27CXtLA7XN0mXjfppw43O1DHwrYj5e7rKWhVYtS3tDvu7kTE3aRn6qmP/OmgxOKLMMJy8Pu0RGPLWyx9x9zGWtBIBINTY6sIXyveIGaE3sDEUjSzy8q42qinFuSLLDtOm1mI2xr57iKT/b4+2AQ+s8S8SVPuKII3kic8kh71dm4wQcoTxhnx82iQ9TulLpq1s8LcIMM6WAE8Wnb3UrZnqXkKUV/cDLOX9MHPYHlQBGWeA+RK+EQf86nLxqKbGQapjbIip0GzmzSuMT/dxPryFAHh2rbRlg7HJSBrXQLPMR2JtK6Op68jv0u4sxbtVcHBzHntQjcAbT+0sTYROL5jnQkBZbVwHvGjxOlp5gO68pLprWi+d0XVnwTU7DkBW8/qjv7y3Pis7WdCQ8jOUFoRCR6c2dY3Ybq+XXvuga4+nCIl56zxals8UypKz7SLpQhUx5IXNSrQEUPz54jKiQ1ysp3C6/EbUbXjPtgGHm9lQzwHfaoWdrqzex0ng4X3lQ5COEOihguhSlOtC4mUx7NMNrAy4W6C1lcAYvGO96lKzKhPSpJjV6hzx51O7BuVOMqL4uN/po4O70BEzYdN8AS0XEpbu8Q2ZoUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YsTNuhYfyizg+T9q0BthDkvQsK/lxFRpg9c/7CPK2VHPT4C3YfLWzcBoojNTVsFE3mx0WwTnNLlao9uvD2bYWSplKLoiYBIEcoz542xHkIIs65QK8fNuqmt95K+CSWOdaa4QBI4yMSr4sDEUHyyaFRbFB521DEO9EhOqIi/7huhxw5QpR/Bsml8EOxV+aA8M6AqUVwZZVJpKyEJTGeoAQSPo7IUwv7KudHK+P+qLyJppI6PCq8afK4G2ku9jSK0zsKqpYE7yF7eaFgHWgG25JNOBGYBHcg8um7gWdjzeh/7OtnhvN5TLECMPCQ5h3knx/VZ4jsi8vbMlt/h/gT2782THvShmZ1pxMQvw1sGzRuYmoFOv4ZfNS8vH9Pde7mjNbaKCEGhBzR/08mg0Q6a5nWhou1eIG5kUhqqjNPqWYi2k1mX5K65F+O4Yll5dOvdA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 10:11:07.6801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cc7a8d-26da-40b3-069e-08de8be929cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016160.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
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

When a clock parent entry is DUMMY_PARENT (0xFFFFFFFE), masking it
with CLK_PARENTS_ID_MASK (0xFFFF) produces the value 0xFFFE (65534).
This value is stored in parent->id and later used as a clock array
index in versal_clock_get_parentid(). Since clock_max_idx is
typically 228, accessing clock[65534] is out-of-bounds, and the
garbage value read is used as a clock ID in subsequent clock rate
calculations, eventually causing U-Boot to crash. This is observed
as a crash during "clk dump" on AMD Versal Gen 2.

Fix this by setting parent->id = 0 for DUMMY_PARENT entries.

Fixes: 95105089afe2 ("clk: versal: Add clock driver support")
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/clk/clk_versal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
index 78a2410ca21..2e0c382ef30 100644
--- a/drivers/clk/clk_versal.c
+++ b/drivers/clk/clk_versal.c
@@ -326,6 +326,7 @@ static int __versal_clock_get_parents(struct clock_parent *parents, u32 *data,
 		parent = &parents[i];
 		parent->id = data[i] & CLK_PARENTS_ID_MASK;
 		if (data[i] == DUMMY_PARENT) {
+			parent->id = 0;
 			strcpy(parent->name, "dummy_name");
 			parent->flag = 0;
 		} else {
-- 
2.34.1


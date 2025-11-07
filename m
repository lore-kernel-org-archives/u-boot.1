Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBB8CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 10:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4789F83CDF;
	Fri,  7 Nov 2025 11:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XYLz/+o2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBA6883CEB; Fri,  7 Nov 2025 11:29:05 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A53D283CB8
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 11:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHtk59/URGJGdYjf6GRgcInRVs6buT2V+QVb37G/6KDzFHVEWW6BmS2jFE7uGvfThXmgjImSOY/m0DbE4VurrZdGdiCm99duUA5UAwA4fyPNoWXMUscwBJCvlZqQkzGUrQDpDKWy7A7dOG5nO8lmZY4X7zWNmJuZIHA28zbqpE/3KKADQXGufcCpE/XXv9tCpswLPTrHho4hwGAdyad669GXDnCmtnJMo+t54dqELBX5IwWJMUhOE+UIJI56rNjNlMmWtKLbNXmUAxtcqk0JnLLc6kDARecfW5wzuqpEUFy2G/gmd7mU2S+Ydlwwmz8DFr/4K7BoX8mUu780GCAZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+gPlQ4ImQkiRbFDtKDMP5jfKp2izZFU0WKuXO+Wteg=;
 b=rqKuDqa1nE8AkOOXBoO99+zTw+UENCohf8WkVmAklA7+YpHWtNtLnb49SL5/2h2UkRbgqoH37Tx2QnzVH3k6+ncGwyyyJmoyPDksTu5/no0BwPHlsnOJhaMVK4Yi23h1zaGQi4dYrm4N1uy/HmFnqkhG32VRvKipO9FUwnkWF56sQFJGbeEB5LNyPZn6SBmtw1+gcVHRK0dQlvE60Krcl7M9ew8ae58oEPEAqsb8kJy+rGg0M5OdN+ZW1xy2w0humKY8ZbA0mGgB9S6gW7hY4/iw7/Rkq6OkRjkUbmEqDPY3RoXbDPZryIWBgAGQ6ig7zeY347utyMADOam/cOrw3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+gPlQ4ImQkiRbFDtKDMP5jfKp2izZFU0WKuXO+Wteg=;
 b=XYLz/+o2+fJtO56O5Ilm/RyEkO48TutIT/lmWWpdqfPVeTwx7x1WswNf9TwTQEirnlBgopxBVou+hwEfopfhSfsDyQEz8oqBx+0Hmhtk7h/2PotaTvvrpIKwe1R/CJMstjASTLRWRz/8ZQwc2mvaNdGyBvMxVz/hXDc1Sos8QQ0=
Received: from BL1PR13CA0259.namprd13.prod.outlook.com (2603:10b6:208:2ba::24)
 by CH1PPFDA9B3771F.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::626) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 10:28:59 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::97) by BL1PR13CA0259.outlook.office365.com
 (2603:10b6:208:2ba::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.8 via Frontend Transport; Fri, 7
 Nov 2025 10:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 10:28:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 7 Nov
 2025 02:28:59 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 7 Nov
 2025 02:28:58 -0800
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 7 Nov 2025 02:28:57 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Lukasz Majewski <lukma@denx.de>, Naman Trivedi
 <naman.trivedimanojbhai@amd.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH] clk: versal: Use __data macro for moving variable to data
 section
Date: Fri, 7 Nov 2025 11:28:49 +0100
Message-ID: <eac8d0ab60a018d6c59aa28c49691839a3eec174.1762511327.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=f6KEvnpejlWTpXZDCLwRgpEed76rfnZijx0eWLHyuok=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTynnxk+z+xqTzA+WNMMnc1W8rU6t2+ayOmfLt3RuDzK
 un/d3lXdZSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEPvgw/LN/YGxoJ8msbTL9
 +6b+y8eePw15Fv12R4zAe27PcAXpbY8ZGS7PenmvI/7ZkbNlllLaC48kJVjJC79oebk15hT/Ain
 JLSwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|CH1PPFDA9B3771F:EE_
X-MS-Office365-Filtering-Correlation-Id: bccd8aab-7932-47a0-e100-08de1de876c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iNfPAmn6ANBfNOoDngcZMDDIxlY2Cb1uLFzheDjh2dUjZp+kIYlrV1w8WWmO?=
 =?us-ascii?Q?gs2PEaskU7bH37ZggKEF/pYxQ7nnLKs2vMTrz4/s1Ux6kjW7xk7Vedy6ooms?=
 =?us-ascii?Q?TWxOVuDKDSSdp293mVQV4ACExbHmUfX8fQo9DyW1+tXXVcxF6A1Fu4FRze1H?=
 =?us-ascii?Q?HhkQL551Y4XD/JJQZzYVkYuiKKszBPCdEA4fwaOB+SBO/9AMnPk6NmxGEkq2?=
 =?us-ascii?Q?dGLIrcEHHFLaejoP+jt7qgpbz9t1u5IzamZGzjsFqfLMqKbe/KSnKDarGbZZ?=
 =?us-ascii?Q?QKYQ5y2EE+5r1iOpY8B7/ahmK3joo9FMrsT5k03IteN0A8LP/OW2l20c7N9S?=
 =?us-ascii?Q?vRRlNTUNpeEpc95hh/XM7Ker+yOPU+WsZnfcbDl/TjwIl/oT/cri0HSGpqmT?=
 =?us-ascii?Q?4LNolhKkp7VDYNBIjsz6xL9LotnnbzH8fNueHiqY6W3r1GXwfAOOeij1VIz/?=
 =?us-ascii?Q?yOrBju4/hvAm6cyPGpLGLemTXmbcoXr1/MEusA50IO4uRYvdCKDetBYwN9fx?=
 =?us-ascii?Q?3V+Ooqo9l2w6o0Q8Nr7RU9tcG6hQM1sgGZWEo4btDyetOERd4xEADOAVWZfq?=
 =?us-ascii?Q?9aCH80AxtDA4vgB69b80ZXsFONwE4VzjF4yERbOsG/nGmEIjJ7azfh1Czjnj?=
 =?us-ascii?Q?sLIsvkovAoSsEoMSo1ohZjl1VBvJNvjp1wrZssW1uzdK7tDRDwhXB+HcPEO8?=
 =?us-ascii?Q?WkbW3DeXhPNBFhkr2wCDEjfq1NGEc5uw33iibJyIanz9Dds7y/Ec6YzxV86D?=
 =?us-ascii?Q?0ZK/QGeTr4KgGNYgrqumGuRFkyGpWBYnu1svgONShc3tueGpYdYxEY5MMc72?=
 =?us-ascii?Q?rgQSrsFe0156X7fprNfT6tvsqLHsGLKze+gPT+l7sgYJ90jKG1xa3haG01A+?=
 =?us-ascii?Q?laaLVAvhpe/7QysT6D2VqkJNNq6nH8Id7xIS4az53cFhFWOKxnaO+TiQb8+e?=
 =?us-ascii?Q?NHjwEtSuKTRl4CCTVOq39wsgXbc/+gd370t7cj1HOYhvG1A/81xJFf5M7yTC?=
 =?us-ascii?Q?Ihzdkv2C9VVbfsORGNZsW9QoE+ZgkP8jzX6lSaLK2Ame3qfUzdJqiaBFHs8x?=
 =?us-ascii?Q?aoIrtvH+OY1ZpEHsufJWKn4FlYpLRXIn+YE3cUTZnnZeoVQvpTmZQo4GN8x+?=
 =?us-ascii?Q?GZCEXaubZ3R12UpLEvKtWp/sldaMV42UPXsDyQc4gdjg6Q/H0/0r5vRvOzWf?=
 =?us-ascii?Q?iThF6aifMwvd5APTUVsONBjbAuGWo3gQXlaqs9wHc87lfdG+fWq/FgD4jqGM?=
 =?us-ascii?Q?yc3a9iLuV2K364rBYE48nIxfLiDv83tQinYanKs/o/KWdPATsOkpekhkCSBB?=
 =?us-ascii?Q?aBDEY0UyGdou5pHztFqyqVrAhS0oj+m3pWL74T35fvwN9G3toTF3fOxd6O2u?=
 =?us-ascii?Q?TIcWujGxzhmR4Pb8VkQJxbZy1WJgXWxAVLLpAhuB2WIzDHdxiiZssA+niybJ?=
 =?us-ascii?Q?uisY3b4lvquA0jFM1tt55rlls4pe+KVnXOIcU3KsTBkyrrLuv7tB62nECIik?=
 =?us-ascii?Q?fmCuay/lS0zd/3w40FLLeFz2HP8u6me46axkzWul7Sxb6pyvkYhPetPqK2NL?=
 =?us-ascii?Q?heeCMzF69eidVOREQ8E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:28:59.5189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bccd8aab-7932-47a0-e100-08de1de876c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDA9B3771F
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

The commit 1b267fe1824e ("firmware: xilinx: Prepare code for new SMC
firmware format") introduce new __data macro that's why use it in clock
driver too.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/clk/clk_versal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
index c62a747036d9..0c754943deda 100644
--- a/drivers/clk/clk_versal.c
+++ b/drivers/clk/clk_versal.c
@@ -106,8 +106,8 @@ struct versal_clk_priv {
 	struct versal_clock *clk;
 };
 
-static ulong pl_alt_ref_clk __section(".data");
-static ulong ref_clk __section(".data");
+static ulong __data pl_alt_ref_clk;
+static ulong __data ref_clk;
 
 struct versal_pm_query_data {
 	u32 qid;
@@ -116,8 +116,8 @@ struct versal_pm_query_data {
 	u32 arg3;
 };
 
-static struct versal_clock *clock __section(".data");
-static unsigned int clock_max_idx __section(".data");
+static struct versal_clock __data *clock;
+static unsigned int __data clock_max_idx;
 
 #define PM_QUERY_DATA	35
 
-- 
2.43.0

base-commit: f15a697077f107ca277a6aa73c165cd1293088a7

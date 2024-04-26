Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B3EC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 13:38:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 863E6881D3;
	Fri, 26 Apr 2024 15:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NSSrzbQF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77051881D3; Fri, 26 Apr 2024 15:38:35 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8D69881CE
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 15:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnzoPW3AxauZDGz3+HEKRBxauUuKlChz0gVMdzj/Na95mUVbeA1nGNL/xYRp5wXC4dOZfbKWw58lyuxpgGRlBxP2VTCy6sUKrQTSPlSFY2WXkI1M9V7jGTDr6SKVLsEqt7jknPBKU6tQoXERBpyUOfq4ywzm7Q6rfT9nOXwi+wzt2pARClMmXFuiyM2niETxERkQBw9Gx5RflbHoDsvk0VGfiJURdO07xhyRQcey4UfKUvbuUgULUSMJ9Ky6dwlnzUpd6J2iikpFkNzuKr3bYt8CJbIh/pdsoJDXBK4kQzqODPrWSRav+Yq/RQ2n7kMFl94rmXprUIgWin4fS/5d6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvlrc/Czggg0saNztVIpP1iAwdkl0Az2i848BCamEaY=;
 b=GD7CbYGF53G+GGQvivED9Oa7y7+mJnV2p+YizuwDNju8xB6LHwhAplFs2MbiBP2D2CAmnD9Bj4Nq8QhAuLg3a+bPBtTxn5zgEkLIx5NIc0WrI+NlXq9eaYCN0RTBckoJUcbtXOkD3HkOYaaU1rVTvsBZoaTRnF6aFRkzBpeWtq2W+as1dj0jHab37WcQ1ZNl/72LxMUCRaM1NL4gAYyJjAR4KVP8bGLJfNsHL6pSl/1dDoKg0ZrKSfqI+oXvLM/7EPNF9uQsegWAWoKPBHFkVbrbRg4E0jbOj3XwoK/rP0zJe0TbfzYzeF5x+McfmUVS0D5TwMbOiw/ylTwXjCYvUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvlrc/Czggg0saNztVIpP1iAwdkl0Az2i848BCamEaY=;
 b=NSSrzbQFZZM4T4HRPMm/Gozp/+kyTzG0Edx8BvtQasMuasgS2ipyq3qgpuvwfjsOuoz0wrFQOFgngf0kpf6VNYd29H7bSVpbMOY1MpR4XzWGRjNMCgz5D2V0NGHZkQOAkI8qatve40riwo6APbnQRHivySWzflTPLHEKXjK8j1k=
Received: from SA9PR13CA0008.namprd13.prod.outlook.com (2603:10b6:806:21::13)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Fri, 26 Apr
 2024 13:38:29 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::c9) by SA9PR13CA0008.outlook.office365.com
 (2603:10b6:806:21::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.18 via Frontend
 Transport; Fri, 26 Apr 2024 13:38:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 13:38:29 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 08:38:28 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Peter Robinson <pbrobinson@gmail.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] lib: smbios: Let detect the system via sysinfo
Date: Fri, 26 Apr 2024 15:38:12 +0200
Message-ID: <4e7e75bae7104bfca3964f7a442cac9f084a1f5b.1714138688.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714138688.git.michal.simek@amd.com>
References: <cover.1714138688.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=943; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=BN4+dvfLs3a/vN1ci14bGhyp8Q5ihnXbiQIe1OFtEcw=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjTtdR5aBxN+3Le7/7XV+m/TlheHeyXjy64arTadaBzxI
 zmO5eq8jlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRC7EM80PNF6aZyR9TlYie
 9jql8/exjAWl/xnmqf2T/W5ySjFljuyVp9u8deYWd99mBQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SJ0PR12MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: ac694438-a8cf-4797-cfda-08dc65f628a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gmkeLLKYrIlxnIM+5+tK2ijZp5Mee8C0hGb6a714vA+OEAJxvaViC9xnjZF3?=
 =?us-ascii?Q?Rzilj/9w/VpVbxk05nQLA9f8Nv4ZG02AWuxCjBPlULToEaR9/JLiPDKat3XB?=
 =?us-ascii?Q?K/6iTGlLEHC7e4SvVjOohzkT1hIn43QnPNfqf8KD+XAyGnhYT1Ecb3OCQRaB?=
 =?us-ascii?Q?UeBzWes5QZWXMPs4ErufHzzQ0sz4vUEPRKZwtjtTd6XQhp0Kt6vHKz95SivM?=
 =?us-ascii?Q?KE1BvmMBxknvZmwqfWmipvEoGrpPcPQqgN7ogLBx5/zyVNMwbeFisNISe4bi?=
 =?us-ascii?Q?snn2QkV5P0/QLj9LNp5YWckxlCgGOp5Bv+Qez0wCRKrN8a+ui8PwatwEo/2Y?=
 =?us-ascii?Q?mGAHbOCouFiAp9k9/Pz05CXq5H7nQUkT+xIc5Wnk3wMtt75ERbVFQrHQvAIy?=
 =?us-ascii?Q?xyKVXh/wmHF6MNtzVXaCDITZNJRX7xKViUOXe9MZHgKRCjKVeshVJJkGB+ZO?=
 =?us-ascii?Q?gBh4FrrQfubadlY98ms2iPqSsUvn895jc8/355uHTKBpjsez4bxKihiRPqhG?=
 =?us-ascii?Q?Ewn64w01FRaGaJVJEOT8sm1fl8lwQKNyAOgj3NF22Cy6ndEYUIpB+pot51y6?=
 =?us-ascii?Q?kq34rf+7UnEWPX4F34ckfm0XPa6/YNYJ74Evt3LW0PCyO+het4GyZLiq0CD2?=
 =?us-ascii?Q?5xju/NFuaUwdxyCLjWwuK3V6OJvcNOekCPHtwAWOtfiCC6aUWR39DUIt2sfw?=
 =?us-ascii?Q?aosOneyfv5fgx8JNV5eq5IkqvpapsbC1lilxdeHUfJMv7kPbl3mX4YwTeDgR?=
 =?us-ascii?Q?ieqyrZcQzerKm2+rlruQSsy2E1EX56vx5QGnvte/viQEtyyT925B7efDgx/l?=
 =?us-ascii?Q?/ZGyOXrJG+/Xf9mWPf3zceAnvq+iapl+S95P3YAc1XAMDlbD/PU6/5/OjdDJ?=
 =?us-ascii?Q?4y6zVii1BOPRkwXdqeBhALFwi1ASnoLQZDrO0HJOIb5zKfa63QPChyfdcbaV?=
 =?us-ascii?Q?nXaST0J9VTOiTQRHPQHBPihUey9Iu1NyoJ73YxnJ5bluZlvqgPjggeGieEFW?=
 =?us-ascii?Q?zB7pzjGs8EIvmsD5hq95qC2QuhbKcrGcX5v1Nn5v1pKckjhP5jkry66D8ghD?=
 =?us-ascii?Q?5dFLK0IPdUO8B7dvz4qn7HCXcehYWNESsruz0jNjwFcbW0OM59yciZHl0V8D?=
 =?us-ascii?Q?Me6a09SHyDIdTTrrLEt7708beIclv+jWGRNBvVDoMxq37os+7jTMI6BytU22?=
 =?us-ascii?Q?8KHuEHJGMIfqDlhDY23IUAqZ8iJw1uOtyUrkxpb6FW0k4Jgevk2iJnBQdxlh?=
 =?us-ascii?Q?KH+yXFofsYYXZ19Sawr+2BhksQuWSqEUFcpjNG6nh++qWExGUGC/GrUIHbk2?=
 =?us-ascii?Q?ilgMGOThiJw+q5z6G3EVfNhtFaj0lLxNR1LEbpojwv9PDijeoEXAv5fmKNKO?=
 =?us-ascii?Q?irXlc8Mg+KMnX0Uhp5A1pzVt3wGo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:38:29.6898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac694438-a8cf-4797-cfda-08dc65f628a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880
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

Currently code looks like that it sysinfo drivers are supported but
actually none checking that system is detected. That's why call
sysinfo_detect() to make sure that priv->detected in sysinfo uclass is
setup hence information from driver can be passed to smbios.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 lib/smbios.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index b190b010f30f..3c1b3cf47e72 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -573,8 +573,14 @@ ulong write_smbios_table(ulong addr)
 	ctx.node = ofnode_null();
 	if (IS_ENABLED(CONFIG_OF_CONTROL)) {
 		uclass_first_device(UCLASS_SYSINFO, &ctx.dev);
-		if (ctx.dev)
+		if (ctx.dev) {
+			int ret;
+
 			parent_node = dev_read_subnode(ctx.dev, "smbios");
+			ret = sysinfo_detect(ctx.dev);
+			if (ret)
+				return ret;
+		}
 	} else {
 		ctx.dev = NULL;
 	}
-- 
2.44.0


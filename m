Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF941C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 15:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F20CF849FB;
	Mon, 29 Jun 2026 17:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cJ82FP2q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21C0C84A0A; Mon, 29 Jun 2026 17:44:23 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B35C5849A3
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 17:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDVQKlN30+PJkrDJvAmPPrCpNEfNYKUMOBtJTUDd0WF4LNRJCc3tgr+Xq34n3OMZ4KQZUhtlfhQhvX8mrPKEGTW+ffk8KVEYsaIHSSmUkXGErDGHln36YaS58b0ZvQWNaXmpDBt/tEFW/u1FndCqx5Rfm5Q3iSTQ5m/L9f/MgoMrWSaZdTLbQ27TKIviwzA6VsNCNsWacXPPif3VhgZ0ZsJsEinSIZtLZS4Dh4Fb1VH4lJ5XlCGmyQFHYH6N4+NpP+ay+M4mnIuO7TfcUQz4BHvlh2bgC4tXc3REsvNv07ruoJg0CXrlky9ZPYRWqKiwTvmzx7S+XKzcKO1rDMhP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTa+yPSHlYx+1nrvStZEBCmtxn7zt3r9bdtaAfM8ha0=;
 b=uYBg12G8FV37yr585OJTw9IpF1Yl199fof2FHs7wV4hClPnXvYhKon7O0FHo6Kr98V5sErooBD7gPObj5ZEgRfvi4Hd07W4lB6ZYi624VG1UrMAAQIBMTVo+eaIbWn/6Y85bl4wAI5jveJau4D06Uzbxdoyy4pxF0CIlzspz9NinoTODUhD7hrgneo2lVnsjRvCwG8rnIOMQlxKxHISc0IN0XL2L5sRGH8KYlBd7V9WA4onaMa1oFi8xzb8c9zQUIw1fQOM7KgVQ2NfpUHEOHprJrhqSN95adQZwYHVLJ0HvUzCDad2v6F3WJI0hQ06oSkmxhFsdBnRZEQROTo3kBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTa+yPSHlYx+1nrvStZEBCmtxn7zt3r9bdtaAfM8ha0=;
 b=cJ82FP2q2S3TTzhrau8KWnAnwZsWedH0cqk32PckxsCXkMqfqG2Rt3Vvg6/72sxlNzE4PLZGdmuUViOQg0jd/mvitXxhfQH+Cm5bBPWKUXq+rCk87S1SUsrKRBN3LUdodx4uhw/Pz1kobHrbjwDJ/Zf0IYe8xSKSM5T0bfj5duU=
Received: from MW4P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::7) by
 DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Mon, 29 Jun 2026 15:44:16 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::6d) by MW4P221CA0002.outlook.office365.com
 (2603:10b6:303:8b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:44:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:44:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:44:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:44:14 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Mon, 29 Jun 2026 10:44:13 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>, Chen-Yu Tsai
 <wens@kernel.org>, Eugen Hristev <ehristev@kernel.org>, Heiko Schocher
 <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jerome Forissier
 <jerome.forissier@arm.com>, Quentin Schulz <quentin.schulz@cherry.de>, "Simon
 Glass" <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Wolfgang Wallner
 <wolfgang.wallner@at.abb.com>
Subject: [PATCH 1/2] .mailmap: update e-mail address for Abbarapu Venkatesh
 Yadav
Date: Mon, 29 Jun 2026 17:44:00 +0200
Message-ID: <dc57b5048b5c64693b5347b811ffb8cd5107770a.1782747838.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=KrZDaJxLAqg2CjFWa+rHgH1XlR71bqeJKUZTAQqGQ1Y=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ5TTqofOOe1bLDLK2n+GQfmbf8MAnfNf/04Z8/r+8W/
 hcitW7K+Y5SFgYxDgZZMUWW6Uw6Dmu+XVsqtjwyH2YOKxPIEAYuTgGYiOAahn8Wr8yKLaueKYXx
 /lh2i+nLes71ZnHrPhWnLFBf/UAiQcGTkaHl6qsdt+Y0XO+tX60kf4Zt42H//2f4c8OPyFT93hh
 ZJ8YHAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: fd1893d4-0a42-4fea-9dbf-08ded5f5465e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|82310400026|36860700016|1800799024|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: vuk6JnZBJLMnIknNw5f8s+G4E/FzBEZakRihqczPJmFnzT4PvSKoZSIqg3117wj0HiUuK5XN7ILzPx068pFGKJ/DvYJYoNkSQdhayXNNBsKpW1oPvqmg/tcI1kibIJ4VYCRdzgPUpbdP44Rz8A2scc+hSMhJKnpH4mNX4GJlgKkVfpyeMuS94NT8FW+ZM53GHampp//wXMrI3lv/3Nuc1Q7MoT1gB998QKxpN+LyUrxBcEa7KTOlHNifj7ANuxLCNRTorTZGEfphKsbhqnmlibQPI9LSjktVvVQJ75jC0jndA9cN7Yfvon+7YuSc6XBEZhzzrERN4siPr8ANZitKLV87J22ehT4KXOJDdAaIaaXVsoqXdTuTY2vEwfhF3ohCOFjxITtJ9VeugdmYV8l+hIRzSk4nCosSi+k3NM+Y1nGcsUx3lRGYZsng3hpcwx6/AnjhsMlrEg/cEIi9LCVhkhLmrbX153d3hbLdc/WpZMzCQkdTbZajZs1p2c/NYcaoJ2G0qRjfS6EvKr8SmJBqHNvBjvO94fXDjNDvt4PriOpSQlR+Iq4GqGQO6LYDm03nmwKT5anaHrborqLzkvaLTRff52xaaSOLfvG0Mnl3ehgV6q5Ys8QRIRs1U+AIdzya4eGNePy7qz5QMwVu/qacd/Wvqu4yCx3CW6X+FjECL8LwCfF80zcIAfXOSlyMCfm252wu5+0tmu9SLk5BoEZCNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZYox7AP8cC9sTBtWBFGkyB3cRNYrk3tCrgDn2Wo5915lmeW1DECMZoc9sbS/9vw+AtOFy5qhwaz4TKpFGkoPkv/aJfucfeO/TgzOZQ6NlrZdjo6CKR9YU5M/PmEHcR9AGFrDuhzB/9akUp/eMQiDN1gZkxSIvrtFtjKBbOZeEaxOzOaUX89K/Uqk0j4T/sXL03ZBQulvXSmxEafYFQwE+cUzliA9EtC9O9styp0ItnckzMeIqOLwdoAh1wzvsP2WgbHLOLS+DvGxe4Hw2ia9MWBRaqeeEPZsOTA0SkrUK/96hN5QWsPe9sS/SFMzPqFs6JwBUWWWednZT7/5MYs6Xzj9bwK8WfvAyLe5i06RgAd54AS+wq8a70Z6SR6WGKDf2FVGQHZSM+jR28DEiEhT5F4Snd9UqgQ0Mc5fZTfV4pRR5hYhEKtBgiFvx+AyBmIS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:44:15.6398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1893d4-0a42-4fea-9dbf-08ded5f5465e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771
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

Name and email address has changed but format wasn't correct. Keep origin
line which is doing conversion from xilinx.com to amd.com and then have
conversion from AMD to Qualcomm. Also move name to proper location.

Fixes: f21920f7e795 (".mailmap: update e-mail address for Abbarapu Venkatesh Yadav")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .mailmap | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 7aef23fd7cf1..d9ba6638728b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -16,6 +16,7 @@
 # Proper Name <proper@email.xx> Commit Name <commit@email.xx>
 
 AKASHI Takahiro <akashi.tkhro@gmail.com> <takahiro.akashi@linaro.org>
+Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com> Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
 Alexander Graf <agraf@csgraf.de> <agraf@suse.de>
 Allen Martin <amartin@nvidia.com>
 Amanda Baze <amanda.baze@amd.com> <nicole.baze@xilinx.com>
@@ -153,7 +154,7 @@ Tom Rini <trini@konsulko.com> <trini@ti.com>
 Tomas Thoresen <tomas.thoresen@amd.com> <tomast@xilinx.com>
 TsiChung Liew <Tsi-Chung.Liew@freescale.com>
 Varalaxmi Bingi <varalaxmi.bingi@amd.com> <varalaxmi.bingi@xilinx.com>
-Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>
+Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com> <venkatesh.abbarapu@xilinx.com>
 Vikhyat Goyal <vikhyat.goyal@amd.com> <vikhyat.goyal@xilinx.com>
 Vishal Patel <vishal.patel@amd.com> <vishal.patel@xilinx.com>
 Wolfgang Denk <wd@denx.de> <wd@atlas.denx.de>
---
base-commit: bdcadd64dd750f617943ee7088ea4724e19d1f8b
branch: debian-sent3

-- 
2.43.0


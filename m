Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161FEC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 06:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 488BF82B9D;
	Mon,  7 Apr 2025 08:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="WEUxBGUY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8538E82BBF; Mon,  7 Apr 2025 08:07:45 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::70a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F79A82B7E
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 08:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qu62gwj5rkBInsShMsNymiSSW0VYgkzkbNoHjuTSCzoVR9CD2/QxfvEzR2kB2GcCebZrHJTIdnckMEHNcFsw+wGTQcmnez6dCOlB9+FbYs5FFXP286q246y6LnIjXOU+cYAI1b52pqivmVhu0VOk3Unw2SHiXFz/Q3PBkpl0gs7pn1bLOsbDzkU/N8IlyAOu+PLogFxbWUvJwLXUz3UPsvyfkEAiOyj/A84Z4AsK9M4aG7nhFGlMHjF0Xu8v3KddI6O2Rs0E2ruzj/4EB0pA+6PKIjNSoyU+xuSre03fJT5/Do1rVztVa4esYRie2OIF4ihL6Y8BKT9W9oFdtThtmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01/azFyiVLuVYtIQIGl7IC2P2ms0yrrkLHdabgrfA1s=;
 b=jg4Su7qYs1cXesekyppapapLvhexLslv6rEaYWAul3QmVxghdMByCGT23XbDi2Mmps0t+BUmPf5qePcIH2gP8SkKTtmezJwOYzRwxq94zt8RP0jMkYTTt0A5Yo606EGJFc+C1xr9wO5QiwIs++9QX5KzIwAG5GmsNBUbUq8F+IAgS/sX3+RHHWCkxlPXAqFuw/uzcLiUOTm9PZcW3ws3VJGP5xy2MBbAamIECRKg6Z3nfX4TH+55t4YGFbllHZTFnq4y5Tld/BKSWLK3s9Ri0NP/XpDYAwZ4WbggJIadCe0eJFW/HEVVaXmFZHZ2iHYS5kDUqMpxEgauFQILqiI4nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01/azFyiVLuVYtIQIGl7IC2P2ms0yrrkLHdabgrfA1s=;
 b=WEUxBGUYfURbDU6dRVaxlaYJ8MbKrp1nemmHKesDvqw6YoqbmwWi7kkaLddH0VmmJPLWLskpT3NIga+fC5JMCf5uEi6fIxhZ+ojk2yyb7IIl7kWyeKOOSUbZL0S2Ncq3Hv6pXh6keZfvEri2I3eH+GW/bSjYfFkeVkca4Hd/JpGse4pzp9puGfzYsMx6N7C7fRA3ZzuxHOThpRSi22au5h1kHzyJ8cBT9zBHedFVDgkm0dhr1QzWrJZxR2n5R9D0sTREtKwPj91/vxjFCwYFhCidXFpztR//xZo5lahli6f+oq2wpwOG5ENdt0UUyEkIjh/i19y5nTV0mTj9LpqYAw==
Received: from CWLP123CA0191.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19c::19)
 by GV2P195MB1988.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 06:07:28 +0000
Received: from AM2PEPF0001C70E.eurprd05.prod.outlook.com
 (2603:10a6:400:19c:cafe::82) by CWLP123CA0191.outlook.office365.com
 (2603:10a6:400:19c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Mon,
 7 Apr 2025 06:07:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C70E.mail.protection.outlook.com (10.167.16.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Mon, 7 Apr 2025 06:07:28 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 7 Apr
 2025 08:07:27 +0200
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 7 Apr
 2025 08:07:25 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <trini@konsulko.com>, <n-francis@ti.com>, <u-kumar1@ti.com>, <bb@ti.com>, 
 <afd@ti.com>, <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, <w.egorov@phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH] mach-k3: common_fdt: Fix Label Issue
Date: Sun, 6 Apr 2025 23:07:11 -0700
Message-ID: <20250407060711.3160366-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70E:EE_|GV2P195MB1988:EE_
X-MS-Office365-Filtering-Correlation-Id: 17406f74-1d94-42b8-cc12-08dd759a79aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FpQrpb3DWzIZYm76okv0D4lCFLDh8ntwkxOo4EZLkV5jiNNcZHJYWZ3GGl3w?=
 =?us-ascii?Q?CVHkJi2/pNXAqX5FVJSm+iRErJKEQboR2zzaDRI1mi8ZSs3PYKd+gCitZhRw?=
 =?us-ascii?Q?2ufjmm/90Tkml8otyWXsgUfUKgfh7vwJDhNIdxP1uuMMusoMaESS6MuYChXi?=
 =?us-ascii?Q?53idY8Znzl4OSF1GiKw3u9JrC1UDAkr2ecfCTX2QSXapwNG0T3iZT8zncKlP?=
 =?us-ascii?Q?ehWZmHycVHjeYSytG40V/ZUq1nXJTrtaKhndb62PP9aHIsdcyYwyilLBGSGL?=
 =?us-ascii?Q?KxBRGP5nOLTC2GHseDgOMQ/uT5E4WscaKHC5SI2bBnN0clw682VOam4TOHqQ?=
 =?us-ascii?Q?K0RX3e1MKIC05hHeEDrc9h1XBe8TCeDos0ShseYROhXMgQ67TbRIhF13czt3?=
 =?us-ascii?Q?FhLfzF3FfVmpCTRHb/c+5FXaC41/uHlYh9WNgiGB9yXClW54QMPKlJ4ZdaSj?=
 =?us-ascii?Q?ps9upLKhNrcK9AB4Rr7/NRzYI6Zh/6KaneosaxpzA64ogOgDJs/cgpKoD17n?=
 =?us-ascii?Q?KPJmutGjOKeEiz3bYRLpJCsdF0Q+jsc/Ijr5BFQK3qkKbwLlwnK6jN4vF4NA?=
 =?us-ascii?Q?HphSrE7n6SmI3QtNNFvPajHsFft+nv62E/9PHJwH1/3KUY906+bfSUTwElPJ?=
 =?us-ascii?Q?ZQpAUSPYf5fYOWJ6qCWlGmd3ziQR7T89FNEdlYQ9CWXe13IAlrAPOC2Egz4o?=
 =?us-ascii?Q?jLq2PXlZtxr51k33szLRpzhWSFxNtXHO/5U76F6ACYJwjHo4sSp2d6gxmenL?=
 =?us-ascii?Q?LuGQmKChZcZ0yrk13azcjW6okNrGnwoKS5IcT0A1/Bfe6SThQbpJQFET/X92?=
 =?us-ascii?Q?LrcLvIfRbM5KUei0WsRsUSD+062iR0xnPMfK4wYHFLfxbAy9Y4c7C54ePYzh?=
 =?us-ascii?Q?07dHW1EQWfS5G1yc1/lx5gSKYRjQDKVuLdTPHSJRjRzzh5UH7+wEu1LC67Nq?=
 =?us-ascii?Q?FMDKR9RsQ6OsLqnTphLOa337KSlQQpldsx05KMM4BV+cJ4mWVNNJqEDHjMg6?=
 =?us-ascii?Q?FSHMFmD5CDx/pAIvbOpXWLjrf3zSSqpYqk0aahVqbwZUvFrJT1bllDUE8GCM?=
 =?us-ascii?Q?QemGk3hrH1bk4TQh4iJLD6Rc2MmqQZtAE70W8cLKj3c0hYFTChGA1JRHPRax?=
 =?us-ascii?Q?1F16Eh8ZYpuxTHpGI9i+HtuAlEWALyfP5gKe1JLym0MXGVLqDWhK6CAAXdfA?=
 =?us-ascii?Q?TJEYt57AYIH9Znxh+3qbJK8FZfozwEZSbcyf7oSolgkygZq+NcQR48/Vy+kI?=
 =?us-ascii?Q?HgkFze3VIJx3qEa/VgI/efeIqk0uXGUowU9Hp0Qr+njDBl5ul4igj7N+CD6o?=
 =?us-ascii?Q?8Jz1IUiuiIZLr24yQdSx4oecSG1SuWJKQz7kEmxYnjt2tYIvTlj9SsTd6+EP?=
 =?us-ascii?Q?Q4s7zUydq0Tj70IEjvYTCiDbsb+hfsiA+5Dzjixi6JHPZPt8+blKnlXyztyO?=
 =?us-ascii?Q?0R7Q8xMwsgBAwTzDNuiH35R06wLV9G9r4n5mkzI3ndsd3BDYVyMBcz9gV8ue?=
 =?us-ascii?Q?2Y6eIVCgFFQFh4M=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 06:07:28.2659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17406f74-1d94-42b8-cc12-08dd759a79aa
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P195MB1988
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

Labels are not allowed before declarations. Add a semicolon after the
label to introduce an empty statement. This will fix following error:

arch/arm/mach-k3/common_fdt.c: In function 'fdt_fixup_reserved':
arch/arm/mach-k3/common_fdt.c:156:2: error: a label can only be part of a statement and a declaration is not a statement
  156 |  struct fdt_memory carveout = {
      |  ^~~~~~
make[1]: *** [scripts/Makefile.build:256: arch/arm/mach-k3/common_fdt.o] Error 1
make: *** [Makefile:1919: arch/arm/mach-k3] Error 2

Fixes: 096aa229a9e ("mach-k3: common_fdt: create a reserved memory node")

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---

I'm open to other suggestions! This is just the easiest way to fix this
compile error. BTW, master is fine since 096aa229a9e is only on next.

 arch/arm/mach-k3/common_fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
index 361b0c0b31b..7178918a12c 100644
--- a/arch/arm/mach-k3/common_fdt.c
+++ b/arch/arm/mach-k3/common_fdt.c
@@ -152,7 +152,7 @@ int fdt_fixup_reserved(void *blob, const char *name,
 		}
 	}
 
-add_carveout:
+add_carveout: ;
 	struct fdt_memory carveout = {
 		.start = new_address,
 		.end = new_address + new_size - 1,
-- 
2.25.1


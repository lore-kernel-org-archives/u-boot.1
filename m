Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E22C3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ACEC8852E;
	Thu, 27 Jun 2024 13:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="aAanw7Cf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6842F8856B; Thu, 27 Jun 2024 13:29:14 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20719.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::719])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 886E8880A5
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zjv50Q65CbY3x7ZB5WUbrEgp0Nnh30Nex8M379Q/Kr2F4Ak6mQKjfd8SE8Jbn0ZTvjoZxrLETooRJEzwhGc+9lTLizlYNLcK1TVGR9G8a6e79PmCjhjO/aBMr9IJ+K8gpxClfwsob+vRlJXziFSzPiihvP+l6V4hMxLGZeFyno2V8wrXSNQMubSMwaFj3CJ+EDplucMgBu7UZDryogpXreiwJwFIwihw8qpw88D+ATWuQ5LsAJBWG0mM2XdlDWEXbQ6p9BRMJyx4v0EDF5kahGzRI3JDrzo4Ks7scOBG0nEAhybG/xrwIRY6sqNt7cbz33r/rvyUcyG3ELl1AkMVKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fo9TCbWOQQWrNSXfkLuqNSC615xpjOcFyInM6PhhilY=;
 b=NQfH34PF0L+X1WGlVeAIXxq/xgxE5Cp81H+GEhY506S1o4VcX7K90cMEvCT093tq9NEan70Zu7uOKLdmMOLoI8+AvTQRorCqj3TVI39nuVdbWxdHNZO21Kgr5R0VWwCZs6fQNUJg7fJ1nb1L877xErtLTZmOLtOf4gKAgZoLYl7X9I5AbkYhOnPSi5GDXOFY/YujEpL4tefiyZ8hBjDHJRGdVHkA6BbV3qJNFZv+EA2wzhFTu2Ze1UYGbng+4xR/zag4ht3N3hq10VmcL6ymYvUiLb/d5UOloULOCXtFlELFHVEczLfUZ/1W49D6AggvBcNrfI772+7/LaGzzFCrYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fo9TCbWOQQWrNSXfkLuqNSC615xpjOcFyInM6PhhilY=;
 b=aAanw7CfOxICqJpXFpTqRuU496ddqF2eOI1q908RQGXJrRP5Rn68IBskohcNW1BMj6LSi8hqbk0EA6vNpZoGHBOcl7gXG1bp/CUyLbBjA6mESwypFSUhu4W6vaBc2/J0t/oNXGoNOHXIeJjHJ4FFtvCNCDvF6QFWQ9DFdxGObOLTLd/vgNff3KMmkw0qMx1aNYeynWCmlhbZAx6lN9WBKBQ9D3XyUX5iQYYHNApVOrwO5HWNTkh7ewUWnE0uFYt5dPwcjiqG0Mmly5fnEu9rKqwAzxVn2kzd8QvWgVJ63ZEDSKynJLuE5GTqA6rbcSjmKKXn3zT3P6ioP4EOjmCx7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6686.eurprd08.prod.outlook.com (2603:10a6:102:13e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:29:11 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:29:11 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Joshua Watt <jpewhacker@gmail.com>,
 Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>, u-boot@lists.denx.de
Subject: [PATCH] gpt: allow spaces in partition list
Date: Thu, 27 Jun 2024 14:29:04 +0300
Message-ID: <20240627112904.99969-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::16) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 401bd8f9-d94e-49fa-a0bd-08dc969c5db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|1800799024|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xuI+dUgWIk+AEYtYZFESF9pCBRjbjyPtkffMFT+ljpOzO/mbRezBuK4wYOwK?=
 =?us-ascii?Q?Bup+eHMbx8rkrDj4btNw4qCaVhoEBa4uJOLCEd0neGU3OlthaoGCp6AXPiNJ?=
 =?us-ascii?Q?d0BE7pgUNcGkjqev7TvIxQYsJb28jGMoz7jLGfa0YZFo4uBxumm+L2XIoq08?=
 =?us-ascii?Q?byCoGCwb+wL/ZnbP/DfGPy4bqvoI6pWYjv82PEfjca1vvDFVk6PhexoSxw0v?=
 =?us-ascii?Q?Qn9x4K+BP7kWQlmoedFC78KKS19bUFidmpLFi852FYLuRUnK0ELfrs+NAdrh?=
 =?us-ascii?Q?tavf8ZWq/7Oee+fdP1Hn3NtQL4qgrxk1eSfXDsN8e5FKI0s3XCTs3VSD55Vq?=
 =?us-ascii?Q?cPANXiwdzm93CngFZHER4EffhaR8Heu+ImefSrs64u1GCxngix8U0EexcQ3G?=
 =?us-ascii?Q?Du+LPDByEdrt/eLY6mPlCboJV/0vUineXWFllfPfFou0dF157zlKdCmc2ujt?=
 =?us-ascii?Q?40A1ObmdTx+ulbWJWOnTwOYyOx2vVXG+X8odAE44SMPqJ2ObRImhIiCD9TYB?=
 =?us-ascii?Q?Dbfxu9jRnbt6wAkOA4eM+jDJX7zTdBW7Ko2dZWOjIxahZY8e02hyvDFz17vz?=
 =?us-ascii?Q?qguWAJz8lTx+ZpA/ZEE5kEe4CWYHRmdUcs7por1p3xFCLbYNQrLfm8aYQG67?=
 =?us-ascii?Q?41Sg/lM3a+JvVTrZjP42dyhKcPXry+mhJvFGsxXSDYVJfjConJiqbpg4kR8x?=
 =?us-ascii?Q?oVMoVAWuVPerkG0vdyQp3axUse93XcP3AD8oLnF+4V1N4UYHWKtY8iQDZiNa?=
 =?us-ascii?Q?GUOIXOj39GjSmVuTpMEAO1+FedUreEilmzg+HsEqw8PEqHG/O/sAF/2057YL?=
 =?us-ascii?Q?skGyZa0xzKFCYIZxNH3OpgLcWEbpv3sVpal6P7W9I4ve22N3l5ZCTrWRgo0L?=
 =?us-ascii?Q?o3emgnsTtUdRnhcByKUCXMdjlMXE9V3tRaknIfI1iIbReuQINKxbkS0MJW/U?=
 =?us-ascii?Q?tsRpn7NgYkMvV7D3CgpWCvr32u3aSePn8HjN9XQOVOEknGNXPHl1368QDqsA?=
 =?us-ascii?Q?C/G6Yg+J7m64iofaXEANvqMjBHof1MmfKj8UKiwqpIbRX2y+YaxBQIM/rRl9?=
 =?us-ascii?Q?+Az87NC4fgXoNzHTC22ki6AbzSMFS4W7LLfg5F99uBl3621STKU807LUS9Yu?=
 =?us-ascii?Q?lFW7LgGrMXH/Z/g70lzptA9OPuN0F/Wgj6k9Mw+wd6Uu6je8qzjinZPnaQob?=
 =?us-ascii?Q?ibPIC/dahZ131LQf7W85MoGUR+buX4ip3w6n3pjYGm+RdoqUHk723+HLyqiC?=
 =?us-ascii?Q?jG82Wb27FfQDp56KsseoKESoEU57I3Q8EetMj3jPVI3joThe4BIj0mJbsBbK?=
 =?us-ascii?Q?mV2TmKFNzRy0UeV/tzRhBnvTXU1i6WbPoAhTVBb6xdgEesnF5h0MeexVGESR?=
 =?us-ascii?Q?sNFmpPkqSxEmoj2cGM0vGe9SwPbmd5Bx7sZED55gHWbq3n651Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xe2T2wT7l1a6qNPk/4STGxQPMkRqiMQWYz5WY8c+2IzfqN7C6iuL06mLPynX?=
 =?us-ascii?Q?qfNvdclFlTp9BbMHvcm39lYECVsYx4wo7SlSwmZVk1pOvSSiiJ9BnTJfQmsO?=
 =?us-ascii?Q?0NBWDIaiWACBwni77m+gNFGGmla13Z1DjDyP3zp1Tb1xmzoXZAjZX2NzgRrD?=
 =?us-ascii?Q?FmMz5VFFe7H7N6/im9YpjjdcBqTjoetz2TE+Ib7XnFD2tyfsuW5SqZcX7rz5?=
 =?us-ascii?Q?hVbvn1R4kFMVHpWiCumTrn6mbbykn5sap5N6qim84VpD+m8d3sY0A0Zcc9gx?=
 =?us-ascii?Q?VpTLX8S/NAogxuJaWP5nqZzuvZMGoAjmSgerg+F8BsY73jnYIFXLS/yYANiM?=
 =?us-ascii?Q?ExnbZf5ODF7IjJtjNaxk9l9uT//6R3VhsX1LrLvWlf9ieNVxPPonqvexGZDv?=
 =?us-ascii?Q?p7/pwy88vhVhBI5M+K/QNovRpq4p65m6UjW7YEUaewSr6X+iJUDLmKugonMM?=
 =?us-ascii?Q?rEQpB69IcHnIi4VC8e9wbTVwKVHxc2tnywoFK+Mywgv6nGmzQTWdb/eGT19e?=
 =?us-ascii?Q?ywMLRV0Q0Gqhz40Sc4OeP41tCt6ZUKK+C9RpTrOmIWKGrEf5sDnroWIHgkbS?=
 =?us-ascii?Q?gQ+WleMA3piByIDPG/CCIF8vpICJo+A5yvgfPiBZH/ywW0ffmNf8qehGgUiw?=
 =?us-ascii?Q?rSOvyBIyPId8x4UDMWJFny69J6JXheqbDSgBwoVL8v/88LYT4p2Uc6p84jyq?=
 =?us-ascii?Q?ncOqOOTxW5Eopb1zm0qpx32TpJwW7fwwvOPUhf69SClW18w40D1Q6e4OdkgW?=
 =?us-ascii?Q?z0LEkXUl4NNxYOKOu+YKmoqJZDFHjw6wfkWX25f1BU1+zs7pC/mPAqOgYoYm?=
 =?us-ascii?Q?0gk3hKrscHy7JDTSueAy5QZD8pAank8QPgqwCk9VVxlKwoiGrI95HOCmJsou?=
 =?us-ascii?Q?uACVQ4Sjh5xycwB6IHwoWKpJepKepyeuPLg7SWsOeELp7maki7PsWRIDTTN7?=
 =?us-ascii?Q?6YGunpHPO5N2wmgKF4NTT/JPNjTRxyXWe1PBYQvvBNr8paRTiJKZiem9NQBa?=
 =?us-ascii?Q?W0n1z+LOd4n3beG9u2FiL+mdWNyEyujSo7fPU7AvAnsUSRY71wWyi7biGlge?=
 =?us-ascii?Q?e/SQvaxiYpBQYaLn5FdUZwV9teVf/EFprHnzZEF1X5mTTcYDi3iwnCn76vB1?=
 =?us-ascii?Q?sxENs8CZFfZ67qitthDR40bAzB6QAKVwxma/8UxFvT7PhMPRNyE1M8FMxR7j?=
 =?us-ascii?Q?UtNRM7P7J5jfwsE5bn95/MCQ0bU9R7+FCgJesWcn4EGCrXsF1Fgj+cqDRL8i?=
 =?us-ascii?Q?UfiMT/qOl4mMXD69XXwCf2ux1QJszKNLVCT3cJ/H6EKmeDfsatdEMLfj7REZ?=
 =?us-ascii?Q?cp1G03fcgOgwcWGn+Y9jBZB//ZswvOAWZV4Z/lGRnfoUdQOHnKChe2ysqAxR?=
 =?us-ascii?Q?U5ETe/Ch3gb9HDnhRJ+SM85YuSSKOwD22jwFGPGcbWWz8jPP/DXG5a+QwSRg?=
 =?us-ascii?Q?SfXpwvNtbm4MTXsW0wk1IcV86SEBup/LrAxWESroPdhHNUD2InJGEv2tIYeY?=
 =?us-ascii?Q?6WXrhYp3UuDq3Xr8LqlvS0cfzLupveqVYp9NjXeiaJj0b5mWtAe6i0RoxXZA?=
 =?us-ascii?Q?uxqFLtMT6buqnzb29jll2D7GOByaBx3zVV9My0ez/N2GYOFvPcAaO8YkAa3A?=
 =?us-ascii?Q?e2H4o6LdVeQfA4bXhEfeK/w=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 401bd8f9-d94e-49fa-a0bd-08dc969c5db8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:29:11.2847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyOjgULl0zrfVoCKiLdpu9gK7qRBqVrsh04s5idtzFqAj3fH6WHgTYQ+w675ubfBDYrvchq+CHV1IknNLky1k3ckSAgj3cCT7rpINpsOcrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6686
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

This allows spliting partition list to several lines in environment file

ex:
--------------------
gpt_partition_list=
	name=boot1,size=5MiB,start=0x100000;
	name=boot2,size=5MiB;
	name=rootfs1,size=70MiB;
	name=rootfs2,size=70MiB;
	name=overlay1,size=20MiB;
	name=overlay2,size=20MiB;
	name=art,size=4MiB;

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/gpt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 7aaf1889a5a..2b29ab98ccc 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -117,6 +117,7 @@ static char *extract_val(const char *str, const char *key)
 		k = strsep(&v, "=");
 		if (!k)
 			break;
+		k += strspn(k, " \t");
 		if  (strcmp(k, key) == 0) {
 			new = strdup(v);
 			break;
@@ -151,6 +152,7 @@ static bool found_key(const char *str, const char *key)
 		k = strsep(&s, ",");
 		if (!k)
 			break;
+		k += strspn(k, " \t");
 		if  (strcmp(k, key) == 0) {
 			result = true;
 			break;
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52026C36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 12:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CDAE820A0;
	Tue,  1 Apr 2025 14:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="EYVKxf+c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1296A820E1; Tue,  1 Apr 2025 14:28:29 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0B1D8209D
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 14:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJGdbajLHB6ZNmLUhAwlKcfTvrpHRCFV/xOHSjA06+XUkvSUNMfPR8ijOMKBF4+2G+Xc3Ph+YvgpeLo9IK/i2dtQWfhZjaP0Arve+3u2xF3ZDNvXbIjEJb/bcjmwTqfW43DX5aatvgnygZrlZ1XfGYdjkbPy7aCORuQQ3ZbgLU9T4v6lEOsK6BlBku17pysuEOPW2/CE6I8d1uKSaMtgC5ch9y3eclpmf/k3nJQbq2g/BJyrwBXD6Lqk1txXnhPWpIvuIPQaR2/U6A/ocBZVUvzUEJnGedIf1m8QkjL30eMCgX/dFlpd8uL90Azdx2TTZEjJ+KplHPltQxVFt++Y+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6v8MrpwL6azZ/Lpxe8te9lxdm5yqYOFX3G5Px1BTOE=;
 b=Stmftk/OqDGAwmdbuPTFZTLn0LxK7yEjlpBolBr/J3cQKaYl8YraW+nMMzh6YFSOFuFWZ1vqLu1Vpm1wq/xRMOe8D4+96VtAl/CMWwFn/HjB/SABzLn87IDdJc6fxufjpDCEe43u4XSWABEufSzq71dI8m+V1Kei6Pv2ZrB45JVRI+HnE83jUQSglHP1b+hmas+PZmvMt7hYWeuHqOvh14lnDlX8c89sdg+fgbdivA5fbd2WaO8aJ0CBlmZ/e2kTrlwLznTHVwaapS5YrEkwqfxoGMQIYpM3CrpqUZh1eGrrg0Jji6ReLg4QqqxjJjVswUwdmTrtJZSXiGC8ARPjrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6v8MrpwL6azZ/Lpxe8te9lxdm5yqYOFX3G5Px1BTOE=;
 b=EYVKxf+cg5asj0OrJ1joOw/hQdQDogWmoTVBoTmVovBU2zoU4C3nujtl2phe58fX74oOPkfqKwIxEPyRhfUibv2/sIFn5BowDYz5z5L75KWqfJr4irejcQKOGFQHqr8i1DrR4ft63hmX0vP+uPdYG5mdES8KCdninB/yRkeYdVySAv05QU6QXBMtxT4v/sH+sHdVfdiCLmEL/1UYQ9pZg12iWLQCdhCQp/X5ESKUWG73sN7PNS3uHJvWdMYUiJutvezdrhRVpiGD3BJFzINUjIGct4KzcBGwD3eafF+UjZVmL5H9W/RNxtlgQ+CyMGp28cI4RW0Puv1EXls6IMVpHQ==
Received: from DU7P195CA0002.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::9) by
 DB4P195MB1893.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:381::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.47; Tue, 1 Apr 2025 12:28:21 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::da) by DU7P195CA0002.outlook.office365.com
 (2603:10a6:10:54d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Tue,
 1 Apr 2025 12:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 1 Apr 2025 12:28:21 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 1 Apr
 2025 14:28:20 +0200
Received: from llp-anderweit.phytec.de (172.25.32.242) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 1 Apr
 2025 14:28:20 +0200
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <quentin.schulz@cherry.de>,
 <upstream@lists.phytec.de>
Subject: [PATCH v2 1/2] doc: build: docker: Fix code highlighting syntax
Date: Tue, 1 Apr 2025 14:28:10 +0200
Message-ID: <20250401122811.14806-1-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.32.242]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D07:EE_|DB4P195MB1893:EE_
X-MS-Office365-Filtering-Correlation-Id: dcec0c1b-7315-437d-4541-08dd7118b0c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cjPcaEloG4AgSxlBgY3qFqUehhBE78b4i5ePMdw8wYBk4DSw/bhte9JbwPUx?=
 =?us-ascii?Q?oEuxtahVNX35TTts58kIEuZ28R50D8VZQajWpqJcdX2gZ99SLxgkISczmKCo?=
 =?us-ascii?Q?1IwXwlinKvMzUW9MocptcsFS8JcdXWum298AE3KraOmHlOSz1XmcYZlE2epT?=
 =?us-ascii?Q?tPcuhgRq5LxO0wW39hzB9r/+jBZ7NHbjbhSDeNGj3pPDzbkdJ0jO8XIqQtJC?=
 =?us-ascii?Q?XXDMPtjiyRiy6ZRJ4yc4QLqmi1hNe15nUaaG047pdOVJCqJwnb+nfEOYklgQ?=
 =?us-ascii?Q?bW+qCKBVAryf9288FGtkSym2zOFXMfV7DGuZQv4aL1szCz4mfedt7Qpkeqvv?=
 =?us-ascii?Q?mUrOnnBbdprWnCZYRraKM+ZDqtIKVsI0TexkAyxXOLjNGv1P7qNH2/tBDhb3?=
 =?us-ascii?Q?1y/n7kJ9HrQIoy0kugNodrb3nHYe0oZ0+bbPxlKTHekC+HZca2q4NkGuP1a8?=
 =?us-ascii?Q?3S8Tjlm4MzcpKJqoYQbr4OXU6+5qfmvrLCbOh330iX08GQc6+Smh/7rI80aZ?=
 =?us-ascii?Q?atQG4qt4PW49lh8w12u9fSV7/kZGvlugHFzblfDXnrDcmTKrt9wOe0RamVG3?=
 =?us-ascii?Q?t8184+PL0NQMWIuTconvKRtDyzzVDtN5HBNtztS+f2+D8kV2SVdpPhpS9122?=
 =?us-ascii?Q?F/2VIyFZj+/KViWPcdkYbBKAs6QyfMdO9hbrpuXwmrJpfE0/aT2pCMj1q0xt?=
 =?us-ascii?Q?gn/X0mllFyEi+/ALwV49gf/bKZkzS4P3VmetzoMYZat7iymLEJ0Vbwme1s7J?=
 =?us-ascii?Q?OORDNZFksUQjBijidEmJCoOz4IkTpTK4qS4xAQcNDRQXU/MYWra7F4XxaI7v?=
 =?us-ascii?Q?ligATx/dB7p2W5LurtK8vOwgH1/+u7Kk8XzKCy8KIabvgZOySgHbU3zyOcT/?=
 =?us-ascii?Q?RyODunf4grz6cRoV3l0ahL10g/Juc89NCnH9rIiF+avfwMffuHkSXA4YqIy4?=
 =?us-ascii?Q?7nuAgpwual+fH8QF+5VIIg/sLUh4+w1QFRy5EMgV84L2JR3zGlLPkDpcDcjX?=
 =?us-ascii?Q?unPO+eKMP99AKxvpFuojq3RgF3cTvhB2Wv4SEeywqNmTZiRW81BJPx9BTQK5?=
 =?us-ascii?Q?Q5/Op1uc7jAx3rQ/ZoWFwtbhUM8WY565eXoTfSiUXKdBDq+ptgISLIxb11ch?=
 =?us-ascii?Q?I6KgDUgIpYZULvWmM2fHDm+XnWxdNS3ItpzuNRPsCO5Sv+BG4AMLjFN/bYh+?=
 =?us-ascii?Q?K1ljf864F5bHl76fZOcE9YFw0xjWkflY295GJ0mAoLeKrA45daEaFMO83MUR?=
 =?us-ascii?Q?xdhi+vOmDq0xYfRHzAPQ3tMqACv6mY5FCWhjeWVtoaqFupqsSFHPujXHMi0E?=
 =?us-ascii?Q?KswVpeT+XGH3TP/+56aaWotvNtFmcFNbhnXoEx4Q6IhvXR3YOiUCiROCYKko?=
 =?us-ascii?Q?NejNQ4OVVckrzOiQE5I02bAAOfJ+nv15bURF3CKqUBN8ddetXEJ6Up0mb++1?=
 =?us-ascii?Q?RRYkR6OxUBnozoGsaz2q2uRVEslASE0lx37kO5BUpKp+xiJ0jJbNC0JWuRfC?=
 =?us-ascii?Q?/JSDAo5snktO7K0=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 12:28:21.4660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcec0c1b-7315-437d-4541-08dd7118b0c4
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4P195MB1893
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

Remove double :: before .. code-block:: bash to correctly highlight the
following commands.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
v2: split in two patches
---
 doc/build/docker.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/build/docker.rst b/doc/build/docker.rst
index 01ed35050908..fe087651d347 100644
--- a/doc/build/docker.rst
+++ b/doc/build/docker.rst
@@ -28,7 +28,7 @@ fast amd64 (i.e. 64-bit x86) and arm64 machines is::
 And this will result in a builder named multiarch-multinode that will build
 each platform natively on each node.
 
-To build the image yourself::
+To build the image yourself:
 
 .. code-block:: bash
 
-- 
2.43.0


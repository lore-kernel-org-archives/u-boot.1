Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B82CC48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 17:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEF4B87BBA;
	Thu, 15 Feb 2024 18:19:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="vtkdX+9h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="dGZWgf5C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D274877D3; Thu, 15 Feb 2024 18:19:45 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2071b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::71b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0ABA87E21
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 18:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=WhMt1m+YutJPIot+6pC3sWYb6W7lpjMNThp7exHBPr7D8wVAoGXc4joXrDPYmzpP5swcoDpDC+P3Lhm3UbLiGACCU4tXwxMMlxY0h4GW85Jru3+CA+t0C2cQn6zRhNPd0BJqohDrw8K0q4TrK7hOUizJ7Svyl4PJLwrfVL3gXkoILWnFg9ZSCY1pvk6eBYkZR4xNQfpeGiGxcTEaUcjYA2uLQQ2eWGlOYkzcnyU9Zx4DOPomXRftkF1jSyXShRFxF37zs3M0O/EKanWgOc9Hdi0p9fitODp45NyU+Kau6sLAiP+V2Q4VdpGSWW2Ih6tIVjDkilCgg1l8FkFGWa89bA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/kggYJv6Da7fI8kKxLyTyye7S3AGWVNlVyBsYCJkbQ=;
 b=Y8sEcbRwnQqoQSSb8VA6718BFBUmVHOqBOoG7sPtBxNDv9AlMuSuRuagTzW13X9oCqGqCe85pfeZsJKGico6EeSmwW750qvytLdvwzoSDoswSIupGDWyjHZiyEW/7oWFjv5vAvi5C/2S2d3oR8X1qATbcH4N6R1iHoKBxLZn10hQlO/b2MLLYzlNO1nO9mjSkn0Qi45yW1Ir7GBKPojm2PeHDhA3H5UlaUfHBi7v/VsZ7I/WjXoFCF2ETzLRPG1qJOEwKgDl4BwwcSi/GsX7FRhpQwP4pC47MQNDnQ69CnJC5EsrvksJF8idOAePWc3n2Brj3nh1N9K4dRPpewCRCQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.87) smtp.rcpttodomain=amd.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/kggYJv6Da7fI8kKxLyTyye7S3AGWVNlVyBsYCJkbQ=;
 b=vtkdX+9hXG6Q2Psq+VbncaoMfbciZCvy9Qx3GS7XNggQDD0cB0UylR0+JsBmJvbG6IxzaMMRq+W6+Mg1yLa40EA7syIiv1J6A2Wp2tYjrcUfFeyUFRA8iln7Duojvorv79W3zxJoL0W0jpYfuc5XIqYWIZtGS5YVUAcgZW+rvvjUscrk3RfmWcQplUoJEE+zl79b2hu4Ocf07VlFDx9mV0rRUTq+B/eQtcTjsMrBD0v84Q+tmDRDL9OtyxBL1UAFPFintChlA/tnZyxXcxBT3Y2gx7dK0rlJErqvTvgQt6oR8+xa6g2oVrAsvaPeFhNFw7SCYRC+2FyNYfeHDjXFWg==
Received: from DUZPR01CA0140.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::23) by PAVPR03MB9526.eurprd03.prod.outlook.com
 (2603:10a6:102:304::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 17:19:36 +0000
Received: from DB5PEPF00014B8A.eurprd02.prod.outlook.com
 (2603:10a6:10:4bd:cafe::de) by DUZPR01CA0140.outlook.office365.com
 (2603:10a6:10:4bd::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Thu, 15 Feb 2024 17:19:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.87)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.87; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.87) by
 DB5PEPF00014B8A.mail.protection.outlook.com (10.167.8.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 17:19:36 +0000
Received: from outmta (unknown [192.168.82.132])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 28B362009538A; Thu, 15 Feb 2024 17:19:36 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (unknown
 [104.47.13.51])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 2291E2008006E; 
 Thu, 15 Feb 2024 17:19:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7Df4s4hy8Z0vlxBzAqORUrruzRG0mdVx1PPYGj17lFaFsr2EwkIV30ukBq287oxFdStSg5qmVuQ9kVGj++X05cLYTYVJQmTHuyeyFS7xz8KxclCuB37+7NXJDps5AIBJpnYXkEt1+PK9z/10VP75VOSpFnBymfzr6IXgnqnfFlF+0BtvjCofT21sEMX6pbixu2xDIEhOShG9ruY+QGsjeJAE6RTss+ExY2JT2emiZBbhNoU9E8GO0PExRb7q86NE9FHm1D1t3lUGzrbpHlzPjQdrh+i72D0frvV6okWc0WE6B9XIbsk9344jia3PqoEz7s8TJc61/YnLlEWB7ffZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whkAXl7R6Lj/4fAp4Di2TtChqEn5Ba34S6EUySPsFAM=;
 b=CEu4Bi8VEaYCI6j2gg74HW4faET41GgX2le40meVA+HcubLi8PS9YILBV8h6eOpp25eVS6c15POb+6X5ymYvPE5rhbK00ZXj9bGaG+JMsl6DbsSPysJYh39FcmIj0EpwUgsQNIBbdgkDyPNmvxcuOju0KtPEvXeP39/hGquztMkaP9MvmebeMhrRy7ADrpKQYgONCJJNX/bIZgD8rroOZrBlw+7ZGPesdySO19HTK7+fLFcuSx41ELqy8ANRKq2BL0DClBWx9qXDzBX6a54fceoOpEZ2yIA/THXnP5Ku9HnSL0KYIn25I/gqjjTgK7kXUSWYDPAa5mFA+PtzPaXbhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whkAXl7R6Lj/4fAp4Di2TtChqEn5Ba34S6EUySPsFAM=;
 b=dGZWgf5CbfgUSeUgFJfls8WlxKkfnBw/5UtQKgIcsYy6yivoTy42apRLmug5Flgf0BlEfDgeiyill9igXJyaXcL7no2TE1gDOoG3gXOiD/0SjiOt3Sx63fqCmwtojopfBGJRDwj7R5LXBA8rsIuebyYoEBcmJ1I9TxVuPdAZqRWMoCmzUj3pGyhLn1jEaYUbrDBL417HZfYVqKKkh5Q/ODoUxpv2pcs53720pnFdSl7lnnBG/TVUWI6UZTMl9A3tanqvdKUYVOXfMjf95dwsCHjlBzA45FIgZF/Y39MST9GsORQWZxegHLFlt4njCJDXSlSYaHyXDsbcShL2iDEEJw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DB9PR03MB8236.eurprd03.prod.outlook.com (2603:10a6:10:307::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40; Thu, 15 Feb
 2024 17:19:30 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::18b0:3c00:30cb:711c]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::18b0:3c00:30cb:711c%6]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 17:19:30 +0000
From: Sean Anderson <sean.anderson@seco.com>
To: u-boot@lists.denx.de,
	Michal Simek <michal.simek@amd.com>
Cc: Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH] arm64: zynqmp: Support semhosting boot method
Date: Thu, 15 Feb 2024 12:19:18 -0500
Message-Id: <20240215171918.3729508-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0050.namprd08.prod.outlook.com
 (2603:10b6:a03:117::27) To AS8PR03MB8832.eurprd03.prod.outlook.com
 (2603:10a6:20b:56e::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DB9PR03MB8236:EE_|DB5PEPF00014B8A:EE_|PAVPR03MB9526:EE_
X-MS-Office365-Filtering-Correlation-Id: 318301bd-2995-4b03-f51f-08dc2e4a48eb
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: cFI+iL+1lJoQDY/Vg8rOp0r6/H0jRweWWbxdeJoqX1FXmLD9ZhwbtV5EBZXHt+0THzTyPUWNDlhwoixDsM0nB/23RtUP+xhKtPuEPpWKCxWCpZ0CEhSgVwjSvxh3ukst9h0T/qXzEFNQY2Wrx6zX4VOP4CVk7+QxbqOloLu5ofF2qCdj2koDNViAmsrgOOMsCqFrCJ44XxLQrTgh1imC1vMP4bKiKPKXbBuoE4THMb/4SHu5xjF+v4mF3JfXwk5tGvamtNrHgv9Rf9qMdo40xwXoBMc21qRJax+wlyQtJ/K3EwaH0sKnqvf+Mb8fCksldQSoQpYPHe89L+jZwj/mpG9aJclfwNWp6vDYA4zboSGzSgqMO2y5hHk0c1rJ0IPw5po/5jFXEFSD4x47oBrM6xTmEmF/Ijn1lTEo1p4a+kcMgUdQImLj1nQh4xizIpCo7f4JSQk+g5PzZK1N8IHtjvaBusLJiAhDMxQnFYJS0+PAKCdduUR1lfztTRduc+85mziLqwUGGk1ZjXKWI0dFNk7e0KHNGO7rBqFOjzMRP8IoKwlitfPTxjS7CsLv3JK/a0TfB5BGRMbRYdHv7pzVQLnVOHYrQGeCAu/210mTxMfg7YeL2ceZDqtdCISYGMEC
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(346002)(376002)(39850400004)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(5660300002)(8676002)(2906002)(8936002)(44832011)(4326008)(52116002)(83380400001)(38100700002)(26005)(36756003)(86362001)(2616005)(1076003)(107886003)(38350700005)(6506007)(66946007)(316002)(6916009)(66556008)(66476007)(6512007)(6486002)(478600001)(6666004)(41300700001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8236
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c3cf60af-028e-4af3-14bf-08dc2e4a450b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3AqGTZhkDfI9HVNrUi12kEgcKZSQQW8qhTAqusHVRsIhwGFT/WkFauGfD0jfpWQCvZfeI4a3gemtoGm28HaXb+DTJ3m8xBAsmSOc6LqVKQ4VT52ykO+a4DQLGWYzW3N0FLX066uyJQgNON2LwC08yczx30E7PdxY+woexp76lv831kRyBbKVri6mnlDs6PyoZdLL9VtrkMMQHn27ZZH7KpI9R+9EBRR4VydaKwoQlaMv4kqbMAJxvg8NxeQ/1tVnA5xJwFsCeLXYIeKu+mmvcs05CiLY7AObUKWr8RabmkVaZTlaH0q5O3hKXswmdmrrK5/JCZxUUX9yNVstqtzpLMKWK8BN6EJxFTkz7pH/mQsEao60Vx+OPvSCHPMcLjTb5+P7881ANewHb3xw6MOmwEmBm7ejh5t/4t2eVXXEDhX59+7Ffg/x/fCjpkpWzJEfcDFsmEfqTl86FAdwvMMNq1+9+tEudihb6DWEiVwErQRypN2eKwWC3vl15TXiM5YqYvqtVCZ/BwuejZ3ajo81l0N53lLT7wuvelpMRZhzZ+/lLfsCaQiHl/ULBUYQGMfslbS/yhA+TfZL4M9BVtEAbRzL6l116hYs71dEpSArU4MgxlVNmlAGjzoRfcjbPxN/EqNlv3lyiALDy0DSMd72oM9csT076+90U6lRBN1LpSA=
X-Forefront-Antispam-Report: CIP:20.160.56.87; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39850400004)(396003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(36860700004)(82310400011)(40470700004)(46966006)(36756003)(86362001)(41300700001)(6512007)(6486002)(6506007)(478600001)(1076003)(107886003)(26005)(336012)(2616005)(6666004)(70586007)(6916009)(8676002)(5660300002)(7636003)(7596003)(4326008)(316002)(356005)(8936002)(82740400003)(83380400001)(70206006)(44832011)(2906002);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 17:19:36.4867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 318301bd-2995-4b03-f51f-08dc2e4a48eb
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.87];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9526
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

Currently, when we boot from JTAG we try to boot U-Boot from RAM.
However, this is a bit tricky to time, since the debugger has to wait
for SPL to initialize RAM before it can load U-Boot. This can result in
long waits, since occasionally initializing RAM (and other things in
psu_init) takes a long time to complete and the debugger must wait for
this worst case.

Support semihosting if it is enabled, as it lets U-Boot tell the
debugger when we are ready for the image. This means we don't have to
wait any more than necessary. We don't change the default config to
ensure we don't break compatibility with existing debuggers that don't
expect us to hit semihosting breakpoints.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 arch/arm/mach-zynqmp/spl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
index a0f35f36faa..5af735aa5ce 100644
--- a/arch/arm/mach-zynqmp/spl.c
+++ b/arch/arm/mach-zynqmp/spl.c
@@ -9,6 +9,7 @@
 #include <image.h>
 #include <init.h>
 #include <log.h>
+#include <semihosting.h>
 #include <spl.h>
 #include <linux/delay.h>

@@ -66,6 +67,11 @@ void spl_board_init(void)
 }
 #endif

+static u32 jtag_boot_device(void)
+{
+       return semihosting_enabled() ? BOOT_DEVICE_SMH : BOOT_DEVICE_RAM;
+}
+
 void board_boot_order(u32 *spl_boot_list)
 {
        spl_boot_list[0] =3D spl_boot_device();
@@ -75,7 +81,7 @@ void board_boot_order(u32 *spl_boot_list)
        if (spl_boot_list[0] =3D=3D BOOT_DEVICE_MMC2)
                spl_boot_list[1] =3D BOOT_DEVICE_MMC1;

-       spl_boot_list[2] =3D BOOT_DEVICE_RAM;
+       spl_boot_list[2] =3D jtag_boot_device();
 }

 u32 spl_boot_device(void)
@@ -97,7 +103,7 @@ u32 spl_boot_device(void)

        switch (bootmode) {
        case JTAG_MODE:
-               return BOOT_DEVICE_RAM;
+               return jtag_boot_device();
 #ifdef CONFIG_SPL_MMC
        case SD_MODE1:
        case SD1_LSHFT_MODE: /* not working on silicon v1 */
--
2.35.1.1320.gc452695387.dirty


[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>

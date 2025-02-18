Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F14C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9042C80F91;
	Tue, 18 Feb 2025 13:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vsjyC6be";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D67C580F91; Tue, 18 Feb 2025 13:11:24 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D96B80FB5
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:11:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8vun48QrQNdMuIE76q61ONkF6UkTQQb/obBX9P6hLF6RPOfQ/NTPuT/9c1GDQ1zT2np2KvQlY08IyVLRlZQBel5R4PIIyar/WEjBntdo09MR0zzXndLvbADXLSKWzRr/3hGazz4PryYMzwxqvD7A8kbwAU0MKKdRBEGJZoIj0C4L2X7SXH87nZXI2Lmcpy0tVwDZBg86ny0Jw97mUEIDr8zrcf697CyK3NSJobgoq19OtvSgJ0PoeXWd7uP1L+DwIesVB6QvfYgmHzYEn3i/MwQ/d+GnPW6Iqgu3eoJ3D0AWs2zCKeF3FmO6VWh2gsrX4Ohms9ivfVA6o1rwO4GXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cto5NrIyElklbUADydTj0HqajVnmwTGf84kbSV+gK/Y=;
 b=oPnK8tlA4/+Jylh0PnIy7fBx3Yh2i4eYVb0BPV2xSqLzVBwueIXQBgBjHzX3eexQwLRj/1ivdlJ7+U7FcdER+eBtWEOkkMsGnfNarFSZiBg8ACmiSarAksUy6skzSn8r9QXZrAuXPN0k3Wg4mcKyGdc4vOUCYDrzCdFX/DyAF6qiyCfYpkV2bsJectM9ND0KoqL2oVJZM5Mcw7ypJCAb10VZF1+5v3sHQXguUKnpZk8Tc8+6M9PLhtR/bhd/YFXqwxuWVZe7AK9Hdvjvo8YYIMCSPswUPQz+r4uI863ZAADIOPqmSBIw33+f+6TLna2/ezO7qAwKJXKoRnf5UbErIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cto5NrIyElklbUADydTj0HqajVnmwTGf84kbSV+gK/Y=;
 b=vsjyC6beZvaf6C6etfbSrGPi6f6tNhF1+z0+QHxdgRcJXXwr5oeE6E32lpnUUqw8mg6FtBa4TWpRv/PEK7xIX7U8CawOmZTtmfUH3ns7U45psahRgVoHF1qSXrDvW0Q5rN75y8wlqeoclQI8TjUulhk7/v0fBEP5n4XMsmAyfyw7VB/QUaj2sLraHGGYOj46kuLY0RxB/x5JfUdaDy46eSxYZzrgtDqxyE0p2zMydEV9ZjJNPrFK985/JkUxZPfUrIfCPc72kITetk41J04L8+9h8WczwPFxbVXCfRneSdbhwcLn3yjyVjkvTbMM+XKQm6HEBTBXpfDcffMLrR1TgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 12:11:20 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:11:20 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, marex@denx.de
Cc: u-boot@lists.denx.de,
	tharvey@gateworks.com
Subject: [PATCH v5 17/20] imx: add V2X container support on i.MX95
Date: Tue, 18 Feb 2025 20:05:54 +0800
Message-ID: <20250218120559.451678-18-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218120559.451678-1-alice.guo@oss.nxp.com>
References: <20250218120559.451678-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DBBPR04MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d201aba-7fec-4a03-b368-08dd50155ab9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tJ5HuNUYicaLZZ12c0PcWmceNgOFqA1AKbpb+Vl40Qz/GonYjFv1QzCaw1ZW?=
 =?us-ascii?Q?mC6WNvWA0PI0m2WVml0nhREJoLaWOsn/R/HmtEhhAI+4RAKXLaAv6hAE3fmt?=
 =?us-ascii?Q?rL/NMPlM/w6ykRFUH3QwrHjvC6ltBRZ+rRMI1FS310ifuGhISieHChGshQ5O?=
 =?us-ascii?Q?fEt5LG1a/X2bTOchixuwr5hewjZ5VubOQR0QoCaEGH/UkYRNs3PD2Iu+jhaH?=
 =?us-ascii?Q?YcvTaL9V9hVknwYC6exW+afqqpGQiHnT0RKFP0J4x93/FHdjvisXmxdm524v?=
 =?us-ascii?Q?TVRWR8DtszYoHaGVdhK3XWdYNkvOX5e9vBV95sbiKCFQCk2/4ZSkQI7Sjlb2?=
 =?us-ascii?Q?2Imjb+mfzX+Alz2ueHaADWgUg91J7VIzIXimcmNU7w7Z64L9J8lzGlOsC4lY?=
 =?us-ascii?Q?EaRHYE5IPCvbydXEHqGrOyeTOq5s8jBrgWPUpBdKBE+N4OU4n8RZA+QpOksU?=
 =?us-ascii?Q?FBqZbDxkI5/gv2HVkKuve/6DkTK4HuX6YsTHaIzbb6PCDraDv31z1bxtxhML?=
 =?us-ascii?Q?3pXmaL9d5+fHV4mx6PlL7n+G/IHUdmzzaBZ5ItlLqoeAwV4IGCowPLvOTqSU?=
 =?us-ascii?Q?Wyku4CZHtG7IEWX0sZjfzlxgQWB+OPFskRBHxG4vrjYDA07QoWfr5AFlTNM4?=
 =?us-ascii?Q?8zTlAB3jboM8QVmrxfghq2go45ZrGpCbqRsABoV9KMwKKDFZ/Odavae6rGvT?=
 =?us-ascii?Q?9+1DBcFN0JFdoL6BCQWs8PBiNKfSkxd2tgQ6X+voQbOoso11WJwImzITbBz/?=
 =?us-ascii?Q?jkqlOQPR2EoCDhNDCQxHKmC30DG7iP4InTdultHMMav/DQJCS13PaAWh6hRx?=
 =?us-ascii?Q?QfHv7Sbve1z7Np2qN800RWJN5nIJEPuXYu1NySHyrpC3jawqVNPu07ZAOeLL?=
 =?us-ascii?Q?phPwFljGj5FQtJ2cIGdBgao6X7gPIpf69adwlyEFdRJKPlX1lq8Zbc1fym8i?=
 =?us-ascii?Q?2eGKUqq1FlFHk8EI2Wq1ohjVnyALF7ByKgqzoa4VSxQdrZAAAFkPjveuOM82?=
 =?us-ascii?Q?r0JnUjR8hh4kjcewGTEGY7yO9e2aivH6Rm/Jp8qR6A8g6Uhg6r3VB0aYwN6T?=
 =?us-ascii?Q?ErA9rTgmZKF6LcBWoJf4s4KJIIKF7mvQTQ9ryORu8dLBFOfZzJt70Jldgsov?=
 =?us-ascii?Q?BdRwqw3a3j/ccr7LTWCKmJ2xECUI2i7SVj2vKSAI4ozYycHHvlT0a2G2+Pp9?=
 =?us-ascii?Q?wKlVAMlFDvnDoFAKbUrQDWQ++NBcLSUQzSUNENofeSeIaq/6yR9iXIf2f0Dq?=
 =?us-ascii?Q?NFJXGfC51hs2HT7ftMTy/Bdm9Wnt2j9cKR25vZ2mMRezmZxk+O3BT8fTi8XA?=
 =?us-ascii?Q?48hTefQhof8LVB/8I0S/dr6a572HSjYPjBmkdIgyhIOB6b1jSGz9tHDkIhAP?=
 =?us-ascii?Q?j3xBEoaCX4V71IUheiyznZYsXzm+dgZmH5jkh0KFEEjvMDwHzaOMQtLTq/xF?=
 =?us-ascii?Q?obwkXcnXipGdFYzRK+0n/4FC+QiPcmrc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w6cPmbDsIE0liICQXepbGbIVcdrzuQdvMhqmHubM+S1mJNI7Cm+Z9MpEAFQw?=
 =?us-ascii?Q?TVtNhXiW21XYB+GnpmQh4f7kAL2tVV4uFY24FqypFRYXyRoVFujUSYQkENld?=
 =?us-ascii?Q?gXaDNn/zqqxC/bPD+db2Sk0EixnWxwqETUbmv4k88Zzl9wC695u9oWvnKiCP?=
 =?us-ascii?Q?VnnWXHOVe4ydx4GwIi03j61OcZ0R7DPXahrXm3FA1b/Nt4j7lSiiZaCv0LTB?=
 =?us-ascii?Q?9HM1/qpkh0UrYGSpT5x83t9w1XBKF3Qr0/7ef7rd1yNVhMGW8WkXigtBsqm0?=
 =?us-ascii?Q?Z0GIc2e191sIkFYDqM8ohCcwlwGm6QGRpyN6c7VZ4A83+F3xvfHY1yFaMo/A?=
 =?us-ascii?Q?rYnHZ9za95Mde+MDXTnI+Qbd3uhK0bi7a7jZG91nmJABoL6YGZk8/Ok7oUQY?=
 =?us-ascii?Q?nRfg8ilMAkLprk4ARDjOVKWJ9McDlH/9VnK4EIlh/yKRZv6OUzK8fTEKd1Wn?=
 =?us-ascii?Q?UEt06N78j8ALEAY73/mixI7wK55rxcbDFDFLkFTG555iq0fHmsl6+OIAhDNm?=
 =?us-ascii?Q?nrSny7gRVR/Ofvn+OTX87POiufdKy0flk57sPyh0un7R5GVcOL1jSYCerCkm?=
 =?us-ascii?Q?EEm0sGad+JmQSTUBa8n6NSC9jihhss+iyfHCCLm58y7RHzljyBqOhGSvvbMy?=
 =?us-ascii?Q?TJW0I7vYxp9dG5l4VFuRvNmdYGM3vGkBoCxpd4xRspJ+R0jOLpk1YKNcxHmD?=
 =?us-ascii?Q?oqjxUNgqyya6uLPZBRmocTLOPiVZKs8ym+MBzIKOyJmQBeTW/svlJhv0dBi3?=
 =?us-ascii?Q?g1rW2FdJwj/XJlHCElGlIwQijp5CxraDNu2TICB2pZm1t09/NYxAvM9dYCex?=
 =?us-ascii?Q?XpwtGFbvdERzXNMaDTRzxO13a0lGXprCNi7SnN88YQsdlkYLMtRRlLvMN5XN?=
 =?us-ascii?Q?6SKXwOBcMU/7qvHQDxv/jcpugZGKBaJhPPbsIpw365Wm78OHxKEUi33FSpjx?=
 =?us-ascii?Q?5XuF6e+vo45VDhhVkVl7ultf5mvGYZAxvL3yyvYKtFv0H8f0BVRwt+AZ6MSy?=
 =?us-ascii?Q?mOXO9ubXM99HX0j4K1GjU1SAfSIDJbRFf8eY47utAscx1YHV79OMPoZgrSAo?=
 =?us-ascii?Q?GevAC9qkLO1cJv7oh3LcNaKjKOLTaZ93hp186SxND0Bk67OBp0pr7Ua0CMsg?=
 =?us-ascii?Q?Wp4o2Al/d6qm+hmcRwsyjNS/w+SgFAsCz+2PofhvS5P+so9+wZszzHfl2743?=
 =?us-ascii?Q?V4FbxvCpy7Y/M6C4+rBplrN6WCGDLWDRwETxdAMZUqi/pssKYeHnWTiDMApx?=
 =?us-ascii?Q?gtgs/l/UFDN3dXkzHelo9XdcgudQtz4muJGFDRkSRDxKGYKpaxS++WZoYcA1?=
 =?us-ascii?Q?hxR6atZru/tjU1sQJTnHev0xeNG9Swqe4ArlQcqStPUDfrgxJ4VuDA+kwU0n?=
 =?us-ascii?Q?nlUGF6WNs2KZkFHv/PH562mt8EXOn7/NtpijQQe5T1Qrz7KYznP9xfhyVkuR?=
 =?us-ascii?Q?aLW/vpJ4uPGydFDW3g7cIwknxGAVHo9elF0T2joWA1oLENShpyfx9cl/4V+H?=
 =?us-ascii?Q?8Zzo7kPQe/EiKJz8PqqaJWKBrFEO8dNCMsti9gomaf64c8DoeR6ngnz8bwCu?=
 =?us-ascii?Q?c+K+lozqQgU1tkVJ1WJK/sDj5Z/vfBfBylMNbBVU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d201aba-7fec-4a03-b368-08dd50155ab9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:11:20.5092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qewITHwv1NpkmN6u6g1KV+AXR8vpIQFoePUX/Cj1N2slkaulMQV8axFdW76O+6Q3f5zSBo2lcyU9cqwyOnGdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7690
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

From: Teo Hall <teo.hall@nxp.com>

This patch adds V2X container support on i.MX95.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Teo Hall <teo.hall@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/image-container.c | 63 ++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 2afe9d38a06..54ae7721888 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -231,45 +231,62 @@ static unsigned long get_boot_device_offset(void *dev, int dev_type)
 	return offset;
 }
 
-static int get_imageset_end(void *dev, int dev_type)
+static ulong get_imageset_end(void *dev, int dev_type)
 {
-	unsigned long offset1 = 0, offset2 = 0;
-	int value_container[2];
+	unsigned long offset[3] = {};
+	int value_container[3] = {};
 	u16 hdr_length;
 
-	offset1 = get_boot_device_offset(dev, dev_type);
-	offset2 = CONTAINER_HDR_ALIGNMENT + offset1;
+	offset[0] = get_boot_device_offset(dev, dev_type);
 
-	value_container[0] = get_dev_container_size(dev, dev_type, offset1, &hdr_length);
+	value_container[0] = get_dev_container_size(dev, dev_type, offset[0], &hdr_length);
 	if (value_container[0] < 0) {
 		printf("Parse seco container failed %d\n", value_container[0]);
-		return value_container[0];
+		return 0;
 	}
 
 	debug("seco container size 0x%x\n", value_container[0]);
 
-	value_container[1] = get_dev_container_size(dev, dev_type, offset2, &hdr_length);
-	if (value_container[1] < 0) {
-		debug("Parse scu container failed %d, only seco container\n",
-		      value_container[1]);
-		/* return seco container total size */
-		return value_container[0] + offset1;
+	if (is_imx95()) {
+		offset[1] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
+
+		value_container[1] = get_dev_container_size(dev, dev_type, offset[1], &hdr_length);
+		if (value_container[1] < 0) {
+			printf("Parse v2x container failed %d\n", value_container[1]);
+			return value_container[0] + offset[0]; /* return seco container total size */
+		}
+
+		debug("v2x container size 0x%x\n", value_container[1]);
+
+		offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[1];
+	} else {
+		/* Skip offset[1] */
+		offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
 	}
 
-	debug("scu container size 0x%x\n", value_container[1]);
+	value_container[2] = get_dev_container_size(dev, dev_type, offset[2], &hdr_length);
+	if (value_container[2] < 0) {
+		debug("Parse scu container image failed %d, only seco container\n", value_container[2]);
+		if (is_imx95())
+			return value_container[1] + offset[1]; /* return seco + v2x container total size */
+		else
+			return value_container[0] + offset[0]; /* return seco container total size */
+	}
 
-	return value_container[1] + offset2;
+	debug("scu container size 0x%x\n", value_container[2]);
+
+	return value_container[2] + offset[2];
 }
 
 #ifdef CONFIG_SPL_SPI_LOAD
 unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end(flash, QSPI_DEV);
 	end = ROUND(end, SZ_1K);
 
-	printf("Load image from QSPI 0x%x\n", end);
+	printf("Load image from QSPI 0x%lx\n", end);
 
 	return end;
 }
@@ -279,12 +296,12 @@ unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 						unsigned long raw_sect)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end(mmc, MMC_DEV);
 	end = ROUND(end, SZ_1K);
 
-	printf("Load image from MMC/SD 0x%x\n", end);
+	printf("Load image from MMC/SD 0x%lx\n", end);
 
 	return end / mmc->read_bl_len;
 }
@@ -312,12 +329,12 @@ int spl_mmc_emmc_boot_partition(struct mmc *mmc)
 #ifdef CONFIG_SPL_NAND_SUPPORT
 uint32_t spl_nand_get_uboot_raw_page(void)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end((void *)NULL, NAND_DEV);
 	end = ROUND(end, SZ_16K);
 
-	printf("Load image from NAND 0x%x\n", end);
+	printf("Load image from NAND 0x%lx\n", end);
 
 	return end;
 }
@@ -326,7 +343,7 @@ uint32_t spl_nand_get_uboot_raw_page(void)
 #ifdef CONFIG_SPL_NOR_SUPPORT
 unsigned long spl_nor_get_uboot_base(void)
 {
-	int end;
+	ulong end;
 
 	/* Calculate the image set end,
 	 * if it is less than CFG_SYS_UBOOT_BASE(0x8281000),
@@ -339,7 +356,7 @@ unsigned long spl_nor_get_uboot_base(void)
 	else
 		end = ROUND(end, SZ_1K);
 
-	printf("Load image from NOR 0x%x\n", end);
+	printf("Load image from NOR 0x%lx\n", end);
 
 	return end;
 }
-- 
2.43.0


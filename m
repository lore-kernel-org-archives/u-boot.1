Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEABFF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 11:16:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F2C184119;
	Tue, 28 Apr 2026 13:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="CDaizgRd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC853842A2; Tue, 28 Apr 2026 13:16:27 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96D5280433
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 13:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqF0DJuq2cC7aKu4v/qtqrydyQAZk4HhefPoLg8xOzrBAAVy50D8HL6B4yGAravQfX0GUb0yecf/5y1oC16xDFGCg0aklxX5x5DtGvCAPbdsqonWGD+79J1NQN9rDMte9UV3d7WyhlD4AdrOq4Tr0gX4s9RYfaqHooClayzDtQ9sh1a8DB9LFONGgFxGt3zpKMEoiYNWguKXXbqYNTyal5yYztwnUfGUuHExUSCOpXAl7CVe4UlJAo6l4IiRcQXfhDcWp2jJ29XaT7Y2kMZTeyDeIfelsLpTL9mBn8Znxm6sh4/Edj3ihUNrEWQoM0GtGKq14RBjhQiZLFqaGoCLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=732Guq/2onii7YKyZrfgRznziUKarGz5BQgbocXkpLk=;
 b=tX8gGLp9nJ6KhSYCJO01m9nH98iwXCOUwbowcjUmOfMjk2xlmYf8gF8ftTed4HRg6IbksB7ezKlZXD4ppAzpZ7sGU3ztMwr//Ivv7IghEzGRHQXma3LrFzAQFMjzMQVIyWxwAKur8s67uKvMFs08h9hSjUNLUthahfmDjLLSaoxeDXfS6/7GixVGA8EbuDvaVnyR7uPxXK+x1pIU0TPIk4YbZ1eZ3unWvvuDCn0gbsZgCGnFtUflZGmqYcprYUK7YtUSOydEPUkRhfzVO3HTkgiStJGTME/WGv2Y4E9uLKfJd24N3BGXnaqGadu0pq48+IiS1ElVafB5GUKzTjf2kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=732Guq/2onii7YKyZrfgRznziUKarGz5BQgbocXkpLk=;
 b=CDaizgRdyvBgdp7rklNT1n7m8/Vi5vFQfSx5ui/kYzDeNjQju3uGZTjUOa9AQLsZHHW6dP/nK3u7b/kD/3bmj2qx45gYGT5GvNBIhi0lIMOvT9htUVJe+7YQ4znH8kx1O2SOrB0vDXnK6OpUY9VFK9EI75Ja3dQkvPMqjrDiGHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by VI0PR10MB9835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:326::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 11:16:22 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 11:16:22 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] net: phy: adin: add support for the ADIN1200 phy
Date: Tue, 28 Apr 2026 13:15:32 +0200
Message-ID: <20260428111532.1311239-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0051.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::35) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|VI0PR10MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a502dd1-92ae-4c9f-918a-08dea5179401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: AKd8A17EFDC4gxleaihkLEZlIN6e4iKp38BJoBaIhDDhKpsPQzZ3N7fbw8L3tuRWwzyTV06neK40caxv6VP/xXmwGbjRiQBRCrj+j11gXkXu/oOcS7UQq8GoounnM6zad5DuFrfMExi+LloqWzYva3SeVu6fuzh4Fv2RabBURJtVNnJxtUo4M69aHUkBMOOZwphRDFTOJNcX/CpJn+sCVVtiWjaKGwQYzZaNqex7NeYSNUL5o1HZIF/5ffTbuIDLOOrn0rRIyA9FSQ77kvzwgQvBpjyAXHrnPakqmt1FjqdLkalsW5H/Bg9Q+PQjR2wl8Lqbn1Ebj0xYFYfi678sSdDLI+zMNYpkBePjUULyweJaPeVVYkdAaIKs4J/sG6PpTYeJaE1CE8xc+t/qOaG3wzSJCBsf/g7vVZz36H0xxkSB68bG0YwrRyUkDeeveaFHE906XrIYLAobu9b10qYy92/cCyi9omA7JBn3w/GP+c1CYUdGEfpRAAfz9m3MREpPXE/bkoCjXMdC+7rLFC9axueacdZEBttfreSpxbKaN9dWThxaCy4mLpd/Kp2G6FP6r+vXwulmZJx8oVQUI8k/DnzSud4agBJdeoa/uknv2ktFFU1fATtY7s7YPg6isARCTHLIMQIMP3FteEVYB/JkI2Tl8w3c/khbdhQOXypOTqB+wgJWZ91QA4lq1ksIEAQh6mBQdsGCqPLxn+naD3R39MVihPB6sQZmHGpSxCWXw46i5hhi48p64OUkQHT+PzI22DjvWmfHFGra/BKPtQIyBbRw97H4bQVNaaIO03e6DsI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(56012099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bL2B2/3H7DIvCi69rXjfA7Ued5zjbhRcbsGW5891sl0tqVd7rvOyK+Fddghx?=
 =?us-ascii?Q?Ke22jQ9fMhtui8eo/KChccXvnGY0jR+/mCyKmuHFr78R0ppptkeW/0xMJ+Mb?=
 =?us-ascii?Q?S44Wyfh5ddNkNRAnlnOdOVRqE7PDoKGN720CauYAJGh7tDKeQRkWp5CS1peh?=
 =?us-ascii?Q?l7r+HxpEC6K7SIdyhCfWziQZtdMxEPB0qO6X6XI3+adMcoMjFz/EvtW/2hnJ?=
 =?us-ascii?Q?TSit1p0bMgkRlRMkn+WJ/7OBtvLCgAzehPxymJ9IgJqAWNL2Rb7y0fEU6+1W?=
 =?us-ascii?Q?L4dphz0z3W8Zf+TlyFG+s2JHaNJDopR4xS4MjgAllTgfcY070TkkESR9E8Uk?=
 =?us-ascii?Q?UhZ7PfoPa1H+2VF9/oQ48f0k97TNY0FcMsyTYD2B5P328yg9vgAyd1yE1159?=
 =?us-ascii?Q?rJQB0Olsfk68CtIVye37A9vfHIc6ckHp8FSmXw+DP0UNoJ77U0ouVcr9jZhC?=
 =?us-ascii?Q?ezigJeEPKJBYfLHS0fiT90ARUAyCmIoqwgZck2F97sYnpq7nfOr16nJMJQbD?=
 =?us-ascii?Q?fKyVkfjdL/k6m5t7Wxa2QZ13EHvH5qrHi3PlMgHEHld8yyrVFSMBnsM8HyRs?=
 =?us-ascii?Q?1JlZxgOn8wwuGwDuSU4PKxQYxd4uAWt+ELBuGM8WCdhEY5xexs0vVaBp4LiS?=
 =?us-ascii?Q?GXFJrX42ZBUwQLaThDP7McbQ5IInLQZWV1w9gn0OoAzByTmNawwEiKj1YSCd?=
 =?us-ascii?Q?5MLz6Bidmk2mK6vnw8sAdrh/lLXu+MvLYtKa2PFA89yO//4zbnjJro7XmVH4?=
 =?us-ascii?Q?kInnXTTGHvVgtsGmiTnytjO+bYmIV4FAEJ9cEdZHYPLD2n1aHIdPbODQiJpI?=
 =?us-ascii?Q?NR8MW3/jKbPNpkVn4MxTUBobL7/zY8LVr4/se+pHsJ1JhOXHdubqyRppYM/S?=
 =?us-ascii?Q?s0VcpyFLQZARKs72oN637oQU977TqgHnZuQgHMlMBAGUpACglvbrom0DQxSN?=
 =?us-ascii?Q?sE3h2UVXx5b/4ktIvXRNzWKPoPjOKy3uvaBwkx3Ad5sFgvDbUTx2l6zBLVTD?=
 =?us-ascii?Q?I0RrtL29gGSXL8dZyhn0hvbzSNeJfavokxt7o5DsqbWFKkIZJNzVA01PR5bg?=
 =?us-ascii?Q?S1T0t8DpBH7OGWFgGPtHSpAz7nsICpXI0XvRd3r7xKLd1NA8DfkH67cN5y0C?=
 =?us-ascii?Q?CxK1LtQ1FjkPOqJXvr+Wst6r0a7tmI31S7KX5nqLcxqsI4fjGgkuJTeTXrpP?=
 =?us-ascii?Q?xFtrtvoT9VulCawbMnTiZqlscWc4/L1LiB1CoKzT1MHsYdtTuS5AbQqLzbrB?=
 =?us-ascii?Q?I+PeM5vj33DcTCk3chO+7X3aKY9VHoyelCd3T2DtRyNC//dLJqNGYnP+MnoL?=
 =?us-ascii?Q?P0yv3fPzmoFu30Z7Kn+RQgwo34cSeKs2kTqSiw0HPSKJdh1bW1DGc52TfZ6T?=
 =?us-ascii?Q?G/nWzl8IZ76rBYbfVHpBZ+SDxKSqHCwG3cG6YKumhpkFpKIqT654lhofj9SL?=
 =?us-ascii?Q?Aw0iPPy2YHzUm8FckJ/XqzzUtCEHBvDEOv2DOVLVRO22WdlVBVnQkryi+5+5?=
 =?us-ascii?Q?zduRrglTEMM01v4tP8Q3llBYZRhCdtJmrzrLpFD6vVWH4TPwHlYTyJCCXRkk?=
 =?us-ascii?Q?7oxzIZ5Ys2yaOGR7NuINA8HxLP57y69T68K3QK4mIQO0ucegoxTFpM4WgohN?=
 =?us-ascii?Q?PBTjnHhu+RupCQZilAPezbIAlTMXE4Txa5dPJw6Ck1MdFxoycRktGdLPSqhd?=
 =?us-ascii?Q?ec8xjlCdy9AvOGzjz41gBGa/UZcYw/kfaGBsUT70+JLPH51GRJjmn82x2dA3?=
 =?us-ascii?Q?FMo/J4vR6J5w7ZqdbCv8Te8LN7qtYkY=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a502dd1-92ae-4c9f-918a-08dea5179401
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 11:16:22.1459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYD7vM9tgbw0ik/aIpcU7UOQ1shc7WMcnAXPr3dc0UgIEg5ret3BITm4KBWxV95rdXJAjvUp38xuTMOwt2sPEOwBOEEEL0ibwUtIk+/HsZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9835
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

The ADIN1200 chip is register compatible with the ADIN1300, but only
supports 10/100 Mbit.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/net/phy/adin.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/phy/adin.c b/drivers/net/phy/adin.c
index ce448810ff6..4d42e56dada 100644
--- a/drivers/net/phy/adin.c
+++ b/drivers/net/phy/adin.c
@@ -10,6 +10,7 @@
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
 
+#define PHY_ID_ADIN1200				0x0283bc20
 #define PHY_ID_ADIN1300				0x0283bc30
 #define ADIN1300_EXT_REG_PTR			0x10
 #define ADIN1300_EXT_REG_DATA			0x11
@@ -263,6 +264,18 @@ static int adin1300_config(struct phy_device *phydev)
 	return genphy_config(phydev);
 }
 
+U_BOOT_PHY_DRIVER(ADIN1200) = {
+	.name = "ADIN1200",
+	.uid = PHY_ID_ADIN1200,
+	.mask = 0xffffffff,
+	.features = PHY_BASIC_FEATURES,
+	.config = adin1300_config,
+	.startup = genphy_startup,
+	.shutdown = genphy_shutdown,
+	.readext = adin_extread,
+	.writeext = adin_extwrite,
+};
+
 U_BOOT_PHY_DRIVER(ADIN1300) = {
 	.name = "ADIN1300",
 	.uid = PHY_ID_ADIN1300,
-- 
2.53.0


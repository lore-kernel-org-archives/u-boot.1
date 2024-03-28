Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DD7C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 10:50:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C208D880DE;
	Thu, 28 Mar 2024 11:50:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="q3Rbjdl4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D62E83348; Thu, 28 Mar 2024 11:50:18 +0100 (CET)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C91E88811D
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 11:50:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/nAAMdfPYvjzPrH7l8U+1wCes6OBd7nAYbO+XitpU/eE0IXoZc2gRvHQdiFm2asaQCJ2UOUY38CTL8TSaFbKeJRy0Z50KR5rwSz5bavjLGkZW0Ob2m8W4DWODZ2hplAhFdnROhQnuDCisyFZNoN7zV12TvOYr+TMeD2LeYfINlBN24+Yv57phvjxv3UtR9Y4EAexd6w65gWv8aOFGqOLAfmz34kTaiaYHWTg45K3YPyQgZbZIUBGKjsk8zGaG7vBmBnl1HIcNNwcO73vtuDGWPCk+9MtK+UD+6QVQi04COAscPPLyxzw92QfgIZMsaHEmhV74Rol7sRvFui/4yCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUrw0i2KK34XdESFvuhZH164eP2Vzh6viNo+T+ah6UY=;
 b=VVqSk3eV5B/wkpl0U3F2KAFKrzqMpr82D22D3+zvLqDCvHgwVm9qzX0HIaOR9EKzOwpLfn/gkJnlkJNUnnSVryGMCwe+mH/8k9E2eIqycLPzhOnxmKoVfDCmOk14gns5Vxt0ksUSQzOz0IT3dFl/TbQ1q/fsqMQTYbcUbuAa5pgCPfrGNRgBBRM2hS3NhYPIySdfLHnKL7H3chZyhvaTyPlbdGthGg0AxAkRkUR5v4WBc46CjkkaBt45+X88aHASsZYvb/FbubWRLwyrvCB+A1F8/LVLRsySngve7/VURyTJK9CoMVc9+iyuNx/QtYgNpHpkfuTmYZ7C3cZZhoYW5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUrw0i2KK34XdESFvuhZH164eP2Vzh6viNo+T+ah6UY=;
 b=q3Rbjdl4Nw8PKDAwIjj25capRA/e0kuTwDmNohYub421ORTr44ccRnsCKFs3GsSHlLyLh4IXC4o6Px6I0wNf1CBMjU0YYAuvKVB9jcVhFRj0fOHKuLMblVPW5zdcLrRqsVMlJKzdBOhqYcc6aSL+KZPUNtsRnDMLgm95BuHpUy4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AM9PR04MB8745.eurprd04.prod.outlook.com (2603:10a6:20b:43e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Thu, 28 Mar
 2024 10:50:15 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::3da1:cdb:7bd8:750a]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::3da1:cdb:7bd8:750a%7]) with mapi id 15.20.7362.035; Thu, 28 Mar 2024
 10:50:15 +0000
From: Ye Li <ye.li@nxp.com>
To: sbabic@denx.de, u-boot@lists.denx.de, festevam@gmail.com, peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH] thermal: imx_tmu: Fix TMU error on iMX8MQ
Date: Thu, 28 Mar 2024 18:49:59 +0800
Message-Id: <1711622999-62247-1-git-send-email-ye.li@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AM9PR04MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 44001f79-544c-47e9-594a-08dc4f14d99a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ywCSIvEuQLIvPIpRZ8ii3IhTPJsR8zQtec2ZNEImiNP9uqZyseCt3FAx/VAJFAuC+SlOpP2f2LpUtyzoDBkL7Ogh1c0tL80Nf2G49sgf/30Oezn1skdLucfRuE/EmePL0cBZqKnzNujYlJXg/sUYUWxAhMPzY4B+rQ4lw1075gqymRx4DoZ4Xzjxomm9qHC7RVkO/i2avywTY+bRT9Nb7Y4XeHdYbzSeQB4/0xgr8QJIa+tfyrFhQC4ZSqUX7Kzs/6OKjF2NDS7y2BQt7wWZj/oZQ3TwJHnxcp4lNNfaFBfhyqDegMnUVBnNyMjurR3StaaFPxv1ZNlnjOAX30lvKeXql67I2lE8dedvaB1JayaSFI06pB2mqpfmaC7RsJFYqgnuHixooT9pnVULNLWN2uIjvthrnd6uGOwi55xCza719NhXPV5IK9bV4K48P8hygoS0DER0F1L2O/2wWFyE/IP+4NVSL41O/JTjA2addb71XND2akzIDR5qbe7XRzZe9bKQYHAOZYW+Zxno99nCPXKmfFIvabNqSjc6Ge32JsIpfPdvREaptg//Nn0JGL91/iflex81talBZnn1hYDLwa9Bsg70r6BFdjA91ZRopuvkR6PSZzrGz6tEeHiL2qI1kYxWvf/7ZmRmIEiafoaof9Ff+DNQnXDDj/sEroqMFMLBXC+0ogIG+uTfklPZ3J/ezxGYK4HgIN7GCaxUBd4JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vmuhpFKeL3h0gQ1UYIPxUxvwuux1GIC4Va6MJiwiOwEhzvSmFq6s4GsOoQWf?=
 =?us-ascii?Q?AQoOlXZk8BsVD02ZWkSKFbEnenFTo5Gs5bYXUFIfmlcyYxVrRRpK/pG237YK?=
 =?us-ascii?Q?FqN6h6W06tue8E8rlrPtegyAnOnK/BfOmp5cYvj6oF44zaqgpG0Q3LL148Lu?=
 =?us-ascii?Q?5bpI/w/O6jlybBAGAHR/Zv0z2EHyteAdNbh+qxlZw7qqqZEzJy5eCLm+8rIY?=
 =?us-ascii?Q?F/jgsVzjITrSc0eeuvhwLmzpenfPsvRTZDBjNOr/YxWtxthb2tZorC/DHcAr?=
 =?us-ascii?Q?XKTI74NC9s+Z7Xxc+aV8Lm4953AOdVnAkEuxTV0KoeePars+KgzkyZABxkd0?=
 =?us-ascii?Q?yTotHqk3WXybIYdODO5UAQ/OhcuV1tDKzAUcNnQJS4EHKDqcSMYXkjPl8XtA?=
 =?us-ascii?Q?CIAHgLjY8TJKnSPty+UtDOnUmXQv4Xv47kqKFCFa2z6VuyplqpqaDAxMnbS5?=
 =?us-ascii?Q?rFCb1v/uR31210EVVcOGXyj/WNCjy/WPFTMoQF1P4W2lW+ociL9SFKN0oloR?=
 =?us-ascii?Q?LOXB7AWMPUpJZkZcWtcwRMykVc06eWPtw7sGl6PD3h348QQdTUVR9ouNZK2Y?=
 =?us-ascii?Q?SyZTCe7SZM13D4VSf5Q66XSXcjlrnkejsrKY+GspibtSK+JDOjAlYyBXM34t?=
 =?us-ascii?Q?1ghq0Tv1yKPT8GIGbbACpEyj3uYKeEjgG+nIJXebhQOc4gtNmARxyiFiMX8S?=
 =?us-ascii?Q?QkSLkmBTi1sla6kkBSJrarSeJAjVsFBJ6bSz3+QH+c8Z9PctOYJXYdAIIYpT?=
 =?us-ascii?Q?H0Dn/LpJZ9qN8FxVGSqatW+cNd64dfKfZb1PC93H1+Iw01S+/JlcNAdMxuH2?=
 =?us-ascii?Q?2iwkJsprGVShtWXZWPBGHkVCXL0+G1DfuciFwwul9wHGeKg8dlX6BQh7zG1N?=
 =?us-ascii?Q?s2QPgcu+Q6ldCqMSZiCGzT9PLeXUYQfS4b9DPx6eoaVNJVwbzXXcQf3+a9im?=
 =?us-ascii?Q?elNZPVO1+tNTfTX6iB6Att/dNjnpsz/f4BXFRheG0pddwPEqMz/227srQdVD?=
 =?us-ascii?Q?pZtKqFe8jndUYJ+2x/9BkMQgk6INL+gpZ/tCGJKbL2ImwACpboWdlbPMzlei?=
 =?us-ascii?Q?AE2/1Cjjm5J0N1O4qwaxN0SZ8q3n6dNv9rS26Te5uzSF18XIz6eVOD2NIymv?=
 =?us-ascii?Q?XYLYqqgO5uEzhP51C9qIvFgs0N/29mg/M17lpnw6joH0X53Nqbb7tpkDYM2G?=
 =?us-ascii?Q?zZ141ChRWua4MmyhXbLiwehVD4jLBuStGGH04sQ834JYugFCkfJIN1lncGGX?=
 =?us-ascii?Q?NCFHadUDx1M9Zyy20NEPiDBe2gfviu8TG+o1pEuVRcThP86TgbqM1nLnabqK?=
 =?us-ascii?Q?Zuv3XHA4Q2D2uikqsfVhFablTnaVHjITNa676jJteGb5sxjRliBr+Rhb8Qo1?=
 =?us-ascii?Q?x/DiH9sSkwy/lhcHP6MD09dd3oVKrS/cdvSqPW6lSoHD27jFam7G+DgLXTxF?=
 =?us-ascii?Q?qGeKFmsI9Pokl5OOBbZpYW1cWD7I/PPGKct63qzEKuZXvkXIRwYEvENvDM9T?=
 =?us-ascii?Q?MmiYc63oa6M6HLP3HNIjSnols0ATc49PeNW715iqxUwU5Is5YTGoLOdTShvk?=
 =?us-ascii?Q?fP3K2NGLiVKTbmb78jKtm0t3iFN7usuOz7VDCXkp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44001f79-544c-47e9-594a-08dc4f14d99a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 10:50:15.3445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+r7mhzgFo0z5S9Xg83im1dZzpZHtk9dlYdsJiIL6WNWsMdjS4hKv3fZ45Ls/mZa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8745
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

imx_tmu_arch_init does not implement for iMX8MQ, error is returned

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/thermal/imx_tmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/imx_tmu.c b/drivers/thermal/imx_tmu.c
index 4721cfb..ca775e5 100644
--- a/drivers/thermal/imx_tmu.c
+++ b/drivers/thermal/imx_tmu.c
@@ -402,6 +402,7 @@ static inline void imx_tmu_mx8mp_init(struct udevice *dev) { }
 #endif
 
 static inline void imx_tmu_mx93_init(struct udevice *dev) { }
+static inline void imx_tmu_mx8mq_init(struct udevice *dev) { }
 
 static void imx_tmu_arch_init(struct udevice *dev)
 {
@@ -411,6 +412,8 @@ static void imx_tmu_arch_init(struct udevice *dev)
 		imx_tmu_mx8mp_init(dev);
 	else if (is_imx93())
 		imx_tmu_mx93_init(dev);
+	else if (is_imx8mq())
+		imx_tmu_mx8mq_init(dev);
 	else
 		dev_err(dev, "Unsupported SoC, TMU calibration not loaded!\n");
 }
-- 
2.7.4


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDB3CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 23:44:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA5B683844;
	Thu, 14 Aug 2025 01:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="g587gIsJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC7F08381D; Thu, 14 Aug 2025 01:43:30 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70B02837F5
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 01:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9AUO4IfX8IhYX5POOx91QNx34I0izLUJOt6bmiwudliCmeEMUlwt5tkyK6tqzVfr1Df5jAoxu6uK8bTbUmwDHEnWuBMY7ZS7LdI8c+qJHs3Tzb7Re9WI2W1IEXpwmftP81EDThs81jzJszpNr+si0HDn2XKCz1czDh6Zj4jdWFLZpXOesp6YY+bAAKfVyYDB1PjQfoVnpBx8jJqujmuu0wMhvVAmfmIMlFIFbkNaPLEokgUqG2rGjI+hPMXjXD6lTZv/9SJXGw7d/LKLsvM26jXMCdM5ggXmbIfY7sJUg7OSzXEOTzjRAIjkP4VyMgd1FPf98LQKYGzh/AIsV46yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLfqzq6uzBu/PHu4ycsLiVbWd/9ClDqQD49NqjqoRjg=;
 b=Bv/uvhzWIOp4C822bDv++vTBdkeG6Rty5txZ54xbGMUcj4ytG9mts/n7YPMt+yTYZckNQhWSP7/RvCUHG2spro25P+RviSPYgw/JiS5/mEjEFkEP3bwois2dI6ijyiReUcyZhkEzNpK3o9HkhTGCwMTfuHUUwNM5PnrP+bnZVVvW75Ghm6juxNZjr//eEchsifarBGCL7/aBgous6tcH6RJJw44AovuDbc0pacoGLtRr6ewtAO83zVDv1Z5fXG/OSLS5AOk8g5K7BjTh/d92dYBYcPGh2MnNocOT2Fn+/Iqm09cEjDiOfh+Nunt5cWUoTc+vFS2NGNV4bt4SlVKekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLfqzq6uzBu/PHu4ycsLiVbWd/9ClDqQD49NqjqoRjg=;
 b=g587gIsJT2DMR4R52swAnGpdUb314uaKKwp9eHQTjOoRX/5T2tAPhHO7jwPs5arbnxqpMsQyfcrsDGMXd8dIRdBR/r3rcY0ukneykLaO+N8dNTJ+me/tnvfMwX4tzcR5NLK1do2We3YnlsFVnW4qbkcYjaAp3iwy65dg90ueEmVigDyKjbG7Z+9fU68NajF97t4HlcFHPbew3FEk/pR1u85F4+/sM79AsZps7DT4qUIcf7m3oIughnWZ+77J2omWUwHRXBFbYOCn6MhHFvtK610rRMvc8p9SQBJkfFLb0+4W4RTGLf19IbhsuiwEktMYAZefw3TZ7dKkDxGgXookYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11021.eurprd08.prod.outlook.com (2603:10a6:d10:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:43:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 23:43:27 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 03/21] mtd: nand: Add a NAND page I/O request type
Date: Thu, 14 Aug 2025 02:42:56 +0300
Message-ID: <20250813234314.3945708-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|FRZPR08MB11021:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c759ba-142d-414b-c9d9-08dddac3334b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?11r9/DuYQm814ZyQo68/FIuqWfy1oaHrOsA+UGWn0pBzwGlGTflgxXu8CqnJ?=
 =?us-ascii?Q?3KLHlz9074TEDeuzewkrtgCzq2kQTi43Sz21ZllIR/OQpDyQRPbfOmQYFLC9?=
 =?us-ascii?Q?VD34TwHL3nLBWGPZWUezYU7mSDqjx53ka+nwLCA9Hp2dVjFDOoz3ogFn5sia?=
 =?us-ascii?Q?hCuVoV952VN4LYvAw4RCpV4rqPHeKiSjdvXtQPF9cPJLgt+X64dw8iA2v9+R?=
 =?us-ascii?Q?q0i766FLbRD6mSFBYzrkHuiPlAxXucxFKoELj2VQhSegubVZ/MMx1ckhINdB?=
 =?us-ascii?Q?cfm5fliS/QzCu5+MOrtNA+tfl2ndhNItwDaXz7TuK4BgRmdqODlLwomj942C?=
 =?us-ascii?Q?ui29yVqrxf2xi7e4FEwkHWGHcgrOvm42Adh2SQ0ZXZyjMHFrImVDUtWiD4lO?=
 =?us-ascii?Q?OLIiNSySG/vq8kQvwHrFaHO9DEH2QvMhzaMYFAaezfERxUi0J+0sJ5QcLe8a?=
 =?us-ascii?Q?A2hl9Pu2stHk6M09wli2z1VUC416AK96uMBjDmYWBeB7h5prG1l4inyXQaMt?=
 =?us-ascii?Q?bP3/F4xWtLnpAiFlF+zmVpzDA5fPxIh9Z88UyvlYPS1v+f3KOabjZ5LwDiyo?=
 =?us-ascii?Q?8cR/Mourcb/vAG7KFBe67taYF6e6LeJljm5cumujanzQfbhGhd9Ff6fNLvvL?=
 =?us-ascii?Q?Kt/TkJe5j6ZLZdA7p6MbV6lb++IqrIeptAx18A9kHoBJXOcl8wGCpYH1YmS+?=
 =?us-ascii?Q?2eqnkHJgH3j8UoJ86gK5+xZyENfmw/1yWPOGHW5Yvkwu7dPIbjfZxGkUUrl7?=
 =?us-ascii?Q?CtdEz/A39u7BlKiINlZAPl2aAL245EhEoms2CinmpBREY3mK1fQBFtxZOP3q?=
 =?us-ascii?Q?H6aN3IS6ZMnCfp5XH1nnF7MhsnzPPrRItPU940MN0/p+NwlY8NXXw4ew55na?=
 =?us-ascii?Q?8cDZIZhWkkuH9agPpULwKtlQJ+ugAW1lxUG8a7ZGR1lnpQLT4ngdtRtNdC5Z?=
 =?us-ascii?Q?nphhe0nNVtq9CpsAoj76r3Qv/UMNSc4Y19MUFpGDsE1/Y3k2Ip7h4oPHWZ8T?=
 =?us-ascii?Q?Jr20n1/9FzfxOtlkvSsObXgSXOG+/LaHP2Sxg5AvR6h0Amz+Fx6ZUdSyuHWG?=
 =?us-ascii?Q?Gt5NVdceGKWNsdkvMCS/q0HzrdCzwnACUmepHwfNAu6RtcFqu+EWd37WeLKb?=
 =?us-ascii?Q?eIjoH0nOHNOJK95RXVThKN9Srnj2X997p9VsSioQSvi5Hztxxtj6kPu8Fv3a?=
 =?us-ascii?Q?6hJ4ALRtFT3Mj+W9HY1RoxZxMVboRaiBCzKIt6IjlwggtL+tYaFwWiQX4dGi?=
 =?us-ascii?Q?Rcs2oBXXwCpfFQyByPkzMsG4mVGZX0XJTVdwd4NmGIvfdt/XQnnii10UWBIo?=
 =?us-ascii?Q?ooVU1wIT59bJXK+EaJPmm437s3YDV+JmTro64dxL1mT45wOI/my7xjNrh2Zv?=
 =?us-ascii?Q?o4eZ2Iu048+yRqDysZZFQ7R0U03OnvAk+vHr+mTqeG6NNMesfJulDn1cQWCP?=
 =?us-ascii?Q?++KwMsOi3uBC/YGmU+YJQU0k0wSHYTIszJxhrxMEAozlJMlR27H/ggA1SD7M?=
 =?us-ascii?Q?CvmeyuHEz1bekR8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VxLCYgtD9LpuMH3J+tkXK2IiAU1yl0GC10d40SRj8wEzOKzlZPq7XqWG7Ef6?=
 =?us-ascii?Q?TRUnMFvK6oHPHqfk9RufWrNkgX88u2vamTNIhlSbSFygXzXV9c4zVZ6XlfBb?=
 =?us-ascii?Q?h6tloWeaYXX+mnOibn0TwgwfBXDBdBaMHsOlrtHA+z/0mca2GKpBp/tz1F3Y?=
 =?us-ascii?Q?S9wvfQWddjj9zq+SeNZnta1QdkJR6aSOO0Iag96Hejg0AYBOPUdNsdDcoSzV?=
 =?us-ascii?Q?Ib+HAH8ruThHsoOK3/wNkTwnCNxUN+gcBgklxln+j+Nwzvv5TYuUOsC6EfjE?=
 =?us-ascii?Q?e03XatERxrR2LIsfiZbUjgZjcn2tYvCCvW5fAJMKusZqIn7Ant/WiwWLlJwr?=
 =?us-ascii?Q?haL2heOOIJQQySgnhFzqLOIP4UEBECHE8SKVVdw/8NIdrqfgs2+1JWXgSq3j?=
 =?us-ascii?Q?4PN+VIPocsNxaLr+IWzZfmfPAsmAbBzGzzW9mahay2pReM8CZhkSB5nqyrSu?=
 =?us-ascii?Q?EkqJOgYs//HJXwO511XNU4OefozKafSSdvOLipCBYRp5qMpepPa/GrUPPAHl?=
 =?us-ascii?Q?I4AHKCT4T5QX97YafDYX9Dp+Oa036fjPLm+BXQu2WZbEk6l8zFAZjC3yfd0c?=
 =?us-ascii?Q?W2NdY85KWcp3GwZS2PZpBbUDPd/67V/X2o1BfV25Whr8cPtUjrN4iIGRvvw8?=
 =?us-ascii?Q?VU7rQyaV3sBjFqaGRKXSiw6J3xKCczPnouLFriV4Uf0Ev0vQN/Jim3YD5YUb?=
 =?us-ascii?Q?tQsaif0xkingd+mA5aeqfpY5kuM8Iel5PxyFrqf7vrtu8u7V8mksG4Vtbv5q?=
 =?us-ascii?Q?wNmh93ZSLC910LHBpa4oc1NliVyMOF8Hwj7u9M8AEZYbLnrngaK8cxeHlJRk?=
 =?us-ascii?Q?jzRQFnGpaxNPjsvmhhmxOUAfPwGFZtXG0GtaFynZrKuICYQi3vOSXVVTC8tp?=
 =?us-ascii?Q?AH0FIZ9mwvK6cHROoiTjgVPxhD63ehY3NZeiFVqLT76IUjSuefBzeR1UwCkF?=
 =?us-ascii?Q?BPZdQab1TyxGbB5zTFhxnSH4pVAwTVQO7RsaYUDVy5JE1vvzfAmctk1zSdwr?=
 =?us-ascii?Q?5Wl0m0ai1hn9Tw4O7bQLUNraDZpQSwVe7iBcWIrRFEaZON22NnfpisocmKNA?=
 =?us-ascii?Q?TFp6oIDIEPdPjQTWd0wJXiwh4aswtunigYI1Vw39DXhkJiyMxpieCH4xRyUN?=
 =?us-ascii?Q?C17nnq/w4Nu4teeFCBKQXj+9olUe6+nuOD5D8Zxswr0qHvFbysTf1c2/wMFQ?=
 =?us-ascii?Q?o4J7of6cfnnl8sr9RIpk7XYNXI4+aWHoT+XGG1SfVt6zbQ96g+1bW1/lw1tY?=
 =?us-ascii?Q?TZo9P6v8SSv7rFpypaudiiz/1eRG9NqVoTV8ayUCgsd+Io96EsK/7XqIuij9?=
 =?us-ascii?Q?Xx0ywe/fYuD89MKeSdPgDT3bO9zOMv6aEuyOYdXauG6N6O+yJugDOJzcdgUi?=
 =?us-ascii?Q?CdF3dQU5LzD4MPhIkG/rjmq11ZFsqDyQcSW+EeY1uWEcelIwFc0zL6cMnKWV?=
 =?us-ascii?Q?RPhxg2s9GxgUwcHFYAc8ltc0NaP8HRAWUInSre3KZi5feXyyqZYNAUGoXO/n?=
 =?us-ascii?Q?Up9JUXnt/BoDsy/+auu+kFIfA176vppl3IfRdp2m6vCLBlZG+ZzTCD0E8Sno?=
 =?us-ascii?Q?39ozgKJMtV2g6zPRUPRiABNlB3Dwv6mgxIH2srNAngFzeS/7iBN2sb0MZA8C?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c759ba-142d-414b-c9d9-08dddac3334b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:43:27.2255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKIIA/Uidxt7AVr+PxoKTzl8EMIc+eha+SNxc27AKpZU0cMx2qHdUVXwIyEZnJYfain1twPsrElSnbgWv09V1+vid3GrOEIyb2IVTEIAVtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11021
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

Use an enum to differentiate the type of I/O (reading or writing a
page). Also update the request iterator.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://lore.kernel.org/linux-mtd/20200827085208.16276-5-miquel.raynal@bootlin.com

This is a port of linux patch 701981cab016 ("mtd: nand: Add a NAND page I/O request type")

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c |  4 ++--
 include/linux/mtd/nand.h    | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index c1b8b9627f2..d8abd03e919 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -523,7 +523,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	mutex_lock(&spinand->lock);
 #endif
 
-	nanddev_io_for_each_page(nand, from, ops, &iter) {
+	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
@@ -575,7 +575,7 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 	mutex_lock(&spinand->lock);
 #endif
 
-	nanddev_io_for_each_page(nand, to, ops, &iter) {
+	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
 		schedule();
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 651f8706df5..0afdaed5715 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -80,8 +80,19 @@ struct nand_pos {
 	unsigned int page;
 };
 
+/**
+ * enum nand_page_io_req_type - Direction of an I/O request
+ * @NAND_PAGE_READ: from the chip, to the controller
+ * @NAND_PAGE_WRITE: from the controller, to the chip
+ */
+enum nand_page_io_req_type {
+	NAND_PAGE_READ = 0,
+	NAND_PAGE_WRITE,
+};
+
 /**
  * struct nand_page_io_req - NAND I/O request object
+ * @type: the type of page I/O: read or write
  * @pos: the position this I/O request is targeting
  * @dataoffs: the offset within the page
  * @datalen: number of data bytes to read from/write to this page
@@ -97,6 +108,7 @@ struct nand_pos {
  * specific commands/operations.
  */
 struct nand_page_io_req {
+	enum nand_page_io_req_type type;
 	struct nand_pos pos;
 	unsigned int dataoffs;
 	unsigned int datalen;
@@ -613,11 +625,13 @@ static inline void nanddev_pos_next_page(struct nand_device *nand,
  * layer.
  */
 static inline void nanddev_io_iter_init(struct nand_device *nand,
+					enum nand_page_io_req_type reqtype,
 					loff_t offs, struct mtd_oob_ops *req,
 					struct nand_io_iter *iter)
 {
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
 
+	iter->req.type = reqtype;
 	iter->req.mode = req->mode;
 	iter->req.dataoffs = nanddev_offs_to_pos(nand, offs, &iter->req.pos);
 	iter->req.ooboffs = req->ooboffs;
@@ -687,8 +701,8 @@ static inline bool nanddev_io_iter_end(struct nand_device *nand,
  *
  * Should be used for iterate over pages that are contained in an MTD request.
  */
-#define nanddev_io_for_each_page(nand, start, req, iter)		\
-	for (nanddev_io_iter_init(nand, start, req, iter);		\
+#define nanddev_io_for_each_page(nand, type, start, req, iter)		\
+	for (nanddev_io_iter_init(nand, type, start, req, iter);	\
 	     !nanddev_io_iter_end(nand, iter);				\
 	     nanddev_io_iter_next_page(nand, iter))
 
-- 
2.50.1


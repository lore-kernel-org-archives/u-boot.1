Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ABBCAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 04:21:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1260380B9B;
	Wed, 24 Sep 2025 06:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="X4ps28MC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 115A4800D7; Wed, 24 Sep 2025 06:20:50 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8225D808AF
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 06:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppSqOGr6OAcOTkvz9ioQ75KNKhYJPDQpievVmIc2FgtxddPn/lIhdxYtZwoAFHx8y3JndvfjOl2MVwmWjEjQtwnLgV10w4mI97tZncfA+uAcwLKGio63VTGYdNEHUIgbpQgIW11oXzxnxETqoUW2t021LbhPATrvgQ28Dm+QYhlTsHV8qnRZB7UFydw5eRNtLzmj+IF31M7RV0bT1m520ugZQk4kAdOpr9/NiG7S0+zsOrpORDl3lCdPr9XVomGzJ+oQ3InkAKGJWfGzZM9g5r/lINnE9mJeO8mHkk18+ocbeDlrHK6geSCDvGe56WORnjh7GuZIxxjmDcJKA+qmtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIAot7O4PMObXjI3f9lKGxyvIH24A3n6XZ7M6K4b6ZE=;
 b=D31qyTwm3wjR42ffOHlSbq8d8wA23sLUrsXGWJ/qiO7l9LPof4ieXSuZJKiavtR63w+dGqWJ9NXUSO4o+yfkBI1AFgPkMuZldFTnoFNGde/VSoeJMGziaeuM3u2pFCgvBHCyyt1X7dbWWv25dcLwiUuI6eSk4hCNEdgFhmMrrSUocupPBm3uhRDA9oCX+GLs9sJv1F61D3HXPX+vtdmFb8bvmkiS0huwAS4hSxOSCquTgjmKBzebyAa4LXYswt8Pe333vnZbHWRM2XhQ0SKLER6879Cciu90r2OYdVwiS1YKxCWi4iGxEOa2yDNxhk2wVtDq10oqWOKHJ3Kb6Gsikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIAot7O4PMObXjI3f9lKGxyvIH24A3n6XZ7M6K4b6ZE=;
 b=X4ps28MCRBleuQlcTpJr3keq8QvT8Fmwtx6b2KVNZF85goyNK4mBTfqGcnpTD/TYc+8yG+iaJqy837iXDmkmQ1adi+obMoBf71VVVxQ+ICecdzNAZVrQsW+Eo0pJlnZIv+rROMPLHYu5fYk9ZZsA71UQ1RhcoN4Fnv4ZOONuxmT5nway4Gj5AuEkTUQEUOD8tw6WG5QcRPLcVQ4MUctFbWcOG9qmGinM/54oV9nEM1iCkfDHRU/jfXU16t4YFbnsQJF+zwxC8MvWTZ6eEDEWoGfvLQio+AvZ1MZ+fRDikFNCgSuviSr3swW7Kv6LkzKjk9DDVQ/zeeZqdfeXFRuJMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB7552.eurprd08.prod.outlook.com (2603:10a6:102:24f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 04:20:44 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 04:20:44 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v2 1/3] cmd: mtd: add markbad command support
Date: Wed, 24 Sep 2025 07:20:31 +0300
Message-ID: <20250924042033.1873771-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924042033.1873771-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250924042033.1873771-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b6eacf-d141-4c7b-85bc-08ddfb21baa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TlKix5/Qn1+ZKaQIP+AM2QK5s8UPy5BWACI3K165Jh42fVfAyFXBl2FUtPcI?=
 =?us-ascii?Q?bOSqe9/lpkF+GzIAPO474wgC5d0tWbEf1qRPKr5Dg7NuYT/O+ISHkAiUfB3Q?=
 =?us-ascii?Q?LKC6IhF3s4PGpgRVfaPV3ejGML6Mpf81CjlGUO5VK+ePnSc+eS+bnMjSekek?=
 =?us-ascii?Q?F4YKKmnh/ljvHlcbcGH3w9NX6C1phZ4kCsYX6VN0HjoSmAREttFDX2csdFUV?=
 =?us-ascii?Q?LNiwpwom1lranQ/G6x9oPrg4TSMUnqJXBSM/KG9ySrmE2VL+BEKnYnVK8K44?=
 =?us-ascii?Q?b7Y0sbBE+KnkdXFjiEwnbheFkCafZUcfsMUNtcsSbp1JPhYQFbj73sOOZ9eH?=
 =?us-ascii?Q?Q7gotSRf9YpN5pTn4pk9tkSTcmypuszrj5mxCZI0C665qyy/Ww23qfGyBcWX?=
 =?us-ascii?Q?YFsMXFysF23bc2wIziDXaHZ6MOmziX3zOQ1BWLbbh+HeUJxTQq45YXba0H07?=
 =?us-ascii?Q?rAdJI1li7fZGo2FVxSpItlzoC0MwKUNYCDIv+RWPzwEjez0xs/+L3e9Z5TpZ?=
 =?us-ascii?Q?2k4JI+hWHfGoRsOwALByQUD8REBDVLaE56XNlEkhzu7UppgoU5f640ildNZ3?=
 =?us-ascii?Q?qyehAfRb6Pkbo54agJM/4qi9CWla5ayWsz/aS6FUQwpUQbW+qt1yhGZVCTIs?=
 =?us-ascii?Q?IES7mXjd2ArcOnzfb80+r4GnSJkLEmnL3ZUtwnnV1bfyS2JaoRQuKpEK0o5E?=
 =?us-ascii?Q?chx/gcTeQk5ZK8+ojxX5emnnAPRLL71DK0TP1YmhqxbhSJajR6at5FemJNYu?=
 =?us-ascii?Q?B0iFrZgu/ykELNyE08rcMRoaTyX3d4Wirxv82A1kN+LFZluI4XC7EFTuz38d?=
 =?us-ascii?Q?5shb7DdZ6o0NN5kUkTVxO9Lf0nr1E4bYAPZpSuJAfoaC29UqYol6uO0X8A35?=
 =?us-ascii?Q?heEZ49Tpf46KcPj4dSR+T86QbLlKY73I5ZQGeAhvGmVKD344pPlvHhxHCXi8?=
 =?us-ascii?Q?1RckpUmFqkTRuW8eBcSHr4ZR2NuvwyTQugvFnPM7L7MPvdhcqHkNklZiyDev?=
 =?us-ascii?Q?l2ZSGgarm9oN0SonOxQvpU0YYczjj7hoVKHRWw7ryv5pXmJth+4T3Dwjn4oD?=
 =?us-ascii?Q?eHXeP8Fs+qfuKdmjr2OCSPoyBYDPer2VZEHz8uZUUTC83JDrc5osHYReYoKb?=
 =?us-ascii?Q?a0gQfY1eyd14iyl2m2qQJb8Qa0ZHRUrn+b3qBrHfeNIaAxfqHr5xTswbQomB?=
 =?us-ascii?Q?ZQcjMfvSge5hbH3SJxikhdESblW+HjgFbgma2ZvviIiJEJr83NvR+59b3Rag?=
 =?us-ascii?Q?Smdx0GkvZvu8pxn8WL4cE1dMKafcx0/x2zmJfqVmcXJIQuzyWhXT59y5H52t?=
 =?us-ascii?Q?cFbtwaHjDdq+AJb0NSUaU+kuDD5NJQZZGHFwhd+/ahGDEaBfq42eTDt6hvY9?=
 =?us-ascii?Q?ka3Camo0kPjVSRKb+6iHa7hjMNH3xdHDRxCSKE0pqwgJs3l28TjRvmVmpDUH?=
 =?us-ascii?Q?/O1wkDExjCarIQ5gj+ZA+Nqej3VFvo/mm/F0bqc6KCfvxUf1hEBR5J6cj8im?=
 =?us-ascii?Q?ko66gQv4fMaM+RE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GUG72izgCdE/asntujEfAOczgy0fgSMFM60VtUhMyPk5sFylr5IUa9ClooW7?=
 =?us-ascii?Q?G7ZalBqfAcbe0Dy7bcj+S02iO4fSUkGLhZ36G7YBUzCeqEW61QyZqUPEGgBB?=
 =?us-ascii?Q?Y4YqIeRn67wM4KqTQ5Z+ulUpLZ+WqTf6oljD9iVpx2kGe/tqE9xoxMFplcJr?=
 =?us-ascii?Q?y6OELsERYp8+5yb9pyFF9gQerdiRUwvPfuL9Kx1wRjHfU+QiTbuPCJo0b2LU?=
 =?us-ascii?Q?SPnj2eFqnAt1GjTD50IEeecoikB3MnGmyHRk2yN3PRIxuWaRmn8xDknBz9Uo?=
 =?us-ascii?Q?UNtz4IZcE77rOpCgtyAyIEhV1HEVlkOMFh1eF0viqIYYGuxmtoVNurljg4H5?=
 =?us-ascii?Q?meMARU//auxfx/7lDLJroiq96AV79wE6Xo/TcWcue55Sf6dBhyXX4iTcipbG?=
 =?us-ascii?Q?ny5xzSY3LgpbgD4CAu0peSlcQm4YsyQk8TSDzbGScHjfrnYod5jADPwfzC0j?=
 =?us-ascii?Q?VMlsmmElVgGZDvJAfHV5LYmedQBzxowL4VKRJ0e/nbaneDBe7I4HT0eTlvNL?=
 =?us-ascii?Q?M4mrslMPZsG3MgIITsnDs2wOE3OM2V91eNPwHIkn7ZxXj4GM+FmAROFGccWk?=
 =?us-ascii?Q?IQXz9ZyGsaxJSlmfMYBw2HtnUp2eoFkbUFVAh8RPcpVEeA3lM3v7s37fbKKr?=
 =?us-ascii?Q?ELRD/rBfUledUN7zv395/S/PiBIYtqUmaUyWd/B4J1I0EmjvVtbHw7/kEEhR?=
 =?us-ascii?Q?UQJ3U0feQ75+HKCtzeYsMm7NRRmOl0cSP8JvckBz1HIOL7ZwBp9myP6onf+4?=
 =?us-ascii?Q?2P63F5X6uXLrX7BH4KSMq+aKDynRVrOax3m3b0LvOusUfg7p7r2qLUETJtik?=
 =?us-ascii?Q?7tJ4VshHIDlyclE6lkObYGjPejkFXCDQPO7Sji6e6DxRE2JBEq6OfG4ycAlA?=
 =?us-ascii?Q?HOWxTjyajeZBSgpOJSheCgSWJTn9LpUEi8/6BnsxXi5LnD+7O38fopJBsHVj?=
 =?us-ascii?Q?ljRH+hpLI/RU5OyGTFEcsxHfVQ+7vLdY6REOOI4xEBs5JA0CQwk3BewLuJ4y?=
 =?us-ascii?Q?WL7VV3Bf5VVDptFzp89lSpaiiZ8TWsbDNqnD8oMHYrVjaT6sylnQobMDGl1r?=
 =?us-ascii?Q?GaMpmlJwIvXQpOwBSn+P73SS+EHCfICHkWWzVGNXaMLdFEFvJkTs6XuKM39Y?=
 =?us-ascii?Q?QjgkDfS95Y7W/jQQktZ91sy0wknYxIWPu83QiOhirCEw8NajpzPEGUo7pyyy?=
 =?us-ascii?Q?HM01ZODZMwJWKhj5n4L2lKDRz2GAoaApBRV+dSmDBfLElU68Z5TC8gAyJDfy?=
 =?us-ascii?Q?uHW3YGjO1vUNLuSdzdYYIrYkL9ItPAwE7/oGzG1VARa1e4V/35JoMAdFiQ5u?=
 =?us-ascii?Q?x+1x0AjSAz1eGjYt1rCfmrfOozsFBtiZW9jH+lpDRQofHuj4HWpzF2dVOsvn?=
 =?us-ascii?Q?IlysYtH2eXEPsOI3ib0HNhp4LE+kM4BFM2C/p56kiUlqpwSPx3lN+lo9a3+O?=
 =?us-ascii?Q?UseJKRVJzJBtSuxJB9ehdCMn14Ed+zOOVq5tMrrIRTehZNiAbFZdum9voVfN?=
 =?us-ascii?Q?kI8UqGHxdyhxOG/oyHMqBc4xIrPt0tpuQeCb3hIuBc2YZolxdHgrfutYMoZ2?=
 =?us-ascii?Q?Tu7FrEbaRJ63nCbdJcKU/mmzViDR3tJfQgBYEfHUDWVe+xLsQa7Gvm80W/Cv?=
 =?us-ascii?Q?C8J3TFO3+T97RtiiAvxarWc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b6eacf-d141-4c7b-85bc-08ddfb21baa9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 04:20:44.2582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7sx/nXhr6uw7UrX0s2+rO+rBnIfqO/q2dIOF8WRn+VVC5GD0+mci/nSBNPrs7GF0+NNGnkeZYXq9NdRinVTRgdHpKYS3t1xSGn/S7NsNxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7552
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

Some nand flashes (like spi-nand one) are registered with mtd
subsystem only, thus nand command can't be used to work with
such flashes. As result some functionality is missing.

This patch implements 'nand markbad' functionality for mtd command.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 cmd/Kconfig |  8 ++++++++
 cmd/mtd.c   | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 29de857ba7c..8f2a35d780b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1511,6 +1511,14 @@ config CMD_MTD_OTP
 	help
 	  MTD commands for OTP access.
 
+config CMD_MTD_MARKBAD
+	bool "mtd markbad"
+	depends on CMD_MTD
+	help
+	  MTD markbad command support.
+
+	  This is a clone of "nand markbad" command, but for 'mtd' subsystem.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index 2520b89eed2..95e4be9863d 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -711,6 +711,57 @@ out_put_mtd:
 	return ret;
 }
 
+#ifdef CONFIG_CMD_MTD_MARKBAD
+static int do_mtd_markbad(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	struct mtd_info *mtd;
+	loff_t off;
+	int ret = 0;
+
+	if (argc < 3)
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	if (!mtd_can_have_bb(mtd)) {
+		printf("Only NAND-based devices can have bad blocks\n");
+		goto out_put_mtd;
+	}
+
+	argc -= 2;
+	argv += 2;
+	while (argc > 0) {
+		off = hextoul(argv[0], NULL);
+		if (!mtd_is_aligned_with_block_size(mtd, off)) {
+			printf("Offset not aligned with a block (0x%x)\n",
+			       mtd->erasesize);
+			ret = CMD_RET_FAILURE;
+			goto out_put_mtd;
+		}
+
+		ret = mtd_block_markbad(mtd, off);
+		if (ret) {
+			printf("block 0x%08llx NOT marked as bad! ERROR %d\n",
+			       off, ret);
+			ret = CMD_RET_FAILURE;
+		} else {
+			printf("block 0x%08llx successfully marked as bad\n",
+			       off);
+		}
+		--argc;
+		++argv;
+	}
+
+out_put_mtd:
+	put_mtd_device(mtd);
+
+	return ret;
+}
+#endif
+
 static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -793,6 +844,9 @@ U_BOOT_LONGHELP(mtd,
 	"mtd otpwrite                          <name> <off> <hex string>\n"
 	"mtd otplock                           <name> <off> <size>\n"
 	"mtd otpinfo                           <name> [u|f]\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
+	"mtd markbad                           <name>         <off> [<off> ...]\n"
 #endif
 	"\n"
 	"With:\n"
@@ -827,5 +881,9 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 					     mtd_name_complete),
 		U_BOOT_SUBCMD_MKENT_COMPLETE(erase, 4, 0, do_mtd_erase,
 					     mtd_name_complete),
+#if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
+		U_BOOT_SUBCMD_MKENT_COMPLETE(markbad, 20, 0, do_mtd_markbad,
+					     mtd_name_complete),
+#endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.51.0


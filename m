Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421A6CD8C8E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 07:46:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C587884879;
	Mon,  8 Jun 2026 09:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="HYOef8XE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D6F48466E; Mon,  8 Jun 2026 03:28:26 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9111883314
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 03:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFNw7eKw2uoCkHl7jCeGxQGTalQnSJzwid+Yq+zEWyYMkbQVllh4QKAyJnr3Sve/COhUIOrSCFXPdMSnGgfCAZS4aYtr4Yn9xPnral8M6PzscKqyAPocU5tYqUpCShke64/z57M5mc9a9hKlTvGDg0RsSorMc6UBhroQamdCm1eEXKyZ6nwg460gIrEdwqG25QIhJgSb1HOhZTZ0F2DV0gIyHUgi+QCXFBxJKHTs67GAM098C13+/GBl3Ys8h11MIUXAV4iUmJAFWzXCNa3zhiXLUPr3tgTkHigXy/GrE0uuWN0K7zVLcvx2TIP7hsOFyG23sesnN5ZDFzfJ1C6Rqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnOIdjZzcgM42p2bGKyRHlnA/ZCS7sy3h4HSPWl8RRM=;
 b=aZKUVnAeJtPFjnQPAly7r8fZqVfQl0KS2DlQEGnzu5MaTVs/fko/jk7DwMHyX0Ai7uudRagADlS1YEEJEn60zJ6tSAlzwy4RCwZlKpz0tmFugKFU8TO/jjjiLVMhy4peZ4Hv6eT33jNN9dygeszYSk7gTVPPxTMg1NnJ4kYZwhmMOSHFs+WyMLXWLGph0iGEFRKgTReW6VhJGpfHqW3kdhiYamarM1CJqjtyF7rmdWZ2CzcJglx/RsPYfNFkcq4ERIP+3DwCqbQtHoGXPZDpp3xar6uuak87iNPPBgUg4aQDoKJA+EFZ2N1QilAODQNZaOxyPc7bMDVXE8+uhu9xRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnOIdjZzcgM42p2bGKyRHlnA/ZCS7sy3h4HSPWl8RRM=;
 b=HYOef8XEu0oJXEKQNMJP1nD2We2aswDJtsHZUa838d9Mg1XJG4ABx3LSGsYA203aapclWnixSYXvWuje0qdTUnFoUxofPjXoMqm8UGt1XSORHP6XpDrTGc0E1H6KRJovGg4Yf/02d0tLeZkWei7E0AR1b7i2odO/a6Kqiic+Ael5CIbba5S8NZ/SmUvkrkWSyMe40qtAVHtiSreFcuh74z4UPNY34YlP7RCJ/J/CsvIfN8qHEKDTBKgEvssNvMOJcUSqS+fYDwWoxN47y8w6mXOg9V3C89i74mWbzC+3xWZOaCcw6AhTjoqj0xfPVwm1zJJ20cwB+BRiZuetW2PiqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by SJ0PR03MB5807.namprd03.prod.outlook.com (2603:10b6:a03:2ad::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 01:28:22 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 01:28:21 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v3 3/7] configs: socfpga: n5x: enable CMD_MTD
Date: Mon,  8 Jun 2026 09:27:37 +0800
Message-ID: <20260608012741.23760-4-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260608012741.23760-1-chen.huei.lok@altera.com>
References: <20260608012741.23760-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|SJ0PR03MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8ddb35-f8e1-450f-420d-08dec4fd3a2d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: oV6SlNZbcjjdlIa3kYZpnzSmmviV8TTJtwG/W5X3rZ9m3OAJtXVLdCCbekLgMmRKF+h6qF4L+RMFF5RMpoFLBrwDo9PG40u+gUK/4mpBj3loZFkfeVO9+HLZtp+4tKUIh2AeYiRoEidnmPpIs+J2IGtrvHjW4FULOg6Qa1SZLFqtS7etk/5Tsyt8ZHdhjMNKu/WTRqMRrpaLE0I+uT3/SFXT0Gh8NsnjRT/bXM70tpgzrHqcE7anwUvrUm8ho3twKSeATpF85WAhginV1Uqs+K1TijdlcRLv8MJMkEuWTuyZHp/H+mz02IrbwYHulEcg1AOEEOJrW0rPOMh4tPkjhl4F6cIzacjCOJAI5bIbYER0u0nKhY6tiE0ZtXyuYiMNW96FAG3zWEVF9TjfMsr3Hk8k8Jhs332DSpNq1be03P8zGnQOR2qtjgbq2Lnv6yOhFCZvzUnuVhI4Zn03mkif35R83juCWNrkQj+K8sEe3gxSRfqpTn/NXmYxjVqcEunDbam00zgyIDnrn+qxJJaF1aq768axqnV0GJUuQmqMe1gWu25a6NXaKmLSXssURJawE4TyTMY3oqcfZem6mJukl/WijKJrHIAcc9hXYJK+Pfrw/OTCkB+2F0EuCt40K0ffE2y63LNU0G0wS49C0HZh/0Lk6lE44xMaFNWBerjSfTU2YhEHqUpMcEuT+0fxIzhC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G7ct8Bl+JHjKVMxGC3E0MWQecxlVvuY8ZRkWFxHRjE6/2WNqaRezw7RJDbSt?=
 =?us-ascii?Q?0/2mYnkGUKRcXHA46R48i+RHa7nIa28/I5H+OmwJW7iyx0ZWqopV5JmLMZ+n?=
 =?us-ascii?Q?Df3lgZCgjMdXQ0DE1j74ArEoo1sawElqIMlqy3PQs7X7+Ynnk4faIFE2rS2T?=
 =?us-ascii?Q?Yug7ZskX1d2ZFgFqS2h3MyIeO3PnEEtEj8cS3KfJ0hX9aC5DD5Ev+LFpCrGf?=
 =?us-ascii?Q?1eCQDFfN+JE0+VYTGAqYimG+tAje1cD7HEZe91+7okjdCPzJ1SEzA00ShpNT?=
 =?us-ascii?Q?0sytvvirzg2YiHJjMkUqz3ChjYJSSR0irZuHVWlEie0w0TJ2C9kPJjyuzq2w?=
 =?us-ascii?Q?wW6+udqqS7prdPClt7U1ooeWPnvAGwKxceOIT3AzosBWT/0tm/Xl+oQEEFBm?=
 =?us-ascii?Q?RkRfK7qGozB1mbpKhhXDu6WlLxBOmYUx/6icKwodt1jPFb/yPxjWmawzQwZO?=
 =?us-ascii?Q?2s7VcKzmskrVB8d+gbWhT5JXFk0A088lw4g4Oy+9gaOC/pB6cXcVU9ovtgIy?=
 =?us-ascii?Q?lJ5p4E67hE9tUK5jfBtiaNbbSCIY9qVfCT/ToQXu10idY8FTwCJ8As/x6rQ/?=
 =?us-ascii?Q?HhP5zg2DkpC7/L+pii4mBTF0+ROtxXXGwL6hLTboRbRwrxC5p3Y1x60OQO0R?=
 =?us-ascii?Q?Bm0bOOyysfdeZocovkiXYyGNtMUQmCZolynpJdp1A0htgO5aJ8OYN8cDI+JR?=
 =?us-ascii?Q?75PtrH40L4tm4ZxnTOMdeOhliBW5x5dyBY/oOiUb9/HQJIYpdVeOSyDOXvgI?=
 =?us-ascii?Q?cgLwVtSoSZ/Mk5SQsRAERbtF+lgmTTa7wvtyYJ22Pa49bwEAEE8kLAzdemr/?=
 =?us-ascii?Q?RmpORndeig1Yz+mTJt7sP7TBF41rztGLSViOexQIKuu5Uu8IKmoCVssQDZ6K?=
 =?us-ascii?Q?Yhi35X4YgE0/soQNrKfLT8JE0vv0m9y7WofpdvnidKAmV0qgl5iNK0PNFOBH?=
 =?us-ascii?Q?sYjMvXXD8PWIlkO8tzHVlt0kFni7SWrJ/3J+cftrfraH1JcCoYNOekapH1Na?=
 =?us-ascii?Q?LAZFAsjlk7O1eBW7gvd7LbaINtKFcBN72oB6r5RG4Cj55F6maA/9j2saUzjP?=
 =?us-ascii?Q?VXxPG2fVZWGWajiMqE6UgzUc1NN+i8IN/UfXJRHTAJGbbl3mQ18VFZ6tzqV3?=
 =?us-ascii?Q?xj7I1oc0Kx8Zc3geTYcnbSD2G6+qmJkROxUShaDEkdv4CLU1tXaalvr+28QG?=
 =?us-ascii?Q?D6mcYSSiSeCtaTOi6UsguDGS4CdFUPZZ/mVHn2fuHZeA13cx3SqaUkqu8cPE?=
 =?us-ascii?Q?dAUWHRZsTVO4CH96543exJKsvQHq66c8tzSn4kKUIORr70GKwsGlOfaLNMN7?=
 =?us-ascii?Q?SJ6QTrFeM8mf3g6WeZF3oYRvAzN8g+ZjDjkPnvE1P+6DLoRbuTqw4YO5paYc?=
 =?us-ascii?Q?1v00FoVIzb8fAljoPoLmHu08nJnKZ/Uwnn/6XWkRrDfou4wPr1ByKLhXKsdk?=
 =?us-ascii?Q?/LmKtOhgiKrPsVKPMhnHNHiMLrNnDI//w5JvVLdPj2p8yDtE+ksUq9ntsNZv?=
 =?us-ascii?Q?ulCZfk4YFOhOJkYqR3mjZoRZ2LKTPtRyl9TL7TY9hlfOs/0Ml3vBQNyNIqoo?=
 =?us-ascii?Q?0gdnAxauezh6FsSSdHjY6aUJ9Hmbr/QlowJ1wAo4UA4QB8v6ACsREQMEl+LU?=
 =?us-ascii?Q?rDIV5dRp5uhX5DJ6tU+VOZXGqYsD+FPHa+eaeWqIqra99yBJvZ440t55T99L?=
 =?us-ascii?Q?E6BQntSakSP45U6fj7hV1nSQlCVWNdPBMVPYGXQdYX4+OofHkf7o/psRzwG2?=
 =?us-ascii?Q?tDGmaK2qgw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8ddb35-f8e1-450f-420d-08dec4fd3a2d
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 01:28:21.8087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjKuGUtIbAKjh8Y3XHSLg7rFh5TS/WV6DpFrI+n02h6PK/gxOH+M+WwZrAOyrkTrRiBBVakGq6zUyrIAHjwF3vONI51xxGW/QL8s/GOOLnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5807
X-Mailman-Approved-At: Mon, 08 Jun 2026 09:45:15 +0200
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

Enable MTD command support for the N5X platform.
- Enable CONFIG_CMD_MTD to allow MTD operations from the U-Boot shell

This option aligns N5X configuration with other SoCFPGA platforms
that use the same MTD framework.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---

Changes in v3:
- Drop CONFIG_SPL_ALTERA_SDRAM: auto-selected by Kconfig for N5X, no
  explicit defconfig entry needed
- Fix CONFIG_CMD_MTD position: correctly placed between CONFIG_CMD_MMC
  and CONFIG_CMD_SPI per canonical savedefconfig ordering (was
  misplaced after CONFIG_CMD_WDT in v2)
- Rename commit from "enable CMD_MTD and SPL SDRAM support" to
  "enable CMD_MTD" to reflect actual change

 configs/socfpga_n5x_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index 97c90656e7d..9159fa0c859 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -52,6 +52,7 @@ CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
-- 
2.43.7


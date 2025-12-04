Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F7DD1CDD0
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 04:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F27A38403D;
	Thu,  4 Dec 2025 05:15:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="nwqezePu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ACDF83FE6; Thu,  4 Dec 2025 05:15:15 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4041F84051
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 05:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anbuFLnzRSgbzOdTkBknbF7pK/B03yZAxgQ+2lP/uDTM8RW9kubkHFksx9StFW5z7aSTlnmnU2cRnq+3eWMpz0gMFehNTb9NUl9GAwVwBu0bYc1a6/sz44pHvx95Puf5t1DZTzygsAIWrBAIcz8XCVqckFRuyktWTc9ohYNifa5FNZqG8hCSR2tVYvSBGLtzQmnt2/rccj4S+DzlDdpIzQIAxW3/qwsN8pTWzHKtzeipdZ1Tw/QJlSUxagKLdsMkGzE3m2X5Zg5nSUsTTJ3RoIQwWNx/ga9iRRkdFgRTBQl4hnqDLbmtPqyiC5pbgzSmT0zQ+U5gy5IMsMmO65udaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6MM2DdJnC7NLlI6GoCM7YbN6kMMZMRjZOaZ3nzflXU=;
 b=iuDE54EC/GfB52tHSnn2znLGFyV4QXzWgfPYjSUZAZi+mRXRtGqeSvNTk/3n+vL6/CuawK+gv9XW9hIB90YmuB4EkGhaHtUcEH45om9UlEfYT3McHZCzQuw8cVao7Xp+OJI/XALUrMCHReWkm6k3+WEu2KINuJNZL/m0dj8O7K7z1GlTp9fg9oQkgTY1pC1xpVLzFdR3VHySosRbdRtTHeaGrshZbwSudEln+CHJ6yKfTmUKHa4YQNerHKSLp4NWpxzzPOtok9DTKvZV+rasOkaXphLcx1+gKMpxn2ijuqNssRo/sbougxZPcSiwrrUCgigbDxWzd+5DJA4OWQnzSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6MM2DdJnC7NLlI6GoCM7YbN6kMMZMRjZOaZ3nzflXU=;
 b=nwqezePu3ykLMWSldtHzpoDh1GJ74soFuCkpghCN22763md7ITLOfFxek4ivQFn9YZNYst/AfJvxQrZvD8sEJSu/l3vH8Q63vKbZ3pLoob55Sn717syhiLfEdnD5Ny9OZYctXVoS6M2DkGBBuDeNEiqNwkoyEYPgUzjMUlGEu0wpgiKS+uwZwQrTdcxHP/QAOa9BBHQ//m6uk89drD98G2NOxmoapLzPMbo/sMZUQ5m6OqQ7/lY3CWxD6FiYOqZaQXdC6Sz8/mjj+8hyAAyNsw6gBz1wIurH+UaazkBPY9cdmCcRmb6Q34msIZwkBPofCPmKZPEieJHaGvjhe07iyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB11134.eurprd08.prod.outlook.com (2603:10a6:800:250::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Thu, 4 Dec
 2025 04:15:10 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 04:15:10 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <ziyao@disroot.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Markus Gothe <markus.gothe@genexis.eu>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 19/19] airoha: enable DM_MDIO and MDIO CMD by default
Date: Thu,  4 Dec 2025 07:14:33 +0300
Message-ID: <20251204041433.3459826-20-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB11134:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af37929-9c56-4f44-d36e-08de32ebb70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XJaZ8iiNkOyN7os2/k/fR/tso9E67J7KahdYeUMoIqfHzTQX+s+CcsioULf7?=
 =?us-ascii?Q?VMzHD3lOjNZ4M3rrCuXQ8p4mTcG5tf34NWEPmc95quJN/1GO0227kDrbHicC?=
 =?us-ascii?Q?f1+j5LSYJqpJyQmknFNHM21Rz3stzSy2ukE0juI+sifn5NJjahsDCY9fYIQD?=
 =?us-ascii?Q?5g/Kemrv7hK2TdL+rRtFitp5qUMJ2KRfrpWyJO8O75Iyagj2aQDlOH3Ugb6Z?=
 =?us-ascii?Q?ulEBbFXwZoi7XCDJjtUkwGEZW3kf0an/Oco70aVguVOvCqdxJCZ+PXgurDt8?=
 =?us-ascii?Q?V8cdljA7dWhp6GrHhgVOltZ71UxCxRKztYhJNitviG6XmdU2g+FAwg8f9CBu?=
 =?us-ascii?Q?5BnRWYe4oWC+KxHS7JBp0DEIjiMr+IYeZ4JodjjWmHqPmVG6bIbWuR1IwOrU?=
 =?us-ascii?Q?FvDHBtWVKsTHWfAxHopdcbf8VUJfeOtJ4VM5LOQ8Y6Sn57Hd+gxybFI2/YV7?=
 =?us-ascii?Q?XvbsZzsTqGgHC2TOf6C7ysuNXbT/Qovzn83Nb/CnaocZjALBEZBVupMuY9E4?=
 =?us-ascii?Q?IY1o89f5yPi+IbZiHE/x95Mc4QEIMI90QTXCCVVrdZJ8+UDfkJ4PqQbwZ8y4?=
 =?us-ascii?Q?/J25+2AC6WZ3XKbNTZKU0cm0TaLUnmP6FaVwvA/pAczlAZ1yIHdpx65xAFgM?=
 =?us-ascii?Q?fv0nCtabbmowWsmP6uM4si5mEKjuRj14oZdKPtgF1y9OIDy1pIjB+1Axcti6?=
 =?us-ascii?Q?uh7Zyv/bW5k6QyPHNTCoAiBuldvGAFftM1fC+ygBP4jm7eOwAcrYxLVnHgFu?=
 =?us-ascii?Q?u79dio3eIifgX7omxVL1PFbgzWbX+Al5miPiy+FVOs1GjNN8Vzr5JgN7tkDb?=
 =?us-ascii?Q?rgHS8hMFRwQEo0fIwl0Vt62+MMOgQiRiP79EKScRbsxqc2vSwm9k/So+QllC?=
 =?us-ascii?Q?R2/mQBCoOnDSzSHHSoVWHYo66kSK00v20z7LjbzBc5jmjwKHrqsiuzhCLjMe?=
 =?us-ascii?Q?CO9DoXS6HZeeI54/BxJReGPhAAFXp/7VRZyrWRuY5XNEkPG549pmzWa+HbNZ?=
 =?us-ascii?Q?IScW4iHqoKY5JWuygPeud6cH9jkIp2EpgixIkkqkNVPlFEXomvLVU2QJ7biH?=
 =?us-ascii?Q?xDwDfu4HutPMFOks9smTl/NnOcoa1JQcBz9mU8ftpbxSJ+oDw9V+Y5QflZOe?=
 =?us-ascii?Q?nN1x7t1jIFq4xEXv0lb0pJL2U4tF+lZhfqIScCg0OLtdpcxZMeNDAix+YRi1?=
 =?us-ascii?Q?gopYoPnB/cJ8tPPzc5blPHDtT62lv23ttt59NPHOqnufPHc3O1WLyqZda50h?=
 =?us-ascii?Q?klunYxeySwQRxZj/KTozygS209GqeJfsEwibSZQ/GLL4bfVEwo9RM61hU5BQ?=
 =?us-ascii?Q?mteP7ZTzjAFZDuy0Lb9XH3D5p1zkp3LNohnBov6IfuY+RyGZjsoVwYiDEWwM?=
 =?us-ascii?Q?9fnC+/EPoLcv0Yy7bSsqWIFI7iJzgA9qKMhibBMKkwpwaCVLlRz1GuiVSV1k?=
 =?us-ascii?Q?Qn0egKMWpQatn83FqLDqd36K+ep6hR+Qhf+ufdUmqbkCwrDb4vgkE6bwJFRG?=
 =?us-ascii?Q?vvFu7oaJeSpmW/XZ8kQn6mYw0Ou1CHpZgvQcfdPVmB7XSRSUMlvNU4H2pQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7E1qfPtyxs/rdqXSUd5plbRrzM2ueUhdSsFWjmIkRPFnS8n1NHdxx/pE4F/E?=
 =?us-ascii?Q?DoWNeiMZFnVLt/I3zo46RtAavewvskLklECSXkoLpbHlF+0kK5L5JiamKuNv?=
 =?us-ascii?Q?2xL+/eFX8nYp8q7HrsO3YwJ3ac64A6TM6kzKO6PYmXZtI4qL/SP4S2Em3gLj?=
 =?us-ascii?Q?+IzxKjzMVKiTjW7gE5Q1+b3xpGAF3OFP3Uzse9Z9adIPrkI7EXpXTl4Z77iB?=
 =?us-ascii?Q?1v11nFfSwoA7SyCeXDrhmXtZ0eocOoZXZMcsijp6uifhXvhEnbdetnfjlwxk?=
 =?us-ascii?Q?jykmfn3jkZoPXIBZbnf7ckMDJYRu8+KlI/+TbA7TBGaqY54ddXtqySK8YiMn?=
 =?us-ascii?Q?hdsfzt7mDi87eKH3SWVR2H0eJU8JdBDNUFUmP7YuukTYhvAVGq6tjUwV9DOi?=
 =?us-ascii?Q?+p+2dWlA3vo295NQy4Qucy2OJRowcByiTPaXEzNOoeXpu7ho04gDNVgo/zfQ?=
 =?us-ascii?Q?g/BFYZnzuatBg8PDuCl/vSDedVhensojyMwpqtiB+jn7pbO7IKIFI08qaVMO?=
 =?us-ascii?Q?otzPnU5WlMzBkWgV3JGleFD80n6KwnilOGnNH7cfYt5mh9+PRgEHdG+uM+TO?=
 =?us-ascii?Q?ySIElKXCpiQUOd8KdqwsSUhqvSIO6ly+40IJegOBC5sqV9vOCK4BbSEpJMiX?=
 =?us-ascii?Q?GdL3srKvAl555WSAJGSNVkAx0Q3oKVz1j7PNQae9PQ77PxCN4xa9ndxHEN2w?=
 =?us-ascii?Q?FdV3AvKQNNM2o3ucd2oJ33QWF6FTN6J36XtONWJw+nRLck4M7+AyRuL/301C?=
 =?us-ascii?Q?b9ivaNfhsRzL4GhctbUV1Eb/CczaEp5jnLAZu5vCpZQsA6/xvnaq8Z+Bz0tQ?=
 =?us-ascii?Q?ROjq4sGlUy7srj961ah87GyVIpDhOjOqYapOT1LesCOMpJ8pVHs5bybtYgYR?=
 =?us-ascii?Q?p8Wmkcd+UZGdBDkzh9vRQc/GGEqNxUZIweYaTbAn+LoeXgpNji81/+cV5Ohh?=
 =?us-ascii?Q?L0+h88X3q/6NoeMCoGDHZvb/WBCBnlW+7mfZDFWuyQZrlE7raXavLu1QJrWf?=
 =?us-ascii?Q?t29ViiUZHsMzkPUcWdavY881Vg3heSqa4hvrGETbUNeGhvsHzDQOaRIKTIQ1?=
 =?us-ascii?Q?QUAtNz5de3mLHk/5HAhDwmpBcoCqw1stNE9jf94gaebpbT2T5g71doBOtjzM?=
 =?us-ascii?Q?jLYUzw/BqIPR1Wn8IBHO7CTl/ujd5lYvODSoJlU+2sWdfTOxdsZfMadE3xxh?=
 =?us-ascii?Q?h1gAxueua0jo+r5csAz/EJGp6ImU5u1WesS8bX/7xNHxEnf7DASdWjmv4UKZ?=
 =?us-ascii?Q?mohJSxo1GCjFYfX/xVK6kElrJ/YPSvwQnaWRdIggpu5UtG3UbGDu036MX17g?=
 =?us-ascii?Q?xft0ayL4pEciQ8/+6gKpT73BJV3edkULur6tgsiR8hf5k+FpXSBQtB8eVP/t?=
 =?us-ascii?Q?vKbg3IbNdcMxaSPoj1jIzt7PvzJE5yojF8sUCqtQoDT8xb2HgNiVsxyAzFBg?=
 =?us-ascii?Q?5dTE7J9NQ8VVX3DWpSUYNHhb6SrkPkVe1Ohst0pYs1TJ/yB/yFFT87J6OEGC?=
 =?us-ascii?Q?FrvXc/AZ4QZv1IFDdM73svNxeAhld0mOb2Xf/tPRTt6Y2gJEoPMojeNNnLzi?=
 =?us-ascii?Q?+Rw8RZaCdtPNRMbbWHAOJNwFM/eJhfHoZv6/F0bxb4FxsX07Mr+6SHtTB756?=
 =?us-ascii?Q?uhe2g1k5N5j0+8aAEVZ9o7Y=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af37929-9c56-4f44-d36e-08de32ebb70e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 04:15:10.5203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRN/zYpMw6web9vbCg9fvtD5UskvEt2GasXkHhC1bfGfJeMNC64LARJShmsNIlUWwsNx64FEjWeyxo7jolII5o8Ohemzwll5kPGg0DVdcjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11134
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

From: Christian Marangi <ansuelsmth@gmail.com>

Enable DM_MDIO and MDIO CMD in the default config.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 configs/an7581_evb_defconfig | 3 +++
 configs/en7523_evb_defconfig | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index 37786ace2b4..606689c829d 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -67,6 +67,9 @@ CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PCS_AIROHA_AN7581=y
+CONFIG_DM_MDIO=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_MDIO=y
 CONFIG_PHYLIB=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
diff --git a/configs/en7523_evb_defconfig b/configs/en7523_evb_defconfig
index 113ddb46a7f..ebd99d133c9 100644
--- a/configs/en7523_evb_defconfig
+++ b/configs/en7523_evb_defconfig
@@ -51,6 +51,9 @@ CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_SPI_NAND=y
 CONFIG_AIROHA_ETH=y
+CONFIG_DM_MDIO=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_MDIO=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
-- 
2.51.0


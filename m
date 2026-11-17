Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6329606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 01:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CM5lvxa1;
	dkim=pass (2048-bit key, unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=1OUFTWhb
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59B57605E6;
	Wed, 18 Nov 2026 01:25:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bi0WfvO4Qjjx; Wed, 18 Nov 2026 01:25:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4D96860735
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794965152;
	b=nTINNN183VSLcNd8tZ8eyGxmuH7q9mnsdVDbJH10p4eBUbno7aaLk8m/8dZQzS5Md8L6
	 c3pHqSZmfpTGGWaGqaY+lXIBsAXlVZGLmh/pVQE654p1Wewbn21FUP36tR4CCno82pix4
	 AMEkSHcuUg2ms6YzUmCJw7nHpeiQ1uUc+Vqn7LJ94SxzCAqQWZCOALD0NoqnPe6gB4oUa
	 jpl7odHs8XT3/dLeRVoYKbiJvptMLwBTu4lgg+aL6AlSqqaMPLwvP++/WOVQXvCDRp9Op
	 Y4RPwRVA1WT0jue7Pen69jXaNaD3s6hisYYwPh6LJRo2sN+i+knJB34VbdOMV72Q1mA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794965152;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5uLsvspSBjlFadwHmubOqsHczSic7cv84RCCMkzPytQ=;
	b=E/X++1JDVuai15LQpY6SIMjYtfWu4g7qSPT0kdAnUEzF0cT1DitpMa5EC87/XDoyA0xl
	 1RpJi4F0q6N5091pKUb3bsguhJEJMHK0zBvHDGYoje+LBBxZuTtZFrvqWNP5bSy/O2TSr
	 Sl83HvRTqe0BJ0xd4KqOKBZrR5+LegPpFUo7Gv2y0hweOuA8K5GbgP+/sTGptxOJHq1Aj
	 Wb+IpMbSs/mIkC8iSwN12UxfW0yjRQSCv2XZlDAYdTbFqTTlTWowtx3CLyuDmOJc+uIvs
	 o3S+gEO8/rZ+PL84lltevCNHDTtZGByuAc1wR7AXhG+jojn/xV4nOecg9VnrzdKBBTQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794965152;
	bh=5uLsvspSBjlFadwHmubOqsHczSic7cv84RCCMkzPytQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CM5lvxa17nDfT7hBhlWTnLzj/dlulcVbAF4GBlvBg26Gend+jdKRujaQ17CNoEMwo
	 jhlxnr/m03qbs90pSvnsnv8ayigP9lEZ5tgI0bfTrHT3Jad68Hy5KOrWP5Fb25u+gC
	 R7XYiUwNFokHkJbd4rqacaZ+0/tQr1j4J8Eqeb8noN7UlNkGL+UHrHKQ5ikyzoUPaQ
	 iMNQsjVEb68ZLUiIgUkV8biH3wKAzoMJIjNhoa+znFIwKi/c1U7mRhXsyeDJnZBwD4
	 LM9HWyL7LR0XSZQiMRHsvFCS0/mg0IBrLvEtnLTEzh/MT0q21cLHL67PQ+5Woug1np
	 YlL56VuKkWJzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D96860735;
	Wed, 18 Nov 2026 01:25:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A31A105
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:05:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B51080F67
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:05:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2gc5c0aibMui for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 22:05:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D107980E7D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=1OUFTWhb
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D107980E7D
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uLsvspSBjlFadwHmubOqsHczSic7cv84RCCMkzPytQ=;
 b=1OUFTWhbB4jZfw4RWFksR8HhRmqPvNLyCdKZDEu6CHRE6AmxwP4GUOymWqEWYKT76BP/yUtcInv0W9P13755OZZPvdGF4oE+yTadTJTvuNZmF7YB2WEjbO0CDhkQG/RBAJ7R1FjttVZFp3Cb2fJ9hLUhwULFSFG6pqRmKtOQjcnaVYpD6pGedQwOv4vVzIBPO9f3O9tb3+PyMcCxf+YU9HQ2UKkQD3+O2BG2lRWXwDsORNEClXNzXLN3T40GCfP1gnatfTSNJ2DT33H9JDiwIhNAO3xUCjoS9B6Rn1w3pbDVHZJ1h5I9wjxV6yMQC2UV14XYbYWLq3yYRFkGE5EScA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB8750.eurprd08.prod.outlook.com (2603:10a6:150:c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 22:05:05 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:05:05 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Daniel Golle <daniel@makrotopia.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Aleksei Sviridkin <f@lex.la>,
 Zunyi Hu <roberhu001@163.com>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Mark Brown <broonie@kernel.org>,
 Yuho Choi <oss.patchbox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Peng Fan <peng.fan@nxp.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Akshay Belsare <akshay.belsare@amd.com>,
 Cooper Huang <cooper_huang@aspeedtech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Cole Munz <Munzzyy1@proton.me>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 1/6] spi: spi-mem: add spi-mem caps support
Date: Wed, 18 Nov 2026 01:04:44 +0300
Message-ID: <20261117220449.3134408-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117220449.3134408-1-mikhail.kshevetskiy@iopsys.eu>
References: <20261117220449.3134408-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee1df9f-7892-47c3-5ccb-08df44f6d5eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|23010399003|38350700014|921020|260925022911599003|11063799006|260925021311599003|260925021911599003|56012099006|261028144727099003|261022075727099003|261021123027099003|5023799004|261022105027099003|261021121427099003|261102123227099003|261026140227099003|10067099003|261026121527099003|261102130727099003|261009223027099003|261009221727099003|261009223327099003|261009221227099003|261009220027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: JVl/a1/Yv+/zyRMqe3zAr1JWhb8LxQ4JUZUpr2lMg8H3yf2NeHWSq+HgnTT8/VLoz+1loPf0CN2LaKTuqB2YqkSUpETvloBW1vcvrVtaY1E6nh31iaCHLg9slmBQFpRJkEnZyUUPU8bTGFQ6qI99OcgeBodSwXx6P56+bDqCpZ3QiHryS0gXxuqL6FNXQhn49466OehboSgK5metSKE8rwQHHXda6UhVXnSO6P2KZtLbnhxCqH3eldo1lr1FDydAI6/0qhTXyu5Uo3tuMK9abw9ReM4zWjpO9XmiZl8642ISi/yd7itKl4sOjlkUOgAyIH3lRmyA29e5dFZkjqFTRjEdMOcIGevrDcyHkEnSNVib8HZkfjxa62ls7Uk/92XaLntHkjku9A5WVGq1k6YjkiPgc9Ftl7WBMtKrnvtX1eXCqPQnnkUwTUr8PF0MF/PwTtVMkTn+6QuFX01IXgQIkneQhTGPPoDAk+pj3e/mWjJWUjMDAv2cnMAt0Lr/v3UM1nrPC1Hxf9nDmQqgu8H4q+HlDdHclIK/nURV4/8wv5U7vMIxl6Ex9boQxC4/wEA94q6C9VnWuk/WPNIK2+grD8AzJPTCSWWiZHnnesJDypEvf9NYAzC4fuoKMpMm1PksLZVCQhhLeOS9/tvFVJY8ElYhKPZB4WmnYWfFEaIWC8+TlFjk5//DB0HCQ83pzeMmx4wfwZ6sVxsr5vTo6EZz7Xvm+cIsZFTSF3hOH8dxC54=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(23010399003)(38350700014)(921020)(260925022911599003)(11063799006)(260925021311599003)(260925021911599003)(56012099006)(261028144727099003)(261022075727099003)(261021123027099003)(5023799004)(261022105027099003)(261021121427099003)(261102123227099003)(261026140227099003)(10067099003)(261026121527099003)(261102130727099003)(261009223027099003)(261009221727099003)(261009223327099003)(261009221227099003)(261009220027099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7J5xd8diANp73FJAFuSmhx/xe20NfrHvcW2fbXkOIT4A42QWQU0Lbrx+yC/S?=
 =?us-ascii?Q?XNxxiVvAGjiBkAU8SvZ510Olj/U6zMzko3uXOeMhWY0eCojhbzCohK7UUA71?=
 =?us-ascii?Q?PbL3I1SWjYjfmzmbvdgsQcZpHgsgpny2nYRPCvq7/oI/E3pWBvFsFT50JldI?=
 =?us-ascii?Q?fEmQljZP6HUEd2xNpy+q+y2mnLRH1+4Hl2K++l7bPoxnvDfVNLgAlkD8v780?=
 =?us-ascii?Q?v7bGUsuVt2r2UpEZIFeOvWXNBvq/KKcdm6Bcrjnh7n247c4E1NYYwMpC1nOR?=
 =?us-ascii?Q?wY+eZh+vyNh1OibcsiLtA9HdbTreCBkg583kIcPO9L6SX199+N5TvqJNMy6o?=
 =?us-ascii?Q?N6HFjwdTN00DKVwFYv0q4nq2gagEyQSZo4iqSO0fliAtYraUfzvXcdSqCgKi?=
 =?us-ascii?Q?c+VaDGRaCs8Fbhoj612Zla3M9+ZY73HSEJNO8V/ZDEA4UhoT/jaWiD9idxtY?=
 =?us-ascii?Q?P7qhqaBgsJW4GAMwyDBM4MSNSrdJqofSLwTFflWaih0hFRACpU9ZucdE1FwM?=
 =?us-ascii?Q?lCn1BF7vq/BGpnLrzuiewYH9vCcStuZIlYSASBnqAprOYBt6x6WelZuZFaCG?=
 =?us-ascii?Q?a/+wh/LZKdu39RYGgh6pWOo3sCdpvS3SO2SiQFajl/CPl3NtPGKxBkAhEULN?=
 =?us-ascii?Q?/mpVM9VOskSU/GOEamwyekRLe9eTwMjg/Z2AAgS2ppwbfitTjEiNvWmPKobY?=
 =?us-ascii?Q?PEA+t7o/kbbQ1hicgGKyvKiC4AB0nTNXo128AsUP43sbzvWD8yfQsIt2+On/?=
 =?us-ascii?Q?toYNK+8Fnr3/ZcP6rH5kjJCQhJKfignmDFeP05cWxXMfV3PDD4GAmazCQ0wL?=
 =?us-ascii?Q?nOpCTw8tGJtIsQzymZo4lRO4hIUsgwluh+XSej160r0JxKFtSPWiuIOD6wOn?=
 =?us-ascii?Q?o4N/d2J6YOjxX8LuCqbBive/DFyQ/vTwU7BK/b9FCAx/eN/4Dc8GcjP3sYUi?=
 =?us-ascii?Q?lRIBjVD4CpD+rg7H7djeR7jdJaX1BJy5HH/5K69AGpFNxXV/VOUsy9CqHglk?=
 =?us-ascii?Q?iEECkg6+0DEErMcNi99ESHqJ5wFTPmaVh+6RRWDKbkTofB6op0ENYwotGNnT?=
 =?us-ascii?Q?RTy0FFdWhctUI9gYYW/PWY0B5HBGES+zBgKr/E6fjTfuBfMJUpMbA73gskdn?=
 =?us-ascii?Q?7Y8f8bpN2viLLbIL1pzxVI3GlYsTKE13Ct7gwfnL9S/X5/cIel6bFgDebWpf?=
 =?us-ascii?Q?PTWYY7nXAElHEYD4gWQjrlQpzUpm6TM8RpKVIfvsdMA2kEHi1HG1RBrvDCbS?=
 =?us-ascii?Q?vtWbPknotsI12BVQPDbk4CoMULyPJITuY2UfXwFsb68imDQ4oTJNpIDyoJlD?=
 =?us-ascii?Q?8jQrauYiJdxp9Ix8PQrW3uNWzkK0GeL/Pv1xYEopYsTDkRHoF7j5wDi9deV1?=
 =?us-ascii?Q?qE1iYGrW9n8UczgT/VkmOzjNe/chtJsUIAqmhisnSAAcb+YtD5DHHwhnljsN?=
 =?us-ascii?Q?4vRnzLKZqOPOKfp6eiZiu+Yq5HMB/Qy0SShbk/PI7Y4RQ12vz5a3n4xL5r6V?=
 =?us-ascii?Q?227q0ngPNidjf+iP3BfDU+OveNjUKOnI+rvD/4v+0sFsilFqKeW3wf/Cfnlr?=
 =?us-ascii?Q?LoEWBLydU3iEK9K695i3TMsGKGzMWOy9YzHR81J7tTLy0+l//1uUdMQZGIz4?=
 =?us-ascii?Q?kSa6yISUjAMTX6pauofRqHcsIdu2EYR7L90XB/smIZODDR+J65C9uVUiVANC?=
 =?us-ascii?Q?ylNbD+9M72QkZcXD1wBIqRsiH1y+vBz2fHKY2Ssj8ze6mPcZl6nynxhBAhHj?=
 =?us-ascii?Q?LV43odM+6g3Zw4EniEkI6KVHsqCEgE4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee1df9f-7892-47c3-5ccb-08df44f6d5eb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:05:05.3622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZY0W6tk2bWztbL2recz6xqMx338Zn7yo+WrXlh6FSKWMLCe5hV9RcQvztbf3t0CLfFPhwEg/8rb93g90HXX8Ez+A8wN3Np3WhjRtrPRVu3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8750
X-Mailman-Approved-At: Wed, 18 Nov 2026 01:25:48 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This makes code more generic. Also it allows check for DTR support
and emit DTR operations only if it supported by the spi controller.

This is necessary for spinand DTR support.

The patch based on following linux commits:
 * 4a3cc7fb6e63bcfd ("spi: spi-mem: Introduce a capability structure")
 * cb7e96ee81edaa48 ("spi: spi-mem: Check the controller extra capabilities")
 * 9a15efc5d5e6b5be ("spi: spi-mem: Kill the spi_mem_dtr_supports_op() helper")
 * a433c2cbd75ab76f ("spi: spi-mem: Add an ecc parameter to the spi_mem_op structure")
 * 030ace430afcf847 ("spi: spi-mem: Allow specifying the byte order in Octal DTR mode")
 * 8618271887ca10ac ("spi: spi-mem: Limit octal DTR constraints to octal DTR situations")
 * a9be454927de3b6d ("spi: cadence-quadspi: Provide a capability structure")
 * 29c8c00d9f9db5fb ("spi: add driver for NXP XSPI controller")

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/cadence_qspi.c | 10 ++++---
 drivers/spi/nxp_xspi.c     | 12 ++++----
 drivers/spi/spi-mem.c      | 61 +++++++++++++++++++++-----------------
 include/spi-mem.h          | 19 ++++++++++--
 include/spi.h              |  1 +
 5 files changed, 63 insertions(+), 40 deletions(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index bb8e7004a34..c3be4b1edb2 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -400,10 +400,7 @@ static bool cadence_spi_mem_supports_op(struct spi_slave *slave,
 	if (!(all_true || all_false))
 		return false;
 
-	if (all_true)
-		return spi_mem_dtr_supports_op(slave, op);
-	else
-		return spi_mem_default_supports_op(slave, op);
+	return spi_mem_default_supports_op(slave, op);
 }
 
 static int cadence_spi_of_to_plat(struct udevice *bus)
@@ -472,10 +469,15 @@ static const struct spi_controller_mem_ops cadence_spi_mem_ops = {
 	.supports_op = cadence_spi_mem_supports_op,
 };
 
+static const struct spi_controller_mem_caps cadence_spi_mem_caps = {
+	.dtr = true,
+};
+
 static const struct dm_spi_ops cadence_spi_ops = {
 	.set_speed	= cadence_spi_set_speed,
 	.set_mode	= cadence_spi_set_mode,
 	.mem_ops	= &cadence_spi_mem_ops,
+	.mem_caps	= &cadence_spi_mem_caps,
 	/*
 	 * cs_info is not needed, since we require all chip selects to be
 	 * in the device tree explicitly
diff --git a/drivers/spi/nxp_xspi.c b/drivers/spi/nxp_xspi.c
index 7ba3f00e506..9c70a4a19c1 100644
--- a/drivers/spi/nxp_xspi.c
+++ b/drivers/spi/nxp_xspi.c
@@ -326,10 +326,7 @@ static bool nxp_xspi_supports_op(struct spi_slave *slave,
 	    op->data.nbytes > x->devtype_data->txfifo)
 		return false;
 
-	if (op->cmd.dtr)
-		return spi_mem_dtr_supports_op(slave, op);
-	else
-		return spi_mem_default_supports_op(slave, op);
+	return spi_mem_default_supports_op(slave, op);
 }
 
 static int xspi_update_lut(struct nxp_xspi *x, u32 seq_index, const u32 *lut_base, u32 num_of_seq)
@@ -700,11 +697,16 @@ static const struct spi_controller_mem_ops nxp_xspi_mem_ops = {
 	.exec_op = nxp_xspi_exec_op,
 };
 
+static const struct spi_controller_mem_caps nxp_xspi_mem_caps = {
+	.dtr = true,
+};
+
 static const struct dm_spi_ops nxp_xspi_ops = {
 	.claim_bus	= nxp_xspi_claim_bus,
 	.set_speed	= nxp_xspi_set_speed,
 	.set_mode	= nxp_xspi_set_mode,
-	.mem_ops        = &nxp_xspi_mem_ops,
+	.mem_ops	= &nxp_xspi_mem_ops,
+	.mem_caps	= &nxp_xspi_mem_caps,
 };
 
 static int nxp_xspi_of_to_plat(struct udevice *bus)
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 3fd2353af94..1c23f3d8843 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -171,38 +171,43 @@ static bool spi_mem_check_buswidth(struct spi_slave *slave,
 	return true;
 }
 
-bool spi_mem_dtr_supports_op(struct spi_slave *slave,
-			     const struct spi_mem_op *op)
-{
-	if (op->cmd.buswidth == 8 && op->cmd.nbytes % 2)
-		return false;
-
-	if (op->addr.nbytes && op->addr.buswidth == 8 && op->addr.nbytes % 2)
-		return false;
-
-	if (op->dummy.nbytes && op->dummy.buswidth == 8 && op->dummy.nbytes % 2)
-		return false;
-
-	/*
-	 * Transactions of odd length do not make sense for 8D-8D-8D mode
-	 * because a byte is transferred in just half a cycle.
-	 */
-	if (op->data.dir != SPI_MEM_NO_DATA && op->data.dir != SPI_MEM_DATA_IN &&
-	    op->data.buswidth == 8 && op->data.nbytes % 2)
-		return false;
-
-	return spi_mem_check_buswidth(slave, op);
-}
-EXPORT_SYMBOL_GPL(spi_mem_dtr_supports_op);
-
 bool spi_mem_default_supports_op(struct spi_slave *slave,
 				 const struct spi_mem_op *op)
 {
-	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
-		return false;
+	struct udevice *bus = slave->dev->parent;
+	struct dm_spi_ops *ops = spi_get_ops(bus);
+	bool op_is_dtr =
+		op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr;
+
+	if (op_is_dtr) {
+		if (!spi_mem_controller_is_capable(ops, dtr))
+			return false;
+
+		if (op->data.swap16 && !spi_mem_controller_is_capable(ops, swap16))
+			return false;
+
+		/* Extra 8D-8D-8D limitations */
+		if (op->cmd.dtr && op->cmd.buswidth == 8) {
+			if (op->cmd.nbytes != 2)
+				return false;
+
+			if ((op->addr.nbytes % 2) ||
+			    (op->dummy.nbytes % 2) ||
+			    (op->data.nbytes % 2)) {
+				dev_err(bus,
+					"Even byte numbers not allowed in octal DTR operations\n");
+				return false;
+			}
+		}
+	} else {
+		if (op->cmd.nbytes != 1)
+			return false;
+	}
 
-	if (op->cmd.nbytes != 1)
-		return false;
+	if (op->data.ecc) {
+		if (!spi_mem_controller_is_capable(ops, ecc))
+			return false;
+	}
 
 	return spi_mem_check_buswidth(slave, op);
 }
diff --git a/include/spi-mem.h b/include/spi-mem.h
index 36281a62f77..8c20feebfca 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -331,6 +331,22 @@ struct spi_controller_mem_ops {
 				u64 offs, size_t len, const void *buf);
 };
 
+/**
+ * struct spi_controller_mem_caps - SPI memory controller capabilities
+ * @dtr: Supports DTR operations
+ * @ecc: Supports operations with error correction
+ * @swap16: Supports swapping bytes on a 16 bit boundary when configured in
+ *          Octal DTR
+ */
+struct spi_controller_mem_caps {
+	bool dtr;
+	bool ecc;
+	bool swap16;
+};
+
+#define spi_mem_controller_is_capable(spi_ops, cap)	\
+	((spi_ops)->mem_caps && (spi_ops)->mem_caps->cap)
+
 #ifndef __UBOOT__
 /**
  * struct spi_mem_driver - SPI memory driver
@@ -395,9 +411,6 @@ int spi_mem_adjust_op_size(struct spi_slave *slave, struct spi_mem_op *op);
 u64 spi_mem_calc_op_duration(struct spi_mem_op *op);
 
 bool spi_mem_supports_op(struct spi_slave *slave, const struct spi_mem_op *op);
-bool spi_mem_dtr_supports_op(struct spi_slave *slave,
-			     const struct spi_mem_op *op);
-
 bool spi_mem_default_supports_op(struct spi_slave *slave,
 				 const struct spi_mem_op *op);
 
diff --git a/include/spi.h b/include/spi.h
index f477763bdc6..6697d09e9e3 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -494,6 +494,7 @@ struct dm_spi_ops {
 	 * has native support for memory like operations.
 	 */
 	const struct spi_controller_mem_ops *mem_ops;
+	const struct spi_controller_mem_caps *mem_caps;
 
 	/**
 	 * Set transfer speed.
-- 
2.53.0


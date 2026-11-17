Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350CD606A32A
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MK+mzQ/3;
	dkim=pass (2048-bit key, unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=xcTxa6hs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C4A34089A;
	Wed, 18 Nov 2026 01:26:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yhiLzbo9jHMe; Wed, 18 Nov 2026 01:26:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6688B40895
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794965165;
	b=sib4ZDhabSSKekSYhczfijhwBBUHR1zWwcY/bKnzoNj30+WholmWYqKKY3/NuRSqDkQ8
	 eDBlFZWcDjx9Lm3rU3QxNPIGDjaxFrspQJzIiq9NTrSz0nTv/1uch5yuXXx4ZGmDDNU6C
	 hR+mcm2Lk4a4SU7ExHO4ZOkE2EbY3c3EFEnkC6cB6Gc+vl+51NTxBw2lJBd0l7LKHBOUy
	 QQVWqW2OFYULm1Sa18Dn1+zVdPJCrZnkxSSHGqB2p8ybXU909ETZc3Lhol8YtEznjUByT
	 Kp2Zz6vuk7ja0NUujBIOMeChwFkwncSOKsa6R7raOmr7tqTeidrwazvw25Xs7XDf9lQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794965165;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=DJtqBP3pm/2mzhA7IAYzdaJKMpDSAT2uDMO3D72JrkE=;
	b=IqoMx8fzgLu6GbiF1V1ZicdrDUxqkpzztYL6yjlCzW2+4KJHUt1eg9CcydRxgh9LGzn7
	 nDnoveY+DgbZBZGGD+SmedKtSvgTxl8zqt2fPB8d7zWg49lEorALFGQL7U9PT3/PLUO/K
	 uraYVFba7Mu19WLUFyr0wpxWNt3KS1dIU2lVD18PHJ5GmPq5TToE3fCQT3icI5/zIjCjr
	 mwdeFGptskjKNMNU0hju6Opy3puVl5U+/pRDsAN8wt/UStMC9UftOH7kqFwpYGSLXAheK
	 MeAAm7Y2DGL6LG90Q0jauGz/bs0m3nhWThvhzQLSXcaTfZtwtjtxm1/456kML7CjyDw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794965165;
	bh=DJtqBP3pm/2mzhA7IAYzdaJKMpDSAT2uDMO3D72JrkE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MK+mzQ/3qsZwVMI6j21a/YosNSb02efK+Y+Hcq6gqhNwrj5rZorST8rd3fsm3ezQn
	 3xQBfOnjKNZ1VxJ2HBFG0qK4afbHZeeku4R5hmkw3EoU/uoS8wnXCSkp+eWwJLbRvE
	 1d3gqbXyMTjiGVOKNyU67nOdNPfbmy0aJQ6nlLPLYvAiAv7AFHzc5fPKwFexiY0idz
	 1BMS/gDsXDUJjxDaRQkeu2biB4zihcRrWSbNT3WC3/XdmK1DzfFMu0/yCMju8NczcT
	 JWw5iU8zZbxuBuuvPs41foRGIlVmkYEIWtG2ViM4TaziQG4lHcNsYdRdXd8saNycIT
	 vlome6MbgttIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6688B40895;
	Wed, 18 Nov 2026 01:26:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E1DAD105
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:42:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D3A4060735
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:42:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NMpZkMySQMnf for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 22:42:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 39DE46067D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=xcTxa6hs
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 39DE46067D
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJtqBP3pm/2mzhA7IAYzdaJKMpDSAT2uDMO3D72JrkE=;
 b=xcTxa6hshwsXHQbYHOLmhei+ajmsd+gwkEw11lu4yCt6ZZrRYLMKfFgEwi/Vlc4WD8T8Pw6i85DuhMRArUKJVd0c8LcDloLkOqseYuS30m+8/Y1fA33RoIaNR9lxi8qQdhPOMMLJgrxqgUac1S5RylmGrVi9qLhfyZ6hkHBrRM2Zt2wkOLXed3maQB5yZYpxEsYOqv9RRZIuivQHV78jdmJWSL5EA0wtSuzeU0+Q28WlxSfQaGzTQMwnjAFuNjafRFE63FD8QDZAKk5n3Wt7iuABjFKPEXwMYayuup00SJfkuYbgxbK/E9w2qIxItfEVKntFi38bdpSFYC9eT9ORGg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS8PR08MB9291.eurprd08.prod.outlook.com (2603:10a6:20b:5a6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:42:48 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:42:48 +0000
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
Subject: [PATCH v3 0/6] mtd: spinand: sync with linux-7.3
Date: Wed, 18 Nov 2026 01:42:30 +0300
Message-ID: <20261117224236.3150882-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::9) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS8PR08MB9291:EE_
X-MS-Office365-Filtering-Correlation-Id: e565ff24-2f7b-4323-d898-08df44fc1a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|52116014|376014|7416014|921020|38350700014|10067099003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|261009221727099003|261009220027099003|261009223327099003|261009223027099003|261009221227099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: VTs7v9LymcBS6eT8tlFxdbu7RjVXQtYoNEO1gr4FX9gIkuXOUizYioP1zzF91cxOKRQ4PJFJa8API4udioav0rREst2Bo8oKJ/HUM+yb9SQebzsBG9TYZ6Dbiemt+KMTI/peJtioHEataWWLNG+DHYzpZAAwqxBMDczrta8pkmiawO5bgS1vEPIFcZEJadAi7gAUUqp93xFkuKmwWm8n1CK/nLQWyyHzEjXBfjFy0RxJ5rylGdw7yIuU6ur9DhOiECKRwxxzgjrX8Yw+ux/KmCJY34SCCUDK+aOXsORtKhmWWPl+SJXRayj7A47H9sfuyGIz0RMUiktG7KqZCJOSy95khy+ZNYUKBPjyD0/SFAYjTxfwhT2oVcJ8zTTikpJ7a/d6H6Y6rW5g2wMZELx/Grw2r56qJvA72P0uRxe15CEP4U0oV6zo8CUpNVMg3fYwzjcsS5vyg4XCU+tlfoYpg71Q5Yaa1jHJ2LcP/Wnr5YEUjDz5SCSoGXb6CP+ou7Mw6CkJ57JNEynOfeKKxr3+O7R1mMkUiFGFFFXaqZy1PsGFmVEUexhOTvv7oJTbfAX7P2NTSiI1g1jee0AlQTYKGNzgkHbuo/LJoFhQZPVRHNWDy0mABw76Rx4X7H1PNOFEeKvjhQv0AojxTFEVBYJFk7EhkOXo2QAFhVNyxRTP6Ntb6EQ4am4wKrCLitwJS/9hVzoVXKjLB9mIVrsBtx+o8tgRMAIPhROqQElP8cVMeMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014)(10067099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009221727099003)(261009220027099003)(261009223327099003)(261009223027099003)(261009221227099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T9RPvCFyTPKOqh899TGeGUCWp/1sYIY0nUaKcvEueGlLoDhHkJfr+QaHqYeo?=
 =?us-ascii?Q?YAze/RlVAV9quXC3zmDD20D8HcUSrvgtfkJeez8ik7AlvoZa9VCARhJ4D/F6?=
 =?us-ascii?Q?s4zP0ke7BOFTywo73GuFdGiaud7QknbxcCZ7KOWtskcGxqDeRrNptMyZQKka?=
 =?us-ascii?Q?d/IWmX0zRG8EED+KPqVv73FH3OKxXKA1rDYeQKY7OtAySsECrBKcacxzYuM5?=
 =?us-ascii?Q?XW0wJORaW+dNoyJrAateSdlBlcDSnQGTeUEJOaw74Mny60DKCbz5k6yPiyEJ?=
 =?us-ascii?Q?6xu5SlSZs79lWO/OTaP7Cf6PtW9P29mG239THakJFK1b9bvGjKVp957mJ67f?=
 =?us-ascii?Q?CYilwSwpZSS33InDXkI0Kv2C9QBQsdFTTUT8PyooV04tGF0IF5fpyyZexW2o?=
 =?us-ascii?Q?uOCF4BdZa6loyU0U9ZQOvw39Ia/DENakgVXCn8aB5vxhRYSQHPSODwkqWcFy?=
 =?us-ascii?Q?AkPFTexkPGxiXGOOb5I9G3CGHSeviWDo2Xs6O0ucaBvXqgn/Fi/r1g3+qBNJ?=
 =?us-ascii?Q?LLByxicf78T7lHRVdoG844K2WFBwz7XqIr8W8hnr0bNyhnUVzkb/yA+BYo60?=
 =?us-ascii?Q?N964zmERJNZ7J+dOlsAxVIFElYXHL78oCOCBPPlMFVck/FMZazfjaCQEtDUU?=
 =?us-ascii?Q?KwhhDkUM6HY7sMSF3XhHYuPHGqppYXmytzvT9/LxVTNHiJ2/w1rMsU152xse?=
 =?us-ascii?Q?GuYlAkCuAf/VoQs3a5HA46qriN1OGwOiCRctrD9mmsuCeG/NmO2/KWXL/0ii?=
 =?us-ascii?Q?5xA4Pv0tm5fafkNK93lLw3I4ntvyebrErDmpL4SB/jLB9IERNUbZNh71QO8a?=
 =?us-ascii?Q?cLQR6EcMB1CO71VjnYeuDJnG5CzkE35Dl200tDWByxBvuMbBfVzWdKsT2KgX?=
 =?us-ascii?Q?rZs7YYJ1rwVwXiniIQaUyJy2oNlejaTGRMHIJjXU0QDn+30Kl+zfvrmUOeDb?=
 =?us-ascii?Q?oWlv8U3Crr2NvJTzv/kjc9LT4x1+amFomIh09KsCwByCYn1IsB/7T0ureapT?=
 =?us-ascii?Q?eN02RifFrolRvPq0PCuzV8OfVQ4g7DHmgptJOHD3+FGOWOBhvqkOqKPHBx14?=
 =?us-ascii?Q?50hZmjFYG8mfw7BVhhOcWZ4G9GaqLz82/M24NlUMWVwCDMfwIbgrrEWYU8Au?=
 =?us-ascii?Q?IA5gcilHHP7e2dO0FLPJYCtNVndCC21ZTMLxdyy5SmxU/fmWmqbn77petPPn?=
 =?us-ascii?Q?kVKFixb6e0k3+yHZOgpMTevJI8WxDz+zCNYNwkvs4Vst6L5d0NNCwJgKXuVU?=
 =?us-ascii?Q?4Z/J377EsotMesZ4zimACtC8w2ZnsNqKPPnTB4K21Fg3uTbd6es0fpqMrtxH?=
 =?us-ascii?Q?TQQCH0exZVEVaGZ5O+JkxLd1mZePMTUmo9NC8HJZ442YULwgDtyQZVoqJl0u?=
 =?us-ascii?Q?V86V1PlQB62vqMlDTd4q6p5gUONtxtP8Te+PrHg6oTdcf0aeAi7bNgXU31H6?=
 =?us-ascii?Q?QZpROGbPA5Vx4a8bLoHDPBiGX6iA6/J/4XqcEJaGnUQ9Xrpc3bXbHweJ4wgN?=
 =?us-ascii?Q?aKLE3mLG8pABs8cryqau7h39bviMVeUIS9ErzxHz+uts+qgoVGCVgRuXysIy?=
 =?us-ascii?Q?kmcYHIE9Bdrr9R3ApUa5OXBRuN9AKKC59+7b9MQxff9fo8NFo7wXt70nrJWv?=
 =?us-ascii?Q?yWwkWMYwOWUGlJj95wcusq8o0UbTk+0BhTb9OWLAYjvJ3Ifa8fl6f/o8PCUC?=
 =?us-ascii?Q?3IZAPNODMh2A8yk61dvLI5RJWWoveLwgL8fveubqEX1oEm93hsUy5tf2in4S?=
 =?us-ascii?Q?cUdVj7OwDfWYXXTYHVLJGRdWTv0xSIQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e565ff24-2f7b-4323-d898-08df44fc1a48
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:42:47.7871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9k7Jtp57Cu5nU5iv2DT4vUJf7NKg7UlYPK1FGErGAk/8OBt/zarQN8AcV1/lIuqprsrQy7YqVRSDZdwHa1JJa2XCHBhLmmgg3KciXvkOQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9291
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch sync spinand & spi-mem code with linux-7.3. Here is a list of
major changes:
 * spi-mem: capabilities were added, so spi-mem or spinand drivers could check
            spi-controller for support of specific features
 * spinand: continuous mode improvements
 * spinand: octal DTR support
 * spinand: many flashes were supported

Changes v2:
 * remove dtr caps from atmel-quadspi driver
 * fix issues noticed by Frieder Schrempf
 * update patch notes a bit
 * split spinand driver update on 2 parts: core code and fash driver updates

Changes v3:
 * fix behavior of spinand_randomizer_init() to match linux

Mikhail Kshevetskiy (4):
  spi: spi-mem: add spi-mem caps support
  spi: spi-mem: sync code and behavior with linux
  mtd: spinand: sync core code with linux-7.3 release
  mtd: spinand: update flash drivers to match linux-7.3 release

Miquel Raynal (2):
  spi: spi-mem: Transform the read operation template
  spi: spi-mem: Create a secondary read operation

 drivers/mtd/nand/spi/Makefile     |   5 +-
 drivers/mtd/nand/spi/core.c       | 507 +++++++++++++++++++++++++-----
 drivers/mtd/nand/spi/dosilicon.c  |  93 ++++++
 drivers/mtd/nand/spi/esmt.c       |  30 +-
 drivers/mtd/nand/spi/fmsh.c       |  72 +++++
 drivers/mtd/nand/spi/foresee.c    |  34 ++
 drivers/mtd/nand/spi/gigadevice.c | 117 ++++++-
 drivers/mtd/nand/spi/heyangtek.c  | 132 ++++++++
 drivers/mtd/nand/spi/macronix.c   |  87 ++++-
 drivers/mtd/nand/spi/micron.c     |   8 +-
 drivers/mtd/nand/spi/toshiba.c    |   3 +-
 drivers/mtd/nand/spi/winbond.c    | 466 +++++++++++++++++++++------
 drivers/mtd/spi/sf_probe.c        |  22 +-
 drivers/mtd/spi/spi-nor-core.c    |  20 +-
 drivers/spi/airoha_snfi_spi.c     |  10 +-
 drivers/spi/cadence_qspi.c        |  10 +-
 drivers/spi/nxp_xspi.c            |  12 +-
 drivers/spi/spi-aspeed-smc.c      |   8 +-
 drivers/spi/spi-mem.c             | 150 ++++++---
 include/linux/mtd/spinand.h       | 198 ++++++++++--
 include/spi-mem.h                 |  53 +++-
 include/spi.h                     |   1 +
 22 files changed, 1740 insertions(+), 298 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/dosilicon.c
 create mode 100644 drivers/mtd/nand/spi/heyangtek.c

-- 
2.53.0


Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9D6606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 01:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qPB0Fbbh;
	dkim=pass (2048-bit key, unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=zNX8v7ND
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58B86810F4;
	Wed, 18 Nov 2026 01:26:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d3mdjP4O9Up5; Wed, 18 Nov 2026 01:26:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7021F810D0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794965168;
	b=dN5OZAoM/9FCp0rMTOR0Fiqz5XUsgQUIDJuhKbS7M8TBT3xtUMWj6k+OVytFtEsMMICd
	 xrJ/BkgXoPmPN+ht5c7EFKb6BFpYajtI0ReOknBXSCnOgBJRMIMFKhFFR+o7gKT/TgQSO
	 2Rjux+Dm7Y2T9tc0hfzgUNQqjMi8M06VKtdvGahvymnrq/AdYZPNWv8jMmQ1tyTSKHmly
	 MTYrDwu8h0uZczZjhkfPS0+RukdD0SqybDfO2p+WRkEQQCNeMlXC2jR1PLvJgI0FKAfSD
	 ry+orIkx6tjIxubvwaKdbBOl3UvG2LC7Qmy/g+R6jmX5buyIQWMvTWnvUDUHU0z1tIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794965168;
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
	bh=NlxIjJT4+MP21+gD7BvtcjYlMI4vX2iR/EApR4VC+3A=;
	b=jpFP0m1UxdEPWByCoyMCedzZqkS1BemuKKuoF9zUZgWfjSLYOe75xT+KjC7ozHywbCin
	 S04SB+r61HPXvsyYxp18InII7Far5uhcSj6QW7tXMslvwIjJmQrSQejel4N6RsUYjgbcZ
	 zRg0aLxcLXBqs3jSd7Jn01mZex6AeS5SKHTTAGO6m/Y6H6N8VLraXWbUKnW3MRhzKSZXw
	 cy4ylo+gMNaWnEG6yUI0iWq28clGNMzSaYYQFXew29GNkbhzTo5wocfjutewwoPGN33N3
	 PKmsrEsQMu/BmFIwbCRSZPKKIRgjPtKZc/9/ppFAAawaZ0AVKOTlBpadhgYh4/pATBw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=iopsys.eu;
	dkim=pass header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=zNX8v7ND;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794965168;
	bh=NlxIjJT4+MP21+gD7BvtcjYlMI4vX2iR/EApR4VC+3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qPB0FbbhU0kuoSYbIA1edyiHLUfzRrSKc34H3LBmOzF/7uGxDIT/XzBtdfYUpUslj
	 xg4Yuery/l1M1DzkUxmYR4/3JaPUb73yF3HXtwkwGQTosydS5OmDd6yIsawn4VwBN8
	 DdSHKTN+oKHsfeZ0dnmYHxYmPbPg1r97pbN/RU5YcziAFLFMAs/UpcBZXCv12L820j
	 qHdroAfc38DROIB5v4CQOPSTARTrFVJbaaxJZCKIJetN7p2ngB9G8CDwn+DvB6HtrC
	 B0ErFBddiWizmUjHQ98YLRYqsTLTd8ky1TpElpk6XS/ID8cgUHt2H+6mWN/M8VO1Wx
	 VVWNhvE7+m6Ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7021F810D0;
	Wed, 18 Nov 2026 01:26:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FC3BA0E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:43:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 021FE80C7B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:43:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TOT-MnwXQnzB for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 22:43:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1B30980C1A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=zNX8v7ND
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1B30980C1A
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlxIjJT4+MP21+gD7BvtcjYlMI4vX2iR/EApR4VC+3A=;
 b=zNX8v7NDn3+fqdrX4YymrZmqxisTa+9lGMgI4prGL441FHkpkOT1Yv/NWw7zDljrykheFNIB2OEp6/qqn96rIKnFRfkzvFnzkJsaRV+CrLtItmMiWQvq3A5hz9VbdiNiOQjRkXBy1Tkuoj8ZiJeQEf2VzmS3THGeLFtq5K61QbyKmEnlwFvcbqdXxiP1wdbmjpzro3SKn/52t1+EfrqqZ2cXEcFsqAVviiFgTrDE6IqydsXWFz+/EIzUHzvDAK17lRW/FHEt7r6uayGKPAreLjFVDnav+ranL/fYRy0OZsiuI9KgIWCVh+ivm41tCzbrsBy6P4Z1IIJtodXVizo8Qw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS8PR08MB9291.eurprd08.prod.outlook.com (2603:10a6:20b:5a6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:43:04 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:43:02 +0000
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
Subject: [PATCH v3 3/6] spi: spi-mem: Create a secondary read operation
Date: Wed, 18 Nov 2026 01:42:33 +0300
Message-ID: <20261117224236.3150882-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117224236.3150882-1-mikhail.kshevetskiy@iopsys.eu>
References: <20261117224236.3150882-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::9) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS8PR08MB9291:EE_
X-MS-Office365-Filtering-Correlation-Id: 48db5f5c-5802-4805-3a40-08df44fc2336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|52116014|376014|7416014|921020|38350700014|10067099003|11063799006|5023799004|56012099006|261026140227099003|261026121527099003|261028144727099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: Wzr7DA9OXu9p2h6X1nRhN+SKxACa3r+6+oFIMrlAaiq6VmfvDb3JQMjZ6RKwUShaWVTvv7wzBoWUt+aCFm5uDsmq4qFxx++TtcO0zykYaXMpiOkg73t18FpVVco44In98lxshX6MoZM8IjMErO3WHcY6cGd6qc3PL5zHV+nzkie8Z3c12Oc2loIDj1QMG4b6ld3Tx6pV/pIfC5N35iI0wlVykT9dCx25tF653hxUXpCrbZNFT5K1aXjSJjcqMJgtb/iQqnEFjgrcs7LpQVJ+JPPwVMmuvMHTYWIeV5aadFH9oXfPi7fmf4BXhLfXsGiOzFLvPpZ1luucKxiJRS9NqOubEZyKE7XTqPC+A733C6LFbJqykrhxw7XOzxHqZtCwQ6WGVEdTRml3gpOx4nCrviIDXJNQ6hb/M56J8LjftY2FwystaawJt4U7mr/0/7R+SZ9vW0xsYNPbyVCHrqysrAtLrDqhmGifgc/hoV75rBb+Phg8Po+OgPEFZQDd++Tzte8N/eRM+WZiVS37TD1kr2XKMEMVI8wNAPFLBwW2CtnySK06+paOVTKDJSLHBMUisFhsHbgxl7xDfz45b+SpJg9y2GzesEQeZSecZ0heGpf/LfhKqbqIr+XMwswu220ur0Z9fZUxxFhG3R/wHdZsBnHj23Ea1Y0n/Id3oGciuUGYQVVpdm03dQbCYWkNc3omGiaDH2lbTPD04YmxlutQ89UY7BnjXSWdF4Y7CmzTEL2SlVo7K5Df1C8Crva2ZgYA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014)(10067099003)(11063799006)(5023799004)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6aGagMngHCox1Wq0F8h7/wSDQkrO30Hp8uRMwUdLA5dYTSK7N236kvWilbP/?=
 =?us-ascii?Q?U/LtkZdjxiXC8RIOJQNFBYGP2YvkRpnG01yumqc9Kx2tura2UdpKSvZCFBmC?=
 =?us-ascii?Q?8d7RKa/d4ojBvBxIklFysVwyK3wHs72lEEwBBDumgM1AgPWKVVlz2PSOIrmW?=
 =?us-ascii?Q?P33pEN7zFvWKJUKRuclGoT74tZ3QTTNewmBcfLsaZlf35IhBCd9Sr1ZZ3k7S?=
 =?us-ascii?Q?zGKAGYON0qDr5Je6q06xqWs9/S7VVYFTINpOCxheuegWiLryGPc8mfmRu6eq?=
 =?us-ascii?Q?WAh9P/6tc7sdQdrkZexZbmRgyQ36q+kM1h7X6EMHaid2ssl2i2RinYBH2vDL?=
 =?us-ascii?Q?i9yTzNZUKijKOY6ZY9OEbGjaICVweUFL8Te/00Hys7TNenaQWmrRG4ZD+LnD?=
 =?us-ascii?Q?jB9pdv9kpA3Zah/rS/MGe/CjSqa0OPD9e9tpaLOM6Q+0WxFacqpmR5yQm/jI?=
 =?us-ascii?Q?jj/+b8Oum/34DP9D+OD3DhCrdsrSPUapWCogYqacWiJbTpIxPOv86z+Kjnwn?=
 =?us-ascii?Q?9Va3ZzBGJZW9pgY8Hfb6o1LflJYwTOf3S/Yl18FPKNlikl6OyCJY1vSd0HFu?=
 =?us-ascii?Q?WdzjMWKSSOu+y5YCksawvbjJZ5xBo+sUS1WPO/niMONAQq8e5VEY1/o/VZyU?=
 =?us-ascii?Q?i4vq8YRd3RJktqKNq0GnRhcYh/tEHLBg+QWy+EkigtKfuXkPYrRR7yWN0n57?=
 =?us-ascii?Q?PhYoCJ4wjnza0Q+Uys6K0WhP3KpjrRkWOoOm0kk+mCFdFj9XCJsigA1DWwBk?=
 =?us-ascii?Q?ObLdQYXPtVC7yLAL4c/Ftmaf4/rgNl5jGVtQTjhYLPZ5RfwMAMHdwCQWBx6b?=
 =?us-ascii?Q?pkWsDNyEIeiQg+95Ehg4MeJArDCkhBUB34jo/5yf68o63aMiz0NhI4wL0ATh?=
 =?us-ascii?Q?YIwZHVYbAeB2UKDKLmPS44t4yNyvO3BsLR69ji1kCrdecIW9H7CIH3lhApOJ?=
 =?us-ascii?Q?dGY8dpkg9sLGwX/YJLA1mdlWxfb3CvaONU5Cf8BpRRAQVw1IDY1yClQGXEOf?=
 =?us-ascii?Q?qo7dK8IxBypbvSPgwkJotQ2+/JX3oLunT8oT7c9UpB2CmInbq4xVKc1C2if2?=
 =?us-ascii?Q?zGcJoFD07akQfP8luVUnZj611j+Gioni/4/ObEsFvausLQphumv8XZf72Sdk?=
 =?us-ascii?Q?qHDZmqjpHnmBo7rs2KU+4YjXzTly+NyvUhF3kmo+7sjxdT/nHg4gdvP8pEHy?=
 =?us-ascii?Q?7J5xwIIez9gBjeFxJMnuQhBcOoGpNzDtBILWLqFbcYy0rM8mQl4XSb9jpwJ4?=
 =?us-ascii?Q?loAiuMy/1NR24ESwWYn/uNgx9VIgzv6Yt5VBu5yYYuad+L4hErrClFxl7zJ+?=
 =?us-ascii?Q?+IZzL7bmwQe9vvISuwbFhXAojhKephejQZM/gL7vwDzynBVf4oa3uduKIElr?=
 =?us-ascii?Q?f308m6plo78oJFaqDPa6ExZ9TBHilMZoFZBTvkikhCuxfe7SF0G5sD+Lc2jP?=
 =?us-ascii?Q?YBJt6an6sxooE7Nznp/EbPV6rLsOnHEe9C4PCAkJjtimcH5vARy0gGtfWaV7?=
 =?us-ascii?Q?XvQnqdMLyk+dnkuUp9i//mrrfHSlgi+xNjQfgpSxxuQKn67aB2mbK5/eT7ai?=
 =?us-ascii?Q?gQwffTaS/uMYkjSM9cdn7seH3yteusw0EilmGHOPJXD4IUEXng53qGM5UO5U?=
 =?us-ascii?Q?yen+0s3O6bym/PPy7NxT8VOI/2BW7Pbkd3FiIwSdyvNH6U4aazEGA5EQKCcZ?=
 =?us-ascii?Q?din+zBHxZSe4dQL7xVBS+nkdig3aFq/CkuH/KuJw1QyBe81ZQOmCazCATh6u?=
 =?us-ascii?Q?OH312Bw6JnZUFvaarNKv1x8qt/JU2X0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 48db5f5c-5802-4805-3a40-08df44fc2336
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:43:02.4818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /p5RlrJthsCBAio573Ko7Qh58dg1G8mttGhk+5VWGVOyKOfoFLpINQeullqvbbIZraUHv1ydHyhpRgILMATeyhfk17Em3IBzK7vkgV9lTr8=
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Miquel Raynal <miquel.raynal@bootlin.com>

In some situations, direct mappings may need to use different
operation templates.

For instance, when enabling continuous reads, Winbond SPI NANDs no
longer expect address cycles because they would be ignoring them
otherwise. Hence, right after the command opcode, they start counting
dummy cycles, followed by the data cycles as usual.

This breaks the assumptions of "reads from cache" always being done
identically once the best variant has been picked up, across the
lifetime of the system.

In order to support this feature, we must give direct mapping more than
a single operation template to use, in order to switch to using
secondary operations upon request by the upper layer.

Create the concept of optional secondary operation template, which may
or may not be fulfilled by the SPI NAND and SPI NOR cores. If the
underlying SPI controller does not leverage any kind of direct mapping
acceleration, the feature has no impact and can be freely
used. Otherwise, the controller driver needs to opt-in for using this
feature, if supported.

The condition checked to know whether a secondary operation has been
provided or not is to look for a non zero opcode to limit the creation
of extra variables. In practice, the opcode 0x00 exist, but is not
related to any cache related operation.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
[Linux commit: 6f96f2fa152518d93ffeedbea781db50aef7f7dc]
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-mem.c | 17 +++++++++++++++++
 include/spi-mem.h     |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 351ca725524..ee6c9b6f3a2 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -639,6 +639,23 @@ spi_mem_dirmap_create(struct spi_slave *slave,
 	if (info->primary_op_tmpl.data.dir == SPI_MEM_NO_DATA)
 		return ERR_PTR(-EINVAL);
 
+	/* Apply similar constraints to the secondary template */
+	if (info->secondary_op_tmpl.cmd.opcode) {
+		if (!info->secondary_op_tmpl.addr.nbytes ||
+		    info->secondary_op_tmpl.addr.nbytes > 8)
+			return ERR_PTR(-EINVAL);
+
+		if (info->secondary_op_tmpl.data.dir == SPI_MEM_NO_DATA)
+			return ERR_PTR(-EINVAL);
+
+		if (!spi_mem_supports_op(slave, &info->secondary_op_tmpl))
+			return ERR_PTR(-EOPNOTSUPP);
+
+		if (ops->mem_ops && ops->mem_ops->dirmap_create &&
+		    !spi_mem_controller_is_capable(ops, secondary_op_tmpl))
+			return ERR_PTR(-EOPNOTSUPP);
+	}
+
 	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
 	if (!desc)
 		return ERR_PTR(-ENOMEM);
diff --git a/include/spi-mem.h b/include/spi-mem.h
index 81166492da2..08d854b1e52 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -201,6 +201,8 @@ struct spi_mem_op {
  * struct spi_mem_dirmap_info - Direct mapping information
  * @op_tmpl: operation template that should be used by the direct mapping when
  *	     the memory device is accessed
+ * @secondary_op_tmpl: secondary template, may be used as an alternative to the
+ *                     primary template (decided by the upper layer)
  * @offset: absolute offset this direct mapping is pointing to
  * @length: length in byte of this direct mapping
  *
@@ -213,6 +215,7 @@ struct spi_mem_op {
 struct spi_mem_dirmap_info {
 	struct spi_mem_op *op_tmpl;
 	struct spi_mem_op primary_op_tmpl;
+	struct spi_mem_op secondary_op_tmpl;
 	u64 offset;
 	u64 length;
 };
@@ -338,11 +341,13 @@ struct spi_controller_mem_ops {
  * @ecc: Supports operations with error correction
  * @swap16: Supports swapping bytes on a 16 bit boundary when configured in
  *          Octal DTR
+ * @secondary_op_tmpl: Supports leveraging a secondary memory operation template
  */
 struct spi_controller_mem_caps {
 	bool dtr;
 	bool ecc;
 	bool swap16;
+	bool secondary_op_tmpl;
 };
 
 #define spi_mem_controller_is_capable(spi_ops, cap)	\
-- 
2.53.0


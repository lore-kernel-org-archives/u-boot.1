Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52484606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dyN+OmYF;
	dkim=pass (2048-bit key, unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=X1gRkuju
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C527810B5;
	Wed, 18 Nov 2026 01:26:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1rfPpaxN-XPj; Wed, 18 Nov 2026 01:26:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 01D2B810E0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794965164;
	b=Z6hdseINN0ccyTYDsVR+32YB3mUcdYJbyz8BPaMGLQxEv+kfH8V2kEMAovxhqPK5P821
	 UAJvkqhY2VwaHJ8bL/FsgluYdGIWDxDlP7r2NO82lisR1aYLxIpPWiLeBd1Is9d0Tx+tT
	 PxOtJYY4x+rWUYqdf2JbRZwb/Nyp27372ZXJ41E/7mgJJQX4k5laoqZRtkb9jV4xUcZ1n
	 NVecvWvX8VIrnGThRogum3QMdSrQpRjRXLr/lJ3ARxvd9WhAeHGWYiFktVmbHakHibOKm
	 nxiY5DsthhhtYy1mSmiM6jcOIk0x6c0WdJWFoSkxMN7MK4H4S7MkwVBtSVqKw2/ROhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794965164;
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
	b=KFdv/cDSyxcxvd1+UanJPHOa9yIBtPCRDpYkmpOkkuO1+GoKJp7QwBAmnzPaOu/pZjMJ
	 eXnhO4qTA6fdC1Q7DaZ1gCqTrZimUCso/i84HnjbWmcBQBR9KI0ErF+UDASviVt0j2mJV
	 SNr+0Da3RWDMSC3oNldpdkYmn47Va60FbZOWkftti+O8kcU1HT1UpDn9/MCFz7o1cZEo0
	 zBU7EJnlHeT+uSOx/UfnlXlSOCywr/JTi6EZFL3t0Ew9l8fgqhYhN4cmWTv0SMK8V5sjI
	 cLgVYPT420sOPRccwwbB5cHMHpzQ/4dfZHOOPWJakf6jsxoteQmZgNvnc8JtBya4JIA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794965164;
	bh=5uLsvspSBjlFadwHmubOqsHczSic7cv84RCCMkzPytQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dyN+OmYF5ykX/ySUlQZWSoRC1uD5QgIvtdLCUtsbBZo2gXLWI66SdRlwsZpYicSB6
	 a12xwkP7nepOn2wLUb/ZV9TnYRdiU28DhsP+bnfnf5Khn9t8VEz3gGZ5YGAPp3ZXC4
	 l5ZdqWG+ORtS+80Mwz1jJeOqmnunK4+qqsa0kpgyJ/xqnfnI5P5mJ7A7gSI4VydvvJ
	 XRInehYDMJ+xrralUamAw54ZXP0ph/wAWwLmmmDFJ7Mt2wK+FUQypXJhXcNp2N5MSx
	 L+5ca2EVyHymiB2zNtWHQZhWu1ZKqeTVsSjBieIJvRXlu/RRMgvz77wSI1Zuu8PLPt
	 bnGp+Yts1GfWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01D2B810E0;
	Wed, 18 Nov 2026 01:26:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5394E1E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:42:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3939D60751
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:42:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6wF9HlD3njcS for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 22:42:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EA3BC60735
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
 header.s=selector1 header.b=X1gRkuju
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA3BC60735
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uLsvspSBjlFadwHmubOqsHczSic7cv84RCCMkzPytQ=;
 b=X1gRkujuNweg+3ct93aDsazdQIVmC6tk3fcKyWUPkC6KB+hqnQqJ25uUOblrhFxhazCBT2NArHftBbQbP1581qspYFq97LDolU0PYKlGPU9eX5b5gS5dbGdIOlkLlf8uQAkeKrtAnmVLpJnNGfaxoiQrmY9j4b5445y/NZlVrx5EVmT8wHMjVISVFxXE5macga1YprQ0BgAkmZVjeBLJpqaiTZan/2n1ryu1bR9w+BE3bha4b7fO0lIQinwhZVw3O62fXY7mK8911EVn1HagXOzXkHjUG0J4JbY98TbrjDGROkIIwSkd7kdH5bCWheu8imyPKR1ySidlLY62LL3S6g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS8PR08MB9291.eurprd08.prod.outlook.com (2603:10a6:20b:5a6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:42:52 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:42:52 +0000
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
Subject: [PATCH v3 1/6] spi: spi-mem: add spi-mem caps support
Date: Wed, 18 Nov 2026 01:42:31 +0300
Message-ID: <20261117224236.3150882-2-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: b0421544-cf66-41bb-3471-08df44fc1ce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|52116014|376014|7416014|921020|38350700014|10067099003|11063799006|260925022911599003|5023799004|260925021911599003|260925021311599003|56012099006|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261022075727099003|261021121427099003|261022105027099003|261102130727099003|261102123227099003|261009221727099003|261009220027099003|261009223327099003|261009223027099003|261009221227099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 30z1VacZtp0L9qlnBk1KrEqWVxlmhXCh1l6agyxYdUmVoPN57lMbqDRcn9a1sQvxlGlMGvocJDFKYGUXv1f8uXkYnDcH3sSJ3VbLKolUnGu01JlZanA3ToqvC2XDXRHPhANIWGRNifRatMZGHh0qVMjXc+jDOfVVgUFCGs2qIajY8O8xgu+WUlUZ5X5LAGHbzEUtEHgG1Xo81uSQokuhkadB0uwHBxygEQUn8tIeFrZ3RGBcTwMbyEfCDMk1WyY9JCBZmTIjsEeiLb+Et9/uFz/tXR0uyMbedl49BPdA7zrFRaz2QTWMxWTP/4vY+I2VKvs+YADFAL6y3rqcBUFY9SCEgAj0uDcWUY8icD3Sv4lACK9hwfvnIrU17SG6s6D3iS+ukd+hWXeULrQeRpwyARR8ahcTu2QJ0Vq3f4gYHdz7xxmJGdS86Vb5n76YU372E1W729xPwdUlBbbNYKGS02cqvV78FJfHgiZVTuURbEI7WpBr45RR63hzQqxtBAhod4e2ow6zYvWo9mgc5XwcoenMdeXqKmhcdJL2dgS4J1U8Y/udZtYn5yKkp+sU2xAqn299DFSA0eriJHeJbjiv2W/TuveA0KZTCRshTsQlK8GHvMgwoI1ykpLmMaTCXIz6kifyu06DS+dzeBIwW4D63RA9I6UamVznxt+YQ7L71a6fgWooz9qgWhhGA/j6fE1hwPyPkxSglEZ1QHhYWQXp7uPFxsnZlL+2qPrrXIyLsS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014)(10067099003)(11063799006)(260925022911599003)(5023799004)(260925021911599003)(260925021311599003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102130727099003)(261102123227099003)(261009221727099003)(261009220027099003)(261009223327099003)(261009223027099003)(261009221227099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vYeL9tfpkR7bO+q0v3pXVbBGaFZMtvzhQTxk38rdJi/Cp++mMNHIoTpHjDSm?=
 =?us-ascii?Q?2DmwhwpjxCOrUMrafFbTGmTFQqRygEXJDV9x+CWNV8QFdAs1jSWUSIMA6J7Y?=
 =?us-ascii?Q?XZ7E2Lsz9xcYWrGPdXa/RekQwGKK5eyEklMqxcZy4SoPeF0frXc38fUTKq5b?=
 =?us-ascii?Q?tL4IKxXN6awDMdWCJwRhCK/0hkvClJNTKAKiIlEEalbmqGmmUhX8WjdXSyxl?=
 =?us-ascii?Q?RKzCMlNYOe74cnxstjOEXIH9PShmyMH9pSQ8iZbuSFdwmjqwibRsa7TKh6IU?=
 =?us-ascii?Q?9yn3ao1AftbAo4gxecVcMqNXkMAS7mfXEaLMaOBnD4v7pMD3TaC5SPNgpoxF?=
 =?us-ascii?Q?JZPZfwzd+SgmTVITLsuUSNFTIY1yJNHku+264cvtT7K0EvOn9pKY4+cdeHOD?=
 =?us-ascii?Q?oreEw/OU8hzUyAreafFBSdMQtiqoVQ/W3TWXp8EeEohBURa84Vy9Wtw5mKzD?=
 =?us-ascii?Q?X/hNqO0SI3jsmB/XuWQytWxqhuqSxrHxek8244GsSzV9E032LABjy3FEeGaL?=
 =?us-ascii?Q?gwWN3nhdjZ3VYW0rldOi9WfkYpTj9l960S0cSwoAPitzSC1zTjx3SvdFqUfk?=
 =?us-ascii?Q?Aa9J+RLElQ8r7y9kogoEd6nM8xRoRb8+F2m31qV0gspR33ckYsarf1RrVX7f?=
 =?us-ascii?Q?CK9RQscfVwDlTs7ryoLMkJ1UFBwnaJm8fKPnHrOzSmutFzvCPIy7b2NVZdBI?=
 =?us-ascii?Q?1JorVyha0ZwlAGic/TQBgWr3Ohyuhn9H7ZMgwPo/GOsyOZlTmC9HVTeZpGJi?=
 =?us-ascii?Q?kD4YX9LAlOzoFYQzbnX9QlJ2ITn4FUxmTUW5r6KeVh0ylgssPIcK62IUcu5b?=
 =?us-ascii?Q?WLHCMSpKGV+vtaOfU0jFcmiCk/K39op55cLqxDRUnfj0X1sxzg2tXPkpTAMU?=
 =?us-ascii?Q?uay2ARl6PyqJc6w/4S1RiNC6TwF3hDSG/JCmGgYqZByj1rin76BfQ8Ip5stW?=
 =?us-ascii?Q?2jIwErSDE3SnsYm890sAbMbbSv9eTpgXnn6lF3Cm918Gg9B79sySZWa4FdZs?=
 =?us-ascii?Q?tkTTBW35p3P1v4/Tg+jX31GxrnigjwvkMJPyn1YunDoTcLActoIxoZ+BJxI+?=
 =?us-ascii?Q?8BC9WQ2h2U1ytQeLP8hBSdzNUGy0BJy4mlBxJcyOrA2evUcbryQM04rXA7sy?=
 =?us-ascii?Q?uLiVBPc1karcZShOjgNVq3mbhGJ/W7KY9DzBMOYmNhzshHk2jYJF+smwczey?=
 =?us-ascii?Q?khGTxFwC8/FfEEifsOdCT3aZaDblFgAUwiefeb1TrpNGzLg776xRbHGqmlO9?=
 =?us-ascii?Q?h7aWAir0KHKzjuy+MFB/iiJJK7pDRN5BLsT+pVXwx6u+lFPhuQHT180ECSXp?=
 =?us-ascii?Q?3MsLfEQLHGeQaL3+wh5eq2cxenHV5mFIWTjS7pi8AbAMjLRiyWMsfvlVNyuU?=
 =?us-ascii?Q?3/YzWctfNoedcr76gSwBIO/LBhvuVPpiNZdhda7sKtUiCw1ks3prKF8NCnbf?=
 =?us-ascii?Q?8MEVm6H3BfpvPb8nRRy54c+o1BICu02e2F+zMnS/A2EVzD008MUuboM3DtB3?=
 =?us-ascii?Q?7q7WnkM6DSTkJlzi6OdfJ3/sTWatABg4/IJTzjoFQTeOnnDsgqb/EBA4ew+R?=
 =?us-ascii?Q?Zw3Raw0Zjgifi2PCCqcoLVkCAc7w4icOL+bm62QLRSgf5iDZXfzRMYLdX1s+?=
 =?us-ascii?Q?ATQ/Z47+ubBw5c7b4qlo12kNfUrHH6YBs+b17IQ1AQ8h9G8EFLYJWoS8J3hZ?=
 =?us-ascii?Q?bKwqCgeSXsBhlWBfjrqD6/MGnMqs40jqrQ51xDtHSqMPVnnKeArkrJGvfR0v?=
 =?us-ascii?Q?G8Nn8MGvZwZFo/Nau0TunyxQ7c4+6Qk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b0421544-cf66-41bb-3471-08df44fc1ce2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:42:51.9631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qikK3REDG7hQ4WJQeRd/QL6sfqowPEHVu9IvFDQrqb6YjW4TOWb5JpFYLMf26sI5C15QsQZ0u1HCBWQHiVORL2DxEd0CwKXHUZHQV1w6cLc=
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


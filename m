Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1E0606A32C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 01:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SegCz/MP;
	dkim=pass (2048-bit key, unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=5aDMom0L
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2305E60A35;
	Wed, 18 Nov 2026 01:26:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ZgmL9j8NDxf; Wed, 18 Nov 2026 01:26:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DCB6C608AD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794965167;
	b=n/izwp9lzWo4Jp3vL7ey/UFw7ohgXqI8B/+sRF6AaFPVQQVVFLoPjLOFHnCMYGbFgyWZ
	 ZwePXXdDueJ46Igg0OurhNjkiLKC3A89YbcKWux36Uy6VZDkkcgGpXQQhsxAl1oq057eM
	 HlKRYMKav0jpgmOj5P/4iq6AZf0LhiVuX8EiwjArGitj4GVgRJTPGFKR7B+gj4IuhJb8B
	 uFhUR6Z5iRGVxVP/1GQ+KwsPALmGqKdnxu8XzbsIE7Mko2FPYAO59j5hjHYoGioaKJnWb
	 X+y98yhjED4m0AihJN9m0kIUnduDDntwzpyYLAxjEPIcmPOFV2zoXmcNnVaVEuEzr3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794965167;
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
	bh=keI2UOskcz+T54Lq2AlxnYBl3aqyurxu6+gElXr26oU=;
	b=hEennXvIOJp9L5LCG6XrlE+u4Mmg2Gsdf69WnXBKtmI8fqOGp3msOd4o2kyQ7PCFjrnY
	 rA6aFjRn3UDbr72xyKTq/otpMWfQKfgVLfKFYW9DIyYibBpDTfa24rfSbqqmcOygVY7ak
	 TCdxP7gJ/BWKrk/EL9ITAUDh2HRcdkhTcsDqmNtWtFSHA38XfM0YQeduOHShhEY30TWqt
	 59zS2brRfSE4/7zmgG904OXBjNykkxR4pW6KhXKQv6SYgZS/qNsHAK+98KwbNwSYYCOpV
	 cA1vY6TLMSclQcNxE+h7nADVeq9kt9H6drrdKDArdQMGOVhdXIkHZgeJsWaJxp0kiCg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794965167;
	bh=keI2UOskcz+T54Lq2AlxnYBl3aqyurxu6+gElXr26oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SegCz/MPh6t0WadNYevDEPXdsHGmJC2xzAMe3pml81z9985qPJowWrAgWfkvDr4sG
	 UfNy/By7mv2kXAjv6B7KNRj6Ho548roZurrpgB/ZLS4QdYXb91TW+Tdrobv3kStgvj
	 X1XdjCTfCKFOFyQ7m/wkME58EGdieP59NzrOUkCWmlcAlJSoRhRibdgJJv45ZuwgRt
	 Ct3D6sZpY2W3bPjKmlmYQZD3OjCO6aN08oUAPW2XpVBNdSCKqn8MNvCbhocuW6m+9Z
	 q9fhcJfoTk9iDnRZjx2SAwuX03ZS6CvvSXdx7/l1qMyMAaZ11E6+j3wCtZIFBhJrT4
	 P18DO06N6GPNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCB6C608AD;
	Wed, 18 Nov 2026 01:26:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 364AA1A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:43:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C731809A7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:43:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 19bbm7CsrsKW for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 22:43:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF96D8109F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=5aDMom0L
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF96D8109F
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keI2UOskcz+T54Lq2AlxnYBl3aqyurxu6+gElXr26oU=;
 b=5aDMom0LM8S7pmTmNYlEDyEKkKaTi7edK7lXtvTVaksfiEF87UTzE56xFA/Rh936LO5jO0A8oxwPo1gU9NWS/X9cchxE9DMJMVhYBdV6CHLviydbZee4vmVrmstoZTAemS4U0EAze1ai19o+0cLHrA6bBVkvZDakQhTeIwADl/awExMocdm4s8S4sSE/PAdQnUOylxUcHOaoY3Ggy16x2NqQAxbp4ZO0ysJhCeGX2vDCDK4AxpSHiw9ueJRrfwOxRHu2DvYLd4Qqcwm0bY21VMyxdTiE2bPiFA0zD0TGFTV936UbjNZinXn78Jaut+fr3HeqIit+mrmc4Mvwim6y4g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS8PR08MB9291.eurprd08.prod.outlook.com (2603:10a6:20b:5a6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:42:59 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:42:59 +0000
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
Subject: [PATCH v3 2/6] spi: spi-mem: Transform the read operation template
Date: Wed, 18 Nov 2026 01:42:32 +0300
Message-ID: <20261117224236.3150882-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 29a0e6df-1edf-4525-26ec-08df44fc2149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|52116014|376014|7416014|921020|38350700014|261021135927099003|10067099003|11063799006|56012099006|261026135527099003|261026140227099003|261026121527099003|261022115727099003|261028144727099003|261021133027099003|261021130227099003|261021123027099003|261022113327099003|261022075727099003|261021121427099003|261022105027099003|261026130827099003|261102130727099003|261102123227099003|261009223027099003|261009221227099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: f9xmugW5qtHJA+Uy2ZC/hc7PddZQV2IW+iSUNJACUalo+2AfK99I4jsA6SJs3ZixT5OARJA/sRuQGKzbqL/nGpsubKircqJa4ofqcC/NWPkxSJXA/pjnnAq5bxT0+jZGGOudTQxRGiBVaOt+R17JVzAu6j/2XHuE/ohanEEvChXPto6cnXxd8d3S/5dL5bVPHGEgJL7SzWmmt3upk66nrnRgKBNGShtP5QBxb9zGu343i34/bdkeD1FlhT6uC0A8NJ1XhpLajjwj6Hdn7QCvc7if8UCubvkfXxuIIPN8S+k0MWENA0HENuukNocqKEeFJ32jV14e3bVjH2J6TS/UyXQ7mdf2JwnvnmboDiSJyv6jav/z0Uz7nDsWHt3MUoHkAJbiO9o4rxvkn1vBIN+BCL42hTnIahUZ7Ps8gnAMKvQ3RdfBiroAjIJr873xhmK9kQHFoXB8t9680UGdsnEJcUsRvBSUwtCvCLt0ZUEPM+KNgrLkTa030b83CSn/c9ObndH9i6PVN7dn0oHyjVUkCi8HmltXKtFSG/tiLCgahAOgyYm7fyBleRiCPrOK60kv1oC+MFkN880AssvWJVEaM8mD6VZO64yYiyHRd+vD6Tcq3S8uGiSMiHTy/aZ2mndQDgbXc0v/NPIah3++n+kiW9gDvmf0HViAf7no1RuW9j3v1tysZUUgJ70rFX37ZjnG2YtjlgNMT0h9aRqLnmtcMlp3rueh2M5Wck751rjdZ7w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014)(261021135927099003)(10067099003)(11063799006)(56012099006)(261026135527099003)(261026140227099003)(261026121527099003)(261022115727099003)(261028144727099003)(261021133027099003)(261021130227099003)(261021123027099003)(261022113327099003)(261022075727099003)(261021121427099003)(261022105027099003)(261026130827099003)(261102130727099003)(261102123227099003)(261009223027099003)(261009221227099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cXjEl/zn/j771eo2OTwRoh+1q53b27nr2xiLraX4yh2Xdj91m2/HAgG6Rie+?=
 =?us-ascii?Q?RjtjjmpzRm4La9qhpAnPxDtUC6q+xV4AetirT+XsYtlOxu/T5Q4JPWTva5gy?=
 =?us-ascii?Q?qHVap24N456aOZXQ2uguF1uh+Bgv1ZdLZ+s2WOxG8x4kmUyi68dy+6mFov0q?=
 =?us-ascii?Q?OZ9i8MPxpJyJbS4omSTKsVITMUPSAVo4e/jJXQwHoM+KHBoVWoGU230mY1n3?=
 =?us-ascii?Q?cPvTFqB3A/KEz+V6BMvo8ka7vKAQFYOiYSUHhqdzaQ505j+6xas9IVmiovaB?=
 =?us-ascii?Q?e3GR6LBiCX02+I/EJaZ0Nyseiso/XJqDwk1COBgqXXpJfY0uKxCwAG27B6AI?=
 =?us-ascii?Q?Malxi+900LfX70NBwiVlkqYKYXt16DVqVxFR3HNFr6rH8eKUr+OVf0MJFjPN?=
 =?us-ascii?Q?JWj2Sg228q7Lhf2yXWFwjtGnpZ7XxQ38ihUvhBB/Z4/q0GYrMCpTWZCZvqtX?=
 =?us-ascii?Q?B7a2LqXCJibN6EkhwFrAucEh9Rz8g07qro1KLvV1slEY23ieT+XHYZ37acSi?=
 =?us-ascii?Q?HdJzChzvyd8OE5fkIvB7MvNCGa2wT3Y44fff0RU3Q27hJzgIsQQANtAvFA28?=
 =?us-ascii?Q?blaQkE+YrA52eSLHc6eus/fb2F7vGMTXXOCbCjtsH7hlbNaxwwycTkxHBetG?=
 =?us-ascii?Q?7vD0qotpPY9mu/5rQiShNaEpfbgvZObcPmvm55yaYLKMbKZSfQ32zHWNbFNY?=
 =?us-ascii?Q?zJro9czDGuf+t9LIGxYlotP7u9rX+H/pGQ0SfUsBWdZYkbQYqFOEOStXujWr?=
 =?us-ascii?Q?9iBlbghFPAa2mCKbv4fe9v2WvfIVLXUM3LhsNMelr/cMjt8/AybzkLj/P4YX?=
 =?us-ascii?Q?SKkxW5akdkoWKuMuaE5AP+g/N9OK1Zmtl8fX7BiC9jr9Lp0jJaAjX2CpD4pH?=
 =?us-ascii?Q?X+9mSTrHUhD1AXZexgaQpRZgSzE03TeHiLsOFSlhhzg9yenW78ugyCwGSp2+?=
 =?us-ascii?Q?JrlamiOsxifAOjbZUvfuqxs0d6Wm6iMCPhLOT9iRzsH2vs0UKcCFUeNSK6mD?=
 =?us-ascii?Q?2i/VttnkLwvpBiGD1zqw8sc9V6FfzWV2Fo2vSIs0uW1r5gTlPhPOdwIuHEBy?=
 =?us-ascii?Q?ST5xEnLWuR+7sAKCh0mhLnZOkkxlcgLELNuv5wtdSO12cYHYAoO+/euOpXH7?=
 =?us-ascii?Q?i8/fXEI81piP0qMiBaaqz94IXzdEscPZe/QTwHNA199+24GwKocX+XJrmLMq?=
 =?us-ascii?Q?RjYub47lZxgk7ssk1jFccSxuvfvv2jcIQQbdnjFW9Gk0293ubHczhw6zlHbh?=
 =?us-ascii?Q?wst0XD39DZKAXo4DZcfD9Cuze1+6d12z11xQxYEsDTAXHErxpK0isIkN4HWi?=
 =?us-ascii?Q?Oobm+xRtzmPMeoMv/Ww3ohZEFZGqFQ0agUKyjRoxhqGutmIwdg2rmAPGbj9m?=
 =?us-ascii?Q?GApF4HwfaWooKNcYngirCejrhIdRenM+pFCWkVx0/aAQEGYgxxtNef2Lzxtn?=
 =?us-ascii?Q?alDDp97wqKccGR8x2wA2fme4HCeX7kEJK3SH73auXVTXJ8k296kgdHXS8GVr?=
 =?us-ascii?Q?+evy5OOgBP5AcS2qITMv4Pk/OpBUSjdKFJoslIsPp0feToOJgAeYX7X0Fl+G?=
 =?us-ascii?Q?SLMUz6luxKWjIufL4icQ4DJcw3zpNuZ8qqrg57AXHlLABWdKKM91xbDdOMHs?=
 =?us-ascii?Q?p2GhD2IMrcIUSjhCNVL0jzsI97KM8D2cMCFSD/MViBaOBQixBob1x+P+QFm+?=
 =?us-ascii?Q?tPTBNR6X5Fr+PGKw8udWflua589jt9lgqO20spQ39GR77cs+4Ko0l2IP1SL5?=
 =?us-ascii?Q?0aT1cxxT1FLlhJHICGvyvt9nNwSxAck=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a0e6df-1edf-4525-26ec-08df44fc2149
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:42:59.2370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rATkU8iBs1E0eyziLMbvy1pkKkkBqp6TykgO3gwQMFd6w/OKmjI94YUUgIjHHJPcNiJAmsbWNtMOjlRvaIlCAiiX2uNuRSOs42r5mxUVEY=
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Miquel Raynal <miquel.raynal@bootlin.com>

As of now, we only use a single operation template when creating SPI
memory direct mappings. With the idea to extend this possibility to 2,
rename the template to reflect that we are currently setting the
"primary" operation, and create a pointer in the same structure to point
to it.

From a user point of view, the op_tmpl name remains but becomes a
pointer, leading to minor changes in both the SPI NAND and SPI NOR
cores.

There is no functional change.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
[Linux commit: 39d0ea33123ffe0214217b529830ad91574c8757]
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c    |  4 ++--
 drivers/mtd/spi/sf_probe.c     | 22 ++++++++++++----------
 drivers/mtd/spi/spi-nor-core.c | 20 ++++++++++++--------
 drivers/spi/airoha_snfi_spi.c  | 10 +++++-----
 drivers/spi/spi-aspeed-smc.c   |  8 ++++----
 drivers/spi/spi-mem.c          | 15 ++++++++-------
 include/spi-mem.h              |  3 ++-
 7 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index fb8ca0a787d..14a8703d34f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1174,14 +1174,14 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	info.offset = plane << fls(nand->memorg.pagesize);
 
 	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
-	info.op_tmpl = *spinand->op_templates.update_cache;
+	info.primary_op_tmpl = *spinand->op_templates.update_cache;
 	desc = spi_mem_dirmap_create(spinand->slave, &info);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
 	spinand->dirmaps[plane].wdesc = desc;
 
-	info.op_tmpl = *spinand->op_templates.read_cache;
+	info.primary_op_tmpl = *spinand->op_templates.read_cache;
 	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc)) {
 		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc);
diff --git a/drivers/mtd/spi/sf_probe.c b/drivers/mtd/spi/sf_probe.c
index dee03662d45..0d01753b884 100644
--- a/drivers/mtd/spi/sf_probe.c
+++ b/drivers/mtd/spi/sf_probe.c
@@ -21,14 +21,15 @@
 static int spi_nor_create_read_dirmap(struct spi_nor *nor)
 {
 	struct spi_mem_dirmap_info info = {
-		.op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
-				      SPI_MEM_OP_ADDR(nor->addr_width, 0, 0),
-				      SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
-				      SPI_MEM_OP_DATA_IN(0, NULL, 0)),
+		.op_tmpl = &info.primary_op_tmpl,
+		.primary_op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
+					      SPI_MEM_OP_ADDR(nor->addr_width, 0, 0),
+					      SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
+					      SPI_MEM_OP_DATA_IN(0, NULL, 0)),
 		.offset = 0,
 		.length = nor->mtd.size,
 	};
-	struct spi_mem_op *op = &info.op_tmpl;
+	struct spi_mem_op *op = info.op_tmpl;
 
 	/* get transfer protocols. */
 	spi_nor_setup_op(nor, op, nor->read_proto);
@@ -49,14 +50,15 @@ static int spi_nor_create_read_dirmap(struct spi_nor *nor)
 static int spi_nor_create_write_dirmap(struct spi_nor *nor)
 {
 	struct spi_mem_dirmap_info info = {
-		.op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->program_opcode, 0),
-				      SPI_MEM_OP_ADDR(nor->addr_width, 0, 0),
-				      SPI_MEM_OP_NO_DUMMY,
-				      SPI_MEM_OP_DATA_OUT(0, NULL, 0)),
+		.op_tmpl = &info.primary_op_tmpl,
+		.primary_op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->program_opcode, 0),
+					      SPI_MEM_OP_ADDR(nor->addr_width, 0, 0),
+					      SPI_MEM_OP_NO_DUMMY,
+					      SPI_MEM_OP_DATA_OUT(0, NULL, 0)),
 		.offset = 0,
 		.length = nor->mtd.size,
 	};
-	struct spi_mem_op *op = &info.op_tmpl;
+	struct spi_mem_op *op = info.op_tmpl;
 
 	/* get transfer protocols. */
 	spi_nor_setup_op(nor, op, nor->write_proto);
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 7bc889c9629..d568b19058f 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -401,15 +401,15 @@ static ssize_t spi_nor_read_data(struct spi_nor *nor, loff_t from, size_t len,
 		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
 
 		if (CONFIG_IS_ENABLED(SPI_DIRMAP) && nor->dirmap.rdesc) {
-			/*
-			 * Record current operation information which may be used
-			 * when the address or data length exceeds address mapping.
-			 */
-			memcpy(&nor->dirmap.rdesc->info.op_tmpl, &op,
-			       sizeof(struct spi_mem_op));
+			struct spi_mem_op *tmp;
+
+			/* temporary use another dirmap template */
+			tmp = nor->dirmap.rdesc->info.op_tmpl;
+			nor->dirmap.rdesc->info.op_tmpl = &op;
 			ret = spi_mem_dirmap_read(nor->dirmap.rdesc,
 						  op.addr.val, op.data.nbytes,
 						  op.data.buf.in);
+			nor->dirmap.rdesc->info.op_tmpl = tmp;
 			if (ret < 0)
 				return ret;
 			op.data.nbytes = ret;
@@ -447,10 +447,14 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
 	spi_nor_setup_op(nor, &op, nor->write_proto);
 
 	if (CONFIG_IS_ENABLED(SPI_DIRMAP) && nor->dirmap.wdesc) {
-		memcpy(&nor->dirmap.wdesc->info.op_tmpl, &op,
-		       sizeof(struct spi_mem_op));
+		struct spi_mem_op *tmp;
+
+		/* temporary use another dirmap template */
+		tmp = nor->dirmap.wdesc->info.op_tmpl;
+		nor->dirmap.wdesc->info.op_tmpl = &op;
 		op.data.nbytes = spi_mem_dirmap_write(nor->dirmap.wdesc, op.addr.val,
 						      op.data.nbytes, op.data.buf.out);
+		nor->dirmap.wdesc->info.op_tmpl = tmp;
 	} else {
 		ret = spi_mem_adjust_op_size(nor->spi, &op);
 		if (ret)
diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 769ec956793..30feaca25e6 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -545,7 +545,7 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (desc->info.length > SPI_NAND_CACHE_SIZE)
 		return -E2BIG;
 
-	if (!airoha_snand_supports_op(desc->slave, &desc->info.op_tmpl))
+	if (!airoha_snand_supports_op(desc->slave, desc->info.op_tmpl))
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -565,7 +565,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	if (!priv->dma) {
 		/* simplified version of spi_mem_no_dirmap_read() */
-		struct spi_mem_op op = desc->info.op_tmpl;
+		struct spi_mem_op op = *desc->info.op_tmpl;
 
 		op.addr.val = desc->info.offset + offs;
 		op.data.buf.in = buf;
@@ -584,7 +584,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
 	 * replace them with supported opcodes.
 	 */
-	opcode = desc->info.op_tmpl.cmd.opcode;
+	opcode = desc->info.op_tmpl->cmd.opcode;
 	switch (opcode) {
 	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE:
 	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST:
@@ -767,7 +767,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 
 	if (!priv->dma) {
 		/* simplified version of spi_mem_no_dirmap_write() */
-		struct spi_mem_op op = desc->info.op_tmpl;
+		struct spi_mem_op op = *desc->info.op_tmpl;
 
 		op.addr.val = desc->info.offset + offs;
 		op.data.buf.out = buf;
@@ -782,7 +782,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	/* minimum oob size is 64 */
 	bytes = round_up(offs + len, 64);
 
-	opcode = desc->info.op_tmpl.cmd.opcode;
+	opcode = desc->info.op_tmpl->cmd.opcode;
 	switch (opcode) {
 	case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
 	case SPI_NAND_OP_PROGRAM_LOAD_RAMDOM_SINGLE:
diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index fb773c44fec..b6f3bd0685b 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -982,13 +982,13 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	struct aspeed_spi_priv *priv = dev_get_priv(bus);
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
 	const struct aspeed_spi_info *info = priv->info;
-	struct spi_mem_op op_tmpl = desc->info.op_tmpl;
+	struct spi_mem_op op_tmpl = *desc->info.op_tmpl;
 	u32 i;
 	u32 cs = slave_plat->cs[0];
 	u32 cmd_io_conf;
 	uintptr_t ce_ctrl_reg;
 
-	if (desc->info.op_tmpl.data.dir == SPI_MEM_DATA_OUT) {
+	if (desc->info.op_tmpl->data.dir == SPI_MEM_DATA_OUT) {
 		/*
 		 * dirmap_write is not supported currently due to a HW
 		 * limitation for command write mode: The written data
@@ -1058,12 +1058,12 @@ static ssize_t aspeed_spi_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	int ret;
 
 	dev_dbg(dev, "read op:0x%x, addr:0x%llx, len:0x%zx\n",
-		desc->info.op_tmpl.cmd.opcode, offs, len);
+		desc->info.op_tmpl->cmd.opcode, offs, len);
 
 	if (priv->flashes[cs].ahb_decoded_sz < offs + len ||
 	    (offs % 4) != 0) {
 		ret = aspeed_spi_exec_op_user_mode(desc->slave,
-						   &desc->info.op_tmpl);
+						   desc->info.op_tmpl);
 		if (ret != 0)
 			return 0;
 	} else {
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 1c23f3d8843..351ca725524 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -572,7 +572,7 @@ EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
 static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
-	struct spi_mem_op op = desc->info.op_tmpl;
+	struct spi_mem_op op = *desc->info.op_tmpl;
 	int ret;
 
 	op.addr.val = desc->info.offset + offs;
@@ -592,7 +592,7 @@ static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 static ssize_t spi_mem_no_dirmap_write(struct spi_mem_dirmap_desc *desc,
 				       u64 offs, size_t len, const void *buf)
 {
-	struct spi_mem_op op = desc->info.op_tmpl;
+	struct spi_mem_op op = *desc->info.op_tmpl;
 	int ret;
 
 	op.addr.val = desc->info.offset + offs;
@@ -632,11 +632,11 @@ spi_mem_dirmap_create(struct spi_slave *slave,
 	int ret = -EOPNOTSUPP;
 
 	/* Make sure the number of address cycles is between 1 and 8 bytes. */
-	if (!info->op_tmpl.addr.nbytes || info->op_tmpl.addr.nbytes > 8)
+	if (!info->primary_op_tmpl.addr.nbytes || info->primary_op_tmpl.addr.nbytes > 8)
 		return ERR_PTR(-EINVAL);
 
 	/* data.dir should either be SPI_MEM_DATA_IN or SPI_MEM_DATA_OUT. */
-	if (info->op_tmpl.data.dir == SPI_MEM_NO_DATA)
+	if (info->primary_op_tmpl.data.dir == SPI_MEM_NO_DATA)
 		return ERR_PTR(-EINVAL);
 
 	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
@@ -645,12 +645,13 @@ spi_mem_dirmap_create(struct spi_slave *slave,
 
 	desc->slave = slave;
 	desc->info = *info;
+	desc->info.op_tmpl = &desc->info.primary_op_tmpl;
 	if (ops->mem_ops && ops->mem_ops->dirmap_create)
 		ret = ops->mem_ops->dirmap_create(desc);
 
 	if (ret) {
 		desc->nodirmap = true;
-		if (!spi_mem_supports_op(desc->slave, &desc->info.op_tmpl))
+		if (!spi_mem_supports_op(desc->slave, &desc->info.primary_op_tmpl))
 			ret = -EOPNOTSUPP;
 		else
 			ret = 0;
@@ -778,7 +779,7 @@ ssize_t spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	struct dm_spi_ops *ops = spi_get_ops(bus);
 	ssize_t ret;
 
-	if (desc->info.op_tmpl.data.dir != SPI_MEM_DATA_IN)
+	if (desc->info.op_tmpl->data.dir != SPI_MEM_DATA_IN)
 		return -EINVAL;
 
 	if (!len)
@@ -818,7 +819,7 @@ ssize_t spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	struct dm_spi_ops *ops = spi_get_ops(bus);
 	ssize_t ret;
 
-	if (desc->info.op_tmpl.data.dir != SPI_MEM_DATA_OUT)
+	if (desc->info.op_tmpl->data.dir != SPI_MEM_DATA_OUT)
 		return -EINVAL;
 
 	if (!len)
diff --git a/include/spi-mem.h b/include/spi-mem.h
index 8c20feebfca..81166492da2 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -211,7 +211,8 @@ struct spi_mem_op {
  * direction is directly encoded in the ->op_tmpl.data.dir field.
  */
 struct spi_mem_dirmap_info {
-	struct spi_mem_op op_tmpl;
+	struct spi_mem_op *op_tmpl;
+	struct spi_mem_op primary_op_tmpl;
 	u64 offset;
 	u64 length;
 };
-- 
2.53.0


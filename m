Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45B8606A880
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 01:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hxflCtTf;
	dkim=pass (2048-bit key, unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=hgHdM7bN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 818F340672;
	Wed, 18 Nov 2026 01:26:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3abdIbanlsJ2; Wed, 18 Nov 2026 01:26:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB44140881
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794965160;
	b=dcvHrt0WkkIrY7J00SKp9E4Jhk/w3aOUqieUaDBC/zXV6UK8XvqT1wAmIgNrlXt7sEUg
	 6u+OueqhuJbaB7WNczDqJSWP0J4+jpIsbG/MCeOHWCWTpE+Anm34gzcQ+Zus3jxJ7zeqn
	 2X8XKxQwUzIewVkO6atEwIfYhKun3H7AlvRf+2VcbyxehN8d1VT5N2Jd0I8AOtYlaM9oH
	 ObW5KVt1sBv7yFILX8ErnjQajYDdxZtSXtRlznzw+tE8j0QA0iPq9tmDcjDJGvBl0lEZ9
	 antegeM+FVoZb4MzmHGAIXWCxFIZyYapka+osHGyaEpcMJdTOIBjo7CuN1OUryn/Nfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794965160;
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
	bh=5ieIsC19GBRNKeoB4yvDZLL3Ek9L6VXzgwRVeCVM4lE=;
	b=o94amRTPA9mfFxXsRCx+htxv8c+X4wO5hSxJde/Bn1WV4IZZmQq8fds69JYgc3ZGTr3s
	 C/cyoQtBLtg68oOgvsJP8l6aP+I9ABTCywWWyrf+KRoZVd2kxc+KlTqwnFmcalxHgaJCU
	 zk02YoK84rWmnkMPeZe1ku6V9/udoHnabQxw4/cnE/EN4vqkzJSFO+cwe/VoQ2QuIDK1s
	 yfTvtIC8Ozvce3vv7wlBEGt16PM1Yk5ogrL3P7SU5ejQit0B5/5SUN/2V6EpTBNPmJl1p
	 ZYgBukdmBemTgrrGFUh8fJIy60mYLZ2+zGUjLCcMj3BkpfE9tRCK8XFjcVMEZGU7pTQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=iopsys.eu;
	dkim=pass header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=hgHdM7bN;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794965160;
	bh=5ieIsC19GBRNKeoB4yvDZLL3Ek9L6VXzgwRVeCVM4lE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hxflCtTfOnGO31toIwPWp8TkW3oE2SWiPwODSoQ0+qRcdO5arZ24OjDCWuC+6vd+n
	 igri9on1C1FoRl8Skyp2Z1s+1r3YqiNN28d4Q9QWtB6Ab0bqfknV+stFZ1sQ+Byjyh
	 NxC8ireABOvYGD62+SoNpXY2NRyijCmIFfCf3yLSkK6mAWnnjoGXUCixXel+hC9yj3
	 wDOipQbUES4UYzuz2vRjUXCD4khgdrHoR2TDZ7g9VcMmyPKpnAOOQ7Zqh+ZkH3Kovt
	 QpSIEf8SOZmgEsRaH1v23m8RdbtaXKfDOw0P6fIWi7eVvEKKbk1ug0cMiNjjdEzF8p
	 +FanJ4LtoGGNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB44140881;
	Wed, 18 Nov 2026 01:26:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3004C49B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 164F5405B7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:05:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rrA54bFW_wxB for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 22:05:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 29D4C40598
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=hgHdM7bN
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 29D4C40598
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ieIsC19GBRNKeoB4yvDZLL3Ek9L6VXzgwRVeCVM4lE=;
 b=hgHdM7bNfg9dT/iY3YokvU5kixlTz3OSYPdnuh+lSYP9KXkZhL3jS/gQR9ZHtdFa9XQZWS2+SpLZNMdpqrryhUUtPymiqj0nKYy71EVqPz8JjEuwfnOGXaZxVqF+C3RtSr+0ChyjwYpij+103gVQcrLMTCgywbs6xFfM4rKGDIe3/G8djEsO/u46zufvRZSg1K4sn7XZHbfWGSEINL6ukhcUV0zyrzst6qJLWrnXc657FtdLEHjVz6BStzkjuancwJFctHBSYl3XA6uGSf4eTc6L2dUJjrEiT0t19FOeiuyOAqw222LjtTSYIanhb4+6+WTH02r0TCzQn3rFLgBAcA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AMDPR08MB892675.eurprd08.prod.outlook.com (2603:10a6:20b:749::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:05:25 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:05:25 +0000
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
Subject: [PATCH v2 6/6] mtd: spinand: update flash drivers to match linux-7.3
 release
Date: Wed, 18 Nov 2026 01:04:49 +0300
Message-ID: <20261117220449.3134408-7-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AMDPR08MB892675:EE_
X-MS-Office365-Filtering-Correlation-Id: af911d63-7503-4d85-9595-08df44f6e1e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|52116014|23010399003|366016|18002099003|6133799003|22082099003|261009223027099003|3023799007|921020|11063799006|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|38350700014|10067099003;
X-Microsoft-Antispam-Message-Info: fVhGbPcsi7woLaL3iE7JdRUlA4Y7p4mfgr5wz23gOB3n9Ayws/1DS2WkRsWMp8Y6gzFNCgf5H3BmxtUNjsy0iUNtDRC/TKZ14Ct48zzwDG1FxZ4lxle3ng6psEdOcjSDGr1WyymvLLrafA0JWUoyxdGUzQ3+LSUsLH9+68/9xmCWKiiEYlqOCFl8oKCA3QqHVdMk66d+id1/uAFAvLc9QhxV46P+gqd9jdwJ+vI98LMd1Q4EkN9p0Fe4+5hyt+x1RBsgaK55HdyZOQpQ9vp8Q04dzp6XJPc1Mwt15QK3t0EP79hGE2XT0+KzS/bL1TuyYmUbTed4Qf6/wBIOiAEl4HrBLALNknJb0xf6wbIKyCzgd7BpwKFQJdc7i991r9q9ORQG+LySf59iZnXLzchMD0/53fRkY2MIX/2nVFOAKkpVCd+UNt/cpQQwmLGGLzd+8IcqCX1diWnoLaKjAIZrVUW+9SkKfhsvJZkqYxN1+vCAiP3FOj3bClZJYABanHqkykoWyNRvZUdsGcJwpEQz5cB7JkPnK5Sj8TiGtFVqhzxYBKiFaGj5UlYDci04DHtIq0ZZ+I5qM5i/0dCAaCqwfmy6RbThnvzBUtl9cHKRSbX1kByXxFko9lntuK0pRKj2pplj4jjFROKca0JD7McpBKi3NgVEELjPHshCZ4gFmrK/EygxDFb851twinOIlB1ARsMKRO1SWLYawvnsjCQxu8B1eOlj4NM5SYVr1MzYW0UzZm9Z/HNUhcjM8C1aowbN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(23010399003)(366016)(18002099003)(6133799003)(22082099003)(261009223027099003)(3023799007)(921020)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(38350700014)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+AZLBkoAacCsOAXAP4GwvrB84tRTRoV1Dw98Yc3bDIx2nlPIECBbzWaEkx81?=
 =?us-ascii?Q?oXVIXO3l/DvXSsClK0+VkNRL4XkwNXa+qiQ2JlyiclzgwSNwTGPPRV+CkdXi?=
 =?us-ascii?Q?jZ6rd8erKcj+tTV0b84zVuPxBZesQZN7qdMAHC8fefFjB/nFndpme1GFEaB7?=
 =?us-ascii?Q?8lTdp/Uma6svtJnBbO7OwocebWnW2jEzml8zkUABosVBX/WUHb1JtuRyxZe4?=
 =?us-ascii?Q?gOyJf+PnAr1bjhdMrDMebC/yItyq6eNw75IEAczPa1KPpcML4vMoBSfNF8Bg?=
 =?us-ascii?Q?uRx38x6Y380P/s9mba5vwsOVNcGSfjwBWzeBDs5GvIJno+IjEDgwf9UXQAYk?=
 =?us-ascii?Q?ILwoDiQTd50hzlTWtvVM91pDKXtQORYZRCu0112HxXqRMfAsb/Ra1LKWHKhq?=
 =?us-ascii?Q?qKu4ydPv8p5y65QkSlVOC0h4S5CHxOjq2YNoFX/yvUFsEHtJRucKykwAJ7ty?=
 =?us-ascii?Q?ev3tj/uhvSrzORK42nrz7mzRZ5WfRxOhNwtUYwoCTg+G/DCcSfXu0YmSOIrL?=
 =?us-ascii?Q?0scD9z06uuR4NSIG8oAVrN75v5L+g4CUobD8bqar8Fd60L/EeBnqL/k5Vjp5?=
 =?us-ascii?Q?JEsAOL1S3WelNp3Ylk0UcRWlh2+C5rVXqQm95PdqTTIq6dZ3YmV6B06HKuIT?=
 =?us-ascii?Q?IxZfmobV5u1pRW6H79kRYm/5/pIGSoMERcJwZuQkbrnJWnB1s75NYWd9Nyuk?=
 =?us-ascii?Q?z6QXTmEb/H3z2qlHU7loBrtQCBRTBkiesbK6Q52TJAYqRUuXcRz15g1/0Ffr?=
 =?us-ascii?Q?yLtbeVUNpJAVvdHksWyBRv4qauQhriqW1Q0wpghk0Syg5z8mJ2BxjNVSBvRn?=
 =?us-ascii?Q?myXdoSriWBvAw4ogL0g4sX0IFT6sChItnOTnzjGQPMj4MQvuQJtnh9rvZwKU?=
 =?us-ascii?Q?EF8uOx+SPsctUKqp9FU321diyDWPqm0L0V+v7aQJPYPz8pNTGvDkLXoKsSOB?=
 =?us-ascii?Q?JTOLQtQlSX/MTmSmmWOY+3knAVeEErTQl3mMJXGiWoelEYE9A8fYu8XT8kx3?=
 =?us-ascii?Q?lW7rfTSEOOaqgXytCgUdPEB6iwp4tQG7lBBtRa6q5HB5ow9GvgPlXpgueSyv?=
 =?us-ascii?Q?l4wB/eryp3e4MCWApiAfrAWv51SgXkJG94bd3F5pfS/DQ7r7B2syamEF2Jwp?=
 =?us-ascii?Q?/EPa+CD62h1XcQ+7j5to4gwcj4rJNrCGkoKo9ePOy1K8g+Cl0/qjVIUBQ77G?=
 =?us-ascii?Q?zpYuwds+3MMu+GqsozXJqPA2avPXLztFNJQoXZAPvG8ca+FdUt1ATArlfFz8?=
 =?us-ascii?Q?PqK/q8AXd07jBnuzcMHyJTxt5twHdhmIW60RETVgX76EtOTEk0RUvsmydx0+?=
 =?us-ascii?Q?igCdgmDcilcRTIKYtFYKP0SEDaCch6uVWN0ZuuXMucOD2N0KCIbCsxWBv1M8?=
 =?us-ascii?Q?NSKgYDIqy1ZVI6/RM+t8Bx5Z9OcKXP51TKSVcJcwwF9nsCWfTIaAsf/avuyV?=
 =?us-ascii?Q?I/WzACzgugEFKF7HpZvWHpG3iM+DGzBB6Pyi+YgocLcTI6qCWYjUDrTLpxR/?=
 =?us-ascii?Q?ucieiIdi2P8xce9/Zk8W3GBQ2C9zEwp+6ITMgfCVEoQ3f/MEcL5NkiaCd1XG?=
 =?us-ascii?Q?BwSVjGIZUFQOVCyTlgWx/PwWsL91la+I8c0Y6bpWNnKWMSl6J5aUPhLov8DS?=
 =?us-ascii?Q?EWCiB4GoV2tfdrSIPBsVRL9TIBwFkhQAQCZtU2uWbtjrdndfRtnWGCDMfJoV?=
 =?us-ascii?Q?KnU58MlQ8/SiagkNmVp3RbCeHGiu+2bkCWhTiw2XvtVXfxHIdmzGkVZ/EN1d?=
 =?us-ascii?Q?N2Cdsez8RWkKg3gxbEwNPhu5fgH19RI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: af911d63-7503-4d85-9595-08df44f6e1e1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:05:25.3761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dmVPvC3XAYuQNnYqlXHnMs3i9TTWcUDWpIh/6hSD5WEdJn/ld0cwN/MrJo1Zte6kCUJG4+ynSmipCtrDMiHPYaX+oPy/yf/WuRJvjQl+WI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB892675
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

changes:
 * fixes
 * octal DTR support
 * randomizer support
 * continuous mode improvements
 * more flashes supported

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/Makefile     |   5 +-
 drivers/mtd/nand/spi/core.c       |   3 +
 drivers/mtd/nand/spi/dosilicon.c  |  93 ++++++
 drivers/mtd/nand/spi/esmt.c       |  26 +-
 drivers/mtd/nand/spi/fmsh.c       |  72 +++++
 drivers/mtd/nand/spi/foresee.c    |  34 +++
 drivers/mtd/nand/spi/gigadevice.c | 109 ++++++-
 drivers/mtd/nand/spi/heyangtek.c  | 132 +++++++++
 drivers/mtd/nand/spi/macronix.c   |  83 +++++-
 drivers/mtd/nand/spi/winbond.c    | 463 ++++++++++++++++++++++++------
 include/linux/mtd/spinand.h       |   3 +
 11 files changed, 911 insertions(+), 112 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/dosilicon.c
 create mode 100644 drivers/mtd/nand/spi/heyangtek.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index a7a0b2cb4b9..106c2d121bc 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 spinand-objs := core.o otp.o
-spinand-objs += alliancememory.o ato.o esmt.o fmsh.o foresee.o gigadevice.o macronix.o
-spinand-objs += micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
+spinand-objs += alliancememory.o ato.o dosilicon.o esmt.o fmsh.o foresee.o
+spinand-objs += gigadevice.o heyangtek.o macronix.o micron.o paragon.o
+spinand-objs += skyhigh.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index ef899772752..6b623738120 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1366,10 +1366,13 @@ static const struct nand_ops spinand_ops = {
 static const struct spinand_manufacturer *spinand_manufacturers[] = {
 	&alliancememory_spinand_manufacturer,
 	&ato_spinand_manufacturer,
+	&dosilicon_spinand_manufacturer,
+	&esmt_8c_spinand_manufacturer,
 	&esmt_c8_spinand_manufacturer,
 	&fmsh_spinand_manufacturer,
 	&foresee_spinand_manufacturer,
 	&gigadevice_spinand_manufacturer,
+	&heyangtek_spinand_manufacturer,
 	&macronix_spinand_manufacturer,
 	&micron_spinand_manufacturer,
 	&paragon_spinand_manufacturer,
diff --git a/drivers/mtd/nand/spi/dosilicon.c b/drivers/mtd/nand/spi/dosilicon.c
new file mode 100644
index 00000000000..fb6677fc9f3
--- /dev/null
+++ b/drivers/mtd/nand/spi/dosilicon.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Ahmed Naseef <naseefkm@gmail.com>
+ */
+
+#ifndef __UBOOT__
+#include <linux/device.h>
+#include <linux/kernel.h>
+#endif
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_DOSILICON        0xE5
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
+
+static int ds35xx_ooblayout_ecc(struct mtd_info *mtd, int section,
+				struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = 8 + (section * 16);
+	region->length = 8;
+
+	return 0;
+}
+
+static int ds35xx_ooblayout_free(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	if (section == 0) {
+		/* reserve 2 bytes for the BBM */
+		region->offset = 2;
+		region->length = 6;
+	} else {
+		region->offset = section * 16;
+		region->length = 8;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops ds35xx_ooblayout = {
+	.ecc = ds35xx_ooblayout_ecc,
+	.rfree = ds35xx_ooblayout_free,
+};
+
+static const struct spinand_info dosilicon_spinand_table[] = {
+	SPINAND_INFO("DS35Q1GA",
+		SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x71),
+		NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		NAND_ECCREQ(4, 512),
+		SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					 &write_cache_variants,
+					 &update_cache_variants),
+		SPINAND_HAS_QE_BIT,
+		SPINAND_ECCINFO(&ds35xx_ooblayout, NULL)),
+	SPINAND_INFO("DS35M1GA",
+		SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x21),
+		NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		NAND_ECCREQ(4, 512),
+		SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					 &write_cache_variants,
+					 &update_cache_variants),
+		SPINAND_HAS_QE_BIT,
+		SPINAND_ECCINFO(&ds35xx_ooblayout, NULL)),
+};
+
+static const struct spinand_manufacturer_ops dosilicon_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer dosilicon_spinand_manufacturer = {
+	.id = SPINAND_MFR_DOSILICON,
+	.name = "Dosilicon",
+	.chips = dosilicon_spinand_table,
+	.nchips = ARRAY_SIZE(dosilicon_spinand_table),
+	.ops = &dosilicon_spinand_manuf_ops,
+};
diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
index 631b9e241be..1bfb13bd764 100644
--- a/drivers/mtd/nand/spi/esmt.c
+++ b/drivers/mtd/nand/spi/esmt.c
@@ -17,6 +17,7 @@
 
 /* ESMT uses GigaDevice 0xc8 JECDEC ID on some SPI NANDs */
 #define SPINAND_MFR_ESMT_C8			0xc8
+#define SPINAND_MFR_ESMT_8C			0x8c
 
 #define ESMT_F50L1G41LB_CFG_OTP_PROTECT		BIT(7)
 #define ESMT_F50L1G41LB_CFG_OTP_LOCK		\
@@ -189,6 +190,21 @@ static const struct spinand_fact_otp_ops f50l1g41lb_fact_otp_ops = {
 	.read = spinand_fact_otp_read,
 };
 
+
+static const struct spinand_info esmt_8c_spinand_table[] = {
+	SPINAND_INFO("F50L1G41LC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x2C),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL),
+		     SPINAND_USER_OTP_INFO(28, 2, &f50l1g41lb_user_otp_ops),
+		     SPINAND_FACT_OTP_INFO(2, 0, &f50l1g41lb_fact_otp_ops)),
+};
+
 static const struct spinand_info esmt_c8_spinand_table[] = {
 	SPINAND_INFO("F50L1G41LB",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01, 0x7f,
@@ -204,7 +220,7 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
 		     SPINAND_FACT_OTP_INFO(2, 0, &f50l1g41lb_fact_otp_ops)),
 	SPINAND_INFO("F50D1G41LB",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x11, 0x7f,
-				0x7f),
+				0x7f, 0x7f),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -229,6 +245,14 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
 static const struct spinand_manufacturer_ops esmt_spinand_manuf_ops = {
 };
 
+const struct spinand_manufacturer esmt_8c_spinand_manufacturer = {
+	.id = SPINAND_MFR_ESMT_8C,
+	.name = "ESMT",
+	.chips = esmt_8c_spinand_table,
+	.nchips = ARRAY_SIZE(esmt_8c_spinand_table),
+	.ops = &esmt_spinand_manuf_ops,
+};
+
 const struct spinand_manufacturer esmt_c8_spinand_manufacturer = {
 	.id = SPINAND_MFR_ESMT_C8,
 	.name = "ESMT",
diff --git a/drivers/mtd/nand/spi/fmsh.c b/drivers/mtd/nand/spi/fmsh.c
index dc6c3fc358d..f0d691fa44b 100644
--- a/drivers/mtd/nand/spi/fmsh.c
+++ b/drivers/mtd/nand/spi/fmsh.c
@@ -21,6 +21,13 @@
 	#define FM25G01B_STATUS_ECC_8_BITFLIPS		(6 << 4)
 	#define FM25G01B_STATUS_ECC_UNCOR_ERROR		(7 << 4)
 
+#define FM25S01BI3_STATUS_ECC_MASK		(7 << 4)
+	#define FM25S01BI3_STATUS_ECC_NO_BITFLIPS	(0 << 4)
+	#define FM25S01BI3_STATUS_ECC_1_3_BITFLIPS	(1 << 4)
+	#define FM25S01BI3_STATUS_ECC_UNCOR_ERROR	(2 << 4)
+	#define FM25S01BI3_STATUS_ECC_4_6_BITFLIPS	(3 << 4)
+	#define FM25S01BI3_STATUS_ECC_7_8_BITFLIPS	(5 << 4)
+
 #define SPINAND_MFR_FMSH		0xA1
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
@@ -125,6 +132,56 @@ static int fm25s01a_ooblayout_free(struct mtd_info *mtd, int section,
 	return 0;
 }
 
+static int fm25s01bi3_ecc_get_status(struct spinand_device *spinand,
+				     u8 status)
+{
+	switch (status & FM25S01BI3_STATUS_ECC_MASK) {
+	case FM25S01BI3_STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case FM25S01BI3_STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	case FM25S01BI3_STATUS_ECC_1_3_BITFLIPS:
+		return 3;
+
+	case FM25S01BI3_STATUS_ECC_4_6_BITFLIPS:
+		return 6;
+
+	case FM25S01BI3_STATUS_ECC_7_8_BITFLIPS:
+		return 8;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int fm25s01bi3_ooblayout_ecc(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	region->offset = 64;
+	region->length = 64;
+
+	return 0;
+}
+
+static int fm25s01bi3_ooblayout_free(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = (16 * section) + 4;
+	region->length = 12;
+
+	return 0;
+}
+
 static const struct mtd_ooblayout_ops fm25g01b_ooblayout = {
 	.ecc = fm25g01b_ooblayout_ecc,
 	.rfree = fm25g01b_ooblayout_free,
@@ -135,6 +192,11 @@ static const struct mtd_ooblayout_ops fm25s01a_ooblayout = {
 	.rfree = fm25s01a_ooblayout_free,
 };
 
+static const struct mtd_ooblayout_ops fm25s01bi3_ooblayout = {
+	.ecc = fm25s01bi3_ooblayout_ecc,
+	.rfree = fm25s01bi3_ooblayout_free,
+};
+
 static const struct spinand_info fmsh_spinand_table[] = {
 	SPINAND_INFO("FM25G01B",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xd1),
@@ -165,6 +227,16 @@ static const struct spinand_info fmsh_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&fm25s01a_ooblayout, NULL)),
+	SPINAND_INFO("FM25S01BI3",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xd4),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&fm25s01bi3_ooblayout,
+				      fm25s01bi3_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops fmsh_spinand_manuf_ops = {
diff --git a/drivers/mtd/nand/spi/foresee.c b/drivers/mtd/nand/spi/foresee.c
index 370f8494fb5..986f77426e5 100644
--- a/drivers/mtd/nand/spi/foresee.c
+++ b/drivers/mtd/nand/spi/foresee.c
@@ -13,6 +13,11 @@
 
 #define SPINAND_MFR_FORESEE		0xCD
 
+#define F35SQB002G_STATUS_ECC_MASK		(7 << 4)
+#define F35SQB002G_STATUS_ECC_NO_BITFLIPS	(0 << 4)
+#define F35SQB002G_STATUS_ECC_1_3_BITFLIPS	(1 << 4)
+#define F35SQB002G_STATUS_ECC_UNCOR_ERROR	(7 << 4)
+
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
@@ -72,6 +77,25 @@ static int f35sqa002g_ecc_get_status(struct spinand_device *spinand, u8 status)
 	return -EBADMSG;
 }
 
+static int f35sqb002g_ecc_get_status(struct spinand_device *spinand, u8 status)
+{
+	switch (status & F35SQB002G_STATUS_ECC_MASK) {
+	case F35SQB002G_STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case F35SQB002G_STATUS_ECC_1_3_BITFLIPS:
+		return 3;
+
+	case F35SQB002G_STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	default: /* (2 << 4) through (6 << 4) are 4-8 corrected errors */
+		return ((status & F35SQB002G_STATUS_ECC_MASK) >> 4) + 2;
+	}
+
+	return -EINVAL;
+}
+
 static const struct spinand_info foresee_spinand_table[] = {
 	SPINAND_INFO("F35SQA002G",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x72, 0x72),
@@ -93,6 +117,16 @@ static const struct spinand_info foresee_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&f35sqa002g_ooblayout,
 				     f35sqa002g_ecc_get_status)),
+	SPINAND_INFO("F35SQB002G",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x52, 0x52),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&f35sqa002g_ooblayout,
+				     f35sqb002g_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops foresee_spinand_manuf_ops = {
diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index 5e6ae0b184f..081d54fbbc5 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -6,9 +6,12 @@
  *   Copyright (c) 2016-2017 Micron Technology, Inc.
  */
 
+#include <linux/bitfield.h>
 #ifndef __UBOOT__
 #include <linux/device.h>
 #include <linux/kernel.h>
+#else
+#include <linux/bug.h>
 #endif
 #include <linux/mtd/spinand.h>
 
@@ -27,6 +30,18 @@
 #define GD5FXGQ4UXFXXG_STATUS_ECC_1_3_BITFLIPS	(1 << 4)
 #define GD5FXGQ4UXFXXG_STATUS_ECC_UNCOR_ERROR	(7 << 4)
 
+/* Feature bit definitions */
+#define GD_FEATURE_NR	BIT(3)	/* Normal Read(1=normal,0=continuous) */
+#define GD_FEATURE_CRDC	BIT(2)	/* Continuous Read Dummy */
+
+/* ECC status extraction helpers */
+#define GD_ECCSR_LAST_PAGE(eccsr)	FIELD_GET(GENMASK(3, 0), eccsr)
+#define GD_ECCSR_ACCUMULATED(eccsr)	FIELD_GET(GENMASK(7, 4), eccsr)
+
+struct gigadevice_priv {
+	bool continuous_read;
+};
+
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
@@ -67,6 +82,74 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
+static int gd5fxgm9_get_eccsr(struct spinand_device *spinand, u8 *eccsr)
+{
+	struct gigadevice_priv *priv = spinand->priv;
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(0x7c, 1),
+					SPI_MEM_OP_NO_ADDR,
+					SPI_MEM_OP_DUMMY(1, 1),
+					SPI_MEM_OP_DATA_IN(1, eccsr, 1));
+	int ret;
+
+	ret = spi_mem_exec_op(spinand->slave, &op);
+	if (ret)
+		return ret;
+
+	if (priv->continuous_read)
+		*eccsr = GD_ECCSR_ACCUMULATED(*eccsr);
+	else
+		*eccsr = GD_ECCSR_LAST_PAGE(*eccsr);
+
+	return 0;
+}
+
+static int gd5fxgm9_ecc_get_status(struct spinand_device *spinand, u8 status)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	u8 eccsr;
+	int ret;
+
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case GD5FXGQ4XA_STATUS_ECC_1_7_BITFLIPS:
+		ret = gd5fxgm9_get_eccsr(spinand, spinand->scratchbuf);
+		if (ret)
+			return nanddev_get_ecc_conf(nand)->strength;
+
+		eccsr = *spinand->scratchbuf;
+		if (WARN_ON(!eccsr || eccsr > nanddev_get_ecc_conf(nand)->strength))
+			return nanddev_get_ecc_conf(nand)->strength;
+
+		return eccsr;
+
+	case GD5FXGQ4XA_STATUS_ECC_8_BITFLIPS:
+		return 8;
+
+	case STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int gd5fxgm9_set_continuous_read(struct spinand_device *spinand, bool enable)
+{
+	struct gigadevice_priv *priv = spinand->priv;
+	int ret;
+
+	ret = spinand_upd_cfg(spinand, GD_FEATURE_NR,
+				enable ? 0 : GD_FEATURE_NR);
+	if (ret)
+		return ret;
+
+	priv->continuous_read = enable;
+
+	return 0;
+}
+
 static int gd5fxgq4xa_ooblayout_ecc(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *region)
 {
@@ -546,7 +629,8 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
-				     gd5fxgq4uexxg_ecc_get_status)),
+				     gd5fxgm9_ecc_get_status),
+			SPINAND_CONT_READ(gd5fxgm9_set_continuous_read)),
 	SPINAND_INFO("GD5F1GM9RExxG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x81, 0x01),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
@@ -556,10 +640,31 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
-				     gd5fxgq4uexxg_ecc_get_status)),
+				     gd5fxgm9_ecc_get_status),
+			SPINAND_CONT_READ(gd5fxgm9_set_continuous_read)),
 };
 
+static int gd5fxgm9_spinand_init(struct spinand_device *spinand)
+{
+	struct gigadevice_priv *priv;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spinand->priv =  priv;
+
+	return 0;
+}
+
+static void gd5fxgm9_spinand_cleanup(struct spinand_device *spinand)
+{
+	kfree(spinand->priv);
+}
+
 static const struct spinand_manufacturer_ops gigadevice_spinand_manuf_ops = {
+	.init = gd5fxgm9_spinand_init,
+	.cleanup = gd5fxgm9_spinand_cleanup,
 };
 
 const struct spinand_manufacturer gigadevice_spinand_manufacturer = {
diff --git a/drivers/mtd/nand/spi/heyangtek.c b/drivers/mtd/nand/spi/heyangtek.c
new file mode 100644
index 00000000000..c1eacf5d41f
--- /dev/null
+++ b/drivers/mtd/nand/spi/heyangtek.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Authors:
+ *	Andrey Zolotarev <andrey.zolotarev@keenetic.com> - the main driver logic
+ *	Aleksei Sviridkin <f@lex.la> - adaptation to the mainline Linux kernel
+ *
+ * Based on:
+ *	https://github.com/keenetic/kernel-49/commit/bacade569fb12bc0ad31ba09bca9b890118fbca7
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_HEYANGTEK			0xc9
+
+#define HYF1GQ4_STATUS_ECC_LIMIT_BITFLIPS	(3 << 4)
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
+
+/*
+ * HYF1GQ4UDACAE is a GD5F1GQ4-compatible die, so the OOB layout is taken
+ * from gd5fxgq4xa: the on-die ECC parity occupies bytes 8..15 of each
+ * 16-byte section, the bad block marker sits in byte 0 and the remaining
+ * bytes are exposed as free.
+ */
+static int hyf1gq4_ooblayout_ecc(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = (16 * section) + 8;
+	region->length = 8;
+
+	return 0;
+}
+
+static int hyf1gq4_ooblayout_free(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	if (section) {
+		region->offset = 16 * section;
+		region->length = 8;
+	} else {
+		/* section 0 has one byte reserved for the bad block marker */
+		region->offset = 1;
+		region->length = 7;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops hyf1gq4_ooblayout = {
+	.ecc = hyf1gq4_ooblayout_ecc,
+	.rfree = hyf1gq4_ooblayout_free,
+};
+
+static int hyf1gq4_ecc_get_status(struct spinand_device *spinand, u8 status)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	case STATUS_ECC_HAS_BITFLIPS:
+		/*
+		 * The die exposes only a coarse 2-bit ECC status and has no
+		 * register for the exact bitflip count. This code means
+		 * "corrected, below the refresh threshold", so report half of
+		 * the ECC strength as a representative value.
+		 */
+		return nanddev_get_ecc_conf(nand)->strength / 2;
+
+	case HYF1GQ4_STATUS_ECC_LIMIT_BITFLIPS:
+		/*
+		 * "Corrected, refresh recommended": report the full ECC
+		 * strength so the upper layers relocate the data.
+		 */
+		return nanddev_get_ecc_conf(nand)->strength;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static const struct spinand_info heyangtek_spinand_table[] = {
+	SPINAND_INFO("HYF1GQ4UDACAE",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x21),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&hyf1gq4_ooblayout,
+				     hyf1gq4_ecc_get_status)),
+};
+
+static const struct spinand_manufacturer_ops heyangtek_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer heyangtek_spinand_manufacturer = {
+	.id = SPINAND_MFR_HEYANGTEK,
+	.name = "HeYangTek",
+	.chips = heyangtek_spinand_table,
+	.nchips = ARRAY_SIZE(heyangtek_spinand_table),
+	.ops = &heyangtek_spinand_manuf_ops,
+};
diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index e2114b7b546..753bf88cd6f 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -17,6 +17,8 @@
 #define MACRONIX_ECCSR_BF_LAST_PAGE(eccsr) FIELD_GET(GENMASK(3, 0), eccsr)
 #define MACRONIX_ECCSR_BF_ACCUMULATED_PAGES(eccsr) FIELD_GET(GENMASK(7, 4), eccsr)
 #define MACRONIX_CFG_CONT_READ         BIT(2)
+#define MACRONIX_CFG_RANDOMIZER_EN     BIT(1)
+#define MACRONIX_FEATURE_ADDR_RANDOMIZER 0x10
 #define MACRONIX_FEATURE_ADDR_READ_RETRY 0x70
 #define MACRONIX_NUM_READ_RETRY_MODES 5
 
@@ -44,6 +46,23 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
+#define SPINAND_MACRONIX_READ_ECCSR_1S_0_1S(buf)			\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x7c, 1),				\
+		   SPI_MEM_OP_NO_ADDR,					\
+		   SPI_MEM_OP_DUMMY(1, 1),				\
+		   SPI_MEM_OP_DATA_IN(1, buf, 1))
+
+static SPINAND_OP_VARIANTS(macronix_ops,
+		SPINAND_MACRONIX_READ_ECCSR_1S_0_1S(NULL));
+
+static struct spi_mem_op
+spinand_fill_macronix_read_eccsr_op(struct spinand_device *spinand, void *valptr)
+{
+	WARN_ON_ONCE(spinand->bus_iface != SSDR);
+
+	return (struct spi_mem_op)SPINAND_MACRONIX_READ_ECCSR_1S_0_1S(valptr);
+}
+
 static int mx35lfxge4ab_ooblayout_ecc(struct mtd_info *mtd, int section,
 				      struct mtd_oob_region *region)
 {
@@ -70,12 +89,10 @@ static const struct mtd_ooblayout_ops mx35lfxge4ab_ooblayout = {
 static int macronix_get_eccsr(struct spinand_device *spinand, u8 *eccsr)
 {
 	struct macronix_priv *priv = spinand->priv;
-	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(0x7c, 1),
-					  SPI_MEM_OP_NO_ADDR,
-					  SPI_MEM_OP_DUMMY(1, 1),
-					  SPI_MEM_OP_DATA_IN(1, eccsr, 1));
+	struct spi_mem_op op = SPINAND_OP(spinand, macronix_read_eccsr, eccsr);
+	int ret;
 
-	int ret = spi_mem_exec_op(spinand->slave, &op);
+	ret = spi_mem_exec_op(spinand->slave, &op);
 	if (ret)
 		return ret;
 
@@ -158,6 +175,12 @@ static int macronix_set_read_retry(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->slave, &op);
 }
 
+static int macronix_set_randomizer(struct spinand_device *spinand, bool enable)
+{
+	return spinand_write_reg_op(spinand, MACRONIX_FEATURE_ADDR_RANDOMIZER,
+				    enable ? MACRONIX_CFG_RANDOMIZER_EN : 0);
+}
+
 static const struct spinand_info macronix_spinand_table[] = {
 	SPINAND_INFO("MX35LF1GE4AB",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x12),
@@ -167,6 +190,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX35LF2GE4AB",
@@ -188,6 +212,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_CONT_READ(macronix_set_cont_read),
@@ -201,6 +226,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_CONT_READ(macronix_set_cont_read),
@@ -216,7 +242,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+		     SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35LF2G24AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x24, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
@@ -228,7 +255,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+		     SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35LF2G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x64, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
@@ -239,7 +267,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+		     SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35LF4G24AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 2, 1, 1),
@@ -251,7 +280,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+		     SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35LF4G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x75, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -262,7 +292,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+		     SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX31LF1GE4BC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x1e),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
@@ -271,6 +302,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX31UF1GE4BC",
@@ -281,6 +313,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 
@@ -294,6 +327,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT |
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT |
 		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX35UF4G24AD",
@@ -305,10 +339,12 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT |
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+		     SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35UF4G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xf5, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -317,10 +353,12 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+		     SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35UF4GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb7, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -329,6 +367,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_CONT_READ(macronix_set_cont_read),
@@ -344,6 +383,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT |
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT |
 		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX35UF2G24AD",
@@ -355,10 +395,12 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT |
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+		     SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35UF2G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xe4, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
@@ -367,10 +409,12 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+		     SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35UF2GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa6, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
@@ -379,6 +423,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_CONT_READ(macronix_set_cont_read),
@@ -392,6 +437,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_CONT_READ(macronix_set_cont_read)),
@@ -403,6 +449,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX35UF1G24AD",
@@ -413,10 +460,12 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
-					macronix_set_read_retry)),
+					macronix_set_read_retry),
+		     SPINAND_RANDOMIZER(macronix_set_randomizer)),
 	SPINAND_INFO("MX35UF1GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x96, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
@@ -425,6 +474,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_CONT_READ(macronix_set_cont_read),
@@ -438,6 +488,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_CONT_READ(macronix_set_cont_read)),
@@ -449,6 +500,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX3UF2GE4BC",
@@ -459,6 +511,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 };
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 7c457da3991..9bd835fd44b 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -20,20 +20,121 @@
 
 #define SPINAND_MFR_WINBOND		0xEF
 
+#define WINBOND_CFG_HFREQ		BIT(0)
 #define WINBOND_CFG_BUF_READ		BIT(3)
 
 #define W25N04KV_STATUS_ECC_5_8_BITFLIPS	(3 << 4)
+#define W25W35NXXJW_STATUS_ECC_MULT_UNCOR	(3 << 4)
 
 #define W25N0XJW_SR4			0xD0
 #define W25N0XJW_SR4_HS			BIT(2)
 
-#define W35N01JW_VCR_IO_MODE			0x00
+#define W35N01JW_VCR_IO_MODE_REG	0x00
 #define W35N01JW_VCR_IO_MODE_SINGLE_SDR		0xFF
 #define W35N01JW_VCR_IO_MODE_OCTAL_SDR		0xDF
 #define W35N01JW_VCR_IO_MODE_OCTAL_DDR_DS	0xE7
 #define W35N01JW_VCR_IO_MODE_OCTAL_DDR		0xC7
 #define W35N01JW_VCR_DUMMY_CLOCK_REG	0x01
 
+/*
+ * Winbond chips ignore the address bytes during continuous reads, and
+ * because the dummy cycles are enough they indicate dropping the
+ * address cycles from the continuous read from cache variants. This is
+ * very poorly supported by SPI controller drivers which are "wired" to
+ * always at least provide the column. Keep using address cycles, but
+ * reduce the number of dummy cycles accordingly.
+ */
+#define WINBOND_CONT_READ_FROM_CACHE_FAST_1S_1S_1S_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0b, 1),				\
+		   SPI_MEM_OP_ADDR(1, 0, 1),				\
+		   SPI_MEM_OP_DUMMY(ndummy - 1, 1),			\
+		   SPI_MEM_OP_DATA_IN(len, buf, 1),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define WINBOND_CONT_READ_FROM_CACHE_1S_1D_1D_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0d, 1),				\
+		   SPI_MEM_DTR_OP_ADDR(2, 0, 1),			\
+		   SPI_MEM_DTR_OP_DUMMY(ndummy, 1),			\
+		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 1),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define WINBOND_CONT_READ_FROM_CACHE_1S_1S_2S_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x3b, 1),				\
+		   SPI_MEM_OP_ADDR(1, 0, 1),				\
+		   SPI_MEM_OP_DUMMY(ndummy - 1, 1),			\
+		   SPI_MEM_OP_DATA_IN(len, buf, 2),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define WINBOND_CONT_READ_FROM_CACHE_1S_2S_2S_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0xbb, 1),				\
+		   SPI_MEM_OP_ADDR(1, 0, 2),				\
+		   SPI_MEM_OP_DUMMY(ndummy - 1, 2),			\
+		   SPI_MEM_OP_DATA_IN(len, buf, 2),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define WINBOND_CONT_READ_FROM_CACHE_1S_2D_2D_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0xbd, 1),				\
+		   SPI_MEM_DTR_OP_ADDR(1, 0, 2),			\
+		   SPI_MEM_DTR_OP_DUMMY(ndummy - 1, 2),			\
+		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 2),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define WINBOND_CONT_READ_FROM_CACHE_1S_1S_4S_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x6b, 1),				\
+		   SPI_MEM_OP_ADDR(1, 0, 1),				\
+		   SPI_MEM_OP_DUMMY(ndummy - 1, 1),			\
+		   SPI_MEM_OP_DATA_IN(len, buf, 4),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define WINBOND_CONT_READ_FROM_CACHE_1S_1D_4D_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x6d, 1),				\
+		   SPI_MEM_DTR_OP_ADDR(1, 0, 1),			\
+		   SPI_MEM_DTR_OP_DUMMY(ndummy - 1, 1),			\
+		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 4),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define WINBOND_CONT_READ_FROM_CACHE_1S_4S_4S_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0xeb, 1),				\
+		   SPI_MEM_OP_ADDR(1, 0, 4),				\
+		   SPI_MEM_OP_DUMMY(ndummy - 1, 4),			\
+		   SPI_MEM_OP_DATA_IN(len, buf, 4),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define WINBOND_CONT_READ_FROM_CACHE_1S_4D_4D_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0xed, 1),				\
+		   SPI_MEM_DTR_OP_ADDR(1, 0, 4),			\
+		   SPI_MEM_DTR_OP_DUMMY(ndummy - 1, 4),			\
+		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 4),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define WINBOND_CONT_READ_FROM_CACHE_1S_1S_8S_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x8b, 1),				\
+		   SPI_MEM_OP_ADDR(1, 0, 1),				\
+		   SPI_MEM_OP_DUMMY(ndummy - 1, 1),			\
+		   SPI_MEM_OP_DATA_IN(len, buf, 8),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define WINBOND_CONT_READ_FROM_CACHE_1S_1D_8D_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x9d, 1),				\
+		   SPI_MEM_DTR_OP_ADDR(1, 0, 1),			\
+		   SPI_MEM_DTR_OP_DUMMY(ndummy - 1, 1),			\
+		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 8),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define WINBOND_CONT_READ_FROM_CACHE_1S_8S_8S_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0xcb, 1),				\
+		   SPI_MEM_OP_ADDR(1, 0, 8),				\
+		   SPI_MEM_OP_DUMMY(ndummy - 1, 8),			\
+		   SPI_MEM_OP_DATA_IN(len, buf, 8),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define WINBOND_CONT_READ_FROM_CACHE_8D_8D_8D_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_DTR_OP_RPT_CMD(0x9d, 8),			\
+		   SPI_MEM_DTR_OP_ADDR(2, 0, 8),			\
+		   SPI_MEM_DTR_OP_DUMMY(ndummy - 2, 8),			\
+		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 8),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
 /*
  * "X2" in the core is equivalent to "dual output" in the datasheets,
  * "X4" in the core is equivalent to "quad output" in the datasheets.
@@ -41,6 +142,8 @@
  */
 
 static SPINAND_OP_VARIANTS(read_cache_octal_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_8D_8D_8D_OP(0, 24, NULL, 0, 120 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_8D_8D_8D_OP(0, 16, NULL, 0, 86 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_8D_OP(0, 3, NULL, 0, 120 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_8D_OP(0, 2, NULL, 0, 105 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_8S_8S_OP(0, 20, NULL, 0, 0),
@@ -52,12 +155,27 @@ static SPINAND_OP_VARIANTS(read_cache_octal_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
 
+static SPINAND_OP_VARIANTS(cont_read_cache_octal_variants,
+		WINBOND_CONT_READ_FROM_CACHE_8D_8D_8D_OP(24, NULL, 0, 120 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_8D_8D_8D_OP(16, NULL, 0, 86 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_1D_8D_OP(3, NULL, 0, 120 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_1D_8D_OP(2, NULL, 0, 105 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_8S_8S_OP(20, NULL, 0, 0),
+		WINBOND_CONT_READ_FROM_CACHE_1S_8S_8S_OP(16, NULL, 0, 162 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_8S_8S_OP(12, NULL, 0, 124 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_8S_8S_OP(8, NULL, 0, 86 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_1S_8S_OP(2, NULL, 0, 0),
+		WINBOND_CONT_READ_FROM_CACHE_1S_1S_8S_OP(1, NULL, 0, 133 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_FAST_1S_1S_1S_OP(1, NULL, 0, 0));
+
 static SPINAND_OP_VARIANTS(write_cache_octal_variants,
+		SPINAND_PROG_LOAD_8D_8D_8D_OP(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_8S_8S_OP(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_8S_OP(0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_octal_variants,
+		SPINAND_PROG_LOAD_8D_8D_8D_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_8S_8S_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
@@ -76,6 +194,20 @@ static SPINAND_OP_VARIANTS(read_cache_dual_quad_dtr_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 54 * HZ_PER_MHZ));
 
+static SPINAND_OP_VARIANTS(cont_read_cache_dual_quad_dtr_variants,
+		WINBOND_CONT_READ_FROM_CACHE_1S_4D_4D_OP(11, NULL, 0, 80 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_1D_4D_OP(5, NULL, 0, 80 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_4S_4S_OP(7, NULL, 0, 0),
+		WINBOND_CONT_READ_FROM_CACHE_1S_4S_4S_OP(6, NULL, 0, 104 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_1S_4S_OP(4, NULL, 0, 0),
+		WINBOND_CONT_READ_FROM_CACHE_1S_2D_2D_OP(6, NULL, 0, 80 * HZ_PER_MHZ),
+		/* The 1S_1D_2D variant would require 4.5 dummy bytes, this is not possible */
+		WINBOND_CONT_READ_FROM_CACHE_1S_2S_2S_OP(5, NULL, 0, 0),
+		WINBOND_CONT_READ_FROM_CACHE_1S_2S_2S_OP(4, NULL, 0, 104 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_1S_2S_OP(4, NULL, 0, 0),
+		/* The 1S_1D_1D variant would require 4.5 dummy bytes, this is not possible */
+		WINBOND_CONT_READ_FROM_CACHE_FAST_1S_1S_1S_OP(4, NULL, 0, 0));
+
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
@@ -92,6 +224,47 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
+#define SPINAND_WINBOND_WRITE_VCR_1S_1S_1S(reg, buf)			\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x81, 1),				\
+		   SPI_MEM_OP_ADDR(3, reg, 1),				\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_DATA_OUT(1, buf, 1))
+
+#define SPINAND_WINBOND_WRITE_VCR_8D_8D_8D(reg, buf)			\
+	SPI_MEM_OP(SPI_MEM_DTR_OP_RPT_CMD(0x81, 8),			\
+		   SPI_MEM_DTR_OP_ADDR(4, reg << 8, 8),			\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_DTR_OP_DATA_OUT(2, buf, 8))
+
+static SPINAND_OP_VARIANTS(winbond_w35_ops,
+		SPINAND_WINBOND_WRITE_VCR_1S_1S_1S(0, NULL),
+		SPINAND_WINBOND_WRITE_VCR_8D_8D_8D(0, NULL));
+
+static struct spi_mem_op
+spinand_fill_winbond_write_vcr_op(struct spinand_device *spinand, u8 reg, void *valptr)
+{
+	return (spinand->bus_iface == SSDR) ?
+		(struct spi_mem_op)SPINAND_WINBOND_WRITE_VCR_1S_1S_1S(reg, valptr) :
+		(struct spi_mem_op)SPINAND_WINBOND_WRITE_VCR_8D_8D_8D(reg, valptr);
+}
+
+#define SPINAND_WINBOND_SELECT_TARGET_1S_0_1S(buf)			\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0xc2, 1),				\
+		   SPI_MEM_OP_NO_ADDR,					\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_DATA_OUT(1, buf, 1))
+
+static SPINAND_OP_VARIANTS(winbond_w25_ops,
+		SPINAND_WINBOND_SELECT_TARGET_1S_0_1S(NULL));
+
+static struct spi_mem_op
+spinand_fill_winbond_select_target_op(struct spinand_device *spinand, void *valptr)
+{
+	WARN_ON_ONCE(spinand->bus_iface != SSDR);
+
+	return (struct spi_mem_op)SPINAND_WINBOND_SELECT_TARGET_1S_0_1S(valptr);
+}
+
 static int w25m02gv_ooblayout_ecc(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *region)
 {
@@ -124,12 +297,8 @@ static const struct mtd_ooblayout_ops w25m02gv_ooblayout = {
 static int w25m02gv_select_target(struct spinand_device *spinand,
 				  unsigned int target)
 {
-	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(0xc2, 1),
-					  SPI_MEM_OP_NO_ADDR,
-					  SPI_MEM_OP_NO_DUMMY,
-					  SPI_MEM_OP_DATA_OUT(1,
-							spinand->scratchbuf,
-							1));
+	struct spi_mem_op op = SPINAND_OP(spinand, winbond_select_target,
+					  spinand->scratchbuf);
 
 	*spinand->scratchbuf = target;
 	return spi_mem_exec_op(spinand->slave, &op);
@@ -181,6 +350,36 @@ static const struct mtd_ooblayout_ops w25n02kv_ooblayout = {
 	.rfree = w25n02kv_ooblayout_free,
 };
 
+static int w25n01jw_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = (16 * section) + 12;
+	region->length = 4;
+
+	return 0;
+}
+
+static int w25n01jw_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = (16 * section);
+	region->length = 12;
+
+	/* Extract BBM */
+	if (!section) {
+		region->offset += 2;
+		region->length -= 2;
+	}
+
+	return 0;
+}
+
 static int w35n01jw_ooblayout_ecc(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *region)
 {
@@ -211,6 +410,11 @@ static int w35n01jw_ooblayout_free(struct mtd_info *mtd, int section,
 	return 0;
 }
 
+static const struct mtd_ooblayout_ops w25n01jw_ooblayout = {
+	.ecc = w25n01jw_ooblayout_ecc,
+	.rfree = w25n01jw_ooblayout_free,
+};
+
 static const struct mtd_ooblayout_ops w35n01jw_ooblayout = {
 	.ecc = w35n01jw_ooblayout_ecc,
 	.rfree = w35n01jw_ooblayout_free,
@@ -255,51 +459,90 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 	return -EINVAL;
 }
 
-static int w25n0xjw_hs_cfg(struct spinand_device *spinand,
-			   enum spinand_bus_interface iface)
+static int w25w35nxxjw_ecc_get_status(struct spinand_device *spinand, u8 status)
 {
-	const struct spi_mem_op *op;
-	bool hs;
-	u8 sr4;
-	int ret;
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
 
-	if (iface != SSDR)
-		return -EOPNOTSUPP;
+	case STATUS_ECC_HAS_BITFLIPS:
+		return 1;
 
-	op = spinand->op_templates->read_cache;
-	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
-		hs = false;
-	else if (op->cmd.buswidth == 1 && op->addr.buswidth == 1 &&
-		 op->dummy.buswidth == 1 && op->data.buswidth == 1)
-		hs = false;
-	else if (!op->max_freq)
-		hs = true;
-	else
-		hs = false;
+	case STATUS_ECC_UNCOR_ERROR:
+	case W25W35NXXJW_STATUS_ECC_MULT_UNCOR:
+		return -EBADMSG;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int w25n0xjw_set_sr4_hs(struct spinand_device *spinand, bool enable)
+{
+	int ret;
+	u8 sr4;
 
 	ret = spinand_read_reg_op(spinand, W25N0XJW_SR4, &sr4);
 	if (ret)
 		return ret;
 
-	if (hs)
+	if (enable)
 		sr4 |= W25N0XJW_SR4_HS;
 	else
 		sr4 &= ~W25N0XJW_SR4_HS;
 
-	ret = spinand_write_reg_op(spinand, W25N0XJW_SR4, sr4);
-	if (ret)
-		return ret;
+	return spinand_write_reg_op(spinand, W25N0XJW_SR4, sr4);
+}
 
-	return 0;
+/*
+ * SDR dual and quad I/O operations over 104MHz require the HS bit to
+ * enable a few more dummy cycles.
+ */
+static bool w25n0xjw_op_needs_hs(const struct spi_mem_op *op)
+{
+	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
+		return false;
+	else if (op->cmd.buswidth != 1 || op->addr.buswidth == 1)
+		return false;
+	else if (op->max_freq && op->max_freq <= 104 * HZ_PER_MHZ)
+		return false;
+
+	return true;
+}
+
+static int w25n0xjw_hs_cfg(struct spinand_device *spinand,
+			   enum spinand_bus_interface iface)
+{
+	const struct spi_mem_op *op;
+
+	if (iface != SSDR)
+		return -EOPNOTSUPP;
+
+	/*
+	 * At this stage, we do not yet know the continuous read template, nor
+	 * if there is going to be one. Let's assume the continuous read
+	 * template will be selected with the same heuristics as the buffered
+	 * read variant, as there cannot be a HS configuration mismatch between
+	 * them.
+	 */
+	op = spinand->op_templates->read_cache;
+
+	return w25n0xjw_set_sr4_hs(spinand, w25n0xjw_op_needs_hs(op));
+}
+
+static int w25n0xjw_set_cont_read(struct spinand_device *spinand, bool enable)
+{
+	u8 mask = enable ? 0 : WINBOND_CFG_BUF_READ;
+
+	return spinand_upd_cfg(spinand, WINBOND_CFG_BUF_READ, mask);
 }
 
 static int w35n0xjw_write_vcr(struct spinand_device *spinand, u8 reg, u8 val)
 {
-	struct spi_mem_op op =
-		SPI_MEM_OP(SPI_MEM_OP_CMD(0x81, 1),
-			   SPI_MEM_OP_ADDR(3, reg, 1),
-			   SPI_MEM_OP_NO_DUMMY,
-			   SPI_MEM_OP_DATA_OUT(1, spinand->scratchbuf, 1));
+	struct spi_mem_op op = SPINAND_OP(spinand, winbond_write_vcr,
+					  reg, spinand->scratchbuf);
 	int ret;
 
 	*spinand->scratchbuf = val;
@@ -325,33 +568,25 @@ static int w35n0xjw_write_vcr(struct spinand_device *spinand, u8 reg, u8 val)
 static int w35n0xjw_vcr_cfg(struct spinand_device *spinand,
 			    enum spinand_bus_interface iface)
 {
-	const struct spi_mem_op *op;
+	const struct spi_mem_op *ref_op;
 	unsigned int dummy_cycles;
 	bool dtr, single;
 	u8 io_mode;
 	int ret;
 
-	if (iface != SSDR)
+	switch (iface) {
+	case SSDR:
+		ref_op = spinand->ssdr_op_templates.read_cache;
+		break;
+	case ODTR:
+		ref_op = spinand->odtr_op_templates.read_cache;
+		break;
+	default:
 		return -EOPNOTSUPP;
+	}
 
-	op = spinand->op_templates->read_cache;
-
-	single = (op->cmd.buswidth == 1 && op->addr.buswidth == 1 && op->data.buswidth == 1);
-	dtr = (op->cmd.dtr || op->addr.dtr || op->data.dtr);
-	if (single && !dtr)
-		io_mode = W35N01JW_VCR_IO_MODE_SINGLE_SDR;
-	else if (!single && !dtr)
-		io_mode = W35N01JW_VCR_IO_MODE_OCTAL_SDR;
-	else if (!single && dtr)
-		io_mode = W35N01JW_VCR_IO_MODE_OCTAL_DDR;
-	else
-		return -EINVAL;
-
-	ret = w35n0xjw_write_vcr(spinand, W35N01JW_VCR_IO_MODE, io_mode);
-	if (ret)
-		return ret;
-
-	dummy_cycles = ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
+	dummy_cycles = ((ref_op->dummy.nbytes * 8) / ref_op->dummy.buswidth) /
+		(ref_op->dummy.dtr ? 2 : 1);
 	switch (dummy_cycles) {
 	case 8:
 	case 12:
@@ -363,13 +598,43 @@ static int w35n0xjw_vcr_cfg(struct spinand_device *spinand,
 	default:
 		return -EINVAL;
 	}
+
 	ret = w35n0xjw_write_vcr(spinand, W35N01JW_VCR_DUMMY_CLOCK_REG, dummy_cycles);
 	if (ret)
 		return ret;
 
+	single = (ref_op->cmd.buswidth == 1 &&
+		  ref_op->addr.buswidth == 1 &&
+		  ref_op->data.buswidth == 1);
+	dtr = (ref_op->cmd.dtr && ref_op->addr.dtr && ref_op->data.dtr);
+	if (single && !dtr)
+		io_mode = W35N01JW_VCR_IO_MODE_SINGLE_SDR;
+	else if (!single && !dtr)
+		io_mode = W35N01JW_VCR_IO_MODE_OCTAL_SDR;
+	else if (!single && dtr)
+		io_mode = W35N01JW_VCR_IO_MODE_OCTAL_DDR;
+	else
+		return -EINVAL;
+
+	ret = w35n0xjw_write_vcr(spinand, W35N01JW_VCR_IO_MODE_REG, io_mode);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
+static int w35n0xjw_set_cont_read(struct spinand_device *spinand, bool enable)
+{
+	const struct spi_mem_op *cont_op = spinand->op_templates->cont_read_cache;
+	u8 mask = enable ? 0 : WINBOND_CFG_BUF_READ;
+
+	if (cont_op && enable && spinand_op_is_odtr(cont_op) &&
+	    cont_op->max_freq >= 90 * HZ_PER_MHZ)
+		mask |= WINBOND_CFG_HFREQ;
+
+	return spinand_upd_cfg(spinand, WINBOND_CFG_BUF_READ | WINBOND_CFG_HFREQ, mask);
+}
+
 static const struct spinand_info winbond_spinand_table[] = {
 	/* 512M-bit densities */
 	SPINAND_INFO("W25N512GW", /* 1.8V */
@@ -404,12 +669,14 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xbc, 0x21),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_dual_quad_dtr_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
-		     0,
-		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
-		     SPINAND_CONFIGURE_CHIP(w25n0xjw_hs_cfg)),
+		     SPINAND_INFO_OP_VARIANTS_WITH_CONT(&read_cache_dual_quad_dtr_variants,
+							&write_cache_variants,
+							&update_cache_variants,
+							&cont_read_cache_dual_quad_dtr_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&w25n01jw_ooblayout, w25w35nxxjw_ecc_get_status),
+		     SPINAND_CONFIGURE_CHIP(w25n0xjw_hs_cfg),
+		     SPINAND_CONT_READ(w25n0xjw_set_cont_read)),
 	SPINAND_INFO("W25N01KV", /* 3.3V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xae, 0x21),
 		     NAND_MEMORG(1, 2048, 96, 64, 1024, 20, 1, 1, 1),
@@ -423,32 +690,15 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdc, 0x21),
 		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
-					      &write_cache_octal_variants,
-					      &update_cache_octal_variants),
+		     SPINAND_INFO_OP_VARIANTS_WITH_CONT(&read_cache_octal_variants,
+							&write_cache_octal_variants,
+							&update_cache_octal_variants,
+							&cont_read_cache_octal_variants),
 		     0,
-		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
-		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
-	SPINAND_INFO("W35N02JW", /* 1.8V */
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x22),
-		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 2, 1),
-		     NAND_ECCREQ(1, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
-					      &write_cache_octal_variants,
-					      &update_cache_octal_variants),
-		     0,
-		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
-		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
-	SPINAND_INFO("W35N04JW", /* 1.8V */
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x23),
-		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 4, 1),
-		     NAND_ECCREQ(1, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
-					      &write_cache_octal_variants,
-					      &update_cache_octal_variants),
-		     0,
-		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
-		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
+		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, w25w35nxxjw_ecc_get_status),
+		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg),
+		     SPINAND_CONT_READ(w35n0xjw_set_cont_read)),
 	/* 2G-bit densities */
 	SPINAND_INFO("W25M02GV", /* 2x1G-bit 3.3V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xab, 0x21),
@@ -458,18 +708,21 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
+		     SPINAND_INFO_VENDOR_OPS(&winbond_w25_ops),
 		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
 		     SPINAND_SELECT_TARGET(w25m02gv_select_target)),
 	SPINAND_INFO("W25N02JW", /* high-speed 1.8V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xbf, 0x22),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 2, 1),
 		     NAND_ECCREQ(1, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_dual_quad_dtr_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
-		     0,
-		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
-		     SPINAND_CONFIGURE_CHIP(w25n0xjw_hs_cfg)),
+		     SPINAND_INFO_OP_VARIANTS_WITH_CONT(&read_cache_dual_quad_dtr_variants,
+							&write_cache_variants,
+							&update_cache_variants,
+							&cont_read_cache_dual_quad_dtr_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&w25m02gv_ooblayout, w25w35nxxjw_ecc_get_status),
+		     SPINAND_CONFIGURE_CHIP(w25n0xjw_hs_cfg),
+		     SPINAND_CONT_READ(w25n0xjw_set_cont_read)),
 	SPINAND_INFO("W25N02KV", /* 3.3V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x22),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
@@ -488,6 +741,19 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W35N02JW", /* 1.8V */
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x22),
+		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 2, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS_WITH_CONT(&read_cache_octal_variants,
+							&write_cache_octal_variants,
+							&update_cache_octal_variants,
+							&cont_read_cache_octal_variants),
+		     SPINAND_ODTR_PACKED_PAGE_READ,
+		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, w25w35nxxjw_ecc_get_status),
+		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg),
+		     SPINAND_CONT_READ(w35n0xjw_set_cont_read)),
 	/* 4G-bit densities */
 	SPINAND_INFO("W25N04KV", /* 3.3V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x23),
@@ -507,6 +773,19 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W35N04JW", /* 1.8V */
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x23),
+		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 4, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS_WITH_CONT(&read_cache_octal_variants,
+							&write_cache_octal_variants,
+							&update_cache_octal_variants,
+							&cont_read_cache_octal_variants),
+		     SPINAND_ODTR_PACKED_PAGE_READ,
+		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, w25w35nxxjw_ecc_get_status),
+		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg),
+		     SPINAND_CONT_READ(w35n0xjw_set_cont_read)),
 };
 
 static int winbond_spinand_init(struct spinand_device *spinand)
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 4bdbb397826..270958b8101 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -437,10 +437,13 @@ struct spinand_manufacturer {
 /* SPI NAND manufacturers */
 extern const struct spinand_manufacturer alliancememory_spinand_manufacturer;
 extern const struct spinand_manufacturer ato_spinand_manufacturer;
+extern const struct spinand_manufacturer dosilicon_spinand_manufacturer;
+extern const struct spinand_manufacturer esmt_8c_spinand_manufacturer;
 extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
 extern const struct spinand_manufacturer fmsh_spinand_manufacturer;
 extern const struct spinand_manufacturer foresee_spinand_manufacturer;
 extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
+extern const struct spinand_manufacturer heyangtek_spinand_manufacturer;
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
 extern const struct spinand_manufacturer micron_spinand_manufacturer;
 extern const struct spinand_manufacturer paragon_spinand_manufacturer;
-- 
2.53.0


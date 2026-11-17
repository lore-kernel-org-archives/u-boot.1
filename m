Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06795606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 01:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dfxCZNIh;
	dkim=pass (2048-bit key, unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=kZ3uOjg5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B816D408F4;
	Wed, 18 Nov 2026 01:26:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j1QirKeO4YaS; Wed, 18 Nov 2026 01:26:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 72FD8408B5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794965171;
	b=XNMwQPF7s+s5KJJ0SWM+OnXa3Vbd22+ddhfvp8x9Plg+yf43kDE/OO/xUclzUHSp4nAW
	 b6f5OfO8E4ovE4FVf8Gj29SS9goEvQ8VYTa5Oe5Gmu9cSdcyIzVyIDhyW4jJP/GCtys9L
	 1YPZeN6AipKJMP8XJLXK17Ni1N7CjU95y4tn1G89/U6u/U9RDi9Iw6tH0kV2PTb6ThW0O
	 zp+vvZqvzSWa1rfWCPEc5h3G6RNFaMKbMYz6ipdH9/qU/RQbAYtkKb0Pm/x4l3xpHc2K5
	 6IVKR/Q8p/rAK2K35Rys9hwSMji43Fvb0hqTyRwee6YzfWCwlHWtlqcV+QCC3afYD7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794965171;
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
	bh=Iv6jjx5kzrqEq7mZigzoPvANsrKwrdXiURFUKhT21cc=;
	b=cn8dZKbRZTdvZ9OgCdr/rlpXcXS+ithDFpJo+4AGKtbMdWbY6FO9DShzdxjr6hIPUOCf
	 xhspD7nkVVV9eZ4Kcbo8D4TvjxffrTDNZUw/jqzlX93T1TWT92T0p4xRL7k+IUqFKYEtp
	 RxLQj9L4m99fcvaarJd5Lo7hdB0BcuoECSG8d1im72ZAx7WOKwLv03zh3FUYfIgKuCDXn
	 CbyufOG2TeJJN4DRVnQOhcE7EE/aDGIra3cXqh2t79D5UlojogshjTrWnerrpZd4w5uPz
	 iZARlSjJGIkgQ1zyh7kz3rij1kEDAC6RyzU30DtyAn+YoSqnZqvLZT1Od9VRRCP7R/Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794965171;
	bh=Iv6jjx5kzrqEq7mZigzoPvANsrKwrdXiURFUKhT21cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dfxCZNIhsxdiTAMSCXoa2JqNSxhDIAKLydDFPYPl4EORB0q1HzXVnhljUpvOjXBYE
	 2ZlBx+3yKSCPCUk1ICGgLrhyAUhr5rfI+mVcgRm+4Hk2jkGWaYC37sx4GLG5OcX3+N
	 HZnfpJHduWAYrr/da3EvDPaKvF8KQarHzM2j39DXIQhSpX5tfqzEYmnqzEMHgOb2qy
	 KsQN/SY9LUzGOlZvTBShJlZgxUM79DrG4qGRgkf9BlZLko+EJ2KPbBHCu8726mtgMl
	 oAnSvxJbIHMltLVfqvois5AGmVbGUZsx/gWTvymW3PSx5ADo8Ri5GSgJvphGNHlPmE
	 FME4rRHS/misw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72FD8408B5;
	Wed, 18 Nov 2026 01:26:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B0E2E1E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:43:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A2BE480C87
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:43:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kdRvlfWtI-Vf for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 22:43:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A8B6380C5C
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
 header.s=selector1 header.b=kZ3uOjg5
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A8B6380C5C
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iv6jjx5kzrqEq7mZigzoPvANsrKwrdXiURFUKhT21cc=;
 b=kZ3uOjg5V2n/ZYO8jCCo7MlUAfNeaHrC5xfJZF8D4XUpmGn05r3KycSMFLTi/ZKfRTaYsa9XunaC8ljdWCpeWj4EkFRII2oyxVrHsPFaYHrT+z/ZxpDBDz5dw7hMi2pO81O7ZiUMCX55eT4/pCJLH/Z7RWxoIh0WyF3gO6L+oentRB0E6QI91DXIWDgV83v6NJeNqxIFeMsJZcbLioMFuz2FXhiU5hi4vH7eWPp3CAhDylnOZOjiDHpzFpKBdiVw2GS7MGzD5QNJ6NPMEDiKKrRtBDQ+4LqGO0fMaH1uIZTSnYaxrGkbc8dixZa8ze0mV++0XH/vZrt/9TNMB9Ce4w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS8PR08MB9291.eurprd08.prod.outlook.com (2603:10a6:20b:5a6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:43:08 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:43:08 +0000
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
Subject: [PATCH v3 4/6] spi: spi-mem: sync code and behavior with linux
Date: Wed, 18 Nov 2026 01:42:34 +0300
Message-ID: <20261117224236.3150882-5-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 4626019d-0358-4799-1254-08df44fc2528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|52116014|376014|7416014|921020|38350700014|10067099003|11063799006|5023799004|56012099006|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261022075727099003|261021121427099003|261022105027099003|261102130727099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NqKtJHg9HY+M3X7MVbSemTxienVG3FOoL90HvuH0ikBPdM4VXXUifsyEXDv05FCDGT2KBOR+hlHWfuJ0M4pajKo+m7HC2GcnSFW+d8mZiCxFUjsacY9m22Y6/XRFxwR9Mz/KF0EgMGQhXojTDpT1mhNkmcPFbepN49eZmvYrJGYf4/SKP0VjoN2c0yOFb5oHfOfPv9GkWGQrgL58rLkSyoMvoFRO3QYqah6GD6LLkdkndEndELrVb0H6An07XCTx2uyZO/PBYczDmf9Dw5JprJnNxRCeaa/6XUt/vA/4Hb9FpiTd5EQgbW54dQPyCCEE2GnAULicFMwixg3OxeDECXkeeX/XINXNM5xLoENfifrk93L3PYRlhahBIE1vL4oPR5rQx/74xgGxR/XjoaxzEtY8bYxCoPFzgfEPBmlqzwA7MHd+DY+rxKjrlxhFHGy4XjgBwhDpy1kDagnRNfSyQSWanMMzWfOVC3wIWINbJjhedOOC34jqzG8DR4XMZ0r6M3YzeBOPzMU3GruUdV3X2y59SKHwv80VQBnN+oCV51VlG7eehXBnhJ2I+VEMZeya+TksnG84kU2eTI/HF//CPeEkiXG95KbMt+ZRaM/YA6om3KHb7ATttm6rsnQhIBZxuGUpVY/2g4VXU+t5IxXAk6Ft4zIQuIi0YcT9/gvaJB1fmFw7Bu3jsj4/cijj58BxshWYGd4tVJbjIvCioZe7mQdIbmMWbYA0iKNeTAnYHHJS5ACFcXwvIzapHjzFVSaS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014)(10067099003)(11063799006)(5023799004)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102130727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Lvui+IfbE6sEU5nNxh5px/5IoVW1eOAAl317RW21HLNqoPzZaP0k8z1y38T?=
 =?us-ascii?Q?SDhuv1je4xeTn70XF7G/d1Ys+7z8ZaiGwM0WKyzv1I5wV3LM7IHRgnTb9ma4?=
 =?us-ascii?Q?/XA6DlYFKOYCuz8EuaMODajmC6RhU+zlZPQQ88p/kq0He5NZR3fgKlrC3nc1?=
 =?us-ascii?Q?vvhurCUjhyvUVdmG0w9SMVTK9xxLdI3NMsgjAr4W6nPJX5IadwZE4EIixkGc?=
 =?us-ascii?Q?Y3xPo+n3ZzTlwHwsSvztN+XgswJCXMl8knp04/ieOQpYmKdpTHNBqIcPH7iC?=
 =?us-ascii?Q?osvnp3CJ1gMlAOF5MkYIKVAfOTIL3loZVlkyVmj4Zw1Ye5LtMIQennxCPrPf?=
 =?us-ascii?Q?Mr3wz2jDDkZOQ+3tHDxE1/VKpUsETmTpc+FI9yqb+ZdjV/1AgD+wJr/2kZxl?=
 =?us-ascii?Q?kgWUsaK2OAVs0ZHoBtA3Q/uFMcdqoJ6AkGpteSwPD5DvOJYb3j/i2jCod6UG?=
 =?us-ascii?Q?WegvBy/lNNWAdP1TyMMK/9gODOKdyVriY+9MiI+Pg2D4eYxC1t9hJp2FI+/F?=
 =?us-ascii?Q?5lz0/HHnq/ZY/+GZnjAW6m3jXCjhaPWR487r93KDZ8538rzKYxzGPv8mvcFj?=
 =?us-ascii?Q?/tujH2wqWiw+PBUStG8AjuyyeUMyy+V9Eqxc/fCLS5RqrSP5rwBx179hWwsU?=
 =?us-ascii?Q?rkOBPKoq5fT8xCtKhyTHlTtl8x52pMeMpaujXMeb3jCreSNF6lneJbxIabyj?=
 =?us-ascii?Q?jhzAO2Lms6CCj6YKpDP4l53/XqlZLMNifH52a2OkbFiixLH4iNwHgE20itEk?=
 =?us-ascii?Q?s9MUa3UHwk7+lnVDOhLNuQaYMJePQHatlUn6eClbMURho0yUpRHqE4aMX1XR?=
 =?us-ascii?Q?MfUIdaNhkhjAH8qgAbHYJvWS/m5N7SQwP9NjDk0i923jgsVnESgOc2xkKPF3?=
 =?us-ascii?Q?8BtK311T/8qJoKJBgW5S6Ix18pRG9PE5j0ldAAQ/Gt6efjLJkZxIW/Z4Ft7Z?=
 =?us-ascii?Q?vtpcixWbENVv+mJxFoN2fv7Acksmmpyh9IoowCoUr+HxIpGUkTM3e8RbbcjP?=
 =?us-ascii?Q?lSmVjU4tstAQtD4KhuhB0vOG7b3ALeGAjc4iA4cd6p3aCACQ+qD9Mxq9VpOL?=
 =?us-ascii?Q?lXTshPLMvu3mEWkRdJisb9thq8GjdwGuwl1/HUyyKbj81FMCDkMbhjXA9T+b?=
 =?us-ascii?Q?TIbd7zq5snLqQ8GouDw7cwGc262IJOaugIIHDyJY43AVEXbNG7TS0Qzpdvj2?=
 =?us-ascii?Q?6Cq1ge7mPHcuWmxhgLNHBXn/rMyQjF0rb72DoLO598FPsUFraGoRgHAsPc/3?=
 =?us-ascii?Q?fhQMcrjcOSqmowdYStJSkWTOyR1vL8/2/0+no9/x2ftiwjo3zB3MwbgwHWn/?=
 =?us-ascii?Q?w0rYGdsBiU+XmLJGRuFCOJCzINWApa7gObkdeSGXa7mnkcL3APPizRVJo6Dz?=
 =?us-ascii?Q?1qvuNc9m9y5w3PhFRtu7/P4h2oDnZ69dwl14wirxGJcoxJWBYG1DIwZipv0I?=
 =?us-ascii?Q?uPUUwEdw8moppXycTsyLjz7g4n6PX1Jof/KE2LkiaJGDDe4NQlk6CjFrG2kG?=
 =?us-ascii?Q?+Y9oZd3V5dp/IM1WZSojwz4iVe1fjnR9NL1bcIYc9UEs0LkAAh0HhFRhg1ud?=
 =?us-ascii?Q?IIMyEKWSKz+AsocApFzNBCVt0ZtuycYvj+VDbs25iEeMnsEWwxaUQOUMzCIv?=
 =?us-ascii?Q?f3C/xvIyhgsRDhADGZ9yOUTg1eF1gj1XM7ObZhO2X4j5eA71kcyCAaVnIWXo?=
 =?us-ascii?Q?ch6gJ2mV6u6JcSDhXdKsZCSfKoPrnYVJ5MCc/D8OLXrYAlatv+eeADIz6N4w?=
 =?us-ascii?Q?r7jLQnLqFj1Lk27UhevFS16OTNL6n2M=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4626019d-0358-4799-1254-08df44fc2528
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:43:05.7121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jo6a+QvP6ZPgFvDbBdwdlBLPra2sCW1njh0ZsT/9dTO3HK+MKz/9VXsulC8YoARC5mecl62iJO14M6nNI8rfJqAmj6DdKPVXCrFTtTuEjz0=
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

Align code and behavior with linux-7.3 release.

Changes:
 * add comments
 * use the same error codes as used in linux
 * add more checks for spi_mem_op
 * add macros necessary for spinand dtr support
 * remove unused macros

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-mem.c | 65 +++++++++++++++++++++++++++++++++++--------
 include/spi-mem.h     | 26 +++++++++++++++--
 2 files changed, 77 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index ee6c9b6f3a2..1367c9d3290 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -22,8 +22,11 @@
 #include <dm/device_compat.h>
 #include <dm/devres.h>
 #include <linux/bug.h>
+#include <linux/bitops.h>
 #endif
 
+#define SPI_MEM_MAX_BUSWIDTH		8
+
 #ifndef __UBOOT__
 /**
  * spi_controller_dma_map_mem_op_data() - DMA-map the buffer attached to a
@@ -213,6 +216,45 @@ bool spi_mem_default_supports_op(struct spi_slave *slave,
 }
 EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
 
+static bool spi_mem_buswidth_is_valid(u8 buswidth)
+{
+	if (hweight8(buswidth) > 1 || buswidth > SPI_MEM_MAX_BUSWIDTH)
+		return false;
+
+	return true;
+}
+
+static int spi_mem_check_op(const struct spi_mem_op *op)
+{
+	if (!op->cmd.buswidth || !op->cmd.nbytes)
+		return -EINVAL;
+
+	if ((op->addr.nbytes && !op->addr.buswidth) ||
+	    (op->dummy.nbytes && !op->dummy.buswidth) ||
+	    (op->data.nbytes && !op->data.buswidth))
+		return -EINVAL;
+
+	if (!spi_mem_buswidth_is_valid(op->cmd.buswidth) ||
+	    !spi_mem_buswidth_is_valid(op->addr.buswidth) ||
+	    !spi_mem_buswidth_is_valid(op->dummy.buswidth) ||
+	    !spi_mem_buswidth_is_valid(op->data.buswidth))
+		return -EINVAL;
+
+	return 0;
+}
+
+static bool spi_mem_internal_supports_op(struct spi_slave *slave,
+					 const struct spi_mem_op *op)
+{
+	struct udevice *bus = slave->dev->parent;
+	struct dm_spi_ops *ops = spi_get_ops(bus);
+
+	if (ops->mem_ops && ops->mem_ops->supports_op)
+		return ops->mem_ops->supports_op(slave, op);
+
+	return spi_mem_default_supports_op(slave, op);
+}
+
 /**
  * spi_mem_supports_op() - Check if a memory device and the controller it is
  *			   connected to support a specific memory operation
@@ -231,13 +273,10 @@ EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
 bool spi_mem_supports_op(struct spi_slave *slave,
 			 const struct spi_mem_op *op)
 {
-	struct udevice *bus = slave->dev->parent;
-	struct dm_spi_ops *ops = spi_get_ops(bus);
-
-	if (ops->mem_ops && ops->mem_ops->supports_op)
-		return ops->mem_ops->supports_op(slave, op);
+	if (spi_mem_check_op(op))
+		return false;
 
-	return spi_mem_default_supports_op(slave, op);
+	return spi_mem_internal_supports_op(slave, op);
 }
 EXPORT_SYMBOL_GPL(spi_mem_supports_op);
 
@@ -265,8 +304,12 @@ int spi_mem_exec_op(struct spi_slave *slave, const struct spi_mem_op *op)
 	int ret;
 	int i;
 
-	if (!spi_mem_supports_op(slave, op))
-		return -ENOTSUPP;
+	ret = spi_mem_check_op(op);
+	if (ret)
+		return ret;
+
+	if (!spi_mem_internal_supports_op(slave, op))
+		return -EOPNOTSUPP;
 
 	ret = spi_claim_bus(slave);
 	if (ret < 0)
@@ -629,7 +672,7 @@ spi_mem_dirmap_create(struct spi_slave *slave,
 	struct udevice *bus = slave->dev->parent;
 	struct dm_spi_ops *ops = spi_get_ops(bus);
 	struct spi_mem_dirmap_desc *desc;
-	int ret = -EOPNOTSUPP;
+	int ret = -ENOTSUPP;
 
 	/* Make sure the number of address cycles is between 1 and 8 bytes. */
 	if (!info->primary_op_tmpl.addr.nbytes || info->primary_op_tmpl.addr.nbytes > 8)
@@ -807,7 +850,7 @@ ssize_t spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	else if (ops->mem_ops && ops->mem_ops->dirmap_read)
 		ret = ops->mem_ops->dirmap_read(desc, offs, len, buf);
 	else
-		ret = -EOPNOTSUPP;
+		ret = -ENOTSUPP;
 
 	return ret;
 }
@@ -847,7 +890,7 @@ ssize_t spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	else if (ops->mem_ops && ops->mem_ops->dirmap_write)
 		ret = ops->mem_ops->dirmap_write(desc, offs, len, buf);
 	else
-		ret = -EOPNOTSUPP;
+		ret = -ENOTSUPP;
 
 	return ret;
 }
diff --git a/include/spi-mem.h b/include/spi-mem.h
index 08d854b1e52..a69fd0d0948 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -22,10 +22,18 @@ struct udevice;
 		.opcode = __opcode,				\
 	}
 
-#define SPI_MEM_DTR_OP_CMD(__opcode, __buswidth)		\
+#define SPI_MEM_DTR_OP_RPT_CMD(__opcode, __buswidth)		\
 	{							\
-		.nbytes = 1,					\
-		.opcode = __opcode,				\
+		.nbytes = 2,					\
+		.opcode = __opcode | __opcode << 8,		\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
+#define SPI_MEM_DTR_OP_PACKED_CMD(__opcode, __addr, __buswidth)	\
+	{							\
+		.nbytes = 2,					\
+		.opcode = __opcode << 8 | __addr,		\
 		.buswidth = __buswidth,				\
 		.dtr = true,					\
 	}
@@ -45,6 +53,14 @@ struct udevice;
 		.dtr = true,					\
 	}
 
+#define SPI_MEM_DTR_OP_RPT_ADDR(__val, __buswidth)		\
+	{							\
+		.nbytes = 2,					\
+		.val = __val | __val << 8,			\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_NO_ADDR	{ }
 
 #define SPI_MEM_OP_DUMMY(__nbytes, __buswidth)			\
@@ -116,11 +132,13 @@ enum spi_mem_data_dir {
 
 /**
  * struct spi_mem_op - describes a SPI memory operation
+ * @cmd: the complete command
  * @cmd.nbytes: number of opcode bytes (only 1 or 2 are valid). The opcode is
  *		sent MSB-first.
  * @cmd.buswidth: number of IO lines used to transmit the command
  * @cmd.opcode: operation opcode
  * @cmd.dtr: whether the command opcode should be sent in DTR mode or not
+ * @addr: the address attributes
  * @addr.nbytes: number of address bytes to send. Can be zero if the operation
  *		 does not need to send an address
  * @addr.buswidth: number of IO lines used to transmit the address cycles
@@ -129,10 +147,12 @@ enum spi_mem_data_dir {
  *	      Note that only @addr.nbytes are taken into account in this
  *	      address value, so users should make sure the value fits in the
  *	      assigned number of bytes.
+ * @dummy: data for dummy operation
  * @dummy.nbytes: number of dummy bytes to send after an opcode or address. Can
  *		  be zero if the operation does not require dummy bytes
  * @dummy.buswidth: number of IO lanes used to transmit the dummy bytes
  * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
+ * @data: the data attributes
  * @data.buswidth: number of IO lanes used to send/receive the data
  * @data.dtr: whether the data should be sent in DTR mode or not
  * @data.ecc: whether error correction is required or not
-- 
2.53.0


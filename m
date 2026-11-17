Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7285F606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 01:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bWFu1Bwg;
	dkim=pass (2048-bit key, unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=EEhlbe7w
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34A0B6086D;
	Wed, 18 Nov 2026 01:25:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LKSVT8NHMVhm; Wed, 18 Nov 2026 01:25:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1FCCB60860
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794965157;
	b=lnF6ea2QhCJ3skHZchuewX1IIfQFYGmLlECW298CLGsNEU3tT4dS+FniGbsnZ1czLyoc
	 OmWR9Cvn7PZsUYG4S/Kacmi8WjepoHaL7jiun5+uZl6qdIhYRFZk2AiW808jsbrLnPET3
	 z9SxBlT7Pr9eXs+YokPY9d5i/cOPZCJmZlSEJh9kdswAnMVOSlTKJxK8G6r1GdQZ30SPr
	 4RIUO/5jlbPKkFiXjFz1+VT8vJZ9hn7AGl03/nLL4O6p4TSF2RLO2GnqdVJOi8cNAj2jg
	 8OJ0riredRX8/dAq2FCFw5zyjNX8bxiInGwY8bJHvA45239kEBBJHPgVI4jlFPnuryA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794965157;
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
	b=bmGaIepnZw+vZvOhdvo+MrcrKKRq+MHsvfjJX/a06gs1HVxea502CkdUKRFIsL1RuOKJ
	 Vw367ByozsNIoPaE5HSmhAHxs56OkketZWX8HrFQq/mwRyM8bh83c6f8hpyIGS/4MZXVx
	 ZD5aMFP02wHL3Sl0zXfa2bGv1ErM0eKY2G9lgdn9U5Y2HN/JdkDhOYgCJHfg6gu5IdVK8
	 GMc2fQjYJYiLkUfoFlU/pn3GVeeBN6xwLlzWEe7K1KCilUzl/d7pJzOHUWrDHPAUgxxxT
	 yTF3lDCQhCyxsdB0BXUXDiBhj8Yn4uk/Tt6Ztx9p0tD/tO3rcsrHJJDsEM2p7CM4yzQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794965157;
	bh=Iv6jjx5kzrqEq7mZigzoPvANsrKwrdXiURFUKhT21cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bWFu1Bwgo0FqIHxzpGyD01ShlvgQyNX5Sl7GIUlIqqjT9wCvxFlBaQQk2JudfJiqc
	 yNrXnQ7KhlGjzj3L0/SzVB/pSQ8+6aErhan6nBbaoX0ZsqBfE3WLYJOpbNcBxjNOW6
	 gRh3NZTFeMvr6cjhRzI0ZapTPsax0YfA7pSUfyll3qlbHjG3TxL2uUGRjurz4qRAKn
	 84TgZuMoqTYyWZZR4HSnZFQS//jxbIsDb3CT/hpNDcvb9AphDAnH7Z/goGmO53BtRL
	 eq+9D9RCAIi2sldafZ95Si0VBhUOKqDSiPj7F/bYNAtuF6eODr3BDE5rZnPfHe53cd
	 FnsjWAhvlNVKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FCCB60860;
	Wed, 18 Nov 2026 01:25:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EFC91E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:05:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 255AF405C6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:05:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AHoVGstII70u for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 22:05:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D5A8840598
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
 header.s=selector1 header.b=EEhlbe7w
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D5A8840598
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iv6jjx5kzrqEq7mZigzoPvANsrKwrdXiURFUKhT21cc=;
 b=EEhlbe7wLTo3dpmHRpvICgtDvFFtX4A2d/skrMr/Yj2XHo50w2bN/C0eEoueMaJNxPGXumHgcLsuPb0NZogzamQeEQxShIyTR1p3AUu8/aeEW6kdiFWswoVpuzuivD50dcRseC3leusjelRbIDGIyvrcUIdTWLahzMnXCQKwmMnCSQTN0g/sZ4wjp015D1FuMKHWqG0oAVpDJ2MqdAWhqX+nKnTZ9T2SNBbLWfgm0TjPbpj6Ihnxr8/xSkyDnoZPvevwy4ugDVG5ObwDOqgLd5VOMkv46xD2zPKIKiG5KOZgaZ7jr9r8sRpJclqdf7vCxitKAP9tx3I32IoOmAy0FA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AMDPR08MB892675.eurprd08.prod.outlook.com (2603:10a6:20b:749::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:05:18 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:05:17 +0000
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
Subject: [PATCH v2 4/6] spi: spi-mem: sync code and behavior with linux
Date: Wed, 18 Nov 2026 01:04:47 +0300
Message-ID: <20261117220449.3134408-5-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: ba7407f9-1aab-4e60-efdf-08df44f6dd21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|52116014|23010399003|366016|18002099003|22082099003|261009223027099003|921020|11063799006|56012099006|5023799004|261102130727099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|38350700014|10067099003;
X-Microsoft-Antispam-Message-Info: yInk8hv8OkrwaNJh67oV3sgPL8VS2mpY2uC5F6YSbr9nx/1TlI922ENDs9mcWVOofuU1fX9IuZMFlD8NzBNX/SNRj7NjAXjGdzA57COTx+QmBEfCu0bjWzu+fl93OpSE5qQRFhC1PVlN/LMqK3t/5RJ87+qNZ7gY2IJE3ZInMzT7UgIvou07lsewmBsHuESDHMKDmiH8W8wMhmKZYhSaGxbdL+O9VUGxfGU6m6P+GWRwqJVoVCgxlIsm1kOfsFRCMaF1gxGwVMiIEEbxi4a4x3TuljsPioBx2slBXAk26IXcChOLyH4m2+x9gUAW8kScQgoSyisU7vN4wscyBt2DIy8IQ/3fVPta5xnjOtNGVrhUk9xgj4JEzlGZO7ctGQnTnF/W/duY4JluFy+qfurR1HCFvl2wcXupoAoIUxCCyjETdIrGiMvWZCglF5uYIU7BT+g+OPQf2K4yBdqDs4Lyl3m+OwMrabBsNycN+ew/FgMCVtViVlzRhAgzAoPzDqpZHOXTFk5pu9Ba95veUo8EWW09XV6gnwdmFEsAU+N6VNQSNiGTgvot5VRy8LxJap1grHNG5yvs4ga9M1vl7w7Lx0ja1u3NA2TMc9VAKM9pq/FPIcj2gpp2X1fv+OL0Ca8UBm0C35uN2V3IcRVOrXpHF3dJSBzmnpj8HPv52mrrarK/Fwd+8QeDYA6d41db5UhMlAP9OO4h1arCiplDXOetl8U6yTvngjArzGT//qomPX0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(921020)(11063799006)(56012099006)(5023799004)(261102130727099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(38350700014)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xb5LTDkoO7KzbIskenItia0t/+uOLcxoYYWyvuc8hEc6ZLLB5se2ssGGWvg1?=
 =?us-ascii?Q?OJfQO+xK4Lj65ybXWPym986KXmV5G4fyp+4cFVQiatvCSCifMTOkMMNZi+Zj?=
 =?us-ascii?Q?ZkoBvd6Z7send0BAX8OP/wjaVBxvYqzbB+IcdSRw969sJrW1r1/4TiAeTbOS?=
 =?us-ascii?Q?LuJs5PLLshk6RgLb2SHDiG84HTUxMdGk0OTQFT93II9JhryKRaLpkG5ubDhU?=
 =?us-ascii?Q?gOAfdRPL4T6L9GRJ1tGxcImBpxb5AwDpSN0ddzJ6QDEM3WKrupogTyFEqm7f?=
 =?us-ascii?Q?3ZcN1UQhnmtS42F1JVKNB78aOyfdIREUvoWCldjO3DQod82uWcED+chljJRV?=
 =?us-ascii?Q?JooNwhxt556z+8ZzBZvJDE4GqFEahZoRtIWxLkdn2LzlFJu4Q+FlU3NF7zbg?=
 =?us-ascii?Q?vfyCydz0mqx0n+kffjAZJABVbS7VMWBejNUFDzkT2K83yi9SDjdo1HRQmGhK?=
 =?us-ascii?Q?H/koEMR7jITQ0RBazQQ2kNAfblBIdRCQpSppMEAoyCHGTlsymIdWzdn4ERRj?=
 =?us-ascii?Q?3WvHFbu8CiVO0ZkJ5czUfLcKSW51mUWkbq1gS/L3pW/BcFMz0q0NL9H4mdDz?=
 =?us-ascii?Q?R8NpP5OFGjVcGYdt8fVUtPXLLWDnSSCAVwv138vQrMWxqkhpKm41mbXo6ott?=
 =?us-ascii?Q?5xu1ok6MZGaSExwHFbB2LpGDtQ5m1SGl70rZQ7OfDYkKBTnUoEoZV404lscn?=
 =?us-ascii?Q?dq0/UIRS9CvUTjNOVEi0H3u/zVyBMWFdqBS/+h8J8br2tXLhrtXzPoel23hV?=
 =?us-ascii?Q?JXbeHztKfJTtuhSALeLz/rRfrKC+gmsZ4tUnXDc6gVS2zSCdiC0Mhw+IcTMy?=
 =?us-ascii?Q?4+gRN1lEMQ3TNoxyIXu2IFeA5wXlMjRow41lqn5EAWG782k76/MgGRaIECrS?=
 =?us-ascii?Q?6rRD6I/yBD1CYO+FNIOqtuWoyCd7eAdvfZg8soJf2AftKhVrIUepKHEdS/Kn?=
 =?us-ascii?Q?ps5t3KY2Ibgc86ZO/HP18webZ6PLedu2e3lglVTIE51X+zfS862vfMj/cmhp?=
 =?us-ascii?Q?AXbAtMNJbX2+CyHt3WH9UXmJInUBtdJxBaWgnzjWy9AMsLC3puDRfj3ckdez?=
 =?us-ascii?Q?naZ65wiOo3PNjjiTOgAG7b0QpKsI583UDTq8lLX4RSKNP8haTq68fr4rxbT6?=
 =?us-ascii?Q?4Rhm/8XTuEudqnrSpcskDpBx/PZeGB1YCe9v/cvTrE/nXFZQY8LewcxdBFqT?=
 =?us-ascii?Q?sfMwpGCm26exbtTH6QCCcS8O31+NReth0TXP4zqCH6aREUhYyM0VwDmYCEI6?=
 =?us-ascii?Q?LX0aoFNVzwABq6FhwB1Wh+T5rLNxElSIbNQ73w6qSkajIy/ZfRUadJ5UhIAA?=
 =?us-ascii?Q?9xgRQyF36TUStMHIOtNWqMQH2+1bJEgEHL2KP/l/99YC/I2SPqcKIrvWRTgg?=
 =?us-ascii?Q?2H37FoF/b0wt00HiSreGLma6RejcCsWpuxgszmJ/1CF5yJbxZsas1T/MIa/n?=
 =?us-ascii?Q?ypcSqGa4ilb+L1lceQ0FBEEUKTEeiJw81o/Ffm2keoDWOdodht7GhMCBCiim?=
 =?us-ascii?Q?unu5tnRG5HnKACDbYb0oRglk8aeZHN1g3kCkHmFxbCb5dnryK7FiUUsQ9xAH?=
 =?us-ascii?Q?IxC0+Yuo7esqczbDlbDWtmQd7w7UxycF9om6oSrtMSM8Mmc3OkU2uNOUsI8S?=
 =?us-ascii?Q?IUQI/Wo3aSdWdxGrRcGL08kHZA4aCiwVe4KE+wSC9VfZ3Sxf+C/nh0i1heXc?=
 =?us-ascii?Q?bNov9V9h5t8Nf3SHB/qKTNIa8iJ3WRXy3tMkw64Q2O39qAU0O2hQnxviVTBk?=
 =?us-ascii?Q?WGe+YcpniKcMGnzrbwyyFql2NZGvw30=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7407f9-1aab-4e60-efdf-08df44f6dd21
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:05:17.4920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wVO3OdUrVZ/38jig6ZsPaybqr3JtX84cJ37wfkRkZQQVmu6q/RcIRMDycMQKRq78c62eV7xmc7Nn2eFp4XoZ5xp4YLwts8hg8aES0JjoWU=
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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


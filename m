Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC359606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 01:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vmar/7c4;
	dkim=pass (2048-bit key, unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=AZxnaPAN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7358C40856;
	Wed, 18 Nov 2026 01:25:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q0M1rI9KxZY7; Wed, 18 Nov 2026 01:25:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6EA244084A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794965155;
	b=QBRYbPjGMFdW3CMyxF7yfM7XiT6D1imEF78OZaI4i0NgStE938kKz5Freoyhge20Jc5B
	 84t5ABPEmSbcjaQGcz5LLyh6/EhcfsVw6zhyI4nb6c0tOH74Rjjs67eMPxe4AIMiemkQ3
	 LcG4fl9BeJroPqLgCFQkma9eXCzjn/NhGt2QsVlDkZMJSabmhW+/XkSHensY9tadXod9Z
	 7CPYEY9pAYKsAccxnamedNsahi8O62cmkpDX2angl8PfneWKz41Zo3DmU6K9hD2YQlg+J
	 Rr2XzpkQp49gw24Bv89W66zLt+Bp25LK3enbcTkET0hgs3ILVdymGkhZZh80Vpfmu1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794965155;
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
	b=Ns8w1dJepC4x5LMmnEUCMzK30/rAy6Mr7Nu3B2hgn6uwCQ+Ej/fD+DpTR3nlnn1uImcJ
	 O9UzlkSmgL/6LBHSnSn7tcG5XNKjDYtpNhmvZ7QiYvi6Kt804bFW3x+95i+6hC0TSpgkH
	 WAJCyMImZAkz0dA9yapRBasBpB1imTIosdEB7Xu19/hftAfvSEncwaqBRVH/jqezpqOw6
	 TSBQ6woB8NGSk/lVkGSgNvRTcSbeCUTSEfp6s2Esc+9teYvnQ2WgSWPHko+xuzq9aCe9G
	 TIeprtsYxkHQUl7wcbI/2P3fJZYquSUtWZzmFVTdkxr2Au6Cp1RlUn5eti3JHF4Vxrw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794965155;
	bh=NlxIjJT4+MP21+gD7BvtcjYlMI4vX2iR/EApR4VC+3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vmar/7c42Nu6NBUfht5qJWi67SqEK4CLyoFhZlbDBSS9mtrax/MUZDA44Pq1H+Z6G
	 1TYDmRNDNnu+Y28ATDpVnnX5zpgLy1TuAOmTaHFc2hmfWQuPa6qQcfC9p1aLZ0N9Ba
	 qlfLFbyYUDOgdoGkFsx976SYQdJva67Xq6sEsZD28oES7hdLphnBiTg7ZyiE/MAqNx
	 c9BxLCU6itD4AVGPphkMszpoxX5RuCYUZ8Jc0SM4LFzvwmutxtNhJGzD3XbSHNT7mp
	 Kd5owagCdOknyz8pi/ipUbMvqij9NlygSjloZ2Cb6R8W+Bk7KC+63ZYogN60Dd+piL
	 QJlRyqcL3jwBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6EA244084A;
	Wed, 18 Nov 2026 01:25:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A82049B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 70DE880EF4
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:05:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id azhYp4nsBdzM for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 22:05:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9D5A980E67
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
 header.s=selector1 header.b=AZxnaPAN
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D5A980E67
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlxIjJT4+MP21+gD7BvtcjYlMI4vX2iR/EApR4VC+3A=;
 b=AZxnaPANNG9aa5kOuAV2eWIIsobff/VRALkpGf8RILcF+27BGLTggIJLW59v+Gq3pn0UVzc/HKGyemHzrXRL2fx93LXg+nb5yvORk25BSTblgnKT8hjnwUGuwr1yZwb3t7GDNnsz+WE7rrF2Q73g5vqEuM0bntD5cBY3eBEo+cBzXQoADqVscvrZDXNf7gOeUEVU+6HdEu3jyR8CVs8RS8SXtF+4yPEHTX6cenRrLe4Iy+3Q9csWxFTSRHje5i7q2XIksPNAE+hIsgQwI1Kk4RxoU8rV49Y+BMD6P6gbTUCH+B+aEeGQoK7Kgte+P8jkHMCErzDd7COMGuYAxv3CoQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB8750.eurprd08.prod.outlook.com (2603:10a6:150:c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 22:05:13 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:05:13 +0000
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
Subject: [PATCH v2 3/6] spi: spi-mem: Create a secondary read operation
Date: Wed, 18 Nov 2026 01:04:46 +0300
Message-ID: <20261117220449.3134408-4-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 41e342b2-cb51-40b6-e0de-08df44f6dac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|23010399003|38350700014|921020|11063799006|56012099006|261028144727099003|261022075727099003|5023799004|261022105027099003|261021121427099003|261102123227099003|261026140227099003|10067099003|261026121527099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: Glp16O+6Csw+ReO6VODw1CZ85aGHuOOB/4AQrvc/V4xpXXbJMtFRtiD8o6HpbSHo/tFSaO9qel96a+OG9ASU+b93BSgEPPy612rZVVwjOD1RMI/KeClTtYUauoHW/J30OZZ21GxX0vKyiN7aylmba8Es//+oMLRn2Mb1WOgFiPfZ+wu/ZggZWuF3wOoPokcTgA89KTifz+S9vPY5AHjYQPRhEFe2a1QmZPJKvYsbuGg8oyB1qa5ja6S0TwFrlEKCUZ/eU1VsnFrlnPiPY/j3V4dUSaH7tXJuNBiadRsxp3Ssc44VmoWvA/fvYpZ49+l5jqO8WmCQXtFt3cFUcmnUhRPzFCusNYs8Nww2wvqJUD3QQUFbj1ti4wquXjk7/g8pgk17D9r+0Q1halNGWQqcIWb6o9k2AwamUYgGYX9MPHugCByl72J0OYNP1ZgK+stmfunARW5TNIwcCR1WLInfRFrq4q3QzwHS0gt/LyhQLmBejim9/M1kEyheib4bRdhRm5tcWue+2xiNKeapWuAC4/nctpuIunU+zijgqYjJuCagHwYSy2ERZFpTrK7E9NA+BCvhYEBv4eCVWArAAWW7ITFHoJgbewfHpjp8r+oRyNE0w7lZBpi2XG9kmZmkbnfw57KhP8CrvyJrREv+F7+2nr6hZi5zE8/z0Us4vM8qNyTRAKS3gu9ZzxW1y/EJ0MQmuraeoVewB3iCGM5auOOvBPpO+V85dAaUw0R8qrO2uXc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(23010399003)(38350700014)(921020)(11063799006)(56012099006)(261028144727099003)(261022075727099003)(5023799004)(261022105027099003)(261021121427099003)(261102123227099003)(261026140227099003)(10067099003)(261026121527099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZfTdM5Gnfr27MJOUI/TeaowuPswWY8C650eZEDC8SOcn2Az0Q9aNACLH1ne1?=
 =?us-ascii?Q?q2ms8mZ9VRQCbppwzwxrXU1F19bLXemAc9Cu33oY3uNMiAlXyagXiOanZ3/n?=
 =?us-ascii?Q?zjKAvVBTfaTxLii8UxP1FhQyevqrv+BcNmyW3klhhzGW0RtcUbXCSPTa3xFH?=
 =?us-ascii?Q?a9d0h+3dFOvykvm+UQTQldWMeaXz8iIwwPmrlVA+i/furj+Lym5GNESmzPAn?=
 =?us-ascii?Q?hqvHynx7OyxHogNnjoGZoN1uiLCjw6HM9mQeyvtT7J/8Xzx9L21aqHLOtlkV?=
 =?us-ascii?Q?hTMErMu2D63K3aC9Un8eQaUttKgKLfwNUmWIoWwlRGfOccmKcbN3KTustOIE?=
 =?us-ascii?Q?Gh6Rc9KvhCh6JliYUxRHeqwjCipdJHBYs1/VP5VK6ypW+iMCl1McUeZ1kyxF?=
 =?us-ascii?Q?LcofpURaVOeon82TUR7+ZTO0W7fs/AjcDN/VoRslhXsN6rgo9f/jUIwDT1TH?=
 =?us-ascii?Q?J+ZNj1m1LAiFnzCOhO9mpM+cQya4QiSSMEknvJLvt6gSGrxVPzNV/wj5W0Hg?=
 =?us-ascii?Q?MCbImE2933bRxeZ813XkFNOhxKg+lmEqYhyUVfM85P3lbr8NlNodiQVsbhOA?=
 =?us-ascii?Q?bZMLAv+F3egU/DeCiJvOKoOOR0Pv3EvxKde2ku3TGVMrs72LJ55lGC7+2F3N?=
 =?us-ascii?Q?GmWokaFqbCJ2+zoBLJ2gYVGy/pGRdAVYHrtzfmRj7YQI5E6UR3Sp5nlGoUpl?=
 =?us-ascii?Q?iDHqP/Gn6VF4DoVjekLe9zOEIPkUCSxFKqxrOVrvM7/eTIuCC9TtKL8aNWXW?=
 =?us-ascii?Q?ZFNFGRcyatBsxymu9XH2Uf8TeZ7bJ9my9LRJ89e2jQMhFwGD3g1EcqsIdPxx?=
 =?us-ascii?Q?avG9pH6qN4SzvsJTzvZtVVMWAld/DWxT0fQuctCp+XkHeUXK7I5pSg0JTYqU?=
 =?us-ascii?Q?h1jXPi8+OZmzE7CoEV+uuniwaR8jv11o1ofYEZu0jTid0odK0CG9bDnDUSvA?=
 =?us-ascii?Q?P7zfJI0YPhH8vCUkKb+sZaK+l5/Y8H004W80oU6V8jSBD3Y6QTIAd2M8cams?=
 =?us-ascii?Q?Ok0ksWHFgzGtIQef7ETP3GGlB+0gWg5RBs9ri7FMZJfMu738HelKHBh24T0i?=
 =?us-ascii?Q?BTm1ChCbgWsXo1rh575QMiZxyv9luxtzg+8iNgmlSkIqF6yxLAdRu1WeJKq2?=
 =?us-ascii?Q?tAKgiliYJH28CwwWMDs7TQv+Alus/WFnPRF52UekgUEfZ876HXqWxLk/4UH0?=
 =?us-ascii?Q?AwimfSihXYIZOyDhc+a+LpAs5vv4DUhwpAcfz1LfFOSVbyUTGT0zjEEIe2BX?=
 =?us-ascii?Q?LAsRADtGtvKQVO0Tun9nC0XnG+0TI5dChNk0b4aIon7Dgx9HU6p2VjU7W0Av?=
 =?us-ascii?Q?shUbHi6XrIjmXFDVkPIN5s3/XyjTxbJ2d8+qBlW6S/HvONX3dfyjDyFKSa2b?=
 =?us-ascii?Q?hGJn+FAadN/z5PyWoobWLeHp8OHEk5BnYBgFunyN1qhryjAN0pA1Drh8yQjn?=
 =?us-ascii?Q?IIKQX8t/YBeFgQK29oc86JTtmVucS+DLn8QOpatlUmgWJInyQ4PAm+1h0mJI?=
 =?us-ascii?Q?ZtIbW68TVA7B+Q59minOkKyGecCszK/3ZTCOsxfhQz/FyEliH3f7q3qhsIyH?=
 =?us-ascii?Q?7Z/DxyLGOfY2dKLf2cjIxgGKMH+dwDtPBzUFP/YDGEU3Oo1bZRWvou1o2H7Y?=
 =?us-ascii?Q?NasJ0lFjKot61eapSkbQsB1JIgsxRKpIHkjiXj38HzNk2xTbMN6pE3aDMtWr?=
 =?us-ascii?Q?HHMt/BL+r8dHhD0xUqtRh0uxfhK/kw/j9m1ctSDkIdL7esE7x1AyaReEgIH6?=
 =?us-ascii?Q?JxS/6m8vHahD/m+cZ0hZR2wJH75nY5s=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e342b2-cb51-40b6-e0de-08df44f6dac3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:05:13.4396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGe+MTd6KQdgT/KHgtKFidb7w6X374V7Ece/V37w4RcWqTNtCLG7RlmdyKERTiOqfHgO1LaPUQnkQE5LDQuRcFesTLTNkzJK3V4B0iSELjU=
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1928C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 21:35:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15EED87B4D;
	Tue,  9 Jul 2024 23:35:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="mTQOUwzv";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mTQOUwzv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 323818862E; Tue,  9 Jul 2024 22:19:55 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC31D88570
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 22:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=YeoReum.Yun@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Sm4R5x6v18BxLxWt7x64k8O+0LMpCkPe05S2pF9m0hIChUsk4PCQXVpgumCkF2t9d7lwlCmHKkbLJ2c/1WPuX4qs1zuRlfTCyOP+XepODfw+hDcsB8aRi03CRmOSMcUhvU3FnptrVTDWnXzFWDw+8AfUjal0syk7LcT5MG3ytH0wPxqm3y2XJOuocElYNcl+um2UaqKyZ7ijCD22bG5yiMAhzXV484HNl6VBGDSJjO4rX6RdtDhvGDTwRVsTnQU8/lz8+0gdgDvF6mlR7HZaFfQSN+LhaJTzfa3fTnY0P2almoRR/WR5uRAlxq1zeyBa9dz/MGukISKJIktilqtEow==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/i+WzY5sqoF7NiZk+mR6klw340bWp/uppkazUunCQ/0=;
 b=TR4oAIbEgsLBmBTmMYKEBkjK2VKPHe+ogwphriLbH2cs9NcdHynCr72m5ZZMUKL8l3+zbk0FkBGtLBr11TegEerJKiWHDq1v2dtJkmr69CycsDDZmP/8UunoKYl6CfqIs0R4VtjUTJ8oJJSydPZpO6AX4vR5M4BwEFuq3LpTyzyd7JGTJwhmEFPyg/dvGU1fup3rbFzCT+zsEG2+Zwc3IOTbImrcazL3oocy8CATFt2mSYOb92BNEjnZv+Hy4RP39XBwJOvynR82aVmlu02/h3tFNDTrfKVNoY8aBeljjnHIhcHdTgrfIajycF5leWT93ihm3pUpV9qQEQP3/MsmKw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/i+WzY5sqoF7NiZk+mR6klw340bWp/uppkazUunCQ/0=;
 b=mTQOUwzvNSau6db4TFNBMVDqbeCuuC7zDvNn5M2KCECxoZZh3dB1G71ywf9VbQuA4IA3/5dj+7QrRQw4xmfgiRGIj67FoBOGCt+O9mXhZXGN5UNqjelA981d0FZQvwFKaG7gdvU8Rz6fgfcNR5TvGM8RrMUftbzs6u/4V+IDKwc=
Received: from DB6PR0301CA0086.eurprd03.prod.outlook.com (2603:10a6:6:30::33)
 by DB9PR08MB8627.eurprd08.prod.outlook.com (2603:10a6:10:3d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 20:19:50 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:6:30:cafe::7a) by DB6PR0301CA0086.outlook.office365.com
 (2603:10a6:6:30::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Tue, 9 Jul 2024 20:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with
 Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7762.17 via
 Frontend Transport; Tue, 9 Jul 2024 20:19:50 +0000
Received: ("Tessian outbound fb4a9dc7a0b9:v359");
 Tue, 09 Jul 2024 20:19:50 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9490161518f2683d
X-CR-MTA-TID: 64aa7808
Received: from 3a6fb980858c.2
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 00E5F849-20BA-4D4E-A49A-703E549E9CB2.1; 
 Tue, 09 Jul 2024 20:19:41 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3a6fb980858c.2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Tue, 09 Jul 2024 20:19:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pgy8Mm247L25Ha9QqlQ5AfZ/LsTW9K3zfJMdRpkU6Rz4r1bXcEbEmgdPaZ9v/bv6ibJmZjpm53YDxn8zUSDdPRGUA5e3HqKyqvI06zTjBuy7IhMhA6LhVk76dfHFbotfAFAp/5jqe6WUEXfYcWjlyqqtT2e/G+N/3GY89TJcTSQQwM3bi1Hbfo6zoQrUROSMJMf+/vZQRQc7CT5ss2O+sII44EmDGjSFNV72QSXiu1ZCuwcyS5FJgXaNOMg6rl9g7q+ZDnt73XbdHItFDyiCCrcbUynBmBQPQnm/GBBnoxcFADMVKgb9YwY1wxxBfFE35TknVPl+c84xCvFu0kRZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/i+WzY5sqoF7NiZk+mR6klw340bWp/uppkazUunCQ/0=;
 b=Myhe0XGlmPbUkymdKn8zBcB4oOWA1A76dfUSbjfJ0KXWxsiuKcPrdJbHY6Z0mtna/jfDbEH8Xxfzuf+xJXRs2i9M68oPEgw81XDBjpjFOeSUcGfNmRu+sWfdGtlIyjzC/f+DgiAaOF4paxwW+iPJm1TEZZ/GzFfIgtAalGLxCAH7S/gqB1jvRBNwRTkx4i4VlCxq+lFzYHGHFekNyB/QC2SuXKFj8p/sCRA/M4a4n3zxjvTxtIU/0/hDf9bqCz6neSAhzPcb1kYv9wAj20eLrOjMqa249D0kdllESG/jc3/uXDu0UGKAJ3b2Mb0N5WuRa4rwqH9mKTyZXT17GNxNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/i+WzY5sqoF7NiZk+mR6klw340bWp/uppkazUunCQ/0=;
 b=mTQOUwzvNSau6db4TFNBMVDqbeCuuC7zDvNn5M2KCECxoZZh3dB1G71ywf9VbQuA4IA3/5dj+7QrRQw4xmfgiRGIj67FoBOGCt+O9mXhZXGN5UNqjelA981d0FZQvwFKaG7gdvU8Rz6fgfcNR5TvGM8RrMUftbzs6u/4V+IDKwc=
Received: from AM0PR08MB4289.eurprd08.prod.outlook.com (2603:10a6:208:148::12)
 by AM8PR08MB5857.eurprd08.prod.outlook.com (2603:10a6:20b:1d2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 20:19:37 +0000
Received: from AM0PR08MB4289.eurprd08.prod.outlook.com
 ([fe80::507d:582a:b779:1b83]) by AM0PR08MB4289.eurprd08.prod.outlook.com
 ([fe80::507d:582a:b779:1b83%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 20:19:36 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: Raymond Mao <raymond.mao@linaro.org>
CC: "trini@konsulko.com" <trini@konsulko.com>, "sjg@chromium.org"
 <sjg@chromium.org>, ilias.apalodimas <ilias.apalodimas@linaro.org>,
 "n-jain1@ti.com" <n-jain1@ti.com>, "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] bloblist: Fix bloblist convention checking.
Thread-Topic: [PATCH] bloblist: Fix bloblist convention checking.
Thread-Index: AQHa0gN4INcUrc64ME2JLLc5F5/sc7HuczoAgAAv2/CAACTTgIAADoRP
Date: Tue, 9 Jul 2024 20:19:36 +0000
Message-ID: <AM0PR08MB42895ACB7A07456A68C3B2F3FBDB2@AM0PR08MB4289.eurprd08.prod.outlook.com>
References: <20240709132516.2427654-1-yeoreum.yun@arm.com>
 <CAEfUkUKQGN3NBomwAkyP2fD6e6MoCrsiav3cS39gVxM43JHrXg@mail.gmail.com>
 <AM0PR08MB4289A2EDE199614C04D77FC7FBDB2@AM0PR08MB4289.eurprd08.prod.outlook.com>
 <CAEfUkULxHy+4THehXON9tu0H-y93LhTkMrAyPBN3R9A=j3zLaA@mail.gmail.com>
In-Reply-To: <CAEfUkULxHy+4THehXON9tu0H-y93LhTkMrAyPBN3R9A=j3zLaA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: AM0PR08MB4289:EE_|AM8PR08MB5857:EE_|DU6PEPF00009528:EE_|DB9PR08MB8627:EE_
X-MS-Office365-Filtering-Correlation-Id: 490949fc-fbda-4298-be27-08dca0547c75
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?cZxxxrFUbBDnY9wD4+9i5P91yfYnzN+Ri+x3TwSkwOgrhnj8HgjRjNHyvUGi?=
 =?us-ascii?Q?JMAwr5aL4fm90c+Sxdc3a88pSLF1aMkFC56yKNWrI843iaRyMkGZI4+UfAHP?=
 =?us-ascii?Q?gOgKeYepFHQayCsXruBrtwhmSmq8aCVLMigDWJ89q75e9XHCmb8Ti+z1wlpr?=
 =?us-ascii?Q?j7REjwAgppJQiLszOjjfH3dn9IsV6ppnHLrE3Qfn/ae12U4dxC2qLXp1ubNn?=
 =?us-ascii?Q?xOu79f2yC6zbLQxEQMM0B9NUMvu20pmBEhszG6wJCHOAO0cOBsNoHkx/eXhs?=
 =?us-ascii?Q?lu5Gam1B7baZmloIZDIcVF/zAc/ndM4tKno9fWUuI02lXMOlgO8pTsDwWxi3?=
 =?us-ascii?Q?VmgnF3wuNP5bUuVgtqhC/A7sNXVY6+m68/Sh5xDT8ydBsUPWg9LE81YqmAut?=
 =?us-ascii?Q?DmrBQ1mgMVHb8H2me40MErTjH9KOR3Y1tsN053B7vfNjYOsZn5MoSm6OVxYs?=
 =?us-ascii?Q?97vjVGPYgvxzPg21dTuYtjoM1LsE1Zqvun0l9lzIXeNF+QOum5W18MF/aeCc?=
 =?us-ascii?Q?fHzf27OA0bDRyKRA2uLHma9NnhzVcqt32Ka+O+TwvDxJgU95ahf9bNyGVQhq?=
 =?us-ascii?Q?RGl250cI2ZS5hOstroiN1nnZUCQPhztcVqccoIvn7cToFZ1jM9XNpKIXNfDB?=
 =?us-ascii?Q?ZbRQ0ttWaBj4RPIfxRxY7+EuG6pV99H5dxtpwl9Cj07WXR+4Ctgo/Hh23RT8?=
 =?us-ascii?Q?gdvzuOcZS0gBwBWCVOQAQYgK3M8wGojv4fbOD7cqO4kPfFhf8Lt3A7AU61P0?=
 =?us-ascii?Q?SxJD1wZT2JW8zMGScz/tKMp3uH1+k3N1ysg2yKhG0HMngm1LycHv9M5UucjA?=
 =?us-ascii?Q?8oaC5J5ROxxVU2OaGrVC7xDVtyjLV89IXVAN+WxY2ckVUz1LK/FwVqu9CMZT?=
 =?us-ascii?Q?BFDHYWA1v8Pm1jPjdZv2LLchfYoQD2BOuA2pXNJKH925lkKsfGyWBmgK8jIA?=
 =?us-ascii?Q?2JjcaiFaf2iKreS+iKQwg+BsZsLM4ZWo7/PRLoNXFg3nSkggDsjpdyM0zgT5?=
 =?us-ascii?Q?HgNsQU4JHT0fLJccLD5lDwr188LG+WUjWpB4Cp7MdUQ0CrxzUZaFt1ywuOUs?=
 =?us-ascii?Q?piwcajrxR9w+KUywJUGqSfJhf8qkVfel0iVxa6VadRBW9RUi1pviowOLBkj7?=
 =?us-ascii?Q?VxXMwhdHOskbqcMMeE5CEvlJfmZ+earIs74pQFNMHDFqCrW0Y754LbpKIsqg?=
 =?us-ascii?Q?5HEhVkOBBPV5eleh9/tve71/RcgjR5fnwWLIketPE8Tt0SRhvxGS/QcomPu3?=
 =?us-ascii?Q?JkHg0skdNTD1P0FN9VsbDxQhuLjUbNz3qA2+UkK/Y2QN4IJ5ZsZUbSqHcM7H?=
 =?us-ascii?Q?9/FAIMkfJz5c8WwvPtUuUPjf4HB3YxnduldO2sXaMkFONTyKv8ZZ6vzD5Ri/?=
 =?us-ascii?Q?V0UFtDzRjwsXvnjjYlC+uU3NpYA75vjFqShF97uH23i3DspcvQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB4289.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5857
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2d966b85-552c-47c5-c06e-08dca0547456
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|35042699022|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gRCVZPP5FlZewo1g93Y9htOuNTKtIRIB8kZPaGZKWGcsuhyBEYd6KqfWl/Qx?=
 =?us-ascii?Q?CF4hVInvlVjuLznHfEopW9aNTrtGPQtcC4X8gnPJQknf+U708uUpbSK+Zmhn?=
 =?us-ascii?Q?URFf50DD371MllU6ZMDKzTbERfmYMBi3JJf86IkZMReeYFG2r/0Sw2uyoPqe?=
 =?us-ascii?Q?5y7JhCL78N71grwp09fucI8aE1gPEzsh+hT2l+4/jw2RkrLx6pEQxt8iGfiq?=
 =?us-ascii?Q?ItbZG0jcfAt3s59sRBtXpM6ATJ7QGxmN7mgqVn3JYGVi1/ZihssVVFAbHHuk?=
 =?us-ascii?Q?bMICUtbNpx7OCSyCfTOKNlkfSPK6d4+84FW1kuPyiQAogxBKdV8bGo21fZ/9?=
 =?us-ascii?Q?iugXF0JmrtPrqUxnoCKL/NFhqPHii5t47RdTRNzXsnlqaWYj4CoRz8mD+R2m?=
 =?us-ascii?Q?14VgEBcaOPcKJA/kHD4EXdEvQjWOqBI2j8+Lf+4eWtRKWfdvhxKi5rBTkmGF?=
 =?us-ascii?Q?WxWXmaxHze2G2jh9OqAEli2gAj2FevsgRAyVq/DzE9l1EKAyPO1RF4msM3r2?=
 =?us-ascii?Q?T+VOCv22HkglLigbWyxJhVC/UGTxWrE/zDJtF3SWHkrJXTz+z1u1ijWVJ4WM?=
 =?us-ascii?Q?VsMqSsOO2sBC9/L08i3jrudt848iIbk2xg03kO/F3NuXlF+RryV/9kWdLdJT?=
 =?us-ascii?Q?ZlYwpbaROFHXKfE+r4uFotPzumPS4/a04ZDDIB9s6pi+ckujOGMgdtB6b/RX?=
 =?us-ascii?Q?AYAa6cmJJb/EilVp641OTOsoZ+rk/LXCsxRZTYa1ikFCvKsb3H+NJzpnLQvm?=
 =?us-ascii?Q?yQ8mt9pY+9rK027TjMxrFweDFZVlIWzcmJqGMneyRVXFQu3jkmkC48EOIG1S?=
 =?us-ascii?Q?y52LfvECWeol4XYcBWFGdk1lsiQlo1If5IVoj+dFtMrXJVbL6jUOqQ8+KGPX?=
 =?us-ascii?Q?/Ts2lwi9hn/n1y4JXDtG2k1AhjbImaL+h/SIhdaB5Vzp6WMLNcgAR30lYB//?=
 =?us-ascii?Q?+Rn92uzjQbOOWsAPwbnQSyunwRnbVnnPYuUZHbwmTNi5wphiWt7xufWziY7G?=
 =?us-ascii?Q?hPijQmFkKO2BT4ZJ6DHJcp/kYnE+fnViFiIi4R0aWuiFMVJmwGvWyFCwS6Ah?=
 =?us-ascii?Q?QzMSXtKlhraNAIMR5KPrboskl/G4Q/cHF1UG9WKX0wypRch5XLja2FG4Y4dI?=
 =?us-ascii?Q?rHi3QUkCFJf+XmegxixQlbfd3HdsudsEY/FA59gK+mFmZwaS8QyHjNFjTdN8?=
 =?us-ascii?Q?KUG6Xejaom9zx9EAlVA0JQDKrxwQ15F2KRoHmUhbhk1xEvo+B4yRzgEOIlHm?=
 =?us-ascii?Q?Yl9ufzND5PjoJXKPqjVsP6sK+G5Gg5RypPvDF4/jtq0YGmYm3HQsUpmSZU6V?=
 =?us-ascii?Q?Cv9k83AgzaDY1ePbsJPXsKrfj8F1D9ONS/UQkDk7Wrx3taV6Kw9853UXsIq9?=
 =?us-ascii?Q?eNlx2NQmSWf3kcllo9sNTeB85/T4hdtnccO/LqdU0OsU3AhnvBxvxnKDPiaP?=
 =?us-ascii?Q?WqSMr/V5xFoZ2kilY8swaxCZZYP0/qbk?=
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(35042699022)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 20:19:50.5556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 490949fc-fbda-4298-be27-08dca0547c75
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8627
X-Mailman-Approved-At: Tue, 09 Jul 2024 23:35:52 +0200
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

Hi. Raymond.

> I think you don't even need to change the order.
> The FW handoff must fulfill two conditions at the same time (A valid TL p=
lus and proper register
> conventions).
> Both conditions are essential with the same priority and which one should=
 be proceeded first
> is fully arbitrary.

okay. then I'll restore xferlist.c.

and send patch v3.
Please ignore patch v2.

Thanks!

________________________________________
From: Raymond Mao <raymond.mao@linaro.org>
Sent: 09 July 2024 20:26
To: Yeo Reum Yun
Cc: trini@konsulko.com; sjg@chromium.org; ilias.apalodimas; n-jain1@ti.com;=
 bmeng.cn@gmail.com; u-boot@lists.denx.de
Subject: Re: [PATCH] bloblist: Fix bloblist convention checking.

Hi Levi,

On Tue, 9 Jul 2024 at 13:16, Yeo Reum Yun <YeoReum.Yun@arm.com<mailto:YeoRe=
um.Yun@arm.com>> wrote:
Hi Raymond!


> The handoff of armv7 will break if you swap arg[0] and arg[2] here.
> The args are already aligned in the correct order via the assembly code.
> Please see the 'save_boot_params' function in start.S of armv7.

Thanks to let me know. I couldn't see that code.
But I think before checking transfer_list, It would be good to check conven=
tion first.

So, I'll change order only.

I think you don't even need to change the order.
The FW handoff must fulfill two conditions at the same time (A valid TL plu=
s and proper register
conventions).
Both conditions are essential with the same priority and which one should b=
e proceeded first
is fully arbitrary.

Regards,
Raymond
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

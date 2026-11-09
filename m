Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22285606A323
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0VK9EFG2;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=StA92pv4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECA1F80A89;
	Mon,  9 Nov 2026 09:32:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fkVPQksvDSCn; Mon,  9 Nov 2026 09:32:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4FC1680E33
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794216726;
	b=p/38O58FFAS7ET65iCP12nuJJsDgkqff6m6UBxArjMezWXwjZjZAOWXZYJuR6qTlIiVk
	 WHjfIW8iuk6VX1I6vC1E8yOw8UR+/ViEO/dNnx7e0g/Pa7WtNK2KV4WwojJ+xm/f+BC19
	 RRFc6L8lG/7c/30ytvBU5eJUn1TpTy3zNI9DGz1obLPtn8DMqC6FrUnHuf612x6CNzV2c
	 W1s3QAWt10Ls8gjWA/uFgE/4XtUCAJzE5N4b9XT+Klh0GUYNwCbj6/zs+gdQNaQW4tb3I
	 B60eeoaijDJ0i8cuSF3OWuoJ+/aA/mvfMj7jzg33au1FLOzH+KN2YEjehQnnf8igNDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794216726;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=F8ERIMH6KWSNAxTiOYBDK6nauyd1+En0vlWcntBGVXs=;
	b=mFamQFP5r86G/wLsEqD90O4019BErkqYn10M/DqkYnPSq9Hqv5BTSzGglKXPRK/OtW8T
	 7OQYnICg635YLfQ8ytLBb/OhqYFHdS53vQe8I56W0xOn3FtRunRi691Dd6JkxWBM6lOzU
	 V4XQy1syd6tJkRSiSA5Qlx8PX76lcKYc8JBr+cLVqln58YDMw4MUDqHa2iiW0hAw4AcVz
	 OmYULM6AcO7MhEBgPfzd0xviQCcDnmzHBQXWkliHoe/zCsSB6k/t/GKlZGT9fck6yiv9R
	 veatPkx69F8TapAc5D9yD4tFew4IEKUZf4gaUxWDZFS1E2NdbgFgQviPPH8d4YAX9SQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=fail header.from=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=StA92pv4;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794216726;
	bh=F8ERIMH6KWSNAxTiOYBDK6nauyd1+En0vlWcntBGVXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0VK9EFG2YMAz41VeGfmwke6dPjYYT7FIFu/a4NZ1y0KO2OkOliEjbC3ZLSYpEidzB
	 CG75E7vEExd1WM4eFc2spPWMvbSICel8o4L6U0ChdMhsA8i8WK4hj7dLW+cWzOIN09
	 QLqzN7JAhFfc9nj3pN9CPruxmhRSgFLlR7WmtROfLyHyQfCIV7zM65DJx0MKCHqZu2
	 PGH4VJGh9KP9+ZsyQjZ9J8mhe3kIzUwXVoVpR4mFEqgMpfSOkHnR52juFZ3VMB1iXW
	 ciEi8BUK79GYEDZzCTrc9am+EYVsnAvLfZ0AxGl4czW91PcoH/3jskF6tDtsmOFkTP
	 eUPLHPSxnMmgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FC1680E33;
	Mon,  9 Nov 2026 09:32:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 127DC2AC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:32:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03FEA80E33
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:32:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id it76DOwBgW-U for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 09:32:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2FA9980A89
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=StA92pv4
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2FA9980A89
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8ERIMH6KWSNAxTiOYBDK6nauyd1+En0vlWcntBGVXs=;
 b=StA92pv4c6t4iGC/dCqgVxQpjefFxQi4CsCv5bngUwzFqQBy/9vHnxXDA930NpEc0ndMR+UbtelgPGcj9n0RUXziwd9PrgP8VqpO9MCAs5I5T6l21iq00LfD5YMEyytOQoDJn3EyPiRo9x+N7j28wsQ8QidikMC2vGGW87lQ41OdgEH6N8zjLlymfXITK0/CZa4Np5u+78FMxmhfEoiB0QSJ5tjcah4qxL131SXsJ7Z3HoeTk26sqwiaBAGHR+7FV6ba0d2FTZcBYhRJcz9jWd7i7Z1uu3Ul4J9mn3qYg0i1LK7gPwYqeESbf1m9sacX+5lLRbah9lZWFs/lCO2/qw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB8072.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 09:31:59 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 09:31:58 +0000
Date: Mon, 9 Nov 2026 17:28:28 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Alexey Charkov <alchark@flipper.net>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 1/4] power: pmic: mtk-pwrap: honor fallback compatible
 strings
Message-ID: <avGSPK3JDYnzo7Nw@nxa18884-linux-1.ap.freescale.net>
References: <20261104-ccaione-upstream-mtk-g700-usb-v2-0-b8dc65b47373@baylibre.com>
 <20261104-ccaione-upstream-mtk-g700-usb-v2-1-b8dc65b47373@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-ccaione-upstream-mtk-g700-usb-v2-1-b8dc65b47373@baylibre.com>
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c33c08-4f94-4a35-7a1b-08df3e444d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|366016|1800799024|19092799006|11063799006|4143699003|56012099006|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tG4fg9T3HcS98SawRTlZ4KLd6HH5a0Zf10jI3ggdsr+pziaJf6C0BLSmD5+weI5JCSiPlkMK+EE5rRzmDIOS7NsOUUdX+gD8WJZKWEI3oIlv8W0cZMPUMv0D+ztzFTmSks6yVYp5gmpUXw/YCO78om+VFHovB9j4x++/9lSrIBOjOmaDK8X56OqYkAii8tJGh5XHSvYxJTynzhLxaEQFyI1Dh4UQw4wTbTCmBLvQzHNVwJg2QDOeJlJ18HNVxSaqhd1TzAIJ8nKtM++irCC3cLXzdcPH56QskFlAPO6lTCao/sf1wOrZ9AiwZYVvaF8U31MlpNYxw1xkgPGOx7QqwbfClaeE/+/oOzHmV8DR6O+M0J0204u36uJ3vKYr9irLc5cejvAgbjCq88/V7MXYoXF9IpRku0CuMyQv13Lex9ZGjdZAQ7WBkkVHjX5i5g6PjQltO9is8C4hmTpOBWbZ+SUIoEyJq7zUTZMT9ExUf6+fvGPxVEexL03Q6u3aSk+ebA5Vx1ZSeOIt6A+rKZ76uamkZDFm1wkgmRbvHJGDlHEgy/qCC4EizpuYWylDwmQ+uWHorUlLkkbMhGnWRE1C/Wl+1AXUprv55ryL9E3b6V4eAfwyiDJj1mcnf4qefXYzO5v29Aqzn8Q0Zy4haiL9I/pkHhBGKiayLjL7Ux08ZgI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(19092799006)(11063799006)(4143699003)(56012099006)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qXFcHwXbjRUxfW7sdudgTL7S9Z63IYyfzmrjZhgmG0Ew6121UXZ1n5VgsqnJ?=
 =?us-ascii?Q?ov6b3lFuqykqu+xe7hlzP518W7OWp7ZvOQEk6bapPiePDgwUwbEj9e1shp8v?=
 =?us-ascii?Q?yR5Q6t5qZaG8sH7W1xvoIZbyScfYeXkLJJiITTcdFvZxjup9ji/yQEoiDosL?=
 =?us-ascii?Q?sLKiAt86+rG9yiUgt7Q5GPVfQF/qPY4xaw6u0XkvKU1liptMnCekiQ+hlkDP?=
 =?us-ascii?Q?vjkdH6vFX+0RMbnBxIFkWSNWCwK8JDCU5i4OO78MmuvFGx450k5nISl78RbO?=
 =?us-ascii?Q?cRyaDJvXvog6+635u6RaQpL2qapfS28tKBKaSjqyw2DljlPv8VSmKLluiUrl?=
 =?us-ascii?Q?mUhGs5DrURDGtU0Pc8g8JFVfGnN1HD7XF8FBervZBW8Ws1SUxotx0eQhqJ0a?=
 =?us-ascii?Q?M2NOOjdvxP2nyfQfUgIXZiyoBTdsJ72GFLRtUz+zSdf3xYETcJj65jBJbGii?=
 =?us-ascii?Q?HeeQi2rgQ0y+RoP8b2DDF4iGu3mXtzluoj895fL9dM+/zYyrnRwMTU+SQ8xv?=
 =?us-ascii?Q?q26yE8onIIqVXcEKaaRjjOLvoAfxTf+zXv+XdrS147mllhJUIhbBtu37O585?=
 =?us-ascii?Q?31hCampcJDUmDyinjZOLFt/mIWIngayEJA5JpA79pdlzqzR3tns1FErOuDK6?=
 =?us-ascii?Q?ASdbs1Qx58VW3Or+2jpTF5/qkoPWg3atbOuyIlKTs3bPBmFd4GpUxpRtD8rh?=
 =?us-ascii?Q?OT3MHwqTrwInH9GHx2Wu0zLnfISqAee6/f5PH30G83oFPvsDspuPcbEHe7bz?=
 =?us-ascii?Q?Y9zkB7E+deHkA65LJHH1LUqe1RwcceWdNTXwAZZLjRurJH9YWN2PznAg01rC?=
 =?us-ascii?Q?/ewYPnps5yHyzH0tr4VVz39k05uEwHLFn+0VQAL0SvPH85NmesOsNvA+JObi?=
 =?us-ascii?Q?hx3KX4PZ8pMkPWT4z5zs/f7isvFzM3b0M5WrhAcWKyzF9n/Vpus/Dv6LLYip?=
 =?us-ascii?Q?lmYryBjydvkcyfu2RArXwgE6OYmIWHXD9gUJobTp/EopOySBhIyMmfs62kfh?=
 =?us-ascii?Q?x7r28S4MS+3TF0Jub0dcs4Jddj8LbXdiG3forRsmqwe2XcqH+rAGNnP2cKrZ?=
 =?us-ascii?Q?88amA6RJ8qNYxoZ5BFNLn3E0rUz9RQSnFmfP85PHlPLPXSXMby3W3DePRb4q?=
 =?us-ascii?Q?lTZgbEEbnJFvhiW0lDJqiW7KTuG1FP0cAXhw7oCX/ArG9IbXq04J3vPpT71f?=
 =?us-ascii?Q?BPKC9lEd0rPdbAh3jCqmhzEUmqgofDVj0pdYZpOwX3MJQZ0NtJC36GpP7lXp?=
 =?us-ascii?Q?dLxgt831wvu6VmEtxACRyhX3NcPRyUmiMFoQRJN32bmK0d7j5YF3ZlyDmc0J?=
 =?us-ascii?Q?NGymbJkXrM+Vy+vrnbs/yK1OtEfeWntfERNKJqxs5DXpyQxX7O5oHzlpF7oZ?=
 =?us-ascii?Q?vOQTSqvmZO3aOYGG/KzjV2s7RtjZK4sNgtJvtw39orw8GTpnsnia/0ToHqau?=
 =?us-ascii?Q?yHPeVnMRRU15pswKAlfCObUM9SPLN5ntXZWUvM2NSj6oRyNkuirSxaJ45IHj?=
 =?us-ascii?Q?ZvFmh4hJu7BZZ5W4yydzvF7amdRje8ayCSIEBJ367tEZvBfkQzMdEXS4nqZm?=
 =?us-ascii?Q?hk7inmoiem6G5wyV4DlLLlMxgGMcBQKzdHjjqXaUEI2vuZek9kFd9K7qdpz5?=
 =?us-ascii?Q?drcYtRHZiZSqCLzqrM8X8/T2N2bgxrUkES7tg0ArFJO38Mme2x7ZXj7JPYUT?=
 =?us-ascii?Q?qy8IW0pcKX9dPwqCopXUy1DIUFNeNaqSnRCqT7tlPJ+c4vfG0UC2BYZsOjRa?=
 =?us-ascii?Q?eOfgsofnS/YAhF2m6IVGEQavMIgIGYlUZ2U3kFIK0T9rn3HVnbGd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c33c08-4f94-4a35-7a1b-08df3e444d37
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 09:31:58.7037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcAgRokysWvEwcukmcRJFI/DuH5fsUnudVqlM1Ucvf0ctpe/Gyu3JR2jNii5vZ2i57rgr3GRgvPK25NRfg9ZUk/HDtR1h0fYQOosFWRqyajEm30zlICWNrPxc3IccBYr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8072
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FORGED_SPF_HELO,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,T_SPF_PERMERROR
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 09:50:29AM +0100, Carlo Caione wrote:
>The MT6365 device tree lists mediatek,mt6359 as a fallback, but slave
>selection compares only the first compatible string. Consequently the
>wrapper reports that no PMIC slave was found even though its existing
>MT6359 support matches the node.
>
>Use ofnode_device_is_compatible() to consider the full compatible list,
>as the regulator-binding path already does. This allows the Genio 510
>and 700 USB supplies to be resolved without changing the device tree's
>PMIC identity.
>
>Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Acked-by: Peng Fan <peng.fan@nxp.com>

Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBCEC9832F
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 23:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D151C60642;
	Sun, 27 Sep 2026 23:57:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k2oQLW80zGgb; Sun, 27 Sep 2026 23:57:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2067060686
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790553473;
	b=QzdbWuXGVQ1esaA+ikpRCcbp4Pditw3UcKPn6fAq7NxX3GZBIR+v+Y4ba2EzJedUTF0B
	 d7FTQdJNuR5pf1oIt+SeV1OfNNfBnvxlQBbMfsRE0VJyCcm43m/qU203I82ebqYdRX5sy
	 cz0Jzi7bWse9qTR2w32BMcBd0haO8eam5wPSM8a3LI5xDkogcqfTv/mL3Rgw3iSlgClVM
	 4iCHhfcuy2kwIiCbOQs0c+dHYYkPxxnufOx6M+3WpOh2ty+tjDEFz0arPjRFzu3XmtHwa
	 +isrH0rgwmpJ4WieMkYXlkiOxck7Ui11fgX3dD8uk8YHp9XxviGXlYxiwEcGxsa44Xw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790553473;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5RgpnMGXx4vFxw+C7hYFbUn1trDJLJjp3uh5wUeLLWU=;
	b=CCX+6nB6iVaC+jIEOUgXDE2tgSkYOrj9vBylWPjGXKA2yGSA0VxHHMh/RipgoFcGGv9Z
	 OHj2xwV7/NhJUBYuCEbk1b4poGEjQx+6ZQunLe2UOIvvjXOxb32TjulreBaH/a4707XYQ
	 iFPGQEvEzUPJxxXhMWNtmUzhMdQhcuZK+iiFavzYYEw6XGWW3K1dqYoooIHlfN+B1RxIc
	 vNW+OOpAisDZnJA0b1Us1yrSdzYn2Bh6S7+wkibJB64dd6Wur9G4v/mR1TId/v2aU2aHX
	 Kug0XyZPVEDclMM/0yxpbKqW17NxtcwTiB2xFTXHGwprNnlHkdfU3uVlOtXZEIZPHmw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790553473;
	bh=5RgpnMGXx4vFxw+C7hYFbUn1trDJLJjp3uh5wUeLLWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lnkpej7S4UUFc61Vdn8Z8ebdHoITHTBHAxX4kPNK0+M+ZpbuN1Key5x/fGGrDJtHY
	 lYu53vJu04AEGHxz5PVcn8r4yBwRtLAMCEpK8NA3lg7ztaBbnGSJZPP4gSw8/HfrQM
	 jS8z65itdAJAiM3okx+pwKRhuTdTQ9X7bMHCuvOPO549tt5wNxiUHVJ7Yr879wngg0
	 cjMHQb5i7UePr8nBbz+5fiRGwlKcAa/6IR2itM7n4FLG8Y/bCAqHrRShDAbRKkWzqI
	 n6/1++oLYrMZeOJEmypcW/oU4D0jY97x2bNcQD6y/9xIXM+Oo9l/NL5x8CAUS19Mt7
	 KKt2tIRCT95Sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2067060686;
	Sun, 27 Sep 2026 23:57:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 413B524E
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 23:57:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26CDE80E39
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 23:57:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u9AKqmP9SuOm for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 23:57:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A1C4680E34
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790553471;
 b=qTMg+NkPO1X2AhMY2I3U7vYJlpjbgmoI4YgWSqnl+JLTGKpiSoF/sDpfcKAURMR0N+3J
 ydkgRPKinjDQ72qH8/aY4sUI/n7qHVN1MNDDNhPjq8heUAlnyRgkyuiFfmXUke92HTYLO
 j8/PiquEtHqUwGWatuGVBc0ROkxTnTdOycRXzDUEulbuQwaoZz89ZArp1c9wxnvK5aeuu
 BixmdqCxRzC2O361GXNlPA0Xd0W4GFkvCaz2aMq5FlVr3087IYoefXfZRT9QnhJI+qitA
 seVeSyOH5GXqfaeyQtMnkUXeJht7kbHFqtgGcH3aVBN38f0wLKm4bs1XcI/M25b8skA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790553471;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=5RgpnMGXx4vFxw+C7hYFbUn1trDJLJjp3uh5wUeLLWU=;
 b=V63dMWy3Vv++m1qd3G6Briq2W5q28E692NR5Fi9hb5adzHQk5sBwkdLzWbun2LRZhazN
 HiGl4KlrL1W9y0uvXl7uGos8tui8XT9a2U1Eh6lLTOPrUNv3faktRhhuKjQY2ngeacRF1
 C1k40zEKYv6sNDq6+ocWdjuXjGDlCWwRhet+r2SgzOFx3eCsXKsbG5JXG0rsed4+FKY/p
 Xr+oYhxjHjmapL28KewlPZTRoyL7XyN3Naplqi63eHsuXS/x7uTW0mOnm9k2gIU+NOiYs
 DZ0n11KGPkozyCuZYt3UDXIfT8rZh1P+wIhQ9MRHux9Ykx93xYu6xfvTSZT5oKEqnAQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=iopsys.eu; 
 dkim=pass header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=Uft6ROhd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=Uft6ROhd
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A1C4680E34
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 23:57:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLU8cs+nFI3crUL6/519C0BrWCTpb9dU7HJgyTdt/OutKE40Pm/FvycimtyjrrL8ZBWuS1HrAWX0Bq3Ishz2C3yzQiMgTpRWboJ4UkGdqrdLjI8iBdhAcuLa0QkuEdPKAqFa+QGottlnV6AZjBw56yjzNt6lkuHUdGDGq8Y+nx4t0lxAvgahHOIp+SPnZcAfFM53T2mb+6uoT6oFitzbY1mgA7jYk8PWjd04em0dfG2fU4UIH5mSbdKLJV05b9g2MUb1fAvH16ZwHbdQbns/2NjGU4UGhwx4WGi5FwZ98ztkwgsXMSkN4l9G6ydS2IMa89VBwYwbBNvEHEwJD2tuDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RgpnMGXx4vFxw+C7hYFbUn1trDJLJjp3uh5wUeLLWU=;
 b=qtEuI+r69X2OC0i6xNuR8+rJSGyKzyff0R9Pj0WgMuzCB9e5inBNUuJwXJhu+0U/iDC2UrtWktkhLwLwksLQKCipyrYsylajgSBT5evZSSu/02M1Gh5/EjeXtsDPEiXoXmSJKikHcdgx7UIFRK9G3C195Nz0A/R6Gc61C6KC8jibEdPfDhCThrYybjC9Zi4OY5e3Dg6hgRdFfS2cg8LoEb6ca54zv9252S6OigJVVOF+GkW7cRt4s7B5ZH82hanfcEALbK+29DlJ0OcZcvUE2vQVup1HjOOEUxM7J0zrIJZ+1MK4xImuObD2qw5LVOzlZTYlHY6ythAx7zjMC62jHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RgpnMGXx4vFxw+C7hYFbUn1trDJLJjp3uh5wUeLLWU=;
 b=Uft6ROhdZSg12upPBSWLUTe0LcrYiw4hurzxUu84h1+nfR13Yl4eqdiKP2K7gLZfldXoscce7XhTUxyBq3+oHCPUcVbBgunjyCCxEmC1powelBVvbyww1OufxMKbLFlCjmVry8k4QXhBn2Ooj7jik5bBFyNv2D90SkToyztwKgCLsz27rPNj4xmsKHGAPFu3RsJBxUTLDnKJS50EJpvoZ85kzdBcLALUEjxzlqKpTN3tYpMZo5IU7VMuBlYMaxOnm9aK0NzlExmAQ/yvWSrnubMyJFoZmxYB3cny+RWZGSxMA/9Nk4/d6ZKi38Ks0Wx5tfauPjFbs9SlRxrEBWfv7w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DU0PR08MB8347.eurprd08.prod.outlook.com (2603:10a6:10:409::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sun, 27 Sep
 2026 23:57:44 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0472.005; Sun, 27 Sep 2026
 23:57:44 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Eugen Hristev <ehristev@kernel.org>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 2/5] spi: spi-mem: Transform the read operation template
Date: Mon, 28 Sep 2026 02:57:13 +0300
Message-ID: <20260927235716.1872707-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927235716.1872707-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260927235716.1872707-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DU0PR08MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d83a3ea-3996-4537-1391-08df1cf31fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|366016|1800799024|23010399003|10067099003|11063799006|3023799007|18002099003|22082099003|56012099006|38350700014|921020;
X-Microsoft-Antispam-Message-Info: HWFFgfHIYeaImwtufXHWtF9xdGEbN9xaH9NhuO4XTwtTGvohe1awOoS2i3zIjRIJQ/OwxDukEgasChfs22vTiDioKqe46Wwa5Qns20paZUp09Ku8kl/ruIGTTK9T7taw1PkJ+c9eYZMzteu8CjXzJ+C8Qw40UgJEKAwhJkv9KAzwlxAYyy19Zr6TWlmT1sXDx0udo5AA14sc+58p2iFbHgGNMnkA2dqMl1skB6sKzTG4bReEXx1NLl/WKZ8LzNxQRikZFUg43ck2flEV8S1KrRNnetXlH7Px5CT1KGYeDcFgRXy3b9RI9u7kPGZAV5SsP055iuKoeXHvfTM9BheH9ds2h2w27rbznTGXumvnbPtKlIBZEKooyzC8UVFHv4LFmRSlXHfMChgxmQBjWXLbAONjF0uRUUpfZGeyOOfmb2gY6bceJeyK2cGkUiHPQ8QNjjn0QRxDW/C42F7/0C8CGARJPIWesxij0PgY7paVLWCmAchQWjXdFCmQnMx+JSoHxczcl3XumQ+Wovyx1HARzvvhvKjesDqjxJ05AfEstfrU1PqfOMHhoo0TE/7FtCIRaSEjeasa4zDx30Wt7M3QBPEXauQySEtbR9WrY8VzOAe8Nuh3ieTzZurppZLb7TGIY7mHiELyT3a5CoZAWB3e2PaZ3ngXywG5Rg/O/THi9Rr8hbZp6L1s2n4UI8wfQDEFXUt0b2VAcF+5W4DXR3kYWh+BPWTkHFjeM1Pq6sLTnHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(3023799007)(18002099003)(22082099003)(56012099006)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x5eykZor93aGUgTbR1T07XtAlPJV9nUe+5Q0aT4onPkS9lnc46llgcIl8L6H?=
 =?us-ascii?Q?0HnVX5qKAXV7/YYYKavHNoh6WBfhfb1he+PfBFeXSbiqKeEJdg3XMWXppLzk?=
 =?us-ascii?Q?e/bO96Tj7vLYaNIAS0ZSC2ro7l0vTm/nIybWKqOkMJtzWpyAC2bjjFPGnaJ9?=
 =?us-ascii?Q?BBtAbEHirxD14N9FJa51qyhMpwEqihwpcNcb3/GZgjpOQ8FuVXsOhl9ri8oo?=
 =?us-ascii?Q?OhTwgCzXtyG46IFZva3atW84lHN6GabKIh1IvV+RYyp7ddkFcJQHChTSOYtF?=
 =?us-ascii?Q?WhwQ0pOMxAXc2yQ+6DuaBb5Ix1MojoQavSiMTlF8eBnLYoCwxqPjapxnrFuB?=
 =?us-ascii?Q?8BbFp/P+3vF6MOvG0VOYAgx5NwYgPkGZEwYIfDxuXmGMk0HsTZZIQ1H4UtvF?=
 =?us-ascii?Q?DknJvidCUbdw5NJtcYkVc+zdb7P1fPVeUc7eSmGM3MGEEZDWsTP5pKIQL3TS?=
 =?us-ascii?Q?cpMGYZEeZSoumY4wP4K5NmijhjD5oeiWWv3TxcY0Yx6aogTNu7MlZobF5964?=
 =?us-ascii?Q?3ryd0oDfaAs2dlvFvhNAUUcEKLbtl0ov3ybD76Rs9tc/zAcE9NzXgDF2NE5P?=
 =?us-ascii?Q?K7EFyRkxkQJBsQGdQBGS2Sa1g4GiuO7qoU667qr4L7ZsU9Fw6r8ES8cNQXvs?=
 =?us-ascii?Q?GeD5Lpg63GPePsn8W7jQYaijguSU/3M0/343hEpUPhdfITjXjMOPGJfIpJjy?=
 =?us-ascii?Q?C7krz3UlLT7VsX2Hkgf31vDh8hWHqQ8MH/MVyBaSz7v6b/OTPWC632+KZh+F?=
 =?us-ascii?Q?JHZmloC7FhLBV9fvGoXpQFVIEQaMkPnBoad+YCD+uCb08IPwpY7S7OheX6Vm?=
 =?us-ascii?Q?j5rOgrNw6k80437Xy+uzehG5oXjWiyQfZJY3+71LuyN+LfRSGOtiCUOZIEak?=
 =?us-ascii?Q?nbg0dsUmxypj36ZDMvGVa3VdpR/lw5P1rVynmCy2+hvg51sLVlrhhtzbfUzT?=
 =?us-ascii?Q?SsqzaIs3TfAWr5csvzlzFaV2YXe+6jmTz904NyC6CE/q2UZ0oE5hTjHQUz81?=
 =?us-ascii?Q?wEw26YwLsoSsV7c7H7JqiUNgFZYMxRnQDFKH4to87s/neUSMaMN5wNGe3Xiy?=
 =?us-ascii?Q?eMiI5nqdZ45sH9WAYO8cKfxUL/NuSrv6iegtDJ+K/bbQAPHC2wZ3V6oLuQaM?=
 =?us-ascii?Q?Qu5yjGb+/jzWzUrmEpbamJY/u29DZISpC/iWgihYU0B/OsvXIfeZZ8esiwdb?=
 =?us-ascii?Q?GbQDwRu7Iz5yDUaUY6GBVaxPCbjYcMhQGSrNB9bVUSVS7SU8vmHhF3nF/s6z?=
 =?us-ascii?Q?nWwmq5bXvAePG/z3QzbPIuDV/mS/Ndh8G+UVXCQGVo046Mx4+7u+XdsIXYj5?=
 =?us-ascii?Q?2SzBWaV+/TDoqGHqmf8pDo2ZBT37nmKlvbT+mEpysUvnFSWWbp04SEG2wHmi?=
 =?us-ascii?Q?F/AzR8HKZ64YSR9aaYLcBUqWtuPUzGZb9Jf/xvhFIRGmKe7iOfooXn0X56MV?=
 =?us-ascii?Q?rsChcUjjg4l1lMj2u82KZTyoXZ71Mxh0wkeZpogxqB2Ny7RjcRVUU5zFPt8a?=
 =?us-ascii?Q?Y5tEwycHtmMidAwIKJM7ejebPvO4QLw2InDu1rLhyGHppHWPqhK7nQdgZwzI?=
 =?us-ascii?Q?0RkNGrGv9cvEwnrxiybR45HXaGgVUoKq1maODPSwvbG69JrT6axKwmzPzOsR?=
 =?us-ascii?Q?qxt8OvdQw0sNGGg+jhJjMv4cyQtBOCyBZDLvm8ZYW3mKGFGWdDD5x1VOYL0c?=
 =?us-ascii?Q?A/1deGpqEeh1MeyCBNQqiH0dvSvKcHfmCwAL584WLxp0VuUwSQuPyaJV8hQm?=
 =?us-ascii?Q?67hqKOtXQiO3mARZWHi2dQnuHWV2ftU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d83a3ea-3996-4537-1391-08df1cf31fad
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 23:57:44.7572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ouXNyr10u6RVh+ShaaB66u6qT9kp1tXRN707q1P/Ov3WRuq+Qy6S/kh2WC9NhfiytgjgPvZWskPA/qhCUI3E4N6hd2SQ1y8LQNSF9OxcDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8347
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

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
index 14af4264612..5c54e726c4f 100644
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
index 937d79af64e..88312a38338 100644
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
+			tmp = nor->dirmap.wdesc->info.op_tmpl;
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
index 0186b01ad9a..83eca25ecdd 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -732,13 +732,13 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
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
@@ -795,12 +795,12 @@ static ssize_t aspeed_spi_dirmap_read(struct spi_mem_dirmap_desc *desc,
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


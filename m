Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82423CCA46D
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 07:27:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BC0260B0F;
	Fri, 16 Oct 2026 07:27:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S1Nwv0NCq4sp; Fri, 16 Oct 2026 07:27:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 75A5D60B10
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792135660;
	b=WKs2R9bjT9scAnTtmqzBsCXunUjeOw0Bs1UE001oa8nIlLvrKctsoJaWmOJIVmPQK5+O
	 yBZ2qSBEMIZEtDN7xrp/baIflP1ImWG3ntCxr6QrSoC/5jNuHP2P7AHkYBsEgoeggyRQ8
	 Xh1SulZC30EtafBY2DoPtNS59MSvvAMTsm4tv7SX8zd2q8eNa7muFOZsJURyy0Ewm1EeX
	 lAChFlinKLxNucL0eb2ZHrpP6ELCCUwWUgt/q0AOZfAMoRGsrkrowxRuWSG1E4d3X9HPz
	 z16Cn2OMpz59X5d7JjZGCB1iYcvSYsAm4vYH4dUfHH88sxeceX8bg1lSX1EAnAA9D6w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792135660;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dSgFFQCRqkxRRdekcQiAuratrPN7FFDZvaMuqGTbQmc=;
	b=Kwhd8cRPsFjwVWv2OdjGWeA+4ZjzZCiT7Tn5jJQhpd5Tz/vn1npqZKS2W6Hm5e8qgFlZ
	 e7qFBCs2Eje6WXxmVA1ffzo/AZsTGopcvtgMW7nBAJtMCeSQBRjSrO0UwNukAcRADt3kd
	 SNVY5w/JV7nc5dj/l3eaeiJToTUZafnNAZXyjXP9SnDZnwVnFMP96QN/0Ep33y/aXoo4o
	 P92neaOIElJeEPrTnm7Qfm76W9lcAvDPIbU6WBnQkkf55K1W7ch9N5igHHDcZgz4a2tLw
	 IPrX+TU5ysmquczCvocBp8gjF9F46cY9gvx5ipPzMtsWoFuiZHTWDUu4/4xDmeWpR1w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792135660;
	bh=dSgFFQCRqkxRRdekcQiAuratrPN7FFDZvaMuqGTbQmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ji4s1kaS5gRFof+KwcWipts/jVnJmEmHUuwHpQlZtg9yl7HAfyEdkN+gvgqtXGIdx
	 s3+RHi7bRS/IYFPKoUm9kejrX6vO3Lu76fux5KbHVvNfN7DcvKitCRpdmaiQqXhMAp
	 zYmTGU87WarUneLS3R+QFhg5+cATEO46iwqqiJ7LjQ7pSSipNYNtoMUuGKcih8o+29
	 WGUb6keEOUZpMjfnfmelewyO+VYDuQho1tQNVzaQX7CGeLkYnWZjUPTHgy2vjmwJkT
	 ELy+pwioOWWkC7I1tylDesjjYR/iX/xV4NYYlw9ukWE8DseoHbV5owUeWOjDVwbSGp
	 92NIZMqGRXkfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75A5D60B10;
	Fri, 16 Oct 2026 07:27:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1090E1DE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EB00540050
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DAZRpX3WaA7P for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 07:27:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 118644009C
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792135652;
 b=MJpe5QK0W8R6s0kER3UY3vR/eriWLmZQofKsVbV3FsFp408lz6lamSpbCJmuz55/xdjp
 hV9I27/XoVLb6VVFo6T3c4TEqqhe6NjwIqBX8eK3jv51t9yWgq6MDnwPi00UJ0hVq5a1R
 GsSgoEzRx2Y9XzF21XmJ2LHSZpYXA0/YEArWiow509kw97Xi6LSjEz17jJUh75RO/virJ
 9Cq74WCg6V9xAvvHJZ0AJy7FYqjXMtHStCfKiwmRwjOwGjNuDmF6eynvbDKpyoPXP4K+M
 VL5ZdbF8IT7Gqc+C7cbvT6pzLpmBo1VW+OG+4YD/v4KozMWM1e7DdcZIkn9ErUF2bVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792135652;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=dSgFFQCRqkxRRdekcQiAuratrPN7FFDZvaMuqGTbQmc=;
 b=QsStlTTMIqtebTomjAk3PUylDGNHGx1KDGemhWR0n/Z+ZFxHx2Fior/I7wiYpfhCuKow
 Km5jNpPu3UhDQLCaH84Ze9lV0O93RhPUsxZTSBR2ie+yTB/cMkiO04AuxkMl9YwznQ9mX
 SSUD3/n3qjlhcGFhAuKUuDbUj6pUnHkCdcdSMDgE4Wje/hYJT+Yc/UFm7V9AqVJdlNYb0
 ZaNoA4IMLeDbeGD2E+eRubjRH+oVtQbBOquvIMylKc9OJXRl5ZlrvEzW95Dn8bz70JKpb
 3Uu9BHsvokCAF8NNfITnhAYaosvYbDFsbVqlnUHByQNlaRQ7/m1s/dlVUTZm/w7q5/g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=emteria.com;
 dkim=pass header.d=emteria.com header.i=@emteria.com header.a=rsa-sha256
 header.s=selector1 header.b=ehVXtHXB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=jan.kehren@emteria.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=emteria.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=emteria.com header.i=@emteria.com header.a=rsa-sha256
 header.s=selector1 header.b=ehVXtHXB
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 118644009C
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:27:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRQVIemYPAsh4fJ4Or3QVsGpGa6XNvoS38Oj8UrX/+1WcA3yCnaiklzUifsmFGRLw1xMzMTiWLuP3uZMsoYHfGmloy5BmRclSx6jrhvKWqgYXaTFze4KloSf7d1NdVoxZC0oIemrEOGIKiVmouX+jJdLqt+GXvXgWCtmmWN8HtzN0fkMYoRwbVmsPLIA+z3SxTp7FzRloSs/BqhBCjcybWbZc5Uud/VypNC2zv/f+d+2cAh9Ct99RjCP/RbbbeIrtDErWp0Jn9vizvekJuPx9tRcQmzrXWzGRc8jrvp9H0OdO5ccekW2NPkKYCSCFTBGpgKygKl0xmCPIWEfAhGRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSgFFQCRqkxRRdekcQiAuratrPN7FFDZvaMuqGTbQmc=;
 b=Hcy0i5IVJ44gdunCTlbn7W0fUOPb6xwCFbTSsXiGi/2ALojipbEVfdSz03j+Ok6//vIsI2bns+BH/aBK3S3bs0eGHtMu6J8/ZHyd0TEeo0J88Q5TuTB0cuBs54zK/C+0h3nOfNv2D+Q9nMf6OJwWDg+1yVvFuNtManST0XHYW3YmEBWU0PzVfhfg6QrnS3P/4lQeGKdsdzDE0QOhyNIpsC/ozd4uA819h07gZ96tke2AgownCSWnhNJn628rQqImM3m/BgMEu+2Ch2+r6eAqmnYXZ4JiGx509/Npt1qw0xRiij4Q1TkZH34iT45KdqYEyWih5MR0KQ0ZGKWm+qdohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emteria.com; dmarc=pass action=none header.from=emteria.com;
 dkim=pass header.d=emteria.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSgFFQCRqkxRRdekcQiAuratrPN7FFDZvaMuqGTbQmc=;
 b=ehVXtHXBs4K5QP6Sf4SuORr0qi3rGRZvnlH6dgsUckbXeTYxdB+LHWsTFnjMHjn5QM1w6ZGLhzV2KjMdxn/9MnZP3qr0rgb6oGSiAoIiR3/57m/4Y2JfEcYpeRuVFC9DyxypOh6sQi+KjuNfzsizwL2YR7n8Po9KOco2uq7ZpIY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=emteria.com;
Received: from AM6PR04MB6662.eurprd04.prod.outlook.com (2603:10a6:20b:ff::15)
 by PAXPR04MB8559.eurprd04.prod.outlook.com (2603:10a6:102:216::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 07:27:21 +0000
Received: from AM6PR04MB6662.eurprd04.prod.outlook.com
 ([fe80::8a0e:d777:59b6:f25d]) by AM6PR04MB6662.eurprd04.prod.outlook.com
 ([fe80::8a0e:d777:59b6:f25d%3]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 07:27:21 +0000
From: Jan Kehren <jan.kehren@emteria.com>
To: u-boot@lists.u-boot-project.org
Cc: mkorpershoek@kernel.org, igor.opaniuk@oss.qualcomm.com,
 glaroque@baylibre.com, sjg@chromium.org, trini@konsulko.com,
 Jan Kehren <jan.kehren@emteria.com>
Subject: [PATCH v3 2/3] blk: Add a name-to-interface-type lookup
Date: Fri, 16 Oct 2026 09:26:38 +0200
Message-ID: <20261016072640.772964-3-jan.kehren@emteria.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016072640.772964-1-jan.kehren@emteria.com>
References: <20261006092732.3577974-1-jan.kehren@emteria.com>
 <20261016072640.772964-1-jan.kehren@emteria.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::9) To AM6PR04MB6662.eurprd04.prod.outlook.com
 (2603:10a6:20b:ff::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6662:EE_|PAXPR04MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 42da151f-3fa2-4f45-c3d9-08df2b56eade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10070799003|52116014|18002099003|22082099003|10067099003|3023799007|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: iR5u1TaOpx9VozZwHnckPdcCN8pTrXG5h6trvYR+xQc2lzs57DJlSZw4f6fdLvsINpHcydRTuK83Ua00RGdM2iO7hzf1YIxNm3d+6jCL7w/fRUc76eL3UnjsjeTGa0svzzlBZ9zBTWhYQWF9G9NSizOFKpxkg1AAQXFSpgxlcWQ8YzvmHELpDJLiWaPm6hGfjBAARuKoXIbm+030MJE9kJcgkAJC0XUYCDvJuwCPZ8aTalTF3PGE+UWs5cn8fyXRx3u4SSzQtSPxT+5FbZ5XT5GkAr+DaHt/Xmsn1XHMH2srrXsv3O5eo3hcmG1wOtcuieBHwF8WZECV6b/FTnm3iEZkqxxFpLYY8pAHiyUoq5/hjcTKsHvlvN4p7popYGsZCgfrU44iifdzLpf6E6XFwoqycYr8NXjjYSOh0Bd3N0YmqCtyXcJSs5q0m12L0p1C3UrNK4AMjD9qePhsxJsZj9Ob3bmYgCrujsUfDKXZI1gCe1IX1g6gXEasGaoxwbzIgwsySvNKQYRQwnSk07tfursG1B+ZJ1XXiRjtTl+CKzOtgV6fd/wOdrEgBdJvt6EdyGumXHBmXGUl/fHq8Q6Ig1bij4t3kklwpyxyi49IZT3kSQuf0nMadh83aQNlJkmWAVDoJL6rRly2AuGSzpzgS7i7hvs9O0yeJuyQT1qnqPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB6662.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10070799003)(52116014)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1bryncs/jhKKx8TMcSA5rT+G7t7HDAHFhzg0UKyVPe9nWmRzjIapE7LHZa+/?=
 =?us-ascii?Q?Aff+YluhfxzuK/LjeM7nqJ8sV8V8T2HCAYm1Y0/a71eHmMnkYYxyemPHMZ/i?=
 =?us-ascii?Q?tfdWlF2eOgZK+aYfz8xdXlNtRsOYebA4YpSBmIgfsLPrF0NHuQOKGFuPl4z9?=
 =?us-ascii?Q?J0X+e7pLKUME5WZu5NhCxCsmWxKAeISvWWvEwdJNLnVtyJ1prTNlXkW7Qhv7?=
 =?us-ascii?Q?+NJRfvB0XfLKVo3rES3zTWrOTDFWmGNDfaNdXcXW2HT/RkUhwifiuVAwhrru?=
 =?us-ascii?Q?yJjDBIp+ELFlk40vXI7afjoqSIP2hq2StWDOzFYdnJFzs+Ea0WdA0zpS5PXq?=
 =?us-ascii?Q?RnyH8+/PKyot2g9It+5xOJW5LGH+RmvED9xPIiuKEE4ydI567xnzk7EEUoT9?=
 =?us-ascii?Q?U3PD+tJkVGy6S3MRTnEIRI0XiLbsKaLj9wa5bb3F7gteVROY3/pO7ycFWuoo?=
 =?us-ascii?Q?CfPmjhYZ7YqkVPJeDdgD9pGBljbEd9A0JpMoyB++YUDZuIEhQR97EkpOxVAb?=
 =?us-ascii?Q?DD9+lphS6vF21NU8/NbrTZ0MaA5UG12RoUCiorP38MEnsdQVPps5J+iF2sQO?=
 =?us-ascii?Q?GYKZSvoI7TUL+Nb+yYMntR3cLs3SjZDDJAzfLagTegzO6kefj65Gwh28P/Bc?=
 =?us-ascii?Q?HSyoLtRTci69XhJ8p1hTS5PFNWi80M2qIE1wxL15LgwRVk8XgUS4+263Qn/W?=
 =?us-ascii?Q?ix+tmug/YB7iF5qSjlgt/n7BiZZEc/xBQRW4zwOeMmi5QLXWulZjeMlDazXs?=
 =?us-ascii?Q?NBe1kSWfrX0anP21/r2KkfR5J67p4AYlBlxgh9BDPhE/mY3LTXJik4k/z1tk?=
 =?us-ascii?Q?pL9eyTPMtcu6+32wiEnSkE3Y+ZLQENkQdNnrs3M0zSbP/rNKa57jS6TWFQ9j?=
 =?us-ascii?Q?CyBvpQhPKnrBYbR/W7RTIJwMd3+LKBFg+dFivzxVC+CescMhtWM8K/zu0g1f?=
 =?us-ascii?Q?1Y+net7Ao151GbRwwCwCHZ6EhMXDtkvDAB0F0EgbLfpaIvj3wqkyn44rLmT3?=
 =?us-ascii?Q?eNwv2pgb9TJtck1spVl69VovMT2kDsfWyoS5dnGhxwMEeavqwWoEgWc/DwpZ?=
 =?us-ascii?Q?wQ8VDWH6BAhikQNyRPYmSC8hZj5CYtaAXibS6iDSW0GclpuPNgD8510nXBhx?=
 =?us-ascii?Q?EhksAc2jD4DHU/iLx6z+bxd5zj13kcWIPAuli8K4ANCH/oqgPT926SsZaAes?=
 =?us-ascii?Q?zfW1Ao9j6zwPU7os2NdIcQ3l5rpdquTKgD1/0cLvi2E9EYrznIhcR7qw2huj?=
 =?us-ascii?Q?H/gA8l4fE7+y0jgNEtulitEXWQEtlWkhoS3QRchT4DzsCOTDRYAU7krsvMcH?=
 =?us-ascii?Q?Sx3uslxpFz23dfObC5CkaqU23Z+aFpF/CQ9Ljhu7YIqGV2p0hFZVD/FklGWP?=
 =?us-ascii?Q?opUOUa9pTcx4EQMXSv64BKpUZYOfvpO+aHtEyVg1KwX8vpUsiEhlboSYJ6sM?=
 =?us-ascii?Q?q58R9eVOQ9hcJKU7luXJIW3r7xm6v1h0fLUVogp9T5+t7iS/YTCPxmUkw3OD?=
 =?us-ascii?Q?uNrUKxb0xIS7X++g7PlsIhBKDuPY7CWH7UZ5X5WsfsEa0y9qHTgywcX8U6kJ?=
 =?us-ascii?Q?XLKHb6DdAzKsDaxHe3x2AFc/0bFnd+YX+4+fTRxnbhme09+seITXAgThvemU?=
 =?us-ascii?Q?1fpkBgmijp3ic5/GIENr8f5Kaa8oiHTAae/yprqn84a43JzzaA1iMU/Q488A?=
 =?us-ascii?Q?xCuwG+N8vS1JfyLJe8811Y2CsbkWGHmmkQyMORV7fNtFW2HFtm0bNwic9ufo?=
 =?us-ascii?Q?TtCzxv+tPO6Izq9WjTyfmMkoeEcovx/DC7Jmj513qxVJvYOtMkTOTFwfeDxP?=
X-MS-Exchange-AntiSpam-MessageData-1: w1o/AUlbQi7NaA==
X-OriginatorOrg: emteria.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42da151f-3fa2-4f45-c3d9-08df2b56eade
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6662.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:27:21.8464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e416006-a062-4a38-99be-aba82ce308ae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eusuv3rmlBiE0ei+p6/ZpE6hcYWs6w5TBbZdOE4kjt3eKEw/v3UcJRpu1azOfrvgFkjeIP55i7J4eBQjlDtNRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8559
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

blk_get_uclass_name() turns an interface type into a name, but there is no
public way to go the other way. The driver model block layer already has
the lookup, as a static helper behind blk_get_devnum_by_uclass_idname(),
which resolves a device at the same time.

A caller that wants to accept an interface name from the user, and only
resolve a device later, has no way to tell a bad name from a device that
is not there yet. Export the lookup under a name that mirrors its
counterpart, and add the legacy block layer equivalent.

Signed-off-by: Jan Kehren <jan.kehren@emteria.com>
---
Changes in v3:
- New patch: "avb init" now validates an interface name without
  resolving a device, and the block layer only had the reverse lookup

 drivers/block/blk-uclass.c |  4 ++--
 drivers/block/blk_legacy.c |  7 +++++++
 include/blk.h              | 11 +++++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index 6d2161cfc7..37d87be3a5 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -40,7 +40,7 @@ static struct {
 	{ UCLASS_MTD, "ubi" },
 };
 
-static enum uclass_id uclass_name_to_iftype(const char *uclass_idname)
+enum uclass_id blk_get_uclass_id(const char *uclass_idname)
 {
 	int i;
 
@@ -115,7 +115,7 @@ struct blk_desc *blk_get_devnum_by_uclass_idname(const char *uclass_idname, int
 	struct uclass *uc;
 	int ret;
 
-	type = uclass_name_to_iftype(uclass_idname);
+	type = blk_get_uclass_id(uclass_idname);
 	if (type == UCLASS_INVALID) {
 		debug("%s: Unknown interface type '%s'\n", __func__,
 		      uclass_idname);
diff --git a/drivers/block/blk_legacy.c b/drivers/block/blk_legacy.c
index f36932183d..7ef7115165 100644
--- a/drivers/block/blk_legacy.c
+++ b/drivers/block/blk_legacy.c
@@ -45,6 +45,13 @@ const char *blk_get_uclass_name(enum uclass_id uclass_id)
 	return drv ? drv->uclass_idname : NULL;
 }
 
+enum uclass_id blk_get_uclass_id(const char *uclass_idname)
+{
+	struct blk_driver *drv = blk_driver_lookup_typename(uclass_idname);
+
+	return drv ? drv->uclass_id : UCLASS_INVALID;
+}
+
 /**
  * get_desc() - Get the block device descriptor for the given device number
  *
diff --git a/include/blk.h b/include/blk.h
index 2cb9cb31ac..5ef9129b3e 100644
--- a/include/blk.h
+++ b/include/blk.h
@@ -741,6 +741,17 @@ int blk_select_hwpart_devnum(enum uclass_id uclass_id, int devnum, int hwpart);
  */
 const char *blk_get_uclass_name(enum uclass_id uclass_id);
 
+/**
+ * blk_get_uclass_id() - Get the interface type for a name
+ *
+ * This does not look up or probe any device, so it can be used to validate
+ * an interface name before a device of that type exists.
+ *
+ * @uclass_idname: Interface name to check, e.g. "mmc"
+ * Return: interface type, or UCLASS_INVALID if the name is not known
+ */
+enum uclass_id blk_get_uclass_id(const char *uclass_idname);
+
 /**
  * blk_common_cmd() - handle common commands with block devices
  *
-- 
2.43.0


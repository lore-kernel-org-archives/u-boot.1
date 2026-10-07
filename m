Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE32ECA5FF1
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 08:05:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CAD9406AB;
	Wed,  7 Oct 2026 08:05:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TNlkoyqrD4II; Wed,  7 Oct 2026 08:05:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EA244406D9
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791360340;
	b=DXd13ysjTKVTMd+28pLZlxsfRgPNzfEeP4g19kEeyqA8GTVlhOEUS5RL6WUPuADG/bkl
	 qnjABVnOlGj4HU5Lkxw3NJgrmVzP0yx1Mg4tPA6kFHoBV5omAV6uLr2Px3M+SlsCmQnPx
	 wlS0Sm1dN8OIqFXONCbbuXetCy1Ci6/Pw0TXy4VZksSilHdRtfB2NbKVD9bJT2E8FnzsU
	 hLqkIXX8jEY44NTne4YyRLbj770iOYh3z2mFEs8gY4ULl4evLvEFsW+7lfL5lypczaOmC
	 1yozO2uqDpzLCXzgDeuV2ktrqltn9M5kb1o2n2ZHA0jlTubtL/PhySsytNVUxrh+s3A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791360340;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VYRj3fd+LdQ0G5SY3AgL9nZpJRfV5gvPt/c7Bq1xXs4=;
	b=JkG7j926mt5q2cGv4049P8sRobsle37jMw/7ZBycppjimEd1VmeVw4qY7xwDqWWCNesW
	 Ot79AqyWe1gEfk0WR6Wqvaokne5toKYFxCeFoCUhBEm8QDZPdswB8UUqgiFYoXM4Q1n9F
	 ts7KWwyIUj8iVZXafGFC1dAIf4P6apsRHwvlrpPYn/OOfoOQdSx2Xk9C9OTbzcZuSJg9M
	 dB0PRyuSX9JfF628i3r+0q1tUI0ehpSzE5JFLldB8eOzqhK8znG51VpzPEI5/KjphfW10
	 UtrWQq9/acWC64tLSzqyMf3AeyHZCLZe7thLJ54izI8t5aj29A3L/9ktDKhYsVAjwoQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=none header.from=kontron.de;
	dkim=pass header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256 header.s=selector1 header.b=BGjSvMZY;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791360340;
	bh=VYRj3fd+LdQ0G5SY3AgL9nZpJRfV5gvPt/c7Bq1xXs4=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DMVmAyR0r/J+dNH0FqubBztu8nmnto2/OAYKdes++X9dRrtD3KPYP1toXDXLabuUi
	 EJrzFLPlg8U4z5nIRXjDwCyrWjP7xsBhRYZk1julStWZnFyBkp5QlxTNYTcfNnl5vQ
	 2OP/zNe7aVWN9e3rLmhFvkNSprhBxl+bJ64betvLtNDFxtRnezvxj+h6NVeX3yI1SV
	 8sexTKyfKXP9Bph3pYGl7K1OicnuAHCCNyR8+/Nhzev7/civjUFZLrhC9TLcnr9J3U
	 Si5YHEL4NF8pzY0CgqM+TpTvGUjHFL9Yjkt35h2+X9X2OQKzRrMS21pjXYS+XCjMp1
	 Ohna4X6xlTIkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA244406D9;
	Wed,  7 Oct 2026 08:05:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A7F33317
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 07:56:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D66B40694
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 07:56:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GRNKAgbO1jH4 for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 07:56:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3BC104061D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791359795;
 b=c//BE+UP4e6KXadgtnMbAl7dbp018soRV3TV2ffcMTg5JGoPb72wADRLnr2M2B/mWye2
 IOi7OT0KKA/1Bmkklp78gaPf3a/K+dlEkje4I0XSW5CG3ukagk48t1L8ir8vs1NJYWn9e
 b+xQl/4P0ckVMpQcavPttIIolgSQvhDHQT21i9wcTD/5DFQkkstJhYCetfT0GtwrKjgG6
 2j5JhI/qeAVZ3glYwKHbveAyMfaNxu/Zlyl1iCEMcpcDoPYlQJZafZwzOlpG4uaGDT1uc
 8gWto+MvfT2QrVT6uZf/zxGqOGbrqOW8IOfJ3w67K/fMHkhW8MX2KRyMPrKKdXn6YFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791359795;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 bh=VYRj3fd+LdQ0G5SY3AgL9nZpJRfV5gvPt/c7Bq1xXs4=;
 b=VjpON1sjwXrgDBlnp0likDXSzi+ths5H9ue8mlTyzH003AjDBXZzaLpCNdleI9ZUG5ha
 CklG9sFBd6TtnWhQ1um6r/hHGr7aYPSzHT67gu+fNns8try+hE3TbVWUwWn7fkJ58xoVQ
 5f0BKbsyKj4P3z34ERhrbR7uVU1SIs+Feja68X+I404lGY74d57XfXA9BUt+/O/oMAPmR
 wcMgPkuG3j5uRjBxjrdzK3Dl7QRXnXPq3E6lwWHu82Q7SAE9edfDWf+BvNfK/6CpCljuU
 uYcauh6+hi0yoxfNwx06oHwYLCMm03G3OoROgdDm6utMnRaFXH4qXf8+spTWXzdkiKg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=none header.from=kontron.de; 
 dkim=pass header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=BGjSvMZY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=BGjSvMZY
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3BC104061D
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 07:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLeF1TwbmocsX6KSkGG3+8J7Q+MSTGgw9MSlHdsmtTxzuiN9DegjVw6C+UUZj4Y7bUxsuNPDXlAVAelnf9YJlriry2sOhuGKkwP5aSepCOTIfvAI0e/MWPB411C5mxesS/erQ9hSsUhJHke3cO6IzFXTzWEha9qbBGHMp51rdhr4Hzastlq0Iz7GZgKtZn4zI2VktiT6zxforYZ7JH5CWZkiDTZzrkLvsx1IxJbtl0TZirE0bPwmv6QfHFlOA98XrCBM+bsZg3nhyL1Idl7GlCO481UcQqxcB7MudRt3tJxc8VAxtyzys4ox8oZ280rWvyNFmMX1mFPvzhMb375J5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYRj3fd+LdQ0G5SY3AgL9nZpJRfV5gvPt/c7Bq1xXs4=;
 b=bV1ZJFEsPWNcdVZuaUH9ISt8bFcxSH4g4hE8aI/3ciGFVQD7+/nG+mJXA0YqPP0nHSsVIfSQj+5CoB4eHqmOtIJoPGVegW99JLUbxfSJn4KBm3F0wHvt2hTV6MkkKW/pV5RXGj408hTXiYYbgSAkoN5WiLNdVpvtp+G5MgIUs4ngptJquUZH0d+y2Y8nxIQ6sR+R+YG2iy1nJl3SbQlvSGiqTXZvQV6uDjT5Yj3nfNnXgluNnF1kak/QDOFWWodwefbrbb/eeTXYbJ9oZDwZO2rJtshjSgpKq2OYgHOrqeDsbzj677xQ12FXYBzEG8/OIHmUL5OIgkFhzHyZCxUhIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYRj3fd+LdQ0G5SY3AgL9nZpJRfV5gvPt/c7Bq1xXs4=;
 b=BGjSvMZYtHXuI31dvciF+1Wus+FFSFJAhWzOgk2zILOkA38I0NXeN4p8q1RUNxOrYvP6pYIi69EfIViNstAmTCGHRg3lWaiwpb5ZvjlahaSq/hMYNRqRXH3EAEGXf9RQoXKQ3ucdz3IHP9WNSq3ho5rovvupaiU+xsq+pYBekLQlwLGNbXhztONvp/Yx6MkhWfEhKMAe/9k4O5ID7UC2zSqE6lMS+DdOkR5WhS5ymlRrkPwk5+mJ1PT3urFkfKI8K+auucs1GRsq9yvyWQGDchbUyzfD/QJFUG8M0k4FkJLKlGfwm8iDK6gqPtom+MXCdJyhlWCrxMwqkr746cE5rg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e4::18)
 by PAWPR10MB516996.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:3bc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 7 Oct
 2026 07:56:27 +0000
Received: from AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fec3:eb34:f163:4536]) by AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fec3:eb34:f163:4536%6]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 07:56:27 +0000
Message-ID: <589300bb-100c-4d23-b290-8a859f79c9f0@kontron.de>
Date: Wed, 7 Oct 2026 09:56:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] spi: spi-mem: Create a secondary read operation
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Vignesh R
 <vigneshr@ti.com>, Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Eugen Hristev
 <ehristev@kernel.org>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, u-boot@lists.u-boot-project.org
References: <20260927235716.1872707-1-mikhail.kshevetskiy@iopsys.eu>
 <20260927235716.1872707-4-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20260927235716.1872707-4-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::12) To AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1e4::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR10MB4273:EE_|PAWPR10MB516996:EE_
X-MS-Office365-Filtering-Correlation-Id: ee9d160d-5c9b-45f7-b77e-08df24487d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|921020|6133799003|10067099003|3023799007|5023799004|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +4edfUwvAss6dfVhQle37qOsJaK2brOLELKm6viScS8yKQj1mVER0Vas0Df14g0NwHoftDCBwrPYdYFO/TSdHbLyPOdvaXHT8AG4BQXgxAstcwE+noZ9y7Xu6bP6T7rDT87bhh/lqoSDTqEWvqRM6k7kbB1+hqbdFMWkX6LTVyLEuKVJyO/ZaCCaFsbnE+v6o7BfXxKPT1vpCpg0Z3qH/dt+Fo/Ktx7Cuf/PcbH29F8dAACHTe7NL/HMeXe4SYYJrA0mMcPnCQG3SDCfTD5mqg5CjkA8ncQr+UW2Q6oPN8hcuwA3o/XOmAwXPJhVv6esNkv8NOX7/cBGqMLn8fQsk153NvaljCCcjRwIACX+ncMzl3ITAAeDdJXRnf4hGsxXV7b3EWgtxr7TnYUiOoiN+zGA4QAO1QQk1NhjvPZ/fNUyEX3hIIevXpv6c76I2dke+fiCvftTWvvvPZsywciJrleNGOxhg+YGlgAhqhwitFuOIfNeL3fa4DFrQ90A6caMtkvcKhxzY2ihJc8VRR8VQ8RX1p8b1nvjJLWY4GiPs3RGKrp094Q/KDm4/fzdQSG+Tq9SvTbn9euiPH4eiN16OKOkYn7WOFE5pBcQCIjXJuLFGAW1ebCwZ4BMhbpnA5edypiCzTqvaxOPxhNAcqIPxA/kJQ1j737PsZGm8pFdvQESvh43/VPCpuDT8ZoH9VCAFkznUKR3FAx1qDz5apcP1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(6133799003)(10067099003)(3023799007)(5023799004)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzF6VVdoWlpHbnNYSVFTUmNmOFJhL1ZKR0tYVWw4di9BV3grZThDU2pua1M2?=
 =?utf-8?B?OERtQmR0cEZYbCtOUGp5VnIzMHlWMzc0K2RwUlpPQVlUTktEN0xGdlU3WEpK?=
 =?utf-8?B?UXZRVVdPWC9nM2hqaTRzU3F1L2pFcDZTaE1hUFpkZzFXTGJ3cEdtQm5Qa0Nq?=
 =?utf-8?B?TmJTRWFvbWg3cWVVTmlmR2ZsM2xkYUdZNDN1TFJTN3pOK0ZpWmViUVg4dUNN?=
 =?utf-8?B?N2ppZTB0ZTVLU1hkeGFGQmVJZG1iQ3kzRjAzRFI1b2o0enJwdm0xc01aRjdr?=
 =?utf-8?B?cXV5a21OdjZjNktNTnFUNGx1dWZBK2ZhRDgxY0RWUjF2U3ZyREFMeFEycDBW?=
 =?utf-8?B?MUZPbW0zN0hWT0tSaWpVcks4UUpEdWo3NlJMRUFaRllKa2hWNkc3ejhVNFpn?=
 =?utf-8?B?eFRYQy83UnpIMExQZU1qcm5VR2RnZW1EZ09ncFBPb2JUYWtrT1YvU21pREI4?=
 =?utf-8?B?NU9NdG9JZGtkVndDZjlibTliS0lHdVRxU09ZTVl5cm5aY3o0aWlvbElGdS9V?=
 =?utf-8?B?LzY2REpEOHp0QU5DeENHZHNYOFBqOGFzaTh1dUMwQnZrQ01CbHpjZEFpSFFO?=
 =?utf-8?B?L0V5RFdZUVVsS0M3Z3QrZ0U0UWliM3RXejZZRFFzeTRBeDdweVFLcFJDejFr?=
 =?utf-8?B?SndQa3dmMmRrZkhOWlM4bisrYThORi9Pdmw5K3UzeEh3VG4zUi9UcXlMSUJa?=
 =?utf-8?B?Z1VMYm82dmY3WFVpaWxkMjR5Qk81d1VwREw1L0NKUmgrelpvTmQwNFZSU29j?=
 =?utf-8?B?OWxhVmpmR2hWRWordWlCUGtQZnlpRVpMN2RwRU5EMGdLNmVmM2djWnFjczEw?=
 =?utf-8?B?L1cxeDdKRy8rcElIczB4T2RxRE11MDk3eUM2NXhUQmV2bXFoRVVOaTZ5RHVJ?=
 =?utf-8?B?U040R1YreG0yOWNURFFWYjU0R1pPbDZQYis2VG1DMWZyQTdGQmJOVzhFUXZF?=
 =?utf-8?B?emZyWFN0bHcxQ0tlT2tYWWtXS1ltQUFISEVsMG5xSmtraE16OXhDcmo3SDRa?=
 =?utf-8?B?clltWHpJY1FHWXNRUDR5Vy9lSTgxWVJNbmFMMEJTV2krTVB2MzhIaitMMnJi?=
 =?utf-8?B?d3F3WjZpR2MzRkd0dU5ESWNMTkpCYkJIdUUxR0RTb1RRdmJmQmt1SU5Ua3lQ?=
 =?utf-8?B?TlBHY0VMbWhWN2xkaVNWdW5PbHNZRmlBKzFHMG9PaThCT0lqeUl5SlhTeEZI?=
 =?utf-8?B?V09GLzBvZ0NoemFvb1FiVXBaY0lEOFZPUFp4T0cvZTMvVzJnSjdDS0tnYytN?=
 =?utf-8?B?eFljaXIwb2VtWWpPYm8wREtLbUUrK3BYeFNZdlh0RXMzcVh4Ny94dE5KSWRG?=
 =?utf-8?B?T2hJWVkxcmRmMGUzdzExZ2VZUUhsa0tObWNMRHJzSVN4VEluQzFYWS90VDZr?=
 =?utf-8?B?anR2V0RQVzhHZ3ZKa3RGd21LMlc0bGx1WDd0TnVrcUgzUWkrVTVscEZndFBj?=
 =?utf-8?B?V1VqV2QyMkl2dkRRZE1ZeXNxR2FITmpnRVJRdzk0RzlYU3RvaFAzdDBJWnIr?=
 =?utf-8?B?S2dqSFZGSDI2UXRmSkgzNzJpd1NxVW9xWjJDRmp0Q1ZsWThkUTVpZzdwZkpS?=
 =?utf-8?B?M2xZLzB4YStqcDlWbmRxdXgzNndpV1pDNXRpblVZVVRZTHUzN2gvakY5SzFV?=
 =?utf-8?B?dVBhQ21kRWRpK0kxTzBvVjUzbHlUUU4yM3lpN2JtRVF5UjNscnBIc2FXY2Zi?=
 =?utf-8?B?YnQ4UVF6VFZnNUtSOE1MS0cxRFlScVgvNmpqVDgrRklDY05QbzdCSVhYSDF6?=
 =?utf-8?B?Q1l4dzVtV2IrUFdaemU1QTdtUGhQcFZNMStJRmhpaW4vREdWbmtER3ZQYzJh?=
 =?utf-8?B?bGFDQVpYN3A0bW9HTEdoMlRhaXJMczNaS1B5TmltSXNYYUJRaGRJcG5BYVQx?=
 =?utf-8?B?dmIyOTI4bG16WnBiTjV1VTVnVmRSeEsxK0NxRnpDSXhEVmYrZGVtMVlOaitm?=
 =?utf-8?B?M012YnBXSGFLRHpvL0VHakhPTE51VURSSlZhRWhacFNmMUVhZTEzaVhrdVh0?=
 =?utf-8?B?V3lSQzYzQnRGYitTMGZ0LyszWVZSQjVIN3NFN2xSVk1GamRBMUtsYmNLRkMr?=
 =?utf-8?B?eXAwSEwydlh6b3UrRnUwckZNa0hvNEdQZ0o2bXhBdWMxM1NYcVVSN21RZ3dX?=
 =?utf-8?B?eWJuYTFsdWwzZTByQ3FaenV6TVg2S1MrZU9UQnQreVdabmUyTCt1VUhNZklu?=
 =?utf-8?B?TGp4ZEpCQ015dEJOdXFlbEl0OEprVHlWZU1Tc242UUZJb1pXdVNiWEZLUCtF?=
 =?utf-8?B?alc4cDRmLzBoSG5sV3VpTWhkZEJXbFlkeWpCK0JQVlFQM1orRTdnMWRkeVJR?=
 =?utf-8?B?Q1JISTZXN1VQUktuekZyMmc4MnVPa2NsUDRIQnhDSkhlSkp5ckxOT2cvNXJC?=
 =?utf-8?Q?8hJg+7UH6CXQhLFU=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9d160d-5c9b-45f7-b77e-08df24487d55
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 07:56:27.2669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfRFg5GPNbk4QrvRkEYCOaU2mcZtKfXGgegkqHF6GTUMKehE3+eZRZvnftSaN4Fq/tTy3dYWRFGeSsJhMcS+/FtGNaIl7QJ9rTHI+9oe4aM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB516996
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

On 28.09.26 01:57, Mikhail Kshevetskiy wrote:
> From: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> In some situations, direct mappings may need to use different
> operation templates.
> 
> For instance, when enabling continuous reads, Winbond SPI NANDs no
> longer expect address cycles because they would be ignoring them
> otherwise. Hence, right after the command opcode, they start counting
> dummy cycles, followed by the data cycles as usual.
> 
> This breaks the assumptions of "reads from cache" always being done
> identically once the best variant has been picked up, across the
> lifetime of the system.
> 
> In order to support this feature, we must give direct mapping more than
> a single operation template to use, in order to switch to using
> secondary operations upon request by the upper layer.
> 
> Create the concept of optional secondary operation template, which may
> or may not be fulfilled by the SPI NAND and SPI NOR cores. If the
> underlying SPI controller does not leverage any kind of direct mapping
> acceleration, the feature has no impact and can be freely
> used. Otherwise, the controller driver needs to opt-in for using this
> feature, if supported.
> 
> The condition checked to know whether a secondary operation has been
> provided or not is to look for a non zero opcode to limit the creation
> of extra variables. In practice, the opcode 0x00 exist, but is not
> related to any cache related operation.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> [Linux commit: 6f96f2fa152518d93ffeedbea781db50aef7f7dc]
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/spi/spi-mem.c | 17 +++++++++++++++++
>  include/spi-mem.h     |  5 +++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index 351ca725524..ae393ca48bc 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -639,6 +639,23 @@ spi_mem_dirmap_create(struct spi_slave *slave,
>  	if (info->primary_op_tmpl.data.dir == SPI_MEM_NO_DATA)
>  		return ERR_PTR(-EINVAL);
>  
> +	/* Apply similar constraints to the secondary template */
> +	if (info->secondary_op_tmpl.cmd.opcode) {
> +		if (!info->secondary_op_tmpl.addr.nbytes ||
> +		    info->secondary_op_tmpl.addr.nbytes > 8)
> +			return ERR_PTR(-EINVAL);
> +
> +		if (info->secondary_op_tmpl.data.dir == SPI_MEM_NO_DATA)
> +			return ERR_PTR(-EINVAL);
> +
> +		if (!spi_mem_supports_op(desc->slave, &info->secondary_op_tmpl))

You are accessing desc here where it is still uninitialized.

> +			return ERR_PTR(-EOPNOTSUPP);
> +
> +		if (ops->mem_ops && ops->mem_ops->dirmap_create &&
> +		    !spi_mem_controller_is_capable(ops, secondary_op_tmpl))
> +			return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
>  	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
>  	if (!desc)
>  		return ERR_PTR(-ENOMEM);
> diff --git a/include/spi-mem.h b/include/spi-mem.h
> index 81166492da2..08d854b1e52 100644
> --- a/include/spi-mem.h
> +++ b/include/spi-mem.h
> @@ -201,6 +201,8 @@ struct spi_mem_op {
>   * struct spi_mem_dirmap_info - Direct mapping information
>   * @op_tmpl: operation template that should be used by the direct mapping when
>   *	     the memory device is accessed
> + * @secondary_op_tmpl: secondary template, may be used as an alternative to the
> + *                     primary template (decided by the upper layer)
>   * @offset: absolute offset this direct mapping is pointing to
>   * @length: length in byte of this direct mapping
>   *
> @@ -213,6 +215,7 @@ struct spi_mem_op {
>  struct spi_mem_dirmap_info {
>  	struct spi_mem_op *op_tmpl;
>  	struct spi_mem_op primary_op_tmpl;
> +	struct spi_mem_op secondary_op_tmpl;
>  	u64 offset;
>  	u64 length;
>  };
> @@ -338,11 +341,13 @@ struct spi_controller_mem_ops {
>   * @ecc: Supports operations with error correction
>   * @swap16: Supports swapping bytes on a 16 bit boundary when configured in
>   *          Octal DTR
> + * @secondary_op_tmpl: Supports leveraging a secondary memory operation template
>   */
>  struct spi_controller_mem_caps {
>  	bool dtr;
>  	bool ecc;
>  	bool swap16;
> +	bool secondary_op_tmpl;
>  };
>  
>  #define spi_mem_controller_is_capable(spi_ops, cap)	\


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9E0C9830E
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 23:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5077C60671;
	Sun, 27 Sep 2026 23:57:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J9JZ6Ktd3EI9; Sun, 27 Sep 2026 23:57:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2A88A60619
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790553467;
	b=dEmQJ5L/l0mbdwsT/Ch97jo2x6sfLuUZ4FEws3ds3yf64p/3mOogK9JIxuYnTfcM6pcF
	 TewYeDTwcE5GN1tLI38ApRR2x2RwpTLYpMPtMTSKR0UqP/APLgRsdkRfV00i04WYWK2W+
	 tqFQS4yfJIUSJpY73He9pPrfM+shjI7ZFmEm3vZdB1LmUBWMgkhuJJHMshrqDk7LMgxp+
	 Mm+bWs8HJH2usvM/BphAbtv9iOqQws954TweASEqpt4FRErhCoxzv9T5pT4jxZ/pa5IRB
	 UBaWqPWTrF+csFzmZI5cXxF9BvcUAaPNsm6EI4cws1Bdy4CAgUpvv+pfSGOrpgqH9qg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790553467;
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
	bh=f1WZtVUmZUxGyDLXVOMXHHg6vXeeULgqkKotYl8bpxs=;
	b=Qz9Y8rPt0fsOseKRcbf7HAH/INipr6G0fiwQ3+OHz2AMSzZ/6izUj1Ufh6oHMuYWTQwz
	 MkrVpIn1j+H/0o5heB3Ris7Wl6n8P7Tn4gMjhX8txRNr2AL4q/12tfA4rEoIH2YsQvbGU
	 Q5s2ot2YfB/66ff6+GnJD30bQL3/1DTil+CyHLTcbfp+Tk5RrTXNxb5Jlj/3rdY/Dbze/
	 8ouzXu7mtyULFAtgc0eAwwhpbyvCX8TuU2w85dWB97qLxnIRhZ1INnmb5XhGycipdwivP
	 wOmI/CNtIWuGzmKXz1sd7vLKxNpJJsq9Bt46+c4wHUw4vyahEmxm/kkSMuD+5YYrT0Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790553467;
	bh=f1WZtVUmZUxGyDLXVOMXHHg6vXeeULgqkKotYl8bpxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SkAEwrYy7z666+fjM3cmQDFJTHPZ4o2pkmX46lTi2G/1r9y1uZQjfJ/vOsuYVZXRb
	 bCm9ZgKgMZC/IzAs7DgYMqYCZ6OlG0kBD7F9oVF9qyAcUSyZ9wGiKQPjOofS8GSI/d
	 kWEMf2kYEwzNSFO3ZT3f/v4j8fZge9wwvxb/hwq9yr3jFND1HfPMdQD0EPYnjDKKqq
	 zd5jj4RdtRNREAxkgU6AMW9ZRenxi1U8ZSsXJe0DCxoc2ZfeDi6uIEcRTPM7iiMwNR
	 Fgi8gkx8aiH8Nyf0kbEIFm6E/9PDl3SKSGhfMH1eqG+y/104DCrx9cxrGXYPS5WBb2
	 SvL/z0K6cEoPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A88A60619;
	Sun, 27 Sep 2026 23:57:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BF576361
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 23:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A51D280C87
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 23:57:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Mogibfr3JvS for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 23:57:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 60EB780CA8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790553462;
 b=Xzv6Y2F63zz7rkLq7lHrGHbBht8onJoKhrmMMbeBeUYqrDCZ/QecC29MUZD85EjbyI3w
 D07I0UObV0qBj+439dknbL2h+J5xqMySayzRbDnHP7eposXEGarRvInV9R9Mr3IBBCeGv
 gIxYRvIrHPWymP9D7aNWOcyiaYUSF/95AIQAcRKpe9UNCqB9K/aKxupPJKd/8YKHirXgS
 89Z8lfTTYBPHTS4LPv2v9Kh4i5j5lIv8N9n+XpLXIxIYqp9pxOm2PoU9bqk4xG37pPFLf
 1Gnq7cFa1tMyXLDwJ8AGx3bgh6ubxb1Oro0hs79OJaEr3GBhD5VoLnM2HN8WPe2wzcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790553462;
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
 bh=f1WZtVUmZUxGyDLXVOMXHHg6vXeeULgqkKotYl8bpxs=;
 b=CMp9XuzvdL143GWGxfuWg0g4FLms2e9ByNgDJUfVxCosxa0+VGjg9i5Zr17lVi4HyAE3
 lGtoEAuXWoAEz1atdXjwC06dUgROU+skuNFRGuV8etxkjBg8INSBOMH4WSj6eELBDlSmk
 nepxr/b3DGMRyD0Yq2CndP/sndWpBNUsjZbveX9vyVBqCSikcDWT7gDMJ6kgaK6q6oPLY
 2XdZxS2juReMSsdYQxcGNkiQld7Mu97b3OXs7JHr5Bf20FrHakxLBEg2PSHtsQgpM8zSE
 /SoeKDuGzCEcFUaTOp0L4CMlgroJYgBc4N2CIzKP0Xh6zzcqUXHlVjlcz0g+KZ1x4VQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=iopsys.eu; 
 dkim=pass header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=ThfaDAV2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=ThfaDAV2
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 60EB780CA8
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 23:57:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRJsfS+UcDMCrtflmRQh6RwpMZe8EWSJ5L96176Qkdq2Qeo2sIenid/sGOeqwR5qQzmM8uoQa7xtSXnzD6Cv3E1Ptp+GaKjR8kJd9LwykHxE/yfzJzsShxGJOktyXWr2ccaq2dtNB/wwc09a346DmuNmdsLPLW9icRb+Msk8MonhQl5RkX+N4+pfgcSsWghwZTlz4JIIm9DGaLwDSbtD9rycJ61HmXnynwed2VsOwtKLoTXEDaNTcZcu6/1Dgn8Yb/2an38U3SN5Zrwo8A0guIlEJfTBhpkxLlOk37DZIUur4vSaEuSqwdKi2Y3WoD/Q8NZaYV6+IFtSi4z7ges9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1WZtVUmZUxGyDLXVOMXHHg6vXeeULgqkKotYl8bpxs=;
 b=qSEeCyXK6m7nsR9n9tLNaWh6rRp0a27oh3XkEsP5+N5SnAdz6+0QYlgek+EzNgtCR1lxih7LDMNLyeIB5rUdiX6kzv/EdMOM6SDSVvqbtQKHypmNUFFceCvDnikPM84BJ3M6d5b3IKfYNyeQ8D4YIGfBJeQTIQhsVBcQREO6AuXlQf+i5TSNmOeKPJgsT5UASW1IjOt8NRNpD2yxPrxVib+FYSW8ft7a47ZFnAGxrPSr17UcZAo/c+H5I0FNbMEdHrB6qIuQ3zskhFq4iq0esIGXihZ5Cf+T/GRThlQhYGoldovLxO9mmDX5Md47yN1+DS0Abu+2wyGEt3B/ph0d8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1WZtVUmZUxGyDLXVOMXHHg6vXeeULgqkKotYl8bpxs=;
 b=ThfaDAV2OAqhynnIp4IwZWNKTlBjyFV4aSN+AJ15mYS6nnHZjpKROHBT90+BSzCNFrRb+N73pJ3rkgHAjuGcFkMLbs6c4PGYUclR1yqnt5GQZ45I2AYGpSdwcEM/7pLuMvlvc9KTQX2Z4V2rfBBZsukhyz2gII2x87mai3o8zGR6K58FtXGZEBanxiLxgV1l+F5TNy3rGxildrnch/2dMON0Ly0IsENSu9T8e1qSk9D72zlXeI+ao1k+hjsn99bWA+JkWSq213ssvL9yJ/6lGTIlycjhhwUe1uVUartHx8jgI3VLx3D0NIHHyX5dqetYbw/s2Z2dRKuzBk0aY7cPxw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DU0PR08MB8347.eurprd08.prod.outlook.com (2603:10a6:10:409::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sun, 27 Sep
 2026 23:57:38 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0472.005; Sun, 27 Sep 2026
 23:57:38 +0000
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
Subject: [PATCH 1/5] spi: spi-mem: add spi-mem caps support
Date: Mon, 28 Sep 2026 02:57:12 +0300
Message-ID: <20260927235716.1872707-2-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 36e2d85f-0646-41a0-fff3-08df1cf31c04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|366016|1800799024|23010399003|10067099003|11063799006|5023799004|6133799003|18002099003|22082099003|56012099006|38350700014|921020;
X-Microsoft-Antispam-Message-Info: pM6sNnPR6UJVOevQZCJ+bxbos5Luw/78DalEqmAyJnIREeehLw6DKR1520ixKfgy1ILYOZy+beN0PYkX8OyHgUDZPyST/Gq8cAiBvpCxYk+d/mVoyLoPbuUTWFVPGs+HrHQSSqn5LAk2o1oCRP1BfrFy+5eXd7mT7EtfJHWs110a+XCXF8SHNWkD4ymuh50dssUZ1sDTXbXwQjk6DtoX2qYGDG+o9NzObkQiOV2dv4LipMdu/W29gprRX/s6ZrXbkI+Q8yuDRwQowz6+Ph7M34XmIeqkGW7cBFOCXEzM5YC5B13MSBghkOFdWxcSZHpvWhpQU3bWKsFdfT2uKVaBa4rXhzTySbam+U31AqPvfleQUTJpd8Yew3utYzRQzJONOIArPokJeXVmBz/75gMjvI+QXIPK47ocTr+npMq24xS24thG/BIStf4S4DamkYJ9Xhe7LIgGoUjYJRJWwHxPWJHBi+Qo96ZMkARba4blPgi+mbuf+cOJKPiiEFOBZNi2Yj8Z4qXBd2YXnpFm5rZmJPEDWLZhpZwQz17XPlGzDlANDBIjdA9ORivKOO1CLKUMyzE4N8XzLDb6vG88zZBi/aM1LhBZcab9p2mWSQ7QVeiDXQ4z9ecO5ub3iBR3CQNKclPBQm7aF6AMNGU8kbVkG+vzZPv1hABr0n63F9EiV+EHtJdqh7S+C4esr3bQiyThBupYzixxCZLM8/babGjFzhcTSnV0IXRudCpkoNZGcnJkJIRm0xkaqWrcmw1PTW8S
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(5023799004)(6133799003)(18002099003)(22082099003)(56012099006)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?06nmmY53LYMw7iPdDP6ZR9qOyOew7P38AZjKOh5uzYbamnCNWPsEReiKN3BF?=
 =?us-ascii?Q?6z3Ps4nIXzy1dPIlNym+nWAQ1fOLUUIe9Ssb4FIa97+pYFZK+amDxBjwaT/8?=
 =?us-ascii?Q?Rhh1ilR515HeiF17JZTFrS1NaxDm5b7rml3XTDffhhY+sqnDA3yPq5BHhdV+?=
 =?us-ascii?Q?p/Nq6z1wmd6TReM8H9zgoZ1lWhW1mmnWhIOOzciOIps1Hffeldyq+2sLXYis?=
 =?us-ascii?Q?h7hw5VoEZ4nmSfhR236ivhlnlBmhrYzdS1++RX326lqEXVEKTajSCXIQ//JF?=
 =?us-ascii?Q?Ub6Lj5Twt6z8OgtZLJg7G4C98zMhEf4qjyiXexdmvkFs1ZnIDYBi6OKNt800?=
 =?us-ascii?Q?Nh+Q2zB3jDoXDKlNGOUX0zS53jvGIdV68Gy6Lwu5NXk19aoio2hB/gvknOkD?=
 =?us-ascii?Q?F4tBAv67qyqNsS0IWD5wuJihT66GJf1Dob8GT5S8NiWODS2lxdbDNnCI5Yq7?=
 =?us-ascii?Q?KiJnKPOCSLXAmEW7DCQBsGFVq7HmTNY1ZZd9yTOVuY09ivH+KgAaNM3cRNJ3?=
 =?us-ascii?Q?jj3ZKyBthDz/sj2lUlpQQPyLJcNHuhjpxBukRyxNWK+vla9vgPopo9K/483G?=
 =?us-ascii?Q?E0mf0LbMrVifeflAqo2BqWfcEHuqs6UKu4cLbQDe2Adg/aT2CUGj9TL5axMB?=
 =?us-ascii?Q?DhtjPqfz3+0I0RoFpt+knxs0Z2/3c+sCqhi8Io9E13GfRcGjC8bgQ37cy7gc?=
 =?us-ascii?Q?GpghOJjXc0WD7mz6g3WHBIEiXbmPEmPUoluJQj5T7zs9pkU28+qru9YVS9NR?=
 =?us-ascii?Q?9NRmA2iJZyvTvwyxGw6rUBcjbY6vu1I/Ry+LadL7R/YVDzBwctUhg8Q0DOwf?=
 =?us-ascii?Q?6nz1YLad4hyUc0d/CBT9SIpu2ZqTE4XntasHJ0dqrt7dmbKWRTg079SewoYD?=
 =?us-ascii?Q?aUSQsRXCpqWZ8f7UXLuZdrzUickQqcYNi+j6ZYPRywdeBim7AywxPlnnAi8w?=
 =?us-ascii?Q?GTXmOF8SrolAsNC3xEUC/HrjRHwVv1D+0ieICJ0wOXQpISkw2AogARzX1aTY?=
 =?us-ascii?Q?OkI/YLAbasAsA9qX4NX6hrPee+GXRyKNB76fKUar7X4TybLo2sZRb3nr0sT7?=
 =?us-ascii?Q?dlQngZk8o6FktM8QdVmpoKNGWCXlS7J4QMYG3cnNESRjoGEFkSuRRwZr6+/q?=
 =?us-ascii?Q?i3PlPqFxYnc5S71DkKsJLn21Bbi+H92gTyQd3cp9pV9UMU5V2UamOn+FrIlo?=
 =?us-ascii?Q?2pt3dwuC5bbO6e5b5Z46UJqyWLkwgnIDhXqPofCkVmDuKRHg/5hRgNRVWXDf?=
 =?us-ascii?Q?37TutxNkjO1QcowfUEfgPmAL9eKLxzHUXowPt4cNCWqsHyed5LwXQoHfzotG?=
 =?us-ascii?Q?8scmWKYyKXgBGEsWSzgSYLoIWndPRuEu4Jqe7kuXnN/kvbdFaKCFs5IZEfN5?=
 =?us-ascii?Q?DAe5rm4sXPFhOmHksv3RuJMNuhkoHtzPk6+1sd0JRwBMOy7C4PxaFeAoumNp?=
 =?us-ascii?Q?jhgtezvunm8/fUkLj9NlG9iix8wSLpiFN1PNQitQ71HMYUxvmRkYwEmjyT+D?=
 =?us-ascii?Q?gvDnUi8hljOIoBdQpld1xGq7W69hjiZ58tKnRhiTYUka+A6tPonVZtmj3wCs?=
 =?us-ascii?Q?KnQg+Rr62x712pgFkPXZuwkfdwvda4Dxi4PrLRl59g9znplASCBMOMrb4zHK?=
 =?us-ascii?Q?UHYWrSyZGOloLbZXK2UG4o/J5zAwvCyEDjJaTOrQ5/HnohYmK1dQ4mJBkh+r?=
 =?us-ascii?Q?vlXyo9S9GKcu9PxiBLwY1LZw8erfquVlIlVcr1Bdxp+nELCCVR0tu552SmU5?=
 =?us-ascii?Q?eQXn+Msa2JNzW6/cw8G2VDTYHub8Xgo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e2d85f-0646-41a0-fff3-08df1cf31c04
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 23:57:38.5734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FWbxp6P5bsnrSOFKRsB+MWt/aknKl2RgHrJuQktapOpG692XBjwpBXHHkCYOg/nbFHFwpMq0auzRSgtw/ahBd1vpJI/z5ODdaUSdfNV3IE=
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

This makes code more generic. Also it allows check for DTR support
and emit DTR operations only if it supported by the spi controller.

This is necessary for spinand DTR support.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/atmel-quadspi.c |  5 +++
 drivers/spi/cadence_qspi.c  | 10 +++---
 drivers/spi/nxp_xspi.c      | 12 +++++---
 drivers/spi/spi-mem.c       | 61 ++++++++++++++++++++-----------------
 include/spi-mem.h           | 19 ++++++++++--
 include/spi.h               |  1 +
 6 files changed, 68 insertions(+), 40 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index b2b96e1c4b9..37d97c094f8 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1286,11 +1286,16 @@ static const struct spi_controller_mem_ops atmel_qspi_mem_ops = {
 	.exec_op = atmel_qspi_exec_op,
 };
 
+static const struct spi_controller_mem_ops atmel_qspi_mem_caps = {
+	.dtr = true,
+};
+
 static const struct dm_spi_ops atmel_qspi_ops = {
 	.claim_bus = atmel_qspi_claim_bus,
 	.release_bus = atmel_qspi_release_bus,
 	.xfer = atmel_qspi_xfer,
 	.mem_ops = &atmel_qspi_mem_ops,
+	.mem_caps = &atmel_qspi_mem_caps,
 	.set_speed = atmel_qspi_set_speed,
 	.set_mode = atmel_qspi_set_mode,
 };
diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 984d4a39ded..8eec45270b0 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -398,10 +398,7 @@ static bool cadence_spi_mem_supports_op(struct spi_slave *slave,
 	if (!(all_true || all_false))
 		return false;
 
-	if (all_true)
-		return spi_mem_dtr_supports_op(slave, op);
-	else
-		return spi_mem_default_supports_op(slave, op);
+	return spi_mem_default_supports_op(slave, op);
 }
 
 static int cadence_spi_of_to_plat(struct udevice *bus)
@@ -467,10 +464,15 @@ static const struct spi_controller_mem_ops cadence_spi_mem_ops = {
 	.supports_op = cadence_spi_mem_supports_op,
 };
 
+static const struct spi_controller_mem_caps cadence_spi_mem_caps = {
+	.dtr = true,
+};
+
 static const struct dm_spi_ops cadence_spi_ops = {
 	.set_speed	= cadence_spi_set_speed,
 	.set_mode	= cadence_spi_set_mode,
 	.mem_ops	= &cadence_spi_mem_ops,
+	.mem_caps	= &cadence_spi_mem_caps,
 	/*
 	 * cs_info is not needed, since we require all chip selects to be
 	 * in the device tree explicitly
diff --git a/drivers/spi/nxp_xspi.c b/drivers/spi/nxp_xspi.c
index 200138f5adf..c3a5c56b138 100644
--- a/drivers/spi/nxp_xspi.c
+++ b/drivers/spi/nxp_xspi.c
@@ -326,10 +326,7 @@ static bool nxp_xspi_supports_op(struct spi_slave *slave,
 	    op->data.nbytes > x->devtype_data->txfifo)
 		return false;
 
-	if (op->cmd.dtr)
-		return spi_mem_dtr_supports_op(slave, op);
-	else
-		return spi_mem_default_supports_op(slave, op);
+	return spi_mem_default_supports_op(slave, op);
 }
 
 static int xspi_update_lut(struct nxp_xspi *x, u32 seq_index, const u32 *lut_base, u32 num_of_seq)
@@ -700,11 +697,16 @@ static const struct spi_controller_mem_ops nxp_xspi_mem_ops = {
 	.exec_op = nxp_xspi_exec_op,
 };
 
+static const struct spi_controller_mem_caps nxp_xspi_mem_caps = {
+	.dtr = true,
+};
+
 static const struct dm_spi_ops nxp_xspi_ops = {
 	.claim_bus	= nxp_xspi_claim_bus,
 	.set_speed	= nxp_xspi_set_speed,
 	.set_mode	= nxp_xspi_set_mode,
-	.mem_ops        = &nxp_xspi_mem_ops,
+	.mem_ops	= &nxp_xspi_mem_ops,
+	.mem_caps	= &nxp_xspi_mem_caps,
 };
 
 static int nxp_xspi_of_to_plat(struct udevice *bus)
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 3fd2353af94..1c23f3d8843 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -171,38 +171,43 @@ static bool spi_mem_check_buswidth(struct spi_slave *slave,
 	return true;
 }
 
-bool spi_mem_dtr_supports_op(struct spi_slave *slave,
-			     const struct spi_mem_op *op)
-{
-	if (op->cmd.buswidth == 8 && op->cmd.nbytes % 2)
-		return false;
-
-	if (op->addr.nbytes && op->addr.buswidth == 8 && op->addr.nbytes % 2)
-		return false;
-
-	if (op->dummy.nbytes && op->dummy.buswidth == 8 && op->dummy.nbytes % 2)
-		return false;
-
-	/*
-	 * Transactions of odd length do not make sense for 8D-8D-8D mode
-	 * because a byte is transferred in just half a cycle.
-	 */
-	if (op->data.dir != SPI_MEM_NO_DATA && op->data.dir != SPI_MEM_DATA_IN &&
-	    op->data.buswidth == 8 && op->data.nbytes % 2)
-		return false;
-
-	return spi_mem_check_buswidth(slave, op);
-}
-EXPORT_SYMBOL_GPL(spi_mem_dtr_supports_op);
-
 bool spi_mem_default_supports_op(struct spi_slave *slave,
 				 const struct spi_mem_op *op)
 {
-	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
-		return false;
+	struct udevice *bus = slave->dev->parent;
+	struct dm_spi_ops *ops = spi_get_ops(bus);
+	bool op_is_dtr =
+		op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr;
+
+	if (op_is_dtr) {
+		if (!spi_mem_controller_is_capable(ops, dtr))
+			return false;
+
+		if (op->data.swap16 && !spi_mem_controller_is_capable(ops, swap16))
+			return false;
+
+		/* Extra 8D-8D-8D limitations */
+		if (op->cmd.dtr && op->cmd.buswidth == 8) {
+			if (op->cmd.nbytes != 2)
+				return false;
+
+			if ((op->addr.nbytes % 2) ||
+			    (op->dummy.nbytes % 2) ||
+			    (op->data.nbytes % 2)) {
+				dev_err(bus,
+					"Even byte numbers not allowed in octal DTR operations\n");
+				return false;
+			}
+		}
+	} else {
+		if (op->cmd.nbytes != 1)
+			return false;
+	}
 
-	if (op->cmd.nbytes != 1)
-		return false;
+	if (op->data.ecc) {
+		if (!spi_mem_controller_is_capable(ops, ecc))
+			return false;
+	}
 
 	return spi_mem_check_buswidth(slave, op);
 }
diff --git a/include/spi-mem.h b/include/spi-mem.h
index 36281a62f77..8c20feebfca 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -331,6 +331,22 @@ struct spi_controller_mem_ops {
 				u64 offs, size_t len, const void *buf);
 };
 
+/**
+ * struct spi_controller_mem_caps - SPI memory controller capabilities
+ * @dtr: Supports DTR operations
+ * @ecc: Supports operations with error correction
+ * @swap16: Supports swapping bytes on a 16 bit boundary when configured in
+ *          Octal DTR
+ */
+struct spi_controller_mem_caps {
+	bool dtr;
+	bool ecc;
+	bool swap16;
+};
+
+#define spi_mem_controller_is_capable(spi_ops, cap)	\
+	((spi_ops)->mem_caps && (spi_ops)->mem_caps->cap)
+
 #ifndef __UBOOT__
 /**
  * struct spi_mem_driver - SPI memory driver
@@ -395,9 +411,6 @@ int spi_mem_adjust_op_size(struct spi_slave *slave, struct spi_mem_op *op);
 u64 spi_mem_calc_op_duration(struct spi_mem_op *op);
 
 bool spi_mem_supports_op(struct spi_slave *slave, const struct spi_mem_op *op);
-bool spi_mem_dtr_supports_op(struct spi_slave *slave,
-			     const struct spi_mem_op *op);
-
 bool spi_mem_default_supports_op(struct spi_slave *slave,
 				 const struct spi_mem_op *op);
 
diff --git a/include/spi.h b/include/spi.h
index 97096a77526..97e95529850 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -492,6 +492,7 @@ struct dm_spi_ops {
 	 * has native support for memory like operations.
 	 */
 	const struct spi_controller_mem_ops *mem_ops;
+	const struct spi_controller_mem_caps *mem_caps;
 
 	/**
 	 * Set transfer speed.
-- 
2.53.0


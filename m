Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0D0CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 04:28:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03185406E6;
	Wed, 14 Oct 2026 04:28:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nV6aSZN_nWsn; Wed, 14 Oct 2026 04:28:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 36D16406DF
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791952086;
	b=R9hw3nfpeZu+yKo+sq418YuuChCUFUSfoAND4/VCAIV7Q5KhKXtkSys/MuhzFW63K4iO
	 y28torOBtAu/7dLApmxIbe46XDtNkyjadKtRJBdoC91BN5TONhwB9N+uuY1+gIeQf9TJc
	 0Yi3oFRxSHqZjZqmFN3zZiCwyh5kRB9p+5j9VXyuX/61LBmX/EAoHO+X+4XuBYFjpKaxm
	 6JAgfWLrxhUemQkQxzGireTd09kYvnjsMN7cJseaIZiSZ3EyosgyYn/s9e5Dk5iSODco3
	 T3g0EK3KTKKEN1+G71IA8sRGjKaqCSg8AmHq1fSThw9gQoDyOBYOrHhg+hFoE27WrDA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791952086;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kXsYlDBMeM5Urx6Ax8jlIBH8phcCQToKehUKq8Cm84c=;
	b=Hah/cN67HZM8uOp6WPduev1C2x1L2RbCbo/KYh0Nd0SukCcX1N1Y0GIkaLIOz/cv62S2
	 hXkpLV1WESDyKni0pTINjYxGQH+bReIc58Ufi3E+iINW+M3UzqdIMeK/Yl3jZjFXFmcC6
	 47Z3H9X8EcHM5MbXrYpPCji3FX0OebX9GKY/B/ZRfDkB2eCnwxDqC4BuzSca/ybOSGJPI
	 tiJf3IO27qZVBHMK1gPG7GdigyAdQrGgupeajUcsLq2NsMVldCCeaFYNxciyG81YgbX0w
	 I/b/79HCxZmQRtdxnsx7A3+GF7jw86Glol+MNaK/wS1ov31zzMuZlPvTmQZWswZ84PQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=processmission.com;
	dkim=pass header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=njDbvGWN;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791952086;
	bh=kXsYlDBMeM5Urx6Ax8jlIBH8phcCQToKehUKq8Cm84c=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SZLgfZel3QFYLbAX0BGmvB9A3Y3MyVqr1LqrOfcuk9HE4huCXOf3K60ZOgahh/M5+
	 yAPNVahd9H8LZ/hF+fRuIHb1iNInWyGDSuLbQqjyX0YC/NKhyvics7Lo1oS/XB7JT7
	 QD75P8BN8GD3hG4KXbp6rSUVH+frbJf03K1LhzV+wB77YSpdAWsTeAJ7d22mrs7CiH
	 6lIPNDTHWc0CNEh2oddVaz3ZM2XPPJ0b3V8/yMzuJz1EkPWaSc+xO1Qx2KoiiS//j7
	 s19iSqbdBBQX3gEtoj5uTVCnXhopNwsftpm9hFdb9je9PzOvGN96yvkaBbhA4cJmjN
	 WKbRe2oXe5R0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36D16406DF;
	Wed, 14 Oct 2026 04:28:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 684572E0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 23:27:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6559D406E1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 23:27:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NMBhSZutyRQD for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 23:27:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7FD4C406E0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c406::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791934044;
 b=FAIRrEQmF0vd328tVjvBY4T4mPVeRql/RGboB1ghhIxkpmm6T2P0PT4xljm2uIu4S2JL
 0dcckrezghyg970oCeoIpFNsAueC62FxwtRSbqs13VAnGW6jnG9dG3BoJhajVitXNdsNj
 jhuuunLrp3ZAAz+B2xWRDUKHEsJv/BkVILfXntU+cSKM33FjH9edKu68hxYTIbkt7iRON
 v6irbnjd4oIzr4qJqAHyLCGpqIh9pqv/r97/7cX44t9j1i9uM79dxLz454bIprp7z/Vxa
 S5GdPE+baM/l9DejnV5I+p5a4UMiuh8l5kdLoarwAgFt6gpAQfCqKiFGT4UjEceywzw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791934044;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:Content-Type:Content-Transfer-Encoding:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=kXsYlDBMeM5Urx6Ax8jlIBH8phcCQToKehUKq8Cm84c=;
 b=MW9rtmXNc5h5uoE4boJVysBXS7rKHmL8kW5/UZTqgO0ERicC1y21JlKnM7E/ePT3FaZT
 PFzIEErad3Np26OqPix1tOPm5FhYw5r500LmPUjLHwJXYdaDAMfXA0VoKAzECioeokNLX
 KiH3+e8oaTpibmk3ml8uqdWaokfxCuJR70wNX4bfopzZc3rsfhZ6FYZnI53WLSElRz5ug
 bKCkCak2kIVZfSUwiD3FpuGd1x/j3legkbbnijhRc4ODJGsIMObL1l+e52Slb2foWXvqG
 hgb5jc48DjrWyn2AL/Mmb7ZNXrzwt7gr2dHCGtREQ5HM3fCcFZzYBRH90CyWlI2xMnQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=processmission.com;
 dkim=pass header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=njDbvGWN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c406::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c406::3;
 helo=os8pr02cu002.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=njDbvGWN
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c406::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7FD4C406E0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 23:27:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ir9j0vMsQvl3qvGJQDFyxnqWm69qyzSNYawzW3GeJe0IiUQATrYA3DaW7Uarm17s7RfUqsofJ4LBpyRc+3Gg9ovSA+6Jlxplw/XEzLoUvzmHbGKhBwvYK6Cf+jniDLQQVdALkdMCfEJF6FS+adQ4NxZyR8AxnHpNzQZLfgRQNdhQKiha1n2Ka4oAHw9Cm6JC6EWyF2h1A7b5USa379+6W4T5bUDbC1tdnSERqJ8Q5OASQy6uVifCETCL02ULM3qV7+Tgt2A8fYOhrjMn8VS37NNlZRG+eMBXToGtEUepaS4Q2wv3NBiwg+HuPRYVTPVqwYHRKW1nR596BZ7EBJVjIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXsYlDBMeM5Urx6Ax8jlIBH8phcCQToKehUKq8Cm84c=;
 b=VHeQHehTBpymARPTc/qEqRabxhsX84UHD3tIAFtyWdBt5Yn3usw/TCtN2GfV8xLMDEL+oggfI0GbTiQb6Sc6+NNVBxVlYLhoLiY0gxGnGzGE1lu+HUoKEWGoeHARm9y/R15FNV121knP0XlpOOVEDHtlvbkqQtbSuA2KzE1uagk70tF/NC9BItKSX28rerPuw6RwWEOz+lZcNeZU2f4iqbja4gtRMDeoODeXH90vGmJzviKh0CHjpeTRcM6iW5rfsQUyAhNDKKD7QG98a1TtT6DWPj/z4xgfLnolIpDxO78SOMLkmaA2ODuWGQnPlfgv0kTkgX94mvx9wx+MKDufvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXsYlDBMeM5Urx6Ax8jlIBH8phcCQToKehUKq8Cm84c=;
 b=njDbvGWN2x/fy5iHFor+z9YMYLaBY/m+BHLiEbBGeDaMIC2OhYsCFhqwvf6EA4x70kP+MtQjxyhah2K43pwp2ilwbLHd0Fmz+tKthA+h2LZUGwGAroKq6p3AMePeE28ajhA6aSQv63tMzmllxif3/9tCxUhUeVEcXvCZHbmviV5yAlReKweoG5fKDT3n3tml/S9JSP71P3uW2kZ7YPdbDNppLvfd0uJOzJ0/yxN1gpIPXJlY18jL/8JweEV3W8kyrcZf+ze+uQZMk0E4gQHm9Yudf1/Y1yrgi8t80gSMohhcF3PD0/4VTPPW8DAe2W6HiLDIzmL88GMqLxxYBOqQEw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB7178.apcprd02.prod.outlook.com (2603:1096:405:2c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Tue, 13 Oct
 2026 23:27:18 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 23:27:17 +0000
From: Bin Meng <bin.meng@processmission.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] arm: imx6: Only read SCU for i.MX6DL/i.MX6Q/i.MX6QP
 variant detection
Date: Wed, 14 Oct 2026 07:26:59 +0800
Message-ID: <20261013232700.289717-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0263.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::11) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYZPR02MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 972f5314-96db-43df-352f-08df29818513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|56012099006|18002099003|6133799003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: x0kOSH+K1eip0kifa76tzkt5hvVLpjWbd2mY6lFXP+Rro3dEQ6Y6fJrLGxQ7yv+WCrg1QMNVNKHW2dRGRt3fTGWrHLlkOVxA6IPGUYLzCEpsDWZTn26cuhUKEapxHODMFOlGsKZKlGMqCCKZz70WgJcNuZwrg+Hz+I+asUXr5TvMhFEluz3Kyo2eAICXW2bu4zYLppx4rbIBhrre8cEqak53clYaqrt1sb9hcfGkZCZLf3lcxphnbmsPDk+l3NLjUnxdHZWvTEH/O4WBjIXrV7Clv+CZlBIYeuQ8YL8zMmXwxrccrQzAgERdaQ/6pOzXVC4smlqeHqApfvaZPrTPvsSCblXQTEFYjTVTSqemVPhuqdIQhCubb1kxMKZ62IbZ2pb3Qkr0tzgSMM/cfBGkVuWPuaEV59AdP66I5eXNCDDS66gchLsAouGugYVOfZn1/laY1JzQ++V1PMVaMpwD6GPobParJ5dIbnGOOM1CFLO5mq3sv9R0BDEL0iI1XZq+Q3WaWxC3gT1fzGY6gyCHsyChqkZeOs+vl+YFIIkoryPw+oziHwIlqeN3EHEI6QdQjoZC++j06EXxMrl5cUHgtJOLo8KipOS/O7zxaf1YRrPrdsYtd8wWtZhELRwktheUeXf0QKOMn5Wa+4mS1AlD44DvuA3x9Du/zCjZo1bjJkQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(18002099003)(6133799003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T09lekppZzErckkwQWswZTF2S0xlc29zb1Rra3Q2d0FmOWZvRXNHWTRlQklP?=
 =?utf-8?B?SWtMbkkxcGJCbjd1MGFacnJrc1dZaG9sRE9heC9LU1pqMUtqam1rTTZIZDJR?=
 =?utf-8?B?N08vZU1abUZ2N05yR2pKcWcxWlpMNkZzUGZ4MXRRTEpiU3dBUXYvMVhvTzJy?=
 =?utf-8?B?SnJWUUdLNnlLQWl6VHZQNUFaSVc2dThJZkVaS2c0TFJRSW5jZDFhdloxL3dr?=
 =?utf-8?B?ZzBxZVpNTytWQ0ppenJFMEtxV3RPM2VBc0NrWDN1MVhiR0k4V1RNRUNrOWlz?=
 =?utf-8?B?VXIzZ0N2dVJQbkJ5eCtzVk5FUE1QY1NtLyswbi9lNkJoM0d3Q2VqVGRGelF4?=
 =?utf-8?B?NGQ2NnBwS2cyMERWUS91M0VLMFNXUUducFFEVTkvSk9sbGRBYm5yb1d1SlVn?=
 =?utf-8?B?QThNUTNMMjdQNnhxMXZHTWtrSml2MjhBa2swWmlwYXhRWklxWXhLTi9DRUkw?=
 =?utf-8?B?bmlYVTNKWDdpV2RWWnRPN2xRNi9OQkZzbTlrcys3UHNEZTNQbjFTY2hOL0Jx?=
 =?utf-8?B?bjFRM24vbGpySHZVZU5ZTmlxY1BMM0o0WTFxSzRTU2tYWGVzS25KRWgzL1Q3?=
 =?utf-8?B?YzVQTXVMR3NIQ1ZYZWRUSyt3c3VwSkdKOWluNU96OFRpMENMcjZzb2hTZmQ3?=
 =?utf-8?B?Z2pHbld6NkdWM24zaFhtV3ZpNTE4VDN5TmtPT2hXbGs5TTBNWU5NVmt0bTVN?=
 =?utf-8?B?dmxUOS9OWDdvZm9iRHowSkZETTVaaHJQRUQwRVF5Y1JMQXZkVC9ZZ2lLWkZ1?=
 =?utf-8?B?R0pyMUlWbjRPNDQ1K2R1cUx3TzNZVDZRdFJySUU4K3I3S1JFQkY4WWNGVVhJ?=
 =?utf-8?B?Vk0xemNZaUpXOTBYakpHRVdZdGo4dVo3b0VBdjJRSnlJV1c1bUc0cFlEUDFp?=
 =?utf-8?B?WUZ6RW9LejlYMmJ3TlE1Um9SUURDUStQVXAycklROG5WR3FGY2Nsb3BoTUo5?=
 =?utf-8?B?b05zU0FCYS9POWZxRVNqd25pc3A2TVdiNmVKRExCN2tkNjdMNmxsTEM5R0Z5?=
 =?utf-8?B?TlpQbnVjWEZBWUt0V1dmYytPSUgydksxTFZna1Q3c3ViSzlZdmpibU9IWXBo?=
 =?utf-8?B?YXk2YWo2R1ZKMUFiT0ZuV2tGNzZvT21lK3EwL1RlUnNHL1JldnFzS2JPL2Fi?=
 =?utf-8?B?NkFCbHdsTDdNd2h4R1lpbWdDdXJhcXVTRUpPTnV0elFkZWlxdm56RytsQ2w0?=
 =?utf-8?B?SFlMSTdqYVQ4Q2dsM3FxSVJlUDhvWWJOTkk5Y2hyWktlbnJ5YW44NVh0eFlp?=
 =?utf-8?B?dFpxaWVERm1rU3VXS3pnR1ZGOUNDa1laRjBITTRCWTNDS1pCMU92ZTFaWkdn?=
 =?utf-8?B?SUE2My9IL2FqNEJ5S1lFZmY2TmFNZVlQTGtEek13ejRHMkI3bWxIN2Z4Z3FY?=
 =?utf-8?B?MEdUZmZCQ0xzVkVLUW04NFFMVkZWajlOY0xxeGhzczc0NEFpenFmYzJ2MExI?=
 =?utf-8?B?bW1uZjRxTm9GMjJqS2czYWVIUjRVK2hRQjQyelJMTTBoRmJ5dVN0ZmRXWmQz?=
 =?utf-8?B?Y3dqVG55WFJCaG11b0EyZy9MUGlpcnFCWkhGbWNseGhuSjNLQlhDZUlTR0w4?=
 =?utf-8?B?dW9HWXM0dE96RS9vMDFBSkg1VTVYM25tV251bC9jeE81WU5sS3BGb1hyVVlQ?=
 =?utf-8?B?TlhhSEFFNFY4dXhnWTVBZkhWMVZHVDdnSkFOSWdHeDVHRmp6R2U0bjJEZWZu?=
 =?utf-8?B?cGpvM2ZBZ05qcUgrSDJ4Z1hyM0Y1MUdPTU1KM0Jzak5GemZaQitVWmFyNkFN?=
 =?utf-8?B?N3dGVStveTNEdTZZZDRMVktPZFRuaDJSKzZzcThwdjhQRk9rS3lyeC9RMmFN?=
 =?utf-8?B?UDVKLzMzZTFBVzV4eFJ1Q0dUOTlCKzlIeFZGSkV6NEd0SElkMjZsNlIrWHlV?=
 =?utf-8?B?UzJhako0ZGQyU3pPa1czM1VFUFBPTjRBM2RkMjA5NGUrTzdDTzNHc0JDQnV4?=
 =?utf-8?B?Q0lXb0pxYUlkSHhmT21RZEF1OTBNdUphVThhL2duUlB1MVFJUVNpM1lKek1C?=
 =?utf-8?B?bElTd3VVenFxa1hjRGl5akxTT2xLdXVMZTNpSmtQVXlKUGNGWFFhcjVJNWVv?=
 =?utf-8?B?RnBrQzJhSFFCUlZMdG14dDNJUlpGclJOOHAwZWFIdUhWMUhmTDIycnZadnhi?=
 =?utf-8?B?N1JZcDlCQ1JCbDlId2Fsb1B4M2tUdVdOeURzZk0zL2xESzh5b0J5R2hOWDFZ?=
 =?utf-8?B?TXhkUFdvOVhoaUhsTG43UU5KVjhPZ0REWFdGaUVja0hXcU9iZHJPZjh1SHBQ?=
 =?utf-8?B?V2wwb0RraG1tdTg2a00wdmFMbkVSUG9DdkhDbGFRVld4MFpkcElNdGFGSkdS?=
 =?utf-8?B?OG1adk9HQjNEbUhIWWtPdURPODZpTTFiR3lmNWlSVTl3TFR5T3ZDZ2dTUXMv?=
 =?utf-8?Q?2fQTuQ4Wbu7DChjA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972f5314-96db-43df-352f-08df29818513
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 23:27:17.2320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JEhOKBAOxvk89JeQ2Lyclt3A7dVNywBAK21/CSdJfcSnzxow8urxJba2G+Rm4js+J5ErIN9IcL9vINrL4zT2vBdnXCxnQjXVGKNNLYovPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7178
X-Mailman-Approved-At: Wed, 14 Oct 2026 04:27:54 +0000
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

Currently get_cpu_rev() reads the Cortex-A9 SCU configuration register
for every i.MX6 variant except i.MX6SL. On the Cortex-A7 based i.MX6UL,
i.MX6ULL and i.MX6ULZ that address is reserved, so the read should not
be performed.

The value is only used to distinguish the Cortex-A9 variants:
MX6DL vs MX6SOLO, MX6Q vs MX6D, and MX6QP vs MX6DP. Read the SCU
configuration only for the raw MX6DL and MX6Q digprog IDs and leave
'cfg' at zero for all other SoCs, which never consumed it.

Fixes: 94db66557997 ("mx6: Distinguish mx6dual from mx6quad")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

---

Changes in v2:
- Improve commit message (Philippe)

 arch/arm/mach-imx/mx6/soc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mx6/soc.c b/arch/arm/mach-imx/mx6/soc.c
index 02df86156d4..824e8ca6d8a 100644
--- a/arch/arm/mach-imx/mx6/soc.c
+++ b/arch/arm/mach-imx/mx6/soc.c
@@ -71,15 +71,17 @@ u32 get_nr_cpus(void)
 u32 get_cpu_rev(void)
 {
 	struct anatop_regs *anatop = (struct anatop_regs *)ANATOP_BASE_ADDR;
+	struct scu_regs *scu = (struct scu_regs *)SCU_BASE_ADDR;
 	u32 reg = readl(&anatop->digprog_sololite);
 	u32 type = ((reg >> 16) & 0xff);
 	u32 major, cfg = 0;
 
 	if (type != MXC_CPU_MX6SL) {
 		reg = readl(&anatop->digprog);
-		struct scu_regs *scu = (struct scu_regs *)SCU_BASE_ADDR;
-		cfg = readl(&scu->config) & 3;
 		type = ((reg >> 16) & 0xff);
+		if (type == MXC_CPU_MX6DL || type == MXC_CPU_MX6Q)
+			cfg = readl(&scu->config) & 3;
+
 		if (type == MXC_CPU_MX6DL) {
 			if (!cfg)
 				type = MXC_CPU_MX6SOLO;
---
base-commit: 32ebe922e574a733d01c3f106fa77d9176bfecad
branch: imx6ul

-- 
2.53.0


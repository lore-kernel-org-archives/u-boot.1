Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D126AC982E1
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 11:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B552180D36;
	Mon, 21 Sep 2026 11:26:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pIIxofLwxrgv; Mon, 21 Sep 2026 11:26:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8364A80D23
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789989984;
	b=btp35pLKryXTHxcYvoXyuHzLN2EqSLJLyvKnXOq16yKGA7nb9JzhrOfLUh+8+gxOe+ad
	 VTIiCRigxreXovoNPdPm//THm6roGffZlzIb1hWdrJ6guaPJuQmIYY6fkAxKJ7YIHrdXk
	 QGzSM9xlCXPWILZ2rpKWuStx4NKr1IasEhGSS2HOSYLVNw3slfF0tzEBKhflwFJYQ6ONV
	 M5hi21s9vHN4Z0B1cC8OfKiVPDvGCYd86JoF1Y5FUl0AR3exFR0kBXL1jVB3K0vnK8rXv
	 IVsCKFTslNvsKCgc/c55kn4odjPDI5RUXQsYlHGVTih+gB/h0YJDeaS/oCKLOSOmXNA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789989984;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qBRmfH+qDxB/1EnYIZfRN+1iEGTXs3z6PTUfl/mlPhY=;
	b=aEc5drDpzGbiUNIRl/DL1FoholzgKRKeIwwslQbQtgImZo2JwgEoJzFziNuvkY+bgcuS
	 D0ec5AgaZWQvbV8xl/kjojJ2zIsXKf30frXdbqceB3dsFJJv+LrUqFy31J1JFAP/oywJX
	 vpj9ElQXmxxBGZ7p1os5MXJxqp+Lof17Py/h0s0BNT3qrX9s0IHN6c65tAwQzqGWxz1Lk
	 95n69bKQx5cqxLgj5M+yXOLhkyJWO25AdAKi0sf9v5xHvgz34ehbNcg7C1z1qQ9RlCQ/Q
	 o4GZ5x1NhxbDhYTO17xcmgo2bRf8vaIpp/pnCE9rm2bHmaSXg72NfpHxA36JTw9ydMg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789989984;
	bh=qBRmfH+qDxB/1EnYIZfRN+1iEGTXs3z6PTUfl/mlPhY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EQTTmk0gzXmbl8+EetM/kvTxkHMLhJyeAJcDB33+0Ts7EzI4unccSkGc7BHiz4yoH
	 X7Uql8Y1jsaJ8pKCreCohJEPKO3GY10dMfE2/K+oJ/UHqU1HLAleOPkh5X6fFV7t23
	 JwrVTflJJKRo0VHN/+gbCKkhkRt20q8YIDew/aFi1IZLUpK+LbAvdTPySlZaUszbvD
	 Wber3vJohziaNIQgLt57w4WSWXmXqsZWHM3FrAusJuFtZPV8AIYEjR6Pc6I1rH/7Yh
	 QbpNfVpvMoqfpBLSY8GkuQ0OP30pIkVBzcTbaN3g2DlKf8F9Z8grLdCLLEYS1VTUp2
	 zxQJyTEqr4jiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8364A80D23;
	Mon, 21 Sep 2026 11:26:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 240EC12C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 11:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15A9740CDA
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 11:26:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9lLFPdRGxbC3 for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 11:26:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6A76540A24
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789989981;
 b=cbnoRJ+75XEtfZ5a39lPOEcAxGRAO7IHnJBJPSAgNjAxT5zntRJ7tZU6rguH5gSuVpd0
 IYOxBMtFlBGCdr79cQ+XT+1A2NWk0FPzePDm3KTdADV19Jd4TuC2oN0uB6uNekq2MG+K/
 yaQnXMgRmtcpeZjK+eItAAUipiRO6M/rbdk56gsQryGUe8mSNMuaYEpjZF2S00ye/m0Qd
 6JL3gP/3IAJvE9ETvNWfV6jClcZZ4QO/SX2zJTkd++U9VMjDMXlhwNHStbXeE0YpZBg/w
 ddNLQL0RC7NYuuq3CCkwd0f08+ceGWNjxlTnfGTVPFawgZIAfpc+3k8+WuzocEzo5DA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789989981;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
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
 bh=qBRmfH+qDxB/1EnYIZfRN+1iEGTXs3z6PTUfl/mlPhY=;
 b=CryGFAZwRB1RxLZN4RhjjXxSbGDaGK6ORONdqM0Q8PfTWyNhHV2KGBhk6+Cd9ocl7DXy
 zBZYxeieH12U82igKwHR4qRQGMYRDe0Xg6wPg0sqIedws5/sj95Lu1z0kcwOCuAXVmfz8
 fp9MSGSkJe+4TFlMhmDvnbLtiSx5rjg47w8nGLZkqAEPvWgll36NP7F6iKAiGb6in3dcN
 Xi8jWwvnywXgdyUqAtAHZvBByip33EUSsFuGPjvS+3COSgHY13hUzuKYW1p0jrxU5KaaH
 Ff3bK4QhO5QIr1WLUBmFd9wmO8ys/TEE2kcbvvS92Urd3NGx1Y7eo/mfaJIchUUVS0Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=prevas.dk; 
 dkim=pass header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=KylphqX6; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=KylphqX6
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A76540A24
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 11:26:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXMx1gf5EgNBH4NcVtsiIPxTj02ku4GTzojLIDdZzcQnGCmIXkS9YjZkDrlw/25pUgOAl9bkhAHMGGAIvZpn39MPO6h2XDG3vagv2A+p9j9EpGft0CQHTKzeQFwLDkCmvOsSMG5Od47Hhx7GzehRuRXa8iMGAvoqoDRunAXEAunAXx/BMUgM7NvrQSLks2V83V7ScxL+hJeGcdjs2lK9yC8JwFinnWRddSDyH/GiB6G+RjXGVkEkGhMkCpM69p5vhGsdbRz/Q2PqsvpQowAcOrHXbtjqDdtrqrUC7UTbUXx/YOZjohPApSuL6GjBiYjxzBnI5fTuogQmll1y4utqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBRmfH+qDxB/1EnYIZfRN+1iEGTXs3z6PTUfl/mlPhY=;
 b=rwAdiIo1MAq3Vc8r97NX9avOWYBAAOYvoD7ANKRnaIk59zkw+WiLexwnUSpfMiKUTF+xQOuCRUCXjRz3a+pcSXd5OSZdQn4u0xcNU82HKwF48hP1FSTUGV4DSO+fLaLls13FrBZHpx/XrhtFQl2IFi5PdNDIihhIzHrtC5JuV4sN8aJAMG0AR4ytInBwr/HsLnJZMmbEk1YXMRXwJoyMAG/KGOdZ4co8BOhw0XTpAjRLH+g3tG4sTnzEx2S1It2BXzaRFpiMs1C7RD7fsQ88LEnfjCM923hcPYeyhWT/ORGpKhvqyaKGiW9V5VMp7/dti1YiktMKR6qOIFFYkBXVxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBRmfH+qDxB/1EnYIZfRN+1iEGTXs3z6PTUfl/mlPhY=;
 b=KylphqX6729DvLbp5ODZZZmJkdWsNrTsQV10PaBY4W1rsMuIAh01eko8ygJ939G3YUrWP3/NXkrWdrMLGCSLPDveHa/CU1CsINutBfXxqH/jWNAmze6iRxJsqwLNt0+uAS3tvRX00MT5rxMXJaOkqVe3ySQlSGlQok3YVLOvIHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB6863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:323::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:26:11 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:26:11 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 0/5] cmd: optee_rpmb: make it usable by scripts
Date: Mon, 21 Sep 2026 13:26:02 +0200
Message-ID: <20260921112607.1562189-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0077.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::33) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 35cb5bf2-ecf5-488b-ad5c-08df17d32378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: CFX38eM0CXD42tdEoE6+s9p6vHS7DC4rcz9TJn0T8PQINRmZHwNDaGonCMIqBshtKOCbp5RRcvVm3YL0Ooga2M5EHyhsst52MHlxp19f3r3GfxbqwqpunWi6thJwQr8DyyI2IeL8tOx7lEA3cDFCqxg82E8xcFfQZ2SYM24Y6katBRoLXbKP2LO2e8XGY4bcSgCyeELaPPJ487+tdtzwsZY99RIUFZKJhIf2dti3ek19JAXPYifRTEvhAwwwZWRGHtiOcS5dgNevz3r3Is0NfJhcJuun/QXdyAJRfEEtW1GaU73tE0ZaadDvmaRkX7Gjpge7xyUZuUl37a9RxiJmhE7fa57ILsN7jD+S/Bx3Bamt6zIUI3JlLszP8WaWGWvf1sCvMVUNO+LPWKp3s84AOXBMZcijUFOTVzq2QpazCLwc7AvTB4kTzk3RHF8bSyOAFDW0HDteqAkGxr9TaMETavPifbVcLO8RuXdtwvJUkuBH5sHg05br/RR2vbm86QuITyAVCApLJr2OkZ3w0HeRpAnmH8/lWuJlJHsJ1nBMmCkxes8pjUOeoR8ojDiOBHHfV35YoovzSIKs46wa1kJeDTm9IZCMUNtszpoHJuwMcekGrNZJuQWo+2mom7G/ilGo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XXPz+pdTcfciy1OycEha3ZazVd+oQlP/eNpgbrJppqTJqcTIY/0Ra7HjCi38?=
 =?us-ascii?Q?gP/HKrJZG9angmhsBsFzXKbod+8r1h/g/cNLvqMVcRTXfjMsVXRUpxjF/vBZ?=
 =?us-ascii?Q?FKOFP1YDA/8Fb6BnMxjIEFQ4G4+x8Os9/LPQ5xWqoKZOhfP2dU5BthutMdob?=
 =?us-ascii?Q?CleVT6ciJq/D82h/W+prIMxVJej7X1iv2Y7gTUmXSxQsJp+A0aQsWHVhBPN5?=
 =?us-ascii?Q?BYQxJNSSNgECTI0F+pyxvd41LCkftLKThVo9hNxCvfqKkmbJK+AHVMq6j9kE?=
 =?us-ascii?Q?F2bqjeXDbC2NHLIqEMXiKxH39mzfsbM7ZHjqLfQ9MLVB812lTHyqr2fiE9TZ?=
 =?us-ascii?Q?s4OlaropJ+suQPI0bnUc6Cpdm0v11lJt2eunbl/lXIPQ+3LxtGjDiv/fgw/i?=
 =?us-ascii?Q?ekAugDzvIY17rNvGSg2OwxpvLr19L5DG/N/yb7TCC+eTB2UghLC4CCNL9LKO?=
 =?us-ascii?Q?5O0T1OHNXi1AKfifE1dGE1jcFfTOBJTx2mZ38q+rv0Nm0zJkI3MWWVlz8n2u?=
 =?us-ascii?Q?mMxBbn4LWLuhhaZGdLTpKyRh+oQzZM4zgnhZLgRETgXECeGqUb7Il/Fvcbef?=
 =?us-ascii?Q?/yofqpHMIA/EGSrvsCTl86rjJKbJU4qM8OfB19Jy21+Izd9ybDCAhFQmr6vD?=
 =?us-ascii?Q?R4f0z7KbuafSWw+pZxemBV/RMaBLj8TlEhJntak5KJoWBjHoGpo7d+0YFz2h?=
 =?us-ascii?Q?fPx+WTEbcRSslo6MWhlUwFbrdvJVsQvpQDkWR336xRO2bMULriAH6nENK6Oh?=
 =?us-ascii?Q?ihawU6fKfa2Dzr1dQReiK7gnHbzSXIF0mTYiRihCWShICvc2gvLnx37ZYW3B?=
 =?us-ascii?Q?mNPz4nWFP6HrqVgPEuZBWqNd+9zvH++q2/MV4noza8+grBCNkRRFqU5HPgQs?=
 =?us-ascii?Q?L5GWDbFdYsVgCC1lLzWdj66UpHS8dgHZ/plOFgjOX+21CgOZIMJO/6YuDDe1?=
 =?us-ascii?Q?UoLWiyWsODJajCCx9JNwCwDqGdG5y3HjvZ+MQcF88vvOwvV0QC60sQoOdC2p?=
 =?us-ascii?Q?k5i7NAsWO7p2gKKy+s9plnVL1qD0j6TA8WPAaRdVpVcgJtrK3jBHugU/Luyq?=
 =?us-ascii?Q?bkCz/nJnvGih8NTPRlpb60jVzuytpW5cwpMbeWiIzydbVAwlIGWZrCpHLtpi?=
 =?us-ascii?Q?QF8HOj49ve/ZHQGMxBPcJlM2/demFogof1k+9H0yifBLdaWBvcE4nQQ/OaSW?=
 =?us-ascii?Q?so7Z4LfNNYcy1WXQkv6gTivfE9AWoBSoME7cjSPc6Z5jrMqLMjP28LxtHvoV?=
 =?us-ascii?Q?gvMxXJGp6VMdrmtiMxAz3v+oIHASsrGxN/7jL4Xk2WAAWVbFW/wfKPRTqcDY?=
 =?us-ascii?Q?hgZZK1Xpjsn6mDBtoophCxxjf3FN+3DPAY3LZn6Ri0lqZUsi0/eCr5xn17Vd?=
 =?us-ascii?Q?Julhxwhn/4+rPL2pyZt1YtIbNcvjlHmNTx1kV/bXx+cEMSdGBPBba3deweEg?=
 =?us-ascii?Q?onHzrODj66DN/IZilTGrSO6w851f/cdQV+B+PPYU7UyQrYoqOwgAiYvwHpl+?=
 =?us-ascii?Q?APGIsroob1IAWg6QAG1Y+o7YTddDOghsR+BRa0pDOfvIdiVK+1AkeKSVa867?=
 =?us-ascii?Q?OkrBGlURVNYjcUoTXoEJNG2F2f+j2fhg14y0YOA7APLFBtrlI4buXHRnsbXU?=
 =?us-ascii?Q?4d4DYuke0F+fE5NrH2b4E+CA0qprH00YePhznG83k7QCYyzvho7k9j+lQjxn?=
 =?us-ascii?Q?Io0h/V7IpUzcjWVFUO+a6pL8m3K3WPENG0lKMsmxvVUJA9XjmHUvqRwmtp2x?=
 =?us-ascii?Q?HYJcQf+26N9HO0qXQJx5a9whvupJ/nQ=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cb5bf2-ecf5-488b-ad5c-08df17d32378
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:26:11.2403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: riaxR/kKKZHqfPfCjOvq/WgF9hba0ZAsxONG3PtYSBdxmVmdoi2NfNLhQ3qbMDLXcet37qBJ9fwyZYrCvGsOI6dshg+CzWenRLraeizkv1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6863
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

This all started by wanting to be able to fetch a "persistent value"
from RPMB and use that in boot logic. I noticed that the "optee_rpmb
read_pvalue" subcommand had two flaws in that regard: No way to
actually store the result in e.g. an environment variable, and having
to know and provide a "large enough" size of the value.

For the former, it's just a matter of letting the caller provide the
name of an environment variable to store the result to in lieu of
printing it.

For the latter, the tee side should have provided a way to know if a
too small buffer was passed, but that was never actually implemented,
and instead a silently truncated value would be returned. That has
been fixed by adding a new variant of the
TA_AVB_CMD_READ_PERSIST_VALUE method which does yield an error along
with the proper size to allocate:
https://github.com/OP-TEE/optee_os/pull/7959 . That is now merged, and
its time to update the U-Boot side accordingly.

v3:

- Add patch updating the sandbox tee implementation (3/5) to match the
  semantics of the real optee-os.

v2: https://lore.kernel.org/u-boot/20260903212215.2331118-1-ravi@prevas.dk/

- Drop the part touching common/avb_verify.c, now that the old
  TA_AVB_CMD_READ_PERSIST_VALUE method is not changed. That doesn't
  mean it shouldn't be updated at some point (the header file promises
  behaviour which is not actually implemented), but it is out of scope
  for what I intend to do currently.

- Do make use of the new method in optee_rpmb read_pvalue, and
  implement the "store result to env var".

v1: https://lore.kernel.org/u-boot/20260828105005.200338-1-ravi@prevas.dk/


Rasmus Villemoes (5):
  cmd: optee_rpmb: sanitize TEE_ERROR -> E* translations
  optee_ta_avb.h: add TA_AVB_CMD_READ_PERSIST_VALUE2 define
  tee: sandbox: support new TA_AVB_CMD_READ_PERSIST_VALUE2
  cmd: optee_rpmb: allocate large enough buffer when reading persistent
    value
  cmd: optee_rpmb: make it usable by scripts

 cmd/optee_rpmb.c           | 70 ++++++++++++++++++++++++++------------
 drivers/tee/sandbox.c      | 20 +++++++++--
 include/tee/optee_ta_avb.h | 12 +++++++
 3 files changed, 79 insertions(+), 23 deletions(-)

-- 
2.55.0


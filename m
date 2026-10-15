Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DBDCCA464
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 20:16:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DA558120D;
	Thu, 15 Oct 2026 20:16:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1WhUtqVTS3qY; Thu, 15 Oct 2026 20:16:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AA84381212
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792095375;
	b=dkNP3FIVqIaQ41q9ZlSEmQuh+ZCUktYfkFpgWJ36/8DAaEGJts01GtWLuDoxfGl3jK/f
	 /nukVAcPz48eB70nspACQkm36FPQnDOmFUJHRGkkQ7pFgb48Civ8sSxigU5bjztEaFftw
	 Kw0CJsS9trC7LZoFONO5upI0oGHBHsshzUdbEEBm14W/foKZptSQetySo1C7shQYyuXew
	 3yyySffv2RiNxoItkjioKTfHtjVrN7yiBN5F/aZh7nYTuZ0qkN/EJNC+uSJauoWJsUHhy
	 4DGtjo38v3nyyok9qxvO9Zv/uyZ28I7tI9qH1O3rXJxfNREWkSRegRQZTMiclZ+YMkA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792095375;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=G0vDI0kBf5psqGSY8qQAQUu0cdWHg1l/QRT4A1jwBMg=;
	b=Xf057/dQCXtfLNdTQ2vH1JeTV/pxO117Nm9HZAiWm/MbME2hBYGMgjL9Br77r2AJMpog
	 b6zkUfNpPtvYzhKm2aBNXj5wBzQk8uptllAaLL2+Vn5a/Emj0mcBBmigzIblM7fSt2GX1
	 a1LORYHsRUESk9GvR6uBg2z3nkijHtEt8+DpuRlYTMnteONRDw6/x8viUeotlmsJfnkW5
	 FBSxStnWw+5K4W3qH0AVDJkepmFISLcBKuJ+cThtcwh29S8s80Gv2UiUtnh3a6kqjrN3e
	 f8sx3jIy9EuRiEbWjYMqIxIUXihw0ZMw+fEMFvLZ2+rKGJsGKRMeEirQLOqiOQpVvzw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792095375;
	bh=G0vDI0kBf5psqGSY8qQAQUu0cdWHg1l/QRT4A1jwBMg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Oa0OjA5NAgi39L0/OURAV4hhBKAMRbUiqicZFno3Y4Typ/Iw2o003B0/i5jJ4mNhd
	 DTT9fTSrqowIZfo3ewO4mJfm0NkxkoA4HKRQhEL3YTIZkuevTzJ1pT+TXLfLNCTjo5
	 cfFu7cncNCM/wBHNQeaImngasu874nXpqkIjIPtFyCPiu2TOIto4uWk+M30Q4eSMLl
	 C0imeSzyoa2WzcyPh0l/jUMfKmhGKYZoUVV6A1NPkOtgN8jekgEv+PB/oTetO1BQGX
	 CcrT+sSto/PXLv7eiYLPcEkVKO0K32m3PpMUEoBVcLWrKqhzJZA5kPEOTaVaJOe88U
	 WGemVeAZfgULA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA84381212;
	Thu, 15 Oct 2026 20:16:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E88E4235
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 17:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA5AF6086C
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 17:02:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jPPqagq-ZtXT for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 17:02:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A1EED606CB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792083775;
 b=CRVk84xxzOE19hOftJ02ZXOkHQapDUnboka6buP9y7d/ijjaO5UAIxF6p938FLm8onak
 QNWlHYN8gIFwcKXaQOAVKqHg5eBbHr63qfLF2ommRWPDkPd+a6fWZwtvzC90C8Kcgr5MD
 QebRkxM89r8p9qxEXD28UUEdVdbelOqh6KlJXZ64dRMM2816O9hFnlM8H3WnFTrJPKUCz
 KiPwTElnTXcilRH/n4T5cl9cHl5lfH1KZ3rqF/I7ZqfF3N4t6N/lZT5g7aHIvYDFYIl5N
 5iLy4Kj7vVLQweOkaRCGgWFi/nXBAcjdaUmMCsj14n0SQjQjdpushXOnCbNIEOrVIug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792083775;
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
 bh=G0vDI0kBf5psqGSY8qQAQUu0cdWHg1l/QRT4A1jwBMg=;
 b=q9ItWrq2o2F0IfnZw3nouluyGMbiRzOfmi4dlMP2mos7uK4kFM0mBmZ6NAzjYD2/END1
 g8i3ptwqZ06aujDfu6qMgrwzxOJDMWmekFTy5ZSWlZ8WmFMeLGFns1SD4uU5KuwoE4QRv
 tMQz02xnXU2EwxZRK2uvZMrQOKqhuhdZYYRYn1PFdpStGm6TC2gRdyrZcHqcf5ezPyton
 +lvDjru7U6w3TTFTtLudc7ERvkh/uvFbkngozmLJU3Mbxk4yptFYmHNIwaWE66DCrnFCa
 uJdep44V0eGZAZz61YrRSPcnYva7kqhPXAsy2wBa80HE9rKhR1DHb0aVp8y7HSKbPvg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu header.i=@pa.msu.edu header.a=rsa-sha256
 header.s=selector1 header.b=BmN1wQHE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=nathanw@msu.edu; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=pa.msu.edu header.i=@pa.msu.edu header.a=rsa-sha256
 header.s=selector1 header.b=BmN1wQHE
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A1EED606CB
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 17:02:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZ64rrO2l7YrCVDXrp5IT9Day58ZwfJHPKHVSy/hJequg0kpZlBx3scW6X3Z+QvdKhFT0q9loki4L8ee0Z0FIH8xQD1MSWxsuktw3qCzCDCCw4BfAmHUlfNdkTeU2KFtXqstF9rvX3RRZKD1RE9biCH8TEkLTlRau6oI/NCYnyDla92s5yi7T77eKOSHDYg78Gegz7E+j7KjiQUtaWnzmELly+zXPD+KBvkv8AgOt9V/KKhTn9ozE0f8Qk9CFAGOAIxNPT3N9CbUIGjEqtk536Sozq6+UJtkCHvkQgJ7nz9gkXC5+Bdl6CjRWL8Fm63w99itDSTjgY8BGuxc0oyobg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0vDI0kBf5psqGSY8qQAQUu0cdWHg1l/QRT4A1jwBMg=;
 b=reruuNm47WK7FZMNnuEtDfeGDXfuCHsKnazBIMHvFL/eqUzbGp8UOkuKXMOKDcZfXP9MDVLS6gxtWQDm9/DXUBXkOQISjuyTRpLGRLPxSBwdL4612jM2dZM7QyO2vJhiEA9XufFPFWBgMtkPcWSMbiqt9GktIZZE7ZEbFEZeK1yimq7Dx6CY32+YtfoLtrQ44mtge4p5sNWbQA/sEcpKDO8BvUdCz2rY0Guo0AUvKgeZxsQBiH9ul5aXscI8rzdpfB5lGtsS6raf0ChoHlvUp5NkIj7lwlNEtFUbDEIyvfo3U3gPkEkRX8eWjSklGQtFsil5OQFPgr4/LPeHbhlVug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0vDI0kBf5psqGSY8qQAQUu0cdWHg1l/QRT4A1jwBMg=;
 b=BmN1wQHEqUHRC6jO2iDUdncOIKnz3BhAYB08tDHXXX2i0isf2aSzjnb++/faB3m6v2H0nxyKhN499ECfd1kBU/ErXC+WttcduKIbGhprl+EbdA5UbKehG7shi/Cf1WoX1vcEYLmG115pKBLlYYBWtiGXvLPeEIxSdo9fSRSKGbXwi0MDmx9dZP57eKBI9qvFeqDaBq3Y5J3ZE8oV7gvFKZAW8+OnnimCVHVFiNhIWOXiggEs6oWHAx7bWrghFQAVrAr5Pt2URwMingraE9yX54uQfiA1O/pJ4ecmVmecBJGKWf2EqyvL8BMCd3kAOdFW2j7bHiO7CZLH4U4FOdxhKQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 17:02:49 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%5]) with mapi id 15.21.0496.020; Thu, 15 Oct 2026
 17:02:49 +0000
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
To: u-boot@lists.u-boot-project.org
Cc: christian.dreher@nanoxplore.com, claudiu.beznea@microchip.com,
 Conor.Dooley@microchip.com, Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Subject: [PATCH v2] net: macb: add 1000BASE-X autonegotiation support
Date: Thu, 15 Oct 2026 13:02:33 -0400
Message-ID: <20261015170233.56389-1-nwhitehorn@pa.msu.edu>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR19CA0002.namprd19.prod.outlook.com
 (2603:10b6:610:4d::12) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|MW4PR12MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 30b63587-4918-4090-72de-08df2ade234c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|786006|23010399003|376014|10070799003|366016|1800799024|18002099003|10067099003|11063799006|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: GWCSDvlrPIrSVSnUVVrXVLoplnkZTf+AbJjQvFfb/5j3LFZMD0D23Lk0s5McYcT04svT7R4xfZ7G78h0/awRW4Qncoi1NNMt1AnY+HFLVcYq8ij5keksVF4ga/l93op1sfUmfBX0XS7Fm2/zxEom19yKkYvO9A9c1TyuVFqY9HZy/d7N4sEz/evlniKd5CfVf9bqV6X/REmu2MENSNyxjDRjrr3sr/y0Ycf9ex8bzRcrPDtQoiBstRTzZl2ZJaei+YhKuaVx1jeZ8zGwe5aq1h//cbq8A/VbatCjEmrLwVOUpNkMGSNvFq+LMZ5PeIOEnF8abgz6M1HTxKF/uJto8PmQZHgQu0L0BakNjvsirJ9LBDZA+m92Ke3F8fOQeFZ2acjinyhQ2PEoWFMK5Xt4TiFH0vxaGWp817qf2T4JjZhClBziivlqUrwlzE1s5WfvRKCA/FNUKBm/5pDDYC6HkFmp4ATx56JHgPlq8L1B/ULlJuV84ugBb5PX5F/FJSRg5IKfPobfQc1xGjIQgWYQ++e0WrBTtVnFbOHCsF3ak/7k+4yDdZ8vObBAJdstOsPONGtXehtVqez0jdUbG7Ry88KeJ4LyUjgmD5UyjHMjs8W7mL7LNL4Oc6nWr1PPv7OqNIzV/JH3tUk9JYJ7EOZdgbvFW9ajLrPa4JTWjE6Xu2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(23010399003)(376014)(10070799003)(366016)(1800799024)(18002099003)(10067099003)(11063799006)(5023799004)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sjrlPdsPQbEDYzJHhQqltPNg/XE1U4uMWXwtLY8QBkNTni3IFX4SOj3vi5VH?=
 =?us-ascii?Q?75miHAu10qCmWJrIh5ZYUhhJoDMKdjZg2e1UF3NFRAC5GinluTIsiEJwUqw8?=
 =?us-ascii?Q?UZEBQ0eoXw+I15nwsXdH9OQXPg9fOGS8z/Khkey6zGuiANBYW1i+lNDFAvsO?=
 =?us-ascii?Q?27iXDksKohPOBiTkMPQmgF9cgfVVLAeYwp5LYN2VbVL5maLSM1/+9wbU8g+Y?=
 =?us-ascii?Q?qY+QqA5d9Bi2aV/jZxEqNXxhVy8ZSQkVoJlAgwm/gzIPd20cbZYQ+ox0ZhAe?=
 =?us-ascii?Q?638ltSfY0B98kGAHiWfZLP2y3/tNCqMiNq2Z4oUfK2N0wlMNXNuiiH/T3dZW?=
 =?us-ascii?Q?w5Wi23wIbtMtmzfV1F5M4kWK1+1HYkE9BzwKq9cQ8Ns2fd4VUiEvjJ9BJaee?=
 =?us-ascii?Q?h1mxgfvxHsr+dXpP8H4ggJS/wNGkD1l10wjslH7KrU0MwgeA3dyQ20K0f+DI?=
 =?us-ascii?Q?qbXTuT1ULLHGbfU4S3pgiWEJBF4B7Mamm0LVAnEkirgZXeSeO2kAUsqNVSli?=
 =?us-ascii?Q?9Yi3f/nlp4m2LhIk41NAO3gjRnPpxlBRrgigsONzgLZX8/AL7Z9NQR7W+5sx?=
 =?us-ascii?Q?h0HTt5blu0PebMx5r6VstTHel19t6z1H1XjpXGXzt4vkC25mdk1KapDzpMaC?=
 =?us-ascii?Q?B+m0wDN/AICNT/tsXRMyHPsDHUlMwv0QjydZaDQLftycjO4X055DFnD74aKT?=
 =?us-ascii?Q?hvWbq49t4beqGjiIi2BDh2DALzDgmfzDPlR2vbUd9wGdKezNET7nvWyQ2hUX?=
 =?us-ascii?Q?1pqvAhQVj1lCSzyoWgbkLWBTIHIIA22lyDAOWDLmgZ4EI0TwR11pT8yFvNq+?=
 =?us-ascii?Q?sNDIoCAJdfPMVav5ND96mV3huS6jmIfhvYBeUYM3vnvfHCBhAYmJXoFdTCW4?=
 =?us-ascii?Q?GQJzmIzIFywVPUbXh+ZZtdQ8LTEZfl8hJXQZ0tFWTjde3XTNK2rdlFJFoFG+?=
 =?us-ascii?Q?EY+vaUuuieXCBU4UcbQCUcOHHYN7kPEqPtA5B/ZptoSJw+LLpdyBwHi4MoG6?=
 =?us-ascii?Q?uTx1ucfjMV/s3LcsASYLE59Ke9LdoA1olse4GdGA9StBh62WDK+aKN7BuyTD?=
 =?us-ascii?Q?w77gsoVKV5T3hRexB9YZN8KcPkKTWKbG47CdaP0U+CiafQx2gjB3EZhWE1Nj?=
 =?us-ascii?Q?urUou5qy2as1N5fp+xe3uheoh6akhNdzS2XkJtnKdPWAb7DWOViE8dLw2WPU?=
 =?us-ascii?Q?EkvvBtP5At3+2YAG3Y6wgQC+54PNPeW2Xx3OIGjBF7HqtZZRxPI0fvfhJr3/?=
 =?us-ascii?Q?NPhKXCCxuqHBoQAI1/LVFo3yg+ryzoSn8bU/Y5a5a33PElBEXUMMn8/KZ6Uk?=
 =?us-ascii?Q?56k/l7jdifNDDR8PmORCYh2l3maTU56Hg/Q3vWAB0ItdY4tUmYR6t/DvFTli?=
 =?us-ascii?Q?LwCqILtpgjesx95BSvSYuQQt4lz6gWjrEhqm305gQJccGa4/NHt9gkGdMOXg?=
 =?us-ascii?Q?2X1/5hhOXNMmbqfKC/UXwg4YOXodt1oabfT/ERdK2a649L8tRELzzwtA34MR?=
 =?us-ascii?Q?wrua1wJdjW8Ut6L56X+hHlHvTqJxkVj9c4q/LQsLGyGDCNzu7EnGAth32Nku?=
 =?us-ascii?Q?FX5DOLLbt2Fc9R2l2vusHI6MMKvjF196jBUEumhcX2UOo3u9FongSLa/mBSa?=
 =?us-ascii?Q?TFDVSzH9Gwbb2D067Eg7THnG6s7xXsuSpCmyeDTPcCaCN10KlBso5eWCBPQS?=
 =?us-ascii?Q?aoE2kGigNkBLLV9ieYrgSHm8A+GVNIh7bUzgxwKmmitzPo7+X5/dpsnUECQG?=
 =?us-ascii?Q?0N5sqfwSQA=3D=3D?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b63587-4918-4090-72de-08df2ade234c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 17:02:48.9813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTLnLMdIf919+z/KK5LUi8gWdU5OtYzrmxDlZ5v4SkpwkNNzZcSZ3Zs+VYMR+BuJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240
X-Mailman-Approved-At: Thu, 15 Oct 2026 20:16:13 +0000
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

This works in two possible ways: through an external PHY or through
the internal PCS. The existing autonegotiation code is handled through
the MAC driver, even in the external PHY case, and assumes a copper
PHY.

Instead, add two pieces of logic:
- If there is an external PHY, use the interface mode of the PHY,
  as distinct from the interface mode of the MAC, to determine
  how to adjust the 802.3 clause-22 autonegotiation registers.
- If there is no external PHY, and the device tree signals to use
  inband autonegotiation, use the interface mode of the MAC to
  decide this.

In addition, add support for use of the internal PCS without an
external PHY with autonegotiation. The internal PCS provides the
standard set of 802.3 clause-22 PHY registers, which work in
standard ways, so provide access to those registers as a fake MDIO
device. This unifies the external-PHY and internal-PCS cases, and
provides autonegotiation with the internal PCS for both 1000BASE-X
and SGMII devices.

Tested on:
- BeagleV-Fire (SGMII-attached copper PHY -- no regressions seen)
- Custom PolarFire SoC hardware with GMII-attached 1000BASE-X PHY
- Custom PolarFire SoC hardware with internal PCS in 1000BASE-X mode

Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
---
Changes for v2:
- Include test history in commit message

 drivers/net/macb.c | 60 +++++++++++++++++++++++++++++++++++++++++-----
 drivers/net/macb.h |  1 +
 2 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/net/macb.c b/drivers/net/macb.c
index bea1dfed892..06e08d1d87e 100644
--- a/drivers/net/macb.c
+++ b/drivers/net/macb.c
@@ -143,6 +143,7 @@ struct macb_device {
 	unsigned long		pclk_rate;
 #endif
 	phy_interface_t		phy_interface;
+	phy_interface_t		phy_sub_interface;
 };
 
 struct macb_usrio_cfg {
@@ -186,7 +187,7 @@ static int gem_is_gigabit_capable(struct macb_device *macb)
 /* Is the port a fixed link */
 static int macb_port_is_fixed_link(struct macb_device *macb)
 {
-	return macb->phy_addr > PHY_MAX_ADDR;
+	return macb->phy_addr == PHY_MAX_ADDR + 1;
 }
 
 static void macb_mdio_write(struct macb_device *macb, u8 phy_adr, u8 reg,
@@ -196,6 +197,14 @@ static void macb_mdio_write(struct macb_device *macb, u8 phy_adr, u8 reg,
 	unsigned long netstat;
 	unsigned long frame;
 
+	if (phy_adr == PHY_MAX_ADDR + 2) {
+		/* Internal PCS */
+		if (reg > 0x0f)
+			return;
+		gem_writel(macb, PCS_CONTROL + reg*4, value);
+		return;
+	}
+
 	netctl = macb_readl(macb, NCR);
 	netctl |= MACB_BIT(MPE);
 	macb_writel(macb, NCR, netctl);
@@ -223,6 +232,14 @@ static u16 macb_mdio_read(struct macb_device *macb, u8 phy_adr, u8 reg)
 	unsigned long netstat;
 	unsigned long frame;
 
+	if (phy_adr == PHY_MAX_ADDR + 2) {
+		/* Internal PCS: implements the usual MII registers,
+		 * so just treat it like a PHY at a weird address. */
+		if (reg > 0x0f)
+			return (0);
+		return gem_readl(macb, PCS_CONTROL + reg*4);
+	}
+
 	netctl = macb_readl(macb, NCR);
 	netctl |= MACB_BIT(MPE);
 	macb_writel(macb, NCR, netctl);
@@ -532,7 +549,11 @@ static void macb_phy_reset(struct macb_device *macb, const char *name)
 	int i;
 	u16 status, adv;
 
-	adv = ADVERTISE_CSMA | ADVERTISE_ALL;
+	if (macb->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    macb->phy_sub_interface == PHY_INTERFACE_MODE_1000BASEX)
+		adv = ADVERTISE_1000XFULL;
+	else
+		adv = ADVERTISE_CSMA | ADVERTISE_ALL;
 	macb_mdio_write(macb, macb->phy_addr, MII_ADVERTISE, adv);
 	printf("%s: Starting autonegotiation...\n", name);
 	macb_mdio_write(macb, macb->phy_addr, MII_BMCR, (BMCR_ANENABLE
@@ -692,8 +713,18 @@ static int macb_phy_init(struct udevice *dev, const char *name)
 		}
 
 #ifdef CONFIG_PHYLIB
-		macb->phydev = phy_connect(macb->bus, macb->phy_addr, dev,
-				     macb->phy_interface);
+		if (macb->phy_addr == PHY_MAX_ADDR+2) {
+			/* Internal PCS fake PHY */
+			int id;
+			get_phy_id(macb->bus, macb->phy_addr, MDIO_DEVAD_NONE, &id);
+			macb->phydev = phy_device_create(macb->bus, macb->phy_addr, id, false);
+			macb->phydev->node = dev_ofnode(dev);
+		} else {
+			/* Real PHY */
+			macb->phydev = phy_connect(macb->bus, macb->phy_addr, dev,
+					     macb->phy_interface);
+		}
+
 		if (!macb->phydev) {
 			printf("phy_connect failed\n");
 			return -ENODEV;
@@ -727,9 +758,13 @@ static int macb_phy_init(struct udevice *dev, const char *name)
 			return -ENETDOWN;
 		}
 
+		adv = macb_mdio_read(macb, macb->phy_addr, MII_ADVERTISE);
+		lpa = macb_mdio_read(macb, macb->phy_addr, MII_LPA);
+
 		/* First check for GMAC and that it is GiB capable */
 		if (gem_is_gigabit_capable(macb)) {
-			lpa = macb_mdio_read(macb, macb->phy_addr, MII_STAT1000);
+			if (lpa & ADVERTISE_CSMA)
+				lpa = macb_mdio_read(macb, macb->phy_addr, MII_STAT1000);
 
 			if (lpa & (LPA_1000FULL | LPA_1000HALF | LPA_1000XFULL |
 						LPA_1000XHALF)) {
@@ -988,6 +1023,12 @@ static int _macb_init(struct udevice *dev, const char *name)
 
 			ncfgr |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
 			macb_writel(macb, NCFGR, ncfgr);
+		} else if (macb->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
+			unsigned int ncfgr = macb_readl(macb, NCFGR);
+
+			ncfgr |= GEM_BIT(PCSSEL);
+			ncfgr &= ~GEM_BIT(SGMIIEN);
+			macb_writel(macb, NCFGR, ncfgr);
 		}
 	} else {
 	/* choose RMII or MII mode. This depends on the board */
@@ -1269,10 +1310,17 @@ static int macb_eth_probe(struct udevice *dev)
 		return -EINVAL;
 
 	/* Read phyaddr from DT */
+	macb->phy_sub_interface = macb->phy_interface;
 	if (!dev_read_phandle_with_args(dev, "phy-handle", NULL, 0, 0,
-					&phandle_args))
+					&phandle_args)) {
 		macb->phy_addr = ofnode_read_u32_default(phandle_args.node,
 							 "reg", -1);
+		macb->phy_sub_interface = ofnode_read_phy_mode(phandle_args.node);
+	} else if (dev_read_string(dev, "managed") != NULL &&
+			strcmp(dev_read_string(dev, "managed"), "in-band-status") == 0) {
+		/* Use internal PCS */
+		macb->phy_addr = PHY_MAX_ADDR + 2;
+	}
 
 	macb->regs = (void *)(uintptr_t)pdata->iobase;
 
diff --git a/drivers/net/macb.h b/drivers/net/macb.h
index 002d5bd31b2..69cede27848 100644
--- a/drivers/net/macb.h
+++ b/drivers/net/macb.h
@@ -144,6 +144,7 @@
 #define GEM_PEFTN		0x01f4 /* PTP Peer Event Frame Tx Ns */
 #define GEM_PEFRSL		0x01f8 /* PTP Peer Event Frame Rx Sec Low */
 #define GEM_PEFRN		0x01fc /* PTP Peer Event Frame Rx Ns */
+#define GEM_PCS_CONTROL		0x0200 /* PCS Control */
 #define GEM_DCFG1		0x0280 /* Design Config 1 */
 #define GEM_DCFG2		0x0284 /* Design Config 2 */
 #define GEM_DCFG3		0x0288 /* Design Config 3 */
-- 
2.43.0


Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE7B606A321
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XYrqCr3e;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=CPiDEqzi
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAE9C60ADD;
	Fri, 30 Oct 2026 14:42:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1EFUr_Me7ZeV; Fri, 30 Oct 2026 14:42:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0EEAE60B14
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793371352;
	b=HN2phmI7ZvHcpyMu1fCKg1J+SFoMmFV03IpO4Kv+sAanxNRxX0Sj7ivmiTSzp6A9JTb2
	 6LT38n0PxtTIJiC7nLyh1Vdz0mBrnY6hyzl+yKSOck+Qsx0iIaQvt18/2+XQ59A6PCwji
	 29nm+cSepvhBdGE4V8bZnh6OyytdzA7OnPRrDZimdTa5O6aM63MiWtUyE0mFs7PcbKC9u
	 l0ty2ZOlqVDf5urLWgV7HOc8ltDlk2yJ8HUtaIy2oCBIgk0nffoAQpoGf0XnxJyq5jJUI
	 Zz6cVJvymjRdSE7No8Mw5WrvO1t2+JD9NohNeMw3fe8PeEHdV3YcU7zfiFr58iagDSA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793371352;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qAF7takyno6uqWqNjrmtxVZO4j6vTPCJTR4kumRdzkM=;
	b=QmHWrsD3pf3Se5L2Jioj811RQ225MQJKtX1cOmwO23vwoXkgXAk1X40joS0aPby+AXL3
	 xsJdy1aehUZU2bGGThlJMxD09mlDzoRumuLLmmrcGG2k++62+utZ1uM5RxhtWgC7KVKbe
	 nOK+x/TY1M1ncOxM/Zp1vRdofdH5kgG+KazzNbr+JfVx2m55x9Gu60oLTwpEvSihwEqCO
	 mE4e/yCqJFaH2vyxJ+wMr5X6X3d1IOnyVa/965oQJolJw+brAFsVfIbt/kgisjo0gMWbu
	 Uh8aGE0Xx+H0cqwRuYqkNtl2r0cwqk712O/4SBN2JYvwo1Z3WtM14kvgkUP7TJavA4Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793371352;
	bh=qAF7takyno6uqWqNjrmtxVZO4j6vTPCJTR4kumRdzkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XYrqCr3ecoAdQBITmGspm6pTh8WbP7JIXz1sKwJsH4KoMWYLZmmhWFhMBaTGhAcJI
	 5V2wrZb2FCWHW4BE3mbD5XWmeWgsqz1aN/rTWLgwV1t3Vy1dn1+wiwy/+ZZTYxd/9a
	 P2rqTg20HULo5CltTn00F/AtAwFrNyXxx7MYYHsIFK6L8bet8YuU9BrN64JKYd+P/1
	 VVGqoZAESgArYrCv0IWk9teZEVTNmRYdDg5HGKTcnxsYzLFuPNbCb8JAw50r1pBj3Z
	 qa0gOVpTyaDPC3Xjff8jyAb8Tlr10NrLZWOtd18ZXGqIT7sEmzTPfyoAKWHWpOoIwD
	 Vu69MkcjPxqtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EEAE60B14;
	Fri, 30 Oct 2026 14:42:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9853C235
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E4C240CDF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:39:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3le1Ls50dZrh for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:39:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A855B40CE6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793371146;
 b=Oz5nSbIctTqz7YWOeQJQFyp9Nvxb/O4xYzzq56Rx5dHMhyPUn6AkDRtmVcuu+Df76+V5
 O5O2ef9CDu0uDqAWe6F+tj9QqEdN2VnBFKVMxnzAnYZq8WM1L5AIcR9CznxnW+EI9+ite
 xkH2IqTDyosNkWpf8gopNOvC1sm20xL5odoURJjpQYjLu3C/8qMdDemuiIZNlyudWd8/J
 EoY75buNeDedKGvtWKPQ5JAVh3CfoxSHRZ9ojtjrRvGV3J2lBp1JmHqMx1Odc/8P0foib
 ziB/Wx40DM2nMw2/RhU442tACz44nIisNXK7XbCrBcE1n6cwJ2iJXIFerKMm2gV2Xrg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793371146;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 bh=qAF7takyno6uqWqNjrmtxVZO4j6vTPCJTR4kumRdzkM=;
 b=ftwxm5aEI8D7fpiNmpzY8GGU7T9lumUfSE0+eicN8iX09M1SVDsXdFbnCJoH5gTtGwLv
 aV3HaLqYbNThEB7EYElmfTOBYwwL8qJ5/MYS3dxzDdTVI/40KZmeq1mEfCWvLzhQ/X5aV
 MqpAp0yyqDm0Kx8V8H73DPJ5fhlnqN1BoafMZp8QuWp+eG2Eou8UfPcm7DISkljdhbzhI
 bkU753+BxnT0Xo0cpbiIN0Kwvy7nQi7C7bRR4S4v19dl/KrQizuJjrMSVb0CGkVgk9yhR
 iqA+282mpnRnkZG3IDm56CJ6CvHeRq16LAChE6o8NECailQSgzJ1mPFQJT1logMEVYA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=CPiDEqzi; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=felix.moessbauer@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=CPiDEqzi
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A855B40CE6
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:39:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVHHFkiw8IDabpYIS3LHa36vHgAqTT3D13MVueZAiSzB3+WeCySshQuXQUrHn48/pB+VbtE1wYtVg86M0mqhQlIYDv5n7npnyCb24AfWGtijpr7FPrqNeqBt/hL9sk5Jrtpi5lbC0cehedRWVAheznRaP5Mp3ojl7Dc0F2cPORVN+jDilMT1F3gTtq3t677X8J9mjc8+Cs5xdT0oECsFlvDhNkcqVZoY1gSo7POHG8drtRrqP0XlGDoz4Dlc+MH1GcAp5QZ8ejlS3RNe4p4PlNp3cG7eo4vIKmmtECuIIEanI3ErvzWGCa3FNtGa4X8j2QH9oDCNKsHw+QJTZ46fYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAF7takyno6uqWqNjrmtxVZO4j6vTPCJTR4kumRdzkM=;
 b=vPg+3sFjCKWw7F4wtQW2K4Tt8ZuF00yW7dPRzvyeuhFgPgMaMqsLe9ckStzYdsg9n9FFOioXSRP+8JlwbmUgzmjSMr+nnOjXjBTOwuhx4kZy4weieneHXP9Ajo8Jf5w0zueUaczkZPFM+nTfhi8l3xPz+JWhCaKSYrSVJKErsditjVKw6ZKE9n8jeLU6pV6qsjlDfr0cc2hGTrG1hTF8vjKuo14nW6qOvZEXsK4aVNAoQtLVyuYNM9Bcs8DZuPF5PyRNyCnf60E2buncaTEgPdMfozwXlon9wmd2U+DW8h45H5kYuSFi8sg/uCp2hXxX97ZIe+1p41pnLthQ0NWNFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAF7takyno6uqWqNjrmtxVZO4j6vTPCJTR4kumRdzkM=;
 b=CPiDEqzigVaaULgIq52VIjK19bhCFa9l8olylXSNUqYzrivr/eCio/hlizaekvaPz66SdduwNzr3+mKVyARTb6A52udr0N9c86ItFYq+8l7s/5OmqiJQm0k9wasLnZTGN9Hcv24Cj/3GfmyKGkqKRJf9KyY7L2AZzDFT/JONIueblnI9ZNljRh9uDQJvMCUFNIaReBLrvlS5NYKlTWa5CS+sfC9BPg/7ZUz1AKhTV6Glyll0xogHyrLz5vskyvxG4wEIaqDZrJs6tfuqvMFuPwbKj5QO+nIErJdXq1qVnz+Z+CgwtUAbI8rNSiIxgTTPXyTrxouyCM0DIZzXWyqSWA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by VI1PR10MB7733.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1bc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.4; Fri, 30 Oct
 2026 14:38:54 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 14:38:53 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, jan.kiszka@siemens.com,
 Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH 2/3] efi_selftest: add test for EFI_TIMESTAMP_PROTOCOL
Date: Fri, 30 Oct 2026 15:38:42 +0100
Message-ID: <20261030143843.467968-3-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030143843.467968-1-felix.moessbauer@siemens.com>
References: <20261030143843.467968-1-felix.moessbauer@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::18) To AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3956:EE_|VI1PR10MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: f02311e6-7ba6-4017-849c-08df3693855d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|10070799003|366016|11063799006|56012099006|261009223027099003|261026140227099003|261022115727099003|261028144727099003|261022075727099003|261021121427099003|10067099003|261022105027099003|22082099003|18002099003|55112099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: Iv8OywEx/6rAAiornu4UQFtMKb8qmml2UUa+fkJEr1pdekOP0/3locPzYOppTBbb4G7iLVQDAXYs8dY2lbRF3zZCm7USQ/gwOLhotP08D3E2laAI5mu0D+Pqw3XoCHghB81cAZDqyxv7UjVHrNLBTpok052RJVjr/4FFAussZcFTArJqxsE/g8I7FxXFsJ4Zrl2pdb1dEqkNk2WjxIUFeqMREj1ieQZa0rQ0NMPCIeL1K77D0Q9UdBf+mgmqKSVEVN8gY4Jt3AJEV7oYbBig5w2qW5/wVV9tXXvAnyaQ4EHWCEEwNb1TiwUfLziCKYOubdj1ojcWWD8+hqLoFh9Tkv9Unnskm2rnM+28nOxLD5TJJlv36GOS2tKiptFZs11/U4u8lgcMvXM3gj0HAU4hoMxiQ80QlQrDYCqQx6ZuhaZiee7f/CTiz5LZLuotW/elDk2nNFfdv7UUJUVh4Q0/pSazkMb8TxXmnwpltZdd/TDYHT2Fhqgv7MJFyrtFSGx0NFiULU7luZj4kN0SaakwtZmnN2uwe8LrP6tMbz5N3f2U/1vT8lLS6gFgxs+GyMs9cRYaYAGXof6bgW54we1xhoLmExX6WfucLfFB/jIULYhNhZUZxwl0G0KGAraQFN9lDT7Su31JGgaBAsjqKLYwB/mMd0gLglD0F09GaZbl/qg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(10070799003)(366016)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261022115727099003)(261028144727099003)(261022075727099003)(261021121427099003)(10067099003)(261022105027099003)(22082099003)(18002099003)(55112099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0dVvG5JnxXZPJgBegsrOsEZfMv583YqkovnGMXaPPelTTYCeNs/XRryejaFI?=
 =?us-ascii?Q?eFt8AtRsrCyCx1CSmcwua4quQggfI8dCiNDZFTFnAkQTqNlRmXpCbCBntmd2?=
 =?us-ascii?Q?HOqXCoXmr50mO6VypAYbXKNKB5OVqEm1Xvvyua4SWUySzZIWnauEJE0UfTrl?=
 =?us-ascii?Q?GT0iz5uDX5A5tnovL9WOFe6fyTOLXngY05490t/5BINUFOAEgLo8yYvcoHF3?=
 =?us-ascii?Q?t5uowROu1lQkqY6BHcrNKwYL/dlUxH7c2wJsbQeNKBj5Dy5bFav0OsOFrlAH?=
 =?us-ascii?Q?5TDfIe6SOWoIsrg/F/TSiuV2VoiTgpTusdcMThAs7D/y/1bFtzByGk3YFP/F?=
 =?us-ascii?Q?Xp5CJBBmpyjrJcEuoH3Fkkfu/gfsePcgp+yR2070y6joHRi5dFm5+7uxoN+u?=
 =?us-ascii?Q?kdHFEYZ7Ayz+kLachuN2MWt6l+lRYuaOKDzUL40bkfWecHUjJaCKGs9nEE69?=
 =?us-ascii?Q?lcdx3JQ8S4dXkF1OsXGqTouu+BGJVxIUK4f5k8wgumYlap67H1Zymfpqd9PW?=
 =?us-ascii?Q?SrdWOivF2JJZa3lwbhuD18+1iik5p2fbIlreXxKv2uSd/+CwtlKKvmHiy/WP?=
 =?us-ascii?Q?WwfRnYAbdk83b+1EkQ9jshyBCAH8da53T79X7JFXuwTqiRG7RtUONVfvCWFF?=
 =?us-ascii?Q?+hSC9spycvx1Vlt+GCukPr2XdyrpD9eUTnZFP2FGeUGedHgseF+vBVThTRB+?=
 =?us-ascii?Q?K+tQMksOpoHYSu8PT9a1lMW3h4u/6Y0GVbGoWh16h1P5JxbGX6D+NZRf6W25?=
 =?us-ascii?Q?J8rrWS8PRdTmGoe2syBIV6vwY96cLo5Nj2zibb4I+JDxbDYUPc7qawNJf6Pq?=
 =?us-ascii?Q?mtkx9vBFGkCWBdWdghnZVqHwbWOZa5KB3lesocyN4PjhZ0dJoDnxYlU9rwA6?=
 =?us-ascii?Q?JeDEsSPUuQY0UwxOhh46GXp8PRT4qABZZzGHVY+rsSQrNGwbrqTbCUvX7sJs?=
 =?us-ascii?Q?PsmtSEOCvxHsPG0zC8qubdEwTXL8LdCCkJ7MBMjn2VBdOX5sJxbuwG/7B1u4?=
 =?us-ascii?Q?uE0ajsgxYbHLTp2AQkDUe+J7HBr5+8ceMPWl5LLyPG/2Fm5OE5Zt6ZSt9Kb0?=
 =?us-ascii?Q?2uOR5fdEIpY6KvCcyqqOxhvkQ4o64e74H33qxEIZY9wj8nmtfxXdag7yLjQd?=
 =?us-ascii?Q?zagmk/rXb/yuVzQUzFaDoDa6Tv70VSaXx/DY0HCFArPXn2ie9kWgfQhSUxWc?=
 =?us-ascii?Q?bBitDi+ScxyT/iG5YNoB6ZE1l87CfkWeh7a/xUfYe+aMmnm3sTuc+gWaKHWd?=
 =?us-ascii?Q?3qT1NJTGU2dvAM82wp4f+sEGQYae1Uyaa+9caJPhzfyfirFkc3lU5c9MQVhQ?=
 =?us-ascii?Q?vhVQ9Q4iQWBrVwaovOxwQhHXJtpRiUWKz8bcWGHhomIFoXAJKcYY2eXA5PnT?=
 =?us-ascii?Q?sA5hBfVtyFMftNGeifWj486KU2+OnYUsMMkvSQmqMZWM/V/TA4Uc27ioOEXK?=
 =?us-ascii?Q?vsgy/wbexvIFKTSdVlDSzfhr52kIC9n2aWt/fNDVqNzg9sxgAuEY5WR55Qfy?=
 =?us-ascii?Q?7+A59QaEHlGSJtp0Fq8njgHppA35vOWS0/bsytQWBkph+zQhXhGsuDZQm9CX?=
 =?us-ascii?Q?fcmFYqxkoobzycBDnpFo9wLtf4u2LcOHfhvWVdVthKiUSul0izbhzvLpBCaS?=
 =?us-ascii?Q?AAfUcwxq6+PWkvykDfa5lmrgCd1c7zW/mXv/LB5JVmItt0y1orhh11jaHzJt?=
 =?us-ascii?Q?MiJ6idA3bF1h7/DX9mgMPt9wcXiZe+Ev0oJLSZGABPZBFh05+JvQN7W07SXk?=
 =?us-ascii?Q?QcnuTdrt9D3cq+5uzg8AHyWmFFB1/GFLvFIjv+Wgn88PswrK6NTdY5laCnGX?=
X-MS-Exchange-AntiSpam-MessageData-1: ma78yIgsf/u2xBDnvc7jimsbZxDMwdqfLis=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02311e6-7ba6-4017-849c-08df3693855d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:38:53.6674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xvgS+Mjqg2Ijt44IvzIB96CHADtfz7MYYBErDOghKCCnqcB49t32d/GzN32PKlt6AacHvpDXJU8vpdrqA2akUaQpUiFUtK40Vdl35kv7gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7733
X-Mailman-Approved-At: Fri, 30 Oct 2026 14:42:24 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make sure the protocol is usable: the counter must advance at roughly
the reported frequency, otherwise applications get wrong time
measurements.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 lib/efi_selftest/Makefile                 |  1 +
 lib/efi_selftest/efi_selftest_timestamp.c | 99 +++++++++++++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 lib/efi_selftest/efi_selftest_timestamp.c

diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
index 9882d9f2748..552eeb071a7 100644
--- a/lib/efi_selftest/Makefile
+++ b/lib/efi_selftest/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_EFI_LOADER_HII) += efi_selftest_hii.o
 obj-$(CONFIG_EFI_RNG_PROTOCOL) += efi_selftest_rng.o
 obj-$(CONFIG_EFI_GET_TIME) += efi_selftest_rtc.o
 obj-$(CONFIG_EFI_TCG2_PROTOCOL) += efi_selftest_tcg2.o
+obj-$(CONFIG_EFI_TIMESTAMP_PROTOCOL) += efi_selftest_timestamp.o
 
 ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
 obj-y += efi_selftest_fdt.o
diff --git a/lib/efi_selftest/efi_selftest_timestamp.c b/lib/efi_selftest/efi_selftest_timestamp.c
new file mode 100644
index 00000000000..39583f0df3b
--- /dev/null
+++ b/lib/efi_selftest/efi_selftest_timestamp.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * efi_selftest_timestamp
+ *
+ * Copyright (c) 2026, Siemens AG
+ *
+ * Test the efi timestamp service.
+ */
+
+#include <efi_selftest.h>
+#include <efi_timestamp.h>
+
+static struct efi_boot_services *boottime;
+static efi_guid_t efi_timestamp_guid = EFI_TIMESTAMP_PROTOCOL_GUID;
+
+/*
+ * Setup unit test.
+ *
+ * @handle:	handle of the loaded image
+ * @systable:	system table
+ * Return:	EFI_ST_SUCCESS for success
+ */
+static int setup(const efi_handle_t handle,
+		 const struct efi_system_table *systable)
+{
+	boottime = systable->boottime;
+	return EFI_ST_SUCCESS;
+}
+
+/*
+ * Execute unit test.
+ *
+ * Check the properties of the timestamp counter and verify that it
+ * advances at roughly the advertised frequency across a 10 ms stall.
+ *
+ * Return:	EFI_ST_SUCCESS for success
+ */
+static int execute(void)
+{
+	struct efi_timestamp_protocol *ts;
+	struct efi_timestamp_properties props;
+	efi_status_t ret;
+	u64 t0, t1, expected;
+
+	ret = boottime->locate_protocol(&efi_timestamp_guid, NULL,
+					(void **)&ts);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Timestamp protocol not available\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = ts->get_properties(NULL);
+	if (ret != EFI_INVALID_PARAMETER) {
+		efi_st_error("GetProperties(NULL) did not fail\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = ts->get_properties(&props);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("GetProperties failed\n");
+		return EFI_ST_FAILURE;
+	}
+	if (!props.frequency) {
+		efi_st_error("Frequency is zero\n");
+		return EFI_ST_FAILURE;
+	}
+	if (props.end_value != ~0ULL) {
+		efi_st_error("Unexpected end value\n");
+		return EFI_ST_FAILURE;
+	}
+
+	t0 = ts->get_timestamp();
+	ret = boottime->stall(10000);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Stall failed\n");
+		return EFI_ST_FAILURE;
+	}
+	t1 = ts->get_timestamp();
+
+	if (t1 <= t0) {
+		efi_st_error("Timestamp did not advance\n");
+		return EFI_ST_FAILURE;
+	}
+	/* 10 ms correspond to frequency / 100 ticks, allow 50 % slack */
+	expected = props.frequency / 100;
+	if (t1 - t0 < expected / 2) {
+		efi_st_error("Timestamp advanced too slowly\n");
+		return EFI_ST_FAILURE;
+	}
+
+	return EFI_ST_SUCCESS;
+}
+
+EFI_UNIT_TEST(timestamp) = {
+	.name = "timestamp",
+	.phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
+	.setup = setup,
+	.execute = execute,
+};
-- 
2.55.0


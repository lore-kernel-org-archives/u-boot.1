Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8473606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 17:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k3Mjj+/c;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=KPblRNBE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E95C60DD8;
	Thu, 19 Nov 2026 17:25:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ymmtzHURbfsi; Thu, 19 Nov 2026 17:25:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 80DAF60DC5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795109111;
	b=rMIvy+1PqHQ4c/pUaAZnbU4FfaDJWLrEkaTCLvT8FZFY2M282kGwPZJwoJBK6UG9ksJU
	 SpUgk+Aq79q1MVaeFQtowYjzansuH4Nv/PA7+mqth4fogST2WJ3q2PnBYIlrFE7Ri8Vkq
	 o1kL3XvM6YH2XTQX2FH8aLNk75Xw5oDC+85DvfH6kml72WkKua1uqE42Ok4gTUOQ3xOAF
	 NGKRClrLBQpw5WPgYdI60iZFDyORbnIziOg4KOPzBlfYLF3hRa/WcsdlDXmeLQs10ALW4
	 NIdOy+sxhP6dlGqvcC9a5KKUoMsZrz7ppFNROIu1XTgYabOn3PCKqs3VEwaQl/GMxQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795109111;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mluAHrHlQwuAaOHw4W3e8kxPzRfnZu7GsY6nW5Pkao4=;
	b=gfc5a5CXUVqAXZSx3sE1WEQLpm4Li8c9xp3d/sUIWeQtV6hu/72LQgugutYwjq0Zz6uV
	 qMoBehllRUEWPhYZRA8WHBRlZS5ENLGIXmLpZMQ07AcZKgfhPCzo1yHQjiG0kWT0zqBmf
	 feEi8fpCRIaeIX9T0ccc1lHovP54CVhS/hawFfucI+6WYOLehhXjgTXS3SOwHjhOFbal1
	 5e3fKyLGqAg9EK1qsSs8oMMLIyxxnMlPi5Nas7NJ010W7mJ49neGQSNy1ttYsy1Gz7oe/
	 v4NOwqZsT3WKLsEw5jsuCKKT9zcFMfzgbz/hGEaABk+zan9AIIITJ3+0WSQt7/Gne6Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795109111;
	bh=mluAHrHlQwuAaOHw4W3e8kxPzRfnZu7GsY6nW5Pkao4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k3Mjj+/c5wJNgD/AJEuvw++5Mop6XZyCEBjh3Z6ABO9GO6C1KOAO5qMdj4pUnsODn
	 rHbDqz4vRnxLNEUS8kBn/v1bG/jUNYplcuVGM175P/R7qggY3OE+HH+EU2cDHe/xy3
	 qj7MSmvsKB+ITQBuaEJ0PpMog2BNS6WtWlUoxBkm3Ky1UW6xUjzehwFGFmZskQRssX
	 gjhukrKUROn3ICeu6YkS70oXC3FUr8CpmIKxvEvhmaDordcVgJLp0dhlW86y9ZIE0x
	 6uO1CJ2cJp8Es2hUooUAb2hoW5BeZa+qjqhOcYh55c/tlNyGrD2P1XpqH7k94n++eB
	 vqUvfBGBsefZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80DAF60DC5;
	Thu, 19 Nov 2026 17:25:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9FBE322B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:25:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C219A81396
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:23:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x4YopfSoMCVo for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 17:23:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8C7048138E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=KPblRNBE
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C7048138E
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mluAHrHlQwuAaOHw4W3e8kxPzRfnZu7GsY6nW5Pkao4=;
 b=KPblRNBEDUfaQc+jvBBbIgqgcig0KtO/yX2IDJ6mVh0VOpiswDxCw06KFXcigBVH4VO/RgrecCnrsYg6CwN3cR/WoMk3viDENXMySqQ1rB1zpRTcc99/jOGNZTfGDnAUNJS2GiAF7swtEFwHlPjI6x1ZZ8/pubFy+flGBaMy/o8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB7751.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 17:23:50 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 17:23:50 +0000
Message-ID: <912e3d80-3a85-4281-91ca-11de8a26bf59@cherry.de>
Date: Thu, 19 Nov 2026 18:23:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/15] buildman: Cope with CPP="gcc -E"
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@nabladev.com>
References: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
 <20261116-qcheck_fix-v3-13-b6cf7e96944b@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261116-qcheck_fix-v3-13-b6cf7e96944b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::10) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: c7386007-2e40-42f0-5869-08df4661e042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|10070799003|1800799024|6133799003|18002099003|17002099007|22082099003|3023799007|4143699003|56012099006|11063799006|261026140227099003|261026121527099003|261022105027099003|10067099003|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: N4oapVAEBnTXkcf2uQTykTadNAkClRnw4RfPEgaMqA1srDQ+V6zuOLz8X0ikWdShL6fB6LKM2HmBUN8VGg/d6vfblI/ATnSvYiFJMa2hqCMo+pt5yO5vIgKcWzHErTe51ffYf40y7qkUE5Zm0GPCio3wvhcR9gl71GmPsFwpbLJDvxZHyyvNsDWz8UzmqLa01cfs2wLoBVkHXAvC481uoSJUyulgy3baKE849u+jdu2+2RgNXsRN3Mpm9Oz0VwO0cyH4pTCRbM5Pn6PmMfb0/vCa0YEJcUEkpXSEBK+kbcXXimcOnFykl3sX80DMPHbGU0nBSXrR7FoObdenbqH/Cs3U2YxbepAulQaGm12FtMB52d4wrfDvtxS+eCRVrfCUQaT3TGyjTXylZhA6VEgBX+ywxzp/90M6M9D8zlZk38O2aZZoOmRhhr6AEyXKFSQ6b464YFjr6EpZri6gC9fIhV95h5J0aEME2XNIuoSy3BS+pphq3lGUBzTBnZAugCqmZMn2MASPRBQTIH+fY6L/SOHL3eFJeDktjZbiKKU+vFd83lZ8seoHWAvQywXFzhx+xzFIffZPgOkZPaKpyhlB/kIvaJ8FXRSu42WVPqOMYfgb25QMZ/gTm8wqLCo50+i3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(10070799003)(1800799024)(6133799003)(18002099003)(17002099007)(22082099003)(3023799007)(4143699003)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261022105027099003)(10067099003)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGhxTk4yeEJzRXJWMmRDSjF2RUhkMFNBdlJ0enRMOUp6SDBoZ201d21hWkNO?=
 =?utf-8?B?YW95ZW1nOGpadkZ2cjdQanRzMlp5YlczY052b3Y5OUtnbWR4RmRsbmo3THU5?=
 =?utf-8?B?cWdjcWJhUC9jK3l1QjBJMjc3SUlOblNMWUlFNU00d0ZPY3YvSkZpazYvTHZm?=
 =?utf-8?B?dGVBK0tPaHZqcVNHTFV0bFBHeGJJK3JsWWd0a3czU0thbW40dHRpR3Z4RXNL?=
 =?utf-8?B?b3FYejE3eW9Rdi93aFEwYkhIMnova3l0RjBUV0FPYk45RVJxWHZ1anBJVXly?=
 =?utf-8?B?YWxhOUErcEg3WE82VDE4d0cvQnZWSVpKcW9VN0s2cTZHcXpjREhRNXNkR2Na?=
 =?utf-8?B?WmtGQ3hVSlZ4dDNXOVRYb3NDcVFoa2tTUlJBQ2dxMnJOclhWd3dmQ3ZBYkJE?=
 =?utf-8?B?WUFndGhHeCsyYUxwU2VObUlJaEhWZFJBdzhweUc2RGNqcFVka3JvaE1rVGdF?=
 =?utf-8?B?SzRiM1Z1dUFRQ3VpdUJzZ1BjSm5kMHRXd0haNlpXRWJSdFJGemZKME8xdjhz?=
 =?utf-8?B?YUd2U0kxTm5waEFNZ1RGcys0NTNJa1RsV3VOVTFsenhJOVJvSXJsM1g4Nldz?=
 =?utf-8?B?UElCMW4xcUMvcUpNTzBaeUNsd0tpRTFaQzB0ZXpMNW1iMVFMeEU3ZnZDbzlZ?=
 =?utf-8?B?cktmM1JQSDU4dXdod3NnY1J2andNUXFpZ0M0MnZwQ2JsL0xxQytyLzF4TXZo?=
 =?utf-8?B?VDVwMVdLb25LcjJDa0UyeVZVK1dmTmVjM3pTZXBGTStzYlcwRmZxaGNLRDdR?=
 =?utf-8?B?aUVJWUZwL2ZtK0lLSGpNVWkzeHJNWFd6a2Y4UUVIcXA5ZmQvOHZ4cHFIeHJJ?=
 =?utf-8?B?ZlZPdllQL2RTVW5COUIrY21GZHEybWlTZ2RnQ3FneGd5SkdYTnlBY3RTVjNw?=
 =?utf-8?B?V3VOYzg5Rk5FM2N5TjAra2lwdkY2SGRYTlpmMTVXL3ViRlQwWHF4TFYzZUpv?=
 =?utf-8?B?VVhkYWpUWEVQNC9ZTkxZb01jWGpBRURWczV5VENFN25RVHovaWdsWkFJSUdX?=
 =?utf-8?B?MXRvMlRHb1M1V29xamJpeDV4TEtjYUo0STFuUE1qUnFGY3hSNUZpWGF4MUM1?=
 =?utf-8?B?S0xHZkJIbnpXdmdvaWJWN1BrRUVvTStnZDErVU94VTFyMGNoSEt2anBXVzFt?=
 =?utf-8?B?MTBQZUphdEZpcVlaSVppbDk5d1hrRkY4a1N1cnRXbmtRc3ErajVpTnlIc1py?=
 =?utf-8?B?Q1Q0U2lFZ0c0V1NwblA0eFh5bnNpZVFWKzNUbURNZHp0cnIySFo4WHFIOFNi?=
 =?utf-8?B?NEZ3bzBrcU9RZnc1NkN4Rk85Z1N2SWpXNVBSL1pYOUw4UU1TQmVyRFZFTmh2?=
 =?utf-8?B?QTdMd0ljT09pbGNUSHFoa3d1VForVEVIVXF5U2NyWUtHd3A5RyttdkFqU0xY?=
 =?utf-8?B?MDNyT0VEMGJsU05OZ2pEeHhhdXFpNXVqTTJTTTVIajVKNnppdGViQ0Y1N05C?=
 =?utf-8?B?b3NrNVlqbzFVTFh4Q3E1QkhsWURrMGl1K3o0TzU0TWZBUStBU0wvSVlTbUxR?=
 =?utf-8?B?dU12N21UcDlHaUk2Wk5tclRKNkVhcjhDREx1YTJ1ZHZnMDFXSHl4NHVWQVkz?=
 =?utf-8?B?cEZsc2tBRWt2WUNRQUFsc2p1K2F3SDJBOUI5c0NGdDNLWUJDREVyRG1kUlJ2?=
 =?utf-8?B?KzdNSTh5OU5mSzdsUk9vbStJUlljUnlhQzExTDJGS01QZ1RzNnN0YThud0t3?=
 =?utf-8?B?U3lmSFErS2pHR3NEWGEzclN2SjV2M1c1TmFTNXFSY29uOTFPenNJdm1JVUd2?=
 =?utf-8?B?WFF2OTBheUFNWjZ2eHZEOTVia2xOREZ3YTMyNVlhd29rRnIxcHp5RHpONkJS?=
 =?utf-8?B?d0t3ZmRPYXZvSnBFWW1HZm9UL29xeHBXOHlZcXFWY0xadGdtMnJUcnNFOWpR?=
 =?utf-8?B?T01aVGxPSkVSWTE0UThIU1NCT2JJWmo0ZVN6RzRncnNQVGR4dVh4WVVnT0Ir?=
 =?utf-8?B?NWdDSzRlYkJWTVZBL1Nka3ZiZ2wvNi9LWEdKdVRwNGxEOUp2dERNT2ZsMmhp?=
 =?utf-8?B?WUg1TWcrd2d3M200RDdXRjc5VzVmTUlaRkduMEtQbk9HZ051SlFOOGxrUHpE?=
 =?utf-8?B?dGMxY3dubWxYV0Y4Z01Vam4zVUJNRi91TFZyVGh3bkNoMlF0RGJmL0FtUmZU?=
 =?utf-8?B?cUZ4alZLT2FDMWNyd09ibUkybTRZZmtXeHN0QkNTaDRyMmNvc0dqNm9aL2Q3?=
 =?utf-8?B?anJCbG1BclZ3TnNVNStzMFp6aWRUdFBkWmdqa1RxaHkvaFEwRHl6Tm1mcXJX?=
 =?utf-8?B?YkJ3NWFGL2JJR3k4TnVibjkxRDhLVlpxbHZzTExlS05CU1IrbERHd2dXeFMw?=
 =?utf-8?B?OVpCZnRaTFRwQW1IVTcvN3dtbEoyRGNUSUtGT3JDMkNlaVhRM2JWWVNwQ1V2?=
 =?utf-8?Q?nC6mfOYDhNLQBEtCONtmjPkVE+Df0ZB2JC3L92sVWdCZT?=
X-MS-Exchange-AntiSpam-MessageData-1: Kytef60Wb0PzxMlu9q5O6rLOsAywi7slq8Q=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c7386007-2e40-42f0-5869-08df4661e042
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:23:50.0791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jzzyaWjGf9oF83Fg6Nlr0wcwqB7yldVur65cS7WSUVizzUKZ/D1g3FsLHyAUsh8j83+eYXhOfWdCfAGcrOGklx3714hFzu5J4dEHAsLGFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7751
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

On 11/16/26 11:59 AM, Andrew Goodbody wrote:
> Allow the use of "gcc -E" as an alternative to "cpp" when set in the
> environment as the value of CPP. Accept it as a valid command for
> running the preprocessor and adjust the test to not depend on a fixed
> number of arguments. Also split it into parts for constructing the
> command list so that the validation for running a command does not fail
> when it tries to find an executable named "gcc -E".
> As well as -E accept --preprocess. Also accept clang instead of gcc.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   tools/buildman/boards.py    |  4 ++--
>   tools/buildman/func_test.py | 11 +++++++++--
>   2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/buildman/boards.py b/tools/buildman/boards.py
> index 5d5d3a3822b..1e871c9921d 100644
> --- a/tools/buildman/boards.py
> +++ b/tools/buildman/boards.py
> @@ -12,6 +12,7 @@ import glob
>   import multiprocessing
>   import os
>   import re
> +import shlex
>   import sys
>   import tempfile
>   import time
> @@ -244,8 +245,7 @@ class KconfigScanner:
>   
>           temp = None
>           if b'#include' in tools.read_file(defconfig):
> -            cmd = [
> -                os.getenv('CPP', 'cpp'),
> +            cmd = shlex.split(os.getenv('CPP', 'cpp')) + [
>                   '-nostdinc', '-P',
>                   '-I', self._srctree,
>                   '-undef',
> diff --git a/tools/buildman/func_test.py b/tools/buildman/func_test.py
> index fce615ba8b8..7a5f9ba22c1 100644
> --- a/tools/buildman/func_test.py
> +++ b/tools/buildman/func_test.py
> @@ -378,7 +378,12 @@ class TestFunctional(unittest.TestCase):
>       def _HandleCommandCpp(self, args):
>           # args ['-nostdinc', '-P', '-I', '/tmp/tmp7f17xk_o/src', '-undef',
>           # '-x', 'assembler-with-cpp', fname]
> -        fname = args[7]
> +        # If 'gcc -E' is defined as the preprocessor then the args list will
> +        # have an additional item, '-E', at the beginning which changes the
> +        # number of items in the argument list. In order to guarantee picking
> +        # up the filename use -1 as the position which will always be the last
> +        # item
> +        fname = args[-1]
>           buf = io.StringIO()
>           for line in tools.read_file(fname, False).splitlines():
>               if line.startswith('#include'):
> @@ -424,7 +429,9 @@ class TestFunctional(unittest.TestCase):
>               return self._HandleCommandObjcopy(args)
>           elif cmd.endswith( 'size'):
>               return self._HandleCommandSize(args)
> -        elif cmd.endswith( 'cpp'):
> +        elif cmd.endswith('cpp') \
> +                or ((cmd.endswith('gcc') or cmd.endswith('clang')) \

suggestion: combine for shorter line

c.f. https://docs.python.org/3/builtins/stdtypes.html#str.endswith

cmd.endswith(('gcc', 'clang'))

In any case:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

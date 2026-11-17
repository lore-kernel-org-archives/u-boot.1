Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4CD606A32C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uX28IZKL;
	dkim=pass (2048-bit key, unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=eEitO/qD
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E3FB40596;
	Tue, 17 Nov 2026 13:09:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0AB3b9Xud8m0; Tue, 17 Nov 2026 13:09:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C85F2407FE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794920944;
	b=gXDtLXkrYTCoe2K5n/u5jTqEUurLWm+zZKHzfMJZBZ7eIlZBRH9DxSuPBUBKSJcSVdC7
	 wcb5JJxOTY8NIEHHwUTu9Y8ZwYHXnwbdhS9MjUMDBrDCFejTWYB/WIBfidja/oSUwmhJ7
	 wnFk7TTjXOm0LvpfWAZ/mkDlYFQOWsPYpC4ZXq5sp/Ahno1PcHHnxLdaOtu+/97Qjvrjx
	 bUSCNt+3LOIx1dhImWbOFSKb6XiFjFftExi4tcyCgmHzsh7fEok/5zGbLHs5WVztu4dkK
	 zY0N0YY14a14Fc4oTaiSRCq6r61E6rP9veWAV1fLrPB41VdOTyV+oBK3KpEvcIKCt2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794920944;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:From:Content-Language:In-Reply-To:Content-Type:
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
	bh=P+bJ2rOUdR+uNtSjCPsP2qhDCJnelUYQS8Xs7xcEbKc=;
	b=QVGMZOTcLvCmKbiqJOYuTlC5pKVjRBCsk/jT17ZLX36TB03GHjwSVdbLjoSKRgOdkx5o
	 rxQ4oSKgwWlhk6Ipa4Op6fLQ0ybvkNMM1JdX/w3f0NIiz7vnKmNeCtPtPqGDpIEcK5ECL
	 df0oC8APbYqHflPtUxdiyiOKnL5odfuQ8TCh2Gl/ISuo5RndhnXDasD4tPdJMFlEhEFo/
	 hONnHBNXJtMd4vQ1qboYZZEFnqd26PVmi7cSuyspFFUTqVQJJWCLeIDCBeHP1c+q+s+PK
	 WMTCntmoLcElixsiGEqmrzgoUXJjJ2g+NjZKCqiBtRYeASc9VOlC0OOtSAwV3XxTDzQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794920943;
	bh=P+bJ2rOUdR+uNtSjCPsP2qhDCJnelUYQS8Xs7xcEbKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uX28IZKLdoBPgcvssC+81euDKHS4All+eVxj4nUK99ZfK0rEJGhRCPp1bYzFqhAmL
	 fr+Eo15jlbwIA+dzFaVV0PH8YaPX31yJfShzmSKXLp3wqtOgMb6uQk+E8ADXokf0A3
	 gXlIfYtdliYPAG9wnrztIjr7TkLioHnpUmLA/NPC5vEugyOZhSLGsxDHVQbUdEtTmS
	 DbNXuMjaknlDaexHu0CbI/bA0pPD6fufInYPPsDijnNP8a/+mp4xDu/J/xmF0bn+oy
	 m6dkJ0MetVFtZe34CBeyiJvAUDs2FtJOIx5JtpNlFCPYuUhGMwwaEM7NiwPcv3wamB
	 vlxddmBDEYs2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C85F2407FE;
	Tue, 17 Nov 2026 13:09:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BB3B105
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:09:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4D21580CA9
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:09:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X_jLNlvBfWQE for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 13:09:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 08BF580C5D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=w.egorov@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=eEitO/qD
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 08BF580C5D
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+bJ2rOUdR+uNtSjCPsP2qhDCJnelUYQS8Xs7xcEbKc=;
 b=eEitO/qDRnE4CD1IDMFB4xxKNqFwSLyJ60ut5kOm3mc0xEVx2AiLCt8dR91/QjkcRXuqJYRo5L9d6g1BIjhPTdyeiQCBRhSQru9hcPTY5lP7ObX2vp36FpYCF7mj+SzDmNjH/HpFbdolv1Wgru9aIWwxTE5z8O9i1SStbKMEGiYQQbYg9gm245hzEMGQCGjnDLR5H3p/AzPH2Y/AvvFy5EkTXgQ7YFJVV1xRxagjj4XzpigTR21u1jyRZxWJweNr9mliKahxbSHt4bqsATQZZdLINGmSVQi3DZqwQrkD2690vLo0CQVz2dw+ci8/rf5prQOnOrLvEC9dTeegK/HKWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by DB9P195MB1825.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:39c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 13:08:56 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 13:08:56 +0000
Message-ID: <6be0723f-a662-4d84-bdf6-ed142fa4f43b@phytec.de>
Date: Tue, 17 Nov 2026 15:08:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] fdt_support: Add /chosen/bootsource fixup
To: Quentin Schulz <quentin.schulz@cherry.de>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sjg@chromium.org
Cc: kever.yang@rock-chips.com, anshuld@ti.com, aristo.chen@canonical.com,
 alchark@flipper.net, u-boot@lists.u-boot-project.org,
 upstream@lists.phytec.de
References: <20261014143328.3135006-1-w.egorov@phytec.de>
 <20261014143328.3135006-2-w.egorov@phytec.de>
 <cba6b6a3-2e61-4bf0-af99-6429f9da3350@cherry.de>
From: Wadim Egorov <w.egorov@phytec.de>
Content-Language: en-US
In-Reply-To: <cba6b6a3-2e61-4bf0-af99-6429f9da3350@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR1PEPF000077EB.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::449) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|DB9P195MB1825:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b71aa26-b5d5-4393-50e4-08df44abef92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10070799003|18002099003|22082099003|261009223027099003|11063799006|56012099006|10067099003|4143699003|261102123227099003|261026121527099003|261022115727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: UkTDaUJF7amtUzQS4TMVLsJAqaWX6lJdsw8lbfYZ+F1KfX/zzqhPdti1IFeQJXWfG8OTcfepxvbvsNxe2jVJLWts0lY+J2G6ME5FU1W4RnhwQvXY3Jb4GJfl4Vz6Q74pdZiZ/7Qhq6IzsY+nQxUhzjSQ+/VQPJpaNX+/fPuoiFnxU7MJMLIFl7LLYuRTTB/PksMx75l9Eg32aJUj5dkfBXlGXBNv2/hpKaA39CLOzaAV8k9rbtpfYwzK7e9rtGSFhc2+hiRq+MhO/8KrtQjpvIHk0A4cx9Y5MXLGTJi8r6WLTcHcMUxrJDz5oHNeyeopTVWAYhu0gNdhxYCpDlogJPAItTZia9oTXn5aKTzPjE3NVUdY5Lx60TJAyvWGEcp6YUYIYYTCRoQtDZA6Nw04P0V5JioJwwXED8gAbh83d6wHOfmmcDYZxk+Vqspb0QZAvywUMHkf3ucIYIZrIzJGgmunxgJsdiaKmec5QwHBlMsWaBtvEtyowrup8oNiZRZ9vAxrqTiBzv8gewWeRLIKWrfsAO/ko0xS2i2frcn7k1YeDqdvoEDzYH5tVyS5H66pqKAmXVmMkPjCGmbodTHimOj/sjAwJ0TfiWDh2o34u/4+NI808r1BIJfOzUmy+CD7Z8cPixmbwa4oaAhRfOHSJ+2yb5/uwHjfMPrWbRFcW88=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10070799003)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261026121527099003)(261022115727099003)(261021121427099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzA3Q3E2MGJ0R0ZkTDF5NFNLdmNJMWNFSnNuc1JLSllKaGJNYmZoOGw0VXVU?=
 =?utf-8?B?dkU3VWNSUVc2M0NQQ3RIRlcwU0J5bXRCOWh6YytzSUVKUFRSYVJGZUJzNFFK?=
 =?utf-8?B?WlBKK2N6ZDQ0MzFpS1ozZDU4VFE4cW44K28vbUxNdHdPNXExQXI1ZGE4TDBu?=
 =?utf-8?B?akRNSDhnZDZnZ2tvUjR1Wkw1RVlPekRIaHc2YkRRKy9oSEtXeS9CZy9yN3Jr?=
 =?utf-8?B?OHFPdHIrb2pKbzRFY2xyTjhQS1Z6K1Y2dzRzWlNHQjdERFJKYjZ0VklLeFFJ?=
 =?utf-8?B?TjFwTE9UdktMOEpUV2Z1Ti9ZWnBRM2JSa1FPRjVsRHB2MFN3M2JFcVdlNE9H?=
 =?utf-8?B?SldWbFNGdC83bDdTeVpMY1ZqTDN6WXdwMkc4Vi85QW1ISmdNc1Y3WC8zMlZ3?=
 =?utf-8?B?M3JXODAzdEczMTZJMm51enlZWlQrdTYyODlONEJVdVUrUmRrSS9CR2hNdFFT?=
 =?utf-8?B?ZG9mTmg1TVVnZVBKdFBnSlROSVgyd3BmQ3YyQ3VJc1ArRU43ZDU1ajA1b1VP?=
 =?utf-8?B?RUtVSy92QW9XZ2o1Q1R1UkZtZjF0eE9GV01Sb1RhSGc2WURzdjlLZk5jdWdH?=
 =?utf-8?B?cklVUy9YOUVUOU1uQUhiekRSanFoSHRkcVp3d0szenEwTU1zem9jdmxiS25Q?=
 =?utf-8?B?TC9UY3Z3WFJZNHRSeHNCanJPaTM2aHdqOWlGOEZxZ0RyWU1vWjFiWlVGSFZp?=
 =?utf-8?B?NS9RN2h6RmxVSWZFbE8zbnE3ZzIrVU14TERIUjhHR1RqenFUNWNGa2ZRemxF?=
 =?utf-8?B?RVBNQTZHQ0ErMzFhYXNPSXo0MjFZazVURHVkQmdYY2pTblh6UWR3ZXVPWmJQ?=
 =?utf-8?B?eGFSZDI3N0dWNWpHMmtGY2dBTGFvY1lUMklUU1Z3bVVDLzY2S3REZW1zWVVo?=
 =?utf-8?B?S3JMZm5VL2p2N1JRcDQ1WFVMN3hQMXdnYSt6djRESDdJaGNsLzdBUjdwSFpK?=
 =?utf-8?B?OW9uMlUyQUx0d0hKUWNvdTA5ekh6Vm05TDY1ZlM1U3pWM2UwRWk0Y1NKSW11?=
 =?utf-8?B?dFYxbVdWVXlLOVdNT0RRRDR2NFVvR3NkWERhMkhvK1VhVWpkUHdMT0F1UWlY?=
 =?utf-8?B?dVJIMVNJMm11dWhGMG9CYmUvenNmZ1lCOHlSaGl6OXl2dUN0Z2RENkZ3MzFu?=
 =?utf-8?B?Mnl6T2gwK1VkbkxOOUx4YU5QWEZtdkM2ZTlJT3g3eGdJK0hqZ1FyUVN5cGZF?=
 =?utf-8?B?UGUxelBZTllDc0pRK1VIMGdyN2lHNUUyS2R2Z1FWTUJ1Ui94S2V5TjJudXp2?=
 =?utf-8?B?VkFEV1Vwek9TRjZVTUhKeWIrY0NMY3JIeTBjaWg2akh2aDA1R0hjVGlLa0Vp?=
 =?utf-8?B?aEhQRmplR3JnaXNhUnRZa01jVTBqb3JxalFQRzFPQ0hNQmsxNHJIM1V3WTd5?=
 =?utf-8?B?aFBMY0lxKzJtY2pvUHpNVUtDcnZ1a2tpMXFmN2pYeE1EcXh3YWhucGZSdmta?=
 =?utf-8?B?U2JMK1pNRDR2ZFhxL3FDSFlqQUJZUGVRcnlLc3dsbkFYWGg4Q084UThEZVJD?=
 =?utf-8?B?ay9XVElUUHgwMlJETVhxVFVPbGY1NStsUkw3RjdqVFVBMkhJYVlVeExmV0t3?=
 =?utf-8?B?NkhFVWV3ckErLzlSWWpRbWtXYnBLYXBveDNCZzFscEp0T3ltc2cvcktTNHdw?=
 =?utf-8?B?MlFtbDFBYXdaWW1DWUNKYlNQa3RhZi94K3FHaVcvM2tCbGRSMFZEUkwxZG1S?=
 =?utf-8?B?M1FSTWVmUXkvbStXelFYSmdkUFQ4Mm83RG8yaURySVpsdlZpa1pKWjlmSU1Y?=
 =?utf-8?B?UjRYamUwVCtpZTJZaWcrQ1UySjdSTXJpbU1ZaTEvL1p5REUwRE1uVlY4R3dR?=
 =?utf-8?B?K25iOGVncU5Bdlp6YUhSSDdENC9UcGJvWkRFWkdBM1F2b2JaREVrUjFCRWUx?=
 =?utf-8?B?cWtDZVZVcHZQYnRoY095T0ZWUVkrTzRJOFdUZDZsQWRIMmhsbUY5Vjk2Sytl?=
 =?utf-8?B?MWRSaXQ2Nk1mRUxhYWpWVTBhSVVPV3J3UHJDcWxHSXp1L04zdnNSTkFLaUlj?=
 =?utf-8?B?NXI0Zm1lc1lrbW5jN1ZkbXJjTDNSdmpLOWZzOWo1S2grVWYxQWtNdVppV01C?=
 =?utf-8?B?VzhQd1lGQnVxNDUzcGhoaFk4TnBqemxrTDU5aFV2YTFOTW5UakhRb0F6c2Nu?=
 =?utf-8?B?SzJKRkRpOHBWUVA4MnpEdWNvdWVNWU0vSm1uYTNRc2pQbE5nZzNQVUZ3WWVq?=
 =?utf-8?B?N3RielozcmhQTTlBNFRiRk5wRlJTeWdYbTIwL3dMaHppelRGUkJlNFQzZ3Bq?=
 =?utf-8?B?RWxMQ05YZ1laT3dJdXFsQ0V1YnE1SFBXOW1YWUduc1BvWHUzbGtHZW12SSs5?=
 =?utf-8?B?UnVYOFJVYWRDVHpIcm1FaHFtL1JUeHVtRmxKb3FMZVhRTlhnanlJQ1lwOFRp?=
 =?utf-8?Q?2iBYXH3uP1u7Q2Wg2HWE54D9i3w78d3f3CN9JVUw+gf/0?=
X-MS-Exchange-AntiSpam-MessageData-1: ot8hSzDbKXEYPw==
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b71aa26-b5d5-4393-50e4-08df44abef92
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 13:08:56.0930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhCrTc5+7orv+MKOtNiyChWNqGdAqTZBJRRYgzLgUyx02O1BHs+NEE6YOaxKYliXC4f4pyVS+LrW5ZKeWb0ZAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1825
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



On 11/9/26 6:35 PM, Quentin Schulz wrote:
> Hi Wadim,
> 
> On 10/14/26 4:33 PM, Wadim Egorov wrote:
>> Set /chosen/bootsource to the node of the device the BootROM booted
>> from. Platforms provide the path via bootsource_get_ofpath(). By
>> default we pass on what a previous boot stage has set in the control
>> device tree. The property is only set if the device tree has a node
>> at that path.
>>
>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>> ---
>>   boot/fdt_support.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   include/fdt_support.h | 26 ++++++++++++++++++++++++++
>>   2 files changed, 68 insertions(+)
>>
>> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
>> index 2941df55996..0d04d6f7e9a 100644
>> --- a/boot/fdt_support.c
>> +++ b/boot/fdt_support.c
>> @@ -334,6 +334,46 @@ __weak const char *board_fdt_chosen_bootargs(const struct fdt_property *fdt_ba)
>>       return env_get("bootargs");
>>   }
>>   +/*
>> + * By default pass on what a previous boot stage recorded in the control
>> + * device tree of this stage.
>> + */
>> +__weak const char *bootsource_get_ofpath(void)
>> +{
>> +    if (CONFIG_IS_ENABLED(OF_REAL))
>> +        return ofnode_read_chosen_string("bootsource");
>> +
>> +    return NULL;
>> +}
>> +
>> +int fdt_fixup_bootsource(void *fdt)
>> +{
>> +    const char *path;
>> +    int chosen, err;
>> +
>> +    path = bootsource_get_ofpath();
>> +    if (!path)
>> +        return 0;
>> +
>> +    /* Only record a path this tree has a node at, so it can be resolved */
>> +    if (fdt_path_offset(fdt, path) < 0) {
>> +        debug("%s: no node %s, not setting bootsource\n",
>> +              __func__, path);
>> +        return 0;
>> +    }
>> +
> 
> I'm wondering whether that's a good idea. SPL's DTB is a very stripped down version of proper's, so I could imagine setups in which you boot e.g. from USB via the BootROM but not have USB enabled in SPL and thus it's missing from the DTB.

Good point, I am dropping it in v3.

> 
>> +    chosen = fdt_find_or_add_subnode(fdt, 0, "chosen");
>> +    if (chosen < 0)
>> +        return chosen;
>> +
>> +    err = fdt_setprop_string(fdt, chosen, "bootsource", path);
>> +    if (err < 0)
>> +        printf("WARNING: could not set bootsource %s.\n",
>> +               fdt_strerror(err));
> 
> suggestion: switch to log_warning

Will do in v3

> 
> but i guess this matches what's currently in fdt_kaslrseed.
> 
> Cheers,
> Quentin


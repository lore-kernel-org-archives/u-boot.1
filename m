Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676CF606A328
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dvfJ2DmL;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=nYYgs33/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B02F260860;
	Thu,  5 Nov 2026 15:46:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mi1q3HrVnSjR; Thu,  5 Nov 2026 15:46:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B29106070C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793893589;
	b=jpoF5wvA/8CK+Dm5takCFmbCtalKNdLnCUHOYduhBV+2IbeAo3xaBH1vqu4r2jLLzO4i
	 1yF360FEJ8d48dPkiwdxg4HTufs9BLirFUdDfrRNNz3WIHHId0Y/W8J/jOkA3RhUS4Qgo
	 KtluU4fSP1FRoDkUqiJpuA2jsLrr2i9cV9sXCldQpvDsE8F4rvbBqfBPLANlfLa19NGLM
	 tbDii8A9NN3dliuYOzVybg67XlLMsSMAa0tkQmJkmSkizfDrY5zdlS07dI2x9wvaHZhs1
	 MK3ASfr1x2LZ71xrAx646DyN2iSVxEuA3w0ZEUZWqFg6HCyFTnjdcwjb/274DylC/BQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793893589;
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
	bh=k3jaUJMfjBYl20oSOZoVj7wgHcVbhc3oem1yuMCoAaw=;
	b=tStuMZW2Vka+r+dlzDd4k1+56hp6yvq42XPA64N6gqyEYwPFpEB8mH7sCX3qdkEukvap
	 niwfHbJ3a69o8koTnsaW47yM1Y2yb94J2UwRCpmp94HIgXXBBq153b+6Q5Tb5gouApk0c
	 jSD4q9nj9VwgM/AI4M7bFgxwKY3Wz/OVIESXJvWs3bxOpiH2uoZ+fC9NPtDdqBtAQHcE0
	 bDZG4rxDOEUmaCoWaQgZAPT3P7NeU14163j69im6PdQVS8S3jfzFZRL8Avy03/5PApIz+
	 AUcAjBxw3yGhG+7HoU9CC9WYcBm/rlMttSxnoCddUPa8Rhj2fid68ai3/wz6Bf+kB+w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b="nYYgs33/";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793893589;
	bh=k3jaUJMfjBYl20oSOZoVj7wgHcVbhc3oem1yuMCoAaw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dvfJ2DmLK+/UO6YoQMeJZU188M0N0u44ArzjouEm2zG8g81INzydEiTIEKa2+GBQT
	 BOR99lP6wrSEpKQkJxTj55EbyhC/DS0scqfZpW+KcwORkWztiMQCIj9T6ExMzl6ayL
	 c4s+P+2ptxBY7X4nEfG3iBi5YJBmZi64HyYvq/35xiCwgHqSPXlyFCt9BWfWw71RDn
	 odHdHKEkNB331KikjfTcWJBUp1mqN3c9WgQAN1fohy0LVmnHRtjYl5p04zt/tUZOTn
	 rij2mvxr5l49yU/+I07ljPermAzXjNnD+oETiuyoS6q0NYzBUGp5zjiC7il/qRx/0T
	 GqLlNj5s/FYtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B29106070C;
	Thu,  5 Nov 2026 15:46:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 06D8BB00
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 15:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 044C86070C
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 15:46:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pWIouKvjxF6a for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 15:46:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2B86D606A7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=nYYgs33/
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B86D606A7
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 15:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3jaUJMfjBYl20oSOZoVj7wgHcVbhc3oem1yuMCoAaw=;
 b=nYYgs33/eRclImYQ8egToRHA6HDQG0AQKp4vvj0xettwQf6Skj5DqZOeYpyHiy4bMx8S69ofAN+bOEu92S1KU2PkL/KJe2pPzmLY9IbxJlaUXKiShzjd7uuXv+/DyA5HnKxJ8g8h4d7uWIdVXSSIeA6TvxxU1SM34/O9dhWQPUk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GVXPR04MB10802.eurprd04.prod.outlook.com (2603:10a6:150:220::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:46:19 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 15:46:18 +0000
Message-ID: <fc54cf9e-e56f-427b-b390-fbb2c9ea5c1c@cherry.de>
Date: Thu, 5 Nov 2026 16:46:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: develop/sending_patches: add tips for series
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, E Shattow <e@freeshell.de>
References: <20261104-doc-sending-patches-v2-1-c0a90ff6c049@linaro.org>
 <76240a0d-96ed-4a8b-9336-8cc96c6e6e4f@cherry.de>
 <auyTzNmT63e_mEWO@maple.netwinder.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <auyTzNmT63e_mEWO@maple.netwinder.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0054.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ca::8) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GVXPR04MB10802:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f97e507-1d9d-4f1a-a4b5-08df3b53ee85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|10067099003|3023799007|56012099006|4143699003|11063799006|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261022105027099003|261021135927099003|261102123227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: DhmIRIuCDErSP4foK0YYRnnyfSanKLWWZN4wxlbAvzKnlifiImeQJL6GZxNTakSCn4H5JYb7vlqkRU0tTab84WvCnIHfOXrawaj3h46+iHJQ0Kar6z5qQprRuLCfqTOQ0ilDZ/bm2OnDMLJap92EX0UeW9LCDyatNU2Zz8AIDth90ZblGc2lLqPSmFQVQ77r5m0XcorjXMdCuntL2pCo8DlRyaDO78xwE+HNd8M3hrsOdr8qUzJbmaE7haGeIGOnrEBeZgvuR40GRikm2sIOQMKMIzd/bFQ/G0JCMEqKd264G5omfKu6f8nyCkO4PgQsB7XLo33CujnLa5bZ4dc1kBzZ4rpPH042vV60q+H3NzOkFFjoW9ghK+c58+UcDPJb1qrQCXnUNIFzipBJ5C7yhVa/hYV6OTrMbvZdwcD+J7P1hkttzQkbm0GKTYv6dWhlEnO3BvrWVpJ4ouGvit1Pnt1DQ8WdFLP+pjYFRuO2OYRisbYMWg16rYowuF3oG3Jey4qx46nwqc+hMtRGCmxX8i6FyOCI7B6ZJ7Mal6HBBezYQ4j8V5OIXNTw+l0g1d5fWpvzSL8nvvzL9Afj8ceOsmALIuel6CzOL/f+KlR/7coZetGZTFu1qz2oQX0W2QV77jnIoRDC9pldSC3+fe4rw9ryHNDzhKq2/55slpi+LoE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(3023799007)(56012099006)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021135927099003)(261102123227099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUsyTDV3cDhTTThTOTNybHBCblhOTjVBaVg2bVNVWnVGL2t6bDM1dmFZLy9H?=
 =?utf-8?B?QlJ4bHJuWHBleHd5bGd4QmgrNHJUMTFnUDF5bjROYVJiaTNucm5ka0cwcE5n?=
 =?utf-8?B?TnN1blQvbGhWMEcyWjA5R2VlQWVCSGlkRnd2VlRWSDlhV3BKeTVBWUN0USsx?=
 =?utf-8?B?Mm03NVhkakZlemFNaUlCOG9JWFlFRmIrUGtubWt5V0FkMW9jT3RmWkZTVWJT?=
 =?utf-8?B?QXIrellpOGx0UVo4N2dLQlVub2pmU0Z3b0ZFRTZSemdKNGxKUGhkcTc2UWVB?=
 =?utf-8?B?UlNqVExHNW9UZDVBaW0vTmEzOVkxajhwdk1OdEJOZGttSG1NcUZaRUc1M25U?=
 =?utf-8?B?WjZjQWtUMTVuVzc0Qks0R3ZRalhGYWF2ZUxvcU02Q0tMT3FIVlBOcUhscHpY?=
 =?utf-8?B?MkFGc3NQMUsyZ0FYV0RxNEF6MWRTY0UrVURyeXlBNjZVTGtDby9ZV2d3eFVB?=
 =?utf-8?B?ZjJzMFVNQnZmVVJmaGs2VTh6eVlJVTlIdGQzb1JSL0xRR3B3anQxaWI5MUNp?=
 =?utf-8?B?d05BM05tQ0tSR1RhMU8yeXhPQkk3U1VFZWJEQ2wzQ0pmM2JpYTZyOTgzbllJ?=
 =?utf-8?B?NU5QYzR6ZjJESURVTmlWeVQwTmd3M2ovVzlVa0t1elBsdzduZ211dDVoRkVT?=
 =?utf-8?B?Nk56QkZ3TXhhOExmcDZTUW5yUUdYS1ppYmYvWkVWOTFGVkZmWktGSlBvREZC?=
 =?utf-8?B?NUxpV0pyaVRYdGgvdzNUZW5OQzBKY1NGTkoyd0JDTk1nOHMweUFHVkRMWWJz?=
 =?utf-8?B?ZzVOSDY2NTBET3Rkb3B0dURMc0NYK0h3Ym9aZGlhYlFMOUZoK3ZuY3VTY0tu?=
 =?utf-8?B?UGI5NE5GcnJsWWhQNUVjL0FYTm1ua0taeGZJSFh2My8rZFAvV1cvTEFodGRa?=
 =?utf-8?B?dE82UkFmelZPR3FxZGJGdHhFeHNWQXhPcXFPcHAvUmhtdHJrbDFqblp2SlJE?=
 =?utf-8?B?dFNRZ01jQ3NmVHV4UzFVdmVXOFZOVGNHcVdMeWoyL2o4RnJVZG52TFRnbXlH?=
 =?utf-8?B?cDJONnRUeCs4Nzc2QitJdC84dUFodVRrZUNqTldjaTI5N0hDTU5za2QzNE85?=
 =?utf-8?B?SkZYb0ZsL3prRlBaaWJ1aWVRY2x1Smc4ckdTclR4bHFyQ1BuSWdJTWV6dXRs?=
 =?utf-8?B?eEtrMisxYTA0Z2doY1VQNWZ4M0dTbTk0d1BuNkUyZnpmdmVEaFJkSzZpaHE3?=
 =?utf-8?B?cTQ4UnpRTndUYjZhMUNJWXNsTWE5SVk4OTZBalRtSENuUWFkU3ZpMW9YTHI4?=
 =?utf-8?B?eGN5TjhNeldNa1lHQkkxcDEwdE5oZnQyU2F2N2VobktPeVJud3pMSzFvUVY5?=
 =?utf-8?B?Q0RiMTNPRFE4dEluMFZOS1lQaUhheHVpS2JrWVRwV01vTzRDTVorRGN2ZXJR?=
 =?utf-8?B?MU9acVRmczZ5eGJaSHdBK3BOeHgxQnhXdkhjR3ZRRmI0UTg4OTZtaUZHS2FF?=
 =?utf-8?B?NWpiQmt1QnIyUnNjUllkN25tVC9Ia0tsMEJUT3FHNm1neStndy9nb0YwaVpr?=
 =?utf-8?B?K0J1UVV0RHhWbS9ZMmpuRWRSc08vbEVsZUlFRXk0R0JWSWx0MEhVVDZ2aU1o?=
 =?utf-8?B?bTFOOWpPRUFydzdKMlBpN0RydUVDblVYMVZsTGxsZnBEZk1iWXlSSW51ZUNV?=
 =?utf-8?B?RTVra1BaTExXSU5xelZCVjlFamZtQXR4UFFTYXpGem5lSHNuRE1VTUwwZzMr?=
 =?utf-8?B?bS9QZkF2Vnc2dXo5eDVxSmhNbVk4b3BYMVBpUjJ5SGcrOGNVNitaWmhXMEQr?=
 =?utf-8?B?Q3o1bWdtS1ZWeHFzSFA3MDJWOGVPN0RVTndPSjN6RU5jOTBFWElwZHc0OVY3?=
 =?utf-8?B?NTh6MGsvdHo5cXBJcTJqTis2YlpHZVZIc3JWZW1zYjFyaUI1NTRVWjZzU2hJ?=
 =?utf-8?B?T25iRmZtcmNmb0xYZmhqZllHRnJMWnA2UjhKSWhpN2tLcjcvNjN2TDZqbUtF?=
 =?utf-8?B?SjRIMzlxRm9HOG42ZHBrNEp1Q1JYQmdPTGxTL2ZKN1pBQ2htalVlZGFkejRa?=
 =?utf-8?B?UHFvKzNUbWxpYmFlQm1SbWk0dWhwWHBTV3kxV2RpYm9YVmdndEhJMi9tT3lq?=
 =?utf-8?B?NFY0VFpXVlBSblI1U2lNdzNUdTYrSXIzOGJKZitiYVBwZ2FPQW9WVGZKTDc1?=
 =?utf-8?B?VmVYRWFjS0pCUXN2eG5vdGVTcGM0b1o1V3VwUGZFZi90MUMybENxc1FqbVpw?=
 =?utf-8?B?dk43RE1jU3hkZnZkajdkQ3l4UzV2UFRzR3Z6dCtxRHVCWFM2R0s4NWdBT3VR?=
 =?utf-8?B?R3lGSnl5QWl0N0pNNG16YnJ2Si9iendodFlIUEVnZ1U3ejA5bUVKY1NQL0J3?=
 =?utf-8?B?RWE5ODdYcm9Ebml4cWZzTVVVSEs0SWg3WXlrbUlpTHNPS0xvT0xmUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f97e507-1d9d-4f1a-a4b5-08df3b53ee85
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:46:18.1115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBTvrDw0ukDQI45pfGMJMlCvwC07J3I+FmnwkRGkwDymqdvg15dWxHgk5Zu3rFF4dXqrdqmzctLYZ5S4oM1BHo7MWA+VmlxSk+kpx1xBsBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10802
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ralph,

On 11/5/26 3:33 PM, Ralph Siemsen wrote:
> On Thu, Nov 05, 2026 at 12:00:27PM +0100, Quentin Schulz wrote:
>>
>> On 11/4/26 8:48 PM, Ralph Siemsen wrote:
>>> +Of course there are sometimes cases where a large patch series is okay:
>>> +
>>> +* when the changes are all in a specific area: for example when 
>>> fixing a bug
>>> +  in a driver, but also doing some refactoring or cleanup in the 
>>> same code
>>
>> issue: This is typically the things we don't want to see I believe. 
>> Separate bugs from refactoring, cleanup, and new features. The 
>> argument is: we want the bug to be fixed as soon as possible, but we 
>> *reaaaaally* like to merge full series at once, so having this kind of 
>> changes mixed in a series means it's likely we'll either ask the 
>> contributor to split the series, or if the non-bug-fixing part of the 
>> series is controversial or not in a good state yet, unnecessarily 
>> postpone the merging of the bug fix.
> 
> Maybe I should have said: "*directly related* refactoring or cleanup"?
> 
> Ideally a bug fix should be its own patch, and certainly it should not 
> include any new features. But sometimes a bit of refactor/cleanup helps 
> to make a bug fix easier to implement and/or understand.
> 

Sometimes it's tempting to squeeze some refactoring that isn't actually 
necessary. I'm sure there are exceptions, but the more there is in 
context for a bug fix to be merged, the longer it'll take for the bug to 
be fixed, that's unfortunately the reality. We can strongly 
encourage/discourage people to do something, but there are of course 
always exceptions. Best judgment applies, but everybody has a different 
one and it gets trained over time :)

Something along the lines of "In the event a refactoring drastically 
simplifies bug fixing, it may be part of the same series, but it should 
be understood that this means the review will likely take much longer 
than if it was the bug fix alone in the series".

>>> +* when there are unavoidable dependencies between patches: keeping them
>>> +  together avoids having to explain how multiple series are dependent
>>
>> thought: People usually struggle to detect the *actual* dependencies 
>> and are usually leaning too much on "I need those two drivers to be 
>> merged for the board to work" for example. We've seen this more 
>> recently with a full SoC bring-up being sent as one series. Yes, the 
>> SoC is unusable without all the minimally required drivers, but each 
>> individual driver can and should be sent a separate series. I'm not 
>> sure how we can word this better, maybe providing a real-life example 
>> would be nice. This can always be improved later on, so not a blocker.
> 
> Having struggled with this myself, while I do agree with the idea of 
> using separate series, it does complicate the development process. It 
> means a branch for each series, and merging them together for each 
> compile/test cycle. Only after doing this dozens of times did I realize 
> that I could stack the branches on top of each other rather than merging 
> each time. Then "git history fixup" and "git history reword" made it 
> much easier to modify the stack. But all of this has to be learned and 
> it is not immediately obvious.
> 

There needs to be a compromise between friction for the contributor and 
friction for the maintainer/reviewer. Unfortunately, the balance is 
already so skewed in Open Source Software in general that more friction 
for the individual contributor than the reviewer is currently necessary 
for the maintainers/reviewers to barely avoid burning out. I 
unfortunately do not have an answer other than "we know this isn't super 
nice, but this is what we could come up with that makes merging your 
patches more likely and faster with the resources we have today".

> I also agree that it is hard to detect the actual dependencies. And in 
> fact they are not static: when a reviewer of one series requests 
> changes, it can often impact other series. Which suggests that there is 
> a dependency, even if it was not apparent initially.
> 

At some point, there's also "don't send too many series at once". If 
your series A requires big changes in series B, it either means it 
should be series A+B, or that series B was sent too early and we should 
focus on answering design questions in series A before having a look at 
series B. Sometimes patience pays off in the long run.

>> With the issue in the previous paragraph fixed, I think this is a good 
>> improvement and we should merge as soon as possible.
> 
> Perhaps I should just drop the whole "Of course there are sometimes 
> cases where a large patch series..." section?
> 

I like the second bullet point. It also gives a way out to people: we 
aren't super strict and sometimes we're fine with a series with 
"different subsystems but somewhat related". I prefer the patches to 
exist even if we don't review them quick than having the contributor 
agonize over what it is we exactly want. We can always tell them once 
their series is sent how we would have liked it to be formatted. This is 
something I've learned over the years by doing, the same with learning 
how to do bisectable changes, fine-grained commits and write commit logs 
that are (I hope) helpful to reviewers. I believe Tom's position in 
general is to leave enough wiggle room so people can figure out how 
things work best for them (e.g. we don't have super strict rules for 
custodians or merging, unlike the kernel for example).

Cheers,
Quentin

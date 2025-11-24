Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9290CFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 15:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5892183E20;
	Mon, 24 Nov 2025 16:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="La7dwXm2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9330583B85; Mon, 24 Nov 2025 16:02:16 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A301F83E23
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 16:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0tBVyaG39rWsLH886BkOjtjaM0W2WCL2Ox/FIt2Rark/9gL4St+5NGmq8C58Fc729ht0oQhVQU621vd8Krvfpj92SLMJ27ZWMhOavHj+XGImzR1tdd++NcY9VAz77Ir5Hm/GYYParn++IIiAm+R0U/3LfNST4dNnul1vuYkF5kRAyVIMkcdxHvG95hkMgiIhy50WF3U+CJgWti21x+4SXlIjB72oXSZrj8X9dubkTaIOpr28v7u7s8Vd76dIZe02JojYx8JovVPDKgzZIpf1Nk3XXx4r+NpOyfYnyqIArqZvtqVYI6+LysBmgg57tbDvw7tqdoFdkNXgK0X5H141w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2Fx9q98UwV8gyJUwXIV8BgO7+o71kCgA55qFl5eBVQ=;
 b=KFg9O5xS4Rco+0Z2i0VYdMee2sFXPjQRj1j6aTsslYKyBSqTC5ETQi03P8YSjnZNgd1pvhN0lABU/7Yk5HesHer2Ni24J3dCrMV8yb9yLiyepIx/XqG/ZIIk327n74gzNn6WbpM42FI15JK0jX1JwGllJb6wKEZYkZ9HloS3zcNdMvxorvVucZEt3OgcKtSyq6Kyifij9UmzbFhwTzmevadwf8hPzbE0orGkKqe1Gp4UQfYjt+YZA+z0TCOtLY9Q7RclOfmW8lE3jXXzAmJMBL5OrRJOFSm8p6zQgOOOm2nXI7wwOwXTXuaQQjAWf/fMJllYvEBUDe1hOR62MV+IGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2Fx9q98UwV8gyJUwXIV8BgO7+o71kCgA55qFl5eBVQ=;
 b=La7dwXm2banmDQZawdP2xQ3BMDM0ZDo4q9voHLK2eGeBusKG3JGj5Izx2yOm77NgsXC6npjLBwmL4zuBWT+0SdxSjblgvc2N+k4Ti6CLMAG/JNuVjAU6HjXhzLzNXNDboo96Jt+q+ykBvFuV9cOMni1cF9DLd2NGYD72ptQwsiWT/101IcGc79lU2WCgAiztCm7GGN3Qqs1C47T6BX5dl7ryJAXch+N7uU9O+9G/ir3Noqfq3kwteOK/iur6FDXXwUjBe5XEny5YQaect/wSkG4uLzUj+tKjT02p6zs0IMHSrpn3S1DWtbTs4au+soyCDOMQJoKGL09LeQd0lZiOdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6794.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5bc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 24 Nov
 2025 15:02:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 15:02:10 +0000
Message-ID: <e2557c4f-19b8-45b9-b956-a8131271c7a6@siemens.com>
Date: Mon, 24 Nov 2025 16:02:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Altera SoCFpga Boot Stall Fix
To: "Chee, Tien Fong" <tienfong.chee@altera.com>, Tom Rini <trini@konsulko.com>
Cc: Sune Brian <briansune@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
References: <20251020133455.1870-1-briansune@gmail.com>
 <adaf5081-3b9b-4cdc-b7d3-ec9756f60ead@altera.com>
 <CAN7C2SDVD+bpF=CGDPXDqLE3U9cMm2YqxnwXScvxiFh3OypP=A@mail.gmail.com>
 <009323c1-98b3-490a-912a-35249efbfd9d@altera.com>
 <CAN7C2SBU1xozPwfRG_tdcqos4jDZRm-qzXR5MEVTG7jXebp_7Q@mail.gmail.com>
 <20251114173535.GD6688@bill-the-cat>
 <9cc70ebc-2391-407c-97c0-78c687dc7915@altera.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <9cc70ebc-2391-407c-97c0-78c687dc7915@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 97104dda-4bc7-4e9a-0477-08de2b6a7130
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZStyZjBGVnQ3U3V4eXRYaHo0Y2pQWDNjZ3dyaWJkV3JHdnlRMGFzSnVNUTdG?=
 =?utf-8?B?TmFaUzIxSzFsdVI1aGtLczlRNXJzWHBGTW1JNm9Nc1lFYlkweXQ2ZmVJd0I5?=
 =?utf-8?B?T3d4VkFKRFM0OHZ6S2hBdmtNaXVad3BVeVB5enZPUDhqYXlLcW4zRXlxdW43?=
 =?utf-8?B?NXZJSzJtL1NMM3Z2eCtlUjlJYnpNeFhXMCtkMGh2OVNpdkJyTjJ2MWJucHlx?=
 =?utf-8?B?Z2Z6SWg4SU84OHNkK0VCT1FLTnpNNkY3SWhwQzlmbUNMYnZQS2hOd3pZQmRp?=
 =?utf-8?B?ek56RUo1RlFycUROM0xUY3pKYzlDUEdwOVR4emdRYkdIMm5aeTliREYrckwy?=
 =?utf-8?B?UDZJeUhCd0hSSlY5a0lSQnBjeVRSM3gvK2RYODM4ZzNnVTFEVUdRSmlSZVNo?=
 =?utf-8?B?RjhCeThGam9qUFRPSzhEKzg1eSs3cVYzUU0wTDUzMVMxZWN2eXFXUVEvUlRX?=
 =?utf-8?B?citJdnRkMjJJOGJyZWREcnl3cHYvZ0o5aGZsRXNHK0YyeUtqTjM4eXprc2F6?=
 =?utf-8?B?cUNTcDdUZlBPM3pRRExtRzRLVEZBY2dhaWpHZDUwYmRQTEd6TWE3Q0RRemJj?=
 =?utf-8?B?L0lSQ05zenVhUGpRcnA4RFNwWFdsd3gvNGxYUjdZTlMyc0FzV2dOTW9vNWIx?=
 =?utf-8?B?NG0yQ1dodU1oWjZWQ2FDa3FDeWVkRlJ0Z1NUZDdicVhIQk9iMmtEVDg1ZUY0?=
 =?utf-8?B?T3hwS0twNHliSXlwWkpmcThudjRuVkZWN0x1SjU3bzhUNVNJaE1tY2VCdlZL?=
 =?utf-8?B?alN3QVROVmpuODA5RHBFbDdITHN6dzBma2I2a1ZhUk80Zy9zeGtGdUJobE9I?=
 =?utf-8?B?TnV6L00vOUxhNnlCcWRkMkhlcU0waExPd2JndEZ4S3NydjdYeTd5Y3VUU1FT?=
 =?utf-8?B?UWJiUFI5aXN1Ui94ZkZLRnZsaFpCSnlvR1c2S2VCaHYyMUs4VjdSR1ZYUFhw?=
 =?utf-8?B?Ui9lWmZsaU04VXdYUTRLckJyWUFtdWd3MUZMVUthZVZ2dTUwbXhxcEJUMit6?=
 =?utf-8?B?bXF0N1NwVjhrcHpjT1pibkF6NjZ4ZDFJdjI4OVB5VmZDTXJITEFrN2ZNT2hL?=
 =?utf-8?B?OW92TVUzaXpWWmtzNThld0cwc1hvd3k4dXlSK0J6NXVIblVYdzZ1THEvd1FI?=
 =?utf-8?B?S3l4V3F3SXY1VmdPTktnYlRxWFRGcDVldG8yeXRuTVRmSVR5KzF3ckJWNVF6?=
 =?utf-8?B?VVlMeGxqZ2gzK0p2V21Vc2pXa0ZTQWowZndHN1J3VmIvZkV5QnUzMGdVQ3lq?=
 =?utf-8?B?WkIydEtzT1oyRWxScWNKemxjV01FdE5hKzd2Q2NEb0IyM2RmRk85ZGRvUnkx?=
 =?utf-8?B?R0kzTlpCUTBrcUg5R3M3M2wyYWZsQlp3YjN4alpJcUpsMTU1QmErRzNjS1Ux?=
 =?utf-8?B?ZThMMUpjT1czT1dCbU1QbjZDWTRlL0dmRE9rK2tCdTRWYndxcTMrOVZlYmNa?=
 =?utf-8?B?Ym1kQk1lbTAweHkrd0tyMUwvaXQ3RkJpVFJ1T2txQSt0dVZiQVZkYjlxVndZ?=
 =?utf-8?B?dWVIMUtUSmtCWUV3TVdrZG81VjZqYnM1MDdVNHkxWXlMbjZhVUpybDVYa2Zy?=
 =?utf-8?B?dDZCUVZwcmVLSW8zdWhmTFR0Z2NhTG5MTE1MQW1nV3IwZS9Ubm1qeHZxZ3dj?=
 =?utf-8?B?clBTMWoyVGpzSCs2Q1Y5Nng0U2ZJZ3V1TVJJN3I4dmVoaXl2L2hYQjh4Rlc1?=
 =?utf-8?B?cDlwYlB3elN1RXl6WEtxM1lKTHNrNkp0cW5rRzl5MjRyVlg0VVB3SzZRTnZu?=
 =?utf-8?B?eFRBTlBCUnZnc2Ewa3ppMlJONFdKa3VldFdlaU9EWTV0YTljL3RkSS81WFJM?=
 =?utf-8?B?bVlWRFNnL1RRYVVnQ2dGbGZCOFVUWUJmTHp1Y3hiM0V6WnA5d1FSRGR0V2p6?=
 =?utf-8?B?VlJ6R1k0U0Y5UGtTaTIrZFFDQlJhTTlEWTFya1RHdjloUmwyNi9LSUNveVZ6?=
 =?utf-8?B?aDNZbzROYkVyam53d1AzbFAwa24zQlFGeThXeWdzT0dJeTBZbG9ZSlc1dU5q?=
 =?utf-8?B?ZDBUODhXZ2tnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDNHL3NSbjhMUTlkTnQxTzZVLzhvUU5rNm5NcndtQlMzcjNDV3duc1pxUEV4?=
 =?utf-8?B?c2tDWGJleTJncmVMTER3ZUUzRkE0dGxYanpOamhuS2FLUnN2NUdHMUVIR3pV?=
 =?utf-8?B?Ymh4RkxjcFJRYkI3ODUrSmo4RnRPUFZqcHlzbDlMNk9TM1k2Z1d4TC9TRnZN?=
 =?utf-8?B?WXRnSHJVQXF2MmZIWVEwM1FmZEpaS2YwazQvZlFBR280MzJzeHFXRlF5REJO?=
 =?utf-8?B?Z1AzdU8yZE4rLzFrMHh5Vk1TMU0xbFlJM0tGN2ZwTzVwWXlLdVVVcHQ4UnUy?=
 =?utf-8?B?Y0NKYnlRMmw2MzFNYlVGRjJac24xVmpncDZHc1FFdEVNSG9NaDN1NnpYR0to?=
 =?utf-8?B?T0JockFWOEl4U0h1L3k3QkVyRDZVR2hwOC90a3JUczVmWGhjRXE0aE9abEVl?=
 =?utf-8?B?ZjNyaHR1c2Q3QmZKdDhtcDB5TDJ1MzE2NTJaKzgxdVJ2NndwUlNXeExpUUNI?=
 =?utf-8?B?enBNVGdtN0pNdkFwaWdsdUJjNlRVQ1RpN0dHSk9xRnRQWm9aVksvRkErRlE2?=
 =?utf-8?B?NzliSGY5RGZKZS84R3VXSmFsZ2o0RzNPeGJUYW82NDlIaDRXcUM3U1BaWlow?=
 =?utf-8?B?MlpQcGRSUTAxTXV3YkUzdld6c1BaVUlKSTRzdVRpTDZRL1FNQ1B5V0pYNWp5?=
 =?utf-8?B?RmVlSFV6SmJOVUxraVNCMDQrY3NXV1pNQWtaRU55emVJcnBreGVwK2xWNjlW?=
 =?utf-8?B?dUVBNDZmWi9ORGFJVDFkNmZydWMzQXloTVJGdzJINW94anVoREJYb1ZkZlJV?=
 =?utf-8?B?MWM3bktuRGNwMEk2VWJLS2JDK2lIWCtrN3YwWXV2dWM1TzdyY3N5SVVyQU1B?=
 =?utf-8?B?RW9CUHBjSEZka1R6VUxhRG9xMmJyZzNHQU5NOWZPanEwV0hyWUZtQ2xFOGZ5?=
 =?utf-8?B?M2lROERGU3dmNlJFeEZOTG1KbmZoSStKNjBxWTBVZFExZkV2K1l5N1lmUXNn?=
 =?utf-8?B?ZlRId3VORXRsaEtlN3pMTXdEcWJtbmdZU0V3OFlYcnBFTFBSM2NwSWVUdHJj?=
 =?utf-8?B?dDFhM3BPaFdDVytqa3pEYjE2anc0L1M3UXJmNmRJb3hIWEZnSnhIWDcxeGJC?=
 =?utf-8?B?eTI3K0dVcjVnQXJJc3NiN0hnNTR1M1BOLzRhcWI5V0dYdTFEdkNGSEIvNzFN?=
 =?utf-8?B?NHNxUUtPTEhoaTFtS3VLQnFhOXdvdEpTTjRRYXRvN1FlN3o0S3NMZEhIbVlV?=
 =?utf-8?B?THZjYTM5My95ejJiMDcrNzgxR3FESHhRL21wWDAvOGxGakNIWjV5OXpLWm1X?=
 =?utf-8?B?dnlQK1U4dGFqcEs1b0tFaXZVNGhqak1ibUxnMXdLRXU1SUV6RHpoaEdrNExh?=
 =?utf-8?B?Q0ZVZU9XaUNtV3kyRlFnek9EaHQzTGhiTDRXTjh3TkVPbkpvdGJzazJHZVRp?=
 =?utf-8?B?bjhFSk1ON1BPY2JmWDVBdTJCcFVBcllYSmxkRlZMMklhdjhCWjFaVHUrUHNw?=
 =?utf-8?B?djAvQlJhMUpPc0tzMFNPNzBMemFldk1qS0JXTUhheGZZdGNDaWdjUFVqU0w2?=
 =?utf-8?B?SUt6ZkN1YXdha2lhL2psTUt6Ry9SMkVQVGhkdGhlRU5ES3ErMjFnanFSakpL?=
 =?utf-8?B?RnpxZ3NhTUNYK1RLWUYrUDU2S3JLWVlVYnpXVHpmYUJpTHRPbjJ0ZEJNOWJZ?=
 =?utf-8?B?bmlzRFN5TXkyRUJxN1JZR1lBdlliWkwvZHVOaDI0T2pIVEg4b0FKNkZ4NDl4?=
 =?utf-8?B?VERyOWFWM1VFODJ1b0NIQjlLNWExa3NEWm9TNE5KSHJ4YlBhb2dCZHhtM1Ay?=
 =?utf-8?B?dUNVelkzZERWc3FmUTA4U0V6bDZZRGVqUWFpbUdmRDQrU1lWMElwOUhTeitw?=
 =?utf-8?B?WUhrd1o5dTlsV0xTU3lMOTJzOC9oeDlxeVBxNGNwOURPRGdpaHA2MnQyRDNj?=
 =?utf-8?B?ZDd5K0NyQ1p3bVQvRVhMYXl0SFBwbXR5Z3E4Q05vOGFkaGtTZUphZVArZVdw?=
 =?utf-8?B?TlNKZ3NHNTVtemk4a2lDTGZaZnhKUm82Z0VlcFlTVkw3eHZCdkxvVHNRTS9O?=
 =?utf-8?B?WWlUS0RhZG1aUGhrMEIyR0szYStVakVQbjE2emwwZUFTNGN2bDRoU1VVaEhM?=
 =?utf-8?B?SWJxbzV5SmV1SC9ta2I3M1lrSStjdHY2TXhPcTF6YlRhc3k2T1pCK1F3NmVZ?=
 =?utf-8?B?TWV0QXpoNmQxZi9KSjFWM0I1YlhNajVDTFo5ZlRrNjJLUzdWbTNiMTFEOE5w?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97104dda-4bc7-4e9a-0477-08de2b6a7130
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 15:02:10.2007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+091hmvedtmYM0Nm1oWvmIZSEyWQgfBqx8TJSzkonjfWj5kwZI0IYSRvu/VIh7P6M81VziNDOHgaWSDRemJhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6794
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 17.11.25 08:44, Chee, Tien Fong wrote:
> Hi Tom,
> 
> On 15/11/2025 1:35 am, Tom Rini wrote:
>>>> like Cyclone V, and Arria 10. Our initial assumption was that users
>>>> would primarily use the Altera official release repo, where we have
>>>> been
>>>> gradually migrating platform devices to the driver model stage by
>>>> stage,
>>>> including clk driver used in MMC driver.
>>> Tom, with all respect. I don't see those previous patches really
>>> improved
>>> nor introduced a proper build environment for supported SoCFPGA series.
>>>
>>> Assumption is not considered as a proper way nor correct way to patch
>>> things.
>>> Simply removing critical code and breaking other SoCFPGA families is
>>> completely
>>> unacceptable.
>>>
>>> We are not talking about code improvement nor cleanup.
>>> What the previous patch actually did is simply remove old generation
>>> SoCFPGA
>>> codes and w/o coherently coexist old and new generations.
>> Something like this recently happened on the i.MX side of things, and it
>> was fixed because once the rest of the community found out, it was made
>> clear breaking / removing older used devices is not allowed.
>>
>> So, Tien, Altera in general, please do whatever is needed to restore
>> functionality to older devices that are still quite clearly being used
>> by both the community and your own customers. If more CI of older
>> targets is needed, get that going. Breaking older devices to support
>> newer devices is not appropriate.
> 
> 
> Understood, we will make sure older SoCFPGA platforms (Cyclone V and
> Arria 10) remain fully supported. We'll prepare patches to restore the
> missing functionality and ensure proper coexistence between legacy and
> new driver-model platforms.
> 
> We’ll also review our internal CI coverage for older devices to prevent
> similar regressions going forward.
> 
> Thanks for highlighting this, we’ll follow up with the fixes.
> 

Just discovered this somehow familiar thread, after having spent more 
than a day two weeks ago on the fallouts as well. My patches:

 - https://patchwork.ozlabs.org/project/uboot/patch/99585fee-dd5d-4f9f-aa88-0ee34fe02181@siemens.com/
 - https://patchwork.ozlabs.org/project/uboot/list/?series=482132

I'm all for finding the best technical solution in the end, but I wonder 
if we can at least come to an intermediate solution for the upcoming 
release so that folks do not need to carry too many extra patches in 
their pipelines (https://patchwork.kernel.org/project/cip-dev/patch/cf43e9da3cfc59771e801d3215d3b3794f3602a8.1763446144.git.jan.kiszka@siemens.com/)

Thanks a lot,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04805606B220
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=df6FcTzC;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=J5B4YvuZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D447F81603;
	Fri, 13 Nov 2026 18:04:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cHV46ANUosHF; Fri, 13 Nov 2026 18:04:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 32462816DD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794593047;
	b=RMW6nujWqS34KL0olceTSGoXS33207VCQ6towG/ZSsctoacg6Duy5qMtkvVYsbF6mqgG
	 6jNTmyKRyH5d21tHofDUQH6nCb9ZgQDX2qt3ohglLTQBxDngttwp363+82v87NHf55AXz
	 G6rsndmNQzjQXi/HwtnV1hYbICWm3Ayrb0Ghy214yJVjjLrTKGRbtbKzxlDMHhNsDf1jT
	 1cfAuisfU/jsYDzSlm2sAiqP452Y8+oRGJiyvVbyylt7NxVuUFPOV/qExCx5382HpKgfi
	 HX6ScBq37BaEKZlCdErx7ufzl5GQsfPIxdcYexNAmekQCzxTC0C6VK5JVKBnQcFH7rA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794593047;
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
	bh=szwaHsHdaNFUL/s8iN81aw8qo3y8hWXYpY+QBuU5bXg=;
	b=SO4fybGxeCAFgkoHVMVJvNkSQBIjxYz9hmSqgfSFg22dxwFNdhruuZrouBkKvCP4jNxC
	 TVUQI8yKHEWRAFhfswHjA2//8ysF64rZwQEF2sBCE5AtMV8ckM3OHaBb+akStk/2WRejS
	 IdUSbRytuwA/qndpbcz/ftvF2jrEvDilDcTpv96D0ni0ADupO4lqbKQqwDatEgJjIjYgZ
	 7UAAZ5zNWjg1AXifWEY1QMpTvNQtrwwJoBGFFkFBDvXjmhR1qrbPKk/DjJvFZsmccKgcg
	 UNbi+5gIDV0VcUj1WzJyR0mUW3eYmzb+byeaUa/seFkeeh8bLDBTQseEDMNxGP3H/TQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794593047;
	bh=szwaHsHdaNFUL/s8iN81aw8qo3y8hWXYpY+QBuU5bXg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=df6FcTzCZSiC4ZhFggnY8Q75MPDH5vcOv34M++31AZm8QaFThB8u9SYwxCcXDEft8
	 TwJc9F7DcpDF2/SCAlIbwzh+5YueV98fZUNXoSl0U/qcF67EuuXIHFlJTBTMG60iUn
	 MQ/VpqzhqPmNf630sDllExjsbKtVGOp7ziwY4sExOt/WC/Gd2Yf7BgcH6CCtmNi4xN
	 4Mu7/5T0WufeZtsW0fbJMy0gF8fMVYaD/QIcnRy6OYAHFLSBD4jSO278VGslyejdrc
	 hHC0hD6Ssw1yJHqw5wY600mgQv/vRwTefkGdXAr+dpEd2wnVNjNgORK1JNH1H9/Qv8
	 vMdgHboEMyAug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32462816DD;
	Fri, 13 Nov 2026 18:04:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D4632FE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E93C4018D
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:04:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8aT1yQfG5gYR for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 18:04:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 62CD24005E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=J5B4YvuZ
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62CD24005E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szwaHsHdaNFUL/s8iN81aw8qo3y8hWXYpY+QBuU5bXg=;
 b=J5B4YvuZnf1dEQmgKl5fovZlqsL2ylzFQK6eNnqEfbUapgu/WSy3wdAPQj+5QWqiOZQrUiNAk3AhFjbcj+DB5MMl0VS4NFPkQ4fF9gHTJIjqXzcsf+fkMFjFpNb4KHrV7BQ2MFduMdjvkInFe8N7MbEFaNEDEUNkXfp77n5thyo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA6PR04MB11780.eurprd04.prod.outlook.com (2603:10a6:102:522::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 18:04:02 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 18:04:02 +0000
Message-ID: <91793e39-5b1e-44b3-b6bc-59497f4068c8@cherry.de>
Date: Fri, 13 Nov 2026 19:04:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/37] clk: rockchip: rk3576: Group LPLL register macro
 with CCI macros
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: Lukasz Majewski <lukma@nabladev.com>, u-boot@lists.u-boot-project.org
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-30-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261011222930.1085075-30-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0047.eurprd04.prod.outlook.com
 (2603:10a6:802:2::18) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA6PR04MB11780:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb90cf7-34d5-4263-2905-08df41b07fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: z/2W5gQzj0jQRIThZEK/YKCT/YW88uBQT+pDMOKI2TA8o5tYaFnID1mxYRWpXAikmxDMRmH+xWpsAd+BYxkJ/WrGLPhawQ4hvYBDPd/OKGfqJxdFjYaR/ZpDBU/n6XAy/erUiEdzd1wLf1v0qy0rEskWqcFNzeB/GX6Ei6y/V0kobvmRw/LbdTI3swDo5iEKco4woKbnr5HeO+UD6jgNM58Spdhc+PNWxAyshPvIMSamMBzXLZltwlDchwDCxZZWMRK9IQFg1tHs/xlzvwampNzBPpqtnTBKjc5rGZIhCS5gikaqXtoCk0ydomP4fQswu1Y/MESI/Jzssr5k7tnrIGxq/nPNVf68WCIZZ56i18oscw9njhlopJP0Amu63OhwB3I7tasXr9k99YgSZ/X4WivTmCg06llsIEIceltk+oxye4YXxKfVhjkOPB3qv4O5+9C5TY3cJN6dQTtGdyD5rfLsg+Y+trcKMjG3bJPWrsGlORsfdOTDZeCNuuXEqUZJ6kN13bLFWgblRTngFKmd5yhkHN2ggT0D9uKp7xVdODE6w/eqUmmQHz401ZVN3fRSWyfNlJmUVW7tkzES7Orrq2y+EMWW4Vs5drBlDD/WtEzLBGO78cJb7dbVy3ckk5BXF5476kZDzh7WvHuvnKX3+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVppRW9DeWFmeWJJTU53bm9CRkNkWHFmSk1iV21VYWVEV2ZMK1R0ZVJPNGtv?=
 =?utf-8?B?NkNJVzFta1JkalJQazAxV3Fra1JUV01vMjg1b1hCSHZYcDAwWFF3SVVDc2E5?=
 =?utf-8?B?Y3E2US9RTFh3bEpwMXNtbXA3OUxBSVNaWGoyem5TY1lUMGpKTWRzNDlzS3Iw?=
 =?utf-8?B?TkZwWCtYbzRwdm5QSnNnK0VlLzZkdlViem5JMXhXcm1TU0dHQ01Ib2oxV1pK?=
 =?utf-8?B?TU1kUVQ1MFQ3SVZGYW9ISzYvTE4yTXFFT0gwQXBlZ1B0ZGc0UXFIdnVZQkZt?=
 =?utf-8?B?NzgweDZ6MjlrQVRMdGhoVXZvcGJicGZuaFZOL2puUXkxV2VQZlRoenZTTXVE?=
 =?utf-8?B?aTVYWlRLT1BROTFULzNvWWZxR0doWmR3RU5Vdjltano3OWcwSDdDRUc0V2h5?=
 =?utf-8?B?R3hlMVdEUmw4Z2ZCd2lYMlBvY3JtdkRMT2VabGs1aFVEbURIc0xzdmthWUc3?=
 =?utf-8?B?L0tGTzVIOEtHVUg3a0FXbmF2ejFtY3FNTFdvZ0lJUG01aUFLaHRwZVFLQ2xx?=
 =?utf-8?B?SnhYNXN6WFRSVTRublkvY2hqdDhQRXVBOHIzQjZFRGtLVEFjNExnT1pwYXRs?=
 =?utf-8?B?MUFhcVMwNmlqNUZzTHV3UlpwbGJZZ2s0eUZtV2lsNmdlL1dteEJNVi94Yld6?=
 =?utf-8?B?d3M0TVpMSzRSSmM4SjlMMDhaUjVzZ3F4dmM0cEJJcGd4WGpwY09za3lrSWZH?=
 =?utf-8?B?TTVHUHVUa3d0Yld5SER6UTh2cm0vOGNJK2R6WVNpWU5iTThJN2hWMjJEam1D?=
 =?utf-8?B?WTRES2NVR1lsUW1JckM1ZTNrMUpUUmxVM0FCUGkwN1JRbjlLd0x6dURTR2RS?=
 =?utf-8?B?ZG13YUoweHVxSjdrM0Fqai8veVc4Kzd1ZEI3V1JXT0JJVXlhdmFaSG13MTVa?=
 =?utf-8?B?WkJPYkRtTjMwUXR3dmZoUllDeUFtYjA2SnZmbEhHSTRVSjBvZ1ZuSW85azZi?=
 =?utf-8?B?NmM4ZDQzSVNVRXZ1Z1g5eG9GaWxBNUR5Qnc1OFl3d2grZ01BTyt0UERuUTdU?=
 =?utf-8?B?U0QrY1craEtUQklGZkVuVkVMQkl2d2hXUUlCRmdmcER3Zmt5Z2c1eDBrUGVM?=
 =?utf-8?B?RU91M0VnbTU4NlRMbDgwVytKaDBBd2tjYkIyd01UaDNLVnMyQWorRDM2SjRY?=
 =?utf-8?B?NUQvUEttNXZZbWlHUlJGdlpDV3c1QzFsdGZwR1BvVnV4eVZYTDBmalBDZWVJ?=
 =?utf-8?B?czVMWU9UQ3UvaTNEM0lyVHJLbWhVSkNIOU9zdCtzaU91L3RHZ3N0c0J1bFZB?=
 =?utf-8?B?dlpBNU5FWWY2WFBZT2FPMk9KSVQxZDU5WlJtZXRWTWlmbnlQOFhRdy9wTG5C?=
 =?utf-8?B?N1dNbEdzbzR0QVZSUUEvUzdsek1GOWxnc0t0YUZ6R3RtN2wwakxlbno3dFpm?=
 =?utf-8?B?Q3RsUFdKaUdmVlJtRUd5OFB2M2JpQlIrcjlkOXl2NlkrM0lXczRicVJ0ZVNJ?=
 =?utf-8?B?cHo2QkZxWHdEOEovQzFZQ0d2bHgwTktPUGp5R0VuTlVpUVp0bHhIOUJvUGJM?=
 =?utf-8?B?cXVmaGptZmhFREh4Qms3Z1ZSbkIybjBGOWtLRUFwOGs3d0FXdnlvRlc5Y2tp?=
 =?utf-8?B?aWdMcTF5RGlxa2EzQk0zaEh1VVl5SXRIWFZ6eXJMU0xodVRhL09xdXg4T0hV?=
 =?utf-8?B?Z0NFTVdNOEZwZWtYd01wenF3bWtwbXVWVEV5aWxwSS9maXBxbWNWeWpLZjZj?=
 =?utf-8?B?ZjhXSWRlMXBwT0ZlbVZySWNmdWtFd2JuZDd6SVJGMnI1Y1cvL0xPOHo4YTFC?=
 =?utf-8?B?M0xQamRPeVR3SEQxdWNjRTBaSEt4cmNxeVV2WmhZQWxIeHVqS1JTaFdZMDZX?=
 =?utf-8?B?Y0pGbEt4VDNQSElNQ3I3cEJVTytsaVpDMVc3L0ROUWNwR1lPMCsyZHh3NUgy?=
 =?utf-8?B?NHFjK28zZlVjMFhLd2s5UkcwbzNMeTZhZUNWa0xIc1VvcWtYaHRHL0l4eVBL?=
 =?utf-8?B?eUJuSmloUTJONHBYcS9xQUV6WTBlT2RsT1RmZk9qNEF0TUdkWTNxZ095RmU3?=
 =?utf-8?B?M0pBU28vdUhiVDErQkNlMEdiOXdiYVBRY0hlQThEdkJseUszTSs5enh4d3h6?=
 =?utf-8?B?SUVERlUwczBRM0FVWmEvUnJ5YnRybDJFUDVrRVBQK3VwdU9JUC9yQmE1ampU?=
 =?utf-8?B?OUdYTVo0bDZpREc1d1QwemRrMmZoNUFEbTk3c3ViZGkxblVYRG1ibmxXN0tW?=
 =?utf-8?B?bDlRaFlsRXFMS0RaL3JmWVEwSU5ZUDZMQk5PQUN0NDA0UU1IbUZQRFdwL1Vm?=
 =?utf-8?B?SlpzVmdScVdHWFRyM1BaM2wzSkZUdnV2UHFiQWd2QktIVUhmdUs5SXZ4dVVQ?=
 =?utf-8?B?eGFPM21JcGtyVnpHeCtPN05aMWZCcEJ4bXJrSGYrN1BFekhocllSdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb90cf7-34d5-4263-2905-08df41b07fd3
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:04:02.6463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGiwkoy/P5ie5j4nHmTEK3hV+K/Mnpcs6OPlzVNkP+SLNO2Z9ayfzBeOdxjJUj8yUY4Bco+VlWQoLWY1gykjx2X26Gw9ie0BlV8MGnJOyVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11780
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 10/12/26 12:29 AM, Jonas Karlman wrote:
> Move the RK3576_LPLL_CON macro alongside the other CCI CRU register
> macros for consistency.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE8DE668B4
	for <u-boot@archiver.kernel.org>; Sat, 20 Dec 2025 14:56:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4562D803F5;
	Sat, 20 Dec 2025 15:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="i5x4zZtR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9124C808AF; Sat, 20 Dec 2025 15:56:11 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B549480325
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 15:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrIWKhUFAVcuxUMGNbk5gfZg/YIGKVvnUPPEL5jKgLzgH23zQl2bAwcIUtJf1MLnvOrMKYpy42oSfwsuui9gEzNbCRxbIiVesJ62SQaQIUgbOGv6uHvWMo62Ad6K+E/1GJeWl2gZTp5I8evg0/huJ2DSGeduuxy1UZol8t2wnc5XRuvpKQ2BD2SQziAHDuXE9QJWk95S55bW8QNoLlOkMOf1yomesAZHUZeTeNV7kOLc2rSBt+xMKBfpRNNSsF/oN+lQ/BCkeb90mLaEhHWC3dS2dcyQumZh2UgDVZOAuXGkcP4LO6wxoL2N4eVYc3yL4KFPzIdwBefIORrFUyvRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3jbBhXERIwqDK2hHZIRggpHijdpsxX6SsTfDCPDf9s=;
 b=OCsTinvZKhaGU45MSrTGVJ/GqcsaYc3tQfTYuNLgwg58lMzJCfd5mcnXAicDzkAQGHGJKY2Di3C8vDxNqcAAc0wRGOld2svMMUqguxE4kof0WLdC4AFy7i1X36lhXhzCcGyR2UB0XXvZ650na9x1UIBEugK/NHSx/KmFI7kF4t+EWZh1H+ywej4Tal2m5w98L6zaaL7q6u893a6ls6WUPjVYGZxrULqaQMQn9KI9SoYoTJ1tgerhHquSd88lFlggUDZhQqPlVicUAn+pHHoq00skVuLGYbMiSOJy9Njsq20THO51paYEizRjH+4yxcFwJ/lZRn2GjKjO51WiNpVlLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3jbBhXERIwqDK2hHZIRggpHijdpsxX6SsTfDCPDf9s=;
 b=i5x4zZtR6mIbctxYOZbYN2QnGHwQTkht7Rjeg+o8H27W6NDE5DaSHmHhXmMn+j8w3Emv2dNrdpwp+eixORsc5GZs/XcZ/J47nZZ2USh7Xy2iTCaZgu9rBy77HcaeXT7ucQGRKJbo6s8/mfVNgtOZF7dUHpEGIdnG+b5bb6YFZqDTHYSfSAAR6nfAJ89gdxLtKnwdPRGFl7TUdh+TlXMHo1Vyd2ZJJAIVCqWsxYAjlNUY+n8sjO3+I0Khkkzex6tW5gDVKPsi8w1WXm6T18DpHvvduEpoK2goSoJREQtPY/A06878TQXCnAvmrqchJsYHkEiUKXy87nHjpCZimUguyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6807.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:337::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Sat, 20 Dec
 2025 14:56:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9434.009; Sat, 20 Dec 2025
 14:56:06 +0000
Message-ID: <8dc60721-bfd3-4421-9b47-956c18314fc3@siemens.com>
Date: Sat, 20 Dec 2025 15:56:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Add support for BeagleV-Fire
To: Jamie Gibbons <jamie.gibbons@microchip.com>, u-boot@lists.denx.de
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>,
 Tom Rini <trini@konsulko.com>, Leo <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>, Yao Zi <ziyao@disroot.org>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Cyril Jean <cyril.jean@microchip.com>
References: <20251209114521.164647-1-jamie.gibbons@microchip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251209114521.164647-1-jamie.gibbons@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 7277fcf0-1e13-408c-ec1b-08de3fd7e720
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTRPTVFmQXpjc21KdEpRYmF1cVV6cGtsaVltbHlZa1U3aWNvU3l6YWxvOVVo?=
 =?utf-8?B?enV2ZVRGVXFJZlRBbDNRbEVLbElydEF0N0UvUmJoZUZJaU4vL1ExQysyT0ln?=
 =?utf-8?B?dmltaXBteW03eDE1RmRTWGNacS9VNUlLd01uc3NJLzFBU1d1dHRMYlRMMC9M?=
 =?utf-8?B?Z2ZLL0VpUVZFUDBaTXRQRkovY0NwLzFScG51NzJzRm92bjh3UWdFVFJPck9R?=
 =?utf-8?B?dHdOMmFVaFNaNlRadjdSQi9TZW9MZHB6d3VGSnlveFVVTlZoWnlNczNqWkw0?=
 =?utf-8?B?OUFiUWs3dnhKWTNER0toVkRZRjlyK0FTeXpQcjNZb2pOYnRocXBUMVZtalYy?=
 =?utf-8?B?Vk9QTHhiUVFEMmJCN1I2U0xXaExjNCtOU0FLZ1M5a1RkQjlMcWoxU0R3K25i?=
 =?utf-8?B?RG5RcWszcCswQ0xIUkdnQlVTY2F4T0NLQnlUQVhpNkJpSjMrVkFSajhtb2RN?=
 =?utf-8?B?emcrVWZxcDNhNkNRMWs1NyttSmhyRksyY1kxSVpGdnh2eGgrSG95TDFHaC9E?=
 =?utf-8?B?Vkd0ZllQSENTV2o0ZDduaDU4bUQ1cnZ2SWU0U3F1Z3hld0owZnRGSDdvTDJi?=
 =?utf-8?B?UDA3and2SXFoNHNrSFRvMi9nbjFFYWl0UXRrQUlac0JrNkt6cmgxRzFoWUFG?=
 =?utf-8?B?SmRFRXVmc0pqekdmbXBYd3ZYR3BvZExPdDVsb2tNZ2Z0dXFxWU9CL2ZEZEJL?=
 =?utf-8?B?bkJpQWZBWUI2amlTa0paTmJqOFlsSnpRbWRQVmFQbjliOG9IaTAvV3kvNWpC?=
 =?utf-8?B?bzVxa1QyNFRoTGs2ZGNGNTNTRjRtV1dJRndTLzM1Wmk3Wi9kSmVvYkZ5cFBY?=
 =?utf-8?B?RWlacXBxZld2cUtvTDZDL1BQTTlLU3RybVJDQnpNbmVoMG0wdFJCazZPais5?=
 =?utf-8?B?VHluS0xoQzZ6YjN2M2ZTQmdTU1Z2KzJFcmFMMXJCTzlkcVdxUHc0SlBuSFdE?=
 =?utf-8?B?T1htbHJpVDRjejRIcWFvaXh6WTZNcHFRcDRNYjZkVE1DRTRXZWJVOUlIVllz?=
 =?utf-8?B?TGFrVXdFai9kTXRxd0RUSE9jczNyTWV3MHc1MGZ5S2QvMFNyL1IwdjVPOWxo?=
 =?utf-8?B?dkdnSitTVlBQQWR1ZlhsRmZ0TVd1eXQrM01nYXZGWmkvcjA5Y0EwODdpbDVP?=
 =?utf-8?B?MnV1cWViRmk2dytpakgwYjJQK28rTzVZZXNyUW5oVGNoZFZmYjJjYXlGS3Q1?=
 =?utf-8?B?aFE0Z2F0M3BwT01sSTRtNzNFWUR4Q3RDSjdZMkd6TlZsTUVoZmtheldxaFQz?=
 =?utf-8?B?dFIxaUZPQlFuZHlPRXJKK01nZlNSM3pqU245YnlDZktlOVY5Z1NlMCsyZUY2?=
 =?utf-8?B?TlNPNlAram05MmEwT0ZZQSt4RGtXTE1LbXlTdStGcFkvSkM0VWVRMGZKTDRj?=
 =?utf-8?B?MzU2b0FTemZzV1BOMllTUXpWTm92WXR0eVJscUgwUWJrUStSMmYvN3pTa2xB?=
 =?utf-8?B?UzhRcXh1bS9STDRXWVlxUkUzNGxyZHhRd1g0emw1M1hhS2RoQSttZVZFLzAw?=
 =?utf-8?B?dGZMNUN0VTQyZGRCY2JSSlZBRWlhSE1FTHl0Tit3dElhdXdSa0dUbVBtYllD?=
 =?utf-8?B?UE9lWGdkSHFyaERJd1V5SVp4L2ZPc2VMaHJMM0xScVJNYTMrMFdCV0c2OEZr?=
 =?utf-8?B?WnpBU0oyNExyWHc3VWw0ckZIT2w5RVVJVEUxUnFlOCtURVV1SlUxVlM3bmQr?=
 =?utf-8?B?S01EenBiVzRVMDROMDFsUk9wbVY2Um5kSmxxRmJmT0VMc2Eyb3ZQMzh0elZQ?=
 =?utf-8?B?cExaeTRZdnQ3eXZDVTlkWU5qa0lOaWpXUFl4WmJGRnhIWGswRXI0clJSS2ZE?=
 =?utf-8?B?SGpFQmZBMkkzOTcva1ZGY01kMS82Qm9GUWZCM3EzTEIwVE5Dd1NFc2VKRnRh?=
 =?utf-8?B?NTNtajd2QW51RFZkV3ErWmZ2bFd2YjJlSnhVaHZpMWNUNm81RzBTV0tRbHFl?=
 =?utf-8?Q?WYBLUf32QzUAG1BvfEeTpq0JOTveG9hU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEdwenFmUkNwSUNrVGhBdVp4UnEvZzNnOVBQa1RyQmo0TjVnU2VoZFJMSGFX?=
 =?utf-8?B?dWIrcnVXY3VrWGRLaVZtWDhiOWtobmZKVDh3aE15Uk91UFd1aUZxNkhYSWJo?=
 =?utf-8?B?bUdScHFNeDNNQ2tYQ3pxc2xVUTdKZmQyNllIRENDbmlMWkJ1NzRVUGs2RDFJ?=
 =?utf-8?B?cFBFK3NnSlA5bnp6UUxrc0sycjBJaVNLbGgzczB4NWpUdWRHcmtPWndFT1hn?=
 =?utf-8?B?M1RhaG84SEVhbmwyRmhtMHFOM2xNTG93ZnIzcFJMdjR0VHNDTiszNzc3bG5h?=
 =?utf-8?B?UUNYUEFuUDB1dHN0QjNpbG1FWWloejcxUnczK0NUTWx1eFMwOTkyb1AxZW5Y?=
 =?utf-8?B?S1NmZVR2S2lGc1dQTXltejZPTC9OeVhUendBOUNFQllhVzhmdW5aTzZSekNa?=
 =?utf-8?B?VEIyQzlPSm9QSDhmYmJ6R05UWm1BcG9BdUh6OVdST0VhWEFpcVN3YnZmNU5r?=
 =?utf-8?B?b1daZm9TYk1iOUVValM3MlRaZUh0UVZrRjk0R0hEMytldy90cWtGblZ5RkJv?=
 =?utf-8?B?YjFnK0FXNVp5dHl2YzdNaysrVllUcGgvOVI0Vy9VVkdGSDFUTnBGbjcwbDZo?=
 =?utf-8?B?cXlra3EzMGR3aVZnWHNKRjFyb3d6WFh4ZS9GcU1OaGtzQ2dVSlJTSEM3eEpw?=
 =?utf-8?B?cVM0em90NFlKTlB1ZEF4QjB2am5pZlYvL0FndGZXNVRXQ1FvcVBVRkczYVVq?=
 =?utf-8?B?anQwTW9qRmwzczRySU15TEVwdjhZUjZvYVpqY0VwOWlSdzQ2TjQwMzRJbDVD?=
 =?utf-8?B?bml1ZGcyZkU5TlFJTytSNTVWLzZiOWovWFdnMFdCVDl0VGM1L1FQS0I5MFRv?=
 =?utf-8?B?T3d2UXhYdUJpTWJnNldEZ2NrQlp1NTBYSWVVdEk2ckkrc3JzU3NXYjVCZS9T?=
 =?utf-8?B?cTJ1czBBSkEwU1AzZ0MwdHNhZHJ3SHZvZTRIQlhvWEwwdUpHbEdTSFFxMmlC?=
 =?utf-8?B?VnVueVhuRFQ1dlVSUitFVkpJdTVJUjZHQUFHRkJkdUZYYWdUSWQ4QnV0b0dQ?=
 =?utf-8?B?cWhuL1lhaFREUFVSQjdQZ0JMR1Yvd0M0UFI2VllMVFdyMGZ3ekpCNG1Wb2wx?=
 =?utf-8?B?NTdGOGxZTTZQek83T2M0bEdqdkpvZGN1NjBxVmQ3eTlGd01lMDBnWS9VYzly?=
 =?utf-8?B?bWpLMS9vM3pwdGlIQlN4QVZaNmhXTjZYbTlab3pnclVMZkxsMVFESm04WnU3?=
 =?utf-8?B?TFFoRGZQaCs3dUJHOUlZYnV6bGlTNGwrMG1CUTFwTnNIRkZwbms5MDdjQlY4?=
 =?utf-8?B?WENqYTI0MkxpRnZscHJ2OE1aWFk3a1VZMXFkVjMwcXh1bE1wWGxuL3NCOWxD?=
 =?utf-8?B?K2NlZ29tWkhpS2dLNXFFQ1dqcG9oVThaOE9nd2xoejBQMnFRQmVZT0g5TVE2?=
 =?utf-8?B?a1g2Tkl2YmI1alZOQXIzeDdyWXZvc2w5UmlXcG9Gck1tL25CQlBVN3YyWWxs?=
 =?utf-8?B?b2Ivb09TY3VaMUdQbDVseTFkTE81dG5TbUJ6bkNqMk9ZemdpdExFcVp1Q3dJ?=
 =?utf-8?B?K0laV05VbVRzdmhuS2RrelpRb0lEMGN6em05cS9pSzNMMTFtbC9kMnN0Rmhp?=
 =?utf-8?B?UitQRDNCVkJkclZkVWdMejZLN1Q4SUcwcWVneXVDOFJFSlJoZW5IMDFnTVo0?=
 =?utf-8?B?QjhrOVNZY0RVMmZhK2s4UnRNQ2k2bnhNMHN6WHBWWVN0cS8yNkVRREY1WWo4?=
 =?utf-8?B?aUFSclIrblRrYnJMaXpyakZzMENib0ZMbi84TjZVVkxoVENoRUFiSzVrR1Vt?=
 =?utf-8?B?SDdZNzkwZ0JabTJJbVlXZEVhVjhmWG9sdUpGMlE5T1RCYWxtQ3lsMGlRU0VR?=
 =?utf-8?B?ODRwdE5WaHpCcEt5eUs4Q21HS25wTjdycVVBT2pUNm12bzRJVlFOZUN2ams5?=
 =?utf-8?B?L21yWUhTRWIxNE9VTU1BVTN1OWUwQWIwTzk4dFB3RVZDQ1h2MEpYbTF1ZTBy?=
 =?utf-8?B?amFyU0F0QnVVSnRkZEFwR2QzQXRvSSthYlBlMllHemxIVjVmbXFENjRSeGNv?=
 =?utf-8?B?WVhpYnUweWY4ZUdRTHNYdHM4cmFIcmFqZWdzSmJHL2tKMVV3QzdpT1RLU3Yz?=
 =?utf-8?B?OFBiZm5uT21iQWtFcElaTFNzTVdvanlabGh0NVptTmhnd2E2R0l2dTNNM1gw?=
 =?utf-8?B?KzIrem15V0NrZVZENHF0Q1c3dGdBK3dieWJhVkFhbG9xS0JhTm9ub2cwMnlq?=
 =?utf-8?B?YjNydEFZa2FQRmxKT0FPUWRjaUNUcjRPb3ZsYWxFc1U3UURSMFdUdThDOFli?=
 =?utf-8?B?TFpLaDExZUEvaFdWdWdyYU9TSmRRKzcrOUUrQ2pTYktZZEQ5elorMXpyZ2x0?=
 =?utf-8?B?Nllsb29hdUFyNllnemZtcVZqd0NJTTM0VERXMFFYaG1McmkwaHV3QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7277fcf0-1e13-408c-ec1b-08de3fd7e720
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 14:56:06.6329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gq1patVOSag4CVB9QQ6FkSWV863fW5ffZyiAeJ5OebSFfcQZQ6Xzm3T1f89+CFSj/A/GsaVelYn2zUXw40b3hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6807
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

On 09.12.25 12:45, Jamie Gibbons wrote:
> Bring U-Boot support for the BeagleV-Fire by adding a defconfig and
> supporting board files etc.
> 
> Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
> ---
>  arch/riscv/Kconfig                       |   4 +
>  board/beagle/beaglev_fire/Kconfig        |  39 ++++++++
>  board/beagle/beaglev_fire/MAINTAINERS    |   7 ++
>  board/beagle/beaglev_fire/Makefile       |   6 ++
>  board/beagle/beaglev_fire/beaglev_fire.c | 117 +++++++++++++++++++++++
>  configs/beaglev_fire_defconfig           |  29 ++++++
>  include/configs/beaglev_fire.h           |  57 +++++++++++
>  7 files changed, 259 insertions(+)
>  create mode 100644 board/beagle/beaglev_fire/Kconfig
>  create mode 100644 board/beagle/beaglev_fire/MAINTAINERS
>  create mode 100644 board/beagle/beaglev_fire/Makefile
>  create mode 100644 board/beagle/beaglev_fire/beaglev_fire.c
>  create mode 100644 configs/beaglev_fire_defconfig
>  create mode 100644 include/configs/beaglev_fire.h
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 265b5320777..dd98dee8eab 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -17,6 +17,9 @@ config TARGET_ANDES_VOYAGER
>  config TARGET_BANANAPI_F3
>  	bool "Support BananaPi F3 Board"
>  
> +config TARGET_BEAGLEBOARD_BEAGLEVFIRE
> +	bool "Support BeagleBoard BeagleV-Fire Board (based on Microchip MPFS)"
> +
>  config TARGET_K230_CANMV
>  	bool "Support K230 CanMV Board"
>  
> @@ -106,6 +109,7 @@ config SPL_ZERO_MEM_BEFORE_USE
>  source "board/andestech/ae350/Kconfig"
>  source "board/andestech/voyager/Kconfig"
>  source "board/aspeed/ibex_ast2700/Kconfig"
> +source "board/beagle/beaglev_fire/Kconfig"
>  source "board/canaan/k230_canmv/Kconfig"
>  source "board/emulation/qemu-riscv/Kconfig"
>  source "board/microchip/mpfs_generic/Kconfig"
> diff --git a/board/beagle/beaglev_fire/Kconfig b/board/beagle/beaglev_fire/Kconfig
> new file mode 100644
> index 00000000000..279d38b3aa9
> --- /dev/null
> +++ b/board/beagle/beaglev_fire/Kconfig
> @@ -0,0 +1,39 @@
> +if TARGET_BEAGLEBOARD_BEAGLEVFIRE
> +
> +config SYS_BOARD
> +	default "beaglev_fire"
> +
> +config SYS_VENDOR
> +	default "beagle"
> +
> +config SYS_CPU
> +	default "mpfs"
> +
> +config SYS_CONFIG_NAME
> +	default "beaglev_fire"
> +
> +config TEXT_BASE
> +	default 0x80000000 if !RISCV_SMODE
> +	default 0x80200000 if RISCV_SMODE
> +
> +config BOARD_SPECIFIC_OPTIONS # dummy
> +	def_bool y
> +	select MICROCHIP_MPFS
> +	select BOARD_EARLY_INIT_F
> +	select BOARD_LATE_INIT
> +	imply SMP
> +	imply CMD_DHCP
> +	imply CMD_EXT2
> +	imply CMD_EXT4
> +	imply CMD_FAT
> +	imply CMD_FS_GENERIC
> +	imply CMD_NET
> +	imply CMD_PING
> +	imply CMD_MMC
> +	imply DOS_PARTITION
> +	imply EFI_PARTITION
> +	imply IP_DYN
> +	imply ISO_PARTITION
> +	imply PHY_LIB
> +	imply PHY_VITESSE
> +endif
> diff --git a/board/beagle/beaglev_fire/MAINTAINERS b/board/beagle/beaglev_fire/MAINTAINERS
> new file mode 100644
> index 00000000000..a5dad93ee99
> --- /dev/null
> +++ b/board/beagle/beaglev_fire/MAINTAINERS
> @@ -0,0 +1,7 @@
> +BeagleBoard MPFS BeagleV-Fire
> +M:	Cyril Jean <cyril.jean@microchip.com>
> +M:	Jamie Gibbons <jamie.gibbons@microchip.com>
> +S:	Maintained
> +F:	board/beagle/beaglev_fire/
> +F:	include/configs/beaglev_fire.h
> +F:	configs/beaglev_fire_defconfig
> \ No newline at end of file
> diff --git a/board/beagle/beaglev_fire/Makefile b/board/beagle/beaglev_fire/Makefile
> new file mode 100644
> index 00000000000..a4109a8aad4
> --- /dev/null
> +++ b/board/beagle/beaglev_fire/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2023 Microchip Technology Inc.
> +#
> +
> +obj-y	+= beaglev_fire.o
> \ No newline at end of file
> diff --git a/board/beagle/beaglev_fire/beaglev_fire.c b/board/beagle/beaglev_fire/beaglev_fire.c
> new file mode 100644
> index 00000000000..b2f18c455b7
> --- /dev/null
> +++ b/board/beagle/beaglev_fire/beaglev_fire.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019-2023 Microchip Technology Inc.
> + */
> +
> +#include <dm.h>
> +#include <dm/devres.h>
> +#include <env.h>
> +#include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <linux/compat.h>
> +#include <mpfs-mailbox.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define MPFS_SYSREG_SOFT_RESET	((unsigned int *)0x20002088)
> +#define PERIPH_RESET_VALUE		0x800001e8u
> +
> +#if IS_ENABLED(CONFIG_MPFS_SYSCONTROLLER)
> +static unsigned char mac_addr[6];
> +#endif
> +
> +int board_init(void)
> +{
> +	/* For now nothing to do here. */
> +
> +	return 0;
> +}
> +
> +int board_early_init_f(void)
> +{
> +	unsigned int val;
> +
> +	/* Reset uart, mmc peripheral */
> +	val = readl(MPFS_SYSREG_SOFT_RESET);
> +	val = (val & ~(PERIPH_RESET_VALUE));
> +	writel(val, MPFS_SYSREG_SOFT_RESET);
> +
> +	return 0;
> +}
> +
> +int board_late_init(void)
> +{
> +#if IS_ENABLED(CONFIG_MPFS_SYSCONTROLLER)
> +	u32 ret;
> +	int node;
> +	u8 device_serial_number[16] = {0};
> +	void *blob = (void *)gd->fdt_blob;
> +	struct udevice *dev;
> +	struct mpfs_sys_serv *sys_serv_priv;
> +
> +	ret = uclass_get_device_by_name(UCLASS_MISC, "syscontroller", &dev);
> +	if (ret) {
> +		debug("%s: system controller setup failed\n", __func__);
> +		return ret;
> +	}
> +
> +	sys_serv_priv = devm_kzalloc(dev, sizeof(*sys_serv_priv), GFP_KERNEL);
> +	if (!sys_serv_priv)
> +		return -ENOMEM;
> +
> +	sys_serv_priv->dev = dev;
> +
> +	sys_serv_priv->sys_controller = mpfs_syscontroller_get(dev);
> +	ret = IS_ERR(sys_serv_priv->sys_controller);
> +	if (ret) {
> +		debug("%s:  Failed to register system controller sub device ret=%d\n", __func__, ret);
> +		return -ENODEV;
> +	}
> +
> +	ret = mpfs_syscontroller_read_sernum(sys_serv_priv, device_serial_number);
> +	if (ret) {
> +		printf("Cannot read device serial number\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Update MAC address with device serial number */
> +	mac_addr[0] = 0x00;
> +	mac_addr[1] = 0x04;
> +	mac_addr[2] = 0xA3;
> +	mac_addr[3] = device_serial_number[2];
> +	mac_addr[4] = device_serial_number[1];
> +	mac_addr[5] = device_serial_number[0];
> +
> +	node = fdt_path_offset(blob, "/soc/ethernet@20110000");
> +	if (node >= 0) {
> +		ret = fdt_setprop(blob, node, "local-mac-address", mac_addr, 6);
> +		if (ret) {
> +			printf("Error setting local-mac-address property for ethernet@20110000\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	mpfs_syscontroller_process_dtbo(sys_serv_priv);
> +#endif
> +
> +	return 0;
> +}
> +
> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +#if IS_ENABLED(CONFIG_MPFS_SYSCONTROLLER)
> +	u32 ret;
> +	int node;
> +
> +	node = fdt_path_offset(blob, "/soc/ethernet@20110000");
> +	if (node >= 0) {
> +		ret = fdt_setprop(blob, node, "local-mac-address", mac_addr, 6);
> +		if (ret) {
> +			printf("Error setting local-mac-address property for ethernet@20110000\n");
> +			return -ENODEV;
> +		}
> +	}
> +#endif
> +
> +	return 0;
> +}
> \ No newline at end of file
> diff --git a/configs/beaglev_fire_defconfig b/configs/beaglev_fire_defconfig
> new file mode 100644
> index 00000000000..c476fb103c5
> --- /dev/null
> +++ b/configs/beaglev_fire_defconfig
> @@ -0,0 +1,29 @@
> +CONFIG_RISCV=y
> +CONFIG_SYS_MALLOC_LEN=0x800000
> +CONFIG_SYS_MALLOC_F_LEN=0x2000
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
> +CONFIG_ENV_SIZE=0x2000
> +CONFIG_DEFAULT_DEVICE_TREE="microchip/mpfs-beaglev-fire"
> +CONFIG_SYS_PROMPT="RISC-V # "
> +CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_SYS_LOAD_ADDR=0x80200000
> +CONFIG_TARGET_BEAGLEBOARD_BEAGLEVFIRE=y
> +CONFIG_ARCH_RV64I=y
> +CONFIG_RISCV_SMODE=y
> +CONFIG_FIT=y
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_DISPLAY_CPUINFO=y
> +CONFIG_DISPLAY_BOARDINFO=y
> +CONFIG_SYS_CBSIZE=256
> +CONFIG_SYS_PBSIZE=282
> +CONFIG_SYS_BOOTM_LEN=0x4000000
> +CONFIG_OVERWRITE_ETHADDR_ONCE=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_BOOTP_SEND_HOSTNAME=y
> +CONFIG_SYSRESET=y
> +CONFIG_MPFS_GPIO=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_DM_GPIO=y
> +CONFIG_MMC_SPI=y

I think you are missing CONFIG_OF_UPSTREAM=y. I applied this on top of
next and only got things compiling after turning it manually on.

> diff --git a/include/configs/beaglev_fire.h b/include/configs/beaglev_fire.h
> new file mode 100644
> index 00000000000..e3ee0f02f2d
> --- /dev/null
> +++ b/include/configs/beaglev_fire.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2023 Microchip Technology Inc.
> + */
> +
> +#ifndef __CONFIG_H
> +#define __CONFIG_H
> +
> +#include <linux/sizes.h>
> +
> +#define CFG_SYS_SDRAM_BASE       0x80000000
> +
> +/* Environment options */
> +
> +#if defined(CONFIG_CMD_DHCP)
> +#define BOOT_TARGET_DEVICES_DHCP(func)	func(DHCP, dhcp, na)
> +#else
> +#define BOOT_TARGET_DEVICES_DHCP(func)
> +#endif
> +
> +#if defined(CONFIG_CMD_MMC)
> +#define BOOT_TARGET_DEVICES_MMC(func)	func(MMC, mmc, 0)
> +#else
> +#define BOOT_TARGET_DEVICES_MMC(func)
> +#endif
> +
> +#define BOOT_TARGET_DEVICES(func) \
> +	BOOT_TARGET_DEVICES_MMC(func)\
> +	BOOT_TARGET_DEVICES_DHCP(func)
> +
> +#define BOOTENV_DESIGN_OVERLAYS \
> +	"design_overlays=" \
> +	"if test -n ${no_of_overlays}; then " \
> +		"setenv inc 1; " \
> +		"setenv idx 0; " \
> +		"fdt resize ${dtbo_size}; " \
> +		"while test $idx -ne ${no_of_overlays}; do " \
> +			"setenv dtbo_name dtbo_image${idx}; " \
> +			"setenv fdt_cmd \"fdt apply $\"$dtbo_name; " \
> +			"run fdt_cmd; " \
> +			"setexpr idx $inc + $idx; " \
> +		"done; " \
> +	"fi;\0 " \
> +
> +#include <config_distro_bootcmd.h>
> +
> +#define CFG_EXTRA_ENV_SETTINGS \
> +	"bootm_size=0x10000000\0" \
> +	"kernel_addr_r=0x80200000\0" \
> +	"fdt_addr_r=0x8a000000\0" \
> +	"fdtoverlay_addr_r=0x8a080000\0" \
> +	"ramdisk_addr_r=0x8aa00000\0" \
> +	"scriptaddr=0x8e000000\0" \
> +	BOOTENV_DESIGN_OVERLAYS \
> +	BOOTENV \
> +
> +#endif /* __CONFIG_H */

No luck with booting next(29ab19c2bead)+this yet, though. No output after

[9.356454] Boot image set name: "PolarFire-SoC-HSS::U-Boot"

Am I missing dependencies?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

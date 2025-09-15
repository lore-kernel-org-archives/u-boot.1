Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62902CAC592
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 13:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B220D8344E;
	Mon, 15 Sep 2025 15:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="eUBeH5nW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1C1080422; Mon, 15 Sep 2025 15:42:01 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A51FD80422
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 15:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2MvKMSl8C22dLh7lvss7BsHaeRhqTujvoTE7Rf4svKxpQKi4IXxzL4AEcGlU5N90oEB2M5SMFgRALK4lfYeC8yD2SkssOdhXfnuD/ekx1Yfi6TLAEKXk1XQiCio0BcOO7GOHmcwhcloozNZVNChu6ICpoy5SpzOrxIyVSgC6InJzyqm7B2NgjchH46WUY8omXXQB048l8AR4lbAnu9gTgKF1yJ1zL8bNYs2RrybUhfIxrnhY2tEOqmpAzYjOWxbUlFmx7TZUbuY7LlUddcaM8dhGw6w9la8rCYU+SZYByYxaW6IsmgcivrdwIqcVBD1qaM2QqR1sI+iTyZZ5mn1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8nnC3eS983sXG0LVakLwd7YoBeO7p8XofAi6nn0Ld4=;
 b=yUgsvL/jFdWwLz9oX2ubI7cXyQ4jan80wyr8971HQnUDV1+IXmcX6w9zCZFtx04j429Wun1uSUDZkOWKiq/G59j5i+UI1DQ9l11to8OUU6i1R73FSg1lu/pl/orvm2w09O6/iqTrrlMm4OwJX9si/3JCMlrrs8ChMxB0iU6yAejGVaIDw3wPsuzDjGrKyYX+7HIO8AEIbba8VSgi/StkDdeCqxkU5K1zoxIAYGC0OIJG933TWzfamIG/pRDLj4gHACZ5MJdU/H2jMeEmFx45rthjibRry8L4uwS3qwhYdkANsY5q6idaEMGZ+/WetGWAFP9B1GnX/SHzswvDkj/19Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8nnC3eS983sXG0LVakLwd7YoBeO7p8XofAi6nn0Ld4=;
 b=eUBeH5nWLoRzpY2N+U9CS7fmNGHXDzUIiFfsHxxJBWLx06rAQQZb5ihORRpqgnRLydwx8nYJDGy5c5NGac64dny0wPJ6qVy/LeAnS0QM/bWOcnFPF2nsrLpyXb/LSMoAQTy6aiAWbuvE0MHuiJ3WcMB/nV+8Oy2pxt1RhImHigZu8uD4+gECaFgY1LEjMT9vdX33vVF5FlgUzS3i/aupW8KGuK6VbnFNvH4aSnCDsK6PwwFHAq35/QpytvZaNfkF3OTdyiDpf6LO0qbrqNlSzizOPp8TH17Y/oxlsCD2dyPwtJn9WT7327JB4mIEFP9ZqmHGqsOMfRQtJ06ZFm4Flw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:386::16)
 by PR3PR10MB3916.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:48::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 13:41:57 +0000
Received: from DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa4b:dd2d:9aea:d5b3]) by DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa4b:dd2d:9aea:d5b3%6]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 13:41:57 +0000
Message-ID: <de5e5cfd-6946-4be3-ba08-5105460a7de0@siemens.com>
Date: Mon, 15 Sep 2025 15:41:55 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] test: Fix optee unit test
Content-Language: en-US
To: Jens Wiklander <jens.wiklander@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::6) To DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:386::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6190:EE_|PR3PR10MB3916:EE_
X-MS-Office365-Filtering-Correlation-Id: f96c9fd8-1f66-4112-5a74-08ddf45da3a6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2N1SDd0TDhwTlhUSkxmWldFY2ZsU0hOTVFyZVNldW1URm1JekxTZlFzQ25Q?=
 =?utf-8?B?dlJiTWpvN1hUZEY0TitYbDdpMzUxNktUcm9WTUlQMTdTTVhDQzQ0bnJDSXZx?=
 =?utf-8?B?L2cvaFVQNGlnZ053Tm9wVDZxNWtPT1JPNEdhVXBVVVJGQnJsM1hDb2NDMGVY?=
 =?utf-8?B?dVVIN3ljdURSeEh3SlduVFIwRGlyaFJlYTJwejVEYW5tTFQ1QjNBRFJQeFNO?=
 =?utf-8?B?U3JOellLQjRhTmxET01kU2RkdzBlZnZ3cUNjR1B4VjB2dHZKSXpSendhYzNo?=
 =?utf-8?B?Z2pKSEthNjN2V0pOQkNhSm1jSWxicHZIYzQ2WDcvVHpTWVdicmoycHEvL2VD?=
 =?utf-8?B?SVd3a1RHRzdLc3d1bll6T0NRVi9LRG9oS01obk5zampsTkRjcnFyVjViZkts?=
 =?utf-8?B?SVlVeDYyYUZpRlFhVm5nNU1yVHpNY1RnMHM3L0RUc0xQamR5a1B1aXBRSDNL?=
 =?utf-8?B?NW9PT1VvOGt0aWhKendFaWFJMXpZdnU3TzJzayt5MnY2RVl3QkN6d2ZYbnA2?=
 =?utf-8?B?Y29aZnU1TjFicVloU1ZlL1FJVWQvb25xOUlLRE9ZQzNYSzVNQmp5cW4vd1kv?=
 =?utf-8?B?amtEUHJMb1I4UmdKWHVCanZ2SkZwakNRZ2J5aU5XQjBmZFJpL3Y1d2hwZGww?=
 =?utf-8?B?LzRiUnF0RUpoVk95WWd2YUpDMldWeHpSTUdwSk5lNUJzc2MzZkxoSENTM2Iw?=
 =?utf-8?B?N1JOVEVORXVRZmVOVHJ4UkhsdHlNVlRwa3NiNHV1bjhIZ0tISFJ1WllsK281?=
 =?utf-8?B?TFpEdllZQkNUV01vUUxEK0k0OHkzQ0oyU0tNSFJzcHFEczJ3WDV3UHRzUVBr?=
 =?utf-8?B?VTdrUUJHSXFURDk0NlZvTUIzMW9CcGRrZTErZkp4eU9XUWNYUktLSFJjWk9i?=
 =?utf-8?B?NFFBaURjT0dnVWRZL0tCVGowUmFYZ04wYVIzeW01S0ovVWcrUVhmMlA1Vkhv?=
 =?utf-8?B?NHhOdVhENHJGUkFhYkRJRFFiU3RvUXNpYTJVTHRVM3o4eXgyem9FeG42MzhM?=
 =?utf-8?B?V0xhZHIyZmNpd0xxWDQwYVFFT1VFd013MGw3TWptV3kwdEV3ek1TZkg3ZGpx?=
 =?utf-8?B?cytFL3JWZ1JxQjVMMUR5NU5ObUJnOGFheGJDYUZNNy8xTkdDWVFRT1A3RVZx?=
 =?utf-8?B?RDdUMEZOTE1NbThOUjdsc1hndXBPaFBnWkF0N3lJNHZYKyt5Qkt5aGtlRE5V?=
 =?utf-8?B?K2hnTCthT1FNQ1Jtbi9ENy93aWtqSnZVR2JwczJnYk5NeWFzOUNqcHVYMVNI?=
 =?utf-8?B?VTIxLzk0V3B1STNWTk91b29pTWZERHlTN25XWE5KNU9EQkhUaDROcWFLV0Uv?=
 =?utf-8?B?SzA0ZTFDa2t5dDJEYmNNaDdaNk5XbTBJVXhTaW1yOUltblFWMVhnZ0pDRXpC?=
 =?utf-8?B?bk9ncEVGK0FlaE9XNHBNV0VuNkorc0d4bmFtWnZHYUpweU9HVkR5bGYyTU9I?=
 =?utf-8?B?a0p5eWpUUFBieFpuTXBMTGRWejljN0FrNzg5aHJPV3NzcXdKUnUxTmNBMzRo?=
 =?utf-8?B?NGt0VDZwbXlPWjMwdllzMmlRYlVFdjBuS3pYbWRDb2RJZFRPUzZ2c3ovNlVv?=
 =?utf-8?B?RmZoSE1sanV5ZHVCRU1sMnJKdFdnd1U0Z3BYTkwvRkUrSWNFb2VYeGtHNDdR?=
 =?utf-8?B?SGVYd0hZbVRSSGdiWlIzaG4ra1FFdmUrMTQ3QThYQiswbCt5cnl1RXo4bmRu?=
 =?utf-8?B?K0RBbkQycjRLS1JqeGFEQXdTbk1zU2IwMjFQZ1dEamNRTUZZbmlUdFAwejdF?=
 =?utf-8?B?TS9leGpaelcyV20zMmgveGZvQmwvR20wdElJZ1g1dEJFQkRGa0dQVW40bHpC?=
 =?utf-8?B?cFFaRmtqMXkwcjJnRjBsbmJGZkdyeExJQmVpZmV5YjRzZXJuTzEvVXR0Z0ha?=
 =?utf-8?B?SFFvNGE4ZkJiYXlDa0JHYVdNRWNGQXUrVC9jbEpiK212Zk1PMEd6YjlZL3hP?=
 =?utf-8?Q?SN7jHbuGcOM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXZYdm1uNXJnN2ZwYWhsOXhxVndIeHMyRzBQd0h1SWxRUUxWcmp1VWtYMjFI?=
 =?utf-8?B?Qy8vV1FQNFZZZURNdmVhazg0Rm1NWDBycnpqVTFCMW8zc1VXS0t3TzhzM1Z5?=
 =?utf-8?B?RmpzUk5iK2VyNm9LMUhVeWxJMHVxK2lwUnJERUpYKytjRDRmdWlJQlBydjBP?=
 =?utf-8?B?UDg2UXY3Q1RidDRndW5nNVByMkVlbEk4cWViLzk0VXhacG9GWXJrV0NrREFz?=
 =?utf-8?B?dnlpME00RmpTM0JMemRJZm5vN2VUVGs3MzUvSTA4eXpTdFp2ZXFWdmhadkpk?=
 =?utf-8?B?SlFrdllIZVlpU0NCQklDdCtXc2FjV2hyRWpRNU84TEdRN3JjdkdmUjRjT0JR?=
 =?utf-8?B?MExzTmQrTDl5d2NNd2JFOGFJT3ErVmJEZVlwQVkyMElreWtHMmV4SkRjdy9W?=
 =?utf-8?B?WGw5VUF2dVF3MW94MERaZklCN2Q0emFRbGkxUXdObFlZbWR6aittb2h0QXYv?=
 =?utf-8?B?ZHFaQzg5V3VJODZOVVo4N00rMGc2Q05NbEExR1hjSEs5bU5COTF4RGFsbG45?=
 =?utf-8?B?SUg4bWZvOTYyVjJCOWNLMVNhOU8rNEJFWmhReVZHc284alB6cmw5SVE4cUlq?=
 =?utf-8?B?K1NrNkZHRXFzQ2g5VUN3L3ZhZlBIU2g0ZSs3b2xkdUoyemVLOEdpWGkwSklr?=
 =?utf-8?B?K3JDSlZ5WlFFZkg1RlVianZENEFZa1QrbVRIeUxocXkremNUdUFtRHRPOURL?=
 =?utf-8?B?bHNOZTZrRFlFbzdzdjM5QnIyd21tL0FHZEdSb0Q0aHdMK3dHbkdaSTM3N0Q0?=
 =?utf-8?B?M0pRTzNpdS9YVFFSNHVjTjZONnVEcDVwWTl1c2F5empwTTNhYXIzUkRpNmNU?=
 =?utf-8?B?dGRQcy9aQkFBZFQ2RWpRQ29uMVF3QStpaTRUVFBKRjVvMGRhL0xyOU9qMGg4?=
 =?utf-8?B?NmNtS3FHKzB0QnNsRFgvT2JxTkVtYkNaU0lNbmY2SGtwZGFzWkJodXRCSlU2?=
 =?utf-8?B?VWExKzRoRjNnMTJQdVBkd29LdjVocTBTOHk5R1pEaXE2Qy9EeGRlcGdNbXEy?=
 =?utf-8?B?QmhEbGl4UWJKbHUxemFLZkpKZ2JrTnNBMjRGWHNhaWlTVTU3MDhmV3pSMHd3?=
 =?utf-8?B?YW1YaVFHdUFEV3hzbTQ3S0pHd3NlajFnSkpnczg3OUdoRlB5RVJrVDVEYUE1?=
 =?utf-8?B?SVhZWnlnYWFPbnVNTUxLY1FUZSttWm4xbFB4MlZtK3Irc0NicXRLcm9VUDRX?=
 =?utf-8?B?TWhXcTZ6WE1wSVJLQ2pSbE05WlQrNVVhbk80djVEY21NZGdFU29Wd3hEWW16?=
 =?utf-8?B?K0RKTkRKUTdaY01SMGV4UTBpZmR1SHV1ZzY1SWt5QmdiNGpzczhsaExYR2lS?=
 =?utf-8?B?VC8weGtKUnlrSWJWem5QeldpZ3NsS1ZTcU5nZzlocEFJMlR1Z0dYZkRlNlFK?=
 =?utf-8?B?Y3p5NTdoTWFUQjNad2tmczE3emtvQXE5WGhmc1hKdmdsdmJDNWlwMDRUb1Bm?=
 =?utf-8?B?Q0VWZjJNZkx6RnAzb0cvMFpZVWxnNkIzZTM1YW9uWFhNaWNSN2Uvc1NTeG8r?=
 =?utf-8?B?Qm5BcXZxMGYrWjZ1dCtyUmk5QVA2ODlNVDMzRDhxT0R5ckI4Rk1wamhmUXRD?=
 =?utf-8?B?cjBmaVRkRDZVRlpGZU9RZ1lQWU8vaHhnN3Z4djRCa0hNSWIzcmJMdnUrRkE4?=
 =?utf-8?B?L3BYTFVFL2dIYy9lOWhtK1NGWnNxSDVQa1pCMXY4ZEhrc3hXeEMzMmpKUGU3?=
 =?utf-8?B?b0pIWW1lUW8rVnMyMVNrRjNvWXIveFltc01uNEgrVFczNW5zUTVIb2NvdHRO?=
 =?utf-8?B?SmkwL00yeWo0WDZQOUdDWDU1cThsaHhPMmZnK2JFY1R1UUpVU3phaDZuT2R6?=
 =?utf-8?B?UkprWExlamFzaExmakc0WWFmZVY1R0l2eTQ2MTlnM29Lam8vZm5RSlFpZng3?=
 =?utf-8?B?K2k4ODBncVpBZzdsejJad2tHWWYySmljU2UzS0dCd2RTeXZWLzNTV25ibWUx?=
 =?utf-8?B?RjZseWZ6Y3JQdGFIQUpETW0xNkNGMXh3NFp5KzRSSWo4NTVvTzdyQnFCR0Q0?=
 =?utf-8?B?dlIyenhvQ0xoa3g4YUMxSnp2STNNRHlad0tHL0RzbkJVYWtQd2UvZ1FhOThP?=
 =?utf-8?B?RXFBUUNnRmw3ZE1iZS9tSm0zWjZZUGdWLzFIbm5DbEUxaVVnU0pwTjdMM3Vx?=
 =?utf-8?B?L0wvT25nZ1NDUUViVm9NWjJRQ0cwY3RuTjF1cmlSU1BNVWlOMXR0WGdDdlNa?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96c9fd8-1f66-4112-5a74-08ddf45da3a6
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:41:57.4221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ss23ogZodx+wO7Qcl+cSxwMcuNaOIsnkmk0k+zlNXEHR7EhENVJ5UbqxbWJxhPsidytQ0bYp7ZEYKPfIWapKfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3916
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

From: Jan Kiszka <jan.kiszka@siemens.com>

This was apparently not built for several years: Since a2535243e011,
optee_copy_fdt_nodes implicitly works against the U-Boot dt. We
therefore have to tweak its reference before using the function and
restore things afterwards.

If it had been built, actually trying it out would have failed next: We
need CONFIG_OPTEE_LIB to actually build the function that is primarily
being tested here. And we need to re-initialize target fdt, now that the
tests may run in random order.

Fixes: a2535243e011 ("lib: optee: migration optee_copy_fdt_nodes for OF_LIVE support")
Fixes: ba2feaf41435 ("test: Split optee tests into three functions")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 test/optee/Kconfig |  1 +
 test/optee/optee.c | 42 +++++++++++++++++++++++++++++++-----------
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/test/optee/Kconfig b/test/optee/Kconfig
index 63e2cbf79c7..ebf8d07c41c 100644
--- a/test/optee/Kconfig
+++ b/test/optee/Kconfig
@@ -1,6 +1,7 @@
 config UT_OPTEE
 	bool "Enable OP-TEE Unit Tests"
 	depends on OF_CONTROL && OPTEE
+	select OPTEE_LIB
 	default y
 	help
 	  This enables the 'ut optee' command which runs a series of unit
diff --git a/test/optee/optee.c b/test/optee/optee.c
index 658621fa2fa..7e1c8d04a11 100644
--- a/test/optee/optee.c
+++ b/test/optee/optee.c
@@ -5,16 +5,20 @@
 
 #include <command.h>
 #include <errno.h>
+#include <fdtdec.h>
 #include <fdt_support.h>
 #include <log.h>
 #include <malloc.h>
 #include <tee/optee.h>
+#include <asm/global_data.h>
 
 #include <linux/sizes.h>
 
 #include <test/ut.h>
 #include <test/optee.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 /* 4k ought to be enough for anybody */
 #define FDT_COPY_SIZE	(4 * SZ_1K)
 
@@ -40,14 +44,6 @@ static int optee_test_init(struct unit_test_state *uts)
 	if (!fdt)
 		return ret;
 
-	/*
-	 * Resize the FDT to 4k so that we have room to operate on
-	 *
-	 * (and relocate it since the memory might be mapped
-	 * read-only)
-	 */
-	ut_assertok(fdt_open_into(fdt_base, fdt, FDT_COPY_SIZE));
-
 	return 0;
 }
 OPTEE_TEST_INIT(optee_test_init, 0);
@@ -127,9 +123,21 @@ static int optee_fdt_protected_memory(struct unit_test_state *uts)
 static int optee_fdt_copy_empty(struct unit_test_state *uts)
 {
 	void *fdt_no_optee = &__dtb_test_optee_no_optee_begin;
+	const void *fdt_blob = gd->fdt_blob;
+
+	/*
+	 * Resize the FDT to 4k so that we have room to operate on
+	 *
+	 * (and relocate it since the memory might be mapped
+	 * read-only)
+	 */
+	ut_assertok(fdt_open_into(&__dtb_test_optee_base_begin, fdt,
+				  FDT_COPY_SIZE));
 
 	/* This should still run successfully */
-	ut_assertok(optee_copy_fdt_nodes(fdt_no_optee, fdt));
+	gd->fdt_blob = fdt_no_optee;
+	ut_assertok(optee_copy_fdt_nodes(fdt));
+	gd->fdt_blob = fdt_blob;
 
 	expect_success = false;
 	ut_assertok(optee_fdt_firmware(uts));
@@ -143,8 +151,14 @@ OPTEE_TEST(optee_fdt_copy_empty, 0);
 static int optee_fdt_copy_prefilled(struct unit_test_state *uts)
 {
 	void *fdt_optee = &__dtb_test_optee_optee_begin;
+	const void *fdt_blob = gd->fdt_blob;
 
-	ut_assertok(optee_copy_fdt_nodes(fdt_optee, fdt));
+	ut_assertok(fdt_open_into(&__dtb_test_optee_base_begin, fdt,
+				  FDT_COPY_SIZE));
+
+	gd->fdt_blob = fdt_optee;
+	ut_assertok(optee_copy_fdt_nodes(fdt));
+	gd->fdt_blob = fdt_blob;
 
 	expect_success = true;
 	ut_assertok(optee_fdt_firmware(uts));
@@ -158,9 +172,15 @@ OPTEE_TEST(optee_fdt_copy_prefilled, 0);
 static int optee_fdt_copy_already_filled(struct unit_test_state *uts)
 {
 	void *fdt_optee = &__dtb_test_optee_optee_begin;
+	const void *fdt_blob = gd->fdt_blob;
+
+	ut_assertok(fdt_open_into(&__dtb_test_optee_base_begin, fdt,
+				  FDT_COPY_SIZE));
 
 	ut_assertok(fdt_open_into(fdt_optee, fdt, FDT_COPY_SIZE));
-	ut_assertok(optee_copy_fdt_nodes(fdt_optee, fdt));
+	gd->fdt_blob = fdt_optee;
+	ut_assertok(optee_copy_fdt_nodes(fdt));
+	gd->fdt_blob = fdt_blob;
 
 	expect_success = true;
 	ut_assertok(optee_fdt_firmware(uts));
-- 
2.51.0

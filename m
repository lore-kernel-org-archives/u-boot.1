Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5CBD111A8
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 09:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB14783A64;
	Mon,  1 Dec 2025 10:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="HFxLc1M/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60C4383A8E; Mon,  1 Dec 2025 10:48:34 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A95B083A2B
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 10:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfVBqQtyYTgaRzEAFPb+WVAvQiPpjPekiAF2XXjdldla7UcAiyBYmCryQ2qUE60KBI2Umppv+Be48A2T2we8UgqXwUi4nAhfef1YMbzXjIipoycZ2D6Kt4l4FcLMTUa4eNBsdIMybONPO/77q1IxrVzY+zL5VZwRhYiI48gkz+Z7W6ZXV0o3DcMzVblpVw00nwdwimpP/wUX20c5CLELxsyDWVaDFM+KvfkssL3I3son4bofMm5S0RWRLXNc2Ygt+0YeO/g3N6+6yZHRU1x7MijYGeVrpBBSKQAmjp2AJzyhMCRHSbSz94yR4DCqPxxcXlHeZjs2+GmFrAQHjaQg3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlrendYijM7ZSUoPa3AF5Z8LNQHQJLuiqSkoOUFIwxU=;
 b=bksKxPMN0cAw/ZrK/ZxGreM7DgA+mUzdd9gxfvv7kD70q5eNTlceKtZYk9UfeeO3zTiYmEHymIEHYPZSQJcXXVNaodslAWfRdY7gWuNMKyOx53uIRgAHhFlSUzRzUgNZ3CbEGgX89EUyzMEStBgT2OWyPKf7wm44O9qq7LWHY/mSa7TpekAneel5IlXOlVgTaaU9CMav1rD5SyF5OPfaB6vOQBY9z5Dr4iPEFLU5i2QQZZDVJr91UZv7SfXx9q/w0adkXa9Vo18SQl+fmCsb0W34M3RkkE+rOShf4/Y3YKoZooN8t1Ku93NGLmGywUWx07Nsq9oULFgDNRKGwo8RWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlrendYijM7ZSUoPa3AF5Z8LNQHQJLuiqSkoOUFIwxU=;
 b=HFxLc1M/kEf/fzPAT5GUU5rinKpTg8MLPZ1M5ZBXH/cRqlBon3AD3P8CTxAPjl+FtZZLN+yzMQ6HJ9vIw4aoDY/R+UbhSMx3BbNEilZ/bCbyIWdTlJRKCWl7E/zIfQ63VJ/AArnt8OYkvLoaegHnFLHlnKgQRatAK0BxG12r/yU/BvxF1nf/qt8E6jI03oKJiRTkNpOZ1uO9tgAEXk+fw0ShlSxqi9LoXw4Xx0C8u2qTh6ThEEqM9Ng7N1tFX8lLJi1wNvHCvg8c2+sjgLOzai2Wmn7d9Bzusk2GqZa/EW51WpUkXeNmsXkHaCn+OdBzX86ZmlbvnxE1iwpXgx4HNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by FRWPR10MB9506.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1b2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 09:48:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 09:48:28 +0000
Message-ID: <f9f6a5e1-266f-4814-9fef-fe39782a36f7@siemens.com>
Date: Mon, 1 Dec 2025 10:48:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch: arm: mach-socfpga: Fix non-Agilex targets
To: "Chee, Tien Fong" <tienfong.chee@altera.com>, Marek Vasut
 <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sune Brian <briansune@gmail.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
References: <99585fee-dd5d-4f9f-aa88-0ee34fe02181@siemens.com>
 <3682cf96-0cca-45ce-92ae-9fc33345e3ee@altera.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <3682cf96-0cca-45ce-92ae-9fc33345e3ee@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|FRWPR10MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: e167e6e7-e8e0-476a-3bdb-08de30bec787
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEk1UXkxZ0xpZ1oweG41MC9JVzUxcGwzRzl3dVpSN0VNajN1ZUdITVhJbkxs?=
 =?utf-8?B?N0ZYRXFmNS9RUnMvUmloTnp6bWQrMmVabGxIczE4SUwwWGp3MDQ5TlFRNnZU?=
 =?utf-8?B?U3RrU0s2RjVpVlZobHZlQnF4TTY2ajF1dUVRTzcweDVta3dlSGNRZGx0SkNy?=
 =?utf-8?B?TFg4aWZDV2tUZ0pZazd5QjFLK3FlY0RVMGJzaEF5WVdZd1FrRkxNNXltaWxI?=
 =?utf-8?B?OE1PRnh4SXBrRG0yVlkyVGxvcXk0UzIwOHlXRU1wQ0svL1Q2V3hLb0hNaUlz?=
 =?utf-8?B?TWJuNmtSUXg3bGovQkRVQTRLL3B6VmJDeWpVK3VXTGNCVXBXZ1dVVFZoVytT?=
 =?utf-8?B?bEd0UTAzTWxVaVk1TklzUEFKK0lvMUJBaHR1RkFzNUJDdVRWU29vaGZtWTI4?=
 =?utf-8?B?akxMSitRN2dkRU9tMElRa25PMzVPdnczQmNFbGRkZ0YrTkhiOUNVVVNzWS9v?=
 =?utf-8?B?RHRZNFNqK0dwR2FkQTlMdUpjdnRack00SVp6WWJzdi83TzFhM1NWMloxREx1?=
 =?utf-8?B?ZjBGZTlzRDg3TFZxR0pHek9tQllGaXdaS1hEa0xneGtiMzRmb2dNWFJsQUU1?=
 =?utf-8?B?Q1IzYllFNkVyUHdrbW9yVHdFcFFhUDZ0TmNmODBmd0s1aDB2bENiTU9xVlJv?=
 =?utf-8?B?Y28wSkI4Z1l6aERnVzFmT3Rudzk1QzIvakNTTTUzSk5hR0l2VFhXQzkzcFZm?=
 =?utf-8?B?R0hibVlYUDFmVS9BOGtDZ0FhN2NJdDNsVWpiTzFQM21DVVlmQ0RsMVNGVmtY?=
 =?utf-8?B?TEdkc0luVHdWNm9DMG9vYmgxT1I4Rm1leXN5b09VYWFHbHk5QVgwTlpja1A5?=
 =?utf-8?B?OThxK3ZzQ2M5cUNxbG9SaW5JQmZFOWtmeERKQjVEMFpNbjJUTWc2MlVGRjNL?=
 =?utf-8?B?RmxBUG91VUNUcUUweEROcW5NMEc4eFlSY1VhRG1Hc2pJWlE0K0MrSEI5ZHhy?=
 =?utf-8?B?NE1WNHhrclZqQ1VlV0xMeEQreXUxREZ5RmROMUpYdGNkb1pvYVhRendHc0Ru?=
 =?utf-8?B?RWd6aWhlaU5jQnpaSDRkYmtTVTFHTi9zVEVmalVYcmNHZS96ekZlYlBCZmtn?=
 =?utf-8?B?NHA1MjBWSkJYdE5hdGs1ZDE0Rll4OHVSRktuMjB2YlpYSmJpejdxejZQcVht?=
 =?utf-8?B?VExxNys2S3JMR2g1eFJ1YUFSS0t5UHB6VFMwR0k5Y1NpMXczcWpJTE5DM2RQ?=
 =?utf-8?B?RkpVYWlDVDVNSkJiOGozNUs2RmM3N3hNK1R0eVZuUW1YS2hPVVAwV1ZteXps?=
 =?utf-8?B?M2V3MkxJZGN6YlZlOTIxZ2IyTVpneVNrMEdsRUdzdzFxRkZ1VXg1UHB3cC9H?=
 =?utf-8?B?YXc1aFhmNWdFUjlheTJaSCtVY1dCTGhkTVl6S3pOWm4veVdrc0NUV1JMejYr?=
 =?utf-8?B?MU5Zb1o5cEpiODNmL2NRS211cWlJQ1lscC9FMnhOUUJ5dDJhMkdaaEpsa3l4?=
 =?utf-8?B?azkrYi9iVG1zRjZ3VE9HeVN5RlpoQUY5WmtHdVB0Rm5vVElIaUN2czVsbml0?=
 =?utf-8?B?V253THlZejhJMjRIdUF1Zkt4V1JUL0d4WjVEV0g1WmwvZmtFRlFLOEtoNjJn?=
 =?utf-8?B?QWdJS0VKTmlwanlUS2g4YXFqNkJ0cnBPdTZPZ1ZCbDRjdjBPYXJ5anFSb3cw?=
 =?utf-8?B?TkZIV00vaThuUFFVdWtrV1FrQ1puYXB3NEhFMmVybjdLVGJwZlUyN2NwVTRs?=
 =?utf-8?B?QmhEZEk5M0p4djBSTFJBTUpwc1pnOHlUcjZkemZyU1J6L3ZZZXpXK1JuY3p0?=
 =?utf-8?B?MU52Wi9YTTdBVG5PVzFLSEdyQnROTFRZNlhjb3JFUmthc0NLTnlUMlRTL0RZ?=
 =?utf-8?B?NXdCV2ozcVBXaTMxRkhjQVZJZlM1QTViaUhKeGlacWRmK1RvS0hqN29ud241?=
 =?utf-8?B?Y2FXSTNKMjg0Nm52OFpwVmYyVU84QlBXRDdZcHlqS0xGVGx2TUxLQm9XREhL?=
 =?utf-8?B?cXlaR3J6ek5XT3FsOWk3elhvckNLaGVJaldMWklBZm5ZNVpWdmZEM28yeGNB?=
 =?utf-8?B?WmR4V21Qd2xnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L21pZGRieXVaSmdXYURRdmlxNmUxSHlBOVJsY2I0RXVYVjdQa2VBTmlNSTNT?=
 =?utf-8?B?VENqRSsyNlVLTTZId0JhODd3aWR3Rk1IUm5pdzFISWxrWXR3UFlsa3krR0Fa?=
 =?utf-8?B?SmsydE9TT2N3L3Fka1BUdU1xZmdic0FsSERNbjVyYTF2amhDMGp1eHpUTy9v?=
 =?utf-8?B?NkU5NEZSZXh1LytVYi9rYWdMTndMSnpscGNSMGZDYnRhN1UvTG85OTR3MG9Y?=
 =?utf-8?B?c2tWYytmNEpZUENuVTVkM1EyMFNORlZwQ2ZhTDNqb2RPbklxbXZuZFVhL1hT?=
 =?utf-8?B?WG1xeENnTTE4UzlhYnhhWjlrb0xWMWUzL1c5K3MvSGxnY2VVMkl4Unk2aXFl?=
 =?utf-8?B?dnBsSC8xdVIzRWpxNi9Ub0pQeUZuT2I3bXp4R05Wd0ZIdU1vdTU5bjU4K1B6?=
 =?utf-8?B?RnVWUHUzVm1xbmJjNmJGUWhGM29DK0plOGhZUWRodHFzTkVyQXFyancwcFEw?=
 =?utf-8?B?bHlKbjllczV2TnliMGFsTlY3c3llRmhFbTF6VzZ1ZjVEZGNpWGs2UmtSdzcr?=
 =?utf-8?B?cXJ2dzRONEpqU2E2cm1zbU83VVliTk8rektQKzMzSFQ5VlhXUjNCSE9DR0dC?=
 =?utf-8?B?eVM1eWpWQ1FUTHhWcU1ubHJXd0xsaVJFU2FOZWQxWmZTNmJnYWxaL21jTm9D?=
 =?utf-8?B?Z3c2K0RrYmdySUcrQ1pYM2RUUlJoL1l0Zys1MGhabU5xbWZ3ZDZyS1o5YWoy?=
 =?utf-8?B?cGFieVpOaWF5Q0g3U2VxMXk1alJVUVozZktab0ZQOUg0aW85ajh4WjYzNCty?=
 =?utf-8?B?ZTF2MFFKKzVKb3hqSGhvM0JjbC8yNWRaRG5ZekhIalN6M0FGQU1UNnJtQm1m?=
 =?utf-8?B?N1F0OWR4VnZrN2xYRnV2TzJVRUMvZEdDM0lRZHgrUURhWjF3Z2lodHFXOWNr?=
 =?utf-8?B?VkVLNHFVZGxMUDdKN1MvVGdPL3RnVFRuMWZIa1VMc1RMQ0hFVHU4TnVOc2Zj?=
 =?utf-8?B?cXIyKzJkdEhWbG4rWCtvaHArVUxwcXZ6SlNHU29TYWNmK2xmdVhPNzl5b3NZ?=
 =?utf-8?B?NlBaeXV2U1g1T0w1UWFoRDlVdGxjOEFVbnk0NWdZRXh5Vk41bFl2Vmp3VkE4?=
 =?utf-8?B?S0tTZ3h5QkVIUTliOXB2WDZ0Rk1SSFdGNDdxbm5vek0raGJhZ25Qd2lrWm5s?=
 =?utf-8?B?WmpPbUk5bFp1MEwvSVpuODNaRnNWVTk1ZlNNeUw0Y1RLeFhzWE9pZUc3ZjRx?=
 =?utf-8?B?cXpDZzBlSk5yekg2RldQTVRhKzQ4c0lKNTZjWjlIeDNlL3ZWeXFycFlnR09N?=
 =?utf-8?B?SXBjak90R3UzOHpDeTllSXplaGZRRnM1Wm55R2d4N3F1ZUxUZ1dCS1hrU2ZP?=
 =?utf-8?B?SmZ3dWtwbVB5Z2d4NlZJT1piZDV6NVVnYmZTajVEZUIyNGUxNE5RYmQ2WEpG?=
 =?utf-8?B?U05CRVRCZ25NcytOeDdKUG01T1pVd0ErWkZDNzBvWXFiaCt3Q2hpR3VkeFp6?=
 =?utf-8?B?VFdsa1pNSmgzMkZiNndHZWRSRURrSmROQnFmelBZa3JkR1F1Z2VJdVJvQ2Z4?=
 =?utf-8?B?aVR6RXRtNFFubjI3K1BLcktOM280aWZEZUVLcEJHV1ZQK044YXNNMmdwOE1W?=
 =?utf-8?B?cFZldk9pMEozNU5QMjVaMUFTeU9sRXBRa0tzbWxmdVg3OGM5bkJMM1ZReGxw?=
 =?utf-8?B?T3lVMTEwTFJNcGd6S3VZZlNhazdsem8xRlNXeHlWZWI2TXA3RitTYjlDNDkr?=
 =?utf-8?B?Q0RXZDFTV1RTSkZ5bnh0NUU3cUc5SFU5NUIxVElVTFdXeVpHQmZ3S0pIcW9D?=
 =?utf-8?B?SzBXUVFHR0JUR0J3VC90VWwwSlM1bzlXM3cxNUdkY2V3c2ZlYWpuUEliZHFD?=
 =?utf-8?B?VllJOFZhRFpIK3BXcTc1S0JjT3NBNHc1Q3ZsTk1SbGFSSzJhQm4zeWUreGtw?=
 =?utf-8?B?SFZlWk9mSWJhUzlENGNKR3RGNEpiVGdaWVN2bEJZVHlPaktqekRueXBNK3Jr?=
 =?utf-8?B?c3lZUFMvMVU1WmVSazlsN1AxN1JBUUFSengxYlhLSjZsdU1STDh4QWsyZG5o?=
 =?utf-8?B?ZFM5UWN3NGtKSEFvakdvMTlVRFREbjBSVHFPZ0ZDK3JYRnk1NEYzcmZPNUIy?=
 =?utf-8?B?SmRtVmU4Z0V6cVNOczlEVFBSV1Z1aTc1aWx3UGtyVGVvKzR4YStVWGZjcTBl?=
 =?utf-8?B?bTNOMzJ1MmZsM0NnYXhFYk9Ub2ZGMjR4dnV1MUhiMVpZWFdqTnB5Tkl6bUZT?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e167e6e7-e8e0-476a-3bdb-08de30bec787
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 09:48:28.6412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odNEnyZ+oL6jwqYkEpWl4pTO6O7tCXEyx4itUZLwIAJA3sccZa4b90f+QYhQ3sS31hX6sDYzZnORzP1NTfWEbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9506
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

On 25.11.25 04:31, Chee, Tien Fong wrote:
> Hi Jan,
> 
> On 14/11/2025 8:07 pm, Jan Kiszka wrote:
>> [CAUTION: This email is from outside your organization. Unless you
>> trust the sender, do not click on links or open attachments as it may
>> be a fraudulent email attempting to steal your information and/or
>> compromise your computer.]
>>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The Altera system manager device is only provided for the Agilex
>> targets. All others were left with an uninitialized socfpga_sysmgr_base
>> after that refactoring, breaking any boot attempts already in SPL.
>>
>> Tested only on Cyclone5 / DE0-Nano-SoC.
>>
>> Fixes: 35638172f99a ("arm: socfpga: agilex5: Add new driver model for
>> system manager in Agilex5")
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   arch/arm/mach-socfpga/misc.c     | 7 +++++++
>>   arch/arm/mach-socfpga/spl_a10.c  | 1 +
>>   arch/arm/mach-socfpga/spl_gen5.c | 1 +
>>   arch/arm/mach-socfpga/spl_n5x.c  | 1 +
>>   arch/arm/mach-socfpga/spl_s10.c  | 1 +
>>   5 files changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
>> index 76747c2196a..f859d54dce4 100644
>> --- a/arch/arm/mach-socfpga/misc.c
>> +++ b/arch/arm/mach-socfpga/misc.c
>> @@ -277,6 +277,8 @@ void socfpga_get_managers_addr(void)
>>   void socfpga_get_sys_mgr_addr(void)
>>   {
>>          int ret;
>> +#if defined(CONFIG_TARGET_SOCFPGA_AGILEX) || \
>> +    defined(TARGET_SOCFPGA_AGILEX7M) || defined(TARGET_SOCFPGA_AGILEX5)
>>          struct udevice *dev;
>>
>>          ofnode node = ofnode_get_aliases_node("sysmgr");
>> @@ -293,6 +295,11 @@ void socfpga_get_sys_mgr_addr(void)
>>          } else {
>>                  socfpga_sysmgr_base = (phys_addr_t)dev_read_addr(dev);
>>          }
>> +#else
>> +       ret = socfpga_get_base_addr("altr,sys-mgr",
>> &socfpga_sysmgr_base);
>> +       if (ret)
>> +               hang();
>> +#endif
>>   }
>>
>>   phys_addr_t socfpga_get_rstmgr_addr(void)
>> diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/
>> spl_a10.c
>> index c20376f7f8e..26828077c51 100644
>> --- a/arch/arm/mach-socfpga/spl_a10.c
>> +++ b/arch/arm/mach-socfpga/spl_a10.c
>> @@ -250,6 +250,7 @@ void board_init_f(ulong dummy)
>>          if (spl_early_init())
>>                  hang();
>>
>> +       socfpga_get_sys_mgr_addr();
>>          socfpga_get_managers_addr();
>>
>>          dcache_disable();
>> diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/
>> spl_gen5.c
>> index df79cfe0f7f..f1c654e1566 100644
>> --- a/arch/arm/mach-socfpga/spl_gen5.c
>> +++ b/arch/arm/mach-socfpga/spl_gen5.c
>> @@ -72,6 +72,7 @@ void board_init_f(ulong dummy)
>>          if (ret)
>>                  hang();
>>
>> +       socfpga_get_sys_mgr_addr();
>>          socfpga_get_managers_addr();
>>
>>          /*
>> diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/
>> spl_n5x.c
>> index 81283ef7162..ed4e6f38b31 100644
>> --- a/arch/arm/mach-socfpga/spl_n5x.c
>> +++ b/arch/arm/mach-socfpga/spl_n5x.c
>> @@ -31,6 +31,7 @@ void board_init_f(ulong dummy)
>>          if (ret)
>>                  hang();
>>
>> +       socfpga_get_sys_mgr_addr();
>>          socfpga_get_managers_addr();
>>
>>          /* Ensure watchdog is paused when debugging is happening */
>> diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/
>> spl_s10.c
>> index fa83ff96adc..460a6f88416 100644
>> --- a/arch/arm/mach-socfpga/spl_s10.c
>> +++ b/arch/arm/mach-socfpga/spl_s10.c
>> @@ -33,6 +33,7 @@ void board_init_f(ulong dummy)
>>          if (ret)
>>                  hang();
>>
>> +       socfpga_get_sys_mgr_addr();
>>          socfpga_get_managers_addr();
>>
>>          /* Ensure watchdog is paused when debugging is happening */
> 
> Thanks for the quick fix. I’ve reviewed your patch along with Brian’s fix
> (https://patchwork.ozlabs.org/project/uboot/patch/20251114160423.1518-1-
> briansune@gmail.com/).
> 
> Both address the same issue, but Brian’s approach keeps the change local
> to misc.c and avoids spreading SoC specific conditionals into SPL paths,
> which fits better with the ongoing DM migration.
> 
> Functionally they both work, but Brian’s version looks cleaner for long-
> term maintenance.
> 
> 
> Could you take a look at Brian’s patch as well and let us know if you
> see any issues or corner cases we might have missed?
> 

Sorry, think I forgot to reply back than: The difference is that my
patch already prepares for having a driver model for the other boards as
well, establishing that socfpga_get_sys_mgr_addr sets the address, only
catching the differences in that function. That looks more invasive but
should be design-wise in line with what you want to achieve, at least
mid to long-term.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

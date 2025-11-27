Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA6BCFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 06:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4330842E6;
	Thu, 27 Nov 2025 07:37:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="yAbQRHal";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76330842E7; Thu, 27 Nov 2025 07:37:19 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A6E5842DF
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 07:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgyoHyiqA2RJHdjcUlcTrxHGIkdFNIcTSHXpQaEKTSZlUGBvM7PHF+p8aD+YRUii4iswjpqunoeqdvPYX59PNY+RKXZut+2pnzgXwLhP9qudp/lhDz4ILT0sfeQYi1lEXd/1KiGbQ6oMO15VhB89n6s+rNcBohuEVLMx26maECIOvHW6vyHzVJb71ltkhpr8jkcZZiRwk+Nxk4KrDKbYH0y5BruKCZBvVRfCIi6nND7S/I0ySVCKnnTwnII/Qk7O0JlJgYfXTwH08dDyVp0KWtVhj/dgCVzlJB5hGPVhWf5y4TYtqvo5dJy4Cwv3U4LdDoO/hOuIQ47Uv0kuJWzsyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUYe34Lfyipxypun/BonC3Rz7ugzsLID4dBxVAvOGd8=;
 b=Sa9l7ygNas81NodWmbew+K/WbZEYWQ5A3Yqo+AkMwaRZD5OjcqOO0zqW53zyDEjwJXrZGa7G0H9GRniA+YKsqsoO6ueGWrpdnhvjeZ8BM/9Be/JHmDOjqZiQAH/SBB3J4ML0aoUep08ALvyaX7yxpm4mO4HiNPkW2cjIr+pobYYklwPOMY8ADaSZtLjkszyfbqU8qCBsfVxDNcEEixhYlA7QrCo+Ii2Su/viPZZRk1SrmisBs4gixHn1KiM0Xk0JfGb/M2j0H2tIblBQMdtL6/Y1dwHJN3zt7mjbLIyvYbDchwU6kW+oApuD/OVrYRqto0i0+fM7LdNcwjO5qQ+9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUYe34Lfyipxypun/BonC3Rz7ugzsLID4dBxVAvOGd8=;
 b=yAbQRHalqqfj6A20D3mE9N8KXo8KJDHMWU+oDQz4Q/wDDjPFv61dYVDAtI229XrRY8mZ7b1pXfMLrWGEE36bF4IpL658ShvuLQlt7bhn6EShjcLZTipPSnzP7nOozY9FZEB0qYbaW4pKrLJZnFSeZXN06Zs3OeCeJwWgiONZZeCkVl8o84/OCg0CmNd35XGGmwPxbFmQ0a1DK2+Uo01QOguu8H5ve/jk8AJALQyyWWkYMHEh5NBXp4KVS05gS+XkXlbbcrpdcJOeFtjeOsg8sAXkyp/6SIT72zvphS/rLVmIFqEo34VMofn63syA0PU5TC58VxtEGnfKwYMQAddEYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6875.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:464::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 06:37:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 06:37:13 +0000
Message-ID: <dbe16e20-ae32-441e-b987-6cb5feaeeb93@siemens.com>
Date: Thu, 27 Nov 2025 07:37:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/8] configs: cyclone5: Enable SPL FAT support
To: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Brian Sune <briansune@gmail.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-7-alif.zakuan.yuslaimi@altera.com>
 <896ecbf4-d85b-4c09-b8d0-9730be370673@siemens.com>
 <e2f1c154-573e-4326-ae8c-ee9ded46c71d@altera.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e2f1c154-573e-4326-ae8c-ee9ded46c71d@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b544b7b-1032-4ca2-b878-08de2d7f667b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U01RM0FuUFVrSEdSQ00wVFdhS0FXRldXYXZYZlhFbm0xZHJkenVtM0tJczhS?=
 =?utf-8?B?anRWdld3UzF4dzN5dTZhQVBlNjFQU0RrWG1IVnZRaFVWVVR5N3l2ZDVuZ2NL?=
 =?utf-8?B?Q0djSXlLYm1HWldIVldjTHBpVHI3NmtQVkZwdHpTQzdWQTQ4UnJidGxndXRG?=
 =?utf-8?B?d2VWTFlSaTB1Y2l0Nk1lWGZQWGtqVUtkSW9UQlNqUzV5ZGlkZ2Ridmc3VERZ?=
 =?utf-8?B?V2gzRURSODZzK0pqdDROOWFDSnJrZlVsL3EvWWlrMlZ0dkVTcHJVdFFHSUg1?=
 =?utf-8?B?RStTRWk0YVlPUHNTVStlYXMvWE1kbWlwQVZiQ29RM0E3UGVZR3NHYnVFWWhP?=
 =?utf-8?B?QnVFUENUT3BqUFJLTlM4NU9wUUI1REpaSi82MmVYcWl2OEp4VXE0aEh0WjRU?=
 =?utf-8?B?dG1Rb0ZZOWwvYXJZYXl6NEttZTJwYitXWllmbFlXK3d6a2h5czBOVzhwWXNn?=
 =?utf-8?B?Q0o4MW0zKy9KUVliWm5Sa1FHTVFuRWo2REVaUXJkbHRWanlHZU91ZmU0YUR0?=
 =?utf-8?B?OWpDTlRGT1dmWEFxc3h2aEpEZDZqZWgvMnRhZDlMUE02VWFoSVBWamg4emNj?=
 =?utf-8?B?WFR3VEpvTjgxWjJXL2VkejZxaE0wNlNlMVlCekxIcGF6YVJnNGpwM3AwNUF6?=
 =?utf-8?B?RVRBQkV0d2FmRmIzV21OT1FVRDN5RThoNmRLVk0wbUN5KytsQkF1Sy9jOGNK?=
 =?utf-8?B?Yzl4NTBhREJWRjZISVBaNUJVZjRHWVVoZmlwNjBFOXNjSUtjeFc1OFM0ek9D?=
 =?utf-8?B?U3JsdUcrdTVkb2ZkSkQybXhRVFBsQ0dla0UrM254dXRJNWNjY2hRNU4ya0t3?=
 =?utf-8?B?cnc2UWRZdFFvREptc3RFS09kS3lXTlZqL1VRekdhd1NQLzRjL2xKaVI3UXVJ?=
 =?utf-8?B?cWo4UHF5UWRQY3l6YWVHQSs3U2VoaldBdWpZbUFTR3ZwSWljd1lLS0UrTzZ0?=
 =?utf-8?B?WEZwZm9IYmphejE3ZHUwR0NnRWJ2UkRCZmloSXlrOUVBNjEvUDhMaHhGSFFS?=
 =?utf-8?B?QkFndWg1N0JqaFJHcVIzNUZ6L2M0ZWtCcStKRUI5a2p2L29MUmFpRS82dzRh?=
 =?utf-8?B?RUVwUVhqNFhFTC9ENDdmdXQ1OGVuSWxUMThsTnBKRXp5RFAzM1BFUUNsc01l?=
 =?utf-8?B?WFJvVVF1US9JRFJ5eXkxVUt6NDFGYi8rWnVabGNrY0dMRmhwK2tjSG5tbWlR?=
 =?utf-8?B?VE1BYjhRWWVZc01RSE40S1dKeFJGY2t5eVd0STRONWttSzVodjFDTDdYQWlN?=
 =?utf-8?B?YklPblhwSXB2VGViMTdtSzZkUVJCdWxqdDVFVHYyQVJwSjhqWktES2toeVlJ?=
 =?utf-8?B?SnMyd2FUcVZLS2hDL2MrSUFKTzJZV2FBZGZSZVBzVmRnVC9pWjYzU1d0SWgr?=
 =?utf-8?B?OVBaSC9Fd25sdndmUlJiOW9tMGg2emNFRmJLN05KVUNZWEdEak4vWEpsZ0Rv?=
 =?utf-8?B?TzhsdGlHL2h0MmtuSU1CMkZOOGNSZ1ROa000dGRITzZrWGtPcEt1UGwxdU0w?=
 =?utf-8?B?QlAvQmozZFpORzNrUk5KcncwSGZtOUhPYW0yOGV5T0FtSDRyaEs0eGlPcmw3?=
 =?utf-8?B?dWk2MVAxbDE5dllYUDUyUmUxdzBhOExBSzkwaVN0NDZ2UlFGcDkxOEtLWUFs?=
 =?utf-8?B?NXZCdGNMR2dGWUk0RFF1RFJMY25QeURocUh3OG9taXF1T2RBT1B2bkdaanRs?=
 =?utf-8?B?NFVUUUxVNTJJdUVYZDZKRSs3T2I1SitMNVhsWm44Vm93K0tobHdpNUxvQ2ZC?=
 =?utf-8?B?eHg2NVpKb2FkTHJpMVZrL3dqSzdyeDhCclR6VTY4d1U5VDlPTWlrdlpaYmcx?=
 =?utf-8?B?bUVhL3FiQ1VIWEZEeXorcERXY290OG4xZC9xcW9Xb1l0UlpiYitpUHVKWU1l?=
 =?utf-8?B?amg0TkJvYldyRGhzRi9jOFphTk4rcmI5dWg0bTBaelpnZngva1lxc0RNVzZh?=
 =?utf-8?Q?uEjsjU+b7EhEAYhgqgsRD/WEb1mM9Ia5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWkzaUFBd1FGM2czUVhhS0ZqTlo5dXNQUzV4d1Z4dVpyRmdKUklLZE1Qd1F5?=
 =?utf-8?B?a2ZPT0wrenZEcWxZU25lK3o3RGZYMmZyTUZGa0NSdlZBcEFhZ1VmeXhYbjE5?=
 =?utf-8?B?YjdxNW1uZkY2TTZ1RXpScDc2Z2RzUWxoOVdTcHpXT3E2dE94eEtIS0RsclBS?=
 =?utf-8?B?Tm1TWSt0MW16ZUpJWHlZV01FUGpuUURMa1lIb0Fsaks3ZXIrb3R6NXpoZTQ0?=
 =?utf-8?B?TlR6bVlRZktwK0VqbTBuTkJ4SHg0WTMvM2wwSmxRUnM0UkpiazcvQXkxTVh1?=
 =?utf-8?B?ZWVOREJtMHN4Z0NCWUNjU2hEU2g2b3RjcS81NEFEeVVPazdlVzQ1bkdzaDlj?=
 =?utf-8?B?TjRuK2NKS3d2TUhYVHB1MG1Ic3lpZmFkVFF6V2FaaGF6T2IzeU4yK0ovT2Nu?=
 =?utf-8?B?dHpqcVNNWXpnL2RIc2d6OUVpUUJyQ0pRVC9iZ0RDQWJRT2tiUjQ5bUFsZjkx?=
 =?utf-8?B?NE5HNTBsQ1lIYWdFeGdkRDVWMkNQRDcyS3BtRWFSc1hoMEtzNllaSTBldHli?=
 =?utf-8?B?L0NMWVZVQUlNQTNFbW1PY28xVlR6M3J6VzY4M3liQWhpWjU1OWU5NnFPL2Ja?=
 =?utf-8?B?WVRsdHBDWEw1RjhIQ3J1VWdxL0RML3pMWnFaeWkwWEErb3ZpZ3k4YXZhWWtK?=
 =?utf-8?B?YXBRVkt2RHloLytJcVg3bmt4WHZ1d1pXNWR5L3R3MHdZZEJaNERwbWFaZWFQ?=
 =?utf-8?B?a3E1dUkwVCs0SlJRY3Bnb0RQdUZJRktjUWtacDZER2d3aS9JQnJwRHBLSHoy?=
 =?utf-8?B?c083Ymg1VzFhVWFLY3lRdUdqSzhod3JFeDIrRzRIeTdNdUJEdjBkNDlTZ2pl?=
 =?utf-8?B?SVdmMmZ2OXQ4OE11Z29aSzFvVXZUYmhPTkRwRjErRUkrMlRXZUVTRFJ3b0xP?=
 =?utf-8?B?SkVmZDdDb2IvYU9VUXgwZmU4anMzbCt3Q3QzZ1BGelBaRnU3dnQxcXJIQ1BR?=
 =?utf-8?B?RmE0algvNGVYMmEva3BrQ3p6bHFuMkM4R3BScHArVkN2bVJmZlVXcXJIbmpV?=
 =?utf-8?B?Sk5XbTNQdmV2REVTc0M2MnlIcko0V094RnVVTHBtVHVtOE8zMHR0V1RXQkZB?=
 =?utf-8?B?QzRZaFhxdG1kbUY0YjVZSFlwZVcrM0VEQW9xQnp2UllDQ1JTbW5pTXZQa0Ez?=
 =?utf-8?B?Z0NFc1JnRkV5K1EybXNrOEkxRHE3Zk00SmtPTG5iQ3B3VVBKWEJiMWtDbnMr?=
 =?utf-8?B?Q2xUeEN5SG12b3RpODVJaWovSVViSHQwTEloUUlidjJyeGFsTW92NUxoZHd2?=
 =?utf-8?B?d0lMcVNmSzY1NE9BTVgwakZicGZZTk5LNURlSEU5a0NVYVN1b3FkWmpDeEVE?=
 =?utf-8?B?dWphSXNXdFYzSi9ocGJ6QS9EUEdPODErR0RGVS8xNFlEQ21xMjR2ZXF5M2JV?=
 =?utf-8?B?YmVHclVKVGRtL1FuTC9lS3RjbjRYVU0xVDlIb0dEa3o4OUpUK3UyN2VyZU9a?=
 =?utf-8?B?WmtlQ01OVFMrRGlOdnN0cWFXZ2NXallScmZpU0NhbyttRzBOaExXemRscUl0?=
 =?utf-8?B?YjR1bEQ0cnd5dEY1MXJUbmd5Vi9HL2F4RSs5ZFR4RzhwQVFiVWsrNjhEdkVZ?=
 =?utf-8?B?L3o1RFVZRzRSSDFvVGUrZCtLWEpCZUpOV3g4dnByQXlMeFhvS0x1TW1kbyt5?=
 =?utf-8?B?RkorRElWT1Q4dWNXWUxzUDNRd0dPNVlSSDJmd05hc3JRb2hHbzUvZkQrcmpR?=
 =?utf-8?B?OE5xZWZ0emdkUmdRd3RtbURJU3RpaGFMYjJFeTJTN1l0ajUvMDIxR3lXUmpX?=
 =?utf-8?B?V3lLamhrLzNPeGZzY0gzcFpzd3NFOUxCSXN1djBiZ01kdnFtaTB6ekMzNXRY?=
 =?utf-8?B?NENIbDVnUGxxTG45T253NTFycnpIL3BWQU1jMldOeDcvMThKTjFicFJDRTYw?=
 =?utf-8?B?NDhSQVhUbFhUSXJPUEVwVTNTR1F5blZaKytCb2hCREdIZ0JkcnlEdmlTYlNS?=
 =?utf-8?B?V3JLUlM0NHFpZjRHa0E1ZHEwa2NUdFNnK0dOR1F2QS96ejdXTFRTYXZrZUsz?=
 =?utf-8?B?NXZvTnpZUUovQXhkVlpaS1c1TlRXNTd5cmU2QnRrejlVWTNvZFZkSkcvdTY4?=
 =?utf-8?B?WFZKTHYvV1FuZlZBcHJiOTZWTkxwS1ZFQUpHTU1UZzdJbU11ZWVjdnU5TUpR?=
 =?utf-8?Q?R3EfGhD9NPsuhFkFEV8wRp/+N?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b544b7b-1032-4ca2-b878-08de2d7f667b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 06:37:13.8248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEK4XEcfLU9/w3BQixo5inwjoRFhSrQOrfHrUCS14lef6uDGwvG3tD5SaKnKZQxjoKDRH5Q7S+dE42Hf6PRoQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6875
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

On 27.11.25 05:32, Chee, Tien Fong wrote:
> Hi Jan,
> 
> On 25/11/2025 5:41 pm, Jan Kiszka wrote:
>> [CAUTION: This email is from outside your organization. Unless you
>> trust the sender, do not click on links or open attachments as it may
>> be a fraudulent email attempting to steal your information and/or
>> compromise your computer.]
>>
>> On 25.11.25 09:13, alif.zakuan.yuslaimi@altera.com wrote:
>>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>>
>>> Enable support for FAT filesystem with SPL for CycloneV instead of raw
>>> mode.
>>>
>>> Recent changes breaks CycloneV MMC boot from raw mode, and so we are
>>> taking
>>> this opportunity to migrate MMC boot mode to FAT as smaller OCRAM
>>> size is
>>> required, as well as aligning MMC boot flow with our other devices.
>>>
>>> Fixes: 2a00d73d081a1 ("spl: mmc: Try to clean up raw-mode options")
>>>
>>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>> ---
>>>   configs/socfpga_cyclone5_defconfig | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/configs/socfpga_cyclone5_defconfig b/configs/
>>> socfpga_cyclone5_defconfig
>>> index 2bec82b0625..2b2435a27bb 100644
>>> --- a/configs/socfpga_cyclone5_defconfig
>>> +++ b/configs/socfpga_cyclone5_defconfig
>>> @@ -12,6 +12,7 @@ CONFIG_DM_RESET=y
>>>   CONFIG_SPL_STACK=0x0
>>>   CONFIG_SPL_TEXT_BASE=0xFFFF0000
>>>   CONFIG_TARGET_SOCFPGA_CYCLONE5_SOCDK=y
>>> +CONFIG_SPL_FS_FAT=y
>>>   CONFIG_TIMESTAMP=y
>>>   CONFIG_FIT=y
>>>   CONFIG_DISTRO_DEFAULTS=y
>>> @@ -27,6 +28,7 @@ CONFIG_SPL_PAD_TO=0x10000
>>>   CONFIG_SPL_NO_BSS_LIMIT=y
>>>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>>>   CONFIG_SPL_HAVE_INIT_STACK=y
>>> +# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
>>>   CONFIG_SPL_SPI_LOAD=y
>>>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
>>>   CONFIG_SYS_MAXARGS=32
>> But what about other boards for the cycline5? If you want to switch,
>> switch them all. This looks half-backed.
> 
> 
> The changes only affect the Altera official Cyclone V devkit. Other
> partner and vendor boards may have different MMC layouts, so we are not
> touching those in this patch.

But - as you introduced yourself - raw mode loading is broken for most
boards, specifically the DE0 Nano SoC. It uses sector-based raw mode by
default with an offset which only works by chance (if at all). If you
switch to partition ID mode (like the romloader), everything falls
apart. That's why I sent the other series. It may not yet be correct in
all details, though.

> 
> The motivation is to enable FAT filesystem support for SPL on the
> official devkit, which reduces OCRAM usage, aligns the MMC boot flow
> with our other devkits, and avoids the raw-mode issues introduced by
> recent changes (mentioned in your series patches).
> 

All fine, but please do it for all boards. I would not rely on partners
to do their homework here, otherwise things wouldn't have been broken
for more than a year now.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F78CCCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 06:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB9208323A;
	Wed, 22 Oct 2025 08:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="dsVpt9yl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0EAD832BC; Wed, 22 Oct 2025 08:25:24 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2378082E34
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 08:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyjdjybggKJIqcI80eIJFma+oEdQt4TSrEYnG0Zzko0IV+xW4OgK/zmS3Tk+rByPsde41PwacpUOrNLnrnQTNCQFsLXEnGBwgFUKZu3JMogfLTpBEG2rui5AQj8ue+eRQr1CS7ipIwv1TvC49sdoumGNjQkQ7g6fAGl+oTB67VWuodIC6JbE0Q3iTfhmxhQVRaN3ywRb5VqHBT6WRkti5zhbHB5Itw5l/5tGptzQPTjHh3O8pAGibkiLH6AF3742VU75DhNsiW7tdo26Ycn7HhsvmN2eAyWI+sSS0CVHdd0x/pcIXlmHcQ8VKV5mRMVHf2xQSymPkvFEkqhaT+KhOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/TtE5j3EdgLoPbz0Qg7P37dn/abACgIkqh6OMnijLw=;
 b=kInie+tN+fGhHIl6kgb8OS72u04zIqXAC0HNoxkysK+2bJyc88zjtz6/aOr1zvCyisjM0/imvhJU2dpD8mKmTEf/NqAOV7MFpTMyE5BuB7ZL5jm6uxAEVTSdP+FM4xMcC8u+7mCe8TlocBKNUEu0pYKVld2slTXxYpORrWwVTUy1aq6B1oMvBLTeS233skZ/y++v5WguRNOe6hFJMIUgOli9ANJJ+LYrbih7+PN2VUk7Y97kF5tEGyBk1G+4go12xZ+dUohBQdUAY34FrWkuv1G/R7BvSc4DK34Pt8lIZEf3ZfmlWR6P1wVwVVhjous+YGhuR1W9d+7BN+MoDWjOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/TtE5j3EdgLoPbz0Qg7P37dn/abACgIkqh6OMnijLw=;
 b=dsVpt9yl2BGttgDQxqSxuoSZdMFLkx/RMTU/C8RWO5v+GBUZ5u5zyb6qoylnpFeO35hJVViBW02gVaiDx85F6UjRQbCVfU4OjaJ6nCR2ZSlr3zsRxYWmo4MRY87AjecHxENhRnlOHRsoi0pahebbjcX7E7FHKS5EK8uMvlDYsuB/BOjM2DnLRzL6L6wGJBH+4ZoMQYR7thI3+sErB2BaTxYY4bqCwCfg+W0WjvwdqAivVbaBh6+dRGtReerLV+uhK3Fm6n6/KSB+gCY7wGOkz4h3cYJzHA7qaDK9jQdFWlnGAUDWWgg4vtZlH2yrDl7uFeOYM+dGOeh3JiZOSq+g2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8977.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 06:25:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 06:25:20 +0000
Message-ID: <f31a7958-091c-404d-afaa-bfa03c3a2e55@siemens.com>
Date: Wed, 22 Oct 2025 08:25:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: Select required CMDs from BOOTMETH_EFILOADER
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, E Shattow <e@freeshell.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <a2f2b1cf-aa2a-4628-9d04-f293591f5f9c@siemens.com>
 <59fa7090-9ec0-450c-8ea8-ead768d4e345@siemens.com>
 <CAFLszTg5gOP=bNJBBrDsFf-BKYiZF27a0-1t0CgiF6Z0xBD0Zg@mail.gmail.com>
 <20251019164845.GR6688@bill-the-cat>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251019164845.GR6688@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: 291ad913-c51e-41ca-2e9f-08de1133c689
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkxycEFXekNTKzNBTmFienJjMlRTTkNsUkRUMzhnTEsvVmg2eVZvKytTTmxL?=
 =?utf-8?B?WGoxK2xmR0FRNmVnS1pSVEpaWXZrZlV4R3Nvc1F1b0IyRDZ6NkdTZnFwVG9Z?=
 =?utf-8?B?akY3aWdqaU5sNWEvTS9tVTVSSEExcStKbFhORnVxQnJ0L2E3RGdWT0NGcElu?=
 =?utf-8?B?M3MzNnRWckFSc0gvdGFiQUE3YjJVZWNjNlJWK2lFbHA0bU45eExqa01BbzRp?=
 =?utf-8?B?ZjU5eEFLbzhIbHNoVmdRK2pMZW8yNEpzTGhhRkl6U1ZhSzJtb2FjYS9ZSTNi?=
 =?utf-8?B?dFdJUEhHbE9pYXJXeTE3NmF5OEpqL2hXT1NOU1UzczJJK0VTSVFjZ3BHNGEx?=
 =?utf-8?B?cVYrTXltVitia2tDN29SeE1xU0ppSUYyelE1anBGbmY2aE0xS0JIKy9OS0RN?=
 =?utf-8?B?NFhEekwyTlF3NXMxNzBGZmdld0l5ME96emhDSGZOVkIySUtXS3BkUkxWcVM3?=
 =?utf-8?B?UWlpVytaNGlQNVV2cTZIRFhZQ05uNUVxeWxrWHZuMmxLMDVoV2NDNnRQOEtr?=
 =?utf-8?B?L2JDU2NBTndmSHRaU3BEZW9aTktwTG5EN2I4UVpKb0NKSEE0Vm9uSDU3Sllm?=
 =?utf-8?B?VXBOak16NStRTDhRZUJVVTJTZGMrOVR2US9saTRqOUdwdDFYblV0YWNIOW5t?=
 =?utf-8?B?ajBWS0gwVE1MRWpMVGZTSEJNbFNnKzZyUUxHUzV0MzlxbUxRY2k5RkpMbjVB?=
 =?utf-8?B?Nkp4Sm0vR1Rua0lTSk42RkZmWDlRWXl2M1lYcGRWR2VDeW9aKzlkUklZVTVu?=
 =?utf-8?B?T1Nwc3dFYzU1aklzVUU0NjY5cTJvT3dMVFhoYjlROUVnR2VGb1ZKbEJkeVZX?=
 =?utf-8?B?OGlxMWZacUYzQWtaKzRld1IrUE5JdUlidGtZUU53ZW9LcjNSSGQxaitWWGNh?=
 =?utf-8?B?RUJUSmQ0Z3Ruc0NhSTZuc0NMSEdvc3poTXJudTI5dUpVWWdqRGt0NFNacnht?=
 =?utf-8?B?Tkt6WExYRVN5TFhRTWtIbkN3YkFId2Y5MkxlTldKUTkzYy9WQmJaS1l1cW45?=
 =?utf-8?B?S2kycWlPUVRQZmx1OUVnZkRVN3BueDV3MUwvTnZHSGZKSFFwdWZhN2hrR0du?=
 =?utf-8?B?Z3ZrQWQwNHM1ZWFUMGlLWStldUJUbkYxUHprQ2UrM2xSVjFuMTBaTnA2a2xZ?=
 =?utf-8?B?elJVNE51bmdNRzRob29YMDA3aWNJMFIwaENQODFJSXVPbXhWYWtzWmovVXRJ?=
 =?utf-8?B?amdrQmxXMFkwMXlRK3JDRlpYRC9YUE9PWkdmSGdvOVVPM1RoRThoR2JhSmpH?=
 =?utf-8?B?eUN2OFJNaTdWYWlqcTgvR3JYRThlR2hlUkVFZm1GcktOb09IWXhHZnl6KzQ1?=
 =?utf-8?B?Snh4SzEzcFhadnpxUUlNYk5uZGJqeVVoSFp1WFNXQjJXTHFRdnlYMkdLM3Zi?=
 =?utf-8?B?aGlNb3BqQTZvZklSVVZoK0xDNXd1em9Fam1LdTZOdzd0UWhSSWNFNTdjdU1I?=
 =?utf-8?B?TCtYWHk3ZjRaZG16V0dSR0EraHBReUhmTlBKTU0zbjljVTF6NWtocDR4NzVv?=
 =?utf-8?B?ZmxOaGFLUzhXbjJqSW5oeStTWjJLbkxaWDJzQmVmU0hFRHJHdk5hU1dMaDYy?=
 =?utf-8?B?WTVhaDVDbU9lSSt1SE54ZENWdko0TGUyS2JRRHkzcnlEV0lTaHpzQWZLbHlz?=
 =?utf-8?B?bDRTRU5aWGNxMHRNaUZ4NHRBYmh6QzE0T3ROV211Nm94b3FVZm4vMnhyak1W?=
 =?utf-8?B?VU5YOWJPajI2TDYzOGdsQjM2TDU2aEpwU2xYdWlvekxTTTM2SjFndXVXRjJF?=
 =?utf-8?B?ZzBXT1BrbVhwUDdEZXhsV0dMUWF3SU9LdFlvQ0ZySkNyS3VNTHE1cXB1U1FP?=
 =?utf-8?B?TGRIT2dMTE10SExnbVRQUytOM3UyRzRjeGcxMk5scElHTTd2Y0hQcnBJVENT?=
 =?utf-8?B?cmJGcFZWVk81KzZIcWMwUWJZNWNqN0JZVzArRmFCWUZqREE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWZ4ay9uQktiUTRTcFdqMko1dEJuTm9PUVF4clNCOFYxbjZwV0pMZytzWGk4?=
 =?utf-8?B?ZXhtakF5RVpOMFJtTlM5OS95Zm8rbjJDMmk2cC9ldmJ4WlpuUU5NVTd4aVNC?=
 =?utf-8?B?em94cGZiRXlKaGZqeTdmVmVMQjlaOW5vWnRGc01vME8zQnE2bE1uSU53eWFB?=
 =?utf-8?B?b1R3RTdwdWhxVmRxcVQ0YkNmcldYMERRK3drbjd3MldoaGZHaHFqVXo3ZVll?=
 =?utf-8?B?UHdja2k0SVBkM1htNVo1UXJ2ZXh4dVZFZmtnd2N1OHBuS2ZiMGVKSzZEcytq?=
 =?utf-8?B?dzhzUHFnYWVnTEN5L09yY3Bocm5Bay90SkUxc0xYZi9VYUs2NmJiRGJHTklN?=
 =?utf-8?B?aWFhWkxGWmllK3BuWEJhR2lkMlU5RUVBbzF1VVhiOWo4cmQ0djBmYStyRy9i?=
 =?utf-8?B?SmpJNDdac2l5ajhtY3R5dVJSMkQreDlab0FOUW1KcStKdDRiK0g4cTZ1dkV6?=
 =?utf-8?B?L3dhK0hoQitoZnV3dWtiQjNaWE9PaE9XS0ZCNzlneE1MSlVpc1dmZDhqQUJO?=
 =?utf-8?B?Nk04L0p1bnYrdENmMTFPTk91NzRLWmpYZFVvd2loYkdhZFRNdnhGTWlIUUw5?=
 =?utf-8?B?YTFZck9mSHRkM3FHRUNwWjFBMkhoblgwWTVaTWNJcmVXREwvNnZFRjh1Q0l5?=
 =?utf-8?B?dW9xTDhPeEhTdmFqUHd3MG15eVo3ZmorVzRIdmVKdm10WCtodHVIdGFKWjUv?=
 =?utf-8?B?Y0lTNVJ5MWJId3hpb0sxRS95bmtnb2drclV2RlhJU0JFYjZzbTNGVUd2S3pM?=
 =?utf-8?B?cWthMXlaR3hrZ0tQRHJoTkFxcHdHWndDVHNIeDRXQUVFQXJSQTZTemtzbTZL?=
 =?utf-8?B?eFNQT2FMWlVnc0V2Tm10R0dURHhGSzhkUUFXS25aVWt2ajRQNmE3cXNQSEpI?=
 =?utf-8?B?RHdkRlliV3FHaFRDQ2x5dFVxeDExWnozRUFIdmcxUXVDSUNLTkI1cWc2QnNk?=
 =?utf-8?B?TnN1SENPOVAySHF2QjFlNnJ6YUJ6dS84WWROQkt1ei9TU3hRUXo5ekQvV3ZF?=
 =?utf-8?B?STNocjJCanhBeEU1enBNNkxYKzdTWnRTTmZOZHF0cTFpaTZxZFF1TTh4KzQ5?=
 =?utf-8?B?Rld0QjNtN0hLNlF0ellzS1NoTUxZOThLTm5kcnlmdDIzUDlrbk9TL1Y2dnNo?=
 =?utf-8?B?MkRiNnpUUDVPOWNYTjlJK2R3RVFUbGhMZW9CMkQ2U1M4YVhFcWIyYVgvM3Bo?=
 =?utf-8?B?b0lTcXZkZk1DNEpwM1c3OFlFeEo2eFhNTU53Tm5naGtsT2lYSHNaQ1ZxWTkv?=
 =?utf-8?B?b05FVEx2YWZlVGw1R3ZyT3ZyL0VlM1c2RFlvOTFUcmMrV05OaEZrTGRHSFhk?=
 =?utf-8?B?ZEkybFVrdnRFdXZkdjhUMnNJRVFZVFhNT2N1eWJNRlVZVjk0Y3FNRHh1Smhx?=
 =?utf-8?B?MzRjbDh2akdLNE5PVHp1bUI3RlBZU3NXUnZpUXR6dkdWTGM3dVd4dG84eG5J?=
 =?utf-8?B?R3NINTZMMm02dFBORlJsekI1c0hTM3p0T2t5N1hMOU9uQXJaeVJRNk11Q083?=
 =?utf-8?B?ckU4a2FEQlN0d3ZjQTdKbnBnck9ZZUo3UHdEODh1VzAvb2V4c0Z5SU5uMVBU?=
 =?utf-8?B?Y01hZnRpSE5MR3k3TXU3TmZ3V29vczJVNHBiOGhPUzNIdWJOeHNLaEgwcCtL?=
 =?utf-8?B?VXM5dUJmeDhBWHl3czdhWUtFUHVYRWk4L2FhS2lLN0xmUUY1K0lWTDRNbTJj?=
 =?utf-8?B?SVdRVnBuaDlubjgxSFB0THYyd2FMVExDck5DYmVHVDhMeHhLZ1dUdGxqVGtM?=
 =?utf-8?B?L0JyOHZrbThEUnFzclpxQVFVeGZuaWtPRDVuT1BQbC9MbzJDbVRtWWpjMXRQ?=
 =?utf-8?B?TE5ZNjF5YzFxekVFYktLZ2dDeDhLQXNabDQyMllGRS95NzNzeEpuRC9vQWwr?=
 =?utf-8?B?VE9JRE5QVENDRlJsTVZ4SGxFY3hGaVVoSU5PQ3Vsd2xwU1VyOThvSkRKMTR0?=
 =?utf-8?B?elpjYlF2Z0x4RHVERmNLM1dBSmNpUE50MVl5WUlYT2NaWWZmT29lQ21kN0Nk?=
 =?utf-8?B?Zm5aRGhCazQwSUs5VEliYS90TXNmdElGampCS0M3b3dNNEF3TmM1bzc4N1lz?=
 =?utf-8?B?ekhxeUdrTXFPbFJPRFMyUnNOMUoxR1prdHByQ0thSjlkQkhrNDhac1BKSk5n?=
 =?utf-8?Q?AXlOWuF9yPjqDMMBPqo+6M4m+?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291ad913-c51e-41ca-2e9f-08de1133c689
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 06:25:20.7869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1D0Oc/Qfds1je+C+tKMvpP6bvgK6ndQ/kkfdq+PpsqIvuLQP2s+7jC2mvRXsMgiim9SHQFnzXw2x8lguxZPLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8977
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

On 19.10.25 18:48, Tom Rini wrote:
> On Sun, Oct 19, 2025 at 04:21:01PM +0100, Simon Glass wrote:
>> Hi Jan,
>>
>> On Sun, 19 Oct 2025 at 16:02, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>
>>> On 20.08.25 07:50, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> There are needed because distro_efi_read_bootflow_net depend on symbols
>>>> provided by those commands when networking is in use. Imply is too weak.
>>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>
>> But I would like a bit more info on why 'imply' doesn't do the trick.
>> Is it due to a depends being wrong somewhere else, perhaps?
> 
> Well, is it valid to enable BOOTMETH_EFILOADER and disable CMD_TFTPBOOT
> and/or CMD_DHCP? It sounds like it's not (link failure) and so imply is
> the wrong keyword.
> 

Oh, I just noticed that [1] was merged. So this commit is technically no 
longer needed, though I thought it would be preferred over that other 
one.

Jan

[1] https://source.denx.de/u-boot/u-boot/-/commit/6deac6147bdba45e4bb74b608e301cb18a708b79

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

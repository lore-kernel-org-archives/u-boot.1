Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2736E77188
	for <u-boot@archiver.kernel.org>; Sat, 28 Dec 2024 09:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C72298034E;
	Sat, 28 Dec 2024 10:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="N+LCBb08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51C5980362; Sat, 28 Dec 2024 10:49:30 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EC0480317
 for <u-boot@lists.denx.de>; Sat, 28 Dec 2024 10:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/8gb4UhRX9xrfqIb2TWmvSjx1EQ/182nhRuOHKLmI/KsH7fzxVQFqKFx45UJwAyhxsnzhxn8kP2k3VylamgIK2/44EY2YOLcuIqDCZwe+IVTBdysrWop7v8bGAc7RtF2qRXmt7IhdL2EOeKS0mB90OvLy93LmhoEMOy9Oi9J9taH3zNMRR6B9K7UC5wGrnNGAItF1E14b2OzJDPDTyZiX4dp7nb4KQAvNC+XsSHDOD9dZCqOggJHlFOPguBZsdpAeQ8Y1eXyiLbIKuvllnMYG8Y9a5dTQoTsxhdF8+/+MfUlKAUoHnS36zQyyCCXWOXBmX0iJbKQ5ZaSEPfQ0fUTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPE1Ak5Pirf1rK6BxAiEx7CmeMK/bnWO/qp6yU1S0f0=;
 b=BChYXnIx20wPqjc1oK9ZcecWHQwlbXPPTc1+scfa18VOYyQcjy8yQ8st8axfgdKZqHyVhzJ5tKulUuS9oCbQA9TDtIT+eXEJSZZRp12f3jQaYp2s2+rk+Jdrg5JmgfKVQwgB4YZSWe8HIdWCs5g6p144ssuIi7q/g06DjXwMU9I/+p7ye+ZCuHdtxDBE8qogREEgVGpW1oi4lf8VuYT63ZNV6OuAlUCLzZ4TFXSwq67pBBn2Ves/YIX63UOtQiP4+ik1CCAn3aNaQyGnV9aYgE+TnuWcplRgOOmOuPyHCIHX5sokfNekl0wMVKhV/8I8REJx7i7i6u3imqKRCdbtKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPE1Ak5Pirf1rK6BxAiEx7CmeMK/bnWO/qp6yU1S0f0=;
 b=N+LCBb08bSFgYMoCtUZ7L2tR2bW0UJXGY83SRXCO64wc+x/6Id/VMQlVMcy/WmhJyJOVs+3fNyq+9oZDR1H/W/LEfyXeiCOu805dgaZC3c+Vj+QE00X+wNp1M68ImO4+xi9AuFPeXrme6GHdV/BiYSLjwomkvHoe7LWwvPqqWoTkq8E7mrjZiWcWuqh7T9n8DB1Vq/ft8RZC6qq5armC1k+YRadf8XhchcXRqaEKgHtgBaeUtttd7mjZU0tyvLzL/OaWonwDMHfW97bkgYUtb8+cm+QKP2LvKZuZB8S+d14jrC6zAt4TPqWHGL0CLaRH4/Sb9tnVQgE8aFcjQuPjtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB8669.eurprd08.prod.outlook.com (2603:10a6:20b:55c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Sat, 28 Dec
 2024 09:49:21 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 09:49:21 +0000
Message-ID: <ed0351b2-4a7f-4c86-969a-3253b74e921f@iopsys.eu>
Date: Sat, 28 Dec 2024 12:49:18 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/11] net: tcp: improve tcp support in legacy stack
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 u-boot@lists.denx.de
References: <20241223105852.1074404-1-mikhail.kshevetskiy@iopsys.eu>
 <20241227210012.GG1505244@bill-the-cat>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20241227210012.GG1505244@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB8669:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c9d72c5-6a86-44c1-b106-08dd2724e723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGJWMnhPTlJRc1JPQzhQdm42OUxwdUF0b2pTc2kwVUhsV1pxbGFaSWRINndp?=
 =?utf-8?B?YzdpUDllcDdTQzV3bXY4SklpOG9qK2pKTStlNmRBN1JhdmszbnFmeFlyamhm?=
 =?utf-8?B?U1ZqaExRYzBMQlZRTjloTUk2MnR4cGJINDBWOThDd0R6Q2prODdlSVJpN2dw?=
 =?utf-8?B?TWlpMUlzV0N4OWJ5SVgrNjFZZE12WkJUVzBDSVFkYlBnakoyOTE0eGRrUlNU?=
 =?utf-8?B?Vi83UVlrVlVqanpKNGJaMTdPdlZ2UVdYMWswYVlKdHFJaFIvd2d6SmxEUVBm?=
 =?utf-8?B?cUxta2ZoNkVmVHliNzZabEhxcnNtM29jSzdyYmNmYTA1TW81T3Z6Mmx2cTk1?=
 =?utf-8?B?cmw0SzRpWTJrY2krQkJEZHlIRXN1dnJuT1lpRnV2bkdCNUpGU3VqVkZUQUpP?=
 =?utf-8?B?M3NRL1BQc0puWVFPWjFJYmhncUlxNkIwbElmSmgzR0xnZ29Db1p1Uys4THFV?=
 =?utf-8?B?NG1kUWVzNmgxZ1B0NmNuQVFUT0RKQ3QxWCsvZUlEZU12UGM2L1FKc2UybVNN?=
 =?utf-8?B?RW9ZMDJ3Y3Q2UWpUV3dqdGVadGwvd0FiRHZpK1QxZ1lBWm5rVkRvS3VBVVhC?=
 =?utf-8?B?K3dTc0FtV3hlTk11UksvbmgzK3paTWtzVUdvUGp4UHg1TlUxaDNZOUpKZ0dD?=
 =?utf-8?B?WUFCQVo3UjVwTEZiKzFPTlNLQi9aM0tCaVNkTDAvVnJZTUpPTGlyREpESm1I?=
 =?utf-8?B?RThCRWlQMkp5aGh2eUVycVpNNnlxYkQwUDkrV0JGY3paWG9ybWdJMFoyRm5m?=
 =?utf-8?B?anBaeVlEOER4VjRtMm5sbjUvMEttUjFZd3R0SHhkN1k5c3ZiL2lwQi9wazU3?=
 =?utf-8?B?dGpFWjVVa25yOE8xdkh0SzBnQkt2cmpTK2xpZ1I1Vll3ejJycUwycDRYLzdv?=
 =?utf-8?B?cEdkTFVYV1FWZCtWcHJKL2tFOSsyTDBzNGN0ZnFGNEliY0V3a0lpM2Q1bC9Y?=
 =?utf-8?B?K0JuV2JPWDc5UklTZE1Id0QwWXBWNGYvMWtuY3Z2ckxzMEVCWG5PWUxkUDBt?=
 =?utf-8?B?VnlwdTh2QWV2alJDQm9haVNTOWpKMmxobW1FUHc5TG9IOUdNd3Y3Y2JsQWpE?=
 =?utf-8?B?ZUR5ZWI0Zms1TCtiSmpqV2RoaW00TTJwOE4vTnZxZW9sTU5rMmhpby9UcmtY?=
 =?utf-8?B?MzRaaEpEVC9iY1k4YURnWm5UN2w2WTQrQXZIbFFaTmhwYm1KVUszT0kvVDVS?=
 =?utf-8?B?K3lYaXVET3VteThRWmsrU09aMnZRSStlODNtR3A5azNlbEVIc1p6VWYwbFJl?=
 =?utf-8?B?UDJ1RFh6OXNmWDJDY0hyVzZqZmE1UFpJSklLMjZncm5Nc0xZcHdJWit5WlRY?=
 =?utf-8?B?MjRlQmtkc0gvd2tyeWJYVXhQVXR0T0F0Um1UUDFQaHhEb3NSdjJjVjlpR1ZH?=
 =?utf-8?B?TTMwc2ZkM0ZDZ2l6ZjVtZUlqVHBVTVQ1WE5WODlvcUJoeXdzaEplS3lXdC9h?=
 =?utf-8?B?RzJQUGZMZzAvWEtIU0txQU9GUHl1V3dYY0VubkY3WUdoK3VFVHY4djZXSDd1?=
 =?utf-8?B?WXk0ZExHMFZrNDNKN1VqTEV2T29RSVUyUEZYV2pJTXQrN1hNRk1qUjdzM3Rr?=
 =?utf-8?B?OUNOdTMxeTI0SkpWb3cweFRsVW5XTU9QN3RlNVJaVWxJWW1PbWtFZ2Z6eSsx?=
 =?utf-8?B?WkV6a21pNFhWdDFlekl0MHFPRFpOOURSRENhRkJndTZ5Q1M4TlkvYUpOT0NT?=
 =?utf-8?B?emZmZ1YrVU1ySklPemxqbXF4cUY2bzVWcVdGNFVHQ05EWldoTkEvdEVSQWpo?=
 =?utf-8?B?aU5CeXRicDU4empQcm1HVlZRZnFVRFp6NXhOaFVKVThsdTA1aE5vRUlmMCtB?=
 =?utf-8?B?LzExRkh4WGFKWWFOVzdtUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW9EKzFTRXB1ak1xMXlGMzR1eWJiN05wUkIvdVMrZ3hBNDJGeU5COWxwNkxk?=
 =?utf-8?B?WnpXY3VHT3dNWjdzZTNMbTY1K1FTdlVqOGZhUGZ2ZnF1bUhESXdhODNZQ1dW?=
 =?utf-8?B?S1NFWTFQS2pKZDYwRGRsbzhQUlgxc09mOXZkRkVqSk0xWmkwWnBBbUdqWHlB?=
 =?utf-8?B?MVpBZVArL3pRSE0zdzAxb0prNlBnaXY3UzdrSHI0eHEyMDRyc0ZxemlCM3Ro?=
 =?utf-8?B?Qm8rNjVDdEdjWmhQTU56SVpjd1cwUFB0aU56OW1KVGorN0lhbTFwbTR6Vll5?=
 =?utf-8?B?Yk0zTzYyQjZ4SjBYR2Z4ZEZEMmFkYytFWmhyUUcxTVVrNWUrZTVkME9Eekhs?=
 =?utf-8?B?VTFsaGhjOUZGMHFBWEtMR2lyZDhUUk1tNzJCVzZsQlZkOW5YYTU4OXdWc0ZF?=
 =?utf-8?B?V1hFZjVpMnlWQ1dqNEg5a1RtWllmOTBCN3NTK3FiWk5IUzMrV2lWOVZaazZh?=
 =?utf-8?B?SWtHODZ2ZEpVQ3l2UVdzRkUzVk93eU96N3c1elIvaFFsN1BoSXVQakFLKzBN?=
 =?utf-8?B?bVZjM2hsL29OaGoyeHdYVHNKZ3RuSDAxOGt4LzY0MCtBK2RtT0plZFV3Q1Ex?=
 =?utf-8?B?Umx1c3REQWdLa2d6RVZaa3MrdFFBaXkrWU9jWVpMKzRzSnhRWWt1aW5GSFdt?=
 =?utf-8?B?SnJQYUlWYmhEYXRESlZHTWZLbkpmWmd4RlRmeTFTc0tUeDJnWHhZVW1kVzlk?=
 =?utf-8?B?RjFaS3FRUkFNa1gyZlFMOWhLQTZ3ZThkZ0NVUDI0QmVCOVVrcG9pODkyWTFu?=
 =?utf-8?B?QlBuWW9MRDBpUzcvakxDU0x2MCtrc3pWMHpNS3BIcGE3T3VRSlROMUVlOU5W?=
 =?utf-8?B?djJHMXJtazA0OUZxcWN6WUl5bkNlYnJFWXNKODFudmVvdGwyOEpraEdJbkZB?=
 =?utf-8?B?NWFhL0h6d3Yzd3phTURlOU9IbjdnTS9uY3p2amRCZHpMcmErYTQ1UzM3OTlr?=
 =?utf-8?B?NytrZDExTmxMdTZnT21wWkRBc1lTNFN1RWR0alJXRlVROUVGZnU3Y0o5czRr?=
 =?utf-8?B?NWxOb2xyR1k4MUpZdkVIM242ZFJjV051UkNrU0xiZGo4b3RMTjgvc1ZadkhL?=
 =?utf-8?B?VVphNU8vYk1OYkhVdUlRdEw3eWczNWNkdTAxTmIyemRoRGN4blNRcXF2VVpv?=
 =?utf-8?B?M1NxRThJVzcrTWw0M3dvcUdkTzBkU0FXNVNBRzFySkYvK1NMNDlteUppdDB4?=
 =?utf-8?B?aC9YdDlRb1VISGhjWWJnaWpyN0wxWmlGazlmVUJPdVNpYlFtWEZFSXBvRkpn?=
 =?utf-8?B?TkZQRFl6VkdiWXJiaVhhQkovR0dGV0JGaUZzMFMrN3dCdzR2V2JtRGd1UTQ2?=
 =?utf-8?B?SUNUdWFtbWQreVFQeDVDUDdQSWV6MHdwMWlQRmRqcEs2bEhsM0pPd0laWlB1?=
 =?utf-8?B?Mko5OEUxYXBvampjUmRQNmZzamZ6OEtGaWZIVjRMRG4yekZOZUh1MHhpa2dy?=
 =?utf-8?B?UUR2WURmelFiUWxocG55VFFQeXhIWU5RMXhpZlNxTHo2cDBYR2E0a0xXVHd3?=
 =?utf-8?B?OEhyZmxqSHJ0STUyaXlrd3B2ZUJuV3ZHaDcxakFiS2NLOWNQWHFDYWI1NW0z?=
 =?utf-8?B?QXJDbFVtZlRPbnFDdzJwYjE1LytzdnVOWjJ5Mi93QVVNWTFRWmRqL3BhZUp5?=
 =?utf-8?B?VlZENzExdW56MmVmSzUxT01FUGF1YmczdmNvaDFEM21jT1JLcTFiM296Rk4r?=
 =?utf-8?B?VzJiODJuRkRoNGM3WTdpeWlFNkZ2WTBBamlJM1ZGZTMzSVVob1NtRGJpTUFt?=
 =?utf-8?B?L3hMMlY4bVdhemdob21XQmc1Yi9mUDJ4MStRRU93T2w1dlNLbUdKRVVzWVZK?=
 =?utf-8?B?SnNheEZIUDhEV0dqVmRxTzRoVXZEQUNYaTl5WEY0c05vU1lzRjJIdWpvTHN0?=
 =?utf-8?B?R29ueDErdFZIOG4rUlJXSGJRRjExcDZsQXNBbkt0TFJ3RTFidTFqSEczdW1w?=
 =?utf-8?B?aVZ1OVBFMTFxc2ZiQVo2blNmNjd1UkZaNmF6bXE4b1NRQlR2U0JuR2RBSW1y?=
 =?utf-8?B?Q1lZUW1JbVZSNWtFeFZCVll4Sk1BZDVmKzY4RFpmN21MOWh5Szcyc0duNThR?=
 =?utf-8?B?STl0QTdtTzV0cVZEdFNCdFpnMWx6V29DZlJKeVdBM3Q3aXRjTFptdVJMWXFC?=
 =?utf-8?B?RXRzWTlJV0xpT29jTFAvM3lzelNjNWRyTUUzVmNqODdKcGhGY1l6NTNyTk11?=
 =?utf-8?Q?i882gNSOZNH/v5tu8oeioHE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9d72c5-6a86-44c1-b106-08dd2724e723
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 09:49:20.8584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwIjgZiSswvmmZyOlzRkok5v1eqzbLk/cr9+5GOEAttII5xkJT2E76TWQe0MHHrM5QmzoReZhIXC0zZXbxr63Ea7z29Df3770LATCcSrM/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8669
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

more notes about lib/efi_selftest/efi_selftest_http
1) test does not send HEAD request as stated in the
lib/efi_selftest/efi_selftest_http.c file header. It send GET request in
the  line 168 and read the response twice (line 203 and line 244). It
looks a bit wrong to read the response twice from the same request.

2) I replace "http://example.com/" with my router page
"http://10.0.14.10/index.html" to avoid DNS issue (discussed in the
previous mail), but  sandbox/sandbox64 produce  SIGABRT during a test run.


kl@laska:~/econet/bootloader/u-boot-current$ sudo gdb ./u-boot
GNU gdb (Debian 15.2-1) 15.2
Copyright (C) 2024 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from ./u-boot...
(gdb) run -D
Starting program: /home/kl/econet/bootloader/u-boot-current/u-boot -D
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
Bloblist at b000 not found (err=-2)


U-Boot 2025.01-rc5-00387-gc390d0882c37-dirty (Dec 28 2024 - 12:19:19 +0300)

Reset Status: COLD
Model: sandbox
DRAM:  256 MiB

Warning: host_lo MAC addresses don't match:
Address in ROM is        12:f0:b0:f5:1b:36
Address in environment is    02:00:11:22:33:44
Core:  114 devices, 60 uclasses, devicetree: board, universal payload active
WDT:   Started alarm-wdt with servicing every 1000ms (5s timeout)
NAND:  0 MiB
MMC:   
Loading Environment from nowhere... OK
Warning: device tree node '/config/environment' not found
In:    serial
Out:   serial,vidconsole
Err:   serial,vidconsole
Model: sandbox
Net:   eth0: host_lo, eth1: host_enp1s0, eth2: host_wlp2s0, eth3:
host_enx00e04c6801f6
Error: eth@10002000 No valid MAC address found.


Hit any key to stop autoboot:  0
=> setenv autoload no;setenv ethrotate no;setenv ethact host_enp1s0; dhcp
BOOTP broadcast 1
BOOTP broadcast 2
BOOTP broadcast 3
BOOTP broadcast 4
DHCP client bound to address 10.0.0.146 (3407 ms)
=> setenv efi_selftest "http protocol"
=> bootefi selftest
     efi_var_to_file() Cannot persist EFI variables without system partition

Testing EFI API implementation

Selected test: 'http protocol'

Setting up 'http protocol'
HTTP Service Binding: child created successfully
Setting up 'http protocol' succeeded

Executing 'http protocol'
phys_to_virt: Cannot map sandbox address 18bc1010 (SDRAM from 0 to 10000000)

Program received signal SIGABRT, Aborted.
__pthread_kill_implementation (threadid=<optimized out>,
signo=signo@entry=6, no_tid=no_tid@entry=0)
    at ./nptl/pthread_kill.c:44
warning: 44    ./nptl/pthread_kill.c: No such file or directory
(gdb) bt
#0  __pthread_kill_implementation (threadid=<optimized out>,
signo=signo@entry=6, no_tid=no_tid@entry=0)
    at ./nptl/pthread_kill.c:44
#1  0x00007ffff7e2acef in __pthread_kill_internal (threadid=<optimized
out>, signo=6)
    at ./nptl/pthread_kill.c:78
#2  0x00007ffff7dd6c42 in __GI_raise (sig=sig@entry=6) at
../sysdeps/posix/raise.c:26
#3  0x00007ffff7dbf4f0 in __GI_abort () at ./stdlib/abort.c:79
#4  0x000055555559d450 in os_abort () at arch/sandbox/cpu/os.c:1054
#5  phys_to_virt (paddr=<optimized out>) at arch/sandbox/cpu/cpu.c:121
#6  phys_to_virt (paddr=<optimized out>) at arch/sandbox/cpu/cpu.c:96
#7  0x0000555555791444 in map_physmem.constprop.0
(paddr=paddr@entry=414978064, len=<optimized out>,
    len@entry=36, flags=0) at arch/sandbox/cpu/cpu.c:184
#8  0x00005555556d1587 in map_sysmem (paddr=414978064, len=36) at
./arch/sandbox/include/asm/io.h:225
#9  store_block (src=0x555555964462 <net_pkt_buf+1858> "HTTP/1.0 200
OK\r\nConnection: close\r\n",
    offset=<optimized out>, len=36) at net/wget.c:65
#10 tcp_stream_rx (tcp=<optimized out>, rx_offs=<optimized out>,
buf=0x555555964462 <net_pkt_buf+1858>,
    len=36) at net/wget.c:230
#11 0x00005555556d4e3c in tcp_rx_user_data (tcp=tcp@entry=0x55555595e700
<tcp_stream.lto_priv>,
    tcp_seq_num=tcp_seq_num@entry=3457615271,
    buf=buf@entry=0x555555964462 <net_pkt_buf+1858> "HTTP/1.0 200
OK\r\nConnection: close\r\n",
    len=len@entry=36) at net/tcp.c:943
#12 0x00005555556d630d in tcp_rx_state_machine (tcp=0x55555595e700
<tcp_stream.lto_priv>,
    b=0x55555596442e <net_pkt_buf+1806>, pkt_len=88) at net/tcp.c:1104
#13 rxhand_tcp_f (b=0x55555596442e <net_pkt_buf+1806>, pkt_len=88) at
net/tcp.c:1207
#14 net_process_received_packet (in_packet=<optimized out>,
len=<optimized out>) at net/net.c:1411
#15 eth_rx () at net/eth-uclass.c:459
#16 0x00005555556d7121 in net_loop (protocol=protocol@entry=WGET) at
net/net.c:656
#17 0x00005555556d7b87 in wget_do_request (dst_addr=414978064,
uri=<optimized out>) at net/wget.c:413
#18 0x00005555556875cb in wget_request (info=0x555555940e20
<efi_wget_info>, dst_addr=4166818,
    uri=0x7fffffffd618 "http://10.0.14.10/index.html") at
net/net-common.c:26
#19 efi_net_do_request (url=0x7fffffffd618
"http://10.0.14.10/index.html", method=HTTP_METHOD_GET,
    buffer=0x19c6b980, status_code=0x19c6b998, file_size=0x19c6b988,
headers_buffer=0x19c7b3a8 "")
    at lib/efi_loader/efi_net.c:1320
#20 efi_http_request (this=0x19c6b940, token=0x7fffffffdb70) at
lib/efi_loader/efi_http.c:242
#21 0x000055555568f3ec in execute () at
lib/efi_selftest/efi_selftest_http.c:168
#22 0x0000555555681687 in execute (test=0x5555559225f0
<_u_boot_list_2_efi_unit_test_2_http>,
    failures=0x7fffffffdd08) at lib/efi_selftest/efi_selftest.c:112
#23 efi_st_do_tests (testname=0x19c47df0, phase=1, steps=7,
failures=0x7fffffffdd08)
    at lib/efi_selftest/efi_selftest.c:229
#24 0x00005555555bdce6 in efi_selftest (systab=0x55555592ec20 <systab>,
image_handle=0x19c6b7a0,
    systab=0x55555592ec20 <systab>) at lib/efi_selftest/efi_selftest.c:313
#25 do_efi_selftest () at cmd/bootefi.c:109
#26 do_bootefi (cmdtp=<optimized out>, flag=<optimized out>,
argc=<optimized out>, argv=<optimized out>)
    at cmd/bootefi.c:176
#27 0x00005555555f2bb6 in cmd_call (cmdtp=0x5555559168b8
<_u_boot_list_2_cmd_2_bootefi>, flag=0, argc=2,
    argv=0x19c58a20, repeatable=0x7fffffffdd84) at common/command.c:582
#28 cmd_process (flag=<optimized out>, argc=2, argv=0x19c58a20,
repeatable=0x555555948c68 <flag_repeat>,
    ticks=0x0) at common/command.c:637
#29 0x00005555555ebdf6 in run_pipe_real (pi=0x19c586a0) at
common/cli_hush.c:1672
#30 run_list_real (pi=pi@entry=0x19c586a0) at common/cli_hush.c:1868
#31 0x00005555555ec100 in run_list (pi=0x19c586a0) at common/cli_hush.c:2017
#32 parse_stream_outer (inp=inp@entry=0x7fffffffdf28, flag=flag@entry=2)
at common/cli_hush.c:3207
#33 0x00005555555ed848 in parse_file_outer () at common/cli_hush.c:3299
#34 cli_loop () at common/cli.c:302
#35 main_loop () at common/main.c:82
--Type <RET> for more, q to quit, c to continue without paging--Quit

The incorrect image loading address comes to wget from the test or efi
subsystem, thus we get SIGABRT on map_sysmem() function call.

Mikhail Kshevetskiy



On 28.12.2024 00:00, Tom Rini wrote:
> On Mon, Dec 23, 2024 at 01:58:41PM +0300, Mikhail Kshevetskiy wrote:
>
>> Legacy TCP stack is bad. Here are some of the known issues:
>>  * tcp packet from other connection can break a current one
>>  * tcp send sequence always starts from zero
>>  * bad tcp options processing
>>  * strange assumptions on packet size for selective acknowledge
>>  * tcp interface assumes one of the two scenarios:
>>      - data downloading from remote host to a board
>>      - request-response exchange with a small packets
>>    so it's not possible to upload large amount of data from the
>>    board to remote host.
>>  * wget test generate bad tcp stream, test should fail but it passes instead
>>
>> This series of patches fixes all of the above issues.
>>
>> The benefits:
>>  * A lot of bug was fixed
>>  * Better and more reliable TCP state machine
>>  * Tcp clients becomes smaller/simpler
>>  * Data uploading was fixed (now it's possible to transmit a huge amount of
>>    data from the board to remote host)
>>
>> Modification was verified with
>>  * firmware downloading via u-boot wget command
>>  * fastboot over tcp
>>  * netcat linux client using test netcat implementation (not included
>>    to this patch series)
>>  * Firefox/Chrome/Edge using test web-server implementation (not included
>>    to this patch series)
> This fails on the EFI self test on qemu-arm64. You can see this with
> "bootefi selftest" on the platform, and the excerpt from the full
> failure log at:
> https://source.denx.de/u-boot/u-boot/-/jobs/984858
> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=10224&view=logs&s=664d8594-b731-54d7-afc5-7167226e08f3&j=52970d71-9fb7-5005-2ae1-66817be903ba
> is:
> Setting up 'http protocol' succeeded
> Executing 'http protocol'
> 93.184.215.14
> Packets received 5, Transfer Successful
> lib/efi_selftest/efi_selftest_http.c(216):
> ERROR: File not found
> lib/efi_selftest/efi_selftest.c(114):
> ERROR: Executing 'http protocol' failed
> Tearing down 'http protocol'
>

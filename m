Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681B5C3600B
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 15:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6CB881D3B;
	Mon, 24 Mar 2025 16:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="GfyOHACg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E59B801CF; Mon, 24 Mar 2025 09:40:26 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B5A981F28
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 09:40:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5SdKtvgPqgBsNRs0CFlGUdFU46U0eOCw+/8Rd9si/BTQgu9DOF+QyNFqG//MgRMq235etnn1yvixrXTd87p4ZeRRL3t0+4lc5eJFMZNHCE5g0K8Lnog3a81lYssnqu98Rel2xcLqTSeq6QgCRdo+X1b2avPJpufV0POFwF4NfNInQrkkdtIkrTWiqnWTNPZPG4Yb16/mJ/6syh+ZM8bxNAjjD/GtUfY7OvKqD7gMX2KbMqVGpzWN4bcka0jZqqbLcBpM6Xth8BmaAF/uSpZqIKxV28+onVwgAP/9rwxi6BT57vS9Is/Fuz+9ngeXu3nxIbIRpddJJezRv9RClujBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdvV9UoRNM9KLri/EmoqMmNhzRX2u+djvAjE6b+yq3A=;
 b=sikDR5EL5r61BO8XiEaB/lGwEh2Eam+I21XtfCKHmzyjO7EfBraqnvAhSUQz0r5bDMaZ3Tbns6zk7Q880QlOJuA6NR9Nvkk9v1WuBSwcqbdD426246uMiF288TvUZMbmiSsbprXDI70txOZoLzdDD48mLb/4lz7aDCPJuT3B7JeG1HB3/31SUrRQjb0HIvUTmsxwIWPQu8oSrPsOJTk1+rfhq/6hAZDdHqrU6ITAPgOnZ1YFBhS7blQHlxCHFNPx3v94P9cTEqovthdPv7MigVPzjR2umIzGj+oaCDydZGWHRE8rKaMse7opL4EJ+q+lfR2qiaEnIP9988lGK8zMbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdvV9UoRNM9KLri/EmoqMmNhzRX2u+djvAjE6b+yq3A=;
 b=GfyOHACgwJAydg9suR0Pv/MI6JYdvvfbqh2lzWzLJLhgLIvsJjd0L1bKtF0IYgR5ORFTi/gVGq9tzPaUnKSj7H5QKBCQBP/Fx+3MYgUv6IRf3K4YoIXonwnFVr56mMWUsdk46XhplTlmg4SA5E9pqB5AwxeirclyALI2f67PwQawaDp1FnSDDSVLxLxWIFeLlLgio4r7KNK5cwA7im5g9P1bklcmZaRtvNj+DIawDdJ7cJG9bIQA67bezak7+w73WRecgR+7Gi8xDjijb5QwB2JOgOK1E9J9mhG/Z+lyMwFM6mKdc2HzXF6a8Meis9Wg2OYG/Y0fXQaaxOyJNocgoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by MW5PR03MB6958.namprd03.prod.outlook.com (2603:10b6:303:1a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:40:20 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:40:20 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v3 04/12] drivers: Enabled Kconfig and Makefile for i3c
 support
Date: Mon, 24 Mar 2025 16:36:56 +0800
Message-Id: <20250324083704.26259-5-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250324083704.26259-1-dinesh.maniyam@altera.com>
References: <20250324083704.26259-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::47) To SA1PR03MB6370.namprd03.prod.outlook.com
 (2603:10b6:806:1b5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6370:EE_|MW5PR03MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 1403bb30-14d2-4f1d-377c-08dd6aaf82c3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWJGbnBVUzZQWGZlZklURk90OW5oL2RIWEh3SGhpVXJ6WEV5NElTM2l4cmUy?=
 =?utf-8?B?czgwRS9XNVhpb1pRU1JQeUd1dENURktuNExCaWhpK1ZBQlBEa2U0WE5lVnJv?=
 =?utf-8?B?bk16dldkVU5rcUl4akVJNkEyQldQeENtdk9GUnVOYWo3ZEx4djRWS0RxbzJz?=
 =?utf-8?B?UHIwSWt5NkRsY1Y0M1Z5ZS9BM2FzUWd2K2pCNytMK0hKZUFqSjMzemw2bjBk?=
 =?utf-8?B?cS9uSjdwRGtxdllacEVJaVJmSTdnczBBQUhDQVJucUNIdFZVRjBCL2tLNnVm?=
 =?utf-8?B?SmQ3OVBlSXlrUDFmd3BOOTE3THAyYWZuTGViK3JRekpjbnBVWjVmRHBNa21E?=
 =?utf-8?B?NXhxTTE3S0gxemczQ2NRdmd4WVlUeTNNbWp4SlZneU9TTG9yUC9Cb1dMQ3N0?=
 =?utf-8?B?R053SEVjL1hTd25GSXd4QklXSGpZbWtFVzcxNCtyR3paSEVkUTVpand4QkhD?=
 =?utf-8?B?NWtTTjhESk5PNm0rVzNvQkxOVVA1V1hobDNNaFQzOWFKcVp3NVlhQXBvNFFC?=
 =?utf-8?B?ZlBTeG54VkUwT2VQalpCMm92aVE1RFNqV2prUnN6S0luMWk2L0lVUGYzSWZL?=
 =?utf-8?B?dlFwYlhiU3ZqVTl6eHAyUXJ2WkhkTitOOTNvclFyck9ucHJQZ1dIaGdhbW5i?=
 =?utf-8?B?VU1rZWl0YlRVY3ExR3NHdzhJeGNaSWtsNEVUaEVkQmJuWDR0eHFQa3JRSXFx?=
 =?utf-8?B?R2pGalE5ZEJlNnVnaE53eWMrN01ia3NxcVN6dWozYVBqV0UrSHJTM0l6c0pY?=
 =?utf-8?B?TVRkUVdUbmxYMU43eXdpbHlBcm5hbGFydFB6NXFxdFJLaUhNVmhjaUtCc2NW?=
 =?utf-8?B?bnR1WVgyaDZtcElvZlJHbDB4M2plUXVUS1g5R0F4cGFxSmxVVFBUeWNLbTNa?=
 =?utf-8?B?V0ZNSXpMeEJXdVpiZW9JS1ZUekk0LzZ4Y25mRTVKYzZDYUZnVmJNREJWQS9k?=
 =?utf-8?B?ZkRVS3pxWTVobHZjTHJ1ZWFpRk8zajZUUGFqZnhMWHVtbmJqdU5RZXdoZWU1?=
 =?utf-8?B?aW9ISDlFTE5tckdaYTFwbjNoM1p0VGpOcDNHeGgzN0hwcUV6TEg2blNMc0VJ?=
 =?utf-8?B?bzFWbnFzUndNNTdpUnpQbGVFWU9yenVsenJvYmVmbjNjdzY3MXA2YUQzOUty?=
 =?utf-8?B?TDlBQ1g5QS8ybThEZE95SFc0Vm5IRU5iSWY0OGJSaUV6Mjl6WXAzZ2UrZVVa?=
 =?utf-8?B?cTBqaDRVYkUxY2owQ0xSSG5QaEh1dEVENVRqRWJtM2JGN2NEZ3RQdlJVWDVG?=
 =?utf-8?B?T2FVbDB6QVIvcnhIZE12M20rcERzUmN4Z2YzVU8rWk1WakVTaG1NVThRQURt?=
 =?utf-8?B?RTNQWkdXMWNYRktid1AzcmZFa1BqK01wTlhoMVVEdGF6cDdsQlM1cEk4WGw5?=
 =?utf-8?B?ZDVlNnF3eFljbEN0Z0RZMEsvZEh4SkM0UUl4UmpMR2d4c2I2dGJYZUwwbkJI?=
 =?utf-8?B?d296Yk5teVE3T0tqMDhnQkRKR0h5SmdTRVFWSHVwYmNGcUxpc0I4ZUdmWnJV?=
 =?utf-8?B?M0JIeUdSc0pEanVxSG5jcW9lSmNzZkIzVzBCdENQUXJLQ2hjblZDTVE1bWtK?=
 =?utf-8?B?WC9BM0NwOHFNQVpuN0dnNUdBekxlRzJtNHdDdzBMejhaUHpmTHQ4YytBV3JV?=
 =?utf-8?B?RnJTelZtdkw2NkhFTXV2aHMwMG1ackRLRUFkaDk5bkd0OEliRlRpNGlOWW11?=
 =?utf-8?B?L0JOUkdoaWFwOTN0WXNwWXhGVjRRdDUzVWZmdy9weWFya0xSNGM3dnQyaDdN?=
 =?utf-8?Q?C06L08OBsyCLQcRKk4f+Esb+7GplqWAtYFZ3g9O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjBBdEx5YXhxWGFLdEZoZFk2Z2QyYnAvN3E2THV2ZlJZUFF4YUh0d1ZKQmd6?=
 =?utf-8?B?LzVsbTdwWlVPZ00yK2xPdHhaR0NJQ2x6c0hrMUh2dm4xUkFQZCtuU3BNbU5v?=
 =?utf-8?B?enJMZ08yMHJnUEF3a2VvRi9lUUE1RmpPZGtTeUE5by9aRFZLUjMyVWhkcS90?=
 =?utf-8?B?NG16RjF2RmVGUnl0SmlEZ3NFKzNaNXZlOHJZc1NlcjJMbXJ1bno2OUlQeEhh?=
 =?utf-8?B?SmErc2plZy8rRzVFRWhxdmx4UC80US9zc3RGb2NxNDRrYkFHMnZzb1ZwRlZs?=
 =?utf-8?B?RnppaTRPelVTcmIvV3RGSTRROEFYMDJSa2NxOWxLN2tYNGdWWDQvM1lNcXdT?=
 =?utf-8?B?NmJZamJhVC82V3BLVDNpeGxaMmZqTi9yQ050MG8rVm0xN3VDTkhUWVplWXB6?=
 =?utf-8?B?YmJvMFpCUnR0ckNnSHNXcTJEMlBISHkzRVc4eENpTDZMY1dyWGtvUUJZdURi?=
 =?utf-8?B?VDd1Q2RPd29Dc0RnMUFidXc0QjJDYU12a2lTTVgxMTk2WXhSZHpDOWk5R2JD?=
 =?utf-8?B?d0w4Y2x6dHhGbWh1L0ZWRGdFOE83WncxOFlFQUZsK3VuL3kzQTlPQ044Znc0?=
 =?utf-8?B?ZThYMG54MWdyTjBiV0pGV205RmdRbzZNN2l2d3dnMUVMYWZtOCtvS0dPeVpT?=
 =?utf-8?B?VXRVYzVkYnJOS2FVcW5iNzlBMnVnL1NvZVZtVVp4VmNDckl1K1laM3B5TXYw?=
 =?utf-8?B?b1NOR3BXNklqaWFPTEZUYW5FK0VseUljbTdaVUFxSklWMUhVeW1ia1BYN3FI?=
 =?utf-8?B?dkxLL2lTbEo4ai9VNjVpMVRnUEp0ekVzcnhRLzkyVEVXS1V2RVV4TVZSMHNM?=
 =?utf-8?B?dEt1bVZDK1lZckhxTG03cXpyVmJkMXM3Y2J6NnlURGFxUkgzOE56OGlxdW1u?=
 =?utf-8?B?WDJUemZ0UU1RVkNTRVQ1WmwrK3d4dG1oMG9kU3JiR2RaNkVINWxLN0xqbFBx?=
 =?utf-8?B?QkF4RFRSN21xb3c0TXcvZm5VR1BiY0llTzBUOFlUVTVGc3k2Tk9SNFdJMFV2?=
 =?utf-8?B?dVRLcW9ja3lIeGMxeWp2Qnl0VS9SdDNhMWFHc2kwT250bGc4MjRzTVhJdnNa?=
 =?utf-8?B?K3hsbnU5bFVuVUsvdGlmd2ZaZTh4ZGp1VDBhVFpwL1ppS1ovWG1LMjY5SFF2?=
 =?utf-8?B?ck5ycTgvdVNoUlhmOHRmanNKRGw1bmtOVUFoTElVSFIvb2JxSk1YdDA3WnhE?=
 =?utf-8?B?QjBpVnJCODdUQVlJY3JSeVhXVmk1bWMzU1JHU0pCNzRobDlITCtxdFNoUHl1?=
 =?utf-8?B?R1F5K2JzRUNTNVo4d3p2dVd0Q1RYeG85b1dSUjBsWjVpTmtuRXdMYklnZHRU?=
 =?utf-8?B?aWJMakk0eitMS3VsWnNIZFhnejA0VW16Snk4Uk1KcHI4cnFZdVBCOHl6VGN1?=
 =?utf-8?B?SjlVYnlHc3pOSWRjekFpZmVZYTBlM25GSVByR0xja3ZMbGFMcXQ5Q2lmVDNI?=
 =?utf-8?B?Q1YrK2RycnZWUkFEWnBJeThuOGthQUU3WHlZYUNQcWo0alNCdXlxSFRyTE5k?=
 =?utf-8?B?T3JCc1c5L21nbEpCbHJPaFNjNzdnaTFGRFF4Qkdyb2RRaDY3aXpwVDdHdUNI?=
 =?utf-8?B?clIyZlZac2F1K01lNEp0dmxkRjc0WUxBanlmL3J3eFRGbzUzdmo5SGZsWVlm?=
 =?utf-8?B?UU9PdDRvWCtHd2FCa0xhMXo1dE5uNzlTTnNKRDVDSzJtcGdZR1dHT1ArWVU2?=
 =?utf-8?B?VVZGSTB3dVpuTzdycUNJak0zOVV0dWMwUkpHMGN3anpDZjkzQmRYQ3JKeTZM?=
 =?utf-8?B?VUNHcDJVNDFBQngwZ2xUdENuZHNBMlBteWNUeldMRjJLRFMrb05SNUxuM0dS?=
 =?utf-8?B?YzRaaURHQkJ4a2t4TXlURWRKNmRjRkZsU3pqbCtIN3NQc0lLRGtpT2xKREdH?=
 =?utf-8?B?VEp1NEFyZGQ4OUlGRmlwTzk0eHhldFQyZzkwUXRiTitmdTJVWFk2Zm84MlJB?=
 =?utf-8?B?bUlLSkRrOEdwYVYvS2k0OGd5WWMvWnNvb3E0K0RrMmRJMGhhQnBsVHlvVWt5?=
 =?utf-8?B?eUdYQ3pySFl0M000dXZ2MU00TGlWV3gvNVZCWDZid0g5dlFXUFF0VzZTOE52?=
 =?utf-8?B?aG5DYWo5S1cyY1pNQXZwcHhualBiVXI2aGZMbjZSb2s1SzZaVkdUQlFCM0I5?=
 =?utf-8?B?ME1aRWxBcFMzWnNLcEF2TEdIaUdKVTZMck5GNjNmRDNtWEZveHBoVjNDQ3FC?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1403bb30-14d2-4f1d-377c-08dd6aaf82c3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:40:20.4758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsI1ZUEsFBGK2NAIfB6b/3iAs/e2Pga8LgHJerugwGTY/yN51izzAY9Fca4XzTpqr3G/wZTjbJZEQ8BDxJwy5AsmAkdqPz9+r1Zw2ZaRAyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6958
X-Mailman-Approved-At: Mon, 24 Mar 2025 16:09:48 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add new i3c driver to U-Boot drivers.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 MAINTAINERS          |  7 +++++++
 drivers/Kconfig      |  2 ++
 drivers/Makefile     |  1 +
 drivers/i3c/Kconfig  | 16 ++++++++++++++++
 drivers/i3c/Makefile |  3 +++
 5 files changed, 29 insertions(+)
 create mode 100644 drivers/i3c/Kconfig
 create mode 100644 drivers/i3c/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 0315c606744..6dcc566eb72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1230,6 +1230,13 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-i2c.git
 F:	drivers/i2c/
 
+I3C
+M:	Dinesh <dinesh.maniyam@altera.com>
+S:	Maintained
+T:	git https://source.denx.de/u-boot/u-boot.git
+F:	cmd/i3c.c
+F:	drivers/i3c/
+
 KWBIMAGE / KWBOOT TOOLS
 M:	Pali Rohár <pali@kernel.org>
 M:	Marek Behún <kabel@kernel.org>
diff --git a/drivers/Kconfig b/drivers/Kconfig
index a073230c26d..0b0c610e629 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -56,6 +56,8 @@ source "drivers/hwspinlock/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/i3c/Kconfig"
+
 source "drivers/input/Kconfig"
 
 source "drivers/iommu/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 0e1f58c515b..fd155835ab6 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_$(PHASE_)DRIVERS_MISC) += misc/
 obj-$(CONFIG_$(PHASE_)SYSRESET) += sysreset/
 obj-$(CONFIG_$(PHASE_)FIRMWARE) +=firmware/
 obj-$(CONFIG_$(PHASE_)I2C) += i2c/
+obj-$(CONFIG_$(PHASE_)I3C) += i3c/
 obj-$(CONFIG_$(PHASE_)INPUT) += input/
 obj-$(CONFIG_$(PHASE_)LED) += led/
 obj-$(CONFIG_$(PHASE_)MMC) += mmc/
diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
new file mode 100644
index 00000000000..fa68612787b
--- /dev/null
+++ b/drivers/i3c/Kconfig
@@ -0,0 +1,16 @@
+menuconfig I3C
+	tristate "I3C support"
+	select I2C
+	help
+	  I3C is a serial protocol standardized by the MIPI alliance.
+
+	  It's supposed to be backward compatible with I2C while providing
+	  support for high speed transfers and native interrupt support
+	  without the need for extra pins.
+
+	  The I3C protocol also standardizes the slave device types and is
+	  mainly designed to communicate with sensors.
+
+	  If you want I3C support, you should say Y here and also to the
+	  specific driver for your bus adapter(s) below.
+
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
new file mode 100644
index 00000000000..5bb44a8d64f
--- /dev/null
+++ b/drivers/i3c/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y				:= i3c-uclass.o device.o master.o
-- 
2.26.2


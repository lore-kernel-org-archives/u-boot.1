Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD51DC369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 12:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 207E182B44;
	Wed, 16 Apr 2025 14:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="kZsHmDoR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13C5482DF2; Wed, 16 Apr 2025 14:47:43 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91AF382AB1
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 14:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLv1XuR8yHm0O66CccqDDQu5vSTA/LvOrW77LiT+7X+O9FjpakrxldkT8l85JRq7VJNm3upei9prxzfGkrzqP6mLsgsMVqZ4PNlEwoBKH+bmlDLm1XzqgqEnk2t4mnjR1ULcE0Ops3naffIl7BvRDTOfqj13r7wPSoPJjaBMV6qTnjObiNJBOWB9tbyTEMV1clOEUXzmud0tMOCxbv1onMSELwQYMlOPmUMn4zK2BvurAUsFUHCgN2AXgESnndljuN5nV0RamCEZAqCa4qv11oC6s3qZbi4abYoB3kfIksKC3eaTSGWG4bVU3BcHc6ZMs8AUREg/HihC+h25vG0xlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGi/MjYywbJ2g9KHIeZEs0/XKTiaaRboiFmdRXv7fXQ=;
 b=kU5b8JRca8giJz/m6sdvHBQOLr/ibJmRZC097uDhZbO/FDCVt8U+EfkYW3mScGa07Yb6lqfGOPx3j3JPrG7NprBXCDn875CKfLMZ9+D6HNwoQeyHY7ygKpSOZWKf5YJJXYleze/5udoHA9ZKzS4PJmqKYslURjFol0ZIixE9t4l6oH6p16BZ19UGwnlHuiiXRmT5b0r9i31azGsR7xhshjI3F7YyvEkcXKTaLTGG9nEPTRnn0ZZGN6u0cBPLtKUcEGhazSRwfes1SXkVl4vAhTHJWCSh9MABAcIRdwSITgCcTC5R45uJtqjQcaBJkNG/PiOaGbNR2RSzYhBGGizmSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGi/MjYywbJ2g9KHIeZEs0/XKTiaaRboiFmdRXv7fXQ=;
 b=kZsHmDoRlaZaPzOhGlwERKgPGoyaEGW0yrzWVEFPqNIEsioMWtilGGLeiAkVNByXAM+gZaddP17cBnTYGxXX04cPliEPN5R3boECfDBOSJGVfm3dAvTEECgM9YycgE4YwQMaknzXRhJBqUbiJtP6d4FKoSKilgfhC1PC326EaA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBBPR04MB7738.eurprd04.prod.outlook.com (2603:10a6:10:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 12:47:38 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 12:47:38 +0000
Message-ID: <7278a03f-57d3-4e50-9c84-8b329c2032e8@cherry.de>
Date: Wed, 16 Apr 2025 14:47:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools/make_pip: Use venv when invoking pip
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20250416-ubuntu-24-04-v2-1-bad2be600857@kernel.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250416-ubuntu-24-04-v2-1-bad2be600857@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR3P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBBPR04MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: b24d60af-d412-4ba0-f79a-08dd7ce4de7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGNlUDFXL1BvWEpJVkw0dTRKeXlVci9wVlExUExoVHZMdTZleUtPUC9CVDd0?=
 =?utf-8?B?WUwzQ1Y5NDZVSzNQOXY2NXBDRzN0N0MxeEZHb2VIZ0R3Um9SL2Y1RGIvV2Zs?=
 =?utf-8?B?enl1QmE2aURCRDYwbVdpcW1WMFZTYTRoVHlFVWcxTGxSb0pFR0VtM3p4Q2w3?=
 =?utf-8?B?N1YrcHpJc2ZYYURYdVVFQ0hEUVFmZW9jTGJiamxvbld3UmJIcTBVUkVhSE5w?=
 =?utf-8?B?clh6ZUo5MHFPNDZ5RTFUQndGSlp1TVVYMXhzeitEZFVuLzhDK2lBbzBIRTlC?=
 =?utf-8?B?YVFVNGZLaXJmVStGYWRkYlpRWXcyOWxhVitYUU9MalVMVFpLLzQ4bFJvQTIy?=
 =?utf-8?B?bUswbnppV0hGa2UzYTdFNXo3MkRGdjlxbHpVR2YvSXRTRWI3QTVZRGhSRXRm?=
 =?utf-8?B?QkRjb0pUUGxkTk02RTdIcnR1YUEzL2pER29pWGFJQVRnK1pDQzI4Sk5rdmVM?=
 =?utf-8?B?cGp5aFJ2cXBmRmw1dkFFK3Z0Y0RMUEZmUXRjczFJVWUzWmJxYkRqOURoeS9a?=
 =?utf-8?B?Sm5aRWc0a0QyTjN3ekdnSnBvZjc5eCs5a09MZjdVQmQ0SFhPaG9Od0lpNUlC?=
 =?utf-8?B?QnB5dFF6cnVqWEhCeTlaYjZWbllXRmFvS1MxRGRjRG10cEFFT29VUmM3VkFl?=
 =?utf-8?B?UEhHMFd2M3BtZWZjTHRXRlRNMGs1Y2NtUmNpMUlsVVNTRDdZQmg3YkdQaXNt?=
 =?utf-8?B?RkxHQ0xWV3VTWVcyZWJyRFhmd0V2TEJyanVvOXFyR0Z3OEJEQ21UQXBHNDFE?=
 =?utf-8?B?V2VBcDdEVjJkck1GdFdYalZBVllEcko0OVJaZXQ5WUFpVnI0Z0pLVEY2ampz?=
 =?utf-8?B?UnA1VlE0Zlkrc1VBdHJhajhVbFJpeWNYelFTanhiMjhFWHJNcTJOUU1LbXV6?=
 =?utf-8?B?L2kyanNNekNZWG9nVHBNWWEvNEVXWVlGN2RiR09HM2Z2NnVtdjdtMENELzQ5?=
 =?utf-8?B?ODNjZ25DSjRGcmtES254TUduU0ZEM0ZjL1BBZHhIV3MrbWJNdWhwRlVPR21o?=
 =?utf-8?B?Q05neHc3Yy9TSi9tRlVkT1FIek1OOW5XUjVkRUd2Q1lFMVBPaklDUFYyN0xF?=
 =?utf-8?B?bUtXS2l6WjBKd1RHTVBzL3lrMjlQV2FYYnN5U0xKdXlKSktZR0w4Zkt5RFJE?=
 =?utf-8?B?VE1Id2thTUkwbDllT3RnZ3VQNW05akNzcUtnN0h5cWhXY0JoZEYzNDFwWFdM?=
 =?utf-8?B?b09xUll4WDQrT29hbG5jS29MZ0h6d2U1YWNQaUlSOGJXb1lLUWlwMHZYaVdB?=
 =?utf-8?B?ZERBWS9oWnZveUp2d0twc2h3R20waUxReC9sSzJvc0dOcWxQUGpTcEpkdE9X?=
 =?utf-8?B?VVI4bVFzaFBrRE9ydlI4OXhzVXJIbUk3Qis4OG55aTFSZnJvV2c1SWhkMVBU?=
 =?utf-8?B?Nm5IL1plOUgrbzJnQmM3ckNYZHZjMk9tTnpscjNNYXpOd21ZMlgvK1NzNUxo?=
 =?utf-8?B?anB3TzIxRVZtU3MyaDJtNjgrYm95Y2U4YjYrUkoxWW05Z0F2OU51Q0VpVUtj?=
 =?utf-8?B?YVptWm5PbldLU0pmUFNaZkpWcFFUdmU3N3JMdklPWUxsbTFWa1JBaGRZRXZW?=
 =?utf-8?B?UzdOUlRMQjFNeTNGM0xmMEtqQ1hlRXdvUkJGYXpDamhXblBacXJ5VDJlZktz?=
 =?utf-8?B?VXRFeU0zM1JxT09xQlhFK2ljc0U0dzhXQmU1N1JUTVEwTk5Ncm9GMTQ4ZE9i?=
 =?utf-8?B?VDdrc2hJVXFVNWJDQitsNXpxMkdCZlRnWERvYXYrOFNTdTJkOTNhQ3JlckRx?=
 =?utf-8?B?Q09kejRvUHZ5TnNFcUloOGx4WU1tdnZBVEV3UlVWQURBa0lKSVV5ZWU1eis2?=
 =?utf-8?Q?AIboGjp0YH8wx1OsHfTNqdUhGm6oPu4aLpVnk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N205ZGw0eXRjMnAvUXUzbHlwcE9ORmM3MERPRy8vUHdTblluTUFKM3YySzNv?=
 =?utf-8?B?cVVZYy9RL1BZRzRzdi9TdGJJOHMwQUlaa3NIUVVGejl5dENnSTVJRFZRZUlQ?=
 =?utf-8?B?eDJ4Ky9UMTZySVdPRmhLTWxnYWNWY21CdzNGV1ZwK01FTnkvektFdFlWcG12?=
 =?utf-8?B?UmNEcjk1R2NNTmp6RHNxd3krZzVUTVRKN3JPRXZNckpqanJNUzd1ZlJra214?=
 =?utf-8?B?R2xEM0VuR1p3MkE5ZllBQm5saVVlRmQ4d0szenhZTFVMWStaRTZCY0xtS3dl?=
 =?utf-8?B?UHJ3OGRjWWxVdmxPK3lBUXJMckhjaFhOY3pCV01Ma0tUL0xhUHFteEhQenpn?=
 =?utf-8?B?bGFWOElwNzJKdUtLenRNeTZxbHdJc1NZRWtDbktVTFV6NTAwOWpqNkdvQ2xR?=
 =?utf-8?B?aHdjOHN0aVVmS2YyZ3ppVEJpYVJ3N1hsMll3elNQU3NqUDFUaWF4TFgzL0ZX?=
 =?utf-8?B?RC80ajhjSGlDZWE5cHlNY1ZtSElJK2loRldQWVZka21Xc1VBd1prVmdlYU5l?=
 =?utf-8?B?T0xWRERKRnYybkRkSDVnV2p3MEZZZkVoVTBCd2ZlMkduSHJHdS9WS2hRbnph?=
 =?utf-8?B?di81Nit1QXRlWkJIRndiRVNKT3NHbzh0N3hQSmNTQ0h5cC80eVJpck5WSmxh?=
 =?utf-8?B?M2Rac25LWjZMbk1rdlpjQUh0eFkzV2w3U1Uxc1dZd0RkZk9XUEhyeHJCek1j?=
 =?utf-8?B?YURFZFRwNUF0ODJ5U2p3TTdyMUM1STFHS3ZVL2tabE5LemlFWE1xL1l0ZUxh?=
 =?utf-8?B?bE5MNjh0NlJHdWUzbWp2dnZYR2YrN3ZDRis0WWZBYkx5Z2p1NlhITFByY0h4?=
 =?utf-8?B?QjFsNTAwWWNxZTJvcXc0UFNiR2I2T3pPMmRSTHRGTnVUdWl1dU1yQ0s3VzMx?=
 =?utf-8?B?cjhPOFVEajR3Rm5wNUNDR0JHcWFQUUFMbDFHN3pxUFZBVzV6aUlGemdGRFRZ?=
 =?utf-8?B?ZW5VZUVtL3VmNk14aEIwRnVTN1NUV21oQXlUU2tkbHBZcnFvYzB1TE01M21l?=
 =?utf-8?B?UWtsbEpzRE5GRVJkK2wzNjNQUllOeGZyUTJwRzN2dHZNMnV4VTlhZ3NOZXlj?=
 =?utf-8?B?bzNCbGt3cGovcWRIcDFrMnZJSTZUVEcwWHFrTXBjcmh0MTJudTZQZkd2UDR0?=
 =?utf-8?B?dGhoK2lFYTlOVzgxTm1URncveUIvQ1RVWmM4RmpsQjJZUHNJd3F0ajUycm9r?=
 =?utf-8?B?bjNoc21yMXhpTnJXdGpwbE0vR2tkTjFEMWNJbU8wMDgrRHdIaWo5NTZLQUFL?=
 =?utf-8?B?dDdEYURoMUZBS2huS04rS0NCUU8vMzc5ZFJpblR6NUROMk1vWjVZQmJ3Q3da?=
 =?utf-8?B?MjhSemlzTFkwci81RTBTWWxzOHNJM2NqSGM5a1BQZzJGdUh4ZkVLOHZMQSs2?=
 =?utf-8?B?WDczL2xqZGpvdjVoZ09wdkt4OXFSNFVHQzJjS2FsRVBTVmc5Y3ViRFdPUkhK?=
 =?utf-8?B?MnV2M0ppNzBjWEdNR3owWEd1T1hiWm1zS1BDZmpqclJlVkcySG5EaXkvN1hY?=
 =?utf-8?B?RnRxcHRUSng3b2k4ZUx3R3JrRTZMVU5vd2tXZUNHaUZuQVZ1WURBaVFZWGtn?=
 =?utf-8?B?Z3VUS2RyazRUanpLT0JoYXBHSUpDS0l5TmkyV2pkNFJiZFBNcFBUZkVWKzR5?=
 =?utf-8?B?YUVxOUdhT21XTjhBdU91UlQwUFJ0aXdTL0tqaXBDekM4OHV1TzhXaVIrVisy?=
 =?utf-8?B?ZnkwNWtKV2pNYzNYc1JLUFROSHp4RXlCc0VoR3lYNU1VdVZrNXNmeDhVaHFQ?=
 =?utf-8?B?Q3FuamhMVGZqVE03L3ZmSWVUTWJFTytJUDhTbHlnYWhvcEpPUXpuaHduZHdG?=
 =?utf-8?B?K3FpRHRZMkxoU3pwelRBaUpBQUk1KytvWWdKNUhuQmxLWC9OdGkzTmVIVTFI?=
 =?utf-8?B?ejF2Mzk3QmZ4QkwydVB1bWVUZXNDQ2o0cE1HZndIVXp3RFJQZjRQc3MycXhm?=
 =?utf-8?B?Z2VyZDFnMDN2eXY4eWgwbnEwMXc4YUdwOTQrdGtpbjJzV29iUjVwRTd0TTdS?=
 =?utf-8?B?bTIvVTcxdWhlUVo2YTk3QXlWVXJtOXJ6eTBuVDF5bnBOUGpyYWFSbEV5Y2Vv?=
 =?utf-8?B?bm9lRTAyNG9MRmhuQWtGQ3ExNkhVbjlaeDljaEo0b1dEbUFyVlZIdGl0UXUz?=
 =?utf-8?B?U1V0RitCMCtyeEo1MzNlSURFTlo2OWNER3JaTU03T2VkVTU0ZWd3emFKaHpN?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b24d60af-d412-4ba0-f79a-08dd7ce4de7f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 12:47:38.5791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/2NSDD4y6h4P4CY8FnVwwVJF0DyNQiG/uhmoORH5+putjUBO2Itj7UzSMgO8qEBrU4r5e9FsS9eqTm0XfnJTWMrEg2XvbZ1TNPIVQk6n/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7738
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

Hi Mattijs,

On 4/16/25 2:36 PM, Mattijs Korpershoek wrote:
> Recent Ubuntu versions (24.04+) disallow pip by default when
> installing packages. The recommended approach is to use a virtual
> environment (venv) instead.
> Because of this, "make pip" is failing on such versions.
> 
> To prepare CI container migration to Ubuntu 24.04, use a venv in the
> make_pip script.
> 
> Note: This has been reported on [1]
> 
> [1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/37
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---
> This has been tested in docker on ubuntu:24.04 after running:
> $ apt install python3 python3-venv
> 
> with:
> $ ./scripts/make_pip.sh u_boot_pylib "-n"
> 
> And shows:
> Successfully built u_boot_pylib-0.0.6.tar.gz and u_boot_pylib-0.0.6-py3-none-any.whl
> 
> Also tested with "$ make pip".
> ---
> Changes in v2:
> - Use venv instead of virtualenv (Tom)
> - Link to v1: https://lore.kernel.org/r/20250409-ubuntu-24-04-v1-1-056728207b6c@kernel.org
> ---
>   scripts/make_pip.sh | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/make_pip.sh b/scripts/make_pip.sh
> index d2639ffd6e43..33ad51ada703 100755
> --- a/scripts/make_pip.sh
> +++ b/scripts/make_pip.sh
> @@ -106,6 +106,10 @@ fi
>   mkdir ${dir}/tests
>   cd ${dir}
>   
> +# Use virtual environment
> +python3 -m venv .venv

Do we want to make sure there are no leftovers from previous runs? If 
so, maybe add --clear here?

> +source .venv/bin/activate
> +
>   # Make sure the tools are up to date
>   python3 -m pip install --upgrade build
>   python3 -m pip install --upgrade twine
> @@ -122,6 +126,8 @@ if [ -n "${upload}" ]; then
>   	echo "Completed upload of ${tool}"
>   fi
>   
> +# Finish using virtual environment
> +deactivate

Maybe you want this in a trap so that if we exit early (which may happen 
due to the script doing `set -e`), we're out of the venv?

And I tested otherwise, with:

#!/usr/bin/env bash
python3 -m venv .venv
source .venv/bin/activate

and it seems that once I exit the script it's deactivated anyways?

So, I guess no need for the trap or the deactivate, but we can play it 
safe and still have it :)

Cheers,
Quentin

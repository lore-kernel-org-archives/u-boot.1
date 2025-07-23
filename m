Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A280EC83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 09:25:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 019D9829E7;
	Wed, 23 Jul 2025 11:25:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="YRMJBoV1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0DC083439; Wed, 23 Jul 2025 11:25:56 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39449803CC
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 11:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCkFqHAmeII7Yaq2RDO1v6S2xZ6/LGgvcDpnkMedYXYN4J/78YMxSSn+e26yXFzo4tKERWIZoneb3m52HBnYXTOfl8GAc1v0JVMIh70Na/424MgrOOeze6TSS5Fqo07AHYzCnj7HIljMR1gHGt8r91frBsJsw8W63DRX1NwtbrFsLGLGRso/MOoqjdZadr39jiTu1wx7rFHUTLW9qEv9XOuK25zTu1gIJ5CEJtYaJQ3lVCzPqSTc/6oFbLkMPc295spJM6eTP79rGKD2ySe1CW7dO8S7JbawtcX3cGBxUlwrcxk6vXMgvawm7iDaksbaZKKQTa0fUXXGZp3rVUfB6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgLLNlOrbxzp5qxtBgSmvyD8/3N98jZQdIxCqQ99wWs=;
 b=H7VA3Xs5UHc11/bbtjLx8E4rzmBbITVYoMGghk+WZIIXUxMelCdNFhvhQ7ubmWKDFc78aGV9cbldySuZNOH5L1hv6WEXoAyuW8CbpisX05xWdUUimnVKl+k+k0hcjvCnqn/xJ3DL4V+mB5waojM7xn/ZNIXEnktqjJaO7kVi+3U6k3pf7wsdUIPo9zfaNcApZVZ5IzpCM+uu1bmyOfI5cloMXPrEhs91UGbXp4+RrK+C2VpMY5K1KrERCN0ZILhHvf5T4OlhAG+XPZUwyq297TPUJFQoUWHMpfL6eih/TpOMWt3zdyspvULnFvAwcvkd4VI8LLVEkFQHxAqe6dGXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgLLNlOrbxzp5qxtBgSmvyD8/3N98jZQdIxCqQ99wWs=;
 b=YRMJBoV12pT7sLBF8JsfxLP6c9SsGE9Zror8JM5jnTlWF51Iy+OjEtQXHwIODq+NOpAIcmgTQRC009wFGtzomUajiEQtBDcOFbBDkZvgMhj5K8OJPa0povD5RilMune1VjPrcXCtOV/IcbfpHIylxJ9Wbr+RTS6/ol64rfVGEig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8690.eurprd04.prod.outlook.com (2603:10a6:20b:429::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 09:25:52 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 09:25:51 +0000
Message-ID: <c2c4887b-aeb0-4880-8241-058ef26552fd@cherry.de>
Date: Wed, 23 Jul 2025 11:25:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: phy: Support overriding Auto Negotiation timeout
 with env variable
To: Siddharth Vadapalli <s-vadapalli@ti.com>, trini@konsulko.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 michal.simek@amd.com, marek.vasut+renesas@mailbox.org,
 marek.vasut@mailbox.org, dsimic@manjaro.org, jerome.forissier@linaro.org,
 kever.yang@rock-chips.com, alexthreed@gmail.com,
 ilias.apalodimas@linaro.org, pbrobinson@gmail.com,
 paul.barker.ct@bp.renesas.com, lucienzx159@gmail.com,
 skylake.huang@mediatek.com
Cc: u-boot@lists.denx.de, u-kumar1@ti.com, praneeth@ti.com, nm@ti.com,
 srk@ti.com
References: <20250723062642.634345-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250723062642.634345-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0129.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::22) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ac261d-1159-494b-cae8-08ddc9caead9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmpkeW5GU3VVS3N3cFplR0ViNnBTV3EzaFdQMk5XQjBHSWNYUG8wa3NWR2gw?=
 =?utf-8?B?TDhOU1ByVThBRG1yaXN6Z3lUdWg3UDZIdEE4OUlGTjJTNnArR2ZyVXA5RkhD?=
 =?utf-8?B?VEtIZ2pjOU1SVSt1YXYzQ3JlcjBsOWtyT3VibUY3czRzYUNWOG1WMHlydFpN?=
 =?utf-8?B?eWkrWHFVbjJKaFREUHRRa2VKVWN6eGpDWkVrTnZPNnNuQUlZeFlSYnA3K3dW?=
 =?utf-8?B?VDJEUm1CRUQydVpybnZobmR0UDR2N0ZINXlRNVhZcUMxSWtBaHIzT1FTQVRJ?=
 =?utf-8?B?NzJFWkNIdkNGV2V6dU9Rak1JOXJsb2FXV3llSW54U09xWHZQWURMT25rbEVC?=
 =?utf-8?B?QXVicUNPVjl6NEdvTFRheGphOWJwWTFNT2wyUWUrdFBhKzg3aExKdy93VXlF?=
 =?utf-8?B?aklsWTFHYmM2bVNYSnZJNTFQT29wbjlxSTU5aC9jL0xkK3pIWXU2SjBiQUh5?=
 =?utf-8?B?dHJQMy9ZVlBkbm1PQkE0cnNRMTNoN05qZk9wajFmMXBtR1JrNFdaSWFyc2Ro?=
 =?utf-8?B?ZVZTaEJsTHcvMHc2alk5VjRhSWpablV1emdya3BGOW12TEU1YkVzZ201TSt5?=
 =?utf-8?B?bjZNQjRFeklFeGUySFpDZlVjS1A2V0dndktmWmJ4ZkxnYnZmdmNsZloxckd3?=
 =?utf-8?B?dTlyMk5NUjhXNExmandTZ0w5NkVDbmxYVExQN0Myeno0UzRpMXhSYUhZT2Zo?=
 =?utf-8?B?RDROOGlTclJRdVdaVXNCempwNlpnbnpjQ2hxL0pIWitraS9oYkE2azFYQmRY?=
 =?utf-8?B?WlMxYnM5TDlyUUF3NTZZQkw1Ym1QUWhjYloyWTlPSlpnWTFCeVAycXVGdXN0?=
 =?utf-8?B?RVJRRFNSenVCSUhhUU82Tjg1a1NmS2ZCZmxoSjJ6TGxsa2M5TWtzQlpvYmFH?=
 =?utf-8?B?TTFhc1FEMjh2akNMVFp1S1dsNkZDb0FvazVPL3pOdm14RUljTXJwTnFMVnJZ?=
 =?utf-8?B?WW1mMGZtc1hXTUorWlBwY1Y2V1NYcVhIZ0Z4eDU2aDJaS2lNQlc3U0lyYzhH?=
 =?utf-8?B?L0FpMlNOdmprQ3Y4Wm9kTDNZS3U3TWJPajhRUVAwdldwVGNHZnl1dVM0MWE1?=
 =?utf-8?B?alVVS1duOEtRYlN4SmdyVFBXNjI0RTFNM1ViMmNSR0lsSVRZNTJUMmNscGVo?=
 =?utf-8?B?eFQxVFBTb0N4WDhyUVl2ZnR5K3dUVEFRWnFRWjRWQnhxbWJpR3MxR2tVN3Qy?=
 =?utf-8?B?aGMzb2s2aUtGUHZ6d2twclE4N1dKalhwNndzV1lRdWZlbzlJUjVNS2VIUFZw?=
 =?utf-8?B?NzdMa1BPVnVnMlRHZkFYTnlvdWRkdkxXNDUwN0tjZ0VHUFRQaHluTXhyWXlr?=
 =?utf-8?B?VlNmaHovdC9ZeVNRVzBiRUNadjhvZHdGNkhoNlYrdnZFTUd0TjFlQkZqbjV2?=
 =?utf-8?B?aUhsa3JpMlRyZjVZMm5aNEdIM3BiQUxURncyTmZZeVdVSTlSTVNtcWNTZW5z?=
 =?utf-8?B?bXB6Y1RPVWxKY1RwZjZUZGVSOGxCN3VYMjdjSUNJT2V6Znk2b3ZuU3VxVXBR?=
 =?utf-8?B?bjBZNzdEWThJSUd2dVJZNnB1QlptNnJ6M09BWlpBNmJXZGthbVc4Y09yQ0lM?=
 =?utf-8?B?VlB0TU9MdnpPZ2xQemtobmxlWVR1TDNyMHgveWJZekN2OWtKOGFGRVZMYTdx?=
 =?utf-8?B?b3hYeE45VExnaXJDeTJ5SEtNZGxOWDhqVGtCaFoyMmRPOUtDckRYWHRheDMy?=
 =?utf-8?B?ZWRwelNTVXBwUFN5TS9CL1FKUzVsYVZ4am11TGhZRjZYUmpLL1Q2SXRXMVY4?=
 =?utf-8?B?Qm5FTThvbE5qbHBVVXJIMnMrMUdKeHBaYmZRdXlkOUFNR1ByMTNBNGYwUXZO?=
 =?utf-8?B?SFB1OVhEMFFQV09vdmZvc2E4RTFaUFZScmtUUFAzR0xjVkhzdTlxY0xrdE9o?=
 =?utf-8?B?bUp1SjAzR016YnVrYTNZNnJ4bjFoUW1rci8rV2E0K0hPTkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHhhdW83NFZja1JhVHRjZWlvOXdqa1NCNWRXcGFOY3dJZDdtVkQra3llL0JI?=
 =?utf-8?B?U0FUa0ZRdS9maXN0UDBXaXo1VjVUTXcrYXZ6NW4zaWw2Q3RVTHBQN2xwL3kr?=
 =?utf-8?B?empxc2tXMnNFdmg5cFJRZUZ6OUhoNURFcnBvVzN2Tm1hL0hTZGt6Qlp6MWtZ?=
 =?utf-8?B?RW54UU9QNGhEYk9GSS8yeTZmRlZMRkxta0tRUkZ3R0toS1NNdzRldWlPaFNn?=
 =?utf-8?B?UU01a3hJZkZ4dmFjQ1hoZFgvZjRBZHA4bVJFTVVlNVBaNUFWZFFNMXNqT2Jn?=
 =?utf-8?B?Uk4xNEl4eEhxTklCSFJDdHhRMk1jQUpsTHV2WUVkZEwyVFVnaGZTMHByUHo1?=
 =?utf-8?B?Z3M1eW5uVEwvSUZTSllkV3hNR0RadU5meG5vaWEreExGVnFWd1R2UWRLUWtt?=
 =?utf-8?B?SldNVTR6a2htOTBNeE0rUVpHVlA5Y0tQWTk3YlF2Q3VVZ0xsVmNobm94UzJk?=
 =?utf-8?B?cFJiYWkxbkxDVmhoMnNBenpsN1ppeTl6cktYRGxhQ3JQRmhJUGlPQWNsS1F6?=
 =?utf-8?B?WWdaK1d3bHhxM3VWSGUwYXIvc1lWRzZOVUFyU2s1ZDlWNDZINTVJVjAzaHhq?=
 =?utf-8?B?eXMzWTdINEJmMk56SjFrbmxsUW9sZmkwbzFwNTdseE5NV0ZUTC9XNUN1bFZB?=
 =?utf-8?B?QUNXZ0lld1VzVUNiYnFTUlRTMm9JZXRQYWF6Sk9BeUd2NHZRRURBTXlscTZF?=
 =?utf-8?B?YmVpM0VpYmJ5eXFDQ0cvZTE1MWFhYTZQMWM3eVd5NmxtM1dxL3V3Wm1LbVlB?=
 =?utf-8?B?SE1aWWRBQzhmYlZXdTE2aVN0bldPbzhISkhLcEhmeEhWdUl4RVJUaUpmZmFy?=
 =?utf-8?B?ZWhEZ3NNa1hvajFrS2VtTnArcUNzenlxYzlSM2lQbkZseW1lNDg5S3cwQkZE?=
 =?utf-8?B?ZXVvVEE2ajlKY3NXek5uL2RZZGNrR1VtaDFQbkJvaXpEb1JkU3dkbHhJZVFW?=
 =?utf-8?B?RVpjTnkwNXBnMWhpa05LV01LdDFtZkk4UzFwYklYOTZOL0JEdGkwTWZsbEFT?=
 =?utf-8?B?anlnajE2Wkpjalk2TmxaTFlMQWEzNUphU1o3TUNQeCt4MUIwNFR3WGNOSnBD?=
 =?utf-8?B?eWtOYURCNWx5a1pNVUorWTlyOGRram5MWHk3V3FGSFA4RjVXRFh6Wno2M0pF?=
 =?utf-8?B?U3pFMXdBWlhtTWw4VURpUzFLR3p0YWhNYWxEc0syWXNiaGZYZHViQjRueE5C?=
 =?utf-8?B?anRVUFhlWk9xS2U3U0Q2SmhGMmNjc1YvTHlwcnYyQ0E2QVluczk3QmlCbzdH?=
 =?utf-8?B?TGovZ2dTdlVCK0ZEK25hakdLMmx1UEFaRDY5b20zc2tWZ2Q4NmdHRTRDRkt2?=
 =?utf-8?B?L0pYaXlKTkJzVUlPZWJ2cklGd3A0NUhHako5TEhhVC9MSGFkV25lSUkvZmwz?=
 =?utf-8?B?WjZ1R1lVQVFTekVtN3Mrd0tmNUVvMlZTTW5oRnQ0TlhzN3FMUGlsd0NTMW90?=
 =?utf-8?B?aVJKdTNxMjlQRjB1SGFJY3Myb3RzWmhmRkw5Zk92NUloUERLZ3N5VGRHWVFj?=
 =?utf-8?B?STQvNDJLd3BzRVBpZUxLbWt4Z2Q1dXpnT1I0dWZYWFJpbGwveGUwYks3bFpt?=
 =?utf-8?B?UWNaSE1sWWhDQkY1aG9lekpxaGZlWkVLYkpQTXlBOE9PU2tLSHB3MFo4cjkv?=
 =?utf-8?B?V29XU2JScGZBei9qWFVBWTJqL0NjMm1qWktSSHB2aDF1ZXRHNUxlYWVVNXMw?=
 =?utf-8?B?cnQxdmpuanp4aERYQXhPdUNmZ0Q5S2ZxMWt6eXU3VC9SUVlQcSswVTVuMVNG?=
 =?utf-8?B?dUNCWFhlTXNIa3hmN1hrdWdhSThGK3J2bmVmOWc3WkJkZGpCNGtuZjRXZkhp?=
 =?utf-8?B?dGFXWWkrd1RsZnNwSWw1czRMVGV4UzZJLy8yZno2cG1KZFFhMTI3Qll5ZGZG?=
 =?utf-8?B?TGNmNGlSbHZDZ1h3TmJaemowS0E0NUZsbUZHOWx0aFhQc2I5SHhNbHVDSjJQ?=
 =?utf-8?B?ZUkxWkFWTXIxVUVvT3dxYzNlcEZhMno2YWJndlQ3NUFzOHNLb2xMNlB3dUVs?=
 =?utf-8?B?R2ltYlpFN0gzQjZuM1lheEZmekdTUXQxRDhvN1NHS05FUVRKeGJyRGtwVFgy?=
 =?utf-8?B?QUk0ZGNvNXdSNmpWTkEyZ3QwclhaWWtJK0FjMVo1cEFuYU8zZjgvYlNFTmt1?=
 =?utf-8?B?T0VYWEp5Q21acE5TOE4rdDZrZG9IS2h0QnJGdVBIWDBxN2FZajd0SVl2V3I1?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ac261d-1159-494b-cae8-08ddc9caead9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 09:25:51.8712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5Tu8kU1ux/YXl0Vxt736iWYVMaeybSTsnMnLlUulpGskvzE6Jb3GDtzLH+THTNBukHYwT5ptbZh38SR092gWioI7bxGWkrWxx+lFngJ4lY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8690
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

Hi Siddharth,

On 7/23/25 8:26 AM, Siddharth Vadapalli wrote:
> The Auto Negotiation procedure between two Ethernet PHYs consists of
> determining the best commonly supported parameters among Speed,
> Duplex Mode and Flow Control.
> 
> The time taken for this procedure is not only dependent on the local
> PHY used, but also on the link-partner PHY.
> 
> While a timeout can be specified in the form of a "CONFIG" on the basis
> of the local PHY present on the device, since the timeout also depends
> on the link-partner PHY, it might be necessary to modify the timeout.
> 
> To avoid rebuilding the bootloader for a given device, just because it
> may be connected to various link-partner PHYs, each with a different
> timeout, introduce an environment variable named "phy_aneg_timeout" and
> override "CONFIG_PHY_ANEG_TIMEOUT" with "phy_aneg_timeout".
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> 7598b469c16 Merge tag 'u-boot-dfu-next-20250703' of https://source.denx.de/u-boot/custodians/u-boot-dfu into next
> of the next branch of Mainline U-Boot.
> 

Between the release and -rc2 (excluded), please use master branch and 
not next as your base, see 
https://docs.u-boot.org/en/latest/develop/release_cycle.html

> v1 of this patch is at:
> https://patchwork.ozlabs.org/project/uboot/patch/20250722060554.352952-1-s-vadapalli@ti.com/
> Changes since v1:
> - Switched to env_get_ulong() based on feedback from Marek Vasut at:
>    https://patchwork.ozlabs.org/project/uboot/patch/20250722060554.352952-1-s-vadapalli@ti.com/#3550426
> - Addressed feedback from Quentin Schulz at:
>    https://patchwork.ozlabs.org/project/uboot/patch/20250722060554.352952-1-s-vadapalli@ti.com/#3550263
>    by performing the following changes:
>    1) Updated drivers/net/phy/Kconfig by documenting that phy_aneg_timeout
>       env variable can override the value of CONFIG_PHY_ANEG_TIMEOUT
>    2) Updated doc/usage/environment.rst by documenting the base and unit
>       of phy_aneg_timeout
>    3) Updated drivers/net/phy/aquantia.c and drivers/net/xilinx_axi_emac.c
>       to support overriding CONFIG_PHY_ANEG_TIMEOUT with phy_aneg_timeout
> 
> Patch has been tested on J784S4-EVM validating the following cases:
> 1. PHY Auto-Negotiation performed with "phy_aneg_timeout" unset.
>     CONFIG_PHY_TIMEOUT with a value of 4,000 takes effect.
>     => Auto Negotiation succeeds
> 2. PHY Auto-Negotiation performed with "phy_aneg_timeout" set to 20,000.
>     "phy_aneg_timeout" overrides CONFIG_PHY_TIMEOUT.
>     [Higher value than default specified by CONFIG_PHY_ANEG_TIMEOUT]
>     => Auto Negotiation succeeds
> 3. PHY Auto-Negotiation performed with "phy_aneg_timeout" set to 200.
>     "phy_aneg_timeout" overrides CONFIG_PHY_TIMEOUT.
>     [Lower value than default specified by CONFIG_PHY_ANEG_TIMEOUT]
>     => Auto Negotiation times out
> 
> Test Logs:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/3e9cbdfedc541032768b14c15244f590
> 
> Regards,
> Siddharth.
> 
>   doc/usage/environment.rst     | 9 +++++++++
>   drivers/net/phy/Kconfig       | 4 +++-
>   drivers/net/phy/aquantia.c    | 8 +++++---
>   drivers/net/phy/phy.c         | 7 +++++--
>   drivers/net/xilinx_axi_emac.c | 7 +++++--
>   5 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
> index bb6c351b441..b48c11faffa 100644
> --- a/doc/usage/environment.rst
> +++ b/doc/usage/environment.rst
> @@ -335,6 +335,15 @@ netretry
>       Useful on scripts which control the retry operation
>       themselves.
>   
> +phy_aneg_timeout
> +    If set, the specified value will override CONFIG_PHY_ANEG_TIMEOUT
> +    which defaults to 4000 (decimal) millisecond. This variable has

Please do not specify the default here, it may be different per board 
and this would then be misleading.

> +    the same base and unit as CONFIG_PHY_ANEG_TIMEOUT.

+that is, decimal and milliseconds.

> +    The default value of CONFIG_PHY_ANEG_TIMEOUT may be sufficient for
> +    most use-cases, but certain link-partners may require a larger
> +    timeout due to the Ethernet PHY they use. Alternatively, the timeout
> +    can be reduced as well if the use-case demands it.
> +
>   rng_seed_size
>       Size of random value added to device-tree node /chosen/rng-seed.
>       This variable is given as a decimal number.
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 3132718e4f8..7fa1a89fca4 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -23,7 +23,9 @@ config PHY_ANEG_TIMEOUT
>   	int "PHY auto-negotiation timeout"
>   	default 4000
>   	help
> -	  Default PHY auto-negotiation timeout.
> +	  Default PHY auto-negotiation timeout in millisecond (decimal).

Not a native, but my gut says it should be "in milliseconds".

> +	  This can be overridden by the phy_aneg_timeout environment
> +	  variable that has the same base and unit.
>   
>   if PHY_ADDR_ENABLE
>   config PHY_ADDR
> diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
> index d2db8d9f792..72f29824468 100644
> --- a/drivers/net/phy/aquantia.c
> +++ b/drivers/net/phy/aquantia.c
> @@ -552,13 +552,15 @@ int aquantia_config(struct phy_device *phydev)
>   int aquantia_startup(struct phy_device *phydev)
>   {
>   	u32 speed;
> -	int i = 0;
> +	ulong i = 0;
>   	int reg;
>   
>   	phydev->duplex = DUPLEX_FULL;
>   
>   	/* if the AN is still in progress, wait till timeout. */
>   	if (!aquantia_link_is_up(phydev)) {
> +		ulong aneg_timeout = env_get_ulong("phy_aneg_timeout", 10,
> +						   CONFIG_PHY_ANEG_TIMEOUT);

Considering phy_aneg_timeout stores a value in milliseconds, I believe a 
u32 is plenty enough as that would mean 4294967295 milliseconds max 
which is almost 50 days, I think that's enough for a timeout :)

Up to you on the type of the variable but ulong seems overkill (it is 
what env_get_ulong will return but we don't need more). Since this comes 
from the user at runtime, I would suggest to *not* take a signed type so 
that a type overflow is defined behavior (it wraps and is minimally 0).

Same remark for other drivers. ulong is fine as is, just taking a lot of 
space in memory for no benefit.

Cheers,
Quentin

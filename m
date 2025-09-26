Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A66CAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 16:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6202C838E7;
	Fri, 26 Sep 2025 18:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="x9E42ArY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FE58836AC; Fri, 26 Sep 2025 16:54:33 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FB90835B9
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 16:54:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1gUmY4tabluqt9feq/ketmWNoq+9u3ZU8OY4ONJzpHxcCaCmbzqtBJgivdep1nxFprwyfTxBF07tOfTDYEL78ol+BV7W3T3Hny2bOTiyrD6/kZofSMv77APyw5EKitSg5rgZShLYWLRohtc7can7S2HF8aSpP6Cr0VatU6wlJIk8XH2zEZRvWcBup9QF8MPvvdLiYB+k6OqkOJKppUAlSRMCj3mOnQEbMgyOXNlIVHHDzSKUp1VBX7PrtXKGCP9EuA4DAdcYVeUDBCaQE2Xr8T8WTYid3756kflciDtNU5T/8fB4cq48xLmHNYNspEqSfEAKT5CaMJemdbXzwdT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKyTAtrVBPov/IfzWDBRdobzSbiXyxlDWbebOklz1YQ=;
 b=cE80E+nw8S0WnK+U3wGCw2lsZzqvgVGgN5mAJBcnrmvAw4TJI0NWL0vh1UCU4skssHJWfBgbi61DIv3zo3oFoS1/DqdbsyPHevch8vU8owke1MuBzvGGeDrO7Q6EwQiGQtNtF91vOXQwBkShzp1br2vXIFFn1BX4ctRE6xD4/W+YY3IHR9Iz+ownmo5wZHj0pF7NJADWNsAD6XAbQ4EbCSCrWHk1OqCTFuhA631JOCy/UsJpMyWYPNaTjObKDql/WwQTe+Kh4sHTUTawtvFt2/qCCzH7MAcfamuiTpuEIEezRQ+udyFLC2m4RM9tgEmMH9NwQvubZ7NfiNGxlHfS+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKyTAtrVBPov/IfzWDBRdobzSbiXyxlDWbebOklz1YQ=;
 b=x9E42ArYlGjZeZRze3/Mr2iQr6o7Tt7VElop7GaUKrgpAKqGjdeHws1O5oQ46pfmjDrvkhoMcoymQ/d9mA2QR41ZBIaCWziPSyy+SeErKgsINyH6pzuCLzEGKTSN98+zLhJYKIvlgkWByo2OzrZdIS4KMtY1u1/b3Iw98VZ3an54UrwVXfpJH0Pvu0sc88ppj6ShBgGiNxo73LZS0/Gr0k8SQAxwOHN1p/NVuwduCYbvGlQgr//vGVmKFC1pahA40KgcG/+AsUXgbQcl+9q2jG9QuTv7L6YjhV2q42mxFxg18dFlTJdRzn98PDJbpK6jPZ3hhnaBJeiEoIRm5y28+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB11141.eurprd04.prod.outlook.com (2603:10a6:150:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 14:54:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 14:54:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 27 Sep 2025 00:06:15 +0800
Subject: [PATCH 02/10] firmware: scmi: smt: Use io helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-scmi-v1-2-5e9354fb3bff@nxp.com>
References: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
In-Reply-To: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV2PR04MB11141:EE_
X-MS-Office365-Filtering-Correlation-Id: b4836268-5ca9-4457-4b20-08ddfd0c983c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ek1nUWJDYktaQkpMdk05d0hleU02UWMwakdQMUdvb3ZxNUNhZ2FzWFBjeGJh?=
 =?utf-8?B?OEhreTNMOEp2c084RjhLSWIzbENVblFWcGJGV05YdThkVTRPNlZqdFhKN2V5?=
 =?utf-8?B?ZEhndlNSM3VqQ0FJdHlIOEF4ZU5PZ1kyVk5XS1RmSjYxZWUycHplN3dOdjYy?=
 =?utf-8?B?N1kvWFZJMld5T0czenc1MDVVUVJJbTBHYkl6REdabFdxN2ZySHN0R3hibVdG?=
 =?utf-8?B?T0tJUlpta3h4bWZKRlAveDJmOGppZHFTelJhOVJKTE1EbHVlT1lhYXpvMTlW?=
 =?utf-8?B?MnR6eW5peGVhZ3B4b1RVTkc1aUYrMENWZ2Y0djFxdXozZms2VUZoKzVyZ2Q1?=
 =?utf-8?B?djVaK2N0OGo5YnNHTlZjd3N2SlhlSjQvNTlQeUtWSVMzZGkyMmZ2SVJXTkdq?=
 =?utf-8?B?NzQyMjd6UGg1NUN0cFVnbHlSbkN2d3Q3WEJ0WFZMaGRFNDhkZzhRS2UxdUhs?=
 =?utf-8?B?enhMWUJrb0NTTCtDcERiOEgzYmJsTk9VMjREUnl4SUhmemhnR3JCUVQ3bjJu?=
 =?utf-8?B?Uk1KRzVSK0pLRS9yM0duSnpQdTkya21odndGN2xWOEhTN0VTaVJMMkVpRzNW?=
 =?utf-8?B?ZjZCUnk2QkRnNkJmNzJzdWJtTFJreGNZTDN3RHR1Skc4ZG15alF0WEpmUlpG?=
 =?utf-8?B?UjRkdEZBcjhVSXJKZWpTN3lqTXhHaUVDQU1UL0FOTUdJOHlaU0FUaVkrSWZU?=
 =?utf-8?B?Q1p1NERwN1UyV1NGZTNtTGNZQkF3VXIwWTJ1M0NJR3VxV2MrV3NSLzNSeE54?=
 =?utf-8?B?OXlKSjNLQWdKamtCVFV2LzhVRzFTL05zS0Y4SEVTTWExYVd3a1JmUVRyNjlT?=
 =?utf-8?B?akJuV3RIVkVkaVRjMXYzaHlCbnVVTTh4QUwwOXJ4U1NLSTFGNENKYzV2TVZH?=
 =?utf-8?B?T0VLZWJIbTFKdVdrMVpnYUdjY2pZTUU0K3BKQk5zTWxiM3VEZjBUTWY3ejR0?=
 =?utf-8?B?dzR5VmxlQjh2RVM4d3hpRWViL0VPdXU4bjlvZGkrellUUDNnWDZQcWNHcmhL?=
 =?utf-8?B?ZGZ5Y01ycjBiWXAwcURvQ3hyOEM2TXdza3RIbXZUaHZhWCs0bnBGeHdaTWts?=
 =?utf-8?B?SUxEeFYvbGNKbkJNZUttVGF2dGozSlJ0aEZtbG5CMC9HQy9FcWsvZ3RmRVRQ?=
 =?utf-8?B?eTM2elpack9aWjloTDNINGd0UGJUa0tHN044bndVczB6K2JOUk9YOFd3RGpQ?=
 =?utf-8?B?Z0VHbDhnbVAxVUxXS09UVmt1MkRKQmxCNUowL0c5Zm5vbzdObEhHb2VyK2RU?=
 =?utf-8?B?QUhLenZ4SUVzSjEzbUNCMHMxbVoycnFEeVQxb0s5MWE5TmdSc3p5NWhBQnM1?=
 =?utf-8?B?ZE1ySldjeTBSNi9nd2prczg4YzNIR3VNRysxSkxlMmVCbUZDVmUrQWtHUDUv?=
 =?utf-8?B?UU9JK1RiczQzU0M5d2tNWkc3cVUvQW1TUXNVbmtGWFRDOG5naTNlYjZPVkZs?=
 =?utf-8?B?NVBxRmdsak9BUkhvSFBhWXVwajZ1MXNyUXNOREl3M3Y0akNKNTQyYkg5Q1Fm?=
 =?utf-8?B?QkgrVnJqLzI1QWpQS3pDeUtTQTJZTDlvdjdTRzI0T0d3cEVacGdJUklndzlZ?=
 =?utf-8?B?MmpYeThpaXMxWEt5VXE2WmRya3BiRkZsdkg3OTZDUS8zdEh2cTkzclhudGZQ?=
 =?utf-8?B?MEVhZU84bGJNMGQ3UlVvdVNsSXJ2Wm1pYXRBUkhocFQ2STc0YTZ3WEdpQWJl?=
 =?utf-8?B?R0FHTnhObWxNbkpXR1dLTHNPSU4xY0UwbzNQTy93Q25iODBNRUQzRVBFZHVQ?=
 =?utf-8?B?R0FlTTEybXlwMno5dVFCTDhHWVJMMW1tdFlpc3VDKzl5UTBOSkRPVi9FSG5w?=
 =?utf-8?B?WnkrckJDWU44QUt4VVV3dXFhWWFtTUJzSVEwdWFHSXFGcEN6UVkxTUd0WEc1?=
 =?utf-8?B?QW8yKzVKdDE2YncvNmNJRmJXbHdvRUFybncyUUZzNHNKVzRBVTlzTFJ6K0tj?=
 =?utf-8?B?QVNRSTBtcWRaYjM0bmJlR2QvaEhwTDJFYVNnOWh6WUR2bkVXN2Y3aEtzKzlR?=
 =?utf-8?B?U0Z5dWtNVE13PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzRQaitqOE5YeHVBc0Q5VVVGUm1XM1g3ZDhGVlRtWlUzbTlxMFBVaWJwWWpn?=
 =?utf-8?B?QURkUmRUTmgxalhoSkxNY3RjNE82WWZDenV6Z01WMXIwTmpSL1RmeWVGSXBI?=
 =?utf-8?B?MExJa2cvUmpHMlZhbUNjNUVXRlFkNUJkZXR6dFRHNXpPKzE4R0duNE9UUlpJ?=
 =?utf-8?B?dksxSml4V3BuZUZhOXFUbjFWMnRIQjFHY2tkdWVDMS9sOWRMdElXSjFEWng5?=
 =?utf-8?B?K1VMM3hUUVVuSlZ3Q1ZtSkFnZEc4Nm5QV3lNSENFR3d4S0VkTVZ6ckZEejVE?=
 =?utf-8?B?Ykkwc25GK2xrSjFabmtNd0xpbURZcVBOdUpqSktOUklyNTdFMGxVL2tnNGVa?=
 =?utf-8?B?Wmgzbnp5MEt4WkxVSjBiZTlxV3FlalZLZld1cXhBUmxORGVqZFRnc3ZSN244?=
 =?utf-8?B?cmpiR0tkMTBsOTg3N3k5WDNEU3YwcUVmRzFsMk9TdVN5cEZESEE3RTc5Nzls?=
 =?utf-8?B?UFAwUzBUMGhvRFljV2FVVGlZQzdRckdMVVI4VUphN0hVckQ3MTRVS01aWk16?=
 =?utf-8?B?RWxycnJ4NUdHbk5rZWEyTVhrNS8xdVJLV0dlMCtVZXdIZmVhR3ZvMWhXT2xE?=
 =?utf-8?B?ZjhWSVdoQlVWeWlsMDR5RFQ3MVhZYllUbUljcWJlMEZTajFNb1RxYUN3RTFw?=
 =?utf-8?B?UDgyTlBsK0Z3ZUM5eVBzaUZvdXBVY1RjNllkaTBWaEVoN29ZWDh0UTQ0d1NC?=
 =?utf-8?B?bmUrS0ZVS2gxR1VFWnJwSVlHY2dQbmlNRHBETEJHYXRQTnh3RGRQa1NBczVi?=
 =?utf-8?B?VGZpdndRZmVjdWJac2JiaHAxaXk1aE11S2dJZHVwalMyMTdHZFdhS2lVdFhw?=
 =?utf-8?B?ZzZZRDUzMHFRZ2xNVHcwZGplUjVwZDdvS1ZEekxybFJyQWJubFhxdk9ialY1?=
 =?utf-8?B?Q1NFRklSRDZ2a3hqVC9mZ0sxcVQ4ZG9wZ2s5cDNIVndlWTFnQjZFZk5KWHdY?=
 =?utf-8?B?c3JSNW9EckZvckVHNTVIaTg4eDBtMEpVZW1sWEtndzRJeUtXQWtBT3NoYmFh?=
 =?utf-8?B?YUxkK2F6dEo5cyt5V1lyRlBzQ2VBcGljSzIwS0ZPNENuc0tFSWxkWndhRmdo?=
 =?utf-8?B?YzBBbC9JWUNkMEZsU1FCQzc5ZmZXKzA4MytVejhZaEMxcGpFejZjRXdiQjZJ?=
 =?utf-8?B?a2JuT3ZpT0gwdkwxOVVQWDZJeTlIckQybHQ1Q3h1TGVrNHhVbUltTXRtNlQ4?=
 =?utf-8?B?WFJIUjdPWUhFR1g5M2EzQ2cwOUxBeURpTFpoL3dUN05lUE9ZOFdnVjlXMU5G?=
 =?utf-8?B?b0lxQWhmMjA3dVp3dTRtM3VvYUpTQmZKZE1QTSt1bSsrK2k1c0dvZ3VkZE9j?=
 =?utf-8?B?QkJQZmVhbnFxeUFPSG5FeFB3RUVsSDErRDNlZC96NURYQk0rbSsxSm9zRHZo?=
 =?utf-8?B?enE4UkxlcHZhUm9DVllNUUJ1bTBTNHRtbTMwK21QVjdIdnFBMk5sb0lBZGdP?=
 =?utf-8?B?VmtBZmEvYXphZXhjN054NEMwODNTQkRjSG9oZkNhT1hNV2pvSDZ0WmJzWVlO?=
 =?utf-8?B?UWtVUmo1V0J0M3ZhMXplclNvVW1uK202T3lsQXpQamFaNHFMYm9UbXB2UmRK?=
 =?utf-8?B?UDZpaEM3NUpjMUdRRnplMS8rUENyZGQrUEswYXhhOVY2N1VEdUZHRjhLU3N4?=
 =?utf-8?B?MHlNM0tic3I5NEhWY2RuZkJUTkEvaXZaV2RCMG8wbHBPZUI3ZjY5a2FJbnEv?=
 =?utf-8?B?bEhCZkxxSHMyQkhNQUY4SFhLOEVtRm1JYVJCRW1EQnlVNlNSYkVUS1VEN2Jp?=
 =?utf-8?B?NU8yV0FhRTJRbjJnOEVPT2NPa2JGc3E2RS9oclF2T256WXpwUmxkZUFiK2xm?=
 =?utf-8?B?WnduUndUc1d1WFJKNUJlY28vL1hHZzNtRjBaQjYyUmZsdTJRZXZjVC9GQ2hG?=
 =?utf-8?B?djZJQlFyVmFxazRCMDFYYW05Zk83cGFHYjhnRTJLckdQRHRyRUZtWkh3OUdJ?=
 =?utf-8?B?VUlwN0hWV1kxUU9FMWdQTDBkMjZ5K0paMng4T1MvSEhhSVVlNkRhVFNMQzN0?=
 =?utf-8?B?NUhBOWNpVUFqUmxDMDhaeTNlMVdQcmw1L0g0RDIwbWlZN0k0dFkvUFZZaExG?=
 =?utf-8?B?dWxrOThqaWVBejBXWXpzZXFIZE9sZ2pIRjZZNjJ4L0tlWHpWd1lQRnNwVklV?=
 =?utf-8?Q?mneKsTiF9zhPliKXV3nju9OlR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4836268-5ca9-4457-4b20-08ddfd0c983c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 14:54:29.5652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPK4pKsrXUtFQSIPBpoOeXm5sJ+hckRSCu1lyjkwTqeCtSWAwUrCoRKHAAuplQhPl2QgunDxbKYV/OpCk6/NTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11141
X-Mailman-Approved-At: Fri, 26 Sep 2025 18:06:25 +0200
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

From: Peng Fan <peng.fan@nxp.com>

It is not good practice to directly use "hdr->x" to read/write the hdr,
because the SCMI buffer may not mapped as normal memory. Following Linux
Kernel, using ioread32/iowrite32/memcpy_[from,to]io for smt header read,
write.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/scmi/smt.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
index a7721bbe54ee286fe88dabb7e015944feaea2843..8bc721c664794e6629c50939707a756786353f9b 100644
--- a/drivers/firmware/scmi/smt.c
+++ b/drivers/firmware/scmi/smt.c
@@ -25,9 +25,9 @@ static void scmi_smt_enable_intr(struct scmi_smt *smt, bool enable)
 	struct scmi_smt_header *hdr = (void *)smt->buf;
 
 	if (enable)
-		hdr->flags |= SCMI_SHMEM_FLAG_INTR_ENABLED;
+		iowrite32(ioread32(&hdr->flags) | SCMI_SHMEM_FLAG_INTR_ENABLED, &hdr->flags);
 	else
-		hdr->flags &= ~SCMI_SHMEM_FLAG_INTR_ENABLED;
+		iowrite32(ioread32(&hdr->flags) & ~SCMI_SHMEM_FLAG_INTR_ENABLED, &hdr->flags);
 }
 
 /**
@@ -85,7 +85,7 @@ int scmi_write_msg_to_smt(struct udevice *dev, struct scmi_smt *smt,
 	    (!msg->out_msg && msg->out_msg_sz))
 		return -EINVAL;
 
-	if (!(hdr->channel_status & SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE)) {
+	if (!(ioread32(&hdr->channel_status) & SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE)) {
 		dev_dbg(dev, "Channel busy\n");
 		return -EBUSY;
 	}
@@ -97,12 +97,13 @@ int scmi_write_msg_to_smt(struct udevice *dev, struct scmi_smt *smt,
 	}
 
 	/* Load message in shared memory */
-	hdr->channel_status &= ~SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE;
-	hdr->length = msg->in_msg_sz + sizeof(hdr->msg_header);
-	hdr->msg_header = SMT_HEADER_TOKEN(0) |
-			  SMT_HEADER_MESSAGE_TYPE(0) |
-			  SMT_HEADER_PROTOCOL_ID(msg->protocol_id) |
-			  SMT_HEADER_MESSAGE_ID(msg->message_id);
+	iowrite32(ioread32(&hdr->channel_status) & ~SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE,
+		  &hdr->channel_status);
+	iowrite32(msg->in_msg_sz + sizeof(hdr->msg_header), &hdr->length);
+	iowrite32(SMT_HEADER_TOKEN(0) |
+		  SMT_HEADER_MESSAGE_TYPE(0) |
+		  SMT_HEADER_PROTOCOL_ID(msg->protocol_id) |
+		  SMT_HEADER_MESSAGE_ID(msg->message_id), &hdr->msg_header);
 
 	memcpy_toio(hdr->msg_payload, msg->in_msg, msg->in_msg_sz);
 
@@ -118,23 +119,23 @@ int scmi_read_resp_from_smt(struct udevice *dev, struct scmi_smt *smt,
 {
 	struct scmi_smt_header *hdr = (void *)smt->buf;
 
-	if (!(hdr->channel_status & SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE)) {
+	if (!(ioread32(&hdr->channel_status) & SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE)) {
 		dev_err(dev, "Channel unexpectedly busy\n");
 		return -EBUSY;
 	}
 
-	if (hdr->channel_status & SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR) {
+	if (ioread32(&hdr->channel_status) & SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR) {
 		dev_err(dev, "Channel error reported, reset channel\n");
 		return -ECOMM;
 	}
 
-	if (hdr->length > msg->out_msg_sz + sizeof(hdr->msg_header)) {
+	if (ioread32(&hdr->length) > msg->out_msg_sz + sizeof(hdr->msg_header)) {
 		dev_err(dev, "Buffer too small\n");
 		return -ETOOSMALL;
 	}
 
 	/* Get the data */
-	msg->out_msg_sz = hdr->length - sizeof(hdr->msg_header);
+	msg->out_msg_sz = ioread32(&hdr->length) - sizeof(hdr->msg_header);
 	memcpy_fromio(msg->out_msg, hdr->msg_payload, msg->out_msg_sz);
 
 	return 0;
@@ -147,7 +148,8 @@ void scmi_clear_smt_channel(struct scmi_smt *smt)
 {
 	struct scmi_smt_header *hdr = (void *)smt->buf;
 
-	hdr->channel_status &= ~SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR;
+	iowrite32(ioread32(&hdr->channel_status) & ~SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR,
+		  &hdr->channel_status);
 }
 
 /**
@@ -171,12 +173,12 @@ int scmi_msg_to_smt_msg(struct udevice *dev, struct scmi_smt *smt,
 
 	*buf_size = msg->in_msg_sz + sizeof(hdr->msg_header);
 
-	hdr->msg_header = SMT_HEADER_TOKEN(0) |
-			  SMT_HEADER_MESSAGE_TYPE(0) |
-			  SMT_HEADER_PROTOCOL_ID(msg->protocol_id) |
-			  SMT_HEADER_MESSAGE_ID(msg->message_id);
+	iowrite32(SMT_HEADER_TOKEN(0) |
+		  SMT_HEADER_MESSAGE_TYPE(0) |
+		  SMT_HEADER_PROTOCOL_ID(msg->protocol_id) |
+		  SMT_HEADER_MESSAGE_ID(msg->message_id), &hdr->msg_header);
 
-	memcpy(hdr->msg_payload, msg->in_msg, msg->in_msg_sz);
+	memcpy_fromio(hdr->msg_payload, msg->in_msg, msg->in_msg_sz);
 
 	return 0;
 }
@@ -196,7 +198,7 @@ int scmi_msg_from_smt_msg(struct udevice *dev, struct scmi_smt *smt,
 	}
 
 	msg->out_msg_sz = buf_size - sizeof(hdr->msg_header);
-	memcpy(msg->out_msg, hdr->msg_payload, msg->out_msg_sz);
+	memcpy_toio(msg->out_msg, hdr->msg_payload, msg->out_msg_sz);
 
 	return 0;
 }

-- 
2.35.3


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D0DC3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 13:48:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF3B78219D;
	Mon,  5 May 2025 15:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="bJ4pSybW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64F2382999; Mon,  5 May 2025 15:48:49 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 468D58219D
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 15:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPORPHGWfVvSZV83nDIntv0tO3OUt/dkgZetGEHc0rMNHBeh4v/GfNQxjLWXDUUL3lY/Orge7j8re6x9h1vV6qFMLx8ml1fDTlFmWzA5GbgVI8xqWm7ss5EzO1iT2UeJmyCMDFxfDW/lvJOtoWEZJPLyWgkgEJmkor02TpAvkA9gssunedpfvpHU33sg7r6Bi1dPud2kGYMzsqsfGJMLhK+veguvchSCOfnJd7bUDokWQ76JsscNSY4nnycaaCFJ0+shVtG4v/UHEWLKf6Ki9TK0FBeD1ysd5kIeaTybqbaVmyEv3Z1Km0HOMl+BYhnK5jWc6UkwEigEjFiex7to5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqd6zXVkqlZaO16Rxrjpe9a+oQmxtQWV4ANH6OlNlqI=;
 b=Z15ZHtaIH50FGKPXkCNgQ0R9oLLlpqB2oQ7tMH+uWjm9VSPJNnw89/5yrs4etsrUPpg8tO9aAaEZ6NpX0qtqTUTFedeMNZ/lI9JI90XAKHI+fU/BsazSkqup1gQ/wimP69I09GejSAMDe11DRITf/l2Q/nGpxAxpi1qzKFSOBAh50qtcVnM/YGK9ptG1G/Oyf/iVN4XXtNBxIppInQ86zb/WgR6ztd3o6mKkWNXHOiheKMbMK4kkQccP4N07k1omGqrsqCO2UKaW7m8iy+W7vkZVLJWwoANTtpuRT1b70Pmq6y3W6u2YCV60j3vLjRFDZ6r1Ci+YOOwgIIUTNC9A9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqd6zXVkqlZaO16Rxrjpe9a+oQmxtQWV4ANH6OlNlqI=;
 b=bJ4pSybWBZOZFB4FsVSkZIjTul/WQ0VjhQ6EzB4dCEiOWuUqFCLl7hDcJmIoWO3k+JjCSvlr3Ku2WoX5cQWL5miraZabzjQNTn3nB5Er45EwhT1GJpu64SxWHp95muA8nl9wBldrEu+CBEeZ+r6PW2XX9+Ib6B55KMWeMxMDQlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB9134.eurprd04.prod.outlook.com (2603:10a6:150:25::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Mon, 5 May
 2025 13:48:43 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 13:48:43 +0000
Message-ID: <8216a50c-43bf-4055-ac91-4b921441ee63@cherry.de>
Date: Mon, 5 May 2025 15:48:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next RFC 0/5] rockchip: panic() when DRAM init fails
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>
References: <20241105-rk3399-dram-init-v1-0-1e29acdf0966@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241105-rk3399-dram-init-v1-0-1e29acdf0966@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e14f58d-817f-46f3-3686-08dd8bdb8c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXd2bUF4TVArSmN6cm9rVktBUnVKL2U2S0tNb2pManB5Tkd1S09OOUJFNk03?=
 =?utf-8?B?L3QwSmFPNldyNEFvZE5BZGFJUjQzckQwaW1nSXJmQTJNYVM0UU9LeENjSnRt?=
 =?utf-8?B?Rkd0aFFnZHpwR0d3bE02eVM0WkV2RGV6SERRT2ZCVFB0OXNhaThCTDFkS1RF?=
 =?utf-8?B?ZHlvVmhGaHVUL0I1RlFUT1d1MUZCWlYyN0pZdkQ5UlIySm4rQjFJazFiL1Vx?=
 =?utf-8?B?SUpzUDVYeklncmQxOEtzMEs2UnN3QzAwZUhPNG1ENUo4cFF6aDREbHROSUhU?=
 =?utf-8?B?YUQ5dkYyOXRLcnRnZ29wVnJWTm03WklPaGlDbnRjSzFmaE40aUNQVmdCSHRj?=
 =?utf-8?B?c003SjZub1dTNFI1ZGdzTkRWRFZWQ3NUTkplL2NMdkMrWlo5NnJla25iL1Zi?=
 =?utf-8?B?NEw0UGdicGk5aFIwbGhpb002RjdJRkg4dEV6SWlXNGhWR0JtSzJkbG9scnpq?=
 =?utf-8?B?c1JHRk9FVjJWZXpSamhzTG5kL21rbkNSaWpvbmwyWGZYNTloWkQ2OWdBaExN?=
 =?utf-8?B?RDRpR0tMSWhWMFRrZDJtM1AzSEpZbDlqQ0JzZExTazU1UHpjbWUrMXV0akxr?=
 =?utf-8?B?TXJrK2xQRXgrTi95cDd3VkovOVlrOFV0RFg0UnRPc2NxNEtZNEU0NWlJV293?=
 =?utf-8?B?d0F6RFRhc1RqZ24wZEdwdHZvdW9Mc2NCN213ZXZlRmJtbEhTeUVJWkFVVEto?=
 =?utf-8?B?N2h2d3VNc2x3TDdYZUJld21WTUdwQ2t4Z0JYRlZLdndEVjVCNmxoemFHUW5E?=
 =?utf-8?B?NUdVVEVKN1lUWnZoQlFoNzNyZTlIbnU0by93RmZ6bGIxVGJQVTJYVGJNbDkv?=
 =?utf-8?B?akVEcDdEL1k4dTZpNXpzSko5VDMrSVB6d2pHOGVaVWNIV1ppYVdMbkRMY1lQ?=
 =?utf-8?B?bUVLVDdvVXBtK0tMUURPNDROQmozczg1K1VodFV2ZFFGYVZoK21TKzFlaVFq?=
 =?utf-8?B?cFE2cFVKYjlPZHBPUlZUWkNSclJZNk41L1ROeWdHd3dzU1BTWU1KMTQwVlUr?=
 =?utf-8?B?QVlYTEw5RG5qQkFtSDVHd2lndDJLU1NETU44cHBmVFV3a0VUL1krNE9YRWhO?=
 =?utf-8?B?OHJObjhwWXRzK3FLOUtaUGp0TjQvSkFkeGYyTkQ3RGVQSDQ0VU9UallkTTN3?=
 =?utf-8?B?SzdicWtBWktBMkQ5SVZNMzNsOGRqV05nQUtSTkdUTzdTanB2bjJ6OFhIbXlF?=
 =?utf-8?B?bkhYbWc0dFVZbkZPcE5xMXBReitHN1ljNXdNbU9NZU5xU0lrMmxHV1ZLYTlH?=
 =?utf-8?B?SG5tNDR2Q2NlU040Y0d4VkFZdUNhd3BQaFZ1T0pXSStRbUhYUXRLdUthVWtH?=
 =?utf-8?B?eUNxbFdZTWlJOG9YekVyMTZmd2ViOFVLVUVrTS9raEVlWmlxaksvRDJ2UUE5?=
 =?utf-8?B?UmNucFkyQVRJdlVoOWJ6RXZNd0FnYkJRR1dqbFhwdkt3bGxubnZudEN5MThr?=
 =?utf-8?B?SUowTUY4WktPTTdnWTk3RzNyaHVKaVpWOHp4dzlFZWtRdUpma0VtS0prc3VW?=
 =?utf-8?B?SlVFMlUvZ3I1NTVrMnVCNW1oRWtraTBVWDFJRktCNmFzRmxSUTRqajRmRDdr?=
 =?utf-8?B?amk5WFZoanhXbFFWUnM0VnE0ZE95a3AxNlQ4dWQxL0xyNmJLaFhJdkRNckp6?=
 =?utf-8?B?R3k2eVpreWZBOXhjc29vQUtrdWRtckpJcTRldVVuR1MvLy9TV01NUXlTM283?=
 =?utf-8?B?NHpJYkJqbE9qSkRxdlFmSXVVUG03UUg5cXBHWHFWUGM1d2tNa0NyTDB6ZG1N?=
 =?utf-8?B?VHc1MllTNTVhVkZvd215YzNQN3NGaStBcmF0RE9ZQm9jTEhtNlVFbUl2NWFp?=
 =?utf-8?B?NnNkUjFMcTdYYmxpZHM2WkNXTm15M1FmN0p2NW9lRzNMSithWXNycnl1bzBt?=
 =?utf-8?B?TXdwT3pMSUw5Qks0VnFpSEdIejV6aVZyeGVrRS95bHRObWk5SEpzVlVjWGor?=
 =?utf-8?Q?Lw4aNELHHvE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlJLUi9FZTBEaERXTGdNbGZqdlhkL3B4emprWmdNc250Ny92RUZETW9KSVlm?=
 =?utf-8?B?cFkyYTVMZG9pOTZDSGhMcmVHT3BYREVJOE1NbFdBcE9XRUF1dnJGVnJyUU9Q?=
 =?utf-8?B?cHBUN2k1bkMyN2cxaUdyUFlrczByT2JBSkRxTDFYMjI3T2dmSVluWEZub1JS?=
 =?utf-8?B?aXpUSXlIN1ROWDA1THVBUmpWRW13T2xmSEVMMVV3UG5NbWlqRm9WVk5RQUVK?=
 =?utf-8?B?bUQrSmZaMmJydFlYQkcrOUV6aFF0M0hUZnl4M0dseEo0QkxqUFJ2dlZxdHJn?=
 =?utf-8?B?MDhPczZ1Qkdjc2h4RGQ2TStHR2tiSEIwTWREWTlKUzNDOUwwaStYSWhwKzE2?=
 =?utf-8?B?S2JEMGNyOVc4RS9pRkN0b0JNNzY2dU5BZnlzOG10ZTZVRU9rR3F1cXNCd0t0?=
 =?utf-8?B?RjV6eGVQVHdZdlkweUs5T0tXd3dHbXRTaHAvaG1Ic1FBbXRkTUJ6aU5GOTY0?=
 =?utf-8?B?UThKTVJZNTNmRjMyZVk1VTFUWExuRVEwKzU3NmtndHVqdnNleTJQZ2tuWDRt?=
 =?utf-8?B?VGtnam9jK1I4ZkdPWTUvL29nRG53K2hCZjRaaDNoVENCVDVEcVdrNWtIc0xn?=
 =?utf-8?B?L1BYd25BdmdUVFVwYTY0K3JKblUvbmwxNGQ4Yjh4MGw1em9DdTkxbWd3Zk1C?=
 =?utf-8?B?NC9IQllJeWdaWHk2bUl5M1JUeVNTVWJaWDFKd3M2azFyeVMvLzdPaFZyc1hU?=
 =?utf-8?B?NDFwNDc4dDhCMWxYbzk1bTJNNDY0SEN0MmtpeEJxa2h1R0M3bUVsU0d0U2pq?=
 =?utf-8?B?OHlhc2w1c0pNdzBuWU9TajhaRTVNNmwwam8vUDZJRG1xM0Y0VUVwazFtenZ5?=
 =?utf-8?B?a2tKbEpvN0JtSitnNWZoYlZud1ZkNWIyeW84Z1B6QVRzZ25KZDVCL1h5SFZ6?=
 =?utf-8?B?cVBkdjRSa3hvU1FYbEhyeWtSaHJwdnhHUnZkNUZjZno2QzJFc2Q1YlJDZkxU?=
 =?utf-8?B?M3NWS3J1ZDQ3MHdTVmMvUlpSOFUraGdnN2VRaXZaUnVJWjZZMDBXbzF4NWQ1?=
 =?utf-8?B?RUN6TFZaOGFkRnBlc1hPL3REZnZBWlorMEZtaFJBczBhZzNsUE5CdVZJRlVk?=
 =?utf-8?B?SFhDeHJNMHllVStxOWh0bjBLSFZWU0VKL09pZ3VZWnNEaUVxVG5vSU04aytI?=
 =?utf-8?B?bnZDUDZZVkxpRzdsT0k3OE41dG0vZ2tLdTljZEV5b1lXRzdpN1hpTHRhRzJH?=
 =?utf-8?B?VnM1MjRZUFVNc2p1bldlYTJrdy9ibEJjOU5sMml4VkxIUGhCUnRBdllQSy8x?=
 =?utf-8?B?K0xFczhQc2M2U1RXSUVFWmQwWDE2WjVHSkNxYkpFd1J1cGhIWnBXWjMvaGRS?=
 =?utf-8?B?dnFuSVF6ejQ0QVQvamlwcVIzOUtIaGtpYUR6TEtvZkk0OTNJb1prWHRycWF5?=
 =?utf-8?B?MjhvS2hhOVRPZ0RUY0JPUVBOUkFJeFJHZVkzdHdkbm53aUwyMDlhTGt6aXZo?=
 =?utf-8?B?VmwwbkhxdVFVYWJwQU5wK013dFFWNXYrK3V5aUt3YUZLTXJNVFV4MkFucWFW?=
 =?utf-8?B?UFExMmc0TmluM0pucDZIT2Z3ZGg0WGo0VzVJMzlNdHZWK3ltTmdpcTJFMy81?=
 =?utf-8?B?TGVuUC9Tejg1dWJyWmU0azMvcE5UMEJaZjFSMHF2QzB0V3dGSzhzcEFGYmlB?=
 =?utf-8?B?UHhBcjFUY1RhNlJVbFBRUEgvNzZENTQwL2prT05nMXcwUS9uVmVCRXRCM3U3?=
 =?utf-8?B?LzVJY0g0WlVhcFIyOG1GVFlzZHl3bXZoZnZUZmNQUVcxTEwxSmV4MnRkL2xi?=
 =?utf-8?B?RWsvZHJ2TGVoVmg1em5TMEhwWGIxc0I2Z0kza2dTSEx6aVFsSjY1YytDa2JX?=
 =?utf-8?B?aCttSE01N2RodEg5Rkg1NHE5QWNZQjFTSUNCZDdtNk9jV3B4am55cDlSRXZG?=
 =?utf-8?B?L0NUV0pQNktyM296TUZTYTA0V1RUVjVPbGIvbFIwK0RLUDI1dDZyeEExU1dw?=
 =?utf-8?B?QVJLaExlYnhKQVZXRjVSWmdWaG5zQkRmM0V6UFRYYWZLaXYzd0paSWpKUjVj?=
 =?utf-8?B?clYzQWN2bGEwd1UvNVRWT1orTUtFaHlnSlgxbjRDNERrdm5JdkRhNG1RZitX?=
 =?utf-8?B?bElLNDg4NWZ4d0ZnWmlpS2s0WFZiRS8wbTNkZzJJbUVvUWlWS2tJbUFvazk0?=
 =?utf-8?B?VFpHOXMzVlg3ck5oWkZhRG5LTDJxQit4eEQ2RTNsUEJmN0FLZzVvYlByOVlN?=
 =?utf-8?B?dlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e14f58d-817f-46f3-3686-08dd8bdb8c8b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 13:48:43.0088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kerysj1w5ZeAv7/nEKakkyVdxFuhRkwIEor//D9GqNL37QUdLg0YNHBOyEa3w5jpzezuByJbJcyetoWUxTKFnvcUWH8SdJguouFFbETRfaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9134
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

Hi Kever,

On 11/5/24 6:21 PM, Quentin Schulz wrote:
> I am the unfortunate owner of an RK3399 Puma that is failing DRAM init
> every now and then with the following cryptic error message:
> """
> pctl_start: Failed to init pctl channel 0
> """
> 
> When it fails, the current logic is implemented in such a way that the
> board enters an infinite while loop. This is not ideal for embedded
> systems that are not easily accessible and also an issue when having
> devices in a CI lab for example.
> 
> Therefore, let's simply panic if the DRAM fails to init. This was tested
> only on RK3399 Puma, similar changes may be required for other SoCs to
> properly propagate the errors.
> 
> While this is all but a work-around instead of fixing the DRAM init
> sequence, I believe it is important for resilience of devices in the
> field.
> 
> Marking this as RFC because:
> 1) panic()s for all Rockchip SoCs but only tested on RK3399
> 2) unsure about error return values (ENODEV and the likes), not sure
>     what would be better than that though :/
> 
> Note that one can still hang() if they want by setting PANIC_HANG
> symbol.
> 

What do you think about this series?

I believe we should be able to merge everything but the panic() and fail 
DRAM init on pctl patches without changing the current behavior?

I could keep the panic() and fail DRAM init on pctl patches in my 
downstream fork if there's no interest but I think it makes sense to 
have them merged.

Cheers,
Quentin

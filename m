Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83526C71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 12:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18B4682CA0;
	Fri, 13 Jun 2025 14:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rRZ6wFkn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F78E82CA6; Fri, 13 Jun 2025 14:51:13 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09308807B1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 14:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtgC0w8Bz1DS3iHr+wWptSFBgFBcimgI2BVl3E9LvGGKl6birKHFJtj9D6iYnlhxLliBuXyRHhvOplLyEClKcyAhBL/JHN8vCSAe9IsLOxRV//bZhjeBqh9soeGyrHAsAWN09NKcWVGIHYp/iBEdjGyLpSOuZSz09NKYyFaVzzWrzEI35zKmK98jqthqIRDT0SedvMJymQbNKV2pA8elRVrdnG+QePsw62MnAZVe2KJRkvcfFSqX87WDuy3iLGZRZuNPo4igKbOgWauw23GM5ifM+KcAo2LO0+xN6H+j8mSFaxb2G/DvTKKMdhNG9krUIF2A8nLrQZH7Tuhw276Zig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWQfIuR+/tTwv+98gnjJ7M677+sKHnPnGlUqakaS05Y=;
 b=En195/hOK9vDHPR4JSxew8qZ5iVE/M2+iGUewkGuwdtGdnpg0JltFScNWDBJf4cTQyHW80H7wtuyPmBFuVVrEWvhkmZRI98+gnFjxxjrCNEKx6zTsJX4cvdgwoY4jPTnovdMVE7bDOCLLi6nKvh2yjVV/K8OnJHbBlBDnyFTN5Fe9cPqZfH6rBwUG+cf2yjp16cOTRSxj390lR2uuszZU16fSZv2G3e6BfAQ14/OQw1bZAZ6jhu7SYs7mf//0b5TY2cyCzB/lI3LbDrPHcyRk9fK5lNPOo6yaVba49SCGs7LCZuEDEvY6EzTz1infQetEywQa5LJOipAvAwlGJ8a1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWQfIuR+/tTwv+98gnjJ7M677+sKHnPnGlUqakaS05Y=;
 b=rRZ6wFkn5pRWEINC5h9rxaBqQegmCBwq/gxu/xIC3e/IgLaiysatGXGFNDM2BGAyAbSDVnT8QY4qTS7hEmkgyUc9a5nilWSg+BgwHejUNdrL/NmMm7/bkA+JqtmRFq0+rVuFRzPu7vR3CuujUsCX9HVeHHEw4zT5/BPUwbEIdyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 12:51:08 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 12:51:08 +0000
Message-ID: <6d3e7ea1-9ae4-4f5f-a25f-968e7a15e89f@amd.com>
Date: Fri, 13 Jun 2025 14:50:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tools: zynqmp: add build script and documentation for
 ZynqMP KV260
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Neal Frager <neal.frager@amd.com>
Cc: U-Boot mailing list <u-boot@lists.denx.de>
References: <20250612153311.2379944-1-jerome.forissier@linaro.org>
 <20250612164939.GO1382132@bill-the-cat>
 <b806f55f-da5a-4373-a6c2-15b1cab93da3@linaro.org>
 <eefb84b0-f995-446a-b885-8de9e0b2f295@amd.com>
 <a63dd90d-8c31-44d0-88da-228df3e36b32@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <a63dd90d-8c31-44d0-88da-228df3e36b32@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::11) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4d7b49-9912-4c76-d89d-08ddaa78f752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVBKNEgvYVhmSk5vTEcyMndmODBVSS9FSEdoUnlhNFkzYm1TY1NYakY5Wi9L?=
 =?utf-8?B?aUFTL01jYi9nNCtzWmVHYzl5SmZUYlB2a1JvTU53eU10ZWQ3a01ZZVQ4cEw5?=
 =?utf-8?B?MVVwN08vNStTdm5rT2lWZ3RzQUV6aU9rSTFaeWlpbE10UVE3SlVLMkcvVXBj?=
 =?utf-8?B?OWU5R1pGZ0JVamxRQTFGUEVERmpwYUJlTTl2d2cyYmZpMWxoL0lOVEJCMUZs?=
 =?utf-8?B?NjhndmhmbjJSUG5Ra1ZNU05VT0NxWTNRekZEcnpmTDUvTHgyZmcxMkZsTTFx?=
 =?utf-8?B?MTNta1RyM24zRTF1aFlRazdDTlYyUjgwK2tKM1VkR0M0Uk5IRHBsKzVna045?=
 =?utf-8?B?RXFpVW40NitKMXNHRzkvUzJOQ2FIc2dSUjZhVzIxTTE0SHlDeTljQnl6aEpJ?=
 =?utf-8?B?WjJlUHZQZGkxV3ovNjh1R0UwaWtrd2NOVTBMVWdmenhCRUl2eHNqRWhFK2My?=
 =?utf-8?B?d1piNjdqWmxUa2M0MCtNdnc1VW9pengzc05ocGNsZmhSbDdISXUxZVB3VnNw?=
 =?utf-8?B?aWNaK1pkTlVxcmQyNGNOeGtIdEszZmh0d3JwMTd6T2MwTk52NmpVZ2creTRF?=
 =?utf-8?B?QmpxQkhNUmdyU1Q3OXB3WVZ2aHhxMGVveVpZWXVOZXB2TFl2SEJRMGN4Nlht?=
 =?utf-8?B?SnR6OTdjWnZtcWtoeVVsbHVqT01JU3FwVzBVdnNnTmNlcXlOOHdyV3hWaWlh?=
 =?utf-8?B?K3B5MW04aUtIWmtTRldzTGM2SFo5czNrQ1NyQ0tZTGgyMUpKb0s1ZzlzeGtJ?=
 =?utf-8?B?OWNma3orY3M2Y2d4WmttT2lleTQxQnpjQkwzdVJnampnQnIwNzl3YWRDa1F0?=
 =?utf-8?B?WnVNZG42SGVDSHYrVXRHcWNmM3NOYlZlRDRORWtPRWpIc1RNWnlZdXNqcU5q?=
 =?utf-8?B?MzVYRmtyWEE5WUtrSXFHNHk0dWI3RDU1ancxc25HRFBPc0RHRnc4VmFsNFhP?=
 =?utf-8?B?c0tsMnVZM0Ezc3h1Tzc5cXZkY0hhSGZmeWtQeFY2d1BWeFZ6NE5tUXNhMEE1?=
 =?utf-8?B?Q2JIWWlVNGZRaXBvd2c1alFkUVhZUGE0cVkyZTdpaE9IblRyRXN6N1ZMOVNY?=
 =?utf-8?B?WXRsSWkweElvdDRzb1lITEplQWxyZWpaYlUxTDBXQkUvMGJBdTF0S3VxU3M4?=
 =?utf-8?B?Vm9wYUxDVHI1TzVoL0tFUGZiMENubHlJQStXL0F0UE9LekZDakdpV0tGdHVi?=
 =?utf-8?B?d0R1bjhDK3dDampZZDJFbzF1K25jZWttMlZrMHNtTmhIcE95eXlNaTY1ajl1?=
 =?utf-8?B?ZkJvdE0zUGtyMlZQTHFsZ1Z3ck5QTEIzMXloRHBDOGJnZUdoYXFMNFM3UlRC?=
 =?utf-8?B?ZXl6NzRXWkpyRnd5Nk5PVmdhcmhBazUyMnVDTGgzZ1BwYVQzL01vNEEvMk85?=
 =?utf-8?B?eEhqSGVON3B3OGdFaU9ENHhGZzZBVEh6dWdlc2l4WDgzZHFsbjF6R08vcHZy?=
 =?utf-8?B?NUx1L0NCeHl2Q0ZaaG4yTTBZNGlIRTJNSHhsUW9PNEl6cUF3cGVkMzRzSXRn?=
 =?utf-8?B?a3NWakRVR1BhZE01ZHRaQ1pvVzZMcCtOL0E0VFVEeW45TllLelI3TFRmSE9i?=
 =?utf-8?B?cytsZHJZend4NUMyZXJlUE1xNWhBcGZmaG42MjJxMGp4TC9rblJhWmdBZEdl?=
 =?utf-8?B?dVE1ejdYRGJOOVlCVHN2OVhrT1NwNDBvaEFnU0w1cHNyNHdCenNEaG0wdzhO?=
 =?utf-8?B?T1QrN2kxVmlpQ2VNSXhucmJ4Z1AwaE5McitERDBXQWErQkZZQklkVlAwZER4?=
 =?utf-8?B?eXYzNDR2WU4zajRQRFlQSVJMWjIvYmxEUXZVUytKbkZxOEt1dlJHSjMxZDVs?=
 =?utf-8?B?RmVBc0FxMGpPOE1zcHkzRUdlRkt3bnRRYkRlSUgvS0lnV1hWOUdoV0czVDNz?=
 =?utf-8?B?c292bTNFR09XalROSlFGem1pazNiUjQvUjRqRGNUVGk4WFVOd0IzNGxwY2xT?=
 =?utf-8?Q?nTek5eyHuRg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXE1aXBWakJCR3dyVHRtbHh0OTdsZW5WUVdTdjA2cWhIc29YUTJrQjUwUVpt?=
 =?utf-8?B?MWNMZmZhaG56NlJtUE1MempTUGVsVGpzNWFKbXZUL2pmenc1eU92bGM1RkFR?=
 =?utf-8?B?QXVwYmo5L0l0VWdaUjBqK28wc1ZBNUE4TWhqK1hHakF4RXFNWi9GL1FOdmI4?=
 =?utf-8?B?azFWZmZKSmNJdkFJcU11Y3R2Y1pHdkRiZUJVWTQ0WXNmdVQ5UVJNMlFrcUpx?=
 =?utf-8?B?VlhiY2lFejVqaXV3RjZHdy9rdUN6V1Y5UmErVXI3TTBRSExodTFwZVQ2bEJR?=
 =?utf-8?B?aGg2N2d0Tm1USFM1djdXY1ZxNGpTODdrNEZJdWQ1by9hekZkMGIrQU0vVlQv?=
 =?utf-8?B?NTRvUjBkLzNzamtBOHZaN1Y3RWhqdE5GWjF6aHg0Y0wzMGNhMWxPRDdCVHFO?=
 =?utf-8?B?a21zYVcyalhreUh6QWFBRnpvbDJiZmg2MmhOZUcvelc2em4xZXd3amhXVTU5?=
 =?utf-8?B?RUlIUXY3dmhuNHJQRkZsQU9zQ3BSVERnQzFrbSttU3N0MGxpQ3FpYlZxR2lH?=
 =?utf-8?B?T1dlZ3Yrc1NRcEJ6VlFUQndPelZxZE9qNEtIbEM1Z1BpSzdzeGIwVkZLd1RT?=
 =?utf-8?B?cmtQMmtveFhhQnEwZjVLSzhGV2J0eG5weDRURmNSNm9GVWlrSmF1dmNJaHJM?=
 =?utf-8?B?UFdNZkhUcDM5d0RhQkVFOU9RL2ZDQjB0bGUrL3hUMC9XSXg4WXQ0Sk8xSzZl?=
 =?utf-8?B?SlVYdHVkQmQwWHh5MjlJNmw5RnFCRWtva09QbFgveGhha1p6bHVXejlKbXd2?=
 =?utf-8?B?U01KVzUzR1pZeUsrdmhlWHFQWDdKTUlqTThRV1Jkb3Y3bkI5VlFMUFdkWW4v?=
 =?utf-8?B?RjZpeldKM2IrRmY3dlNMc2hQMUJ1ck1LQmRjeWN4U2RhcnlNVis4SC9lTENu?=
 =?utf-8?B?alBmTzk1UHJhcnBsbTFpNnNwV1hwaUNza3FiNmp5ZittdktJNjdnS3VQOEIw?=
 =?utf-8?B?ekhqbjJDUEpJSmY2djhubVhidWlucVZ1RWoxU2Q3M1FRVXNoSmpxZjA4czBT?=
 =?utf-8?B?WXRPNTFPdmlnUUM5bFNzWW5yVlVsTzJ4UlFQY2VVN2NDYXlJWE9BaTUycmhw?=
 =?utf-8?B?Y1BFRHhacmVqdys0c0wxRGQ2cWR0VnJJc1dzQVlrM2FjMEgwRDRlSnduZno2?=
 =?utf-8?B?TFdKMUwzaXp4S2diZXdDNHg4Slk1MEFVVWlFN3dBMG1mcDNqM0xkeVZzU3JB?=
 =?utf-8?B?clV1QSs5RG5ENDhIcTN1d1pjY2hFSU5GMmF4cU03OFFBVENkUVpHeENDU1lV?=
 =?utf-8?B?TU5SOTUxYUszMTBnMCt4bTd0SjVDaTlzWDBLTUd3VEVNWHY5ZlhpWFZMTmF6?=
 =?utf-8?B?SE9pT1dINnUrVWNJKy82OVF6NFdtWVZ4ZWdjNjdUS3hKSGtLVnEzWVFJaVky?=
 =?utf-8?B?dW13Rkx3NFlwZWpSaGFGbTZIc2xoN2d0UGRkYjhqeGJDdGxOQnNWeDJFa1ZK?=
 =?utf-8?B?dGZxb21EVzU2Z2xoNXh1YzU5YU4yU1FLK0NlUXc2L3lNMnVWQzZjcFEvVW9y?=
 =?utf-8?B?dDlKdUY1UGRldjZsT3NXRmV1TWpSdENtL2hibFN3V2pKUWpneGtZeWkrN0RV?=
 =?utf-8?B?cVAwMlVqUzlkVFdTYndIZE5GNFFDcUowT0JVUkNPTlFSbjdwZDNmTk41blNx?=
 =?utf-8?B?ak9Ub25mZVo0aHRJc3lPNm1Vd2Y1aXpNQ3J4TWQ5VERDUVpHWUlwbU5QeEg1?=
 =?utf-8?B?RE5UZ1E4RHQwU2dMY2QxM1Q2Wk9vTVBpSkhrS3Z6WE9NaEwvL3JKdWVGU2w2?=
 =?utf-8?B?VC9Vam1zL2xxZU8vL3lYVkhFaCtVMFNwcmd4Y2VDY2NQZVhrZ2xYNFZacTEz?=
 =?utf-8?B?aXlUWEpOQjB1SHc3Z0RqekhBaThoWThBYmhTNnovUmk2N1RuVG53akNyeDZK?=
 =?utf-8?B?dTJjQWl6WWhpSEFHNFJzZWpMSUZXSzFKRTZ5c3R0V0ZTRHFkZUxTRDBJTnZ3?=
 =?utf-8?B?UHM2TXdWMWtTcmtxVjhMcWR2MVNNL000dU1NTENGQXJhYnF3YlVNbmRCTito?=
 =?utf-8?B?ejNoTXJ2Y1NiejREcldJQ2J1T3FlTllodDN5VnR6clRKaXBUSlpXVlVpVElH?=
 =?utf-8?B?OUc2WXRuai9aUGNTOGhzdnVCcFFybjBDMlM0WmExN0UxdDEwS3FWY0piR0w0?=
 =?utf-8?Q?c2oGr8z+myP0ikkJeHh2gZGDl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4d7b49-9912-4c76-d89d-08ddaa78f752
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 12:51:08.1135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BK5jE/9WAXphC1tEctZSkTOZJ0PoEIUa9R2L5vpouPe8JMWigllcZgebdIb3pwQS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252
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



On 6/13/25 14:30, Jerome Forissier wrote:
> Hi Michal,
> 
> On 6/13/25 09:59, Michal Simek wrote:
>>
>>
>> On 6/13/25 09:38, Jerome Forissier wrote:
>>>
>>>
>>> On 6/12/25 18:49, Tom Rini wrote:
>>>> On Thu, Jun 12, 2025 at 05:32:41PM +0200, Jerome Forissier wrote:
>>>>
>>>>> Add a script to help build a functional U-Boot binary for the ZynqMP
>>>>> Kria KV260. Also add some documentation.
>>>>>
>>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>>> ---
>>>>>
>>>>>    doc/board/xilinx/index.rst        |  1 +
>>>>>    doc/board/xilinx/zynqmp-kv260.rst | 27 +++++++++
>>>>>    tools/zynqmp_kv260_build.sh       | 43 ++++++++++++++
>>>>>    tools/zynqmp_pmufw_elf_convert.py | 96 +++++++++++++++++++++++++++++++
>>>>>    4 files changed, 167 insertions(+)
>>>>>    create mode 100644 doc/board/xilinx/zynqmp-kv260.rst
>>>>>    create mode 100755 tools/zynqmp_kv260_build.sh
>>>>>    create mode 100755 tools/zynqmp_pmufw_elf_convert.py
>>>>
>>>> Helper build scripts don't belong in the tools directory. If they're
>>>> super helpful, I don't object to adding them to
>>>> u-boot-extras/contrib/<you>/ directory.
>>>
>>> OK
>>>
>>>> But there's a number of
>>>> documented examples already on checkout and build TF-A then do ... for
>>>> your platform.
>>>
>>> There is doc/board/xilinx/zynqmp.rst which deals with quite few ZynqMP
>>> boards but not the KV260. In addition, it has a number of shortcomings:
>>> - It mentions pmu.bin but does not say where to get if from
>>> - It doesn't say how to build TF-A (bl31.bin), some very specific build
>>> options are needed.
>>> - I consider that detailed build instructions belong in things called
>>> scripts or Makefiles, that were invented long ago exactly for that
>>> purpose :) IMO the documentation should tell the bare minimum and ideally
>>> be unnecessary.
>>>
>>> I am not particularly proud of the fact that I spent more than a whole
>>> day trying to get U-Boot master to boot on my KV260, and without the help
>>> of Michal, no doubt I would still be trying... So, how about I submit the
>>> zynqmp_kv260_build.sh script to the u-boot-extras/contrib/<me>/ directory
>>> and just point to it in doc/board/xilinx/zynqmp.rst?
>>
>> no issue from my side.
> 
> OK so here you go:
> 
>  From a429f6563fc5f1433a2df8eabe6a42a98864701b Mon Sep 17 00:00:00 2001
> From: Jerome Forissier <jerome.forissier@linaro.org>
> Date: Fri, 13 Jun 2025 13:39:10 +0200
> Subject: [PATCH] contrib/jforissier: add zynqmp_kv260_build.sh
> 
> Add a build script for the AMD/Xilinx ZynqMP Kria KV260 board.
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>   contrib/jforissier/zynqmp_kv260_build.sh | 42 ++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
>   create mode 100755 contrib/jforissier/zynqmp_kv260_build.sh
> 
> diff --git a/contrib/jforissier/zynqmp_kv260_build.sh b/contrib/jforissier/zynqmp_kv260_build.sh
> new file mode 100755
> index 0000000..967c946
> --- /dev/null
> +++ b/contrib/jforissier/zynqmp_kv260_build.sh
> @@ -0,0 +1,42 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2025 Linaro Ltd.
> +
> +set -ex
> +
> +if [ "$1" == "-c" ]; then
> +  # Clean: remove downloaded/converted files
> +  rm -f bl31.elf bl31.bin pmufw.elf pmufw.bin zynqmp_fsbl.elf pmu_obj.bin
> +  exit 0
> +fi
> +[ -e bl31.bin ] || {
> +  wget https://github.com/Xilinx/soc-prebuilt-firmware/raw/refs/heads/xlnx_rel_v2025.1/kv260-kria/bl31.elf

I would create one variable to keep xlnx_rel_v2025.1 string that you can change 
one location to get new versions.

> +  aarch64-linux-gnu-objcopy -O binary bl31.elf bl31.bin
> +  BL31_LOAD_ADDR=$(aarch64-linux-gnu-readelf -l bl31.elf | awk '/Entry point/ { print $3 }')

here you have bug. Your script works fine on the first run.

You can try this
./zynqmp_kv260_build.sh
make mrproper
./zynqmp_kv260_build.sh

and look at
CONFIG_BL31_LOAD_ADDR

you are all the time getting default Kconfig address which is wrong.


> +}
> +[ -e pmufw.bin ] || {
> +  wget https://github.com/Xilinx/soc-prebuilt-firmware/raw/refs/heads/xlnx_rel_v2025.1/kv260-kria/pmufw.elf
> +  llvm-objcopy -O binary pmufw.elf pmufw.bin
> +}
> +[ -e pmu_obj.bin ] || {
> +  wget https://github.com/Xilinx/soc-prebuilt-firmware/raw/refs/heads/xlnx_rel_v2025.1/kv260-kria/zynqmp_fsbl.elf
> +  aarch64-linux-gnu-objcopy --dump-section .sys_cfg_data=pmu_obj.bin zynqmp_fsbl.elf
> +}
> +[ -e .config ] || {
> +  make xilinx_zynqmp_kria_defconfig
> +  cat << EOF >> .config
> +CONFIG_PMUFW_INIT_FILE="pmufw.bin"
> +CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE="pmu_obj.bin"
> +CONFIG_BL31_LOAD_ADDR=${BL31_LOAD_ADDR}
> +CONFIG_BL32_LOAD_ADDR=0
> +EOF
> +}
> +export BL31=bl31.bin
> +export BL32=
> +export TEE=
> +export CROSS_COMPILE=aarch64-linux-gnu-
> +make -j$(nproc) BINMAN_ALLOW_MISSING=1
> +set +x
> +echo Build was successful:
> +ls -l qspi.bin

The rest is fine.

M


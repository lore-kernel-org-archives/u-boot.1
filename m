Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5974BCCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 13:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56E5D83768;
	Mon, 20 Oct 2025 15:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=legrand.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=Legrand.com header.i=@Legrand.com header.b="lhtx3obS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC53282C84; Mon, 20 Oct 2025 11:53:18 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D29D88004F
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 11:53:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=legrand.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ronald.wahl@legrand.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKs0AjsQNTCAC0VSLuVp1KaV3apOMtXO2dWXDz44rDLGMsoVMXMk5B7d3V6SQpWy5DDLxPUVfl1E/dAm5kiEnHDW7FS/FIYPwKFiNlWqprTSyrWxBMokrFW0B/eoLRYWHy2KDjeINfFsYS6W5VCQF5ba7qHkSoT5ppQ7VQlzNiPlZYgXwW96ER2zx1KjUrjIwXZSjf+dh4vuj6pj1TGpNr/LImlsG6t9hxbOfrlj6+5bRG8acGV4RzZxDPdvLXLuc+BZSKUlAEDKmgoBpNuXZRMIuBp08BrpBUMvwB+scWlN/lSCgebU+PdEjSt9d4HutKDiLmWMzqRxNCy1wr8n4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe4kcagAm8D4EzyOGgOxi3opcms2sWI6ePemmAqHbX8=;
 b=JXqPWbL/6jPZRi2IPwREL4R3KO43mMC7rIhVKxcgD6LH3kZZpDd6P7fq9AQGaPuHRi7aca8IRULZH0h0fFHs3CtBxpKo/o+hRBGJNVuHwVgfZti5DiiW3sl0K3B0tAH4HXdAVON3d010ROGIbfFL84+C1DY+gAPnvoBXsUUQd52AipYJDdmmqwR3TwI2G/+C23eZPXwVhU5Oj+be6R06lIQHD7JD4IApS1TP4xIO3WDeL3ZJ1k5wYeJH+jFOo7emXvavdp/PYGXQdY3GXHdJ2eHLZqFmWwiufGH5GpIQiDvhSI/tuDUNLG6ZUQj1tvVgtopqVQoZpuCTcsuZApZ9Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=legrand.com; dmarc=pass action=none header.from=legrand.com;
 dkim=pass header.d=legrand.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Legrand.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe4kcagAm8D4EzyOGgOxi3opcms2sWI6ePemmAqHbX8=;
 b=lhtx3obSRboV/Kmsj9nIgLHgAYQl1wR9yai2sMjyeZxiWP/ncja1cwcd2RCyvCtYGYFSJ2SG+7+MGVg+sUBhZBdGCpRNrverMEhOnNN/dlu996KPXHoGLuKjW80sevqkQVK9dxoJbCjW+1ZdO3voNvxvMOxuAX20u30hU5C0CZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=legrand.com;
Received: from DUZPR06MB9057.eurprd06.prod.outlook.com (2603:10a6:10:4b2::18)
 by DUZPR06MB8982.eurprd06.prod.outlook.com (2603:10a6:10:4b2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 09:53:13 +0000
Received: from DUZPR06MB9057.eurprd06.prod.outlook.com
 ([fe80::7883:195d:c189:373b]) by DUZPR06MB9057.eurprd06.prod.outlook.com
 ([fe80::7883:195d:c189:373b%6]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 09:53:13 +0000
Message-ID: <4f8c9aa6-e26e-4fa7-b06b-d18d6dbb027c@legrand.com>
Date: Mon, 20 Oct 2025 11:53:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: cadence-qspi: Remove cdns,is-dma property handling
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, E Shattow <e@freeshell.de>,
 u-boot@lists.denx.de, git@amd.com
Cc: Boon Khai Ng <boon.khai.ng@altera.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <6205c6585589b423692b6ed063506b4c51c04c77.1760006086.git.michal.simek@amd.com>
 <3949b231-b62f-4fac-a078-bd066940420f@freeshell.de>
 <b21e8dc3-7ec7-4fcd-a0ef-1d214fc8a1e9@legrand.com>
 <d710f2d3-4044-4a64-a85a-2650b3ca6238@amd.com>
 <2b3d068d-4888-4594-a75e-6c2729bf28c4@legrand.com>
 <df818160-3ffa-49ad-959d-3df22fae9100@amd.com>
From: Ronald Wahl <ronald.wahl@legrand.com>
In-Reply-To: <df818160-3ffa-49ad-959d-3df22fae9100@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::13) To DUZPR06MB9057.eurprd06.prod.outlook.com
 (2603:10a6:10:4b2::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DUZPR06MB9057:EE_|DUZPR06MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b141f8-e52a-4300-7c77-08de0fbe7bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHcvNTNVc3d3Wk9DQnhST1JuVHZKeUN4cnA4UE8rWGxiTFFXSE1WbVJrN3h5?=
 =?utf-8?B?SmxIUjU0a240ZDVQeVRCNkEyc3NqN25uL2pIN2hiOEVUZTZIdEplUm1Kc3JB?=
 =?utf-8?B?TE5uWnpIREVXMzd1MkRJUjVCT3lkOUdaWFh4RzRUUEdnZjNsVGh3dENpdTh2?=
 =?utf-8?B?TzYrNzdkQXlKOTB6M2ZEN2Q4U3A2YnZCOVZIT2VlVGZxOW9pMGpjZ0NaeXV4?=
 =?utf-8?B?NDQxWmJMZU9RY2ZUL0tsRlREdVFpNUNYSmp5REVkdGRKQXVXNGFHMVMrZ0lW?=
 =?utf-8?B?Q0ZUUnFoWUJSTkl5U0hYUTNqb0xhQjBGczkwbXlRU0N4TWVBVXllQ1VraVlu?=
 =?utf-8?B?OUI5SWJ4UTZSTjFVSE5pN0tPOGtZR1FETHNBaXNlckU2elg2VWg1V2VXS3VW?=
 =?utf-8?B?dTlWS1diclJkUUkyTlg3WVRRQWZUVk9qZ3l0bmZObkVsZGFIaTc0NktaSUVZ?=
 =?utf-8?B?MXpsbHFXVy8rWkttUFYrc2lUV1VRRHpHRmI4bXZWZjNqSGp4elRNNmRMTU55?=
 =?utf-8?B?aGpQeDluQTdIRVV6ZmdGYzk5NS9PS3pPTlVadzFDVTVnQzlLdS9Bam5KME1n?=
 =?utf-8?B?V3B3YlZhWElwY2w4d05mVEU1amhjdkVucklrOG5Fb3NlL2VDNnVQUTEvWlpm?=
 =?utf-8?B?YzBqNldWaGtzVUlWSk1HU1pwdi9URTNlYmhyMDNvK0RMQmMxUkxjMUlUb01O?=
 =?utf-8?B?ekQycGdBSC9CUWNDekVRNTNDZ1RrQisxZjFidjNyVkdxK0FIT29GN1hLQVpO?=
 =?utf-8?B?TWJvUzNqeHAwMnVBRDVjOEV6elI5bEZLdUtORTF3UWNMckxwaXR4amQ4Risz?=
 =?utf-8?B?ci91WWxtNmVQSkVVL2VNWUwvaDBNem5PVml0NFhpWG5tNzhZS0FuVzJJZ3p5?=
 =?utf-8?B?ZFlUWFJpYVlUeGw5NG1LWUpBanJuenJjRENsUFFJdU8yN0w3dXlRU3ZVeXNJ?=
 =?utf-8?B?bVNHeXYrUU1yTmZLajVOa3V2RGxtdmFYWldhbWtqZ3c1Z1hMcHFnQUR1alhs?=
 =?utf-8?B?R20xVVhrRU4yRGJFdkl5dmlBUnc5b3I0VG9JM29FL1R0dFBSMFBVSVIvL2lR?=
 =?utf-8?B?eHdvQlVmK3BILy9CclhsTTJHVUoxelFTT21JaGFHc3hkNWd3VWdneWY1aW1G?=
 =?utf-8?B?NjZhQnNNVFVYTTVjSTNrYW10UTNWVGwza3doSEZFTjdqSmd5d25zTnRMZE5h?=
 =?utf-8?B?eWNzdWpyT2dzR1pGV3E4WkN2NExvZjR6QnV3b2NHS1ErTVQ4TmZ3WUxIemU5?=
 =?utf-8?B?cmtyTnhDTGtHWjU2NEc0eVJnSm5tUVdwYndvWE41U0RnWFN6U2pDNUQ0Rkxv?=
 =?utf-8?B?OXE3YmJpMkhUQ1h2dFA5a0QvOG95UDdUYVBCdDYxZk9KSWRnM2p5NnVYdmo4?=
 =?utf-8?B?RTBYZWxRbG9pbnllT3lyaWdEcWd0dVBMRytMQXdhSVcxNk51RDduRDVHS1VM?=
 =?utf-8?B?SXVxak5iZGg0YklSUDVzWG5UR0VLSHlLdnBoVU8vSlBMUWx3anZWNTVPQ0hH?=
 =?utf-8?B?K0h1THVwOXVDbVNnZFN2Qm5pZ1ZTNWNBdFlpVlZXZ3dMTzlsVnNCWXN2aDRy?=
 =?utf-8?B?alFxRWpEQzFzYnhOV1hyZ3FUb3Q0WW5TSzJGNUF0RW52eDMvUGJHcGJ2VFNT?=
 =?utf-8?B?bWgycHF2TUFXaHJ5ZUsvaUFER3pBU2IwRDhCK0V6YXhlNG1ncXhWSjlZenQ2?=
 =?utf-8?B?RDdOMTdsRDk0bEd3Nkx0UytpOHBlcWVLM0d4L2VCYkpIaFY3RmV4VE9tellP?=
 =?utf-8?B?YlY0QzEwSC9mWEZXVVFNVndFblUzQ0twd1c5OTBTeUtrTnQwMC9RbGRqbVFP?=
 =?utf-8?B?YVVBc0gxczBCTXBNdUNzTkwvL1gyekRnUUF0NGUxMDFEeWFFM1JpdzRyWmdF?=
 =?utf-8?B?NkU3MU8yUklLckNwdGs1cmZqVWthK01UelY2WGVzeVN4cUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DUZPR06MB9057.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVN0Ty9yMythekprWjE1aFhGY0ZqTnEwUmRDK0ZwSEtENDdtaGtldndJdGFx?=
 =?utf-8?B?ZmZqUENXZnpmUDEyR1ArbUwwRHVnNDgrSzNMOVRFd0J2Z1Rna2F3OGNBNnFq?=
 =?utf-8?B?c0pxMmsxYS9hL1FjMzZWWDhIMWhNaVBzY0xtYkkvWHp0NWF5Q1hPLzJ4TVlS?=
 =?utf-8?B?WlV4bTY4bUtIRVk0U0NWVFZHM3owZFZRcmtleXB2d1EwU0h0Z1JaazNVWDA0?=
 =?utf-8?B?RkJHaThNZ3d5d25EMWh1Umovd1krV1IzVVcwRlBDNXR3VEJPQ2lmeVBBOUxy?=
 =?utf-8?B?R1pZdHFqQmZiZ0xLSjA4ZUxVd2lucXVWRDBTdmdQVXh2T05SK1krNFpVbmlx?=
 =?utf-8?B?WVUvVXBQbjRWZHJTWHlmY25ieGtwWHI3aEV1Nk1zL3Z1dmdQcUhLbVczUlFU?=
 =?utf-8?B?eWFTVEcwcStveUdVZWxQek5lNGU3SUVvdXUyNEVTSDgyc2JjM2EwRUZHL1VT?=
 =?utf-8?B?TERobmxvQktWL0RtSFNYVndxV0hNUC9IeVo0Z2xPTEFTM0M3NlFZbDhPcGhI?=
 =?utf-8?B?MWphQUp6YkVQTXQ3WmRXdnFZNFBuVEJKUFkrNThickJLc3pWc0s2aDROQWMv?=
 =?utf-8?B?dGxyMkdHWmx1RDJiSmdqWjdvb282ZUR5QjRPdk8yMkdXNHg1RGR1U2V5c2tR?=
 =?utf-8?B?ajFFbUFVYkhCeVFhZFlpTHdFVzZYdU4vNnp6bWh5a3dzdkUwRlJSZ3VOUnZH?=
 =?utf-8?B?UDZ0WitCZTVKanZDVnRsTzFSL3pWSTlJbk5ENDBmOEk2Mi9YdE5YNmZUMjF0?=
 =?utf-8?B?Uy8ybCtOM3NrSE1XTXgvVGV5ZllvZDRKSTJYNFhwbWZtWjEyUUV0VmhHMXZo?=
 =?utf-8?B?eStRZGx6TTZ1QVNSM243MWU0b3c3ZmtCQ3FuN1ZvM3JSeW81WFp2dVhWVEtk?=
 =?utf-8?B?Q0s4UXVvejBCQnNEa0ZZeENRY3BTRlkwMFNUMzh3WWJJUitLeFFyU2FwUWs5?=
 =?utf-8?B?SU4zTC96YWllM25udWlqQytoN2FOTm9XNXczQkpDOXhsSmlMR2JRYWpuNWZL?=
 =?utf-8?B?TXlTa0kvYVMwNUZKcGJWVWJIcDRVb0FZUk1TRUdFeEdpS2huZ3ZuN2Q0SThY?=
 =?utf-8?B?Rk15WW1BcjB2RUZIcTExWnFzYWIyL0xWSW03Nkp6eUtsWUNDZ3FtbHN3bHU5?=
 =?utf-8?B?eHRlMUl1MVdxVkdCdWp2RmY0ZHdQaVE3ZUFIMDIzK2lZWDBxTTQzcTFCbExl?=
 =?utf-8?B?ME5rSGdnTDRPR05sMDVtaVFCZGEzalRUTEg4QXZXZ0JnL3FDSWphN0x3MG5j?=
 =?utf-8?B?RHpTdjJvckpyWndHYTltU2hoVENXb3RZbDdVV0VuS055RFdGSkRyUlZNdGZy?=
 =?utf-8?B?VW12ZDhQSlVtVEExU3BoQW1ubUtFRS9nbTBVckNkbjRhYVllZitpNE9XZWpm?=
 =?utf-8?B?OG9aU1FoanhvRmNIcGN4c2lHeDg3YnlhUlJOYkEreWRQeXVncTZmWGNkQWNn?=
 =?utf-8?B?WTJXWmo2M3F5dHVZdEptcTc4V0hTWmZQSU9DeTA1QkFtS3FSNXNvanYvSkNa?=
 =?utf-8?B?Y090dW5VTGpGSExkZTN3LytsL2FlVjNrOGFJR2xvU2VzeVdGUG5mSnRBRlB5?=
 =?utf-8?B?Y1RPc1lFcVdlOTVtaXQzcDI3eXNCRXp1ZlczQjB2OWhjRngvcjJRM2s3Q1ZQ?=
 =?utf-8?B?enpEb00rc2ExNUk3OGJqeFFiMHBQUkU2aWdjNldLalpnYm9rV1Q4Q3A4cUwx?=
 =?utf-8?B?Y21JbXh0K2xNTlNvallVK0NYNDhGU003Z1FBS2FJWEhMSSs4WTFkSDh6MFpL?=
 =?utf-8?B?b0ZGaEdZZmN2aGNaaXdLTy9mbFBoSlZjV3M4RHh5ZmNLMFVMZmlRM2svVmtG?=
 =?utf-8?B?WURUMUNZY0FhdHpBRW9jb1RjcG12cUZ3ZjdoUFBGWHl2WkxSWFZjS25MOHVq?=
 =?utf-8?B?Nnk3V0FhZW9oNy9wWEYyb0FsQ1JLZFQ4UklRRkxUS1MzSHBCdHpBQnlHeEVh?=
 =?utf-8?B?bHNxV1VwWXJmSW1XdllWanQ0UnN5N2tGSFNyY0J0d2ZhVmJic3BFYzhDaHM0?=
 =?utf-8?B?bDRnUkcvZm1Nb1lITlVsY1FSdUh2UTZhMGV0Z0xiNEdOZjNZdHIrMUJpZVVV?=
 =?utf-8?B?MlViQXpLcjZWMHpVR3gvSitJbkpWQWJxWkoxdWh6SGoreE9BZDIxYXFSTTZa?=
 =?utf-8?B?Um1vY3VvYXd6bEkrMy9qMmgzRlhNQ3hWNXhhaDJ2aEtvZ0xuNHRrL2x4aDNh?=
 =?utf-8?B?ZFE9PQ==?=
X-OriginatorOrg: Legrand.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b141f8-e52a-4300-7c77-08de0fbe7bd2
X-MS-Exchange-CrossTenant-AuthSource: DUZPR06MB9057.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 09:53:13.0646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 199686b5-bef4-4960-8786-7a6b1888fee3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODbr0iOBdM/vCvGEziqiJLqx6qxOccza1KuaogzmYctWW/hh6+i1Qf9+jElLMo8GwoR81FqfLrD8MWJ8F34NAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR06MB8982
X-Mailman-Approved-At: Mon, 20 Oct 2025 15:15:13 +0200
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

On 20.10.25 11:38, Michal Simek wrote:
> On 10/20/25 10:30, Ronald Wahl wrote:
>> On 20.10.25 07:51, Michal Simek wrote:
>>> [You don't often get email from michal.simek@amd.com. Learn why this is
>>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>> On 10/20/25 00:36, Ronald Wahl wrote:
>>>> On 20.10.25 00:03, E Shattow wrote:
>>>>> On 10/9/25 03:34, Michal Simek wrote:
>>>>>> Remove cdns,is-dma DT property handling. Property is not the part
>>>>>> of DT
>>>>>> binding and it is also hardcoded to value 1 in all DTs that's why
>>>>>> remove it
>>>>>> because none is also testing value 0.
>>>>>> If there is any use case when this configuration should be supported
>>>>>> this
>>>>>> patch can be reverted.
>>>>>>
>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>> ---
>>>>>>
>>>>>> Changes in v2:
>>>>>> - Remove other functions which are reported as unused by gitlab CI.
>>>>>>
>>>>>> v1: https://eur01.safelinks.protection.outlook.com/?
>>>>>> url=3Dhttps%3A%2F%2Flore.kernel.org%2Fr%2F&data=3D05%7C02%7Cronald.w=
ahl%40legrand.com%7Cedf1107fa8c143a9738c08de0f9cc246%7C199686b5bef449608786=
7a6b1888fee3%7C0%7C0%7C638965363122564250%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0e=
U1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoy=
fQ%3D%3D%7C0%7C%7C%7C&sdata=3DwloMzuMKR6AGQHJ%2FMurQdgiZrPsQkHvsewR5%2F48Ts=
ZM%3D&reserved=3D0
>>>>>> c6a5b4bfe565668eb3299d5c5a5548a2163b129a.1758786568.git.michal.simek=
@amd.com>>> ---
>>>>>>   arch/arm/dts/versal-mini-ospi.dtsi     |=C2=A0=C2=A0 1 -
>>>>>>   arch/arm/dts/versal-net-mini-ospi.dtsi |=C2=A0=C2=A0 1 -
>>>>>>   drivers/spi/cadence_qspi.c             |=C2=A0=C2=A0 8 +-
>>>>>>   drivers/spi/cadence_qspi.h             |=C2=A0=C2=A0 5 --
>>>>>>   drivers/spi/cadence_qspi_apb.c         | 119
>>>>>> -------------------------
>>>>>>   5 files changed, 1 insertion(+), 133 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/dts/versal-mini-ospi.dtsi b/arch/arm/dts/
>>>>>> versal-mini-
>>>>>> ospi.dtsi
>>>>>> index eec2a08e7c70..6991f6a51db0 100644
>>>>>> --- a/arch/arm/dts/versal-mini-ospi.dtsi
>>>>>> +++ b/arch/arm/dts/versal-mini-ospi.dtsi
>>>>>> @@ -38,7 +38,6 @@
>>>>>>                num-cs =3D <1>;
>>>>>>                cdns,fifo-depth =3D <256>;
>>>>>>                cdns,fifo-width =3D <4>;
>>>>>> -             cdns,is-dma =3D <1>;
>>>>>>                cdns,trigger-address =3D <0xc0000000>;
>>>>>>                #address-cells =3D <1>;
>>>>>>                #size-cells =3D <0>;
>>>>>> diff --git a/arch/arm/dts/versal-net-mini-ospi.dtsi b/arch/arm/dts/
>>>>>> versal-
>>>>>> net-mini-ospi.dtsi
>>>>>> index 1c94b352dc97..d2d5ec8e5cbf 100644
>>>>>> --- a/arch/arm/dts/versal-net-mini-ospi.dtsi
>>>>>> +++ b/arch/arm/dts/versal-net-mini-ospi.dtsi
>>>>>> @@ -52,7 +52,6 @@
>>>>>>                num-cs =3D <1>;
>>>>>>                cdns,fifo-depth =3D <256>;
>>>>>>                cdns,fifo-width =3D <4>;
>>>>>> -             cdns,is-dma =3D <1>;
>>>>>>                cdns,is-stig-pgm =3D <1>;
>>>>>>                cdns,trigger-address =3D <0xc0000000>;
>>>>>>                #address-cells =3D <1>;
>>>>>> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
>>>>>> index 599596f9f087..849bd930edf0 100644
>>>>>> --- a/drivers/spi/cadence_qspi.c
>>>>>> +++ b/drivers/spi/cadence_qspi.c
>>>>>> @@ -210,7 +210,6 @@ static int cadence_spi_probe(struct udevice *bus=
)
>>>>>>
>>>>>>        priv->regbase           =3D plat->regbase;
>>>>>>        priv->ahbbase           =3D plat->ahbbase;
>>>>>> -     priv->is_dma            =3D plat->is_dma;
>>>>>>        priv->is_decoded_cs     =3D plat->is_decoded_cs;
>>>>>>        priv->fifo_depth        =3D plat->fifo_depth;
>>>>>>        priv->fifo_width        =3D plat->fifo_width;
>>>>>> @@ -348,10 +347,7 @@ static int cadence_spi_mem_exec_op(struct
>>>>>> spi_slave *spi,
>>>>>>        case CQSPI_READ:
>>>>>>                err =3D cadence_qspi_apb_read_setup(priv, op);
>>>>>>                if (!err) {
>>>>>> -                     if (priv->is_dma)
>>>>>> -                             err =3D cadence_qspi_apb_dma_read(priv=
,
>>>>>> op);
>>>>>> -                     else
>>>>>> -                             err =3D
>>>>>> cadence_qspi_apb_read_execute(priv, op);
>>>>>> +                     err =3D cadence_qspi_apb_dma_read(priv, op);
>>>>>>                }
>>>>>>                break;
>>>>>>        case CQSPI_WRITE:
>>>>>> @@ -412,8 +408,6 @@ static int cadence_spi_of_to_plat(struct udevice
>>>>>> *bus)
>>>>>>        if (plat->ahbsize >=3D SZ_8M)
>>>>>>                priv->use_dac_mode =3D true;
>>>>>>
>>>>>> -     plat->is_dma =3D dev_read_bool(bus, "cdns,is-dma");
>>>>>> -
>>>>>>        /* All other parameters are embedded in the child node */
>>>>>>        subnode =3D cadence_qspi_get_subnode(bus);
>>>>>>        if (!ofnode_valid(subnode)) {
>>>>>> diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
>>>>>> index 879e7f8dbfb8..10c4ad14cc05 100644
>>>>>> --- a/drivers/spi/cadence_qspi.h
>>>>>> +++ b/drivers/spi/cadence_qspi.h
>>>>>> @@ -223,8 +223,6 @@ struct cadence_spi_plat {
>>>>>>        u32             tchsh_ns;
>>>>>>        u32             tslch_ns;
>>>>>>        u32             quirks;
>>>>>> -
>>>>>> -     bool            is_dma;
>>>>>>   };
>>>>>>
>>>>>>   struct cadence_spi_priv {
>>>>>> @@ -261,7 +259,6 @@ struct cadence_spi_priv {
>>>>>>        bool            ddr_init;
>>>>>>        bool            is_decoded_cs;
>>>>>>        bool            use_dac_mode;
>>>>>> -     bool            is_dma;
>>>>>>
>>>>>>        /* Transaction protocol parameters. */
>>>>>>        u8              inst_width;
>>>>>> @@ -292,8 +289,6 @@ int cadence_qspi_apb_command_write(struct
>>>>>> cadence_spi_priv *priv,
>>>>>>
>>>>>>   int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
>>>>>>                                const struct spi_mem_op *op);
>>>>>> -int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
>>>>>> -                               const struct spi_mem_op *op);
>>>>>>   int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
>>>>>>                                 const struct spi_mem_op *op);
>>>>>>   int cadence_qspi_apb_write_execute(struct cadence_spi_priv *priv,
>>>>>> diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/
>>>>>> cadence_qspi_apb.c
>>>>>> index 4696c09f754b..58be017720bc 100644
>>>>>> --- a/drivers/spi/cadence_qspi_apb.c
>>>>>> +++ b/drivers/spi/cadence_qspi_apb.c
>>>>>> @@ -667,125 +667,6 @@ int cadence_qspi_apb_read_setup(struct
>>>>>> cadence_spi_priv
>>>>>> *priv,
>>>>>>        return 0;
>>>>>>   }
>>>>>>
>>>>>> -static u32 cadence_qspi_get_rd_sram_level(struct cadence_spi_priv
>>>>>> *priv)
>>>>>> -{
>>>>>> -     u32 reg =3D readl(priv->regbase + CQSPI_REG_SDRAMLEVEL);
>>>>>> -     reg >>=3D CQSPI_REG_SDRAMLEVEL_RD_LSB;
>>>>>> -     return reg & CQSPI_REG_SDRAMLEVEL_RD_MASK;
>>>>>> -}
>>>>>> -
>>>>>> -static int cadence_qspi_wait_for_data(struct cadence_spi_priv *priv=
)
>>>>>> -{
>>>>>> -     unsigned int timeout =3D 10000;
>>>>>> -     u32 reg;
>>>>>> -
>>>>>> -     while (timeout--) {
>>>>>> -             reg =3D cadence_qspi_get_rd_sram_level(priv);
>>>>>> -             if (reg)
>>>>>> -                     return reg;
>>>>>> -             udelay(1);
>>>>>> -     }
>>>>>> -
>>>>>> -     return -ETIMEDOUT;
>>>>>> -}
>>>>>> -
>>>>>> -static int
>>>>>> -cadence_qspi_apb_indirect_read_execute(struct cadence_spi_priv
>>>>>> *priv,
>>>>>> -                                    unsigned int n_rx, u8 *rxbuf)
>>>>>> -{
>>>>>> -     unsigned int remaining =3D n_rx;
>>>>>> -     unsigned int bytes_to_read =3D 0;
>>>>>> -     int ret;
>>>>>> -
>>>>>> -     writel(n_rx, priv->regbase + CQSPI_REG_INDIRECTRDBYTES);
>>>>>> -
>>>>>> -     /* Start the indirect read transfer */
>>>>>> -     writel(CQSPI_REG_INDIRECTRD_START,
>>>>>> -            priv->regbase + CQSPI_REG_INDIRECTRD);
>>>>>> -
>>>>>> -     while (remaining > 0) {
>>>>>> -             ret =3D cadence_qspi_wait_for_data(priv);
>>>>>> -             if (ret < 0) {
>>>>>> -                     printf("Indirect write timed out (%i)\n", ret)=
;
>>>>>> -                     goto failrd;
>>>>>> -             }
>>>>>> -
>>>>>> -             bytes_to_read =3D ret;
>>>>>> -
>>>>>> -             while (bytes_to_read !=3D 0) {
>>>>>> -                     bytes_to_read *=3D priv->fifo_width;
>>>>>> -                     bytes_to_read =3D bytes_to_read > remaining ?
>>>>>> -                                     remaining : bytes_to_read;
>>>>>> -                     /*
>>>>>> -                      * Handle non-4-byte aligned access to avoid
>>>>>> -                      * data abort.
>>>>>> -                      */
>>>>>> -                     if (((uintptr_t)rxbuf % 4) || (bytes_to_read %
>>>>>> 4))
>>>>>> -                             readsb(priv->ahbbase, rxbuf,
>>>>>> bytes_to_read);
>>>>>> -                     else
>>>>>> -                             readsl(priv->ahbbase, rxbuf,
>>>>>> -                                    bytes_to_read >> 2);
>>>>>> -                     rxbuf +=3D bytes_to_read;
>>>>>> -                     remaining -=3D bytes_to_read;
>>>>>> -                     bytes_to_read =3D
>>>>>> cadence_qspi_get_rd_sram_level(priv);
>>>>>> -             }
>>>>>> -     }
>>>>>> -
>>>>>> -     /* Check indirect done status */
>>>>>> -     ret =3D wait_for_bit_le32(priv->regbase + CQSPI_REG_INDIRECTRD=
,
>>>>>> -                             CQSPI_REG_INDIRECTRD_DONE, 1, 10, 0);
>>>>>> -     if (ret) {
>>>>>> -             printf("Indirect read completion error (%i)\n", ret);
>>>>>> -             goto failrd;
>>>>>> -     }
>>>>>> -
>>>>>> -     /* Clear indirect completion status */
>>>>>> -     writel(CQSPI_REG_INDIRECTRD_DONE,
>>>>>> -            priv->regbase + CQSPI_REG_INDIRECTRD);
>>>>>> -
>>>>>> -     /* Check indirect done status */
>>>>>> -     ret =3D wait_for_bit_le32(priv->regbase + CQSPI_REG_INDIRECTRD=
,
>>>>>> -                             CQSPI_REG_INDIRECTRD_DONE, 0, 10, 0);
>>>>>> -     if (ret) {
>>>>>> -             printf("Indirect read clear completion error (%i)\n",
>>>>>> ret);
>>>>>> -             goto failrd;
>>>>>> -     }
>>>>>> -
>>>>>> -     /* Wait til QSPI is idle */
>>>>>> -     if (!cadence_qspi_wait_idle(priv->regbase))
>>>>>> -             return -EIO;
>>>>>> -
>>>>>> -     return 0;
>>>>>> -
>>>>>> -failrd:
>>>>>> -     /* Cancel the indirect read */
>>>>>> -     writel(CQSPI_REG_INDIRECTRD_CANCEL,
>>>>>> -            priv->regbase + CQSPI_REG_INDIRECTRD);
>>>>>> -     return ret;
>>>>>> -}
>>>>>> -
>>>>>> -int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
>>>>>> -                               const struct spi_mem_op *op)
>>>>>> -{
>>>>>> -     u64 from =3D op->addr.val;
>>>>>> -     void *buf =3D op->data.buf.in;
>>>>>> -     size_t len =3D op->data.nbytes;
>>>>>> -
>>>>>> -     cadence_qspi_apb_enable_linear_mode(true);
>>>>>> -
>>>>>> -     if (priv->use_dac_mode && (from + len < priv->ahbsize)) {
>>>>>> -             if (len < 256 ||
>>>>>> -                 dma_memcpy(buf, priv->ahbbase + from, len) < 0) {
>>>>>> -                     memcpy_fromio(buf, priv->ahbbase + from, len);
>>>>>> -             }
>>>>>> -             if (!cadence_qspi_wait_idle(priv->regbase))
>>>>>> -                     return -EIO;
>>>>>> -             return 0;
>>>>>> -     }
>>>>>> -
>>>>>> -     return cadence_qspi_apb_indirect_read_execute(priv, len, buf);
>>>>>> -}
>>>>>> -
>>>>>>   /* Opcode + Address (3/4 bytes) */
>>>>>>   int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
>>>>>>                                 const struct spi_mem_op *op)
>>>>>
>>>>> Your patch results in corrupted SPI NOR flash writing from U-Boot on
>>>>> starfive_visionfive2_defconfig target board Pine64 Star64:
>>>>>
>>>>> a040578d8270ed8788d7663808ea63ce5ffd7840 is the first bad commit
>>>>> commit a040578d8270ed8788d7663808ea63ce5ffd7840
>>>>> Author: Michal Simek <michal.simek@amd.com>
>>>>> Date:   Thu Oct 9 12:34:48 2025 +0200
>>>>>
>>>>>      spi: cadence-qspi: Remove cdns,is-dma property handling
>>>>>
>>>>> Steps to reproduce with Star64:
>>>>>
>>>>> 1). Set JH-7110 SoC RGPIO configured for UART BootROM loader mode
>>>>> 2). Power on and Transfer U-Boot SPL by XMODEM as prompted by BootROM
>>>>> 3). Transfer U-Boot main by YMODEM from U-Boot SPL prompt
>>>>> 4). Having `(cd $HOME/build/u-boot && python3 -m http.server 6789)` o=
r
>>>>> similar for serving U-Boot SPL and U-Boot Main to save some time with
>>>>> UART transfer:
>>>>> 4a). wget $loadaddr http://host:6789/spl/u-boot-spl.bin.normal.out
>>>>> && sf
>>>>> update $loadaddr 0 $filesize
>>>>> 4b). wget $loadaddr http://host:6789/u-boot.itb && sf update $loadadd=
r
>>>>> 100000 $filesize
>>>>>
>>>>> Repeat steps 4a and 4b, note that each time all bytes are written
>>>>> and no
>>>>> bytes are skipped. Written data is wrong and device unsuccessfully
>>>>> boots
>>>>> in SPI NOR flash BootROM loader configuration showing wrong
>>>>> information
>>>>> to output.
>>>>>
>>>>> Please follow up with your analysis of why these changes have this
>>>>> effect.
>>>>
>>>> I guess this is because the committer didn't take into account that
>>>> when
>>>> a DT did not mention the property then it is 0 (false).
>>>>
>>>> I assume TI K3 hardware is affected as well. So I think the patch must
>>>> be reverted.
>>>
>>> Are you using cadence-qspi in non DMA mode? DT property shouldn't be
>>> introduced
>>> in the first place that's why it was removed.
>>
>> cadence_qspi_apb_dma_read is only implemented for versal HW and otherwis=
e
>> a NOP. This does not mean that DMA is not used on non-versal HW, it is
>> just
>> implemented differently.
>
> ah ok. I see. Can you please send revert patch or do you want me to send
> it?

It would be good when you could do it, thanks!

- ron

________________________________

Ce message, ainsi que tous les fichiers joints =C3=A0 ce message, peuvent c=
ontenir des informations sensibles et/ ou confidentielles ne devant pas =C3=
=AAtre divulgu=C3=A9es. Si vous n'=C3=AAtes pas le destinataire de ce messa=
ge (ou que vous recevez ce message par erreur), nous vous remercions de le =
notifier imm=C3=A9diatement =C3=A0 son exp=C3=A9diteur, et de d=C3=A9truire=
 ce message. Toute copie, divulgation, modification, utilisation ou diffusi=
on, non autoris=C3=A9e, directe ou indirecte, de tout ou partie de ce messa=
ge, est strictement interdite.


This e-mail, and any document attached hereby, may contain confidential and=
/or privileged information. If you are not the intended recipient (or have =
received this e-mail in error) please notify the sender immediately and des=
troy this e-mail. Any unauthorized, direct or indirect, copying, disclosure=
, distribution or other use of the material or parts thereof is strictly fo=
rbidden.

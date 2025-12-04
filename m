Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F197D1F9A0
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 10:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C84D83FCD;
	Thu,  4 Dec 2025 11:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T25VXcru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7406183FDB; Thu,  4 Dec 2025 11:01:31 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2163983FBF
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 11:01:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQvU4PlNfyJt9811ha/ewTbyy/DRWKtZCMIt3uJZHXzFpfVCFNbyoO/p6KDQb+ii2rVMv9lL8VlBaP5A2uQ09fdAhmUoFqwXynJPP+Pw3IrINMrieWunhVnoSmu7xSjh1+K1M16SLudNUNf0y8oKBe2Z9ALpYykJCslQgyh+9pzP5mlEMSHCIb9N5BAXpwgCC53mf8aHvPVqDs9ImERWNrwJFIV/4lDR0zJYTK1UoFZaFJ0ohFcSi9gGDfhD0q4OAvtBJRBJKWlpEUQna87YqZ6wWtaD9AtjLLjuoei3Ge86dNT3ox2K3yvVy7eyliU5eMKVhYTrqjCATofAvhiVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQBy0wo0Sa7XXVcIZfGE0cxji3TlFC6wZbp5Pxp0rI8=;
 b=txeQsagOTy9fuHJBju8OiywprlxtLDuThHvZPqux8pKsU6FL1F5ec7UGGQmIPNftiZRVh92LENsWDi7RQbOsiNgMU+NGJQDXtGOgFDpq907whf2RZ4Patgt0kzRQvT+b6A69Nww3JHfVTS6wyBvKs6c7nXmPEUekVVlOqs0G3OEMSmcvogcKW2PHrtk/IXbDeJnFGUAuEXzW195lWEOLrVr70xmmrtpmQT+tnINyNuimDp7n13sz43ZTjfRG7GydTQ4938X6bgSD5JQfW/mwLKKNZPpd5uokGAe2w9Ez0cNP6FxmS8QLcTU7ARWjkb2rPG6fHSP7CTQgsYXD/YDXaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQBy0wo0Sa7XXVcIZfGE0cxji3TlFC6wZbp5Pxp0rI8=;
 b=T25VXcruL++arzqqGesApejVLdexNytfo39OBWczsc4uwEkSRXAIFv1qE47AT8UBB04NnRktM7i3ZIisQijn+mRlngq2Q5E/JwzeQlW2U0JFwGAwhkgHfEpdhaKuw529p4e9nH5wkE+2+n+sDVKTwnbHr8sQucFWGCmg6Z3u+F0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 10:01:19 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 10:01:18 +0000
Message-ID: <7f6afc17-ccc2-4d7a-b8e4-a5a4c1cf0945@amd.com>
Date: Thu, 4 Dec 2025 11:01:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] efi_loader: disk: Add print to show ESP device
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org
Cc: git@amd.com, john.toomey@amd.com
References: <20251204094758.2800428-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20251204094758.2800428-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0025.eurprd08.prod.outlook.com
 (2603:10a6:803:104::38) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 793e264c-0147-4ead-d7b3-08de331c11f2
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OS9aTmpTWUhZM1J2cmRhMnYyTE1VZFpCSXpFWWEwQytRdWZZeU52cDJRclpl?=
 =?utf-8?B?d3YvVTUwK2wzbTBqekdKVTMyRFliQmwrdnNIWXc4dFgxTkRTZWRzOER6NE5X?=
 =?utf-8?B?VFBxbldXTzk1dG5TMy93NUs3a3FYK1QwdzM2blgvd2NTUUI4cXBWU01aYS82?=
 =?utf-8?B?VVpMQm5Hbk84dzVZMWpOcDJLS1lHc2hLWUVVTEI1RnlmaVdEbTBLTFVGYjdK?=
 =?utf-8?B?T0I4T3k1aWk0SW43cnM1UlpuQnAwL3E0azBJYWJnQ0o1MEZ3YlhxeWFPSmZT?=
 =?utf-8?B?Q3VVUXg2K0xtSWluMWlXUzVxeXZIM1RyOGs1WnZjVjZvSFFpTlRERkR2bU90?=
 =?utf-8?B?UUlrRnRyMG1MN3l3S0pzcE55ZjFZR09hNWZPb1ZWUm9BMER1QVJhaHVSMU5X?=
 =?utf-8?B?U1RuTkNza01rd0V5SFpyVHZ0NWRhdGJjLzcwL1BCWkM5QVJHM3dUT0hTaWlW?=
 =?utf-8?B?SXNrU1B4UlNHWVEyQU9Vd2xZbWV4anRlR2N0QWZvYzBBdjJKRG9qNW5JZHlD?=
 =?utf-8?B?OXFSV2NmU3QwcnV4T1pxZXlNWFVtZEh1Y2doaXdYdEMvNFhsOXk4SndrRGpT?=
 =?utf-8?B?RW93MllGblZHWXlQWmdNZmlEb1dXVzNpSkpvVHBXNlZEK1FlQWtOWmI1R0ZL?=
 =?utf-8?B?WE9ac1hZTXNyTFhtUmtray9wL2d3Y05DQnlJQnJKZW54YVNUbldXWXlvaHhD?=
 =?utf-8?B?d1VTaG9WWTB6elFHbmxSVXFyQTdTdlFwelpxUFBuNUtDWTZrN24wOXdZVjhz?=
 =?utf-8?B?Vmo4M3J3M1JJZHRjNWxyTmJXRWFXSnZxUUp5L1hPNXZjbjROZldUd1Z3b1RV?=
 =?utf-8?B?UDJzQy9DdzltMXVadlAxc1hCcldDM0lkVm5CeVJZcmJmcm5hQ0cyUkhESVJN?=
 =?utf-8?B?V1FnWndMNDVkTlRjUmpyVysxamVZV2lIMFVhNVR4ZTkySEhNYU93R09XTTl5?=
 =?utf-8?B?SDM2cXlyMGtzL25ZNENaamV5NlFpYnluK0xEK1dJaFY0YWxPZXpHOU93cHdh?=
 =?utf-8?B?U2FFQVZ1K1Y0bHJqSFo2R1drOUhSanhWWlBtOXNHMHk2RjRDRlF4NHZOMnRL?=
 =?utf-8?B?MU1DY2FzTDhUSi9CMW1zdlZyc08xQ2w4bDNLaklPSk10bFo4SnVML3RxWXdz?=
 =?utf-8?B?d3hQSDRhaHZMSWtCVmVrNjNlVEs4UTNXTjhkWHE1a1A4eEZJU1J4bThDY0Qx?=
 =?utf-8?B?RE5VVFkxRUhzS0JNSWo5d1owZHRPRVVaeTJzS3ltZnBtUHMxSDd2dzNBaVlL?=
 =?utf-8?B?QVVuRS91aVdGSGRpcTFDQkxDc1ArMHRXOStsR1pjNzhseXpEK21JdDYvVUFx?=
 =?utf-8?B?R2dVQ0dObjFCc0JQcW95MldEd3ZSOTVKaG1FVXNnUE1rNTNSSnFrNWlQWU8w?=
 =?utf-8?B?K0kvWTFOS2oxMHI0VUphZFFYOGx2YUhzaVFXcHdMZFRMUUdKNUEwVmpCd2RO?=
 =?utf-8?B?REVMNHdEUG03NUwzc05RTjRibWNwdVRLYTBNUzV5eEUxQTNEVFNKSU1GVzVF?=
 =?utf-8?B?aUlsZjhBaEQ2MlFDd3lJUUJYQkJ0ckNscjJ3VmkweCt0SGN2NFdNKzRwNmR3?=
 =?utf-8?B?MW9GVFNyZ0VqanNJbzJCSk5HeHJlL1JuM050U3RUSjdSeTJQZFBnN20wamw0?=
 =?utf-8?B?NWI0MlpDRUwyeXdRTVp2eHRUUlN2YzBXK1pZMVhOTkg1ZHVCWGl0VjNlVEtU?=
 =?utf-8?B?ZVpreXdFWkQvSXdKM2dOeG1zeXRIcWx4aCtycTQ5aXhHNkNOYXJOdHZvYk4z?=
 =?utf-8?B?akkyb0FIT3BKeit4M0pmdkcyS2RvaVhFZXp4ckNvVGx1NGdNTkQxZDdQTlpD?=
 =?utf-8?B?b042bW14NE1rU3NTUXAvUVZFZmRRaXFRd3JlTDNBbGFUVmc2aWVGYVZVS1k1?=
 =?utf-8?B?dTR5cmc3blpLalk3MEtCQzd2bDhveXNoMzBoeWE4ZWg4cVRpSWcxdkE3Z3g3?=
 =?utf-8?Q?9jeCeFzD3KyrozFkVfdNI4mMVamuLsTQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVpENVpkWkRwN1JDNWxJYnhKQkVTNG5lMGdUQ0JoakVOYm53OUVGdGJUa0lG?=
 =?utf-8?B?SzNOL0l5VU94WEpReHVuTjY3Q0hxR21SaWIybW9ZOVcrM2FlcUZTS3lnRzQw?=
 =?utf-8?B?V1UxRXdEdkozeVVRWmtjSGs2VFIrZDcrNzAxQ0RmZUhNSHVodjhJMGxIMjNW?=
 =?utf-8?B?NDdNYWFFNFovNDBRbmpKVy9Iak1Uc1crZjBnc1Z3MHhBTTVrYkVhbnlRUUlO?=
 =?utf-8?B?N3FQM0FaakxwZFRqMXkvVWZhUDdQMlJWWW95OWxJdFM3VGx6TkdqdXBGamJk?=
 =?utf-8?B?eURGZVVuamNQZzJSa2ozR1IzSEQ5V1pBcGlTZmgyeVFPb0xNNVYyQmxBWW5h?=
 =?utf-8?B?N3BnOG85SU9RZ2NnL1lTWUUrT0UvRlV5R2tIMkFocGE0aEdhQW1zZFhwUWlk?=
 =?utf-8?B?S0NQUzNKQmJUOTdXSU55VHhWeG5GVGtqUjN2SExKNGFJNFA5Z0x5RmJzOGo3?=
 =?utf-8?B?QStMVjh0NVN3VXZMYWxhMGZOakZSUXNDZmo4UFY3VXlDbE1GNjJzRjNMaDhL?=
 =?utf-8?B?OVlqVnlNL3J3OGQzWW41TVV3WU1CWHliZGlPN3p6K1Fkdm5zL1NEU1RiaUs3?=
 =?utf-8?B?OW5iU1JPT2Z0aEg2RWphVGtRaU4vNHEyWjY1SnYzRlZaUm9KK3NYZU1SUXhq?=
 =?utf-8?B?WlZkeVhkenNTUXhGUWN0UklKS21ERGRYWmxBSldiODFSWFduRlhwOGlzOGdP?=
 =?utf-8?B?aGREbEFsY3JnVzJTazkrNVRLQWd2a2kyZE9xUTJaUTBUTlpmUEVMUmxZSEx6?=
 =?utf-8?B?aXBxK3phTUNDZFZHU2hwTUZCSHFMd0tKRWQwVlFFTUVaZk1HWk43eEJqSERa?=
 =?utf-8?B?Um04NEpSZWhxaFFSbEE2T3dKSWg3dk9vYkZvMmQvKzJxMElpMnlwZmRQVUky?=
 =?utf-8?B?V0FSeTRjM3Q1Z1NXOUVvdWdneTZKRVMzcmpaT0dyaTZhZTNMVnZOcGJUWUVJ?=
 =?utf-8?B?dGlyNGtkYkVYUXVQeXI4b0NpYnZzWklsUmU4QmhpVWFoREFMdk40YVBkSEJZ?=
 =?utf-8?B?U0hacWZwSXVHNHFzeHJ1bktJVWlnczNRVDFFa1dRR2VWVFJ2bUFicURqK1A4?=
 =?utf-8?B?U3FZR3VrR2QzUUExR0RJdjJqd2RlbE1USG05dlJEakdXcFpqc1RBUUl4cnpz?=
 =?utf-8?B?OGltMTVxb050NmJHRTBUL0Q2MWx3TXV2bG1EWUlpam53NzE4eVIzQTIydGpK?=
 =?utf-8?B?N0FEd3NRU1V1ai9NSDlXbzVxRXljanYzUG5Xc09RTk5lUzlkZmZrRnBTTlVJ?=
 =?utf-8?B?Yis2NG9RYk9oWFhzZDdLaEdvc3RzVHl0N2M5YzJ1T0ovOEx4M3dtS2picmlW?=
 =?utf-8?B?TURGU3RPeFdlZlRNd1hEVDBVZC9Qa25UYjRhNGk4MG1xbzFyQzZrMERxUjNI?=
 =?utf-8?B?TjgyNjVQWWZXVk5qWDMxbjZIYkJ3aDVqNkVDSVcybmVKbmwyWUw5TUVicmtY?=
 =?utf-8?B?UDBJa0pZZmxteHprSU85MGhoamFIbS8wRVM3QkpLZjFOYnZaTHFad0hmN1Jq?=
 =?utf-8?B?WmE2ZmxZR3dDbkxqUnZHWVFscTFRVDRoNGdRaXF2Y3FJdFZ2Sy9CSU02amVn?=
 =?utf-8?B?TXFWakpuQTJHcU5FZ3JPYklHeWRxWCszdER4SWYwSnlWTkJvNy9jNUhEUkt5?=
 =?utf-8?B?b0IxMVRlb1dDTG5qbStveml0eEVoZkFZRTIwNUx3c1NLTk95MnJkeFRRQVVw?=
 =?utf-8?B?NjljNEtlbVhrbS9KWmErTk9nZWFCaWRXM2gycElYMjBZNjJGbW5ZZE13bzJR?=
 =?utf-8?B?WEhvY09GbWwrU2RTQ1YwZmlkUGIyME1aZHNUbG5RYkFTTnhZV0cvSU91ZDJo?=
 =?utf-8?B?Z000MWUwdzZYelJuZXR0MVMrSTRmczBubmVRQlhCQy9ZZmh1VGJjRThBLy8r?=
 =?utf-8?B?dFZrV3Y0d0pCdGlLemwzWEFtc1N6K2tCbXhsYlIvaCtiM21pQkVJUnZodXFO?=
 =?utf-8?B?ZUF3VUFCVnVxVTBXdVU5M3AwZXpKRWlaZ2l3SmRobDJNcEFKc0Y5NHAxU2RQ?=
 =?utf-8?B?Q3g5TTk5dW1UU3dMWWZkQ3h1S0xsTEZQNlIwd0hFMjFIZHc2dGlnQm84UWpm?=
 =?utf-8?B?ZzFzSzhMVStTWFRjSE9TSUV4eGtyMW9BcHZHUDVGemtNT0FYK0tSN0pEZ3I4?=
 =?utf-8?Q?mZAv/PcXZ8lMPondY/BhVGuJt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793e264c-0147-4ead-d7b3-08de331c11f2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 10:01:18.8949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IqwqDB9u8Q/5tQqcok+rYAKD9hToiYgQbwBeTJalJV8Trfi7+yY8U9mITkS8Zta
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419
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



On 12/4/25 10:47, Padmarao Begari wrote:
> Print a message for debug purposes when an EFI System Partition
> (ESP) is detected on the device to indicate how many devices are
> detected. Only one ESP device is used for capsule update; if
> multiple ESP devices are found, it may indicate corruption in UEFI
> variables. This is for informational purposes only, as the number
> of removable media connected to a given board cannot be controlled.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   lib/efi_loader/efi_disk.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index 130c4db9606..8391de1527c 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -565,6 +565,11 @@ static efi_status_t efi_disk_add_dev(
>   		  diskobj->media.removable_media,
>   		  diskobj->media.last_block);
>   
> +	if (part_info && part_info->bootable & PART_EFI_SYSTEM_PARTITION)
> +		printf("EFI system partition: %s %x:%x\n",
> +		       blk_get_uclass_name(desc->uclass_id),
> +		       desc->devnum, part);
> +
>   	/* Store first EFI system partition */
>   	if (part && efi_system_partition.uclass_id == UCLASS_INVALID) {
>   		if (part_info &&

how does the output look like?

M

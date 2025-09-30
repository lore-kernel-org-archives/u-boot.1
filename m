Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336E7CAC5B9
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 07:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C93BD83045;
	Tue, 30 Sep 2025 09:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s8bFQg18";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4487A8344E; Tue, 30 Sep 2025 09:10:03 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45592828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 09:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+JvXdrJ/nlBPsEcYMxLulEcN6wEdNXb8hby6QA4gmFcX0KUrmbsl0UPnpoEDMPpI8oZY4gg/foeUiFGNxKw9syMmEd+uFY3AUb2AQ1kYDDNY9LQxW+Yh0qp/YgV8dmJcXVIb7IkAqy1tBBMF7pSPjhgUPlQjxiyshXcJgKXeeAVnuhWdBnFKAhLQ31jQQuUmcd2dht8mLlTGBFwEq0bXnu9Fs6+vxCA5PPUWQxkbVqjKPcFn6pz0G5ObmgyERYdt3PXp/jaX91JdHNt2KJcEnvhfTzzhEiknqQB444jcQSU6SQ1AOmZagnoqeFfomqAn9vXw8i7pHUYn+lCHKmDZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nmw1ERLgw6m5NAgWmutx60rB4K1nWP3476SzBc2K93o=;
 b=rVIe7WdE1QU5O9RMsklpOVgAppiUBZ/BWQD4XPS9yQGMMJ0aTZrdbRs9G+09sKt7/0XFma/8TWa2W5c6lBkAYpRdsZh4CTv3lKMn9z0d1lkeH10ZSjVolnFK7LC+00ebTqVzYSZ0xH0ur2iU4feiSqow31kQ2tQNbg0wlqCewwv0Dwe5+dZqlWXqgSZhaVE8+clEWL5M/sA2isIu1RkYpATmsJV9tKeJ72SIHOQwX3fUUKm7SRiurZxq9nsRCWryrxJoH0qgWRbwtZXS2ddtuEyAIQYfw3pW4fUPw3r/I3hykCu/slnv5Mk6N4PBXYhCnZ6AdMp3Wph1GbHQrRSR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nmw1ERLgw6m5NAgWmutx60rB4K1nWP3476SzBc2K93o=;
 b=s8bFQg180in8X/Dte4HyuS4uOON0pnc6lWehkh1eWgM8tpcHlKsfpsMa9vwPPxzygIeSJxzeH2GaJoPXZqUFOwx3GsK1dVyi1sM82u4n92NUKOuZoOcCwDF3Fd3hqBa23Fi8uVXhyn4JBVflcWTub068X6zbI2DuWMqKICCW7MU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB7026.namprd12.prod.outlook.com (2603:10b6:510:1bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 07:09:56 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9160.008; Tue, 30 Sep 2025
 07:09:56 +0000
Message-ID: <2f709640-0a8b-4bf7-a4e7-c1688f1d7908@amd.com>
Date: Tue, 30 Sep 2025 09:09:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: U-Boot PHY_MSCC vs PHY_VITESSE
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Pramod Kumar <pramod.kumar_1@nxp.com>, Tang Yuantian <andy.tang@nxp.com>, 
 Mingkai Hu <mingkai.hu@nxp.com>, Ashish Kumar <Ashish.Kumar@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Udit Agarwal <udit.agarwal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Manish Tomar <Manish.Tomar@nxp.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Aaron Williams <awilliams@marvell.com>, Mathew McBride <matt@traverse.com.au>
References: <20250929224336.GS6093@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250929224336.GS6093@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0298.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::33) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c26833-04bd-408f-b888-08ddfff05bea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmJpdFNIRXdsOTRlMVpVTTRyUjRiaG15akR5MVN0clpwSi8rV0xZSkJQMkEw?=
 =?utf-8?B?ZjZUdzRqVS81N2w2OVpNb2JSaGtiODE2VGdhMUFONWg0MnFHUGFEbkdKK3h6?=
 =?utf-8?B?UnIwTUhwMVNZa3ZJdkVvWTFMQ0JlbUdaWWF5QkZwTXdISlRwcDJ1d1Z6SEdB?=
 =?utf-8?B?Z0ZtT3k2MzFVOWZOeE80SE96ZFByd1ZBR0ZqYzA3STByR000Rk5LVUFRSXhX?=
 =?utf-8?B?dXU0UE5EbzNDZThwaUt4OEtWUkJrTC9nZy90NWptdkR2OFh3R2ZOUVBkckJY?=
 =?utf-8?B?dkpQT3RUTDczbGtha1daWjgyWVZqc1BIUUhvdVdkUnpqcXlTa0V6VTBxNTNm?=
 =?utf-8?B?VnFiNGtCT2cxN0sva0RBR3ZXU1N2UEZPUGFoYmU4SWdWejlhYTcyZERhQThz?=
 =?utf-8?B?OVowR2kvYi9PYkNKUVhUZktpbzhPTEc3OGRQSFdaYlRaZkpJdlNOKzNxYVFC?=
 =?utf-8?B?bGkzSGhvYVRuTzhJTGg2bVZjcWRXZ2pPOHhwTllpUzJjN1JnN3c4blJ1R0pl?=
 =?utf-8?B?RVVSeFBUVzFHUlZ0OUh3ZkhwWU5MRDBGZE00UWhKZWk4QTY2TlZGcThsYmlF?=
 =?utf-8?B?N1FObDBocmFqQ2tBSjU4b3d3MDF5OEZjZnNhdmZQSnVHcGNIZEVITTdUc3Iv?=
 =?utf-8?B?SGgrSmd3eWpvRDNBN3FKWFh1cGQwWTgzeWN1SFhlOXF5TWN4czhVSExkVi9v?=
 =?utf-8?B?UEkyK1ZTSEgrY1FDbzlMMVFOSXpYVEhkTThaODhlenp4NTJEbWpCa2kvMC9v?=
 =?utf-8?B?cDlNdFVrL3FWZ3Z4YVV2eWRXbUZFZVNhb0swc1lVWTdWN0NMM1VDaER0SUlp?=
 =?utf-8?B?US9ZeDdJRU1MYkxQYzNCbFJ0KzdVTE5IQ1pVNm9FMFVDcmVDZ2ZSUE4xb05t?=
 =?utf-8?B?NmpRRytWVytFZFV0VE1YUWlTRWJRQ0N3d1EyemJnTnFGQkZnWmJxVnFvWkZF?=
 =?utf-8?B?b2hrN1ZOWFJEalFwQlJVeXQxV3JHY1ovSVBoNmlKcFFoVTFRQWFSb012a2pj?=
 =?utf-8?B?NzIzTThBeStjYWZQU2hqZkFObnVmMXlYL3hhL09rK3BrNUxNZElaSUh5dFNx?=
 =?utf-8?B?djJabG9FNjBrT29saUFnMHdnQWR0TFZVRTVOeVdhTVU0eDR2OU5YWnpyZ05N?=
 =?utf-8?B?eXRoQUt0Qk9UVmZqTStlNzFsbkl3WnlwS1Jtbzl4RHVGM2RlU0ZYZU05L1NP?=
 =?utf-8?B?aWE2MmdWbUliNGhEcEJWc0YrTUhHR3RQcXYySmdRRUFFMDJGMi9WUUpHRWN2?=
 =?utf-8?B?a3N5SlRJaTBzZVJCaHBiWUd6M2Jzc1FudU5ZSm1ubkR3NXlZTU0xVDhhNnhx?=
 =?utf-8?B?a0YzR2R0Q1lRRENvYUtLQ28xRThvODJkeHNLeTlTRkhsRWlseXZyWkdLak5W?=
 =?utf-8?B?Wm5aUFRxNjhRNnJOcytVMHNNcXN5QjE2ODl4NWZnTDdpeXhTS0l1TUhMWllj?=
 =?utf-8?B?WjBrODJGTG15VXMvL3JJbkR0U0RvQ04xSHRNaFRvYU5rQ0VlaTg3OW9Cb2RW?=
 =?utf-8?B?bnJVbEpuK3plNnlRQ01BeUV1UEZRanpNc3dUVHREOTBZWW5DRkN3V1dPZk5B?=
 =?utf-8?B?TFN3VFBUNUQ0VHZDVHRBWjJSU3lLbWFWVllTQWdkOHptNms4QUR2aHU1K3Yv?=
 =?utf-8?B?TENGK1FzV1NBbk5KdkYycUZWRWM1U3pYQWFMcnR3UllzZ1I5bUpKVzJ6eHdx?=
 =?utf-8?B?YU96bkd5eEtwSFNZbk9DQlZYVldEQm5BanRjd3pTZ3VQYlFsNkw2RmpyMmZI?=
 =?utf-8?B?VjJ5MmhMVEJ4UkQ4ZjlmYkxocEhGMDYweURwblFhVGh0dTE5T3FZSk00KzRD?=
 =?utf-8?B?cG9xdk5ZTWRPUGN2NUVNRTlRNzcyWElsQTBzZjdKaVpqZE9TdWVLbXZkQVN4?=
 =?utf-8?B?SFlvVGFNYnVvMHdHZFU3ZXpubzAyaHJ4THhaUnJEd0IrNUpjb0svYmJLcEtO?=
 =?utf-8?Q?bZw2gY6cDqDayCIS8mk0bVn6D7rLY7Na?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG4vNTVXbUJnNnE4bE9GRHBHcXZQVHF4ZUMvSG9wT2NIck4zbzRkVllKRVV0?=
 =?utf-8?B?SG5zcDBKdVZHWlV5RWdNQlRnKzNydS9sRU90eURmdWxtbWhpSmp0Tm5nTEMr?=
 =?utf-8?B?UWUxL0diQTMxRVI0cW5IUUl5V1IyTDNManRTV3c5TG81UU50bThVTC9LY3Zw?=
 =?utf-8?B?a21zc0NqSEx4NTZTZDA3QkIyQzRCWGVxdldGaFluOU1HYU5LSkF6UkFoTEpn?=
 =?utf-8?B?YnRyWTVMYUJPWm1JN0Q2eHlGcHcrcVNFQTJpN2VDT1dZb0wxK0JrMStkb2Ry?=
 =?utf-8?B?eXR5NnBhM3JFQ2NRcEZvbVAzb3dyd2tkZ3VhaUxKdXF5QjVmRFpvOHE4eWxW?=
 =?utf-8?B?TU5uVHg5RG9Vb0xpdml1ZDYzOG1PdzV3VXVDTHh2VWlyckltYng4MjNWWE5F?=
 =?utf-8?B?cFIzSDRRUGNBQUk3aE9JUFhDVU5vOFBRN3d3MlZPZGdTbXFDRkJPYjU3UUZK?=
 =?utf-8?B?SEF6ekdDNXhiTlRIOERoUHFyQ1FJbTRRUEVKNDExc1VFNFg5cDZnYUo0R3RN?=
 =?utf-8?B?V0RoTDdKOTZ2YzlNTEdMNTJLTDA3RmhuSVp6NXVOQ2xJOEV6aStWQ3p3bTNH?=
 =?utf-8?B?SHZzYU1CUHgyaWU5M05TdlZHcUZTTGFPbGNoTzhFY1NVUDFEOVAvOGlTREYw?=
 =?utf-8?B?c0tKZytsNWFUbTBPNGtWU0F2MG9FaXdYb3lXeVNxUURkS2RicThCUHhyUGFV?=
 =?utf-8?B?U3dsTzYvVGo2cG51QUVGSy9EcWZkUVlwdnFwSVowSnpzL2FVdHRwV0w2SVhT?=
 =?utf-8?B?L09vNnBhT0FmTWV0S2lLSGpuZm96WkUzNWEwWko4R2VhU3FScnJIdkkyT2pw?=
 =?utf-8?B?RTc1QmNvNExqM1Z3dXFDQk5wdTU1b3VBMzJhNnEyVk4rdEFTS2Joc0FDTCta?=
 =?utf-8?B?VGdyKzFFTXdEbVJnOTN2am1qckcyTldZMlJSMFpiei8yK1ZiN0dqWWJIbWwr?=
 =?utf-8?B?Z3psSS82SnlZUjVkdlR4R2FDQmlMcjV6RThpdGZiN2liRGIwWHE1WE9LTWFh?=
 =?utf-8?B?RWRIR3RUdmtKV1dOK0pNaFY4aVR6NUdvV3owZXBCMTdIR1ZzbHk0TWkwbml6?=
 =?utf-8?B?ZVdFQmorSFpqcE4yVHhwTnIxaFhpMjAxb2xKdkNqSGN4SmR3ZzFkVjF6cHhB?=
 =?utf-8?B?YUV0a0JqQWVjUnBkanpjZlRmZHhlOUd4YlN4V3d1VmpkaXpycEVDTmdmUVpV?=
 =?utf-8?B?L0tpTUxmc2hCNFAvRTRGM2hiZkFrWFpWZzdLZ0MwV2NkWUhGbHlXVFp3S1F1?=
 =?utf-8?B?NjlLTnl3R1gvUnl5SVd6S3lONXdzTjFXOGRIaTUvNk1xaUtTWmZhK0tvS2xL?=
 =?utf-8?B?bnZZL29EdEh5UTRzL3dGQUpoZVFENDhVRG5ua1FLcm1EVEZGYlAvY0xNQWxZ?=
 =?utf-8?B?bUdUWWFiS0JJa1NQcmJNS0hsRytubjJSbmJhSFdaNjhJNGZZeER5MlFKNnFn?=
 =?utf-8?B?QmpPY2t5MVd6d25LckhZVjd4bXpRTi90Q3VBZzBaSkxpa3plRjd3VS9xbkZm?=
 =?utf-8?B?QTduOGZJSGtrZWt4Vzg5SEZYU2srK0Uwa1RhL3M3M1ppK3VZeXRBaTM3dGdR?=
 =?utf-8?B?N1BnWDNJTklLZ21jK3p5MHBMTzRvTzhEQkg0Tko0TnJrR1REMzJZNjB4U3ZH?=
 =?utf-8?B?K2VNTTU1dDdpTlpkUmtXVFBtSTkxVTU3RDUxaWJxVG9BWElPZGxCeXNiSVpD?=
 =?utf-8?B?emM2bWM1a1FrQk0xTFhPbitTcXdMVGpld3JiZ2xlNi92cHpjdzZWUmJnRWFh?=
 =?utf-8?B?dlhNdmxiZ2ZJVmhjN0tlend1TFpOZU5QUXlvd2ZxeU5SRS9VczhXeHlQaGpa?=
 =?utf-8?B?cm5OcEhydWcwYWVSYjVJZGN5MlptRmdxbVdadTRiQkEzWmJIVS9wbHJKejNL?=
 =?utf-8?B?L2RqdW5CRVZST09YN1JObFRhb2FyckhmbFNwa3NYMXFZampsZGo0M0NjRVJx?=
 =?utf-8?B?NlAwUHI1T0lyRWM1bWpmMVd5T0Y3NzZ3VEIzTWhEZW1BWkFWTWFIQVlKZm1I?=
 =?utf-8?B?K0FsNXgwR3ZyQXhnZVFNK05vc21iQVErVnJyM01RNkgzWFllY1EzZFBocXlV?=
 =?utf-8?B?Rk40SGlkbHorZ2VzNEdKVzE4dTlUM2JxZWFobzVzMWdWVEQxVWRzakx1aE9Y?=
 =?utf-8?Q?XfbvjzxjJVwNoSwWh4YMYx3Tf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c26833-04bd-408f-b888-08ddfff05bea
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 07:09:55.9394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqQZsm3XgXkgGi9le27q9dYD4KoqtH+q2TsvZpgyhuHca+3LBqMJIcWVFwKk41K7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026
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

Hi,

On 9/30/25 00:43, Tom Rini wrote:
> Hey all,
> 
> As part of working on "allyesconfig" support I ran into the following
> problem. Both drivers/net/phy/mscc.c and drivers/net/phy/vitesse.c
> implement support for the VSC8584 PHY. The vitesse.c driver is much
> older and only had VSC8584 support added for a specific Freescale
> Layerscape platform whereas mscc.c is modern and been updated with
> newer PHYs as well. And we need one driver to support this phy, not two.
> I am inclined to remove support from vitesse.c. However, only 4
> platforms use the PHY_MSCC driver and everyone else uses PHY_VITESSE.
> 
> I'm cc'ing all of the board maintainers (other than PowerPC platforms)
> that use PHY_VITESEE today to see what their feedback is on which way to
> go here. I'm ignoring PowerPC because that can just stay on the
> PHY_VITESSE driver based on timing of changes in git log.
> 

We have VSC8531 on one Versal board which is the part of mscc.c driver already.
Because we do create one config for all boards with the same SOC to have 
something to start with enabling ethernet phy is just in case.

I sent the patch to switch to MSCC driver.

Thanks,
Michal

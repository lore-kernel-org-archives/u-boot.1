Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53A3D1038B
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 08:09:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81B838418C;
	Wed, 26 Nov 2025 09:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3QjLRRVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EA2284199; Wed, 26 Nov 2025 09:09:52 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B679184142
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 09:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjDzGKqyaUzOzKd6l2I2i8ckCKVWU0nn4kzoh7j0u5+RT9orTEhEQdvVBtryPoGaL8HxdQ3JHUesXwy5EKFuzhnCONHHtGp4od4qKpX46bHnbvDQOc2C00ZLokdllHl7XaOvmWNFmjZjR8p9JKliEj13+W/b88x1EQITBm09CR77zdnFxO5Nx8ryMQroP+7Fy7Y9mtkL6xFkmPisglRf2jz4ii1h8jMagFf5RhYtB42lrJu+KkGxIgo/mujOA+CcYMBoqUIfWORbPXkuo2w6V3XsfJqm26FcJ2/W667Pt1LQte+dVKTljAHwsngswqnQwd1ADdrp0Oj+a8/yqLzLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIRXCVj/afdlxGeyxRNWHpmkeQtmbZ92drFWh9Ja2QY=;
 b=BdeZR3pfo9Pmw3sGapxKzwyCGMbEwLCI25au29HS6rx7VONXTQOo3Vo5tSMfA10ZispBu+to5JUx1ilmZ5ckXLbV4u4K3LntChFfdV+nC6fdDQJzE7mYtXSRUONUdlSq9KAp3mtQMV/BB0ASkX64OmPGu4X1O1/FP88eHTu8LtTL8jmcB/OkNbzkL04vVElBlHHD4knf1FoEzs6PMsqX0qiwXUrAiTNgvXvGB/yugXGYF3qJfP2mHDJyQqkrsH6dl2DqJxZ0JDQOxWBeMtaR0WzjcnLcbijXWDigrT/Gjg3yOWYrqLTgxaX9hU+tya1QFHu6ffbIDnrlq8XWAzOesQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIRXCVj/afdlxGeyxRNWHpmkeQtmbZ92drFWh9Ja2QY=;
 b=3QjLRRVAOYXdK5a08Cr30lF1dpRUR1vYLBQvZMuClBd0ZOsUZPL8pgjO+ioZ/g6d9IgrrPkqmnRwKJ1+m2y89ril4bazFKB2x1u86iAWJjEWHNQrYJJ5wl+1VEL9XqDp7u3ButneHKhdu09k9Bh5XK4olEFMzR5YWT5plL5gAcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN6PR12MB8490.namprd12.prod.outlook.com (2603:10b6:208:470::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 08:09:43 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 08:09:43 +0000
Message-ID: <2a44cb01-b6b9-411a-a9df-cb521a68ac14@amd.com>
Date: Wed, 26 Nov 2025 09:09:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] firmware: xilinx: Add support for enhancement SMC
 format
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <16bdee56fd75113c6d531bae7a8a34900b10280d.1762788250.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <16bdee56fd75113c6d531bae7a8a34900b10280d.1762788250.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0076.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::21) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN6PR12MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: 647a1432-4dba-417e-c54e-08de2cc327d7
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ti9DZ21ia2FSSGxZZlVCVlZ1YlVoaEtSRFVVSHgzZE96ZWMyRlBBUFpNZ2sx?=
 =?utf-8?B?NFJKcmtrTFA0cE5NelYxcEdsWVQ4U3JydU9sejYxdytsV0JMbFd3dU9iODdq?=
 =?utf-8?B?eEp5UE9ramhpNFg5aE1HRFZvWVF5SkxJaktmQ21seVZZMnRMTFJTRFNRbHQr?=
 =?utf-8?B?eGpuMUkzKzNaZFZ6WXBycEQ1N0dOYlErLzl6ZkthcmYvRUxSUVF5N2greUY1?=
 =?utf-8?B?QXZ6dXZJSmZCdHpMVFlhUEtzN2ppcW13b0lGd3h6NVJqZnBrY3VmS3ZNSy9a?=
 =?utf-8?B?SmRDL1QzR3gyWkpZSUxaMEJpemJJMnNyL0FsVzJ5YWRRbmdteHVlOEUzUllU?=
 =?utf-8?B?R0RGazVJNzdHYTFJKzkybnF5Ky9CcGRtS0JZZW9ZV2NTamtwSlg3RW9ZL2dT?=
 =?utf-8?B?TzlBazB2UDRNOG5jTEJoaEhSN2pUVDUrZ2tCdmZDMzlNMzNlV1ZSQmlqLzNm?=
 =?utf-8?B?RThQL1BoSVJpMlhiN0FFTnNuTXlQR1Y0a0kzSzBIN2orWktDT3MrREcvZXQx?=
 =?utf-8?B?R3hKc2JXUGRaTnAxWkt0RDAyRXFpWnFrME51Z3B4Mjd5ZUJEWHprOW5DWnBt?=
 =?utf-8?B?S25ENlh2eGJ6UXJwdDNnTW4wSGk3YnkrODJCT0VxQWI0R0didFhrYlU4blBt?=
 =?utf-8?B?ZWVBa3dUMXJZOXJtZ21LcGpCd0g2dlAwRFN6dFVmNFhjc3BGT05yaE80Q0Fk?=
 =?utf-8?B?NTdoRDllTGZNYjBpZ0FVcjZWRHRxU29JdFVDL0ZiRkNMVGViMDZ1bm1lNkZl?=
 =?utf-8?B?TC91ekY5TGVNZUZnM3RRUHNOMFlkZFgrREo3MXAvaTNZWk1NOWphcFlXcHVF?=
 =?utf-8?B?cDBXN2xYbTA1WW5QUG0zeHpuVEx4Zmh4VWdvWlJxMVNHdFZFVEZ1Ymh1Z2pK?=
 =?utf-8?B?S2cwdEsvanFKVUhWNG5KcW1CVlMwVDFnb1FLUXBIVEVHV3hNUGdSeUZIaGFW?=
 =?utf-8?B?OThzUDVzTG1JMGtVUXFrV3NmS2tMc0VMcThsamxOclMxOHFkcWM1b2FaZXUv?=
 =?utf-8?B?cndSUTBLNmtoRmJVc01wN1pJcjNoZE5aQU9uYmthdXA4UW9EdStLWkNZYXI3?=
 =?utf-8?B?Y1dscTBQYW01Sml0SlA1aWJnVjl4dHVKa0lsU3hSNE9KRitRTFNVV014bjUr?=
 =?utf-8?B?YVlLNHlKdnZRbk9QOEhlQXl0QlZobnNyb0tuc3FpWmY4TW1DQlFnK3FUZWJQ?=
 =?utf-8?B?MTBSSVhIMEgrTHNBaktGbThTQnJFbXE4aWd4U3JsY1pJMWpoY2ZtL3JUQnFQ?=
 =?utf-8?B?UUxEMzRzRTloRUM0S2d5RnNsalp3cGVYZ0k3U0M0TUJNV2ZJY1VhWkFWSkM0?=
 =?utf-8?B?NEp1b3g2NHNvU0FidXliaWdHMHZRZUhYVkowb1dLWnVqSmxVbG1JM2JUL3U5?=
 =?utf-8?B?LzV2U2pJa2RNaXZ3SnpRYm9wQjNpeERhWmgwUVRyV2NzZkU5ZkNlQ1h5bm84?=
 =?utf-8?B?M0Nadk9meG1LZDZuaGhQdk1XWDRHWlBlUXAyVE1jTUtpamV4RjhPT3NhR0Zz?=
 =?utf-8?B?U3JTeC9aSEFiaWRCcGR4NG9pSkUza0RQcUIwN25SSlBOdW14Qmc0OUE0TS94?=
 =?utf-8?B?NkZsYjJBQXlKdW15dzBZeG5YM1JNNzh2LytpWlVlQjBPT2xYZEJvUFJsNko3?=
 =?utf-8?B?MmdGeHgvSVUzY2RVWTNFdnYzNnN2YWlSTDVUU1ZUbWNOd0h2VTViWW5oU0tH?=
 =?utf-8?B?Y1dFSUdJOEFTdk9oVDRROVBURjRMVk1oRWtNWnEzRCtSVDNIZURSOVhHaElk?=
 =?utf-8?B?TWRxMzRyZEMzOHR5ckZORXNjajBoVXhZY1RVUUFqc3dhZXdUa0s3eDNtcHdX?=
 =?utf-8?B?WEM1Yk9Fd3I5T3pKbHNoMVFRNURubHhHYTM4TEYxS2pSYlBGcVBFYXRXWUxI?=
 =?utf-8?B?SElPVjJjNVQxUmsyVHYxQ2hNdGRPM09SMlNvNXlGeUN6Y2NQWmhUR1orbSt1?=
 =?utf-8?Q?407Z9Gqj9mT1hnZSq73x4Tt20+WdjCFM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEYrNHN5dms4YXZZTTQ1dENTUmo1YXdXalpab2pQcDZTM2N2MmhEVHZuWGhG?=
 =?utf-8?B?cjZmUGwvcjdtOTFPcmFHUFZIcnozT1hHWFZVQll4ZTlhQktuc3BSY0pXQ2xC?=
 =?utf-8?B?UEFXdjNFVllNditkSFcrTDJGWW5EdldtRXNIQyt5cFU0UjhOV3E5WXM2dW1N?=
 =?utf-8?B?UXlhVnF1U0ExS0IwUG42Rzg0UGdWcDRkeU9kK0J5dmY4cS9IV25CYkczS0pw?=
 =?utf-8?B?bGY5QVFQMGdDZURFY0x6S2Z3dnBFR0VqaXZHRStxY09wWERjalFtdDg1MEVO?=
 =?utf-8?B?ZVJjSG5OM0Zyckt3WURBa1lRMTRlMHB0YzMrRy9HRkxWalZNOUJxMjZKNDgw?=
 =?utf-8?B?NW8yS1hySkNGejFPVE5QNy81VWQxT2lVNzczck10cEFuM3hmMkR4bU1XZ1lq?=
 =?utf-8?B?RlZrOFFnNXhUWnhQUHl2LzdOM3RSc1ZXM3lZVjcyUTZFN0NtdkF3a01zWDI4?=
 =?utf-8?B?SE1pOUFNSisxaDJnUTI0VjRlL1BRV1Z6V2VqZWpxSWZqVmZFUEdGbVBLQ0pk?=
 =?utf-8?B?THBTRnI5bHpUZGRwYWsrVkh3bUlXRkEvaG5HWTFzQmJOKzFRYmhTQUVpZm9u?=
 =?utf-8?B?aEI5cVB5VlcxSWdMVnBjK3RJYjVJU1QwMVpvR0Z4WFp2WWxVUnVZOW54VXEy?=
 =?utf-8?B?SEs5cGZwQkMxK1ZlTUNNdk9Ga1Q4MDZPMGx3Q3hJL0ZGSjRsNllhM1BUM2Qw?=
 =?utf-8?B?Q1lBNzNndVpYMlJSUURZL3ZOWklLWGI0eXNITC9RRVJvRURVeUFiUGJxeVg2?=
 =?utf-8?B?S2NDWXhZeFVQRnVjRXZWbWJqaXFKd0h3ZDc1ajlzbG94RGpERFM1UkIyZ09p?=
 =?utf-8?B?dGhHWEdiOFRhTjdweDNnNlp1M3VQU0IyQm91ZXFCVFRaaUpZTWhFZytLR0Ja?=
 =?utf-8?B?b3FldWxiTDEwSmxqZkdSckZwQlY1RlBTbitKa2xRd2gyZm9PQ0tIVTByZUJh?=
 =?utf-8?B?Vis2a25oYWtubDEyRUpZWkxnQlRhSHdoNmJ1VlNpcjVjemdTLzFRUHhHdDJI?=
 =?utf-8?B?ZHFleDFTMlk3dXN0V3FaNzM0WFpxams0K05XM0l2Mm1uK2tvc1IwQkJlYm80?=
 =?utf-8?B?N1FVdll6QjVDOTZ6bjN0M3BKMUh6RlkyVndZbnlJWmZuZld6RmJEai9UajAv?=
 =?utf-8?B?T3Bjb3F5alBFZUVRUXFtUFltaXBCNThsajBPekZiUU56bkJ2QjZKNjVGZ1Qw?=
 =?utf-8?B?SGJ6RkdJUDd3YXdYMDZCb3E4S0U4TUdURndxL2xvUUpIWDJSMC9OYzNBNDYw?=
 =?utf-8?B?UzkwUFdYRk1CcEFKQmZwbjNFeTlLOW1mSmg1dnFCMkxFZXNmMks1Q2U0RHpx?=
 =?utf-8?B?b21rVEtzQTRrSjh3TXExdStnWFp4S0J3a0JBd3BtdXFTQW02bHZYWWQwZnkz?=
 =?utf-8?B?NVEvd0xGb1I0T1ZhbUQ0WmlsalZjbkN4RTJCMVpzaWVuejNGZVR2Y3E3dzJ6?=
 =?utf-8?B?MHIra1liZ0M4VzVoQWUrZkJ1QkV0OEhEZEVOeFNFdXlTOEd3b1hPd05HMEs5?=
 =?utf-8?B?QjY0ZUNMRkhKalN5UytIVDljQ2Qwa1NseUMyQ00ya1JudmZzVFlWMWFub09Q?=
 =?utf-8?B?dmMyM3ZoYVpLQStzMHFyQnFZdlhXYVMzTWppTnliM1BqM3FtQlNvYkJRUVNz?=
 =?utf-8?B?Y0w4MHFjUGt6Myt2V2VGdmx0cm9rbTlQNCt5dUJlbENIRHRGQzdIS2JOUm9k?=
 =?utf-8?B?dGFmTFJ5UUZwQktPYlU5VEdocE9JTUZpcVZVUFY5MUJrQU9MbFVUZ3cvcEVY?=
 =?utf-8?B?UGJVZmRZSnpjdFNydlVWTGMzdFJJaVlPbmpOcE9abmRrSTdjeXBoZzdYSkp3?=
 =?utf-8?B?SUc4K2V0UTNEelFLa0pnVGJBTXErNXNRdlpvbUJ3NEl5SGttVkJaQlVJeUJY?=
 =?utf-8?B?bENiYmh0VHBCTVpoUHNxWHdXRDBtSVZKSFd1TU1DdXBoVzZYZFZ3S09zc3NE?=
 =?utf-8?B?bDBSSk16VUZ4c0NjZllFUXVPNERJbWE1ZzQ2REpqZ3ozMkFMVC9LNmlBZHY0?=
 =?utf-8?B?Vll4V3RTcmc2ai80eEI4b0s0cjhhaitacmh0NnBUU3J1S2E2SW5ieXF2akpH?=
 =?utf-8?B?bG1HNzlNVy9sbVdJN1lFeE9oZ2VMNUdpQjZjRnN3a0pueWFCemlPN3VpWG81?=
 =?utf-8?Q?6jfl0wkeEbpjlETF5ai2pjVYe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647a1432-4dba-417e-c54e-08de2cc327d7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 08:09:43.3979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33R3eRKwZFgi1YIA8NvyYu0hH49ACGJrgUFAEqGnxGs47JD0oPS3+a9S2LxMGmOI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8490
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



On 11/10/25 16:24, Michal Simek wrote:
> Versal Gen 2 is using different SMC format that's why firmware and clock
> drivers needs to be align with it.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/firmware/firmware-zynqmp.c | 34 ++++++++++++++++++++++++++++++
>   include/zynqmp_firmware.h          |  6 ++++++
>   2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
> index 3742467caee1..2ef499bf4084 100644
> --- a/drivers/firmware/firmware-zynqmp.c
> +++ b/drivers/firmware/firmware-zynqmp.c
> @@ -16,6 +16,7 @@
>   #include <zynqmp_firmware.h>
>   #include <asm/cache.h>
>   #include <asm/ptrace.h>
> +#include <linux/bitfield.h>
>   
>   #if defined(CONFIG_ZYNQMP_IPI)
>   #include <mailbox.h>
> @@ -451,6 +452,38 @@ static int smc_call_legacy(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
>   	return (ret_payload) ? ret_payload[0] : 0;
>   }
>   
> +static int smc_call_enhanced(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
> +			     u32 arg3, u32 arg4, u32 arg5, u32 *ret_payload)
> +{
> +	struct pt_regs regs;
> +	u32 module_id = FIELD_GET(PLM_MODULE_ID_MASK, api_id);
> +
> +	if (module_id == 0)
> +		module_id = PM_MODULE_ID;
> +
> +	regs.regs[0] = PM_SIP_SVC | PASS_THROUGH_FW_CMD_ID;
> +	regs.regs[1] = ((u64)arg0 << 32U) |
> +			FIELD_PREP(PLM_MODULE_ID_MASK, module_id) |
> +			(api_id & API_ID_MASK);
> +	regs.regs[2] = arg1 | ((u64)arg2 << 32);
> +	regs.regs[3] = arg3 | ((u64)arg4 << 32);
> +	regs.regs[4] = arg5;
> +
> +	smc_call(&regs);
> +
> +	if (ret_payload) {
> +		ret_payload[0] = regs.regs[0];
> +		ret_payload[1] = upper_32_bits(regs.regs[0]);
> +		ret_payload[2] = (u32)regs.regs[1];
> +		ret_payload[3] = upper_32_bits(regs.regs[1]);
> +		ret_payload[4] = (u32)regs.regs[2];
> +		ret_payload[5] = upper_32_bits((u32)regs.regs[2]);
> +		ret_payload[6] = (u32)regs.regs[3];
> +	}
> +
> +	return regs.regs[0];
> +}
> +
>   int __maybe_unused xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
>   				     u32 arg3, u32 arg4, u32 arg5, u32 *ret_payload)
>   {
> @@ -494,6 +527,7 @@ static const struct udevice_id zynqmp_firmware_ids[] = {
>   	{ .compatible = "xlnx,zynqmp-firmware", .data = (ulong)smc_call_legacy },
>   	{ .compatible = "xlnx,versal-firmware", .data = (ulong)smc_call_legacy},
>   	{ .compatible = "xlnx,versal-net-firmware", .data = (ulong)smc_call_legacy },
> +	{ .compatible = "xlnx,versal2-firmware", .data = (ulong)smc_call_enhanced},
>   	{ }
>   };
>   
> diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
> index 7f93241b1932..72f6459b91c8 100644
> --- a/include/zynqmp_firmware.h
> +++ b/include/zynqmp_firmware.h
> @@ -521,4 +521,10 @@ typedef int (*smc_call_handler_t)(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
>   
>   extern smc_call_handler_t __data smc_call_handler;
>   
> +#define PM_MODULE_ID		2
> +
> +#define PASS_THROUGH_FW_CMD_ID	GENMASK(11, 0)
> +#define PLM_MODULE_ID_MASK	GENMASK(15, 8)
> +#define API_ID_MASK		GENMASK(7, 0)
> +
>   #endif /* _ZYNQMP_FIRMWARE_H_ */

Applied.
M

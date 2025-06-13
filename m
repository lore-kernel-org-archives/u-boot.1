Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ACBC71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 08:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04C6582C30;
	Fri, 13 Jun 2025 10:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F6PznU9p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CD6C82C44; Fri, 13 Jun 2025 10:31:46 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D680182C2F
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 10:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZFBYFFWYXhnSHBn7h5Q5aY1mcLqRwMWB5C6QcOsTU/pgIM+DQ9Rs7pUcBeq0ZffYmdJQdMgC9E9PxowMitm+Zl0canHREdhHm2vLzDGzedy3KD1kTZMW/RYV1+c/o5+IjyhiWvOepelKTOxlWVoa3Pbul0nvTxC5FFDwCQ7uDU0NxkvQz4dALwf0APEXlISEvbxn7kpGjaibKBQBWVwI2Od2/iS/zI40B7vKOfbYCG/cwXb2/V8UFRyj5/ELxn9+yxxKkTrNgiNcsVVIhPZAmdCU2WTysHiqTZEIY7DSG/8rH8H6uMmS/APrg/+KDitREobVgLNtRPIiNyC6s1D7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4FzKgcn//YHh6SDxJccUil2V27hOwyuDqfJQqhfp+w=;
 b=BMd0ZJk5RdFgi1yXvTjQt2eJ04BZCxFFE7yTYpqL5UO/Ir0eWeTZe7KL3laEogUEbmwIxhzsdHUM1/SLYVIWy1nyMM0og2q6NaVjRob3T0Z9+Q4A7Pdya8TYS6inR6WtFJlROGbLRgXrdlDmzKEl5luE7CBeI/eAIW1t79YVHevwwj6iKZSl5FNRGG+fvuU9NGiEsoGYklJKERJPymBXZsPTh089po8TtOzW45hmDJbmq6tkwbwIkcR7I6oLfrkTuZX9nf/eCyJgqDfWhBoMGfSafVKDqaObjtOHnQM6iOrj39jVfA2qaQKE5V6PsajvE1cSS1cwFnZTjCYEjb/ETg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4FzKgcn//YHh6SDxJccUil2V27hOwyuDqfJQqhfp+w=;
 b=F6PznU9pG8Z0YEAexC1pJFJhpgCAQrwod+PjXD6Z5KRwMlM7iyrHS7eyAzi7EoH3EiPGSzR6FP9Hahn6JWwY9pGDI/wEPORECQkyonXAQHtNSpqKmg2WBSrzEDOFuStspklhFMAXhjFypdBSyoApxDU2qHavQ0udJJzAofobIhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 08:31:41 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 08:31:41 +0000
Message-ID: <5e694bb1-02e7-48c2-8b07-35882fff0939@amd.com>
Date: Fri, 13 Jun 2025 10:31:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: zynqmp: Remove local copy of
 'dt-bindings/clock/xlnx-zynqmp-clk.h'
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250612181128.340232-1-trini@konsulko.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250612181128.340232-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0025.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::38) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b4497d-fb1e-4f1d-9e67-08ddaa54b8a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eStmZGFsMDZJck85RVhtZ3dTZlpMWXNocVkwdHAvYk1BYmdJWUt5MkZBNE9T?=
 =?utf-8?B?UHU3Uk83VDFjcU8yR2lXUysxbDViY0xXeTlWOGJ5L3pmRStUYm9kZGoybFQy?=
 =?utf-8?B?VUJIQ01qdjdSSFkzM05JVG9GM1VBUHVCNnJnK3B5M1NRWFdnQTdkcFZadjhl?=
 =?utf-8?B?QTdYWmllOTgyNGh6VWxhcWtzdjdFWjdMSXFQcDFBR21FREF3REtieFZXUmh5?=
 =?utf-8?B?VUJpVGl6T2ZOZk5tak5UZ0UxNHJoUDlJQkprbWovNWEzSmpUL3c2OGFnc0gy?=
 =?utf-8?B?ZkN0U1lOc096K2FSQTN6b3hDV0tDUmR4TjZPU0tQZ3JmdXlyQ2cyaEsrZDZs?=
 =?utf-8?B?TXE1L2FySS9HTjNxZURPS0tNSzNKWHFVamFUNnNWVVV0b0dXZFc0YnJ0alRz?=
 =?utf-8?B?QzBiSFY3bmpsRTdEYmhuS0ZHYmNUMitMVDFiN3gvdEUvQml6RjY0SjRHQWF6?=
 =?utf-8?B?WkI4cUNORkxJVFEyeUtYaUJwWG05UjZqU1dCdGZXVXB5Uy9sSklBZ1hpcnZJ?=
 =?utf-8?B?clpZY1ZibGxvVFh4aUZnWmhsaEsvKzB3cUpERnQrUWxGNVFDWlFMMTRTZ2lX?=
 =?utf-8?B?SFYzVzIrU29Udys0bFFBY2V1b1JhcUJ1YUg1OVpEZG84VjZTZjJHR2l3ODQw?=
 =?utf-8?B?cUlXT1FsZVJ0UEVwNnpzQUdQWTZDWUpNalNPZm01eXZrUUM5aXhjUDlSZTVa?=
 =?utf-8?B?ZXdUNytnRXlGRGs5dVhPR0VsdnhPdC92Vit6Vkh1OXd5L0dvM0pDVmpLV3JJ?=
 =?utf-8?B?SmZ3Yk1qZnN5QlN4RjV1YzluVnVMM2xXZFQzUTBlaUg2cGxJcWNONzRGdzlB?=
 =?utf-8?B?dWU3YlUvVHpHYW4vb3RDYVlKSHI2QWJWK1VNZUd0elI1UjlEczRMVExKbEhh?=
 =?utf-8?B?dFhTdTkyR1pvZHNhdXNTNWxjOVNPM1hTMnc2NXdQZmVoTjV5TXFWbTVPNmFt?=
 =?utf-8?B?azcyNGVjWHJqQ29XMFpKckNMUFhUaWFCaUtCdzR3blJld0xPZms1ekFjWGww?=
 =?utf-8?B?RE9FR2p2ckJKYTBUbDNBQWpkcnJ5RVFtSldWMyt0bFNCZCtiMmpLVU5tdDN0?=
 =?utf-8?B?SVVnWmpWc0I2UzdPeUtGbGdaYmdvY3BRUmg0bS9oRjJqbU1PbWJPdm5rSElJ?=
 =?utf-8?B?eDkybnk0eG5LMm1iZTJnTHo5cEN1L2hQcjUyODdhWG1tZWZCZkVELzZnSUdz?=
 =?utf-8?B?c0NhZ2FTUjltcmJEOHhlb2c4Y1N4SjNKOEtPMUdVdzNVSW9zZkhrZkw1dDVE?=
 =?utf-8?B?bVFSRFFsSS9ITGRCWFBIS21Ic0FUWU44Q3NjZmt3blJBRkhBNjdPNE9temY0?=
 =?utf-8?B?SkM4cHhHZVRpZE1HbnNBNHlxaytScndVZHJCeXV0TXdDdGNPakZKVG5OS1h3?=
 =?utf-8?B?VVRmTTBlckJBNXVZTHdLZmFwaFA5ZGtYM1dLaEtsVklaUENGdEFhUFVlTUFL?=
 =?utf-8?B?ckxwTDBiVUVWSC80T1doNWlnNFgwMmNVWTdKaktXV1YvZWR4WXBMZW9Zbjc4?=
 =?utf-8?B?MW9qdlM0ck1PZFc5bEtxaWdTSTh0TVJzeDJDTzV0SENBK2lwa2J5emwwOVBZ?=
 =?utf-8?B?MXRIeTJ5TUMrM0IzbStyUHhzanZxL0lKdmUxRlRrQUtMa2hsNUxPWTNVVk9o?=
 =?utf-8?B?UVZJYmJWNjVEYVpWT2ZMMmgwZmh3UkxGTkhTcFpwRXFZMVNaUFZoR3dCU0Y2?=
 =?utf-8?B?SmRpdnBqRVYwU2dZRGZCM0hzREdSVGF4dFhFNzlzTW1vdEt6SUxHdlpLdU9C?=
 =?utf-8?B?dlVtRmFuZExNc25VOG13aG4yT2l0aHlIYWxhTVJYTmcvZjJqYXdRRy82Y2oz?=
 =?utf-8?B?TEV6Nlk1cDB5WmtTTFoxcGxIbkE1dUdEU2g4ejREK3FJNDZFTTZ2dDl3bGE0?=
 =?utf-8?B?c1lNUnJLczN5V1J6M1I4Uk95ODhEUTFKdHFGalQvTDR0YXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmxPbGVxN2RPd1FHRFhiT2Z3eEQ0aE5qQktUeTd2MEIrVEFMb09wb1dqRkVK?=
 =?utf-8?B?RVUwUFhTNjdjRFFqRlBHcXNOanVaZXduVU94dTRDRTFEVXhyVG1ScFZxQ0ly?=
 =?utf-8?B?QXF4eEZxcTc1TXY2NlNsN3FKaDlseXZHeTlOUllYSGdDV3ROaHJxZldjZkF3?=
 =?utf-8?B?SENjWENDT1E1ZCt4ZTFaMGgvSHhRVUdFZFdPL0l4eCsrcmI4OEErbmo3M2kr?=
 =?utf-8?B?N0JKM0FKbXZocFE1WmMwRS9nVVlHb2lkZW12UHBRS0VSU2RPNVpLcHJPTTRs?=
 =?utf-8?B?M3NZUXhrYTZMWHZOMXYrUUozaEhrNlBjM0dNUlJydEFVa1B1RzFIaU5tZUFs?=
 =?utf-8?B?ZU9YMmJCN3JSTWQrSFV3YXBqZ2dqQ2ZIZzJoWms1REdqanBYY3FNMTRSaVQ4?=
 =?utf-8?B?am43amtsbjlDVVlrNDBMaThvcEdiZGZFYmNXbmpoRGxiL2ZadzNtMk5QcUpm?=
 =?utf-8?B?MDl2dWM1dENjQ3FYQ3FuZ0tTbmk4dmFmWG05TTgzUVFhQUlTeXBldS80VFJQ?=
 =?utf-8?B?biswQ1dTelJHL29idmhzU2s1SzhpREVtQXZqOEtZc09pb3c4QmNwRjR3Zm1v?=
 =?utf-8?B?STJtK2ttSEl6bWlycXpzTUdpYkQxY00xajIwMFg0am1uOWNYbEVXa3VIQjlP?=
 =?utf-8?B?RTNMYy9pRXFjS0F5c2ZjbXRrSktrc255OU8zMkZ2UElaVzVJVHdWRmtLbjFB?=
 =?utf-8?B?eDdNOHIxS1AvckMyODhNcmRvNS9lem1PczJRb2pRcXlvZFc4d1lPVS9PR0NH?=
 =?utf-8?B?TnBPWHVYNW5KcVdnR00ra2ZvVG5qMDdwS0dXcFRaVDJPQ3hFY213N0N2Ri9t?=
 =?utf-8?B?bDArbi9PMC9qQklxRVFlQytreEJvVE0vdFFaUnBodU41dG1aTEtrTjIyckZE?=
 =?utf-8?B?NEs5VzVZYzY3ZVAzMC8yRlV4UkQwZmViUUFvbXJ1bmhXOW02bUh3M2F2Y2lj?=
 =?utf-8?B?cTA3Y3JnTDJLMEhpWENDUk5QUkJwNjZJZld6aHVWMVd0WU5ld29GOVZCdm1Y?=
 =?utf-8?B?KzFEZ2ZmUlRaeHNBTkJPcWdzWkx5eDRZUGhyQ3VDbE01RCsrQVNzbjdwMEVm?=
 =?utf-8?B?akxnMHYzWW9QSzduL0MwckU2aC9MRkFZOGpXUUNhOU9lSG1rUWhiREpBeXIy?=
 =?utf-8?B?TkNBVkMraUtaWXhtOFlya2F0cm01YS9YMDlQM1lnV2JUN1ErT3VxaVhBc3lV?=
 =?utf-8?B?R3hkSXZIOE45TjBRNlpXb1I5dEMwRk90a0ppWDIzRjhpREk5SUZ2ZEdJdDdr?=
 =?utf-8?B?QUdXdEFVRXlmQ3ZaM05BSHhqYlhGMnNicjkyVDZxS2wyYUdKRnRhZTBWajZu?=
 =?utf-8?B?Y1N0aGxqcjlTYjQrRXhUWHRWT2RmNnFkRkkydFlhK1RXVUFvalVobmxIVklU?=
 =?utf-8?B?blNxdFQ4WGMrWmJoWk5jZnh5ejlYcHdRVUpBVXlScVVpS0dYZlpOa2Flb2h0?=
 =?utf-8?B?d2Z1NlU5bU8rZHdvYlM0VFUrdTVub2NLVHR4bitTR3JYQkcwZVpQekhLUDg4?=
 =?utf-8?B?dWNhZEFySTRCT1lnNjZubzNvaGpxcXFoeU9RZG40OVFqWXRpN2YzcFRqMEc3?=
 =?utf-8?B?QU1GdjE4VUdwR3RrZmwvU3ZOV3NQRDI5b2s0YzU2RmV0S2orN2ltM1dPNmU2?=
 =?utf-8?B?K2J1OXlGc0JGYkEvVjZXWXRobmhSMEdNVXBQNlVhUmxNVHdDbTNwdzRrT1dS?=
 =?utf-8?B?YTNxcFlGTzZMNHQ4R3diVVQ4bndNWTE1dFoyaFBJdFNoL1R4OXM0dUVEbjB2?=
 =?utf-8?B?akFxbXdjWnRDMTJORFNRd09zeE5mVzFZZTFpRjRqV3dTaDhraC9KQS94U05T?=
 =?utf-8?B?Y3pucldFVFNxV3dZVmFkSWlrN2pNTlNIa2RXcVJQYkpEVUNmSTlTSURzMWcz?=
 =?utf-8?B?c1VwdzdNQUwwWHJ3MzFrYklyN09vTFJQdDVVVE9oZTB2UjJ2T3hjYkpMNjVD?=
 =?utf-8?B?V0wrZ0lwUXJEYmhnMkJLVlRaTThiaDcra0N0aXJud3JEUzJ0b1d3Q1ZOelFt?=
 =?utf-8?B?bC9oeDI2MWd4aStkRUZtSlpJMjF5dU9leDVKQ3BuVGpwSzdIWkpPbTlvQUd5?=
 =?utf-8?B?RGtseDRpOEVOdWxMMnhTK2xYMVFzekhsK3N1VXZ1dUZUV3dzR05UYkJ5bEhr?=
 =?utf-8?Q?nf2XmPRhc/cGMJt2pz8SHPkl5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b4497d-fb1e-4f1d-9e67-08ddaa54b8a7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 08:31:41.1158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdwyoPgcZou3GOfKxnD9oS3BZg0JGN5YnhXwlXbsMBFpm4+04AWOO/8LLCLe02qe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
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



On 6/12/25 20:11, Tom Rini wrote:
> As part of the recent cleanup of dt-bindigns header files we did not
> remove our copy of dt-bindings/clock/xlnx-zynqmp-clk.h at the time. This
> is because the difference between ours and current upstream is that
> current upstream has a #warning to not use it and to instead use
> xlnx-zynqmp-clk.h. So we change zynqmp-clk-ccf.dtsi to use the other
> and upstream-only file and then delete our dt-bindings file.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Michal Simek <michal.simek@amd.com>
> ---
>   arch/arm/dts/zynqmp-clk-ccf.dtsi            |   2 +-
>   include/dt-bindings/clock/xlnx-zynqmp-clk.h | 126 --------------------
>   2 files changed, 1 insertion(+), 127 deletions(-)
>   delete mode 100644 include/dt-bindings/clock/xlnx-zynqmp-clk.h
> 

Tested-by: Michal Simek <michal.simek@amd.com>

I expect you will take this patch via your tree. If not, please let me know.

Thanks,
Michal


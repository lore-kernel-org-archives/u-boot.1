Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BD6EA3F2A
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 09:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C96B8341A;
	Tue, 10 Feb 2026 10:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eXeHrk/J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3616B8388D; Tue, 10 Feb 2026 10:51:25 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FB8C8309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 10:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgIXWDcMRrIzqI/J8uExW/pV6cPFOlQRdZakSotxPmNleBJVfejscfl6xrM0nY0xt6jxyFoZOsU5YtzaABmh9nJe1oNxQF6G5GDzl0HoOULkxKQoAzh7NFqDa6PWE8WH4mxZkISMlmHqnKvicAGcHBBCnc9x1DihExXP+ZzRq3mDclEmw2W6T3nwyPHjFSVgGULcnr1ao1u0yGKZYMVpFPBS6V8XbHy5fsHeUi/wzjzkrdhq3QlTHCwAAc4dKS5xvLD3mMCXL2Fhik1CoqCF/5ntcPthD6vFaNu+PBKUqhAFxvRPwhsXXvBy8e6eda+29/6KUMv6Otar2ewohdjMPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQuKL9QGz/WsIsDzLE9v2gFipU7WiCC27C3CfXNwE54=;
 b=jQ10+rDVCCfi4FidwpmoEpehBEowWBajbZ6UgoaLLu4xNpk3P1sFVYxsdy1tWYIgxpiakwZOXpiaU3yVXrjpqg+k0utEF3d6sKyHxFjJ4HhEODaIe9fhdh4wox9niXA4mKsqi6nVpNy7q6oJLF7jTmUDkJkTo7ZDMWNn7lreYTf4ApvGoJjqMIHdDLHVXaOe1zC10hCQWG08+xFZtikq5wLY7//fuBjB8gb7YWeJ4jWVPUR7vWUEBBM+zN3PfOKhfynU3JhWXaOE73/Qear7p5u7hq5KrerYXOzExUrNhc6zli5FDtJFRWnuhVCWRrNKCNTXDcrXQlQ3c33DWfYlBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQuKL9QGz/WsIsDzLE9v2gFipU7WiCC27C3CfXNwE54=;
 b=eXeHrk/JZoLb2lV+crlFCNJDHgt2zREC/3xERIVd2WbtLr4LcKCGr2vu3mTIbm6xWLlJjLfUNk6X6X25ebOnmadO9Ped3HFomfZi2PkHRmwBfwBULHza6QSI6C4WEvN+/XAtqlb6ac8Uy7+T3hYt66iJiljNHPLQAjVQgDDUcvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by PH0PR12MB5606.namprd12.prod.outlook.com (2603:10b6:510:141::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:51:18 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9587.016; Tue, 10 Feb 2026
 09:51:17 +0000
Message-ID: <43354441-515a-4f29-9bd7-623f6c9da21f@amd.com>
Date: Tue, 10 Feb 2026 10:51:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence_qspi: reset OSPI controller
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, jagan@amarulasolutions.com
References: <20260128193819.1177944-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260128193819.1177944-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0176.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::33) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|PH0PR12MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: c10ff413-340a-4626-e822-08de6889ef67
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dU13dVVURjE0MVBPeGpyR3ZES0FzM091NzV5N3V5aERHYituUGN6bGJ3a2NN?=
 =?utf-8?B?VStscUk4dWhVd0hFcHVhSFhzcHZoSGp4RDdPdDY3anpYdmd6YUJ3dzJjT3pM?=
 =?utf-8?B?V2pCTE1sVW4wMzFZNDJSQ3J2ZDI5eHpibDlmZGtqNllQTUVNUGZmQU00SHU5?=
 =?utf-8?B?S1RjRktpakQzOEN1d1lDTElObkQxYUZBaWVkKzdiaGZmNTEyZEdmQjhmZmFE?=
 =?utf-8?B?WDdhWDA4WU81QkFqYXVuTm5hS1RCZUp2bVIxNlFvbTFWWDZORW4wWUd0OTNh?=
 =?utf-8?B?LytnVDRFS1FManJZTTZ3VUt0SEZiQUhFbW9MTWVHdHZ2RldwVUZvNExTYVls?=
 =?utf-8?B?VWJta1FZdnpKR01vWnlHWEJQMndKN0lydlZ4b0lYemRoWEw3eDNkOUliRmR2?=
 =?utf-8?B?UjNkemRyZXpXMXhxYlo3RFpuRFR5WmxmaVNiRFR2WWl0VnhPN3ZOUUROVXdQ?=
 =?utf-8?B?dFVYQjZHeEh5cCszMUhhM3M1NFhCcmJINWQ0ZnJsNTl5YnFvTlFDTHQ2b0oy?=
 =?utf-8?B?OVFmaWQrQWdURGFrVHVQM2YvQlBrc0w1anhGekRyazB1Z08reUN5VVgwZStZ?=
 =?utf-8?B?QklZam8yYnkxSi9MVFJ5d0VZZHROTDd1UTcrWmovd3BVSGtaeWtlenVBb2Jq?=
 =?utf-8?B?Y2Q1T1pXdFY3bWRlUVUyclFZYmJJellDWVcveEpZb0d0SExYbnA5cW5MbHkw?=
 =?utf-8?B?ZUF2dUVGLy9MTHNOWTdTaWthRXpVdHR2QUhLdEtHSExZdkwzTXp2c2pKY05m?=
 =?utf-8?B?a05lOFUrVlhHanEwSHpMRWRjbGxtUzdzcmV1ZjhNOTFsd0JqT2VoZXVYU0c0?=
 =?utf-8?B?ZTRrRkFKTTUxUW1RSTdwSXBFOGVZWXN2MEZiZUFJQWUwY0trVFVaQWJoOEVq?=
 =?utf-8?B?TGcyQWNhMm1qTFZnc3VkdExoRFVGV0ZIYVltcTg0MEZjZDZPTGVOa2dRdk11?=
 =?utf-8?B?UmVaMldmbUFRbmI2YWhuK0h0dHV3anNwa3EwMkFkVGsrTDhPVWJJUjJtRG9G?=
 =?utf-8?B?QTcwRDRaOXpnZ3VOQXM0TEkxa0VoeWdSS3Jrd2x6THFUMzh5eEUydTVVRTJk?=
 =?utf-8?B?NGVoV1pWU0p6TndPYzZXaDZXemJlTVdnU0NraTNMaWFHd3MrbXpGUFRtK3Nn?=
 =?utf-8?B?VW1qODZ3cFBFNHNvbUw3UWtFOVpORVl6UCtaTDIrNktybTBSazJMcFFqcnVK?=
 =?utf-8?B?US9BUmwzZ052bm50Tm9tTy9EQjFMUFJRZDNKaERmcW1CcUlXZWFRQ3RONjlN?=
 =?utf-8?B?Z0o5eFR6Nlg2T2NFRU53YnJQUlpOQ0lxYzJ1ZWZFK1Qyd2UrbUhoR1dNMHpD?=
 =?utf-8?B?WmNRSXNlUk9NaXZDRjJZdVhCdlNsTnZuVGx4V0JibGNUVld4TXk5RUlTMk4w?=
 =?utf-8?B?NDNNLzQ5alhDSjNVS3pZU0xKU0RyRkZ5Vm82cDFFc2MwSE9ia1lMclZ2L1k5?=
 =?utf-8?B?VEpoK0tzWFdhaHhDakthVE0ycHdkWG1qVXZGRE9TZnd6SUxhRzhMOXRucjdY?=
 =?utf-8?B?U2tmZDlTS28vS1NnQS9ITWhWdEN1YkswMDVhbHNIa2lzc05yZ1loa05wRUhY?=
 =?utf-8?B?SkQ0RTlPRis2cnlnY1NwZHE1ckVYOElXaVppaFEwNm9QRTEzOVc5T29VRjZY?=
 =?utf-8?B?MThMUHRsZjZyam9aSGpmLzlra2VwVXgzMW9MNlFSaWJ1SlVyNFFUaDFCcVRt?=
 =?utf-8?B?ZEpxVU9MakFTU1d4K0p0TmdWcncraWtEOGVpMHJjaFFFUy82VUppblQ2cFcr?=
 =?utf-8?B?NmdjZEJkbjYwUm1jL3VrOURFb2lYM0U1NHVxUWlLM3d5V2VObDNuYUdhekh0?=
 =?utf-8?B?dlhpeVEyQWRRb09aZkdSekI4SXJpWjV1czVIK2NaZjhlWXREY3VhUTdyV2oy?=
 =?utf-8?B?TEU3TW5pSElTU2FDZHFOWUhoclBmMlBWckhkSGJLYnBkNTNtZFNpNHVRVlZ3?=
 =?utf-8?B?Ym1laGdyRGRzTWhHY1JuOS9Kb3hXSzhTZjdjV2pNcUtKUkRDd0kzQktvMU8r?=
 =?utf-8?B?U21oTVk1UDZBbCtNWXZhMkUwU2h3NnpZYnJWa05Zb0N5MU1qb3hjb21kV0da?=
 =?utf-8?B?NG9oNTBPdDNBR09YK1NxK2ZqR3V5Ty9hb2NPY0VsaThjbXdBaU5hS1B4NzdW?=
 =?utf-8?Q?2yp4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEVvbzdOaDB1SHR2Z25UNVdZa1o4TzNQYldyazlzRlNxSFhrZGZjSWJwNVdq?=
 =?utf-8?B?Z2R6R2hCK1N4K3dFVVMxYTRGc0xMNkVqbzJZeWRPVktJcGhzamJZRGpoNjhL?=
 =?utf-8?B?T0V1RU1FcHVtMXgveVZ2bCtsMFFwU3EyTVROckJZVGdVZHBQTUNTaFViaURB?=
 =?utf-8?B?RFM1WE1yWXNkaUltYlJLeWdFN1I2Q2ZsMCtYTHRZWE1NK3dYVmVDck1hcW9h?=
 =?utf-8?B?MTh5ZFE3aHlodU84dGdqSGhwUUNsWTRZRXN5SmpmaXBxdTZYcGRvNGpLTlFR?=
 =?utf-8?B?Y1ozeHkxOFNvUk5DcFVrMDduRkE3TDdCcmJKalVhSjVmQ05kZ29IaFE3SmNu?=
 =?utf-8?B?WmZRKzd0M3JyOFpmYllsYmc2OFFBb2pmVlJOZWJPN0QxamxzL3NUOUdYbktl?=
 =?utf-8?B?SkYwWkh4b0orRktOWVRRekJ5YThWbnF2VHkxMmU2YTQ1Zy90elZyM2g2VnUz?=
 =?utf-8?B?VUVzcVEwZVVXNlBmQ0hJSityNmhvTXZqTjkwSGwxd1A5Y1JueFVLLzAwNUZB?=
 =?utf-8?B?eExTMHZnb2N6aE1iTTBUS3NBQk9hNXEwU2RueGFCUTR5Mm1EdG04Yzh4NEVZ?=
 =?utf-8?B?R1IxcnFYYUM4MjlTZ2MyNzc0ZC9NRkpSS0J3V3hwaFJ4ZDB3VzA2OGsrMUJM?=
 =?utf-8?B?VWtnbS9kMXpqYm9sU2orUmM5NUw0QjJlM0JqUWVoZTAzWWZNdy9BcmlneEFi?=
 =?utf-8?B?YjNncUpBc0lwQUsydDd0N2JPZXlCcW8zVmpCWVJGK0IyTEhDSW1ZRWVzT2dr?=
 =?utf-8?B?NGk1cFVoVjkzQTRQbC9qcDlzVHB5TGk5bVhPNEV0a0p0UjVTTStXUXhxdkg0?=
 =?utf-8?B?VlVjaUNJemZQRnp1THBTaUpQcGhMMnQ5K1ZtQ3ZCOHdaWGpNZGZNVUVKbkdV?=
 =?utf-8?B?RE9FZ2YwYmJPbmhBejRsZWw1amMwVVZINGl5cjVhclA2WGthalBsSEJWd010?=
 =?utf-8?B?LzJ6UXdEZEdNTWdZN3FBSm1YMGNUSnNzeStFRUdqc0lOaVhCbXIzWFF0UVZ2?=
 =?utf-8?B?TzFnQnpPTjBTS2hVNG94c0o4bWxRQUZpRDhyMGp1VURWaFgyazdBb3dkYnAz?=
 =?utf-8?B?MTRCVnZLUmpZeDdOSnM3ZWJHdkR2OVBBeExzalJhOHlPN2dkeWRpYjB2M1Z2?=
 =?utf-8?B?SHEzcXVETTh3Z0djcldMQ0tpQkhoYi9CZGhBUGZtSjEwZ2RPMFVSUWVLQWlT?=
 =?utf-8?B?eHlPNTY0U3RkZkIzK1BtSFBuaGpRRXM1MjhNNE5ZMGFuYUpLY242VFB5eTVN?=
 =?utf-8?B?YU1xUnlZbGFLeVlnbjBMMnBhNkRHcktrY2N4YWJhell2YTRqcFY2TStMaFJR?=
 =?utf-8?B?YVZHTHlod3N5bUlFa3l2T0d4QktEdlpxcUVzb3UzWFlhQTM2M1JiOWtqKzNp?=
 =?utf-8?B?M0RFWFhGekhqTVNxbXpkeGhLcFdaUTZ4bmxLR3lESXp0M1diMlBZMGxLZk1I?=
 =?utf-8?B?K2JBWElXbkZGWkRha2ZhSCtqUWJTYm1qRXhDblNFSkg1TndtUXVxQmtYMm5o?=
 =?utf-8?B?RHNMNWM4UWZLOGY5MFhQb3FNbWdOTEhKVllhcHFSQzRXU0gvQWllQTNQT3Ny?=
 =?utf-8?B?MWtmTDlzYnJCVzVZNWMrVUsxV0NNMS9kRVFGVHROUnNqTUlJZTFwS3krbW1G?=
 =?utf-8?B?cWRQVGgvMDFBUzQxNm1md3ErQVYvemRGNU1ZVm54eENxOFR0ZUVzeFl5ZCt6?=
 =?utf-8?B?N2lqSnVCYW5DTG5kUm1xUi80LzJFY2xZbW9WNHhrMTc1ekpnREh4MUVUTkh0?=
 =?utf-8?B?TFRnUXh6ZC9mS3o0S01hSjhMbldOS09IcVBCZXV1ZitYempQVktCVHg4R21w?=
 =?utf-8?B?di80VkxwK3UxYWFBUFJ2amt6aFl4U1VqdExRZmpFb0NuL1RWZkpLdFdPdHdL?=
 =?utf-8?B?MUwwT3IwWURzaEQ5UXE2MUhDVk9DWHdIeUF4eFJJQncwNnFrOElKcnY5cTR3?=
 =?utf-8?B?akFkRVRxbzk4Tk9wZzk0K1NTbWp4QStKK0swV1llWDZXT3Q3VzFFKzhrbXBR?=
 =?utf-8?B?MjdDR1pxSWNGdzlRYlJTQTU5R1B6aldBN0VQTTNjREZiN0VRMkd6WW04bVhT?=
 =?utf-8?B?UWRlR0o1QnpQOThYM3ArUm5mVGNXUEJ1OHRtUUVBaUZBWk5HLzRqc3ZrdUFi?=
 =?utf-8?B?UUp4UjAyWUZOT2owRURHTWNXUHkyTGhaNXpxVkhLUlMyMGFCMkZZZU1wWDVh?=
 =?utf-8?B?OFBXSmIyNHh6OERoQVUrK3BXNkMxU2Z2eFpwUzUvWVVKcUMwTUh1aVBsd3VB?=
 =?utf-8?B?ZFgxYkgyU0tucEEzUy9vMWtUZHF4dEdVNUJBUWVSVlA5dEkwMkJ3ZW9INnE4?=
 =?utf-8?B?UXQwMXptT1V0aVdTTWVKNzViWER1Z1d3SlVBMEdJcHdFZ2pqWlkwUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10ff413-340a-4626-e822-08de6889ef67
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 09:51:17.5486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuOwNwGPqL4eKElSZna/74aMDm4uEASUEVOLNK6pUKNb+OPYRlna/KxXQ0Qw0Dit
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5606
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



On 1/28/26 20:38, Padmarao Begari wrote:
> During probe, toggle the OSPI controller reset if
> CONFIG_ZYNQMP_FIRMWARE is enabled to guarantee the block starts
> from a clean state. Add the small delay and error handling
> around reset assert/deassert. This ensures the OSPI controller
> is reliably reset during probe on AMD FPGA platforms.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   drivers/spi/cadence_qspi.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
> index d1404e13810..a29acf75abd 100644
> --- a/drivers/spi/cadence_qspi.c
> +++ b/drivers/spi/cadence_qspi.c
> @@ -13,6 +13,7 @@
>   #include <spi.h>
>   #include <spi-mem.h>
>   #include <dm/device_compat.h>
> +#include <linux/delay.h>
>   #include <linux/err.h>
>   #include <linux/errno.h>
>   #include <linux/io.h>
> @@ -257,6 +258,24 @@ static int cadence_spi_probe(struct udevice *bus)
>   	if (priv->resets)
>   		reset_deassert_bulk(priv->resets);
>   
> +	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE) && priv->resets) {
> +		/* Assert ospi controller */
> +		ret = reset_assert(priv->resets->resets);
> +		if (ret) {
> +			dev_err(bus, "Failed to assert OSPI reset: %d\n", ret);
> +			return ret;
> +		}
> +
> +		udelay(10);
> +
> +		/* Deassert ospi controller */
> +		ret = reset_deassert(priv->resets->resets);
> +		if (ret) {
> +			dev_err(bus, "Failed to deassert OSPI reset: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>   	if (!priv->qspi_is_init) {
>   		cadence_qspi_apb_controller_init(priv);
>   		priv->qspi_is_init = 1;


Isn't this cover by this code already?
         priv->resets = devm_reset_bulk_get_optional(bus);
         if (priv->resets)
                 reset_deassert_bulk(priv->resets);

If you need to call assert, delay and deassert than you should extend existing code.

Thanks,
Michal

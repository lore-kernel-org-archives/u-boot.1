Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E049CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 11:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2235683335;
	Wed,  1 Oct 2025 13:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k7Nd5ntR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CF378344E; Wed,  1 Oct 2025 13:20:59 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90BDC80107
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 13:20:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbGoL1pGEZX24EeLbDbVYOquLRPvhxpM6J5RMIyXDw0zW8emCilnBW9eKcH/aW5wEyNoLIdEdcYgmtpWRBe8XyYy4Uzz6q4DXLR0TSLzCZFsPbX5jKwKHTPCgD2Y+RBcDA2lqRyE5hEa9SsnR4xda2fg5otCciRoGiQDEd4anWYX8O/zKLv8JnAx4pbT9N6cm97Fivj7cEQfuYYU36Klx27UST8MWGaN1Civ2Mb8EEEpE/W82GB0nV1f7dmHGjv/ld7ohJl2K99QIGnD5Vinaimd88Q4XS84dVVpTuaCPvPHFS+LWoLzyunS/uUHJYe7W9iQDcEiqF/EXyJZ6qeccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46yklST89oCuQLp+1ar45qKgkMqHfWzCheu3LQAy0GM=;
 b=i/Mg9+M1NXowrJyvNCms/sCeQoVMlmFBW5GbDmMUcaFyCg1cx3VGlrWZ3wxV78TepOvjN5Ja6xXEG1Mp988jisr6JqoBgC+yxUqT8T1xeyWPbHvaKygGFasZb5+oQKrSf6QkHN10hX2fUxF1WpqQdGdI7w5prd+ywC3JSSrwpbZFUcdJaWLHt8c1RCGnIfr6PH6Bjhd9MfuOqnaCD2mitbqTiHiK6nYB1d23epEtq+2vuW3N7RZmvk9CSk9QIjgaIHccYkGBDIVrtCnC7IeGHoF2PaKF8AR0DjMd3jSSmDq6LaXUAqZKMRNEuD5X/1kbHKvm2D8b0oVLF5GcDCHuRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46yklST89oCuQLp+1ar45qKgkMqHfWzCheu3LQAy0GM=;
 b=k7Nd5ntRp3sP6VQEUR0sg8MIf4wKSYmkWjag5kkqtuwvvLUuvZzjHoh5zIOE8J7QajofypUjWJJ/gM9vG0atuE1NUcsTgcUfx6Xz6VrCXcmd8iOJ4vFMWhSIrEa3GsAo7S4Z5eLkq0kUAVhx/HtO2Rw6S+qt6+/gpSm27Hgs9+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 11:20:50 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9160.008; Wed, 1 Oct 2025
 11:20:49 +0000
Message-ID: <383f719d-b36c-49f4-bae5-52c27e312838@amd.com>
Date: Wed, 1 Oct 2025 13:20:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: onboard-hub: Make i2c-bus option
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de, git@amd.com, 
 fabrice.gasnier@foss.st.com, Marek Vasut <marex@denx.de>
Cc: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <8d5ce6f2bf23e1bed12f4929745b0189df8e2f3c.1759299606.git.michal.simek@amd.com>
 <d3fc747a-fa52-4370-919d-8a0a4df6f80f@mailbox.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <d3fc747a-fa52-4370-919d-8a0a4df6f80f@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0031.prod.exchangelabs.com (2603:10b6:a02:80::44)
 To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f0875b-21c9-4fe0-60c2-08de00dc9349
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZE1JUXNIcFF6Rkc4QjJxSEt6d2tGdmhIZGpGSWpvSFlkSDg5M3lXVUtjWVdo?=
 =?utf-8?B?WGJTY0VWM2pjTUVjMS93UWN3MnRPbFRWcjZ2aUZqNHdFUTZIL0dNMkZ5UE93?=
 =?utf-8?B?NThheGRET29KdVRteXB0ZVg4ZDY1NjZ1L0VRNEJadndBLzB0WXZudC83dVNK?=
 =?utf-8?B?Ui80YUkzZW5uODJpY3JHNHVaVUVpb2d0enZueUR0VU1jU1Q4d3FnVTN1WFo4?=
 =?utf-8?B?MzNmdzlkTlRZSXVJVTY2VFpBeFVUcGhseUxEZnVMSjE5VmpHV0Vla2V5dGNV?=
 =?utf-8?B?eXdUTHhJazdwbHZrWk5iNmVkdzMvd3UvVlU2OHVvYXFhN3pLNVh4YkczNGNh?=
 =?utf-8?B?bWlibTBIdnlyUUNTNDF3YU1PYyt0TTJ1U3daNmpBdXhYTHFzeFFQbWhoaXZw?=
 =?utf-8?B?eDJkc2NGaGVORWNDRWo2TnEzS2ZValVUc2QwTXlCU3h2TnhqS3hVOXFJSlow?=
 =?utf-8?B?MXhxbGRMZUpacVY2eVlKSUwwb2VkNFBwRFpOYys5WEtXTGlyYkhGNVdEQzNj?=
 =?utf-8?B?aWxDVENEUlZ0anNRQnF0d0JDRkhlSDhZZG5ZbFJjdXlrNlBxMjA2WllBZklW?=
 =?utf-8?B?eXU2WlVYRkNzc1lCZTA1dnI1Q1NPY2R2MnNxMnpBSnFQSTYvZjF0bWlMOG0z?=
 =?utf-8?B?MythVFhFTndWdi85K0k5bisyNEFtK3BMOStxK0owWkRrOUJ0SHhLM0xadDFK?=
 =?utf-8?B?RHRaRHNZSU11UCtrQVhwZ3BCTzhUTGpaY1R5VlgwQWhZeWNFcDRPbzIxQUt1?=
 =?utf-8?B?c0tNN1JacU5zcXdUUlpkNEdSendsaVJJeEluZnJPek5SYzJqaUdEaXpDOEhC?=
 =?utf-8?B?dVBnSkZ6OENmMWFSS2R1cWFzZTR0b1oyZGZndTR1TFNhNUJmVTNXa2s2dUw2?=
 =?utf-8?B?dURUYTVpN2JjVEx1QnY4RHdGUm9hejUvb0N1QzY3dTcwSXk1ODhqUlQ5MmxC?=
 =?utf-8?B?QXhockVrVGJtb2lJTnJJM043elZkRHo0TW42K0JSVG55TUpQV0ZmVkRjM0Qy?=
 =?utf-8?B?VVpxTnpZdnN4RTl2UEs5RnljL3RzbUZxajQ1bnRITzR6Q2IyL0p3RzJ4WENJ?=
 =?utf-8?B?dGFaSm1nb0o3S3JZUVVEc1B2TDd4WDEyZjltWCtlT2QyaGF4S3EvVmtTM2xs?=
 =?utf-8?B?NnNJcUxxbmZDaDkxVjV5N0pQUVhzMkZSTkdFaTRqSjRYaC9kVmo0a2ZNZkoz?=
 =?utf-8?B?cGVGT3BkQ2VGQTlGNEFiZ2pUTkdycy90aHlwWVVxREhFZ1F2VHhIT05zL2pH?=
 =?utf-8?B?cVF1eDZuS0R4STlGZ0VtMUV6S1oySUJOQWp0SHlld3N1Ny9Bc0dSSVV0dzQy?=
 =?utf-8?B?UE9JQ1ZhSmVvaEhKRUoyREE4Y2prUExQN2hCSk43NVhWTjBxZG1jKzBHVitE?=
 =?utf-8?B?UDAxeUpiSklkQTRIbmhNSk9lc1JEczlod3dYZ0M0R25qTHQzNTI3aFo5T2li?=
 =?utf-8?B?NE5vUEZySHFHaWVOU0pDcHA4T2ZEcFRFcEZvSEVadGFmTkJCQzBkdXR2UTJZ?=
 =?utf-8?B?T0dpZ0xLVmEzMEVGbjZ5czluYUpBZGU5M0JGY2VVVC8rNXVFV0JDUG9OWSti?=
 =?utf-8?B?cC9vQU1lTzJaemxzdVFkSjExNE12U0MzOE8wOWN0NVRuRlArRDZ1N2FKU1I5?=
 =?utf-8?B?SVltZFZ4MWIrYlhaWEFzQ1I3VGdaclQ4UUY1ZXU3bUwzT1Y2SGh1MHQxUnRG?=
 =?utf-8?B?MjBEbkFERnlud2l5bThxcEZUL0VTTWF4NTk0NERCSFcxN3QvYUREaXdqb0Mw?=
 =?utf-8?B?TXhWZmN6SEtvUUVPR0k3Z0pNa0FOdTdvcHY4YzdQdG1QSFoxOG1PRE5OaFND?=
 =?utf-8?B?NmlESXA0TUt5TkpyUHlvVnU1TWR1VkNFdUg5eFJsUFpXVXorZXlYeGZGcjlZ?=
 =?utf-8?B?NHNaZkdsSUE3ZGVSR0p1UVZISzdmVW00L3Z1ZUJla1VqQzFVK2RlakJ6ZDdC?=
 =?utf-8?Q?aJV8ttHGCuCb9iSExGsm+4MaxUJ5crEF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUlZb0c1NGRQVEZJSGlPTThJd1ZORDBNKzFxZCtycGdoWVRCbitnOHYweTdQ?=
 =?utf-8?B?MWxhRVRqZTEyRzVDeWpSK25lL1RNUzdIQ3Z3SVZDS2VnZXVibDBKZVMvRFgr?=
 =?utf-8?B?ZE0vNHlaWFhqbnByME0rQ1Y1WFIwZ011cXlLcTE4U1pIcVlPUjMxcENTZzRF?=
 =?utf-8?B?WSt3c1BpaitkVjhkMkxpMGhxQ09YN1ppdTNDOXltbURKQUhDTm1uQ1VvZEh6?=
 =?utf-8?B?VE50NEYvWU1ZV2NmMnQxelFLYkhRWFFiaCtKeG1QRGk5UjJUZjN0OGZ1WC9K?=
 =?utf-8?B?NHErZFBXUzA2RDVCSFBUVERjM1NEakpDNE1LYmVNQXNsMnQ1Z0NMbGxyWWww?=
 =?utf-8?B?MkdJeG84U3lndmFibFdQOVhzWGRQWVlQUjlVZXRpc2YvZVFSTFhrWnBZZGp5?=
 =?utf-8?B?TUFBODl1bUJranhpNHVaWnJGMDMyQUJlV2MvU1pKa3J1VUtESkNVUFJ6bzdF?=
 =?utf-8?B?dFpXSHR0aUMyS3FhQlArdEptN1BLTHpMaHI2c2FFOFpHMU1aSUhjQUwwTU9q?=
 =?utf-8?B?VkRVOTkwazY3b3R1VDNnd3ExeEZHRDg3QWhrWlJXalFXL0xVaG85V2xNZEwx?=
 =?utf-8?B?SElpeVlmZVVLdWRUbGtjR0wveDErc0xjVXk4S0FjWVZZNnFxNExxSmdBZk9a?=
 =?utf-8?B?NE9WcnNxMmk1dnBHamdsZkFhSXIrS2g1NGRFNWZTemFOYWNGS0paNDhESVZO?=
 =?utf-8?B?dXN3UkJVeGRjTW92VjZlZWR6dUdiVTRwUDNoQnFYL05HSnZrZ3YxeFVqL1FU?=
 =?utf-8?B?ZTdDeTJxL3BHc1U5UWdlOHZPMEN3WGxyV29sOVhROHlXMDY3QTBVeWp4RUhU?=
 =?utf-8?B?dytaVFc3alhDbXVDd3hPT0F0cVV5RUdNemlPLzZnTGc2WHFEREJOekZIbEkr?=
 =?utf-8?B?NDhKc29UME1hSm1uWmR2WHlPMXhGaHdBZlFMSlozMXl6djNzT01oVmh3bGNy?=
 =?utf-8?B?bm16K3hGd0EzYzhEL0pMaEVQaE5sd2ljR2xLcG9vUkd3Nm5NbWIyOVRpbkc2?=
 =?utf-8?B?WkFibHJWUnVXd1Fqd1JodTdvUGUwUlBLbGFESjZNajdDWlVXdVRVa3JXSzho?=
 =?utf-8?B?SEU5dGV4aXNaUDMvS01TYlJaWHg2THFSWlA4aitmS0ZhZk1sY2FseklFN0NQ?=
 =?utf-8?B?OUcrRUJIVHdGK2J5d3BSTHlvNDdlbjl5Z21sOGxWTEFuOEhZTFptakQ2QXEy?=
 =?utf-8?B?UTFFYWVrdFhWWkRGcXZlc2FudWRybmozdndlN2pCY3RYa0ZBV1hBTnJRSFo3?=
 =?utf-8?B?dytJajhYRDNnS3UyNVRGYlY1N0R2cUVzTkVHckQ0VEFndEFZQ2dyanFJOHQv?=
 =?utf-8?B?SVRaT0F2QXRBUDlheGg0ZlAvWTFBNkk4ckpzT1NobDFEM3lUaE5nUmUvYmdm?=
 =?utf-8?B?NytKSlFVVVNreVpGbzhhdm41MDJ4SmJpbUNTUmg1a2RFcmlkSGRVWE84ZGZx?=
 =?utf-8?B?aEMyQURqVE5lVjNDeW95dEx2bHlDRDhmRkdlM1Y4TDdPallSWkM2d3BQa1NH?=
 =?utf-8?B?MTFzcDVySi84SG1zQVBOM3hiZGtOTGxuM09JUEFmaXM4V1FEN3IrMFU3aDhV?=
 =?utf-8?B?Z0lxd0pweWVwRXg3MlJRQlErV3VOc0tHYTVKVE1wMHRQY3hoemw4eGRFMC9s?=
 =?utf-8?B?eDhGRmhjS1FJeTBRU3FsOXB5WEFqTDlaN2x5OEVKK1NtYXJsbVQ1VVN0VnZY?=
 =?utf-8?B?M0o2OVBCYUN4RWRieEhtajUrUHpXYnJPNXBRQ0hQNW5mSzU2cnpMYlZuSTds?=
 =?utf-8?B?YjFSYXA0UG9UYkxyQVRWWEhlUHVZWmdTSG5mVGdtemw0elZDMmh4STV4YnhJ?=
 =?utf-8?B?MjVnMHRwTnU5Szd4bXR6bTcwMjQ4WVBBSUFwUlNRVFhqKzFzOGxmSFZlcTRZ?=
 =?utf-8?B?TEtLR1JIR201ZUFEODZPNkhGajVOL2c1SDIxUTVVZGNEOXJ3eGNDMEUzZW9R?=
 =?utf-8?B?a1I4RWFFaUEvQmliVzFOUHJzMDBjQ0NEZENvaXVjM3BQY09xdVBhT3pPV3JY?=
 =?utf-8?B?OU9HeE1tSjVVbnhaZlNxYmQ3aDc1SnVSUk16MnB1OUlabmNFbDRFM3lacU5Q?=
 =?utf-8?B?SG9TZTRENTNKNUdPbzVJM0EvajR4UWN1QUFyRDdKSkdCbmxsMENuYjdJUGhx?=
 =?utf-8?Q?eJxZQfYA9/nHVjHwO/rQPnS28?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f0875b-21c9-4fe0-60c2-08de00dc9349
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 11:20:49.8635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tq1HKGYTtLqjCuUWQh0ZssiZhOSAkGLOOzRsjaTVBMVQjJ9a+pmpjBUd8TXQkPWZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853
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



On 10/1/25 13:16, Marek Vasut wrote:
> On 10/1/25 8:20 AM, Michal Simek wrote:
>> DT binding doesn't mandate i2c-bus as required property because hub itself
>> doesn't need to have i2c connected.
>> It can be in standalone mode that only power regulator and reset should be
>> handled.
>> Or hub should be configured via spi interface.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
>> ---
> usb: onboard-hub: Make i2c-bus option
> 
> ... optional ? I can fix while applying ?

yes, please do.

Thanks,
Michal

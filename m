Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F7ECA0ED3
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 08:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 956A588C9D;
	Wed,  4 Sep 2024 10:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ToFo7LdD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECE0888CA0; Wed,  4 Sep 2024 10:15:28 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B617288CAC
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 10:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpUsYNWJCY//vw/up41ckrLqENWv/nWQzTmI1hGWklpNaPI2O6N1EH+oANElx4G/k+P3DhZ8XipwOd07S1XmIRKoWeJ/IYHOIJt1nOwOA4fx31Oylj70+6QXn9C8S2+foKwJ401LL6JLPHVzTK7iVwKedT2vxuTZ3q3wFbjdI/6XTc1PUXLGwjA8yHysIwgjpKu1u+4mMV04cH1wyFHbb9BUJr1nzVZEMVJ6B8bgSCQmfQEPKbRIUD/yi5R1rdyOheGqNKBe4Zmybekqxzg+VrSGDfeX+anD+tC1j6tuPE0xn61deWetz73ASeCcscn7P/JRMkzQ6h+R0BnoBvHmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMNBuQmwoV2csHzJXBt4I7qiGRWs9PbE8MpljRtDpAg=;
 b=qf7WwYiSz8d+OuuN1FQPYpKBPe/JBwsQ0Tvfu/MrHqRK2D7j7oRaN3YaeQXWMk0qdFSYxmDKhEQtfeRnbeqRt0hgKms9C50ggBsGJKW0UJP2x7+GAjnQjUbhZLPUBvfNkHui0tfpXMqa2X9xJV3l7VQV6LTMUJQZu59uIMCQhAPxY2WfH6a38R5X00M8JIpnSTg5VHm6CA3cZXH4iM8xO0GGeX2QMXyn77h5hOtJXTiFhRKIB0U/1/VjHYk+J1BS/u98QAKSvXl4nB+0CGrOwS/mvrY0u1Ieppc62TEHzVDTnkSLANEtgtBgm4/adT4Ox7QoFuHY5+6BulgogrEFdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMNBuQmwoV2csHzJXBt4I7qiGRWs9PbE8MpljRtDpAg=;
 b=ToFo7LdDVV+V8mqsAjIPBhzBex8jf+wxE2GjjBb4LUEtudCHu8J+egyozfDlDKH6T81c0ouu1Msyt12W7oh84cUOzRgKEkRUutV+Zn/7v2zNC5EonZ5ZyD5s15FZ4yGz2r7Tnk9Oz8x5LuIeySLEEq/7hhj+SEsVi0qvpcgqO5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.24; Wed, 4 Sep 2024 08:15:23 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 08:15:22 +0000
Message-ID: <d3a2b1f8-0288-413c-a28f-ce2d1456607d@amd.com>
Date: Wed, 4 Sep 2024 10:15:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Miscellaneous FWU fixes
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240830114057.891069-1-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::34) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: e242862d-8382-48c1-854c-08dcccb9b8ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T01zWXlyZjNQc2ViN2xHUVdzSy91ZWs1VWFHcVduSnJCSzgvc2dCNWVEekJS?=
 =?utf-8?B?Ymkxalp1T05XemptMG9xa3hRYjVtWVk5dFNYazNUcGlNaklZb2NPMnNYOXNp?=
 =?utf-8?B?WE8yYjdlQ3ZZcTdHWVhyNzNmVitReU9SUHM3TUtaNXo1OXc5cWtVNVV6Qkhr?=
 =?utf-8?B?QjBDN0duT2UzMVVHZTVtdnVKRWJzT1ZnUXRNOGZ5a041bHM2ZmJYbk03SWVZ?=
 =?utf-8?B?d3dCZDEwL3NBbWtiNGpCbnhqaUtIRndwYmpoQU8rbFNoQzJkdjF4ek91V2pL?=
 =?utf-8?B?blJnTUNHTjY2dmR4dkE1OEYyRi9tenliVHQ5b3VhMWhQekE5SWIrUjBPMlV2?=
 =?utf-8?B?bTlrQUk4bGViUVhiK2wwdHh6ckpWV3M2S0tUSUY5Z2VpWFplSllRWlp0WXNZ?=
 =?utf-8?B?SDVyTTBXaHZ3NzVoRDE5anN6ZUNGcjF0bjZjMXFMMlpEdWpuUGtYT0lxQ3Zp?=
 =?utf-8?B?OFRhNkpCODNmS3ZJOUtYZUNpWXIvcitYUmgxS1Jya2RVeUNjN1RIOGFPWFNO?=
 =?utf-8?B?Y0ZNTEp1NU5aMDN3MzhIMjdtWGhLQjc5Y3RISE1LQU5uT0JrbHBuc0ZjUkx2?=
 =?utf-8?B?VWlhY09zUTRsRkxmVWdSck5DL0lQTklDUUVSMFFTWVNKbnhSNDJmbDE2T2Zy?=
 =?utf-8?B?bXFKczBTcXBCWXh1cTN1eU82S01WRlRhUUc3R1FaTDFleGY2MklCM2w2ZjNF?=
 =?utf-8?B?RDVXR3VzYXZIVW1LNVhCNitIZjdPYVBXVmQ3U1lNVGRFdVhWMHdyL05oRitZ?=
 =?utf-8?B?SXVqQVlDNElKcWpnZHR4a1Y0eXZTNFZtQ21XNW5hdUxHNmNXTjhaQUFpUTlu?=
 =?utf-8?B?aDFJN3Nzb2Z3dVNFcFg4cFhuMFhEWm1jL0thalhwNVR4c0NrYTNRVFdOc3ZT?=
 =?utf-8?B?T3duNXRGTWQ5YmxxTkR0cURpQUY5Rk4yK2hCL2dtNThEelZKdnQ3K2cxK0sw?=
 =?utf-8?B?VFdPV2U5aVIzWndkU1Y5SlRQVVdldGpyZDJoRndzaGtuUmhTVG81OGlKSGtE?=
 =?utf-8?B?aFZ6VTFERDhaSFlFbXU2OG9OdVlXbzhhcjVudnZTYkZQK2VEdE5kVmVYOGxn?=
 =?utf-8?B?R2ZIem93YWdGNTFMU3lRYzRuaFh4NlFMem5YdWVXdFZlR3ZyVjlUblI1ejF2?=
 =?utf-8?B?K0Q0UFpEQ1ZtWUFnL2VIWTNZWHoxcTBuc24rL2Z4Q0xCRFpBUmhlYU93dnJt?=
 =?utf-8?B?bVlYK1IxRVFNeFBpZzNxMG1ZRVA4YVhoMXFKWXRUa2ZWVU9KQmk2WHRZUkhB?=
 =?utf-8?B?R0t3d3FkV2hDYjB0VWxmNWdMWjQ4UDlmRVpPbWp6U0RyeXdrT3c5VEhFcUhQ?=
 =?utf-8?B?c2hvYTl6RkVBWlk4UHd0aWlYOW9rak4zOEdJM2xWYzNTOFNjbjNIcGhYQzdQ?=
 =?utf-8?B?K3RIUk1seE8rN0dScjgzTkZNM3M1T3RFOElJMXBEdENDR0hkT1EzS0Rlak9B?=
 =?utf-8?B?NUgvNWVFc2lobzRKUWxzYnllb2JXK1RUN3RjUjhjRlRXdHJmZXNYdlIvNGJh?=
 =?utf-8?B?NGlNVm1tRTYrQWY3cVFtSUpqTFJBemtVMlJoaXVOMUxXR0l4WFVLNWRES2RN?=
 =?utf-8?B?YXY3ZGJuN1phek14VEdEeGtCQ1BZakZlUW5xUGFSZ21NcGxIWkNMa1NremFu?=
 =?utf-8?B?STZYTjlkYlR1elcvOVp6aGg0M2JHY2wrelBvN1hNOCt6SmRLOWYyZ3EzTWVy?=
 =?utf-8?B?OTlsWUkzRHlTaFc1TzZhTjZxaklLZHgzQnVhZ0h6am5YbXd1YVQrL2lvcXZz?=
 =?utf-8?B?QjR0RCtrcGszdUZyWWdSYWk3VTJDNmNzWEs0OHBoSTJQQzF2L21IRVRkVExS?=
 =?utf-8?B?ZkZoWlBiWWc0VFM0bFVLUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmplMG1ieStOazhzcUE0L0llWXMrMW1xdzU0dHRrLzdzM1lWY25xZ21zUlgz?=
 =?utf-8?B?YVhkcm83U05DcVVZMVVweXduM1UxMVZIWE1SQjkxY1dveXNNWnM1M0MwU3Uz?=
 =?utf-8?B?cUQ3N3ZhanphaGJxd2lsOEV0MEpPVXNBNDZ3ODRYSzV6U0w4SytFMnV0TDgy?=
 =?utf-8?B?TE9uME80M0FaRUV2anhWa2tScmh4M0pyRUFzeHJGcVhuMUlFSCtjMG5hTWhv?=
 =?utf-8?B?UDNlck9BWnJSVkFON3RkOWlKMnR1S0pwNGRETmRObkRtdm9WdXBINmZKM0Y4?=
 =?utf-8?B?MGx3MFVZUU1NQW4wWC8xTlNRUklZSHJkajBrTk9CdnB3dnNBaUtSZHNMSlB4?=
 =?utf-8?B?ZCtIbGpBVUVpRzA5QUtVNmRQWllwbEk4aExtcHBkcXVSWWcydm9BZFI0eHdO?=
 =?utf-8?B?aFRVZW10am9JZHdIMDd0c2E0b0hkSVhWME5oc3FncU0yVGNpaTVUUFdoeFlM?=
 =?utf-8?B?aWtxUXRFeHpER3JBSWQ3R0ZMQVdUZVIwWlRnQStySFpFSXd0WXBpSU9lVnls?=
 =?utf-8?B?dVhQWU5KUFM2TGdsQmxqcnU1d0xzU0V5dXNYNGVwa3VFTVUyK2xVaDV4bm1l?=
 =?utf-8?B?Sk9WWWQwWUo2L1phMDNjVm9IR0lMUWVLMkxnZkJ3V2NwaFlGTzg0TFFla1ND?=
 =?utf-8?B?ODlqM3JaVjVsSHgxUlBoUWFLYTc5TUxMYXQxQmN6UUxHNkxUVFUvRFZqQkxv?=
 =?utf-8?B?M2JsUjd6ckhCK0xiY0Y5aVdkMGRMeWcxUDhoUjkwWFJCQlo2cTVoVDBRQk5K?=
 =?utf-8?B?MnRzUFZEV2o3cElVanZvR2RVSTk5bXJyQjB0dFpscWVTSldEcURzYUdzZll5?=
 =?utf-8?B?L3orWHFTb2t5c2ZrVzNpNGZpdkZhaS9heHA0MmF0S29yZDBGc0M5Z3N2NWxn?=
 =?utf-8?B?THN3bjB1c0oyWEw0SFVab0VFdDNOYWRFWllLWFEvSVVjZjVlb0RCMEFyNG0z?=
 =?utf-8?B?emRRWmc3bFN6M1kzdUJuMlNkNllLZ0hjWmx3OUNxQkljY01LWXk1Uy9ncFp1?=
 =?utf-8?B?WVdGdGlBL3J5d3BaeXE5L09NRi84NkFuUDRNbkdYQU1uSGR4amd4VTFPTFI2?=
 =?utf-8?B?dlF3MWtpWXc3QUs1bkdaMFVPSFZlNmJubFRoWE5ZNzBDWThwbXVUVDN1dkdE?=
 =?utf-8?B?c1dXdG5INlB3S29RN0tTdGdlaEdPdUZ1UXpvWTZyWWhJZzBxZmNFQnBnblB1?=
 =?utf-8?B?L1VVcnlxNlIxOTNRb3JsTWhmcmNFZVdKKzh1bzBaeVkrcXM0UnBjelVJN3li?=
 =?utf-8?B?Nk9lM3FXRnZZMkRRbEY0cjZRZHl1anpjRTgyZWprWmFDeC8rN2owdzN5a0ts?=
 =?utf-8?B?Z0hBeXY1VlloZEZUYjd3VGo5OXZiNHV6NXJMcmlxem44K0ZFcGFXUk85Mkdq?=
 =?utf-8?B?REN0eXZEQ3BWT2U3ZWo4bWJ4RTZIK1lsRkhqb0tjVk4vakRxMHg5YXQ0M2Fj?=
 =?utf-8?B?S0g5TmdnWHRZQXQwTm9GYy9rMUJHUkozSFJYQjhPMFd0NTdhMTRlNnpBcUZz?=
 =?utf-8?B?ZHZYa2tJMEJ2WjA3eHRjc00yNlNyVFkvanh0cXRmTDB2YkZIRUl1bytjSFBK?=
 =?utf-8?B?MnVKTlRkK0IwR0hPeDd3LzlYSHdibmVpbG4rbnB0QUszQzFoWm4vVlBoRGw2?=
 =?utf-8?B?c3JNRnBYSnJOMzcrS2FmRG1hUkRKYjlBRnpEcndhOEdybTdYd1BzYjc2RHls?=
 =?utf-8?B?N3lBV0VyQllKRk5PdW50VW9CWVQ1RHNFYTJtRDNPN0dzSkhKMytNTCtLbEMw?=
 =?utf-8?B?ZFVWWkplaHNsbHZZN1Q2STZkZG1pYitsS25sbEFDbUxJajRqcHBNY2pMU1cr?=
 =?utf-8?B?aVJHdWVqN29BUmQ1aXZqSFVNdmRnanpPMDFvY2RsOXhBUVR6d2U0SlB6S1NE?=
 =?utf-8?B?UjdEa252MmtVTGNhTTczKzhORy8yb1EyMW9MSThpbnpldGxHd3FrZVdmWjZq?=
 =?utf-8?B?c1c3V0diRm15clVsYy8rRG5aa09UUGt1Z296R3VnYXVzMjd6cU4wY1Y2Yjgz?=
 =?utf-8?B?Q0FLZ2ljL3lMTk1rclN4U3VVWVVtc3FVRjAxcUZScE1xTXBMYVVTQ2RiTy91?=
 =?utf-8?B?VEFOdWdkaVZTTlRnNkhhTERYcUFWaWw1UlJjUGZYc1Y0RjY4eHpBbCtjSURC?=
 =?utf-8?Q?E4rVs2VkqdPKbn0sQ3kxnSA+f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e242862d-8382-48c1-854c-08dcccb9b8ec
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 08:15:22.5664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fra9fyNbAbsdY3acKZIEUWqLAPGw+b4J18a0LeGhvDhc7WuIB66t6pVNyEqr+jb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
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



On 8/30/24 13:40, Sughosh Ganu wrote:
> 
> The following set of patches are miscellaneous fixes and some
> hardening of the FWU update logic.
> 
> Sughosh Ganu (6):
>    fwu: v2: perform some checks before reading metadata
>    fwu: v2: try reading both copies of metadata
>    fwu: v1: do a version check for the metadata
>    fwu: check all images for transitioning out of Trial State
>    fwu: add dependency checks for selecting FWU metadata version
>    fwu: do not allow capsule processing on exceeding Trial Counter
>      threshold
> 
>   include/fwu.h            | 11 ++++++
>   lib/fwu_updates/Kconfig  |  1 +
>   lib/fwu_updates/fwu.c    | 31 +++++++++++++++-
>   lib/fwu_updates/fwu_v1.c | 18 +++++++--
>   lib/fwu_updates/fwu_v2.c | 80 ++++++++++++++++++++++------------------
>   5 files changed, 99 insertions(+), 42 deletions(-)
> 

I think there is still issue with returning values.
Take a look at my log. I am in trial state - I accepted both images already 
that's why fwu has everything accepted. But I can still apply empty capsules 
which are passing.
1. if they are accepted status should be reflected and visible via fwu
2. if they are not accepted error from command should be returned.

Thanks,
Michal

ZynqMP> fwu
	FWU Metadata
crc32: 0x12fd554e
version: 0x2
size: 0xda
active_index: 0x0
previous_active_index: 0x1
bank_state[0]: 0xfc
bank_state[1]: 0xfc
bank_state[2]: 0xff
bank_state[3]: 0xff
	Image Info

Image Type Guid: DE6066E8-0256-4FAD-8238-E406E274C4CF
Location Guid: D7CE8A58-CE2C-11ED-81CD-D324E93AC223
Image Guid:  F64A0548-2CCE-ED11-8F66-7BC4531CFE6B
Image Acceptance: yes
Image Guid:  3E9C814B-2CCE-ED11-BEC8-23DE4C6D2CF2
Image Acceptance: yes

Image Type Guid: CF9ECFD4-938B-41C5-8551-1F883AB7DC18
Location Guid: D7CE8A58-CE2C-11ED-81CD-D324E93AC223
Image Guid:  52DA04FB-9D0E-EE11-A57F-637805837C3F
Image Acceptance: yes
Image Guid:  46926007-9E0E-EE11-A23A-A38980B779A1
Image Acceptance: yes
Custom fields covered by CRC 0x12
CUSTOM 00000000: 31 32 33 34 35 36 37 38 64 65 61 64 62 65 65 66  12345678deadbeef
CUSTOM 00000010: 0a 0b                                            ..
0xffd80050 = 0xb002c001
0xffd80054 = 0xb0020ff0
0xffd80058 = 0x1d000048
0xffd8005c = 0x0
ZynqMP>   tftpboot 0x100000 192.168.0.105:capsule1-revert.bin && efidebug 
capsule update -v 0x100000
Set rate id 48/125000000
Using ethernet@ff0e0000 device
TFTP from server 192.168.0.105; our IP address is 192.168.0.155
Filename 'capsule1-revert.bin'.
Load address: 0x100000
Loading: #
	 3.9 KiB/s
done
Bytes transferred = 28 (1c hex)
Capsule guid: acd58b4b-c0e8-475f-99b5-6b3f7e07aaf0
Capsule flags: 0x0
Capsule header size: 0x1c
Capsule image size: 0x1c
ZynqMP> echo $?
0
ZynqMP> fwu
	FWU Metadata
crc32: 0x4aef4913
version: 0x2
size: 0xda
active_index: 0x1
previous_active_index: 0x0
bank_state[0]: 0xfc
bank_state[1]: 0xfc
bank_state[2]: 0xff
bank_state[3]: 0xff
	Image Info

Image Type Guid: DE6066E8-0256-4FAD-8238-E406E274C4CF
Location Guid: D7CE8A58-CE2C-11ED-81CD-D324E93AC223
Image Guid:  F64A0548-2CCE-ED11-8F66-7BC4531CFE6B
Image Acceptance: yes
Image Guid:  3E9C814B-2CCE-ED11-BEC8-23DE4C6D2CF2
Image Acceptance: yes

Image Type Guid: CF9ECFD4-938B-41C5-8551-1F883AB7DC18
Location Guid: D7CE8A58-CE2C-11ED-81CD-D324E93AC223
Image Guid:  52DA04FB-9D0E-EE11-A57F-637805837C3F
Image Acceptance: yes
Image Guid:  46926007-9E0E-EE11-A23A-A38980B779A1
Image Acceptance: yes
Custom fields covered by CRC 0x12
CUSTOM 00000000: 31 32 33 34 35 36 37 38 64 65 61 64 62 65 65 66  12345678deadbeef
CUSTOM 00000010: 0a 0b                                            ..
0xffd80050 = 0xb002c001
0xffd80054 = 0xb0020ff0
0xffd80058 = 0x1d000048
0xffd8005c = 0x0
ZynqMP>   tftpboot 0x100000 192.168.0.105:capsule2-accept.bin && efidebug 
capsule update -v 0x100000
Set rate id 48/125000000
Using ethernet@ff0e0000 device
TFTP from server 192.168.0.105; our IP address is 192.168.0.155
Filename 'capsule2-accept.bin'.
Load address: 0x100000
Loading: #
	 5.9 KiB/s
done
Bytes transferred = 44 (2c hex)
Capsule guid: 0c996046-bcc0-4d04-85ec-e1fcedf1c6f8
Capsule flags: 0x0
Capsule header size: 0x1c
Capsule image size: 0x2c
ZynqMP> echo $?
0
ZynqMP> fwu
	FWU Metadata
crc32: 0x4aef4913
version: 0x2
size: 0xda
active_index: 0x1
previous_active_index: 0x0
bank_state[0]: 0xfc
bank_state[1]: 0xfc
bank_state[2]: 0xff
bank_state[3]: 0xff
	Image Info

Image Type Guid: DE6066E8-0256-4FAD-8238-E406E274C4CF
Location Guid: D7CE8A58-CE2C-11ED-81CD-D324E93AC223
Image Guid:  F64A0548-2CCE-ED11-8F66-7BC4531CFE6B
Image Acceptance: yes
Image Guid:  3E9C814B-2CCE-ED11-BEC8-23DE4C6D2CF2
Image Acceptance: yes

Image Type Guid: CF9ECFD4-938B-41C5-8551-1F883AB7DC18
Location Guid: D7CE8A58-CE2C-11ED-81CD-D324E93AC223
Image Guid:  52DA04FB-9D0E-EE11-A57F-637805837C3F
Image Acceptance: yes
Image Guid:  46926007-9E0E-EE11-A23A-A38980B779A1
Image Acceptance: yes
Custom fields covered by CRC 0x12
CUSTOM 00000000: 31 32 33 34 35 36 37 38 64 65 61 64 62 65 65 66  12345678deadbeef
CUSTOM 00000010: 0a 0b                                            ..
0xffd80050 = 0xb002c001
0xffd80054 = 0xb0020ff0
0xffd80058 = 0x1d000048
0xffd8005c = 0x0
ZynqMP>


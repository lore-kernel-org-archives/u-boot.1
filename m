Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23253C71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 08:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F05F82C30;
	Fri, 13 Jun 2025 10:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y/7uE1Kw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B839A82C44; Fri, 13 Jun 2025 10:00:06 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08B5882C2F
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 10:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECAVLON7Icls2ZxvP5Vdb0o/8j8fjMWLsN1Trl/fRFeM/FFRVmeLJ4JeL06yWmXDkDYmmBLXv3N6DpC14ilT248J7u5t4Tt2t2GHhZAjtx3sObNuOLwByd69e33PwBfaEPEda97gvC7/5HG3ZTfVzFyaWv8Xukr7bgi2PD3iNcS91Bq2t1zed8d1I4qDExRa+PTtvssx+qFKdER8cjEJvHUp0xB/VUSIo0YJIT7XJnCqTZzKWV9yS6Wa6Ngd8P5+pH5aI9F3c6wP8CT/O+qzgfZG69tFh8Dvl3d3l86Rk/qNQojxn7pnfS4D1NkRgCOCSRoYB/BgCA+7WYlJtmJlcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p102FfQm0ud8E7/n+vkvoAwgnbfnpwnV72iO7IfBKAk=;
 b=ViCFT5p8Uv4BrYE3QVUjuBPWjcuZ6p3RXGmsO6+oDW2eETbTCMr3QpcZa2qzZmGtF/gxEVynTM6m9mtClmGCN0WfCYCxSwd13tP2lpZB0/Hdab+L70jTSFZo9Gc0Myu9b1b7THC4KoDkhHN+Gnx2LdICoCOOXBh5f1T4RQT5i1BYi2nCh1ShhajfC/rcAvF7+WwWs1WmMtZw7YOHgBetbtyzQJ7fZpHocDEl3/jHoCxSrKEvEwt5GNwHKefYTOzOo/ZFeSCZvfoMTqpcRC8YsgzCLzbjCclrbfzrhka3eCz9f7BW6+meARCPND1tu/gv38IPN2syn0kF5v1QVmTFEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p102FfQm0ud8E7/n+vkvoAwgnbfnpwnV72iO7IfBKAk=;
 b=y/7uE1Kwxj4MGO42R6M4hbYulk5+UGxy/BcA25lQKV4P50Ksrgi3OLExAxwTvC/u7P5iam7UqOKIkFFpQ76fBFWTemS0Raj5N5eu4qo7tqg19vzHom6p8V/kEUP/AHGPh5BNHWooFTiJFvxQ0eWmNi5O9oCX2qlH94TWoKdoIHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Fri, 13 Jun
 2025 08:00:00 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 08:00:00 +0000
Message-ID: <eefb84b0-f995-446a-b885-8de9e0b2f295@amd.com>
Date: Fri, 13 Jun 2025 09:59:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tools: zynqmp: add build script and documentation for
 ZynqMP KV260
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Neal Frager <neal.frager@amd.com>
Cc: U-Boot mailing list <u-boot@lists.denx.de>
References: <20250612153311.2379944-1-jerome.forissier@linaro.org>
 <20250612164939.GO1382132@bill-the-cat>
 <b806f55f-da5a-4373-a6c2-15b1cab93da3@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <b806f55f-da5a-4373-a6c2-15b1cab93da3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0076.eurprd03.prod.outlook.com
 (2603:10a6:803:50::47) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: f248b5c4-8810-4bec-c951-08ddaa504bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzlZZ3VOL3dKbE41bDFxWWtsN2MwUUsrMm9wRnM2Y2hDaytCdVRYc3NZaTh6?=
 =?utf-8?B?aTFHQkVhTGNGVHBGeEVjUVpZMTVVL2xGRFZKMWRHemZVdzdOeUFmcUc4emh3?=
 =?utf-8?B?anZmblpWQ083aDNhbThlNlIvM1JVSXpyZURsWHF5MnVBU1JHMlBrN01xVGNo?=
 =?utf-8?B?VXJadGxqZWxRTEtaajl6YVpaSXZObmdZa3RkVTNHQ0VVMC9iMElsbVJQbGpE?=
 =?utf-8?B?UWZtTVZ3bzM4ZG0xWVBPK0VsbGtBVEdpSU9BZElQamQyVkpjRC84S1NEQlFR?=
 =?utf-8?B?VWRZbjN4bENzNVZpSWNGT0NiejJGL1RMNitkRStreVBHa3pWay95dy9Wcmg5?=
 =?utf-8?B?cjBRRjYvQnpSUnhGYlA5RXlCdStsT2pUUkNld3dkNjdaTWRlRk1CbzJzbnZa?=
 =?utf-8?B?SEtHc3habCs1UDF6Y1NEL3FTRlBqVVFkQUtEV3ZtYnExbVpxMFdYTE1DSWRy?=
 =?utf-8?B?dzVQTDRTMHpEV2lCbjlsdzNFQmVFSlpCOUd0SFF0eE5XWDd4UnNXV0pUM2or?=
 =?utf-8?B?SDNRT0tDUDBOQ2d3RmxlbmVaZ0NyNlVGM3hjNW5EY0tvUXhwVFh6aFYzMFpC?=
 =?utf-8?B?N2JUcy8ySEg5azhUelFMR2drNGxTQWtoTGtxNUo1MjRoSnk0ZDUzRVZhNUp0?=
 =?utf-8?B?Uno0RTZXaXZPKzFxeDQvOUxpSnFwek9CcStGdzFERWZxUXlmdE90N2JnMHdL?=
 =?utf-8?B?M0UrcWM4UEZaV2ZYNk1HaTlqS280cC8wUUVGaDU4N2JESmZDUEZCMHpXQTBP?=
 =?utf-8?B?TUwzMjlHOEc0bjhDNHloMi9BRnJpQm9pVnlRVE9yZU9jT0FjMkV0OFEyQlVx?=
 =?utf-8?B?bnUvNEJOWGovU1pZSzd1MTZscVM3ZC9rOXVZemlkZjluL1g3N0hCLzZYamJh?=
 =?utf-8?B?OWtpUHc5a0FxbGdRU1BiOTgxWmpWNjQyOEM3bFNMVWpYTHFWRmtiZ3JMMVlU?=
 =?utf-8?B?UC9TaXREdGZOUTcxRXgyeTdMeXQydFZ1eHdUSE04Z0FXQ3ZQYTNKUHVqdzVK?=
 =?utf-8?B?WkNlMStVR0RuTWlYZmlUVFFIZGQ3eHJ4SkNhY0hmUkVWV0lwamVCWitBaExi?=
 =?utf-8?B?a3Jod0N0UFlVMzFwei8yTU1CTUxOVmdETWgrRzFFeVNSbkZ6VTdPVlRVNStB?=
 =?utf-8?B?TlV5WWpGWm5obUlqRUxiMzJHcWJiNnhOamFIV3VSdEo5NWUxTHAvYjZLN1Jh?=
 =?utf-8?B?QlhlUDdsMjhGV0dvcjVXQTAvY2t6NTdGcndpVkx3VXI3RUh0MFpORGhvVEVF?=
 =?utf-8?B?ZkZTMjdQcVh0R2k0cGxjN3JyWTcyWWo2OS9lU2lPRy9tYSt6dXJBdjhjUVZs?=
 =?utf-8?B?MXZYRHdmQlhUVTBORzNDbUdXcnQ1b21TMHpJTjR3RWZxVnl5T0pvbllrVmcw?=
 =?utf-8?B?NUp5RFhTekdBalNhT2NmM0sxZWI2TVlZY3lwcm0vM0NOYVZ2Vk5XaWtzVmY1?=
 =?utf-8?B?ZUl1U1JSWk4vSjRsMnVpM0FHRWMwYVFHTmNkZ1V5ekhGNm1yUC82ZDY3dmhk?=
 =?utf-8?B?M2h3bHduMmhsa1N6M2pNZlhucWJ5U2RBN0hMZXpHSkZUUGtzeW5jY1dDTFU5?=
 =?utf-8?B?U2syYVkrM21xS2w5UU5NdVNwOEJvRHZtbW4vSktuZWZkT3NkTm85K2NHSzMr?=
 =?utf-8?B?aWsveGlMVStaK25VQXdQejRxZW1KQkFYYXpPOU1XTkZLdlZoMEE2ZERZazRS?=
 =?utf-8?B?cXJwVkdySE1wU25sUEhjYzhGRjhrMlZCbnVMa0gxaG4wRzN4ZExwcWdPLy9l?=
 =?utf-8?B?eENWK1lpSkJuZHc2OXR0SWFXS3RnYkxnUzd4RFhabHQ0cEh4R2NCMWpLM05l?=
 =?utf-8?B?L3htZEpXMWxTcnJZeXE1UDFETVZadllxME5uaHdtTDA1YVExTnVnTXJ4bko0?=
 =?utf-8?B?WTBheGdVSWVkVXNTRjQzYlBuTGNEeUF5N3VRdjNaNnpFS05xOXVVQmJueXh4?=
 =?utf-8?Q?5EKZgGqUmB4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWllMzhxbjRpZ0VMWlhYdkRoNmNGMFpNMGFybUR2aWg3Q3B4cnFWc0ZsbFpl?=
 =?utf-8?B?T3Y2ZmZUTkdHWFR2MVc0bkxTeFJnNUJlczk1V2gzRUtVWmZwb0FXM1lNZ2l0?=
 =?utf-8?B?MjhRYmt6TWZsTmVOYTM3d1F6bnVrVmQ3WmZDYVViWC9jS2hmQysxaS9YRnhy?=
 =?utf-8?B?cE5vQmxOaHdWNWwrM0dDL3k5eE83VWtRQllLaEl6R1FnZ281cXg0S1hXa1Nm?=
 =?utf-8?B?dzJ6azJmdFVJNnpZSENEWkdUZElmV3U5L1NuQk5kaGtZR2l4WFpqY01vZHVa?=
 =?utf-8?B?c3FVbERnOTNRNzBBWitlK3E5dzBudlJqTTNlRm1La2ZuYUIydUIwUTUzQW5H?=
 =?utf-8?B?WTBGUHdBWTNiMHl2bjdrUm5hdVBEWHpDb1BWMWVHYWJKRnpYNEs3M1VqR0Rm?=
 =?utf-8?B?RnFEcnVsZksvZUs3a1B1RFBwTHlXVDQ0SDlDQ1BjOWFqR1gzVWxET3YvMW4y?=
 =?utf-8?B?ekkxOUJwZWVlbWhnQVJtVDV2Z1dSTTBuNVBEYml5Vkdzc1dVL3ZHOVlOTWpm?=
 =?utf-8?B?UkZmNjhQaXllWWo1Zk1zUG9kV3BXQy9nT0FIRUZhOE1vd3BBejQyWDU3K0N6?=
 =?utf-8?B?YlFFTVQ2N0RHQ0xveVFidGZqTG1tRTIrN2pMUFZMOWVzNjhBaDZlckNFb1dp?=
 =?utf-8?B?bDU3bnV5ZXQwVWo1SDY1ZVJmM0IyMm1qdDZLNUpTL0xqUmk0ekRRMk9VQi9S?=
 =?utf-8?B?MWNNL3FHdmZLZUkzaG1zZ3RoYnNlWWlxQWxWTEZGc01Wc2pnSkFLZUNURi9F?=
 =?utf-8?B?TWVzQVNVc2M5N0d2b3ppcFNhZmdrd1dkSHBObHFTR1RKc2kxU0NhYnFkSk9S?=
 =?utf-8?B?MkUvTmN4bXA1ZnRYQnNOanAwWDhRZVNQeVhnVnIrVlNjbGhKWVgxckVjek9C?=
 =?utf-8?B?cXdCYmNKbmp0WUx3YXNKeXhKQVRUVGhobDRVaVlhbmY4RVBlZGoyZ1EwcFZh?=
 =?utf-8?B?dGRhODhmWDBCT0hMMGhwWG1tM0EvZE9rald3cUFha2hrbHBQeGd2OEJXTnlO?=
 =?utf-8?B?OGVFNzByNmwzeGVCTDJRanZ5VlJ6am5VdFBDbzlBWDZCK0pBRWRHdlQ0Qzdx?=
 =?utf-8?B?SHV0bVJVSi9EaERzRFBleGN4WjhLRnY1TjIwV2xTbG51QjNQR1VrUGpKMERE?=
 =?utf-8?B?SXRUbkF6ZGpKcEZpcWQzNFdGM2hsQXhMaUFnelMyYUJMSmxzazd6K2M5TGJw?=
 =?utf-8?B?Y2lKYXdYSnNvdlhIZGxBd0tyMWEwZ3ZCMVBtaTdOeTFyNWljZ25GVjFVUlBl?=
 =?utf-8?B?WjBGN3lYYmpyTHpDdVNEM0NPTnB3azBOUk4wL0RXWGZMdmVzYm42RW8yVE85?=
 =?utf-8?B?N0szdmZRNEtxNTNqKzhYSnBMKzRGRXc2TkJOSVNDMUwwRkI2OGR0L0hkdlNN?=
 =?utf-8?B?NXlLQVVOWTB1MEhhbStXWFV6RldmNUxJQ2dWSXE1b0VZamNqMEJEdTdNTUFN?=
 =?utf-8?B?MnZRaW54K0pCUitWdHQwRUZLTUxkZUhQTmJhN3Z6dzkwRzBrakh6cFp0NDNl?=
 =?utf-8?B?eUx1MmZpc2FBWEY4d2RScWFsWnhQcXdRM1hxek5tTnJDSmNPc3o0ZU94TEIw?=
 =?utf-8?B?YXBUTDliM3hMMjZ1NFZqVFNWODRnVnArMHVsZ1p3eERPWmVFV1ViV01JWFJu?=
 =?utf-8?B?ei9kK2dlYWNUZEhVcnVFMU1uZFU3REd5K0dQSUlJcE5aYWQvdFNvNDloL2Zs?=
 =?utf-8?B?a3pNTFpyNW9CQ2x4OUlTZ3hGR3QxZTY3Y2JNcXNzSW1KWk16N1lZVzZjcWMx?=
 =?utf-8?B?RWtTQzFuRVNBSlFBRVlLWHFIZ1k1S1dzc2tlckk0YzU3OGQ5ZDlQYWo3WC81?=
 =?utf-8?B?czI3UWgzcVh6aTVGRlR2aUhoRTNVSzR0T3drbzZkWXFEVWRWbCtjeFBBL285?=
 =?utf-8?B?WVpMbWpWdzI3NE1kaVNwRmkvSklxMW5ZUlcwT0luYk5ZTVBwSjYxb0VvOEVp?=
 =?utf-8?B?WEx6REFtSnpXeDhPU2Vyd1pGUzZjYXExL255S0RLTFN6V3BYa0llelFZMisw?=
 =?utf-8?B?U2ljdjhUVXYzeTIzUGQ0RUhKYjVNM05ocWpHd3k1QWlaZ01NZDR3Nmo4bGdh?=
 =?utf-8?B?T3NTNEtoRlk2TXVpNlNqSXF3b1VObUs4dTlPQURGWTRjdkhEdVRibFJrUWhN?=
 =?utf-8?Q?vnyzOHmk2wt2zIUxiuQeXcTrd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f248b5c4-8810-4bec-c951-08ddaa504bd1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 08:00:00.5318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndNBcD369BbIHujcgdhK8vlXzUVSjnYOxNNUPK248NFERfjecNpFrgnWSBxk6mDg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248
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



On 6/13/25 09:38, Jerome Forissier wrote:
> 
> 
> On 6/12/25 18:49, Tom Rini wrote:
>> On Thu, Jun 12, 2025 at 05:32:41PM +0200, Jerome Forissier wrote:
>>
>>> Add a script to help build a functional U-Boot binary for the ZynqMP
>>> Kria KV260. Also add some documentation.
>>>
>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>> ---
>>>
>>>   doc/board/xilinx/index.rst        |  1 +
>>>   doc/board/xilinx/zynqmp-kv260.rst | 27 +++++++++
>>>   tools/zynqmp_kv260_build.sh       | 43 ++++++++++++++
>>>   tools/zynqmp_pmufw_elf_convert.py | 96 +++++++++++++++++++++++++++++++
>>>   4 files changed, 167 insertions(+)
>>>   create mode 100644 doc/board/xilinx/zynqmp-kv260.rst
>>>   create mode 100755 tools/zynqmp_kv260_build.sh
>>>   create mode 100755 tools/zynqmp_pmufw_elf_convert.py
>>
>> Helper build scripts don't belong in the tools directory. If they're
>> super helpful, I don't object to adding them to
>> u-boot-extras/contrib/<you>/ directory.
> 
> OK
> 
>> But there's a number of
>> documented examples already on checkout and build TF-A then do ... for
>> your platform.
> 
> There is doc/board/xilinx/zynqmp.rst which deals with quite few ZynqMP
> boards but not the KV260. In addition, it has a number of shortcomings:
> - It mentions pmu.bin but does not say where to get if from
> - It doesn't say how to build TF-A (bl31.bin), some very specific build
> options are needed.
> - I consider that detailed build instructions belong in things called
> scripts or Makefiles, that were invented long ago exactly for that
> purpose :) IMO the documentation should tell the bare minimum and ideally
> be unnecessary.
> 
> I am not particularly proud of the fact that I spent more than a whole
> day trying to get U-Boot master to boot on my KV260, and without the help
> of Michal, no doubt I would still be trying... So, how about I submit the
> zynqmp_kv260_build.sh script to the u-boot-extras/contrib/<me>/ directory
> and just point to it in doc/board/xilinx/zynqmp.rst?

no issue from my side.


>>> diff --git a/tools/zynqmp_pmufw_elf_convert.py b/tools/zynqmp_pmufw_elf_convert.py
>>> new file mode 100755
>>> index 00000000000..b4eb2695831
>>> --- /dev/null
>>> +++ b/tools/zynqmp_pmufw_elf_convert.py
>>> @@ -0,0 +1,96 @@
>>> +#!/usr/bin/env python3
>>> +# SPDX-License-Identifier: GPL-2.0+
>>> +# Copyright (C) 2025 Linaro Ltd.
>>> +#
>>> +# Written by Gemini (Google AI) then reviewed and edited to remove some comments
>>
>> I'm glad this calls out where it's from. I'm not comfortable for a
>> number of ethical reasons on taking LLM-generated code. I'm also a
>> little surprised we don't already have something like this with binman
>> today?
> 
> Nervermind. 'llvm-objcopy -O binary pmufw.elf pmufw.bin' works just
> fine :) so I'll use that instead. Note that the binutils objcopy
> cannot be used because it is target-specific and the MicroBlaze
> version is not so easily available. While LLVM supports many targets
> natively.

yes/no. Toolchains are wired via buildman already and available at kernel.org.
Connection to llvm is adding another dependency.

I think putting this script to u-boot-extras is fine. To upstream u-boot could 
be more problematic because as I mentioned there are some issues with the way 
you use. You should be able to take bl31.elf from soc-prebuilt-firmware repo too.
You can also look what Neal did in buildroot to get it work which is better 
place for building tfa and putting images together from different locations.

Thanks,
Michal





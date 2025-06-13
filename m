Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B52C61DB2
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 10:28:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49D3B800C1;
	Fri, 13 Jun 2025 12:28:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nOJU8h+v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A5E4807B1; Fri, 13 Jun 2025 12:28:10 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD3678003E
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 12:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbR8hV3OKY5+AObNjp5v9Y535PTqep+HrZxv4J73WZLAJWukJ74pBn32hXJy/SaY5BDxal4wWF2+qET1EmArJzhnQmMwSNauwSaplrl6RmSX5992PExAhaIJ8ZXmGHRdxzjqAy32xJDBtjHjaDC4KLhxsrmt+FJWGI2OQFsSmhVLVnNcIWaFeXwKsSdqhQ7EurTpIZJ4KaQo82vAIkvB9w3DhBOyUOIdbR/DmLfFftPT6lydBWOqu57Cy7N6qO+egrltzdTq8Rxv1gW4xdNMTiD/J9qUMOTwGpFGK+VYxLrqcmDe3UTFNHCWWiIkWQBf3MAd7mbnW0wzKXY/zmxIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9QW2j7P6KtwK0qRjyDkE1mVZ39iEdpedm0UukGVwHw=;
 b=KD1LKndQM3euRMhUUW0q/IEgUxOkeQBbncNwnP/SmCzm+wgcX8/xw6ywPuhWYBafPxYBEr3ntCCciYSAP1yGCgOX/8ZRuHlzL1HR5DUfMG1EljeBL4AJjgcdmJfEsCW/Ue1zq7MWEVnRJ0BKzIZpygo/dIaCmJEw6MSr69cBCEZBWDDnfR6AuC6dNstK/38nsjfKmCwWh/FHLGysfYlc5Hi1e8Qo9N/ao8UFHcyiutai4qRmsH2hW1fvRofUIA/KLwSN5sK3ZEyiUjGQJf+HMW57+2DkIlTtP+aC05skdvM2EnQ9kYx/1uE1wF4MoNXY0VLH/DjvCJ1vX1YiGwg6sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9QW2j7P6KtwK0qRjyDkE1mVZ39iEdpedm0UukGVwHw=;
 b=nOJU8h+v7VqHp2PvMFNVAjfOfVlfUuCLg7xrMlzGJ6PrxESltxQqjzW+1c6cV2VGCZfbkhGwCsGkm4jYDiTyLX60CPpp/Q/9Rtry8Pl0nuaS63m1YcJTVZ2z70B+qY3m9rkn74y+V51ZHC03i1OnOVqi2dNuLcBoln3/hcbd1hY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 10:28:04 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 10:28:04 +0000
Message-ID: <6105e973-6677-4839-8489-138c20137baa@amd.com>
Date: Fri, 13 Jun 2025 12:27:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] i2c: muxes: pca954x: add pca9545 support
To: Frank Wunderlich <linux@fw-web.de>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 Maksim Kiselev <bigunclemax@gmail.com>, u-boot@lists.denx.de
References: <20250606095056.22082-1-linux@fw-web.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250606095056.22082-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0051.eurprd09.prod.outlook.com
 (2603:10a6:802:1::40) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 39dbb596-b585-4906-a189-08ddaa64fb40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGE0SXNFam1saEZDZ0gwTmdyOHRmWWdKUXZ0VlhRZ2tRSStMRG9MUU51L09P?=
 =?utf-8?B?WSttRDd6eG5tYTNtdmZBRjJXekRTRlIvRlRjTFVFb2FiREJKK0NxWk8xMVpO?=
 =?utf-8?B?UjF3N3paaXVEOGh0MG9yamtVS1M4aWVuajEyZ0szSCt3OHFrRE43RDBZU0FW?=
 =?utf-8?B?WTV1YnVGcDdIQXNIZzlFQVY1L2t5WnRNNnRON2FuSHFtempvZUlZb21ITVc0?=
 =?utf-8?B?RjlCL2xjWVl5emFkdFZaakg1K3ZVY05rZnA5VzBQd0VpRW85eWFHTHVvK3o0?=
 =?utf-8?B?K1ZIdUg4eVdPYU1uZFdoTStvU3FoVU1oaGQxMkJhbFBYQmJ4TzV3dEh1LzJZ?=
 =?utf-8?B?bU91L0xXQ2tKMkg3dm5ZbVRaYk5wSkRwSHZXOEpXcUhPTjdjclFXWm5hYTNx?=
 =?utf-8?B?RXpJbEw2aFQzdGxvdzNwMitTK1RqRFBxUlpFeEcxZTFDS2x6Ris0MURtbkVo?=
 =?utf-8?B?VUZ4dmVoeW1wWFc4MDZxc2ZTbkpCOXVhQlRiTTNjM2gvZUczL1Q5UWFDckYy?=
 =?utf-8?B?K2FTa3JSTitTdEUwVGFnRnFlYzRWWXN2dWE0MFR0TTQ0SENmQ1JKckNOdkJJ?=
 =?utf-8?B?Wk1OdWNIWm02Yk1ZQStscUo3dFlsUXRMTXRLSmdtanB4d2FKU05ieGltcSs0?=
 =?utf-8?B?eXdINW93cys0YiswU25jMm1KY2RvYy9ickYrR1dsbUpzYy9kYXlST0tITGwr?=
 =?utf-8?B?QU9zSy83T29GaUNTNWhhdEE1M2t3aDFWeHZlZjZyVVRvTmxLVW4xby8veU1C?=
 =?utf-8?B?OUVodGNqbGpSMHdRN3lsMEpJeTlKbzZVdW43NXJZOUdQVnhreVVQRlE1Z0sv?=
 =?utf-8?B?M0lneHBsWlAzOUlOUVEyOFE5VGtLNTJDQ0lRMEJLbngzdFV0dkVVQXhYa2l5?=
 =?utf-8?B?OWNlSUFJaC9GL1VWR0xON2VxdmtzSnA3Z3ZPeGZBM2grNm1nZmg3OGpvWGMw?=
 =?utf-8?B?bDluOVB3U3RWOVJKd3NXMDVqbXl3RlkxcEVCZHZlT3dtUUNTOU5VQ2IwcDM2?=
 =?utf-8?B?ejBmR1cwTVY5RUhEK3BLNDQ1ZGd3YWF2YzR0cWRzWGxBbWF3eEtNQmlPTCs2?=
 =?utf-8?B?K3FZUFVtR01vSThWdjk5Q0JiMDhGdTZ0d2N2dVVsdW5KVmJtb2ZnbjFRQmJH?=
 =?utf-8?B?bUhQMHJiZ1VpWEFpMUU3ek5paGNVRy95OGp0dVJOQk5aWnk2SmZhQnpCVkJo?=
 =?utf-8?B?anVOWkhuZXdiaEZZOCtyZUxWZ3I0eGNiMjdINy96Njd5VmZTVWFQbVNpajdB?=
 =?utf-8?B?d0UrUUkxUXV3WGc5eTFvalBERTRIT084cGF1YUJsRktSVjBQUWhVWmtMekVR?=
 =?utf-8?B?L0JDUHFSNk4vQTBudmFNdTdnbWpHeWVjdEZya0cyRnRRRnlEaXZuV3M0UWtm?=
 =?utf-8?B?ZmNoeWphSlVYMVJvVEVQUTNabzFyS1QyK0poUTlrOHB2L0lwOUJrLzlzSFda?=
 =?utf-8?B?NEYxZ25kcTFkMWo0Rkg4ZEh0YkhWL29vYTNkdWpybkZPZUo4aytFSFZ4VFo4?=
 =?utf-8?B?VVVVanJrSzNpR3lIVUdVa1UzL1laU25Sek1McGM3eHVVRTA4L05wUnp4ZEtH?=
 =?utf-8?B?Z0JhbjUvdmovdkRCRVFlY2kvdm9GRVhEVGVqL0RVZmdiRDljU2dRZURpaGJG?=
 =?utf-8?B?dlBDZlJYRU5yLy82dmcrVWo1TGEwNUUzSnZ6SXQ4RkkzUlRLOS9NaDcwWlk1?=
 =?utf-8?B?Wld3SjdqM3c2clQ3S25MR2RGTEhUQVM2Skd4b2R5VldjN085dTRJNG1XenhQ?=
 =?utf-8?B?eHFuVjVEUVI4elJCMlI5dHhLcXB6ejhXY2JOdTNxamxBZTBMNUNPL00wV1ZH?=
 =?utf-8?B?MTQ0ekdBS2ptL0ZvYWt4OTBubkxRcTBQN0lPd3g5WGJ2TFRWUnFTZkJGeDI3?=
 =?utf-8?B?VG9qeGEweXNJOUhEVXhlMU85NkRpVEY0Qm14YTBuZ2l3MlFwVVM4Q28zWHVr?=
 =?utf-8?Q?T38QClGo2+w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnlUWFB2TXR1Unl2cmpFcWFNWDdiSmRpR01MNTYvS2FFRGdpTVJxdW91WUJJ?=
 =?utf-8?B?ZTFBMHF2VUhSQ3FnN2dYWk1hT0NNWUdIcjAwbEczZ1dMcEEwK3B2Qy81aEdM?=
 =?utf-8?B?WTQvaFpaZVo5NnhUQ2RGL0NYdmc1V2lablp2ODJUeEdlT1BoVVAwcVpvSDNG?=
 =?utf-8?B?TFdMZ2p0Y0I3b0JYZDVJU05mUUVEMGx1QmdXeW1HT1d1L1NXdWF5QU04ZE1S?=
 =?utf-8?B?VElXbzZWYkQ2V2hVVU0zdVdlTVpyYTg4VE9uVkdvL2tJOGRLQ1czb0VtV2RT?=
 =?utf-8?B?WVJPVzNMelEzRkY2dFRsS3U2cTYwaUNyMmhoQk5xbnMyQWtnVkZmVjhISStM?=
 =?utf-8?B?VjU2eTYwaFdyQUd6YWthaHNJU3ZROTFnREhqNklYZnM4OGtrUS91aU1sSHdS?=
 =?utf-8?B?RUhFVUgxdEx6bXBRdndubFJQdk4zMmRXNXhrSnB1QVNpYVRQUVpRWWF3Zi9J?=
 =?utf-8?B?RUZXaUhCV1ZSWmppYmdJSzlqb0prZ2xRRXkwdDhkOGQ3TVpqM0t1T1JGTTkv?=
 =?utf-8?B?QTRhVTI1cHNKU2QrcGM5NnJHcXgvTkhWbklzZWpRVmhrYzVIUzZoWmxyWDlr?=
 =?utf-8?B?WDlCKzcxdncrVkxKOGplbUQxUzhFVGt1Zk41QnByL3JvM2diVnlKdWJVVTdC?=
 =?utf-8?B?RVRKZzA3OFBqYUtJdGNJNHd0Y09ybm5qRWxoTFAxVU9zK2FPMzNjbFBWL3Mr?=
 =?utf-8?B?dmJNbUQ4Z1BGejY3YkxrZ2x6MlhTemJ4ejMvVnNYd3FkbjMrZnJYbHVGazhm?=
 =?utf-8?B?QjF0RmFFRHBDYXBldC9EbERldkltakVZUmowWkdkQkFhQWRJZlFsbXlWcGRS?=
 =?utf-8?B?eXk3cnZMbFZVMTRROWgrWm85NUovdFVhRm5mM1NGQVk4bktxSmdoK1kxUHVQ?=
 =?utf-8?B?dEpQMm9meTRWMzlCcGlJTU91WUVGU2hSZnVudEhaVWpxdVpiNkdHcnZ0KytO?=
 =?utf-8?B?cmlURTFnSDM4ZGp4UDF4cG5FQVZtdEFPMGtXQnhLdmFNK1gyWDBkdEhtN2k0?=
 =?utf-8?B?d0hEdXptL252Q241V1g4TkdoK1AxMkVoaE9SOHArVE5SS0RlZk00OGxWNnNx?=
 =?utf-8?B?dCtnb0N6Ukp6eXVlcEpBWnpPNGdSUFR4T2R6NUdIV2d3SmFWYVozMjdTRVVm?=
 =?utf-8?B?MVNYV3gxU09saUZ6K3VMNTJRUVVaazhpcVlmempaZG9zcmFXZGFDdDN4RUQx?=
 =?utf-8?B?S1QxWUpFdjRxWllXY2lMV2tiZ3c2S3p6MWI2L255T3NnZHJUaVRmV090a2lY?=
 =?utf-8?B?QUVWRTBabkpkWDI4cVpmRzZ4OFlPYzhnZGZEMjBVWXd4ZmVuMEpmUFBDK2th?=
 =?utf-8?B?bjJoeTVDYnR1T3RoL0hqWVN4dHpKcWdiREZ2NXgvRlpxdWxWaFVib2xDelg4?=
 =?utf-8?B?Z2tFZU9rTWVmditsMk96MlNsVWg3Zk9DcEFKOEttblM4SmdYYTNUOCt5WE0w?=
 =?utf-8?B?eTI3bkZ6cnVXNUx4TDczajdQbzBqU1VKV3hJY3lxcnY4MFJ6UVVFd2hKV0N2?=
 =?utf-8?B?TGJIL2J1MXk1T3lIUmR5U09nREhTMkRHeUVERmJuZURwSFQvaldJdFJQVlVR?=
 =?utf-8?B?ZzVub3RlSENPRUtKSnRHVUdvWWNZS29tdS92cFR0Slk2VEhKU1MwNjNNbmF4?=
 =?utf-8?B?TDgyby9OY3RRNGVvRTVmVkZMVmZWN2Mvc1drRzdkOFdUWmpaVGpNZ1VNRm51?=
 =?utf-8?B?Q3VDV0JhR2QxbG91UGNBeVM0aXZ4cEJqUW41OVdONzJCdTJpdHNsMGM4enM1?=
 =?utf-8?B?K1JTT1AydUpEQktic1FWOXRtVnRrUld6eFRKT2tMZ2h1Y2FWTDM3cXB6MHRG?=
 =?utf-8?B?ajQ4N0R5UWV5bVllNHpWUWRSOUhYSDJMOHZDeDF2ek8wUVBPcldzanV2SjVj?=
 =?utf-8?B?b0ZKNW52RUNycThCaVZMVUZ6aCtmU2crSUNrZmFqVWFWOW1EZ0tPQ0NZUUtq?=
 =?utf-8?B?VUlJQm5oYVFqelRDdS94Vzhnb21OQi9oV2lhR2lCQ1ZVclFNOGRPVGlGSmVH?=
 =?utf-8?B?YldXaGVOUjVMUjlIdDNQeHNpSkVaY2NVcjM5ekQ4dndjcGo0TjZVNnpTS05D?=
 =?utf-8?B?S0tJcXJ0MENoRnBHN1NJSzJUTm9XeDhDWm11UnQrdDZieTIrdldXd0lOSmhV?=
 =?utf-8?Q?Rlz+meAAG1SBXPTpqB5GoI8je?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39dbb596-b585-4906-a189-08ddaa64fb40
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 10:28:04.8015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdvBScxsAQXFPqEh0PXoPQuJnFE0NrtVxtLYA/AhqXy4JIBtm3yUjlXOT7m1bOOr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323
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



On 6/6/25 11:50, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add support for 4 channel pca9545 found on Bananapi R4.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   drivers/i2c/muxes/pca954x.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/i2c/muxes/pca954x.c b/drivers/i2c/muxes/pca954x.c
> index 9dd269727036..d13947a0d9cc 100644
> --- a/drivers/i2c/muxes/pca954x.c
> +++ b/drivers/i2c/muxes/pca954x.c
> @@ -22,6 +22,7 @@ enum pca_type {
>   	MAX7369,
>   	PCA9543,
>   	PCA9544,
> +	PCA9545,
>   	PCA9546,
>   	PCA9547,
>   	PCA9548,
> @@ -79,6 +80,10 @@ static const struct chip_desc chips[] = {
>   		.muxtype = pca954x_ismux,
>   		.width = 4,
>   	},
> +	[PCA9545] = {
> +		.muxtype = pca954x_isswi,
> +		.width = 4,
> +	},
>   	[PCA9546] = {
>   		.muxtype = pca954x_isswi,
>   		.width = 4,
> @@ -141,6 +146,7 @@ static const struct udevice_id pca954x_ids[] = {
>   	{ .compatible = "maxim,max7369", .data = MAX7369 },
>   	{ .compatible = "nxp,pca9543", .data = PCA9543 },
>   	{ .compatible = "nxp,pca9544", .data = PCA9544 },
> +	{ .compatible = "nxp,pca9545", .data = PCA9545 },
>   	{ .compatible = "nxp,pca9546", .data = PCA9546 },
>   	{ .compatible = "nxp,pca9547", .data = PCA9547 },
>   	{ .compatible = "nxp,pca9548", .data = PCA9548 },

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

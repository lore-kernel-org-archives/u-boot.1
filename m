Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4231AD5A6DF
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 06:43:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 952BB89C20;
	Tue, 26 Nov 2024 07:43:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="okrjwaU9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08CB389C15; Tue, 26 Nov 2024 07:43:41 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CB5C895D6
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:43:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FumAl/bJJbAa7pza1yMvLKnTTIV1hhelroIe3OE1AEJKqPPCDJ22XvCEjUAcjCkC/MsMvfApwgFhQmKg6Pgky2xih78hjbC+oHt6kjv7oq4U9NfkTnAZDCSMT81kDHi9OG/PsJ2MaYtPLXXGM/fmgABLctwMGlohKvDLttFRqfOgkB94zM2Jg0xx+KXDRgrpibh9AE4T/y26+LSa5aMLIyGCmonmCkcs6ppBzyVsukWVhNoTnnwmzjC1TuDQhe9sZdjQ9kEPjfoRH4MKLlBglw7TOORHBStQWapDuPk9F5Ll24/z5UsQhGV0y/FMInRnBxzKBG8u8MW7oJhPio3uZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj2xvKgj52Nu98nNktE7nxnkGGm2LhiRgX5HXWGynu8=;
 b=rAic+PqLyj2iHraZEA8QvyVURTJGDDMcKKyLDhInJzgxPSTBXTRu9TfzGm1TowFw2MsDndGhb7q8Ibq+YB8WZ2b54k3oFG8uqKWUrLFhX8dNKuPvAE59fJSTlARFe9f8duAMwlTTPHmBsXz8LOLiaDp4C3DssN51LnQ5n6+SCvvGjuQq6r4ScaSkW/OSYpeC537Ayt582Q3K4IPa1q0aXLIZG0r+FIQ68D5AiXFiEmJP0eXbigX6fHG8uWXhyDwMc1r3HodDOOeQZaypJRsfapVZtYIZUIC67ddoi61zJxI6950nSUcvc2usR/YYxCfsIfnH769Xh1Q4uuKGsHcA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj2xvKgj52Nu98nNktE7nxnkGGm2LhiRgX5HXWGynu8=;
 b=okrjwaU9mpylWM5Sd4fc+4Q8rVKw626AhTCEJiIP6qkX6k3P8EBhlEKHojAp/qh8pFQIi2AOt6OA+p/seVUISWaL/w9S571yrIXrtdRZeif7BJ/WLX15b8eK/mgJb3qwoGMwWI/HRQHehc8P0HOw+8OZGGZdXeOUaHdUwsC65IM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 06:43:28 +0000
Received: from PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f]) by PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 06:43:28 +0000
Message-ID: <4838b206-6701-4d03-b291-95bdd691e378@amd.com>
Date: Tue, 26 Nov 2024 12:13:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] ufs: core: initial cleanup and defines sync with
 Linux v6.12
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: michal.simek@amd.com, marek.vasut+renesas@mailbox.org,
 bmeng.cn@gmail.com, venkatesh.abbarapu@amd.com, u-boot@lists.denx.de
References: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
Content-Language: en-US
From: Love Kumar <love.kumar@amd.com>
In-Reply-To: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0039.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::13) To PH7PR12MB6538.namprd12.prod.outlook.com
 (2603:10b6:510:1f1::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6538:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d675eab-acd5-40e8-3ca9-08dd0de5a280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWdDV3pjcnlGZDh5NC8vdWF4VVVjK3hyZElTdlk5YWpLNjROaWUzTEVqaExi?=
 =?utf-8?B?YURRZS9Ha3JFL3JUa1lPTHhwWFVtTnU2TE9pTWdaNUJJR2pEd1VqYnFHV2JS?=
 =?utf-8?B?cnprMXFtcmdmRXNwRldOTEl3WXYrSHdMMm92RG9tTGh2MldTTXhERnM5anBH?=
 =?utf-8?B?bGZ5NlVPTG1NVFp5TmtWRGFRblhadStZc0IxSE9SZyt0cHh0OEgrV1ZpYU5z?=
 =?utf-8?B?VGg1NFR6NVNjUmgxdlhNQUZJRHZsMzNmZEVQbUJscXlLR25oSFpiMFFLRTBs?=
 =?utf-8?B?NXdXL2FHdU1FeWxHM1p5UGtGU0NDV1k4S2Q4TTBqTjV4eUF4OGRxUHNXSWFm?=
 =?utf-8?B?YWxrRFpIM0s2SnlITXM1NDlRb1pTc3Q2eUp4T0wrTlI3NmFKK1l3VkZYQjI1?=
 =?utf-8?B?aVIrc25zUEFaS1RxQWxlUGszTGsyT1VpL0duTmQrQ1JPQmljL0Z0bFRXSTN3?=
 =?utf-8?B?Mm5uTWtUZ3E3Tm9oY096ckxtYVV2N0F1Y3R1K2dpMnZWQm1HZlhXOWF5VG1O?=
 =?utf-8?B?M1habk8yUnJSanh6b1FwVGorTThGQzAyTE1QakhPS2lRdW5sSDhyc24yM0d3?=
 =?utf-8?B?UTVIeHBCN1ZrVnR1WHQ4ZmtkS0V2WlZwaGxHdDEvajFzZlkrbG05UXlMOXd6?=
 =?utf-8?B?RXFkUkJIU09wVDY3UmtRUmJBOFZFVVAvWHZnWDlNMzUyYmppUDlBbkF4SVVh?=
 =?utf-8?B?T09Wa2REMlk1TUwrVjdGTDdmekRQVWtpcFNqbmprRGJpY1c5WGF0cnpvV2F1?=
 =?utf-8?B?T1MrV2dHRTViMktEMk9hR09ZVVpPamZHdkdYRVE2c0NzenJNWkpZUzNDWXdt?=
 =?utf-8?B?WUVMblN5MjJpZUpyWHJ2NVV4aG9waW9KazU4SWpPak1FSEUwcHQ1U3JLWEZM?=
 =?utf-8?B?ZndhMDhaMVVuWGN6eHM3M3hjK2RiZ0pqdm0zWTZVaC9vZFU1UWVBYzdrR1FF?=
 =?utf-8?B?QnNsMWxhTkZMOEwrM2FDb2hLRzhzS0pNZENNWW1RNTdreWhxN2xnV095QWt4?=
 =?utf-8?B?b1huQlJ5RFgzVnFWejZHQzcyTWduMUs5cC8zOXY5WUNuNlBQYjNXZEhXRXFa?=
 =?utf-8?B?T3R4V2FPVm1US0NBbSszRmZUQXc1UFNMZHIxVWVvRzUxT21JY2FPczhEWE9l?=
 =?utf-8?B?U3A3c1lRc1d6VG9nZFFZSGlnbjM0b1llQXRzOWpQOE5kUE8vS3JQNGpxTnU2?=
 =?utf-8?B?TUlUNE9DSTF6V3B0bUlXZDhUaEtmd1ZveVZ3Sko1dUY2RlFTdnhYQmM2SGhu?=
 =?utf-8?B?M3ptWmVpVHN2ZXJXRVFxQ1ZJa1c3RjgycVVyYnVRUHBqdTBIWUpVcjEwc1FE?=
 =?utf-8?B?ZGp6c2dna296WDZvbDA0Vi9oT1J5MUtYeEdpQk1OYUpQZjFpdUVnWVhNL3lr?=
 =?utf-8?B?TU9jZDlwU2RvaWNCYU9RK1VNZk5QVk1qRm1hbFhPSnZpU3dJUFV1N1JBRjVl?=
 =?utf-8?B?NjNMTnp1KzI5U3RzK2Y4VXdUS2cycWpFZVpITHpiUjlsNDBWSnIwVklXRmZH?=
 =?utf-8?B?SkVJWVFtTS9LU1ZvRXZzMVN5SndWaW5ZVzUzZXBjNlpKc0hSQ205T1lIY2Ry?=
 =?utf-8?B?M2I2MDMvNVdLQXhMcUJ4c0NMd2h3cHAyUVV4dUpVTlVmY2xKSjBmZExhY0l4?=
 =?utf-8?B?MkxFWXYySDYwM1lWNjNYSURhdnNUMkVSc2dmR2hvNkkzdVFrb3RtaGRjSmJQ?=
 =?utf-8?B?YzlodDdOc0Y2b2Z6MnE2ZHRNZzQ5ZWRDbDdDR3lveDE5ZDQyR1l2UHIzb1hN?=
 =?utf-8?B?dkw2cEpwczZaR01FdG4rTS9FbFJvZWdOZDgxUm9sWkVjKzRtUUhIYnhjQTBN?=
 =?utf-8?B?MS9JbERZK0tJNkZLTEQ3Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6538.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmJWVnRUV2cvMExVUDRiNlZIL2oyT0JldWJUaHFLNlE4bHplekpYQU0xZ0t1?=
 =?utf-8?B?QVhKRXFIN2xaWHRDaGt4WTVTa1lEazEwSEowbVNNZ3VRNnBXVVNWYkJ6NTBn?=
 =?utf-8?B?R0dNTlg1S1UrOTdNRGp0TDA2MTArUUN3VGkzNFNsc2l4S2hWWVZJUmNBcHlK?=
 =?utf-8?B?SDcrSkFzbVYyUkFkdmxRaEhmZDA5Q0pCZ2JMME5waDNSUGFjVld1MGF3dlpK?=
 =?utf-8?B?aWhsN0dWN3pBMU9uRVA2bzUrand5R0s3RzdIejdUQzJQeHF6Ni8zeWxvS01k?=
 =?utf-8?B?bGNUaGZGUkpzRzFnN1A0QTVkeVR4dEtsV0Q5ZXZUYmttSjFHUitUdlNqTlRq?=
 =?utf-8?B?eW9nL0JNV1E0ZWJDdFJLaW55VVg2bllRZE5Bb2VUaS9nVy9EcjRwN0Nxb2Vx?=
 =?utf-8?B?TU56RnJ0a2hMQmZtMUprNGRnU0dsRHdGSlVUMGQ3YU5oQlV3TE1hZk5LclRk?=
 =?utf-8?B?MXZCM2RKQk1EaUp0Umh2Z21ucjZ4VWE0SzB3VmZFaFJsUGo2bzgzRWxXSytI?=
 =?utf-8?B?ZG9oWnhSckVVcUEyQ2VKQmZEcHJ2ZU1ocURkQnAwZ0xHU0Q5REtoUDlHYzV2?=
 =?utf-8?B?Mk5UenhGZlE3bDlad0UxallkcGNnYzBTTmtBTnlibndIVEIvQjF5b0txSUt3?=
 =?utf-8?B?bHNZTVg0Mi9kSWZBWEQxSGdxcXJHWG40dW1GNHpsL0dpM1RlWGRQblRuNDFW?=
 =?utf-8?B?NTJxNlhBeWlDWUUvb1F3N2Fvd2NLTnE0eTFLVHVoL3BXdk5ybTBvZEYrMmJW?=
 =?utf-8?B?VGNHS3prNmVxZjZWaWtxQy8yZFNhSXBlR1lmUEk2bDIyTUtwdWJ5UG53Q2tR?=
 =?utf-8?B?bC9NMEVybFFsaEJkNllUNTVISWNrVWpLZmxJTGJpT2szRFdaK1pmNTNESWtx?=
 =?utf-8?B?Slk3bGtVd3N2emdhYnI4QzhoWk9TUVRwMnNCYW5IMjYvdVZhREhMVDRZSFEr?=
 =?utf-8?B?NVpITjF5MTlPWjJiczZFYWhqbjhJMUdkKzYyd0ZrZHUzQ1FhQUxVdnNEZVI3?=
 =?utf-8?B?MURzdXlETllPems2VXNyVm9taFlNUVV6WHMvWkdsN3h5MytUVWR6Yy9WTXYv?=
 =?utf-8?B?WWxCSHpvMy8xVDBWNmFsU25Rdmt4ZHNQL3lFRlZoQkx5eWpwalVSTVpjL2h3?=
 =?utf-8?B?WlZrSVBCSkNDM29rUzN3RkpBVEkwRFMvZ2dBQ3FZc0FmNEs4V1VDKy9sdzVB?=
 =?utf-8?B?UW1sUWI5cnNZK3dKaHJJTWtFTGpQbFBPaEJKZkwzRjBoNkR6TGtManlXYzNa?=
 =?utf-8?B?RWs4ckRCYnZmSktVZUtodEhpRWZNWURMKzE0UjJNUlNzWUEycUZnalc0YkhT?=
 =?utf-8?B?clI3VWxZdjVvbjhWZjF4TUFLOVVMN20yZ044aFZSV2dGWWxob0FUZUlnVXVU?=
 =?utf-8?B?Mi9KdGEwbjFjL2xGMzVKR1FhbStkM01pNEcwcC9PNElxWmhKRU5leHQ1aEk1?=
 =?utf-8?B?ZnBBckVKVmw1VStoVHZIblFwRW56M3JjeVpxNytYYnhyUGR4TkJteDhQN2o4?=
 =?utf-8?B?ZHJNNFlncFNNOFJmUXlXNHlLa1Z1TGNJY2FwcUtOblZsOXMyREhabW9hTW1p?=
 =?utf-8?B?WWtBZHExbHBQUUoyTTEyeFp1b1UyZHhsUkxvWFY4cXVaNUF2Ny9MQmhhMUJT?=
 =?utf-8?B?RnV5L3FObUFaTENYRFNxRTNnNUJac2FVN29qZEgvMUVlbnlmdDVZL1dKc09z?=
 =?utf-8?B?bzlTYzhTY254Tkd2NjdseFI3bnBhZEhyZVVBVWUvTkJrNjRFWkhMVHhneG15?=
 =?utf-8?B?dDNCVXVyV2IxV01sZzd6QWdZb2RHWFFYY0ViUGNyUmY1Ni9EVU1oVW5waEIy?=
 =?utf-8?B?cEo5ekYwSTBMTkRaeHcwS29SdldaWVRoOENnRVZOUVRqVk1CM2c4bVFISGE5?=
 =?utf-8?B?SXQySzFSMkw0VnBzZjEyQ2w5TTM1QUlvRTdoWXIvMERTWEpjcFZuTGVCOE9v?=
 =?utf-8?B?c2ZieGpYaStKbDE1ZzNwNWRoWUdHa0R2TzRKanB4aFU2RDZuSVc4d3JsTmR5?=
 =?utf-8?B?UUhFTzF1UmcvaXo2emZFUkNCYUUzaDR3WDhPU2phNFpnMmV2aHUzZjllS2NJ?=
 =?utf-8?B?MFUrNmlmY3lzRzJmbDg0Zjl2YlVjZWh0L2xEVGxyVlp1RFVYZ2NLWDJWd1ox?=
 =?utf-8?Q?i16s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d675eab-acd5-40e8-3ca9-08dd0de5a280
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6538.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 06:43:28.5361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kBhI1sWACvyC1bZh47NPhfAlJpq8hjY3OMsHjaMJI1CkN+AE+5s3kFNsUoQtTuI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
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

On 20/11/24 2:52 pm, Neil Armstrong wrote:
> This serie fixes the build and checkpatch warnings, and
> does a split of the ufs.h into a separate ufshci.h which
> helps syndhronizing the defines from Linux v6.12.
> 
> No functional changes intended, tests on hardware
> are welcome.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Neil Armstrong (6):
>        ufs: core: include missing include/ufs.h
>        ufs: core: mark unexported functions as static
>        ufs: core: cosmetic fixups
>        ufs: core: move ufshci defines in a separate header
>        ufs: core: sync unipro.h with Linux v6.12
>        ufs: core: sync ufshci.h with Linux v6.12
> 
>   drivers/ufs/ufs.c    |  43 +++--
>   drivers/ufs/ufs.h    | 335 +-----------------------------------
>   drivers/ufs/ufshci.h | 469 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/ufs/unipro.h | 128 ++++++++------
>   4 files changed, 571 insertions(+), 404 deletions(-)
> ---
> base-commit: dc1859f8d2ac3faaa5e2e1d465ec4bd8980520a5
> change-id: 20241120-topic-ufs-cleanup-23671e3fc9e9
> 
> Best regards,
Verified these changes on AMD platform (amd_versal2_virt_defconfig) and 
didn't observe any issue with this series.

Tested-by: Love Kumar <love.kumar@amd.com>

Regards,
Love Kumar

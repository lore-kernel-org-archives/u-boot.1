Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921CEC282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 08:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7F65811B2;
	Mon, 10 Mar 2025 09:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F8LcDPHE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D487811C1; Mon, 10 Mar 2025 09:03:59 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 687E780107
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 09:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAwT/qo/eO9QgUrgkdiTWjw5HQcSNXVXsEeXhPaogbWajxZk7AtmdlGDCoBmsFEuYc5OTd2AHpvG8IBmFpcTkOR/H7w4r/XnztQnZYVPcpy2bdlFov+/IBt6++gfxWt92Abe4W25gI/GnXo/jJQvpoSp648r4mj59d91OR+oNgBg8YbbmuFvF6R+/RE7SnSK1Vpe8MBOXe6b1Hwe/f9p9OgMV0Xhwut8kb9UXEeK+jKO8Bm7dPCz4o59CogxitvzWr153mNAVmed8MUuGFeuhXIQ6SI/NT5tN6Pxf3InGN2CtNRy5eqaXpWxHzhkuwVNb1x2/z//qJsa3fRuCYUhsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOIdQArhpID91dvB5ouzsGJUR/RtfNwjaXUedHMn9vc=;
 b=EfyBaUMzJA6SU7BQtyqadfavdz3dOjn9ds7Q/GLmcshOI+nMCEmF0Pnuz9+qWzqx9rGanENTOIa+hQandgrTufSetBNeNFSJ67NxnBleH4AlMkVQeoWKpumM89u1Be0CZtgRs0nMUotc38mSlUzV4L5UHKnhYNrrQs9XEDNO7AS5EIAUruIq4WRB+Lhw0XXcXhM6q6e/H+KFkkzyID+ZN7Rd+I4QI/M5TUvZm7bjmff10bNv7cnotedBUPul7r5PW+t06nq/FOL9g1L2DN/paoSdSPrL/a6R5NYN2gVYtCM7BAFnTa+cVtb4rATKzgGDhmoyyfvfcQhlLAmPC4nZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOIdQArhpID91dvB5ouzsGJUR/RtfNwjaXUedHMn9vc=;
 b=F8LcDPHEkw1vuUAfaJWbeAmpZLmhkrOGp++US0uNJU2AMdEePNbOlxTPrL9qW3XyKXkYdvFTSjAHwIgCHH4AkymzBGftYlj5gchQWpsQz5qsdGRhfXLbbnjDOP7WRkUVNSTBnUZ4UqaYnPEO0jmEvwxebqL0zleYo3l/qMr+EyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 08:03:50 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 08:03:50 +0000
Message-ID: <5afce6e7-db75-4899-96e7-454f95b9583d@amd.com>
Date: Mon, 10 Mar 2025 09:03:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence_ospi: Add device reset via OSPI controller
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, tudor.ambarus@linaro.org, j-humphreys@ti.com,
 marex@denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, u-kumar1@ti.com,
 trini@konsulko.com, seanga2@gmail.com, caleb.connolly@linaro.org,
 sjg@chromium.org, william.zhang@broadcom.com, stefan_b@posteo.net,
 quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com, p-mantena@ti.com,
 git@amd.com
References: <20250220141941.1509674-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250220141941.1509674-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::23) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|DS0PR12MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: 4772e5dd-5190-4f95-7018-08dd5faa1774
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFVRKzJ6UStaM1NjZEIxYmo3ZHZ0THJPOXJyTmFYeHJXM3dvSjdLUHhVVUxN?=
 =?utf-8?B?NW90MFQxcVZrbjNNcVU3Wmp6bUQ4bE9jaFpoeDlkVDRiUlFBOTlJMXY0ZE83?=
 =?utf-8?B?OXZKb0FMeXZSVERCclkxMzZNK1RSRThjWVN1VWJsY2xvOXlZTHBvcVlVYUFN?=
 =?utf-8?B?STZkSU5weHF5WWdHUzlVZjhQSVlnM0txdEkvZ05vY0R4cU9nMjhRMTBJMEJq?=
 =?utf-8?B?S1ZnL2pCcnJoQlZpTStaUFprcHVzMXNid0ExUGQ1Q0VHRUlaN1lHNE5TdXAy?=
 =?utf-8?B?R0VSVk1MZ3AvcG90ZCtSYjFKcW9DcVo0alpFVW9BUnRpTFNQdEd0c0xIaG16?=
 =?utf-8?B?WUtVMFg4aEQzTkU3YnRnb3Urckt2ZHVLejNNTTNuZ0p2RWI4UE5hcitFNlA4?=
 =?utf-8?B?QWxXWWNxNW1jbUVOeHVhc21Rd245VkRuTDR1YTRUcGhZRnlQendsQXFwNVFK?=
 =?utf-8?B?NGM1WnVKbUJlU2lNbENTQVQ0S3FrWVNJVlgyRC9DdVBSUlpOOENkSG83eEh2?=
 =?utf-8?B?ZDFoVDFEUTlXTWlHN1QySXNNWUdOdkpIR3luY1ZobEFNck5KY2E5NVl5dkEr?=
 =?utf-8?B?OEdYQ09WZ1ZZejMwdnd2MG1rSndCQktaSk4xZVlkUURDWE0waFIvcjJkRFZq?=
 =?utf-8?B?ZEFpT2VTS1hQeURjTUVxYmUxenNzWlYrZzZ5WjRJOTBVRE12MENkSzIydUcz?=
 =?utf-8?B?NzFDMHVHZVlZM2liWFUvMERZQWJ5UjBTdVJzUG1oTlNURGRZTzhNWUM4Mm1O?=
 =?utf-8?B?NXBlaGtuVU5Lb0p1MDNab2ZvNVRpTS81Snk3eG9kUnIybWdiM1BaV0ZsMU1Z?=
 =?utf-8?B?Q0dXNmJYOTNrajQ2VFBCbExlZHE4WXpTcFVTa2RFajYxenVXSXBoWVlGMGt3?=
 =?utf-8?B?bUtkZlBTcVlaOFpOODhZZGU2b00zWnZsNzNZMUw0d3g4c0Z3cEZaVFNlTUVz?=
 =?utf-8?B?QUsvN0hGdDdqUUtCbjlaOE9NZEFnbFZYYURLam5ZaW4rUnk4MkFsTXE0d3lC?=
 =?utf-8?B?ZlUrZy93bDV0MEVNRStuRHdxL1BJOURhczZZNkZZR3BCU1VTOEdzQlM1ZnNl?=
 =?utf-8?B?TXNpdHpJcWE3Q0VObXIrMkJiUWJsTTIrTVdpdWFSdDVaMktRUVJWd003TU1T?=
 =?utf-8?B?QkxhZWs5ZUxTNHpsWk9FRTZKTXRyUDlrZHYxM0lBbFMzTFpGQk5DMzFEZFcr?=
 =?utf-8?B?VGV6SE1tSzYyR0RqZ05lbS8wenlIK043WDRjZjN1THd5OU4vaXo0OTZld3NG?=
 =?utf-8?B?OXIvNFBRL2lvcWNOclUwdEJ1b29QR2V4U09nSDMxTlFmeklPbnVjUkZZcEhE?=
 =?utf-8?B?WUZGWU9qdEV2TVJVSTNoVjA0T0xTYzBTZjUxTndZaUVFWjZmZ0kzL0NGVC9E?=
 =?utf-8?B?ejIzMUhiRW1qc2VTeWNkMG91YjhXTzZtQllEOGVWMEg1a1doR09uMysybW5i?=
 =?utf-8?B?S3FFRmhqaXZvSFVPcjhWMjdHdUYrbEVYa2pOa2Q1WGtTcFRHZDdHcGRwVGkz?=
 =?utf-8?B?QXVIMHpldW9SSnpXNlNQMHR3eWlOSWZNbXRILzVXT2lqU1pXQzJoSXNKdU9F?=
 =?utf-8?B?MDVUTmdzNDN1RkRPZ0tneDl1azNuQnZQS1E5Mm83N2VtMTFpdkhsTFZEb0pX?=
 =?utf-8?B?Wi81M1FTNDR6bGtwS3Z1QUFaTUNIT1plTWRadC9oK0tSdG80NE1oNWZCeGdG?=
 =?utf-8?B?UW90YlFwcmwrVng5VmJkVENNNU8vVGkweDFabTJQaisyWHI1L1VIY2E3WHBv?=
 =?utf-8?B?UmxGUVFOUVdlSE9KUmVpQXZXeWRuMWJRd05WNFNqZklheDJGL09ZQnI2elc3?=
 =?utf-8?B?ZEZvRDJNM01qYVEydXJvSGhUSE9WUUR6aVM5eWc1R0VjRmxGbDFlS0piSk95?=
 =?utf-8?Q?VFvNryvCWOBwf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wnpqd2lLc1o2eVUvWkZNbXd4ZURHQ2RqNFVYTEdmTERZUTdHVzBLYmdrUlFp?=
 =?utf-8?B?cFVib0FxRC9YZWtEaDFzdDF4aXdDSXBoN3FvTEZIVWU0WTdDS2YyVjFLNDNl?=
 =?utf-8?B?aEpqR2l2SlkyaFdBR0lTYmRsMUFqalh6cUwwUTAyY0R6US9CWWpWa0orL1Yw?=
 =?utf-8?B?MWVRNUFvNGRoSjNrL3ovSE1jVCtKQWhaQjh6ZGY4TWsvWTQvT3k1b2FNb2JN?=
 =?utf-8?B?VnM3cWM1TjUwRmNKbXVqK3ZpakRmZ1R6NG1hcUQ3N3FqQ1pxTzZ6WmdzTUQ0?=
 =?utf-8?B?N2dESnEvbWZ5cFFNS2lxYjlaS2g1dWMxSnBSQS8vaXlNdG5EWC9zS3RSL2xH?=
 =?utf-8?B?TDFiTnhBYzRqdEpHaHczdE9GalJtdkhPRS9iWDZCRER1dVpnc1ViQ3JSd2E5?=
 =?utf-8?B?eXpJUUd1KzJ6a2xtSWRHbTFJSFI5blNhT0VlRHBaeUsvNWl1YVJLSlhuWSs4?=
 =?utf-8?B?WXVPUENhRW5DMXJRU2xlTFE1S1FUaEJoSzUzYWJMT0JmMFF5dkJmSVByTDZw?=
 =?utf-8?B?Ykl2cW9RNVhGMnF5S2g5Qms3UWs3bUE1UlZhcEV3a0tVWXg3UU5xRzU0U0tr?=
 =?utf-8?B?ay80NHNCcGdEblBCWUdnSXlXRy9udHJZcDJEU1FZbm10ZGdidmxXN3R1ejdK?=
 =?utf-8?B?QnBuL2hGczBQK3Z4QXNycENiWnI5K1A0ZitNZjdKZ0NkOVY0cTllOGVWMDht?=
 =?utf-8?B?WGdkaGhndE9IQ2Y2YVZDV3JBYnpHQ3hDb1V3aUlFU2dGVDJNcXlkNmIvMTJG?=
 =?utf-8?B?WjJBMVo5M3pyOUNPaVFXc05mMDJLdGZFaVFaVmFsVTNLUWV0czBxUjNSOE85?=
 =?utf-8?B?N2pYUzYvaTdmMVFQVjd0cnVJeUpqTmREdHduKytrZnJDZzRoUFFnL3lHcmVs?=
 =?utf-8?B?WHRpd0xIUDd4RXBCR29rL3prMDZqRm9KOVNvOFlYMjFlUFBRUmcvUjBPc1NP?=
 =?utf-8?B?NDdXMC9rOHIxZkpwQXdLRHhFSWV1YzF0VG9BR0JmMDNlZFE0Q0xKVk5UN3VP?=
 =?utf-8?B?M1hvOW9NcTBzdXhyVENSZDYva0pwWFZmQkVXcFJlQmp0bi9ZdHB0YWZxRGti?=
 =?utf-8?B?azZ4SDFJeGZpNkhXRXhNOGNUWXZsZDFXcUlleDkzdlE2dk84bEFxM3IwVFBK?=
 =?utf-8?B?WTZGUjBmRnVHQ1ZTVnFlRmM1ZVpMbmpkQU1nL1BhTExsalhyMTRUcXBrTVVI?=
 =?utf-8?B?Z251L2QxaTNsZVhYQWYvQmZxUkJXcFU1d3F1MEk4c21PMUY5SnNaYnlObENz?=
 =?utf-8?B?TEZMNXdCSFp4cEdpK2U2RXU3bWRWM2RRSHlneDRwYUdCekRQcDJweE9nVkwz?=
 =?utf-8?B?ZmRvaTlYc3I3bzBPcUFUUWVmMWtnREg4NUg0UGRLVzY3Z0t6VUJhY01KZ0Nk?=
 =?utf-8?B?MElhd2dGOTJXL0dKTVpMaEhaeERkYXVibXpQbzBoeFpDZWcxZGx3UWdaSi81?=
 =?utf-8?B?dzBMUlA2c29QYmNoVzFiQXBoZE9CbklBSnk0NCtuZ2hBTldYb2hEaVdHQzhO?=
 =?utf-8?B?UGU0anRmYW5UYzhjaDRTeXV4ZGVJcjNva1VxazJFYXhEN0NKbzBMcmVZY3Mr?=
 =?utf-8?B?V08vbm5pOUp0SDRhL2ZUbWkwVGY4eGpWSUdteHVIeWpkUzZtdzQ5Snk0QWM0?=
 =?utf-8?B?VzVZWkNid0xoNWs2UWwvR3ptc005VWozVlQ4TkxwMGRuU2hHYlAyS1NjbmRj?=
 =?utf-8?B?dnExejB1MVNYSDlTa21JdWtkRGtlbDBhYzZUUFgxb0pUYndNNm93bS9ncVYz?=
 =?utf-8?B?QnBSWEVvbzc0UnlWSG1mRTc1YTk2SWZJREI5S09ZSHFLNkQ4eCsza1lxTk9a?=
 =?utf-8?B?bWtaR2p5dE5MS3hOTTYzVWMzMDRGazUvK2pEN3NMS3NYKzNoWEwySHdZeDB4?=
 =?utf-8?B?Y3BrQnF2WDhjTjlMc29HdUFXdFNGUDIwb3JybkxPSkp3RlZMMUZFRGE0cnBM?=
 =?utf-8?B?NERCcjZVS1NMZlBIaGducUJtUGJubGNuV3ZYMURYSFl2bXJRVmhSVUgxUGx2?=
 =?utf-8?B?N24rVHpCZEZabFZ0WG0xOXBqRm9zUDlQdll0QWdVVmloUGZ5QjRhcklsc1M2?=
 =?utf-8?B?VW5wN0lEMXFHS0k1V0I5K2hjUFZyRGhpV1dOUERrbDBrMmE4c0NFQ3VWTiti?=
 =?utf-8?Q?S7flyL0HMgW+aCzPEKkTLAv3Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4772e5dd-5190-4f95-7018-08dd5faa1774
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 08:03:50.0301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIJsWowXDwJI/DAgzjqq0M6xosvXEyh6ngzvjzZsrQRjD7YR0v18V5gV05X8gU+Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200
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



On 2/20/25 15:19, Venkatesh Yadav Abbarapu wrote:
> Add support for flash device reset via OSPI controller
> instead of using GPIO, as OSPI IP has device reset
> feature on Versal Gen2 platform. Also add compatible
> string for Versal Gen2 platform.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/spi/cadence_ospi_versal.c | 19 +++++++++++++++++++
>   drivers/spi/cadence_qspi.c        |  4 ++++
>   drivers/spi/cadence_qspi.h        |  4 +++-
>   3 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
> index 816916de16d..fbeb0c6a85c 100644
> --- a/drivers/spi/cadence_ospi_versal.c
> +++ b/drivers/spi/cadence_ospi_versal.c
> @@ -204,3 +204,22 @@ void cadence_qspi_apb_enable_linear_mode(bool enable)
>   			       ~VERSAL_OSPI_LINEAR_MODE, VERSAL_AXI_MUX_SEL);
>   	}
>   }
> +
> +int cadence_device_reset(struct udevice *bus)
> +{
> +	struct cadence_spi_priv *priv = dev_get_priv(bus);
> +	u32 reg;
> +
> +	reg = readl(priv->regbase + CQSPI_REG_CONFIG);
> +	reg |= CQSPI_REG_CONFIG_RESET_CFG_FLD_MASK;
> +	writel(reg, priv->regbase + CQSPI_REG_CONFIG);
> +
> +	writel(reg & ~CQSPI_REG_CONFIG_RESET_PIN_FLD_MASK, priv->regbase + CQSPI_REG_CONFIG);
> +	udelay(5);
> +	writel(reg | CQSPI_REG_CONFIG_RESET_PIN_FLD_MASK, priv->regbase + CQSPI_REG_CONFIG);
> +	udelay(150);
> +	writel(reg & ~CQSPI_REG_CONFIG_RESET_PIN_FLD_MASK, priv->regbase + CQSPI_REG_CONFIG);
> +	udelay(1200);
> +
> +	return 0;
> +}
> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
> index 623904ecdad..05356ad2e03 100644
> --- a/drivers/spi/cadence_qspi.c
> +++ b/drivers/spi/cadence_qspi.c
> @@ -251,6 +251,9 @@ static int cadence_spi_probe(struct udevice *bus)
>   
>   	priv->wr_delay = 50 * DIV_ROUND_UP(NSEC_PER_SEC, priv->ref_clk_hz);
>   
> +	if (device_is_compatible(bus, "amd,versal2-ospi"))
> +		return cadence_device_reset(bus);
> +
>   	/* Reset ospi flash device */
>   	return cadence_qspi_flash_reset(bus);
>   
> @@ -452,6 +455,7 @@ static const struct dm_spi_ops cadence_spi_ops = {
>   static const struct udevice_id cadence_spi_ids[] = {
>   	{ .compatible = "cdns,qspi-nor" },
>   	{ .compatible = "ti,am654-ospi" },
> +	{ .compatible = "amd,versal2-ospi" },
>   	{ }
>   };
>   
> diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
> index 1f9125cd239..d7db37c1463 100644
> --- a/drivers/spi/cadence_qspi.h
> +++ b/drivers/spi/cadence_qspi.h
> @@ -45,6 +45,8 @@
>   #define CQSPI_REG_CONFIG_CLK_POL                BIT(1)
>   #define CQSPI_REG_CONFIG_CLK_PHA                BIT(2)
>   #define CQSPI_REG_CONFIG_PHY_ENABLE_MASK        BIT(3)
> +#define CQSPI_REG_CONFIG_RESET_PIN_FLD_MASK	BIT(5)
> +#define CQSPI_REG_CONFIG_RESET_CFG_FLD_MASK	BIT(6)
>   #define CQSPI_REG_CONFIG_DIRECT                 BIT(7)
>   #define CQSPI_REG_CONFIG_DECODE                 BIT(9)
>   #define CQSPI_REG_CONFIG_ENBL_DMA               BIT(15)
> @@ -310,5 +312,5 @@ int cadence_qspi_apb_exec_flash_cmd(void *reg_base, unsigned int reg);
>   int cadence_qspi_flash_reset(struct udevice *dev);
>   ofnode cadence_qspi_get_subnode(struct udevice *dev);
>   void cadence_qspi_apb_enable_linear_mode(bool enable);
> -
> +int cadence_device_reset(struct udevice *dev);

This newline is nice. Anyway I have patched it.

>   #endif /* __CADENCE_QSPI_H__ */

Applied with small change in commit message to spell Versal Gen 2 properly.

Thanks,
Michal


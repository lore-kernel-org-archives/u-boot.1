Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B32CC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 15:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 989D182A76;
	Tue,  3 Jun 2025 17:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UMYDAP86";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2EC480F9C; Tue,  3 Jun 2025 17:08:20 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E4FC82A8D
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 17:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FR9+wrp7wKLny6QblLPuVYwr8cYLAtiGmJ21sPTsSYzEJ6B1CQr2UgVthiamP67uuuTbdu+wOdlcsp49ZWhH5lKxCcNz1HLbj7HYMIcgIwJXZkNNTDobTifbdCTJ685E7RSLmm0RTkzN3/0OUVIMB+euYbg9lpAifBPcA8/sBYQcM8ZR9AP6SmY195BPFHZM2IDEfvyqTC8WsxBBTOD8cCxBP053FVuP6KKWr5e6HyMkw4TUm3atYcDvSRAvEQ3Dv8yHnJtziof4fljdLw0N8PEHjYkY2E0ROsLDOq0w8IEdUeI24vz1UkgK69MCogq4ukOrXF+le2UxvnHSlrVzdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUSCadcJHP6LFdBy8/6zb0fzLAalcMQA55Mzb/mPdyw=;
 b=ubq/hnaZXby3NIGQUq55dZ1eTUTIBNSxzXn1ioFmnQGlqipr6zWJ6D2gpeP/IrZufeEjo0xSydxx2eBtTLIbjESluoYBFzLMg7uVRL8Qfwei+CkILJ0RGxD0VjQJea8CXAbBrs7XZ8N8VSW1/baAj2+1kzwcgXsGK88q5z8WJi/aRHXQSGZUF0t20/eYTe37eIX4RqWrUd8Vtn5GezSw9rrB8kC6W1uAdTbvjvzFmCZLx/qEfcx9RKrCk6Zc5OHDrLoEN5W0JMxyZM06w+X597NTh/quuaTB4hCn0xkjmafvz8KiHCDTBMgWjrzvuHT+Iaf/bNZ/3wXYfftKqIeGSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUSCadcJHP6LFdBy8/6zb0fzLAalcMQA55Mzb/mPdyw=;
 b=UMYDAP86Mrd3qLxzda0EODw+vuRgXqGJmRjJSF55lZBJTvTI2mosMjkaLXdUG9iCSy7Z16pIY9oHRskgYkNB9yl2f8RZjMOgDaMs/JtXA6279Fz17zsalMOtQfsRnFq5t+xhEedTPjjvW3awIS3etZEILvoilE2b//QEuGkLUo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by VI2PR04MB10977.eurprd04.prod.outlook.com (2603:10a6:800:271::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Tue, 3 Jun
 2025 15:08:15 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%4]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 15:08:15 +0000
Message-ID: <d272087c-4f0d-406f-9630-57fc1c68b403@cherry.de>
Date: Tue, 3 Jun 2025 17:08:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux/bitfield.h: import FIELD_PREP_CONST macro from
 Linux Kernel
To: Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250603085132.12407-1-ansuelsmth@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250603085132.12407-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0183.eurprd09.prod.outlook.com
 (2603:10a6:800:120::37) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|VI2PR04MB10977:EE_
X-MS-Office365-Filtering-Correlation-Id: ee985d19-56b1-4a71-59c5-08dda2b076df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjhKY2VqUEY3anZHUVI3UGViWmU1dVJBWGV0OUxiVG1nd2JpeGVCSlNySFZu?=
 =?utf-8?B?RkNwNEgzT0ZzRy9yN1JtMkxTQU9POG11TEZ0VWxrZGFJYVRBQ2hhMFAwRk9X?=
 =?utf-8?B?Qytmb0xLazVjYm4vZlpjZWNpK0ZvWWVCbkl1VERZTWdETFdpdC9wenNuK1dR?=
 =?utf-8?B?cngyZ0RHT3ljeE9UMnF4NWNES3BZZ2hvUHF0eHkzcDRscHI2SlNrTjNJNmh3?=
 =?utf-8?B?Z3JKZG5SV3VsSitWZ0dHMHpBQ0o3QnhhZ3g0MWZrSEllaXF2RmpxT1lDTmhT?=
 =?utf-8?B?ZnY5MEhndWZ3T2w0N3dXOUdtUmF2QnJ4OGl6UU0rSS9Xb2IvUGtiM2tvY0kv?=
 =?utf-8?B?ZEtKL043bFdYZG8rTE45c1Q4Q2pDU1h3UHhJRFU0M2ZLTmxKZTRSRTlqSnhs?=
 =?utf-8?B?andqOEpDVHoxN3ZyUkYrbERCZVVrVkt4a2JyVnh0eEhGSGlrVGprOTJOSldB?=
 =?utf-8?B?YWdTSTZzNUcxOXJlWnBlNzE2ZHBxNVNtK256R0FzWU1JV0ZXNEtUOUttL3oz?=
 =?utf-8?B?SFJ4bEY2Z0lUUFQxdUNlejlJN3ZEcXVZWkEwWGM0WG1KOUlOalRpWXJGSWdp?=
 =?utf-8?B?N1cvbTJVS0N0UXIrWU9XR24wUWtCNzhvZWZFVlpGd1Z6QnRaWFBhVVpNUWRt?=
 =?utf-8?B?Z0F6eVlaWDN3Rjh2TG5ab0Y2Y0hQY0V5V0xkTWJLaTZicG9vdC9PL3BIL1Jz?=
 =?utf-8?B?eG1Eak5KNGF4eVFJckU5dHdWUDJmL20rN21pRVdxNUlqNk1YcHZuNnlMUng5?=
 =?utf-8?B?a1R1NzdLWk1PeU9GTWJsSjNweGpraUErTkV4UnlJajgzT0Q3TnBQSFlzZ21j?=
 =?utf-8?B?UHQ5TEF3YzRMQUxCSHpIei9vSXpLdythazVpS245bmlrL3BXaGdNelloaUJi?=
 =?utf-8?B?V3VqeXloL3gvNVZjc3p0TDB1N21TaHhwSFZvdytGdmRZekRmcElNUS9jTmdI?=
 =?utf-8?B?ejBSNDUyOE1jcE92L2pyd3g5SUViMjNKbEVqb1k1djl4czk2a2ZERTRkZ1lZ?=
 =?utf-8?B?aXFhckRQQkF0eHk2ZnErQjVGT1BqaFhKSWVjazdpRnlPWTMwcDFxRVl2YnFi?=
 =?utf-8?B?QkNScWNrMjRvelAzTnIvVU5GN1hGVUgrU3ZRalJYYkg3NmtYMC9GejlFUHRj?=
 =?utf-8?B?ZHRZUkdCY0dGV0FlWVdlTmloU2w3eGVxLzlXZmFpdFpnc1RqZExIczk4ZVJi?=
 =?utf-8?B?dEtpTmZKUDlkSzF2ZG0zRCs3Wi9TQTcrWTNiN3dMTkFiajBrdGVHZ2RJNHk1?=
 =?utf-8?B?UHlUdHRSblF2T1FqcGVlNWpsbUo4azFXZXVnR1Qya3V0ZlJKOWVuc3p3L09s?=
 =?utf-8?B?ejhacElPdHZwOGtBOUdyY0M3b3ZhS3JrSWxia2w4ekt1TnUvQXdtLzJMUHFv?=
 =?utf-8?B?VTBkaUMyN0F2RmE1eCsvQnRWRWhRd1lMVjZVL2tVdUF1Z2FaZ1EzKzgzQXdv?=
 =?utf-8?B?U0I0SGg1NTZ3WmR3R3BRQytrUHFVTGl5MGZ6NUxXUnQ4L0VHdUUyeVlCQW5C?=
 =?utf-8?B?M2lreGJCREo3MVNqK0xibWhuL0pjbnIvdjVuOWcrRFphMGhkY2MzSWFzSkgx?=
 =?utf-8?B?VTZYL3c3c2tsN3BrMC8wMGlwdE5KNkprZk04bjhYM24zdnl5dDNyNzlvYTlO?=
 =?utf-8?B?MjhxUC9LN0IwQWVGaHRVODJWbXREY1ZvejVuUjlCbUhma2ROTjZ6S08xVFpJ?=
 =?utf-8?B?Uy80SDBXVDFZUi9QNHkyb1d6YjNYV2ZGYVk1WjRRNXN2SUVJRzc4eWtUdno4?=
 =?utf-8?B?ZFFXRFdWRnJxNVhjVjczbjk2RlRkVkg2c0NLK0R2VW9PbkV1NGd4a2JpaGdP?=
 =?utf-8?B?aHdwQUhDNmxvRTA4bHJTY1NFUDN6L0pnQkw3aitGWDd2UGZJUmlXYm56THNj?=
 =?utf-8?B?K3h0L3grZ1NPM0NGMGlPSXByckk1TmNpUFRzd3NQdjBhVUxScDZvbXUzZmNQ?=
 =?utf-8?Q?Be6Vx1Qz7RE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NC9MTkRPQjZUUEVkL3E4elU2YldyWkdXcWJ5TkpkUDBhMWZjSGtYc0RjWTcz?=
 =?utf-8?B?dmVWREhxRFo5U3J2Tmp3S1BjRGVDa0R1WS9sVW5Na0JPbldyRHJLVVM4R01s?=
 =?utf-8?B?M0FtRmF3UEpGOHNkclFjWkI1QmNqSTVyWWY3ZEprUngwRXRqc1FUQWxydmdY?=
 =?utf-8?B?OHFtK2lVZkplNTh1MzJySjdaSHJud05haGg1TkhQVmNkeGU3anZ3WmRSeHp2?=
 =?utf-8?B?QnpEbjVRcXVMaFpjN3JMN0NVT0JKdExQU1FRQ3VmeE1Bck9BSm1hei9yVGQ0?=
 =?utf-8?B?c251eUI3K1Z2eXk2bVJ2dkVSazFXR292UHQzL00zSVd0YjFQeU9PblJFUlFx?=
 =?utf-8?B?TTFMSmJIVU1aWnJjUC9vSXF6V3J3SVRuVW1DRVFGMHBFc3NFVTZ3cGlQK0hZ?=
 =?utf-8?B?NnlUb3ZBaFl6RTc1WmJKSU1Pck5GN1Q0WWlFcXNrOU1JejlYV2ZjVE4ybFRD?=
 =?utf-8?B?bnlZTm9NdHVwQUdCMzArWnU2TjludWRDWDNvd2Q2S1BWQ2laQVV4TlBxcU1M?=
 =?utf-8?B?SUxXT0g5S1cyL0N2NG9tY21UQUJ6amhMVTJZY3ZjRERCZURrMXRYdHFhM2ZM?=
 =?utf-8?B?NWNIUUNMeGh3MjZtL3R6UHd0ZjRHSkxPS1pETDh5QVQwQjMxdXdKMVhlM29t?=
 =?utf-8?B?T3dIOXowR044a29NYVZ0Ym1xU1V0b2Q4ckNRMWUyaEphVlhMK25iRXVjbFhC?=
 =?utf-8?B?UWtIK1hOSjMwb1lxMWpGN3U1bFg5MVpneWlCbEQxMFljUTh5ZzlLK3dSdkJI?=
 =?utf-8?B?bFVqL1pVKzhVOWd4YmREYjZYY20yS0dpM3phYTRDYU56U0J5eHo1M09ZbEYv?=
 =?utf-8?B?eDMwN1BVV0ljM2V2RVg5OG9Pc2FGZTlheTFCUzc3c2RONy9kMzZNdzhpWjU3?=
 =?utf-8?B?dFFDY3ViYVRPeDlCOGcrUDlVRXNzWDZETlJYUFJiS1BnUEpuVkE0d2Z3YTY2?=
 =?utf-8?B?RDROU1lSd1ZvVm5Sck03aU9iNXlQY2FubXdva1ZSbGJCSkF4NVRyU2VlWFp5?=
 =?utf-8?B?SkJBMDJwTStkd3J1SUMyOVppSzJSbUttMitvcjk3WTBGTVJTbU53SWQvT0pv?=
 =?utf-8?B?ZS9LMXEzWG0zMGM3MnhjaDczaTFOQ3Q4NDZkRG4zeDNBNmhQakZJZzZkYVFU?=
 =?utf-8?B?ZVN6Q3JxRGNtUnJkaFpFdWRTT1F5bGhNWGNld2RSeVUzQUNwRzRkaUJzUmR5?=
 =?utf-8?B?My9TQWo5d2U3aXNZWFBXb2NrS3NIVzN1ZDY1SEZmamtWNXFUVHJrSmU3WXZo?=
 =?utf-8?B?YkU4ZXZMSmpkV1VJZ1VIcGEwNXhxY0ZpaXp5QXJLZjBZS0VURVVabTEyRWQ2?=
 =?utf-8?B?NVNwV0ZnUU9jT0t6V3kraE1SVVBnVGhjKzRQQ2NsMmZJWEpWQkVaQUJEL1BV?=
 =?utf-8?B?T21lMzM5QlVWdEY5KzhHS0krUnVGZ0tON1JGVXpDdUc1cnJhVittRDRvOVQ4?=
 =?utf-8?B?Q3VqWnRac3hSYjZ2ZHpxOEFNVWphNUhWakR5aUdlbTVNOTNlVXpHK3d6dW1a?=
 =?utf-8?B?bWVlaHlPMDA0cU0wRWx5TUdVSVBuS1JtTHhjWktrcm5nY2pnRDhHVFFhV0xK?=
 =?utf-8?B?b2JqMkhwN0RrVUZ5RjI1dXF5ZWgrQnBsSzU5N1E5Yi9vOTNwb3ptMFcxc09H?=
 =?utf-8?B?ekFkMkkxR0lKZ3NvVFlWaGxSZ012L05tdWt1aklTOXJ5VXRueU5CWHpQVTZz?=
 =?utf-8?B?Z0w1TDBoNHdwSnlWZ0dEUVR2V3RvMkJGRTNnbDl4Z2FuYkQvSW5HZHUvMGZY?=
 =?utf-8?B?aklOKzlPOCtCOXF4L2lCVlBUS01FSFgyeUtrTHZ3a1JpUUc0UlppaHBnQ09R?=
 =?utf-8?B?Ri9GaTRkMVFRRS9nUUJidWFQUnZBYW1qUkJ2cnlGRThCU0c4MUlIcmFudHUw?=
 =?utf-8?B?c2FkeDUwVGc0T01zTUFQTzZjTFRGWHVIWFhRNlFMTk1CQkVSL0lSMTY0Z1hC?=
 =?utf-8?B?YWgxb1M5a2lvSTk3L1NqOHNLZ1V5UEFpQS91V2tCRExiZjN5YkNReWNxaUU0?=
 =?utf-8?B?aDFXczJla3RScXlIM2llc1hWcHUvWGdocTZ6b2FFZVVDLzNndDA4V1h5TUxJ?=
 =?utf-8?B?N3JyRHhwYTZoenNjdzNXRnRXbTNTT2NkMVR2b2NQV1N5RzdnWkVwN0RNSU9G?=
 =?utf-8?B?T3FxdUwvbUJyQjRWaEdJK2s4TGVFanFqY2dIdml4OXRWNnp3NjlWeEVIbVNo?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ee985d19-56b1-4a71-59c5-08dda2b076df
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 15:08:15.1165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qglxg4EyJjfG1hVuTLGSWfQkCI+06Fgb+BhYUz3XVTAHwPgV2dHgfFuoSLxW18gTL6aTbZlBsl0Nz9ctL7wLLQ3mhGZTcft1u1J+H3TOtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10977
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

Hi Christian,

On 6/3/25 10:51 AM, Christian Marangi wrote:
> Import FIELD_PREP_CONST macro from Linux Kernel to permit usage of
> FIELD_PREP with scenario where a constant value is needed.
> 
> Refer to commit e2192de59e45 ("bitfield: add FIELD_PREP_CONST()") in
> Linux kernel for extensive explaination of why this is useful.
> 
> This is also to better align with the Linux Kernel for easier porting of
> driver.
> 

Do you know it it'd be possible to simply copy Linux kernel's bitfield.h 
instead of "cherry-picking" individual commit(s)?

Cheers,
Quentin

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268A7C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 07:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA95E83641;
	Thu, 24 Jul 2025 09:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3LkJ+R5v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4788083653; Thu, 24 Jul 2025 09:07:15 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 465B48362A
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 09:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMClIJM2xEy/3cYSbV0YI7FvN9gcNY0+nr8dlungquS+tbMTk1nyzXcMzAbbUEaMpeKZWtrwJY1TfABogfJo9dN+k3Md8XuM2tuiAIKUN1TBKtL66EPOh8jgAXu2mycbRXPkvb8kD5b8UGR9lqHLWrEjDBcwegfhm1PB96eFK0fgLz9nFoJf8r2arQLwBBDmJze0aUcx2MUeWWdmZL1P4/qiMMbxgVdoa87Xf2MtE+bmpI+yP8dvZuet4hZPT3WyBVfKVywRMoa7p6nNIigcnKTBzOjq1ZzQJUgGbmeA5tRkweFrBEgcltGJUiFSKE8CgYvnTXfCWX1o4DffX2mBuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWA5aUgaBNUdzLHFdfw0TZVXX0NLHjZrPcTyJJHXpuU=;
 b=k4519BKm1CWSjcs3cJiBp4zOauEHamqJoT+txO3w98pT4R+RzF7/laCMaXVEkpY9eT+y6E8F87bymVthNiqnFuOH5iIVjerM60Z+pdQpdxS8fKW7vUkIRgX3rQ86bNq/XMVo9mTolEZJsSn1V9nKFANICoVRQFHGPCKNZ4P158UprfC7nJCqqpRMc3aeDZ0vyvRSLx0Y7bUCtzYC7C780YWHTTo++CEEE7aWNXjZ7ZZttEunfgxU4/vMFGxMdde8JxUNSFhu+UV7eoUYOjMhDznO+v6Y7jCyaD3E3WETKdcLKKX7JnFCiguMLQQJUvB6M6XtHQQUdBO2nqHf1p6DiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWA5aUgaBNUdzLHFdfw0TZVXX0NLHjZrPcTyJJHXpuU=;
 b=3LkJ+R5v7kJDgvPx1kJj4E3XTm9pMxPrODPYORBuEe+8Nnd7+t1MNDgKm8EgROZpjJY7UN/KMuo3Zp254knMI09uZ0OLJZ4jVj+YQtgZNv4trSNuOSuWV7Ge7ebe4z7wKmmI9DLv92IPW0XHFP18ZiyLiKG5H2WpTCYcZ3KcjuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS2PR12MB9661.namprd12.prod.outlook.com (2603:10b6:8:27b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 07:07:10 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 07:07:10 +0000
Message-ID: <b7657f36-0268-4cdb-84c9-96a6ee2db8ed@amd.com>
Date: Thu, 24 Jul 2025 09:07:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: zynqmp: Simplify power-domain driver bind
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <c75627e92eeaffedf0f7e682edd4f6f39f0b5706.1752826352.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <c75627e92eeaffedf0f7e682edd4f6f39f0b5706.1752826352.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0109.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::38) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS2PR12MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fdcfb0c-c427-4711-0c08-08ddca80b55a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TS8yMCtKbmxwbUhDMCtZdGNpUVR0TFJNT3I0NGo2RXNoTXF4bTBHS1BoK05u?=
 =?utf-8?B?UTA1UENVNEtFbzNndUNOTm5jM0x2b05aY0VLaDNuQnUrellhMnhwMlNOMnE4?=
 =?utf-8?B?VmsxRjVoQ2lJeUxVUEZxSHFCbVFnRThwZDZ2VDZ2YWJ4UCtSSEh5dFl0UDln?=
 =?utf-8?B?V3NxNmJkcWpBcGpIMzhDYU1UUzZGc3FSSEp5NktxMnM3blJ5N1ZQWWhSVWd6?=
 =?utf-8?B?TitQWSsxYWRUVmMzUVNWSjZ3UlpDZ2Zoekh4L0lXazJvVThIWjRnM3Ara2ZY?=
 =?utf-8?B?WEF3Wm5OMGd0U285cFBGTlE4OGoreDA4Ry8wK1lKSFJOdEk4MTR1cjgvek10?=
 =?utf-8?B?emZqTnh6ZC9UTjc4TzZHcTVKQUE5M1hSemtWNndrSUE4a3Z4VTE0ZUdtVngw?=
 =?utf-8?B?V1VWM05OVm9FL0M2M0xXd2JWMDBlbytXWm1hb0dENUFVczdFYnU5dVRyYzdB?=
 =?utf-8?B?Q1F4YVFsTDZrbkxYUlc3cE1MaHcxQ0grN1dJa214dGFMR3FZakpNWW9uZTFP?=
 =?utf-8?B?Y0FNcXMyMG5WMG0ySk9GcjdUUXkvM3hyVHFXcXUwaVdtMEdFR015MnlxTWdI?=
 =?utf-8?B?SitqMkVxdWExajFCK3NpRnQ5TTlXVk9pUktaMFh0UmdTdGFSTkVpMHVtZVhB?=
 =?utf-8?B?TVpPWE45RVg0UDNCNGR6K3JLeEFsZE5FK200aVBIcUdaOTZHRTJWTHZuQ2lI?=
 =?utf-8?B?bGdiaGJYWHZtMFJHWDNwOG5BMUNhV0gxanRxaStYck9JdkF6MlRrZjI4b0xG?=
 =?utf-8?B?THRQMmxQNXZzTlZJb0p5RDNwUHhSaUFxVjNmU2tpOHlsaHV5ZjF3RVBPa21i?=
 =?utf-8?B?RFMzYmZLRktyUmtKYU14OS9iZUpqK2hVcHRXaWxwZ2YzQXI4aUpPOEFxSFVC?=
 =?utf-8?B?T0NHeVk5RC9EZkJTd3JzZ2FxUHFmQ3ZXTnh0TDYvak1nMW83Z2xJVDA4RDlZ?=
 =?utf-8?B?eUVVSHFKQ253ekNoeE9xQzBEa2NWOVNSc0htemx6WDlIa3dSdUVRenNvQTJQ?=
 =?utf-8?B?VlBiUHh5V1dPcVVEQjkvekdlU1djRnJWNjF1TFh6ZnhvY2pqTEZ6Z056RWhF?=
 =?utf-8?B?NUJkcTUwUVc4RXRzWHNpZmRnSEZmSzFlUzFiRnk5dnJwbThXbm5zM2NrUlUv?=
 =?utf-8?B?OWZCbVQ3aTdGQzRRdnorc1U0OGpRci92ejZBcmZVVTEzUkM0YWlZamVEYk9X?=
 =?utf-8?B?Z1VDRkcwdnNCVFBKYVlZMDc3NXRjcGR4em04WE9oMXVRSmt2NWxCbWZDV0tp?=
 =?utf-8?B?NU1PeHBvT3FYRlF4Uy9YSUFDQXlPWFlUSG1EVlhCS1AzNFZnNEpEYXhMMVRl?=
 =?utf-8?B?bERHL0ZWZGVpeHhnMXFpbVphdmJya0xuY3pWbFFhVERMRVlILzhVQXhpQWFk?=
 =?utf-8?B?VDNOOEMvYkpEOTFjc2VBOEtOKzA4cVIyTEdoK2wyT1pnQzgwK0x6c1JjdGZl?=
 =?utf-8?B?MytTSFdQQ3JDMVhQYnllSU81WlpGZzN1SktRV2NiZnZmSjdRSU9RQ2VGcFl5?=
 =?utf-8?B?bDI5R0RrYk1rZk8yQ3dqQUFacEk2d0YzdjM1TlB3OVV0UFFXUzBPbm00bWd1?=
 =?utf-8?B?czFlK1pTeTFFZlZZYUpHT24zQ3diZFlrS1luRUlLNHQvaGZNcnNrOGgzcWlx?=
 =?utf-8?B?NlpQam1WMmVISFU1WXVxbVZydVFHcFM0UVBjVFVtTWFEdXg4TkxkclpyZ3hS?=
 =?utf-8?B?ZGNDeTBpNS9BUGlrTDBPQzRaN3N2SGRycGwxUXlXaWMxUUdXRVMvRTUrQmN5?=
 =?utf-8?B?aVpyTDRqd21Ha1dPWVRlRHRqVWtIN1BkVW50Ymc3Q3lMenZRUmp2cWZQUCtQ?=
 =?utf-8?B?Z0NsdmZMZDAzL3FvRzR3TGRvM04zQ1h5VHdUWkVMblJrVFFJZlpNc2gyeG1x?=
 =?utf-8?B?OUpaWjNCT1UrQlQyU0pDT3VmeVdzVUJBZEttV25JT00yYkF2Z3M3R0p0eERP?=
 =?utf-8?Q?cP3HgENhq7Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTNuSklvMjQyeTdMdXVQM09FY0lXbUN5V2dPY3pOQ2N1d1N6L0g1WVh5QmxN?=
 =?utf-8?B?bTFmRGkwdlVGbitLZkQyZVBkOGEzdHJQZVVnZ3hBUThNMzZteFA2blMwN0N4?=
 =?utf-8?B?U2NqQWNpK2xEVU81bFpTeTNnb0lYUkNWUjBzc1ZBWGsvVjV1cFprRWpOU3RI?=
 =?utf-8?B?dFlyVzdxSHR5WFg3cXhFUXV3RzJjU3lmejVhQ1grdTA3enpHeFYzWFFEWUh1?=
 =?utf-8?B?WU5pQ2g5UWtjQWFYRnZndTNCRHBGMlJrd1hCS05mSjdzNFU4UklMN1pEcGtn?=
 =?utf-8?B?VC84RDhEb21sb0RLQW9IbGlRclV1QkNqaEtldzEwSVBtdnZFUVJhZVljSk1s?=
 =?utf-8?B?YWtiTlhBeHpNaU4zamZ5R0VmK3pzbVBQd1MweitrTERibG5kdG5FTFpVMVcw?=
 =?utf-8?B?YSt2YXl2TGpONE9OQmdXZkdlQitncmNNVFA2RVZNT1dQeWFwOXRaSG1INThL?=
 =?utf-8?B?QjhRbWtxTkJrbHBVRCswOUZ2eDl3eFk2KzRwNzl5RllrQnFCRG42QnZrdmdl?=
 =?utf-8?B?UG4xNjN2c3pIdnFXQVRvMXp2K0lQNFhIS0h3YkNnWTlwVFo1NVdKVWovR3Jr?=
 =?utf-8?B?M3RKRFFMazlMb3AvSzNQdkVqN3kxRldRQmNqeDJnYXdaRFFmWXQ4eEgvdElD?=
 =?utf-8?B?eUpheVkzejZsS25YZW9DNk5ObS9lbU91cFIrdTI0T2pSOHVpMmZnUlQ4MzJp?=
 =?utf-8?B?OWNNcHA3TTF6N0NlNnlxOHZLQjYwMFRhdU9GK2FCS2Q4YUtIYXBDQU5uYTBN?=
 =?utf-8?B?Wldid1F0NG5hZ0lJYmd3TmVsZWpDL2xyZ0txMHFjKzZCQWcvNy9sMHZrNUFU?=
 =?utf-8?B?Zzh2S3Q3TjVtRFNib2duSTIvK25ZVDBTUWhKVTFOZGFYM3FsOFZLcVBoaDlL?=
 =?utf-8?B?TW1oenRGT1pVcFZON3JPTGtMYU5vcHFMZnBQNCtQNUxSMVErTHdnNGF2UmNi?=
 =?utf-8?B?NzgvQW8xeWtNUkgzQlBNQUZSaWJnUWJuK2tvUW4zeFhmS1FSaGhJdDJuRkY5?=
 =?utf-8?B?MWtadW9TRElyeXBLbkxudHFsRXR1cVZGMlpscWdsRTlHQisvYzlFTWJLbGJj?=
 =?utf-8?B?VFM2WDQ1NGJhOXRScFBkTVhTRDVhTEFqcUR6dGlJdEZkNmV0RzJnUU9rYWt2?=
 =?utf-8?B?TXA1OVNUbnFZRlJQeGdUSTc4NFkraElMM25oQWZaMU9lZkplVWhSMFF4VlI5?=
 =?utf-8?B?QXVVSVdEaXBTSExwNDZGRDJvbXhtcFZybGpZZlpSeHBJZjZRa3hCVlNNZ2ZM?=
 =?utf-8?B?NmZtVDh5MUQ5NFRkS2dVZ0pld3dCbjAwYVJEYldzNEJKU1lwM2E4bCtaM3pO?=
 =?utf-8?B?T1pJQmc5Z2d4NHBaVkNrSDFQcVZsUnpiWHM3dUoyd3VwK3FUNGFlZ1NHTkp4?=
 =?utf-8?B?dU9BL3FiaEJHbjhTQVdkbzkxR2xSaGxqUTRmQVpzL0J4MTE3YTBENnF4UGtn?=
 =?utf-8?B?cC9vOXBPcCswa1F0Z2VMTitKY29OZG5LdVlCaXpycU5IVFMzQk56TkVyc1dV?=
 =?utf-8?B?L3Bac2s0eGdFYlUweThLVlB4eU1Ndlo2T29adGd5b1dYdnpVT2JSbWlvTVYy?=
 =?utf-8?B?OWVBUnZ4em9GTHV4Z3RBWHNpMjEvLzBIQWgzaURKM0lWWHU0SmIvdnRQU1BL?=
 =?utf-8?B?TWtkWEw3eWhxV3ZYSUQwREpBT3pxeXNzcjRiSE1laE1hQnB0MzNDckF4Y29u?=
 =?utf-8?B?dWZqNlZNSE1kQm9HSFl1b1BiU0pnTUorNFpjRDRlVzJpL1hBWnhjZmpmcHJv?=
 =?utf-8?B?ZEVpUVRlZDZmSmFUV0ZqaTZFRHpqbWVTbTkzc21RRnJ3dHlWRzdiUmtpdlV1?=
 =?utf-8?B?bUZpcHE3QlhBbnBjQVRBZEZmbWJNTTZNcUxBeHhIUEF2M2ozd2h4Kzk2V2cy?=
 =?utf-8?B?cjEzeHFTd21IaWxoSk1UcTdOb0RxdGk1akowbTNHNUg2ajNQaGVVNkRKdUV3?=
 =?utf-8?B?MFIzM0FTWEFybHNuQmdXc2wvNG94K2I3Y1ovWk1GUnlBQW1sdlhEQjVYUTFS?=
 =?utf-8?B?S1BwU0Y2dDRvdlo5RjBLWkp0dTB1OHZFeHZ0andDT3pFQW9hM2dBd09jaEJj?=
 =?utf-8?B?WjNHUFJJM2R1M1hLd2p0THgyMi9aVko5SEEyRkxTK2FzRU5Nbk1EQklaRmla?=
 =?utf-8?Q?nLmVc3a2J2a89XVLPNG/3AbX4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdcfb0c-c427-4711-0c08-08ddca80b55a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 07:07:10.6974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gwa4wAyz1S0XAtXWSJQSLCqKb2w3FDMQfTxlg6lhtpRaEl/Zogd8Siyb5q6rLjVT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9661
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



On 7/18/25 10:12, Michal Simek wrote:
> CONFIG_IS_ENABLED macro is covering CONFIG_POWER_DOMAIN or
> CONFIG_SPL_POWER_DOMAIN Kconfig symbols based on build target which
> simplify logic around binding power domain driver.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/firmware/firmware-zynqmp.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
> index d18ae523b6bc..e07ec3929b29 100644
> --- a/drivers/firmware/firmware-zynqmp.c
> +++ b/drivers/firmware/firmware-zynqmp.c
> @@ -500,11 +500,8 @@ static int zynqmp_firmware_bind(struct udevice *dev)
>   	if (!smc_call_handler)
>   		return -EINVAL;
>   
> -	if ((IS_ENABLED(CONFIG_XPL_BUILD) &&
> -	     IS_ENABLED(CONFIG_SPL_POWER_DOMAIN) &&
> -	     IS_ENABLED(CONFIG_ZYNQMP_POWER_DOMAIN)) ||
> -	     (!IS_ENABLED(CONFIG_XPL_BUILD) &&
> -	      IS_ENABLED(CONFIG_ZYNQMP_POWER_DOMAIN))) {
> +	if (CONFIG_IS_ENABLED(POWER_DOMAIN) &&
> +	    IS_ENABLED(CONFIG_ZYNQMP_POWER_DOMAIN)) {
>   		ret = device_bind_driver_to_node(dev, "zynqmp_power_domain",
>   						 "zynqmp_power_domain",
>   						 dev_ofnode(dev), &child);

Applied.
M

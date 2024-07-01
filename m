Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C629C2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 08:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4327088681;
	Mon,  1 Jul 2024 10:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ITfa5gCh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE3148866B; Mon,  1 Jul 2024 10:25:07 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C54488684
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 10:25:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcstcgQVH8/eh0RGRJAGae/Kk0fxFEspeXmFtda1viiGUsyNoo22Uz2DmJKvIBdU89sk+dK1o7PzABujm3+gD/PUmC55cbjyrlwytwiQmSV6v8RWlz+xRkF7p0p3c6Nl2Ps2jTMI2At1LICo7B3Lm9D227ACpA0Hx/gmtZkoz2r3XpcWXz4x0CfojXz6pYUjtVhtRu9Hcdp5hW444U+MRuNDyxNlvHNZc02lJozdmnW4xxkfnrCSwzoKRFcrW0QZ2FCX4x+/3ye90BViqxo8O2pFFIhk2wqrkvxQQ2sf5djojg/XKRc0tpV6QJayHAeHBBKQFd2X37W4AFqWRH6Z7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3gsGg4rT2yb4NZm+Lak9DTo8Vj+cmm45Qrgs9lFHQo=;
 b=AAt/B0MR0Q8a29TgXrwQNxM8R3X/dQOemuOvkX5Pxn6j+EVxNYXwJs+0XEifl/okctzBR81I+tbYGCrTOCQ6OOCmSgMncuDfjcYc/fPaIOWmDKvdmcuXtaLZMy3tLva/8IvhG/aiT2yFEt//sCwNe1kltOOGrZcGYrgENsbWUVXpi0r5O87qnnpHyU7h9XvxxE+HLiG+XVaZg+BG0ZyHWaPFXhpb3T0kbrwYp82M3UeWF7jbAx8TXhJsfY5ULtWhzOXZhqqtuWPRdpq+BsVM5faSIa5UIjYbSGqoZvqUYtFBTv/xW20H/LtOUv8JrlCxCMzNAkPDouynBHnD0X9Z4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3gsGg4rT2yb4NZm+Lak9DTo8Vj+cmm45Qrgs9lFHQo=;
 b=ITfa5gChdLlWIu8nxvcEcTh+TjeG7F/Q1mrqS9mxMhIb/uz3mdJYyLLR4tcxgmcTStIoHo5ZwP1B/3uSRAKLQckT10AMRWuCjtBu6CXgjght/arLPxL4gDYVOGh/GpHxWLaRz7mv2dQSNG5f0WKvrpdQcc+Xt+Kkz1wmSz5j0D0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AM7PR04MB7031.eurprd04.prod.outlook.com (2603:10a6:20b:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 08:25:02 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 08:25:02 +0000
Message-ID: <524b0226-aa5f-47d6-9e67-7a0ec9b142af@cherry.de>
Date: Mon, 1 Jul 2024 10:25:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drivers: bootcount: Add support for ANY filesystem
To: Vasileios Amoiridis <vassilisamir@gmail.com>, trini@konsulko.com,
 hs@denx.de, pro@denx.de
Cc: u-boot@lists.denx.de, Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
References: <20240628173543.129207-1-vassilisamir@gmail.com>
 <20240628173543.129207-2-vassilisamir@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240628173543.129207-2-vassilisamir@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0040.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::24) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AM7PR04MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc5998b-d083-412a-178f-08dc99a74ddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTJ5elhvQ0U3dm5PNHU4MzhGYWFWRmpuQkJMdVdUcUtna0o0SFhkSjMrRmVz?=
 =?utf-8?B?dmJZdUF5VTNZSExaN3pEa3hydlFxUWFjaVREbjdnVDR1N2pDYzROK0tZbWFp?=
 =?utf-8?B?L1dQM1ZTVWNOb3FSUDVBYWp2OUgyanZvYzBZZG9xZ0Z1emtlQitjU0UzTGpw?=
 =?utf-8?B?YzNheW1DaS9zWUNXUFJBZHloTCtFTy9Wb0tzUjJ4azlkV3pqMWtuTUtaWTA5?=
 =?utf-8?B?eUsrcXBLdTl1MktmTzMwSmJpMFduSnFHTWpRWFo2bGFuNUtWQlJCZThMcmJT?=
 =?utf-8?B?OW43ZzVFRmZSZVQ0bnpOQzF4UXozcytmV041TWx6azFVdHBjS0hJYUdmTHor?=
 =?utf-8?B?MXR2YXkwZmFtVmNMdE5yVHRqTVkrNnlJZko0bS9IM3ZXS0t6Wk5wWHFzSDZn?=
 =?utf-8?B?OTcranJlc2xmZDF1UjlsRTF4NjZkL2UwNmQvaElqRUhHeU5KTS8wYTl0SWxw?=
 =?utf-8?B?SGNhaE1zRDlEckZMcG5nbUR1N0E5R21LTy8xRk9mc3FiTnpvUzgwTHN1eU1B?=
 =?utf-8?B?Qk9NaU8rc1hISFJHdXdwK1d0VUsvaFBoWlRuZ09sZjY1blRWY2hqcFJjZUZT?=
 =?utf-8?B?cFV3K2djSnNnNXZRbGF2b3NNQitJeGlmUHcyZFVtZE1vZTJMamZCc0xlZ1U3?=
 =?utf-8?B?TVVldnFwd3RJY1g4TURzcjlSdHZMZ3Znck90Q2Z3SnpDQlNhMnp0YzRvZUlu?=
 =?utf-8?B?UmJrclpITVoydDVUQUh0NFVGYkRFRnNPRG1BTkZPOHFEQUlUNGtIbUZVU25m?=
 =?utf-8?B?VkhFME1HakF0M1F3d3lEeEVtZlFxYTJ3U3NQMkJUeDdYdC9kM2hVZllQZTQx?=
 =?utf-8?B?ZDVHTVRqUG5QdzVJQlorMEp1cHJyWkxPNXNWemxyQ0paOWJkOTV3RldadWx1?=
 =?utf-8?B?N3lrK3M3YlFrT2JvMGhVTDZ0VEMybE85dkpERko2djVuN1J4U1hiWFJJMjNx?=
 =?utf-8?B?OTMvT0IzKzc2OURmc3VUZXNuUCtDcHBXVlgxcCtORVpxbjdndFlYUXlQRUl0?=
 =?utf-8?B?MjBWU2hZVFh5Y3BxVDdOWUhYK0ROR1RjblBlQWNBakdtTVAwRmNPdG9jS1g3?=
 =?utf-8?B?SldzMTdNbEtVK293cm8yZlJoUU9DSzJoSlhjSnZzVmlKdzE0K1gxTW1SQ0Z1?=
 =?utf-8?B?RWprUGw3TWpEZ2ppSkw2Z0E0TGpyNThyYVBIL1FQcmZWNGV6Z2FjY2RFQkRQ?=
 =?utf-8?B?dlQ2OGI2QmxITHd1WFdXc3hRN3dOemNMVDA3U0tRbGt6bExPMWoyV0R1NDFy?=
 =?utf-8?B?aUVLc1NzcWpHQTVwdTI0NXRrNjNtUUt2RER3UldnWXQwdTAzVVBYR0NvS2dT?=
 =?utf-8?B?aFF3aWZOb3VlQWNTcnJ6dkRPU2l6MUhhdXYwbjB4Rkx3eTlVR0xvVm5FVU5s?=
 =?utf-8?B?UHIzT0R4VG1SNHV0ZmYzVlZ6Y1dMUmJTZmZabG5ReHVFajB6TXpqK3pIekw3?=
 =?utf-8?B?b0NFYSsrRkNvRWprSGx1bXdNQ2M3NWpoQnR0WGszajMrRDZzNXhwZkZqeHUw?=
 =?utf-8?B?MlhlQ2t3N3pwZXdaNTlleDZkbkpzL0R3Z00xblNDalVyOXJRT2V3TTd2WHEw?=
 =?utf-8?B?Qi96UDZCamQ0WTNLdWdkUk43cjB1VitteWFzNWs2SkVWQWpXVVZVVitRU0lE?=
 =?utf-8?B?TkE1SEhlVDI4VFhPTkR4MkpGcnRWb2JucE8wekhaUXBnQWRVcjJIcEd4dy9a?=
 =?utf-8?B?Uk1jaTRhbjBNczJpR2k5WUlQa3M0ZUpnVnhqNVJuZG9sT2c4RmdpM2hJUFl6?=
 =?utf-8?B?UWV3SlJtRmZCbnpqa1JvbEZpbWRuaFkrWjlYR0NiRFJLUTh3L1JjRU1KY0lF?=
 =?utf-8?B?SGtZMWhFem1CWEc1dm1uQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk5GRVdhenZJclVKaWZia3NnTUk3ZG5vaWRoNGhzcGMxc3A4S3V6eGxSVFhx?=
 =?utf-8?B?eHFXSXBYQ3BmMndWNGhpRkpzMjgzbFR5M3RKeUl4bGlhckJUaE9iWUhRMklw?=
 =?utf-8?B?REN2RENjR2UxS250amM2NXc4RFN6Qm5QSGZCUXNaS3FKOStQbytQbzgrSFpx?=
 =?utf-8?B?a085R05zMlBCMTAxZms5RHJldFdPK0F2SlBrWjZKcjBBTnlEOFNuOHpXaUc3?=
 =?utf-8?B?WlJ6UkU0MEcxNW1oWHo1L3hiZ2ZGejNKM0NZV2tuVUZ3VW85Y1RSU0pEVlZN?=
 =?utf-8?B?dkxMbkxxTFlTUURkT093OExJRm1EK01BWFlNQkJpbEVJaVNGZUtWM050Wjc4?=
 =?utf-8?B?NEhCY3pLWFhDV1p6WnJISUtMeVJ4dHB1QWVpVWc2eU12U1FXcjhmU2xvWU5B?=
 =?utf-8?B?ckFYR2VzdGV6QWxuR20zZ3A2Rm1kd3gzZVh5S01KdUM3cnNFS1JpbXdDUGts?=
 =?utf-8?B?R1NGZnlTZ2lWU1VUQkRlNmdmMkZ2Y0Nsb3hBcC9uSXUzTnRDTDNMTmtNV0hL?=
 =?utf-8?B?QmVsU0hwV0FmVExRb09Pek94d3prN3EzREJaU3dPY2JIR0xZNTNWcStXTVBW?=
 =?utf-8?B?TUxIdlFoMjB3UU9QZFhZaVV1TkVHN1RnOVpKeDc2M1VjZjUyblVRM3lxamR4?=
 =?utf-8?B?MStLczFDNTlUcUZMZnh1SzRyQ2x1VjExdEExM1JGUitUaitSWk9jSTRSeTFE?=
 =?utf-8?B?TldDY3dHcWZ5RkR2OW1mVVRqWXgrTXYzdGdnTDk1b3ZqM1k0V1V6SDJIUkpW?=
 =?utf-8?B?UEM2UExjengvRlI0N3VxU2ZYOTkxZ29sRFlJSCs4cExYWkthTi92aUF2N0Fh?=
 =?utf-8?B?U3FoYzB6aDROZC9jNnlDWUVGSXFyeVRNSVJrR2dhcWp2YTRBb2FFQkM3L0R2?=
 =?utf-8?B?SkRIWVFGQmdhblowS3d2M1dVcUJCRk4vcWFwQTdwUERXUzdqQUhkU21nRFpQ?=
 =?utf-8?B?NGdsdFF6N0tLN2prbC8xdmNDZ3JkVXBvd215ekd2WWVwVEtGRXIweXN0MjFW?=
 =?utf-8?B?bVZNa2l4R2dQZHc0OTVsWXdjYmlucU80WTFUb1FaSVE5clpLWkl2Rnl3eGdv?=
 =?utf-8?B?NEZUeWpOZGpaTlg5N0h6MDZISkV0aDhoQ2JaZ0lTMXBGVVl3UWh5ZmNkQW1r?=
 =?utf-8?B?Vk9mZk9uNjRKcXRZdkNrTDMwV1NvZzhhdUw2MWhIOThUT3cxQlpQWE5FZml1?=
 =?utf-8?B?SEtKa0F3NmxkcktiWTlxQXVjWXdwK3Q3dEVLaTljemRtQU04bFo0N0lEUy94?=
 =?utf-8?B?bFhWNDY2RzV5Tldlekx3aU5ITUhUMHNyWTIyWXdDZXVYSExWZEp4SU9mSmNH?=
 =?utf-8?B?ZWJsbWlSSTkyRkYrMHBOTGlFN0NndTM2M1JUZjBZL04xbHpqRFpjT3dZUTVU?=
 =?utf-8?B?UUtiMmtMWmtTbFIvUVJSKytBaTg1VkRrOXM3VTZqbUV3TVpDNkhzOUY1YVFu?=
 =?utf-8?B?cCszUGwyWUprSnBhQTNkRDhiMUNUY0xzNU9GVTkwcTJ3QmVoVmlRbXdaOU9P?=
 =?utf-8?B?bHBnZGR5UW1kRGhuUmRMQnhZd3paMjg2ckY4Z1RPOU40YlpCOVhMU1hPOVAx?=
 =?utf-8?B?aFpjRHdnNTFjY0l2aThWM1dmeVo2VE9Wa0NRdEtBTjlDcFQ3VDI1bkZkSnl2?=
 =?utf-8?B?aFhTWThFN25pSkhVYVRsNmp5RzBPSWdtM081UUVHbDdHdDJ2TVNVN1BWWVh1?=
 =?utf-8?B?WEF4SlhSbWYvc1dsZTl3RXcvMjIxUUlFdWM3UDB0NXRiaUJWMVEzZ3pCekta?=
 =?utf-8?B?ejRTd0Vpc3ZpekloMUE1VzJSemlHbFQ0QnpUaDgwdkJwL0grcmJucEhKSHJL?=
 =?utf-8?B?WnJYOXF4VWV0SUxZTnhHdzBrTUNTZVVUdzZhNDFvTE50cTUrR0g4NHZKNGYz?=
 =?utf-8?B?bnRzempQbjc1NEROTmROWWt6ZkYvUFVhSFZvQXpXNVhlWUdxRVRpQ1hIajdZ?=
 =?utf-8?B?Mlh6Nkg5cXlLZThDUDdaVFJ4d3dwcE95QWd4d2FPdjNDaCs0M29Ob3V0N1pY?=
 =?utf-8?B?SWU4dHFubkFzNlBuZkVRdGFCYmhkenNNMENFR2Fza0o3blZuVi83ZjY4M2hL?=
 =?utf-8?B?QStaYmdSMWtkWVRXRE9ZMHRmaDJ0QnlHL0tKbEdRQ0dERlpFYkRLTWUxVTJQ?=
 =?utf-8?B?VXFrUXRsNFY4SlBwT0NYOWRYcXhyelZtSms2VzlweEZodE5JU0N2TUtUbm1X?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc5998b-d083-412a-178f-08dc99a74ddb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 08:25:02.5915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tywe4IBw9CqE/PYZOmqAr3tX+W69nuYg2hTvtuI2p7/Ar6rxF8eBfqUhfuhx9xSsOVJc9qlYmaEaINSmf9B/UouTRfrPttsYzEGLu4fnZfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7031
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

Hi Vasileios,

On 6/28/24 7:35 PM, Vasileios Amoiridis wrote:
> Add support to save boot count variable in ANY filesystem. Tested with
> FAT and EXT.
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Heiko Schocher <hs@denx.de>
> Reviewed-by: Philip Oberfichtner <pro@denx.de>
> Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> ---
>   doc/README.bootcount                          | 12 +++----
>   drivers/bootcount/Kconfig                     | 36 +++++++++----------
>   drivers/bootcount/Makefile                    |  2 +-
>   .../{bootcount_ext.c => bootcount_fs.c}       | 12 +++----
>   4 files changed, 31 insertions(+), 31 deletions(-)
>   rename drivers/bootcount/{bootcount_ext.c => bootcount_fs.c} (81%)
> 
> diff --git a/doc/README.bootcount b/doc/README.bootcount
> index f6c5f82f98..0f4ffb6828 100644
> --- a/doc/README.bootcount
> +++ b/doc/README.bootcount
> @@ -23,15 +23,15 @@ It is the responsibility of some application code (typically a Linux
>   application) to reset the variable "bootcount" to 0 when the system booted
>   successfully, thus allowing for more boot cycles.
>   
> -CONFIG_BOOTCOUNT_EXT
> +CONFIG_BOOTCOUNT_FS
>   --------------------
>   
> -This adds support for maintaining boot count in a file on an EXT filesystem.
> -The file to use is defined by:
> +This adds support for maintaining boot count in a file on a filesystem.
> +Supported filesystems are FAT and EXT. The file to use is defined by:
>   
> -CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE
> -CONFIG_SYS_BOOTCOUNT_EXT_DEVPART
> -CONFIG_SYS_BOOTCOUNT_EXT_NAME
> +CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
> +CONFIG_SYS_BOOTCOUNT_FS_DEVPART
> +CONFIG_SYS_BOOTCOUNT_FS_NAME
>   
>   The format of the file is:
>   
> diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
> index 3c56253b1e..fbf3c56b41 100644
> --- a/drivers/bootcount/Kconfig
> +++ b/drivers/bootcount/Kconfig
> @@ -25,13 +25,13 @@ config BOOTCOUNT_GENERIC
>   	    Set to the address where the bootcount and bootcount magic
>   	    will be stored.
>   
> -config BOOTCOUNT_EXT
> -	bool "Boot counter on EXT filesystem"
> -	depends on FS_EXT4
> -	select EXT4_WRITE
> +config BOOTCOUNT_FS
> +	bool "Boot counter on a filesystem"
>   	help
> -	  Add support for maintaining boot count in a file on an EXT
> -	  filesystem.
> +	  Add support for maintaining boot count in a file on a filesystem.
> +	  This requires that you have enabled write support for the filesystem
> +	  that you will be used by the partition that you configure this feature
> +	  for.
>   

The first "you" shouldn't be here. This could be modified when merged by 
the maintainer if they feel like it. We have many typos in different 
places and this help text is understandable with the typo/mistake, so 
**I** wouldn't send a new version just for that.

Looks good to me otherwise.
Cheers,
Quentin

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2855CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 09:24:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 143D880422;
	Mon, 27 Oct 2025 10:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="jRYRXUDY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AAE582A9E; Mon, 27 Oct 2025 10:24:49 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0720880107
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 10:24:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngw8pkCpQusR82xlyJlLtxIFBeMr1JekwA0mYAYOtzKmG7c1t3+ddwgHRLAA7Emq77YbBwLj2f9tgV5ZLNwEMgYxPT9yAn2CXXQKMT2NsDl5U3rzjeJv0Rdwb2fuG0wRzfXfRj8ozYdgQNR1ilDF7DVKTyxVrPzcm9568y+G04nGh+AdUYjBiZ5RyVyodVxU80O3gxxtgIZuT2mbroVl4zaYJ6BIx9QpohTKWm1XwOtIS+ZIAKZwXA3wHSTWoLOTjxuEJwZY7Uc4iMkZgjZITKYktL/cZucdPxDfRqWgDVhGI1kkm6DEX59xgqhZTUJiosksVeT1jbyHwzoysIm3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sh5gPuF7+YWMJ5w7BrOnEdswW3nhb2CsCo2f8hD58Os=;
 b=dhlBQ7C1zymfVw15FR99ooQN+GZD2UfkdgqtLvOn8xvJ1KgZgu/4Ye3TkdZ877L1AXW49YJOcejE+FJ5NoeXZrc+VWM+N9nkVPaZOxqHDg1Mw9QWWOERfFoRrx+BD15sMmM51N2Gk18wqvf8rLX2hIHLF9R4HQxqpEyTeOKOtn3W5QVGtYQXSk3Dh5O6OMAMqYdeR8HiHp5fH1TitGIBKGLIeF3ZoQLjTxpMd+JyVkYZaN2JMXm33GElzj+cPaP1Voz9ligmTKLumkDaF5zvZQhVfIDRRnxLC8IJdilR97J59FGKt2F+kTU3uoUSUbYaj3mco6bXpHcwz4AUK29SiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sh5gPuF7+YWMJ5w7BrOnEdswW3nhb2CsCo2f8hD58Os=;
 b=jRYRXUDYr4ZLtlb8tGP07JLs7keqTuQt9mDwD3ReLgObx3ILCDryaHdtIklbfB3zAjssAvTXqGQPc6h/+ga8Sk/h3/S/gLqJUC7pM5cOQmurCT9vT046ewisOwdLKez/8Vyew+sfSsOF8wnDfDN2rpo1FW2bGDVejbx/q6/e6gc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB8139.eurprd04.prod.outlook.com (2603:10a6:10:248::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Mon, 27 Oct
 2025 09:24:44 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 09:24:44 +0000
Message-ID: <1ea31172-bf9a-4f7a-81e9-287772417241@cherry.de>
Date: Mon, 27 Oct 2025 10:24:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] doc: usage: Use glob for all commands
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251024172209.2418554-1-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251024172209.2418554-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: 57261008-9952-4c70-1a1c-08de153aa9c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTAyNE9ST1RadEo1TnZPTEdxYUFKT0xuR0N5SnJCMnlIQ2NOUmVqRm5HQUEv?=
 =?utf-8?B?SHlWTDZmdjA1Yy8vR2xFWVN1YS9TTE9uOEtRVGlBOGU2ZFdHaGJQLzlqOU5j?=
 =?utf-8?B?T3hXNTdFRy9yVjhxck9VcE5iRW5RV2FJUVlOd2NXTVBsdDkraXdHcVMwblFX?=
 =?utf-8?B?ZWkvRU9nVDBsNXBqclhqNGdwejBsZk1Mb1ZyOXFnUXpRb1RlMDN0WmNodXd1?=
 =?utf-8?B?MFE5d0V1cE83TndzNzl0d2dsbjJCSnhEd2EyREFXNzBBMVlCN20zbVRhUElM?=
 =?utf-8?B?Q0RVbzQ4MU8wc3FPOFA4Ni9yc3A1ejdJdnBha04xY2VVVmd2cFFhYTFzUDNB?=
 =?utf-8?B?SmFxR0w4dytzYndqLyszWHo0T1lNYjdFN0hkaGFoNmJvY2JmWjNXNGNjcGYv?=
 =?utf-8?B?VWFlMHJqUDkrNkp5SzB6T2NwN2IrempkQTF3dCtRb2dvd3NQTEhSQmFOUFNW?=
 =?utf-8?B?REV2SEw0S0Z1N3hZdHVJd3RhZXI2akc1b0FDa0xjclNpdGM5T3VQRjVML09V?=
 =?utf-8?B?aFpRVHVRWkU5cS8yYXZNRGtVTUlNY3NvS3RiOFk5aDRSRmJSc2NZa3FJK2Z2?=
 =?utf-8?B?aE9BOUdwd0JYa0ZOdnA3cW5EYjJ1eUcyMXVpcEM1a2M0ZjZyMXRpeHJISTls?=
 =?utf-8?B?K2RUSWRmNjVnMmtuUE01ZnBQT2szUGNQZFBVMmZBallGRHBtdWp6Sk1uT1BZ?=
 =?utf-8?B?Sm9SQ0ljK2g2U2xodWNxNTRKOWtxbXhxWXMwNE0yY3pERzVvTEorckRIU3Jp?=
 =?utf-8?B?UnFVMUd6aFdlVzVEWTBCZnFWZnZvWU1uQjVSL2F1NmdCcmNmNW90NEhlMUdK?=
 =?utf-8?B?bzNHK1V0TlZ1aE1nc3BYTE9sa0ZaZm5HWmNrbEtHQll1dlpVeUE2amUxaTB3?=
 =?utf-8?B?SWtDSytSOG1hVU8vdnJtbG9EMTgyZWt1SGwrRDUycEROVFhZZy9PTFpROS84?=
 =?utf-8?B?VXdrNUk5QkhDL1BGanBRZWdtK2xudndDSk9LSEFnTi9Qc01pN29DeVd5TGIy?=
 =?utf-8?B?emFEdnRUbCtoTVI0T2g2Zkl2YmNMQWtUdkVaZEh5V2sxS1FsMDJ3aWRIbG1q?=
 =?utf-8?B?N3lnOFJ0aG56NlRRWGp3VHo3L0dETGd1NUJHNnNWVVZxak5lZ1U5VkhERzRG?=
 =?utf-8?B?ZXpEV0xxNWE0b0xoa0t2MnRjUlBkc2JpalhWR1lvYklVQXNzU1RwZ2twaTN1?=
 =?utf-8?B?RERzM2pnaTBSdmtFR2tJcW5NNFE4cGhkZFBSeXRIRnhQVmZGMm9BWlk2dkJ5?=
 =?utf-8?B?TlRsd1JDYjF0S1VoRzBUeHhsaVJqMTVOdXZiNzlIL0d2cDlTQm9YVjNIOGVk?=
 =?utf-8?B?dzJSWTJsV1FGQTRlSjFwTTA5TkppeldFNFNQelBMOW55UGVrL3F0V2RmblZG?=
 =?utf-8?B?Mjd0WGZQNFpDUUNHR0JhR1daM3MyS2FaZnJSeVRTOTFDZWl5dWxPamIvbXRa?=
 =?utf-8?B?dys2SHdnVjRFYlhWZ0d5S1B6a2k1TkRtSTFQS3REanZIdDdFRXg4MU9yd2Va?=
 =?utf-8?B?aEw0OGw2OGFRRHhkbUVmRGxrVWxEdjhERXV2dEJCWlNhTDQ2N1RoNFhmUmFV?=
 =?utf-8?B?Rk55aVU0TmpFLzI2SzlMVEV1T1gzcGE4VVkreDF0ZmRTTnFRb3ozRnNESzJM?=
 =?utf-8?B?UkMySDRqVHN5ZCtpNDBzU3Rzamh0dHBqNEZRbEIvUnFGbDd6czB6NGlTZ2Uz?=
 =?utf-8?B?b0NvZ2x3L0h3ckNySkZUSDdiVnNrTGQ1bnJmMHl0Q2VSZVdNQUtNSDRkbEQ0?=
 =?utf-8?B?VXE0SEM0RnRlRXFYVjZ5YlovQktmL1Y0MllmMVZUc2NuRzRWMXc5enRvL2V4?=
 =?utf-8?B?dDcrN2QwUStFWlJ0eVNPUEdxWUV6Y2FrcThMd3VhYXhZQmkxdTN2cnFLbHdo?=
 =?utf-8?B?Tkd1TTRaa1lYWnVkS3JGT0phaEd0TnRLRWJyOFQ0Qm96a1FrK0xUSWt6YUpX?=
 =?utf-8?Q?vyoGar+dSY/RjlXg0YpA+4kr/UlvFSn1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWg3QVV3SGxjNmFtL1c0R0RPRWxqUHBLSEVRWEkzY2plV0IwQW5oUVJTVGQ4?=
 =?utf-8?B?eXlobzkxTEY4NmJVMVlmZ0RLdEZBb2poWm5CUU5wbVc1ZFlITm5xK1JPbUdE?=
 =?utf-8?B?aC9RM3F2WFpqQml5WlVrbDRDUkhlTHRNcmJGb0F4SHVHYTVaV1gvSldNV1pu?=
 =?utf-8?B?SXdUemdsZGc2SThFQXROenhZbG1wdWxqbE9CMVlncXlLSGJjc1FjRUQvTXdF?=
 =?utf-8?B?dy9VSy9oWmRXT3M1ZnBqMHdmQVUwSU5Ra014OGRzRTNaMkRFeVkzUjQ3ZjBG?=
 =?utf-8?B?eDZBeDV6VHhCZDNhTDF1eFFsaUNENFZ3SWYycUc3dGNkRWQ5dDYwS3RSK0M4?=
 =?utf-8?B?OXA0VHVRMGhQL2NnOUpRcGxNUnoveTBXbElwTnFyakx2OUpHR1NNUVpHSHZn?=
 =?utf-8?B?a1J1bkVVdUd6NHBJL1RMMkhXUDRlZ0UyYTRock4xc2NUK2JZd0lvQ2huajh5?=
 =?utf-8?B?RWl4NjNkZGV0dE1ybHpzVUtUdllFUjUzV2pQU2NXcTY5RlV1NWdlbS9VMmEy?=
 =?utf-8?B?Vzg2TFBMbTIvVi9uS2tqSVorTTZLVUlhMTVZa0R6enNUMWl0M3k1YmkzYVJp?=
 =?utf-8?B?VGlrbDJPQ2Rpd0Myc2lvQ2VHQjIxWlo3VWY0ODdrSC95VnhvV3N2V1hLbmcw?=
 =?utf-8?B?SmFrbGVYdXVIZVM4Tm9ReU9vVTFnOUdHc0dVOHNvTGZpZFB3TjNCVDlYelVl?=
 =?utf-8?B?YWM0MC9LZGRHZzR1RDNyYjV4Q2tzcUt1dVBHd2dNZHpHYVVkSTRmMTcxSkpw?=
 =?utf-8?B?aVBsWC9OWlMxUWY4UDBvOXNoS2NyUmpwL3BMTEwwZjNvTHUzaGhFNW9xVTJw?=
 =?utf-8?B?MVEzQ081MXlDb2dCblZXNEN5Njl3WVM3dDRCc3B5citqZnJ5S1pESlNwaW5J?=
 =?utf-8?B?dDdNV292L1hiQ3NtL1lsR1ZFRmRzSlFlUndaYjdaZ3VaZVRkYlQyVmMydU80?=
 =?utf-8?B?LzBUU25kWUMrN3pOVVJPU3FkZjNUYzZKNEszZGhoR2grSUlFYWtoNUN0MHkv?=
 =?utf-8?B?bzYwb3N3b09BUGprdHY0VmxsRWNTWjRwVHh5R3RKT0lFeHI1SUJocTJZZVNx?=
 =?utf-8?B?alVIWnFRTUdCVXh3d2FBS3VmRVROVm1hWTJCTkY3azUxNmE3Umtka0RGMDlR?=
 =?utf-8?B?WjlKWCtzbTROamt6cmxFUTE0Vk5ZMjBnWkZia3dIM0pjY0dWam5hUXVwa0I2?=
 =?utf-8?B?ZjEyS0liVFNHd1AwdG5wcWhPSWJHdDRHTkJKTUlaL3VRNzdMUVNnS01rak1L?=
 =?utf-8?B?V2pKN01kM3JLNEd3L3YvK3RlZ09uc3VCemIxd0hXdERTWEZ4MW5OcjI1eHg5?=
 =?utf-8?B?bm5OekZEbHhLNjNlaXFjWERCK2s3Ny9mR2dRNndMejdnZmVTT2dNbHJ3S1pk?=
 =?utf-8?B?ZWVkMmd2SWczYzlrby92Rk9wWlFTZmkvNS8rYlI4Vzl2amQ2SEtTYVErbEY2?=
 =?utf-8?B?OW5PaU5RWGgxR3hDU1hsaWJpM0wwZHRSMmo3YUNFdG0xTmllQW5RbU5HNWxx?=
 =?utf-8?B?VEVQRkNISE1LNkN4RDB0azFmeG9LeXNqakp5T1o4UzB5WUtUTlpuOTJOMFcr?=
 =?utf-8?B?YjBtYTlsd0JEOXRMNUxab0FRbFg5c1ZXL1k0VDhKaTY5enZSalVxYTY1bmxw?=
 =?utf-8?B?aVpYaDRkSjh3TVRhYUc5alY1S1pnMGlFZ3paT1cvUjdwcnRLM0xvNm94Q0w4?=
 =?utf-8?B?V3FxY0FYdzlpL0tEOElsbnZjYzNwWGJxUVdJc2pLaE9uMVFtcFVEZFNGSDhm?=
 =?utf-8?B?VExYY0ZGcis0WWwzZnpEdkpkUzc0M3VkTTc4TmJleXBRaWoraE83ZEpLZHlL?=
 =?utf-8?B?a2xVS0o2cG14QXhrZ09salJ3alNJT0E3N1h2aE1ZYVpCUjBRd2tjVHdqV3Nx?=
 =?utf-8?B?VGl1UXljcjdwdmUxTG5aUG5TN0lROXVqbjRpU3crUEtCK00xOFA2NUJGRTBX?=
 =?utf-8?B?b1ZyQU5CeDhOWllVODdraXpnb0EySHV2RnBtcUlDdnF1U1NNREhsUmFqYzJP?=
 =?utf-8?B?VnlLQ1AzWUw1a0tIT2kxY3E3ZUo1d3FIRm1mVDAwNGFXVFVUVU8rbEV6QkRL?=
 =?utf-8?B?SmtpYi93SzY3dTBvZnY3WEJIVlhNYThXV2pxbjRwSUhycU8zaEp3NTBFaVJ3?=
 =?utf-8?B?YjRWMkRrRmo2QzBETDFqcGxYVE1lUGRqc3M5akc0Y0dyemdyYmdVRk5zam9r?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 57261008-9952-4c70-1a1c-08de153aa9c2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 09:24:44.0444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zq0hW292nUKp1/05Y/K+EkTfd3MKg/b43yXndqKW9WV+6Ao1fAcppPmwQm3jHak8SRdadnylkZ6jd6oIsjY2TePbOsvyAm3bYkRYYrE/HYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8139
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

Hi Tom,

On 10/24/25 7:22 PM, Tom Rini wrote:
> Make use of the glob syntax to automatically include all command
> documents.
> 

Great idea.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

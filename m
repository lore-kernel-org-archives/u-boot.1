Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11862C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 12:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AE7C884FC;
	Thu, 27 Jun 2024 14:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UlVxkmiv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC286880A5; Thu, 27 Jun 2024 14:42:20 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20711.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEAE688247
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 14:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbUKmyBVcgKgKd8ykgvvZjOzq8Gv/6i3z2fcgjTl+C5as6M0s26IuhpMQJA6r9Eyg/J0qOO7r2R0AHy2AcNmH4Kvc5N/BAMGxW+bxSEnRfC0cyj3rsq+Q4khPH5ZTY6hS73mY09akh8Ve54Yv4dt5OShJFz6/KKFsmk3d76wspn+ChUS4ueBXN3FHEmt1NnFLBbwaS9IVu2+8KeeHvxlxTqkPMjzvCaXiA2vyJ6GffqcXX8AdNofXpvfVC/fvujNQGonWlRkPfrRgW+KKmFPGbNoL0WsisRQHuimGU2r0Y1kc2wHf52RRgaivKl5pbPPKFDYMk+etK//SM4VGfSinQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xJFZkEzuOJgqKFExMHl/q7l5AppiqT94RztqyLkeHs=;
 b=Jwc65UsTbsLsIYX3wvDeTKmzfmlM3eAB9r8wcirXZDJfPZjBluatFqUIuMucmJUbyIsrjwP4mzvxvTrilyj2/H/C4OZLHvtnF+CDVs3yvWwsgVRi/fyUbL2Q2suyvXFB5rAlP2BYGNJ2lcGGQJlHzI4jJk7Kf/fX7u5edU5AFsaaAYA1MBZaZEtQTKvpyaDlQFnH8d3oAwUkCCVSStNoRf472m7ReMtgCcSx6w7CBEQg9gfg+RKRXhvuVk5o+kqD1r4CzQi5/jZ0dL8Tr03K/5yV9lebM1NkMLmkDvxArKA8Myj+7F2wNIqTQGuWbyID64MXkftCNx7Rr3+vOtvXLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xJFZkEzuOJgqKFExMHl/q7l5AppiqT94RztqyLkeHs=;
 b=UlVxkmivJjXrbKaYwweyiJRCZWNVtigZHrAnY58IWfysVUfBZG1pdglaJSxT03VzkANX8KMqCS9Xr7gyIpYU9V7KxCcMqx8r8np5jIUJR1tiwv7ueIrtWBY8RMxP4xvZ1Hx/Ce/F3gmjmMqI6ZpFszKDd8PjXNr4deJarf96FB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PA4PR04MB7757.eurprd04.prod.outlook.com (2603:10a6:102:b8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 12:42:16 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 12:42:16 +0000
Message-ID: <d31b4e88-a59c-4ec7-aa05-1293ab8139d9@cherry.de>
Date: Thu, 27 Jun 2024 14:42:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spl: fit: List DTOs applied by SPL in U-Boot control DT
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
References: <20240626235857.272264-1-marex@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240626235857.272264-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0017.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::17) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PA4PR04MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d096c37-26f3-4fe0-9ac8-08dc96a69379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGp5dURGRURqMkZTZXA2eE1tNFdKL3pYZVFiNDJVQU14cWFjNnBmWHNFc2pu?=
 =?utf-8?B?WDFlVmd3ZC96ajl4cU9IUVhIaUw0Qk5jeElRMDJHOENGWVlJNzMyamlucHlB?=
 =?utf-8?B?eEEzTVJDQitzTzd4bFg1SEVzeXgxQnVHNFlMMHoyNlphQWcxZU84OE5uWXl1?=
 =?utf-8?B?NE5GYW9USDIwRWN3aVVjZkFGd1o4T2EvQmVRb1dRd2JLeUlFWmQ3RVpQa2pr?=
 =?utf-8?B?ODFlaUdwOGxYSzR0T3VSRmNieDVEZFBibWhXNlRTaEcwaUNLRlp5aEsxaEtX?=
 =?utf-8?B?ci83dTAvTXZBRllxUVJqeDRwaG9mL1NQc2xWbEVQMFVuOUJmdUp3VnRISG16?=
 =?utf-8?B?cWlRRkJCYko1bmdDeXAzUUN1Ymw4c1NjZ0Exc0c0L2JWaE9aT1lnaVV1RlRZ?=
 =?utf-8?B?NmlxZDgzU2syUlpCVWhUanlqdE9Ta3lVNHdiMkNnRDlCUTc0MFEvbUE5eXJo?=
 =?utf-8?B?cmFDdDgrWkdzWkpLWk5YL1ZIaXN4Si9rRmNSRVlXVjRNeDlWazUxcUJiL0xp?=
 =?utf-8?B?MWprbENVV0VmRk9BL05zbnhMRUIzU2NQTVRCdHM3M1FIclVxclRLZE5UODhJ?=
 =?utf-8?B?akdpYWEvdXVoL3ZPMUZvV05NQTNLZzEvRXphRmJSc3E1VTB6ZjJNRXZtbmxz?=
 =?utf-8?B?ZlF2MUdjUjdaNlJQM1Zkc1lUcHRhaUM3M0hLb0UydFNua2NDemdCODVnNTFN?=
 =?utf-8?B?bGFvcnltSHpoVFZuUU5lY1dFbWdKVnBxdlZUZXZQZm9SRFpaemZZcGZMZk1t?=
 =?utf-8?B?TzBpNmFoQi91NlE2YlQ2S1ZXa0FVaTV6NDNXNEFPRVkxTFM2clV6VEE2MFVO?=
 =?utf-8?B?WE01cVZGZ0s5Ym5DUktXUkNUeVJ0K2FsQ2w0alZEak8rTWcrL1FGV3VLV09v?=
 =?utf-8?B?YWhaYjZhUmZNNFFOS1ROUFlJVEV3TmgzRURZcEZmQ0NLS0NhZWtTRHpqVW9l?=
 =?utf-8?B?dVdYbXg5Z3pNTmExbVdVc1cyWnNvb1JHZWhlbUVpTlpUbmg4UVNaa0JnQUda?=
 =?utf-8?B?ZU9lSnJZdmxna3hZNXY4SlUrbkpybmxJdnQwZkhXMW1PS2VJZEFRUlUrelpQ?=
 =?utf-8?B?WWgwblJaeWtScEdMdlJPbkJheXc3MDR2NXlPa0haUm93TVIvdFpNeUZqWWJ6?=
 =?utf-8?B?dUZva1dsaE94VzgwelhPcmdlTWpXY05nT09MUjZGTXpMV2hSaG5XbEFVc1BB?=
 =?utf-8?B?NHhXUndWTXZodnRwOUxWUERjSDZ5dTgraDFnUnd1ZlpiamZrWHd1cTRpSDB3?=
 =?utf-8?B?VmJ0L0EyTHZzK0VIZ0phR3pYTFJlek8vR0VVdmpoMmF6NHBWNVN0eXRjMnlF?=
 =?utf-8?B?clVnTW1HZk1ZeWFrUG1TcGROaVpJY1EvUW1TNWNUcUpvRFNNM1pKck9NSWN2?=
 =?utf-8?B?Z1NLYXdmKzJGRVE4R2lNMnRrNTczeitIclR2Wi9GeCthbUhXL0VlYjR5eXRM?=
 =?utf-8?B?TkFDNWNMWXJNRXB4U09PS3BjWmRNdGZRaUtRSUxlS0JybjFlRlRKVWR1V2Za?=
 =?utf-8?B?RStyd3NFUjA4cE82T29IWnZRK0NhbEdSOFVzbG9SZFRFeVRjMnR4NDd0NlQr?=
 =?utf-8?B?K0VQMjdacGtOaUFsYnk2NUZPeU5CejQ1c2dGYUc3WldxV2dzNXZSYlJWMWVO?=
 =?utf-8?B?eVZBVEdrMU5lSGRkNm1BSE5sUTF2ek9ZWWh3SWlta2l3SktJUWJ1VHE4MlVP?=
 =?utf-8?B?Zk5LNTRjMjVOQTVndWs0bm53MTVYcTQ2TmFoYzlmWTFZQTRuU1R0R2sxSWpv?=
 =?utf-8?B?eUZUbzBNYkxTZWdCRWJnb0M5ZWdZMjlPSmkxbkVnZHd3bVkvb2FNV3BYUDlE?=
 =?utf-8?B?Nmh1cElYcUM3L1JyTEZ5QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2xWcmJKMDJZTW9sT2RyYzFpZVYxSHhqTWFiRmRsSUY2SjhwZWRXZ3MyT0Fh?=
 =?utf-8?B?MTM0V2tnWnZSWUkvQmhPVHpRdm9rWlI3NVNCbmpJUGVJZzNXQkYvUnhJY2hr?=
 =?utf-8?B?TEh3WHlDam52M0pSMVFSc2xqQ0dpdUVQcjdOV2R6YnpqYmFZTzZIdGdGa1FM?=
 =?utf-8?B?TXNteHNJT1dDSEpJWjBvL2lxbVBwd3d4NEc5NEUyQVJKQitVQS9yem8wMms3?=
 =?utf-8?B?MnNnbE15RjNVL0JIUStMVlFtb1ljaG5wQ2d1dXZnTTk4R2hiSGlabGNmZFV1?=
 =?utf-8?B?cVl0S0wyT0Z6eHZjdFJBMzI3dmRqa1hqV3ArK0dUVk54a3JsMFpsWXBSR2VY?=
 =?utf-8?B?L1Q1RDNhdDhJTkM4VDNGcHlSWEFIMTBHVHNpa3piaDE0cmNGRzFEM2lpdCtR?=
 =?utf-8?B?SXMxaHZadnNUc3JVa1VNR2dYV0NsUk15VGdXaGM0SHp3RHRKeUhDUlgwcFdm?=
 =?utf-8?B?YmtCdUlkSE9QdTBwYkUwUkhJbjg2MlY3aGkzR050ZTdDV1djMHBwSkVZZWxq?=
 =?utf-8?B?S0VieWQ0SFEvK25xTDczMEJmbFRjMm1NOXFUS1BBSGFQNlgyM0JLRVY1cUVm?=
 =?utf-8?B?REV5dHM2eDFxa1NPM0Rxd0JBbjFRMmtxQURPcDBseWtkL1ZLcnd5Y0lMRnVV?=
 =?utf-8?B?Y2JPbmFOREpWd0VwMElJejdrQWNNTDQ3UmZFOWM4dDR0TnVFdEVPbHc2cWlP?=
 =?utf-8?B?YmxpcVp2anI2UjdvZGwwMW1oODA2a1h1dklueDdqYTdpNitVb2M1SnpzODlK?=
 =?utf-8?B?Z1JiSU1ubjBMbGpSSVhDcVI5RURUNjJmNWR6OWVlWklzT3ZJY0VCeDJBN04x?=
 =?utf-8?B?UXBhNU9OMWJOV2QrMENpM3VYYzhmS29aWFBWaFhPTGxHbmhhNHJGMEhPV2N0?=
 =?utf-8?B?dnVyYkJOMWp5REdrSTdKT2lDdHVmYWRRS3RlWGxZMFY1UlNHZnYvUWVoZnZv?=
 =?utf-8?B?OVpraGdGUmpxS01HamM1NE1YbXZ6cWptbEdYY29vSUlpdTBsR2grNkVKUHh0?=
 =?utf-8?B?S0Z1TFVTemtpSVBQUnRYL015K0VCWW9waDBNNEV5QnE1MW5ueVJYOXVEWFVL?=
 =?utf-8?B?Rm5RVWdlUURVbXZuZGxjc1pCZDRBY2NVMEc0QWZkVUhTdGM3QVRuVmloTjFE?=
 =?utf-8?B?cmNLM2NGVkg4U1Y3ZFB4aEg4ejhjRHpqOXE4T3dFL085andQaXAwZERMZWcv?=
 =?utf-8?B?QlhVYitEVnhRNU5OUnlkMmVaWURMbVF3WGhYZFp6emxYbnpXV1JXZnVURnY4?=
 =?utf-8?B?YzRvVGpKUXdxZlJjSXMzQkUyNjFtZkx1YVN2Q3cxZ1FCRkZpZHl2dDBVU1RH?=
 =?utf-8?B?Q3p2dUJBZjgxV0RRd0V6RDBsU0lUVFd5UDJwbDZJdTVmcHoraEhuSGQrcysr?=
 =?utf-8?B?ek1HMWN3OEdYWkh6bnlaRGY5aS9HazJLbCsyZjk5cVJKV1BLUVA4eHRvZXU0?=
 =?utf-8?B?K244aHJVZUhwV0V3dkNiTUZwdnhkY29XZ0UrS2xMNExhZzlEaU5YUEtPK3VV?=
 =?utf-8?B?Rkh4N1JMdXlNWDdXNU9UblJjODh2RzVKTXNFR1orcDJHa3JLSnd1bnhYQk9z?=
 =?utf-8?B?cFJ5bUlSMnJPSGlOcHl4Z2JFUFlLdDRkRDBGWXN1SHBmczRhTFNjNC96TEtT?=
 =?utf-8?B?TE5kRys4bkxIa2pZWjVub0xHemh3SUhHNm00MHNPVmk1Mk9EdHpzSFduTmRG?=
 =?utf-8?B?Vk92ZURUdUttZjB6TGxkRlBKd2VIRWJjNXhMaE1qTHcrV1hzNE1IS0t6LzZG?=
 =?utf-8?B?MFJzMUU3WWQ5Wm5vK2VhSlFQZ3RPY0tiRVZMdnJBTUxpLy82WWpiOVlnc2po?=
 =?utf-8?B?aDBKdmwwbGlWdnV5L3oxdzhNN3dUVHY1VmNEdDhNQytSRWZYeDhRWEtpYVVv?=
 =?utf-8?B?MUhyNFNLVmhYcERpTkNOOGF3ekV3VE8rSkt6TmEvaTVxWnFpVzNXZE5NMStL?=
 =?utf-8?B?cUl0VmNlS0htL2FXMzZyRXBSc1FZeG9kTVdRUWl5YlpPZ21raEF2RFJyMzhw?=
 =?utf-8?B?RDl0MFMyNVBmdTZwOE1lTzJaYVBtMHFGNlpTTk5nNzZldG9RTHkxN3gvY29R?=
 =?utf-8?B?MlpqdERTYmFnVE5GbjNwcm5jZ2hnR1VJWU9UK2M2c0xxMnBDdFZDejljenZh?=
 =?utf-8?B?QWhFdmQ0aXZ3VExoN2lva0t1cjhVbHVTOHlhTXVEVW9iQzBhdEVkT2hrYzBW?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d096c37-26f3-4fe0-9ac8-08dc96a69379
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 12:42:16.4082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbo0ku+3401Fzx2TnGi0SHfbXsOj5wpPM3EKToP40pFHVL8W0qa/RJewXppFafPi22Y7MiR7zec6h5LyWtC0K+PK9YBN5U2Kejz9kp/ZYdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7757
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

Hi Marek,

On 6/27/24 1:58 AM, Marek Vasut wrote:
> Insert /u-boot,<dto-name> = <index> property into the U-Boot control DT
> during SPL DTO application process. This can be used by user to inspect
> which DTOs got applied by the SPL and in which order from running U-Boot.
> 
> Example:
> ```
> u-boot=> fdt addr $fdtcontroladdr && fdt list /
> Working FDT set to aee9aeb0
> / {
>          u-boot,fdt-dto-imx8mp-dhcom-pdk3-overlay-rev100 = <0x00000005>;
>          u-boot,fdt-dto-imx8mp-dhcom-som-overlay-rev100 = <0x00000004>;
>          u-boot,fdt-dto-imx8mp-dhcom-pdk-overlay-eth2xfast = <0x00000003>;
>          u-boot,fdt-dto-imx8mp-dhcom-som-overlay-eth2xfast = <0x00000002>;
> ...
> ```
> 

Shouldn't this rather be in /config node?

Also, I am highly suggesting to have an additional prefix aside from 
u-boot to avoid unfortunate name clashes between DTO and existing 
properties. Or could be in its own child node of /config ?

In any case, can you please add or edit a file somewhere to define this 
new dt-binding.

Additional question, what is this index for?

I am wondering if we cannot simply have a string array with overlays 
applied left-to-right or right-to-left instead? Or u-boot,fdt-dto-N = 
"imx8mp-dhcom-pdk3-overlay-rev100";

Cheers,
Quentin

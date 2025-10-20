Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6B4CCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 12:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3C0F807C0;
	Mon, 20 Oct 2025 14:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WES8+hbl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58966831D6; Mon, 20 Oct 2025 14:56:06 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03A0E807B1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 14:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtZq8JtO47CEbmpkw/5FN5tDbyAmd110NbFEHTOC7xTd0SldkX4+MFve1RQpzkT7d9IoI7pLGXbXZBOBoihzF1nf8NrhbvxPJmZRnXtddpcC/xnYzlUXXgC+W0avW4qWNzIk0bbBluKKqEsmPrDypSb0BqFMqW4kFj+3HvxjK/c63PiuZDrF2DyJSTjPZMctUtZM/x7ikzDuaYp0Mlm08mQEtuJdgcZQpJSTwuy6t7lN/Jfg91x/TTU+DC02N70QwCn5Pi0vldA3PpcITav/UlrQ8iw1Uz6SUDmZP3UQfzjhisYkasz7uGe504YwoJlFro1B0mShgqhWwITIASkImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CK0vdGE3k4VS5ZufN6QrpLi+oV8Dz+wQpRXSEdNTcs=;
 b=wDhiViIFz8CqtL+pFQZQGsQJt/Tb9QFebmeCI5Ve+eE/MnN4ExdpKqEFBSvzSQV2hrVL9K5U0XeX9qQu0uPYeoGuKLbhNhSAve5/Bw9r7J1OqjtVUBl8wJGEBNaj88uv89dxVEV/Tuzbr7+A+ccEFF9ayKRGDPItLzhzb539t8p0OEEC/G3M1A2+EX7XOAGl+K5kyuQ7mh8mM4ludnhd2Y4edf6FMUbdnKdBkDkQa6qEVJ5sNt2SWexNgy+eeR4/XGypn74pYWjbZlnYJg7eaiElvSwPULATNWoD1+cRWnZBh16dfsATlanGlg4xOvhr85LfZPbNf2hZOtMC4oDo4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CK0vdGE3k4VS5ZufN6QrpLi+oV8Dz+wQpRXSEdNTcs=;
 b=WES8+hblPOFVjaX6QfV6T52zwtfaKtlbLorVCGbHRbqzFta3+N0g/U8YlU+7BFRAjhQmH81ikYuzvMXr8RaSUma3g/8dgmymbV6p0vLPDHiFWUIywuD8qcEXZyNubSQ2D1lltj/BDlbvHLbRr+WRDJx8D4MueFB/Vwsio6GfQtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 12:56:00 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 12:56:00 +0000
Message-ID: <96dc0167-fe3c-4db1-9f6f-2ee2e93efd0d@cherry.de>
Date: Mon, 20 Oct 2025 14:55:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: sandbox: fix typos
To: Lukas Zirpel <lukas@zirpel.de>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
References: <20251009101802.160467-1-lukas@zirpel.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251009101802.160467-1-lukas@zirpel.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c27298e-fc5a-4ae5-d33a-08de0fd804d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnJnak5JK0s0NGxOVnd1NFBZWndXalRUc2dhMXFuSXBFSDVtN2RwUEhVOUNv?=
 =?utf-8?B?ZEV5UnU0eW1laTFWVElKNXBxZGtqNkN6ektDMklBYmJCS3kzMDdwQzRYODEr?=
 =?utf-8?B?VGErNFZHdWhvcTcrZTk3OG9zVmFsNGF5M1EvNS96YUtXSWFneXJGR3pYWk9G?=
 =?utf-8?B?TkNYbVh4anBZS2FmbW1BOHprSzlEejk4cWxQZGFJMjA2T012WElaNEhNZkh6?=
 =?utf-8?B?VUhuYnpLbjdlZjFwak1VWTJUaW04N1RMOGN3a3pkdS85blY5cUpsTGNlak9y?=
 =?utf-8?B?dFgyOUFYMi90cWtydGpjMjU3dVh4aWFhUEpNbndpTTFlNkViWTdHYUpRdzVx?=
 =?utf-8?B?dTR2NUhyQ1ZETkJwaXZBQWhWK3lpUTkxZ1lnWmltZ3JUa2M2R2pMUnVSRWJO?=
 =?utf-8?B?eWo1enhYWmhnZVVYODF1Qm1PSjVjUXpTSWR6S0p3SW94Q2hXNUFPZ3F2L2N4?=
 =?utf-8?B?cDQwM3huMkkxenNoZWlvZTVSYndMSlNJdVlPSUJvOHNGbkZ0RzlRT2hZT3Vi?=
 =?utf-8?B?M2ZUSDF2TmkrMlJlUTBLN2NYSW9SZXVpc1gzRFFkdlRvRzhwV2Z1anVWU2Jw?=
 =?utf-8?B?blRyOEVIazBBMnNOaVAwdFM0cUtLOC9VNmdEbjMxNlArYTZDN2tYVGV5Q0pk?=
 =?utf-8?B?TlA1WlJnWU05emRyWmYvZ2hxTnFoWXFKTlJHOTA2L1dVS0x3V2xwM2kzV085?=
 =?utf-8?B?dzA4WnVLUHBub3NrQW81UXpSUHFCQzd5ZGFYc2Q5QTMvcGZheXlselVianQw?=
 =?utf-8?B?NVl6QVRQLzBaMmlVZmdlNWpDajJ6VHdtaW1PQkNrTXl5bmlCTVRldFpxN3Nx?=
 =?utf-8?B?a3NUdjEzME5VQjdxQ2pMZXVSL2FoSUo0dDMvaXFxLzV6MXJ4dG9FRHNQQm43?=
 =?utf-8?B?ZGZhSGwyUVZmYythUVoyaU1XNVRDeW9JS0lVMjQ5c3YzaDZIdnZteDc5TSsx?=
 =?utf-8?B?d2kvejJOa0dORWJ3MDllTUoyZlhhbFFQM3ZpZ3djYXZMK2ZUR2s2N2FpT0Jk?=
 =?utf-8?B?VnBMVi9hSGRwcVJiZElOSS8zSVFFK1YrQzlRanZoOTUvNThYSEwwRmpwYTZj?=
 =?utf-8?B?NnpMalR4MDhsMC9QdXFhdFE2S2dOUVVrdlRIaUxkNzJPc3hwaHM2RThJZVox?=
 =?utf-8?B?Q1djVVNpeWlmRk5mZTVYei9zS1NkR1pFYmNHakZBSkxKREtFQlVrdEVGV0Ry?=
 =?utf-8?B?aU1mME9NVTE0aUgyUHozRFRvcXE5MU1SS1dFeFJyN0xWWkdNcUIvQzVLL2Yx?=
 =?utf-8?B?cHQvb3cvcmZSbG1rRDIvN3IrUE5BbmRMN25yTjlFd3pkTVIrQ3VhYUlzQnZi?=
 =?utf-8?B?akFUL2QxOG12cVcycUQ1T1Y3eUlUckV2OXEyc3MxUmtQSTUvek1sZm8yMGR1?=
 =?utf-8?B?QU03TFBQYUo5eTdmdmQvYjdKbkUwYlBjbGpxSGx1SlMyL0p2R3l4Y1I5ZW1a?=
 =?utf-8?B?MHM2WWhFWjAvMndjUy9NVlY1LytaZi9TenJnSTJ0Q3lvdGtKby85aHQwTktY?=
 =?utf-8?B?akZobjR4aW1CNFlHdVlWaG5nMWViengyV3lHcnZ2bDR2M0FxSitEVGpXTmJr?=
 =?utf-8?B?ZXk1MzlHV2ZXMFQzMDRIV1c4amNZeU1Kc01PWjNVbWJGVWlOc3ljdSt1T0pU?=
 =?utf-8?B?M1VqMWJ1RVorTzNmK0VVN0E2cEF3ZSttZjF3Sm01dTkvUmZqVGUvaVlvRklM?=
 =?utf-8?B?dUJJazFpckhZRUZkVFB0dmRIZWpTRVJVaDhiOFl6S3dKemorVXpJL09TZ3pp?=
 =?utf-8?B?V3g2TFlmNHNJWVZXRU0wQ0RxMHNuZVJ0VGVvbVQyMk9yNjJKRnM2eFFIN25z?=
 =?utf-8?B?VThJKzhLc1AvWmp5OXR3cW4rNk9oa0hyT3lJSGtLWEwrY3JCSnN3emxtV3NO?=
 =?utf-8?B?UndEdTJ1REovQy9TMy93cDJPRU9vQ3Q2MWt3bFBlMmZ6YWgyWlJ0VDN3YnZ0?=
 =?utf-8?Q?FGrjE+IBZVtOowjJTqb8w5HgeOeXbCHk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmVRUy9NbVZoU3ViOWpkNmxoWFdOZW9leGN5Z3ZJUUxZU2xPVS9IYjNHdFNB?=
 =?utf-8?B?QW4yM3p0Z2ZtQnpNVlhiak9UOUwvOGEyOElrb2VnUkQ3eG1ERWtBb3lFRVJX?=
 =?utf-8?B?dU5EM1dqeXBycEFTaE5NcVZXckVlc01TaXQ4YkdsdU8vNU85a0tmRXpnL0pr?=
 =?utf-8?B?UmVUcGI2Z2g5cERIQ1lNZ0hVeXZ1WlZmY2hXZWtyRE8xUUFFWjMxVHVUWk5j?=
 =?utf-8?B?YnlNUXAxcklRNUhDeEUrMFYycHZZcDhRTkt3NGNxM3c1QmFaTXJCa3NDaEY1?=
 =?utf-8?B?bStyRWUyN0NIODc3ZmJ1L3pBMzVVbUtIWTBJWi8zSEo2VGpNc2ZUT2hPTm9o?=
 =?utf-8?B?VGZ1L0Z2bTJiM2IxUVlOYXUxYXZqTFJGYlZxNWZFUXFDbmhkUVZ6ZDZab29M?=
 =?utf-8?B?ZHdzdHpJZ2t6TnJocW8xQ0tPK3FCR1ZRcTNZZVorT2REZDh0SGdXejZYU3NN?=
 =?utf-8?B?bENHVmxBZ1pHSnFiZkM5cUU1VzNZbkQ3WmIvam8vNUVLdG1LS29Yak1DQXhP?=
 =?utf-8?B?L2ZkT080VTcreUZlMmc3MGZzZkszZUNlYVNPVTJFVy9waDBvaXdMSmRxUFZG?=
 =?utf-8?B?cThLZ25hNElYODMrbjY5UDdFaTMzM3lGUnBIN3o4ZER2N010Q3E3ZFpYSGFk?=
 =?utf-8?B?elprYUV0Vk5xUVFYS2hKZW1PZWdDbTlqSktjbGNhbDlLd3pWaitJK0JQbGc5?=
 =?utf-8?B?ZjN0NDhlSkdUVkhyVUt5YzA2Ri9KV29RaGZjS0htSlNXRFg2UGUwUUhMVUw0?=
 =?utf-8?B?NDg3cjhSZDV2WEhKaC9HVWI1U2ttRjR5cE41MHJETTN4cTQ4eXBCT0Iwd0x4?=
 =?utf-8?B?MHZ0NGdYOEJYcXAycS9hMEo4MHdkNmp1dVNNN2N0WUk5WjVrTFNyTDNsWUNl?=
 =?utf-8?B?TUdpbURaNmloRlFKRmt3dEVlSklNYXVEeVZ4ckVBWkF1aEpUeE1aMzdaNVhT?=
 =?utf-8?B?c25JKytQenRaNWVHSXhNOVk0NTZpMnVTQUVMNTRFUit6bUtqTnl2SktXWnZM?=
 =?utf-8?B?T25XUEx4Njh0bDdWejFYcHRHQlpuc3FmYXIyYjZKREpxY1dJMzFleis1K3Q4?=
 =?utf-8?B?RmRBY1pCWTlUZWVQOVlUWkdReEl1ckpBdGN2NmZmU2ozSzVPVUpkVXQxQ2xB?=
 =?utf-8?B?OWNLZUx0YlVRcGhDYWRFdkpEMWFIT1VxbnZoeThaN2sycVkxRkI5RllLeVVk?=
 =?utf-8?B?SFlORUxFWERDRGlrcFBoZENXbW9PTy9UZCtnYVlEUTJzbXl1cG81MmthTFU1?=
 =?utf-8?B?S04wbGhLOXppT0VmN1NVZkJOd20wSHdOcmRpTDI1bWVPUmNjNHdMdlZ5dCs4?=
 =?utf-8?B?YXBHTkNKRnlwQXRTUmsrdkxFc0w5OWlKWGZTd3RVSkJINkpzdmhDTkltMDQ1?=
 =?utf-8?B?MUl2dHJVMXVEVDFUTEdqaUFqNFJHMitubkZoSmw5anBxY1N1Y3p2elBSSENY?=
 =?utf-8?B?WjFVeDQ0TW1zekZVYWp4dHlRcGxTU0pRT01PWXB2RHdaNnFrd3A4d0xhUVdO?=
 =?utf-8?B?K2hMdHQxUmlsc3ZSR0pNQ1M1R1BxTDZ3WmlVMVZOQjFXaW5RM2EzVDVnd09P?=
 =?utf-8?B?c3FTWG5XY0UvT2RSUXplOTJOL3NpNTBKUWFlT0xVVmpnOU5WM3ZNRktMUGdq?=
 =?utf-8?B?elRNOFRPY01QUnpTQ2laYlBEQUFFUjM1bjVPWWhWUERaQ1Y2eEN0N0pCbGJE?=
 =?utf-8?B?UHVwRHoraG5RaERGT1g4eGtmNXZhK01aRE03bGt1MzZENXNTM21aQXlPODQr?=
 =?utf-8?B?RG9DbGl0QWc1dFFtTlp4M1kvRlU3eGxTK29iRHJDS0tnTFpzamR5Tk81TVc0?=
 =?utf-8?B?UEpIVW1jRFBqK3JFOEdESFlUVW5yaTFYT1JoYzJHN2pXQ0ZreVUrdHBWYmpz?=
 =?utf-8?B?R3pEMXVhR1dkd3FxdUpDNCtvNXRkNG03TEoxajNTbzhhamlXbk9yeU40WUxZ?=
 =?utf-8?B?WXZENFo2TUhjSm1CU25QNmFHM2wxVWhWZ1pWSlFpZnVxWDdFd0w3WUUxczNs?=
 =?utf-8?B?d05zV3FhMGliMzIxVTNwUTQxMG9ORlVSTVBGZExGZ1JDVjhrUDlDcm1wMWow?=
 =?utf-8?B?bzY1RGplckNGN3RjbmJLdG03SlovOXBNUGpCZGg5WklhZlQ4VXU5OFI4UnZ2?=
 =?utf-8?B?TFBZSXE5NkVaY3RyQzh2UGp4S3ROdWtzaWIxS1R5UHdNNGE1RWNVeG9Oc2NK?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c27298e-fc5a-4ae5-d33a-08de0fd804d9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:56:00.5097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEEKvwPjPAnJLi/ljc3oupY1uK8HLvaWddNJ92wlPtdVD/3sxqqRVASKO5CljDQ7jrEItlcnBltcI7B8slPBDfiqF+AYIKSnAKMILyWpSzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869
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

Hi Lukas,

On 10/9/25 12:18 PM, Lukas Zirpel wrote:
> [You don't often get email from lukas@zirpel.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Fix two typos in the sandbox docs.
> 
> Signed-off-by: Lukas Zirpel <lukas@zirpel.de>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

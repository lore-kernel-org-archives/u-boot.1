Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA653C3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 07:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E0E6880AE;
	Tue,  2 Jul 2024 09:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KmXjWthm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06C9D88025; Tue,  2 Jul 2024 09:41:57 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1A39880AE
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 09:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hevn8Z25mvzHN49B1vnXhAmEKJf/voXCOMefGi6lQARwxvZAafK81nr22zTzA3SN/w4IcLBi3nRkdcGc0GbHvNJRj6FYgU7hqYnzLSDbk3KPKy2K+p77vN+7e5nUdsXQVBfJ7nxlDXOtpEYe9Ptoe3E8bi4L57DzAYqk2ek08ibuI+Wj+jYirkCiaZ5gj4kFp+fefvLTQ5gWhLO4X/A/Tb275fTO1e4HXYvT+E0Zo6g1fu9qXrRXZSXuBDu17O0MJFFRNChBBFEZFQ03gJnPb+0Z+rTFyZeHhOMvrO9nksZyi1grhLhqz4Dg0iaMsEzDMl4ROEbKGf9X2YLRX4+BUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LawvJaY8umxri8N6VOVf8tO0MpWxhYSnjMKkDamsak=;
 b=hKQ3CmdZAR97/zBS5jtu7P0xKKgByf+0Y70VCpsnQyXLiO+IKou0fTdQS988jh7ZZHh1xian3rhsnnRBpp1r95mjd85kZOrkTEXUZMbmklryOliUbWWTaklCfRHB/fyKO0vdmrtDO+r/gCRA8f3h26zEa0hW6eU5kyQ1+7WcS9ZovVqkVO+KmEwF1NhZfPkqBhcWkIM4LmQw2Ss67P8gHhkSuGEkEBg513MVcb99PM+2g0YVj4R6bJ3Any7wlnOn4c3+oagUs9oABEa62+kzX2Dk6tXRuBKsW28dId3GxhWQpqFiNesgkWPeTnYBBolJ2gkpLoLw79A1HBvTWtlQ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LawvJaY8umxri8N6VOVf8tO0MpWxhYSnjMKkDamsak=;
 b=KmXjWthmJHVGHXiZAfbR7oxlQ7EtZ/0lsmamhDYFlIPr3EQPgm3pzy+P/1w50NTcnjMGlo03UQtFyL8dDe3e4mRype8PLrp+BsmrXv6kwtZ9PoMKhtQpziaA7VTW0fhg3IFaq4Cm4vHLgLl+RzPVxhL+Z76hL7Onp2+EuVwlIsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AS8PR04MB9143.eurprd04.prod.outlook.com (2603:10a6:20b:44a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Tue, 2 Jul
 2024 07:41:52 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 07:41:51 +0000
Message-ID: <038dad39-e99a-4464-be5e-57a3a73ca8af@oss.nxp.com>
Date: Tue, 2 Jul 2024 15:41:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: hab: Make imx_hab_is_enabled dependent on
 FIELD_RETURN
To: Paul Geurts <paul.geurts@prodrive-technologies.com>, festevam@gmail.com
Cc: sbabic@denx.de, uboot-imx@nxp.com, trini@konsulko.com, peng.fan@nxp.com,
 eduard@lionizers.com, marex@denx.de, fedor.ross@ifm.com,
 rasmus.villemoes@prevas.dk, xypron.glpk@gmx.de, elena.popa@nxp.com,
 tharvey@gateworks.com, sjg@chromium.org, vitor.soares@toradex.com,
 u-boot@lists.denx.de, martijn.de.gouw@prodrive-technologies.com
References: <a9ebece9-4ab6-4bca-bebe-985e0bf95278@oss.nxp.com>
 <20240701123914.2685310-1-paul.geurts@prodrive-technologies.com>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <20240701123914.2685310-1-paul.geurts@prodrive-technologies.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0089.apcprd02.prod.outlook.com
 (2603:1096:4:90::29) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AS8PR04MB9143:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b633e8-1d9f-405d-ace1-08dc9a6a6ff8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGdnRUlKdVVYU2RCcEt0cjQzNlQzRFN6L1BROGpJVWs1cmcxbno4bUtoV0xv?=
 =?utf-8?B?R0JuL1c3M1dKTHJkWGtpOHM5c0Y0Z09jdE9haVlEZlpHZlF0a1dVYlNyeHRT?=
 =?utf-8?B?Nk9YM0xhdlh4RjVGbnZQZ2s0b0gwVUNDTkhyejJDdjkybUQxWGJJZ0tVcC9q?=
 =?utf-8?B?NFNJZXc3bGszSkFoOFZ5RGtaQWZGaGkwY1FnQWdzY0R5RytGeEx1a1VoVDB2?=
 =?utf-8?B?UE5JaUJvb3NNaERkdDNmaGJQbHNpS3R2Nk51aUNlajAveVBYNTQ4cFFyMnFZ?=
 =?utf-8?B?SDlaK2RrTFAzQWhYeFE2b3VVc055L2tqRVdqZkRqT2J0bnFxdEdzUE9OV2dr?=
 =?utf-8?B?VTBoWlphZ0R3RHRRcWREeDU5OVQrb1JKTzhSbU9tMTVMWkpwOGFXL1NWcWtI?=
 =?utf-8?B?NzVwNVlLTldkUnhPWjhFSzJCOUx6REJYWjZocElYMUZEWDFFSXZyV1dlelo5?=
 =?utf-8?B?YVMwd2h6a09nclV6TmVTemhVVU54Q1BjcE1sWFJFcm15UDlnQTE3ZDJJRERz?=
 =?utf-8?B?L3J3WldNTnRBNG0yS3NsdjRVeEhlUmFBTGVuaTFCcnkvazdoeUtkOGhIbWF6?=
 =?utf-8?B?SzRaamtsNnd3QVU3aUJINE1kaHpITU1lS2ZVZzI2MUU4QVRRekdwbURhU0VX?=
 =?utf-8?B?UHl5ZjZSTTlpbE1uU09ERkx3TWtsLzlBeUt0aVl0L0xCTnF1UWovVE5sK2NQ?=
 =?utf-8?B?OTJMRGJrRWxiaWdCNWtXaUZ2OEU4Q0s3NzJQWEZWTHNva25USmlQTk5IN3JJ?=
 =?utf-8?B?dHlBSmdMaWloKzE4MXZ1bkhyWWJaYTRHMFZjbUZRekEzWTRXOXk4RUhpV24y?=
 =?utf-8?B?K2swTjNtU2NsL0l1bzc0Slo4YUFmR3c1dFNVQTVXcmxWeDFKYXNhMEd1VUZo?=
 =?utf-8?B?cjFSYkJZRVpqSmloeDNvVGxLZzErRGtQR1FjRjhOK01QaytXUHR3b3JXU3VE?=
 =?utf-8?B?WWcrSUpuNUFVK2d3UVF5aXlBT1FOQyt1Zm1KRlIybXQ0VGFqenFlek4xRTlY?=
 =?utf-8?B?WUJqeEt5bmp1anNPUjUxOW8rNlhPazREdnhLMEJwancreCtzN1VLSHVka2Yw?=
 =?utf-8?B?bVh0RmJNRnpSaUVXUnN2bHo0TXpVYkcxOEh0YjMrTnZqdTJBYzZTRVFIMk5U?=
 =?utf-8?B?U3RCbERwcVRCNDNWOHFOT0JQNlpOaDlKVjdVRzNJMXA2dWlObzNMZ3lXTVNZ?=
 =?utf-8?B?L1k5RWc1UDZJZkhUMmFsTnk5eVVRRFIxN2d5bUlnOVhzVEdtZ1V6dFlucENK?=
 =?utf-8?B?MEd3UEMwWXVqdGN1QzJPTGFiOU80OEZxMFdtR24wSVp2Wm1LSFBnaExiQng1?=
 =?utf-8?B?YkljVXR4ZnNWcElxTjA1T0dHUnBHcVA1K09QVTg0UFNUK3gvUmlzU1E4SGw1?=
 =?utf-8?B?aGt4d3lGV2R1ZjBtTmZBSWxvN0ZEa0llWTVzeFR1MCsvUHp5QVgxcC9XYUdI?=
 =?utf-8?B?Y3MzNDlkNEtsNDVLV3RpMUpUU0VFMGdiRDl0MTJxTks3a2tscW0xS0NITmpB?=
 =?utf-8?B?a0ZPT0dwMkZrNGhGd2tyaWNYNSt1c1k4VDJveUc2blhXUk5MbUVRNDlxeEEv?=
 =?utf-8?B?cVh3WXo3NEhna3lQM2xIL09XbFhVT3grMGpiRXh2YmlDdUhjMGh4WHBwV0dm?=
 =?utf-8?B?Vi92Q082UTZYdW9vNkdBT0dwbnVNRUlXOGtNSDcyUHc4d2Y1VVJxWEVTckdq?=
 =?utf-8?B?Y2prMkVyUUxpVlFrVHZ5bU5BVlhzajFaQ3ZYSVdGVnhnMVZXaTJyaXF0UEJk?=
 =?utf-8?B?U3VrUlFKMjBqY1RBeThkOW45UjBBWWFhS0YyMkQ3Z0FoRkk1SVdaZ2dCY201?=
 =?utf-8?B?V2UxeDJ0SzlqQjd0eEZrUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHhodFEzM2piOWpMaG0wcFZyRlZvazczOUV5ZGNzenBkOEJwcDFDTllDOStE?=
 =?utf-8?B?Q1p0S2g4WUVtbU5JVGxHMU1ocGRjV0E0ajQwRG1xTTBuTHhTd01kN1Y1RkVm?=
 =?utf-8?B?aENmazRuMXd1QjBHUDZhdzR3S0tlK1pkNjBFZVVDemkyTm93UTFVN1U1TCtI?=
 =?utf-8?B?dUo1SzRqWjJvNWFOQmo2cjI3YzkzOHJTQ3l0VFNwZGtJU1JKMFFROGVhT0NS?=
 =?utf-8?B?b25VUGpEWUgrUjR2UDg4OGxESTRhWUhxaUo0aEJRUEZXOElJYzVZNmVwZ1oz?=
 =?utf-8?B?akl2bUxTYTNha3VmNFhMcVUyN1FEa2htMnE1RlY3RFFSTG5lclRjcEV2OCtl?=
 =?utf-8?B?RldpZExaT3dhay9OY3RWUFhtSWZzemxHK2xTdm5GTmZicUxOdHFLUTNYdlRh?=
 =?utf-8?B?dE5WU3dOVW8xTkQ5RE5LMkNFUFFUSXJTd01ucVh1OXprRDcraXNJMExOZ2ox?=
 =?utf-8?B?NWI2U3RWd01mU21WMHhUZCswSzVGTFVJMTZ2RVJWUFlMWFAxREJ3V095WTBv?=
 =?utf-8?B?WkVCK3JDdmlwVExKVGI2SzZxenh1clcrUHR6WExuTXRVeU9tblJpdHQyempU?=
 =?utf-8?B?Y0djTURFZHN3T2xkVEw1cmF6SDJ2dkJpSFlhMWkyYURhWk1zSDNEVTVhWVdV?=
 =?utf-8?B?NUVUOVI5aHByS2FicmYxUDduZmxtNE1DZ0xqSEI3eFl4LzNYRURVYXlES25L?=
 =?utf-8?B?L0pRNFU1Y2Vuc1FnVlN0MTRSVGE2bSt0TXQ5QU1DR1NWTEM0dzlOYXhFQy9H?=
 =?utf-8?B?QUVjVkZXVDlMdmxPZ3U3dnFvQ0oyQkJwZ0JwVlFpTVc0cWc2c0NIelQ5SU54?=
 =?utf-8?B?a1JoaDJYVllLNUIwQzFYSWdocS9IZjBqZXU5aVlGRHd6Qi9iMGtENzVDN291?=
 =?utf-8?B?YnFNNXBHUkJXdW4vdVdzR3JjeW14VXdzUzV5SVIrcklrRDdMcno2MzYzUFI4?=
 =?utf-8?B?SUgzTHFvTXN4aFZKODRHOXJiWmF5b1Z2cmZkU056UytSSSthSTcycjZmZW5V?=
 =?utf-8?B?MmdaRGpyZ2pjQk5aT2tMdnlvUjdRSzFIV0hZTm1rUFRPTFpldnZlQXBwMk5h?=
 =?utf-8?B?ckovL2ZteWxkZEFCRElxcklzNUM3S25PNXZnUEU1RTFKMXYrWnBWQzE1Z0l5?=
 =?utf-8?B?UGRSUXhxbVFpU0tSU0xDbG9LV2tIV2NvSjJOc0RrQ056YmlqWURUUERScTFt?=
 =?utf-8?B?VnNRWGZTamFyN3QyY0V2VGVMRjh0T3dFbGU1TFpvei9CRWhWczJ2eUNtOHVt?=
 =?utf-8?B?QnlDSUt4Z3VVWExnS2hhQ1Zpekg5eEk3UXRIVmpJejBQNy9DNTY4bVlrTkRJ?=
 =?utf-8?B?QUlzTU5kTFZDeXBrWk1NU1NkUE5oVzJkNVVwVlBBOGdTOXM3WVN6R2prdmFC?=
 =?utf-8?B?aDNob3dGMGUzSDNhTzJKUlBnTHBpbnA4eVk2K3EyKzNsR2IyMDM3KzJpSDBh?=
 =?utf-8?B?aXVqVDU0dmNVVWhSMFVoOHlxemllQ3Q4R2Q1YVRxdHBxVDNQektjWjRkdHh3?=
 =?utf-8?B?N0MyTlV0QWVjajRLbFZIYkYvSVBldkY4NzVhQUNpaVZXa2NPb3QrYWtJOXBR?=
 =?utf-8?B?R2wyYk1zRzUyZWJrVUZEMWNsbmF1RWZPYmNuTUd5S3hwK1FtTVlGUEtsaUVW?=
 =?utf-8?B?ekMwc1RmSkJKc2FFczlzRDlteWxvaGNRbHRVcGFOaUlvd1hzUEtHUmdYMzN2?=
 =?utf-8?B?cFhHUjB2N08yaGZBeGJRdFg3czhzZlhmT25id05aSWxVYnhOanVxaVNPSkQ0?=
 =?utf-8?B?K1JvRzFTN1hWRkNVaC94NUUxcEZmU1FCaDZRb3h1dnNjUS9DNDV3aTJQWE5Q?=
 =?utf-8?B?cUFJemRIQWNwQ3h6WFBTalgxQytxb3lsZks5Lzk4YlFEZkt0Y1c5NVFHdkNZ?=
 =?utf-8?B?dkNQREthMFBtYnVRelhIY3R0eU1Hek9tWi9raklFc0thWVlDRFVQSGdmTnpa?=
 =?utf-8?B?bUhndDFDUkNPakRWc3hycURSbkNoNWsrY1l5NjBUTUdTd0hwUWZpZXpoRjkz?=
 =?utf-8?B?WnpOL3djTW56TUNmWXpraGhqaTR3bldGKy9EbW9kS0JxNk0vYnI1NmhoQ0tZ?=
 =?utf-8?B?UGU4RmV4ZGFMaXc0S05JRCthUDBlbEp0OEErV0Z4R2gzZXZMd3pKYWQ1eUxl?=
 =?utf-8?Q?6FWgNQ2FNw3uHyu7AMo7iUjrV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b633e8-1d9f-405d-ace1-08dc9a6a6ff8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 07:41:51.9176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OalHxQT/M0vUhW2JruXN6vcmLfoPfI+FWm13R58LJ2y0DOQOpwOcvCnr7C5/y2G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9143
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

Hi Paul,

On 7/1/2024 8:39 PM, Paul Geurts wrote:
> Hi Ye,
>
>> Hi Paul,
>>
>> On 6/26/2024 3:17 PM, Paul Geurts wrote:
>>> Hi,
>>> Thanks for the feedback.
>>>
>>>> Hi Paul,
>>>>
>>>> On 6/24/2024 8:09 PM, Fabio Estevam wrote:
>>>>
>>>>> Hi Paul,
>>>>>
>>>>> On Fri, Jun 21, 2024 at 10:06 AM Paul Geurts
>>>>> <paul.geurts@prodrive-technologies.com>  wrote:
>>>>>
>>>>>> -struct imx_sec_config_fuse_t {
>>>>>> +struct imx_fuse_t {
>>>>> Please make the struct renaming a separate patch.
>>>>>
>>>>> Peng Fan, Ye Li,
>>>>>
>>>>> Could you please help review this patch?
>>>>>
>>>>> Thanks
>>>> Can you take a look iMX8MP FIELD_RETURN fuse, I think it does not
>>>> have 1 bit but 8 bits which requires to burn a sequence. Only when
>>>> the bits sequence is matched, the field return can work.  So checking
>>>> the bit 0 is not enough.
>>> Are you sure about that? The security reference manual (IMX8MPSRM)
>>> says in Table 5-5
>>> that the FIELD_RETURN fuse is located on fuse 0x630[0], which is a
>>> single bit. Also,
>>> the "Chip Security Lifecycle" section (2.15.1) says the following:
>>>
>>> FEILD RETURN (SEC_CONFIG[1] fuse = 1 and FIELD_RETURN fuse = 1)
>>>
>>> Are you maybe confusing the FIELD_RETURN fuse with the
>>> FIELD_RETURN_LOCK sticky bit?
>>> clearing the lock bit _is_ quite the procedure, but it is unrelated to
>>> U-Boot, as
>>> this is done by ROM code through CSF.
>>>
>>> I tested this on an i.MX8M Plus and it seems to work fine.
>> I know the steps for field return.  What I mean is the FIELD_RETURN
>> fuse.  It is true that security RM mentions it as you quote. But from
>> 8MP fuse map and ROM codes,  I get different things.
>>
>> FIELD_RETURN 8-bit code.
>> FIELD_RETURN = 0, is non-field return mode, functional/secure mode.
>> FIELD_RETURN = Matching Sequence, device is in field_return mode
>> FIELD_RETURN != Matching Sequence, device asserts security violation
> That is indeed different from what is mentioned in documentation. I have
> asked our NXP FAE about the discrepancy and I will adjust the code if
> needed.

Thanks for confirm. I also cross checked with teams. 8MP must burn a 
pattern. Otherwise HAB won't covert to field return.

Additional, do you think it is very necessary to add this patch set?  
Because field return is a pure debug feature, it won't be deployed on 
productions. The developers working on field return parts can re-build 
u-boot with CONFIG_IMX_HAB disabled.

This patch may introduce risk to HAB in some sense,  especially for 
productions. One mistake would make unsigned image bypass authentication 
result.


Best regards,

Ye Li

>>
>> However, I'm not sure how is it implemented in HAB. Since you have
>> tested 8M plus, can you confirm the closed part is successfully
>> converted to field return and can boot without signing?
> Maybe I did something wrong while testing. I will retest it on a new
> board when I have received some more information from NXP.
>
>>
>>   Best regards,
>>
>> Ye Li
>>

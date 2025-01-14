Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F941E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 14:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A160480657;
	Tue, 14 Jan 2025 15:48:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="jLLSaRam";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC2F68069D; Tue, 14 Jan 2025 15:48:22 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41DD98060C
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 15:48:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjoNe6ENote+I2Tvjr5FgQNLADFbgVl6u7FRWrbH4GXmB3jVe+Nx9xuk++d4J19Re0u7R8VhXw6cbal5nsXOQV+63DDRoOMAYAlCRvSue9TOj2HcP+YzjIlklWk4h7bJzi349dkxYtLqU5uaZ2sxE6nSPqN9mspiWtaq+cTidxJmELEQx7P1jecJy1uOjN5bnADz9UAhkPg0Sl3yCX17EFg7bYCR7ePrk1el24vvVruqzUt81Wh1t7oUBh5qXkOpknjMsYYFpsuXlbjEIlgCmlg6NT8FUCkl+k3/0M46HtVgYHH9pZpNd6bsOUB0mYX9JMu/PnG1372z70/AOsmIVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvPB2uxg0vjz4RCj763yW/BuSuA3/sVO0uj5eJvC3wo=;
 b=B+9jah0Tuh4fK2a/EQawtgKnN+D3JcqZJvWUrgzjMRxWy2IMQNCpD6N2BMp5z32t5j7mk2wzJqnCQPeF9sl1xUgOzidOKWixRV0/jo/itSy3DxFcA/HajX5AnQpfbtbATbDQlY0KkEjIJcakBaRma0PHdv1HKDFlITaLPgsf/AT5n7agKkDiIrraSJkeT7R6G34Ta/V5PdXVDqX8+IW+S52/za0avSbYXC2NPL27AYtbg/gZzZIJUScV0rshBJ2oQeCjviLvWFM3VPxnkxIawcgCm4q7CgqjmkV53xaTVRKAuZQN5PSZN8YKSJEtx8iIMT3verZMhZ7mKH6pmdOsZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvPB2uxg0vjz4RCj763yW/BuSuA3/sVO0uj5eJvC3wo=;
 b=jLLSaRammvJBWfSXXoFb9LyOa5AOflP2Ck/hNWLABsUU+2uYSiSJFN+z/8/QgVMw2oFZrkGV3e6wPBj5WJ6CumFcS/15b2wM3lR2suMAD/eVtqvEXMtMzjV+i9vsoZttL7c+83vlm+O3xqr4D6rD6Q1SvlvJ+NxbYyq7O689KLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU6PR04MB11184.eurprd04.prod.outlook.com (2603:10a6:10:5c1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 14:48:18 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 14:48:18 +0000
Message-ID: <b32bc9f1-3bcf-4cea-8242-e372e68740e3@cherry.de>
Date: Tue, 14 Jan 2025 15:48:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] board: rockchip: add FriendlyElec NanoPi R3S
To: Tianling Shen <cnsztl@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
References: <20241226092043.419511-1-cnsztl@gmail.com>
 <20241226092043.419511-8-cnsztl@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241226092043.419511-8-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0139.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::23) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU6PR04MB11184:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7cbff6-c120-4fd3-eac6-08dd34aa7c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjFlVXRJSUN0UVZuVjM2TEo3empJM2g4bE1CYjRxcnF0MFNnaHNGNHhrWkY5?=
 =?utf-8?B?NitTTFpibnFEQUZOTW82K0dKTllETUtiSVdGL1BlRi9TMTBITjJ1NVA2OFVr?=
 =?utf-8?B?ZkFCTzVmL1EzMmlLMlBjSzFXUTlZYWFEMFU0RXE4eHo5R0hkQ0JLVWZkNzZS?=
 =?utf-8?B?Z1hCa0xGemtBTVNiZXpVWXZKeDVZQWNURmNkem9LTi84Z1d5ZDY1UDh6L2Na?=
 =?utf-8?B?Q3I2OHNXQ2ZQSW9FWG9kQ0docU1MQzRkTWRvS0pIWWJ4a3UwWTh4Qm01YWY4?=
 =?utf-8?B?NXIxc1ovRWlzZFVBMnV3TmxERTdBVC9vblkyNVBoTXY5aUlRUlMyM3BpU3Fx?=
 =?utf-8?B?RmJJbk5SOUh4Vk11azlUYlppTHB4SHpzSGpHdmJkOEszT1p4U1FXWVNCY0hT?=
 =?utf-8?B?cklOcUFlWm1KWk5TYXBkSGJ0U0lITmdaTkV6QlRCM1dSaktvYTBIaG45Zzkr?=
 =?utf-8?B?VTg1ZnlGMkZhSVMvcTBCSHZYcGxzNnhFZFF1U3lBMHhYL3h0RklJUkg2Q2Z6?=
 =?utf-8?B?UnJ5TWtyNVJOdTFsdWZwTzZvbGh0MndGcDhKRGpnSm0ySGZFNndSQ2lDUjlC?=
 =?utf-8?B?NCsxdlFQcFBub2NvTGV1ZnBUNFplcXpXTUQwb0l5Mm9MS0ZKMXMyRERCT3hX?=
 =?utf-8?B?RWN1SHBEOGpyVGM3b245dEFkL2gxQ0NBWkZXZzg1ZHo4endaemppRWN1RG5L?=
 =?utf-8?B?Y1ptc28wSHJvR3l4WDF4NDZHekxIbTV4ejFmQTRLU0tPMHhMUlQrMXppY25o?=
 =?utf-8?B?bUJSVlpYMWxUeUtHdHFUa3QwRjNHNXpuQk8xWit5WENBUUJDV2diOGJqZHE4?=
 =?utf-8?B?aHNMd1dZSm56Uy8zeTlWek5NYzJVSGtqVCtXaS9NS2dYMlJqOXluL3ZrdUdh?=
 =?utf-8?B?cmcvWHo1Z0ErN2k3aEtubWUyOW15NjR0NXRhb0RJeUNLY0tMblBPV3FYYkUv?=
 =?utf-8?B?STA2eUtxWXZoZG54eWtldTFncHB2T3FMOG9Vb0NIWHdjODI2MjBlb3BZeTBw?=
 =?utf-8?B?Mkw4Nm9YZWtpandrbWRsZU1nN0RLdy95VnNJYXpyU0lmMnUvR2xuQmRmam5Y?=
 =?utf-8?B?NGNjTGVCR1E3T3NsbUJLOUR3SWNHVXM5LzUxRHZ6Y1liUU8wQ2ZyRE1keVcy?=
 =?utf-8?B?UFB3aDRMbUdYZ0djN3plcTdCMEJiN3NuSVVsMjJOQ3d1NVJYZHpKV2k3WC9Z?=
 =?utf-8?B?ZTZoRmsxQTRHM2RhaG01NDZkNGprSWRCN1EyN0c3dXRyZHREQzYvczRMSFlM?=
 =?utf-8?B?VEZRZjZQUm1iNUphUUtlaUxKa29XaWJPdlJLVjFOSmtQOFpkdjVjcWJTc2E2?=
 =?utf-8?B?MU9QaTRqVjFDTlFGeWI1REhKdUIzOGV2WHpmNWpwV051S2JBOTc0b3p0ZkZP?=
 =?utf-8?B?RFlwYVBXMGZNZ1ZYWVNHVFZTcmpibFdleUZtNGRLd08vQkpYUEl5V3IwVXVR?=
 =?utf-8?B?M1Q5bE0vdWN5YUlKekY5TVN2R0NTWk9nTG5HZ0hhRy9USUVGRlQxSWxncHFs?=
 =?utf-8?B?VjZ3b3I0WVQ0RjBkbzZNeS9qczAzQkdJZGpsT28zTXNoMS9JQThwTkhaNWVy?=
 =?utf-8?B?UzhaSnFDY25MOWVPbkJnTDczeXdCNitleWY2bXdmK29rMkNJQlovQ2Mxajcv?=
 =?utf-8?B?OFZacGlycjRacEVYRG9JRTBkZFlXSk5PTE1EWUFLVWhKQzRZNENGR1NNVWtI?=
 =?utf-8?B?T2NLUG1sRHZaZTNjNERFcmR6eVdTRE12a1NtZEtrZGV2YTNSaGQvQkI4RE5F?=
 =?utf-8?B?cC8wZkVKVjRqY21wUEl5MlJmMDRiaEtHYklOc2FBbHk4L2pFRzVGRUZTN0FE?=
 =?utf-8?B?SDJpa1V4Vlc2eEgwSWQ1QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGhlYVlqVU1Ia3kxZDB5VmVUYjRKMmtMeUV0bjJnQnRLS1R6TnhPOWpOemoy?=
 =?utf-8?B?SjZnL1Y1NjRrWitDZHJBdWFNVjNndGpFV1UrOExkK1dIUUFieDJ3b0FtWGk3?=
 =?utf-8?B?VWFVaitOR3NleG9sVktrZkRLM01YSnJzWi85ZWRqc2tHMFJMUDlKeWRhVCth?=
 =?utf-8?B?VHFMWll1dUVHeDJ1cHd6YlRXcmFhaUptbGkwc0dPYkVoZUFzMURYQVFOTmZt?=
 =?utf-8?B?QjFTZzg1L2UyY3U5cXB4STE3T3lnWFpQOE5IMkQwRVgrVFZyQU1RS3ByaUpG?=
 =?utf-8?B?T1dnaVhWcmFsU0hXalNZVkxKaGNLaHpxZjN5Z2hwS1VGWWI4RVRIZU1NcVUx?=
 =?utf-8?B?UU9CWnlab25lVURoWTh1bUZDcm1KaFVISUxxK25QdGVLVGFQWXc2N0E1QTcz?=
 =?utf-8?B?YldOVXlnNzFXdTNXcXNzK2NUZWpEZFp0OWt3MjNZR2FQOXpDNTRENnM1MlQr?=
 =?utf-8?B?akJuSmRaZG5iMTBZRStmUklZYVBnOEFWZmV5VVMyWWxmbmdKODRMQjIramts?=
 =?utf-8?B?V21XS0IrZldKa0QyWm51WFJrOWxoL2p1enRRNFZUNU5waGFZb0Vud3VSVUxV?=
 =?utf-8?B?VVFyQXRsRThEdVVGQVdpd29tTXBnc3dMbjlnZ3d5MWtnSWRxbkk1Uk4zSEZN?=
 =?utf-8?B?c3plWTY0eG55KzBMRkRWbnQzcVlpdC9hUXY5SnZlL0dzQmw2a2NQNEpmWXBQ?=
 =?utf-8?B?dXlVN2FRaUZKMXRoNFNIdzgza1FwR0UzR0lod0ZCMFdiZlBnU2ZSdFRBbXRM?=
 =?utf-8?B?L3V6eDhvS3g0NVlVMW9BeHJXZGlJUnNDOXY1cWlLNnBCWCt3ckxJT2ZjTkNo?=
 =?utf-8?B?SGpzYytDTWs2TWZZaXJCNGpzRXByTXgyYitNbWZMdEx4S1c3aDNEV2ROeGVX?=
 =?utf-8?B?NUdSQ01BSzlIZFZGK3FTb3paaktTTXJaOUIzdE5jRFp4SFp4bUJ1emxxK0No?=
 =?utf-8?B?NFVEOWhxQXJHcW9CUHRoUnVSWVF6QXNCcDBKNk5vZlZPVVlxSHMzQXN6SHRa?=
 =?utf-8?B?cjR1WWhjVHJ2aHdmWW5UdGNUSkN6d05ZREdxbFU3YnIwUDhvSUhJOXYwRk4r?=
 =?utf-8?B?bXJNbFMrSjgzNmpHblNRdWFCMXVsNVJHaktsQXhUNjI1MW5WalpJWEluWENn?=
 =?utf-8?B?eVJlbFZXWWxGQURvQ1BUNWNQLzJmU3VlYk1QeiszYXFsSW44aXBEZStnc3JZ?=
 =?utf-8?B?R01XWUt4bE9BTGY3YlgwUUpxR080dUhOZUwzVU4zWC91L1RuQ2Vocm4yQlgw?=
 =?utf-8?B?VDFobXFGUzdScGtiVTF6b0FWU0dsTEN5QVlZZGNOWml0YmU3dGdteE15WW56?=
 =?utf-8?B?SmJrYnRiZDNCYVZ3SjVLQTA4L3VNNHI0UytIRWQzRXVhUklpY2t5a2p3Tnln?=
 =?utf-8?B?TkpOdXZJaXBzZmxXc25EYnNUQklURnNIQW9ZdCs2S3lEVDdlWldabzRyM0ln?=
 =?utf-8?B?VkxhcHo3bUJ6UXFQSDNwR1JSU0JWYWlic2tPR0RhekJ5ZE42UkIrZHBYMUdB?=
 =?utf-8?B?MGRUTFlVbkVJV3BVdWY4dkdwamk0dHdCVkNsMktibVJxUUM5Tnd0M1BLY1JU?=
 =?utf-8?B?Y3hNaUpHdnVjaUdYSlJHQWJUYmFhb1VaTitnQU12ZjJaZzFCbGxNY2t5N0Yv?=
 =?utf-8?B?RjVwQkc5Sk9qTU5STHREVVZJMUJKYytFbWhJZlFDdXlVd3VMa1h1RTIrOXVq?=
 =?utf-8?B?RWtEenFtYUR4VEsvMjg5dWRyRGpNTzdZdmVTVG9uQlpWaGMxQlpsZFFGVXMw?=
 =?utf-8?B?bU94UkJScXY1VlF4NGdBaWhHWXZXdFRhY1ZsY2x2Ty95VDRXNWplT3NOR1Jy?=
 =?utf-8?B?TWpiN3JQVytXcVZPSU1yN0JxNm51elJnOWRjd3RicHJmNnpvbkhsSXJCdjBG?=
 =?utf-8?B?OWJiRHgrdytLRlBTanM1UTZpV3ZSNjFodTRrQlQ5UU95dytPbVV5VlNFYWJD?=
 =?utf-8?B?YjVJMzVUdUpnSkdiaHBseFlmZndmek5YOUlIbG5SZWtwZlp4RU1SVUZCalM1?=
 =?utf-8?B?MWkxNGkxRjB1ZE9CQTVGZkQwbGpaWE95VGNBZjBEL0RlRE55YStabm01akJt?=
 =?utf-8?B?SGV1aHk1TUxEa2RKTzU0VndPck5ueE4ydjZSQ0NSQ0FkQmg2eFJYb1k2c2VB?=
 =?utf-8?B?ZnJtYmFQSDdKUlk2WTVuUDVHdkM2MXVwVlljTmRvV1hSc2syNDlCbEtkWmd5?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7cbff6-c120-4fd3-eac6-08dd34aa7c0d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 14:48:18.8147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BtrzL7k3NHPYMoDriqtANvtKfzZvusrZNHpMutm7qNvDHwqR/P6s0yKPWXF4bJkJWRVGKDJNY2nsY5On/GM5RmnJrY4PW96wNDRuWpZjhS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11184
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

Hi Tianling,

On 12/26/24 10:20 AM, Tianling Shen wrote:
> The NanoPi R3S(as "R3S") is an open source platform with dual-Gbps
> Ethernet ports designed and developed by FriendlyElec for IoT
> applications.
> 
> Specification:
> - Rockchip RK3566
> - 2GB LPDDR4X RAM
> - optional 32GB eMMC module
> - SD card slot
> - 2x 1000 Base-T
> - 3x LEDs (POWER, LAN, WAN)
> - 2x Buttons (Reset, MaskROM)
> - 1x USB 3.0 Port
> - Type-C 5V 2A Power
> 
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>   arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi |  8 +++
>   board/rockchip/evb_rk3568/MAINTAINERS      |  7 ++
>   configs/nanopi-r3s-rk3566_defconfig        | 74 ++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst            |  1 +
>   4 files changed, 90 insertions(+)
>   create mode 100644 arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi
>   create mode 100644 configs/nanopi-r3s-rk3566_defconfig
> 
> diff --git a/arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi b/arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi
> new file mode 100644
> index 0000000000..b66e5015d6
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include "rk356x-u-boot.dtsi"
> +
> +&vcc5v0_usb {
> +	/delete-property/ regulator-always-on;
> +	/delete-property/ regulator-boot-on;
> +};

Please justify this change, this seems very odd.

> diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
> index 588134ecb2..b2780401a3 100644
> --- a/board/rockchip/evb_rk3568/MAINTAINERS
> +++ b/board/rockchip/evb_rk3568/MAINTAINERS
> @@ -28,6 +28,13 @@ F:	configs/lubancat-2-rk3568_defconfig
>   F:	arch/arm/dts/rk3568-lubancat-2.dts
>   F:	arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
>   
> +NANOPI-R3S
> +M:	Tianling Shen <cnsztl@gmail.com>
> +R:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	configs/nanopi-r3s-rk3566_defconfig
> +F:	arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi
> +
>   NANOPI-R5C
>   M:	Tianling Shen <cnsztl@gmail.com>
>   R:	Jonas Karlman <jonas@kwiboo.se>
> diff --git a/configs/nanopi-r3s-rk3566_defconfig b/configs/nanopi-r3s-rk3566_defconfig
> new file mode 100644
> index 0000000000..f21c703ca7
> --- /dev/null
> +++ b/configs/nanopi-r3s-rk3566_defconfig
> @@ -0,0 +1,74 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-nanopi-r3s"
> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFE660000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-nanopi-r3s.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_RTL8169=y
> +CONFIG_NVME_PCI=y

I didn't see any PCIe connector for an NVMe on the R3S[1]? Did I miss 
something? The wiki seems to indicate there may be an NVME but that 
could be just a bad copy-pasting[2]?

[1] https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R3S
[2] 
https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R3S#Expand_Docker_Storage

Cheers,
Quentin

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97479C3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 14:38:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BB3C8006D;
	Fri, 16 May 2025 16:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IXhhspu9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35CF480079; Fri, 16 May 2025 16:38:11 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30CC680050
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 16:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypB+jUmMdg5tLFFoE/atQbdx8hwrMfn6dG6kqXjUbg45o6xVdCixhvf+MWNcgk8tQmHGvfubGQ0SrypEPttj4iFNPoYVcA3clGXFk5ZfQjYQLJgnp3dJHUGkvYCzCaGDpd+72lAGwgois+1uaLhlwqVdOtFAkxngvdoHVJZGXoRo1O9cCC6BfMRML2Pppxqgb2K/fkPeX7KgwZO8UpL+vgJn6zm0VLXU/IDAeqEJNKRBePFeuI3wEw4ZK56+dNMFyH55W57R1V0MRoT8n3e2pvyfUa2/cVtppsI83gyx1lzjCBJTIx7hRN+4t8UppAiEgJF+FgTCSFYYCsbwC1s+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hEgoJrm/hnrIbQaMcFDSb5k+pF6lvq3b6A9HNoGK4U=;
 b=IN7/ZaW+48cWsh6eyTazizZZDHdKvWNgLp8t4TrSJYK6y4wtaKh9Y4hXtaSAbQQMT0RZy9MPvrwumf0lRPTIjU3DBGIpBs5Ojeq5IQsDVUzsMijin5tiHCh6iSN40bnsHPGgQptG1YSQLEsnegJ2nzBFVVnOn18kN+gtj7lV+gLvxrTAopx1sLjEyky9dVkeSMVHnwo418zgzKM65XvoF5POlAccqAvAIdcgG4urqKAYIfmTCAqWEJ655QvlCslhHQPW5XUNKu65Qrqld1CW54p06rOkKIeIWKFAafSTPma2GKaLuNDFm2+/qrtGzQffb5fvXzeR16HsevRBLAGmAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hEgoJrm/hnrIbQaMcFDSb5k+pF6lvq3b6A9HNoGK4U=;
 b=IXhhspu93976A4m/fBax8EoNyBKvIH1H+K2CGMgW3hzC79/iv+xBTCxFhbKHXA1r+cX1uBVzk0Tl9eBnfkUsAMn1bYKHU6V27RUKdm1of4ZELrxdRxnNcFsFXPw8OqRGteqDronuKEk7mBG2RTnpSTKEznypsIJ1LT53W12MbmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8553.eurprd04.prod.outlook.com (2603:10a6:20b:434::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 14:38:07 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 14:38:07 +0000
Message-ID: <40a312c1-06ef-4e90-9260-e9f15e0215c2@cherry.de>
Date: Fri, 16 May 2025 16:38:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] usb: onboard-hub: Set the reset gpio pin before
 freeing
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20250425-usb_onboard_hub_cypress_hx3-v1-0-3cc5a06087cf@thaumatec.com>
 <20250425-usb_onboard_hub_cypress_hx3-v1-2-3cc5a06087cf@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250425-usb_onboard_hub_cypress_hx3-v1-2-3cc5a06087cf@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0234.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: 19fd2850-4dd7-4edb-1bf9-08dd948745e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0xwTTVkNnIrTXo5eEE0MEdWbTdlZjQyM1ZkQXFLdUNBd0QvOWF2QTIvekdO?=
 =?utf-8?B?UzZ1SEl5T0U2M0JCK0JWYnJIeWlOaisvUEhnSGY4TjlWMzllSmk5TWxSNjZG?=
 =?utf-8?B?UWl6UDV4NXlWemhGTldXWWQ4VW12MXlzN2p6UkF3eEFMTU5NKzRtSk1aYVoy?=
 =?utf-8?B?R1J6dUlnUFFzelJ2TExZOU5tbFlDMlVGMFYwZ1JucHM0K0dXTUN2MGU5NTJr?=
 =?utf-8?B?QU1YYUhPZUxWcWV0L3ZVenhGL2JvWW9mazd6M2pQZHVQMG9yYjA4SCtYSitp?=
 =?utf-8?B?SlRwaGo0YWpnRHJvN3NMV1YyeTI1MS91M3RsbC9OS0U2MllDcmErVW8rRmtQ?=
 =?utf-8?B?a0xnQmhNQXlvSTBKREZoclVJeU01UWRoa00zSzVMSEZaczUxUHZPc2xLaGdH?=
 =?utf-8?B?ck5IYXBjZWZsSWk0bXJlWTdkOWJ5RXJTU1NmM2FYR0dWdmE5TzZRNnBQWEtr?=
 =?utf-8?B?RHRuMFJZSUVlRXk2SUF5dXQxbzRDRjVFaG8rZGNYd05GOENnZ20yL1BqMG5o?=
 =?utf-8?B?VHFrQWtHSVlDckhKYXZ2N3RVZUNlbmlzemlTOFJ1czZ1bWZFZzRCS0Zhd28w?=
 =?utf-8?B?YmRpbFNvRFRJREVDQytjNC9vamxTOHdZQ2dxbG1ZcU9FRnpZdWViclVhQkpB?=
 =?utf-8?B?VnFseHNPKzF4UDh4TWhUNDFKTDdUbER0MnM4L1UxRFRnNWNpeEFDQXVoQy8r?=
 =?utf-8?B?cHV3OGFRaG5vTHFZWFFFcVl3SmZRMlBtWFRDaElISHhQTjV2clUyZ0VGZi9N?=
 =?utf-8?B?VFY3UUhhQWZPbTRCOFlRazFiWGZWUE5wQ1Z5eGNBZlNUWjhpN2QyQWRaYU00?=
 =?utf-8?B?S0FGYzRkOEtMTDlzNXpiRU11OFJGaXRlTERVUGt2YUhCcmQ5VmI0L3pFR254?=
 =?utf-8?B?UXZCeTBJWVJBWDhSSHZCTDlhTXZqZEc0SlQ2dXk3ZEl5SnpIT0lGSEtFbkc0?=
 =?utf-8?B?ZlBIT1ZSK011SXQzQXZORjNITGtEbUp5ZDNTSC9iTjVsVTBIcVFNYWtyQlVr?=
 =?utf-8?B?STZNbnQyTVJmMFA3UE9MWlBsQ1o1Qy9EV0VpelJ1b2xtaDc4d1A1elhoQ0g1?=
 =?utf-8?B?UDZUdVBXWksrME5vaWJtVE45YTZYbmkvcFBhbHBReUFHV1JjMi9vRElibmFp?=
 =?utf-8?B?eUZqa0hUZjdsRHEyL2N2aUJXRmpEWEJkRUxKOFRDOVlYNkFvWlRkcG1PcEth?=
 =?utf-8?B?YTJSQmtsWCt3MnpHbyt6QTBoaXRzYnVGYjFTcWVUZDBKOEFMUEtYUFFEYk41?=
 =?utf-8?B?VzJ1d3QraElVMXZpa3VOdXdqTDFhOTkwemdUdDlVb1RhNUpFem9vUmR1cHQz?=
 =?utf-8?B?ekY5QVI4bnhZMUk1akpIQit5YzZ5d3ZIcGxtTXdqQ0Z4WDFCOTBXVEdzTFFs?=
 =?utf-8?B?MFJvcnFMOHZLV3dLR2ZoUWQzbTJBZlhNNTk1N2htSVQ2dStDTS81eWJtVU9y?=
 =?utf-8?B?cHY3VmFUcjdHV0huZFRTclF0VXdHd244SkFuNnJ2S2k1LzF2QXdNaDBGZlN5?=
 =?utf-8?B?Qnc0bWpwTFhRMjZoRFhSSXorWW93QkdEOVkveWVramxnTW0rODhBTHNlaHJH?=
 =?utf-8?B?TmpUSWVPbU9tSS93SjBqSFVocTRETEtNT2dsMFN3SlRhZFlIYmorZStIOFlp?=
 =?utf-8?B?MkVaRGppckJqN1MzclRka3JNcGNDN2dDdGl3cUM1bzVzY2ppbFpxT01rc3NV?=
 =?utf-8?B?ZFQyd1NOLzZNNHpFbXVmVmQvZ0ZYcHpiSFk0djJuUmlKa294V2lYKzdWeXVV?=
 =?utf-8?B?YmtGS29qdGIyNEQ2UXU1U1lxaUhteG1QdTk4bGJTQkR4U3YvbHRCZUowZndY?=
 =?utf-8?B?eGhjV0Y1QWZOdTIrVDMyY0lZblZvNElxR0RtUWovVzFUcEhxS1FMMStmU21t?=
 =?utf-8?B?eFhEaTErcmVaR3BNdjdRRmlJdWg5ekdvS1VnL1dlZFdqTHZzeGw4SnFlRVBu?=
 =?utf-8?Q?NqOSuBSo39M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmJvM2tlcFJJOEFmbGkvR2ZROFZtU0pKeXdvOVFlbVUzMjNHQVIvbjFzNmtz?=
 =?utf-8?B?NGdDY1R6blkyUGRDcnNQZVBDSXhvaDY0d1pLTjgwQXp5VUJXUTN4dGFSdXhi?=
 =?utf-8?B?UThmV21KeTJHSWwrVjVReTFzU0pmYjZYeitHeXdQckJQV1FXbXlBWHRyME83?=
 =?utf-8?B?N3BsekRMaTJwNjZXbndVSEZvQnJ6UUtMZ1hoTkV4dzNFUFNyaEJHTGlhM21Q?=
 =?utf-8?B?YlRvWDZMOWVYVHRFdGhZTjB6N05RcVg3cFJRWlRNc0xtMXJMUWh2d0hNR21X?=
 =?utf-8?B?d2cwb21YNEFrVTlvTVhibE1xYUFlOHdydkJJckR3OC9kMnAwRitOM05lNTlY?=
 =?utf-8?B?SUhPdFdxK2t5K2hJVFMzRHkvZzkyRGRMTDRJUEtTT050NkltOU9EdmQrVy9Y?=
 =?utf-8?B?QzJsVlNMbHNPa2tEcEwzNEhYM3V5REQvOVNPOTZYcjFtZWh6a3F3WGtRbWRY?=
 =?utf-8?B?M1BWNnRoc1kzMFU4NWFTcVRPNCtRayt2Y1FhckcvVlRtc3lIMXFOUzhGR29J?=
 =?utf-8?B?aUNFbTZvd0RYL2gvRXZ3dm8rWWxEWndiYWJaWXE5VVA4WFV3Wm5rNE1kQWNa?=
 =?utf-8?B?MEhha3dnOC9kTmlZakQ1ZVZwN0VqekxqNDFDQ1RHT2dEdjZnVTlYcTJNRG0w?=
 =?utf-8?B?QkVCNElnSGgzaHVzcGdBa2pZbm5ibHlvcUFSc0tNN0J2UGVRalBZZDdhR3JE?=
 =?utf-8?B?Mm9lODBFK25ESDFwUjJIMEtHYVRxM1VpQmR2bUdOZlpkVXVDUTh6aVZVYVpo?=
 =?utf-8?B?SlR3YUc0NzJGV3htdzI2TjFObk1WOFloanhON0RaM29wZUV5QTlidlgvVjZZ?=
 =?utf-8?B?QTExenlLZkhzcFd2RmtYSnA2a0JCQlNPUGZFaDZaNy9zaStDOXpDTDY4L3BW?=
 =?utf-8?B?VTBaTWVMOENJbWNxQ2U5c29FQS9JZlllRFVSWFJReHNQSEJtUHB4TkJWTW5D?=
 =?utf-8?B?clJOOUFTYzlrSVVCYTE2Mys2Zjc3WmdzWFhjdFdLbTUrRm9VY0k1eVBUSlV1?=
 =?utf-8?B?UHVPZjdDZTdtUDhzb3dKNkpiaXl4R0MxNFh1Mlh2c3lTWnVyU2dnVmZSYXE3?=
 =?utf-8?B?WDhFL2ZGMWRtdzhneno4MlNmdmc1Wm9nQnU5SUtSckJRVFRMWjN2VUtpd2JE?=
 =?utf-8?B?OFlQRHNHZnRWUkp3NDdKcjU4VVN0bS8wbDcrV3JjWWpNRFpFM0dPaXRzcTJE?=
 =?utf-8?B?ZkFnbHg0L1ZmeGhJV2JQUThvRlExNlNhcHIzS3p4TElsWFR2TXBrUkxDY1hj?=
 =?utf-8?B?b2JOL1QzM25ackNNbi9mTHBlT0loU3FBQitaaXcxOGdRSW1LUjB2TW1FclJK?=
 =?utf-8?B?ZHgvVTJlaHI2RWZvVXBZRmxRd0E2MG1zZDZPT0R5LytpdmJDOHlLMDgvcHZS?=
 =?utf-8?B?bmdBaVFoU291TlFLVGlScUFMdGdMMmdxTEN1V1oySmxGNmxCUm5kMFJWeU9u?=
 =?utf-8?B?VUhJeEZyMWdvVDJqaXZBTy95YXFRQnpYdnJjZnRtWGo3bFdIOFV3YUo4VTgw?=
 =?utf-8?B?b3lWcS9HVGpSQ0J2RDd3Vmx3aWxoYmpmUEZXZHRabWI1SFZGamszczRIRnU0?=
 =?utf-8?B?Z3hhNVM4Ly9FRkp3MnNmR1Z4dEsveHpsVEs4MlBNMmtxRm1NbU9PSE1nWFZZ?=
 =?utf-8?B?ODN0M0VDTVJYWGF4OE05VFhkZ0ZXN3pMeDdMaEtJMWZxSzQ3NHY3UTF3bHBB?=
 =?utf-8?B?YW1rVjlHUm1tekFZWURwaTdqb2lGaDNiREVHRXBjQTg1bkZKa2VzQnU0akZ6?=
 =?utf-8?B?QlFpdkRISExJTlNMZEVDTjlnWGJWckJpMGFsaitTUFlOVmNFK0tmYnpXUHlk?=
 =?utf-8?B?K3JvaTJKbDZ3Y2VnYzZGb2hLcE1YaE42bmJ4QW1ySGhkR1M5UTlLcWdSNWJW?=
 =?utf-8?B?R1ZUMEhJR3FqeDA3YW5hQU5VL2tUZHFucjVNaU9pSVpDNE03Y2pLSWRRc0Ew?=
 =?utf-8?B?ZXZGQVQ1WExyTHEwd0R0cGJkUFkxSElaK3BpZE54QVBRSGJuQWhFV204Z3cv?=
 =?utf-8?B?Slp4VXczeE9NWmdmSWl1cUFjRXhSVUJTQWM3ODJpbkg3UVQ2eUxhSXlKb2VN?=
 =?utf-8?B?Rk9iQ3c0VVpyd0VaTVdnSkxxejByL0NTTG5TdmN1ZHFodEpqc1hwMkczekJL?=
 =?utf-8?B?MXpFb1R1K1VOK2dBMm5sY04wd1NWeTJTcVNDREErNzJwNnhxQlByM3NPd3BF?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fd2850-4dd7-4edb-1bf9-08dd948745e3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 14:38:07.2006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DwXFd1xM/m4JsonKUGHpB4PeydVUt1hyrOgBDMIVYCQhG2JPcGEGx5D/Ha+C1qrlOj2z6D75GqPFWungKaR4/Lwhn0O4s1IJkJX1ZmBq18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8553
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

Hi Lukasz,

On 4/25/25 12:56 PM, Lukasz Czechowski wrote:
> In the usb_onboard_hub_remove, the reset gpio, if available, is
> freed. The pin state however, remains unchanged, as set in the
> usb_onboard_hub_reset. The hub is then left enabled.
> 
> During second onboard hub probing, the hub is initially enabled
> (reset pin in state "0"), and then it is being reset by the reset
> function (transition to "1" and then to "0"). Because of this,
> the hub first disconnects from root hub, and then it connects again.
> 
> When the devices are being discovered in the usb_scan_port in the
> usb_hub driver, initially there is the USB_PORT_STAT_CONNECTION bit
> not set in portstatus, but USB_PORT_STAT_C_CONNECTION set in
> portchange data (which is because disconnect event occurred first).
> In this condition, the driver does not wait for devices to appear.
> This can cause the hub (and all child devices) to be not enumerated
> when rescanning on "usb reset" command.
> 
> To fix this, set the reset gpio to active before freeing, to put
> the hub into reset state.
> 

I would add in the commit log that there's still an additional scenario 
currently not being handled:

The reset GPIO is held high by default by the HW before U-Boot takes 
over, in which case the USB hub is active, then during the probe it gets 
reset and we have the same issue of child devices not being enumerated 
because they are quickly disconnected.

> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> ---
>   common/usb_onboard_hub.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 9f8c1a304cdf..325c274ed952 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -211,8 +211,10 @@ static int usb_onboard_hub_remove(struct udevice *dev)
>   	struct onboard_hub *hub = dev_get_priv(dev);
>   	int ret;
>   
> -	if (hub->reset_gpio)
> +	if (hub->reset_gpio) {
> +		ret = dm_gpio_set_value(hub->reset_gpio, 1);

We should probably dev_err here if ret is non-0?

With that done:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Side note, I think the ret handling is wrong in the function as we'll 
only ever return the return code of the last 
regulator_set_enable_if_allowed call or if no supply provided, 
dm_gpio_set_value.

I guess we should |= them all (but only call dev_err when the latest 
function returns non-zero) and return that at the end.

Nothing blocking this patch though.

Thanks!
Quentin

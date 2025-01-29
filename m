Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D46AC02190
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 14:16:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 984A480885;
	Wed, 29 Jan 2025 15:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="n/w1437G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62C1E80885; Wed, 29 Jan 2025 15:16:20 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A53D80843
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 15:16:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o05EOr8j6UYft9MyzwNs05tfpFwlK9rjb+6r562NfbW2yAD2UvFS5IV+TSQzgqVEmzU+qoU5hqfFZsVNPPVHUKHu+fcYAd2OQ+vebCucqhqnX76j0CUm8ShtJSKj4ZsnAMJzb8mCXCRBqnXZ4+vyyYVRxf602jpMOGpFfRmpJKBecv00kSTV/Z07CYsAHE4rx+5xBJBtG0oR6JzxkwgBMMV4pUW1lefvEA4roGywGK4iBJjPOn4L+0lleXiDb0xF6ukTw38uiWhEpzJTOUDRp4Gswieyv1gmZ28rQd237frYZPQWaS3rTD3uuX+SjhBiTh3B/dfBvkrLCj2o39F/Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xbht8UpRPcYCNEz6U5fD4vXi1WUDAxL56yMDGA1dp1Q=;
 b=t3keNWmfb1vV1eRKDtWpG1z3G+QHgMKrM+17W+VNn/c6CWkkcN1EaeM4CJu5ZvAQ0S+dbU82wquZeFDj7gtSN10gcOVzAEeQy/LmI7VEdq40tVDXmJ6ZUUpA1+z/mSnBdedeTLUCvyFFaCalrVa6OpIybAG/2X6hpcMWjJFVmpgUxguVk5iHk8Wb5Varnq6fKId0scMPMSJDscPhedi3fA+HUutpX1m5OLscCMDLY6P3oYd5oKn2T86VHZiNvgNTnwzX2nr6K2jVi74FR1qjqNHPJheb6MtZmCBH8nzssUyRh0s4XYfcdSWaBFrv3EuFOntrZq/D5OL9zg9Pj0eUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xbht8UpRPcYCNEz6U5fD4vXi1WUDAxL56yMDGA1dp1Q=;
 b=n/w1437G4J54uDUAxwltN3WT2JAm1HfKrSmQWF6567RSrAagw02AJ2dzrWXxhFXvStDc5OFc63+GUVgBfyzH9/NVnj7CiT171INyVOMArqgXgflBCD/Gk+6wYEAfg0WSz3UndUpXOjpZk5R2bSLu99PlS92pDDcdiSwPSDrpvtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PR3PR04MB7370.eurprd04.prod.outlook.com (2603:10a6:102:92::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 14:16:15 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 14:16:15 +0000
Message-ID: <d7c14292-1d74-4692-b981-8b674c005069@cherry.de>
Date: Wed, 29 Jan 2025 15:16:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rockchip: Fix TPL link error
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, jonas@kwiboo.se, dsimic@manjaro.org,
 pbrobinson@gmail.com, marek.vasut+renesas@mailbox.org,
 ian.roberts@timesys.com, nathan.morrison@timesys.com,
 greg.malysa@timesys.com, bb@ti.com
References: <20250129132529.807031-1-naoki@radxa.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250129132529.807031-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::30) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PR3PR04MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 89db01c8-14df-4df6-cadc-08dd406f7da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXNrbjYrbTNkVzcrRVNYamVjUXkyaHg5WmR6d3BQeTdjSzg0UEdMTGo3WTRk?=
 =?utf-8?B?Q2tBL2I5c1FrbE1VUVZUbGlwdiswc3FUd28zOXJLZnRvalZuRUpGQWpTajhP?=
 =?utf-8?B?aDVXMjVYL1kvMU1KZDVGSE5nVFZFMjVQRnk2RWtaSERRUnFjdmlBcXFwaGQ2?=
 =?utf-8?B?ZEpvQU05blIvUXhhMmtOcHdtb0IzMHBlZkI1anFwRm0rWEQrRVFXdjQ5RzFM?=
 =?utf-8?B?WmFjWEZ3OGVSY1F3S1A5Si8rNjljUHZWS3FpbDRFYWlmUTMza0R0VzliUkZV?=
 =?utf-8?B?VDZTU1FIQ2lRWlBUcXhGTW44eUwveWs0ek1La1dKcFRWN20ybG4waHYyNVZ6?=
 =?utf-8?B?cXVGZVA3TGRFQ0pXaGc4UzlNN1g4N01icEZ2RC9peldtcmpCM2R1Z1FtdTE5?=
 =?utf-8?B?VkZqL0NoZmdGMTNBRWxlQUc4UkZCTXRyb0NGVGpJVDh6ekphK1p2QWFpSEFr?=
 =?utf-8?B?YzRENU9aUWVpWTkwMm5iMUp0YXF1VEV0L0lsc0lyTDBKOU1GZHp6TjZEVVcx?=
 =?utf-8?B?eHZkMU1SbXdjdjBSQmhkeDN6SzVIRVNxZU82YVRpRkxOU3Y3b2RoNmUvcnVy?=
 =?utf-8?B?c2FsY3ZyU2pzc0l4ajhZZ3d5aXNtVDNSYUkzNWFsRFFydnRmS2MyOHI5RzNs?=
 =?utf-8?B?dmFnZzlhTTFyNHNESDdjTmpBT1RRMXMzL01rWEhJc3p2OHdLTlhCQ2QvN2dK?=
 =?utf-8?B?azlFOFVXVzlvYnFFOWw3U042aStEN0tNU1pibXBRNVRtMGljaENqZjVNcnly?=
 =?utf-8?B?aTN3VCtUOFNhdm9qcmdTZnZhbVVlUDFqdFdCQTcrcmJTWXlHODBwKytPbnkx?=
 =?utf-8?B?V1puTElMTUtYMTYwNkQ2NG5KWTVHamc2elBTbDI3NDgzSFl5QXVZaytpemdw?=
 =?utf-8?B?SmsxMFlOMlgxYjFIbXFmdURpZ2s2T2lKbVNVQmpRY1NzNm5rWmsyU2E4SGRB?=
 =?utf-8?B?WDR5LzIxTzBYRHBQbWxBSHh0dkVrTDF5N2dacjBUWUVxNWlIRGZ0MlVITnFp?=
 =?utf-8?B?UG1CcGQ5Z3R6SEppaVM3eitDdEptUGVOaldPbVB4MitvaEZSeVNLOXZpbHhZ?=
 =?utf-8?B?OWdmbUVqZHgyeDRLTFNzT3dlekpwam9QVU1iQS9UMmVEWXRsOE5HYmFVUXRG?=
 =?utf-8?B?ZmVYMmFwb0I4WG82WU52eXd0eXlNYzZTdW5peVFtSW8vUkdsT0dxYjR4TVZy?=
 =?utf-8?B?YTRXNHBvZHUyN3FBNll4UkRiN0U4dmdWZ3JKbVY2NHh2bWZJOHowd1NaNDNw?=
 =?utf-8?B?UFl6SG5NUXVzUFdmdW1FZmxadEx2TFFMc0prL1pMZG14WDdydjNvaHhqSDc1?=
 =?utf-8?B?cjA4ZUhWamVEcUV5TkdBRmZEVS9HNXVnZlNOcUlDYTRVOWkzVXQxWFc4cW1p?=
 =?utf-8?B?MGhZeGlhVlBMOThHeXdKWE90ZklFdWlIMlEvNlN4QU11b0J1S0kyRm4xbWF6?=
 =?utf-8?B?aklUcHpyMjBEbG5rZVpnQU5xbUtMTmpLa3YzQmRCRjloOFhRNkpRa04vbm1H?=
 =?utf-8?B?bmI4WHordXdVK2FDdXZrSE01ZnphandPVXhzT21GdStvUGRNd0NXNzl2THJn?=
 =?utf-8?B?azF6SkNwd0QweUMyVVhuNnZjR1JGYjRMRGgvQmFaV3F0KzE2eFMydjE4eFBs?=
 =?utf-8?B?WXloMmZPV25Bbk1wVklvSk4zSzFqL0dBUnN0Nk5xZ0F1ZmxRWkhKRnBkV2Q4?=
 =?utf-8?B?Vm94QWxUbVBGcWFXSXlZY0tCbXlNODNsb240U01zcGRpVURPd1BZSDhHUnRl?=
 =?utf-8?B?Tlh6QmlBUjRLZUJkMUtEdnVNaGl1K3Y0ZXBlV2dVYThYc29abWxyMHl4VE9H?=
 =?utf-8?B?STU4OENPaDRzVmZIZUF0eEEzWE03dHI0UFJkSU1vNlJjcmRCN3hvM2ZVUjFJ?=
 =?utf-8?Q?KX4juZJFNoOLt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1M2OFVONWlOYjJLRlpTNFY1bERJRE9Tdzk2WVJwQkduYU9xa0xPNWI0Nko3?=
 =?utf-8?B?ZFhZL3EzaWJOMW12TXphL002bmlsL3Z2eUtEb1UzRTFIakNOc3FmWEpKSFNP?=
 =?utf-8?B?TWRZdVBaKzVsUUk1Z0ZIQUs5dzR5WUk3MUdGUlorV2VJdThFUGFXZGRlTU92?=
 =?utf-8?B?clhvN2tha2RnM05Zc0NCVnRleld4eFVLZjZkbWxqWm5WNW9SU3Z2TmwxMWJ4?=
 =?utf-8?B?YVY4MjJZbmovTDBlYzZEQU5HanlsTE01NDZ4REVldXIxM21iSzc1TE5QR0ln?=
 =?utf-8?B?RHBweTlTZHR4enZCbXF0ak1XNkNuakdUTU5Xb1NHTzhxR2FmbGlzOEhJanlC?=
 =?utf-8?B?TWtFcUgrYWRHTWN2K0cyRmxqaE1WY2ZEN3F3c3JpT2c4WFVZbXlneiswYkVi?=
 =?utf-8?B?eGVCWGhhU2JRc1VibXQ1Q0pja3gvNDFnWFNPbGdVZlU5ZHdUNmU3Yk90VGZY?=
 =?utf-8?B?Um5URUhqSDI3SGhlQlBVU0lseFh2aDlFSzBFcjFNb1d5L2R3VTJWdExrbHlH?=
 =?utf-8?B?TjZqRnlETVFHM1diTTducGdVcVJjVDNXV05yZURVMExCMVRYTjQzcDdiWnl3?=
 =?utf-8?B?bHRxU1ZWUnphZVBVVUxUK2F4NGtoc3FPVUdPS0tnK3dvdDRWaHQ0dWVjcVJw?=
 =?utf-8?B?dzczN0p3djhqWjZPQURjVHpCSFRSN1J6UnVnSWNUbW0xVWNPRGllck1xUnow?=
 =?utf-8?B?Ym5jU1VLbmptZ0c5V0lzeStzRWczY29oMkdmT3Ezdk5INnBDRWhQeTB1R0tE?=
 =?utf-8?B?OHo3dU0vb1N4SmZLMjQrVGxzMHN2bktvRVF4Q3ZYcnBpOVQ1REt5Y0ZiVWV1?=
 =?utf-8?B?Tnh6V3NyTjlIaEdGYU5sY1dXS0RrRGt6aFk5YmI3QzFzRzFFalRzS2toUkJV?=
 =?utf-8?B?R3k3VTQ0OEl0ZnVGZHhUUXRKODFSMENiaDYzVjhEVmprRlRMNnZ1RDQybUtG?=
 =?utf-8?B?R09rUnh2VzNIWVg1Tk54WllvZnhLR0dmdk15aVBveXpxL3JwUWRDUTFzNDg5?=
 =?utf-8?B?ejdNSU5SeHZ1ci92WmIwQ1RjZUdsMUEvQnRLQ3hDRUpZT05GTXJ1TTE2U2Z3?=
 =?utf-8?B?VmdiUlVlSVV2VXJGb01teDZ4aXd4TjRwQU5sRS9xbUk5bVB6T2FYZmZseFVD?=
 =?utf-8?B?cE9uZEFWKytXaUdzRVk4dmtTTDlRMmpuQm9qemhXSmZqdnk1bzR4STh2bzFX?=
 =?utf-8?B?WGtwZzlXNGIvTC9KUjNMWEFRTDNNZlNpM1ZoblUyVzZxVnlmTnlQaHRDcFB5?=
 =?utf-8?B?eUs1Wms3UEk3UEg3cUFEMGxKbjlYdGFhQzN3UFBxM2ZDVkxpVUNxdWM3dWJN?=
 =?utf-8?B?cHV1UWtieldDaTJMdVJwK2VlUUJRVzFNLzNCWW05aFZGMGhkM1NYRjduaSsz?=
 =?utf-8?B?bjZ6OUhxYlBnZk80MW0xV0NoM1NmMUp5M2pWU1lyNjFlRkVYbGxIOTRQR2ND?=
 =?utf-8?B?YnZWcE9JTW1jdFVmaDM3WXZ0RjdzU1IyNFBvRkhnakpydVVCejVGRUtIcHZM?=
 =?utf-8?B?RGtRM1RucmJqcTBVck8vcHF3U21JUGVRSGJ3amEvdzBTRUxtcG9ucjRSczY1?=
 =?utf-8?B?eUdvaWVyazJkc0trQXlPOUVHRFpKcFFRL0poNFQ5QXlCOVhFZ0JLZ1o3NEk1?=
 =?utf-8?B?VmFsTFRmU2ZGTWwwUm1tMjYzSTRzNmRqc3BsbG5jQWZ2SFY0ZWNYOEZIYU5p?=
 =?utf-8?B?NWtBTTVzOEpNcGE0dVZSYmNqOG9QeTM0alY3dDQwWnlSS3p3NXAyNG5nMWhY?=
 =?utf-8?B?eTFRMzB1Ly92SXBKNDFjN25pRTEwMG5tdllIcDlsT1lwWndUZnVEcHBFZU5I?=
 =?utf-8?B?YzJGL016MkM3NUE5Q3Vxb1ZCdGtkN0NuSHJIQzBFQzdwbnA4dXh1MmxUcndU?=
 =?utf-8?B?UTE1Vm5VVkU2eGlEcWJxdmFBTWZWVU1oMG9obWxiVDdGMlRjdXpiSGp4VFo0?=
 =?utf-8?B?amg2TjFSMHNxWHo3WndlbU5pNUxoQkY3WThXUERDakNZbkFTSklYanFxR3NH?=
 =?utf-8?B?ZlplanVGbFZ3WnZDaml1djJVY3VDVVNWaVg5alhmS2gwajE3TTFKZjlpYVpQ?=
 =?utf-8?B?R00rYjluaHhsbTNtd2tJZ293ZVVGOE40emhnL00rTjBoM3ZrZ0thUEdIVVJW?=
 =?utf-8?B?c2VyN0lMN3lwQWp6clRBcjJYSlBwblZGcWxZUEpJTjBBVlpQa0wzMU81RUpV?=
 =?utf-8?Q?GutvD55V9NpW9R5G7PdF9eo=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 89db01c8-14df-4df6-cadc-08dd406f7da0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 14:16:15.2921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6XDiR235VDbdvkrRHV+q2QCP/Bnvnv2yYnCpa5xo52rbk65dUlzpowr0ybXK1O5O+1u0hfl0USZjAsv4cvtLf2od1j54MMH7IjeN3MuQuGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7370
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

Hi Naoki,

On 1/29/25 2:25 PM, FUKAUMI Naoki wrote:
> Rockchip RK3399 targets build TPL. If CONFIG_SPL_USB_DWC3_GENERIC and
> CONFIG_SPL_USB_GADGET are enabled, linking u-boot-tpl will fail.
> 
>    LD      tpl/u-boot-tpl
> ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in function `dwc3_glue_bind_common':
> /home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:527:(.text.dwc3_glue_bind_common+0x20): undefined reference to `usb_get_dr_mode'
> /home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:527:(.text.dwc3_glue_bind_common+0x20): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_get_dr_mode'
> ld.bfd: /home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:529:(.text.dwc3_glue_bind_common+0x2c): undefined reference to `usb_get_dr_mode'
> /home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:529:(.text.dwc3_glue_bind_common+0x2c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_get_dr_mode'
> ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in function `dwc3_glue_probe':
> /home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:683:(.text.dwc3_glue_probe+0xb0): undefined reference to `usb_get_dr_mode'
> /home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:683:(.text.dwc3_glue_probe+0xb0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_get_dr_mode'
> 
> Do not compile drivers/usb/ for TPL.
> 
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
>   scripts/Makefile.xpl | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
> index abc49fbe6c9..e4ca4d395ac 100644
> --- a/scripts/Makefile.xpl
> +++ b/scripts/Makefile.xpl
> @@ -125,8 +125,8 @@ endif
>   
>   libs-y += drivers/
>   libs-$(CONFIG_SPL_MEMORY) += drivers/memory/
> -libs-$(CONFIG_SPL_USB_GADGET) += drivers/usb/dwc3/
> -libs-$(CONFIG_SPL_USB_GADGET) += drivers/usb/cdns3/
> +libs-$(CONFIG_$(PHASE_)USB_GADGET) += drivers/usb/dwc3/
> +libs-$(CONFIG_$(PHASE_)USB_GADGET) += drivers/usb/cdns3/

I don't know what this is actually used for? Like why is it different 
from the typical Makefile we have for other subsystems and drivers?

Can't we simply remove those and add them in drivers/Makefile, like:

obj-$(CONFIG_$(PHASE_)USB_GADGET) += usb/dwc3/
obj-$(CONFIG_$(PHASE_)USB_GADGET) += usb/cdns3/

For example?

Otherwise makes sense to me.

Cheers,
Quentin

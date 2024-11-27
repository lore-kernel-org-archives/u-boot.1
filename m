Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0844D6ACC0
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 11:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D2EB897C3;
	Wed, 27 Nov 2024 12:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Cx9Ca62T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2D17897C4; Wed, 27 Nov 2024 12:39:15 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E7498977F
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 12:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCdtoqA2ebAI4qd0X0M+jnV+nqlKqiRxsUDWYvwvecwjvZQUJMX2lWb6STlOpWB7nFqe+D4FZYq7GV4L0OjwkkHSJTpvRY7Oq02p7sFQ10058pZ74s7nyb0QhAvibP67MHBPhppJUWdrvznuFHqyD08AUdrCC1qZ0NPEQWqW7GOvgjbieWw7OKLFkZAWM3dDsjmMwy1xT9lcjWW68RmbSkCDCEbdP+igzqyVGvu7Cv2oT/O6xmeYBDJACm0MBMYJXm8xALjyuKkSLooVwjgcOtt5X+rHZuKk+jNOmGZDWHBg+YV8oCRNLveInO4RAt9+utxiJqmcwoTA6qPIwG4meg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGbevhcO/oHfzCvmpx1qopSpXsp4EtAgy2djmZpd4FQ=;
 b=ZtgsCrjiXTMaOprm5RGoLeJax72NC0Ou8DmdEakB0RABPB1IqSWYrmGjibsCFUoe4m/JnGnDUc2QXJIKYgP7NmJtbNZ12B3kpYZ3zmy3TymAwzcCYN4fY5HhavvJ8to428JaSIDGJrn6rngHSaXVcsvnj3Fy8DAow8Fuwig+YfpY95/Kva+CocLMUKNQS+d+M47FQgyoVTyMXqudqlRjp8FxfEQyPHjnU4Ligi4oPmPJfAurVmS05Epl4SwS7osvJ7FLy06mRiNyvZ7rH3itHuNvZWIcANH4KzOqhm7dg8Rs/IdfFBJ+AFQYqyWtk6Au9AsItfID9Xp3tQBJnyKkVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGbevhcO/oHfzCvmpx1qopSpXsp4EtAgy2djmZpd4FQ=;
 b=Cx9Ca62TAZT5nhxOqPTnCEuKUMOb/Z6G3jarElcAsRhBwXjpvMYXUdC9C2dKViV79NMSPbsU7snV/BYtX1ytAKxlmNNkDAEJjdhG2VocZyzosmX5S0AJPE4FbG62b4N1MVDAeqgP3gjQZA1v44HhZGLqOBmr9i9nP+CdHTqwqrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB7670.eurprd04.prod.outlook.com (2603:10a6:20b:297::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 11:39:12 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 11:39:12 +0000
Message-ID: <c7b987aa-13ad-4fbc-b321-ef3ee161dd2c@cherry.de>
Date: Wed, 27 Nov 2024 12:39:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/39] boot: Split pxe label_run_boot() into two parts
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20241119131844.4078144-1-sjg@chromium.org>
 <20241119131844.4078144-11-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241119131844.4078144-11-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::25) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb70a1b-36ca-4eca-f217-08dd0ed81d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OThVOXE0bTA4L1M3V3BvdnlIM2Zyd1pkSDRLU1JJcHliTUZxL0dSMDRISitH?=
 =?utf-8?B?OG9ad3doS0hEZXlBZURndHhUeWVvNUFEWUE0TlYyaHpYVWRGbnJpbVk1b3Fv?=
 =?utf-8?B?U2VpVkhOYXBiQlp6K1d0WThKVHJVNERGcVF4ai9GLzA2VXgyTUNWNXVXMk9Q?=
 =?utf-8?B?czNWczZua1M5QjV5NW1TazZjSG9xckhlcE93MStsbDlZUDJzeU8yd0htMkFB?=
 =?utf-8?B?K3lpU3Y4OTdNWjUzWktlOG5RQWRpZC9uY2E2ZkQ0ekF0aXhoYUdJK05xZXRX?=
 =?utf-8?B?cktpWWFCN0hBaWxRZXZRQ0JObVlaM0t5Qk0wOE1sRFhxQVl2c3U3eExFeDVy?=
 =?utf-8?B?OXF3Mm9jZzV0SzRDSmRzaEFBYmliZUVORTQyb0R6b0dZYVgrWlUzcjBiNFJN?=
 =?utf-8?B?dGp5dkg0ZStnTmZITXcxQjJYZ0ZrWjh1M08vZkJrUDV5NWJ4bi90bEp2c29u?=
 =?utf-8?B?aXlPMlNTeWw4Q0VIMVVVU0gvNmhLUHdzYVB2VzJYeHh6MDJUbm1xeEFUTndy?=
 =?utf-8?B?OEQyYVQ0b2FvNndhbCtrVEV5ZHVmaXQ4VkNNQTNCZzEvTUREa0JkWnNJU2FK?=
 =?utf-8?B?bTMwcm5ZV2t6RHNFeWZHNEJwL0tSRTlTazRON1NnYXJJajk3cmZlY0pKWXUw?=
 =?utf-8?B?UFF4YzlicDlEbkFvVlB5QTJITldTQXpPbzhJQk41TjhFMG1hTEdyZkxrNkkz?=
 =?utf-8?B?YW95VHZJVVo3QlE2endJdS94RkFUVUlOVEhLT0J2Wm9UMEpnYTIwczBFNWcw?=
 =?utf-8?B?K0dHVmxWYnpFaWVvQnMwTVcyQkdXZFh5S2hWUk9CTytqUzVjTi90NFY1OGto?=
 =?utf-8?B?emlFREVNR1VGTmF4VGRqNXprdDZKVFRnSlpnK01taHYrQnhGNEpad2NJa1pE?=
 =?utf-8?B?UXhMZFY4dmFtSXJlK0l6N1FWVHFLNDJIQlBTNnc1cGNtSm50SFo2SzVwM1ds?=
 =?utf-8?B?Zi9vQVorK29RMDRGbVY5ZWxlM3duKy83clVtWUJQdFB5Z3NSSlZpbk5LQ3ow?=
 =?utf-8?B?bWE4Y3ZSazE5d1Axd1lLR2RuTkpSNUJidnNHd3hSRksra0pvTWhjakY1NmlL?=
 =?utf-8?B?Yk5rbVpIaFl4VGs3ZFJiMVVGRUNvc25PdnZTYUZSSVV6TlFLKzBjMkgyMzkz?=
 =?utf-8?B?ZlFyaWxTSWNxb3hCWEUyd2FwemxvdjJ2NC9hMGRUaWw2U2srOWlzVzJML1hC?=
 =?utf-8?B?UGxDUnBYaTd6WDYvdW1nQWNPTjVUOFJpUWh6UWk2ald1citjaWJKWCt6VVJY?=
 =?utf-8?B?a0lITXBhZjFjb3lVQ3M5UTNjZktLQm5mSFcxZms2bzdzQ3JBeVdHazlWdXJ3?=
 =?utf-8?B?VWRXZ1ZzWGswemlHUGtNNXI5dkZ4cmFzTnBCanNWc2tpU2dSRThYcjMyekpP?=
 =?utf-8?B?ZmE1V3BpOWJTSUcyanNGUzRQWDZhZVdsR0RCWmFDdWtUaElucDE0UnhYWDVY?=
 =?utf-8?B?TUtLOEVVcTVqYUZTMXlLWnVwWFZHRGRKWTIrRlRJemFYMVR3K2dnMTQ5QXZH?=
 =?utf-8?B?Z3dOUWhUcFQxaEpuaGxXbThEcjVPTnkxdzZzWlNKdEQ4QmFQZTVTRFc0V1RU?=
 =?utf-8?B?c3o2MW03MUxaMDgxd2RXVGZTZVliRXdEbk95a0JWZU95VndiN3NPYWNtMXVQ?=
 =?utf-8?B?VUV3SVJHTWU4aW5uRU9EK1UvcHM3ZGlsUllBTmxMeU1tSGdQUllkWVIzNEtj?=
 =?utf-8?B?OFBqajRIS3V2UVR3Ym9QcU1IRGhONXZPRGJmVnIvQWtjREpKd09jZHdWU2xD?=
 =?utf-8?B?bUdJSzdsa3JrWnlGTnRFQnpYM2h4V1RMdVgzaFZEcHFXQmF5cVhoYVFpaVpH?=
 =?utf-8?B?cG50VEVyK00xbk4wTy9tdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXFyamkvcEhwU2EyRkFzVUlUMEdxS3hDTjRmWWlXc2JmZ1hNeTNWRHVqWnY1?=
 =?utf-8?B?a1FRWXY4WHVnTnZaaCtRcS9TNmVYNDNxdDZZR3dnWVBvSjhnSlI2aDJSdzVh?=
 =?utf-8?B?WUhtTTBoUFFLQ3BCTGRXUVNjUzRPWFl5RlNZL1hhOG1UWHZiREZvTWozZGU5?=
 =?utf-8?B?YnJTVytKaW11QktjdHNBZUtPVG5SQVBNQUE5ak84WERISXY3Z2xnekFJbVZy?=
 =?utf-8?B?TTNDREZ0eDRFcDROV1ZQWkR4bjRSSkpvYldxMlg3d0hPL1RUVmNXcjNnMUNn?=
 =?utf-8?B?OENacnlqampDVlZBSnBwaWhVQndmM1F2NmdheDdsbVlMcnN2K2VNY3dTaDRy?=
 =?utf-8?B?SDNacVh0Wm94OWU4WkN2VTBYOHFvcE1kT3NrbFdETWlkSFZOdXhFNlZMc1lm?=
 =?utf-8?B?ZU9VOEVqd0FESGcrcWg0UC8zOFlXaU9aTlhyUUlCSW40SkFWZCtQT1h5TU4w?=
 =?utf-8?B?NVh2eENXU3RMam1mNHN5QW5LeDlia1VVTjRlbnZNdGtxalFaOXVyME9mM3gr?=
 =?utf-8?B?bTkyblUzVHk4RjVwdUNqNFpqWUExaE5Ja0UxZGFyRU5JVkFldWdPbDZOQ0dQ?=
 =?utf-8?B?Y205YnF2NHdiYldsUW02eDhJVjZZdjZoV1cwcDJXT1FscCtyNEVjbnRjNWJW?=
 =?utf-8?B?L05COTd1NnBBS2tFZGRVck92S1BIVXh1Nmpic05CVDhxaG9Da1RyZXJBZWRI?=
 =?utf-8?B?MkJLWm1VTUNmZlBZdDJoL1B1eUtxQldYcHkvT0FzMS9TWDJ6cWR5Z3BtVzRR?=
 =?utf-8?B?ZENBR28zaER4aHVnKzlXRjlQVjNmenMzdHBzdVRSekVtWThCNmJQbDhkTzRz?=
 =?utf-8?B?cVUzbElDL0llbHBhOUVyNkZVRm5FeHd5dGZUOFlOQmRWVkNDbTZIUTd1UWJO?=
 =?utf-8?B?R1ljd2hvZXRqRUdCR3EyZ05hTGk2c1pqNUthMHI4WVA1QWRQWkdLbXZHaGQ2?=
 =?utf-8?B?Rm9oU1NMTmVVc3Vscys0RDVXZWhhdmh4WDZoN043cFVEOFkxcUhVL3lPeC90?=
 =?utf-8?B?NysxemNUc2F3bzk2Yjk4Y0NzdXdEbVpqK094NXNoMlhURXNLYjE3ZnpQSzg2?=
 =?utf-8?B?K1A5ZXdJTnlBSlVpdkZQTEhwRUpuVUk0RzgvOERXd1VJZkt5QWZYejFBN0Nt?=
 =?utf-8?B?emNmZkV4Zy9yQzZJeE5NNGViWll2UG5qOVo5SkRKTjRYZTBUM1d3MlhwTHVY?=
 =?utf-8?B?Rm13QUI0ZDY0aUlHa0lkU2lLdldoUG00eUg3SjBvUjhQcFRKdzNkb0UwaXlq?=
 =?utf-8?B?UW0xTTk0REJIN1djQlZUbUltaGc3NWlIZWZNcmhZMHgxeUsxNEZwN2QyQTdv?=
 =?utf-8?B?UXcvNms0SWhIUFZvVnhTWTROSWNRNjk5emYwNjJja09Ydnd1dVZ4eFRmbU45?=
 =?utf-8?B?aHArV1ZYS1pVS3YzanBodEFaMTlOLzU2bmd6TytNU0FGa3ZPb1lTR05QNTV1?=
 =?utf-8?B?Y3p4cEtoYm9TZkwwbEtVTWEwWVZTQmJWRUE4RDFrUjAveituS2l5RWpTQ0Ra?=
 =?utf-8?B?UFl0WkFXTVMyUDNDTU1sYWlqNG1saDhNRm5kdXArd3I3ZjJDVmhIK0xSZU5h?=
 =?utf-8?B?akRmOVN0RE9hc0NZdkFERkEzZzhMRmVXdXRSMnVBaTNNRVgxTENLR2Y4ckZ5?=
 =?utf-8?B?TFlFSlRsMzZ6MVYzQVcwa2ttbGZUeFVuaXhseSt5SEN3UWFPL0NmRGc1WmdH?=
 =?utf-8?B?WEFMY1ZDVWR3bDVFd1V5KzRSZXVadktyVEhVSFFRK0xraHptZjhab0FHQ1ZM?=
 =?utf-8?B?OHhHaU9RcW9zaEJLZHpSWnBkZGJIOGJDU3JHWHFRM0FwYUttVld3Wk05d280?=
 =?utf-8?B?aHV5YVZUUFhVdW55VENJKzZzWWhCeGNUN1dUdSsrMFM0RXpDaGRobWJ3TlRs?=
 =?utf-8?B?ZDlZSUYxWlE3WEtHMnRnTExvT1dmVncvU0k0Rm5Gc1JsRXhFZnNaelJnOUVp?=
 =?utf-8?B?dUNQeW5SV01YRHA4Sk9CNWE1aXdrWEloRWtVcnJkOW1NOG54aGtyektlSFha?=
 =?utf-8?B?MGRzdEJncE02WVpIMFpsOXNDcXVRZUFjbDJ3bTVQRHd1eGxucmVEZ1lKWk4v?=
 =?utf-8?B?VU9xQkFnQTVRTEhqeFJwaVRyRWFtWVRDbWhnM3d6VjlSekhQeWV2Z0NoTjY1?=
 =?utf-8?B?THVwM1M2NnR2ZHJTTFB3UXpjUzMrejVCV1MvZHVUa3Q0YkJnbURSMnJuSkhq?=
 =?utf-8?Q?0D6pFmFgrdGHw8YV5PxfHLc=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb70a1b-36ca-4eca-f217-08dd0ed81d30
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 11:39:12.3572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfHe9zPR+wdKHqTUYbpKUqp+/td0f0UZVwjHwTq5Ex58DdGPUIEz/sDDXTnfernH9N/3q2ioncEGcholDyX96lLJcSd/s2IK+Ga9ZadFlGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7670
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

Hi Simon,

On 11/19/24 2:18 PM, Simon Glass wrote:
> This function is quite long. Split out the FDT processing into its own
> function.
> 
> Add a function comment for the new label_process_fdt() function.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   boot/pxe_utils.c | 100 ++++++++++++++++++++++++++++-------------------
>   1 file changed, 60 insertions(+), 40 deletions(-)
> 
> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> index edccb29e770..97dd5a36150 100644
> --- a/boot/pxe_utils.c
> +++ b/boot/pxe_utils.c
> @@ -432,51 +432,37 @@ skip_overlay:
>   }
>   #endif
>   
> -/**
> - * label_run_boot() - Set up the FDT and call the appropriate bootm/z/i command
> +/*
> + * label_process_fdt() - Process FDT for the label
>    *
>    * @ctx: PXE context
>    * @label: Label to process
> - * @kernel_addr: String containing kernel address (cannot be NULL)
> - * @initrd_addr_str: String containing initaddr address (NULL if none)
> - * @initrd_filesize: String containing initrd size (only used if
> - *	@initrd_addr_str)
> - * @initrd_str: initrd string to process (only used if @initrd_addr_str)
> - * Return: does not return on success, or returns 0 if the boot command
> - * returned, or -ve error value on error
> + * @kernel_addr: String containing kernel address
> + * @bootm_argv: bootm arguments to fill in (this only adjusts @bootm_argv[3])
> + * Return: 0 if OK, -ENOMEM if out of memory, -ENOENT if FDT file could not be
> + *	loaded
> + *
> + * fdt usage is optional:
> + * It handles the following scenarios.
> + *
> + * Scenario 1: If fdt_addr_r specified and "fdt" or "fdtdir" label is
> + * defined in pxe file, retrieve fdt blob from server. Pass fdt_addr_r to
> + * bootm, and adjust argc appropriately.
> + *
> + * If retrieve fails and no exact fdt blob is specified in pxe file with
> + * "fdt" label, try Scenario 2.
> + *
> + * Scenario 2: If there is an fdt_addr specified, pass it along to
> + * bootm, and adjust argc appropriately.
> + *
> + * Scenario 3: If there is an fdtcontroladdr specified, pass it along to
> + * bootm, and adjust argc appropriately, unless the image type is fitImage.
> + *
> + * Scenario 4: fdt blob is not available.
>    */
> -static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
> -			  char *kernel_addr, char *initrd_addr_str,
> -			  char *initrd_filesize, char *initrd_str)
> +static int label_process_fdt(struct pxe_context *ctx, struct pxe_label *label,
> +			     char *kernel_addr, char *bootm_argv[])
>   {
> -	char *bootm_argv[] = { "bootm", NULL, NULL, NULL, NULL };
> -	char *zboot_argv[] = { "zboot", NULL, "0", NULL, NULL };
> -	ulong kernel_addr_r;
> -	int bootm_argc = 2;
> -	int zboot_argc = 3;
> -	void *buf;
> -
> -	/*
> -	 * fdt usage is optional:
> -	 * It handles the following scenarios.
> -	 *
> -	 * Scenario 1: If fdt_addr_r specified and "fdt" or "fdtdir" label is
> -	 * defined in pxe file, retrieve fdt blob from server. Pass fdt_addr_r to
> -	 * bootm, and adjust argc appropriately.
> -	 *
> -	 * If retrieve fails and no exact fdt blob is specified in pxe file with
> -	 * "fdt" label, try Scenario 2.
> -	 *
> -	 * Scenario 2: If there is an fdt_addr specified, pass it along to
> -	 * bootm, and adjust argc appropriately.
> -	 *
> -	 * Scenario 3: If there is an fdtcontroladdr specified, pass it along to
> -	 * bootm, and adjust argc appropriately, unless the image type is fitImage.
> -	 *
> -	 * Scenario 4: fdt blob is not available.
> -	 */
> -	bootm_argv[3] = env_get("fdt_addr_r");
> -

I would keep this in the label_process_fdt function as it seems awfully 
related to fdt handling :)

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

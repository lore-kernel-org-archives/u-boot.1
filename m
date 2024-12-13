Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293F7E7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 14:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C4088012C;
	Fri, 13 Dec 2024 15:31:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IM9OOsVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B3B580137; Fri, 13 Dec 2024 15:31:08 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEC9480104
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 15:31:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dil9G7R0XLpqC6rKVbNaIWyjvJzQe3BFGDJTxS1Od/xfuxvHxSkGVKDB57QgiYvWWwBneJu9TK6AXeczqoaNrFv9OPpwJOJBP6E7N9MEhStYlMA7/6ZvHRZpCuCYinUON3nIDo/hRO/xnjJ8GcA02Xs3hemBLMoU8YEkmERqPhU2vzUrHYWq97xPRd4DnjucL8I/hXx2m+lyflUNq1j4Z62IJTI5hclXxevyewcTUrXP4ju/IjW5c0eSBO7mHB0igk+OvqnY1lswd2KP/V40w7NGeIygdgNE/kM5XWCxHhIUSSlJJ0T61kSr0EJ0EfuCeIFLfDP/JouH65pK4lVysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wC5cCSqiyPUN6H6bbwHkBLuQYEhLuMU6ziOJHFQVCw=;
 b=KgqtuI4S8Gw/4WKjADqLE8LhfG0H0vxUE3rOjzhLl194OeebN4SbLkFUMfyNFWfXA/eaHXMXj7OcNYebqJpvtAnQMw3SgEGPb+u20TZrnQZeBtH+/yxK2sdUGvC1V9FmUgVUvvOgYIkoTJp3ksGJk5B4Ks1nlVWc3x4WkqSL+eQhJTzc7QU0+qBetPwtrTxkdYz1/OIdG2GZpgwuJBbUXSXjFJ5yId1k1+KSF7TMMc04TZx9W0OMq/kZDJwrs3o5sl01uUmtrGe92UlbwOh5ae5/L6UEGn54h8ejRrDgnI/lO5o7cObvmquMkD+96VCOnGwIB4OGW2K/KYkdNrMgxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wC5cCSqiyPUN6H6bbwHkBLuQYEhLuMU6ziOJHFQVCw=;
 b=IM9OOsVeKCbVpYQn51xYYIYzpGp2kTCNu5li/ldhazMoM4QBDu7rpF5v9mRkN8TGbPbbFtBR1u7yiv/GcJ7WzEDji/QtHY0D5YfYKQxtPzEIWknogj+KF0VwMD/te8DQc5RMnIAuZElwqRT2Fhjb0giNltzwbAtzTi5SoebaUkk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10155.eurprd04.prod.outlook.com (2603:10a6:150:1a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 14:31:00 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 14:30:59 +0000
Message-ID: <8a6bb542-aeda-4d74-bdcc-8eace71eaf62@cherry.de>
Date: Fri, 13 Dec 2024 15:30:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] rockchip: rk3399-gru: Include binman generated FIT
 in u-boot.rom image
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-7-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241212235735.164272-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10155:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d4c1509-eb29-42a9-ba0b-08dd1b82c35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akxWM2s1UXNrVlBLN0RrRGxpWXhYQ3Q2UTVIS0VJRGFKZGpVRnp1TnYvb1U5?=
 =?utf-8?B?R2swU0xadTkxcFhGWi9aQlJlbysvaUtiR1dXRWxPdXVZNnhVMDJNTXJpL1VD?=
 =?utf-8?B?cGRRSGpTTHZ0bjFHMTNZU1VzdFdBMUhSQTRtWmdRVGFRRk5jK0V2UjRTd0Uv?=
 =?utf-8?B?YUJtSVBidkd5bldUcUpVdFJCazhHNEhTbGJ6cUp3NnlkM3AzUkNlMC83b3JP?=
 =?utf-8?B?cFVLdWxpNG0rNXpsN25mVlNjaWFudit2K1E4NDNWcmxUZktNQzE0WHptU01R?=
 =?utf-8?B?aFQvZGhac3FBOEVyM3BtRXdjLzBpcDR4a3dFd3Q0QzdTS1lqYkUvUU0yYVVu?=
 =?utf-8?B?SHJzUlFMWEpUVGdJZFUzNzBicThjZWhzZ3FBWWhDZVlRQVJHbjJOY3pYRVJF?=
 =?utf-8?B?Qm5heDkvV0YwM01NdGFzTTZQU2RvMlRkTEp2RTR3a05KcllDMmRyOHBRdWJR?=
 =?utf-8?B?NG5ZdkhDUkJubXpqMGFTOUUySmp2bko4Q0dCV3Q0ZHo5SERvdUVDcFY5RnN0?=
 =?utf-8?B?anlSb1ZSbHh5M0FSUDNXN2l2VHN4eXRwK2Y0SlZaRHZhUm9uTkw0LzRqMlYz?=
 =?utf-8?B?Mjc3NjNiRGNFcFNjSGlsZVdEcC9oTjMzQk4zTXJLTjlJc2RrRHBYOGNXMklL?=
 =?utf-8?B?TnZBNllKdXRsbHM4TUZkaUJwenczbVJsWjNoRTkwa3lLZ0Nqeno2VXoraVdn?=
 =?utf-8?B?TkFVVkhtOG5NY0E2MHByNWZxT2hFcjB0bTZueHJGdSs5MkRGU3FnKzJXL2xP?=
 =?utf-8?B?SGt3S3lYOUxLazhkdXhuY01UOStWZXBYK05xK2oxYU5acUdRWFlzcFYvS3F4?=
 =?utf-8?B?VGdxbGJtV1FSdWhCVGpsNWZYN0k0VDVpOG1IVmFuaGJyYTJRdkdCUjhqT3lL?=
 =?utf-8?B?ZHJJNFN2NDNKRUtNbDR3aG5FUDJWbHJCdTROZk5RZFVLTFZZZ0lmSWRHUTZx?=
 =?utf-8?B?S2FIbFZ0bmFiUllJMHByQUlMQkU3Y0ZTNFdQeHpkTit6ZGsvbjV4TUxVNzVl?=
 =?utf-8?B?aExFSWl6dGc4L2VnbGlsZU5Va3dTdEE2Umtsa3AzSDQxREhwblVZTW1Ja0xG?=
 =?utf-8?B?VWZCQ294cGNvZFFMdC8rSVpOZmNoUTM4YUVwRUlTdGNOVWJoaEtyamZ1YnJn?=
 =?utf-8?B?WDd3bWo2QUNoMXJ3TEZkWTFqL3VIbEluYXFYMGN1UEoxZHIwNUduVjJLRm55?=
 =?utf-8?B?TVJacXMvM0prWWUwT0xQOXJQMmNDaFRIcnVVNHpyTmI4SFlLYS9QNUNwbXJl?=
 =?utf-8?B?NDlwRVJQdmpROGRVbnJ4SmtkMXlQRklHR3liTEQvVWh0TmE4YWRVVEN6alJS?=
 =?utf-8?B?cS9paVRTWmVZVjV1WGU2L2hSWko2NmIrZHFLcTd0TGxSZnZkUkVXVzhHbG1G?=
 =?utf-8?B?ZVNPczFjbmdsSnRLT0UyYzVPWVRBQVJ4Q1g5a0RiOWs4a2RDUjBqQ3ZpT3NC?=
 =?utf-8?B?YUg5Q2pZU0xkQ1NKSEUxalBBMllXVEZhTW1BMzlBeVVDNmg5ays3Vnd0dlpK?=
 =?utf-8?B?UjZYa2N6Q2hHMS9mTXhjcCtkWGpsZ0RWRW1iSDRCMmNiWnpFZ0FES1V2S1Y5?=
 =?utf-8?B?d2pkU2xPekFuNDd6NU9UUnV5cDF3TlR2Nm9ETTRQVEhDWjhlMEsxMUVnYWZ6?=
 =?utf-8?B?QlQ5amduelpvMHlDNDFGTDJOSEc1Q2RSeDFIcXE4QkNreUVjU1RPTDA2QTEw?=
 =?utf-8?B?U2tqNllsd0I1WUJDeXh3Z1l2ZHBVNU5HempzRWltRVRrM1FvZ3hRQkVtRWJ4?=
 =?utf-8?B?UDVtdkhKUS9FTVd2M1N1T1BLRW1DcERFOTZzRm9rcXZKM0RhdVhHQWZIUUJS?=
 =?utf-8?B?MDJlOVdYY1IvVzIwT3JwUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3hYTDJtRFByQ0hTcUVTU2pSM3lMWmdOb01YdkZxcEdmV2ZTL1E5YXFtc1Ft?=
 =?utf-8?B?cGl1Rkt4Sm9PS0R5a21EdHRpbHZLaG5XN2tOYk8waVFFb2xZbndDM2VXZVFF?=
 =?utf-8?B?cDFuYkFMZ08xMjdrS1NudzAzT2ZtcVZLdVM1MVpaL0piN3dISTlwVlpoMzJT?=
 =?utf-8?B?SEplNkVqZjQvSUV0TjNaNW92cVY4Q2x4UDEwcHBvVXpZS2U0VTNYVzFnQkwy?=
 =?utf-8?B?MzR2d1NuV3Zpd3BGMXdLZGlMUzlmV25PcXZxcU05ek9VU0tObXZVSGliUFZQ?=
 =?utf-8?B?S0JIdUt1YnFlakJheS9LeEI5Q1NQTGllOHE1YlF0NXZVcExLUFVTK1RwZGpK?=
 =?utf-8?B?SmwraG8rR3g5aXdDV05ra3VKZnBqMnlpZFR2VHFPMlRiSWZxNjRHL1BpMDlM?=
 =?utf-8?B?MVVPNUVpV1FqTUtJN1h1dnhEWCtaV1dLdGNoNGx2Y1h2SVQrRjRzQnJ1RGRB?=
 =?utf-8?B?WXo5K3Yyd0FSMVI3SWhYS0orc3VQVnFqdjltYndhRFg3SEVEVGI4c0FUcDM1?=
 =?utf-8?B?UnlIdmVVU3c5a0lEMEVTZnVFYy8raGhzR2JxSnB4TlB2UzlXc0NmQ2JXajJ5?=
 =?utf-8?B?L1VSQkFYL2VXZVBRRFZsSkhUeWlnbXg2WXoreFRvQkZxSldKc1oySmxDeW1D?=
 =?utf-8?B?ZXluWHBVaU1SM2xheXEzODErWGJDZ2tSMFZPSUNGVm9MbzhZTkVEUk9mUE9z?=
 =?utf-8?B?cmJkdit6bXNEbytkd0FlYW8yU2ZoV2lVaStmNHpZTE5aZ0RvZ2RSWjRCUG1J?=
 =?utf-8?B?Qm9jRHV2ODNhTnBhZWpxOVo0aTQyWVNDbjhMVGpMQ2NSY1hrZklGamlxMEN6?=
 =?utf-8?B?TEROamh5R3lWMU9pUXFFVzV5YmZXUG91b2hpRWxRRXlwODhnV3ZJRVRMdnZU?=
 =?utf-8?B?bkVpd3JMTnJjTGFOQTI0SFZQMm56akVmeEJDRVNoS1N4ODZoUjA3anZZQStp?=
 =?utf-8?B?UmRiUTlqeVF3anBMb0JFbTZ5bmFhdXVYOWIxU0pZK1FuejZZZ3dUc1VrREwv?=
 =?utf-8?B?MFgyTWNBNVYwcFJaL3g5Z1JaZUQ0a1FvZ3UwcmErSEV6emIyYVhVZFc4S2Mx?=
 =?utf-8?B?U0lBbE51NXh1MlUyb3BLeGdIUEZaVEdjSUJZTlBUaWNRdk04MjBEZ3RWbEQ0?=
 =?utf-8?B?SEVFSnpUeUx6TllqZ0JJOE56d1IvMG94UlFoU3JKUnlnQmxoVXIyQktTaWs3?=
 =?utf-8?B?ZkRzaFBZcjdZN0I1MGRFNUk0dnpOaGJZOUhLZGJWMG9XRUdqQkVmMTJOUmk5?=
 =?utf-8?B?dldWNEZXOW5HdjBlRmhMeTRhcG8xZHh3NlBBT1ZsQjRvNHN0NlgveHU2dEt5?=
 =?utf-8?B?WEZqdkZ5NW94ODc1VXZSbm1IVW1CYVFUemxBeGgzRFU5anF4MEJ0QzVqQVJr?=
 =?utf-8?B?dlExRzRPcEYrNXFtT05RM2wwTGJhN1hUeXpKUlJVdXpLOURWTzh2WEdZMUFF?=
 =?utf-8?B?ZENSeGhwNW9WbkdpakhNNTJXYWR0dmpGcWhlZUVBN3hhOHZra1NNdU9hdHZM?=
 =?utf-8?B?MVV6ZVRHWEk1dnpWSm0vWFRkMVloSHV2V3Q1bkxZcGVWUUhmaGFIMTRWOVVw?=
 =?utf-8?B?b2dyc3VBZ05xOGh2cEtlQUxGbWZnQnlVYU1ramozTCtMMnk5QlAwZGNzK2E1?=
 =?utf-8?B?SUdpQXNqVkQrRVpjWm4yeUgvVlFjTmFrR2VBSlRZNlRyZnI1SDZsWUhCK2x1?=
 =?utf-8?B?SVR2eldUU2phaXNuT3psS3p4bndrTFdqWDhueXNLUTFmV2ErcDhZVmZXVm1G?=
 =?utf-8?B?Z1I0K09ERVRka2VSMjV3eG9CZXZidXpOSTNVb3hTS1hJM044MjZRaGVXV0Jk?=
 =?utf-8?B?cW0zZVhOZ3RYTUVKaHhvcFJhVXVVaXphMjhFS2lvUHZtdnQvczFXM01KdVhK?=
 =?utf-8?B?blhSbWl1QUtiNnZNODllN01POWttQko1VzkvbEROWXJSNmRaeFJXMjRPL1dt?=
 =?utf-8?B?M3lnZ1VEWkNDS05FQVpiOThUajVtS2NnYm51NklzTmVoNTZHdG1xVGF2eEYv?=
 =?utf-8?B?ODNXWDM1UzdhekRPbW0wa0h6anRpT3ZpMFUwV0lkcXNVVDZITWdKemJNMm5o?=
 =?utf-8?B?MnJreTdBRFlkWk8rMmxjRWJQRGl0ZXF4Tkc2dkR5TlExVi9Pcm5najNjbk12?=
 =?utf-8?B?S01rVjNBZ3dZNzErMWwwb3lVMkpsblNxQ2xQdHNaSUZBMzZ6MWF0dUhMK0dC?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4c1509-eb29-42a9-ba0b-08dd1b82c35c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 14:30:59.5382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P79KQc23TQNxWWbQFxiNBcetZDq5DKJtFkx5QU9jeNZ1VY+v3ihyB+r/lGoskgPO36Br0/sWzft6gaUVAJm3D7jNyyZcqRg6Q0x8Ls4LD2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10155
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

Hi Jonas,

On 12/13/24 12:57 AM, Jonas Karlman wrote:
> The u-boot.rom image contain u-boot.img FIT instead of the FIT generated
> by binman for the u-boot-rockchip.bin image.
> 
> Change to include the binman generated FIT for the u-boot.rom image.
> 
> This change result in TF-A being included and the use sha256 instead of
> crc32 checksum in the u-boot.rom FIT.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

IIRC Simon was fine with removing u-boot.rom support for RK3399 when I 
asked months (probably years?) ago, if that hasn't changed, maybe we 
should now.

Especially since the only RK3399 with CONGIG_HAS_ROM set are Bob and Kevin.

@Simon, you said you tested the patch series on them, with which image 
did you do that? Are you still fine with removing the u-boot.rom for RK3399?

Cheers,
Quentin

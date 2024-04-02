Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C55C6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 11:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 574288806A;
	Tue,  2 Apr 2024 13:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="L4GRC47Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B1268806A; Tue,  2 Apr 2024 13:11:11 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 759E2880FE
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 13:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtwP0FdmZ0beJL6AXGSkN19+u3ostSi7q5KVway0ewEfQbTHLTYEJZKesCp1f9PjaYY/9pkC/alxy8GPDgQvZ8qN4eZAWYa+3/XkbxzmJ2cgnET4aKwFE4nAelPhWOZZGrwbPEF3fZF/OCpvRVDqYJRqzZO+b8LIU4By4MNoSXhY9k7Gje03g9jwxQOJTqLwTVXPr3OPx/M3VZIoVEp51LtP5m9rWyXIgvB5y4aKjgkHVToDvlNJPn644FfNJgnFbWMezz/4+hW9eJDBRnsjmWLLAwKk5H1yuahtsGtm12Z6v6dJvgWc+8ysVM8QyckF4/iqnh4B5LK+fMnLKum9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70dKrzUHsZ+TKi2cqGNW3ZyiivJzMQDyeFNb0YTVqHo=;
 b=Lpb/GLkv/GpyHnRWfke9dzpm+GMNB/nEwZ0/DhvWpTGyyIKE7d3o5HsIkL6NWSdCRiLCEPGWMdB37VNTIZaV42wuxSRndiicyB9aqmMHctZepe/gAi9Menz6n0SYw5naO197k3Hn0IyUFD9nmfq7i0PmSsDi1YsG5v8ULrLEQwln1Xz8dAlDnGtnqO8kNPhVgz3hrfq/PccFpNg+URG4jIT6muNvajBUZJm5LH4d0gc+R66dMsHXe/6VXy9hQfo2ywRavR/uHsejo685YgpzCiVHXVIBVABr1tnlkmGPGFAG1/9mpifcZNLDUemSEefx/Duh2Uk2lK3v4ir02dhAtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70dKrzUHsZ+TKi2cqGNW3ZyiivJzMQDyeFNb0YTVqHo=;
 b=L4GRC47QEEgDlj3rbuu0t9sPYiro2WerXzJLYm6Vpa8s7O8wI1OkaMiDVlXBCzPLaEnj8ulZXOjpoYaxMLDlj0McPUYv+IFnTnsYg3sOj+yCWRrWcDJC0orMIisqSvL/numeuOSfsuHBf9Wc6twn4rmFdWKipvNiiz8+4difCQpvG+Pn8fPeVZxFo4ycOqZnRJue86itDLKZzE8kR7ffS9pfj6J9JQYEIm8g7+0DgNyU81NyNFG3uA6u0UcqGNJywtPUkH04zvZcVMugkJoHOEObyKHz4O1zYevf1y4bHzPq+kRG7pwHtq4TeUX/UNGbt5fYiH/wxlX+ehUYXO/XWw==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DU0PR04MB9443.eurprd04.prod.outlook.com (2603:10a6:10:35b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 11:11:06 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 11:11:06 +0000
Message-ID: <d210412c-ec9d-480b-ac0a-da7976490f78@theobroma-systems.com>
Date: Tue, 2 Apr 2024 13:11:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/19] rockchip: rk35xx: Imply support for GbE PHY
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240329190224.3613471-1-jonas@kwiboo.se>
 <20240329190224.3613471-9-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240329190224.3613471-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::8) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DU0PR04MB9443:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iD1YOS8uzPPc/O0udlSN0ZTWwZaF5pPmKhftjgLMiGE8eqCY1+lWeSGwpl2LPE3D3jPx/iyUKnBrqFeM5kSd6cfxbSYUCOMHJzujkl2WM/NlHO75Ui50McSe2dRgYjUnI0wnYcPOCtneo9gh8KoEUHHOte8LymGkpUk4rlj699VuublRPa0PimSoYaRo4XODNYFn+fL7PFt2XcTIEpe/9e/e7/phcwimVlvVWMc9x4AuDLdqhn60fWDFsbhsMiLv4mtdu45reLnHyn/EPQFvXkhfY6HsOthDO5DItJlNLYuh2VWJAIUX44q3mVbFvKmlL/xYtSPyYaT9o2r3HgmeLS4fVUWQR7sToC8N6qqCVyuaYDlq4C782Ckh4iL3I/+BfxlMF6LVi0Fv0UZtrR47Sf7RX47rDSjsdIBNqjJB8cVUyMpVsgSGxbeepm6TuXRn8F8L9CFYLGnyz45jbbQSHsB8hFJt3BaiyW7wGLKYjFbKUT6CsgVWf1+6jaLZeS2GCGA50zmL/bQHR93ty2Y7cVOGi3kOcRvwnBgzylUWV8h71mqJZvM0+glFOHAbVq++53RdFozg2RqTX+2uNVAq5BTrJ96rc0EcekKWL/rP0o9ZPhYAd1yJAlp72WvslJWw7alzFIeVrNyvpsrMGbaJIhOJ+JthgqMaW7zpLjmHZJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWtCM3BrbDZmaFA2aUwzcHZvd1p1Uk1pTEQ5REhpSHhzam5jRSs4NFZZNDZE?=
 =?utf-8?B?Z1JuLzQvY203bko3aTdZWFJjMVJlb1kvbXJpNjIvamdxOUpmaldWQjZ5dkZY?=
 =?utf-8?B?eSt3UTBsdnZEZitZTGxjVU91RUMxOHdJWHJjU25YTDFKSmJmaTVDQkcxRHlE?=
 =?utf-8?B?Z0R3NkN1VTAzSUdOdWc0VlZqZ3lZdkR2VFJhVWNTcExPc29HTUtZTXYrczFC?=
 =?utf-8?B?RUpXTFV5ckU3OU1sT3RLcS9GTUdCVi9OU2FheWlodjNIU04xeW5vcW5IUDR6?=
 =?utf-8?B?SjI0UTlCaFdLY0lRWjJTQkhqb3BiYm1rVUo3OXNMTVVtbmpLSXJiL3dCcnVw?=
 =?utf-8?B?SUkrdFJVVkpxR2pBUFF3TDBlV3lKcHdPMDA1OFhZQVZLbXRxVVFTY0Q2N0VH?=
 =?utf-8?B?M2xKamJuVWdPWHMveGhSUXlBTEZ1RzcyYVAxUm8rb01jNWhadHVsR0JBaHY1?=
 =?utf-8?B?RkV6azZBQk1RMmdrM3NEa2lBdXd3OUV5dlhsM2ZybG1kQ0tKdCsvYnFLbkZR?=
 =?utf-8?B?RWlNQS9qTjJpQUlNRXpmLy9SeUlLSHVjSXdwaklyV0Z4VnVKT05wUkdGRDBq?=
 =?utf-8?B?dWIrYjBsRjNHQ3J0WTFVUkN0Mnh5eDA0Zm9YclkybE5zWlRyTG1wUTZSdmFV?=
 =?utf-8?B?TjVZb1ZkdFR2ZzU4bUtaNDdFb0gvU3oxWUVCZFdhUExCQ2ZiT1FYOWVjdWRk?=
 =?utf-8?B?blF0NFpyN0JEcVlGZlEzWEh1Z1hBVXpmZHplQy9aa2RSd1ZMYzR6T1dXeEFv?=
 =?utf-8?B?ZWNMZEdIelFtZ0Y3Mlo1OGhvdVJHUjR0N1R2aENqb0l4RCtCM3I0cFpwa0hF?=
 =?utf-8?B?bkY2UzAybWpxbU56QTlQTmI1cWJCYkFLcUZtR2doRzdLWFh2ZzlHdnBjYS9H?=
 =?utf-8?B?WGsvbi85VGNBbmZONDB5VzZVK0pVa09oTmZjMllKUHZ6N09sT2JyMUZDanlB?=
 =?utf-8?B?VE1zajcybjJTYnhtb25sWDloekk3T2M0eWw0K3U1MENWRms2bzl1bzFFRytx?=
 =?utf-8?B?Y3d1eGI5Y09EZUEzZUpoRXVCU3lOdWxPdTB3NEdncTdBSzFvY1RESVArY25k?=
 =?utf-8?B?NjEzL2ltQlFiQTJiZFJqbU9YcndRWUE1cnY5eW1RZ3czd2pzYlJSZ1JEL2ZU?=
 =?utf-8?B?NGJtMUU1SXBBKzVqamFNMDkvZHFkakpxWUtjY01YRTVLc3NnL0VFM2JnTEY4?=
 =?utf-8?B?RGtqNi9ZL3AvVDJpb2hHR3ZZZndtNmZBSzh1RDVrV1pxMlhJVDZpNHlOQUNV?=
 =?utf-8?B?Uk5IUDVOUlpOMVdIWmQ4NzZXZ2JjcVF0Zmd4S2s3NDRUK2FVVXpZYW9oT2tL?=
 =?utf-8?B?OENBMFM5WWFBWHhRMzRYS0J2UUZkZ3VYUE01WWFneEJCZjdiVVF3K29hWTg4?=
 =?utf-8?B?U3I3YnZPYlZYTDJsOGlGbjRxNDZrV2ZheEhKbWhUWVMrNWFXaVNYTmpTemhL?=
 =?utf-8?B?VCtyTHBldGxUVUUvd0x3bWlxWUdhdnFiZStmTmQxd0N1WDhyRmxRSGtJQ2Js?=
 =?utf-8?B?Sjg5aTA4Vkx0eldQMVNyMTA2YUc5OUppWUlnc1ZqYUUwNElmWFNUbm8vTEJU?=
 =?utf-8?B?K2VIUkdLUFhrbG5FdjlMVkd5Q0ZvMHNJM0gvQUtiNUd2aEw5ZzV6SDNWODF5?=
 =?utf-8?B?SEt3NitqR3NJNGVxRDV1R0VVU3BQTzExRkJzWERPZFMxcUIrMkRhZUIyQ2xn?=
 =?utf-8?B?WUpscFY1Wnh4UFhlcU1LRzRJSXk4WEVzbzZ0YW4zVkhaaDd1UlI0WWI0a3U5?=
 =?utf-8?B?SnRuakZKTGVYWUpZUGc5QmFET29rMHFneVBwcUJtRnFWOUFXcXNlUDJDZmZI?=
 =?utf-8?B?cGNxMVk1WUNWR3U4azJSeEZtZ2N4dUdoMFMxdlRFblkrOEd6RkJpazJXMkdZ?=
 =?utf-8?B?M0NLSUQ0YjBzalUvUUY2V2J1N2pCRnZhZGZzbU13VmljQk1rL0c1djdVRnBL?=
 =?utf-8?B?N1gvVWdJRWdsSWFKLzJKSFRLZ3AzRS9WMXArZWZxOUpXVjVoMElSVXhxUEtv?=
 =?utf-8?B?aCttRUJVN0dZTVZaNE1Ka1lwNHkrZWxKOGtLck1ZK2diWnB2Z0hHM0ZRTXNF?=
 =?utf-8?B?K3VTR0xnMGZ6Qm1UdjhUSGcxazk4V1Q5Zyt3dW5TbFZsMHBqR0hJWXQ5d2ZK?=
 =?utf-8?B?aGtwR3hZd2hSYzVRS0g2VUR6WVRRREdVTFBYcTN2dUJLTVd5QWxoNGV4VDNY?=
 =?utf-8?Q?gnx1w42bhhNscLZyM5L4vwI=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab6c99c-cb85-4fb0-8dbf-08dc530597db
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 11:11:06.8668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kaWjmH/lKEN8IqqHg+ALu1r9oplntUHt+KUKC9TCg5w2u8lF5ktnaBU/J0AruYqYn02+tyLlE/EbAmY3E5g3gBys2soDVb79bDfkC2FjgH2FWu2TtkvA6SdTm5XqSTT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9443
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

On 3/29/24 20:01, Jonas Karlman wrote:
> Imply support for GbE PHY status parsing and configuration when support
> for onboard ethernet is enabled.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/mach-rockchip/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index d518913f8a37..d85b59a92da2 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -316,6 +316,7 @@ config ROCKCHIP_RK3568
>   	imply MISC_INIT_R
>   	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
>   	imply OF_LIBFDT_OVERLAY
> +	imply PHY_GIGE if DWC_ETH_QOS_ROCKCHIP

Is this really something we expect most devices to use?

We have two products based on RK3588, none use it. If I'm not mistaken, 
Rock5B doesn't as well as Orange Pi 5 Plus, RK3588 EVB, Rock5A, (likely 
not the Edgeble as well since they have 2.5Gbps connectors), NanoPC T6, 
IndieDroid Nova, Cool Pi 4B, Cool Pi CM5 EVB, NanoPi R6S, Rockchip 
Toybrick TB-RK3588X.

So, I'm not sure it's worth it making it the default? (Even though we 
could remove it from the defconfig manually). Wouldn't this make more 
sense in your generic defconfigs?

Cheers,
Quentin

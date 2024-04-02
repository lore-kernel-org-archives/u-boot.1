Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551A6CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 13:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C777C88157;
	Tue,  2 Apr 2024 15:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="L5C/q4IV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDD9588124; Tue,  2 Apr 2024 15:22:51 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20713.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::713])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E7B58815A
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 15:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0vqtRARtoJEq8ZgViBiw+XM0gXdGFtbyNzz5VWHhvd03Xu/d19fx4XybiBocmQDi31S2O3/mSpmEot7RHqxb5Mi/L8MnWVIUcWnc3Y/M7rYFqImad/baLb6pOfuOhHqCsgemEyeRRbhFTAc0MJUECH4KU8AbkeHECVOuyl1kFEmnK0JXyqbI1DH4Q+l+iKxifyyPZA3p79Lo6I1c10nDzcYnyqi1NPSHI2EK6r0xM6uDBDOTy4qQVuHfQLLznSJKlhLVI1UK0YIlapvNsR5xL+4GZ/K7J+AW7ZPyofkj1ofSWv3eZc6qtFO612Y/xNzCPjjBuWfgV78Cg9RumlmZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5A2EHHoS5jcNBYxgb71HYTJ4NxqZ/Yf1Nx4N199jmQ=;
 b=Bp+X2DBA2Zwx59UkAlgZ1dX6Sh8h6jke4fuVKPOnGfGa3mM9611wtP61Ka+/cVjTMeJzSTzP8lP1qY5ejpXqCTOGaUeU/dT+elPiNlD1DtQIppqCM+QTA5a/2glt6UnjHtNJdwLL9mC6x/xsKA/IVfOIGnjqim98AVgMwd1XNsgjgk2VffLXiI1gVnUDEPBJtn8fN0GkRFPkPSjL6SsASrnpG0MxKujOzydGdHyePabVa2Buut7wz1sfU7HtfPqOBl2ErjNO15UAlLRVKP47ymqBcym9eXrTRScFjeLvIy/8c9wI8PJXXjlVlH++rf+GKrCGVRJaMQ/yNyfWaaQNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5A2EHHoS5jcNBYxgb71HYTJ4NxqZ/Yf1Nx4N199jmQ=;
 b=L5C/q4IVxTxapFiTgVnDDiFbgi9lFC3NjChIiVNDpaGl31OCm7sta7YNrT+YiDlR2q2m2L52bQm8EgwANEjYeIdCw3DTLRYgAqTJTHMHDJuh4TD0kRL2FSSNcSIvMqhXIAWYE/hsITf9n5yLe/OoxmQoTjkirt1V0kvKyZKIuUUKj0WksBiWszXTExlPFn6VLWRBvmv9ZhtWxMn9vpJ2TO7/KhGyCaqmMAXNQkpb83Uck8A4gEQi+0iEQ0S7wjS8vQ9fmIM29SpjjlggYbt470Ot6QVKvRkLcTUVT/q0qMEOZqwK5GD7HKjXkJpdqxN0c/O3wzDK84ATDeBf9Z5PsQ==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AS8PR04MB8053.eurprd04.prod.outlook.com (2603:10a6:20b:2ad::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:22:48 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 13:22:47 +0000
Message-ID: <758118bd-e7b5-43ad-a9b5-4203afc058f2@theobroma-systems.com>
Date: Tue, 2 Apr 2024 15:22:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/31] rockchip: rk3399: Enable ARMv8 crypto and FIT
 checksum validation
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-5-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240331202921.262323-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::7) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AS8PR04MB8053:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BxYdSwvY925v6dbdfhNVvtNdsRZiK1ggfkByFq3fBArRVn6BBNW+rbWGqpu1SGx9BN9kEZuncq4dFJSC5HSm30t1va+n/ZnOiCvPWLT2ZzwD5JEyXTlszBIXd3QwmRwL7MKTkELOebXGmuJk7IwQzyvqWi5N8hwzoyjPOaOtbSd6X8Ftd3D8AB4H+yrgX7TIMrV23+uCV86re4AM1PBASvtW+efqtvrQF8QB1YiG+O2ksHbJgyKlYLCxjFXHqP0wPnZK2B3wOj5i/qsSg3/KcMgPbVdIqJpgILJjJChJinRxMiJZBd8LJdYfYkPfK9xDFNGypo1il68/doQ4kbHqJl+hT9hEIf/ADhe3k22Z6hOPVmHKdxmtzulsle4kvnKWhLNY4DCm9hhQeEsUVVDCbZRw8oYHxnO7Z4ZQRQgPRvueddnJGJCyb5rA1TtDGIoWOsYOBDGVN5Eo9PZ51YZ6c3SuQjDv+vwm3GEBDEQS3+r1YEzPyisEOwA8YTZmGVvP66n9cYVs7HLxLErwW9S5aJeR57QHKdG8hK6RbbXhPwZPjjboD4Pth6JwB/6w7tRDm4jxddyXGYZr2xJ+jDPfVCYt3AJn7M6GF/K+IpW7AOhiWkqLaZp+GTb8psHMzGFvGvS4Konv5+c/2azc1V70bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(7416005)(376005)(1800799015)(921011); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFJCOWFPSWtoWHJyVkFFdjZqZ0RGcG16bVQ1bDJ2YmxHQnhGbmovbHdHb1JN?=
 =?utf-8?B?cHU0Tjhnc1VVU3JhZUN5cGlzTTBYRkxuS041a1FzbjRsaHFlSzdsRndBUnlW?=
 =?utf-8?B?VGJpa0JsWW1lbSt5QXh6ODdDUEptTGMveUFaZDRpc3lPSkRnUVhMN3FOeWh1?=
 =?utf-8?B?MVpjNitlOTZ1aGlHZzZRUVljaWpOWi80SDZPVlY1TVhxb3c0M2JQZ01vWGRk?=
 =?utf-8?B?N0hhRjQyenc4Nm14SFJqUWRVZ1JueEJjU3pSS1JybjVMYi82dEh5aDNNdzVm?=
 =?utf-8?B?R0lGMkxyMkkzTzR5YVZSOC9VNGoxdjNPaysvNTR0Sy9zTWRTeUVaQ1FsU21z?=
 =?utf-8?B?Tk4rTGM1THJaSFJvNTE4N2w3VWp3cVNub3d4OXBha09EZDlzNUlxS2dqMUhs?=
 =?utf-8?B?NG5DNmo1Zm9mU091aXo0Ulk2c01mR2tmUkxobFVvdVVqckVJemlJbm1RV081?=
 =?utf-8?B?ZGljNlAzK1JNVHpudm5zdUx4TFFuTEtiK1pzRGQzMkhaRTBJeXRyK3EzZE5H?=
 =?utf-8?B?N3lNd25RRHByUDVqVmxQcmFZTUxDTmwwNU9zeVVJTzcvRDB6REpTemtZdGZG?=
 =?utf-8?B?eDFjb01qM2NQWnFhTFZJUkhGc0I3K2s3aWhkcStFMk9vSXlnS0NtMi8zRjBr?=
 =?utf-8?B?bFlGMFU4R0JpS1ovYlVWMHB3TjNja1dxSXlOclJHVTJRbjhZYmdSWFQ1OG04?=
 =?utf-8?B?TkVQajU0UXk4YW1JTjhFUDk5OCsxWENCVWVLSzh3UnRaeUsrVFpHSndmQ0ZH?=
 =?utf-8?B?YUo1c1RDMHRZUi8xOEREcmVOZHl1TUZrNHBqZFFSU1ZvZ2lQWlJ2clViZWVO?=
 =?utf-8?B?ODhrZlZMU1liNW5WQUV6ZUYvNDNIaGl6NFV5THIyb3dtOHBIQnltVW1Bdy9J?=
 =?utf-8?B?VE9ncEdNcjNmOTY5QjZremxSTmU1cWJ3YlFGdkNlV0hXdHF0N0c0bi9vV1ZN?=
 =?utf-8?B?TDdxUXlBU2h2WWE4UDFJYTIwZmdxcm9MSHZqODBXKzRjWEZaWEFTckp1VE96?=
 =?utf-8?B?SG9QWFZ5ay9qSENBMFQ5c01Xdm1GRmU1ZUFrRVU5RUc2dHZ6bnpReS9qYXQ2?=
 =?utf-8?B?Q0c0a0VYT0c2TlRSbGVmQXRSN0YwSi9Oc0FkMjBkVWxQZkJzeUM3dUxvQ2tR?=
 =?utf-8?B?cExHUEQ4aHJ6RFdOWGRiZ0Y0cVJEc21ncUx1NUlpbWphMDZtdHg5WFB0b1BP?=
 =?utf-8?B?RnFjNkhyUVpyYkNibEZYVko5WS9NM1pmVWxKOTNWQXRIM2owVE9Ia3BRaDVr?=
 =?utf-8?B?TERiSGF1UjJkK0xjamZyeGlZbnYxNERNZGViL1ZNSkFFYVY0V29vdnNHeERl?=
 =?utf-8?B?RlR2UjRCUG1HYzJkQVdldGdLbG50aEl4NFErcnFjNC90cVZVOEV0RjFXSGIy?=
 =?utf-8?B?K3RLL2s2bXFINHRnNGIrVjJ6WEQ0M29UNnJ0YTJGRDk4dFFqNzU5QWFZR2Ft?=
 =?utf-8?B?Q1MxeG1BL1poWVo2Q3M1NFdDZHNUYVdUZ2ZlWUd0cWpEclRsd0N5V1pmTVVH?=
 =?utf-8?B?UENaV1dXZ0ZqQ0o3RkpGZTg2UlphU0paSkZJSHRGRDA4aEs2c0dZaEIxZUJP?=
 =?utf-8?B?RkdXUktvQVZjK1ArVzQwSTFxWVEwVFpNdXZYcGhDYTBZdXJ1YUs1TitZblBp?=
 =?utf-8?B?YWZCbWFBRnUwYzlzT2txYk9BeVl4andrSmNpZWxpWUdrMVg1cndQcENUcytV?=
 =?utf-8?B?SUlMU1hCNDBXcVg2aEhySk9TMjRhVDMxQVpOTmZDU1RMRTgrNFNHZHNyamlV?=
 =?utf-8?B?SFpjQ3BtaGw4WnRlY2VHOElYbEdnRyswVWk4NUxleXI3M1J6OTdXZjE3SXBx?=
 =?utf-8?B?WFVxaHBYbDFZb2UzYzZTS1JPczVUdFAyUUNDWE5CZEFzYTRnVldwOGNwczNR?=
 =?utf-8?B?L1ZzZDYzZ0pXSFBpWXZ1TkMrUnNDbVZIQ1RFTmNyUEt1V2QrVjZ5SFM3QjNz?=
 =?utf-8?B?U0VBWDB6dnBVSFVNYnhBaWZqcnd4OEMzNmI4T2YzWFJUcWorOGtzazNYYzFi?=
 =?utf-8?B?MjRMRUNoMTJuSU0vZkxwbTRtZjJ2RDRLcEcrRktjaC9wQUhQalVISHdqR1F0?=
 =?utf-8?B?UkdaWHUrY25lZmUyYTlLN2grQVM1dWdsbWR5a0RWOStha2NGWFJYeEFadnF3?=
 =?utf-8?B?SXhXUkUwN3VyVzgwUXR2SVVnZjMxUXhQMWkyNWFINE5pcCtYKzBJTklvMkov?=
 =?utf-8?Q?n5+sFkFYnccep9FBXLMJGhw=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3ca1cb-1fba-41c6-20d1-08dc5317fd48
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:22:47.9474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JS9MQwRP+TRcZkNSA+6MWLImwDkT5a+Gt0MDfE/uP6ya3uYmfxu9AG2CgNnbhfwFZ1QHVTdD6+QREClTGoIAfD6cUqPLHjal2Q8VCdOcpKhG3GdGBbjrnJtoucjoxfmr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8053
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

On 3/31/24 22:28, Jonas Karlman wrote:
> The RK3399 SoC support the ARMv8 Cryptography Extensions, use of ARMv8
> crypto can speed up FIT checksum validation in SPL.
> 
> Imply ARMV8_SET_SMPEN and ARMV8_CRYPTO to take advantage of the crypto
> extensions for SHA256 when validating checksum of FIT images.
> 
> Imply SPL_FIT_SIGNATURE and LEGACY_IMAGE_FORMAT to enable FIT checksum
> validation to almost all RK3399 boards.
> 
> The following boards have been excluded:
> - chromebook_bob: SPL max size limitation of 120 KiB
> - chromebook_kevin: SPL max size limitation of 120 KiB
> - puma-rk3399: SPL stack in SRAM and TPL+SPL combined max size
>                 limitation of 224 KiB
> 

I think we should move the SPL stack out of SRAM, thanks for hinting at 
this. This is clearly something I missed when migrating Puma to TPL+SPL 
as all other devices were migrated way earlier than this board, c.f. 
https://source.denx.de/u-boot/u-boot/-/commit/f113d7d3034672de7d074506a05a7055f1f0dcae 
for the default address.

Considering that SPL_MAX_SIZE is set to 0x2e000 (184K) right now, we 
should fail if we reach that size. But I couldn't with applying the same 
changes as in this patch, is there something I'm missing that prevents 
this from happening on Puma? Just trying to figure out what we need to 
do to not stay too far from most RK3399 devices :)

"""
diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index c2aa02ec74b..f3d23fa3f11 100644
--- a/configs/puma-rk3399_defconfig
+++ b/configs/puma-rk3399_defconfig
@@ -21,8 +21,12 @@ CONFIG_DEBUG_UART_BASE=0xFF180000
  CONFIG_DEBUG_UART_CLOCK=24000000
  CONFIG_SPL_SPI_FLASH_SUPPORT=y
  CONFIG_SPL_SPI=y
+CONFIG_ARMV8_SET_SMPEN=y
+CONFIG_ARMV8_CRYPTO=y
  CONFIG_SYS_LOAD_ADDR=0x800800
  CONFIG_DEBUG_UART=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-puma-haikou.dtb"
  CONFIG_DISPLAY_BOARDINFO_LATE=y
  CONFIG_MISC_INIT_R=y
@@ -115,4 +119,5 @@ CONFIG_DISPLAY_ROCKCHIP_HDMI=y
  CONFIG_BMP_16BPP=y
  CONFIG_BMP_24BPP=y
  CONFIG_BMP_32BPP=y
+# CONFIG_RSA is not set
  CONFIG_ERRNO_STR=y
"""

(not booted).

Additionally, I think I should be able to bump SPL_MAX_SIZE to 0x30000 
(224K offset for U-Boot proper on MMC - 32K offset for TPL+SPL on MMC), 
don't you think?

Backward compatibility is a PITA :)

Cheers,
Quentin

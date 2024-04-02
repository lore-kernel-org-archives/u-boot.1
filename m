Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25C2C6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 15:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 352D38818E;
	Tue,  2 Apr 2024 17:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="j9nPViL7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6100288322; Tue,  2 Apr 2024 17:16:17 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39FB588123
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 17:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBsvlH8hEJVzuDN1mxKEiespNdPQTHjvZE6/5dAqfcgedzzHuPCe+4i4ITF3QZ4f9j7iyfzdUaID+U8wDqvmV+8aIos+mIxuk82phkHv04aNfI2eRtQB6SI5gcOCGrfRUNNS2pTkgK813j3L+Hg5BdfAGFzf895JzT9ScaTIDMwM+Ac/x/Nx+GIF3fNmcD7JxQjKFrOtG5DU8tiMzxpu8kXTyKlzXgK+mCgFLAUGBb4CDwlIXFXdoRgyqEMerfLgg/acqwYJUXPBZtUhRjSJjXR0SHmdyUZjAIIL87y+BuwNshA3pyYAvx+VgpxA3o34AXSkKe0a9FVcqu6++0y92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDiy5D1XurWaQe4Q7v9btYJA29StELRnnoZwuFAMXw4=;
 b=Dt4kiTANtdX/M9w1KZ+FzBM48JDWICZH1qLVz8UU8AYrnr1DpmQI6YzMoFhSumEIeRM305IQZB6IcJwB5PRlPO8nOm9s1d7qqEGM32AMSa8r1s2qr5pWfZ2HaWcXsHfCsOPVgjWdL8/A/a60xFXX6z6TR7BnOFoD+vYx6zZ+N4OE3TXhT/A3+aLq8GEDzFeN39VDi0aMdQAJPemPU/HrIj7io8jB5RFrxkYYzNbRVtWPktLEUWhQQ3V99WdktDUI+dOusFtBh9Auqy6pkaq3s7xUfpIJ9DYwduPfkCGML7UoHcZoz4z7V/IVGM9vqR1g0qt0SOQXw0HnCXhK5j+/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDiy5D1XurWaQe4Q7v9btYJA29StELRnnoZwuFAMXw4=;
 b=j9nPViL7N2uPhF6me9rcwoUKuzXU9nmkLxYjuRlVLTuC7aylf+wVFk6Dw0MubWGNIam0f5SjriJsHBZBCNzjClqX0boY/vu6+0/BGM1ZMI5C5glOPyshyOxGNhROkC476qDb5qUxApwaVSSS7TWhGIC5I5D+4QDx7q3K9X8AOI6+QnLoAR98jMsbHet3BV8XoLrUzH0HtYwagW8ezeqbK7/55sBaV9njHiB4+96IHLFCZtzErZZDdJrqD0he7LlIPkyH9rPxutHlMRiEAsBbI4ZixsqascoTZPsl16hiDMf3YHkcW2A+lDlKDuhLqqBETFp4efs0tjXDaJstSBSoPA==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 15:16:09 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 15:16:09 +0000
Message-ID: <c07baf30-4c08-44ba-b51e-6cc660ae13a1@theobroma-systems.com>
Date: Tue, 2 Apr 2024 17:16:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/31] rockchip: rk3399: Sync DT with linux v6.8 and
 update defconfigs
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240331202921.262323-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0015.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::20) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|VE1PR04MB7472:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ugKXappy10g3ckv+sqKubnZVaOJ5lfVjV1y7I3PYZHAvslRmwvpTls2s3yLudr7BCdmhaa1xw8wRj1gcYRb4oj4MDYZ5R3u7PZo/EIPJlI20fu8UbV15440NULlRoa7qsW9BWQmiDbT5u7AAFNEVOaXQCxqIenoopyu7FKzzE4DeiiaQ9omZpYOWs0nW6XGXCWIyEt/JVAp9Pka9fCEpcnSnG3AOt97V3BoHJXYHvdMLHtd/Udrn5Mqx0Mo3mv6CjOG6llUo1r+NSHaFwptPBAEYCc9J1IQxPEbwGVXY1d9kuZbXigPjHpRcwbtcbIWtnosBLLqkhfbZLhqvlhsG98UKjked+rOv3g9c988snVChy0VS9RGQ78t+h3RC+UQviBarQW6yKa6VTMDohtcnyUcXVmssutwQ3Kkov/XaYARodZSrqjm9Sb52UtYM59l763LKcdXy2xyimI/Bgs1ALUI+Y+b2c+H6cZnY4BN8ASVNeGc+r5pUetegXazrlE5R4E4r+ib09Wg3khgoQPp+VONetRpJz2zJz8x8nckkOApIzt+0bDRAAdGvWL4q5fX3IiNcVAXQCSFyQZ25eCCuuiEfz74XES/YN1o8Axm6/WA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDVsNHo1R3Z6UHdJTno3dTV5c1NPS2ZPQVNEYW5IdStKVkZYVkhSMnkrYmNM?=
 =?utf-8?B?YWZvTkxhb0NQZUNuMVlIOEFtZnBJSDhWa2FDNDV6d2RjQlh5NkhSUUtDVHlX?=
 =?utf-8?B?NWd0RVp2dDkyOEpWUlhEVTVKQkpFU2t2bnQvYW12OUpKRHg2Z2kzMnNsMXRD?=
 =?utf-8?B?QkNWUUxRRkMycmptS01hcllWSFNYRWZ6SFkzdkQzVGRvTVNPWG1BZUhmM3kx?=
 =?utf-8?B?NStpS1VrTTF1UTMwQTBGSjhSRTJ4eXhSWk14RlB6dGNiZW9JdnBjbnNuQmlo?=
 =?utf-8?B?K0pTbnc3Z2dDYW5Ib1VBOHo2SGFmVWd4czVIVVo5dzhvNWpoK3RFenZiL3Iy?=
 =?utf-8?B?QnpNUmo5RGFrOFBKYVl6SXdLR3d2c2lobEhpK2lXbStTZU5HWjFrU0ZVSjVm?=
 =?utf-8?B?aXlEOHkwRlRyb20vN0daUjNrUHdBSjFtZmM2ai9RbDdMOFNQaEdidDl0SDJa?=
 =?utf-8?B?cG9qM1VOM1BhSTg5Y3hvamFsbUF3cnRZUkJyZ25Fek04ZEpYM2xVZEErUGpx?=
 =?utf-8?B?bjZLd1JRNUkvemFIaGgraUd1S1dIUUV5M1VGR0t1TUxNZjhyOHovdDNXaFRo?=
 =?utf-8?B?bGxpMHZvYVhvM2VoakdIWVBxNUxkcDBlNldSUVhXZ3RiMDErVklRbVlXNlFx?=
 =?utf-8?B?R3Z1ZkNkWE5UVm9jR1grWG11U0pqc01nYi9IZUxJT1NZMkdQd1MyZ1cySVdh?=
 =?utf-8?B?aXNtcU1MMVJFem9UZ2F3K3B6aFRmWExHaG9xTWFoT0VsY3RrYitUckNuL1Jz?=
 =?utf-8?B?bDR2cUFJbTlFTTEzOHBDNTZtd3ZPVkpVUXVEdUJGdW9UQndLbmgyOE8zbWRX?=
 =?utf-8?B?NkhnbksyNC9hMlFwSWI5YmxwOE91ZWF1VldlM2ZRYnQ0eCtCdHVIZVJMS2M5?=
 =?utf-8?B?WHhQVHc0YVVLMFZkbFhwbS9VTXFuVXRWZmlGenNOWWE5RjF2SHZpc0U2TG9x?=
 =?utf-8?B?UmRTWjg0aU1jNnFUWU9RdE5JQ3Exdng4QW5oK0plb2xNK1oza3ZNRjRGeGhx?=
 =?utf-8?B?UDRWSXVXVTFVSDRvdllZWm1udHN2ZE5FTWJxOUlNZ0JTcy9YaWI0cktHeDRu?=
 =?utf-8?B?QnB4T3NYNVhTQ3BJd0FXSlJsblM0TXZZc3g3a3NMcWJVSXlOZVlMVEpOSUh5?=
 =?utf-8?B?dURNbTlmblZjMDB5S3dGNGhkUnpabnFrL0d2QXh0MHN4MVMzcmJyUTg3WkZT?=
 =?utf-8?B?a0d2dEJocGlGeStyQnRRS2hONzRneEJmSThtdlRmcmZFUExFUEVnME00TWx3?=
 =?utf-8?B?REtxYjhPSkY3ZStZQXVNS1lhb0hSRjlTMXFLSWRabUtnS2QxNGV6blNXZUw1?=
 =?utf-8?B?Rm5nK2JJakdkc2ZFM1F4TXZoVmQzZnUrMzQ3cVM4WkZlTS8rNGRhOHJER1Z4?=
 =?utf-8?B?b0FYKzk5UDdzelpwZnRoQ3pkd3N3bFNBR3NpQitJTlNnQWltQ1pDWDYrWkQr?=
 =?utf-8?B?VCtXc0hsMzNGN1Vkc2NNSi9uSExPTitjenRpb2x1ZGxxWnc4bk5sUlV3czBN?=
 =?utf-8?B?MGhUQWpCVFlObmdsalFjYXFVSGFMWDMwNmhud3pHMGtHeXdBZ2M4eTRNcUt3?=
 =?utf-8?B?SWVTM0tmSmtzMkFoZGMxcTN0cFNZL2JzanhJUkx0RE5XTWpiWS9tV2dLZlZn?=
 =?utf-8?B?UVM0WjRYRkQrQW8xb2dxell6OW13M1dSQXlsR2RVL01WdUV3RVppVW9WYTI3?=
 =?utf-8?B?bkNJT3E3b1prY291WVB2Z01BVWlCR1I3ZUZHWHhzRzRIYmVGWDMvOUZjMnJx?=
 =?utf-8?B?bHhjd1ZYVkhoS3gwWGU0UWl6Uk0vdjhGeUpCdlBUMGUvYUEzclhMU0FuZEh6?=
 =?utf-8?B?Y2xrMzZVRlNyQzNpMlptOW1YOEh3NXlhUjlNRFVQMEtmbER3WjdtL04wWXZX?=
 =?utf-8?B?MGhSckFwbHVtYnM5ek1MSWc0MkJPa25PcXpQdnFNS2pldEI0UjVsRjNhcmp3?=
 =?utf-8?B?bWN4THE3bmx1eW1RQnJGa2QrTzRNbjcyTWZzeFFzU0dGOXBPU3hCeFJyNlhH?=
 =?utf-8?B?MlFGV055YUM0YjhqNGlFRW9Iam9GSXN2ZVFORHBKNXlLOVVlNCs2TW1zMlhI?=
 =?utf-8?B?NmF5U01xUHNvRForTXBLSVU3SDgvQzdnVlNQcnZKbVFCdklvQ2N1eVpxU2RP?=
 =?utf-8?B?STVVYTh4T1BtbzFiQktYL09sR3hUdExYSW5aaUpBODN5enEwdFMyOE1rNXJk?=
 =?utf-8?Q?SrYEp8kXCGV6E4RSj05q5R0=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59e5230-b7a7-4a4d-653f-08dc5327d341
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 15:16:09.4994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnW/55kzbXBIEYStGHuGXR1u9T3sDMT+9HCFkZketj5jcgqA9/rvN2fpftGjbixOegwD4HrlcmIkIIWU6iSnK+WMUh991FCwakBpgY7tFLWNZbE5Ifye5H6KClslbmPz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472
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
> This series adds support for new clocks used in linux v6.8 device trees,
> enables use of FIT signature check for checksum validation and fixes
> loading FIT from SD-card when loading FIT from eMMC fails.
> 
> After this series it should be possible to move RK3399 boards to use
> OF_UPSTREAM in a future patch once dts/upstream move to a v6.8+ tag.
> 
> I have runtime tested this series on following devices:
> - 96boards Rock960
> - Khadas Edge Captain
> - Pine64 PineBook Pro
> - Pine64 RockPro64
> - Radxa ROCK 4C+
> - Radxa ROCK 4SE
> - Radxa ROCK Pi 4A
> - Radxa ROCK Pi 4B+
> 
> This series depends on the following series:
> - Enable booting from SPI flash on ROCK Pi 4 [1]
> - rockchip: spl: Cache boot source id for later use [2]
> 
> A copy of this series and all its depends can be found at [3]
> 
> [1] https://patchwork.ozlabs.org/cover/1912469/
> [2] https://patchwork.ozlabs.org/cover/1915071/
> [3] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3399-dt-sync-v1
> 

That's a patch series I warmly welcome, we've been long overdue an 
update of Rockchip's DTs in U-Boot.

Here's to hope we can migrate to use OF_UPSTREAM sooner rather than 
later and this is a very big step in that direction, so thank you.

Cheers,
Quentin

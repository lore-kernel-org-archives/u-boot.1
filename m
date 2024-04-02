Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759F9CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 10:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB0B388096;
	Tue,  2 Apr 2024 12:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="jImifjI0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF47288096; Tue,  2 Apr 2024 12:28:06 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A50BB87FDA
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 12:28:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYkB/GKIqhgAQmsxYM3jQqGFv1u4XsE+CSf1N+jJLXAf747nFTaSn8ieaee1AW0FnJT0WAob55njmS4uvibWQy458qjQrgknSL0NXLBPT/K1C3c3gWjwoyw/2gpYEKAW8S97NwbcS9x2g8rMwpZC5enL9kqrQw3XmoYDtSuPmiA9jtT2WexbyVAAEl3ibPB4CUq8sgTm+Co7sMre4/X45PfObca3k0wMz6fFAuO9PHa1rK77km9bDEDEtPLVYKzv8itvaWYicG5g/fhLuji7tHIh+BeCW1rhr+AfUHNlGGHalMxH33owP01iXdw9EJ+eY03lEMeSf7723h4dC2Q9eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IHhz3bLJorLcSPTwHXODRBH/zn0/zOHXu7N/fRcDXo=;
 b=kOkwYx8fimnWNlol3RrRayaApkuETUQc2ZuZ+/aOSVJLh8TYblAKsvY4I2Q5V2JiRAVzyPk2Er5ppg8et20juUBlAVlrzSDZ7rkTAdc9kiyxgxqZ4IrwnJNbsegy2zV+2E8D+xn3auY6LxkWQrmrjRLmZs36XTBhaK7QKvhMQWhYsgx4qGqKMMLKddokiIqC+J8vncjjgifxt7I8QkI73LCWTcA9CdptDSB2kACM5LLnOKSgLkt2nRlNXcmf9/QB9KBGIR5JJv/AoUE99z1wOtyFT5HKzqKWrT7GmuSW16iRtJ+sjGeBf/JXTvthSYEJ+0IXM8TpKb5qB7oCJDachA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IHhz3bLJorLcSPTwHXODRBH/zn0/zOHXu7N/fRcDXo=;
 b=jImifjI0XgXxNbyxFKdx7rGS4KvCCOt+pFXtRFhtqKdFvvF4FAt93gRrKjnXE2c7WT/pnsVn22MWJfjW4Mugv2l/M3SuJCsTIeiCwlVVIbIrCdT9/WCHvUNIrgj2eOKbtjnYY9Ho7SvuyPTdVQiJqAOd9/OP4anqw9T1FOUF061JgwwrGsdmI5sSfvGa2Zf1bq1jby2QgcyO82JIrdyK2GcjzaeRZ1ULKABlGFzBfUYgD6jj0Koa5XJuKfiJL/1NpSr2P7ExY3OQdFOaYWQ0WXXz59JTCWHrFOM6UMpL8BHa5eH0QPBZ4Hc5z/5T6feyd+V0PrQLmowUyWI+Rxgbog==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DB8PR04MB6843.eurprd04.prod.outlook.com (2603:10a6:10:11b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:28:02 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 10:28:02 +0000
Message-ID: <ed5576a3-24cb-4c6c-958c-66c63d43ed69@theobroma-systems.com>
Date: Tue, 2 Apr 2024 12:28:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/19] rockchip: rk3588-toybrick: Add missing Kconfig
 options
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Elon Zhang <zhangzj@rock-chips.com>,
 Weizhao Ouyang <weizhao.ouyang@arm.com>
Cc: u-boot@lists.denx.de
References: <20240329190224.3613471-1-jonas@kwiboo.se>
 <20240329190224.3613471-16-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240329190224.3613471-16-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::11) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DB8PR04MB6843:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ya1EC311ksXpIGMiw8TwGDYvWcwI4zL0YqiWhRy7/4b7NeqcQcNptKz0E2qltu9xAiubZM33XiYvlvFREHIhNWHHXINB5C9i4hGYlichzh7mop6W5v2PimSREQO7Kg6SOB4RJq8wmqQoLVIW0M7IvjtAGTAV5xhIc56d+HQWsI21QkgtuixoKaV7671vrRsciW6lP5eSLoT3aT8GpsCzKA3FuFj9sUxTlj3w4Knr/NZc2vkznNtRXCAPTT/sVvvbEj1I0tEsETbdstBTyQPDRlEBnqIMCTFyoDtVt4gMY8gDHilkouENOX6TAS2Dhs/ErML392uvzgqykUIrXepciGvZoHNUyx41NFCLgJZhbPwtg9j88Clg/01CkEUbxpCR1JZlR/iWiqGEosX42cF8ZHFULEuR3hSzbTjg4O/moknz0i2HA31WgrQXDaq6ycb49xj6N5K7EOug/yAIEPsKZiP2XhX+5/P9ptEj9IpNJgLfPYSiOvrf9cKKqfraOggLDgnJMHHtz1k9dX/Ro+4+sHodfeUSM7h6Quc56RgOSOUWLDT8A2i/Qf9+lWr8Kn+F80i9Gr3jebSPk3ETNewRR4S8R74+Mw6EN2VR5L59wU1gmkOjMEVS4yiVFvJvUsil34G0e/fXFKE2XMu4p4dp/4sblchz9mnGfmIbOUca4nE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmF3N0R0ZmRhNHpaWVJVdDhsRE9iTlJXRHdRVERJRmZkVnU2SjMwM0gwcXdo?=
 =?utf-8?B?UjB6bWZVRFMxR3NkSWRLOUl6ZFlYdU43eFNLUVhvc1lSeFQ0VVFKY2t5Wks0?=
 =?utf-8?B?T3lBR01qcUMxeldkb0JGK20xbnRxa1NiNndOdDA0ZjVScWNuN1VHN3F5RVcy?=
 =?utf-8?B?STRUaS9xNDh5cUtzYmx2bkFheWFKa1cwcGFYNEgzdkVtMnhZUWxCMFdIMWhI?=
 =?utf-8?B?TGVDVlM1Y3pjbjZFSzEyZFZDbkdJUGNmaHJScTl4OHVEelM2N1NIcVNSd0sz?=
 =?utf-8?B?Z1ZMeDlheXg1bVJ0dE02TmJUTWJYdEszTXpYL21JbGZWbjErUE1Temg3NzNa?=
 =?utf-8?B?WjdmUm9nY21yb2NVTzhLZWJxaW42YWZhSWNDRU8zRmtrQWtpWUxPOTBETTds?=
 =?utf-8?B?RjJMNWhBOWk1d3p1am4vbmVXd0UxTk9JZGFhOFE2cG5pckt2SGdiUEdkeHRQ?=
 =?utf-8?B?QXdwN3JpM0ZjWmpXSkpVanRUTk1oUmk3dHBYcDFwKzBCZ3lQMXQzMkRIbnFB?=
 =?utf-8?B?RU82aW5jdmkvUS9jU1B1aXRmeSs5azBLT3NzSzJHZG8wa1pRRnlXS21NQ3FK?=
 =?utf-8?B?Z2daYWhTZDBsWk1JRFlVVGlOWEI5N1dQdks2WjlsR3RmY2lNKzF4STREam11?=
 =?utf-8?B?MFhmR2plZHZUM2dPeGY2dW1IRnBXNmxMeU05K25LRm54ODk1MnNUTXVvYVcx?=
 =?utf-8?B?ZlpTRUNBKy9lTEVzMUpleGxsZERHYjgxWTBSRlhuM2JaT1RtSWpGemtUbmp0?=
 =?utf-8?B?VUt5OXowWEhpV2FMcm9EN085bk11Yld6TkM1Wko5R1Q4WTFWbWRqYmRHZE44?=
 =?utf-8?B?MjZFbXgwemVOdGpxQnlsem5oUTN1ZUQ0ZER0STlVNkNVOWN1d0VYOWFqc2Jp?=
 =?utf-8?B?QUgzck9KRU5peFFvS3JEclJnU1g0dGxHVk5wcDRrTjdIa01RQ3FtYzRhNGZO?=
 =?utf-8?B?T0wweWREZ3BVMjV1MUZYMFhsMzRyTWV2Rm5ZTVZpc0tRbTB1bHpUd3FKcFNB?=
 =?utf-8?B?NWQ2RGFxNXhSRENWWkQvOUk4Vk8remVITzZSa3FVZjM2b2piV0gzMXQ3bWJy?=
 =?utf-8?B?dW5vb0NDdExEZ0hrNkpOS0NpSzFjeGh4Ull0anlUL1pUdTBXNVRrVmtYU0RL?=
 =?utf-8?B?UkFrdU8vQ1ZIQW4zWnlnakJvditYZDJtc1dqckdaaGZUVG93UW10cHpiYWsw?=
 =?utf-8?B?Sm14ZU1aeXR5c3VRQXJoSjd5OG9vTHc5UmNWOWR5OG1TQVFpV2NmMzlJcG1w?=
 =?utf-8?B?SWlETU84YStCOWlDNmlyaFd1SEJ5WmhId2hJM28rZ3pGZFI2TS9NcXJBNjZ1?=
 =?utf-8?B?SFM1SUpJUGVoZmVpYXpSWFlINFlvMGF4a09EZW1xOWZtVGwzSnBrZ0htdXp6?=
 =?utf-8?B?ZWZjTE1YeWlnS3FLOFpGUHhqUHByNVpRb2JRTTFyalY5UVNtS1EyeVlOci9y?=
 =?utf-8?B?VTBqRzEzSVI0MEY4VzcrUTdTbDgvMUl2bHlOUUUxYUd5NE5MbmJJamNIVzdU?=
 =?utf-8?B?T1N0MURtSG4wOVRSa1JoL3lXeW1Lc3J3c2I5Q0FUcTJrbmZnR21RTmtMWjQ4?=
 =?utf-8?B?emtvSGVTbUFWSDZLVDNXU2szUHhSUmlqOG5rdnJJTUNBcnQ1QzZXUFU2bWQ4?=
 =?utf-8?B?cVdLOGNZTzlzWm5maURseGF5QTZoTlBiNWhMaGVTeUN6SWJWakFDeXY3K3NF?=
 =?utf-8?B?UnFNZGlMOGpOTDdyMmNFRmVKcUF5M0xkVTF3VS9VdU5FTmJjZ1hya1ZuNGVn?=
 =?utf-8?B?K2RNUGpMdWphWWJ5Sy8vQkEzOFV0UjlZOU96M1BqMmNKUGNpYXZDeVlIMnc4?=
 =?utf-8?B?RnY3V2c4cnduT3VobGliSndNRVpFQ1ErWEh5TjVZazNVYkhOeXJ1c3JNblhP?=
 =?utf-8?B?Qm1vM2VOUlFOM0dDaTdLZUVCck0xSm02N3BQd0ZiL0RFYmlpYUVZUkJPNGoy?=
 =?utf-8?B?MC9MUzRVSWo5eFNNUlZSR3ZnVm9CN2d6RjJENGxXK0FVSTNYYm5kVEh0UXdR?=
 =?utf-8?B?NFd5R0tadnFoYldYdFNnSzU2bHJTR3BOSHlVb0FqczBmUWhjVHJHdGx2bVZy?=
 =?utf-8?B?TkY4TkQ0RjlZUTF5bGVWMWVnd05DL3c3dlJ1aEd4ekw0NXljL0I4aGl4ay9H?=
 =?utf-8?B?eUpZTFBPdGppK2Rzejc0YWUyVjBxcWV5NlVpNm5hbUdUTWptZkNHQ050L1Vz?=
 =?utf-8?Q?VnLfNI/ZKbBfumsPWW2fQr0=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ea1c97-ecdc-4d43-ee1b-08dc52ff931e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:28:02.0468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdooxbbZMGB6ykn21O1NrwzmXO7ntR14nC1cgMtO3q4v6qGKJTkdaSCfxCJ+T0cAGq1eudt2W1gCFe30OQi0cnrcwxczK5EDQGU9nKe6wEDyB6GjIpGjGh7fqd8R1eVD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6843
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
> Add .dtb-file entry to Makefile and enable Kconfig options required to
> configure pinctrl in SPL. Also add missing PHY_ROCKCHIP_NANENG_COMBOPHY.
> 
> Fixes: 9fdd9a546986 ("board: rockchip: add Rockchip Toybrick TB-RK3588X board")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/dts/Makefile             | 1 +
>   configs/toybrick-rk3588_defconfig | 5 ++++-
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index f49b7e5d251f..3e0bad8306b5 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -207,6 +207,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3588) += \
>   	rk3588-quartzpro64.dtb \
>   	rk3588s-rock-5a.dtb \
>   	rk3588-rock-5b.dtb \
> +	rk3588-toybrick-x0.dts \

Should be .dtb here I guess :)

Cheers,
Quentin

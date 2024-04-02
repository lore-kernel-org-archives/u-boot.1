Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A547ECD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 14:32:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEC8688148;
	Tue,  2 Apr 2024 16:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="icLSv7oh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 142E588148; Tue,  2 Apr 2024 16:31:58 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A55588380
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 16:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVEQilNMKueQjOwMmGsopL9O7gcyVOwL46ewa+0AvR4AUVvDnByKG7cda41iIjVAOglgAydhxGfYvJ7Tl45C8qm9633gulUifIFAHjEz9qpzsYELqV8bjVyhkHsS1p5q/AtvPLysTYNFbze3UYKamzTOb5wz0flAXNIbP3YFb4BOF5gafLTfyVo3cXmgD9kx2h+9xEyFQGPNjaG8GCxO1voyD3WkFf3HlkIvMOAhx4C8kWtx3c1kNmVj7jZEErlQlUosIm+AG81zYGfH1u9qhtC+aXDwYqGW1aTJueL3nZjnbVL54FzvJiNxYSuuBuw80j6eWChBuScw1X7MTfPlxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rr5B6xwIhXTcDv6FUegcYx8f4v85SJJVsCNOxAMoFn0=;
 b=R1BiX7QP/epiA5zYstBlzwLCUE2tm568DrWA343fi4cT6zHS0IrYV5UojLALbyiVfXbAqPBG/fJuU/W9Ex6vtz/PDylCGYK8xVA0PGeo+UzsKx/BpSkKn0n0rM5zMS+KG1CrsRzmXkBFY5EC1Cp4TOIFVqgmWrSNOVi9Wyl4li9X0TlOAV5Wd3VHeHcLFI5xC8oO6IICKUqrP7qAL8vrMen97u7l5qMOd9zShgfHPNtNnY+Oun+rqqB/JOQ4GmX/RJeFSLR0Ds+2vFpZp+v7Ujc67KIXTc3W+gif+GcrNaghOSy1DpWzkcwx++AVLTJmQcwXtgBjzbGZFVZU9J8lig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rr5B6xwIhXTcDv6FUegcYx8f4v85SJJVsCNOxAMoFn0=;
 b=icLSv7ohSsvjMyXAMfLRxQBxlczSFjNclKO9yidW04d71+ITqgaBlI3dE1rTWFaGiMJ32GNzBlO7fsMFf22UGnW5R7jSqe1LwFLCgolqSAuq+8VBWCktZfXA0u5vShi9KefpTgkayMr5GGuVsDRgT0rze4jkgYSzpx0z6RHSiKqZYPuWskJdWQgadyTWKn3PEbtS7/2HjfWsvyP7KTSUzjK1E6k5VT5XLUJmToiZ9nrwJkvfMV4p/xZqfnpY74pm3i4xFeArzwppWmvJixPnTf3dxyAqN1GgNOMlHno4dVC9r7CSGH7tbdpz1J+wZeJObJPDBKIuuskbx9iZ+u7D4g==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM8PR04MB7411.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:31:54 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:31:54 +0000
Message-ID: <24853978-283c-4656-9a3f-23caf015ec4b@theobroma-systems.com>
Date: Tue, 2 Apr 2024 16:31:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/31] rockchip: rk3399: Fix loading FIT from SD-card when
 booting from eMMC
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>, Levin Du
 <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Andy Yan <andy.yan@rock-chips.com>,
 Nick Xie <nick@khadas.com>, Deepak Das <deepakdas.linux@gmail.com>,
 Alexandre Vicenzi <linux@alxd.me>, Xiaobo Tian <peterwillcn@gmail.com>,
 Christopher Obbard <chris.obbard@collabora.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-11-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240331202921.262323-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM8PR04MB7411:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tbikceMMWF5RWe/2TuLYCsOK8AoUJoKHFsOwqcPLL4VRJKIe2CqASUspxOa2iRtiGleas1iHqAoK0Xs1vJRpPmXRv+PX90q4Wm6OtbDg2bKVbZrZpBVnJwFvy63tOY3yN0PZIBuRwzdpAXA/apqt2dvvZ9x+9Dwnbp36LJrbekULp/zLSvrxIKs04pqRCft4P6KaiR79MAxdwsyAYMmprkhVKPzCFUNpHZxZZRGF/AfulBJ1xOqpuygc3GPdzmJuQ8W7ZFSUR9K5N1V9WNyD95PFO08u1YKgfTchNoly7WigVAZbzMdJu2brg+Kk2pQ8boWT9yjQwNjEVvTmX/83L/iFNYLA+yy+fQTmijd04Ar/c+7tOlzwBFIhNClfQORxukVZoiULN9wKMYzXSfBAhlGQh4C44krzPiiyzOEZ8GmM6nQZCJNtxL9rrh/MZAkJX30f8VQ69zS94QXoO2PtWbqfSHYuMXSnUEYB17L3JrlehJ3D2FpqG+ppQrhMaKkaGaMByxAdcGSNQb4Hz5rv/SW87VRzPnM2SH/BUqwt5YHcHXrgZHKVD25/QZRz30zK6vZzB0n0jozU/XLDlfFjVA1xmmNb0AE2c6LjFp3mGqHgoRJxkcr5VY+n2DlzqAJfC3vrPvvsJZvJ5I9Le44K1HoaZ+Q+SjbdmGj4Gndr5SNFP4DswxUn1rBJTivwCVXpYzb82qou7MYrmWVE7A/hEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzJENTlYUWdJYzRhdDdXRkFRTmNodkZKdEdYTENlWkEvcHFVNG9GSlZ4UERV?=
 =?utf-8?B?VytKTzFLNVZSNHpWcm9uYmhud2M2WjlWRlRtQzVwL1VLVURrc2hCY0k1Qk5D?=
 =?utf-8?B?aUQ5TFJWN2ZERDgyNXFsOXhoNkhpdVJ3NDhOZFQrVkxIR29yYjJzYURML3pn?=
 =?utf-8?B?ZVZuREp1UEY5RU9WRjAvdXk5TllYZ1NiQVR0d3RFNnRzaHV5Rm8xV0dSV3U2?=
 =?utf-8?B?V0JvU3dyRVdKMTlEQWFLb25NL05PaWxPSHBOWXllNXpJYTNPRndiSC9wZFQ5?=
 =?utf-8?B?c0FNODVGRmJmMFh0VnRIaXROMXNJeWVmam5iaXVWMW5kU1pIcXNLU1h1WmRl?=
 =?utf-8?B?bnpDaXEweUxQTng2YUdSNmFWUnJGdElpNmIwMTkyYzlkamM3U2J0Y0FsVFRD?=
 =?utf-8?B?d2s4Syt2d21CU1l3MzBzL0FRYjNOZi9XQWZoeWhQRjJlSGlUUGtPZnpVNjdU?=
 =?utf-8?B?T0ZwbmVHTkNXenVaNnAySUdWQmlMMnhKQWhFc2lGL1BWaGJxWlcwMjY1bUx3?=
 =?utf-8?B?Y1kzN2JDUUc4aEI0NFp2SjRZVFBJK1l5bjhzYU5FQ3V1WEdQWWZ2ZnBzNENp?=
 =?utf-8?B?NzVpSWxuSEc4QXJZZUhFd2tvU0tWSFNpSDlBSE81RDB1bFR2ZzZsbFNmT0dX?=
 =?utf-8?B?c1VOU0RiVmpKRXRpem1oKzFNWHBXVXd3Q0Q2L2dDdy8xRk9QTHhuYWpwU29H?=
 =?utf-8?B?TUphMXorUTYzTy9JcG9JbUxBOEZ2L2thT3dqVHp1NEhMelJYWlp1YnpYTGNY?=
 =?utf-8?B?SWN4ZTA4K045Q1RtT1Z0bkdjNGZlcUxhZVhtYk1Lbk1weldrTHJjRVQwYW5S?=
 =?utf-8?B?czAyR3V3bzlLSGREcTlEYnEyeUZYb3pKdktoYWI4M3FqdVlNbC9PWGQ1NnhT?=
 =?utf-8?B?N2lvVVJpQ0lQM1hOSkNrcmRWMUJCd00za0tlK2Q4eWJYYWgzY0FPWFpqQXFZ?=
 =?utf-8?B?ZysvVFQybFJqK2QxUHgrVjMrOUFsbFdCaVZ5VXFhUGJxZVppbUt2OTV2bG55?=
 =?utf-8?B?RlNzbzlSc1plSXpHeWVyU2lTekdTVVR4MjRoTEdWUlNpM1p5cS81ZjZFbzg0?=
 =?utf-8?B?K0lUdE1MNGt2aGlsSXgxOVh3SktiVlZmM2xKZ0RtQ0Y0anQ5cnVvVWdTeWNv?=
 =?utf-8?B?OWNaaUZ3ejduSlFBcVRhOEFyTFgvakxaSUZSbDgwK2FwM2NEWnRTeXNXOVU1?=
 =?utf-8?B?bU95cmtLSjJDc2VCWEdUTGtLa3JDRi9CWmIzNzI5NWRVUVpNM0FlRG1NSEE1?=
 =?utf-8?B?ekhrTXNWcWsxZ3BsRFVNYkVLNnpXZkJQVzBuaE1DVFNleUVxYXlHbDNnRm82?=
 =?utf-8?B?RG90SnU0QkNsNERUUktIQUI4MDhsSVAvUWN3QWxQR3hUVlg5bTdHK1JaRDNU?=
 =?utf-8?B?ajh1M1hNY3hOTlFsMnJ5dzZGeXFFRjQxcldMUVpJRkx3QngrL0NBWFdBcmRE?=
 =?utf-8?B?Qnk1QlN3d2lTQlBsQnViTHYwQzRFZnBsa2pFYzVDYi9XSFlZOWtmYm04eTZZ?=
 =?utf-8?B?MzZWK3l0OWlMaUl4TWR4U0xyb0FJUlVheU9hbnFaditpTXUvMXRRRVhMaDgx?=
 =?utf-8?B?di9XSXV2QlZiT1hQTmx1OG9SMjVRbXJyZzZweHo1QmRpdmlFTE81ZzBvYkxj?=
 =?utf-8?B?cEh5SkVkTHNFWnR0RFJxcEc4Q29BU21CK1ZsbWNlZlY4VUExTHdrbUVlV3JH?=
 =?utf-8?B?NjhuWE1KNDJyUmZBYXc2TXphZ3ZONnNIZi9qWkNXdmhURHp4b1dKK2FKeWdU?=
 =?utf-8?B?ZmdYWll2K0IyQXFxQUVUYzBpTDhYRWtTRTVBQ2JsYnF3b2RIS0U2TFdabHAx?=
 =?utf-8?B?NFNTUFEvY1RvTExUaEQwaG92c09yU1BmN0YxbjNVczJVeGZaWWU2TkVEQzhh?=
 =?utf-8?B?clAycndYRXBxS0o4cnhjTm51UFlManJxNkV2SjFjeldmRjkzM3lHMDIreFFO?=
 =?utf-8?B?R0QxNENXS1Fld1YyMDRsVC90bnBJdkFYeFRUNWlxem1FM2ZnVGVja0wyeFdP?=
 =?utf-8?B?ak5qYkFSRVFXUURSYlROSlhETjFXeWtHN2xPbE5mWDAzNkp3bWV6eEM4WFU1?=
 =?utf-8?B?TGx6bkhxTm5LNldURy9tM3NrM25NaWJGQUZMOEdWd0NUSHVFaytaa3UwYVNV?=
 =?utf-8?B?U1BuVGNCT3dZZW1pMmVmMXM4WkVab1FZZ2ZvZ1lvbzZpMWZXUWp3UDczdHJn?=
 =?utf-8?Q?CB/1eYN9oH6T+ZO/9pTfHNk=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56082a7-06e5-414d-9b10-08dc5321a441
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:31:54.3482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /D8bjDlKZdkjNB+b23Pb+jkwgIUAv5HgobGGWKv23zMFQaHwGK6DJaMb5OhL5zjIIBIipqhdoZenckIMCs6FjTQKNAHBat0qQ0cAznhW1iigWkwqqUhWiEjIHT6l4C8L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7411
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
> When RK3399 boards run SPL from eMMC and fail to load FIT from eMMC due
> to it being missing or checksum validation fails there can be a fallback
> to read FIT from SD-card. However, without proper pinctrl configuration
> reading FIT from SD-card may fail:
> 
>    U-Boot SPL 2024.04-rc4 (Mar 17 2024 - 22:54:45 +0000)
>    Trying to boot from MMC2
>    mmc_load_image_raw_sector: mmc block read error
>    Trying to boot from MMC2
>    mmc_load_image_raw_sector: mmc block read error
>    Trying to boot from MMC1
>    Card did not respond to voltage select! : -110
>    mmc_init: -95, time 12
>    spl: mmc init failed with error: -95
>    SPL: failed to boot from all boot devices (err=-6)
>    ### ERROR ### Please RESET the board ###
> 
> Fix this by tagging related sdhci and sdmmc pinctrl nodes with bootph
> props. Also sort and move common nodes shared by all boards to the SoC
> u-boot.dtsi. Finally imply the SPL_DM_SEQ_ALIAS Kconfig option to enable
> it on all RK3399 boards.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Review may be easier if we added all missing nodes in one commit, and 
then another commit to move the common nodes into rk3399-u-boot.dtsi.

For Puma,

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin

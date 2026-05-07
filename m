Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1B4CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 12:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB74A84B1E;
	Thu,  7 May 2026 14:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JFKWzY2c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E449184A85; Thu,  7 May 2026 12:20:03 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8285584A37
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 12:19:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsUt99GY3L9T/cCieq9da1jRHV7CPW9g5iWBPygd6L3zs/ewzx06XcJJ165z4XAjsydeF6uB/HBLgBXfCxWt+pi6jB/4MwiwCp93HGqfo2SYUajyF4RMHpsu2d3tAk4Im5AEaiJrre0q1feZLvjX8XRFq76N+GiaI7+n70ma1RIftDV3Au00XELqJwfBNdTw+D51Qx/ZTjZ5M1s6+chAVMzdj9iQidHwT3SZXUapu4ezlgXdjI05ndip4iy1VUQaIVUKQCiMpCnnbnnyyeuTZXCZivgZUyKHLw4OGwBIWu7KXLMFwzlSfdiP1UFXPjGlLC0suK0GswooQOoi/xbx1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMz2j5mOJDVNH+FrfK9wULifycCBaVA8Upsw75Bs87c=;
 b=Fcxha3LTlzemMm+DmhRTDORhSMd5upyOBs32vVDSoPDHQVOdACZZr6bQFGpZxlVEaRwHbx2+Fe2xwYJf2tBq/z7cJ9j9kWMoCxLONQPfdmaSEL4kjqHlU7/cnYuIdLolr/qwqcNsmO0++14x437ZdGxVQTqRB8dwOAH0Iw/nPa0UWg5XkSgvBhxWqYHL/D7rXbXYCSqOvsqd7l4gZqlLrwGD6GfjTl0VkQaUGmVidDIGiqmlM+ouiaqWt9MF35jtM842iX8VeJzJS3KYmIGMrjNc3R6qKyeZPQpgo4pDy/6e9XxIr699C/ctiIRpunOZhXpyP6TZ9sX+xBGG9RVsdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMz2j5mOJDVNH+FrfK9wULifycCBaVA8Upsw75Bs87c=;
 b=JFKWzY2cS4E8fHb2XjddaEnzl5qK6AWuuq6s+86Gw5djTBjUnh2r56t81z5hCohU6w5h4j3dAePmxQDVCy+NZApvEVFaH/e4jv1tkto7QnOyCLMj94gVPz3d6hp3RgIQ++41Y10ekkHJc0aHNQOEcDuFzebigV28XJByzttUK64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB7815.eurprd04.prod.outlook.com (2603:10a6:20b:28a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 10:19:54 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 10:19:54 +0000
Message-ID: <01052779-9532-4ab8-8453-3759375983ae@cherry.de>
Date: Thu, 7 May 2026 12:19:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] net: phy: air_phy_lib: Factorize BuckPBus register
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>,
 Yao Zi <me@ziyao.cc>, Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Weijie Gao
 <weijie.gao@mediatek.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, Beiyan Yun <root@infi.wang>,
 Ryder Lee <ryder.lee@mediatek.com>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 fanyi zhang <fanyi.zhang@mediatek.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut
 <marek.vasut@mailbox.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Heiko Stuebner <heiko@sntech.de>, Samuel Holland
 <samuel.holland@sifive.com>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Tommy Shih
 <tommy.shih@airoha.com>, Kevin-KW Huang <kevin-kw.huang@airoha.com>,
 Peter Robinson <pbrobinson@gmail.com>
References: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
 <20260429-add-ethernet-support-for-genio-520-720-v4-5-be54e17239b7@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v4-5-be54e17239b7@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1PR08CA0226.eurprd08.prod.outlook.com
 (2603:10a6:802:15::35) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a2fd99-e17f-4920-f8ee-08deac222e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|22082099003|56012099003|4133799003|18002099003;
X-Microsoft-Antispam-Message-Info: MvyS6mFsJfUfdtjWVtdZDU0+rXxz0ZjaZhN1qIpIRCg72+yoJnPKJqTolWYUz3Xe2qZqSCAJq+dk39Y9noBt0m2Bx1Fk85AxBP6E20g53W2l65kfCbVWXIPLulk4ePDX5KyYXG7ULnAMfQlP3M/RMToPayV24dTG+DwBovdRuPFeclrFxl5M6pSB1Ld2rVDDYVyEuHNYXY3c0usFzVEUoW6HecppC5+v6hoZM8Zw/AWNB4UCd0esPmhJ/DnlSxFGRmohddveNWGDKNePIJikT6VoMuRiPpH+gtyxCzzhTu/iOoOoWLK5Qdb4wky9egCcVdOi0iUCDqEJiRxCZjK2IvsRmCd5I0TSq6o2D8e0+lJxhqScWqlCC5GAmqRdt62QPCFwcnChVNd9Y0+IOrpXFz85QKh2U1fQBmR5PTD8d8YpUFCNFaG8AsIpHNOjOAMIqUHv8Jpv+YrhpTvI/DckErku8FDTmK5iHmT0GcKNGXI8Bk1X4N/ooDkixk2WW+fYfb2MgkWRQ6KB6otwLgz5IKCSWK4XhzVGaRjk0cg+NHnws0glGw3e3k8jfyKO6HVgolGBIhkxXBsD2mFtd7RttGP8tkl1oYEVmxBjOg0CP144LESiaf0I7kF1Gt7+eMjY28T+/Ab5n721Y07cHdvHZdGSYfkwBwaMh68on/mED3Oxz+LZPiUrFx4hfTn/c357h2RV/UGH2u165hy44QCMEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(22082099003)(56012099003)(4133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUcvV2NiREh0clV3eTUzSmtCMkVSenIwT052YzZVNmd3NzVEV3U3ekxxaGhp?=
 =?utf-8?B?RXN1VzFxSVdQRTVncGxEa3BraXpYNW9aL2JuYWo2V2NweFl4WW5CNUZlK3dO?=
 =?utf-8?B?cGQ4Nm1USUtMZ3RWQ3hzSWszemJBajBMUW9FaEliMTZjY3N2YXhGVVBLNHRy?=
 =?utf-8?B?NUdwWk5vT1d3R1VZNms1S1FHSFpOK1dvODY0eXRyR0gwMWFSdVBPbTdyRXBH?=
 =?utf-8?B?WXFYT3QxQkRDZlpqaEhUd2xWYWpnYXFveFpaNFQzWFNhbW1BN0gzZWo0dGlV?=
 =?utf-8?B?OUR1RTVUc2VTM013TFNFdHZhdTJCZjgzNHlhbnFDeFVpNE9IZ2h0MnFVL0lT?=
 =?utf-8?B?dTFqa3ZQUDVOY0N4WE5sYXo0NFZpaDQ0M2xXVXFTc1dSZDlKWWNRQU0vOVVR?=
 =?utf-8?B?ZkpKUUtvMWk3MVY5d05GYlhtNEhuaFZXQ2d4c09qcnBldmh5Nk1KUUxUcnJo?=
 =?utf-8?B?RWlNNjl1TzRNWG9aU3BvT2wrOE44MkNkbzJBYWJMV2cvSlVlSzZIb0dkSC9v?=
 =?utf-8?B?WGFkclRHbFd1ODU1K1gvbCtzOHA4ZGFkNDdIMzlXNFF3YTJoRy9BMlJ4Nk5p?=
 =?utf-8?B?Y01lUmpYdEowVk9zQUlsMUVncFVuRGpVcmlsV1o2bXNyL0FEQmFONmorM2VL?=
 =?utf-8?B?cEd3eGtKS3g5a3dsRlhUSC82N3h1ZlhDVXEweDZkb25rekR3c0h3Q1dZQjNo?=
 =?utf-8?B?Rnc0OVJUNXJ4UllkMTAxZ3E2L1Q5VG9mTWdlRmhTcFR2anJyaGdLc3lDNld0?=
 =?utf-8?B?NlN5M2ZiczlnVWhrSGtDS2R2dDNvUTdpZzE2SE1vN2Yyd0tNTHl6ODR4Y2Fr?=
 =?utf-8?B?YnNjb2ZRQTZCa1lNb21STkVzNFQrdXNHM29ua3Urc3Nia2F4TWNWKzFBWHRC?=
 =?utf-8?B?Y3JiaS9RQjhPLzNmb0w0YkNUOGNYbllEZytyOGFkNzZGeGVoWkU3eU9BY1Zr?=
 =?utf-8?B?d0I0TWlBNzFTbmM0NG5CR2FhOThUTUxJSHowb1U1Q21remFmb0xQbDRjWTVC?=
 =?utf-8?B?RUs3RS9qb1VGa3ZjYTdHK2FXOFg2bStWcDZwQ2tUWWU3WEZ3SG9wR3IraitP?=
 =?utf-8?B?VEwwVERBcWdqb0NEdldSR1dSS3gzdWZjcG5wSzVSeXVOY3h0d3RPQXRKcUhk?=
 =?utf-8?B?QzlVYlZkalpGRitKRGl0V240MUVsbXhGM1lWZFlXOWpKRkpteGxPRmtvVDFp?=
 =?utf-8?B?UjFESWJwSXlxUGl6Kzd3cTdSZ3NDby9BdDRxa3JHQmdzS3JJUDdWV0V1OVlo?=
 =?utf-8?B?b3lueGlWNys5TElKb0RJcHphbm4xQVdvU0hPYVc5MUdEUXYzUVM5Z0lZeml2?=
 =?utf-8?B?Uzc3WUpQRlkzaXhPMnU3My9vaFowdlJvWkQvNEVaWlJzMWN2SHMvcXdacmNP?=
 =?utf-8?B?M2t4VWFSM085bDRFWDYyRFJMdzZpaHFCaGF6b0VYQ0hlWGVScGh0MlZIVWli?=
 =?utf-8?B?aFFTTGVUL1hHNVVYMmhPbVN6MzlJWnhqWXJ3SXdZN1IvWmh0TkdEenZTSU85?=
 =?utf-8?B?czN1bHNiak5hN2lHMm8wQU5ncmsvaEl6ck9BNWJzMlZUekxSWlhZNVVDRnFJ?=
 =?utf-8?B?MkJoNnBBSUZ5OGJRT1RhOURXcHltbXVZWnpzRVpoN2srZmcrci82cm1zcE9F?=
 =?utf-8?B?STVmV0tVQmhqcjFuQVROZWQzSzlheXREVThVN0crT2YweHJqQXM3bTlRSjRU?=
 =?utf-8?B?ZCtUd1ZxLytINStBYzhQd0V2ald0djA4NVltbGxRdnFqamVLY1NzZ1g0NGZX?=
 =?utf-8?B?NDJ5cnJUV0NYODVxem8zQzJIRC9TaC9qdzJaWVBKNFFSL1BhUFF1UHo5VEhT?=
 =?utf-8?B?bSt3YzZZT3Z5NEIzcUNVWG1PNzRiZTBQbnRxU1JvaTBPaFJVNzNtZXVaUENY?=
 =?utf-8?B?a1l5L0F2Z1BLZGlHM0xHaWE0aVI3dFFuYVhLTkoxZEVlSjJGTzJHSURNZlpo?=
 =?utf-8?B?UFVKelhJSlI2Z3dpQVM4MTN4UFYrWTVoWkpPODltdmlxQVliVld6WHgwckxz?=
 =?utf-8?B?NVZqcTRWRVJVR3Q3QWZzTUdDN0JzTmRITUl6VzRhUms5dThYRUN2YnlySzZI?=
 =?utf-8?B?SlJBRzZQckoyNWM3MjdkVThBdmJJVlphY2M0YmlPMHJQRUZGNDdPODlTV2NC?=
 =?utf-8?B?QmZvTUVtTUEvK0J2MkJ5MmdlUUZzRUkvQXdURG5ZMndtV20xbkxmYjl6U2M2?=
 =?utf-8?B?MzlWaUhweGNUeXdUMjluNWlqczRjdmdnZ1JWeWg4RFFOSUhjaCtWZGgxeWNZ?=
 =?utf-8?B?WmxNbS93NXVodEZuUE9mcmFXTy9PUFEyM2V2N09ubktqci9NYWVncTBmOUVH?=
 =?utf-8?B?T2tUTE1lTDZ1Z1hHQ3VzY1lmMFpKTDdUYUVoZ0FLZVdNTk5zeTYvQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a2fd99-e17f-4920-f8ee-08deac222e68
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 10:19:54.2142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMf3ZPD1lkM+bUR7HaOFNQ+BUBsb9ln7e9pWnrIgtRH7besvw4iySwQQp0Bs0QZ0ej+o07WIQnFsC6VoVWkSLi9K0dMPM56tpu2lJ4zCgD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7815
X-Mailman-Approved-At: Thu, 07 May 2026 14:04:29 +0200
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

Hi Julien,

On 4/29/26 3:58 PM, Julien Stephan wrote:
> In preparation of Airoha AN8801R PHY support, move the BuckPBus
> register accessors and definitions, present in air_en8811h driver,
> into the Airoha PHY shared code (air_phy_lib), so they will be usable
> by the new driver without duplicating them.
> Also, update air_en8811h driver to use the new function names.
> 
> Adapted from [1].
> 
> [1]: https://lore.kernel.org/all/20260326-add-airoha-an8801-support-v2-2-1a42d6b6050f@collabora.com/
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   MAINTAINERS                          |   2 +-
>   drivers/net/phy/airoha/Kconfig       |   6 +
>   drivers/net/phy/airoha/Makefile      |   1 +
>   drivers/net/phy/airoha/air_en8811.c  | 304 ++++++++---------------------------
>   drivers/net/phy/airoha/air_phy_lib.c | 216 +++++++++++++++++++++++++
>   drivers/net/phy/airoha/air_phy_lib.h |  39 +++++
>   6 files changed, 329 insertions(+), 239 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 105590ffad0..735ecc36210 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -61,7 +61,7 @@ F:	lib/acpi/
>   AIROHA PHY
>   M:	Tommy Shih <tommy.shih@airoha.com>
>   S:	Maintained
> -F:	drivers/net/phy/airoha/air_en8811.c
> +F:	drivers/net/phy/airoha/
>   
>   ALIST
>   M:	Simon Glass <sjg@chromium.org>
> diff --git a/drivers/net/phy/airoha/Kconfig b/drivers/net/phy/airoha/Kconfig
> index da8747939e3..5b109d5c6b4 100644
> --- a/drivers/net/phy/airoha/Kconfig
> +++ b/drivers/net/phy/airoha/Kconfig
> @@ -7,6 +7,12 @@ config PHY_AIROHA_EN8811
>   	depends on PHY_AIROHA
>   	depends on SUPPORTS_FW_LOADER
>   	select FW_LOADER
> +	select PHY_AIROHA_PHYLIB
>   	help
>   	  AIROHA EN8811H supported.
>   	  AIROHA AN8811HB supported.
> +
> +config PHY_AIROHA_PHYLIB
> +	tristate

tristate is invalid in U-Boot, use bool instead.

Cheers,
Quentin

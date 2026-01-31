Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0744FD46C1D
	for <u-boot@archiver.kernel.org>; Sat, 31 Jan 2026 02:34:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 197F98456C;
	Sat, 31 Jan 2026 03:34:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="Bckm4HjA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 445F58457A; Sat, 31 Jan 2026 03:34:24 +0100 (CET)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d405::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C563A84568
 for <u-boot@lists.denx.de>; Sat, 31 Jan 2026 03:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiPnYGjsLAG0qIKIWZiFaDdUmdXdFeP6VaZTuw7fgAcY/9PXujaodWJ7faqfHzE9rFIP5UKdQdJXTibSmh87fa/JiwiAWmBGyMq5U2x9SbJWsgzvNlafaU3PWdsnqW2vquqhOX8cLT8MNjGfY+rjv8tx2JWRwtdyTGp49P8bh2CSFj3EJikJlippvmPS6IbIYcX7H1MX/Eact+uq+30pN3SGBIJJ3k6yVlBsn/c48EHGh8aZZHbs4ZBsgMMsbZksLL4+cO/aBJXHrPz8KCyJ4Uuf7sbN9FJuuyRWbqaFnyILYio69lxbkgMLDCvp0ZZdZT2oiPjlP//QtJtSpq9mZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ce4YHNjju97XjPwznC1cI0UrBPmh70KWgQV30cUp+8s=;
 b=e0T3Z0R9XECqxzW3I3+PWng835qhKRyz5Basw/0yG0jJnAzwxmEmZ5Vup+BTpX/nQ+B2VWtcLXR09pJflzt+v6M99j3tc8zqkFFWQ75Oc10E9qWgg41TRS6F/OmOTLPanIgMZvHkQlmxeHq6Pv2KGAEG/UOvIKIUd8jN+srumypbTXEvA7IZJaJf5A9ii6yggAi90ds5xS1d2QhWvScot60J8JXjYh3+YzGBzs//4ziEgxAm7UGGWrRLh6tkPAeWUyV8l2wKcxqCxzl3JF/f/fT2b1015MuiRw7rX37e6ZX6zd+gA6kEhjQ57+zRZX31KgR45MwRlOntFO5qa4K/IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ce4YHNjju97XjPwznC1cI0UrBPmh70KWgQV30cUp+8s=;
 b=Bckm4HjA87HOR1EVtPWmnDu+G+p4TFEPJaE3ZRn/Agm90Vz/PiN7K8FeCXs1WYY1iY4WoNBvHgSVobtVaq+K/JT0EUJo8f6lzI773/eMwvwJ3GUIiBelj46GK36EeReGoFq6OPt+rfEnvz0uN4WjS3DVwDcHofVBHaGr3SPnuhJpVnTMKo0OHNTtgc8H6qtZBK7AIMOsnJKDae9F+pGrc477VuY57vxYrmBj6UJjW6FMQr2YWjKqctVP1zIFNNiPfpjPktZ/ROzvTQFbO6qpEvMQ3xJPGPCc2lbBlz2cbPQcjKoIhKpakFifmYcFmahLETxqZIg9P28ra0qhYHG6gg==
Received: from OS7PR01MB13602.jpnprd01.prod.outlook.com (2603:1096:604:359::9)
 by TYWPR01MB10741.jpnprd01.prod.outlook.com (2603:1096:400:2a5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Sat, 31 Jan
 2026 02:34:17 +0000
Received: from OS7PR01MB13602.jpnprd01.prod.outlook.com
 ([fe80::18f0:95b7:632f:9ce6]) by OS7PR01MB13602.jpnprd01.prod.outlook.com
 ([fe80::18f0:95b7:632f:9ce6%5]) with mapi id 15.20.9564.010; Sat, 31 Jan 2026
 02:34:17 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 developer <developer@mediatek.com>, Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] pinctrl: mediatek: set MT798x rev as MTK_PINCTRL_V1
Date: Sat, 31 Jan 2026 10:33:50 +0800
Message-ID: <OS7PR01MB136029C80ECF5AE153DD40706BC9CA@OS7PR01MB13602.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0232.apcprd06.prod.outlook.com
 (2603:1096:4:ac::16) To OS7PR01MB13602.jpnprd01.prod.outlook.com
 (2603:1096:604:359::9)
X-Microsoft-Original-Message-ID: <20260131023350.10053-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7PR01MB13602:EE_|TYWPR01MB10741:EE_
X-MS-Office365-Filtering-Correlation-Id: 11decd8c-2b0c-4bb7-b8be-08de60713ab2
X-MS-Exchange-SLBlob-MailProps: RlF2DIMZ1qUDiUrRDWdcIAv30B9TdfbxjcDw1XJytfttiPUJD9jqox9y7dlFoc0kilJk1ZuMTEAE5LF61qZnUu26XO2/o4tc3t0l/tv7eO2V7p0yQuU95VHStHaLFfWmo/tpeBOJHrpuAOH+YbrpAK2WOlI0BHBapNShc4MdVJZqEf8oLqDByap5ceT5C+8jb/SoPyKBOC31FuacokIbiOgAMsbUSmc0QgKl8dloWNHFPjRxs7TIG1M0boFRODn8Vn54iPra2pxwv20Bp1TbHmfekBSwuAz2ULQJASSdcvtGUG6WvtsQ8wQr7wdYi95VofaQAbECyncfzoF3ARzWrg3FDKV53ci+YykxwdrXxGp/QsiNUlrUEKX3lA72FTmsojeb836BZ/xQ+NE3b5d5XpimU5fcnYX8bX0uX6lZGdtNc9G9kTKvOmmRBhUZlH41tIcrIcKWZgTn6UrLAC+8iD8lPqsbRMT9Gp+9AIP2E/oA+6pfwRquqs8jLE3bCTB8lN96bF7cI5bk/exMoxfRAYLRNlozRl3b6PnlfKfhkpZxQ1BHtpniE87b0fDZAF3lAEyJTcTPIhGcakZpTw7kE9i2hx5jDwqro4UN1ixzCHhDKLMURcw+RZwQ3Bnk9eGjDTON5/d74LdLMJ3n4U9emVkHH208YDek2+Ws6JohSl0+Jyg/RY/YuafheZc2oECnxvivxbJllMpWMsuhs92KIzpEg5Ep+TlvtWQ+c7mvmtRIeyLJNRd65/PELKycOrazt5LAjzhUHfRLzWETKFUmaS0cn165YdNDV8x15CCo0K/DK85886htvBCdtPgug6w0MkwcvxQdQ19iPW1LtJDl6oRNIHbfli1H
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|461199028|15080799012|5072599009|5062599005|51005399006|8060799015|19110799012|4302099013|3412199025|440099028|10035399007|40105399003|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nJiYp/LeZ2PhbPhGxCUxpcp6/DxKS5Zw5ntGkcWw4b2Pj9MoZZAR3LeATa+t?=
 =?us-ascii?Q?OJgE3eK2SVgTnunEUZH/VmjuCnW8xd69GFP9kUTiWEsDy71OjcLvlhppuE1B?=
 =?us-ascii?Q?I4ybWsEWlE9FrCgrRsICzPNmZG000/kH3SrgzL4z2c4tgm4b1vZGIZIyoOTP?=
 =?us-ascii?Q?15Qib7j3ig8G3sxNHlybwASYW/I4EoELCdS7mRciECywHrAE4RXnTNA+SZWy?=
 =?us-ascii?Q?SToe9nxtPc1WlbUpTaMMH0jA+E7LlaZZx3Vpu7/JBmTT7z+OSMcW51f1Vdb5?=
 =?us-ascii?Q?w8vLUKILWFHgJrEkop8U0keD71hS3gkqZtn2lAs9nhwfUax5+tXbLPs1MqUe?=
 =?us-ascii?Q?HZxwf6V80AFKogRVvRwGPqnaIEYVl9VDFbEgTv+zLIixSod3qqVSdR3SckNf?=
 =?us-ascii?Q?fdYwqqUNqWUXX0WEhqaZP7DaLxILiIrvJ/Vn6BGeitH5vgTO5umq/GS4MGrV?=
 =?us-ascii?Q?x88WwOOL+Qj49agDQTXdnyYirtQ2t35CHr8X6jvcLQiaTSQLL924wlnH+exx?=
 =?us-ascii?Q?fqZJ3DmNNdgL5ZUCml4GxNLl0SP88iL4viw/xVC17qQOJ9Tq1htp74eZQiW7?=
 =?us-ascii?Q?8LaSGSjYtF8f4wCdAXiqfBxq0UkqqsUI8KHn4cNGnoAuby7+aZMHDMbmJeO4?=
 =?us-ascii?Q?bdQaM8ETo+ArQXI4/Qgq6aaNaa5gerwQFXvhVo+VSMqXxe9Lp2jFF6Zj+/3d?=
 =?us-ascii?Q?AqXCnkjfL/xhNhUlDmtHsLZc572mLUlqo5/M3Det5Ryv6Zelcry8dtetFuzt?=
 =?us-ascii?Q?SupRTgO6iCC9C8h+vo5JCPjO4HDNQdTN3N3FXCTbHrF8hqLPVkb2By3rQb0z?=
 =?us-ascii?Q?I1Os/RvvTSlZiNVQwuNv4gtqZDxP/JEwwya7R7Ef1FyfQIN3HfLdkf0/BIhJ?=
 =?us-ascii?Q?hMRO8ikFQ+F5I9IF35bcxYfBqzSFS0932seQ2oOljINH5uDD6bwlBFOpF45B?=
 =?us-ascii?Q?fYBIE/ygENEd4wL30QrJOtsGKSYBkM3hy4ta4vWZcw0lVs0/tV1V3NbOdTiA?=
 =?us-ascii?Q?vzyEHeh1/ORAXDLm+kCJN8Z12D/h9GWpWqzRtDaB4wnJdcLvfGjK5HZL3W10?=
 =?us-ascii?Q?7HKx5EY0q/M9jMRrtn3mDYN8CNrxSJrdx8pszU9YMT98xqK0me+fO02pPx1M?=
 =?us-ascii?Q?TSTpn+HE0+hv4/QMBNRVEfrrbeXmXTlVGRBntVzkqvTbQBEuRTX/OSHyW16N?=
 =?us-ascii?Q?IRAybrX9mQfO6QNg1RWO+6xhkVHeQIUCW+PBDAOSMnDVCRPEUGmyXxB7XTVr?=
 =?us-ascii?Q?1YEd1M5yOrs1LcK1A9r9K6rHiEWN53yQai4B33OUMRH0y2OzzvmtZw2iYmV8?=
 =?us-ascii?Q?TBz+EFyT5IDm4UIyH9sMhDqPpIcgcySnpeYpyHCIkdYnxNswV81uBVaZaHjA?=
 =?us-ascii?Q?eJjoVG3HklUU7AL/HUnjgPLlDXX0?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ypX/M9nXb+CtNATQzKbkWZBYneSatG0344Cw9iOHiGoQPVZgLz9+RvLaL84T?=
 =?us-ascii?Q?yKupM6Vy/JHgaQ9brSKjfrcbgXBZ5z1QmQGmp7FmeoUT6DSalmlbhevgbxB9?=
 =?us-ascii?Q?fPKr1B+sPh5zrk6hhbygylccXLszwe9mljvNgbv6Qm/6d6rtj+MYmghRNF6w?=
 =?us-ascii?Q?Grv8h9o4hPDUM/okP0EtGFeu0jvZ5ATfcALI8dBISwLbJGTav/IhRUpzrllg?=
 =?us-ascii?Q?F/yVMDC+57Nl9lnUNhwRzG6ckmFTUYj6wzCtcDoEOkj2abOE41VbadYLKkB0?=
 =?us-ascii?Q?4cBI8uWM7Nh9hOR5hdZ6jLtV9V4ztn4DWqKeKbDExWNBSPsJjtJbyHciOpqg?=
 =?us-ascii?Q?N2xb4FX8uaQMlmFgFcwpDY2IN9yBBnvFmliBb8h7216v28s8LgxpMuW8fVBr?=
 =?us-ascii?Q?lQLvqHLcGegFaaUyRFKBjggge4CkKLNbzMfaJeeENUqO8gNfEhv+AzBax282?=
 =?us-ascii?Q?+jD2JQNtOneTkCKevJUndAyXpJhNbjU3uNCkHFTG665WgLXjRKlXet7z2Iom?=
 =?us-ascii?Q?ZwwOGPwQqw1/iCWf9HV0PMEgWAq2WE0B1+av1hGosZir5iEPWffNM0HnY84b?=
 =?us-ascii?Q?+D1x2kw2j9dLFqmkEbshxspxxrfRkUgngyVWg4BIfiVK2VaH/Tic9hLkq9jh?=
 =?us-ascii?Q?ATHQs6tmx70sKzSQQlIc6mCtnWowC+bd2lQlBjoF/Q4IVopwBrECy1LvTDvQ?=
 =?us-ascii?Q?kmxxE2/JGjhpHPhCiD4OPtx3AMInhs+f6U1zzdcD7g4bHcNEDJ3fxuldYomX?=
 =?us-ascii?Q?OCZdRiYohK5WXo5IFWM1qS2QzRK6iL47s81uiI3oEpJp+JDjksNJih+eM3WM?=
 =?us-ascii?Q?CW29Ju6WPcO8N79/Wc6hjUbStH9wOqjdQVI19yoGo8MoqA76i50adWQVwU5q?=
 =?us-ascii?Q?t2aJL9b07DgSKs9qz6jAyAyye5wncAeHR0uvoTYabV1ya4MaiD1Y7TPkZERZ?=
 =?us-ascii?Q?wSXYvXr0xYeNviMrYj7i/2zw9E8rC6QvbFtqDvJj7/hsplC9CCZX60wvJ5eq?=
 =?us-ascii?Q?2CEORkxl2lpOZHtb374v/nApVvwN6It6XDkefGpa+7VpNVanxlJGfyVIxt4w?=
 =?us-ascii?Q?MWL3lGLfEiuFbRNi16JFLSlrGV1EqyTfwjcwneNl5+MyDZZjLEBOQrEn2KeD?=
 =?us-ascii?Q?/PJ53KvqqkwxpL58lfhLw/Bo9R2nfwFlMfSKRG+rl77f4l4GIyWrynvJLW3K?=
 =?us-ascii?Q?N8BDeuig7ip/GCsEd+osemQwEMEnmyL2fs7PLTQLAiFYMa8usmLtTXMf5ijL?=
 =?us-ascii?Q?UP1gLeGSGjBGc2rVW23mNHQD6JHEvWaF3YNfyfRTwDpvFc2Yd+LHx6cG7cWz?=
 =?us-ascii?Q?dh0NYPFnRCI59NaOrhGfc0jwuzqw2YquOUdHgBS+jCdcKCPhr64dzuviO9KP?=
 =?us-ascii?Q?oBi8CP9etMjngnRP4nDI43I0cEp3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11decd8c-2b0c-4bb7-b8be-08de60713ab2
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13602.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 02:34:16.9881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10741
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

The MT798x series SoCs have IES regiter definitions. They should
belong to the pinctrl v1 revision.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---

This patch did the same thing as the linux upstream patch:
https://lore.kernel.org/all/OS7PR01MB13834D5838A90C138C62CD817BC8AA@OS7PR01MB13834.jpnprd01.prod.outlook.com/

 drivers/pinctrl/mediatek/pinctrl-mt7981.c | 1 +
 drivers/pinctrl/mediatek/pinctrl-mt7986.c | 1 +
 drivers/pinctrl/mediatek/pinctrl-mt7987.c | 1 +
 drivers/pinctrl/mediatek/pinctrl-mt7988.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7981.c b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
index 0d3cf71667a..9b650beb01e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7981.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
@@ -1070,6 +1070,7 @@ static const struct mtk_pinctrl_soc mt7981_data = {
 	.gpio_mode = 0,
 	.base_names = mt7981_pinctrl_register_base_names,
 	.nbase_names = ARRAY_SIZE(mt7981_pinctrl_register_base_names),
+	.rev = MTK_PINCTRL_V1,
 	.base_calc = 1,
 };
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7986.c b/drivers/pinctrl/mediatek/pinctrl-mt7986.c
index bf8cd037535..af7f347ab58 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7986.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7986.c
@@ -755,6 +755,7 @@ static const struct mtk_pinctrl_soc mt7986_data = {
 	.gpio_mode = 0,
 	.base_names = mt7986_pinctrl_register_base_names,
 	.nbase_names = ARRAY_SIZE(mt7986_pinctrl_register_base_names),
+	.rev = MTK_PINCTRL_V1,
 	.base_calc = 1,
 };
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7987.c b/drivers/pinctrl/mediatek/pinctrl-mt7987.c
index db672d26798..2042e7516d7 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7987.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7987.c
@@ -712,6 +712,7 @@ static const struct mtk_pinctrl_soc mt7987_data = {
 	.gpio_mode = 0,
 	.base_names = mt7987_pinctrl_register_base_names,
 	.nbase_names = ARRAY_SIZE(mt7987_pinctrl_register_base_names),
+	.rev = MTK_PINCTRL_V1,
 	.base_calc = 1,
 };
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7988.c b/drivers/pinctrl/mediatek/pinctrl-mt7988.c
index 639e2415c63..9d8e09f8dbb 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7988.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7988.c
@@ -1250,6 +1250,7 @@ static const struct mtk_pinctrl_soc mt7988_data = {
 	.gpio_mode = 0,
 	.base_names = mt7988_pinctrl_register_base_names,
 	.nbase_names = ARRAY_SIZE(mt7988_pinctrl_register_base_names),
+	.rev = MTK_PINCTRL_V1,
 	.base_calc = 1,
 };
 
-- 
2.51.0


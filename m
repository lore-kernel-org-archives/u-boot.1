Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C433FCD6E57
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 10:05:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF58B84944;
	Tue,  2 Jun 2026 12:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mZOmg/QM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E167F8488F; Tue,  2 Jun 2026 12:05:07 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64201848C5
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 12:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrpSPMzk8+P9MIXsNlloL/uV7titw3n6FlM37v5r0kcEmmBjJIgCVytYwWfJIxVKWt1M4JHPj/ZNS0L2ucasgw7Wh8F4ThZA93rMo9nBzZ8jua3/DDO4zPSodxoq9Pjjn1E0VtKrh7dxFjo1HLOChbYopIUxAEXntAASO0qgNFBAnyPQnxPm5IcQtcKuNT+8a0DBcsrEKRkCPA/Bsgud1wbvl5TQz5elPs25Ai6JAMUKMnyIrQN/hjbAbfCAwIQh7rfRqT3GV1AEN6QLW6Jx7xLIMnJ203cq57E7zMFr4UluKi0olsd7ElvriCP2EATfOKUzpW9m3FpSBiYNm5+QmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iAww+M6bwWbqGgen7eh+rMTCdamjUOiPPM6AmLjQTc=;
 b=lGdWPCbs5V66gvZi3vdalkZIQu/WIgF8wbFl2PJ6HM/7nJElmChuepSYqqZ8/+67mOndGbe1YfhBNOFy32YJx+h635QvYqZScgSLbGQIL9FkpkzfKJDc5aqBmlqChcpL4O3jDTNhzIu1FW8rYkTblA5Zag6LNk17jegy1RAkKwEytPi24WQoCip3Rbgxo7TsdoLI/Ad4bEGKasvRKubyLWhRdTgCHsGZgznhTc/OYcXB26Ao67Rz0STtojx6eJ+BkqdO3qXXMTe8a6G6XkSZTQYCtDp4Pg70e6ZnRTtuxFyWPG3JoVlOu5TK/oFb22Jf4HoZBLpzHaUQhDvxQlz9Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iAww+M6bwWbqGgen7eh+rMTCdamjUOiPPM6AmLjQTc=;
 b=mZOmg/QM/t6JHpoNcS1Lb0V+DzSQJvKbs1xYXQ/1IIAwjtd9p96FoSbfsNI/OE1o4oPvsGP07OQepNJUOdy54YrgWkBb74d7crX6+VMtKnMgSbHbr4WUXCxmTUyxZMZFwwhpbdGdMcVZkQwQMUyi+9T1dCXW2941E76qa7BIRJ98M2vJp0ZtOybY9XzRXrLuZUlTNkpwgIGVFgJfhp3wtKhOw7gR8jMZnFmr6R24uQYaAC0BZgb/M3qGsES7P2sZKAVlGe9v3I56sJerBUTSoA4gXBDEPKey4E7JPxlH4Y34+Jbqsf2nLYZCbkNi0vFFyeba2reVtzOtfXrwo7STFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PR3PR04MB7372.eurprd04.prod.outlook.com (2603:10a6:102:80::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Tue, 2 Jun 2026
 10:05:02 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0071.011; Tue, 2 Jun 2026
 10:05:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 02 Jun 2026 19:21:42 +0800
Subject: [PATCH v2 3/6] usb: musb-new: Update phandle handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-devfdt-usb-v2-3-a587ab36b906@nxp.com>
References: <20260602-devfdt-usb-v2-0-a587ab36b906@nxp.com>
In-Reply-To: <20260602-devfdt-usb-v2-0-a587ab36b906@nxp.com>
To: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PR3PR04MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f8c1f2c-616c-4f01-d6e7-08dec08e698a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|52116014|376014|7416014|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 6AU64fuZv1A1kUFWX+SDkmi/J9nT79aXvwrZ9koAKXb7bQVtvezBDk2geMEF2zvN55MsB+8+kCVoGp945mF7FYm/uyerLvfcalxSj0s34ia8wmpAh/f3bKUneE5750nDnruz2lZncZFm3CTtNHiPrkX1v/xYHOr4aeHRdgqDoCiWkjiUFU4A6lq8g9Tw+tkVyiB21NQwy2lCwkhZuNlFAYmv4X74oFGiy+FNU6s5dxCLhfa1WA55Q8Y934RSpyHHn8NFctGC1pGl6INswXk5zW9bnBR2A2P6RymK8F8RAxXaohMabyzQN7y5tm8odVv04QacrEwZ0jKwvi0283Q/JubKjvVvm4QXMIWPZyH45RTKRvDtOZm4RpGUdzj2AHHJP9ACs26IIFUKum7vrfOuuWFNO+OrEQR7/mW6U4mLJwnsFvAy0UHroZ4dX0owhKU4fe6T3XzcraHEK64pEsu0/bJ/fPO6a5Pkh6QfoiHvh2VnXOnIxYFqIrORgU9IUavqHvnbDHQkpI82CqvDIhUck6cyrOJfSnUjCp01jzUhoj3+39AWCgq/tH7ZSQm9xDvW1rhV3XxlDk33GTlm2kk72zk89cyiUa8djkCxVp16vqZqHZdR5noqFIvmHThAA9X68WeYBOGVEHBH2W3ul72rIbYoAQ2dvuFquKbmmj1btbNLWqDyv7FgP7onHhR0xBBRjA0Hzq4+MSaeLx1jPntSk7SxgYisXnyyjq+EwysoO7lwnecj7Mw92BIza19tOyOk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(7416014)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW53WmRUM1RxWjR4SWhSUm5yYjIrRjRMVDVnMGlYOWp6WGtBUVB1dnhuM0dN?=
 =?utf-8?B?WjJxaEN0RGl4b212ZSsxdzRsdmFEVWlSUkM4eVFlQXhObnQvR283WXROOFkv?=
 =?utf-8?B?TWlFbXdIRlhOSXJJSVhkVTJuUEtUN3hNc2JNYWlTc3JzZVVUeGlzV01MaVhu?=
 =?utf-8?B?L2dSaDhkYXNVckRrZmVRM1JJd256L0NGSVRwVTdRaEgzeWdwNTE2ZXVQRXVU?=
 =?utf-8?B?R0M4a2hOTGVLK2ZmWVJEaUo5T1ZmdG43YWVLeE83U3RCZUhXbTc1dVRPaGl5?=
 =?utf-8?B?aHY2NUdEa29QOUwxaW5WWS9INlcrblNWaVNxSG8yZW40VE9QOENzV1FYYk1o?=
 =?utf-8?B?bllzSjIwa1hPT0lRNDNKMDZ5SXNuZzdadk81QjBqVU5nYUpmbEw4aFFYS3gr?=
 =?utf-8?B?YUExQnFjRzJyNm1rVmtLQ0NFbmtQMm8wUnJyd05YckRqQVFuaWZzTWFsZzZj?=
 =?utf-8?B?ZlJUSHFEM1o5dDhUVVdSS1pKT2JxUVBjdnNueGN2UENva21IRTFhTUZhMEZB?=
 =?utf-8?B?c2NQdDREYzJnT050cVRqUThlZlJuZks5bWtjMVpBckRLYk9OQmJCalFBbUxQ?=
 =?utf-8?B?K1U3aE9yOGNObXZKWmZwcDZDLzFBSkc5dU1PNzdNbGxsdTkxcGVtdldRYnJx?=
 =?utf-8?B?aURLUGU0Z2hPOUZ3NmExUjEycnZCaVlWNEQ4MzRSNE5jNzV3d25qMDNxMnhs?=
 =?utf-8?B?b2xPbThIcDUwMW5zby9iMWJhUS9yTmhOUnRUMXQxY3I1RHpMQy9TY3FCdk1n?=
 =?utf-8?B?ZzRsK2t5bUJOeTMxY1hTMHpKekN4Y0QwbHdGMTU0aUxyVGNZRHYvd241dzVh?=
 =?utf-8?B?TWFBTEU1R2k5Yy96Q1V0NnI5YUNidFNjQk41N2hpblUzcWxNVlY1UTgvcTlO?=
 =?utf-8?B?ZklZdThubWtNR2t1M0FHdlpqVi9ML3BmaHc3U1pMRkU0NVVBMjlaallxdStn?=
 =?utf-8?B?RUVubHhsWEJRM0t2TUJReUZ0ZGxCRzFEOW93cktXWEhFUWQ1Y2UxWXRhcmpv?=
 =?utf-8?B?QWNLTGtDa3NCd2JyM3RMc1o1eGplVlFpRDhQblhGSlAzUVdRM2RTUDBrc2hr?=
 =?utf-8?B?WW5tWHhVNEZoWkNxbmh5TTFNTTUwdHErY2JWWXpVSnpuSTFFNlFLbXg4VDVD?=
 =?utf-8?B?Vnlrd3M1VE84QUhkTTFDdWhqZFQ2OG03ZEoxQndtcVRwWHNhcFk3NXY5ZVhr?=
 =?utf-8?B?allreHF5U0xQOXVLVFZ6UDdpdzBxSHI2ejUwOVRBcm1YbnpZTkU2Q0w3K0la?=
 =?utf-8?B?clkydHBCSXpMakprMEwzem1pUFpab3ZqZjVsUW9iYXQ5UHRsdi9tazlIK2Na?=
 =?utf-8?B?QU9BeEFvYjlOcHdmTFkwdllzQThlVS9NODNyVWV1V0NEdXNERG8zWEM5NWRK?=
 =?utf-8?B?SmtsU2pYUnlyS1A2UkdxZnAwR3FuV0FTc0RHdTc5RDhyc3F1TGJtQTF4ZWNj?=
 =?utf-8?B?VUxNdGZhK3hmTkRCd3gvQ1hBcm9hNDNIMGVTd2NJZ1ZSYmV3NzZ4WDZNS3BW?=
 =?utf-8?B?MTFoQ01naGlyN0tEOWtNeFJoOFV1S0ZRT0FGbkJqTHZsQWtuRE5waVBNYkJm?=
 =?utf-8?B?UmVmMCtKMlRSSklZTjVxc1JaV1BnK3FDQ3NaSTd6QlNqbFU5ZnQzY1hhVWRw?=
 =?utf-8?B?UFByYVhiZkUwSDhuRkJjcGZjanNLc2ZPaWVDdDRYeUhuM2xmaWRCc2lzajdU?=
 =?utf-8?B?R2VCaGQzd2lkRWs5VWJKNGc0SkNMb1NtaU1qcTdacXo4eTlwT3lNSnA3OWZB?=
 =?utf-8?B?WUVDU0l4b0NIRjNpeDJPVFBPbXFuOEFxcStjbm1uaXZ2MEpLc3BzYnRUTGN4?=
 =?utf-8?B?eTY1dUZqajJxVlFUTVdzcmZFV3RXNEszLzJlbjVqSUQ2cUlkYjRYNmY3eGVP?=
 =?utf-8?B?MmY5d2lkazlaZzZaU1N1eFFickdOUTQ4RmJRVVpsTXVac1ZmOFl4WkYyZ0Vx?=
 =?utf-8?B?M0NMcjJra0daSEpDZkl0bzRBYW5EZW9uM1ZaNWhUQXVpcHp5V0RvSHovVEhn?=
 =?utf-8?B?ME10TXczdWM4dER3RVNwR2ZiaGQ2UTdiOHdzWlR1aDYzbzZHUGI0UXdyeVpE?=
 =?utf-8?B?N29nNlhrcmVZd0tUb0hCNm1TRmRabFBERHd1REZxVXlRK0lhSVJRRER2cVYr?=
 =?utf-8?B?VlV1RWMxY21La2VLRzQ3NWYza2ZzeXZ3QlBKZFZEYjdQL0krRlRvb1pickQ2?=
 =?utf-8?B?UGE3dTU2RkMxY2hRM1lraDhUdm4ybkRlSFZ3NWt5NWNiaWpRc01LUE5wOTdS?=
 =?utf-8?B?RHhtVHVjR2xIa0tWZjl6ajB6dnd0aFIwaWxHSENWUUhYUUZwM0w0YzF3dE1N?=
 =?utf-8?B?RU5nbStvR3o5cFBYUThFQzRKc0Y4eHNHejBLOVNUL3VOaXY3dEcyUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8c1f2c-616c-4f01-d6e7-08dec08e698a
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 10:05:02.4440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ex5mx13krnDxyQeYzRfUtiLd1AEagE4s6KfRSRa3vF0TZaC81v57GDl3yWKcC3WuE6GIBBSj/wCFUOcsc8tfCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7372
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

From: Peng Fan <peng.fan@nxp.com>

Replace ofnode_get_by_phandle(dev_read_u32_default()) with
ofnode_parse_phandle() for resolving the "phys" and "ti,ctrl_mod"
phandle references in ti_musb_of_to_plat().

ofnode_parse_phandle() handles the phandle lookup in a single call and
works with both live and flat device trees. Add ofnode_valid() checks
after each resolution so the driver returns -EINVAL early instead of
operating on invalid nodes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/musb-new/ti-musb.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index 1c80b78b031..73be026af85 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -85,8 +85,14 @@ static int ti_musb_of_to_plat(struct udevice *dev)
 	if (!plat->base)
 		return -EINVAL;
 
-	phys_node = ofnode_get_by_phandle(dev_read_u32_default(dev, "phys", 0));
-	ctrl_mod_node = ofnode_get_by_phandle(ofnode_read_u32_default(phys_node, "ti,ctrl_mod", 0));
+	phys_node = ofnode_parse_phandle(node, "phys", 0);
+	if (!ofnode_valid(phys_node))
+		return -EINVAL;
+
+	ctrl_mod_node = ofnode_parse_phandle(phys_node, "ti,ctrl_mod", 0);
+	if (!ofnode_valid(ctrl_mod_node))
+		return -EINVAL;
+
 	plat->ctrl_mod_base = (void *)ofnode_get_addr(ctrl_mod_node);
 	usb_index = ti_musb_get_usb_index(node);
 	switch (usb_index) {

-- 
2.51.0


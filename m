Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43ED1CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 07:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EEBB846CA;
	Tue, 26 May 2026 09:53:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="e3ErgR8C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38233846CA; Tue, 26 May 2026 09:53:40 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53DBF846F8
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LToAC+RCBTnjMLiVtuk0bibOZgzZfsoSRtybQDbxK7Nbotd5A2ix+8xQu6SBBsS3VCA65X2BitZpjxA19bRDwyLTJt3NPcR3sImrCxJIq81BMlzfylaJVbl/a0wfM7lsJJXQcqfJztWXMfrElPXUv0DNqCNh6kLOOqluYnzSPfoMinaPAwiMxwsDPBPNuz2sWFYQSp1XInf2UuWZqRiqD0wAaz0rPOT6pNUY//lbklcC+t64Wq5DXLpg7PH29bKJv9S0Yo0+wf1wMiIizbNJgB+8MXskS08W5EHGZnckQ5pGp9UpYxQFI6hu4cDRTzzlynp2oCYAkerNqjvUO8DvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvqY8QVQmQeb//GDZ4KFYWgjDi7VPf+dsHC8/Jvkekc=;
 b=VzQSOjjF7N6nApK7QLwWCjlvkljS7WeFQNF+u74pQwYxskTE6a96gx/pzGr3Wa3iFpr6+msxS8jy0+QiF46MlqDoVmw6RQFIlmeQNnAPeXdevymmJpnbl6XXXJVbqOihkgtbaWcccxoX3HaaqRvGmX8jkubS0Agcompzs6PqG/ZJ605MsP2HkP3/DMWgfd/q4JmhZaGvYhJv+eNfbtpwds2ygk1Sm4d/YBIYqs9Sy8JOJIReuySiXKpgfbAnIwETZfA+Gm6Tfmx2j3bQdEvRVWoU4PJeWF/5VB3e3lX8n/W/gxx/p/LEaFwZapZ7L4RM2ZSkC6GlV8weUSDdJyRTsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvqY8QVQmQeb//GDZ4KFYWgjDi7VPf+dsHC8/Jvkekc=;
 b=e3ErgR8CVEKWhVwQXqkOKhJfRfRFtypfiicWU3I/tRi3ewAkl2JlfZ84k+PbwY4QBJeffjELD9zMm4LUHhkGC9P4ZjOgVe6umbr/XLT7EDxCAznMGyo4o84gTfP7fkgbsIUd/GXUx/JgLLLwAxoolxg68VarAdYK/bu24/9gZR2aCL37TwKxadnBly5qrGZNXwFP+uIYyz9LvcQWTfG3g6rmS7R8jstcAz9mqJ+0aWkFeiTsQUbyRSv0ASFNFtcTXkOr6zlg4rZVM0UHe0wTG5xAXpHrkX1SHSu9w/bURSK4Jm2gi6zn4oW34M5da7WUEGIwPWRhXoRX1cUAJCgaDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 07:53:36 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 07:53:36 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 26 May 2026 17:10:01 +0800
Subject: [PATCH 5/6] usb: mtu3: Use dev_remap_addr_name()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-devfdt-usb-v1-5-a4e22b23bfae@nxp.com>
References: <20260526-devfdt-usb-v1-0-a4e22b23bfae@nxp.com>
In-Reply-To: <20260526-devfdt-usb-v1-0-a4e22b23bfae@nxp.com>
To: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Marek Vasut <marek.vasut@mailbox.org>
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
X-ClientProxiedBy: MA5PR01CA0217.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::8) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|DU4PR04MB10401:EE_
X-MS-Office365-Filtering-Correlation-Id: 48771055-5f15-402d-1e63-08debafbe441
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|11063799006|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: JsKhOk4HmcLR2G/sWFf+rFVjUkIRXagMlb9mLtVJe3MfDo+CVBqfpMBYmmYuMjFLCoNJLEK2lmbKIb0PNRamTILNeGvY4fshDzsBimzVRkxY8aGO0rUEbvgnYgpHEtl5SpfXkGSiCf92nSdvmoVvpB3gfEQj1MBISjsM68lbuoAMH7rJbFya0QY8eB5LpGBq2q9gnKSi8asVrcpjq8pHgpPAQEyJN7LH2FvKfMFz4zM3QRlEybg1A7Gckp6RFUitFMCUzviGtSKL9tppmBzx5RyJmGLAg1Pr6xyfau2OFviIlG+x3YQtWtY/DS0w8tL1FtzVc7MOLvv+biakMWeWZO6jJpXMdBM+Xzdbp59/GLn617yEKegzBqOhTDVnOsbW5ePFFLCmMxEocuL+i2ijp7V5dKm99AQkXvqbVq8yFsWGaaK6CZ4jUPxNH2yIWwfJMFwT/OXf1Zt7ngcoNn4P7MgQlBNOOAY155X5JeZrbGWsaVnf6baTsVyXlFpXVjcbEUwQOFSyNipCXd91MkNQ20Wa/25gioCn7VRKjpLW4KolbRU9zamYR5PsaAcfd9Tgdlbh4b04Ul3CAMyBHTW4qnlpwVJCIgrONj8TJWrrpFzJb2eEPBT2PKQALCbTXT+EFk8KNb6cxPPQ/5bo2cZMQ/sOiqqgPfsIZOUEN8jrQ8nZquQK3VhR1FGHET7NMRM8SLjghPSS3f/r+5rgshqlEm3ksOVRhPHz++XZB0ucxctAVXnPfuq8Rtyr8yf7SdXi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(11063799006)(18002099003)(22082099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTB2TlIwRXQ0L1I3UHlIY1NVNDJ0cHhPTW5QVmgxU3hkT2VpY3ZIb08rSGhG?=
 =?utf-8?B?aElpYVF0WHJpcVgzeVVMUSs1TjNuRUJmbWhWR3h4dGJUcm9QWFZaTFdRNzFH?=
 =?utf-8?B?R293OWpwWi9SY2hvYkVZcEVKaVlkcTFiZTRsZ0dvd2M3MThicTc4VEEyaUFF?=
 =?utf-8?B?azQxcUM3UFlVeloxRFlyNC9SbHV2Y29iTElpV1hxTzZVR2F1by9meTZhUjJE?=
 =?utf-8?B?Mm9uQndSaEhvNjg0OHRscGl0TkhDVmVQdXNvYTdZYWVoTDFBYmlqR1hnTXIx?=
 =?utf-8?B?eGduZTZsVjZJb1NnRjlseTJKdk1OU3RjT2J6dzZOQTNMOGMwWjBNbzBQYXBz?=
 =?utf-8?B?NXcvUUE0VlhJUkZSckJGeERvT0xCUjd6Z09KMXVvMHdWUGp0dWNYOEUwTUhY?=
 =?utf-8?B?NHZJNzY1cGF3dUdxUFBmbEpHZDFxZnlFWWgrK2x0SkpJenBVL2JNcUhNZHU2?=
 =?utf-8?B?ZzRBNjhrNUxWRWR5S2tIV2orYWhXV0l5Ynl3WXpTaEJxNEdoQXRKeG8vR25E?=
 =?utf-8?B?SGk1RW5tU1RGRW1yWUMzVi9KWGpSd2xQTVgrWFkzbjk3SVZvUHlCcDdmZWpQ?=
 =?utf-8?B?Y25iQ0FibVVhOUNseFo2OXRDWTVYOHV5UjlaZXZKWW9TYlBaa0NvQ2VPeGZX?=
 =?utf-8?B?Z3d1OFVJWitUSTlWYVdmNnBkaE9Na29UZ0JxSW9VanhoclNJeHc2dU4wbDVs?=
 =?utf-8?B?U05weitkRnZRTWZGR0ptRDJGek5ocVFBSWpIdjJMK2swak8xQWExNGJXWlJv?=
 =?utf-8?B?OUV2UC9tc0lDdktnMk9tY2VWWHVvLzVRYWlaZEhxSU9mQkIzR09iTDdGMU1N?=
 =?utf-8?B?ZXYvM1F2RGQ5MHZqWngvOERTb3V0WkV4clVUSkNYT3M2cEQvYzlhcUtSYXhI?=
 =?utf-8?B?MkY0K1VjVFlnYmw3cDcxUTNyczNKbUxhaEF3T0lFdWhqeHFhZ3hPUGJlcFJp?=
 =?utf-8?B?MDcxVWhRN1U2Rkc2Yi91UElLWXpISVlINU93NXFEb3YwdHJpbU15ODArOEw3?=
 =?utf-8?B?THhsc1B4ZWc1dFF3Q2hadGFIUTdzZGlhaUlqcTN1amJZVHFmbjlHZjU2N1Q2?=
 =?utf-8?B?WVRmMTBGQlc3UjNnS1hjY3RidlFNQjdqa1JQZmg3anFkMlEydnpNcFBQMytC?=
 =?utf-8?B?OUJ6RUJJWVk1d2pQZ1dFSGwwR3V5allKYjc0eGFGMzVGL0RvaSs0SmpGeXMy?=
 =?utf-8?B?NmlteVRIbVZnaEFDZHZIYzR2NlpqQ0JqREZ0Zi9paThKODFXRzNHSU5jaDFQ?=
 =?utf-8?B?UWVUc0QrcGYvU3ROLytzUCszMEZmOWJmZ1gxeFRlWXpFcWdoNmZlVUhUTjRZ?=
 =?utf-8?B?ZXFGU3pEalpRMTR3bXdiZEtmTjlaK21zMGF1WklRcUF3eUx1RnJFem90NVdD?=
 =?utf-8?B?WnhidDFORkJRZ1ErTFBMUmhrZm50NEwvdjhIMEY2dWJjQ1N3cFZrQUh5RDds?=
 =?utf-8?B?cUVkdUwwWG5Rc25YU2ZpeEphN3dqN3k4cEJ5Rjgvb3ErVVVJMCtYYkxaa0JI?=
 =?utf-8?B?Qk9jZ3hUOXdjVFdBaWlTNGdWZDZjQ1UrSGQvREd6cFdzdzhNSWIwbWR6dU5J?=
 =?utf-8?B?TVVYRjN3Ull0VXlJTml2eU5oTG95SzhsSG5CRDhlWWFxKzI5Y0lyb1QvdUp1?=
 =?utf-8?B?Y1U1K1JYd0xUN0Z2cTFpM0dPQjdIYTNzd2l3ZFRSSU9WSDM2SUR4R0RBMFg1?=
 =?utf-8?B?T0cvTGFCZld0MExGcXRLdFdlc29IMzhCK3pDaWljRm5HN05UZngrdFc2Z3lO?=
 =?utf-8?B?VWJVZ1BJakFkTStnSjVSdUV0cCtmTHJ3RVhhZ3NxWndrTjcwaDBQVUdwb1N4?=
 =?utf-8?B?eVo0TnRBcGFveDNpVnhndEpMYmoraTUxaXNIakxHQURvdTBiMzZGNG5hOEs5?=
 =?utf-8?B?TlNsd09ucS90dThEaXM5RTN3WFhWeWVoZlRlZzdUZWFrSDlKYkd3bEwzek9u?=
 =?utf-8?B?ZDBXcm1TL2l5Z0Z4bnBFc1pUVkR5ellxaDhrdFhHZExVNXo4cFh6MC9paHBw?=
 =?utf-8?B?cHN0ZVliWVBlbHhhUnVKSFhxZkxBNloyUGVGUjMvcVBvUllwSXNkNGZoUlQ1?=
 =?utf-8?B?aEswNEhzb29tUXdZYkM1alNCcFNKdDd1SE1LL0ZDMWhPdnNqSXFCQTRYUFVU?=
 =?utf-8?B?MWllZXVPaTJYMVdKOXNnRHRYTXNaK21nclhMZzd2Rm50U2dlRVdaTVJ3S2kv?=
 =?utf-8?B?eTdZdjlueXpXakwzZlBNbjlPK1Z1Z0V4ZCtOcGtlZjh5Z1F0eG8rOTBVV01m?=
 =?utf-8?B?aVdxeGNkNEp2MTI1OEhKMUg4VlE2bllDRlU3M01ZcFVsSXluWDh4aGx5VWpT?=
 =?utf-8?B?dDlmOEliRVJYY084UXVZQkI1WVBHUnExWTFHaVl4NWhualRXZnJGdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48771055-5f15-402d-1e63-08debafbe441
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:53:36.2988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlov249MNbgDq1TjXUL4J3/nQ/oK25fAvEICrI+/tu+N20vaGvYZ6Huife4Lt7ZSJgX3KerVZv9Gvyry3RrUpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10401
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

Use dev_remap_addr_name() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/mtu3/mtu3_plat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 26fee141f6e..a35ec47f85f 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -154,7 +154,7 @@ static int get_ssusb_rscs(struct udevice *dev, struct ssusb_mtk *ssusb)
 		return ret;
 	}
 
-	ssusb->ippc_base = devfdt_remap_addr_name(dev, "ippc");
+	ssusb->ippc_base = dev_remap_addr_name(dev, "ippc");
 	if (!ssusb->ippc_base) {
 		dev_err(dev, "error mapping memory for ippc\n");
 		return -ENODEV;
@@ -166,7 +166,7 @@ static int get_ssusb_rscs(struct udevice *dev, struct ssusb_mtk *ssusb)
 		return ret;
 	}
 
-	ssusb->mac_base = devfdt_remap_addr_name(child, "mac");
+	ssusb->mac_base = dev_remap_addr_name(child, "mac");
 	if (!ssusb->mac_base) {
 		dev_err(dev, "error mapping memory for mac\n");
 		return -ENODEV;

-- 
2.51.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE471CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 10:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9697E84936;
	Tue,  2 Jun 2026 12:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ypdhain9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67A638488F; Tue,  2 Jun 2026 12:05:07 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7FA384932
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 12:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIa4D4AXJ39wKTWN54MAfwGROcANtUoBAYM4k5YciEASKf38JwSR8jDMZRPugMvj0z24qQRRvEPSc1EWEcYqCTZXGG1wHriz+ydaXxzFRJZkil15K+Q5LY42EIHFkEtJwSfs/dF3Sv1e5fp3o7qReCiVYoFNQEo+7gtwSoL0sB0nTYK+/ycrzAhJ69TTuQrbu8DqQ5wSqVehEAifl8se8zbrpGEACmOw9IYmeiwnPa+m5e+sdIS4IAo0EGHjIqPENsNydEEH7Q89vv9rymfZBUAhMgtkF4pjQ4qQyy3H14Wz1yWaYAmGYKK136nrGx03jN500YDqDYqex+yChJ4LfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKLqBXO88B4oheThGGyeDlXckESjiFh6NHSLTagO6Wo=;
 b=UOKzObbwwJYuN1DzwkB4WMtdbl4tN3abO4JIrd48LhSwSAyPeAEbvGWpGZsWdmlQqjntPuCnHYgr+x1zXOrjROmNuynDFZgR+PDIGTgxd37iw/puGzhvFXd30onxO8juhhbCihVQj0yFwR/0lyq31wzm/P8IMufsc/AA2fpKiLI/Qz0VxVCn4CTjQn0pZo0WSvpY49UWXCf3YBMCi63cw6y8EBwRRA+uPXz4EeEqI+SVY53V5txF0T/nYpzPf4wvTPb4CKEEFV7BKKm79jhoA9ExHw0KIPqk4Pd+eIvZmZaTHZ5PzMdo8V1X8/x383pRQJCLRSXMlAEyT0hzxHKcgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKLqBXO88B4oheThGGyeDlXckESjiFh6NHSLTagO6Wo=;
 b=Ypdhain9A/Cs2L0pNOnA928HMihCzglOdRsfA5r0G5sMua87HKGn2+24i5nBxrFdZ+pOK4TGA8WUZ1+81p4zsmgGPusIhtNrHUeAGLdlUhP87y0S/fE5SzBSvTuzhxMYW1+33+8yTqZtyl0flAgiZ+CLjC4/rrGrs4AL0uuUGv57CqgxtFcAs5GnPr3o4zO4C84XyxQoRMQLNzgUjDC13IiZdEYwrBsYcRDx6k8hiMHK1HjcUhoYSeoj1PvTKazIwA8qhPsO6FodBV3OForvPNhYd5VPI/3kxiKTzXuqFKUWIvQ4/KIy+IqnRTr54JoUqYBrPnz9+rkXbJdsZDC3dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI1PR04MB7118.eurprd04.prod.outlook.com (2603:10a6:800:127::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 10:04:57 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0071.011; Tue, 2 Jun 2026
 10:04:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 02 Jun 2026 19:21:41 +0800
Subject: [PATCH v2 2/6] usb: musb-new: Use ofnode and dev APIs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-devfdt-usb-v2-2-a587ab36b906@nxp.com>
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
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI1PR04MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d1d6e6-2323-401c-e877-08dec08e66ba
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|7416014|1800799024|38350700014|18002099003|22082099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: Ow7C0kPKGcc7fg0VsY7XMuM4kVIj2vkLXtjDr5+OfzCpKLvmNC02P2iXFxyFTH32zYZtgKpHS4TmPBK+3OklDJQmbMUzqYf2IihwjILftZOSyDuqLASFS+Y1B3aXHssJfRQoxBzhTiE7em2uCkQts2BF2H3VWvqRkUN14rFdNZmkVPgavsMrjk6zpFNrDbqYtkkGkOp79Jqoo3oQfgb78ugbVmurdNMgCVqjb+NsnKR/SLXYLyfjILC4Pj8tzQh+2mabdj7y3bTroxQzFr/Km5lmM0eOJiB2dRgWeJhJE9YSRRTZVL7y3NMQI67OdxGNsCL1/pDwPEvMEpX8orSUN3GdL669XPEbu2eN/G1wtCDEXAU4XmUnAPOneL6L5whx/n66kI+WUHZmHZWvbIFGRsR9hqWm1vMM4BXb4xs3DhHhbRwUBUYWUp1SVNtlzDmcWWJcmrQQgeyfZiVfZuWVNObf6r/V4dNRzo8FRYtvHLqN3uJ6fjnSnCY8HwizBzqspUPEx4jXRhQszS9uOEZtC8DWy/1/Szr87tZFqLNwUnj4v/TootXqCvswOKokkR736i51XW9hJlCGQN6gMZnyI6cq96/P0HDUW+WiDOZ5iOEMO5XpSNlZvjRuNVwC3hHoYw0tYx8/tXitToUE79H9Vpu0BXY6nKwyHwM0VfXkCMQi3ACogl4PEddHNa5lUEQbJVTBc5Fm/oLjW5ZI1qn9MBNuyKcsyqoWdbDf+KGYl9uIZ/wlUj1cgn4xLsGUKQ/5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(7416014)(1800799024)(38350700014)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ykw1QktMaXNFdUFYNW9uY1JmSDAwZGpLZ1JWaXl3Mm82QUNFUllUdWxxRVNt?=
 =?utf-8?B?SSttWDVsdzFZSmdDKzlJMGl6SWxNdGxZWEZLakNacnlBN1JVZmh2ZHB3UHpV?=
 =?utf-8?B?a1R6SDVhMHdmdjBrRitycVhFRitQRmx4UjRib0x1eXVoMlBTaVFvZ2xXa0RR?=
 =?utf-8?B?cmRnTThTUmRxbnlKczU5dTB4ZXlSa2tEVlhMY0graGZTZUtieXZwWTVLTDdO?=
 =?utf-8?B?TURpQWljTG1EcU0xOTIwV29mSGRGK0xyNjZ5RlRvcDFyeGZVS0g4RjJXVlIv?=
 =?utf-8?B?U2Q2bThIZ3dVckp3MXA1a25BUDRPUE4yS3FOZ0Q2emNIa2VLR2lkR1V1bFVv?=
 =?utf-8?B?UlRtTVVCMVJOOFVLVHN1L3g0ZjM2VFU5ZmczUThWY0loaDFaMWZ2WVQ1NFVv?=
 =?utf-8?B?SStSZjc2bjllR1o1bTVnbGc2Tit3dGpXWWJPcElackNzUEh5THFZQStqV055?=
 =?utf-8?B?MVJoL21KdkkzYjRqMC9WV1FoeTlmemVmakJ1SDRHZ1NLczJPVC8yWmk0UGhQ?=
 =?utf-8?B?a2lXVERxVVZlOXpOaEFFa09wMmFUQ1ZFZnVZSi9yc1N4enVCeXhWSkp3b0N4?=
 =?utf-8?B?WHdrT3pNcVJ5emk4VFpFSThQdXpXYzNXVjIwcHcrUG91ekUvZ0VFUmhndSta?=
 =?utf-8?B?TkxmdmNVR1pJRm96Y09QQlppRTBqVlAzZ1pPM2Q3OGJXdlV3ZTdSZklKZW5H?=
 =?utf-8?B?dWpsWm5EMlpUUnJaWkVsUGgvUFZzM0FvQTk1Q2UyM3FWaGV5S2FQYU83bm92?=
 =?utf-8?B?a0pDZVB5Z0ROYjhMWk9oMWxDUkNJdGo2QityL2FzR0JjRlRxbnl0MjJ0cmhS?=
 =?utf-8?B?TDhVdjdoWWVManJ5b0dDNE5FUmJqa3I0TDl3Q0ltQXg0VEFhOWJtMnJIWC96?=
 =?utf-8?B?TXY5WDVPMkZCVlhvcElzdUhsQStySkg5S0Q3bFkvRDFpWTMrUWtnMTVEUmxR?=
 =?utf-8?B?dHR2RGF4OUNRekZxNk1rcmxDNy9RNjMvT1lrMmhlZUp0aTEvS1IwbEVad2t3?=
 =?utf-8?B?dnpFNU1aMi9IQnpSNThMcUV0enpLZFo3R1ZrYjBFUnhmT0lHVlN4aEZqQXZK?=
 =?utf-8?B?TTdEd05RMHk4NVBJNmE5WHhHaEZzYTVxN1gzbDJ6NXdZVUNSRmUxa09DSkRZ?=
 =?utf-8?B?QlBNMzBod1Z3VW8rdVJlOWJObk52WVNGdHFQc2p6Rm5WYnFIT0RENHozWlJl?=
 =?utf-8?B?TFZiWkp5N1R3R2V3V0Y0YU05MTUzRHArQXlscU5lSWI0TGQxc1Zvc0doa2dJ?=
 =?utf-8?B?V2V6Y0hmdGF2dXdYTDUyL2xSUHNWUVByWmE3RHU3WW1QL3lWV2duNTZSZms2?=
 =?utf-8?B?MldiUnVEcnNFVC9wdVljejdxa1pFVjJTMEV0SEQyakNKcEptNUIzTldSMVZ5?=
 =?utf-8?B?amZCOFZKYS9HYnVGZVl6YU15bzRMVnhEa3owbkYvUlV5MGpzVDFuL1NpOEFm?=
 =?utf-8?B?eCs4TEwyUkxIR3JzSk4zTlJoVGRSS0RlQkFvUzhDeU16UEd2Z1o0MGJOTnN4?=
 =?utf-8?B?MzhPdVZMWEg3OWp3ZFI5Y29yMjlwdkdHdVZ2R2lIdkVmUkRmaGtJS0s4Tmhz?=
 =?utf-8?B?dGlBL2l5NFd2eXhoM1VlSDZJbzBCZ3dUUVNwcEVIRjdQay94NlNVTTlvZEQ4?=
 =?utf-8?B?YlRueDg3WXl5NlVUMDF0MmJ1ZUVZRjJUZkxsZW9hdHhYWXRzS2lld0J4OW45?=
 =?utf-8?B?ODdxV3QxSG5FSWhtaGg5SVNHeWlVRFU5YTZ5cTBSRUNSRFZMSjJUZWZxcWhl?=
 =?utf-8?B?eUZrWnRseXFmdy9kSnFITW1wME81Q1h0enl5bzNSSFU2TEdTUHl0RnpDMHlB?=
 =?utf-8?B?MGhOckIyTmxlZTFrKzJsbnF1Q3NZRTVOMFgwRkRrVjZaeGswMDBMV3dQNEtT?=
 =?utf-8?B?MW5xTkJwL3YzSWw0Vm1ORldUZ0RMT3pXMnNVWUVwaXBqMktRZVpIcnFRU3Bu?=
 =?utf-8?B?anI5bXR4L3pzb0dScTRkQ002SE8yTUVxeWFWYWRGdEJMQ0dmdHU1Zk5xWGlH?=
 =?utf-8?B?ZE54L3Q5TUh0cmF1QitxZUoxcVRCQjdRYzRKRFlPU0JMVWVrTDRXMDNYOWNw?=
 =?utf-8?B?UExCYlM0Zlp2UkUwellOeHA1L3lJanNVelY0R3JMQ2hVQlV0bWFBNW9oMFJL?=
 =?utf-8?B?RVNLaWRMWisxODVJMitrcnRhdFdtYzhvOFg0Ui9zNXpSaENFdkpaMDhsbXhD?=
 =?utf-8?B?RlgrMmorR0VuUjR3eDVidzl2aklBcXE3NHN3ZG1HREVLUkgvdUhmaDNPTWdM?=
 =?utf-8?B?WTNkVk93YjZiajdJdURTcERnNk1Yak95dVJmTEpIaGJ5Q0k0bFBMSnFYOG14?=
 =?utf-8?B?ZVJPc2JJUWR1anN0Tk4raFpHajJPNk5sNXFmeHRJajJvUWVSWEp4QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d1d6e6-2323-401c-e877-08dec08e66ba
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 10:04:57.6190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQTD7LiKTjP6rEI+o5EJ0kuMoqrojeL708B/zpWFaUbaRddR0BP/E+S1HU8lAdwo1Jw+5JDGbI6uQMQHGTeuvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7118
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

Convert the TI MUSB driver from legacy FDT interfaces to ofnode and dev
APIs to support both live device tree and flat DT backends.

In ti_musb_get_usb_index(), replace fdt_get_path()/fdt_get_alias()
based string comparison with ofnode_get_aliases_node()/ofnode_equal()
to match USB alias by ofnode identity rather than path strings.

In ti_musb_of_to_plat(), replace devfdt_get_addr_index_ptr() with
dev_read_addr_index_ptr() and add a NULL check on the result. Convert
four fdtdec_get_int() calls reading "mentor,multipoint", "mentor,num-eps",
"mentor,ram-bits", and "mentor,power" properties to dev_read_s32_default().

Remove DECLARE_GLOBAL_DATA_PTR and the asm/global_data.h include as
gd->fdt_blob is no longer referenced.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/musb-new/ti-musb.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index e083cb7d0ff..1c80b78b031 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -10,7 +10,6 @@
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
-#include <asm/global_data.h>
 #include <linux/printk.h>
 #include <linux/usb/otg.h>
 #include <dm/device-internal.h>
@@ -20,8 +19,6 @@
 #include <asm/omap_musb.h>
 #include "musb_uboot.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #if CONFIG_IS_ENABLED(DM_USB)
 /* USB 2.0 PHY Control */
 #define CM_PHY_PWRDN			(1 << 0)
@@ -51,29 +48,25 @@ static void ti_musb_set_phy_power(struct udevice *dev, u8 on)
 
 #if CONFIG_IS_ENABLED(OF_CONTROL)
 
-static int ti_musb_get_usb_index(int node)
+static int ti_musb_get_usb_index(ofnode node)
 {
-	const void *fdt = gd->fdt_blob;
 	int i = 0;
-	char path[64];
-	const char *alias_path;
+	ofnode alias_path;
 	char alias[16];
 
-	fdt_get_path(fdt, node, path, sizeof(path));
-
 	do {
 		snprintf(alias, sizeof(alias), "usb%d", i);
-		alias_path = fdt_get_alias(fdt, alias);
-		if (alias_path == NULL) {
+		alias_path = ofnode_get_aliases_node(alias);
+		if (!ofnode_valid(alias_path)) {
 			debug("USB index not found\n");
 			return -ENOENT;
 		}
 
-		if (!strcmp(path, alias_path))
+		if (ofnode_equal(node, alias_path))
 			return i;
 
 		i++;
-	} while (alias_path);
+	} while (1);
 
 	return -ENOENT;
 }
@@ -81,15 +74,16 @@ static int ti_musb_get_usb_index(int node)
 static int ti_musb_of_to_plat(struct udevice *dev)
 {
 	struct ti_musb_plat *plat = dev_get_plat(dev);
-	const void *fdt = gd->fdt_blob;
-	int node = dev_of_offset(dev);
+	ofnode node = dev_ofnode(dev);
 	ofnode phys_node;
 	ofnode ctrl_mod_node;
 	int usb_index;
 	int ret;
 	struct musb_hdrc_config *musb_config;
 
-	plat->base = devfdt_get_addr_index_ptr(dev, 1);
+	plat->base = dev_read_addr_index_ptr(dev, 1);
+	if (!plat->base)
+		return -EINVAL;
 
 	phys_node = ofnode_get_by_phandle(dev_read_u32_default(dev, "phys", 0));
 	ctrl_mod_node = ofnode_get_by_phandle(ofnode_read_u32_default(phys_node, "ti,ctrl_mod", 0));
@@ -109,7 +103,7 @@ static int ti_musb_of_to_plat(struct udevice *dev)
 	musb_config = malloc(sizeof(struct musb_hdrc_config));
 	memset(musb_config, 0, sizeof(struct musb_hdrc_config));
 
-	ret = fdtdec_get_int(fdt, node, "mentor,multipoint", -1);
+	ret = dev_read_s32_default(dev, "mentor,multipoint", -1);
 	if (ret < 0) {
 		pr_err("MUSB multipoint DT entry missing\n");
 		return -ENOENT;
@@ -119,7 +113,7 @@ static int ti_musb_of_to_plat(struct udevice *dev)
 
 	musb_config->dyn_fifo = 1;
 
-	ret = fdtdec_get_int(fdt, node, "mentor,num-eps", -1);
+	ret = dev_read_s32_default(dev, "mentor,num-eps", -1);
 	if (ret < 0) {
 		pr_err("MUSB num-eps DT entry missing\n");
 		return -ENOENT;
@@ -127,7 +121,7 @@ static int ti_musb_of_to_plat(struct udevice *dev)
 		musb_config->num_eps = ret;
 	}
 
-	ret = fdtdec_get_int(fdt, node, "mentor,ram-bits", -1);
+	ret = dev_read_s32_default(dev, "mentor,ram-bits", -1);
 	if (ret < 0) {
 		pr_err("MUSB ram-bits DT entry missing\n");
 		return -ENOENT;
@@ -137,7 +131,7 @@ static int ti_musb_of_to_plat(struct udevice *dev)
 
 	plat->plat.config = musb_config;
 
-	ret = fdtdec_get_int(fdt, node, "mentor,power", -1);
+	ret = dev_read_s32_default(dev, "mentor,power", -1);
 	if (ret < 0) {
 		pr_err("MUSB mentor,power DT entry missing\n");
 		return -ENOENT;

-- 
2.51.0


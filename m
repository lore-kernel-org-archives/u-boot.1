Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A492CCD98EE
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 07:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5807D848D1;
	Wed, 17 Jun 2026 09:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IQZl7Qhm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CA9284981; Wed, 17 Jun 2026 09:07:14 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55022803F0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 09:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnUfYrdOWK89ZPgWTW1kfIqEyiFLUg9a+r/w3IJGFWv5ntj5snnW40e9Wvwztjm5BWC7PAcK9C1iZj1Z9hoEVhS29lBPearbp222TeMzYrZUG/HuluONDS1QOhWl7K9uHAarBsQF4cwrwEJvrsEbqJ4cWF4CXx63n3eC6HFH2WmCBeW2T0DM9bh4j+zvqxNlZ/QJC965hYn4DuybU+PdJD6VLi412UnEFRJdof+SZGJ3zQRVgiDaQ+k7T9NhyYBScoJY6J25VTbm9FQ/H4tbRsJtvVMoMTcXsGuPJ5/hW47AvaNgqOarj/QB75ehQZhMYCvp7vdU7dJ/nEcVSpAu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuYWieIo/Oz4c9UrPveglWb1Tq+9lMVgXR+sZMekAAE=;
 b=B+ZSorXAWQZejiObBBXqMOOx0hxmvZeAPlvEqldOjS9v7Ic6/Fnkolz+oPEn4mDKC8MA5dHLIgimY858aTxH/4Wd04D6/IILbSMjG+ZwvjlWUtA/y+ieqOXC7s571UyYV2CqNdEnF+rMjeS+Ysgz2YpUllrDa5kC1xCYRJ69aabySeWILMnw5i1eJTqtiW/IMPppHxhFi7EAgGgyvyIiEm1BZtei7Xtk79BoTWY5RBHTjg8yWmQ0CpCV0cnyoyE8uqh4a806F6bmDQX5dHSAvsCF6FT0y/GGsfsWKfrFIqNC0SJseWsRfup6FI5sZ30WBeayOoFvAELexdu+YFVT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuYWieIo/Oz4c9UrPveglWb1Tq+9lMVgXR+sZMekAAE=;
 b=IQZl7QhmE9UZrqPNdOCFP3+iolczhOYEp4cmhYSMotV5g2g9YJceUwGe2xlFfrBcuRcyMq+sRmHtpHwSa+KwKOm45YT/6xWv/DQgkOjjJowqmKpBrrk1ftFG4q71P48bw3WOhATYraY3tsX9cHxArHVpvTKUp4pWK/m3r6gBJQTiBBhlX9k1Y7z+sWOc0DUe/wToWPtu3ANvWPEG0on1XG3HKZ2p5Z4kuGDVK6Ava8z+UXH/OsOj2UYkr89zd0IiN9UBqOgBOgWycN50ZZGa7SCFK+6WLsqrKBP3Q83vzjnC4S6g+U/QJd8VEiOUkCCzKaCkGmFTJ2EdYjRUPs5P3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI0PR04MB10832.eurprd04.prod.outlook.com (2603:10a6:800:267::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 07:07:04 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 07:07:04 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 17 Jun 2026 16:23:08 +0800
Subject: [PATCH 09/11] usb: dwc3: generic: support OTG dual-bind for
 runtime host/device switching
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-tcpci-dwc3-v1-9-b824fe1e9299@nxp.com>
References: <20260617-tcpci-dwc3-v1-0-b824fe1e9299@nxp.com>
In-Reply-To: <20260617-tcpci-dwc3-v1-0-b824fe1e9299@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 Wang Jie <dave.wang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Ye Li <ye.li@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI0PR04MB10832:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b6e980-d206-4938-cde7-08decc3f091c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|19092799006|23010399003|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bO70TC6b7iwUvRDPEGkuYyXGmIgGw3nEzeN747xkp7X9eTXX92XhKfBsP/cHbcnUQcg5axxdo7dv+wVDymlTe8yAX1vAHcxDV/1OOEDXoYKahVHRKhQYDOBXt+9g1uOEtqDplj+0GmltLYKWyqjgHW3WLDy4+soZNAFq93JInb5FkBwZ77E8OO0XBpVEPyL6kQBCTYrLmgiqGtCNw1rv1kSWgKWutP71TY0VAZRa7+wqE02QJMAggZAFhhXmOUmTXUNue/N5ISKfnKi5GhW59erASFgMqYA0oIaCTGqDyumhZwP0J2rA0PvoHRuVQWpjFgcacSqldvn8DcvIoEjI5gryBbNFV1dbx2iPhp1FPiYrS37myb4bpLvRlJsStmYYnZM3ehEHX/oAvYBaTVP5dmVEGCdvCroVBENJDWs6WOvTp/5RR/b0jTJ+f85PtPhMJAGqDynh3rtdf4PfBgMnii5xinBK4r1wZ3m2UkvaWukW5wSUGWHo+WUCMgo664e58jxoz3Y5W3p0Cc6WmvoHfQau+46TA1o80opZRBJWaGUFWKk0cwo1SaV2AQO+RVDapmwMHQQ1iSYdC5WwB0JAOTyDTy7VOQBlkk1rkBlwjowlagTyTvXz9+iO2ZC77SLc1wgfk2ne6dhE3xOYsS/amMX6KO12Q5Wc/8TQHubIiJH5zZCw4b1CRD5HD+NkZ9hQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(19092799006)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXVNYTJROXlTQkJDZHA5dWZwY05PTHU4RnBhT2hjTFdseDBZN01FNStORXU0?=
 =?utf-8?B?NURmYXZuZllabVhETWl5Y2w2UnZSM2RiTWovRFN4UHRveDQrZHdGc2lnVDVl?=
 =?utf-8?B?dGhGNCtlWVJTMDZhc0lUNXVpcGRUeE5nVkJWNkxhMXgwMlFHT0x1VW1DczJp?=
 =?utf-8?B?RXFOTFBqaXV1RzJFdDJHMUlZaWVsOHlabzlVTEh1cjA2MXY3YmVLZ3ZPU2VZ?=
 =?utf-8?B?dGpNeC94dzJmbmxQMC9ObkIxak12MFpjWW02K1pBT0JGelU3WVVvU3VwMzNi?=
 =?utf-8?B?dnY4MWhiQms4UTJRM1l5SnNiSlczUEgyL25WVE9hZVNsb2VwM0lRT1E1bHRn?=
 =?utf-8?B?QlZqVG9QTlFvV3BZcHlhVVJsWUhySDNXdXIreGFmdVJ2Mm40bU8xL2Y5MmJi?=
 =?utf-8?B?aXhQb1NRK0drSitEVlZjSDcvSHd4QkNoQm5NTklnaFoweFpUTGpiRnRmOW56?=
 =?utf-8?B?VTJxOHhyL3FmODZsMkdQbzhnVlh6RjN2SGZac2dSL0IraEtqR3IzOSsxb1F5?=
 =?utf-8?B?dWV1d1VDTDNWN1oxTUlpemVyelQyTW5PT0c4aFhkWkp3VTFIM3FtUTZHUnpX?=
 =?utf-8?B?NFFTWjJnUk56VVAzV1NSY3lOSk4wMmFoK3h5NGcwMFNNN2NQQXVVQnR3ZkVO?=
 =?utf-8?B?eDFzT2VTcTRYSGNaNTVXdWxsU2ZuNkVpMjJvdjRrd2RsSkl5dGd4MDZHN0dP?=
 =?utf-8?B?dXhMU1V4eVcyRmNSNjJZVGcwMktKUHMvTkt4Vm5OWWFkMCtGQmdEZHJhbHMz?=
 =?utf-8?B?eWlJSHVnUlphZzFNbldNQUJ3OEh6WFQ2U2JoeXpNNjkzNzdUZCtFRFRUV1dG?=
 =?utf-8?B?NVF0MTRBMjlKWVFXd21URVVCQXZiNHVPTXY1dUtjRmlDajJ2cWZpUldWRk1L?=
 =?utf-8?B?eHpRTDUrcHZ5Rlo3b2EwUHRGald1aXhQWVFoNEtiYVpwTzlNdWRVQk84TDla?=
 =?utf-8?B?ZjJvN3lZUVVYWjRqR2M0T3Uyc001L29hQm9uWmgwdjNDSnFtQ1FvMDJqL3c1?=
 =?utf-8?B?NWpjL3JZdXJjS050Tmhma2cxQVJXYW1kendEQUFGSVh0dGdVb3FQbjVGaC9t?=
 =?utf-8?B?NzRqSXg0VTRCRldqb3ZNSTI4VjR2RGtyMkVKN3hQRGZ1dm4wN1MyVEdLWHNn?=
 =?utf-8?B?aCtKamtkT2d6Z0x5eEJvc0hlRFBkaFB3REpEZ3JKMDdoZFdHbWNUWFdETFFZ?=
 =?utf-8?B?UUU5R1dFWkZCTHJoanVXcVY4cWZMZzRMdENMN3FtWCttZjZjaTVCMW8walJk?=
 =?utf-8?B?QzhCZ3pUbURmZWdzMW1NbmNQRFJKSWVBK0FYZ2RQTVF2YVNCeHp0ZERWN3JN?=
 =?utf-8?B?d1pIbjJFWDZZSm5UL2d0cUxQbkJHN0dwaG5RSDhmZkhvd2RWV2d2NjJpNytr?=
 =?utf-8?B?b043cTl4bDJ2b1BLeldpYTNQRjZTQlQrZlBJdWFOZ0V0NUU4ZDd3WHo0MHBY?=
 =?utf-8?B?ZUV6dTVKUlRkcjB1dHBjdGhiQUFpZFpSYitjeVcwdk1aZ3FUbWJCckovUTdj?=
 =?utf-8?B?OWk5Mjd3ZStjcHlKNnplS0ZRRmFVZ01qWDZxUDFiY25lMU1PMUxjU3BSb0RT?=
 =?utf-8?B?c2F1QmV5TnlEaE5OZGFFOXp1cnJ4cFlhN2NpMEYvUDdaaWlDajBUU0dmRS9y?=
 =?utf-8?B?aFQ4NmNoTElUNWJ3Y0QzMUNqQk5ad0h0dmZiVGwrRVFqZDd3Ti85S1czdmVu?=
 =?utf-8?B?MUo5bko3R3pkVkhvby9xaGNiVjk1NTdZZHIxKyszeXlKcUh1VG5rZXdxajg3?=
 =?utf-8?B?Qk5xK3E3dDRnbXQ0ZDZERWZyeitZYmZIRWExY2RvV2VKVzlzbVdIanRkencz?=
 =?utf-8?B?bEprOFhrSklFMlVsWThxSThuZldkTXpHR2F4aHJrd1VxUWgvVW9XNjU1RzBn?=
 =?utf-8?B?Nmp4dU54dHpVMjBrNFhtelFRdUZJTTZYRWJFeEZndU5sRmt3R2RWaTR2ZFA2?=
 =?utf-8?B?RlNsOE0xTmZsVnB5bVlnS2dSSEpSTFY3eFVGZXdxRGFlcm9QNGl6UXlFK1lt?=
 =?utf-8?B?YktQaUtENWJzU1ZEU0ljcW5lR2FFd09TUnlFVUFzUkVjeG9lZ0lJeElpdFU1?=
 =?utf-8?B?U1dQWlN3TENnVEh6MWtzU1lXOFNmVXFyT1czYmt3N0xJOXkxOVpzNEdxbkVo?=
 =?utf-8?B?eGh2WGlZWVRIYWlRTkw5ZnFOVXVNekRReTBwVmsvKzBzMnEvYkJKY3RZdEpQ?=
 =?utf-8?B?akt6WkVZcTlXTTN2b0RPb0VQV2F0SzF3WTJvNjR5TW5qRW1vcGxFUTFKMEJm?=
 =?utf-8?B?Z2ppM2ZidVgxSk1CQm5aNFBiWjMyYVRGS3BxQUpSNFpqcWI5dWpWcjNmMkxX?=
 =?utf-8?B?aGpWM29DcFlWNFNsTk15VHBjV240YkUwc09USTUwSjd5UnV6ZTNNNGlQSldC?=
 =?utf-8?Q?rg9Gddhv7cc2eoXbUp3KjNAofFrev4X3a3hZn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b6e980-d206-4938-cde7-08decc3f091c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 07:07:04.2560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muBWgRmTbhydU6mX0zJI6Uuc+5y/2HAJ3RnBZYnG88t08xizHMbqPh+WmDpso8TVLUAuwfTDwEO2LyIOBnB2QiUDL61PK6wfANXEE7O6LguzitzKLPar6Tny8mVzx+ox
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10832
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

When dr_mode is "otg", bind both dwc3-generic-host and
dwc3-generic-peripheral children to the same DT node. This allows
runtime mode switching: "usb start" probes the host child while
"ums" or "fastboot" probes the peripheral child.

Add dwc3_otg_deactivate_sibling() which is called at the top of both
host and peripheral probe. It removes the active sibling via
device_remove() so the DWC3 core can be re-initialized in the new
mode (PHY teardown, GCTL.PRTCAPDIR flip, board_usb_cleanup/init).

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/dwc3/dwc3-generic.c | 61 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 2c6f8e6d8ba..7fcb201d5f0 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -8,6 +8,7 @@
  */
 
 #include <dm.h>
+#include <dm/device-internal.h>
 #include <reset.h>
 #include <usb.h>
 #include <asm/gpio.h>
@@ -194,11 +195,33 @@ static int dwc3_generic_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
+/*
+ * When OTG mode is used, both host and peripheral children are bound to
+ * the same DWC3 node.  Only one can be active at a time.  Before probing
+ * one child, remove the other if it is currently active so that the DWC3
+ * core can be re-initialized in the new mode.
+ */
+static void dwc3_otg_deactivate_sibling(struct udevice *dev)
+{
+	struct udevice *parent = dev->parent;
+	struct udevice *child;
+
+	device_foreach_child(child, parent) {
+		if (child != dev && device_active(child)) {
+			debug("%s: deactivating sibling %s\n",
+			      dev->name, child->name);
+			device_remove(child, DM_REMOVE_NORMAL);
+		}
+	}
+}
+
 #if CONFIG_IS_ENABLED(DM_USB_GADGET)
 static int dwc3_generic_peripheral_probe(struct udevice *dev)
 {
 	struct dwc3_generic_priv *priv = dev_get_priv(dev);
 
+	dwc3_otg_deactivate_sibling(dev);
+
 	return dwc3_generic_probe(dev, priv, USB_DR_MODE_PERIPHERAL);
 }
 
@@ -243,6 +266,8 @@ static int dwc3_generic_host_probe(struct udevice *dev)
 	struct dwc3_generic_host_priv *priv = dev_get_priv(dev);
 	int rc;
 
+	dwc3_otg_deactivate_sibling(dev);
+
 	rc = dwc3_generic_probe(dev, &priv->gen_priv, USB_DR_MODE_HOST);
 	if (rc)
 		return rc;
@@ -550,9 +575,41 @@ static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
 	if (dr_mode == USB_DR_MODE_UNKNOWN)
 		dr_mode = USB_DR_MODE_OTG;
 
+	/*
+	 * For OTG mode, bind both host and peripheral children so that
+	 * runtime mode switching is possible via usb start / ums / fastboot.
+	 * Only the one that gets probed first will actually initialize;
+	 * the other stays bound but inactive until needed.
+	 */
+	if (dr_mode == USB_DR_MODE_OTG) {
+		if (CONFIG_IS_ENABLED(USB_HOST)) {
+			ret = device_bind_driver_to_node(parent, "dwc3-generic-host",
+							 name, node, &dev);
+			if (ret) {
+				debug("%s: failed to bind host: %d\n",
+				      __func__, ret);
+				return ret;
+			}
+			debug("%s: OTG: bound host child\n", __func__);
+		}
+
+		if (CONFIG_IS_ENABLED(DM_USB_GADGET)) {
+			ret = device_bind_driver_to_node(parent, "dwc3-generic-peripheral",
+							 name, node, &dev);
+			if (ret) {
+				debug("%s: failed to bind peripheral: %d\n",
+				      __func__, ret);
+				return ret;
+			}
+			debug("%s: OTG: bound peripheral child\n", __func__);
+		}
+
+		return 0;
+	}
+
 	if (CONFIG_IS_ENABLED(DM_USB_GADGET) &&
-	    (dr_mode == USB_DR_MODE_PERIPHERAL || dr_mode == USB_DR_MODE_OTG)) {
-		debug("%s: dr_mode: OTG or Peripheral\n", __func__);
+	    dr_mode == USB_DR_MODE_PERIPHERAL) {
+		debug("%s: dr_mode: Peripheral\n", __func__);
 		driver = "dwc3-generic-peripheral";
 	} else if (CONFIG_IS_ENABLED(USB_HOST) && dr_mode == USB_DR_MODE_HOST) {
 		debug("%s: dr_mode: HOST\n", __func__);

-- 
2.51.0


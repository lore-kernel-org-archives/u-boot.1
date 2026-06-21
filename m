Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EBBCDB466
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 00:50:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E538F849EB;
	Sun, 21 Jun 2026 02:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="J5KB9wLi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58C90849F3; Sun, 21 Jun 2026 02:50:35 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ACD883FEE
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 02:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3ypY7e/ibcKInbvVhDEVzR49WRBh+83GJU9Z7AJVeYXwcO9no1KB2+eFvibTo0KUrCG9vjlrWD6LltZemmdZhTcqUPKzjzkrQi50gXwXnuRMfndNkrVzNHXQK/YwwLPglIjtXH7imoxd4vo98Lcr0VApfyzE7rYL1VxlmBxrsm8wSxnyzCnhwKXklhfsvH1X6gfj3CRzAPpcC6ZoKzDFPPgmkITmQu6sUA6jQ4huFcsp3/80Ujws1i72rk4eENsWoEph7Q2iL+3xZo4HsWvIeYM87Qz4mkImqYSZZIULUe4xnqy8w1cfYr0LMl7eEwJWVl3Hij0eT5VkMrxPYXoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuYWieIo/Oz4c9UrPveglWb1Tq+9lMVgXR+sZMekAAE=;
 b=HeZcrjT872cZeHMvZ/eQ/EGg+1MT5rxzFwqDg0sZ3cAsYX6wUQU6o4ugVQA5frJF5lbP6gq8t4I41E78gdHq08leOSpSSksIJwGh9e4PpCANniyF1OSpbS9HgZFkkGPRDV4Wuwk90okOhl0kKwzuFJcOjpuR5si0i9RDCg7zcBCKEEeyBPOpuz4E0VvYjYQUPAaSjv9FyvECIzMimhpftUxb8IXsqSaQtOMNoUoU0+52p5G/FAbyRstWrVCKXVksoitxI48+ho2Zh270a1NexkSdOTfyKw0yUp4ExIG56burO6QGtaymbhKtG+kulF1fJfpNjXTmc8Tr+3WqEru5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuYWieIo/Oz4c9UrPveglWb1Tq+9lMVgXR+sZMekAAE=;
 b=J5KB9wLiSyFgtV+c1nuMQAwGmocsmkqaXnMbsOm2MBw6S1V/u/DPUxuSDGAItMnlM0GpACRA9Gu8GbZDeK8STEWdvm2WoEwHb0OFFsA8j/TUN/sgeZtXI9h2mexxxF8chd4TkUxLM6mCKb5jcM2JUGOdzNJNq5ER34+05w/Av38b+U6edp6F2PQJULV1cm0iGacDs0dUVFw+D/8eMqo00KLnkHUHfRYtT88FK5EyPPEdidCxH4gFZu3iEp+6UJ8J13qkgn6iI/tRvYcm5x4XgDQfvfAriuVnEMO+J7ONfbsCqg2VNNYJ1NDhh6njoBghkiYBVcFw63k9kMLw82fm2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PR3PR04MB7305.eurprd04.prod.outlook.com (2603:10a6:102:83::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sun, 21 Jun
 2026 00:50:31 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Sun, 21 Jun 2026
 00:50:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 21 Jun 2026 10:06:44 +0800
Subject: [PATCH v2 08/10] usb: dwc3: generic: support OTG dual-bind for
 runtime host/device switching
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-tcpci-dwc3-v2-8-990ecacc111c@nxp.com>
References: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
In-Reply-To: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
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
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PR3PR04MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c26e99-99cc-4a1e-d397-08decf2f1887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|19092799006|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: FrPVaMwoOXair4nOI/6DYNl2oT9VcGtTbI6cmXqIUNpD2+5IMW6EdkWlv+E/puvr7AgESVBzKDD/HnQk8/HcQ3Zs0Vm4bzd+Ic2MDVAIjVv+urY9gLGio6lFm/7sUQCWfxPOiJ4UFLGfRqbhLnK+sz8Oy/Lj/dNuUavW1Nem+ssk+ct2zLgsWjY8JU9NioJVHElDXIkM21V7g6A9glWFGicvB1Gf4SujTzOpTm5tr+HES+0BlzrCHKoHAzlj/6Ek0ZSa7+Of4lQ7FakVjuqqLKZE6Ix7dBnlR0TibJR1piYdF7PTUXuUy9Lh5AMv5CZQ/20PAeUrjDqMsrbld2NjoIxK8EzZYX8QA5d7lqHPw0FYUEjad17nJki0ui0vJG53o7h2KUmLWxQh+QELHUCX/0r4xbgMkIH2vNH7rKiREu3i+rMV8NS9zOJVT0sMynr4eZo5a5D5uIDNNWO9j6Fe1MTsa1wraeo32x+tG7/QATkSpvwAJ8PD+vKif/+0XPBNGatiXU1FEPMVwqqUe6nxrAReVWhdnmoTtYEgCt2Dn6QPCN1kBp22sZnFRVZaquTn0t8cEJzjtkHop9IqgoQPB9fOuZAnNWL3IdC/k6puy2cb/BqUauzAKkRAc9oV12HS0uTyhAc/7zU3eozE7jNQ+gBAkdVHq1zz9z4Vck5HFic=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDcrMlZHeXdMZnppQTFpVjhGWlMxbnlxcjg2akNrR3EyaDM1WVJlK3lSOUhi?=
 =?utf-8?B?a2VYUUVHcjNkejdURDJSMnBEMVZqUGtyTm95dllUYjZORFRWNE5kOEhvazlB?=
 =?utf-8?B?LzNpRjJGWHpWSWowbForcWFlOHJCd0lFbFVnbFUxVEVxZFZLeGZ0RTJMMXpk?=
 =?utf-8?B?ZVhjV2RQL2oyMkV5Nm5ta3E4ek8yaUJCcjk3RkcyWHU1alJCUHIwQnJpS0pL?=
 =?utf-8?B?UlgwK0dFaVpFRkY0SFhiVmZzNGp4cmJYOWdlR2tVYThReXpSZG5IL1pzcENl?=
 =?utf-8?B?TENkblZXclZjNFJIZCtlaGtOemxiWTVWNnJ0Nk9XTHRLQmovcFd4OXRSL09Q?=
 =?utf-8?B?VGVKSGo1SDB3eW43ZTQ2TWx4UnZ0d1VUVkozd1Rva1RZRDdMT2pRdHlLODJs?=
 =?utf-8?B?ZjVNajY2QmZ1NnZHT2VxOWdKeFZVK2FOVWdCbWh3aXd5TWt4WWVjQkx6ZzBN?=
 =?utf-8?B?N0lJK0FMOUU4bUpma05SRkhoSUxhUHRsampGWm0zWWNMQjZxY1NmamZsSTFm?=
 =?utf-8?B?QUxIZFBWYjRtbVpxZ3RJcmk4MU5HaGpBUHBaSmpDZ3ZCWXdSN3c3NThmWlRy?=
 =?utf-8?B?YXM0ZzNTRnRNRzVpWlBNZ1NkNnNYYUtDeU5KbVQ3NENTdW1UMmU4SGlUUUI3?=
 =?utf-8?B?RWdxbGNjREFFM3pmSlZWTHR5YW5wYjBrcDdiaVBrcVdiVERTVTJWOVZrd29E?=
 =?utf-8?B?b2V2ZlBKYnJZTCt3c1o2UUdVZGxSNkQyR00wMXZVQ1F4Rmt6QWViaXhBYXQ4?=
 =?utf-8?B?cWt3UVNRWGlydWsyeGFZWHJnaUtqY0JseDgxTGZZVGFXSVlhdmtXY3ZUcjJI?=
 =?utf-8?B?MUJqUXV4MFcyS0lnd2w5S00xd0pvVzVFRmxROHhsUStyTTBXZkxWRGtqZ0xG?=
 =?utf-8?B?OFV6OHQ4QnRvODFZU1p1ak1VWlZzOGZuY3UzR2lEa3lUZS9PYkk5bHZsNGlp?=
 =?utf-8?B?cjNUTHNZNkxnRGVhVGp0ZmVhK3lNUTJxbHlJdkxvUzNmcW9tNkUxa3JPK1h6?=
 =?utf-8?B?RlpMa1RHaGZsQytBQ21QQWdRdzRqTzhna05TL1pObFVuQTFMK29UbzRXOWNN?=
 =?utf-8?B?MzZ5OTJ3OGdpeXdSS3F3Q2Q3WHFhRWFNZkVZY3c5ZHZrVitsRFAybWl3bnkz?=
 =?utf-8?B?dzdRaWRhOGdiRVBjb2FrVzhFRHd5UGlwa1Q5NnpveXBDZjgrOE5GTU9oOE1W?=
 =?utf-8?B?cTg1cFY3ajhGV2FVU1hUelAyaHNucXBVMGJ5UHZLMi9GQUhHNVc4UjJ6MlBF?=
 =?utf-8?B?anlpOWxESzhRdm8zc3FLT09URjJtcFZiVGhURzgxNzd0SnV3Z3UyNU13YkVs?=
 =?utf-8?B?VllvYVNUbHNhUTZ2ay8wUFBESTJzck91NWZUNDRjaUtpY2traG5yUzM5Umpl?=
 =?utf-8?B?aHRIaE9vTWI2WUNiRVczZ1NxMFBmRkMvQ2ZVbFI3RlI4VDlnajY4aVViSEc1?=
 =?utf-8?B?VUQybDhqOTE4cEU0ckYrUGRybndBNCtwNDZyTFVZWmNpeUgvZ2FKdVZPWjFO?=
 =?utf-8?B?TVgrR3lXUjVsMlYvd1lnb05raVRFcDh0b0hteFN6YmdkaFJhN09WTXpLOFRR?=
 =?utf-8?B?WWhKdGpXZVZRUFlnbHk1aEMrWmVSK1RjYWNpTmFIdndpTFRRNmN2aG4xbXRE?=
 =?utf-8?B?L0lBN2VlNVhUdFZCL2RPeDh6U2lJZngwek1VTjlLRFQxRjAwcC91cVBvUjZR?=
 =?utf-8?B?K3g1ZEhFOGcwQVdJaDYrVW9ZdUZraTlYQUhJVmF0TkV1U29vYVoxdElENG94?=
 =?utf-8?B?U2k3VDExMDdKMmZFL29ad1RDMnFla2Zqc1h2aXZXekRFN0NSS2dzOEtZNGxF?=
 =?utf-8?B?MWxBeVRxTzV6dVhRSzZqelN0ejQ4c283aWRiK1lndURXZXZPTWlWWjB1LzhZ?=
 =?utf-8?B?UzUvaklVbG5TSlRYZ0hIOVlHbjlrbmlKamc2cDRjN2FUV3J3WjAxbCtXRzVx?=
 =?utf-8?B?ZFYxc0RLNklRNXdYMEVvQTl5YWhxQ1E4cjJ3Sk1IWG12OElhdUFmeFhTVVZJ?=
 =?utf-8?B?ZnFObE5kK3MxdlpKVUh3dTVaejlYNzdTUXM5R2hjSWk2aG5odVI1UlM3R0lC?=
 =?utf-8?B?QUJZTUEvQkk3b0VEbnlDQjBmU004UnVHck9lUjRJYkYyOFFJTmY3ZVplMW5F?=
 =?utf-8?B?YnB4VSs0dXcxK2ZDbU0yNGVHajVkQTlrbGR5aG1pdUFJeFdTY05CbkNJUE1R?=
 =?utf-8?B?eEs1UEJPMTZ2Y0NHY0ZPanJTMU5ZY0dwNWtQd2o1Y0U4NXRBVXkvY2l2bFZR?=
 =?utf-8?B?MzdobGFPaWkzVFlySnYxOWdtb0NBejVlWjErSk9iVGliZlc2VVkwZWtPQzhh?=
 =?utf-8?B?MjQ1Wjg1aG4rUGR0NEZMN2wyZ1oyL0kzYlRTaHNqZDhBYytDbFlqRDBXWGd4?=
 =?utf-8?Q?7V9WNggem/H79SHCpCaZSkckLvL3pTBtmRYZP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c26e99-99cc-4a1e-d397-08decf2f1887
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 00:50:31.6575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d48MiKuiFq8p2slHk7v8AagGtrcCU/rNEZX4EmIpyjq9/5r311MHo9kl8tv5Tbz732eWKuCCOYsXsHdSNHIhg/7hOld+KF/m4ik3v7sisqm0h1BdwLtd8scsZsf5wPli
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7305
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FA5CD5BB4
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 07:53:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C22183FF5;
	Tue, 26 May 2026 09:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nZZXMTOc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5828846DE; Tue, 26 May 2026 09:53:34 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4998803C6
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOUK0SSfRbrSEYy98P8kaPJ+bdHg/cB4vEgpBUiOdKzeAUmV8992h9uLtKiOZskqwfzt+bz3yXyz5i/3Eq5nbg5YmGPBeF0d7kW5wI7xd4kgoTlr0LzJhlkyDtzaV671oDz7Fka25GK1DB/7dSeT7kT4am6TgoArtH3Ltg4+8Y0tdteF+wT3UKcqV10P+PRMiE6lHylvYSOig6Fkdk0/SbpKmO1mTyonQBdRP5t1S8GvhLs8GkE5y5ZKSi1G6rZD8yYI3+WG1KdmVlypRB4QuOSyvS/t9GTCg9Iy4dAr+VT1N7ksrnUhoyDQ2T4vV8Hb0cvFVoazhLXJoLXoL8chMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQmLuRdMo1kE9kbw6SzqLX1pjpTE1lpACzmOyAoTH6k=;
 b=aN3fGQwjQQgN7aQ5ZmgYZmxi7Ce3WoLvgY70dkIbnjvYUZs3036dgySCvzWkO+9x+kUQBZY648BCQ5mMK8u0ey9q2pgO3luAeuag4azsgar7FZdCJvteVATkM9ji0pa9NhG+Nj2KErsMtcEO5sepEFLhX2CzwBuaaQK9dMHGN3XutCoQA92zWq/YElLfG96If3AtA8guW+RCMC5ZCm3LqTSgh88WNZpmrsZaXXnK9jM0F1dNqAh1soVQ8+6auiFpAuzaRLGfk2jI7gZjbc3XWU9B88XrraLGa2bSqtBJ/yLYdLCTO2wkjskj7uR/E8m9CrDOrTxVp8tnRJbFPmPoLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQmLuRdMo1kE9kbw6SzqLX1pjpTE1lpACzmOyAoTH6k=;
 b=nZZXMTOcHBxxWeAKu1nvF0UzIkz8hhzNKF5Iv6C3aVnZvSlYkthCn6xwRND8qENltE4qLPpcwflm13dD5Cj9TDn3+buHwpP2HbItqdjwejaKhxFzOecgm8Q4AFC9/+wrbHqusPZ3irTkfuo7V7DqH8LebXhzLzTftCKOXKiNqR5bMrfgxZGpBDkNjGo0fRbTmY37h8r+RL1j8JHJqyn6BErPSivFT62/4XsX6NjeEi5yhmGbE3tR532InpOiZ9/k03wCOIZ3eUMQMTNxDalHbmHpSQi0x4xp5ohBt9Jq0kwGu3Xf0qZcvNr0o+xgoswQnYqXuaT0SxlDZ/ko+YDN6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 07:53:27 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 07:53:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 26 May 2026 17:09:59 +0800
Subject: [PATCH 3/6] usb: musb-new: Update phandle handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-devfdt-usb-v1-3-a4e22b23bfae@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: bcb575b6-0943-4f18-3b95-08debafbdebe
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|11063799006|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: /swFpl4R3Bapk9tWBtxLgi5BGUw3fp/yD5F0sJ83wFWhiYd4zkUKrj3fscMXBgc4HIf2KfqQnkZUNkybYCYmTOtMMiCzKYkJ+aQKm4mu7EwQZAUQr58vrZAQOXhgZ+pK8a3bMf/+g2+/DbfAeEtWEPROtY4jjKIL5W9Gd1MO+UTLuoj+WcthO0X9NEmBH6ei7EZBNxj9mTBygLe5HFHPVMH9YouKJtgfYtbAujafukl65MYaZOwnQS/ibV2OMHmWDfXEeAne30jN0l3VWHen7VW/nTpmw675rVKbyOV2QKmwqJf9meRUjk8PMa2bAB78yHMf2zD7RViF1kSF0qR2u7eo+oUOSwZpc2EdcdaU2BIWkYqaje0YjGPbLYhFgk73hkoG9I0nBYQBTH1aCLWo8ZWNemKSlWX6fM/LJhG1UFZERkJUI96yQs32gBNFwzbLyvSEAPAGNhh2VCfezGGqxAib1Nknw0UPDXz0YgsJ6XcB4mpSNa7RlHGO0Nl+VRt5P4ZroFr/l+tah41RNTTphM/aAyaxM+W6hbBkvxltSYX8FclL/dG8xKnXj7kyuqA4+y1KrAUfzlAtany74ceVoaKrxDWMGQejIR8iXMzZoD9oYLOBgH67f695pWA3S+B/aNUXiXpkPqcxXeONDD+2W0BWl+bStWkrjDnF1PYz+UJErk0w7jhJ+cBjXZQ+fpP19ntBeeoRkjJkfG+2lAg5Ihrtlx6k+34k4KYiv4NCc2WaYrdojtFRdxP1hUNayfQe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(11063799006)(18002099003)(22082099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alE5OVFRNFdLd0RRK0plU1BXVDVHLzNVbkEyN3dkdWVOTEdSMzlWemYxRHhY?=
 =?utf-8?B?RkwyMGJ2Qnd2M3pUVEJLOG9ycHMrNnlIdTR3NzNyekhIaU1rNXgvRWNTMjRw?=
 =?utf-8?B?ZHQ5Q3NUSXlZNTVOOEZIMkMzL2ZWK2RaaER0aThSektBSmNTNDdveExSUXlu?=
 =?utf-8?B?Wi9xaGU3bmk3b3MyK3krU0k2NlpQMkhycE9KU1FsNXdBU1RQYTg2Z2xDaXBt?=
 =?utf-8?B?QnVYcDhwQ3h3UU84UnlXc0M2ditVek8ycFV6cng2OWs0TTJDMDRZNVBwS0VM?=
 =?utf-8?B?WEc2OWhseGFZYjViZnJwS2x2SGlEUzRaSGpjRlUwejRleTRuYTZubVR3clpT?=
 =?utf-8?B?Qk0zbUpDaW0zVWVTYk9nRk9xNmJGcC9FSTd6MFNDQXVKNjBHYXhuNHVkR3pw?=
 =?utf-8?B?Tk8vUlNkYVhLTEFQSjB3UmJ6bVlVRzN5L2JIRG9ZL0t0SCt6S0R5RHpDRU43?=
 =?utf-8?B?UXBmd2hjSFFlYmJ6WjRFenEwVGlCcDN5U044S0M5eUhFYVBkSFQ1ZHFBODhk?=
 =?utf-8?B?Yno3QkQ1RFhxaGI3RllSRlRGWUhKMW9NRGpObExWaFNha1JCVnFvT093MHpG?=
 =?utf-8?B?SjVBZlRwZHVIc1FPamYrdzdlKzY5ejc3TzZOVWFkd2JKZzhrSWtIc2JmZDFJ?=
 =?utf-8?B?blYzbXpnbzI2cVJudGJMdXY4a1AyQU1hNTAvbTZNRWpmODhZZVR3TVZQK2da?=
 =?utf-8?B?QTl1c1BuR3JJUlkvcFZzKzFuclp0cHozSG5ueTJzY0lxS0wzbytrQzdKaW11?=
 =?utf-8?B?bHNJU3A4TnBDbzdiWXVXVmM0RmJlenVrSWUzaFRJSEpBUFZlcFNWakhKS2c1?=
 =?utf-8?B?YmRLV1R5bEdRcm90RDlhcDFQK1RGMUx5SDUrdlYzWFYzR2J6Y2JjeVFMNGNB?=
 =?utf-8?B?Q2tRV0M0UldzbDhZVEZiM1NmWDcrelA0T2l5TTdvWFR3dVh2OXNaZWtxemxo?=
 =?utf-8?B?dWJVeFhocU5KeUFMaEVmNG0yM3JvZ1o1NVBwTXA3OVJJd3I3NVhoY0ZEZVNt?=
 =?utf-8?B?ZEg3ZjFYOUYvbUZFR2pxdjdqa0laN0t5a2Q5N2pWOHhDL0ZkUzZzMFZHenNU?=
 =?utf-8?B?Z0xFRmRBVzBTa1pCekpBSjlyRllyNTVFVnZ5aHh2ZldWaFlDWnFtL0xuVlVU?=
 =?utf-8?B?bFBrR0tBdWR5b0wrRG51M056TmxhZ3ptdmhEV2dtLy9OdzJqMTh2SHE5bTZJ?=
 =?utf-8?B?WmR6c25KWjBjOVRpTVFpZWFNTUhuYkdSc09GOHM3WXhFcXphaEJYQ3h4OTdn?=
 =?utf-8?B?NUtlNTlzVVFDV3IvTkdrV1RoMUd6R25zZFZrcXlNRmoxSVpSSFViL2tmZ1hC?=
 =?utf-8?B?VHhKZ1prOC9YOFRQWGtnaFdaaUgrK0prblo0Y3gzcUhoUzJ1U1NSaDNLd1NQ?=
 =?utf-8?B?a3Z0Q0pDMTJRUFF6dmwzR1lQOXV3dXhkU0NIOXJRcnUrQmVNU1hIQzN5Mk5V?=
 =?utf-8?B?SDZKUjgwTmlnMkJXWHkyQlRybTZkeEl4V1ZqK1l2U2VwaDlmbGNhQUxDQnAv?=
 =?utf-8?B?QzVPQlErb1ZXWVA3M2lVV1pRbis3bDBGUTFFZTZONm9uOUtwTmhDS1BqaWti?=
 =?utf-8?B?empTd3hjUjZad05Ja3RTd2dJSytIRW1FS2JLV0NDSDFucjMrV0s0ZVFxVXhj?=
 =?utf-8?B?d2ZORXJuSlcxRHdJcUlWaFpnd1MzblB0ZzdCUnl0RlJPM211YTc3TC81T0hN?=
 =?utf-8?B?dHQxc1hZek56SjJ1Y3hlenc0OE1qZC9XbFl5QkZhMXhvZ2xEcUN0emhYMUZo?=
 =?utf-8?B?UTczUk90Z05MMnRpc2hZVUpORzZtZ0FRVDF0Q0hpb051U2tmeUpYcktsMlA0?=
 =?utf-8?B?RzhlU1pnZ29QVmZrQ00vUFcrWTAwSVEyRkNoaGRyL3BWU1I0RGhYZFBnM3A0?=
 =?utf-8?B?Nlpia05IbW9vWnl3MVhoVDJCbkZLbDE4dEQrdHFRdzBnaFl6dHhqRzhHcnBG?=
 =?utf-8?B?ZzZ2NUFZek00SFpraEdnU2lIcnVnN2lzM0ZLK1JuT1FKa0NSUldzZzJaMnVz?=
 =?utf-8?B?cW50VFNxdzR1WFZGb0wybHVCVkYvYkhZVkNvMVFyRVF1a3RwenQ5K1hNVDdk?=
 =?utf-8?B?TmVlTW9GKzB0Smt4c2RPT2hyb1ZjV1ROa1ZOemVpQ1pFVU5NVUs4bkZGZTN4?=
 =?utf-8?B?aVl4QTk3d3prY3NSYzA1OFF0eUkvVHYzOXVJRnJ4dkZlTE5XMUVNRi9jejRh?=
 =?utf-8?B?eEFHbjIxUHRPdGxCR24xZ0FPRS9HS2V4WUFwWTZ0ZGUzWm1vMjJCQS9XdmI2?=
 =?utf-8?B?ckFUSldpY2IvdllnYUcyQjIxQjZIZlZuaTFWZ2tWV1FFS0s3OGNBMElGSVZY?=
 =?utf-8?B?Yjc3Sk9icTJvWFZXTldLVzhHbkFqZzFjUFpJVnhXWEFhUkptUEJKZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb575b6-0943-4f18-3b95-08debafbdebe
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:53:27.0636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LaILATvN2RyPX+oPSeghEUL41G7rxCf6NM0w3/96zFy2prGrRp6PSqk9Vt+lfkQvORxsR2EH8dS0rX27WwVOMA==
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

Switch to ofnode_parse_phandle() and add proper ofnode_valid() checks when
resolving "phys" and "ti,ctrl_mod" references to avoid operating on invalid
nodes.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/musb-new/ti-musb.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index 3dd6e3eb718..75568f54dce 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -88,8 +88,14 @@ static int ti_musb_of_to_plat(struct udevice *dev)
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


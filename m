Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C7BC3DA45
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 05:25:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B4AD87B30;
	Fri, 12 Jul 2024 07:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="wf05xAzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E0B988758; Fri, 12 Jul 2024 07:25:27 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20719.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::719])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FA3B88415
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 07:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKD6J9trjlOTDl+VL0DcUPnuybnNxiZXUtPop9gBIWuUYkaF6OG917sV4K7c41Anvc+5KJHQlc6wCq+768Zykdfk4lMIHu/REVhV8wq7maRsQXuPw02fSzQR4Rd9n1Zxb+W3OYrZjCywYQnKKelXgmCqyD2PFlcg4o4QDE4NTD/WiUqFQQUaxtSCVXLlDZl46VYNALD0nsPCywJL4VLah9asoLX8FX+d5rO4NrnEwQklOAwLQHKmcQKvQ4D/4D4lpTPNPwPjifg606Zm9ZRZJAPtKdFDTBnOHDEhLYCltpKQwDrMJAGEBTnkpTHgloKdDIYn08IHKyk2es4dbrCAYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7g4+dKnGSjLwx/oQXYoXFh6LhUSajSs4e683tlyrme8=;
 b=F3hd+WFcflBecW9XvOMfQFH1t9XvwU0Jybh/WGBU913iuJyPbPB2vqd/MxdhRtIzi0RxRmnb5TwH4eSOrsQT9NZ1Zkcul70A9fM9j7aNg8NqlJxfqr5B8Ik4YBLw0TyHd7wEZeGzvKidR89XhGaL2XJaPuCgssvUUrTl/wfCxegCV3DdfEd0MBqgWQDsJJcGXcgbztCcXai1Z2p4e/t0aTyZ30wICaUonVfN9sTakDdg9VBjsYS6pYmq3rqyXFtAx7q8T4eV2TdRmNH91pxkKK2C+8rcjI+Q8Qo9LHXFpda8FRywfm/fpfCr25VLZ84nXwi5ew253t48AE79+sYAsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7g4+dKnGSjLwx/oQXYoXFh6LhUSajSs4e683tlyrme8=;
 b=wf05xAzNoVpHS0Z2+RJV9CfER1QbXwKL5OCu7lKiu37+rTnVmf0YxTjJzuoivKEAnZIg47xkPbXUzZvInM9xbk7WP1NIoLTukQOztr8W+Z5HTnWIGr4+qJlWfP6KXjxPIp9MUSi0FlyZCZSdigPI2go3MOTbZ+0eoxfdQgqcp3enma7WVT8qv3+tFBlo0FLqDE2r3hIVFj/94Uw0E9Fd6TzJNE2pgOOytr8UoXYNCQ6tJA3jhIy7t3iL1643V6dtB0xYb9ufVHiqNC6CYZeNEzbahs2a85vy0zcAYqqNaCLpUHDfkdrs1aF8l8dLKTbxQPcTpCB883r+PtqQFDEp7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5796.eurprd08.prod.outlook.com (2603:10a6:20b:1d1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 05:25:24 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 05:25:24 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 2/2] led: Add dts property to specify blinking of the led
Date: Fri, 12 Jul 2024 09:25:07 +0400
Message-Id: <20240712052507.2496669-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712052507.2496669-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240712052507.2496669-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0178.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::21) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: c796c2d2-a4be-471a-08b2-08dca23307ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R1irlaBpyd48Kf7JiXKoG11pxht46TP2PideGIaZ8YuW1y/ZJWV+naKmXoNX?=
 =?us-ascii?Q?ku8b/x9QlNAnW1Dnb9uVxw/tCQuGuukt1OAk29mRKLjnQhkf9aOfeoD5v2k3?=
 =?us-ascii?Q?psL6JNOXDrbkatcpCIhb8byZjgppKxtHzx+PXzTk5aoAB/eYTpfvkWXa+cNk?=
 =?us-ascii?Q?GQAG/3wWxxNEObxQejxpOu7uZbjxWHZ2lOkBBsPITYqcaUiQFZVtzt66BDje?=
 =?us-ascii?Q?ne5ZZUdKl0Aj+sAhRXuNRekze/upiI76eHIF+NLYvEQkqlFSZnjxDDYsagxb?=
 =?us-ascii?Q?CDPYWt32msTnIGZevj2MKWtaLqfyY9DDapzBFQ6TvNdNu4Xmf7ZT/E5Jt11W?=
 =?us-ascii?Q?PJlE/U+fFBA9rcJ8i48hPQUk9c3TbaaqK3fS26PGt1tMEwVP8Zuls1ScuyxF?=
 =?us-ascii?Q?xUFkjhYZ4JqvSILg9Ak3KhuGBewtV+ObzzuLdDdCTXFp2At6IcMRBcZafIH8?=
 =?us-ascii?Q?apfxOTus92XZHeq//Vb1GVE621YA/0t55nOVcoqdIdmOQZZBX4XqHIVPmH3/?=
 =?us-ascii?Q?0gsykKW/7j4FiZ3dkqBBnfyhLtzrT2mY7fHc8n1CjOMB+Z5jTXvfGTxjtIxX?=
 =?us-ascii?Q?x2y86FcXkNyShuMO0mZ9Yw7Y6UAnCoTBpYFJ9SxbYtIz+o1J4D3YI1eFIMcM?=
 =?us-ascii?Q?5mzj4Q0qqChhE1H+nNVshyfqYxVt223ElUCuvpy1y3AQcn/tqEet+B8Men1P?=
 =?us-ascii?Q?zabblPOgwU2QtNWwTHZmVQiJvXc16FDQkllJeTivuatVDXjQu7gZPmHr78qB?=
 =?us-ascii?Q?Ekq4N+9otksWO2o9Xs9cjVqQFoPHfz4CteQxVF0LNRvENt97lhAJ7oqK50j6?=
 =?us-ascii?Q?R9BWUGWZnF2YLupNxgorbAM2rhQU8p7zvVlN4o/3GhUOVvvCJhbo3aCGb5v7?=
 =?us-ascii?Q?BfGi1EHenaXChtnNJP36Lq23AhwRDp6w5SNYCHssjH3xn+EnLbaMH0XRGJUo?=
 =?us-ascii?Q?z1PQs9+NS9A3DNXk4q0B6XAi8+RmYW2tkukvsBMbpmxnmE8/Ooz43UoocCnp?=
 =?us-ascii?Q?e6f+koL87Mh4qAdnX7D6RqrRFj1YYjgYN9JVFU5UL4hqlrMqXp8/NcFZGohT?=
 =?us-ascii?Q?dWOS0ydsveWOl2hRhU69vPQPanHtqvaABml7dy5QoU+KGTxNlc6WYoMerxXH?=
 =?us-ascii?Q?W+/8G6rxrqJpcxedK2mcaHOkU3CA8KS8tOfn2YDRLhgHRSy04aimEweWAvtk?=
 =?us-ascii?Q?hnwC2SO7sT1q78Bqa6JaEiDrHZzEyOHTujnvNCrzQGrHZIVvZXMmhYFrYdJE?=
 =?us-ascii?Q?Bdv2ejX3tzeYdJH2Glaz2+188C22qmEKgbOeIccBPBzVdmSX0QSX5tpSJwv0?=
 =?us-ascii?Q?Vb58Hm/rdg1j1qMLq7ouTincgS9J/KkSfJt5VNahTpd2YpgV1S8bdjd3FKdB?=
 =?us-ascii?Q?teHipnrM5Y/Sx0odBAM42FCPu+iS+j2b7oM5Lg5fwo4PV3oIrQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4tnHBaxqHnonfnxmY6E0Y4JPkMf3YtIg4CSrgfo2NDazM/5kpDr/W+KwtVeQ?=
 =?us-ascii?Q?V870DPtISALeyX8O36Tqb8ebeCEGUI08mdcu9S6OCj3fv2IUCHlhYUksF67M?=
 =?us-ascii?Q?IEFHoZkoRd7wILT/5QZRutQCzinokEmWg/qUcypX+iXgNVvjE5TWlwuJ7tya?=
 =?us-ascii?Q?1kUhSPH6boTzcWQrC8+1CNxIgq4P2wQ8kEYkYCcodkypymjK7JDrhyx1SVsI?=
 =?us-ascii?Q?yBnGsz+beTHCHTiObUJC9CwPGoEtKtdRT8fYgwVMbm6280m42v3Jn26s5T7u?=
 =?us-ascii?Q?YE9BqddoFm6AdWBcb5Skow/o6UL8lhM4KKtA2MaEnPxM1qaY8laUj/SD95Jr?=
 =?us-ascii?Q?D0HYv4oqNhZRr/XBjrZmU3PX3zkO81FtZAMOv08YpvNGMsw8O3FTVLs3fnc3?=
 =?us-ascii?Q?UCLUAMqB1Us8pGUPmvtUBVNH0HDXf6HovBO0x73wRTBQ7edto2TNNS++L60M?=
 =?us-ascii?Q?2xtt7Kv9/5CI81rMg/jGVhxS3bcwM4mWP1+dLyrfy2cU+gP69u6LH4b4OMl4?=
 =?us-ascii?Q?ehjbDUX0VKJbMtPGctml8jsDJCVsKFtsHEWB5fpb9v6aSVoABmG89tvHRY8o?=
 =?us-ascii?Q?6HOHUxxmmA9E0Zj+w9q54SiFh/i5HtpTkjMhnLkgxWbOEladO68juE4VG1Sa?=
 =?us-ascii?Q?Zya04mwdvX89qSbCM0nowut+dkA92qTRmi9yu4MQW3tqZROzrpN2T/gjcoa5?=
 =?us-ascii?Q?C1OLDaQFtr7/cuSIYb1digGIroJ08YD0A4Eo64hkg4l37UiH/qpUFtVeNWSP?=
 =?us-ascii?Q?Eu6cbeoFKYU0hV6xaiE/RSAJfo3/F1YeER89Xs9hycQKwYWTBe6yKrl/KGiC?=
 =?us-ascii?Q?QD3xxFulQKG/klATrzTWJh9wao8uWCXBPxEHufnHnH5ofcfjODGJS3BSIUvE?=
 =?us-ascii?Q?ehXgkfyLs9Q8D6xAynJ7rYSpOHIQO6EJJUOwCgqrWjhny/Y+kNPYY7LVkHUn?=
 =?us-ascii?Q?4feKPD2en0gMxju4YMOTQET47BSvmFZa8LqQApbTgaErvzRIIxtb8zfKzKf9?=
 =?us-ascii?Q?nK4IdEAI17GZCYJjsm9zjbIWMxgKRZXP0bPfKpCKpFIxnVvsIz2YXJZm0KWY?=
 =?us-ascii?Q?ZWcOrXDmlzNmIk5whUVWpN1DH0KoDjErkadK7PZi31NHB+OJMPr3Fl87sX2V?=
 =?us-ascii?Q?HZl2oMpZEtDUTjudbKl6eeh5kLNh/F+Lt91RdUa8QJSjNlrvUmwS+rO7NQ/M?=
 =?us-ascii?Q?eciUxbSarzdeEbPoSyAnFmZNPI6j6Ao3Lb0OTcv3AXeRsq6kER2mj2e/fv7K?=
 =?us-ascii?Q?mfE29JWz+Rvlimz56/foqLXkPOZ0mpOSP/AadtFScLVyi1USC4wD0B2Y+G2A?=
 =?us-ascii?Q?ZqaV4wCGZQdoPoPOWScsAEdSq+9nm8ialH0Go3qfmPYrpYQL7tlI0kAcXmn1?=
 =?us-ascii?Q?nNrphQkKz1TW1SdFr4iQRtT9EBwrDy0zsH6IXnxwBCR+PunLXCtFs37/5ZVZ?=
 =?us-ascii?Q?lx7LfaAPIrwtSa8z1YxOvz/RVe01utu901kq8UHUTdfZlg2zWq576F0TFJP1?=
 =?us-ascii?Q?XeLuJqrtcT79X5vmn3UMOT3BfkdnFG7vPo0QArqVx/oHc/lPeEu/MDdEGwXv?=
 =?us-ascii?Q?Yax+4uTQ+gb+WCuz6p+byjAmhiu5ealoS3dEkGbKbdTiZMtSiCHaVlPV+mDH?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c796c2d2-a4be-471a-08b2-08dca23307ec
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 05:25:24.1241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OqMT+XlPR9BHuCqB5xiQXFwToXsIPfj4TrpUyF1Kw7B1TTOlEgNby5IXhNQvLQC3R+C0UiP+2NfrVe+YzV7Mfb3xpOOftfrOdMtKBr/PU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5796
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

From: Michael Polyntsov <michael.polyntsov@iopsys.eu>

The standard property

    linux,default-trigger = "pattern";

used to get an effect. No blinking parameters can be set yet.

Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/led/led-uclass.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 4f5dd66765e..90047ad35ba 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -100,6 +100,9 @@ static int led_post_bind(struct udevice *dev)
 {
 	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 	const char *default_state;
+#ifdef CONFIG_LED_BLINK
+	const char *trigger;
+#endif
 
 	if (!uc_plat->label)
 		uc_plat->label = dev_read_string(dev, "label");
@@ -120,6 +123,12 @@ static int led_post_bind(struct udevice *dev)
 	else
 		return 0;
 
+#ifdef CONFIG_LED_BLINK
+	trigger = dev_read_string(dev, "linux,default-trigger");
+	if (trigger && !strncmp(trigger, "pattern", 7))
+		uc_plat->default_state = LEDST_BLINK;
+#endif
+
 	/*
 	 * In case the LED has default-state DT property, trigger
 	 * probe() to configure its default state during startup.
@@ -132,12 +141,28 @@ static int led_post_bind(struct udevice *dev)
 static int led_post_probe(struct udevice *dev)
 {
 	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+	int rc = 0;
 
-	if (uc_plat->default_state == LEDST_ON ||
-	    uc_plat->default_state == LEDST_OFF)
-		led_set_state(dev, uc_plat->default_state);
+	switch (uc_plat->default_state) {
+	case LEDST_ON:
+	case LEDST_OFF:
+		rc = led_set_state(dev, uc_plat->default_state);
+		break;
+#ifdef CONFIG_LED_BLINK
+	case LEDST_BLINK: {
+		const int default_period_ms = 1000;
 
-	return 0;
+		rc = led_set_period(dev, default_period_ms);
+		if (rc == 0)
+			rc = led_set_state(dev, uc_plat->default_state);
+		break;
+	}
+#endif
+	default:
+		break;
+	}
+
+	return rc;
 }
 
 UCLASS_DRIVER(led) = {
-- 
2.39.2


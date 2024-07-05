Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF559C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 02:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 232348895A;
	Fri,  5 Jul 2024 04:26:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Hgf3L8VI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 250B18895A; Fri,  5 Jul 2024 04:26:48 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E3E983989
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 04:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyXtAy4IP34noFS1xSzB1NbjYW77rjT3JBmx87t9eUa7oqFZ07jldwLXtuzdo/EJyjday4cA52Ann5WiRGSq9L660dWh9lJgI4ApOpvBznAEkN1cP3adeKr3ujSoJiB/kHJ4nr0/OOCvBUaC3q05WHaSB3HcTD9AvMWN80IoTkl2FOH1a4eIGzvR66yP+yHrTb+CHdj3p7KtF+aZ+AWkgoNNaBgMhscmWgjTzLcJ6plQYMpIF5iocIm/+LE7xIdgTAZJEPoBU7QYZKFBmyc6t6tfhTc8AVAHUBrH9Gwpw0JBbyEgdxy6jJLU3lgFW4OA107JxXZ8GTQdaVNj9qaQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uOGsTp553DwyolEC176OOt1PtAfOrnPIB1cKIoZ6IQ=;
 b=Oc+bNaN9lTczUtg0pFRj2fDCIfw/dPiicCqar4oQr0s5PR0WUfVu4z0s5DQGHl3AEvAP1KE8iZrAaE0fyIgYXDLqhtufSd3a2c33MmVo/KtHVOIb2US6Pn2tvZI9R10Nwept1lx3uMPiXJjLyoUtJHGPHf907jMF3FkhUW25yAbdWoO5EtQ6KhRHwjYMjFFKRvJ4bP6bauGEapRUsrqzqItV0m/YnmtKgNTTmyUEM6iN62qfvAkm+odk19x1U1m+61zTrTOk85xHwk4Ht1GakybWoUwmT8mvZZfmoh2IypVGft557C8//OTXCuH/9zx/QGHafQ8UX/ssolVzN94sfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uOGsTp553DwyolEC176OOt1PtAfOrnPIB1cKIoZ6IQ=;
 b=Hgf3L8VIFc6T7zPxeWFuo3bQB9SYZljd9gZd12kqmrdXIINDuX19V26YgJcWDbTwoo432cAhKRLend0aLbQU5myJMkTG8z1LstWcexthTkd+ywwTh4nvoi8YR1+qKG3Jzl1NyLtwS134wJJZatR1J1vT9TnPAdCLVtv9VuXM8uD44FMZse/JwvG8mKGqKgBCqYQzFc9vEEbp/SJWtaM05sZOE/HKZhiNSBqroEFG018FcmmMrRe237Dhlp2RJXn3kVyOoConMhowqrtA5gt2GJ6lq7X07acGteamBJ7NAyM99mF02deLV0Jy9gMknIXwMu5QTKXZz0FyQjF+XjRGuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8488.eurprd08.prod.outlook.com (2603:10a6:150:b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 02:26:45 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 02:26:45 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de,
 Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 2/2] led: Add dts property to specify blinking of the led
Date: Fri,  5 Jul 2024 06:26:25 +0400
Message-Id: <20240705022625.2249734-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705022625.2249734-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240705022625.2249734-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0627.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9c0b3d-2512-4b11-1b22-08dc9c99e9fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l42iD7AWGrqyK8jsff1ANWhz3cN4jBWnYxH0EO7yzDYFkHv1f/lTiiUmx7Ol?=
 =?us-ascii?Q?dCXU86uiUH95R+K+9L9jkvR16J0rPndgZG/YWlfJEhn65EQPk/gt7+R10XZT?=
 =?us-ascii?Q?JLf65bphMU8OrbfRIAjvhLyEYkWd098OZTxO25xyuqvyKODlac8fncGGuVeO?=
 =?us-ascii?Q?6yBBIcOtdzuHghRv7MDUVoZYkkzUlffZoLw7PHFk6+gZhC089/r9HLcNUPue?=
 =?us-ascii?Q?MSc15FnSXVNMLtG/eKiyFyhCHWNNgP7+R9d+2ExydqtbdEAnjQX7a8JgL9kr?=
 =?us-ascii?Q?jGZIyTHmrQ69uOnxsY7isTSopIMMl95eNuLqzFrWWgGiKMr9XoLfsGvZLLWq?=
 =?us-ascii?Q?gr5TjPdSISx16HriiyHQ/quR6M9ivXP8Wn2Nvdz8+Ohipx9P6sH9pIPL576R?=
 =?us-ascii?Q?3s3Fq+HcVM7V1Ik+P/Yrd6RR+WrHaacbiAO6yN4oSq4JdfNHAHjn8gmKpfhS?=
 =?us-ascii?Q?Fe4YFSBGfO9fY1UwBTgCulhZd6w4tC2CnEVAiGjDIdra9jlsmx3Ms6EK3hov?=
 =?us-ascii?Q?OZsuJs4jebzUPbAMqqYgwgnJWplpQDwim3CwTpy6DgFQxfxrSvOl7WFTmpr4?=
 =?us-ascii?Q?AKfufqAuGTjnoLaC2UCKrXQIOxYbjfM3fkag5v7kLtKpIYsI9bXWyDUDhtlq?=
 =?us-ascii?Q?lY2TmSmpmSjjd+nkvpAGSpQYw67KqayhdnrpikTKwmRnfnBXe+XDl24zAs+H?=
 =?us-ascii?Q?QM+8759FqTpmwLn1VxZLiCNHbxdZ9pyhFnNaDjNA0m9DVsnUXZhVzdwSYPzZ?=
 =?us-ascii?Q?KYZ1wwemjnn/rEuyBQuUtRNjDF3Qnw4AUk6Y+J4Szxx//6hX56Rxsdkk2Nm1?=
 =?us-ascii?Q?cbi1EH+P67c0lepWTZh9IPMCj8c/9LisG+pQwJrSbB5fXaWg85oV9eKurZR3?=
 =?us-ascii?Q?F/9/mPBZAfhMID4MQDWpJtYT9iGvIj2NyVN8J70bYNgLr9BRt1tjRRFQkQP9?=
 =?us-ascii?Q?NGynhlVAoI0ZsfHMO0YFxovohzeisEiE8D6RLKeFj2eHKYqbPZV1v4Ipb9t6?=
 =?us-ascii?Q?cjeTUWDiVFs4fD0ckQ4J9YBnVPD53ZBJoc2X7LElgunk2150/DeKI33GjxBU?=
 =?us-ascii?Q?eAwY0etMgMnn/gMwD1158yDcYjajbRqHnehbX+AMzIdH3p34bXl6vtFyVY7j?=
 =?us-ascii?Q?bo0GZIU4uv0cMveu8N/r6Jq2Bq6xLkVxvJNjd/Od37mTP2PAWhIPC2lxEa60?=
 =?us-ascii?Q?LIjOMeN407BTXk1n3ik44jo75LI8OOKm11ommJCOPHcJzstWbRd7KhhUx0OS?=
 =?us-ascii?Q?7iNHgdR/m9Xd9TiGW20BQHgEFetSrqGqqKUqFK8kNY9GKK6VjnTMboXNpEBU?=
 =?us-ascii?Q?un/gwdCc+tLREpcdGnm6K9R7x4EQe9NHWSnXSQ4enPcz+4t7D1Qnv3ucs9U5?=
 =?us-ascii?Q?xWDvKGFW9il9NB12T3QRwrSxVJ6/SryFVMX/OM78VwaddNdoBA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tk3YhblZDE//mdRssk7GjUdYXqS2ikKcuOzgMbChTJUxgEcs4qm4N5y3uJ42?=
 =?us-ascii?Q?bJB0hIuMA1VhWpJCf10XkjD3JC4yKSCRBXGzcBCDWWhgAT2ZzinJxGCxwuvH?=
 =?us-ascii?Q?kIELkod1ELMqQM6PRl2gSwVgFZjTdS1OS86X5Z2l9JEN9RSEONfSubyWbFGO?=
 =?us-ascii?Q?N2H37fm/WZyNgNd/Mohmvz3YPxHUvsVAX7dabJo+QviDC/KlBGS0+s1AMQJB?=
 =?us-ascii?Q?EhTrDHmwEGLxMxJwxiWCucRoUgQJLFSBn9VXbQqNmQgcUxityIXd/Ampj5Ad?=
 =?us-ascii?Q?sDQMZwhIyi49fcuuwqaSmEdqgivooK4BXEACKlIJmTTiRqtWvupnSDF4P8Ap?=
 =?us-ascii?Q?DWSOs0KJDzHgJgEz9YgcCjNNk85cG+nzn8scWqd4xcMkwookCa+j5Dk+LJUa?=
 =?us-ascii?Q?dr9YDXvzXGGc5prvrAUT9lB63t3CTroxz//5B1knpSErMsCwgRBdV5BQd2bF?=
 =?us-ascii?Q?QwZ3DvpcJGzBSVmE/0nQFWNZV2gJVcTCLOBhoJnY3cIuKQx0W9bW7TUnPlAa?=
 =?us-ascii?Q?R5O3ul+rJMeVBTF9HjP1SkgVyTjpt+GoK0BJloTHC8AKZRF77CoZxFNZAOjM?=
 =?us-ascii?Q?ZQRh/ujGa0mzH6a6pIS8pduIaNnKyeRTyEBWwPs97qA49sAPJ8BqZZykQse6?=
 =?us-ascii?Q?0Z2AMWI5ZdeYdkZIEC8ix95L9TzP9jzf32gch/gjUGlTY5nvFKurL2iBigdu?=
 =?us-ascii?Q?R6o+lnkI99J2R4d2Dx5HS89zUTdVTzLzvWkjr6Hi5aamievEL7q4b+3fxP5A?=
 =?us-ascii?Q?8vdiNzK93S2urGhoNg0iqTn3yhabTiCg4gmZQINvfYxMBHYnJ8o69/KTP3Ob?=
 =?us-ascii?Q?wRSR90WQ9xj0hEmL178dFr9JhL4Froj6upP0pE9ypWZJpXIwSkj4hrt8VoTX?=
 =?us-ascii?Q?flnyD78pbTxfnfXotS1qSiFIa8yS2XhwPJRXQp0yFeA0xj5B3QQ80eruZPzv?=
 =?us-ascii?Q?rHo695wdwKLiSN7dakHGyBxzeI0Dg+U/OXLSLDRTZAbx2DFtpBfov6LPXIVv?=
 =?us-ascii?Q?iKavP/Q4kZExk0vSE0r6h1akwfsvrOYSzPlCMuSK1Fhyn3ImsA5UoHtzb5XY?=
 =?us-ascii?Q?NxAqxUQKE8byEF9HsrLW8vsYNhzT39XUoXIx+2S0rTbnhkLQI4XDQzf8a95a?=
 =?us-ascii?Q?XdGZ+AJg5uMHt9VYeLY5lYF5/SHnanA9fDvUURowcJ62kKUBOM45iLWxEzFj?=
 =?us-ascii?Q?zwurZOESrIgKafy1jJgjMmivHbRQqRFg7oMwzPrkcI+ltQ8C10AO00hZ8oIT?=
 =?us-ascii?Q?2NjB0O180pSKQMo90BAjuE3QfpIdkyaTQnt989Zlc9R0wA9rkapXWvkL17JK?=
 =?us-ascii?Q?/jM/TM5Jvx0PdioFmyjwAdCWAsKsorizDghnS98g9+kjahhV6VRCqDZIvZZn?=
 =?us-ascii?Q?yeA3/pXFyvysIvuU05+DWubys0ZhUUAczuofF+4hHwg2vAuDOb72pcvq7V0z?=
 =?us-ascii?Q?wwu1NfWUmreMpDOkDUunUyWUbsI4E9KXRkMAQhkg0LVyBaSQtTwB4V4WTMW3?=
 =?us-ascii?Q?R3nKzH80rLQTTpe9maKAkSbsKb2vXNK8qS4DtaMLNm0Xx4HRRoteOMauvVF6?=
 =?us-ascii?Q?VKVrj9VAPvVa5jmu3kk2idMeh6OvAMN0lkaqptTUX4QbCExGGf9wVsTrbYIx?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9c0b3d-2512-4b11-1b22-08dc9c99e9fb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 02:26:45.0785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tkwd1RAMC/Z4gSly2v/6PlH6bgbAPJc2qdzSv80B3H0xgmhO9cOqxymSOELWixcKyV285E3aQcKlj9YaxMQTOTEDMduEhYjh4EmoCol+6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8488
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
 drivers/led/led-uclass.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 37dc99cecdc..7d4db9f9c32 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -99,6 +99,9 @@ static int led_post_bind(struct udevice *dev)
 {
 	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 	const char *default_state;
+#ifdef CONFIG_LED_BLINK
+	const char *trigger;
+#endif
 
 	if (!uc_plat->label)
 		uc_plat->label = dev_read_string(dev, "label");
@@ -119,6 +122,13 @@ static int led_post_bind(struct udevice *dev)
 	else
 		return 0;
 
+#ifdef CONFIG_LED_BLINK
+	trigger = dev_read_string(dev, "linux,default-trigger");
+	if (trigger && !strncmp(trigger, "pattern", 7)) {
+		uc_plat->default_state = LEDST_BLINK;
+	}
+#endif
+
 	/*
 	 * In case the LED has default-state DT property, trigger
 	 * probe() to configure its default state during startup.
@@ -131,12 +141,28 @@ static int led_post_bind(struct udevice *dev)
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


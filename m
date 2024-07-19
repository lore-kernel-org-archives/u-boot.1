Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524E9C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 09:13:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45C8888B78;
	Fri, 19 Jul 2024 11:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="iNHvPS2K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30E68884AC; Fri, 19 Jul 2024 11:12:35 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4807788B49
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 11:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6MiU7ikvI0RZK9T6HuOwQFq+tjEvnj9wEcHR7zMGSIVn/Q+pyLiptZ2EoSC4trG8dWtST+6c7eKL8SoJKYbpUWpCN01tHyWJHP2MFm90yszgNukITvRWieo1W5swDgHsewCzX8XlVrTSZb6uUhX9+7pHMRqDcpgKp38pkxoKcXWjW14IdI/yhJHYpGwU2x8AkCAQKwGoFO28yo4orvLH8SwQ0TYidXDTSmsgiXfr0Ys6wxSQI8kgKD4cXHcjvvWy8Ot9Tou1ieimjr7+cRvNlYZi4iiumtIzE6fsna4QkoUK3+4hcM+n+7rnprOEGG0jeWEQgIBICCWUnIH+lKscA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1D3HCxeX+fvuGk49Jb7+mB19Tyv2DDaVYX8eH+mvr0=;
 b=iJq4Mwzf+qTWVcehCaP4fyu8X3BBhoP/g45aLVEjIQD0QUQN7GNF4vSO07I2dXhYq3Ypu2vgSW77hkS2NbAXAW0jUjNNCknFcuIPjgrOfsPcZWkxuvcChu2L9edDAhOz65TIvLZ3fSs6Rx6+TD7YnxIwoHHoRdHZuUSM54bSQBTbT+EJzrC6wqVTU3OImRr6EBHPZmy540Ajjp4Fr2gopFE9dsY92FMGSAlIJz5fxYdjMIyC848w4tzHjBabm1DQlayLIc6yQDiurliwgV42BgSnZuQqXrIFa0Ak3GDbmUw4R1Q5zO1+NwAXTj+GWcyqK8IAosImdfar+ay+WnEoWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1D3HCxeX+fvuGk49Jb7+mB19Tyv2DDaVYX8eH+mvr0=;
 b=iNHvPS2KY8aVUMyC6eQusasu9qZZtvC29kGMstgeLFNbXa9PNPlR4Ptc8rOeuhI3W0Hj6gyGCBXcG4l18RtjSCu4PHuzxE9ZJT397vSG/cyDQml2/m2zYVU1qm8zIFQnVQUFocEg9wlwg1kvgSOpuvP9y5Qe8CCrESqhWgvU63szdTAiSFwGZlCk8gSNtuM/+ikjnboQOcBn+HtbMOhKPYnyavftMVNf8Vlz7LML+S/wVcRUjvgCVnIJ4Xc7Z9wthwx3lyM4Ph0F0lJoMQygv3NzKsS2vg7s0UHNwXjwkVjykSHKe0BE5SUSwVWlArMMJDoNaXW5JLjbyVKZ6TLD3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8628.eurprd08.prod.outlook.com (2603:10a6:10:3d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 19 Jul
 2024 09:12:30 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 09:12:29 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v6 3/3] led: Add dts property to specify blinking of the led
Date: Fri, 19 Jul 2024 13:12:13 +0400
Message-Id: <20240719091213.3757300-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240719091213.3757300-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240719091213.3757300-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0029.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::20) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8628:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b6eada-6ba1-4c74-819e-08dca7d2ea60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f+opbzPigqx4I5FywonoqBpYKmZ9vJ2NFbqbIl7mI08DEwYFJu6V0EkpLvfd?=
 =?us-ascii?Q?xkd7Q8bkEASce35flrKmaAug+IhNZVYnPa0azXSv6nbA759OTKFjIfCAYePG?=
 =?us-ascii?Q?B/tlUHXsvJpJ4F+Vgf2dG+XCEMMZg/7nx+CwSQDq362qavki0ldfzqFT659C?=
 =?us-ascii?Q?GqGZyW7P5gH8H2WiT3r9nEhdrJYN2oUoZI/kUmPDtAwLvZSrgcwCT0FOCJrs?=
 =?us-ascii?Q?lzQwlvOf8bDsRRmx0YFuHl+wIzPY73onNQgBOUtgwY9d2TJkqVENQM14yjVn?=
 =?us-ascii?Q?nGFsTDed2EeKtiq4GR2scr/yLZbbKi6CJnfcBWeK9nhoEyZ5amUFPjJqaNAZ?=
 =?us-ascii?Q?0Mwab33o23iaz2L0kIuJ41j/bDTChuU/mcrtCoCEppvqwHYrtAlYSL1dEBni?=
 =?us-ascii?Q?dwhKgn1UzVfL5mBlIp4sS5p/crnHpdWFLAi5rQRhqvIjZeTGCeqEh5UTRLLk?=
 =?us-ascii?Q?U5/7Ya55GtL1K2CwIyGHa3iL+1L9Kg4h0z8Y/U0rKV+8NAj4GJ8Adi3Kg1w3?=
 =?us-ascii?Q?hBTOBx3tH4VcUnfoGViJQkqjRYOM2dsEMWS1mM6CaxAuZpQIjIPO9YIef5oa?=
 =?us-ascii?Q?X1QIBaS4vQWyR4qjl2qZzY1ckH0szTVwQKmo10f5XNe+WEKPYV8DGlEhGEj+?=
 =?us-ascii?Q?7/U3u0aGGX2lxtsd4enS5i/ZHZzpgDmUz0LuKNw8SXVWHtHnodI1UfDm+6mq?=
 =?us-ascii?Q?LxMRsJOSZaMzpCWUZYU9GqSpXLkzm+ZIO8cDCacQPsrXcd+Sz72dRg9k09Nq?=
 =?us-ascii?Q?Rl+SojTpVaz0rOwdrUOxKl0UUGdLPsIurYb32h3Ic/GXpBSftBs6nn2nAPLC?=
 =?us-ascii?Q?5RTpgJOgGN5WR6Da4ajgfXzTFCyaAMPwbPleFxKVka49KREZ9WK300DdtbYF?=
 =?us-ascii?Q?ZiDEVJn4vNj/oM7aDyntX5MAqudgADmJ2/8bW0ygUKbICz4wxGQ+eBt+inat?=
 =?us-ascii?Q?0eyX6KVRd6GippJ6+7DouOd6pWR7xTj10oieg4fT/8VAxvsXShqmTeQ2vR/J?=
 =?us-ascii?Q?k8chk0bdi1CBol8Ke1aCbqMbn2OINCBH8LLV2aeW7BbD7K/dyVWnz/1f7chV?=
 =?us-ascii?Q?8S3Fb4eLij0zCT1FE32sHL0ZBGUIcd5plazQ8iFpOa09/K9DSGczkmYN5/P9?=
 =?us-ascii?Q?C0auUzG20RfjW3uhA+TfJMeMH/rN/TxTsuimEOuuFKEbIx/X9GdxLqAlBvGf?=
 =?us-ascii?Q?YiXjNMDgZzHSUe9GAk3jTR0ab+YQrPl4rUs1afKqwxHiRmkU89lxAvoELpQy?=
 =?us-ascii?Q?b/aMXti47I8QWJ7CxNQrNj00hcRhN8AMFuKOOvSzEtpDgMMzomMs9U1gsnzm?=
 =?us-ascii?Q?8ljntBrMpyGrJ7u0+rj2kYuNkwLVZMfa3q9Caw/y23i7JrE1YyHDQbqSQzWF?=
 =?us-ascii?Q?BSLQzas+zFoN0oiHQNHsg7kiJj+xNW0pezw/XjLwPb0HHDUtqA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O0Iv+kRgiwaGsS9BO7Ji05HPsaivslJxbMA5s7p57drXDyKM0DvIKucu34+A?=
 =?us-ascii?Q?ZBJZ7koog9/Qg2WPLSx/Gf3hB1eM8YfBjyb+LJQ9ZrpKpMbOgjOISIVYwgY3?=
 =?us-ascii?Q?rJjCD77MZjB4NqDHe6ZJD8R4j5mQx9E6qFqdDjXR8ZeWYICYAbAIY6PuAGiY?=
 =?us-ascii?Q?YkpLn4jE739NuqPZ0cxnDLRtm44qSyN8ytkMh+Oe8yLps6ACBgf03VZMFymj?=
 =?us-ascii?Q?j4zNIxfyeRKs7KIdoZZJP5pO0W8YxY/ziEATluEH08qfTpKR0xkdMxFstM99?=
 =?us-ascii?Q?QzdkI6e2+IN4d8DesNQsM6wHkyisGhiTC3wZJJY6fR9TvdhhZQ65VS/NcNc6?=
 =?us-ascii?Q?R8Ky10VGyjJ1vJve3ZDMRqWrpkq0sIoERMo+6gDMOBuS/HSGpKLueXhkvNHs?=
 =?us-ascii?Q?myIkNYay02Z134VhYLwL2nKo5cEdc6lTKMdlZUxm0rnEpufi43IOR4bGGZH9?=
 =?us-ascii?Q?cAAAxTloACBCyTX1jFJ8i/UIwqMkQN+gc7NpJQBmdLQ+DOiB9kbseN1xh6Gz?=
 =?us-ascii?Q?Fk/K7DpxyzMr8OaqeAqywW6gOFgcl2VINOsPQiKXe19jfUKSEId79VuZHlpw?=
 =?us-ascii?Q?roii2w88zw8X9LN+Mxgu/Y5AQeQ7H4ltaSlERospWsecEJMG4KIF2KVtuu6S?=
 =?us-ascii?Q?jRt8uJIY8hYZRU+1o6wC0I99CEY4XVOxHP+bMddHHF2OveGOZAwzUHIg2uer?=
 =?us-ascii?Q?Se5DYD7Df++TAf0n46brEr+SHeP3DM74BCUQJlqJUnD7aIuo9vhyAKmDVk7M?=
 =?us-ascii?Q?OSz18rEcezP+CucXBzWDn1uSv/QhqHJSffyr43Equ/R3DSqfsZ3VY6qaKPyq?=
 =?us-ascii?Q?PFjEA3NyHZ0Xmp3wgrIzldjr3qFnsA/h9LIBTgmMWbqkmJmdx1jUTo2pfAKm?=
 =?us-ascii?Q?x0ldqydEjMw4Z0rkQXURjCVC0H4Ghes9HOxf27LfG5fcv/u0kZ/G26YuZcd+?=
 =?us-ascii?Q?D4Akal3ORBZc6cc3efH1yJU2zFVfcBYfAAMcbXiHXRVxM4HroUfKD0AnqNvS?=
 =?us-ascii?Q?jzk2jGKu2oaCp55A5xAqrvTzNnuonDoz6d6MmLGYGGteSzIwQqIGU37U4i9O?=
 =?us-ascii?Q?wgToT8nghcAJY9BDY+rA/Yahh7tApHyNrsaHRB3KPFCO6VUwQiWXI64J4aA4?=
 =?us-ascii?Q?BujaMhtzhgh9cM3aCoxkc0WLZAdz7t3d4WgTWW+MhLXA4v0evh203mRyCulf?=
 =?us-ascii?Q?f9CprZNcjDHZXOhIV88JSz8IlI6Gdlk4ZJYioTqaQv81WjKhSslXvB9BRTQR?=
 =?us-ascii?Q?V2PNk4J9lBUgBUva9ME60aorD2/LyWN2xOzGgZKAl/twDF1rMQtmVEIXDU7t?=
 =?us-ascii?Q?JbAgH+Fh5Ttj4THEtxZ9oHpGNLyUxkX3uhjSyMt58BpzQTUf8EdyBf8COwlS?=
 =?us-ascii?Q?2UrnOlSb41cMhQVMNhcrXcrNLNh5ihYqOyuVgiQHS1jX3J36sUg55NyMliXr?=
 =?us-ascii?Q?ygiv+MzJi56vEioR0Uz9GV46IfIj/xmdE1Wg8LfCHUzJuZkBqOwDokKKVR0l?=
 =?us-ascii?Q?A7U7FhyszsGKFiXL9YXVsceZrhntVL/tYzGH4R31hkrjQ6o893sdFy3WUWU1?=
 =?us-ascii?Q?BzJJUqCKQRqZUBEEDrH25p1S+FdImGO3Zz0myBgawtv2JdGUL5UqgWIpzAYT?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b6eada-6ba1-4c74-819e-08dca7d2ea60
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 09:12:29.8819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zd0+und25fA6ZN/jsbM9a99rBZJOqHuYFDT1jfLrWK8kWkPGzhgH/Raq6HkZPdn38hdNtafVpNu9X8SWWjr+bJCG5PxXDsnxhDkj94PpObc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8628
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
 drivers/led/led-uclass.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index e6312d1dc41..199d68bc25a 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -118,6 +118,14 @@ static int led_post_bind(struct udevice *dev)
 	else
 		return 0;
 
+	if (IS_ENABLED(CONFIG_LED_BLINK)) {
+		const char *trigger;
+
+		trigger = dev_read_string(dev, "linux,default-trigger");
+		if (trigger && !strncmp(trigger, "pattern", 7))
+			uc_plat->default_state = LEDST_BLINK;
+	}
+
 	/*
 	 * In case the LED has default-state DT property, trigger
 	 * probe() to configure its default state during startup.
@@ -130,12 +138,24 @@ static int led_post_bind(struct udevice *dev)
 static int led_post_probe(struct udevice *dev)
 {
 	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+	int default_period_ms = 1000;
+	int ret = 0;
+
+	switch (uc_plat->default_state) {
+	case LEDST_ON:
+	case LEDST_OFF:
+		ret = led_set_state(dev, uc_plat->default_state);
+		break;
+	case LEDST_BLINK:
+		ret = led_set_period(dev, default_period_ms);
+		if (!ret)
+			ret = led_set_state(dev, uc_plat->default_state);
+		break;
+	default:
+		break;
+	}
 
-	if (uc_plat->default_state == LEDST_ON ||
-	    uc_plat->default_state == LEDST_OFF)
-		led_set_state(dev, uc_plat->default_state);
-
-	return 0;
+	return ret;
 }
 
 UCLASS_DRIVER(led) = {
-- 
2.39.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D4FC30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 12:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 708F88893E;
	Fri,  5 Jul 2024 14:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="xnQXMU/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53E0988498; Fri,  5 Jul 2024 14:10:42 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C7C488974
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 14:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxc3IeSRpgzX9+iNdU0bciuvDxYXXt6ELXoy/9oItHctiVcG28wOP4mUrr77/JH8+ucOKHecBh0xZ/l8fflCqwMKMVo9cWDInOKqlO+PNouX6yDAcBCuISHp59DCk2+NDooaWyDoZjWgIprziTJo4rA5URLosVx+dmVUSWtiGwo67WWTTTiisIf1ge2sAIiKd5Vj1HkytdeunhBcMIfkpBfiBfC0ZRXARfBVSRMsbC5jYDx5eCSZyaKaMVxjRyRou7NM4Rpx5BBN+V1zOvm/BKS/UtSrLW6FinaHl7ojcxPZFDH4QJXQufyseDGLyC8UKLeOfO4Geqtjerj6RtMrWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWLZvV2UdrZj0UM6O7plxXVRilje2tCzdCTI7bSyl44=;
 b=V3F0jfA0vDvNSD5wKAWNwsl9zBTTEaaAks19eQeETKSF9Bh4GMu1kvJnwQeLaYAoOJRuayaI6ZhHGNFB7wDLH+E1msFMmRIZz1xjI87KhsKfX6n6sbmIZYZ9xcxQ5MhWU/4jlR/FOJcmcsaAd5T5Npyam2gBmSP/s7Dl1CHo6ie7FXBtLARpP47J2BYJNWZnorqLGxdBiuora/imlWMdl1ufYRt2oAjFFRJf0pgEsjBj7sIOFrtF1rrjHQDI35PWdQjK/WVF14gmh7gn3qCyWZDA3lnLAGAX3gQUMp5Pub0DSyYq7W/a3M6PG427QLu2mKDwrVi7w4gaSDoIFx9qgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWLZvV2UdrZj0UM6O7plxXVRilje2tCzdCTI7bSyl44=;
 b=xnQXMU/E47ht3Akurbq82y3PMCWyAzb5xmPz60+0r/VWHHWYXgcqMuodHUkldUs6rNco6bej0pcHBPFHccGzkcYlocJj+R2ibhfEzHmzfa52dAtWNYGoqDVaojvevZjdwsC+04EPBFCVvTaDDylcfkCrS/eHx9LzlrQerwtAyB9TrGbO+0aimdK1/f0/ktlgtTZ5U5bCJ0cnp2PSVU9C72Ba3G1HWELJQHRBEjZEgaTPzvQiaJKXrnzD3zb9oihKBr9Pzu6Tc/JC5zjrlS00/VMwmOrQHJ5L4VAjfF0O6hfnyC8A9b+Wk3y9QDqirBmoumIUHgVURH7bHSx58WKF4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9395.eurprd08.prod.outlook.com (2603:10a6:10:422::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 12:10:38 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 12:10:38 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 2/2] led: Add dts property to specify blinking of the led
Date: Fri,  5 Jul 2024 16:10:23 +0400
Message-Id: <20240705121023.2266479-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705121023.2266479-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240705121023.2266479-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0060.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d42da5-7cb3-45ec-702f-08dc9ceb7b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DZ2KFM7DXDsKjQCmgvdR4egpJBDaW2/2WKOUMa88u8CpqWOOFVQCrJkPzDJl?=
 =?us-ascii?Q?vogW3XXvshgKp+Ie73GqnrWbImcG46pp57C/iBKpUohmY4srnSGa6NW2/Gid?=
 =?us-ascii?Q?11Qpd2KpgtMoQg4kNMpVakP79N/GcQUY/kY4glxU1Uth1wo+xqbE97H2cRDM?=
 =?us-ascii?Q?PTevMVY35emKWnnyHmoi0ZBdnWih1D/iGmGH9Ehqh/EY9uphoPsWQZLaX4LQ?=
 =?us-ascii?Q?LL/FWKxjdSEL25JFVXhTHBjKJDnAsRQgIla6+/zvL6M3GZLQfM8Z0Vz2egiy?=
 =?us-ascii?Q?uTKhvczr0pwGW90TmN8z1gI2WgI/iK67Foy/Bl/nrYBoC1Yjm8l9/Ta1MeTR?=
 =?us-ascii?Q?YB8SwZg7wET0sLUp2YpkPXWAbJecGeuGNZIYMYU09u9NtSMnXHypWbIcR87Y?=
 =?us-ascii?Q?m8USVV4gub3I0Wt4/whJLGeIh54VdYCCZY50z+p4lIZjBtH0yXKF4/mTldTo?=
 =?us-ascii?Q?5etc/K0T1lXSJsltb9oQZmR0w8TpmLyjmIaVYN0phtKBPRww5B2j4j4DUjvj?=
 =?us-ascii?Q?EuaJJxAdZF3bqoIx2O5aC6IJPkAJ6VaK5RwpxIQLARSIn+8YsVNCdeAK4cA+?=
 =?us-ascii?Q?WdHFJBey+Jv6tLZmV+P1uhHUxO4hFxDFZkF8i0oWFyis8v97D+zexuPmRQ83?=
 =?us-ascii?Q?0QywTmYLQj8ngKEDuxbwg7d8FRKgKKLEm+Feh0ezO3VIQyHpXc2agBMg14xu?=
 =?us-ascii?Q?+ZtwHutoCAR/bJPrOlmAWDW/WEWlZGFOmkX6lb9rcSqS5KmESu6wkN/57MqW?=
 =?us-ascii?Q?n2m9xkuSZIDkdKfejpCUJxyYcPA6zJ97IF/6weRMlR0Arn1YEZgk9/Uwyn5u?=
 =?us-ascii?Q?pzEkx4Djq8a0k9PGY0D95DMmbzno7OsN92tedDk2pDjOwHCUpVVbAEWnIldT?=
 =?us-ascii?Q?8FB0f7IsDsKNbFa7DPR0hwUwVDkurQvlOL63HKFZ+AryPgUWAGSGHjMCOHlm?=
 =?us-ascii?Q?Q0yRZaYqC5bNA/he0Ti+9l3qSHRuhAFmTgaXe1Ma/8RX1FGax+vi8SHaMZpC?=
 =?us-ascii?Q?T31VWjfPiuplYqn+dZHUL0XgVyOIsFC6Ol4qFe+bud22OiIgB7D1/PFNVdVp?=
 =?us-ascii?Q?xA9Se35zcGnAeqC25kvGR/hzwfXtJLCq7WD6CPxYmOYsQVonx8ozZBq5UyKr?=
 =?us-ascii?Q?B6iX71fH8RTBhptSiMkW5EUcmf1oKuoIvdGGS2GTXZLZrjNdHFBxwerfroWZ?=
 =?us-ascii?Q?IXVNUTA0EjHq/72VV/jmcbqm6TrwDC1IArW8lf/7KUe+78n/iCdwEhq/rtYE?=
 =?us-ascii?Q?50wmt1UdeZ1oH1yuWkZNnSKR1PeBvNOqmM2n6jAkzcov3nubg4pM5CKdGUJl?=
 =?us-ascii?Q?fYJoVh0Ismws7yXWUXKZ22dJNrGDvs3maH/GQUun04UoVmd4iwtTIHqnXTxb?=
 =?us-ascii?Q?luhax2t6xx2Q//R7IivOboQrsAjl8qaw6Eo6t4RZ3AbnwgKxZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x1jH5MGxMMf6oJ0v8WnILH6lZyjZNwg0q1QwTzWQjZLDT4qkpMNGF6KOZAfJ?=
 =?us-ascii?Q?td7GZ+iOmvMmxmXtypzwblbWSxcUzXTuYDew/qI0NQoY/xhkfLNOBHR4UaD4?=
 =?us-ascii?Q?ZWzGNNNZ4MW1cpMhD6IzS56MixtoSDJPtuaRjAHEtxhz35gm9n+W/cPGuu5f?=
 =?us-ascii?Q?LqJYPrgUdUxiyYRJuBOXvwyq1MmeBy5vmo996asI7YiJqRTNSaroh+v70wHI?=
 =?us-ascii?Q?56wpJQdnxiHa0lStWQKbD+rTc7fMM4AorZeRTxE+DXnli8GyaCfl/zG0weuF?=
 =?us-ascii?Q?GQMeeX2CkfRNVsHgZND3Bz6h+8VyIJSvL7fVlzsJBr4Qa/tTura7v/6yu14O?=
 =?us-ascii?Q?uSFzdijIQxckSHqzOidt4DGzI+AmnRj3ZVFTU0Q3JoTW5wD44e7Izq9SVPIx?=
 =?us-ascii?Q?8lN21Q+Q1jappF4H038aOJSarqFwctPul32wZjH4nU3pba6R2e7WXB3BphVZ?=
 =?us-ascii?Q?YUK+QKX/4gnbIrZPbtFLpcg+S8P5rh1FIKdJXN6+6n2ss5lArLAT2idPV0mu?=
 =?us-ascii?Q?jQow2yX52iwpyLCAhvi9Af/A6Jc0vxvvHUhfrwmaRMLbYvOjgR148s1AweDT?=
 =?us-ascii?Q?GGH1JVYN9A/GdM/IVqBhRYe7XcJtLIso5UCBSaR8b7pAIpSs4KpnztQ481Ns?=
 =?us-ascii?Q?bX3v1Oq2l0s69MQSUWnGMtcLLgFVbarfRmif+IgIGGG0xIMX8IGTVQkdarDa?=
 =?us-ascii?Q?kH0kl1N9QmCy+kIwvrmgqryNbyMbWFk5H8xuXQ2HdCVF0ESPmQvUPo91HpIr?=
 =?us-ascii?Q?ryYrH0v7YICklQAaQvOFDl/c4BOsAJLSBf/LYHaKo3f7BVjYj2ck7latN7yP?=
 =?us-ascii?Q?IXejKEpBvZGUDm50Eyp5Sc/SS4AMr2yIiAifh338NygvBwHTQ6Ee8LGso1Ra?=
 =?us-ascii?Q?r6Fdpr4ncNkLVl6EHS6fd5ncNPnkGrZpC+4j3y3KE4VHvHrlQUaGqDfJWIHf?=
 =?us-ascii?Q?pssJn71b4q/1o89oxk+QQkFDpcIz3Kg0x5B9zqTBfpD53BrVqU9M3WRv02xn?=
 =?us-ascii?Q?4gozqA47oFL9Ikb5jbJTqE0DRqcDsdYS9kG1HSRxPQqbr7M4+G+NmUDRv7J8?=
 =?us-ascii?Q?Yl5UyBxddGC474NT7sZ8aTGIi3hKYwD1g7gswRyXy/IP1v/sA2/+2ONzfInE?=
 =?us-ascii?Q?rQB45pS1bF++ucKYfasuAt9YGZ5KqFa6z3q2Mg+dSbHJoi05qaRkYZFRsClA?=
 =?us-ascii?Q?KEstC8afa/h1bi2pLc4IaM080tUFrR87esnjMkz8sruZGCfugjAEXh9PZqfH?=
 =?us-ascii?Q?Fn3mlAW+PxrGqky1D+TL6sXDIuF3ggFrV7VNl8vVcPesUxXjvb3nTBf5eQWk?=
 =?us-ascii?Q?SiNnst7sDFh56G+EOtSY3swDIRHRMI5TYvy5mjaA5V7fcvWNs/tH14aCWcR6?=
 =?us-ascii?Q?JCCiFg8JPqZgc2k6Lb4aEVlI0cf67w7MXcw6ozqYeqMExfNIuhB/LVN/ykQ2?=
 =?us-ascii?Q?NKZGkoxnpqRE0BI24fl1d0is8CcDmYwG/IOAchGD+8ePhXEludqYq/5K+urt?=
 =?us-ascii?Q?wpd6cVQQq1YA4xaaGzgjaaxcWzH1LNYqj1boXvN3SMayjEXXCmmoYHS77YEm?=
 =?us-ascii?Q?Gv3BoOQbZVVuutqzzREAxswofD8jVwcfSuX3ZNalKa1V0KBzQXeY9ta9TtrD?=
 =?us-ascii?Q?xo5GaKT9TjRAUbFd9l4Kr0E=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d42da5-7cb3-45ec-702f-08dc9ceb7b60
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 12:10:38.2488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+HQs4jsLvDsOJo2G5RxMC6xBaExBrzIdLUP4XRYspyecGVvFmuE/VmD6t7SqkaXixXyz1+AMSnAoVRG161PbIC9bWEoBPb5DZKlA1aHO1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9395
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
index 03907a12407..6f5315e0fb8 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -98,6 +98,9 @@ static int led_post_bind(struct udevice *dev)
 {
 	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 	const char *default_state;
+#ifdef CONFIG_LED_BLINK
+	const char *trigger;
+#endif
 
 	if (!uc_plat->label)
 		uc_plat->label = dev_read_string(dev, "label");
@@ -118,6 +121,12 @@ static int led_post_bind(struct udevice *dev)
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
@@ -130,12 +139,28 @@ static int led_post_bind(struct udevice *dev)
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


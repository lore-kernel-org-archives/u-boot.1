Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D8EC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 665E68856B;
	Thu, 27 Jun 2024 13:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="gzI31K3o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50FFF8855C; Thu, 27 Jun 2024 13:31:28 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 946E788596
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWZAvsY4BxdV81sJyCpWSZGLirkU9y9CFtx8U5SYY95P0DXlpH2TG4Lsny7M099TlK1IzTflvac4OiY3dRBT/eY1+q+NNnYxJeItUAywSzfusou2ThWurK7qoIZ7Uo1IyUqDl8CryYCVCQZ3gZLJfwLqcCQd4FntjtThNzZeLlqzHLDEMfKqj06lr85X1n9zHsNMEn2qmW1OYObd4iQXYGSJwEnIC6/otzP3Fkb/3I+FDnwgGpbMOHQDdWTTsJRSxGJtRTcMDWeOUNnTA/bvueTU/tBN1okCw/28geW+W+FwKdMPIcZhoLSxcZSZG4RlhVBc5KHtX8LLhnXRhD3lGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPqHyxV3RRXnAgh7tybLyQdfgKiBxUTbEwPkXpTKAP4=;
 b=buo0dbIqB55e8/FTZNFmp9zcq4ZfToSZBrjZrRpu26cCQ2lUNizq8mhD0OaBHPBLWQY8+PaZ71N//XVDA95AG7DL7htoMuj7hnjD2HkTeIoxNn6ubTTrbpgnsnGVoAZ17McxKcnKFaCqm0DnsuQB/5MWzzwJqmc8SwzWaAbE0egBz/quvVfErmNmU2oaTmKC1J7Pk4ARFGkwqBY7glTCvGxk8QeIpRtD1e3fBv6vBtPzaq+cbcyTFM+r5B8C8b2+Zln0jTQy84fBS0l0wZwdFuJT25gvmJOacHTWEVpeKhp7/SvAAybbK0GbLo0GcUftGyFcbq4z6dQaVBgpKi/q1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPqHyxV3RRXnAgh7tybLyQdfgKiBxUTbEwPkXpTKAP4=;
 b=gzI31K3ozaEw8NJkmUjj5nljZmYZ6FofFWjENFxFGESfaz3rWHM7hOZqww8IP4AvjpEbobGamu6dnJuxhGOcVgtr9REq2crePySDiZtmXtnhZk5K6mo2cXxAiL9k27GMinyo+uQdm7YkTBp28lVe7pkBrWsZ490ODL6gbkKLEeDICgjq6KoMJs4Ch69jJtWBiOnn6r064JIpm34AWmNDuc/eaSf/ig8gFEcYMF87J6gqelfyYpASpfqVxkIR/wFvXH4iFH8iYOACu8trZkgUXyC3HiR3RNCViDCtJ9YHxZXYAjkIF95tHecwcGVhMCKKak2Dy9h4suYw0iFPWhFNwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS4PR08MB7579.eurprd08.prod.outlook.com (2603:10a6:20b:4fe::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.37; Thu, 27 Jun
 2024 11:31:22 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:31:22 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de
Cc: Michael Polyntsov <michael.polyntsov@iopsys.eu>
Subject: [PATCH 2/2] led: Add dts property to specify blinking of the led
Date: Thu, 27 Jun 2024 14:31:14 +0300
Message-ID: <20240627113114.100083-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627113114.100083-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240627113114.100083-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0000367B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::397) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS4PR08MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d62e161-764e-408d-a342-08dc969cac0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?86g3SjJ7F6Wcxu23xWrIU3tTEzOtK/Sg21c2PPhBdUmmFwN/EQetfuOr3ZNE?=
 =?us-ascii?Q?vNwKFou+Q3HiZGogGOOKiE22n4/zz0mGeGbe3KsAFmTJETBuXoAzl3Hv/yXP?=
 =?us-ascii?Q?0w7AlD7ldpLdpQW94DPg28axzNKJML5jHFrjW8NowGlRpWsrtLZcsJvYK5VY?=
 =?us-ascii?Q?RXBqecS5YnWrMVR3mxry8NCPxFSojaJz7CsWr+KkQuVeLl5QcSRDWaT7bxft?=
 =?us-ascii?Q?5Dh0pfdKKYe7WIk4wso7G8FDZjAW7nKldjbtmB1yeYGuvrvKgxhTannIZI7n?=
 =?us-ascii?Q?JHUKMaHnU4NOCid7NhcL+ReZuzXta9gwg8QMv9Iny1glYOqTDZJ8aZxIuFgc?=
 =?us-ascii?Q?lH3OVa9bzqoo0TOV1klM3P9eig88MVU+Dk/f0GLXhhqVKBbl7fIjvz798Ux4?=
 =?us-ascii?Q?DHWvrYMSAW6g3JxzyorrR7AF+U7+NK1+Eyqa5sKSUeWQlmTfvo96W9jovNIh?=
 =?us-ascii?Q?EE5yVb2NkxlHaHduNa9beoTa1/djyivIZ2+cXveWPjBhlRzisencYZSe3zNk?=
 =?us-ascii?Q?Wz9K49YAGplGMfq80Rn9K+grPae+tM8JATvj00wapPqJ9FA74N2JyvptoWiL?=
 =?us-ascii?Q?f9aGwOA+G2+bYF3JDJx51Gq1/ZdhS6aKxS42YqVmzkcMqTovzh7ikC56EL4Y?=
 =?us-ascii?Q?Gkv0gKgyaAVcFrlKmlr6rdIuZFW+M6gL/GgQY1hUxwNC5FmUpocfKzXibfSu?=
 =?us-ascii?Q?0ztBy7in/F7H05ATe9ewcA6DDxDt9tbLEoRhmRSupPu2fgcmqpMXNvlM7HUN?=
 =?us-ascii?Q?hQ6FDW4Tyg9C6pQvCaSvbv2A5/fF1paOI3wkaJk8TTXN352N7OilhAlgMdP3?=
 =?us-ascii?Q?GgYd7lGSKkSZCIOM1mGvSm/nVjoIKHiFoqjGemzSDSYVHIH28kTeAOFFiwql?=
 =?us-ascii?Q?Ec4WLCeFLwU4aH26ZNxJYnuMcRxfrlvdIkxQsvsWaP9GoZjEfLNYnzaxUEj4?=
 =?us-ascii?Q?ewAhe4aEY6UNOVFVC1bqHEFvBm4gyqsE8JBHfPsrlpAjwSnssFEIlLMUeIvA?=
 =?us-ascii?Q?G8GMpsMyyuyaQjaw2iYvTi/SiJ8ErR6qI6v/C9F5xQY0ASL84I41/JDXiD4F?=
 =?us-ascii?Q?fp/TJIOLy//zTY5wdnoQXBZN819u7Aoid5G3Y6els5GI0Y7LEwch1JCY2Yht?=
 =?us-ascii?Q?SS269Jx9Tz6Ht47c2L4DLP1kZy4lc+jmiXRGF+52j59m6PHFtPcF3DSu15DS?=
 =?us-ascii?Q?p3/VdtVhMrgu4NVWq6mVsdzbOaOMeJvvNpWAwcVi5aqzuURUJZjaQ5zc9eq9?=
 =?us-ascii?Q?svuzct8Qis0971dcUsICPwOA40efDdCcrZ+wGsfc7KtEwePMhcNpHYQa1kMG?=
 =?us-ascii?Q?OOTtcwsu5IC+0V79iv2ehn5JIGAfuRKaPvdaWi0t/AqZ3o0s29vEqyymhEWR?=
 =?us-ascii?Q?1W9HzcH/f0hmVyZ8a03OhPFoPkN5gnCPmP7U04Vs7w3bbPMSPg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tYzf5pU2SVFqjL/ABmbXhsUoxAhD/ifL6VQ0fiEFgiqRA22YjZWhFQ0GUv6M?=
 =?us-ascii?Q?l6UOBh2bxMEzTZdg/BuNtubI/35Dw+pR3HifTZnR+FJGPoTs/eDujl4ertra?=
 =?us-ascii?Q?MoXqTs9EYIGTIcjtrmlgZc0t3nLY+rioQ8czwFpSRPdBoKyrzQB5D+WBKplZ?=
 =?us-ascii?Q?F0/Y3yGXn3rfWmii1vi+m0Pa1IKBhtI99aFhGZBgzW7Atl7uxK04ay34KJb1?=
 =?us-ascii?Q?HPQ9GyzSflQqaXWfzCu7MsYbTxEGp/RmT6LAM2Qun1Mk38Y4uvt6I5nG2foU?=
 =?us-ascii?Q?SlmpZwPzxswC5U+FWT8dH/3DpUSmHnQtKpX5AIMy9Jdwc5MsIZUo4seexEEx?=
 =?us-ascii?Q?fvGj53xIhtMeikzgS+xANZ6rBsT/a3E2tAK2+Evle+1if/ZfGNqkI7Usj0Bh?=
 =?us-ascii?Q?b27wj5G/1tJ/LfObU9D4wXGLUL536+I5OOgqSM6mZDefXoam1//buUcFmy4L?=
 =?us-ascii?Q?BPd4/Po1TFuHLCjGJgxr3xzc2pmDdLXnIL8WsM7OVwNBOkx4ZRNw0DbRuJ1g?=
 =?us-ascii?Q?bp0doKvHY8N7mTqJ5n/UTB8mz5jfWn/++kJYITrmsP6ElbFSz2e1y77Ys5FY?=
 =?us-ascii?Q?uKIbDkUPpc01LSGT8LwR8ydPbWiKskuuyJDKp964v2RlQyDkaGkQ1dRwtTZ6?=
 =?us-ascii?Q?R/QfM+y/o0KtmmIKFA9qQvlTiXTdVjKID17a8YKAMJlu++yBi1xDt/VOPlLU?=
 =?us-ascii?Q?JXxH94/lcRRKmd+ytNbKSAU+MBA7KLX8OJtMl5TYjWCUnHNey8z4XiLkphok?=
 =?us-ascii?Q?orRh+qMlOROHZTDQFeCFIhjeuwlpkB+k5XNPIm0m+jWG4e4/ERlG7JHSGjJI?=
 =?us-ascii?Q?FrSQ//5pTdG/QOZhlnYdOtowwOljbHkoHEE0am0odV/TM8ucjoD8+kuYfPmA?=
 =?us-ascii?Q?h0OPJEKOm1Mc8FDoJRAdNA0e0v8xIbPaFipZg8hllBAZsVS1b6+0y1NJirdR?=
 =?us-ascii?Q?ZIwqsyueQlO/3T4I5WjSsEXPN/ceFqg2BgLDj6lopSMEyueGvDwvk/eHnyli?=
 =?us-ascii?Q?GvI08eZPqDV3fpGSiX36dEele6MzoGmTef1blV1bnqEIzegMpz85LIVkjrLW?=
 =?us-ascii?Q?fqgarS6m8LhEytfFJ/WRMRG84HUuNuGyLeFjZWU9Um9ukVrZr10SnYXrL4mD?=
 =?us-ascii?Q?Z5hzx29XKKFglgfSFv0X2RVKuLA2w1ikmUpNbneymZk6y6SwoDobnVNgoX+n?=
 =?us-ascii?Q?Xzx5n+gjobaD/HWsds8BeM5MiEVN7yqIGEAYJHLzWggUYbIiXk7yj88+6rFq?=
 =?us-ascii?Q?YBQCIMsMldRq5yUHYzcwXIZMck7talQSJ3i4tPgP6KOJ0fHSAhmzrKZB1GpP?=
 =?us-ascii?Q?GgTjcvHE4YrRXrtoW/m90joVBToDlwO5h7V5K2z9NC+lEDzKxNkQdsvNwhcj?=
 =?us-ascii?Q?isZehAzuECy4vDCpWjAMsNoNGYe9PtW95qZRJgpehAgoG7loe0EmsvgKp3ht?=
 =?us-ascii?Q?HpcJE2p77kXhls+nqv47CcUAiSqBmOG31ehFqQ6sXG948vo64sFymf0A02Y1?=
 =?us-ascii?Q?uIf2K/sRVLmCnbwA2BySaIduXLA9eNAUqwwZkivWtjE+mKtjNJDNVIBMLrGU?=
 =?us-ascii?Q?+2GIqAtz6UKSLOJmo3Pt5+hCCbBtMy2CeioKhU21toNyS9ECGf8rH8aJztu2?=
 =?us-ascii?Q?D52YpGStLxDaySTzWkYe3B0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d62e161-764e-408d-a342-08dc969cac0c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:31:22.6900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnYdFxCvylm5twL7exBdD8pfAubuTcDeCd/g5nOsUvE3csXxHs5xsHzp7Fc2RN90FNzVdgjg6z4cOPaNcNNRIzf6ZvtiBndmfQ8pSL6w3gg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7579
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
index b35964f2e99..645d0069efe 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -271,6 +271,9 @@ static int led_post_bind(struct udevice *dev)
 {
 	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 	const char *default_state;
+#ifdef CONFIG_LED_BLINK
+	const char *trigger;
+#endif
 
 	if (!uc_plat->label)
 		uc_plat->label = dev_read_string(dev, "label");
@@ -291,6 +294,13 @@ static int led_post_bind(struct udevice *dev)
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
@@ -302,12 +312,28 @@ static int led_post_bind(struct udevice *dev)
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
2.43.0


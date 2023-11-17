Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F401C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 11:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B7C2874D0;
	Fri, 17 Nov 2023 12:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="W1tIE96X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71F81874E4; Fri, 17 Nov 2023 12:38:49 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::724])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6904874BD
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 12:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaR/a/+paojf7oT9lhytzQz5HTc2xhaLKQuggjrx+KyndMXuz+KD8CSGdxdOS+wZE+TDxVyl+PHbBXLVjDqu+EA3SmZKpkkOPI4LfE1tEf5QlvNoON3QpQQq9ABtXsJtNgwkvrr7CmZ7NSfLyRpD9eemEmY5Vz4Jjd66QmF3xoIFjwK94zcKq5IFp4rcZQUL2kMSJLcsvOPFZYVu8JU4Pnef2pJ0snYyuR35dWWKauRtFNJO59+Rf0oZ9TfoTT4Gw0FnjwgEEccjFtQg3voCO4Bb73/eKFsqJ5VlXM0SzQsZx8LRz7ysW6Kd2Mu137jllCW358lUK2MJ2tqOBp32Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCveA8WW3uyjgCw7sF9lnTfdzi/bZH50W1r1BQrFivw=;
 b=E4+0oIMy9tnhlLIMnI/00z313G6qNtWTINKMvhAgGdbEmDhxIb2/G4Gmiw0fAK6zw8BKnDB7cTMdstSOzZNkj/QQHhARDjod+mzW9SC3M36R/I1MOsduB1PHWrBxkJJQ2kUg926ueL23UI4qa1ZUdX//pt0lDM1eBU0Gyqsp2nTDMaYSfkihtl4AFGWlYqy/3U+YQMp8kh/APhZUNbuKbYjpms/AXCDsl26aOzdN/yEz68R3uADtt9mwP5kQAc8ctkHyRsclYnu6Fkjow5kVjf7wI4rpPsF6cUwNldSfnLvwzbYUlRRGTrMUuOMKWGal1NQ1mRAwOUyns0w2hUcPTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCveA8WW3uyjgCw7sF9lnTfdzi/bZH50W1r1BQrFivw=;
 b=W1tIE96XvxDx/DMBGOszhXL8Kvy+HmWS676BUvdJrry95U9jHP5bk1TC/Gtv7SN8ToaWyS2OOHese+8FfBciVBq0S4Uq3COTHhslpScv00x7OTKsNIDdHx8V91ZMVHS3xdAzjoP4vNHAcGtwB+PIzG3ZKNIsoc3OcssiFSLCkoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI1PR10MB3664.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 11:38:25 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15%5]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 11:38:25 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 5/6] led: led_pwm: use led_bind_generic() helper
Date: Fri, 17 Nov 2023 12:38:10 +0100
Message-Id: <20231117113811.149329-6-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20231117113811.149329-1-rasmus.villemoes@prevas.dk>
References: <20231117113811.149329-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0000FA93.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:4:0:16) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI1PR10MB3664:EE_
X-MS-Office365-Filtering-Correlation-Id: e90b910d-470b-4fea-b8b8-08dbe761b5e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wnukOH96M8ukJ/XEAWnjWjT0wpNFqbb94AbRNQayrSvTA4ChQI54OhYGGIPNoNaymUh7wCMBpAJuLQdYBVQcb24593X+TUfewymMKNAzS5eJVDj/0O9KdkYbItQcnSH8+Ybty8p5HM7unlOxN8TlFw3r1m7RebiW22wBnaV1gte+z6pOl7RY6AaEB3MnSNtHGcuOSqgDJBZb4d+pPMRHdSMZ0jmRWeDkrsy0CtxaeLiPw8Un6Lha8A8lvL20rf8qrvAIp/NX8cZibSRQawuIigO2EHL9qo7HCYUQKIPyOv0Ebx0Ppj0/VWLYXIJfIEadXQ4nSsotqBxS9zAOxxN2sulFtg7PYM9n/4VXcpmcYnAEXqGctPCWcAVs6tGqS6Na9cFULjFiDM21BDhAli7dII17uSw8uPDayav4AUs/8x1aTY/TfXaIbFoWEUe0Nqh3RhP8RdxAPkxlIfTI0pmCm9UlWSZh0J6mJWJaXs75J2bi2T6LTM+V5OwWKaSyhoKrV+Ikuk0eEN3wZbSja+7bfU9jPfwBPPuZ11P2WAwYu8f8QGo9gzGXW2bSMuPZkKfgg0nJULEhvuO0UPit6ZR+DDZ1c7XUtfAna30btKKxrZVouNbwGg7lUU5ZIP8qKRSdSH6Jbo3a5YrsLOLJwlwwuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(39840400004)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38350700005)(52116002)(6506007)(6512007)(36756003)(6486002)(41300700001)(8976002)(8936002)(6666004)(107886003)(5660300002)(86362001)(1076003)(8676002)(4326008)(38100700002)(26005)(2906002)(44832011)(83380400001)(66476007)(66556008)(54906003)(66946007)(478600001)(6916009)(316002)(2616005)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?neKuUDNowWTmEDiw7peYhGOZHyCoO4kj2wJMjXKpxFaDiRTQiJIBMF/FZKyF?=
 =?us-ascii?Q?V8Vf+ApfiLsc9jTEoGMS9wUbOBtor8PhMYB2T19Sd5iMgiYLQ//K3DxSEUQk?=
 =?us-ascii?Q?8cPmTII8toDPAt6ddfL65uVX6jMv/f0NY9CPq23EHBH1ZWTyj4lEnwfBtUGJ?=
 =?us-ascii?Q?ErM63NrwawZGrrbzsbVo3f1yFVWJ8KK6dsAJEDOhnYuzjXmPWzS1sWFGJJd1?=
 =?us-ascii?Q?7nvpaGGQpzBC5Ggk9yjcaNw0LB6Lubo5/YZh7+56izSjAfjiUEV3Gat9SOrl?=
 =?us-ascii?Q?b0vkrC9ufnwwqgGih7LsW8UrdKD4f6z6At18AhJfKZYKH9vM/YmMYQ4+sPN/?=
 =?us-ascii?Q?TvgaXTaWZQR9ALgmmSOkdlH2BrtETjmGzd6MDOK1gWJ0lPoRG2rlbwbfxTfw?=
 =?us-ascii?Q?tdBwGWFVHIaYG6P0xdvTzreoN3UzS38f6m9NqK74v3V5XM3rnS0ZzPjDyghn?=
 =?us-ascii?Q?5/XilfxFKZ2rDDZvyuHX8CtoaqlApACEMVK4se0UYf7+AmbOqyy8wdj+NWwQ?=
 =?us-ascii?Q?+Du6usDNrwNAik1M3gLW/TGuGPYRzibeTdgcFkpF9M1h8j6MdwCl+ZiDoTzq?=
 =?us-ascii?Q?D7MjyEkU+xZKKYOs8QT6UkPeJN6d/3F4bZMCWf7fl0geZrSHPWdj5DaYuHeK?=
 =?us-ascii?Q?o6ym3wYZF+N7FTVvqwRMaE0JX06PpKV4Ne22nWoNAoxQ4GjB8XO8hnJ9zFGj?=
 =?us-ascii?Q?tnjW3PjHyaHV6W++g8e4/zKBulOGIgyF1KscUqfVH7XBnsyq7baYPWruxydN?=
 =?us-ascii?Q?w+YmSJfrJS8qiqy74+xpv+anXbJEvf9qHeaQ7s9XZIKci22A+A7krBGEt9zW?=
 =?us-ascii?Q?NEfkWwLMB3x2+5VtZILTrsj5qK0RXSHNjdFJbp0+cruHHxZYNdUyEezJwRL1?=
 =?us-ascii?Q?HfjAJzTk7VTNk3+n+2YsU3k8+g6cpf4AoZ+3YHL19++8ehXwQAglAIOrtRVo?=
 =?us-ascii?Q?mpAsHUDUR4dt/CK72kNVT1rGglk/dmtQWWN4Pn+3IkrAFs5c4/20Hyv+PMn7?=
 =?us-ascii?Q?+4EsUD1U3YXf1SKnv8w7vLrmjsP0/tichumNOl05YRikvMElWgEKcPHIFXbb?=
 =?us-ascii?Q?GEwb0MPxu7j4e/BnejxHVu3eqNzAOwOQcb+oynZGYwmlmwZvODHpdps21/nE?=
 =?us-ascii?Q?5ZW0ZsCwwRp1FIxL0x7+XueVUJhZYuTMXuCBNkfpV3FM1MlLASuIE+MoE44S?=
 =?us-ascii?Q?hjlbohKXWZ2VJBPUm1nwzSNym+81urbCKh8c80Qv89ahM0gW0Rt9TjthfoXj?=
 =?us-ascii?Q?6IPT6hhPLkrkzxukzB3llJ0BV4bo3ROltimVYoYygnEEeUTfOmL0WbSRGTqF?=
 =?us-ascii?Q?R66Lsn+YovXU1CE3msHhkHneWQ+LRNIkBdIiWPF54AKDNNsUURpoYNJi6ETE?=
 =?us-ascii?Q?Lz/gt6ytHx5HCwisW4fdMr6kP9TdBlGZvWpVwy+92crqNHafJAsklzx4msIx?=
 =?us-ascii?Q?BbyFdPSGzvPCszSnj1VECfwfmJrbp44GZreO+1wujfio4y1NJxWL1vnupH7A?=
 =?us-ascii?Q?pCrBmznYsFQnweVzc+lc5p9/IoQqNIli2OCpp5UHdB9lATGhSDyo0APoYa6O?=
 =?us-ascii?Q?aZeBoHIf5YKw3zq5+Fr/bbDRqPf75+Z5uTT5sZdVq1eSQagCdqJKtyoSPr8V?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e90b910d-470b-4fea-b8b8-08dbe761b5e4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 11:38:25.4088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHBhcu2R8hmNbepTU2nf25oa+LFpJwGtVbNNTRpDYghQ2Z43O+goNI3VLoUo6SiLUwptvm9217iuoVJfjbaTmbCl4kyT82/ltDq/ahDO3Kc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3664
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

Use the helper led_bind_generic() to reduce code duplication.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/led/led_pwm.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/led/led_pwm.c b/drivers/led/led_pwm.c
index 7c8eae9337b..ae6de3087ab 100644
--- a/drivers/led/led_pwm.c
+++ b/drivers/led/led_pwm.c
@@ -9,7 +9,6 @@
 #include <errno.h>
 #include <led.h>
 #include <malloc.h>
-#include <dm/lists.h>
 #include <pwm.h>
 
 #define LEDS_PWM_DRIVER_NAME	"led_pwm"
@@ -136,18 +135,7 @@ static int led_pwm_of_to_plat(struct udevice *dev)
 
 static int led_pwm_bind(struct udevice *parent)
 {
-	struct udevice *dev;
-	ofnode node;
-	int ret;
-
-	dev_for_each_subnode(node, parent) {
-		ret = device_bind_driver_to_node(parent, LEDS_PWM_DRIVER_NAME,
-						 ofnode_get_name(node),
-						 node, &dev);
-		if (ret)
-			return ret;
-	}
-	return 0;
+	return led_bind_generic(parent, LEDS_PWM_DRIVER_NAME);
 }
 
 static const struct led_ops led_pwm_ops = {
-- 
2.40.1.1.g1c60b9335d


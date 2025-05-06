Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCECC3ABBF
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDE7282B00;
	Tue,  6 May 2025 16:15:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="BNpHwFgg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4D6482AE1; Tue,  6 May 2025 16:15:34 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC03982A4D
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbxdLl4E5Wey9q0XcynJdEnBHM6IBzAQz/FvycNF52rlc6YXECTUgiUTBUL2ZY0rM0P6bU00/YG41iJgSA5dFkEGDocvlkEa6ZaLNhXRN2nozYwbl5h2eUKIn7TFXsXryIAZk4ZdSgximdNbOxT6X/9nADlOiJDSgBepeJ3V6Mej7DzeLL4gsHNvrcatkUpuYMFKKWfepCGCvDyUAL4jzT5a0vvJRoaVH/4Cqw9oXg93AqQxkhG1NniLDEFXewgK9tiOvKjtaBKXh8gYV0dN2NLuUNPtMY7nKrgR43NazsTMlSoDXXs5QkhZCBon6IQT7kv95tgzcpzP6oo4bBE1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7v9Q+8GSpxr0U5wvgup945hXD/XUAHJT+mFOwPLfYw=;
 b=xFCtenz1PdBSa14meM19B+pb7kEAVwB36EaHZdgH8kpIKKLkj67of//lxGwMx8IIUceNJRuu2EZo6GfL/9MMKjf5qPNUaZwawAap03NU345KWnzQL/zidZSbA+2wIX1xmzasL8sW7H2/DWGMi8tRJIlbOoO1r6uhrr7IfAHyYWJj/ihvUrpIZ5BnmmTu3S/JntFEqrDpDmY/8oumfbqtcc4R9bMEm95PSoHw5awn3mOAXOfamNaw1mS4P+Rwd9NiyVP3gjivLE8Js/C5dqtnlYAJD4EurGx9fgR4tbePWsrZcWleEMyMLpKc0mZqtaCcPS8iyZZgRawM97Ilffs6oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7v9Q+8GSpxr0U5wvgup945hXD/XUAHJT+mFOwPLfYw=;
 b=BNpHwFggpRPkPBHKTKg4g2rlb5bLaHmMfjJW8Uv/GMrMCY6ct9LkcRGNk1zB9c/YUMZ4/OZkAQl0ro2rujyISmqIO1JnYMT3RZi+3Bb2R32dEXJIagX7gb0b3DyY3AO5ZMxl2RHSsrUYu9Q9glJP3SlCUNUOIJzCpCIDoJ4pO5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ca::21)
 by VI1PR10MB8208.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 14:15:29 +0000
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769]) by DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769%4]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 14:15:29 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 09/11] test: slre: add test cases for escape char in character
 class
Date: Tue,  6 May 2025 16:10:33 +0200
Message-ID: <20250506141035.385756-10-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506141035.385756-1-ravi@prevas.dk>
References: <20250506141035.385756-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0046.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::20) To DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8248:EE_|VI1PR10MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 02bc5464-6b7b-45c0-9544-08dd8ca87464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7ezKzWwqUje0v5MB1rDPX8xQVBTF4a/Dehvlhe5QzuAYaf5HC75wRL431NZ4?=
 =?us-ascii?Q?ZkD/xIc66zNl1bI8rRSD6s3h8nE5mejIqqyDRXqovqtfe7sseItcHyaNFgJ2?=
 =?us-ascii?Q?l/2UQvOhnBKy/MhyQMGjvznTXlje7m49oxYz+4wY+JLWasGXGHquKNqbW55b?=
 =?us-ascii?Q?fgMZUOLBnpCL9st2cPRR3vJFAirJUlXbvKIyjoRRQtgzd7ynGqRNrlAMZfdv?=
 =?us-ascii?Q?dr7vr2FgH2LnD6HBH5/0cNAzxsdrWIOepXIWDpesMFZWiqnN4fUn8P44V2vt?=
 =?us-ascii?Q?xY7/KYkR44UlI2EqP4toLpJqtbCUN5VRNJfPozcz2rQv1gWrvxtBrWLzAvWU?=
 =?us-ascii?Q?sFh3H7Iz/4mMI+A3oxIiO5Cgd2YKD6+Cgbg7FBFAH/tNSCGtLT3euqTc0RKY?=
 =?us-ascii?Q?faXYznphbnZ55Of+8TTGEUPngvQaccFuNWYDL4UBVH/xUKIq2yN0YtWOpCy+?=
 =?us-ascii?Q?z9XPKja+hKMf9UEHkGvuTaV8ewsc/cdBUm0ZZmo4fSqWCUC9sE1CC/mB7tTm?=
 =?us-ascii?Q?QcJhvBDE0V4r7T9MlxfdaLbSGadFMbjneHlaf6ve38xtpLhlJwmSqJmAQb3O?=
 =?us-ascii?Q?btjXjUl+vkiyACuPVMOzjimDV3P54tILSX3T3Gov65jMjNawo60iqCddURJ6?=
 =?us-ascii?Q?W2g6gr9odqsIYD2PZpHjuGU+YOFyIvU+BOr6fF0mfJjGhCogWNYzB2TMTCwn?=
 =?us-ascii?Q?cmOdV09OCd4UdENQQUTfvHywMao+E57QCMgpBeh1N1H8lKKnTXfQpKEK1RFa?=
 =?us-ascii?Q?t5Cg3F3KGUU9D1T0NP7VOwtAoPbms06r6Lo3e/DIRs8qZxVgkEwt/hJOdj6i?=
 =?us-ascii?Q?3S5YcI4V0ooV6IhnK9GqaDDAZh0TTK/4r3LOk6ymOmyRsQLNUOphpBFSPaEn?=
 =?us-ascii?Q?2iezF+FJkd61ekW5GOQbpXiq6KUHNZK9oJbkSVpbd18xftR+r3HJ0DhwsGBv?=
 =?us-ascii?Q?HbcsXBn1J0ATbEqh04wIVOelVxKrfI3UKhfCFvTJCB7Ejbsj26o2IvpJdqWD?=
 =?us-ascii?Q?KU0ma5Mzz56UgMNuGYBI/4/KzlHtcLRv/NDbNJRdJwqpKfauE90Deb1A+5tu?=
 =?us-ascii?Q?csHVq0sS+AjqvgE3EA80rDwOE0WnIHaWRRmZf28WAI0BP0lwCDxkUrmRqsMY?=
 =?us-ascii?Q?aOlkhirYlwiohUQyX3U/C+brLI3IPxbbNLY7fSFg7SoIgdcOfhawXmwzihnK?=
 =?us-ascii?Q?4D50y9eJJhuC6S8aDdPtQ/mdJ1Oeywqf2U0q87AzSdt1v9LRJeXJF2DERsRr?=
 =?us-ascii?Q?Z4RSAKBupCmlVwd0w1kMn2Jly+kU4gUfdHF/D2oFHy4JoZvq8g9AhCJJUHxd?=
 =?us-ascii?Q?W4Qufx83cn2CQXz+ld4BBfxPGjLPZFyOn5rFw8ptVv/Km9n9FnScoLri58BR?=
 =?us-ascii?Q?YGyK18hSai5J0xhiQ8xQE7d9yqBkL/B82YuIPkoK8DurQLc3zzGhbm/ichox?=
 =?us-ascii?Q?eq/bvMIcrs/zZEFymDxaYI7PqOKchx5F/RGJYj0OJe+Q5ji7hCAPMA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+UYdd/3LCe770Poou0OY0lBeKN15ym9qpgo0+0j/u3bZvlU+n6WA3ZRB/FcS?=
 =?us-ascii?Q?YQsibdB9t1JHeI5to34DHv0hNYEqTSONS58DngY1/twf6M+mh2r+H0s+/UDF?=
 =?us-ascii?Q?2YCkgpJmLARmQK0lFtYDm4gmhNXK5jG+i2A54QKkPfsFEJSO1nCW6hh+hU2q?=
 =?us-ascii?Q?WQyBvSCBHNZE4GiSlAQTgvVt1IRVHJF3CmIOs/Z7Tw4uv8hgJZaIwJElekvp?=
 =?us-ascii?Q?OyopPpgwru59lCdfmKlisY8D2hXNYXpFRpK1s2CcarT2rWcOghkOLQevo8BT?=
 =?us-ascii?Q?7mcJMGlgeGpNzw81tXM/JazbBCzu0DddeInsC+NzdhcPD0XHiRUMXkht/JLi?=
 =?us-ascii?Q?nTK7lBCsBtVJ0WZGQs84dTigFnb7zbeZOUKOJfxo79Ec2tUvmZFXt1HlD1Fj?=
 =?us-ascii?Q?kdpLHzw+ICJdxcPWNKwAynXRYpemr19Qh4EwHfU1btBhX81YDtMQVXWV0ohf?=
 =?us-ascii?Q?colgV51v3oHrDe+se1uNi9V8mSFTR68k7SQPDDZxxNC8o9PuSH8YvW1uj9Nk?=
 =?us-ascii?Q?ZpDdGIfBrHo404D6mUir//dhQxTpZiG51YzLBgVaJQ+5nrikWhApFkGFQ4LR?=
 =?us-ascii?Q?2XwlaLN3BDvMgTpEYJs8Q5jjcXAq+fuGWuXasvYYhYg1NrJ6v0aqv+o0+S3R?=
 =?us-ascii?Q?1ziLmIIVh+Pe2mUHVOR1IiuCEihHBAzRGK41jFLARVOHts0aRWog0vvzlwSx?=
 =?us-ascii?Q?u21r1f4qhbayJLmX001Hu4hhfEILiU/bvLdnn7aQLp1UvZyqfNeI6UupRnUe?=
 =?us-ascii?Q?e3QLBaAXUE6rJRCsCfAD+hvkkpKeb13xEUh/HfCl2jn3t3Ab/Hf5ibaB9x9o?=
 =?us-ascii?Q?MLNL2Z/7hcRMPfd5nci3hA9BYZVwgaAUFkaxReU6c6sKyGhXntFMj8ESTsV/?=
 =?us-ascii?Q?dS/88JgM8tglPzZJvA0VNWpdsg8gMAl8XGWM0aglwh+uJ+Nu/6dUaORbVbxE?=
 =?us-ascii?Q?HQODqcMAZ29PEY6QF0+RwnflsEs5xy2+BBlq8a0i4mvQfF600v7FPsAG8Slk?=
 =?us-ascii?Q?DAoqyu2Twit4+57JzylrQFlJGR2OcYRTk/rfS0SLsfFPbKvcFE0OuG4OFrju?=
 =?us-ascii?Q?nbs34UMwVQUqlnrGVqaAetBe6vpykNZpF1zwujtMB2HX67Op6FA8E1BfcI17?=
 =?us-ascii?Q?vaEYSlfsMLpxCmWaq8qucKoBIMUC0a+ltzx2u/l6VhlWhnmoiHDXTspXDeiO?=
 =?us-ascii?Q?SIGa9PA+zUmmJTSFNJfTb+lltaXB/PTRcsBzJ27VyoU1MTLV/tDccwFMIc80?=
 =?us-ascii?Q?gV8obpeIzxJ31colypbyjWs9a+TJn440cNXp8k24fpz+OcyR09G5s+EktyQJ?=
 =?us-ascii?Q?ZnRbJve4AXCxNyuNVsmqS4m1mJslcGwCHOyAF8DsVRwrjYzY18vqej64Eij6?=
 =?us-ascii?Q?f0rWuYZraqIvVKUeiPJ2j4syo4KkLXnM5F8N5QIFFtTPYDrsu6fDaP0ZFs3Y?=
 =?us-ascii?Q?7sXBMncSOmzvikbFXujw3Lr2lG9S0+bsLmtdh09knGFxf50u78NuG580d/WE?=
 =?us-ascii?Q?W6zdXg8vYm5piRlLBwiCkzNcw9KJ9+j6IQs2dm3ADNGFcxZjFtlVc0xysjED?=
 =?us-ascii?Q?EWwiHYDa0EpvxT4l659rEwIrx6JZQLUJYxFpIH7KVlPmXswUhWroEHy1MlqU?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 02bc5464-6b7b-45c0-9544-08dd8ca87464
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:15:29.3464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hceofQfYwN0SnXG7PL85yz3EcghugDF67KyG8XlXmt7u4A+HGiwQ+1Dt0LlbxXlel+yUDGEAPpXIVxIV5ikNBSzep27RJ+H3LhgN/I606EE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8208
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

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 test/lib/slre.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/test/lib/slre.c b/test/lib/slre.c
index 9b41ea92f38..053d046075e 100644
--- a/test/lib/slre.c
+++ b/test/lib/slre.c
@@ -26,6 +26,9 @@ static const struct re_test re_test[] = {
 	{ "Gadsby", "^[^eE]*$", 1},
 	{ "Ernest", "^[^eE]*$", 0},
 	{ "6d41f0a39d6", "^[0123456789abcdef]*$", 1 },
+	/* DIGIT is 17 */
+	{ "##\x11%%\x11", "^[#%\\d]*$", 0 },
+	{ "##23%%45", "^[#%\\d]*$", 1 },
 	{}
 };
 
-- 
2.49.0


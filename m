Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D1CC27C50
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 14:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB415884C6;
	Tue,  4 Jun 2024 16:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="W3L/798e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F37884D7; Tue,  4 Jun 2024 16:27:56 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on2071f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::71f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1139C884D2
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 16:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4c+BU7+fB1X4rwx20Vbe/jhBkyhT3sNyt7XufYPTp9R0ZuCXD3u+RYG/JATExw/E4DIGonjM5kfkTaGLCQI/Qg/BzHztIPwnH/PC3ntiSJG/d1E9kdJozGDzb2CW9ib08pbHYXEEsCQji+fhL+5V77MghTbisHhGU8B5Z8i1036aeWvxAIXSiISP95XvozHJ8sMfbn97WP/ZxIsoZGsj2a3xCao7ga4KJT8jcV+uWi3SWg6hb2mrPxi6pvtlPqRd1x10yeMJ/H9UPhqwGDaYMQeTEkf7QvhqsVrzD/OtjId6Oa4El8Kc1KjxxOna/OzJlD5UR5Yxntg5X1TkASeXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wliZlrgI2jnURe3HwQsYPZ5mC1kZUiimR4ZIUWZrrOw=;
 b=X9X6IGOgPaT9u9Cyo48chmd9onI4E5flvP3SENBgCstku6ihxpG5vXnMR/4ZaDWMEBbCRVZkrYcBna+JDYVIRQy94VzR8pK7kBV8tDal6B5mPMT4EIWv5JAQzLVowLyk3sw/APkALKkMU6Ln2PRQ8npFGGJ8QhUU+miIEUTGsptZLywbOLp/0b/qNh9N1okoUGxDrdb8ZpcsARbFvMISkG+BAuqLZQIa8ieghMSEqerNHr0d0KaPxD/AaHhZUqjcSikkb8ar4GQ+7MHKV+UtepOKXzoudZvfbkLCo0KlbQTC2LwIgO6XeoYYdSJIrOuriejN0TaNejPd/2/yPrFmmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wliZlrgI2jnURe3HwQsYPZ5mC1kZUiimR4ZIUWZrrOw=;
 b=W3L/798e7lHyPG65CmKHUYoS0kl1neXWXWTAfhG9SjAsIpTv80a+Kp3LGIrBZXhIm8G1bi9kC7JJHwGkqT3HzomG7i0VyLnKMmWrNL8JQLkTYuD/whuQNHQp+HAFj2xwtyV+X6CzcHF6U+nBs4ZOgNa0Vp/3AeNWZylO88WB9z4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM8PR08MB5827.eurprd08.prod.outlook.com (2603:10a6:20b:1da::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 14:27:50 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 14:27:50 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Bryan Brattlof <bb@ti.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/7] soc: xilinx: versal: Use zynqmp_pm_get_chipid() to get
 chip revision
Date: Tue,  4 Jun 2024 16:27:37 +0200
Message-Id: <20240604142741.425307-4-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
References: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0308.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::12) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM8PR08MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: b194fcad-9270-4c6d-fcd3-08dc84a283a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|376005|52116005|1800799015|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qFKpPSlac7JfoC1YIVwIE/XAZ8gJJ0q9yhJDpbtJu/KXzANFfv9gtkyiQyoq?=
 =?us-ascii?Q?KYTMi+1Er5x/SoiJiv0y+aBhfO5x2zz9J6eAwlhPr6WglBzk0O4wxAZD5lJ0?=
 =?us-ascii?Q?nQAFVGTj/AV65/MIAOD5dHQyBKUqARARJcNwEUzQA4vqgdPyvhaXVR/a7aB6?=
 =?us-ascii?Q?RbMRm55vTvZZIX0oGkW8DQdxeyIE+65YsQoXxuqVNytlH0IOz8PQkn+qIuLy?=
 =?us-ascii?Q?ASVw3MhbBcHfl4qtyNVa59KQ31qLMvD1HbFgp6/tYQzyk5LEyFaOElWAHzg9?=
 =?us-ascii?Q?knizXi0b2iAAJVZEu7rQdsOTCKqCNUYv0rHKOF05Zalv47bxmVKkECvIrPea?=
 =?us-ascii?Q?gi2xgvdq/G9mtIPREGxhZnk5NlRJXhx4Aan/bCycjvMZq3w99RjhqyFh/FLU?=
 =?us-ascii?Q?V0Tvqit793tmemMxf5S0gW/bQiHMzXYljgDRl4qSVRfxwryiXklqkTlIlazY?=
 =?us-ascii?Q?5Fq5fn14PXKBOTy60PwGsmKhG3o8EQUYdGpiVXZMN27cGkJEu/iY4e4uOxQ1?=
 =?us-ascii?Q?JW7HP8GVGRu9Om/0gRG4E6+qNPkiH2MuG6c6EQxW42ZQ2XpiNHcDCoPXfj5E?=
 =?us-ascii?Q?QLX6UF/uNgE3257T8UKVgbLSCmUiPVS603TvV0ty+JRL1iWBTiC+m348qn+2?=
 =?us-ascii?Q?NFUCTgAJGMh5a4lWqnmw4oC5uHFj+9xsS2FmQL/QzAMyFrtF8UBJX/U+loKw?=
 =?us-ascii?Q?QR/OASLUMTl9uakwpKojxo4QTflliCMY+z0IejFv90f0TVBX3fsv67QcAXx4?=
 =?us-ascii?Q?7BQHdClPMnnPgFMMuWVvV7YHQekZlsdqcH6VfuG5VwvR7T3STzYojXbt03rT?=
 =?us-ascii?Q?DVVncKKWducM12LcRLLh9/qU7BVJooqMs/GqXdyb5AxYGMrODf/INZo3E/aH?=
 =?us-ascii?Q?sfVulBbVqTg95ENz9zlPfeXZYLJJm9XRonDbX01GhrPnHjItbGwiR9dbFZF8?=
 =?us-ascii?Q?ggA6ezl0jOPcL84AGR4R68x3QFRPwHO8a/3g1Ow213OHKJyHL4g92mGJ8nx4?=
 =?us-ascii?Q?sOfRaMRC4OQEkO3g4bRrHIrt/E4RG9wGlhO4jhu1IQUR7bBcT5jOyCcIO14A?=
 =?us-ascii?Q?19x+5DPWqCkzoDtugxUWs4OXQWuTDHkuLxBTFAgDlg3etZ6yOMuM+W/bk641?=
 =?us-ascii?Q?lm4a4sPkiodmlrv0vIdBCXLoBaw8p+Q/DgLzN5HzlQzVKbE5CvQhcy5LDG+s?=
 =?us-ascii?Q?qzQtTxrS9f7CB4zLwzpP5sS01v2n+1//sF99Qdy8MMYLL80/Jg7eHnnHdXqN?=
 =?us-ascii?Q?kAoJnXrdRf2ruDTOc5sDTBQSJePteajf4k9V5GJNzI5YD4wU1HmG7lJAO3vk?=
 =?us-ascii?Q?OZTJOhUipRCmduqJlhBoCU1AsFWZf1ACBEegYpPOE4BPK5TTswafMlCiFNDR?=
 =?us-ascii?Q?oAdi+nw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EYsAa4cmzURIM7O0P+s5fYXD3+jBy0qXn5ideRGkMVyjaoegDxPWbnfX4c1l?=
 =?us-ascii?Q?gSeJLxwch7Oq5zWcO+dPYXKzBlARn3imYq4JObLZ7PfTKkdu8eOaaN9l8JH4?=
 =?us-ascii?Q?upq1hEhwxL/8HtMqWkYaDa3fAo8AE1fa0+6RSjjcGSziJY1ra/3K/xHwUai0?=
 =?us-ascii?Q?NStj2Y6szr3gjAtVQu/jMRIMr3NXcSh6wCBFl4mB1xcDkOJ8ywpSQJbAIb2g?=
 =?us-ascii?Q?QkvbHiJBp1APNiuds9Snn7DJYUgJ6/3JjcKMJjkkD41euANd5J0ZtL1erk2g?=
 =?us-ascii?Q?yLKbVkkXhOKFB+MKTH7KT+pG0N7cN2ewHRcDbz0kedFzMrwg9E6U88g1vMr6?=
 =?us-ascii?Q?KGZQ0373DeISkIfH8EhYCti4g1Sl3UvbyEnfRRj3v42aoJJ/WPph/UGce3KU?=
 =?us-ascii?Q?kN3ff7+IsU89gGCgVcYCjZiIuanq1DK0c2upcoYKzkHog17FWEWBvE50X7HN?=
 =?us-ascii?Q?l7/9t9/01HwA9LBwUhdV1UPKvrANuyJsJOLwY9M8VGgnQYf+fVoFrQG9EFyU?=
 =?us-ascii?Q?KLjRlcdNcxMLhw8Exn/+1ecORT8cQdPm4xM+F2rfqRsZAJcXYfgYsYEEWeu8?=
 =?us-ascii?Q?lZ78n589eyuglHcUcsF9LvxIPyJgqCcu8EnhIaWj3uuXOnvzLdceYvNjjJQF?=
 =?us-ascii?Q?Lvd+5A3S5GMOZVvzummUffTaDYxS/5qLY7VyiBHSZtyovga3C7cn1rlUYz90?=
 =?us-ascii?Q?Wm88+QT2TlYqjLKuyOnAFfRzVI9Vzsuw5ZOjLdLf/dfiYk34p20X3HdxVPI3?=
 =?us-ascii?Q?/vip7pDSWLAgbaOg13muEoNmTJ+h9c3uvvVMlyRqanBmSmHgoF6uHj6QKlJs?=
 =?us-ascii?Q?N5e15tdzujqBPwOwZJ2P8i3qLt1qUj8We4hZDohR1hX+gEbGwEZNZQG6/2Zd?=
 =?us-ascii?Q?BVPJoOKRc6RDLD/+7oP2vrX+kpKOjDKaMsdBaRBkJuARpJaaIl373zkgTXT2?=
 =?us-ascii?Q?+csC8+RKWGANS3Rj30tXgUwIg11CLfksHpI9RmLVSmy4Yw6RYe8fLzRqLY3p?=
 =?us-ascii?Q?JWvbt1GuJhptUd5R4c2CWgqpE6x9OrC5tGPD1l6XpSTtDo753vlk4BbdWrmr?=
 =?us-ascii?Q?NG2B/0NKdnG3uvEBb/xIMLVPWLdR1Mx8RgpbqfiMNPpsXwcKlotsvdEyVd8G?=
 =?us-ascii?Q?YMu7RWSO+VxcYQ2czQLVoG2uDFhnXZiD6SegXxVkwYc1M7jPZkCrYVLY+UOa?=
 =?us-ascii?Q?eXBWuWwL0yPGH6mru6Mg2KxmurzsePGFTzakQS339RXosie7MwER6ie49xJc?=
 =?us-ascii?Q?YXyrlmG8GDNkJx4mkUEzugfMikB68NCese/IHq+/MhfvuektSOr5TeL4+eu/?=
 =?us-ascii?Q?KpLlIkwtc3/NxUndaKIQslS2zac7kZWLrLx5w2N1TUCjh09DsTG+IabEuFC+?=
 =?us-ascii?Q?9+Uw7RczpHuBRKrB5s4tPEUSG4b7wBzxRH13Zjo/GoMXysD4gkjmWwkr1BvY?=
 =?us-ascii?Q?K5EBvZU4eV3dIOPhi2IxVnpLbd8X8ujW4S0uUYSg34KSFKbHw2zhCE3JnIhm?=
 =?us-ascii?Q?P6C++tosB9Tky41fZJ0hSzjM3sRI7BbhtWHnLt6D+8bjf5PcAqbxBdAllMNp?=
 =?us-ascii?Q?7+yEADxxkoQ8VpbLZmvaGwDEo7Qd/KtQCqBeNomNVT4y+Fe1Prd0vPcN8iHH?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b194fcad-9270-4c6d-fcd3-08dc84a283a0
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 14:27:50.9109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdgJKj88z5b3l+AygsqN7mlQ++vH0XUviDLlrIWYwMDbmrub0jeYjrMkRGYYAmotT0oToakVVp1BF24NqVlJuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5827
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Use common zynqmp_pm_get_chipid() function to get the chip revision

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

(no changes since v1)

 drivers/soc/soc_xilinx_versal.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/soc_xilinx_versal.c b/drivers/soc/soc_xilinx_versal.c
index 3d8c25c19bb..3d949c4e612 100644
--- a/drivers/soc/soc_xilinx_versal.c
+++ b/drivers/soc/soc_xilinx_versal.c
@@ -45,23 +45,22 @@ static const struct soc_ops soc_xilinx_versal_ops = {
 static int soc_xilinx_versal_probe(struct udevice *dev)
 {
 	struct soc_xilinx_versal_priv *priv = dev_get_priv(dev);
-	u32 ret_payload[PAYLOAD_ARG_CNT];
+	u32 idcode, version;
 	int ret;
 
 	priv->family = versal_family;
 
-	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE)) {
-		ret = xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0,
-					ret_payload);
+	if (CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)) {
+		ret = zynqmp_pm_get_chipid(&idcode, &version);
 		if (ret)
 			return ret;
 	} else {
-		ret_payload[2] = readl(VERSAL_PS_PMC_VERSION);
-		if (!ret_payload[2])
+		version = readl(VERSAL_PS_PMC_VERSION);
+		if (!version)
 			return -EINVAL;
 	}
 
-	priv->revision = ret_payload[2] >> VERSAL_PS_VER_SHIFT;
+	priv->revision = version >> VERSAL_PS_VER_SHIFT;
 
 	return 0;
 }
-- 
2.30.2


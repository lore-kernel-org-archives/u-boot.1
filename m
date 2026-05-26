Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E544CD5BB4
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:36:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3B7383FF5;
	Tue, 26 May 2026 08:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="m4VifiJV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD5D684659; Tue, 26 May 2026 08:36:30 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F79183EF9
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=any/uANuGo3fbf0SKwphXnhmAhFTTJsx2p+BAJkPG5WFeUsQBvagkMmsCjMAWP1sgk4zlmbYkUHnP7WIjhUvlpzq+JW5eReOi/0g4F2BwBB4M1HX9+XqTVYoh/KAbE5y/sycU40XRTGnzlxBhOw10VrdWUxCiMQ8p2MisisIbTaUsfuoN44tJGyEMm6ZcKmplEYnZA5JFBg20zvUmxCvcPV2yb2RvymHnWQKv/WkVAVARn99sMSJtZr/C9ORpxQaYSMyQnpyL+xYm79h+ILwl+7p0JuJ2+JVDAoKzATKsYMS+YB7wIhCc8NSZ51yrtOLbQSjIYw5fqDQsG+i1PeVdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGDE2V/bbE0igMwu2rVlulTFV5PQ/kG70FVdL6PWc7A=;
 b=mYAFpkbn3DxkWEAEwvYHTZpiJNKU9HuVCUe1yklqJOj7QMzqR0/Fs2ii3hvbFDdCkhgwI3VLjIEMEXCbjlCLfxdQauHVkuzdfZKBm/VjmWg8Rg7i5m+3a43X+oefxv9jA/ODB5iXD0CEfnKx8JaAAC2w4oLNsqGLKWTH6LMjfMv/3y5CgaIOZlFeRIw7jwuWqNMJrh8K0lYWE/oXcNYj6q4QHVs1LZaVoPKrzhZCqpCu1isyiEblQ3Udbv6Q2CoRdaQa9Bb15TkL3l1+7RWbKx2LmpPNE5RUn1l8gD/A9djzSOxI0eh78XkCVpar8fkiOaPXX3SyROLIQh5DipMY9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGDE2V/bbE0igMwu2rVlulTFV5PQ/kG70FVdL6PWc7A=;
 b=m4VifiJVbMTgEjx1Y9C3OZLdK/Mqb3Rp/uoCYblX1HwqbAHWUqXzmt3kyDxCt50H8tCD8BVZta56mwI6zCFWcOpCHvoz4CBxHdzQKeKhjwBnahP3k+dNscdgZb4t3GqE76DMrj8swkojHNiZQ8+sqWHmjy8sR3XhwVObu39ba6Sb6A7eUh3njVnlsBvL6MewQi+K4B6wzuIDyTXaJp0erafFyScoQs1/1iatepU79zBryY31rE1gp4YmywMK2dUKFHQPfpx06WgyefCCMQc2WgwL5AQimHTcJSrWOz0t4+HZQUX8klq7CcWr8Ng1cxtsyuMvNFQeS+hLNy6rHBPvZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS8PR04MB7736.eurprd04.prod.outlook.com (2603:10a6:20b:2af::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 06:36:26 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 06:36:26 +0000
From: peng.fan@nxp.com
To: trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] timer: orion: Use dev_remap_addr_index()
Date: Tue, 26 May 2026 15:53:06 +0800
Message-ID: <20260526075306.2801616-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0200.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::15) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS8PR04MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b4c959-1694-4934-1c27-08debaf11c95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|19092799006|38350700014|11063799006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ibhYeZTtDCJWIe9ymGJ4hYl3tD8vE8xNADC0AOcNHKiX/rj/4fL8llm+2DSLfgMMEohnQULgKz0lQTQCau1teFHeIwPhmZQCUvYp8oWPh0gpsI3fBPXlCE9TEgCc9O40EU3dq04UkhBZp3OL3x4USb6wGd0tkmXBSNH8Ge0CMFmQmqGP5fbRyZA2keWvuhnL31TFoPUBQV68pwxBT9MO4NkKsYJhjxKkTrPG+MJgDTukbb+R/5s2rItg1PmbvPsCQujOW5KL8VqZN19X+MV7Fv2B75YIYA9leD5vZZttcmCyQNjeWexTQ7B2BA3TLMoR03wjbM31Jn2cF5QRkxnQec5n+KX+lXB/Io6UQjJUkOjHtI4Oi+BJu3n21Sk1kW0Vp0Wn43re8X4WBW75bnKo8oSJ5XONB1yATSC7So3s9/1fSjiDMo+/R4MvT+CkojfCmzhGnu8kE29MWw1o3qxWnczgmXYNzXm5731JnRrmw2UUQ6K0UOE2Ixyp74SXzoV8WJpCMrJZ3gOl3NFEIR5qfFtFTapj/fi4SdrYB3mvCdPKM/GsrceMCHgd/4XvsgviPWA/UMswZWzKk/oWAqoNif2eoEOLa2V1Ylo79CplN3qwqgO2vTvI5o8E0BOVKDopUW9e3Hkmj54RvUiM+di8SZ8EAHRzyJlJ415pALOeJFPD8n944oLgaVwg+EZkHTz9neMRlplzrRXPShf+T54W7wWAobmH2v2IYYnd/0FK+qzhYQJpRljeKdOLq3G4dSVB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(38350700014)(11063799006)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gq1lzKiF/UeIg8IgAiZSjxKPyPAq1SBvVjCVms5aRHkVX7VaWqZ251WvI98p?=
 =?us-ascii?Q?YGmMeE3iSMH4xYy9zDm8DanSrrQNe3ToL9efem8x0NdJqUYeuph6dBA39dTT?=
 =?us-ascii?Q?Ek2sYqeeQ9LKbFbUxasOt+K3wZhaK4JYyXO6kvPBA73WWA863dPKrz2PmS4X?=
 =?us-ascii?Q?Xxmwg6F5ktqrA2liTGCxwJ+oV0+EZLLXzerJc3pADMH6S+C8amER1Lnol05D?=
 =?us-ascii?Q?JmDtalgCu6D8Uk06i86dnav9JLSmFLOR1H2a02ZQH6dzMs1WQNUJpcb3s2Ru?=
 =?us-ascii?Q?zHIJUT4u71SnzRWqwdRYJRATUbvZ7r3xBq17Fh1jNX6v/jSNuVM0QeYvfrLC?=
 =?us-ascii?Q?K7I0R2UNIZGVtPHGutOX6BUEWcUiLnqpOBifPg9KDEu6q6sNqDadYkq483cE?=
 =?us-ascii?Q?ckbpqc4aYlnS9ro/fKpy2lnQI02mzlPFhtBeXbyUUz7LvBS8Ezd2Hfx5Ok6P?=
 =?us-ascii?Q?lWfm4R2lZMkB2tXw+RE3ZNNSlrmGrBk2GfW2Mbe0dexq1cbj0sgvNpxeE3D8?=
 =?us-ascii?Q?TDricw+glqvM3fBhuZU2xeKguBCFL9SyMSpM0AowDA0+L7BU9bWZuzPTjQ0H?=
 =?us-ascii?Q?xnffGLtPfTwmw4q9g9+mJptFltjLu3cWX8QLzVjb6qJsFrcSOmtbwjFLUdnK?=
 =?us-ascii?Q?E/arYvovlcK7M0wbRmqXqBiXya6EXFAlV8RmZRafkBtflA6s00Kei4ABQD1X?=
 =?us-ascii?Q?nWkmZWI+J+lPkxpmJUanEKsEsUsP+RWwKROkqTkrNiC9MCQJsJaAwf73QOm/?=
 =?us-ascii?Q?BsD+tldXieKRp/TiTQO07VdIPlEWoSktd1lwuHupS2NZM7w88i2eNk1xyqD7?=
 =?us-ascii?Q?NL04mYQqWOGtu/gmJBtA0cBoTHk8ygKsLkQqijzBtz14c+NsV+ddByUni5oq?=
 =?us-ascii?Q?vfeFtZZpK/cUFv2W5m1U9fOAyNzuk0A1uqqJgdO2qQiBcydRcucZDpMLkjw/?=
 =?us-ascii?Q?FwjuG9hE/AKOUBlO+kdrXsw4YVFrBDKREshTPsI0IB7sC5e93H9NITbRtF87?=
 =?us-ascii?Q?mg3oPmPfW122Ec04IxPtcQTSxk+mW/vgQ7vhl1aZYiFVChZ99EEaDeHC2N/m?=
 =?us-ascii?Q?3iLjSPOhg8ftkZpyk+m1paOL/HcG44WDBAN1R52ZSd+SHkoq2caD5WxGQ8M5?=
 =?us-ascii?Q?82kMlTG0ho9n4Hp8vH0a1vl2FyxDvNi5A7dfc1ve39wXxDL8pt9H+JbkUxEq?=
 =?us-ascii?Q?t/UxvITUccJ0EG3/yzw3b/KsmYwQNZizTSlZ7MZwNYYQalCD5nwlixET2Axf?=
 =?us-ascii?Q?REFMsX+gw93WUXFogPNpDiCvqgf45amH0ViINqBvhwaQ4izj/TWobE21DV9a?=
 =?us-ascii?Q?tj+Y6ofipVUoF1FzyiucTReCCSKEUG75+SMXjWJtIkDz5Ar4C4mYMl801TvW?=
 =?us-ascii?Q?jRPHu5c/MUMP/c0t/Tq77orNlo6swzy4vpUwun2w6QF9TGGdkBqbEkVHpzom?=
 =?us-ascii?Q?DdFaDXOLiMwiAUD2U+B94vv+qcD8UmBf9DCNGYireoa3j7PSvRebEL80dd4V?=
 =?us-ascii?Q?TzwofSq9he0OqVIzoCiDoHXFEZyOi1p+A2GWUmTABj6X7y3RLOj0K+4mkhOk?=
 =?us-ascii?Q?Qnk+7Xh4UEZZSB1EOBFDMS3N12hZIa9DMXxucUxn+lDldmfJUEy1JFSd7EqY?=
 =?us-ascii?Q?BghjMD92uI2qjJTBli2sLflMGPh9d4ChRB5bb657es0eeE/3e0sKZ7+9iQXu?=
 =?us-ascii?Q?7slLv02di6tuM8yT9Yw0EQzts45xnMoMUHWPcmzc5v9LQpt+70nZAsr63VVX?=
 =?us-ascii?Q?Pj9i8h8T0w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b4c959-1694-4934-1c27-08debaf11c95
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:36:26.5541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ET8zaCL5LTmxhuE7w6H6qfB3XZ68N9Q96aPsF8kod6trphg/aGcuHst6q17kYCfK1/YUUlPpSMgcTN//tq3JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7736
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

Use dev_remap_addr_index() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/timer/orion-timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/timer/orion-timer.c b/drivers/timer/orion-timer.c
index 821b681a232..4d1c6b5cef2 100644
--- a/drivers/timer/orion-timer.c
+++ b/drivers/timer/orion-timer.c
@@ -2,6 +2,7 @@
 #include <asm/io.h>
 #include <config.h>
 #include <div64.h>
+#include <dm.h>
 #include <dm/device.h>
 #include <dm/fdtaddr.h>
 #include <timer.h>
@@ -113,7 +114,7 @@ static int orion_timer_probe(struct udevice *dev)
 	enum input_clock_type type = dev_get_driver_data(dev);
 	struct orion_timer_priv *priv = dev_get_priv(dev);
 
-	priv->base = devfdt_remap_addr_index(dev, 0);
+	priv->base = dev_remap_addr_index(dev, 0);
 	if (!priv->base) {
 		debug("unable to map registers\n");
 		return -ENOMEM;
-- 
2.51.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E01CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 09:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA9F0871E6;
	Thu, 19 Oct 2023 11:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="UWLlTM2Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D2C871DE; Thu, 19 Oct 2023 11:58:52 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2071f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe12::71f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37DDE871D3
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 11:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXzjCKH5iYlDe5ui5ezyLa6f5IUkG3emkznV7pu2kFgIo99iJMv5CL1DyDyRcqrqSq82bfn+ERLuVdG1JrMSOkE3khNzOcN0hFAFT08tjsIf56jBVDr+7cXOz19c4XoEtb5qlWkDw+Pu7QpqVWfnYC8yT7BFx3ZmaPAHi5q/xdpk72BZDmeVdHI5xmk+sZpETcZaTE/si+CVnnPyDb5U6TU4xq2EUqmEidLTOKvwwY3YNBaG7FDTruKqjRnETsA0k3a69CkInQp+ANTLBpg7pd87/gwMHJBmyAbbt2PYJYruBLxyPjvuWrkgOvrRoqfOE2/aTZje+EG0njc8GVVWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4ZRkIqMMdl1M43yCTx8DN3L+wIVqMOPfDUXqkm7yaA=;
 b=nPnEAoJcAG++zHLeLf39j9B1+tiN+CpmJeL8XAv3th7NarzyC8FPJ/oS5wwgRZ/rLrxi6DL/iS1r3zfXLVggqlk9d1DYVNMku9je60JtoWeOSzRWesym5cruazrEwslw4AHJTrIpWCYrB42aOiXgJkCGswHDxl3hHCaTYpjQl4IdELvUGdSrDTY6q+sD9xctPrFCFjwjd5SfMzMj1GZQEAvo04k0Gb6phvrZTkG+AFrZpUZ1aZQnWLXzeEJvs2BXAfPRQ8eWgp3CKhfGwQB27rSNaTvKQUan5iFHOLWu0k6u9SE6yjjTfTh+bgHU1So+wCq6nMLwbbUZWJ36I6NWKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4ZRkIqMMdl1M43yCTx8DN3L+wIVqMOPfDUXqkm7yaA=;
 b=UWLlTM2YxV55HY5oDsqit3pX9VGlPgMM5tvnTVxtU3WtMgWLHGveNGy+xQkC0jicTcCogXtOAR/rwXp4cu2cguo7QB4i1XZ/SafqkkHWbpqfnkzvJSlJI2cQyz2gT6wdL79lQ1n5MNZk9Zx6KCdG/ytI1j+7se15rpPjQv9TG/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU0PR10MB7481.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:424::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 09:58:48 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 09:58:48 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 3/6] led: introduce led_bind_generic()
Date: Thu, 19 Oct 2023 11:58:34 +0200
Message-Id: <20231019095837.2084458-4-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0094.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::35) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU0PR10MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a7141da-9a93-4186-ba91-08dbd089fd36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jE70avS6ur5G+0efFojULgyylYwEzvZhzgrcvodO9H3x6AfjYU7digDqMCFKRlbc422YJ7W1UDmunugDBhFQ7Qos/mvSwBJXKdrOsWF5OIrIfrjYMGDv+lVImBFu+zp1rUp1hF/fTLtQeRwy63BMH/37irHQtLmUh8+d3kW4Hpja1LGuHd4K/6uj61RVbuHEV/vqMOUJ4PzIjBJkqN7oj8+nrntvruTbwvuK0aTOJHsPnW1rI9BytRed0oMv8y+lRiozPX16H3ga4sdweuPyhVGxX2DOsSPIBBh2NRRFW1HxSKDwyOa76RNcgLgiZf7+8HYG9RCrDYEzu/+BPGZawSdUJj8sOIqvDbrzYVYyK85wctjO1kwWCXdgvSvkfwYCqtWt+m1heb4ux2Nv82XoWZI1Moy/bNg8pZJTFB51CEBIYegjayEVPwQ3ZU17DbPAb99oaitGstlnO9t7Xdt90rOKqNEGCnE+bgM0Rd4nIvJ+OdsRf53Yag0uXEwNtQ5HXgpXiQWm/pkR2zxYRVYP2lwuqxyJHdxbCZc+QrChu5wbyCcZfqVx3fpVZG79QR8SiIYo0iOPx/K/SWTw36/Og5NW9FTc1zEukumRkL6oAqNGxiwjRcgiNOgkmaB4ZQCfERb3+dnIoMltZNPS40cYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(346002)(39850400004)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(38350700005)(2906002)(38100700002)(44832011)(41300700001)(36756003)(86362001)(26005)(6512007)(1076003)(52116002)(6506007)(2616005)(107886003)(5660300002)(4326008)(6666004)(478600001)(8676002)(6486002)(66476007)(54906003)(66946007)(6916009)(8976002)(316002)(8936002)(66556008)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aaBHP2OhTylTzhsCGdclTHYL9eiRk/sYEis6MZ1sRlCCG8UbqoOrShEP0eXK?=
 =?us-ascii?Q?DMEtrOzD57klDmg+mXiogGtNbabyKqFmLp2lZrzU9mff8V5FfAGTJHI3c2gA?=
 =?us-ascii?Q?bNeJeeQ5eonEKP343+kYXfRiI3ctUpirNEx6wYOJ2lyb1kUTR/WRgwrzWDKM?=
 =?us-ascii?Q?I4sGBpR6oTPSMYW0RORyp0aZ4YQcg4GpA7s5tRmh1GuVAeLOCkZKEM6LmHDL?=
 =?us-ascii?Q?02/FoMKMdsgxcBreGqqKnSQB2rvKAkZUXPPFB5Qygjnla2DIWg9I9Hrvc/mW?=
 =?us-ascii?Q?0fA7zOH6JGshWd8HOvHHi5HoRzZh6Su1bKE5pSMB9WbCUHsBpXbYBzXd8QcL?=
 =?us-ascii?Q?BBdhm4AG2yoAelo+NJY1Ht1gA760xusUdaOzGp2xljl6IX2xeNj36uZXuwxk?=
 =?us-ascii?Q?6FVowpwRNuZ+GzU2XRfDyxLl4MWTBZJX7ydCEC12JBFSeZ1BiPuS23/jEaRi?=
 =?us-ascii?Q?oRGGBkfDlXJ+boQ3sMc/bui1GmHfu8e2CGGIiBqFQt3kKGgvB1C5kRHw6pY5?=
 =?us-ascii?Q?gOKAXO02kUDNeL2ySjH22bVWT5RGCVFT8VBULk9cApZFdMtsaJeiYmrlgztF?=
 =?us-ascii?Q?x7rPTNspTRrYhSxFY/xfwxnMzRsIPPB0H9wtBsYM78c4pfiQEhAqE2lQDl3P?=
 =?us-ascii?Q?HjVTQuD0vKH7eziPGaR4pk04SErlZ9tfZ7K1jF8/sBTbO8QqA10GYNBNDgoo?=
 =?us-ascii?Q?quYeou8SLpA0E50wOUIbA1e4d58h+q2+canjaYO6zF9eJJxXXClmndQYKMAC?=
 =?us-ascii?Q?cDmJ4YpJAcBlfzZ1V9L/4scGKL1hNOOJy5CJCpgB4M0OI0uo9iDFqXvvIOmd?=
 =?us-ascii?Q?GNRnc/DB19aDGkNcAUP4sDk537A2BwOBC1F33uLg58e21A4Ne4HSCSnJBZxT?=
 =?us-ascii?Q?TbyIq3tyrhy5UtBcK/TZuZMZEPgHVq8/M0Qpn/Ryqglzq8hV9OYYAF4N2lKB?=
 =?us-ascii?Q?L5Qx4WoGqwFdH8eEfl2RdxV2o+rRotZCAB9Y/IqVrIj8Bo7gvCmL49qYbtJr?=
 =?us-ascii?Q?RlYseSRriRGL6yujGnziQSq+rKrF7375a7Omv/rY7ESExlo0kZXHWAu3w6Cq?=
 =?us-ascii?Q?EGK5pq9te4REuY8Ql1gHf0lojJ6Bm9WCfa8BelwJAcCdRBNJugkF4Mdc/oxL?=
 =?us-ascii?Q?4/FRuRSWaJKyDWfvnTGlkdKxIPxYa15gV2tagKlM3hTw6CcMgaku6M6xoPs4?=
 =?us-ascii?Q?n0thtZLioMpVLXSrluQe0Mf7bEp1i+oLz0rMYfe+ekqKi9WRJ22Cy+AEfnJR?=
 =?us-ascii?Q?0PR6RyKUiazvxzMXii/t9gzT20o1xp9mYKkPp9kf56GWJIFqICcTuYCklobc?=
 =?us-ascii?Q?bYF19CeVbbdjv57vdILrDR7L1yjCBUNG+NkDlPcNLbjrrT/JYeF1Fze8e9g8?=
 =?us-ascii?Q?sISfQ5hVPXdWVf+M3BUDPW6q+IXZbbIj5t8hwrW0DUAnWt+re2f+WZR7WTAR?=
 =?us-ascii?Q?qlIMdMObe5CGHb1N1+QStiEBLmJdhgcBolRcc4Bu5shMPls2UE+h4TE0gTH9?=
 =?us-ascii?Q?dKh3d6pvj998FG2jyhYTPTk+n5EhNDSoUmAUQnm+ZOXjeH4BP6JW8r8J11Uh?=
 =?us-ascii?Q?wIg+Ge4YzRA8w/LfjbFriPT/fMeapxhCKquTTn8oohcZSfBB55onBN4eDQms?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7141da-9a93-4186-ba91-08dbd089fd36
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 09:58:48.1798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Earyw4P6GDtPImwZ+42IrUELTF2wzPEp0bIOYpsSvQiNT08R36zuYhsoj0RBMwVyiQXfdp8JWUpJD20rQ2vvWrcPz1KTRFCwa9UgDIYyIjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7481
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

All existing drivers in drivers/led/ contain a .bind method that does
exactly the same thing, with just the actual driver name
differing. Create a helper so all those individual methods can be
changed to one-liners.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/led/led-uclass.c | 18 ++++++++++++++++++
 include/led.h            |  8 ++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 0232fa84de..a4be56fc25 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -11,9 +11,27 @@
 #include <errno.h>
 #include <led.h>
 #include <dm/device-internal.h>
+#include <dm/lists.h>
 #include <dm/root.h>
 #include <dm/uclass-internal.h>
 
+int led_bind_generic(struct udevice *parent, const char *driver_name)
+{
+	struct udevice *dev;
+	ofnode node;
+	int ret;
+
+	dev_for_each_subnode(node, parent) {
+		ret = device_bind_driver_to_node(parent, driver_name,
+						 ofnode_get_name(node),
+						 node, &dev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int led_get_by_label(const char *label, struct udevice **devp)
 {
 	struct udevice *dev;
diff --git a/include/led.h b/include/led.h
index 329041008c..a635316628 100644
--- a/include/led.h
+++ b/include/led.h
@@ -110,4 +110,12 @@ enum led_state_t led_get_state(struct udevice *dev);
  */
 int led_set_period(struct udevice *dev, int period_ms);
 
+/**
+ * led_bind_generic() - bind children of parent to given driver
+ *
+ * @parent:      Top-level LED device
+ * @driver_name: Driver for handling individual child nodes
+ */
+int led_bind_generic(struct udevice *parent, const char *driver_name);
+
 #endif
-- 
2.40.1.1.g1c60b9335d


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88135C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0549A87AD2;
	Thu, 27 Jun 2024 13:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="l9wV535C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D12887666; Thu, 27 Jun 2024 13:31:26 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 655438852E
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1bWhPWlY8z/apEnnxjbVjAYrUQYDfwLvGplzKR481BnBa3jTzPOAs75RMpjLfivzKtp0JjWI2/WUrik2o50/VykakW1mM3RexHuMLjha5llaVL1SpClGyA1OFewSACWwdNZIZoO/OlcPMQpC8EG7DXcdqpXaTKhQifJJl4w5RVyYfnE27FBNHEW+kfQuspRviBbToJ5suXvL/bywF96swOg2EbNQvXtjvDKtKV9NemWg9YYORk3RLAc05c4F6CY7bpW7Jj/w90BRcYK2BvEUnwT6+HbxQD6sfmWH4ViW8hu5i4uNR6rHYVBlzsAlteyoVy52uRMcG18hcFAHbmRAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KR6K42xulgJLVxyD56eY0jP5CSC0ke62ZN6TuplEbOk=;
 b=eCrGtKX3ZHet4YgWojfiYRDwZNEsurOBL05Qd/xDXi+r6aIwf5HcnXdQ9AON4sn3WC0jQUQ25rBLMqVy/3oFIwsybCue8ZlTi2UVN8sbTvCd+VodVNdu29iX/KxclrtkAbnQGzigRLEhtuTAgHn6wlcs5Pb8Pc8UbNQTkA6UtmgAM91++gmBG1bS8PBNukV0Y9KIoBwJ6MZZIDmqjNd96PtI1oBkTjL2BIqQ4UeU6XZTj1+n6fk+X5t54WHO9345Z8N0Iwi0LH7BVUpml0ORWNxjCVl9Xtb0Ci4jEyxz6BPJabY2VYRci6D54560ezwzkIS0aApDt/eFDLDlP4+hHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KR6K42xulgJLVxyD56eY0jP5CSC0ke62ZN6TuplEbOk=;
 b=l9wV535C2eDjdREdDefsDr6/ODJHvc9qKRh519wVnQXjyEcrVvR7HaNzCdt/OK5tCayr+uwxD715kfqhzKjU0waSK17GgFqCcqWIg4kfTCBXKToApfUjshlDTT7UJ/5hIKMF/NfjW0ZzxgptU2mPZf2q5qxcwrsLbIDWd5Jx7txAgdfB33U1ONjnL5HrUSl96VH3S6g2rLybzTeyKJ6EQZv749k9DK8rBldeKo+YnZWNDEQLY8U5yYsWX91v6gpubxBFzwLeE0QLLKi5Jg48WlfRhekKzaW84jCMCbnOnwq3oCkjxypJtqDrW36lBv+AIm2zNkO8zSFSvg5OWdmF9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS4PR08MB7579.eurprd08.prod.outlook.com (2603:10a6:20b:4fe::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.37; Thu, 27 Jun
 2024 11:31:21 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:31:21 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de
Cc: Michael Polyntsov <michael.polyntsov@iopsys.eu>
Subject: [PATCH 1/2] led: Implement software led blinking
Date: Thu, 27 Jun 2024 14:31:13 +0300
Message-ID: <20240627113114.100083-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0000367B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::397) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS4PR08MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f82f1a4-7dd1-41d2-5d3d-08dc969cab8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kWWg3g67ssYHdnlbONsYqZb+yLTKCbHVFqnM/PdEfWiHRRB+9knnfkG44bd1?=
 =?us-ascii?Q?U+7ipiNzw3uPZzkp31kWGxR+XMVuPaOFe3+LoUPafGTuHC1unor7G81qriG8?=
 =?us-ascii?Q?0bstCOHk4Qbp3HTcFDQaeteArl1HR2HmLGKKCZXpUNZugozh+ovBiBfMCKni?=
 =?us-ascii?Q?c/T+HQBESMuOQavFA3J/adsrPtue6gShTYSMi11DdV8p4UJbFjY8KNGtSBV/?=
 =?us-ascii?Q?jWf7nDW+3NUmVBFw5Zwd4zHdbUGbVWr3dpLy5FzkhKaBEtBazzHh2kDSIzJ6?=
 =?us-ascii?Q?C9y1ds0JiikGm8oOnKqPyXanl9bOzy35Z8fBfCJ6ovy+6OHXWGBxSzQrBcdT?=
 =?us-ascii?Q?pFR8kMTumIxxmFiOWWCkl8DkyEzegbmP2RdjqoMrwdm+Efn/FNnhtgQHXm6W?=
 =?us-ascii?Q?6tWanDLPuUWPeWy9KEdGEW99MeWycosmJojrPigsTFT6a1DtMEtDWK1e6UVA?=
 =?us-ascii?Q?DS/bp9tWywRmdg+TRspstx+0nBoZWEVK9FF/MABXc1yAIm3Gh307TSO102Qk?=
 =?us-ascii?Q?GZjPVBY+7LfmkAS5BJijEvCU0jgNEW+eCFoqzN05tOdNdkzMQ4sxDJIT5kUX?=
 =?us-ascii?Q?qh1FAV6FJCbypsSAdzRyg65o9cR+OlvVPIJrLDGg3J6inplJ8Cu+UJqVvwGd?=
 =?us-ascii?Q?yT2J9xHD9chDIuXsjzK0DtOx+AGLx0b2LupPYIAcmUTfpdDpFKq2s6tmH0YZ?=
 =?us-ascii?Q?R+lbLVzlQGNVwkoAM6b36RsbuS+mAQjNf2B83RrD7GwqNFCOa0FQTjsd+vHY?=
 =?us-ascii?Q?y/+esHOYJglFWDGX2aPGu8+fPQKqS6g1ebK6mAUUIM0x+reguz5en+DyhYws?=
 =?us-ascii?Q?e5suaLJnTEnoc60J6x7Lz0gFXz6vRcmV86iV08kHT5qXdvVsqIfXoVv9N9QG?=
 =?us-ascii?Q?q/ymmL0aJ/bOik53DF/rC4WzkUVupDcjEHtg3LCYXTs0cvZZ7Ln6v5TnW/tQ?=
 =?us-ascii?Q?lk7b4REekRvvibAobGEhujAE/QtmKRr9fPlx4hP0trdnZysyLM4BGeb2NdQp?=
 =?us-ascii?Q?ayA+YmQj6N5WpiJ+DMk8Q0+Cn5vYMgiQ1Jk7FrBHkO25H+rO3kCUTpgrXeRQ?=
 =?us-ascii?Q?zpEatNEgudgtdWgHRygzDZ7VnzANZ4aLuiSz1W8/spi1QD8Nti6zdf2uG7MT?=
 =?us-ascii?Q?DBwXuG1LRUVSmjnW/Ssk9JeGyKGf3zXQw4Xz//gvGisvKMRJKRnwwfr+LXAC?=
 =?us-ascii?Q?EQkIuLk1D/LIXDRlkIAPpLEbhX3BZedKeOKpqs1b9OzPNM3SeLSUgrSjFID2?=
 =?us-ascii?Q?8IneGwnyhihlTVI9i67VKkgCVEihQpaqLjRfIf7zrDG8lYa/z63nk0VL3v/D?=
 =?us-ascii?Q?y5M4eE2alHPlmatEX+nbsBDC4pXmCeFhOB5YbGJN93vJtT6MPA2MEv1f2tAx?=
 =?us-ascii?Q?K05Gf6bbCiZcJb9cKh2oMeEusPWQO2MXiKRJ+hNxGod443KGyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bYzfsiSelMSWCcdGDpPcP8RL6RYMAz0gREzbw3nV3ceFFXEYZR6TWdWsFZcw?=
 =?us-ascii?Q?XZ3liWyPx2JqEB+cwukXNzxxksvLvwOPdCIfW1r3yc6RkcixxrFh8C+g6jW7?=
 =?us-ascii?Q?YFYFdIq7lQyxQhFYR+DA7BRTh2bTImwr4lAwhlvJuvgn3INdIdRD2SqlGZF/?=
 =?us-ascii?Q?N9FQYSEalXqcTNHCuHpP3DmwxgcMa25+vIHKdLKnPwOhSW0Tkz0Cx+0tv0RL?=
 =?us-ascii?Q?k//ZQsw23qerWnylIvHF2gY/bVEfBzKxP/bfLTM4s+75vvV40cgQZmzzzZ2i?=
 =?us-ascii?Q?1l82UzX0dByGccGmOuOLNulF3474Jjtn9L5YdbypPF9QuSGlfjR3gR1EmRUh?=
 =?us-ascii?Q?/cl0nbBM4xLmMqXnE6IWbxcGz3QXNkOaXUNaW5/ntbWKwiOKJF1P2G5SvX9T?=
 =?us-ascii?Q?CAT2Hm0qV0fPsczwt2uL6Kg325gqXapawAVNzyx9A2la9gyoKqkjEZ7+RpGF?=
 =?us-ascii?Q?ok22Ux5eEnTXr/FdoxXwwoubZ97UEvpdWwC1kM0tE7pjKAEzxY2RQy3+WbMa?=
 =?us-ascii?Q?DtqpcDGxDJOppcmicCwezo+vyQgmuvdB4ag7oPYVhZuF089C+yNDiO8oAaLl?=
 =?us-ascii?Q?76T2qpm5TzQpqM5FvqzBJjXqyTLMsnyh/EgMwVbS9bq4ieTvUmZvIxP6ILDn?=
 =?us-ascii?Q?LNFOFNV6926uMCo8VaC+S9ILhfXWL0xdOayBbeZpqipkqD48KFhwCcvy3hRM?=
 =?us-ascii?Q?IOIb6SCSgzDPKEX6mIZBWXJYEkL5HofoTWTkoGMq6PZ3qAoK0q0oBLQYIbQi?=
 =?us-ascii?Q?xnNYfwcWEhgM0oX5tjLhq4KelBIG28WeKqtJ00Z4xNYOy99kqGmiSQfxR9OK?=
 =?us-ascii?Q?EDHqPjlG8gocBySygTTDrk6xYaIetgMkvmDP+lFm3QdpxXP5CVkGQJLoElyB?=
 =?us-ascii?Q?jsyrhtfz4N4F1+Jn1JNpR+NsRITBwCBZCP+lxT2Qcj+ZPXDfuTdJnC0VahJV?=
 =?us-ascii?Q?+7Ri5+4pHPnUE1eRm+A94rJIBcwbCwdAkYEDaEqVxqiu3mYs79BUikPt4SzQ?=
 =?us-ascii?Q?OKon/LJIUu/UPf6i4dttlaYU2ocfuY0aequt3sSoCDG4KK1eThlPCgko2rPT?=
 =?us-ascii?Q?I6VAJ23pKQ4mQpqzPCjBwpYo+3RxT59ByMUSuLw3WsGQwChkEe+84issUzm0?=
 =?us-ascii?Q?u77T2MmZKoM3U4i4Jvs9WWH1Nj1vBxRoIjJKR+zkyPHmjlPW6qYS3ZvMSmG1?=
 =?us-ascii?Q?FchOTVeK+SH4joE0gumttYPDgyxsOimqktocb6gqI5LhXcSqry+QFeg4gCVY?=
 =?us-ascii?Q?U9DKjiRKNQfi5Y/zHlJjMMlh43qFTmbqqzbEHhtImUFZlwyDgcaz9dVytmNT?=
 =?us-ascii?Q?F1KDGcWU7EHUp1trPCqeojf82ooGO9Iimn8CFHN4Y6nHB1iwq9qjghcpk3Ck?=
 =?us-ascii?Q?jhPTllak+lkebQdLNdHV9mKHrFc0eivFkuX2z/c0H0j08dOvxQq1Jc3bEQki?=
 =?us-ascii?Q?pUOXaOFQ+0hNRRBQXZf4fmyRo0GI8zxJv9aX6Di5v6ArWcgSp2YoGHZvnuh7?=
 =?us-ascii?Q?owVjLDNthqbHiTzxFV3XpASSCRhNjGFXY1Vx9W7duhExWxyxqSamDE4gXQ9J?=
 =?us-ascii?Q?uo0jd4BKzU15r2mcD/jkTAoOpRVesIs0Zug26uBquDZIGzZWM6GZXlLbaMV5?=
 =?us-ascii?Q?4j3laXBwiUnractj/PnvaDM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f82f1a4-7dd1-41d2-5d3d-08dc969cab8d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:31:21.8622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBsGzq9Tifdm6jGXVp7OlfOPMZm7IF+fh5etIN0YQzYQ+rRkWM6bp6cFs3egUNtgt4c0SU5/m3T3+8vq2BDizDnU43TF2uJE4CQBYfXM9bI=
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

If hardware (or driver) doesn't support leds blinking, it's
now possible to use software implementation of blinking instead.
This relies on cyclic functions.

Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/led/Kconfig      |   9 ++
 drivers/led/led-uclass.c | 190 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 195 insertions(+), 4 deletions(-)

diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index 9837960198d..4330f014239 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -73,6 +73,15 @@ config LED_BLINK
 	  This option enables support for this which adds slightly to the
 	  code size.
 
+config LED_SW_BLINK
+	bool "Support software LED blinking"
+	depends on LED_BLINK
+	select CYCLIC
+	help
+	  Turns on led blinking implemented in the software, useful when
+	  the hardware doesn't support led blinking. Does nothing if
+	  driver supports blinking.
+
 config SPL_LED
 	bool "Enable LED support in SPL"
 	depends on SPL_DM
diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index a4be56fc258..b35964f2e99 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -15,6 +15,10 @@
 #include <dm/root.h>
 #include <dm/uclass-internal.h>
 
+#ifdef CONFIG_LED_SW_BLINK
+#include <malloc.h>
+#endif
+
 int led_bind_generic(struct udevice *parent, const char *driver_name)
 {
 	struct udevice *dev;
@@ -41,6 +45,7 @@ int led_get_by_label(const char *label, struct udevice **devp)
 	ret = uclass_get(UCLASS_LED, &uc);
 	if (ret)
 		return ret;
+
 	uclass_foreach_dev(dev, uc) {
 		struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 
@@ -52,14 +57,180 @@ int led_get_by_label(const char *label, struct udevice **devp)
 	return -ENODEV;
 }
 
-int led_set_state(struct udevice *dev, enum led_state_t state)
+#ifdef CONFIG_LED_SW_BLINK
+
+enum led_sw_blink_state_t {
+	LED_SW_BLINK_ST_OFF = 0,
+	LED_SW_BLINK_ST_ON = 1,
+	LED_SW_BLINK_ST_NONE = 2,
+};
+
+struct sw_blink_state {
+	struct udevice *dev;
+	enum led_sw_blink_state_t cur_blink_state;
+};
+
+static bool led_driver_supports_hw_blinking(const struct udevice *dev)
+{
+	struct led_ops *ops = led_get_ops(dev);
+
+	/*
+	 * We assume that if driver supports set_period, then it correctly
+	 * handles all other requests, for example, that
+	 * led_set_state(LEDST_BLINK) works correctly.
+	 */
+	return ops->set_period != NULL;
+}
+
+static const char *led_sw_label_to_cyclic_func_name(const char *label)
+{
+#define MAX_NAME_LEN 50
+	static char cyclic_func_name[MAX_NAME_LEN] = {0};
+
+	snprintf(cyclic_func_name, MAX_NAME_LEN, "sw_blink_%s", label);
+	return cyclic_func_name;
+#undef MAX_NAME_LEN
+}
+
+static struct cyclic_info *led_sw_find_blinking_led(const char *label)
+{
+	struct cyclic_info *cyclic;
+	const char *cyclic_name;
+
+	cyclic_name = led_sw_label_to_cyclic_func_name(label);
+
+	hlist_for_each_entry(cyclic, cyclic_get_list(), list) {
+		if (strcmp(cyclic->name, cyclic_name) == 0)
+			return cyclic;
+	}
+
+	return NULL;
+}
+
+static bool led_sw_is_blinking(struct udevice *dev)
+{
+	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+	struct cyclic_info *cyclic = led_sw_find_blinking_led(uc_plat->label);
+
+	if (cyclic != NULL) {
+		struct sw_blink_state *state;
+
+		state = (struct sw_blink_state *)cyclic->ctx;
+		return state->cur_blink_state != LED_SW_BLINK_ST_NONE;
+	}
+
+	return false;
+}
+
+static void led_sw_blink(void *void_state)
+{
+	struct sw_blink_state *state = (struct sw_blink_state *)void_state;
+	struct udevice *dev = state->dev;
+	struct led_ops *ops = led_get_ops(dev);
+
+	switch (state->cur_blink_state) {
+	case LED_SW_BLINK_ST_OFF:
+		state->cur_blink_state = LED_SW_BLINK_ST_ON;
+		ops->set_state(dev, LEDST_ON);
+		break;
+	case LED_SW_BLINK_ST_ON:
+		state->cur_blink_state = LED_SW_BLINK_ST_OFF;
+		ops->set_state(dev, LEDST_OFF);
+		break;
+	case LED_SW_BLINK_ST_NONE:
+		/*
+		 * led_set_period has been called, but
+		 * led_set_state(LDST_BLINK) has not yet,
+		 * so doing nothing
+		 */
+		break;
+	}
+}
+
+static void led_sw_free_cyclic(struct cyclic_info *cyclic)
+{
+	free(cyclic->ctx);
+	cyclic_unregister(cyclic);
+}
+
+static int led_sw_set_period(struct udevice *dev, int period_ms)
+{
+	struct cyclic_info *cyclic;
+	struct sw_blink_state *state;
+	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+	const char *cyclic_func_name;
+
+	state = malloc(sizeof(struct sw_blink_state));
+	if (state == NULL) {
+		printf("Allocating memory for sw_blink_state for %s failed\n",
+		       uc_plat->label);
+		return -ENOMEM;
+	}
+
+	state->cur_blink_state = LED_SW_BLINK_ST_NONE;
+	state->dev = dev;
+
+	/*
+	 * Make sure that there is no cyclic function already
+	 * registered for this label
+	 */
+	cyclic = led_sw_find_blinking_led(uc_plat->label);
+	if (cyclic != NULL)
+		led_sw_free_cyclic(cyclic);
+
+	cyclic_func_name = led_sw_label_to_cyclic_func_name(uc_plat->label);
+
+	cyclic = cyclic_register(led_sw_blink, period_ms * 1000,
+				 cyclic_func_name, (void *)state);
+	if (cyclic == NULL) {
+		printf("Registering of blinking function for %s failed\n",
+		       uc_plat->label);
+		free(state);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+#endif
+
+int led_set_state(struct udevice *dev, enum led_state_t new_state)
 {
 	struct led_ops *ops = led_get_ops(dev);
 
 	if (!ops->set_state)
 		return -ENOSYS;
 
-	return ops->set_state(dev, state);
+#ifdef CONFIG_LED_SW_BLINK
+	if (!led_driver_supports_hw_blinking(dev)) {
+		struct cyclic_info *cyclic;
+		struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+
+		cyclic = led_sw_find_blinking_led(uc_plat->label);
+
+		if (cyclic != NULL) {
+			if (new_state == LEDST_BLINK) {
+				struct sw_blink_state *cur_st;
+
+				cur_st = (struct sw_blink_state *)cyclic->ctx;
+
+				/*
+				 * Next call to led_sw_blink will start blinking
+				 */
+				cur_st->cur_blink_state = LED_SW_BLINK_ST_OFF;
+				return 0;
+			}
+
+			/*
+			 * Changing current blinking state to
+			 * something else
+			 */
+			led_sw_free_cyclic(cyclic);
+		}
+	}
+#endif
+
+	return ops->set_state(dev, new_state);
 }
 
 enum led_state_t led_get_state(struct udevice *dev)
@@ -69,19 +240,31 @@ enum led_state_t led_get_state(struct udevice *dev)
 	if (!ops->get_state)
 		return -ENOSYS;
 
+#ifdef CONFIG_LED_SW_BLINK
+	if (!led_driver_supports_hw_blinking(dev) && led_sw_is_blinking(dev))
+		return LEDST_BLINK;
+#endif
+
 	return ops->get_state(dev);
 }
 
 #ifdef CONFIG_LED_BLINK
+
 int led_set_period(struct udevice *dev, int period_ms)
 {
 	struct led_ops *ops = led_get_ops(dev);
 
-	if (!ops->set_period)
+	if (!ops->set_period) {
+#ifdef CONFIG_LED_SW_BLINK
+		return led_sw_set_period(dev, period_ms);
+#else
 		return -ENOSYS;
+#endif
+	}
 
 	return ops->set_period(dev, period_ms);
 }
+
 #endif
 
 static int led_post_bind(struct udevice *dev)
@@ -113,7 +296,6 @@ static int led_post_bind(struct udevice *dev)
 	 * probe() to configure its default state during startup.
 	 */
 	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
-
 	return 0;
 }
 
-- 
2.43.0


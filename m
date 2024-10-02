Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E64CF319E
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 19:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E792B88A4C;
	Wed,  2 Oct 2024 21:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="aGCXr1uk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D03988A43; Wed,  2 Oct 2024 21:23:29 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B8FF88DCD
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 21:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bt3iKlVeCjCz8iWVzL24W888SswlmlheJB3b9QKSPFgj8WJ0pseyuAVstZJN52gl68n3xdYIE2QhommqHO/a5oB6v3GmFtoML2uMkmdp4WSvAuTzsnbKax5ZQ+etThXVyRcY+Nkn9HNFIfRsbrgOj2ieZ4XqiX9sI0miRbC/VEUOdAy4+K/lNCLALKKwIHFnVrFySb3gtEpymjcDn3adLj2KXNvwNV3XXZpDGnE713wXRrFLYJ+j8NZP67fkwFxXzKL2pUuH9vFQoN0eGfYIXjImx5Hq5Q3nRE6zeMzNYTEIN6c24BB4kCiNxOfffq6orNIFWl7sAxryROYgxuQYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dg8TGKt+KHiU2VwdGP15rxBmFr7scc0YNIMF3agOFmY=;
 b=H3O9mfc6kIH5e0DzUo1Fh2zSt0nR1j8VevHL0oM8IBCxWeTUP2mJWo8jZQVufzwxgRsG+ymoEILgb363KFucaTRECkcTWLogZ24e/BXLR1tc4Erc7n835K21FfujM9G3D7NXIKlsuXccNdkaV7hLZfvnLtlAlmom4jUYHjCXejjS+zRARdeXmNVVS88gdkvgYaLw3hxcGypXRMULH/Y6El0lwwSUueaL+FNF76L4hjQdazgZ1wkA+367qrY5h9Xi98W1oOVYtiRPKJKNIJpRuZlgqv0dwtmcJyU3oPaTySQ5JVH+3tWa9tE9dTmSE95Px+Dlxnk9iX9iBO0XzAOn3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dg8TGKt+KHiU2VwdGP15rxBmFr7scc0YNIMF3agOFmY=;
 b=aGCXr1ukF8aTy125kRCdXy9uj2jrsd6k9jxAot7TeTH8aK9dWjS0AAGXu0lb65Rqh7xCS0EEqgtSgAsoNPeSp4u3g1WzQFM9d4+FycmKCO0XHMrF2Y9ftYk4wz3osW241b+xPBzOOx43go9vCnPrzZpiImwTIIKkv2D1DD7uPKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM0PR10MB3651.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:156::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Wed, 2 Oct
 2024 19:23:25 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8005.026; Wed, 2 Oct 2024
 19:23:25 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Paul Doelle <paaull.git@gmail.com>, Felix Blix <felbe@prevas.dk>,
 Stefan Roese <sr@denx.de>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] watchdog: gpio_wdt: add support for stoppable devices
Date: Wed,  2 Oct 2024 21:23:23 +0200
Message-ID: <20241002192323.632822-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0098.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::30) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM0PR10MB3651:EE_
X-MS-Office365-Filtering-Correlation-Id: 609d6f8c-b045-42f1-d218-08dce317afc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b0hzyTKimd0HsjP4rPbxMXQkNc4jcYhECwtrBbOBg6NcG3wvH41H2v7WqfK3?=
 =?us-ascii?Q?MrShGG3ShKdKPlvBo0U+9MJ8RS5ED8pQV7WLVaND+QHgXD2IHmenj6ZN83vF?=
 =?us-ascii?Q?cYhLV/HSub7VCL30oiekNwe3mfTSyPKkFhtguH3WYNldIjdKkMEO2WoMo6BP?=
 =?us-ascii?Q?wDMEZ3uA32ViVTNrPu8nuua2dCOlkxsxnMx7H0WdPT+A5rJNFQPG8VTcucL/?=
 =?us-ascii?Q?qU/eIqJwxA06iT33q7rU9K9TiK0cAiSo9UcXA821zPykFPCl7rLx1ynl4/kH?=
 =?us-ascii?Q?qQi3qlDGIMyLKOs1AQsx6H5TytsdgmyUiU4mWvICjarjJ62X/dXOz0j0S1Lu?=
 =?us-ascii?Q?B4ME2ISIAGFWHxKc+LiZcWTQV3kYamlUMG9O4kdzSXxhqSRODFv7TX5Iv+uI?=
 =?us-ascii?Q?gEIpYPTLo9xPsX7LZkB+cVFxP9iKb+wC5s6kJk88EAqlUv+NHFP/SnfdMzdU?=
 =?us-ascii?Q?u1HURbSQtpHAdQgGU51EmZ98OCucXGn2JQEqWef6h0QZU0fN7MRL3z1CcEQg?=
 =?us-ascii?Q?dyNF2VGceEYMCmleRvq00BonuKnLmB+TOTcCri7V7wf+EyKpxh8aLgLWsjDU?=
 =?us-ascii?Q?fbIvndy6JXeUd2YFzhAOKs5Ua8MBRQ62kOxWbRe9qMq/jDcpeJl4B4tporG1?=
 =?us-ascii?Q?ITke9QCoCxt+CO+zUgIo/86FYZeYTHL0IAMa8o/03GuWBr7o44Nz6XrGD02j?=
 =?us-ascii?Q?TELXB83bs791cdUNEe9YQ2Zml6tiXaYIqtkabiCWjLQqQb/an1vf+hzpdLQB?=
 =?us-ascii?Q?C8wfEPb0nD9Y4VrBD8V9VRU4d1JBqjjAhz7bIcHW6iZ6/RhfM1+F86ohntiS?=
 =?us-ascii?Q?eWaCZNCV8hfu0kbN9WJXaCQGTLpPkWz8naiLY1pX9TObCT6piBcYLNi4/AOj?=
 =?us-ascii?Q?AEh/wkn72U56lPGuQIOes6wFT+2GfqyXWaOSYyogCbxJyGqZSFmlM7GvPLgr?=
 =?us-ascii?Q?AKDXnRzeafwkWtTe9j0O1r6U+Ib/6dQnHZnOmRaQboCxFz4/1Cy7FnyyoGoA?=
 =?us-ascii?Q?rFdurek9CgxBLFRXEf7fmcm19Oa0gIdUQOwRD2FTwmhjOrGObigGLCvmORjJ?=
 =?us-ascii?Q?hAcYNg0afkG2xQh0uWhucNgoCeNK58Lr+FRxhYHKmFTxDdt4BpLmfrNJTjDS?=
 =?us-ascii?Q?sQUzIt9LUT0L6ME8GZGE2GxDLmEaoZhdNDU79+Dm8pAY3z8on8qinpv5e9QM?=
 =?us-ascii?Q?m5ibOPX5djg/r85jL5VsGsZiH+2U6yZ0u1KRmPFhtayG2EvbvTsUDumevF5/?=
 =?us-ascii?Q?Yqi6P9sWBPI01uvAK+yVGfDfwYJmHWaaj1ZkaG3u8lolRp5exxq4Jo1IfTwo?=
 =?us-ascii?Q?A5tiFi8BHJ8eJ7SVaTgGWaXzgyhTouw7LwjG+9fa0mGvnA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eJr09xsFs/lX1JtY0fbh6YbRL6FTuMnD7x8BkWvZ+Jzo/xQ/7p9HItelyLH8?=
 =?us-ascii?Q?77OWqt+pJgM5nVNv8wIodzSS4xji5m6ZiWhDxni6UzuhFRTGLvDtgkzjP9DO?=
 =?us-ascii?Q?bQu7j/QppfRHCT4q3RQfvrZxSNoQni7rrz2o+EOk1Ofot8DAOs2DJ79knQFB?=
 =?us-ascii?Q?jRuj/DhY2XCuAoe0bVsqR+eit7Rl+tJYqBE6k4Fd7McgUch9fFGUjvuTG2Z2?=
 =?us-ascii?Q?1w9uN/jMUZzN/zBrbTBcc2LGXhYHRypJ43fD80a9HmnUaamRkd0o13XdbcvF?=
 =?us-ascii?Q?sgihhjwMMTOKskjylhdFfeqnrpqlSgUmuYtSflJn9GwZXDI23eLDX39JhKdb?=
 =?us-ascii?Q?tiuXbExgpVSbjBqeSkcoEY/ZYkAIqA4QxoAApVAr1ilA6wuDhElZoFmVLypY?=
 =?us-ascii?Q?toFtjhLuJU3dqrsRzcbLjW/jSS0H5cNYVinmRUdGjobw4+eBM9fe9ud6Mz0N?=
 =?us-ascii?Q?QkqhB8F9d/InnxIxdYAglfH2D7ts1W6Y4nk7M/aA7g57zSwIi8aWj4w5JXJX?=
 =?us-ascii?Q?r7PuEtvb2yIKl10CmGd3tgaic7msXfRnzvSsRXffeXT7C2faj/wvGB9uu0ih?=
 =?us-ascii?Q?XYzGJNDCatLGA3a7h6e0aOoSIzE0mTxHmmewy5dZny1Q0yLQq5O+1iO4z3A3?=
 =?us-ascii?Q?192Itz5vTnq9e7gg0jJLNluZmR9EnvdrVGgcAzq/3nha7rB+Jc60OhutQgZv?=
 =?us-ascii?Q?md8kDMDkTGLbgi0EXN6XxzaR9Yu+HUobA1wm5QXw3CU9w2it965c/ueyrzsS?=
 =?us-ascii?Q?pE1Wu8I3pIfi0MzdEqOJYx+ZqM+4uqOdncxFeDRTyh853N7Wkr322jwliCk6?=
 =?us-ascii?Q?vTGpuBK+SJna5FFFXLo8jrBl03gRAAmW7+eE60rODtn3ooodrlApBwX199Nq?=
 =?us-ascii?Q?YYuuPolvG3BeH3MmgAE60T1c0GZJkUxYlrG9csWo2X8rXCd589x+ytCYZyeS?=
 =?us-ascii?Q?imoC8GZb6OkP3FlxZHkOy06R6cHIohBBEibUF10IjZiCc+vTdPMLi3YLCYO1?=
 =?us-ascii?Q?1QOOVeCYsxaR5bKMA+q1LLRfwKp6EsrBV+CrQNw8yeqU2qvRn16S0HEto5tw?=
 =?us-ascii?Q?7OSPf2hokKb+tTbT6WQ+09AziagGEM4lvK4EUkIOxPwpflIkCDJ4INvWZ9sY?=
 =?us-ascii?Q?tuaLD5GXIL8gzHO/rJIJNxe89oA0T2vg0qvx2Gc/VN0HP0v1LHqu1/qOcTP4?=
 =?us-ascii?Q?gm8qzy+EUg2M0OfkxoFWWIrdmwueIK1puCZURVDKoPl3QpB31clea34JQ2LR?=
 =?us-ascii?Q?HOoZh9AcLOdAUQDu9wNrq609NsBiyiLQzxFCjXUMO3ArZ8PMN3RSAx4S1FBg?=
 =?us-ascii?Q?Viz3snLPB5FspoZA4zETCkkWq3mJdhfyMKrDgxTJPdUGIMj+2u8rTvFaBfKc?=
 =?us-ascii?Q?kquPOB1p+1HD7pSaReKNRNCRmvpJrP+TvOLNdS3bazcgqa6vVYP1Kk4oCgES?=
 =?us-ascii?Q?ArESYQEmUqsp9sSVBpbSa4ZcJMycCoWKWctiSFunnvsDjkjKa/SIaKnZHN9Q?=
 =?us-ascii?Q?3wf/pTep9Xwx1Lk/4+AFRB+BVReLsskzJtaXbL3FzmA0N9ZQD8LyxhdEmiOP?=
 =?us-ascii?Q?RMmkmdw2/er5YarfKip2BIBvDLt9ZkYyxeCU+0HEYFbhV2ieHLDF6H8ZECPe?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 609d6f8c-b045-42f1-d218-08dce317afc4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 19:23:25.3787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hI9x9pbE5J2gSAUwIGWZuDSR9j6reEn1umj+VCT52psONM+TtrHyc7/bsBW6+wmfrytBU4jlCtGv4kl6AC97OMBgjFR8RxztBmFpv0jpXKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3651
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

Back when I added this driver in commit 2ac8490412c9, I wrote

    The corresponding linux driver apparently has support for some
    watchdog circuits which can be disabled by tri-stating the gpio, but I
    have never actually encountered such a chip in the wild;

That has changed now; I have a board with just such a watchdog on my
desk currently. Add support for that.

- For a hw_algo="toggle" device, the gpio is requested as output if the
  always-running flag is set, otherwise as input.

- The ->start() method is updated to change the direction to output when
  required (i.e. it is not always-running).

- The ->stop() method is implemented, but of course reports failure if
  always-running.

As I still haven't met any hw_algo="level" devices, I'm not entirely
sure how they fit in, but I'm borrowing logic from the corresponding
linux driver:

- In ->probe(), such devices always request the gpio as GPIOD_IS_OUT.

- In ->stop(), the linux driver has an "eternal ping" comment and sets
  the gpio to (logic) high.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/watchdog/gpio_wdt.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 2920c2c751f..e889861e917 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -45,14 +45,32 @@ static int gpio_wdt_start(struct udevice *dev, u64 timeout, ulong flags)
 	if (priv->always_running)
 		return 0;
 
-	return -ENOSYS;
+	dm_gpio_set_dir_flags(&priv->gpio, GPIOD_IS_OUT);
+	gpio_wdt_reset(dev);
+
+	return 0;
+}
+
+static int gpio_wdt_stop(struct udevice *dev)
+{
+	struct gpio_wdt_priv *priv = dev_get_priv(dev);
+
+	if (priv->always_running)
+		return -EOPNOTSUPP;
+
+	if (priv->hw_algo == HW_ALGO_TOGGLE)
+		dm_gpio_set_dir_flags(&priv->gpio, GPIOD_IS_IN);
+	else
+		dm_gpio_set_value(&priv->gpio, 1);
+
+	return 0;
 }
 
 static int dm_probe(struct udevice *dev)
 {
 	struct gpio_wdt_priv *priv = dev_get_priv(dev);
-	int ret;
 	const char *algo = dev_read_string(dev, "hw_algo");
+	int ret, flags;
 
 	if (!algo)
 		return -EINVAL;
@@ -64,7 +82,9 @@ static int dm_probe(struct udevice *dev)
 		return -EINVAL;
 
 	priv->always_running = dev_read_bool(dev, "always-running");
-	ret = gpio_request_by_name(dev, "gpios", 0, &priv->gpio, GPIOD_IS_OUT);
+	flags = priv->always_running || priv->hw_algo == HW_ALGO_LEVEL ?
+		GPIOD_IS_OUT : GPIOD_IS_IN;
+	ret = gpio_request_by_name(dev, "gpios", 0, &priv->gpio, flags);
 	if (ret < 0) {
 		dev_err(dev, "Request for wdt gpio failed: %d\n", ret);
 		return ret;
@@ -78,6 +98,7 @@ static int dm_probe(struct udevice *dev)
 
 static const struct wdt_ops gpio_wdt_ops = {
 	.start = gpio_wdt_start,
+	.stop  = gpio_wdt_stop,
 	.reset = gpio_wdt_reset,
 };
 
-- 
2.46.2


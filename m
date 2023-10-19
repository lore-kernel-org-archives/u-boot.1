Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8C9CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 09:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29E20871C9;
	Thu, 19 Oct 2023 11:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ISEayV2v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B4CD871D7; Thu, 19 Oct 2023 11:58:52 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20703.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe12::703])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EC9E871C9
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 11:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUj/wt/XJyb7zfJtutsL0B22A+V3mrx1qEgC4D9sJEK7vK4ergfc/yn0t7nuvY6K0aNkzEb6Dt5tUbIZMD73/O3iPVsJXYAluxF+IZeAjaveVZAO6BirGKPcXzoRhC+PyU3mvvLZV2G3VVERqVSG3yVlmH7XPFN98d98N7/AEgIfk0o0BqrIULznsRu3bpf+eOZXhsiXnZhQVgNnlGnEUW8Dfik6B1uPJKJs8i6RvcJ30GyRtAtAxIG8N3ly+juDGRSSePvO02Y5jiRqGuP+lHFtlPYE46Bi+9YS6hH9nQNAzz20Rv2Agza88Yy1CXg1uEEBZcBPY4VLBgd++SnKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DNUCT75Z3W7mhKDVWh8gHo42/HIrkqYEtkKL5ABtNs=;
 b=D/Y0GVByeqxNrmpjv+xFoFE0KC7IBB2cu1dq1AYP2Xe1sSGNHbYd1KN45xkS4ZYCNq3mZxcIrday7/AyUtUA3bJxZUC5dkqVjTXpJcZ13IMM+NO80YanpPqz93jbB3WoDz59E1jsf71+f24vTFv8ic8G9yUdrg88bRxZgwfTbimTMxbc5ACSaiBe9XoRQTNXxLeDFjShu4nV2pG9cKkQMJveMpICVTuuYSapqrXK4dtjCKtImPmJJ8r4bk/hHUkJQNHVT0SrwFu5KJcHdG7FZuHa65M1owJ6Ts3IDf13ttVRPG+DYh0JGcVPHU2yBh6qFPQbCvWdj5GPVgfYjo7nqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DNUCT75Z3W7mhKDVWh8gHo42/HIrkqYEtkKL5ABtNs=;
 b=ISEayV2vnGihxf03pUWD5UxizL6nvxRNSBd7Bk8VMzyoTpq+eDJxAHddUorJHXTnIOIVJYZumcvbxdqoy/IDzWb0PFnHACmwpTSf1baM420XN5XRYAu0UacKGMUEyiZRtLTwemEYbKXaGqsYT2it54KTLRYS3+kfQJ8JUy+q29c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU0PR10MB7481.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:424::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 09:58:49 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 09:58:49 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 4/6] led: led_gpio: use led_bind_generic() helper
Date: Thu, 19 Oct 2023 11:58:35 +0200
Message-Id: <20231019095837.2084458-5-rasmus.villemoes@prevas.dk>
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
X-MS-Office365-Filtering-Correlation-Id: c4374f8e-6ebc-473c-9141-08dbd089fdab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zZ7COp0ieYWyHexibZ9EsZ5QMB7I30TsELGHrbYUDK40fJ5yhrsu4zVblwrgVcHNrPQrPP23EMEI/BDq4A8fIRe/BjYFbpkWaNAFQF2Rmnzoqex7dNnYsSPueafnlZnUs9iopH6ojKBt2ci3e4Cn0zsam2aOodUi6WLq6WwS/cjxreAZ2xk3c8yx6GGtbGTBMQ5uslD3dmhSC0J8DXxrXNjSlutqI8UphMTy6QCdTiICKb4yMh5O+fZo7TA0XqSRmBFF+1djzOpE1wv2NINnFd8ZHtt8JE1P8MXfM9G9+kD51w6HbNXGVGPWF3FVFhdO1ptcKETOcCf45RDOduLaOT4HeQexvKVvGd9J9GRLf/aLuHriWghVfwzlNrwabxA+RGyofIy5LEKlgtdsrCGvZxfzmr1QfeQF7T7/QoopKizVbed8wIWJojvsj2XPNFmwrY4Vk6WWsLafq7QuPGcOjps5RqqvxWTNNoUWHqBCcO3rl0UCvm7uzrtBo8fl5DvptJEUjzLcSfskusCBf4JXMTwADWSWEy8CMTLAEBrIr3gRes7kJuWu1fqW3jsouRKyEEK6Tsc35UMfAWaETrzaSoJZuAS2vHmas/9bXJ5vxghiHRwfvrOKxjvnlFiCJNxu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(346002)(39850400004)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(38350700005)(2906002)(38100700002)(44832011)(41300700001)(36756003)(4744005)(86362001)(83380400001)(26005)(6512007)(1076003)(52116002)(6506007)(2616005)(107886003)(5660300002)(4326008)(6666004)(478600001)(8676002)(6486002)(66476007)(54906003)(66946007)(6916009)(8976002)(316002)(8936002)(66556008)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U4DebuCjQXLaa1h9hYnOo6dgnvDFFzFO+UgulseX5yB91gTxL+wcMe8oVsBL?=
 =?us-ascii?Q?fbNL1ghgUyzacftETHldcfwplt/fBs4rtZSfblrt9WKx/AgB/l6usYulfCLf?=
 =?us-ascii?Q?YZvRnPz9/bTEe1ZVbqZ3Ghlc1NmPwdFmhWSeVFSAUnk6UDcVMgbsRwXw4hdG?=
 =?us-ascii?Q?iaNdaBNrjM+rTO60agJVSG+2Vn0DwpQtJ6gIpF4jazAXKBxBmAiOW+FfvFxr?=
 =?us-ascii?Q?Clcbt6H+Ked+gib04vF8BvnmfrTisagF76cyF8HWBy3ZG3zuv9xnGgYoFsTA?=
 =?us-ascii?Q?QsiKlu9VhEw9gEHECYPy9fvR9xs+m30N/A3QtzyE9i+A03rKQMIQBa3bvBHg?=
 =?us-ascii?Q?Kg5UXJ28OIMt221ohULCOwJGGuSa/s4CAxqcHTtElfIDoR8gZF4qjH584wOx?=
 =?us-ascii?Q?urDo9AT7aJOK6YgNq2c784QZIW/dQ9GbydzA/hRxBHST6fpwS9dFQmGz+UTM?=
 =?us-ascii?Q?x8Im5lXkLuftDGtqpwkQXYuXWSgNRiG1XIhZ/a10GtyToItHYPjYkeSe5Wfj?=
 =?us-ascii?Q?Q+cVvjSPK1mrhrbgs0V3ZY2eiaZGjayozILZMJ/76zRIcZ3f0Z7SJHypMkJu?=
 =?us-ascii?Q?PyQatFMtBL8rfq4Dqh5wL94CT0rBj2LEVGTfhqX1oE95H+lAQYXuU5dMnOMC?=
 =?us-ascii?Q?GJGfEYDAVGYIw5d3Tx/f3pmx5j07wH8ljn58riunsaunMmk0Kw0n5Y9ypfJS?=
 =?us-ascii?Q?WH9zGRI85t2XS42d2mtiB+dBDuQ/94UYXxqvsz9+F8XqGX8Tn9mCLTyoRqA2?=
 =?us-ascii?Q?nQbLE5nFCQWaMAbv4bYwrhyEq25k+/dD85c/Bbfh6LC8SCnoV3tqLeEBx3qz?=
 =?us-ascii?Q?Cns51PEGOI0NFjhugG1ryleZ8QgFfMSdij0/44vGQPxJ5Mkc+eUPLFOdKP0h?=
 =?us-ascii?Q?xkUWeceaWJxFcayaSWX1VO7TYG8ECqlO5maUZ6GYqsEtF6nKvKLKTxvzuoaQ?=
 =?us-ascii?Q?GP2G4IIrORqvldmSibKsJpm7SkRz3wM1nD3hdizFcS5W7NQkrh5PZ9aIwU8J?=
 =?us-ascii?Q?UZJu9/wNTaUPXvFNteZb6ZW0EXFmvWujPg+4xKK6iwujC1oQuqeFCsumUJ8w?=
 =?us-ascii?Q?gjRX1aKOkPfdzrP2mCXyCmSkCbiWKotOSK1WUSR6pClbpWEf6iLKv7Hw/3tk?=
 =?us-ascii?Q?cG9C2ruC1OxEWepE+xaJfGR75CPkroKgDudVSDfQnG/KSOnVqcbPWEYG9uKs?=
 =?us-ascii?Q?c26+lTvk2ysf2aJOVQCinCHdStoNaeM5/wXc8F6d3FjAldf5OF59IhnH5k2W?=
 =?us-ascii?Q?/jFxD+RfXb5rlZsXdJRdf3ndADG3EGYDGMYFExl0zND7RpxtszuaTaBjGBfe?=
 =?us-ascii?Q?NnGP+ouGLGmVEzb863ahZqaRMCzOlvK/8HsQ2/Es2lVaMKItugtmP27rqGw9?=
 =?us-ascii?Q?S0DF61B7HERzONsfGk9EiI+B7o/3o5QbNzMeNfuAYc8HK1q9OQ3DxlLi11/G?=
 =?us-ascii?Q?esQnw/6pOrvYYUzE/ac+d+xjc2Ymfpk2wH42ix5P2kNPu8ar1OsvBJCYZL60?=
 =?us-ascii?Q?xjXaTL4mdDzwLpeKCWOJbPTj2J/9jvLSJ0+E01ROz7hJVWfxU36n3CZoZ8iU?=
 =?us-ascii?Q?7zjijh+KPgfihcR/ssweIp3s16Giw/9KsP0Ae5CCUhw/rMv2mLKk+PgS4x66?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c4374f8e-6ebc-473c-9141-08dbd089fdab
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 09:58:48.9818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlCRpUijVIQNZELWTUAse0kHpYtl3Blm4eItMcal+6KlvaHEjCyWI7eldyWxVGzjPXODK320FCRNDW7cYrFvd56hUOXGLYCYxgb0N2O9sH0=
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

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/led/led_gpio.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/led/led_gpio.c b/drivers/led/led_gpio.c
index fbed151b5d..71421de628 100644
--- a/drivers/led/led_gpio.c
+++ b/drivers/led/led_gpio.c
@@ -11,7 +11,6 @@
 #include <log.h>
 #include <malloc.h>
 #include <asm/gpio.h>
-#include <dm/lists.h>
 
 struct led_gpio_priv {
 	struct gpio_desc gpio;
@@ -80,19 +79,7 @@ static int led_gpio_remove(struct udevice *dev)
 
 static int led_gpio_bind(struct udevice *parent)
 {
-	struct udevice *dev;
-	ofnode node;
-	int ret;
-
-	dev_for_each_subnode(node, parent) {
-		ret = device_bind_driver_to_node(parent, "gpio_led",
-						 ofnode_get_name(node),
-						 node, &dev);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+	return led_bind_generic(parent, "gpio_led");
 }
 
 static const struct led_ops gpio_led_ops = {
-- 
2.40.1.1.g1c60b9335d


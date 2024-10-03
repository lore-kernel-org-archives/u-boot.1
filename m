Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71ED5CF34C3
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 21:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCE1688FAF;
	Thu,  3 Oct 2024 23:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="YeeJSBIi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 079A188EAB; Thu,  3 Oct 2024 23:28:23 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AF6C88DD0
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:28:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5wp3AgqYPlYk8Gqp3p7uwErP+vn4/YvVM2LVuX+Li0P1vLKB16yIdhACjpmBhPRoLWK742M3d7WUTtBig8yQbPNw0+TX5DZ0LDaiDsRZHXTtekUgM2OtS8Hor/xMuPbBd2AWGvaQEZriFYQaU/i4FJylnMnUzLf0zYzIF7moNQBVN0TtvA5M3UkJ3+hNpc72IF0SqG5dAXJq6ZYhuLoNFRbOBLY9D0pMI5pjfkOy7URaGhTRFGEV08nmelPilZQOpzciDbXaZHwXucDoUyleJk8c9WK/gvlPsYGn0r1ENfhOfGxf3u7j68d6Mr1L3O0/X/4cQOKzTfvDGNFOEREqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSawR9H8qeTcjd1HTONRmgGwMTTvkx5KYSms32G/leI=;
 b=wN7e6Wlc10HmfCM7JvnrXBRIA9ZUZdQz89oiyCV4Btd8P6Qx690yymuTCSjzTcTVoS7+S846ojtnMVDehb5TXPZxTzmQjHpfcuZKFDfNXwb8sEc99Pa2xRyOcYx/3GK5Q6gN4Cuuhw/jEYn1rml6XYuhRZDN4lUghez+8sek9bmcAIZY/ZNahPHPLWhUN9Pr48gK7Uqri/YSvL/ZmP5F57BLZSsHkjdqLSLCpzGVeDJEiKE89QJheTV25ezB0r+pu3WxFoNgtaGLwpEt/+53BrA/irNncH9B6m+h19x3iee/KC59FR6Y8ef2jrdSrO5yzXZV4d0OcK6V/hjTgTLWrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSawR9H8qeTcjd1HTONRmgGwMTTvkx5KYSms32G/leI=;
 b=YeeJSBIidgXryEcBTz7CAOproaTF8XRXIIa/DqHmzt4LmBRIcPb4UyigAyflxKGfJzNqyW0jv3bnIah+Bro1N1Ks50bGBjZinagDBo7rRzjroCeZdVZZtcAhFZ3mTYgH6sNUKpW4JDJMWlQ6ZqCNBbDdLBck0I+JExq79Yr2YX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB9PR10MB8118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 21:28:18 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 21:28:18 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 06/13] test: dm: wdt: replace cyclic_run() by schedule()
Date: Thu,  3 Oct 2024 23:27:55 +0200
Message-ID: <20241003212802.3810-7-ravi@prevas.dk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003212802.3810-1-ravi@prevas.dk>
References: <20241003212802.3810-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0045.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:b::8)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB9PR10MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 0500f4c6-b87d-4362-687d-08dce3f24c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c8AKC/d0Y9B0o34c+qzQ4Hkk7LkEOjMIuIL8OkBdTQWax/RIryLjPL4mOGNW?=
 =?us-ascii?Q?56CTxIrzk9ehCDYIxY8EyvFBLyPmjCYWPvpkQ3dFhTf7H7tWtmOkW5NDGvon?=
 =?us-ascii?Q?62CF7Wv/m2Rctzw+Kx4oGK2pqi/lUTeXtq1f7uRTb+KsISMmv6Crrvgx2IAS?=
 =?us-ascii?Q?b1nLVhMrwBePnuqcdlr79cBCzuhn9KLCiudHZryiSbqj/m7KzR81K2bV6D17?=
 =?us-ascii?Q?YLIlDw63Jygxv7DXo12NQCv/36HaGqSV8OpWta0rAxeWoEaDUv+UOQX9MciK?=
 =?us-ascii?Q?XSmGRXAoE26s8pXsxQdF34UlgYDNKgXUwr68tnZg5x0O4y9BEESBjxVnMQ4R?=
 =?us-ascii?Q?OD1PAsAnRHf2eu3OGXzjoTB8jQJJ/oG3C0G8FsnTYXE0cy4A8IHCrC5jhlfX?=
 =?us-ascii?Q?taPwaQeLJ5kLi2rV6Tf0LJxD7eIIZojfcaVVy7rm6v7Pe2EhblcVR5axz0Dj?=
 =?us-ascii?Q?Qsz76BuXpaR9NmbTG8lRBP6TO8eMux972oCK7aGR6VwFqosE925c5qPn6+Mn?=
 =?us-ascii?Q?0+E2bDfGYkg2fJ2xeGdKKpYzADYW0BbaE14BXvVFUk63nacnFIh8B1wNx4On?=
 =?us-ascii?Q?FrGAz01pgaknMP1c9GDK6QciCzk6g81Kk4Jtx6k0RQml/BXJZ4K5NKN/7pw2?=
 =?us-ascii?Q?NXxemTYyKE22ctkjip+vV1AOUWc0cLELfVD0Zc2oCqI9T0OTGYAoKmoRcIuv?=
 =?us-ascii?Q?+f0viMmRLP1ccjv+M7RL6ay2BiMlt3ApktJPcDfLv7t/zWxQpF/kCT7PS318?=
 =?us-ascii?Q?Yfi0xxvu0II5VqjT2wi1F6jyPu05/vMhrflzhJcHdLoLvrMlPZFIwy+aqNMA?=
 =?us-ascii?Q?LWn3zEuwsSD4h4VstF3ovDw6iIyFBDt3k+t3tZ6pKQ5DvRJL4wZ7Iqoga1JG?=
 =?us-ascii?Q?E9uQXRWxfzA6/dQC8vClNsEWL7zJHF5UIkxQd6DAsK4nsQ4/AVjXUL9yZ7f1?=
 =?us-ascii?Q?oO8SSyCHaI6efZH2hisLAmfS5gkJRtmtnJWhFQHCXj2fMwsZFI5xH88x5Vrl?=
 =?us-ascii?Q?q35i0WKOI3dW6VLb9R35WYSlN3+pchG7tNod6DGkyItSlJ1C48eqesvUCzJk?=
 =?us-ascii?Q?tunOTlO/41LCQ4HmhQ4Hs3GdjVmVBlmsukbSgP/V0EkzdY5Kv294W+fY9oHE?=
 =?us-ascii?Q?hdiZd9hFg379FUAL4sPfGbqOC+iXM6/w/D9pWcxYx+DL9ELAsdpjq6RbxfC4?=
 =?us-ascii?Q?zFnohILqK2QoQqRXMK0pT8bb6aX8GSFJb35608tgO3TVRdgYxjVu3VMvZNVt?=
 =?us-ascii?Q?okZ/HuPWmh509WkrSKR1Boy7gnj0kxQ/fLk9uDnXDqbcaL+5TbyE1ZTK7Xsw?=
 =?us-ascii?Q?2bH5xHN3sJzvQ+6d7He+qfN6Oq56mih0c5cgCx+BA0VFYw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HT72ClqnwP4SYtXmn0a5Z/gLrnPAelbgd+yDW2s6KYl99ds6UdoQyj4KWmf0?=
 =?us-ascii?Q?c3k2DW/ySoo81w46bIKBo2JNVHQSvYjbj3j/JblMij3nV3IwUpfY0kziLEgz?=
 =?us-ascii?Q?jroM+J6tZm5T7c/QaFSd2Ycd8nB+3AygCAWv2c+lDzkQJ2pWtXV/o0vl2UUz?=
 =?us-ascii?Q?prYUD3A+JmK+jWF6re02/euTmcoG5+7qNSNVQkkJBhkyElKJ4ESeFyyJgwVH?=
 =?us-ascii?Q?MquvOWIA0qCw2IRKsmbhRbV1SMvxP8Dk2VyE+VD0FLYcy4wT1dqHdbSyDkqv?=
 =?us-ascii?Q?Rj09j6EhJ21u8kp1vhkxezoTerjiM23CE1RMBMTRD2PnUTMg9i8CyMzg7dZ9?=
 =?us-ascii?Q?/CuEIP12C9TileRzFRaa78wHyzjoLRbmkA69lKsjR6QBo5EZKboWanzAuJcm?=
 =?us-ascii?Q?hf8FUZpHxuqs3OwE+x4A7u0Ale3DmPHww9oJNpcuG7QSEbzY0L6UudRgzXjG?=
 =?us-ascii?Q?2OgTZJpnmxrLkLkOoMxC2pAkLRw3hhogBXNk2ZQIHw0oYAcj7vMtUz7p88TJ?=
 =?us-ascii?Q?ZXw1SXrOqk90Ww79ZH0P0obtWQ4P6FN9kDjWuJ73CdDFxXvDuzW4+wlDUhhh?=
 =?us-ascii?Q?plk3rJsOUQop2SwM9Ft191qcwSiOiR09Qt5hqP44wdR+FPFYLsprfpgcNkUa?=
 =?us-ascii?Q?X8tcXElRGvZGBEBkmugFCmpaf4qckaMli4l+BFt2Sqk+h2wq0GiQqpfsxFHM?=
 =?us-ascii?Q?koM/gB8xMw3FIY56xKngBB82787Qk5RlaxKxxqyNOfyOk5pguTATDqRntD6r?=
 =?us-ascii?Q?ozWuzK3QDUqmzaHJZEu/BpyhRwlAsamykWutbjYxzAhdBYdqQkmbL3j6yuNu?=
 =?us-ascii?Q?Wh62dvP+7/zLRKBanJq6qJqH7+tj5kYJ5kTL8BjKeAv2qKv/puc8fVg72hNN?=
 =?us-ascii?Q?cfzu+yde3hvXlSqCVmAVJkcWBUcBC2+YLClQTKS4u/+Mt5CJIrNEevGO0v6g?=
 =?us-ascii?Q?7ehF04I09Wsa8zjIIucHDVrWx3qQnR36iQd1ycgShJ6XYz/17gHZIfrDRQjM?=
 =?us-ascii?Q?l7hNYZB08oE1NyBEyBCQv4Pc2Q4zrRfyXSuJBOWBrmzltpYrW7/SdBLPtKbu?=
 =?us-ascii?Q?yzdw7HIUwQ0UqzktNKrce0z20CByQ01usA6g6MiBLyfVyOaPRMWwWhe4FGVF?=
 =?us-ascii?Q?rw36MyNN1zptPt18QCmGJlNshrn7afpXE0LbnSaPGijBagDzNgRipATqleI9?=
 =?us-ascii?Q?73k0YAhYt1hA0qesOVdyGhhb22MOHMTJLK0ZbQ4TA58sSKsk40AlKH/pxdY7?=
 =?us-ascii?Q?cANI//6Y8yfaXOVK8xE5TFJeKDqEP96XBXPubGgLjsewnSnBIThf3K7hW3uY?=
 =?us-ascii?Q?FmxFjwJiVTxtDPDQ0HMKBjlXte0D+wwyjzHEy+oqimL9G5lTt2JR+r6/bHQi?=
 =?us-ascii?Q?4C1An7DZjVWiEVeYCzzu6yiI/zal+vsEo9fiRZoBUezq7dn2IZM9PvM/ZluP?=
 =?us-ascii?Q?QK9ZohVR2457Br/FC+OetIyeQGZeBI3GIDSE8gZaDqziXW17Bu3ldha1DmYI?=
 =?us-ascii?Q?cARp3Axp0ut3RJtZ9Les4EqqOtcOezA0hgsaB9W3GU4BquuWUL0M9eCfkSC+?=
 =?us-ascii?Q?H5ZdvPrjJOhs9SvStjqRun4Cat0PgcnnS2/w7Srx2DZvnDMvfOFk+Tm8AvQe?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 0500f4c6-b87d-4362-687d-08dce3f24c49
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 21:28:18.2311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAwcdi4XzXhJ/Q/4wo2UZe0+XEZvW2W5Hkn7SjJ0Rjt48RqeIR29VyWh9lX8cJmZ3u32KNu0hQ7jGDbkm2e73v+0FEpZhFpUwMCEbVKaorc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8118
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

This is the last place outside of cyclic.c that references
cyclic_run() directly. Replace by schedule(), so that cyclic_run() can
be made private. This also better matches what I believe commit
29caf9305b6f ("cyclic: Use schedule() instead of WATCHDOG_RESET()")
intended to do.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 test/dm/wdt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/test/dm/wdt.c b/test/dm/wdt.c
index 1df2da23c6c..4d751b7e8cf 100644
--- a/test/dm/wdt.c
+++ b/test/dm/wdt.c
@@ -3,7 +3,6 @@
  * Copyright 2017 Google, Inc
  */
 
-#include <cyclic.h>
 #include <dm.h>
 #include <time.h>
 #include <wdt.h>
@@ -14,6 +13,7 @@
 #include <test/test.h>
 #include <test/ut.h>
 #include <linux/delay.h>
+#include <u-boot/schedule.h>
 #include <watchdog.h>
 
 /* Test that watchdog driver functions are called */
@@ -131,7 +131,7 @@ static int dm_test_wdt_watchdog_reset(struct unit_test_state *uts)
 	/* Neither device should be "started", so watchdog_reset() should be a no-op. */
 	reset_count = state->wdt.reset_count;
 	val = sandbox_gpio_get_value(gpio, offset);
-	cyclic_run();
+	schedule();
 	ut_asserteq(reset_count, state->wdt.reset_count);
 	ut_asserteq(val, sandbox_gpio_get_value(gpio, offset));
 
@@ -141,19 +141,19 @@ static int dm_test_wdt_watchdog_reset(struct unit_test_state *uts)
 
 	/* Make sure both devices have just been pinged. */
 	timer_test_add_offset(100);
-	cyclic_run();
+	schedule();
 	reset_count = state->wdt.reset_count;
 	val = sandbox_gpio_get_value(gpio, offset);
 
 	/* The gpio watchdog should be pinged, the sandbox one not. */
 	timer_test_add_offset(30);
-	cyclic_run();
+	schedule();
 	ut_asserteq(reset_count, state->wdt.reset_count);
 	ut_asserteq(!val, sandbox_gpio_get_value(gpio, offset));
 
 	/* After another ~30ms, both devices should get pinged. */
 	timer_test_add_offset(30);
-	cyclic_run();
+	schedule();
 	ut_asserteq(reset_count + 1, state->wdt.reset_count);
 	ut_asserteq(val, sandbox_gpio_get_value(gpio, offset));
 
-- 
2.46.2


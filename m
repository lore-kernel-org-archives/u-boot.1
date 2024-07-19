Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0F4C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 09:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 825E688B5F;
	Fri, 19 Jul 2024 11:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Q0ZEtr+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8666388B62; Fri, 19 Jul 2024 11:12:31 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::724])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D17CA88B22
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 11:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewHt9rPG4iQvzMTSxx/RwRDvBiyNBXlmjXmEz7Ps9S0q2hy3pE6M2MW9YVKmc1JIhCD4IlmSkThabil1fCk80rYnX45xGqoOi+m4vCXLb+Ici5Zl0/K2/JY8NDbP0HuHsNtHT0YSLvOHTGFG8r+9sYy6gRPlig4dNnQW/2qXWxHKJklgzkf5uJMMxqfo603f0szCbNost7QnyrplMhfgtJ8WK6ekUj6Psgvy4E6Dik8E/Ui6p4kMw8jhv1LM/aW+H2r2Lb3YAifi9NhinVuiOwAovWEPYmZ1yN+LoisFnqHEo3xHhSjmXxyfEWiTyPL8DVdfOWrp9NLn9qPN3bX7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSdm6mhWoq1KYoUYh5mgoF3D3WfZDwrLYl1s20p+xSs=;
 b=VKuvlOE6a70DzBZkZMHmkPpQ7af4lTyj1B4sS5vXqJvHuKukYYd2lnjht+V383OpRW6facQ9s7Q47iPMjaGvaffoIaRJp+8/1rNKN5Q+wQ0XQJsX9GoazShDxePIDazOiCT6nAQl5CD4YeiLz238C99bKUUrup6WBb4PAM8Jd+umM7V6dzOlRSDTBUGU5SUrn/xhO5/eZ513QZDdxqUMByMv9bqbj/+Fn3rwWsa6MaAHYf8dNGTTZsjUk2d6ObyeFR89W4xzn0+lhJY0yKrX9rUaxVEydWxyNIhRs69UAuI9VmM0rV28TdBQ7nDnFz7ZfnoIWyVPhjaSm6PYs5f3LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSdm6mhWoq1KYoUYh5mgoF3D3WfZDwrLYl1s20p+xSs=;
 b=Q0ZEtr+M8Fmkrzjq2cxa690lanuLAkBVCuuSFcf/KrNCWgmKk6mNxCWgtXPIJ+0IERWulM3A7j34uCAcDrIiPw0OxmVkn9Rr1X1lTDN3CUbn8cKdbhNhE263IyRupVY1cvCsTcmxQR/Dgk0EigySCkV0zARcAjRqT3ObE3iugGHZoMbyir29ftomTAG9lAAxhrQwp+yiI7tOssBFyuiP9oA+lK9XoGgtbYNu5bk6xdZ8R6jJCUf3g3cZz3XcKw0GqW4QNWrF2aOw+bGVes/U51EsDcRzINKbyBIYxkjElCSZqW7oLWDLLVMrna3HOeS187isToJ58gxUwqXVO/OFhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7402.eurprd08.prod.outlook.com (2603:10a6:20b:4c6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 09:12:26 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 09:12:26 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v6 1/3] led: enable LEDST_BLINK state unconditionally
Date: Fri, 19 Jul 2024 13:12:11 +0400
Message-Id: <20240719091213.3757300-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240719091213.3757300-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240719091213.3757300-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0029.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::20) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: f7730e30-6ee7-4212-6622-08dca7d2e85c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0c06L9dzaUqjqsu4fQA0dmtaYMpjDKOsO6O+bTonYtiwIVGm/s7mCSXr4bRO?=
 =?us-ascii?Q?e87WKq1Y9BOSyH/a/8iPgJhjoRQIBM8rvJevICfe8309EkkxHRBbVgvkW/pZ?=
 =?us-ascii?Q?mRFDMhU1bS97LGO4ix9axiRo68OH20Tl6/z/rw/KrY2KYmQIPZeq9Tsfvxs+?=
 =?us-ascii?Q?EBGx9Qe6BUGLSZrAtmKGdZLjUNbpBJ8oX8naBTfgY+MVc+mFO8MluCHsZT0B?=
 =?us-ascii?Q?eBltyRty+/W5oQIdwRNDPiBdK3g/8jfrFlJbNeJfWqUAdWH62n5OfEiOMEVM?=
 =?us-ascii?Q?a0uYCnQT3EX79UG4dln7BNJByjDoRm8yfeW2V24eJQ6C7f76Tlf8kmBunJ0B?=
 =?us-ascii?Q?oQP8O/v4KrXMU7hLEgdvm65wYO7ed87Lu6c1G2zYR+H7idYw9afPCGUDOoXU?=
 =?us-ascii?Q?Yijkevl6kBkVbrMKbWP3H8inrX9e1iM+wqWdrm66tSA3G3K8BzPnb5+Su9SW?=
 =?us-ascii?Q?AVHOsnJO5782aBfBwguUP64sHh7NQ8oZDcLjzGuzcANHbPpjfpwnLdz82J2U?=
 =?us-ascii?Q?hqCMCfFlJfnsvN2BgKpYxZFqjikajt0ACS2dvyswj7ZO77ad6JdGroeyZ42I?=
 =?us-ascii?Q?b45bSO+ZOv9IairgxFDneoXR9mkoNkh4KwM7lD9WkaZ1ojpnBR4yFkru5Xmn?=
 =?us-ascii?Q?ZSD+hNvsPB0nIKKeWu+AQ+LL9fEfrlY9yLNwzTxKRHdvEB4DnF/EsaD/Ell4?=
 =?us-ascii?Q?u6sfTzK4O0WcGLkQ0owPQSlZ3WswL/FDrESY7tiqEie/3hdYKEgeYqwkR2az?=
 =?us-ascii?Q?KeJs2xJPjp6lb7dh9x8VYo2opVxJPCMXezUfmGzG6KGDnW4PI60/2CPDhWVj?=
 =?us-ascii?Q?jGV4AZ2hPx6iLwO0smXLd6NtP6PAK+bpXaZPbLP4z59eASbktG4wmn718qom?=
 =?us-ascii?Q?tFiZdQ6gGLGCPH/wNws7SFEEfDy1fLzSs35++aUMmKRzlG5HrLnuNyt30s1b?=
 =?us-ascii?Q?lhiYwb3ACdA+qe+CrKmDhry+0eF3fPEG1RMyLMfo4CNP+IGBxTtGhVX/5MJg?=
 =?us-ascii?Q?E8R2+5D6TakoQwZAJcwug57w7/xXnUaa8jUW9kOtUST04ZPQJab87a3rzW2i?=
 =?us-ascii?Q?xPslxAnSnvZ85gCZnX6ce0l7lrEWs7zfa3wxVWqVgdS8k4tH2vWm8qfqFefI?=
 =?us-ascii?Q?iGfkD8kJVFcKKPgYjO2GH9us4LbXc/aPgGnTnPJVywFgdoQB+4CzuZJ0D6i8?=
 =?us-ascii?Q?zzujNyUB3tMV+Mu8c3gjiYLow4jHaxyPbEyVQkM1zxJqGWhsCNI40TWutwVV?=
 =?us-ascii?Q?S/mauhYQ9FczACNwlfp+zvotfjZooB4fPHFLmY9Iax5o4dRZgS5U+YFXzxAy?=
 =?us-ascii?Q?rGU7fqbfDG3mjCJcNqGeJZqVdFqJm21tCeWD70hLXS0gLj3IwxtoiU5boS6d?=
 =?us-ascii?Q?rhyxSBofQ3T4eu7ToDD8xVLE8NfetH4xBplDG55h/2TnEyxwfw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ecxoppAk3XBbAghamqht6oHPmb4XVqqJtZgOnMR4rhJ4Ys8h8/6+DaM0RCdV?=
 =?us-ascii?Q?s0moCEQjv4LO7XrDIB+nyy411lB2JhDZg+L8Biy6I9jlURw40vGgY6BptQLe?=
 =?us-ascii?Q?IWD6baNyaPV7Ik/15qQux/I69kpHDv5qYfC0UzXKcMv+kPQpd7PyL5KeSPoh?=
 =?us-ascii?Q?kY1XUQoqJt5m5Hq0rzxYGXjT/WeV5NZfBBK2Fm8cuVvDFrTQMvnyAll37liV?=
 =?us-ascii?Q?qI9iEIJYo3LgPR3CyU1WT2Qv8XOx4z8F0whKhM8nwfL5R8niHsHPGuNlXjoa?=
 =?us-ascii?Q?qBkTUgDbuxbltwuNLk8zaTezs/2XIjcphr2O6/GANzPqHla06+kmsLi17R83?=
 =?us-ascii?Q?xtmY7EomFsQ7B8m5aIToVTGoEincjRTVFZy3avVcy7ADqihsR64x0E5fHKuc?=
 =?us-ascii?Q?YRnWuhLbxBaWpJQ9MtQZ6WxRH0mZZK9beJUTj3r5YX35/uNYC3Jz0QoauBPe?=
 =?us-ascii?Q?rjNH+ajlSR/fiPk/1pvRJbyLiBDYRTu7j8JuIDTeVf+2z3E8J5dy4QhbaOls?=
 =?us-ascii?Q?VPJmqEoMM8ULj4s1hAJv3p9CJ4W9THlFNcYlif/i/O/4GVzmyNKE9bPpVbzF?=
 =?us-ascii?Q?8ApQKNNcrbylEV+tUHd8wScUR+y0B6oHQ7XG0QL49Bo6oKy/aNPbnqQK+7SR?=
 =?us-ascii?Q?EfwLi2LnM8vF2StjcCggn19xsPqSAe7qXQ/M+w8ReEi8l1bZLJrUw+jV6IYg?=
 =?us-ascii?Q?ekHVeAdIda2FD7+KufEHbaaPJAef4HR9o2SBHdzPeCKbOhP+jIZYvWCFEdS7?=
 =?us-ascii?Q?ab3gfajyU8x2XrqxtILw0NssBdLR1Szh85zVRD0z3ByULcrGjkWHGADtgbtE?=
 =?us-ascii?Q?Y+x/Gf2nTxU8QtolK6lz475dRhwfrGmGTwZT27nu5OGk64EyBe2NkyJUT2Fe?=
 =?us-ascii?Q?m+kAH2uJPJFCDfGlX9Ee3uw6m7XEZXxVzrcKhbvnrXvagBY4pXcuM58rps3a?=
 =?us-ascii?Q?MozXaVCp+QrvjNMSpAvO0wdTHL/3BBBCdmO1EePB31Xf7vPoCa3/NmbaPXrr?=
 =?us-ascii?Q?/0sjtjkNI28YBV0jQBLGaDQHWFcQfmaUO+IXD1Kz5IBLIXGAwyIqbZSrU6V6?=
 =?us-ascii?Q?+vLMqaY+ERbUjfE34B/WD0pYJx3L5/ZytPW/0v+fNROxUj8a3duKL+AMyZyC?=
 =?us-ascii?Q?UpcmtYjDjeWfTrloacdF9BAJZoEeJMFns4BXVUrwl7FvPfTPgC+t5eOxhnXV?=
 =?us-ascii?Q?ANRZlf89mQZuL/ALBtMxMhEtF+BsmKlhjQErxcRRksgkD/dGAlGg1YfJsFWG?=
 =?us-ascii?Q?mtnxz1LZfUBE8Lwedzw3xuOLA56wol0t3wKvZea8t5aQlX5zSEi0pHfax85t?=
 =?us-ascii?Q?6/PRVoL2gwG10F5rCtwzFwj0f0Rvj3F/mugbJGdN4ArFHCF/b3/bed/qkPHb?=
 =?us-ascii?Q?VR3GvUabliqioOQbDwPa6IwMlSxMPFChilPYvYgsL2BeK6hSw9zsLv4t41uu?=
 =?us-ascii?Q?MzXuJGL/a2SdY0/fZXTl87UmwHuvENE+34iZBLvZOagq4y9EDC80ogvad6Ox?=
 =?us-ascii?Q?hqNvejoITSiJ6+j0+mJ8xCKdbpKQ6jm0m2eYhZldzGnye5jHcS6VGAdL6IMy?=
 =?us-ascii?Q?Bl5T1Lee31vzA0Q7XaM7H+ES6frBf5Y6eO4xzYWXXAhfXGkg54gsPYJwSTGJ?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f7730e30-6ee7-4212-6622-08dca7d2e85c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 09:12:26.5088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5riu6uwc4sBV17ME8RQ3b0g5y5IrUXgy3wU5a8FWevOx6RHEYnqlh+bEg428CMKs78WKJm+8VtWd+wwAQUMabmJb6sp3jKHfK/3Lpps1Kz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7402
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

Changes:
 * enable LEDST_BLINK state unconditionally
 * function led_set_period() becomes available when CONFIG_LED_BLINK
   is disabled. This makes led code simpler.
 * fix cmd/led.c to work properly when LEDST_BLINK present, but
   CONFIG_LED_BLINK is disabled

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/led.c                |  8 --------
 drivers/led/led-uclass.c | 10 +++++-----
 include/led.h            |  2 --
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/cmd/led.c b/cmd/led.c
index 4256b3429c2..2f786f34c67 100644
--- a/cmd/led.c
+++ b/cmd/led.c
@@ -15,9 +15,7 @@ static const char *const state_label[] = {
 	[LEDST_OFF]	= "off",
 	[LEDST_ON]	= "on",
 	[LEDST_TOGGLE]	= "toggle",
-#ifdef CONFIG_LED_BLINK
 	[LEDST_BLINK]	= "blink",
-#endif
 };
 
 enum led_state_t get_led_cmd(char *var)
@@ -75,9 +73,7 @@ int do_led(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	enum led_state_t cmd;
 	const char *led_label;
 	struct udevice *dev;
-#ifdef CONFIG_LED_BLINK
 	int freq_ms = 0;
-#endif
 	int ret;
 
 	/* Validate arguments */
@@ -88,13 +84,11 @@ int do_led(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return list_leds();
 
 	cmd = argc > 2 ? get_led_cmd(argv[2]) : LEDST_COUNT;
-#ifdef CONFIG_LED_BLINK
 	if (cmd == LEDST_BLINK) {
 		if (argc < 4)
 			return CMD_RET_USAGE;
 		freq_ms = dectoul(argv[3], NULL);
 	}
-#endif
 	ret = led_get_by_label(led_label, &dev);
 	if (ret) {
 		printf("LED '%s' not found (err=%d)\n", led_label, ret);
@@ -106,13 +100,11 @@ int do_led(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	case LEDST_TOGGLE:
 		ret = led_set_state(dev, cmd);
 		break;
-#ifdef CONFIG_LED_BLINK
 	case LEDST_BLINK:
 		ret = led_set_period(dev, freq_ms);
 		if (!ret)
 			ret = led_set_state(dev, LEDST_BLINK);
 		break;
-#endif
 	case LEDST_COUNT:
 		printf("LED '%s': ", led_label);
 		ret = show_led_state(dev);
diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index f37bf6a1550..4932b901142 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -71,17 +71,17 @@ enum led_state_t led_get_state(struct udevice *dev)
 	return ops->get_state(dev);
 }
 
-#ifdef CONFIG_LED_BLINK
 int led_set_period(struct udevice *dev, int period_ms)
 {
+#ifdef CONFIG_LED_BLINK
 	struct led_ops *ops = led_get_ops(dev);
 
-	if (!ops->set_period)
-		return -ENOSYS;
+	if (ops->set_period)
+		return ops->set_period(dev, period_ms);
+#endif
 
-	return ops->set_period(dev, period_ms);
+	return -ENOSYS;
 }
-#endif
 
 static int led_post_bind(struct udevice *dev)
 {
diff --git a/include/led.h b/include/led.h
index a6353166289..9b24a4ce188 100644
--- a/include/led.h
+++ b/include/led.h
@@ -13,9 +13,7 @@ enum led_state_t {
 	LEDST_OFF = 0,
 	LEDST_ON = 1,
 	LEDST_TOGGLE,
-#ifdef CONFIG_LED_BLINK
 	LEDST_BLINK,
-#endif
 
 	LEDST_COUNT,
 };
-- 
2.39.2


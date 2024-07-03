Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA4CC3065C
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 01:02:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA71988784;
	Wed,  3 Jul 2024 03:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="jWr9dW0Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ED9A880F1; Wed,  3 Jul 2024 03:02:36 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::722])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3FBC887B6
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 03:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghX2DQqBjJKla2A4fs1KbSCI33l7bxwzP7D0fXKfpfAwfUHUlW+YlA6JIikcIFluoOV21wmV0x403QLzQHm49+qPUUiq+LvV1wyvhR2r9L4KEFekvyb5aHns/nytNU1AfzT3uHjTJHmCUAeHqbW1D2lKGrJSyIp0r+SdaEdpo8GA4U1c/X3/VGs0hnF+J6Yvg9OdTRzMtjXbhqxBb5kAkJ8Bj/Gm4m5brcf7rUUbJl09dxEgyc64bj+iZrTfR5fGnRG2f01knfcrEfTmjOSNoI8vQQ69Nm/nM85mEpIdgTUqb1tsHuVGtpHMn+FdAtLWhXCTNyL5hXqhlh5cJSOYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zm3MkdaHde+3PAq9/ryoQjka+RNNVIAB/mnXMpSgyjE=;
 b=THh4aI1U3qK4bsd/Cc4+5bIfTsvg3k+GekPEJO4i0RH1IkSYRWNAey16XqTTa7uvsYLEcCx+Jdu6+MGYImVw6k4xu7x4l1c4yd3KAS2F9C3ZRbh5ul5fDpZRfdeOOXuj5sYgJ39Wm2DPkSFnh3Yt5wDFNjcySngPCcgWowKGRrL7bC37avfJpd5OTOz+GT0nbabiKw0kqRy2xGK01gunhADi5h1ADWUu7QeUvFSEcp6R+I5tlWFK1iWs/AtEpkGDrsnjzJWJR0n4YakkSQL38jgm0Vxd0gQzaGrVqfpt2ZGcENHxZmw2ZBqSzwv6QZPzE1CYHAUmvOUb28l8K2geKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zm3MkdaHde+3PAq9/ryoQjka+RNNVIAB/mnXMpSgyjE=;
 b=jWr9dW0ZaqaofmcL73bUCWvjvVSkf9MqoMFEsfmZKR+fr4DScwBp3LYtPy7OU6PZuuQ+keUs655pU/4xryMXkv+Aq8uGyak2YlWz4j2H/nNlZgbx+nQ6XFtH2YB/hkUX1OiA6U9Xs7uHDFe9LdWbzX4iDWiBj2WI7/IZW670cRKcBh85gnbB4HcPaoqyEy+dJV6oNuCMxPyV2Y1HKSOwIGvgRQHnrYhKvVKqQYyYMF4zTHU3tkAU7678qhQ1HPN2BFUM06kd14IgHLE6Lo6Xx7z/TL9nBok4YhAD4zXv0CRLP/jr9GqOP/nQn0JPNcEMcp/tfy+OdY+WgljpswZVDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6013.eurprd08.prod.outlook.com (2603:10a6:102:eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 01:02:31 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 01:02:31 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Cc: Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 2/2] led: Add dts property to specify blinking of the led
Date: Wed,  3 Jul 2024 05:01:31 +0400
Message-Id: <20240703010131.1735100-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240703010131.1735100-1-mikhail.kshevetskiy@iopsys.eu>
References: <CAFLszTihEQVMW==2V2Vq9GY_JffKWFgmarshmXSJFkCFyg4pXg@mail.gmail.com>
 <20240703010131.1735100-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0130.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::22) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec02349-dd6b-4a0f-56e9-08dc9afbd0cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?na8EqiGFJ2Hf6DWr3tk8KAowSHjOZPyNdiAK84kDWx4/Uy2GC9AZJqnJPwTZ?=
 =?us-ascii?Q?sMi0VDTiSIhJyHBoGXgAQ/c+0rOleMLn8Ja6NWopobBxWTdFhMwtZQqfNXRS?=
 =?us-ascii?Q?I/noReHdMIQBjA8WLISpo0qqN3OzBS71MfUFyvHVDnaL2/ODhaOL/St1p8k8?=
 =?us-ascii?Q?mYhSNLkWX94jenf0s/zCPALrzlRj5n//uak9w3Cu2u7ZcdKqbUyF+z23t+2q?=
 =?us-ascii?Q?OWQy+f1zEJtzs+PDAsnGF3qzpuyCrX1GhQn6wjYim0dMp5FO8ImCvPHgRp+F?=
 =?us-ascii?Q?/yIz2FMCdxpMVRD1HRAxriXIE3jx8wMk2l2IMoX9Vmj+gKFLpoON7LWq9UVl?=
 =?us-ascii?Q?RPMuvotGC0xv0Xpum16O7kqcpk34pTIjrbxmvbOnOgKWz8Hrl5xb+NxUbBrc?=
 =?us-ascii?Q?6AODrCvlfhy+sjd4Z3uRezWKwn9PCisfLMEfyhHYg8naC52Pptks7smtFonJ?=
 =?us-ascii?Q?i3yW7ljwT8ouGtNCX097p0NrIoiwXzhGPp6e7aVulaDEQB8g1/DNRKL9xSmk?=
 =?us-ascii?Q?cdVzDbEmjq7RfufBYG8qSOkxzlScz04dT4XATgOylFL+GkU9rlcI7TLQttHB?=
 =?us-ascii?Q?BFf9K+/Fs7KSf90w3LNZhPyEDRKMj/wZ+gm63uuLMxSj/gbxA+qC0oPDTBdh?=
 =?us-ascii?Q?0ImBEzKh70+cF3iPiLK7HoO6tuiIf25d22Fqc6Rw2t1YmJopDjwue9ZT0Pan?=
 =?us-ascii?Q?WRGprzM9A7V0gc5bNd0THhzN4gl0eAXSJ7V7KYh4norfK3gZRwrTPcmfTk8n?=
 =?us-ascii?Q?QaC9jHQ9zfuOEhdT0jZH6lzBCRgX84J3ImFhwBnb/7+W047c2recfXlrBroC?=
 =?us-ascii?Q?GKenJ7lcOk1gsBWQc5NzaF/+3CKVeKLcD77wPnhr3hRNEhXVrWmMdT0xFa8/?=
 =?us-ascii?Q?unH/f+Nd16D3j8K0cS3o531+FD2qEgSOWxxq/eSkxG4i7JhW1ilViUZkWtBh?=
 =?us-ascii?Q?CczYd3kVAvTHvsrGag7Ns27GtAEvEviEaknmpILB6n+bMUBUYCYfZcJtO+Ss?=
 =?us-ascii?Q?+8BlMcTrNExq839Tr3vQKNTS22iKCCO9s8J9NnyC8QkR0iFDSKks4Ko8PjFN?=
 =?us-ascii?Q?VJp3WlTmhbWOzV+qRpPmBeDfB8+HJ1okF0HYs/0SUTZtNH5f2wgvODbuW/B2?=
 =?us-ascii?Q?hK0Wq22RZsN/dvyP92ZQArDtUUwJQh3bGNCnBxHLOBkOPqniI6diQf47asYE?=
 =?us-ascii?Q?OmM5IyLSYSWDQldrmZq52ijEhJ2rk2xyhLXnO38+IAp/ONtpnNgXXlw8fNkc?=
 =?us-ascii?Q?ozppgn9JPXO+tWhVTZxOrrwTM7KYSFwhhTtIi2ZQY24bZEgRy8I3C/5KZSnL?=
 =?us-ascii?Q?qK9woiJhFDmvmza++v/pGinOakuD54Pe0BCzTJYQxgYRPl5xf9cgRhX2eOEt?=
 =?us-ascii?Q?XCMRD/pfyXZpdejZmqYHplxxLyeE41yNW/VkVrF/dxIY6tAtfw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uyuXwHyGiaF2dMRztOyDkdosUcz28gPD6y/TMCf6cRUX7myAsn2gLCXXKMNP?=
 =?us-ascii?Q?ccr94Q1bW/fOi3Pb/Zmp7bS0FfYOvc/LecmxD6eAEpIFTojJ1KsrGYOYCN1A?=
 =?us-ascii?Q?7swmLsUroB34ZDkh6fWoJeTQ4eFaGWAEhcMMHzSfcZgB0lfEb6Sz1F2scHz8?=
 =?us-ascii?Q?Y8AccauTJmwkgr/klsLlLF1q6fF+03LCZcSUNtSf2N58kCBlMwl46VMYW/u5?=
 =?us-ascii?Q?L1jiKZ6SEZnpdRrIZD7OEn6H72L5b1284xiSMpjxpvNauw9kRdd9LilX0ePH?=
 =?us-ascii?Q?+tOPtz8cIkopw1qph9jqMWIT+V6CiwsT3DK7eoVUOGXB+ZB3V9t2L7/aRBbw?=
 =?us-ascii?Q?hkuO7LNfhM6WnGhbbctOu+AcmPe2FxR8AuH34XnaWig6pQNqLK9x9NvPhm8o?=
 =?us-ascii?Q?A5Cme8tkLtykRST8jm6KMSJpsQMvBTQB3LT1e7Rnol0QGFiWav4oD4VNA+tJ?=
 =?us-ascii?Q?yOTzffeixH+am+Vc4IO3690RK3EbLheSqlmBWV5xFr8BKuPd02jnL24vDXUX?=
 =?us-ascii?Q?yX042Qw2KEjUT3DFBvW24iiJzdoKCjZxQP4+Kjhu6qqVrAiQIonJNAG/0xSj?=
 =?us-ascii?Q?no0canNumnnzrYmSMyyUagljUD02J5EmWKwhlv4SxUGazCmltqvTaOU+roOT?=
 =?us-ascii?Q?9jmmCArAzXcCgPUQEwTK6BM1CLrqtDnJcePusd75wWdVEU8/Gv8Y0EIMMYd2?=
 =?us-ascii?Q?k/wetFix0wONhViJi9/YzUL1soHrHm/CPmLn1jSfCVYZtYVP6J3vo4vJNS38?=
 =?us-ascii?Q?AQ5GU6mzS+ghgf4/x1bo6qJGIpq4pDcSygp99qsgzEhEk8h5dXolDIAI8j4e?=
 =?us-ascii?Q?QBt8cS+/BHFIqi2p0umtgB1jIrgcyEugm1b1S25CkLjDFWjDtrKGIfc0suD6?=
 =?us-ascii?Q?r6WgYpaHBbpk0JjWeuqukxoogch44qCH5XtCcQI22Btr4CqbUy8ICQ0af19X?=
 =?us-ascii?Q?vh3UBzmV6CIg0IUNWCLjdgHbzE/wAwZG8i6h4vkwvI60/EdzqsSzpLuYZTPu?=
 =?us-ascii?Q?JTzfZVmT/firIhOJkzZVxILeAm37+s27pKhcMjSjfd3U6o+i2hshT2SkDiTr?=
 =?us-ascii?Q?pdpEq6Cl3wGfwIEd1ubd3CK9IrTMdYjaG0VWatft1awrorq8p1LGjdnzBnYE?=
 =?us-ascii?Q?WRWapOq2od+t9Lnyleom3J2LN4rCHdPcocMCt1JKIgvzeKt6ho3fuGk/b6us?=
 =?us-ascii?Q?rK+bNlD7o6VQDxrgcXHDAsTXQV9mWA0xCokv45thAowA3sLyIv6zBZvarUZD?=
 =?us-ascii?Q?1RjIFfrpmjdo66LceVklDwh9UqhL+Dulpyte90ITKD2XkKFKikk6asCVCQxb?=
 =?us-ascii?Q?yc4JY+S/SovjDKE0lFPkNKpsrVrCtU0qPC89FAND7+CFsfqQW+YHfR2WWRTV?=
 =?us-ascii?Q?y1lqWqUtFGkEop1SisQiBHKfEvF6Tw6ovEf38i2+xkkogWycZs7uyGrLJSoS?=
 =?us-ascii?Q?I13L3tw6w2vLn7exauxssH7F81Dsp+H2q0w89853+VQJqo894T+Kat/MqPv6?=
 =?us-ascii?Q?aRv2CG9pwPVweXaxHFx74BK4A7PXgW0vKROv7AJNEGtHLjj1P44RSvSh5C7r?=
 =?us-ascii?Q?/Z/n0BcIt9nvgQp7Juq1+Gx4WYF9tcvQcQcrccunz3gKb9DXRBdydOuh+nrc?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec02349-dd6b-4a0f-56e9-08dc9afbd0cc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 01:02:31.1781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0gB10oUF8OER/cz2ng4W85mZJoGIa67VKnTPRNlwqzKQMRX5zpoNXMcQR7ZahO27CFTYko/mfQglXBbeS+JF3RYzKNEFIAf/A9iEuenlns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6013
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

The standard property

    linux,default-trigger = "pattern";

used to get an effect. No blinking parameters can be set yet.

Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/led/led-uclass.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index d021c3bbf20..78d1a3d152b 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -190,6 +190,9 @@ static int led_post_bind(struct udevice *dev)
 {
 	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 	const char *default_state;
+#ifdef CONFIG_LED_BLINK
+	const char *trigger;
+#endif
 
 	if (!uc_plat->label)
 		uc_plat->label = dev_read_string(dev, "label");
@@ -210,6 +213,13 @@ static int led_post_bind(struct udevice *dev)
 	else
 		return 0;
 
+#ifdef CONFIG_LED_BLINK
+	trigger = dev_read_string(dev, "linux,default-trigger");
+	if (trigger && !strncmp(trigger, "pattern", 7)) {
+		uc_plat->default_state = LEDST_BLINK;
+	}
+#endif
+
 	/*
 	 * In case the LED has default-state DT property, trigger
 	 * probe() to configure its default state during startup.
@@ -222,12 +232,28 @@ static int led_post_bind(struct udevice *dev)
 static int led_post_probe(struct udevice *dev)
 {
 	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+	int rc = 0;
 
-	if (uc_plat->default_state == LEDST_ON ||
-	    uc_plat->default_state == LEDST_OFF)
-		led_set_state(dev, uc_plat->default_state);
+	switch (uc_plat->default_state) {
+	case LEDST_ON:
+	case LEDST_OFF:
+		rc = led_set_state(dev, uc_plat->default_state);
+		break;
+#ifdef CONFIG_LED_BLINK
+	case LEDST_BLINK: {
+		const int default_period_ms = 1000;
 
-	return 0;
+		rc = led_set_period(dev, default_period_ms);
+		if (rc == 0)
+			rc = led_set_state(dev, uc_plat->default_state);
+		break;
+	}
+#endif
+	default:
+		break;
+	}
+
+	return rc;
 }
 
 UCLASS_DRIVER(led) = {
-- 
2.39.2


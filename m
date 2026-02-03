Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BE8E8783D
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 14:43:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F61A842ED;
	Tue,  3 Feb 2026 15:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="HW4/qNqI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 501AD842E1; Tue,  3 Feb 2026 15:43:38 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58286842ED
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 15:43:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niko.mauno@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nd8E8UKTPqM11wr03Ygn2F+coGL3XUgC1aDuA5AkMw+vxRgOp6nuwCoNZleOcBlC0NiAOcUxH+fMeiQB9KtKUvEWTnSaoBIYJl2Vc3MuRe0GPKrjO7FvSlPbB5L4zYaVbcIeh9HCDndFfFPR9B8hV4xTma1G/pOB8yNwRpJRRK45X/Jf0EimFkRQSr4FmlyUwV1S8FBLbnmUDr39m0XaI4t7quqM3BAjex+zfNyNAErb31mktGBwpTINDxFy3ARufDv8AaDuMmlPkVR3kKv1D0EUIeRk9S/+/FW3j9CiyWf7BaSPyNhIeq6c32L8nXvYKk8Fy1YgDVauy+gB3G+wqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylzaBk10wdcym0SjHWY83w1oxfVCarD38lxNLwupQ1I=;
 b=BLFsqpFP5nBzsmkWDrwL74UTq299hMJW1L6ABiQTeKV3N25Wk3EdL1WIsc3Az+9cKg2OSJFKckxi1Ggwgu/00F5orMo1b2dUCVPdZkzlNuzzu0mquy6QJuNoo1vXkXIc5qlug0D6arMUczhQZ1La2fZ+qDwxLe7p3GZDOucWaOz3jZp41BNBjfGmsaFrS2pYWKiDiXdMbGqmNeQlNTvlqFYA24e+4Hcpy6Tv8TN0XoT2atICp1E8HEkjR0bMnWXZySg+7zJWC/eqIywzvrG1JPfyhlUUeyasCKpO28YlcefVWSQvLHUzADqyu8OhLAZp08QhqGx5Sd0SsvTAQPiG6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylzaBk10wdcym0SjHWY83w1oxfVCarD38lxNLwupQ1I=;
 b=HW4/qNqIE8rIwA6b13fTf7V0ieycTbcufEB/oQTJ0hO7hKPXOC6iJZ38u7CPH2sZv3Q2lVveoxJTgjmekGa/svHUxcPhtAqx8ZvVuKJVGzkEmvEw86hYo+/xD7WJLKgWNROxCAOXh5yjJLc6hmYJEOpCGpJDz8hTUcNAV0nAqx0HhDIMdi9NgYy+70l43S9jEhbCBYu0its6MMFJhe1HYdmrrn+NSXxNnSK6mxESFIKF1uveL5+Glfvz0VFXgDHgnWNKsJLYNU7fnQWzOqGjWrKmSKegsEdZtwa+QDccDUq7+2Rr0ugQX+C8uiR8UExxdv2PTby1Tv9BfrxTANEccg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from DB9PR06MB8439.eurprd06.prod.outlook.com (2603:10a6:10:371::13)
 by AM9PR06MB7267.eurprd06.prod.outlook.com (2603:10a6:20b:2cb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 14:43:35 +0000
Received: from DB9PR06MB8439.eurprd06.prod.outlook.com
 ([fe80::18c4:93fb:c621:fe6c]) by DB9PR06MB8439.eurprd06.prod.outlook.com
 ([fe80::18c4:93fb:c621:fe6c%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 14:43:35 +0000
From: niko.mauno@vaisala.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Niko Mauno <niko.mauno@vaisala.com>
Subject: [PATCH 3/3] bootcount: dm_i2c: Support also single word mode
Date: Tue,  3 Feb 2026 16:44:04 +0200
Message-ID: <20260203144404.12093-3-niko.mauno@vaisala.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203144404.12093-1-niko.mauno@vaisala.com>
References: <20260203144404.12093-1-niko.mauno@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF0000662D.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3d1) To DB9PR06MB8439.eurprd06.prod.outlook.com
 (2603:10a6:10:371::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR06MB8439:EE_|AM9PR06MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee27d23-eb39-4423-6bc3-08de63329bbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OGkq7XEPFY2FOR/asdI6Xj7ppg+q1gTJxXrt2GTiVL5FM29l2UD77em4/6xT?=
 =?us-ascii?Q?PzNfqgYkaCwy5ThbXYuimRTOgz6UxF9xGU2Ovu4x0YrgKdBSjuq8Nzgl5YMf?=
 =?us-ascii?Q?Xm+WS7Je9dZ4MaxaSHegB+WT8GE8aTngujAkjATnjrzWtBwEU4H97P2KgX3d?=
 =?us-ascii?Q?5bxcBJvV3n3fQguGEXKcI6NxtaRBJyOQQssMaMlphiTLce7e6GNkYbANhxLD?=
 =?us-ascii?Q?EI0b209Qv0PYpvRFOPEozmPdpAth3/SpG9sFljNnWBJI0iV+YavLd4ER0//J?=
 =?us-ascii?Q?ZyHu9OeDnj2BtRFJyRxJ0imhP853RcsLtlXTZJLMY3P1AUOezxfLBzTkBbXV?=
 =?us-ascii?Q?ktNEs7U3ef0JEl+JF85vHbaIvis9ew/G9c3XQCOZuDhp8623TabEnjH5yKUK?=
 =?us-ascii?Q?ees2/iRxunK/PM5asoOaQvmTRdy8OLESRTRqwyVN2wzNmcLvhUM3TK+ebtuu?=
 =?us-ascii?Q?cSWQuioheLrNUlWfZpYy/ZKO+jMSYCa9aE/ZIm77E86aTTMSyOvlbEy87lI1?=
 =?us-ascii?Q?QjhF8Sg7hzS6QvEcAPKEDU7EPQLmiRu6ybJbjAuzDftvV21JALs/OWwgyFhq?=
 =?us-ascii?Q?MH7sY3GXvlnOW89K7/GmcG99907XZmuzO+wLoD7GveXlikRqUNHbAD/0aVEG?=
 =?us-ascii?Q?kP8XsQbgT/MQBWuIHArt2A4Y728cqpBl+HTjL5CciZ6xiRfyFpBIEQS/Ehxz?=
 =?us-ascii?Q?Ed+FofGInOez95tIspmij57iXxTt2z6vODMyPDt9eyXu/dadXgiOyExNwIaL?=
 =?us-ascii?Q?KP8nOnwBL+1+hAmAiZiA9aAQCHWzm+Auz6YxZMSMWAN03s4YcR0fcX7wQpKE?=
 =?us-ascii?Q?24Pt5E4WR/jEu0UwCma8GAcfpwZc6vOlphWtTyLwhLuDwWJmbSszEj7tBfPo?=
 =?us-ascii?Q?XaVlSEHg9coZ6ryVNWWDPrA1I11qjQ6NCZgIsvmEmMODHaT2yW3ds6G7eS6w?=
 =?us-ascii?Q?Vqxm9W0+UB/u6xwGFhNcrKdHJLmgahiluK3t8bswtKoQeJMiQi3eBIQwEajC?=
 =?us-ascii?Q?7t/v13eMwcMl7EVWX4hiiEb3shf1/VS9gb/PtqWqNeuhc9hTIzz35LNJQii/?=
 =?us-ascii?Q?EPwHAeTNaSCuWr/F/R6THUQ6CILnICUj8yJs5n3NTVYax2I00Bg+CzrZn2Fd?=
 =?us-ascii?Q?ESFEnhuMWRutAqacV9f0o7/2fSOcxwbSXnz3qZYFCF8MV89ERqJkzmkfxPSx?=
 =?us-ascii?Q?YtViHK92CjSYoG1/ACr1JMdFvz32Ub+I4XNv6UDp7+pHNg2S2y8G+V/alJrP?=
 =?us-ascii?Q?B9EfjdPaUU5sDXoVa8UsRVepVbV4/m6sNOggU4OnMWRQqSK9yd9Qhyenk9Qx?=
 =?us-ascii?Q?ZqKXwrGn9O++iDPU2H9BSQyyyOaCqF+wb56YI5iT/KiebLAIs2HKU01XMNNR?=
 =?us-ascii?Q?qoj1qbhBVdoushl1sceNY3grdPUM6tD3xoo4GjIhWJmR0CSaN1nhSxp8EzdJ?=
 =?us-ascii?Q?pakT8lXQOEZUDCOAsqJnkRiO/DuWi3YZ0AxQgiQHYcid3pyqXE1yuCEmWlme?=
 =?us-ascii?Q?fl2B/k5vXyDXS0XhlWE+1ys4b006vLpnyut8MAa1ORmjaINCbdsgu1pOZgNF?=
 =?us-ascii?Q?7O1qWHMjcsCP1o6ekWymmc7BqxzSc5/33mQbAEXCAVzUb40RwQDz6zIkFkRV?=
 =?us-ascii?Q?93tdaggkOQxjGaw45dORyDI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8439.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+cA6V6BoV5h6EfAgdnwhxNbpijFZshe7dwDFBDc90SJeSyluK/Lhi6OzPtzC?=
 =?us-ascii?Q?CTP1BpUwvv1lrjwQEbzKFCa+do7c0MalRN2b4LbfsdNtzH8qodcGywOyYaQ1?=
 =?us-ascii?Q?9vEpv3/RGvR1+wyJ1coLm5OkKDPePKxbtwwItYGRS/n2pAfKr/ciIBykEayS?=
 =?us-ascii?Q?FNuy/NgmFFhKkd4P4sIM6+etJbfPbsXiO454l7ZyDf+c8c6abiPPih6lCnC6?=
 =?us-ascii?Q?TjVBz3h147p8KLmzsZbbAG+6kDmZ8wIR3YRMoEWypSQ8BwnqNfuJGCN0PlRc?=
 =?us-ascii?Q?gKlLQOfltAQ3i3b4Vgb/DI4d3rlYfLTDrYdeIvLNXHhhqFpJR3vVaoNKycnW?=
 =?us-ascii?Q?JfehPDKmPci9NVnnRqm8gI0Of/S4p8OTrZnYv8Ln2mCXfUO0oYtKXdEBH3Lx?=
 =?us-ascii?Q?XFfjTZgFxKMIQMrq4a2ut0aKoZPMBwArSXezDqvbTTJIsaCWYknokfOTheXl?=
 =?us-ascii?Q?8y0ydzpa2+l27I77WUGBbWcQZN+RCfrt8yTViCVKJLJliRHGH+ntCkSMY+HS?=
 =?us-ascii?Q?Wp1KqrDBHtQG5OnvvEEkgG3xvhawyBdrIdGj22caqs0UEEWjuuttZp9s2pv1?=
 =?us-ascii?Q?bp5oSPUHc4A/w/p1SDKhFABQMxoZj3EJct0TlvvA4yHE9f/A4cAN2QyUB5yQ?=
 =?us-ascii?Q?ynRs0lS/jyWaqK5nUDhtJYkXj1wA8jCb33EOju3iwqbfxXXvkq+6FF0txVd+?=
 =?us-ascii?Q?2TmI6/aRxGVe82+qTNG0sO3tAq9o9EoaSRT7EtLBPmmlnvxYUBZHVTqa9tU9?=
 =?us-ascii?Q?atyFNqBL7JiyLGo5ZPFhUMSvmWtnfdGzujTiEg/braS3g64wrzBPYEnTpFHo?=
 =?us-ascii?Q?XF0LEvuumg5nzvD5JYGQd94ZyX/GY9OMvaSlNwPrbHdI+PjJrLX6Qu/QNnYo?=
 =?us-ascii?Q?D4/3WV+rKZtj6RqsTF7WY+Ssm/4NFFizlw+Y6uLjBC13PfVovzdHqbYZV2Dd?=
 =?us-ascii?Q?uIZpfgjD3LrJLmZYO7g6u/1SGo50uBvkudBHC272kcKjXpIfWMf8sqO6syMy?=
 =?us-ascii?Q?JpN2MhzF44EEiP1/yl35slK3rmHUXL8PtDJ1Flvtt9GS/z6llBvD2RpIMmri?=
 =?us-ascii?Q?8wZG18YxznqKKOUmlk5le/d+nkBeWsQIZA4pZrw+XxlPqNWdGJ8cl7ntEPM3?=
 =?us-ascii?Q?H/TVAesnV6Xo7MejtbAUTr9W3CLzPn/Po6wMEBrMJwsseQR2az4i0iUvUep6?=
 =?us-ascii?Q?NSFkrDBJlLs+qhTUsccbPJNeVnSIHyYe+aF0Iw2ywog9YcHQkiRxWtaXpIcr?=
 =?us-ascii?Q?yBKKHOEQBXfX3Z66KrUb5Nd0pmJRwyJjoFzsJw/2ghGlhjKe+T59VCdrupRY?=
 =?us-ascii?Q?0o4lOt/I5sV5M1tCEQj1l9/rwl60NjCib7+rfrt36AG32zPMxmJwNxI9ZssH?=
 =?us-ascii?Q?gLvUPTZlz4p9832VUKh0BnI0o0MK1sDP2GFmIHD5EJ6c0eS6/48xveTy4CkS?=
 =?us-ascii?Q?luXP7OoPGAcJT5CMMI27DDG7MU+VwQw7g0U282j7R5bJ7J4D3joQDfwOwQHC?=
 =?us-ascii?Q?a6G2kzF/YkXQNiohPIE9NWNuud3fVTphaUovCdFJlEN0ousWEx+ZhSKRiadB?=
 =?us-ascii?Q?p3EE2w3TFKxgk1EI3dxMt9Bm1TiHOa8UYbnYD0ph14yThggEgPoipm1feDV6?=
 =?us-ascii?Q?mIcDy8U7GK6xY5QeNKBsnIZwPvM26qhHlHVUrbbEZ8FHagLVm6tFoLjqW5Zn?=
 =?us-ascii?Q?bhKjw4JQ6xgxdq3Rm6Yc5OqeQpnpdZhe5tkgPUHq4be4J0axuHQ6ZKP9MxWK?=
 =?us-ascii?Q?4q1l1EzaQMxUA++4T3S/5OdbXOSUabA=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee27d23-eb39-4423-6bc3-08de63329bbd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8439.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:43:34.9712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l71CzL8gShrzhni+3EF6Xp7bhRpnz4NiGE2oEsO0Q72WwJpgs9GYDYzJ0myBOULtkoMmBqo7jmDZj17y/bIkkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB7267
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

From: Niko Mauno <niko.mauno@vaisala.com>

In addition to pre-existing half-word (2 byte) mode, add support for
the driver to work also in single word (4 byte) mode by adding
'size = <0x4>;' in the device tree node.

Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
---
 drivers/bootcount/bootcount_dm_i2c.c | 74 ++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 20 deletions(-)

diff --git a/drivers/bootcount/bootcount_dm_i2c.c b/drivers/bootcount/bootcount_dm_i2c.c
index e27034cbeb0..07359ecfa6c 100644
--- a/drivers/bootcount/bootcount_dm_i2c.c
+++ b/drivers/bootcount/bootcount_dm_i2c.c
@@ -15,6 +15,7 @@
 struct bootcount_i2c_priv {
 	struct udevice *bcdev;
 	unsigned int offset;
+	unsigned int size;
 };
 
 static int bootcount_i2c_set(struct udevice *dev, const u32 val)
@@ -22,13 +23,22 @@ static int bootcount_i2c_set(struct udevice *dev, const u32 val)
 	int ret;
 	struct bootcount_i2c_priv *priv = dev_get_priv(dev);
 
-	ret = dm_i2c_reg_write(priv->bcdev, priv->offset, BC_MAGIC);
-	if (ret < 0)
-		goto err_exit;
-
-	ret = dm_i2c_reg_write(priv->bcdev, priv->offset + 1, val & 0xff);
-	if (ret < 0)
-		goto err_exit;
+	if (priv->size == 4) {
+		u32 bc = (CONFIG_SYS_BOOTCOUNT_MAGIC & BOOTCOUNT_MAGIC_MASK)
+			| (val & BOOTCOUNT_COUNT_MASK);
+
+		ret = dm_i2c_write(priv->bcdev, priv->offset, (uint8_t *)&bc, sizeof(bc));
+		if (ret < 0)
+			goto err_exit;
+	} else {
+		ret = dm_i2c_reg_write(priv->bcdev, priv->offset, BC_MAGIC);
+		if (ret < 0)
+			goto err_exit;
+
+		ret = dm_i2c_reg_write(priv->bcdev, priv->offset + 1, val & 0xff);
+		if (ret < 0)
+			goto err_exit;
+	}
 
 	return 0;
 
@@ -42,21 +52,39 @@ static int bootcount_i2c_get(struct udevice *dev, u32 *val)
 	int ret;
 	struct bootcount_i2c_priv *priv = dev_get_priv(dev);
 
-	ret = dm_i2c_reg_read(priv->bcdev, priv->offset);
-	if (ret < 0)
-		goto err_exit;
-
-	if ((ret & 0xff) != BC_MAGIC) {
-		log_debug("%s: Invalid Magic, reset bootcounter.\n", __func__);
-		*val = 0;
-		return bootcount_i2c_set(dev, 0);
+	if (priv->size == 4) {
+		u32 bc;
+
+		ret = dm_i2c_read(priv->bcdev, priv->offset, (uint8_t *)&bc, sizeof(bc));
+		if (ret < 0)
+			goto err_exit;
+
+		if ((bc & BOOTCOUNT_MAGIC_MASK) !=
+		    (CONFIG_SYS_BOOTCOUNT_MAGIC & BOOTCOUNT_MAGIC_MASK)) {
+			log_debug("%s: Invalid Magic, reset bootcounter.\n", __func__);
+			*val = 0;
+			return bootcount_i2c_set(dev, 0);
+		}
+
+		*val = (bc & BOOTCOUNT_COUNT_MASK);
+	} else {
+		ret = dm_i2c_reg_read(priv->bcdev, priv->offset);
+		if (ret < 0)
+			goto err_exit;
+
+		if ((ret & 0xff) != BC_MAGIC) {
+			log_debug("%s: Invalid Magic, reset bootcounter.\n", __func__);
+			*val = 0;
+			return bootcount_i2c_set(dev, 0);
+		}
+
+		ret = dm_i2c_reg_read(priv->bcdev, priv->offset + 1);
+		if (ret < 0)
+			goto err_exit;
+
+		*val = ret;
 	}
 
-	ret = dm_i2c_reg_read(priv->bcdev, priv->offset + 1);
-	if (ret < 0)
-		goto err_exit;
-
-	*val = ret;
 	return 0;
 
 err_exit:
@@ -73,6 +101,12 @@ static int bootcount_i2c_probe(struct udevice *dev)
 	if (ret)
 		goto exit;
 
+	priv->size = dev_read_u32_default(dev, "size", 2);
+	if (priv->size != 2 && priv->size != 4) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	ret = i2c_get_chip_by_phandle(dev, "i2cbcdev", &priv->bcdev);
 
 exit:
-- 
2.47.3


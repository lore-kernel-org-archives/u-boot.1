Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817C0CA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F313E83145;
	Mon, 18 Aug 2025 12:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="S6qXvgwI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F205801DD; Mon, 18 Aug 2025 12:06:55 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19B2582AC4
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZue2k0c1T9AzAv+wKGQYzAsaXbx8mY597psD+Gw4FAzDv/aa4QfrrrT9/mSMOaXXlKFQtI+C/g4Y0Ek84m3fN5AF6tiSVcP0+VDzNuLHRxiDTiYQShNk3Ryjsr1sr2o8/X2UjzvvlrLXkH2zthxnkmf9eD2HnwKGuDeAxamuuuYHewXsiH9K22KEgw/NzM+jmu+210t3GmSfsyMEFadmlsYUtqqzlyFydgcKymtLjm23vJ1bGAewyvTBrhAa37dD6xloOL5M+p+3H5jB/6kXl4wCXyMVMKRD9lzcONva0PZvKMeeEZi3Cw4ZA83oRoIsJMKeGrqL9vHdflvrCgzjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WztOuYtTXO19AS7OWUprh/veIajaJD0t+IrhtWvBi9k=;
 b=VTS7lv6N7yWBjjakHfOmB4NJaUZS61KZQUJ/SKIzdANbHpF6tAKNxjXZXd7aONloZJ6n47d4ZEMrcODyqaEC7xsOkwnzox+qZzhBr5nsMa+GYgNXfeqsZXAtquVxIqmcCEbSP6TN5skrEDj51mhhBECH0WKnDfXJ1xVpSiuunMIavpU7BKfgH4f8Mu/Vghj7ykvT6A0uii2f5i93KEhPpDoGj7mKCxPXTw0yHd3L9TJTW71jMW3VqhWovpuK7LL/zcfQxca9QefCvnSupqCtwaN9kL743FURm3YmuUeQIHVcJ56CyCRNhTo7ik+pQH77xv9DZt0Iezns3NZuhk9mAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WztOuYtTXO19AS7OWUprh/veIajaJD0t+IrhtWvBi9k=;
 b=S6qXvgwIx4nspgvfKMqLwwztapI8+WqZld5DGM5/kL57A5TDVSJVr3GoYhEyi9UAawbGnTTCtZtgv90hzgMTgK86AmQvZZqSXJL22cqKFIcwf60EYootPWtSmGcxO1zzPNaEKVvHGInP7A7/vPtzTmrbfxo43WTs6b8iC5MVxduGQHo0YBnAFIPji8AoKYSxPwxcOfcbZPVe+HJ/rDoF9HX02/s0VJo+niGOCg1mn1jRR/ZxqrvxrNVFmADXnI4NvWz7VHuycbwUI4yoDMxJQcuau/bsMgzhSwILoiMJ4PcNv1AdjV20mz994qwrzXU4xIPyevUZoFi/Hy+aQ/Wbag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9719.eurprd08.prod.outlook.com (2603:10a6:20b:615::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:06:50 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:06:50 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v6 17/21] mtd: spinand: add OTP support
Date: Mon, 18 Aug 2025 13:06:09 +0300
Message-ID: <20250818100614.432931-18-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E2E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6d8386-01e9-4c35-3548-08ddde3ef2bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yAJC6vZQxf8MTw9CDBoRpOCHL4b0ypvURtNQblezilZjlBvChoLItoUWvIiH?=
 =?us-ascii?Q?0npHtQrLwnsCXVb+Mj+hx8XNY9TpLoedloMWtrxpGm/iOMl9v7FvWiJEHLXg?=
 =?us-ascii?Q?zbkygpwSFf5uNFkQAyLb46RnNbq1IOVRfHz05k+tBawIHQJ5ThHMlNYXDZDx?=
 =?us-ascii?Q?+Ggh54nq5/y4w2DbpyAGFxt2C5bKTfTQ7N2MObER4U/qQ8kJkwpdGONwfN8L?=
 =?us-ascii?Q?EQeLMcxxak5usXnUQ3mSjNdbPVfWg/d1Vqt111WE1FlSPoKRnyhYpEKah0YP?=
 =?us-ascii?Q?tcuB83yJI5g4C3IzOr4qk03TrVfx8I8mgzUi3oirkz9oIGM8iU1zCSPuWngI?=
 =?us-ascii?Q?XphM0zJxAWmA6LiFCDB3RoTGVAttYgS2dwnaBHyPFCeVFURwE4lGYbPADVA8?=
 =?us-ascii?Q?gbk04BJ0GhHEhLmMrcXkIJH9IiqoA8G5zieZZLPztxO0R+2M2m68NOiSUevW?=
 =?us-ascii?Q?EDAEyOrVqLPpl4OPlqVxSO8dCKCZ8WWYuTEn22V27IMeiShGztqAcKq4LRYU?=
 =?us-ascii?Q?i1xyvj6n7xJNaxHnWKNHAnjAUmXaohUqYJtSTXmnn1kzBeIWNsyCqDQWlZzV?=
 =?us-ascii?Q?ibjyLRwEsxwNIQnKFzCU2xFpxJZZzuy0NEm3zfWKjwATOqLAX4it9QU30DiQ?=
 =?us-ascii?Q?7ny8AFs2CIX0+nVna6ZsGYF3v49j78HlyvaAoYOVDp6j1KR9L/SED8xtxvLo?=
 =?us-ascii?Q?An0Q/LXtRXPd6ng3Yomn9E/HTB8woO7mhKOqJhnjuoRspH8MHYgOLiDP+p92?=
 =?us-ascii?Q?qldceKnOe7CJ0FfKtf60rqDAreKQauoVd9rdWduKeWlZVWB73U7vfv+nYKJ9?=
 =?us-ascii?Q?y07je6jc1aqLn9AyMbGPu65Qu6Yw20kWZS3/OWRy/8t+QAHPXCiIlW4fFt1X?=
 =?us-ascii?Q?eQHeMvaEv/jgXvK7gSST5vN/iYBKm1hSn/B34BXpa0eYmNIdx5v3UvEZmL/c?=
 =?us-ascii?Q?fmB0bOIv6Q2Z65j2xQZZ0PrLYY4nzTYE5ukP6Bkg4kPOsP3MaH7fw00XjBIU?=
 =?us-ascii?Q?aNQmH88k1tB+rBBmuIKJ5a0h/Yoj3h/MVhGZf31w86FR/evbP59cJ81oKDPo?=
 =?us-ascii?Q?TVp7bJb4+m5tdxE4Hr74qAS5dnxDeEGTxVo+qORhtY6jZ6GEJJBesPNAZyxS?=
 =?us-ascii?Q?I1EdiiB89G/6hvOLi9k0ebdhiqXT+b/CLQUNnYejwwho7Tz6Ew5JNY64u6+y?=
 =?us-ascii?Q?/xIjDGqg8a0OnQH11OD2MqKeS3oepNzgh3IKZoclv0Rw5VfwH0WASmlXIOT/?=
 =?us-ascii?Q?2kv9tUZ7E2Mg7BJAqInEMZ4Bu4Qh7Ey1f1E9GfHVheUpwRk2duosx4Zo2mWs?=
 =?us-ascii?Q?EhB3lwum8bg1lM2wkKU23IKRQcbIZRRVFA4TryLy1LdimgF3aOCyGUnUJejc?=
 =?us-ascii?Q?N6+9Agh8TRQqXg+lPFr2PA/rgEg+QRQgv1oN4k8pfpEh4UaTHYh8Sr7nYWey?=
 =?us-ascii?Q?qZ83uQjVYTZsx5geXTAtPIfI5C6vzLOygpzLrEJBJMF6LkvwuzrIsW+wKcHB?=
 =?us-ascii?Q?nlocxr330ilmJd4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6LY0Yd5fclP3AdJvcJaEHtTVDcN7yUj3HzvrxX1WNkVKqoKO+hocnO2IY2Ra?=
 =?us-ascii?Q?utXiswYSgrsqrBV4oU2KX0nycyOl6/HmLwLE3BlzCH24LCD8S3KmQtWc4a+G?=
 =?us-ascii?Q?tApVOu4JQi48GXxVTNG85FEAmStD6hELqWSUfnRHeble1I8Lq+cR5FpZu9GQ?=
 =?us-ascii?Q?3B/frGaakeS10iWJehw62V+c5KKcyKazmBwTt6LhW9gCyHswqbWRbpJBiwvL?=
 =?us-ascii?Q?/WPLEac9QwNA2ljCmyrvYl9SNh6sQxOK/40yfcq+lDGXv0m6YyskLcAlafxr?=
 =?us-ascii?Q?fpcNuqYSzi6vGkXWbtnU5tzF8+vlvgqeHn+yeCYL4myk3qoeZC3sY/LsUXFW?=
 =?us-ascii?Q?+REaZEqMwAPujrI0X5fo4pe2v8sWBvnrMwJ+HCzENS5FTsQUiTs61+P61COk?=
 =?us-ascii?Q?VULgNHjr+j+m56cznBKJX0vKlFCX4BBz9W/87GdZbhMQzQbah1Ue/YQDgbLQ?=
 =?us-ascii?Q?emlAZL0H8q3aN1v1n4Nkv2VdQsedEO6nS8y4SkGygOYQbU4S3/FIJdi84t9Y?=
 =?us-ascii?Q?3X1XUKrNp8ECSDbdKLkcekaWLC489nwUZKZHP7tb6VyoNxhAdvu6JHRLzjZ2?=
 =?us-ascii?Q?F89kCMt3ckyzK8FOzGhXm7zy7KAjtM3YNY+Z8nBsupTSBSZaOT7BexaqlHur?=
 =?us-ascii?Q?NrNcccsAxaaVc57AobohSSs9a0qH8pWDWVJEvO3nT35bL66scrp7leai9Fd4?=
 =?us-ascii?Q?0tGy3UfFcQZ20EhGN2am9XmjiVoO/K3LaFuGcwR4ss7anc4AhS1FV94fdqLd?=
 =?us-ascii?Q?n1pExSkhME39ojBRA5UhFMaSEPUNNRisbgB95exYA2YP6Rj/kAWiR3RlFOl9?=
 =?us-ascii?Q?6WL1SVCb9roeE1i0ZqJJMOTlHhQIQAeFzpEwLqaESXG0R3tLimWLv9DAPiHk?=
 =?us-ascii?Q?knRC2UWFo3CJ2VIboj5lXXbmiXR/VnHZETxF+Mkx5Hd2bwwnI7KJJZtrEIor?=
 =?us-ascii?Q?BV/heB4nh3WEN9uQMmCcwK4PZs7KQjbjtHaT+SN8Z0MhpAiOqUAAG1gVDf6d?=
 =?us-ascii?Q?xoRpN1SWmHB1+5H4xtiyNwTEj44aXPKUTsI/aj0unrKYqTzdI8htSNDfKg9R?=
 =?us-ascii?Q?1C9kpXUDh+QgENJMqfTU23C/nY7GJ/3opPdXUOitUTa7u5KeHX0K0XcB1csh?=
 =?us-ascii?Q?2AycXsZP1u9Ca4Ik7uIVzm+YGj50Zfaxp7zpuYRXEYjQYx6ue/2bl1uemJlT?=
 =?us-ascii?Q?B/2xcuioy66ULcdyDi68hoh60iA2iiZfI31w9DeH+LzYU0iKbyzEkwY1Utte?=
 =?us-ascii?Q?xEjFXCl7OOEiSzW8uzR+C/PF7d+d7HTZgXpxNSLyyZpV0TW7ERJPwEvMmYxh?=
 =?us-ascii?Q?fyzjJxvtZjQeXdFLFMoazvN5BP6My3MjqMKQSpzFCk9RnsiLH8SD7eOCkSeq?=
 =?us-ascii?Q?/+eIEVTMuctF7DeQLEfLQlFAAu9mJkb9/loOTNRRTEYloyc5lQJ1Iy1hTiFU?=
 =?us-ascii?Q?CYZeVtLvtrObTfpwNPtrhHJ0BS1rB5nVFRR79QzDGk3D9ofaCtVrW6Qo3/B2?=
 =?us-ascii?Q?IIQtUr0119jDtpPMOEFN+8z7lU+Vcfd4Xt7UqqbUSYIOK32iP5q76aHfEthv?=
 =?us-ascii?Q?F4KwGLnThqEfsRP5pXXgCNLgO4ckfxlqbs+w1hveMmlH+9yoxhUpRQmYl5UY?=
 =?us-ascii?Q?2518qp4A5GW/ChwaGaf+W08=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6d8386-01e9-4c35-3548-08ddde3ef2bf
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:06:50.1893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pen8y+/gPkcsXh7Uu2OF7/zIXYMzO+yWZtG+muFomq9KS0t+mEFDHLv8YWB4Pa1d7T2CIPmYwjQGeIVrUNDXQn982LdY8qK4fbgGpr2R54A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9719
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

The code was ported from linux-6.15

based on a linux commit c06b1f753bea (mtd: spinand: add OTP support)
created by Martin Kurbanov <mmkurbanov@salutedevices.com>

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/Makefile |   3 +-
 drivers/mtd/nand/spi/core.c   |  42 +++-
 drivers/mtd/nand/spi/otp.c    | 369 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h   | 112 +++++++++++
 4 files changed, 516 insertions(+), 10 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/otp.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index d438747cf37..831760da1c9 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-spinand-objs := core.o alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
+spinand-objs := core.o otp.o
+spinand-objs += alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
 spinand-objs += micron.o paragon.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 33d0c27f788..f16d3b0335f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -56,7 +56,7 @@ static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 	return 0;
 }
 
-static int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
+int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
 {
 	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(reg,
 						      spinand->scratchbuf);
@@ -543,10 +543,10 @@ static int spinand_erase_op(struct spinand_device *spinand,
  *
  * Return: 0 on success, a negative error code otherwise.
  */
-static int spinand_wait(struct spinand_device *spinand,
-			unsigned long initial_delay_us,
-			unsigned long poll_delay_us,
-			u8 *s)
+int spinand_wait(struct spinand_device *spinand,
+		 unsigned long initial_delay_us,
+		 unsigned long poll_delay_us,
+		 u8 *s)
 {
 	unsigned long start, stop;
 	u8 status;
@@ -617,8 +617,16 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
 }
 
-static int spinand_read_page(struct spinand_device *spinand,
-			     const struct nand_page_io_req *req)
+/**
+ * spinand_read_page() - Read a page
+ * @spinand: the spinand device
+ * @req: the I/O request
+ *
+ * Return: 0 or a positive number of bitflips corrected on success.
+ * A negative error code otherwise.
+ */
+int spinand_read_page(struct spinand_device *spinand,
+		      const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 status;
@@ -648,8 +656,16 @@ static int spinand_read_page(struct spinand_device *spinand,
 	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
 }
 
-static int spinand_write_page(struct spinand_device *spinand,
-			      const struct nand_page_io_req *req)
+/**
+ * spinand_write_page() - Write a page
+ * @spinand: the spinand device
+ * @req: the I/O request
+ *
+ * Return: 0 or a positive number of bitflips corrected on success.
+ * A negative error code otherwise.
+ */
+int spinand_write_page(struct spinand_device *spinand,
+		       const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 status;
@@ -1338,6 +1354,8 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
 		spinand->set_cont_read = table[i].set_cont_read;
+		spinand->fact_otp = &table[i].fact_otp;
+		spinand->user_otp = &table[i].user_otp;
 		spinand->read_retries = table[i].read_retries;
 		spinand->set_read_retry = table[i].set_read_retry;
 
@@ -1504,6 +1522,12 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->_block_isreserved = spinand_mtd_block_isreserved;
 	mtd->_erase = spinand_mtd_erase;
 
+	if (spinand_user_otp_size(spinand) || spinand_fact_otp_size(spinand)) {
+		ret = spinand_set_mtd_otp_ops(spinand);
+		if (ret)
+			goto err_cleanup_ecc_engine;
+	}
+
 	ret = mtd_ooblayout_count_freebytes(mtd);
 	if (ret < 0)
 		goto err_cleanup_ecc_engine;
diff --git a/drivers/mtd/nand/spi/otp.c b/drivers/mtd/nand/spi/otp.c
new file mode 100644
index 00000000000..e6ef78d9464
--- /dev/null
+++ b/drivers/mtd/nand/spi/otp.c
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025, SaluteDevices. All Rights Reserved.
+ *
+ * Author: Martin Kurbanov <mmkurbanov@salutedevices.com>
+ */
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/spinand.h>
+#ifdef __UBOOT__
+#include <spi.h>
+#include <dm/device_compat.h>
+#endif
+
+/**
+ * spinand_otp_page_size() - Get SPI-NAND OTP page size
+ * @spinand: the spinand device
+ *
+ * Return: the OTP page size.
+ */
+size_t spinand_otp_page_size(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	return nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
+}
+
+static size_t spinand_otp_size(struct spinand_device *spinand,
+			       const struct spinand_otp_layout *layout)
+{
+	return layout->npages * spinand_otp_page_size(spinand);
+}
+
+/**
+ * spinand_fact_otp_size() - Get SPI-NAND factory OTP area size
+ * @spinand: the spinand device
+ *
+ * Return: the OTP size.
+ */
+size_t spinand_fact_otp_size(struct spinand_device *spinand)
+{
+	return spinand_otp_size(spinand, &spinand->fact_otp->layout);
+}
+
+/**
+ * spinand_user_otp_size() - Get SPI-NAND user OTP area size
+ * @spinand: the spinand device
+ *
+ * Return: the OTP size.
+ */
+size_t spinand_user_otp_size(struct spinand_device *spinand)
+{
+	return spinand_otp_size(spinand, &spinand->user_otp->layout);
+}
+
+static int spinand_otp_check_bounds(struct spinand_device *spinand, loff_t ofs,
+				    size_t len,
+				    const struct spinand_otp_layout *layout)
+{
+	if (ofs < 0 || ofs + len > spinand_otp_size(spinand, layout))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int spinand_user_otp_check_bounds(struct spinand_device *spinand,
+					 loff_t ofs, size_t len)
+{
+	return spinand_otp_check_bounds(spinand, ofs, len,
+					&spinand->user_otp->layout);
+}
+
+static int spinand_otp_rw(struct spinand_device *spinand, loff_t ofs,
+			  size_t len, size_t *retlen, u8 *buf, bool is_write,
+			  const struct spinand_otp_layout *layout)
+{
+	struct nand_page_io_req req = {};
+	unsigned long long page;
+	size_t copied = 0;
+	size_t otp_pagesize = spinand_otp_page_size(spinand);
+	int ret;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_otp_check_bounds(spinand, ofs, len, layout);
+	if (ret)
+		return ret;
+
+	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, CFG_OTP_ENABLE);
+	if (ret)
+		return ret;
+
+	page = ofs;
+	req.dataoffs = do_div(page, otp_pagesize);
+	req.pos.page = page + layout->start_page;
+	req.type = is_write ? NAND_PAGE_WRITE : NAND_PAGE_READ;
+	req.mode = MTD_OPS_RAW;
+	req.databuf.in = buf;
+
+	while (copied < len) {
+		req.datalen = min_t(unsigned int,
+				    otp_pagesize - req.dataoffs,
+				    len - copied);
+
+		if (is_write)
+			ret = spinand_write_page(spinand, &req);
+		else
+			ret = spinand_read_page(spinand, &req);
+
+		if (ret < 0)
+			break;
+
+		req.databuf.in += req.datalen;
+		req.pos.page++;
+		req.dataoffs = 0;
+		copied += req.datalen;
+	}
+
+	*retlen = copied;
+
+	if (spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0)) {
+		dev_warn(spinand->slave->dev,
+			 "Can not disable OTP mode\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+/**
+ * spinand_fact_otp_read() - Read from OTP area
+ * @spinand: the spinand device
+ * @ofs: the offset to read
+ * @len: the number of data bytes to read
+ * @retlen: the pointer to variable to store the number of read bytes
+ * @buf: the buffer to store the read data
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+int spinand_fact_otp_read(struct spinand_device *spinand, loff_t ofs,
+			  size_t len, size_t *retlen, u8 *buf)
+{
+	return spinand_otp_rw(spinand, ofs, len, retlen, buf, false,
+			      &spinand->fact_otp->layout);
+}
+
+/**
+ * spinand_user_otp_read() - Read from OTP area
+ * @spinand: the spinand device
+ * @ofs: the offset to read
+ * @len: the number of data bytes to read
+ * @retlen: the pointer to variable to store the number of read bytes
+ * @buf: the buffer to store the read data
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+int spinand_user_otp_read(struct spinand_device *spinand, loff_t ofs,
+			  size_t len, size_t *retlen, u8 *buf)
+{
+	return spinand_otp_rw(spinand, ofs, len, retlen, buf, false,
+			      &spinand->user_otp->layout);
+}
+
+/**
+ * spinand_user_otp_write() - Write to OTP area
+ * @spinand:  the spinand device
+ * @ofs: the offset to write to
+ * @len: the number of bytes to write
+ * @retlen: the pointer to variable to store the number of written bytes
+ * @buf: the buffer with data to write
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+int spinand_user_otp_write(struct spinand_device *spinand, loff_t ofs,
+			   size_t len, size_t *retlen, const u8 *buf)
+{
+	return spinand_otp_rw(spinand, ofs, len, retlen, (u8 *)buf, true,
+			      &spinand->user_otp->layout);
+}
+
+static int spinand_mtd_otp_info(struct mtd_info *mtd, size_t len,
+				size_t *retlen, struct otp_info *buf,
+				bool is_fact)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	int ret;
+
+	*retlen = 0;
+
+	mutex_lock(&spinand->lock);
+
+	if (is_fact)
+		ret = spinand->fact_otp->ops->info(spinand, len, buf, retlen);
+	else
+		ret = spinand->user_otp->ops->info(spinand, len, buf, retlen);
+
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+
+static int spinand_mtd_fact_otp_info(struct mtd_info *mtd, size_t len,
+				     size_t *retlen, struct otp_info *buf)
+{
+	return spinand_mtd_otp_info(mtd, len, retlen, buf, true);
+}
+
+static int spinand_mtd_user_otp_info(struct mtd_info *mtd, size_t len,
+				     size_t *retlen, struct otp_info *buf)
+{
+	return spinand_mtd_otp_info(mtd, len, retlen, buf, false);
+}
+
+static int spinand_mtd_otp_read(struct mtd_info *mtd, loff_t ofs, size_t len,
+				size_t *retlen, u8 *buf, bool is_fact)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	int ret;
+
+	*retlen = 0;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_otp_check_bounds(spinand, ofs, len,
+				       is_fact ? &spinand->fact_otp->layout :
+						 &spinand->user_otp->layout);
+	if (ret)
+		return ret;
+
+	mutex_lock(&spinand->lock);
+
+	if (is_fact)
+		ret = spinand->fact_otp->ops->read(spinand, ofs, len, retlen,
+						   buf);
+	else
+		ret = spinand->user_otp->ops->read(spinand, ofs, len, retlen,
+						   buf);
+
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+
+static int spinand_mtd_fact_otp_read(struct mtd_info *mtd, loff_t ofs,
+				     size_t len, size_t *retlen, u8 *buf)
+{
+	return spinand_mtd_otp_read(mtd, ofs, len, retlen, buf, true);
+}
+
+static int spinand_mtd_user_otp_read(struct mtd_info *mtd, loff_t ofs,
+				     size_t len, size_t *retlen, u8 *buf)
+{
+	return spinand_mtd_otp_read(mtd, ofs, len, retlen, buf, false);
+}
+
+static int spinand_mtd_user_otp_write(struct mtd_info *mtd, loff_t ofs,
+				      size_t len, size_t *retlen, u_char *buf)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	const struct spinand_user_otp_ops *ops = spinand->user_otp->ops;
+	int ret;
+
+	*retlen = 0;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_user_otp_check_bounds(spinand, ofs, len);
+	if (ret)
+		return ret;
+
+	mutex_lock(&spinand->lock);
+	ret = ops->write(spinand, ofs, len, retlen, buf);
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+
+#ifndef __UBOOT__
+static int spinand_mtd_user_otp_erase(struct mtd_info *mtd, loff_t ofs,
+				      size_t len)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	const struct spinand_user_otp_ops *ops = spinand->user_otp->ops;
+	int ret;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_user_otp_check_bounds(spinand, ofs, len);
+	if (ret)
+		return ret;
+
+	mutex_lock(&spinand->lock);
+	ret = ops->erase(spinand, ofs, len);
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+#endif
+
+static int spinand_mtd_user_otp_lock(struct mtd_info *mtd, loff_t ofs,
+				     size_t len)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	const struct spinand_user_otp_ops *ops = spinand->user_otp->ops;
+	int ret;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_user_otp_check_bounds(spinand, ofs, len);
+	if (ret)
+		return ret;
+
+	mutex_lock(&spinand->lock);
+	ret = ops->lock(spinand, ofs, len);
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+
+/**
+ * spinand_set_mtd_otp_ops() - Setup OTP methods
+ * @spinand: the spinand device
+ *
+ * Setup OTP methods.
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+int spinand_set_mtd_otp_ops(struct spinand_device *spinand)
+{
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
+	const struct spinand_fact_otp_ops *fact_ops = spinand->fact_otp->ops;
+	const struct spinand_user_otp_ops *user_ops = spinand->user_otp->ops;
+
+	if (!user_ops && !fact_ops)
+		return -EINVAL;
+
+	if (user_ops) {
+		if (user_ops->info)
+			mtd->_get_user_prot_info = spinand_mtd_user_otp_info;
+
+		if (user_ops->read)
+			mtd->_read_user_prot_reg = spinand_mtd_user_otp_read;
+
+		if (user_ops->write)
+			mtd->_write_user_prot_reg = spinand_mtd_user_otp_write;
+
+		if (user_ops->lock)
+			mtd->_lock_user_prot_reg = spinand_mtd_user_otp_lock;
+#ifndef __UBOOT__
+		if (user_ops->erase)
+			mtd->_erase_user_prot_reg = spinand_mtd_user_otp_erase;
+#endif
+	}
+
+	if (fact_ops) {
+		if (fact_ops->info)
+			mtd->_get_fact_prot_info = spinand_mtd_fact_otp_info;
+
+		if (fact_ops->read)
+			mtd->_read_fact_prot_reg = spinand_mtd_fact_otp_read;
+	}
+
+	return 0;
+}
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 44c616a4acf..adfb5f3ffbc 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -322,6 +322,68 @@ struct spinand_ecc_info {
 #define SPINAND_HAS_READ_PLANE_SELECT_BIT	BIT(3)
 #define SPINAND_NO_RAW_ACCESS			BIT(4)
 
+/**
+ * struct spinand_otp_layout - structure to describe the SPI NAND OTP area
+ * @npages: number of pages in the OTP
+ * @start_page: start page of the user/factory OTP area.
+ */
+struct spinand_otp_layout {
+	unsigned int npages;
+	unsigned int start_page;
+};
+
+/**
+ * struct spinand_fact_otp_ops - SPI NAND OTP methods for factory area
+ * @info: get the OTP area information
+ * @read: read from the SPI NAND OTP area
+ */
+struct spinand_fact_otp_ops {
+	int (*info)(struct spinand_device *spinand, size_t len,
+		    struct otp_info *buf, size_t *retlen);
+	int (*read)(struct spinand_device *spinand, loff_t from, size_t len,
+		    size_t *retlen, u8 *buf);
+};
+
+/**
+ * struct spinand_user_otp_ops - SPI NAND OTP methods for user area
+ * @info: get the OTP area information
+ * @lock: lock an OTP region
+ * @erase: erase an OTP region
+ * @read: read from the SPI NAND OTP area
+ * @write: write to the SPI NAND OTP area
+ */
+struct spinand_user_otp_ops {
+	int (*info)(struct spinand_device *spinand, size_t len,
+		    struct otp_info *buf, size_t *retlen);
+	int (*lock)(struct spinand_device *spinand, loff_t from, size_t len);
+	int (*erase)(struct spinand_device *spinand, loff_t from, size_t len);
+	int (*read)(struct spinand_device *spinand, loff_t from, size_t len,
+		    size_t *retlen, u8 *buf);
+	int (*write)(struct spinand_device *spinand, loff_t from, size_t len,
+		     size_t *retlen, const u8 *buf);
+};
+
+/**
+ * struct spinand_fact_otp - SPI NAND OTP grouping structure for factory area
+ * @layout: OTP region layout
+ * @ops: OTP access ops
+ */
+struct spinand_fact_otp {
+	const struct spinand_otp_layout layout;
+	const struct spinand_fact_otp_ops *ops;
+};
+
+/**
+ * struct spinand_user_otp - SPI NAND OTP grouping structure for user area
+ * @layout: OTP region layout
+ * @ops: OTP access ops
+ */
+struct spinand_user_otp {
+	const struct spinand_otp_layout layout;
+	const struct spinand_user_otp_ops *ops;
+};
+
+
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
  * @model: model name
@@ -337,6 +399,8 @@ struct spinand_ecc_info {
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
  * @set_cont_read: enable/disable continuous cached reads
+ * @fact_otp: SPI NAND factory OTP info.
+ * @user_otp: SPI NAND user OTP info.
  * @read_retries: the number of read retry modes supported
  * @set_read_retry: enable/disable read retry for data recovery
  *
@@ -359,6 +423,8 @@ struct spinand_info {
 			     unsigned int target);
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
+	struct spinand_fact_otp fact_otp;
+	struct spinand_user_otp user_otp;
 	unsigned int read_retries;
 	int (*set_read_retry)(struct spinand_device *spinand,
 			     unsigned int read_retry);
@@ -390,6 +456,24 @@ struct spinand_info {
 #define SPINAND_CONT_READ(__set_cont_read)				\
 	.set_cont_read = __set_cont_read,
 
+#define SPINAND_FACT_OTP_INFO(__npages, __start_page, __ops)		\
+	.fact_otp = {							\
+		.layout = {						\
+			.npages = __npages,				\
+			.start_page = __start_page,			\
+		},							\
+		.ops = __ops,						\
+	}
+
+#define SPINAND_USER_OTP_INFO(__npages, __start_page, __ops)		\
+	.user_otp = {							\
+		.layout = {						\
+			.npages = __npages,				\
+			.start_page = __start_page,			\
+		},							\
+		.ops = __ops,						\
+	}
+
 #define SPINAND_READ_RETRY(__read_retries, __set_read_retry)		\
 	.read_retries = __read_retries,					\
 	.set_read_retry = __set_read_retry
@@ -444,6 +528,8 @@ struct spinand_dirmap {
  *		actually relevant to enable this feature.
  * @set_cont_read: Enable/disable the continuous read feature
  * @priv: manufacturer private data
+ * @fact_otp: SPI NAND factory OTP info.
+ * @user_otp: SPI NAND user OTP info.
  * @read_retries: the number of read retry modes supported
  * @set_read_retry: Enable/disable the read retry feature
  * @last_wait_status: status of the last wait operation that will be used in case
@@ -487,6 +573,9 @@ struct spinand_device {
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
 
+	const struct spinand_fact_otp *fact_otp;
+	const struct spinand_user_otp *user_otp;
+
 	unsigned int read_retries;
 	int (*set_read_retry)(struct spinand_device *spinand,
 			     unsigned int retry_mode);
@@ -571,6 +660,29 @@ int spinand_match_and_init(struct spinand_device *spinand,
 			   enum spinand_readid_method rdid_method);
 
 int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
+int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val);
 int spinand_select_target(struct spinand_device *spinand, unsigned int target);
 
+int spinand_wait(struct spinand_device *spinand, unsigned long initial_delay_us,
+		 unsigned long poll_delay_us, u8 *s);
+
+int spinand_read_page(struct spinand_device *spinand,
+		      const struct nand_page_io_req *req);
+
+int spinand_write_page(struct spinand_device *spinand,
+		       const struct nand_page_io_req *req);
+
+size_t spinand_otp_page_size(struct spinand_device *spinand);
+size_t spinand_fact_otp_size(struct spinand_device *spinand);
+size_t spinand_user_otp_size(struct spinand_device *spinand);
+
+int spinand_fact_otp_read(struct spinand_device *spinand, loff_t ofs,
+			  size_t len, size_t *retlen, u8 *buf);
+int spinand_user_otp_read(struct spinand_device *spinand, loff_t ofs,
+			  size_t len, size_t *retlen, u8 *buf);
+int spinand_user_otp_write(struct spinand_device *spinand, loff_t ofs,
+			   size_t len, size_t *retlen, const u8 *buf);
+
+int spinand_set_mtd_otp_ops(struct spinand_device *spinand);
+
 #endif /* __LINUX_MTD_SPINAND_H */
-- 
2.50.1


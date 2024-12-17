Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6581BE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 21:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89E63801CE;
	Tue, 17 Dec 2024 22:36:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="aBuZpX6T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39450802EF; Tue, 17 Dec 2024 22:36:22 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 887798021D
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 22:36:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVdjPsQSKQZ+ef7M0eQArgVKnbi1S6KAKnsPJRt44iPftcENqE+OvTDO3NXg8F6Ghzx/oRodvPxyEfKt2nZ/CepaazrfT5jZmKaxNjuM2pH0f3eGO0iZiV0yPpljRBvWVStV0QFQT3FRpfIIvjj5v70SieHSo5sSp9n6mg+Ofz0/ZmbAYJf870O/TXhAxqx5GuVKVjU4O+JOXWFPwxFsMLO0D6CrHpzsmwVlYCZ8KUiKib9OYLBVu7TK5PyZvF1gT4JRYVLGD3FdK2xj0OL2TL7KP4PNPRq8iKUmUQAbovyBeJlDG/Hd+ImIUk4BJ3KZFiczZuVlLqsx+pJLFMIwdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QCYaJre4Bf0xil4bx+pFmzWDqIHT3v9iBPqzYc3iSU=;
 b=k2boKHvBFJVLP3yJuRSRHMB5Gc0/83rN59vED2EK4dQZcqQ4AypYVJ+kOuiou1VimtLoL0/S8EZRx/ajtNs5en39sYov3meyk3PwUsbUmgyupVCPxEqxouAbMgq4qluQJPdWFixMAqEQMaVroB5SSfR6kLcUOUheeCpNB1dnNlZhHhg7nJe3V0hT6KJR0ld6ca5PjeESZ7KEWNHHMazZMkt52SxBMsJAYjpW5F5xenJ0z8fCtR9MvVRwC36oHrLnmBVeQzHolqB99NaLFH3LSWJ+Tt93BkD/WYuBv5LPUnPAARXP3UWesQno3noXSiQEDbWyoffHpvXGi9a9thm//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QCYaJre4Bf0xil4bx+pFmzWDqIHT3v9iBPqzYc3iSU=;
 b=aBuZpX6TZuTqHQXsa4pPke4fb6smhY7gn7XCIkl/des5xQcEIw/sHrnv/N6IIAmFlNKwLA+/EDnnWVG9fu/ldbbjaMHSJjAxCkccUVdxgeSc7sa0toK2fowRmvlbWY7sAlpMxHBLzB8IzrpW7b8A7/YyUwHP0+cKs/rX9h8h4RTCZJ0HTmpA219MVcu6KWmQLMOnRiYT4WNYsQu8v7vQsXNVZ6VHlFz5xYpArwj/yMAe4Ru+gZansl23FG/aMT88Vhtjh0NhmzY9s1aEVkgbHCvgavObjt4Dsvm1TFDDwBlU1xSTx+sKaPSQE/Khc+S/Q2+siZhyj2cRBg3ItBlqug==
Received: from GV0P278CA0040.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:29::9) by
 PR0P264MB3275.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:145::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.22; Tue, 17 Dec 2024 21:36:16 +0000
Received: from PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:710:29:cafe::28) by GV0P278CA0040.outlook.office365.com
 (2603:10a6:710:29::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Tue,
 17 Dec 2024 21:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019231.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Tue, 17 Dec 2024 21:36:16 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 0959F20229;
 Tue, 17 Dec 2024 22:36:16 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v6 1/9] tools: kwbimage.h: use linux/compiler_attributes.h
Date: Tue, 17 Dec 2024 22:36:05 +0100
Message-Id: <20241217213613.286813-2-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241217213613.286813-1-philippe.reynes@softathome.com>
References: <20241217213613.286813-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019231:EE_|PR0P264MB3275:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8a861167-5b0a-41e1-19d8-08dd1ee2d647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iehb/L///w7vXUHHGr2noTBaccuSfR0w+7jfA7f9dMGhk69tkuRuk3CPlz/F?=
 =?us-ascii?Q?NQqNP9t8VCfb3FWIU34/uz50Qo+vyiIXFFtWu8fduJ00VTW2pZYNJc4OZSFY?=
 =?us-ascii?Q?4FM9i/SSgmL7d0fIqO5Y2AVSujk2vZ8k/CGEHgnMPLOZXZyADUDwOkM5cGdV?=
 =?us-ascii?Q?0zMa79HzccOiJ/zKeU/V8XCjWUb+SEo0Wa9MVCw9YmHpCg+MAp8LvgFn8xeG?=
 =?us-ascii?Q?PVRJEfT9FU8/6tv7wtCGJUwNRStVFUbEtDXoOlXDKZRyHxAee+J3YAakvDkM?=
 =?us-ascii?Q?9cpaBEBu1oeuqXxdPpRbhqKXB8oiaejpk0ASzCK18yyJMv3pnFXokveJD2qk?=
 =?us-ascii?Q?skjjYfpROOzbHE03E/E6D05I+CiUPV0Y0aqxe1F+bqwY6J/T+1tmDW9HaJ2X?=
 =?us-ascii?Q?p56tSWqJWfdt8e6tOK6CWg52XZCbC+5HDThswhbIz6aFRbXPBPi4VFCe6uUr?=
 =?us-ascii?Q?BUa5vdhU9m2MEZFATKAyskacCDECCTZKyIuDbFF0/peliTZuaUB0F+GmJSlD?=
 =?us-ascii?Q?Ztn4KOf0dhNo6U1lCNSDihgKzypq+WRPgDd9GsLNWdy1E2MgexqO7DtcjPeq?=
 =?us-ascii?Q?73llg+SA5T56WZbMp+k19B17Q4z1EH9O8oVzriRriZcBVf/K8wgBB2fBAbIG?=
 =?us-ascii?Q?F0FnVcMb1sbKrARRKfzU2c0JxqQUS4OoK4WAfBaC4M8qWopKy0Ce1WwGrSgv?=
 =?us-ascii?Q?57le/DjLha80r9N8P5RrPsaAy47vEBWrADeu0XHRh61tTrkl2xeJ8rnXZIJn?=
 =?us-ascii?Q?JATC6Tv82sKkxQ24B228lA2gKqGZ6yqMBu1F0hJGjanq0zl/evJs46MEJvEA?=
 =?us-ascii?Q?k7KS5FvkSVuXuHvlzQuuoIOMdFfe40KZZWkRgf9ZLgdYrWFQqfYkv3PHV5H7?=
 =?us-ascii?Q?VlCvcN4Oz3xonX2XZNnD+BNKWNDGRsvOV8eUyUa5AFWb/8q8iGNIFf46XS1l?=
 =?us-ascii?Q?zeHnOYqlSAhfzhdKl42upqrmXklk54sJRaMxlfKn/fVBAsdXsl8qUQ0aHKYl?=
 =?us-ascii?Q?Pv8b3cM3casCW57pJKRn6uWTjlaiOVJWUyT+XYP5jydTUoCT57TB8wyT2Kvq?=
 =?us-ascii?Q?9U+BV5iKhJkuXX6DAby0rsXC1UOWgdjdDlsZRdb/JfewAsck7OWklaxv8c2Y?=
 =?us-ascii?Q?JP/2jTmZytVtsITJYWLiD5VD+1FyfuAsodQmDwQZLKyhI2+1cyVvXUgtQs2N?=
 =?us-ascii?Q?MOaqUZFHSc0d27JuJ2TDGb+tGJ5ziFMD3Z7i4jcPsl1l+4aa5HjbTbgCiG1T?=
 =?us-ascii?Q?FtS77VgbihvNHymkVkvxFYQ7qFbbJ7siuLhYV1eBm9jF8wSpn7m+5o7QLTXC?=
 =?us-ascii?Q?Fhm+dnEdxjoXyT4dtRufaj9ZpYOBtUSpyPEMMNqlGp4uyvdxkYH/j2o9hk7f?=
 =?us-ascii?Q?FRlVd6YhM0NZXCLK/VSYGZyWGP5g26qavUVpKwfADoh77rwee8TfDAbH4UJn?=
 =?us-ascii?Q?yW7BkBx3Z/pXS0H3HnO+vLYrebwLzVmGeArf9+wCt3Hh6Im/F9uv6A=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 21:36:16.2435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a861167-5b0a-41e1-19d8-08dd1ee2d647
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3275
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

The attribute __packed was defined in the file
tools/kwbimage.h but this attribute is already
defined in linux/compiler_attributes.h. So we
include <linux/compiler_attributes.h.h> and
do not define __packed.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 tools/kwbimage.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/kwbimage.h b/tools/kwbimage.h
index 505522332bd..e1fa2e4e215 100644
--- a/tools/kwbimage.h
+++ b/tools/kwbimage.h
@@ -11,11 +11,7 @@
 #include <compiler.h>
 #include <stdint.h>
 
-#ifdef __GNUC__
-#define __packed __attribute((packed))
-#else
-#define __packed
-#endif
+#include <linux/compiler_attributes.h>
 
 #define KWBIMAGE_MAX_CONFIG	((0x1dc - 0x20)/sizeof(struct reg_config))
 #define MAX_TEMPBUF_LEN		32
-- 
2.25.1


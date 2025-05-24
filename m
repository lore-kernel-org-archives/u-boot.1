Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB23C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 20:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0106582E28;
	Sat, 24 May 2025 22:37:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="jJkP1JxK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CC4583623; Sat, 24 May 2025 22:37:57 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AECCC82E28
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 22:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmAFFt/1xaPwpsvnCc/JIvZh3PCOt2ig6cg59R3RHebiqDYx+4DZbWzEgN5P9p4V5KtGbYhOju9TvPajc0xnUOEE/CIuGLGyO4zIz/2IRY2ukkJuribUfgFyGbfaMa1NwKVR0RNtYQ0BBB1w/F/fAP63ScFepCKzv8S723BQXc6QNDX+xciGtT2G+HovpUgtLaafsHoNRAmpTTiW8or+0PChKhEUU2Lz0LUZaxvRQvr8nP24RvCh0CbPd0fFq9DBfcNZWdE9ovrwZisjSJvLaE6jmBd/jv2c1ttG3iQ6FJ9YSGlAOE2nidov9R9yPAwy4GGb0lTvkOXhb4EGINYbbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37ePBQkOo1IAgEzI1ZrbYkZE1J68JA5bw9M12SDSlJM=;
 b=RjduVce4mrLtbDy1n2P9W1Z4JMC0yX9N7AkX2xgPdcTqG+vnVzXu1BmWtbz9XkXl0iAdDCJHzSnESvVd5lDNcDdGuRAjLo+N1YmoaL+DJTGCGUkWuz39goBD0P9k8oYM+rBDKm0gUKFTdpR2z0Gc1Lgo85B9NWRnvjYqygTYZqdh01f9U6lyKMzjq4zKZQTC8eyXdd+/ClzE4u8KIoQtSzsSHhOX0pjrzyQtdi9cBO88JGMqjkbGvmLojnXsqKSwENMhDbKtdZTwtLK/jG6r1C4JgK0HjFqgjPL1xzYordaPOGZI4T0x5h6URU5d/gEFNex7o6UsM2dig3u2QSHGGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37ePBQkOo1IAgEzI1ZrbYkZE1J68JA5bw9M12SDSlJM=;
 b=jJkP1JxKDpmiTqoDJRbUSIoK4t/vgGXjb4sjcaMHTgtXfmVZVEdl2ZyeW4Dd9icLvoPwG6/8Uyzixg7xCug3BRvDJHtdRKlw2GR6YhKsGERI/7+7qbCGefdZ261/kfcRgPz/xcbk72rTi9MiOoOH8UWeF9y9Z2MV1PwilV5XFeslvgYmdymRCiW0YTRca5zgzkTiEPts4CKeAGl84dRqDTGbCmHNrha6go3f3y6nXmqCxZ/a9XWCFyduQIZdwK/QJGtLK8wudpb39k4kfv8ZpmedtpXQ99jP2CBCrB1UdQcLdN8CcQlGj2cdsw8D/OZ2B1jgYmosEK5aL+0ISGI4VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by SA1PR03MB7100.namprd03.prod.outlook.com (2603:10b6:806:339::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Sat, 24 May
 2025 20:37:52 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8722.027; Sat, 24 May 2025
 20:37:52 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2 1/5] drivers: fpga: Add generic partial reconfiguration
 support
Date: Sat, 24 May 2025 13:37:33 -0700
Message-Id: <20250524203737.20541-2-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250524203737.20541-1-nareshkumar.ravulapalli@altera.com>
References: <20250524203737.20541-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::33) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|SA1PR03MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e4a952-d60b-4acb-eb82-08dd9b02da9c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ynmijRU+4PN+neOhcE8ca0EKoQdVDjRNe16Hsh5F0H5HvJ75MDwTttUgLMcm?=
 =?us-ascii?Q?3tN1Z9c4/QO/MySQTjHTNurUcW94cPvtcGJT+S6cdFz1XKTqqr6E5iLEYUf3?=
 =?us-ascii?Q?HCGO7jsJcx34cI5YS6z2+5l33khmV3IrMJMMT10XtNWiebTPR3ykKOjWpzXs?=
 =?us-ascii?Q?50Q8w00N1Ob4snKlNUhEGKXBm3S/OuYdPtJGvstf9RlQBc7qvKLgjz1CLBNV?=
 =?us-ascii?Q?N81qedsQwWY/R6H/GP5viq/NIOAKaZqghJdCgA8PBeiL1YXguNZDXhP+SEHE?=
 =?us-ascii?Q?ZKCDxFK7o5C5pSQ7DKheiz/1zP1cA88OmfAv8yDey2/uMsQ/lod1WmEck2Kw?=
 =?us-ascii?Q?RBpqug/Lojd5wIh8JYflv7IQeSb6rxm2Clq2plu+hZu1gjgAKlQd3hEq//7b?=
 =?us-ascii?Q?8l4IxJ0RJ4oCviO08Fbn65I8pxD+HBRM8qXWgbsrRwz4BR2383ot9dpXguXg?=
 =?us-ascii?Q?i4bKo3/5yZAF2x4sps/QuO8gJt/RGrJn3tngt1MkAiyYhFS+TZ+3CipBVhPg?=
 =?us-ascii?Q?K+1+lr/Vw0EAiJo7FsF/ZZkDgY0Surnk/78zm8AnL8xf3NVEWK3zlK111txT?=
 =?us-ascii?Q?m4JD5xgBGIqQcoPyQsvAS//KGxcRLdX+7TTS1KR3qo7WlBqkLIPofnvIqkqs?=
 =?us-ascii?Q?TU6N088txPqpycAIfUCYJ5jhI4+lh2ADRucRMIH/61yVM1Opau82JgWqUYjL?=
 =?us-ascii?Q?e2y8X8P/cJuNtQiPU6mduEt6jbc+rPv4DAeGUf2dKxBKp0mRhH6rX8NsI7Z1?=
 =?us-ascii?Q?zpNxKUeR/1ZnPxgq4Fk/AcJc95oB/HKMektGQKZ6FUSq3AaDAHkLIgcTuljd?=
 =?us-ascii?Q?j/AXZInsX1XlagS9FZH6iHAYwYKDOXrHoAEfHcVog52BOpHorFXNjghsJouX?=
 =?us-ascii?Q?/cKlkXvxXCObEj5kZ5SiLSn8AqrZ1dX8J5W+7fB+KEy3DwsSfYCQ3Gj7OwC5?=
 =?us-ascii?Q?6M3OkxI5J0SU76vp3ocjuZ5l0IWnYVj+W6wlFZFPjPQVpBHp6pC0FINT6BxY?=
 =?us-ascii?Q?7Qh06LW/tO3uEgT/TpA/2kI3u2jnfmwXAwPsXvxMPcFHWajy4xQK0r/csR42?=
 =?us-ascii?Q?iVFUAhFnLghCbqhQnHey/QB4QCfs+J9UprLdxgVolEUVhWByub39nV62/Csv?=
 =?us-ascii?Q?VPeHliul69hhbmBTeBnEORG31WUgp0ecwleG5rVxaQrPfbmBDUa5zGwsIHaU?=
 =?us-ascii?Q?UZDp11NHpnx/AZKZx9fzijt+attzUfMZi8o2ztcnb7x6VqUJ6bEJI0U7My2j?=
 =?us-ascii?Q?PAA+G/jr2SAs8/6dbIBKcwjjFVbnGimPr9i3snVJTNR/8lJJjvG8G6BUN7NV?=
 =?us-ascii?Q?xQNd5vHQWiRA3ZixhvQmlv20Lw+oecT688BkSkKKENTFdsGb87gqF1DKz6Mg?=
 =?us-ascii?Q?YldIxCM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cPRIUAs89JvOYrfewen+c9Ip0V/p0WWIkbYIA6Phsqx8njaMkGfeWUUlpMsv?=
 =?us-ascii?Q?lPJs1bgty2PbhworaIZL6P5LMJkTC3YpuIkfXgK+kilJCmVPVycbpL3c4uYP?=
 =?us-ascii?Q?g1Wc+LFm+yPLRgkDWy5DWuPd06ErT/A6nAT7lRznk8c46dXHuK4L2OUlxVqp?=
 =?us-ascii?Q?tsoV4zxlIDK3vmxouf8CIhDqUTYZRFlij0uk+KAUEwGjbk+mD2gDkAI/ms01?=
 =?us-ascii?Q?uRdUwRLoqXMXDNlYv8/LvfsGB9cZas/2FXdxfxA+LQkFtW8NZDaC2LCWjD1C?=
 =?us-ascii?Q?pBMqlv6p/jbL7aWLUzKcpUvzmn+DVcgIxHyNwKUzbU66eQmg9sXuZ5xyXVYf?=
 =?us-ascii?Q?pHPXfgK0BJl/vQ0qmzZq2JLYCs7ekRIWVIVnd2Pv8TaXLJ9ucOfOMsp5NRTi?=
 =?us-ascii?Q?UVkAV3kNmspU0dqrXIR0AqJoxFafL+dxlLpMHvLi8PZWwVz2gVEDczz4w6Ir?=
 =?us-ascii?Q?l918F4XIuaHb4KB/sb50DWkhTsu4Q3PiCk7mloW8M085/p/AaTRH/RJWKyX+?=
 =?us-ascii?Q?xAR/Z4uTsBKk03Byx04FbexRb81Q4Cx+LrUjrKOMDXD2zhyAC+gh3u6HPNWg?=
 =?us-ascii?Q?cfpnzAcZ3OlOujXsBBxctgD/rOXVSTGhibWtlapFw1OArr6OJWAMajT/9ceb?=
 =?us-ascii?Q?xftwcKPF9D+zX4Arz1f+004k+hg+Vk69HsEwLltgrVwhAn/y66H0QWYUlQ1B?=
 =?us-ascii?Q?7fpcvigwMTDqmzNfTcYpthN0CG5LWWglbv4vkE+MGJyQIreB76kMUMlt/5KY?=
 =?us-ascii?Q?NGfXWXw2MSwvIH3Xb3dd0EAr61w06vD4JPH70Tu2/mYZdrzOHcFZKP5ojTd8?=
 =?us-ascii?Q?dMWy2bVIzE6UnHpLTNsmB3i6z6jtU3EytOwshmeyr6+jLf2I/tBmm7cV6JH7?=
 =?us-ascii?Q?t9lY1FoUp4Cx514i1ZsFXixiwBibzI6iyvquEkStOR+n4ptZ8qQHdJs6Ckkc?=
 =?us-ascii?Q?r4XuKAYAWWZkXEP8NJLdi7yT87b9s7EoThe4iSaZihJpuZ40xm0kH72y/F4q?=
 =?us-ascii?Q?tw18VLHOlg1HSbSwMUxerCnIbmfXtjr6DMb6n9hNJrkLjWtKaW0z3URyDM1J?=
 =?us-ascii?Q?a8zUYk6kZJ6o+39f7eAGf7coj+07xv+3MyV4+7S3aHIvlAeJSolJ6v7s0OG+?=
 =?us-ascii?Q?oqk58QHlGNxm9HCrV3xemc0lErrElLEBoyu87woWKtDqCpDjxs3EehjqXnRO?=
 =?us-ascii?Q?3Fa4u+9vlEhR+dZHxQMN7QyVlcaZnWM1ZM4IQDQpnSItag7yaA4jLvI6OjeH?=
 =?us-ascii?Q?aA/T6NX4m+/vcHfrYpgO4cIaBu93c0SOtwNWLy1uuwHs7u4g6+8N9AaTp1Wo?=
 =?us-ascii?Q?aFfMjphZYHGLV9sa8vyPxZF1lxCj/oVtuzKqV4Wgd4JjsAcbyJ8fjw4zvnaW?=
 =?us-ascii?Q?cXmyFjGVAakCdkBq8+UhpzaSHIS5NBA/h6zLdfBGYOnV/CHG5JZg6epFmmK5?=
 =?us-ascii?Q?30Jrf2hLxKQMBQBPn4lzKV2N4APnu43nZoFILtLErPMz9F+GHCX9E2NqmWY7?=
 =?us-ascii?Q?JjWqLcv0yslEW9VQ+bGgxeQjUI/Ke4EiJ4DtO5TrLwfPL3QwBFFp+pHcd2E2?=
 =?us-ascii?Q?SOH4XSGa2boDjDniKH3u0OAIFTPHK1QHCIY51oIGhXratiKBecGr6WrpdhPa?=
 =?us-ascii?Q?+YidrOTDtdWI6NHlVG2IFCE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e4a952-d60b-4acb-eb82-08dd9b02da9c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2025 20:37:52.1581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzsPqzS8eYw+uUoW31DM9YQPth1ryXlGLp6FjLgXLRQ354/zs+se0VCz1Chwke2DhvswSkElfkzaj0oUlZsWjj/lyOzPwaOWObxERMUjGz7WGAMgvNC4yYUBr583oDh8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7100
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

Support for generic FPGA partial reconfiguration (pr) is added. This
implementation could now be expanded based on individual SoC support
for the same.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/fpga/Kconfig |  7 +++++++
 drivers/fpga/fpga.c  | 26 ++++++++++++++++++++++++++
 include/fpga.h       |  3 +++
 3 files changed, 36 insertions(+)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 62cb77b098c..f2497eb3c87 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -139,6 +139,13 @@ config FPGA_LOAD_SECURE
 	  Enables the fpga loads() functions that are used to load secure
 	  (authenticated or encrypted or both) bitstreams on to FPGA.
 
+config FPGA_PR
+	bool "Support FPGA partial reconfiguration"
+	depends on FPGA
+	help
+	  This defines functions for partial reconfiguration which
+	  include the freeze controller support.
+
 config SPL_FPGA_LOAD_SECURE
 	bool "Enable loading secure bitstreams for SPL"
 	depends on SPL_FPGA
diff --git a/drivers/fpga/fpga.c b/drivers/fpga/fpga.c
index f88267e01b6..c1d10c9cad4 100644
--- a/drivers/fpga/fpga.c
+++ b/drivers/fpga/fpga.c
@@ -2,6 +2,8 @@
 /*
  * (C) Copyright 2002
  * Rich Ireland, Enterasys Networks, rireland@enterasys.com.
+ *
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 /* Generic FPGA support */
@@ -396,3 +398,27 @@ int fpga_compatible2flag(int devnum, const char *compatible)
 	return 0;
 }
 #endif
+
+#if CONFIG_IS_ENABLED(FPGA_PR)
+/*
+ * fpga_pr
+ *	Support partial reconfiguration
+ */
+int fpga_pr(int devnum, const char *cmd, unsigned int region)
+{
+	int ret_val = FPGA_FAIL;           /* assume failure */
+	const fpga_desc * const desc = fpga_get_desc(devnum);
+
+	if (desc) {
+		switch (desc->devtype) {
+		default:
+			printf("%s: Invalid or unsupported device type %d\n",
+			       __func__, desc->devtype);
+		}
+	} else {
+		printf("invalid device number: %d\n", devnum);
+	}
+
+	return ret_val;
+}
+#endif
diff --git a/include/fpga.h b/include/fpga.h
index 4cc44164b2f..221a7f1a21f 100644
--- a/include/fpga.h
+++ b/include/fpga.h
@@ -2,6 +2,8 @@
 /*
  * (C) Copyright 2002
  * Rich Ireland, Enterasys Networks, rireland@enterasys.com.
+ *
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #include <linux/types.h>	       /* for ulong typedef */
@@ -78,6 +80,7 @@ int fpga_loadbitstream(int devnum, char *fpgadata, size_t size,
 		       bitstream_type bstype);
 int fpga_dump(int devnum, const void *buf, size_t bsize);
 int fpga_info(int devnum);
+int fpga_pr(int devnum, const char *cmd, unsigned int region);
 const fpga_desc *fpga_validate(int devnum, const void *buf,
 			       size_t bsize, char *fn);
 int fpga_compatible2flag(int devnum, const char *compatible);
-- 
2.35.3


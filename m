Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97089C282DE
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 02:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3FB0806FC;
	Fri, 14 Mar 2025 03:21:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="m1bCNdtH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89ACC80C93; Fri, 14 Mar 2025 03:21:30 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::613])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CA0480C93
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 03:21:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=muhammad.hazim.izzat.zamri@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uf0lt1j7qHC6tiXlCSnCs0jQNRZlyNoAvzsP98p/RaqMoOcfA9LM6P+dsI+QNjFN1tA2Nt4JTQ1fd3cjFGogv46rGOPmUptJAsVLRyHbPkqeDBVdZURKELopIeF/doss96kRyhUF2EAsSq+zbt7X9BsWeRZvajQTS6t1Gm/geA8VXWjWs0qH62VUHDsG3KfHxEhNq/UhE1norbzemWzmz6xakCSviO+/2HpQqUb6wcOxXUhrGnIuHzLJsteYJChqFtATDQ5wZEIz6d62UrmYxQZ4HyOtLZKVFw1S6AB5rRfhmHHkskrR+AQQOb3Qa7LP64NR1fGzW3NQQMkCdXl8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/p9K12ykO4E6cOJFG+0scWwnRyhaK/hHUPJ9e7IqAm4=;
 b=k8o0Fgqt7WszniWobU5f0Y3nCC3PbqoyIEReXICfMXLDUeTCT+qpOALz6fwdY/9rlFtVhngfPhNknX5IAeNPar68H3i2fS9Eou80rtn8OTcJE/U7gIJBWdbObt/p5k0+Is4+383wluORlF6k4LRuowK+1LJ/RKoxk0ufSpvNtwmBNkr+KoNIWCrsS6GU2BJQSQPpjVj8HhRzH1YYZoFj9YGaNRDSjq7iRLtr9NU5C4DTyaJEaKM2sKEt2nHa0WlOh5IIeELPL54kDo5D4wcxNxtisyd/guXpLC1/OlEIjBFW45S5m9vDRDss3JBYMO9uk5hSP+WjK2CykqL/kO2yWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/p9K12ykO4E6cOJFG+0scWwnRyhaK/hHUPJ9e7IqAm4=;
 b=m1bCNdtHZokk6Teiq6mQlGcOI2K0VRne/HVK800aknJmoI8aHtBO5Via+KB421lTyeibQ2PlnoiEEwTlYv3S+iQ/8T7YiUdVOSIfPf1JO0D94R2EizEAVDbCRScNpuUv/PPPcLBrFBTY1KHvO5G3PFIQJPIxBPDid/0L6ZK4Capmh0UOsNXfJNoR5wYACN4TadjHWX4hU4jpewoukyrD8MeV/oAmAhpkrgqFjwCWCbEo1IldGyrFpLetHXg2z2AQomjDC+SD/Mb90eF8mqtP89ooCD4mUi+S4aYAkDkARrbAhoFRmadYW1MlIHnRwS5SnwEBc1Vj/aXyGD/9Ng+8Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7491.namprd03.prod.outlook.com (2603:10b6:806:3a0::10)
 by MN2PR03MB5296.namprd03.prod.outlook.com (2603:10b6:208:1e8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 02:21:26 +0000
Received: from SA3PR03MB7491.namprd03.prod.outlook.com
 ([fe80::8a2a:76a5:d9a0:c191]) by SA3PR03MB7491.namprd03.prod.outlook.com
 ([fe80::8a2a:76a5:d9a0:c191%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 02:21:25 +0000
From: muhammad.hazim.izzat.zamri@altera.com
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Tingting Meng <tingting.meng@altera.com>
Subject: [PATCH v1 1/2] drivers: fpga: Add FPGA configuration during bootm for
 Intel SOCFPGA
Date: Thu, 13 Mar 2025 19:19:52 -0700
Message-Id: <20250314021953.18379-2-muhammad.hazim.izzat.zamri@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250314021953.18379-1-muhammad.hazim.izzat.zamri@altera.com>
References: <20250314021953.18379-1-muhammad.hazim.izzat.zamri@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::27) To SA3PR03MB7491.namprd03.prod.outlook.com
 (2603:10b6:806:3a0::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7491:EE_|MN2PR03MB5296:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d00892-0c95-4397-e27f-08dd629eebdd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eFRE94rJkperdrX4gEFYun7XU5eXY5wkiwK8J+hrloPqFrgchdEZaDO04xuK?=
 =?us-ascii?Q?giKnZ9zyPbEfHSEBm0GC/gglUQCJkTlJS9FS54TY0kF4vYYXQK1w/Hwca3i8?=
 =?us-ascii?Q?xvu/+VExXqGPQsfjuLRHzxfJa6u0PpYknk/qgkV994QUO2b2yfsbULS0NRSu?=
 =?us-ascii?Q?DVtlEBqmwdziXoSBy3myJw9C1/CSVPim08aXdMWiSMKzn3Pm6I+yU+92v4+m?=
 =?us-ascii?Q?DVHnGWWm1t15k+cwZ4PAZqGDPge0BS2Y7EG3vj13qk6a/oZkaVCJI5MKxTSm?=
 =?us-ascii?Q?oRG+YbK6hg4s9O2PNHNPFvjFhQo1L6J5X9hsHKK5tdrwaUBLUKy6NSsa1RmC?=
 =?us-ascii?Q?U2Gm9gtCyWBmOOnWXpq97LULLsNPnZOMKsXjA1sbFFghShPQRQEiQUWXrSVJ?=
 =?us-ascii?Q?k3E0zdwXpdu/occbAXSZ96Nu9rH29W6c8m7pBqICnHgOYZT85ILqHprA1bH5?=
 =?us-ascii?Q?2vfXTFCEqYYkrBPKv+Y15AkWfZxR6LP6Zppj+4oSr5T61G/HEHkLbxd5QoXX?=
 =?us-ascii?Q?p7qf7LT5v8IAhulXwgcPSEHlBK9U67f8vAyKJgLi1nMQb0WQBuDvEx9s+ox2?=
 =?us-ascii?Q?+mu8gYIVBTSxfV5wAAQTa6zpD+Q5vQtfQ7PP4x4V5otzfNGl3Wl5JQ9wyQ8t?=
 =?us-ascii?Q?9qKT/xF3M5aPDJxI7tWyDrUno/nTbiVoZaY50JJY2bQdHCM/fUJtL99THWGu?=
 =?us-ascii?Q?vdlZgWbCdNl33ftMprBkTF1kundAWhpvTFBNna+EoyS7V1VHhGuC5VAAsjgo?=
 =?us-ascii?Q?W4Q43n1S1wcZ5G1FTriwZWcyHtepSvfVzKHqR5M/JHQJ6gexjLQJ2J0qdGTA?=
 =?us-ascii?Q?PsVl46UCQZA3wd5OhsmqusZ575TZPxhasF2uYASQl2/shoIeaoRQczI31P62?=
 =?us-ascii?Q?z4MKJJS5WYoKPxnBA8STEHAyQoX5Ad80eWri0W9ampBIxhpoQ2wZR+y3AL09?=
 =?us-ascii?Q?/XKAIuz/b9F+HwulBOCkxwx1cOjBg6T2zc9/xfZjTnYJ/mWWAD9l/48S87Uo?=
 =?us-ascii?Q?ArKd5PtzloWy6mZD4XkeWCuIp/YTBJZ+L96EEElym1zGO6KCsxAxcbqC0UwG?=
 =?us-ascii?Q?0G8Ee1pDHHexQw1mouaoWTnWYbVFZrPAWNrxLIRC0ub+fxV1xScD7KZLuijX?=
 =?us-ascii?Q?aTo2vsR1iHHMbmvsgKipu++HYokcI3euNxrebrs7oSHAhubPYOqL0PLNniTi?=
 =?us-ascii?Q?UWO44srnwowl78WJWHEWQfJJHTTdq0Lgu3f2S5JxFudi6d97IqHuIX5syzek?=
 =?us-ascii?Q?B4snJgXoRJXMClFzRT3O+34QN3BjRGnHG1pNVEliuBBXx0u9hjiQiZ0WR+Od?=
 =?us-ascii?Q?C3IQ4/YiXwgNc2qWs7lCDkFKe9RntysMThSBIyp0ol+W77NBnnFoUM0Q/d5w?=
 =?us-ascii?Q?gTOmk35vyyf95yoV587Zz+K+YZxC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7491.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?10VbtnA4rCzKhUQVTZV9KBxemsGNm9ejBBmlBHFg299IdBlw7Q0Jq1YhcobZ?=
 =?us-ascii?Q?B2chQXKHNo+gYqON6u78wtqy3GeVvc63oquq3jrpsR28vcz0HSJckES6WTm2?=
 =?us-ascii?Q?MGT9vjyZIcJ4MoFTt/B8EB7GvsJbJsDfpFosvjHA9S/sW8CNovEG7Mx9JUzL?=
 =?us-ascii?Q?u+0YGAnDAOPMj9VGFyD9tDJ0hku6M6mDxRJHehqwEUElgtfYAk09tRRUpY1M?=
 =?us-ascii?Q?EJcwO132Ket9/wdBmuftPyyIjM4oCVVXNnmdiI4KItDA6xxTS2oLklHwZ6T7?=
 =?us-ascii?Q?2RY4Fa2gLbNDrUHeUgqg1Q4T4WKFSGycNDgkZvQW7+e4LsasW/Vy9K5g4wFY?=
 =?us-ascii?Q?sWIUTeWofRWr6i5Sz2rDBAe4rM5Q73m3fRez7UM+CuPEOxjd/o8iTJisp+tE?=
 =?us-ascii?Q?t43e18tIYsUCt1AmdVOZ0ZLSGGtSGDCV4Rvl3odKnzr1lK890LA/zq1/rozG?=
 =?us-ascii?Q?zlXM+voG87Pnnav08tHNn8ThlmBA/6nYHatct6pbbqHlS1T3BMdqTq9hCzye?=
 =?us-ascii?Q?HRqkwym7psviV4PfcbYGW/Iwjp/JloFmXkIQCPETsHtKaAHPx/MLfRYNXQg+?=
 =?us-ascii?Q?1ml5r5yO6f1RyLZb4w/r2P1K8ofwFi9Tkk1kFENUh126HyFIEZF9JOw6mmV3?=
 =?us-ascii?Q?4BFOP+dwXsWGfq/2wHTHv4CxAGL+zy1fFDqGd+QKSJhlB+EKXxF4IGrT3zfA?=
 =?us-ascii?Q?cNbdfjhZHbCgpTvazji5Jr56Bx2puCbgleKUlEwQMDOp2bXceXb1+vYCVeTY?=
 =?us-ascii?Q?vYdc0gagMbTon6Y1a0EUWQN6hohpvtyGh0MjuoXXA4m3RWDWVCuhdRMls1QU?=
 =?us-ascii?Q?BvgeRU7Axyq0emsU9UwxcXaagNVVd4nvoDYdjghxWNLRSGjn6DmjJwBgTOyY?=
 =?us-ascii?Q?RulEvGNa6oQtT+EQoWSkCTiC4/YylxbaTYf5ScTXjixY3mrpDjYRqVwuac1w?=
 =?us-ascii?Q?MJK72TVfAmcradBi4qfXEbMxu2KSuI9VlRbvsKHRxoJGgcDY/ITEJ3GAXrcO?=
 =?us-ascii?Q?PJjkT/Qia+n0S0NKwO5MU8x143DXtPpxM4fqGyP1yJFxPyktz+oikYNFhnZb?=
 =?us-ascii?Q?j8nB4KofWOIxFdF7yx2Sb56klX48cIIl5Tk/HWFm57pAGm/FXVwk5RYIs88/?=
 =?us-ascii?Q?dntGKC84SlAM0KzF2xmjke83WUquGLgcnSTdmwnUBI2eN3JnwdPVXHiAbjaj?=
 =?us-ascii?Q?0+pe+GAQdPCaa8Hz8xyWi86D6whB9+8dZJ12zIpTfvi3hO3JJKHjCpTAjzaT?=
 =?us-ascii?Q?jpbVStexRp5wpz3S257RR3/Mp/zL7g4uTAOTX2x2rQRx0g46Q8AEgeXkIxWF?=
 =?us-ascii?Q?Lw2I8X0qIZ3uNBDQw/pPGU7Rxe1kGDwnqGF9uyEvBwOYF+991Fe1+d7JhEgB?=
 =?us-ascii?Q?oqokl/YKg5j5W7juNIlnJVlrJNDB1rc7bWnGI2t3dHVdv7/loDmGrIMgCkoV?=
 =?us-ascii?Q?ylnX8Mr0iPPYrglPOW6i3d5g4PUY7ByVDJO+uJ/6SAOLYlf1/xPONnODw1hp?=
 =?us-ascii?Q?vdw4kJmiPp9lhvBee6lTja6oJ3yMI1StO70CI7gdW90HzKI/1E97IN0ucnPP?=
 =?us-ascii?Q?uzP9WFQRqE3RqlWyIkieZgOHVIUYnsi0WxDfTtDHoeLxCK/NgAHoOy3aEFwl?=
 =?us-ascii?Q?djz6OzGLay0A7IkLBP4JaH0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d00892-0c95-4397-e27f-08dd629eebdd
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7491.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 02:21:25.9142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wuzX5F/Mz4EOtRf440V1oyqUcYNnRMFUa6vQpUsJqhZSBoSVlV/VRfxbBaD+ZvzBfGXMDhh+10YwzD9StZooPXXVct/JEW9dY6qxtJoG75jRPPfkIW/QC7ZMDnpE/W6J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5296
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

From: Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>

Enabling the capability to automatically perform FPGA configuration
when booting Linux FIT image via bootm command. The FPGA
configuration bitstream shall be packed within the FIT image.

The FPGA data (full or partial) is checked by the SDM hardware,
for Intel SDM Mailbox based devices. Hence always return full
bitstream.

Second function is to enable the HPS to FPGA bridges when FPGA load
is completed successfully. This is to ensure the FPGA is accessible
by the HPS.

Signed-off-by: Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>
---
 drivers/fpga/altera.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/fpga/altera.c b/drivers/fpga/altera.c
index ae06f0123a0..136ccfc2de4 100644
--- a/drivers/fpga/altera.c
+++ b/drivers/fpga/altera.c
@@ -12,6 +12,10 @@
 /*
  *  Altera FPGA support
  */
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || \
+	IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
+#include <asm/arch/misc.h>
+#endif
 #include <errno.h>
 #include <ACEX1K.h>
 #include <log.h>
@@ -47,6 +51,42 @@ static const struct altera_fpga {
 #endif
 };

+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || \
+	IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
+int fpga_is_partial_data(int devnum, size_t img_len)
+{
+	/*
+	 * The FPGA data (full or partial) is checked by
+	 * the SDM hardware, for Intel SDM Mailbox based
+	 * devices. Hence always return full bitstream.
+	 *
+	 * For Cyclone V and Arria 10 family, the bitstream
+	 * type parameter is not handled by the driver.
+	 */
+	return 0;
+}
+
+int fpga_loadbitstream(int devnum, char *fpgadata, size_t size,
+		       bitstream_type bstype)
+{
+	int ret_val;
+
+	ret_val = fpga_load(devnum, (void *)fpgadata, size, bstype);
+
+	/*
+	 * Enable the HPS to FPGA bridges when FPGA load is completed
+	 * successfully. This is to ensure the FPGA is accessible
+	 * by the HPS.
+	 */
+	if (!ret_val) {
+		printf("Enable FPGA bridges\n");
+		do_bridge_reset(1, ~0);
+	}
+
+	return ret_val;
+}
+#endif
+
 static int altera_validate(Altera_desc *desc, const char *fn)
 {
 	if (!desc) {
--
2.25.1


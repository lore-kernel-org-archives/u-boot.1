Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC75D33996
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 15:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4900890D1;
	Mon, 28 Oct 2024 16:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="K8yO9ogj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BF02890FC; Mon, 28 Oct 2024 16:23:48 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::729])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCAB1890E9
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 16:23:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYdIySHHsrfdkmvZxKE03uk2PyFI0L9xbrYPIheKVuCFJDzcFS0afB7bkKrKuV7tKel8IjfW+WSqTkSIPX+/kNi9Olo/cfe/8sj+lSX7AHxpfLqB/C3acMIKb/PZ5ry/931bg6xdCoiUnek5ZnnRJfZzHgaLnGvD9fYPCB7LUgqic82IOjREn8+GD/BDRI8db+Pa6HZe/bKsLnQy6jmtDL223kzEZuLnhuvKx3A+sW+mAMk+z3ydUzSgPp+mzCN8cJzwI/AF+K7OY5HkH684p2N9j/DYc+Vb/kswZo4Tf4wpNVn1jWgrUCX97mDuplGNZN+xwAgqupHI3tux39oAxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iiy54t2/U+oPGjSlipHhTsqYRTm7pHKgoVEWyH1jftI=;
 b=EQUVDIWu97gwO7FjY6RWtSF+InGfbQkFeFkRdCBuQc4KIWy2eH1kHajvsaflcX8fUKEJK66ku3LnDOjp93UMQFUrpB/TfYVU/6trsGjrdi0fPETnr0odO621aWNK0RgcOdiw9OcDvMpDCRIg3sacS2QFubPO09cbavRh9WzNB/4T8/yPMjldBrssf5GrL8IozOwnfB8RxsVR1QP+kEXSVew79/isoYcK8F31ddOBEdoh7XIwSTd1/qdsIyU42LPX3gDIQ+8H9wVDza7WuFemc19BxDtHG0w1Y7mIQZTreOBXkfttm+IV4WQNkE3Wf+XjKwc8v/rtDFXC4tEHv55Slw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iiy54t2/U+oPGjSlipHhTsqYRTm7pHKgoVEWyH1jftI=;
 b=K8yO9ogjABAN3l8OaEmp8gZRcmWg9BbdiL+QVmZT6KNqB6uvaZNAUlgGMYtoYpk+Sm3xCLkprNqaT/2nwMTqx5kwjcaTJ3XnMNQKaEMuM3tCGAaeKy1YamAj6RTIF3Vo8/HwQ57CIR4g2Oi6f6ieXq/yz8SWf+c2B/6YejxjBaxh4oKYUxWputLSBi98zFGMDVArUBmssgpB67+1pIP7MbghdUdnc20kUfmGNmIddFTrOXGETo4hnnmMdLc0YQeOe8BKSxWUSAW99waEOTzsb3YzY5lHFn3ZPVAkMaYzcxp4UsRHk/c4F22rRJQ8fIk3966Fvd9UWjZahlzm+fUmuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5697.eurprd08.prod.outlook.com (2603:10a6:20b:1d7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 15:23:44 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 15:23:44 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v4 2/3] cmd: mtd: add nand_write_test command support
Date: Mon, 28 Oct 2024 18:23:33 +0300
Message-ID: <20241028152334.1814929-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028152334.1814929-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241028152334.1814929-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF000045C5.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::43c) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5697:EE_
X-MS-Office365-Filtering-Correlation-Id: 69092dac-3d72-45f4-b563-08dcf76482ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YUB4oT3hvdEJ+Qlg0EKXh6BO/uC6huc6X6z/GogxJf0ZwJINVbLkaNOusfrx?=
 =?us-ascii?Q?wLSKm6aFCly5mEpTHYI0/SAs6fEW3PWSVC8eg//urKYWKBivA98BaAQyUaDg?=
 =?us-ascii?Q?oujBye8Ax9wuxchcMgzgv3ho5wkZNi3Le73CeXHfFC41mD20ybRDj6k5xJ3X?=
 =?us-ascii?Q?4bQjlvo5vTwq/GOOdJuh9Yx81f3F4Y0onStl+XlWo/3eGlsqFYQzamf5yGDW?=
 =?us-ascii?Q?A7yV3Z7rMLTMSLC6lCmrbFDfyEU6ixqu80IuA22oG5YVf+fd8lXY6ZT1VZhD?=
 =?us-ascii?Q?XD5EM9AHmzyjVw8tu57JZNrQG7nXtLSWjrvRZsRQ0LwwW9F+kzhSliMgoLL2?=
 =?us-ascii?Q?ViUyqQ3hELEXTiBAvSxrxizE+1sBVW5C0oxD3E2jiJQfbo37TRYPsCukQ160?=
 =?us-ascii?Q?JH6gNh7I1MTGn1MBoz2atHFmiQAdTe73v79KMq1PsVqwo2bfApzPmqvGCdXk?=
 =?us-ascii?Q?GtNr6JVFXBQY+M7OJt5ZHYjtH5kP8pYeJ2Fo2GfRmfr4oVQCyV0VAK3sVXE7?=
 =?us-ascii?Q?uojP2LFHwfZAvDcIIAaH+Hv/0CYB6cA+xItbNDaQY83/Em6zsefGqBBzzTU1?=
 =?us-ascii?Q?QImB3X6Wc/PAxCTckOxlbZ50I1cHRqFrkodgbnvc/o7a06xpP3w95whJRQ0X?=
 =?us-ascii?Q?XCCAQ1pRAJ7ORBjNkPNE6yzT16v/47DQOMdyVarw+dDMbMaN/ZVJyUO4h8Y+?=
 =?us-ascii?Q?1JqPNQoA0wpSf7ic2SZMNN+rL8bSZKK8djyrrumBLbua/zdvKhLKuXcbkEU1?=
 =?us-ascii?Q?P+4JscfRZe9sqeu1eUWsC+MF81iMpXN3Z1YZXKckE2oF5CP4kPmdFqQ2oV2P?=
 =?us-ascii?Q?MvSB8DlL6CG+QaaVy5LHvnHV5MAgfAItNRs1gHwdWt0StH8vbXZ/RdMWHl9J?=
 =?us-ascii?Q?f4J+fsfiRdHe2i7I0PJ3CpxQeYIid/RBSMY2O71rDHt6KB8eF1ph1rNA2gcx?=
 =?us-ascii?Q?IElrZjxBmP2vfABVOwS/0aztpmdfp1n77YaUmljY7khzNT+yGL3FMVb0qCyk?=
 =?us-ascii?Q?G1wI0lrwC7EmuLtE+L2WbvMGjysp6ufp9Mw9Yoyem/hz4gnBAPZi89kwBzL7?=
 =?us-ascii?Q?VvNCFlFsTAuZJssn63/G3SgQD1ZWpgM69pmFij/8R9bHQdptIpiS8BzA8XnR?=
 =?us-ascii?Q?jJJpWpo++uXh9v/T7AJkqs4LM5pFkX6kkEND5rV+gMiejZebglFGSuwgx72i?=
 =?us-ascii?Q?6kZPHiag9wICl7UJT1d0XQ7bCpElD/cY6N7+JWVCGyyFKUFuw5JXqORnO2GI?=
 =?us-ascii?Q?fznAuLxEFisXGvuQ4kInQhH4hhViZqfm59Sb3/vem8TzlmWP9HMH8QlSWgP1?=
 =?us-ascii?Q?v4H63MmItoAZ3oPPKGYVF6+xN7I2i8TN5fLwf7kFdO/CLgaMHmWMkAqK5eCD?=
 =?us-ascii?Q?euCS5btbhOYov1ElwAHrhdNZYLos?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f0EyK8isu0+bdj+BATNY6y72ACzDq3lcZ8sTMf0QKZbIkRf5Y7XUA4dsmKoJ?=
 =?us-ascii?Q?GuWNMv56oL1sa6n3m6R5lUskE6o3n6GOOLzyj1Es/r1NrQSqUJIf25HKOErf?=
 =?us-ascii?Q?fFOdnS9f1AtW87I69eHGvtqUXOuAs3jxjQBMJrGGQdZAJ/Aa+UDzl4i02PEb?=
 =?us-ascii?Q?vGCWvXUQeCGn4lh29Gup3vRsOFIZ9eUwvTn09T5IIdfqyhbpfXMeaR9xmwVo?=
 =?us-ascii?Q?OHqTnFJUQW8KNH/gjW/D6HIDKOSOoeEtG44/9wjQZVtlAiJLxgiGqsiaDB4w?=
 =?us-ascii?Q?m/4LbJqHB+OfMsdO1GQDI3d0Kn71TWKesO9S1+ED1PX4s6v0k/IRomQNPRqM?=
 =?us-ascii?Q?SIu8v6UNvnfRUnb/4cseMry/WZx7IGKMNcSqzah4GkbHd+gqduZNuegE0QWJ?=
 =?us-ascii?Q?gmibXURVbIhdlWjbokFDn6t0tUnJPlAjCT6QbqjShyAROLa5ZzKKxYG2PHSg?=
 =?us-ascii?Q?y4XeK/sOqhW7qigHVsbdJlV9DZEcfrBUMsAULvaJLA96e7mfgOeV6q+0+Q4q?=
 =?us-ascii?Q?Jf+wBG5dVHHaZoRXDfDuP9OnG2wEzfCv9g7bcLzSURw7KKNo0mk0Idhlxmna?=
 =?us-ascii?Q?yBePJSMDEjIVTCYoLK4xGcJ3HGr1231hHyN3oBRNq8Yhr6DM/l5+q9ha/K/f?=
 =?us-ascii?Q?RssjJNTrZAassn2h47xOhwdagWSpo6Dceu7KjUWkSVDKDQ9LJ9MAOaGxQafh?=
 =?us-ascii?Q?2H3n9J1bITu0kxjgAAKCtffvPkcibYQMY0olXU8PWeW/AzSMMI0zTHgYbWeM?=
 =?us-ascii?Q?N2YJ10z+U7860HAg0owYIAldp9zdxxVzhoamOsCmx4Ww6YGcdKJbfI4kEXMF?=
 =?us-ascii?Q?ciBZY2Vrx1CHetjz4T6R9hZShMdGRbmgXjimDWNooXbrTcE/nuBGznOAOWhm?=
 =?us-ascii?Q?Rtt3n7o0mESkvXJxmBJup4gPMvA0399pkblihghEF0k3V0FqqfVEfFsOUqKk?=
 =?us-ascii?Q?XRDD8KmhyXy41QZRvSoXlGAZJkMT16u4M6w68/cUHwkcAyQA/P8x4yoGait9?=
 =?us-ascii?Q?pCWAfO5SfVpl9bY5e2xhS6csI0wKHd0nV2KNxZZZEO5ypWS++Gppc7zsE5XV?=
 =?us-ascii?Q?Pum1nYLO5AEb1KOCcx6aUH3KpJJOSw2J0qeswqD2GYRrnnKZUhImaN36l+C3?=
 =?us-ascii?Q?HdKYUj0BaWHVGkGrx7ZCjvi2YV4zucfXDFRgnwUWPAElcTig2bUQ7zkOmiMl?=
 =?us-ascii?Q?mQEoYuIpVfNccy3pEbsT0Gr5NnD35Yb49XydFJbyS9Lqsd+wyLOI47u05byP?=
 =?us-ascii?Q?madSHziP19CeMrTOBvt03K8hzvxgNw18F3FBQF/mFQBOFxZHuBi3OoMfaQL1?=
 =?us-ascii?Q?vbYKFlWEcE9mqSM3PWL06ioawOdZgxfXE9EzNtqsrst4Bhf3UwUlAfEUhqPW?=
 =?us-ascii?Q?s31CYtCuS2eC8f4fEal+m8h6shV8dGzGiC/mWK9qhxlrkdQvKWSs2bjHwt7t?=
 =?us-ascii?Q?MRXAiYaSbRk5r6MnUa1GvC2IUB7EjjmSOHxvl8Fk7oCD33UuXMYns+YFXJ0y?=
 =?us-ascii?Q?9oqa0esj3vlyEj5KsCTmZ+mFeGEZ9XW75bC7v22ZxjF2FvWQyaBQotbSqpAj?=
 =?us-ascii?Q?BmK36HEV5Oc4KFrExQFTmYgwpt+zjJslu0fapqmbYJlFlzQ3AgsmZxubbQB3?=
 =?us-ascii?Q?EYBjZhFAcgqN6ZRHzzeTY14=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 69092dac-3d72-45f4-b563-08dcf76482ca
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 15:23:44.4696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94Qv0Wwkao6jgy67SZg/pFzDTuP04fDZEPk1Rja+2Wohb286e7t7kbfd8xGWYJVROzcfc20S8NnX7GHmg0lPUU81jur2Zu6z6Vt8P7UIp/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5697
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

Some nand flashes (like spi-nand one) are registered with mtd
subsystem only, thus nand command can't be used to work with
such flashes. As result some functionality is missing.

This patch implements 'nand torture' functionality for mtd command.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig |  14 ++++
 cmd/mtd.c   | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 211 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c2ece0a7c1f..43eb13e44b8 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1468,6 +1468,20 @@ config CMD_MTD_MARKBAD
 
 	  This is a clone of "nand markbad" command, but for 'mtd' subsystem.
 
+config CMD_MTD_NAND_WRITE_TEST
+	bool "mtd nand_write_test (destructive)"
+	depends on CMD_MTD
+	help
+	  MTD nand_write_test command support.
+
+	  Writes blocks of NAND flash with different patterns.
+	  This is useful to determine if a block that caused a write error
+	  is still good or should be marked as bad.
+
+	  This is a clone of "nand torture" command, but for 'mtd' subsystem.
+
+	  WARNING: This test will destroy any data on blocks being tested.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index bf08f483c14..bcff020bfd3 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -19,6 +19,7 @@
 #include <mtd.h>
 #include <dm/devres.h>
 #include <linux/err.h>
+#include <memalign.h>
 
 #include <linux/ctype.h>
 
@@ -751,6 +752,194 @@ out_put_mtd:
 }
 #endif
 
+#ifdef CONFIG_CMD_MTD_NAND_WRITE_TEST
+/**
+ * nand_check_pattern:
+ *
+ * Check if buffer contains only a certain byte pattern.
+ *
+ * @param buf buffer to check
+ * @param patt the pattern to check
+ * @param size buffer size in bytes
+ * Return: 1 if there are only patt bytes in buf
+ *         0 if something else was found
+ */
+static int nand_check_pattern(const u_char *buf, u_char patt, int size)
+{
+	int i;
+
+	for (i = 0; i < size; i++)
+		if (buf[i] != patt)
+			return 0;
+	return 1;
+}
+
+/**
+ * nand_write_test:
+ *
+ * Writes a block of NAND flash with different patterns.
+ * This is useful to determine if a block that caused a write error is still
+ * good or should be marked as bad.
+ *
+ * @param mtd nand mtd instance
+ * @param offset offset in flash
+ * Return: 0 if the block is still good
+ */
+static int nand_write_test(struct mtd_info *mtd, loff_t offset)
+{
+	u_char patterns[] = {0xa5, 0x5a, 0x00};
+	struct erase_info instr = {
+		.mtd = mtd,
+		.addr = offset,
+		.len = mtd->erasesize,
+	};
+	size_t retlen;
+	int err, ret = -1, i, patt_count;
+	u_char *buf;
+
+	if ((offset & (mtd->erasesize - 1)) != 0) {
+		puts("Attempt to torture a block at a non block-aligned offset\n");
+		return -EINVAL;
+	}
+
+	if (offset + mtd->erasesize > mtd->size) {
+		puts("Attempt to torture a block outside the flash area\n");
+		return -EINVAL;
+	}
+
+	patt_count = ARRAY_SIZE(patterns);
+
+	buf = malloc_cache_aligned(mtd->erasesize);
+	if (buf == NULL) {
+		puts("Out of memory for erase block buffer\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < patt_count; i++) {
+		err = mtd_erase(mtd, &instr);
+		if (err) {
+			printf("%s: erase() failed for block at 0x%llx: %d\n",
+			       mtd->name, instr.addr, err);
+			goto out;
+		}
+
+		/* Make sure the block contains only 0xff bytes */
+		err = mtd_read(mtd, offset, mtd->erasesize, &retlen, buf);
+		if ((err && err != -EUCLEAN) || retlen != mtd->erasesize) {
+			printf("%s: read() failed for block at 0x%llx: %d\n",
+			       mtd->name, instr.addr, err);
+			goto out;
+		}
+
+		err = nand_check_pattern(buf, 0xff, mtd->erasesize);
+		if (!err) {
+			printf("Erased block at 0x%llx, but a non-0xff byte was found\n",
+			       offset);
+			ret = -EIO;
+			goto out;
+		}
+
+		/* Write a pattern and check it */
+		memset(buf, patterns[i], mtd->erasesize);
+		err = mtd_write(mtd, offset, mtd->erasesize, &retlen, buf);
+		if (err || retlen != mtd->erasesize) {
+			printf("%s: write() failed for block at 0x%llx: %d\n",
+			       mtd->name, instr.addr, err);
+			goto out;
+		}
+
+		err = mtd_read(mtd, offset, mtd->erasesize, &retlen, buf);
+		if ((err && err != -EUCLEAN) || retlen != mtd->erasesize) {
+			printf("%s: read() failed for block at 0x%llx: %d\n",
+			       mtd->name, instr.addr, err);
+			goto out;
+		}
+
+		err = nand_check_pattern(buf, patterns[i], mtd->erasesize);
+		if (!err) {
+			printf("Pattern 0x%.2x checking failed for block at "
+			       "0x%llx\n", patterns[i], offset);
+			ret = -EIO;
+			goto out;
+		}
+	}
+
+	ret = 0;
+
+out:
+	free(buf);
+	return ret;
+}
+
+static int do_nand_write_test(struct cmd_tbl *cmdtp, int flag, int argc,
+			      char *const argv[])
+{
+	struct mtd_info *mtd;
+	loff_t off, len;
+	int ret = 0;
+	unsigned int failed = 0, passed = 0;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	if (!mtd_can_have_bb(mtd)) {
+		printf("Only NAND-based devices can be tortured\n");
+		goto out_put_mtd;
+	}
+
+	argc -= 2;
+	argv += 2;
+
+	off = argc > 0 ? hextoul(argv[0], NULL) : 0;
+	len = argc > 1 ? hextoul(argv[1], NULL) : mtd->size;
+
+	if (!mtd_is_aligned_with_block_size(mtd, off)) {
+		printf("Offset not aligned with a block (0x%x)\n",
+		       mtd->erasesize);
+		ret = CMD_RET_FAILURE;
+		goto out_put_mtd;
+	}
+
+	if (!mtd_is_aligned_with_block_size(mtd, len)) {
+		printf("Size not a multiple of a block (0x%x)\n",
+		       mtd->erasesize);
+		ret = CMD_RET_FAILURE;
+		goto out_put_mtd;
+	}
+
+	printf("\nNAND write test: device '%s' offset 0x%llx size 0x%llx (block size 0x%x)\n",
+	       mtd->name, off, len, mtd->erasesize);
+	while (len > 0) {
+		printf("\r  block at %llx ", off);
+		if (mtd_block_isbad(mtd, off)) {
+			printf("marked bad, skipping\n");
+		} else {
+			ret = nand_write_test(mtd, off);
+			if (ret) {
+				failed++;
+				printf("failed\n");
+			} else {
+				passed++;
+			}
+		}
+		off += mtd->erasesize;
+		len -= mtd->erasesize;
+	}
+	printf("\n Passed: %u, failed: %u\n", passed, failed);
+	if (failed != 0)
+		ret = CMD_RET_FAILURE;
+
+out_put_mtd:
+	put_mtd_device(mtd);
+
+	return ret;
+}
+#endif
+
 static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -836,6 +1025,9 @@ U_BOOT_LONGHELP(mtd,
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
 	"mtd markbad                           <name>         <off> [<off> ...]\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
+	"mtd nand_write_test                   <name>        [<off> [<size>]]\n"
 #endif
 	"\n"
 	"With:\n"
@@ -873,6 +1065,11 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 #if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
 		U_BOOT_SUBCMD_MKENT_COMPLETE(markbad, 20, 0, do_mtd_markbad,
 					     mtd_name_complete),
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
+		U_BOOT_SUBCMD_MKENT_COMPLETE(nand_write_test, 4, 0,
+					     do_nand_write_test,
+					     mtd_name_complete),
 #endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.45.2


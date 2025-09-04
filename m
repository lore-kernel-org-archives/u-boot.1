Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2F9CA1002
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 14:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 564CC83B9D;
	Thu,  4 Sep 2025 16:50:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="53Tohki4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C682E83B7F; Thu,  4 Sep 2025 16:50:38 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A041C83B8F
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 16:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPM4/6UUOY01NJ/44T3P7dJC7I8OrmnhRRPKG01TDZBpDo4eWc18CcR2hcKDITk3I4c6R4/Hwp80Ds6OObhGOMBLEQni3Utq/vXVSgdtJfMO9AgOPQHyS3T6AKKDt4OpKGhLJ7quMP1gImaq17uEimxEe84VY4/vsdA2XGd1rJY6+c0EURTaTG2WPzBM1J2RQGfxzmYHC/ZURKzA8TO4Jg4icmpoSAjAn3hd/lhHPoSVC5lPZbf3ueR82qBu1RoMFKb3p2QeUejyFddT9u6j23a/+V2vuPuQiwJ5ebv/rUVtAFGKwFtBb3p+wsEVYBHNi99hm9f6rkZ1WdF0l0QBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+14esnUcvHc7TuN4z3zgM+OwDLD6LAVkq3b30tsipPM=;
 b=ubNDWpxzIu5OM3yJw2wKSjbEWzrKSX3Dge0k4KLgIdH2+ViC6Jb75W328s7OpNWOrC8nnr0HyRfTGs3ua/OQ/lWEsNguiOBSqsD7bHKlGeVFowrXIvzuMIhZDsXFdhJvldM3aHcHJW2zp68l3xTWge7FKsByiwxthskUu5/ttL/KzjP2EOcSYTiwCiAgqFMN+8NsfE5FATr/WhaIzcGiNXGJFZFsDp5CywddbGEiHUtqcIx3ws1OcK51iu/0NZUsA8rQoWaUGtoVemj2Xk0GIbGEaZgyyK6DUbNGezopgMqw5IRHNKAtYkiMS4ZMI+KgExH8Lh2dfHhs0675DNqSZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+14esnUcvHc7TuN4z3zgM+OwDLD6LAVkq3b30tsipPM=;
 b=53Tohki4bnn/l/v9TJLucOvIWV5FGdClWKBwFzDL8unuyqxv9v+k8tLN9178HKjZjA0+YSW+DzG3fPuGkRcoJFYIbn60bYBrzeNxf8qKoc3Tt8vdACD7yQ0cDdbDWorEGzAwS0+RknUHDJ2qBvEibHSSK3pULlo5CXL/MCD1bzkMuhnoWOMTL3dU6f2uqSGhX9U7uMAHcSl08NEA2AZEb8+p3XdJj1T6GBHS67QrNJ6Wq9jgLBHgwuey+dVoYdHarOeZPgdfnK8onppljkeNoEhxTdhSsIuxDH8fNQpV9gkz9ihbaq9nClSvBHIDMiwLBi1Sy/lSyM1SJJI9LtvkJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7582.eurprd08.prod.outlook.com (2603:10a6:10:306::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 14:50:35 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 14:50:35 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 2/3] cmd: mtd: add nand_write_test command support
Date: Thu,  4 Sep 2025 17:50:22 +0300
Message-ID: <20250904145023.659922-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250904145023.659922-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250904145023.659922-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0056.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 8455a3b7-ef5a-4447-be4a-08ddebc26766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DphU6+nyTtjS1Gft+qhpY1jSaluUfaPSzU/23WiVe8UtzjmoT0iCo2UwhrHb?=
 =?us-ascii?Q?f6STZRyN0WLssiW3DWdpngwvCaFetgaXVmmS5hvl+P5+vbGIWdCe9PRYYxbK?=
 =?us-ascii?Q?a39OXKtHHN5YO6AJueJ+kfGpDY1ngA+Lbr7AsfOBENvteaazvNDuqKFmZYVE?=
 =?us-ascii?Q?aN4rV4TiA+IVuSpumsJ2N53K5bOBrn3XuwDKiG7riG9PzBTzzXIByHr0kGdq?=
 =?us-ascii?Q?2MuzVwvWKAx9A1LgYS5aE5A62r6cgfK3gAjgRUHL56cjhFcQE8kxoYQdqFI5?=
 =?us-ascii?Q?YG6g9gT+S6a5tzLKssTZIh+IZAaXL3jzNC0473s1+P2dvxAJi2+xPYCTPsol?=
 =?us-ascii?Q?TBoYeM+Dbk7PA0yWHhJ3PXk/f0RToMweRYKLg8QStmGsfaBeg67r3YMsgdLh?=
 =?us-ascii?Q?l/KK9aImm+JyTkgig2RXkSxpCaJDJF2ExwajDZ6vS3Vz3U9UHeHFE4fQErjs?=
 =?us-ascii?Q?af04nQYQyQ6X5gfeqRz9TMhrb0Wv0sG/t1kXH2ceYQYoAA66xbvr23UWUvjv?=
 =?us-ascii?Q?y+iACeea5Clm7KtCHIwmE/+q3orZcXLuse+gSWS5EHdZRqbd7+tYv31B5CFo?=
 =?us-ascii?Q?Jo7zat4AcOoR2+Tuk6uiMFiAtxgB6FiagwO53VM7GoBXx+GbZJS9LQSZadDl?=
 =?us-ascii?Q?P7iZgFwtJ42cYPSPYj7mLkIyxeAd3EfOfNN++7/Bw2n5suADLCKxWRP1dVjM?=
 =?us-ascii?Q?KfFPjqnKZjjDVgKyhxHJP6VJ0mIf6poSPEFDNBx4IEW6CeuA+pBWHqkYMa1t?=
 =?us-ascii?Q?LQQxqiMY4lWKZd1aLu1eKrkkUvjy0JAqT5ZRMfMSAGpnebXCfV/ftqx5CQcQ?=
 =?us-ascii?Q?Ko0Qhf+mUwTRnnWroob7lj9MnYjSiPa87pTy2AhOGlMHADiMtEicsX/uoaVE?=
 =?us-ascii?Q?s9tUZdpKzv8EBgFdlVpELhl2FaZ9JHZmh8PU8TrF34LziMR7Ht08Gc5Zk9vs?=
 =?us-ascii?Q?TB3zqe446LwRtre30oFzPWSmVne1nf9mWnpB5dcgzCnOb/e8zxkjfwzB5hNU?=
 =?us-ascii?Q?yuRN0hVpjAQ7F0hwphFs8khhe49vYpNeBxqA1WQdMxqe8JrdunuTl58la4WF?=
 =?us-ascii?Q?WKI5q/suk8ysGc4Z4TkDDhyaWIr6QtDxdj2Hdhli0kNxB59zXq237P+NhCYf?=
 =?us-ascii?Q?+zV72FtDzUjhseg/29p8W9iSxK5/wPyQ9JjF3VdZ2nGmuU0uAjdawcYhp1KK?=
 =?us-ascii?Q?QsJCegjlCtjUgrEW6RqCYD5Z1D8j8pHsRqmBxa4muUhAAW16acPk05t3K4O5?=
 =?us-ascii?Q?oWIAouYxwDbcQWH7d5fqrypadmWSk66ItC9N1j6ZA1A4MDIq0PtWJq2KpJ3N?=
 =?us-ascii?Q?qX+Du+zdQ+/AGJS8sNKb1YEnvJwhSPPKbhRy02BWkS+KUuYe4bhvCjDb9ufQ?=
 =?us-ascii?Q?E1KrVhejb4sLVpbOg8WA7QxyN4ZuGOY2gc+QcgYxAytMmgwxwzdsBPGcEe66?=
 =?us-ascii?Q?V+ZI14oxCrL4j/lIDbyiN3LvBF6IJLfuTKCgiiL6gVTYbsx5PgQSHPAka8qX?=
 =?us-ascii?Q?tYeAaOv/6nUHKEo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eZBnct/xiEqZhdAuJe//C2mjYHrep8IUMC1SndAp4Rfxx9S9J/uD8W59V/ya?=
 =?us-ascii?Q?8CbLCtrxIdZStnf1UXnH19yyao/UMUtnbObj7uevrcz597H0OBEw8i46LMjj?=
 =?us-ascii?Q?WVBhCr8kbXLiXxOwTEyhJir2guam6+pA//9uQYB7qBa2Su5vHaH3TzKH/HEm?=
 =?us-ascii?Q?heiiIZiWLLiO4cnitm5h5eQiLtUV9DUlp3nq4XP0CGOFJTZbRjGJanlXoYUP?=
 =?us-ascii?Q?KxfQkI6Zy69XywThUqo/Ev7FhiOUqbJH03OYo1MS66GTSXEUpjVGx2k1bxNu?=
 =?us-ascii?Q?BVBIYhmQWqAGyOD9SfBg15u7pHqffxKHBJ6LBABfujXfierX6e6TB6RZYono?=
 =?us-ascii?Q?lNgKiGKW1G99tZuhczd19vuTDJWFFk1ilz+KNQGMRq5WXRYVD71Xem2lWjSW?=
 =?us-ascii?Q?KYrd8V7o+NMDlwp4h7IT2sbBzHnidRYx+XpBu/+xo2DEs3+NUhhFo5Zd2lau?=
 =?us-ascii?Q?41JX3XejNX/hCvEhEEggWff1K2AppFgSGckcSrIjl9PlnsP8YbfdVnctC1t9?=
 =?us-ascii?Q?OitBccT3hAewK8BzI46yqV2F7lD7HKPitgy2pRDcd3Gm8iO8XmBwil4413at?=
 =?us-ascii?Q?shzm7ZerJPWBaVhtPPcwAmccz3uhm5I9dqyEhkAWaHWzWG4E8j/RaXwRiEMI?=
 =?us-ascii?Q?giBNoDiMVBmHL8Lt5i9OO25mQWHXXOvkDoACVCBo7XroC/layzZ09ToUhalH?=
 =?us-ascii?Q?6jy4zS//4+qZ6CAf42rc5dCWKla6rZbA+NUOLETo1XXFnmdnAOVcQ5eQAJ4F?=
 =?us-ascii?Q?/ETa59cRPzTLw2HoaX5OfEv4EUWMS5UUs+29PmXhPJD1Z79lcjakTVQDR07i?=
 =?us-ascii?Q?fM44TD5+K1qMtiXIufU1OWRiFrCBOOIFo35FvYbrLvjGLwruNOi5+G41J0oT?=
 =?us-ascii?Q?gTR3ym7J7r7oD0dlDiRXtFt2jrYqvkF3rrw29JnRJEOn2QOFYX1BrKUzl8mm?=
 =?us-ascii?Q?uiHpaZGaimDauX/DTlPfiV0/4BIAxpYsEAv+bgutGiBEYzI6kyHtZRnpD9Ig?=
 =?us-ascii?Q?rBu4dTrn2Yh6xWehbo6iGcGx7ydZ0eDDsGkJAMOOK5B140Mpws+OmYeAlmOg?=
 =?us-ascii?Q?14LoRetzhfv6znFBjD08d5iu0ijLKC7xDlIbw+tg0OJyAMwyMIMpbZ0PAJTf?=
 =?us-ascii?Q?HUZ4+HMmCVhN80mk2H+r2W+XSDWSrr+IE8qxaejR618o8JM4AgzEdzTPIpRN?=
 =?us-ascii?Q?SlTHWrgY3xOPZdJY/jYUWReeFsB5tXYQiePGWgTZ1SAe3RpmcmYei8FIpual?=
 =?us-ascii?Q?i8+NincqJNJh3bvwfnNJkluzStDZEWaBLCvD+Sig3LSIbalXKTN5klyr/RML?=
 =?us-ascii?Q?sAwLGk2mVLn21bAx79jr3GciZRFqo+6sYM22seZ1pOftPNIJHYy9GBgKD9ZA?=
 =?us-ascii?Q?KiP85TCQG3lLTutzE1gd2ykLMAcev7XXO7sGgl2RAtDOOuUh3EO+GHQ9GPGG?=
 =?us-ascii?Q?e+2dte7OsQePvIhPwKj5QVD0QNTWRetmWfZfQm1IJaCAeXxiPRzj/zM5HTLj?=
 =?us-ascii?Q?xLPndorhtl816Yai+tiSzvgw3KIV4zssmTFLjvPuWWHWL+OR9jcNg0z3BWP+?=
 =?us-ascii?Q?rjre9YVUGhKP0tPBJY3aeLOST2bfnL53ZEqOyK+379VNAYG2O+JHfjyrz+bO?=
 =?us-ascii?Q?Xz3Eet+P0Xgugn6Xb0zaMVg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8455a3b7-ef5a-4447-be4a-08ddebc26766
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:50:35.0213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmHYbieWzrF20uA60C5Vrfjby0GqxJtOZXQIMGtXUU3fbslA0MlqA71A0EH6MVmFLTjZZZ4aIJUujB6nfiXNkrqQFSTZZOkQjXshimWcWig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7582
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
index 8f2a35d780b..cd1a664f34f 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1519,6 +1519,20 @@ config CMD_MTD_MARKBAD
 
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
index 95e4be9863d..4d69c7b4915 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -20,6 +20,7 @@
 #include <time.h>
 #include <dm/devres.h>
 #include <linux/err.h>
+#include <memalign.h>
 
 #include <linux/ctype.h>
 
@@ -762,6 +763,194 @@ out_put_mtd:
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
@@ -847,6 +1036,9 @@ U_BOOT_LONGHELP(mtd,
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
 	"mtd markbad                           <name>         <off> [<off> ...]\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
+	"mtd nand_write_test                   <name>        [<off> [<size>]]\n"
 #endif
 	"\n"
 	"With:\n"
@@ -884,6 +1076,11 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
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
2.50.1


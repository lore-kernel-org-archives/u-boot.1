Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44174EE49A5
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 13:39:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6569988F4C;
	Wed, 11 Sep 2024 15:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="iGQuPR0v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B1CA89297; Wed, 11 Sep 2024 15:39:09 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::61a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C1BC88F4C
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 15:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N08uc1xMSND+jjMzPK/b73uw+iW/wKS9DhYBSDva0nyHBmQhw2p148iaD7Z+HOMZWs9nhNjEd/T0E7ZYBibP7rExfBjV/FjqnzGrHFrVP0ILSN59M3c81WHnmEpgJFtDjZboLJ+WNpZsxFKzxMJ/naMER3KTWCRAGrZI8H3wSo0mbXUDhIuO/wkFr3YADUSsBVs4WoXwYo0agXvOnh8AQdNl/z+wXubEA5ME9D3w3c/hIKlryNcFxcfU3GbmcN+r6czq82gVM5cG8wcEEDKNVd5j7AZijnV/4q0T07g2rlp/xP6xynqu6BonLqvWeVNH7mRymDO8jN27YTRVsUG+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJ+pIVjuzZoWLXLYZS08KuS0IQtdJkStQMFfOBvm5uk=;
 b=LJwqe6JQR4xvMI3w8tbC33WVPbq+A41hTDtrsKgZNHMJSzCtt1V8WJE9TkCaQQZFWoO9unHf7h5JxGgudER4jPS94sq4xLupPy8MhwWyEA2DgS0mUskk5vuJ37yHAtKiz1J+3PrwjG1IgxAJz/cEvPIJV9BbWye2cdjQ4m7/Bcva35HOWcW1x9vE03vJJ49a3yra9a4RTM+Pe8TagUJl4YmMMhoDE/qBY4QyMX0tXa9ylEI/Q/OfnoKoVccjLFnLeahvxShnlT3ghlgLZr5nRvdOL4HPOUH5sKC6Dhf5cxbvJrhG/abHTMHxuYzkWOTO8xX4H5fugnY4eyDD+hBD1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJ+pIVjuzZoWLXLYZS08KuS0IQtdJkStQMFfOBvm5uk=;
 b=iGQuPR0vrCbvIJSeDLUpgAJlkaXC4X7+BpZvt3PSdfMdM3Sla83D/8bkmuesnL5kWJxuIYbXmKOexVr33eIzbcnniBqXu4Cj8Mpw4jC9KJwzXEgaQtYvLiOvkprjIsPq49w5CzrFLwwbdM91SeZ0qJwcXqpaaaLeZ82h5Sqzxks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GVXPR10MB8083.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:115::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 13:38:59 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 13:38:59 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH] dfu: define a callback function for the dfu_alt_info
 environment variable
Date: Wed, 11 Sep 2024 15:39:00 +0200
Message-ID: <20240911133900.1444083-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0116.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::33) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GVXPR10MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: ddcdc62a-e22c-4712-d0b1-08dcd2671763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gTWiAi3iqH88g40MZBtWFiZhDWtBdKj6TR5dhEU4jD4kp9ZgykNkKqY0LGTQ?=
 =?us-ascii?Q?7R9SsWJY/7fp6F1ovPji5UYq5GEri61fEO2/ZeQD7vtNLLeAbw2TavrbAXXL?=
 =?us-ascii?Q?T0sv5o1OuPcAVviGK/J+FWbZG0zWDUwmRUTtFk3M5uv/JVwV/W5Je6wpkGxk?=
 =?us-ascii?Q?GeEWgro+g8KOFK/RoVRtLlAaDuFNmkNyXN8q5GIg0qvyIvdqCxFJyJoNkaSI?=
 =?us-ascii?Q?AipD/gucGmolwzhtla/LSXJQmWSuRVykkqIWP20X9FCEFeleE+FX5QicKiKp?=
 =?us-ascii?Q?ix0IHLoakEyS4MvTppZ0QLF7DKu2Q4wVEMRpMmRppxVpGPBuoWy5uQkoLFkJ?=
 =?us-ascii?Q?buL81yB0YtrZVRoDo5MP2Q8RgMyflUwLSu1k8aCKPu0eyTWJ0k7pxOb3tlle?=
 =?us-ascii?Q?Ohh0ZCuyI8DDNyS4scslmAD4VufcNabfZb9H18V9P+8YTYm4tYsvCyZh5jib?=
 =?us-ascii?Q?WkCtB8AlRZiKzb09j+zPRH6KEWVa2HHj//7L+VevxhGVfB869EklVAk6WEr2?=
 =?us-ascii?Q?Iu+sqcl2ExSZ1xjWpiLj7EfQz85Ob3NZqSXqIK1P2SB25Gs2wSeeFUvWm4eN?=
 =?us-ascii?Q?LrDypCm2ns8cVWlGbDD/aUcMXMKroPRLFGzTUuJoW9EBPnZSRcw3W747Janc?=
 =?us-ascii?Q?CxqWzv/C7aIoHuY3DZwRy48RdR/Pp+HuMVGGgTooXrFyecXHfbq5dmTcOnDe?=
 =?us-ascii?Q?whTENKUoWbNvnmLULftOtx6WOM4yMeaoHz5iASfKOAZilXUTvbVU39ByTxmZ?=
 =?us-ascii?Q?8HnQI/c3IX+WrAVdvvxnRiJYHktF9K+0yJpKZQLpo0AG2nYnkq4SUAcun1SJ?=
 =?us-ascii?Q?ujf2k71hP0JbO0fmA8ldtDFfZlWaD/L8DCqia48UUZ2+V8KultsNPLtSFrPL?=
 =?us-ascii?Q?vMMipo4aE3pPl5w1cldQdIO/eiW/n+9ZTbOWeq/EEZKG7Gnr+AGJvjFWFmGG?=
 =?us-ascii?Q?vScmFu2h4U/ttDP9z5P/EiFJNRGbuViQPNdRM2kgB9RkNZmT3ue17gfNlAi9?=
 =?us-ascii?Q?F4cWPJjFRCHsJ4iL0U8nYtBbvdukIFsTLSNjXBICJHyLn8kOFFIH1xwytv9t?=
 =?us-ascii?Q?CXkGmdQ1LSloaOBbD3v97+DdH8DQS8a6Mz7MBl4tbEbGXZbfueCYvDMZSKIy?=
 =?us-ascii?Q?3TNEL6uEje5M7x1lTavuVh9smf2lvvRJ+QP2z+GBCkyXZchDsozhr8ZVhzXh?=
 =?us-ascii?Q?aXqU7QcA4snUXGU58uc5mIs+/DrtIQiqL6CzE1vgSeNVK+tUDsV8T65eal0O?=
 =?us-ascii?Q?FU+CySUOITHQOZFuaR5mjgs8uU+ulpvJYajFGQgDzQchh0xofI9+f3c14D1c?=
 =?us-ascii?Q?EM7jG86CFFxNMjsnZbX5aIvfRH4oXEURTbOYajUQIeMa/OGq301Vymtaqux+?=
 =?us-ascii?Q?M2fyoD3lxUK9L9vR2B2xcGYmTHcpe4LPT19Hwh+ED15e5QMGSQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dnut0fdcXNXKYDk9DcBFiUDSXdB4Qc8yE3ApnDm+BiVOV1WkZ1SgeXVquCtv?=
 =?us-ascii?Q?yhqj5cp8zjb/yGr1vorKAaYdmdQuzakEtcLidxBGMk+Q22nLeqFoKW8f0idF?=
 =?us-ascii?Q?x54aNaDJTRPzTu6gORXEkdkoQIBbX4I4GPWxCzoi/CUBa+poE+QIKHWP5GSy?=
 =?us-ascii?Q?E+FE8oH8wEM6gn7p3rzHUbAd9Ovq++EZ0xTLpEM8gUjm5Yikws1HzSrYq56F?=
 =?us-ascii?Q?t/dO6m1cr6jGOSze/P3u3uuKuz/Lh/J3SAv6kqSVYG9wh+P9V6yeS5d1HvHD?=
 =?us-ascii?Q?IxEuuGZjo2v/s0VyqZ3AnnHnGXqB1PkxN9dZuhGEmwsiQJuDBsaihoH+UHpl?=
 =?us-ascii?Q?4KKCvsszdTyJrWX9N+C8vdZUVOvKEIGxXz9Lcn7vqhBtJEepzxy5degVxnIk?=
 =?us-ascii?Q?qS4mnJOja4FxynXOMXXhRklVUx7njR0e/n1KSZKuDcFHwtnMiWXuRnhiMlEU?=
 =?us-ascii?Q?urvashPHogqvd0SNm0PH4VU92us+L8UiZdyOKJX1KB5yOQmAmpmeMyuDWR43?=
 =?us-ascii?Q?vyEfB2RJfHEMspuC9le06xD71ELxPSwX1gyA54EtDqwPCmt/gV9CVCSAjRgG?=
 =?us-ascii?Q?dNMAFn3akDR8yxOIL8IEBdHULS3+gkvM7771GbhSUdbcZTEjvRxm/pbnFNuE?=
 =?us-ascii?Q?ofvyXw5TYNHNcVFFmrO5gq/eFReioo8eLUnKCN29M1JtXF4uQ0iCja8FO+dD?=
 =?us-ascii?Q?fHhShSWBSFDtkzGRrlMaJpbxhkUZyh4R7kiVt9tCJ45+hJ+hYuBQrHpzwwcL?=
 =?us-ascii?Q?JIKRaZT2BXqd8f2ZH7cIotA2C2QW1skhUsoMEXQ6HOn4beR7uBzLAw1/L94y?=
 =?us-ascii?Q?R6EO/GwP5SotV9QAyGvjqzCK9YKqqUbbCL3J6zCeW0akjX87Qa1WwB+xDFMo?=
 =?us-ascii?Q?o4R3ot4onINFl5PWhjSRtDuYThXXtQCY2hKZE26oMCG1Fpm4Zj6Siu9mAD+7?=
 =?us-ascii?Q?Z+v+RoMp8S5k0pyx5Bghc4/6yNZpy/DJqTjUevvx8WFbp07GZrlIPaKb4taZ?=
 =?us-ascii?Q?YXur6BDfVdP6Yb4FXEleWv9qlw7iyChwsDpJWVWMnDgdjKkRl4kPwt9z/K6b?=
 =?us-ascii?Q?/O+SLcto1g6YBOUwqNbG1fe5odKcFj8gt/FWEHLfvvhYEMJBKeO+b7x6gCmc?=
 =?us-ascii?Q?IVlqAbXtKcAOdpNiQLuTimeZlche1dDIID7nCP7nyoQDJ7aje/3QzlIPgneL?=
 =?us-ascii?Q?x1dzVg3FsVbzqiVK/vW0NhrcHG3lfvaYj7mndEp/REv0P5O/8UTla0d08f1K?=
 =?us-ascii?Q?cgr1BD0YoSHuU1C3fHflNe+oYWO+tJ8doRs2R6L5vVyKRzthnzUMrPflv4zz?=
 =?us-ascii?Q?naWyYND7B9y9LKB/Tmm0eTpSi/51oNj8Exdu872QtNXdr24bnavxgbkSJwCW?=
 =?us-ascii?Q?+0U0TTxrcmxrwsKvV5lXGi64xg/kNXKhPVRD2/kqFfxfr1Fl4qxqPj2OIzTi?=
 =?us-ascii?Q?xvR1T6ZoMXU9Tj7OjH4M1W0rXvBaa8BOod+uNGKfhZ9Yt46v4UzCmxoNn2fl?=
 =?us-ascii?Q?J5Mh0pd5b9N0MkHOF4eyoO8Gwtj3zdWUtPJyZPS4PO58f83BHZ8bh37lyhW+?=
 =?us-ascii?Q?z7GZOdMJJlvGpWANZBF5JfT+j8nw000k/1yQ3noEIKEkmgLElAMHS9ZoePss?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ddcdc62a-e22c-4712-d0b1-08dcd2671763
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 13:38:59.6810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgQzy1xl5D4wl0k2O+0CcnXCneJmpC/5ohCmYutg6gBpEjh5raX73pbSJccrtXHvzel9hPNCELyCHQRy3/udWIJkDzxAFQB9KYX2CFhx42A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8083
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

I'm trying to use dfu-util for bootstrapping an stm32mp board. It
mostly works fine, but something goes horribly wrong as soon as I make
use of the ability to run arbitrary u-boot shell commands. The shell
commands themselves work fine, but the heuristic "dfu_alt_info may
have changed, we have to reinit" seems to cause the board and/or my
host machine to go into some bad state, and further dfu-util commands
fail.

U-Boot already has a mechanism whereby C code can be told about
changes to specific environment variables. So instead of always doing
re-init, add a hook to the dfu_alt_info variable so that we only do
set dfu_reinit_needed if the commands actually did modify that
variable.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/dfu/dfu.c      | 16 ++++++++++++++++
 drivers/dfu/dfu_mmc.c  |  3 ++-
 include/dfu.h          |  1 +
 include/env_callback.h |  7 +++++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
index 540d48fab77..7a4d7ba2a7f 100644
--- a/drivers/dfu/dfu.c
+++ b/drivers/dfu/dfu.c
@@ -27,6 +27,21 @@ static unsigned long dfu_timeout = 0;
 #endif
 
 bool dfu_reinit_needed = false;
+bool dfu_alt_info_changed = false;
+
+static int on_dfu_alt_info(const char *name, const char *value, enum env_op op,
+			   int flags)
+{
+	switch (op) {
+	case env_op_create:
+	case env_op_overwrite:
+	case env_op_delete:
+		dfu_alt_info_changed = true;
+		break;
+	}
+	return 0;
+}
+U_BOOT_ENV_CALLBACK(dfu_alt_info, on_dfu_alt_info);
 
 /*
  * The purpose of the dfu_flush_callback() function is to
@@ -152,6 +167,7 @@ int dfu_init_env_entities(char *interface, char *devstr)
 	int ret = 0;
 
 	dfu_reinit_needed = false;
+	dfu_alt_info_changed = false;
 
 #ifdef CONFIG_SET_DFU_ALT_INFO
 	set_dfu_alt_info(interface, devstr);
diff --git a/drivers/dfu/dfu_mmc.c b/drivers/dfu/dfu_mmc.c
index 8f7ecfa8fc7..c19eb919388 100644
--- a/drivers/dfu/dfu_mmc.c
+++ b/drivers/dfu/dfu_mmc.c
@@ -232,7 +232,8 @@ int dfu_flush_medium_mmc(struct dfu_entity *dfu)
 		break;
 	case DFU_SCRIPT:
 		/* script may have changed the dfu_alt_info */
-		dfu_reinit_needed = true;
+		if (dfu_alt_info_changed)
+			dfu_reinit_needed = true;
 		break;
 	case DFU_RAW_ADDR:
 	case DFU_SKIP:
diff --git a/include/dfu.h b/include/dfu.h
index 6c5431b3948..e25588c33cb 100644
--- a/include/dfu.h
+++ b/include/dfu.h
@@ -517,6 +517,7 @@ static inline int dfu_fill_entity_virt(struct dfu_entity *dfu, char *devstr,
 #endif
 
 extern bool dfu_reinit_needed;
+extern bool dfu_alt_info_changed;
 
 #if CONFIG_IS_ENABLED(DFU_WRITE_ALT)
 /**
diff --git a/include/env_callback.h b/include/env_callback.h
index 8e500aaaf80..66cc8309e71 100644
--- a/include/env_callback.h
+++ b/include/env_callback.h
@@ -69,6 +69,12 @@
 #define BOOTSTD_CALLBACK
 #endif
 
+#ifdef CONFIG_DFU
+#define DFU_CALLBACK "dfu_alt_info:dfu_alt_info,"
+#else
+#define DFU_CALLBACK
+#endif
+
 /*
  * This list of callback bindings is static, but may be overridden by defining
  * a new association in the ".callbacks" environment variable.
@@ -79,6 +85,7 @@
 	NET_CALLBACKS \
 	NET6_CALLBACKS \
 	BOOTSTD_CALLBACK \
+	DFU_CALLBACK \
 	"loadaddr:loadaddr," \
 	SILENT_CALLBACK \
 	"stdin:console,stdout:console,stderr:console," \
-- 
2.46.0


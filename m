Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886B4D1CA19
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 03:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 780128914C;
	Tue,  5 Nov 2024 04:45:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8C1688F77; Tue,  5 Nov 2024 04:45:06 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2070c.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::70c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C62A88F83
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 04:45:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ik7bg4Pt5E4EHUQSPXegQZvRaHnDY1hGHz3hxs0D1vbWaihP7sJvK+6dydMynpqck+DWTXP5bxf8lxiDGuG0IXiq8V0iEZoXnbnKB6d6ym41DV5F5FwoRaDCFy9FEZ7ljizYOGEJ8z0juRpdCF3KMFhnIHiqTry/+i1Ft9ave4idyPebXi8j0JA1e0v5MitEkiNcktLyDi8vR+Xk7YAMpDQ2QP/o7AamSz2i3FlHLNvlHsxR7W18JBIUGi4fU0GsKi5am/v/jqLOC5ZBi2ZD74gvxg1sODG06FN8+OAkokX0wHzIRMH+Ji8vi+0DUT3eCOAn/FQJwYDX5Q4cyKDmDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbV396/FpjFr4A6ackDyBcrWDiBmV71Vr9mMQcVnyNM=;
 b=cHPcmB3TifHJqEBDFrCtnVgzxWH1Df6itXxSFvsjNCc0OzwXK4+EpveSzPIhrel1vFwwXFXhzwtup6gxtNFEy9DoNbIbwKSATfOhNZTUEwNCMh1fE7fIvB3XXuRHxj3zMv3xpSQtBSFZ3iD6Nd0Th6ETfnk/6kzj8CE9PJ9Jo3TdJmDs4JSe0j4BT7rHAXaz4HgbgPevj8Aubs5NS7ilKEWznSUNUT0hgK3n7TMzcx8zBcxrIayRezv6zTbdMrAjnL+5qnSyLTfZrPyWdvB44CqB1qnFiluRw7MxWocEzTMhgQpkDqScK9xczSoixCfzg/JqPEkKZZgY4b68cZdiag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1145.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 03:45:13 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 03:45:13 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v3 10/13] configs: visionfive2: Enable MULTI_DTB_FIT for
 JH7110 based board DT
Date: Tue,  5 Nov 2024 11:43:25 +0800
Message-ID: <20241105034328.56439-11-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241105034328.56439-1-hal.feng@starfivetech.com>
References: <20241105034328.56439-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1145:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd2c44b-ba3b-4504-2787-08dcfd4c4170
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|41320700013|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: A8RzLeMmuu32mp1vS2Ml9Uy2vIbvuU+MZDdgqRQUFyrglbQXt62iXvNKc55rNIO6ct3d/baJHixsXgQsLWKxV7Xom0X8tNgk7hwhRe5q0dUYxoNmEV4TFR8EUoNa4Zv/4xn1o4ognt7Vx0ZnHh4SOzmwDuiEDHgbb5Tb/PvAqBlnyDbQ+nEi94t8+qlOe4l37P0HnKIjrZekhmg8/ofWDx/wvMVf4DCMZBIWLXEZRMHLLOiJFu8yqQqCtA1AXBDb+Fd9KW1OgrUSbLzW3+xI6JprNZZCTeW+RH+yzUX39GJ9mHgsOQVr0rp9H6oYib0ut8LyiHMim5F3mW5RYZTRcSu/Th86WJHTOy8RRWg+mv6U4P4o7jd+98pZRg8bCQnZVj+/vgq1N8Pt6ai36xPRRWxO+Bjs6V4/Xae7s2DUksx+VgBpoWGDO9B45gcZaD8yUpnqltH44Z8F1V9RM+JTQSmXZuYbZsjGSyERZjVvxfnpz7mPwePthA0XhMnuKh2vEwD7Nq2nZLXsxboSK5StJRSvnkkyP32LasxZ/vkNsjJ1j2zjuR3XBdOp7dYg0d5igYvpeP7VXMkV2gPcU5EuwOWzQv/r+Bf/4oQGeKsid7SUeVsbqs/DjydKGDiWZixiJ1ViK5hc2fOZJ4/or6BiEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(41320700013)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FDku7Hh3RFxDYqhogxj6KLEQ1t6eJaK0YA+rmk362nazc7hYKS5ZIe3puboY?=
 =?us-ascii?Q?6yq+Q0YGuHu9bdQihiRoyZQ84RGdqUL4f1xdKS9QvDLde2RmLnoTbIevlpa2?=
 =?us-ascii?Q?QdPIBs+tzAinkdERolljQtjffOahZxepVN5rj5ppN8Ue+sbhslIVw/3stLPy?=
 =?us-ascii?Q?8tfcCJd516+IkKHRsxjs66y7el4rE3Faa74jUlljayM4kfYUbxA2qas2Ut7k?=
 =?us-ascii?Q?nvrTSgnmAUGFMZclxYXRFVrE5AuXGCJENFor/YBEgzQx95h+wATUOhvKoPEo?=
 =?us-ascii?Q?Op+oUW0AWCf8YbnOI7LBZz5/Am50y81KC27727UK3T9bhMqbWTMfTgm3fqoH?=
 =?us-ascii?Q?b3YuXEK1HJfM1OJdY4CIYSoWXcq/c7kcSnwVwTWzDOwddjfknl834eiKSoTG?=
 =?us-ascii?Q?IGWmL0A0aPkWVl6XLdfav8/Qm8Q5O4V0wc7OS/PnQ7f+ftUbHHtWF3/z1nju?=
 =?us-ascii?Q?JM3kDGOh6z6COIcibvHWdUBKJ71nYzHo9qJ4h2DJMNplx++izBa0glUtgVIs?=
 =?us-ascii?Q?VBdv/zs2FHB8eiwn0bGJfyQyLwgXF4TVR9uGpNN0Pc0Q1MZfcz7qPAHKjPGR?=
 =?us-ascii?Q?xhogCVQMoHlswczanIryuYfZ1eGVQg+29waU8ZfBY7svXKj270XrDnu8OGHC?=
 =?us-ascii?Q?wqeeVNbAtFDBlz6Cpx7JgRjX9LgeBbuGqYQ+XXMX76Sy2DDoWZsUFkaS50j2?=
 =?us-ascii?Q?ZHKkAokH2eWEIs6fNp5LGwyAOoKI0mCZTAQ6hhjmar7AY4Pf3i6bGh+H49Wl?=
 =?us-ascii?Q?xhtc9ApMC9LeKZecGlTP8g31SVNUhWbLG1iGew3MCseuXubujw7V55KWQJhW?=
 =?us-ascii?Q?vDzdt6u3vQwyUASVDHnFCQRzgDl9gyNaYmLvkSr3Ci8gAx/mNIbemZMnH6ka?=
 =?us-ascii?Q?F9f4my/h3861ebMgWtRzxKuL50iZsOWBx+Zke+R2OkCEN8JQ2fD1EIJB6axY?=
 =?us-ascii?Q?xOLdyAoVAH/s+9WvX9FwLIwMXxZBUFSJUllhiNlcWK1QlyNuHBMKwwVp3LcY?=
 =?us-ascii?Q?YVGmN6fgWaXeD+noV+sMaVqpQTqUqNCEgYt9mYzPtnwSg29tD44ejr7vCO+U?=
 =?us-ascii?Q?/ewX/6KfyJatWDWpCOBM+TFDKjE3OLf+SjRUpKXVgZBs3J6YS9sFBf92uG7O?=
 =?us-ascii?Q?+15dvIufAr1gGj7XEUGykn66bSBrNeRwpM0P/4+SYeBl6BbN0sYKd0fBRO62?=
 =?us-ascii?Q?TC8dXVYGMpPCAX9la2d+f6RYrpF1bFhow4UnWB4UP2es4uD2ENJ3EHxWHsS5?=
 =?us-ascii?Q?slNYqTWaCOk85qZzW/wTog41eV9DTEZMum1fjKwF59mbG/twUMSaQVN/cjIT?=
 =?us-ascii?Q?Vrym5FU3KBy2at8mGgaAKWtQD2IQSdIZGc8SWAdpZkAguZLZf6lmNUzZ39GN?=
 =?us-ascii?Q?K9oJ5YDB0Basmek+JbHocV7/mi+alcBzOsLTZ+V0n1Le18OonYLqd5DFpeI8?=
 =?us-ascii?Q?y2Ukmvy99YVvPndh6kTTWO9v2qLbEAg5G5h3yc8tmZ7M5TzTkz+DiVYUvOJF?=
 =?us-ascii?Q?CzTCaDarpjYQ8hFb9h3raMowSkv7DQky6UhoqveEcdvPy2K+9sLXthAoeqg/?=
 =?us-ascii?Q?UW+CZtaf7qQ1b+2CSL/968O/38r/2YoWT/PCkyt4qgI85SY1Y15Rk/TpsvIc?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd2c44b-ba3b-4504-2787-08dcfd4c4170
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 03:45:13.8359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJfOibLnZHG92TyEfEe85ycO7cTv5tAgFWlKXNmpCEMTaODM8swD4CsUPMZ28iqy+qyc8nWG77GtNt7I0BjkdnKR9gfL37wW4DHI+4jR5b4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1145
X-Mailman-Approved-At: Tue, 05 Nov 2024 04:45:33 +0100
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

So JH7110 based boards can select their own DT at runtime.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 configs/starfive_visionfive2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 5257e64a79..47b7122470 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -75,6 +75,8 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
+CONFIG_OF_LIST="starfive/jh7110-starfive-visionfive-2-v1.3b starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64"
+CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SECT_SIZE_AUTO=y
-- 
2.43.2


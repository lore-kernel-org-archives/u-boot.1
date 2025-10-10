Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16557CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:05:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E69D84314;
	Fri, 10 Oct 2025 14:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="O7Q9ha7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1439B83E92; Fri, 10 Oct 2025 14:04:46 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 349B984286
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 14:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3XwEl+Zu2p787fCtQjjoJA7ioXDCZ8Kl3vjfgNCh5O7N9zuB7jwpldffMOaCkaDHsxzwv9fusE59NGRvetaZlH3OXkdMiWsNG8RA/CYm8vXYBxhUV29R4VziT29qjfHTp4itbxu5zmyuaMYe/uhWknITpdfe/A+E3uA0/gvx7ONBO2Mr1hW+ae8LnGXbHkU4UGDTWFHF3q0tBDn40DM2/qIV8G/p0Gq0txPC3xfMwNPSe8lV7M7Z8V25z8DbKF3gzkzBtegF+PpwqpeED+UtYEuur6VfurE1fEgt9Clus71nEJavVpllAL6deXmOLM9Q0/JK+hJ3RGdL0u2ulnkXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbiImkL30R3AUdCxQBcwAjHGwA1aA/gdYk5NEp+x/Lo=;
 b=nZOWjMjAUneELXi3hoYUUzzLZ1NuB0c2XbtQcS+roJMuax/moTiaG1LySaW07vuoKXdCg9IZw2IU+W9rsaqGwJU94soovGYLK1YyMa8sE2AgD5FM//v+vd7geQY+DEb7k479lG+Vw4MWCmRdz895Lloxa07Y8NdRmjGWHQLxCwbOrcEmEpUWugUmnR1Pb6xEeZVjYDs7JMecAgUYn62Ho79ySJ2wspUyR+q+XcMFy+RbybtPTeWPudKn3erKzCwO29WqX2KQFUfY4FVkxOZ08CAGJ/ucuTS2a3cfY7/NE0Hyg0BX15cbd/k/kXxrv6VE+31QEc6mBYWXK1nqnCoE/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbiImkL30R3AUdCxQBcwAjHGwA1aA/gdYk5NEp+x/Lo=;
 b=O7Q9ha7CSCwC+uwTFbincHJ+qo2dP8aWKTkhCp+9Jp0sE8xPMpMJQ6RUyz9wze6m/BuGRno8f44AIhrNVHipXYpFCtr9oq8wY1v3nDNVytE+AebKOU6dNu+RJmety2dgpsvq38zAlSLI5utNsxlHEi2nxCx2IFHENDqg7q08RLjKJf2k96d80UycNnz8CnbGkGc9gg7mW/HrCKpjctnVlVNH4+af80Xv+NFmusjraftrlOnHK4Un0cEAHD3kQsWu3ynENUsdZWP41pajngWBcgyx9Zd1rfvcFwUnDu/c5Pt4upCwjmPOLOciGLLClJWAaBfNLCwQOad/zw2SLl2b/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6650.eurprd08.prod.outlook.com (2603:10a6:10:26d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 12:04:42 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 12:04:42 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 5/5] cmd: mtd: add benchmark option to the help
Date: Fri, 10 Oct 2025 15:04:28 +0300
Message-ID: <20251010120429.1532370-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010120429.1532370-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010120429.1532370-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13)
 To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 46da1834-2daa-45d9-a79f-08de07f5323e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZDF30tqI+7cvGIICzq0znatmz1zy8+iv5yHGyzXw1ezkrQ+UpMzikgH1ejgy?=
 =?us-ascii?Q?eNZ31bm+lZaJMsfRi16JmW/ygHgwQWXNn4tOA2UP1qsgUMy+X9YBwbM8s7Sb?=
 =?us-ascii?Q?NwqGun+DAp6/XUDQVlgAQNLP4O6PPjRpIAotOBobR0S3Nopi1AHQc5+XcxLu?=
 =?us-ascii?Q?SfdFVHVuxcpGWkjlQwS2WSPytG2cwk3GuGxeLhy7JOlB+UlIHB1xcI0OlW+3?=
 =?us-ascii?Q?IjgoAz+1At7sNce67nRRrpNMLK6jXF/tpEgK3MjlXcvv6kb0+jDx+wQKSG/b?=
 =?us-ascii?Q?ObmZUumh2CBAQ8+rgpV1VmQw8oGwy/zktZx9Taw5NqtVMQs2YrQTsQdbI1SU?=
 =?us-ascii?Q?DWdBYwRYopzP/yqyB3+6aZay6AlAO6nYkkoNy2BaLE6gij6e/7BMGHNVOSyV?=
 =?us-ascii?Q?HzV2XZ60TcLkS0uIdyiQZMsbxqk1bCiFFhMFJ/vTvcWLxFMWn5mV4ODhA9wv?=
 =?us-ascii?Q?OnPj2tYa45qyOq3ndUqeE59RthczqyDTLTu6UnvK9jvJMq5tZ53z0+lcESZL?=
 =?us-ascii?Q?eZpPMtKijn1Vd09Hoyb5PfomSbOv8aZ7DDYKa8LTcFCh/Rh9CkkWd+RvXLk8?=
 =?us-ascii?Q?dha21hrw3oHLNuK/nEpWprDftdm+i7q0sjAirF1xWlzECGyMLYJAu+YJhP5i?=
 =?us-ascii?Q?l4c8zX3PgxmjzTLye10rq4iQh2/pOyC4qMXp/Fo04maI4+m6MZOd9QvxxI11?=
 =?us-ascii?Q?YPIh52B+H2T0HxncRaZ+lLAqVFyXNo40bmnT2lKi4dANrtTxBOPH0ZFJ4sBx?=
 =?us-ascii?Q?CLg0Dowzuun1AQ5UkLZZnsqMRU1NC8FwjdrYMbUSiGpm+Ru83dl2jyQyYbjj?=
 =?us-ascii?Q?l5v0H4hIpNZCXRo7F8q/PGHeJxEjbsDktFJPiRXyv6XjRj1q1zNy3qt/mzMZ?=
 =?us-ascii?Q?L45Y6s2XHAd9RTH6J7AZUArtnVy5KzzJdAdsJzd3DW4ZglU0bT4xOIPIG6a6?=
 =?us-ascii?Q?CDLI4uvwrWQsBSziMou5UoudGjPGW5yLzGz8Xm0PhHGyY3qRf9uqgiW+3GjS?=
 =?us-ascii?Q?rgNgjYdmwsXIf7JfNI7Fc8UxBxDKkVzxhN1x3JUppPTJR1u/H/mqebgJClUM?=
 =?us-ascii?Q?RZ9hUL72wxYbxPldKD9x3j+EyQKTfT4eqVzVHzRE6ze8K/4BH5kO6M01MpYi?=
 =?us-ascii?Q?I5U9vPlSE/p7tnWjylsVDWS8J/hGYo67uwsgIaDeqEY67psXI+XS/VOQKvsy?=
 =?us-ascii?Q?fj9DrZa0BAzg4yA2u4NuMArPJRnoaBQsxoUouYLvgjBWrBKRij3IwsmFxPl/?=
 =?us-ascii?Q?Unv55R23DSu+C/JG26H0uoo+ROWfWkDCYPFtuUMjv11zJFMoNCrUn7Jtnh5d?=
 =?us-ascii?Q?P8uvWCbGCYVLYrjQQAt4DQQ3A7mHft1G9ghogdPhk8Y+cOqQixx8v0FNNdzt?=
 =?us-ascii?Q?h+U5rAf/fnCmh39Hcm+qjrBzf6NUaIw0T5Gr6z8SB6TFZ97Pntcjl7WxHw7W?=
 =?us-ascii?Q?kliM+D+MPfZbqHDwWXDID8k76yT7303Cm1T9Z/RFZPL7XH35MNglCpRc4Q6x?=
 =?us-ascii?Q?yZTFDkX4RG6Sg1bqqB60962718M0F2ou/jSb1IekbagJX93faXck7GB06A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fbxJTqQaZIiYbNGv4AJ9mBksuuKY+dIxOs+YHyOA08RN/hXDkF3UGi5k1Gpv?=
 =?us-ascii?Q?CffeJKFakXJzchV4KsImzpifPLlEZz/7gVlSAxwMenPm9aWn6U9jiPJyhsjO?=
 =?us-ascii?Q?hbo9xrUhmMvh/ddaQ7vb5s04BuV0aczuWY/S3r3D4567Ku1+aPPjsZQCZHK6?=
 =?us-ascii?Q?vXNB0HEnjve5DmOpsQk4RBvIHBhO4A6qJjv7EHSO6JYVMzHLZ3MrHDdHWY4K?=
 =?us-ascii?Q?oJO0QpCvnkv7wMTzv/N5hBYhyVP3t6tqKRMfxQdohufVYMn5pdwbEj2BjXMf?=
 =?us-ascii?Q?DWhLdaZGvqrWW5LZjR1utcG+uTzv1vo5POfmDbLlRCnnp0m90wdKiShCBga8?=
 =?us-ascii?Q?uOLvUb0hKY4rYZK2qc5fIoHZaKhR5TEY4hb6wEiraR8sYqN15a0ZH+rR2txr?=
 =?us-ascii?Q?HeEEfjj+mT/TsUwUM4U0ZozOqq+9tK0BaUXkg7LmiW12RGinP0+dYY4E0fWT?=
 =?us-ascii?Q?1pP8XoGrsTaT1Odfm8DoZ4tU7VMWvkUCzM1Lgj3BE4HvzQFj2GfNHCqFzWON?=
 =?us-ascii?Q?DRJGo7isK71uVsCteL9HSm1yAComF9NFtK6UArEFfPvUmmqna6FNVFzgAo1l?=
 =?us-ascii?Q?PqvwdtrblnvH2EdcpaB791MG2eXmkIcR8AJhUgLas9ZnH5YRmYptDz4BLeey?=
 =?us-ascii?Q?Pu5qYkwXFXNGA0mUVFSn20rKo9y1b3d3qWMvs6KJkTyxklQgMf0yKNzFTGXA?=
 =?us-ascii?Q?JifoCv1DybWi2k7aKRIBh+PrCJeHI/c0HkgYqsBUvgeT1L3ZRjqMb9ZMoV11?=
 =?us-ascii?Q?uJVUYeJFGzu0QWPOT9ViOGbeQ7+KfB4TAxULFPE5QvhbvA03MMmG9+dVNiiW?=
 =?us-ascii?Q?9C/iPvAecsVWCkLE2kG8UCQ/O6hk634XXdeIn1NnJei0tFz62U3r/VHog/sy?=
 =?us-ascii?Q?YxvqxOCUY9Ia+ymNLxoWqrACLuXqLbqCk9xWFE814C7quWvB8yw9MFhhqajq?=
 =?us-ascii?Q?PpGNjDyVsomrZZASUepsTI+pGuSgU0lYa0+KJ18+ajuyEbMaV1tbOZZJWdyF?=
 =?us-ascii?Q?tLcDusHzns2xvruek+nQf7RXZhe/wkKwbJXjeFhdLIWGiPvvKlsyh+mzhVzT?=
 =?us-ascii?Q?y2QaiL9k73rhEXvLWECc8WBGXqObguiKfW7PHPloZ+X+eHVxamqGp/0AahWk?=
 =?us-ascii?Q?nc4Gwo4NG5ZxGuskBBKhT+dFLBfKP5oeM1VELJF+7VBiNEoDkOKSy6aDEiCf?=
 =?us-ascii?Q?1PBI0v1MS/BIPcc4roBtdyFncTz6ilKWmKlPURDwCkhkpcp34bOe6vPy0uxp?=
 =?us-ascii?Q?Z5eEaAK30OH1Km5VzntqmNJFt0gWtHunl4OV6vmp8kSjTga3cxw3LC5KOFR2?=
 =?us-ascii?Q?fMtC402OnhDJMR4H+0ViP7GFBaoMuwTAR/wt6neOmJ3Ezx2Wn4ctF8psXt/O?=
 =?us-ascii?Q?xWrubVHsc4u76rCcc74aAttDwaUNaYuxZMU7ZqE8tma/Cifnsg6A5TCaGpn/?=
 =?us-ascii?Q?r5pPaLLTi8BgFMs4MwXgm6e1FYBB98jO2CkUuc1Xg2t5pwPNDR7gi0k/x55f?=
 =?us-ascii?Q?kQRbk2m9DRAIvVwmfusmghRHnRGnBRys/GAANHgLzT2fTBNG67y3XtIxteNK?=
 =?us-ascii?Q?hgVCFZSeOOBrKlo0WiX2oXb/bm0T4Ae+3Ff4ybCAE/0Sv5runlVY1cpowaKT?=
 =?us-ascii?Q?dlWfa4FrxY2NfwYxAGwECqI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 46da1834-2daa-45d9-a79f-08de07f5323e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 12:04:42.6763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQkCQNy2gnhzuh/uRlDUx0L/5U427YE/T3PrDGr67zM75RU1bs/sj1Lmpsu3OF9WJ+pY5WonIvdbKgE1J9pIee0kNQHK74nBdBGcvSNwqdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6650
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

The patch adds benchmark option to the help of mtd command. For the
'mtd write' case the help line exceed 80 characters. Ignore this issue
as modern terminals are capable to handle more characters.

The patch also formats other command to make sure all device names
starts on the same collumn.

Fixes: d246e70cf81d0 ("cmd: mtd: Enable speed benchmarking")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 cmd/mtd.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index e415a2d7f02..acd886da6da 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -1216,27 +1216,27 @@ static int mtd_name_complete(int argc, char *const argv[], char last_char,
 U_BOOT_LONGHELP(mtd,
 	"- generic operations on memory technology devices\n\n"
 	"mtd list\n"
-	"mtd read[.raw][.oob]                  <name> <addr> [<off> [<size>]]\n"
-	"mtd dump[.raw][.oob]                  <name>        [<off> [<size>]]\n"
-	"mtd write[.raw][.oob][.dontskipff]    <name> <addr> [<off> [<size>]]\n"
-	"mtd erase[.dontskipbad]               <name>        [<off> [<size>]]\n"
+	"mtd read[.raw][.oob][.benchmark]                <name> <addr> [<off> [<size>]]\n"
+	"mtd dump[.raw][.oob]                            <name>        [<off> [<size>]]\n"
+	"mtd write[.raw][.oob][.dontskipff][.benchmark]  <name> <addr> [<off> [<size>]]\n"
+	"mtd erase[.dontskipbad]                         <name>        [<off> [<size>]]\n"
 	"\n"
 	"Specific functions:\n"
-	"mtd bad                               <name>\n"
+	"mtd bad                                         <name>\n"
 #if CONFIG_IS_ENABLED(CMD_MTD_OTP)
-	"mtd otpread                           <name> [u|f] <off> <size>\n"
-	"mtd otpwrite                          <name> <off> <hex string>\n"
-	"mtd otplock                           <name> <off> <size>\n"
-	"mtd otpinfo                           <name> [u|f]\n"
+	"mtd otpread                                     <name> [u|f] <off> <size>\n"
+	"mtd otpwrite                                    <name> <off> <hex string>\n"
+	"mtd otplock                                     <name> <off> <size>\n"
+	"mtd otpinfo                                     <name> [u|f]\n"
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
-	"mtd markbad                           <name>         <off> [<off> ...]\n"
+	"mtd markbad                                     <name>         <off> [<off> ...]\n"
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
-	"mtd nand_write_test                   <name>        [<off> [<size>]]\n"
+	"mtd nand_write_test                             <name>        [<off> [<size>]]\n"
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_NAND_READ_TEST)
-	"mtd nand_read_test                    <name>\n"
+	"mtd nand_read_test                              <name>\n"
 #endif
 	"\n"
 	"With:\n"
-- 
2.51.0


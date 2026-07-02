Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E984C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 05:59:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E96A84C9F;
	Thu,  2 Jul 2026 07:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="w6fae+/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 838CF84C87; Thu,  2 Jul 2026 07:58:19 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A162F84C6D
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 07:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q26UrEd0kypBHmbzQQkFeu1XCK7fjAmIV6j0IUW3fF1zhq8qeuy6HrP224C6xool6ybCdFTKwkfyPqUwCDkxePEJlcE8s/8LkNrlN5WDEzaDs2Huy/4zxRkWAz5kB9UvHgRY6jMk2snwel4ObUgcohmBrk4SVUZqS2dvE/9ZeCqIotjKU1HWthgSAFjz/APFYCDIifbOviS08OdJPiKrE6s9nLnT3PHqckHSPJN3K/EuUzEi2gech7EyrQF5HLkSpP+TJ683ihoaou9I/j1xbs10f6/UcuFGT/m19xe1UbspbgYtKPR7j2kakVp7D5PuEE0wfJBPhZsaGVz3PpYf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiQ8wTpRuCqJYcYP3XFsnetl68f0w/LaKQFOxdJYwa8=;
 b=sbhm5dwRW1xLCHIUpi9LOde7dGcKYSSWpI3Oa9v3ML/gXpMlIhshPmQ5eYmkB6uL5fA9gCE2j+Z385htzyhTVcemm0REZTAMowIIen2P2DU36EDHxt6blJfrW0W8QTAL+FE21ijYDcTJ1ueYVTuUXy6a1J7s3+xq09o80+9kL2+RKJX4JKihT3UQpM6On47sFWlnHsLqtylRvA/Ap43ZQxvbB5LwaL+dR6o42PnB2hm7nXrLhf2XnrPve+wrDPM5Iv/P3R2BJN6m4eZ3At70lR9g+48cvkBo/6b5SHjwmlMbxT5NMRlZXYx9kotkyHyjqvhcwWCH+kX31KfRRtBHFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiQ8wTpRuCqJYcYP3XFsnetl68f0w/LaKQFOxdJYwa8=;
 b=w6fae+/W70lxIBfiroYPt27UHZIiSkwXMn3ZVKmckXlTASXv0gCVy1nl9xzxl0Nse+/JKTykQPJYgSRtRsUDdtz5WgvuS5NwH88JR6o4BweK5e1O0qIWMia8xTBrCKqphUQpoeRM+ItfRdakYagOPKTR622LR4ckMMGXppG6bX5+jtGHiLFpON42lO9uIQUB3YkQp4m6xX6tpVnwuo0XfIV4zZoxTyTMJ68sBPxdFBE8ViNKKi7nBOUu65KMau3F/Qe9MkYCK6m8VkuVD36kizOUTUGJ2eK7gy+BSl3V0RH1RpQXWn73ICG72lYAMRWDBcftB4aH0pC0C0T9rA8KqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB10433.eurprd08.prod.outlook.com (2603:10a6:10:52f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 05:58:12 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 05:58:12 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v14 07/18] mtd: nand: raw: sunxi: Convert to common field_{get,
 prep}() helpers
Date: Thu,  2 Jul 2026 08:57:33 +0300
Message-ID: <20260702055744.2164975-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBBPR08MB10433:EE_
X-MS-Office365-Filtering-Correlation-Id: 0973dab0-7ba9-4063-5018-08ded7fee6b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|23010399003|366016|921020|38350700014|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: xODMNaFI5BVjee6U2/jFiDud7kEnoCkWd/7N/eG0YMwaL1otv0yOkIJHw3yvyC0GZUOlpDYox07UOTQTzUKuocJqDWpzkTc4UxIDZ87ZB4PcNEagZmJ1wJrbzYDDGwwkPpy3oOLwjBt0Yo1P2cTu3kQ/nTOX0LlW98yvnkpOH+WWLMkd10cB14mw/Eluks8tPkgMpWxyqbZMv3SF0VgqeUYNkxbtk8Dv0JJO6CxbmZy44E9kBdmFiAnaqX4QcatXqAfFiH5y29+rCb4qxoL6j5VAxRXT01/uPfYvqiwhSHBiruVt7Idqjf5BUOMMBR01Hd8qqfUW9XdSih88nJZJ8EwouZ6qQ/C3gCISgWNfVdmZEkm6h/TzNb44G2JOXi8SHtbckTZwGqW3gM+SoxZ5NSW1SPBGk93xr/TFuu4cmS85J55/IesqvHJfNhnxE3MD898CPjmHm0az0F0FVuOdE7TwwyV9ueXO5TrXZIMcFP65HpNh8I7k/cTJ5OukbyMIE+mQtPEZKz45ZCXZMA6pslGxJwX0Je39isgRduZQ8nnxoF0bPI2Ch2hHWAMsUmtN8z41wJCh9VSkSLkWBw44GuXgfgC7MenTp5RYAq7za3gUvvKRysuqsWtc0/1ZoKcVWYaUKsys3m6pAQ4V92LB/CZKfWVP0A8h0WGz+EymJ0KEDse9bmGHdLbFskGCe5bLiaDlUci5+eEmlAx/2DTKDT20daxc/aXZAZ63odj0yncaj5FdhUf8SG5HUd3XZm8C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(23010399003)(366016)(921020)(38350700014)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2NjGzggm5ZWddQksV1RryDBUJwp9pyfv8oP0h5NHSbwJsOQpdmZjhR313Hed?=
 =?us-ascii?Q?ZeBeL3NQVUVJcQ2Qh8o3AQINsVN2Ux7DjztIBIgU2pdchzAlSigQuMi6dw9R?=
 =?us-ascii?Q?McnpYB23c4vEi9Q+xaFcUsgyhfj74lKx2OCaU6aHHgD372trKeFAx3qjqRhG?=
 =?us-ascii?Q?n/N3Bp3DilwOTBRqEULyBlel53DCK7UCo4y9Hk6jJ41in03dKgcdUgp0fmlJ?=
 =?us-ascii?Q?fGtRz8wKYe0/BxlMS8WEKNmNhXED3qxSi8MXyuHnQMQOEGTZC/76D+xePL6Q?=
 =?us-ascii?Q?DW5slukESd1IOuNy5WtLw2m5tsyT+TlSo9ZDpeSSxZPTk/g3QZG9+KkxKz+v?=
 =?us-ascii?Q?VQCMhc4VJ7Syqa90vUc4OzNBMnByzhLGasgBBc+9AGYevU69Viwn2NmCTTVp?=
 =?us-ascii?Q?F7aYO8F30RGjNTixRdwSnWf5ACp2EnJplHnhrl1W+3w2nicUkxLMubG3eNMg?=
 =?us-ascii?Q?+JqWIn8JrhxAWwPulEC6BOvJo4RNBWN6U8fDX7zM9z9oafqOzlE4zAH07mtr?=
 =?us-ascii?Q?56E5B5AEo0W/yYsdeAYN5xBZlYfRo9WIa6R31mgcIl/jb9eiLb7xPNvsFJ4c?=
 =?us-ascii?Q?FbUs26/IVZTx1U3/7WQILkcvOTgrZfNc4E9CFwUUSp+VMNx4tPzMfdNPOrNp?=
 =?us-ascii?Q?hmckjvBpoPSftpygSVnDBQrbpotuAMuRAXb/B2slAjK4W5Ed6GqBXnwJPaUo?=
 =?us-ascii?Q?2MXGiD3lCcEULI5k5K5lCKFoxUSpm02FKDJQyDM/1wRw9UNsxPhb7t2AszM5?=
 =?us-ascii?Q?7VB9DIs5E9cBatZ+Njt5xwkyxbJL5ruMwayzq5e44UDrPKhkEFrW5ThGdvyU?=
 =?us-ascii?Q?Nr9cU/5lGPfZu0ieZFLWQ94eqbOrdAB0osc7jwxTx7zh/LQKs2/AuLkjg6p0?=
 =?us-ascii?Q?CEi4eLg7xPDPuuEinn9ReInJLBrrJQZurGBXVjDYzVX7DcpBzRhsg0LIp5xb?=
 =?us-ascii?Q?FNeGLgP489N666oWZ+btEapkG86c32z+pGvaUFekRkMr6/ip0DFOy5gpMoxA?=
 =?us-ascii?Q?oOKrS7as6eGDB1Ube7Lk9oD3IZUsBsl6dujlyW3OwuGwZpEwJSvR86XImvRa?=
 =?us-ascii?Q?y4qZRa3qs6rbKRTllkRZcbBHaNT0nhaF4CS/ZvKSckzgq2VuZLn5Nu2tGZxC?=
 =?us-ascii?Q?vXrB77V5XP3tn8nYiK2H5dSCMUJYWRSAr7c5jQ7qQNiahnunu/TqnzftbehD?=
 =?us-ascii?Q?hCMyUivV5Q54esLBKbx3YX18WuvL7nfk8kd9bvcnSpdgH2Q5t4ZtLyl1qOHG?=
 =?us-ascii?Q?T0xX0IHi+Sf2+xqR/4uiyZy9A7Olo9Jcjy41jqp7jKj+wXcRUDVHcvTrbYbq?=
 =?us-ascii?Q?wB9BP5WgDXoZoZAFXPdPQg/rjPw2NjZUsbAp8OLpEI/m8BPD+oXyz1nhChCs?=
 =?us-ascii?Q?aD4SEAtWlFK7WTZmRqAIfYIi/8Qh1o/cuSqVEsZVdRFYrmmtQ4z4mDqXhwWs?=
 =?us-ascii?Q?sJ3LcfL3yk3uhCUJho644QQqBHHjwevsPhm8J53gTQaExMk8nMFpWDTNYTxW?=
 =?us-ascii?Q?GpqNts6LCsILpIaJ9eL00ZpecEeAHgx7v+FQ08YhvoKH2QdCr7qULK897liQ?=
 =?us-ascii?Q?+KFPX0H3d+H7gNKumbJpsVj20/rZRhuM5MI3vEwrm+TbzokI+oEQYEjAem6T?=
 =?us-ascii?Q?4M/rp7V1LIgnhrwqHTzraF3Rskvoft0GmrkVgPEPnmjofw9jI/VGnYsgXo15?=
 =?us-ascii?Q?WA1Te6KS174+sevBg9uuvrUnkZjn2LAgnMPxpVZspjBPHiX7kLcm/0y51JgK?=
 =?us-ascii?Q?V9RkmsNteBTaKvXznxXmG9SmpVCfjoM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0973dab0-7ba9-4063-5018-08ded7fee6b8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 05:58:12.8302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZcnP779IDLRN/zkAiiKGbjRzJhVrxVlQLBKNObsRVblpREdN3m0pBFL3FbXBY01C9DnWwkzUkU+EtBBNqVOTe+q/KIfbhLZWCI8t5exLJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10433
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

Drop the driver-specific field_get() and field_prep() macros, in favor
of the globally available variants from <linux/bitfield.h>.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/raw/sunxi_nand.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
index d7a8b3dd40c..1b2c514852d 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.h
+++ b/drivers/mtd/nand/raw/sunxi_nand.h
@@ -24,10 +24,7 @@
 #define SUNXI_NAND_H
 
 #include <linux/bitops.h>
-
-/* non compile-time field get/prep */
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
+#include <linux/bitfield.h>
 
 #define NFC_REG_CTL		0x0000
 #define NFC_REG_ST		0x0004
-- 
2.53.0


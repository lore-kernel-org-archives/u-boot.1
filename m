Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681FACEACEE
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 18:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81CE589287;
	Tue,  1 Oct 2024 20:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="R521fc2T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 454F8892B4; Tue,  1 Oct 2024 20:21:34 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20715.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::715])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D20089287
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 20:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLOriK7N23ZxP+bAIlLeg58J1BtmhvWSKiGghoTkGxlfUo+cBX0Jeixg93+DqOz2I3BgM4uJT8Zc8Y0VB7+UZuqDV69uYChjD2dFXsQI6W945l5KOCYzY8NZQ18Yb5pCGU0D5OqkzlqXMV6/59C1hJ9SGM94rQRdI9I2VC9rV0wpq/ZhbeB0i4UbTnx1tEklPLs1rjihX6b50Xj6L3PAZXVP1EbM8TAUQ/rlfEZ9eRTpNrq+8gZkCuzvWXpn5tWN7Gsp/K6LSQEApQ4MvA20V4QFM1lKL30Txk1/SyIbaftMO8/Habz5IsuivqD9fOS1PJ3PcWYLFgcRnO/aTzBv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgcqraEHqPyykh/wlZqUjRNabygkd8IJ0z5+wTHSEng=;
 b=eWezz67yotb78uq41rt9GuTTqzwaIB6rNQa3UxCI17UiIPXd06ebPL/TWbTKODrTFRm6BEOsb5QpM+cgo1sOIyPBXZ1Eq0NaJh0dITOZfrwErxxsL8iri4XH5tla27EVzpZAxYKuMF9L3w41FtaHsctbp9ETSVvYWkFH+kSzw4iWn/bx8aFk8e67b/BesT0fWFrZxGtk8It91qfVMkYvpWOH3gBfHhvC7E/D0KD99iYSpeSGl/4ys3JsP+nh11UomBjdX7zpj+IxfYwthFKUsg9852dLYzJGLm3rCS2RMmb0kEz+PY0R4mf+lXNNg9wd0UAcbuoODVedMopxPlmI3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgcqraEHqPyykh/wlZqUjRNabygkd8IJ0z5+wTHSEng=;
 b=R521fc2TRHWFwtDi+80sH/s24agyg6X2Rm2ZQ9YviZiMXRB2lGgfsG6N3E5QrLmyvb35tMmDnouO4FfnMdc3X1T3GbltxvSDxwoO/i/Z66DxZefj2P/jynv+cbboXEBM4qZ8GdC7PdMTjB7JaYz75VN9rT0HulIoKps371MdcuKWspVOsRKJWwD6PGokDkyC591dtFY0vK4QOCuq2hpYnyIO2Unl6+oCTuyYGla6jXaVQ73Eunl3dW8nfifpd86PAsEqMuwOZXksJI+XSuF5cB3ABMDJBCyrrP5c9N0bduB4zSPDqnpkqdb5xJB1O4U7EC5AnfpCRtu7r0kI9pZsMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9153.eurprd08.prod.outlook.com (2603:10a6:10:414::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Tue, 1 Oct
 2024 18:21:29 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 18:21:29 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v9 10/13] net/net: fix include ordering
Date: Tue,  1 Oct 2024 21:21:04 +0300
Message-ID: <20241001182107.907828-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001182107.907828-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241001182107.907828-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE7.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::311) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 924d6067-1817-49f1-9dbd-08dce245dea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/vBy53Ay/QkmhAuEZDVJ3FkcUoDV/odzfPLez9J4jQHAVqYgdvmcWn8o1ye8?=
 =?us-ascii?Q?7qQMYFsDZmejssObYZ0BaAZQI15B5DGbThQHfkFlBaEyqglmyM9SqnQ5lEMQ?=
 =?us-ascii?Q?SwBafIJuO9r4aSoSfrFJNKuuuDtN+xf68vdr+J2HyAExlfValrEoXXzA7XoM?=
 =?us-ascii?Q?ECEveZKZkQ6opUi+DWNtEbHdqecByap06YXDZJivv8M4UKqCiSid7qv794En?=
 =?us-ascii?Q?I0tkhlQu1bfgrcMQrmdT8cZ6o3FnJATpFSr0vcyzDMdYB+T8IlXTgfxeBtNb?=
 =?us-ascii?Q?AlO8LE+5LSG/TCFr+3pFxvTtzIDb+JF0uv4x5a9nswg3are/t7G1UaA4TMCV?=
 =?us-ascii?Q?V3NISJGe3/QWZqHRmifbz5UdLBcI7m2ex6b+guz/UuPNlAyGJuPEQewGsMZ4?=
 =?us-ascii?Q?HlFv6ltkjZ3SWIcc6ppdPbWibW3AV/889XqBG0CCnNx9YvjUUDyvemYnw26L?=
 =?us-ascii?Q?NqhKw0TtfHuYNuolICaJKd6aQUdDTlfScJn/Vg2NSTmMM9sXE5nwn2KZrMEy?=
 =?us-ascii?Q?DTSBk1+j48rngmaInTwBjl+jgE9H8XzRSfhMV1bZzsFByNMi69UlpSDAvNJm?=
 =?us-ascii?Q?mVM3Xso+TsHL2CtoCAAeFmdPOprIFhtYgaFrbmaTDpg7KjPKV/5rXfTswHGI?=
 =?us-ascii?Q?ppMReOYdfuEkU4rl7CS4n0CEQMCnEWvDkCEUrfy5KTUMgNysd0RICpzuJmdB?=
 =?us-ascii?Q?ECZMkL6zfD2I3lQhwogUf2HTE36BfsMPLmTxZOc1P4PI8RjxequAVswYvM6I?=
 =?us-ascii?Q?ucOaKIsWKsgQsf3kwXqRtu7W/8QA5MnrYTXnZ6IdkfJKnsWKsu4ZHTjmECoZ?=
 =?us-ascii?Q?P1plc2eHixMDxPq1i2/5i/LgQ80NdLEALUBkpORpnO3Y2x74DfrX4pJXTMx1?=
 =?us-ascii?Q?HP1qwmN/L65NdmuXeka/VAdYO4Cqr3VyvUMKF3M4j1qfBPPSGbFc4Ai/yvWb?=
 =?us-ascii?Q?tGJZ6FfxvJ2nsW50alLpBSDXTe0GNALIFr/iUIQlLQWBySAawvTAReKLlXIw?=
 =?us-ascii?Q?qNCcRb2c+4x4OaFWAcnati8S0GvWYv2NZuVN4h8+k3KlWiAKegg0zCLIKAar?=
 =?us-ascii?Q?0OEEppcA01mDI8cYIh/2ovghbUPF3P4t3cPmJhFmM5+SmPGW3SZvtgoaIiDB?=
 =?us-ascii?Q?LsPitRPe8cn5A1/E9nvcINehMizEZenqZmTChBh0nmqWFQj/WGFpUmtfjvIR?=
 =?us-ascii?Q?D8WWlLxFEknDtkQTFfey9IowwIqetVyL023FI0AuixopkOeJa15yVZNRnhU+?=
 =?us-ascii?Q?9BEd2/4asrPyhnE2BPtUP8fICqApIHVQAjncJkGfY/IozzhWizWGEKbCiits?=
 =?us-ascii?Q?oEZ3xin+T7tSCVJkR7X+CkE5xxubrC9Pr/hQm5/RmncP/D+ZL6yO4ib1riir?=
 =?us-ascii?Q?dt5iYy8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QDzUbBCDeim3Xlc01UNWhbxB9AgqYH9MLoJmFxyXf1tZo6Xg9dyzIVGcfpUM?=
 =?us-ascii?Q?yaggP6EK3PBm5Sufq6INlUVOZbyg1OBi0DspNj9fohsxEVZPbCn+J85QUw6U?=
 =?us-ascii?Q?cVzActOevuuwmGswUJOTGAlcWAQSozBxK7ZJptoUGHakfiAJtwyg5aIiuziL?=
 =?us-ascii?Q?dKAOAYAHYlKRhJdL9FZPY57kmrr9k3pNTF5iBoaa/OCkBX6a6qIyr20joGAl?=
 =?us-ascii?Q?oW9g5lpeSth4yyrpKrDQSFT+ggUR0FBKmCgM5bKCBuw5xOARcb7PG19CBpvO?=
 =?us-ascii?Q?hHlOx2SbG4DbIHY6IhwlNQ6CjkMm9zOEH+sC04BFxsg42FAPvaAbIdcIkMbC?=
 =?us-ascii?Q?wwArefkQOpcVu2Q6qGjVwPaSq7iz5FJ0IQBEHjyYgsX4RGuiwkHJ8tmsRmbO?=
 =?us-ascii?Q?lKfDS8DBnivzRcDxE32hptIA+ZHwGra9JrEZvSpBkJj9dgFdVG5p0eO2BYdd?=
 =?us-ascii?Q?MDLtYkI+g9gSnl2oY8dPiTtgWTh/uv46JORlRd7uxMCjt1SE6fV/hZV2djc+?=
 =?us-ascii?Q?Wijj+ecUYGB7YwUhpHM1ecdtfD02UB8k2hHS1MvQ1xqXCvocAUuJCPbZEAN1?=
 =?us-ascii?Q?kN2wYCr8pWNdI+KxlvK2AjsUO8HMS2WHl0yUir0KYZ6HMYDaDgMnUjHLbSPI?=
 =?us-ascii?Q?ojaFycIsi2x08MlyRYmoKc902Oq9lmnPU2TWAyopvTtytP+uh86PVzdccvkP?=
 =?us-ascii?Q?gPoPsRnKSdKSTNF8aEEp61d3z8bSjiIOUZO4wNLN/KnfBMcdxxa9fuBkTZ7a?=
 =?us-ascii?Q?rSK187V8GzC8QM3e//ZG09k2IIBmqt/XrK2BFEwkPLNGKow77aHckz2Mk4hI?=
 =?us-ascii?Q?VhJ85vya2QylXBdHWh6AvPI+n+r1hBQcYrso29pZEHZxo/6vxilGO3xPXRKp?=
 =?us-ascii?Q?0ZIMUF2bdCMEThwwyo0LdVsVFZWGco/dkfBHs9gT9Dgcv/CXfb7OVPgGvS23?=
 =?us-ascii?Q?GA7LT1R71TG392o04yNLtMIlcNWQBoyi443kyD4T98eqHi1RHQhAWY/sMOnb?=
 =?us-ascii?Q?Zux0Ut2Ql7bZExBJLVfkK2WxfMUeN1O4LZaH1N/EwoRaFJFPYToULQIGz7Pw?=
 =?us-ascii?Q?8UG0KC83jJkntU24xwnoPEuGWxMWnsV1BuMmgJTVifLMKp2Ymy4LEWOQoWbY?=
 =?us-ascii?Q?hIHw6jqSva+KO3rg50ZetlVrEj1n+ePwv5/+fqg+BDOorcgx/aIc1sQqV8/O?=
 =?us-ascii?Q?0yD4okFyRIWgEjvi8+NhjdSOHJC9F52f3+JgWQYeqWkZIdgW2yXdVoT+A0WD?=
 =?us-ascii?Q?Woovlw0IoVNVytqagObAvYw4eBpueWGLA5hjYQCFgZ1whDvTt1dRdjK+jopj?=
 =?us-ascii?Q?T2JZuM+iQdwoAOhIFPDfheHfs+f+Nmb68CcLYb1No7xJG5nn9pZ7tUHLsr/H?=
 =?us-ascii?Q?HJmII/Z+fae9SfIQsoctgJAcSlirWzgmqJnveX1l7wwvHhFXYSsto5ZXF0LB?=
 =?us-ascii?Q?eAUp9NXasMK7RmeisXuZSJTTyGsja8qcsDJC/qd65QSriZcHO3gD/1lSHYcG?=
 =?us-ascii?Q?dNj+ThJrKsZbk7bxBcFWabNHlIkAu6TupE1OoTbxFPSY5Uz8o/wjEBI/ZI3a?=
 =?us-ascii?Q?cWscI0wox41rNGH8qe49zNXxEiE1ri20h9YfM0XdfloE1gP2hghzWEvk5XX8?=
 =?us-ascii?Q?bwFRvlo6/rFzg1sJf7+R1Iw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 924d6067-1817-49f1-9dbd-08dce245dea4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:21:29.7047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpT13cNknI79YtqF3x/sihu1mRY/qXYKKCkB6HGdxWmGKT0OS3/yGAiV1EvlTWI5UIaGUF4c87REE5U/KxvMu7ibr3wWGb39gLl/dd/zhFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9153
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

fix include ordering to follow
  https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/net.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/net.c b/net/net.c
index 4b0b0061ba7..dde6009abd2 100644
--- a/net/net.c
+++ b/net/net.c
@@ -88,41 +88,43 @@
 #include <errno.h>
 #include <image.h>
 #include <log.h>
+#if defined(CONFIG_LED_STATUS)
+#include <miiphy.h>
+#endif
 #include <net.h>
 #include <net6.h>
 #include <ndisc.h>
+#if defined(CONFIG_LED_STATUS)
+#include <status_led.h>
+#endif
+#include <watchdog.h>
+#include <linux/compiler.h>
 #include <net/fastboot_udp.h>
 #include <net/fastboot_tcp.h>
-#include <net/tftp.h>
 #include <net/ncsi.h>
 #if defined(CONFIG_CMD_PCAP)
 #include <net/pcap.h>
 #endif
-#include <net/udp.h>
-#if defined(CONFIG_LED_STATUS)
-#include <miiphy.h>
-#include <status_led.h>
-#endif
-#include <watchdog.h>
-#include <linux/compiler.h>
-#include <test/test.h>
 #include <net/tcp.h>
+#include <net/tftp.h>
+#include <net/udp.h>
 #include <net/wget.h>
+#include <test/test.h>
 #include "arp.h"
 #include "bootp.h"
 #include "cdp.h"
+#include "dhcpv6.h"
 #if defined(CONFIG_CMD_DNS)
 #include "dns.h"
 #endif
 #include "link_local.h"
+#include "net_rand.h"
 #include "nfs.h"
 #include "ping.h"
 #include "rarp.h"
 #if defined(CONFIG_CMD_WOL)
 #include "wol.h"
 #endif
-#include "dhcpv6.h"
-#include "net_rand.h"
 
 /** BOOTP EXTENTIONS **/
 
-- 
2.45.2


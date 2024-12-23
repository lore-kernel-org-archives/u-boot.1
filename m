Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37996E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 11:00:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED42480737;
	Mon, 23 Dec 2024 11:59:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="a5VL7ynq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FFD88070B; Mon, 23 Dec 2024 11:59:20 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE7238069C
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 11:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQi0lcyHtowatSllCmFGuBgaZIn4bhMe6DnRlXuNzZgaqCImd4E9lFz5nvaDm/1ruSUlKDoXPcX4sncWMHLjozKKHB2ubB5y+N8Pd/zPgc0BeSU3jJxiIsraYN7TYlgJeyEcL+UOwk9VOuk9J7/ELXC7dIzziFEQ8k6OnJbK4mtJBJ8FrpEj0DOcUeiInL5ntyeyOzdqsEAvEXt+Sz0Q6e1Um7ekTJeHllng7ihMUlJsWurkeZ+104av/Ej8cZR8XGLrX6I2zGPxnzQC5KVPNo0K+xs3pTy1FpKmbuG/yUySVCvd0MjTdJ1R2JhOmW141X8XQ36C8d12PasjTauSZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+u8bdyboDepikG2SkgmMVwkfD7F1ouVTbYHyNOUCiE=;
 b=DeqSKDxkxvWGugvxQtW9Nu02AJ+7VVWx+hzTZ3z/TZ9bLuDH6g/i9b5lQryrblHrzS+XDgJ98fpuIDaHRDzlx2zBRlsEeRCzQTFoJJau2gwdguHu4Cj/w6u46S3aqWR4P5+FULsAgIJR3VyKAgGnQexaqWQ8m4bM9Nd0hNrQI5fOzkjYu8kMhNo7/KX3BR6ImkrkjRm+MbokcNtMx6coKGc501xvJUeA/yZVKuuePPh/xMFnQWdyZSuZCkYOZpJZqkCDnw5h7ub2vcqYqSfHdW5U253vPXL2HQ1ZbxfqivPvDCq1gXlLv/XVrvVZMv6nnyc5V2u4E4QYi5FFIkObjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+u8bdyboDepikG2SkgmMVwkfD7F1ouVTbYHyNOUCiE=;
 b=a5VL7ynq/yZXjPvjQmP0kFOzN86DXtaVhmeJky20OKXsbBuRqpNrm+I2SiSmwLUkh8i6n/VBYDIhC/V0R2LNUEc5RC+VFicUiR8JDFcMfFWhYjIlXku2arEDQlDp+qeZIpMlGvCGzgyC06RudDn3yDW6HrSmjbEu9M7TTfGAFebeznfYebWdoN/qHEqOVSLGLgNWaS3hLVB2tUvD5IruhKh91MuibZSmNLTcsrLGwzMJf576oBXOeSuJRAPuwpR7IKfzUckbaID1WMnwrdN6FPG9cmynLq4p8HvgL4mf4IBzeWvbbDGamQF+qDU+dBMu3zbSOLVzInoSzyzWf6ah8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6676.eurprd08.prod.outlook.com (2603:10a6:20b:2ff::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 10:59:13 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 10:59:13 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v15 10/11] net/tcp: define a fallback value for rcv_wnd size
Date: Mon, 23 Dec 2024 13:58:51 +0300
Message-ID: <20241223105852.1074404-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241223105852.1074404-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241223105852.1074404-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c44b88-1dfc-46a2-e084-08dd2340d5dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4rsCMiPXHXjgJ90zPHkKc7Yn+yBJQ6LpBig8JW+zgS0OX5AG7C46m2vsGFRD?=
 =?us-ascii?Q?B5IVlml0NahCpadQEmatml/jXBzNrx559RWOx0bvEFJb4iUj8QP/xc/1yzoJ?=
 =?us-ascii?Q?mYiXMkAUkgsztH8FireKw8NmQf26Ztj9YGAnORYRS4tr5AaorLq6s7VSdePZ?=
 =?us-ascii?Q?G//nBSEqCoO3rjaBo6iSNM+p6CF0arU9qb5xdV33xkEu3C926z2w+kbMVTxG?=
 =?us-ascii?Q?uQ5fI67b2PeQonIoN+9u4mDCA6/BbxA1n0KIkpqny9J15ujjax15rybhbGlc?=
 =?us-ascii?Q?4x8teHTR/5Vo5+deOQ5fgxwIit4w+8UBIBT4MYKIdh8eAChPo0mY5pe+irzd?=
 =?us-ascii?Q?MJXvt4mkvnU6+eGZ2Y16nK/fWLkN03cMHVvrXO8G7Jnd0BZ9V45BYtQOoH6x?=
 =?us-ascii?Q?yrFw35fUsictZwEmOD4ZGFkvgroEMU604Eln9li76duOMltZqpQEMwKf36tF?=
 =?us-ascii?Q?V/31MHAN2mS5Gi47H4V2pInl+yUijxTQjTqy0S1sAYuHD9oGW5Lr3QeQHFsC?=
 =?us-ascii?Q?nWOFZrO1XmbyPcM9L614ft2KzJZh1dVG7Q7JtUfTi8qE/6ZfIaldoIhB046x?=
 =?us-ascii?Q?WGzjZlHYwZ3VWG7JvFySugynlFszoqRxMQedDora1HyIWERRE/UwjD442AVB?=
 =?us-ascii?Q?yRGU41KDtlNOydOt94MaKVB+2wRdojZGkOq3OWPbgHupSr2zdE8d8XY9SkvW?=
 =?us-ascii?Q?UugowDMznxa88yvSZHgXGlAQfF/BRAGnXTjcX7C77XmdGt9SiRLBKHTKgQ2f?=
 =?us-ascii?Q?lx0G4GJOIhPBI18PMYm2VZGbEB8bA1e3awmLtawwPCI9GTBLV9QCuSw68hC4?=
 =?us-ascii?Q?yUWYxSHihYRUzshwpIgBIOo4fY3XPxN4CGafuQNIM2fJDd088WXvoWXr8SZg?=
 =?us-ascii?Q?5SFdGlr9JyGnkRA4EXSXwoSJN9wmpie0qsVqnfzXurTF9oaitZOKTi210cmh?=
 =?us-ascii?Q?VxoKLbwQ3VJ3qKqCdonxopq3llrkOSEHp/bifDwvm8euRIU76JnQTBo3pJLy?=
 =?us-ascii?Q?NAGXmKHMFMUb4y2eWvW+D/CgaQaEjn+MQzEmZU4UvTYRdp2iBhRgXfZjV/6m?=
 =?us-ascii?Q?SUvwuyZsEtUKev0Drxg5rs9dYOg7EsfaKXKvnWzSOvuv6S/NgARL/htrMFoV?=
 =?us-ascii?Q?2aF5CHql2lIKnnPsVu1fXkh382mBQcUJokAqpjfiVd9sMWWCt1VQgP2W4Xmv?=
 =?us-ascii?Q?PuydeUy7vSKpAz67yFUt307yt1kXurIoVw+JiolBOC5PeQM1QXGRuZ+f9v67?=
 =?us-ascii?Q?ZChRZ5PdaUIUi4pxtPEq8guaNPCm8k1TD1ZmbBN+nOLG14boD3PsjbFdGvPa?=
 =?us-ascii?Q?3epj0uJC0Vyet6qHRKjii2NmQLDs71yNAVkxfP9OIT+T+bH6qTUYzzMh65JI?=
 =?us-ascii?Q?Fg/PS9KnKRjWexVkBlXQFWlFMa35OxIcmhsT3tzJTxArVSoqZ8eL885iXGWz?=
 =?us-ascii?Q?sgWSeMeirE+O9XU0DivEReohv+74gdBEub+tVqyyVLD711CdsIVLmA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dh8Z4OHBo0P+teNEoZ2LAbu7axTFu7J9fqHCq6zjBvivi90N40VnTRfq36dT?=
 =?us-ascii?Q?fp9XOWDtj9eUd/LFprhk4+Y8vjFypdjW+keN21JKbZ9EFSknbJv6mIqAtmTZ?=
 =?us-ascii?Q?CpZOYeB0B3R96mo6feFTSlGUGH72X6LQ8vM1xbhhxCgZayiTIUnv2tE5eeUR?=
 =?us-ascii?Q?ioJNW66yM/t5O2oFH/nc5G0D3D6g8Dx6EGz0VdWSyNrGSBpsWLy31RYNpz08?=
 =?us-ascii?Q?q6pXO0OBTCawjL5SLNw71Ji2TYR7Cbl30m1B9eKfdrfsoPioeZBSZaZF+4fT?=
 =?us-ascii?Q?aCca3bRL6DyWSMpUBx8K4hgtmYJVuqXyfHBaeU09NTQzi8kB4xcSHkEQebzu?=
 =?us-ascii?Q?0Ckh7Ffz6N0WJR9YfQ2PHXo836i3kScF9fD2sVfb0dG9/xg9CHJ2KzDV5ypP?=
 =?us-ascii?Q?9pproj5tbs4KRlelzcFKRpo2xiiRFymtxoBUQamSKB9c4o/9VsJJz56FprN2?=
 =?us-ascii?Q?3HTVdmln94bG67wWfmo508xgdr4jnvqhUOfW8ktoqrp603j+gnsDE4XtHoO/?=
 =?us-ascii?Q?yfBwQFoJ4XGfoJLgDWBJJ0SlWLvUjvGZg7XKi2bLQOE0iKw2pmHe6/H+3DMq?=
 =?us-ascii?Q?j9MzYgzlhN/wNvgaj+Q+pAfuUzi/QBlIvpt0VYuqZNauO5GlO5iOu5ylapeI?=
 =?us-ascii?Q?OZTdeGpawLyeYo5mz/Yi61T2MTP73JwY4QEITUxF2bzG7+f8qwXy8lb32XqC?=
 =?us-ascii?Q?OJ8T8GqBeG6BNrKaHwDyBVWy/tXmUp5qSPcX4bMapaCf6ctgz6+zAJ6OwmC1?=
 =?us-ascii?Q?qq8y3lp+ws3z8IXm4ygLb/rR8ABjaHvWLkbnKNIWCQrpQEto6Tpm9Uf8Twrc?=
 =?us-ascii?Q?WkrKDCby1Xxy88FxRYKQjPIta1ZxKAlQBZ0udqJmTNXcrrEVT2unWlz4E49q?=
 =?us-ascii?Q?uyQ154Wwr9r/cdVOVMguxSJ1N63I1s0kyIxNs9xj3+O8YMt9U2OTXkMokeFm?=
 =?us-ascii?Q?T46XQecgqTUWybGGOMaCIYNlcNuQFPNXNJbP4KfNipgZQ1CfENq5o4XzM+H/?=
 =?us-ascii?Q?V8esY1+k/h9I7+EDcncpdEggkkjOeXGUdyp5tLEriWTK8hBzFiNx5hL1J2DG?=
 =?us-ascii?Q?7HPVlpNjRoGFxrUvCmdoKcNEOYW8kNlIFM3J+8WzzfqV+KxzwlLKPuBxnPB2?=
 =?us-ascii?Q?d5aBPKi6OqzbYkxsCbfieDpS34p2W+o/Oxp0mTLDlSH4VuYP6gTcQosf6uEQ?=
 =?us-ascii?Q?nEF80xO3G5CfQtl8RdQHVP5E2sUDBVJd+JS8K5P9hL/iVRcH30V8Dx7Ammbj?=
 =?us-ascii?Q?l1FVDmEE9JwVmlrNSoS7CJ6JHTyIv+3gXRvpvJjuwee1fETZOlpvBeWH5Rr4?=
 =?us-ascii?Q?hpu4jhDCW9xeolmi/jW4rcRyBhKlWGdkO8rZrwftB2MGRvUC2yqtyDXyqPi6?=
 =?us-ascii?Q?XjzmYaI8IbHvlVysPaa/30qZybnazj5FeU0M9G/JZGc0DO1rclw5MPitIACA?=
 =?us-ascii?Q?CBY++SyH/bKyc8DhIqyzInUKbwcD2qaoQoeICnucDnZbJNUugQkUtgo6kTL4?=
 =?us-ascii?Q?pgnQO7OVI2rJoVmYgv2jpLgpLoOXfIAgqeGZYUHD10SUp5avk8kVSI00/tsW?=
 =?us-ascii?Q?g1UGW3IKaPBHVGdZ4s/kundDeFrOP9vq1rVO3Ff1+WGtcyZYwLDG5hbaSbOh?=
 =?us-ascii?Q?OUZKvq87asjxFnMoYEksSGc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c44b88-1dfc-46a2-e084-08dd2340d5dc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 10:59:13.1010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xB+mt2DnoJUaCeh19uAPAyUPOsHSl4AiuMcn+BckiODXWrck6oIPXnsYESLcdztZ1e/IBH51smslvLyCW2ovVB+0EAlXMYZ0Oq1xOGcOcZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6676
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

Some driver implements it's own network packet pool, so PKTBUFSRX is zero.
This results in zero-size TCP receive window, so data transfer doesn't
work. Avoid it by setting a reasonable fallback value.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tcp.c b/net/tcp.c
index 2600f74b265..2635727f47d 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -36,7 +36,11 @@
 #define TCP_SEND_RETRY		3
 #define TCP_SEND_TIMEOUT	2000UL
 #define TCP_RX_INACTIVE_TIMEOUT	30000UL
-#define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#if PKTBUFSRX != 0
+  #define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#else
+  #define TCP_RCV_WND_SIZE	(4 * TCP_MSS)
+#endif
 
 #define TCP_PACKET_OK		0
 #define TCP_PACKET_DROP		1
-- 
2.45.2


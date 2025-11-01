Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EC3CCF9FE
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 00:45:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D60B183B7F;
	Sat,  1 Nov 2025 01:45:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="KQgFb7XK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE62583B4F; Sat,  1 Nov 2025 01:45:18 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAF6183B4A
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 01:45:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kki5w6kLdlQuNCkik7bFTrf7BSNzpSEzG4p4veamHAmaZ5Xr4FTNfv7OYnRmgGXCYo7XbP6ZfRzotwUffIkc4+2Hb9zhDcR3sn0PLauBdKuJvFG0p/e0lOhsqCv5j46Sp6HAYuSbRja+W987b6+H/NvNg/VovdgDBruTee1rMnr7kHyaB/5fzfif7cFbpM41P78KupEwN/LtkR+kFtv37rL9Wd2DOYMSb15Vm4djZYM2ZAKNSMQQo7FyjNg5KMvvERm2Awi6hZRYoZ4d3bUSOVIj0+6mJmFoK3/uljOOZ/S+GgWEu5VgCh/qRn5QHywPJm3JffJK1mBaN78ewJhTlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wn0adpxi0B7dEUr3bxLKhyaXzvOZmyswDGF+iC3yx4Y=;
 b=xCPUoi12bDcHek9JCiKPhTE1n3djO5ugQknE2RY1Be7RQAlEj42SPRZAh4USjlj/KkoCrPxPC/oY8+RVr75FOSE1ZQYwtY/7prfKkUIxfA07jTq+/Nii+kpgHYm7IJ1cU9T/h3udL2LNQZqRTLRoc22Xg0EZDexhLP32zsAr9PS8eObCwvLbuVXMW1U9ZExYRO3uYnT9difRjpmd6yiIXr+PhpRoFvJF2QEoBLD+0oQveHvhj8UJX2qzpR36aBQVqeMsAbfq0n1i1w4l4EZgPzl5IYOGMdU12qvaseJebUiOSVJa2wP7pCpbwOl2yhv/qFP2pbRCZxDxOELSWTvVSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wn0adpxi0B7dEUr3bxLKhyaXzvOZmyswDGF+iC3yx4Y=;
 b=KQgFb7XKwbBWVZ9vutf2DesYNKnkMzQztaAgX1Bp4n5LoOloJ0+7IPF/HAcHjv2foHYkDyxHbh8sidyAoNFR1/TXrZuDCb1EbR6asseADiSA3hol5gPXSeR0RWeoDtqxYy55LBTdiKlWypluW7DGyztH2dVp5GFY0dPys6frZcWDBMmpVQzYecKkAhICMkuYRu2U7i1WAfAJz7z01Tyqu7wDU90V+RxwH3Iylzuw2Odg7Rm66U6DZvMr3qbH+mWVebtDDpeyig5nHUOWkTNdPvwBC0RI3i/ef3TrC9xGtuF0uO53VU0+ByCCp/0t4NItyrvu7+OwwxHP1s0cXqIcjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9258.eurprd08.prod.outlook.com (2603:10a6:102:308::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:45:14 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 00:45:14 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 02/19] arm/airoha: add support for airoha en7523 SoC family
Date: Sat,  1 Nov 2025 03:44:46 +0300
Message-ID: <20251101004503.2379529-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: e7160774-174c-474c-015b-08de18dfeb8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?StjcNtPMQZBEg/2Jw5wKYdS46xW+2bYxeIo4l8y5Y+Xv1cKg0InrjkTgJyC7?=
 =?us-ascii?Q?M/YGKzxs0HAgc/go71X7STt68GvDWWE9tdEfvLcMQeMSakWbVBhEMqvzIoSV?=
 =?us-ascii?Q?cGCY0aTBPtlFiEIVeAdTXjejva9o08hfG4XWDTxlXV1nz/y1Op8a4Jdybj6n?=
 =?us-ascii?Q?hJiLvFSJ4xqb62zpfTxT59S9XLM6KfHG/uLPMqlmwB+VlC/ppfpZA0fy43ND?=
 =?us-ascii?Q?whoK8a0p2qGMyWluX/5rduMG2QN4jUDp6oCSBmHse8aqo/kNZ+Mq83bjli7S?=
 =?us-ascii?Q?HZLPL9Sa8QFEUtQjYk0Q6ephWNWpOj0JmqbDUencxX+tIaovyEczNRWlkiIo?=
 =?us-ascii?Q?mfeWhabK63Mb2dPouKQxwjv3JSJhE81enoZW02FH88d6W032YYFn4ZaQ/Zyb?=
 =?us-ascii?Q?Mc3FIJj9BI/JI9Uhg7Jqm5/jgIjAC1hLNaRMp9Y+B/N1S/9zm0jYzXU0dxNW?=
 =?us-ascii?Q?FVngQgpKJdIqTiHbQKeJb6m91ua0F3l8QJtDyMRGDfEh+Ss3rk1IreiAYlGo?=
 =?us-ascii?Q?8lzhfnnfgTQ5fRNzJFovJTt76/HuL/bluidVWtw03vwDwJr9+DH+nanJJ0Dn?=
 =?us-ascii?Q?BmFGINpggAT9uhfkzRCLTvC7iMnQWdSxklHN2+XXO9rAtg4YXriK44VYpA09?=
 =?us-ascii?Q?n8hQTYW98U0CzmFk7xR5WtUVZLpItKbDUA/xe3fFWXLc6z8cC4jjsa3pUhto?=
 =?us-ascii?Q?4hEvIB7wRagv5HkqdW6YrJE9qYzJcr5rYMhwCGi28Szsi8OWQ/7U6WXyxIsZ?=
 =?us-ascii?Q?ltauWq+G+Y6XhJZ0++yu2DbTCFSfw978xsY8ML+53ob0O/9HIsSgTOrlHUKI?=
 =?us-ascii?Q?mljahSmTm+ulf0sdvtcBcYZ1ohRlXSbPB78WarytX1ms6lLBlhyN8UuV7xgM?=
 =?us-ascii?Q?glzGrbBKm6oP7pzR9Te2gdl20jjTYTBwqZDrseFVh0vd8TfESFPcU58FqAlT?=
 =?us-ascii?Q?lUqti9dpOuWp5UskFWeTYY5pSPrr7mru85S8SVn9Uz2WUldZEaNxs/UF3KZD?=
 =?us-ascii?Q?rUHmVywUkHZnIXaQzBfDKspnrX47jdQDvWTWDIqOS/K4rYuh/OVmOScwT9Ex?=
 =?us-ascii?Q?HKt1EoYtcubhWLxoOt+e/vakq7pjaMimYpKZcWwqbijgbCz3FlPS0f+zvKxB?=
 =?us-ascii?Q?b4OfMB3sl8YUimtnqslcdhOu5YsDfcqzKg/OMbQ7iTM+368Ho+XUxIB8y8h4?=
 =?us-ascii?Q?dWGL+vvORrpsHV4mbptg70rPtSoBHhtWdS/cS96DZA7jZ3+8JlXI5O05NxM6?=
 =?us-ascii?Q?TcRWCstQr183AbWkmME8c6KKc6rOaBNX2JWeOMDIpF/kp0VDWrhNug4+xKG6?=
 =?us-ascii?Q?C4sjaoUiSPxe9Wvk7RKlt1OHuFsNQMOquS/Jzoj0p3wnHLygXvsEgUniO21q?=
 =?us-ascii?Q?KysvrOLM0GHesfKLoJMjPlhmfOpBPLj/QbR+ikyoxJkPCXJGjQlqIoYV2RVi?=
 =?us-ascii?Q?ODEaWUqqwHcyC2W11KIM+aDln87ebNT6ZRLAJNdRVmLRdfE40s/XlcX9vW/N?=
 =?us-ascii?Q?WbxXfiVHwoangrxoRJBmFWF3sOqV2LDAu8UE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zKUwL+k+u9kCXG3N8Sba3jHoUmDzLEI+qJdoQIzxNG03bootImxFUyebbPAP?=
 =?us-ascii?Q?iLXXPp+WS8Jy6X4tfi1WhdugWP6A7N2Cy6ggReC9xDE7xzaN9wbttxoNdj/V?=
 =?us-ascii?Q?HfBuVXp/D7p/mZQDg/CE6EWiFqnNdSxBdfrqyBuRu50TFkgCDAy4fbGjnJLV?=
 =?us-ascii?Q?YrYkpnx2iO1Wwkf6baYNhAZK8PmjLWD1IgXZ8v+mZQR2F4+1vrWQo7KTsBSU?=
 =?us-ascii?Q?9deyF7H6VwYUkjT1CCOYcGEA1/L2CX0hn5bjoVEymS4BVm9stpidb2z+j3LB?=
 =?us-ascii?Q?daoj0Up07PQuJ5MadTM/ipJzyF/npbKy/FxP74IEGZEA1EDzdDPzVEDPTjEG?=
 =?us-ascii?Q?g3VASaxLi+cNM61tTTXMuLyvYoWWU4hZroPQG9cL5ghz2Xb2CvCut6IEJDtW?=
 =?us-ascii?Q?h3sN2GBj8ztt2T3eX9ambyrIDrxVIFLpVH7aOiZm6VH0is1K9Je4ulKWGiF9?=
 =?us-ascii?Q?WRK1Ob2KuW7Vf9aUOMiAzhMAse7+IF9fjKlBbHtCK9MSazxhdoKHtEQa0Cge?=
 =?us-ascii?Q?pGl+hnV5WddVKhxF9tCOSRnO07fnI31x3PjB6tj5m/GjKhPGU09gBUFLel84?=
 =?us-ascii?Q?7NendEdcA9vh+jtrFlL2Sb36T6su/A308Z2REcE8x2YH4RHuYEiKZnga/6Hi?=
 =?us-ascii?Q?wjWBT1/pFJQqaqFD+oJNOMRYmNilVLZvRAqbJUmdP/MuVJYwE1PY/Doy7X3W?=
 =?us-ascii?Q?plyAvGvXqa8nKF7AsKXhZEhXgmDf3dBhPKhhdWCDA1+Hmis/b0kRflzojVgI?=
 =?us-ascii?Q?hUMShc0IgOdR8aKy8QIszVURIJC+NfSrnY0Sl5Js63F0pOB7o/eVGC5nwMj0?=
 =?us-ascii?Q?gyIp5CUYKHBf4QqnwfuX2U7hcuzZq0ELVM4Le1PZg8WcIe2TdETjsfdI2fz/?=
 =?us-ascii?Q?GPbs6EMp7UbnYBoAdyr+mXJS/Q8Hz/CPBkyUL0V9U2NEFwgdxLjEmxA1fMQy?=
 =?us-ascii?Q?FedZy4eaBChIiRQ1qnwzdovUCTci9zW0QdaNpvFw76fCb0IxQP1jzq5ZLUwu?=
 =?us-ascii?Q?WeDqm6NVBXkTUROCzwMY32l3ycD9a3VOTS+iQRmOOHzP4Xzlb4omjlrZNtfM?=
 =?us-ascii?Q?UE0FMzSTGpM+1rkdI3+4+GstKrbtMgdz7Patcf+V0euDQcinIDdQPwdyTGel?=
 =?us-ascii?Q?d8N8BU9grm2AyApnUonFeqAmODCYQYDCIQXs3xz8K7/+OMViowU3o40DyLAm?=
 =?us-ascii?Q?Fa06KFmbfTjBmMweUPxDebrDJrwY+9PSmGoAVmCr5JDJ8OEuSX8gbiqfgRlV?=
 =?us-ascii?Q?dG6pHo2gprZdCUaqyLvd98VYxGKF2WqmtbyyU48O5F8i3KoKx0Df2KeB9Xjf?=
 =?us-ascii?Q?KlXBxXxPzst2JnKtJokV2v4N7gIkW0EQo87HRPKaggl9OWFjulbu3hs83aMk?=
 =?us-ascii?Q?P7flBFLmwDreS/nF4SG3xHObb2InzehfsZOr5SR/NmuWp0O1wZesXWI2nZvg?=
 =?us-ascii?Q?ccGggqfFeahrrI9NHNI654XZbXkbjT49eTtSvxiiS4FRPqXqrOLlebLCHo1J?=
 =?us-ascii?Q?y7/lL3fGrc6ZkzyojbgWEGBayQbnN8U2iA5+LnjjNOzPQo6/vYyRPmmg4Z0n?=
 =?us-ascii?Q?GB84yPTp9Q+Pz9nhAdxKJ+aamMK8r5TrfQMqEnbdGbdgGmS29wC9cS5uV7ns?=
 =?us-ascii?Q?3KGtv+uapqipwTMEltV0izQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e7160774-174c-474c-015b-08de18dfeb8d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:45:14.3531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Qf8PqTeeyVDEJjYJEDoByYVl4/LsEG4gIlEXF5Q2UItXrFja9OcgIrj8YG4EEv6vNgr8xy502Yozod782XUJtb8Up8GvGE2mycIK8sANKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9258
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

Basic support for en7523/en7529/en7562 SoCs. Within a patch
only serial console will be supported.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/dts/en7523-evb-u-boot.dtsi  | 11 ++++++
 arch/arm/dts/en7523-u-boot.dtsi      | 26 +++++++++++++
 arch/arm/mach-airoha/Kconfig         | 14 +++++++
 arch/arm/mach-airoha/Makefile        |  1 +
 arch/arm/mach-airoha/en7523/Makefile |  3 ++
 arch/arm/mach-airoha/en7523/init.c   | 33 ++++++++++++++++
 board/airoha/en7523/Makefile         |  3 ++
 board/airoha/en7523/en7523_rfb.c     | 16 ++++++++
 configs/en7523_evb_defconfig         | 57 ++++++++++++++++++++++++++++
 include/configs/en7523.h             | 21 ++++++++++
 10 files changed, 185 insertions(+)
 create mode 100644 arch/arm/dts/en7523-evb-u-boot.dtsi
 create mode 100644 arch/arm/dts/en7523-u-boot.dtsi
 create mode 100644 arch/arm/mach-airoha/en7523/Makefile
 create mode 100644 arch/arm/mach-airoha/en7523/init.c
 create mode 100644 board/airoha/en7523/Makefile
 create mode 100644 board/airoha/en7523/en7523_rfb.c
 create mode 100644 configs/en7523_evb_defconfig
 create mode 100644 include/configs/en7523.h

diff --git a/arch/arm/dts/en7523-evb-u-boot.dtsi b/arch/arm/dts/en7523-evb-u-boot.dtsi
new file mode 100644
index 00000000000..c109d6794fb
--- /dev/null
+++ b/arch/arm/dts/en7523-evb-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/ {
+	/* When running as a first-stage bootloader this isn't filled in automatically */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>;
+	};
+};
+
+#include "en7523-u-boot.dtsi"
diff --git a/arch/arm/dts/en7523-u-boot.dtsi b/arch/arm/dts/en7523-u-boot.dtsi
new file mode 100644
index 00000000000..34fa8069f9e
--- /dev/null
+++ b/arch/arm/dts/en7523-u-boot.dtsi
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/ {
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		atf-reserved-memory@80000000 {
+			no-map;
+			reg = <0x80000000 0x40000>;
+		};
+	};
+
+	scu: system-controller@1fa20000 {
+		compatible = "airoha,en7523-scu";
+		reg = <0x1fa20000 0x400>,
+		      <0x1fb00000 0x1000>;
+		#clock-cells = <1>;
+	};
+
+};
+
+&uart1 {
+	bootph-all;
+};
diff --git a/arch/arm/mach-airoha/Kconfig b/arch/arm/mach-airoha/Kconfig
index be3562ae3ff..b9cd0a413e1 100644
--- a/arch/arm/mach-airoha/Kconfig
+++ b/arch/arm/mach-airoha/Kconfig
@@ -6,6 +6,17 @@ config SYS_VENDOR
 choice
 	prompt "Airoha board select"
 
+config TARGET_EN7523
+	bool "Airoha EN7523 SoC"
+	select CPU_V7A
+	select ARMV7_SET_CORTEX_SMPEN
+	help
+	  The Airoha EN7523 family (en7523/en7529/en7562) is an ARM-based
+	  SoCs with a dual-core CPU. It comes with Wi-Fi 5/6 support and
+	  connectivity to Ethernet PHY, DDR, PCIe, USB, UART and VoIP.
+	  With advanced hardware design, EN7523 provides high processing
+	  performance and low power consumption.
+
 config TARGET_AN7581
 	bool "Airoha AN7581 SoC"
 	select ARM64
@@ -20,12 +31,15 @@ config TARGET_AN7581
 endchoice
 
 config SYS_SOC
+	default "en7523" if TARGET_EN7523
 	default "an7581" if TARGET_AN7581
 
 config SYS_BOARD
+	default "en7523" if TARGET_EN7523
 	default "an7581" if TARGET_AN7581
 
 config SYS_CONFIG_NAME
+	default "en7523" if TARGET_EN7523
 	default "an7581" if TARGET_AN7581
 
 endif
diff --git a/arch/arm/mach-airoha/Makefile b/arch/arm/mach-airoha/Makefile
index 215a300373b..91395b8a850 100644
--- a/arch/arm/mach-airoha/Makefile
+++ b/arch/arm/mach-airoha/Makefile
@@ -2,4 +2,5 @@
 
 obj-y	+= cpu.o
 
+obj-$(CONFIG_TARGET_EN7523) += en7523/
 obj-$(CONFIG_TARGET_AN7581) += an7581/
diff --git a/arch/arm/mach-airoha/en7523/Makefile b/arch/arm/mach-airoha/en7523/Makefile
new file mode 100644
index 00000000000..886ab7e4eb9
--- /dev/null
+++ b/arch/arm/mach-airoha/en7523/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y += init.o
diff --git a/arch/arm/mach-airoha/en7523/init.c b/arch/arm/mach-airoha/en7523/init.c
new file mode 100644
index 00000000000..c1c1eeabdf5
--- /dev/null
+++ b/arch/arm/mach-airoha/en7523/init.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+#include <fdtdec.h>
+#include <init.h>
+#include <sysreset.h>
+#include <asm/system.h>
+#include <linux/io.h>
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   Airoha EN7523/EN7529/EN7562\n");
+	return 0;
+}
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
+
+void __noreturn reset_cpu(void)
+{
+	writel(0x80000000, 0x1FB00040);
+	while (1) {
+		/* loop forever */
+	}
+}
diff --git a/board/airoha/en7523/Makefile b/board/airoha/en7523/Makefile
new file mode 100644
index 00000000000..c6629486f21
--- /dev/null
+++ b/board/airoha/en7523/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y	+= en7523_rfb.o
diff --git a/board/airoha/en7523/en7523_rfb.c b/board/airoha/en7523/en7523_rfb.c
new file mode 100644
index 00000000000..aa73679d929
--- /dev/null
+++ b/board/airoha/en7523/en7523_rfb.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_init(void)
+{
+	/* address of boot parameters */
+	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
+
+	return 0;
+}
diff --git a/configs/en7523_evb_defconfig b/configs/en7523_evb_defconfig
new file mode 100644
index 00000000000..0730136b041
--- /dev/null
+++ b/configs/en7523_evb_defconfig
@@ -0,0 +1,57 @@
+CONFIG_ARM=y
+CONFIG_SYS_ARCH_TIMER=y
+CONFIG_ARCH_AIROHA=y
+CONFIG_TARGET_EN7523=y
+CONFIG_TEXT_BASE=0x81E00000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="airoha/en7523-evb"
+CONFIG_SYS_LOAD_ADDR=0x81800000
+CONFIG_BUILD_TARGET="u-boot.bin"
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=3
+CONFIG_DEFAULT_FDT_FILE="en7523-evb"
+CONFIG_SYS_PBSIZE=1049
+CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="U-Boot> "
+CONFIG_SYS_MAXARGS=8
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_BOOTMENU=y
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_XIMG is not set
+CONFIG_CMD_BIND=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MTD=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_PING=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_CMD_LOG=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+# CONFIG_ENV_IS_IN_MTD is not set
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_REGMAP=y
+CONFIG_DMA=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+# CONFIG_MMC is not set
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_RAM=y
+CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
+CONFIG_SHA512=y
diff --git a/include/configs/en7523.h b/include/configs/en7523.h
new file mode 100644
index 00000000000..2d27b3626ae
--- /dev/null
+++ b/include/configs/en7523.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Configuration for Airoha EN7523
+ *
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#ifndef __EN7523_H
+#define __EN7523_H
+
+#include <linux/sizes.h>
+
+#define CFG_SYS_UBOOT_BASE		CONFIG_TEXT_BASE
+
+#define CFG_SYS_INIT_RAM_ADDR           CONFIG_TEXT_BASE
+#define CFG_SYS_INIT_RAM_SIZE           SZ_2M
+
+/* DRAM */
+#define CFG_SYS_SDRAM_BASE		0x80000000
+
+#endif
-- 
2.51.0


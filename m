Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399DDC53200
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 09:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C5E283E96;
	Fri, 20 Feb 2026 10:15:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="Vp3zbYd4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3469A83E7F; Fri, 20 Feb 2026 10:15:34 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DC8783E96
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 10:15:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ze9XaxNQkqyxKk/j9FEEEFOgr+4MRxS8dGKj4LcffqWWfGHF5+/S2SRxcEhU53YQNFun+a82s02GtDx5xTSn34qJsXknE0lii+gZIoM5MYKoGlSTB0ExwY0vsPTf5g2e24ddCEIYD1hAc9V8rOoK7zxYs90B+kqwyFPeoxSX6xIWHjQH8KVua2bXxXfjChUHhp3+ytcsgYyuF9BBTqss971NeVUpmBbzJHDEXJQaMDol4d/woOdq8HKr5V/YVJqdz5f3c4nfIekmhX3toEaZ6t+w6K5zmn/ZQRdeKujtGTGa8HGHaY2HEa1iryWI96dvc045FgdOqRxbQZDDkMjGmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCUMWnFgRDij/FhFFtE3U9IqeNgArrbzm+Mp4QpWP7E=;
 b=aLKJlGC8vpeaDnfYvXrI2fmNLQL2LmelmNgOsdrtmU2kEX+92uXnbxMZDBTsLfwzljQuxTWcuIOaYwUYhahmPa49QwWPtQOqCvh2oB87rIgADV8NjH+RU0mg45iPdH2HTg3ddJSy41OUB62BNUgFu5gp10xWdVuqJ+iDVMje4h2iKPDyJ4c+17gKw6KW9WKBS/KkQcyS62n//OfUGGcCgHtZBPKcQw5k+aONaIzp16es2eaHnQz2+V9dfum1QQidnvCMLpjRr4majDgoNpymTZPq9nKHIZBGBJIjAjRnc+viF18YRl2hkCbrFV+49TfAFY7btYgY7BJdt+GAe1wfOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCUMWnFgRDij/FhFFtE3U9IqeNgArrbzm+Mp4QpWP7E=;
 b=Vp3zbYd4H3e/KxvJicnxqSyUCXtMP04MGWvEE2RXaZMyvIoP18Zx0c4LZP1kimfQtGh681EFWmejZ7qRsJPVmq72GsWTtNt72jH3bLZ6FcZt1Cffn/R22/ZSzlSWSpNrufj6bsnNFYoAqFsZVMlcbhad5ypg8ymtIWyOroBEVk6tfJoiLOMyHqb7HUbMPeZyVji6T7gPSy3cPYkbafBiE5Et53CuV1i9dIc9RbYfIq5N6IdOfwhZx7q8T4wcv+jF3Z0FHe4QsTg2zXqp6hKkGky0Y+wqhJxIa1SUmIiaJWu/ttm5R+SeaMULPT+HA85Fr3M95fHqCc25K+6M8Cjvlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by GV1PR03MB8544.eurprd03.prod.outlook.com (2603:10a6:150:9c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 09:15:28 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 09:15:28 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, ilias.apalodimas@linaro.org,
 trini@konsulko.com, simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v7 6/6] test: binman: Add test for pkcs11 signed capsule
Date: Fri, 20 Feb 2026 10:15:16 +0100
Message-ID: <20260220091518.180641-7-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260220091518.180641-1-Wojciech.Dubowik@mt.com>
References: <20260220091518.180641-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::17) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|GV1PR03MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 806d92d7-4881-474f-e0ac-08de70609708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|19092799006|376014|52116014|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T6bxNuB4wfoggwu+jLdpt3YA8yRCVhok0eyLJ/OXZwpaEDH7haAReqs5uhp/?=
 =?us-ascii?Q?avEir1J0KS7SFXKy4NaAuX/6ERGI0x6R6rcNrW3qTs08OmnJyli2TASUWQHd?=
 =?us-ascii?Q?qTQxPTmYo066sA5n4wKfZ4Cp8foz7qUP/Jx4KQ73bTJYYEVmZ83OzsUUgHcr?=
 =?us-ascii?Q?l0oppnZ0T+EoMNhFp0Gysh1rL1cTUHh1NsP4SLPl5CiSa+Jl2FlMPgC7bXTB?=
 =?us-ascii?Q?HVlIP0IfObRDcoS0jekhJUKQJHGgP1UqzaBeTmGVRoBoELU4ieiTqidSfLxk?=
 =?us-ascii?Q?2+mr9lVMLBN4EzNkSrYQlDNOti38AUXUBx/JemeWY+r28A/rioTQjLqM/H+J?=
 =?us-ascii?Q?f5CpddSDCrqM5p9z90fYievuOZ3fzAIDVaqR4r+dC1w55vJjhjBYt4zkF3py?=
 =?us-ascii?Q?hEhiLYLkEoQJDlnyyWBOxTU2XT7igH9Sh7CvFQPVVt+MuroEPwhc+9i8h02H?=
 =?us-ascii?Q?GxjNgtJf3K72V140rATPhtmzNmm+4XMNC1KuY/KLoVTB52zcb7NKYzP+nsLY?=
 =?us-ascii?Q?eRJkqHj7V3wx3akPqT1j0LSiHCfTIY+r/gJo2kkimEBDseOPIZ5D7B0UpD4W?=
 =?us-ascii?Q?vguRxGXYoaPO1WIELUMXQFDi3Zb59q3P0rEsC5gO6EDLuKgnMtSLtlJLbD7u?=
 =?us-ascii?Q?3Ka3753bgYJxlxfvFe+g1P2dQJwZ2JOd4cfRJkrIQx7bBygfYPijErelPzh0?=
 =?us-ascii?Q?2cpw0l4Mwws+xCacBtNgUXUgga9DNhT4vVt17sZ7P85FaJU7XZ7X7mnb1qTO?=
 =?us-ascii?Q?Bu4gwY7L7Mw5TFI8+S7mkLK9f5ZOc5/WU4z749l3h3egRjvvFRfxUORiQjDC?=
 =?us-ascii?Q?aTkZkmil0fhmZ8Ygm2DslbVVCXSlepDkSdNugPEBsaxhRq6wiNY6CSZlRG91?=
 =?us-ascii?Q?UENDNsNt58NHDuH6WrCd2LTL9mFvHB+MLdG3FrMZ/r5O08wcB72ELWexzo8c?=
 =?us-ascii?Q?qTRD+rm65spMtysmk5C1csM/8rP2au4yQ5/g6cdv1Pd6aP+ppFMDTNCA+Wc/?=
 =?us-ascii?Q?h9D3wZTZ61n1mjQkgeWy/zL8sQQMq7jeBWUYeVPdJwOKEC8lW/CDik/CWAgq?=
 =?us-ascii?Q?9U74a4V/OAXWQZARVcQnNYMChaOk2VSwmatl3Q1/y64ic65gR4Hc70xY5eAp?=
 =?us-ascii?Q?G/zaRLhnw1Ss96PpGL52MIIckRlc3fIQLpG7aZfyziDL9m32SdjKzK9WtmHW?=
 =?us-ascii?Q?fHMxtT82HhIroFWEXpArqvss4l2HfC0s+e7CzMTFlXmon6/VgqP5by2HvNRw?=
 =?us-ascii?Q?QKenIfLBdk3czjq/EUnRdHiGdS3rAcujGQU4r+m7NuJ6vfPIUID25Luj+M3j?=
 =?us-ascii?Q?mMCAYuYEftlyxl/Q7XEpw7JhjKeUtqN624+I0TYzY24ODLBYvjm3rCtDG8rN?=
 =?us-ascii?Q?4c5V7DVLEehFjuqxkObikmjiKAb0T+l71XXXq1QsL1DfaoqEzVwsXCpSfQEf?=
 =?us-ascii?Q?mQcvhGGXr+cTolgluVdA4YzoBl0Q+hv9fihO9jfsLZZCfhG/JlUORRyybfKX?=
 =?us-ascii?Q?42P2MjSsLHL5aaNqWKXy+kGTM5bF9ViUTvMRQU0p0MYrtpLyb/6+ayO9F2kF?=
 =?us-ascii?Q?YBjgHBgeQ/g7QYC2mFE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(19092799006)(376014)(52116014)(1800799024)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ouQjp61yR3goLngi+TinSf38d32lGy0aOza+lLKJ53h5qhHfd0d8RU3S6yeA?=
 =?us-ascii?Q?q2FkdR9buUP3sml8gDNo+YoiO/T8nKWBgEGw30S/C0qUlcaHcpfGzFP6obHh?=
 =?us-ascii?Q?v+tKW4cgoYXihxzif/4k5Fi5vs8WkoMK2P5HDXvKb7jteIGf6RGsdDgLk7IN?=
 =?us-ascii?Q?ZAwjhBtHEIjSg5dnMK8wA0weYVWEuVl4U+4DxXZDK2GB/FJGLlSoy+PLJ43S?=
 =?us-ascii?Q?YR0Un3fnBX5HAuMCKuv0QF5TA+81QP66SOQkDreAo4NpB606OOEv+iHtWM3f?=
 =?us-ascii?Q?lpE9WBk79lyxLhp3bZUOnU1WcWLV1qsJ1N31iYQbaWW7tY6sRkJ3x8z624cH?=
 =?us-ascii?Q?TO0I5MTxoiArquWZjW3vDE0Km/pyBzfSrhDEb3+fbbTWX+dDZIOJZqk4s+0t?=
 =?us-ascii?Q?9b5wxIspNXynC8wJ1438le+/rR64uHSX3mXMt9fImxUVvs0OiwgE3wx9m/a3?=
 =?us-ascii?Q?HN/IkHpx8zEuRFfHY4PPqwR2uvXb/eRURePGj9Vd7CJQPRcsLPC6IAOk96Ra?=
 =?us-ascii?Q?/gT8iRimOw5gYoScplWEpUtvUwVhZZY/YtI15iL1V+/rPZuhRSJSogKMg9ql?=
 =?us-ascii?Q?ju+4u9hi6OWyrsBYvLjrDPrVrvefLEDPS4qSojkjpnkK4Q8RO4vbSoNTxU+r?=
 =?us-ascii?Q?nSNb5DHYoHwqW0DSIW3HuhvO5FESsNtk8izxStt4LZ5hVibdw6tVotOmJcwb?=
 =?us-ascii?Q?20PZv8JVXaVJRuqIHKItHMxsWj2TFH75OaOiPTV8ooOCLqgJSv4h/D5x8o4V?=
 =?us-ascii?Q?ebCNY/5JcnWTSMMfp66yzePLRMyXRaXGMGeuhjQ7rPMkHNt2Qq029UgPOFP8?=
 =?us-ascii?Q?MAXndEmIfQMH9L6wx2m0UPUGkFwbnIcDp33jXmJ6ygJ1wGvdgud1d6kPt/tC?=
 =?us-ascii?Q?GeYZBswT9fdwZ1RvsfaP+5M3aO2FhG1WE6E1gbKio6IaG+UMfuzT2q3RBuT6?=
 =?us-ascii?Q?pFSOmE0wwgiveDNh1p2ehL708oirhlSA6TXmFun4JlBJ9m4qd5AjgXn5ScIn?=
 =?us-ascii?Q?14DWvwh2C5znJ56kQp83kBuDN/cLFiKqS63ejn9zSPhnasIuE0iSKJB/oT/S?=
 =?us-ascii?Q?rqbFfIHsdN4Z8WB9JdmCZyxLgMqXtmEUC9qoVst9ThjPFIDscLLl614zjOtT?=
 =?us-ascii?Q?oCEnNJOB5kxblXbENdpGv6FshcYRAboOOBLIP4zbLBxLI2zFpW0nNYUb9ugI?=
 =?us-ascii?Q?pYapHFHyOjeRMEeEAFVSmQs4XHt6dW1F1nqTgXTV3cXWAotrnRCNYJdEQHc6?=
 =?us-ascii?Q?OKgkmj3boW03xw30ArQ5qYa6Iy7z2KKcXIamYSbmoNVpinZVRh90rpSu+dCk?=
 =?us-ascii?Q?MTL5V9CM55cRo28phkrf+OxQVrt2iIWj3iYgOaI8u4ZH7O/j5hk+PEAFBYhV?=
 =?us-ascii?Q?UIe77ECWG+Hdv8ZHtmhVEzxqfXD/D4fBBAtNq6XT7J7GG+aMGnuQp+nDRUtT?=
 =?us-ascii?Q?0LiqAEAVo50qOE8+ewcWh7pp+QEcXTkRqlIJ4tDAcTQbT4S2VbbMYBfpHLPm?=
 =?us-ascii?Q?orUM8wYaqXnTs4v0VW2LTtaGFBYPgzE03/8dbnriMVwYLgUIztVOcRo9LURg?=
 =?us-ascii?Q?gluOW7PBaVnay9ewMFtektHQH19PFr+UNM5wplbwaf4Ubl3CjGicQTphqGVh?=
 =?us-ascii?Q?ZX6wr4dTou0niQzt7oox5HVAbFTsmRv9KeoA+Vov0VfE2a9KedFcbPDPNpIb?=
 =?us-ascii?Q?yey0GygzRgWz23DGg6jNksC0Q2wAH8jSLsjjm9I7WXN1GQlWOTDO5AtuMZXs?=
 =?us-ascii?Q?hT108+89CKqJGbxAk4Su083TocIwV5o4V3wb7Y5PKkMpF2p34+SAViky0cfJ?=
X-MS-Exchange-AntiSpam-MessageData-1: soESOt+Vxm6Qi1de1zsOf4oGQ4bPwM4FnLY=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806d92d7-4881-474f-e0ac-08de70609708
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 09:15:28.7217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yY2jvTS55oY3lHWfrsJKLWY1sppsn5iajzbrH9Y6/3mJsjPl9t61yJLHcH+7lnSjKInHDxxV/LsSS4RuFyJ7qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8544
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

Test pkcs11 URI support for UEFI capsule generation. Both
public certificate and private key are used over pkcs11
protocol.
Pkcs11-tool has been introduced as softhsm tool doesn't have
functionality to import certificates in commonly distributed
version (only in the latest).

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Reviewed-by: Simon Glass <simon.glass@canonical.com>
---
 tools/binman/btool/p11_kit.py                 | 21 ++++++
 tools/binman/btool/pkcs11_tool.py             | 21 ++++++
 tools/binman/ftest.py                         | 73 +++++++++++++++++++
 .../binman/test/351_capsule_signed_pkcs11.dts | 22 ++++++
 4 files changed, 137 insertions(+)
 create mode 100644 tools/binman/btool/p11_kit.py
 create mode 100644 tools/binman/btool/pkcs11_tool.py
 create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts

diff --git a/tools/binman/btool/p11_kit.py b/tools/binman/btool/p11_kit.py
new file mode 100644
index 000000000000..9d8d5d848b44
--- /dev/null
+++ b/tools/binman/btool/p11_kit.py
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright 2026 Mettler Toledo Technologies GmbH
+#
+"""Bintool implementation for p11-kit"""
+
+from binman import bintool
+
+
+class Bintoolp11_kit(bintool.Bintool):
+    """p11-kit -- support tool for pkcs#11 libraries"""
+    def __init__(self, name):
+        super().__init__('p11-kit',
+                         'Pkcs11 library modules tool',
+                         version_args='list modules')
+
+    def fetch(self, method):
+        """Install p11-kit via APT """
+        if method != bintool.FETCH_BIN:
+            return None
+
+        return self.apt_install('p11-kit')
diff --git a/tools/binman/btool/pkcs11_tool.py b/tools/binman/btool/pkcs11_tool.py
new file mode 100644
index 000000000000..673c0ea0ac35
--- /dev/null
+++ b/tools/binman/btool/pkcs11_tool.py
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright 2026 Mettler Toledo Technologies GmbH
+#
+"""Bintool implementation for pkcs11-tool"""
+
+from binman import bintool
+
+
+class Bintoolpkcs11_tool(bintool.Bintool):
+    """pkcs11-tool -- support tool for managing pkcs#11 tokens"""
+    def __init__(self, name):
+        super().__init__('pkcs11-tool',
+                         'PKCS #11 tokens managing tool',
+                         version_args='--show-info')
+
+    def fetch(self, method):
+        """Install opensc via APT """
+        if method != bintool.FETCH_BIN:
+            return None
+
+        return self.apt_install('opensc')
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a53e37f31b3e..d47364162188 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7,6 +7,7 @@
 #    python -m unittest func_test.TestFunctional.testHelp
 
 import collections
+import configparser
 import glob
 import gzip
 import hashlib
@@ -7532,6 +7533,78 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
         self._CheckCapsule(data, signed_capsule=True)
 
+    def testPkcs11SignedCapsuleGen(self):
+        """Test generation of EFI capsule (with PKCS11)"""
+        data = tools.read_file(self.TestFile("key.key"))
+        private_key = self._MakeInputFile("key.key", data)
+        data = tools.read_file(self.TestFile("key.pem"))
+        cert_file = self._MakeInputFile("key.crt", data)
+
+        softhsm2_util = bintool.Bintool.create('softhsm2_util')
+        self._CheckBintool(softhsm2_util)
+
+        pkcs11_tool = bintool.Bintool.create('pkcs11-tool')
+        self._CheckBintool(pkcs11_tool)
+
+        prefix = "testPkcs11SignedCapsuleGen."
+        # Configure SoftHSMv2
+        data = tools.read_file(self.TestFile('340_softhsm2.conf'))
+        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf', data)
+        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
+
+        with open(softhsm2_conf, 'a') as f:
+            f.write(f'directories.tokendir = {softhsm2_tokens_dir}\n')
+
+        # Find the path to softhsm2 library
+        p11_kit = bintool.Bintool.create('p11-kit')
+        self._CheckBintool(p11_kit)
+
+        p11_kit_config = configparser.ConfigParser()
+        out = tools.run('p11-kit', 'print-config')
+        p11_kit_config.read_string(out)
+        softhsm2_lib = p11_kit_config.get('softhsm2', 'module',
+                                           fallback=None)
+        self.assertIsNotNone(softhsm2_lib)
+
+        with unittest.mock.patch.dict('os.environ',
+                                      {'SOFTHSM2_CONF': softhsm2_conf,
+                                       'PKCS11_MODULE_PATH': softhsm2_lib}):
+                tools.run('softhsm2-util', '--init-token', '--free', '--label',
+                          'U-Boot token', '--pin', '1111', '--so-pin',
+                          '222222')
+                tools.run('pkcs11-tool', '--module', softhsm2_lib,
+                          '--write-object', cert_file, '--pin', '1111',
+                          '--type', 'cert', '--id', '999999', '--label',
+                          'test_cert', '--login')
+                tools.run('softhsm2-util', '--import', private_key, '--token',
+                          'U-Boot token', '--label', 'test_key', '--id', '999999',
+                          '--pin', '1111')
+                data = self._DoReadFile('351_capsule_signed_pkcs11.dts')
+
+        self._CheckCapsule(data, signed_capsule=True)
+
+        hdr = self._GetCapsuleHeaders(data)
+        monotonic_count = hdr['EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT']
+
+        # UEFI standard requires that signature is checked over payload followed
+        # by a monotonic count as little endian 64-bit integer.
+        sig_input = self._MakeInputFile("sig_input", EFI_CAPSULE_DATA)
+        with open(sig_input, 'ab') as f:
+            f.write(struct.pack('<Q', int(monotonic_count, 16)))
+
+        # Verify dumped capsule signature dumped by meficapsule during
+        # generation
+        openssl = bintool.Bintool.create('openssl')
+        self._CheckBintool(openssl)
+        openssl_args = ['smime', '-verify', '-inform', 'DER',
+                        '-in', tools.get_output_filename('capsule.efi-capsule.p7'),
+                        '-content', sig_input, '-CAfile', cert_file,
+                        '-no_check_time',
+                        '-out', tools.get_output_filename('decoded-capsule.bin')]
+        result = openssl.run_cmd_result(*openssl_args)
+        self.assertIsNotNone(result.stdout)
+        self.assertIn('Verification successful', result.stderr)
+
     def testCapsuleGenVersionSupport(self):
         """Test generation of EFI capsule with version support"""
         data = self._DoReadFile('313_capsule_version.dts')
diff --git a/tools/binman/test/351_capsule_signed_pkcs11.dts b/tools/binman/test/351_capsule_signed_pkcs11.dts
new file mode 100644
index 000000000000..bb87e18a15fe
--- /dev/null
+++ b/tools/binman/test/351_capsule_signed_pkcs11.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	binman {
+		efi-capsule {
+			image-index = <0x1>;
+			/* Image GUID for testing capsule update */
+			image-guid = "binman-test";
+			hardware-instance = <0x0>;
+			monotonic-count = <0x1>;
+			dump-signature;
+			private-key = "pkcs11:token=U-Boot%20token;object=test_key;type=private;pin-value=1111";
+			public-key-cert = "pkcs11:token=U-Boot%20token;object=test_cert;type=cert;pin-value=1111";
+
+			blob {
+				filename = "capsule_input.bin";
+			};
+		};
+	};
+};
-- 
2.47.3


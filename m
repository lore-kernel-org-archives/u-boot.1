Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD08D35687
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 08:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 073CC8427F;
	Wed, 28 Jan 2026 09:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="Ccg+K3yk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACE5783B87; Wed, 28 Jan 2026 09:05:35 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD124842BC
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 09:05:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUtbwrVQPDOLefCtnmfFdwHtRN0zfZw2slhA5ZWjMQgLyD5k9eHsH9ZIeFCmF8lJ0033iFBb/peN4tMq7kwsoFPUNAgqPLPbJ6hFSIh1rsi5W3EoRjk10cbNgqlUR1DVLJWzNXL2Z0DbeMvRvuQAWOlYgRNKzDEPJM1ngsaDFaqlm1hU/I0TuP2BS0SJRVZz1/+7PE6Ahg8i+jtfoBjfJ8KxjZINFSC1+y5N6NhyPoaZJdSGzEyDU/qG2Pvy9Y5f/rzc+wXXzEYpoMxoPa3sRQWuNA3MIOcjYZqS1NAB31YBRAJWvqrRcK7CylJGVUteWC2Ybzh1g0r/OjJOxqC37g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3s9IIgj318aBELyROAQ4gmwurodTETKA8I/OVjvWV+Y=;
 b=GQsrWOr+6m5lumCh1Zzt0MmO3XAtJgBf5fSl2Y4N9mR561HTPaKNGFzoil5B1+jDU9b/9AmKBZaS5u+F0xTwV8GEJmw8gpxRCA3cDLQKHNsHsKO5hTsNgAu01o5KStuw9dfIQLe9WDU4DE43RGNOkPVxQ/0bOE+8YziESOpsHdE5pxgvBF6inXDfCdRHarPLRDL2PreUPcVs/+tMwMZ4Nc22S2MRokdRWuUpRTiBVyXLOEzyuftDDpLaVd9ycHewI9VqbYrfBEkPir+qkdd57tKpoNDu5cJnVr4xPg6lx8HA6JUCdm/aIoJrU3GbagBxGmrJe07xttlelUL9uopq9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3s9IIgj318aBELyROAQ4gmwurodTETKA8I/OVjvWV+Y=;
 b=Ccg+K3ykpxh6Kr+5dLkr/NiT/IP55/0aVWzTdsoEBpkUMOwfit2ctTpnKXvJEnfDfKQ/+NLvrf/f3AL07F9Zhzqmcq65jCUk+aIegEvWAVxx/ymL7/jEu7VamGbQJsJjgB+pOSxVDx2VVBOhfwEjk+j4D4pN5kei3X2b3VIqvD8NEklMCgoCCqIKbqVIIE6Cr3fv7uEHOkRSQ96yABHzJ3hoCYPY2WPH+VbtW+mmrR3Ve2MLYVbqgETmBCt/t08eEwyEipOfUJWHyREOORoRz+cJljuBWKznDOvtVH6UDY22hmAYX/4TtSy8cdfflZ6EZcnsjESvasuSblu6ETY3SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by VI0PR03MB11456.eurprd03.prod.outlook.com (2603:10a6:800:321::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 28 Jan
 2026 08:05:31 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 08:05:31 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, trini@konsulko.com,
 simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v5 6/6] test: binman: Add test for pkcs11 signed capsule
Date: Wed, 28 Jan 2026 09:05:13 +0100
Message-ID: <20260128080515.1275941-7-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
References: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::18) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|VI0PR03MB11456:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f26104-007c-46b4-b0b7-08de5e4401d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014|7142099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DQSjkOPdEQi07cZm09fC4NxD9fneSp33lKPDwAl0iJ3GIJgbwizCugrz+HC9?=
 =?us-ascii?Q?OI2E33fZq6JaYO1lPOmw2+gEI0otrBdnj3GzzuZFXKstYyfipcz+sxgE4tDJ?=
 =?us-ascii?Q?fzCyTcOV+qCUtbrHJXIoshezl9BgzlZFODYgHiiMje0YQiFmtPn3isqbV3j2?=
 =?us-ascii?Q?HqNfUmdgOvJ9n5pZwDkdNXwesvWSNtFd5jpa0BUMRU0n5VrKxK/6SPtQZufU?=
 =?us-ascii?Q?FLrS/D8T/RLpsCtbmeKwtJmlv9Enll5YECH2rh0Aw69X8rj/37Hmg5OTjeWg?=
 =?us-ascii?Q?kse5C2yoXemTi03cdf9zTKJ6dbcdPTDUApDLVlg6c2HzVevQiSUtXIg0eI1U?=
 =?us-ascii?Q?Xb/NW4poQKWjCwp5LezqOOHni3/AWYprYfHP+qJ76LXmcfhyRo4X1ZHbZ89M?=
 =?us-ascii?Q?e6friMLYV/yWNL25H2BRp0EO5RTxv/Es9C7lTuYN2A3HBjt/F5n2QMH1uQXv?=
 =?us-ascii?Q?d1IJBhwAO33GbEcVOl+b2IfY0F/W9PO1SVuA0VX9ZY42AcVS24MZHMeonDXr?=
 =?us-ascii?Q?VaqcztiT/O+9aui2GJK811eGj+1KAJNT3NxrmtVV17v52qbEcCxNtp61XIdi?=
 =?us-ascii?Q?OuceGIQlSolGUfnI5/FXkqMD/Avxeu2djBkJeMRyBYD35LmbE1Tf0ep4brZ7?=
 =?us-ascii?Q?PE9O5y45tf5asqZEtHuIwwWw8kAHpMdY710SWwPWNoGqbWql8xkcXQvFO7IY?=
 =?us-ascii?Q?RMfaHaHPoZoxAFEy8wZX41mxYeYXcLnGNt/5sYkdd0rXJUZtExpzNEqA3ac4?=
 =?us-ascii?Q?fgHyn4gGy+cpkxTTCpS4hhSseTGxafPLjJgdeG1vRtlNVIfixIDaq4Vg3Mme?=
 =?us-ascii?Q?izt2+CHbyPRKWwG2tjWyFqtOCkG422YOsrUtNQ6sW9wNtxK7jH8O/XYWd12w?=
 =?us-ascii?Q?xUd1XzaoTUkS7PcfG8Otlz92j5o1BDVXRDkym4/qfkLFX8gbc/+WCoLRHPL+?=
 =?us-ascii?Q?rle2CKA6ekiLpDfkQT8ZkDHkQ8vA4iANG073O58PofBW6AbBTSBTVWHQSxNT?=
 =?us-ascii?Q?NUyKCsMhh6JgoqGLyHm/eQ/w/N3eRCDYsKYMHHJoa0/Je2w6mxjERuxJkC0N?=
 =?us-ascii?Q?ReQsZN19wUquX32XjzDU7TYAZdGE0LM2/PhlzmmHzYi4r6c9VJK6WgDV6T98?=
 =?us-ascii?Q?rDHDPxpi4aZZlw9oMDOhJ4nyjxUarTblC4Le1Xn23dQ/hc5NImhwhOQF6kvr?=
 =?us-ascii?Q?NT4RRmcQlVK8ngjwPaR1LAmLzBDOY49ZDGWYnNFzOE6rUJtzmRwb2D36eqho?=
 =?us-ascii?Q?lQRqVNpqUmxaSrhSXaDA1khkL3haKRiGSRfh3t/357+57A8yDJRlxxsX8y42?=
 =?us-ascii?Q?e5Kr9k7NbuSZn1Chk3ip4lytyq4wF4YDmeoVqbFT4gjU5v9xOwFsoEzVI4ZP?=
 =?us-ascii?Q?zlItgmjRVYfUErN9H2QqcDrglJMEZUBnJRukxKHWiFU5VwYv0FabE83q6/CS?=
 =?us-ascii?Q?hDEM8FzjZKLWvmerjRNKTpy2MP1B5HafPH9j9fK+T57Q0ZQlvJt6x1U7/O3+?=
 =?us-ascii?Q?EeaCCV9rXhODUG2sh9V8q5E0qyb7qVQ2tCR++GNL0T91S30aLyKaTzf2z4fc?=
 =?us-ascii?Q?o5IhBSSQekHRjQb53rAH3d4WDRI4xsIspYnQ5mEkPBZxgKQ6N70kHQOm+Erz?=
 =?us-ascii?Q?LlV35oaC+8QuhMputPs2oHA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qiyggeYWBa41r9XweCKzJunGDoFfZpcaiJNGy0utAeZqvBJwnCE8oBGHxMAT?=
 =?us-ascii?Q?KuXQ60HJdqPo2OmnHv6Z1qafAH8urGUkVkwndDRjfaoWLkcD0nPKBUYdaU+l?=
 =?us-ascii?Q?r2WHaZxVcJeiVzn4adFjm619zbltxq2cbCk6FSAgb3Imlk4s14wfoOTWXXk5?=
 =?us-ascii?Q?7/EWxFvD84yrZh8a/oyizve5LoNmFtkPKbEdt37THqTGynUdIhDbjNqrsY8y?=
 =?us-ascii?Q?477eTtqe0zzbvAipN4V7PSbLNlQVkU/EioEeD0CjSELgiopOppnqWCcrjZPd?=
 =?us-ascii?Q?+yfbodfaBB0/d+EfoN79O8hgUVCX6jqHERAGMNfLws+l8OMum2sebX7AgWLS?=
 =?us-ascii?Q?VyDVw28/rF6kzqo3/fsSYDxZUMnyx9+JNUauJ2NzaLiTiiBlJjeKadcI26op?=
 =?us-ascii?Q?wnfqtxNEo/gkhzNG7F6MddyAyUql7W4CQZiums9trWseajdIhN25inzM1uuu?=
 =?us-ascii?Q?JBopa1zI+Q3COAc2mRAjMpuV/VQ1UDNIwwSzPoAVL8TLBHdavVRiDWArmgx7?=
 =?us-ascii?Q?PCgBvVfYt9bOIAAHOIE5f1ItjdpPqDmPV7uJIVr9okbqAwL2VjdW2edBGLga?=
 =?us-ascii?Q?9UiqISGHJ1NE2iVFcO1sV5hupjWozii2Q2owqKjI0DSbjHC7PWxZJtCTfJfT?=
 =?us-ascii?Q?dHEip2Pa0iwSXkZWMTlfn2ldpvlh3IEogC1QjvFSeGBMfWVjZYxk/QNcDBpS?=
 =?us-ascii?Q?U5b3v2g5KwARfmT7oZvMRhy3jfd+Tocdxp5OZ73pUyX/u5l+ALo3dbN/Ioyg?=
 =?us-ascii?Q?qMC75S17aZjYpJqHhEaxwoG/mRe4OqLAr07PDwicdJ3LymiXpPQthdhcHXcA?=
 =?us-ascii?Q?K1299wt6MNc5nmkEtsk/9RgnYzu9+0EowyVXugO1GnxfOwBRJgeuFOIfq6HL?=
 =?us-ascii?Q?6eu6Uq10Ou9yeL3OFQ73yBmDz7M6y+lduoMU+Gw7cM7A/U/87lvXLU2t8/f5?=
 =?us-ascii?Q?uEB1lCeP/5JHXSNsZRzHe3+AiEvn/LB4icZ7gHmYNZpYgydDHmrGWbiPhBWl?=
 =?us-ascii?Q?cY9uTqWKlvMBpZuQ2Gh/aKTBb5xgfZzYc42eg1T8PZa6RzH+naPSxsygTdbC?=
 =?us-ascii?Q?cublIwzXRIiAKzUjim9zTqISCYL6qbjjZVg4QUF2Vk91AGhmJ0ATdTaeVFC3?=
 =?us-ascii?Q?JPpDo8e+HVmpKeEMn8kcuNjjM+wY/nsc6sM8bXIUB4D0MvQ/lGmO9c35PEZK?=
 =?us-ascii?Q?OG9T917o2AEIF3fdRG9s8B8CVWCJ0s8mVl4mpLecsFhDyYx7DUCdn4l+Monm?=
 =?us-ascii?Q?kv3Fl0SUjRuIGbXWG4q/C3gp8hMRON3QCHahlMn8FLFORkGcW2F9DEvRbhLK?=
 =?us-ascii?Q?h8vfUmU0bZ/by8Yp3ECiRYOQSM3AdjBqMDVkpnr4C+bhEbsqV3GlffE9ANuH?=
 =?us-ascii?Q?OCYpLLEDYc2bHu0BiVRC+m06aTJYWDzyXHARp6QXrqOP7DjGHUCZC/LC4QXC?=
 =?us-ascii?Q?t1czriNfPGm6CV6qCTuhhLEoVlSB49EnDwP/xaDHlohOR1wXhEOYgjZ+r2QZ?=
 =?us-ascii?Q?d36r7wc7nUNujm17MuuQiX+4hu0UY7DtEMr4Ll70VVdND2mpYWXs6zx7OJlw?=
 =?us-ascii?Q?WOtlcDUaGwoN42X4a1jxLXU9EWCIGzi4QXbwxbdswXQ3jtcR46VPngdBpoD4?=
 =?us-ascii?Q?+LbxFi9AsL+fkma7CuByrio+cwvr+T5Cae77eg9SqUCd5gFoNRydF9YeaIld?=
 =?us-ascii?Q?Yh7dv0bb+kipIdEVQCf8INpFvYLjBi0vsHA03n/7X5FzsTndLnEfqQbsJfR1?=
 =?us-ascii?Q?l+kbaC0VTQ=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f26104-007c-46b4-b0b7-08de5e4401d7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 08:05:31.5949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fK6kiCoAXi788JBnRyNEeFFsLbLOr+wJ2cdOo7mljzM/oOnmHnBeGVqfjpyXzYBJm8BKxHhlVA62Ne0toV8znA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB11456
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

Test pkcs11 URI support for UEFI capsule generation. For
simplicity only private key is defined in binman section
as softhsm tool doesn't support certificate import (yet).

Add bintool support for p11-kit as it's needed in the test
to find library path for softhsm2 module.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Reviewed-by: Simon Glass <simon.glass@canonical.com>
---
 tools/binman/btool/p11_kit.py                 | 21 ++++++
 tools/binman/ftest.py                         | 66 +++++++++++++++++++
 .../binman/test/351_capsule_signed_pkcs11.dts | 22 +++++++
 3 files changed, 109 insertions(+)
 create mode 100644 tools/binman/btool/p11_kit.py
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
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 21ec48d86fd1..a66030c7a56f 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7,6 +7,7 @@
 #    python -m unittest func_test.TestFunctional.testHelp
 
 import collections
+import configparser
 import glob
 import gzip
 import hashlib
@@ -7532,6 +7533,71 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
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
index 000000000000..ae93bf83936f
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
+			public-key-cert = "key.crt";
+
+			blob {
+				filename = "capsule_input.bin";
+			};
+		};
+	};
+};
-- 
2.47.3


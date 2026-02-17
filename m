Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F00E6816B
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 11:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8A9083E61;
	Tue, 17 Feb 2026 12:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="SP/S5wfE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92C6D83AA9; Tue, 17 Feb 2026 12:53:46 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 698C583CB5
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 12:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1tkf1oGrag1V3/42DUacfY3QJUbzDtofdDh5n8cri+RDuimRe+DVLtnp4tnhLr1btlMX2hcOEhZiGPbfjvqQiCQLa4Wrcv8FM5F8MbIZW8A7s66gxU7kPhdJo7CEbJg79vXJGkA5sdzzsYTWR8Xy2OpWBqNmp5Q91hD3D/OX8+jXg93HL5/++caebOLNPlDiulSbu9SM5pgCIhA0CyKOANZicQYqfXkF0FHADSV7JEARsZ2jBlZvdFLoA/mS8NPLqKWIKzl8iCBkwcUBCBluJUvltvK848/cY47P7ptzvw3D9IU20tMjLX4NGkxHthra/wBFqOJOEdontuVOd8Cpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELjAzkfGNKMpJ6Q1xzELEGeev9gXdQQ5ccwrxCZLpks=;
 b=q3Qcww0OM5fVXUU8urm3SyJlCP62HiLalCbpVBxZGQ/etCPli1SkBipstaiUQ1RQzXhaoq5rGn78PiiOMZRxXNKXpXyBnj2FKKMJKb2+XfVf9ENbhwQx75hohfdI0huEkI4lta2poKBdpUih0KhaARvN3UfCNAD71+xlkpHOADiR7bn8vnZgKMfts+NWtD7JlC4Ih0AUY2RhMoanxVFu6gI27uA1wPlYelasLwbagvfGU9gkhXs/fPKNenwA2VcakCjqIdW/qRK3fKvSP0aBZHoNwQvbo/VTlgtuENb2p1Piyd/luUFKJPARsH52c2Mhmp6qBI1xT0y/E0jO4ta0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELjAzkfGNKMpJ6Q1xzELEGeev9gXdQQ5ccwrxCZLpks=;
 b=SP/S5wfEgUNK7k5qzaKJ4Wa14QXvhykoBOtGB9JO176MQ7sNKpeieSF+mXRis6+/yWJwfngt09d9vDMSKszK1jj3qxCmBInjEbl7jDWlRe8M9L2QXhFPk3n03hDAxPZpDburvMbyCxJUasWVPzJ9clu0VO3QJibzwTStGzwdHKZASYWp3FVUWnTS0WjUbMgQ0DCJVjZqwTa59D1LGxvAkU38D5loWEx3LcDWmp763IX/O2Qjn0GE08vw6l58vcziPdEV0rG0tSbmC2KOIT8Bvoj82iGAMsx8mk7bcHmAJDc8+8kqEp5Ay6pvkBUt6LRAYkK+7jXf27OpWDuPp8OEEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by DBBPR03MB6761.eurprd03.prod.outlook.com (2603:10a6:10:1f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 11:53:43 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9611.012; Tue, 17 Feb 2026
 11:53:43 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, ilias.apalodimas@linaro.org,
 trini@konsulko.com, simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v6 6/6] test: binman: Add test for pkcs11 signed capsule
Date: Tue, 17 Feb 2026 12:53:32 +0100
Message-ID: <20260217115333.503359-7-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260217115333.503359-1-Wojciech.Dubowik@mt.com>
References: <20260217115333.503359-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0127.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::6) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|DBBPR03MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d45ded1-d0ad-4bdf-d3ce-08de6e1b32df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|19092799006|7142099003|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5vEqVu31Hms1CyxrnMqW1fXvEpyW3DEKSjH1Co3ZGmMM1MxvgDnlBHlaF0Z0?=
 =?us-ascii?Q?ldg6F9EEaryU5Y/6BwAv5l2DvZiTntIPzfDWTsY82FY/BotbgqByAgEIliTJ?=
 =?us-ascii?Q?+9D1mjKeNyQACwl2thVMjd9LvNID2W12F5EHXppGj9v97pEm5cM0RC5yNC2v?=
 =?us-ascii?Q?e+/96SBcS5P8wbarml/xKaKu01hXFtnX6hi7IykHad2p8wtpbdLyehzcUwEm?=
 =?us-ascii?Q?4xB7V1yhJZ0HdWRK2KkzukPYUDOJzcjLkACzpQCMPr3wKQxVELCeuG2mr/y8?=
 =?us-ascii?Q?KTTFCbbo5LfauaLcEeZ9bC4MllLTVpWv1Bpcs+k9hc7+sAPg5Ho5L6XWhqL4?=
 =?us-ascii?Q?rBupUPM6CrgK551RQIHH8mK/JnZP91L10bsEI7VZ9lOgchgqfw02plEgK1us?=
 =?us-ascii?Q?xbcP1+wWJhyohjnobJkQ+rlASnHTbQxpUDrgnNT1Zr5putxH/mGM+NsZaryM?=
 =?us-ascii?Q?sc026mUZ0/Em9DwBxc2/rfemUZ3eb3bOAG4kqqi8teoUlqq7CsenPQv+tuZU?=
 =?us-ascii?Q?bsr6J6hxnN6Mzp2DBI0FC7Va5E4MK1PFSnbA+GnYgHB0x/Ng6FpGLppryJmW?=
 =?us-ascii?Q?WHYQ0lvxrZKP9XMbBUOm4pmC/X/EHCBSiFRM0eNZrtTeUYlvZv+S/Y+eenHL?=
 =?us-ascii?Q?5QtaukiVvFkW3DKlW2sSQ7yZZ8rNDJSiA8W7Zx2euddP5MKIwwcBKv1HgIIo?=
 =?us-ascii?Q?DiVmQG1Bo0DCsnm6E8SIcg+1Ve4sl0LIS3ydqnX2M2Vkw++zgF+7qRAMgpqN?=
 =?us-ascii?Q?T6CG0lNuDbRkWMuDj0HZ/59snwQwGGVQunyiicfI1sFQUCDwZHoFwnMBl1Sn?=
 =?us-ascii?Q?fJzPD7I3mi+9Njzdt4soSVDbihPjaqoXSxXYkKltKHKcyaAOQL9cSwsTXqlq?=
 =?us-ascii?Q?/oTDP96r6tNDVmiWk0JcOSAqqZSpOZMdabPHz+zRaex1NWoxX5gsQ1c9Zleg?=
 =?us-ascii?Q?lpS2jcKvbKIf5Zd8nGA5WIdiHYrN1JhJtCa4yAOst1FPaK5YLJXoZcUoHFRH?=
 =?us-ascii?Q?sAOZjsxDwiEft0D4XAF9sVftprVPr3oearlTHB7EOEkHL/AMEP8URQn4CTO7?=
 =?us-ascii?Q?G13Vy9gTeLkl7K9oJlj5PSy89H3WCqgXxQNHQNxnsr3doDB8/tVfDSOI5Az6?=
 =?us-ascii?Q?kAmAGhP7G4JaMP24jEWgObM43UGY0WmMviCwT5e7vCM99ljyTZM6KsmvigeT?=
 =?us-ascii?Q?WzD/0bH2XcgcKtIr7Xoj8VkjUI5R+Sg0w2HdQzDArsNISNUcdwoYBrC3P/XH?=
 =?us-ascii?Q?62mafnTv4gux73Qpz5aXDQgRVEfe9gAOQizCUZXeKk5Mefyt94jNZnmuzUrF?=
 =?us-ascii?Q?t7uQQxyFKdY/nx+FpXY4FBxGKYc5trG2KVENLwhYWvLg8AhrkPEZTM96K9jd?=
 =?us-ascii?Q?qTAyHox62+PqDt91DWNTal/T61S9DC+9k+2r8+BqrUCTaZBtFgRl+Y7EQOIM?=
 =?us-ascii?Q?eq4Vfob6B277GZGuyMT45iS7SZfahbUZYeKsorj1P9EPPRxZfdDrvEHFZ4Ku?=
 =?us-ascii?Q?PyeH1/0r4SWUY6V4Ig14fMHQNiygJSLlalYwe7nz/a83CuFSmPU1HIkCO3yS?=
 =?us-ascii?Q?WpnJAE4TvdcT8s2rHElNOqJm4HJb5Vx4NSwWkjOU+KerIbOROUqi+opvkQXL?=
 =?us-ascii?Q?diVRO1DMtK+O4fZ0f5YrRxw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(19092799006)(7142099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?osI9K4ZtwtA8tcWkmTKQQ3pXbmh4w6iVrXCTbwvqnHh0bvPqXeRUkSYzRrFV?=
 =?us-ascii?Q?97zZD+t/cvTa/wK3v62aeCT6zVyb2e/TwaW4TebC1Q2rzqaSRmPwKZA4FhEq?=
 =?us-ascii?Q?Q3KidG/zhoxKVWaDfX+LO2v/GsvMVEOrSBs1Mcx8uU7aJE7MNKlxuJccjj0s?=
 =?us-ascii?Q?KcwdofnpfrR4LtP2Rec+diKqKK1Fll+Gxh3VxsT4/iwZD0yu+ELZJRJKPTE2?=
 =?us-ascii?Q?9qcMUbg8kR3LVQnZ8GWSL4IJdc0rD6xvsAEYW+Iztl1Phfn837Sd401qwV2Y?=
 =?us-ascii?Q?KJxvPjkzMLxYa2+NJcK2RskJq0hmRZh9Mjz3eP25Zj/M3Pv/X1lWIfmkay7n?=
 =?us-ascii?Q?4ZQ7p77yF1CliWdUkE+PzAaUdk8MW9nVhjeJ3isEDZKdTog2gJZ/ujXOMUlA?=
 =?us-ascii?Q?IXynGvRCQUAI/4FNneCcXW9xhB3LJejjtTweNPi7R1cmaxH//aEPhffJKP8l?=
 =?us-ascii?Q?ujd3BLYi3/d/yiMOeYRb9y0Wid0xnTbWqNOxl79tI/jWklUpoYl+gTQX1N5M?=
 =?us-ascii?Q?ChPy7GvmU3lWbHHKPhBi3uGRsGozLgqJHBZT8AC43taSMUpP/XwTwEg7oA6N?=
 =?us-ascii?Q?GdHbcdMPYByiFNCOY30NMSJPPO+VBo4wOdMsn+3zpwdfcVWC3kj2E5y2OAVb?=
 =?us-ascii?Q?/4DZDksbkdqOStW+5FHgKOn4aj3hOvFgV3kfOW5qNMbUAtd4ofOkLELGGpic?=
 =?us-ascii?Q?xBgEWdCkuacxc7ytgv2RrF8giuiRUSygbtRXMqbRt9x1U7yeN1YBK+gJZoVQ?=
 =?us-ascii?Q?eBkahWG6SpLr8ix4H6bt+jYWRgJ2yvRhyoUeBu+oSrTmwYmeUubvMESYmbwi?=
 =?us-ascii?Q?1ukfjal4UFIWQF2mcux8hC9sA1TwvHT7NBRlv+SH2qhcTa4JSJqWwpaubf5I?=
 =?us-ascii?Q?7G1cU+7IPIb3keqIQVo+9wQ8y+1RUFAYc4LYQQe2NHpY50IcRtXHe6HGSOTi?=
 =?us-ascii?Q?1B4czgO4bbnZxASVAOvfbSdku7vqCy2JaN5Oy2Blbwx2i0nfS00OJlVtwg34?=
 =?us-ascii?Q?I+2OQXEWzwyKgkM/EBYb5Mgqst6VN0dtXJkY3mcuY3COwdtBZQbH/+veqa2O?=
 =?us-ascii?Q?KnSOBzsVoD9sNTRfpfejecOlYDrZ8Vv+E40nd09j7G6GpwG2/YEPd6J72kyc?=
 =?us-ascii?Q?ukNst0vCzwc90nH3t2G2USwqB+s+JH0puMXlCllkYnarT0MSrCu46rDE29M/?=
 =?us-ascii?Q?SrR1fe5g9880To9b9AoEcI33j33DNV3Ks8eCIP7D0JaYgRPXlUM6GIfQb5fj?=
 =?us-ascii?Q?1BAEipR+b/ceEMPTZRvnBI6Yza0HQl/QI6b4faorjAt0uXsIawFQBVNB4cRN?=
 =?us-ascii?Q?6Zer6//nBGFH+AI/sWXpKO6IZkFskzA9JY8Uhq2vMW6jj5fAplAhBv8+frms?=
 =?us-ascii?Q?9gSZzc9J4BoEbgcGd8YMK8maYaCLPwlVcOg90AXq5hei6Yb3aknMM6gdPo9d?=
 =?us-ascii?Q?067V6UAX/3jeL5B4DJu2cAjIkr9kKUg/3ZFuhgNzF7NmlDF9CUsvgx2OXL3F?=
 =?us-ascii?Q?omvvrMVPEvXhS7dKreaVZLZ57uMbf9qi5z+jAMWbeQVU8BWyzHZQOC0oKtvO?=
 =?us-ascii?Q?n8dRUbQiuzYXlxeArC8IR/ZWT+DML6baPhNw33zRThDq2xpSJkUPbbpPqmk1?=
 =?us-ascii?Q?zGXHwsPlz+SpFDZx6BUrokrMWhILg6Kfl8O2oDFEti6G3WADbdbATSU9yZhZ?=
 =?us-ascii?Q?gx7By75rmURtULF5rC5MOTBOjQAhKI696mCosTiQ7eQoItZEgTtkj4KcRI0g?=
 =?us-ascii?Q?t1G3As66iA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d45ded1-d0ad-4bdf-d3ce-08de6e1b32df
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 11:53:43.1344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxHKX4Yoda47J3rHM3C+SVZJzoryyS0hGSCJ04SEEn9niB2tuxo5gPE7j2S7ChX0A32xULMNB+C95JMEzGTlFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6761
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
index a53e37f31b3e..eb08593b2241 100644
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


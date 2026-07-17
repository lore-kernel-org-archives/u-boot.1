Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D3EC4451C
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 13:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BAD084E6B;
	Fri, 17 Jul 2026 15:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="lhwSFjou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AB4E84E6B; Fri, 17 Jul 2026 15:58:52 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5343B84E83
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 15:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pr4rZaWhU0kamfVm7yI0nBKgQ7Kk4uMUE/caHGjaH5kEkhzjDhHnOx4U1I7ufUt8VoFV6CL3r/UkUJC/taOGU3i3pQbQDqkVe0xPQvxLRoWdBfmIPDH4rtj7rzMabP9ntBbPj6bg7Exx5XBXv2fKLFRNPKmADlmQqEwnrNuR81FuNzcci+aQO2CUNJ+5BpCl3w2PUy76/x1RaLqGLoapguDy2xzjesI2SmBUbSv67LUVPC/G1QxYG1v9Z5PYUNJOcfzy3j4q46SVY0gYHZN2bv+Z8DbZvMErLne3JJgzeixD9TGmoRDWbPIl0I0JTBBuPU+xwrnA0z93o2ziBgPyEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySf1EFgDa8s+e8lPks8ZrBaMJHPTxyqNSMn0RRqiNNI=;
 b=SD8fgrTdL1bUq05W6Awg67+iqK+WrqNX+zFh6JhIjap08YjDnblsAEgV34Prwb7etUrAMWY/U3jdYJNA3jYkkNPM9w/60yBmCL2g1YAqmefSrVdYwnOZEkfkLCwKRKvj8tVU0dyIBTYW1WjHlfn0R6F8DEkHxdPLGWorYKsoW26/JWIac3aaNXTcVoWOfEMCxsivpafHqPsLbxpnsZ5gqTfR425GWQKaCYPn2hoIz7BazrwlsjAcqfM9coJMwCGhIVvfALUBn4lnRMcxTV6ZAbUp4c95zQNEkyMjAvyTojVVqecIUB7n0XL+DS+AwdIC3gz1oyAzwxSSXyQE6Tf+MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySf1EFgDa8s+e8lPks8ZrBaMJHPTxyqNSMn0RRqiNNI=;
 b=lhwSFjouRMeMuzjkIjKFJ6KlyNGcIfGGlHzdUxE3LHKC/bMW29By30+cbb0cxh5EXmibgcZDMdfrLkd9R3sxQ5azyd3Q71fb40KtbPDEOkek5WAw2K7gQz8SGCb+s9xJoVLlEIpsmYXhLgA0/iVexgmJWXk1qq2ZDhZJo3xjeto=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS8PR10MB7426.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5aa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:58:47 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:58:47 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 7/7] doc: k3.rst: describe use of keyname and
 distinguished_name binman templates
Date: Fri, 17 Jul 2026 15:58:24 +0200
Message-ID: <20260717135824.2142135-8-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717135824.2142135-1-ravi@prevas.dk>
References: <20260717135824.2142135-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0079.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::22) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS8PR10MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 42272194-8f55-4a56-bdcb-08dee40b85f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: kqwpcPl4Wi7ZGaSTJ8m/r0yPjTYPsXaKn5yKxvRY1S0MuuXAbW+giakpWdClQZTiCZ4HpTV/dDjPY33oZiszlMAQU0Yafbb1q2LTlcSgoOpWdvPLUAvlknW0+1psUYUkb1qrYKdyjhERyeStKv4DHYXGmo/DDbZLAwM/A5sVO9lNcMxXsePgcWBYupuiQ+ykrkttdrm7JT2Qziymwyn9crndh22OAJlRv8rJ3yqUtWQdz/M+sGM0GEfXgSxMpJ0CaIDnECGTXpP41o4uOzOoT6NJNBItJKG4kMzqdtKibmQzlMlafqIFhym/T0ozr5se4blI7ODcxYRKkt4Bk+AVeaYjPXKj3aCZp1eWUEWZKdzNSbSDIiN0yZkRh9hr9VmXK3v3rYlI4mvsQD5DFEnKFHb2Vl0jxZuBrHE5havFsFRtI4XV6B1W1MfISecvL3QPkc4WDMsmDIMLQASv+PidY0wiV3iLW1MQS3xfBv+mpVJav7m3QGmj+79yqhBSR8+zcn/LTlkwRNOGxfMe2rx2Ko1TBp61e/kCe6jUpxobCs+CmpA5hLPe1HZjutNdYXpdhfItpuHcUNbiiusweO+qEnSbwVKH8mfWFGp2sesToYkD6pA4kIDQr9M14ZDajAkMGGra0sSrO3O/aItf3HwYJyfubRTlrR3lIq003vafXLc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vYWqjZ9j5ZBHqKbrDs9xBovU82a919wdJWa7jYNVStokGVWnXl9KpARhbrQ6?=
 =?us-ascii?Q?M2YQbfy/iFnYKJZEuBFsXWgjamg+iB2aC4rBtArP7G3rQJ4BBqgoCIqCJbBd?=
 =?us-ascii?Q?yf/W3ps4T0jvmYqd0cBF9pIjjQxWxrWB/Y+n9a5HLmCMOITVwySoOC/kQ2Zp?=
 =?us-ascii?Q?0Kmw5TQ6YTmRvC0KwRWO4Ma70I+KtxqZuqb0Hb0SPGciJ4UlXBqcGUo/BZVQ?=
 =?us-ascii?Q?zOQoRg87VFFb9wWbXOPfu7mCUT9C/AkdwykDkX1iJAslrb1PK28ZID4BLo2D?=
 =?us-ascii?Q?2esY5bDmv8OXEpT3P+3nqH/chgRzgc73P9Ngsr7k0pLgd4UVQxh9TwaLgGBG?=
 =?us-ascii?Q?RI2vQJwq0goJGxu3mggJdEN+sG00Jkb7DSmpxon9erWtjW6oGed8PC9dhJvx?=
 =?us-ascii?Q?WbPsY0qHZudJN6goBAz2OnFTgQlZOSO40rMjUM6e+U0aewvFsbFCnvjwrC0B?=
 =?us-ascii?Q?DMoSHs8DhypH7U5baVehCDh7qGGfIb6/HI9q+0uR8sJ9dArddYKyq/1P0YtO?=
 =?us-ascii?Q?33ELLPeJkbAkeum/cVxWvJ8iNTKwiKPTQFKjMe46bdY1D7M6c0p56X/X3RrT?=
 =?us-ascii?Q?8vViuW9lQNRMqrLYeWwi0UgWebw2MEoPZIZ52NDvXNV+rWU9JUjIoEAGBTGb?=
 =?us-ascii?Q?/bQOY4BcyG5MfTb/tsI5voc93lDfae82qFgB+8j6jvH812u1ps2WHgw7NWS8?=
 =?us-ascii?Q?zDGI3jpEDSnXjEEtI/4tsDgF9jTQ3sdZAEmlX1cFdTq+Iwhyzr6SkOpIHKaF?=
 =?us-ascii?Q?7BJn+6u4Qz/q2gc/h26K4GeaEpCvvubILU1ppiUe3Tl1E2DeFCXL2nrqwdBg?=
 =?us-ascii?Q?fJovL1hw0QUU33C01gZPyk5l0C2xcf6DF19H6a4qkFUuT5fwIXMwxL65eVw/?=
 =?us-ascii?Q?wudeolLSYUU3S+7uE5x/sMXbQmhbuzeOFQrKMNdt8w5/pt6OMaUPQoO4LJgf?=
 =?us-ascii?Q?Pmj7yj/ibrEj2YPvq38asK8Ksgtd0CrLQ3laVYvDTE4UleBYUk5w6XKeAGTi?=
 =?us-ascii?Q?1eqANW16ttKsUE6VWsoZqaTr6vRAQBS+00Qbxl1Da8wbO7pq08u1LzcqXzPU?=
 =?us-ascii?Q?Ni65EmKOZACIAylC+t5Pb2i3g35M+Rs7XC7/VGlXVMaApBSIRGvOpdMS2zdU?=
 =?us-ascii?Q?QznN69faZdNG8ukqf627PoV7Kzs0kwg7EfavOVWoG+ARqsL2TvPp9tnjodF7?=
 =?us-ascii?Q?OCqhDs66Rnlm+PNt5j2po/5Rsr1fG9dVhJ1nx1aXSlFGnR5J7QUbo3zkxit0?=
 =?us-ascii?Q?U0Ftikm9uDvHv6Sz6DveWm9Zxc98jZ8AOdgGRbxGCnDArochC8ydmonInLI1?=
 =?us-ascii?Q?5rj0MSox+ABLzZCDewrjLK7wm+SqoKJJR0SiezDBFY4c0gjth/lTKI0ieCwg?=
 =?us-ascii?Q?xTnSlXDygdActGldy8QJOBq3NlfITgLCiZiLiCirOvoidRJ/1vFMALHrfFIj?=
 =?us-ascii?Q?ivLcNuq8D455Iems+cMmL4DCY26oF0F58gQ7ehQesW4KqYlOPbxmlpPIT3Ro?=
 =?us-ascii?Q?g0hIcvM0QiA69OdkqmejtNweQkACAHe5GWMlZO7Hf8mrk9wVI81f9F64//iu?=
 =?us-ascii?Q?kBJtx40AA8Ki3cBrWKvW+hmGazhT1DEtmX66aUrd1o0nUH/gVgfh/rAo47Qj?=
 =?us-ascii?Q?1XHFM7v+ZIjpdrqJnEEC57v6Nw3Vgc/ecLHGpO5qeJgpOMjIxfbVF8M60yL6?=
 =?us-ascii?Q?2LCwyafYss32RquLc8+HW869soFEDITsREXnDsNlwGzsYsuID0quoLg0fxHu?=
 =?us-ascii?Q?fnGyqNMweLiY9a2bPrh5hfRBECqz9jQ=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 42272194-8f55-4a56-bdcb-08dee40b85f7
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:58:47.7417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGPYnx/ewpUlxWGtiDG2dXtQeXXe1kBG5e+BTHPs6Wu/aK1B/Vi3JYZDrbIDPJzrvfGQ7c5cQMbfcKgYjkepb75o9w7gedE7Xi7ShE8M2jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7426
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

Document how one can use the keyname_template to specify one's own key
in a single place, and similarly document the use of the
distinguished_name_template.

Also mention the ability to use a pkcs#11 uri as "keyfile", and that
it requires one to provide a suitable openssl configuration file (via
the OPENSSL_CONF environment variable). Details on how to write such a
file for one's specific provider is out of scope for this document.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 doc/board/ti/k3.rst | 48 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 21973d53b15..a2c8589e8c9 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -127,6 +127,54 @@ function as in HS-SE, but as there are no customer keys to verify the
 signatures against, the authentication will pass for certificates signed
 with any key.
 
+In order to direct the build to use your own signing infrastructure
+instead of the custMpk.pem dummy key shipped with the U-Boot sources,
+add something like
+
+.. code-block:: dts
+
+    &keyname_template {
+        keyfile = "/path/to/your/key.pem";
+    };
+
+to your board's ``-u-boot.dtsi`` file. You can also customize the
+Distinguished Name in the generated certificates by including
+something like
+
+.. code-block:: dts
+
+    &distinguished_name_template {
+        distinguished-name {
+	    C = "DE";
+	    L = "Berlin";
+	    O = "Acme Corporation";
+	    OU = "Cartoon props";
+	};
+    };
+
+Ensure that any ``ti-secure`` or ``ti-secure-rom`` nodes defined in
+your own ``.dts`` files contain
+
+.. code-block:: dts
+
+    insert-template = <&keyfile_template>, <&distinguished_name_template>;
+
+as that will ensure that all certificates use the key and
+Distinguished Name defined in the templates.
+
+If you do not have the private key in a file, but instead use a HSM of
+some sort, it is also possible to set ``keyfile`` to a PKCS#11 URI, e.g.
+
+.. code-block:: dts
+
+    &keyname_template {
+        keyfile = "pkcs11:object=your-key-identifier";
+    };
+
+For that to work, you must set the ``OPENSSL_CONF`` environment
+variable appropriately when building, pointing it at a configuration
+file matching your pkcs#11 provider.
+
 Chain of trust
 ^^^^^^^^^^^^^^
 
-- 
2.55.0


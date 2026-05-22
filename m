Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0733DCD4F3D
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 21:29:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8459848FD;
	Fri, 22 May 2026 23:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="B4x8Ux15";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E62A5848F5; Fri, 22 May 2026 23:28:17 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FA8284912
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 23:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmYwIzEXsvNUJSfS4nOGMWDbbSyQ5HYx8Cc1Zv05bffzVJycQUqIkMo7vqMPJ4/nY4Hj9w61/DeA1e+Dd21Va1c+ZuSHzeKuWeWqfF8CeeTDIocEycHQLPwghQBPvizIYvPIsfhqsBD8MMCRwn3QF8LobQuUrWnK9BvD2NuAtWEjAmwy0mY9HMQJk3APhlgAih7kyXG1eXjSQhjtYelw7pNhZ8zFGQUsyfCVwfjtU4RmFMHWOP8+M95PhLA9QKPNtmV+YHJ8KsogcdHm9xll4rWXZUDLddsElT/8UXrsa6Bd0Ar9eUoIBlXwLUMWLdmm7avjOsqazqx5vEISI4NByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk/Aud3gDI1K4JRe31iqjU3YYL3Bx7Zj0oooCdjauEI=;
 b=jF4b8x7dTCLqoO4OnmhwkpAyVrwmt4NkFyqQ4WWmgm+AuXLaF7JNcY6Suf22CoejFlqEUfFT6JrRtPlOpnShEfDZetp00yuZGNWwROvBfUleiQYiv9e9oR1TkHJexgdtQPMfBhLpp115x/B0g57ANHbQuZL8BLM3rw2j/oxOxobuYzf94ET2JDywkpdMu7s8VIJN/Mxr1gw2cz59PhMd+s9DBqJXCUbQK4yiHVXk9zDoItVkbWflSm+7vIpFe0tXdZhN8LLKsvrLHxS83Uy7bZmiUW1mCh5brUgMilfyqwwZjSdr7by6L8MQNBrMA3/nGwdHrx76VhXPVg0FylxeUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk/Aud3gDI1K4JRe31iqjU3YYL3Bx7Zj0oooCdjauEI=;
 b=B4x8Ux151a9ptVl0944hiwr8+UHw7K3H0lFv4DK6UJRLnJIinoPQFg+ode8o38DqgYA+fMUoIEgZrJ/0B8c4w9Gq6zLoVq7Y+7uSryL1YOv9uol06DYYU8gpaK/vgKZJXDBi1lkWOuX2H5nwKFJA+RUXRjPqhsf0wRZIhE4w6BQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB5385.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:340::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 21:28:10 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 21:28:10 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [RFC PATCH 9/9] tools: add linker-lists.py parser/checker script
Date: Fri, 22 May 2026 23:27:56 +0200
Message-ID: <20260522212756.3169222-10-ravi@prevas.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522212756.3169222-1-ravi@prevas.dk>
References: <20260522212756.3169222-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::17) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB5385:EE_
X-MS-Office365-Filtering-Correlation-Id: 68becc9f-a4c9-4259-c461-08deb84905e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|6133799003|3023799007|11063799006|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: cuTFP/f8PEPixFJQq6MxHDST0dUpBUeobJZ2kj91bCi3Au5B8848FpebEBwELoOfBW7Ge01K8CT9yIAwcwBm6/gd0y1wPn9ctHdDcBcxYioNgKl8N1gH1nmbHCthUZjFwx0W1IQA9sB8qkN8kMjelP4tlBu996ADYPKCEQszmcA2uhmkdH7LOOu4r7aIlM9e6KnC0OXi0+mCtF51a0GA0xBjQGNNbJKwY5nYu7IE1FDVKuGTJ0cRRb2P9uob+Fy3w9CXxcfOzz+3eP8gSdwSmPNJ+2/4LIWQ0W0kcJq/CfuQ1zrsvWMDGEUdhwHzrzUbGFw+Nd0f7cweF3V4CNASlK+uctNEs19rRRdHcjXTMoFUE617zOG1YcMh3XEmcYYPp2Y/koHR6kvXsyTm7jZeh1QCGHmCGFW4AcIlYJfBt/AtiFbowZfLH0D/OJZ9RKQH8xGFhjrLXNn2/XH56ni4vwMeV37jWSfJdzQaf5wJJC62Pwhh1KT/X0XGz1GmtyqMIyQNZ7+0Jk2OJ2qsAJCLCeFsX9bq67HVQibttApNsj7cRtwooEe4ajpsU0zBi9EtfIXqsIpQavueWoLWmHrAy6tPOdr2QXIVc4dGL1/XZF85yI+DaSZLGNb52/gCnpJmzzupXA/qC4PkwaxxED/WBAIJcEHA42wJSSZLSilYyMhcR/LqQlSoQagA7H6OImNLpUKzpH2V0NlXkeDrorqmg/XcF0j1tXQUc45feW5RBx/8EYD5FiwfGyeZvWbnwqNE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(6133799003)(3023799007)(11063799006)(56012099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jlqK1PwSrj9+0fwYekZ4iPktmh5wI1JuRcANUjOVcOfItIGCNSBijscnqvJM?=
 =?us-ascii?Q?FTtQ7aS0Fku5oEH13PBw5cEq3epHqCDj55YH8U3EVYvuMoA/50x3xJZNiG9P?=
 =?us-ascii?Q?EzCv9crnhsJX0tZKSAhPdCw5DY16nct76sUONxdfGy+0nz+A2qCDILX3etmH?=
 =?us-ascii?Q?jpBAXT/KXVsuxw6ep1pl8/RtNBxVSwJg98yaxRcHnoYHZMQEkHGM2GA3bS5h?=
 =?us-ascii?Q?1UjonrjD5/yzt5r8sDDm+XcVcsLcfFGQFiDOL6x3BYa9+pJ0bHgroPiYZfRl?=
 =?us-ascii?Q?zRAkcNvatE/2H4B6kep/op3zCZjYkxvyFLG5gNFVeh3EFLhUlRMjqcXLdegK?=
 =?us-ascii?Q?ASVWlyzdFH8hDZ93g90FyLC9oHjbAZzfCtiPV6jUiXFXb25QupNcEo3Xa523?=
 =?us-ascii?Q?TXW+u7yyjEKzldYadN7AS8VQtVkTyYJ0kjoexxfo7srbVGXbe3n5UFa8ulGM?=
 =?us-ascii?Q?ye+P6wDXaeMXdD8hCF2FW+jp9EVRgr4pl+yff5zkA/oj1iVOKCtAu2rmG31S?=
 =?us-ascii?Q?2idWaF0Cv+mivxx66E9c/oJ0I2W7YJR7gD6ty7hAqMosgP/AggxMdnRgqg+4?=
 =?us-ascii?Q?EdkiS/emFwHezSVHs5s3NBoDZCEGlv2CNBPTg9g2I9y+CH9IaBPIqF1vcfJg?=
 =?us-ascii?Q?KHTDpESZvb7TJXZVIFRn0g1Sa+HAGUfZmHkUjTav4qI8yZg/mZptMwEEuhvG?=
 =?us-ascii?Q?dZMcnfi5JNvheCUeDVSpV8TMDQ11NkHYSHH/7Jnatn9oOhEyocOnE9Y9qLl0?=
 =?us-ascii?Q?/FBZ6AOuyXwjnZHjPWAEVzwlE2Wa9hbbkgxHTW6C4pT6RRCCLkSi2dhsIf0t?=
 =?us-ascii?Q?P61QnbhNBSrS8ETGnVIox2ynmQM+J2+Cv3iw2q5zYqznmn7Dxie/9c9GeG4w?=
 =?us-ascii?Q?sTmHq3W63tSrO44jWLHboPgYqioKgYl8FBlEa4S9h4Twbyw9m0HAHFe6evV+?=
 =?us-ascii?Q?g71obEKWVsfE0fIZeAb+zKxyaU4hYgaCrz6MzwdKFLNOYwxy9hCkAqsLrWZz?=
 =?us-ascii?Q?XQONFA4PuefPCrK18mtCCAWBdcerWPseeS6sg6RiUxNgwkpCkNAm26mx2A3d?=
 =?us-ascii?Q?ic2yZP/S4ht5IgQOtnxW0PCnEp49p5GxKtxZ0fGRCJXTKR6sGE9ifKMtqsol?=
 =?us-ascii?Q?mTwF6zxLr1+3VHQ0wlBeoghGLGAIE3xOK/AatPxlKB6jIDU7FuinGQQ/DFnX?=
 =?us-ascii?Q?gJ+tsC2jAUO+Ee38e0jeKEl+rNetQKt4EHrm3FEVWny3p35UL26fzE29i4of?=
 =?us-ascii?Q?RB1l2f4VHb1vlQfjbYUlcKFspeCYCoq9/0dESCxUH6nP2w1ggLhBmdugvZtT?=
 =?us-ascii?Q?/nVOL5ZjFa23UcII9BsXU13a3hxt/81FLb6wKodIcGFnyxWwKQvHgCVYS7aj?=
 =?us-ascii?Q?zNtXXbZFttjuTeTeNN+gCwFNf7cNJnl4qG0Gr7SIXZAuebvsv7uLmS7WEfRh?=
 =?us-ascii?Q?25qgmUQldHO33QbMu5rDwl1L3L0kq0hjkRy34e7mqPwX+v7GVxoLGV5MWAVF?=
 =?us-ascii?Q?IdfCV6LuGn1QUud4WTnldtDtiCzcDL5wuzdI7NQv/TQS6yOuUdJ+Ut7Iuh9b?=
 =?us-ascii?Q?efzPu65V+rSYMsZFy8EJNgJucUya4KQvPiiaFaXSG808/pQACs2odI451qEO?=
 =?us-ascii?Q?D6EVhqESxhUzXrxOxOEMl11laKBuipFbyfPtexRaAxzX36/PnNIRc3fBVxZ5?=
 =?us-ascii?Q?zXWoMn5EpOlnKQEWdTSM4ebFmHSLLd7ovrj7EP6GX0bx2Bna3aOcANf7L0+W?=
 =?us-ascii?Q?6B5kMAPka40A+hUjubTSl9256Y5lG0c=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 68becc9f-a4c9-4259-c461-08deb84905e4
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 21:28:10.5398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7NWC5/mWMn6nd0gzpmcKbKB7bteapMwuvp7t1m2G4YEYnaOIIONahgqNQVX/BU38wEVQWsMvZTQYYMjiId/DyQINoYSj4V5gakHebphRO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5385
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

Add a python script which will make use of the special symbols emitted
by the linker list macros, and perform various sanity checks. By
default, it ends with printing a list of all the defined linker lists,
including their start/end addresses, the size and aligment of
individual items and the number of items.

With --check, it only does the sanity checking and its exit code
reflects whether any problems were found. That is eventually intended
to be done as part of the build.

With --dump, it not only prints the lists and their overall
properties, but also the names/addresses of each item belong to the
list.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 tools/linker-lists.py | 234 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 234 insertions(+)
 create mode 100755 tools/linker-lists.py

diff --git a/tools/linker-lists.py b/tools/linker-lists.py
new file mode 100755
index 00000000000..419879ee31a
--- /dev/null
+++ b/tools/linker-lists.py
@@ -0,0 +1,234 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+import sys
+from argparse import ArgumentParser
+import subprocess
+
+# Parse the output of
+#
+#   readelf --wide --symbols u-boot
+#
+# or
+#
+#   nm --print-size u-boot
+#
+# do sanity checks, and optionally print information on all the
+# defined lists.
+
+bad_lists = set()
+def warn(list_name, msg):
+    print(msg, file=sys.stderr)
+    bad_lists.add(list_name)
+
+class unique_dict(dict):
+    def __init__(self, name, format_spec, *arg, **kw):
+        super(unique_dict, self).__init__(*arg, **kw)
+        self.name = name
+        self.format_spec = format_spec
+
+    def __setitem__(self, key, value):
+        if key in self:
+            old = self[key]
+            if value != old:
+                warn(key,
+                     f"Inconsistent {self.name} for list '{key}': Old value {self.format_spec}, new value {self.format_spec}" %
+                     (old, value))
+            return
+        super(unique_dict, self).__setitem__(key, value)
+
+# <list name> -> <value>
+item_size        = unique_dict("size", "%d")
+item_alignment   = unique_dict("alignment", "%d")
+start_address    = unique_dict("start address", "0x%08x")
+end_address      = unique_dict("end address", "0x%08x")
+
+# <list name> -> list of (name, address, size) triples
+entries       = dict()
+
+def handle_symbol(symbol, address, size):
+    if not symbol.startswith("_u_boot_list_"):
+        return
+
+    symbol = symbol[13:]
+    if symbol.endswith("_1_start"):
+        assert(size == 0)
+        start_address[symbol[0:-8]] = address
+        return
+
+    if symbol.endswith("_3_end"):
+        assert(size == 0)
+        end_address[symbol[0:-6]] = address
+        return
+
+    if symbol.endswith("_0_item_align"):
+        item_alignment[symbol[0:-13]] = size
+        return
+
+    if symbol.endswith("_0_item_size"):
+        item_size[symbol[0:-12]] = size
+        return
+
+    # Deal with lists/sublists. ut_2_bootm_2_bootm_test_silent
+    # - An entry called "bootm_2_bootm_test_silent" in the outer "ut" list, and
+    # - An entry called "bootm_test_silent" in the "ut_2_bootm" list.
+
+    atoms = symbol.split("_2_")
+    if len(atoms) < 2:
+        return
+
+    for i in range(1, len(atoms)):
+        list_name = "_2_".join(atoms[0:i])
+        entry_name = "_2_".join(atoms[i:])
+        if list_name not in entries:
+            entries[list_name] = []
+        entries[list_name].append((entry_name, address, size))
+
+def parse_readelf(line):
+    # Fields are
+    #
+    #    Num:    Value          Size Type    Bind   Vis      Ndx Name
+    #
+    # where Value (i.e. address) is in hex and Size is in
+    # decimal. There are lines (such as that header line) that we just
+    # need to ignore.
+    fields = line.split()
+    if len(fields) != 8:
+        return
+
+    (_, address, size, _, _, _, _, symbol) = fields
+
+    address = int(address, 16)
+    size = int(size, 10)
+
+    handle_symbol(symbol, address, size)
+
+def parse_nm(line):
+    # Fields are
+    #
+    # Address [Size] Type Name
+    #
+    # but [Size] is not present when it is 0. Both Address and Size
+    # are in hex.
+    fields = line.split()
+    if len(fields) == 4:
+        (address, size, _, symbol) = fields
+        size = int(size, 16)
+    elif len(fields) == 3:
+        (address, _, symbol) = fields
+        size = 0
+    else:
+        return
+
+    address = int(address, 16)
+
+    handle_symbol(symbol, address, size)
+
+
+ap = ArgumentParser(description='Linker lists sanity checker')
+
+ap.add_argument('--parser', '-p', default='nm', choices=['nm', 'readelf'],
+                help='Program to use to parse the ELF file (nm or readelf)')
+ap.add_argument('--check', '-c', action='store_true',
+                help='Only do sanity checks and exit non-zero if any problems are found')
+ap.add_argument('--dump', '-d', action='store_true',
+                help='Print all individual list entries')
+
+ap.add_argument('elf_file', metavar='ELF_FILE', nargs='?', default="u-boot", help='ELF file to parse (default u-boot)')
+
+args = ap.parse_args()
+
+if args.parser == 'nm':
+    parser = parse_nm
+    cmd = ['nm', '--print-size', args.elf_file]
+else:
+    parser = parse_readelf
+    cmd = ['readelf', '--symbols', '--wide', args.elf_file]
+
+subp = subprocess.Popen(cmd, stdout=subprocess.PIPE, text=True)
+
+for line in subp.stdout:
+    if "_u_boot_list_" not in line:
+        continue
+    parser(line)
+
+# These should all be the same, except perhaps that there might be lists without entries.
+list_names = set(item_size.keys())
+list_names.update(item_alignment.keys())
+list_names.update(start_address.keys())
+list_names.update(end_address.keys())
+list_names.update(entries.keys())
+
+list_names = list(list_names)
+list_names.sort(key=lambda x: (start_address.get(x, 0), x))
+
+for name in list_names:
+    # There really should be item_size and item_alignment values for
+    # all lists. Otherwise, we've emitted list entries to a list that
+    # is never referred to via the start/end macros.
+    size = item_size.get(name)
+    align = item_alignment.get(name)
+    if size is None:
+        warn(name, f"No known entry size for list '{name}'")
+        # Let the below sanity checks pass.
+        size = 1
+    if align is None:
+        warn(name, f"No known entry alignment for list '{name}'")
+        # Let the below sanity checks pass.
+        align = 1
+
+    if size % align != 0:
+        warn(name, f"Item size {size} for list '{name}' is not a multiple of the alignment {align}")
+
+    start = start_address.get(name)
+    end = end_address.get(name)
+
+    if start is None:
+        warn(name, f"No known start address for list '{name}'")
+    elif start % align != 0:
+        warn(name, f"Start address 0x{start:08x} for list '{name}' is not {align}-byte aligned")
+
+    if end is None:
+        warn(name, f"No known end address for list '{name}'")
+    elif end % align != 0:
+        warn(name, f"End address 0x{end:08x} for list '{name}' is not {align}-byte aligned")
+
+    if start is not None and end is not None and (end - start) % size != 0:
+        warn(name, f"Difference {end - start} between start 0x{start:08x} and end 0x{end:08x} addresses for list '{name}' is not a multiple of the item size {size}")
+
+    for (symbol, address, entry_size) in entries.get(name, []):
+        if start is not None and address < start:
+            warn(name, f"Entry {symbol} in list {name} has address 0x{address:08x} before start address 0x{start:08x}")
+        if end is not None and address > end:
+            warn(name, f"Entry {symbol} in list {name} has address 0x{address:08x} after end address 0x{end:08x}")
+        if entry_size % size != 0:
+            warn(name, f"Size {entry_size} of entry {symbol} in list {name} is not a multiple item size {size}")
+        if address % align != 0:
+            warn(name, f"Address 0x{address:08x} of entry {symbol} in list {name} is not {align}-byte aligned")
+
+if args.check:
+    if len(bad_lists) == 0:
+        sys.exit(0)
+    else:
+        sys.exit(1)
+
+
+print(f"{'List':36s}\t{'Start':10s}\t{'End':10s}\tSize\tAlign\tCount")
+
+for name in list_names:
+    size = item_size.get(name, 1)
+    align = item_alignment.get(name, 1)
+    start = start_address.get(name, 0)
+    end = end_address.get(name, 0)
+    count = (end - start) // size
+    if name in bad_lists:
+        bang = "\t!!!"
+    else:
+        bang = ""
+
+    print(f"{name:36s}\t0x{start:08x}\t0x{end:08x}\t{size}\t{align}\t{count}{bang}")
+    if not args.dump:
+        continue
+
+    for (symbol, address, entry_size) in entries.get(name, []):
+        print(f"    {symbol:32s}\t0x{address:08x}\t{'':10s}\t{entry_size}\t\t{entry_size // size}")
-- 
2.54.0


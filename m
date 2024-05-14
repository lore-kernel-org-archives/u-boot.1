Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A2AC04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 14:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E59C88303;
	Tue, 14 May 2024 16:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="RG1BtCmI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 802C688232; Tue, 14 May 2024 16:04:35 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::70a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C12A88303
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 16:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRH9R5R5MVENlTJwNVIc0tGkcQiT8Vsn4P9DBpIEAlq9bfBikanz2aV7JBN5TjL4lfCoCvjP6ujyGs7Rkr7xK9xvwvEOFZOUDkDPiNry4Q+4sphSTr35+ullH4d1kQRsd6EpP/DGJ4J4kde/CMXfK2VByJnhAmN2IHZ8uV3/INf0HyMdnd1roFnYp4Rbt1nl6TT245Z7XIPsyGS35YBKTLwpze4eaEhsC5oCB1hIgfgHuksqs+AhXXEwrKynMChp1FYJJdYPX8EHqwUZ/Ok76qpTYNXRVPvP0Fzz7M3OuyllWRKmbRkKhjfNJRFLzXB9mQNYiiz60W7AADMRsB3wYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4ecPOl7Ls4Icsb9WjBhLJyA2KMOpHPOgI2NDRju/qU=;
 b=NYe9fGzWwkRevuOFUIyTxxiyN1vc1eAmFIdqNFeY0e5QklyYISpv+8aAaVa/j7gKNbgy8fs2JphPUToOE6vSXV/tcX1Bvg++I+H4o+2+lZmSx75AZNT9bqOypbbEIoWSL0MVEta9EXmEWdspyomL2+kbfAAYZ8FM0/EMHlyp48SRAEbx0PoQJIv02xUDdOjWxLWGf+HVGlo+V4wEKfjcpnqaoSXLz4Pla1r0W/CpM8cdaXBUaTb1/JaIMChczTTKAv1Mps6DM7hOWJEL8bfrfNvcZ8JLRniVdBDw9oABlCgicyToyePSEWdJ09qVt2rEVuzeZlS4cTi65rJ9b/cRrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4ecPOl7Ls4Icsb9WjBhLJyA2KMOpHPOgI2NDRju/qU=;
 b=RG1BtCmILyj0ZkCzxvS/gNSLn2/J40OHaOPVxVMbU4FMgxgi9zzgggEe4oOsNsU9NTkLSlvJHjSknkfMQmY4FTZyMcl3GRzIRF+14sripHz75xqr5o7k4lfalY8qVciQm9VQXKphI3dh4NUpvoj02I7apDNmfFL454zEc2scRX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by VI1PR08MB10052.eurprd08.prod.outlook.com (2603:10a6:800:1c7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 14:04:30 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 14:04:29 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 2/3] amd64: zynqmp: Add command to program efuses
Date: Tue, 14 May 2024 16:04:15 +0200
Message-Id: <20240514140416.156747-3-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240514140416.156747-1-lukas.funke-oss@weidmueller.com>
References: <20240514140416.156747-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::12) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|VI1PR08MB10052:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af652cb-3b13-4426-3d1f-08dc741ec5f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|1800799015|376005|52116005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pS8MZxVHRwm2biKEUGVpRAZrJhnBACPruWtNYq+RMz8i+q+1oZ4Twlnk00Ww?=
 =?us-ascii?Q?VTP0MSXlM9wnNLBtqz+xSMgdRXdsMyhY+YflGYyXRTaTDS0Hu8lbnCfN0PnB?=
 =?us-ascii?Q?xe0yfEp0EYdugEHIKjmNwEoir4ne9EiLKGVYyh0enY7x/CChxIGf45aHCY0H?=
 =?us-ascii?Q?OlmlJl8LXJJIu9PNfh5un/HtZlZHGQgg8tiaciaLJvxl9rgw8IUpAjibL2PS?=
 =?us-ascii?Q?mPzcZETx8WmA71xlEXCDMUoCOysTamy4QgloYr4LexcVoF/QYY9E8zE7gXN0?=
 =?us-ascii?Q?kKo7zCmF8pUXRhVKk9hFiS8Hvu+lyGSWFrPfx4gE27qWKz1XCIYtCMqLsEFU?=
 =?us-ascii?Q?Ve/R6T2i4gZofT0cdM5LYxwLzlvZHU05QZuwaS32pKepirh+F33tsQlLzsbJ?=
 =?us-ascii?Q?lCZ4O+34TM0fRRpE29KRU8Llcr4VA0Qo7h3aS05KX+7kjgDNTjWQPo+YBjUi?=
 =?us-ascii?Q?x3TNlnDdHWI0JpmwBIk2K16mqZ616JkQ1I9V8AXEm6yFMVZLxglQyja3ku3v?=
 =?us-ascii?Q?YYEuTSJTtKkT43tl55nP3Eu5jSP+PwmDRBg1yhG4a9l+oZfAH1pQZ8Y1B7Q4?=
 =?us-ascii?Q?p79shWjm2fDqKuKdHnoBNxKEBdwVjHyuWYffdvBXFa4Bbr2fgkGSP/KsunLe?=
 =?us-ascii?Q?UWl4lUEnJ17qLmRF0e9qDrhxPxd2vHcWt4z+PMjHqYuS9u5M8ELZa3e6ksE0?=
 =?us-ascii?Q?cNl2xaR4GwTBzTC8jECteP+Z9Bu/pb+KvLHuTEJJC3tJVchh66IxsDsprFAO?=
 =?us-ascii?Q?rAslyIbdvPROvJzsKWfv/5TZ1CgHChxhJPNQaLEnA2SrQt2QyUq3aqN8WiwD?=
 =?us-ascii?Q?jDpUb1HTnNvbeczcsk++i9d6Pqn+yDbvtxikECHHOemOWKoN4eQFWg9UnruT?=
 =?us-ascii?Q?YvP8PT1yGI2S/7AaJC9CBtdfCivyBbUWCfDYdaKmpJ/bNHqBJUiC6O94fhFf?=
 =?us-ascii?Q?XTmp+f0dNHVc96t/4SzF52irgWv8rLrEOjdrxzwKYFRcVY/xYWj57Jv97g4e?=
 =?us-ascii?Q?wDX2pvIfjhwnYuhX40+Wc9BFAVcnpiaBGdtJsdJ3SNa/chJgO6NbDGT66SMu?=
 =?us-ascii?Q?36LjF1VkwnEq70abfvO0ohux0u8pebViUK4PFqdvjrr2t0tM5Giz4h4GBDXJ?=
 =?us-ascii?Q?YJwfQFB212bDh6UeShMVrPnju2QsIRN5sH6z6CWZWcLyDRL71+AEZGfbUM7u?=
 =?us-ascii?Q?toMLwU9ZOBGJ6W0LtTlb2xddh1vcTMxyB93K0R6kicxkahfj/pfekgneJoIO?=
 =?us-ascii?Q?qH/3H32piP/4eRZirmhLbdhHq4pqZUV6Oyr8eeOsqVLHVl0fSMy+Cyz9UC9y?=
 =?us-ascii?Q?I/yOVgw/eKLSILr81PCs/fIHbFWOLkGbRaRv6XC74iLwVA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(52116005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tHF5KvcjH+8n7/P7VWnZqMrqmFyNYWV9W185ThdO/WGAX18cEsuKRRLru4Uj?=
 =?us-ascii?Q?vLFdzF4Jrk/XyqNLY6J04jPgAC9pcw4pnRBYY15bdxGFgYyzZdWFmMTZNEd9?=
 =?us-ascii?Q?YqkfzSawOu9jAd3Xxz03wydMOiZfb0RYYRlER41n6Y7FuXoC/NDZCgZZk9lV?=
 =?us-ascii?Q?ROWeNOJ+9i4SYPU3z/LcFCe/aESQhP8ursNC/zUrsesLwqKFGtvGoGZ8m1Pw?=
 =?us-ascii?Q?yXtvlrL95nPGfHzYd6WU8v1AtWJ+Dq7OMw/c/YABopog3W9fIr9GVe93iJvZ?=
 =?us-ascii?Q?3q1FH49MVVYkOsNgcoBTHbF9Xrs5DBAeVIOkfVi88vmg21XqdhPpTyTRWfPA?=
 =?us-ascii?Q?nslq4P3RFCj2xPYfseLwqraWBowIR7AUzfP0oU1+tCH27Qc7G0Vmb68rPUpB?=
 =?us-ascii?Q?gZ5uEdeJ7EDScjV0gaw94RHvH/9KBlMegJNiBy4pH3al/ka8nvTexSVB7QRU?=
 =?us-ascii?Q?W+7vCpmzchPNIDSX2j2KhjMKnl4I6XsMF64kBZLYGEZIW4X1eMyYs2VnoexI?=
 =?us-ascii?Q?taFetUQHMAjcyPBT/wEMC32r5fiV6gUqKM7rCn4qbrG4A9MA6BFQydNE1iJO?=
 =?us-ascii?Q?1wUgq9uXMSs8jGWhwJ0ydqYAkiwrdjRyswhFSwpb9jabldETR9AylOt57FN8?=
 =?us-ascii?Q?li9tdhDh5YEqs1hgiWoGSQUsi52qH7F5XMRUFRFN5wgalFhstmCrnXYVukEP?=
 =?us-ascii?Q?FHw+ydHW4FjS3vZId5z98VUOAlwH52f5JardncMrewnxxZLV3W27mzAK2+ci?=
 =?us-ascii?Q?xwuG+RrIMgl4yMpUozOFSsvWBcoTU6ghKtkg8WNvuhvD41jMN2UiWNCOXLLh?=
 =?us-ascii?Q?mrXHJpgjy/vEiRBFr0Wi3IUiyxKu2SPCRE2RGWV7eI7Y9qyEELxowDp/IBnJ?=
 =?us-ascii?Q?u4uOBYEo+TaWZWcmPw1CE+geKmjQzMKuDv4sImCKgOvJ/oLGzv+l/Dl2ChZ6?=
 =?us-ascii?Q?W7Q8cGDpT3ANfT0qyD+nqxi8BaLCWtgauE2OQswwACNOpBpssHweo1Tq9suE?=
 =?us-ascii?Q?G03HaaO8n9ORzK7bOiljx25RPEyOg8I6ofkz2KJhX5g8SFNhavQoP9Ijdrb/?=
 =?us-ascii?Q?LYS13xKnRJszuH120nvAJXDfVV4yKLc2sTAEhxdM33AYg+FuI7p/+mduKMFp?=
 =?us-ascii?Q?sCTGYj6lABO9urJjtEdIwvV71zMwAZAPSmBQXfOnnssEMAqT5JCC26SYJJWy?=
 =?us-ascii?Q?NfucyybhnW+oG4PvXb+HKnBaLLjuEGaxnUcMnQ/UAQRU/A4jikPS0hMrD+qt?=
 =?us-ascii?Q?MVk8dsNvJCO5O+Nlbb5XBnBiBYiXRFB5HH6tOJORNAn3kuPOSuWz/2j80+c6?=
 =?us-ascii?Q?+B2vxmvfr3/OmCveZRSUZ/sh80GDnqRSDaKGrO3D417sKoafUeNGTRGtrBqM?=
 =?us-ascii?Q?MpfwC4uKz5zi7LIoblmnbrqY7TrDfLRmuoKnqq6OZoZputZgig9kkmTNeHot?=
 =?us-ascii?Q?Bm5HQC7lvixz+J22539vags0yrAHC/uC9MzkxCAtDsGPZjbVJG67NFOzrPBh?=
 =?us-ascii?Q?iy0+vC7MKVY0AZehyqwIRSIEj7UHSBuWywuql8N2S/1UP+BNs6ak1VqYf1Cj?=
 =?us-ascii?Q?lnvrjv+0IwhIc1hiCltQKQ7NwPH7Xe0B21EsbZFM?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af652cb-3b13-4426-3d1f-08dc741ec5f1
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 14:04:29.9484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycZnEP3FfzkDVPbEgX0YwiBFsPLhkWVJJtwfdhVNrVqeTM/fq3d4j+jTHZ6/5D3ul1VUTPN5FASk7t5YqbMxEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10052
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Add subcommands to read/write eFuses using u-boot. The subcommands
through the 'zynqmp' command.

Example:

=> zynqmp efuse_read 0xc 0xc
00000000: 85 36 b1 3c 34 f2 3b 01 00 00 00 40              .f.<D.:....@

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 board/xilinx/zynqmp/cmds.c | 101 +++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/board/xilinx/zynqmp/cmds.c b/board/xilinx/zynqmp/cmds.c
index bf39c5472ea..e8d70ffecd6 100644
--- a/board/xilinx/zynqmp/cmds.c
+++ b/board/xilinx/zynqmp/cmds.c
@@ -16,6 +16,9 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/io.h>
 #include <mach/zynqmp_aes.h>
+#include <misc.h>
+#include <hexdump.h>
+#include <dm.h>
 
 static int do_zynqmp_verify_secure(struct cmd_tbl *cmdtp, int flag, int argc,
 				   char *const argv[])
@@ -340,6 +343,99 @@ static int do_zynqmp_sha3(struct cmd_tbl *cmdtp, int flag,
 	return CMD_RET_SUCCESS;
 }
 
+static int do_zynqmp_efuse_read(struct cmd_tbl *cmdtp, int flag,
+				int argc, char * const argv[])
+{
+	struct udevice *dev;
+	u32 offset, len;
+	u8 buf[32];
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(ZYNQMP_EFUSE)) {
+		printf("Failed: not supported\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (argc > cmdtp->maxargs || argc < (cmdtp->maxargs - 1))
+		return CMD_RET_USAGE;
+
+	memset(buf, 0, sizeof(buf));
+
+	offset = hextoul(argv[2], NULL);
+	len = hextoul(argv[3], NULL);
+
+	if (len > sizeof(buf)) {
+		printf("Failed: length exceeds buffer size");
+		return CMD_RET_FAILURE;
+	}
+
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(zynqmp_efuse), &dev);
+	if (ret) {
+		printf("Failed to initialize zynqmp_efuse: %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	ret = misc_read(dev, offset, (void *)buf, len);
+	if (ret) {
+		printf("Failed: cannot read efuse at 0x%x, errocode %d\n",
+		       offset, ret);
+		return CMD_RET_FAILURE;
+	}
+
+	if (CONFIG_IS_ENABLED(HEXDUMP))
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, buf, len);
+
+	return CMD_RET_SUCCESS;
+}
+
+static int do_zynqmp_efuse_write(struct cmd_tbl *cmdtp, int flag,
+				 int argc, char * const argv[])
+{
+	struct udevice *dev;
+	u64 value;
+	u32 offset, len;
+	u8 buf[sizeof(u64)];
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(ZYNQMP_EFUSE)) {
+		printf("Failed: not supported\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (argc > cmdtp->maxargs || argc < (cmdtp->maxargs - 1))
+		return CMD_RET_USAGE;
+
+	memset(buf, 0, sizeof(buf));
+
+	offset = hextoul(argv[2], NULL);
+	len = hextoul(argv[3], NULL);
+
+	if (len <= sizeof(u64)) {
+		value = hextoul(argv[4], NULL);
+		memcpy(buf, &value, sizeof(value));
+	} else {
+		printf("Cannot write more than %zu byte to efuse\n", sizeof(u64));
+		return CMD_RET_FAILURE;
+	}
+
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(zynqmp_efuse), &dev);
+	if (ret) {
+		printf("Failed to initialize zynqmp_efuse: %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	ret = misc_write(dev, offset, (void *)buf, sizeof(buf));
+	if (ret) {
+		printf("Failed: cannot read efuse at 0x%x, errocode 0x%x\n",
+		       offset, ret);
+		return CMD_RET_FAILURE;
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
 static struct cmd_tbl cmd_zynqmp_sub[] = {
 	U_BOOT_CMD_MKENT(secure, 5, 0, do_zynqmp_verify_secure, "", ""),
 	U_BOOT_CMD_MKENT(pmufw, 4, 0, do_zynqmp_pmufw, "", ""),
@@ -348,6 +444,8 @@ static struct cmd_tbl cmd_zynqmp_sub[] = {
 	U_BOOT_CMD_MKENT(aes, 9, 0, do_zynqmp_aes, "", ""),
 	U_BOOT_CMD_MKENT(rsa, 7, 0, do_zynqmp_rsa, "", ""),
 	U_BOOT_CMD_MKENT(sha3, 5, 0, do_zynqmp_sha3, "", ""),
+	U_BOOT_CMD_MKENT(efuse_read, 4, 0, do_zynqmp_efuse_read, "", ""),
+	U_BOOT_CMD_MKENT(efuse_write, 5, 0, do_zynqmp_efuse_write, "", ""),
 #ifdef CONFIG_DEFINE_TCM_OCM_MMAP
 	U_BOOT_CMD_MKENT(tcminit, 3, 0, do_zynqmp_tcm_init, "", ""),
 #endif
@@ -422,6 +520,9 @@ U_BOOT_LONGHELP(zynqmp,
 	"	48 bytes hash value into srcaddr\n"
 	"	Optional key_addr can be specified for saving sha3 hash value\n"
 	"	Note: srcaddr/srclen should not be 0\n"
+	"zynqmp efuse_read offset len - read efuse at given offset\n"
+	"zynqmp efuse_write offset len value - write value of length <len>\n"
+	"		       to efuse at given offset\n"
 	);
 
 U_BOOT_CMD(
-- 
2.30.2


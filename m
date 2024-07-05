Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20C6C2BD09
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 13:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 160CD889E8;
	Sat,  6 Jul 2024 15:37:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="MB6ukZOa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C8DC88864; Fri,  5 Jul 2024 22:30:17 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE9E0889D9
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 22:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9h6wQ8wYMzbALPI7zp7n0nK6EbzigPGWUy4uHvJUbHfUK61bekV829XhYn+HrNFh/uag1uodpMEMbF1UEvuC6FFdgsyy4dIDTXDyAwmGxzlBV1ooiDEP3zaBVUaPo5rhB88Swy5L0D2cB4ibRbytQzcFkBF2yTp7PQs0ArJZChNVbFFdqIp8kcWbjXvhnG0zRIEA2XpW6CT1uc3gU0UpY12TMU/uy1aP3fg8QFjSFkrHjORB3FnbUL9hMjKIexixBRaBtUfxvvYHx8jmmdpwfSKtZSGl7P04O3EaXe9CiPcD3EZrtRP60r30VSWFwP6qGwHm3GGd6y1TQxym1Zyug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HkmnCU9ax2nIbZD47/0VID8guvEFzBgl8JoFoTq+Yo=;
 b=TR5G0xw4HpSF3SPxCGMrSKc6GfEAJGvGwVlmgLv5wvEr2qtyDgfGUUBe7Q9LZQyOzVVoxQPe4OM2sPteNahj+maLMowI3KRkna5KNVyNBz6ClJV2xiToolBoPDlABbdbcPBdw6YDQDPg/VCCgLpTcDawxgcPKLhc010tERAyZU6XIiRO+SpCkjrjgeppbobP0yj7lXJJYgPUNetyTwvgNosfP9Gnd1DKf31mu+CFF/kvKB+AnLI4XLwbmkVn7DYdvJBi9uj2vvdwT9KVe+OvS4OwI7td3oQoFFEO5dj8IlfslgvNzp1N1wkytbQfyhYCosLww1K+zgLB+0aRfvmUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HkmnCU9ax2nIbZD47/0VID8guvEFzBgl8JoFoTq+Yo=;
 b=MB6ukZOaO8ObYJSAa2b13PVPCk4QC8YFugy5cf6nciSc/EooaazWvV/pNswFBAZJiCdq2pubauoIaV2QyHFjYDeS74dcA1EW8/DgioyEuMUmmWyn/kHVz5nDMbEIfijoTBMcCopHNnkp6GU/tvWfqtSK8RO5eMCEA9UufmKrdog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV2PR10MB6307.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Fri, 5 Jul
 2024 20:30:10 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%4]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 20:30:10 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH 4/5] test/py: efi_capsule: rename device tree overlay source
 to .dtso
Date: Fri,  5 Jul 2024 22:29:53 +0200
Message-ID: <20240705202954.1149590-5-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705202954.1149590-1-rasmus.villemoes@prevas.dk>
References: <20240705202954.1149590-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0043.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::14) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV2PR10MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc7fe50-184c-40bc-54b6-08dc9d31442c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a7MF1o0Yr4a4NP1Rcv2O1NWAcEu7xeYh5onZK1pOBfUbzbqdD6slOIJh+JWv?=
 =?us-ascii?Q?6N9s0gYH1KkgGSOG+hiZDIb5bBilfONI08cbKNZ28GwQyX2llxXdTIgxuaQk?=
 =?us-ascii?Q?ZegpBdHefL+AbKrfWFqEn3n+9JzIoNAgW6r1aGGXJCW3nQam5sghlDGrGTtf?=
 =?us-ascii?Q?UI7rIrbYoIGbB7T+VPLtSIV4BebeJ2DfGjYfFVRohOukQf3u91SRBINcOfhF?=
 =?us-ascii?Q?laRCAVybTydEZVJnbVIvd0c85QGT1xOCYnhkisj+QjRok/EqRPoN91zWXzBd?=
 =?us-ascii?Q?ZFCvzqH7vRgX3EWSnFzhwo1fy07EEMhk8uNyDHJpFZcpbvcUgKl1bS0z8qVK?=
 =?us-ascii?Q?nD1yr5QGxyx7BP81aoox9azmTDh98ScYpoDOMSdILaDTDzjIdpEv1Hrj7cZX?=
 =?us-ascii?Q?88DKndgXAuG8WfVPKD3/mdKep7j854BzoQd0kA2KInA+SkAeRbYFlgAGVWcC?=
 =?us-ascii?Q?cvL2iTPn1OPBJiukPdxd+62eyUpyveV9eccuCKefdRLlNAtMKL66l98K2p4X?=
 =?us-ascii?Q?4+xxzEGIQuDNdyVa4H7REHzuVh0szX0c74Ngqr5++VBqNVCGB10jjJqlJ2FB?=
 =?us-ascii?Q?4fjBx3cZXeomG8LcN2jkqdMPgIS5DFbOa+XMSON1dbEbqfMadf5Omqm45jT6?=
 =?us-ascii?Q?7zz7W6vd00NqgKVKJMtOQRhXB+tPhQ61N5JhhAuWzS8GNXKQG+5EMmvFpK05?=
 =?us-ascii?Q?SYYS1lsWDrW2w45pNfH1HjHMm3jMjmgv/8kg3u/Wv5lWRl74Ckrs9eXkfLPP?=
 =?us-ascii?Q?zQeLSiezSBfuYpRekJ39mgSGqPbSrMTKbyDJDQH6d9XMYGSyDg/k1Udzkas3?=
 =?us-ascii?Q?rR4vxfP3FFM0496y/ztKdav2bxhDO/8gRFdOUbaT03qe6KS4hJc88Tte0yK3?=
 =?us-ascii?Q?tpFVruCiwKPhOgueZyCZfXg06osGIBNXtdHl32b5wngCpPmJ7fu8SAJQuJiC?=
 =?us-ascii?Q?tyrXLZecP30mqVnAmLYlVc3wa+JnFrXoZHgYwRjU3nRafNLCVWy0+vSB2VS4?=
 =?us-ascii?Q?CBMMUEte3galb41jaI6n1jB+yCO0XJuWPGf/e6tkTfKqgmDp6m7lmcvaCHm1?=
 =?us-ascii?Q?kqPdyyz0RZkWbsSfQro0wmmMtrVk+L6KNy+gIqlfd1wKTI2Xex+Eakvb1nn2?=
 =?us-ascii?Q?dBOtqfzckacEY4eIxszmgzL4t96i9qztiLCC0Gk4NE+6O09YKwjSaJ7joS+j?=
 =?us-ascii?Q?15CY/2wKFAnKQtt0xkLw5zystQUKLRLCMZTqRRKkAn+qBSQqNnQB/YKQnGXw?=
 =?us-ascii?Q?1gILsoncuvJj0juP3HkLwLIvteHPRttRIFeyEO9E0eWTVPo2xEgNRrtDYY9e?=
 =?us-ascii?Q?h8x8rNbJgs8nL4EHq5XzENDtdJ2NZISw8w8su1mSFCE3iKe3TjO0KEV2XbGC?=
 =?us-ascii?Q?LIeFj5JpaRks5XeKUGAJwxBxUh/e2hLtQMz/ScgLlQIRHvCDeg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/43aRcFxFo1cEDLHYShd5KlCNEQv3PovQTi6jkaacd7K7G0msPGt2lGovxp7?=
 =?us-ascii?Q?tqO9XIHFLBbfTc9xo5E1EguIzB5ikQl7uLnIGPGwWVO7TEEfj2NTlHwvBeku?=
 =?us-ascii?Q?u5j10HfQrZGKJcmpLi1LIj6MwQrAik71U+7QYH/5hOXpttl3lGn9ZwyOAu3N?=
 =?us-ascii?Q?qPI7XG+zfyGxzHdXBc7s3MDGgObEeiU0IxeN6YT7oKPC0L2NrG/Pc0zpIWhG?=
 =?us-ascii?Q?mxDjI2a3Cib7y+peDARr/HdXHg3SAd6YQbrScEfPdoAcHyO8nLqOd3CbR06b?=
 =?us-ascii?Q?14HIrmdZtSbdO6ZTunF9hGiTrG80kgx/G/urn6WuWoAq6GYfyLnTw0ODBWhY?=
 =?us-ascii?Q?sv2GaZ4o+sxUuAfkxzPuuNnZ5KFu+wNdnA8Y7Vlwio9PyUrZfQhwf7TQezzf?=
 =?us-ascii?Q?Prk9zL0GZZwH2e32FJHA3YDZqi6zh3wbv87h3nN7b/P5tYfEPGTuwrmZNTLR?=
 =?us-ascii?Q?D9SzgElVu0LOlJ0k2Z2iN3oCWjz8EDG954NB9xwTTev89BlrcKslwgciPCea?=
 =?us-ascii?Q?q1gVh2YvHS18QH4hIK3lFrMCJehwCWkQejmtGyz+uBsLSc4UvwGakX9fV+63?=
 =?us-ascii?Q?vlsHqBqxJFJzjY2qredjqWi7l3DfcQiq+mlHUTvd1lle5hLl+weoF4JOyili?=
 =?us-ascii?Q?srxHYX2eyj0e1/5XvAAyr0EpL2vD8rasNJP2IKqagyp6iYvZhsLMV4E/M03c?=
 =?us-ascii?Q?l5WAIJw/H+dtuj4lOy/DRNcqkOHbrGo6VbXx97fqWAFIAZnQDrQMMkOQpZ9T?=
 =?us-ascii?Q?bot/kBeO+iua8UD64NL34oOkdXUAUC4rHgJWXaHDkF1EaJqv/s1x4aLTN3i3?=
 =?us-ascii?Q?JzkEeBUrnQoSCT3lARyJThXlVZTU8/5kLAX12Y8nVlFMaP4MTKBcRuAS0bD4?=
 =?us-ascii?Q?u8HYQcS5bHaw8FWy16W0q9ly7KQs30GgRlYj5wJ+12RreO7MwPywbwcdCIrk?=
 =?us-ascii?Q?ZBcfT3UBqzduq7mVnRTyLfUNOzx541zqz4f9a2Cr3puzCCvSLMivE9xg7qeA?=
 =?us-ascii?Q?4zuyLP2s3e0XxoxslfXh99x22uUCPZWTUC/FBXAbzUmh8je5q8xE6XPLYtg9?=
 =?us-ascii?Q?Vp/LYKHKxytGcOhJ/31wfWSRFrp98ALdi0Xt+VAlbXL3S22VsBI1k6b9FDgB?=
 =?us-ascii?Q?wGHZsVITN7OzPYf5iFM5/1F+RzvknfvMFplhpr7NOrirT2wFaADHNfCKIy35?=
 =?us-ascii?Q?WkMecbB9xqdGgTCUxIKoNW9tNQ402lAacc6F6wCpnOH2+bw+Y1f3/kfiNDsT?=
 =?us-ascii?Q?wLWQG298QH/scfSt6OAf133TNI53XfOo3Iu4b6w2+jIlPdbM2oRl7Bak4HuU?=
 =?us-ascii?Q?CiofKy/aBADWEZWTxZpCJlyuGRNCP4BwODHUYztdqPxu9+bnhPtvL6xaEFFU?=
 =?us-ascii?Q?wCpUccBGrPgT6oVTfo+p2YYny3x5kQvGi1OOKecgnF3yrFS3zNZw5KkjeI3V?=
 =?us-ascii?Q?IUjiyu0qKAc+k6UqzRKFUtM8F4a7OQ7Ql5K6cj+1DWbpVgqFERRc9PUiKJtM?=
 =?us-ascii?Q?avQHGFhEiW8vpcegO7T2Gqhuvir5Nqfu4Vjcb+nmwpEnDnILK7zUDENt4Fb1?=
 =?us-ascii?Q?eunHABZMeEzASxmpa0gNMed/0f76CPA399tYZ+VTkGdbYYIgBuyOabrVEIFE?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc7fe50-184c-40bc-54b6-08dc9d31442c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 20:30:10.2947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IeLhfcnezuJy0AMBSl1gQ7gtqjEMNuDJnalKuBZB49oNkcv5S3EAidINwTUOEqf2s9U6qMBRC91/D29YRN9Il53Dl8DH3xnHEXTkj6QUGKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6307
X-Mailman-Approved-At: Sat, 06 Jul 2024 15:37:18 +0200
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

Distinguish more clearly between source files meant for producing .dtb
from those meant for producing .dtbo.

Note that in the linux tree, all device tree overlay sources have been
renamed to .dtso, and the .dts->.dtbo rule is gone since v6.5 (commit
81d362732bac). So this is also a step towards staying closer to linux
with respect to both Kbuild and device tree sources, and eventually
eliminating all .dts -> .dtbo instances.

This also matches the documentation update done in commit 4fb7e570d6b.

Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 test/py/tests/test_efi_capsule/conftest.py                  | 6 +++---
 .../py/tests/test_efi_capsule/{version.dts => version.dtso} | 0
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename test/py/tests/test_efi_capsule/{version.dts => version.dtso} (100%)

diff --git a/test/py/tests/test_efi_capsule/conftest.py b/test/py/tests/test_efi_capsule/conftest.py
index 80b12977d6f..61eab5112a1 100644
--- a/test/py/tests/test_efi_capsule/conftest.py
+++ b/test/py/tests/test_efi_capsule/conftest.py
@@ -53,7 +53,7 @@ def efi_capsule_data(request, u_boot_config):
 
         # Update dtb to add the version information
         check_call('cd %s; '
-                   'cp %s/test/py/tests/test_efi_capsule/version.dts .'
+                   'cp %s/test/py/tests/test_efi_capsule/version.dtso .'
                    % (data_dir, u_boot_config.source_dir), shell=True)
 
         if capsule_auth_enabled:
@@ -61,13 +61,13 @@ def efi_capsule_data(request, u_boot_config):
                        'cp %s/arch/sandbox/dts/test.dtb test_sig.dtb'
                        % (data_dir, u_boot_config.build_dir), shell=True)
             check_call('cd %s; '
-                       'dtc -@ -I dts -O dtb -o version.dtbo version.dts; '
+                       'dtc -@ -I dts -O dtb -o version.dtbo version.dtso; '
                        'fdtoverlay -i test_sig.dtb '
                             '-o test_ver.dtb version.dtbo'
                        % (data_dir), shell=True)
         else:
             check_call('cd %s; '
-                       'dtc -@ -I dts -O dtb -o version.dtbo version.dts; '
+                       'dtc -@ -I dts -O dtb -o version.dtbo version.dtso; '
                        'fdtoverlay -i %s/arch/sandbox/dts/test.dtb '
                             '-o test_ver.dtb version.dtbo'
                        % (data_dir, u_boot_config.build_dir), shell=True)
diff --git a/test/py/tests/test_efi_capsule/version.dts b/test/py/tests/test_efi_capsule/version.dtso
similarity index 100%
rename from test/py/tests/test_efi_capsule/version.dts
rename to test/py/tests/test_efi_capsule/version.dtso
-- 
2.45.2


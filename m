Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E8CD2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 08:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A38A983B27;
	Tue, 20 Jan 2026 09:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="hTJPUwtk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5656B839E8; Tue, 20 Jan 2026 09:12:28 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BEC583A83
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 09:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFLsiWpAqqIP502//mHn/ELrHAsC9LsMoDPgfFi2dqs9cb6VKNHehUZlXc838Isd8O4CUph2YdAjb9rV0+7+vQTb81Npv7b4TtNkU2It28YvHNiAqTBit0e+WvxSgb3IXUZ+J3XvdLQvNb29c/DmY0hReKgLKvMpU69QE+aLvWyGg3hpERn9/9GysfBNbIjPdf72gqUHycMSiBoBu7osLlwCyTc3fbxIUuI+j2P04/G5A1Cmb378Q6ECVA3/tocdZo5cmoOj0RjhnTM8L6qAla+bGheWUdVv9TtYceRyhIU8eUTzXgqYd0xHdiUELBjYvFkI2jbvfxpXiTGkuzZSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAAaLDndi+beSJP5MVQYxRQ/+UMjHbVh0ybVT/UjtcI=;
 b=bGh3FX0JG7pwu860zMtLCUNkX0AgS6lsWiyBQX5p2WRxH0N66zAe71yun53+zpnf/JaoabOBLFB3lnAxXwD1A8agOWSsnMpBmvyxva6HAefFKr2g++LWb84V/3r/SFN69cFbe223M9EqcQADvhafdUZPsyZ5Q1Y0nfYi2612aVZ6MrtXvotHTxUB0foFDQc0LWFZt5jZo3h/OUcRKMm9RZoGbePfA14zfx+ppHC4VkdcuRDutYnrFkvd7O1+NRgT9Z35hWyVxoNSKRsKTQRp4fSul07DpsSw8wlEF7MLvtvVUQzsrQmq4ZCuh+29KOsjVZlbKcXOGwdvWPP5mDUldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAAaLDndi+beSJP5MVQYxRQ/+UMjHbVh0ybVT/UjtcI=;
 b=hTJPUwtkt6bnaEamZNGXwwH8v1a1gWFQ9I9/zVJNFSh2QyBSpDbyyFVeS3HuGo5EpvN0yoJzSGls4gjJn+dSFy1xyl79+Qa66YDEWWNCtxLhapI81JzQzY60NzTdR8L/4/btv9zxEFEwyCoX+HXrNRGj8gKG5jehAJIGRjrK5D3p2I+VkN62Acjp2mYrhMtc/GkivZEqkyYDsl4O5M5uA3cHX7yIa+xcV2jdbqf69t4S2k2WUgSamUHf3oOATezmak+ZKuoaALJe2E6nAezdEptnpc+WxVzR6ugu2yQfI8dMH3fNjD7WwtmVWv/zkTgFo0LgSQbBzpMFjjQTLBbgLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by PAVPR03MB9116.eurprd03.prod.outlook.com (2603:10a6:102:32f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 08:12:24 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9520.009; Tue, 20 Jan 2026
 08:12:24 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, trini@konsulko.com,
 simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v4 6/6] test: binman: Add test for pkcs11 signed capsule
Date: Tue, 20 Jan 2026 09:12:03 +0100
Message-ID: <20260120081206.251544-7-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
References: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0049.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::18) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|PAVPR03MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: 329f9abb-c928-490c-c15a-08de57fb9f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014|7142099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AolTM7JZr+l8ApBEecn9EaDYzUqCU3FdVZEJdloMUaQQdJLJ7Pbr/rY5Fdkr?=
 =?us-ascii?Q?h2od2t1e/MoYa6dL4TcvbxOvd3Zsm888uRLMBhlM1vmEjLotsCs+twZuJtfV?=
 =?us-ascii?Q?u+avLfXLuWbF7f3w3Blp4mFPfcAanW38D5aboQ3Xu3QGgTge4/z0kBYAjgvr?=
 =?us-ascii?Q?wr8QfJ5beiLJt126wFIffL/jQ8m/kHRjxauP5hpCYCT8W2SS9RcYazOZHG3u?=
 =?us-ascii?Q?TLQhiP7nOjO/5DUuAgfGuat9NbNJMoQIPPIcicrKOhdWF+mXnDjf5LOYzaki?=
 =?us-ascii?Q?jmD8i+L2G15VFguHLGsS3IzWuQrzSo8yLQko3lY/O+YD6PZ8gQVQd1rJy7lh?=
 =?us-ascii?Q?xI4qTGCQJqYiBps1a4KeefrBTJanRy3/7dZVsH/xpxd57+p/3K5yJNYci9u6?=
 =?us-ascii?Q?VT/cbdUcvZRUAJd/T8daY22Q2TKt+1MEPHZBYPqzV9N4UtcUF4y0sk8xWNxR?=
 =?us-ascii?Q?RYIWM9Gr9Vk1PJgg1DhSoMhGLrrsUbcPO6jx3dWf4JThfzkNK+Mid1yVyFUJ?=
 =?us-ascii?Q?wIKAbFjsR6m0zxffgjR2Y3leelso/SPWB0Ee2d5EslnAfwt/dUw5ibyAaDje?=
 =?us-ascii?Q?E2Vy9pkgs6hjVQ3yWz2xwOLgDr7nWyN0ac8zKGCokGjGq2c4M1H48EAtyefK?=
 =?us-ascii?Q?SRsZfSLAxfY86pn9dYdi8TF8PPyjbG/iLGAp5Vu5uTn4nxsPdPgsI0HPzqG/?=
 =?us-ascii?Q?6rzrptvMUxX9tzPnld8hreaT1FQUaa3o4zTMjgxdGXq2XNL3wbmiwN8wEROl?=
 =?us-ascii?Q?brxZ38juhzMVY2phTkZGY//wT1ViB3RBbAnsBNnDFcFa2kuM5bY71rKl40Bh?=
 =?us-ascii?Q?KggpaclBvGjQXoR2CgZMthNF0t8vzV6lcQgthErnovEsr3ADMjS9BFfn20PO?=
 =?us-ascii?Q?aqnhXsveEVWTtvBMNAeEC3n71DiibpEMq5GOH0QN9iLJ7A9AH9PABZ6Fthiy?=
 =?us-ascii?Q?4YlJGy029VuA7RZT2vaKq8E7AMpMV9XT7id516eJgFdCEE3CenSt7GVdIDcI?=
 =?us-ascii?Q?8vz0oI7qLqYVhv5dIB2+yobd2owUB3V4JuLj2TeKeSQPoc+89ejfSWqVxB7W?=
 =?us-ascii?Q?QnVjAb6lR2lM5fecUSHxMI3x811tqjoUWahcGptHMTryH1tgAGmoMOBu05dC?=
 =?us-ascii?Q?0gS5KF4AA7QrbmQmhuynOTNRK1sQxnjMcT1S0qqNaChkot17t/RDrSWnzZZf?=
 =?us-ascii?Q?l7ltVGxDDmarDQE25Se5ee9UGZfwSfXquSSsuy9wLqRqcvHzUQIb16GZBmSz?=
 =?us-ascii?Q?uqLoriJU7wo7O2uWGAqTbmkwdjlAgx6dvN3fUtmz4kr2XI6kCs6XE4xUyH11?=
 =?us-ascii?Q?d4eOjo42qO3sAf60CQ2z4oGrWMJOygCWLr3wc018fFkdxFifeyyUeuIz7fbR?=
 =?us-ascii?Q?3JiaG0c/ATNNNFB1zxI26SCWSUffrjLmFAJ88zUPKMqN1nrbb4K78sxgju7k?=
 =?us-ascii?Q?sKAALbDF5uMm78I4WA+sQ7ZjIybI35yw1heFqoP1thcDcJirE5LSGQMdl+A3?=
 =?us-ascii?Q?Kii2aii8oQSLizhIEonzHfavAO3KMombFwMXrwNhKv+wQJ6YhmiyF4oPon+P?=
 =?us-ascii?Q?KgAY6pwHWFAtZQ2QTG7DSZZ03qTjfBUc+yZIvY8urmPZfipQxHMki+YUHGTh?=
 =?us-ascii?Q?H3pmqeNZvfQT+D5UAg3fLzM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O5M7S0Vb/c5b6ALr5iUNom5unIcekoZLP0Z753cNZ1J8G/J5oaaz7vzpEiEq?=
 =?us-ascii?Q?kgedJ+c0qzJiSy6oLWbizL6rLphOlCJUEXv6m3w4WY3qTdxJ2A/rI7JgGr75?=
 =?us-ascii?Q?t2AVKrcTrVHPP+sWi6BKejzTaj46fgn7gMDLukyBanjIkE928nsFCoSXQjyP?=
 =?us-ascii?Q?dyZZ4Vgg4PGNQpPgEntzov9YZzmzE+1vqXg/1GfUPXhYBcK5+PQ1THPbIE7Q?=
 =?us-ascii?Q?QaYMZGuIFl8MFNR10ZAdHbysazz+QovfArnl5WKU6SpDuSWzsQoqnuOsYlsf?=
 =?us-ascii?Q?HQpD9QU24BwI4sO/v/aZJwmuTpd5y9Gq0joREYUn15fGUEgjxXh1c2Rod+hQ?=
 =?us-ascii?Q?m8Y/vKTslWCq/IG6PD5mYCf5BzRVenS8Jqu8ThAMcoqdfRYmg6+nWCAjkDU/?=
 =?us-ascii?Q?6ylG3s4IzscwYceD8Asb/O9kV1hZw9v+rZgLGxMy8IDV9QOMfUdWANHDJffN?=
 =?us-ascii?Q?AUMhUpiNG5nw7A4y8H0Vq4oerW0bkiBhvph1dx4Y8LPTRPRJQbkYox89SvI9?=
 =?us-ascii?Q?y+2+nqBFjg8sgZfknVqSOgoS0SbZcC3HJ+rwchz0MJ7w6s7dnDR4aCifze2S?=
 =?us-ascii?Q?3ABsmOSZT0R5L+LvBk0VC+9ZmlEDBf/wpTbwhDOQsOwtkg4zUgBiHTEb4EMm?=
 =?us-ascii?Q?wamTft81U5VeyhM108Ow9FiSNjV5arT0ecK5jo/ccR2AeaXreIs6Z+jXA1xE?=
 =?us-ascii?Q?yNA7P0t/FrmYKztNu50kDSUO4cWpbsGnb+HsDi/hT7waUa+XhXt8TWI7iGEC?=
 =?us-ascii?Q?Cx02CLcAiqRvyOzJqdgPfBN2kIlSXnA/UD5NPLgeJ2+MbqUOmoptYSr4HmXH?=
 =?us-ascii?Q?IebxRcIccpc9oKhtLdD03b/ju7kswxRAFzo0Dsb1ELz6zZS4uRQR5sNgQ4kO?=
 =?us-ascii?Q?+UP7qKLz2v5mJXs4LEMr5Cj3k0mMHIwkjDl3ofFFNGah+UM6CcQw1EXAihEW?=
 =?us-ascii?Q?RzaE6IOQIYypZ7mEmRC96IPD+o0cM3Y++FesMvw4onckA99+8gMvXNOpRk4S?=
 =?us-ascii?Q?qaMkX+xDa2rKm5Y3Nzw+Z8JFXsICoefpv8/X4ms1/xC8K0iQ7VBvMbPB1EM8?=
 =?us-ascii?Q?K9Fbsgel3T8hhlUFOAWeku8uLBB79h+UKdAB07QHUlDpla00B0u3yFSliGa7?=
 =?us-ascii?Q?zVvYgHVsYbiCqmjceSkSdyFUThv3tiN9BT4Za2zFcuDXmFPS8WuKrZA/nGOl?=
 =?us-ascii?Q?tJdl23hCp91iSuNXC07/w7tEZMX/AG9jdYFeVFNhJx1ETjsmpCQpxoVC4kmf?=
 =?us-ascii?Q?4/wOFeSZyP8ExA4lb/Ikgb3VEp0kk8LpntSWiQrMtyDDhVVTp3xEhBZ8hC+Q?=
 =?us-ascii?Q?Qi5Jq7rkOq0ogMb3AmKYZj+6zDGI/bz+hUaSIMMJ1AIzZ4REVhoAdyPqDavD?=
 =?us-ascii?Q?6m2qNnRSMZKCmZdp5RqhNOgKO7BP8viLbVQPIkQVrENdTZHMKMk00h1VlC7n?=
 =?us-ascii?Q?0ZtgUFZls7J9q96MMk7HhVE0KRTepIa/NotSn3vRrcpn5Gl7aKoqtRk2Lz7i?=
 =?us-ascii?Q?mhprfFSUAKCrRJcPvbo6XJCqm3rV6MSCCE/S4x230YgH/QTCWHdLv6ERUvUV?=
 =?us-ascii?Q?F4nBerr9I2X9a1r2aEOWq9krChOoU8z/y8N6XTzHvQw0UlBd6VEdb3m4kzai?=
 =?us-ascii?Q?p/GgrMc/3MDUL3FaJcXZPGlVWHPUjckm/SSUI3fSZN+LTUVFxgwmGfTW/5iv?=
 =?us-ascii?Q?Hrv+Za4H+PbuhmZMD4Ga7sCqedxk9eKLsKiIKQGumrRuiMEbnfm5e6TFt5+F?=
 =?us-ascii?Q?mL9sL8wPzA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329f9abb-c928-490c-c15a-08de57fb9f82
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:12:15.8490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzubdNOVx32Sik/sbhDUoiia/Px4RdeaMh540tbw9kVKUCkycrIlGfd9SlEkkuhBd3BtojrihaQCmdJUgIkomw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9116
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

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Reviewed-by: Simon Glass <simon.glass@canonical.com>
---
 tools/binman/ftest.py                         | 53 +++++++++++++++++++
 .../binman/test/351_capsule_signed_pkcs11.dts | 22 ++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 21ec48d86fd1..a005a167e414 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7,6 +7,7 @@
 #    python -m unittest func_test.TestFunctional.testHelp
 
 import collections
+import configparser
 import glob
 import gzip
 import hashlib
@@ -7532,6 +7533,58 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
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
+        tools.write_file(softhsm2_conf, data +
+                         f'\ndirectories.tokendir = \
+                         {softhsm2_tokens_dir}\n'.encode("utf-8"))
+
+        p11_kit_config = configparser.ConfigParser()
+        out = tools.run('p11-kit', 'print-config')
+        p11_kit_config.read_string(out)
+        softhsm2_lib = p11_kit_config['softhsm2']['module']
+
+        os.environ['SOFTHSM2_CONF'] = softhsm2_conf
+        tools.run('softhsm2-util', '--init-token', '--free', '--label',
+                  'U-Boot token', '--pin', '1111', '--so-pin',
+                  '222222')
+        tools.run('softhsm2-util', '--import', private_key, '--token',
+                  'U-Boot token', '--label', 'test_key', '--id', '999999',
+                  '--pin', '1111')
+
+        os.environ['PKCS11_MODULE_PATH'] = softhsm2_lib
+        data = self._DoReadFile('351_capsule_signed_pkcs11.dts')
+
+        self._CheckCapsule(data, signed_capsule=True)
+
+        # Verify signed capsule
+        hdr = self._GetCapsuleHeaders(data)
+        monotonic_count = hdr['EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT']
+
+        with open(self._indir + '/capsule_input.bin', 'ab') as f:
+            f.write(struct.pack('<Q', int(monotonic_count, 16)))
+
+        try:
+            tools.run('openssl', 'smime', '-verify', '-inform', 'DER',
+                      '-in', tools.get_output_dir() + '/capsule.efi-capsule.p7',
+                      '-content', self._indir + '/capsule_input.bin',
+                      '-CAfile', cert_file, '-no_check_time')
+        except ValueError:
+            self.assertIn('UEFI Capsule verification failed')
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


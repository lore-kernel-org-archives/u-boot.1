Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58792C47BE6
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 11:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C18E83F64;
	Tue,  6 Jan 2026 12:11:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="DVPr6Rx0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9268083952; Tue,  6 Jan 2026 12:11:16 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C830F83F5B
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 12:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePVmbtZa3J2xzMMzwMcgsAmtfPz/pf3HeVVW+6tdOaUVOtqdhVpFqieGlTbjvU5yoonfUA6BUxhtKJw87fBOeCRJFbCuHcxFmDBNtTEQMezNNUbdeQ+Sk6XHUeWiLCQDwDIm2kxNzEGns3JQ+iobcyClvU3olApe0YgR78/vB8JnEe5IgjBjhF8yR1s6pP1fB4xL0Gc/6ivKKX8D2fGekfaicDJBR56Yf5drMHzQKCmfE4DMmTmlwo047yMOJYoYM6krXv2DLo/o17HDaDOl6P/ZIx83lK2FpC025KpwNZ2zYei1qNleqlkDkAHszu4nZG+cFt5qUMhbFOqz+6qa4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTECza4TDyey6WRpo3rQfFhBKAZZ62PnaTAYDNqv8FA=;
 b=RqaTKKm8eXcaVuGmr7dTxELtI3aVnf10yhmBhHu2EgfOLr7fKxiaCUVpKUYXPECV4FVFs3XQ3eF2gRmJOnz63q9V7Ta0XqUUrorRbtyvvx2U7we3AouZwZMrqvqFnjJ5KFZwuSSQnzduBA9P/DlbTGc70seaGXORpVB8m6U5HB51Jvey11CblnIr9R0wD5c4gXT/vL2Llq4g+d87QCPljLLF+fzrIWjbZtYFeJ91C+ji8zZPQikEiy56M9TmrUBOP9skpRQJYT8u5+5g2DSWNKQ+XaGRq75z2PhBwyh+B2bxr/ypMPhe2siyGj+TOAkl9EW4K9T8eobS8w992VAoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTECza4TDyey6WRpo3rQfFhBKAZZ62PnaTAYDNqv8FA=;
 b=DVPr6Rx0iKRYdi51H9FaQ/NMiOw5MBLRdQPnpvI0/d8BhIAHEXcRVvvYKz1NdmeMD9GcHtPdinNM0XtP91ZGgC/E8DsjH7GrC2PSpgWYAZVAxLLHTD2z9b9zqrmrk+iVBHKwqDudaDHW71p3miFvl5oyYYhiu4HV3K2qM7YjCXXOz32Vjf6Y2m3E29yFgaPf//sQ+ZKM3WVzemdwhHFO89NAf2ZvD8wxR+k79f+dDfatrLiwmuXGuxh7fQX0OJ7Hwl2/RMyYnD3nnRjqh7goMBNWSFaXqkzBpj/3ASLn2MDqsbggQLFt/Ud9Ve2Hx6QHl9o4cn1OCDTtY9ch7bhdcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AS8PR03MB7302.eurprd03.prod.outlook.com (2603:10a6:20b:2ec::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 11:11:07 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466%2]) with mapi id 15.20.9499.001; Tue, 6 Jan 2026
 11:11:07 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
	trini@konsulko.com
Subject: [PATCH v2 2/3] binman: Accept pkcs11 URI tokens for capsule updates
Date: Tue,  6 Jan 2026 12:09:58 +0100
Message-ID: <20260106111034.889964-3-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106111034.889964-1-Wojciech.Dubowik@mt.com>
References: <20260106111034.889964-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZRAP278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::22) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|AS8PR03MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ee90e8-d4d7-41a5-1b0f-08de4d144a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OOICz4uXt9ineSc68XvSic21Og6H+XRtTyZv0OnZrTJj0hY4CG1ddrPeHZWx?=
 =?us-ascii?Q?LMgSKUtxn1j2AFxB2t8GyrGXHh5IAvuebGgHV2pYYzwPk5z8d9dvWAp1qRcb?=
 =?us-ascii?Q?M42StP8lcdtUX/iU0hpEGLJqZN1Obzy/Cnn+/9BpFGPP/5reanGiDL9YCxEr?=
 =?us-ascii?Q?+HgQ8d5IwIX/6gg4vFmbuYqGBX+rC8NfZQLYpBOiHHidngWRtalFHOgX4zHB?=
 =?us-ascii?Q?eU3dWu3UGtHkXlj1XmfmjdGTSLJwZIdqDOByRX6xU+lYMjdNlqer1LK90ekX?=
 =?us-ascii?Q?V6HLPIuj+qa4urzhTTLqRUyeaAyFHwIgaEzJRu4tp591hmlpjPCMRX9jvabr?=
 =?us-ascii?Q?yjqPo0gGoN+HVSh66HPJayAfboZEpVNgPJ/oB8v8d+u8EMhtTFgoXAYdHl0y?=
 =?us-ascii?Q?rsZwlq5NOPZOOFNGVGqa9ayd4TumuapVRhlrPdFVO2HZAnv8EMGV0MQYMP76?=
 =?us-ascii?Q?lTrpWdeqNjg2t1QFPHg6nTqHGFtyZY1iqd+LDFQAVvpHE2l3hfniWFI+gPbS?=
 =?us-ascii?Q?a9+FzyI2PueYh2nVfihxmBGw7bBt0QakGJLvpIkIPABLYwpyMM2epdhQ19Pc?=
 =?us-ascii?Q?oBx26dH09esL/XgtxC/GimJtlPJl8qJyESm1nSJA/aWdEikyV2HPmhusIeSD?=
 =?us-ascii?Q?IH3NCk34LZ0/AFsdx68EQ7A5OrvUzbmIFx+v+3+y/OQljACZxtV8sr3Y8qC5?=
 =?us-ascii?Q?SlivzeKuveq1avFq//CmyNOvvLV8NI285AVIMlSDvpszBjzG+MNZqVzkfL75?=
 =?us-ascii?Q?dbx9Ix5aSPpGmC0wMMkV4qlzoLMvwH553ymhRe3UIJZWFitLqTIcASmmYYhz?=
 =?us-ascii?Q?n8Kja9ZeTLIO25LjBx9g6hta+EioOPGJn0JA2l3wTXqESHFpxxSxs1XDuVuS?=
 =?us-ascii?Q?5BgUv+wqwnpgvTH3n5FQa99EMLz9z32QVw+rC1wISxq3PyvO8JzYOGMXy/yx?=
 =?us-ascii?Q?nHP4z+GRzw+2kyCj53G2xRadwB8netBhwsnzDfOg442uA9TxECsQHrLpESLC?=
 =?us-ascii?Q?Qkjiw2uPIPe28ifZE6Xt1x/vEbThLuMHlUwLcwwIKfWvTMMPf5FAyR6rExRq?=
 =?us-ascii?Q?TCtEMnMmvQC8I7MEMP5U6I4MA6wKL7byDxhha/wD31GiFiG2ZApliVEJptC0?=
 =?us-ascii?Q?bEvXQS+UNa1d/Pe5E/9tzE4Gp7SNTFLQyd1QeXxkuz+9UIeDLmpsZ2J+q0lM?=
 =?us-ascii?Q?op39QwgGPsFWLFCXF7NnJ4xnZhQup8me/FIPB/ReYwnbc8eEFQAFNzkaRAT4?=
 =?us-ascii?Q?lRjKDzWSnGafvk0QsKXVr/Eup44Vw0FJYVVKwVLP5qDhIb5lemUl61kWqogR?=
 =?us-ascii?Q?gIRZFA+HlmoQ9tzTIbWyO7ld0YPt9JpUNe0M+H4k9/Lrvl2390I0J2sq9WRc?=
 =?us-ascii?Q?ibILy9HN9VNp2SRjwkp7sxsQJuBWBsZ4HWOv/qWmfYqwLnp2VFO7muT9CKJo?=
 =?us-ascii?Q?/+cNOFi/UikWAF2uicJbji60qF5IXXYQsA+Ay+FRIna7MYWOgqFAbLOt/xNp?=
 =?us-ascii?Q?1gHEqkfXSjDSZQ8+1AGAJPBDivnRyb7dE8pl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eYN6JhL2YhFAQDZ0yZGe94VRKyaoIsVMLzHL/pRhJH7Y1pJb4JV7pSr7Z15+?=
 =?us-ascii?Q?1mubgsexfJUK3gcCsRjyorgkAxgcUWE/vKhJb2ZAmBl1/Ff6FGskU29TNWTc?=
 =?us-ascii?Q?uu8ZV0rYqyt3HSGNt7stCPQhnm5zXis9PkkTK0jtZ/lYxxOm8r9zBQc5vpIN?=
 =?us-ascii?Q?LuiL4JTY5v7pz32kjM0pN2sstcU3xATnSvN4uXMj3MsnGsLwnIlUfDPVUP3h?=
 =?us-ascii?Q?hA3V7RaH1XP0uf457j5PAoXVgO/xy5kDtLvG1Sh5I1O/mnXUtHfmwyCT69J5?=
 =?us-ascii?Q?jIgnum5yde8qVSeQGkaeUoG8BpvG9m7a4QNIVGCOy2ha55WKNHL6i2ctKsQ5?=
 =?us-ascii?Q?9QDyMri2oEa9cPfHU1oSZYw1R8DiHutSCB+HD3B0jo8gL35fKp6lj3GNgxSt?=
 =?us-ascii?Q?DGOewUgPgLZoTWlilUgLnChsaM7ESG/scSzXTQNRDChyVFFp0oogcMHTO6QF?=
 =?us-ascii?Q?MNMSzn7itDY/SqxNBwF2S2frnaDPOChFd+kAs/PNR3CduQik+ylSno4FD46j?=
 =?us-ascii?Q?eVl+cqdftMLWOqJN4fYO83LNK5a6kiYWF0e66+r+9WUCdJFh+/L+NCPM2rfC?=
 =?us-ascii?Q?vqcXMY7tUzOcsQSGHd+JEw3hMVFh5+dBOTvgWgsov9Jc14nVfuOojm02DRr+?=
 =?us-ascii?Q?12zShM3xUVUo1AT/4Idv6Az10qrZR+kIXIeoRxNqFKJdDL8YlkwJDbX+PaLA?=
 =?us-ascii?Q?vbfOIBSNP73U05zzcUROySqxrGkHTIE23pscwuuiEaCDsstMI99aEPk5YUVY?=
 =?us-ascii?Q?fKeH8jiB9XyLaou0u4bKCLK5MhGuBTwxMVrCZ7Ie0UHnkAUXlhWuPT77280o?=
 =?us-ascii?Q?cslHGAvJ3TZOeRzD4pSsoddEd+lpWO8uq6j8EoWfWs26926+p6qZkgWLrmHb?=
 =?us-ascii?Q?fZ5nWOELGkAi+q/uId3CRD62p8hghO2UgSXFjgehHAWevblC3CfPUuTiWW4X?=
 =?us-ascii?Q?T/jYVce2Z8vS8XlCI5pNG4+g6QlGy3d8Er929lX2tL1dqXFx2O/oT03XlIaI?=
 =?us-ascii?Q?Xqwa/0svYEp+RnIENd2sT9Pg36GyqBR8tD2emwaa2kx4lbqT4Vnnpq2gQI7Z?=
 =?us-ascii?Q?A6XEI4l4ydzLFLGT84VznV4VtL2qARNRrHb2zKdXS4MyTxkZjw1H2yzLuyrK?=
 =?us-ascii?Q?eemXDsHIF2GL4OnWheb0vLcaITXxpy0DZ/WnwBMct9FSOOD3h3lYLah26T9v?=
 =?us-ascii?Q?FwC+uWfcNLPl0TKJPtqrLhtmkMbuBU+PufsrI5MyX4zDxPaq9sEFzo8BbF+w?=
 =?us-ascii?Q?0+QJpeF4Q3EEcxul6C+eKPoxHYt9lpTvwuERQQD931H5nMmJ1b3WGRYfXpP5?=
 =?us-ascii?Q?utMNpjJOnwZqBUGCv969/ik2K/qw7sCKtfFrtF2UkCthOX3JXJExsl3R/wLZ?=
 =?us-ascii?Q?2ZqI6zMr8DSYSxrcDCSpRGm+VcGBglEgWt/aPlg19f/cZD71WN64PYCsr89q?=
 =?us-ascii?Q?nwr9SPl8+b3HgKylecAmvy0QWHdZISNRCt9XiQQAEX3w37QDTVMH1MDTFjmL?=
 =?us-ascii?Q?1burtQHboFDAUy/3w8z5jr9GeGyJprMxeLKh1iFhbOdQgJOgvUgHbxGCCUqi?=
 =?us-ascii?Q?9Mi5zOHSSnziWICh+wyg2NLV4g7fD8wmMHQv+IQOQ0qFORAKEIEPht/aWRzo?=
 =?us-ascii?Q?KEATGcDFqLE+wt4mDU9u8Sil0+o/ux8wN2t5z6nUUDzYber3xRHsyfePldUP?=
 =?us-ascii?Q?vqeIYg9G22oUfxIipaCi8eptpIrBIcyAX3naI/yeaQFLmpLSSwoGF4prORkV?=
 =?us-ascii?Q?xAS+a8mvpA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ee90e8-d4d7-41a5-1b0f-08de4d144a36
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 11:11:07.4024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBZ/fjJYvWruMKLsTfYM3rmzrWBC7YLtLK4OaHwQ2NIBMV3i9ypVgBo4TlKJgozGB6YBbg3PJN1tSZkaYoANuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7302
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

With pkcs11 support in mkeficapsule we can now accept URI
tokens and not only files.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 tools/binman/etype/efi_capsule.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index 9f06cc88e6e5..3b30c12ea514 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -125,10 +125,14 @@ class Entry_efi_capsule(Entry_section):
         private_key = ''
         public_key_cert = ''
         if self.auth:
-            if not os.path.isabs(self.private_key):
+            if not os.path.isabs(self.private_key) and not 'pkcs11:' in self.private_key:
                 private_key =  tools.get_input_filename(self.private_key)
-            if not os.path.isabs(self.public_key_cert):
+            if not os.path.isabs(self.public_key_cert) and not 'pkcs11:' in self.public_key_cert:
                 public_key_cert = tools.get_input_filename(self.public_key_cert)
+            if 'pkcs11:' in self.private_key:
+                private_key = self.private_key
+            if 'pkcs11:' in self.public_key_cert:
+                public_key_cert = self.public_key_cert
         data, payload, uniq = self.collect_contents_to_file(
             self._entries.values(), 'capsule_in')
         outfile = self._filename if self._filename else 'capsule.%s' % uniq
-- 
2.47.3


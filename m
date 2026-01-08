Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B97ECF6ABF
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8781C841D7;
	Thu,  8 Jan 2026 15:14:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="gVMmpovs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ADFD841D7; Thu,  8 Jan 2026 15:14:12 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49B9C83B72
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:14:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6pUx5rLZaNyM3yxjkNb3j2SXWE1WZPNL9HXtIYdOPyeEJwrqI5o6WoAUE0Z9FpFKt5daZDdSiTIgi6wYQNuacfS+Qe2l0McRvMZTrtzEcr5pPWVk33X2gkKcibjANRd1nRlG8J2KVzMb9BlBOt9+fw+5lN5GHr9r+bIh5UtwW9iFLxxCGbDYXbDkgzdzn6cj76C2HjcJFx2ZNtKVeJGeEfYO01Nb0vbq51O2+0+tV7GtiLLeKJkYhGAQtgqi8pT5vcxuvjB0dHsxhaTgAShTdq/q4WO9f172H5UxammmbK/w5tDQTd87o9y+BDXz9uKuvAh0XBNUnf7YcX3refFhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4ndap8nGdDraoPpBOBCj6o3I0A9b4+6cnWMrySVcM8=;
 b=ZyAiu3K5vYrna+DHfBVLK4ZzReVxkZrWnCvME3wb17o0k+hT73DO7DCmst/q+4XJ4QiSaS/zGkKw0JEe+P9QskDKO/nbYpk4ba5O+NvsT2ZUoJrtxfWWxnWOtX+Li6mrefHi6TztyXQbsj1/DGXAAUnuGbOW0RTkXOvWJnlKEro0uKzxcFNT1jYZBbasjv7kYT3iIjrGsssQQOOChwwJaELmHF+HT68pRuiwEdZ94Co4ctOAqoAkVF21QTc/ZoD32lOoWt2H30xGJXfuIx9ZM4era+ANAjWAkbLbmqhhloamc06quGa4QQNDM8moUcWZEEWu0m97Nco6GtsePAlPRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4ndap8nGdDraoPpBOBCj6o3I0A9b4+6cnWMrySVcM8=;
 b=gVMmpovsGlji//Xf8Gi5+HOKG1hPwPljuJCZEUNR1dDdB1/YmFlsZjBBHZnQP+fB2EUVaRvRtdUBzHTCNWWCNfje5ApptuprLx+oOPxaFGam/9cKqKsNiHcEa4COLEhnlMpPq0sVcGUXkTpslVzdpdAeNkTtjkYZaokcX/87tO92dXz18S+1R5N7Q4Dtojkotg6gfQI7ZSlOO2lIOEabb6bkP3JOIgTU21X/sUSYrca4HrAvjS+rxeb2T43u0kyQQXyk8KQqIeGiXIgS0YJOxHeFBE0e+GVljs0D7cez1baaZ8vDczjKJ0VNuinGYgm5cejU1vLubhBfmYQ7up/ftQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AM9PR03MB6836.eurprd03.prod.outlook.com (2603:10a6:20b:2d8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:14:07 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466%2]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 14:14:07 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, trini@konsulko.com,
 simon.glass@canonical.com
Subject: [PATCH v3 3/3] test: binman: Add test for pkcs11 signed capsule
Date: Thu,  8 Jan 2026 15:13:44 +0100
Message-ID: <20260108141346.1663305-4-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108141346.1663305-1-Wojciech.Dubowik@mt.com>
References: <20260108141346.1663305-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:610:20::22) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|AM9PR03MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: f11b74b3-0f6e-4cf0-5b19-08de4ec02fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|52116014|376014|7142099003|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/Sn+mtlwEtHixJ6BRQ97SsAIea1tmYxFRG2NmR/SRMnTuXWV9AO+QSBmZ8HB?=
 =?us-ascii?Q?fU8cyZxJE69CbTgoBGBQ1GcGps5VB0U2GOfZk+BgDCuESVd+BBtt8ujpd8KB?=
 =?us-ascii?Q?QO5orcfDocJ+P6Cv+rXfBviqahg3KcpVm+7b1Jbqw/UnMyEeyHhlnlVc7B8r?=
 =?us-ascii?Q?1v/tyqklmtiYumxgvkPvMgXKBVN3VchkNviXosofSdb+apsaZJdiOpgVjcUC?=
 =?us-ascii?Q?LPNrHih9na/RL5P0OM5T5S4Fw7aemv2jnBxIxpEcbGktr2rW8T9iaBZXu46t?=
 =?us-ascii?Q?hKr8ESnFlidqrKmx6kfqF24pYmYUUboC1gLSYhosq/qNX3NPjJggrE63xh3i?=
 =?us-ascii?Q?zuxcBIclDvgTRpR3Pi1VWQmMUDhmUyx3TLehQQ45FEIlIUwjAE7sK8fAFAK2?=
 =?us-ascii?Q?EBimeuvg2nlPKPQUpD41MIKrOMXUIyFF2kD+2gXa9Fd8NOMkk3hPT5gtFzsQ?=
 =?us-ascii?Q?CuIXDW6v7ql+jHU2prIUWw62boGloXUqlGsNMcnEtiUyuHsDaxjj7A+iKlQ4?=
 =?us-ascii?Q?Vt2Uxs9gLC/XcAiiAfospObvWGGgRF2Dz9mebO9Vp3evHhyRqf5+LB6BdMZt?=
 =?us-ascii?Q?onsMSbW3zP/7mrEahpmGVZ81xQq6BKbE5lphdPJw/3KQfE00R9Fpb4Kib40d?=
 =?us-ascii?Q?BX0rKCP7nvptEkmQN8rkWF2o/qJWwwGIV/HixIW2E6akVzv4jOrgGLPyavTY?=
 =?us-ascii?Q?0qa80u5y/YzEJOzbVwKZS43Sf4GS7vYWun31JE2KR/sPmp7+ZNrZpsK4h627?=
 =?us-ascii?Q?XckHnRyedQuTllzgeDyyYCrgbyDC6H8Y9HH1IOEo+hyyrFMjVb5cHFP4Uznz?=
 =?us-ascii?Q?i41GxAgs62jEXp1NmjQU2KVpXY1vdjudRe7JKtG0IfXdpLYkg/ToC06rQdWf?=
 =?us-ascii?Q?YedNjY3S5b0z52PLyi7eB3TcU5ECdITu721L4aJhVa96MYPJkuxpkT78g3CK?=
 =?us-ascii?Q?YmOvQgwV3DLy46AsmERMfCjQMGI0DNVj58VjDtIN6aJA9R7kvYYu8uenPqCx?=
 =?us-ascii?Q?yNDGuwdy5n/0hzPLSQx1XZqS3YpUQRQfiHYojMRvgwTiIWfaKym+5ddMMXs+?=
 =?us-ascii?Q?XglS+pTCg72QxlulkBbEAiM5ArIJo/9d/hxOzKEM6uzdiQc0ADtpFkBmUjuk?=
 =?us-ascii?Q?pf/qBoZwXPqwnam4NY5XUCK6DpAlSzAH3POVlWoa/fau0x+LJ+UFZSzYw474?=
 =?us-ascii?Q?YMwAvogoSnwigRQCtz+5Ac5O4ub5cd6Cb/9c/h1fKjYAFHOfiVsDf+GLjjBA?=
 =?us-ascii?Q?8zbsP+5VJg90ebj4IGFoU6cagMxp0pXddHI0hXw3Y8Quj8jL6WNanjKIrS47?=
 =?us-ascii?Q?yahVPDh9WJ8dHBL2+3X5qQjf8ymJB8DB8sGYGA7gnVSALK+sH25pozb1RTUO?=
 =?us-ascii?Q?57/pdSM8j6JDnHZCyPtwNfkSE494yR98nyEtj+6I2InGpnkiLIDaOEljbHQr?=
 =?us-ascii?Q?XaPXwM7XlQnABnDptcepQcVpxAACVDRr93QrdNr6oBZB1z7fF0diGgfPL+fq?=
 =?us-ascii?Q?fqtEdv7fyo7pYT0N1lqhcMi6s0kF5mTEuFvw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(7142099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5bLbzDVaOzAc7pfNZe8Uj7NkcBD0FhbH6rzY2ZBHXgTKV8J5ttX3mQ0XxIBf?=
 =?us-ascii?Q?joRzi40JN8dX8X8M5ddL1XbkT/9dM7O/dgE59SCfUYNS8WNByp8rnttHZ1Yv?=
 =?us-ascii?Q?1FPoEtqV3GJ5SDukeSMl5BVbMpDx1v/0ObDlY+j/5dkc3wp3MT9m5ZNGPyWy?=
 =?us-ascii?Q?U+WxAnAQLHFvOapBmoUxYWE9c82/hYT2DWrCWeHuU0BVPtcWmxCJhWQzOluT?=
 =?us-ascii?Q?5fuLW87pChEWb9t+JRsOdPutwhnqJbKLxwvUYEDNacR2cM4eLKxBmPcrC2PP?=
 =?us-ascii?Q?3gF1ZR2SBZinap6Au6KVhZCOJJxKh+/v/uoW25BxUjcGNBELOUZZ4ahi+QyU?=
 =?us-ascii?Q?b9fmse9nRETatiSvPiAK4RZed26er+dA4hCjf7Er0J6CetcprWgRlJEk7jwy?=
 =?us-ascii?Q?pC3IUh6Z9FZ4g5GvRs10iq26pXNO1HO63gdJi5ZU6/45jNO86qP9IcuT/zJd?=
 =?us-ascii?Q?FTuPF9jjfhclgfgWnzUufqf+Nm6fOEcaNy6EaFeLAN8Ailam7GSqYVrEV2Pt?=
 =?us-ascii?Q?26fBQ/v06CdgvI7NS0+6GJdDbzDK0eWNaeDL5Lhu7a/sYWH5Zmmnthb4c0EW?=
 =?us-ascii?Q?1iAp1Dhw2bGb0WylRYgW6URrJzA/XAGLzZrXiYUeAtF/PDxzYwG/1OCl2d0W?=
 =?us-ascii?Q?ZJ2Vt7F4EATk9kRBMmOp9jP5YrkvdF+u/0fWZt6KuTNRlLodZaM1Ycf352KL?=
 =?us-ascii?Q?gme9rvb5fh1aHCNnktt8+O0y5x03LkhYYOJPlOo4YwONhyNIF07k1LvCqghP?=
 =?us-ascii?Q?tenCHWKC5lsB01WE08zoSaXMqHraNJ4FwRp3TMkT0N79mmcZ760N0aXAK3rf?=
 =?us-ascii?Q?nNEGtIywmnJ3l9Zb8+nt+zWM9GRnCPL8aUKFAEpN/THgALMd6Oo3yIjfYmou?=
 =?us-ascii?Q?k+DJpZ1C+JKm6tqf7RwdBYNsYshMWFaAkPDYU/uGydpQ0Tnjo/ryIt8apBKb?=
 =?us-ascii?Q?s3Xa/yGt/riRogTT9tKaCzjuOuo+HEDbb5lbuHRlt/Z66F1Ojgb2wwkRDIt3?=
 =?us-ascii?Q?/RXFea1rbWuuQjO1Wv7IKO1g3Mujr9hhNd+r5VkiPJmgwXgMO4Wh4Vkcazyi?=
 =?us-ascii?Q?nMXnKJSFbv0SEXaJtVelcVyhhsAlYVarjpb5JD4MaXZajCXhICuk5qDr1rPs?=
 =?us-ascii?Q?p1/tteQSCtaGYWTSRXWppOXJ95V88fY6wGOsWJE2oWkn55GfzkWD4S28Ntc8?=
 =?us-ascii?Q?swJ5HdvWalpTkYqj0/x34kAdtKgNzeNQzW9FDzjVKDzbka/C6T/6JeTF4qi5?=
 =?us-ascii?Q?vXbqbhWdHd8b01P4yTzUJgjGDIuH41+t6W6+igYLE3B+7vD7eOTSeW1VAP4P?=
 =?us-ascii?Q?EUN/pV3mHAGd0ssvsgAaQRZbzOLqU49+q41X6WIHisNnJcSdWKNfUB8YbKaU?=
 =?us-ascii?Q?0zIo3kcte0DcOZThYOQhDLah5BZarIAAj7NGgWJEwDX1pDNF9vw1cCOIf4PO?=
 =?us-ascii?Q?8MrYx1qvbav0B9hOzocfNXS1kWtFHpX/eLuOpgKy/YTtG9EbVo8JlX/BTY6s?=
 =?us-ascii?Q?Vksi8NggYt2tzf+8XmCCm03ZtIX9WZ1LLRpplF+i2tf4VHfgew+xeSvqxz1W?=
 =?us-ascii?Q?5Pc+GS4nN0ivixGTlQoNG+SY8Jh8b8TIHUkLgAjOavpezvCYJ3gw6cN88rCQ?=
 =?us-ascii?Q?69o56klHGMi9li+MK55RZrJRlZ/L5FvWL+KSYYOKXUhwk8mM7XAppUAf97vn?=
 =?us-ascii?Q?+YJPohWzE6Qe+MSGSfRoxbFbAz5ckMdpaW0YeOTUfv/z/5waAe9DfvOHfkAf?=
 =?us-ascii?Q?XS28LbQjuQ=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11b74b3-0f6e-4cf0-5b19-08de4ec02fd8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:14:07.7480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZE3UkyIvq7xnLp0UQ8Mm3t1pnW2S4Rlggoa7u/3WIxH3WPiVRNMYn76908n5HbBkFETsRMoDhISZJM9fI+VRmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6836
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
 tools/binman/ftest.py                         | 42 +++++++++++++++++++
 .../binman/test/351_capsule_signed_pkcs11.dts | 20 +++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 21ec48d86fd1..ad5c2d63900a 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7532,6 +7532,48 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
         self._CheckCapsule(data, signed_capsule=True)
 
+    def testPkcs11SignedCapsuleGen(self):
+        """Test generation of EFI capsule (with PKCS11)"""
+        data = tools.read_file(self.TestFile("key.key"))
+        private_key = self._MakeInputFile("key.key", data)
+        data = tools.read_file(self.TestFile("key.pem"))
+        self._MakeInputFile("key.crt", data)
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
+        softhsm_paths="/usr/local/lib/softhsm/libsofthsm2.so \
+                /usr/lib/softhsm/libsofthsm2.so \
+                /usr/lib64/pkcs11/libsofthsm2.so \
+                /usr/lib/i386-linux-gnu/softhsm/libsofthsm2.so \
+                /usr/lib/x86_64-linux-gnu/softhsm/libsofthsm2.so"
+
+        for softhsm2_lib_loc in softhsm_paths.split():
+                if os.path.exists(softhsm2_lib_loc):
+                        softhsm2_lib = softhsm2_lib_loc
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
     def testCapsuleGenVersionSupport(self):
         """Test generation of EFI capsule with version support"""
         data = self._DoReadFile('313_capsule_version.dts')
diff --git a/tools/binman/test/351_capsule_signed_pkcs11.dts b/tools/binman/test/351_capsule_signed_pkcs11.dts
new file mode 100644
index 000000000000..c8c06805daf9
--- /dev/null
+++ b/tools/binman/test/351_capsule_signed_pkcs11.dts
@@ -0,0 +1,20 @@
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


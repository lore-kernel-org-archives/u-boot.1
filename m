Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B42C53200
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 09:15:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1030A83E88;
	Fri, 20 Feb 2026 10:15:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="oSQqjSLa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5CCF83E7F; Fri, 20 Feb 2026 10:15:30 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 844E583E88
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 10:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBgBe3405nki28CKoPdgO9j4xua3km3aViqdXCgjGIL53uakIw2MsizuQS1ctpyywOA7D3k+VqnavQf+03wxxAEs7X5BEokmPkQjTqOgjqR/1xLeLHgF1kcJaej8jipQXtzlKATNo+RxyX4Vk6maHI8nVFm7hw+4QT3mDa0T+2hFNJkJIb2V17Xo8Odhef8Juo/CaS15U2tnA+ED8LX92tGNL/CCvleZvVIsujKr+8Ak/TEgzn2o54hEl5E3Hno/AafhsGDoRMeLEGhAos4vUJDk5Dyh9oxC93vY3r+FJebAXt0+3186uS2fZks20RimJlfwv3dGttW68QLSefCtxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbZFX5FWOcAUQK3Y+2aF374THyiWyOztaMIW0orcmvo=;
 b=OTqwHj0SFKcAasItf+/ahUCWhP36yBTSZs28QqBmjdYaahOrEgTSnvPJecWATXMs17XyMqWiA+Mn6uwdAQPv5/wsR7CthHzz9zEr+0GNecWNjjRqJWaYzjatCN94X7+km4oSjQycUekML5qP6rRITbfGYRQsQx7vcjpzWzA5tuFTORd0iyLhI3QuMvfnOfei5SeqAafNhMF5djCQLGMpyiJEqgLDqOAAF3pQWXa2IqTQu1gNxChku/6ncNIXK4QboltIi6P+nXybanXY8BSga59Dyg0JIOpSk+qJoU/C8PqXjT2l4lD5OVWnkdneJ1jWJhtERk0kihTReo6FPRcXTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbZFX5FWOcAUQK3Y+2aF374THyiWyOztaMIW0orcmvo=;
 b=oSQqjSLaIw2VYUTSP2K7WoxPnVQYM0CBzC25zGCFf1gBZNXXc+SEdDcZzuA8Bf4cFLbqR7OjPxaRwkNCzB8mXXo88CFQoUZKK0neAWcVUv3GtTUb59wDI2+l1gu2sNrxT64dtFxJdAzs/tXkcRt3MtThnmbYPAvqFHcNvK+rWlNCViP/nd+Wbaz8x5UWdhIA8EADpJ/z4LCrKagbGI4zZlW3iWLyTGWocF0meH+oUmkXAv/9q8QQojJSxnYDvI4khjUmMMrC3AYVcJBhMLwdb9KB362OTpQuLKJqmNde3VTO4NIoaohooc4rpa/SDCjuvfbZWoD/6X7KECnXxZ17Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by GV1PR03MB8544.eurprd03.prod.outlook.com (2603:10a6:150:9c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 09:15:26 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 09:15:26 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, ilias.apalodimas@linaro.org,
 trini@konsulko.com, simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v7 4/6] binman: Add dump signature option to mkeficapsule
Date: Fri, 20 Feb 2026 10:15:14 +0100
Message-ID: <20260220091518.180641-5-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260220091518.180641-1-Wojciech.Dubowik@mt.com>
References: <20260220091518.180641-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0045.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::14) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|GV1PR03MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 478399f3-84ba-4316-3a2a-08de706095ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|19092799006|376014|52116014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h+Saof0En/pjjGhJPGxtdgB5DTx6Vjy6ZhnLgNxcQB6L5P+hhEFZx9DIkHNC?=
 =?us-ascii?Q?LZL0LKbGPpylrCGG9Fy4HNtVvu+cJ+56dGOpEVncZrCX9QalUIJIQ5Ey47Nb?=
 =?us-ascii?Q?kPeiYjeqprbSgB4RCR7NAWG7GrX6vuNJhM7tNkXkGNGGnebFFMRvW70OuqTv?=
 =?us-ascii?Q?+Rk9g2XBdP5owpp9DJP408bU9yphllAbV1hTCIFgWQifrx8m0PfyD1gKmqbx?=
 =?us-ascii?Q?NE3Ty65c0nFbYG5i8Xqjc6IdR3gdXzvMkhKkbjr5vQwDy40opXHVcVujM4cd?=
 =?us-ascii?Q?K18C/TSDbFGwAMhmYL2j4chsHOnrtK8EsS0FWOAEh1hhICNzNdxJWKymCcR6?=
 =?us-ascii?Q?QEl54t3Z3WlXIAdnzX/9wNw97veFz+SBP8rW5ri7wXNgkorCUuWAkIGSUL5P?=
 =?us-ascii?Q?74uYnz1/twntzfTJvaamLWu1S3539gWMWcLZ6f4AUROWUlrg/WvhKfdaUnux?=
 =?us-ascii?Q?TD59RkBrEqEq0lG2A95byi5qBORqlhHD7QInUYXOR/iI06XB+gJq4opR4BKu?=
 =?us-ascii?Q?rWCQQXBjyfR0aCYaugsqnLRbiKusvTB8upzhjYPlneOdkgBC5uPackCYrEMM?=
 =?us-ascii?Q?Y+eJZTfF5vE+2Lq06SGWNag+5XEKRvWewHjXW3YluNHzkp7rPWOjhb4uoV8i?=
 =?us-ascii?Q?UQl/KgfQZRJe9VxENjJFXPUwvDjLUjZuFNkJcYREnV1lWMvnBIj1ab5Jwkcl?=
 =?us-ascii?Q?UYtUk+B0qmTejOAUAGktm/sdvYbgdX4Mzdq2qy0UOleWHTPn3yhkbtAFguAH?=
 =?us-ascii?Q?T+BiR4Z1gVrr2yeseKXtgrMIrSOL2b+/ZZBNl6T1WuEAhbC0XHYk8LNJBD8y?=
 =?us-ascii?Q?xk9GUoIYjHXh2fDVUXgkwmBeHd7yOHhxByLPqmy5zo2173DAsaSiXBVY4v4J?=
 =?us-ascii?Q?8IrkPhX2nbVYFWFwluZuNF0s3+NaP9/6wAw80ShDmD/6iFQDGpbf4FUsxhLU?=
 =?us-ascii?Q?M+gD5js/sKuVU5kS9TOG2NsA50wCBBQOf+lJhEgobhoqc/uGTI+Ks11X5uMe?=
 =?us-ascii?Q?4S5eu/T0z1k7ddDioaAZWACIzH45f+ICZCGOiKcj7v/kjAS+n9lCnxHs00rI?=
 =?us-ascii?Q?nlXIMvN6CTHQ7tcAkpUPlIj+iT+ny/2NbXZUV2eaZqhmjIgUbBWmYfKvCtw8?=
 =?us-ascii?Q?+KPzeZHnjUlyU0l9zZvT9k4lh72DK6Ulyr+04SY+G55KxZm/vXo+bOvJjGOx?=
 =?us-ascii?Q?gRlTo8+7rA5iQj65y1GFD9e/wszdUUtEXdkZYNcYCWygb9AgUhTdPhVMB9uk?=
 =?us-ascii?Q?C+MrqMbAs8s9qcGtSvhbQxYfrwairOWqwNxcQSJiOyYPaAeYy3/m1XYZ0/4y?=
 =?us-ascii?Q?Hfs4cIPIHKgQe5eBB2C6eMEteySHgcEyC1jCcS++Iy2Xte/85uTDJGaHM3PN?=
 =?us-ascii?Q?9ut7+aF/cJJ8T0rYzCV2eHvn9iswSXh/MhxkwJRYRDasM1orrBjO8vAEQCR8?=
 =?us-ascii?Q?MbWA1Gin257mMymXmkTual/yRy9iOF9iE+fzi4FR/SPeV6bvFUxr6TK6tt/T?=
 =?us-ascii?Q?AycBE68zRnI8jVJ29PnWsTDR8ZbrL3WAZPa5FYwtauvA01bKWrvebBPDPVB+?=
 =?us-ascii?Q?A8l6pHEZPRJPmDzffn4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(19092799006)(376014)(52116014)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DO4lRH6zUdknNBERhl0tcziu4eQjBhiVzOHai9VqZ8Z+zEPcRkaYEvO7jvzt?=
 =?us-ascii?Q?xFi5KrAVOFE4xaWu3MFosGzQQD1DNzO30WNkI8sKBKWA5XMHzZyJaGrff+fW?=
 =?us-ascii?Q?fV49bJASGaN/p4KjYmkO0PqkY++sq3D2+4hf/+3JodExijeFdyLY1YdwFUZp?=
 =?us-ascii?Q?txEjlWgdgpuDGZnhN8n4mM+8SezJbvMhWOpbpaKtSSnzPtno3OVKoo24yC8S?=
 =?us-ascii?Q?bVQbOrRjAaWMmrqPgtqZ/Uvb1cPzNoWXmptOAmXgQe7tfh2DSJ/hFMQDONnI?=
 =?us-ascii?Q?fdc8ZdOub+tp5DIloOQbvsu45vFJHcH+kfrHbvi+0Tj/hmKz1yoHcx8uBvL0?=
 =?us-ascii?Q?8o6CxT5nfG8Vm/arDC65lWkEA6LE4M3javdDzQG+lnJ10ojrysn+PTEvr/aH?=
 =?us-ascii?Q?7nJBkWTyewDWJcVW6bqZ2vY79+53W0Q0CzDGWe3j2XD0+xpNIVJ4lqBDD947?=
 =?us-ascii?Q?L2t4q6FACQaygn/emJowrankE2/eSZW4Dz9b9a0WNnFskDAjSUe5aRkL/GUL?=
 =?us-ascii?Q?/GIO/luT/UaAyV+Q27ht19BBBUCeXRsKxoskfNttVQxzM9UMIRe0f3ePPJU/?=
 =?us-ascii?Q?LMWzb8OYx8usKMi5ZU7fBGJDspWmkhHmyilLaqLc1VnS4RHLyKpKy961mgtv?=
 =?us-ascii?Q?Yp+8v1SyKdSKFtRT47RP+SsIYgOSLBn2cdK/OaQR79BPmPLHkGt/Qi1oGc2O?=
 =?us-ascii?Q?pc5RsfasfqjQtlDcn7c5849wnvCJeLP8kNE9uUDo4YFJWTpHE62JArBsUsi7?=
 =?us-ascii?Q?zEX0etOcoW9Y5ysgYs2kpQ+Shr53bxrzkrCf+bh64M/5rxtS1+L4QTC3dpOI?=
 =?us-ascii?Q?jGDFJZTWb46hXEvskmJB+prvpPT9o+m2GRfXErCT32aIQfZZ5Wb2AXD9HFTQ?=
 =?us-ascii?Q?jIQWSiHMaHS/CKH1Zw66daAeMd7l7Xj2QozYXAR/W9u6XJ6pNVjX+FB31Agc?=
 =?us-ascii?Q?nZqMmITrho3e759+D8roE5yf7EOyI8p6pScJ2QfAi47BeL1nC6wDmQDyu5mw?=
 =?us-ascii?Q?6q/mlAbTIUzr69JlHfQms90mj7qmzr212p75PrQrWhlvchMjydpgeA/HUL7A?=
 =?us-ascii?Q?Anul88UQK9lcIYeuDcq+l/Wd/x0i7mydc/Ei3vOA4Bx8OJEfSjFDbghtd/CM?=
 =?us-ascii?Q?gzcNYMyZ3N/BIOcUyejAiPGAvvRbzYQUPEwWN8OKLJ57tMMxYjXCIWYZhm4a?=
 =?us-ascii?Q?9HHY4h/Hua7GyYwDHmlSBk7Cujq0HwxtoUifoAvRw/AMIlXfY1k0+P+WpCiI?=
 =?us-ascii?Q?flqi0qAdUiyU7zy0dWRSongUw2tD5wmUhUUviWMPrfOmOM+uzs3wtw0Uq/Uf?=
 =?us-ascii?Q?TxkTg/EPInLl44Xi8yKhBOMIjYAZFbHtZexb0CmlxSrykZ65Mv5PnY8fokUx?=
 =?us-ascii?Q?L81MU89NZ233v/g9QrfOXPBVX6xQIlPJw/zqwDsIQHqNZue3ko1ZF/FpYSNQ?=
 =?us-ascii?Q?OGyRXHx9NkBvmW2Y/sBOcIp3MUsZulgTMjjqYZ8NtjvNqhZXluJUppkzRRuT?=
 =?us-ascii?Q?UDhHXpDoD4nJgdqBqGKezB1NwzN6LSG29LqacgJxgGmK9I+wmFhmCt6nyQJn?=
 =?us-ascii?Q?1iUg/2Frbu1EqqgzMDUiKNhK4G0wqwTtT1eASvroGf7OhiEF4g26W8LINgs7?=
 =?us-ascii?Q?WcjwfffqGMq4Lwiehu4KhFIfoz+DchQfAzlUNxW8QVAFw1ukL7E3x+4x4Kc0?=
 =?us-ascii?Q?KjHh/jE+Vmz2KJfxGSs77j2n1Ij1eFD2y+SJcgZDuO41yueCiZyifgQnIH98?=
 =?us-ascii?Q?GbTgW40aAJuoP9ljF1QSn8JWt3fkNAyIrhRPUqcpvkrzHkqzn1Ifqy03EmPl?=
X-MS-Exchange-AntiSpam-MessageData-1: X9s02hUIGQAg6cnVJSxZZzzxPkUA+QNEpRY=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478399f3-84ba-4316-3a2a-08de706095ce
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 09:15:26.6401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9uKucX4Bt6e6Z2eJfnvMvLqmmxBoUKP17w+bf/OV0wsAKO+IXYi6AfckRYBy3jtRtPJb9o8tbEwszXUq9m+a5A==
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

It will be used to capsule signature verification.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 tools/binman/btool/mkeficapsule.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mkeficapsule.py
index f2ac654db81e..7638c941a8ee 100644
--- a/tools/binman/btool/mkeficapsule.py
+++ b/tools/binman/btool/mkeficapsule.py
@@ -38,7 +38,8 @@ class Bintoolmkeficapsule(bintool.Bintool):
 
     def generate_capsule(self, image_index, image_guid, hardware_instance,
                          payload, output_fname, priv_key, pub_key,
-                         monotonic_count=0, version=0, oemflags=0):
+                         monotonic_count=0, version=0, oemflags=0,
+                         dump_sig=False):
         """Generate a capsule through commandline-provided parameters
 
         Args:
@@ -53,6 +54,7 @@ class Bintoolmkeficapsule(bintool.Bintool):
             monotonic_count (int): Count used when signing an image
             version (int): Image version (Optional)
             oemflags (int): Optional 16 bit OEM flags
+            dump_sig (bool): Dump signature to a file (Optional). Default no.
 
         Returns:
             str: Tool output
@@ -73,6 +75,8 @@ class Bintoolmkeficapsule(bintool.Bintool):
                 f'--private-key={priv_key}',
                 f'--certificate={pub_key}'
             ]
+        if dump_sig:
+            args += [f'--dump-sig']
 
         args += [
             payload,
-- 
2.47.3


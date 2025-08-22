Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A94CA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 18:21:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03D5782E34;
	Fri, 22 Aug 2025 20:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="d3xqPPJI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FC8D82998; Fri, 22 Aug 2025 20:20:47 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 246F582AC4
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 20:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHloPZIeWOBemZr06rPpIWzhLUCvtqJL7SXz1NONpnGa7DVZrqgSUlr4tHyjztbrcbuy5dGA0Z/lurYJaKOVSZgJdECFNsxH28NVFgEcYKWIDUtySFUkYHV0eR5TAB3E0MAJR4DLeUBUaAWBqnd0QP6+1mljiegBwMsv9iDsAFogUrgXmOZjCidi66G459p6H2nYc/aIFULJitMtkhS2rdxcxa4/R9fQlxZAwRk5jPlfa43Iipo/acx8ZfPJl67hRHQ3H93VcGqa6MS9cbRLVKUwS/umR7+H76NK7DY0pq6WMk+7wfACniRUcgy/eeFg4ehvPkIugNeaqH8xwRYpvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRFMSzbPu6zVF+zH2AsxEMwRRYSQ3746c09tjWt56ZI=;
 b=N9xjLrSs35dx6kafjDbFdGLxEPKILzNsiknOoVd2hH1jIsdXebSmzrXG3UhqvPuY8gfH5YAWOMCitl6EN13yUFcVnGQ/c2zD/0+SasegSSGFWLNFUXHuz71i0y773vG0gWT8PTLBtRKICpVlmfd3N7EOS7w0oQuIiUQvjMQ/QaCA78FhtjoqfIsm7mmbdRCPfbgnt/Pm3w7OlJ2xYhRMthCqUFR4iTCp+q5Mc84bPlWM6fKkCFbE8nhmTbXn7FrJ5T+EQP+uh65GVnkIfhpVUklsRccYgZ6L2/nl6yEV+O1SPzH+0Oh6v0yMZlf16jiRs6oKXnHboPZn/Fn7FlNAyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRFMSzbPu6zVF+zH2AsxEMwRRYSQ3746c09tjWt56ZI=;
 b=d3xqPPJIKO30ZSjf0J7+hMJBb71uuVOR9A28DhAYQgtPAbGo9X2TpAfSIaHr50LEs6rcCCQIAzoTlhtToUftikAkHCcnqbrGHQ+g8C5McNKXdGiqhcaGegUmZBlE2vIEcDDlaKFQ64OUeY3qdtBEVcvQIeUiJBR7ToS7Ab4L6ec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by VI1PR10MB3742.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Fri, 22 Aug
 2025 18:20:41 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 18:20:40 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 2/3] memtest: only call schedule() once for every 256 words
Date: Fri, 22 Aug 2025 20:18:47 +0200
Message-ID: <20250822181848.3325832-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822181848.3325832-1-ravi@prevas.dk>
References: <20250822181848.3325832-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0078.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::13) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|VI1PR10MB3742:EE_
X-MS-Office365-Filtering-Correlation-Id: ee394a0a-5afc-4f86-53b1-08dde1a896c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SSQYOVsM7ovxCS8+4kT7B4lDfKFkPSQbVRhaAn9YnCoZmX/ghquPQ3YfksWv?=
 =?us-ascii?Q?zQMY/3xbWzhYk3+lxelwjv4qVG271NYCAToP7+AloXox/AxXdjL3tI8svyfL?=
 =?us-ascii?Q?R3FR/Vzr2n3oAIoxd75UsodT/NqI9mhlx4aykWkQx1ncqM9QMmMYpa3iqgLU?=
 =?us-ascii?Q?Q7HbzmFbt0TVlClA39fHEV2GQXVxU8QrY/7NoAh2qd3OkYP4hul3wXwer1I/?=
 =?us-ascii?Q?7vyK4u9El4LYMAHOSrp0rujMYBQIo0hckSOEjET5NSKCtwsh2vXo8eIZNvwa?=
 =?us-ascii?Q?5fU9/UWmjKNxkvZn4JbnE/IQjtIc3jtFLQBw3nQNXRQPkAhfKzqAqOPrOPB7?=
 =?us-ascii?Q?Aq844wTiN2k0QV9+kws7cmRYEfAJyLj49brwo8eu9qAJBF1LeK4rvbQ1prNK?=
 =?us-ascii?Q?iKEDgkAsgAvLVAxszBDRvLKCyMMHa0dDrFFhSwHlfvtyswa4XWraJaUXX0aK?=
 =?us-ascii?Q?n08VuSFz2gTVnTyvu8InECWU8hQu7xjiE4vhmGl9Bjhlh97qLtBOO0QBqYYY?=
 =?us-ascii?Q?prlAtevduDtEJaIQgjkBSMaHivxcxkIRoH0t2ENWsLgFqcO8nRGKuWzuowtX?=
 =?us-ascii?Q?fRQBwJp77isOSglou9Nmw68V+saISN1v5r5o0x6hqusl43NrCMS+r2lAj9US?=
 =?us-ascii?Q?k7nFzWf7WzYdTmznRh2u7oMoqSTIqfU9M39pqHTsJ120n9yH2GK+zAiXd+s1?=
 =?us-ascii?Q?rFVlKxaY/7f+uyjCRVcD5YuvgsbM7yTxMTWHdJHvdh5xxPrMpLJ+3vhjjXxR?=
 =?us-ascii?Q?XcZxH2+M7/QBaWruF8hAjW7hD/zMmBv1xHNrT9QiYJBb5/O1RXwS+NfcxdWU?=
 =?us-ascii?Q?64UPjmpxwd6++YYXc3FCmPybXXSjnhNFeZXCKlurIBCHcnSZoQQfyu9oaeaT?=
 =?us-ascii?Q?OZxpohGVoV4jRm63dzw1eLTistZcxJ1nt7p4rSFqCx5JgFczNdLpNMaB3Gf6?=
 =?us-ascii?Q?IO7Ykab6gsaIDYRTi2LLFLTf4AryygP5d/c1uVwDnvL4E5NqD7A1dBROys3C?=
 =?us-ascii?Q?y7wwdo+OoJK88ud3FafDN44oWZGDQ+8daSZxZR2jLqXZUE602NgL93RyZQkK?=
 =?us-ascii?Q?Lt31GTPRxOcktjvoV2GOt3Aj327nTcEO0SEex4Asx4DWzUHN7qStVm0a5rL7?=
 =?us-ascii?Q?D3Tq2OVymw1AzOh9jW0uSqPLKHdZKC1XNKJ9ct9U07VB4JgYV2j0Kgfj1F7U?=
 =?us-ascii?Q?R/JihjQy65v0WIWLE66NQl4LCnujmHZxv834GrP0hE3/sWD5kVjId9NKdMAv?=
 =?us-ascii?Q?DpkQYzKZ+GVO5RpQsTf2RJfMPDTcm9CVB9HeDmxGwwd6TOx6rjbR3ka3cEE/?=
 =?us-ascii?Q?v0rm1wnDIk8gvJ8MaKRNU+T3HpG+6IvA01H+T7zHFIFN9dSUbA3pqh68eG4s?=
 =?us-ascii?Q?HFuyxzdcbowNAmigvei+XwuBVHppyAbAFmIeyN+BiKjbE5bt+xeT82dTkTi8?=
 =?us-ascii?Q?KG2FQv7FHFVxJn/o1/C332JspkIBmIarB0MkjWSVsMKschR/5452tQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?amKHPgcq7uNmiS+72Lofl4MF3XayABMZ1eS1cXEI7Y7aOT4oDvO4cYG6s1W+?=
 =?us-ascii?Q?sS/DzZp1fXLBSPwQvR3W3X9w0G2nLsSvBhLXYL76Yg7vyfZLCqU+HCSqrgMq?=
 =?us-ascii?Q?eEZQYzhuGZYvcii1+QHWlUlXca+EKvhu+kHwqYEDx8LgYN8Wuw4UlNhpByxr?=
 =?us-ascii?Q?yjvKCOzd8Vczel5u6y8Wi2fZ4M71cA7PfWNOue0AXHRfYWxNCNNJiPhGVeXB?=
 =?us-ascii?Q?iNgm1J1/poXYG9UXrTKutdYrfT2MYHauKSPNDMWSocGAY2ZljwjeE8d5B5EY?=
 =?us-ascii?Q?C5VeL6HYcJFHB2q3vXUsQ/sfxRiAl8zphkYnlBEwamSNav1L7+0DHdyZIrMR?=
 =?us-ascii?Q?J5agH3SRSUJ/uj8xUbWnXdRuJGM4oI32/23ihEO/qDX9aEboxMvOV9NdRTCI?=
 =?us-ascii?Q?CImuJvTsp8nT64qA2Xs4PmyPXqmhrnxSOwLH4RimyPdpd+LJ91PxmT8zkRQQ?=
 =?us-ascii?Q?XGSZ4vcHrkE03I6yJIxJsYdNkH8QjVNNOK/6IDkMKZGc7EiTbgRnoMESILSD?=
 =?us-ascii?Q?DLBKFJI3GF0bZzNXOcpcejOAAFHMk+zjWKsNtd36XIXzfhQ3t1yxC559MqwG?=
 =?us-ascii?Q?A5yZ1mdcWL/vdQp01fk1IHi4139eKGQOWUTZ9XMt/P9wY5cLydyuUbxTyXDl?=
 =?us-ascii?Q?HnEJ7iQ1KrchM/Eo3s1gghfXjttQOMnBGLIMilYBqxpUV9MhmpgBe0PBg7OK?=
 =?us-ascii?Q?EyeWEF+EpYi6RZ1zYmY3Ak+eicnJuWbIO+7VGy9coZjK4e6HwUUJ9AKhKFyv?=
 =?us-ascii?Q?y7+gQ4cd6ayhlC/VFztZlNYsUnhBFUbgZQOt2T42wXomya5/O90lMXA4top3?=
 =?us-ascii?Q?H1RtD0o9Ge62JGVH2nyH9hn7NvzsRS+TdmGySi2I+mL9qpCC44mDqadIe/Ga?=
 =?us-ascii?Q?sw+neTyrKKU79+ViJ9438IP4CsFaacdLFTXMap/FQiTFzLev4vw6X9PBlFAQ?=
 =?us-ascii?Q?hSOgCuBGqh3/9gpT7xTl9+x5MGkq4QRchrUZkF8nycbvjpMwBhpy9GPQp9Sf?=
 =?us-ascii?Q?chzhc1rtNKPJxPYA6jL0+lipB9+TFhpaL1XGxicV7lcpH9Zjc3Yn08IAby+7?=
 =?us-ascii?Q?FP8B0vk573sGTRosWFydTE9PeSjezUECcYHfC/LcpzIj/39aH7IfZDhZ68DO?=
 =?us-ascii?Q?JGaWiC//Wc6kyOyL87+ENQnKiKRdQWxmHIDsISjrMh8W8c/dtDGRuS3tG5zc?=
 =?us-ascii?Q?2cUZ21LrbFXQrYL4K3HQJX4l7dkxPEs63susSsdRAla61zBvDu2fmIEzfa4z?=
 =?us-ascii?Q?bIzutl4UcVGlTzF2eqahd2Ow7ercDRTNxIK5BqwgOqq3oYgDHyGoP2ryqGzQ?=
 =?us-ascii?Q?U6w4J7zW1Ph2QRwFMjpVrMzszBC5TutMthuc6FhUYVQYTszPkWnn0vjypytr?=
 =?us-ascii?Q?2y9z3KQTYww1Buyyu5eFt9uHYgSm5XusXZxtpKhkN5PpYS7lPsfzsj0O5kNh?=
 =?us-ascii?Q?SGU/cSgnm5yKaauHqUJQwSKIK7JOjkYMkDUmNj/pcUzVnBhsoIex3bvQrMpC?=
 =?us-ascii?Q?zzgMKzTvbfFv39vJxozYe2ZCZxSzlB6Wec3n0iSiomCEffsjOTJoz8Bwngba?=
 =?us-ascii?Q?kgIunx5B+l3C2EcEUr1Wk1ZaeRiXlaEighLQrRMuNXvoPeQESZdMKa6oRjWB?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ee394a0a-5afc-4f86-53b1-08dde1a896c7
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:20:35.8006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CRUGydN8wzeIQFftNQpk4zUhaEPXYc8TwKrnfAWX1ECDPBw1luaO4n/Th3J+Q/hGttX0QM+bJIr3IW+ftJJ6BUd4NAPM/uAr2SND0R4sB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3742
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

A function call itself for every word written or read+written in these
loops is bad enough. But since the memory test must be run with dcache
disabled, the schedule() call, traversing the linked list of
registered cyclic clients, and accessing the 'struct cyclic_info' for
each to see if any are due for a callback, is quite expensive. On a
beagleboneblack, testing a modest 16MiB region takes 2.5 minutes:

  => dcache off
  => time mtest 0x81000000 0x82000000 0 1
  Testing 81000000 ... 82000000:
  Iteration:      1
  Tested 1 iteration(s) with 0 errors.

  time: 2 minutes, 28.946 seconds

There is really no need for calling schedule() so frequently. It is
quite easy to limit the calls to once for every 256 words by using a
u8 variable. With that, the same test as above becomes 37 times
faster:

  => dcache off
  => time mtest 0x81000000 0x82000000 0 1
  Testing 81000000 ... 82000000:
  Iteration:      1
  Tested 1 iteration(s) with 0 errors.

  time: 4.052 seconds

Note that we are still making a total of

  3 loops * (4 * 2^20 words/loop) / (256 words/call) = 49152 calls

during those ~4000 milliseconds, so the schedule() calls are still
done less than 0.1ms apart.

These numbers are just for a beagleboneblack, other boards may have a
slower memory, but we are _two orders of magnitude_ away from
schedule() "only" being called at 100Hz, which is still more than
enough to ensure any watchdog is kept happy.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/mem.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/cmd/mem.c b/cmd/mem.c
index 9a1cfa4534c..013e93f09df 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -730,6 +730,8 @@ static ulong mem_test_alt(vu_long *buf, ulong start_addr, ulong end_addr,
 		0x00000055,	/* four non-adjacent bits */
 		0xaaaaaaaa,	/* alternating 1/0 */
 	};
+	/* Rate-limit schedule() calls to one for every 256 words. */
+	u8 count = 0;
 
 	num_words = (end_addr - start_addr) / sizeof(vu_long);
 
@@ -885,7 +887,8 @@ static ulong mem_test_alt(vu_long *buf, ulong start_addr, ulong end_addr,
 	 * Fill memory with a known pattern.
 	 */
 	for (pattern = 1, offset = 0; offset < num_words; pattern++, offset++) {
-		schedule();
+		if (!count++)
+			schedule();
 		addr[offset] = pattern;
 	}
 
@@ -893,7 +896,8 @@ static ulong mem_test_alt(vu_long *buf, ulong start_addr, ulong end_addr,
 	 * Check each location and invert it for the second pass.
 	 */
 	for (pattern = 1, offset = 0; offset < num_words; pattern++, offset++) {
-		schedule();
+		if (!count++)
+			schedule();
 		temp = addr[offset];
 		if (temp != pattern) {
 			printf("\nFAILURE (read/write) @ 0x%.8lx:"
@@ -913,7 +917,8 @@ static ulong mem_test_alt(vu_long *buf, ulong start_addr, ulong end_addr,
 	 * Check each location for the inverted pattern and zero it.
 	 */
 	for (pattern = 1, offset = 0; offset < num_words; pattern++, offset++) {
-		schedule();
+		if (!count++)
+			schedule();
 		anti_pattern = ~pattern;
 		temp = addr[offset];
 		if (temp != anti_pattern) {
-- 
2.50.1


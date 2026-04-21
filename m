Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C04F327BE
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 07:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6008784372;
	Tue, 21 Apr 2026 09:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Ezh12DNb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D9AC84374; Tue, 21 Apr 2026 09:55:05 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C865A84258
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 09:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r33Z+XzCMcqBwTTxasapF+b1c823lPVjYWmVnD7ncldHUlr/8wh4o7rSQgInsWfTuL5YImXwvNa45FyzEIOWQThfxouqf+U+uUSpyO4yvkcodbm6qmSyUrEKy3XYkS/1PnhpGUwqiglrHBBnOB4cp/J+GG42qVEAyYzuMMPf2Oj99PFMT76FCVFebDWw3ktIh33U6x06GH40mXuowQkRHXogWlaA3vlmPZmdN/lOVxqrHfkpjohkQp8TQMs8/qxgaEZlvfu7rzYlY9+cawb72GjYSAEu2JlxRlaV8EVeiLQdFzdfj0LknJC2MVGa+BosEApZiDfh24OE2+OraHA+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcIG5JjE0LoqGPJvCOcFjDnp0IANj3N15d1tEwQsv2E=;
 b=eyUN5ZWIBZIpLO5fBc2Tl1fl5ZWbJVVG2hltYfEI1A2+HjhIfCXzqaS7Y4nMaS2oosOKdUXqIiXo2ZRfAaUYjyo1IhmpkMAiKiAAXB+zGDewGEeTh04BOuG8IBtyWB9SVSxb95hSrG9UJ9kbiFn0Sd1qqDWkeSQGWRi+NU7lmEGnqmh0X2DuaK3J3vhfWVZOLvr/Y90/QWhpvNJYmQs+5LBWg7cPGM5BC+DP3akJGdJb4/at5neBFmGvjs1H51BiGURkInh+5CDKwGOylrifUFZoEo75UsWBRdHNvW0R4zU7ICAYDisoEx1JYg9znnRMV78PlUFBdoFHrfvx20hQvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcIG5JjE0LoqGPJvCOcFjDnp0IANj3N15d1tEwQsv2E=;
 b=Ezh12DNbkNJS68VqS91lrDjoOaiqitoimwF1QTtI0Y66CbkUC0jyOYYGwzjsIkNNgLIV2Ki445TGuslai3JZByYvHdvwPu9qECkJ5RC08B8obgDV0XbZ+RsvTX/zkvgKgZKVR4bup8LpPnVGviunxHUZTUQdi7/UQs05YmK4XWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB6233.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:78::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 07:54:51 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:54:51 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 0/9] add memdup_nul(), use it and memdup() in a few places
Date: Tue, 21 Apr 2026 09:54:30 +0200
Message-ID: <20260421075439.16696-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0005F697.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::12d) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 91fe56c2-5c95-4ba4-f227-08de9f7b4443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: gRQZ+j61PmYr+3i8fJl2U9VeYBAcCplCvG1y1EPgJJKVdqZq68Ig3kCnM7A6f6y59hlsFTBjd8hglbgfQbgLKn4OqaSJTqImfGpchKT2QjLEXLuGKeld59j/lEjApxv5UIaJr9hgVPCtC7Q+gaYwqbIgOS/C8P60yCoJ++jFoKqYfhs4ySOpbTekSyLQio1U4+FcKxIaO6YIAtxKHkQPelIV03Kgp4BPZO68RRNdniSlNXrJj1ismgxbSJoj7kxreSOTbQGyM5Zni739NNH1uJUMtOCcIwtY6659PCv+TkrinLbGub+fJ8bQU4HvzYCAw4Hp6xm0meZV9byyd60ajgjsFVkxXwwxosTc813mCe20f4m0wIeVIms9dnVoOtZFR91wAbE/JIytonuuxaJdGi2viFKaEtDb6ewdGhYIFtumA1HuH+j31N6IimfJ+BtL7Ir0SbTnV8zMDm6iKxgc/NDYiA86JR0W/B7DsJZmR0QU9Dse7QNS/xZZP/W+IO/fUFwgfBjUYgYbNDwu5JMvDTCz9DERYWj/63Ir3CI969kV6PBDgxbAnYmRja86NeJR7OZzPhOk52jmJrMR/UPYv3t8e0Js1SCWnmYy+9Ny4s97DqbDcl5PNPQ7EAfzAbSIJLv77bK9+SAe4IYfPxspXJmNxjyhj60wNaiHk/d8yondL70/9khwFBZhuGMp3rxO2k8hhPRQSAL/ZBPcPTl3Z60CZjB7iv13SVbUsXpZv1evoc1IMQMkU2OAqjXoW/m7rqCbONlkzZo7e2zmKd1UIAsAYEzDIr2dvzhcJp+TbHw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KDzhX5+S1XR+SVZGqLdJrjaYWPnRohdeFvGhijWzxCNq1GPXpucMmLusToMw?=
 =?us-ascii?Q?ilc3HYVroaHe9Xp+p2TUNE4+xk9MOxlSfY6MGfHQxfYGeZOSsfCbOUoy7Ggb?=
 =?us-ascii?Q?RypBR/aJdIOh48IfmYhjNE3OW3MXHsuWxVb/PTlyQSffSQPlDf7UqF9RQoQL?=
 =?us-ascii?Q?HDg42OIzBN/lEqfd4ql+tpHF+intvDvKfnixvPJNJCTTD7Zep9lc26BRrwhl?=
 =?us-ascii?Q?l9U0i3nPnrbABfEOQE1Re/bsk4UFv3BxJwed9eI66QOA1P78yYAd3Gr8EMTg?=
 =?us-ascii?Q?yg+8+ea2J4wkAdfGKUT/uy1S+rJsfLTbkP7XUGk/r2Xu9hKBPyHSPcnxwaDk?=
 =?us-ascii?Q?YreX/ngZo9TEfgQ3OxuhGiWRMi7IbqPKxSMgNa4dIRcC/veOy2FUj2PWN5zb?=
 =?us-ascii?Q?UiFKLXf62gsOf25YHzeFm8xXfUZ6jTdE1cXDkNxhqEW4TMjcrf13pUpeaotH?=
 =?us-ascii?Q?86WVMOuWmilFj+Nz2inntXNZSNlB7ikjhrJsBxpsuIqkXln7RVD+u/c1JcxS?=
 =?us-ascii?Q?u+YDZ/mArqf6rpYkYRvKQiy+GQdHWt0QNOPf9bT7S92ZVF/pYdAzt/tL9ADx?=
 =?us-ascii?Q?FQSjHQeG24860t2qJFM3B7enQH3KLr9ueYdUqR6l/XAqYH50JVXFCu3JSp3A?=
 =?us-ascii?Q?i/TkfOYB5i1wwA4BU3AGXvzGYmpzVgy2SeKijsNWsYwE4XWLZr5roMLOBUXX?=
 =?us-ascii?Q?+UXiEeopbtVv3p6E50PvKIU2unqbAvRS9frvkbapD9cXK8plkKrdZl9/p3HF?=
 =?us-ascii?Q?ujziaIXR8YU5muV1RIh/L642S8kgYbZWdEXQcMy9KvC4yb+ZwsfA6l9TD1SZ?=
 =?us-ascii?Q?kKElM2F64XNefIgOMoWwTZgrCoir+iR0yOqYgRTvNjoqQStNAtHmIhqZnC2Y?=
 =?us-ascii?Q?Y6FM+KlNe/DgttU4oaTYWze12nxh2SYDszaKLYB82ybmcK9XSeXGhIdEWqZ0?=
 =?us-ascii?Q?tlZlO0IUINTyY2mmsNCCdb5D+l9I5VXtSVXrvTo4gKq0on0Hlk67/07vCH8R?=
 =?us-ascii?Q?ItzAzrn2We/8fZABfkAoMZQWOlDFz609sZFfjl6Hg2Zq2SxK5KRiK3MNebf0?=
 =?us-ascii?Q?qpctNesEuTjYbwO9rVxxA250yrbspzo2yPxea/laox7VeMez0mgiaSczKEGc?=
 =?us-ascii?Q?HKV8O2iEYRBanlqPcm9Ey1L+bJ9kB38Y/rE7KvqEIIrtlVG1Ux1pAfWWpcB6?=
 =?us-ascii?Q?j0JQ/m8jwckKU4yMWWmAA/p+XzVoIHrVof4MC1iY7XdrTHpY10VFJjEvvx8R?=
 =?us-ascii?Q?TBhO83yogdiS/6WE3E9bjAhVQJT7N8+HMPNPWxc/PRrSZYvjfjoTm55fJWjc?=
 =?us-ascii?Q?tBljLxP1jBiAY0laKgGe0TP9AlVnSCEWv2aCtopSSPOm/kE2OgR3ucog9ZoZ?=
 =?us-ascii?Q?KZyhn2dnxCVSHBHnTMyU4RPlkLB47JnICXtzKpUdVFrecU2RWeEHbzyMKYGF?=
 =?us-ascii?Q?27yNg7QScYOe7y1SfnxKNzHigc4owB19IBMY86Y/6+9irjVPAJYcYHKjqsCv?=
 =?us-ascii?Q?3l/onu7sgBYCl5W219xmiljSdwWiPTd12NA7d/LjS51ZTlgwq0OJkjCShTj6?=
 =?us-ascii?Q?f0spdfS5dmvSM65jpKQ9UHF2y2+hGpls5MFvKAauU4OhLEXO0ZNILRNyZQ75?=
 =?us-ascii?Q?+4P/wY5ASN1GW1DgglASJaEdTktKebVa7DX78NAlGKPc8WraLlhVWbvff5O7?=
 =?us-ascii?Q?l0X+00lD3xYk+7Y1fGEXhQXPhIhOOLcTSBcK0mbOjo2LsB0EVv+h+uYCTTQC?=
 =?us-ascii?Q?e3A4+CaFG8nIKYF5pxveK4fqVg7UgPc=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 91fe56c2-5c95-4ba4-f227-08de9f7b4443
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:54:51.0331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8ebnQhUXH1Gihnf7xx2gmJ90re8K8DdIUfnrCVK2sxUtKeJma1tIJI1SAjJ/6SHr4uW0gosDLNc3+TqTehx3iF7q4ecn9mXkQgiTKR4SN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6233
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

There are quite a few places where we allocate X+1 bytes, initialize
the first X bytes via memcpy() and then set the last byte to 0.

The kernel has a helper for that, kmemdup_nul(). Introduce a similar
one, and start making use of it in a few places. Also the existing
memdup() helper can be put to more use.

There are lots more places one could modify. But for code shared with
host tools, one would need to do some refactoring, putting memdup()
and memdup_nul() in their own str-util.c TU which could then also be
included in the tools build.

v2: Fix grammar in commit msg, add Simon's R-B to patches 1-8, add
test (new patch 9).

v1: https://lore.kernel.org/u-boot/20260412195947.1982729-1-ravi@prevas.dk/

Rasmus Villemoes (9):
  string: fix prototype of memdup()
  stdio: drop stdio_clone
  lib/string.c: drop pointless __HAVE_ARCH_STRDUP
  lib/string.c: introduce memdup_nul() helper
  lib/string.c: implement strdup() and strndup() in terms of
    memdup_nul()
  lib/hashtable.c: use memdup_nul() in himport_r
  common/cli.c: use memdup_nul() in run_command_list()
  drivers/core: use memdup() instead of malloc()+memcpy()
  test: lib: add test of memdup_nul()

 common/cli.c           |  4 +---
 common/stdio.c         | 18 +--------------
 drivers/core/acpi.c    |  3 +--
 drivers/core/ofnode.c  |  3 +--
 drivers/core/root.c    |  3 +--
 include/linux/string.h | 18 ++++++++++++---
 include/stdio_dev.h    |  1 -
 lib/hashtable.c        |  7 +++---
 lib/string.c           | 51 +++++++++++++++---------------------------
 test/lib/string.c      | 34 ++++++++++++++++++++++++++++
 10 files changed, 75 insertions(+), 67 deletions(-)

-- 
2.53.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E3CE98FC2
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 06:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B2BE839D5;
	Thu,  9 Apr 2026 08:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tGLh4Oqt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9041983CF5; Thu,  9 Apr 2026 08:21:53 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 834CB83693
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 08:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7ZpJpLq9cGYz69VBfT8nfWc09Z+4k2LvV6OXceOn7NPPcKS1XRoaek/9v13JFzld2vwFdFEiP2ZE7zYPVvpbsyx05/P9ReOed92up/d5Fupk2EZBatbMyn1G17zHG5SA6TR0KrkgKcpWMaY5AFr3Em1CoYGCLPncdfNhW+/VUrBoHLTFX44WgcIrLflsx0n4YC9x9R/ifv58z0Zs0dOuoqmwQ3GZYn1ksS9xBgW73Hh9v55dJBuU9xHsMXROUGh2i0GKpS6irb2d80+9/k1iZql/Sl0QHhRWo7uV5i2mQdDBeIIrCzWKOMwOGMJol6TkBuUDB3YfGo+UNPC88q6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoDWR6NLcav5cCrgUNrSnpQPsnc+5g3h6peyvzF1iUk=;
 b=JyB7c0yvIOBC7Z/xKjrU/pONQDo8N2WLNxRoBEVKQXPjq9DGHddv9MmxhAUgeSsKCdmaAG6aFIZ7T9YM6kThtv0I62rF0vaZvybuScA1tivWFh1fM8BRBEKp56KlmNCxmHuwGd2TQGq76W0TKwqs55wUaks39+6ehLopw30sLm1HyUXXdi4KmVJ9FsnE3r5eZQXUFBudS30u9HG08+MXb6SV/4q0QABPKOA1O12VWdn7GcY7EMjcnayf77thXlIccx/LS5SLDj8SpODOICXOky+nKcRJL9adq0Z/tamrV55wrVw+CWK1Y254Uv3hIdX15rVE2RJCCpXbiiTJPpVOmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoDWR6NLcav5cCrgUNrSnpQPsnc+5g3h6peyvzF1iUk=;
 b=tGLh4OqtBlNcmUX8UcaBrNYgQowgSNMCMTnbKdJHNNp8DVZrOGMU0aq/3GnTPES+quszxSdCqWVQe8GJjrxeD92ssYb5GhwewQryibzPlk3HhfF4qlIlGz+qaUEQ7BFKOTYfRPCqVnY5RGPPfNA23QN7pvWGMIQl03i7sn6KjIGAqDlYVV+h7P1aurdd5qEFVeYvq2HB/XunL7mEBZdyUoHx6whjPlNP5LMsXahr2IwepiYYgbHXM7U7qehXk/o6wESm1Wa83hfz2ipZBOKdjJivnUEOwdL1miP3SSYlluL7pE2IxwC0klCgSX9kyiFSNddAZuYObH6MramUqtUhKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7659.eurprd04.prod.outlook.com (2603:10a6:10:209::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.39; Thu, 9 Apr
 2026 06:21:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Thu, 9 Apr 2026
 06:21:48 +0000
Date: Thu, 9 Apr 2026 15:37:55 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Oleksandr Suvorov <cryosay@gmail.com>
Cc: u-boot@lists.denx.de, Gaurav Jain <gaurav.jain@nxp.com>,
 Ruchika Gupta <ruchika.gupta@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] DM: crypto/fsl: fix unaligned exponent handling in fsl_rsa
Message-ID: <addXUw0DodVyuWiC@nxa18884-linux.ap.freescale.net>
References: <20260405135446.415680-1-cryosay@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405135446.415680-1-cryosay@gmail.com>
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: dd72b09c-7b38-4bb7-5375-08de960047bf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|52116014|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Z53F+aX6XmM3O1vDaacYXv5wsZjZrrTSPPTCu5RdUGjdVgW2iztwo3dE4fG7NAbdOWntmvA8+cZU7uHvgBGOezP/dtaLuehZVihdqBNMYlit0IHt9aaebvgQWQeHs7FRKk/sL/lkOIBnC1JCne0Mr9HJSyY1ymmHRtiuo0d7O2J2yCj3Qg1qXnU1Jq7mmUETztcgef1TrP6R8+pmr5FygcZfeepBTj19OHt1O/dkud44ryPUDsHKDjBMDPfvpQe1EPLAvH43ViMXEme2aiKo5d7793RCI/i04LkME62QqOU++qzncybigxnTRAzb1SlaMqxeRSpj/C6wF71oJdgGdKVfADc4b/gooD16Off2Bz3eGXGRiB/jeSjueA+EhCi9xAhYMcmFejUolcNWBl7K+KkKYzNC8m96GV7DksFkLNpVPZ0r+IGBan/RfY3sgp5XpiL9pcH3ul5MQOwflBrWX5rBdJOqEoi6Vp+TFNq2wxncMYFodXK0bWmx64calOLsrMPLCJI7mkJnwqofbaPXrWYQ2cINpOcBrkDm58zbAofwK1XCSGcLZzpgo8uS7n8sDBnNGJzpFQxmvePZT5KzQy6SaOZ+5pnRgIOa57dhxuJ8xoYXyQW1tiWcI93ljqr76fM2WT2gGTII14eJtfSEoX50ZRwBX5ef3VdCqsk73Wci+Qh6dzB2HUaAO6ACSCslqU/ox+GaJaV0Aqro0IzUJtJnD8m7WqAiEKtAQXKzRCKWxNCtwb96SrIT+l/9joaK6wQsyQg6WNvTnLwAOmpq0h3lkYCxxpvrdOdIUpOKeZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(38350700014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yKZnyClQAXXCnJ2NpcnH2VoU1lna9AnNwrCKGmmF5rVi1dqeH97+rUTEBHim?=
 =?us-ascii?Q?wFHyPhrMQvhi27uDDVMQMNVRV6/489xBYehILZ9H/p/J+iWq7kC0Va6/XccZ?=
 =?us-ascii?Q?TDUDjBvPwA/Cb5gczEp1UXMcTz3T2qs/K0sgsyqXIlRdQTzRDh6/jOXxkgdK?=
 =?us-ascii?Q?3+XVLF5HnLaMULELGmFt9XrseuputXbVA0Qq+ozv6WbXIvWM1qxJblW77S3k?=
 =?us-ascii?Q?SaO94mXS7Rl3DlEz0rUHI28KJVn+4BA/qT7Nzu+r8vGxPu2kKpvdvKSapSGm?=
 =?us-ascii?Q?+jUCzFh01a7DugAeoON8D57NEblvYhWmWbmrfMUYFpdiYdqz7W1yikcqi4XA?=
 =?us-ascii?Q?N8+Z9O1ukuZiQW8TnjUZgz32YR2nJC4sOsFkUmJ+UaKddxphnpRu8HbfWfX+?=
 =?us-ascii?Q?I5a7NGoOP71F+iG8ldsTyZaLCg+PhKKPEynecusSITOfqPuN7JeNyC5wgWpz?=
 =?us-ascii?Q?zH49DusuuEcEzcy6II3+EQ2YYhBz8pp8BV1rL02btQAB/fmB3VswPSxqBEqf?=
 =?us-ascii?Q?rW7xfrbJCny8qMICtHUb4MYRJqTDslE56RTpWJ5urae85D3kvsri7dvPkezG?=
 =?us-ascii?Q?yzOQuFfRpzxtppyYzTT+xkJC1mOec8bER8ECQuSeMFYB7faUTlMSfUTcxKwD?=
 =?us-ascii?Q?j8ww1rv/75UI9Mhc7KeVNqwFJjpFm7g+E9YowPyImtrDz7PTgEcErgC0cLd2?=
 =?us-ascii?Q?hZ9moCmdBDYcXfPvZ/jtNj2wGnGfIENX6rcKqYcKfYxlI+gdD2ZPsRWSnGWl?=
 =?us-ascii?Q?FGAUVJK+K1p9GCU/VyYAAsimyaO3pL62GNBXgQ6mkhDcm6nQ0SQBWTf40sq1?=
 =?us-ascii?Q?SrlhyippfxU2hIVaGRksQByPGW3j+YmP8bU/gF+gRulDSbPBIH6JNWrvPh+S?=
 =?us-ascii?Q?XXDluNFewQZd/PkDdZwT8jb0V62fiLjluXAKgAh7/aSLSQPDUWN6+uhBp6h7?=
 =?us-ascii?Q?2l0d3a5wu7cmievaJQpQHBzVW6WNpgsEg7SLmrwylO6D87q9jN0o1pWpABsu?=
 =?us-ascii?Q?BOu33Ukt2LvOft0bGgnsNV7yQAOuJxxgrwz+fWziNdedaN22leGvfv0fy6Np?=
 =?us-ascii?Q?DXf+gQ372hddbMvIpydw3YBYz1prgZ7qEv+fg7+oqBPo5NEL6SpNLQ0cvCPf?=
 =?us-ascii?Q?31fP78Jmgl+xwk1kBdXdBcOw++rPl9qY2EOJCy7O/doi0wkFug/waZJZMAsV?=
 =?us-ascii?Q?l5PIxDAkY2UJgwZLWQ8wMqeHM7yweBjEDRLp3Gw9OOFqe17rGb/cT8H9BKDx?=
 =?us-ascii?Q?Kdgipd6qrDsT8WZ2lSqXDmdwjlU/4Bku2fK4MhKOas+7Lgr0jn/K9pbiP0uM?=
 =?us-ascii?Q?9OWSuOfgh9EycoE2ARYmuOej3yssckmT2K22J++R944K+SJv2llTCuhK8bwW?=
 =?us-ascii?Q?6K3dCkx0iygWfRm7gi16cjXu5N+5YawIosOvOu3C57MxvmC+kmvQFlHvBcl5?=
 =?us-ascii?Q?33zpYtoT5W8EbRbWErAa9MUIpVHMX1Zvo9vCBziXSyr1pq97ECL2/rT2+kv2?=
 =?us-ascii?Q?78ugLrQzJLe4AAGw50PIqyTqZoZFdvwp5wYWBmip7t7oxcosCp4VeWV6dCIt?=
 =?us-ascii?Q?OWsb2WkcIxpFpJ3ry9x2wG7S+CZdL9eOUt+s/3GkEznUbO+D8tVy7lqYJrN3?=
 =?us-ascii?Q?+UYYCiBkJ8Lj1HtGlbUcLJwmWZI1DLUg/HQg66JkH3l/rtlXJOpgtbJQpyAk?=
 =?us-ascii?Q?DwFnty/Zt8o/QsKzAJmpWzr+V1a1onVCWTF062qtNtP0sgs2cMmT3Y4ya2xx?=
 =?us-ascii?Q?qPY0Jweerw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd72b09c-7b38-4bb7-5375-08de960047bf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 06:21:48.4786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hq46xL63xJWLpeqatBmUGPLK0NMjegCJpuhZXfp4vYLffEKIc8dqL7ctGhxZEEGQvmLLIwLJ8c/94VA0PeW78A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7659
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

On Sun, Apr 05, 2026 at 04:54:43PM +0300, Oleksandr Suvorov wrote:
>The RSA verification path loads the public exponent from the FIT key
>node with fdt_getprop(). That property buffer is not guaranteed to be
>naturally aligned. On ARM64 this can lead to a synchronous abort when
>fsl_rsa uses the exponent value directly during verified boot.
>
>Fix the driver by copying the exponent into an aligned local buffer
>before building the CAAM RSA job descriptor. Read the value with the
>pointer-safe fdt64_to_cpu() helper and pass the aligned copy to the
>engine instead of the original FDT property buffer.
>
>Also flush the cache for the aligned exponent buffer actually consumed
>by CAAM so the cache maintenance matches the data path used by the
>hardware.
>
>This keeps RSA verification functional while avoiding crashes caused by
>unaligned FDT property access.
>
>[1]
>---
>
>Trying to boot from MMC2
>    sha256,rsa2048:dev"Synchronous Abort" handler, esr 0x96000021
>    elr: 00000000007e737c lr : 00000000007e6e78
>    x 0: 00000000007fd1e4 x 1: 0000000000000100
>    x 2: 0000000000000800 x 3: 000000000091d420
>    x 4: 000000000091d420 x 5: 000000000091d588
>    x 6: 00000000401ff9b8 x 7: 0000000000000003
>    x 8: 000000000091d49c x 9: 0000000000000002
>...
>    Code: f94008a0 2a0103f4 aa0303f5 b40005c0 (f9400003)
>    Resetting CPU ...
>---
>
>Fixes: 34276478f7b7 ("DM: crypto/fsl - Add Freescale rsa DM driver")
>Signed-off-by: Oleksandr Suvorov <cryosay@gmail.com>
>---
> drivers/crypto/fsl/fsl_rsa.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/crypto/fsl/fsl_rsa.c b/drivers/crypto/fsl/fsl_rsa.c
>index 125a72ae6d3..053e1862bc4 100644
>--- a/drivers/crypto/fsl/fsl_rsa.c
>+++ b/drivers/crypto/fsl/fsl_rsa.c
>@@ -23,6 +23,7 @@ int fsl_mod_exp(struct udevice *dev, const uint8_t *sig, uint32_t sig_len,
> 	struct pk_in_params pkin;
> 	uint32_t desc[MAX_CAAM_DESCSIZE];
> 	int ret;
>+	fdt64_t exp = fdt64_to_cpu(prop->public_exponent);

Build warning->error.

+In file included from include/linux/byteorder/little_endian.h:14,
+                 from arch/arm/include/asm/byteorder.h:28,
+                 from include/linux/libfdt_env.h:15,
+                 from include/linux/libfdt.h:6,
+                 from include/fdtdec.h:17,
+                 from include/dm/ofnode.h:11,
+                 from include/dm/device.h:13,
+                 from include/dm.h:13,
+                 from drivers/crypto/fsl/fsl_rsa.c:9:
+drivers/crypto/fsl/fsl_rsa.c: In function 'fsl_mod_exp':
+include/linux/byteorder/little_endian.h:39:50: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
+   39 | #define __be64_to_cpu(x) __swab64((__force __u64)(__be64)(x))
+      |                                                  ^
+include/linux/byteorder/swab.h:92:31: note: in definition of macro '__swab64'
+   92 | (__builtin_constant_p((__u64)(x)) ? \
+      |                               ^
+include/linux/byteorder/generic.h:93:21: note: in expansion of macro '__be64_to_cpu'
+   93 | #define be64_to_cpu __be64_to_cpu
+      |                     ^~~~~~~~~~~~~
+include/linux/libfdt_env.h:24:25: note: in expansion of macro 'be64_to_cpu'
+   24 | #define fdt64_to_cpu(x) be64_to_cpu(x)
+      |                         ^~~~~~~~~~~
+drivers/crypto/fsl/fsl_rsa.c:26:23: note: in expansion of macro 'fdt64_to_cpu'
+   26 |         fdt64_t exp = fdt64_to_cpu(prop->public_exponent);
+      |                       ^~~~~~~~~~~~
+include/linux/byteorder/swab.h:33:34: note: in definition of macro '___swab64'
+   33 |                 (__u64)(((__u64)(x) & (__u64)0x00000000000000ffULL) << 56) | \
+      |                                  ^
+include/linux/byteorder/little_endian.h:39:26: note: in expansion of macro '__swab64'
+      |                          ^~~~~~~~
+include/linux/byteorder/swab.h:34:34: note: in definition of macro '___swab64'
+   34 |                 (__u64)(((__u64)(x) & (__u64)0x000000000000ff00ULL) << 40) | \
+include/linux/byteorder/swab.h:35:34: note: in definition of macro '___swab64'
+   35 |                 (__u64)(((__u64)(x) & (__u64)0x0000000000ff0000ULL) << 24) | \
+include/linux/byteorder/swab.h:36:34: note: in definition of macro '___swab64'
+   36 |                 (__u64)(((__u64)(x) & (__u64)0x00000000ff000000ULL) <<  8) | \
+include/linux/byteorder/swab.h:37:34: note: in definition of macro '___swab64'
+   37 |                 (__u64)(((__u64)(x) & (__u64)0x000000ff00000000ULL) >>  8) | \
+include/linux/byteorder/swab.h:38:34: note: in definition of macro '___swab64'
+   38 |                 (__u64)(((__u64)(x) & (__u64)0x0000ff0000000000ULL) >> 24) | \
+include/linux/byteorder/swab.h:93:2: note: in expansion of macro '___swab64'
+   93 |  ___swab64((x)) : \
+      |  ^~~~~~~~~
+include/linux/byteorder/swab.h:40:34: note: in definition of macro '___swab64'
+   40 |                 (__u64)(((__u64)(x) & (__u64)0xff00000000000000ULL) >> 56) ))
+include/linux/byteorder/swab.h:94:13: note: in definition of macro '__swab64'
+   94 |  __fswab64((x)))
+      |             ^
+cc1: all warnings being treated as errors
+make[4]: *** [scripts/Makefile.build:271: drivers/crypto/fsl/fsl_rsa.o] Error

Regards
Peng

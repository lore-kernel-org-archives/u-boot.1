Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E719FEDEC03
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 04:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83B2C83FD3;
	Wed,  4 Mar 2026 05:22:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="fWsvdHBF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AF1683F75; Wed,  4 Mar 2026 05:02:17 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FF0283E7F
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 05:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWfoHuYKcEwy+YXHVIzfoRSh+ean46gVtjdTgQmTMdZCsH+xx0Tb4RAw6vQilZ3pfLRylxvpsiNj9mVfBuFSy2oiQany12sV5mZHXE7jzgNwXWKJH4+JxwMmLnt8IUa0fSZSQ4cku0ek2yFRsLB00V9HmwAKTjvzGYwO2Ofq8INBJv38vtmHMtiQvdnp1G+LounQM5wKmBOiW/UHOjX/FLZNIMhGIYu2kTQo/fWKNuMWjO/+mGgxpjF+W1/LApuA1PdcCnePAOcgdEiEbzJEGore2g/7PatV6up9aFeQm1b+N3hCWjf4Bnu+M17x57K64Pifohghu+MMRzzDsgHnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqaPv8HubW0enk12nGdUH6US6QwGvWjsHPRNuWSpbJo=;
 b=te41BWzLwAiXGdNaCm8WIM6VHEHeMuCOSoxj6TGJTD5Ovt9q7L5IHKW/LoSdXMTNMBONxib5Y8T0JezKLdTPJho1Ihs/NoMoxEKnSec6k16VqkMB2bnQeR7X0m36ODT6hAfhTsH9DJ3jAwSTB5GocLrS07r4a/sHtXFnqHp0LpMY200pW0HoBc34FWKma4Z2ihQ3Zxnx5FjKvKuuIfXg3DiTlxrfa+DZ+PPl/Fi4Khy//8lx0DadoWPerFCN3Nm50yZHx+jxrBWII3jEZe3wxW3i0F03se8OiLF5bsoPTecZw4RRO3RBTuftfDskKEtuUG/9GUdqngv4bSJtWUOurg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqaPv8HubW0enk12nGdUH6US6QwGvWjsHPRNuWSpbJo=;
 b=fWsvdHBFqd/8IIAiXMsYzBtwPXvEZBTiH9oi+mDfYjy1aDQyWnddzn/yt4Zti4bvmF7pDi7/VcoDuuXyFQ1zmPSsweWXRP707coqSuctUnasZuGE0fbIMbJ8j7iEd2rRTMBdU7BTwQjdEsfabxezMffmJZmqb4z3b10G0BaHbc0k8CsW2GvIZbAwyEwWSaxcFGWPFAKeimvRKm+HhsMD3kif2yq1SeEkyfaIn+AzY1Vd1FbayLYBEC3FE5hS4Epgoq/lfPm1sFgZuHNBoeGem6W61NunUeZau+8R9M+SC0/e5rsy/OnyMNmapk83WmuIEG0MWPqE+nFXTSTi1ZI/0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by LV8PR03MB7327.namprd03.prod.outlook.com (2603:10b6:408:18c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 04:02:12 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 04:02:11 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Brian Sune <briansune@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1] include: configs: socfpga: Add environment variables for
 distro boot
Date: Wed,  4 Mar 2026 12:02:01 +0800
Message-ID: <20260304040201.9265-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::32) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|LV8PR03MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: ad39f19f-407c-4f22-262c-08de79a2d007
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: wq82oxWQPjWJUqZe/WrtTb5g06CE7fDRZ5NbY7FH6dT4S/xER6S99lAmKFAdE5eed4OuF3bTLnUMonrdm85lk/ROX4ZMs69wKGUCcPo6tDmW/1An2C4/TQgYY9s/pacwEqjtal3DlysX91B73gVmJEq9wdSdfA15sWfRbnM006OHQffumuFZR/8AFYvC33F/rhNVDsnUxyGrd7bDyEptSgjd7fvMGRqbt0HhX3D/MnrrQQP1eJDJ2sdIa1bGeIW00m7zALwXUvIdsEjrs2WCFwh/5KyKNmp7doIQrmu6EddRS9YLlkjZip17gWmf/SrcCDg3mG3vlV6r6lfeBgqoTJXLS0oEvu2Ex+Jg7YfY6M72I07OkE9DGWYt515Oc8ThgUUrQugFujYE7iwIkYGouCEUYuus7wW9W2Sz1tmO973bxWgynxQk8cqeY8IiHYrHVIOHINv6cRXC4FO4nXZoSnT7pkvBeTzllZVk9/6LGTPLCpTYQwMT/4hh924QJ+Tau3f0CaIORJ7OJGOwG/AEpZuXDVZq/o38XfwXjsftlSzkiRG/UC7+sEC0ZaR7bsBdvUL21z/xONe6hKABcdSqexAHykw1snp8mXH1YhqhcudZ+txBYQQJ045efBArHOSB4fulR2/fqbsf3BPx7rROdVtbJFdvdONVRKAqk2BCGg8dhM5OP02xf+u04Myw/YjY4MtzOQm6gbMLNvtoE01j1wfrHprFStgREkZAUjplm4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OeAfcQxvnZkmAMf7zzBCUqFeZSuwmxHEZBFWIBuTg1QO++TZs0wz80T+UX0u?=
 =?us-ascii?Q?zh1PFTvUrnTT4rIriB1NcN3hivq2qGxXi+RZcdJYKoPJjBopOB8Da0yTR746?=
 =?us-ascii?Q?d/Z9zzNyY32Av+9cAozM6oqSIldpo324h/X30Rm/oyotuuJouNOzeZdzibff?=
 =?us-ascii?Q?Ybkf6km3uQ8qbhwXl10iuzpn9TGIoQuQB6zTIzfGN4zykMsXACE1g8Lyo66N?=
 =?us-ascii?Q?f9Jxps61PQhm1k7MlU4bAy+VCe+pznjPcvYgJRS10Hiy0bRe9UQvxt2VXX/V?=
 =?us-ascii?Q?Nhck8UhLHmZSzUz8coSnj/o0np/0mLfLsYKVSOCik8P3lUYfrWWkBC0FJtBT?=
 =?us-ascii?Q?gNiFZOxVbyX/tlr0Qj/S8Gng1ZGWaUzt/aOVDISL75WDs7ic9avzqxAVgxJ4?=
 =?us-ascii?Q?cW5Bw2hIcZLeioulmQN9K0bAUiosaYEAtwZNrG2D4MTh2/vxAghKo5ErohJu?=
 =?us-ascii?Q?5iZL/oUsEKj4QtRby+RYBXYA2pLseaHoj1ef/ScacjxwOHUrrVDSXnofZfDc?=
 =?us-ascii?Q?IeLnuKU5PFJxfRVlhXL19IYb038dzUyY0uDeLEmHUrbwpjpcebkirVBvAoTP?=
 =?us-ascii?Q?diZawqh1chN/eyR4AZ71cfsXHRy2luoe4ZZis4QqLDjvL3dMmxOGCTookgk4?=
 =?us-ascii?Q?6E4OYGEyXoJleLVTn5XUrjIx6hmHuJ/N3OCQtEMHuE5DDwBKC8qEvKdcZPJ4?=
 =?us-ascii?Q?Xa4NfGOu8DPiUb5atcn32ou3N/RH+cnTsAAT9w/aC/drQZ4wtxE71Z/5nMPr?=
 =?us-ascii?Q?IjpX2yqMDKybTzX7G2hUSD/YFxGbVMGIIL+lH3caA1NEU0LtoUL4FgiasFZ/?=
 =?us-ascii?Q?YrwiLJBJSL1576Ndgq1wM1dhS3lPvNhQlqPmBRJ6FPG4M92nuqwUWqlBQOwh?=
 =?us-ascii?Q?NCDb1URc6JW4ARik8zt4kBV/UDHwSLrxiJv+Djgr6ScV4oLdz571Ox/5dslY?=
 =?us-ascii?Q?aIH6RJMqNw6KFCdSY/mQR79pGVdUDmG2zARh71mqoJOjrq69yYk34HSbzeJ1?=
 =?us-ascii?Q?dvZYopDb6Faa3tddcy625ItE0qOhxkjvDH89gZTG5aNSeiThjtXUCgngb1jC?=
 =?us-ascii?Q?i9TPN6Z/WnaFqeNtlX30Gxs2Ro50EizH8VLPOP1z5mze6ulgBz34yc7qzEoq?=
 =?us-ascii?Q?T+D5idTi15ir9g/adMXhNprSu2FauDpQQKuoT217bk10SY/HJ8TDPXIlLrNi?=
 =?us-ascii?Q?wxB92aukqJKGJp1egyvBc6xicDEix1NmtKijbKuxkTEgKMjvedGyM409/dtL?=
 =?us-ascii?Q?foFyYbr2QfNzwEUQKaYOLyyyNRci6Nh4/e+aqTv35jry9uKOh1X5jRf/PwDZ?=
 =?us-ascii?Q?tgaEMkyR2WFuvTYHFssSnAVz46wccjupFLQWSnK9fybAxPePPaG3MKoByeS1?=
 =?us-ascii?Q?VoavOAYlplLNLi4JSHLPJBYe7UiGXR+1qKRxH3ToNIyQ8wN+PqVAc8VIGoie?=
 =?us-ascii?Q?0JmRy1mWhIxrr9fhc65qZypQOJxpUdVv+a3IsknSILlCsBAae+X1UuoGnHWl?=
 =?us-ascii?Q?KKHnS5/xKe4ksNQthBxw8QJpVBpbmHrhpbkiR6hKUMe2g/x29Ql4kHVQ1w2Y?=
 =?us-ascii?Q?cnK7gQQivLuprCQxl2cEVOnf/2a2jaXobejeosMTR/B/9CSabfYWeKJpOHYK?=
 =?us-ascii?Q?md+LmAeqNiqjLA9XZGLqm64XmtV4OnCO72K5chpGxfBIhugOU6UL+XNZB3HE?=
 =?us-ascii?Q?evUe8//rLLMXBIdynSGBg+OlfTUxU1rhng+KyWwD5eYADpGdJLKbdObvA7/t?=
 =?us-ascii?Q?FI95tEzQGA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad39f19f-407c-4f22-262c-08de79a2d007
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 04:02:11.8543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9J+cl1lCu9iS5mZcudFLj9kZSXfimsCMKcqT3FNiU4ZZQRzfuDZiidKcSIjut2wnCPffUXtS8fAYV76ShhPJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7327
X-Mailman-Approved-At: Wed, 04 Mar 2026 05:22:07 +0100
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

Added environment variables needed to support distro boot.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 include/configs/socfpga_soc64_common.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/configs/socfpga_soc64_common.h b/include/configs/socfpga_soc64_common.h
index 4d333c63ad9..14c53a1da5f 100644
--- a/include/configs/socfpga_soc64_common.h
+++ b/include/configs/socfpga_soc64_common.h
@@ -144,6 +144,7 @@
 		" ${qspi_clock}; echo QSPI clock frequency updated; fi; fi\0" \
 	"scriptaddr=0x81000000\0" \
 	"scriptfile=boot.scr\0" \
+	"nandroot=ubi0:rootfs\0" \
 	"socfpga_legacy_reset_compat=1\0" \
 	"smc_fid_rd=0xC2000007\0" \
 	"smc_fid_wr=0xC2000008\0" \
@@ -178,6 +179,8 @@
 	"scriptfile=boot.scr\0" \
 	"nandroot=ubi0:rootfs\0" \
 	"socfpga_legacy_reset_compat=1\0" \
+	"rsu_status=rsu dtb; rsu display_dcmf_version; "\
+		"rsu display_dcmf_status; rsu display_max_retry\0" \
 	"smc_fid_rd=0xC2000007\0" \
 	"smc_fid_wr=0xC2000008\0" \
 	"smc_fid_upd=0xC2000009\0 " \
-- 
2.43.7


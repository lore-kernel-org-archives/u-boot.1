Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4236EDEC03
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 04:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A20183FA5;
	Wed,  4 Mar 2026 05:22:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="h6ok2c+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 612B083F61; Wed,  4 Mar 2026 04:30:46 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32C6C83E7F
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 04:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DeCtGV5yrfdVPrzvdvuxLCbnfH1FogYgnGEr8m24kFOSKNLJQ1kYqbNMaSYvFCPrsF2qr2nxx2jRYM8DIr9pBQ3CND2RWoybW0Fun+7BP/jiBq6yqDGUIBvKTL2Z7B/frKWzcx7OI8La9xdH7R9JlL6QQBrDACRH6Fema8HqPlj3G6jw8NH+NEy+FTNUB8jAP/rr8QU/A7Fn8YI7cDF35DrFsTXFtJAY62+Mdq2WpXCeKfPxiBg+WpWXfJTCW0hyKSduyQgONuLmehYhQpPrDOXg1X6FjTsy/ZjduaffRUjly+WDiG6LhBh1k8IS4C62iJucL6DXfuMVUvOY/+7s5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyE0OgYrAutFttfDMQMymRJJJ28Nnf/mljt3Ynpd1lQ=;
 b=FGLVNP2zRop+bv6/S7Eo5Apil7twKqcGFIDIiu+Uka+ec0OZ5uOpI+GrbnA8i3efLfo8QLJzQHOZj+x/5X0orr6j+3gSpJxNVndGdsl5F1tjj9UacFHykjTGPGUv+vkxgnIl+T14ERHKJIHp5GQCP1KuE3p6lnRTLuhuP1hqYLqI1yw2AUosxnjt+QIL3amwoxx8ZIkHrCL9Y8f0R6bbkairhO7BnVVoOeb2s/mLVy5aGyoZLx9Me4tlwIhccI0FB+GLIB8qYOFWjjSAuJEBxAqttmmKN6AY25vRazu2iUFXYRKhXWFDuepFQoEY7JBoZuC8mcY53qk4GczvtJPBBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyE0OgYrAutFttfDMQMymRJJJ28Nnf/mljt3Ynpd1lQ=;
 b=h6ok2c+zhGbtYnfHB3+w1SqKE17AMBYEt6Lt843NXmqSp7CqHenIWYgQs9yXeBndICi/VRUydS/yyyRHYJKG4yBycHenQCZEn9Pf/bJ2qkoXykQOFUjGZ6pVJ/yJ08/50HZxtVs8K0XpbJETlrkNjGl79+KCthjsWMycj5P4mtAh82trbZW4CkL+wgrfSb5SsSfBeNnUT8VhxxBRAbXuscuuwG/5v9L6z8ooV/J7kNQEzv46KfGYNpca77fKWZXphuhauaJ5v0oinXEUJoNsVdpzwGUfaQfm6Hh+CsuRUW1lV2yHCVAhMNX/A6n3/dalqMwDHd93cGjKzB824t4f1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH0PR03MB6605.namprd03.prod.outlook.com (2603:10b6:510:b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 03:30:41 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 03:30:41 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH 0/3] arm: socfpga: Arria10 SPL FIT support for SPI/NAND boot
Date: Wed,  4 Mar 2026 11:30:26 +0800
Message-ID: <20260304033029.10825-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::17) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH0PR03MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c68688c-ee67-4237-3a94-08de799e6936
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: RarWQlfKA8n75+/NXhkxNLO+DjuCqfQlhWvEateleqfLbAj44a9jyfKrAr1Z19tuP63LC14mloCdWRL5/REzbNg9BpGNSolYQ4eQEciuRDM4Bp/f09MrtQYq+IqrHc9RT/nZlaE+RIWzQnzkJWRwaYfjfKyZ9Zb1XjzObEzP7xSL2d5MKbReDnlsARpPgqXxhVcvmSiSAZoz59ZOZ7ElbzJoG4YLpX9ea6CBDgZCFOXLgHhXqKcHQGmZfbFqMnELc8SkmG45OFPiPx9EL1RibgC5uN7Rna6HbGl4PEZv7j5pgCiePWDFXcGu6B8NxudUUfaRybLCCSaRA6KiymGEuQkrshjUv2FgfQGxoAv6yjhKi9//phDpKxuW4wwX6Z1MVqqKNoenvlb2T/+Q8qLXlwM6hh6c4qDl3FlC+otjZ1WdfZl6dqTGxhlCIg4oWwSLJ10/RA5flT0LbeuYVHKmB1CEq69+MTxzk/Aks2fFQhEfLGd60KbXsfpQstkjmAm8451Dueg570I8FELS4Cvwz8D8zjh5kjC5Wbaq+7FbNE9PLCLznRTJynhiiic0POScmfZLNjayPJF3G0zUbDBkty7h0u8Ba1QfeX1IcNIpxaM+67annIEyXvC8o1NERhnHhkJO/s1z61Lb6K8Uvb8xFABeERJfIb51hQXHZ0e/tg1NkdN+pzXgR5+baxpT1wo3Pg+FQEUe9GEXMxRs6l+nJNBAfJp66BJHIlOwC0uNsGw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1VoPQj5JB6Ai31bvAFYQd6SAKw7nHl2SpZcFe9uoQCN1ptRtcf1LONbzXeU6?=
 =?us-ascii?Q?s5QLyYQiNFYrpbAxW5jY4KZzC2l6zR4MaJ3VQJ8WTqv6NtjcUsKdvdfeCArm?=
 =?us-ascii?Q?ObDuLCrxiDE456KAM6qgvi4aw0KfnFGjV7JmW63RmRqjCUtHWeEEpir5ETTw?=
 =?us-ascii?Q?/Ng5TPO4UeFlnJaH4+HStoQDKbpwsm3FmpZoeFmyrdX3Oa09hzYwOU/U4UyG?=
 =?us-ascii?Q?VGvxJctZ9ssncS8yB2ZLO0NPWniwQBKUvd6I/lsvz82OPWIl6ohBOJ9fMGEU?=
 =?us-ascii?Q?ka1lfIwZAykQSXAeTBrxO+0Hi9TEpSDfUEZ49mD2UdUcFbM7hUY40zXp6w3L?=
 =?us-ascii?Q?4bnErn07R/DAQu7H7GuOHOEqAeRtoxdpXap74CCS5cjs1AkbrhgcMG9liTtG?=
 =?us-ascii?Q?1pjH5a35Juybg9onXvtMQGAseewUsxGChpz4qxSUT55GE8P83RdZB406mar5?=
 =?us-ascii?Q?QMlFqZFVq+uvEei2XoL6tbqSRi7FiSGelnP/zfeF07N+mw9e196YJKpZmXsS?=
 =?us-ascii?Q?0NgdcsxXHAQ+U72eyIbBnmCeSRDnkLYG5Q3nW9lNqvXDboynvcfcWzY/mCSv?=
 =?us-ascii?Q?ItCYGGJAFJSQ11Ymv9J2vLLsdBVA06nIBjkCHVhE+YGxEB5SNv8RoIKtK3kk?=
 =?us-ascii?Q?0RQh5q8divFS2iGPPBH/D+TQwaAJiC06gqbZGe/sI61hnV2soT6bBkLbW2p/?=
 =?us-ascii?Q?GE4Obeu6kwcnNsfj4TuviYHojVaeJmTGpCebF6FY4G5O+YZjNh67G9eRzoeO?=
 =?us-ascii?Q?YvI63pFh6moF0lgHWvppfhyqNIfsAMYYFNuxkfhymxL3rB0Y6Dez0+U+Lgol?=
 =?us-ascii?Q?B4KhguTcPxAaOva4mHyi+Yu7VL4qOOhLtJ32FPGAW9tHOZ9wKkuhZKo5Ci4k?=
 =?us-ascii?Q?qGtnVWcTMBLuVcWIPTgn8BZKrfAZlGo6RY4CoI764MuyomR365soAXdsMBaY?=
 =?us-ascii?Q?oMk6JWltWUQWtZYiRXRk2Qmhkg7IthiLiCeu1z3lORO73mr2uBjNsnqvozvA?=
 =?us-ascii?Q?sq5zAYlmEXsS4lzrBp+N3cRHSDIDGfJi4Kyo9vtznpSfe1xy8CW9FxmiSV5s?=
 =?us-ascii?Q?l03fpj4E8vG5Yfb1XjJaPoZ9yeM9LVbefIZpPIM42ddrzZt9aK3oNfM/xxl/?=
 =?us-ascii?Q?+CUBROjK9DkzWDNpi4wlwZEK0rRNTFR+U0Evz7Fvojemn7GO74h93wHx0VLF?=
 =?us-ascii?Q?hc4aahwzRsTFUHGrlYjF3ILeegH1WgUqXrxvViloSSRtocZLSSKxZ2B5JD5O?=
 =?us-ascii?Q?vnFmfQH5jpVK1ibfZ9LVSSf6AIn8CQHuT8qoP7dWhxTPzwoNTesAUuuj4n+N?=
 =?us-ascii?Q?8oInNJJrvFbu+LKvOlbW+3YaOmT6P+f9Vsf+eyVunWIzj8RdTzfSx1MzQYAB?=
 =?us-ascii?Q?lp9nASvIedtCT7UW56vhBZjtv5xaayDFwiueUQfmDkdAJc5TiZOiP5PCvSFc?=
 =?us-ascii?Q?LQHqjPrB8bF3ryxN+GHYlog0pYkuibVSILArU8v6cD7FnkVyCTU8VY355Yam?=
 =?us-ascii?Q?zhkTqbrFRoSiooHSZsHUp1vtSipvoHSRPETlme4bkNqCVKVtd9sD43rri5Lu?=
 =?us-ascii?Q?Q4SxGxXAmcC0jWJhfQ1qu21kDkNb12f6y8G0zk73srFULo6aB6uC1aRKxZ/U?=
 =?us-ascii?Q?y+cmnmnwD0kZMM/+wnTEaZ3wp1jECOaM/FjZBQowWGxw106gOIF0hBtiu/Bm?=
 =?us-ascii?Q?9X31E2dSnlaOaEKofMUZAjOzngFOwSojhBzw2vblcq7sMIkYWHp6ekH+KU4o?=
 =?us-ascii?Q?mjHvuJgDuhTXvwePMz8hLQns06WVQN8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c68688c-ee67-4237-3a94-08de799e6936
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 03:30:41.3952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCdAE5+vzDps0s+rxLIOshs14jh3QddW/pVh8pkXwsTyWluBS6nV05id3/uPrQ19417ETBCV6UBdsH8n+6YHa3cev5E+B+1ePMHJB0I31xU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6605
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

This series enables basic SPL FIT support for Arria10 SoCFPGA when
booting from SPI or NAND.

It provides a fixed SPL load buffer for FIT headers and a minimal
board_fit_config_name_match() implementation, allowing SPL to load,
parse, and handle FIT images during early boot.

The changes are limited to Arria10 SPL and are required for FIT-based
boot flows from SPI and NAND.

Dinesh Maniyam (3):
  arm: socfpga: Use custom header target buffer in SPL
  arm: socfpga: Add SPL fitImage config match
  arm: socfpga: Include required functions for FIT implementation in
    NAND

 arch/arm/mach-socfpga/spl_a10.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

-- 
2.43.7


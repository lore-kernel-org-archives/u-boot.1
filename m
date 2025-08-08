Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE9CC87FD3
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 10:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DF11846AA;
	Fri,  8 Aug 2025 12:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="D0xeK3Yj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBB40846B9; Fri,  8 Aug 2025 12:04:31 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F13B684559
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 12:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLjQMLAwlAfghhN8+qyX6LISVefYuQ0HjtwFj4RrI4K8PwmxKSMojjsq4DXlTTL7EOehpPRr+FprN0+ou/h9rYltb6reGyZWIY9S7MgLkkKNH6P2Hk/GfByMc0gaFvJBitauEeZDY53dabX55FHw1L8fkYE1mH1s4IEIjwzyK4M3RxcuDBYebbesiMET2icSrRy77vxkOomBTaTVIrEfgaiIkxDwC8bO5nOGtBlGRpqaTZyOlTBw1UpbHIoUlgEoV6uVuBy8ladXoCcek5gZz/GOsQTVd7OeBV73a3Ry6UiqCTcWC5XhDgNltGq9VFQaOSffkFZR/7Wkosh/Lo66fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njI3b6SOjINJfMTWTmrkKd6tL/1avkflrbL9rAAydbk=;
 b=aDj/JaDKJgMXUMIA+k6ARHURLkDd+3Crbjy43Q7+1aXrdYLn+j70stCrhDcWZ2QSR4P3sTpc42Rcm6XcIMBzFj2+n98b/w9LmCGTocE8W79lLhQtrHL5QW+kbkRLRyYlxUnQJ7nHkn34KclMe2YaOLXi62N+/OXXhX83WQyfdXKSW9RPHQmbBYSoWvwVnwKKj31ity+o74YMe40CFSzoD5AaDPMMj73wTTdJRqrQckZIe6bAPtRhcQY0y6tHHgzZV59vWRAiukTYIF3SWWROf9E5k28UetAk+1Mrb2FoBq8oCoBQtVgZHlMpVIsbvJVVl9Y7rB/xrs2Qs/NH2UNvaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njI3b6SOjINJfMTWTmrkKd6tL/1avkflrbL9rAAydbk=;
 b=D0xeK3YjpweF4/pz/NcHeLROvjVbN5MGhLc3HlQy0/2n3lvnS5tIipCnlpFEzoK6kLh7i+DeljPc7Oxex7hrh1ECSJ5D8HFc58EHjzD2AM59bDSNpC0UX0i5RAmT1z38zW9Hq/WlJ3a+IDqLo8d7VcsLQNuj/AGnlTgOYXaypsPHyqGQDHj3WZ89ARAey5aS+nbB8ocZezRz11xUT6NowDmyJ206n2D+eZHh1sRusf7JMKjA7CE4g2wSiRX1NGpaUOubZ9G6cHCv50QnMxhlTaX/RlVO52akAqiN5Shar4ollLI+Guz2yKOj8WL8bzwlvoLPPRxuDV2ZwqJEj0V7HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by PH0PR03MB7113.namprd03.prod.outlook.com (2603:10b6:510:298::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 10:04:25 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 10:04:25 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH 3/4] configs: Increase USB Hub debounce timeout in Agilex5
Date: Fri,  8 Aug 2025 03:04:11 -0700
Message-Id: <20250808100412.9320-4-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
References: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::18) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|PH0PR03MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: fea64a0a-b3fa-4537-c958-08ddd662f43c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y+6mif5lQgvesLVeSj6lmJ3+fIn4HgDv0i5o+3LjslPxypvSiFSz1DBAh9vk?=
 =?us-ascii?Q?lVi7EiFWo42UiOF6kN0q6dwuQ7ZhQIOvPlnr4vQn27pNE1HwoNgxy4meCgjK?=
 =?us-ascii?Q?W9HqeBOFL56UE3LBbfbxPJ4LNb13IAj1X08Bx5Qe5CVGpds7BKRsefksRjwA?=
 =?us-ascii?Q?pkV6BURD+qPeJMBar3RtUs4No+QLWRt+pfdQahxjPbEB0MqS8nEAx46bd3Nc?=
 =?us-ascii?Q?GaG6KYNIuUde3+cFGNMFbb+NtV8MbSWwd+4Ndhc0QtGyhLCpVpcexcbX3yla?=
 =?us-ascii?Q?R3aOeCydy83irScGOehoyWPYWTQzO14q/DW4yl7VnFcr0bGWF1yIh9djEZzG?=
 =?us-ascii?Q?iuC3lWRNfkiksxq6brwn+AgbIn2JrC27krFG/LZ0aEcWc7Ah6QoUJhZyG8kz?=
 =?us-ascii?Q?pzFFYXS/hjIuRaLkxcGWtjou6xe272larGieqV4Sk8CakdPWBL/v9a8GR9+l?=
 =?us-ascii?Q?OEuETKWIUfyr4UAHSQpG35tcOUB796ZT1yYsKdWAbEFFQnOR9Y4MYd8itEZk?=
 =?us-ascii?Q?8KkwGF1uCVEJ03vFNK8SlREjLAEXDlm5s4Qlzuzd/xivCShkl4+PFlawps9T?=
 =?us-ascii?Q?aJE6i5HlBZTgQLTryHHlByVwoUhaAVRC+VkxbhNaupU4Sq9Ol2xLTw0i9AWs?=
 =?us-ascii?Q?bjrNdcmDAapBiACLcYFQLwFyRnhMkHmGZUDPKcPMuJQxJmzwvEb5VsMSyPrW?=
 =?us-ascii?Q?1NTDd3Nzu6D7n/1daZOTNGjM4FoSd43LE88P7DfZOEuXtLxk6Per7pzQGTBN?=
 =?us-ascii?Q?OY2IrKawtBU8xB8crKGkzFmnjJoAPkYQMWJgIgD03un+jiO6Svti5c1/LYDw?=
 =?us-ascii?Q?2W33AdTHKovYO2kw27OE5exJTEFrLOzIgg/QtRiO2cuT/nfU40QFWDyFeMJL?=
 =?us-ascii?Q?B4aL4s3wTe9JcXODzyTXhzAQWbm3LJp3mG/2zBj08pNE4lbz8JUcxua+1mwK?=
 =?us-ascii?Q?/kMvuzzRMnYC43qqrZbZFPN8gIK7wl28f6xkk37zo0WGtmWbfSZzEtTuG91t?=
 =?us-ascii?Q?r0cvmyhdFY834OqRH2OMXvglVPyx9IjKvDUDBk0uXVwYIjdv3TCu04jLey1r?=
 =?us-ascii?Q?cm09IgAbSOfStofPF2UkZdWjJYuSHdjYyElJElibKWWAUbh8+yx4sN4kwpM6?=
 =?us-ascii?Q?a5WOufmYpkB2jatZ5oA80AXn1qvsqoUIfPQKxSPjyHoZvMPKPvXZRWplJJIB?=
 =?us-ascii?Q?rl9tFH0HlBm00WGJJQXiTl7QKN+C9HOVx03T2tggQNJCukQfoD5Ts+GOrx1b?=
 =?us-ascii?Q?O4HExKmcWDOXqRrzo4n6eitBNwCpOPbyPBBWNrJlHucOK7y0WKNJWPxRqwpr?=
 =?us-ascii?Q?Vda8OgNdMHJuKEMoB0LJ7R+loZAcSBXk7DGC89ibc44hPc1PbL0P/ZYbHuHa?=
 =?us-ascii?Q?Zrf8dO8q87LhDkYwPQNkCmQlmC7Bk3a4Et8DD7AjzHmtdTKgytGwc4nhUYbV?=
 =?us-ascii?Q?2KvVM2HgB4w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3AKEjU3QZPPCW2DkVtzlqKMNpcevApVNH+1BGnPPMQOuFHBDHgwX03xMz925?=
 =?us-ascii?Q?wxXILBNcGGdpzonDy4zqjXLJavbGakZXS1UTjkr4vwFoVPMUDBKWzV5hX07f?=
 =?us-ascii?Q?2kxZf60UgdT1ez1i6wzIMDu5EfrvQ4/op8213YSrktr0XCAye5Er5Gyvtse8?=
 =?us-ascii?Q?0Zp13phxr6XRupV3pQJLDPIOvrxRSIbN7LDBZe3/ZR4btbTLc77dvwLxJiQb?=
 =?us-ascii?Q?XhLqve52EUDz5NamBl2uj7vHG9FVr+HqdoHaEdpT5vjM4B+QqPGTJdo5bdrN?=
 =?us-ascii?Q?VVaMOnog8ZhDITYDjxGJpUfjbx6SMac5shd28KGRQv1BPMH273K+KRQ/6oZM?=
 =?us-ascii?Q?uwqS7rgFPETajTkhWp/dzCcIIp8mrHDf27n900TPdHQFeEzpXxOPRKu5FDDc?=
 =?us-ascii?Q?/5NTqECuyMLimmwwW6eL3o0hSQLKgRdEZIpYTypNjZM3k27P7LDm9eCK06IQ?=
 =?us-ascii?Q?6chSu/qfedklRc/VaIgEZkKYZV0Y/+xfKg9wLWIZRoezC6g7vJZgJkDqYj+y?=
 =?us-ascii?Q?iklK30mxvOydOxoVB424nIUPaFM9LebyAnYeuiQhzty7lTh387fovY3ds+fr?=
 =?us-ascii?Q?N8aRhUShIVQeCjk+pCTzaVKN2EBPHBFwnAIdXt1AFoUG99tJO0XqsjDO5Iuk?=
 =?us-ascii?Q?Yp1ddw4fQwJuKdG5BTLChHMcQVQ4H5AKwhi13pw+SEuvrOUWUlwURr+Bz/8U?=
 =?us-ascii?Q?RmItJsE9dWks94wjhAs7RQhmRTE5sNbwf0fgNMz174yhD5ovMF7wGrdsQ/iP?=
 =?us-ascii?Q?tiJkwo/PbZ+0DUK/avd2Ix5GA+tMZnZotFQoWFvDqVR2Do+j2FBIETXjwhke?=
 =?us-ascii?Q?TRWiAAYdPYspZmZodptPIZe41LBVdOHOvFWOjtpvNzzkWCbOkIyMbkkZHr+e?=
 =?us-ascii?Q?a4lXp+cU/0MfclRF3twhx7LEzl6FzkqFOIRFtUE+aL4ahREIz77h4bqhAqz7?=
 =?us-ascii?Q?/Hwfd3mcTFVabgcMEAbefM0B3eYleHXJsVQnkB6wf0xyvkPIRVQtG3CSHZzH?=
 =?us-ascii?Q?HInaZg/wg9lHnK2h4lNuHCtKC2ynmqoqFqW2o5gLcjd4zdxb+zB/HUscYIrj?=
 =?us-ascii?Q?PCczZ+Do21G93U5cyPLJR7snEH1D2swS/9YALiQlmVVr/oiHMisfh3VCs5c0?=
 =?us-ascii?Q?eIlnYacVm778YCI+NOEReQ7dQ1E+DHPD6cfrVU2rjVxwwZillrVMIo8cihSR?=
 =?us-ascii?Q?/PO8G/pWLqQRPGGlki4qkrRg1r0jDkw9KknWjhdKrvqkoF6jOKflGTgqIKgE?=
 =?us-ascii?Q?0JO6KnYM8m3jgfPXSpAW9oYHl5iFMoiMCIEVeE7vdv0o5bKq+hNoCDDMx2MZ?=
 =?us-ascii?Q?CE4eLQn4RL3nbS0UYbEM+1TQsYgMUDPGbaQVt8BWS2+rFPviaY3eSKH+LZ54?=
 =?us-ascii?Q?g8xBzrrQRsbukcPdYba0IRJ+h7myoeAqHVvHuLDPI07ipvYpcI9uhLE56Svg?=
 =?us-ascii?Q?55sLCl/aH0+AtYBBGYOykQ+dL/SlW03nNgm0h3b9KCLGWU8jVpjwPuq9KxKp?=
 =?us-ascii?Q?0ED1KMII2itMYM8zzUaYlJH3A2Ilnmo2sLVScQgaz7fLrxVz7spXVod5oW5P?=
 =?us-ascii?Q?76ou3vn5omkYyVFks6TAw3VkyKcm3lkr+gUJ/eGpWAZwNmThxLVEG51n17Mb?=
 =?us-ascii?Q?VxPg7nVSVxhPO3JRqIY0XVQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea64a0a-b3fa-4537-c958-08ddd662f43c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 10:04:25.1373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mi/0TpxzkkDirHZG0oLRIJ8/ZU2/o5PEcWbXGL6qkMvo6SIg3fu+txPmYaUkxK2RE30NYIA/+Ocsl7xEbqLsHLO2AFy/3bCvg6VhE5aoMsSa1iKisRvnpKgls4ialsLx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7113
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

Some USB devices need more time to be initialized. Hence,
increasing the default USB Hub debounce timeout value for
devices to be discovered, connected to Agilex5 boards.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 configs/socfpga_agilex5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 859750f02e7..6f7a2cb11a5 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -101,6 +101,7 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_DWC3=y
+CONFIG_USB_HUB_DEBOUNCE_TIMEOUT=3000
 CONFIG_DESIGNWARE_WATCHDOG=y
 CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
-- 
2.35.3


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C950ACA0EEB
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 05:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12C9280B9B;
	Thu, 21 Aug 2025 07:38:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="niGm8A6j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4927482E37; Thu, 21 Aug 2025 05:35:53 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E58681E13
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 05:35:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3nZJIir0unkmPb8ZUnFA10r15fz19kZEq+Z+BdAAjc73FQEwSamQMAiNc5DWsH/FwOBIyy5wfdg7F4/ZL4chOvQ/e7awhZZ+VVdsl9HSOOgwC5PJnJR7D3KNzuMxTCGtfhxkqDQGem/5uGWEvy09f3fz0ZEvsvXNswE5wyXlG5Wtiae0FzrtHfaPfXCxXyBoZU+NTTsRC0q7Fckap+ptZP413p/wfavgFwmuWNXGcnc7DbNYs06WFp7/vabAqPchlGaMJzgt1oFNdsCOOssfuecNqHSIi+GxVewGeUvEoA18Wn90R2075FFp56UOqszXDctHmOPqDWPs85b136MVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBRxnO4pZWIIs/dw9EOToz0QQpSloxRlFXScn2l+Wuw=;
 b=U/ItGLidBnkouB92AEqH/0btWDzoFHj6bzTyIWC6Zmhbsg8/tMPSdNasJ2+6OajUo1AOADWsIcvBCIBYxcaRXA+rhG7SN4LK5ogqe7AIZbNK0Q7xc4hNWlNYPveOymAGzi0wJ4Xxfh/6G1r6N8gRZrfTO/+vzWlPMeeKVhs8n+JGuE/Vdc639HmIH9F5QIgawGrKDglgzMpwj43PAO3hM+7ALwzpWPeCLNCvMCVwUroLFoxyqKWMHbaUvrVIVwCYZ5T2kz6tuvIPVKUmGhUZyilp0oEnnzUzbrzXCSrYjhkEEnjykr9TN1oBdHx4Z8FeSOl7yE6PaTdtSoevsJkOdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBRxnO4pZWIIs/dw9EOToz0QQpSloxRlFXScn2l+Wuw=;
 b=niGm8A6j8uhFKFJOPgpVeOBsfYvePFZDeW8CF07Zz2gwE56aO0gHrD4bezs3RrqgO8tcUT30nCkKvBRESNetPRMUUuRphjok7xLS0ytcTpDTnEv+83ZRxekmfGuJFuLE93l3g7pmCK7c82MAcqPc498e/IQgmoQC4+fpzbYBbTqWwzpaoV4fPmeta+tT/9unXX7SRRJ7yLG2Fckm+nrfFgohPR61r/JtYIo9Tzli3cqDlQCyNHPO6FFrGwpcOa/fizAOlj5mYDgk4KEFJqv6Z0L0J9tdLNQlwG7IKBaQ2L2W8CG6lzV6vaCSZPAUvDk8QRHJ+t7+9NQZKnSxUG85EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SA6PR03MB7567.namprd03.prod.outlook.com (2603:10b6:806:43e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 03:35:48 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 03:35:48 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH] arch: arm: mach-socfpga: misc: improve help text and usage
 examples
Date: Thu, 21 Aug 2025 11:35:31 +0800
Message-Id: <20250821033531.12750-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20)
 To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SA6PR03MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d4ae14-67cd-4662-4069-08dde063d152
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nXOKpefU6IkgwkbRYCDoEgZXfV7iwe3ZXCt77QuwDsd5q9L8hGAKR9JHW8wE?=
 =?us-ascii?Q?AIyE1TcyEzxRmEGsieWnylIzTLb1T9Q0iRMp0LFt3dv9b6tPvMIrB1OqVWqJ?=
 =?us-ascii?Q?1+MiTxMPbzOLtJIABT+OvNCgO7YeVGC9zqWyHeXTz7yZSyqOulzSq8pTTq0H?=
 =?us-ascii?Q?dqmKsPjXXNRD270gMoh1ol0KLfbFE9YDnanzyoKDq5Mzsjx7IwyKSQW1B58g?=
 =?us-ascii?Q?Ub50ljD2u+BIXHkem6nhdhp9YtzUbSQPtCTaoBwfgr1UxrIXnvta3EJ1+hig?=
 =?us-ascii?Q?Zxyv2FxLprTBUi7ghHiG0p6qJtnIJfx2hCG140/3LXqc74JWlVd51nbbsukJ?=
 =?us-ascii?Q?IwacCPf5Cm16S8RPPP63SHRIQ6wms2GCJHnaZ1tYM+4MU4dU2Tw+UfH2/Pgn?=
 =?us-ascii?Q?Lc9qUnHpjcUxuHuxfyDdGA5y/oRUaGmVTz4OW+BSNNG7kfRVkPX8PCKDy6Bh?=
 =?us-ascii?Q?po96A86BFA+3c5+mWl3ra5zP6eh2UCtoxQfbHg/miL4CGNV/HIRt7hpIF9f8?=
 =?us-ascii?Q?Hm+gkwuXFuwD+BsxmOMtHXpM8RZLYnszbzh9tEKpcjyzy1V8S1ZNxMR4jqhc?=
 =?us-ascii?Q?eaQ+JSvoeZ+Tn8/pbgv1fnht0drAKSANpJakr4ANXwHWX0kOFEJuSNntTtpM?=
 =?us-ascii?Q?SwQCC02Z8ehCopUwSLN0FT7J6M5V9Q42Ix5ju/5jo3+2NOWQjLT8KZWhXW7z?=
 =?us-ascii?Q?i03769L0IsNV3wpnjMky64K1jMd1saRT5U7uXGoA9zGqNJugJasNjuh2eoWl?=
 =?us-ascii?Q?DQYQNf16Q8W2kG51WDx23yTDMcRfGZYsiVEAcht+WJDROuCEMG9Dcx/zHSPo?=
 =?us-ascii?Q?l2OZaW7Z0nLycTS5tOgiCbCtktEl36i8KfE5dZwCQl+liEwsDDZ0RZAy4iwA?=
 =?us-ascii?Q?7U0D+K/w5wGbJwsbmWznAu6ESAjk/5h2K2Tuqr7CJbRWHxsFATvXEPsWmCa0?=
 =?us-ascii?Q?KxgRD4ztaX/L0jwAPdqciGYZ7Ht4kKWkQusUkZAw89uDGVkPtVU4umr6IAw0?=
 =?us-ascii?Q?GuBDvUq5OroxBn6uUvJfToaY8LoAszZ+XA0ux01gRVe/FyCm/VfLt3iRkf00?=
 =?us-ascii?Q?ixL4m4I7rrts7YQZWsA8BP4LOPp+nrGj7pO3GT6p6dOOQ5hu1IS2mPY7XJXP?=
 =?us-ascii?Q?t9pD4w47smunq31Lnb7PmhgAQEuWuUmvRcQpLc37A9EorVw/OAobfN2crA7F?=
 =?us-ascii?Q?Gk0qUbY7KbC8lcSIyGIkc0kTY3cPp+LGJJFCaQBHcsVXf4OJSFwnW3H8ZjVp?=
 =?us-ascii?Q?qq/8jPd1HUi9IcCGW//JpwCJu99sL34aYqpM1dpGAEqvRblhYV23+pUyxjXv?=
 =?us-ascii?Q?GWdDqQzmvwuPg8nD0kXluMtwzZMDy2QNSIAewL3DYbX9hET1HoLb9Mmu97mL?=
 =?us-ascii?Q?ye43fUhr3rgTeHBJrInSdbQ8RslExdtfOSrb+oTlmrl4Ag7SvOSk6/pKGqOx?=
 =?us-ascii?Q?qeizKcKrats=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ar26MaGdAVN80StU0VHv9nrNTjucw0WEbgt8VYVJC4oKZFPHi93PHm8Qt2l?=
 =?us-ascii?Q?PscyGW6IB6ciZnxFzQTM4IwnBznfjw4prtXF9isTY+nM5wKhf9EFsdQ+WmbO?=
 =?us-ascii?Q?HYo2jPr8/qB5EDOraCbv0hhXyWf4iqaLP/RQlsPuZuiqRElwOrPbIZsdRFTe?=
 =?us-ascii?Q?37thcl9EJ/uteWBjLyCkQiHvdjBC2R8AM/1UmP22235jEV15GpufP4mGnd84?=
 =?us-ascii?Q?324vgb1uRpGp3GI9sLO3VXd3dwkWnJB63qN/+fLOI9bAei3KMx/9BCc0hNVH?=
 =?us-ascii?Q?/VcH26fHGKD/8B8dChz/F2upF0L099lE7DdMEGMMo4LPofqtKPHrs919wkza?=
 =?us-ascii?Q?15uEcux3qsY0hiYlsyH4ECntEribrj5kK90ePn7apdhCWkw22nEOD51pVX0l?=
 =?us-ascii?Q?gz3arSSANi/xRXWHzKpby5l+H8DSq01G5eS8jnJwnwZc5BPMOBndD27D2Wto?=
 =?us-ascii?Q?czFcyFPgTW/QvTXDA0ZhjPGhlnc2ksWEu6h/HrLV17TNgJazTBMfq9oEWe/z?=
 =?us-ascii?Q?XaMCsL422I24o1bIDqNnkozKp2tMlxCBtpG9vTcDAVJKVysBOfVQYcRX4knI?=
 =?us-ascii?Q?PWf1Ptj89lwg9dNsk2Emk3WlVTALUcyrUUGAOBV2I1+ZNMWw8O3lLJYQZQkw?=
 =?us-ascii?Q?afqrmnfojut9cH1MkKqhatw0MH/3n4s2P0U2kxmE4lAEgh4e4NcPWGsAqeer?=
 =?us-ascii?Q?/I6tgXTtfAIuGVRyRlSK4ySWO0efbAvQTuQDN6voijZRJ89Z2TEk64clB23B?=
 =?us-ascii?Q?+rMqDDLJCdOZQS6EISABNNJ6cHsp4YsKs7MoORZFteW2DoXPHq9j/4M6aDsn?=
 =?us-ascii?Q?uNAEcrxBu4Q62NuyDKPkPUDOojDfX5Z1sPKKFlt9JvAMCH09R7ZcxjHks3O1?=
 =?us-ascii?Q?QCOJzTlHkgrQ7oVqrZRyIQrto2rVmsmoELSCWg85lL8r1HKZCpu7eM2sNKjZ?=
 =?us-ascii?Q?q7bWCnIyx26YmKQG70xmKwzVs/g2cS3/Hf/shAm3IgKQbjI/TPGnespDV1lW?=
 =?us-ascii?Q?ovxx/zx4ZMxHfNrj2iE5s1YLI2vAXIIibFoyP+U/esHe/52l9LP3lDHgt13L?=
 =?us-ascii?Q?znhwkM9zHSpgtOY7WEKfMm5aT8CQDkA+WhGKrwmPt7PzQbeI4+TkPs2pF+Ln?=
 =?us-ascii?Q?fXlUI9N7dy/XlWok/xrCB5c0WgmEDJUNUkRJA+sAA+lYu6eR36A9RtPJ1hMb?=
 =?us-ascii?Q?BrZC0f8y5ttNPkb9jciUhbx/uU6+fwaXI6WKO3l0vkmYn0XjmgavSY2dFlHG?=
 =?us-ascii?Q?32e72WSYxfe1/tLSMI1TME8wygVN40m/dEbgvIFlMqJf9JYf6yRPTQCqw/jH?=
 =?us-ascii?Q?3VVb4Rb4O8OJS/qj/QAm9K4yFhbOhftEpHhiMtl6UxPgTrfBuvEJaA+OxX7W?=
 =?us-ascii?Q?0Jfx/0de1oTwLBrciZUQTMjqczVvS0hYirSuTUcXCa+91o3lmtY6a8e5LUET?=
 =?us-ascii?Q?T+NyRO4NZ6YTPcUum4p3AmJOlTZbvsRt8/wkKfBEazcxAKJsE0brl5wQisaF?=
 =?us-ascii?Q?LhoZKAoEKR8n3PSCKr7LqNdiEZRTK+2irN/sA8Km51lNJaFgu9gWMCVsjHG4?=
 =?us-ascii?Q?hPE6LHohdm4LI3TjmzdS93QHlIPEhAWgbxrukFu8bf3+baFLcTr6v9eVi60Z?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d4ae14-67cd-4662-4069-08dde063d152
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 03:35:47.9423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cYuayDit1RowO4r2WvtKKYMwhDcxaRux4U0Xqtn3Cl1o3DqG0Ux9+pJzfl8claIje/KFN25DEm4GR7mvcOB25xDcIQL6cjxYehmVebN/fE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7567
X-Mailman-Approved-At: Thu, 21 Aug 2025 07:38:49 +0200
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

The existing 'bridge' command help was incomplete and contained a
spelling error. This patch updates the help text to clearly describe
the available bridge bit positions and their corresponding masks:

    bit0: h2f/s2f
    bit1: lwhps2fpga
    bit2: f2h/f2s

On Stratix 10 devices, additional bridges are supported:
    bit3: f2sdram0
    bit4: f2sdram1
    bit5: f2sdram2

The updated help also includes more descriptive command messages and
examples, making it easier for users to enable or disable bridges from
U-Boot.

Example:
    bridge enable 0x3   # Enable h2f/s2f and lwhps2fpga
    bridge disable 0x1  # Disable only h2f/s2f

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/misc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index 76747c2196a..1d709065fa7 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -223,8 +223,16 @@ static int do_bridge(struct cmd_tbl *cmdtp, int flag, int argc,
 
 U_BOOT_CMD(bridge, 3, 1, do_bridge,
 	   "SoCFPGA HPS FPGA bridge control",
-	   "enable [mask] - Enable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2) bridges\n"
-	   "bridge disable [mask] - Disable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2) bridges\n"
+	   "enable [mask] - Enable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2), F2SDRAM0 (Bit 3), F2SDRAM1 (Bit 4), F2SDRAM2 (Bit 5) bridges\n"
+	   "bridge disable [mask] - Disable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2), F2SDRAM0 (Bit 3), F2SDRAM1 (Bit 4), F2SDRAM2 (Bit 5) bridges\n"
+	   "Bit 3, Bit 4 and Bit 5 bridges only available in Stratix 10\n"
+	   "For example:\n"
+	   "1) To enable and disable all bridges (command without mask):\n"
+	   "	a) bridge enable\n"
+	   "	b) bridge disable\n"
+	   "2) To enable and disable HPS-to-FPGA and LWHPS-to-FPGA bridges (command with mask):\n"
+	   "	a) bridge enable 0x3\n"
+	   "	b) bridge disable 0x3\n"
 	   ""
 );
 
-- 
2.35.3


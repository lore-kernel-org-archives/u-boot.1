Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12207C83F26
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 08:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88EA282F14;
	Mon, 28 Jul 2025 10:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="DWGLCDFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B31782B0F; Mon, 28 Jul 2025 08:20:58 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9903E82B0F
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 08:20:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJnwr/HW6MUtMkPV6dZ+lc3LjeYb155q/iwyeSTTIQFv46lx2hYCXYMtTamzEW8nYjVmhbaFC8Vt8/qTRTW/TBP56sYVWvpcwIMZ81i7qd3Et0dJkaDCarKbfOVjzmvl7N/FbvZ2B4FvgEIk7eaYqZIbUsk5CepF65e12tF3i9AX/EOkDb7ebC4f7aI+04gCtpPc7Nk07S6Aux8bkYJtPe0AS1eAsO8PWATUBaExSM0IefsIrUqlazoiYNPE9sFnQ1jZUuqlnK+Cu6FRvFOT+p4Yym54JEZ156s23+JqQegowcB+BPsrNJa8+mElt+8uopH2YIDfQZJicY8gQCAaow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pwi1tCE0UtOVogiAjE/TOCjZ8URrPGI7n63mk7yFs/4=;
 b=nIVr7so4Qr43eCuHrCbu+bfeb/Wv0weKQQ/HPbDkfFg5fkDpYjGnrhxd0+uGhlm5m8Goeh63EBXQx4tmCRyJvjoBGRzAmLFYGL0RNoosfpqqScjVoxqa066uwM5dFblO+zcS2CD+gh+xlJSXZ7kC5f5bzm7T4FuWqWw73F6F4UspFvuYniTNMkiMcAYqpRnRfRMg+D1q9GPQy/0mUdveRTRgA4WcxLwyOsfNDxy1CArw/E8grhTiF3aCaaCuNQD+6i/ogrB/92JTQaASfokVZGp+4N9byWjmgkPuvUQ9j/Aytd9sjXPFvYB0uZ3D7z+kgAFYThBf6X8kObguqtQI4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pwi1tCE0UtOVogiAjE/TOCjZ8URrPGI7n63mk7yFs/4=;
 b=DWGLCDFR1729CF36iBRv4mp+WJbMuxGd8QEhDNQOfNcO2jjpw+5HxiNIXbXl1WuLVlyHAG/RvDX1BjkZmz/F6TY+lPapeCRMVuitq1q7ZEC/9Uk9lXLP03gzRVy4SUyHpK8G7LVyXQPLjZVPOU7pfT/ewEIdWHXFRRf404TwBw3Th/CWg1jHGh1WtVJi4bzx3xh3O9EXEmhsZaxXxj84gVg803wShldmFF6S8MYfVVD0DITdNkeZJS5/EDOL2hPwpA6D+0MM+ge+9DZixCPW1sAt+SSxtbtRbNAxKzJ9PZX+2SeJsY8YMP/JXdPOPz5t5A4yRli/ItNyDxG24txMdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by CH0PR03MB6067.namprd03.prod.outlook.com (2603:10b6:610:be::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Mon, 28 Jul
 2025 06:20:52 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 06:20:51 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>
Subject: [PATCH v2] socfpga_agilex5: config: Relocate malloc and bss address
Date: Mon, 28 Jul 2025 14:19:42 +0800
Message-Id: <20250728061942.15766-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::17) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|CH0PR03MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: bce0658e-dd2d-48a9-5e34-08ddcd9ee6b3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nt0GNdvauMpCyLpbapw/zgFpb0yRjEuGM72b1cwlCTFNyBvdjy/m6SeqIFAW?=
 =?us-ascii?Q?aMN/G2h3zEe5j3QY0mJHeS+/2bbgKty/lDIVV/h1fclQzrBavgp+Lun3lNbl?=
 =?us-ascii?Q?mzaA2+sheM9jDIel7C2/7n2J9ouIAoQFlt3VneGWZti4PGTpJQJht03YX817?=
 =?us-ascii?Q?zWTArpK8KI8feWQRiS/oh7Y4bFEVX4dWT7s33kFw7XMzyWKyqL3oN2TVwKSV?=
 =?us-ascii?Q?ygxogsgJCH+8HqaZkN6fg1yhe8I+tKnmmRUXfM9gWysXidXhqm60rn33KUBp?=
 =?us-ascii?Q?XdbC5rSqsdA6d2ZG6a81fUTf00rjmlQXoVopyAuGn88vUN1BTORuYFKCUzZx?=
 =?us-ascii?Q?n4SHvVnf/5KRoN3ZjrlJXsQMU38+Wxs36/2Z9XduggCXS7IbrDl42qoj3E2+?=
 =?us-ascii?Q?kCh9wSbjM3Kts5uJv9H1X5Oc9lJ3A9E3hrVXwxlmmdMvJU/H/vwMcuKt6W2K?=
 =?us-ascii?Q?wvGmICwc8xIuU6RLJfHQ+iHpymxd9B4k5NEaG4fEpy0WTS5qhm+MDoy9EDhY?=
 =?us-ascii?Q?TtURofS4wzEA/i6FK9utvHD5swDUwPelNL6l66PD46PjM5xXOsMGF90Dlf+s?=
 =?us-ascii?Q?lBCtjTf04xcmD4CNE5MUpoF1FlHmZ6euTbJ9LWKloFESO4hbLpKR7ckPz6bn?=
 =?us-ascii?Q?fyg7rHGys7oGrXBxK41wzuKkzThmfJGazRxtoRLxFeC0XMJZP/ICznfG7V9D?=
 =?us-ascii?Q?aD1SQjbBodwF6BIUqh+eNl2lqv8fzeaDRJfD2oSKkyBlCeHCTyAGUTWvlp+G?=
 =?us-ascii?Q?omRaQUlemYDsSWwRAq8Cs4RATIsOygkk7aDG50AUANtn7BINIQLKnf88MxYK?=
 =?us-ascii?Q?Ht7AL00EvOBnyxXm3UBN8USgWajVyBT5nEToZVRrYJqreNvca7hUJjf+Opxv?=
 =?us-ascii?Q?vsMSCJ3Kjr+fLWBewmSr5McKUt+SbuwDLhDKW/jiJ35GWfAz4v4XNpLN9QwK?=
 =?us-ascii?Q?J6yqO46NZ/vMCat5qaPSXSj66R3u2IfSAhlCUGTie/mXszT/So4YULQYOyI8?=
 =?us-ascii?Q?R7FQgOwOENSS8HsW7++xdgF95l4GwYxIA5JErGEW1a0BuEey5c6KuF1vRu4x?=
 =?us-ascii?Q?EqRE0v6i7GK0WgAWkclGGy7/v8FVZ7BjxQqYKqskGsGJZ0Yk2IltCARBZ0A5?=
 =?us-ascii?Q?QhBT0B3VJGpovxFXXLzdk1M8iNq4+RHrAVlKLx2BFQTBSc8578K6CluFHv4F?=
 =?us-ascii?Q?Gjh1Z+yLUcjCeksh0i8ojLrV+cIPmK+AoSXAQzTX8kBax44uCXvuix7CFsoR?=
 =?us-ascii?Q?szVcOK1LiyZ3BzSJEK3RnoV3o6fQYMxASrUJLZbENpv1k5E3/BkIFzY+me48?=
 =?us-ascii?Q?eMu2nYlitYD4k9Mfi+L1BOXtjt2+ad64XnmWwoeRXCC2JZkNVRpzV+jKNrEB?=
 =?us-ascii?Q?69qm/Utk6wQ09woQLqatsfixxB8dtEYt3AuKxsbfKNxlGSKiNumFvDBHjH4K?=
 =?us-ascii?Q?juHcQBWad4s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k1h55D4mxzkO5Tw9O06I1oAc4mIGsVEmJUBPx0a8Wy4LabWqfxvhDXJAqesF?=
 =?us-ascii?Q?icrLRBEcXDGe8hlkCgao7kRnb3Jyx9k5GvvkV6gH+SKaD0yss7dB4+HNdj9F?=
 =?us-ascii?Q?p2c71Wfx+gMbui58Kr3exrZ1fVoj+WeqcWoBOiWAQmGn1dCJdgLITEWclVLJ?=
 =?us-ascii?Q?rzjBavAupPaVRZu7ouRnznyHPuyy0UexPKi1rg8cDdW0reufXM3wbQLY/34c?=
 =?us-ascii?Q?7aGQOuu5ReWybnL8k5XXX/w7tY/YJYmTIeMbQLYM/ZkxYx4GAYMIapsA14fA?=
 =?us-ascii?Q?wa/S7VYWQmVeVqARr3+wPEW6nW8/Fng9hSCY0+kuQkPskHnQQvNbR8LCNJeP?=
 =?us-ascii?Q?tMVPlNweUEQZWfnCSdWmi1Jv40OrYNCWJGYklhRmUa+ZboNO6q8lpGl6kVtp?=
 =?us-ascii?Q?2Edn+sV1JCjXkxVW88jtA6wpcpWnduT8Qx/g/11cYn4WOdFaM6x8iDzzRK8A?=
 =?us-ascii?Q?yMygpAF0cXWZLlbne+iCjKg4JVovwtdx0tr3F2KxqzjHQ9dQljAqnJVjwmIL?=
 =?us-ascii?Q?TXFpCMBKyGLFdu2ZqzNA1aDuwtHEm6IkFvEerWJYvDolwmWiBywEtp2TCMrM?=
 =?us-ascii?Q?Khu4ujwMmewK6Y8vl3Q4nFU0W1cm3Z77nvrreHNI2Am/IXzNazvXR7H64f4D?=
 =?us-ascii?Q?ldlCK/ayuwV00cddAnFELFlnZjq1AMjZkhLYtAGhIlJ9Waeo399HWhuo4Pz5?=
 =?us-ascii?Q?vPKUdyqmifmzgztOhNCBIQ3vpcRscCEpBYqc+bHWSiIf+CmwbQ70lnn/Ze5P?=
 =?us-ascii?Q?Ei4gOhuTyxPvt+7z/bLy7L4oEWvlI3Yg46d0/6eFh/pwg4kWZvvMERdCKi2/?=
 =?us-ascii?Q?pShX0pOxTJVmjQahG9nAMNEQDKzkpCXBmYIBZAKGBqI32cmvvzwRXkNDVqgw?=
 =?us-ascii?Q?67RiVj2SBCf9vjf0qOAFfD6MUZyVvGS3UOReOYY3hYcbgt402OKx1CZ8VWr+?=
 =?us-ascii?Q?k3DkTtL06VRBjZ8Ppb9EvWlMZcfsE4JEOXen2D9rJfBa379936d3kd7UDt7X?=
 =?us-ascii?Q?lO3FxxpBHswXLegAzilpgu3nZDy2zgMpTZSqSLiYu5fXHArVgECygP2UM+/p?=
 =?us-ascii?Q?/vYpbDMchB1/Sg136xFbZrSFtPGpNr9/cqKuhfTbYoU0IyjgOoyBfqRGbSeZ?=
 =?us-ascii?Q?cmviyXs8CLbkRI73GL2VLGxBKEVYxBiNAmso0YAtxis9b9/RRzYykeepj2Mw?=
 =?us-ascii?Q?SVvDfu106R+DS16Sy6qj3rakBSKckH8hqOOf1g5GvF9Vtnzw0oNyNc1JqzpI?=
 =?us-ascii?Q?Q9NX3LfUdyjtFvyCy8idE7y+NWCbeNEmvr4hjAtCUAnRMfNFblLFQ/kN1M8H?=
 =?us-ascii?Q?5iGauUNWKETvGYjOqQEpEVCfgesEjdNPAyj+5kWEZgeXoqusvHtUp1qu8NqH?=
 =?us-ascii?Q?tU+21f9V5Txe6he4sny2ewTW1HL2J58Au1JopFHyRa6Q6G9FyCkp+aXxEje4?=
 =?us-ascii?Q?xwO/UP5uxtz8Dz5mNDyI5H2RbFpV3ypgDEkqa3/py+j6G3bx5tr0vO3LHW0o?=
 =?us-ascii?Q?8PhHjHsAviHYHsojJ30af1aUz8UW5p1m1Kq7GrR3M0O0P/BDUovZOuuCS99K?=
 =?us-ascii?Q?nyjXWElupLXtkCtg0gVbluP30yng8O4TwWRIC16vdfCnO4qJSmNFIJe91SfD?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce0658e-dd2d-48a9-5e34-08ddcd9ee6b3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:20:51.8600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WMy44XZYhIxCZU10HLF2/WkMlFKvn8zohk9/AFLixvcjA3P88w5li6ce0OtD4wR+D/oFs/R/MpPEtEm2p7gv3Doxup8ws6YIQqqXWnN9Ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6067
X-Mailman-Approved-At: Mon, 28 Jul 2025 10:46:50 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

With Inline ECC enabled, the bottom 1/8 of DDR is reserved
for ECC parity bits and must not be used for general data address
allocation. Previously, the SPL bss and malloc addresses were allocated
inside this ECC parity region if the DDR size is 1GB.

This caused ECC hardware to detect stale or invalid parity bits,
leading to data correction attempts and DMA polling hangs or failures.

Fix this by relocating the malloc and bss to the usable 7/8 region of DDR
and is fully ECC-safe.

This change ensures reliable ddr address operation and
prevents unintended memory corruption.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 configs/socfpga_agilex5_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 4ac0a5d9b99..01c5ac88015 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -12,7 +12,7 @@ CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk"
 CONFIG_DM_RESET=y
 CONFIG_SPL_STACK=0x7d000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0xbff00000
+CONFIG_SPL_BSS_START_ADDR=0x9ff00000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 CONFIG_SYS_LOAD_ADDR=0x82000000
 CONFIG_TARGET_SOCFPGA_AGILEX5_SOCDK=y
@@ -42,7 +42,7 @@ CONFIG_HANDOFF=y
 CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xbfa00000
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x9fa00000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 CONFIG_SPL_CACHE=y
 CONFIG_SPL_MTD=y
-- 
2.26.2


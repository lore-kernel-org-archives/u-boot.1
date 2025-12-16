Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BD6D5C0F3
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 08:46:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5848D8334F;
	Tue, 16 Dec 2025 09:46:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tQTwa9P+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C1108334F; Tue, 16 Dec 2025 09:46:33 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68BC4833C6
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 09:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3BhTDPhKA4d8OjRnQPP4XmPIsw1Gqx5s2Klv4aquUryFEDWC28YKk0eWZXWAgPdutC0NTSdN9816Mvd2oX0/qVIS2vEqqMg56l5DW8kK+wVykthr4V6WFBEAKxUX/P8DynKVJYyaB5BQhHZHwysEwhNPlndhOJuTtpywa0e/qwTypu8yjXMplF6UL2OXE3COwS4ff67f+159YDcjVZmTxSEvxi4rTXgHx6JNlNOPFdvvP0fEVy/ofuZbCIBfjL99Iw5TQF/0IghcIXZqpseUAhOKjy83POiKjvwDnfkJq28Itt/PE1ucUKBA+ruYynfTy51izR04Zyn1abv8iBaAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoQ75tuEWeo7gbBVYKQP0L7iqOcdc9HURLLwAc6CQ4w=;
 b=oIRVaNe/GhuDTsZZVqdv2Kfvybp543wVocgsDHcFTQTu2mQz/lANEvqymhVBHLGAqkMk1KU3iJrA83V6pkdibFw/fyjpoYfrvfsEm40x3srUv7vz3+xv5rxzx3EYv8yl8O/tXi9oCRl07ntrTZUnXqFuQrDXcdvmEfVdArHVFkU4eiyU4RY/jFeuBdBFB0BMU0tMJ/7YUsR/mYQlw6TJrU+ni0VBnoHqgporJxY7M/zozLoGIObDAfDAO2H4nGb5VuxBkVs+OC+4dkkJ4/+KdfxpJcb65SLgU6urvY+/1X/pm2VT/CyKDns5LjAr/uAILPkzNzq9Jkdz9Z+LhLFevg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoQ75tuEWeo7gbBVYKQP0L7iqOcdc9HURLLwAc6CQ4w=;
 b=tQTwa9P+WyjAkXabz+PO/Na+6/oei4HK6Ar0XDo46JfXWeOsInVfO6df8lCzxm9jWirUDgRO0nGP5jbPMKtno4Gpw5q1CMBSyy4PJvYOdT4jMgjozR/51ZsL+p7/w17/MbGMgYS8jpZ5PKTfuFHYjW36J68EXB9DZtg8Sd0m1tLDdlT3ziTBQITOHRqRkCX+M3RsD6Mh1DLfcdx5ICS3P7dm30Oj4kou47wetx8iturrGXXkFnQAESg2u1/AI9/L+wj4uls+CDHQQ7pBMsOynglCdsVUwYAxG+dUwL4I4kE/I/ICTacLzev44zb2V5SeqnBRnAoVIU8PtkmAFOdM1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DM6PR03MB5081.namprd03.prod.outlook.com (2603:10b6:5:1f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 08:46:28 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 08:46:28 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 1/5] arm: socfpga: Consolidate dram_bank_mmu_setup()
Date: Tue, 16 Dec 2025 00:46:19 -0800
Message-ID: <20251216084623.19589-2-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::13) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DM6PR03MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c8c044a-18a1-4144-eee7-08de3c7f9a56
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VUkUbkzD1JKSzM1jl+0Lcm/O5c8IiMno0rT61+FGg5+p2uCrK6FE2h6r5m6/?=
 =?us-ascii?Q?2Yq8I/KolSSPEkDy04sTJPdwyGhPqeRUkT/KhkNxiGzOMjeMe3C8yvJt0YTP?=
 =?us-ascii?Q?uS4gU5jkitS4AZtZEg109AHtHgMQaux7ybB4UeQWE0qTwCvvaS/8bQJ6PELA?=
 =?us-ascii?Q?nZKyoPXxPzsqFC1U/nBky6vQEceVdQNo4JHY7/29JT499GxP/D+AexEvB++O?=
 =?us-ascii?Q?Abzc0G3I9zk7R2ws2xj1UX4+uEik4xZKNY+eyCzXXEuZqVfguP8NvdWvxROq?=
 =?us-ascii?Q?ZFkIkt1YAwlhN63YEa0aCv2/DFgLyZZVpA8waOIVvPex+uAdMWcsRSLxXPsY?=
 =?us-ascii?Q?iwQ6ObJUkMfa9dezbnW6TzzUEu/WhbUdft5XRwKpfN/Qk46B3klkPSnZ4awM?=
 =?us-ascii?Q?z1fqq6Z4rU0kdozwBH6RqBfrZYsGeKhTq/nMft6dRoSgbDVemT7bLdcTwFCP?=
 =?us-ascii?Q?TOLjPISSNDPJ95YisJaUPpIh//dyYFlUmHtFvfhsmi9Cs1gNQ1RrG//3mrvM?=
 =?us-ascii?Q?RLApxygB88WV1TpjKAHHeYjlXM+o2QTTcTqVTUNYS2RiZ+RS1+vbTGrPyBT0?=
 =?us-ascii?Q?/+WQdsYiz8mlRnFRm4mJN1LFWOc4tzuBF4+SQvaWP1Rou6l2TQPHU7wVnw+R?=
 =?us-ascii?Q?vcIISbVBBAwthC7AiDxpYRUnWOx08RLkpBI4vXWRZwX8Igd9bpZwEFAtoJrn?=
 =?us-ascii?Q?zyw7PYVPy3UXF9S+HnY4ZfhXxkePlydLvP73uKQ53psRmWVFvm6MRCofyqhD?=
 =?us-ascii?Q?zYrtdghaLTlr1CQe3Xx0rjkMj6MNgrZTat9TmRHhSYXMXGZlkT2yBuoy06hv?=
 =?us-ascii?Q?Kwr9cx48a+Hp0LlqZ+bP4BpJeSZT7NcXRqzXKKny36GzvFIrXgDGaZPIf77I?=
 =?us-ascii?Q?HLldojgB4WKqGE/uF3wh+eZHBtjkd5tjSPQ07bHWzrAwtC3uKyBbfCZFNUww?=
 =?us-ascii?Q?uizmyoFLNIfhHb4o6kCdUJy47Tle4P/UiSywX9HAT6a/Jrzz8rFzvh4061TI?=
 =?us-ascii?Q?Lm9ltC6akY1E+lW1Eta5Zl0+d/tPex/wD2iOpZLiomJ9byjVK8ew4BDKpG4I?=
 =?us-ascii?Q?B3ziI7hhSD2HSSWdrJE4UkHkT3SqyDQbRu9YMQqNDFmFIN5Q9VpjuX5EO4H7?=
 =?us-ascii?Q?mCWrG/D0+cuQz1zwR4qkOkpyCNFZsyiPShFOJlcexYty5qgq86l4fWbugHU5?=
 =?us-ascii?Q?27thzXKP0MJuUhzGVKL0ALNhtxl+yWZMHB4c1iCSZDBXFIyOhbf6xtaCtHKr?=
 =?us-ascii?Q?ods5ro/5LZN5+7AhuegkvvGm9eTtySHxsOJM0LTkfoVMgsECavmidM0yh6Mt?=
 =?us-ascii?Q?Q4WSPMlcJvSQ1iPqLlE2lxl6EVmi9/5CJQT7Zp8QC8zET5bIm0oyUB/23pUG?=
 =?us-ascii?Q?WAe7Gk1e/uxSka6/Ryk3LFTbdjeAbbWQ+lsWxnKj42cHPqd10WZfm/aAmJRJ?=
 =?us-ascii?Q?f0z80k4czaD6iUP52IaGypz9s/++ZYf6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?REaDeQIN19SHenAu7N8nYtwwHraOsU20Jr8Y+LJFxAjqDlQWv8SJgLXZs2D9?=
 =?us-ascii?Q?j4aJMW4r/S30pahRB72PsPXZjiHLW55yp5ZMoiPvGSL2s4a4wgfVOMleuUpx?=
 =?us-ascii?Q?lapQUjvfoDDlTy1wHd/SkDPZ0sSBPPa95wcg2dvQJuR/oSdhoamK6vmf6vM2?=
 =?us-ascii?Q?Ra6fVmg/NeYKQ1ezsJGEhit+AtrgCtCZmMszDpHoOT0RzjclF6PRpdZ0Kj//?=
 =?us-ascii?Q?jiFx8CsvFQsFAMH1GEoXq5C0+g6seHltvglVGDYYcFJqkoDaUvpUYBWoBzIC?=
 =?us-ascii?Q?nDLDMUXF5gualAVY4h+3tN0URCkPc49UshToj3D21qVroXOBCqHHvfVsbM7R?=
 =?us-ascii?Q?/jq4i8wOfH9ipvnYLjOzZAgKVfgdVrPCX6TlJ6BeEO5x21DxOlk5TikcKxWa?=
 =?us-ascii?Q?KNSMHd+frraZ2nLmZzG2X0wclSZ7FhqSl4y5cUtmLk1gZDEw3rWheYEK5wVK?=
 =?us-ascii?Q?1mTuNEKyG49qPIjjDIG6qEwVV3UzbMv5XXL+z5Ig4UguoiJB/AeLyuE63+j1?=
 =?us-ascii?Q?wEf/H+sAb5rFCoJE96NhpJVNZwlih9Ruzr58JtPTKR2bF+jykSgprxWQ2f/G?=
 =?us-ascii?Q?iEhSuqXWKLku3iIzJ+pOEKWSDRnDy97/9a1KCKTId7eZY9GiIQ46EF6v94Je?=
 =?us-ascii?Q?VaL/v7HYhZuXseoOZBfcYEtYtd8FYnA/w6V1Rct7qghzZj9Fx/6OnpvCcfVY?=
 =?us-ascii?Q?HF9zYwZA/Qn0FelygGRA4ZlqSBsBFZRvzgvGqb2ISvPU79hJr1DvJaGgo8ra?=
 =?us-ascii?Q?ntlbcuaDWjvvJEUW0Z6E8iOzYqHwf2T4CCcsobEDetdnXIatoKnad7ku2p3O?=
 =?us-ascii?Q?Syd8hKHcm9mc+G4m40Mzp3FJx3BRzDRrx2t4eqCiKXSBhWY5ADF8dJaPTuWR?=
 =?us-ascii?Q?Zn16e10t26LOzuZUjK2UatByfY5Zt7dGLdvzBJ/bvNt4XwOHYsvmmMVm6eVo?=
 =?us-ascii?Q?yr/2i980gnQXirt2obMMIOn+Lz3oy5NEVaBgjTlP3dF8kiORbgWtuboLaw89?=
 =?us-ascii?Q?CnWigXCqDI1p3zMyO/xGtPyHLl63MEQ5ZL4mPtixuu4zGz1YdwhWxHFHwWR2?=
 =?us-ascii?Q?oUw0JQR00s3nItFnWx23a+oV9xJfz4cFtnfpDrQVuY51WtZoMih3+FTgb39Z?=
 =?us-ascii?Q?fdHr5ZHajxxNrC0HU2tjsPSu+vNByePKBrOSkHbGFzZhPG/JHs/HzEePUOQI?=
 =?us-ascii?Q?EAFIxIRjndEwBeqLn6P/DJY4uQ3Yilhp+MaEnP1T8YfbkPgaonUIFC7XVadB?=
 =?us-ascii?Q?KP/iILmu4cImFSJUEmzRHKVkzM9k4NTavCaMJM3geuakgmASVz6D/Sxs2DoH?=
 =?us-ascii?Q?aWEx2KltaGWJMOpUGVrR6gxpzWwIVYf85/YOPpL0TlQMWbo7wPp8Gua2dZNE?=
 =?us-ascii?Q?yKG7DXlmhyMB0014J+pFerJFh9BcoVqEoHmVh9w8Z96jcZtckictoLsYB2Hi?=
 =?us-ascii?Q?y4ulqRZiyH98W45Z0duEMo1dIlRsS1cVy6CHx06mik3dvge+woWWyDADcpMr?=
 =?us-ascii?Q?Y+VSnSuxSbXnMJEEIemkhAfmpXZAHXmmrzQX1Y8ISLzLbezCAfAljjcaZ0Zu?=
 =?us-ascii?Q?oPL75kpN/KDmHq6kCDdz+4ywC9ORmvboLNyuTEkc1I2a/6rMtxiDfotbrc0o?=
 =?us-ascii?Q?zBNQheCyQs2c0ZgIrQ/Q5DmAPKLA1SVan9eek9Pxj67toO+oMQyUKznpRG5m?=
 =?us-ascii?Q?SOsAMMcWIZZRAMlk9nnTJLKXT51JkyGxBA/WN7KzMaLuLqdi3qfzwMPJ2m7p?=
 =?us-ascii?Q?TrFW/k0bX8LSrKrjHgWfJgN/4LfJQIU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8c044a-18a1-4144-eee7-08de3c7f9a56
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 08:46:28.1757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uW4gcrmm0QwkdQgwPDqT/081JrwtOk42y7Fi/H3WV2B028ueaeofJelsouI3TuwJKYDd5+7Hixu8KHc+qzkLaZTw5azX3Au3DWV8DvM1Ldk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5081
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Relocate the dram_bank_mmu_setup() implementation from misc_arria10.c to
the common socfpga misc.c and update the function to correctly handle both
pre-relocation and post-relocation cases for DRAM cache enabling for
consistent MMU/dcache setup across Arria10 and CycloneV platforms.

These changes help to improve maintainability and consistency of DRAM
initialization as well as MMU configuration for Arria10 and CycloneV
platforms.

Fixes: e26ecebc684b ("socfpga: arria10: Allow dcache_enable before relocation")

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/Kconfig        |  1 +
 arch/arm/mach-socfpga/misc.c         | 31 ++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/misc_arria10.c | 26 -----------------------
 3 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index f2e959b5662..5b00a101a67 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -118,6 +118,7 @@ config TARGET_SOCFPGA_CYCLONE5
 config TARGET_SOCFPGA_GEN5
 	bool
 	select SPL_ALTERA_SDRAM
+	select SPL_CACHE if SPL
 	imply FPGA_SOCFPGA
 	imply SPL_SIZE_LIMIT_SUBTRACT_GD
 	imply SPL_SIZE_LIMIT_SUBTRACT_MALLOC
diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index 07694107c8a..2eee6ab3efe 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -318,3 +318,34 @@ phys_addr_t socfpga_get_clkmgr_addr(void)
 {
 	return socfpga_clkmgr_base;
 }
+
+#if IS_ENABLED(CONFIG_SYS_ARM_CACHE_CP15)
+void dram_bank_mmu_setup(int bank)
+{
+	struct bd_info *bd = gd->bd;
+	u32 start, size;
+	int i;
+
+	/* If we're still in OCRAM, don't set the XN bit on it */
+	if (!(gd->flags & GD_FLG_RELOC)) {
+		set_section_dcache(CFG_SYS_INIT_RAM_ADDR >> MMU_SECTION_SHIFT,
+				   DCACHE_WRITETHROUGH);
+
+		/*
+		 * The default implementation of this function allows the DRAM dcache
+		 * to be enabled only after relocation. However, to speed up ECC
+		 * initialization, we want to be able to enable DRAM dcache before
+		 * relocation.
+		 */
+		start = bd->bi_dram[bank].start >> MMU_SECTION_SHIFT;
+		size = bd->bi_dram[bank].size >> MMU_SECTION_SHIFT;
+		for (i = start; i < start + size; i++)
+			set_section_dcache(i, DCACHE_WRITETHROUGH);
+	} else {
+		start = bd->bi_dram[bank].start >> MMU_SECTION_SHIFT;
+		size = bd->bi_dram[bank].size >> MMU_SECTION_SHIFT;
+		for (i = start; i < start + size; i++)
+			set_section_dcache(i, DCACHE_DEFAULT_OPTION);
+	}
+}
+#endif
diff --git a/arch/arm/mach-socfpga/misc_arria10.c b/arch/arm/mach-socfpga/misc_arria10.c
index 7e0f3875b7c..635fc3568fb 100644
--- a/arch/arm/mach-socfpga/misc_arria10.c
+++ b/arch/arm/mach-socfpga/misc_arria10.c
@@ -243,29 +243,3 @@ int qspi_flash_software_reset(void)
 	return 0;
 }
 #endif
-
-void dram_bank_mmu_setup(int bank)
-{
-	struct bd_info *bd = gd->bd;
-	u32 start, size;
-	int i;
-
-	/* If we're still in OCRAM, don't set the XN bit on it */
-	if (!(gd->flags & GD_FLG_RELOC)) {
-		set_section_dcache(
-			CFG_SYS_INIT_RAM_ADDR >> MMU_SECTION_SHIFT,
-			DCACHE_WRITETHROUGH);
-	}
-
-	/*
-	 * The default implementation of this function allows the DRAM dcache
-	 * to be enabled only after relocation. However, to speed up ECC
-	 * initialization, we want to be able to enable DRAM dcache before
-	 * relocation, so we don't check GD_FLG_RELOC (this assumes bd->bi_dram
-	 * is set first).
-	 */
-	start = bd->bi_dram[bank].start >> MMU_SECTION_SHIFT;
-	size = bd->bi_dram[bank].size >> MMU_SECTION_SHIFT;
-	for (i = start; i < start + size; i++)
-		set_section_dcache(i, DCACHE_DEFAULT_OPTION);
-}
-- 
2.43.7


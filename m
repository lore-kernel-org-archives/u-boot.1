Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED4A606A334
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 05:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U6w+7bgc;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uc8YdnFA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B34394057A;
	Thu,  5 Nov 2026 05:17:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Su0UG0XItKJl; Thu,  5 Nov 2026 05:17:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E53E040598
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793855863;
	b=l16KIPPzK5Sem2Po4HL4Y1BY+g8q7Ip0lWIidTDZiIj/Z+9E9kjg5BQjXL8eXvWQ0ZM0
	 qeLvsoVgjReLQGASVExCNkqw38viu/em16fWcEzxnlea/0BAeA9H16PEfikNdXlRkILWu
	 L5BrES4Lrymp9UjAmwIXQSSLa2yxpb4f1egllWKJyATvZ+mwzsxKodzw5uVFmWF/2/Lvq
	 EHs4oySZtKV2Zx2G16HPwXZmvSW8NZAoCr6+p1LY1b+Q45hqqHWmEovb56O0wPZ1p0NCT
	 u99zgZk0f58w9NbeqQ+PrDru/rgV2c0HpU/Z1P1lIXAJ6RmUzrp++CQ7yQomx/ptUFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793855863;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dWHYCW7POGeG/io+CuScOfxFxStWqbFxsoKoiMXZz/w=;
	b=AsVtO+2EDaYbU0Ja5JY0RpnOtLajjHfzZqO7TctfmQch/WBMhnEIEdhRXpP3htgTzk1+
	 y8Z/xy3d0yOqE2hUUSCdyRJxSImX04pwPpZ+nDz1JbKiCkF2yHjZCfz1XtS1CrCuNQx2g
	 BBsQQwHtsZaeNjb0PYBax2+fKaCgCkQvPJNNX5+bf7OhvDVQh0GGJ88LjmP56WV4IotFW
	 JadDNZ/Wmr3aZTqLBF4X26hKtE/LjPLpjQy25Pxcusz2UjWCtUtjnlcPUDxRUHTl05Nb7
	 GP6XAx5M/gz9Yvz1rltI4SdN5yaPfudD5sYyg2kwchpuKOJ5b0C7ypC460q1Ey9DHLg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793855863;
	bh=dWHYCW7POGeG/io+CuScOfxFxStWqbFxsoKoiMXZz/w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U6w+7bgcOWeHUehDIvedIcoVdna1cdo+1lTx4E+3SQyR4BWA6fXQmEkGPSH5qQjRH
	 wqirsAkyDTDICp9Wpr+8M2YpmbXK1CBHXRAXcPElQkdpkGxti7pPCqRwkiJhkG5ul3
	 uf+f4H/aI2R0cxBZMl1SANzsPcr8MXl1yhrQFN5s5Z7pr192GwYjMpPyOSQzTi8Kwt
	 O25e6oFM1VCp03SRPBB+eTWvs6axcUkRZyzmddBMCrpGWPOWcqVu18FqndYDvIWt5S
	 NADo5Bu3Q5DqBH4AS9hXY19clUQfg057vlPc6DQ8LUu626a4IBmFvwyhGa+PPHuIVL
	 jQfaFUgUe9KFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E53E040598;
	Thu,  5 Nov 2026 05:17:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 121FC34D
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 05:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC926400FF
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 05:17:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HvT0C7xDY7fC for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 05:17:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 585F140076
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c110::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::3;
 helo=bn8pr05cu002.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=uc8YdnFA
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 585F140076
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 05:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWHYCW7POGeG/io+CuScOfxFxStWqbFxsoKoiMXZz/w=;
 b=uc8YdnFAxGUaksKg9Zrp3DuWMbiI8AOXmiLst+HM+yQpK7krI+L7OOeymgbbb6phPOs2MquY78AKim4B1RC/aM0lp0NOhKRVHV0dX3ArLrsY69mpqtyKXeFFeNuX4tGwC9qqbHyDfI3uojl5fHquHXXO6THjoBfcs9KchrvmDao=
Received: from BY5PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:1e0::24)
 by LV8PR12MB9691.namprd12.prod.outlook.com (2603:10b6:408:295::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 05:17:31 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::98) by BY5PR03CA0014.outlook.office365.com
 (2603:10b6:a03:1e0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 05:17:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 05:17:31 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 23:17:28 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 4 Nov 2026 23:17:26 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/2] lib: vsprintf: add %uZ to print sizes
Date: Thu, 5 Nov 2026 10:46:53 +0530
Message-ID: <20261105051715.215560-2-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105051715.215560-1-padmarao.begari@amd.com>
References: <20261105051715.215560-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|LV8PR12MB9691:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f174418-38b2-4808-9408-08df3afc17dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261021121427099003|261021135927099003|261022105027099003|261009223027099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: G2GaTQ8SNNDb71S8DGHK3fUsPTd1g4RdhqeT7C7mKEPN6LckmRKOprzXv5ex+OK1iGDBBR+v5oOnHeAOqJ4ZDMNMkS42EdnMdc+dZ9Zc/DRe1/hgEneAjk6tqb41Ib8yw3TydreJw6pdi2L1xvKWKoMjtjT7jsEr5hutfhWsHR9obbSStMAk++1J3QEZM2WUNY/ZAZg925M3WC7iLhWiAEYN4YGThvKMXfYTKp31cZUDFqQgb8fxQ4qxGGhht4ZLKKYpP8aPtWtrm/T1hVBVGxScPgJYXU8VnvK0Z6K6U9Z7vXBUeiExUUjNgcak8DtUWZwWRe3q0chBsaLFu3ScfAJDdpTgfWDMW+AvwGUxUfkug53YmRWW6UIIMZBtbKDMq0DTmZUwNSCau0E8h3cjQn6zuBcQbo+NCyEgZrSAi7WxhcoBfOlzWTPK5gBb6SIMmfrixYp2+1OxWRo/y25hPy5Vl5tppkfqyyi7cxL5o4ckJvCMY7AaAZb/UuyUKbUeN9fwSiBL7PUVn0E4TcsOkYctDytpsSXx+CbyOu6hUCKr+tgcGURz9vuv+r7x324YmUjFOAOvWSF6WnHe5b1pKINmhkmnHvd9qAmGVDbHVjlvORRCkRlkMOkwmiOIptw1lull/sBRKckJl+eCmVOqmTlLq3JTDfFoifxcD8vsGHldzNCL55F28TGz1P9/mkCjbiz/914QKJFKr0PAVStRSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021121427099003)(261021135927099003)(261022105027099003)(261009223027099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E2wu7XtuStmNiRljLiYhxkjOvSR+IdqP2jibKGnrukSxYrvFSUfBFANyFiecFzVYoNk083cb9yVn7WqXL29j+lPTDVgFmWgz4E2Gp1I0VKBMz2Zq/PjqRpIa0/Tn3zk40cVktfm3o0BI4cb4nLeG7acLuYIsPtY8NZOzRQ/6e9dsM66vacud0HJxa6PFLxkvmLQPpWpu6V1X/PIPAeWrjkv+ogNy3fAOjZeYtQ9336gzsAGqKUyXemU57/uk7N2AWk39C+4jIXrOynELv4zKbYaE1dFmvjxtnAr5nEVnlRSi8FKnqcGSr/rEmG8iq65vpuXOb0ARH8vj7oEBxKcWIFoZF+FguPDBn9jP4+WN9SQxku2tu33mfPSE8YsL6EbtvQruE9uSi6aSNWqG4wQyH91BFxAUfbQtjvOH/YUUQuW2zGCO3i2D+H7kB5CSkCmI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 05:17:31.5122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f174418-38b2-4808-9408-08df3afc17dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9691
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A size with a binary unit can only be printed to the console with
print_size(). Code which builds a string, such as a boot menu entry,
has to format the size itself.

Add a Z suffix to the %u conversion which prints the value as a size in
bytes with a binary unit, as print_size() does, so that sizes can be
printed with printf() and its variants:

	printf("%lluZ\n", 0x113000ULL);		/* 1 MiB */
	printf("%.3lluZ\n", 0x113000ULL);	/* 1.074 MiB */

The precision is the number of decimal places, with the last one rounded
and trailing zeros left out, so that "%.1lluZ" prints the same as
print_size(). The Z only has this meaning after %u, since an existing
format string has "%dZ" followed by other text. Compilers which check
format strings see the Z as an ordinary character, so this does not
cause warnings.

Document the format and add tests, including one which checks that
"%.1lluZ" prints the same as print_size() for a range of sizes.

Suggested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
Changes in v3:
- New patch, replacing "lib: display_options: add snprint_size()":
  print sizes with a Z suffix to the %u conversion, as suggested by
  Heinrich Schuchardt

checkpatch reports 'Please use a blank line after
function/struct/union/enum declarations' for each COMMON_TEST() line.
COMMON_TEST() is placed directly after its test function, as in the
other tests.

 doc/develop/printf.rst | 30 +++++++++++++
 lib/vsprintf.c         | 98 ++++++++++++++++++++++++++++++++++++++++++
 test/common/print.c    | 97 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 225 insertions(+)

diff --git a/doc/develop/printf.rst b/doc/develop/printf.rst
index 99d05061b14..33f2e027fa0 100644
--- a/doc/develop/printf.rst
+++ b/doc/develop/printf.rst
@@ -127,6 +127,36 @@ size_t              %zu, %zx, %zX
 ssize_t             %zd, %zx, %zX
 =================== ==================
 
+Sizes
+-----
+
+%uZ, %luZ, %lluZ, %zuZ
+	prints an unsigned integer as a size in bytes with a binary unit:
+	"xxx Bytes" below 1 KiB, otherwise "xxx KiB", "xxx MiB" and so on up
+	to "xxx EiB", using the largest unit which gives at least 1.
+
+	The precision is the number of decimal places, at most 9. The last
+	one is rounded and trailing zeros are left out. Without a precision,
+	the size is rounded to a whole number of the unit. A field width pads
+	the whole string with spaces.
+
+	"%.1lluZ" prints a size the same way as print_size().
+
+	The Z only has this meaning after %u. After other conversions, such
+	as %d or %x, it is printed as a normal character. The SPL and TPL
+	tiny printf() does not support it.
+
+=================== ======================= ==============
+Format              Value                   Output
+=================== ======================= ==============
+%lluZ               0x113000                1 MiB
+%.1lluZ             0x113000                1.1 MiB
+%.3lluZ             0x113000                1.074 MiB
+%.3lluZ             0x100000                1 MiB
+%zuZ                512                     512 Bytes
+%10lluZ             1024                    "     1 KiB"
+=================== ======================= ==============
+
 Characters
 ----------
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 49dc9c38c65..a14f8c600b7 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -151,6 +151,7 @@ static noinline char *put_dec(char *buf, uint64_t num)
 #define SMALL	32		/* Must be 32 == 0x20 */
 #define SPECIAL	64		/* 0x */
 #define ERRSTR	128		/* %dE showing error string if enabled */
+#define SIZEUNIT	256		/* %uZ showing a size with a unit */
 
 /*
  * Macro to add a new character to our output string, but only if it will
@@ -281,6 +282,94 @@ static char *string(char *buf, char *end, const char *s, int field_width,
 	return buf;
 }
 
+/* Most decimal places which %uZ shows */
+#define SIZE_MAX_DECIMALS	9
+
+/**
+ * size_string() - Print a size with a binary unit, for %uZ
+ *
+ * Print a size in bytes as "xxx Bytes" below 1 KiB, and otherwise as
+ * "xxx KiB", "xxx MiB", ... "xxx EiB", with the largest unit that gives at
+ * least 1. The precision is the number of decimal places, at most
+ * SIZE_MAX_DECIMALS, with the last one rounded and trailing zeros left out,
+ * so that "%.1lluZ" prints the same as print_size(). There are no decimal
+ * places without a precision.
+ *
+ * @buf:	Buffer to write to
+ * @end:	End of the buffer
+ * @size:	Size in bytes
+ * @field_width:	Minimum width of the output, padded with spaces
+ * @precision:	Number of decimal places, -1 for none
+ * @flags:	Formatting flags; only LEFT is used
+ * Return:	Pointer to the end of the output in @buf
+ */
+static char *size_string(char *buf, char *end, u64 size, int field_width,
+			 int precision, int flags)
+{
+	static const char units[] = "KMGTPE";
+	char tmp[32], *p, *tmp_end = tmp + sizeof(tmp);
+	int unit, shift, decimals, i;
+	u64 whole, rem, mask;
+	u32 frac, scale;
+
+	/* Find the largest unit which gives at least 1 */
+	for (unit = -1; unit + 1 < (int)ARRAY_SIZE(units) - 1; unit++) {
+		if (!(size >> (10 * (unit + 2))))
+			break;
+	}
+
+	if (unit < 0) {
+		p = number(tmp, tmp_end, size, 10, -1, -1, 0);
+		strcpy(p, " Bytes");
+
+		return string(buf, end, tmp, field_width, -1, flags);
+	}
+
+	shift = 10 * (unit + 1);
+	mask = (1ULL << shift) - 1;
+	whole = size >> shift;
+	rem = size & mask;
+	decimals = precision < 0 ? 0 : min(precision, SIZE_MAX_DECIMALS);
+
+	/* Work out each decimal place in turn, then round the last one */
+	frac = 0;
+	scale = 1;
+	for (i = 0; i < decimals; i++) {
+		rem *= 10;
+		frac = frac * 10 + (rem >> shift);
+		rem &= mask;
+		scale *= 10;
+	}
+	if (rem >> (shift - 1))
+		frac++;
+
+	/* Rounding can carry into the whole part, and on into the next unit */
+	if (frac >= scale) {
+		frac -= scale;
+		whole++;
+		if (whole == 1024 && units[unit + 1]) {
+			whole = 1;
+			unit++;
+		}
+	}
+
+	while (decimals > 0 && !(frac % 10)) {
+		frac /= 10;
+		decimals--;
+	}
+
+	p = number(tmp, tmp_end, whole, 10, -1, -1, 0);
+	if (decimals) {
+		*p++ = '.';
+		p = number(p, tmp_end, frac, 10, -1, decimals, 0);
+	}
+	*p++ = ' ';
+	*p++ = units[unit];
+	strcpy(p, "iB");
+
+	return string(buf, end, tmp, field_width, -1, flags);
+}
+
 /* U-Boot uses UTF-16 strings in the EFI context only. */
 static __maybe_unused char *string16(char *buf, char *end, u16 *s,
 				     int field_width, int precision, int flags)
@@ -726,6 +815,10 @@ repeat:
 			flags |= SIGN;
 		/* fallthrough */
 		case 'u':
+			if (*fmt == 'u' && fmt[1] == 'Z') {
+				flags |= SIZEUNIT;
+				fmt++;
+			}
 			break;
 
 		default:
@@ -755,6 +848,11 @@ repeat:
 			if (flags & SIGN)
 				num = (signed int) num;
 		}
+		if (flags & SIZEUNIT) {
+			str = size_string(str, end, num, field_width, precision,
+					  flags);
+			continue;
+		}
 		str = number(str, end, num, base, field_width, precision,
 			     flags);
 		if (IS_ENABLED(CONFIG_ERRNO_STR) && (flags & ERRSTR)) {
diff --git a/test/common/print.c b/test/common/print.c
index 27fdb444d0d..1d2ee8f3839 100644
--- a/test/common/print.c
+++ b/test/common/print.c
@@ -164,6 +164,103 @@ static int print_printf(struct unit_test_state *uts)
 }
 COMMON_TEST(print_printf, 0);
 
+/* Test printing sizes with %uZ */
+static int print_size_unit(struct unit_test_state *uts)
+{
+	char str[40];
+
+	/* The integer types */
+	snprintf(str, sizeof(str), "%uZ", 0x100000);
+	ut_asserteq_str("1 MiB", str);
+	snprintf(str, sizeof(str), "%luZ", 0x100000UL);
+	ut_asserteq_str("1 MiB", str);
+	snprintf(str, sizeof(str), "%lluZ", 0x100000ULL);
+	ut_asserteq_str("1 MiB", str);
+	snprintf(str, sizeof(str), "%zuZ", (size_t)0x100000);
+	ut_asserteq_str("1 MiB", str);
+
+	/* Below 1 KiB, and each unit */
+	snprintf(str, sizeof(str), "%lluZ", 0ULL);
+	ut_asserteq_str("0 Bytes", str);
+	snprintf(str, sizeof(str), "%lluZ", 1023ULL);
+	ut_asserteq_str("1023 Bytes", str);
+	snprintf(str, sizeof(str), "%lluZ", 1ULL << 10);
+	ut_asserteq_str("1 KiB", str);
+	snprintf(str, sizeof(str), "%lluZ", 1ULL << 30);
+	ut_asserteq_str("1 GiB", str);
+	snprintf(str, sizeof(str), "%lluZ", 1ULL << 40);
+	ut_asserteq_str("1 TiB", str);
+	snprintf(str, sizeof(str), "%lluZ", 1ULL << 50);
+	ut_asserteq_str("1 PiB", str);
+	snprintf(str, sizeof(str), "%lluZ", 1ULL << 60);
+	ut_asserteq_str("1 EiB", str);
+	snprintf(str, sizeof(str), "%.1lluZ", ~0ULL);
+	ut_asserteq_str("16 EiB", str);
+
+	/* The precision is the number of decimal places */
+	snprintf(str, sizeof(str), "%lluZ", 0x113000ULL);
+	ut_asserteq_str("1 MiB", str);
+	snprintf(str, sizeof(str), "%.1lluZ", 0x113000ULL);
+	ut_asserteq_str("1.1 MiB", str);
+	snprintf(str, sizeof(str), "%.3lluZ", 0x113000ULL);
+	ut_asserteq_str("1.074 MiB", str);
+	snprintf(str, sizeof(str), "%.*lluZ", 3, 0x113000ULL);
+	ut_asserteq_str("1.074 MiB", str);
+
+	/* Leading zeros of the decimals are kept, trailing ones left out */
+	snprintf(str, sizeof(str), "%.3lluZ", 0x101000ULL);
+	ut_asserteq_str("1.004 MiB", str);
+	snprintf(str, sizeof(str), "%.3lluZ", 0x100000ULL);
+	ut_asserteq_str("1 MiB", str);
+	snprintf(str, sizeof(str), "%.3lluZ", 0x180000ULL);
+	ut_asserteq_str("1.5 MiB", str);
+
+	/* Rounding, also into the next unit */
+	snprintf(str, sizeof(str), "%lluZ", 0x180000ULL);
+	ut_asserteq_str("2 MiB", str);
+	snprintf(str, sizeof(str), "%.1lluZ", (1ULL << 30) - 1);
+	ut_asserteq_str("1 GiB", str);
+
+	/* Field width */
+	snprintf(str, sizeof(str), "[%10lluZ]", 1ULL << 10);
+	ut_asserteq_str("[     1 KiB]", str);
+	snprintf(str, sizeof(str), "[%-10lluZ]", 1ULL << 10);
+	ut_asserteq_str("[1 KiB     ]", str);
+
+	/* Only %u takes the Z */
+	snprintf(str, sizeof(str), "%dZ %xZ", 0x100000, 0x100000);
+	ut_asserteq_str("1048576Z 100000Z", str);
+
+	/* A size which does not fit is truncated like any other output */
+	ut_asserteq(9, snprintf(str, 5, "%.3lluZ", 0x113000ULL));
+	ut_asserteq_str("1.07", str);
+
+	return 0;
+}
+COMMON_TEST(print_size_unit, 0);
+
+/* Test that %.1lluZ prints the same as print_size() */
+static int print_size_unit_compat(struct unit_test_state *uts)
+{
+	static const u64 sizes[] = {
+		0, 1, 999, 1023, 1024, 1025, 1536, 1588, 1638, 0x3ffff,
+		0xfffff, 0x100000, 0x113000, 0x1f00000, 0x7e00000,
+		0x3fffffff, 0x40000000, 0x76c0000000ULL, 0xe8d4a51000ULL,
+		0xfffffffffffULL, 1ULL << 40, (1ULL << 50) + (1ULL << 49),
+		(1ULL << 60) - 1, 3ULL << 60, ~0ULL,
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
+		print_size(sizes[i], "\n");
+		ut_assert_nextline("%.1lluZ", sizes[i]);
+	}
+	ut_assert_console_end();
+
+	return 0;
+}
+COMMON_TEST(print_size_unit_compat, UTF_CONSOLE);
+
 static int print_display_buffer(struct unit_test_state *uts)
 {
 	u8 *buf;
-- 
2.34.1


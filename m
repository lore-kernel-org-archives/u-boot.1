Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D180C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 10:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05372876C9;
	Wed,  3 Jan 2024 11:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Eqwlpdrh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B82A58715C; Wed,  3 Jan 2024 11:47:26 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D43E6874AC
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 11:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6foPo0Ddjqz/I+SXf6P2BkNwQtXKSdWob2nYVP5J8YPr4+bxt9O6lbuDfHZmz8iw6v4InMODl8piZhe57P9mvs2aGLo62F9SzB77qN+nwCIkhVCgxmNLUO0934kAZj384d0I9aCGrYhmI7f/LO48qD0Lbn/q4FQvjhIwg2ejZHIvalkLioSb1ge6Pk2cZptkQRtRuE2suFuzSc9boufrbFoJc/Nr262urWbK4K/i9+Pq2So/2Be2MUB+tPh6ugd4XkUy4J8Em1vUmw0mXhqJS3DF/Wj+FAk1phy9pvD8czqWY5qz1YHQJR3I+nV4jdcEqxh0UbUFBUyzm+AhcTtfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYI8pkRk24EADLjZQ1+jTy0WS095E9WQXIw3taT/Az8=;
 b=cS4tacnk5Iv/Z+4Oa/Sd0hDPXbAMdYYc9fTXj7BCVKWEnnup9Jg8aqYODn6U0NRaDeK+Sc92B5BX2NF14Y9P9axN6uYQZGETN6wmFTds2drZiVX0dvTIZeUyT/WlMmAAZbKfg4o/jOExeKWFC7apzbUXlDzQrttYximzTydM2c7D58urrhNMyQVRpBijRDycdSVzHe596wQDzOQ8X3qsQFtM1rSNyC4d1qmt4X/Oqg+92bdhuLYuE/tt9EIGbAIpb9isabR+hzAXPq5Z1yz0YjUtDeK8kRHqY/1OZHiOthEF9r0mK4HRJCPtEF8hrJYYK3p9MGdIrBJ3oKefKL4/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYI8pkRk24EADLjZQ1+jTy0WS095E9WQXIw3taT/Az8=;
 b=EqwlpdrhSKrx3yjfthmvQI4am/ZSZDD9wQQEjZCfg+ub7nXm9+mTDiegJZ+nxPknh370CYVSdk2PyT6nU3pY+F/605iZl7NmEmpXjX6S0uV1MQX9LQL4qhcljRUj8a8s7Cy1WvUWlThoUGocpiQuctasZUn+EuC4lmB/+cZR7cc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB7575.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:546::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 10:47:22 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 10:47:22 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 5/8] test: add test of "cp" shell command
Date: Wed,  3 Jan 2024 11:47:07 +0100
Message-Id: <20240103104710.4185383-6-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240103104710.4185383-1-rasmus.villemoes@prevas.dk>
References: <20240103104710.4185383-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0069.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::6)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eaf2150-9322-4bfb-2739-08dc0c495de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLgs8rBzFS8/uTy1DJnXRspN5Rj5XdmI2AM0el1o0nHazFx+atdsfAxCDMbP2chON227hYcUQ5rtphfUKlqlYZweeGV6DclxGDzP5VgQrNZhi2cJAa20KRnD/slojOYvHRzBkCNc9dYLZ2g9LDvQBJUzjVozii9R8j1thNn/h2voJclFmCNwQpsWnjBMUCKPdFNM/06DEp9A4Nuo42Jb7dfxt2cyve5xbxdsFEFVpy7dEN0Dj4sF6TY45cwjLu9FvaVMtjDP8gYtbwaYhd0gQt9OiaDnzRtucJ4pjLk5aEESnrWbGF8ySYX1bhlQs/1pRbHG+0383B4OOtaYF1/9T5stjfNmJimW6ThWjhfEJNtftRfbEVKMglFvXjTIuxj6FyIE6A6eQ7A/0wEEin0bpPtF4zPH4COX4L/9zl4dBUeQpvH1MTK5MHyMVXBpoPucD9FDh7RETY6/QFNIJSiKU0RQDT7SMQ/wmCct5gPL472B+q8DOsKoer7YvnFKemkjNlC1W64E/acyuEQQC2xvPorUVqfzTIV5By8OWK0Alb8/dCnYZHAwF/zu/+g5ebagDIxgwbuBbu67Td6H1NAavlYXYEkQYY6AFYrsb6AjP7t4fVLOE7TsJwtT6ZkSABQT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(366004)(376002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(1076003)(26005)(2616005)(107886003)(66556008)(38100700002)(66946007)(36756003)(54906003)(6916009)(316002)(66476007)(6486002)(478600001)(86362001)(5660300002)(2906002)(44832011)(8676002)(8976002)(8936002)(4326008)(38350700005)(41300700001)(6666004)(6506007)(6512007)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jp3k/KPrYc4pwkCgzXOWIWKBcJxvifHdr6f8KufXd8bpw76zXIUc72eK+c27?=
 =?us-ascii?Q?nh8ohkvVYR1u1k1OAVklKK5mQ1sOkm9GctJUIo6J0fv8Owv7vINIMIXxRpHl?=
 =?us-ascii?Q?nBF7N/ikNC8eAGvJh19+dqlcZhad63EGrcKtqpigHEie/LK8XhlxcNwB0CH2?=
 =?us-ascii?Q?hDMBLiEU62NRgHsX7qxdBdndS9s939DAgkPp3JFUISqcBnfubI9DtV/9mFHc?=
 =?us-ascii?Q?E811YGVprJQ6DdDD82VS7qzyhp5rRAAabmwDRnuecwg4v7z3dykdW75eQXop?=
 =?us-ascii?Q?wAINlyJuI3tSix6xXPYqIKDGrg3tr5bHNinH3wj8xvKtmZgpLJR71knaq8yo?=
 =?us-ascii?Q?KI8wy450RFP1HHK8aESRlPQs2pILU2xicrHmQ2jD6k2WGEG1TULizUWU+1cS?=
 =?us-ascii?Q?JH29H70UDHhS9SSJEd2iYGcT8RIlsJ9ib2Pktv5xFjSmNbTgq4qAHlSbiDWr?=
 =?us-ascii?Q?+zE8JFZuOm0F71xANHpzDwqlqlV6zwwA5SAv/RHzcymgyhOtXIPTGLdsuT98?=
 =?us-ascii?Q?dnVU/2S0RSOnpusNfFjnak8kOD2a2vOOw67Pi40IxBPkPPYJ3blE4eLek2fp?=
 =?us-ascii?Q?OBz5C0xQWGok4kJkPdY4p/P+UmXs5MpACHFcxJSTVnFU8a3n7TQitukwrFlW?=
 =?us-ascii?Q?zx/OsHy1nyzNRygndBx7x5XRll1gcxT4UEiZDL/F00s3+oeoVvGcUWZd/Fzr?=
 =?us-ascii?Q?00wxACHcyMv2fqo0svueD9FOIgQvKrhQrm4g5CtWib7qSmFeazf3aJ7PkhhM?=
 =?us-ascii?Q?D9R8KNBC4rBoGvdTQ4eKXsCdkBMIT+f3wpFUTIrvKHGa3kiO7PNkApAjDuX9?=
 =?us-ascii?Q?3uS5ROR38czb0nl0/47YyrhQgZp0S+gJ8MJJDVQ2zA3XLWzRQKU1QpG1psls?=
 =?us-ascii?Q?hDhrefLiuYtXZ8V5EyKNTEs+dCQ++IOKZ4DhI20OQQ6/twEDxHaACbqbSkDa?=
 =?us-ascii?Q?1qlaL1TiufApyAYlHH18eaVohP2uNR4WagHSpGZLgFtn6vnhBj9oQfNmliep?=
 =?us-ascii?Q?IwzTjyXwFsSJ5WdyN4LG3zm50J/RhIdEL53M9vDHuqHd2rS5WKhb6VdnL8DT?=
 =?us-ascii?Q?2aO42/NQ2WDRPxTvARDagcWB38sdQPFL86OoX7oV++BFn/jH4+GTZKsQUcJZ?=
 =?us-ascii?Q?zpqLKMw5+j452BNCgByCrwDrqELri9p44QLSB9CgJX0f+e+Hadzd5DP1Gi94?=
 =?us-ascii?Q?5+LoEfqNDU/dBRsqlBOGk+eMr2hjJLXyf/UxHXE3Jn5JkxFyHnaWR+G+gFwQ?=
 =?us-ascii?Q?oCHHIparZcB949a/dGsHXrZI3TPN9jKBCt12hrP3Q3dcz8MXGU87FV2Ri1nI?=
 =?us-ascii?Q?U8Cmq5N5IMrYOIGTeFE0JsBnuM+jxICwiiYGgAabnbY5EM3GnCfbUka8+zw/?=
 =?us-ascii?Q?Bzo703/+G8AkezcfKb8QeBgtwR0GJ3JxibsfToStA1Ng44u444t9j2a7ACcI?=
 =?us-ascii?Q?JxE0wUfASOSQhRjF7sXFYbRXv9P7ut8bL3cfdm/BnAhrRe8v1q+UBCXNrSyw?=
 =?us-ascii?Q?6+gK5Q4IAYBKBvpoExOcWiA+/ZjirE+InMzmt9jpomkQ8wWiFj4bZCc2o/0L?=
 =?us-ascii?Q?Df5QFz7nsOYkPrrQ96EvDya6uRwGg7RVKqZ5gYgG107S+BkpD3NwFzpyypGh?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eaf2150-9322-4bfb-2739-08dc0c495de5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 10:47:22.8173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0Y3v49jLSNrj9JaBbQSaMCFgYIsrpTsesE21oUMcar7DZ8dwcnR4kGRr4Lu1kRgjr000gRovVLW6DoNw3jJWgg1pSezgBHLh1xfqSun9GI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7575
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

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 test/cmd/Makefile   |   1 +
 test/cmd/mem_copy.c | 169 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+)
 create mode 100644 test/cmd/mem_copy.c

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index e296ba1192b..b26b5b1ea85 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_CONSOLE_TRUETYPE) += font.o
 obj-$(CONFIG_CMD_HISTORY) += history.o
 obj-$(CONFIG_CMD_LOADM) += loadm.o
 obj-$(CONFIG_CMD_MEM_SEARCH) += mem_search.o
+obj-$(CONFIG_CMD_MEMORY) += mem_copy.o
 ifdef CONFIG_CMD_PCI
 obj-$(CONFIG_CMD_PCI_MPS) += pci_mps.o
 endif
diff --git a/test/cmd/mem_copy.c b/test/cmd/mem_copy.c
new file mode 100644
index 00000000000..072159b2906
--- /dev/null
+++ b/test/cmd/mem_copy.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for memory 'cp' command
+ */
+
+#include <command.h>
+#include <common.h>
+#include <console.h>
+#include <mapmem.h>
+#include <dm/test.h>
+#include <test/ut.h>
+
+#define BUF_SIZE	256
+
+/* Declare a new mem test */
+#define MEM_TEST(_name)	UNIT_TEST(_name, 0, mem_test)
+
+struct param {
+	int d, s, count;
+};
+
+static int do_test(struct unit_test_state *uts,
+		   const char *suffix, int d, int s, int count)
+{
+	const long addr = 0x1000;
+	u8 shadow[BUF_SIZE];
+	u8 *buf;
+	int i, w, bytes;
+
+	buf = map_sysmem(addr, BUF_SIZE);
+
+	/* Fill with distinct bytes. */
+	for (i = 0; i < BUF_SIZE; ++i)
+		buf[i] = shadow[i] = i;
+
+	/* Parameter sanity checking. */
+	w = cmd_get_data_size(suffix, 4);
+	ut_assert(w == 1 || w == 2 || w == 4 || (MEM_SUPPORT_64BIT_DATA && w == 8));
+
+	bytes = count * w;
+	ut_assert(d < BUF_SIZE);
+	ut_assert(d + bytes <= BUF_SIZE);
+	ut_assert(s < BUF_SIZE);
+	ut_assert(s + bytes <= BUF_SIZE);
+
+	/* This is exactly what we expect to happen to "buf" */
+	memmove(shadow + d, shadow + s, bytes);
+
+	run_commandf("cp%s 0x%lx 0x%lx 0x%x", suffix, addr + s, addr + d, count);
+
+	ut_asserteq(0, memcmp(buf, shadow, BUF_SIZE));
+
+	unmap_sysmem(buf);
+
+	return 0;
+}
+
+static int mem_test_cp_b(struct unit_test_state *uts)
+{
+	static const struct param tests[] = {
+		{ 0, 128, 128 },
+		{ 128, 0, 128 },
+		{ 0, 16, 32 },
+		{ 16, 0, 32 },
+		{ 60, 100, 100 },
+		{ 100, 60, 100 },
+		{ 123, 54, 96 },
+		{ 54, 123, 96 },
+	};
+	const struct param *p;
+	int ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(tests); ++i) {
+		p = &tests[i];
+		ret = do_test(uts, ".b", p->d, p->s, p->count);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+MEM_TEST(mem_test_cp_b);
+
+static int mem_test_cp_w(struct unit_test_state *uts)
+{
+	static const struct param tests[] = {
+		{ 0, 128, 64 },
+		{ 128, 0, 64 },
+		{ 0, 16, 16 },
+		{ 16, 0, 16 },
+		{ 60, 100, 50 },
+		{ 100, 60, 50 },
+		{ 123, 54, 48 },
+		{ 54, 123, 48 },
+	};
+	const struct param *p;
+	int ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(tests); ++i) {
+		p = &tests[i];
+		ret = do_test(uts, ".w", p->d, p->s, p->count);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+MEM_TEST(mem_test_cp_w);
+
+static int mem_test_cp_l(struct unit_test_state *uts)
+{
+	static const struct param tests[] = {
+		{ 0, 128, 32 },
+		{ 128, 0, 32 },
+		{ 0, 16, 8 },
+		{ 16, 0, 8 },
+		{ 60, 100, 25 },
+		{ 100, 60, 25 },
+		{ 123, 54, 24 },
+		{ 54, 123, 24 },
+	};
+	const struct param *p;
+	int ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(tests); ++i) {
+		p = &tests[i];
+		ret = do_test(uts, ".l", p->d, p->s, p->count);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tests); ++i) {
+		p = &tests[i];
+		ret = do_test(uts, "", p->d, p->s, p->count);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+MEM_TEST(mem_test_cp_l);
+
+#if MEM_SUPPORT_64BIT_DATA
+static int mem_test_cp_q(struct unit_test_state *uts)
+{
+	static const struct param tests[] = {
+		{ 0, 128, 16 },
+		{ 128, 0, 16 },
+		{ 0, 16, 8 },
+		{ 16, 0, 8 },
+		{ 60, 100, 15 },
+		{ 100, 60, 15 },
+		{ 123, 54, 12 },
+		{ 54, 123, 12 },
+	};
+	const struct param *p;
+	int ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(tests); ++i) {
+		p = &tests[i];
+		ret = do_test(uts, ".q", p->d, p->s, p->count);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+MEM_TEST(mem_test_cp_q);
+#endif
-- 
2.40.1.1.g1c60b9335d


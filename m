Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02963CA1016
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 02:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F3408317B;
	Tue,  9 Sep 2025 04:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="J7yJycgX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9F9A830B3; Tue,  9 Sep 2025 04:13:09 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4352C83106
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 04:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBLdhZuLKX3HBPJCCJcBUExBj6apXLP9Uj9Ztks4Sy1bTq/rhwO0cKguQ1r1oHtOj1+ecojUKi/1UuhWk7yk0lDz4zbjf8DFtrHAqd7OI7ADZM52mwwgxJ+qVdBFv2zrU5Z6Z21YD6jS1w7kRn8dNr2+esW1tS/S/QJYrglRsjPEN+81VmuHc9Eg6RgceR3GgzUOV8uXtnXJV82tIT8xAdLyXJGewsIVjO9mocXQ/+WhGKe1e1gUNHbdIE4kdIg1Pqu8zf0+OJwtm8pu/Pvl/Wuf3ozXze9XUS7//uEwLAj7rUokJUHdPsd0O/Kc4wQcKy3Ds4BF7/tDnC5AjkiFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUFZ7Q4gFZf1nn03AftEuph9ALbHDC+ZXX2h0Yb7rR4=;
 b=F/b2sMO5pQYBZp9GoSNFCDlGNokeChZuwzLCjU+lffq3I5Mb/eeAUHfs1aslLykJy6Oy8YAEI4q+UvIYwLAYRSVdCkFSNpwAzewn+gXGDxFbrh3sMjp1bZ1zNVy5x8B05KavD0T1EjBl5yBtOjWAbX0WeEvm1EUueziXft+9DyaaskIO8YjvzosxvJfB0m3aMccIlJ28dZYeeLxoKnTgmhjpLZudQoDimjJ8JMUfmDHe/wLj0eVlrdpPKsizPpxZzED3+Lsphct7ermdxVuUKZ75NfvEWznTQhIl6vrOeqMO7Ie3ifjOSUacG2UcPU0k+1zrLJRimM/sfZf/MkEnRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUFZ7Q4gFZf1nn03AftEuph9ALbHDC+ZXX2h0Yb7rR4=;
 b=J7yJycgXE5w2iK5C+CFkX6XFcobt4xOjTz3quEm5GqrzNxCqHU9iTi3J/V9ZIoA6aQ31UPuoZCi+D6WzyUqcQCIu+KTgAz+nU8fx1G5vc7uiwMP/m/bkKRmGvyDL1Ei9q9YpSK9Ep3MPDDYczEO7sVnGiztXydyhGflpGiHeI8FNoG/rlCcF6SbQBH+2LCpKrJgv7UpdYN+E4J5eO/zqB+zBnfYhxE2ZiIKwFcI3rjSYWzGi7lXdacTF4v2eAQReNOk9FgIOXJ0JCGILP29WBdnjz97iMDe8yLJXUVtDPDOMkZZ7S6b1INJnI1hyLC+JDXFmeFkIyB0BbMw61iELJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by CH3PR03MB7314.namprd03.prod.outlook.com (2603:10b6:610:1a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Tue, 9 Sep
 2025 02:13:01 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 02:13:01 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2 1/3] include: dt-bindings: clk: agilex: Add Agilex clock
 definitions header file
Date: Mon,  8 Sep 2025 19:11:14 -0700
Message-Id: <20250909021116.12599-2-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250909021116.12599-1-alif.zakuan.yuslaimi@altera.com>
References: <20250909021116.12599-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::11) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|CH3PR03MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: e9759b65-7599-4d80-eebf-08ddef46672c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WY7zOBuPFUJdZrof7xm/TgtvXUUtGicJiPpy+A7W+aDdFqsrEsJcuzEgtQlv?=
 =?us-ascii?Q?oUMZk28nELi81AptYR1FEFqtir6yE8bkqPPgsuMhr0BDDMNYemOkQgL9Ol0g?=
 =?us-ascii?Q?zRZZGwr/4AOERHdudVMycd9mK7v8VNMeJ7RbC7MTdofe/oFsbkxoHaJ7iEJU?=
 =?us-ascii?Q?2wg90yaEeKykDed7xpbesq2ZDZYeHk15Z1RVLr0KDq1Xys+u2n4ExXUec6MP?=
 =?us-ascii?Q?PMavqc11uUPvj2QTX1W1QP7z2kemSAyF4uzYRn3MG5hisqY9BvoXhpvu/b9y?=
 =?us-ascii?Q?e+Mzu0E8GXqaav1brYPVrbXT7M4ikrViSISaj7l9dwDCr7HRS4W50Lk9sD04?=
 =?us-ascii?Q?rYiGRF0M+F83RS9Y/ZLC2O24SRkLy+JNEsvMlC4BRVBNtJkjAnUFPgjihN2C?=
 =?us-ascii?Q?ivDKEFcP/DCBW50cFwCcPgLmBcBUP6RejtOFx8wXfDd2mu5kZZXeBlrApOhR?=
 =?us-ascii?Q?xvj3Zj4abOX3+M0umto69rjVaRL9g3EgDw0W6Q+QbPDNE+X3LSB7/akestm8?=
 =?us-ascii?Q?UcwQk+Cg8GANMYsdBQyD1MlQQmYe00xyIgpX5meCSn9wgD8lTbOdYAcHgV/m?=
 =?us-ascii?Q?suXof2BWpZtnPJzEl+N/Pph/hN2bPrEXb5jrQr2riAHxjd5Ap5Bc8spXDJ5r?=
 =?us-ascii?Q?Ig4nomdtyy1nIdW4b6V60Cge01dLJQALoWRLXJCouPd2VDd5rpF9EytZiRqQ?=
 =?us-ascii?Q?mGpVVRhKWXzsqkGa6XaCAzzjkw7iOeD1dW/zm6lEnFPPqCrCzV/huLU2T0I4?=
 =?us-ascii?Q?+eeu57gBzKdQFP1Ehxw0xzzi0kNdDTsxwMmw4jiaptbPfKZJerHvEwSwJpfo?=
 =?us-ascii?Q?WSr3Ywz8c3/9SJ51cabAREFsEdCF7Xs7pni9+u0UiWP19h+Q8uH7+uhzqZYl?=
 =?us-ascii?Q?BdMZ2Gu0Uu0ByhuVQ9Vv6WcsF5sQxstjTbzaVYHYzJUVgjyLXg2LIRY/Srxy?=
 =?us-ascii?Q?8TFaAUMDzwDvwdlMezs8QgJ9DBW/xyRr9lYVEj7hHmhnIEgv+0eYpjzrbm35?=
 =?us-ascii?Q?wQWe9t3ys03bB/Gl40tclPS/mRf53Kaw6eIaeAjZ8n5AjUc/a8hYMvJPRcC1?=
 =?us-ascii?Q?p2OLdNvFMuizOUuqxkDsgLOCb6AgsOTxjKeAwJpVZsfvV+uMldPTRGWNA5qE?=
 =?us-ascii?Q?Dc4PRyGJWbPY6wjTLzt7HPIZD4TJsJvwBZa/zRghMYWbi+sYGtXir3C0hcGM?=
 =?us-ascii?Q?kcJxlCBN8vtPpwrYYbf2mR3IvP6fZ9sSwwYUkGa7NAKS8X9KtSQrRM/u4HeZ?=
 =?us-ascii?Q?CiH5AKr8GmA4csVGYZg3Qq1gsIwxyignsVxqIE3xBCKNi8HwODzJfgIjnwIJ?=
 =?us-ascii?Q?UK46nrSC7ZX5CLCIFcj0kvLlUcdmyGuq6lgA91JYjJLO2Fc8ThzHuQs8tzta?=
 =?us-ascii?Q?YsVeu2g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bp5jYQxrgN3RzucKbJKNvQ/I23gOwu18pkeTL6oduYGn4SDm7tGY0jf+5La+?=
 =?us-ascii?Q?C/hzQK3TYDZ23SM+0sSNz/nt/5KpyEtsrtttAZ3HpTsJQBYCzTGUTnf+ds91?=
 =?us-ascii?Q?Jxks5acBqEG2xPjID4nNx+EF5cBItvYr+RFabIwm7RJlZC5JrEw8pxH87mOU?=
 =?us-ascii?Q?XidPI+r3I+6fwObrcsFScz2Y6GAJoPRrwuNAdd+RJyfhs5oU7fJmAQ9xqc8a?=
 =?us-ascii?Q?XHIfrwAQxNOH0VF5iaPYzWJWBAAW7UgVnt1WP7AgHWVbIj+Jf0TTdg0itHnv?=
 =?us-ascii?Q?hQYDzK4qr8YSQKudMJJOf4F/eseDeZOcnadutzgF+L3VQPLxQfjPasrVVqQV?=
 =?us-ascii?Q?55v9vLHTY5kiAJ3wWc++ZbS4dqMNTybBOU1u2UdvEyAhWD4UsO6LyUsTSom6?=
 =?us-ascii?Q?WA7XUXGKygYvLjbSjPwuOBm/f5mx0FJ+CbbwskGZTn/2ffxaSFyhp/zyTJUH?=
 =?us-ascii?Q?PfVrhCKCrDKC8rdK1vs9Fgn4eYnAxW5NjwEzuBqLegmoMhMxll5MXJRQw5M7?=
 =?us-ascii?Q?EQUWcxkTMTKACPO5vVziNa14SBntAg/g4g34vPixvTnjjUsv+1XnzY41kOpf?=
 =?us-ascii?Q?rWWvbiObIJsjZMjoq85eM8cJGrzzGogA9mYBxgdoaExl8rlivDXAaf7V1cCR?=
 =?us-ascii?Q?8apwi6o9HBs4quVPJGBBPmAp+t4qKalNiGoB9rkaG0DLTd2f67uK2op4YrB0?=
 =?us-ascii?Q?HFDAMdaud88AbIGEH06HPuML/GxeuKC+LTSjCkVpKPaW59Wekjje8q3RI3Qz?=
 =?us-ascii?Q?UiwFWk/xaDKgaTDzYBHORbUoTfoTr66cw3g79zngCnuWt910rUvk5+wjN67M?=
 =?us-ascii?Q?qbn3W1R7f0f9fhQ2Jyn1MLfjM+0wDcLRqjuwLW68tToNbY3E10F7x7fkGJxB?=
 =?us-ascii?Q?supiQ/jbuLqyQF4lD7985pcy3jUW1HhNouHGP8NNpN8gQwU4uWp/tZKowHJ0?=
 =?us-ascii?Q?Mn0VI+oaMdt4+a+WQmruVI3glfCrY/+/JwiAFrSWKDYQ9acBmEDJ9zv7iPql?=
 =?us-ascii?Q?S6aYZ/EsvTP4VpyU9GqOCrgnnPf9DAIdB1vvUzXqtt6/Q05A1yOoKXntRrt/?=
 =?us-ascii?Q?NJ0JtaXkZUjlNdO2/Xtr/2iWLQfpjiYXPfsbpUCusnxu1LCYBpdakyh/gzgm?=
 =?us-ascii?Q?lTwfZyiwEZflcIIxW0PA2Dgg7Bs9aRrOMiva/O5myhnvagzk7u3XQ048IZCa?=
 =?us-ascii?Q?/eUSKh3o5wINy+hijADgjS9NMWCLquqIclaeJ0CD3ywhFIacqgyi/VnWj6Fh?=
 =?us-ascii?Q?B64J7nuRGneQTbXaOw6BALkZyHAi6wFB8/esqJL4xXmOAwVHavM2OYL5gGd3?=
 =?us-ascii?Q?c311zAPMmIoF6DRbA3VhB36LGqOm/lkRFdDDqmgJIVheTmxsurczJPkcB5DC?=
 =?us-ascii?Q?nkCRJxUQcVp7fZIMtgVOs+O4Eu2e8iMPRTFn92yNB2zL4s8EHsyc8K1ERRF0?=
 =?us-ascii?Q?1AOaz9SSmVUdxUjRMJFHbd2bku2NPgBNQoof7hB3VSe54QOBXqFzSR49uZ5A?=
 =?us-ascii?Q?h8m8FHhyJnY//9AVteCbWFUzPdOATZX0bADUBDHAa4q9K8tkalg1trCnq502?=
 =?us-ascii?Q?W2z/B7lto/5N1atNcZzpdGH1ND0w6B5PRXru6x/qKwGwd611+IwukK2HGQSO?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9759b65-7599-4d80-eebf-08ddef46672c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 02:13:01.7110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlRc0DS+eeqpedC/jmm3KeoEblG8aVi4aD8HYOHbyuccrftwdZM+UPlTOW38o2sk4nKwdeoy/C39dRHjyzsH5nxQvPxQjWVL8KmuTgLUNeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7314
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

Introduce header file to define the clock indexes for the Agilex
platform.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 include/dt-bindings/clock/agilex-clock.h | 71 ++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 include/dt-bindings/clock/agilex-clock.h

diff --git a/include/dt-bindings/clock/agilex-clock.h b/include/dt-bindings/clock/agilex-clock.h
new file mode 100644
index 00000000000..a6252180516
--- /dev/null
+++ b/include/dt-bindings/clock/agilex-clock.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#ifndef __AGILEX_CLOCK_H
+#define __AGILEX_CLOCK_H
+
+/* fixed rate clocks */
+#define AGILEX_OSC1			0
+#define AGILEX_CB_INTOSC_HS_DIV2_CLK	1
+#define AGILEX_CB_INTOSC_LS_CLK		2
+#define AGILEX_L4_SYS_FREE_CLK		3
+#define AGILEX_F2S_FREE_CLK		4
+
+/* PLL clocks */
+#define AGILEX_MAIN_PLL_CLK		5
+#define AGILEX_MAIN_PLL_C0_CLK		6
+#define AGILEX_MAIN_PLL_C1_CLK		7
+#define AGILEX_MAIN_PLL_C2_CLK		8
+#define AGILEX_MAIN_PLL_C3_CLK		9
+#define AGILEX_PERIPH_PLL_CLK		10
+#define AGILEX_PERIPH_PLL_C0_CLK	11
+#define AGILEX_PERIPH_PLL_C1_CLK	12
+#define AGILEX_PERIPH_PLL_C2_CLK	13
+#define AGILEX_PERIPH_PLL_C3_CLK	14
+#define AGILEX_MPU_FREE_CLK		15
+#define AGILEX_MPU_CCU_CLK		16
+#define AGILEX_BOOT_CLK			17
+
+/* fixed factor clocks */
+#define AGILEX_L3_MAIN_FREE_CLK		18
+#define AGILEX_NOC_FREE_CLK		19
+#define AGILEX_S2F_USR0_CLK		20
+#define AGILEX_NOC_CLK			21
+#define AGILEX_EMAC_A_FREE_CLK		22
+#define AGILEX_EMAC_B_FREE_CLK		23
+#define AGILEX_EMAC_PTP_FREE_CLK	24
+#define AGILEX_GPIO_DB_FREE_CLK		25
+#define AGILEX_SDMMC_FREE_CLK		26
+#define AGILEX_S2F_USER0_FREE_CLK	27
+#define AGILEX_S2F_USER1_FREE_CLK	28
+#define AGILEX_PSI_REF_FREE_CLK		29
+
+/* Gate clocks */
+#define AGILEX_MPU_CLK			30
+#define AGILEX_MPU_PERIPH_CLK		31
+#define AGILEX_L4_MAIN_CLK		32
+#define AGILEX_L4_MP_CLK		33
+#define AGILEX_L4_SP_CLK		34
+#define AGILEX_CS_AT_CLK		35
+#define AGILEX_CS_TRACE_CLK		36
+#define AGILEX_CS_PDBG_CLK		37
+#define AGILEX_CS_TIMER_CLK		38
+#define AGILEX_S2F_USER0_CLK		39
+#define AGILEX_EMAC0_CLK		40
+#define AGILEX_EMAC1_CLK		41
+#define AGILEX_EMAC2_CLK		42
+#define AGILEX_EMAC_PTP_CLK		43
+#define AGILEX_GPIO_DB_CLK		44
+#define AGILEX_NAND_CLK			45
+#define AGILEX_PSI_REF_CLK		46
+#define AGILEX_S2F_USER1_CLK		47
+#define AGILEX_SDMMC_CLK		48
+#define AGILEX_SPI_M_CLK		49
+#define AGILEX_USB_CLK			50
+#define AGILEX_NAND_X_CLK		51
+#define AGILEX_NAND_ECC_CLK		52
+#define AGILEX_NUM_CLKS			53
+
+#endif	/* __AGILEX_CLOCK_H */
-- 
2.35.3


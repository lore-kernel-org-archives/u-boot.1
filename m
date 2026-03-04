Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC1CEDEC03
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 04:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E96483FF5;
	Wed,  4 Mar 2026 05:22:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="VrQ5w2Xd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D45883F7D; Wed,  4 Mar 2026 05:13:02 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F322283E7F
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 05:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4DSp1Ed011Nwbg2sjMWLiYIKKtbdL/2EwIQ8jzdsPwW0w2hbeM560UhZ4q2ZhQD0EQR+FkfF5mvHElrd4KHeP7VY3JOm213ZmrLR+glNnn/oTFJaDnQLbWIrhH9IrgXFIkMQ8qXJxAhAw3wgXNv5Jv1Yq3YfnztpfM/DHKn0mwZu7cM5kr8zapXYPpie1LID3/m4wPDEO6enOTUkNyi1Vmq8PQKafQWMpG1azmzjBJipZEi6gvNdTb6bJxYTpESYwKj6WtdzWLuqFf3Xmtau4f/5LIJME3lMKJlTGXJmNO4lbrWGG6ygTgGcBIXmvFEtdYcdiexXVJAn96cQTnJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GAfqU1tSXhLvPvtRNneiyc5zLtYWqJfrjnJlcZhTkg=;
 b=UroE5gGPUyZNxpF3zfyZ0Qv9cEihEfF482SLpxaBWogYueG3S1LfUn4XR9qUsvi4dpw9Lr7M+PKr9KiuZI7qKeAWA4uOWcNAOlSi/V+0BJ+ejrC71Ke2eg+mIrjc89/YscgrhAUBTqfzuS+pqgl1xfRirAG6QKkJ3310qMoP919dFwCGSCv6f1F3RwvHwlHP/Cdh5NXv8px0z9uBpAT7aZgbU2+UWWntPUALg+SBk75GlLFLyC7i+zPaWdKoFSuzaPtF3eFu33U30Jw8Tsngvm4cCJVfXOpRYA5VnB/cfun6FmZxoOG4Mpwlh4D8tXqbtsw2Khl/3pslmlt5E1MWyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GAfqU1tSXhLvPvtRNneiyc5zLtYWqJfrjnJlcZhTkg=;
 b=VrQ5w2XdrC/Yj8UbZhHfDBN7PKBEAfIPHTdInksrNud3NPoFDKF1bKP5kyb4e+veDEOxMObk4odHwN8N/lWDS5TbO4YPvELT7W2HbBHzOzaFOFywE3LtIvxwKvghgQ/i/BSv3uY4ZhzJb67DSrsIeyhvG7JPVk2hJmc4qENOaamExGUrII10yh0aDHWCjceTpcq0nRt/tz1aYjnmemZk6yAn29kiC8G6i2DiKagZO0ay6sWK15nOxNgpq8tZ7UUT/M1BUKkaIWtQo71ZB1HhhTwz00dPaYRuxc9xooqHM/gNFFAoYhdB1RezxUfYbPgrjhDUsahygYZgDC1LLPvoHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SJ0PR03MB7101.namprd03.prod.outlook.com (2603:10b6:a03:4e2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 04:12:57 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 04:12:56 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] arm: arria10: Add correct mask bits for RTRIM and PU_DRV_STRG
Date: Wed,  4 Mar 2026 12:12:46 +0800
Message-ID: <20260304041246.17900-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SJ0PR03MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: a00ef76c-581e-42bc-3be5-08de79a45067
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 2jUQLmjelRlL3JaB9QgpOsQVntKYaNyivCP6+yC/mVfXbps4yGRh7IrjM2dmSU3xyYc7pfFmmAdiYjXdKgePRI8IPt+VVQDYapby3e/6ZrlpUzkxft7OfArG5jO/EVsIEigPTCeqkFqaiqWOYGrffznvJX36mKPeBiK+wymsZ9denlS7c7x4Vx8c0M/Nw2LD2stJD9o+88gFvXD20w4xlY4xEHX9tld1b43fHV+3pcPC8ffigit4I7TjiX5kQnKNrg0q1Xv46SGbiTnVwdO9s5uLZd+X0b71LyjkEFh2NfZFkOEemK7cvIlrS+TGvXXy742D2T8jv47XAEwsOjHEsH81KMzAy2+aMAIjFcnBMSicv27NI1IAXDlwSu6QYFvZrJMZdtGaMGxrC8HtbAYk7YH1sboLLwsxGOUcur3E2ucEhZpbeAg2OHK4/o+A0IfheDtYiwR+m3TgrXkU+6U+4+6Lx4O69GvmxbIvhzYPgxlKpZH/F6OwrkpsMA9pO/Wj22hObdK2EQORz29SBTYs8koqRsn9txpQ934ppyZkwY8mgAZhXWnW1NRYu7WC2J06HLfkgYzpSj9wGDtKdxCVZeD7wIa0+MZ2dLunrda7mXKZY9j3naJD0xSXKF4/pN2DbOo0iXYOmcIyuOyDlam29B7C/2bZpczDn/rdj6k2cSKBuuSq3B1uiLjvOKFuAf908aXJWKHin8XniydyPO8RGvaQo3zQHkxg0GFmQdGFn7w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oS1Ck7v/PNYx8jjGUVVjiOZJyliv/Xyw5yzQiQNNHABINueF/9Ix2hOLD5dg?=
 =?us-ascii?Q?BVg6Gg5A6CDd+lJ+uYureu/bqvnlUOIC+FhqF4l1Wx6rpBFwds0X0e5BykTS?=
 =?us-ascii?Q?jxfdOcg8I2xP0vIDfAnpXY9zyypPpJVQLIL1ld6VfGEfu8G3ksNs5szBbcDk?=
 =?us-ascii?Q?IWYNkPaRSZo41Y5IC0oM0zqTQQumMwgubVklt/jiab2itWGOUbzu5UQ3zxOe?=
 =?us-ascii?Q?kUkzTBoMmW+N9moWoncJPvmdcibbYgL4sKetrLd8wM6CDRJbNX/pdn6Axg64?=
 =?us-ascii?Q?8+0bjTrn1SWCSvGxw3KNv24rgSSnfSNPCUOy4C2isMFuXA+O87PyMyPKl5t/?=
 =?us-ascii?Q?JOp80lwoa6TK2XCoOTYsRCXjq4I5srq9BfHqYMG5n7PgGYMHkm/VAlRuq6qJ?=
 =?us-ascii?Q?QaquK9xLI3Dr/UDpoVIto1Qx2xkocWCEywYVId7TFLkS5noCW0lP07Uic6wj?=
 =?us-ascii?Q?uJcPy0sywB0hr2o00olXprCPiDvC2QlixK0UzhOCdpKcLEy7sW+qcC2PnsQ+?=
 =?us-ascii?Q?Fvm6KlWfZ9YRE/iGxfR1TnSW8Zjbgt32qpSA1RGBkyyOlMctdhWo4t7UQQsc?=
 =?us-ascii?Q?JVWyOZX+SDOGvdm6jR3wkXVOi/i65z4p+gii6/HSiKsaiEP81jqz3sjyrPQr?=
 =?us-ascii?Q?YpxFNHBhahWCNXeWar5xd7ChAPFinMxsSePpBUpc8Y+mCcr/jTfK47XPahRC?=
 =?us-ascii?Q?5xdBRRoo8nF5zn/FC82RQ9FfXB4/IpZ/yvOe0PNISwbevZBdsFXZptepv8Pj?=
 =?us-ascii?Q?+p+Bb+UOauffVr2xT+D6IOpe5Sapx02SRQBvc2psiUdePGyzQxmY5qgoMtlN?=
 =?us-ascii?Q?okeY6JpYolt+9NubQ79GKlWU5SO5ZAI924yOj6NulHwTIwzrK2WYT8Cq4wVU?=
 =?us-ascii?Q?BPx6UrAXDU/OxXHGK57zYH56t9IlQGUiDZ6cNHgrLWBXHwYigMyYsD1a2qIh?=
 =?us-ascii?Q?sN5E8tLopkwv7QEJGSzlBBkb6d+avpY2pvTijmOcKXlnX+UDYiZAC55rOHqv?=
 =?us-ascii?Q?er9TXfDC//4uVGq6LmaKzR3JVkgR6FQxeKbHszkTRre7ATDGMUidOIf8O8xX?=
 =?us-ascii?Q?6rcH46uqGHhbckuflWKoeQTjWIP6BUDQcr+YWyBpx9w3E1WfdYjz9e240UIz?=
 =?us-ascii?Q?wQzv2wRwnU/ffoR07UTh/oW0B8hJmgoSdiPWENjHGrjWYgK+oZ8Adk5g9KWt?=
 =?us-ascii?Q?X3mYJEMgBh5i4Apj4DPvA4IKA7Qm8Lpic2F6pUOIYUcVbhktcrwIZosaK+/T?=
 =?us-ascii?Q?KnW6J7r8k8YI5tldVdSZ2YAegRAyPVwCuxcZ/dlWFlXtCt7CtO0QqtkMCdkA?=
 =?us-ascii?Q?OQcu2IRsrnPoZI1R1dpIs7meaPJRfnXK/st8ecMDy+T4/SDlOA1R83VJVH0R?=
 =?us-ascii?Q?Adej+pIudSRyvGmPI1myoNG5nUUnZubVt/WkWFLznxZIyuMB/+PN9jDZMIe0?=
 =?us-ascii?Q?EHBga21UfuRcWODMO17eOBqH3zbEi3Kxim6XNDOdOds+UF26WF1q8FO8mI5E?=
 =?us-ascii?Q?OtBZRkuup5cELA4KGgeAb+oHsx6u+zQsYptjzWrtt9KTDzeeuPF3ZDhxjDOA?=
 =?us-ascii?Q?zt+ol3fgGpgKZe6VcnrB1JOQKV2959zUFxV4RH6Emg4QQ78VpzLej8GbOIN5?=
 =?us-ascii?Q?bc5F/0WGFNi7gPr4eGq90yepfg4gTEErEF3Apiz8PcxoC6cfu+SSX2YoSReh?=
 =?us-ascii?Q?a7MmIEnHaJbHJzFn1fhMqQijZmmXPpBNsPbZdUnUA87/UnqDOb2sgnMqqQsp?=
 =?us-ascii?Q?liD/Pyoc6riDhZnGQ/5g4f+N8LtTLQ0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00ef76c-581e-42bc-3be5-08de79a45067
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 04:12:56.8453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0Z3CiiSM9tT0gBgv2Z9CXYgpNyS4LJv9/FnXSRASiPYsGCiyQ3yAJdMxtqzwGsoLtfksVUTFDxO3PJHDoZVAVhEBxLIcZNZGfyhKaxYoIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7101
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

The current mask bits of RTRIM and PU_DRV_STRG are mismatched with the
configuration register of arria10. The correct register for RTRIM and
PU_DRV_STRG should be 0x7 and 0x1f respectively.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/qts-filter-a10.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/qts-filter-a10.sh b/arch/arm/mach-socfpga/qts-filter-a10.sh
index ab16522add5..510947d5632 100755
--- a/arch/arm/mach-socfpga/qts-filter-a10.sh
+++ b/arch/arm/mach-socfpga/qts-filter-a10.sh
@@ -106,11 +106,11 @@ EOF
 	echo
 	echo "/* Macro for Config IO bit mapping */"
 	echo -n "#define CONFIG_IO_MACRO(NAME) "
-	echo "(((NAME ## _RTRIM & 0xff) << 19) | \\"
+	echo "(((NAME ## _RTRIM & 0x7) << 19) | \\"
 	echo "	((NAME ## _INPUT_BUF_EN & 0x3) << 17) | \\"
 	echo "	((NAME ## _WK_PU_EN & 0x1) << 16) | \\"
 	echo "	((NAME ## _PU_SLW_RT & 0x1) << 13) | \\"
-	echo "	((NAME ## _PU_DRV_STRG & 0xf) << 8) | \\"
+	echo "	((NAME ## _PU_DRV_STRG & 0x1f) << 8) | \\"
 	echo "	((NAME ## _PD_SLW_RT & 0x1) << 5) | \\"
 	echo "	(NAME ## _PD_DRV_STRG & 0x1f))"
 
-- 
2.43.7


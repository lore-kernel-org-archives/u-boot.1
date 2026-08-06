Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82CAC5AC7A
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 23:45:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 807BA60881;
	Thu,  6 Aug 2026 23:45:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PZ0EzQ30J6IC; Thu,  6 Aug 2026 23:45:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C3BC60867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786059907;
	bh=292JAy2Y2rwDMQnbrODzuJIAKWxIgpePE6Yshf0U38A=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=H6ar9VIYEr3m0NrpxZdTaSfZ6MqUtm+yMQk2X9MBCoVGJVJ39PBCzLSUVvzwLxCjI
	 2nX6sWMEfn6uxoH7TJ8h69CpHcFYDSAouXbeqHJiZKx8Lo02EBQixZJN/wBwROv38G
	 UtENluGXIUjEE/wzYFzUk7EeNClNpPMosOG5qZTlWR3xWEjZBc+Be2uKabAVO/M39h
	 E5UxkRNzVV1TcMWlpmforZ2lDTUiauA8oe0THrWBQGp2c3EWh+it/O8oJsn4Yb73Zz
	 RrdDl2Z+QEP+H/8kInE/z1ZWIv1FCKtcqXyttMf5wkAUdhax1Uh4E122aeyaWvScrC
	 mRQIgpt8osDQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C3BC60867;
	Thu,  6 Aug 2026 23:45:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EC5F023F
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D8AC740919
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zrKGctOnTfZ1 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 23:44:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B6E6A40911
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B6E6A40911
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B6E6A40911
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/HqtquyddRJxwfuxbQG5tYsWQ8nFWOKNPmCRS8nmtsr5jkgM2MX+M1mfbN5457JX+h5s98p+aJGqQSgAWuluBx6fdEUg1+/5PXTjCAYkzJMzdJzSQBfk5XTPDpFXL5eQpxb7sEJRvvmVve911EWoG4SIGkxhJM9wfKIYs1vBStMz1K1KsloTgVNM5Hr4DCfENKvXkuivxIt0pV2nw6heZbMeNSGWDk+Yyl0rFM/kzrvKZifQjqtNT1srn3xBNV7TdSRSg5Rlmaq/Sm5WDz8zbV+StRBjV9nUT+Hjad5lfDLPf/zde259t5YfImzUZ3+BSQ97ycE/hjantqFrowFGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=292JAy2Y2rwDMQnbrODzuJIAKWxIgpePE6Yshf0U38A=;
 b=jVcXwQ6U8gAB03MweHnRDxFLTiZaoexKxHaGpT7/UGWRGwufJGFJhcGGoicl6mY2yhujFBU9ianzo7vjuqy2ToWXjQ1HGKO7sbapL7Y4jtDF8HfuXpXgns5c7PGygt7G2M5cZvVapfIoW7u7XlNmQsJSFzE32mOJgfxcNyiWUwDdNobYBRjPY2Uwftk4o06y+aMvEkN+1p67g++F6hmZoRAW0vR1Xpg1GIscvIXjrs0JCfZ3hM2qgv//kii5PRFFHuXFB4R6wJXNgpINUdEHJzgDxEySj5MFCtkbwV547mfdOo0tamvDaDMchs5yS/hXfSXiEdA3w+hmG3u3KQj+Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAVPR08MB9530.eurprd08.prod.outlook.com (2603:10a6:102:314::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 23:44:50 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 23:44:50 +0000
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 08/16] airoha: add MMC node for Airoha AN7583
Date: Fri,  7 Aug 2026 02:44:24 +0300
Message-ID: <20260806234432.4098414-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC42.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2fa) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAVPR08MB9530:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee386d7-3e07-4575-e34f-08def414b43b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|921020|38350700014|56012099006|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: c9xso8q7Y3E5Ri3lvTrKQ/imko4EuGh4ZNA08KMHHA2ERgxCI0JRxiZl3YJWrXGa3VACqSyoXBrmH72PQbJBPDote1ZFzibCN+ijOaaPI8uz9dw2z7DLdZ4oe7SOi6vLqUbKe3VoKV/puSscZ9r1MPUKr+fbeJmtF4KMj+1D6QWOGuWpsqkqUBYdAIPGZ0hxDj8i/s3o/1XzKsbHc1c6JGaxiR+uj8KcZ4lmrHXvdOisi5Z53CZ2VUxA4NmrC2UMHY/pxhlpHbwlv9chanQqxdjmiTfSnDFl1vPdF2t4tLSGuINfjzKKX2y17LMz4P5RbQx14tosIVm9TDtLHRyfZ4BkbgkfbqkMNIwsrQuDZYNEruf1du2B+YAiQ8JvFSDOpbr3fcE/mzf9hbJA9iuYOi0aOm53NiJeKZ2xF/jGKiQ8YgSaeLF3nonM+wrHJRWY6Tov8Owy0Zj3ocdFrUDx8fCM21Rvt7McPxikfGQ0qf9teQWIdtxYTN1IRpZ5AeQyy/5dmZS8I/PwFyfFcCjGSKLKONoBMm9/D4NiSZsVixl6EJCjLWte4rUgbMhV2fryPx3ZnOaYYEVW5k6Ebp2zpMcX02NDYhVkqXQl2ZX3q22mCj36fBO2F5xio6LdQwoK8CMkZB3iFboS9mrpv5itDy4FYzc0nsW2QHb+g8BrpUxaAtgWBYJSgJ1Tf/xZDYgkXQDoGrxOf5FiT3LKucxqgAVGo+KG6WeoYdY4ILyNBXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YOnDHIuKnvlwHMfHV76owxDUPwWhHr3uA/46f3GVOHvrg8R0xUoZBbTqvB9S?=
 =?us-ascii?Q?j2kf+VgvxbapYGjobzdMob6JZl0+6+Txc46haPCFrFtYfmL4ZrMTtXltvSiG?=
 =?us-ascii?Q?V8aBS+uVSG/3zdr2+19T9/nNJGfE0BJoRTfg/aNNvMLErKF8BdxGd0+Ym4S7?=
 =?us-ascii?Q?IrS5ulJzFv3ZGpb1RnaI9OUxBhZTSmteH4MjKjZZcL5fgA1HcDv8KesoGlxi?=
 =?us-ascii?Q?hS+afFEqu6eJNpuxRwr/btfRoAIrBPyjdrdI/MKtWnkxJguPd1LnW+UEZyuK?=
 =?us-ascii?Q?QVlpZ9JWIDqOTc2z0mdvjcFVwECYPIdFL9uhlcwArD/lcEAAKeNnU/Def/vD?=
 =?us-ascii?Q?ihZp2guTvMBTV1lcxKco/rAFH7TTXXvxDsFIZPUV5BbX3K4Si71FbTXlouwM?=
 =?us-ascii?Q?QL49+xX4ynRNXoEDwpVJ1JoBTZfk6Je86dZrcZCKyxaZrPFNoDHES4GnlEiz?=
 =?us-ascii?Q?4KltZQ1WRGn574hZClV61xUJb9eyXBEwD+2U3tZB/rAeVEkGvhhMZdtiavkW?=
 =?us-ascii?Q?Yevaom60s0hL2OaqSfx4/rWo1BmBNiITtm5X5JlZPfevCb9TdBhhRQHDR1px?=
 =?us-ascii?Q?00MeReP7vi6+OAn2PsXcYQDLhpkWzt/PcVhmk/yvPc2oYVy3xP6XcQCpHcQA?=
 =?us-ascii?Q?mR/eacV8wV+QCIrs/CJa0ZPZSTfBk/KOhRDdjMXXsaJ2U96pAgRnK7C1remH?=
 =?us-ascii?Q?54Y3a8CrM9C8zo9WOO0RQhS7VT2Ew41Z6D617WLuj2WZJ+G3r+0JuKPoHQoK?=
 =?us-ascii?Q?ZncMriAglehTfGw1MpJBr0vNsOl18eHfO6Pr3A8ohYOIEt44HvHyqpJbAkgT?=
 =?us-ascii?Q?Oju06/x9Hg9S7MlFwCbxDli/2qlde7ZFRtt6b1AeozoFSvFDIGtlb1IWa6pa?=
 =?us-ascii?Q?0y0lQ3TQ+zi0zilD6EZyUnOllxGSMwB/qbBWpPqDiW1nzAbSlQ+pOdUrbAvA?=
 =?us-ascii?Q?qZSxcZ4IWn55Tjb+gqE6tG77rHxh+ue5vu4y1NMThtUo6N+64qoqT0bbxaGV?=
 =?us-ascii?Q?e+MI4IxVsgCO/BcfaedROByqI1KYI/AYrM4w9jh4OcaGDtdz+y9FF2CNegqe?=
 =?us-ascii?Q?eWuEwRzerrK3t8ddsT9IYXKnv5OKVrO12G4TWOhE3MdlxW3Gs9St6wHit0CF?=
 =?us-ascii?Q?obvIqLOic7t9x6OZ1oNrgcKZ6cObQajwP2AI2McU+y5U/SngvrV/y8z1LqTg?=
 =?us-ascii?Q?38yj8LSaIChoBJYxNyjJBLtzolgeGrYNjWoXl+4lL79umeNidXttZ2Hj3aHb?=
 =?us-ascii?Q?sIiagPmwwrv4muHyxpqq/C4lkqZTDg6opVh8tYIZuR4beurhnsUs75FdnrWY?=
 =?us-ascii?Q?ORYseBre3qhpFMSEwwTctVsZlMbWmctwM5XYtKOvwvqE/3ZfFOTV5GyTtAO7?=
 =?us-ascii?Q?DQrwUdfIxHpPW9J962svxZmOZeJXwFGH4mh+pkl/jqtlNn6ZLW0hCrhhzg9Q?=
 =?us-ascii?Q?NvcsIN5McDpJMXqNURACexRGh7/AELhOoknn/asfR88hEesLA4PZaAysDYjZ?=
 =?us-ascii?Q?+0eHjuK+ydirfoqE6ZzPfETfektDmYrFvF8H1HlEXaZZZhiUtatv3v7cFqNj?=
 =?us-ascii?Q?PdRBWlXM7jCHnvgEOze0Ni47UYZwj/u3u+XmnNVmIwEnofuLK1Vn4hMNAxqe?=
 =?us-ascii?Q?xTJl+AzpCIwPmSKeaY76PZzQn23wZ7Srj//jlJ2IkGr/bU+WBtHFl1uXzOfv?=
 =?us-ascii?Q?OsM/9sKeTmWQIytt52ucUQm2nOXDTfbFyRx4LfsWwRhKA8e6eDzkOa9lRmgV?=
 =?us-ascii?Q?UFkFd3e2wukyRg2Nw6Z3GcxQNfJjqL8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee386d7-3e07-4575-e34f-08def414b43b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 23:44:49.4814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADUpO/RSt1q6P5J+Gbfrmn0LjowDwoRQo7Aa242aivFvTCyZO6epteDQrlFweXJG152PxzFbxgtDAMVnEJfWuZnzCp3jItnLca3jlmk6ZZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9530
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=292JAy2Y2rwDMQnbrODzuJIAKWxIgpePE6Yshf0U38A=;
 b=con5SIftlXo1oR25Vn72yTyd+Q4PGxM9PM2nXd6VFhnaphEAFZ+pWlXoha0SAvOku8lZPFynp5A3WF1noMo0nrwU02LjyuEH399Hzo0uUFrO1G1rF3JjxD7lTCx5CI7zfq4oW/u/W8vdIq1faNEhEaNFtrTPNKsSzc5wmGKiLD3e/H8egkz/Na1v/XxuIA7WlumUOdBN7ll1NwdGtUhXNmB1a/AMKx46NPcOTrEgRcq88gr+g8g21tBzTXNz4vWZabHtsTMXX2NqyVmTDHCmbygpCDVxPtw5UCQvnFJ+xKDddiq511diVFeusYXqesAM51p2Mk6TL561/rX0VqKufg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=iopsys.eu
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=con5SIft
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Mikhail Kshevetskiy via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Christian Marangi <ansuelsmth@gmail.com>

Add MMC node for Airoha AN7583. These follow the same node of Airoha
AN7581.

Similar to Airoha AN7581, add the fixed regulator and fixed clock for
MMC.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7583.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/dts/an7583.dtsi b/arch/arm/dts/an7583.dtsi
index d67b7459870..1a64f48e5f1 100644
--- a/arch/arm/dts/an7583.dtsi
+++ b/arch/arm/dts/an7583.dtsi
@@ -105,6 +105,21 @@
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 
+	clk25m: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "clkxtal";
+	};
+
+	vmmc_3v3: regulator-vmmc-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -259,6 +274,24 @@
 			};
 		};
 
+		mmc0: mmc@1fa0e000 {
+			compatible = "mediatek,mt7622-mmc";
+			reg = <0x0 0x1fa0e000 0x0 0x1000>,
+				<0x0 0x1fa0c000 0x0 0x60>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&scuclk EN7581_CLK_EMMC>, <&clk25m>;
+			clock-names = "source", "hclk";
+			bus-width = <4>;
+			max-frequency = <52000000>;
+			vmmc-supply = <&vmmc_3v3>;
+			disable-wp;
+			cap-mmc-highspeed;
+			non-removable;
+
+			assigned-clocks = <&scuclk EN7581_CLK_EMMC>;
+			assigned-clock-rates = <200000000>;
+		};
+
 		uart1: serial@1fbf0000 {
 			compatible = "ns16550";
 			reg = <0x0 0x1fbf0000 0x0 0x30>;
-- 
2.53.0


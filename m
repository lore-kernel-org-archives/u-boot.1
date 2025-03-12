Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC17FC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 13:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE9DC81875;
	Wed, 12 Mar 2025 14:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="dA6Oj38v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B9CF805D7; Wed, 12 Mar 2025 10:10:23 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38E75801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 10:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTT0F2W57CNGWAMP3CsqcVAjKt6ASWlNx74UV4bG0PYp9wRgcjZrV1KIIcOd0IcxxRj2awQPZxLp/AS7jsMAio9cqIkectZd1/dq6O9VSe3SsyN0x+r2EmP+Zca4FnqwvpSZ5Y73r+feGHLOhrbnFGc/n5+a98FwJIEaZvdHcuTT/o4Ggjsk75osVVFFJIsFrc0IbE1IAP0A51aQhMzyE3uNvlVt5UvIOKFoeiiDgT9xzWIhJR0VN/XH8a15Zt5qt+AFicNTX8hPNWIjgcgURyf9CFyHBjFlWKzxuXTf4NsIljOz1FpIApwZJGQM5cu+5HG/lzhlzeoCtpBzxv6RBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVgzIbZ4J8HhUXx31WGOn7SsQu9ya09MCHrDp1HqRFM=;
 b=MxGJpHtRoKgi6ysy4Lqo7UZ7DReXcMytJAv0k+m/8M/1XAeyo8/TiDyG+EjDcXqyFs7G38ayVmHd5VVo5GNVUNWqYG2KkBOy0pZRcfDmwjPiIYgpBhiw6hducCttsLuuMbVcbokjw7sFmH4iKC8DaA8omQzeieTUwxc9NatTvKKeR/k44aA9ROzwBnT9hePcwP6fqn+wmD9YY5PyMrDam8sK6bs6jPwrW/qUcZn6H15Dzztm2k5agY/3/8VeNSCwBObpvlnUINtF2P3BmouoVa5WDF7+kHBkNBLUBM09BHAYwcT+YitGw2AdJzPJroq4EMLtXefyPXcGDKsgrE5HDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVgzIbZ4J8HhUXx31WGOn7SsQu9ya09MCHrDp1HqRFM=;
 b=dA6Oj38v/lArELepi8Rw2kmEEv5m2LKlE2cCOmbAUzxBicV5kSK9EXIhhrxq7j3Zirn/dEOMPwGuwF8nzmmkiQhR1AvXvayGGUJRqTKvVXZslFdzqnYpV4FtZ80KC0GIIF8D3u2GTQ5iFPDxLgSZKzuBy6aKX/A5yRDab5IiRIUq34XvnOmXt5cchKlDnLPgY0/nyRMa886esy5r0gJyTLxFQDyMTQ21jBCWAlJJUsbeX8w8V2x2zJacsZLnzq2uBlNifJLeQxd3ta32Cp82HgUNoJLNTT6zZ7qoOZHif9/FbpGoHTzmr35/1CPZw1aLfe4whkyGT0xTnq0H1LEbng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by IA3PR03MB7716.namprd03.prod.outlook.com (2603:10b6:208:515::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 09:10:15 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 09:10:15 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 William Zhang <william.zhang@broadcom.com>,
 U-boot Openlist <u-boot@lists.denx.de>
Cc: Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Muhammad Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Ting Ting Meng <tingting.meng@altera.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [CAD QSPI v1] spi: cadence-qspi: Add disable STIG mode quikrs.
Date: Wed, 12 Mar 2025 17:09:44 +0800
Message-Id: <20250312090944.35977-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::16) To BN8PR03MB5073.namprd03.prod.outlook.com
 (2603:10b6:408:dc::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR03MB5073:EE_|IA3PR03MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: ab326bce-f805-4389-e3f5-08dd6145b3c0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dPDz0qVdDFhcFBn8Z3bOxrdPH7mPkoqdb2WRlLU0m24UjIUpf4p/+YmnFEhQ?=
 =?us-ascii?Q?2olJzbA0K9V+GVZVMPQFcOxZIvEKN1VG4csCZLpIKZhXA3Ckm0ezcLnLBGSF?=
 =?us-ascii?Q?fjQ9ctX5S7aHU7hLjCTCLqFdyFLMb03qnERhLLnFK4xEq6M/VWlfzx+rRStE?=
 =?us-ascii?Q?9HaPSehFNIRpUBEcwVzK65RmijynV2HrAxiGbE7DZWBCx40ybTibttXlx6Op?=
 =?us-ascii?Q?B7qEeul5kftccUUzzFi/ZOhmyBT2l+09ErLtFOjrxMmid9yiTNRrK8ycp+ki?=
 =?us-ascii?Q?RNhr3+xPetLBH8SFZE5lVnENsqUCSjtC3Amzmo6y/Ni1QSp1of+6VXisNlue?=
 =?us-ascii?Q?bm/7Zff1yk0/fVzxHlYoOyPHKbnQ/qYe62m6ggrCKx/v1Y7xTXX7fVp+pdAO?=
 =?us-ascii?Q?/YlwtnC2S9rS0w/cVc1HuhOKhe5917PFp2dvWUfhAptkJ5SNf+Ho7ISyMlzR?=
 =?us-ascii?Q?IH2J3hdiHJUqW6H6gscoAhyqV/KlZEw34un0ZwWBWVMpDpBYsRAn0LdSpayH?=
 =?us-ascii?Q?MltEjPIPulUYPTRVbwSZrIY0ppZiU6XhYfouGLK9w0zfx3hyjT5p6sc5N3aQ?=
 =?us-ascii?Q?zusewxybRPLAS/ik22jiPcvKD15v1fdXDq26+u0D99kes2QB1Y45W4QgiR6l?=
 =?us-ascii?Q?nGmtTaM3NuRh2w5Rix+9sVfP7TvMAJiX5vQpBv8bTB+Ti0XvQ6a+/IH3kqFM?=
 =?us-ascii?Q?Ky6UiwdR+Si95M89QPAuYal1WuXwCXZhmYo7X5wJd/2eH5jRus4kVt3S8vBZ?=
 =?us-ascii?Q?+3trzwST8m/TRodsW/Lzn61cPQroAN9z8/+bLxyY6KrWLhyA7XMd0Phu4Ue3?=
 =?us-ascii?Q?B8nf9XN/wKEv0ZWmCtYkOFIzlT1wJyUHd+mhmxnVeINPnE87HLbT0FkbPYBu?=
 =?us-ascii?Q?QwLcQc3ig5eh2ZtOVF3ZnUu3agApEHxLJqpo+uK0g1Dda7R/ojkW4uRpNI6N?=
 =?us-ascii?Q?wH/VHYrb94kl1ikuS8UYTLxTuM7OQZR4fFtX0qWO8/I9Qp0ldVAHWbqJ4iNY?=
 =?us-ascii?Q?AQ1P7ER1fsQMNadSiGrsBV8PBdLAuJJgnbJPvY6Sia3ISKf5aSkAOw0JVTEO?=
 =?us-ascii?Q?fBqXYLkUnf8bM7twlehz6tNXjAwiLn81BN1/VDKg+A7I4kgZr9MCY839D4cD?=
 =?us-ascii?Q?FfnG2BprN3/LSW/Q0ZA+uxMvyaNMNbhYWmXXAh8xo3t8Q9VkwIHhmv/uL+ma?=
 =?us-ascii?Q?7C9LVoVrEiewGKlx6LiGEmFlFGb85Zzm377u7zdOx37aypR633MK4lybCd4U?=
 =?us-ascii?Q?kytSo2zX5lO/TbXyJULTVlwPDOyEGjIn3iq034Ttz/yrOuhEmDA5S6TL8jMw?=
 =?us-ascii?Q?P9RU5ogMIM1dAmZNA1F8k2mlj76+Dq7n81OFtcAphNJzl8QfwE2SUdqxqQCs?=
 =?us-ascii?Q?kZiyNYD4X04GVPiNpzaLvbWnFWY0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR03MB5073.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?btxF0VMeioIw5Sj3SqSdDIv1zDJ4sDoGMbXFYu15Vzzei030HHi35+XQtP+C?=
 =?us-ascii?Q?LeFGBLT218jMKOEIoUDQsONCBEZUkqJOtqdaKzA6jL0Gs+Ou53x9zXfOJE+z?=
 =?us-ascii?Q?sd/sb14fv9KUMULcMJ8q9YrB1lmY5rfONtsDr0bkVUeSPrZIlaz4pd/aOPUT?=
 =?us-ascii?Q?qsWL+198dKW8eR2oflvEZ4olxNCrT8Y/6F0hzivQFWfLl0MiXqsSyL5NnDjf?=
 =?us-ascii?Q?7E0JFxEzF0/yzY+GqFSLlpJNUovgcmTu2ksmcgxO3oQE1idDjjZm5YVzzftV?=
 =?us-ascii?Q?VzGNc+TaIc08awJzn9f6pvtqetNkn3LlDRZ7kwJy8t8Tc0qp/jWontDx+BzF?=
 =?us-ascii?Q?YvRz2b2r8urO0/wXDx9O0JX0NxJ3THUl4WWvX6yGyIdZPd+RwV87sLX/FS2j?=
 =?us-ascii?Q?wku+8zXS0OjH/XYpd3OMJVwxV9EnBHK1xWIstJKmrvoLBmj8RJ/W7Iqph0GB?=
 =?us-ascii?Q?SUmvOSeGC1Zrj6zQpM32ctpHVnMWB2crNf7H2BHpdqI+31oibImp2SLMmuMo?=
 =?us-ascii?Q?pFZQ8sqr4CNuE63y5WbhS8G8ByvDV5lRQ4lsw8+AF0LuJ9qfOCAgQUdEW7RK?=
 =?us-ascii?Q?Pj+5rVDkxjWIpN1kthf7aHZvw3YGtSqEngwC8Bg/jtGeWpmeEZBWkcRLvKik?=
 =?us-ascii?Q?2hLRmrYCeTMf+/hIvD+THa7jnh0qnzcspHmsslZr7tl1QQTcii3LU/eJtl4a?=
 =?us-ascii?Q?vjPKsehISfrgoLGLcQeRw47dPEqBFmQlcJcAiNizjCoBPZFeGk3C/E1EuQG7?=
 =?us-ascii?Q?C1ZWKjs94jGGquRf7XV9eGqvwWmdENPJ8CbBraSJDkouillL2KBJP9qo6UPX?=
 =?us-ascii?Q?qr49aj6GOsrE3MmQ7LVvHRtwIawGZ9qOrfZyEz54qbXTr5HhJBxZS4oN81qt?=
 =?us-ascii?Q?9c30pBdFXuH2tXP9uDXrQL0CaZUiITvYDq1lEULO4m3ZVF6++Hyt01PccVyV?=
 =?us-ascii?Q?WRjUUj0pmqwiMDO306iFNLnNoUxG3QkG6vgqR8CYnupmTTfpsQJVMNXmNFIp?=
 =?us-ascii?Q?KxHNqzM9VRAsm3BE7u+bbpw3WDQLdhQFG8TYE9SQgoGi/wD/z8qrMq6eSJxB?=
 =?us-ascii?Q?JaIefRuplHyiO1Q4AHVADKGK9yXbNoYozKvrrWBap5nW68u34w4eJcVOvF5L?=
 =?us-ascii?Q?5+YT7yzs+v7PC5FAjxM3YEDKlZCxXGy39/bAbhNEX8cPUaqPpHchXBbJSV1z?=
 =?us-ascii?Q?xfgSsKX/KTGe9o1AyYGIevpggLt/WSEBwzpxMy5y2EA+1CtwDTGZ79VxFUv6?=
 =?us-ascii?Q?8nvKyAFRb5zQ5TgwVP0BOVUQ/7DX5RelDzY0gAGa00IjEnsZmocBCUpOzrLm?=
 =?us-ascii?Q?2H9zrcmZl2oQvDasM3+51wULmp7U/9jnM3uroySGI61nRsZG2WLBehoG3TbY?=
 =?us-ascii?Q?YBcmH5+TdE6o3cMslv2ObIzbwLgGct6qUSvdmdMacx2Jl/YZCvgqrWNLMMLf?=
 =?us-ascii?Q?IITsiQoVMTbVHQCZPCxEuqV6wh3ADfVMrQgXHTEr5TGp9prsXE6T+MxriQKr?=
 =?us-ascii?Q?YjbvfYLaNY18oSNfJZSMKbCCI+3Xd6NcPL+eiPDWoM6ibAUA74RDpPgcpRsz?=
 =?us-ascii?Q?zbw9zIuktrVLywuEqb8l7Z4IFODxJ6LIblnHUpJY?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab326bce-f805-4389-e3f5-08dd6145b3c0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 09:10:15.5867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDc+P7DbEgs359ebgYJeMRgF3O2hKQPRPXxMmcVQopFyalaSWZDjDxgisPFYvJ0mNXVvncE0D9fTFZaeFpOKsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB7716
X-Mailman-Approved-At: Wed, 12 Mar 2025 14:01:40 +0100
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

Adding quirk to disable STIG mode since cadence controller has
issue for read/write using the STIG mode. STIG mode is enabled
by default since 2023.04 for small read/write(<8bytes).

Updated STIG mode reading from dev_get_driver_data by assigning
to platdata struct before read quirks variable.

The STIG mode is disabled for normal read case and enabled
for QSPI Jedec ID read/write since it requires STIG read/write.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 drivers/spi/cadence_qspi.c | 29 +++++++++++++++++++++++++----
 drivers/spi/cadence_qspi.h |  7 +++++++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 623904ecda..c2990ac833 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -27,6 +27,9 @@
 #define CQSPI_READ			2
 #define CQSPI_WRITE			3
 
+/* Quirks */
+#define CQSPI_DISABLE_STIG_MODE		BIT(0)
+
 __weak int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 				     const struct spi_mem_op *op)
 {
@@ -217,6 +220,7 @@ static int cadence_spi_probe(struct udevice *bus)
 	priv->tsd2d_ns		= plat->tsd2d_ns;
 	priv->tchsh_ns		= plat->tchsh_ns;
 	priv->tslch_ns		= plat->tslch_ns;
+	priv->quirks		= plat->quirks;
 
 	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE))
 		xilinx_pm_request(PM_REQUEST_NODE, PM_DEV_OSPI,
@@ -307,12 +311,16 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
 		 * which is unsupported on some flash devices during register
 		 * reads, prefer STIG mode for such small reads.
 		 */
-		if (op->data.nbytes <= CQSPI_STIG_DATA_LEN_MAX)
+		if (!op->addr.nbytes ||
+		    (op->data.nbytes <= CQSPI_STIG_DATA_LEN_MAX &&
+		     !(priv->quirks & CQSPI_DISABLE_STIG_MODE)))
 			mode = CQSPI_STIG_READ;
 		else
 			mode = CQSPI_READ;
 	} else {
-		if (op->data.nbytes <= CQSPI_STIG_DATA_LEN_MAX)
+		if (!op->addr.nbytes || !op->data.buf.out ||
+		    (op->data.nbytes <= CQSPI_STIG_DATA_LEN_MAX &&
+		     !(priv->quirks & CQSPI_DISABLE_STIG_MODE)))
 			mode = CQSPI_STIG_WRITE;
 		else
 			mode = CQSPI_WRITE;
@@ -427,6 +435,10 @@ static int cadence_spi_of_to_plat(struct udevice *bus)
 	plat->read_delay = ofnode_read_s32_default(subnode, "cdns,read-delay",
 						   -1);
 
+	const struct cqspi_driver_platdata *drvdata =
+		(struct cqspi_driver_platdata *)dev_get_driver_data(bus);
+	plat->quirks = drvdata->quirks;
+
 	debug("%s: regbase=%p ahbbase=%p max-frequency=%d page-size=%d\n",
 	      __func__, plat->regbase, plat->ahbbase, plat->max_hz,
 	      plat->page_size);
@@ -449,9 +461,18 @@ static const struct dm_spi_ops cadence_spi_ops = {
 	 */
 };
 
+static const struct cqspi_driver_platdata cdns_qspi = {
+	.quirks = CQSPI_DISABLE_STIG_MODE,
+};
+
 static const struct udevice_id cadence_spi_ids[] = {
-	{ .compatible = "cdns,qspi-nor" },
-	{ .compatible = "ti,am654-ospi" },
+	{
+		.compatible = "cdns,qspi-nor",
+		.data = (ulong)&cdns_qspi,
+	},
+	{
+		.compatible = "ti,am654-ospi"
+	},
 	{ }
 };
 
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 1f9125cd23..e6ea9e6c1f 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -220,6 +220,7 @@ struct cadence_spi_plat {
 	u32		tsd2d_ns;
 	u32		tchsh_ns;
 	u32		tslch_ns;
+	u32		quirks;
 
 	bool            is_dma;
 };
@@ -251,6 +252,7 @@ struct cadence_spi_priv {
 	u32		tsd2d_ns;
 	u32		tchsh_ns;
 	u32		tslch_ns;
+	u32		quirks;
 	u8              edge_mode;
 	u8              dll_mode;
 	bool		extra_dummy;
@@ -266,6 +268,11 @@ struct cadence_spi_priv {
 	bool		dtr;
 };
 
+struct cqspi_driver_platdata {
+	u32 hwcaps_mask;
+	u32 quirks;
+};
+
 /* Functions call declaration */
 void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv);
 void cadence_qspi_apb_controller_enable(void *reg_base_addr);
-- 
2.25.1


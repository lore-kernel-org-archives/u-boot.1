Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC43EE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 21:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76A4880250;
	Tue, 17 Dec 2024 22:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="V7OrFRI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24CDB802F2; Tue, 17 Dec 2024 22:36:24 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB917801FB
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 22:36:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4mf9vVNE4RNT3q8UJQYXNF05fyr72o3NAwcn86O7lRLr953pcberYx5HDewiBva/XAziaGzhCjPCwW+fVcRTxKZp2+aunsRxktx1PpxyAdObFyd2x+DqPFoU5mRqQab9J7DEKVyOp/ixwS9bxWw1+A6EylSQCeTtDNRRco2EhW0s9PHMi5nG13tsD65KNtZul0tr+khKnANMF3amZDCZZCI6+IVcJvNDL7CQudLFol8wHWZ0fBAGvCMR9iFJRIKpxG8APNuDLUEXm+WzS++2rHiLZVtDuPmVSpynjaZXbJMSuxXQsxRugN8eIijguWR/mJ6Cp1N4nWriWpn9ka8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWMf7D1NFrLCQ6xFdysx7G4beie8S+vz5tshovka7t8=;
 b=FsUIq8Cc3IB7cMRJ1umIM0Zuq1pQSUn7cWIO2bnOMRH2FSBMqOHIM9AWfmV0407UAYxm1CTRVWVSTXtYkuAmHuLQJbfbfNLsA9GcgxpxlsaBno3QrLkyJRaLPYJ1D2r21eXI+htwOwT1Zlk97TnBoZqvDcxkDDCW0ljUZQEFzYMVP5p2ZqE4g7PY3x2rsPE9vIHbKIGzz9/1A1da/q7OoKj1y6M+Xs6PI9if1E0oVvS7OnvJh+udQHM8Bj6AM+vY7V8WbHd8hcqPTdeJ+XU6W/PslnhCWWQmHhMQqQKYUAahYNXIVVGjowEjI8Zl7vUxp2kWjhPkLaiNBaLnEO44VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWMf7D1NFrLCQ6xFdysx7G4beie8S+vz5tshovka7t8=;
 b=V7OrFRI5C2A1GcdR9xoAv9cdrtv8bwo5YCBxqC9p5e62qXGtrG2rFHaT2FnA/ZXM/W3zysP8FFoHy59ya/fW1C/SetsMzX4DBhfXSzA6zt1pTOzlZuOGJcCWt3MlDY2iPQ+XT9R/Fgsub+jSnucE0ceCamR5IncN2miuprh7PWJ7MnTE4HODDpequ/eaUTvK1Jnbl5AKlekGv30ezu6dbui17XYcHLNDX90pAfJb5/gJG4kDPSgbLAuJ6Yb1XpiP55BCo4wytPUtKsR/V5rHMQxc17L8Ocx+ZjDauAAIfJB5H/1/Pj8QMGtpUOxTlbsOAcPVxNlsWCIs20xot0kOdQ==
Received: from MR2P264CA0006.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:1::18) by
 PARP264MB4991.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3ee::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.13; Tue, 17 Dec 2024 21:36:17 +0000
Received: from MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1:cafe::64) by MR2P264CA0006.outlook.office365.com
 (2603:10a6:500:1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Tue,
 17 Dec 2024 21:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D5A.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Tue, 17 Dec 2024 21:36:17 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 0AC5520229;
 Tue, 17 Dec 2024 22:36:17 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v6 9/9] configs: sandbox: enable mbedtls
Date: Tue, 17 Dec 2024 22:36:13 +0100
Message-Id: <20241217213613.286813-10-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241217213613.286813-1-philippe.reynes@softathome.com>
References: <20241217213613.286813-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D5A:EE_|PARP264MB4991:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6238745e-6ecc-4f46-dddc-08dd1ee2d6eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nQ0f4+JKPjkBW9FDhDisaucu3mMCOoKdghb0LZst3f2hccD8w8OEC//lpNnr?=
 =?us-ascii?Q?urx58XkSbSCSWQBM3hhsSNSlNV5Rb+odGAVT9Htk4wbLWBOYuyijMea8tKdV?=
 =?us-ascii?Q?6jXPJK9IrtC+AW+8Z+jEC8dR4LQgT2//xcCk02wCyZednoVRRoSwc6CKkyx5?=
 =?us-ascii?Q?kIfRFx5/BhrI4QQaftvGvCJ+DPnQsKbK6REUfpSGRrMaqOWR0Lyxr75a/8hy?=
 =?us-ascii?Q?Im7/tSl4RLoIis4cibK2mF5qVUMSqmWvZR9JyoeQsQcpisGHvuxo3jGj/7gV?=
 =?us-ascii?Q?nd7X2UIk0Et16rJSURrfRYUyIAVPABdN6iRktIyQObHU8poYLAQPQF6KEaJv?=
 =?us-ascii?Q?0a9KEc/3M4r1/HB2mgkEOUntI705RAp/8E9HUMx0Gbq9Cy+ORaayW4ntdI+g?=
 =?us-ascii?Q?eDd8oKZzYy7cxBBZxUKe4+dmDh6fduzqQ4GB3OZEqk1iOxmf+gsVdHjE04Fu?=
 =?us-ascii?Q?piG2uZR85zTBejPpIdgkcDqI/s3ZeNZwNBFr58nVuo8j/dfFI6sKk+WRcJHH?=
 =?us-ascii?Q?UhAXGYyiojPzcrhYGV2WeDvHZp9q8YKFVyKutK7lC4Msyex0wYRksiwm1JTf?=
 =?us-ascii?Q?gHL4rFKTzu4tRxI7KsGRgg/8DxMN3jQhR6G2LDwnDNevStTwWkRjjn52y2a+?=
 =?us-ascii?Q?G8b7lw2DIpzPOmp3OVaAd3A7qx83aQNTC0udfGumXutqU6WvgI4Vp/puy6wp?=
 =?us-ascii?Q?Di6Dz0Uu20IfuD8l8IjmjQnZbhGpuZy5n+umo1Qh8ERdqodxBbdJJOav41oU?=
 =?us-ascii?Q?5li2W6buu02GjdIAZuzo4nBB7jFjlhWmZKJUPMMja9hinV43Lq33ANVCfa/H?=
 =?us-ascii?Q?3q3Tu6CdIbbKiNMEG6u5GysDNxmFuwFI0tEhHX1wMVvO72eDmOmyb80leXA7?=
 =?us-ascii?Q?/pihcVOo+vKpIX1DJ6DRswtN/IvFMKdH4FpWFNYQ06DvlZmO6deKbVbM1qpj?=
 =?us-ascii?Q?MHd3jtqMsn8iVS7cZSv4aWYQFk735QTk6CEs+8DOKo92hnPAEeFrZcsvndqz?=
 =?us-ascii?Q?iuihaKxG/BcpG9sMLVC7WwCwyTUBI72O28/JzZfXOd7hGn9Q4PEx9Gya8mHI?=
 =?us-ascii?Q?Hy9Si77aLlvq6toq29qkW7nY0YempW2xQygc944tQv8Wq80mCrSAfYMRU6Lj?=
 =?us-ascii?Q?tzmxoGYVsrdsD/AiotFL49yK5hv1NJQJAobu2ptUrtI+axPSQPKTCCUUOgD2?=
 =?us-ascii?Q?aT3izeskH9PHWhyJfUGvcyi+NiHJj6E8bRmmuD1dRZZFX+erppusnF2cbcxn?=
 =?us-ascii?Q?DQS8m1ZLOO8kU2dOxXEc8kp8g+FmAULtAXqhwmNuAYYG6sk2nYFewM7e3fDP?=
 =?us-ascii?Q?QKmZzoTZuCi6eO6XrH5zIhhQE7th9W2RRM/TrYFNRQ8fDTJ+4oPyjHujOAsr?=
 =?us-ascii?Q?oq/fY/nT33+UHQXSV2647Zmk1BDegnCW/XeosMj2TTYJYmYwR4SgWjoQC0HH?=
 =?us-ascii?Q?zlUThy6EEKdvbgbhLf8VBsIFvrgfQO9WO6imzgw760s456EJllGlw0GrLE6p?=
 =?us-ascii?Q?QeWyT6vDpmgXQFI=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 21:36:17.3077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6238745e-6ecc-4f46-dddc-08dd1ee2d6eb
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB4991
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

Enable mbedtls to have at least one config with
mbedtls enabled.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 configs/sandbox_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 718e4a8283c..1258044241a 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -352,6 +352,8 @@ CONFIG_FS_CRAMFS=y
 CONFIG_ADDR_MAP=y
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_MBEDTLS_LIB=y
+CONFIG_MBEDTLS_LIB_CRYPTO=y
+CONFIG_HKDF_MBEDTLS=y
 CONFIG_ECDSA=y
 CONFIG_ECDSA_VERIFY=y
 CONFIG_TPM=y
-- 
2.25.1


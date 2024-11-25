Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA42ED58D78
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 18:17:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49D5289A63;
	Mon, 25 Nov 2024 19:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="liHg6FcX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0100189A63; Mon, 25 Nov 2024 19:17:06 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFD4289A3E
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 19:17:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hf/BoMAgGUpXB41K9VwFZTVk4/U+n0ztS4qTERZQZ2F9ZTXGrZ83uy7xXdr4Noj6g4zlYnI/DA/FEAw+jh0ry2p8iJEaN11bkxQGQCzQKVqEg+IxswnWJ/wOtUUsbAsd8rAYmnRhmTj2OBsEPnSbPm4bGDdNeeSEfHv/K0Lb+kIRQ+vg67h+W2Oy8tGGKshsY/Y4xlnnl9Ijo22g0rcXsO28Z8CKG0BGfFuJwk6WjrDyDdY2FGOzU6xuGQ+xDa6SkN0G4iLhw2FuB7se15j2+/qHQlsRMtqs3qc4RF1U9cMX7Qit0Fzn1ACg4fhRKXyo2kvoZRAOfzUs9mk50Qru2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5EQyFSUiDZ3SjP8DF9XykUPc8BY1Hqn8ZWurdTyzAw=;
 b=JXEvzZTXHNx2T1c4vfm/+1Wz4XNA/+VDgxJva0pp675wIL2rryCdKqJqcZieZ2uByYndAc0hXFKwaoybdgl2dvXVwkPLAnqn9DWJtuSFA0LFSV0FCUaHBxbhVrQ8hYplVWDb9ni+YaCj+1YQRLX/yGjojul0J5NGCpT7uq+QSliIK26i7fmLVCR00Pzz1QUOPQPBFhaSa7Rhl80R+xLmohZYCswL4hkKdhXBo3nHZIk+nxymi2818/VYCyiSzFXFLEXvK4S8GE4DWnMu585tpHkxLUxDZBVOuLj5e/kB8OxS56YUjco7GnK0lgS9ATNlb91EDUbZ3ucZHDSds9yCPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5EQyFSUiDZ3SjP8DF9XykUPc8BY1Hqn8ZWurdTyzAw=;
 b=liHg6FcXMox90SnJrSttq2mf9EOaR/32kOIH2aiqnBsyTMFR+ykgHnhONmljc9L35d+zlxkkI5cZLkYK748sWkzmYQWR35sk64w+vnLFgW2abXkkuTTIpbJ+lJFKjLhE2y6NXPZE2bsTShbQG3ohI7lWIMxxi2VA1HG7Q3gXANLF4PDgPZO76e0K8WBfOF4VuFlFdDv1Ehf5ZMGDDRLscesXvVPiZUhaCJlyDivZLfn2DW8XhkxoNstVlI0mFupJneNdNH15C9ua+C/HessmIgbogA+UK+1EqBSiuyGeY3LJAZAmQek2QhbwGXG2DRCSEYpf/bMm3XilAfvXosQ8AA==
Received: from PAYP264CA0014.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11e::19)
 by PARP264MB5643.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:4bc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 18:17:01 +0000
Received: from PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11e:cafe::a0) by PAYP264CA0014.outlook.office365.com
 (2603:10a6:102:11e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend Transport; Mon,
 25 Nov 2024 18:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019230.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12
 via Frontend Transport; Mon, 25 Nov 2024 18:17:01 +0000
Received: from sah2lpt245.. (unknown [192.168.72.99])
 by proxy.softathome.com (Postfix) with ESMTPSA id D4F371FDA8;
 Mon, 25 Nov 2024 19:17:00 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 0/2] Allow to append a list of directories in
 u_boot_pylib/tools.py
Date: Mon, 25 Nov 2024 19:16:52 +0100
Message-ID: <20241125181654.1182646-1-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019230:EE_|PARP264MB5643:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d541e908-b10d-45b9-da2a-08dd0d7d5b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hAuQFmDxfd0zWKJDDbjaRulamA/R04Q5Pfj6IRTB5J1Y8mTljXb/s5Gzfzhr?=
 =?us-ascii?Q?3Mw7FWJvsoh09R0rNZhKE5iBfrv4t35fQ9to+spO7SXwMJQbbXNQsxMh2o+J?=
 =?us-ascii?Q?05RUWCwKS6bygsnjKDbIqCksakyog04+JHs5v2w2lZkYrVvuOtoAVFZLENaG?=
 =?us-ascii?Q?wrrVmKU0xjEwU7psy2BUfPoUtSgoR9JN15u1Th1TB3pop9L+fns9qjWwWvOn?=
 =?us-ascii?Q?4FnMwCiuiG717svVrz1fOAMTVn1P+S11pnXYU+WB8b0GjG+EMNC+Cs90OXUf?=
 =?us-ascii?Q?mkNkq4JuujaeXygOptb70egIBZ2YiQsi93XT1Cf3ZPWpsrkuEMEqaTHdYF0c?=
 =?us-ascii?Q?FHxZq0945K9SURHaaI65k3JL6mJ4XoDyt7XhBOD0BGHy8eiBmF9mugFbvEON?=
 =?us-ascii?Q?ojJK/+4E1xlWuIKK/lzOl/aYKSniZEm1G+QeU9v/BDqonG61hGRbRTaYe3EQ?=
 =?us-ascii?Q?LbIeNLQSAfLoqMbHYofVd2nBPJuP+3NXxROdQL4fNihJSZm2BF6UlWeA+dwB?=
 =?us-ascii?Q?F37zIwk9c6czKORDJ0wpgvnJCOnT9V5UaYc3uzmEudVzAgxq9AVGZDP2KBcq?=
 =?us-ascii?Q?mxGCy24AlnLQiFXmrA5vOwyQU/62xVyIoTIAgpxUzJ8lE+YfCeyMXE98MORp?=
 =?us-ascii?Q?Fhe+hOdLYT06kKmNJVLvuG8SMJC+57pWLN169XekZT9zZ4iDkIuGqKiJQ92T?=
 =?us-ascii?Q?lix6HL8j22ESFHzdzQh5IjlhwWTNiEm0x20WcNvtNlW+iTDIrk18zb8ZgcIR?=
 =?us-ascii?Q?TbZUof0qjSw8+KB5v5PiKn+FqNdb3HQz0GR7/3XBqlKn1zIcKdlp99YsKZuO?=
 =?us-ascii?Q?RcUYSflaR1vJtQSaItlfXTzBYKoq3yQS3uZal7fSOk+nHNTIeTdpwiwvxFok?=
 =?us-ascii?Q?96op/78H1YL12D9/Mcsc7jl9Bbd54E1bkbpxVSm/sokSzq/Ul/7wL8/1uthP?=
 =?us-ascii?Q?yY2o/Ac4tVefp9lYhFeXTmzN1VTWvoq0pbqD6H0xowkvikGHqc8P2LHupCPc?=
 =?us-ascii?Q?rT1N4qqGXtHeYVyzNB7lkrpHvQ03tQNaP/RwaSGZ3C0pxupQboFJEeNu+2Fj?=
 =?us-ascii?Q?sD50Q0niZKbXI+eIJnqQNw4sHCGxR8R3t+KQA0eaUBySMVOAUVaUkUlG5/yw?=
 =?us-ascii?Q?KZ8xbDCPjABrV1VLX7bF59apZ37SscMuiefj2V5nYo7aWFeOZifz2IDPPdwU?=
 =?us-ascii?Q?m5UEvdVsEjLUx15JxPUcWNjcPE52xAywV+VVsnnpZgl1NKd4GhMdCo/BBlGb?=
 =?us-ascii?Q?Z2xkwYn+BZ5OLC26lvMRUSrPECxCqZ9oFN0efBq05K2uftXLwFPOX2kiixMK?=
 =?us-ascii?Q?7RBRtCi9nNmrG6ks4P6mFplO+K+HMkiOpBeb+cEp4rLQflf8rd/IzrI7XOZI?=
 =?us-ascii?Q?7dlo96+XgBdEsW7tCPzFzQigOWUNYrwp43cl48c8a3zuB7MAuHywpFnSR23S?=
 =?us-ascii?Q?FuTug5vDmMHc1EpK/6jm0fhGTS9g5N5H?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 18:17:01.2427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d541e908-b10d-45b9-da2a-08dd0d7d5b71
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB5643
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

The idea here is not to have to pass twice the FDT directory, i.e. once with the
'fit,fdt-list-dir' property in the device tree passed to binman and in the input
arguments of binman with '-I' option.
The method append_input_dirs() can be used to append a list of directories to
the existing list of input directories. The method avoids duplicates and the
method ReadNode() of the class Entry_fit calls tools.append_input_dirs() to add
the FDT directory to the list of input directories.

Paul HENRYS (2):
  tools: u_boot_pylib: Allow to append input directories to indir
  tools: binman: etype: fit: Append DTB directory to the list of input
    directories

 tools/binman/etype/fit.py   |  2 ++
 tools/binman/ftest.py       |  5 ++++-
 tools/u_boot_pylib/tools.py | 16 ++++++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58CEC9EC88
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:11:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5068883A8F;
	Mon, 12 Jan 2026 14:09:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="orliZAhM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24E1983D52; Mon, 12 Jan 2026 10:38:11 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE03583CB9
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fdn9Ct84Qnz44gSCvUT55xdFHlZ23NWrmgAK90o+Xl6xKOY7TS5SM+UWz1V3/oPG0GDDPk7+0ZCgiufXENjVuk/ITqj+TVgoU+HptDqX+3gmQiNznzqUVUmlxd+f73Np54C4sg+MzFHCBxwjAU8iDXVqXwwZq7GBmPYatn09GH4kArOEAXtUNTLgHBUxxpsTDk29acmK9nhIwzS/fPHUTY407C7IZbEx/IQTsrpmqe/nlLXQE1o49S4L0JZNc4k8lDVYKJx41JoL7LpltFrKrMWbyomi0IbxaIm1lgBx6w/g1SFdokxAaHxlUQTkoV/NbWPuDwjrtrwWSJvd3i8TLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSTUhkAe96WDi7HnGnscqHxB0h0UN/ug+bFpE4wzhuM=;
 b=INJQsbXoY3VaiXmUGJlpYH3YW6VRApozavCg7bzPtr7+v0M9rsuDvq6ak8oXM94Y4k7yWgp67qYey0hGBBAO54cPiM5/3rXxCrM8DLflusiCEKPljWFPiKFSXuF2fORkQ7q0CfiOhmLGAGeeBU7y9F7XYOkLVNXrDOhE70DPWt/QNKj5TrvWBgyAAYrVFAv0cxsACDp25rX/YnBmbGW3IiQbZ+QGqfAqLV6JNp5fbAwTzU8SL6oJ3PJsUhDfkiqhUy/L9/tuYVqZCuMJfbKVXVxQdRf0MswBMhrXPhlSwzGeiFNH7qfMfd4C1yMbmovexaiPpaOhrjjTtjyYR9MefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSTUhkAe96WDi7HnGnscqHxB0h0UN/ug+bFpE4wzhuM=;
 b=orliZAhMf7GJKRsGlWLP9GOYltLd1yBKM/bZmNBxcJVrCkETfkWkGxlAY0jEP7B0DYkdITv2GMHzY43jbyKIg8/QvMBrMxZTLk+agi/Ad+FLHinHQM1hWXauantEih69IVJ/k2uucTvQgiWFEYPgaeYUlRzO2w+hql2umpbntko=
Received: from SN7PR04CA0230.namprd04.prod.outlook.com (2603:10b6:806:127::25)
 by BLAPR10MB4899.namprd10.prod.outlook.com (2603:10b6:208:323::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:38:06 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::a9) by SN7PR04CA0230.outlook.office365.com
 (2603:10b6:806:127::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 09:38:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 09:38:04 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 03:38:01 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 03:38:01 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 03:38:01 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60C9bxUs155710;
 Mon, 12 Jan 2026 03:38:00 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>
Subject: [PATCH 0/5] Firewall ATF and OP-TEE memory regions in Sitara
Date: Mon, 12 Jan 2026 15:06:38 +0530
Message-ID: <20260112093643.885903-1-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|BLAPR10MB4899:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a829978-01aa-4dbf-3fe1-08de51be4967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|34020700016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WfrBGZob3iYDYHmTUY/ShH5rhhzPbcSiH1kHDpAIs3Gea2twwqb9QDXNUuFf?=
 =?us-ascii?Q?pqqqDFGGoGc/08TFPFgQ4VGdxxvmtkCtjruYcW/D2mB16OPt+Ms/PScnRbSO?=
 =?us-ascii?Q?/EmE0MYJM3JKrco310j9kvVOfa96j/cTSw96ycxXZF2rxGNYTvrNBOjdW5Lg?=
 =?us-ascii?Q?Riq5CzYnz7mhFnhxNILy4c9thmrt1WDbH3CmsRBDNTyeZPIFtX5kTXxPxlKs?=
 =?us-ascii?Q?asLgq5FmpWscV45P3ASWvDNHuA7q2wjKdl8speqApFhEgYLnV+JiQ9vipaBa?=
 =?us-ascii?Q?K5gshC2F66dlXvlSZq73TXFVk8te22V9x/iMLA/cG1xNbGcm+Uh5mZ1OZaXs?=
 =?us-ascii?Q?2EQ7g4qLlwqV4VfjvRlOpZpuNi4UyZeR9PcfxUXFlA9cl7O46ZnfXvbicNgx?=
 =?us-ascii?Q?2OR4LacZ/UG9KTFRKeDCdkoCQLCbo0SO8ilf19eIVjiXPVwN6EsltIvYR6x8?=
 =?us-ascii?Q?PeZ4Rw58i2Uh3Nz+S5+X3VRZ2ZTQ0xjYQ9XC1ay8bcsIznLZUn9hlGtGew8P?=
 =?us-ascii?Q?sKbKMly4iowJa56CnfHNTCqF/KyThI/2jmCKwRP4gQIgdsxnoBhWK1fRXiCx?=
 =?us-ascii?Q?QUqtdadSGyCBrgO0oomCJGhXq6PeQ3OmhG1bj1LGdecxzSmBFP9FjuMMEF2o?=
 =?us-ascii?Q?mvP9lZ6hs1O1YLaEk2a+AfpT2qS7Dgv7llZCkKD0jGZYIYMxC/BN/PKntaf9?=
 =?us-ascii?Q?dQksJVHKqxsrZKCpplLCS8I+fuJzsHOp9Jo99Gu5rzZh7Idr88m7K81Ma//l?=
 =?us-ascii?Q?wQUIheZ0R4nIPmpJjStKuhvysMkmHidE2k5MTBrncreq8wQBKlZDIQVWcpKn?=
 =?us-ascii?Q?qXSkF2X695Ladxe7Sw4skwspG8GwNDvHzTjPOpZdpVPdbfWxBIOECtVbkO2q?=
 =?us-ascii?Q?tvizoC+SdJt4M7gbW+QAl2SJe3JuwtCHPxOHvdBwumPnvkJ0vFe/m5rhsZxa?=
 =?us-ascii?Q?I5DHf3PmfvBUycFfVGHHCBM4l2lqG5ms4M26xP2E8Y4ar+aoFHvjV8DbrrhS?=
 =?us-ascii?Q?WWnHyJzkN64ygbVQ+OWM/iMyoNvsXYo+kNADNuHstgD6I57Y+1aDicoGovR2?=
 =?us-ascii?Q?Y2hz4ioBDHt2Kudyw2xivAlrPx/l+VG3EJMCqEL3fgia+KL8eOcj8Q0Xk9o6?=
 =?us-ascii?Q?EZIrSGsoj2Wy4QkyvC7lSUduMOSB9Vg9NxYhzPBZGQJOHkTrQqtrbBVBrl2F?=
 =?us-ascii?Q?4FgH3QosxgKEbjvGj3AQO62+maLZxO49dMDhvnH6sfpLJOIg1Hs7e/6UD8TN?=
 =?us-ascii?Q?X9Tg6T5zOLFuzwHGJoMJ+pvD/gdbDmey7jcTae83avUzOAVWjtcWiKUE0HCN?=
 =?us-ascii?Q?4JZTqn0RcNv27v1fPH/X/065psNyDrtnB4lgcGfZN+0TX5hmjoECwLdEsG31?=
 =?us-ascii?Q?xiT7bGYfdQgJDK776roE10KPtu5xThzU5GCu5EIILwiO2aQ7ce83G00/BlkH?=
 =?us-ascii?Q?w0obSJry/qOdwghj4k+t2vhfuN4lv5lstG/mbgHNWhGGbMgjGYXBmqgBOu8D?=
 =?us-ascii?Q?KBM+FWExFvqq+XxqNHkJdNpx6JXNL5BNOCTIfdudAZC44OTAemqe4yFz49CT?=
 =?us-ascii?Q?Ie+4DuCgggetV+FDWd8=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:38:04.9614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a829978-01aa-4dbf-3fe1-08de51be4967
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4899
X-Mailman-Approved-At: Mon, 12 Jan 2026 14:09:41 +0100
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

This series starts by replacing the hard-coded addresses in firewall templates that are defined in
k3-binman.dtsi, by Kconfigs. Using Kconfigs would make it easier for someone to move ATF and OP-TEE
to another location, since they wouldn't have to fiddle with the firewall configs in the dtsi files.

The rest of the commits in this series add firewall configs to each device's dtsi file.

To test this, I used `k3conf read|write <atf and optee address> <val>`. These operations were
disallowed when the patches of this series were applied, expectedly.

Suhaas Joshi (5):
  arm: dts: k3-binman: Use configs for ATF/OPTEE addresses
  arm: dts: k3-am625-binman: Configure firewall for ATF/OPTEE
  arm: dts: k3-am62p-binman: Configure firewall for ATF/OPTEE
  arm: dts: k3-am62a-binman: Configure firewall for ATF/OPTEE
  arm: dts: k3-am64x-binman: Configure firewall for ATF/OPTEE

 arch/arm/dts/k3-am625-sk-binman.dtsi | 30 +++++++++++++++++++++++++
 arch/arm/dts/k3-am62a-sk-binman.dtsi | 30 +++++++++++++++++++++++++
 arch/arm/dts/k3-am62p-sk-binman.dtsi | 33 ++++++++++++++++++++++++++++
 arch/arm/dts/k3-am64x-binman.dtsi    | 31 ++++++++++++++++++++++++++
 arch/arm/dts/k3-binman.dtsi          |  8 +++----
 5 files changed, 128 insertions(+), 4 deletions(-)

-- 
2.34.1


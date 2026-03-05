Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCB6EEF30C
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 06:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8507983F8F;
	Thu,  5 Mar 2026 07:41:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BgjNCDzx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE36D83F93; Thu,  5 Mar 2026 07:41:04 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C21B083EDF
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 07:41:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIW301M90qCKik4YJnIhdL4yRhmLU4q6hpak11VnnDa6d0DPDMeTOJpH6tF6brDmVnVSxVmgn7NII5ir9PlYNCeCL7zk6Mid164AR5R5Vj4gJui4VeWOPYA2HwTzMY03zo3upWzJqxzdsmg9b8KRbORhJhnFN9KO+grWCvSrxEmgB7nFcuS6ONKdYAEsTIVYyI0eSCjccRMoTu2Si5q5xg9JLiHZTr9Q7SJxCI6foeUeq5Qya+xLkH+cVQ7yFnTd6Ejy4pqjaQuyTjLbjC2m3NnjfjvALGKSl3iS2t2zjG4Li0wbodJYLS1GH96TLoRz2N4/GYxBhGhnu0anvtY60g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BiDP8K4UvOcZg7XaJ94hIgzbQ0eFsnCfDOYSy+t1bk=;
 b=YkNGuYZgx9kGCcdGsOIEsQ1TxnaaoeJx8SEfqMWfCH+323s1eoy5xy+WQMf3UuLwr5aDwwjAVvR1ah0R59wdbYEvhj/df/2lOI/95Cjw4ukEneRPYQpuQWt3exeDEzQejCqaGE2maG+q8dFioHDPTJ3Q/dz6ugrPhY7fEcd74k9nddfC6umZSu1sjyeU+aTJ8Y5cHtWWCA++/G+mOzHaAtP6BVQbYsxN7vX+xLrqhGMdwrvElAdEqTUI9uFg3CTqRw8rt5Ngz0itt2qgoM5HEZ7lubQPmHZ4bv4K1Fo7F/lSdnt7OdrghB2Cm58RdXLwW2Rg2mSUpq5oLH8HumttXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BiDP8K4UvOcZg7XaJ94hIgzbQ0eFsnCfDOYSy+t1bk=;
 b=BgjNCDzxuJtScrKIHNzZh2qH4MaIumRAF1K2ZxqRptiaBpyuIbRZIZuu2eNrc0j36YJyMeQ5Sl6Mtwy4+5qEjHomEuEF0mQP2FcvmS8ixwuqdiN41ZJWlT9K3OyekqqQ6jfT6OuWQwC8vM60F/obuov18zgw/7SyEZc1Zhh4H14=
Received: from BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 06:40:56 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::91) by BL0PR02CA0124.outlook.office365.com
 (2603:10b6:208:35::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 06:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 06:40:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 5 Mar
 2026 00:40:55 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Mar
 2026 00:40:54 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 5 Mar 2026 00:40:47 -0600
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, <Pranav.VinayTilak@amd.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: lwip: scale buffer pool size with TFTP block size
Date: Thu, 5 Mar 2026 12:10:11 +0530
Message-ID: <20260305064033.8726-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd4aa1e-3fe1-4cc3-0f47-08de7a82277a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016; 
X-Microsoft-Antispam-Message-Info: HdB2LG01wnwt9u0pdaVjAwjeB8kZxmMU08/L2/68NA90z79rxDLu9UiG8y5AIaKDwYB4cO004hm6gSXHycUIsot1xlgmRtdAubzmDJkqp+Us4ch8+DR4kEKPlvGiz3b+KOBkSc1PXysd7m1t217OunIH0ARlESANqj1dt5shGhcJBTX8VeZPQfcuk8o2mwSRzYOcPBLNe+/XIoFPiws65lEorQONQFHBo5k5k0EYOVt6a1McUzo9wDWex5Znv1F36FpbOafbq6JDL/lDbONhdPTzkeRE3kbUQ8ZVmdj8JVejv4Sio4xAQr3AbWeAPGisV4PRaFu8ZGPf8vXrA9OSujnaoRKHCbA1kW/SmqRKl0FvEHbBs0veH12rbRj6s0Dpwbjc841vUoUwHF5H+DFCRbKsyfRKhaY5+kA2JrLfYxLshr03ji8RfGR0lTOlBVxkj7il8zSfQ+1lkRc59ozzTv1MEERWHkWrYh+o8g8miTzXajdZ6Y0Il9tR/zTZqdPIM1alA5o7GhVMCqb7M0ds/5hdpQmli4a6Ww1yzY4axU4bW7LMYg8CDF8FPbFvjagVYWu3ukeEMkrSt8+8foDKkV5DdDKkigD0uY4C5Oobikw6OY45KuZusKYqVBCcX06oDFjqit6QQ2JCL+uF6peSCX82Wb+sn/gHQiY3LnyHcdr4Dg2k+OehKgZuOZ/O1h8e4wsU8TkQ2laSZvOds+SGh8JIFfQADnublS2bEbbS93eqsk/I3untsVFVY4xE9RaHyH0BQFonFn/u7VaufXGxEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RPZ7NbtkBmyRY/KNFpPJO6zguZOwFd4XFeYG7xWg72qW/ScqCGY8jy70YyuiAYgL2xVNoa6W24Hnat5ngXbnOjDSlZrgw5g+XkjV2H3YY8hohZ48JEtHIpW9gIh1nr5FQIWJAFMPdhBWWrivf/usd0B73m/oBUpbmyRvkHoqaZzAQCQIiwLMubLFVP0bLCGpzTrAHeiDyMfAQ7nFR37L8Xd1otTkS0yX1ha31+CuRJ/4lTlz5bgd91rAnsCL6Xd1a3eNYbLk2ZkrWvuuDrumjG9KpnvzP9C7ocHwriZILPj82CXMmj0TBV3gx9awPF4KGLY6cTQ6PZ56B/5DQ2kKTyZUlvUEDF+vvZ08MY7jt2b77iyt1k9T97NimjKByu2F1cSwkVb9ItqTxrf7T1xr8za/buTv9Gmg0UdWkcGdjo1MjgqeuCw9ecFe4M03eL3c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 06:40:55.9400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd4aa1e-3fe1-4cc3-0f47-08de7a82277a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601
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

TFTP transfers fail when tftpblocksize is set to 8192 or larger due to
insufficient buffer resources for IP fragment reassembly.

Adjust PBUF_POOL_SIZE and IP_REASS_MAX_PBUFS based on
CONFIG_TFTP_BLOCKSIZE to support larger TFTP transfers
while keeping memory usage efficient.

- CONFIG_TFTP_BLOCKSIZE >= 12288:PBUF_POOL_SIZE=18, IP_REASS_MAX_PBUFS=12

- CONFIG_TFTP_BLOCKSIZE >= 8192:PBUF_POOL_SIZE=12, IP_REASS_MAX_PBUFS=6

- CONFIG_TFTP_BLOCKSIZE undefined: PBUF_POOL_SIZE=8, IP_REASS_MAX_PBUFS=4

Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 lib/lwip/u-boot/lwipopts.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
index e8a2c9d7a0a..b4ff31096fe 100644
--- a/lib/lwip/u-boot/lwipopts.h
+++ b/lib/lwip/u-boot/lwipopts.h
@@ -65,7 +65,14 @@
 #define MEM_ALIGNMENT                   8
 
 #define MEMP_NUM_TCP_SEG                16
+
+#if defined(CONFIG_TFTP_BLOCKSIZE) && CONFIG_TFTP_BLOCKSIZE >= 12288
+#define PBUF_POOL_SIZE                  18
+#elif defined(CONFIG_TFTP_BLOCKSIZE) && CONFIG_TFTP_BLOCKSIZE >= 8192
+#define PBUF_POOL_SIZE                  12
+#else
 #define PBUF_POOL_SIZE                  8
+#endif
 
 #define LWIP_ARP                        1
 #define ARP_TABLE_SIZE                  4
@@ -76,7 +83,15 @@
 #define IP_REASSEMBLY                   1
 #define IP_FRAG                         1
 #define IP_REASS_MAXAGE                 3
+
+#if defined(CONFIG_TFTP_BLOCKSIZE) && CONFIG_TFTP_BLOCKSIZE >= 12288
+#define IP_REASS_MAX_PBUFS              12
+#elif defined(CONFIG_TFTP_BLOCKSIZE) && CONFIG_TFTP_BLOCKSIZE >= 8192
+#define IP_REASS_MAX_PBUFS              6
+#else
 #define IP_REASS_MAX_PBUFS              4
+#endif
+
 #define IP_FRAG_USES_STATIC_BUF         0
 
 #define IP_DEFAULT_TTL                  255
-- 
2.34.1


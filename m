Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BABBFD2D73
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 12:59:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABE9883F2A;
	Tue, 10 Mar 2026 13:59:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fTDaf/YU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F35BF83FDC; Tue, 10 Mar 2026 13:59:25 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CB6283981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 13:59:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xe5Xf/zGxi76avsbCwLhBxV6L1oneBiOIHjSi6rGdGjkWxP8fOVClK++hpfLB4WII5uqPGccJkE0WtfQR3zlI4gcc7CMZeDTV2cJqc/GYvpt0RHxMgnjLt7bdNuOoB1tavGE6bXdry7pLfiT9Iiallj/chU2aACOQLymRoBu4pZd+OUVjdgz1CqTGq0ndVaH8Yu59OVWSwS+Zvqx6ORHb/mvJUYoP3RbFv1ZnOjJ9IpMIKUrR4HMIPJeasNm7c7k6dcI5L18qWWMrPAqpnBZrK6oJEIyjtnhehy8qnv7rwOP8o1OXq5bdlOpTsZmXbCKt9RfnUbyWJ8YESnGRrLuJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+kpKq+uJDaq4MRQqZTdV+DU+5ZT1HmtiI5AFRhPl9g=;
 b=pkzsqz5ZrQWlr6NOMI9rpv8PvtuJVwC0eZhoA2GgXxLZF9WaOy8BgDudRPu9OQ4tBrH+QIxQGMJ7MZnP/+rcvkrT2/86Et75KQS/IJ5fAxtBTKLqEA9Zwn8WBhix+yF8Pu9FWQzRgAWhaROjJWtjHxEYy9o+cVNt8YyC5mAkwfZ0MzYh1J4CdcYUAWodOU1jbDKk5hkemJEw0VvBMlLi7Iuf/P/OTE62QaAOSJ0zoc2WnQvuP+iuTdO6bgnsQwWoCBCw0P6zCoscW3UHyFRmU3JbbX/wc0XCupoziptdquAYlEfcBRB6UyOJOnocfcUAVvm4/daKDZ3CymmBDFavCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+kpKq+uJDaq4MRQqZTdV+DU+5ZT1HmtiI5AFRhPl9g=;
 b=fTDaf/YUX9DCDMwVoc/fyYILDavTYAZiSIX6pIqdrGH16upudlP+3ZSWc68QKah0x/9OAtuwE1S1qUlMIJ2JVoQIGypKEzWlHV4LHzQsqjvuNHuWSap5g9hAXLP97Yet4hunx0A9STBQwkF4NeIl/BLuI7Nkzq+TVV+0xhO7JrA=
Received: from CH2PR04CA0020.namprd04.prod.outlook.com (2603:10b6:610:52::30)
 by LV9PR12MB9830.namprd12.prod.outlook.com (2603:10b6:408:2ec::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 12:59:20 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::23) by CH2PR04CA0020.outlook.office365.com
 (2603:10b6:610:52::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 12:59:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 12:59:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 10 Mar
 2026 07:59:19 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Mar
 2026 07:59:17 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 07:59:15 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <jonas@kwiboo.se>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] net: lwip: scale buffer pool size with TFTP block size
Date: Tue, 10 Mar 2026 18:28:25 +0530
Message-ID: <20260310125846.413956-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: pranav.vinaytilak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|LV9PR12MB9830:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe156bc-9d7c-4123-39de-08de7ea4d81b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: pe7ohVxP9QSs0xIqhNr4bm01RWcJoGjbpN3EWatbF8MHGFUnNkvRNDiDJXCzpLvhbdCAVG+PrWgQURJefjmzPoa8M45JNVSv8LJ3O1+QaFM8SH7PZyS9P5jdmMIw8WB9+UVXmkFPKXL3t8YtqYS3j/QMyf07oihmbf+OvqSWqaf4YEupt/zlbU8Enqvevq9fOSJQx9mFbrSOe5O4cYIpnC8+fHNK7hhhlXBHoGFA6loZ819id/dRs9m5TtCTlWpFeO8Hch16OFys3ednRzBCbVGTE7JEaJx6H4D+vP7BaJYxJLGsgoHg4cJ7hNQ/qrvdEfm8Em4hpvMKSLxg6EhZYwZfjMIZIyna++SXDjh+1OF5SytHqYMWLVVR2lIzqbAJTqilJ48BrGf17kk4Z5i7AHIoyL+vHFumC2o9tr5yd+ZEayzkX5CbcG/ppKBhK/9aNjoTz00SyhO4ruwCoEQgrlJY5XGxojccdDa2dD8JWgr6DomhWQ8qtyTpIDPNcRv/jXRtY9DVKycg90eAc96hDjyreDGpWygA09Th4RVDiv9WSAxjqIyplIdIxmpU4inbKebUNNqreqWgeaJcrc8iqUHWeiRtJuVHtE2VMswCHPiyJMfLUSQyZtTETQi0b6OVy7pXkugib350rVH9WFm6F6G4F7c4MqcglypCze3JS5TT+osWWVi/SexiGWg1hYdvgPsIRPKDfhhpf8PvgUEh1n0v7e6sOFay/P0yJynkvZUWEVblX3i6CfSshHm/PdXtblYK5UALtzgatjQyUXUCHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fyVP0rgLfCDI5C8HRXuUBO6nXzcryXeRiBGe/Ftnp2oprQ2WDNrUn9q3itdrcpNHhr+++mfHIV38OdEBarlN9wLYWSLq2EYH7F4Rv+V1LEo9sGHcFXT9OCE8LUAMiHKQgti8aA7gFz1ByCwNqS1HZjHTPYeaLkAku5VLOCW4rpgfH/xIYV+qRw97Zd14r8TJMbGz+hZZZ+VlqAmEZ4xxNhEfuGYGYAcf3CX57GIsnzHoy/nOAdr36odh+XStNdd3HuxvaOGJj3L3WIS4LSdNISc+c+VpY7JQ/OL3OQeqbDx+KF8lSksqmKHj/XmCc/yFcQSJNhrSwWHgMrxJt+4bHO20XD/xob2NelOrsoPVWIGs6ZdqndowmdI/rm5inDQ+czRrzjmHg8pLgc+pp/IaclBLHZun4oYZXcyVfOoSIv0woxqGR27dCLWHH7yA5/Oc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 12:59:19.7986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe156bc-9d7c-4123-39de-08de7ea4d81b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9830
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

Calculate PBUF_POOL_SIZE and IP_REASS_MAX_PBUFS dynamically based on
CONFIG_TFTP_BLOCKSIZE using IP fragmentation boundaries (1480 usable
bytes per fragment at 1500 MTU). The pool size includes headroom for
TX, ARP, and protocol overhead, while ensuring PBUF_POOL_SIZE remains
greater than IP_REASS_MAX_PBUFS as required by lwIP.

Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 lib/lwip/u-boot/lwipopts.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
index e8a2c9d7a0a..4a1f8086673 100644
--- a/lib/lwip/u-boot/lwipopts.h
+++ b/lib/lwip/u-boot/lwipopts.h
@@ -65,7 +65,21 @@
 #define MEM_ALIGNMENT                   8
 
 #define MEMP_NUM_TCP_SEG                16
+
+/* IP fragmentation parameters for TFTP reassembly */
+#define IP_FRAG_MTU_USABLE              1480
+#define PBUF_POOL_HEADROOM              6
+#define PBUF_POOL_RESERVE               4
+#define TFTP_BLOCKSIZE_THRESHOLD        4096
+
+#if defined(CONFIG_TFTP_BLOCKSIZE) && (CONFIG_TFTP_BLOCKSIZE > TFTP_BLOCKSIZE_THRESHOLD)
+#define PBUF_POOL_SIZE			(((CONFIG_TFTP_BLOCKSIZE + (IP_FRAG_MTU_USABLE - 1)) / \
+					  IP_FRAG_MTU_USABLE) + PBUF_POOL_HEADROOM)
+#define IP_REASS_MAX_PBUFS		(PBUF_POOL_SIZE - PBUF_POOL_RESERVE)
+#else
 #define PBUF_POOL_SIZE                  8
+#define IP_REASS_MAX_PBUFS              4
+#endif
 
 #define LWIP_ARP                        1
 #define ARP_TABLE_SIZE                  4
@@ -76,7 +90,7 @@
 #define IP_REASSEMBLY                   1
 #define IP_FRAG                         1
 #define IP_REASS_MAXAGE                 3
-#define IP_REASS_MAX_PBUFS              4
+
 #define IP_FRAG_USES_STATIC_BUF         0
 
 #define IP_DEFAULT_TTL                  255
-- 
2.34.1


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60CFC56201
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 10:34:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4658E40780;
	Wed,  5 Aug 2026 10:34:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YEQCHb88G76r; Wed,  5 Aug 2026 10:34:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30B1A406CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785926091;
	bh=9qhP4jsj2329FunKkYG7pIZBPAAakULngZWFUxb/qJo=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nzuTu6rKOhDS2WNdt7MshfwOXBvvY27wiS4wz0joc32Ms5Kt4+6dzEkn4jDZVsU0i
	 L01o68vJ3T6ZUH16Mput+1J3bKJHh+DDCy8QUDWKNdxhZuS99CPNfXSzI8Qkd1KB6e
	 VrxH2WseGRKeeQgvb7cL0axc5Sa7o1Kw0ZgNNjlv7YIdJwcfIAFK2MqVdzKMBnvkB4
	 BGIVxpnTxEtUbDIPhkCSt2EvsuOQhjdPfi+ywddNMY3kjt/dD5pKFitie+eS0uymNx
	 4wkW0oIpdXe01J3II36LCtH1gvkKWC10ysQy9/szPvIA9GhMfd6mN4+fLWrFOQEd14
	 mTCkFSZNRUJvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30B1A406CA;
	Wed,  5 Aug 2026 10:34:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 899072B6
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 10:34:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 870FC606FD
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 10:34:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H0JrcPq_UNnL for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 10:34:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::1;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 67B8960652
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 67B8960652
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 67B8960652
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 10:34:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJotG4PQgBf4FfmoKhs49ec7j/fSd6a53Bp5m3RX9qTVjeGILROkptWa5SQD1wZgVrIZRz2fMsMm6Ia3WwMC1XwQQJgRVqFW5/EQWOk+piWMHOVond+mjKxuIbLQMyQTi/rqoepIbkG6lkuTkK3hmA+K20C2F51aaNLIGtqbBW1PZdwi1/CpWbdePjuDDaB+l0XuO3qulHukaA+DPO9qSvoyQ0xoYj2dk+ZYbhWWQew3zVFxZ1ZLz3hhxqCpFIDaq5NYEADiA77Hy5OsGAjk6jG+JEf4xGp9ZAe7lzErpHD+OywLHaDcg3MHE94tvFv3Vng90vD521IsqlRGArFvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qhP4jsj2329FunKkYG7pIZBPAAakULngZWFUxb/qJo=;
 b=pMAWOvTGyUYjJExlZqyQLUsE+zqgyHoWyZJaYB7Z55ihJ9uTEEnIgvUtZ6n1J9A7qpD2W5qC3zN3DnMYhPQMZhMv3XJQ7jaEmjAhrLIG6vspFBmk0QSBiwSwFrwAVaolRnu4u2QtO1RBw1b7ndu7L0T4/N9VQfKtocWH3ExWqjULCDztY1aJdQtmw9wv+Pb2kMs4KQeyMXqk19vutCshIcqdR1O4Ia6d0gAwgtxq0rif1vhI4rQWbmqiSimGkQafSTQ7fy2TrIe2DID6s1BJ/YzAH1BdWqIsNeFk+CzaEKxiesTfrBmYbio626O0eZMFwhFm0GQpiLCd1byLoz9ReQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from CH0PR03CA0403.namprd03.prod.outlook.com (2603:10b6:610:11b::13)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 10:34:40 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::2) by CH0PR03CA0403.outlook.office365.com
 (2603:10b6:610:11b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.19 via Frontend Transport; Wed, 5
 Aug 2026 10:34:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 10:34:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 05:34:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 05:34:38 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Wed, 5 Aug 2026 05:34:36 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>
Subject: [PATCH] net: lwip: fix TFTP blocksize threshold check
Date: Wed, 5 Aug 2026 16:03:57 +0530
Message-ID: <20260805103429.3142222-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|BY5PR12MB4211:EE_
X-MS-Office365-Filtering-Correlation-Id: 540f15b3-8a46-49b2-b53d-08def2dd2791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|10067099003|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: a0+LzLej4+XfjoJ98cxewFRPU5FBp3HosB4FbVkgTtHC7Ywx/0MzB8CINk2y0S4rfJhtFeU2FDSEYj8MhuMUFuaq90/qL7s/+YKLoYT13uoDVC+FuDSRULdJPRn4a7fL45SeDyG8FwxfMxHMbE9+2MEHFVUTkDYMxc+mSB4hdHQHfExJjm17CRnV4VkS9PjPB0+Ny25aTYlb0qXyCKqYpbkHE6rzuy7A6g7qK8UnpnFFZ5bC+7S9rYbE65Z1fXsurTCvLA9viYXrU6vmcZdWxQQSsauhgDvofgcQpcMLNo9USZz5+C+fIdxYJQM+DDWWUOdW3Br/mGRZJ1UUHNshDtty9gVSgnlClTp8lrpOO3PqjpzyLcdA9aRqMKXuKgw1rrlu0FAiwwR7lzHjnjUGOVoMc0odkQt00I5WjrdFIG7u4eg81dIl32GHyPx3vqbe0Mqm4NbeFrpIZbWn/936BFcC9D0oKvQsol76lrBXaBZipkykTcc+mpxwCMt4I7u8wga2eaVQgsUXY4Hz1OzzU0RGc2TB66qqt86zMnT641snScpbf7OMZ043UbkHAYfZvdQRRah5V7updbYvbxPDECCAi1oQTQHjWUu7HcKz8W6ddxvmhY8CYz+fI59WUgWJBQvfhUnrjBzMSiFgq0/JLEeM4bE66K7r8M7eGJWH74V3ANvCUlVktTZCrHHE47BQ7SeSnhx2FR6fD4eHMScwKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uQ6hBzlWlxV2ymgxxRWo6YtRPTr/4r1+IkoQgkECtqtD1xT2tO5hO/1BvJSi//0ZMH4yrpykIPsQlBTd17SOalFm/L6Evvzv8IYHFnOfWhWAjdf5W0W/gQ7Tf+TlV+KEulCOwyhqqu4d2jlUZ4/FXYQuy/bu0LR+VL5cDuSwcIK2eJkZQWwFCkFiA2+AVDr2q0HzqJO9CZ7U4vZ0uznMq7PfONcpptnKDASLKJwlbq29+rbykWUDw73OH9ml3Af7c2XgAVo6CxvheLd2trCxX6Qw3yO6fwuLJgUCFKOa2X+iPAcCtMPiWcLKEKLj8WaDaLDYKN1Wh8hPrzHrwMK7oLOjPptakPWFCPZvKOtbjwSke5rRQkp6zV5ux2jHvp8CyNo0Ex2CPeSVasE7kckFAkNrFGStIkWn4p+BO4dulsKH14AwBSK2LyhasKZ0SR1h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 10:34:39.8204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 540f15b3-8a46-49b2-b53d-08def2dd2791
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qhP4jsj2329FunKkYG7pIZBPAAakULngZWFUxb/qJo=;
 b=ysgSd1mMG3qzyDeVFmzAc0AGrzLthuvQOan9kg7kDMOZcY9BRe6IiGU/h+szxKNVL+VEBzbC+5rFb+kNUucEAH3TUS2sZoGCC19QzAlDk47T6ijjSPnBo7iFwPNBy9yS9VTiVMUwDu6/OdOWoUsdYfMyPqXZxB8Azf5g/CHisUk=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ysgSd1mM
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

PBUF_POOL_SIZE/IP_REASS_MAX_PBUFS are only scaled up for large TFTP
block sizes when CONFIG_TFTP_BLOCKSIZE is strictly greater than
TFTP_BLOCKSIZE_THRESHOLD (4096). Since the threshold itself is 4096,
setting CONFIG_TFTP_BLOCKSIZE=4096 exactly falls through to the small
fixed pool (PBUF_POOL_SIZE=8, IP_REASS_MAX_PBUFS=4) instead of the
scaled one.

At blocksize 4096, the full UDP datagram (4096 data + 4-byte TFTP
header + 8-byte UDP header = 4108 bytes) exceeds the usable IP fragment
size (1480 bytes) and is split into 3 IP fragments that lwIP must
reassemble on receive. The scaled sizing accounts for this explicitly
(giving PBUF_POOL_SIZE=9, IP_REASS_MAX_PBUFS=5), so the threshold
should include the boundary value rather than exclude it.

Change the comparison to '>=' so that CONFIG_TFTP_BLOCKSIZE=4096 also
gets the scaled pool sizing.

Fixes: 67586012490a ("net: lwip: scale buffer pool size with TFTP block size")
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 lib/lwip/u-boot/lwipopts.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
index 8dae004f1a2..733478a0cda 100644
--- a/lib/lwip/u-boot/lwipopts.h
+++ b/lib/lwip/u-boot/lwipopts.h
@@ -72,7 +72,7 @@
 #define PBUF_POOL_RESERVE               4
 #define TFTP_BLOCKSIZE_THRESHOLD        4096
 
-#if defined(CONFIG_TFTP_BLOCKSIZE) && (CONFIG_TFTP_BLOCKSIZE > TFTP_BLOCKSIZE_THRESHOLD)
+#if defined(CONFIG_TFTP_BLOCKSIZE) && (CONFIG_TFTP_BLOCKSIZE >= TFTP_BLOCKSIZE_THRESHOLD)
 #define PBUF_POOL_SIZE			(((CONFIG_TFTP_BLOCKSIZE + (IP_FRAG_MTU_USABLE - 1)) / \
 					  IP_FRAG_MTU_USABLE) + PBUF_POOL_HEADROOM)
 #define IP_REASS_MAX_PBUFS		(PBUF_POOL_SIZE - PBUF_POOL_RESERVE)
-- 
2.34.1


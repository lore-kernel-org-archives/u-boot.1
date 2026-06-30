Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC14EC43602
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 15:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39A8A8490A;
	Tue, 30 Jun 2026 17:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="g2SHMVh4";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YBvkc3Fo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE1D38490A; Tue, 30 Jun 2026 17:29:34 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4064B84105
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 17:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-tripathi1@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65UEgkue1078724;
 Tue, 30 Jun 2026 10:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=DdGED2gp4NAly
 2uINjKQJdHJxRTYFMilyxZqGn3vtGQ=; b=g2SHMVh4A/xOINZsSZQ15AYjySjLI
 xryqlIy+DqasPx3KN5y4r4Nv/bzElnRlLI1/rhG+lvJjItb0zXfoPg7YrlhzZqvZ
 ketxkvbMm54SJqfx4SqZJJDKRVmK/jOYYomSLRKAvesrF2wbSupiIEXUFWGv996w
 Zd+KInKMDfE39bUj/3b0mSWO3LeOriCoukh8HmZgaiqnh+EOg1wSt+2s9XQ9ChiA
 37loi8a1I4S/5h4tbJg1DEe+ZDfJDzgAhhih/UE0Fg4TyyJMdAHpHzaDeCIf19v9
 C9BWNIr8PYD47LHb5zQJP2YSyDwngCqIqzdlk+3ziCle+YDA8i94QQAwg==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010049.outbound.protection.outlook.com
 [40.93.198.49])
 by m0380145.ppops.net (PPS) with ESMTPS id 4f4cq6sg74-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 10:29:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwfiBoE7jMsiPfmrb4/hC5EGOZHwaAdsebtTP/5zT7SA5FXXZ37kmL0QU+rpHX9cXZRzenM3wC2/NopoOTYfh9sLhsu/NCKr5TxdnsiSErNVutSOLKxHjGn3CNdYk1x9CF1dzR8paSgwBb4YSjhtx/rokkNb6OjPLFS/uSbTBManfiLJqrJPuwoWUeFLIc+NzEU7FOR54BTnZNuXYYLnKPT6TwJzfZhMCxm5KWjXqNr4FjBHBGtCm+jng92kBGskhgzBZJQGK2CCjIF5CQgBvZ+EWDzQQQeP9nrz5vPl4l2TbrpHJfPLpy4orhRcGGw1ln4LkUsbFupFGAW1NmJ+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdGED2gp4NAly2uINjKQJdHJxRTYFMilyxZqGn3vtGQ=;
 b=M34IdmSDPuMz8od4TGw8Gc0tIBpTJ2fB6U15kzjb0bZV0bSmWYMGJuIgXiVNLfFMzHScuV7sF9dMexe7xu570PwSNu1QW72tYPpqhUC8u7tPDEFUKNsH9THdYFAozSbdn4WMhFQRzVz0N8HeivxaMoKMtJuV7O0qLsrGBp8wbiS7bqY1T4C2pqXsZnFOyqo/nOnQaK9zjYEU8zALVPH54vKZHkLrTiItKrWpWAcI+Xny16S/OEKbImYKxTyfACAUKXH0CtGuoM7tn6afpPlIWjbr90isKt9U1rdDZEIdhal2QvXWgirRbOjWIiD1+msk8a3LHhf79dkVA7WXq6XqMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdGED2gp4NAly2uINjKQJdHJxRTYFMilyxZqGn3vtGQ=;
 b=YBvkc3FozyNetlm1PgHaVN0rjuYnhqQUJfT8L7u/k0PCDrZyV2ACDMahonWBVHH/TA6IHYEb9kqhxzCNZYWVPlvlbqSFoZKCendr7zaEMxoMv5K4txK7yz4Ldb1h7ntMO/6ZfVv51M3cYgjNT4cf1a8qvA6grlP1Z1ec66ftXPE=
Received: from SJ2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:a03:505::13)
 by DM3PPF2023FE2F7.namprd10.prod.outlook.com (2603:10b6:f:fc00::c12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 15:29:24 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::14) by SJ2PR07CA0012.outlook.office365.com
 (2603:10b6:a03:505::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 15:29:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 15:29:24 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 10:29:23 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 10:29:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 30 Jun 2026 10:29:23 -0500
Received: from HP-Z2-Tower-G9.dhcp.ti.com (hp-z2-tower-g9.dhcp.ti.com
 [10.24.51.208])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65UFTJXQ3365129;
 Tue, 30 Jun 2026 10:29:20 -0500
From: Shiva Tripathi <s-tripathi1@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <praneeth@ti.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <vishalm@ti.com>, <k-malarvizhi@ti.com>,
 <s-tripathi1@ti.com>
Subject: [PATCH] tools: binman: ti_board_cfg: Add configurable sw-rev support
Date: Tue, 30 Jun 2026 20:58:09 +0530
Message-ID: <20260630152809.1933616-1-s-tripathi1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|DM3PPF2023FE2F7:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a82f24-750f-4a06-757c-08ded6bc5d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|18002099003|3023799007|56012099006|9063799003|6133799003;
X-Microsoft-Antispam-Message-Info: nl1kLAf1pi9oSTQQklnJB6406gt4E3ql1SOymXWr8zTcg6WfR1Ntu7GJ90BufCYPgCHqRlm7Fd8VwCrE3ldLvb39xTlvBkGiN5gh0PxrE+gR4TReIB+e4sG05+BGsd2sm2uRll8UaJYhC4ktEksYdqsq7dk7WNk5QDB++7lZZojv5Fy0JyLWXLzX4Icq4duAR/86roVajo9f8o29gDvGfgInidN9/KC43GSSQ0RVhvhCClW6JQcogy18J7lroSmjOlvYM3RwupgDqxQCkPH0CjN4nmSzKLJXxfBOOa2FADHHk8m5SRwQCi/0L0S4GLZKSs3TaThR8B8xPK4XEbCuCwDaWtmEExzYjR3QZ/RjVa/rJFXhPSDEoDr1USMifVcJBsZFBOu9NNJsi0HCYb1EgeIAaktGRASi41h2dYxeu+1q33xrjnLjfTTMqopY3XMijizWu5khPL6itef8SYPMpLQrNaAxso6qfbO+m23BOJ4i6egzo82tNlHgLtZmXVI5IVh4OrtAzlFEu2BpH9mC4Z8coDncb0qBEhnjWytiIwz3aZw03b7yy7gV1NuUlJNp9Ll3Rlj9m9EwI3EhJpUvNHq+Qi8Ya6hw7uUiYAkdWSQ1YvNL2eDJEswnlqhxsj7sv7gSM4SCacDVVUD297/dEOZ1G4oZyjpP3/GFSvOzaQO87+jpCiNvzIkZMO7Ufdth3lyG7tkI7zf8q7VLLxzdHQ==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(18002099003)(3023799007)(56012099006)(9063799003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WwxH5Wmol6Vj+mYDRv8l5teB+u2yLgGhVw6JzT/jxp/GAhkDR4qlwuTdNmBE0o/xb7aG+seQ6o9joqVnmOaFzY8oBoFTky9cpZmoEHLBR8BybbOIZPZpEmn0ztE8EFWMUhGOcgguCiyH81Ge3Joq2KZDvzJRmxygJSaKVsJARCrvKDSKLANTePNcFzPCAJnAIDlnTn1ArZzv7XuFEMbnC0AtEI6UkkPk6YA2z3h170Zc7v9FtFVugfOfOSbPfUXc1qwsZAVc7TJguoWcqZDXiGli9uT4AuR21WkPoArWWfTomhQyeCaWV6VVPgbSKG1VaydBjbgKFi+k91ZOr3ydhxvCNbHa+D16vB270xWPH8+W2ZMbJadGCWVwA/KG0/iX1ZAHE1hCtLmuGdxmUsDj/3SdusOV6Nl12x0jwrxAmP8aw+mrpSNwapHgkFPln7DA
X-Exchange-RoutingPolicyChecked: bj9BRFjuLLsFVSe+TJBNJ0sQeD0hUE0hmib6OCY7Cc4NR4zPZH4T8SoykU48sljbGiMLXuo/3mIAAodkAyC7qZLr5A/xZCu3/aYGlOL6gsxFjOVo2vk2PrxNxsjkrILa2d892JYc6sFSYoOvPlag4DUORSvlq6KjwRkuoNmShrlie25AU7CoLoyKQ07kg+fkqbkKGICCehwwfwEQeXjSuMgvsvFsOkdGRoXelF3ejmNaQurZW9P2gzztgL7xuDsEFEOan3xUEO1mcZWS+cp9pBfzO60skp+2T/6EfNlPDQuNfNv4vzIDq4UYryHINyYdCObOzzCvF3PmiIkd4ajB8A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 15:29:24.0826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a82f24-750f-4a06-757c-08ded6bc5d62
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF2023FE2F7
X-Proofpoint-ORIG-GUID: a-gcQu2Wx_d4VgstRSm0vKdikYMG6HCK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE0NiBTYWx0ZWRfX4IMTX4lQXWop
 NuzHNw09EO3OH8OkXWVRbfFfZGZ5h7kF6KiENgwrcN15Dra/8m5ihiLEHF08F5NeqGRbiKDpyEj
 87aEfcAFyMQawAvOry0u/3tb44Bp9rfAeORSvifYAGu+u9Zi9Fm81bLB5E6L9YuqKlDlD1WtUw6
 QF+6xkNSTNIjqqb6YvFlF8ulwbyMRIVEih+JNx/1lfC0fTDy53YquYqhDRIbOUVHsEyO/ZqAF95
 +dL4rPcqsLGUpTCMiHdkpSB6p3E+0tny907NPTXc6uTHgR+tr8RoZkTUVWvlGDNNTvWAvQYfaNe
 e1EA4wstNeUTq0mW9MRnllE0c9JRNLSI1axUGVsaNiNgjzmROXXuI7ODSJFBQYKmYNcNa8VL9RQ
 /8iQzjVfE4ChhrKchzJj2LyGbqsPU+aPhKKBSeizfZtuTeSSqGLxrhh0rLoqUkjQLPj7g1+h8W9
 4/DvfisU//rdB7cvucA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE0NiBTYWx0ZWRfX3ziXqpWvNx4c
 eHExf6MayrMmSfBbcLF6AmeKINvs7Km+YbJXLvfAkUDoLZIeongISLAbgh7jtSIItCVte+/bVKM
 Q7VwM2yrYDiXx+fz4I9fVsBeiGG0KeA=
X-Proofpoint-GUID: a-gcQu2Wx_d4VgstRSm0vKdikYMG6HCK
X-Authority-Analysis: v=2.4 cv=CYg4Irrl c=1 sm=1 tr=0 ts=6a43e0d8 cx=c_pps
 a=+3f3g5PcVU0WeXiSVbezXg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=PPwPmdLsoi5KyGvQsIcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300146
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

The software revision field in the combined board config binary header
was hardcoded to 1, preventing independent control from SBL SWREV
configured via ti-secure-rom's sw-rev property.

Add support for the optional 'sw-rev' DTS property in ti_board_config
nodes, which sets the SWREV byte in the header. Defaults to 1 for
backward compatibility.

Signed-off-by: Shiva Tripathi <s-tripathi1@ti.com>
---
 tools/binman/etype/ti_board_config.py         |  4 ++-
 tools/binman/ftest.py                         |  5 ++++
 .../vendor/ti_board_cfg_combined_sw_rev.dts   | 26 +++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 tools/binman/test/vendor/ti_board_cfg_combined_sw_rev.dts

diff --git a/tools/binman/etype/ti_board_config.py b/tools/binman/etype/ti_board_config.py
index 7c6773ac7bc..3f2135f8f33 100644
--- a/tools/binman/etype/ti_board_config.py
+++ b/tools/binman/etype/ti_board_config.py
@@ -38,6 +38,8 @@ class Entry_ti_board_config(Entry_section):
         - config-file: File containing board configuration data in YAML
         - schema-file: File containing board configuration YAML schema against
           which the config file is validated
+        - sw-rev: Software revision for the board config binary header
+          (optional, default 1)
 
     Output files:
         - board config binary: File containing board configuration binary
@@ -80,11 +82,11 @@ class Entry_ti_board_config(Entry_section):
         self._fmt = '<HHHBB'
         self._index = 0
         self._binary_offset = 0
-        self._sw_rev = 1
         self._devgrp = 0
 
     def ReadNode(self):
         super().ReadNode()
+        self._sw_rev = fdt_util.GetInt(self._node, 'sw-rev', 1)
         self._config = fdt_util.GetString(self._node, 'config')
         self._schema = fdt_util.GetString(self._node, 'schema')
         # Depending on whether config file is present in node, we determine
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index bf98b268ac1..ea2fa6eb83a 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7212,6 +7212,11 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         configlen_noheader = TI_BOARD_CONFIG_DATA * 4
         self.assertGreater(data, configlen_noheader)
 
+    def testTIBoardConfigCombinedSwRev(self):
+        """Test that sw-rev property is honoured in combined board config"""
+        data = self._DoReadFile('vendor/ti_board_cfg_combined_sw_rev.dts')
+        self.assertEqual(2, data[1])
+
     def testTIBoardConfigNoDataType(self):
         """Test that error is thrown when data type is not supported"""
         with self.assertRaises(ValueError) as e:
diff --git a/tools/binman/test/vendor/ti_board_cfg_combined_sw_rev.dts b/tools/binman/test/vendor/ti_board_cfg_combined_sw_rev.dts
new file mode 100644
index 00000000000..b998d22c2da
--- /dev/null
+++ b/tools/binman/test/vendor/ti_board_cfg_combined_sw_rev.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	binman {
+		ti-board-config {
+			sw-rev = <2>;
+			board-cfg {
+				config = "yaml/config.yaml";
+				schema = "yaml/schema.yaml";
+			};
+			sec-cfg {
+				config = "yaml/config.yaml";
+				schema = "yaml/schema.yaml";
+			};
+			rm-cfg {
+				config = "yaml/config.yaml";
+				schema = "yaml/schema.yaml";
+			};
+			pm-cfg {
+				config = "yaml/config.yaml";
+				schema = "yaml/schema.yaml";
+			};
+		};
+	};
+};
-- 
2.34.1


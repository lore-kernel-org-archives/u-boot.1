Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA3AC9EC88
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22CAB83AEE;
	Mon, 12 Jan 2026 14:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="USNorUyT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DED1683D8A; Mon, 12 Jan 2026 10:38:41 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0C5A83CB9
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyJb5YocvTLV3GgcSCwfWuLUDpNwpxOyAJwWfhJLLSKJ2bk5uaOAb/AXuw4UlLO2OQn+QfkW8aivHIauEwLYz6z2DLaowoTI92Ric7j7QzDcf/10u43dSpaYUufwHOMAHAQ+5Zp3ghY1/ZognCRlrWo66vCNcSM11MegwRHFFgKVtzWW3doUT0Ltb6gsdO9xAegUUmz3txlrn9zB4zMymByFb++MVRgp0RrnRVAmLhREz4ATvkqnfmPe2wlHDkDDgoGYls+c5SmcQIs0xych/YNREQalS2TNjUMyLroslVwA9aCnMCx8kQAulRxJEYcyLf762wZSed5h1yfiiVrF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Krjh4rvJOA/7nZTnLKqi7cyaee/531nUaBIh/GuGbkA=;
 b=pCdMF3RELCsc77S93wbhxnGWlZ3e4dNH9DOcXndd1FhNUJmyCCWf/lEhPKR7umRvsBJN8xa9P+NcgrUSiARKyO0S7MXuwcA4O5UeFrVCiaFwRkk6VrQCV9I0xP8TqgrblMBMZFnFCnLwDpw6yNuBkIqrv56xVoPT4PUfFAG/8iyu7Tui2IzWblxKg7KyA37CicdOshZISaxf2s7QgMD8IJChuja3c0WQTbZDtk42f49tGjj9YNllMBA7ZBej3iD8Co1bqYTDQXrMmYCtvZtR2XCKBZfVcumGdU41MpgH54lTfmGl7REynZt16SCuWeBI1m1xTAvf75Sym9pnAqQPyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Krjh4rvJOA/7nZTnLKqi7cyaee/531nUaBIh/GuGbkA=;
 b=USNorUyT3bYxtZD96PetdCeyXgFSRANhrgx5kdi1EDOMJMUH6RFPOgd4Y0lNhpKp23vyJvX0CIVRQIKn4HNJkGydyoA+lZ+9bnuQM9uc2v9YOLAHk5cLBILib8RiJLP0thNm9DNj+ohsmmh3WrGeIdUqplNJXZTReb0C2uS5RYk=
Received: from SN7PR18CA0002.namprd18.prod.outlook.com (2603:10b6:806:f3::25)
 by DS7PR10MB5120.namprd10.prod.outlook.com (2603:10b6:5:3a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:38:31 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::a9) by SN7PR18CA0002.outlook.office365.com
 (2603:10b6:806:f3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 09:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 09:38:29 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 03:38:27 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 03:38:26 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 03:38:26 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60C9cOAI156257;
 Mon, 12 Jan 2026 03:38:26 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>
Subject: [PATCH 2/5] arm: dts: k3-am625-binman: Configure firewall for
 ATF/OPTEE
Date: Mon, 12 Jan 2026 15:06:40 +0530
Message-ID: <20260112093643.885903-3-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260112093643.885903-1-s-joshi@ti.com>
References: <20260112093643.885903-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|DS7PR10MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee18dd5-8cd5-4fa7-cca6-08de51be57c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|34020700016|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sfEP4vmoqTwSJ1FISSTDIYB1J1R31UcnJdp3gqrYEJi7ad2Qnsusiw612RKc?=
 =?us-ascii?Q?KghWWMoWMnIVdungjTPaXJ4k5EDjFApHzMhV4BV+rfZ7SWBm6bJvfw1lw7ru?=
 =?us-ascii?Q?HHIBns6M4PL84luAkNR72eaPpErhcsfaCAJAYcgj3S3q01iJvbRiNzZR4tSU?=
 =?us-ascii?Q?5B7WiNqCL2Ew0d7Zj7MHfjeLnDK2ao3IESV6jO04Ulhql9yH/e1+3OAZLjNL?=
 =?us-ascii?Q?JaCOJM0UD9cgDuN9hzEzygBzcaY+dqiWTlQlcQOnQe4jD7XDfW0u9LF5Fa23?=
 =?us-ascii?Q?h+GVBrHOw56azcsD6W+9MeCOr64WO8xohth8IutNldSdYYj89a9gr/SvUPC0?=
 =?us-ascii?Q?VsgsP00yZy9247UEGNlTmy9eb09YtkTxG6NmLi61hgHOvO+sUxGFw+ooA5lG?=
 =?us-ascii?Q?/T/Ke73t3Br950ABwGMkm8XIAN4l7QdzGyytjHIUQv5wZzU00iaGCtxXLybK?=
 =?us-ascii?Q?JC0V4H2KXeJzg1WZo9woi5HSEsVDgrqVujhUTASbhVBvMkaklsw7KmLvAdTx?=
 =?us-ascii?Q?x0lSEratsO5dgenOXTmMv0epafeQkoUQrTpeb3wwQEfWRKlzdHkzqXCalw4c?=
 =?us-ascii?Q?b0BsseTF8kMuU/SmJqWsuxjr7Y2b4+ujOPPUL9wtDrc6SsCfdcg2HcA9XvuZ?=
 =?us-ascii?Q?QmfeZCicv1nfUT4TxPqzdRp4Rf/kDvGj/iPcCr0m12rwP3NQKmFE1SDOaknd?=
 =?us-ascii?Q?BYRETmUITsoJDpYEjWMvQFbDk//F8k3hTjX6YJWEu/D0k3GAwEFzu4n4PLLQ?=
 =?us-ascii?Q?ufa5n5czTI6dfqJYxlq69pePXALtW7R/ImZctgoiYQjrJcKpsnRHkh8aLKS4?=
 =?us-ascii?Q?hA634oqfrOffbxe/WWd8YYgCLqsMUy37CLwQdlfBcwhv8oKFNM84oYILbW7I?=
 =?us-ascii?Q?MEucRrDg3C/bgGnlV2t9cTzKEibDMCv9fbbX94Qsj1jip19Amjhynrtat6Yn?=
 =?us-ascii?Q?u8oXKhjIWAXnRvzOSOy+MGDh4qHLTQuurfPRARPbLdRwsel7r+zkEDOSDce6?=
 =?us-ascii?Q?YfLzpEYsayGI7rWaPHkOYfo9/szyghbS8gHbWlh44tP2yiHkKaTruKhLvpIM?=
 =?us-ascii?Q?YQKvdx7mrRJqZpyy5WDVMa/qdP+3HUYRURaMluHCDi53kfndV6cs9v0YkOeo?=
 =?us-ascii?Q?ifUX/rsH8WhQBX0Ay3s/miFP458d+udz7yxJ1LLbI73O+I3n9BRyuP5OYwjO?=
 =?us-ascii?Q?Pv4biMPgP/nmj0R++231z1y8O4jT9j0WDeg+A3BAZiypeSgDGI/Vvbikz4NQ?=
 =?us-ascii?Q?2GIMEVZXH/PMWeSh7NNC17I7df0A2QqYAQCK5BGf+SYGHFGUiRzlWQEtkNBx?=
 =?us-ascii?Q?ta8Ir7Zn7QPrno+2H9s8uKZwR/dFP82CPWyg3FKdAnaTfNIhxnGDkwXZ5DOe?=
 =?us-ascii?Q?55XIV7LrbsjqbgISgIKQbaamq7sr5IdtDrFNIiv05CxpHR1HlmeGn3FGp4sm?=
 =?us-ascii?Q?PzKJfUNa/E0IKqLArq7vbh4FyqeGPphH2QMv1ok/UzOWVXPnaxsZQPm2gQYB?=
 =?us-ascii?Q?nm1SX+4dhypRzKyiTuHznm/saMRf2VLIbtHsuNwK6jzIc35tiEvmmzQwHnTV?=
 =?us-ascii?Q?xrKNFrs+EWsuT09q+ZY=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(34020700016)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:38:29.0881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee18dd5-8cd5-4fa7-cca6-08de51be57c7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5120
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

Add firewall configurations to protect ATF and OP-TEE memory regions
from non-secure reads and writes in AM62x.

Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
---
 arch/arm/dts/k3-am625-sk-binman.dtsi | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index 42edb35fa7b..a1ac1f52c94 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -276,6 +276,36 @@
 		fit {
 			images {
 
+				atf {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-1-0 {
+							insert-template = <&firewall_bg_3>;
+							id = <1>;
+							region = <0>;
+						};
+
+						firewall-1-1 {
+							insert-template = <&firewall_armv8_atf_fg>;
+							id = <1>;
+							region = <1>;
+						};
+					};
+				};
+
+				tee {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-1-2 {
+							insert-template = <&firewall_armv8_optee_fg>;
+							id = <1>;
+							region = <2>;
+						};
+					};
+				};
+
 				tifsstub-hs {
 					description = "TIFSSTUB";
 					type = "firmware";
-- 
2.34.1


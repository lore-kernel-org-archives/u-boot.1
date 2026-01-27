Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FC6D2F031
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 13:55:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 071808409C;
	Tue, 27 Jan 2026 14:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f3yG8JkO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FCE683FD3; Tue, 27 Jan 2026 09:17:51 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23B2D83F9D
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 09:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwLB2M2eUUXgoqzcBsKmA6cAdUk8hDh+95OdYLIy3RBLptig62uVzHQvEf2PdSZChnMntDDuOeovwxx+cpOMeT/uN/QGQFkfdo0yxOby/eK1vJ8QDUro2CxOqnpldoQoStlI5Lco7ujxwW9PbUbqTmWpplAnc2GMMp8M3NjD4dk9dhnfsRDvjzLcbB72JfO4M3WE3LGz3Bl2n2pphM5jW5OFek/se47iwlgUhAgpGT78JcGB6sbGFzNmDiZ2KK6B4c4EULA8iUoUbQLoqzAtGFlGm66SM4HW8ojnUEuy0Z4uoAGFQEgXTPeBleEDbIEjfmESj/lhuVuJwbaynDJtDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjazb8XUltw+qYwg/tkuFqelB6Xwt5HnmS0t1hPI+Dk=;
 b=OWFx0NMCrmeqC2mAqbWKd6W/Tj1QBrTUGGlTSB4rewon9//L7GVfsz2+8EMeSTrpAqsXT1h36SPXakOU7tl3bRwN+20MXPOUSZo/Ka2tQOv4QA6R+6DTtJlhY79tfgRjTrTFB6bEdBw1nswNKmichBY0wN9/eGWMPdgSGDSEZaQmdF5DAMV3LD4kl6QAOG72bJlcGhBTaMf9I3zP22va9gFbgYGfFWkpQ1tpzC91LlpqBjPZB3m3XiSJcDMbD3t9XTBqUVU9LkZENfctXHcsjG+qmrho9AonLix4U7L1OBeqzJmmBNoXPpyoDenENntyf3k4bfj/ZHcMF0QsiVUO/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjazb8XUltw+qYwg/tkuFqelB6Xwt5HnmS0t1hPI+Dk=;
 b=f3yG8JkOg4kwPsOdXJKIvAgkafQMU4+qF26IoIY+H0cLGUhq1MVTMFd+EJCC8F2SGH6yyu21foBHDQUgJN1EKoGQgVXupuPQCHOamrhZ2zSkPQw70B5tPe+/4Bk891kmB2Mgow2/ddoG11pdI234fEd/kryTCgOIGQwUqrPVfVc=
Received: from BLAPR03CA0076.namprd03.prod.outlook.com (2603:10b6:208:329::21)
 by CH0PR10MB4907.namprd10.prod.outlook.com (2603:10b6:610:db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Tue, 27 Jan
 2026 08:17:45 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::ab) by BLAPR03CA0076.outlook.office365.com
 (2603:10b6:208:329::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Tue,
 27 Jan 2026 08:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 08:17:43 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:32 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:32 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 02:17:32 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60R8HVWh4029987;
 Tue, 27 Jan 2026 02:17:32 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>, <d.schultz@phytec.de>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>
Subject: [PATCH v3 03/10] arm: dts: k3-am625-phycore-binman: Configure
 firewall for ATF/OPTEE
Date: Tue, 27 Jan 2026 13:46:45 +0530
Message-ID: <20260127081652.506357-4-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127081652.506357-1-s-joshi@ti.com>
References: <20260127081652.506357-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|CH0PR10MB4907:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db0bbe1-5877-44dc-7cfa-08de5d7c8bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C+pxnJY2ejcIJ6ZWiwu5cyaIEMoBqGB1HN6CNT9JJy1NVSnJtiAWxza1I+n0?=
 =?us-ascii?Q?7tB/FuWG9oVSKubEQ7Nkmi9rxT5knRDSuOp55i8MmJA+Ma3K5rjlnFfBxeAm?=
 =?us-ascii?Q?YDCO+K7rJnDSCk/PC3vAGVdx8PRISeV93GLV7x5lGgY0rnHx3dRlWZQhcc6y?=
 =?us-ascii?Q?fqaxbclP6cdnb5GzRFuiiYiITs7TXSmTaWjQciBHUNYZJXFgs0vlQIOkzV9z?=
 =?us-ascii?Q?mr1ql5KF01mqHkhsefwXFtVvAJDfckvlMlhPUv+5/BAknXHTZGgqKxJq266r?=
 =?us-ascii?Q?afs9C0xzfTYoJstakMLP01oXOLOxv13y32Q/hty/k2H0ACxV8tmspJd99mm0?=
 =?us-ascii?Q?O7RT6NBq31Y/MXN3E54w3Va1+BvGj8UIZhzKjiF4qs24XysBUrV8bpKODOxB?=
 =?us-ascii?Q?enzrkd0/E/2iNrWxALjgUAZRrzQcdU27k9tipFZH3cijHwsGyxImJxEm9ov4?=
 =?us-ascii?Q?IaRC5SDGpllsuLCzF0Zr5uXt3NxicqW+L707/jQswVctmzIuXpxEYzuFDtou?=
 =?us-ascii?Q?hM5sqP7QfU7EInONV5rad7B0BkW2w6qkdtRsBvXJ+//tS/OY4sUX3MtamCdb?=
 =?us-ascii?Q?ZkOMMIttf5f0ECV4OO6sJY7IAFdL1uWp5cD6fhgqSyeaL95YnJLhbZdXPimO?=
 =?us-ascii?Q?kklLXDJqUrhTFlWN2HxTEJjG85f7mY4fjmkA/kRrPsIs9VsY8z2q1/rKSAaY?=
 =?us-ascii?Q?/AwtPSCgHjobLXrpKyKv1HJ0wdbapG5M8cJ+Fz/veJhGvH5tY3BwW61zqrFd?=
 =?us-ascii?Q?tH2vlTD6/jW3Un16TrRsm86gNjqJQWps6NU9Cvi1/yfH+TjUdMG8/ZF5WxlD?=
 =?us-ascii?Q?10vsz7ZDkF4RuzyQANURh6C3eNYgPjkdcAZkW2yaRxLRgujjTMOheoGdzxpY?=
 =?us-ascii?Q?PC5ZybJ8+eABf+Q8rHAW3wdN9cvIHrfGXLUvRiRUuDmrkZxNsnadi64kCzRR?=
 =?us-ascii?Q?DTdkr6aq+I/c2wQqXiY/76ARdYn+HoOcA7XixJHd9uPnjU95mRXUJxqtqh5x?=
 =?us-ascii?Q?v9EAlf54jtTGxRVXfe329i88tyBsW/acWfwIMzr+byC5tGuVBd0QM++uiqiK?=
 =?us-ascii?Q?Lr1Bnd4G0mIPp7O30x1xxHMBvSSpokSoexEM9GMbtHQl8JZklTB37HdqlUWJ?=
 =?us-ascii?Q?ehvZOxP60Eifr42T2kVUs2oQqkO7GS1Od6Sul8HWO6XpLtpHHa8CyN1uh43W?=
 =?us-ascii?Q?azUaR52EWWSXfPODIrc1ets5MOB32FegwI7vLrTY0DLjI4WfCCojKdUdI42k?=
 =?us-ascii?Q?0AfC1KvCQcrTkz6dsoHzgpOaNIFLqns/iWUCtURJ4o5TvyVvOClYFx696qOo?=
 =?us-ascii?Q?CcVwIY2E88XY91gBAC/ePeRD1RXRl6tuXcYuFLQEurARa/9Fh+h/QtaLerJg?=
 =?us-ascii?Q?jExQg2C8YlGb941CaRWTjKFpokC43fSxp2TMNfv6vCoVaoBdwds/PNbT8dUC?=
 =?us-ascii?Q?qsHwKBo/YH5Z6jOWYgBVDH93DTI5xC8u1dnL45m/6vssxXL5RDj+EBRazv+T?=
 =?us-ascii?Q?lsrb1xhkj/ou4MOZ7e9YXS9TnE84RHMONYdk4l/Y5LM8Lc/QZ11U35nZyVdt?=
 =?us-ascii?Q?3vTujpJ0fyNlERBvhO6j8dAy1iduMp72BEIzEIYPtWCIPipnWZNw1OVC3gyH?=
 =?us-ascii?Q?0ZBGCJlN6v0LkshF/V29xKAYfSTg1WeWOyljYarSDUY/d9+iR53hptS/A0fi?=
 =?us-ascii?Q?WFD8ZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:17:43.3578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db0bbe1-5877-44dc-7cfa-08de5d7c8bbb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4907
X-Mailman-Approved-At: Tue, 27 Jan 2026 14:54:50 +0100
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

Add firewall configurations to protect ATF and OP-TEE from non-secure
reads and writes in Phycore AM625 SOM.

Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
---
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index a9bd5a2be84..5e777a1f305 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -215,6 +215,36 @@
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


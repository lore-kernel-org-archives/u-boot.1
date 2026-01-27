Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194C8D2F031
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 13:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA54184062;
	Tue, 27 Jan 2026 14:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FZz6R9kY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B3E983FBC; Tue, 27 Jan 2026 09:17:41 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EB3583FC5
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 09:17:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xs3fwxVAIXovqbwtIs2evPXkhkdd2qaqA7nVQnqsQ7aR5avhpZWnAK3tQ7F6SL6IzR966iRfz+yF7HBfPSBziH8KvLK2a8mhHptpGr92kLvWUxsmdkPQ3kZJwZ4NJiWDck3khI0a2+8gcQ5TfoWf3XW26eJkvMOCMUfYuhaPcFsV+wVsvdNlucy4PgRqpQspNHgv/fyoPi2j3yUWKIBUVbnRi2Mi+yi0eIxxHLCYRVzEk/CfSCKoJmElzp5WYVbKLiKHi9mctkE1bBt813pDvqBpuk/b/jpbTiAOvB1NLpSx1K+0AN3tz1kbzPRQVo3PxauMwOOWeCoV/yOHgMkm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIJEhV/SO6C2IVseJhdy7QWuvzqZnHxfiKIoGeKrZuA=;
 b=D8WY+nsLgRnSH/hRgINQcFk4gQIbTbsJIBvYCHBpKTkZ4fqer3SsInn7ez/2pUXfd0MAo7wD8ZoSEavJ+oP82VNTr1NJXkfb6cMoby7pG7yt/USIZsOHVt3xk5DZ0gZOOIO1LCPgm30uqRsIbo6aNMwT39CKNqnaOIdfY78zoHvsafURfMsRjSkAY/uFtSoZUuimJIKtjzgHea7UBVwuRYf8J+f0Cj21Bt1F+kYiPwpHhCSV83IBX10LkJ5FRQEofdDxOUi0cYfKKsF98R/51yJUqd8/ZcB07s+0E8oojiGiXPN4zEBdPLitR5YnsAoBr14D1vJQtveuo2u2Od2U+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIJEhV/SO6C2IVseJhdy7QWuvzqZnHxfiKIoGeKrZuA=;
 b=FZz6R9kYOYGIqwFDiB1yexy9p6Bhr46KgdwUzHOxNk/rdQHA0/rsSPSaws1qVSxwXodugYy9DkM9+WAWkwbYecsHuQ7dhXnWx9pRa9/a9zuK8M08wAw1hRZle7fWUi3DKZLKEP/vF7x0SF3QxLSKBp3tk9JIZP3GtZ+My3OBzgc=
Received: from BYAPR06CA0062.namprd06.prod.outlook.com (2603:10b6:a03:14b::39)
 by DS7PR10MB7373.namprd10.prod.outlook.com (2603:10b6:8:ef::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.7; Tue, 27 Jan 2026 08:17:31 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::70) by BYAPR06CA0062.outlook.office365.com
 (2603:10b6:a03:14b::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 08:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 08:17:30 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:29 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:29 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 02:17:29 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60R8HRbr185216;
 Tue, 27 Jan 2026 02:17:28 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>, <d.schultz@phytec.de>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>
Subject: [PATCH v3 01/10] arm: dts: k3-binman: Use configs for ATF/OPTEE
 addresses
Date: Tue, 27 Jan 2026 13:46:43 +0530
Message-ID: <20260127081652.506357-2-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127081652.506357-1-s-joshi@ti.com>
References: <20260127081652.506357-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|DS7PR10MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 4830d4a8-0649-487f-2a7b-08de5d7c843c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?58GYn1y1i3u9Ajd16Jo3KTOt2UWK3qkv3nvxz/gN/6lE3OT1w4/qxetRqLic?=
 =?us-ascii?Q?k+JD/fj1SLnXok4SRozw153Mr8P79KQRbTPgSr8v4w3WicqnnfJquPrzz/Uv?=
 =?us-ascii?Q?bVMZnOClKuQ50jJbuStHc7GbhzoNaMUznOIAgzJVojQ3O3eHr3J4TrAiijEE?=
 =?us-ascii?Q?XBjcXAGOY99SNoHoFRt1UwXTtlB2ZyMEAivhOEkVDbdvWjDbJYSRGcB17r2p?=
 =?us-ascii?Q?s3pdxQ7Em2PXB2GMJrsl0vMtLYSVld+Xxb2OLuQmmC0Trobmjt+jPFg6NFhB?=
 =?us-ascii?Q?qmSHBg/tz3CzzyBWfWYy4W7cCs9dZ2Do+9YHWpPJXlhN4RSqt0U5frN+aWLZ?=
 =?us-ascii?Q?hU1AhFO62eWNA+suJdEhCQk5J2Jf+sKpbx6qLBwZch4YrWXSSEvzbgNQcB7U?=
 =?us-ascii?Q?eWuE1ilNhQ+hKFrj///Jya5c2F/YMUEuXrfQLGkDsN5JtNEJ7THvC+jLIFS/?=
 =?us-ascii?Q?djKBLTMqFtuLA5x3yh2zMaoUuRTUP1UrXh+719pMIHRLzGd7YRV9bnlKacfB?=
 =?us-ascii?Q?0hNGvHcUGAsi+4+31mkr9OQodS4bV/1nYWpHSywuPKWdpioFbAFybAuM9JJQ?=
 =?us-ascii?Q?knQowRzPKHhi/+nyGNKGddaya/0Fw1WluXmkMpPeByrBVmq11YAcOMMLC3sh?=
 =?us-ascii?Q?JWWCHHM3TQllY5Vwozsb/XoQ4DPfo2zoHdpg9L1C1ITbS+Rmh8yzgI8vr7VD?=
 =?us-ascii?Q?94pneBUXx4vuXi1UO2v3PRcdcgv9++JqOoG60T0ANyc1m1e6fLp0RNzlXv6o?=
 =?us-ascii?Q?W2otIKdX50O0XhBnu4QegARqhOtrFiGSEeeH2YpwgygUMlFPgmHa8AVfspc6?=
 =?us-ascii?Q?O66x/9urUE49qCtgo0LylesqkddHHIsY3GkUSXYgvmYMkaFjTt75AUSZyEgM?=
 =?us-ascii?Q?WtnTn6ljjmFXnbM4vwB3+LXq+dQExCcr3ADDYmIfUtVapikJMeMdv24tduSy?=
 =?us-ascii?Q?EVl+QGOL/KeJXBZW9GOZ9ui/CRlZoo97Br2bB8n5rpDhHAMueDBKu/QkC2NW?=
 =?us-ascii?Q?tf8lC0uR1dOcv6c7eW8j6VcEfaOlg1rdf9dlcuK8GbijZi+GCC1bSlbCMpQM?=
 =?us-ascii?Q?IMTGSpo7EZdRknHBzducdoPB5FiPqSVzD4gn2NppCJ/Hll9PusVH1485oOpK?=
 =?us-ascii?Q?sN2dwr9jUB3ZKHXlL0dNwGLRTKEtrMwOQyLHdXqaDohbjH8SxJbBGwy8QA87?=
 =?us-ascii?Q?J+zhvKJfZ1urkhjttLA+zpRB9jKthhDcNnbEHVCqamS73ub1hLyBdnAwRjpu?=
 =?us-ascii?Q?Gy18u7Ubl0wYreP2LrI/8T5JfuT2Sp7sHdQVWIBB72SaCiqOq4MNvkVhjM+X?=
 =?us-ascii?Q?/BI3MV1pEkT7dAgj6Z8UjZ1Kv8s4EyX7UwtU0d4Gv/ypSjWaovSPSCrn0fgL?=
 =?us-ascii?Q?oPdCW9TK/xPZRRGXrrX/cgXHl+KjrdyQhqIOt2LHTsq3MHFZNJ8+iAGfvwsC?=
 =?us-ascii?Q?ldJoIUZ7stBpWPplRSomzQLnBdhCCx0wb0l4xM/tjI6CiD7ssgvWCJOa7hYZ?=
 =?us-ascii?Q?tE6Jl5HM/MjlzA0HawonI73yhnsgOc4FEEYmzuXv8776qT7gKiQimY7vagOK?=
 =?us-ascii?Q?V6fXf4/T0HLqdpMrJlLXr9cppBBJYarZM1iclIQg4Mtj4Ehl6b3C/fQejqAK?=
 =?us-ascii?Q?Cbxro5u2paWaIoPtV9YZ//f9lwqA0HbfecJGFORRhidPBrE5HNvfRkJV1/3W?=
 =?us-ascii?Q?ON+58A=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:17:30.7722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4830d4a8-0649-487f-2a7b-08de5d7c843c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7373
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

Instead of hard-coding ATF and OPTEE addresses in firewall configuration
templates, use K3_*_LOAD_ADDR. Doing so ensures that if someone moves
ATF/OPTEE regions, the change gets picked up by binman without
explicitly having to modify dts files.

Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
---
 arch/arm/dts/k3-binman.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 761b1730464..0fd93f9536a 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -476,8 +476,8 @@
 		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
 						FWPERM_SECURE_PRIV_RWCD |
 						FWPERM_SECURE_USER_RWCD)>;
-		start_address = <0x0 0x70000000>;
-		end_address = <0x0 0x7001ffff>;
+		start_address = <0x0 CONFIG_K3_ATF_LOAD_ADDR>;
+		end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + 0x1ffff)>;
 	};
 	firewall_armv8_optee_fg: template-8 {
 		control = <(FWCTRL_EN | FWCTRL_LOCK |
@@ -485,8 +485,8 @@
 		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
 						FWPERM_SECURE_PRIV_RWCD |
 						FWPERM_SECURE_USER_RWCD)>;
-		start_address = <0x0 0x9e800000>;
-		end_address = <0x0 0x9fffffff>;
+		start_address = <0x0 CONFIG_K3_OPTEE_LOAD_ADDR>;
+		end_address = <0x0 (CONFIG_K3_OPTEE_LOAD_ADDR + 0x17fffff)>;
 	};
 
 	ti_falcon_template: template-9 {
-- 
2.34.1


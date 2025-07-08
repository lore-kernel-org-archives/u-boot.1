Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D66C8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 13:42:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACAFB8334F;
	Tue,  8 Jul 2025 15:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wNgySG/J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2895883323; Tue,  8 Jul 2025 15:42:15 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 175B18331D
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 15:42:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=go72xG91O1dhne+0Bfo0b2+B3b0iTZ0GseTEKpliRW31ddc6MUY0nPNnp29cKfL/vVwg5/PwRVR8tE3nl2TphaLT41OmdTbopBU96He0d/pZb08/XHSYek5upYEhaBSRRrRvjLEQshXJIbasbMCKVvXzZwlUgPrIiNY2mxn5WOeO8uK4t8Jttxcvx4hqSjfV+NM9dD7ps7NyTfspzxkDW+FlczzQKyAmf06Z0pOacFRJuRK1SJgT0Ogl6hpDiUvvsiOTcVgV6x4Nrylg7MlErGXFu1G9u8m9nibDTREQWojttGOU2SLysWyK5UEe5bhAZyxUEd26h98okbrGoYfXHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P46GtgsiaMyveQC3P5GcU6ERsSHpAl6T9o3zg6GZlu0=;
 b=mE+H8X+VxCgdUpy9uGUksZVIaIe9R2y6KRqyfKbW9xnMWOF9oepWybKzBSI/G/u4o0Dp7Xh8r7oHOcBs7iaXvCqdCsxM3fwlo86pnumDfe8SlvT8nQnJJ35g9S7xzg6hEM0OhqIJTGljoUo0moJq54H+2lOyuYUtPdmwiJtBDj/VPs3+kpN2jQQBxpfLJv6MvMUhY0ip7/zVyC8LTe0Mf6C/cPCaG8xUGSxZ/cpDEQwq1y9+Tz+yHomNMv89SJe3CFyXOuCE7CKe/nDW6kbPGIKLk/pXMdcXSQxE7lNgEA13ittUgKjIbukR7LRQwhiVDmpAf9Fj3qeqsdj48VuKJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P46GtgsiaMyveQC3P5GcU6ERsSHpAl6T9o3zg6GZlu0=;
 b=wNgySG/JA2LtWCzXdZMqaSVga3ieoc64jg9zhzL2KqdaYM78vxh1ViRxBYS9DFb+6BCHwh42OgabI2bmoVOckfUrg4kjVfooAjWr1KHX3+h83g2cg8prjSUG7pHlMCCW1MvwTG41Qy6OOsLnatZyOkZYUK5TLDXZehCKBqkYq80=
Received: from BL1P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::19)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 13:42:09 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::10) by BL1P223CA0014.outlook.office365.com
 (2603:10b6:208:2c4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 13:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 13:42:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 08:42:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 08:41:58 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 8 Jul 2025 08:41:57 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v3 2/2] board: xilinx: update guid based on metadata
Date: Tue, 8 Jul 2025 19:11:42 +0530
Message-ID: <20250708134142.327224-3-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250708134142.327224-1-padmarao.begari@amd.com>
References: <20250708134142.327224-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 746c8543-69e7-4156-1bc6-08ddbe253c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9xy4cux+DsP9sIRLJ3vXJWEU4K2HHDGmepTkEmgEl6r9yPMCi7mY7JCl9oG8?=
 =?us-ascii?Q?tvqGuGr/4PA06GWAzpf0eeuyzWIIuOC+xdqwXMMevsnbL0QG8nyPMgQcI9p4?=
 =?us-ascii?Q?1DsT6FQJTZhEhDEb5NwHupvIHbzqcJTFqaxnCK6+Ve0BlMXt9DnaP9apWRrG?=
 =?us-ascii?Q?WodYk7xlUy/C5Sp11RojpKQCKNLQLvCObIiBIEL4DBNyCYz013YwUmQFCcGh?=
 =?us-ascii?Q?+aHjY3k8Rhmy5JHcSSoclZoCPuow/BzjfndeKdOx4W0bFMoAnr1gwUdN4FKh?=
 =?us-ascii?Q?68CPpK2CP83eE470OpXypkNKeZIjZg81ZhQrI+U5fLysJP0ry0LqHe0Xv9H+?=
 =?us-ascii?Q?XoRdLUraqlArjz6XwWUzctmyLz+I3ZgSHly9ZPKE7oiUz6OGOLbepwoy6ccn?=
 =?us-ascii?Q?hv0fdY26B/byJ3Rm9K52Kx9yJaEbWzYcwJAT3MjiD3R74OwSGUG5C9L1evo/?=
 =?us-ascii?Q?kM7ggOkAZEPK5MIyBQD+2F8n6ajVFcVjhuPQhTUa+7acoNuwIKr4tOmv7TL/?=
 =?us-ascii?Q?DjP5mR6QX/++3otqO99Ki7FbaJMEzWh85Z0VZaI6w7sO9xjq+55652rmMYV/?=
 =?us-ascii?Q?7hXDx08R8dfx3vJmmCPtRgyrflv815xffP0V0C8JoSkHZaZ0pi62pwOvB+e3?=
 =?us-ascii?Q?2PjNanmC/oPiS2N4Q83D5cBp0k/nPNEmRVFto4LdG25j2xMADV+TF4sdpLbv?=
 =?us-ascii?Q?Nj/gD6TcI9cdJ+a9ZW11fQ5s7jdfaPpNqSf3g4knaKR56O3yL/6t0KaXvz8N?=
 =?us-ascii?Q?pG90JaPHYnSfDGwzihZhlyIJg6ouEIKs6PaPvB/WphEO2OVud1IuZnI/dt2q?=
 =?us-ascii?Q?PfD/ItAiJZN38oih5rFBVsNxMjqUUDrhwav7FR9taTE2bejYO1VlnK28ZNSx?=
 =?us-ascii?Q?gViERxYtI4ghsGwumDBrhbiDBiwHwxYQbtYyjt/BBlI+qi3UmQpjSpEJveL7?=
 =?us-ascii?Q?oF/YkFUIcAYDbIespFLgaXLDOwMXyk469GpPzIPBQ5B+ZYWK1B/Y6Darxwie?=
 =?us-ascii?Q?q82J7/ZFJ3bKeOJXJgy2BzMfLJe8WN/qXbC6ySv2Fl9po/r9c7CE+S07/6D9?=
 =?us-ascii?Q?+LrNx3gTF6JQNQQc+X/XkvNO73ZMU5XHd9FMH5ViJpqj7HcBKQqVQWnHr69e?=
 =?us-ascii?Q?8Tj0nTK47X8Yk5ZBZ9yKQufIJ+zvsOQY1o8bV9gMPB717sjFrVPiixBwHsJr?=
 =?us-ascii?Q?s+QuEY6wC5C3ZECT0k4t6KLZUH3x7UXutq+2g3n6mi8eQr+OnNVu6dOghASO?=
 =?us-ascii?Q?cF5kiw5IXMgupGsfFQ20WXKh9CxZHyJQHogEM0WPuC2FrpTnWCC9c8T7iRQy?=
 =?us-ascii?Q?Mk0KrVYlfmX3/qa8xxY2iOG6sZTsU7vGGhjDECuWeO0Qrxa7NjWfdCW/ct8b?=
 =?us-ascii?Q?jwORSvpINo+qav7+Rm05I//J+ul9BJPMVeHLQExxaK5MUXq6DP9psRYIKA4L?=
 =?us-ascii?Q?OpWxkRysLqIRs3kWXUwYMdb0Lxd9qKnMKsCGOdvKiQMK4YU35pcB/aC6//Ix?=
 =?us-ascii?Q?Lq6yuV96YDSzSVVX5oR+sFa2SCd8yk4olzaj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:42:09.5244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 746c8543-69e7-4156-1bc6-08ddbe253c91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321
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

The generated GUID applies to all Xilinx platforms but is not
specific to any individual board. For FWU multi bank update,
use the image UUID (GUID) from the FWU metadata structure
rather than embedding a generated GUID into the U-Boot build.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 board/xilinx/common/board.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 8ffe7429901..c1fc8505761 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -712,3 +712,29 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 }
 
 #endif
+
+#if defined(CONFIG_FWU_MULTI_BANK_UPDATE)
+int fwu_mtd_platform_hook(struct udevice *dev, struct fwu_data *data)
+{
+	/* Note: The FWU metadata is an unsecure piece of data, as
+	 * highlighted by the spec, and there is no way to ascertain
+	 * that it has not been tampered with in a malicious manner.
+	 * U-Boot OTOH can be part of a trusted boot chain, where the
+	 * U-Boot image has been verified before being booted. So,
+	 * although this does remove issues that might crop up with
+	 * manual mismatches, still need to consider the fact that
+	 * the FWU mdata is not a secure piece of data.
+
+	 * And this is a not real problem with Xilinx platforms because
+	 * actually it is only providing reference stack.
+	 */
+
+	struct fwu_image_entry *img_entry = &data->fwu_images[0];
+
+	/* Copy image type GUID */
+	memcpy(&fw_images[0].image_type_id, &img_entry->image_type_guid, 16);
+
+	return 0;
+}
+
+#endif
-- 
2.25.1


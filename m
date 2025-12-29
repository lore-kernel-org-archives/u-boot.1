Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78516E8FDB1
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 12:41:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1FCA83DE0;
	Mon, 29 Dec 2025 13:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="oNu5HSzC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8475B83DDD; Mon, 29 Dec 2025 11:48:58 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7445C838FA
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 11:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbgSH36UXMCiSlMnIuSB1iI+CG1kWba01dZ3ezMdJXsnR9ZtZcwOUiDEC6iQzUeDiGvnDh4BWZuTLPGcIecIP+orD8LcnNZGw8leLULCIiToVv6O1zrJXWeIeA+GQagnJREk7S2YaTbZe3thhhen5E/g9wSusXM6cMKlM0lPib94117CtqeHBTy3K6CsA69it29kMzt1jbaHCRP6oRMmgD3GiAVW+6C3nOAIN9vrbItyw/O8HdMsPNh89XIZpEvlyxFC0sK0pQyFLrUkFz8U1WfgThwgS7fFaen5vn/evQ0B9rLnkUc41nxP/qWk2i6xzkAPDI6e5X0PM0+JEqCskg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YClEXMBJ7qgXq1VFQ3wh+ZNzPxEC83Aky96gEgUGdZQ=;
 b=f+Qhs7AsRSve0CZlzp9EYAjXKEq+cyy0WN9hUHRzcInjj8vfGijtnfAOMTZm9W2Fz4dsTZsvm5DrCdnOFVS5+uhJAMRCINFZivA3FpHJBsLZyDwwv7dlEZHMZ7W4RSqTsg2fPE/ZvIfZxFoIrDSQXosoiikGHM8nI/EBISkXG+pJUtrhcm6Kv0suQMr4waaL9vnPHEXD9Z/IAU6TfS0DIkJSj93Tlzl8FzkNrcQiFkVpfthdmySahatssw5jySZJK3EEuue/fBTvFuoqQFlGjiqy7uOb8BCQspMw4rAwar8m6Fms/nXZj59DakPUIhQ5ek5LfG4N93FktbgjMLRPrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YClEXMBJ7qgXq1VFQ3wh+ZNzPxEC83Aky96gEgUGdZQ=;
 b=oNu5HSzC1ZtAWp0RNpZqoDViFL+YBx19SvJuMBfgt45MiznIgaIk0tk6LxdMhAenRcpaLg1FXcwI915CFMhDXh/Xx04LJRxz7iypaBB/oMnWchNc+2+6DAr2xnv42OYMqGhO8OhG8A5ycaCA3fCXtumvNkPnpnJY0xP2OvYL383YUD95iPO2vNsxMXKGUqQuipbu7EKfnJ6pXOkPy9Wjw85GlKPwOVcXcYhB0Hdw5jqzOt68VifZ1cwCF9b8fePhjXU/EBylt6m9AuQ8QjY+09Z4g9L3uaUyWxPLARThPw968w9bpLy84ATGXXXmiGCgJFivzDZucrwnZ1nYmet3vg==
Received: from DS7PR06CA0010.namprd06.prod.outlook.com (2603:10b6:8:2a::17) by
 SJ2PR22MB5246.namprd22.prod.outlook.com (2603:10b6:a03:586::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 10:48:52 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::b0) by DS7PR06CA0010.outlook.office365.com
 (2603:10b6:8:2a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 10:48:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 10:48:52 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 067E9E8F49;
 Mon, 29 Dec 2025 12:48:50 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
 Stefano Babic <sbabic@nabladev.com>
Subject: [PATCH v2 5/7] video: imx: ipuv3: add names to clk function
 identifiers
Date: Mon, 29 Dec 2025 12:48:05 +0200
Message-Id: <20251229104807.3104-6-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251229104807.3104-1-brian.ruley@gehealthcare.com>
References: <"CAOMZO5DOUE2PexcBcVcg3vYTo5eV=LT3=S9cSBosLCyir8Kw5g@mail.gmail.com">
 <20251229104807.3104-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SJ2PR22MB5246:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 89bb7f5a-1b3a-41f3-b949-08de46c7db2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/YillCvJqipnhlX8ulqoJxGtWKR7Z456EMOX29fQqWcbfG3Aq5FsU6BMZk29?=
 =?us-ascii?Q?m8wZgZ8JKk8x4ro/6qcZ1cKtP8eOS8JA/3STNWtYMy6FiJG2qYLWvgYtA/w7?=
 =?us-ascii?Q?9rcsfhPo4SfFlpYV/vSM76U5mSwka26Nq7KFDQL23TI5D8mObWQ6VX+PKU+9?=
 =?us-ascii?Q?o6UHjelyfotPTan+yJfqwJcj3LOat/s8/wYPUhqSlSdR92/WGoTh5I6yYvJ6?=
 =?us-ascii?Q?v1kH1st6N6mvN8HURJCwoO/W0AsjSh+769X0qnyNRQBzFz8aplLrL2gouQMx?=
 =?us-ascii?Q?I6UsaIHg6g5ttB2UoBfi5I2wOGfFf03wvD1M9pAnbs/TOJl95wGsUC9eRxOA?=
 =?us-ascii?Q?2zAKsv8LrVnYNWYFsfrBA7LdOZItkPd1YNEKtDN8MLuD6z/ykhifb9WYjIv+?=
 =?us-ascii?Q?dzzO2+K8Z69TIa92ejBRwkiC8KF3sbPmG8qmA7ehqMwgYffEYXDUJn43YjPO?=
 =?us-ascii?Q?sj8S5caYyAGmZ31IKCBRxuHK2xI+Znvp/KeQ9ciejFXrEMYLmzEfIymG7GIy?=
 =?us-ascii?Q?atDN/WuhGyL8B6iL3C6X9fMgM8jBoVzC0hEuXKT+u+Q4eQWLBrm6RxGsHxHD?=
 =?us-ascii?Q?MepQfZ69l0w2Z4kME8SuAD1wTfiRDeFcergn94yLCJdmrXCKaWNeQ0ODdQvS?=
 =?us-ascii?Q?91uMNnAS2wpmNlQx6FHs+ZfpZKak9nNPv38TOAn64M3Q71cjNj8Jkj10gHX6?=
 =?us-ascii?Q?zpswrORgEwRaU4SXGMkLNYOHKDYxR6VMwg+yqho8PYFkz7uscJ39NpbWm03T?=
 =?us-ascii?Q?/ratdW9RzjxKvx0mNYX3hSctTgybY/ADSTAJeSqd8K/ISgpsZ8Da8TUL6Y1u?=
 =?us-ascii?Q?PlKsOkcqSlI+OLqGcu8bTb9jljW+zICqHpzx6hUyuAkvq3+6NbuOi1WZBb8m?=
 =?us-ascii?Q?IKa5Mwxkl/UHN+wj11pSRoL9aGHPDFcir3Xf+UTt7iI19PljhEaqxW1sV2fi?=
 =?us-ascii?Q?g+lPs7y6WYFBSljpsErf9DItCRLnfo1UAZCOlpp6uAe/5cYu00mpvqDRwwOx?=
 =?us-ascii?Q?f+9wq9pIJ6d4u730ZcHXx9rFDaQS9X+ZQqJj7JqlJbBAlH5dat56TCFCKiSK?=
 =?us-ascii?Q?wvEuNaMJyhhqRHrXaPNn2SwTFD5aqOlzPo90WWp7LUnaad/Z56XI71ovmIEi?=
 =?us-ascii?Q?JeoUx3PvZpdUsVI93Xa73j0tjKB1xv6r8Gka8quXdbLlAUMsSIDcKXdcj4Nu?=
 =?us-ascii?Q?4DtTYV0NTHeyLQkRQoSFA9Caj1aQQTgW10XhntCQe9jFyt6+ZLcJBGjTArUw?=
 =?us-ascii?Q?V9+X1fpazerWpkF9bnrL7rM7KGTL+0DDtYCkFVlESP0M65KNqhdlZXefkgnd?=
 =?us-ascii?Q?s0WGi1RSeO8CrYQXk13X6uWFpcUJFG87Hd2tMb5Y2cPnzjZEv6vRMA/io3lk?=
 =?us-ascii?Q?iSdxM/1eOVz6xbZn/NIxSx1SxZl7uVbdchRu/8PrEbapXxFT3dTwF5Sxq2mO?=
 =?us-ascii?Q?YiiRd44IEFJdKstHhq5JMEGvGRq9fkZJ6Mb1PcWY80PHOQE0qPihOBes6r5W?=
 =?us-ascii?Q?XaMjo2CTDTJGSaxNgrvKE2zFMvar4hbUG416Q0slUspbtIsGPGdGxWvhlqOL?=
 =?us-ascii?Q?IvQj8AB6WgG6fCU5V3Y=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 10:48:52.1558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bb7f5a-1b3a-41f3-b949-08de46c7db2f
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR22MB5246
X-Mailman-Approved-At: Mon, 29 Dec 2025 13:40:49 +0100
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

The API should provide clear distinction in the order of parameters.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

(no changes since v1)

 drivers/video/imx/ipu.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/imx/ipu.h b/drivers/video/imx/ipu.h
index 16e103cf541..f7d9d809529 100644
--- a/drivers/video/imx/ipu.h
+++ b/drivers/video/imx/ipu.h
@@ -39,30 +39,30 @@ struct clk {
 	 * Function ptr to recalculate the clock's rate based on parent
 	 * clock's rate
 	 */
-	void (*recalc)(struct clk *);
+	void (*recalc)(struct clk *clk);
 	/*
 	 * Function ptr to set the clock to a new rate. The rate must match a
 	 * supported rate returned from round_rate. Leave blank if clock is not
 	* programmable
 	 */
-	int (*set_rate)(struct clk *, unsigned long);
+	int (*set_rate)(struct clk *clk, unsigned long rate);
 	/*
 	 * Function ptr to round the requested clock rate to the nearest
 	 * supported rate that is less than or equal to the requested rate.
 	 */
-	unsigned long (*round_rate)(struct clk *, unsigned long);
+	unsigned long (*round_rate)(struct clk *clk, unsigned long rate);
 	/*
 	 * Function ptr to enable the clock. Leave blank if clock can not
 	 * be gated.
 	 */
-	int (*enable)(struct clk *);
+	int (*enable)(struct clk *clk);
 	/*
 	 * Function ptr to disable the clock. Leave blank if clock can not
 	 * be gated.
 	 */
-	void (*disable)(struct clk *);
+	void (*disable)(struct clk *clk);
 	/* Function ptr to set the parent clock of the clock. */
-	int (*set_parent)(struct clk *, struct clk *);
+	int (*set_parent)(struct clk *clk, struct clk *parent);
 };
 
 /*
-- 
2.39.5


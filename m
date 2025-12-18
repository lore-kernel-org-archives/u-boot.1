Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145A1D6ACEE
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 12:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26C4083DEE;
	Thu, 18 Dec 2025 13:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="i6c7ySEi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A24B583DA6; Thu, 18 Dec 2025 09:33:41 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62AEE83D3C
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/I9QywsQ/9nfK8gxcyGI/RPVNZdG0CE1HvZvJUobTYwcvzJqhBOtviUG113nXCX5dUlAJKFvCSgIrKOMMqxH4lTmjsIS2tfUrYiEYJlp1JXMEtdyp0Cd6+Yf2FR3o/lLApia2GsN9HmJCujG689AJ+szIAedbJ0eUWV6yHGzciGhF2M7l2YUN5L6FdOd7deb4ncKAvEt/oy++wcyFJNlAkltiCQxHUM5N2DcYJxEKbChp4U4hu5j5QnVdl2SmvlEwQ6XxhY4S6dtu/31aqM5F81fuB99R82nmMMb2GDemsy1bVjNP1D7ggwL2d7v2TFGuiCnBok46yWa6OHTf4L4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBrZUE4pxB0MgXMugbDme0d69TlT13NKc9z+rfL4hVE=;
 b=uPTTwFbyA4CgsUT1Uu3sdgZxSVExCdYiLwJp0iGnR5yRaICSEEDx+wT91uQ8MHflIYXAJJlfi40ojfk4xdw/hFuYS6w8NmsArNOwAIEa6qLOcBlzjIivNy+OZ7Zrwv66p57Oi3q8Jnf3iixIi/Jy6aOlcFQbpc3y+HAu47YK8d56BIpPxKFx4UQWStU666EXvK1PLNfdX/h3TTcVvCdt6WBCKrHzyMolq6XytJ7AOKAnNlXGA05HImYduGQqLB2S98kK+QF2vlWpFKAhownIIKMFKXEz9+JOdUcwcnNh4J9HXjihiupcz8Of0mfAkovnm7B2m1aCYZfqLOE/ZDzKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBrZUE4pxB0MgXMugbDme0d69TlT13NKc9z+rfL4hVE=;
 b=i6c7ySEitWBAhwaCYkSpsvipf0zJ/Eh0zOwaSVrGEt4h/E3ONIL60VOX1h+2uzl6bmukeheDfNq952arYi1AYbK5/fa8n+rU9soz4B7leOG1Q3XgwfDosUyCZAoCv7g+hch7kmP/SBIMJMeHcmlUZQimgxmVPoIpiti1aHuqPXhYeSfw17Oa8ZIk6SdJnpUjR7VsWz71WXwsj44M99wZvcPxf5a58NsqFYIt92qHDu0iawcv86ZPdPUmswNMRD4PW4+eO1m0IZZ6IFk/2/vZp5aULyTzaPz2f9rT7ix1BXf5XwdhXjNVzbAl3YUrTB9sUJ6OwwUZNE99W+B9gjC3qg==
Received: from BYAPR06CA0065.namprd06.prod.outlook.com (2603:10b6:a03:14b::42)
 by EA2PR22MB5067.namprd22.prod.outlook.com (2603:10b6:303:257::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 08:33:34 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:14b:cafe::5) by BYAPR06CA0065.outlook.office365.com
 (2603:10b6:a03:14b::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Thu,
 18 Dec 2025 08:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay2.compute.ge-healthcare.net;
Received: from mkerelay2.compute.ge-healthcare.net (165.85.157.49) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Thu, 18 Dec 2025 08:33:34 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id B09B4F047F;
 Thu, 18 Dec 2025 10:33:31 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
 Stefano Babic <sbabic@nabladev.com>
Subject: [PATCH v1 5/7] video: imx: ipuv3: add names to clk function
 identifiers
Date: Thu, 18 Dec 2025 10:33:24 +0200
Message-Id: <20251218083326.644326-6-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251218083326.644326-1-brian.ruley@gehealthcare.com>
References: <20251218083326.644326-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|EA2PR22MB5067:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3a7e310b-f59e-4358-9bde-08de3e10220a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mUzbHQN0jCNe9ouxqDJjIeWTgRYymiZGN26B7ZHVWi4F/A1+GF8gPO2ibk5/?=
 =?us-ascii?Q?is/VqRIo/82CQo2yPGYovOzL/7qLDMSAwHQhYYk5xNnZKoD1tDdlx059U8Pm?=
 =?us-ascii?Q?kMyvYFrgHfoxdIg5SKa+R8g47XvIPOh7Ummr4WTU607MZM96JldudCcpGjuv?=
 =?us-ascii?Q?vOFGxpEI7bcL1zz4OBuEU//A1C3gbQbQYyiULSWPKk8DtiwoY2l6VjsHY8lU?=
 =?us-ascii?Q?4i0zaL13diNaWlhgnmjW8pSHsp44pcbxThJnhp3s526jXIpkXs/yKcT6SFDP?=
 =?us-ascii?Q?fegaGodODB7nIKNorWITGW+dvMlbPY1WAwUtRtjRzi7o+3S7LjdEbWoqtQp6?=
 =?us-ascii?Q?Q/JmSef1Ar7Z4PEK+Mq9m0sa1zicdGte7gFy7kEs62KbIY5plEBLN8BBQj3K?=
 =?us-ascii?Q?4rR6lf0IHiqj7kkCeqh2cM+vREFGDgfVN/yQqTtdMeS6XjEN6sM8AKhOzXKv?=
 =?us-ascii?Q?mMhpfKjGx1N1FLlUDpBo/0rDnm28NcgfGnrAAb53brCT1LLXYVLV9ABkRfkG?=
 =?us-ascii?Q?sgsWqfzfN62MFQMKERwIWjXbEutXiYTtcEpaPfTUoLjieJeP3UVEiMaTHhRN?=
 =?us-ascii?Q?IsLKrO1f8x4B/cqkEtBXQzHLNmSc3Eaa/kxE8kn/ac3kQJbufIz9L2xYZdm1?=
 =?us-ascii?Q?4T05vXGbhAZlqkLxbCDztQx9KMAO2tCJOaeQuwH+yllTw3D0S7z4xXEEThYT?=
 =?us-ascii?Q?4QPhbZSXxKWK3L0gGRldma30R6bfRdIdgBkzSXZjZf3auN0w0wiFs3ImTNTZ?=
 =?us-ascii?Q?HuaYl1Uh3KYrOjBpl9BVjAhfdIaZ9Fry7vPZsygEJ1MhWy6XaORGbj3DSpv9?=
 =?us-ascii?Q?iANCRcHqUQc2hB7tRCgrt1hP9e0BbrL9i1YvOuhKi7vo09Om9e71W9Z79MyL?=
 =?us-ascii?Q?cvMyjeCQvFe8mOQs0G3kG88IaoKtrPZvJhDCaquk5XO6Bl89lnVnFZ9N8fre?=
 =?us-ascii?Q?deoZtQXYUt2RAre66n42GyxxsY3T+LaXY6YJCiPVT8ue6FkCGYCDbZQBZoJc?=
 =?us-ascii?Q?USly2kB/Kgun4bx3TLGBJhv6NF2+WLixBqzfvjohEm+x8PF16FIjEAbBcO8l?=
 =?us-ascii?Q?QeL40tr4wG+2HgzMyUJBC6dH5NgbmYvUaffr4uU1IrufPLel1lp0Pnm3y2YS?=
 =?us-ascii?Q?gQJeYfAZpsVdrNy/RWnj2+JEUlFgf/5p6/9y6zih6MkVV/Xt7QP/v34dMHfZ?=
 =?us-ascii?Q?iPz8YILS7uqgC3FoW+R3v2XhA+J8QecLEpPoJGPI7cSbYrGf+CWoWQ+QjROG?=
 =?us-ascii?Q?5GOeGjeyU6dZWaprCYlYXXeWoJOHo/ERkeBu009l3YxJWQ+zrBhBziVm5uRd?=
 =?us-ascii?Q?U+TRkdLv0gwh0zAG1Rq69vUYt2CXxI+OllrIW3njngNqMnHI2EN7KEccKSV3?=
 =?us-ascii?Q?uFEW4z8JQTciePii61IgEJL7T6ct/IRWifRdv3XloNMFWYFoFOqHAG0pBK91?=
 =?us-ascii?Q?UbN9lX3SoV9yGKEQ5pPvQIvDjvCzjMCNv6KXoQ1vB9n34jSm7V4nHjYBDbvh?=
 =?us-ascii?Q?IUJaLJ8bKMHSNa6Lo421IqYq/DJ6DohpwIIMrklcgwv/htJzl20yO8ulpRLu?=
 =?us-ascii?Q?odS3GpEsVdDyeGQRnDg=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 08:33:34.2305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7e310b-f59e-4358-9bde-08de3e10220a
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR22MB5067
X-Mailman-Approved-At: Thu, 18 Dec 2025 13:13:44 +0100
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


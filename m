Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9997CA0ECA
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 11:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3774286E2F;
	Tue, 12 Sep 2023 13:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ld9lbiIl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5938F86C8C; Tue, 12 Sep 2023 05:31:11 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DBAB86D76
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 05:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LY5lIEGhc8BwuANd6JR0zLamZ0TcNiLCWIonntqglR/fMRAvNeJRnDHYgWD37h6jAYgDfQIaCIcxt8aHr7bekh3JIc9H8UNs9pGah0lQTT+SO/Z9QEyDcMvSymMj0++pvZEsIg82H/DfybK5m00lt62CSwz9MM3F7O6Vq0wGUonrl3iPfN0qfNWTEzOcB9Sdk1gN1hW83OGR0OC7CkFqgIF/e/r/otRMU9wylsRtXsM516gWdbM8ukSr3XBWTUq75cmcKvZI//1vO0JSRkpAs8DX/QxiFOzygQOMwmtwAPpq8HDU+EO1jawc7ycBQnqQqpTKCCR8I75zlJ2Y+MG25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sf09cc3hB4f2I/EoVZyPwpGjwAHYMh837OmgmdKqSl8=;
 b=BE+/TBffsltBqfOnlMnYkY1h4vuZehQnzT4ahnLFx+0qttExZ6qXVKvdU3QMLojmN61aqZ3CuQ100tjRjBLduitm/vpRX9X9eIg/FjCEila4AYZIKavfR7liPI/de6gc+TIa7YdQac+L+VK1BylmM9l0OyaY5WUI1N/edbGY8wfbLhAot80aDfcvqkCrPVl7h4sRPUOe+DElwbDeRsNAXYbVOnO5xeh1fkoKpe9lXn0UmZSnhMiiCr7CJZ2MovrbEIOkHqmneWJUNvRXCDCPxrGocflHW7nYodTaWl05i8exhT738PdvN9EuA+zIbS0q6d72P5BhODcw8iL6Mofgkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sf09cc3hB4f2I/EoVZyPwpGjwAHYMh837OmgmdKqSl8=;
 b=ld9lbiIl7T/+u6pPRNgt3CiXVXXNpI+6dHYNEjND58x4DQPIIeYP3Hph+0ZSRYdKEqWTKs7pHVO75hRbUKBGdvLIba8KJbsgAt/aGiM3CB0GteVrKa4UaeYd4DYB7jpVpkjjWB2Gzzh1Tx1pteRfmG/Es/4ytb1BLk9pkLtuv74=
Received: from CYZPR02CA0010.namprd02.prod.outlook.com (2603:10b6:930:a1::12)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Tue, 12 Sep
 2023 03:31:05 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:a1:cafe::36) by CYZPR02CA0010.outlook.office365.com
 (2603:10b6:930:a1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Tue, 12 Sep 2023 03:31:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Tue, 12 Sep 2023 03:31:04 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 22:31:03 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 11 Sep 2023 22:31:02 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] clk: versal: Fix the function versal_clock_ref
Date: Tue, 12 Sep 2023 09:00:55 +0530
Message-ID: <20230912033055.2549-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SN7PR12MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 056606ea-0f1f-4ed6-ab44-08dbb340b1d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: StVyBF7+k5rQg8tyoXvPJOYfuRHkgp4GaImn/IsZWk+BbFi8t4vEuIx2iyg3r861uYE4RyozCF/7K2YXYZTadD6mwHGzcMvyRvp5gSl6dS9M7p6+b4WXwDzjuY9gCFAFRw+YoX4gCx15+wuUCuK/eSSXm4EfyLlHevBIHAW4rpBb4S/NKQiu0qFaxI3ynrtzlgmmog9kSTFHSVzvT9aHAko4+E808OgSafYg0I94C44UEol/+lJp7H1Biu4U8ZDIYVmAjjhUFMQ8im+QkImf9PSOl5mCj9VLsWBnga90nOSC5Xmz9COkWidRPw8olEyu+6Tm6i4r+i1skIwX8yqwtR9wE4w7xRFf5ifkDvfxfNhWZMWrNYhfNCbIicTnZosYzPxK5YdoxRgTIG3tk4paW4D6uX0PFYljLZU1ZWWiwxkZMWF51ZV1jgbxV2Cv+mMhw5gU06eA+tWITMeoh0J/yn+ZYCkfGwBDCy7LA+d8IkwCkx0fgAnu+jTbfsqJskv4iNusNJBROinqwPa7L3/eoqnAuV9aaxOPvYYacEoGunnjZYZcMyJYQra+T37rbCn5lLpb5RmPvOOvtuAYPLnrSwMeY4uT/UOV5fXgN5cBVfgqLQxjHEmHCoQgPU81KYjnJFXzFJdBpTJUwTJXkl/ATC+mxZU/8YDe8GynzITDLjcFnMjVsHHYH9jDli6q3SscsjThPVEYiLbJHQopydRbgKS9zxPujh6pQcJsZgCcb2eRLo/VB3PAGm+OmYyPJM+VfaOEgXZu0z+sbRZiWu+wyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(186009)(451199024)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(81166007)(86362001)(36756003)(6666004)(40480700001)(1076003)(2616005)(478600001)(5660300002)(54906003)(6916009)(70586007)(316002)(70206006)(41300700001)(426003)(26005)(336012)(8936002)(8676002)(4326008)(47076005)(107886003)(356005)(82740400003)(40460700003)(83380400001)(36860700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 03:31:04.5009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 056606ea-0f1f-4ed6-ab44-08dbb340b1d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321
X-Mailman-Approved-At: Tue, 12 Sep 2023 13:24:28 +0200
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

For reference clocks, PM_CLK_GET_PARENT call is not allowed.
PM_CLK_GET_PARENT only allowed for MUX clocks. Rename the
versal_clock_ref() with versal_clock_get_ref_rate() for better
readability. Fix the versal_clock_get_ref_rate function by
passing the parent_id, and check whether the parent_id
belongs to ref_clk or pl_alt_ref_clk.
Also adding the function versal_clock_get_fixed_factor_rate()
if the clk_id belongs to the fixed factor clock.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/clk/clk_versal.c | 98 ++++++++++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
index b3b3333123..2e004beca2 100644
--- a/drivers/clk/clk_versal.c
+++ b/drivers/clk/clk_versal.c
@@ -68,6 +68,13 @@
 #define CLOCK_NODE_TYPE_DIV	4
 #define CLOCK_NODE_TYPE_GATE	6
 
+#define PM_CLK_REF_CLK		(0x830c06aU)
+#define PM_CLK_PL_ALT_REF_CLK	(0x830c06bU)
+#define PM_CLK_MUXED_IRO	(0x830c06cU)
+#define PM_CLK_EMIO		(0x830c071U)
+
+#define TOPOLOGY_TYPE_FIXEDFACTOR	0x3
+
 enum clk_type {
 	CLK_TYPE_OUTPUT,
 	CLK_TYPE_EXTERNAL,
@@ -365,48 +372,37 @@ static u32 versal_clock_set_div(u32 clk_id, u32 div)
 	return div;
 }
 
-static u64 versal_clock_ref(u32 clk_id)
+static u64 versal_clock_get_ref_rate(u32 clk_id)
 {
-	u32 ret_payload[PAYLOAD_ARG_CNT];
-	int ref;
-
-	xilinx_pm_request(PM_CLOCK_GETPARENT, clk_id, 0, 0, 0, ret_payload);
-	ref = ret_payload[0];
-	if (!(ref & 1))
+	if (clk_id == PM_CLK_REF_CLK || clk_id == PM_CLK_MUXED_IRO || clk_id == PM_CLK_EMIO)
 		return ref_clk;
-	if (ref & 2)
+	else if (clk_id == PM_CLK_PL_ALT_REF_CLK)
 		return pl_alt_ref_clk;
-	return 0;
+	else
+		return 0;
 }
 
-static u64 versal_clock_get_pll_rate(u32 clk_id)
+static int versal_clock_get_fixed_factor_rate(u32 clock_id, u32 parent_id)
 {
+	struct versal_pm_query_data qdata = {0};
 	u32 ret_payload[PAYLOAD_ARG_CNT];
-	u32 fbdiv;
-	u32 res;
-	u32 frac;
-	u64 freq;
-	u32 parent_rate, parent_id;
-	u32 id = clk_id & 0xFFF;
+	u32 mult, div;
+	u32 parent_rate;
+	int ret;
 
-	xilinx_pm_request(PM_CLOCK_GETSTATE, clk_id, 0, 0, 0, ret_payload);
-	res = ret_payload[1];
-	if (!res) {
-		printf("0%x PLL not enabled\n", clk_id);
-		return 0;
-	}
+	qdata.qid = PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS;
+	qdata.arg1 = clock_id;
 
-	parent_id = clock[clock[id].parent[0].id].clk_id;
-	parent_rate = versal_clock_ref(parent_id);
+	ret = versal_pm_query(qdata, ret_payload);
+	if (ret)
+		return ret;
 
-	xilinx_pm_request(PM_CLOCK_GETDIVIDER, clk_id, 0, 0, 0, ret_payload);
-	fbdiv = ret_payload[1];
-	xilinx_pm_request(PM_CLOCK_PLL_GETPARAM, clk_id, 2, 0, 0, ret_payload);
-	frac = ret_payload[1];
+	mult = ret_payload[1];
+	div = ret_payload[2];
 
-	freq = (fbdiv * parent_rate) >> (1 << frac);
+	parent_rate = versal_clock_get_ref_rate(parent_id);
+	return parent_rate * mult / div;
 
-	return freq;
 }
 
 static u32 versal_clock_mux(u32 clk_id)
@@ -437,6 +433,37 @@ static u32 versal_clock_get_parentid(u32 clk_id)
 	return clock[clock[id].parent[parent_id].id].clk_id;
 }
 
+static u64 versal_clock_get_pll_rate(u32 clk_id)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	u32 fbdiv;
+	u32 res;
+	u32 frac;
+	u64 freq;
+	u32 parent_rate, parent_id, parent_ref_clk_id;
+	u32 id = clk_id & 0xFFF;
+
+	xilinx_pm_request(PM_CLOCK_GETSTATE, clk_id, 0, 0, 0, ret_payload);
+	res = ret_payload[1];
+	if (!res) {
+		printf("0%x PLL not enabled\n", clk_id);
+		return 0;
+	}
+
+	parent_id = clock[clock[id].parent[0].id].clk_id;
+	parent_ref_clk_id = versal_clock_get_parentid(parent_id);
+	parent_rate = versal_clock_get_ref_rate(parent_ref_clk_id);
+
+	xilinx_pm_request(PM_CLOCK_GETDIVIDER, clk_id, 0, 0, 0, ret_payload);
+	fbdiv = ret_payload[1];
+	xilinx_pm_request(PM_CLOCK_PLL_GETPARAM, clk_id, 2, 0, 0, ret_payload);
+	frac = ret_payload[1];
+
+	freq = (fbdiv * parent_rate) >> (1 << frac);
+
+	return freq;
+}
+
 static u32 versal_clock_gate(u32 clk_id)
 {
 	u32 id = clk_id & 0xFFF;
@@ -479,14 +506,19 @@ static u64 versal_clock_calc(u32 clk_id)
 	u32 parent_id;
 	u64 clk_rate;
 	u32 div;
+	struct clock_topology topology;
 
 	if (versal_clock_pll(clk_id, &clk_rate))
 		return clk_rate;
 
 	parent_id = versal_clock_get_parentid(clk_id);
 	if (((parent_id >> NODE_SUBCLASS_SHIFT) &
-	     NODE_CLASS_MASK) == NODE_SUBCLASS_CLOCK_REF)
-		return versal_clock_ref(clk_id);
+	     NODE_CLASS_MASK) == NODE_SUBCLASS_CLOCK_REF) {
+		topology = clock[clk_id & 0x3FF].node[0];
+		if (topology.type == TOPOLOGY_TYPE_FIXEDFACTOR)
+			return versal_clock_get_fixed_factor_rate(clk_id, parent_id);
+		return versal_clock_get_ref_rate(parent_id);
+	}
 
 	if (!parent_id)
 		return 0;
@@ -505,7 +537,7 @@ static int versal_clock_get_rate(u32 clk_id, u64 *clk_rate)
 {
 	if (((clk_id >>  NODE_SUBCLASS_SHIFT) &
 	     NODE_CLASS_MASK) == NODE_SUBCLASS_CLOCK_REF)
-		*clk_rate = versal_clock_ref(clk_id);
+		*clk_rate = versal_clock_get_ref_rate(clk_id);
 
 	if (versal_clock_pll(clk_id, clk_rate))
 		return 0;
-- 
2.17.1


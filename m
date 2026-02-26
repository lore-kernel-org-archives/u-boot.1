Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E767EFCE064
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 12:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0874683AA9;
	Thu, 26 Feb 2026 13:25:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U+Wapu7x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D8B783EC9; Thu, 26 Feb 2026 13:25:23 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38CEA83642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 13:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0eUqq7ITMjBGOz1OVmAlyuqPjkhrfI9E3TGEyqxIx81Dc6CVO+bqVxFrNBudABCS04SngB3RLKOX3GwlHAdjWPwpsvsr9N8cUlbEnvuF4OpWK7mADib5aSplkY/Rq1tInPbCp5IZV0JKKBf/Zn3dkNxkcn0uJHkjvL8oXcKIPj4W6VDGarZFreQ7MgGhJzYctr1y5kIE0GxViS9KlvvesSx7azNEx+5ypQ4rWAvBhi276y+M4/GO/mMn6tlT3ebzbblRvTI+MskvNeCH7Mr7MHNqhuqfo/bliK0Np3PASm7KOq6qdWjR9DpILgyiFNZe+SWeTbEYjzkIkOUPSJyhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPJAC+wkfn5GXpi+MzGwCtE7M/IXH3k2DtwyyTZdYJ0=;
 b=Mr8V10ydu24T4JQgCW0geVUTTciXVbzdfWWkb80jnFvW9JriexPFZbtWTRC9dr1eSSPfud2XvfT8OKuZYoTej6D1volIsWdjNZGXtk4B2HUxZ3g5rmX69A1GvBWDOL8WZI+Wfwc9U7mB2w52NyM4WGcmlZhJoulOsfrcACc/K32dtequk5ppk+cWscrEydzKLseYeUJLNTka6aT/ZGmO+p/sivaMVc5z+qcQXzNLzq0FD20CITXVLIm4tozw4HhlXfyQc2XJ+BxQ6mNbdoT6iLpCfKwTq70tKB5WtToCIkPxxIadmoAXO5hX94Go2QJro/wsMlQSQ1zDvY8VVrInQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPJAC+wkfn5GXpi+MzGwCtE7M/IXH3k2DtwyyTZdYJ0=;
 b=U+Wapu7x1zJprPpDej8tl2sB3fRrH/DrHmUG0Xqp0VJXBM2J8RMAQZoxQeXlo90AY79+mgFFWD0xdxZlXouW35sPYtBrbUXOj7slJdCXDuj3IuQ0Ouyhp6YWpAPjG2tfWtTiOAdfUcYOdn4mbnelkHQtKzbl7/ux0eTosdkzFlk=
Received: from SJ0PR13CA0162.namprd13.prod.outlook.com (2603:10b6:a03:2c7::17)
 by LV3PR10MB7770.namprd10.prod.outlook.com (2603:10b6:408:1bb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 12:25:16 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::c7) by SJ0PR13CA0162.outlook.office365.com
 (2603:10b6:a03:2c7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Thu,
 26 Feb 2026 12:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 12:25:15 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 06:25:14 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 06:25:14 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Feb 2026 06:25:14 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61QCP8Rd2348372;
 Thu, 26 Feb 2026 06:25:12 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <bb@ti.com>, <reatmon@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>, 
 <gehariprasath@ti.com>, <s-k6@ti.com>, <n-francis@ti.com>
Subject: [RESEND PATCH v2 1/2] configs: k3_*: Add config fragments for
 enabling inline ECC and/or BIST
Date: Thu, 26 Feb 2026 17:55:07 +0530
Message-ID: <20260226122508.2269682-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226122508.2269682-1-n-francis@ti.com>
References: <20260226122508.2269682-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|LV3PR10MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e3e484-4879-46a3-d614-08de753218e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|34020700016|82310400026; 
X-Microsoft-Antispam-Message-Info: +A90p9NqvgVT/g4gqnZBj5WfxceNAu9aX4uYZgCVt0IZpIlEDFtwdeLNl4qMNMPgbbFT532x9ms346S/vrUkBhRrR0b/ZWq9zkjeR41YzIDdylfxAGNJs+TGjtL2XEh2L0kSA10UgsZpeUfAHGCvNsV4ZxCf7YjYvyp4Z+91zncxuSVg0K0e4d1hoE3uX1ySILqP71lk64DD2NHLG66ZdRek1Jo6B33UZQXffbHZZunBbGv6wMrsop5Gwo70QxBvzNuiGWxoNoGFqh6WPVnhxmq/W20antCJBHs6HOrpe9Q/98xJBAFNX6TTQKO0swfHf95lVnIP9T6YgHjjrLZ7w4ktYTFxMzFEhxwsx6g+eQg6OlID3V5nBguGBt8D2npgW/bOQCcahtqOR6rWqg/mDjVWz78w7BOjFTkEVhAE5CNIgTY23SwS3qxCdWurQnA3Azt389pvS8BA3sefIH07zU0dI0WUj6EjgTLzS6rXFkzFGLyhffW/UEc7XMeRDiM947DQVvgkCOauRi2E1CfhXZhqiRWOgEHp3zcfsp3YDY802/HMqsks3CIWHxAw8dcPDFxJuNPrP7CPy2vrja5szVarGdI88YxSY028bcEwIol8tOdfUlW4degR0W6bbJ9aUq3gquv9HaCkCta+iHy+4iMdTYEcDR+IL8gPIwHugC+CLvDPbNqwjoTGU9yUYKx0sdgP31ppKIX6iSelddnE6PmSrJCO9gztTmraQUjRXkNKn6/ljmM/MPia3NU/mPF5cGgyiqBUJBkilQys02BMsfx/s/q4/r+NppGepST9CNvAT5bRVOLPkMPj5QpezjBEldL1XgxKuu7CC1Qslox2Kg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(34020700016)(82310400026);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WHwU8Yb5vHQ6e508XZiMk4HDm6k3EkMOsI5VYfSUd6NbPTAo8pVwi6LipuImCzNxX8bUxHhJWZE/O8fft7Enx1B+3q+bhCyXYvf9VS6YMyIHUucPV+jKmYPMl2it8xW6rWQJu+mD7ArE2nSbWG8GJ2oPJvnn6vw9IfSZjr/5xtMdJCafv2ttu2wgh/LkvHwKgKcUSWp9SuTzv+xrNGX16nTE87CRscM6d+4sXa9TwtauVDctoboOoJX4y6qdiXaqUyQye+wEMAxpTZkrMpG890SjSmrwYQm3AmURlFaXrRpR8144ZvtRMlWxIyHY/Xw57yUh2rwtWHfEFG4DgwUUYm7wuSGsZouTA1cvElbkImA2EPy6fVj4tQ9aukjTCl0EOklsfmz6khPgAN3QJESndW0XrZOPW1AmEPA8SBftyR8CaIAQqWJdDOYdxS38xHif
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 12:25:15.8231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e3e484-4879-46a3-d614-08de753218e3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7770
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

Add config fragment support for enabling inline ECC and/or BIST on TI K3
supported platforms.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Changes since v1:
- move from configs/ to board/ti/common

 board/ti/common/k3_bist.config       | 1 +
 board/ti/common/k3_inline_ecc.config | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 board/ti/common/k3_bist.config
 create mode 100644 board/ti/common/k3_inline_ecc.config

diff --git a/board/ti/common/k3_bist.config b/board/ti/common/k3_bist.config
new file mode 100644
index 00000000000..671dda1a9dc
--- /dev/null
+++ b/board/ti/common/k3_bist.config
@@ -0,0 +1 @@
+CONFIG_K3_BIST=y
diff --git a/board/ti/common/k3_inline_ecc.config b/board/ti/common/k3_inline_ecc.config
new file mode 100644
index 00000000000..143c814b41c
--- /dev/null
+++ b/board/ti/common/k3_inline_ecc.config
@@ -0,0 +1 @@
+CONFIG_K3_INLINE_ECC=y
-- 
2.34.1


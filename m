Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC2CC02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 08:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AADD680562;
	Tue,  4 Feb 2025 09:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O373iAXO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC3CE805E7; Tue,  4 Feb 2025 09:53:57 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9349080285
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 09:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMaRHYjWKHWLQSIcYhvBOt9q1shqWLuMkXM+vlpaLWgwDLz6K0aI4Wo0dxzlFi8n9eOzW709HL3mj5qNLkofceHcyO6yWMnM+v8aOHxi1ah/TqL+KA/LTOXuXFH91VbItpKuD4d8ohimmRvmPTmxIscNAjG3dRqMStdei0Ipn1hCaTiIjD7GjMNhtSaLmwtCxd7Zppo6s/GO1pfLyIvvkXK22HjxRWzdE/SA0zFg604woMWqeuXRF/OI6rOUhZ0maSGO3AMtlzQGvV4eN5LseQl5vqzwdvPNDqJTNn8d7+oLIdZtQwuq+yuDz215R0gcv6UoKPhlXiL6Xe8KoskyfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjnITrx36iSjl0s5syPxZacIhQqcF9PsEVEMXyOicdY=;
 b=DUUiXV3CRIy1+eSJXZt/1+9sPJcpfz06UEmgtO81C64TEwsWLfA+4PQAyJCQWMfzOS2sIVhbspRL8hf0q5qdi6tKw5mNme0d7Vfa58Au71jPKtqgGIn8wG+HEmqv8MXPs7w1qUksuOnY59OqQdUpQeZXYrH7CoIeuWuosrEBI1P1sxLsSyHCR4JHNfJVHyChODreTkzIvSpN8U4FIABnqEn4LJs8C9k/doxIxiPicIHDqegPWVDbgZiw3XALrdI+o1OMiaAu8yW1nheA0nBYVgCab7cLUgX3gffaoD6j75b3de1/TqnW50/lL98e1PwgfCLlhiElaPgCArT+No2iAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjnITrx36iSjl0s5syPxZacIhQqcF9PsEVEMXyOicdY=;
 b=O373iAXO2j8enWYtsVaCNahHX6wpRK6+PSnjrxQAyF1SqfDe9rNkiPlMhUQ3Dhh00JobZpHrvnA+KR4ZsKSqIYO6HmzwWnfXRDN8fjXTpXlkpkLHPWYSuqW8CvSdcJhgSrEiRqs/Du3uLcM3QUd+c/sIQmHKtdgFQufeA6TGVng=
Received: from DM6PR14CA0038.namprd14.prod.outlook.com (2603:10b6:5:18f::15)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 08:53:49 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:18f:cafe::c0) by DM6PR14CA0038.outlook.office365.com
 (2603:10b6:5:18f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Tue,
 4 Feb 2025 08:53:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 08:53:49 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 02:53:47 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/3] arm64: zynqmp: Fix TEE loading address and add hash
Date: Tue, 4 Feb 2025 09:53:39 +0100
Message-ID: <4e7e3a7110acc050ea7c06ac661e5b5be46e8602.1738659214.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738659214.git.michal.simek@amd.com>
References: <cover.1738659214.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2014; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=jbwwnMl0RqLgx3X5nsD3wMYV/f5++Ttp8m2MNy5x0Nw=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvSFVydPcb1TfyOr1nB1fM4Cq0q9GqUG5ZudB14lcgrts
 vV5mTK1I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzkzhWGecbzPTqqX4rkaO17
 e8DIrX6udjEbP8P8wjN5Mtmb2l9/lTx/WsTtpLvC8z/TAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd549fa-a2ce-4f93-bb48-08dd44f97181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KDFbkt6oZAm7gyejgZIxMNztSXA6IJ+dgFhaYir12+d+OFduWDvFwjihaizB?=
 =?us-ascii?Q?3rD1cmbzkmFMSMSZq9yP33IOQRnwJthWtufg4RzDmVimkdIn8Mtlug/gVi5X?=
 =?us-ascii?Q?VhyYhq6ocuYovyhsn0htyRm7u7M1nMkAJfTu5WgcNjSK1zewEOkxGDdgvPUB?=
 =?us-ascii?Q?SLya+BAMUXIElWTGl2GU2+XdUTStOFg/C8nnUlvPG9JuoUnLO8hnkEgBQBaI?=
 =?us-ascii?Q?EO9MaTEQFTQr1GHGXazjV1s0BP/06yEZ+h9hyoP2YJseXGcKbbjf/zQatwDD?=
 =?us-ascii?Q?XAtNBjbGHS7mXx5VovNRJl7ULSuVg763bRtYaovaprDidDjFvVQRfBCcbFMu?=
 =?us-ascii?Q?MoZsM1pS9P+Y6buplZfw6BQBaCQmz33N2Im+msKmTIdbTbj73JtRBQlB31t+?=
 =?us-ascii?Q?azMGfJiTC5ZsgK3FgtQLcyFNX2TlKhtKO6S3bBrqCwb8BYozZcOBpKhmsPHu?=
 =?us-ascii?Q?NqF2FUb5KzAb41C/QkFtt0OVPbwR9//xAGWPUxW52O6NbmgcM/HsnXM2HFW8?=
 =?us-ascii?Q?q88OdvYpzX2lXUvhzSTO2xTCm7I9yDrHjEuMIsjZu6G0Yo6+bBSeyBI19xey?=
 =?us-ascii?Q?4jUAOUrLFPwBa0TnU5pPStvpO4y8yUAIC3cs2rnRFYchkxqFbEi11f2KTo8j?=
 =?us-ascii?Q?nhT9dW6lXcOE0JbOFnpLkBzofSmUJnDlrhZXPTNer82Gio/CLmk81xuOnLia?=
 =?us-ascii?Q?C79PxPAMkQRrl3/4Tmx1d6kb2ZV/gokrsOfcH/c0fXbpI2UMCZ3kb4kb8xO1?=
 =?us-ascii?Q?tb+WxrbUsIETtgLAUsFPxSlekFEE9fU80cPOWsYyoigyPCLpFw+stSIjSQRY?=
 =?us-ascii?Q?2Vrd/0WI4nfeH52rSEnXPkaG4/UGHhKRNVc1Abmm/knNZfy6lKXbBajb9iLn?=
 =?us-ascii?Q?ISSNNfj3OHYNsUoR5FlgfhS+wknLmmFq8y/li6dq2yP6gDGFw4dc/hS5hILu?=
 =?us-ascii?Q?2lacWEovvRIGX5KDn2FFSTiYr8zfa9gfBRwF6cxmD3v73vpCp5t1VQZFmK8F?=
 =?us-ascii?Q?9ZV3nYA5OAWMD6gZzZ7RIyjMpZCOTNLuFBKL2hCbUPCEWSWQfhqSiJD4JP9s?=
 =?us-ascii?Q?bb1+jHfpm5PCevgLbridLMV3Id9qx0gZtL7490wjqOp1itmh+IFu17A8ZTxV?=
 =?us-ascii?Q?F64Fm2Lpc9j0VR1IkTg4tct5L22VJOtsr/AQQKRsqIScrSExcuxacZPD8fhR?=
 =?us-ascii?Q?duki4Oj3lMfX3O2ntyd6/uhH3s9LgyL8LGrgjvhP4CItkBX6DfiPuYiC0Ljh?=
 =?us-ascii?Q?9d1XldtSbgemu3E8PPCXY46rYti4O4Gs9hGsFpgwwYLb8vcK2FF654Di7w3K?=
 =?us-ascii?Q?ngxVu7AsTtyNL5AB+uggo2buB6Rp7yqNQj6JyyotZypBxlIQ6xxSFVWF9etB?=
 =?us-ascii?Q?65OG6A4I67aTQi74KAwLkhOdIfYzsldMqG0RATVK7XhP1sHrL359AOzU8z60?=
 =?us-ascii?Q?zm6GeAeASfJl36VVWadctL1gDafDof90jUYrQu1+JF/8rU9hmF1ThYB1dP04?=
 =?us-ascii?Q?OS3Otmz/2I+ov7Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 08:53:49.7257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd549fa-a2ce-4f93-bb48-08dd44f97181
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819
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

There is incorrect loading address listed for TEE.
CONFIG_BL32_LOAD_ADDR should be used.
Also there is missing hash for this entry which is present for other nodes.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v1)

 arch/arm/dts/zynqmp-binman-som.dts |  7 +++++--
 arch/arm/dts/zynqmp-binman.dts     | 14 ++++++++++----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/zynqmp-binman-som.dts b/arch/arm/dts/zynqmp-binman-som.dts
index 3ffa06f0c04f..a697c2c1945c 100644
--- a/arch/arm/dts/zynqmp-binman-som.dts
+++ b/arch/arm/dts/zynqmp-binman-som.dts
@@ -148,8 +148,11 @@
 						arch = "arm64";
 						compression = "none";
 						os = "tee";
-						load = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
-						entry = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
+						load = /bits/ 64 <CONFIG_BL32_LOAD_ADDR>;
+						entry = /bits/ 64 <CONFIG_BL32_LOAD_ADDR>;
+						hash {
+							algo = "md5";
+						};
 						tee-os {
 							optional;
 						};
diff --git a/arch/arm/dts/zynqmp-binman.dts b/arch/arm/dts/zynqmp-binman.dts
index bf3335a3e539..458387161c35 100644
--- a/arch/arm/dts/zynqmp-binman.dts
+++ b/arch/arm/dts/zynqmp-binman.dts
@@ -61,8 +61,11 @@
 						arch = "arm64";
 						compression = "none";
 						os = "tee";
-						load = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
-						entry = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
+						load = /bits/ 64 <CONFIG_BL32_LOAD_ADDR>;
+						entry = /bits/ 64 <CONFIG_BL32_LOAD_ADDR>;
+						hash {
+							algo = "md5";
+						};
 						tee-os {
 							optional;
 						};
@@ -135,8 +138,11 @@
 						arch = "arm64";
 						compression = "none";
 						os = "tee";
-						load = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
-						entry = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
+						load = /bits/ 64 <CONFIG_BL32_LOAD_ADDR>;
+						entry = /bits/ 64 <CONFIG_BL32_LOAD_ADDR>;
+						hash {
+							algo = "md5";
+						};
 						tee-os {
 							optional;
 						};
-- 
2.43.0


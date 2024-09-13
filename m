Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C79BFA3736
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF3B08898B;
	Fri, 13 Sep 2024 11:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T+sqEUOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1954C8898B; Fri, 13 Sep 2024 11:29:13 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F2A0889C5
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyM0/0KsMcnkf1cGNkrcZoVzCl7BqYtQQTZqpPsOS0XcA9Sgl+yy4UhfH+FAdNqEEMVc+uInPyX2Hz14QQ5Dk8j8VLH4KpCq1CiE6N3JT+9Bzdh0tXFBujwsr3EgzX4zuHzeEN7vU+MUnNbmH2VWB5AyNl3WzdyvFxEHwe86KaSANVwhDb43NZrmcMNkSJYmHqlk3vrmS9eR3F/nUhj1Lq/jOzceE0doOzMpzmxRaCXNRKoZUPIs08dvkZFaiPxK6H6CKrYoPkzr0rV0BCodgUF3dwvWvzKpkvE1PJFGDkdDZoFUOAeEsdV5oe90plSiHRiW+bUwXnnWurCh/K+r+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/URuVS2ALrIrDx2lZ/5fJ+O3yrmRmMVTyrDZhBq/II=;
 b=X5DCB7gsu9ey5KO9h3OYJwmrATbJqrIlMPtQdinlO9/9zsIudZe4DwSKk+eZ1IS9C3jH9CKB32XT1L0UQDKin6mUEW1tmC5Ov5ex7LZVJSYpPIx6Xp3Pj5UAjlJf8EfJuJpAzwMjewtieGXqSPQyHWL/1+S5J8n7XZ10h0bCS984UlQZPTUda7+Bd6cwRByXTyYevHcAgLlB0dhvm7qI7acutszEaZYek1pqtgfPhGqmSFvtTD4O7DV3CnG56D2GPcFHBYzDKaPKYT2IxUEBkaYTmtc4+lvOH8bPakssg3GPywsu0VmpLHBKhk0l1/Q/Vlvo2vFLN91QwmgsmyFL+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/URuVS2ALrIrDx2lZ/5fJ+O3yrmRmMVTyrDZhBq/II=;
 b=T+sqEUODOFjQTMpiiuai2PBq081bWinjqe/3sgXQ4/G7YRC28ABOpjLM00HB7zftBkc2aTHX5Vkp+w3TLTGaYsu6YfuY965cA8o5vRK2NqJM4//NEbNx4pVEyQwrO659l6ABgIspCoYpY0L1T+g+WVmOLYM9eZp2PcDc+zjtGD8=
Received: from SN6PR05CA0026.namprd05.prod.outlook.com (2603:10b6:805:de::39)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Fri, 13 Sep
 2024 09:29:00 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::dd) by SN6PR05CA0026.outlook.office365.com
 (2603:10b6:805:de::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Fri, 13 Sep 2024 09:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 09:29:00 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 04:28:58 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 02/10] arm64: zynqmp: Align gpio hogs with dt-schema
Date: Fri, 13 Sep 2024 11:28:43 +0200
Message-ID: <112e36e2578c84f30c3c038440405069671d2853.1726219714.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726219714.git.michal.simek@amd.com>
References: <cover.1726219714.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10553; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=kPXL29kp5ZWX6T9zjraNDuvaUCzT5/OkFejHPzGxJEM=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQnrGdWKIdkRa9wnx/3fvcFHp4dV03e79zDu23rRSFJ5
 ci8XXd1O2JZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBE2AQY5nC2me/7d6jaI6+N
 72tYs1xLbPjOUob5wTz2131m+AlfOrXs0mRraf89GqECAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: db2c597b-f3de-4339-6287-08dcd3d68033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?57RMekpNEJoHX0ANzc1BDowgkNp/i8I5sX2//U4o5zq4WhQFUaWvdpu+nnLd?=
 =?us-ascii?Q?Bv4+JFph8Pln8fZVK64D1ezTjK4iHZqbWT6kaN18gLSGHSyz3AbXDA2rXe+S?=
 =?us-ascii?Q?2+Je0p+x3gryu3M5xxF4BSn1Acxi+RGnclewZw5aLy+3QJc+66rjNBrZ0fwQ?=
 =?us-ascii?Q?N4R6zPXte6kxX0+ICZVIl11hFpmtDCH80TVEgb28t4z8RgrY7Xi5VRPY65HG?=
 =?us-ascii?Q?A+pa6L/5I8DwA6stmJtZwb2ZjUEVBxu7qcLFc/Abj2ZLOiGYYSBp6tQGDiHt?=
 =?us-ascii?Q?qxesdvZnpfk/QAaaIjZ0oCcmrS5tw4xpIuEYVewkoNqf6YR+Sp64YEtL1ZJo?=
 =?us-ascii?Q?vDsZTcx/7sKyAvVT/IdeEGRspgzh8JdOTUYIfL/PD7i2BKqS839bz7f7LRLc?=
 =?us-ascii?Q?DJJvQkm0ZidPxrGQvDna2WPYnVATBQPs6cjFcPnA9S9pOkiFBuvPXY2PmOk+?=
 =?us-ascii?Q?SseShgtDPmCW+ncxIjU0NNwODWCFJJIDM/Em95YA0OypWC8B5ZL6sMarUeex?=
 =?us-ascii?Q?s9XfQNAFJkEQDameX63pLccx2T8YYMlW1aNHng5T7WXA4ywQCle6TGMTYAlC?=
 =?us-ascii?Q?LZ4x2c9RYvR8AX3ePbDXyZW6/Mgsww7B9YU97jhWdyKVgb7O9MGF80gTk6ze?=
 =?us-ascii?Q?ypxMo2KCMJAk9n5iIatWt8MbE7d+9gUv4EcHgOZYI2fcihpOV5KeZZNI4w3L?=
 =?us-ascii?Q?duGM8eXCnHDhIuisDl05bLDKvxv4jenv0BfI71z2AuAPpLQtH07S2KGOzEKg?=
 =?us-ascii?Q?9q0WvPBd+Poh33cLzGcrxufinovTTLeQZ7uScgX9ObvKZXRr073hK6zOcdME?=
 =?us-ascii?Q?TMFBrRt1ETGDW0i00MjLL5IjUfA/D0YYtqf/tY93+Vt8dRO2+FInnumC9AGY?=
 =?us-ascii?Q?VDwdf+ic5eBa/63YRB7ZFPrBcIvy8nMtA/gCW4R6IaErCghGjWozXJ3QAiV5?=
 =?us-ascii?Q?6NsNAMzR2xZFrgQSNUy/TIB4ps8eRlGeIxuTV9fPu9bfTwvV778+aMSTdbwE?=
 =?us-ascii?Q?Ede0PY/ZfO/g54FEx2t93f192EyB6wsHK5KlBhTMpJw/8iatLoGSCpsto9fo?=
 =?us-ascii?Q?BQFB8MF9OCDbpE0YdEXS6OKsXOfHQGPbo5OV4VbdsWCtZT/RaeVvsZfbGAWG?=
 =?us-ascii?Q?stSKWoHK4jMVi+0FVCYHhuItINj3Fs2a8B7Yg7JtdUItK+K2OCmShN/dhiUD?=
 =?us-ascii?Q?J8hDrxgS+eZvJSehHmJ5yGBjd/eyjM3ptNlvdfe44S1U3xNHr9rWpXyvJBwH?=
 =?us-ascii?Q?CF9EsoAQ8Sy15WUOu+2M0YySuC1YbC2C3MKumqKzUEo1UKbWdFIzNW9O8GJA?=
 =?us-ascii?Q?M0FnSE84/FHY7Yu1ySsLsWDrZe7Seyd2AeHSrdm+RNllrnGsS0wj1Iwm3min?=
 =?us-ascii?Q?GcxN0MUdloGOju5UDGU3reZzOgw3x75EAZvC6bD3orDxN9x1WLrZPq1smKr5?=
 =?us-ascii?Q?HVYEfmCdY/I3+QEMg+X3iutJ0a+XZuJp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:29:00.6299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db2c597b-f3de-4339-6287-08dcd3d68033
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
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

As was done in past for zcu102 append -hog to node name to pass dt-schema.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-m-a2197-01-revA.dts                | 8 ++++----
 arch/arm/dts/zynqmp-m-a2197-02-revA.dts                | 8 ++++----
 arch/arm/dts/zynqmp-m-a2197-03-revA.dts                | 8 ++++----
 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso | 8 ++++----
 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso | 8 ++++----
 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso | 8 ++++----
 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso | 8 ++++----
 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso | 8 ++++----
 arch/arm/dts/zynqmp-p-a2197-00-revA.dts                | 8 ++++----
 arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso         | 8 ++++----
 10 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
index 38be5a0f96f1..f9299edca82f 100644
--- a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
@@ -365,25 +365,25 @@
 				#gpio-cells = <2>;
 				gpio-line-names = "sw4_1", "sw4_2", "sw4_3", "sw4_4",
 						  "", "", "", "";
-				gtr-sel0 {
+				gtr-sel0-hog {
 					gpio-hog;
 					gpios = <0 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_1";
 				};
-				gtr-sel1 {
+				gtr-sel1-hog {
 					gpio-hog;
 					gpios = <1 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_2";
 				};
-				gtr-sel2 {
+				gtr-sel2-hog {
 					gpio-hog;
 					gpios = <2 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_3";
 				};
-				gtr-sel3 {
+				gtr-sel3-hog {
 					gpio-hog;
 					gpios = <3 0>;
 					input; /* FIXME add meaning */
diff --git a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
index 3c04da1c5fbe..0f61eca3e9cb 100644
--- a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
@@ -367,25 +367,25 @@
 				#gpio-cells = <2>;
 				gpio-line-names = "sw4_1", "sw4_2", "sw4_3", "sw4_4",
 						  "", "", "", "";
-				gtr-sel0 {
+				gtr-sel0-hog {
 					gpio-hog;
 					gpios = <0 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_1";
 				};
-				gtr-sel1 {
+				gtr-sel1-hog {
 					gpio-hog;
 					gpios = <1 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_2";
 				};
-				gtr-sel2 {
+				gtr-sel2-hog {
 					gpio-hog;
 					gpios = <2 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_3";
 				};
-				gtr-sel3 {
+				gtr-sel3-hog {
 					gpio-hog;
 					gpios = <3 0>;
 					input; /* FIXME add meaning */
diff --git a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
index 7439a2f872e5..19f294167f61 100644
--- a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
@@ -361,25 +361,25 @@
 				#gpio-cells = <2>;
 				gpio-line-names = "sw4_1", "sw4_2", "sw4_3", "sw4_4",
 						  "", "", "", "";
-				gtr-sel0 {
+				gtr-sel0-hog {
 					gpio-hog;
 					gpios = <0 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_1";
 				};
-				gtr-sel1 {
+				gtr-sel1-hog {
 					gpio-hog;
 					gpios = <1 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_2";
 				};
-				gtr-sel2 {
+				gtr-sel2-hog {
 					gpio-hog;
 					gpios = <2 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_3";
 				};
-				gtr-sel3 {
+				gtr-sel3-hog {
 					gpio-hog;
 					gpios = <3 0>;
 					input; /* FIXME add meaning */
diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso b/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso
index 197dc2523531..82cc383dc4c1 100644
--- a/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso
@@ -33,25 +33,25 @@
 				#gpio-cells = <2>;
 				gpio-line-names = "sw4_1", "sw4_2", "sw4_3", "sw4_4",
 						  "", "", "", "";
-				gtr-sel0 {
+				gtr-sel0-hog {
 					gpio-hog;
 					gpios = <0 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_1";
 				};
-				gtr-sel1 {
+				gtr-sel1-hog {
 					gpio-hog;
 					gpios = <1 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_2";
 				};
-				gtr-sel2 {
+				gtr-sel2-hog {
 					gpio-hog;
 					gpios = <2 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_3";
 				};
-				gtr-sel3 {
+				gtr-sel3-hog {
 					gpio-hog;
 					gpios = <3 0>;
 					input; /* FIXME add meaning */
diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso b/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso
index 8eb6e40dd9dd..11b154472469 100644
--- a/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso
@@ -33,25 +33,25 @@
 				#gpio-cells = <2>;
 				gpio-line-names = "sw4_1", "sw4_2", "sw4_3", "sw4_4",
 						  "", "", "", "";
-				gtr-sel0 {
+				gtr-sel0-hog {
 					gpio-hog;
 					gpios = <0 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_1";
 				};
-				gtr-sel1 {
+				gtr-sel1-hog {
 					gpio-hog;
 					gpios = <1 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_2";
 				};
-				gtr-sel2 {
+				gtr-sel2-hog {
 					gpio-hog;
 					gpios = <2 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_3";
 				};
-				gtr-sel3 {
+				gtr-sel3-hog {
 					gpio-hog;
 					gpios = <3 0>;
 					input; /* FIXME add meaning */
diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso b/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso
index af7a3ce9c1a6..9b4c8b3520d3 100644
--- a/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso
@@ -33,25 +33,25 @@
 				#gpio-cells = <2>;
 				gpio-line-names = "sw4_1", "sw4_2", "sw4_3", "sw4_4",
 						  "", "", "", "";
-				gtr-sel0 {
+				gtr-sel0-hog {
 					gpio-hog;
 					gpios = <0 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_1";
 				};
-				gtr-sel1 {
+				gtr-sel1-hog {
 					gpio-hog;
 					gpios = <1 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_2";
 				};
-				gtr-sel2 {
+				gtr-sel2-hog {
 					gpio-hog;
 					gpios = <2 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_3";
 				};
-				gtr-sel3 {
+				gtr-sel3-hog {
 					gpio-hog;
 					gpios = <3 0>;
 					input; /* FIXME add meaning */
diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso b/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso
index 29a6c2a627bf..1b1bb3650807 100644
--- a/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso
@@ -33,25 +33,25 @@
 				#gpio-cells = <2>;
 				gpio-line-names = "sw4_1", "sw4_2", "sw4_3", "sw4_4",
 						  "", "", "", "";
-				gtr-sel0 {
+				gtr-sel0-hog {
 					gpio-hog;
 					gpios = <0 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_1";
 				};
-				gtr-sel1 {
+				gtr-sel1-hog {
 					gpio-hog;
 					gpios = <1 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_2";
 				};
-				gtr-sel2 {
+				gtr-sel2-hog {
 					gpio-hog;
 					gpios = <2 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_3";
 				};
-				gtr-sel3 {
+				gtr-sel3-hog {
 					gpio-hog;
 					gpios = <3 0>;
 					input; /* FIXME add meaning */
diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso b/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso
index 6ddf18cf6430..8c16286a0335 100644
--- a/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso
@@ -33,25 +33,25 @@
 				#gpio-cells = <2>;
 				gpio-line-names = "sw4_1", "sw4_2", "sw4_3", "sw4_4",
 						  "", "", "", "";
-				gtr-sel0 {
+				gtr-sel0-hog {
 					gpio-hog;
 					gpios = <0 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_1";
 				};
-				gtr-sel1 {
+				gtr-sel1-hog {
 					gpio-hog;
 					gpios = <1 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_2";
 				};
-				gtr-sel2 {
+				gtr-sel2-hog {
 					gpio-hog;
 					gpios = <2 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_3";
 				};
-				gtr-sel3 {
+				gtr-sel3-hog {
 					gpio-hog;
 					gpios = <3 0>;
 					input; /* FIXME add meaning */
diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
index 1a9729703556..1ae96e34ee91 100644
--- a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
@@ -426,25 +426,25 @@
 				#gpio-cells = <2>;
 				gpio-line-names = "sw4_1", "sw4_2", "sw4_3", "sw4_4",
 						  "", "", "", "";
-				gtr-sel0 {
+				gtr-sel0-hog {
 					gpio-hog;
 					gpios = <0 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_1";
 				};
-				gtr-sel1 {
+				gtr-sel1-hog {
 					gpio-hog;
 					gpios = <1 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_2";
 				};
-				gtr-sel2 {
+				gtr-sel2-hog {
 					gpio-hog;
 					gpios = <2 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_3";
 				};
-				gtr-sel3 {
+				gtr-sel3-hog {
 					gpio-hog;
 					gpios = <3 0>;
 					input; /* FIXME add meaning */
diff --git a/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso b/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
index 5333767361f5..620afba06e6d 100644
--- a/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
+++ b/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
@@ -115,25 +115,25 @@
 		#gpio-cells = <2>;
 		gpio-line-names = "xprc_sw_1", "xprc_sw_2", "xprc_sw_3", "xprc_sw_4",
 					"", "", "", "";
-		gtr-sel0 {
+		gtr-sel0-hog {
 			gpio-hog;
 			gpios = <0 0>;
 			input; /* FIXME add meaning */
 			line-name = "xprc_sw_1";
 		};
-		gtr-sel1 {
+		gtr-sel1-hog {
 			gpio-hog;
 			gpios = <1 0>;
 			input; /* FIXME add meaning */
 			line-name = "xprc_sw_1";
 		};
-		gtr-sel2 {
+		gtr-sel2-hog {
 			gpio-hog;
 			gpios = <2 0>;
 			input; /* FIXME add meaning */
 			line-name = "xprc_sw_1";
 		};
-		gtr-sel3 {
+		gtr-sel3-hog {
 			gpio-hog;
 			gpios = <3 0>;
 			input; /* FIXME add meaning */
-- 
2.43.0


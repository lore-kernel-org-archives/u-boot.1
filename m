Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C91FC36018
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 08:47:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7668082047;
	Tue,  1 Apr 2025 10:47:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="BJvW6KUV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 886128205B; Tue,  1 Apr 2025 10:46:58 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::700])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62AAF82012
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 10:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+Jn994XGrMoNS9ZlARpz9eyJs4k1v+gSh6AzxbJY92Z+1JbLGkwZVRDSR7SMTAMiSUEZTS564tfX2pcTB94rtrJBOa7awrChWP50yrjgXHzBlhAowDBedtTvw0FD7AnQAx+hOeavsJYrQ/10bL3UZMXJi6GWQ0wZ/dC8x3Z2coJYRfs4fdQNRpZuRcM8kehW1irdB6c10ywd8Kot+2p44YzDmlNFlXdoccGLvgxwEkLC5JLrvPS9Is3WDz8wL1sK7kKpcJCqAwxWu+CSKwpKfUE/Zeu40/ZfFxXxlWfmg8ov9xvQCyWKILmuCqfaYInpRtbk77Erg4amHziaMRhTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lacDO1Z3pUq3EL/WAom/gjfGFU5+SKIfPMh0kGXmiYE=;
 b=nQ3fOlzXr4Mmlq9zu/zYDkurQet6jRnKXHXzZJj28IQCdb71jw1w2mStfPAXtOmfRClDMIr6DGU4kIlBCOCZf1OR5HPgpYzVFGPVHj1xHDO/Bs465ZFTNvHqYdbVCJqBA60pcMOVDkgceau+YbwMbScR+6U8q1BgphnPBkNxadlmcM/g7QpoKUQBBMdJYSfkAh7wx0OjfhIdKU3Fck7ME2ZGMUGZFIrmtP9Quwo3lJuGN/1ccsj8p3NYBKYPHtZJvxlK573CqbEJgDFNOkA//BaRZSmy7+x/Pxq4CzQKXxiYlvELeq3dWA4z0eYjI5ArpSNu06GuknzAa/8HeIg+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lacDO1Z3pUq3EL/WAom/gjfGFU5+SKIfPMh0kGXmiYE=;
 b=BJvW6KUVqGSf+y6cno4iwLQ6HajqPZlUrk7CY+jfvm3uWtdOT7hIqx5SxZftQNG3O5qtZcJBztnMWojHN+oAShuGQkUOVajHoVa/WYAb8wPfdznhedtc/hhfx/u6PBHEAFW4qhlJybe93m0Z/tzH2/5OyDW0+O89GPP81SN/TxAHbVYrOcXgyeGs2qu3UDxQfs5MFpUIa6zVE271rSrvHV8uPIKYH+hooTUGVmhEj2XUsc0eJMuBvkjRHxqYojtRnBSq7mu99DS1xTWpYCiOQQsURGwSDgdg3/WYy2o9LcZUFml42/XdO1LbTuKAb0oZS2QPPf1tHRS8SbWDcrhITQ==
Received: from DB8PR09CA0033.eurprd09.prod.outlook.com (2603:10a6:10:a0::46)
 by PR3P195MB1118.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Tue, 1 Apr
 2025 08:46:54 +0000
Received: from DU2PEPF00028CFC.eurprd03.prod.outlook.com
 (2603:10a6:10:a0:cafe::ef) by DB8PR09CA0033.outlook.office365.com
 (2603:10a6:10:a0::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Tue,
 1 Apr 2025 08:46:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028CFC.mail.protection.outlook.com (10.167.242.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 1 Apr 2025 08:46:53 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 1 Apr
 2025 10:46:53 +0200
Received: from llp-anderweit.phytec.de (172.25.32.242) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 1 Apr
 2025 10:46:53 +0200
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <festevam@gmail.com>,
 <marex@denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 1/2] Dockerfile: install byacc
Date: Tue, 1 Apr 2025 10:46:41 +0200
Message-ID: <20250401084642.216933-1-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.32.242]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFC:EE_|PR3P195MB1118:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8296f1-e555-4868-ac6d-08dd70f9c0b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TKf263llBqjFIcZJJLP7kwf70Vngk8+zdDSzSLPwqX1t1tVQgCETRjduZFDR?=
 =?us-ascii?Q?oi/oZS5NEO+fVoeiMdjEYTKNRZWX55NaZXBXddf+1gO0XLQ5OHnH8gYihIX1?=
 =?us-ascii?Q?ovxPP1SfK0NkrfAQ4L3SbQQwN+Y70piUE9kEsWoaXWWjZ3V6S8sG+6RBpIge?=
 =?us-ascii?Q?eQ9I5M6swaQTiCcOE9S10/W2PiDV2yZRjLLJnSOqyDdxpd3XKnsGZFuWfETi?=
 =?us-ascii?Q?SB1dFTkMToJd4/XXIOuH5NriU3brDRC/pFtyuiIpH09PrmXyyDqJX8uhQgah?=
 =?us-ascii?Q?ooGFesJbXA/uKMRsLtfbw38zyiwnKvaRNMS4d/ulXrGp6IjEGY81Hy6pJVQ6?=
 =?us-ascii?Q?6/5Zmo7yg5JdWPcA9y02fcPZjfEoW7qY5ZZ9pXnGejQ1KNYkBhMkYfyOmh9C?=
 =?us-ascii?Q?k4OmoTQP4S1vYY7/bIl3+IVpMUXp/NLvQdDVUpMFvyZW3DxW3kxJsx3EYlva?=
 =?us-ascii?Q?FUlS9g4Gik2HxGJo62YFCUHCcCVkSNBJvbgkgSKQkShwUl1YDHStr67006D2?=
 =?us-ascii?Q?BLpdVCRlXrAz4x7GpPYOvddfgBWazHJyRDzI8Yl6psU4ggDNoP9G2pSc7H4N?=
 =?us-ascii?Q?+Qn55twa6yCoEiWFnMvw8lnOa/8rpTPhhSdfcgBWLS7PSERh0uIZm2RhvsH/?=
 =?us-ascii?Q?70JRzRkvnSKRc2Ije9lre/K4ZDsSf3s3Elh72Hm64YZCBYCRbYI6GmuP4hFD?=
 =?us-ascii?Q?0+EVKsfPxUfpYoSP2S8UNPrvmJhZjPB/yEOf73XIFiBP7zmN+LPpOTv6nd/s?=
 =?us-ascii?Q?61qRDpxiU//wv/twJBgv8yAoOLz2SHbAxXnaMq9kH3/8y38ayjPJi+l7ORVH?=
 =?us-ascii?Q?Pq7BuKwQdZMD/EUfotAMyr89ixMekVOUAU8Qi6OwB7WlJei6vdYhIIP14qb0?=
 =?us-ascii?Q?D5XMMSRLeDnzf+7RLDLG0j8uQJhXHC4hymvB6J5P1fEre/RTLh8KnAfGu82M?=
 =?us-ascii?Q?F82b66HGxPnKizmiXHXRqGzaMxRUhvBgBn1GOIhUEeg7uwevMV37EqqcWwdR?=
 =?us-ascii?Q?+FyJwlpIPuO53zvn9ukE+ag5nJ8JnnZ3cLj6FQyj5jcFRtk7dyqJ5qhGWNeA?=
 =?us-ascii?Q?jKK1GIHMrD2q1lehjrx0ghzJWvUoBxSJ/VzzfIeDt2e0ZrI1RUxmHu+7WSIz?=
 =?us-ascii?Q?rhUt3cDSndZKKmZzuovap+/H0pfzkdFZMzJ2yZ1MPCAqyEz4nnjsH7/p3/sr?=
 =?us-ascii?Q?3Hk8Ip7vkvsnHlfwo5FLejFl8kARUoqpwBXOXckRysQEkxWJyy6kYL9mzvUi?=
 =?us-ascii?Q?YAc8jc4Q/XmJ1MBHA+B/CicluzJhz/mCkAlPg+2CX3X5HUUDLn/WUOJsDpfl?=
 =?us-ascii?Q?Z/fna2m9zoDbL+w/ZRvPT04iSOYe1mxJUZa1CBg1BKRfgBJED1+2eqpTzth/?=
 =?us-ascii?Q?VzkYXIHchcMM6GbAIWIVwDTy1L6FTPD5L9+bJMEeY6QwJ+JjmMbV0yQDHWyX?=
 =?us-ascii?Q?jTVnPTuWFxjKDKIzdmlInyZJad4+91xh90SsM+tpX+tmZY923s8z7okuogmK?=
 =?us-ascii?Q?kUkuvhOJoUSTXQA=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 08:46:53.8218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8296f1-e555-4868-ac6d-08dd70f9c0b6
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB1118
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

Install byacc required to build cst from source.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
 tools/docker/Dockerfile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 569912303fc9..60f63c2d73dc 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -64,6 +64,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	binutils-dev \
 	bison \
 	build-essential \
+	byacc \
 	cgpt \
 	clang-17 \
 	coreutils \
-- 
2.34.1


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7153C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:03:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86CD140B87;
	Wed, 29 Jul 2026 12:03:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QtjpexgPlbs4; Wed, 29 Jul 2026 12:03:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B940540B7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785326596;
	bh=a1sEzYPbzAr6SrEY4XQagM6lXu4t6YDngWAU7SYM5y0=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=d+o0UXjmRVnUsNMQbFC/87tmHj6fJBbWHVX3q3nhephQ5Od2STXWo1RfCvkxDgGoa
	 Ct5+sNXRp30t2E8RSzKFaBX+UbRHO0DlGc2jeVgWL/1kK8+bv7kPZB48iEgpjpQW7M
	 l0pk1sl1oYsNKGWUcm4zcw6BrMFVyc2/utf12vynAlppXNFWyLMp4pNytHcfF2Ocxp
	 gMd3iuJICMTJ9fHgCN3ZuTjsa/caM4IEC6/FkUrVtLhlhNA8tQFB852ImvnZa28FOP
	 RK7dcCjXVxzu3GewzhcB88W49GVZ1TGveUy1Tg9dzdWROCDjm+MJWIKY4jSE90SrYZ
	 qLEE9FNfnj/KQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B940540B7C;
	Wed, 29 Jul 2026 12:03:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E5B2626C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E24F240B7C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:03:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Xt-EZY7MVcc for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 12:03:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::1;
 helo=bn1pr04cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6F11B40B78
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F11B40B78
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F11B40B78
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guRS8o7BpqgmINjjzQRpurdC15cXbjyvt5BowEmB3cn6a2tEDlZbgrFbOd1Yyl6FXpXG0bwNo8IYHHqqmyFhYQZI0R80ckwkqKRlqvXFR/DgbICYyLnn7a45sBOuQ2BRTQEZMPAn3hSoRHIcRiX8dwzRXe4zLQ8A4qsxwU/qDf4XVftrs/CTTCv68lYxisekAteqys+8uJlIZhqJJ9Hs7oBWHgr+lTeQAfB35kHycY/lTA4kt/V1Mu75JX2OHTIBabiMX1UAJig1Z+JLFFBmyi+K5bW5GftYBbCFFRSBjNbRPnV2LK+NwYADBW70c7fZSf4h59/8ZJXeAWvb0C+K7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1sEzYPbzAr6SrEY4XQagM6lXu4t6YDngWAU7SYM5y0=;
 b=Pbxl9LvwRiQuFhllNOcdRKbuDVkcC+g6WXAEO5mLYjq+ZsAnDdltVYIwSTWDRcU5lXjOHTwnzkJhgV956tm2IC0P0e4sGNzhxSnHJulPn7UmSlJO+38FOGWGL+6RGmqZb8/Jp0zzGTOPlpcFI26qSYTDHZCq9xRNw4bpcoPjxXgt+IbNCJNcm6PUN11wJC7L3lSe/WLIQRKiYcUDUoCtRfYzRd4dO0qReDTmkqCnaEB/ubkB+sfpVWaukrPwnT0Dd+B0zsLnJ7ZasCwqRTaxVTELPy/dgvPTTcaRh+zgoGWOw9wUx6Vhx66ypeCFVGmdaFfw91V6chjvFMb3lX65qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from DS7PR03CA0121.namprd03.prod.outlook.com (2603:10b6:5:3b4::6) by
 PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 12:03:07 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::25) by DS7PR03CA0121.outlook.office365.com
 (2603:10b6:5:3b4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 12:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 12:03:06 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 07:03:00 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 07:03:00 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] cmd: scmi: Show names for vendor protocols 0x80 and 0x82
Date: Wed, 29 Jul 2026 14:02:47 +0200
Message-ID: <9ca09685b22f3d2a93a63ebb7b29ab150b07eda5.1785326564.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=840; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=qBxyZGoh+XJbt0FWIppCvFolkgMUEpQtmp7hv5tnBxk=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRlvn5xR+L8nbMnrC/O0+rt9m3NeZIeuUWK1SFOKjEuZ
 weXRYd3RykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEwkOInhr8CcKK4TZ6Pm197Y
 OO9G88ep/7dMu3LV5Nruv0m3p37WCV7I8FdQRrd5vnjctHKX4/mHJ3TsjPjDZ6d4Ie6Asv7Cvhn
 mT9kB
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: c0db907c-c577-4e21-63c8-08deed695996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|56012099006|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: uFhIMMZZW9UnlXyAdsP4/b+HjZhMFEcslCcvBxwf/9P1FAERWLv5M17ZSciXOhwSVwbZ4ba7U68YB3qtl0da6SaNsCeogdz47fXsCoh4HG++ZVIc4RkWO32lYaa9SBKLDuL1e8s2AeV9kj0UriF3nKi3cVdRUji251RVSvET/jfGaJLQBYbwXgiLUigL1wA1jMOZn9jBCQf/M9O48TXVb2yLHnsuCfVWk5pYecw4lBqLYyBmgJR4fkFAFarxW1r0y9ytLsnAyQI8fB8ot8efv8jvLv76x1oWo28H5Doca0tAm8b/d+yM5I3YjIJlLzsgKGSNwxmm65ltRyGVH2+ZnQIyfbVRLWYUwwdL/0gsTc9t5xpuech+1h9Wn18D3x2yxurXt13Av9TjZZuYv+VT2C2ny4Y8QZYFUMZArYxWc5d0l/hEfcTlxkNV1pP+PZCG2oqlor+Ty5nkYE0aQicMyEf8h2InbJFFbu2e5BjJdxXg+hGAG1hF0MyKdfICR5t2RFjtypUh+Uevlggkp3lCbbcsBqzfr7WxlZLx7hhCHZxnlF+hT9NgOkKcIYWn1P3GSWuz64X5lEtwlFx6feSo0dxyhdRA/nIlPdRgJ/aBBVOECFlfoa3a2X3VuK8GbjGISrf71xD/jFrg3L+Obbd5Gl9hjiSXAx50qgX1u7/YaAwYZ3VP2WMdPZnXwZ2e2go7cUHn7JysB3S/90cvA9mywQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JDj42FLLHlpaeJU/5aPV7/7gsFwqE80NlezW3VtEqebqMwOiBUTtGP2quBtZepfA88c5GIy6eZswIPOvou1oytQ6JQtn5YVEQIMMe0bev1EKxC0bOOmk4Smstda9d1IFwvDBs7zGfCa5dKqMdN07akpHCcx862/EB+kP6GjM/nZLCnbFzHrNASPYstmKQEkSnQjWN+oC4pFNBZIGqdgPCVRXO3PTCAkiHOarq/coJDuS/jCArwIks5wyVX50R4o4lpbAYNLtWLjzOt0HyipSIeM5KmTvwhvdfj3x56EFP46icUq/As+g9bMa5PQXiUULWddjSm1qJO/xH0Wcr8kIuA/oVv4JCk4a2MP+aNle47hKaB0Rktzo/nU3H7Yre06RLQOm16Bo0yWoZLhC6eEnMJBEuWLV+BV7Mo51bOrms+y4oqYqouBgYPgSJrfCaXFQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 12:03:06.2939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0db907c-c577-4e21-63c8-08deed695996
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1sEzYPbzAr6SrEY4XQagM6lXu4t6YDngWAU7SYM5y0=;
 b=ayxE8bQs101nzsE9ehnwaPWiA38w+HhuDZlbUEfZDBKHekrJnDLnP4VcxMSGxvSdenJKr9wMrbM9ZaVQuWX5W+buJFf+hnu5BUYh98Xnt3BFyk5eUzMbAPF1r/9JzG1Vqlb5cDb6QkMe1x0THWMFOm43X1MW4kvGqKX/yQYyIbw=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ayxE8bQs
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The generic SCMI vendor protocol IDs (0x80, 0x82) were listed by
"scmi info" as <NULL>. Add human readable names so the
vendor protocols are easier to identify.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 cmd/scmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cmd/scmi.c b/cmd/scmi.c
index d0498b816aaa..af9743145835 100644
--- a/cmd/scmi.c
+++ b/cmd/scmi.c
@@ -30,6 +30,8 @@ struct {
 	{SCMI_PROTOCOL_ID_RESET_DOMAIN, "Reset domain management"},
 	{SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN, "Voltage domain management"},
 	{SCMI_PROTOCOL_ID_PINCTRL, "Pin control management"},
+	{SCMI_PROTOCOL_ID_VENDOR_80, "Vendor specific (0x80)"},
+	{SCMI_PROTOCOL_ID_VENDOR_82, "Vendor specific (0x82)"},
 };
 
 /**
---
base-commit: 264994658ecab72cc292f8ce433469b01f170e5c
branch: debian-sent3

-- 
2.43.0


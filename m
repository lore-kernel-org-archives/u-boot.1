Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A688C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 08:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0ABAB81139;
	Wed, 29 Jul 2026 08:12:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Um7EAaeVxUSF; Wed, 29 Jul 2026 08:12:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 51DC881129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785312758;
	bh=0yOXK5EOWubb9Z9+povV+nCMWP17EzWVfPgR6wWgziQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EKa+hUhNzKSUqzIho8DuI5j1L8FXaWM7MPgWUp7N+TiSh/40+XEX7mP02+Nl2dWhG
	 25jEmDWAmIiH9ROiXyliAmXgN0kKjLkbbp91GT/s4z2eJtiJUREZvkv82oLvvEGv+U
	 HqS+gIX6VXQhd3BIfiZmQIvdGwoWvOwwQr66izeGGMlkYdRAb+kK1FwcWLh2OB93j5
	 OATmsI3hLsEJcc0PaBH1nmVgzTkTyiXizTjhVQ82avKRBpMGu7vYNpyDMap7UwcXCB
	 Gly/J8+rw8FsplivWwZ7KSnHRvqpf0e4HkbXsy/pgxdRqVQ9P9ZgWcfG//iz9du0it
	 lGQ/bxxgtn2Jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51DC881129;
	Wed, 29 Jul 2026 08:12:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CE61C45B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AB98C81110
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MLMVI18eYriQ for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:12:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::1;
 helo=bn1pr04cu002.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 816C681091
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 816C681091
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 816C681091
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:12:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0HD6jfZPsF1XB7s51l1mmXWzmjINyUhDioSkIMnnl+r+7HCc5DHAh0aue0HVFQwLaY9H0Xocqo5Gi0cKq/Pn++WcQ4Td2OwbDzjT3UUeGoBiEkXJ76iQo8NVZznsV4B+b7PLtzTLs6OIlUyix4JPmlo7KgQtt/7WMZ7aaQxEmuNz6Z+tqA6Rn2SPpLK50bCNijJ8YjrXTW02cK6dSeMtcq67snlX0Uopyy//Uu4df+KysWLcHUrMXD6XCkPPaMCJet1SLp4/4xYvnWN9lNwnn1aLon9q3sK97QecLQAJjt88PGJJLN4mS3Oxw1+U3Iuq1uizuqtgyRfg8vinhhBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yOXK5EOWubb9Z9+povV+nCMWP17EzWVfPgR6wWgziQ=;
 b=FUb82aqrXXYkUEWo4QIDzNDld54UB9S10guuIL19t3mMPurjtBYXGpDK2XVQYUm2k1Dk47WujfGpZa77b1BdZJVXu1BmzsWjFVy6ojbvP3UqJYB0ozfOJSbyLenI3WGnbDMSM3D+zYVxOOPsjZCdRUwZ2ogtRMbW5KnEh10TAw1SN18ZTxiucsm7SXPhvPXGERZKT18YdHLvw+PLHb/vLqnFBOhnvuxhWGu8S05xrG+VQwZYXu+5QC9bB1nzjGzCgVojgWT7n8e9ebz72t+CDRKS1CJ1Hl5J26YfjDyVnntdQnlm0kbGO3/HtMFKOiehmS2KUtFSLJQsZ+6E2WWD/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from CH0P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::28)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 08:12:29 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::7e) by CH0P221CA0011.outlook.office365.com
 (2603:10b6:610:11c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 08:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 08:12:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 03:12:28 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 03:12:27 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 03:12:26 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v2 1/5] gpio: uclass: log when a gpio offset is already claimed
Date: Wed, 29 Jul 2026 13:42:14 +0530
Message-ID: <20260729081218.550465-2-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729081218.550465-1-pranav.sanwal@amd.com>
References: <20260729081218.550465-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd5ce55-ce88-4831-8431-08deed49220d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: 7iq1T9xPzlw1U70l2WKSTX3R5ddQLclfiiM4eK69GACdWaPLljL63T7imbIsUu+amL6ks7c3X7XaVy5Nb/Y5E2KMl0+KfT3R4u8No0zMKQA8zatCMc8R3SqnO6el2+l3qvRONOkXGdgBSb/vW9jBVz4sMm1WY1ltbPM6GczuGQ8bGwe+dmIpoq8Foj2FnjTw0mvQzt7VLu76nWAMpuX2z1npGbZjdM1fwDlR/CJZ+MYnp655EnOcXHTK8wDd3OYJBnjghKqo+SvVliQbqw5g4jWTXljerrQ8UPqjf/nPoAF0W2pdmwcDo6HZJIaHYHqqV68oHOFshwpUbcq5arPThfk02Z2GcFBowa/LbJAx3fZhh3Y56Mo7OZX/tX+udLLPrBcXR55lF9wcHDZXPX7qZwKZPtdg+t3zVH3CDSCa0QhXpJtKfnmC3xH+3Pvn1szqOc1eR47o8+uhEezsEQ396wGvrfzBO9tg5R0b/TSITwADhP+2Q5Hqwz6byloEDAXCpJt92jqbZx2nLd07VPUem7Bgj5stb3IMqFn7IbB+MjlkaaCD9Ex/J3Hz1I5QB1GDonVvW/u009mhUrh7VLDVAomhsDbnL02eKJulw91+1iTISpZI8vYk4byNJG+ozZbYvNBWJj54lzRagEKKXLeR28gH4nhD3e0Y7IWyRPBKCDOdLJhzLbnK2vupNG2i5UjU2NR7QR6JfWn7okbB/YlZEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yJGZVJs7ne7HPy8j0SkGgIil5Y+CIBazgyexYLx2y7pxcVVsOqhlNKB6VbTcbd6u3xA162ilItsjtN/dxucEuCAAod43MQ0IyFcRqZjupnyIqoZdAVwJeCIJNyhkuJG0XmTkSIQRZI/Lgij3nWxszixy2TLokkHGSpFKNIeC+TKuY3zpmbJ5BIH2FttJ7JkPk2O/oeb/ovSaFaCGq9qR1qgXKYlb05IEAjijIPp9x/D0E3XSuBdGpF1QiCWyWJAuLpfEq/OYikTxIHTS047YUIUIqmJwV9nCcOmqAQ5ZnWIRAf6+q955t0Mu/sl97Jz7oOINxwSvJysEX8ypr15V1/9gkwVpymE6f8eu0+7pz2kK3WHMJuyD7tnMP4eTJcgo7fjC5Z/WHnJHY+pfrupl9ZDFoMq5QPJiA3wKicwpUtp+QAULSTu3iCgGomNyk6ak
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:12:29.2352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd5ce55-ce88-4831-8431-08deed49220d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yOXK5EOWubb9Z9+povV+nCMWP17EzWVfPgR6wWgziQ=;
 b=q99I3437i/LrwRm7NuhHLNoXhUQWTRS8IgN7oalGVY6AaU7bnLf+xl3oCKezd8dGn7l+Jc+uajcDd9EcL31fv7aQW5I5gKUc7EbT8R2i7yOY4tP9TH6O0cSEEMBdAuhG39C3y4zfRERrTCb8YcpwXyQnr5geDmESf6kOgSKfq0I=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=q99I3437
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

dm_gpio_request() returns -EBUSY when the requested offset is already
claimed, but gives no indication of which label already holds it. Any
caller going through the uclass API directly, rather than the "gpio"
command, has no way to see this at all.

Log it at dev_dbg() level: silent by default, available when actively
debugging with this device's debug output enabled.

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---

Changes in v2:
- Downgraded dev_warn() to dev_dbg(); moved the user-facing warning to
  patch 2/5 instead. (Simon)

 drivers/gpio/gpio-uclass.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 7559b8dc7e2..9451b7db4af 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -391,8 +391,11 @@ int dm_gpio_request(struct gpio_desc *desc, const char *label)
 	int ret;
 
 	uc_priv = dev_get_uclass_priv(dev);
-	if (gpio_is_claimed(uc_priv, desc->offset))
+	if (gpio_is_claimed(uc_priv, desc->offset)) {
+		dev_dbg(dev, "gpio offset %u already claimed by '%s', requested label '%s'\n",
+			desc->offset, uc_priv->name[desc->offset], label);
 		return -EBUSY;
+	}
 	str = strdup(label);
 	if (!str)
 		return -ENOMEM;
-- 
2.43.7


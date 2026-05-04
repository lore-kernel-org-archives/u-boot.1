Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034DDCD342C
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 11:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EC18845E3;
	Mon,  4 May 2026 13:08:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SzXA816W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 408BC8460B; Mon,  4 May 2026 13:07:59 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DB78845E3
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 13:07:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIkOxQmsulYmRqf55Jvx+zGtKuLLVXGDMpUDHWfA1wmHOs5gLRrdJj1QQAGhQY+1/WjQiX79OQj8IlLQqyCHnGAtje8e7QKDcQSjnoRjPhOdGzlvp/Ofe2o7D2iTPQI3awsxHYHCNz2PaTIOD4gtUIlgi66APPlb8UffJMa58R629pzaiovqgEABeYGCpvO0Hmw20B4f9tibQxTZNbyZo1nnKj0NhWrcxDn1CCdZP4cp6mSo9O6wfScT7dge1zybK6/FkKYPoelCd+1FzNNU+TrCJ2fn8iL4QLGbveFUG6tE9wUrW+0GwK4fCCpn+LCbC2EqJEjdAbC4FLmpWtTmaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yupzeHtylXyOzvRsoZnqql5iwZ58rdrTTLMegVUm4g0=;
 b=b6jS2TEMvwRqUvlEcsLqtKY8KCbAJhNSoWaScOq1hpbCs2NcAl0qu2yHxD38MBfEVO89J3MpN7qFcvmgjnVCpX3s/jlBrhYz/W3Y+sQTIaSWJfcMDmMAQQIedEWuJ3wIzU3iUghZsiSdVHnJkSwmlno8kW3hj9uzwZCGWjtLMVBAQJK6mEEBduWBuZ+lyQ/lEpl/gSzCEcSxxTazlC3dGeqLQ6e5NbhYEYvOG5uuTXRxsaxihq1tvlqol++dI/4E4SsW6VkEXho8Qov8qyKvBR125sqoOArQI+iPJ6XRI6oFDE6j0/TlvaqwnUhaXf5UrlxJC9w+nPk63PO5Qyx7Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yupzeHtylXyOzvRsoZnqql5iwZ58rdrTTLMegVUm4g0=;
 b=SzXA816WqMHJJzizt87Eh275yLAkCXHf04NClFn34Ev3ALzdM2Ty1LRozgQld3MXFNh6HNiohA9fMjOZeYrbkJIabcGeZPSGXUHVqQxPGSzK8jB1KBdS+aTBoklMUpG6fJLyjddqHh+09daLJEBGPdylEqK14yeguT4mnM1Bsqw=
Received: from DM6PR03CA0062.namprd03.prod.outlook.com (2603:10b6:5:100::39)
 by CY5PR10MB6021.namprd10.prod.outlook.com (2603:10b6:930:3f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 11:07:54 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:5:100:cafe::d3) by DM6PR03CA0062.outlook.office365.com
 (2603:10b6:5:100::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 11:07:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 11:07:52 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 06:07:52 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 06:07:52 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 06:07:52 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 644B7gdP586965;
 Mon, 4 May 2026 06:07:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 7/7] ufs: qcom: Remove redundant POST_CHANGE clock
 setup call
From: Neha Malcom Francis <n-francis@ti.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
CC: <u-boot@lists.denx.de>, Sumit Garg <sumit.garg@kernel.org>,
 <u-boot-qcom@groups.io>, Lukasz Majewski <lukma@denx.de>, Tom Rini
 <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, David Wronek
 <david.wronek@mainlining.org>, Jens Reidel <adrian@mainlining.org>, "Luca
 Weiss" <luca.weiss@fairphone.com>, Swathi Tamilselvan
 <swathi.tamilselvan@oss.qualcomm.com>, Aswin Murugan
 <aswin.murugan@oss.qualcomm.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Julien Stephan
 <jstephan@baylibre.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260427-ufs_clk-v2-7-36e10a7c0ef6@oss.qualcomm.com>
References: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
 <20260427-ufs_clk-v2-7-36e10a7c0ef6@oss.qualcomm.com>
Date: Mon, 4 May 2026 16:37:39 +0530
Message-ID: <177789285975.3146166.1249313672430803406.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777892862; l=512;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=t2TkOjP4eGSni2fyC957yDUzj9vaormThsvsviFuKGQ=;
 b=XlWDRzGID41N2Qc4zoGIGGi5DPBYJ9hT9h3dyf8mLyPx/qbdrNLoJIu/7TT8gDNPyCe+hscFb
 SuhQXXru0AWAD2tw+YhHVk3TIsLHa5uomFH0ecf8jolTqshrZHk+2iB
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|CY5PR10MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b1b2f3-b134-42cc-5eea-08dea9cd6324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|36860700016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: u0X5VG7ZoO7btnHlHOdysWOhL2Q3CGLiMB30iNlDPttOkdMbZNa4z0UK+Nwtec6mZBMfONMBI4BX1z98bjGkhqgeDtgaS2PTLl21pa77hgbSzN8+2f89CihJW5kA2mlbXxLJKMHljgDdnX1S6450qtvgx9unon30N5r5r3PtjpvkxyKTW/pL+CVJPZj1PJpoAQGMk7plfweGF64zRInAWNjL4IZ3LAShRXnZ8Npq/sG9zUgeQ4ge/sfxyMr9JT6XGxHstLa4JjKpGJ6AFF42aUzwKBtKYsgSEr4qGLY4Pl1+js0Aqj1E5hWyVdKFqD3xtQ2k5CeGwoTLsf0HgC4I+TeW0bfAsMSIU1/uZejIIZGIkaEN3bbBDN9jB6taNv12F2l9Xk4nzO3Oj74rufPtJxD9U6Z+Y643n9Kll2J0Mgtzdg0q0TczWkCIf6o2YTkSCGFWew99syZcn3WKuN00pyrO2Qn0ExhhBlU3nZmhzmFnjYyMTgMtTcAYy1YJ78KPxVB2L/Ra2Tq4T332EjHP7cz3AYaX0DuqaglGx33AeLsdc9Fh0fNqAKHkjzieW7jaXiaWnyKUOhVeHIs4VaPX2qfX9ResHAfp76+rerPU0cP5ca3LJOYrLzsltsiL3XDH2Xya8DkxCLJhaWZ7rAMYP6Gj2RBuFlKbe1wZHWnOzxmdMHh7wD60ONNn7Vm9c2gAWd9dshsQ++dHjrtNup8A0EF7OXVItW/Jd7DqNom5A74=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2xbI3X+F/zaybxbyQEoNbAMVkzfc3BsnGT7CouXxbvPxtZr4siPbf4BG8MKhhXM+XPLcU+tOAqwEOQZa66O+neoGiFNH1kVxrCSui0IoYLxH0FT0K66odara/ybEdyqy0rLPY+PUfJREthFd+VWGeLI/ZGqZ4ELbRmublpeo4ftsoO+LxBJcm2O37uJSZdQdZZntSJpP0UM1IBS78p1Gl7ZkQBWZJrORcaSUaXHLkOia2bPlXret6uFqDVcQbBcKcxL4CTjegOz/dVa0e1X0s9Dm7qKKe2tDyz5C0uOjdyeNQxZwN5cIxav1D1hDqF9JCVGVBQOQp+d0dDnjBhFt8eLhc0882RiWHSrRgA9BXOQl6gYZwS5BKjr72v0acrYe9tvY2WiLX8VzUJKBsMWHfR6PLyls4yW4UjyFOxNIyfj5z7LcW3Pe70z000JA0teA
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 11:07:52.9090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b1b2f3-b134-42cc-5eea-08dea9cd6324
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6021
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

On Mon, 27 Apr 2026 14:56:11 +0530, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:
> The ufs_qcom_init() function was calling ufs_qcom_setup_clocks() with
> POST_CHANGE twice. The first call after setting PA_TXHSADAPTTYPE
> correctly enables the device reference clock. The second call after
> ufs_qcom_advertise_quirks() is redundant as the clock is already
> enabled.
> 
> 
> [...]

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>

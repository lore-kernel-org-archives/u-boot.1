Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581BE606A32A
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W+otLUpN;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UvhIzFdR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2BD96606D5;
	Fri, 20 Nov 2026 15:12:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NGptapj9raT6; Fri, 20 Nov 2026 15:11:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 60EDC606D9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795187519;
	b=q30/akwqPswxX7Jo+lX2D0gXHSdgNk6eWOwCtUIPhE01kU0WFh4/rF0QvLIXuvGkCQGa
	 8DV4SR/KgnOeAk+3TM+v1WI5GP8LLrMJa8NhYJf93yW1nsOQ9djV7fL9NE4ODTO3THMVM
	 +xwtGnzfeR+WZH+iIVHrgz01y7fmq8lZD0j9Z10D8uT2BmAe/B7pWv+TgPWj209mjEkV0
	 1+jzZw1rA5JzD/hTRIMtR5ahXN1Il4TWg3oBk354qIpyGNeB09uYb8oZe9lq2XllCrQED
	 1xOhACKjHUaVT02CHRonOmwljPXF3Up/BTV8hLubjk/k8IAM5RLLH2/1NnoJduOuJig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795187519;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BDjkX5XOYTK5youqSOxmyq845ntPAh8YC5ipFzus7c8=;
	b=NRB8r0kALmcTCZLS87Tscx7zzCCCJbZwrSve58zB7wsotyMdvOc5WdI7c7LB+Z4QArkT
	 +T2ZAC1IHAm4mqN+4lkaivYDwoVdryqRaXv6CDZqDBzTu9Z2zCqcMcpzDmVzWSdfwck8c
	 qXhtxj710z9s1RDPK088lm/WlEO3wCdOZmd7dBNwltKAOTwl7eGI7AFZc9NAO5ySdnawr
	 taDv3IEy0ZTOIG6QiubygXGz2k6+ZwYmAp63gYCUXi+Bhg9QI0JAsbOaS/opeiHoL1rBP
	 jq+el2cQnXZXN+Iaa666q8zPR8w0t5ZL53OsclzwqOUfWrwfsOKdvFQ6FSg65EF4CZQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795187519;
	bh=BDjkX5XOYTK5youqSOxmyq845ntPAh8YC5ipFzus7c8=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=W+otLUpNI9lujpDvB/xhfKZquwTD7d5vET8d+xHd4ncDG1z9uSfvLdYx34LucLAmZ
	 kF7eKza1gBKUevo/gyea3HxhD3SgjNxIFyBZYtDt3xBOTFbZljBLGWaWmklT0iWnNg
	 gxMD+EAC8BuMIkMCBuCHS8VbaQ3ipJcH12yQYHDLC+0NLJN2Dxgl/sJYHYtThOtebK
	 q3DgkdnMohkgWO+uoc2AIKsDjqXIsNLwjiBqubhyPITdu4wAkBg7ztvq9VHvuRNCuz
	 MB9I7mPyCYCF1bk+zVHnio23N9GipNkrCEWdIVj2ubUeYb2MlJTRdsbVQ8Rzpj22t+
	 Vl6iDQ/t/wV7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60EDC606D9;
	Fri, 20 Nov 2026 15:11:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 49D91E52
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2FDBB40E10
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:11:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IjLHr3KSspac for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 15:11:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9C23140DF3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c007::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c007::2;
 helo=mw6pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=UvhIzFdR
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C23140DF3
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDjkX5XOYTK5youqSOxmyq845ntPAh8YC5ipFzus7c8=;
 b=UvhIzFdRvj2pwhMZ1ou/ARJjou0w020hTgyAFYB9Ox4PUO793C949AXROVcch7MY2HhVNZDILXvw75Zt+mkiF3zTat2IDkRvSwESoZKumnvRTslFoSEn5DJe1cDKnZYT8WsjckEFnnOq/i+ub4MNAyrmR/kRShPydDtIRhaWAXs=
Received: from SJ0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:a03:2c0::20)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 15:11:50 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::3d) by SJ0PR13CA0015.outlook.office365.com
 (2603:10b6:a03:2c0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.2 via Frontend Transport; Fri, 20
 Nov 2026 15:11:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Fri, 20 Nov 2026 15:11:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 09:11:26 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 09:02:48 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57 via Frontend
 Transport; Fri, 20 Nov 2026 09:02:47 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] i2c: mux: Inherit bus speed from parent when clock-frequency
 is missing
Date: Fri, 20 Nov 2026 16:02:28 +0100
Message-ID: <0e51dc507acacd4d4bd05c1ffe97f859c6e1f7f3.1795186947.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3085; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=S7l3RkcnE7Qc7GIBXl9ATuZ/+RT7zJDDlF/+WRz8ngw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQzJPJVfXze2+hvM7ec36/w2/fNW3MT3z6QYC9svrV92
 5Myh4rTHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRw7MZ/qnUhSxSP+K9rHB1
 3vtdF7akthwJdbu7yLHT33KB877L13sZGV5e+5wh29X2Ryzwha+Qh1BFvjQbh/D5u5o626fze/0
 uZQYA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: 021dd790-ade3-4bb8-7551-08df471899e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|261009223027099003|261021123027099003|56012099006|261102123227099003|261026121527099003|261021121427099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: OsYPM6x6yQ/lAFF6keIEtzzr1XU57ZjNtrXDaSHtDsJBEb6+0soKprhQn5GqRaLxP0CCPMcXkpZL0z1GDanKfdCjosjsMq7uJSvUGy/rha/0hAOJFRTRHxb8yQnvsHpfrHpneU7eHaWldoFtsLZT8LRESoD99pQgKXJBli7QXjoR70l4roIiuQBvpinVD2MC1FsJ8l9VEbkck8K6X43GcWW5Bc9Z67wvJ5bnjNBb14WkLFeocll+iDqW+Y2NLa8rrNQGvp5uiDZwPCr7DtymOB1ZvYWuIX3M4FyejUa6q8VApfgsW6sHxBWU/Y1R07fRb/6gI9lKAWyUduoOjmmnEXvBNoP7oPd+Ka+Cx9EwLJAnohJDc6lYKsRzlFNGeZUifKIG0VZH2aZ52gNuCkUZAXDUeVwI7ZB/jlMeXQcnBR6zl15LTwQmNdUE+k2sez9Wyes8EKBKJ/j8ZhcVewSfb/DIUWw4eVl6DmRXP5qmXwQ+wU+62zPEihIeDgUS780HdCOou0bSsg+FsBYXvV+aGinaGW59N/fwRPFfVISIvWGDKasxsNMLkRZFKAl2xdLKPz4FuL9ffYXlbmCpyBvV0oFfHeim1kidP7UKP1kbQB8H3ChWJeMrzkYCBP1uJq3v7IExN/ipkomQihMwrTOBUumwgkgv0Rp+SIL4NBNfJFzu98b04SphC8lr0zwmoKjajK9ASnoUgBeI/6cIs7D66w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(261009223027099003)(261021123027099003)(56012099006)(261102123227099003)(261026121527099003)(261021121427099003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: grm/krmMzNaed6hd21ttRcZj76Dt5mYjvjbktKlWdu15Ud39t61cnZRfLrnrkorsxs5DYvjuPgyKM99wLWoP6ZabdOWxNnK2NfMEpkbSew21R2eEc+inrDFrqxa8LBIL+DSou76h9aqNwL79aJOd1o0iusMlvdd285QlIen+3FFwsYbxUKy0InrUCZ5eZ8xbwegaHDgKLSUbxa3n7aOqOWpjO5pieNgOYGsw+hE2u9ZKfR/rN/klAAPRUsdlp/TD0uASht0hjbnE9aUzrYQa+D+vzeNc0wSB4cYzXzVC6M8gf7I5mWMVOcO77nnpjaLh1pfxs/PiEogs0fD6/2GwKldlUXHwLsv9HaZzTfBBi/uCNrykeWChqnCfaDq7yRy1s8BC1U59qVFlkm4f4NbM6s2gqkyRZcFEbxKg5iUe6jVwqAqhMWXF+856Imc8HsgG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 15:11:49.5366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 021dd790-ade3-4bb8-7551-08df471899e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Every i2c mux channel is a UCLASS_I2C device, so i2c_post_probe() reads
clock-frequency from the channel node. Channel nodes usually do not
describe it and the I2C_SPEED_STANDARD_RATE fallback is propagated via
i2c_mux_bus_set_bus_speed() to the upstream controller. That silently
lowers e.g. 400kHz configured on the controller to 100kHz as soon as
any device behind the mux is probed.

Keep using clock-frequency when it is present on the channel node but
otherwise take the speed from the upstream bus without reprogramming
the controller. Add get_bus_speed() to the mux bus to report the speed
of the upstream bus which also handles nested muxes.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/i2c/i2c-uclass.c           | 27 ++++++++++++++++++++++-----
 drivers/i2c/muxes/i2c-mux-uclass.c |  9 +++++++++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-uclass.c b/drivers/i2c/i2c-uclass.c
index bb32ebd9981f..41a6e6b7a041 100644
--- a/drivers/i2c/i2c-uclass.c
+++ b/drivers/i2c/i2c-uclass.c
@@ -729,14 +729,31 @@ static int i2c_pre_probe(struct udevice *dev)
 static int i2c_post_probe(struct udevice *dev)
 {
 	struct dm_i2c_bus *i2c = dev_get_uclass_priv(dev);
+	u32 speed;
+	int ret;
 
-	if (dev_has_ofnode(dev)) {
-		i2c->speed_hz = dev_read_u32_default(dev, "clock-frequency",
-						     I2C_SPEED_STANDARD_RATE);
-	} else {
-		i2c->speed_hz = I2C_SPEED_STANDARD_RATE;
+	/* An explicit clock-frequency always wins */
+	if (dev_has_ofnode(dev) &&
+	    !dev_read_u32(dev, "clock-frequency", &speed)) {
+		i2c->speed_hz = speed;
+		return dm_i2c_set_bus_speed(dev, i2c->speed_hz);
 	}
 
+	/*
+	 * A mux channel without clock-frequency inherits the upstream
+	 * bus speed instead of forcing the default rate onto the controller.
+	 */
+	if (device_get_uclass_id(dev_get_parent(dev)) == UCLASS_I2C_MUX) {
+		ret = dm_i2c_get_bus_speed(dev);
+		if (ret < 0)
+			return ret;
+		i2c->speed_hz = ret;
+
+		return 0;
+	}
+
+	i2c->speed_hz = I2C_SPEED_STANDARD_RATE;
+
 	return dm_i2c_set_bus_speed(dev, i2c->speed_hz);
 }
 
diff --git a/drivers/i2c/muxes/i2c-mux-uclass.c b/drivers/i2c/muxes/i2c-mux-uclass.c
index 7f4eb914af2e..1a00f79764ef 100644
--- a/drivers/i2c/muxes/i2c-mux-uclass.c
+++ b/drivers/i2c/muxes/i2c-mux-uclass.c
@@ -169,6 +169,14 @@ static int i2c_mux_bus_set_bus_speed(struct udevice *dev, unsigned int speed)
 	return ret ? ret : ret2;
 }
 
+static int i2c_mux_bus_get_bus_speed(struct udevice *dev)
+{
+	struct udevice *mux = dev->parent;
+	struct i2c_mux *priv = dev_get_uclass_priv(mux);
+
+	return dm_i2c_get_bus_speed(priv->i2c_bus);
+}
+
 static int i2c_mux_bus_probe(struct udevice *dev, uint chip_addr,
 			     uint chip_flags)
 {
@@ -213,6 +221,7 @@ static const struct dm_i2c_ops i2c_mux_bus_ops = {
 	.xfer		= i2c_mux_bus_xfer,
 	.probe_chip	= i2c_mux_bus_probe,
 	.set_bus_speed	= i2c_mux_bus_set_bus_speed,
+	.get_bus_speed	= i2c_mux_bus_get_bus_speed,
 };
 
 U_BOOT_DRIVER(i2c_mux_bus) = {
---
-- 
2.43.0


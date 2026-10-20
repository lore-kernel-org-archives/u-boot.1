Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B402606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X5R8+D+s;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=onkaWULf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5682C80D84;
	Tue, 20 Oct 2026 14:10:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id le9idt1YpdVu; Tue, 20 Oct 2026 14:10:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 92B7980DD2
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792505401;
	b=XN0ZV+nOBpot1TMuI1VxDiHktCYhaPJ87R8dfed4JscChKXGcNySJErkRP3hcxTv/3xU
	 pSfbukkCKUVirCMLB/nUgX956l5nO78ulHzsRvIc1vGjSJRVLm2JcWjcUfLLXz/6GzfTG
	 +OFO3VDjZMWtEpn8+BKd4RNNAJzJKUYBFhrqBRUrgOzV7lVEFwaWam8+k6yJcTCBUtEWo
	 ZYx4aQNnLVoi+clt4U+73YJ595Iw0xO9Xh01w/k7u+WGxzq+SS0eWQNBaVFmz2SpmXk16
	 AhW4f/Dqi1GeJxjmpvJndU5+dmvzJlBErF6auk2omiRymHcBp40bz0bAZTif5m/xVTQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792505401;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=VcaF7HYJ0oYRpFZr1LB8vOmkZ1GZrkvsrIJvWFCL99s=;
	b=gSqmCFzvI+xr3K2KD6fUFr2eG7lHxY67gVBXv1LyhBKihRU6MKsP2XWe1LvEoDds7vH5
	 kX4D+TsACrrkCsKWwP1MxqJAvY55c9xnLGJ/qhKJ46YH2fM/xt22LghrD5smaLqppi2bY
	 BgSSQAedYiKpMJU0M90+YVGBQiX0dZfSnE9zf1vQK1ilu9WCqKqsqVoCczUbJ2ZBlX71b
	 plky2z0amOR1Bk95udcifopVQW5sZMSZQeR6IFbo/TG7dKy0cwxrUoY4QvmqXS0ylcE+p
	 Yy3bXOy8LY+KQSrcd1chl8lBHHh46d6Z7H32SnXK3JxwLYQwdvN2urDGpYeMJMRHnBQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=onkaWULf;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792505401;
	bh=VcaF7HYJ0oYRpFZr1LB8vOmkZ1GZrkvsrIJvWFCL99s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X5R8+D+sNoS3Q6Xu/NdmCN/QNFKkhLadc4DROLoCqUUoR+mbCsNF/y3lhOD8KpMi7
	 gwQJ8K17FLgT19dQMHtxhvZClrKTpP+ntShGU4BSvSVZSn8yzxkJx3OuZ1sRimky+k
	 dAizqJgFl3xkd7I/0G9925O7ML2p/cooJSNBOZqKhjJcOjxTiknWJOkMbhCKe1d6pp
	 RO7Qd8UgABGoac5iOuQV+BSLz9l/gnCxj7fnQkVxwxYjYaDBFio6JVGtGpIEnsd+ww
	 09kW3O4oX6HcQeV6tD52VqoO6G8PmBlnGDUgCOeMZXcF67IKQOylfTbELRiFca0dhu
	 TYxUTuaBFCNbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92B7980DD2;
	Tue, 20 Oct 2026 14:10:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 68865255
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E7BE80DD2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BASBRamEVJw8 for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 14:09:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 63DA980D84
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c001::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792505399;
 b=cuj3N904RWDGmeUVuQgctaMedt4TBy99G112z9C4zULA2vP1ni7L4JgZHCKzrTWnB8jM
 zVlNVpOeRx4gJ1JpTHQrOBXPlxOYpTayhThIHj/GHCGFDZvvjkC1edAhbIRTes2GQxb2e
 LJ7/iIxlKgiyG0A4lAXq6BPoiHNEZrids8ikyUdRUTYD9E6P3dhX0QSoh8DY7fjuVAK1X
 TbHbUTw8zLb5qkXYUAz5yx21dEZgBZf/d9YWGCsH9e07ojCBkTVqzrhO1LK433jkqEyGW
 3poLJLl57poFQ6c59dGU6yygqMBFgk56k3ABUReDRZGUvuLRgbxzDs9aZPfmUYe49EA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792505399;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-Developer-Signature:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=VcaF7HYJ0oYRpFZr1LB8vOmkZ1GZrkvsrIJvWFCL99s=;
 b=KAmmCR+pQYX1Ktq6Gcd0ei+O8rOQQLAv7sadgFoLaI/Adfzg0i5FqnM+WKAnOYDhorKm
 Li0h6AB4wHpt+H14INJv1sK15CH8ge9CgutCwb4pXJYD8NrKwq2+pHWUhI3raifOt7aWL
 WmCkhxLGqd9Up87eazbDRjUCJebzRgZAFpLQ21SbJBHIkDqfQyB5OSrRUkL8YRb2jjLt1
 lsVZ8WQ1uphK6/JA97G+ng7l1nupC22y87YW9SqI7aViGhv3lKKfgNkgW1RcdesIpDwfA
 8TdGZYRzuTxmao4rZcHNdCCQfC9FqOVsT4u4Hy5ydIuMLKhLrqN0b0P88daQavT+28Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=onkaWULf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c001::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::5;
 helo=byapr05cu005.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=onkaWULf
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 63DA980D84
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:09:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtVhnt5Gxiz3rVQBwNgYQKxcfN8SQ0N8cWFOCK3jy+2HpMKV1lzf8gwP1WjS6d4jQyxndX5AzPeyhr85ca1kRss8zR8Dq+dPporblXGRsbCdB64oa+AUQdM0CtV3GCDQp7kA2XkmgqsPycJ8W7BUC4QE+7A+S8bGUuYKIDtcEJqrn1GZrb031sp9GJizlB+04tlgay5j6nUAGDx/iE7jxaMG4iBV/JzXbglX+x+0cq0WRIUUQ8IbUd7i2J/vDX0cqs/hx+y2vtGYNsMjuqQrcHVyxEVX/0egUni5jtfB6VIPlZuLKhNicVoiSX+WOmnHtiG2fmpsguo12CM7r/wLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcaF7HYJ0oYRpFZr1LB8vOmkZ1GZrkvsrIJvWFCL99s=;
 b=LKcy9Vd9avpCGl7uvonpLpRoH/1EX3dfZtH9H4VF8JAZVMhUQtqOtzfCxVviwLioD2ATD92Qkd9CMf1m8H8jbn/sxcaovsK36LQpTDxvPUl1n2l1nn8DoilAmdYia5wb0vq8jdKYR2avZ6C0HFVs5jOtpiSJgAqggWmArBJzy+LbymlZZbsCkzGD1hxGSo+3csiTiDGtWdinzlJfCyURy3Qd0BU0lgDg0RqfXYKFRNhXrgIKbwg7MvYbLRJbxnltO0Q3xC7Vies8u8Ou8Q97n4I1gG/pcE6oLxD2BmiPAeOSfTxWMHh6wGHld2lkr5wYoRxxQLfxl7zX7HBpFyVAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcaF7HYJ0oYRpFZr1LB8vOmkZ1GZrkvsrIJvWFCL99s=;
 b=onkaWULf0+yD6b+84sjYJP1OnDEOKd6NEmPHnN3WBCTRxRkvs8OGGQ/4Yz7WZrUbHe4p0nqq2RzGykIf3tooOYUW8kj+GUXzPgVP4gODsrTVxS2FTfHKCzrsvS3/EFQgc615k1YPqE7mKlCR6ZjcibT6/CGXXuHe0tBxQNIeJ5A=
Received: from SJ0PR13CA0069.namprd13.prod.outlook.com (2603:10b6:a03:2c4::14)
 by DS0PR12MB503760.namprd12.prod.outlook.com (2603:10b6:8:4ec::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 14:09:55 +0000
Received: from SJ1PEPF000037AE.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::94) by SJ0PR13CA0069.outlook.office365.com
 (2603:10b6:a03:2c4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.14 via Frontend Transport; Tue,
 20 Oct 2026 14:09:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AE.mail.protection.outlook.com (10.167.244.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 14:09:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:09:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:09:52 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 09:09:51 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Leo Liang <leo.liang@sifive.com>, Sandeep Gundlupet Raju
 <sandeep.gundlupet-raju@amd.com>, Tim Ouyang <tim609@andestech.com>, Tom Rini
 <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH 02/11] riscv: dts: mbv: Update bootph-all in xilinx-mbv64 DT
Date: Tue, 20 Oct 2026 16:09:24 +0200
Message-ID: <36c1d6236d4e55b0a095c5f09d229f825559c45c.1792505359.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792505359.git.michal.simek@amd.com>
References: <cover.1792505359.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1343; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=LATT7rTXD0VCcwN8awTjfgLssnM5wEV+s+YoWQ+d+/0=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL5PeUDdx8668AzbVk90PPg9qtLka8nuD334x3nI2/
 dB2pUfFHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCR+gOMDNP6hPWtboTkL1Nm
 Ccl+foyNqc/xF//7C3MmFMyJKLJ5fIHhn4HdrhKvf7H1q9ee37FZeLL725agLRLxWc9rhcsPrG2
 z5AUA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AE:EE_|DS0PR12MB503760:EE_
X-MS-Office365-Filtering-Correlation-Id: bc7981ee-37e6-4802-1a72-08df2eb3d0ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: bq9owVCcHuPKuE6YDVnNac8y+PdNCnLBwz6FHuxvVIliUHg7MNw1rjQTm/lrd35oKcYUgr9c3QNtP4uywjZrsLIEHuVGMtNW/RPsRQvmutWIhm3+XFYGrRMrZD2ibAfJUXenlsq6ofC/hG8NZFSdyb3ezKFfK0MLlfE/xpEu2S0zAAguC193trX8SX5nIBDswHja7khqNEM4nHgVZM6LkKSfvNg3sDqbdgD0zm+nq56wkJRgw+NvnW2XfVwtSeKlgN5a+zDz+g40Re60kxdYUopyTsCPmn/xLj3ZoCzAOqHj7eu2cBqD3sZF8kLO+05DvKQ7blLQNHCqNSBrKKgHtuebxbipPULuv224i+aW2JEFR8wySLMn7aHP1/cXB5EEiHbv4evBpW2Eaa6frb+Ox+cyC7sV0hhkf4e17n6C4jwjc6EoCoiaANMNwRA5IwOqm4YSoDnT7VKCOvTGsHIsvyIluRR5M64PDm6sZCm0sJhWFR1YZJU+A5x0r/wWN3WNfz6blqooLzU2t8GOFoivEEo4Y5keHiWJ6ZjC1mdAvLc1eYcQazeQU2MYWt1nfwbfh3hbVIBXi4ZXv9TgWKVBDqxblgr8dH6OW+JdoecXIiGipZbkWJi54ibEmB+FJErVB1SI3Tz5//MxjWpOsKP9QbKUEVKJwO12sN9hw2giR80/gM6H+mqRe6tn92YaNsTHWXYT1IC1kWJB+TPqNY6NPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vX+l5MFIDhygrJUobB46qItU6nTPZ3eDKOtgUxJDz4H7CpN/6YRfFehptwSWZUDOrxeosFH/HyGYHjjzp8CIxEUGsndG7OY4epDjp0OHIezuxiKnyxGwDZXilNgLCR9BlFpiEcV1POTB+DGIRD3O7OOXL/X2DbMqu57daZrDpvkvPfrRMFh3PycF9+ZLmnT1sIYSK0Y+YQrzc3ImOyLzKKdUtOTkNAo2e/lw9zSFf/zx/NE87mUS7jsRx8s8x3MAd+Xs/hSGdppwa5R/xBwwWnd3bDIxfmtbWFCTXGXMsgokwwKqoBkNKKqBJflyLzA4naDOoDOMNKkXoBzI5zeWMZrzwISuq+wioyTDEysy1V1vgu/KM7wLdBS9rOOmUOCGc9PbL059bb6XE++mcJmT6rpzqMiXupGby67rhpuRpNveo37sIREWhouirZfUeLK0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:09:54.9588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7981ee-37e6-4802-1a72-08df2eb3d0ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB503760
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mark cpus and clk100 with bootph-all to have them available during SPL.
Also remove it from axi timer because RISC-V timer should be used instead.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/riscv/dts/xilinx-mbv64.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/dts/xilinx-mbv64.dts b/arch/riscv/dts/xilinx-mbv64.dts
index cac7f65cd569..46950155bbe6 100644
--- a/arch/riscv/dts/xilinx-mbv64.dts
+++ b/arch/riscv/dts/xilinx-mbv64.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for AMD MicroBlaze V
  *
- * (C) Copyright 2023 - 2025, Advanced Micro Devices, Inc.
+ * (C) Copyright 2023 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -19,6 +19,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		timebase-frequency = <100000000>;
+		bootph-all;
+
 		cpu_0: cpu@0 {
 			compatible = "amd,mbv64", "riscv";
 			device_type = "cpu";
@@ -51,6 +53,7 @@
 	};
 
 	clk100: clock {
+		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <100000000>;
@@ -78,7 +81,6 @@
 			reg = <0 0x41c00000 0 0x1000>;
 			interrupt-parent = <&axi_intc>;
 			interrupts = <0 2>;
-			bootph-all;
 			xlnx,one-timer-only = <0>;
 			clock-names = "s_axi_aclk";
 			clocks = <&clk100>;
-- 
2.43.0


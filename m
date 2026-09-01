Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4006FC61DD6
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 06:32:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2C5340663;
	Tue,  1 Sep 2026 06:32:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MNwHQrkKrUvc; Tue,  1 Sep 2026 06:32:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788244374;
	bh=DwY+bEUovMF0ibiMstymZuY13cZWlWuBL72ZbAOKxXQ=;
	h=Date:From:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tDTX2UU5k7Gl1JN4yBJiI4hBAzA5jfVDJugZDznXjZSi0Pk10eEhGjsGf8hcNiwl6
	 VtKR6ciFUlYQA/C7QFpnQYd0SEZmsDrokL5rhFvM1NLDD+g9eIedkl1zbbP1RJFr9l
	 kvgqI8sZF7t4kCJJB/8JNhTXvsSF+Jk829s8mk7aDRxktzkk0X4nrJCSJ9MAZwEW5q
	 p11a1F3t+6sTWwoyHyTcO6QGjwBZyv55VrTM2eN3jF4qi+p3WVJkJlxhRZ2gzUuuua
	 1zzwW3HFSqebcoTUThqnOn/rTQOs1JmPbQOdhEQXtSRLu7GwhQYYDj+PFH7VNf5w44
	 Ccvmc3WF/8+3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05BB840666;
	Tue,  1 Sep 2026 06:32:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CEDD51D9
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 06:32:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AEEEB40068
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 06:32:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7iTHhtuwbOuc for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 06:32:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=U5Hr2IXT
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 32E6440061
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 06:32:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xW7roMmS/VMLMvu9GUbrFp97PWv9FkQaMAP2ZVMySEaBGjBdogbdwpSd5dhBXRFavXO4FMn8K09yGJhlESAlxtbIJLfzlTiEWGEJnjMtmDmXUGSspY6IKvf81o7J9W0E9pZXaba3xZY5csbeo2khtWlyRoUytyHRMTkPhzXiYA09GlRG7EOgIMfmPb5LtsANzWnWZnDLidsMjxcjRIOFUvM+gaoddbeEmD03raxC47suWZnYkEYYkP2GHurOrYcoPok5EZi47CqUjiXNnEyt7K+NyUZeMPNeu0Wc6U4vvcjs5l0yx2LU8p/kjmZdBdddH/w8a9LxrGi0ov6tUKoKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwY+bEUovMF0ibiMstymZuY13cZWlWuBL72ZbAOKxXQ=;
 b=SjoI5CWNWaLKrtydwOoPZ62kVXSpG63lmFJ8v5Pv90Ncrmp3UxNfyK0kychtszUEC68oPASW3sgSPE7MF1DrQopTIRnhm6l1WKLvlEwqt8HF8O1Cak65LTw7lcCBk7x9Z0IY85lQgSGG2gw4Mz850SOQb13JhYU4/mAdlKzHCWJf75IzKPFSQfBV4zDgqtW5TPXzM0FQX7nbCwcg4oRWfMJpA94sR6A0Z+IAy3ncIlXWBpmU84rkOJ+p3zTazfWADySjcG/ttgd1vDzjojQ4XgOvw/v2oQS09EnoXbveRlnf1m2X/oxdVYRdFt8V7ZkDH/A9lvwp5jpyyRP3S1iFDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.87) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwY+bEUovMF0ibiMstymZuY13cZWlWuBL72ZbAOKxXQ=;
 b=U5Hr2IXTOXxfzVp7f1h+E1xKqnNUo4HKDLDq013wZpGsuS+UmDOSqTs0fC+p5rNJI4tDk/kDImb18lxU6yPzSKIGXCzFWUqPutHb0eMa4WNM+55kdyaqa9mG1ZQ1AQggJdfyY7IZiOJpyo/4ZTwytbs7Jy3GAT2Z0ZSYxQWEOlSi6RwM2MobcFjpgthY1oPXgcnSdAJftTcQLPAEfdmKyBYKgO98vZgy/WOjikrP30vUWRkM6hbIvueSow44c8WPu121UQnWtk31CyulZbS1l7fafbw+KnvRsoXKmhQI5mKnz2F2YNZ3mswKMStM9TkYxkcSWveGssVaLQ2RG5o8+Q==
Received: from AS9PR07CA0011.eurprd07.prod.outlook.com (2603:10a6:20b:46c::18)
 by DB9PR10MB5882.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:396::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 06:32:44 +0000
Received: from AMS1EPF0000004C.eurprd04.prod.outlook.com
 (2603:10a6:20b:46c:cafe::9e) by AS9PR07CA0011.outlook.office365.com
 (2603:10a6:20b:46c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 06:32:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.87)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.87; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.87) by
 AMS1EPF0000004C.mail.protection.outlook.com (10.167.16.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 06:32:44 +0000
Received: from ENXDAG1NODE3.st.com (10.75.129.196) by smtpo365.st.com
 (10.250.44.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 1 Sep
 2026 08:34:41 +0200
Received: from [10.48.87.93] (10.48.87.93) by ENXDAG1NODE3.st.com
 (10.75.129.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 1 Sep
 2026 08:32:43 +0200
Message-ID: <2a8e01f4-9346-471d-90db-5f51b04f21b3@foss.st.com>
Date: Tue, 1 Sep 2026 08:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot master / v2026.10 =
 u-boot-stm32_20260831
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.u-boot-project.org>
CC: ngotra2710 <ngotra27101996@gmail.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To ENXDAG1NODE3.st.com
 (10.75.129.196)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004C:EE_|DB9PR10MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: fc41e2d8-4109-4cd2-a5d7-08df07f2d4de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 2S/cEeuNas0xvsaR5mtpC2YBqZ0B9+2ixSIpROUnh8cklU0JDWHEt8sZH/ksd1blMv/pAfzEGpIaKMkeYgNVitt8kULnutBKWbnq6P+Z4WkFahYna9B8GYS8kZNJqYKXH1NVbF69/KPZ2kqPdUkccL/VI8bsE0nZJprKPK4sPgI+vFPGAkCUZHeJSYbpNzO1oXZOsOhv0D7eHhpCedSXmiZvNv9YINWchrelKrFkdGUgSKgMotrr+gOOrHeXp53YXTXrZXpnBAqVfkxaVihFidq8vbxUf7XoRYdm5w3e3UbyobFhO1ZHJIBY77FH1n2v6RxEHiMQ0O/75LO1dkkEpK8Qw54vH/IeyaLsEM7CltAsuv1TZT1Z5hOpmQ4EuSUK1AHKD5S6Ku2ubd6rUz6TLDDscXZ/Bm2INxUNSiDr5PlOpWSKFeGr+ahwJ0DYuNNGHg/ShktDQOW6DiDOHwiPyaI3SPTz7aAzQ7ujDPIp4gVWQVN6jvvgy+yFjRKf4Vl/tnLbvcOe/XTiI7ab6WNZ+gdG1QYLMU1Sk3VXtpq/ZFXELxvVWG73yaxirK//ArPnQ3ebcKblOR6Sc3VtPlIgo4VBvpUl0QrQsTNLxyXK+OFlZCIHzUgnQZvAzwAsDF8eddFk3xI3eaOr5NGUy18J/g==
X-Forefront-Antispam-Report: CIP:164.130.1.87; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p3nYuBI5tDUec6yu5lVjaPCNDlsQmYWDPWbTw0F5Eb2Ad3TTIi4mCgorasv6s2ZFVtdr4Lx+Rx5rVTposkcUy8OydSKxyUtZsBchAWU2e/NiktquIMWPtmF/or3+G69uOMh/LLcB595FlxyCFmWUxWRvHm5cCgqxsa4gJklp0BSJFOQsIOPvDAeTsXl0/NUqy7LEKasdftOohDHfv37rnwPZJ10dxo4G5LFFOuyRfU5P0+gXKBDOK+EseOAVkrfKPJDmdxYYVl0gIyCLiHEnTPz1R6QBuUL7RQXwu4YEvKulsCj6vrKI+7GuPh/R85puEECcwy4lZlWnSd8RN6X2jG+Ve4ZoPY20tQNS70NhmtE6vpn2NA7Li7aKFtOYQsjGVYtSu76Ddoy4zPZrMdq2N7aXMe/CR30NcukgR5h6IMTzmcAUhcdwPm061cBEkeyC
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 06:32:44.3925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc41e2d8-4109-4cd2-a5d7-08df07f2d4de
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.87];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5882
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

Hi Tom

Please pull the STM32 related fixes for u-boot/master, v2026.10: u-boot-stm32_20260831

CI status: https://git.u-boot-project.org/u-boot/custodians/u-boot-stm/-/pipelines/1132

Thanks

The following changes since commit 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc:

  Prepare v2026.10-rc3 (2026-08-24 18:46:24 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20260831

for you to fetch changes up to 62ea65e54ac7a5c5accda8127830bd0efa4109b6:

  ARM: stm32mp2: fix TAMP_FWU_BOOT_IDX_MASK/OFFSET definition (2026-08-31 10:02:15 +0200)

----------------------------------------------------------------
Fixes:
  _ bound the invalid-argument message in stm32mp1_ddr_subcmd()
  _ Move TAMP_FWU_BOOT_IDX_MASK/OFFSET definition to fix STM32MP2
  compilation issue.

----------------------------------------------------------------
Ngo Luong Thanh Tra (1):
      ram: stm32mp1: bound the invalid-argument message in stm32mp1_ddr_subcmd()

Patrick Delaunay (1):
      ARM: stm32mp2: fix TAMP_FWU_BOOT_IDX_MASK/OFFSET definition

 arch/arm/mach-stm32mp/include/mach/stm32.h  | 6 +++---
 drivers/ram/stm32mp1/stm32mp1_interactive.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE9DCD8CB2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 18:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D713848D8;
	Tue,  9 Jun 2026 20:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="COX0Upf2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98F0D84704; Tue,  9 Jun 2026 20:10:29 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A145E848A6
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 20:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxSdgGI151ANGl2+yil0aF56WlkvtwT0GzCXOt3vpp3CiOSb6ag8zVmgfxucyHIuxkFa+3Yg9R4aqZKfcpqL9B9qjKDaOIjdt5salvFxch9snbpk0PW/jrCrsXeM99EnYPRntzcVYBdeeSOhxcQ/sxaGM1k9orW/rrZC+9phHg5jdzT/8l+8tCoGQM9EOFezL8lwjNfXlYIwG23he2smAY6bwWIkkUgWvUZ/tKKJ4QaL0r/Emkbb7Y55Ru83p3I5YY7pZzk0oSjXVKKrvMwp58d93N4dxxxAennpzCC/JVzDnMWR1AYYI7AZ7H3+xS9Nxd2U8KbFNO+X4FW9oQDSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2ILppgGNn5gNZZ1jywKLtrEpTcqJODeIioVTEAA69o=;
 b=o4yHxy5KnyC4HPsmSdELycyPsInz/1Vd3InbvA2bGswyhSk3v11sXttvXLUMolL13PX6ppr6//SVjeVPq1ts4n72gqsfwG/kXnUaVbF5lkluKcYyYRXmsiiDfeBCXy152KvnYB0+gQQd1hDqOJUWxHY6qQ2TTb+SLM7ZrtPhWK3JomLUnEHyAEzrfWWjaqWnGUWG/0MdSYEJR0GyNpB/LnyksL/Y7ZR8pEX8EkNbXsJ7WHDr8v4q1PGVemRgqlK6LqKq3GlIxzkLAY/J1u4YggKeQYwkF4+v2zHSHHDLoQm8BE6XlRV1kMe7cOJ9pDyFqGWPIvNP5WP3dXdxqoBS4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2ILppgGNn5gNZZ1jywKLtrEpTcqJODeIioVTEAA69o=;
 b=COX0Upf2RryuXv9SyCsNCzlg5TSEhFdYyF93O8IChPqMMHgT0bwAmXroaiP2CgfAb3I6GjsUx8AUCngFes6rWspON5FcHRbaMBt6TYnZRZfXYBzUXKPUfqRDTsMjO9JxXCL6Nm4UVuPk2UTw8hsG4odO38EAWA69WWjJpBUVv8A=
Received: from PH8PR07CA0014.namprd07.prod.outlook.com (2603:10b6:510:2cd::25)
 by CH5PR10MB997694.namprd10.prod.outlook.com (2603:10b6:610:2f1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 18:10:24 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:510:2cd:cafe::ac) by PH8PR07CA0014.outlook.office365.com
 (2603:10b6:510:2cd::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 18:10:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 18:10:21 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 9 Jun
 2026 13:10:19 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 9 Jun
 2026 13:10:18 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 9 Jun 2026 13:10:18 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 659IAHdm2168402;
 Tue, 9 Jun 2026 13:10:18 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <b-liu@ti.com>,
 <afd@ti.com>, <anshuld@ti.com>
Subject: [PATCH 2/4] arm: mach-k3: am62ax: Enable OF_SYSTEM_SETUP for AM62D2
Date: Tue, 9 Jun 2026 23:40:04 +0530
Message-ID: <20260609181006.460401-3-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609181006.460401-1-p-bhagat@ti.com>
References: <20260609181006.460401-1-p-bhagat@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|CH5PR10MB997694:EE_
X-MS-Office365-Filtering-Correlation-Id: f3438d7f-bc5a-49f5-278e-08dec6525f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: uoPn/i3/bGJVZVI2ssUrW2dI5uggc4J8rNak7qwtbeC3G8KdDU0Tg1YwSyeN76NiJtntY/FJ+RnhUgJR1UU/AJCrIJafAz+MxXjUSD3wf9mDzokply/LVEm0VYmlWq7jLmdBXLFEDwild5ihUEAmWETS47uVWuB6P89qOzVa+WumZVP6avobgcg+XebXOAp7fzcxMiE37LPQusVx8tgOBzp2CuNtqvhSmqgxqoKHnyEyfOshw7RLbpePuWL/DQo8hwSO2OnTeRSrR1SfwwpzH0OT2Ct6MDVhFHm6O5F91EYAT9TB+NqoNGea6AKM5yJ2efQ3gwXexugHuShjAjU3rq3zpzLuKqPslOZecUyrZS2C1WipQ2k1qGhPGx7UQXEPM9UlvSF1qFrLHV9XgsTIEMAaccf7v99VWJXXIbJNFidbAq2KvFurUX5PUaGNPUxUi/MrcXphbYO/Y8LymJL5rkaFz+1j4xW4eHI28qtunZ9syXYKu+SdoPTE94inRkYri4plBnsich8PrdjZEq5VBjiHV/hNGq2bbSzJ8jR/kciGufAXq7Xyn1ulx4dkDH7H93AMVJImmLZ4ozZAN5QNglfP8qW/p7UlDmKOyK8dUD7fU/5kZXdia4XAlQfz+xF6HofjfwijyKcdYkT2fB6UDfogjy29DatnGyjtjJlDCWTYR0JkT/FdeV3e8o2v8m7QRLm8/MqHJ+oPNLLVljwL8Be/ZnYqR/12+9tdZYzFYbw=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L56uS1k4AL4+KfkPfxKKRDDfWxErrz+DEmuxIgqw5SZQnRJWesKBXawicDMOIkXr0zsxbA8ylwj7+tb8S8ME2QQaLJGLQc8elYCUK45gMigoogpmVZAoPTr0bu0yaJHZ2yJWjNr1EA/Nl1XAW2+LdMv2Qp/gAQreZWYlLcmHixzEQd6Hg/FKOtwX6Bu1fVwD1KXs/O+feuv1wuVUuGlKFuLIHsake/JNmxxTZ5BjtKWFOJMqxRkfdIqtriwq/Oa23GuET6iF8DUqbcIIozgc+Cf2KspHKnWJJpwnGAmX4xHyZL9RVI1+Hr2J+YTZ2JHk8V5gABXhfJ66zzljVsjkfp6mrrNuTMwPsdcIiZbS8ec/6Smme0PU/QqbYvMRDudfwp9N7TeT3BWjgvc15fLoNvNEMfTFngdqxDY/fkvdUGcnWmxy7magbotb8k8QrfxO
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 18:10:21.9816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3438d7f-bc5a-49f5-278e-08dec6525f3b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR10MB997694
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

Enable OF_SYSTEM_SETUP for AM62D2 to ensure FDT fixups are applied to
the dtb before passing to kernel.

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 arch/arm/mach-k3/am62ax/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-k3/am62ax/Kconfig b/arch/arm/mach-k3/am62ax/Kconfig
index 6a3969343ec..e7c2a2de9be 100644
--- a/arch/arm/mach-k3/am62ax/Kconfig
+++ b/arch/arm/mach-k3/am62ax/Kconfig
@@ -54,6 +54,7 @@ config TARGET_AM62D2_A53_EVM
 	bool "TI K3 based AM62D2 EVM running on A53"
 	select ARM64
 	select BINMAN
+	select OF_SYSTEM_SETUP
 	imply BOARD
 	imply SPL_BOARD
 	imply TI_I2C_BOARD_DETECT
-- 
2.34.1


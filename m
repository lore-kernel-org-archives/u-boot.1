Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E44CD4F52
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 11:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C4E88460E;
	Mon, 18 May 2026 13:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ga6KWUu2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ABEB84688; Mon, 18 May 2026 13:54:21 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C76C845E3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 13:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Be8Cx1+c25CmGsGhEFY0adZcdcMJr5WyIDjIlioE+2zWme5bHspzjqJhAreB2HBYlx5PSxuoMaV4Hwg46q0lRMgqOCondTEZYzL/MMNbjUaRBPmSLSy5Y/+oWv88ja4x1ze/LZ+jUnwWh0RumqDuQu5jGmW0/0vmutZB4L+qeqr2ihS7jTAZeqonbTL8dO9Gjt6YtClqOIDCG3TtwdJcKixn1jjdUBOd7BQyh6mGZlkijvHRMO86FaaUXhS/NQ98WQE7eVrlOC2qjXF8Yru3cxIF8PcxmkAUKvpW+WzUW4gc6kdx1jRO9cjZPgLGynoxrY/5nESBPKhiTC8XznmSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynFzbaey3UQ46VpGioadqgpUPccINu+/kFDWpbOs5UU=;
 b=w0Ka06QC4EgcN48WsOuX+THk5PEYeoBJuTamvyIXVO9iP6USQB0g9ErhepOEYkqrVP5kPSk5KcfJAV77XndcOpygDrqaOehG/vqQ5WkqutEkEEvIp1sM0XtdiJyoN2GntNxsjduUH6BuxIRUIcCBoqcQlELOtX9wMkkOilb5C01dsG76M+NSfUR2WeHwwoXQrEoJCjlgfPByjFp8oprPatbHS6nckEKLnDAciuVvh1KjJEQtDwdGe6QHov3NNjhdlGKZRCVhBwL4kfC3P5ZKq+CJCb5lxjO39XXYim+dkHKyJUR2bTlAryg9uWD0TV68TpHEFCDUJTwkAdkCy/BUtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynFzbaey3UQ46VpGioadqgpUPccINu+/kFDWpbOs5UU=;
 b=ga6KWUu2/Mu7A79Qooe7hVg0UxsgM1H4+sq4TATlECg5Ws8zk2QsOa1rLAVqLndihB/2JjC0wSbubdjLuVwocdUvRlHLzHiu+kYCFovrv2/eXdcXmUHhmn5NUOVYwMHwWqPbByOXykAFaTIHGQ9+zX4SkY7CnZ9G7eD1I/4USTI=
Received: from CYZPR12CA0011.namprd12.prod.outlook.com (2603:10b6:930:8b::12)
 by IA0PR10MB7275.namprd10.prod.outlook.com (2603:10b6:208:3de::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 11:54:14 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:930:8b:cafe::9e) by CYZPR12CA0011.outlook.office365.com
 (2603:10b6:930:8b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Mon, 18
 May 2026 11:54:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 11:54:13 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 06:54:13 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 06:54:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 18 May 2026 06:54:12 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64IBsB8j1269275;
 Mon, 18 May 2026 06:54:12 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Mon, 18 May 2026 17:22:50 +0530
Subject: [PATCH master v2 2/2] mach-k3: enable mmu after reserved memory is
 unmapped
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260518-am62_firewall_exception_fix-v2-2-bd6e816ec23d@ti.com>
References: <20260518-am62_firewall_exception_fix-v2-0-bd6e816ec23d@ti.com>
In-Reply-To: <20260518-am62_firewall_exception_fix-v2-0-bd6e816ec23d@ti.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Mark Kettenis <kettenis@openbsd.org>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>, Moteen Shah <m-shah@ti.com>,
 "Beleswar Padhi" <b-padhi@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Chintan
 Vankar <c-vankar@ti.com>, Suhaas Joshi <s-joshi@ti.com>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779105247; l=1331;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=rL7fwDrpezAbuiL2bDU4G0ZZOjg2UwEIZWtyN0JZ4VE=;
 b=DxmJr2RN2fdNqc66Rj/QdB2WZmvSu5H4VH6y3IvA30RZTNAKtbZ2hdDuGUaBhVkQUCnPLedMq
 EPHfoGfATC9DQmAawlGFxGT7VUciI1v4wF02rRIBcRuYDWsDdHbH1FW
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|IA0PR10MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e240aa8-a07d-4e44-88af-08deb4d42e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: /q+Y7d9HeyFJlBhKW1PAiz/HZ3VGuSIa4wWKnl1KDE3rYXxdvEl2UogR4SWz5dl2bkUxUyDLcHOYZ2HEddxkuEmT+AXjYxamb2///sS9e68wFQ9taSL5R0ZdxA8fCeR2W3RxTx1GycSc7Di5OcYIBSvI2gEyMv1Ho3rcg3bhkRviS3R+xjIo/KQ+mOPX+XTqcRa8fT2Xy+rStQjTKDDpqgIzHz3z9x/EhwsY9JJz3HC4fVVF99KGfLILgDS6uKhDHFlnzEbHgpe+c9D5W80c4VpnWs8hl/dB9iM+2JJlip10EL+EXvrsr+HPAGVC8JR9/h19PdCWwNeGb+RHFeI6VWrLLXFxSypGPCF0HZGLKlh0pkfDWYFDu+Gisv7j27l1CfIr0r8GV7l/3TJh1U6fuIrYQuJwv+qu/MPQ6VKniIIUVbwVEaskWC4SjObeWUhG/AOP1IiTsrTFXRP4AW4uUn/KVcHCC0rwnRrpC6jW+eKO63/D2OVPBjQ18wF1xBwhfJ/uml7p4N7+hmhYMk3EUxT1+UY7m4WH+DTYlgOWcaZ4yev+2Mpr+uFDSvvqVXXhFfOTLY9zzzXUOiEGLnpOAATG4tmQEff2WCw1s0cS7lDZxsmhBIv1MF8jHkGj2nJgINtYfbvBwEvxpyICxRCxfpVSlXng59Qw7qFeVLPVL7GqGfi+2fOFdLACuS5v6CCjoM0RWmYZ8ThKTJsyxwoHGqEtGtX/MYkRX9+i+4ZS92U=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Nt8nInXD+pzKRYWJMvYruhDk5xpgQ2W+XbqyBe8HFy77CJ1C9zrc/Wuyupf0nu+6FzkQwnxPus3o4G8E8SaTftorsFP+elznN4+/NP1/pVgexLt0jC9jsyacxfcJNGBGocxCmRDvrG+ohWE26t+yxEPlphmKdBdWWoT87ch0St69T8Gr1Sr/MveGouAsUA2KiZrbwP+gDr4BU540P4QyjjjFIG14LskCwnVp1uZLTO50AQvuc1WHY76OsSdin2w59D6Ud02ih60IK+TnFux7IG61YcdIRIpK/pkR6nmu4mCaRm9zv40z6krXV1b+TXmN6qh2r3VK24sEHyPs8FIiOKRrCsawDH7YZDr3h3r8LrUmLFRpCr8/Oy1cQ3Sq9FYWL+LEjCUlu4z1n8iTYidbkk5zmfD5Z/BYezYadUPKUj7h1sPlv+hTWETog+6KCuIC
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 11:54:13.4328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e240aa8-a07d-4e44-88af-08deb4d42e41
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7275
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

Currently the sequence to enable caches for the A53/A72 core on K3
devices looks as follows:

 1. Map entire DDR banks
 2. Setup page tables (done by mmu_setup)
 3. Enable MMU
 4. Unmap reserved-memory regions
 5. Enable caches

However there is a brief period of execution between #3 and #4 where the
core can issue speculative accesses to the entire DDR space (including
the reserved-memory regions) despite the caches being disabled.

A firewall exception is triggered whenever such speculative access is
made to secure DDR region of TFA or OP-TEE. This patch fixes the issue
by re-ordering the sequence as follows:

 1. Map entire DDR banks
 2. Setup page tables
 3. Unmap reserved-memory regions
 4. Enable MMU
 5. Enable caches

Fixes: f1c694b8fdde ("mach-k3: map all banks using mem_map_from_dram_banks")
Reported-by: Suhaas Joshi <s-joshi@ti.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 396018b7a7a..9bebc0b1106 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -295,6 +295,7 @@ void enable_caches(void)
 			       __func__, ret);
 	}
 
+	mmu_enable();
 	icache_enable();
 	dcache_enable();
 }

-- 
2.53.0


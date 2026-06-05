Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4C3CD6E7C
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 19:38:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29359846B1;
	Fri,  5 Jun 2026 21:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YbdT3wZL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F342C800AE; Fri,  5 Jun 2026 21:38:36 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9536E849CE
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 21:38:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXoHkJBOvK6kxaYRO8+mBZpOQUF5WxyR4BlpC++oJIcdhDuxfVqQKd5lJ65YdLAJqgPHkTNJHGUDTBiZLkhJ6Q8LL0fuPJE9TIwUpHAGTyOX6jG7MBq/2Rvr5gy3lXUCqBE0J79o45VskxZQwvSqPC6GKywkLv5GPZi87CFilqf6LqnYZwy6OglqzLAyjf+8zJBbqSBsoO+ylFqRkgJyZ/f2GbTFnMMiVbwRX9yXijjOXvCmhdFFkWMbP3Avad7qXd/3Qop4E6vjvcitocwCGnMCqAD8b7WyCIEr7nQabqqTS8Tx+fxoCW3z4gjYhaRTPr9q8N3Gg9sEOMTlJh7V0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzlshrHSU+1Xyd+DLef9b6JvOMwfb7R5VKMS8xVF7kU=;
 b=sXZLoXsFEe8S6b3JO1ICrnmSMPNlhNf/SnslvbOi7NIWbAOFV0xeqqFyl9aRp6rUhjS4M6sCBDmzqnL2tsQYIDin2ocX5MG6iNXzEONCpdWBu0ItTM8IFl+Y9Wqaj16phvUgEz6TLur5XHTdLXn9ya96ZqtsfqxkfiQEBQDH6CFPRjkDL6/6S43SolMKKf0Vr7859cUmLxizFd9EfYJb9RcRYCQukZHU8qfi8EtEhJfkGPd3hEF/jBNNmoqyUtzYvRSTMkVxWhphvvWCYAyeP/nsM/dxauKTAcspmAgmH2dvFkBv/bJX+1sSILt8QBGZsY7pKWrGdJPn0rUrFJcBww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzlshrHSU+1Xyd+DLef9b6JvOMwfb7R5VKMS8xVF7kU=;
 b=YbdT3wZLtc96M4lzs2WwAxqjcIs33JR8CoJ+nEqzwwE0tlIsCNHErfA63QbFyCBkis1r018s6OFU2m3zMtZK/sbwRbABDgVE1Exta39Sxff1ckPe7p60UGfzB1vMN+WDHZki0ZPqMVZQz4nTcjgkLuRfmlRadBbgW65xb54pCfs=
Received: from BLAPR03CA0146.namprd03.prod.outlook.com (2603:10b6:208:32e::31)
 by IA3PR10MB8489.namprd10.prod.outlook.com (2603:10b6:208:583::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 19:38:31 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:208:32e:cafe::3e) by BLAPR03CA0146.outlook.office365.com
 (2603:10b6:208:32e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 19:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 19:38:31 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 5 Jun
 2026 14:38:29 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 5 Jun
 2026 14:38:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 5 Jun 2026 14:38:29 -0500
Received: from uda0271468c.dhcp.ti.com (uda0271468c.dhcp.ti.com
 [128.247.75.164])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 655JcT382005785;
 Fri, 5 Jun 2026 14:38:29 -0500
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Bryan Brattlof
 <bb@ti.com>
CC: Anshul Dalal <anshuld@ti.com>
Subject: [PATCH 1/2] arm: mach-k3: am642: Update MAIN UART1 serial alias from
 3 to 1
Date: Fri, 5 Jun 2026 14:38:28 -0500
Message-ID: <20260605193829.395161-2-vishalm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605193829.395161-1-vishalm@ti.com>
References: <20260605193829.395161-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|IA3PR10MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 76daa786-0ce8-4849-7676-08dec33a0681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: Qmgmtg9xWqT3E5wy2zy25SNveFbQjej6ZfhwgofanBF7wRD4lPe9Kzl7FiK/gSYoUThk7y0UmYW+Z45UGR15R+jYcdgQQw+juKy2wN6op9F8xxp9fCNBylAlJH1Ubpsd2aPcaBMBJ+uOi7b5a3a1rmBtdRU1j7pC5IF3eQoxHWIgg9jeHi9ZBRg0dReaXmdN2VWxtE4Ewe6VJublJed0yf1xkTz+2F4Afa8W2vX2hP2WlIRL8t/O65zc1zUI2I87RE0ycx2sgyboVcTVzuCsWpVIwvt2mNuoeiyKVdjqAFkwfT9X3MYE73YbiuLtN+p4Iwq05mvCSffQORMfhnGaznJDl+j67SJY9yQ8wWPhoYR5mHqJwBD7h/YBJz7w+/gQ4qGp37dfmpnpQbG4NCSKZhnZDoou7zTu5KcTRwZCqOjvUQhEJR4cBYm/9+cvvNorOIGt785qELXzVCN/F8DudMq15GzURyJJ3YqIbiqePI73DmZ4lS7EjKtDfysA5+6CovqmfR0SrevFtCHOhCLMHwCcMfeeHCKgHSbb4BVp1kAZ5hNlfMttX0aqbal6353HsZg/l0C/HP0DgvsYDZ+x3xAfE8rMERUQsHrHJIevUOoQ2obuPq14avdtl5h5li7N1AYhJgw/AXER6Rp9FN8Acp+tiVSmn2u6UBbYoZeWzzjHYL/rSETZKkItt+W8D1jMh04pHDsN2CB5uc1qJ2RWmZE9zb7k/rNFJ+W7iiXRZLk=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jiXqe2v6O+fCVFMjXDjTAE6+wMOec5er5eFTdPglM0zwOoOyAmDIBaAdEuyZdMZLBPT4xn3plWNdI5c9roLoOID+oYb6LSiLF9aHIpE0cmvBG6S7vOZJxeuGE0LYrU94kWXXcQ8uyQq5b1Ac618cj93LSAMMB3elyD8+xL8YMu/37mx7959Ketxut3zIyGqzxXQHik/fchsq1mU78sD5lrfVsWH0tZGRT8sKadIUljuaAEqD5ylmYy+buQ+mAdZFLSDVYDrC0y2tW0GHAhLczFStoSXxH3MflDVljW6fegYzNCVO/0Z4NhmGjDKPGRUpQA+zDU3CAkGuON/QayC9JJo5x7J0FLgBdOoW6JepNrluUfPLRwiSFZgrFlanTVeGQst6QasUFa0EZtkXJAQ8jCzo5jpmbX0YJaeOlmFdQ1TcAMvKfL4uxnV1Tr132ERE
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 19:38:31.6747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76daa786-0ce8-4849-7676-08dec33a0681
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8489
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

The upstream device tree changed the serial alias for MAIN UART1 from
serial3 to serial1. Update the board initialization code to match this
change by modifying the UCLASS_SERIAL sequence number lookup.

This ensures proper pin control configuration for the UART used by
system firmware (SYSFW).

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
---
 arch/arm/mach-k3/am64x/am642_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/am64x/am642_init.c b/arch/arm/mach-k3/am64x/am642_init.c
index a15adf1cb1e..d6cc7a85aae 100644
--- a/arch/arm/mach-k3/am64x/am642_init.c
+++ b/arch/arm/mach-k3/am64x/am642_init.c
@@ -212,14 +212,14 @@ void board_init_f(ulong dummy)
 
 #if defined(CONFIG_K3_LOAD_SYSFW)
 	/*
-	 * Process pinctrl for serial3 a.k.a. MAIN UART1 module and continue
+	 * Process pinctrl for serial1 a.k.a. MAIN UART1 module and continue
 	 * regardless of the result of pinctrl. Do this without probing the
 	 * device, but instead by searching the device that would request the
 	 * given sequence number if probed. The UART will be used by the system
 	 * firmware (SYSFW) image for various purposes and SYSFW depends on us
 	 * to initialize its pin settings.
 	 */
-	ret = uclass_find_device_by_seq(UCLASS_SERIAL, 3, &dev);
+	ret = uclass_find_device_by_seq(UCLASS_SERIAL, 1, &dev);
 	if (!ret)
 		pinctrl_select_state(dev, "default");
 
-- 
2.34.1


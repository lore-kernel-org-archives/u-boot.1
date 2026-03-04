Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CBEEDEC04
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 04:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3997083FD4;
	Wed,  4 Mar 2026 05:22:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="MxGuK8aP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5101A83F61; Wed,  4 Mar 2026 04:44:17 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DFDE83E7F
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 04:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePARaU8nbj0NON5hJnDK79CpVPotMOfpeXpCBGP44X4KsPfvGYwlfnUyfIBqy9rz4r/N+KQSK/626w2yYo8VKwTBJnargPP+k5OOuiEf3XST2TRRlakCX2fTlFtx5Vp/JeS96j0T86TZZREuEqS9V0I9Ld0ESSyAd9iPSFWyXttVmK9xXifZxgKl2UH4qKNfA1xCJWLvykfXLOvNsf4ADv3l58hoAraZYQ0qCTByHykq2GYJbo3FSMzv06Vka91hyTVYXjGDlC2U78XMJbv/P4qN5sYWfDKWVYXmNfPLKqcwFYAYyho2UNr00RlnlpRyidt9kGSWLj1DXAcxn6aYUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGgR7PPFx+W8wRk8BxUZr4aps2+rrzRUcuRsFcpzySY=;
 b=IsPxAr0UyFY21Jy9mwKJ0/BaPCbF3XwHPZqagWh6p3biGRRnY5kRKiN00eE3HfkG7Q/8us3RcO9lRtJXO1pEuOElepLNSOXzr7tHct4Nf036hnZyTqxFKZhWF8od9QW9Wk9mGKaclomYyrilM0yeu/Rp45ZvfzI/rjc7Gcl4j1OTNmvyp3+GFeqIsttq/64rb6jTJb1elev+Ng3XO6EnlU3ZoLw+djMs3Sem3faqIK3wbuvtf/aCsngdCoQfRnEOI28XOWUhnFiMz8FwgZnN3x287oNs5N+Fb5pnrg5E26pKNzFGMsxTAQ4yfJ29ZBuM385yZTMpXVgPfEXIgK9mOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGgR7PPFx+W8wRk8BxUZr4aps2+rrzRUcuRsFcpzySY=;
 b=MxGuK8aPmjJWljwLhHmJyklHaOoyDXHrTD8ywF1+5qOmzhnWiwVwvFe8P/fGXat7rGWLNswe6x5z4LShYD5HzhZehCP8XN7z5K4Wu5aO5dzheDK4tlh2FLqu/oTEJmOygWCoetfZNG56RKiV+JaraI+ZQMruvc5XGBjV1Q3dmj26yaP3KybROyfkYalyYbAAF7Bt0G7GRJYcHYQzvwGOMAa6KAgZ0OeeG5/vlMXb7P/DLM2mDXo24ITndiYzro++H4pa3twh0Teb+cOopEVWoF9esTmMCeewPPgY/tGNQtnFPDJN6j/ieNNrK9Akbs9dNpRCJrLdkGi8r/PwD4lu7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH0PR03MB6574.namprd03.prod.outlook.com (2603:10b6:510:b9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 03:44:11 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 03:44:11 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH] arm: socfpga: Ensure FPGA in user mode before enabling the
 bridges
Date: Wed,  4 Mar 2026 11:43:54 +0800
Message-ID: <20260304034354.2871-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::30) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH0PR03MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c71966-f739-45bb-c21d-08de79a04c12
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: FnQcP1EWHAIaSF0EPneck42DYultt+FIiiJPVSrAMDsvX+JUOO2yi0T2AfvsBpwFBEkiLedpMBjqBSemn+wd6qmwY4EwueRVBqrulVXjF9LRppNjclBf2h91/7GhnwHG7sULrGCOr+l7qvXftB4z4aWxpJ4rXZc+yo6Nwk9FOnTWRQHAjj0UEYwrF3vT6bBQGFbQXl/zWdNkRIQTGu+62ogWjiE1ONWnoL/n8HJICIJvpXkfhjq2UlwW9I4W+cCzZ7s8YfUe8KHQPvGYO6JgqgKv+kwMYOJBMeDKexPY8nmHHEfR58VkZJiVnb0EtSl6v+J9fY/CplQBvFESwfq7jOi83FriYbeMz9NRfkJsigu46P2kk7ngH8YyS5+MgoymMwmdKJqfmPRzLqGcqV7/0oPYBjhDXCVKy9GujSmzcu8OFSVWlgl2w236g1r/blrxIeCGyfDJyP1SEyZ2vF/wmmuki8i8WK3Lvp0P0r2BlIl3qkQ2PceFqf1snwn/2AB5swMEQ3bl4XFb5Zu4juN2rgFGwaC2iQl/o77rJNj78A4iWEWXu1UoH3ZvCvT4Zc0YHO2ol36nfQV+750b+yjkff4njiRXcx3tHwo/+cIofaXgAbEC2+Ra66ifRHTWOmQh8zh5D6lBbJQ3xPQ7Dcgc9/wS2C+UMzxIOXWASyEaNsX3ZJAhwsCLprk6GULa9DZMFCkJVeZdL+KIoxCpW5s3M7JuiJ01sh6nVDTHsVa/L+8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kYqrgr55nFP0TxPmObmPLyGjouqz+UL3CE2gvxxLk5cTloeRCFqBqrY0wNiM?=
 =?us-ascii?Q?fS92fkY2P7i1MqEGM1pZdQ5Ru30qwZbBGnU4AOAPKovMiP6cyBw9WLD+/2Or?=
 =?us-ascii?Q?BjMHFGZ0BYrl+c5sMetizrneazq8Yrikw2tXDtX5MnZgfE8R/uUz/Ct2axcP?=
 =?us-ascii?Q?pZQuuwSEVSHv/bumsj8pTFvZgVH4lmn2TOvOVdCQoaAE6D05yuWtBsxivnRI?=
 =?us-ascii?Q?yQI2Sc0gA8Y0dsq13dq2SUm8ais120DWB1X7mZWjsXr7eSKjMoEecD27AHQd?=
 =?us-ascii?Q?gNRF9DW9xU5bt4SkSEL6o7tK6W1o6Din587gDEF66+aBoYo5E+NAYUF1FXt7?=
 =?us-ascii?Q?0WaKiAl+ryg4KpDDm5XaCUrkNjAeKwtirUcYReeYVqqngO+wgSvWMHoia+pf?=
 =?us-ascii?Q?/Qo/K1f2YkOvqLLpjIMGNAmls7SCpLXTYwRmdYvHbUO/WkrQDwFCtsRTpXU4?=
 =?us-ascii?Q?xORQtvYlCNbRxlFocRtYqFOaK1lkUGYEgmBcWz7/hH7G/FphNvg6pJA3t0NY?=
 =?us-ascii?Q?q3ZEWnYI1MNTFgBA2Xr4PThaUS9T3vmSyDYaCmfd4/o9BcbD2poKhrHgeelo?=
 =?us-ascii?Q?gumVa+jMrIbrCJFfk1OQV0olyEo85ZKkztI4NjvX3I7JvcSpE6jJYMQHoJr3?=
 =?us-ascii?Q?oLNOMefCc9aaK+MNfQBw0lVC4vK9ECh12CrPBS5XsedyAkgjPsxhoX3FhzQA?=
 =?us-ascii?Q?8vnn2LMmn4Njp8tUrXXlsT+EekEh1CTR0EdICofX4p36Zu5tvPACaVkyAN18?=
 =?us-ascii?Q?GbUIRbes8vHHEklqcH2IAnhzqcmkjZg28eILInmGPSPdQIjJHrxkoPNrwVnj?=
 =?us-ascii?Q?4F/lN8ZStJ0u8H0cQeMWKvZ/3ruIrrdPbjR/0ppElQ4C/Jjv+vR07DZUpV19?=
 =?us-ascii?Q?kR0gWLQAakEpxRwwjRUXU9nIPVWoFDDzNxV6QPes5XkXZ23nWmEyS1ax2R54?=
 =?us-ascii?Q?/q7wVrzvlMi77+jaS0ad2dNk69CC4K4O6FYBAGxegq9QR16zIiHxfbRPYtHE?=
 =?us-ascii?Q?mniPUR/IqfmTzr5bjg/fefrz0rOfFgHfZuzQfRCTMjk1cq7a8mql0ygAoHyr?=
 =?us-ascii?Q?kVl2BgAPPbk4ANHpOavUDj54dWje6j5Bh/hvX/ZJL6p5q/grE5zxNwr5ro3V?=
 =?us-ascii?Q?or6WgQwu5a4045XTgsAPIyAxW6FBdaiCZmF5u1Wc1OUEpnqZeqE+CS2bCP4Z?=
 =?us-ascii?Q?YABGUrmY+E69Z8vd2FNNGS4G+MDLKmwvsN6SRXDhDFGMgtZNusL9Qmq5ecba?=
 =?us-ascii?Q?uhQwChOhb0ni7pW8WT8AYcvuSXFusMly+xZg9S6kgYTMuVPsW8VFrAQqaxbN?=
 =?us-ascii?Q?CHpzaIclxgvOWrdk+b/pQuNZXfOhBFi2Xl2e2TZopJBB/24WFBeYpfiLavrZ?=
 =?us-ascii?Q?gQUWBuAhB0SXlSJo9PsnoFuIbUI1K3HpkvNN01/FKVUGhNnbxVNqUyS/xIqJ?=
 =?us-ascii?Q?BCSDwYKXsap8moJrQ84LfJuHldMETSfxAjBwo4dlPkc+W3LpJ+1J2p80a5ty?=
 =?us-ascii?Q?5EolpAakRRII6aALju2GZO+fQD1SkYi08pDllh6e5d22h9M4bsf+Glwkz7np?=
 =?us-ascii?Q?Xc2JR71RtcLI3oUK08oCMZoqVGJP54klZUCRHk9T0kjH3mfPBPERhnbA2tJl?=
 =?us-ascii?Q?WO7qug1BusizJUnU9nk5oBjEHR60B5C3bIfoCfNvIFnpnHnZo6TrrvgbFw7+?=
 =?us-ascii?Q?Wb+A50X0x28BjSKhjhywTcrgObi4rM/3HRivWWWHVmYw6CNyPygS41l2ILA6?=
 =?us-ascii?Q?WL9U2dEaCAIdp463wpfdkIIN8hq0dVw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c71966-f739-45bb-c21d-08de79a04c12
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 03:44:11.4245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOUuwnFNjH/FzZuhetEBTJ54oDIoab3W9DLEVPyp9ymKy2QWojaNCkXq2o49pXPNnaLPQowbtJABIifKUVsyFC/aFkqtX9uq2Rcs+/RPQnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6574
X-Mailman-Approved-At: Wed, 04 Mar 2026 05:22:07 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Unexpected behavior and error can occur if FPGA is accessed in unknown
state.Always checking with FPGA in user mode is required to ensure
system stability.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/misc_arria10.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-socfpga/misc_arria10.c b/arch/arm/mach-socfpga/misc_arria10.c
index 7e0f3875b7c..6b25ab917ca 100644
--- a/arch/arm/mach-socfpga/misc_arria10.c
+++ b/arch/arm/mach-socfpga/misc_arria10.c
@@ -13,6 +13,7 @@
 #include <ns16550.h>
 #include <spi_flash.h>
 #include <watchdog.h>
+#include <asm/arch/fpga_manager.h>
 #include <asm/arch/misc.h>
 #include <asm/arch/pinmux.h>
 #include <asm/arch/reset_manager.h>
@@ -126,10 +127,16 @@ int print_cpuinfo(void)
 
 void do_bridge_reset(int enable, unsigned int mask)
 {
-	if (enable)
-		socfpga_reset_deassert_bridges_handoff();
-	else
+	if (enable) {
+		if (is_fpgamgr_user_mode()) {
+			socfpga_reset_deassert_bridges_handoff();
+		} else {
+			puts("Bridges: Failed to enable because FPGA is not ");
+			puts("in user mode\n");
+		}
+	} else {
 		socfpga_bridges_reset();
+	}
 }
 
 /*
-- 
2.43.7


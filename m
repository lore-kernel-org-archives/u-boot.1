Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F12C02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 06:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CACFB80805;
	Fri,  7 Feb 2025 07:51:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="FKJdKxJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E789801BE; Fri,  7 Feb 2025 07:51:54 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::727])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 192C680756
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 07:51:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNImklAW1mo6bTlgAZyhiSbQCT2S9EBz/zUFPu7/YZYl0Fzv0mRE4dT04YXMKC28mrlykRk5krYtkRRw0wq8KkBJVDk1hox0tegfYFKW99JoIX9CXRQa3AiLTiL2eXA9RuGxQzlh4vZWcShI8bGQmpa/Yg2HCTeeuZ8kADhHPBsT/U4Vf+ItKxPQltXOoE/LJiDdJCxEWTzzHbWTq2YziJqqYn02oRgmMuF0+uZ3CaiE19nFKrQetim5971rY6oUTDzWkQ7sUbfhAyGxzW70SzupWPJwMDDQSrDFj19HlvBDn4k3y2y1qmUiWoNdQ8+cqqdDeMXseaWaTwVcd6GBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19hQAqOUHy8qmfhqoyWYAgDp/fZWOIgjq0zeG9Wk7x8=;
 b=tf71RDHifIPpJgzY5o7uaM5e9YW201SGCHYgqGDwTnNuJqDBNfZUQXYddpCAiZtGlFgC/nlOwjwrElexi8tc0/ibSRU0z+/V5RYnMaL6tu5qEPWht69+LNaBTct4T2ajPGUoqivAG1nfPBTpUasN2c/NWOak1ZX28TE5vmtp/ZYrpUMGD8yyn94Kr9ePfOroIvqP3Q3TVFoh0pIj82GTJY3lSzWMtZZvryZqaYMQOJT5Tg7KyoPIkBQoCC8BGfmec8INJ7DPXYtj2/dumbekIQfCucJbmi4r/sRcUPlK9vjW5rvPngphow1VHO28pmLU6wbpBC8hAUlcyxLc1twLKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19hQAqOUHy8qmfhqoyWYAgDp/fZWOIgjq0zeG9Wk7x8=;
 b=FKJdKxJuJtfbpWRpiLKfVHitMrWuABdbaW+X5GOjXP8wZOOKk2maBR5Jufv7X51AI/VXgAD/QwDcdaXYS5kbfUJwIzSB8/1tIUmTAzWAOPG6iwjVMIXL/cW+H83fztfgRcKJNewfrqMHPbqo1ga8Skv1AzEW3WzojDzGC+oGhkTWFrFVbqjdahkHE7uhPdbmuwK+fzwsgFdk7t6jwlpQnf908nLNaHeeCNgxMUdI3b4sRCftKquZXW94KLMMg4JP2Ij0XhHxzt/vzUEVYtdvqVgRY83Qr5e1oLLkswKo0zzYlyBjfRn7NKLINVpziuaceqwVZZofQXO8KmZEXL5mSA==
Received: from AS9PR06CA0136.eurprd06.prod.outlook.com (2603:10a6:20b:467::28)
 by PAXP195MB1373.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 06:51:48 +0000
Received: from AMS0EPF00000191.eurprd05.prod.outlook.com
 (2603:10a6:20b:467:cafe::77) by AS9PR06CA0136.outlook.office365.com
 (2603:10a6:20b:467::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Fri,
 7 Feb 2025 06:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF00000191.mail.protection.outlook.com (10.167.16.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 06:51:48 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 7 Feb
 2025 07:51:47 +0100
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 7 Feb
 2025 07:51:44 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <ggiordano@phytec.com>,
 <u-boot@lists.denx.de>
CC: <nm@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, <d-gole@ti.com>, 
 <m.otto@phytec.de>, <bb@ti.com>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 1/4] board: phytec: common: k3: Introduce Configs to Sign
 Images
Date: Thu, 6 Feb 2025 22:51:19 -0800
Message-ID: <20250207065122.2495923-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250207065122.2495923-1-d.schultz@phytec.de>
References: <20250207065122.2495923-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000191:EE_|PAXP195MB1373:EE_
X-MS-Office365-Filtering-Correlation-Id: d6570730-8c4c-4b25-1dc5-08dd4743e50a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C+gfeVZKCrLHBfBXDprTrTHIxhAG/U8okXygJn3H+uvcIxV9BKmirhYX8yKG?=
 =?us-ascii?Q?rthLgGUaC6RWJcAm2mOQ3SAiWoyjK9wmQAAMl+/cnVjuVR5WidrylGfLxE3Z?=
 =?us-ascii?Q?I+JYfDGa7cYoXBB8bhhU+YYC41DgE0UWNia9eXDeyHK5vTlLbjMNuTz3hHGI?=
 =?us-ascii?Q?Sax9sDUCuud6NhqspekjhoOGnIeV6OaPJ5AqtnmWOiPAAaHl2ipP+FjCu1EY?=
 =?us-ascii?Q?8QuODdydanH9hFBw4jg4aRvyFIZr69XQu5MFuUkAnu3lt4sBzy4V9/h0rmuu?=
 =?us-ascii?Q?vOnGNEWB7NMx5GDk9KI1wfBhyqD1mgw+GwsjOQQ/GIuOKCdmc1PaHUWqstuX?=
 =?us-ascii?Q?XHNEyyZSmaniel+k7k78CHfruLDGrNCwoq6TW7cRbp8L0Bzr9s05H80WsLxW?=
 =?us-ascii?Q?q2dh7B2UQXs09c48L9ayS8azjehKlY+CL2rNjhGccVHgGe2NJnJwL+kR2IP+?=
 =?us-ascii?Q?QhFGXaZSSofnkkhK//E5YeErGjkF5KeRn86SLEOYu5LGaF6SpKCwcu91nShq?=
 =?us-ascii?Q?LNpaCCVksvtL5oBXGf/RJaRtLmGnHvxdGzQIjif8M1/g2AJWA/XUaq9j58tW?=
 =?us-ascii?Q?Df4k0uC6nHOlZtpFKHIY1+2BrlnELePW6K4z8aa9I8aAb6f+9TXdetiYA12X?=
 =?us-ascii?Q?A4dIdpZY/CrZAeZnAPqWmyf5n1BRxnI3JSuc9Y1X0wyNtA7bmu84WQwf5iC+?=
 =?us-ascii?Q?IbCvZmgDddYBusVC6c1K+Vf2KrNZQctRL6Bsir0MsYQbdSv5dlIzSt3QV+3r?=
 =?us-ascii?Q?Go+7/DWvVkbBeWukqdafoL4jqy8lFOBP9fgHHS9mKG5pVtwpIAWd4eT57pAl?=
 =?us-ascii?Q?LpJe64PRr38CI8njxP+WkrHhfvwBrEZGLNgaB/buAzB3tnBpTOnrDZT9ZoG+?=
 =?us-ascii?Q?knTivzaLl18Smiwg5H6Qvn+SfAcAlONbdf57ifyH/1+pvBcJ04wWsN3Unwvd?=
 =?us-ascii?Q?foxsSlYIqYN+4eG9V2WW2aKat6mkb22LyqxwuEAWeCZSGLx5/Cbx7wCYzU9t?=
 =?us-ascii?Q?BhWNp5HGFCuCmd8CtgHXqmd2uvnUESy2/VeRvoq0ZRyvVRtRLA/eYLWAJDex?=
 =?us-ascii?Q?5NOPvT8zCtE+eRRpg6How4js0AbQd8lWGNydphvF0YUh9uee2JZgQ/njf+tB?=
 =?us-ascii?Q?FOFC6tPcsJj6QZiSl7q9MvCiZdzvwAHLAjDzVkaE3bW5GN62gP4VcVxZGHj0?=
 =?us-ascii?Q?A8lup2BSpKJF5gng0JN/1//ZGOnijd1j18Mjc3OcuCHHB0xkFEqwg4bQ4X7j?=
 =?us-ascii?Q?0p+PB++FNR7sLE8zqg5u1VB79CeZlvJpOgKEpDQG8VSlcFgI3ML8+PhJAMuM?=
 =?us-ascii?Q?FWrLfPoN74RDAYs1NtAjpuxILDwMDytclwKNmKW1QmINnQAbbbyLddnlyIkW?=
 =?us-ascii?Q?bqFMitNp3727BcbVfAPWO/nQInZWOId2SBEelvnidVS5dNGBierd5rdVSw6K?=
 =?us-ascii?Q?/LG1Ava61i0H2oqjeBvQLG1xCe4cXa9pFf/GGMOjFNe57DIG13onU7x7Dg2x?=
 =?us-ascii?Q?yEMF5Aun3S/Gn3I=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 06:51:48.7036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6570730-8c4c-4b25-1dc5-08dd4743e50a
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1373
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

Private keys to sign bootloader images shouldn't be commit or part
of this repository. Add config entries to use keys located outside
of U-Boot to sign images.

Signed-off-by: Maik Otto <m.otto@phytec.de>
Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/common/k3/Kconfig | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/board/phytec/common/k3/Kconfig b/board/phytec/common/k3/Kconfig
index 282f4b79742..19fe927b22e 100644
--- a/board/phytec/common/k3/Kconfig
+++ b/board/phytec/common/k3/Kconfig
@@ -3,3 +3,37 @@ config PHYTEC_K3_DDR_PATCH
 	help
 	   Allow to override default DDR timings prior to
 	   DDRSS driver probing.
+
+config PHYTEC_K3_KEY_BLOB_COPY
+	bool "Copy the MPK key and the degenerate TI key to the build path"
+	default y
+	help
+	   Select how to manage the MPK and degenerate TI keys.
+	   If PHYTEC_K3_KEY_BLOB_COPY is enabled, the keys will be copied into
+	   the U-Boot directory for compatibility with the TI dummy keys
+	   stored there.
+	   If PHYTEC_K3_KEY_BLOB_COPY is disabled, the build will use the
+	   original key directly. It is recommended to use the original key to
+	   avoid unnecessary duplication.
+
+config PHYTEC_K3_MPK_KEY
+	string "Path to customer specific MPK key"
+	default "custMpk.pem" if PHYTEC_K3_KEY_BLOB_COPY
+	default "arch/arm/mach-k3/keys/custMpk.pem" if !PHYTEC_K3_KEY_BLOB_COPY
+	help
+	   Specifies the path to the MPK signing key:
+	   If PHYTEC_K3_KEY_BLOB_COPY is enabled, provide the path to the blob
+	   copy of the original key.
+	   If PHYTEC_K3_KEY_BLOB_COPY is disabled, provide the path to the
+	   original key.
+
+config PHYTEC_K3_DEGENERATE_KEY
+	string "Path to the degenerate TI key"
+	default "ti-degenerate-key.pem" if PHYTEC_K3_KEY_BLOB_COPY
+	default "arch/arm/mach-k3/keys/ti-degenerate-key.pem" if !PHYTEC_K3_KEY_BLOB_COPY
+	help
+	   Specifies the  path to the degenerate key:
+	   If PHYTEC_K3_KEY_BLOB_COPY is enabled, provide the path to the blob
+	   copy of the original key.
+	   If PHYTEC_K3_KEY_BLOB_COPY is disabled, provide the path to the
+	   original key.
-- 
2.25.1


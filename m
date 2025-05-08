Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32187C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 13:16:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B90E8828BC;
	Thu,  8 May 2025 15:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="HHUqtapJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E975829C7; Thu,  8 May 2025 15:16:53 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FEBA8212F
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 15:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RApRBQjxNSOXmo957Oo2ijHwO0jvyAGsItDekGGkyN/Tq2AX+OZsK1GDxoPPoOhQaIcQ2JZbgi0qRVxayW665iZDBBd4+pGi4z4aqJmPh3izAgGlvBYL6rikW375rgQRPieBd1+ViQJP0JeTJO6daCryyldvvbZV7a1qdBFvNs6pJncOFpv+H+7ZqYxND145SzhkSgC8isGcy77JyfqpwhwAks1StihlQJWN3lj3xgVbB7yLKcerLbZIelFe6kQVsq69IIQtBuFtPwszD5ib71TryM2bU5KiffPtvkpa+v/XgzThYvfsOno4gXv7gxgVoHoKYJrLf67HdDwP+QkrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VStsGm2lenO4cboXfL0d+PGDrD/jUi3BsXFeb1bKQfA=;
 b=bzP0LTiIhgD8u8WEMtnkvsjZS15Ah0KHo6Tyz/w2d3YPqu7Ng77D2PuzuABVX0ml3+Rb9QlG/ZjcWyryalxB76ici6HWrXWsPgW73YwIl1yw8kW26GYhTG8cbJRPGv4h/EkzbyfDONo7mzwTm2AettvKnsf0iDEV6TybioJYMFdH6TZDgVQl28SrrnkP427RBiLXLO9Wr59oQk8b2AZ7w+cY16tNmnfc7H0VL5VXBrmRgBHFrjxA+OxUBhZRref0Yya1efV3fQOlYGs4keiIkbMfGsSaJJ6cReHYcYZbT2pgZAEX0D62V6WYgk3y8MhEVjIDo5TdXyFxwq6qfzKTXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VStsGm2lenO4cboXfL0d+PGDrD/jUi3BsXFeb1bKQfA=;
 b=HHUqtapJYIYb7Jyiz7TRE17afFzVaBJF1AhSv/k9f+xErGz9kuWeVwjtxiD6fhI+tWBbNnVISZ6qX2FpMCUE1T3fgYZF1h7X+U3HkmgY+GKDr3qetGfHqkhV8McYre99Mcpag4uzs8OuGLx0sZyEVge0on6A7IBrRINT8g1fZcCd74XKWUAi8SM5CrcuWqy1nv0l6bz5h+UkSueLMGwLKviOVAvppLFwfXkGsG96f06OBrTrcCWyfm5KHP6YYueTil7DSkU4yFWPc9bBCLT8GEuUBTptkiS7HA2ap5+rrtdaqHOyL8szVdigqBAJ8X8DtDq9sjyEwfUOyZCiDSLbdA==
Received: from AS4P189CA0013.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::16)
 by AS4P195MB1938.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:582::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 13:16:49 +0000
Received: from AM2PEPF0001C70E.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::ee) by AS4P189CA0013.outlook.office365.com
 (2603:10a6:20b:5d7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Thu,
 8 May 2025 13:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C70E.mail.protection.outlook.com (10.167.16.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 13:16:49 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 15:16:48 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 15:16:48 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <tudor.ambarus@linaro.org>, <joe.hershberger@ni.com>, <sjg@chromium.org>,
 <d.schultz@phytec.de>
Subject: [PATCH 1/2] boot: Add BOOTSCRIPT_DHCP Kconfig option for
 boot_script_dhcp env
Date: Thu, 8 May 2025 15:16:40 +0200
Message-ID: <20250508131641.2561876-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250508131641.2561876-1-w.egorov@phytec.de>
References: <20250508131641.2561876-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70E:EE_|AS4P195MB1938:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed370da-f8d3-45a2-f58e-08dd8e329747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qXjq/VvWcr9lPc/Y+WCZX1MaEUTG3HCQSeCxnu5lXtlHlCHb6rlhOlKEKnah?=
 =?us-ascii?Q?g+O5jxMABzL13YMtMdGFt+uwOIccQ5meqFVYzXwfY9QoJFYH3vAVxy4nmSoz?=
 =?us-ascii?Q?xxai2kXVUb46yVkRPK5sPrJXBdU9pAcNrIp+bMfEtdl62v+RDA61kjGSOPac?=
 =?us-ascii?Q?XFlp2YKffkayzn6nA3tfU6rxNAdM6DNrJnFW1N35dm5wmCb+sPVAkQ4BfeTm?=
 =?us-ascii?Q?SFOo64whvxdVpnrHu+Kah059qErsSolGzNcNyaWcfUhKNG7L/Lto4UyFgQFz?=
 =?us-ascii?Q?5vPimwglQ406iiWSl/7iOrdz7eHb02RmZCoJB97roclEVUa5aahgZ/menK9P?=
 =?us-ascii?Q?BtxYxrWpy1KafU45XcQSZTmibCVqhEwUeP8RqV0owjYPjdPp339GBBi8TZT1?=
 =?us-ascii?Q?5gXIZUw4egi0H6OjUFdcq5cPgfbFBwUYlDEvToa75QSRRLBQ+K+ZihZwTaQI?=
 =?us-ascii?Q?iRAZz+x6wPzKolSxGjcWAeRdJY3lpIscvxBx94ZNg2emfwKpQSNNqAF4XKh5?=
 =?us-ascii?Q?lQSBbnf604+UnE69VBd6d01XBQdIZWjk20AlBnuraRcbamEMno6Ljd76ZpUs?=
 =?us-ascii?Q?De/5uetnRGv8uMBEPhuZT2CW8hXrlR5nmD1+jT3N8O7p3SiuddZYuPhqSEVk?=
 =?us-ascii?Q?uFhlvXz8d6NyON+tY3o/pWKmFdeSL4YZopct7lTiBV4FGmr1dc7RxAJaaUdY?=
 =?us-ascii?Q?vKsmuK3OM6NZ2Tg9/8l2A8JT0f+nxhcMq/FRzGdHfB7oTKL7JQWFkTqpByfX?=
 =?us-ascii?Q?i+McHRmy/bEaVuDYpBaz+bfZqbmJsne+Upro+6dt19iiYsNUsW4vhDs8hlMc?=
 =?us-ascii?Q?IeTiqSMQ1Vd4SVwcIEHQ/H501Ws8oZAtEcuqc+xTZIMjNSkXOygXY4VfimHS?=
 =?us-ascii?Q?GBJvltO4SXmly8hKBzlV0wpzcjpTz8bssIIsGaQ9doJw4eRK64J42x6soV8q?=
 =?us-ascii?Q?yIsItXMYh+WqdGZKH3gKPw4oYnbFKCB2JQrKyhZUe50IFCOPS0J1C2K9Mqe+?=
 =?us-ascii?Q?+QG7WDysC7Thh+pLMljDO5jKn1uLXXRU8VOpa7ll8KNUAg+Ge422dmRGBLGt?=
 =?us-ascii?Q?kKYOKBLS19RGD9u6NlKTYkbkwj65+wFaRbNioV7V7aiUOu7qGMnT4zGCzKkX?=
 =?us-ascii?Q?qUc9IfXQZmIWs0LDKUiRMv4JqQVhns6FFzPU+5CrC/IjlinkSF/ZjJOP7JWx?=
 =?us-ascii?Q?McG8Siy5cpMvIAibMXEHaNtvHQ3wO2IzFDPXwwjZJLGdGA9Ro5Fqg63Q964c?=
 =?us-ascii?Q?E6zExxXEaI23KZAnYJu2SMBWKDIr9QZRCn4Sq1La7ess1PJ4Yib8Y3KRXeAy?=
 =?us-ascii?Q?6aNJf4SyiY/mbre71Qw0iRSAaNYm2GuYwVzgDFIf9NNLjYzkXOOheBjLVf50?=
 =?us-ascii?Q?675paXmzQmlRTgvxxM63WDRmjxEXbc/+GAXJygJ3eDFAdcoozrjbjbl7Sm3u?=
 =?us-ascii?Q?6YB5pXJnFwpDMow4mw+ipSXPWMJGLtW0fTWjMZlMezd8IjX0CwPb63dWkQBT?=
 =?us-ascii?Q?9NKtzQXttTEbOjWTP0ipD10ggjXQ+KPKBAPy?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 13:16:49.3566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed370da-f8d3-45a2-f58e-08dd8e329747
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1938
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

Introduce a new Kconfig option BOOTSCRIPT_DHCP to allow setting a value
for boot_script_dhcp in the default environment.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 boot/Kconfig          | 18 ++++++++++++++++++
 include/env_default.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index fb37d912bc9..ed34eff5b7a 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -875,6 +875,24 @@ config BOOTMETH_SCRIPT
 	  This provides a way to try out standard boot on an existing boot flow.
 	  It is not enabled by default to save space.
 
+config USE_BOOTSCRIPT_DHCP
+	bool "Enable default DHCP boot script filename"
+	depends on BOOTMETH_SCRIPT
+	help
+	  Enable this option if you want to set a default value for the
+	  'boot_script_dhcp' environment variable, which is used to fetch a
+	  boot script via TFTP over the network.
+
+	  If unsure, say N.
+
+config BOOTSCRIPT_DHCP
+	string "Default boot script filename (boot_script_dhcp)"
+	depends on USE_BOOTSCRIPT_DHCP
+	help
+	  This option sets the default value for the 'boot_script_dhcp' environment
+	  variable, which is used to fetch a boot script over the network via TFTP.
+	  The script must reside in the top-level directory of the TFTP server.
+
 config UPL
 	bool "upl - Universal Payload Specification"
 	imply CMD_UPL
diff --git a/include/env_default.h b/include/env_default.h
index 60c39f9853f..c72cf123004 100644
--- a/include/env_default.h
+++ b/include/env_default.h
@@ -124,6 +124,9 @@ const char default_environment[] = {
 #ifdef CONFIG_MTDPARTS_DEFAULT
 	"mtdparts="	CONFIG_MTDPARTS_DEFAULT		"\0"
 #endif
+#ifdef CONFIG_BOOTSCRIPT_DHCP
+	"boot_script_dhcp="	CONFIG_BOOTSCRIPT_DHCP	"\0"
+#endif
 #ifdef CONFIG_EXTRA_ENV_TEXT
 	/* This is created in the Makefile */
 	CONFIG_EXTRA_ENV_TEXT
-- 
2.34.1


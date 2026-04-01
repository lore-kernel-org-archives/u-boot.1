Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F039D35163
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 09:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9DE483CE3;
	Wed,  1 Apr 2026 11:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Af/sJKBC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51FEF84056; Wed,  1 Apr 2026 11:34:56 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 408BF80212
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 11:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KS60+LiF5yY4m7LLC7enQTOAMqIl5GwDkjT7Bz67U731yfYCVJs1ejV6V0wVybVrHgnH3vhc++Ra5FPI/bh2KCWlNIFRxhKDOqIbOTRMT1tG5Y3Tcd1TTck61U9TKCE8mYzkgf2n5e+/GZ8Ds8xDwFHcvv6U15KqUEVSZhbmHI4A1/QW3oA189RxXOmsj9hfFVmm6tXCRGEqjYq4MjEf4OyLPT6FNyqlQEZolw6FWxaf1TH6+qbT0SxZvUeqJ2pRPH5rWeao60BhIOGx3S8/m4LXNpW4PJ3BIrMuM12rfCw1b0ykv9eO0OGrHFuLKGc17ObxKgvkjrTxkWOdiybsuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXYVPNbw8u1LEiTUPgXpPMh3J8FzG8+JYieCj/cAHGQ=;
 b=LbpnxBl/SrpsWMg8ibz/I4zWe+XbFWAh2phYEOLKbn+0UD3xC2R9oOPO11nXc8L7dEk6Tbm6Kz9qe3c+OQpgqWJj9a4hMoWAVuxVImzO9Jid/QJEkXBWknUA3mSfRFY+WB18ZX7h+uER5xXAjOOZVS1CD2uC2MEntcIMcpEQOpy+paNslvQLJXZ1mubIFGAb9SDL34ddO4mtOTe0vCkecbcUPioF3hwAb3ok5HHcRNem3FCusOOSTlb5l23Ee+BJ0hD206AmUfyFG6XfMPz7qeDLR1+2Hw6QtGVHqazE1XykWiS0Jpj1X6oyo/FI6bvLELYgSgTp+iZZNEoAj8Q4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=denx.de smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXYVPNbw8u1LEiTUPgXpPMh3J8FzG8+JYieCj/cAHGQ=;
 b=Af/sJKBC6ZJP8OazbsR8Gieoa5yiWkmq6ejomXokaljTUdg9E9MBLT/BRWGdn07pAFefoGormD6kH7a0O9eTwvOG0/Gt/lxo1e3JkbyhseMg/zMvgn2p7gApPBUAaieLiSVfknKNTjVFH29vokWrbaFJ3Gvtl1p7FZ09hLvGZqCk1ggTq7jZrh+nGO4bAGUoVMrTr5HOj32a2OkTGVYCOw/Kva2/bZummDQno+2B5iXCT/okeExLDn8EnWfLBocbQczSxJWUtmrB9XAOLGLsC/j1cpJZDY+vMo0bV48hXwHoz7WOkflqMF9RJO7hlHzcRejw8npOZZ2iwXwuaoIFwg==
Received: from CWLP123CA0235.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::23)
 by DB8PR10MB3782.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 09:34:49 +0000
Received: from AMS1EPF00000047.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::88) by CWLP123CA0235.outlook.office365.com
 (2603:10a6:400:19f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 09:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF00000047.mail.protection.outlook.com (10.167.16.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 09:34:49 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 1 Apr
 2026 11:37:46 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 1 Apr
 2026 11:34:48 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 1 Apr 2026 11:34:48 +0200
Subject: [PATCH] clk: stm32: Add STM32MP23 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260401-add_stm32mp23_clock_support-v1-1-ff5fa33d8b67@foss.st.com>
X-B4-Tracking: v=1; b=H4sIALjmzGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwND3cSUlPjiklxjo9wCI+P45Jz85Oz44tKCgvyiEt2kJEMTCwNLIGF
 oqAQ0oaAoNS2zAmx6dGxtLQDc+yHVbQAAAA==
X-Change-ID: 20260401-add_stm32mp23_clock_support-bb1480914811
To: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Gabriel Fernandez
 <gabriel.fernandez@foss.st.com>, Nicolas Le Bayon <nicolas.le.bayon@st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000047:EE_|DB8PR10MB3782:EE_
X-MS-Office365-Filtering-Correlation-Id: df891fb4-5341-49aa-c87d-08de8fd1eb4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: diRB94akwRMc7zCGocZW+kJUKHwdSvmPIDRWfdrzwybeAwShpT3MUtRGZFb78a7/oxdtGR6Yvjk3jlQLL8kpUmHCn8Bm6bhBujcBCeth6JOJVv+1gWeyqbppDk/MsvoyY2/EnoJWf9ervjx8lc7rWg9LiNvUBdmhiMk46liusky3/8hI4FqdJfKEm/I8e9oa26udWbVrntnmIiFiwjfb22rGw44l5DvLiFKlN2ab2txg9SvfBqHEuDuyC0YDpE+CdAflTh4j3pQ5d/WIBkZK+KPtxstbB+p7tfct8D2xFcEDr8/zE+HggyKrWdI/8ZaSn19w0v40dmXQdUa3AytvBJzxMP0OytresRHXfkxP/EqYiSS3t+FSOWHK+OL/GhnKON6xsn3n1xaL5WuOyKZKn6fHtNv3ux+Ug4bhxhHeO3z67XDJ+9nPH3PrT4/DVT4VYUcZAD3N3v9OcuC2rPgRSkHPfn5fmd7YtC1WMmVzVOjT5Sx/jrkf7sjs47lBq3pMGEzXNVGdzH49C/Nli7PGMIwSChYEe4GEl2mqdSOaPTR/6+DaZ5sz5R5cR3ELnnUP3sYWPCn0khzM9QYQgUtjnA2gsafLqDPn5aOt6Zr2cVcRCXGFXS0zLGn2P/4w1TILIagKn27ev91lrNnnbjwHy9mUJppUylvIP2buOc3N0lNsRE73l8a6Z+ggNdpiMynIrrS3RfUSX87LfTB2QFen8S+1Ia+iM2ZQPLhiQmL0FDWpY4KTZQTt7EXykU/bySAgvgO4kPzaw4AQvkX43PsVtQ==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vv9mCyrbg7gEoulOHJ0m3eN62PvHQ64t/pA0yYHMbzM5Xtgm/m5SXOfJazjRhfBVcby6zJVV8gNIaQPkSspuCxeIfvZpDExP09920eTSuKVEGhOa/9NhQfzCAm0S6NHAIHhEZRYrilGv9flSIdEQVFzZx0GsokVqsSY9f0AL76GBcBXniEQQtjYch2n9AyKjRkoErTcMJKGif5AQ7DqZPbk5R6xabBiTNe/SpjDm3yjmCnvRVlrLJAdCgkWl4GkqtV+wQ3N6J4xhQcJe4n72nny9cOl8Df+RCJ5gnR25+ZjAkgx0Y3VGNZ94fQGjjqoUlIs/xd93p7pEu4tUzYmvk8zO2zlZUrLJpFB6C9ouYiqQbsnMxZRfAmrdFgm7pnZf7BXSXuIh20KKkTeMqcQL6XDBysbrcwk0MbExkLzklnszng+lPdGrW0xbYjKn7I6x
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 09:34:49.1012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df891fb4-5341-49aa-c87d-08de8fd1eb4c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000047.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3782
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

Add STM32MP23 support.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/clk/stm32/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/stm32/Kconfig b/drivers/clk/stm32/Kconfig
index 4e488136eac..e63385d3051 100644
--- a/drivers/clk/stm32/Kconfig
+++ b/drivers/clk/stm32/Kconfig
@@ -49,7 +49,7 @@ config CLK_STM32MP21
 config CLK_STM32MP25
 	bool "Enable RCC clock driver for STM32MP25"
 	depends on ARCH_STM32MP && CLK
-	default y if STM32MP25X
+	default y if STM32MP23X || STM32MP25X
 	select CLK_STM32_CORE
 	help
 	  Enable the STM32 clock (RCC) driver. Enable support for

---
base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da
change-id: 20260401-add_stm32mp23_clock_support-bb1480914811

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


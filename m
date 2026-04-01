Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB7DD35164
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 09:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63F9383CE3;
	Wed,  1 Apr 2026 11:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="oWqeZCMG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E04F983CE3; Wed,  1 Apr 2026 11:36:12 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F4D280212
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 11:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NA+5XBVw7Vuqy7d4I4hO+JoKhTrFUqWPwofOrpdBV3syt2Y7Xpzd8T2P2+VJWD7vFg3AUERVA3eTXDD2Wh2ar6TrKMESEQaGOb7M9/sb4rIPjYDrA0uYdWvWFytgZyMd0T/hqql8R4mtUoJknqvhnXQWP2LBFWLvcBOGDAwMYJPONMv1nZ/3MFbIJj2YY/+C3t2HKRYVswG7TrJWzEBXruA1sgzUSmqVzE7S8pzyE59Vg8yXYy5XHxsUnkfgG51UWVmRu7xD1QqntMe4x5pTwjdBj7vhWLSjx5zBoIuIHNE8SzR7ga2jUYu+C70LARzXjfbWqbS6pSA8cQG7L9p8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOW/h7NSYdGP9ycfTPxiqDKOrLtg5WIfcKUctEQq4Mw=;
 b=Xd1UEOgiktMPile7qe/fGu+RgRFI+r3VPq7JQO1pfh6kYdg8gtzudoc/pNBRn6iyyDtxqeYWLomsDoSaEmZSJsEC3VqeGKxqIWupP1ftPotqYD4kSzCRICeC0NnEUr82thjEJOuxo91XPA1Y/wwOk1ismCl6U1OJUJIaJ7qTgrl7dQUs6SdzO5Oy1l/XjMlqcbZJ0BFV3S1JxqhfZQPvfk7VI0SaekhYS1gaxDmrNKbYMUyyDvPa9SdLzT+2NcbwMag0AVEA+jymkYLIubRBbmdoavqujZdXjTQufR5erPx2H3wsFsJjEZVWZlIGhdOpZ9ljXAtRixs97yXc5WyzfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOW/h7NSYdGP9ycfTPxiqDKOrLtg5WIfcKUctEQq4Mw=;
 b=oWqeZCMG4qsLv5GpSgg0Rb8nFk9NY/G9JTK1nnmasxlRuw/Ya1/Giio6PDyxLM/Eyx3Poi7QWM/Nva1HE+yPW6EzSUohNQHgTZs54gevsi6506CwJJivAjOxKDFxWT7lyrG652kSEWS7jG6aw+2kRKXp8KPten+goE9I9lzE1Z9+y1ZvxHm9gb45wfUnDkA3UUaSw/KBbvsW3cgyOb2pi8qSnWggqW+oYzQ4s9vUmCiDjUERMsdg8W7HtRBacOiwrZykVRQZ6NYjFROzKb0r5toDMKy7zMbnhJLeAMb5+L4FToUWosp9hKZHHTZj/tWlsnx71zY/Oix1VPLJGpbxsw==
Received: from CWLP265CA0281.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::29)
 by DB5PR10MB9786.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:650::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.24; Wed, 1 Apr
 2026 09:36:06 +0000
Received: from AM4PEPF00027A66.eurprd04.prod.outlook.com
 (2603:10a6:401:5c:cafe::fe) by CWLP265CA0281.outlook.office365.com
 (2603:10a6:401:5c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Wed,
 1 Apr 2026 09:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM4PEPF00027A66.mail.protection.outlook.com (10.167.16.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 09:36:05 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 1 Apr
 2026 11:38:43 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 1 Apr
 2026 11:36:01 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 1 Apr 2026 11:36:02 +0200
Subject: [PATCH] spi: add STM32MP23 OSPI support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260401-add_stm32mp23_ospi_support-v1-1-4c73550eae3e@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAAHnzGkC/x3MSwqDMBAA0KuEWTeQjwr2KqWEYCbtLEyGjJaCe
 HeDy7d5Bwg2QoGnOqDhj4Rq6bAPBcs3lg9qSt3gjJvMYKyOKQXZVu9Wdj5UYQqyM9e2abukecp
 +jmM20ANumOl/56/3eV5DyfRNbAAAAA==
X-Change-ID: 20260401-add_stm32mp23_ospi_support-1cd96f39a5f0
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Boon Khai Ng <boon.khai.ng@altera.com>,
 Stefan Roese <sr@denx.de>, Christian Marangi <ansuelsmth@gmail.com>, "Ralph
 Siemsen" <ralph.siemsen@linaro.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A66:EE_|DB5PR10MB9786:EE_
X-MS-Office365-Filtering-Correlation-Id: e2232160-120c-4bd1-5f5b-08de8fd21901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: FB/0miaUJR2uwj77vHbFC67q8ZGSIS9g/vQFkzOXwLT+h4MuAKRidX6PEVN1eVO9Rqlx/BZxBkjaoCYBKNuGdo9XaNFnv8QrF3zdh4YvNL4hvs5hGyBvNMHAsc9OvhEhi0V3uLaxMqy6DWCK7rUbTj9ckVL22v6yRqzoIu5JlhsvncPziZG2t6CxxmazN58LU8KG6DoVN3AIZmFKbPwAbPCOtQcbTV8OeHJzbj3IRvlqcu9oFVvh528gnJFO8lW+tNDPyTRqaZ1FV9FOEvhSU1whuNdPBYKUONnpLSWQwG7lZ2FeD7ym58x7rsiEn/f/St5m0gSNHfL6bYUUkshfC/qdYXLCBK1cIoRHcUC8ic0tJ87D2kQOlxj5foG8nBgVZgQ83OqPP1vXl47wpiIS7+sQmRoNmn8DVG4dwW/1qLRdcxzx/0zcpVPQMf1ABOORvcVx+c7XgNTzAMh+VLN5xRYGk9WfSnQK5Kkpu3yDLzl3mqLV1CGLgELiGtwYpIWSrDyl0mFfrUrTN8oZvIsLHo6axEiU7E7ZWIbkBwqGb0qBZEf0G4/I6OQRBOaCCfULc2rBqEsVC850l0cmVvt1JD5vxPr/QqTU0JeKM9i7qS6Q2CyM6OINGk3jsEWXvRhnUkwAdZB63sPCk/N6rnIlm51DJstL1Xwl33mDm0MqCNTmZugzWhASji9FB4g7rSVzNWQy14DJEuQh3DutYGY15RAkKTJM6lUsHRyXDL4cznhB8hxWINuMtnky00uXmegOmWjwsdVK68ZDhwHIVcU5hw==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D4m0tM8/rxsG1VJQlt4QHSBuG7xSC4vJzojl52NjpSWJ4K4aUF3RrqA6qOTSZ1h9acEAImnPLbULJLjwBT4AVkqzTUulS+AkLUpud1gWBoU8siG9v8vjKbG84iAf1QbKnKKdfJbUeAkF5yilVzhLEV9B1waoMMx9WxHjzMHNIFNGZ/KXPIThi3v03uy6XkFHTxYTzAXAC3kGj30sDbiX+bzaYDVpThLkg4Fy0S4RbMXLWNIYGs+d/slg5KNNn6fVdti06lwlDAiplKTtDUWFDkoNPsSl5zIeykkYDBV7zmxhWl0HePDkTwlE5SPeVFUTwidc0S2KCBFoPCmyNYhKuIUFNjdu0eKSEDzl2tAMtbh9yqqqq1ECyM4DnoAuC4sR5htkz+7Ag8BWRw7VXcJZkzdWJDQ09qMep3uVbcOkJLTtl5S2QRP1DrCzdunY1Jdp
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 09:36:05.7772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2232160-120c-4bd1-5f5b-08de8fd21901
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A66.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB9786
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

Add STM32MP23 OSPI support.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 8c6c095a8cf..51909e3a8ff 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -550,7 +550,7 @@ config SPI_SUNXI
 
 config STM32_OSPI
 	bool "STM32MP2 OSPI driver"
-	depends on STM32MP25X && STM32_OMM
+	depends on (STM32MP23X || STM32MP25X) && STM32_OMM
 	help
 	  Enable the STM32MP2 Octo-SPI (OSPI) driver. This driver can be
 	  used to access the SPI NOR flash chips on platforms embedding

---
base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da
change-id: 20260401-add_stm32mp23_ospi_support-1cd96f39a5f0

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


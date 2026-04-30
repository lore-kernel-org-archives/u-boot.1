Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C28FF886F
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 07:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BF8B843D4;
	Thu, 30 Apr 2026 09:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="gILN1q99";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5880845C8; Thu, 30 Apr 2026 09:14:37 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B57FB843B6
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 09:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZMN/ha1bexs48cunUxz+5Q9cg7XkQF/X6wp1UgZq6DUQGtZjadod1tGpoPuQH6k6rufosEGO6Po39C8X67JF+NGn9vgkSvqZqF28O1KvSWONhb2qbPFKPQ0BoHcBias7bBNQ2uNiVXdBgnoQeDId7fTfDFn2qt9qvCbFSSJB+n7KQleh77B317wAGvOgZcStGULkxY4v7OeIJRVSMr/diZbR7ITnwrAxeoocwfCUbJzV5GallvjUOa+qF+wCMY86IY4zYAZD+hixaRNDFbfkOS+n36k9xAWMMO0n1gihG/6yjb7BDmYS2G3/Xoh1ENHTDSJTk36jgVHzBJ0eWrgRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAj6ECfPJxGIlsHZCV3dDnK6q4Rdon/CvYS8vekCxZ4=;
 b=b+HRjs/5aSLcZtzW5ZDfzX2vCtzLtuOPIQx2LPSurr15rUEUMBtCSmwepCxnuoQWTRgeIJua6P/sBUqMPfciLDGiKyEPFyF1O57Al+Y6MjEL2I+PtznKKtNKLLjS8CAGBbTBvD7lYi8TSU6Lqd/B88x39OBEKnBAVlm4HvtgR4LYI2pJB2GjFIqSVRzVeM088S+jetVNpFN8uSeB48qX4CmEovvgWK7XWbM7HrcgXsuYONyXV2aUanRoQYoMkTl6zXNjbw0hdC77yH4js1XFqMW95qAnBQLgkCGy/2kX43k5Cm1qHAe5dDS+Pk9U65KQAkjdCAkvP0fzZaF++dyCiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAj6ECfPJxGIlsHZCV3dDnK6q4Rdon/CvYS8vekCxZ4=;
 b=gILN1q99erwPJq5Z5h2dolBxWJu8+1mNxfGXmyZhlRJdH4m9+59vwexptweUv0raCFZlN8aU+17am8HnUb/h5p+yoxLvWJt6sa1VXkpLETsnMqnlD0cL/McWMqdh+GHdhXmhDCN05yuFe7cRj6XcsYdqQgFJ/rFp9uDM8RwMNG/hSNXV1qpSpHtPVO3+M5PsyNg2cjXLAtWSzixBL6WTuxzVcjOMOn5HgVRIT2oiSP+vAe+VTRpp5MkNs0qrv7vQaOx51KazqeTkfAkR+9FWU/z3DcJPTPIubllEVtyucz3SxLqitpZULv3YqHc53w7OBTiAsV8G8hUMwq0YGRvfSQ==
Received: from AS4P191CA0034.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::27)
 by PA1PR10MB9411.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4fc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Thu, 30 Apr
 2026 07:14:27 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:20b:657:cafe::ed) by AS4P191CA0034.outlook.office365.com
 (2603:10a6:20b:657::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 07:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 07:14:27 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 30 Apr
 2026 09:17:39 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 30 Apr
 2026 09:14:26 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 30 Apr 2026 09:14:20 +0200
Subject: [PATCH] arm/mach-stm32: Remove remaining non-existent STM32_RESET
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260430-remove_non-existent_stm32_reset-v1-1-8ec87c655379@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAEsB82kC/x3NQQqDMBBG4avIrBtIEyvYq5QSgv7RWZiUmSCCe
 HdDl9/mvZMUwlB6dycJdlYuueH56GhaY15geG4mZ91ge2+NYCs7Qi7Z4GCtyDVo3bwLAkU1r3l
 KafRjP8RIrfITJD7+h8/3um5RognqcQAAAA==
X-Change-ID: 20260430-remove_non-existent_stm32_reset-5dcff93946aa
To: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Simeon Marijon <simeon.marijon@foss.st.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B622:EE_|PA1PR10MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: d42450ac-0373-4cda-01fc-08dea6881d81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: n4fgiuDAw9ySWwfNlDngSAkFIOx/CFUFSEbLz2xIWSWk1pXmZTQN0eHutE703QmGCYJtWc2Jk//40e8/5Ea64gzewgOZSzyfLAqpZurN9GzsQ26+UN6ZFq2EEcHOhbMK8OiAPk/gHcONqnI7n2JOPpNkd/ULEexh9ePcuFsAdS6ele7NoIAZOobUMJUFAF9LsOP8uGVth0AhIr/2Q60MU42E60mdyKFsQjEfKI3UA0RnVDi/jxnnEqvbmbo7cypMExrqEo2ed2H83S1cO/Ldt4Ec1i2GlOcGX7AqhmBWL3YDr55AuG7e+ZUxb4zlFCaIrdiiTzAQUqtqwGPfIp6ZaiuggogYpKUiF1rY9lFSnVBkvKONdZMAbnAR+kV++ZZYx/AA1/oD5+bDH6/IX1oEHnnUJoBHiLkkyq8r8YqmBUw48tnqAknao03whlgXt6UP1wOs/wrZmmogS4BRrVwyjtihxhSTrKtkWplpDeUW9zqccdOeB1Z8Tuht/GYVm/eTX4u/GJ66Gn76mQySfVxZHfy5QzNHheEqQ/h92+mNhSwP9A+DzsLeBxMAJ7g21WNgY8BIDuTTQeDC+XbW6ql7RepPKNteHTuukRkUf/zan9CrrRpvIXh8fodp0Nr/1M5KQTUdI3bd4ayaKV2AnHCo/0EYOqtFqXmBOpW38VtloNFmhAqUWfCL6O4M8i7bRkq++ZUiFL82d2weiOFkkixomSx6TbkuW0n9gUzwER1X7x6Q5SQ3XLIvQR7GbqjbSTMnIe+vzhYR0Lr0X7KVBIh3tg==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XPCAL2BRXmtyVvjYEfAxKhcgieeKpf3AyWls6cboIwqkLacQnex/G0dj3IJp8KFs2C/5iAR/glTGkW/vEVOh1yYIA0biztvpdJIKD8DYedi9229a909Gz7t/CRyvgpMQzcfmtg06qZptF4KuXa+X0AX7GZefUW5SOz4L6zX1LtRcQWPfD7lSwr0KVmadvvcZFRRZx2tXSR0GExJs7XYVUP5UvXqxlZ6waZlB0YYLL+b5GPUPkt8MAdeitmDKwzeMJUjRFAAv4TxzMYNU56LXyib0aSAFlHF01sEoRJW+qIR7/2Wu6Tm4/hyZglD9/dkwiknLsmU9AdiaKn2/ZTyESEp0hJGnHeV5OWgQ+H/pd4SF4ROAnUAmTqdMYGwETJ1CbXfRIjS6sutWR3zz/lp+fvup1fN4Q16tBpyKOa3P2djK0w6wYRKag1ulhtT+N+Ll
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 07:14:27.2788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d42450ac-0373-4cda-01fc-08dea6881d81
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9411
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

Symbol CONFIG_STM32_RESET does not exist.
Don't select it.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/mach-stm32mp/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-stm32mp/Kconfig b/arch/arm/mach-stm32mp/Kconfig
index 31b2746379d..ab1655e75b8 100644
--- a/arch/arm/mach-stm32mp/Kconfig
+++ b/arch/arm/mach-stm32mp/Kconfig
@@ -117,7 +117,6 @@ config STM32MP23X
 	select OF_BOARD
 	select PINCTRL_STM32
 	select STM32_RCC
-	select STM32_RESET
 	select STM32_SERIAL
 	select STM32MP_TAMP_NVMEM
 	select SYS_ARCH_TIMER

---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260430-remove_non-existent_stm32_reset-5dcff93946aa

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467A4606D834
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wsBO53Ne;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=VawVSQkG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C6C14099C;
	Fri,  6 Nov 2026 11:19:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5-QWP-AIdbt1; Fri,  6 Nov 2026 11:19:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3E5B540999
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793963948;
	b=V2RHP7A+nBkH1C5E9Hn1Lld3fHTiSAVvJ08r5vEbmhUdhnfZ1ZF35XnTILTIO2RfsjpW
	 c0yT43i4Yrsu04PvVW/rOI04RxGHQOGXComRTuHcHC7319V+acenCo/CrIK3fVJ9Mvmlk
	 tRaUPRLsNMNjrAqFLc2RdUd8IU8RZ2xMeLD5Y4CjCJSTtOYpcFAjZaK1hL9iZXAckevml
	 GT9eVja5BO6EYUWp8l3Q7tgcwdUOYQIPfVeWZx3ZwEetPUhqmhGvIw9i7zhYGBVkRk0Fe
	 FhpXLSNLNEErXrDBVhBcvED2xtP3Nkk8KGMBB3xKJrL2HK7Rb4/uoroatxWIsx8ZmOQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793963948;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Eibd0MFZbl69DgXxcys2tmgjoQg1CamlrXSzsEHFCPk=;
	b=jnv9iB+POr/V1Fsgo2QPPwhwmBWuyyiHCXRUspAfZbQMfC+X0eM1Y3zL/Ed4TWnqdJzW
	 mYx8nTwsa3utCuNxfrcXsj48rnhYsBpANXS+MWjHOCOqb6BqxuLQR0D8FZxwrjSHm3eLm
	 2sC1NCwM4dup723HtSgaVgQUNjeN1w+mNk6N0Sw/PuAkjr8gn7DotQRZK7L7MDTfeJs/9
	 pwylho+LSnMdkGRVIX5O5Hu7jqS2usWRnqLWHZ3bh7J+vbvaV6zDh7W1i2GYJLVLf/Qpl
	 SXBWBc0v1Z8+Flj4rCymJUVJQSUl4qI3NRcTBt3VK2Riod965EXa/OkmYDBTM6Djpgw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=VawVSQkG;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793963948;
	bh=Eibd0MFZbl69DgXxcys2tmgjoQg1CamlrXSzsEHFCPk=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wsBO53NeTfrQfdsA7B1m84w/DthQf+CjqnmQoji2n05rpVeYhDCZVwOVHTDmcsNLi
	 8r9RgZwu9v4bTkjL8O5BLlLDsygIK30oNSVC1LXFePOtN/YeqOLRT17OIjuk+A+Yo+
	 ZVN7g6PsEwOILcvgHh2vEln7ciPd1FDuwtV/iZ1K7VdypLK4aUFaHP2rHnvlJ70IjF
	 m1uYBHF5a+Iz7a8A3fTOC9cFeaj3MdEHQTMUCXGNCkKp4lLR2s/wA8fuxgnsf/YEXK
	 a3pR8zHBq30BPucPoBavz58SpXOcR6XwuFuCylz/dCji5A6DJ9i35pMjByfjueSspn
	 QrIsd5rep6xZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E5B540999;
	Fri,  6 Nov 2026 11:19:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A1FD362
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 11:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 751FE4096F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 11:19:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ILCM63a4YNMN for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 11:19:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB21240952
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=VawVSQkG
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BB21240952
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 11:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eibd0MFZbl69DgXxcys2tmgjoQg1CamlrXSzsEHFCPk=;
 b=VawVSQkGaaQ8+ioDGqhBn54Ht9RSCsj3kopJMUgrXbCGW4YsGEaitqvftzuEKnaG4CvKH1mCPevdgS+eUbp3/sDvtZ5AJfusJAKUgW+1Zy4LttzHlnAskOgF6JK47Cv0W35ySNEP1Uw5FCYu/4xCT17st/LELg8aCh6SUvHAByPgi9gDhgxeftc8dd473BZwbRvS9IcOcKfuQlbFnfSXk7DqEYGaY9sFGT/rzrG4lzN0jhflmHiVh8NFgYT7C8rndDCraCBlZiRU0kvMmRi5CtE/apuSC7g1MVZZCQWMZPn96FQia2DEoTdsKKcvda4OY/iP9rAGHo0bKp6olY9yNA==
Received: from OS6P279CA0024.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:33::11)
 by AS8PR10MB5951.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 11:18:56 +0000
Received: from CPH1EPF0000051D.eurprd04.prod.outlook.com
 (2603:10a6:e10:33:cafe::96) by OS6P279CA0024.outlook.office365.com
 (2603:10a6:e10:33::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 11:18:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 CPH1EPF0000051D.mail.protection.outlook.com (10.167.241.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 11:18:55 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 12:19:41 +0100
Received: from localhost (10.252.31.114) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 12:18:55 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 6 Nov 2026 12:18:52 +0100
Subject: [PATCH 4/5] gpio: stm32_gpio: support RIF semaphore handling
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261106-upstream_pinctrl_update-v1-4-4f3d4f6e97fc@foss.st.com>
References: <20261106-upstream_pinctrl_update-v1-0-4f3d4f6e97fc@foss.st.com>
In-Reply-To: <20261106-upstream_pinctrl_update-v1-0-4f3d4f6e97fc@foss.st.com>
To: <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.u-boot-project.org>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Antonio Borneo <antonio.borneo@foss.st.com>, "Fabien
 Dessenne" <fabien.dessenne@foss.st.com>, Mehmet Fide
 <mehmet.fide@screeningeagle.com>, Vincent Jardin <vjardin@free.fr>, "Pranav
 Sanwal" <pranav.sanwal@amd.com>, Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF0000051D:EE_|AS8PR10MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: 9165d3b5-ab32-4c85-be37-08df3bf7bf1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|6133799003|56012099006|10067099003|11063799006|261026140227099003|261028144727099003|261021121427099003|261022075727099003|261102123227099003|261009223027099003|261021123027099003|261022105027099003|41080700001;
X-Microsoft-Antispam-Message-Info: VPmZo3qJjH+oHZopYqM/i8dWfYcLSi0Pmb5lK/atR/fHcwkm1fWn206v2P2/vuZLb19MjdJ2bPt2dWFM2Mb/iDJhJBU733PP62Z8HBaJ4c4ffdIqisEWS4RHqWHFG1UxvxeuIo4Qv60qPigTKO4PeCkdLF7FC5LNqvYmjDNhWI7POZ1zQArA9b6Yfwf7S694mewkpSWHgvh6qygQ60CVbFQ97URhDs2X2QqQlABhD96zStiWnVDcwuMgRjZXT/rb2cE+BlNPTgLpih54I5ucD7UyXyF9TFas5dGTE/z1BghOL3+/W4/GlrOKjYoCK/6ZTyvfQFPoYSp/ksHYiq+mB5CNyfH8n2Wd/tZpODJsPcJinPIGWuVBopPskGwjewZBrZLR9ukPdE6Hyy+94lepu3/DNaHEzqzrFlOpWLDTISFo60bLqo/7PdGHrxtf/ATExX/2BFeKJR7zNCjXZKJPnfeUqLQl2eAXqxFuDTQJMfWf0KoCr4y5PaUY0k5CXQYMCX6dkbHVk0URX/NzDzp/WUhGDkmXU7qiKVG9sOvvbyVT1b3d5z1pdrzSjHkPiTkXIItZNvThm4SL3A8gXIyslAaeNdqtp/Fbid3DIre9wXWD1K+Zzm3Bl0kIfX/Cx680FgDeFi190A7FwShk/t38tC7xepq5l9EvWEhsu0+CedtTd2pMpuvpinhLq/RObcmlDbsvtQW8I9xvuXVO4mrzvoi0NjbpkGOcSaguoQm8durMcaATaPTdpcREX+JCsQeBwKBSRanlEtgKo8a4XyFeMQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006)(10067099003)(11063799006)(261026140227099003)(261028144727099003)(261021121427099003)(261022075727099003)(261102123227099003)(261009223027099003)(261021123027099003)(261022105027099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IHDG6L5yqjiFvz7tEp+ZxN/hNzPF+U4AovGwxJzDQJf0qAn0kl14UPGu/RLBQHfcstILp9yM71m1xEHmFC7TVR1KMMPOBZR2c8Hn6NKJpIk3Et4r/QR/ynJ8BKThSFTt3PgqHzzgSLXDsnIBE3PRO3rKaU61mypOYYZRi1ihPRFT3a62AL1sPZRsdaEx9fsHkNJIl5r76NfdUkYhkMBbdpDwxqlbYowum+EB4g5qhcFaoQjcNkBgsXy2DVym43gJrmEU8UfoEYBMVJD9+wxrk+L4K52nv2vnozqCcUH44ekjzAylpZ1zNdJCEtqqgDScis23vS7MkeQnQlLDUqFy2FQHTd/jjpmzsjzqfj4NxPioojyfovtDw5iCi1kHVHYe5S74RC/Jtpvm1cHVtqfdRu2N8n4BH5RwL1o3vbVXCb67PknR7EgVh1aod2Kmo7Bv
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:18:55.8480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9165d3b5-ab32-4c85-be37-08df3bf7bf1e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF0000051D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5951
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Antonio Borneo <antonio.borneo@foss.st.com>

GPIO is a RIF-aware IP, meaning it has to handle its RIF configuration
by its own. This patch adds RIF semaphore handling when initializing
GPIO valid mask in stm32_gpio_rif_valid().

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/gpio/stm32_gpio.c       | 61 +++++++++++++++++++++++++++++++++++++++++
 drivers/gpio/stm32_gpio_priv.h  |  7 +++++
 drivers/pinctrl/pinctrl_stm32.c | 11 ++++++++
 3 files changed, 79 insertions(+)

diff --git a/drivers/gpio/stm32_gpio.c b/drivers/gpio/stm32_gpio.c
index 77bafe18ef9..d94cea7fdbc 100644
--- a/drivers/gpio/stm32_gpio.c
+++ b/drivers/gpio/stm32_gpio.c
@@ -14,6 +14,7 @@
 #include <asm/gpio.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/io.h>
@@ -35,6 +36,16 @@
 #define SECCFG_BITS(gpio_pin)		(gpio_pin)
 #define SECCFG_MSK			1
 
+#define STM32_GPIO_CID1			1
+
+#define STM32_GPIO_CIDCFGR_CFEN		BIT(0)
+#define STM32_GPIO_CIDCFGR_SEMEN	BIT(1)
+#define STM32_GPIO_CIDCFGR_SCID_MASK	GENMASK(5, 4)
+#define STM32_GPIO_CIDCFGR_SEMWL_CID1	BIT(16 + STM32_GPIO_CID1)
+
+#define STM32_GPIO_SEMCR_SEM_MUTEX	BIT(0)
+#define STM32_GPIO_SEMCR_SEMCID_MASK	GENMASK(5, 4)
+
 static void stm32_gpio_set_moder(struct stm32_gpio_regs *regs,
 				 int idx,
 				 int mode)
@@ -92,6 +103,43 @@ static bool stm32_gpio_is_mapped(struct udevice *dev, int offset)
 	return !!(priv->gpio_range & BIT(offset));
 }
 
+bool stm32_gpio_rif_valid(struct stm32_gpio_regs *regs, unsigned int offset)
+{
+	u32 cid, sem;
+
+	cid = readl(&regs->rif[offset].cidcfgr);
+
+	if (!(cid & STM32_GPIO_CIDCFGR_CFEN))
+		return true;
+
+	if (!(cid & STM32_GPIO_CIDCFGR_SEMEN)) {
+		if (FIELD_GET(STM32_GPIO_CIDCFGR_SCID_MASK, cid) == STM32_GPIO_CID1)
+			return true;
+
+		return false;
+	}
+
+	if (!(cid & STM32_GPIO_CIDCFGR_SEMWL_CID1))
+		return false;
+
+	sem = readl(&regs->rif[offset].semcr);
+
+	if (sem & STM32_GPIO_SEMCR_SEM_MUTEX) {
+		if (FIELD_GET(STM32_GPIO_SEMCR_SEMCID_MASK, sem) == STM32_GPIO_CID1)
+			return true;
+
+		return false;
+	}
+
+	writel(STM32_GPIO_SEMCR_SEM_MUTEX, &regs->rif[offset].semcr);
+	sem = readl(&regs->rif[offset].semcr);
+	if (sem & STM32_GPIO_SEMCR_SEM_MUTEX &&
+	    FIELD_GET(STM32_GPIO_SEMCR_SEMCID_MASK, sem) == STM32_GPIO_CID1)
+		return true;
+
+	return false;
+}
+
 static int stm32_gpio_request(struct udevice *dev, unsigned int offset, const char *label)
 {
 	struct stm32_gpio_priv *priv = dev_get_priv(dev);
@@ -110,6 +158,14 @@ static int stm32_gpio_request(struct udevice *dev, unsigned int offset, const ch
 		return -EACCES;
 	}
 
+	/* Deny request access if IO RIF configuration forbids access */
+	if ((drv_data & STM32_GPIO_FLAG_RIF_CTRL) &&
+	    !stm32_gpio_rif_valid(regs, offset)) {
+		dev_err(dev, "Failed to acquire RIF access on IO %s %d @ %p\n",
+			uc_priv->bank_name, offset, regs);
+		return -EACCES;
+	}
+
 	return 0;
 }
 
@@ -183,6 +239,11 @@ static int stm32_gpio_get_function(struct udevice *dev, unsigned int offset)
 	    ((readl(&regs->seccfgr) >> SECCFG_BITS(offset)) & SECCFG_MSK))
 		return GPIOF_PROTECTED;
 
+	/* Return 'protected' if the IO RIF semaphore is not available */
+	if ((drv_data & STM32_GPIO_FLAG_RIF_CTRL) &&
+	    !stm32_gpio_rif_valid(regs, offset))
+		return GPIOF_PROTECTED;
+
 	bits_index = MODE_BITS(offset);
 	mask = MODE_BITS_MASK << bits_index;
 
diff --git a/drivers/gpio/stm32_gpio_priv.h b/drivers/gpio/stm32_gpio_priv.h
index 69868787af0..1da066dec3e 100644
--- a/drivers/gpio/stm32_gpio_priv.h
+++ b/drivers/gpio/stm32_gpio_priv.h
@@ -90,6 +90,7 @@ enum stm32_gpio_delay {
 
 #define STM32_GPIO_FLAG_SEC_CTRL	BIT(0)
 #define STM32_GPIO_FLAG_IO_SYNC_CTRL	BIT(1)
+#define STM32_GPIO_FLAG_RIF_CTRL	BIT(2)
 
 struct stm32_gpio_dsc {
 	u8	port;
@@ -127,6 +128,10 @@ struct stm32_gpio_regs {
 	u32 rfu4;	/* Reserved */
 	u32 delayr[2];	/* GPIO port delay */
 	u32 advcfgr[2];	/* GPIO port PIO control */
+	struct {
+		u32 cidcfgr;	/* GPIO RIF CID configuration */
+		u32 semcr;	/* GPIO RIF semaphore */
+	} rif[16];
 };
 
 struct stm32_gpio_priv {
@@ -134,4 +139,6 @@ struct stm32_gpio_priv {
 	unsigned int gpio_range;
 };
 
+bool stm32_gpio_rif_valid(struct stm32_gpio_regs *regs, unsigned int offset);
+
 #endif /* _STM32_GPIO_PRIV_H_ */
diff --git a/drivers/pinctrl/pinctrl_stm32.c b/drivers/pinctrl/pinctrl_stm32.c
index 27a50392f74..d3b02acbc79 100644
--- a/drivers/pinctrl/pinctrl_stm32.c
+++ b/drivers/pinctrl/pinctrl_stm32.c
@@ -52,6 +52,7 @@ struct stm32_gpio_bank {
 struct stm32_pinctrl_data {
 	bool secure_control;
 	bool io_sync_control;
+	bool rif_control;
 };
 
 #ifndef CONFIG_XPL_BUILD
@@ -285,6 +286,11 @@ static int stm32_pinctrl_get_access(struct udevice *gpio_dev, unsigned int gpio_
 	    ((readl(&regs->seccfgr) >> gpio_idx) & SECCFG_MSK))
 		return -EACCES;
 
+	/* Deny request access if IO RIF semaphore is not available */
+	if ((drv_data & STM32_GPIO_FLAG_RIF_CTRL) &&
+	    !stm32_gpio_rif_valid(regs, gpio_idx))
+		return -EACCES;
+
 	return 0;
 }
 
@@ -550,6 +556,8 @@ static int stm32_pinctrl_bind(struct udevice *dev)
 		gpio_data |= STM32_GPIO_FLAG_SEC_CTRL;
 	if (drv_data->io_sync_control)
 		gpio_data |= STM32_GPIO_FLAG_IO_SYNC_CTRL;
+	if (drv_data->rif_control)
+		gpio_data |= STM32_GPIO_FLAG_RIF_CTRL;
 
 	dev_for_each_subnode(node, dev) {
 		dev_dbg(dev, "bind %s\n", ofnode_get_name(node));
@@ -632,16 +640,19 @@ static struct pinctrl_ops stm32_pinctrl_ops = {
 static const struct stm32_pinctrl_data stm32_pinctrl_base = {
 	.secure_control = false,
 	.io_sync_control = false,
+	.rif_control = false,
 };
 
 static const struct stm32_pinctrl_data stm32_pinctrl_sec = {
 	.secure_control = true,
 	.io_sync_control = false,
+	.rif_control = false,
 };
 
 static const struct stm32_pinctrl_data stm32_pinctrl_sec_iosync = {
 	.secure_control = true,
 	.io_sync_control = true,
+	.rif_control = true,
 };
 
 static const struct udevice_id stm32_pinctrl_ids[] = {

-- 
2.43.0


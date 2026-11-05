Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC5F606A326
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HUqfTERI;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ntrp2dYe
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4595460617;
	Thu,  5 Nov 2026 16:53:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AsCoTJhF0Pbx; Thu,  5 Nov 2026 16:53:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 63AB1605D6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793897591;
	b=WbgZbzwZZzGX4Sq8dKzHRvAzssNoqub6YP60B0QHng9q5Vp9vIaqWa1l0wG+rQX71Zi4
	 I/RsYHx6VYT3BV8i7vsuClWsK2G3o/Wt6BpO70rE2tExk7zaD0Vpz6yjXpbqH4h/3qCRp
	 9yIcVYZT5ltVOS83ILIrEvThHmtf2nBjIF45BijVag3oGhWBQSm3ZVi6XXIKdrL95GCS6
	 /pDekDXe3T3Da55R718GVlzgVw925OFo6Iamytr4i23peY1cYB/XcTInyatsEMSSPYwM6
	 U2iEBMXuUOlBVGJGRaORoA+atZ+O6zRNjpqNU4IecAI9bDn/x063WBLHJp/xlE231kw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793897591;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=bZ9FPCM81FdcoF2LEfj3kk/+1SGXeHoyeq/1XN9/75A=;
	b=nnFkCZCAToUUXFRdaWwcKJCbThBKfYy1Yes1BR3n55eO+3mxX1MafXhR7pls5Cmz5df6
	 N+3f4tErZdv/B3ulG7KMfZhKaZ2ub8ryEKUxZwns+rm0PI4QUlpKrXd4rnUTP30rEqXtf
	 eQglVznr8tioEmoLP+mRobkUv3xBeDb8ARupvTmli8fexoub95Z7p22y4nj8ZTiG5jEGH
	 izozvMglNeJn5qUpLa3iJzUQDDGFK5u48auBxto0r/W4DKKElmbo3uZHdtJPg0IZD+2w+
	 1g9/y4E5U4UPV0j2NMzDWG1M/FRnR01ET2bzOtoLQjtjz13B5c9pIw+4bjd+XPD2TPg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793897591;
	bh=bZ9FPCM81FdcoF2LEfj3kk/+1SGXeHoyeq/1XN9/75A=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HUqfTERIg00lJVYDe2QVd84GNgFBSxoKP0XwTcLYNc0WokyhewbGGZHCZVoSrIX96
	 ISg9w6GwKBfATidSQFHNFHQc8yCZ3UXGnIDRIshfjVEOcjWa372FOENyks+D7MfGtp
	 oB1utXcY0z/rMPA5bez24hsiXgGcZHxQxn+lE1gcMnBREhK03uIW67Y/SAIvdjrv7Z
	 J3TBMvybOOOr2RfxjBG8NZ+Tv0R/TN6enMKYDHKxYDPffsCGAhkSMXjb/BGjrY79pL
	 K1O9UCILPo8KWDcRnYdF2OaM2zOMalXYb5TxbWL1PXj2JjEJRkeV2Asl/YRaCdtzbr
	 l6Z66NIcbN3Jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63AB1605D6;
	Thu,  5 Nov 2026 16:53:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 49D8B31F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C0874083E
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:53:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Pv2X86HD9d4 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 16:53:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EE1184083D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=antonio.borneo@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=ntrp2dYe
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE1184083D
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZ9FPCM81FdcoF2LEfj3kk/+1SGXeHoyeq/1XN9/75A=;
 b=ntrp2dYeyAk9uhEwgNe2fY0PCQKy/oLDcfrpekDPE7xPBgZZL0EvwePqh5rsyezg43ZI2ioUJzznTRv/HUWk7LaXN5twjwAIYzxDTl9sMG7YpFOk4hMKxuViLTbRXeIIAsW6/cBmd5YWnttDALZErZP2Wc3gg5N6RvS3liWQaScUm/II8zVyJmbTHdchePtuyQz/ke9RJa1UegCpc/QgX5wR+5itFRYMBvjixaSITUHrt4XYfgHv8ArJ4o6TVg3bDkJnFvG67svXOIoPzR2syLdt5qgwJBAYLLlaaoRQ6/cIVhrftUmEu49+twgojtLKGPcYRHTttDaunJVmB3DF/A==
Received: from DU2PR04CA0228.eurprd04.prod.outlook.com (2603:10a6:10:2b1::23)
 by VI0PR10MB9075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:214::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 16:53:00 +0000
Received: from MAD0EPF000008AB.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1:cafe::7d) by DU2PR04CA0228.outlook.office365.com
 (2603:10a6:10:2b1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 16:52:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MAD0EPF000008AB.mail.protection.outlook.com (10.167.241.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 16:52:57 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 5 Nov
 2026 17:53:42 +0100
Received: from localhost (10.48.87.124) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 5 Nov
 2026 17:52:56 +0100
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Lukasz Majewski
 <lukma@nabladev.com>
CC: Thomas Bourgoin <thomas.bourgoin@foss.st.com>, Antonio Borneo
 <antonio.borneo@foss.st.com>, <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.u-boot-project.org>
Subject: [PATCH 1/3] clk: stm32mp1: add support for IWDG1
Date: Thu, 5 Nov 2026 17:52:51 +0100
Message-ID: <20261105165253.587809-1-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008AB:EE_|VI0PR10MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: e12afa84-7afa-40cd-6304-08df3b5d3e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|10067099003|18002099003|261021121427099003|11063799006|56012099006|261102123227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: SHvq7Vktf0aEFoh5+XYJsM44fyPgfXTXFhqF1KWlWPF1R7j78WzbQd4cEMdxbA+eVy5mM8OktMJdZeNUx1ZKQqyykoi86hrAp/ahkV0WsBFjN58NXzOZ/yFGgSq/qE+i/Eq0ZkGnBZpZcK8PqbEf9HoDELqYCJ38r/XPOZpOHqADrp1drpZFdYV4fBo/L4gMIKsNf/cPSGOWri58YywQKBxjMHyG/EUk3G5fI1G10U+6ngoU6Y3jHcIjhHXZtQ5YvTnsxh1/n/A0EqeondCveV7oVC3Lkc8Yt28rAoxrJ2F0S82hgd4OfV+Wu36TeHlFoW0lNFWerJCTWosUy7tsEXBt85jzaEbtc8hJucdj/7JE2ecwpgXGOEOTYt8JaYRI75JYdWh8ozMvr9VjB/srZnLIEyly2L3+Vn81yIDY8ELSKkJrXn1lt8cZfvai81evfoZzXIEOtZYNGHPeiS0Sg8CxOtIC73NkZ+FypN3EhgyTcZB3DhMBSoGOLbsc88tRe4HalZ8pI/Eo8mJnBxd9w8U+cUmrp+PCK6b4yDqGiJ+x7w2rMOy8h0hXQFFjRrhIEXPVEBO/Bcc82G5u2HmzUvkjNGohOAvPqCtPGj0azGknEDhKYsETvCXOfqntesMCl4RhvRJm0qJOG9QyxrdODGb3gw0ktYiLU64mr+xdKcz6JI+gmH0Gs8gFcDRUN45JW42AVIchaVXg9d4QwD3dDg==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(261021121427099003)(11063799006)(56012099006)(261102123227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 95z+Pgg3pR6SKr9hQUbJBeKEPqtWXf1zZpPUXXkJjNoAkdLDMtiHkRoiPshs4WFy79dK1nA6xYuXWiI3vm71RI4C3h4WvTYRGdWAWBIALj3JJ1gn+tYvLSdaMj3XaZAZ63dDLE4ii1MGDo1v5zlcIDTqT6NXkvfu+Zp4DWkpRBzQOH4D1L+Y7jhZijU7CNFIPtXiXOC96qLSh4leo+C5AHIcAlKygdQ6sL/EWXqrS94ghu/aQKBNLPq865B9bd5FvM49HqsNKd8sz4xdRqHO3ihBrVfCm1snW2rnXou8NbRtDPYZbeENphGtlS8Fiku+/WRuYg07c37Qet4AOAataUxonkWz8p/gugASyNzU2FRHTE/Xj4dyC0eZ/FwCZs7tzIfWhFINgO6k6B+NQgiZ2Hs+K9PJKsBnTJL3nxTMPOyu3Xh1lX8yntQDZplSpr7Z
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:52:57.2228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e12afa84-7afa-40cd-6304-08df3b5d3e4f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008AB.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9075
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Thomas Bourgoin <thomas.bourgoin@foss.st.com>

Add the missing IWDG1 peripheral clock, controlled by the
IWDG1APBEN bit (at position 15) in RCC_MP_APB5ENSETR.

This allows SPL or U-Boot to ping IWDG1 if it was started
by the hardware or by an earlier boot stage.

Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/clk/stm32/clk-stm32mp1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/stm32/clk-stm32mp1.c b/drivers/clk/stm32/clk-stm32mp1.c
index 823ce132d0b..04087cabc14 100644
--- a/drivers/clk/stm32/clk-stm32mp1.c
+++ b/drivers/clk/stm32/clk-stm32mp1.c
@@ -561,6 +561,7 @@ static const struct stm32mp1_clk_gate stm32mp1_clk_gate[] = {
 	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 3, I2C6_K, _I2C46_SEL),
 	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 4, USART1_K, _UART1_SEL),
 	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 8, RTCAPB, _PCLK5),
+	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 15, IWDG1, _UNKNOWN_SEL),
 	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 16, BSEC, _UNKNOWN_SEL),
 	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 20, STGEN_K, _STGEN_SEL),
 

base-commit: dfcfc4c9f78d1743f490a497082a4ec8e058aae8
-- 
2.34.1


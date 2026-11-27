Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD87606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D+F46k6T;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=f3NwmHTq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E109840A7F;
	Fri, 27 Nov 2026 13:04:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V_uWACeeSYme; Fri, 27 Nov 2026 13:04:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2B50D409E3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795784684;
	b=c8OYwgU85qNypT5BlX1FAA50JbRNsuwDy9SUMNuXTEKoy7zT2CqBI5X/HJ+AbAsUEqFI
	 Ry48VJUZ85+7Tlhe5Kky6ktPs0hhO91SVp5jViJcK1J5fLmawuGyiQJcIFUBxgwgF+Ubl
	 npjvgF/6zAjxJesj+W22sUPA9Wevk0a/S/nqrZ+UySCHpkqNlGusyEtKi1M2Tp3JEkDef
	 Zi9pL2g6IXMMSKsvoGSt9Ge3A1Vt38C+/SBhZe1/pshkv0TatHRW1DHdQ1D6uv1yZeCq/
	 fvHUVf/pktS+zs0i7HQK/H0DczA6/RlCV+iaFgcJpi7menE8SRfnoLIcZvKyTmz4TyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795784684;
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
	bh=go+akpvmPZGMp4EKnJ87bXqRmQ7wq9KAtXAYwwjeKr8=;
	b=oIuJkVGGsWmxzfQMWM/A0RFQ84iuUSbUqUkt4kqSLe5V92dHdY/5APkOjKoxDHsFWbsL
	 0KDr8P3rPGEzx43PFAxz4MKLV4/aRwzCjlyv3lzmRnh3nGQoGPNJ3R8xntNrF8TtLKV3n
	 hKS3Kz89a1Bu9RxC3aJk6vbNyJuuJGQ2Ql/wKEgaJ41mUx5GtGILFl4y/LmAfAaHOtACy
	 8RFY0gHAOqAZt173mug8NFDrOV6vGS9KZaB/3YMWlV88tQQ/opGC5EbQXv8b2w2nlTbFJ
	 yF0HYzkKjYGkyMAfN5D4rvuWlPc6PcGcRvrZpwSPO/HqEF+fiKqiuuuI0ILUeVFv7GQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795784684;
	bh=go+akpvmPZGMp4EKnJ87bXqRmQ7wq9KAtXAYwwjeKr8=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D+F46k6T7pd4cJhoT4cdH2vBPKs7MismSCd0ZqdcjZMFKFkaGoORSL7AHQzQbE3iQ
	 HyUBl9oL0WLmZzW1hKCkCcXmdAIBwzigaghGb54v0GM2oCwBtmZl0uB6LIW2LYw+2X
	 MHroCdy8iIA3ykNuwVzESarZRZ4VUDfBlES9Em0J7c7IfqkRurpIqhJtQS8lOiJ5Jg
	 8ziiWEQy2jvZyAlRJzLNB0GG4dN9rk0YQsWZOdyb+Uwbqyu298An9cGNa243CNdjeC
	 PFHzOUkhYgmwHN8yJka3nc0dk6Vyrp9BKxzXL9PBQ8Q4/D0dkPJwQJL2QIeCbBvLL6
	 mW+43V0wA6enQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B50D409E3;
	Fri, 27 Nov 2026 13:04:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C0ECBEC
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 29540401D2
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hjO9_XombrEX for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:04:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1DEC1400F5
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=f3NwmHTq
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1DEC1400F5
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=go+akpvmPZGMp4EKnJ87bXqRmQ7wq9KAtXAYwwjeKr8=;
 b=f3NwmHTqxDb0wPzAAQpozs72L+PtXOdof2t1H4yWFebKLhkxPiknJTAnvyRmBmp61GETeKBX2SsuU+2fzujtLopRLJu+WmEhp5r3UG+UNH4FDS0iw51F9MMJee4pj0ZA9DtXoawv+jz4aI6iNoVjZrOHmG+iR8psFjfSzudIle2cnhMN4n7iQwH1O8oeq2g/aTz9d1kobbcBVNDmwt4/pWP2Lf28w1CUUHnxlnficXBhxm52QWElqXJ4MPEv6I0YKObJj5imSAR7EFXoJ7kDORlqyPiUvh+olHbKlYj3obK1xcjr3sepIzSEEAhwBPvXmXPcnNrItfVWhtfA2ncwQA==
Received: from BE1P281CA0079.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:78::18)
 by MMZPR10MB510724.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:190:33::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 13:04:27 +0000
Received: from WA1PEPF00009B3E.eurprd05.prod.outlook.com
 (2603:10a6:b10:78:cafe::1f) by BE1P281CA0079.outlook.office365.com
 (2603:10a6:b10:78::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.5 via Frontend Transport; Fri, 27
 Nov 2026 13:04:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 WA1PEPF00009B3E.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 13:04:26 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:05:11 +0100
Received: from localhost (10.252.12.59) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:04:20 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 27 Nov 2026 14:04:18 +0100
Subject: [PATCH 5/8] configs: stm32mp25: activate CONFIG_RNG_STM32
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261127-upstream_stm32_rng-v1-5-b8b4a9fdc8a8@foss.st.com>
References: <20261127-upstream_stm32_rng-v1-0-b8b4a9fdc8a8@foss.st.com>
In-Reply-To: <20261127-upstream_stm32_rng-v1-0-b8b4a9fdc8a8@foss.st.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
CC: Sughosh Ganu <sughosh.ganu@arm.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 =?utf-8?q?Maxime_M=C3=A9r=C3=A9?= <maxime.mere@foss.st.com>, "Gatien
 Chevallier" <gatien.chevallier@foss.st.com>, Nicolas Le Bayon
 <nicolas.le.bayon@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B3E:EE_|MMZPR10MB510724:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de06e3f-68c4-43f5-e1a6-08df4c86f6e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|11063799006|261009223027099003|18002099003|22082099003|10067099003|56012099006|261102123227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: dZ7AGeVE4Q4/jXAyRe6SrfTUkuNjBL6Wbqh5uz8CF2UCGVp95m8BPGe+GlbPSMwIDsC3jK2x4V42W/EXEe5AS/lDLzZ9UqfNg/YQf5hl32/j/Z8iGzf5Vk2Ecp6tbZOJtNOtPH4IoTV4TqBrUts2vwaEQ4wb8Fvn8JFw17l00qJTUbEwkvexocHc3Fm7MubEt3SR0zgd7qLiRTp+L9qjyCWjQZxSKlK7h9qOgCAxEaHzMIVBM8XogS7gBoE2eYoLR0saaCmSxAbqBoFor1Io6F608Nw6roSOeOLlXQNkCNElBelVz3JT8BJAt0NCjPm1MQIADvbOhzEM3XztFAMPlqumfizEVjdtv7TiwGTWl/ZPRT7tIalkMwSp8j8esS+kOK6rfaLRVeSYkIOyIkVqdnDHCtL1PXsh3xudpbvjzAiCakPCmPXVBCHD0zM6gfCk0tLHc19qYx36gwQ4/Ni2n+8oM5gkDmT+slzFvH/pdBV54PrTaQaW1ZLBeylqGINp7CBtYjlLo2mvYgdt5qJdLi6PBqqAZQsRXyabvekcWXxDj24DslXUl8gTT9pWUy4eBus07euzGFBgITbwAof+osNg5md2F8f0FPlESEbu3GgrkoWv73bxRResf6L0cVrkDn7OPdzlo16WMLq25crY9Yuvz9qWlZ9sTQR4yY8pCFNkpBKPZGZcSKjSnl3nfdg369vGANTZ5AgVEjFZPfE3hw==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(11063799006)(261009223027099003)(18002099003)(22082099003)(10067099003)(56012099006)(261102123227099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vc7UD9aBNKzkQm8vpo1gLxt+/HYF8FohGOeDC4HECzdqrSbStmMuPqTL1VN4lrvLdJq7UmPp/LvIRALbaTdS1mh4tmHNJziznhhzFLnd1gaMi/oB9tezybetLt49rMY7Zxwxmd8K4VS7zjyGPjsPhF7Xcdp/sz2VVP3OmBhLWnzP2ORCuQTSqlJYrd+Nd/yVd5cwksR1S4/TPVSO/Loc5uHd/hKRIK4YPMpJMbPvZmSaNug5ziUCn9B8I00iji92GRdTxGr6Jtv8gEmi9a3pWohdMUo0ve9dk+WFb2Vi0GYlXp87dXJaRlzzDDHP6JTe25cI8gqg29ifOpIyki+rgnp4DuOdv/lGrU/MNAbWAccgebIGDhw+mWnPBege0dvdXHoBn9KmOAN/9iqb15BjxUg0AYAHyhK7FPTpvUz5rbCV/fJrG4U9Umbdnx0KMXNM
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:04:26.0218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de06e3f-68c4-43f5-e1a6-08df4c86f6e3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF00009B3E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR10MB510724
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

From: Gatien Chevallier <gatien.chevallier@foss.st.com>

Activate the support of RNG on STM32MP25 platforms.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 configs/stm32mp25_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
index e55ca2e3f0f..aba36e5ce56 100644
--- a/configs/stm32mp25_defconfig
+++ b/configs/stm32mp25_defconfig
@@ -89,6 +89,7 @@ CONFIG_PWM_STM32=y
 CONFIG_RAM=y
 # CONFIG_STM32MP1_DDR is not set
 CONFIG_DM_RNG=y
+CONFIG_RNG_STM32=y
 CONFIG_SERIAL_RX_BUFFER=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y

-- 
2.43.0


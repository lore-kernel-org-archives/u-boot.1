Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7A9606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=flpJV6TS;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ITwPvP8I
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CEB260A51;
	Fri, 27 Nov 2026 13:04:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EhWdtHBcg5xa; Fri, 27 Nov 2026 13:04:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C394E60A54
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795784669;
	b=RHQm9SsKO9wCswciPKYwTlYnqEj079EN4bAFYA/YFehsQuyAx+puw/PSMwg1IZI/tErk
	 c3zelp8HE1yPZLu5TpPvv7UDau3DBnd5HgGz70yDrih5Yhp137JLkS4QviFulka7pAgMF
	 uSSzQl5jr6HGl4+ZCltTGFPblhJm32EQ/0BluuDY2oyAzjdi4hYhyDKwJ2r4YypiOYTDo
	 QwEhhwOD66Pd4NSwWgKZt69ynx6rvYkx379jSUzjVZa87Befllb9ehQeGSQITusao/9NI
	 J5ke45yD5v3vM4Fg2kKeg3Or33+GIGNA3qlsaatMYhkvhqwcVx4IrUlHALij0uOZpaw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795784669;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-Originating-IP:X-ClientProxiedBy:
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
	bh=D/ffIj3SjDfuco91HhfxX9XOuKf2OKXNgCh1pfp/N/g=;
	b=j/N6KkyOD78IyUFI8059yWsviMTk7KiyTwn0csbPuFY5B+8dU8W6+B63hzOg7RX2+cvH
	 es9wdDkGn2R/5fvYmhsqp4No5eYDLQ8eL99sGicHNS81sGMumDNjfDyzd64++MnMJOFGS
	 s2v7oMPBROOLiwbJ9ve1R2cBTU2v9EbqevL54JfHwZieuyzbjEOivoSOmVmrGdRJZfmya
	 xEkXXbSvponlMBDgu47QtrsyuxlVrVbK0reYl3fiJxCtGvXJBbmXTwJmVGNvV2j/rwhcG
	 JRMTBmKT5YqUrsSXdDkJIZ8q3otY3TIjaRls3eV1hLijPq5C5mLg3HeB905+rXH9IUg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795784669;
	bh=D/ffIj3SjDfuco91HhfxX9XOuKf2OKXNgCh1pfp/N/g=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=flpJV6TS4Oxe4Zsb7clH/bwUS0uHC7eqTJ5QY6A11zjVQAN7Oa6zEvnc8ZxrWdBjr
	 x5+JFzn8MGFd/sDIx3pS3utljGSUkddW3yby+JhMqwtbZMdzyiITwmfNV6TQlkcS8x
	 NdfeeNv2dRdLCRnd3RkRmDkT+X2mLAQ8ELf52PFJWrK5W6ThD1WZUQE4RCqjiKMgxt
	 FP/wgv7c3h5JipqOh53LmLCB30JoAvEn6adI0aPFe/JTf9/Uor3UMBFQs7HY1ReYJY
	 4/kbM8mTN4vulQr93M+wQYQd9oOu1pHs6JjDyCncc9PUjSZnOnGJQvTmu3ksVogb04
	 Lh1JMFOosYjPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C394E60A54;
	Fri, 27 Nov 2026 13:04:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0875CD1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0578081138
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nBzotTN8fVXm for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:04:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 82A348111D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=ITwPvP8I
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 82A348111D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/ffIj3SjDfuco91HhfxX9XOuKf2OKXNgCh1pfp/N/g=;
 b=ITwPvP8I6g2FrCv94sIGJocgMNn/IL11qc55AXKF34NwxazvlbyQECvMfeXL2nCvrf5Th4taWbq75LNnFQy5zlqu9hZf/8DUj43JrohnnbyxI1XvYa99aha0gMg9Z9zKOjvf35GQmV+cXwFGNj3xxt419xc7Cy2i4woZFjGd6bwdzdNiQNk/lt932iu7Hzyh2d2BB2SkkLbfovbuQZQLobplVf69cvbqFqqYDmoBZhB7NXgPqwv5jOs0wVl2cux9JekL1Jt5UJkZ2HE0N9DpPMFwctVGNJh6UrBaQmjAr95+n16Tsku/ChYNak4HmZQSfnt3lf5sRM1l1I/1mjZTKg==
Received: from DU7P250CA0024.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::17)
 by DU0PR10MB6275.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 13:04:17 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:54f:cafe::7) by DU7P250CA0024.outlook.office365.com
 (2603:10a6:10:54f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 13:04:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 13:04:17 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:05:23 +0100
Received: from localhost (10.252.12.59) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:04:16 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 0/8] rng: stm32: Fixes and new SoC support
Date: Fri, 27 Nov 2026 14:04:13 +0100
Message-ID: <20261127-upstream_stm32_rng-v1-0-b8b4a9fdc8a8@foss.st.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM1/CWsC/yXMQQqDMBBA0avIrBtIUongVUoRTcY4gqnMRCmId
 zety7f4/wBBJhRoqwMYdxL6pALzqMBPfYqoKBSD1dYZYxu1rZIZ+6WTvDxtxykq3bgah+B1MCO
 UcGUc6fufvt63ZRtm9Pl3gvO8AKWb69h2AAAA
X-Change-ID: 20261127-upstream_stm32_rng-0764ebdc0d1f
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F4:EE_|DU0PR10MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e37514-4608-4874-c236-08df4c86f19c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|56012099006|11063799006|261021121427099003|261009223027099003|261021123027099003|261102123227099003|261021135927099003|261022075727099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: wkG6hGNrr1beRK5yshu2GztoFdj7vdFa6QZkzyr3hypa6RWoSAqFuop9bUXQuMSAUXqh1d7efbHKwOT/VkNFax9gZsaMhudsBoqat+6FNtxD7q10akJjxDrBApDadEssZmj92E144zpKQh9cIMB9q2Mm336N09dOHS3qC/OuJ76ahCiOpxVWNO+NPjH9U8PGmEGkFxRp63+cbLimOE/sQAFsw/AnPO4Di8G2IbGs/HkuqhLlq6V5Qxjfzk5r1L2aF7LtWx3uGrtgrdM4eFZNdf4j3bgaG1aWrp/uEwE7mTuRJBppPDf+PauOm61TiJhR5r4quhnJX4eFdFjTdo7prHdTGxIfJHNCcDjFR/iqlpggsElCVskzDEZvVijLywWcyR+13AnXQSUQ09JcUnP2eoymgBRn0fI1fJ+bA56QcQuISL8ZFnV1fws+mQYw5KpEc4oVEEkidVNvOyqiOgkkNYZK5YaZayqJaCEoTDg5IGFZtNBvIwC1Obvf3nmZBI0cMvusz36+9mIgSHTBOPGSBEmx9gs2kWx/mVd+wVskk61r9t9j05dbJHWEEw3AJANfC8AEU4WFwXOl1UuFRw2zW2BXGfhDzVq2XLP5JEwu5FsafHiGnYElDfMi5wotm0Bsjas61pOvHTX5Gd5i6VRCJlHDROb/tJBhickcY1KvB5JxZZx15RwRET0Ob2L7CD6aUv4bIEAHGRPZ8pDfYcEwOg==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(261021121427099003)(261009223027099003)(261021123027099003)(261102123227099003)(261021135927099003)(261022075727099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v1RKy8dh0cGc7Yv++RjjMJz4br8F9H9v05nMQvmCgkxwqZSFkLiT9a+XniM9n3S6Pqrecd+AvyguQyPZXEilWUHxt3+V4nRmGMOtkX4mDM/F1V07dZzy4y3Z9RbCtHBchx3492rq/1TGkxs5xK0JTiG4gYA97o9X49bHivRtdm7vZ+Cj1iCWgv43ZlkIFRJi1t9Gj64TquanajamhxJ1AU8OhYJF1d3BB91HNd9SKbx/ym2diaWiH4vekaSJ9NBQQmMpncbksieDVo5yIQthYQUpqSswRNHCl0ZM/y2+14nC4SUmedt7ta8ZKail5qsvGT7QK80ouD5JfYk3f9denD7f/u+YfzNtvExhXrH+Dte6ONLxpBwSM0nEGfccTHHrRx4eYIbnjTGAUbS1zLAAp6Mr6syxntUrqFjOhn0EZbjQrMu4BjSsFt9rzMBRnMnf
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:04:17.1718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e37514-4608-4874-c236-08df4c86f19c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6275
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

_ Add STM23MP21/23/25 support
_ Increase frequency for STM32MP15
_ Fix RNG_CR_CONFIG1/3 registers definition
_ Update STM32MP25 config for NIST certification 

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Gatien Chevallier (3):
      rng: stm32: update STM32MP15 max RNG clock frequency
      rng: stm32: add STM32MP25 support
      configs: stm32mp25: activate CONFIG_RNG_STM32

Maxime Méré (1):
      rng: stm32: update default RNG configuration for STM32MP25

Nicolas Le Bayon (2):
      rng: stm32: fix RNG_CR_CONFIG1/3 definitions
      rng: stm32: add STM32MP21 support

Patrice Chotard (2):
      configs: stm32mp23: activate CONFIG_RNG_STM32
      configs: stm32mp21: activate CONFIG_RNG_STM32

 configs/stm32mp21_defconfig |  1 +
 configs/stm32mp23_defconfig |  1 +
 configs/stm32mp25_defconfig |  1 +
 drivers/rng/stm32_rng.c     | 89 +++++++++++++++++++++++++++++++++++++--------
 4 files changed, 76 insertions(+), 16 deletions(-)
---
base-commit: ee1b3477e3af6af1ae9b8f98bc84d2cc6f32a3a6
change-id: 20261127-upstream_stm32_rng-0764ebdc0d1f

Best regards,
--  
Patrice Chotard <patrice.chotard@foss.st.com>


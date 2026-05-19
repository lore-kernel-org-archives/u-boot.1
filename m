Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6A0CD4F52
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 08:07:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F20A5846C6;
	Tue, 19 May 2026 10:07:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="O0lCH+8a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1676846BD; Tue, 19 May 2026 10:07:51 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13D458460E
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 10:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yann.gautier@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tY4KJFPMol9rJwrjBUtS9s8vqU9WIiN0tVd+l8ae8lseEU7KyYgjuOlS09GIfrg0QKKcR9g/XFTNMrLDSINEuxHFjsoX0BnEYJdGHCInMOrptLZyp3dlBCBl414GB2P9pIlExEF8QrjE67xr8PStk96Cu0z65kJWtE9F7Sb70SKz0nOR/zVo7hoUPd0kUp9Gqdxx4WRMsfzpMtivvjxKKgtmFz96ra6JeThJafDAJ5uT3VW3hubfvSgOSSpKNDWRAX+VMoBgvlu7Tt36HDrhCR/Xka3s6KSNZmLWLeXRXdEa+Uq7mu7iZnJU/SeP1pJi6/vIW6rLDpa60Huwhig+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwWMu76H6ng6TK6yt5p918GJ5+WiHOMPeN3PYUHxPZ8=;
 b=CPN/HGkuUuVq+Fj4JHq3RQUdqw0dcyaNwkvc9PEjSAReiCW2jTplcBsrN1WHzVNuIk40P18fQ5ZuaBrw0ApBM5e0tS94wQtihj1AvVJT4zPMu/6eVJ0vQW524bvFEjLkzYhRTDqM9bPv4s6ckOGi+7DVbWv7qXzbCR0FtoSS8wmUQ0N6SoEeZtvGZKR1tNAqzUHVnu5trSTjqnIS3Ibd0wUIk5UifPm2anJJCbbbJUv2EXWxWB4BTGck7BRAgFT2zdhgGoYsWmfzKS68oWq2c8pNMmX1Nemu9KE/JiOuQpRhRI6ul2Hc4cFbSNJjrpH+sKyLvOK7AcstHmyf3M9dwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwWMu76H6ng6TK6yt5p918GJ5+WiHOMPeN3PYUHxPZ8=;
 b=O0lCH+8ai3r2xEu5D7IrPWiJvP0C3T1BkrAdA+jEodsqXjz5cgSSyjxC9oItB9PXwbrYVSonbhyIKIg1TrQw5RpIHhxSYbJbf6DGfX+HQFQIb4J4fNsfuTfBR3090/VSF8PP2BKW4lp1kgCPnebtRY5zR4bsdnaOcOal4knYiyzMYnF2phOp8phxRxm9wXWBYbDmoSLmGRRM/wto6CEyAGfUCDb08XAEdxijcb4a7uVy+4b7MUJRtmCkNv5M2hQxzc8BsFtgQXkfxuMr+gKreLgTs6DI80VHpK4gUNwzb1bhMA7JsLIfgmAZvmPiqD/GPZ0ubmwyeCD63GYIoksLfw==
Received: from DB3PR06CA0006.eurprd06.prod.outlook.com (2603:10a6:8:1::19) by
 DU0PR10MB6020.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b0::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Tue, 19 May 2026 08:07:45 +0000
Received: from DU2PEPF00028D01.eurprd03.prod.outlook.com (2603:10a6:8:1::4) by
 DB3PR06CA0006.outlook.office365.com (2603:10a6:8:1::19) with
 Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via
 Frontend Transport; Tue, 19 May 2026 08:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D01.mail.protection.outlook.com (10.167.242.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 08:07:44 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 19 May
 2026 10:11:13 +0200
Received: from localhost (10.252.30.192) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 19 May
 2026 10:07:44 +0200
From: Yann Gautier <yann.gautier@foss.st.com>
To: <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, Yann Gautier <yann.gautier@foss.st.com>,
 Christophe KERELLO <christophe.kerello@foss.st.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Patrice CHOTARD
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] configs: stm32: enable WDT_ARM_SMC driver
Date: Tue, 19 May 2026 10:07:35 +0200
Message-ID: <20260519080737.47928-2-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519080737.47928-1-yann.gautier@foss.st.com>
References: <20260519080737.47928-1-yann.gautier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.30.192]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D01:EE_|DU0PR10MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 39cc95a8-a735-40bb-fc48-08deb57db553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: xE2thtSU4nTsa+EeMpH1w2fYN9GKK/tqYAe81trj6SG+cfwa+2CIY7LmvhmtWJmSOtUSqkJIYZbi1wwBLG2GkqF9U6SXtMCGCBRz7sN7vGKYzb/qPOw5EbZc1nQ4hXkg8l0d4bVVYRp28wi0bn4RhZfoA5z0WXtdzmJWOE/iuugq2IOJtFBlNn6i5+0XPxSr/f+OT4aAhKnvKbkZHHXWPAAV0lKEba4bJ8j38wZ6DKt2KOi7T1KsT7eQNabejKxAtNchdR3prZpcvMDFOZHs6JH9iVS7w64d0+Y+QUXtD3hhcdV4h/URsSy6oC5PHHlnvlCqSgdAL57JJxMKNxel0tilJYL8VvUHEbofNclRp1YElQFIK4g1uUyoJwFYQIl9YXFb2GmRzLgc0X5tP0l4Su8z9mM+isXwSctb4sNNqn4XitBwDV6ElMPLhxjdma9eaIX+nXkZSOLenmmGjPyAp6AAZCXM3A95pjzDI7clr0cjgcHI/A+mFrENBQ310WCVo9aeevWYzxVbPj9F1tn3wQpJltW4it7pTp+M0+Bs+6IrOY2jhyUHwDwQV9uGvbTB29LbSEz0zkBbyVHd16953P7qmjjPNGSu3d02BxSRkyZZx4GS8McKNCUQkY3nxWIZvMNlL3y+2a9iDhj50PeuzPoc7YZplF2KL1hDtnhYUhI4hqjmjhlR1T3c6gi/k2zMN1eiXWLLZ5jZnlQ1gUyuGEr4fYBgGvHCt1lU3kQ0CfY=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(11063799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yXqfYZpDovyr7kKYY1O00b6VyeNpmLxfAcie9QoUfzQHsFx/PWGqyk7EQzRRdzB2Jysl55QLBPNfLleB3lY2bX6bQ1lHsZfHNkVI7kzIetUDhFJYcXHDjbBOKvODSMh8PR9cuxmiXAnPh/g7wKzIH7boQ+HCxuDVpKXh8fQXO6OqfrIzft7FHDXRZHk4u6i0E29twESxZLUX42iuzTW/Un249bhzliDPJtDMvG8ySt9AVbet0DgXuaweP5bj0hbxAhImPqFaMSv0gTWopWGwHdG84Pc67YiAeFy94Nrj/xl6zB7jLmfbbzThijcZ13IoBCrNSV4/wtWr7LpaI9hgAnEj7OzSQ/J1O4NxCjzyb6teM4cWllTKZuIlzyL2gugzoxPHrxMI/lRXSkiG0Em2wTPQmiJ2XPGQ+7mp91p57gIpwIvXlPjcfAIGuOnW9yjV
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 08:07:44.9821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cc95a8-a735-40bb-fc48-08deb57db553
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6020
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

From: Lionel Debieve <lionel.debieve@foss.st.com>

Enable the arm watchdog over SMC driver.

Signed-off-by: Lionel Debieve <lionel.debieve@foss.st.com>
Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>

---

 configs/stm32mp15_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/stm32mp15_defconfig b/configs/stm32mp15_defconfig
index b9e44254087a..2ee08dc15551 100644
--- a/configs/stm32mp15_defconfig
+++ b/configs/stm32mp15_defconfig
@@ -169,5 +169,6 @@ CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
 CONFIG_WDT=y
 CONFIG_WDT_STM32MP=y
+CONFIG_WDT_ARM_SMC=y
 # CONFIG_BINMAN_FDT is not set
 CONFIG_ERRNO_STR=y
-- 
2.34.1


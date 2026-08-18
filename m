Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A394BC5DF81
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 15:12:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA3B260902;
	Tue, 18 Aug 2026 15:12:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E6ZEfTjudTir; Tue, 18 Aug 2026 15:12:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6C99608F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787065925;
	bh=siJwourR2EAL0L7fwdrPGfB1mSKjfi4lPGef3zqlwgc=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nymBn4BfPQwsZbQ0Phn9btEK78oWfU/zYWaXpZbzUA/ukqQaoCN0gPxdYJkEqlKx4
	 YdGVS0LUBtx85pvA5wKfIZdnNDEFFvpdqD1nXulUijkCRd4copslPO2DgbBS6LOcQY
	 +w+qxWalI0embQYhIRXBi9Ch7ie+aGMDl2UWqUiFrzVgsuVDXxPfVXevQlkqknHZno
	 lVzzsdPd9Oeo6McLhSc/qcJ6nFTKlSfGYJLXSoHf5Li9cZ4tB1kQ3Zs5/PRKTU/tKD
	 qoTWUeASDme6Vzxi6/I0/XO2QnmrQ3r1Z1a2iAGSQHIheiW+4M8egtVDWBK2kfkPJR
	 zTg2dykGcm9bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6C99608F0;
	Tue, 18 Aug 2026 15:12:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9368F322
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 15:12:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9134780CA7
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 15:12:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FoeKV57jJnxI for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 15:12:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 726E980C66
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 726E980C66
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=JRSoPzW0
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 726E980C66
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 15:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEOTqc3xsdTujvHb9fR23NuBVir+Hu9dBuFJ4JDM+lAWuTHu0p6fdAMyCSmOntad+bWQolYo4gC/CSgaPKNvanUR9PtPn7yJCH/8YBq6EADvX40vx7kkz3euPqNCRJLpf+fYpNaaOpHl0xX0h/QPCNg6U3CcPo4eQNCnfY+zr0KgH1VzNJFJPTgKTJvjep81id/fDB8obL2q2F6R1xmO6RdPIT3StXNIZ75Vw5HvvS5I4+Q8XeBg29yVoiPBBDu2CQj0SjtaozeL7iQQwXrBjrrVvMiUaXmRiYkf5Infvo+SA2iByAR9ixO1WLjXlu6i+VXT1wL0rachfgkmfJZl8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siJwourR2EAL0L7fwdrPGfB1mSKjfi4lPGef3zqlwgc=;
 b=mZI5YzUSU2Rz34cDAVfBTA8SzsM6wAcGJfjBAfkbAk43X8LlOTFBZsJYUbBkKmuzCkeuPJfJFV10qh8QqJOtECN4WIDz7840Oi6kKCM+wfDfkaOGBgNvWFtzaYNTpbyGufVjEG2BCAJu8Q06hov7YbiVMi7NVXnwhLqPALoSaFloWsm8fQfj1iM/l7wGyOfvK4N1gHW7EH9YmM+a7vFIgh8uGk604h+uSYgjUs2Ne7BUoyOZNLqkld/IEkPLXtLy15KCQ/IuP/ldoaBFyDjflaq+mBWHV15P6RDTmiVNid3Cq8kCKmMrhmDHDFiuf1fszJ9wjPe0lh2KpVHmFWjXJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siJwourR2EAL0L7fwdrPGfB1mSKjfi4lPGef3zqlwgc=;
 b=JRSoPzW0SeD7TK2QVMeEcLr8ck63F4tfAI8yDejllgaudv4gD4RIvXBDKwOVtEZAnkMWYvyaW3q7ebVd/0/MBNyAqFCZhMG/uj1QbRHW4q12XK4eiwLyclTX5QVnuaVPeTYCr5JaxeJn0YW4YDl8ONDAyt+3uYYHZDXTUq3gR9Agn9tXWnUhZrWnEL1n8bzA24exnK337K5ohXqBLhtqzeghC035HqZalI4L7A/c7ha/uToQcQNEdbTZ85mCiy/x0QDeDsL/DAKOEp2Clu438Y+ialmjnPFyMqkmOFPEAlx/Rftzn1cttsjtHcQ1vIN+f/56vZEoUp4XAk8aDt3Ffg==
Received: from DUZPR01CA0239.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::28) by AS1PR10MB5413.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:4af::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 15:11:56 +0000
Received: from DB5PEPF00014B98.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::a5) by DUZPR01CA0239.outlook.office365.com
 (2603:10a6:10:4b5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 15:11:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B98.mail.protection.outlook.com (10.167.8.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 15:11:55 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 18 Aug
 2026 17:16:52 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 18 Aug
 2026 17:11:53 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Tue, 18 Aug 2026 17:11:51 +0200
Subject: [PATCH 1/2] ARM: stm32mp2: fix TAMP_FWU_BOOT_IDX_MASK/OFFSET
 definition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260818-fix_tamp_fwu_boot_idx_mask-offset_definition-v1-1-611201a282ce@foss.st.com>
References: <20260818-fix_tamp_fwu_boot_idx_mask-offset_definition-v1-0-611201a282ce@foss.st.com>
In-Reply-To: <20260818-fix_tamp_fwu_boot_idx_mask-offset_definition-v1-0-611201a282ce@foss.st.com>
To: <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.u-boot-project.org>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B98:EE_|AS1PR10MB5413:EE_
X-MS-Office365-Filtering-Correlation-Id: 81879855-fec7-40b2-d5dc-08defd3b0a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zZXCWuiQGWVwebfocOsy3EM9NObZj78SyXB/LZm5WCnT5wjhaCfa0Flxq8ZQwckMgRB7wCca5Ec/of6F6efBGYw08B+87AgB0mzI1XumqgwqUYcVQIR/H70hspNBOtajwVRXMA/qHb/y7rFgDirnUa0oKfq5rxwFC/BKORJlc16nHGYFXkB3TOblukqwYtFDtbecwV2KPfC4pnYbGvaNpGvsUO+iH9859Lsud8eL2repvv8TEvYD41i9OFBRAB8gpoKxd3qjrFLSuL4rMY+W2nwZ+ddzAJhE16/i5w8yUTWyazlx5b7zB4I14wyMpPz6XBzM83jzTMslzzyJKQral1ryaDxeVnPcqeRVPrv4ue+F+oaS6d236QkSAxzGlNmdm/zivAEvC3JuZA7P41MgJfuYAGVV5SYHgL8alQtfK06bxXxZIGWJw10wI4ffI+OYYa6lydDEZB7fLXXuk3JdWI2je7ffd3iik0FdYT7z+t53z6tzQ5EGL6HSSCbeIEvX1wac6Y+AtjsmtGYTQZetDHxYevjewRoTOrr8l1PS4m8dxW3mpbuHHZUQ1ssdF5USgC/aIV2iRsk5OTPGksS6zrNBIv87dicFWSBm5oKHJSBgsBZ17LdEEpWcBbc8cjT755vuS1+/2B/ZVuhgB4EYRr1ccaLPqgwNzAOQKzrLXmvhzkGzDW1uBFfrUwp4VDxH2Uuct+Ajkvyawa7e95UwQQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v7OEChy+WX+QMovgLnf/1IUieqLR+XlMSlwUd7x6jhy1nDh7/3kk5wXuucLMbabKMGfjfYtVmF+zYWLttG57FntwBDiIH4HBi3+IWydMnghH63Xz2fgKIkp/GTi5fr7JoQKELFszH2v1HS9racU+1+aXBtXOah0ZJ4wMiQeD/C8/lcfty5WJfbLr3UBic/7R2xqhNCK4b1OhpIbq5NNguCFpRgxGrbrMiYh/Y1b8LmhD1qjhS9pL5A9sh5QdOHexBTdJgVEHO5wkJCy407MdKM30+iGL0uSRG16SLpRm22GzMV1Zih2/z41+lPCA4+m/w+wNx6cT8WsDX3NINXx771ktCkrUYsqpkfaTEEanwVX2Tz5AV9vtbD0l/L1dk2UzUurLDsVRcemriXjNBL7QRvIteN56G52I5HXe/2yk+CjwQnBOYz9xBSh92B5Hkl8/
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 15:11:55.0928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81879855-fec7-40b2-d5dc-08defd3b0a5e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5413
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Move the definition of TAMP_FWU_BOOT_IDX_MASK and
TAMP_FWU_BOOT_IDX_OFFSET outside of config check for
CONFIG_STM32MP15X and CONFIG_STM32MP13X.

This patch solves a STM32MP2 compilation issue in
board/st/common/stm32mp_fwu.c when CONFIG_FWU_MULTI_BANK_UPDATE
is activated.

Fixes: 5166658ac605 ("ARM: stm32mp2: Factorize TAMP_FWU_BOOT_IDX_MASK/OFFSET definition")
Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/mach-stm32mp/include/mach/stm32.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
index 42e3735847a..dfbd4f43629 100644
--- a/arch/arm/mach-stm32mp/include/mach/stm32.h
+++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
@@ -67,6 +67,9 @@ enum forced_boot_mode {
 	BOOT_UMS_MMC2 = 0x12,
 };
 
+#define TAMP_FWU_BOOT_IDX_MASK		GENMASK(3, 0)
+#define TAMP_FWU_BOOT_IDX_OFFSET	0
+
 #endif
 
 /*
@@ -135,9 +138,6 @@ enum forced_boot_mode {
 /* TAMP registers */
 #define TAMP_BACKUP_REGISTER(x)		(STM32_TAMP_BASE + 0x100 + 4 * x)
 
-#define TAMP_FWU_BOOT_IDX_MASK		GENMASK(3, 0)
-#define TAMP_FWU_BOOT_IDX_OFFSET	0
-
 #ifdef CONFIG_STM32MP15X
 #define TAMP_BACKUP_MAGIC_NUMBER	TAMP_BACKUP_REGISTER(4)
 #define TAMP_BACKUP_BRANCH_ADDRESS	TAMP_BACKUP_REGISTER(5)

-- 
2.43.0


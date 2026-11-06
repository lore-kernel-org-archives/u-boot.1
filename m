Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCFC606A801
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 11:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=haRwOZKd;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=HQ8VXTRd
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA7E960640;
	Fri,  6 Nov 2026 11:19:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sl7RtfFW_uFQ; Fri,  6 Nov 2026 11:19:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C1F1F607CF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793963947;
	b=q0xdY0DBICf8tM52YH5/TOdnHou8FrtLhdJshdZAJz7TeTaQqIsSzMYE7vSz0Fq/37X9
	 30WRbq1reiqebgteIyb1iw6FvdhBmipvQboTvfzTj9UX6W0zexieHEi3YVF29lM1dDhtF
	 uB5slkSJXvgCbWmWr8dFKod/kn5BGVMaBao2+JjlrmR95avLrNPSBc3BcsJDS/hIIXGu2
	 iZlhyyyHWNXCquN2tpOem8AI4259Q2e3y1Abwt33riQruJw9BR90hhUkk/x/Q2ahHsRWK
	 3Uvgi57/QJQffqGKtw6XbbuOCH3G1RhXNse12t2rZKvlVQuTL3qE8jtlYJSGnuyVzfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793963947;
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
	bh=mhyU8golx+ks4qvQ6rwp1MSrxC3WKyC4LGjmBKrNEM8=;
	b=mAoplxNot2Z9hDnn1A5ccmsHPWb4g8nb9SvGZMBPzTuMJVs+40Lt1OHQSqOFPuBoOwtk
	 00GbEHwyrhHWStAyJ5+RbGnc0foS6fYzvpaR8heI9smKCa/pCqWJxvDKJijN9TA3JrUCJ
	 x4X1aE01azpHnKsiU++ia6WrVFa4JPDiuEaM7BAmQ3L02pKPQsUgUpnbBBxnqx+qJGAxX
	 PyQL6nHKag0TggyFZvlLgxlrHy0zspJgQ73sHJJp5IOsosN+Z1LfZaoGOLqLRWaRNZNGH
	 CI0VeTjtHRGigwqGvn93F0XwyA/hS2cSqL3Pf5CHYaeq5q3Enffka9Z00QutOARHDug==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793963946;
	bh=mhyU8golx+ks4qvQ6rwp1MSrxC3WKyC4LGjmBKrNEM8=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=haRwOZKdIUn3VLwG3/CMpHZQNr9ZM7L8iVGAP+co7FprcyIqSOjnAJu2Rbs4vQ0Gs
	 lvjhBvgPpWveFDg9o1Uo+LOPEFCiRhiQuetOC/t8suEO+C35AoZ9XLYbt2syoqPhar
	 JDmHvzT5TGSoUTm3JIuBerL5d947jT+FqKJifp33gpYf+BYaruB7eka9vmUPfenQFU
	 P3EEuLt+pdc4wuxtGZT0OB4Y3yjoG1/dio/ZpXH68kfwPFx8sV4VP2I5e0hZpbG6KQ
	 qw51hPLjAKQppjHtcm4Cfe2WVlGCApY+0gEbqE/CFP6JU95IzHHbDNdCCmp6KGOzyx
	 NA0Qddl5Xd1JQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1F1F607CF;
	Fri,  6 Nov 2026 11:19:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 871D31E3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 11:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 78554403A9
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 11:19:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s5QCbkGF_kyA for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 11:19:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DAF15400FF
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=HQ8VXTRd
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DAF15400FF
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 11:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhyU8golx+ks4qvQ6rwp1MSrxC3WKyC4LGjmBKrNEM8=;
 b=HQ8VXTRdvnr5KRJxkdG6NBdbMWXVFcFdbfAKizXlZktNGHqNKgeuF7sYGXFb/gPiJMiFGG2QFTmImExnktqV/4fBWUnZlT0Qv2pFj8P0dM6bQJHfDgxX2HHq2icrMu0g24k7QmI5uOzmgdTBfQQmepJH+T4ES5r+HPxuj/pPlWNcleNW1cjgrJP+mLpGPNLhUwYy7fmLj9t8yBQsY3poJgFRc2iFbHogiV+LngS8LIbx/mkGXo2ZX9CHSWrd5qDPdBvd6X9mHdoB8m4ZlpWsart57GjyGHJLP+1JHiM5tURL8Y9EXUIef0k/5nkckVbPkf+VNv6kaKYtbsWYGgNPQQ==
Received: from OL1P279CA0009.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::14)
 by AM0PR10MB618534.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:80b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.5; Fri, 6 Nov 2026
 11:18:53 +0000
Received: from CPH1EPF0000051C.eurprd04.prod.outlook.com (2603:10a6:e10:12::4)
 by OL1P279CA0009.outlook.office365.com (2603:10a6:e10:12::14) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11
 via Frontend Transport; Fri, 6 Nov 2026 11:18:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 CPH1EPF0000051C.mail.protection.outlook.com (10.167.241.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 11:18:53 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 12:19:39 +0100
Received: from localhost (10.252.31.114) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 12:18:52 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 6 Nov 2026 12:18:49 +0100
Subject: [PATCH 1/5] pinctrl: stm32: Support I/O synchronization parameters
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261106-upstream_pinctrl_update-v1-1-4f3d4f6e97fc@foss.st.com>
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
 <patrice.chotard@foss.st.com>, Valentin Caron <valentin.caron@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF0000051C:EE_|AM0PR10MB618534:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3060e5-f41b-4857-4350-08df3bf7bdab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|11063799006|56012099006|261021123027099003|261022075727099003|261021121427099003|261009223027099003|261009221227099003|261102123227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003|3023799007|41080700001;
X-Microsoft-Antispam-Message-Info: KCbKul6baSFoNVKBjTxFPxTeFgRzy5vyKCDP3p4xvam6Xo9F0KYB3r1FW+S+aneD77L6Fh462LNz86rOIUFKnYzVXsAfNuS6o/YipK1+nUxVRzr6dvmiDoy+joy6UuPzlnQGV5LjDDFQl46IfcAFmhTCkPKwTqSGq+ZJ38MKp7nq/xQXMIMIbggmjDK4JLykRgLypzkgivToUceGOx+Fs7yjf3mLCF65AiSVFdGTqAR+x67wX//eYVTjRqQY/5TpDlJikrOCCC3rf4kI3pl5BbWvJtEMaI3uQCFepR86SyUMuzj+mZIk2Im5DL0mZffUUEM74Iin7qMXuayvp/CYovdy3ADWreqPFkjrvYkXgpLhtDLkXDDRQ71FkqO089wRBy2hqWd2gBfra44khfuMhWgf+gYmMQxP2sA/NvuX+PN/S8w/ojYb4NV5Hr4Bd0JW+xKDewVDWeyc/QWxlg/tmmwR2ox5KOj/AL2ueEG9DuvKYPGyYzxU/7v0mfAue83Uu7kKh7swOCBvqRhPyUXWZavI7qd5kqEWQybU4TdfJ2caxYDn1UPCEKPtofxZi/iihyj2fNVu4cMfIdDpCgqWAPiK6sXWl2UehQ67nAD1RuS5E1ozomOIeG68ovJCFDeZvmivq18IM6ilGX9QW0rrUWI3SFXL0lXPstsuoR6b85XabzELKcW4lgTdskiSxKcjh78UarAi2Cye7m3E1YDtNrOagxlXGrgz0SV0ZS3uiWPQaDkw16bcdC0urX0dSJe/tQ6414Yjxc9xxmx4eITENA==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261009221227099003)(261102123227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IGbyPUlIL9cPNmOOIGT4HFFFpkh1gGV0rEQ1HYU8T35ZIRILvKMAYgsDkF8md7AXumPvmErwFWkKvvm5qIwYR4u5AiFQMMGXVBlfkIaoHINT8HZ2EkayF7WhxCC3u3edbi8km5sBfZsJg4y3Pxyo8BuUMd75bjZBv039FyGT4HkY+UbhgDSAbEQCwlV5T5mQgwOBsBU7FnxDCOoJHwbXMXWm1Pt4aeblvyMP583u9Zazw4zRCnMuDVBco2+1JsGNrrq01p6W+Z5ulH2wbEsVuzmwISKpnZLCazS20YpbpQhMkRE6/kB/L0Fju/cSAQDHATlqIgnKbiXk6ZewzZ6dqpZACHZuV5sa4P1hES2ugPhs8dz/SVAoYX1GooMhyI5IPeidAZfQwEu2ER8MoLsTXtauSc97CKTG7AOvlyAqYq1Vb2DFuQyIeY96Om32NOu3
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:18:53.3960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3060e5-f41b-4857-4350-08df3bf7bdab
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF0000051C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB618534
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

From: Antonio Borneo <antonio.borneo@foss.st.com>

Devices in the stm32mp2xx family include an I/O synchronization
block on each pin that is used to fine tune and improve the I/O
timing margins of high speed synchronous interfaces.
It can be configured to provide independently for each pin:
- skew rate on input direction or latch delay on output direction;
- inversion of clock signals or re-sampling of data signals.

Add support for the generic properties:
- skew-delay-input-ps;
- skew-delay-output-ps.

Add support for the property 'st,io-sync' to configure clock
inversion or data re-sampling mode.

Enable it for the stm32mp257 pinctrl driver.

Co-developed-by: Valentin Caron <valentin.caron@foss.st.com>
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
Co-developed-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/gpio/stm32_gpio_priv.h  |  58 +++++++++++++++++--
 drivers/pinctrl/pinctrl_stm32.c | 120 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 158 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/stm32_gpio_priv.h b/drivers/gpio/stm32_gpio_priv.h
index d89e9b8ed60..69868787af0 100644
--- a/drivers/gpio/stm32_gpio_priv.h
+++ b/drivers/gpio/stm32_gpio_priv.h
@@ -51,7 +51,45 @@ enum stm32_gpio_af {
 	STM32_GPIO_AF15
 };
 
+enum stm32_gpio_delay_path {
+	STM32_GPIO_DELAY_PATH_OUT = 0,
+	STM32_GPIO_DELAY_PATH_IN
+};
+
+enum stm32_gpio_clk_edge {
+	STM32_GPIO_CLK_EDGE_SINGLE = 0,
+	STM32_GPIO_CLK_EDGE_DOUBLE
+};
+
+enum stm32_gpio_clk_type {
+	STM32_GPIO_CLK_TYPE_NOT_INVERT = 0,
+	STM32_GPIO_CLK_TYPE_INVERT
+};
+
+enum stm32_gpio_retime {
+	STM32_GPIO_RETIME_DISABLED = 0,
+	STM32_GPIO_RETIME_ENABLED
+};
+
+enum stm32_gpio_delay {
+	STM32_GPIO_DELAY_NONE = 0,
+	STM32_GPIO_DELAY_0_3,
+	STM32_GPIO_DELAY_0_5,
+	STM32_GPIO_DELAY_0_75,
+	STM32_GPIO_DELAY_1_0,
+	STM32_GPIO_DELAY_1_25,
+	STM32_GPIO_DELAY_1_5,
+	STM32_GPIO_DELAY_1_75,
+	STM32_GPIO_DELAY_2_0,
+	STM32_GPIO_DELAY_2_25,
+	STM32_GPIO_DELAY_2_5,
+	STM32_GPIO_DELAY_2_75,
+	STM32_GPIO_DELAY_3_0,
+	STM32_GPIO_DELAY_3_25
+};
+
 #define STM32_GPIO_FLAG_SEC_CTRL	BIT(0)
+#define STM32_GPIO_FLAG_IO_SYNC_CTRL	BIT(1)
 
 struct stm32_gpio_dsc {
 	u8	port;
@@ -59,11 +97,16 @@ struct stm32_gpio_dsc {
 };
 
 struct stm32_gpio_ctl {
-	enum stm32_gpio_mode	mode;
-	enum stm32_gpio_otype	otype;
-	enum stm32_gpio_speed	speed;
-	enum stm32_gpio_pupd	pupd;
-	enum stm32_gpio_af	af;
+	enum stm32_gpio_mode		mode;
+	enum stm32_gpio_otype		otype;
+	enum stm32_gpio_speed		speed;
+	enum stm32_gpio_pupd		pupd;
+	enum stm32_gpio_af		af;
+	enum stm32_gpio_delay_path	delay_path;
+	enum stm32_gpio_clk_edge	clk_edge;
+	enum stm32_gpio_clk_type	clk_type;
+	enum stm32_gpio_retime		retime;
+	enum stm32_gpio_delay		delay;
 };
 
 struct stm32_gpio_regs {
@@ -79,6 +122,11 @@ struct stm32_gpio_regs {
 	u32 brr;	/* GPIO port bit reset */
 	u32 rfu;	/* Reserved */
 	u32 seccfgr;	/* GPIO secure configuration */
+	u32 rfu2;	/* Reserved (privcfgr) */
+	u32 rfu3;	/* Reserved (rcfglock) */
+	u32 rfu4;	/* Reserved */
+	u32 delayr[2];	/* GPIO port delay */
+	u32 advcfgr[2];	/* GPIO port PIO control */
 };
 
 struct stm32_gpio_priv {
diff --git a/drivers/pinctrl/pinctrl_stm32.c b/drivers/pinctrl/pinctrl_stm32.c
index 1758f9a909c..27a50392f74 100644
--- a/drivers/pinctrl/pinctrl_stm32.c
+++ b/drivers/pinctrl/pinctrl_stm32.c
@@ -29,6 +29,14 @@
 #define OTYPE_MSK			1
 #define AFR_MASK			0xF
 #define SECCFG_MSK			1
+#define ADVCFGR_MASK			0xF
+#define DELAYR_MASK			0xF
+#define ADVCFGR_DLYPATH_POS		0
+#define ADVCFGR_DE_POS			1
+#define ADVCFGR_INVCLK_POS		2
+#define ADVCFGR_RET_POS			3
+
+#define DELAYRL_UNITS_PS		250
 
 struct stm32_pinctrl_priv {
 	struct hwspinlock hws;
@@ -43,6 +51,7 @@ struct stm32_gpio_bank {
 
 struct stm32_pinctrl_data {
 	bool secure_control;
+	bool io_sync_control;
 };
 
 #ifndef CONFIG_XPL_BUILD
@@ -304,7 +313,7 @@ static int stm32_gpio_config(ofnode node,
 	struct stm32_gpio_regs *regs = priv->regs;
 	struct stm32_pinctrl_priv *ctrl_priv;
 	int ret;
-	u32 index;
+	u32 index, io_sync, advcfg;
 
 	/* Check access protection */
 	ret = stm32_pinctrl_get_access(desc->dev, desc->offset);
@@ -318,6 +327,14 @@ static int stm32_gpio_config(ofnode node,
 	    ctl->pupd > 2 || ctl->speed > 3)
 		return -EINVAL;
 
+	io_sync = dev_get_driver_data(desc->dev) & STM32_GPIO_FLAG_IO_SYNC_CTRL;
+	if (io_sync && (ctl->delay_path > STM32_GPIO_DELAY_PATH_IN ||
+			ctl->clk_edge > STM32_GPIO_CLK_EDGE_DOUBLE ||
+			ctl->clk_type > STM32_GPIO_CLK_TYPE_INVERT ||
+			ctl->retime > STM32_GPIO_RETIME_ENABLED ||
+			ctl->delay > STM32_GPIO_DELAY_3_25))
+		return -EINVAL;
+
 	ctrl_priv = dev_get_priv(dev_get_parent(desc->dev));
 	ret = hwspinlock_lock_timeout(&ctrl_priv->hws, 10);
 	if (ret == -ETIME) {
@@ -339,6 +356,20 @@ static int stm32_gpio_config(ofnode node,
 	index = desc->offset;
 	clrsetbits_le32(&regs->otyper, OTYPE_MSK << index, ctl->otype << index);
 
+	if (io_sync) {
+		index = (desc->offset & 0x07) * 4;
+		advcfg = (ctl->delay_path << ADVCFGR_DLYPATH_POS) |
+			 (ctl->clk_edge << ADVCFGR_DE_POS) |
+			 (ctl->clk_type << ADVCFGR_INVCLK_POS) |
+			 (ctl->retime << ADVCFGR_RET_POS);
+
+		clrsetbits_le32(&regs->advcfgr[desc->offset >> 3],
+				ADVCFGR_MASK << index, advcfg << index);
+
+		clrsetbits_le32(&regs->delayr[desc->offset >> 3],
+				DELAYR_MASK << index, ctl->delay << index);
+	}
+
 	uc_priv->name[desc->offset] = strdup(ofnode_get_name(node));
 
 	hwspinlock_unlock(&ctrl_priv->hws);
@@ -358,6 +389,9 @@ static int prep_gpio_dsc(struct stm32_gpio_dsc *gpio_dsc, u32 port_pin)
 static int prep_gpio_ctl(struct stm32_gpio_ctl *gpio_ctl, u32 gpio_fn,
 			 ofnode node)
 {
+	const char *s;
+	u32 delay;
+
 	gpio_fn &= 0x00FF;
 	gpio_ctl->af = 0;
 
@@ -391,10 +425,55 @@ static int prep_gpio_ctl(struct stm32_gpio_ctl *gpio_ctl, u32 gpio_fn,
 	else
 		gpio_ctl->pupd = STM32_GPIO_PUPD_NO;
 
+	s = ofnode_read_string(node, "st,io-sync");
+	if (!s || !strcmp(s, "pass-through")) {
+		gpio_ctl->clk_edge = STM32_GPIO_CLK_EDGE_SINGLE;
+		gpio_ctl->clk_type = STM32_GPIO_CLK_TYPE_NOT_INVERT;
+		gpio_ctl->retime = STM32_GPIO_RETIME_DISABLED;
+	} else if (!strcmp(s, "clock inverted")) {
+		gpio_ctl->clk_edge = STM32_GPIO_CLK_EDGE_SINGLE;
+		gpio_ctl->clk_type = STM32_GPIO_CLK_TYPE_INVERT;
+		gpio_ctl->retime = STM32_GPIO_RETIME_DISABLED;
+	} else if (!strcmp(s, "data on rising edge")) {
+		gpio_ctl->clk_edge = STM32_GPIO_CLK_EDGE_SINGLE;
+		gpio_ctl->clk_type = STM32_GPIO_CLK_TYPE_NOT_INVERT;
+		gpio_ctl->retime = STM32_GPIO_RETIME_ENABLED;
+	} else if (!strcmp(s, "data on falling edge")) {
+		gpio_ctl->clk_edge = STM32_GPIO_CLK_EDGE_SINGLE;
+		gpio_ctl->clk_type = STM32_GPIO_CLK_TYPE_INVERT;
+		gpio_ctl->retime = STM32_GPIO_RETIME_ENABLED;
+	} else if (!strcmp(s, "data on both edges")) {
+		gpio_ctl->clk_edge = STM32_GPIO_CLK_EDGE_DOUBLE;
+		gpio_ctl->clk_type = STM32_GPIO_CLK_TYPE_NOT_INVERT;
+		gpio_ctl->retime = STM32_GPIO_RETIME_ENABLED;
+	} else {
+		return -EINVAL;
+	}
+
+	if (!ofnode_read_u32(node, "skew-delay-input-ps", &delay)) {
+		gpio_ctl->delay = delay / DELAYRL_UNITS_PS;
+		gpio_ctl->delay_path = STM32_GPIO_DELAY_PATH_IN;
+	} else if (!ofnode_read_u32(node, "skew-delay-output-ps", &delay)) {
+		gpio_ctl->delay = delay / DELAYRL_UNITS_PS;
+		gpio_ctl->delay_path = STM32_GPIO_DELAY_PATH_OUT;
+	} else {
+		gpio_ctl->delay = STM32_GPIO_DELAY_NONE;
+		gpio_ctl->delay_path = STM32_GPIO_DELAY_PATH_OUT;
+	}
+
 	log_debug("gpio fn= %d, slew-rate= %x, op type= %x, pull-upd is = %x\n",
 		  gpio_fn, gpio_ctl->speed, gpio_ctl->otype,
 		  gpio_ctl->pupd);
 
+	if (gpio_ctl->retime || gpio_ctl->clk_type || gpio_ctl->clk_edge || gpio_ctl->delay_path ||
+	    gpio_ctl->delay)
+		log_debug("	Retime:%d InvClk:%d DblEdge:%d DelayIn:%d\n",
+			  gpio_ctl->retime, gpio_ctl->clk_type, gpio_ctl->clk_edge,
+			  gpio_ctl->delay_path);
+	if (gpio_ctl->delay)
+		log_debug("	Delay: %d (%d ps)\n", gpio_ctl->delay,
+			  gpio_ctl->delay * DELAYRL_UNITS_PS);
+
 	return 0;
 }
 
@@ -428,7 +507,9 @@ static int stm32_pinctrl_config(ofnode node)
 
 			log_debug("pinmux = %x\n", *(pin_mux + i));
 			prep_gpio_dsc(&gpio_dsc, *(pin_mux + i));
-			prep_gpio_ctl(&gpio_ctl, *(pin_mux + i), subnode);
+			rv = prep_gpio_ctl(&gpio_ctl, *(pin_mux + i), subnode);
+			if (rv)
+				return rv;
 			rv = uclass_get_device_by_seq(UCLASS_GPIO,
 						      gpio_dsc.port,
 						      &desc.dev);
@@ -466,7 +547,9 @@ static int stm32_pinctrl_bind(struct udevice *dev)
 		return -EINVAL;
 	}
 	if (drv_data->secure_control)
-		gpio_data = STM32_GPIO_FLAG_SEC_CTRL;
+		gpio_data |= STM32_GPIO_FLAG_SEC_CTRL;
+	if (drv_data->io_sync_control)
+		gpio_data |= STM32_GPIO_FLAG_IO_SYNC_CTRL;
 
 	dev_for_each_subnode(node, dev) {
 		dev_dbg(dev, "bind %s\n", ofnode_get_name(node));
@@ -546,25 +629,32 @@ static struct pinctrl_ops stm32_pinctrl_ops = {
 #endif
 };
 
-static const struct stm32_pinctrl_data stm32_pinctrl_no_sec = {
+static const struct stm32_pinctrl_data stm32_pinctrl_base = {
 	.secure_control = false,
+	.io_sync_control = false,
+};
+
+static const struct stm32_pinctrl_data stm32_pinctrl_sec = {
+	.secure_control = true,
+	.io_sync_control = false,
 };
 
-static const struct stm32_pinctrl_data stm32_pinctrl_with_sec = {
+static const struct stm32_pinctrl_data stm32_pinctrl_sec_iosync = {
 	.secure_control = true,
+	.io_sync_control = true,
 };
 
 static const struct udevice_id stm32_pinctrl_ids[] = {
-	{ .compatible = "st,stm32f429-pinctrl",    .data = (ulong)&stm32_pinctrl_no_sec },
-	{ .compatible = "st,stm32f469-pinctrl",    .data = (ulong)&stm32_pinctrl_no_sec },
-	{ .compatible = "st,stm32f746-pinctrl",    .data = (ulong)&stm32_pinctrl_no_sec },
-	{ .compatible = "st,stm32f769-pinctrl",    .data = (ulong)&stm32_pinctrl_no_sec },
-	{ .compatible = "st,stm32h743-pinctrl",    .data = (ulong)&stm32_pinctrl_no_sec },
-	{ .compatible = "st,stm32mp157-pinctrl",   .data = (ulong)&stm32_pinctrl_no_sec },
-	{ .compatible = "st,stm32mp157-z-pinctrl", .data = (ulong)&stm32_pinctrl_no_sec },
-	{ .compatible = "st,stm32mp135-pinctrl",   .data = (ulong)&stm32_pinctrl_with_sec },
-	{ .compatible = "st,stm32mp257-pinctrl",   .data = (ulong)&stm32_pinctrl_with_sec },
-	{ .compatible = "st,stm32mp257-z-pinctrl", .data = (ulong)&stm32_pinctrl_with_sec },
+	{ .compatible = "st,stm32f429-pinctrl",    .data = (ulong)&stm32_pinctrl_base },
+	{ .compatible = "st,stm32f469-pinctrl",    .data = (ulong)&stm32_pinctrl_base },
+	{ .compatible = "st,stm32f746-pinctrl",    .data = (ulong)&stm32_pinctrl_base },
+	{ .compatible = "st,stm32f769-pinctrl",    .data = (ulong)&stm32_pinctrl_base },
+	{ .compatible = "st,stm32h743-pinctrl",    .data = (ulong)&stm32_pinctrl_base },
+	{ .compatible = "st,stm32mp157-pinctrl",   .data = (ulong)&stm32_pinctrl_base },
+	{ .compatible = "st,stm32mp157-z-pinctrl", .data = (ulong)&stm32_pinctrl_base },
+	{ .compatible = "st,stm32mp135-pinctrl",   .data = (ulong)&stm32_pinctrl_sec },
+	{ .compatible = "st,stm32mp257-pinctrl",   .data = (ulong)&stm32_pinctrl_sec_iosync },
+	{ .compatible = "st,stm32mp257-z-pinctrl", .data = (ulong)&stm32_pinctrl_sec_iosync },
 	{ }
 };
 

-- 
2.43.0


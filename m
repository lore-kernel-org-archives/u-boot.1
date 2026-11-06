Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF31B606A806
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kyMaiNJe;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=EWrI5+ou
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3955608AD;
	Fri,  6 Nov 2026 11:19:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 37DUltxTTlfo; Fri,  6 Nov 2026 11:19:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CC2A9608A0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793963954;
	b=X6KSGINqQzoSEbC55S0Vd/U0WCISKFbx/x5xhgGLnE5w1gud/1e54QjeePpdBNvUruh0
	 nTUHL4Gb/B+mzDSvt4VAywbAaU1rb+FbJk//885L6w3bmdAgYrizbyDAGhwzmQO5NbKik
	 dk0gaW7X0ARCW0LdDiZZb2S8zvm/x8kItq6Y02HRjxc0j1IDpbK0GomDyE0TfW5HheIto
	 9y63sqQ+OcBagBGk2Ymu3YBr8mAYaP1so5NKvOvuEfXS3eDU56fgj6oK7IsosVCpaD72l
	 hvItDK9uO+ym9tefjHspWhkJ9+pfGkxap9Vrr5iapzUKX8gb7/IqrU/zMGbQdBeTCzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793963954;
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
	bh=YnOZVOmDI4UB8GGkmBSkni5cgfozaCsm2Egat2TK1Fw=;
	b=qFDY+JVucucKKHT9TdpBo7meqkPIQa48hhhLItg8kd0Nvt84rPgAO3g+0RqCPT37BA1N
	 aYu2VHZqdHiAIC3BuwQsZVPrSvBvPDbp14vUq+YeBIhGH7zFPn9hYV2Qs8/HPGVLLcqWE
	 zVhZHeStpazrP85/bmxipNudZa3rcJ+mCq3Il0pVbNOPLss9H+s+zTuOGkOb1mDXit1Kc
	 Aoy55uc5CP3D5zhuxSNsZJnSAJw5+TS7FYnv7y/P/gyefAEk9rs5Rht11888CctbDpRoM
	 HjZd1bt8XupAS8BDuc/us+xiAklwm3JRQVwncmdNjoL7f8Y4044pM6xRtNbO2shxrDA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793963954;
	bh=YnOZVOmDI4UB8GGkmBSkni5cgfozaCsm2Egat2TK1Fw=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kyMaiNJeLZ0VVi78ELK3jHyzI9vbvCyc1RP7SmC8QSIuKohPAcon0SrA9SYVJrz2H
	 CBsiXEDeCsFlJHy6pvfKN7FZAVw6e+MDEV4RnYsrndfOVKVSilXrE8/X0STD2KiakQ
	 jQjYmJRtGEpFbgDn29tgYt0VEArjKsHFVnpHuxL4PnoI1Tm1SFeG3TMmwMiRUvuTmv
	 cjTEF8zPJNktkpuNzSB6Qq5qzIHWEdfsqjpHh0eUW5rX8GICKf2SH3givZdaDsAzoX
	 scr1JMUJjr2PnJqxUoWWniGzvzPaO+veZd+ttjSP1uE/XNFmFkz8z37OMJqfZcPJl8
	 DSPyDBRU/3Slg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC2A9608A0;
	Fri,  6 Nov 2026 11:19:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BABF362
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 11:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 79F2340988
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 11:19:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CXgpKBDaSTFD for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 11:19:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6AE7E40985
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=EWrI5+ou
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6AE7E40985
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 11:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnOZVOmDI4UB8GGkmBSkni5cgfozaCsm2Egat2TK1Fw=;
 b=EWrI5+ou1gD0dk0bta/bZPTOtkgRKF061NyW5ZdnbW6FvpXGtiAI51ix6Gb+yaksEaHs+EQZB2prBFq6/XlJt8PfZh5vZBy+81O8K5qxMtTY6w89nV2Vii/hOjB9m1uebj/+pba5Hy/cRtUpOOBjYdoKsH/XRmGRzdkFxx73XQBzQPsYzzg5/IPbmtRb/FAa0Oxtq+FdIN8JuZG0EYtbUCDibLLLlFSu94SfbAUAMSxdwQ+ckcyC2vJkupfv6HQL2JdQeorAJHJTpdp8J8eagvRhH/47GiqaXR599vOZnJt1XlWyJjhI8pUaGapEXHzKazSdOJUyjCOBErNgwZ9CzQ==
Received: from ZR0P278CA0140.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:40::19)
 by VE1PR10MB3789.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 11:18:56 +0000
Received: from ZR1PEPF0000E6B8.eurprd07.prod.outlook.com
 (2603:10a6:910:40:cafe::87) by ZR0P278CA0140.outlook.office365.com
 (2603:10a6:910:40::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 11:18:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 ZR1PEPF0000E6B8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 11:18:56 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 12:19:26 +0100
Received: from localhost (10.252.31.114) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 12:18:55 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 6 Nov 2026 12:18:53 +0100
Subject: [PATCH 5/5] gpio: stm32_gpio: release RIF semaphores before OS
 boot
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261106-upstream_pinctrl_update-v1-5-4f3d4f6e97fc@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6B8:EE_|VE1PR10MB3789:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f8f7dae-fefc-4fbb-d65d-08df3bf7bf87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|10067099003|22082099003|18002099003|3023799007|56012099006|11063799006|261021121427099003|261009223027099003|261102123227099003|261021123027099003|261022075727099003|41080700001;
X-Microsoft-Antispam-Message-Info: Qk1ES9n59D0I4g+gpuKJ61pgoe/pKj7WFboVY9qKXaBSLWIUCuHTK0csd31DLWzIwwWCmLYvLvdFDNIBmJgokvXLO/i5r/1jtQM9pTDrmK/+hQ6AlG+dPXawPau5jSxrWfWdfCOKQCro0ceX12Dw1Znzff1SPzshlUaj5cpM4STjmLHdQrkocavMCskw8SeWvJhPH8rGKurCdWB6DJYA9bNbTwi9V8P6loO8lhcnXwGHB5KOz0JcNPFhj87Nt5gDTFno0TNoKTA4sW8XjvDQsA1ajyI8WZlVYHPrKQOwLYr7ofInISPcDqUoGNI5n/tVHincVX6MTpBpGlOMaaj9HxBSrdrKayFfRxSufQskHlzkgk8lIg40zBLfVzDFYQ5JC/ga6YRkOYCUfnxNTXTsQrLaCJ4kXHzRt92bx8JIP3RnKLE39KvHzP1SWHyx0SPfgHRT+8+OW/0HPs+O+vPLjUkHAt1uV2aII/bpdHrEwJ8rqOJNkq1Fj5QS6N+2zdcKXvZQGa7hIxEpTFAq0XHRDLM5xy6HeAr95MBEEgIuhdm9jm/5AuCb+oHIBZW22OK/RTKUu+bSuYW6F2mdnWvxX8jA4GwGQnxEvdTL0T1gOAGwQRSGbmYc0idsAe6dhPKBPm07R/9qoNcCUy4CBqCO6gMVann7Vps5Lr/3iBiMWCdFLwgTUjgF+Zk4JfbROSXkuliLWeCUQptPfOQmk4QPEd1JUWod+nDPi0vi83gk+V3fPBZf79/hd9C2ox1dcKqs12Ep2e/XcEMK0N0uNZDA0g==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(261021121427099003)(261009223027099003)(261102123227099003)(261021123027099003)(261022075727099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VPUUVDg1IWmDNHVhFS2qLQ/TN6BG7wrpeifyrmN2VrEjgoENzMdrir7wCwsebyVfp0qzKvJEw+LSqaP5nox4Jgijc1jN+E2KGHfgdDNfhrq61NN2RNP/eOwD8AIgbi05XMje1IQ+9K3qCbwbHBGM1+b9SKDsRL5/LgXwiUwCrHaruDl6B0rU+iRT+YWdaL5/YYf37rV2hDK4n4Y0SwwdxuyytrVJhpkcqftqv3hSVfAyFyDU1rK8uw8Qk+fYwa+w+w2UPXyba7QW/1ovm+Q5Sx/sK2BcJIfhuh5rHEuFPHlHEz4XbpAuOl2GKRPTgEATpaXabH6m3nzIOLbtcz/pxBmqEvKALeKTwPyAY4bYU+/0pl+6AnTJiO6BJMkR4+DZsK6FHCTBeT8fZFQpB4UfeS8iWBn2p7YXrwlqlINn/hVP39LP2rUVoYs7Uj3ofICU
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:18:56.5914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8f7dae-fefc-4fbb-d65d-08df3bf7bf87
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6B8.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3789
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
by its own.
The RIF semaphore can be acquired either with 'gpio' command or
through the pinctrl's set-state.

The OS in the following boot stage could require to allocate a shared
GPIO to another CPU, thus the semaphores should be released before
the OS boot.

For the 'gpio' command, release the semaphore when the GPIO is
released.
For pinctrl, release all the acquired semaphores during OS prepare.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/gpio/stm32_gpio.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/stm32_gpio.c b/drivers/gpio/stm32_gpio.c
index d94cea7fdbc..aa933aa3716 100644
--- a/drivers/gpio/stm32_gpio.c
+++ b/drivers/gpio/stm32_gpio.c
@@ -140,6 +140,19 @@ bool stm32_gpio_rif_valid(struct stm32_gpio_regs *regs, unsigned int offset)
 	return false;
 }
 
+static void stm32_gpio_rif_release(struct stm32_gpio_regs *regs, unsigned int offset)
+{
+	u32 cid;
+
+	cid = readl(&regs->rif[offset].cidcfgr);
+
+	if (!(cid & STM32_GPIO_CIDCFGR_CFEN))
+		return;
+
+	if (cid & STM32_GPIO_CIDCFGR_SEMEN && cid & STM32_GPIO_CIDCFGR_SEMWL_CID1)
+		writel(0, &regs->rif[offset].semcr);
+}
+
 static int stm32_gpio_request(struct udevice *dev, unsigned int offset, const char *label)
 {
 	struct stm32_gpio_priv *priv = dev_get_priv(dev);
@@ -169,6 +182,18 @@ static int stm32_gpio_request(struct udevice *dev, unsigned int offset, const ch
 	return 0;
 }
 
+static int stm32_gpio_rfree(struct udevice *dev, unsigned int offset)
+{
+	struct stm32_gpio_priv *priv = dev_get_priv(dev);
+	struct stm32_gpio_regs *regs = priv->regs;
+	ulong drv_data = dev_get_driver_data(dev);
+
+	if (drv_data & STM32_GPIO_FLAG_RIF_CTRL)
+		stm32_gpio_rif_release(regs, offset);
+
+	return 0;
+}
+
 static int stm32_gpio_direction_input(struct udevice *dev, unsigned offset)
 {
 	struct stm32_gpio_priv *priv = dev_get_priv(dev);
@@ -330,6 +355,7 @@ static int stm32_gpio_get_flags(struct udevice *dev, unsigned int offset,
 
 static const struct dm_gpio_ops gpio_stm32_ops = {
 	.request		= stm32_gpio_request,
+	.rfree			= stm32_gpio_rfree,
 	.direction_input	= stm32_gpio_direction_input,
 	.direction_output	= stm32_gpio_direction_output,
 	.get_value		= stm32_gpio_get_value,
@@ -400,11 +426,39 @@ static int gpio_stm32_probe(struct udevice *dev)
 	return 0;
 }
 
+static int gpio_stm32_remove(struct udevice *dev)
+{
+	struct stm32_gpio_priv *priv = dev_get_priv(dev);
+	struct stm32_gpio_regs *regs = priv->regs;
+	ulong drv_data = dev_get_driver_data(dev);
+	unsigned int offset;
+	u32 seccfgr = 0;
+
+	if (!(drv_data & STM32_GPIO_FLAG_RIF_CTRL))
+		return 0;
+
+	if (drv_data & STM32_GPIO_FLAG_SEC_CTRL)
+		seccfgr = readl(&regs->seccfgr);
+
+	for (offset = 0; offset < STM32_GPIOS_PER_BANK; offset++) {
+		if (!stm32_gpio_is_mapped(dev, offset))
+			continue;
+
+		if ((seccfgr >> SECCFG_BITS(offset)) & SECCFG_MSK)
+			continue;
+
+		stm32_gpio_rif_release(regs, offset);
+	}
+
+	return 0;
+}
+
 U_BOOT_DRIVER(gpio_stm32) = {
 	.name	= "gpio_stm32",
 	.id	= UCLASS_GPIO,
 	.probe	= gpio_stm32_probe,
+	.remove	= gpio_stm32_remove,
 	.ops	= &gpio_stm32_ops,
-	.flags	= DM_UC_FLAG_SEQ_ALIAS,
+	.flags	= DM_UC_FLAG_SEQ_ALIAS | DM_FLAG_OS_PREPARE,
 	.priv_auto	= sizeof(struct stm32_gpio_priv),
 };

-- 
2.43.0


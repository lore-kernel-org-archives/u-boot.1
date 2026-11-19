Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1460A606A324
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M7zrVr+O;
	dkim=pass (2048-bit key, unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=EIh476Z/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BAAE81444;
	Thu, 19 Nov 2026 15:54:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Txb515GzQWdJ; Thu, 19 Nov 2026 15:54:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 83EDA81401
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795103672;
	b=oOy3d8fijfgWn9Bj4fI2w1VI2QZTos/aFezgVR2OBQH09YTFpBPYpca77lBzjmTXDkoI
	 x8nhFYH5oUYgl8t1Hv2DGC/yaM9QYvvM04R07I62M4vUsMOtkLWF7XyHsz0kwAstpKwKn
	 mxCY/Gt+dIVInG3NZ9A+V0cdNKpvH7vfEsMcrBa2W+tcwB5tEe9kOo/EDY81LmYCFZk5N
	 dcizpcxbOwX+dBgSmrQ1I5QhJ5PNChano1gvOAX19h/tK2XnpfLKGyHWrlPLPcYoJLy0q
	 9Lu6u7TF9KAHrr02tMXF5gXuIObVClrkfQcdDwgxO8CMyaV6pWL6phb+4u0FNVE0OiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795103672;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Originating-IP:X-ClientProxiedBy:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3+7A5D83iS7YAnHhcq/sIaz9NTnD93aQrP+xi25dc3Q=;
	b=ihrnZpG0tadV8hRcEVBhshLZ17/fJXVbzXi4cHttja/WOKm0yKCXRWEf4zkJqwqZk4S1
	 z1VtAwXyMuF/Vh+ydd+KcTu0rqC3Qs0ZmNvbNnI3+URCS1YUuILVpTQdc6wGgi9YPQgWq
	 3DFMTSvslc7KtT1Zkbq4i/TB/v9C1/pIcs6l1VmiLWw/CSOe9VEsvzR6BRqesTlouzlpM
	 TRhgU19TF+bS5x36dY3Y1pXsLxzwtoEOfr+JbJrFs8cJ74JjaXfUUoa2XoN65p2Zy+3+f
	 B0wfis3AfqZrG8QxhR9gSqMhLL0T6GeJqsWANlngEcPJY6yyC3wKSdDPUAEpAzoyslg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795103672;
	bh=3+7A5D83iS7YAnHhcq/sIaz9NTnD93aQrP+xi25dc3Q=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M7zrVr+OrKIF4y5uiENbP7xJPUHAcSXIQHbjTg/2F1sUiXQc2zTYJhB1Uq6QOhkjO
	 niMA7e1vxtEMhDiTeylvlN8AGCtNgn3dCUUzIgDIK2JkzLTdr3kFz8HbdjuWUQwB/p
	 xgKpZI3VVd/r2g+dlOyAslcB0WwGongd9+EEeEa+dEsJ3Q1qec9bhz3kr8qYOihQUT
	 WEreZLY2eRiqoxjMO3XgkS2EBAyW91cT16hFCDempBAkOmgwug1e+9WD71rNCOhNgF
	 s631PP27/hpjrevtJtbxiOTq1ythPh8Fxn5M59kCGHvyUQtGZbNTD2ChMgiZ5o81Ve
	 j8U97leeGC0Uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83EDA81401;
	Thu, 19 Nov 2026 15:54:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 062FC1C9
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:12:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E0C6E40B12
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:12:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id INja_yREblJT for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 14:12:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A2C5640AF6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=t.schmelzer@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=EIh476Z/
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2C5640AF6
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+7A5D83iS7YAnHhcq/sIaz9NTnD93aQrP+xi25dc3Q=;
 b=EIh476Z/0frX7sH2c536U5TnTA3fIH5T3EBn9dFJYIbpSlXPsvbAmR2EiwidCyUT8wLVnsouO8piezSnszqKB9ikfRQL5TChFIllmWQnpShz2LL86mmhq28BtAY4k0ao3aInQoLpiaVPSYr6vDb/zJx6JRJGjmu9XGUzuXnh5BmPsaLKGCsbLDdO1YNXUx7xF5+TXNZU/BW6p3/HiJs6XvkzM90DAHX/TIwFtOG2WOgh8Di1pLv7C9bt7T7h6i+ADxShQIwbaODC52ypXGn5uPjeg7BcNS87jUYosBzSvnNFBJNWpV+wv4ytCR6Q4NRQ2uW1yQNfh80w3pP3e4Do3g==
Received: from PAYP264CA0028.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::15)
 by PA1PPFDD06E87E6.EURP195.PROD.OUTLOOK.COM (2603:10a6:108:1::1e6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 14:12:33 +0000
Received: from MI3PEPF0000855A.eurprd05.prod.outlook.com
 (2603:10a6:102:11f:cafe::ad) by PAYP264CA0028.outlook.office365.com
 (2603:10a6:102:11f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 14:12:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 91.26.50.189) smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: Fail (protection.outlook.com: domain of phytec.de does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Postix.phytec.de;
Received: from Postix.phytec.de (91.26.50.189) by
 MI3PEPF0000855A.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 14:12:33 +0000
Received: from [127.0.1.1] (172.25.32.137) by Postix.phytec.de (172.25.0.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 19 Nov
 2026 15:12:31 +0100
From: Thorsten Schmelzer <t.schmelzer@phytec.de>
Date: Thu, 19 Nov 2026 15:12:14 +0100
Subject: [PATCH 2/4] configs: phycore-imx8mm: Add support for loading via
 UUU tool
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-2-dd6db9e5edfd@phytec.de>
References: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-0-dd6db9e5edfd@phytec.de>
In-Reply-To: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-0-dd6db9e5edfd@phytec.de>
To: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, <upstream@lists.phytec.de>,
 <u-boot@lists.u-boot-project.org>
CC: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Peng Fan <peng.fan@nxp.com>, Yannic Moog
 <y.moog@phytec.de>, Benedikt Spranger <b.spranger@linutronix.de>, INgo Rah
 <ingo.rah@linutronix.de>, Thorsten Schmelzer <t.schmelzer@phytec.de>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000855A:EE_|PA1PPFDD06E87E6:EE_
X-MS-Office365-Filtering-Correlation-Id: fd107d4f-1bb4-4b2f-0444-08df464727cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|42112799006|36860700016|376014|7416014|23010399003|1800799024|18002099003|22082099003|6133799003|261009223027099003|3023799007|11063799006|56012099006|261102123227099003|261026121527099003|261022115727099003|261021123027099003|261021121427099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: 02NTCKFq+DthC7KbNEDf/4XVMls/+SFfUk1r7MA/NQ/gfMfuKygI6PfXJr34LxbNAjSYS63dXWmG/Vw5doGbuDJJco6mBTZRhfE2vG7iOpMG6xQ5M6IqeBEfqF6eat9ndofGL2ZEJIuz7LD1mwYycItwF43vYSvOrrVRmM9pxqvd6gghROpmU+m18i3r6xGR3VpOBzcxNXP9Gw6KfgjCl4vQggt/3Vq0sYCRLpWrmNriHAPV+Z/dY0fUmf7Epg8LAjXOFVB+uXpLi1ECPmZKjyBg6iPYKlHbB0f8UrDXXX5FdEKAUmb2vkPDuiU4ZyWFObd4FxsrhaZYXCKLNYiXOpBi3c0zRiPDk+tI5chmTasdWSG2yQYakeLWqlCBMv4BgaynjoaSvm64DC63htVRQUqSFuDWXFcshh6+wHoxvmtD1f5/wQ/htMlPtQ3MeKIZb1BCMXA8MdaH2j7ujW9OGxyCsgP09RHIknObGr2apDoPoadtRarBlpUhY9KPo8Mp7a0NB9AAr+MOaTuEbRHLICNjC18pRt/jt0Lye/9xWxCcfSab/xafB0cL2KmuqP6fawQ23M7UlMVgLKGaAQI5QKUyLbkilIUWzCYip502ZiH+TbGIYx9pRVzi1q1ArCKHX0huGX3Gq983Sf3Rp+2ClBJr9xni8kxtnUqLfk6u+d7A6AaUsf5ik2A4NvdiEqtn
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(42112799006)(36860700016)(376014)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261022115727099003)(261021123027099003)(261021121427099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kwJCjYM5bTUMZHFIa/UOgzCRQUR2s/KHhtXYGGdogvqQJnpu5JXeBGAtQ/+XRnlxKGyYmWpG0Vul4Ydgi8LJJeTnwziu+d7ybgsQ3tHmubMmSjBamnYyqTJQPSfCh0rLhLIZjWgeGfDUuuNlUQg9pMY+KpeoulcEFm9naewbwjFER/5irrOs5luO8iGL9fYY78hsGoyR2IQH6JOCVX/mDDqMWYGUwi+gZBQ1UlQghX7G4Ci/WUqU+f0j0Yn1A9Vq8s64v7cVL+OWHKvfzFiXVbsYQ22LjAIuIhHuXXncqjaEfxbrsL1k3kcZMZJUlP5mKPLGoBuK6H0rkXwAAJGed4nYX48RW0OCJMgX+ts/ALwTu2iHMhnktvp0L//xdC1xyQeQH1OCeDMjnSElMAK0Dv/Ia1DqDJ3LdyzWgBVC74WsvTRUqzO7LuY8qWs9mLLh
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 14:12:33.3884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd107d4f-1bb4-4b2f-0444-08df464727cf
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000855A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PPFDD06E87E6
X-Mailman-Approved-At: Thu, 19 Nov 2026 15:54:27 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable all options, which are required to load and run u-boot through
the USB serial download mode and to do basic flash operations with the
NXP UUU tool. This includes:

- generic USB support for imx8mm
- USB gadget support including gadget configuration
- SDP protocol support
- fastboot support including fastboot configuration
- fastboot UUU support

Signed-off-by: Thorsten Schmelzer <t.schmelzer@phytec.de>
---
 configs/phycore-imx8mm_defconfig | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index 2be57246addd..7d4f6005dbaa 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -29,6 +29,7 @@ CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x3E0000
 CONFIG_PCI=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
@@ -58,6 +59,7 @@ CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_SYS_EEPROM_SIZE=4096
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
+# CONFIG_CMD_BIND is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
@@ -65,6 +67,9 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_SDP=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
@@ -82,6 +87,17 @@ CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MM=y
 CONFIG_FSL_CAAM=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x44200000
+CONFIG_FASTBOOT_BUF_SIZE=0x13000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=2
+CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
+CONFIG_FASTBOOT_MMC_BOOT1_NAME="mmc2boot0"
+CONFIG_FASTBOOT_MMC_BOOT2_NAME="mmc2boot1"
+CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
+CONFIG_FASTBOOT_MMC_USER_NAME="mmc2"
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_I2C_EEPROM=y
@@ -131,4 +147,16 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
+CONFIG_USB=y
+CONFIG_SPL_USB_HOST=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_MXC_USB_OTG_HACTIVE=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_CI_UDC=y
+CONFIG_SDP_LOADADDR=0x40400000
+CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_IMX_WATCHDOG=y

-- 
2.53.0


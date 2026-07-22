Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709EFC44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 10:58:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C33040889;
	Wed, 22 Jul 2026 10:58:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qUissoeTtBiq; Wed, 22 Jul 2026 10:58:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D8A8940909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784717916;
	bh=/204/JTEjD7OCDFTBwd/bq6qV2JZanEcg45eChn2h9o=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QXhy0X8LubuOiAtWP6bcgdC6x4BCzcaSF23blbxPSqVXTzYBxcO+OAEUf3WYE8hgt
	 4Ujc/TcDF/obqQNwn9y6JrNOTV6QCL6W5fAYP8HZXYPUTF6v/4PG7b+YpCb0z98rR6
	 WCbAm6qsD1A77tJ5NPlLs9qFeLMR8uVQSA3AxtwnlKODrURKggTbQTna5ivS0aVknG
	 5Pna2EqoiS4lvoEqIEl6rLN+u0YVdbZ+58s8myQexsAovelvTH4PwNAM5kBc2Z87t4
	 itTGjV0JK9qNdLaHvesB1Xufec5g4RYVtZXdZWHePeC6yiji+12Tv4JNG2JSyGh0ZS
	 EJjom8RloDMrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8A8940909;
	Wed, 22 Jul 2026 10:58:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 490AF1099
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:58:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F200607D4
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:58:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AHxftnAusKF0 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 10:58:27 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 320F6607D9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 320F6607D9
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 320F6607D9
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:58:27 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A640C846A4; Wed, 22 Jul 2026 12:58:25 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 065B28495B
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 12:58:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqLofjaS35alBLdUFzBWHq5VkvUkxg/zHn9gixt79Oa1xmAeZnUbeSQZyy2ojU6UJFXpyUxrU2rIbXUqH+/dYlipRB7rpebgCdnxT6PvLy3BRgO2Hz3etMun5W1Xms/VBAsxQ1lxeSLabBly2QpnyrX5aRKzyiam1yUZFx0mrYcdOAhSGtIP1uBTP1Vi3KAIctbbDLloRxDUVXpVyXrRq02U+8siPy/vkyaMA8JTC8BhmczRYrlDgivnAxW/RAv2238rNSF4dy62/S5egBFU64jUv5HXTDiGcwnp8pTtZzFBOCJNm4rHRUrZGFhy8xn4TGUp61Aex+Vb/ssIFTu3Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/204/JTEjD7OCDFTBwd/bq6qV2JZanEcg45eChn2h9o=;
 b=yGa4R/ciLqYhmtfHIDJ8KjLw4beKgJno+jhsOxkgbN8u/kdv5qAzsK2qQBQfDcAKiLbwVfn5uLiKTMejM0OFTiqEgeaTfavYM1ihgUcHXLv6ySVLkT4YDhO6g/yPlmQean7HV3DptNIzz4mdNTpdokX4eI/ESkVzoRNqMcdNzjZcH0GrIQPcRXYCrSG17aGgnxOzOjmIEMMFXQkHT5rIUbBYmBg50yMIAqYkz+ouMltmJwg/+4RMiLAMUe3HTzACvLjLNxeS/afrXi055eDfbe2oKl2oB6maveiO3N186bswkpMJ8wv0r1VDuGeB6tlrmPd0UVP9wO4JtjhyWaQ79g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.84) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
Received: from DUZPR01CA0183.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::21) by AS4PR07MB8460.eurprd07.prod.outlook.com
 (2603:10a6:20b:4e7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.4; Wed, 22 Jul
 2026 10:58:19 +0000
Received: from DU2PEPF00028D08.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::54) by DUZPR01CA0183.outlook.office365.com
 (2603:10a6:10:4b3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 10:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.84)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.84; helo=fihe01smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe01smtplvp01.emea.nsn-net.net (131.228.2.84) by
 DU2PEPF00028D08.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Wed, 22 Jul 2026 10:58:19 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe01smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id A780780000B0;
 Wed, 22 Jul 2026 13:58:18 +0300 (EEST)
Date: Wed, 22 Jul 2026 13:58:00 +0300
Subject: [PATCH v2 2/5] watchdog: sbsa_gwdt: set max_timeout_ms in probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-rinta-watchdog-gettime-v2-2-39e249500543@nokia.com>
References: <20260722-rinta-watchdog-gettime-v2-0-39e249500543@nokia.com>
In-Reply-To: <20260722-rinta-watchdog-gettime-v2-0-39e249500543@nokia.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784717898; l=1491;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=MiQR1BcXEMxEWPGMm+IPaPg5u6pcXZUmfwpGolvxcww=;
 b=S2cuAIAQSpesG5l0Y0stPKtnR/RBtSlCfPpUl8eKKcXLs3dDwG2DvpVGnkpL4FZzQm5yAZbQ0
 qQVvZ2zAdjbB9mH/qlw5zUOIfcesy2AsU1EFu/koiHst/jIIKt8VQjw
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D08:EE_|AS4PR07MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f52587-89cd-4894-73bf-08dee7e023ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3daoTIoPQQcwIu944eiZ5oXci/v+xb2YSSQYeXrNGzjiStyhdmOPgYIUclVHcIDP+OryefAXdRatpwA/uVCaF1tHq3cxjXqLMwISiFArcZqqCwQGhZ1SgXx/7tUT1SptVM51JYjnaLbhOVgJGs9pJCRZY1r1E4qKUhABQ+FdYqG27HL5mzW/lPA2Phw3D6qeHUnsFAYK/PSs3EXktwkmRNv7c/Uk7cQhLX1K3oREpIwynJrju9FfuT8TxpYuLuZ0cMLL8P+0Otz8R39KDzx/iMv8Pu1pCN/fK5ed/gNT5brjNP14XrZ/HaZZPJ5AUXBK32bwcvvOxrLki6gCjribipItCpWSHdyBoQQ6jxBZI7p3KxHEFOyK536/vm0yjUdNV6bGRAtLkdkmwbn9weAwzJDKEAlufL00z2ljUU6DC2qGWdqKeTOfv0o7OTgHwEFax4503c8+Lz+2/CfbZ4U35sKYMzFrB01dRKpbE2kZaH9Mk7h8A0H1oocUVc7rO6zlYgQT57sBrStkS1Mmr3xMfGWrXy+o4SEuXEK6frriA/tewLhMe36dmMdekjM03uilrcvvO1K3LuQzSRpX1fCoTm3jTFko96oXkFEGEoMw8mb304BONuhsPtTEf0RzVaVBoOFMU2iQSkfWa0L8Lvu/D57wdDqRlhoWdqkOfnzkVW7FZRfztG+2SrkSHspjt1BlGPjqW3v2cWbxq0QBq9Ywyw==
X-Forefront-Antispam-Report: CIP:131.228.2.84; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe01smtplvp01.emea.nsn-net.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oiOTrVLXIclG09jYZLG/6Ge/4AplRYTHXzfLwndt5OPGnUVk3qDeYbjpPx8vQdBNFwvWDZulr73bDlhiKDHQII0pUX8chjtNaYPFOowBQAV2OPB/tOeRllZy+SEJcb/4sIfHZMAzVvZbDguxAacWqqsceHWOsfg0PXzyL1v2ym2lCZEbK/xEuGeeeg2t8mZhiG9ao+LWw/tn6FsWm1iUXX7fAEhtHrDmKftifGPRyc0O0MAvfDiY49D7p4UppJyZLKuT5wTLknYlqY0xzfzZrtl4UwFZsHBJECYvYT1eNQCEHqhGzpbaDDJWeB6uIBmcTsN6BF05JuPZGNwNzkV4glpCCqxDvDTitWtTlpl9pdSt/cY7ZwVnrfNismfTMLq2/UtlhlwWy/DekY9qOCJfBRq0S9pNkhSQjz30ZeQoOJKZAcKeYHtVp90D/wzguof3
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 10:58:19.1452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f52587-89cd-4894-73bf-08dee7e023ce
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.84];
 Helo=[fihe01smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8460
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/204/JTEjD7OCDFTBwd/bq6qV2JZanEcg45eChn2h9o=;
 b=ZpS/HOFRVyyoq/RD/4kbi6Asp9ZxZN4356JSWbl5u28YNj9+WT6dGVOF3vswNqJYwCfz7dEz8Fkf5QeHi4wshsCrQHoc6F6yzqm2fRtOU6GqzrYaRk3dDB9mwVAPjPeWHnqsJDMdeylqeQ26xn/X5mVWDpMdMj1Sc8RlQ2xR5Yq/3oZXbvB9J1yAnFpeEl8Kme4TRUESD/2c1/OdhAdKZ5hxlyh3Bz5HgPgrN6gixGV+aAtZgC4EUC7caDg7+KNO8pDEgCRMrE/jvjOfAcLat9K7RHheP7d9iokim3f7MNeLLYFcm7YY8xS3rl2WkreVsLCI1gJKeV+uBhmdR5zwUA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=nokia.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=ZpS/HOFR
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=nokia.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=juuso.rinta@nokia.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=nokia.com header.i=@nokia.com header.b="ZpS/HOFR"; 
 dkim-atps=neutral
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
From: Juuso Rinta via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Juuso Rinta <juuso.rinta@nokia.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Report the hardware-limited maximum timeout value to the wdt
uclass by setting max_timeout_ms in the per-device uclass-plat
data during sbsa_gwdt_probe().

The timeout is programmed via the 32-bit WOR offset register and
lasts (WOR * 2) ticks, so the largest representable timeout is
(U32_MAX * 2) ticks. This is converted to milliseconds using the
timer clock from get_tbclk(). The value is set only when the clock
rate is non-zero.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/sbsa_gwdt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 3a924cb2b9a..4ccde7b1e1a 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -6,6 +6,7 @@
  */
 
 #include <asm/io.h>
+#include <div64.h>
 #include <dm/device.h>
 #include <dm/fdtaddr.h>
 #include <dm/read.h>
@@ -91,8 +92,19 @@ static int sbsa_gwdt_expire_now(struct udevice *dev, ulong flags)
 
 static int sbsa_gwdt_probe(struct udevice *dev)
 {
+	struct wdt_uc_plat *plat = dev_get_uclass_plat(dev);
+	u32 clk = get_tbclk();
+
 	debug("%s: Probing wdt%u (sbsa-gwdt)\n", __func__, dev_seq(dev));
 
+	/*
+	 * WOR is 32-bit and the timeout is (WOR value * 2) ticks,
+	 * so the largest timeout the hardware can represent is
+	 * (U32_MAX * 2) ticks.
+	 */
+	if (clk)
+		plat->max_timeout_ms = lldiv((u64)U32_MAX * 2 * 1000, clk);
+
 	return 0;
 }
 

-- 
2.39.2


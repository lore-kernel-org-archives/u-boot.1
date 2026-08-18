Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F780C5DF67
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 07:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23CDB608B5;
	Tue, 18 Aug 2026 07:44:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id doSXghBkUzEE; Tue, 18 Aug 2026 07:44:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF788608B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787039042;
	bh=/204/JTEjD7OCDFTBwd/bq6qV2JZanEcg45eChn2h9o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ClIo/FMEModta54MmAywZuMkJ627bBCJ2ZcCd202tIgTgimIa+Zc3sNOcNExXsAyx
	 57LETs/sQTWKLkdIn4ePY1nM9hYjlGQkHSoYoRH8lYP2k5a2YlRZxhgR5gS9d2XQ6A
	 3FwwnZMf8cvpiLWIA7gbL/u9FltXftAE8/YTdDym4mIiIzr5OzLazP2kHM/+6YDAG+
	 /fZEZRKC8YbDAq3ATW5GlXl8tNnr35rAGP3sWbIqxQkbCJFRKdUyibPBIyhF/aaStT
	 nQsMHxGnTQe3sfTK2jNZWUqWqe40WGgKLMk4XxHVRXxIgI9R1XSUYDROa02Zceb47g
	 nDrW/mrYsSQqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF788608B9;
	Tue, 18 Aug 2026 07:44:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 75D99194
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 68011605F1
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:43:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jn2j7u4VYchT for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 07:43:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9770E60611
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9770E60611
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=pFtYlYGT
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9770E60611
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHAQEBoz8bv84vfVNwG/1sOjmkhmoDwcm/B1AtL5vog+tAdEdddRUNXaTK4zOY1fNQh/KKHasIAYa0s/q7wOhs0JqpWOBGa5zWcJvI9E/yWv5rvF+UOVlIyK0LnEB937CbrcgG4IMykM4aEvYcZi0Oe/REamLrv/TnUUohUMtZtRd3qAmOkI4ikoRsCxZf/W/NxlMJvsKdcMmLp8XO1iboqGRI+x2RRTusuEpL+DzrcHgu+xqxKboNhZHxzaFARAUDivmCcOBTsD51pccHJyckFat0WR6kCbM0N0c7WoMilKY1RfKCyrDLRIJHo7fBjozbqKtwAqDt2zpH3VBe/HIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/204/JTEjD7OCDFTBwd/bq6qV2JZanEcg45eChn2h9o=;
 b=cziFasW7uJZ6ktYl1jSln+qXRsCCrAj3f3t6qYh21xy2w2jrbKhiMHGryQer5hd0C/uFkUYwP1r4cxsJg5zNu+q/S26q5ckyOozPnySvca/jdHnuKxDro6bxsJ25d4db51aq2ZEQqZ94pr20TOMFZydL0HSmqiDA2TmmW0S5vF+vB/uB9aYlQwxSdeuN/TZTODlVM3FqTnHLgmTPmQOFo7tMw5BFzyO+/QkxrpE1UF5TZsHEsVAgLs5OdK0MiEs9NZSvZzTS7piPB+e00u48lHUIPQdGanPVHSSv98VmGfaTn498GcwG3xw83E4sPwDF08/Oz6S730vpx7zURPsCVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/204/JTEjD7OCDFTBwd/bq6qV2JZanEcg45eChn2h9o=;
 b=pFtYlYGTLzHIO/g3Cdya+5uikMQaQ6aBxepjnGgfDcOIyn/k8qiDfcZizijFjfhPHikCIKZ/qLDu53pJosnghi2zxS5IcS5sU6BHf1Yvj46oGcs9Ne3NLM0P0n1v2ja9GPYapng/Xxku4L65x1UZvn/BvM4T2VN/DIN4H0GORaYr2zyJKyAkFZF42K3EDDNA1BLtrE593HMBR2HJBYS1wR/SJop3XANxC8Zf8/SyaVkzjafm+f96Og5XBPP050wBJzps2V1XmIAhVBila6oNvSc9j7rPQOlJP8FSICRczfZUIOXBi0bVRvQPbsWc2cL02JpDJRGcut4sVvXJwRNYYQ==
Received: from DUZP191CA0026.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::7) by
 DB9PR07MB9197.eurprd07.prod.outlook.com (2603:10a6:10:457::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.8; Tue, 18 Aug 2026 07:43:45 +0000
Received: from DB5PEPF00014B88.eurprd02.prod.outlook.com
 (2603:10a6:10:4f8:cafe::1e) by DUZP191CA0026.outlook.office365.com
 (2603:10a6:10:4f8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 07:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.6.101 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.6.101; helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB5PEPF00014B88.mail.protection.outlook.com (10.167.8.196) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Tue, 18 Aug 2026 07:43:45 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id EACA01C004D;
 Tue, 18 Aug 2026 10:43:44 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Tue, 18 Aug 2026 10:43:27 +0300
Subject: [PATCH v3 3/6] watchdog: sbsa_gwdt: set max_timeout_ms in probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-rinta-watchdog-gettime-v3-3-423f5caf526d@nokia.com>
References: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
In-Reply-To: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787039024; l=1491;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=MiQR1BcXEMxEWPGMm+IPaPg5u6pcXZUmfwpGolvxcww=;
 b=UFsNapl2Lwt1vuafD6+o0CRpPRb1Og4VjsU4/+dEfurr5q+Iw7qlLI7AGgZ//8dFecNIo+/TR
 lk51fNrDMCWD5mNiJ5bbmKC+7N15YCrdeO1VqZ5WM11TieiUvLyGp68
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B88:EE_|DB9PR07MB9197:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7a94b8-3ebf-4b0e-e826-08defcfc6ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: Mfjxg1ei48Vt0kDkkB9coLqpVLk6gKCaE7//L25utqblDDw8OFBDdp3b58JmptFPQn7FKCXhjaeKPhNfyE9pbvqqKLGX9KGE6W+19YkzYsQOHLv996QDNF0El+uQovsvt5HRcZROhjg8TNbON22Vv+tKxDYHso5yuaRNQsj+IM9lzrAQpme38q3mU0fzL/D/YsoRE3mOrIKW2tSIx3Fo63I43jxaTc7SyeLyJ06C7ZMiLkcYHZxcAY6wQMJeBqnqx1tbRuqNLCoynEReBEG1jUHI8mJ7aG73w3D0h7+G4cAPj3DyuD0Pu42iSf84rJBYG6Uia7y+/6nG/i4hsEn9dr+jN+Uy3IxfBRA9s7CDLhCXnYf/0Pea6A/Se/U6D9AWoUKwd05hCAEgpwvWY/cX4r3RA7b/cKdCbzEgjwlBV5Lb8ISxrDZsxcvWNjDiMRQ3EoiizMsAJ1kWI3P1IUVzT/zt4u5XrgDozGsnpZh3GPM71HXrPxBqTJqHoKy0dgpsr09Ka67iFvuGAv7JQ5K++2LsJBIf7aD75+ueRfIhP2cfGtSGtdwRmpYTeGOY7nTXvze/KNqwfj4mEbp6W95tKgOVIUcyRCePudbfSuLLXgI6Mt4MUYYbDICQM4zVft90eSm6GXlR78xa0+djSbtbgfs4CPZTFtT/aHEfF+/Dfv0WGbvFGVqO/+cqF1liwENpwRFa6fkzFP1bpfq+He/hbw==
X-Forefront-Antispam-Report: CIP:131.228.6.101; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fr712usmtp1.zeu.alcatel-lucent.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bW5EowMOSEiowmJpE5u8jwOOg5u2sgCZlS78AI6ycdiUu5S5jwXMFOuXZt7cMCtX1Rt56SIZBHv6ePtGtnYiq1mz7DvNlhVXrNWtpF06zKdn7+i6bZwkvuoy0Mflk9Ny4YA8rnEALT0NavnXwxaz2kJxknuburNnS7Ch/Xhg9Y9PrTBu3vH+MQucW/J0x71L8u/2vlu8aRbQvqluqMldhV+e7qdfrIPneU/u2yg0qBGY1+Eg0ugoHBVgLrmmMYAZYFilN8YxJURwOvOrXpQxG/HC5zkCtdY9DxkE8V0Li3Eid6Sez9Z9p/7IEQFwuphCxTrdHTprJXoNcbmWXFBuFvO/JMOC1rk+e5Gtc9hOYNELOA7NQc4AXx5rsrDNJPxmIJ3CsIHv5/BWbOICLrIoxe7bhXiVxQSoiP074eWnV1u8VZ95D42ImiBuoPi21UIU
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 07:43:45.4869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7a94b8-3ebf-4b0e-e826-08defcfc6ee9
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.6.101];
 Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B88.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9197
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


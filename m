Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0812C606EB16
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=S5eN0oEw;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=hBA4eT7G
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D488B40E6E;
	Fri, 13 Nov 2026 13:58:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b1380k-Q2o6j; Fri, 13 Nov 2026 13:58:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 28BE640E6F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794578331;
	b=q+SF2d+sFEEqalw0cV+V3TbpGXxi1J6PqwOeezroWGVZYEFNibkf42QjgW8NbqYd8sOE
	 wDrFAKZl5pBiJEE35lR1Q0qDfvpnaCPSFV/37Bu9X9+E13KLPuFAmrC2yBGVmphLibo4A
	 uDYjG2KVQlOFjMxQI9Psd5919/04Lee4uS6dY0Bqgi2suUbQbJ9n9MAXdXZSIEFccxb13
	 jBvlXFVjtDlOf004Tzgi5blS+IZzffKBvD7JIVqg6rFRD9VmpGGFNPmhH23pIR+xEr83u
	 DRSqkOcsDB1oAeadkkEhtHsuN8BeIgHSeW1qCWcC4p50sRLimB518uaMtx7X8PHtdtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794578331;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-Originating-IP:
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
	bh=9SnCXYWMC8BDZ9HoygQ0UNoSDsbDDRO41ZRr7dfig2Y=;
	b=oS1WGmT8whlNmUCLU0TfsAWq61WAUItI2wTwuKFIiyTAX78o39jVdMcl0Ahnzg2qOL2x
	 Y2HIM3gJhng+a8XA8fa0KCkrqVp4MNjU7fYOXOG47a7N0zNYY6iBlpOohfKAx/xsbN1L/
	 drDgKr6mbICN80pWSLkFrc5eq5f7//JZegVEjvvg/05firnpcR4kGJIv2sA2mQrRGlIsR
	 JaNUeygW1YoEXxLfxNjbXjl+JrK6qOLXSDK6KmzPx9OmsVtk8+47tQDQgoRyBJc0UOLoZ
	 UoU94NkwVDa7d0Z5SJsq6gwu8apCs1mF148/9nRa/uxZzL+sSXO6hOE/suVE41QhNpg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794578331;
	bh=9SnCXYWMC8BDZ9HoygQ0UNoSDsbDDRO41ZRr7dfig2Y=;
	h=From:Date:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=S5eN0oEwTlXZD8Mv0hPMID3Hqf30aV4mv5BEzBZ55PLHNsJj3lxnhRTn+BXHPnnr9
	 Ov6B3jhcSinTfUhNEafc/3O4185UMsivapHdiQQwmyImwqWhm+pM0JMYkM55597VJH
	 fi7fPxJ9o8zCwZwoYP00Q0yk2B+NQE1Vaz/5QamBk9ruc//PhWimIG8QPwCCffKZjC
	 Gn9+PXtWJYWC95dbKTPRdKzANVFuzlJI8Q+qdqtRCK2kMNIbNOpdAyjj/CygiIB+WD
	 2fEmrRuCo6nf3o1aDg2DtvoDs/umZcOeDbuXQZV6L6dVGMABd3qo4sGNs8A6fjqIkj
	 QbTBc0ldPQYHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28BE640E6F;
	Fri, 13 Nov 2026 13:58:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AEE59AF8
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 13:58:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A0F0881C44
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 13:58:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2eZaKOlYnazn for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 13:58:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E826681C40
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=hBA4eT7G
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E826681C40
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 13:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SnCXYWMC8BDZ9HoygQ0UNoSDsbDDRO41ZRr7dfig2Y=;
 b=hBA4eT7GVCgymM9vy4/bizLZynlFnuvsMuf86kaaOxa0XBwwHg4BQFfPQi4Xs/GfbJd6WPcv3/W/5LVzlnh6b/RWVXR2pKtTsgA7qFamZeNqJ9wSoQ7/5y59LqW6LjkRpYWXt6FcBp6li7NamOMqwAwUDE5C/Zx35kpSp/mRMm38K7iBpBRN1p9magmzEla9iGo05dGTV3haYUdQBgeza8XwLBjS8G5sOlIwdTk0mqVbuFj7L19pw30Rwwo2Dqg4Mzt8H17u4rVp0Pr/R5kzReClDtwatBlCk6Ls1o8SLRHcPIHt9ajb4PeGGEV2G5mrhdjnZnmJe0H0rhM6VZle/w==
Received: from WA1P291CA0022.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:19::29)
 by AS2PR10MB6542.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.0; Fri, 13 Nov
 2026 13:58:39 +0000
Received: from ZR1PEPF0000E6BC.eurprd07.prod.outlook.com
 (2603:10a6:1d0:19:cafe::6b) by WA1P291CA0022.outlook.office365.com
 (2603:10a6:1d0:19::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Fri,
 13 Nov 2026 13:58:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 ZR1PEPF0000E6BC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 13:58:34 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 14:55:30 +0100
Received: from localhost (10.252.28.24) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 14:54:31 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 13 Nov 2026 14:54:30 +0100
Subject: [PATCH] ARM: dts: stm32mp: Fix qspi nodes for
 stm32mp157c-ev1-scmi-u-boot
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261113-ostub-1905-v1-1-7a8b799e260f@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAJUW92oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Nj3fziktIkXUNLA1PdxKSUJEtzwySLZItEJaCGgqLUtMwKsGHRsRB
 +cWlSVmpyCcgEpdpaAMaxFzVuAAAA
X-Change-ID: 20261113-ostub-1905-abdb971b8c8a
To: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, Marek Vasut
 <marex@nabladev.com>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6BC:EE_|AS2PR10MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: ef21702f-c0c0-4f6b-ba02-08df418e3597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|11063799006|10067099003|56012099006|261021123027099003|261026140227099003|261028144727099003|261022115727099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: O84mlgg79AsWZog6lGV9euAPTuXLZEdcRpFpMivttvZ6DgUz5OMc4/2Nqy7WrSuHL3eminbqh0ZTDwvwwzPfzz/Yf5oWDXz07zdFuVio+//EvQfkHunAnSrFFUm5al8L29zYzmLhpcP8tE4nwPCqQpsozH3XUQ4zNGpmhhXEKLn5U4U9ttG5gH+qYz/gdV8CZS/R1p5g2DMt2721EcnlhHFyl/cZXjaVFFjilY7yaqtO45c0yZBNxDIxpYIXzmjTlKLaifAAvwk36azWfR/2fhQQ/g9vnnFBcngU/8sqhamMCVZAMiw0WNmxhLS3ggAv4e+DHYv2cm8w3LUWE+vTMuyYLGR3qbHF8VPPK9olm+78ovP8ByeInjPXQVDMgCWiACx4iJVsYMTgmv04XNclA8/z6LA/erQAu2+P17EjNHUk9WPPP0T76V42poV5lBQP2Ab8fubov/SIwIXckBbj/YQffgtjridmGQu09mGXOR6onFDpnFiLW7JmZjOxZuxzUO/h3CtchITUwG9x1zfE6vwZjaAUpHBRR5sgU81d836t36gvyhZswbcFcowgcR+hevpylJKIe8x41PInd7FR5eew62wxeZFj3qgrwtkV+NqASeOEwWydtNr6lmAsGb2ZidgWtS0wCFdE0toPaxzmkQ64B9xIT3OhyKM0+GjmWESqSrqqJ9VyEqrGJ8sER/dY1hNM2nXY/l6lA7jc0j7R3A==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(11063799006)(10067099003)(56012099006)(261021123027099003)(261026140227099003)(261028144727099003)(261022115727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dJA0Y5qkT0oRdSGptV/CKTuYqU6t3ewxrZ2oDba3aYy496YF7ll+1sENqvLMbu9r1ZVx3nGupXqIBIqLsw6MrnQTTuyiKXsvSU9tLE5sMP9psD3HpOfHfg2PYaEANC7dt89Vbfva/yfsFAQxcY3XCKbzmmZqNgbaooGzdE9o9HQ51oLByPKQ/rBQaoYBeWRoTmI6JxKlbQIRhl/EN7VCHhFiMkFoLJMcgtHatpePxnLt4WS5cwDW0l9kyhiWvO5S2ELxPKpK7BPd1lh3hg2Z/D/UAWvf+xbLdzlOlh2LwKHKVP8sS2bN6uReIK071ifcBoXg25bQBVbSOJ6jdt+cT15sezdSDnRWxiHcqoya15KHNkySLZhx79h3HnganUCtWNNcHeRuRWpbPKu7wIxuCfUtNVVm4tN/xn072aDKm55kk7D0yb4rynpzYF86Qvxd
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:58:34.9229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef21702f-c0c0-4f6b-ba02-08df418e3597
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6BC.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6542
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

Fix NOR boot for stm32mp157c-ev1-scmi board due to qspi pinctrl
mismatch after kernel v6.3 device tree alignment.
Patch similar to commit 5846ef86f89b ("ARM: dts: stm32mp: Repair
damage from alignment with v6.3").

Fixes: 08002ffd083d ("ARM: dts: stm32mp: alignment with v6.3")
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/dts/stm32mp157c-ev1-scmi-u-boot.dtsi | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/stm32mp157c-ev1-scmi-u-boot.dtsi b/arch/arm/dts/stm32mp157c-ev1-scmi-u-boot.dtsi
index 9768db8de9c..1318052d33a 100644
--- a/arch/arm/dts/stm32mp157c-ev1-scmi-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp157c-ev1-scmi-u-boot.dtsi
@@ -123,20 +123,28 @@
 
 &qspi_bk1_pins_a {
 	bootph-pre-ram;
-	pins1 {
+	pins {
 		bootph-pre-ram;
 	};
-	pins2 {
+};
+
+&qspi_cs1_pins_a {
+	bootph-pre-ram;
+	pins {
 		bootph-pre-ram;
 	};
 };
 
 &qspi_bk2_pins_a {
 	bootph-pre-ram;
-	pins1 {
+	pins {
 		bootph-pre-ram;
 	};
-	pins2 {
+};
+
+&qspi_cs2_pins_a {
+	bootph-pre-ram;
+	pins {
 		bootph-pre-ram;
 	};
 };

---
base-commit: ecdcf9e365df6249a57cd8cc946e7026804ff4ae
change-id: 20261113-ostub-1905-abdb971b8c8a

Best regards,
--  
Patrice Chotard <patrice.chotard@foss.st.com>


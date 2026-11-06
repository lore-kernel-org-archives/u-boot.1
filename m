Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1D2606A80D
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UTdhmK6Q;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=RmDu8GFS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 512D0409B6;
	Fri,  6 Nov 2026 11:19:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cvGLFtVtjYkY; Fri,  6 Nov 2026 11:19:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 57C8A409A2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793963951;
	b=iLMMGjgYenKZAZC99lVKQ42m4rmgSh20EylNjgrDBNsM5IpDmBP/uoN0Oe6qacJv/i+Z
	 nNA7ZvknbFfUOqd9olgH7MfQo9n4nRf3WDa4MP9BhaiZoKY7INhW2oaf6RPwIXmc7QWsm
	 5lEAr70ckl0fx+N88SzhUQaeM8ZzfWRwblHOPdmfuBE61EQFUPeGyKl3lKtkqcV/8db/y
	 dmZffl/plxAdN2dSgnXY2XgcbM5800+PH6tX6Sf7/LL53XYunIvb7kvLeJ9KFs8X1r2nk
	 6CFmyR1RQqIT8s0EbMh55hBioiztivq2SPKuRMJ+vMzI7O2zAH0V3vnkt+mEwsvpL5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793963951;
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
	bh=Knuwf9UKPgq2+NZGnYFqJ6StJtvTLc2PDu3RSVhAwj4=;
	b=cp5YTE90fWf/CGWvLcqTVN9CZGXuvO9MHd4/Gc5qPeXEPjpDPfrGhAlYNE5NWtfrCCLX
	 7eixkfwlPhnfxnSDJNXJ8+qJBIH4CKPXTLN98FdEKyo6u8SdB1QS+maLyvT5br9nSuK9e
	 WhKMy7rJPw7FGCCO0sZHXc+G3JWP73637DwYDREkbdzovdO8DOA+iOlGR5MopNFy+Dpag
	 RXD8QIErFV9mgn+Xa4bmkGeIrZc3XhZkyxBso6GjYmSpIMpJ0lC50gT+udZP6rV4xApYE
	 QSrpUMaBKmcvJTwZQen+hAzlDCFOXJSsSPfCQxnne2I6+CjRy/bQiOp7NCB3YXj+qmQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=RmDu8GFS;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793963950;
	bh=Knuwf9UKPgq2+NZGnYFqJ6StJtvTLc2PDu3RSVhAwj4=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UTdhmK6QbbdQwlaeYpOD2IZAdGDIcRAYBxrUmRgblS4jLDru7WqAljRLAro85jnpn
	 7r6rPR8QxAqcWTTlxzE3tYlOB5aXUqjfZ7TPYjigfgbWmwV/HFdltO5UxDE2U+viiS
	 ozYNGAeogD5fdN0M6dNxNGMKdR5mxNNUqI2SKtrtBRdR69qhZQ0UP4DRbUqgXpQQnX
	 5QcZ5hnwGiPT4WyB/ck9T1y5rDIUwo6SsDZfRtiIaK7ueL+0UZzmKwe8fxyCjzdjKn
	 G3P/UirBBw4Idjr9O47W006V6G9c3y2IJwImUmVRwbHQlcoqSWR/zeuCGQAQdE3n0L
	 nEGYGgBeuPsPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57C8A409A2;
	Fri,  6 Nov 2026 11:19:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AF46F1E3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 11:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E6A540986
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 11:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3GiEzZ5nzfWX for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 11:19:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D8D9540953
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=RmDu8GFS
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D8D9540953
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 11:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Knuwf9UKPgq2+NZGnYFqJ6StJtvTLc2PDu3RSVhAwj4=;
 b=RmDu8GFSuoYYujHmLUP22rNMqAPYwlOSh5bueP3fMGgrI93g2VSrWSrWdYAWsteuQ3YtQ8WQ8DbzQc4XLEccutDjSi6NF6e9ewPxTgiUt+pI4qEGQhD/3b9iqyLpdc14gP3UAvX5U96i9dJ6yuM/UpEQCz+CbK8bWrXfIdSWZ1+8PoprrhjYDrE8oLAE9YNdn+Iu9F3RHA3Muz1dwyIIklEFVlVJogx2vmaAbtLqqFvtKjTGJC0GfCO9gKG5OzEp4N6q6rbhfaBXahYXnKGMsRy1LtzoOew5JrPclji5wQSjW3AkH6p3LIyVUllk3GbCh/dU2L9nKVMEQl9HwL84WQ==
Received: from FR0P281CA0086.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1e::22)
 by PA1PR10MB9121.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 11:18:54 +0000
Received: from ZR1PEPF0000E6B6.eurprd07.prod.outlook.com
 (2603:10a6:d10:1e:cafe::2) by FR0P281CA0086.outlook.office365.com
 (2603:10a6:d10:1e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.5 via Frontend Transport; Fri, 6
 Nov 2026 11:18:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 ZR1PEPF0000E6B6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 11:18:54 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 12:19:24 +0100
Received: from localhost (10.252.31.114) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 12:18:53 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 6 Nov 2026 12:18:50 +0100
Subject: [PATCH 2/5] gpio: stm32_gpio: flag secured pin as protected
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261106-upstream_pinctrl_update-v1-2-4f3d4f6e97fc@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6B6:EE_|PA1PR10MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f2ff5e-3f7c-4b08-ce21-08df3bf7be05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|22082099003|18002099003|11063799006|56012099006|261022105027099003|261009220027099003|10067099003|261021121427099003|261026140227099003|261102123227099003|261028144727099003|261009221727099003|261009221227099003|261009223327099003|261009223027099003|41080700001;
X-Microsoft-Antispam-Message-Info: yZ4J1hNHDWRglkYtVlhxn79xKtCM92zJn2R6HgZl/NGn+evB4AfWpH3JZnSOChQ6/jM8wIIPlRFYS7Z4l/vlvUkpJRRLwZitjfBAzm95kLcE+WnQjxZJ9+ONNFS0WgJ74al1W51fhHI6KidVYK7NOCoVmGTZ7mVO9JHCb79/8dNiRuC8CZZ/ASxaq7kWjbhxi5IIL+f6vjYFnog4Lp27VMOdz8lKA/Ss5d7tfJTOgTkrP5MzI2ayGGTuETRJORiS3Y2wOWIR3wPF9nM41EYzUF+FZGI+YQO/mQ3Cf3pm3OG2u5WOtQFXDPX7fVSGW3TWmmV5QOphQumrm9mvStJm8DECAxaZSbV1ehgUAg4i4sdl+YRXurQoEd0YOa0aM8lZZJsMyrRFrPOk/dz5ZReE2MgEswAc6jdTqIFV1JambC+SvWEeW3pxZiNCopHFtvr8sXCJv7iDyVLh1RRNTX7U0qfwLXAYCPXSd/s+4fKVCLp+i53OYG4ese7EcjV1ybdT61umCfICL0jLpkdfORf+CbVqQFaez5qzm1diRBpMDU54QuCJF1UHaNCAZqywq2BidC6/89b1qRoywc5tH/3oNTlYnpGG/HiBWuAbLvEUeLR/r2+X2dNRrOq5pBt1HT7vVa+XLsX4VbJbZQGp4cyGkiPPgwrOyoqMezt+C7hAYbtKA9/Z/poxSMGOLIudEXsEHmjv/HJbQFsSt82sdMmUN8448oEJccZRiWclu3vHqMJx/ti8RCxEoCPps+dhQErgcwZ5cEs5LbSfpJ2E9uTq9g==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(261022105027099003)(261009220027099003)(10067099003)(261021121427099003)(261026140227099003)(261102123227099003)(261028144727099003)(261009221727099003)(261009221227099003)(261009223327099003)(261009223027099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q3Ir9aY6TB8+rmmrJ3IICEXXHkGlcUX9JH/Ze5gioWrivvWmfzUHUKYDpzP4tZvz3NDEFSGys+3Fpu7bBg+8tczr01WTSqyYlVzKlPPAge5Beg4+CfxmmORvYtoyxRpQrQWYKO3X6dX9DCatb0zXr/dzRERpJ9n6zGtiAsN70ZhEo7Bllksa5kDROX/TgfwqUty5Xs/i49bV//jQiiGWjnJsV1gZCUKVPdROuq5jHNZaeIFOFtDIpZe091OqkNN/W/olwrA82hM/MfNBgOe+JzFL6dFyVnJyw/YN7i+kEjts3ArGEpwzTXUcpjtyC3332uQc6DQtGf5MDMnCvxlry7xbPZ95uvvMnxVmIz7IOY1prm0etXkk1QeQ2NoGXwlIoHiG6mlbH0VaPRSFivZ+aBWkfE2/bpic4nitdpaNxtWRtIp0+BDSoeJBUblgYY0Y
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:18:54.0684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f2ff5e-3f7c-4b08-ce21-08df3bf7be05
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6B6.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9121
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

From: Fabien Dessenne <fabien.dessenne@foss.st.com>

When a GPIO is secure-protected, it can't be accessed from U-Boot.
In that case, set its 'function' to GPIOF_PROTECTED.
This makes the "gpio status" command returning the "protected" status.

Example with GPIOA6 pin secure-protected on STM32MP135F-DK:

> gpio status -a
Bank GPIOA:
GPIOA0: unused: 0 [ ]
GPIOA1: func
...
GPIOA6: protected
...

Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/gpio/gpio-uclass.c | 1 +
 drivers/gpio/stm32_gpio.c  | 6 ++++++
 include/asm-generic/gpio.h | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 33eaf2a2022..8567e8493fc 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -867,6 +867,7 @@ static const char * const gpio_function[GPIOF_COUNT] = {
 	"unused",
 	"unknown",
 	"func",
+	"protected",
 };
 
 static int get_function(struct udevice *dev, int offset, bool skip_unused,
diff --git a/drivers/gpio/stm32_gpio.c b/drivers/gpio/stm32_gpio.c
index e354a4148ca..77bafe18ef9 100644
--- a/drivers/gpio/stm32_gpio.c
+++ b/drivers/gpio/stm32_gpio.c
@@ -170,6 +170,7 @@ static int stm32_gpio_get_function(struct udevice *dev, unsigned int offset)
 {
 	struct stm32_gpio_priv *priv = dev_get_priv(dev);
 	struct stm32_gpio_regs *regs = priv->regs;
+	ulong drv_data = dev_get_driver_data(dev);
 	int bits_index;
 	int mask;
 	u32 mode;
@@ -177,6 +178,11 @@ static int stm32_gpio_get_function(struct udevice *dev, unsigned int offset)
 	if (!stm32_gpio_is_mapped(dev, offset))
 		return GPIOF_UNKNOWN;
 
+	/* Return 'protected' if the IO is secured */
+	if ((drv_data & STM32_GPIO_FLAG_SEC_CTRL) &&
+	    ((readl(&regs->seccfgr) >> SECCFG_BITS(offset)) & SECCFG_MSK))
+		return GPIOF_PROTECTED;
+
 	bits_index = MODE_BITS(offset);
 	mask = MODE_BITS_MASK << bits_index;
 
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index 8229a5faac1..9e2d88cad26 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -110,6 +110,7 @@ enum gpio_func_t {
 	GPIOF_UNUSED,		/* Not claimed */
 	GPIOF_UNKNOWN,		/* Not known */
 	GPIOF_FUNC,		/* Not used as a GPIO */
+	GPIOF_PROTECTED,	/* Protected access */
 
 	GPIOF_COUNT,
 };

-- 
2.43.0


Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD85606A802
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YG7LZDAs;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Yg1lhLCA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B0CF4098A;
	Fri,  6 Nov 2026 11:19:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s5R21MEMOMEz; Fri,  6 Nov 2026 11:19:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 929C84093F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793963944;
	b=G00BW6o3W5oHm4OtrSAvjl3lAnqrESzCsCoFBO+H3VnDlTq6VQnSPHvuFglLUCMCQA+K
	 0sM3PcRNbEpO9L56qQLtF3km9obOhJOhGrpuSkuKA2KyLTYu77Hpfdt+3rK5vWM/SbAO7
	 FvJmZbVTqRpxpbvNuYfLuF5cRfqXvrcK4Jk7zbGGUkxHbGTPruTV1qUnEJL9+4v4a226g
	 08IkTX6PIBGESwY69YVY/pdBLEQBDSpmUnsKTLvXljs06CiGlo4LEVtaxC+cUBsIyKvoe
	 fXW4QpTBSHYrjwKHGCZQgsiwvOn3pOg/X4xRbJC/we9xwD82ndjs/57Sj86is4LVLLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793963944;
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
	bh=yv+xNN4INIu1Dc2YKaf/3KCd8+F1VqzuyY+c8TxxO1o=;
	b=CeGZgI9j9h1Iqslqr4qVSnP4eOF4eguWGSyLLmgs8a3aKyFNfu8NVOueRb1eZIdhOMlH
	 UU+LG/zYclM3eS1d3g/J3dEtEKB+vrmN03aow+0MRdCWwQ9QqaaoXON/wXfub4z34sRHI
	 PBg4pqzMPq/mBpsPMQbCV/UOb323rLsQx0gtfcdhyJfvdaRkiZdpX5UY4/OMLHjFyCudN
	 /8ZC9FqvXvA5Tv/ox7NEPm/EyA5SYQdsp4Rssex8Z1qepSXS4CyfLE0dVAZzrfLzD5Kv8
	 Qjv5IxIVzPIPzCUCoeHDa3GNEd7Phquuz6EANp9vRm0gkIkN602zK4wHWKqtiUh6n7Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793963944;
	bh=yv+xNN4INIu1Dc2YKaf/3KCd8+F1VqzuyY+c8TxxO1o=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YG7LZDAsLLqOs5w0kGs0pFBGojg9w6KmGH1Aealr1btPRh9lVmOEqg9HvpaaXA+Kr
	 blg4hj9p17UDydky+caTJ0TvyENcLoX1va1eBjfHp4VWcu0Ao575VUCXT4RuNFVoLC
	 2diuHgUT+xl7Ny7JIPZGEZvhjh1BTULGo+Pb64oxBJZq4KeGWJfHbEChUdEK7NMkTX
	 fgggIJlc3J6thv/s7Zxjyz4YrOcXNVIelgA8SLYoDmeeC7cUZeUPBn+H2bO6u5etBB
	 2Ml7dx+yPtsUgUMlRBZR6IESLyJPirneu7gmnFCAXZMv5k9D19HCQ5EEfbpPQvSIzF
	 6VEQIfwvYIOqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 929C84093F;
	Fri,  6 Nov 2026 11:19:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F5E01E3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 11:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 041B2607CF
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 11:19:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xa4q1j3Xywy2 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 11:19:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D6ED060640
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=Yg1lhLCA
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D6ED060640
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 11:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yv+xNN4INIu1Dc2YKaf/3KCd8+F1VqzuyY+c8TxxO1o=;
 b=Yg1lhLCA9SraLVcgwZD6IUwGdD6vHKR+6Ku2ISKkzPpjbV7CuM0qMfij1HaHrO7Z98GuNkdBAmEX0YqCg0kID8x31nuhptBHZ1p3EcsbDDqoGwpibVvpxmUu8sL/WEEz5Fz697EFua+iRkaTTV0XXEzRQe63+zwUTwbTsGFe6hlgLH9ENLbA0WqorGP+krmGqVA0Ve0MG4xneHLdUT8/gZ95aYSa1l3kmFONZa5vSrAqnz8gfCkY/kvVKJd94Fqxb0yH4BmD1dZ3zfp5+IPZ9as3kxONsVqaTxKdXovefrUAgHfJNJmU5i1h67Rc5YJhyCk6rLaAs4thJk4+0MHWgg==
Received: from OS6P279CA0020.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:33::14)
 by AS2PR10MB6822.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.5; Fri, 6 Nov 2026
 11:18:55 +0000
Received: from CPH1EPF0000051D.eurprd04.prod.outlook.com
 (2603:10a6:e10:33:cafe::76) by OS6P279CA0020.outlook.office365.com
 (2603:10a6:e10:33::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 11:18:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 CPH1EPF0000051D.mail.protection.outlook.com (10.167.241.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 11:18:55 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 12:19:40 +0100
Received: from localhost (10.252.31.114) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 12:18:54 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 6 Nov 2026 12:18:51 +0100
Subject: [PATCH 3/5] dm: gpio: Add GPIOF_PROTECTED flag test
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261106-upstream_pinctrl_update-v1-3-4f3d4f6e97fc@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: CPH1EPF0000051D:EE_|AS2PR10MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 23512222-1134-4029-8099-08df3bf7bea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|10067099003|22082099003|18002099003|3023799007|56012099006|11063799006|261026121527099003|261102123227099003|261021121427099003|261021123027099003|261009223027099003|41080700001;
X-Microsoft-Antispam-Message-Info: eMDcOMqmpH7TA1qx9fCii9dTT7LW+tV82wwphxXlkUUa+IbAEoHyP53k2LwPYP0166iv7TzsSmF4uKr/PoNNx7NQeSyYBtRRcGQ5fRIX/tOIB5REqkwkP6oV1WqHPWcvLVR0FLDzI/PxYkiAYK0jExpV4x9lReX/5irEQJOoLfWMXeTyEHWF9ntDvYoDZgyB5dt8dVC/JJ//5xG7So90q2+3xqZ5y2tX6SO0sUC12GKHIS1X1ovgxJU7a8/ROwx3Du8TlVQl660uMGfNvhuf2myDUbdKBH1xradeqiX++YnEejZIJStiriWxxizaVKK+ucakQ/YUlnsTW07/eQ4uqqLZACL8hu/sHY564GtHJgDo1BGF95jndoaaFTLT6WZ2Az70cuEwHPq1zu/CExaA8GtSGhAMywDi+5gBt1zIUJrIeB0mv9SYyHd+o7fZfBCdWSdPNn68h1A9wx8U2KW5ReHsweo8fpoRB15N18f6GbS1XQzUo+pLxP1C8ghk69RIvZDduFByMC0pg10Zhhj8HOF+D6PNm4zOfZr68RpNtjnwPW7uM+mxBqtZtzfKL2tz+oeZJJ6o2n1knHQNHAXcZUVAHk5xzlJWVEuxdDY/kI4fx+ZuNLQY1iYaO+anRzywsPnV69ZYONYRjwVyES3EWuGNi+3yVfrhFBm5S+ORomdwmKVx9LJKGai8ZkhMGFmASbj/DujhRDKzWSIUY+Ss3+cLomplMnTRq5iQiEky5U1WFUyHNdVMgZw+Wih6smMXv3Ps4/lkHKNA9zQLldw58g==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(10067099003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261021121427099003)(261021123027099003)(261009223027099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zvLN8khbDwLa7eL7j7eBXUDq4tnLrFL0I0g0gTzK8LpQnUk2r8dU69QQcKkc0nU7G9n7artah70OxD+hura9PsaVNMwmzWV4Bb6D7JaYLwWHIl/GNozqq2nkfZQstnyq8wqr8w2jbSvr/jaHoXcHdsRAOnuGM1BTh8ST6wei5d0TAI9UgHpSEiyKJQ9y80rWrSyqEbjfLa+T4TN6slHihRLmSHZv0FixPgbFLB5+B+XS7ieN1L5/33nGiGlTHcblKE0lcsLedX4SYG/6N7FmP4Smza8CM/bPNKTdusJrg+QK2Kv5AW4ScI2vtck9XgzeM3kCppb7KDsNjfK/Ra7d6sKtIt+nwVSkpYLRbc6TsZVloF6STgTO5wRSQwnayYLGYO/4sDakS/p83Ywu96PU6MTOrBtngBH88t9uNwm3oBYEnatcL8DBlzGIucjHpAOe
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:18:55.0614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23512222-1134-4029-8099-08df3bf7bea7
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF0000051D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6822
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

GPIOF_PROTECTED flag identifies a GPIO which can't be used because it
has a protected access, this GPIO can only be accessed from the secure
world.

Add a test and support for GPIO sandbox.

Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/sandbox/include/asm/gpio.h |  3 ++-
 drivers/gpio/sandbox.c          | 16 ++++++++++++----
 test/dm/gpio.c                  |  5 +++++
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/sandbox/include/asm/gpio.h b/arch/sandbox/include/asm/gpio.h
index 0dd4c7bf601..c5ff9e9cdd5 100644
--- a/arch/sandbox/include/asm/gpio.h
+++ b/arch/sandbox/include/asm/gpio.h
@@ -28,9 +28,10 @@
 #define GPIOD_EXT_DRIVEN	BIT(30)	/* external source is driven */
 #define GPIOD_EXT_PULL_UP	BIT(29)	/* GPIO has external pull-up */
 #define GPIOD_EXT_PULL_DOWN	BIT(28)	/* GPIO has external pull-down */
+#define GPIOD_EXT_PROTECTED	BIT(27)	/* GPIO is access protected */
 
 #define GPIOD_EXT_PULL		(BIT(28) | BIT(29))
-#define GPIOD_SANDBOX_MASK	GENMASK(31, 28)
+#define GPIOD_SANDBOX_MASK	GENMASK(31, 27)
 
 /**
  * Return the simulated value of a GPIO (used only in sandbox test code)
diff --git a/drivers/gpio/sandbox.c b/drivers/gpio/sandbox.c
index 76aff0ed5aa..2319b8854e1 100644
--- a/drivers/gpio/sandbox.c
+++ b/drivers/gpio/sandbox.c
@@ -191,6 +191,8 @@ static int sb_gpio_set_value(struct udevice *dev, unsigned offset, int value)
 
 static int sb_gpio_get_function(struct udevice *dev, unsigned offset)
 {
+	if (get_gpio_flag(dev, offset, GPIOD_EXT_PROTECTED))
+		return GPIOF_PROTECTED;
 	if (get_gpio_flag(dev, offset, GPIOD_IS_OUT))
 		return GPIOF_OUTPUT;
 	if (get_gpio_flag(dev, offset, GPIOD_IS_IN))
@@ -198,7 +200,7 @@ static int sb_gpio_get_function(struct udevice *dev, unsigned offset)
 	if (get_gpio_flag(dev, offset, GPIOD_IS_AF))
 		return GPIOF_FUNC;
 
-	return GPIOF_INPUT; /*GPIO is not configurated */
+	return GPIOF_INPUT; /* GPIO is not configured */
 }
 
 static int sb_gpio_xlate(struct udevice *dev, struct gpio_desc *desc,
@@ -528,6 +530,14 @@ static int sb_pinctrl_get_pin_muxing(struct udevice *dev,
 	unsigned int gpio_idx;
 	ulong flags;
 	int function;
+	static const char * const gpio_function[GPIOF_COUNT] = {
+		"input",
+		"output",
+		"unused",
+		"unknown",
+		"func",
+		"protected",
+	};
 
 	/* look up for the bank which owns the requested pin */
 	gpio_dev = sb_pinctrl_get_gpio_dev(dev, selector, &gpio_idx);
@@ -536,9 +546,7 @@ static int sb_pinctrl_get_pin_muxing(struct udevice *dev,
 	} else {
 		function = sb_gpio_get_function(gpio_dev, gpio_idx);
 		flags = *get_gpio_flags(gpio_dev, gpio_idx);
-
-		snprintf(buf, size, "gpio %s %s",
-			 function == GPIOF_OUTPUT ? "output" : "input",
+		snprintf(buf, size, "gpio %s %s", gpio_function[function],
 			 get_flags_string(flags));
 	}
 
diff --git a/test/dm/gpio.c b/test/dm/gpio.c
index 2401c5ed1be..a28c93ec544 100644
--- a/test/dm/gpio.c
+++ b/test/dm/gpio.c
@@ -112,6 +112,11 @@ static int dm_test_gpio(struct unit_test_state *uts)
 	ut_asserteq_str("a", name);
 	ut_asserteq(25, offset_count);
 
+	/* Flag a pin as protected, and check its status */
+	ut_assertok(gpio_lookup_name("a1", &dev, &offset, &gpio));
+	sandbox_gpio_set_flags(dev, 1, GPIOD_EXT_PROTECTED);
+	ut_asserteq(GPIOF_PROTECTED, gpio_get_raw_function(dev, 1, NULL));
+
 	/* add gpio hog tests */
 	ut_assertok(gpio_hog_lookup_name("hog_input_active_low", &desc));
 	ut_asserteq(GPIOD_IS_IN | GPIOD_ACTIVE_LOW, desc->flags);

-- 
2.43.0


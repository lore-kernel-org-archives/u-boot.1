Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC9DC624D4
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 08:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E8BD80F4F;
	Wed,  2 Sep 2026 08:53:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 65rrx-UmChf6; Wed,  2 Sep 2026 08:53:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788339221;
	bh=Ki9Zo/sSS49EOJ2DLIsNmG2k94TMhmqGs1YVTbmXrdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZN8UrrB8hCpgjfJAvSGR46CtsQkuln4tUmCEfWiWeNctpIsH5DBk9X63xLmKyqjLs
	 rTFH75l8OD//Osua6T5dkzQtifOR7E1jP822VQxcOFfKDq+mSH9fZpQRYkwWILVqTh
	 Txs9ddHaee8lFjNz3Hz4xP7w54oZtbAwPRHGN42sitFXICW6dfsDCb5kaflXaXHgTh
	 ULz6nUS1fxMnu3XVxChSyQnPsYcpt7fh8nmEmv01NRwnvi3Dw4ptay65Q2rZJJRG5G
	 irfa6nfEwn9GSX3qbxUQhTbFLltL6fXqE4udgkE9KSxmgO5Cd2ebu9Max5cwowmDSw
	 UC4kIy5NmhyMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01E3880F52;
	Wed,  2 Sep 2026 08:53:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EEB262FC
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D45E34031A
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oR6k0rYX-MuC for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 08:53:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=3I2j7zYD
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C3F6D4031F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owqkq7LjjYJ37HQSQv5uMMIvj3W8f5a76pqHh/RoAPy2X35ml2vLypIR7CbAzS85M6IYbW4pjvlVn5BbeHGTbvyEtjs/vA9xMKElQYDHH7bmGm1J8oNGvLFlQX9zdKC9y48pV2xVf9DVmjnmH2uWWuBji23msBp7aD71Pho0AAxw5nPKN2SyFAL4QG37zCcoXTrvvmO1MGkuwlDR7XqrZLBLZcCOY2vBnNEyYDLDbi+cqU98aelOP1xfTUox8hBgYbQAp7OEAlW3lI61NgZkVtAUXi4inkcRJ60UUboBAU1kT8sYeO9aJa6epbINSLahKm32k1SuDkp1yokZLx+vdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ki9Zo/sSS49EOJ2DLIsNmG2k94TMhmqGs1YVTbmXrdw=;
 b=guPbhUJHZLZFRBWC09g3s+hHYFJ7GPvgWBFUFQhqRlyRPMbu6TZ/oUQpA8B8LO8nbxjKkMEdMF9dDY0tzpiCLEra7/Bj9ODhMt7o+GPk+SVhpz0Q8mIhskaN329wtUr6ixhwP4m1hqjL/qNaGBKj7hMqZfZTBdJcJAwR13/gMNkev0koW/F0My5VplobMJdXyGHDNflfK/dF9WNot/gE4yFOUd77RZowzSPYDt6HtwAf2xSi2LHtzNYTRjR726Tc40zdk66amtioFLw9DheHf9nL+d3DvtjBNbxc7l/uioA/9D/xkR1u1u8GMVefaYZH0iBLzzWxVLJEsZyHBNoA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ki9Zo/sSS49EOJ2DLIsNmG2k94TMhmqGs1YVTbmXrdw=;
 b=3I2j7zYDEbP43ohBWmF/EMMZJrh++d367nOk4Fk5tg2g/3jqi5hip8qUpKodkq6Rf9hVECdys7aF4hxwIyttZt7oo7FweNlljgg6FNAvc5tsaFyLQcplnK9ESz0hR0hm+pPWhqZ7sLUUCRvjRApHThxNZfAQSiboybvuU39KymQsWZUh6EIuS6xLa4fBWB1sceHNEKoOJd1QeZUUHGruNhhWLlPwAo+QzIHq//wsPUY5kVHfT34+iSv8Pf8CB6COuu+ZRy+lylnY8AJ2jZPjj5jFZpUeFSOCnUNC+bWQfIySv+TMipzjDkcDEnBDMjgQs0FEK6v+IwTX1WO8OjenSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB11739.eurprd08.prod.outlook.com (2603:10a6:150:327::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 08:53:27 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 08:53:27 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 02/16] arm: airoha: introduce AN7583 helpers to get SCU and
 CHIP_SCU regmaps
Date: Wed,  2 Sep 2026 11:52:57 +0300
Message-ID: <20260902085311.1550804-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902085311.1550804-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260902085311.1550804-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0077.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB11739:EE_
X-MS-Office365-Filtering-Correlation-Id: f725f5eb-277b-4aba-0493-08df08cfa741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|52116014|1800799024|23010399003|10067099003|11063799006|56012099006|921020|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: m6BW/AbFoA2/WLoCbUWr2f5wHLK9rpSQnLs/Mrmt/2UAci4bcEFVoAwRzERUBCHSABgsyuXAHWWPTZiUxcaorej9zOh3jh4TthJS0BZjQP705XFjJKKN/ifPTbmj+CzXWSW5rks+5uL+B94nma7oXXg7pVxVosV0tQ7QX1FazIXelrfjOS0faS699bGMuUrXl7FyfB0db9zTJBHbkq9IFp3nrROuvSZSA3AvV1Spg408X/FZL7AL576b15tLUo3ucztnyzdOrdN8XQ6xyln9pIVYhm9kbWmsCWujbjt/8NWVYPZkINcqn0GUZOsVHdzKpHxj2r59iFTIScML1ERr7Dd0tUEwnrn1w2hwcfMElbKSo1AlKQY5xcW/GizMXKRNBwcxobYVtJxZ6hMnRFycBw9nxhGOqyBfZlB2lAO+paKD7C3dJzKGXNAhQ5XLUz7Lit22m9T6pgrE3TPO138AZw0i8irhxf+SqzKmBTQYE+Zno71VNTIwep1UK7rbgGPEKmZYxS/LqkyHLbQP2+eag2FckTvgkIwPSdq1nX6dhn79gaigswXHc0JQd4fmXngXmHQUN24JFeEKV6gDDFOatKXazyPZHvcO4CVMZacGbVzs5qOj3uV2Mc92adHjGlYGc0vJuVNCYsxDx6I3jRuYyPQtnLUDt4wYrWGOp773UK9SR3WG/1adLabxD0Fax/WgJhZgxMgWIevFxymsGxk1wmetyQtuU/87R4f+9iaOaXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(921020)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B76vV1+55gorR5uTTd4zqtHs5fPJI8V7stv0yd+7/e4LjMVqeZgvMf1EM4ur?=
 =?us-ascii?Q?ev/jJ0RIVesCDr7ZgYz1poby273BzwFQ+DKwSqDUJiDjjjujej/BMF6KseQM?=
 =?us-ascii?Q?ErttWnXRuglkT5Kyla1S9tiEXSIMzYwnqwE3wpgwvpJICk6ZL6+F7eGQBvnc?=
 =?us-ascii?Q?MzwTT0cTJ4AM5q1PA2svpicCEfdL4//zYHgfxaLdVqCjiljVNDIWeWeXc6W3?=
 =?us-ascii?Q?+ZcINFb0/Xm77t2Ev3hs2xbr3iC9N1wU0JKBKLqwW63T1hEANqQKYVxbEunu?=
 =?us-ascii?Q?jctWP2S31GoNxm/3BT18A7MfUtRqwZrKrHOdpB/vnpQpxia3XAEZ3MotXkCK?=
 =?us-ascii?Q?uJ3F+IOEsE7P9e9endGnVhvkP8UGiAOTsJZUiaBSSXjlKX5m6WhSdWDmcdcG?=
 =?us-ascii?Q?JAga6IarXFv0xiVqHWafmryrLV+5K/D68Ov9DN5FKz4KYrK0EqdtPdD38/eg?=
 =?us-ascii?Q?LTqozP5yw9PsgC3lDR+uK2OZFQDMNCelpMZhAySwg4Nb/c87X8gmtcOYHgVO?=
 =?us-ascii?Q?u4jK0UsyiNxPIf5Lea9EflS3VpQbYYcRELp0Qceu8cuynb5vaai+N7a3a+jA?=
 =?us-ascii?Q?GJB82ykuGgaA2/bTLRGx3f75zfa7Og63p1PkDU0yD7TKlXCAzoEdaeeNsi14?=
 =?us-ascii?Q?9J+p/9esf976qxoryjNiEEHzsOmYnDBhCMS38BUJFQWQps/iR9ooRIuiMQNt?=
 =?us-ascii?Q?y0xjeuIeost2lWihTNgtiuSyNs36Q5y5bY5mc8J20esADGla4WjE/2ORKyAL?=
 =?us-ascii?Q?k65SBzNfG9gqzQ6HveaKLHfhigjxGtzfSmrSvNeui1P3yyYkH3fZxWhz8dDW?=
 =?us-ascii?Q?MPwU8R254xfTmqZYUYkdCUBHOWFcXJcGTst76p0z6BPSWbJiWdT2ABAW0MaD?=
 =?us-ascii?Q?50V4VwsPirwwtGDhpffFMmK1Mouds5V3BF9Tg0GnxJJpD94RRqyk2lVth+bb?=
 =?us-ascii?Q?6yCPH3QOne/zD4kzZuwLunpBI7+CTKEeWSvB2zVogDACBNpgFsu/VwfeYlc8?=
 =?us-ascii?Q?XVbBOqbrd68/f1cavlxnUymsUvuHRQndx1RKmFSPPDaiGwU2HqjaH4BkECDk?=
 =?us-ascii?Q?gWokcwD23PsxjLBcWzdl0SsbrWlVrCCdHz38Y1ewlCQw8IuHj87WyF7wFIJI?=
 =?us-ascii?Q?Iunew0ZFlNbkeHz4TW26cKAIMrzELkhRCpzY+3mFNWsOb3hs1ZRdfczmSlLZ?=
 =?us-ascii?Q?ICeJ/j7jAC/EB24WQr3JvHNWsPeBT+JdryKKY/nP/ArT9NY/bAEhhqSjf07X?=
 =?us-ascii?Q?KEBaEHnwHdZURih/X83iv6p6bl+sDvs9tyHtnZt7ddeGwBWo+HS4t+SPMwcS?=
 =?us-ascii?Q?9tvhakWXdg0XViDXeO6r1KiaXiJLVDs6skPMlGZ11XKH1RWu0pWJs9AAmmA6?=
 =?us-ascii?Q?e6tSC/O/qagMn5fEaEu6aXvUhHFXxjbHH3chtqXv7CnYonNZRSPIOUZ8VpYD?=
 =?us-ascii?Q?KDRrPuNOQnzxWOAwmAf990AJE0FjE3hhYfyueVBU/DU+g3X9YEXbuTVVCQrE?=
 =?us-ascii?Q?X8s/btHZSB3dLJnVaqvdxDbqeHQx8H7IP4UfQy88qSrGJexeRGdtYtE44fqv?=
 =?us-ascii?Q?YIM3B2q5aJSNC5Hjux8rIsRltczJKq6lM7N1M0809IIiCU0vJNNYl0kyHcZu?=
 =?us-ascii?Q?JMZmVGXIyXKpCGShlc1gLTA8U8vuPYyU5vq4+g/6scQlSyu/5t0EXdgQrFde?=
 =?us-ascii?Q?ZI0gtwcQAjtgo6cge3gfONP13pl7GlLPU8Hp5YNECJHSVekQwuzyVQXIe++v?=
 =?us-ascii?Q?CbulUCvv5Y5sXFK2Xfp/ravtcmWYbcg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f725f5eb-277b-4aba-0493-08df08cfa741
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:53:26.9503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2jfQsYVziTO00RZ1Dn6aParRKQyZhImM7vE8aI9PpS2gHxuX+1yDzrsdH5KiBLzB4Gb916sqKNq/Yo0PZrsC5hda3/Uj9Ohd28jmCl8xQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11739
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

We need access SCU and CHIP_SCU regmaps in several places (clk-airoha,
reset-airoha, airoha_eth). Unfortunately these regmaps can't be easily
retrieved with a common code, because of different Airoha SoCs uses
a different dts structure.

To make life easy we can write a commonly named SoC specific helpers
for these tasks. This patch implements helpers for Airoha AN7583 SoC.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/include/asm/arch-an7583         |  1 +
 arch/arm/mach-airoha/an7583/Makefile     |  1 +
 arch/arm/mach-airoha/an7583/scu-regmap.c | 34 ++++++++++++++++++++++++
 3 files changed, 36 insertions(+)
 create mode 120000 arch/arm/include/asm/arch-an7583
 create mode 100644 arch/arm/mach-airoha/an7583/scu-regmap.c

diff --git a/arch/arm/include/asm/arch-an7583 b/arch/arm/include/asm/arch-an7583
new file mode 120000
index 00000000000..d2317ed3bc3
--- /dev/null
+++ b/arch/arm/include/asm/arch-an7583
@@ -0,0 +1 @@
+arch-airoha
\ No newline at end of file
diff --git a/arch/arm/mach-airoha/an7583/Makefile b/arch/arm/mach-airoha/an7583/Makefile
index 886ab7e4eb9..51f978aa101 100644
--- a/arch/arm/mach-airoha/an7583/Makefile
+++ b/arch/arm/mach-airoha/an7583/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier:	GPL-2.0
 
 obj-y += init.o
+obj-y += scu-regmap.o
diff --git a/arch/arm/mach-airoha/an7583/scu-regmap.c b/arch/arm/mach-airoha/an7583/scu-regmap.c
new file mode 100644
index 00000000000..96f3564eec0
--- /dev/null
+++ b/arch/arm/mach-airoha/an7583/scu-regmap.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <syscon.h>
+#include <linux/err.h>
+#include <asm/arch/scu-regmap.h>
+
+struct regmap *airoha_get_scu_regmap(void)
+{
+	ofnode node;
+
+	node = ofnode_by_compatible(ofnode_null(), "airoha,an7583-scu");
+	if (!ofnode_valid(node))
+		return ERR_PTR(-EINVAL);
+
+	node = ofnode_get_parent(node);
+	if (!ofnode_valid(node))
+		return ERR_PTR(-EINVAL);
+
+	return syscon_node_to_regmap(node);
+}
+
+struct regmap *airoha_get_chip_scu_regmap(void)
+{
+	ofnode node;
+
+	node = ofnode_by_compatible(ofnode_null(), "airoha,en7581-chip-scu");
+	if (!ofnode_valid(node))
+		return ERR_PTR(-EINVAL);
+
+	return syscon_node_to_regmap(node);
+}
-- 
2.53.0


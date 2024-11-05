Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29E3D1CA15
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 03:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC30588FA0;
	Tue,  5 Nov 2024 04:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8609988F9F; Tue,  5 Nov 2024 04:45:11 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2070d.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::70d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5100688FC5
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 04:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjEPtSCWUIIn+kRefoDbNULhDWmNTlRwPqi2aMVBnxBimP1ni+kZ9Ee93jj+ou3wBoYwu0799Apj1TOXhtFwn8FkrkytEz7GSvktx/4FwlNJWb/NekXjQQscpXkFWyVquhfEtnbZvzb1pCsm6GhQlD63CoU1ZITz+h6mTH8RMKbcF1Mq6JRBbtx8j4Gkbsfuo4ObmhVo8hDrL8c6M9dFxItnKGHVykC0VyScGJxTqOX9LoVq1+hIL6DGwz8xOBIFrZUSR2wDBcWYRvOyNdRlfqTqHNmN62qwiIgLJw3ZjBArYfQIlJJT/lFO5rPHB+ZXcgibNzJ83uZne88kSgZRzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZ9RhRsTvtO71MUEJ8KRLxcm+/AQk7o/5IxurPSVmgs=;
 b=VaoHBkN9qBYrAH2xuOjlmX5fvGXuO+IX/KGzHbc/yKgAJNVGKLGLJk4wXPzutkhfbqFKd8SKPU/88++nOGdXFRWiRLxcVBhCMjdj7+aRd8cUH8n1yJVNnWIP0Nj/79oSVra5n3EknyyKxooUO+GkWfspbSb5x5Pd5pwnHYcU+dDIlXkhzwMLnZUv/ayb2qNSFH5VbKOsZOrFYXFrCyFpI+lIi09cnVQfYnjWQQ3pdlTGCAOGXvItHElgbEsAauEGgH1dBMkluktsJK3S23O5qSLdXz4MGCSVhwgduBdlYeaY1pSsz2qiyT89AWI0W81ioY+ri9PeyS1U6qBLxiquGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1242.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 03:45:17 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 03:45:17 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v3 13/13] board: starfive: spl: Support multiple DTBs for
 JH7110 based boards
Date: Tue,  5 Nov 2024 11:43:28 +0800
Message-ID: <20241105034328.56439-14-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241105034328.56439-1-hal.feng@starfivetech.com>
References: <20241105034328.56439-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1242:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e54b1f7-2fad-4b9d-9d86-08dcfd4c4358
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: AJZk4Iz5TFaL477VUPT++Hzb/dUS042e1zmSiUECJz+yNCbF745DSmzp2BrbYrXFVBnBpd2AehQLH4cnV/Uj/RL32P+270xLt4HPW/Oe1TxF6Urrk7mX3NDn6I61eOMqQsPCAUSzpyitJg+uKZA1U+Pif4IKEpPjBxndqafVjrWl2wtpw3ydfWRv12fiHZ+vxzRiagkPhTm+cgRl70VREK7EYIGN5E8/dIZh+dIBOc22VSd9mWlWz1ikK2qp5W5dwGxaHg3RmVZyepCXt6Nu5BLvPrJ8BMpaJso1hJqjB2ZP6vXOm00wGjZblz66LvtB6VpXQF7t/WW5vWWVhGUMbZbnNRvgZDU/hy6ZGa0gvkssk8Zs7Na7kFPfKDWMEvw6NHteUb037mIB9Lu2IHojdfKfOYJVtvRW6Erhm+YmHeZ2pI75itSMNtjixCvM8J2VDH03dYa+KXqoBNzHeAd6fkWms+PcynjKVaTyE7UsorArVGruq4OdwSIW7Pwcoov77hJuHksBGS8ZSBwoquVCB6SFxFkIg0188iZP4ZY+zGLBWoZLk36crAJP82Hg4igT9OcbsCNlVq87GzQVx/ZfzIAP0zrVwcskgv/NaNkafC+ldDOkIMcaaFa+hRAyFoSHVuFWAq4BR+mbrcn4smQCUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(41320700013)(7416014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0XQhWn3EwTVLOxsTLlfbDrnYAQaVF3c90TgPGwCFM7myREvkINbVJU/YRxWp?=
 =?us-ascii?Q?iY5zL9XzrGpYetFMr1WyaHheD3WBKM0soVjl8EJd6EsCH5EjZrXbxUTZxze7?=
 =?us-ascii?Q?5P8/77H6TbcKp/0te1HIVpWmL1G7tcg7FJ9dP4E3u1r9cdrOxvqN1IhB45tS?=
 =?us-ascii?Q?4vGdeMhNPYeifs5bM59KBm2I12zoP6KXKzU++fhXedTz/2ZIvmN8Tk6mImbr?=
 =?us-ascii?Q?yPbN+qTv0DSdtPDjth0v1Pl/Y5ONhzg19loTRPuC5YXJx8apSp3yNi/n4BGX?=
 =?us-ascii?Q?7M6b4sDx0YTsuHOxteZzwH1SDQa/6gJnBc6jSmZhrK5FM5VjCXmF7pgEhE6V?=
 =?us-ascii?Q?/fLEio7428n1EXym8QhlVdaQSfYV9bePKZ3gfWOnjSoRR4n186RzpB/qCBu/?=
 =?us-ascii?Q?GRkSUueDTpWSu3m8S7ExLFsbGuZZXRIWpR4w5z4kz0O/DLfKAFVMaPgUCoXr?=
 =?us-ascii?Q?nqfvKAVAy1+JRgTaldSmaK8TXFA1W/aNFrEVK19be0/YfzDAPt40vJMwrD7F?=
 =?us-ascii?Q?YwNHFO8Co0ZyaPeZpf025YiIlvHqW4WGSLBMNa2iFXeQg9oau2X7aRNpsFoK?=
 =?us-ascii?Q?JMyL47i9g7oFFt7xl7LoCEWtM8Czn+9HS5hCx4d2cbGz7zkO6kfu+RO2G6bF?=
 =?us-ascii?Q?5IdPxk17mAwrr075eASq16wD9o8zZHkMJFMSgBuzfskmhv5AF1Jv72N1bVrg?=
 =?us-ascii?Q?QLoRGNGq+J7oPEamxEtKO6vdOC3b5FvaoYBw1//FIJeWRs2wjlK/kewSFJwK?=
 =?us-ascii?Q?8XtnuUOKqkuMgZnDLBgUWg7qSRphW0xnc1BV4FegfEUVsE0bcQX5rU5AtM7u?=
 =?us-ascii?Q?6GGVtiFAnqiasKeH6mGwT4KakgEIjovl0ym52VwVDqRY95EdeWF8r278oLei?=
 =?us-ascii?Q?P1XJE/P3JU9I96IgFwaCnnWOdOEnZqhheaSjbSlMazhK5HeCcuMimxei10Va?=
 =?us-ascii?Q?rUrCS/uh/wAN6Bh8RldtdTk7Sw5NZBBB0BC2xdNpfgHGcPnkV3/a80IVhPbJ?=
 =?us-ascii?Q?xjvqTVeJ2Avksmo87q4hoR9qsqDh/z99KArS/7KCulyCZCIPHS6/YjD6fzwK?=
 =?us-ascii?Q?LgrIRxsL8TMb887TN7HJbYK1Z39+wZ0DesPiK6UNAEZZ0dfoy8lR1Lm8BSHP?=
 =?us-ascii?Q?5wI9TPocUvmo29mXDaMudq6HOV09RLmC5WPpQa6Pl6HdPhvDDz/ajikkGJU0?=
 =?us-ascii?Q?w7VBeVUkF1Z4+I80YAnneG+SHDW245IdDx7U3xoLDYKzTzYOJ4XubNZDHLZI?=
 =?us-ascii?Q?ucKASRfEMZMg4GAANmpWcUsNULNPZx2AJTCwfWPqZIUKZMtxpq6cKOZ13EDt?=
 =?us-ascii?Q?/L+pwXkEcKGmT7SfANHrTQMDKGXsR7/dMu24jJSJ3YS8bD9WaAeceWuynRyk?=
 =?us-ascii?Q?yC3tcNFhaFJgQTx+e//5noNLV9jFKeSIOKexmfnz6tbI1CVEHzhFUA1s3geh?=
 =?us-ascii?Q?tanTCsVaDrhfj5lCivqyfJynYelQuEowitkkzNJrRZFCdEYA2/i3bg93fnre?=
 =?us-ascii?Q?MtQGIGCFvQ4Dc9VNbWD5J509+BUZ7uYbk7MqzRlaWPj7Q7QFVd2fBR4s1+lw?=
 =?us-ascii?Q?bUtXN7Ysjd7/L2hLZF8MlOvl+tbLjP+Ke3leAvg3CeqsgWWVV8emnKuOfDJH?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e54b1f7-2fad-4b9d-9d86-08dcfd4c4358
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 03:45:17.0367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uuKEPfTqVds+QX9jANP7SIOleQmL4WH1mzZUmNKfgkQfK8cDF2e/ub2ilwdo6CRsabxkRX+CsGy0Ipt+Au7Y78SzF08WhNyhATLfQE79SE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1242
X-Mailman-Approved-At: Tue, 05 Nov 2024 04:45:33 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Get product ID and PCB version from EEPROM, use them to select
the correct DTB.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/spl.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index cf7f39d5c5..4396583026 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -113,7 +113,28 @@ void board_init_f(ulong dummy)
 #if CONFIG_IS_ENABLED(LOAD_FIT)
 int board_fit_config_name_match(const char *name)
 {
-	/* boot using first FIT config */
-	return 0;
+	const char *product_id;
+	u8 version;
+
+	product_id = get_product_id_from_eeprom();
+
+	if (!strncmp(product_id, "VF7110", 6)) {
+		version = get_pcb_revision_from_eeprom();
+		if ((version == 'b' || version == 'B') &&
+		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.3b"))
+			return 0;
+
+		if ((version == 'a' || version == 'A') &&
+		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.2a"))
+			return 0;
+	} else if (!strncmp(product_id, "MARS", 4) &&
+		   !strcmp(name, "jh7110-milkv-mars")) {
+		return 0;
+	}  else if (!strncmp(product_id, "STAR64", 6) &&
+		    !strcmp(name, "jh7110-pine64-star64")) {
+		return 0;
+	}
+
+	return -EINVAL;
 }
 #endif
-- 
2.43.2


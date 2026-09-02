Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3B0C624D0
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 08:53:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6D7360874;
	Wed,  2 Sep 2026 08:53:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mMcaFVEQlsUH; Wed,  2 Sep 2026 08:53:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788339229;
	bh=verjvkNO1FIKP9AkL4x7HfiXfVmaII1PYPquNIYquIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XqmXWH9mWpfmsHkK+DZ6/NPgBAk0yuj1reMEh+J4vBs8RFMIGAcInXe/AVHC3AlAV
	 ENOGj+8DYG1WaSDQNDM4hD6vAhC/WfThSmAlmZegFKoK+oPSBbJI8avAbcDXgPo8wT
	 LzYa4UvxBW4kkN8xQ9lGOR2j1Azh5v6ZpikgOB3xHCpGf7asszH3Rf34Ekwt1g6LqE
	 l+D4djKrdVBCNnFWt/Ald4JVCEMFI1Af9THTd4hbDhtPWHCBe3Am0tzFo8eBCvfTXd
	 3+rC/DC/hR4uqez5OCAQn3quDbWowI5SOo7+bB1pdCVOmW3DfqFeKvmBkCQ6Ac4rO9
	 Orcrj/YrVb/rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59B106086A;
	Wed,  2 Sep 2026 08:53:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 607592FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 530BE40310
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vHGvy4zHWmqk for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 08:53:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=XwjaANXt
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7A0DC4031A
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWPDp2CTixmN3/MoZxn05IjpLELPIVAj3XbWDZJoGxH7mR+oGs2jf0Ozs+UNVdkHlGp/H6uJ2nOvKI7TH5HVuW7bw/CVmApFg2YWdteQsuPUSp8okPtsoPjFExT2r9vlxPI0CTBO55rPJGXnkXXJ0HN3R6nCEbwWBOFIqQBpqmf9vGue4wNa0B6Hg/4e14T5HkaMfcPHwAaVg++wDrIL4kCOjSnxy9MU8cjtm3SJ5XwWcYPb58VbAV1ayh3PElOWh/tsZazhcKP0dm6ThpfNK4iF4K3DDuqTDRf1ovQ7T7OEY/XbtKTUV0Fz6kO5CqJltD94dNx8pwmMnFyDeQC6mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=verjvkNO1FIKP9AkL4x7HfiXfVmaII1PYPquNIYquIk=;
 b=RyFcFeRK2ptF/aqZg/CnN08hJz8KdREBPk2QZUXgV4QtWQGyBOiC3aoPdLa+8UZAF+irOBdQPB0v6yqdxSROCERlx/OgCExXdhNSFw9x+UsWQV68ZyvbCLOnqIHx86bZW3ArBayUViguf1yns3vg7qm+meGegKN0pYbCiI0LoKRihxd60QWvKuHglPZUz5FQLxhCyIXw53CIc0OwQEEsDmJakaYSiiyakqRVsOI3qERRZi/yxYtnq5hg8GQPQuQeAqd8AJYR+5DAR5cQmpEdxzLW0lgjMyOMBuj/B58PKgoESE7FlrRN5aQpKWq9oTqGEP+Ruw5kVtdplr0JpL+L6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=verjvkNO1FIKP9AkL4x7HfiXfVmaII1PYPquNIYquIk=;
 b=XwjaANXtd8uJ6u5LosZNNXD9cZmQWkBj9WnWmHeYGppghh28DWlSeGzJbMOpgFOnZOg00GJSCxsjL7AOmn0LfMhtXwp8N+V71KRwgcS/g8iRT75iIbR5NFNZLND6vQ4foUD5f40r242fgZKpZgS7ynW9R+kqIjBVgnXcMViJUbTtLdEP08x2TLvz8c04JKX4rlQ+plxYh64PmgpkM2MACP0nXHpQeV3NSK8tgcyOaKfqNfZs2UHhNh0x7iZmVJkV5+m6xJUcqNNtubKTtbw9ju1Zh17f613bVPWhqvcYkr5s03P9UgwH1T2Vz0VqEjF26ZXaatrrN4QvB1UjJnxq/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB11739.eurprd08.prod.outlook.com (2603:10a6:150:327::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 08:53:35 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 08:53:35 +0000
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
Subject: [PATCH v2 05/16] reset: airoha: Add support for Airoha AN7583 reset
Date: Wed,  2 Sep 2026 11:53:00 +0300
Message-ID: <20260902085311.1550804-6-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 10596ebc-3ccb-4067-2f8b-08df08cfac03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|52116014|1800799024|23010399003|10067099003|11063799006|56012099006|921020|6133799003|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SvZE1qWBLI1AGQOxwI/t66mMF0iq25GH5/GhGKfw1EabJyE/1mjNaP1kPgutxRt33cASI/blyxyym0Tk8nriZLdjdQYN/aa23Hfholt1Ga4lqCUfKj2AQ8ouzF5ZIKCmSKhXtJD5ZfVToMPcjlVFZ7h8UCFffAMjkJZvkydE0lQDZCSXFwQMjcLtSmVyR4jJqnXMkUhwaZWAJaevZIhrUJ59Cy566EuHPAeHfXSxz2ERuQKZHTCzDlIHHWPdIXWezf3ATk3Nkvy8UUsiGpUVyP1d80vtaxHrVAUAwphic+cSTFcInp6bAIzULrwTUdkhtqgjCJsw06FHq6sJNzbUoQMZWMI6pD0E30Gtl6M2/WzEEE1ah9lIWKo6wX6r9mOT6fdXODAsfgyvak4Em13g6u94sa68e4nXF89GEatEiVjz2fkpIUOnkyCGm0maDxmqUEDswriEbgjajCU8Bt2vUhLecht7kdZjS+CbLD28VbCp2ck56c+g4W9Cs/2uEQMfDp56cajy9e7RkZeSJ0I4yjr4ydckFad2LLXd6n98XeJFGWwANPtSOIoELKiPv1j5XJYcgDReeR/QMlo5sxANiC9gI0q1s7cOfWcazw3Y0VdFFPW3jzQA0O9Qbk2HcWxb/chq0KzMUOofYgfiJ/7OGKBn2rZ0gTqM1gcoq8Mq1OmbT/faKER4w4ASsBNPh+vAeLHKx8fum3yGsdHTy4j7rjee3Y8I24lHM/8vs3GvbOiS6kcZNUT3IsLKrx0XFkD4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(921020)(6133799003)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3rXYept4otpeR4ob2/AbMBtGwmjWkVI1yb/EhtYTAIPD/At02HKrzxmp99Fd?=
 =?us-ascii?Q?xKITJC/Uh2CJYPkU+Nkqdz+Q45bMvkpZ5IqPxMBLJIIwnunIDVeFjSJF+hYi?=
 =?us-ascii?Q?S6KLlDpybO+byjrWPIPijA5lBldGOh3LhBTNebR0xCUkdibZX2Vdz6TeBSsV?=
 =?us-ascii?Q?Z91lQhd/3WZe6XdWWCpyZRWoQA84aeTvC8XyXuhxCQX/cnjyr3VXkkSBCCiX?=
 =?us-ascii?Q?Pks5qn2uiwYjfvd+BxE1VdE6zKj7N/UT1YZLovq2eVfyq8SFyWPVQwAgHcdm?=
 =?us-ascii?Q?OTIM8Ct3kwfRqnuPbC9PxUWH8bCpEQNEzTMOOz/2ks5rpgD4EBlTUZKCXG0I?=
 =?us-ascii?Q?fJQGna6ducoN+kgLEyRVeab7lAsLyPaApAjwTAUNWevgchEwaRsRTe9MCgnY?=
 =?us-ascii?Q?SBN0BPZXIUjk5Y/vdncn6J/tIdc9XP5RBEUZBCRnGRAkj/EgsYljF3UVwrdU?=
 =?us-ascii?Q?f0rhfi+aaKoXkkp+7Hw2kJju1MBicGkqeXKXfOT0ptR9NJPWlO9PY6Plfcu5?=
 =?us-ascii?Q?0J4Ab+sg6/gndn+ULD15Xoaz9ILCwe5ON0em09JOkotA2CpM1sFpp2JLeJkr?=
 =?us-ascii?Q?YSkKOatpbfpKw7KXJwHfQoG8hjA/Hf6rAto1U08hKR9rHWZl2T7cqMavg406?=
 =?us-ascii?Q?LWIFXG7/a1Fv25bJGLAf+UNuXYg50YPwU4m9k0ELvX0PC7gVVcVIW1/VobFs?=
 =?us-ascii?Q?PAel9ozbnx6yfzwW7uqr44hSRakhzIjURlXT6KpxjpQmAzFAaoEzHn2FmqZd?=
 =?us-ascii?Q?ayuIQygabDer91mAv6AE48kiDELGqjNnRjnNBG6m/6PROw+QmrLnY84GSr2y?=
 =?us-ascii?Q?W+mTca+jHb9joaVaTfth3IrvkEIun1Sxy4eHaKQPhrB6yVka0AuJkcMuAuoi?=
 =?us-ascii?Q?DQkMRAvSJHdO+xHOulVuwWeRbb1NDcgrItKGliJiQWazipWtFBCqTlS4/QrX?=
 =?us-ascii?Q?ZkFpX9OtYQ1UUCRBZ/2QqHMyCNJZ3jfayjgDw+j+v3wU43KRGsYQkcKEFPrv?=
 =?us-ascii?Q?ptAt39dhAalK9WsvVEpjt8P+/6oMCb0nSuYC0NNcnZ56BDhAeYxlK4c+JSea?=
 =?us-ascii?Q?2DxsJ2fue5QQDxnphGqm6H4RnRMI7ixeMIIdkgdQUOxARVYTbf+HTXBmTu3q?=
 =?us-ascii?Q?clrcErY7L+93YNsAegl43U755ZKsTKvU6ajSBm3xpUfmyUALb1K6XzoWPF2E?=
 =?us-ascii?Q?4wkdsO78Qc4R/Z4tUdo2EBrzq/C0Cy5woRLa0R7BIwlCEXaBOn3OerwguT9u?=
 =?us-ascii?Q?x/c2iTYeBIBuIijUsvz2zG45ZAHU6LjRmdrpdzXmucQHgjc857QdJPxcaUXr?=
 =?us-ascii?Q?kT+sFGFYPv9LrmQ7yEDpkGELjx437GSixGVTgreElxmmgPQpW7ItdGZoHXOs?=
 =?us-ascii?Q?q2gpbLHcF7h2OvPPV7nUD8OeKY2RpK3kDtS43OQrUd4zeDFPDb2UGqiZPXCO?=
 =?us-ascii?Q?xddvg+MeKkus1KAXDdtsqbl/l7jjaskHXE0/zHjbSFQ//Ms2kY2R7lxIb1AF?=
 =?us-ascii?Q?QDessBSi51hYESGS7GL2wQjtmK0/QEw8pl/THbR7jFj+8j1aP0ApZyi50FY+?=
 =?us-ascii?Q?ZHvjGHc6eMJoec/4IwcG1USIa1CTSHkywD8Xxiqr8idB7QvrkENfDpn+2Otm?=
 =?us-ascii?Q?JNVRTY0c+STM01YNSm3vfCJBWzn2uRzYPZmhBIghE96KfDYnP/1jT5f+o7ts?=
 =?us-ascii?Q?lfSEkNjwASq2PUF670KSHjltMBGtlMgjv4rS1hRRatPjhMJz3Dc3QCmsbqRN?=
 =?us-ascii?Q?F9FJh5cFHCnDJZglhK9aQM/AOgv27dQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 10596ebc-3ccb-4067-2f8b-08df08cfac03
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:53:34.9242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmPz1MBRf5/5GWOXTfDbj/YVmcpn5SOWSvN7hBRbmJYi8mImk8/Jq56jBkiqpP8rLaREXb356MOMouDnYQcvb8skOWT+cLSVng2mmWMUTqM=
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

From: Christian Marangi <ansuelsmth@gmail.com>

Adapt the Airoha reset driver to support Airoha AN7583 node structure.
In AN7583 the register is exposed by the parent syscon hence a different
logic needs to be applied. Also the reset line differ from AN7581 hence
a dedicated table is needed.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/reset/reset-airoha.c                  | 60 ++++++++++++++++++
 .../dt-bindings/reset/airoha,an7583-reset.h   | 62 +++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 include/dt-bindings/reset/airoha,an7583-reset.h

diff --git a/drivers/reset/reset-airoha.c b/drivers/reset/reset-airoha.c
index ef8c47a067b..071f29b6f22 100644
--- a/drivers/reset/reset-airoha.c
+++ b/drivers/reset/reset-airoha.c
@@ -15,6 +15,7 @@
 
 #include <dt-bindings/reset/airoha,en7523-reset.h>
 #include <dt-bindings/reset/airoha,en7581-reset.h>
+#include <dt-bindings/reset/airoha,an7583-reset.h>
 
 #define RST_NR_PER_BANK			32
 
@@ -138,6 +139,60 @@ static const u16 en7581_rst_map[] = {
 	[EN7581_XPON_MAC_RST]		= RST_NR_PER_BANK + 31,
 };
 
+static const u16 an7583_rst_map[] = {
+	/* RST_CTRL2 */
+	[AN7583_XPON_PHY_RST]		= 0,
+	[AN7583_GPON_OLT_RST]		= 1,
+	[AN7583_CPU_TIMER2_RST]		= 2,
+	[AN7583_HSUART_RST]		= 3,
+	[AN7583_UART4_RST]		= 4,
+	[AN7583_UART5_RST]		= 5,
+	[AN7583_I2C2_RST]		= 6,
+	[AN7583_XSI_MAC_RST]		= 7,
+	[AN7583_XSI_PHY_RST]		= 8,
+	[AN7583_NPU_RST]		= 9,
+	[AN7583_TRNG_MSTART_RST]	= 12,
+	[AN7583_DUAL_HSI0_RST]		= 13,
+	[AN7583_DUAL_HSI1_RST]		= 14,
+	[AN7583_DUAL_HSI0_MAC_RST]	= 16,
+	[AN7583_DUAL_HSI1_MAC_RST]	= 17,
+	[AN7583_XPON_XFI_RST]		= 18,
+	[AN7583_WDMA_RST]		= 19,
+	[AN7583_WOE0_RST]		= 20,
+	[AN7583_HSDMA_RST]		= 22,
+	[AN7583_TDMA_RST]		= 24,
+	[AN7583_EMMC_RST]		= 25,
+	[AN7583_SOE_RST]		= 26,
+	[AN7583_XFP_MAC_RST]		= 28,
+	[AN7583_MDIO0]			= 30,
+	[AN7583_MDIO1]			= 31,
+	/* RST_CTRL1 */
+	[AN7583_PCM1_ZSI_ISI_RST]	= RST_NR_PER_BANK + 0,
+	[AN7583_FE_PDMA_RST]		= RST_NR_PER_BANK + 1,
+	[AN7583_FE_QDMA_RST]		= RST_NR_PER_BANK + 2,
+	[AN7583_PCM_SPIWP_RST]		= RST_NR_PER_BANK + 4,
+	[AN7583_CRYPTO_RST]		= RST_NR_PER_BANK + 6,
+	[AN7583_TIMER_RST]		= RST_NR_PER_BANK + 8,
+	[AN7583_PCM1_RST]		= RST_NR_PER_BANK + 11,
+	[AN7583_UART_RST]		= RST_NR_PER_BANK + 12,
+	[AN7583_GPIO_RST]		= RST_NR_PER_BANK + 13,
+	[AN7583_GDMA_RST]		= RST_NR_PER_BANK + 14,
+	[AN7583_I2C_MASTER_RST]		= RST_NR_PER_BANK + 16,
+	[AN7583_PCM2_ZSI_ISI_RST]	= RST_NR_PER_BANK + 17,
+	[AN7583_SFC_RST]		= RST_NR_PER_BANK + 18,
+	[AN7583_UART2_RST]		= RST_NR_PER_BANK + 19,
+	[AN7583_GDMP_RST]		= RST_NR_PER_BANK + 20,
+	[AN7583_FE_RST]			= RST_NR_PER_BANK + 21,
+	[AN7583_USB_HOST_P0_RST]	= RST_NR_PER_BANK + 22,
+	[AN7583_GSW_RST]		= RST_NR_PER_BANK + 23,
+	[AN7583_SFC2_PCM_RST]		= RST_NR_PER_BANK + 25,
+	[AN7583_PCIE0_RST]		= RST_NR_PER_BANK + 26,
+	[AN7583_PCIE1_RST]		= RST_NR_PER_BANK + 27,
+	[AN7583_CPU_TIMER_RST]		= RST_NR_PER_BANK + 28,
+	[AN7583_PCIE_HB_RST]		= RST_NR_PER_BANK + 29,
+	[AN7583_XPON_MAC_RST]		= RST_NR_PER_BANK + 31,
+};
+
 static int airoha_reset_update(struct airoha_reset_priv *priv,
 			       unsigned long id, bool assert)
 {
@@ -227,6 +282,11 @@ static int airoha_reset_probe(struct udevice *dev)
 		return reset_init(dev, en7581_rst_map,
 				  ARRAY_SIZE(en7581_rst_map));
 
+	if (ofnode_device_is_compatible(dev_ofnode(dev),
+					"airoha,an7583-scu"))
+		return reset_init(dev, an7583_rst_map,
+				 ARRAY_SIZE(an7583_rst_map));
+
 	return -ENODEV;
 }
 
diff --git a/include/dt-bindings/reset/airoha,an7583-reset.h b/include/dt-bindings/reset/airoha,an7583-reset.h
new file mode 100644
index 00000000000..be80d0e0bf5
--- /dev/null
+++ b/include/dt-bindings/reset/airoha,an7583-reset.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024 AIROHA Inc
+ * Author: Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_RESET_CONTROLLER_AIROHA_AN7583_H_
+#define __DT_BINDINGS_RESET_CONTROLLER_AIROHA_AN7583_H_
+
+/* RST_CTRL2 */
+#define AN7583_XPON_PHY_RST		 0
+#define AN7583_GPON_OLT_RST		 1
+#define AN7583_CPU_TIMER2_RST		 2
+#define AN7583_HSUART_RST		 3
+#define AN7583_UART4_RST		 4
+#define AN7583_UART5_RST		 5
+#define AN7583_I2C2_RST			 6
+#define AN7583_XSI_MAC_RST		 7
+#define AN7583_XSI_PHY_RST		 8
+#define AN7583_NPU_RST			 9
+#define AN7583_TRNG_MSTART_RST		10
+#define AN7583_DUAL_HSI0_RST		11
+#define AN7583_DUAL_HSI1_RST		12
+#define AN7583_DUAL_HSI0_MAC_RST	13
+#define AN7583_DUAL_HSI1_MAC_RST	14
+#define AN7583_XPON_XFI_RST     	15
+#define AN7583_WDMA_RST			16
+#define AN7583_WOE0_RST			17
+#define AN7583_HSDMA_RST		18
+#define AN7583_TDMA_RST			19
+#define AN7583_EMMC_RST			20
+#define AN7583_SOE_RST			21
+#define AN7583_XFP_MAC_RST		22
+#define AN7583_MDIO0                    23
+#define AN7583_MDIO1                    24
+/* RST_CTRL1 */
+#define AN7583_PCM1_ZSI_ISI_RST		25
+#define AN7583_FE_PDMA_RST		26
+#define AN7583_FE_QDMA_RST		27
+#define AN7583_PCM_SPIWP_RST		28
+#define AN7583_CRYPTO_RST		29
+#define AN7583_TIMER_RST		30
+#define AN7583_PCM1_RST			31
+#define AN7583_UART_RST			32
+#define AN7583_GPIO_RST			33
+#define AN7583_GDMA_RST			34
+#define AN7583_I2C_MASTER_RST		35
+#define AN7583_PCM2_ZSI_ISI_RST		36
+#define AN7583_SFC_RST			37
+#define AN7583_UART2_RST		38
+#define AN7583_GDMP_RST			39
+#define AN7583_FE_RST			40
+#define AN7583_USB_HOST_P0_RST		41
+#define AN7583_GSW_RST			42
+#define AN7583_SFC2_PCM_RST		43
+#define AN7583_PCIE0_RST		44
+#define AN7583_PCIE1_RST		45
+#define AN7583_CPU_TIMER_RST		46
+#define AN7583_PCIE_HB_RST		47
+#define AN7583_XPON_MAC_RST		48
+
+#endif /* __DT_BINDINGS_RESET_CONTROLLER_AIROHA_AN7583_H_ */
-- 
2.53.0


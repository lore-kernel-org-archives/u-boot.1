Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECB5606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OHGlzBIo;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=kNzWSMwi
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 837D860A54;
	Fri, 27 Nov 2026 16:57:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DzbJQEeJIB3T; Fri, 27 Nov 2026 16:57:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 714A060D94
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795798653;
	b=PydKxkyxUVcPTyeRkuligYOiBMGheRJcISw6v9zRdEZZGVI27K7QXiI5ao/sDh1UNzMr
	 lAoADG9Pu/uFf/F9BXK0ALTMnnD/jDQQASwWTN3/K9mOfqZSSeaHcv7TJOjvk3n3rjss5
	 nFo7ZDJx9cbD9D9At2ljWjD/aLSawF1J1xZRNNGBw7zA8mYH305gZrC/FDoyvPLtEtZCQ
	 94T2gPhC+H7YG9ocViWuXh22ItIMrGuL5jkZw/KsI0RY4WRayncbm/0LaVlMnUszZHzj/
	 IkYzQ0vjrz3Zmcbi4RnIEWfx8HdfQ7vfgzxIjy75TROc8deJPfiUphnraM/Ht3GD8XA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795798653;
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
	bh=yUTQ5Vr+q7+YXljm7NoI2dmOrbiI8d8yf6EE2sJO4CY=;
	b=Ztir3LvSt3WxIFdEGFtNrtgi8MJwD0buKogSjuv8wQ/eOxEylba1PItNzcwt63kIODWN
	 2YLK9EylU6SRonMViTyeMfEz3M5XGzBBaYGJeQ+dXTdffAlznW1Mfc/AxzjOSmtsbeipz
	 d8U1RIgJyxSic83+jN2ktvlAnspGeuiza7lsSpFFEDv7eCDzP1MyIgakkFptauFaeIBiY
	 +0zEHSHiep+JeJjIzmb1SsBuXjuZBP/J7SyfR4jEnJ7bF6T2THkw1HVbyc+bCBJAUabv/
	 6JLLSBMr0Y+//H7AXxS8gJu5uLEXuziTOaXuIhbrDg2q2r5HW3YX4RJqsasDlUkvtKw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795798653;
	bh=yUTQ5Vr+q7+YXljm7NoI2dmOrbiI8d8yf6EE2sJO4CY=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OHGlzBIofxZtMvf18XuntTo/7NSRDzagZD3h9IovINji5/un6kPP4ynmneuyPrDXl
	 JhHSCeKVID+VCs3s5wlvtM/APAd9Z8dihwBXakjWAqlmedPHGdkQvYRXUsCLi389jt
	 6L7Q0OawIU3Im/oB6M3yvpsOl9mMPB9X5+ztgROOCE1KzDnbFZRh9keL4m1KK8tZAC
	 nFvYChpZxA/8eeeK7fjzkRu9EtocUWmdUpcMBFqFHDMUMZwtwRn9f8Y4L19H9SV6vt
	 go13NRmUorhjVcVFyjv9y5WlfO4abpvRRtOgkK/s6m6s+ynS7lp9L1Cl8ly/Ju8+Z1
	 HaG9583O14rCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 714A060D94;
	Fri, 27 Nov 2026 16:57:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 43055373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:57:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 29409405CE
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:57:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HNju1SC_cbMg for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 16:57:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8FE8040623
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=kNzWSMwi
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8FE8040623
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUTQ5Vr+q7+YXljm7NoI2dmOrbiI8d8yf6EE2sJO4CY=;
 b=kNzWSMwiaxWtGxMqpltvLAWiAJzX28/kMEb1NMKmT38G07fhtA+7wgZDcgkJbWNx8IWofv0y1mJ6oaE3uHT/uyEpi+tdVSMs1jN35HMXKKaFkW+UbBDl/vUlc3PgS6fk0lyvdMqcaKTPNVZXZLBOjWXnkd6Hk52IKcPkqeTJdk1hCsb9aud/7/k3Vzx/od7x13X+xIONCtdrxS51tkv+YyVFaActxOsv/8zEE0u3lisKQ3iy6f+sD1RdG6hNF1nIbJtxN13s5L/0ge1rm7c+x4JVU9L8Uffis7Ymk5MIBIOGYe7mrz/dfiQxMvwoRnL2yh4A7IgFo6V5p/+XXT/inQ==
Received: from AS4P195CA0011.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::15)
 by DU4PR10MB9021.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:567::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 16:57:20 +0000
Received: from AMS1EPF0000009A.eurprd02.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::81) by AS4P195CA0011.outlook.office365.com
 (2603:10a6:20b:5e2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 16:57:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000009A.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 16:57:20 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 17:58:25 +0100
Received: from localhost (10.252.12.59) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 17:57:18 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 27 Nov 2026 17:57:16 +0100
Subject: [PATCH 3/3] mailbox: stm32-ipcc: add stm32_ipcc_of_xlate
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261127-upstream_stm32-ipcc-c-v1-3-b5e3503ec0cb@foss.st.com>
References: <20261127-upstream_stm32-ipcc-c-v1-0-b5e3503ec0cb@foss.st.com>
In-Reply-To: <20261127-upstream_stm32-ipcc-c-v1-0-b5e3503ec0cb@foss.st.com>
To: <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.u-boot-project.org>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Michel JAOUEN <michel.jaouen@st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000009A:EE_|DU4PR10MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a92fe2-ed22-4faa-26ce-08df4ca7805b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|22082099003|56012099006|11063799006|261026140227099003|261022105027099003|261028144727099003|261021123027099003|261102123227099003|261021121427099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: gTGsiqFkiZOnIewOMnWYaWQHipdoSvFqoK/7qb0buOzy+37CWGrbxikNAh44TXm0fkzikGXF+XlDMAKiwTjX4DVWZVl08JrI9LXrNwp0PUjx/9uLiR4NPUZgjnQLSMVcXBRy43XpdbkXmzD/rNYvbY6fEmhYCcY2jNS/RQTLJtfMhTUa2niCBk29m8zLfrqfLHJlLyBcKmuEZ0VweHqKJctc/0JhICzPMt/SbOnSY+nF/Xn3edsuoZcH2VIPqqgK6FgE9TVc+tLpYTx8MxzaM4DbInnJKzHt5Krdzz6GXyuu2hw/LqzOp80h0iqlhUpW1q/eZqBlB6J8KcOAutQcyfxvZnkLf8OnhrDe1AbjPLiET5vblUoVRSC4vnWOa1E4dHXH96kvPZFKEZaL5oK4znPCOAZolw2O/Hxq0OEFRerZ1AQjjcUH+wzMH2EIA81+2VPSdh7YUEvzCNxcBgtXvvz446qUAGxoYjw+RAApugJbnSyxP2f/HUJKCCcRH9Y2sJX7UqQK+IcnW3QpNEODrN50XFD1wqeUPzYQa5CQaCcbHFQvjpub1CO911O3RcMgssDP/ORDjcWOK4Smzi6RHFBIq028nA7j9ywzzKboing79c3c6bCLHwfUULEicckbYlw2tJgFUr15AMzDUMRg2ov7r0aQyWTuJTNV6iulcgpMEjf2rz3KX/nMDZG8vzK1tFW44ICmn/EiIBwgcMPGBw==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(261026140227099003)(261022105027099003)(261028144727099003)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hAlHoTq9UVgUg02E+abSTyfNziJ2QSzWRjBuq4/X9PveYhZNw+vlFya2mX0lIOPPPgQ4l2gQ3ezzRUY7vQ0il5dSAP/WRKGED7ynughuS7cpxMnNhV+F3DzrEn54SYz6/nY8Ei7nIJDjClZ39CapZtqrZze0UQGcipc7nKYVcCCoNH2B4tcCdtwLbfKuaPQ88FcIeSc2+dC9wC1N+qtazKUKKeG86x+RMoZ78P/l608c93zkchm1cobKwE/pr6qdMksyAZOGd8wUPgtwHqCFy6PvAe96fKG7l5ThEOKy+e24rjDb0T7xFrdRikIf69ovdd5xdm6SEXiawZ6+seqz7CEnMIkg0sF9jLjB8peYguQKtrJ+GBnny44wNncKz5E/ghkARMEf6WxDElXxD6JQ/fHcnWQXKkmmabvicAxAu0zy95M3KMKF3Jx7i9CSY54Z
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 16:57:20.5817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a92fe2-ed22-4faa-26ce-08df4ca7805b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000009A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9021
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Patrick Delaunay <patrick.delaunay@foss.st.com>

Add stm32_ipcc_of_xlate to manage the new IPCC binding in Linux kernel
with BIT(8) to indicate the high priority mode for channel.

This mode STM32_IPCC_CH_HIGH_PRIO_MASK is not used in U-Boot.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---
 drivers/mailbox/stm32-ipcc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
index a9da42e27ca..cf78c8cf96c 100644
--- a/drivers/mailbox/stm32-ipcc.c
+++ b/drivers/mailbox/stm32-ipcc.c
@@ -34,6 +34,12 @@
 
 #define STM32_MAX_PROCS		2
 
+/* Use virtual ID by setting bit 8 of a channel ID */
+#define STM32_IPCC_CH_ID_MASK		GENMASK(7, 0)
+#define STM32_IPCC_CH_HIGH_PRIO_MASK	GENMASK(8, 8)
+#define STM32_IPCC_CH_VALID_MASK	(STM32_IPCC_CH_ID_MASK | \
+					 STM32_IPCC_CH_HIGH_PRIO_MASK)
+
 struct stm32_ipcc {
 	void __iomem *reg_base;
 	void __iomem *reg_proc;
@@ -41,6 +47,26 @@ struct stm32_ipcc {
 	u32 n_chans;
 };
 
+static int stm32_ipcc_of_xlate(struct mbox_chan *chan,
+			       struct ofnode_phandle_args *args)
+{
+	dev_dbg(chan->dev, "%s(chan=%p)\n", __func__, chan);
+
+	if (args->args_count != 1) {
+		dev_dbg(chan->dev, "Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	if (args->args[0] & ~STM32_IPCC_CH_VALID_MASK) {
+		dev_dbg(chan->dev, "Invalid value: 0x%x\n", args->args[0]);
+		return -EINVAL;
+	}
+
+	chan->id = args->args[0] & STM32_IPCC_CH_ID_MASK;
+
+	return 0;
+}
+
 static int stm32_ipcc_request(struct mbox_chan *chan)
 {
 	struct stm32_ipcc *ipcc = dev_get_priv(chan->dev);
@@ -151,6 +177,7 @@ static const struct udevice_id stm32_ipcc_ids[] = {
 };
 
 static const struct mbox_ops stm32_ipcc_mbox_ops = {
+	.of_xlate = stm32_ipcc_of_xlate,
 	.request = stm32_ipcc_request,
 	.rfree = stm32_ipcc_free,
 	.send = stm32_ipcc_send,

-- 
2.43.0


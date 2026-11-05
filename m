Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80411606D809
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FgP/CnqZ;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Hcce71zs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DA5D4081D;
	Thu,  5 Nov 2026 09:03:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x0e7uP6KFtFC; Thu,  5 Nov 2026 09:03:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 959B04081B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793869420;
	b=shMEpNKkYwBYaQZ4p+Ro607rsAWyZzT72B1IkNV3E0u3tXI5HkSp5dWYx6cfwWwAJ0A6
	 J2q52EGQLCn5405ITHs8aGomWZnZSHz3yPTsYV8le1C+f3DLC8UEuwSYpzOZSt0BQXQhv
	 qiiZte/baMGz08iJ+dXL3jVvcdfkpRQY2U6pJVz62FrvQde1tKTgah+Xg2xOCiEHkryl6
	 DVcokk83GkkKX9/JYj3SA7X3IgY7JcIdsUZI824kzMOyGTt25EJ/+wFBXFUzp94gCUNfH
	 JzJV5CblcM6puj9kpylhfIzRmbFEFD0W4vKY+sGjaaF2kSQdBx+hywYOfGgK25F4SjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793869420;
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
	bh=zR12yQuryQy1ezhpV/qAl0ZHgSNW5oloGy66drQEeY8=;
	b=sck01pmLnCQGNCMHUrQDsQN2IP/5hFsOJul5oyPLjTvtdWeRVFYABEPO7EUjZQntG7Xk
	 Q4scaOMwN2bYRxgp+J4Mrfg1p0b0c12NGtwxumEe9iLzykKiK06FcUHUxdEGsMxjoBVlV
	 LgyL1EIMmxSdtmiShyqsiaEZARnw+dPCpoLi4NbAK9CV6p8/joZSY7zR9r9Be0RLoS0j2
	 GZkdIubbaS9qwKyOb/l5Y/haR/48H9ZvI4XsuBWDxCk4hN+CWeZWtfq6zy6qqEVSQ8xNT
	 smFQenW7cFzw3xdLe6D6QR4InlRpWOm/9apGRRbdCqu5Kv/lR3LP5RWFmUsT9/ROjMQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Hcce71zs;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793869420;
	bh=zR12yQuryQy1ezhpV/qAl0ZHgSNW5oloGy66drQEeY8=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FgP/CnqZ9IHKNgb9MI8hJtsTvw9PK4ZP5ITCvZ1NVwtS80ZbE3pHgmrvTRdZIufkh
	 LxDJh5EH4QJuu9flaDTr1inIcZkf5wJquvmUUnoj00FWmIE5KXWy45Jtv3arSRHcFY
	 fddDXp8pygFGwOJfNe9+oNpwtNsJoswSGiH8H5mEwUvrqQ6mVI31MqXxkME/ZpikQe
	 UhYAygVgH6UqA6wmv2MGQEbETl9GP3em5Q40R3QdC8fyyaf3sHScWIrToCLCvjy0JX
	 uufnA54/fYsgK72oP6I7QLIl4vtbBoUDi+pc+G9RW5uqRIlXfz5VT83AdQxnWM/bfo
	 ia/lgefxAsbCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 959B04081B;
	Thu,  5 Nov 2026 09:03:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FB1352B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 656164081B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:03:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s_EJ1E_tDLS2 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 09:03:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BA41D40704
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=Hcce71zs
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BA41D40704
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zR12yQuryQy1ezhpV/qAl0ZHgSNW5oloGy66drQEeY8=;
 b=Hcce71zspt0SIbgPqnZxtfuWiwLt5VxYEJ8pfe3ro9WN8x83uu5+6gRcoXWHM++Vy4czEmOHU+S66mqx8c9WzQuFDY1QssMnEPLlK3lytgR7Rb3iX5RMmg/9+enQE69ovqIThw+rNdIe7f0YYBzHCHUJEsy497pjq9hxb/UCVgrwcMcSWN6qtelX2tfYBii01nMfNwXNhxd6Vs4fyeCcL5OYqf1CZ0W1UjbyoY7AvVgN15nKhJULl83c+iosvP9gRwws16zCZbF2raLygidziScZmjJFJolwNyFoxR9x296e8QN7Yn+A72JNrUprM3RVIhBOmx118NqZY5tHMW5u6Q==
Received: from AM0P190CA0022.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::32)
 by DB9PR10MB5377.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:336::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Thu, 5 Nov 2026
 09:03:31 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:208:190:cafe::e) by AM0P190CA0022.outlook.office365.com
 (2603:10a6:208:190::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 09:03:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 09:03:30 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 5 Nov
 2026 10:04:14 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 5 Nov
 2026 10:03:28 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 5 Nov 2026 10:03:21 +0100
Subject: [PATCH 2/3] mmc: export mmc_set_capacity()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261105-upstream_partconf_fixes-v1-2-6abda284aacf@foss.st.com>
References: <20261105-upstream_partconf_fixes-v1-0-6abda284aacf@foss.st.com>
In-Reply-To: <20261105-upstream_partconf_fixes-v1-0-6abda284aacf@foss.st.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, "Tom
 Rini" <trini@konsulko.com>, Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Torsten Rupp
 <torsten.rupp@8tronix.de>, Eric Chung <eric.chung@riscstar.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F7:EE_|DB9PR10MB5377:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d912f3-5787-4b79-1e73-08df3b1ba964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|261026121527099003|261102123227099003|261102130727099003|261021123027099003|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: ylNNcinZHjIi9KHDfUpcwEcQVFxb4kocOTezigtz9NFN1Et2fYATsmS3mKeM9aAbAdUw5tYRpLnc9STFsqx5d2G8wxSTK4I2XQt0+MbH4UkVKumQAJu58oxiG093NOWUfFO78OWUhQwnMM2bNSyYduhJ9m35PFDxlirceiLR29WfJxD4VkhImi92saUunE+w2ugm5PmiM49tB8jymXnwIstkD60BaIj8mYMYrnUdpGqUsd87m3bYAIsifVuSeLFzBFXizJoaYYabG/XdvLYAHlPI76VWWflxDHyIqaLx6vAL7k79gXBXvMCnpqebIfmGmmLbRJzHF70eB7lfXNXtJ45hgVrfd2DG0PHeDYC/iIcyO7Upp11I3fpa09+0bCajOM2YwB0o7YOuA43a01aHRrl0Hu+n+TV70Mt5TNAnrEHg0Fge5rYSer7HHmNXoISW26DZzuuUaPxp0vzsjLFU2EorqUAlR4FWVbuZnKWxH/Vrvx84vTaLX10ZqmcPZbpjTHBmpPuNVAfevFwVs2WqYH0K/A4/7zMUTZogXnQbZJ2wwWC6AWF89wJb+bZbV/ruTyCyqmdOgqL1IXpoXRK3E2jsq9jwC/ml5mLfQ/JjsBgM1iuX/Cy/CIC2IjA8c6e+nytYhjaHwlkSAasQzWDWB/uVtVRZeHFUhJq1npE5o1onbnnemXC7J685trOioghmoCgqhfWFOXysqNYj3n7jrA==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261102130727099003)(261021123027099003)(261009223027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EN8sUwGoEJTPdF7V8HDmuCmCv9SfG+XgmEOTzyz+9r6OwPyjg+xl38EeQGycRmBZVhXIaZE+ioBKyZc71TQH0PZjMLupp2DhsJizWJ4PlC4EnFof6O90CgQ/SAhCIZtB3gkJR3bv3KJW7iRNEnmn6erT60cRJrSF6Sf6UQT4iIM+2T6xdG21LhFE9tyM9luPfUi19sdqN0kyFEngi0RTa/mQMECJAydz836ZflhM0keHJtTmQowaR3XY/dbf+4zWg4HYwBYw94+XzcOyzQ0sFUhgoUeVETyDvLwbpMXCDT92Dg9fmXm1r9WTUlb9mZ16Ro5IOmgMWDEj8n+rQdvkCsD8K9eyWBx6T/9x/i4NNPINg93BO+KsqhQ3N3Ub5v1XOklUkHTN10FSr4IXdhd4WEfKo74V+aAvxLudIaFyvNCXNwTBcSDpsAeePtqI5pwA
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 09:03:30.0652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d912f3-5787-4b79-1e73-08df3b1ba964
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5377
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

From: Patrick Delaunay <patrick.delaunay@foss.st.com>

Export the function mmc_set_capacity to be used after change of
hardware partition manually requested by 'mmc partconf'.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/mmc/mmc.c         | 2 +-
 drivers/mmc/mmc_private.h | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 4835ce0c64b..f9110c365fb 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -1096,7 +1096,7 @@ static int mmc_get_capabilities(struct mmc *mmc)
 }
 #endif
 
-static int mmc_set_capacity(struct mmc *mmc, int part_num)
+int mmc_set_capacity(struct mmc *mmc, int part_num)
 {
 	switch (part_num) {
 	case 0:
diff --git a/drivers/mmc/mmc_private.h b/drivers/mmc/mmc_private.h
index 24e68ceb5e6..a0d4dab9af9 100644
--- a/drivers/mmc/mmc_private.h
+++ b/drivers/mmc/mmc_private.h
@@ -116,6 +116,15 @@ void mmc_list_init(void);
  */
 void mmc_list_add(struct mmc *mmc);
 
+/**
+ * mmc_set_capacity() - Update capacity for a new MMC hardware partition
+ *
+ * @mmc:	MMC device
+ * @part_num:	Hardware partition number
+ * @return 0 if OK, -ve on error
+ */
+int mmc_set_capacity(struct mmc *mmc, int part_num);
+
 /**
  * mmc_switch_part() - Switch to a new MMC hardware partition
  *

-- 
2.43.0


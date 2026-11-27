Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BAD606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TdG7n4Fv;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=KZkg4Fv/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD88640B12;
	Fri, 27 Nov 2026 16:57:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bt3WV-jw20ka; Fri, 27 Nov 2026 16:57:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E49BE40A08
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795798650;
	b=h8brJHJBnghh2OsDWSBDiTAixNmwFCz6LniCqZf9EZw/buxf68uma26bP9IzDjF57kF9
	 etWbnyYtEispSqeXgOOFF2hA8lNXN0QbhbEn1IUFKebn32dbyhaWCnoLOgVQqNlwmqYd+
	 ReKhTBRWao82mqIp69U1XgSZdhqCT3GZ0VN9Sq2F9F+7KVI6a+9UGgHGrkV7/7AaUI+rE
	 nWMbx8F2GzIL9uc74gZuBe82nLKY/OxJTkkLt0/KWpcrOtxVc9Nb2CqMggylTtdxKqVlp
	 qIvftYeOA9+VR4lttfDS4yYt7Wf5Qv3reyINKfx7d0KJXPvd9YEUHWIO1OssB+tPlQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795798650;
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
	bh=DQYD4gQrdSBh1MG+8yExzg9p6Pd8N0vGH45YuvKholY=;
	b=Ki60bOAzgPz/i7BS+A3mltOQq986H9TQ+TMDsbHIRgigDtKqr9yt5A0daFna5hvfRhKr
	 OYmKTfQKgbnVKpnzEUfKczoN+uJwPHRtssjGo6mInXcZrwhCFin713NJN7xJGoOVGGBed
	 RaWHijcAJs9XmkG0sUDW9qAMUMNxezEgd+wStsYh/vLLBOYWUz8PTYPnrDRiZq6VUQz6H
	 2vhtKcW8UjvdcvgG6aOrlxFnaSH/JjYSL2rFTbYpVE7mWW6Q0J7gyDglkWoyMHglfRA+m
	 15R7V7DqIXrqYX6MRKjsxGARPN3uG3pKdVPaYCVi+orpcVrWlIZ/BCJUA6f73Alz/Rw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795798650;
	bh=DQYD4gQrdSBh1MG+8yExzg9p6Pd8N0vGH45YuvKholY=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TdG7n4Fv7GZIHRdvgTXT2J+c0m8GXjX3iSnhq549gia2LCG16TGZgE1+1SfXhHiub
	 XHZLNjeyLQegUinUQc1RuWJwVo6eYQoyCioHxgZwY+uuf8z5MZ4VY2vx59krIXtT2d
	 cf8eseY2EmyHITNjQERwLwLGNSzJW5KfHQpiVHksu4I/CwgLMJGJzgZn2pg5rCnfOw
	 n0seiPjSaT441MysYX70G+yOAGOCKqly2KBRP5ycWFg1ZdZ2UHwSL7vLIwSijfxXqQ
	 GLMwG1FkSfXy/7FbuQkw0tDdfJcyhVqIe3alb2Wa7jgingSSzXrdbCwYZpVl6aFsYk
	 KkJbepdcRuClw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E49BE40A08;
	Fri, 27 Nov 2026 16:57:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9909F373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:57:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A1C081299
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:57:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wQmLMtZ7yKPr for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 16:57:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2CE7F81244
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=KZkg4Fv/
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2CE7F81244
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQYD4gQrdSBh1MG+8yExzg9p6Pd8N0vGH45YuvKholY=;
 b=KZkg4Fv/Bb8NJPHqsGUV1tlvfACSKXJ8DD1DAmIf/9iq9+0oGmLwE9N1j9kVrFQATVAzhA+xoMvbFm9PtJGuX2qmsGhE1PTJLr1rDmiDGNhcr7WzQWJAckedzV/Q/7m5BbcPwjcthJ1Q0ZgNflUbWJ4p/vRdvDcPqHMUkrPyJHHVxmwOcML8TTWGkL40FBnyupQ9YKUJ4Vjf2VmSL6E7MAa1gmijBeDTxDq09BTw+tYgtKlgthpfZnODLvFm9GCN1jk3xMhBiaQacedxjE/b/CmZMWPv13ip93mmnhnZDM2eVKHRA7fFok7vataE3BPFBb/2pvPVuhsoTtTZSi0HxA==
Received: from PAZP264CA0164.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:236::18)
 by AS8PR10MB6556.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:565::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 16:57:19 +0000
Received: from MI3PEPF0000855C.eurprd05.prod.outlook.com
 (2603:10a6:102:236:cafe::81) by PAZP264CA0164.outlook.office365.com
 (2603:10a6:102:236::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 16:57:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF0000855C.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 16:57:19 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 17:58:08 +0100
Received: from localhost (10.252.12.59) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 17:57:17 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 27 Nov 2026 17:57:15 +0100
Subject: [PATCH 2/3] mailbox: stm32-ipcc: fix binding issue
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261127-upstream_stm32-ipcc-c-v1-2-b5e3503ec0cb@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MI3PEPF0000855C:EE_|AS8PR10MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c07828-bddc-43b8-d8eb-08df4ca77fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|18002099003|22082099003|11063799006|56012099006|261022105027099003|261028144727099003|261026140227099003|261021123027099003|261102123227099003|261021121427099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: HY+NdQvD2PvB46W5EhY8eBY4Muhm+EivEQL01oZ+rJZHR5QVt6/G/nSbCb1uA94Z9Z/KmJQOj5G3kYYYGVwe+lxLJLQLqseQrTNC3OUgblMA9+wGAqVM+vKzGEtcxwAF3BR5eXlfMXkjAD/vIgyuWcgRIKrOqlBcGFBViFO0/kJw8yUJ/ThmZNW/BAo/+M5MC9sDLY7XOUgF30NJxkSVWa7MYW3DW9TR0XBjXyxW46deZ0vVdZ5clIt02xNOwb+14gqmK5eFy+xdNBVCFcTSi/Wny0Z0wCBxWWg/YLmh1VofIjPMCjnwLpGPHSHWSgB7n10U0l0f1xlB8ABFZ6JEDPDCoYxv9vP1v5QpicFpzLNX6af5OdrC1TjEo5EIgcxg2j1LCceLHYKPFKb6NaAznkekcrH2ihadDPXXeVG8PcBig1SmIx8y9e74F2+1gqWutSPl91GhFmNAnhys79Fs17fIUvb+0QwqLtYbj1iDCn/bn2Lkh0oqJ2LmKFln8h1vLmZUsGSHXAsT/8/LpUzGXk7jCASETuSdu7R+V9avAuUVGlQnM42b/d8dgnf8QqMaddRSVlVMAOGb1ZSFd5cBS9O2KS4RTkNKLgyXds4xSqmVjFNagtjJERELc26L9ZXH7BUbJeoXmJOWY117EGWjXcYkw/Z5Sn1cPQNknKEjoNxf/SzSASuf/QA9Vl9rCpJhbE2qdR8pNfRLOXJXRuw2oA==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(261022105027099003)(261028144727099003)(261026140227099003)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rmJwjcOjCkv5WldlH799eqqr5X1G+cN3oH6KnanlSXyDtfxFTQhRpA90Nttl8wgSh/veO0+8LhU9jUgzem+UTTs7J2GnULGuY27/Sv/ni8vv5t+adp9U2HOzPp/Y+0umiYh/n7v5Duk2kA7YMm8Av+txqnXWFBUI5zW7xM5LW4IWsk05pT57B1VwIyQXjpb64Q6wrd3yPBDkj33RDrNfcYfAY5xGzhlbH1rrlj0IJO5QdHaV/myjAjQDDAjiWt3sP81Xtx1ET2pktFcXwnpcs+J7yPG2LTutGjYyukvP2Le+n2KcsFe8kZp2VnPG3jP0Cm9AypP9mn75vioezq59IGHHPLKYBHdbYmEsYxxWgttGV4vCScHIUd2eZwzWStA7OlLXMMhxbylRUwsAv4fPaIP6ea6IxRI7aUQs9fH8MUvAPk//QSJngBuVwpY/en8m
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 16:57:19.5684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c07828-bddc-43b8-d8eb-08df4ca77fbe
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000855C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6556
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

From: Michel JAOUEN <michel.jaouen@st.com>

The proc id is locate at index 0.
Fix the typo proc_id vs proc-id.

Signed-off-by: Michel JAOUEN <michel.jaouen@st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/mailbox/stm32-ipcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
index b38c4c393bb..a9da42e27ca 100644
--- a/drivers/mailbox/stm32-ipcc.c
+++ b/drivers/mailbox/stm32-ipcc.c
@@ -114,7 +114,7 @@ static int stm32_ipcc_probe(struct udevice *dev)
 	ipcc->reg_base = (void __iomem *)addr;
 
 	/* proc_id */
-	ret = dev_read_u32_index(dev, "st,proc_id", 1, &ipcc->proc_id);
+	ret = dev_read_u32_index(dev, "st,proc-id", 0, &ipcc->proc_id);
 	if (ret) {
 		dev_dbg(dev, "Missing st,proc_id\n");
 		return -EINVAL;

-- 
2.43.0


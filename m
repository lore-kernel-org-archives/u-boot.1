Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD04606A31F
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rVXWkopt;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=orsa+u+n
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F40D060B0E;
	Fri, 27 Nov 2026 16:57:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fuCXs1tStth3; Fri, 27 Nov 2026 16:57:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3783060A54
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795798646;
	b=tgsvJgj5kTaJ4W2BDD1bt1g6MT2Jahaj537Ud512bxRPXmrW32I59lKUGuNIRouDvRPm
	 cKBXNV5cH5ZPdxMYNuFgUtv0yQdFt095iZk9n9iY+xlxOJn4WlpEEUuJKL4fvXUda1bpb
	 2d7Mc16DR8mbwOwlqyf/VxfgE6mSvm09AVCbFnePWIImfvgML0Lu5YzWg+mCyhzuAKZ9k
	 /tHfC+/SldsdSw3cp44zFmBY2XRFGuHHEpJ6GIqwd92dZL4MKxsdxsGNr+rzLx/IAHflB
	 JIaThRbXyFYHaCWtrVZl2xgwylzW1Mq1E8Rnrj9MU+IAkrGyt8tMZJdgWKZM65R+E5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795798646;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=jiHEXy3NYSP2hEDP+RkcLOXOgqXBnQlMpc1rnolfg/w=;
	b=ma7kozUlPeruHor+JFxZ/XkIE73G9xi9LM+KpqL1IArOTG26wwITvdLZcbcW8z9qGZxR
	 IjF+derG0Yhhyl/pt+a47X0jHmpNA6gq2EpJ9YlQFsIbVzUplXPRVKeCfyoeqSNtfaBTX
	 LEdbWf3mMjhsvLK5CHJhvje/KJ/o4ngCxJB5st3w6sgq22Kq9/qAvQv1s4BNI1JH+WLfp
	 HHfHW5UXrYIGAXcRA80npUSxwg8JrFK9HM/HOieN/ca0eXMLIsV1WLkuHpMQCdhxfB8D8
	 BdU+oyQ2wNNuwRBWfOa6l7FUDSf2QHf+lr01ubuxXXfZHV1Mx0Z6yxEIM2JsYYO8ZJA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795798646;
	bh=jiHEXy3NYSP2hEDP+RkcLOXOgqXBnQlMpc1rnolfg/w=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rVXWkoptv3GpT6twz9ezMEWRaE4699mFqWtDNHjnPur3QW5TSxK7pFKLvhjxPLFgL
	 r3ulwTzbDUYWJ9IHvYFGKbCD09GMYhVOJHRaU98fYqMTlD05uZaoCsJU/1YZ9FrfzY
	 vnR9u7qXuNYdlDieCvP3IgzkJ67B2ZuBzbR9BKxQgM1wR9MLGrfpSGKADfHPoUbP/S
	 0WMX+vcB/IXYePD8q9+pRPar0FQIi/VGHJjp5QAbAVHd4RNxZ1AvQr9bcys80NNTPb
	 DfxxnQUzE30EbjarW9zUxWxFbejWq/RjDM3BqZgoR1E4HUACbgbVUndT1XOscLE3JD
	 +qxcAPu2Pc4bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3783060A54;
	Fri, 27 Nov 2026 16:57:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A9B44311
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:57:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9878F40623
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:57:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y6ZDaxzHqYWA for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 16:57:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 085A9405CE
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=orsa+u+n
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 085A9405CE
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiHEXy3NYSP2hEDP+RkcLOXOgqXBnQlMpc1rnolfg/w=;
 b=orsa+u+n/9zN5Ls7vLgTUPx4O3nAFURCQ7+zYDw6D1x7GCO/ooygatMfhAinOaOzcaLVi5rffsOsRS9DaThCXu5uxJPq5rUQonUFENztb2gvitiPu8O0u+h2BRjaIYh+/SxJ6jEJjkE/FLHhcfLxhTTM6jqPsewZFosVXqLxgh4jIJAKL/v7po9BxJsGDm4BeU16GNI9u0lGsEW01yMSKzwaTO92f/EAvnsw2aJYoUNa+5uGlYjfinfUKDeKF4tbVkex+jUz8Z9zhOEWITgNeind8aKKEN+92QHnnyVEgNium1fakF+TuYKekgWF7S7qLJ0opRGkCyJjdzDZqq9XHQ==
Received: from PAZP264CA0184.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:236::14)
 by CPHPR10MB383388.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:380:10e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.5; Fri, 27 Nov
 2026 16:57:18 +0000
Received: from MI3PEPF0000855C.eurprd05.prod.outlook.com
 (2603:10a6:102:236:cafe::ac) by PAZP264CA0184.outlook.office365.com
 (2603:10a6:102:236::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 16:57:16 +0000
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
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 16:57:16 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 17:58:06 +0100
Received: from localhost (10.252.12.59) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 17:57:15 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 0/3] stm32-ipcc: driver update and fixes
Date: Fri, 27 Nov 2026 17:57:13 +0100
Message-ID: <20261127-upstream_stm32-ipcc-c-v1-0-b5e3503ec0cb@foss.st.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGm2CWsC/yXM0QrCMAxA0V8ZeTawRlyHvyIiNc22CJul6UQY+
 3erPp6HezcwySoG52aDLC81fS4V7tAAT2EZBTVWA7XUOUce12QlS5hvVuYjoSZmZHSRT95HCl3
 fQ21TlkHfv+/l+ret94dw+c5g3z/noerHeQAAAA==
X-Change-ID: 20261127-upstream_stm32-ipcc-c-1dc577d2a688
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
X-MS-TrafficTypeDiagnostic: MI3PEPF0000855C:EE_|CPHPR10MB383388:EE_
X-MS-Office365-Filtering-Correlation-Id: 642af387-cc8c-4434-bfa7-08df4ca77ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|56012099006|11063799006|261028144727099003|261009223027099003|261021121427099003|261021123027099003|261102123227099003|261022105027099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info: OTZhFW/qBgCz6vgpVy9BZEksJzOfjIqPFrcaXiUPaJeasMuasKSwK7dbqKcWQ+ZG8rgGspgrUbGMq7W5I+b90irLxekb/hVy/X46YybGyWNFZrrfaqHYMXJhZSeGpaf1smCgldOKCGrXcridZbGqOkjAi78To8HjKR6qa7hPK2wQtmuLwEs0cjtsEhoGdeRyKcmTP8WPQwClVFn+Cw8yNpkDccvDbKVGzxgN8OXUQ8SVAS8uc8UYpFfkVnyzCvBXPvGid8Z7yuGsjAyQot7+cez/sMyLDLhq6m6PIGpJB2l+42Qiq3wpxDEcqOJSiJHLdDtJ8GX/81v5rd9rInh5/IEdS1LXD2JlMyrLf9nLv+DSvCwWlq+LsNNB4VRv0/n9zyOeMDxqCyU2RR2Z3F9cJU++IWLmma7TWx3LEVwEWJ+s0kgq/CLVFfyK6e+pUs6a3VGj4Rngzj89APXRNkwOwN5l11RUNKKSDEDkaQ3vlxwCDYOi0ZI8F9Veen4kZf22yv7idZ4FA6qTAelgdeBkiglI9BQFwFDcTop8s9bqC0AhIF2yktdhee8m/RwBNREL9FdoCQO5q43V7T8lNn2MxV8tNGoJ0ABdYO6iUfCnxHJvCQxr+CYwztP/qmP/HqqWIIhKRlF/uZArzPA6vOxumkJP7EjDAEnz11U6ZjKqu+cKbpyziwRCmAa8LQPau5pwsfrFVS7o5m8Gq1K65f74tw==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(56012099006)(11063799006)(261028144727099003)(261009223027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261022105027099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EsUwns2FGUUAgix9uiaxZyzYEnL7Qb7e/7Jvoc2KSJ4eJ5yirtTcTNQl5oMetsXt/idRJlUG2w9B/oBlNGhfirJBq+uX4aaNOXhRfSUO03x6qMTpMzYJ8PUmfdQulLA4c+4R8laRoo+TPYgohva9JvotcgwrDProq5vEhM1Q0flQwqFTp3iuY3Zxu7MdJ7ULcpQBW9lA1eBu/j8U8DL5kv+EdBIz4yx7xVISclBK8OfMd4zAKDBWX83cuO11DOMiCBil2g7gvKJ9lB1Nc2RF5r2cVOwiVF4jI/LjSgedcEGlt7t2SH+jOem1pBkbTHSYZ/3Z1Fgcv3RmXFwEkIyYU75St28z1Giunmra67JUKFsUbEFGO8zqF5fnLVK0rccm43aTc5eyV+XbzhgY1ivoBVrShrhtjuMmyavI+0sYAHapiEJsRT6L/+I1cqvbM0aV
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 16:57:16.4355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 642af387-cc8c-4434-bfa7-08df4ca77ddf
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000855C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPHPR10MB383388
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

- fix "st,proc-id" property typo and index.
 - make clock optional.
 - add of_xlate callback.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Michel JAOUEN (2):
      mailbox: stm32-ipcc: support ipcc probe without clock
      mailbox: stm32-ipcc: fix binding issue

Patrick Delaunay (1):
      mailbox: stm32-ipcc: add stm32_ipcc_of_xlate

 drivers/mailbox/stm32-ipcc.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)
---
base-commit: ee1b3477e3af6af1ae9b8f98bc84d2cc6f32a3a6
change-id: 20261127-upstream_stm32-ipcc-c-1dc577d2a688

Best regards,
--  
Patrice Chotard <patrice.chotard@foss.st.com>


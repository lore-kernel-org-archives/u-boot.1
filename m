Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01347606A323
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tlIDyuZ/;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=KMJbxsIW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6E2D8145C;
	Thu, 12 Nov 2026 08:27:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 09PU8XeEn-Vu; Thu, 12 Nov 2026 08:27:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1EAE581463
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794472024;
	b=Ut9hvDC4j0NlX3ZP9rOM2QbrhiaaeswteOINtZ358l3kVaJL3ezzi7fBE8lD6IixV0hb
	 UVqsUSnZpBS9yPnIPvF0n/T0P+yGO4mxMO7DSd2OzxS42LBRDvthETWObSZtzRFkqaB9i
	 FC55PoRNoCfq3WHBiQGcY8Ub9QxqD+ngU+MVjRgkJt4/Vk91oMGPRSuYij44s5i6Wg1IQ
	 0uRNqOJAfTiIEYOTkqcM7iILRp3q9nZY93zePCskJlF6g8Ly/bcs/IzGvT57PHO0giEPx
	 CI1JMI/NDLSkWjrGThuLYbKkwoPMFS8gGHkIAq7BA1k+5pEexTRRj6WxmEAgmhphmWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794472024;
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
	bh=L1KTco7GcAhtb7tJH8OCrKHJxGgP60+6IclTpUN6Ybo=;
	b=KXWMFKVAOq2K7zv7XT6u6p7MF04M1VY056raRnpf4c+aD+Ia7Szm26ZuiBJlVqgmn2U0
	 KUCZTMkd1wJjzcVeeGqX2g3sGzGd0qiewPJQFFgoMhaVVvVUQywLLx4uss5bPAD9B3lMS
	 0L+yiByVOKzKj/sOgcwohLjN/mUirzgX3XsO3aeExHd2hd/YuY+nE/WuWiBXaUaWKeXYj
	 qB6dwY6BkvhP5s0FAJOrsD3Y2eIWAvCSX+YT9tctPgdPclDl/ZA0p5TvNDfN1gUIZupEk
	 5td7GHIoHq0OLH4yQ/EmqNFPbibLr/JSsenMDrnCfUelUnZ56pd/PVXfC8+6EjcO7nA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=KMJbxsIW;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794472024;
	bh=L1KTco7GcAhtb7tJH8OCrKHJxGgP60+6IclTpUN6Ybo=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tlIDyuZ/jbz4quxlEDb7OTVcMUOiXJIXG+gyPnx0OS4WkzeTj7oV8mimEUBG6rGVC
	 Oz7iopi4YoGe304mv5Qe/+fIcAWAqk9eVceTbnRX6Sg4pzq4Vey7Wzvpi9QcPg5sZc
	 xxZYgJwlzN49gEBOKLuks4KR1nEu02B4iEgGT57Vn75KGZKjBONHxIQ/tFcu5a6b+j
	 h+nnKsBCqWQL6F07qhXX9VPOaT+85EpRgyjPeWfRxFJavzATVOgScookPFVwetu0Cg
	 qHHHglwNZFUamQMAVzeXI6KDOsn2qWbc0+Xa7QLf6tF+v/jrWRNH5ya/xJCrxBNc1L
	 F/udkZx0z4vNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1EAE581463;
	Thu, 12 Nov 2026 08:27:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 16C5D28C
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:27:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 07CE681463
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:27:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W9sCrkFlCzun for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 08:27:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 010C78145C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=KMJbxsIW
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 010C78145C
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1KTco7GcAhtb7tJH8OCrKHJxGgP60+6IclTpUN6Ybo=;
 b=KMJbxsIWB7YJnrz5PHCHdi6XGO1t+98B/bMQIJDUx4a73ouZ2ZKmb8mbnjCZjq9LHe2lMZMAS2b3M/Fl/TmouoCLycmI325Fe70Qnq8cK8EhggnC7Ib6Papucz/PbDhiVVssTP8lyRjOJ9t3uTbeXVmC+0ift3Am72TJRloQqS4Tq9vhid2S9VbOUk8nMLuMaXaMhUWHy4h0uJPQyfubixtAWMAv9zoEUBm3ryFlzQgsGL9Ee3Rv0gb9URtcZJWdadwwA2Bkqf1Ef5Y0xu6WgwyWFy4TsGpFLDl2T9iFL0APCkDhpPl9B81lwsVMYt7h3Or2rhbbxK0hWufM4cl19g==
Received: from LO4P123CA0227.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1a6::16)
 by PAXPR10MB5759.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:249::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 08:26:53 +0000
Received: from MI3PEPF0000848C.eurprd02.prod.outlook.com
 (2603:10a6:600:1a6:cafe::af) by LO4P123CA0227.outlook.office365.com
 (2603:10a6:600:1a6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 08:26:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF0000848C.mail.protection.outlook.com (10.167.240.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 08:26:53 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 09:27:50 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 09:26:51 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 12 Nov 2026 09:26:49 +0100
Subject: [PATCH v2 2/3] mmc: export mmc_set_capacity()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261112-upstream_partconf_fixes-v2-2-5eba1cf22b1a@foss.st.com>
References: <20261112-upstream_partconf_fixes-v2-0-5eba1cf22b1a@foss.st.com>
In-Reply-To: <20261112-upstream_partconf_fixes-v2-0-5eba1cf22b1a@foss.st.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, "Tom
 Rini" <trini@konsulko.com>, Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Torsten Rupp
 <torsten.rupp@8tronix.de>, Eric Chung <eric.chung@riscstar.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000848C:EE_|PAXPR10MB5759:EE_
X-MS-Office365-Filtering-Correlation-Id: 44533027-12ce-4e38-ce7d-08df4096b4c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|22082099003|18002099003|6133799003|261009223027099003|11063799006|56012099006|261102130727099003|261026121527099003|261021121427099003|261021123027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: 69U+zURe4Kka4VaDqNs7s5ItX3Q8MmSyperUqEiJ2gHvodab7v9bEBK1+1KyvUMHhUFhXNOM3nr2t0sEcMYYz4KI4xx35J7gbOEJvtCbLjrhykfYnsES1kKiyRJsuwCGdh2YwKhPiQzJVWnQETNAtQ3nNfqxEdpddUS2NJ3iVwTkrleCjGy/39fv4bGfnptJSu44kmHT7bIF2BPJs1H4XQdFJRzwxMxRw4Q10qZuET9mVR6b3lWmRtU5ieegeOecKKCcerHOYX3nJbxO3Xxs3i34wVuKLhsb1pFz+y9OY64fxpXj9Ksj29CzSskBODIhvYXC/n4WhcPxxeOpkpWMZQSqOM3gO26QCdlcvjKSJn+wqwwu4On/Kgca5voU5bmvpjNIgS2/5Waa2+7rXssHW02PAyTbJSD+/NL4r+xwgWV5gw5m+vzmEupZjBal8qU7xyMpfaXAlWutwSslspEdPFWTjPrBWdKaOkArV9/udCQPExTJS97mavGNJzCC78ZbG+KaXAqLJe9NG+CUsdOTVLjU/or2Ay6w4xru9XtlHZG58l8DD4Zem67bdxPlYQMb3NanjoVoUfQnHrbUMe5Kn+ia+oq3Bnh4/HuHivCGqIr69amYMVdz6i/HkK2PrKANf0ZneDkLHJErNn6KXT6Dy57jIn3HJVRsupFfN5n3AUY+T52TPeQlMGHGLbLEiin0l116gwXtEPHeeVk038Obdg==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(261102130727099003)(261026121527099003)(261021121427099003)(261021123027099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2mOxRSNGEsQBNi00VBlMNAp9dhaZ5DxAVlBsYVHAc5EuH8zQai4pc8lAO+jH+mSbz5Qk4LZoYLsVNsMA9LDrPfMMEEjGwIRnKShIurdKsKmXeqkr3RVxScpZMU5XPufUFjTJ2DcOc7wUxEvZvbRea05Pu/Xu8Tu98e2wK1AWmgH7nThUY6i1GAVL20AYdTIPEsHte6rvowIfckKmzMyaH+8RoGGd7TUcsTB/7mdfWyDHY8Xh9og1cSbpzgiUOYovE3fHbygwgZncoa6lKyfoDcDD7PjbIRRGJmEZXFo9//UmQqgMXtjuAaXfr23uKIhlrWAswJWrMpnMzGMUUuc/EN59uSNJj4xj/eVovxBwkxaBQZaq5pCOX6q90ElClFNY5rLgYV8NGxw92wBUIjwF8+Cr1XdNzHuLt7dud+Iptpq6K9XHZ6W1IQfACRaGZz7u
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 08:26:53.1643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44533027-12ce-4e38-ce7d-08df4096b4c4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000848C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5759
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
index 24e68ceb5e6..bccf17d7ddb 100644
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
+ * Return: 0 if OK, -ve on error
+ */
+int mmc_set_capacity(struct mmc *mmc, int part_num);
+
 /**
  * mmc_switch_part() - Switch to a new MMC hardware partition
  *

-- 
2.43.0


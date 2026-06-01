Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2843CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:43:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D16884958;
	Mon,  1 Jun 2026 15:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="NUiBKvoe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C3388493F; Mon,  1 Jun 2026 15:43:22 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADDB7848B4
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBGuftmSCCM9dlJcSZ04aMT6ItDmoTg7827CkIeJLFPaF1TpvRXWi23cJ4Kw2Kkme1eHj60f7Y/ZFD9NIh9BX5Re2wtBrJtpacPSS1Qc4Ryn7d0EdeB3QKPx8OQprGwDZxkW9RbwvRoyRtYELMghYICWZOdEV5+lW31lq+0Umd5vT9Sq+6WMY7UnD7IheV2iRt0rE9+dXjs3J4kXYWU72Lqrx8Pjvdt7IfCc40+X/Z/E+UYmR46gucJPJndWkOwXbvpJm55iq9MQpHvb5b60NarJy8InXiUmsNwcOZysq6unLa1a0AdhcPADCFBDSTxPeQXwwgHw3RcS+WubLgo/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lV/0W1TgLWu+1bXAKg+hyvDZmAQ/lGawmHNebxUq3LU=;
 b=w3hI9FkZaTSrFCBUsuEhSDM1XX5X3M7mSOqSV0FwdSLQS1r/gt0baqJE2Q4Jb6DasNIg8bKc1tCPg2QQhocRR6qyLQIeVcP4iAYoEEzd4J9pBb7aj0Y/YjYFurgtXP/auuEnF25Z4yYYjoeP0rgOTDTNHAEx4feqJtHN7ApHrE4ylBKMWsaSX4wYQXP4IeRpazaR4dghuTNHH3zJSJAmBgM8EOf80kU/gG5pRHkt/xOjqk719jqDfiDQfW0E82Gum7Nv91bT4X8bE4xBCyJItgfvb1Yz/+9tOImOB5c8a0ego4HU1d6cmDmsd71z5DOfgQsO0df5J0oZUPmXon2pOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lV/0W1TgLWu+1bXAKg+hyvDZmAQ/lGawmHNebxUq3LU=;
 b=NUiBKvoejHjc46afPt8u5oRaAj15BhJuxYJryemg1qXUWVj4342OQ2yrJn4YeykpRRXvHAlie/FDskB5sE7mt2id96jXqlWkOVARCXiRdNUPP23Fw4pdbj2JH0LTt+aBVC05slNn64CmYDsU2+8Q8tvfrC9S+gkATmrNgdFG9+3tNSHFnR9yzAFzFuK5/ODAKavDDIa2U92cQJqH7eNUCMW4zYI8pi48lO2L2VmrpUkeJEXdvYswVWx9YzLljmFeub4y/gGSd2ODK4z3vte0n0o7RUSypCVl8RXqo3HcaraLeisymzTwgErhereAk83fnQ/A2SPGWAH9gDtltTxMDw==
Received: from PAZP264CA0112.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1ef::15)
 by MRYP264MB7019.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 13:43:16 +0000
Received: from PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef:cafe::9d) by PAZP264CA0112.outlook.office365.com
 (2603:10a6:102:1ef::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 13:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FB.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Mon, 1 Jun 2026 13:43:16 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.66.192])
 by proxy.softathome.com (Postfix) with ESMTPSA id 8AFC82141F;
 Mon,  1 Jun 2026 15:43:15 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v8 09/15] tools: fit_image_setup_sig: set required_keynode to
 -1
Date: Mon,  1 Jun 2026 15:43:04 +0200
Message-ID: <20260601134310.2452454-10-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601134310.2452454-1-philippe.reynes@softathome.com>
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FB:EE_|MRYP264MB7019:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6df23110-ef21-4acb-90a3-08debfe3bbc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 9nqvbAXK7nqRpxIe3KROfbb9EBt/uIuioeHwpjOs8n3//yuvA2i28XtHSgvXjQ5XMQoai0OOzFm5nC/FlenAchSzvGO+83UCdbUGtak9O30yYkWmq6aZVI+X4PeevtbAuvL/pDKkS6YsB3B8hNGV9MsN6Q5cP1St8iCmZQXgfHH7ABjbXqz9NNUTi43iXz69V8rcERFE4sCg5U9TP7s4y4hYQd0X4XIO5uRTcWEPwdrkx87ABhlO4/VVhY13NAVGKoZsjNlEXhWCYU6jFCVuIHFZRmqODaoI6YP11TiY/AwQvTzl4pkpwFGLbRmkK2YFaGtNDZwy/fHnw6HJflL+W+JgSO/g6WAz/ji9bU0ucoG+c9I4gNudIzv3MHteZUYUh1i7JAFBplli4ICSSi+Zj8gVOOVxDUxp1v2K6OScx41QWuUspopsHS8eJP/rxl5H0KKzj+Y4NFgwIRRZynRNNdulBI4ruDqYTeizpAxfV5VmN9AXsMjIgFpvyZG6vZxELcRq4wPU4ZiSZXfjRd+6gV/5YKHU4FfEKfXjbvbBadEuX1T9+hsgRcGiMCsbU5HKnuwaCnq6M2HZMDwkLK5RIwy1lx5y75bQ1VUDhYRubLChmRrPnobVmUyOscsm9uovdk54fvcyZKEHceNGwxYPDzPjMbHDbEHjHTcKUK5q8mU//kf1vMfPHwG6Xc0v0wUw2cqgPvvAbCObHt2OWEwiJMSszZkovJ1oi5nqMiLgI7o=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gfkZ50CGd/a0XCHhH/qqez6OjmZHyeueyE9kD4shV4BCPRzS8Zv2d/OtD2n0AnWGpLwT+bb24x6CBOO6Q3NMkr+K2vxTlhXTKz+vOovM7O+ONyQ6ik6LUUazRBUUy/cyxwp4fLs9mQtPfYqd4+k+xAS0mwdtsCC9CSnWoLz7FCMDYAnPZzsypLhVA3hA5ZUJ1+NbcsUKZ7h9DhwwTp0RQn/wG2TsPLIe8M2UF+5utALU46URoD1bbamfUKPEQwFIuDHJjy/DoZWsGh+iOg7+WKoS3kJPFFANmhAlToBKNHfMbRi5Lc/HFmqa40XqDDyCTedFdODlWndwtd5KAl/I0ToBpeXfZH1IyD4YFqy0cZmechOMB6mXf0UnjIeyQuyGx9Mq4kyRepkwZelPvhPh0+xCK/am/eU1/sqCeVq1lM4x/XtNewd7m1w5Vt7gFmCn
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:43:16.1500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df23110-ef21-4acb-90a3-08debfe3bbc5
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRYP264MB7019
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

When initializing info about a signature, set required_keynode
to -1 instead of 0, as 0 is a valid keynode offset.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v5:
- initial version
v6:
- no change
v7:
- change info->required_keynode > 0 to info->required_keynode >= 0
  in ecdsa_verify_hash
v8:
- no change

 lib/ecdsa/ecdsa-verify.c | 2 +-
 tools/image-host.c       | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
index 494b60b4ab0..341486de2d3 100644
--- a/lib/ecdsa/ecdsa-verify.c
+++ b/lib/ecdsa/ecdsa-verify.c
@@ -117,7 +117,7 @@ static int ecdsa_verify_hash(struct udevice *dev,
 	if (!ops || !ops->verify)
 		return -ENODEV;
 
-	if (info->required_keynode > 0) {
+	if (info->required_keynode >= 0) {
 		ret = fdt_get_key(&key, info->fdt_blob, info->required_keynode);
 		if (ret < 0)
 			return ret;
diff --git a/tools/image-host.c b/tools/image-host.c
index 8b550af0dc1..f5681d6c1f9 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -198,6 +198,7 @@ static int fit_image_setup_sig(struct image_sign_info *info,
 	info->checksum = image_get_checksum_algo(algo_name);
 	info->crypto = image_get_crypto_algo(algo_name);
 	info->padding = image_get_padding_algo(padding_name);
+	info->required_keynode = -1;
 	info->require_keys = require_keys;
 	info->engine_id = engine_id;
 	if (!info->checksum || !info->crypto) {
-- 
2.43.0


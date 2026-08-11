Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947EFC5CFCF
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 10:53:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FAFA60812;
	Tue, 11 Aug 2026 10:53:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EduYdBsnZiss; Tue, 11 Aug 2026 10:53:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BAA47607BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786445625;
	bh=hQqmQ8b6MszKMgXh1SYmQjof9eN42TND7d70eE81BqQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XGCJ1P9nDvGrnc64x060E2dSCiHfaO3N0uZy3yTaxZib82CTAoPJGzfxCt5y7lbAf
	 Thb9cqw0EGJmAQqzwGhjXUa2gU5WrQuiUKod3E3NXm+ld2m4B2euRiChCY6eqxZWdZ
	 GkjMx8iPEa9aHku5Xr3puszB+zv0WN5nDow5SORXV5WCUxPprc2QRU7VgAPonoMH5n
	 9Ch5fRwDLHkU3lrTg/5dazQJ0ehTJAOem9Ql4NrmHiVsumBzYxL+EkbVgFNS1GFAx+
	 y4KCpFxk+TfsDQPeUTjSx45j6W92kPW4ZN2otojpv57Ef4QiEzva0qmm0txZcN+A3R
	 o7MKFlo/z1q0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BAA47607BD;
	Tue, 11 Aug 2026 10:53:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A13A14E0
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:53:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 873AB4073C
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:53:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tgsKtvAOOk-D for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 10:53:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 01D0D40752
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 01D0D40752
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 01D0D40752
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:53:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAt1FOn2pDOJV3ydW75jegbxhaKhUSPYMw1a/JsXC5Sul8hQYjQh1m3aYHs9byjUEC/pa7+zujPeZhI5dsovcBw1DGDF5VRc+engpXL9UgV9Z9JvAlhT9dW8bMrmHR31wgFQlrEHqmlubsa1LAYsAQ0SFCTNZkiEmWQGcrf/qUc8apMErV7c7TTGP4DsvCCgrft+l3I4qO5kf6dee0cVaIyvupKRJcz5XjV1Hdn+S5axdWulfDWVp5RfCqbyEBMPkmwsZmnrxZVpSpNZeDUOvar/q47KCLF64qNYc+ML6x3gcfNnKnzJO9tdLdAv7FZ5r4lxjWJS3ndw8BagOrMpHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQqmQ8b6MszKMgXh1SYmQjof9eN42TND7d70eE81BqQ=;
 b=i/ETv95LEjHCSWoAHcNJjCQ8UdAlVng4IjcbZuywYyxQzmQPl2TWcDNkTSbNK84J3LoX46f+JqPK0utkprhwnaxgVah9sv1Ndy5m54FxKz+rnUaS8723WV5pfKR5el/tIZhqsIQ498X8Ykw1mJl4neR/M9VhP+PtZpIQMRosRE18cxVBCOVFXJKZrOtRPUadhchk/Cl6w91/tAa2HcdPgT2SVl31chd2SWkJ2WLeyN+OFggoBomB87e8+BvssfM8q24wC1Kms6HPYKlD2f+TfaDUOaQ9qM50trOCt8b3UlVaJbhFFOVnucM14RDInCwC0ikRrV+Betv7Mpik+JwMhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from CH0P221CA0042.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::26)
 by CHXPR12MB999220.namprd12.prod.outlook.com (2603:10b6:610:2fd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Tue, 11 Aug
 2026 10:53:37 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::35) by CH0P221CA0042.outlook.office365.com
 (2603:10b6:610:11d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 10:53:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 10:53:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 05:53:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 05:53:35 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 11 Aug 2026 05:53:33 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 4/6] gpio: delay: fix offset propagation in
 gpio_delay_xlate()
Date: Tue, 11 Aug 2026 16:23:12 +0530
Message-ID: <20260811105314.3837228-5-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811105314.3837228-1-pranav.sanwal@amd.com>
References: <20260811105314.3837228-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|CHXPR12MB999220:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b6bc866-027e-4d87-fad4-08def796cb9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|11063799006|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: C6LnlE691M2U5F9z9Xnzk9bPWgxiJ7VDzyJaE0xFteSP1ZrP4A21P3XNWyeOX5WJuX6T3iRGcne4MGxrqk0lzsyuh1vTrylO+orSfZebLcvyCa3ki7jvqSiGyTl+Pj54OW0E7MZZl2axJjOskj7hLNdzAm8LHODrIbOjXTAQ0huCCT8Hj0m9FX/I3t9GBzN50m8axuv6AJXkyUBVtjEsbh3Whf2KcVlM5sykBeOMoMQbp0zTMO8Jiu9gR0EI12HhkNjnfm9IKJa+zPlSVsR8azmr4oLC9qj2zmxoBf2N+cykE9+ankDu7l7OOS5VqJxcrwDprpbrAP/xAF0dLesk1oKbSKCzO2Der25nwzViv+S9oKIk2nzMeOv04DNk3/UZ27nkXSuNX/Do4uflBwwhvWj6X/l3RNbgUYhmUQ+1NlG2lQEaB6umLfif2AFHjIyEYXoMcsmyaGk8kyCBitjNOCviwj+KwqXZK2Qlmiu9L/12fzbc246rAThDxfyXttxM2ZjU8ho69c2pTAfZzPAa7+qP6X4RJxlHFeo55PKDJAKGGUa50Gt8l8GyZhtRfJ9B1ydlAjHUinRVn8wKkmIj4IHZZhGblnhrWS1LqRTHiTQprLGeKcn04gxHSerZvZ5yj0sVpy6TusbUYY61Qa/5MyWnaByMeOxa/wz3gjUvP1JJg3UKtqI8HnxkYiQ/Gsz7uJOSfBUAhmHVh6wU38f3cg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(11063799006)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +E4e410BOn600zmLJd3If31k9B8h9Bpa2c9EgVb1m16J/QLl8nrkanG57lw+jw5ORfzK81IefJQMCv4qFt2gcAFMA+Q5Jor4rdgxpDDcJ109ekxZG5PR/3qZuHF7VKM1eI+TtrZ+nKJ0CJpajJ5pUPl1qsaT3ZRGuyuPebA2YWWajdX9H83qd28p/kH39y3jrEZYDXkdZMEc7QtuuF6VFhbiO/Z2uSw+rzdI3hwLxgLKsIRUNB0U5CAMoJF3TTCfGxrWSj+poY3OF2m/vFDWN8nZ9cqvtAaUdph5FJDoMFXIlzW1xjigbACCWuwD4brZKgwYC3iKXe64zmsY/Zpj2qLNdu3slVcR45frDs2xt+3td0hhDwnBiIC4TeqtV9kgXlpuuG+T0u/oXIJfBJSzq3+3sO1Ks8on+ykrDvTld9KR5uub0vKhzM+CLS/+3GJg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 10:53:36.5805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6bc866-027e-4d87-fad4-08def796cb9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999220
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQqmQ8b6MszKMgXh1SYmQjof9eN42TND7d70eE81BqQ=;
 b=Yk7YiY84LPesrdVDcbUZEI1hl3UGIt9u/eS59sCrXRmwhQDrIKL583w7abjXlHcnP2bUn1bLn5fLjE1JlQmKXce9fJ6eU0g/2/xrbKZaT67zQLoUowU20l92vSo2Tx+4+cQGvL0voUd3cJNCCRH2ZSbMUC4Rm5fBgHhVZS+naws=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Yk7YiY84
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

gpio_delay_xlate() indexed priv->descs[] correctly using
args->args[0], but never propagated that same index into
desc->offset. Since gpio_desc_init() initializes offset to 0 before
xlate() runs, every consumer's returned descriptor ended up with
offset 0 regardless of which index it actually requested.

On boards where gpio-delay wraps more than one real GPIO line, this
caused every consumer past the first to silently collide with the
first consumer's already-claimed offset 0 in dm_gpio_request(), which
returns -EBUSY. The second consumer's real GPIO line was therefore
never toggled.

Fix gpio_delay_xlate() to record the requested index into
desc->offset so each consumer's descriptor is routed to the correct
underlying real GPIO.

Fixes: c866f2f197e2 ("gpio: Add GPIO delay driver")
Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/gpio/gpio-delay.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-delay.c b/drivers/gpio/gpio-delay.c
index 533e7d2f8ef..f6c9c7efb0b 100644
--- a/drivers/gpio/gpio-delay.c
+++ b/drivers/gpio/gpio-delay.c
@@ -77,6 +77,8 @@ static int gpio_delay_xlate(struct udevice *dev, struct gpio_desc *desc,
 	if (args->args[0] >= uc_priv->gpio_count)
 		return -EINVAL;
 
+	desc->offset = args->args[0];
+
 	struct gpio_delay_desc *d = &priv->descs[args->args[0]];
 
 	d->ramp_up_us = args->args[1];
-- 
2.43.7


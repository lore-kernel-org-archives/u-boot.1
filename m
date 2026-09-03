Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009A4C624A4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 12:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F218D40B0A;
	Thu,  3 Sep 2026 12:51:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CDk29urGRF8U; Thu,  3 Sep 2026 12:51:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C016640B14
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788439870;
	b=NXunUBSmAYoap+lLL+UJkA3rJHwOCfn+Ntr3Lf+oAizAbwyQlTWGeNSe6r1klZfMeBWI
	 8Ptx5QSFH/uemrfY908ceyDkBoUhTWAJtTvImpofjUx44nOnK4Ui0xOXCzcb9LkjPJNG+
	 02H5sthrupQ82pMVff7T5ElPHgugGues5gmjJcPSED8JlwFdPsx9UxjGUe/lWcTbr+7gG
	 Y34JyFHvey+v4ZVyg1rPcQyyaW1LZtOqcpy6O95LHASgJsWiHOaAFjDryRNfSNuuA7ama
	 WPvokTBgLLULoX11hLsSjFHVH4h5nceo/0NEv3N6mYYoblkOoz4yeivxIjx30cw7gWw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788439870;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TjZBxnTSVLzoP/V0EqRVNuOkogH/b4p5rg6ZqSfXyoQ=;
	b=YTvZcKft4BRCqhQkfoXPSg5yVDL/OKPgi94alsc2fDjCNth37bVKBrM9srmOAz9UBURz
	 z9IPPcNxpXhBQFQrkIIWjneMgj+wzi0Ua5lIAPVH4YrKL2xonnm8k8xLtKMi7AxHBujLf
	 9Mq7qdJxbeHfRmZ0K2dZoFELR3PnMX3NL2Ww1Q1UHlhXjO4osuQcIsnBIplvo3QttEMvD
	 Hqp8Vhxm/z8xEVIXen0X3XF/zsta38YI0447+XL9Z1lKgVnrBEEy8Gw73bCGq+YvKcx3d
	 PEaq1naZh/pIc4GYkkUbidbcbyo+URLlwh9b+X71fX55BAJh4di95UdmhLlw0AsfRaw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788439870;
	bh=TjZBxnTSVLzoP/V0EqRVNuOkogH/b4p5rg6ZqSfXyoQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AhMxWI6S0nGHba30FVDKSmQebw2e051IIWiwdmT5VwVrRKsVC6BL7UYXCsUbIsVnI
	 tBY2ohv+bZS94ko5lEbiA0J5Kvf/ZsaMOxafuLnWonPko47dwpI3mnM+J/oqsSbLAG
	 iqV1ehuBhATRB/+9FELWbE/wS0Q+JQabDgMZirpfnFmf3RSUW66BL62OgvqrfAJaYy
	 aotIv6yWVIIvxajJoxw8Wf5SG401RHd/bTZUJMJwekCPX4p6zMQNfGmEJBgk6KKsWB
	 Nc6U3oXt/6PS+V7M2GYM0dUUyqyIGG/OvUghdfVgTOl3yKRYr/H70Ve0naO3vQ9UlQ
	 Wc/ls0R68OQng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C016640B14;
	Thu,  3 Sep 2026 12:51:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D6D372FD
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 07:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD86B40084
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 07:28:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MW_ivLBPua16 for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 07:28:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 94ADF4002B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788420507;
 b=FcowShZ10Em+npLIeZLktv02kL747XGU6TqOeZk0HIBUdd7cI4W8y+opurtQwQc0Ahwq
 zKbt/JEPGIRyh8Gwyj/z3tukVVzr6nPkabn3JrMB1rhypqlBVMhJpdQ2FSVzTTCbrjGfr
 6jizEf0WcTWuL+ju3M1pi72DQP/yufPfcmXMWirAezrWCwTrDsJq5toxzMABtK4qxGB3F
 xFr577rBYBnhcNsk7OZF91Prq0FSeBLN4V89xA9/MtWlKbTZo/WOiIsh952OzQHuFR8gx
 esh1vn2bTxBADdAj0DMhYa//w0Af4I2COksqagWM35kXqJRWh424PmRhjFhpdbJB+rg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788420507;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=TjZBxnTSVLzoP/V0EqRVNuOkogH/b4p5rg6ZqSfXyoQ=;
 b=RcLDlQR9XpwVMG7PTMQczmKJQbm2ZAG6dcSqcIHajoVat4saa8cbV0a3IZhsME2XVqoH
 xP0DvKL0TRWUWKnBGmrQg6r8WG4mOiMD5EHB/ODJ7PrpsjEjtisyRqVXO98RjzvlHC5JY
 MhiKS9W7wiCdox8fCEp/zcgX+OBTJl4dYaez6HJLvdCdpQr/ZRp12guf+QgMXDnNGnWzn
 2cJPxbTmQQfZVoNxZwKwC6dS01vcXj4lP+alkutyGqsQdAVzX2SR+sYvu7wxgxP5GuQdQ
 Q8NjqaUdXjSC7koS6zW76+EWpuUSfui604aoFzT4yqNpkZ1vw9OUcZVM8MAGsU7TIAg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=qMiKFZPu; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=b4vja36L; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=qMiKFZPu; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=b4vja36L
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 94ADF4002B
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 07:28:27 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6835j4BQ2921636;
 Thu, 3 Sep 2026 02:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=TjZBxnTSVLzoP/V0EqRVNuOkogH/b4p5rg6ZqSfXy
 oQ=; b=qMiKFZPuJDM/wLm7NkYZgCHMNJpGZ3Qh1tMpf/6hV9rrvmoFgG83P7QL6
 U1tJeTX5Zsf3vUV8YZqxGrkuS1Ra4FgJaU+FbyX8slf+R/g0Cd2iRsS5ysm4Tvym
 +pc3ka5gCcJYU5xF3k4yCXJhEc+pRo9Whd1cBzE5lGCaU4a/KksQq+FFSiXRPeeu
 GogbA8ZsrNNuH/MRfyv/NwTFnW+Zv0uk4+7HX9LUzx1zHl92BgJqjhft0jN/nOfx
 pRSRQ384m+TDzf4pMSorfXWml8zMtZqt5j0LQfrkadHHK14DwmMfu/jrXvFmVOK+
 Mb0AwkQohIa21ojkQ6AR56qDGG4sw==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gf0jv1ayg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 02:28:26 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDckhV18bSx+vsv8st3dGrTkiUl2swjv7vK9cqW3Z9OUtjky0v06MxIonBAl9DUqXn37lOJyR6H1UgeiZg7dmu10CLC0FGCedatVdpNj/dI5je3uFZ0JNcasLoZkOGQLt5+hL64ir9MuuFBjjmum0rOuF1bgsSMQoYDgtN+vIh0giLyZgDps9OSTY+aPIer34DtKQMFM2S6PHcu7C2bMy7VaR0U+I59mL9Ud7WDOa131gt16CnzuTdMKiwiEcC4SrIkALKQoVkS+At5hNKzDCfV04m3kE2DKoGinKe8YYOUFrvWJAIi8bql/wMwkPgCbtajfzdNpvJaiSPl2fSgb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjZBxnTSVLzoP/V0EqRVNuOkogH/b4p5rg6ZqSfXyoQ=;
 b=pcgqm0S6AYFIyUr3DsGwq2GkNqQMt2wRXu/PyfULPBTDwfDyY05bmgnK/tg2aDbiJWWMU/Ur7D6PXRpoQg2CtfWwxMSolBxwFLNrUGKL8PTbmD6CLrlsojNfydbfWoJ1C0Rih5jUvk5jQcawRyppfPbBD6xNHqiXLlUM2eaWsmpfRcU1S9Gy1yM1lF5M3M7a537r+QUfPcms5i28datkI5ig1aeOVF0aeuL/Nc8l25WR9lK64x804LNmLtYVFhJTJftcJj3iKUb/tJzyjfH+CJ/GzDH7F9cNhZdt5ghXgOuWmOfqCBvAr4GIGVqxdtrHZOFoku7BQKx6RbVSJdgEew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjZBxnTSVLzoP/V0EqRVNuOkogH/b4p5rg6ZqSfXyoQ=;
 b=b4vja36LZNRyhdGhjtplZKBuQEYByGax9n99gKcRfmDpXhRnwEfVbehkg7lxApGkI0ke0BG7oT7qwbYikbN+Ti2pfDn3wSLN7X8GsEAAgKiBUTjkb7rLvXo6i3ddlFFpydxOG17T3yUtqjFbkhtj3pxcNS0EHxBTIB1RjZBSAdk=
Received: from BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::17)
 by MN6PR10MB8189.namprd10.prod.outlook.com (2603:10b6:208:4f8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 07:28:21 +0000
Received: from SJ1PEPF000037A8.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::6) by BY1P220CA0013.outlook.office365.com
 (2603:10b6:a03:59d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 07:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000037A8.mail.protection.outlook.com (10.167.244.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 07:28:21 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 02:28:17 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 02:28:17 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 02:28:17 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.51.66])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6837SBAR1110504;
 Thu, 3 Sep 2026 02:28:15 -0500
From: Gokul Praveen <g-praveen@ti.com>
To: <trini@konsulko.com>, <g-praveen@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.u-boot-project.org>
Subject: [PATCH v4 1/3] configs: add A-core no-SPL mode fragment for k3 devices
Date: Thu, 3 Sep 2026 12:58:03 +0530
Message-ID: <20260903072805.31010-2-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903072805.31010-1-g-praveen@ti.com>
References: <20260903072805.31010-1-g-praveen@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A8:EE_|MN6PR10MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a2273e-05d5-468a-6f67-08df098cee8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: UDOw20QErTTgG5AyAqZmtVNeCN+Gwz/yj5vl1/0ftm/tfyiyw2NTFw3HYlfGloSf0d9l07X67Ue7aHarC8E9xnMFKvh50Y/jj3LIBd4vnHRfNWKQkpvcD8NeNF75YTU0p98N4QHDaIyVyJg62OQWoaMhdIE2WHie/ycFHIgecgPg2kn9w0AdhiHrnLQHyrXETwZa657VVsUhBJWtIW69Rl/QsnpUgB5gPT6Ug2sN0ywAW0qSPieyErdM+HaA3XheW+cEVZhvPfyUU5PvFtjBpemdsYKXwwgWbRD7q/Ewed6TZwAN+C2ikiyM/4Nb/cnRvuCmmWnKWh3576HUcR6Cvvz6ZnRJjlzXGJ2Z5h/tEGmwYaLSNYNqPPDlTQBZIbT5QXy/sPCxBR8fHxcTU082/+mXFtfMCAsZrkUT8LqR5MFpeTZJhWFZWe7rKAER5eTN0RePGvnP146Jkla/bQPy47JzlAVWe59Ltzb1e0yVVGOH4DcklbwcsWA8hxd8iLGKlCo3WnjLpkLr/vT9IWIbOz0yQ5Di2WzG453Rf0tl/8CxKxJyj5p8wXGa8uBP0t2cVeds1tdUt8+iAQPWgj7mr6EInoxihGNqDUPULwfVE2IIFKWEOkyWOsyfxG4P0GOd0ZxDjfAAgZ1oy46Unr2zJY+gSlzJ8kVHSVsJmIYY8rUs/F14k7+EScf5wMQqqtGVKP5qqiKKhRoqHwEa/TYV7w==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mRQjF4qt8Gyl1YcuDiXF/ybod5tF1Wm2YekakpeaGtEUQJyTv5mtJ0adaeWcgFNcvCThFhwD/bbPLFGnnuQ2zHS9GjSC6cPgESjdFvUjt6d1OXU1RfXWGGMROgUqZpRKYlJCZE7aW6ZGjXfTtyFyloq2Srd3oIpzki5YFEhZPrJoufGhD4x0gfvfdCPYnDvaqwW0o8Ufx+Yaz1HxWbHz1ACGZsvSdqbI8mrJsZWjF+zxDToeZSh+nvW3PbIIYjnm9RE7m+NKko77JITGu++y6IGqLKMGof8qtnM5IV7EMmyDbEfBMN093ScTuDCBrDjPPfpycGUF9dKSHEJ9/IaB3J0Cbt8aFtTQa0bK0dAIDz43eSvNdfinlCbGPCE/oQzruCJ5P9vOxbXBlQqUs/RmerGmhObSA3WxP5dFk4OxNCjsLgDznvJUucjaXJBbFnHQ
X-Exchange-RoutingPolicyChecked: oVl+nT1wU2fMWYXgrZphbhyl5TVCkMoqSki7EDJdVpUnn3VAa2xUlwlqfVxxx54oimO/57kpF81vobIQX/+XD/U2uOA0HQjsoBykXkehgOr1y7Hmy4XzJYwGtKcUH592NsPMb2YoVwMBpQBPsE//3OwxQA9JgxqELYT9/Ryntkr+p/XxL9Jo1D/6LK/QAQwx0Ra4C2RkfSMZeDDrfleSdX7ElhXJS4jj2s3Kor9eAyMn+8j4fcfqXVpPI/TSXY3+Xm/ywLk3ZYr4QRVEint5a3oDNXytsj4tRWEjW4hfHqWqDoXM24piUsRgHlIQ2uMoCcPbqn9z88bjFdnXHwvSDA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 07:28:21.0720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a2273e-05d5-468a-6f67-08df098cee8b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8189
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA2NSBTYWx0ZWRfXycjKMR+LHAYL
 8/lFPoRKhY6xHGWdNbWMkdm9ZiO7M1TiT2qG1f6cbPptT3GipznViSJOe6UHIj9roLCb4ibq4UP
 ZgsyiRIbeNJefonsXEJcJ7T550dpEQ8=
X-Authority-Analysis: v=2.4 cv=J6eaKgnS c=1 sm=1 tr=0 ts=6a99219a cx=c_pps
 a=+7NNu1siU3MXiwb9s73WHg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=TwlV235Zt6HhQwVfNlwA:9
X-Proofpoint-GUID: H8bwf98UMfhL1_2Nw49fnIEHrx4TqGjc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA2NSBTYWx0ZWRfX5uc3br/svb00
 gJEpXtVpISL7Li9rKqoQuJ13xLFMAYJke0XtxYrQJhOJfpui1Pgxt5ybc6c+NYwSZZW7KPvOmO0
 V/YhuodoIVIpxa141jTGCZSSk3udEt7Huh80M5xuUI79RACUfIP+eJfjTXhWPCckHfUGt9a7c6A
 DL3jhtwW9FUiWAqCEVyO6A880r44RNf1IkIdz8eIPKB/Y/fOT5qyxfUjYnciK62fjnhn4dEJkWp
 3lzG1XqvzNEXvWg4XQPeoWwvbyKCyQFhxLWquQv5mJEgJEMA3fkq23XQ3ZTC1nGqGlNjhzduvJz
 Cs/5CqKTsoshAXUcJvxU2jLyw5a72U1uKnoRzzXUyXR4FkzkigPz+7NucC4MZfckJd1VBMHK1HV
 gndMvxE9kWniGwjEiqfBk3TBcc2OzT6yEBGRqzuvB6hCJt9xaI6mhwE76xogiwOno+gOKlxRZIx
 eB8r1z/33eQQ961Cp1g==
X-Proofpoint-ORIG-GUID: H8bwf98UMfhL1_2Nw49fnIEHrx4TqGjc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030065
X-Mailman-Approved-At: Thu, 03 Sep 2026 12:50:58 +0000
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

This fragment enables a boot mode for K3 platforms where the R5 SPL
directly loads U-Boot proper, bypassing the A Core SPL stage

The R5 config modifies the payload filename to load tinospl.bin
instead of tispl.bin. The A Core config updates the U-Boot load
address to match the A Core SPL load address, allowing R5 SPL to
load U-Boot directly from that location since A Core SPL is not
present in this boot flow.

This reduces boot time by eliminating the A Core SPL stage.

Signed-off-by: Gokul Praveen <g-praveen@ti.com>
Reviewed-by Neha Malcom Francis <n-francis@ti.com>
---
 board/ti/j784s4/MAINTAINERS | 2 ++
 configs/k3_a72_nospl.config | 1 +
 configs/k3_r5_nospl.config  | 1 +
 3 files changed, 4 insertions(+)
 create mode 100644 configs/k3_a72_nospl.config
 create mode 100644 configs/k3_r5_nospl.config

diff --git a/board/ti/j784s4/MAINTAINERS b/board/ti/j784s4/MAINTAINERS
index f9fe9a9f661..133d79502ee 100644
--- a/board/ti/j784s4/MAINTAINERS
+++ b/board/ti/j784s4/MAINTAINERS
@@ -12,6 +12,8 @@ F:	arch/arm/dts/k3-j784s4-r5.dtsi
 F:	arch/arm/dts/k3-j784s4-ddr.dtsi
 F:	arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi
 F:	doc/board/ti/j784s4_evm.rst
+F: 	configs/k3_a72_nospl.config
+F: 	configs/k3_r5_nospl.config
 
 AM69 SK BOARD
 M:	Apurva Nandan <a-nandan@ti.com>
diff --git a/configs/k3_a72_nospl.config b/configs/k3_a72_nospl.config
new file mode 100644
index 00000000000..7522acab950
--- /dev/null
+++ b/configs/k3_a72_nospl.config
@@ -0,0 +1 @@
+CONFIG_TEXT_BASE=0x80080000
diff --git a/configs/k3_r5_nospl.config b/configs/k3_r5_nospl.config
new file mode 100644
index 00000000000..94931bf8798
--- /dev/null
+++ b/configs/k3_r5_nospl.config
@@ -0,0 +1 @@
+CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="tinospl.bin"
-- 
2.34.1


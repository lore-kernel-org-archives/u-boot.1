Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F777C98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 11:09:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26BCE60D57;
	Fri, 25 Sep 2026 11:09:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VmpUTtf8AV-A; Fri, 25 Sep 2026 11:09:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 562EA60BC2
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790334542;
	b=oBdmuNjsefQ/dYy1N9exE7+2OfkBE1Sxjv8sTdi/jHa+F3rnXA5L0uG+mKTFKpcCU/Q5
	 Ug/g+i3FxZKdx8mXeq1Uf28WRkZskLmYHI+1nQVGpnaHmzSoi7+SAV56DDRWcD6WPm32l
	 RLCqr/xUrv3OAQBe0d+14aRsWim9Sc5Y8hxn1qrS5jl0f0j9r1bts3eX96x1KJ16fUKk+
	 MJqMdeMIHKKugaxYoldKkE3CvzlteIJp7M/ZC3uAZEhcpNTD67uH7CmnQvvdAW6Pp7r2B
	 Ay3P+/9zHR2D8M2ERmiTypTM7eZa/EKPUGtu+R+WGLGYHKpR4ZSSQoe2yB55Q+3JAug==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790334542;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
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
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=C6y54mxK2MY4JbiPfxkP1RhD+JVzG70bosuqClNoiT0=;
	b=o5U2WS3qvS2cJbBudpHg7Ntba46znUFuDzE05WIxSHdu8b4M6vIc9Ofnc6qYmfCsohdA
	 aVet+6Li1GjImz7QQOSvdpsxBAqM/bOXubHtiNeKhEDf64QuFKx/2QL//H8qaoiwKVQ2C
	 0PD/DzENVxPOPtz5pqPUALI0Hd+/pung1QfIqrf1UKuC+ZUT6M1C1AnPvD9jZpfVa3JNQ
	 JY7BrHrPbXqc2QEUe3HslUa44CME4q/o+lNw9psnH93Zojh7E/dcQFeml0P9LG5224a/F
	 yK9jgQG6pnJfqk0AXsKCOwydCRxMwA9I55KtljKd7EN88PQfQo8q/d+l8lybW7uYHBg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790334542;
	bh=C6y54mxK2MY4JbiPfxkP1RhD+JVzG70bosuqClNoiT0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u3jgz4tBYBGJav8HNczec3XIiCcbzOQhDBD14I/F+X1d/fGSa3HM8dEyLz4AKcxxt
	 cvCKE2wnjI+5e1nLEFW8bWZXBMQMLYzc4wmyHdAqgfy79H07gqLeTn/sgh18fhcuUV
	 /ceef/HZu9hINGRCKnm6wnwPSDga9nkGqGBGDq2OvmKprrSsqel6eSu3iUB5GJFo3X
	 5rZBPlzxSrdBm+AC6vAzXjfvspMs11j7FWVaNgbbSjQAXQQBMLmRbRvA+/3Hd4+uAz
	 IodSNJ7lTIgATYhCiKp6bBavEmZ0P3rohENXPUNevsQoT6OeJYxOV4vjeHeqUfzahQ
	 h4XPgTNcoWOtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 562EA60BC2;
	Fri, 25 Sep 2026 11:09:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 88BC2D1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 11:09:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A6C240B6D
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 11:09:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BlGC1-7UEMoj for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 11:09:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8157440B68
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790334540;
 b=dMVuJ96+ScDv9MSWNqmO2NARZNmeoJeN7po2XDPkZNL6mkcGHQqkkfjeYPVYtIp4mmN1
 JKI3lPVyVih6kWdLTg/tbK9EwR1asx3GUsJKucRw1Bbwjqj6cc0e4ZuVpkKbT2DiBm3eq
 triMGVCQeXhkSqVGfKvPzkau08Z6fFWlIwytZ94Yo40trwgLgEMe7CTAlUliNFZk10Uya
 wZMo+zloxYilxto41yhg1plSKQX03qezZlHg0orvQTWWQodI53SVj6rp8HRrMyFieYu+M
 1TF51b/c9euzCtpcgFdEhwruA/EVZ53DL6Yp1A2Ih3TSVX+Kja7tpFKM/RJK5sovAlg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790334540;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
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
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=C6y54mxK2MY4JbiPfxkP1RhD+JVzG70bosuqClNoiT0=;
 b=cNJxpLhkd0IHLDJkUAJYyBUij4O3yCf3ClW3g1heeb7yvBy7li+vidltupP6vtoILUkN
 Ynra6B294rhnp2esmREMISv0urSqCm1KWrLFHLzM75yWApXH7nDTuMr9v9mi9YFAg1Eob
 vAPK+q4ahT3+3qY6K5GGWCaoZgOvc0g+k1iMZi6o+ZJ5BuO0UrKkhAPXXwSsJR8sbanlc
 CN0UdGY72YtWMTktljlKu1sDDL34RhLinP86jiI+3NvtVXACyZiZZDtWqJPr7PnSA/Ck9
 vcJTFCH70nnrD724QpleRF9f9LPIXJTEQuOr83PrvGBcC6ioH4EnnPFsf66nS/beFkg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=MT0Hdl5U; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=WT9I2Kua; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=c-vankar@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=MT0Hdl5U; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=WT9I2Kua
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8157440B68
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 11:09:00 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P6G4RK1848370; Fri, 25 Sep 2026 06:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=C6y54mxK2MY4JbiPfxkP1RhD+JVzG70bosuqClNoi
 T0=; b=MT0Hdl5UlT5IUk/n0vnj/UmtsI++mrMW4LrwS6h1vldNzTAj18LfDhqYf
 G2RN3b018yWFhM8PO9kdVD8bWZTpsraxgICHWEaO4OvlmUPpM8nSozcZbw75yS00
 mlIQzFyLtqZJOvgF+qP2DsxQy9lEzaZqtmSrGLREKN8iTPzFZ+yopZnFGQZZa00d
 pJgknnRayv+8gAhecJU0oxk7ZRc0SGrvKR354kyaZSzfYxvBJHhnormH9mJelHhx
 Gz2u54l96v3FEfvG1dzSTAbTFqSTgdiEJYtqQTWFhgX/U/RtOp27S3aBwc2/WnXm
 3HhpapOy1ZQqDlipmnxK9R2QshWOQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gwkhr993g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 06:08:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RECcuYIoQuTLcKXdojb84GpNi1szt2jxG68stFOwoxWlladQ1wjhBQyGpTd1Q1z1OCuWEGjrcoS3s37fV8UVfBo0YbifKmXozLhf7fp9ttOfVuEj0FRul3IncicbXUptk03qM9yHIDXCKG+dHtJaOpWnl0tUdzKAqWGezRUo1x9cEjf7SUoNtAzhmCrW+4Su/7xJ1vFgGMXnnfHgDBEpOVsCgQoJsV19DwIj4clzcT0t805viHyFaX9mMTt8UOYY3ZvgZjLJ4UOkKZroZyZt0/h30W4/FtcaTK0MGXnw7jSYZ6xCIy99GgKr84rhGGLruMz6T5oYBInmbXktLsyGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6y54mxK2MY4JbiPfxkP1RhD+JVzG70bosuqClNoiT0=;
 b=lKNgRi7ZA8ZrPBw3sUPfQmAYyww6CgYV5COyIZ/AVaWO9tz2Wv/MXcd8+kbdJkb1IGtRtVOhEg8RsrW3J2/GjWO8qR1/l62l5R8/1uP1OM4CjLa81aXeQFo3wcaZw0QlLGzRnveiMwUncWbSKbYkqK+KLUHw+1neCK9Le/ht2vi6mQdyanRmLK6aykAJK7wLOQASqeBheOyll8Y7Wv414KYGjTlTPbC90qPvYDC2RxrpqerpeAxeWRTSrigFeVmpu+WN2C0WsfpH+s0owXA9gKlJPX9Yr38S6xpgI+MfzxNqxa8jM1OmBcMFeN0hh5Py2EVXfRAQeJh+FmXgu9X6tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6y54mxK2MY4JbiPfxkP1RhD+JVzG70bosuqClNoiT0=;
 b=WT9I2Kuaw0+F+yhKxo8PGT31tEoCKhg/lUZtz7stBA0U0I7zeNRVVqWmGb2u0+zrKtbKmCcQ+umClCMt5L1uZH14dlzulU+2gEJRzrNlz5+rdtWZn/N2YzKtBhKwFsHBmwLnDz5kTg+J9QYTViUQyZrMF91euPxuRR1hfrJkBtc=
Received: from BN9PR03CA0726.namprd03.prod.outlook.com (2603:10b6:408:110::11)
 by DS7PR10MB7374.namprd10.prod.outlook.com (2603:10b6:8:eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Fri, 25 Sep
 2026 11:08:51 +0000
Received: from BN3PEPF00022BCF.namprd03.prod.outlook.com
 (2603:10b6:408:110:cafe::24) by BN9PR03CA0726.outlook.office365.com
 (2603:10b6:408:110::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.15 via Frontend Transport; Fri,
 25 Sep 2026 11:08:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF00022BCF.mail.protection.outlook.com (10.167.248.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 11:08:50 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 06:08:06 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 06:08:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 25 Sep 2026 06:08:06 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68PB84I31733647;
 Fri, 25 Sep 2026 06:08:05 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Chintan Vankar <c-vankar@ti.com>, Tom Rini <trini@konsulko.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>
CC: <danishanwar@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH 2/2] configs: am64x_evm_a53_defconfig: Enable
 NET_RANDOM_ETHADDR config option
Date: Fri, 25 Sep 2026 16:37:58 +0530
Message-ID: <20260925110758.843871-3-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925110758.843871-1-c-vankar@ti.com>
References: <20260925110758.843871-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCF:EE_|DS7PR10MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d27f67-8e0d-4918-f54e-08df1af560bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZckoNztgU/PjSMtW5d56FFh5froEoZNS+pBNIWjPke5FnoRW1R7Tq4kd+StmqoNiv4ovTLq5VDz6H6WTolyRIvZPagJrZabhvRrafGtMHmwQnB8LnL+yfOaHetFddWdRz05Xmbo+ysBsFrZNddW9aDLpmmC0lfIjGyA4/oy7deP3AnEDoxGv9Q9j85Pas53QkWWA7kgD6zJAqJMNoIbfjhUFEHsL8SAPTaeTfUGwtGe1Cj0GNoA4IHZHqxdB1ZRFKAY0fXdcujmPjwUUkrNC9gt0U8dI8hD4SOh9DJgzoqIFwhHTEXL+l1AGGuuDdjkwRKO77nxdKL1njkA9EHz/4fn7ilwzffWf52WVlNpbuMSYnSMrlXtU6d96IwirV9vxKsRApy/lSf67AynD7Ayo6Lyjd2eTmDMF6z+3bg3bymeT9kYQwZ5b+NtEnyyJZehOqzAyGivCLqss2XQbhAaWiYfF9wd1eOLmrQ5lAmrTrtwS2dHmYVgZVejV7eZGzgw+EWMiGyY4ljuvW4shyMAylc+yYnYQ0Yq8l2hamania4mq5xeN9LjT4b0gLCAP6/JTn60K8K4YQpoL8rZE5nz9q9RInVcyDsXjVBFOyWp89Ki+zrNPlJ5imbJoIg5O6sH76+EDENqRlgTr0bgWTar1MXmndAxlQzkIP7f5SI7/OfTkoiRrtPYWuimdocSIrWqbbvgrfTZNcBSY9BAbOCBZjA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f4pZnfYIyUP5IERf70vDGlwyzx0+oIVjpkryMvJ7htGLPzLZSv3i40sRZ1makz0D7Qwzy5noDHD9aclLG8+NsGO8C6rG1iamcVXeNiWMRlH+a5D0bson9obwUIFfpM3BQCGse0bHNXBNCEQJZHIMVJ+hmOnZcjKkl2MVU6sHAD3QVOSS9zkcqRszWV8CPpDA3U/GQseN/WRmoyWcy3dVQyrWNt6yOc8mDt8EZYs1F1SpBRNbIFjNroh6q2HFl2Of2+Z+wSOxlvuF6FGYiQRXyX4wlbTnv2ttOD7g4Mbcu6VopthC99kC/g5NF0NfFyzHY3mvf3G0ZvS0N/H76ny+cfTkhUF0/I5aenXAng1xmOT0/lkVevagtju7ybY/xOETkkOSqKq6PL3FjEurkrNNkfGvd6zojsy+oZTetfd5GAbViZgnQw4LfI4kw0yPJcux
X-Exchange-RoutingPolicyChecked: h95Di52Hv4z095noYG3KAlIaxB/+Lx3uZa9mNnyZKqvrNB9ZUNfyDvDNQQitEW9hao6xs7dEqGMTIWF0aD8aYs1jY3Xm6AkicskPhalGy4alfYRw/eq0DGSYthMkII3VodnfRhd2q+5/zjakDTa9ltaMhcVPzipOpLvDHUmIfExBlJFNiFsMJY6es0Uu4gQXC+262QpUhtYVC9lmXUr1eeyk4bNNcwFV+/X0Zh6DooAHeK+7hYyCD6hWcSpdRozSaOKtQuo3vomb3imMrkPXn2yjw0MwoFkqpY6DMkZsADuwUl6evRTNmydZkuG8x6+dhYv20F6GDVFmuiuHlFK93w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 11:08:50.1110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d27f67-8e0d-4918-f54e-08df1af560bd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BCF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7374
X-Authority-Analysis: v=2.4 cv=Fv+QbGrq c=1 sm=1 tr=0 ts=6ab6564a cx=c_pps
 a=qHW1pi9L+1RZ0SKNcL3CYw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=jQrUAKC2Og-0jeR-8bUA:9
X-Proofpoint-GUID: 8q4viKd1cVQ8VJ8UZSLn4lvLTwJIlsFq
X-Proofpoint-ORIG-GUID: 8q4viKd1cVQ8VJ8UZSLn4lvLTwJIlsFq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0NCBTYWx0ZWRfX791OnZL9rgs6
 GLCFQbwClBy2q3u0a01rFpJfYuHcXxvav23ko9RoCNdCZdtZuTNhRjzcw7avvH91bSZXjP8Ze7I
 /uKz5sMR4IEgKlzOtSQZV1U+i90ktdu76avwk19u6MLBE+WGsJ3NMAnelvt/xIyIG9bY+hyU28g
 AamL1QXLg/xKZ2vQ3umtnqn9ZxxR5QdACG1Aa4ziWCowfMsxN9orJ9aw4JwrKqdOPxDGCldUffb
 HHkYnbasaviRob/sndUhqtXT2t6yBnRQ53DXudXVTiTt3cz7GaW0+vhffck+3JZbP+iYcrlH3me
 UPopJUa1L+dvuJYYzdfzhK6KoemgqCALSO0LC1eueBxt8x1TZHdMbdI0RfDffq5lmVtodnjQ0Ux
 ISAft53XsGQmAy4rLil7hndlBLCM7jjoMs9cN4nGBOKpu1tNoWm0Q05oh7NRaWkpOVezhy1lmLU
 xRYL/S7ygQFMtQLupOw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0NCBTYWx0ZWRfXwLhsM+7w8tKn
 LalfCHJRx80qp5mNKzu8iLo1KhqasJhswpFQLWlnoz0MqmAb53/gbg6Av5k2zSYAQoS1esksZ5H
 fo9Lqpuwl5Ccl47JkOZSvNaNSQlbLcw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250044
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

Enable NET_RANDOM_ETHADDR config options which provides random MAC address
to proceed with the Ethernet boot.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 configs/am64x_evm_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index 3a35df830e3..261ca6a3ad5 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -200,5 +200,6 @@ CONFIG_SPL_DFU=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_EFI_SET_TIME=y
 CONFIG_DA8XX_GPIO=y
+CONFIG_NET_RANDOM_ETHADDR=y
 
 #include <configs/k3_efi_capsule.config>
-- 
2.34.1


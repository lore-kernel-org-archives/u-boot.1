Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361F1C79F83
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 12:03:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02D0260C26;
	Fri,  4 Sep 2026 12:03:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id krAGVTogSntG; Fri,  4 Sep 2026 12:03:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EEB5360C15
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788523428;
	b=MZhQTwo1mQZYBFyHpMlbKxOWs6hMTHP5iDt38KJCcWHhSugCM5I6LH+w6jwddJlvU9er
	 8zXFU9Upx6sLGZUhqLbv7eyp4cwXIAJA9+Tt2//zGc29sTS8sT26E5FiDlRMRSwvxEiiS
	 tegvjCNtf64FlAvyj6FQCNjXLTabTkEaTlhaemRFg0H0dM3m80M1r86DkAMiCG+jDogJM
	 MIQ/z9Ut3DPFsyTvrhQ6IKrCYNFO9GLXi9UnhHgIcpeyPLlQNGzTvh64HzbJTEqG6fBCW
	 lOe45gLdmJ6UVCBPqCvN+KW5mvDEfcvM32Szo5KmY7Dc+B+7XwI2CI1e92qZbojCkKw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788523428;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tCkjLjEaFK+o+kr1hzwclvOiqd6CZs72cbafvlT+7CU=;
	b=MGizg/ubgKCnLtOt8rxTwdM7XiytyLadq4Y57zA3Q6Ozs0jBwSKbGVqyTIJx3Jh6zMBj
	 WliJn+6N1y/OUHEREhntVkTyaFsde5LHUeJA4xUXvKK0q1+aRYDpRjfSoOeLM/adVUlV9
	 0Wz1feVHl8rRDe1XKBPMIPOjYP8epUzB/7h20P4NyGcAOo+GbQRsdjjUVwAcUUtWnupRo
	 hpW10NMqWMAWcLUM/fDj/IMM39GIoE83s9GaAB/1V6TjSNQlaGTKT+K8kTaNdFK5H3q7n
	 G/724TMEoSdDfdvKWIfg+WIpnKdcezGiqn5eoKmCun35tjZSzq7n//vhLZ02xXhBX9Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788523428;
	bh=tCkjLjEaFK+o+kr1hzwclvOiqd6CZs72cbafvlT+7CU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OQ1djPIDlxq25phx4yXKHLviWdXRrLd3paXy/oCvxRt7IONRBr0JluTbotm9sTogX
	 0mbhvrZrKoF+PU6UIKa+uUDdgAPm8A0gDKHwAjtZoKkgNs1ZO8hJeEwi4AoL/k/3Xh
	 FMRxUzPdsj2Wi76I94B0Tagyw2+Gn9YtKzLDDMAwheGwXmtOGTt9DUHgwXKoNrL4Bs
	 slhrXIPp8p0DIUNqTYvx+Y0PYrnfXViDEfjPw7yHu+b4uE6AoykGhow3OlnELUDzUW
	 cJx6BJQwCaTOVhrHMw/PbfNK/UDPRqKgEaT43fV5lX239fEq+a2kPNBBIMk1GjeeQn
	 mcFd5AdEbI0nA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EEB5360C15;
	Fri,  4 Sep 2026 12:03:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A47DF14
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1981E4031A
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H6rlbg7BgV5F for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 12:03:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6F78040080
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788523424;
 b=gR5z/oz/xydREo5XS9pYx1EEr/+VAleHTdwna54FEJ97AC/lHn3ak267pjiZFOjBV27y
 ebcSAnHrIDTkHkZzXAzIRJWL0WjUkn1t3uxXtqsP9IA+vJ3hQ2OyBgetZfFAW4Ux6kkuT
 CfZSUExY3yvOVvRD3F7WQJJIANJvVK5IGDnA5+5MDPZqj8BAm2g5N3bL/HzikBObuQRpY
 QeyVIPoDVXVlhjJ5okznR36LXs1IumCeV7EplcShrmVUoMKMjaJ2yh07pg7waX5NQV/EH
 GU8RVdkcNcfyW88l3aUdcBlEqbK+QyeCe4oZ1K/IJbCE0wMxhwE7upR9t45h3I6Kkgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788523424;
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=tCkjLjEaFK+o+kr1hzwclvOiqd6CZs72cbafvlT+7CU=;
 b=Z4QY3T8tshRmC5WvMRL+n5VnP13sa4oJLydYY50VD2/KwAoJYfWeftxvF6Zu0TBvVlzc
 7Xre7kDvnb/OxsiSHAsrEZ0X7ZILpZi5PnT4yivWwAaBzLEoiyKqG3ypFAUNHpNI8NPGC
 gE2ZPdjIktMPPx3m8tj7uQX35ZWorhoZTtdkYo7UttojBZgjxu1jEof8qRDf6bwMOegUm
 MUVbpeMM/nyDchgPUMF057U4/M5Y/ypgbGEAK0cZxyBpt4zQPCG3t1lsZxTi+xYM1/+yQ
 KNLncLsOZalXLF0QG5UtHmbNZ7hgH6bdL4vsv64HOkb4tYjd+HvUSX8owTq42R2B0HA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b="lG/LvC0l"; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=atwC+qkE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=lG/LvC0l; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=atwC+qkE
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F78040080
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:44 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 684AHJti1941784;
 Fri, 4 Sep 2026 07:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=tCkjLjEaFK+o+kr1hzwclvOiqd6CZs72cbafvlT+7
 CU=; b=lG/LvC0l8M+YmtfZLtGOoxvm6gDdhbx0qW0huUD4JuUR+CMjmn+OqCvN0
 K9E3oR0yRHL/uImBR7bBca9SpIhr8Xd1p+kenief+CZCNKR8WDVpyEBZfyyrOrws
 7GyaXO/mq4HbA/iNhlWgyC6hu80hI0uY8IIPipbMRIehheJG9xQifLCFWZv5VIMu
 s/WiJMOCvyqWBEiOIW+LWDehTa+Ta3TNJGvoSmQK1TUTI2rv2VFINIQzqmgtCndP
 czVuQeWVyHCZeO7epMAwVWBQudBjOwlMqJBONIP0SVUkNWriMmrKCQH0MzoeKaqs
 YSYalq/pntQ4RI1JM15qEAnQUwQuw==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010055.outbound.protection.outlook.com
 [40.93.198.55])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gfrs31q4t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 04 Sep 2026 07:03:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ks/a/1Ln6DcdViwzO5bOJM6gPislcJKrOh68yMbT4vz32f534rp9hPcz321GPs+xNfWHpGAoJQqFGQBXBqxrae0ueTYAggWQS6TnqtvbHpuOY2RAphGLWiNDGSFrZRRzDAiz962e5VnDR7siKR1Trw7Q3dH9Hdrv5wQx4LHP0CNRs3oVFflw7X4tLvGQZzK7AusVr/sImWoiWjlbGS+p7FS0ckSrTCPOCQjxL7tAMihGeSU9IbSNE6Wv10s9ccyRk0D6aPIJQAanfaA1AFQOizzF9Hv9G15mUDcUBC/YdQIkHCzp86DzYyT9ePfonOsVsIw8nXqfyGrTRvcZYgggBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCkjLjEaFK+o+kr1hzwclvOiqd6CZs72cbafvlT+7CU=;
 b=fUINB7FyVL0JylHtku8RhyqBHmI1qGm9wyIiMQw+OHvsCf9DkbE2r/9vxWicoO14MN8AqIgIh6d649kMPhFOwM31vdKKQ5NEiNy2rX2gSbs2oRSfZk7QOF7+7pEqMd23pufhS0uTiSpEa8t7un3+DZ+GvC4Z7kNmv0RThvXIb/PP+5WeXffkmpTEmKbsW53DEK/fq4PE3F9kmUxLslWeKq6Hoq0dj4maqoXxdSLNNjZ1Jl0mTM4Oo57iUcAzFN5sL11KrmnZCoxjPHNg+XoZXpI0Esd0WclbQXjKo6kAX/zyeYzu/QkH92AD2NJEYiP16FhQem1L9nBpp+Oa90apWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCkjLjEaFK+o+kr1hzwclvOiqd6CZs72cbafvlT+7CU=;
 b=atwC+qkEwn9/+20TTUC0UsL4/TqrnGiykdNv9UaIhIritTxW8Gnu20xxWpfs6lwCrGUFdvrK/HfPzmVzQTTjF3lQhmbSWAFYVl2jkzzvVw/PZlwcav4jGrAJm7qp1QfdUD4rZA8n2J4DfeN225tlTJ8jHLgNs6hFZ7FrPiXdek8=
Received: from SJ0PR03CA0082.namprd03.prod.outlook.com (2603:10b6:a03:331::27)
 by CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 12:03:30 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::1a) by SJ0PR03CA0082.outlook.office365.com
 (2603:10b6:a03:331::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 12:03:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 12:03:28 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 07:02:31 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 07:02:31 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 4 Sep 2026 07:02:31 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 684C2NcH3456269;
 Fri, 4 Sep 2026 07:02:29 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 2/7] pci: pcie_dw_ti: fetch num-lanes from the device-tree and
 use it
Date: Fri, 4 Sep 2026 17:35:51 +0530
Message-ID: <20260904120604.3612484-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260904120604.3612484-1-s-vadapalli@ti.com>
References: <20260904120604.3612484-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|CH2PR10MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac8c26d-be11-461c-eae7-08df0a7c8820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|6133799003|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: kaPWBm4nApaFrh9CZrIeDlozq6/ghiOX/0kiFT1D8AHuya3EVBJ2WaBmmS1uZMFqiREwJz0DV+1yWgfB0MfvnrZnutxyjDK8QWisMEnbSg35dhYD+el+8RhbMHfP384R36894bSR/LoKHWQ0r9uaWusFGiasT2hIsxx9OqWei6gC9yYe7HAOUx/x1e+/Y/++nKwpZv4bFRc8pl7oh4NsXZrpqbW9+QuzZxbC6++jky3OVutfE9kRLJtzAbqSBEVp3fPaG31uZzAtnbYci8TKOqFB+ij3ZAT+NkP6QhGuZI7P3gMCFDKnx/8vwWF7vFcNi88XAlj94AUITmUqE/ncrksrMQCUjQfm+gSLMoL1tIbOUddRGyZaCz6qlBvbjWLkzpcsf4/UjmsXA8VSH7YAJ9SiS74I9ldorS8ACIxD+FXf3bMYPaXbT+xqBoDjSr/L+SNHEdqGO1vLK1jv1kRmAtKxvKBcUDiGZtsJzV1ssnv7QwWQ1679To/6mZ7bMFi5p1P5+OGgygmtOIkzk9LGgOCJNk29vSqM9a1T9G/nFHTRVYUypMU3AlPVQvhmoMJz0AtQqw0f2WMK52dXzmli5h5d5vsHUdnZuvXKoKMdSORG2bv7reRGAVT6xQQdH/YHT14FOXb8x/aRCm27brvwNY4US/3Ocdg1sFltg0ZtYFRUusf2HHikGolmrSyjaB6iRxdtkTMlYL0STfpGQa2o/A==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(6133799003)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QL/vZeBppwm29xqa1jRefps26TtmZLAT+76VU7YqGovcWlqoYX3p0s6VC7O4dmAXKoxbMp9GnzpNxa3HjEe/G/NcdwUU8AATemFGVQGfi+kV69mcLsD0j8oDWqJnDmgShWG28sCcZPKezK1p/Wsetn3sG511NQiKGF5zayD4dKAAUVBq8qpWVTa7izPzvTgxGmd/UCpjVDqzCADEXY/CMIPpJU+YzKqs1ScFeXhC6HIK0aiVIF217tMPRuJIAPFHoxVwqNV27IwSMPbfEswJ2rIrx0xaQquNf3IMsi08hdXZ5Z6AWDmRQjzGtZKV5h6TR2x0+3b15v+KZnsOdZTeFz4J7ndVhrecW5BJzi7yGFNeaCiWCvZBIEr+2L0PIPRN9TW+mOFjVaKieEIQb72q0TBsKL6eD0TvPhDiyiO8YKrBTNp0QN6IBcG7P3EYlu7N
X-Exchange-RoutingPolicyChecked: 3PrL9TNEjMWmOVwp9hKDwW+K79wJUkdTWHOMsCziIRO+C8Y7C6lExCROLZgjO39W/DmL98IchEam8XItQGdMit1aWj3c+WEJhhO8sFA7dLIQxaJT+5L5hlsoWIRtL59hSsyarFWe6W7Q+HO1VtzYztJssmweEtjb0z8OrEBC+XOWMg5DYPoA213qDQRpyCOUseaKH55m3xfgyh/2W8M6YegIw/0HS9HvUBqTik7sZLTg1TkdBAaZvt99QsHw1weM+Ip5Xc3GDQK2k/IQVthd0lQqG7UgsIJwWkZRqvShaxd0Lu9J4kVxnF3SYgytQHcCZAXMcLvEwJw9v2xUzSxViw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 12:03:28.4692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac8c26d-be11-461c-eae7-08df0a7c8820
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4360
X-Proofpoint-GUID: NiQ5RYyLfUcOWIMrFZEu85p-1DIUl1ag
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEwNyBTYWx0ZWRfXwBr7WQ7k+SeW
 6rgk+d5Cgg+bbuLUXQlYi9E+sc0EJYj6WOgDRTNiWIakqZdOkuExAtv9l5DbSIRKMlo57RcFe7Q
 cc6dJ473URH+lXTUqDv1I3TEnpH7s0I=
X-Authority-Analysis: v=2.4 cv=GshyPE1C c=1 sm=1 tr=0 ts=6a9ab39d cx=c_pps
 a=aDjbMzJe6/auvryAEMJQMw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=gzyk6xmW-C9wgJ78c1wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEwNyBTYWx0ZWRfX5xX8vDm79aTo
 hT5x5ism5T7sESYN/ksrNnNoHYg9XPXlHD7/Ntuey3gOzNfjlLWhufUV8n/RrmYjquNysf1/vHt
 LkeyQC8BaBeiGnXbKe8Z6s1Hd1jIyazJLlCk8b4DsKoAYI2wPQdi6w/sUjYWtX0wfAX9R81ixwk
 0uGC7HWrvC8r+rXJtWR4/U/xg28xrMcKyhJXPrP97kBo3cw2PWt22sLFE7MwlFoMYv2oyrP2o/0
 vv5VDekGBcryaTkIkacBZnIXwyCqEzLmgZ0LJHh9UNgxJ+gL2g2DMn8jVJ2wIQ5ASQrznndAX+w
 x9/lU3bGsuOkEyUIiMwSgkvRbVdqy3PbTVK+sfLa9IShuu6l0LR6BLgk76gsJVqwuLwLA2Qso+7
 19rQOhTLCAB4nfEw8qpEh0ybgBwEU+OST1vjxcvyglQzAMtCb+AAC0Z8Yee1gUCHm/8pUdTybpF
 wQbVQb9IFe30FSKznhQ==
X-Proofpoint-ORIG-GUID: NiQ5RYyLfUcOWIMrFZEu85p-1DIUl1ag
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040107
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

Currently, the PCI Controller is programmed in a '1 lane' configuration
unconditionally. As an improvement, fetch the 'num-lanes' property from the
device-tree and use the specified value. Fallback to the existing  '1 lane'
configuration in the absence of the 'num-lanes' device-tree property.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/pcie_dw_ti.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pcie_dw_ti.c b/drivers/pci/pcie_dw_ti.c
index 37c295fdd38..fb39132f7c1 100644
--- a/drivers/pci/pcie_dw_ti.c
+++ b/drivers/pci/pcie_dw_ti.c
@@ -58,6 +58,7 @@ struct pcie_dw_ti {
 	/* Must be first member of the struct */
 	struct pcie_dw dw;
 	void *app_base;
+	u32 num_lanes;
 };
 
 enum dw_pcie_device_mode {
@@ -278,6 +279,8 @@ static int pcie_dw_ti_probe(struct udevice *dev)
 	if (device_is_compatible(dev, "ti,am654-pcie-rc"))
 		pcie_am654_set_mode(pci, DW_PCIE_RC_TYPE);
 
+	dw_pcie_link_set_max_link_width(&pci->dw, pci->num_lanes);
+
 	if (!pcie_dw_ti_pcie_link_up(pci, LINK_SPEED_GEN_2)) {
 		printf("PCIE-%d: Link down\n", dev_seq(dev));
 		return -ENODEV;
@@ -332,6 +335,9 @@ static int pcie_dw_ti_of_to_plat(struct udevice *dev)
 	if ((fdt_addr_t)pcie->app_base == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
+	/* Get the link-width (number of lanes) */
+	pcie->num_lanes = dev_read_u32_default(dev, "num-lanes", 1);
+
 	return 0;
 }
 
-- 
2.51.1


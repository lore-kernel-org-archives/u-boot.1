Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB6BC5DF88
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 13:42:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1DE040687;
	Wed, 19 Aug 2026 13:42:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OfVkkXMO8kBu; Wed, 19 Aug 2026 13:42:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787146924;
	bh=zW+io1ds8jWrdUjehc6Ka/EIC5e2bejj74t+WcIJ7f4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FHz9g1Y2THtiKvG5hye78N4Lcl8Vka76zcA4Vd/xkxxoFcFxDBDUvOOqhhePOyBe0
	 ARU3oPcKgS3230bcm2mlgj3hj9qmHwofHPGlqLYrW7Icfb8z9Llr4DCR2LSt5VJ4hE
	 wRH80Tl9UTUO6koQVcFfcg5zSvKlWXMp8ZA3RSRmZ6yY6xlRdkBPnuJcD8fxSoevkR
	 JwVlHjShMVw4mZ8Le621xkw7CHqo/VBygPRktvS0Bexj15PVde/iWP+ubCe/JIflbf
	 VilXs3s9qNuJGa7P518l37QmHfBVV7HlexOJB3lIwPhWGDt6GyV8lOh52Fg9XcWMKH
	 q9/DfQ/Pnq4UQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27E9F405EF;
	Wed, 19 Aug 2026 13:42:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E6632FD
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 28B1B40077
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:19:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L5HGbBT5wkjx for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 10:19:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=aQbdxP3f; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=xVe2ORdm
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3CB5E40042
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:19:24 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JA6Lhe2182261; Wed, 19 Aug 2026 05:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=zW+io1ds8jWrdUjehc6Ka/EIC5e2bejj74t+WcIJ7
 f4=; b=aQbdxP3f70oAubMz9FN3OtJvYpDPBGxM3xb40bO8zCBWTgktfZf9EnRZ2
 xt8x1pb+SRehyD1R2onlpZyvsPQ/P4OFTN9MARiYgBlIYEi9AJFJ6vNR2iNEVMWe
 Ct51dE/yZUEGvJ70u8j3D5OTxc3wpkPJpHm5IO7v26QfgHT7J9M9lp9eXjL0PuQt
 lHtjSOjME4C6XqQV+rp0OIY6D9YG60W5NiKpoZ44sDYIULxByFP0lnmKXUu6pZov
 NKQ6aed9a06dafni4f03RKxfywGwIFYIGfyMM7Tyr+gqnBPHweBpzmluk7jLHm6+
 q0pPs9TvDbqgPysbmfL3c/zuEzHMg==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012016.outbound.protection.outlook.com
 [40.107.200.16])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g4yf3btja-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 05:19:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUoocGeRBT26kxHAbFLmRlVIhx2m2WMpEYnQIO/6nWjHjwwxWAsXaBbtMWoSn8r6+Qr8RYSsB6/ODyFGWV3A8LNZvy0zMBjOGLnOodb3aU9KM6aO6cjJuNn3tHx8SQi6IByg6oZTelb13AuXDToAn7BVhW/yoSeu0hMl+IpSicdFn4+9kfvnoX3k5g3ZiTk7NTlE+rx4A6R7RcR3QXaGegSdxIKhAWyWFB5iVU7S4rg7fpC+1h70995xBDdu3GCd7dqxgFmmbPuvMsJKsBR7T+P3mW7uyp/1S6Hqs8wiyHW+j7NKSH966i8CRQZLSV5CcJL5ahEdbCk5KcYuXgrucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zW+io1ds8jWrdUjehc6Ka/EIC5e2bejj74t+WcIJ7f4=;
 b=rV2eqiC1tJobYsNrK8ltS9OxZl1d4bpzE8cGrbaopzHkw1Ls3Yz2+4ftM0NhYDHtYfe67VdjiDr0JCjNlH6aqZp5UlxvaJDHkNuoHw8gWw8oKvDTCSQc7bRvMTNrcxcUPc77LczJYJqEVqvt7SCPoRVaflKnPd7qkvIzf1TZzHDqrVtiB2B0zu/uLCFrPNz6Qg8/Q7NgY7oWhv7wfDikYH9di8ZA7KcNlyalbdB3Mxo+2Jl3tf84XmLF88sPGG9eX+lmVokxDxcHoy28ioQ2r779BQ8jhOtRhCwwDx1RZjUtb8arkKdQV953UvayOqtnXf5KK8GGZhzRme1W69KNBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zW+io1ds8jWrdUjehc6Ka/EIC5e2bejj74t+WcIJ7f4=;
 b=xVe2ORdmudMWFpC8sv8lwRKGE0jLpVb87nXhtEa1NNus+efm6pC0VOgkbG5F9P9CHF0U1JmKugntkMtZbBLKXnBiqu/5HAi2SiiC/ajimzkB4m0XI5z0MhbC29Nq94dTNaOlZw5jRVLXWBDolGm6LuRgvyZkIE7cbJTetRP0T/I=
Received: from BN9PR03CA0142.namprd03.prod.outlook.com (2603:10b6:408:fe::27)
 by IA4PR10MB8303.namprd10.prod.outlook.com (2603:10b6:208:567::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 10:19:20 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:fe:cafe::92) by BN9PR03CA0142.outlook.office365.com
 (2603:10b6:408:fe::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 10:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 10:19:19 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 05:19:18 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 05:19:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 05:19:18 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.154])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67JAJCin2149110;
 Wed, 19 Aug 2026 05:19:16 -0500
From: Gokul Praveen <g-praveen@ti.com>
To: <trini@konsulko.com>, <g-praveen@ti.com>, <n-francis@ti.com>,
 <a-nandan@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH v3 1/3] configs: add A-core no-SPL mode fragment for k3 devices
Date: Wed, 19 Aug 2026 15:49:08 +0530
Message-ID: <20260819101910.39192-2-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819101910.39192-1-g-praveen@ti.com>
References: <20260819101910.39192-1-g-praveen@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|IA4PR10MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a165213-ba88-4cf3-03bd-08defddb54a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uKl1yRrvJx1DPGqi/U9PcEMX9Xvmm9JLbGaMBwKbo41Y7X703Qq3R/8YZiGCLWPE1JhZAvOounEgqLbnYj26mGAhNn6vYmxowb6DrHBHtcvi8GFhFhXlqthiznRhWd9YmFna/1smz1h0HtlRfYIGx8xtwrMS78oU3AvzMLCaUaJR5jfp5Hl/OWazYuv3b4rV2e4Ffov9CpxaTqOBgafEsUXPUEpCSVZlGSxocgp+FGb5RnJEUtZGE7nqKV4MhhoHy2kay3ubETHfNexWq8PGvK0nsP95n1vQt0Y4d+drlp0un2zHKUQ5V4OErJl8qXAZo5+Uvpg6bjDTpV/ZMGapFjKSmg7H4DFgMAWe65trWTWEjJoCJgwSCLrTGMGYU6TlzSDn1kIKrBwIdQfWbfi8bVLRP5yiFAfo6+V5P3JuVtLYK0tVi0vGp7uM7U1eZWodFqpLcCFfKHma35GaQvg5T3qAJGtnY5DuIQJd3b/7PAg7m6EtovL+BALrWOXRrpZZI6ezsYzLO5IZgXIoAIJ6thRiL/qjTQ28mxx/i+NE8hcDiH83s2stJqQkqKKzH/bF2UgAwX3qc0waQRhJYICfGy9gHLLkqdoDnHQt4PDlKu6kO7rnEDmtXZ3gLCoRsnYPxyFCuMv/SzT7bDL/Bc9/Ba+X2lXYaN8ob74+UtXYPAZo2YDe9W/sbr6tBso/1E8bCoh1BaaoD84Me3iHwI93XQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9V717LzQlY1iSMdZRt9KReNSooYACxjnpuJz33R9NPtppCidh1QZE2I2HZoK7QXHjo+76P7s0ngqu3G4nVztVCrd2Fzc0LGKIp95nLWVxbugUrpQyrEptkNmCYC1Y9ySB9AHolyOCzmCf6kDeA0dk+wjJe9M0TPLkkXf/8QeNoxpb0jLs823LLgU+bS/qgMf9rsLI7rh5HBZUVmtjVWbwja8FFp3VxeJj1VmyWtBoJWQZRpvMvYE7gpsqDVEeik+j4Hvnt3ZkuYHnghNeWZckJA7qZQ65VLb0As9Qr7p15i6PiYjQldMaPcZxLBILrIBGy+DOmxl6NcThlkUYk/MLFpQFN4uYiLAgV0+V4G+RQ0DStYiERwWEzf1phCZOakmj9LT1nbOdudD2ARzlVcjdFejTrneRawLtpoxXk8Mc6fLkFDXZcWfZrTTecbF7Mox
X-Exchange-RoutingPolicyChecked: cdnI7a9R2s4Hog1isxBQmmjplNzegqtRL8Z5oyk12c8yV1mtTaJLh6Cwsp8NW2KuR6lHgUIusB4w8smAjndZMA55fm0nSmQrubnzbfG18llYUKqPCcEwG+6+hXHn2+ss77eGF/ZqPFroZ3vuDCc+8dj+8qhVTB9iVK9hT3n0spGTxBhpWz7wQUOGOvyxdTek51SIVptt6opuLeKc8KAAOKeHNh6tHc/tZBglde50YfGKRRPHnfU09bpcLlzYZoBLFyvl51ZWNwaWPYay23H3MkYeU9Kof202oGKb10cZmsebaCLZot8Sr7jK1Y2abdbrELGINfMLwunM0xmHaQBw4g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 10:19:19.1996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a165213-ba88-4cf3-03bd-08defddb54a9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8303
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA3OCBTYWx0ZWRfX8UghE1JJ4dCG
 Xfg1ct+fqT/WjgtcgJc8Zso7/P3LU2jPzAxnFZMovRnmO6jCmlKRNLEmDTJqWIAm7i7Qpy+8XHE
 RZmklEdpnZBZuXZOg468YJ+GC02eSvQ=
X-Proofpoint-GUID: AixXS0my9lfVEM-Si7NxiS1N-w2jgP5L
X-Authority-Analysis: v=2.4 cv=drzrzVg4 c=1 sm=1 tr=0 ts=6a85832b cx=c_pps
 a=2LRq3VT+JIpsXvqoN2bfxg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=TwlV235Zt6HhQwVfNlwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA3OCBTYWx0ZWRfXxxURJvpqaT/W
 6NMyC5oZKtfKPw52JflZjk1qSFxBkmKcs1KwXK8s4/mjmbhDgWSmONF43s1ZL3jHAZBSZjQb1Tx
 dDHegr312dhP8WIwLhCvLqg4Pr29/eVk2qlsGSSi8u5Q1HEghdsAba03W3iM1hsvjK4Jy4omQMJ
 oKIupE54zPHTbgwzmhVmMdGR53p5RxHcemEOn+ibDDtWFAQFh5ql3gcCPB6nbganLp3kX3rQW1Q
 UzkiDFGYMDWVw+wXqBN0DcogJ3x36xNrd7GIGQOdPmyagf6CHbxD5XhKihOn+Uf4rgdt/VCWZ4Y
 KiCLQvPre4vi0bWGNICFUE+TPXQiSem+7s05kwir2joygt2ew39XP6hsr2xwXIbSNisGByLjVVO
 iMhg26W/0o88o4sZk8KAVDbYz/xGniomucqrDKnP6IlGYvsfrB6AVBZ7yUaMaMkW4tjnRjwdSsq
 dKybdpFSuCuB7k8VnRg==
X-Proofpoint-ORIG-GUID: AixXS0my9lfVEM-Si7NxiS1N-w2jgP5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190078
X-Mailman-Approved-At: Wed, 19 Aug 2026 13:42:00 +0000
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
 configs/k3_a72_nospl.config | 1 +
 configs/k3_r5_nospl.config  | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 configs/k3_a72_nospl.config
 create mode 100644 configs/k3_r5_nospl.config

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


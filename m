Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE381606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kDKF02vv;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=cS2S9VlL;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=CUahd8eU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9C6380E0F;
	Mon, 16 Nov 2026 05:52:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0oKvN3MAmmQg; Mon, 16 Nov 2026 05:52:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 107A580DF4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794808336;
	b=RqwdlH4xpdWpMxQ4A4WTMVj4Pbxn9KfJaEOvXE5xvsLWFU4ekdBCYcceKW1UgFHQxZ67
	 WLerjcAW5AI1dv2JOZyvgiNTCvrliP5kvLOCDL1+D2i9eXueuK/5vTbFe6yXe/6VXHLX0
	 jibF5PPqHWJu7Y/zW0Pi4HYLBgQwI/VbfTNS4N+laet/ImlyHKACNK3f/Mb8LAeI3ULR8
	 9aVufZF1qJit94kwFFLj667mZmH8IYzFm5CG6xuJnb+nbjXJTGLHtA+TJXe7lPF499Y0e
	 CfKPsA1ktyNCxX2TvtTjbCt8q98FeCLC2qIWCo0QKBMKUGtMEGnqtIMzhqx0We7HTfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794808336;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5eyIfibM4KF+YtEm4vUUnYuMA7oH1zUJgcoD3R4g+Eo=;
	b=QO9XiF2bGqkUO9SJ/cMj1CAaFE6fj1skdv+16vfONlkji8XYq6YjKEOvzZubnhJUqxu4
	 YCv19EB1dL+jatKpvsMm47ZNit0wJn2auLUAjeS6a1ajzmuYZIAXjjwKaIdzmMh+RQ0xW
	 xSonjmWVOV8K590Qt9/mubsK/8aGkTTSau/22yjVZq7eoNQThhWURO2E7U/POnwGaq4J4
	 pIOONqaq4l69UzDy0xZG4RJ1EV2/7+4WvX1LZPuFQffwg7DMRXdVar4IaxyMVUb4pJlwg
	 cU2hYTjN056C/UwVwk/8MxydXrSQdrS7ZPUotDNdGEzKa0kzMfgqdl7aybFJ6Pr4Ulw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=cS2S9VlL;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=CUahd8eU;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794808336;
	bh=5eyIfibM4KF+YtEm4vUUnYuMA7oH1zUJgcoD3R4g+Eo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kDKF02vvq4lQAsLrXu0HW9rFmHAbmmmATzrpBRfUCQekR++bZhLces/wF89nxj4iX
	 uilOiPOTbY0rbShxNr04+TqmyrH4dHh4kOJM09PWAV1yDWd0sPW0molebXmQCuyQRq
	 TqidR/CHDERefcphAceEA6ZKuRhtmM+AbOU3b6lAWYKWIyxXvMdEzHW8fkndnbHwdD
	 cPUebvY9ZVjkMAsjU9wMglPPab2thmdkouJqMiFswlZMeMl4PgbMJkvIejJdAb0RLp
	 5doNF2qosv3r6Uyx2+dU1Ln8s7f915R7VhM1KoqLITXHK0CfFbrrf3V9o2+p8afIWr
	 0+SThZD3DQ6uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 107A580DF4;
	Mon, 16 Nov 2026 05:52:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B532FD7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A73A480DF4
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:52:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2cLRdKU_ctw7 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 05:52:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0199080DE7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=cS2S9VlL; 
 dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=CUahd8eU
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0199080DE7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:52:12 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AG4QrC2318942;
 Sun, 15 Nov 2026 23:52:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=5eyIfibM4KF+YtEm4vUUnYuMA7oH1zUJgcoD3R4g+
 Eo=; b=cS2S9VlLDjSW7avkxBpqf5ZBZLH5CQyzS1XMtbYgrrNvXpFgdIUqoDv/a
 92DoODZGHyic6T87a/0li+awBAgi0v1WYTxL/MnWbfplAX6y5L2T7k0VSg0pah6F
 s1raeYaAML1wHBufnmROZdQtttZZgROaVvozBPh0NMGAklfyn7EzrTgRARyY3aQG
 yWXrK+2k1YqXOwpRTcooL9MIXXPLtlUwzcA0FPsOG9dvGVefzlSYNrHsEVniAfZA
 DNAjingnfX18y6M1DHFZ9TFag8sHTJY+XCDwGUP44zTe3XJz5NVF+EhK9rwg6DsO
 CYf3UQOy4NpYueuVXcNy+wumdM9Jw==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
 by m0380145.ppops.net (PPS) with ESMTPS id 4hy9j5kpf8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 15 Nov 2026 23:52:10 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eyIfibM4KF+YtEm4vUUnYuMA7oH1zUJgcoD3R4g+Eo=;
 b=CUahd8eU8XryikovhNXgNrfV2r9pdYhUXhAst4P0TcNMkB0unJl/tdz3is/Nj7tUklgYaO1MXpv+NLniR+ztEeyGwaamBt44PArwRaGnZji4NzBMifz0JggsNytYzpPnRIu8bguDiZE3TqO/8ogS0RHAADh7ozzlz8xe24D14Hk=
Received: from CH2PR04CA0019.namprd04.prod.outlook.com (2603:10b6:610:52::29)
 by PH7PR10MB6060.namprd10.prod.outlook.com (2603:10b6:510:1fc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 05:51:06 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:610:52:cafe::33) by CH2PR04CA0019.outlook.office365.com
 (2603:10b6:610:52::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Mon,
 16 Nov 2026 05:51:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Mon, 16 Nov 2026 05:51:05 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 15 Nov
 2026 23:50:51 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 15 Nov
 2026 23:50:51 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 15 Nov 2026 23:50:51 -0600
Received: from toolbx.dhcp.ti.com (uhda0492258.dhcp.ti.com [10.24.68.238])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AG5oTbs091724;
 Sun, 15 Nov 2026 23:50:49 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 7/7] configs: am65x_evm_a53_defconfig: enable support for
 PCI-USB2 daughtercard
Date: Mon, 16 Nov 2026 11:20:07 +0530
Message-ID: <20261116055029.3493551-8-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116055029.3493551-1-s-vadapalli@ti.com>
References: <20261116055029.3493551-1-s-vadapalli@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|PH7PR10MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a70969-6b46-44b2-7f02-08df43a59a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|56012099006|261021121427099003|10067099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: TxMq8yZOQXthg/te8rjqi8tuaaulBXyUTCqoEdqYJ+9GVVqdZa/GzBvblBvGzL3yYAqQ4S5paU/HJWLYw6MvKXJv4a9CWqIq8iX1eBwI0osQyf/F7UKV5+8HDddxpQ6wXt45JTgR67yB2jBYZ/XYVQ7b+kPV12uk4Tbjr7NtezFGoY6bGwwCmjToHgfPnK58RP1a8ALu3UH7+s0QULiq/AL4HN6nQFu4X6VNfL1K+cnvcim+SqupWmzshSlVC/Btdv4zuTGwoNG5WjJeqTO6vPCg/Uj10bjtlGxFxFUv+RKH7eHHli1mEJE/dluw6lNGY8RxpV971g5Picj1V8utG94veQnO98T5WMBEEZH5IStNrSmJvRO7qI0P0VBz5k40vzFHr+2qmJMEjKjyoPJdSvLdVpNxI1G02NLkzN3k1nv33JZILYoRbr89jAgt3zAwe629KcwpUbadEVBj/KSWOP2EZiY8uhq3VF6HQ9dQCKwOmFDvszEPt1Lj2Yx4hGdLvMoBbQu0HCqDuIuYAcFi/qmUH5zxYTY4cK2chVcIumT9SNEZ+5MrJJ0WgAh0mzUQR7Uq2pHwH1DezdlSwVxhl7cxKEVxJjEAEy1KJvLIv/goM2ewrehltuP13qybgvpEMmNdt4tg5MXUQdwzVqlqIyZ+4chXhL3A9X2gdH8kJEkAnOQgvpQPAPwAMhcXgH+WPrF6Bd0t7gTAFGtW9npgtQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(56012099006)(261021121427099003)(10067099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QpOw4Soq9b6mLIa2AILFtVMsyVJdYot9PYjVg27tYPfwQUTijmBUiXuu1O2X5wEBeSYi4WY2qe2sKoq89XEOVIHgHkyX6O+UOIsGqLy5mQLEePRo5bPIsL5nIUla3Dxt9SEReCQ0EQGrz19YL+2tme5i9J+jCOCylp8ZQ9LkDE+GB4goZpPzvHdCABzhsovYFPbU3ms6eibFItMv0PwUMwdIbO6lHVeVR3S0S/9omTMKzI6Ml4YoBIcK0o4WXkxxY2gW79DjQR/xFI6VKRqrz9zYQOGJgWcrG/e8GmW8envZnqGFACdM6ppEsJjah3Bl8nxknyxXYNHEzRI/rAwBEBHZVK8S8QgUxwOjICL3q7zVhQCpGAPvZ+IdTVFM86FvKytOVY4GZ5jQe5pweQoM7BkfcJEk0m152UfO4lEDsiCxRhqKzS8dNBdq9w6Za5hf
X-Exchange-RoutingPolicyChecked: SFUsOpahH0imHvweBAeq16davx6bd7+KYUxA5jd46YJfb6qUy3L8NSeQeZmlYk77se2HjerChZ+LSOkGLSiW7qHtOl/wdDYF0r2ZV/VD35CIJm7OwrlimSZWGQEaDod9MUVb6QmxAK9AumqmndAPYKx2EXOHe+fqvLi3mJA4tWFEBorqo0JHnCp+jSq0WQhc4j22dR4bKwMSGizSkYOH4IvCL0RET1UNldQeXLx/JohE2Ut0jD+wTV1hrheDU9o9gC1BqF5wRbjiEUfblvlGq4bIDbMHXwLjuBnKaRGsQcY9EGdOiL/fmKlf+fosjto3Iz4LCa7z1yPK7zT53G4RGQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 05:51:05.1014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a70969-6b46-44b2-7f02-08df43a59a97
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6060
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyMyBTYWx0ZWRfX/YOy4Y1q4Vw1
 BAJpnLESPutbUAQiFJERhkUhW1puU062oUNlBKpE6quVGrLHkkMW8x7veKFmfRKOR+PZKHW8JZb
 QTgSr9A1X+tMCtO98B6wJz4H/MsNxFU=
X-Proofpoint-ORIG-GUID: Qf9SLd4NsHNUat5qI66gQexY1mU9Y4a-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyMyBTYWx0ZWRfX2ENQOBBRBEc9
 h3pFlk+SfpafB/SwXskr0i0XVBQm1uoVVztCNdjnllceJJDXE2hs6JeLAxo9XkYJwZKn9RN0xS1
 uvm7uZAXhgmDlj6gmXtdpsE3n6FXQj4s+CuuGYPBpAwMdxlan6cgPmJLcec8BmWFBbqq6rq6D0u
 EaCD7ZJv0ydjbyi7/8Jhtk2RqeRSxX+opoPvn7EUAyXSL8mKF15mk3zXdaivGggBiwegyDB98RA
 GZgRQ3xyczJVKelNEA7otS5fKhvXhjaTSJK2zQAyzvvxiv+w6mtz888yQG01W3PTHpqlBazdzgd
 8obc2FYaCbE2fv3u9R/AuCWp1Tln+lRRhse1H38Soafy1RtwQBYH/39DcCY1/dV4s8GnAZdg5+X
 D5cNI13w/SSXl+9YcyXBTA/VO5xYNquoNkUr1L93cRrklRSaWu1C6+mIv21ra8K1I5HGNVw9/K7
 LEwm4V6hZU+aIhnSTgA==
X-Authority-Analysis: v=2.4 cv=TplzFzXh c=1 sm=1 tr=0 ts=6afa9a0a cx=c_pps
 a=RGFq7D/WLd/IouGP2/vkQQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=viOXP6cfK7h9U6r7EzwA:9
X-Proofpoint-GUID: Qf9SLd4NsHNUat5qI66gQexY1mU9Y4a-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160023
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PCI-USB2 daughtercard can be mounted on the AM654 Base-Board (EVM)
to enable PCI x2 Lane and USB2.0 functionality. Adding support for this
involves:
1. Detecting the daughtercard at A53 SPL stage
   => CONFIG_SPL_BOARD_INIT (to probe daughtercards)
2. Packaging the device-tree overlay for A53 SPL to modify U-Boot
   proper's device-tree at runtime
   => CONFIG_OF_OVERLAY_LIST (updated to include k3-am654-pcie-usb2")
3. GPIO support at A53 SPL stage for detecting the daughtercard using
   GPIO pin 38 on WKUP I2C0
   => CONFIG_SPL_GPIO
   => CONFIG_SPL_DM_GPIO
   => CONFIG_SPL_DM_PCA953X

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 configs/am65x_evm_a53_defconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index 5878816f63b..036efbb0e35 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -11,6 +11,8 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x680000
 CONFIG_DM_GPIO=y
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am654-base-board"
 CONFIG_DM_RESET=y
@@ -31,6 +33,7 @@ CONFIG_SPL_SPI=y
 CONFIG_PCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY=y
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTSTD_BOOTCOMMAND=y
 CONFIG_DISTRO_DEFAULTS=y
@@ -64,7 +67,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_OVERLAY_LIST="ti/k3-am654-icssg2"
+CONFIG_OF_OVERLAY_LIST="ti/k3-am654-icssg2 ti/k3-am654-pcie-usb2"
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
@@ -89,6 +92,7 @@ CONFIG_TI_K3_NAVSS_UDMA=y
 CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_DA8XX_GPIO=y
 CONFIG_DM_PCA953X=y
+CONFIG_SPL_DM_PCA953X=y
 CONFIG_DM_I2C=y
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_DM_I2C_GPIO=y
-- 
2.56.0


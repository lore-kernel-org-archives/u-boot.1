Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853C6C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 10:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D41340BA6;
	Wed, 29 Jul 2026 10:55:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6qDc4sGPVEcB; Wed, 29 Jul 2026 10:55:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24C3240BA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785322534;
	bh=BbturLjGCEP8l5lHMCYbwLqdA7/D0ke1uQokfOEvxrI=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WPxGc45ceQ5V0+TCyVTZ3ODAcNZhf286y50wcdVsd/j2v++vQEbqJrjsoiYRkTONo
	 S3aWZhpi/IpWMPeBJ1Ht1iKCveD/CTfsAmqxTfI8I0qHZFhP/0tGWUX9gBVEPQNzHb
	 da/jK7v6p36O9mpnIerJoU7wioIB4u4iFbXUrKPIHexv2mr/eMwlDgo4spt218rXZ6
	 nJ7ihZTahsVihpdpoWUiDM7j2kkHC7qd+A6Hc3XZONn9fYIrLdN0Akox6uwU2ZQOn1
	 lS4Raw3QyNOYW398nSulYxtdmy6TL1+kahCDWE6ua06iIA/Pa6ZVuYNc5qv4txKAcv
	 Z559OJy6S1qBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24C3240BA7;
	Wed, 29 Jul 2026 10:55:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 247B53B0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:55:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 00AE360712
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:55:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ujSznjCALCnR for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 10:55:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 783E660665
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 783E660665
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 783E660665
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:55:29 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66T7eCX73522228;
 Wed, 29 Jul 2026 05:55:20 -0500
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010014.outbound.protection.outlook.com
 [52.101.193.14])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fq41vuuuj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 05:55:20 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hu183z0WD1pcXw4ksQgm9XS+K7n/KjiDBDJ13GjsompVrezIutachJZoSHGol7t+xy0X+wRkmUFtiTK5qwdCVCkrs57ZbufJxecXShprJbTvtx7lA5zGCMJ3Z1Uk3uWf7AQwAMUmgIwuhjgTnwqSQOkymOM6FPNDA+huMANPTCOagH5fD0cn8jyTiAxJW7IqMXZGefLdbxzbCQW6quGn5HDR7s8tT4LKNyXNTZLgQv7TWdfQ/jM+sbvbRoBpSZ8e0hHSMiD2CQcco9Z90hX+Bz73qzzDMIi1+IjENb9kpWL5hUcAUZxCqnLR8k1UlOwtHml/mNfGcSkqzQvRTR5/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbturLjGCEP8l5lHMCYbwLqdA7/D0ke1uQokfOEvxrI=;
 b=weJ+rfSw6VrGgRJwKIeTiOtob3+FuNrP1+Zz+1eFN8PURgWuVpRp0BQDEkO5rnum75fHE43flUSD5W3Q2fjsi9MIYZASQIIws8akimUBWZTR0xeMi3HAKxFp4drgnSU74MrjDhD234TNEgbE/E5NYR+trdc3Fo63BF58tOROnQlaOBbH9/TihB0eeFXb9iORaH8aNbknNhAzSpubjEAsPAiiKV71iA2ccKrFrPA8/q0VIoLEb2nj22Fjgd+P9mE8wQBly7V0EQoduGW/5y/xbGq4JY7oNZ+W2Rr6gOSYmSrtLg3ariX138Yt8RMudaOYQmJTIqLuA9EZBX7GacYcjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from SA0PR11CA0051.namprd11.prod.outlook.com (2603:10b6:806:d0::26)
 by PH7PR10MB6967.namprd10.prod.outlook.com (2603:10b6:510:271::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 10:55:15 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:d0:cafe::5c) by SA0PR11CA0051.outlook.office365.com
 (2603:10b6:806:d0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 10:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 10:55:14 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 05:55:09 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 05:55:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 29 Jul 2026 05:55:09 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66TAt8j31144404;
 Wed, 29 Jul 2026 05:55:08 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Wed, 29 Jul 2026 16:25:00 +0530
Subject: [PATCH v2 2/2] arm: dts: k3-am625: add template for tispl.bin
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260729-k3_binman_refactor-v2-2-9a66fd170040@ti.com>
References: <20260729-k3_binman_refactor-v2-0-9a66fd170040@ti.com>
In-Reply-To: <20260729-k3_binman_refactor-v2-0-9a66fd170040@ti.com>
To: <upstream@lists.phytec.de>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>, "Francesco
 Dolcini" <francesco.dolcini@toradex.com>, Aristo Chen
 <aristo.chen@canonical.com>, Suhaas Joshi <s-joshi@ti.com>, Bryan Brattlof
 <bb@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, Sparsh Kumar <sparsh-kumar@ti.com>, "Anshul
 Dalal" <anshuld@ti.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785322504; l=29023;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=5p6guxIDBa1yqmPymbyjaBqFR63w/fRcudRwl1RLOx0=;
 b=9tLjrFzuAJYFAzj2G9s4lfXZs4XBhiS66vom6miOcpNQgv4WYga9aRXqeXtQOaRnEv6PF25Jb
 o+mrPnXmjPGCZyxekzWex+llG/6ZqHK6PfylUoWC/RnFvmFwx98vw2+
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|PH7PR10MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d31613-ef41-4679-752a-08deed5fdeda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|6133799003|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: NiyIpx5wnEPbgwCVCPAs0v1vOoRI+14r4JREMUQiITMk0l1nYzYveGm0HiMHKVNqOMNI39Z3tuRT9R0kmgnFDnRTzWD/2ZkTshurBGTknEPyI8+7OrjUOKg/c3CUA6+hxdVinNDCgs0oE33CGnqHtTqAmaMwwZtKFKDzxdEVkpObrxdZVamwnnZaMjJ7dCrfWYj2d/+Ng0stjZ99u5d3TgiDm8B1swiGJt6nPM9r4EhNyAt3SbNGtP6Ku8bR6Pk7MVYuMF3t6M1VVD0OKCRe7w8MpNjkjc3Jl+nECOOHPUIqZGINJYrFasOzacPenE/eZELD/dtBXOwjVAgw7srTm3l7uyDwIfaJ+vCT2+DOPHn0N9ymQeJ3z0btQT8RduA8nDcCQqJA6rxm+GeTp9YeJpPZqiX1ue8Hg2hJuOEepy+mx8mgFbELjyL4VJhq18B9AAqqVZCOEKgzGFMKTCrfyEWB/+LgGdSobZR3RgComNzrY92vDU/+XTtFNDnExss2MB9yCTxZJJRimA094ShgWHO6YO5hAQTrsniJfr9M/Ua5tOy2DIOSJ0pDiTU+Yd0enCMrukOCSRjNq1+eKcLk2IlnXDYkHynFyXuWiIh1UtbRJ/jC2aOx4yHBVoJic/eaUrw6hOlCf9xNJkZPdaVsaK/gNEsiv1LggWnrehbBH2pGk2MJW3/iKqeWADZ75tz1OcfcQhCPjlDEexYlGl10yA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(6133799003)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /FQ5I+TUFPLOATal4eSVi7ftWlsqFyWlRgVp9/fHREfontrJMB2t020ZANIb59JQ3RXGz0mScRiYRUp5+I59bq9Xmeu3wZ4IAz5+ph5PEjNEYx5WVyddw4Rfqmaz5JBf6O/5Lf7hmxEPdP7ZdL/0BgmRaAOyYgj2CDWRDqxWUtelFnAHoRSgm2Df/FJfeKb0R0Au2+eqqb3qrQ7lzplAOfwVR89wgQdtPT/9v8FoBADiZztDJI3QxyD3PehPzweWjcM3L0G54iBxXIrZ4rvJ1suySipo4hEKP9xtZq8N2dw2ulqjmNEnmltYt6Ol6eTiSNo8RkOS222SOJ/z30lIYLIE2EftNApFqEFnoIpRpBJwUomaXITTmwbnKeWLBTaochgAhE9JTXQqOoRRoHpuubchbKLXi7iW+e30ga09IF5+E4v4PCgahDXfSXXY2QKI
X-Exchange-RoutingPolicyChecked: d0DEh9TVrd+SDWKkLHiuSRr93Rp6cnX7S98ajkuTX4gM9PoaCzh4zsLHb78Vbr3RAn/05m/bqYSqrOftxL993+v6vsIAnfWhl+lf9aKKdU2NoL5DZXwPfBfqKMoY4GMkJJQMsUa3CrlsftmWBq59gXRBq3y4PfNVo1T6YCRNeec/86LoVEJAa/WRsZhNLeolLVzcPyTNwu74bJeboEWXIGYpN6q9jBw62AIfSnZLhsTiUTsI1+0LuJmQshg+q0BBw5nBOxyLwtYDpW4BOdLc0a3BrlDv7kVwGCJmKfoJDXMFCCuBK8k838lPSw0QuRRDqX5VDHQNXh9KHmcMY/eorQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 10:55:14.9061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d31613-ef41-4679-752a-08deed5fdeda
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6967
X-Authority-Analysis: v=2.4 cv=D/h37PRj c=1 sm=1 tr=0 ts=6a69dc18 cx=c_pps
 a=gJSDm7Sez3IyWyplfMHn2Q==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=lx77uqg2WqRXEC48TswA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1zWrrB5WIUh4sl1UfO5mY2s5b-oUKYax
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA5MCBTYWx0ZWRfXwaiZ03BvAu6C
 43i7FcKUDl2QJPK7I0ohQgSxRGnsnYLzlrQxiUvVCK7tktHfF8MJHfplG/jvfmokEX+oNiTC8Le
 P41BhL6iFNJkKbj1KrJ65KxMrBglMxo=
X-Proofpoint-ORIG-GUID: 1zWrrB5WIUh4sl1UfO5mY2s5b-oUKYax
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA5MCBTYWx0ZWRfX0OZEtsfNCXr/
 WT1fbXDINtINVfeSpnq8ZsxY76eKdLO7lWqWs2ezh9al2iMW/785yye16A0hppowNU7khtrArS7
 wAPEB65driga+wmh7tcMp2sXKz2jh2vcPHRZoQVc6TjOS5Wz8gytUeefBwJ3oRb+Bud2X6idE0j
 fg1zMbJZyla6WLLK8oBYZ4ie5INzacKvc2+1k1MriSjeQU9S9WE/M6+KjeHCxnLp9JPY758oqRX
 9ApZHNuemMTNjpihtabmpnSy3QGMnkrwWVm/uXWzW1kgPC5PW+oi0Iuvj7rfazwh/UdQhZX5/nq
 WWsFiAaN5SgDGh0MZvsSy3ggVtbjPphTCuGEqrr4hbEzb41OwgSNS7EsFtQbc8Y3NrWKxw+mKrO
 Vs7VX5shNqvAhReQnc3kOX6gGNMWct/aRODIeBTcVZsl9Diy3Bithh5qxf//Rwi1+gMIRvscTkm
 ki3t1JblRsKfZgPkXVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290090
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=BbturLjGCEP8l5lHMCYbwLqdA7/D0ke1uQokfOEvx
 rI=; b=oZrilKNJc6BOSpoo64QRsECN8UaGcY6AQ1g1Wb/d3+mIFHkc2loF9mWpz
 KrAxkq7IVUHjh6+QgN3V17GFSUKahYtdKRVLU3uCLdaNpT3AZ+e/rpvTBZ8UPqDm
 WfA1ao3yLhK2WYo4TWSqWNXZJWjWbFSQbQUp7TlnxP4Ev0MuQO7QhNOKRYJR6mvE
 oarzpZSozbZCHsXKp2wSq7btPloSkycgT3I1GT+diApeHA21KebGTRMxSi+HVBcT
 FsmpFV/qcTvmQLTmh4kOEyLDzXxCHjKHyNxysMa7GP287F9gtU9yQXb3W3MyVXav
 cU31PolEolwlI32dYVXPUAgKs5s7A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbturLjGCEP8l5lHMCYbwLqdA7/D0ke1uQokfOEvxrI=;
 b=RnYm4o3qjBvVQ7lELpF7GmqtYimmr1mHO+/G+W6R0QyT8meuNs0tAJPAIhR9pwLRKegzxM1CIa3kRZ1cGvBd3DyJJKnthaaVVyXlfeiX9m8XA0keBSJYKMQSltFrP8jpokgkXqhqHW/3uX6KGWgseR2RrC0b9j6BSh6HAG3JdOE=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=oZrilKNJ; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=RnYm4o3q
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

This patch addresses the duplication of the binman nodes responsible for
generating tispl.bin and tispl.bin_unsigned for TI's AM625 SoC based
boards.

The common nodes are factored out into a template in the SoC level
k3-am625-binman.dtsi that each board in-turn includes.

No functional change is intended from the patch asides from the addition
of tifsstub-hs and tifsstub-fs nodes in beagleplay's tispl.bin which
should have no consequence asides from growing the binary size by few
kilo bytes.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi      |  92 +------
 arch/arm/dts/k3-am625-binman.dtsi                 | 240 +++++++++++++++++
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi     | 241 +----------------
 arch/arm/dts/k3-am625-sk-binman.dtsi              | 313 +++-------------------
 arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi | 185 +------------
 5 files changed, 282 insertions(+), 789 deletions(-)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index 78d69499314e..d06cbd899c2a 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -63,99 +63,11 @@
 #define AM625_BEAGLEPLAY_DTB "dts/upstream/src/arm64/ti/k3-am625-beagleplay.dtb"
 
 &binman {
-	tifsstub-gp {
-		filename = "tifsstub.bin_gp";
-		ti-secure-rom {
-			content = <&tifsstub_gp>;
-			core = "secure";
-			load = <0x60000>;
-			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "ti-degenerate-key.pem";
-			tifsstub;
-		};
-		tifsstub_gp: tifsstub-gp.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-gp.bin";
-			type = "blob-ext";
-			optional;
-		};
-	};
-
 	ti-spl_unsigned {
-		filename = "tispl.bin_unsigned";
+		insert-template = <&ti_spl_unsigned_am625_template>;
 		symlink = "tispl.bin";
-		pad-byte = <0xff>;
-
 		fit {
-			description = "Configuration to load ATF and SPL";
-			#address-cells = <1>;
-
 			images {
-
-				atf {
-					description = "ARM Trusted Firmware";
-					type = "firmware";
-					arch = "arm64";
-					compression = "none";
-					os = "arm-trusted-firmware";
-					load = <CONFIG_K3_ATF_LOAD_ADDR>;
-					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
-					atf-bl31 {
-						filename = "bl31.bin";
-					};
-				};
-
-				tee {
-					description = "OP-TEE";
-					type = "tee";
-					arch = "arm64";
-					compression = "none";
-					os = "tee";
-					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
-					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
-					tee-os {
-						filename = "tee-raw.bin";
-					};
-				};
-
-				tifsstub-gp {
-					description = "tifsstub";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_gp";
-					};
-				};
-
-				dm {
-					description = "DM binary";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "DM";
-					load = <0x89000000>;
-					entry = <0x89000000>;
-					ti-dm {
-						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-					};
-				};
-
-				spl {
-					description = "SPL (64-bit)";
-					type = "standalone";
-					os = "U-Boot";
-					arch = "arm64";
-					compression = "none";
-					load = <CONFIG_SPL_TEXT_BASE>;
-					entry = <CONFIG_SPL_TEXT_BASE>;
-					blob {
-						filename = "spl/u-boot-spl-nodtb.bin";
-					};
-				};
-
 				fdt-0 {
 					description = "k3-am625-beagleplay";
 					type = "flat_dt";
@@ -166,10 +78,8 @@
 					};
 				};
 			};
-
 			configurations {
 				default = "conf-0";
-
 				conf-0 {
 					description = "k3-am625-beagleplay";
 					firmware = "atf";
diff --git a/arch/arm/dts/k3-am625-binman.dtsi b/arch/arm/dts/k3-am625-binman.dtsi
index a96a2006a087..78ea422b85d9 100644
--- a/arch/arm/dts/k3-am625-binman.dtsi
+++ b/arch/arm/dts/k3-am625-binman.dtsi
@@ -120,3 +120,243 @@
 		};
 	};
 };
+
+#ifdef CONFIG_ARM64
+
+&binman {
+	tifsstub-hs {
+		filename = "tifsstub.bin_hs";
+		ti-secure-rom {
+			content = <&tifsstub_hs_cert>;
+			core = "secure";
+			load = <0x40000>;
+			sw-rev = <CONFIG_K3_X509_SWRV>;
+			keyfile = "custMpk.pem";
+			countersign;
+			tifsstub;
+		};
+		tifsstub_hs_cert: tifsstub-hs-cert.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		tifsstub_hs_enc: tifsstub-hs-enc.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+	};
+
+	tifsstub-fs {
+		filename = "tifsstub.bin_fs";
+		tifsstub_fs_cert: tifsstub-fs-cert.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		tifsstub_fs_enc: tifsstub-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+	};
+
+	tifsstub-gp {
+		filename = "tifsstub.bin_gp";
+		ti-secure-rom {
+			content = <&tifsstub_gp>;
+			core = "secure";
+			load = <0x60000>;
+			sw-rev = <CONFIG_K3_X509_SWRV>;
+			keyfile = "ti-degenerate-key.pem";
+			tifsstub;
+		};
+		tifsstub_gp: tifsstub-gp.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-gp.bin";
+			type = "blob-ext";
+			optional;
+		};
+	};
+
+	ti_falcon_am625_template: template-ti-falcon {
+		insert-template = <&ti_falcon_template>;
+		fit {
+			images {
+				tifsstub-hs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-hs";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_hs";
+					};
+				};
+				tifsstub-fs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-fs";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_fs";
+					};
+				};
+				tifsstub-gp {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-gp";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_gp";
+					};
+				};
+				dm {
+					ti-secure {
+						content = <&dm_falcon>;
+						keyfile = "custMpk.pem";
+					};
+					dm_falcon: ti-dm {
+						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+		};
+	};
+
+	ti_spl_am625_template: template-ti-spl {
+		insert-template = <&ti_spl_template>;
+		fit {
+			images {
+				atf {
+					ti-secure {
+						auth-in-place = <0xa02>;
+						firewall-1-0 {
+							insert-template = <&firewall_bg_3>;
+							id = <1>;
+							region = <0>;
+						};
+						firewall-1-1 {
+							insert-template = <&firewall_armv8_atf_fg>;
+							id = <1>;
+							region = <1>;
+						};
+					};
+				};
+				tee {
+					ti-secure {
+						auth-in-place = <0xa02>;
+						firewall-1-2 {
+							insert-template = <&firewall_armv8_optee_fg>;
+							id = <1>;
+							region = <2>;
+						};
+					};
+				};
+				tifsstub-hs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-hs";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_hs";
+					};
+				};
+				tifsstub-fs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-fs";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_fs";
+					};
+				};
+				tifsstub-gp {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-gp";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_gp";
+					};
+				};
+				dm {
+					ti-secure {
+						content = <&dm>;
+						keyfile = "custMpk.pem";
+					};
+					dm: ti-dm {
+						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+		};
+	};
+
+	ti_spl_unsigned_am625_template: template-ti-spl_unsigned {
+		insert-template = <&ti_spl_unsigned_template>;
+		fit {
+			images {
+				tifsstub-hs {
+					description = "tifsstub";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-hs";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_hs";
+					};
+				};
+				tifsstub-fs {
+					description = "tifsstub";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-fs";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_fs";
+					};
+				};
+				tifsstub-gp {
+					description = "tifsstub";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-gp";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_gp";
+					};
+				};
+				dm {
+					ti-dm {
+						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+		};
+	};
+};
+
+#endif
diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index d09bdf29a95d..12f8acffc4a4 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -50,146 +50,10 @@
 #define AM625_PHYBOARD_LYRA_DTB "u-boot.dtb"
 
 &binman {
-	tifsstub-hs {
-		filename = "tifsstub.bin_hs";
-		ti-secure-rom {
-			content = <&tifsstub_hs_cert>;
-			core = "secure";
-			load = <0x40000>;
-			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "custMpk.pem";
-			countersign;
-			tifsstub;
-		};
-		tifsstub_hs_cert: tifsstub-hs-cert.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-			optional;
-		};
-		tifsstub_hs_enc: tifsstub-hs-enc.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-			optional;
-		};
-	};
-
-	tifsstub-fs {
-		filename = "tifsstub.bin_fs";
-		tifsstub_fs_cert: tifsstub-fs-cert.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-			optional;
-		};
-		tifsstub_fs_enc: tifsstub-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-			optional;
-		};
-
-	};
-
-	tifsstub-gp {
-		filename = "tifsstub.bin_gp";
-		ti-secure-rom {
-			content = <&tifsstub_gp>;
-			core = "secure";
-			load = <0x60000>;
-			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "ti-degenerate-key.pem";
-			tifsstub;
-		};
-		tifsstub_gp: tifsstub-gp.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-gp.bin";
-			type = "blob-ext";
-			optional;
-		};
-	};
-
-
 	ti-spl {
-		insert-template = <&ti_spl_template>;
-
+		insert-template = <&ti_spl_am625_template>;
 		fit {
-
 			images {
-				atf {
-					ti-secure {
-						auth-in-place = <0xa02>;
-
-						firewall-1-0 {
-							insert-template = <&firewall_bg_3>;
-							id = <1>;
-							region = <0>;
-						};
-
-						firewall-1-1 {
-							insert-template = <&firewall_armv8_atf_fg>;
-							id = <1>;
-							region = <1>;
-						};
-					};
-				};
-
-				tee {
-					ti-secure {
-						auth-in-place = <0xa02>;
-
-						firewall-1-2 {
-							insert-template = <&firewall_armv8_optee_fg>;
-							id = <1>;
-							region = <2>;
-						};
-					};
-				};
-
-				tifsstub-hs {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-hs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_hs";
-					};
-				};
-
-				tifsstub-fs {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-fs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_fs";
-					};
-				};
-
-				tifsstub-gp {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_gp";
-					};
-				};
-				dm {
-					ti-secure {
-						content = <&dm>;
-						keyfile = "custMpk.pem";
-					};
-					dm: ti-dm {
-						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-					};
-				};
-
 				fdt-0 {
 					description = "k3-am625-phyboard-lyra-rdk";
 					type = "flat_dt";
@@ -338,111 +202,10 @@
 };
 
 &binman {
-	tifsstub-hs {
-		filename = "tifsstub.bin_hs";
-		ti-secure-rom {
-			content = <&tifsstub_hs_cert>;
-			core = "secure";
-			load = <0x40000>;
-			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "custMpk.pem";
-			countersign;
-			tifsstub;
-		};
-		tifsstub_hs_cert: tifsstub-hs-cert.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-			optional;
-		};
-		tifsstub_hs_enc: tifsstub-hs-enc.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-			optional;
-		};
-	};
-
-	tifsstub-fs {
-		filename = "tifsstub.bin_fs";
-		tifsstub_fs_cert: tifsstub-fs-cert.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-			optional;
-		};
-		tifsstub_fs_enc: tifsstub-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-			optional;
-		};
-
-	};
-
-	tifsstub-gp {
-		filename = "tifsstub.bin_gp";
-		ti-secure-rom {
-			content = <&tifsstub_gp>;
-			core = "secure";
-			load = <0x60000>;
-			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "ti-degenerate-key.pem";
-			tifsstub;
-		};
-		tifsstub_gp: tifsstub-gp.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-gp.bin";
-			type = "blob-ext";
-			optional;
-		};
-	};
-
 	ti-spl_unsigned {
-		insert-template = <&ti_spl_unsigned_template>;
-
+		insert-template = <&ti_spl_unsigned_am625_template>;
 		fit {
 			images {
-				tifsstub-hs {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-hs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_hs";
-					};
-				};
-
-				tifsstub-fs {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-fs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_fs";
-					};
-				};
-
-				tifsstub-gp {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_gp";
-					};
-				};
-
-				dm {
-					ti-dm {
-						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-					};
-				};
-
 				fdt-0 {
 					description = "k3-am625-phyboard-lyra-rdk";
 					type = "flat_dt";
diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index 9ac0c36f8645..08edf7f32519 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -46,113 +46,9 @@
 #define AM625_SK_DTB "u-boot.dtb"
 
 &binman {
-	tifsstub-hs {
-		filename = "tifsstub.bin_hs";
-		ti-secure-rom {
-			content = <&tifsstub_hs_cert>;
-			core = "secure";
-			load = <0x40000>;
-			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "custMpk.pem";
-			countersign;
-			tifsstub;
-		};
-		tifsstub_hs_cert: tifsstub-hs-cert.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-			optional;
-		};
-		tifsstub_hs_enc: tifsstub-hs-enc.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-			optional;
-		};
-	};
-
-	tifsstub-fs {
-		filename = "tifsstub.bin_fs";
-		tifsstub_fs_cert: tifsstub-fs-cert.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-			optional;
-		};
-		tifsstub_fs_enc: tifsstub-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-			optional;
-		};
-
-	};
-
-	tifsstub-gp {
-		filename = "tifsstub.bin_gp";
-		ti-secure-rom {
-			content = <&tifsstub_gp>;
-			core = "secure";
-			load = <0x60000>;
-			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "ti-degenerate-key.pem";
-			tifsstub;
-		};
-		tifsstub_gp: tifsstub-gp.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-gp.bin";
-			type = "blob-ext";
-			optional;
-		};
-	};
-
 	ti-falcon {
-		insert-template = <&ti_falcon_template>;
-
+		insert-template = <&ti_falcon_am625_template>;
 		fit {
-			images {
-				tifsstub-hs {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-hs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_hs";
-					};
-				};
-				tifsstub-fs {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-fs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_fs";
-					};
-				};
-				tifsstub-gp {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_gp";
-					};
-				};
-				dm {
-					ti-secure {
-						content = <&dm_falcon>;
-						keyfile = "custMpk.pem";
-					};
-					dm_falcon: ti-dm {
-						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-					};
-				};
-			};
-
 			configurations {
 				default = "conf-hs-fs";
 				conf-hs-fs {
@@ -175,109 +71,63 @@
 	};
 
 	ti-spl {
-		insert-template = <&ti_spl_template>;
-
+		insert-template = <&ti_spl_am625_template>;
 		fit {
 			images {
-				atf {
-					ti-secure {
-						auth-in-place = <0xa02>;
-
-						firewall-1-0 {
-							insert-template = <&firewall_bg_3>;
-							id = <1>;
-							region = <0>;
-						};
-
-						firewall-1-1 {
-							insert-template = <&firewall_armv8_atf_fg>;
-							id = <1>;
-							region = <1>;
-						};
-					};
-				};
-
-				tee {
+				fdt-0 {
+					description = "k3-am625-sk";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
 					ti-secure {
-						auth-in-place = <0xa02>;
-
-						firewall-1-2 {
-							insert-template = <&firewall_armv8_optee_fg>;
-							id = <1>;
-							region = <2>;
-						};
+						content = <&spl_am625_sk_dtb>;
+						keyfile = "custMpk.pem";
 					};
-				};
-
-				tifsstub-hs {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-hs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_hs";
+					spl_am625_sk_dtb: blob-ext {
+						filename = SPL_AM625_SK_DTB;
 					};
 				};
-
-				tifsstub-fs {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-fs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_fs";
-					};
+			};
+			configurations {
+				default = "conf-hs-fs";
+				conf-hs-fs {
+					description = "k3-am625-sk-hs-fs";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-fs", "dm", "spl";
+					fdt = "fdt-0";
 				};
-
-				tifsstub-gp {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_gp";
-					};
+				conf-hs-se {
+					description = "k3-am625-sk-hs-se";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-hs", "dm", "spl";
+					fdt = "fdt-0";
 				};
-
-				dm {
-					ti-secure {
-						content = <&dm>;
-						keyfile = "custMpk.pem";
-					};
-					dm: ti-dm {
-						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-					};
+				conf-gp {
+					description = "k3-am625-sk-gp";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-gp", "dm", "spl";
+					fdt = "fdt-0";
 				};
+			};
+		};
+	};
 
+	ti-spl_unsigned {
+		insert-template = <&ti_spl_unsigned_am625_template>;
+		fit {
+			images {
 				fdt-0 {
 					description = "k3-am625-sk";
 					type = "flat_dt";
 					arch = "arm";
 					compression = "none";
-					ti-secure {
-						content = <&spl_am625_sk_dtb>;
-						keyfile = "custMpk.pem";
-					};
-					spl_am625_sk_dtb: blob-ext {
+					spl_am625_sk_dtb_unsigned: blob {
 						filename = SPL_AM625_SK_DTB;
 					};
-
 				};
-
 			};
-
 			configurations {
 				default = "conf-hs-fs";
-
 				conf-hs-fs {
 					description = "k3-am625-sk-hs-fs";
 					firmware = "atf";
@@ -344,95 +194,6 @@
 	};
 };
 
-&binman {
-	ti-spl_unsigned {
-		insert-template = <&ti_spl_unsigned_template>;
-
-		fit {
-			images {
-
-				tifsstub-hs {
-					description = "tifsstub";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-hs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_hs";
-					};
-				};
-
-				tifsstub-fs {
-					description = "tifsstub";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-fs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_fs";
-					};
-				};
-
-				tifsstub-gp {
-					description = "tifsstub";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_gp";
-					};
-				};
-
-				dm {
-					ti-dm {
-						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-					};
-				};
-
-				fdt-0 {
-					description = "k3-am625-sk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					spl_am625_sk_dtb_unsigned: blob {
-						filename = SPL_AM625_SK_DTB;
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-hs-fs";
-
-				conf-hs-fs {
-					description = "k3-am625-sk-hs-fs";
-					firmware = "atf";
-					loadables = "tee", "tifsstub-fs", "dm", "spl";
-					fdt = "fdt-0";
-				};
-				conf-hs-se {
-					description = "k3-am625-sk-hs-se";
-					firmware = "atf";
-					loadables = "tee", "tifsstub-hs", "dm", "spl";
-					fdt = "fdt-0";
-				};
-				conf-gp {
-					description = "k3-am625-sk-gp";
-					firmware = "atf";
-					loadables = "tee", "tifsstub-gp", "dm", "spl";
-					fdt = "fdt-0";
-				};
-			};
-		};
-	};
-};
-
 &binman {
 	u-boot_unsigned {
 		insert-template = <&u_boot_unsigned_template>;
diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
index c57780d876d6..527b04936fcb 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
@@ -35,146 +35,10 @@
 #define VERDIN_AM62_DTB "u-boot.dtb"
 
 &binman {
-	tifsstub-hs {
-		filename = "tifsstub.bin_hs";
-		ti-secure-rom {
-			content = <&tifsstub_hs_cert>;
-			core = "secure";
-			load = <0x40000>;
-			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "custMpk.pem";
-			countersign;
-			tifsstub;
-		};
-		tifsstub_hs_cert: tifsstub-hs-cert.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-			optional;
-		};
-		tifsstub_hs_enc: tifsstub-hs-enc.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-			optional;
-		};
-	};
-
-	tifsstub-fs {
-		filename = "tifsstub.bin_fs";
-		tifsstub_fs_cert: tifsstub-fs-cert.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-			optional;
-		};
-		tifsstub_fs_enc: tifsstub-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-			optional;
-		};
-
-	};
-
-	tifsstub-gp {
-		filename = "tifsstub.bin_gp";
-		ti-secure-rom {
-			content = <&tifsstub_gp>;
-			core = "secure";
-			load = <0x60000>;
-			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "ti-degenerate-key.pem";
-			tifsstub;
-		};
-		tifsstub_gp: tifsstub-gp.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-gp.bin";
-			type = "blob-ext";
-			optional;
-		};
-	};
-
 	ti-spl {
-		insert-template = <&ti_spl_template>;
-
+		insert-template = <&ti_spl_am625_template>;
 		fit {
-
 			images {
-				atf {
-					ti-secure {
-						auth-in-place = <0xa02>;
-
-						firewall-1-0 {
-							insert-template = <&firewall_bg_3>;
-							id = <1>;
-							region = <0>;
-						};
-
-						firewall-1-1 {
-							insert-template = <&firewall_armv8_atf_fg>;
-							id = <1>;
-							region = <1>;
-						};
-					};
-				};
-
-				tee {
-					ti-secure {
-						auth-in-place = <0xa02>;
-
-						firewall-1-2 {
-							insert-template = <&firewall_armv8_optee_fg>;
-							id = <1>;
-							region = <2>;
-						};
-					};
-				};
-
-				tifsstub-hs {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-hs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_hs";
-					};
-				};
-
-				tifsstub-fs {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-fs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_fs";
-					};
-				};
-
-				tifsstub-gp {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_gp";
-					};
-				};
-
-				dm {
-					ti-secure {
-						content = <&dm>;
-						keyfile = "custMpk.pem";
-					};
-					dm: ti-dm {
-						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-					};
-				};
-
 				fdt-0 {
 					description = "k3-am625-verdin-wifi-dev";
 					type = "flat_dt";
@@ -260,55 +124,10 @@
 
 &binman {
 	ti-spl_unsigned {
-		insert-template = <&ti_spl_unsigned_template>;
+		insert-template = <&ti_spl_unsigned_am625_template>;
 
 		fit {
 			images {
-				tifsstub-hs {
-					description = "tifsstub";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-hs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_hs";
-					};
-				};
-
-				tifsstub-fs {
-					description = "tifsstub";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-fs";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_fs";
-					};
-				};
-
-				tifsstub-gp {
-					description = "tifsstub";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-gp";
-					load = <0x9dc00000>;
-					entry = <0x9dc00000>;
-					blob-ext {
-						filename = "tifsstub.bin_gp";
-					};
-				};
-
-				dm {
-					ti-dm {
-						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-					};
-				};
-
 				fdt-0 {
 					description = "k3-am625-verdin-wifi-dev";
 					type = "flat_dt";

-- 
2.55.0


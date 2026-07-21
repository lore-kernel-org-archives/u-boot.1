Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399FAC4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 18:09:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2525608EA;
	Tue, 21 Jul 2026 18:09:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q6orLNqUXANh; Tue, 21 Jul 2026 18:09:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF30560907
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784657372;
	bh=4f3AnSj/EojCMWQemgJtSIa4zFBilAC9Xp3Pr9gDVs8=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=jDd9LaepgvZQ53+ksVVNCRF4D05WighLGfiTRXMf+SJmYrnq4MLopnsgBbL3Kt8yR
	 fAlYrvDeHNIpgZIUsk39tLSaeIpv/vV17ztVvseYalvziSSdvusrO3INSNHAJoS6rQ
	 HDlI92YjTquxBm1fF4dEXk1JP8stFgkz0YaoE9bKq5mY8OgjL8BecMQGlee2d3iVxA
	 RhIk5ajB/nEOoJbRro+7ESVriK7NxuNPFg0s84ywBRj5mPSEsOGKzjNlA3DcWGrZFy
	 dlwzAU+AhUjGs4VIYw9zEu0J7+XBci+tup4aE1qIUzpHaLgaDuQso2BaFXgSRTpSEc
	 Br76AWI4RKwnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF30560907;
	Tue, 21 Jul 2026 18:09:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 392E9EB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:32:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3686380DF4
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:32:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nOWUYsLNjB9j for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 16:31:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4D1DE80DDD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D1DE80DDD
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4D1DE80DDD
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:31:59 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66LDjP4s3231848;
 Tue, 21 Jul 2026 10:30:53 -0500
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011031.outbound.protection.outlook.com [52.101.57.31])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fj869hch2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 10:30:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAXgV8hHM0GO4It2lKJb6zQPD8LyosYPG+dyJ9J108zvkiN9Qo6+LoZdhP97J5gfbSY/lHl9QvI3q4dQCXZJ7vcEKt3XHBVoWIZafvkEfKLNULItub8em9HfeXWH6U6bdol7VKSdh4eYDzxwkuBfgK9HIhAexrnjkTP77Ox1om02CDSNO63hbOmqdEYiom5Vk8Ehrkhg9RsFp03ftjd6wLMCjmck7jN+pBR31XJ4FpmiWn+zf5lpE4Ldc5FdRPkjG0ipe0xKrpxEh7XghXfI23oXJ4ln+588g+7FwdEQ1GyT6U3Ywsq1UdmYGK9U1Ojcs/s4CEBZcSL+Sg3iHDet0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4f3AnSj/EojCMWQemgJtSIa4zFBilAC9Xp3Pr9gDVs8=;
 b=SNQKc0XDRyEhIORgYMOVJaD+KGdWC/NGJT22SDtSBvLKDqGo3cQodJXYLqllNo4O+HxiiKdLv7W0gcK0KO24S3SUPb7i5YHN2vL6Ls7XluwnrIuTnY1sIl3i5SZYm5KVQodHywkiPHvcxkc1NZXP8Bv069msRZvERTCUf4MT4P20fmpNfy5sWSPdySQ8p3jJxQc5JirtpYHNR+cRw6FIBGUAXq/bUPdkqKdXipY0WignAk0MT2Z8nC7tW3vqs0JW9wtUEgVvbD/QERNnziPzlqhUq+JNEJkP6tjQNlDUg5kQcEcGWnFRuSBmKYpgGfhj1+6QzUlcpzMs7rp8gn6ecQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from MW4PR03CA0196.namprd03.prod.outlook.com (2603:10b6:303:b8::21)
 by PH3PPFAE1A1621A.namprd10.prod.outlook.com (2603:10b6:518:1::7bd)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 15:30:48 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:303:b8:cafe::1e) by MW4PR03CA0196.outlook.office365.com
 (2603:10b6:303:b8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.18 via Frontend Transport; Tue,
 21 Jul 2026 15:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 15:30:47 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:22 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 10:30:22 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66LFUMaW1031815;
 Tue, 21 Jul 2026 10:30:22 -0500
Date: Tue, 21 Jul 2026 10:30:17 -0500
Subject: [PATCH v2 02/11] tools: binman: extend ti_secure_rom to handle op-tee
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-am62lx-v2-2-33ff580c267d@ti.com>
References: <20260721-am62lx-v2-0-33ff580c267d@ti.com>
In-Reply-To: <20260721-am62lx-v2-0-33ff580c267d@ti.com>
To: <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Alice Guo
 <alice.guo@nxp.com>, Anshul Dalal <anshuld@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrew Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, "Kory Maincent
 (TI.com)" <kory.maincent@bootlin.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Daniel Golle <daniel@makrotopia.org>, "Rasmus
 Villemoes" <rv@rasmusvillemoes.dk>, Vignesh Raghavendra <vigneshr@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Dhruva Gole <d-gole@ti.com>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 George McCollister <george.mccollister@konsulko.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 "Swamil Jain" <s-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Shiva Tripathi <s-tripathi1@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "Aristo Chen" <aristo.chen@canonical.com>,
 Johan Jonker <jbx6244@gmail.com>, "Apurva Nandan" <a-nandan@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Hrushikesh Salunke
 <h-salunke@ti.com>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|PH3PPFAE1A1621A:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e04d6dd-1fcc-4727-2adc-08dee73d09fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|7416014|82310400026|376014|56012099006|3023799007|10067099003|6133799003|17002099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8eUyelpqZxlnLu10Eh2Ispa8uABP4AUHzXAYQp4PzJ/7UYbcotQAxA1ch/T2b6+HbMlskBDwIGPYlNDubfjpuNcT+nbr4fSzoARLQAForv2SwFHO2KkPyEvF1xv8u31asg/SuDBGNjkaUkfJYkDH9QMy6ixFCgp7ijXSM0SzsLQXUVuADkO4Qk0W5GXcdtd5xB5GTqeCx179Ti2D3BrDhJB9uSG4mqLAR8RMi3Ko3IffUMsjshtqjNDl3pHZpsf/9NhbM4s/dszn62f+johTq8KlmmfUsrRqtOul3QPod5WVRWqV+vMwZ8vT48vuMgmD2EElUsKZGaNgoyiDMAQkAf3qHT2zl3gPP854eNRjS8xGABEDY9DdVhf0tBaRyBpKJUocQT7qAq6hB8HkQojpYmU73x2xS1ENPo3oUru6UG59n53EGYffTq9HpK3fFXfMIyJhZ5XBbh05MWSfA+6ng2M808bFi/nESlqvRqDKmfnQq5SPi4tM0ucowSpufdPZKJXjOKRiNps4VNsGjzq8VwnqWDBFHm09MiU5jM4w4IaqE7degMLvB3pf2+9OdiD4EWW1HpdBorv94JmPdkrBMi8MFS+mRy4gyYzkVlOOB4wyHpZo2UyxX/dCXSoEZr/+etDIrA+PjUpXVgTUGcWk5MKC0A2chPAjX/4yjVEwr1YQMhpFl0I/hkdjoph/9qD8N/eZ1eyC5kZQLFpfd1Sfrw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(7416014)(82310400026)(376014)(56012099006)(3023799007)(10067099003)(6133799003)(17002099007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TubnfbjXC00xse2RQIYv/76Aw510orhUUmliK4tpkzGG4fOyGDvw+F7u6cIfJhpasTJEaF2ddobEwozxnfUXSxExKTpcegbGYHfOckggqcSWGSnbL737LiwqIPzHni8COXv3MJh30eyVXOINN1kdLKL09aNbIaWiZh0tks7YheE9K41bY/DtVb8UxaDsqjFeCGeVcFI1rko7lQZ2Gbih362rE5tY4/EDD4HkORa0DIWa1M8JuG/Y6AqdCiHPucoH4YB0wbxhakHWw8DtW8R1FGCTeuEjSJdCC6f0nqolvGmQWUUs0TiWZQcdi4ubAz+HGNqpsu3Mm4K1SSaYi3cLQ3h/9r+ALQb5ScZcBuCnE1EVmqsg1HB8Qv6nuhbjGWqeKHb1ZX/D8kqz1Dylj6ggNexmgR/0YpQlL188yS8OWbHXShQTRs2H5SYxPgUSMjxW
X-Exchange-RoutingPolicyChecked: Apj6cbUpKfRE1QtHUX5EYnxMkTirekGYJapEVN4p2eNp5OA/EXjBYVDx7IBfF+aBvWD3xfQ6RUEAq2Q9fdtOj2O0M4tvTZ/FuQygCrc+UhX2SkBpfrbBllto09LJjXeEwHPMx+YhBtaasEo8Is3brwuhBxz5cawu5S38Kq4T5N82ddRkHYM57qBeg/r2+s2VmJYB8+mo3QGVkseqdwP+BH6XaLptRZ9UlXqZ/u6yok1MOSC5agNQnd27MGRSdg5jdgebAdB+LMdB1aRU4PTEREyMIrsRwL5Pe8+2h6E2J2wf0drYa+TLqebAEcWFVpMcpjG9krokewYgyqENIyRYvA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:30:47.8328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e04d6dd-1fcc-4727-2adc-08dee73d09fc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFAE1A1621A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfX/42uIXmSijBi
 3lKs5hFIvqMJnauX5ZtoLyqD2g0GpXCrqmvsrGZrBeMxyP7lbvHIXPsYkpFNx03ktU8qAlbNO0B
 yCoo+K/of0Z7lKnDZb4hWCoQxu0ipxFMdZBGD38YJuk4ipuElI1dFgtIWCcHL0wTr1HysNdG9XB
 xBqtF5JVnqIJeTTFWCRTCeB7e4XJNHO+1zICPJL37z9Z4GSDPJY99FMK20kAQ2r744ox8ODDWlf
 n4p+ZeDBNgAcf2kE9cnvodq5UkyxOtcLNvBcnean3NYukYEAtBPpFdyUCCSoNJSfissHtDc6O/O
 5krQW73rSAJm0YHNNKN0+uTQNVP2wqY43bDyrJWT5GpQs5csCsF+2KCNh+lqUQQzNjgX1BdyASv
 m3ycPknGGSaQriKqdzClWTrn0RS1wQSlLhKtRcy12uhi+44RYbuspWuXGX/XOx+OA5CxtJDcl2r
 k3RnMiTC5mgTM786jpA==
X-Authority-Analysis: v=2.4 cv=WbI8rUhX c=1 sm=1 tr=0 ts=6a5f90ad cx=c_pps
 a=r1suf/lb2duQPz5POPReZg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=9IcOKVw8tvNm7E74pWIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: E35Q0X21qT1KBcM5kW00nKh09viEmka8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfXwZ2BZ3v9QcSE
 Y8ciK3SyMvSV61CViz3FKEEmhbgTw3LO7PPbsgk6pVM4laKIY5za3zM83Qmb4UBX6RVgqU0kScn
 3q7rMNw2/3gxLp8djyDV/QJi5V+2J6w=
X-Proofpoint-GUID: E35Q0X21qT1KBcM5kW00nKh09viEmka8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210164
X-Mailman-Approved-At: Tue, 21 Jul 2026 18:09:10 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=4f3AnSj/EojCMWQemgJtSIa4zFBilAC9Xp3Pr9gDV
 s8=; b=MSJUKGGdS9LHESSg0sLuiIK+qearWyKPZriXXx1B2ODrVoHA+XrVgtLpO
 idvvX9W2iNiURNzuYHpVUQ2unkwjH//X+du1Lz5Rgu2rH7KI21bUwAgDQNwigSIi
 TTn2jjYLKswcPoH46xSmipVtR/NITLhaAiJKWwZt/WI0RtCUwi2duPbmug8Z1yXw
 jwZoycvqJhbhSYXLboumWVmQobdQONU2ndKOS51Y1EngxZta0NaDFetdRrCrm8Yt
 impj8raphVYuk88e/pm41YKacTu0VhPfnUmFMApKgx8l5YJDOAXP4Cw12HmrByAi
 9V/0omunCBVkn2od09MKZfOBTzHsQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4f3AnSj/EojCMWQemgJtSIa4zFBilAC9Xp3Pr9gDVs8=;
 b=GZbuqBSosM4OmdyWcqAu0izwXCzkfbTHwCpK/LAh8G8qtNBmEhKuLPgiqUwa0I7FH/Vcg1+kiVw+vJbO5iV+jLuv6zdWfgaVI6UEp1aiBykzaBfHFAoZbszOtnvg4zPR9oyOGmHkma7vxBqJNDa3WAPLpjK/dowU4xh0MQ07bBc=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=MSJUKGGd; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=GZbuqBSo
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
From: Bryan Brattlof via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Bryan Brattlof <bb@ti.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add an optional 'tee' entry to the x509 certificate template to include
optee during the second (tispl) boot phase for the AM62L.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 tools/binman/btool/openssl.py       | 11 +++++++----
 tools/binman/etype/ti_secure_rom.py | 32 +++++++++++++++++++++++++++++++-
 tools/binman/etype/x509_cert.py     |  4 ++++
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
index b26f087c4470..c4762f6ccee6 100644
--- a/tools/binman/btool/openssl.py
+++ b/tools/binman/btool/openssl.py
@@ -239,10 +239,10 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
     def x509_cert_rom_combined(self, cert_fname, input_fname, key_fname, sw_rev,
                   config_fname, req_dist_name_dict, load_addr, sha, total_size, num_comps,
                   sysfw_inner_cert_ext_boot_sequence_string, dm_data_ext_boot_sequence_string,
-                  imagesize_sbl, hashval_sbl, load_addr_sysfw, imagesize_sysfw,
-                  hashval_sysfw, load_addr_sysfw_data, imagesize_sysfw_data,
-                  hashval_sysfw_data, sysfw_inner_cert_ext_boot_block,
-                  dm_data_ext_boot_block, bootcore_opts, debug):
+                  tee_ext_boot_sequence_string, imagesize_sbl, hashval_sbl, load_addr_sysfw,
+                  imagesize_sysfw, hashval_sysfw, load_addr_sysfw_data, imagesize_sysfw_data,
+                  hashval_sysfw_data, sysfw_inner_cert_ext_boot_block, dm_data_ext_boot_block,
+                  tee_ext_boot_block, bootcore_opts, debug):
         """Create a certificate
 
         Args:
@@ -299,6 +299,7 @@ sbl=SEQUENCE:sbl
 sysfw=SEQUENCE:sysfw
 sysfw_data=SEQUENCE:sysfw_data
 {sysfw_inner_cert_ext_boot_sequence_string}
+{tee_ext_boot_sequence_string}
 {dm_data_ext_boot_sequence_string}
 
 [sbl]
@@ -340,6 +341,8 @@ coreDbgSecEn = INTEGER:0
 
 {sysfw_inner_cert_ext_boot_block}
 
+{tee_ext_boot_block}
+
 {dm_data_ext_boot_block}
         ''', file=outf)
         args = ['req', '-new', '-x509', '-key', key_fname, '-nodes',
diff --git a/tools/binman/etype/ti_secure_rom.py b/tools/binman/etype/ti_secure_rom.py
index 7e90c6559409..4e0c9d54bbc4 100644
--- a/tools/binman/etype/ti_secure_rom.py
+++ b/tools/binman/etype/ti_secure_rom.py
@@ -80,6 +80,11 @@ class Entry_ti_secure_rom(Entry_x509_cert):
             self.dm_data = fdt_util.GetBool(self._node, 'dm-data', False)
             if self.dm_data:
                 self.load_addr_dm_data = fdt_util.GetInt(self._node, 'load-dm-data', 0x00000000)
+
+        self.tee = fdt_util.GetBool(self._node, 'content-tee', False)
+        if self.tee:
+            self.load_addr_tee = fdt_util.GetInt(self._node, 'load-tee', 0x00000000)
+
         self.req_dist_name = {'C': 'US',
                     'ST': 'TX',
                     'L': 'Dallas',
@@ -219,7 +224,32 @@ compSize = INTEGER:{imagesize_dm_data}
 shaType  = OID:{self.sha_type}
 shaValue = FORMAT:HEX,OCT:{hashval_dm_data}"""
 
-        self.total_size = self.imagesize_sbl +  self.imagesize_sysfw + self.imagesize_sysfw_data + imagesize_sysfw_inner_cert + imagesize_dm_data
+        # tee
+        self.tee_ext_boot_sequence_string = ""
+        self.tee_ext_boot_block = ""
+        imagesize_tee = 0
+        if self.tee:
+            self.content = fdt_util.GetPhandleList(self._node, 'content-tee')
+            input_data_tee = self.GetContents(required)
+
+            input_fname_tee = tools.get_output_filename('input.%s' % uniq)
+            tools.write_file(input_fname_tee, input_data_tee)
+
+            indata_tee = tools.read_file(input_fname_tee)
+            hashval_tee = hashlib.sha512(indata_tee).hexdigest()
+            imagesize_tee = len(indata_tee)
+            self.num_comps += 1
+            self.tee_ext_boot_sequence_string = "tee=SEQUENCE:tee"
+            self.tee_ext_boot_block = f"""[tee]
+compType = INTEGER:17
+bootCore = INTEGER:16
+compOpts = INTEGER:0
+destAddr = FORMAT:HEX,OCT:{self.load_addr_tee:08x}
+compSize = INTEGER:{imagesize_tee}
+shaType  = OID:{self.sha_type}
+shaValue = FORMAT:HEX,OCT:{hashval_tee}"""
+
+        self.total_size = self.imagesize_sbl +  self.imagesize_sysfw + self.imagesize_sysfw_data + imagesize_sysfw_inner_cert + imagesize_dm_data + imagesize_tee
         return super().GetCertificate(required=required, type='rom-combined')
 
     def GetCertificate(self, required):
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index b6e8b0b4fb09..79b7b37baee7 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -41,6 +41,7 @@ class Entry_x509_cert(Entry_collection):
         self.num_comps = None
         self.sysfw_inner_cert_ext_boot_sequence_string = None
         self.dm_data_ext_boot_sequence_string = None
+        self.tee_ext_boot_sequence_string = None
         self.imagesize_sbl = None
         self.hashval_sbl = None
         self.load_addr_sysfw = None
@@ -51,6 +52,7 @@ class Entry_x509_cert(Entry_collection):
         self.hashval_sysfw_data = None
         self.sysfw_inner_cert_ext_boot_block = None
         self.dm_data_ext_boot_block = None
+        self.tee_ext_boot_block = None
         self.firewall_cert_data = None
         self.debug = False
 
@@ -132,6 +134,7 @@ class Entry_x509_cert(Entry_collection):
                 num_comps=self.num_comps,
                 sysfw_inner_cert_ext_boot_sequence_string=self.sysfw_inner_cert_ext_boot_sequence_string,
                 dm_data_ext_boot_sequence_string=self.dm_data_ext_boot_sequence_string,
+                tee_ext_boot_sequence_string=self.tee_ext_boot_sequence_string,
                 imagesize_sbl=self.imagesize_sbl,
                 hashval_sbl=self.hashval_sbl,
                 load_addr_sysfw=self.load_addr_sysfw,
@@ -142,6 +145,7 @@ class Entry_x509_cert(Entry_collection):
                 hashval_sysfw_data=self.hashval_sysfw_data,
                 sysfw_inner_cert_ext_boot_block=self.sysfw_inner_cert_ext_boot_block,
                 dm_data_ext_boot_block=self.dm_data_ext_boot_block,
+                tee_ext_boot_block=self.tee_ext_boot_block,
                 bootcore_opts=self.bootcore_opts,
                 debug=self.debug
             )

-- 
2.54.0


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E832DC4452B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 18:09:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B344C608C3;
	Tue, 21 Jul 2026 18:09:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lanZbZeN-5uG; Tue, 21 Jul 2026 18:09:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 78223608DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784657361;
	bh=2qO8S4QsUq/yM2AHzkKfQ5mJAoAu+YZTsCySypXFzC0=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=mk2WOWORzQnfbt+vipTlMKW7g5j7BywZxJgHwZbEZa0/k8i5i54oD8Fvt+hkkksHr
	 A6sCWLafI6e7c2/0ZvdhTsMNo3NkZccVWeTHpR7yqwmKARUyVPGR/LpGkTzMRqPf9a
	 t/dEru/Grvb3U+aBN5Ai28RWeznV6yBKVshIsVjT5mVoXe8h0QdN1XO4FqCT2sU5lB
	 lfogXplzKQ5D1+diu02Le/3UzZRKCSNEOQYKfYj9YTn31i6DUHVGtnMBocsi9qb5+L
	 cu/gJeUTq9cvbBIod0zlDoa4Cq1Dx2lFGXQycOPDivvxVU1DoMdT5uKH7RkcmNsuP7
	 lAa7vOqbawbZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78223608DA;
	Tue, 21 Jul 2026 18:09:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A239F9E5
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9419F40589
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:16:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nydhtfFy5bg3 for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 16:16:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org AD14D40544
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AD14D40544
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD14D40544
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:16:26 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDjYUP986954; Tue, 21 Jul 2026 10:30:53 -0500
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fj7pvsjuf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 10:30:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXQNdEoRDdv/9sruWE6ocUOYCNKGti3lL3Yywem9fzf9E08z3/3bLdkZVC22b7nTEn4kisUHDICtUL1GAnjwCnN7W7suWQpup20H1LeB4Ktu9FAXoDeMEGT2SdsYLrgivJChdhvbwyDsQbsfG9E3cy2GAYBqoWtlFlNrPYT7470y3+gd6T/dDM7nHcxII0WbnQfNZJUKePCMp73wsV+/isWbawE18R5OByUTyc7WWs5YiOLVRSjMBywO/RzNt7mip7hxJLiJhXxeJaxY3LjLOks8RzQ6SPjd4n9L21je/HCaawgGzINlT2RzIaLiZzb/ATegkOwhtoB63TjRZ0MeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qO8S4QsUq/yM2AHzkKfQ5mJAoAu+YZTsCySypXFzC0=;
 b=zFvsoKBgw3Z6RkIrJjik4ugvsBFpT/EhI11c6pSWCpaAdAq3+4/whzDlq7i5Dich/dneWTnbABGPYIfUuDjdQne0eyZ0keWeXaa1mJGugR6EtZE3dFKcQEdSnXzi6Cf3U4hqRirNB1fd6ql8yq2PlTYQte4egEMMFHpJtN0TvEgUNXlxxgkBa68GJHthOoaOF0kYIhf+aMR9uqPSh4mB/OTkMS43Oo1K3pIDrvvn8Qb1X82kr5lO17mxtVWHEweFsFaceS2XaNNmHK0XKNm2qUqCYhBMiVaK8XsY6xBDU+bPrd15cxP31DP4F/pZ+dgh8Sun/60rDxO+pL6OIGdSig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from MW4PR03CA0208.namprd03.prod.outlook.com (2603:10b6:303:b8::33)
 by SN7PR10MB6362.namprd10.prod.outlook.com (2603:10b6:806:26e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 15:30:50 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:303:b8:cafe::8d) by MW4PR03CA0208.outlook.office365.com
 (2603:10b6:303:b8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 15:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 15:30:50 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:23 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 10:30:22 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66LFUM4o1031839;
 Tue, 21 Jul 2026 10:30:22 -0500
Date: Tue, 21 Jul 2026 10:30:24 -0500
Subject: [PATCH v2 09/11] doc: ti: k3: fix pygments warning parsing device-tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-am62lx-v2-9-33ff580c267d@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|SN7PR10MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1d0981-e177-4114-cf99-08dee73d0b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|7416014|376014|82310400026|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: fbYK/j3xu6qRoj9dLJPxTpxq62NSXbL18utLKEu0h2vWDoG5BUfBxcAk/9Xn1P+6NACOcY7oXouwSamZYf/fQ7l0QA0A/saRcCr9+Zc1ix90MRUXp1BlrGCmJm67+1hqFQHkNGlEzx3NhAeQTNFswzAa+rjt3s0g9iAu/dPsPGFio2ik+BVuQG37MFOvra3Yk+AZrW3IkyqQW5miyfcsy7Kd62NirbGNUlv77872vQ4H/6YjLzkSKBYy54NksJ10t115JpZFWdoqT1pyvcinakgleAIzXH7W0zB+q2e5oiMyxlX8L3Mf9uUihlek3zvSxpSage1OPhCt7Ss998PYu1bUuxK64iUdkbIxxdftUSlzIkMQJEUpK6618M4ceyBDEhZgGYRege7NIwq4hgyp2iIsOICDU8j/Rm212TSMyPwHlgjg6P8hfKlQynPprcyrQ997Af5T6jqXLGVYmQv74bXeWicOH4T9sipgW6g+/jtv7NwV5B95Q8eX2a/HZ44lNN8OXhMdiWxGwXeclhaJ6A76gam6D2K0yljknC0fZcUKgcIJOmu2Dr0UElK/nZHdu0jrjEqAAhSuIOMUvvAbeLuhwx/Sp5SFA0TL1/ti/Lqru+9ZjCyRv92dwkKCPq6WBXh+fy5bMoJizaCq/mkRWza28sw/gVeTgUVVCJwU8eeITP2efb+vyjezuSA+B+Rdno5DZn/jvuacn3b1Z2aUpQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(7416014)(376014)(82310400026)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dWBixC0gBFZvfjQ9vZwBVeAlP3PQx+ZwZ6KTPRIg6aYIhSfqOjoOkChk11W7OcmHlBozEqM043Ksb+0evGde5pDqXS7hWH7YmTHR/FcirkLtKEgGk+jw6++vHiF73290roe/MpEDazl4EpVKOKJgo67g8CCWBCupQoYR3Xl6kWYDe2VxsM9uw3WyTFQFfKzEUrZoA52jAySPbMJJJebkCM2jIP0se9mjoVefQ3mAKTNbbhxX59+GheaxTARr8l1k16kJIWkunBGZ+rwrYelg6y84cIHHeuCew6t5Q/ZTYYHjtqvurVOy3dxAjEpLv+TWTlqcUH3u6DLvp0b8EdUw9QRFEcISa8yMY8LdP3YdY62VGYTeOYtM+FKAWWx/pAvdHF+9BPO54i2bKeWC0BT72svE3G0loVbrNrALFalLoeYeO1BOgFvtUCRKgbJd04Ck
X-Exchange-RoutingPolicyChecked: k34fj8mQ/KRRdVywePckU75ttZNh5FdqAvJ+w9w1/Ls48zJRFtPJUItkrJ0M9vDoYbzCdorW4PFh9MioLZpQ10cMieDwBkvYVP2UQV+fUCmbvAlUMC47BSQ9vAPTuG4nhhrBaJrQqbq9ng8txyROy5LogrwL5lDkDJHlDtaHJB60/Z1jJt/BCSnNz35gknnSgZiu9vcmZMCfgd73ssnlJtckTHOb3/hF4auyHLeO4IX0k+78bR16BvsZ4tqPjaCGnY9oKa0xGpBd137ESeksCd+NunV5yA3ZBL743ezVsHxez2HXkVJrH2Zda1fpgwSgbFHB0DGFmsJNzwYgZn8VRQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:30:50.2045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1d0981-e177-4114-cf99-08dee73d0b64
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6362
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfX7XjqND4vFKtD
 aOo0vCWdvVnhtn4cZ8xCFwBGIVIDWmDCQLxiynTBSsZTAGTOBN9T1VADCDqae5Iw95yJPI6RL0i
 42kBz2uJIR72HC4cHjU9C3A45O9o+Cg=
X-Proofpoint-ORIG-GUID: JJUbx9JWHMzQe330azyWRaJ3XvdooNv4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfXyiZSc4XBgLhd
 sN+sudUShpnAl6Dzg3uAJ8nuuuypKIyyMODdnXnv/qErWtfnmyqmgVgESe9g8IYPhNY2oMWW4n/
 vsIAniTFBhJCB9zeWhIg70HGHIpF0SQyr9Vb+JTiuQ/LPEwYbt+Pw5fA/rqF112UY9ssJh9IO3G
 23kDik8w1ku2I70GhZM/3PVN/b5hoQHio1f68GbBRPVuGdVxh27w2WV0wszFYpBAfplUnK4u/dg
 8hobCqJMAIWTpRW3a3b3NYQshl8T0nI33DOscFbN/1A/Sns82COt022vIrnpzsN5q5tC7XjuWhd
 AUNhzoz8hC1Mc66Zb7xZ7k3iJcxFtfpJ6r/Po5Dpd4XBmm6xaK4u3mBTY6XXgON6OuP8h/Z9aGN
 Z0tnu9Yfj4TGuFQuemMwEnSS2YN3c99XGDmK5Uwo4zSe6zjFsjqmFdmP43ZlxES4/X5VAIEnaqo
 aZQ0Uu5LajGpmZdwxvA==
X-Proofpoint-GUID: JJUbx9JWHMzQe330azyWRaJ3XvdooNv4
X-Authority-Analysis: v=2.4 cv=MbFcfZ/f c=1 sm=1 tr=0 ts=6a5f90ac cx=c_pps
 a=6KAf8mVNDH8Ped3ZwZ6wqA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=BavfKqRvrzg0Ny7GcN4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210164
X-Mailman-Approved-At: Tue, 21 Jul 2026 18:09:10 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=2qO8S4QsUq/yM2AHzkKfQ5mJAoAu+YZTsCySypXFz
 C0=; b=qkOypzXx4nJv35KFcoKKj7HUGLBk+bKgebQ6Mo3FEpfzdQrEhzYn8qmgA
 gF1wvMyo9GEREaaNKR5vHeodvyu3r47Dw74SSb640acgqv2Svh/Qlr6YKIKH/AvN
 M74HcNDq9LiQwrJCw7k4ke1J8Wj9W6Fk89DA4DX7o3c6Q7spFEzIVruoHyNGSj/u
 /Y0X8xndTxkyF9e6lBu2gjoNFyiuLMzFUI62W/nGe8EVgdaauxuHbNGXUxnAwChz
 568W5mM9hotcwoB/X1qbazM7bf65GLQ+qVseEwQSlPGAfmRyjVSlUkSGdZP+wvUL
 0ve8ecvwWSCnIWlTIFVFVOYi1KwdQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qO8S4QsUq/yM2AHzkKfQ5mJAoAu+YZTsCySypXFzC0=;
 b=KY/GjqSWDoVByzGB5rOa/I8yUtQ2wObWdMOZooQZA5pQjnO7ppOWKVVA0jEuPUXQCdpbL7f4YqvqhwvKyhQyltC6rG9MIh1zXxJTU42gosJZibC2Y06sboP8S49jqiJf1hwtWX7jGg1+U2YVu1XdOByauRBNyszCaoTWHV0sVXQ=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=qkOypzXx; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=KY/GjqSW
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

A warning is emitted when generating the FIT image examples because of
whitespace and invalid node names. Fix them

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 doc/board/ti/k3.rst | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index d3ecaf599094..b7b69949af16 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -466,25 +466,29 @@ choose any configuration at runtime to boot from.
 
 .. code-block:: dts
 
-    /dts-v1/;
+   / {
+       description = "FIT Image description";
+       #address-cells = <1>;
 
-    / {
-        description = "FIT Image description";
-        #address-cells = <1>;
+       images {
+           image-1 {};
+           image-2 {};
+           fdt-1 {};
+           fdt-2 {};
+       };
 
-        images {
-            [image-1]
-            [image-2]
-            [fdt-1]
-            [fdt-2]
-        }
-
-        configurations {
-            default = <conf-1>
-            [conf-1: image-1,fdt-1]
-            [conf-2: image-2,fdt-1]
-        }
-    }
+       configurations {
+           default = <conf-1>
+           conf-1 {
+               image = "image-1";
+               fdt = "fdt-1";
+           };
+           conf-2 {
+                image = "image-2";
+                fdt = "fdt-1";
+           };
+       };
+   };
 
 * Sample Images
 

-- 
2.54.0


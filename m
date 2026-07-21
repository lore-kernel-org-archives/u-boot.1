Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55913C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 19:29:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81CBD80AA9;
	Tue, 21 Jul 2026 19:29:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tDDhBIYXmfBw; Tue, 21 Jul 2026 19:29:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 45B0E80C23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784662179;
	bh=/C1CRfilhzgQa/zYmt6syGTM871VFwKAJ95bSl0FqM8=;
	h=Date:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=SFb9dl4Zk/UoVHV+KQ0Y2fmptoGI00X6D6FpfgLFXwVz1e+vr4Hv9kuUeFafxNIFN
	 ZLVSEc0q6gmQ9t6ap0oXSjMK+5p2JK4Dr39B6J8ANOwGLVttPvCN4z1vccFbuo7kmn
	 Qrm4U6B3GY4HZb3SYEHAulpxiVrb+JVX+B717Nk6f11/XNv7UzZbHydGKt7sju6dzI
	 Drehcyu7o46LIF5VtzDg9dSeeYxSFfWpVIIW+ZLCnuFHDl0gPrgjZsAs7OIrP+gtPZ
	 +dU90NTb7EBid8nWQCXy6C6AjdD1HIgabezBcByu0OmeoTFggousXTiHwj0aWf6BI3
	 hx2pO/B0n2p/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45B0E80C23;
	Tue, 21 Jul 2026 19:29:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 76875EB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 19:24:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C92A6089B
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 19:24:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OrxUbW1A_46n for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 19:24:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 414476089A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 414476089A
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 414476089A
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 19:24:42 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66LH5wjU3627382;
 Tue, 21 Jul 2026 14:24:26 -0500
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fj869jv3a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 14:24:25 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iulLi2FRo4qOAgPB70NODGe5o5Gc/0LyXuero5FCsiHEuLMHDi2+dxsjCP0AUy2Gybb8Fp6honyKK5f9dYIpuOX6xmNGfPDFCuu5ow8rk33/mqe0/hnvmfxqpcbG4EvXGQKh4pjlhr4m2gbiciFJWEVWopcEeL9sVfm9zXLhdWCYRKqqU8eTmrRqpBhsAgMe0Sv1MKcPXPJ+Ram7OjeTyLrJAB40Y4DH4DyqIdHLN1puRbH2xbrh0yVu1Bv1OiRfA0CR+u3GAjY+Zp6nye7gq9ye/zcPr2pBopcmC+gp+l07yARO2EzQ/BSQl7j1bil67ZRV7rQD7ZbJ9cq/yBkG6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/C1CRfilhzgQa/zYmt6syGTM871VFwKAJ95bSl0FqM8=;
 b=Qo1IQyZT+p7AR5DiZPyGy024t6/BgGnaNJMrFanZa3waTamyKdLI5OoC6JlDcviqNjacWd+vUZ+HVCUyUHY9tXxV6LDygpsh44RZnbCpPvlonRiXqQ1Xu4lA/6lltVMT9SZvxO7VcI8cfNKHgRQbQUzlF3UEjBqpN+0GfpX8WnwY5J8K/1Kek/KFmAGrkxuWjn5hoqhTDdu2l1FAlopJ3JdAtOtoz01K6uwYtIk+b32KLPWKRpCGNiaFDxJcgLfk2ddwc41y1Y6480nNrVRsK+7HISd4Lf1AuW5mhnEwwuNCHR82wPmnCAV4Ute0IcLZd0p2r4stcdvSYnxXuZQ0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from SN7PR04CA0166.namprd04.prod.outlook.com (2603:10b6:806:125::21)
 by MN0PR10MB5934.namprd10.prod.outlook.com (2603:10b6:208:3ce::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 19:24:23 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::68) by SN7PR04CA0166.outlook.office365.com
 (2603:10b6:806:125::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 19:24:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 19:24:19 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 14:23:52 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 14:23:51 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 14:23:51 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66LJNptm2058114;
 Tue, 21 Jul 2026 14:23:51 -0500
Date: Tue, 21 Jul 2026 14:23:51 -0500
To: Andrew Davis <afd@ti.com>
CC: <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>, Peng Fan
 <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Alice Guo
 <alice.guo@nxp.com>, Anshul Dalal <anshuld@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Udit Kumar <u-kumar1@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>, Rasmus Villemoes
 <rv@rasmusvillemoes.dk>, Vignesh Raghavendra <vigneshr@ti.com>, "Manorit
 Chawdhry" <m-chawdhry@ti.com>, Dhruva Gole <d-gole@ti.com>,
 =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 George McCollister <george.mccollister@konsulko.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 "Swamil Jain" <s-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Shiva Tripathi <s-tripathi1@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "Aristo Chen" <aristo.chen@canonical.com>,
 Johan Jonker <jbx6244@gmail.com>, "Apurva Nandan" <a-nandan@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Hrushikesh Salunke
 <h-salunke@ti.com>
Subject: Re: [PATCH v2 03/11] soc: add data to identify the am62lx
Message-ID: <20260721192351.vafgnrj647bvqo57@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260721-am62lx-v2-0-33ff580c267d@ti.com>
 <20260721-am62lx-v2-3-33ff580c267d@ti.com>
 <3bed7ebe-41e9-4f48-a69f-45c5b27b38fa@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <3bed7ebe-41e9-4f48-a69f-45c5b27b38fa@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|MN0PR10MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d9a261-a669-4ce8-eaf6-08dee75da999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|18002099003|22082099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 34J3lZrFqKbP/+o5Zq8qsDtG7E1W/LdYdUYTMpwECkeRXBOw+wcImPf3dud0o6SXFsFW92HGzqujNImeX7RnALomZFcmwQ/IQ3cKfDKIQyJ8sunQuA4ArNHBhVsIqyXFHdyB+fprWVb88w0A02lj9gHBINc8wrSFDj7jPM5LHzEmeW0BQjLpVdxqJ+ZoB+KngB9mRArVI8UKd3bUiALrJAv5qteakqqVj9w2PuyVyavWMFvESiwrb4m9Wt7pRtBDkmn0l1DxIaO+C32XiUEXUJKHImeuP67hnov+u5dHLwrUthoJa0nDNJhwmnfGyt3BwwH9abbKEFmqSE/W+6KxKS3mw9PVRHOajTn7qRFmI5EfgLp2n9Mk/sqBiSGIsDOPfojb7DXdc4aT01epbfK6dfZlMnDYKpa5n/Pw9t3bWxZtQItViAAsfUA5+5FrGelo4mU7HeFrdFktx02aUt/rWwrMi9l+cIoGA8GV0wB6HYfWcTSpULuA8HvhEsRI+W6bobIwNPGQuYSbNPcAmvSL38ukuDT7OBzvQuo7/f7IiCUmVH0PjEPaMXYUdC35MTXKkMkY8V/rZ0oq7QoiKjsAzQLUaLWVk5f39F8xWD+IoEBkk6Ga1yeCx+M4QPr2PmTtCwHczB11flbRGKTeygqy3PO8brR1HPIXXN2M+1c/Ud0GBJI+tFXFJK3WU3BUch3iiIjFD7IqDGE0nGg0Cl+0XQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u6TyyDHNim2RY3RCUcdDDUTyKZ/kFHb1TLXHizE0hvwFzfKsHa6o6zbNdBlL7vAuFaRyLvNP4hmGyMTzpZHpqx2YV4SlCWLvIn3NE5U3YNYMGa3i4Z7YYTFN0oK9FrvMFNZn+Ct1T9v44N8j1jI4pA7XcUINKPFEOIN8bhp3AbeySU/9mKc/98aOdiYpdJPhJ3C2CCN6EmJM78d3JwdVijRxmhFIaeR5+3Kz+SajD/pHTNu6G3uWxsKrk+qBWo59SrdLwAfX1HMIAsQT6jzqx7MzfoPOAXtaxgVtmV32uzMQqfCKMq7mtG5t/OsrqCSCn1IaiPEMJy9xWUKIQYj98BRwArq/ZjNyou/PkWDbEi8tdnG93aGES6zy8n0HsoUIeVhQYUozuKhIZ/xN2QLywdYiz8kkCvHCiNCiMNiUrAHYdETrk8cIuZCn0AMGymV1
X-Exchange-RoutingPolicyChecked: V5iMVQyHHAQKfEcmCgl4nyQvMRdNHI9ExErmPhDWX5SK7ZSEcIaQIuErYTfQEYrV7zTAicPneNuaFKXbrTToN7Vq5oHOI1gtgqaXqpPLehXofSn12pLWY+Sb3x2DpUIaVYo+EtSyl649HrEB7CAHmBw49idfx9YqIcR+NIwDK1+z/DtqHzf0nAqrvm1Y3tYMzdLWZvfyMfTZZf/dFqe9QYyNtK2vWCjDyZEXrdqFninF982wajfDoJrucBYxhyipUolzGRB3hshwmmMtV3Rp5a9vd1cvsvwYwi+gf/5Iot7NQWfeQSWjtGTJc3ENAsOzyyFxSBCtqDzH8ciDjkqGYg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:24:19.5953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d9a261-a669-4ce8-eaf6-08dee75da999
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5934
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIwNCBTYWx0ZWRfX7cVZht3SapUm
 nPlRKnsCW0UvI+VJgrWNNjXLQEWJHA3kNw9mR5SAfeJjHDsJmH+hWDqeefyxQdQlVHdCk6enua+
 e7MZBFC1zz9Zz3xXNg6FUq2XPaZDNyFYAJW037SGnVlsjOXhGKnqmKAYlixOje890OMkargpXI+
 jr10BHhnqJyWP9iskFIwaZnwmn/8ifcEFJZfr2GzaIUH3Nmq/2QpTYUZkBB13vDblzkUqIED7d9
 GaM0uoVbHrDfGFwPMm17IIISflzql6PnjMZ/fErdcd3dLNVm4qdg+Fc5SJe61HbCCP0oILGryZR
 bp3vappLfSKW0WHpvx7VLbo3lU8fWorra1Z2NC8GXlFfRIp4xGb0vgH91Xa6JRQjrA5vcJ81qN+
 HoSwa8DAjNGyoNtg7a1l5URtCxwOv1qzrDFWA5DYm/cXpARP9SZ7oYmbGR911hjvElAJ5EVzl/Y
 dlYoTAlg8A1KGJi4VJw==
X-Authority-Analysis: v=2.4 cv=WbI8rUhX c=1 sm=1 tr=0 ts=6a5fc76a cx=c_pps
 a=kfEGYAivpUbBRfgbjfv6iA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=k54j0JTYUfqhJPwwizUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: C0O9kJhDh5tCR5xHhgBAZulrP2VmuLkE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIwNCBTYWx0ZWRfX10fb+qdqdMnC
 bBg1Xg0X+FTnE5mMKOWfZwuFIneuR2MrtSaBB6WPmUu8M6EN0SP3xO6cLywLvU9BafzQsEV+fk2
 Ba6v8HlH4FMhkictyKThdN7mMUty9Kk=
X-Proofpoint-GUID: C0O9kJhDh5tCR5xHhgBAZulrP2VmuLkE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210204
X-Mailman-Approved-At: Tue, 21 Jul 2026 19:29:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=/C1CRfilhzgQa/z
 Ymt6syGTM871VFwKAJ95bSl0FqM8=; b=WhTg1P97DzHleJoLGT+nIK4CIiu6NFB
 4ILwEkvMk2Sk5jbacdeu/GQ3Srb4/gOnx1Y0e6SBudmctAK6S0vXAGEt/FCpOrgD
 0uG4q91Qqq2X+8jj/uwClJHhf/kpuJ2jGRpZVH2DiLthhN3c6ETkKUIIhFW8NHy/
 IyU5YIG5lRzxK+bb5m6r0YuWaFMGWju1+U4+JdybQ00GfDmUYhh1HQXGHP2lA31u
 AV91BNz5SOYNF52lU9EaZFkJmQ1wOyH/k9k9BhAkM+B5YcYSPK66kB/NM7ZK3k7g
 mFtErJ+RuTNZ/XTtoD371LLyFmqquPBLLxhVQ7nfNdVXb6XLp+siNlQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/C1CRfilhzgQa/zYmt6syGTM871VFwKAJ95bSl0FqM8=;
 b=ZCKfmqpKxE1XbhH3S32JhpTTjws959SOzbVxy+P7uWUoFN/XDfQFfDkOIHgHR7wYrpDTm4W0dPCYDfNtJR4XgSo5YHaten80l9OmOZAqhBl0W738DMphb7RlCGFFPETDe24fWPCA4Nd2WO3omHZDKYfzbjwgpq6vJ8RoKwOQAi0=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=WhTg1P97; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=ZCKfmqpK
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

On July 21, 2026 thus sayeth Andrew Davis:
> On 7/21/26 10:30 AM, Bryan Brattlof wrote:
> > include the part number for TI's am62lx family of SoCs so we can
> 
> Commit messages are normal sentences, capitalize first letter, "." at end.

Yeah I can fix that

~Bryan

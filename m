Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED79C4452B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 18:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6AFC44096B;
	Tue, 21 Jul 2026 18:09:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JW-lAgUHFf0w; Tue, 21 Jul 2026 18:09:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0A8384096C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784657347;
	bh=bP7h7VupiPcdUJZwrk6qfJyGo9+cKv8ZJhYbKDaQ7Yo=;
	h=Date:Subject:To:CC:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=w9qNwOjeLKfm3eE2PGdVVIzwVGol4HveDlHWL8kF6/lwnhTdG5THPPdw7L62qj3SN
	 6yakpJCH0qa2RKqm2ZdHkdtrGo3Lhf4Uq7uqUtD1KZiY5xWKnv55GGe9R6C7lO0M5B
	 QDrvfphuhbBYBSqLQdc35yn7KU01IUrWcXWoQgoPN5CsS2BDniPMFJqcsrCsU0wkPw
	 fgKZ3WyKdRJ0ez/+TU8m6SiwKHKrGJakamG9mODGTFruujIXWeYoqm0QNKU9fY+zxY
	 yx/xbd3Ac2VvqiqJIfzV0z5K/44dodBtsWc5K0ockmn8TeD4KlkeP64ISe5020BkpX
	 PYxnIlQwKgfKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A8384096C;
	Tue, 21 Jul 2026 18:09:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 419BD109C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 17:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C88460859
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 17:23:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uY6ySka_fB6y for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 17:23:39 +0000 (UTC)
X-Greylist: delayed 1199 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 21 Jul 2026 17:23:39 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7E00B6084A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E00B6084A
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=afd@ti.com; receiver=<UNKNOWN> 
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7E00B6084A
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 17:23:39 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66LDjUu03231916;
 Tue, 21 Jul 2026 12:04:06 -0500
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fj869j0mf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 12:04:06 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVkQ2BN/P1ia+H1AvoZmNSTZ/sDnJWQbEqvOz8WG8XkZkvnB0kKyCohzc5A1CjEzFCn9BhHogPQ4uf2GUS7YgClnFRQVQJjVQQjBdAPe/UdtQ2M7KWURFb4PFzk8zChv8sRV0yp/01WIeSNQDopo2ouZegOlIWuz+7W5L8iD/cwQeJFW1dsur3VLueJEO/zN92AQtV9GvhlVJ4D5B+YOWFUXsDPUizs3SLNiA47o8NqtmOQismX7d200p9Rby+7+Tt+Mw0S7xU6vsvSG+6ufyLHT8MoCdRf3EvkXtuN9eZ0ZuNZGDPKJo+88GKQpEaKTHkDO43nL7BGRkHLrw0THyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bP7h7VupiPcdUJZwrk6qfJyGo9+cKv8ZJhYbKDaQ7Yo=;
 b=neI2gbtzIqHStjURXeQ78LVIS6yuxMUdzjNOiMdCd1+uJaVHrCU9EfDYeZiHcoY/QQexTRRWYAa/cDgnTYoU1lUyzWNHkzEJFkoT7KRoG/9+E/3n1pnL2oAmmQK3wWu1vJYqv0QlSpX062kwP3pFy1J2xDvZMxBu7lU3qlr5HccASkUj2JL9mEFsrpQNgptBSuVPNQFIIQj3M5NgqEMlzryNCLG9jJt9y4FWMGQYzdoTUuAJ8VmY8QaAWc9V/IbfOLCC9yh2yEl7Bk1Lpr9YWJHhVJ5NDQ1aOkTLPQkX0QIu6KAQN3q7az8sF7tGomL53Hur3dtnIcVL0rHOs0sVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from SJ0PR03CA0385.namprd03.prod.outlook.com (2603:10b6:a03:3a1::30)
 by CH3PR10MB7611.namprd10.prod.outlook.com (2603:10b6:610:176::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 17:04:03 +0000
Received: from CO1PEPF00012E63.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::a2) by SJ0PR03CA0385.outlook.office365.com
 (2603:10b6:a03:3a1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 17:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF00012E63.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 17:04:02 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 12:04:01 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 12:04:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 12:04:01 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66LH40w61825739;
 Tue, 21 Jul 2026 12:04:00 -0500
Message-ID: <a1d1189d-9a52-4cd5-8c44-b5317c74845d@ti.com>
Date: Tue, 21 Jul 2026 12:03:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] board: ti: am62lx: add initial board files
To: Bryan Brattlof <bb@ti.com>, <u-boot@lists.denx.de>,
 <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Alice Guo
 <alice.guo@nxp.com>, Anshul Dalal <anshuld@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Udit Kumar <u-kumar1@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>, Rasmus Villemoes
 <rv@rasmusvillemoes.dk>, Vignesh Raghavendra <vigneshr@ti.com>, "Manorit
 Chawdhry" <m-chawdhry@ti.com>, Dhruva Gole <d-gole@ti.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
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
References: <20260721-am62lx-v2-0-33ff580c267d@ti.com>
 <20260721-am62lx-v2-6-33ff580c267d@ti.com>
Content-Language: en-US
In-Reply-To: <20260721-am62lx-v2-6-33ff580c267d@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E63:EE_|CH3PR10MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea1c749-34f9-4ced-3466-08dee74a1089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|7416014|13003099007|3023799007|4143699003|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /2+UaOfflhzeDbGXEmOFSrAWe5dn1+gp0CbjbgifZ2XcfLj7Lq4Do9WI5ssoLP5LY1+/Vgm1Y4Gixj5hoydM0kMW/wUUFWGNV1cmbz3HDIpPGp7U45BM5KxGdj03Evvx5+0Zp7b/K5aouKyEdR01XLNe09yjcS6apxd6YIbvmt4sxNoVjoUlDFwxspndsD+YTuE+r9TdZc2fWwlpoa/LyM7adZP7q7QUKPiiBA9hb8LbeqogMcfUgBWjMwzkPpNAm8kRToWbEWSPkYBCiWpiRp1Pi1osRhCQbr+qV3O2jHY/wd8YDPkoB5j8XDW4RwGxFJxvYPGuTy6xV1UoYmtZn9ZlsVIs9XcunonMuS02x9mP86Y7ZlRvP3jo7S7mEWD/TLSfTcEo8LQrS0kVvhWAcrRaAXM9PWgVuRzd9qhfOhkHjYamvBiucLCpny4oOVl7gZTjG+WyHJUS+JSRTEDpdUcu2h1VrnJlDV4vdHFqOo0v0vxi+xbn1DAfPAokq8wSdpDF5Uz2Xd11O31dBkplOk3wOXjNkcEc+EvG3k2TsQWlYekt9pzwJmkoLnWNnnMuv4/BA5iKs5bdldS7wTksAFKQlMUzH/JzzY+WUtmgDG+j61u+LXZ+9+bmvrCaGkXEKHrQhejeAEpVH85ApvQLDA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(7416014)(13003099007)(3023799007)(4143699003)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7a9PfRNwYPVH+ogBOazP+U45ql7VupDOrlAS4A0O3WGMCk3J97zQUnOmGHqk/6jy7895rS6jKGbU2FgJZ4x4ydKdRrx4pHsVODEUqhnGhliNN4gDmvHm8jWh2688IM6YZJdFJ9dLe/NNpCjsQ4CKRY8Z2rRbHZXGxQdrQSVBaOUCWZp7JPBtxKjHimrkjJ/pE21BBg4tsBB5jdQo4+qmH2e+0CJC0+c3pgMqrjLRH1DIQWD3qtgYmm6OCyuPEz6krmVhmYKR0rdTSumiGlgy0vUefedBbjC5oATM/ewL9bl2LWUTsrdxoKPhJLP85u2IJFX8eBrPtT0xMLZn46SVqJu06R5P3abcWDTXiURxRHwkZQ8KUFLITKfT5kXFz3BdM80Wgw1w7aQhM6WQuHbzVv4OtXW92ZSrdYDzdTnwatUIzGRErfV2w+X0X/Sozm/9
X-Exchange-RoutingPolicyChecked: XFLAq9KUvfsaGJXtiAltiuVQdTqRAoqqGu2c6AwW7DkMPsfFRSlKFbOSAyPsu+6yK9ckpWrLYjvUwGMarqR9TYUFLJa8CepmoHX6sLGpcF973TtJcu15Tloj2Dnk6mOStnZ1Pz+P7yiVcmWo6O7sc+aqI8vNBYxMdHiY7IfaYmd/Ohqx78Jk/UmEuOkuS29BbaPww5CjtWeWOA2PNmXhW3tf2qG/WZw0CiaBbSzTAQnmH7JTHhtGN+kEehQBZhXqccouCCS0QdCjRkSGZF5oqqX3tDj9tDFw7lJuMoyr2z0k2050svKZ3wlru6F9/j6VpOgVYEmXNqv/gSDQf/Gfow==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 17:04:02.2853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea1c749-34f9-4ced-3466-08dee74a1089
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7611
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE3OSBTYWx0ZWRfX4FkzNSIKUDkG
 1ng40CEboSrnxW+33M0A4l8ux7j8cv/DeDYY0ROKEauOaWp3jYta5vQeZZz1Se2s9w4Kh0fLkEk
 +qqWD9chlM3KaX/hrCR/VRPLieUv+KzceewSxjRa+GMAvzUhHtDJCQlE5K09O13nONbaSXRb2FV
 WyZAnXAW+s4org4YW5SAlPP30p8RVXQmmIi4JN38TXK+yqzewSw730lz7434QwFdNACW3i0QOwc
 2/D8Do0YV732EBywTheWvoQfiyKntyAkdtDWnQII7G2iU/ftKooAQw6rDNFNthnmulOcm5nxQ6a
 TSebCib/XXnAQl9qWdifKXdG4T9T67vKde1f8vHp92tovyoTe1Hp43jbzgCjax0OWJkhgje9Bzt
 A+hrwRa1l1fmshG71bgfGyG9DH44SaeT23aaAb+pMZgtFSola0cWCmtoIn4bBpEGPfbkRriLfKt
 BU4bpgq9GxShtxSTZQw==
X-Authority-Analysis: v=2.4 cv=WbI8rUhX c=1 sm=1 tr=0 ts=6a5fa686 cx=c_pps
 a=VTZ9QiboGVM1ljQMw9N7kA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=k-42gJp3AAAA:8 a=1-tITlzJkOW8L2dd478A:9 a=QEXdDO2ut3YA:10
 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-ORIG-GUID: uX3wh3_aWmei76mCM9TzdIUAgJ6fXDFQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE3OSBTYWx0ZWRfXw+MGRPOVhJe+
 pwL/ojfZcUFYblHNL+OcG2Ye7W7DJtbAYrmQVCHhoJEFrQS1UYtp7tiOOUyIQvbyUOhCSXDE14+
 ABjFy2Dwm9jGOgwL3G7JbmT5iQ2VaDs=
X-Proofpoint-GUID: uX3wh3_aWmei76mCM9TzdIUAgJ6fXDFQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210179
X-Mailman-Approved-At: Tue, 21 Jul 2026 18:09:05 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=bP7h7VupiPcdUJZwrk6qfJyGo9+cKv8ZJhYbKDaQ7
 Yo=; b=Ssw4oKspGKoUWYGl28tb+1wQ/E1r0u/ujxd833+6/PtllK+Ec9mkaZhid
 WZxqhOVxd9m2Ft5nihwEUdzvj6Ls1xmbwKlvMdXnySmbOTP2XTFXx7ROIp1v+E4R
 CCNTvk40wqYOXPDHUa49VVBxRQmkXnxEj6iwUftwGr+E1hLALGUAXKHFu8RYZBIf
 K0rt+h7YzOBlM7uWxzagwghpiUT+w3KaXtMd1RVgQVsvfG+uccbG43cyXpJ5p/7m
 hLY8EYLsb+HWCVjs38bz/GcymsGTfbgau+0RfMwiZawV4w1vZ8bie3dKe+iZot0e
 4TtK26CVJG3h/IW+zHzYZVM6VbpbQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP7h7VupiPcdUJZwrk6qfJyGo9+cKv8ZJhYbKDaQ7Yo=;
 b=EWHAOJAt/eueDFC7tGQOm02MkhOI3Znkg0a14snhNVMOdk41bcJ2u8dBYL4iiM8el3jOGZila0aC9kIP4VkRl4s4AvEgRnkaPqpScvxv3uKU7Fv2+3j+e2yuYfG4WD81wNHZ8xM2uz3s/gRBtiPyhhn5NbwRuTrNciIfwVlf+co=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Ssw4oKsp; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=EWHAOJAt
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
From: Andrew Davis via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Andrew Davis <afd@ti.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/21/26 10:30 AM, Bryan Brattlof wrote:
> Add the initial board files to support the AM62L3-SK reference boards
> for basic boot via SD and MMC
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>   board/ti/am62lx/Kconfig        |  19 +++
>   board/ti/am62lx/MAINTAINERS    |   8 +
>   board/ti/am62lx/Makefile       |   7 +
>   board/ti/am62lx/am62lx.env     |   8 +
>   board/ti/am62lx/board-cfg.yaml |  32 ++++
>   board/ti/am62lx/evm.c          |  19 +++
>   board/ti/am62lx/sec-cfg.yaml   | 380 +++++++++++++++++++++++++++++++++++++++++
>   7 files changed, 473 insertions(+)
> 
> diff --git a/board/ti/am62lx/Kconfig b/board/ti/am62lx/Kconfig
> new file mode 100644
> index 000000000000..2ee6d0221178
> --- /dev/null
> +++ b/board/ti/am62lx/Kconfig
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> +#
> +
> +if TARGET_AM62L3_EVM
> +
> +config SYS_BOARD
> +	default "am62lx"
> +
> +config SYS_VENDOR
> +	default "ti"
> +
> +config SYS_CONFIG_NAME
> +	default "am62l3_evm"
> +
> +source "board/ti/common/Kconfig"
> +
> +endif
> diff --git a/board/ti/am62lx/MAINTAINERS b/board/ti/am62lx/MAINTAINERS
> new file mode 100644
> index 000000000000..e945689a7f17
> --- /dev/null
> +++ b/board/ti/am62lx/MAINTAINERS
> @@ -0,0 +1,8 @@
> +AM62Lx BOARD
> +M:	Vignesh Raghavendra <vigneshr@ti.com>
> +M:	Bryan Brattlof <bb@ti.com>
> +M:	Tom Rini <trini@konsulko.com>
> +S:	Maintained
> +F:	board/ti/am62lx/
> +F:	include/configs/am62l3_evm.h
> +F:	configs/am62lx_evm_defconfig
> diff --git a/board/ti/am62lx/Makefile b/board/ti/am62lx/Makefile
> new file mode 100644
> index 000000000000..ac5f5e7e807a
> --- /dev/null
> +++ b/board/ti/am62lx/Makefile
> @@ -0,0 +1,7 @@
> +#
> +# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> +#
> +# SPDX-License-Identifier:     GPL-2.0+
> +#
> +
> +obj-y	+= evm.o
> diff --git a/board/ti/am62lx/am62lx.env b/board/ti/am62lx/am62lx.env
> new file mode 100644
> index 000000000000..0dd86db400ee
> --- /dev/null
> +++ b/board/ti/am62lx/am62lx.env
> @@ -0,0 +1,8 @@
> +kernel_addr_r=0x82000000
> +fdt_addr_r=0x88000000
> +fdtoverlay_addr_r=0x89000000
> +ramdisk_addr_r=0x88080000
> +pxefile_addr_r=0x80100000
> +
> +dfu_alt_info_ram=
> +	u-boot.img ram 0x83000000 0x400000
> diff --git a/board/ti/am62lx/board-cfg.yaml b/board/ti/am62lx/board-cfg.yaml
> new file mode 100644
> index 000000000000..ae4b0e503bd1
> --- /dev/null
> +++ b/board/ti/am62lx/board-cfg.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> +#
> +# Board configuration for the emulated AM62Lx

Emulated? I think we are past the pre-sil stage here :)

Andrew

> +#
> +---
> +board-cfg:
> +  rev:
> +    boardcfg_abi_maj: 0x0
> +    boardcfg_abi_min: 0x1
> +
> +  control:
> +    subhdr:
> +      magic: 0xC1D3
> +      size: 7
> +    main_isolation_enable: 0x5A
> +    main_isolation_hostid: 0x2
> +
> +  bm_writer_cfg:
> +    subhdr:
> +      magic: 0x7D8A
> +      size: 5
> +    allowed_host: 10
> +
> +  reserved: [0, 0, 0, 0, 0, 0, 0]
> +
> +  debug_cfg:
> +    subhdr:
> +      magic: 0x020C
> +      size: 8
> +    trace_dst_enables: 0x00
> +    trace_src_enables: 0x00
> diff --git a/board/ti/am62lx/evm.c b/board/ti/am62lx/evm.c
> new file mode 100644
> index 000000000000..cafafb8ede87
> --- /dev/null
> +++ b/board/ti/am62lx/evm.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Board specific initialization for AM62Lx platforms
> + *
> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + */
> +
> +#include <asm/arch/hardware.h>
> +#include <asm/io.h>
> +#include <dm/uclass.h>
> +#include <env.h>
> +#include <fdt_support.h>
> +#include <spl.h>
> +
> +int board_init(void)
> +{
> +	return 0;
> +}
> diff --git a/board/ti/am62lx/sec-cfg.yaml b/board/ti/am62lx/sec-cfg.yaml
> new file mode 100644
> index 000000000000..044e8cb09dd7
> --- /dev/null
> +++ b/board/ti/am62lx/sec-cfg.yaml
> @@ -0,0 +1,380 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> +#
> +# Security management configuration for AM62Lx
> +#
> +---
> +
> +sec-cfg:
> +    rev:
> +        boardcfg_abi_maj: 0x0
> +        boardcfg_abi_min: 0x1
> +
> +    processor_acl_list:
> +        subhdr:
> +            magic: 0xF1EA
> +            size: 164
> +
> +        proc_acl_entries:
> +            -  # 1
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 2
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 3
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 4
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 5
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 6
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 7
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 8
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 9
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 10
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 11
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 12
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 13
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 14
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 15
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 16
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 17
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 18
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 19
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 20
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 21
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 22
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 23
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 24
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 25
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 26
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 27
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 28
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 29
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 30
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 31
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +            -  # 32
> +                processor_id: 0
> +                proc_access_master: 0
> +                proc_access_secondary: [0, 0, 0]
> +    host_hierarchy:
> +        subhdr:
> +            magic: 0x8D27
> +            size: 68
> +        host_hierarchy_entries:
> +            -  # 1
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 2
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 3
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 4
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 5
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 6
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 7
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 8
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 9
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 10
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 11
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 12
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 13
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 14
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 15
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 16
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 17
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 18
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 19
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 20
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 21
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 22
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 23
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 24
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 25
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 26
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 27
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 28
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 29
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 30
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 31
> +                host_id: 0
> +                supervisor_host_id: 0
> +            -  # 32
> +                host_id: 0
> +                supervisor_host_id: 0
> +    otp_config:
> +        subhdr:
> +            magic: 0x4081
> +            size: 69
> +        otp_entry:
> +            -  # 1
> +                host_id: 10
> +                host_perms: 2
> +            -  # 2
> +                host_id: 10
> +                host_perms: 2
> +            -  # 3
> +                host_id: 10
> +                host_perms: 2
> +            -  # 4
> +                host_id: 10
> +                host_perms: 2
> +            -  # 5
> +                host_id: 10
> +                host_perms: 2
> +            -  # 6
> +                host_id: 10
> +                host_perms: 2
> +            -  # 7
> +                host_id: 10
> +                host_perms: 2
> +            -  # 8
> +                host_id: 10
> +                host_perms: 2
> +            -  # 9
> +                host_id: 10
> +                host_perms: 2
> +            -  # 10
> +                host_id: 10
> +                host_perms: 2
> +            -  # 11
> +                host_id: 10
> +                host_perms: 2
> +            -  # 12
> +                host_id: 10
> +                host_perms: 2
> +            -  # 13
> +                host_id: 10
> +                host_perms: 2
> +            -  # 14
> +                host_id: 10
> +                host_perms: 2
> +            -  # 15
> +                host_id: 10
> +                host_perms: 2
> +            -  # 16
> +                host_id: 10
> +                host_perms: 2
> +            -  # 17
> +                host_id: 10
> +                host_perms: 2
> +            -  # 18
> +                host_id: 10
> +                host_perms: 2
> +            -  # 19
> +                host_id: 10
> +                host_perms: 2
> +            -  # 20
> +                host_id: 10
> +                host_perms: 2
> +            -  # 21
> +                host_id: 10
> +                host_perms: 2
> +            -  # 22
> +                host_id: 10
> +                host_perms: 2
> +            -  # 23
> +                host_id: 10
> +                host_perms: 2
> +            -  # 24
> +                host_id: 10
> +                host_perms: 2
> +            -  # 25
> +                host_id: 10
> +                host_perms: 2
> +            -  # 26
> +                host_id: 10
> +                host_perms: 2
> +            -  # 27
> +                host_id: 10
> +                host_perms: 2
> +            -  # 28
> +                host_id: 10
> +                host_perms: 2
> +            -  # 29
> +                host_id: 10
> +                host_perms: 2
> +            -  # 30
> +                host_id: 10
> +                host_perms: 2
> +            -  # 31
> +                host_id: 10
> +                host_perms: 2
> +            -  # 32
> +                host_id: 10
> +                host_perms: 2
> +        write_host_id: 10
> +    dkek_config:
> +        subhdr:
> +            magic: 0x5170
> +            size: 12
> +        allowed_hosts: [128, 0, 0, 0]
> +        allow_dkek_export_tisci: 0x5A
> +        rsvd: [0, 0, 0]
> +    sa2ul_cfg:
> +        subhdr:
> +            magic: 0x0
> +            size: 0
> +        auth_resource_owner: 0
> +        enable_saul_psil_global_config_writes: 0x0
> +        rsvd: [0, 0]
> +    sec_dbg_config:
> +        subhdr:
> +            magic: 0x42AF
> +            size: 16
> +        allow_jtag_unlock: 0x5A
> +        allow_wildcard_unlock: 0x5A
> +        allowed_debug_level_rsvd: 0
> +        rsvd: 0
> +        min_cert_rev: 0x0
> +        jtag_unlock_hosts: [0, 0, 0, 0]
> +    sec_handover_cfg:
> +        subhdr:
> +            magic: 0x0
> +            size: 10
> +        handover_msg_sender: 0
> +        handover_to_host_id: 0
> +        rsvd: [0, 0, 0, 0]
> 


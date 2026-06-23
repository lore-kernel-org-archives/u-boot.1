Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3093CD4F26
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 06:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 044AF849BB;
	Tue, 23 Jun 2026 08:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IT3127QC";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EaM+bP53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0265D849C5; Tue, 23 Jun 2026 08:18:49 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C597848DC
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 08:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65N5knQb673214;
 Tue, 23 Jun 2026 01:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=8RUQOsVB2gPX3HHzwP19/jak1iQw5t5zoBGAIbNRz
 Rs=; b=IT3127QClD+AbC8z8roCQ3G3mIDmviy36ObMb+bJzZNb+s/4X6BBFMOtu
 22zmcqTr3oZTEUoycoytzHV3kf9stndYqDv1SqvZZWZT8M3OKAOVGnFGx2UZnvpf
 nOmKpreZS8IzM0R/IudnHFAUiEphWQONoo6LCTaDxaXSu65jOGaBqunPlLlaASO3
 OafjfA8ZxcgvGzoRb6mPRFIgq0GaKyN2JFTZ7wod7hLq6mUSldqbg5uJNTYFAXAe
 moU3LUyHKh3Y0yO20fiMEPtuSWA6KjQE2yXMs6Yh7gISEDOMILZNlJo0hlcYld0+
 0+mDz+7GwV4z10NjzfVcM6wcE0Wyg==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
 by m0380145.ppops.net (PPS) with ESMTPS id 4eyma1r5e0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 01:18:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqqqtmBZVfGNFSr2xuiclYYyPwxFBNmAklp9WiIR+dPVfNIszwtXCtJmuEv4xbvkutGB3bU71ZSfgNX+MWhxz5t2OvG0+/faHZVahPlO5pWWz2NPYCGmVsuRYTYHKYXw35/Bu9+U6f61n2q75BCcfrBWGH4FfemVr+J0tjPdj4OeyGwfIiFisX1gGu13wnQs7/pyVm4/AbI3zIgpc5cwPRzsWcCKmHVfUoh8F4poEAdb0JnhJ28hIs0TD8S9LgJBjpJbgrAT+y+jk1pKjoaNpDBi6JglY031YdHejPcbvfwr9m8XqLHN4b+OEEQ+4v4eTAhTTrgF0RrNG7sOZIWKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RUQOsVB2gPX3HHzwP19/jak1iQw5t5zoBGAIbNRzRs=;
 b=kB4GLuP5mRleOs4LJ6+4oW7aH7+mZDDUlmuK1dDGcoL9Wj2d0gHHBnrn+ttzYLQsYT1FH0UDznR9sKTiQIW6w5FCwQfkB0pGaEP1o9JIPy2mR9pmRhZPR3oh4fMR68eholNak0Qlhn7vLAS7eoCnctLukCUHLEU1TTFT3G5hqw0dCg+5bO+8RxdzIBeeKFUnaXMWs6ap3q4vYSIvZX137WCvIAuv0zTK+fqneNr/fbD6+346tBZz9QhZEyh+pZCByCEyBo206wjs6+D6hoaCxyN/KjR+/B8PCkelUkfBoX64sJSlu+WjMaZm+wFW3bfQ/f7CbwcGpco5BJdUoQibiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RUQOsVB2gPX3HHzwP19/jak1iQw5t5zoBGAIbNRzRs=;
 b=EaM+bP532OmQhgJvRuoeMtykyQBvf87TmH34FCsZq3fhFyMpYvXHE9oT8aTSY0/OoI9OyI5Skca+cBzGFLxFn4v8vgtxhaRBNZNuOmS5ztqJGtfZVzmas8FynTa3ElIR+me0NU7E34EE+/BEYLPFlnMtHZivkgMe4dHfTjqawOo=
Received: from CY5PR16CA0029.namprd16.prod.outlook.com (2603:10b6:930:10::12)
 by IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 06:18:18 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:10:cafe::92) by CY5PR16CA0029.outlook.office365.com
 (2603:10b6:930:10::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 06:18:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 06:18:18 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 01:18:10 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 01:18:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 23 Jun 2026 01:18:09 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65N6I8QX2231403;
 Tue, 23 Jun 2026 01:18:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1 1/4] arm: k3: select tifsstub via
 board_fit_config_name_match
From: Anshul Dalal <anshuld@ti.com>
To: Aristo Chen <aristo.chen@canonical.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Sparsh Kumar <sparsh-kumar@ti.com>, Suhaas Joshi
 <s-joshi@ti.com>, Anshul Dalal <anshuld@ti.com>, Andrew Davis <afd@ti.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Dhruva Gole <d-gole@ti.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>,
 Beleswar Padhi <b-padhi@ti.com>, Moteen Shah <m-shah@ti.com>,
 Chintan Vankar <c-vankar@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Sam Protsenko <semen.protsenko@linaro.org>, "Vishal
 Mahaveer" <vishalm@ti.com>, Peng Fan <peng.fan@nxp.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Andreas Dannenberg <dannenberg@ti.com>,
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
In-Reply-To: <20260528132746.719699-2-aristo.chen@canonical.com>
References: <20260528132746.719699-1-aristo.chen@canonical.com>
 <20260528132746.719699-2-aristo.chen@canonical.com>
Date: Tue, 23 Jun 2026 11:48:05 +0530
Message-ID: <178219548553.1317404.18395162615291306038.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782195486; l=1800;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=PQUI4cZFmtJpxL86xz2UwpmSsIRDhq1m4Rc/twGRHQs=;
 b=k1zUkwrTdTRPzOT8ekHk5N2iTTJo7S5MI2vbZtlth0cZx5ysT8zXwUsCNGDfWPYQFs8gGRT6f
 PPkHUMxpCCRBdFsViHelWS0kkogbtZlcz53g2dUx7jO2fjCOh2BI4jK
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|IA1PR10MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ed2831-0343-49a5-d3ac-08ded0ef3790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|36860700016|82310400026|23010399003|376014|1800799024|6133799003|56012099006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: 46aMBuMCHGEQk/wtL1MYLjaV/qtJWgbDv7XcfZHaml1ap7B98dCYsfd4FaAevtfW2z1+4fAPjbUg0ub52mIIN5F4sEW8+q6yKzrgwte0WEKX0i+x/9tPiTvZ+aJMoaZ3OFFZC8pg5J6ZYupaA7gnnRUhI4C7B9bPzULcjVtdC06STMNNI8PLe4Vx+S/162RPQ+bXZPTMHA0RGTwlQX8PDRgEc9hmRF70BrZwdZakXrwvpqbd+6E/cRbvsasxBxVTRjQYOowBWS6S/cxg+R74cpbdQgtfUfd38A+EdqkwwIJhN4wfqJN2tjTLH0edppNPcmi7E3luVAHncM0Pvjw5HbhiA0QFEQrZ2XCJwSgTv6Ut//PGbGt+zslDym+A9QTmjZaXs7sHk+5nEtvLjQthSLu6LPxyQzriJTqk9lZUV1eDrhHOBMn9lV13AVuxAzoiPKHof9yPgC0kon+81S1zzSrfu+vJohJ7a3nAaHCbnZvMix9zfkAEjcnpyeHHveatYhE6ZqFw7j5GIP67MocYf7GpIQ7Z73HM+Kz75Tvyho3CoJL7pTloxWSUqYwcrV/Aq0RzbHLj6GGEE+fYQtg4g3jQWLTSYoguRwYdtqcO9cdEzCa3obgupkefVMjcmU9sWAZKB23Fsd8h+L6bC5pE1x977QzUXaXXUbg4LaXZV3vFooayAiPdADuxUnT2jmHWopyzehdd+z7IqjAAPsiKxQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(7416014)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(56012099006)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SZmdTDFxlbbGM3pcHklYVsMB1yWO+SbidI1+r0ynCblVbc6TOuC5SsfirI3gmbvXnwyZB8VsiQbq+6tqhNLOnavJ8i209SMZKQishN0bDjOV1nkun3G+fJpAlBCgpE997moKk7A2tuDPpN7nuYjsk1pES5Kk3UUHi/VKlveIoDrrhwQKVpW5VQtop71diVHr8wllJd/NkZNElAcOZR4aJDVNHR5L34ASsBC+Io0BBXWbCShQxL//7t9EcyMeWJ+GYS3359xFCcKxQgoMYKdpVEFQdqw2t04vDXg6Sl6g3tQZ8tEKjF1H3siV03z8abF9V00tlsaAmBe04DziwnR3Nivi41OIGIe0D2r4Ej1XypHS4yVAU8DJoio+9NSiplUijUGpTMvlfGGGiwhUBtaqQK+Q8NPgcqag7cSxSMuTfryy0FEpmZ5S0RZImuuiwYXk
X-Exchange-RoutingPolicyChecked: rw/AqTVD9uq3jZkPjdboJDhVM9aFHhHJLrX7pVJ9x+xpDYuzhxi4KQ6B0ttQFRyrFLZ/cZNimubI67yIRs0fykXtxfsM9sSrlund9nBECPXoIjshp7Xrkhtlhwarj1bXhUY2RzcunNmIrdLjawYMn9XFvbHXPDso8WU9wUdY7VoI9CPO8RRSLwe/5SndEmqFvOzfW1dQdgOO2QoQ6j0snDtCI6Mv5HNbljBodox2FuzfLOVz6VdyEqErZ7c8x09f8KALhmm4EXA+dqc2shN9taU6sgNpTxGMZnlUxxEyjtXYxeeTfXluFVHOWWBJIHTcy6K3gWji5Rxp/umkjB8ssA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 06:18:18.0379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ed2831-0343-49a5-d3ac-08ded0ef3790
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7240
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA0OCBTYWx0ZWRfX+8EHag5U19Ic
 cf4ZpyoqqpN1F1Q3SGcys92Qhkg4gcs2KhVkPD/rx/81h7X3LIG4mRuYHZFLH0JtF1zw/w+Pu3g
 D4fhm1vpXdKeIsuAkcbpxixiOtxEXBQ=
X-Proofpoint-ORIG-GUID: 9oVMbQCAgiOdQ2zgYzK4X8J0fi2kLsTM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA0OCBTYWx0ZWRfX+B1kUf7Vs7fp
 3T4COHe8cxhGiNJZISrd1k//qSbOnpoHk5I5Pi4UITRiDeyg+7Sb3FDwXuVDoG9rNqC82osPHTa
 xPkhXG4A3tnLbhnwjYJ2+MNzThWsHbQIBmctJwEmt+CYq01QC9cVivE4wqP73kzO4UjZlVK85cK
 1E3amfX4IEFe7bAuEOsY9jLfbgPPo2ZOlPh34CK6B39dAFFlwTZZ+FhU50DaWOODFLOX4LTtrz3
 hKLRUb4tjGoxm/lo9/TLr/USqebfDUFQ8r5eVz5aVDWwjInzHWka/n60HYNUmH1fmgc/Ji5Mq7y
 /fPyzFRsBca8Tv0BkYLord1V7YqgqP4GR1IELSqUiv0oenh/J/vRKVmt7EkYywyI1U7kZ6iNcdF
 kk1q13m7ytEq74XBVQ67sxJqZ0uSTGzh/IGZL5f13uTocIrASOyVEGXTxvYs5hRLDr0PwKG1BLW
 xuOwTEN7UcAvRdeoSyg==
X-Proofpoint-GUID: 9oVMbQCAgiOdQ2zgYzK4X8J0fi2kLsTM
X-Authority-Analysis: v=2.4 cv=WoYb99fv c=1 sm=1 tr=0 ts=6a3a252d cx=c_pps
 a=mfnpAPd2LV9TTO/yo6PAYA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=DfNHnWVPAAAA:8
 a=sozttTNsAAAA:8 a=hcHMgpc67UcRFyhE_9YA:9 a=QEXdDO2ut3YA:10
 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230048
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Thu, 28 May 2026 13:27:10 +0000, Aristo Chen <aristo.chen@canonical.com> wrote:
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 19a6e24f38b..f4c6c4f098e 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -191,6 +191,33 @@ enum k3_device_type get_device_type(void)
> [ ... skip 22 lines ... ]
> +	name_len = strlen(name);
> +	suffix_len = strlen(suffix);
> +	if (name_len < suffix_len)
> +		return -EINVAL;
> +
> +	return strcmp(name + name_len - suffix_len, suffix) ? -EINVAL : 0;

Since we already know suffix_len, a strncmp might be better here. Also the
ternary is redundant since -EINVAL would still mean the 'invalid' configuration
is selected.

>
> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
> index 466ad22f895..37ff98d8992 100644
> --- a/arch/arm/mach-k3/common.h
> +++ b/arch/arm/mach-k3/common.h
> @@ -55,7 +46,6 @@ const struct k3_speed_grade_map *k3_get_speed_grade_map(void);
>  void k3_fix_rproc_clock(const char *path);
>  void mmr_unlock(uintptr_t base, u32 partition);
>  bool is_rom_loaded_sysfw(struct rom_extended_boot_data *data);
> -enum k3_device_type get_device_type(void);

Why the move of this function from common.h to hardware.h? This header should be
accessible to all of K3 anyways.

>
> diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
> index 49e58ad6d6c..59201f8d2ca 100644
> --- a/board/ti/am62x/evm.c
> +++ b/board/ti/am62x/evm.c
> @@ -135,6 +136,13 @@ int board_late_init(void)
>  }
>  #endif
>  
> +#if defined(CONFIG_SPL_LOAD_FIT)

There's no need for the #if guard here, SPL_LOAD_FIT is enabled for all ARCH_K3
and if disabled LTO will optimize out the function anyways at build time.

-- 
Anshul Dalal <anshuld@ti.com>

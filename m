Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA260CD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 07:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22F5D8495C;
	Thu, 18 Jun 2026 09:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SecizFe2";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gTpF7VVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD23084995; Thu, 18 Jun 2026 09:32:21 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B51578460E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 09:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65I6wmOv2383669;
 Thu, 18 Jun 2026 02:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=5c8ZYbnwpyVrfJya+pLwa7l+jgD4miKaJ6tL0dkkL
 zU=; b=SecizFe2h6tD1TqgoyvgQXxXd7QoB0CTG693wKfa8pGOa8WVTylFyh6ZV
 4OeSNI/mdHo1lQW1NJ1Q4H9rRkVACWfASTkgbKkq6uhfEE0GTmad/SYugVKGP+7N
 dtoF8iyqjM733y7HiNdgUn57Yg8LM0rfTkJ866WeQM2DGDxFpKw5lyc0r1Bpe4sU
 oBMwo0VQoYhZb/Z4Ya6hXjiG8ReOyw1tTq2FsrEN0XQGUQ6tJj3p5bLGQiyxEKLU
 lpl/51iAYcEl1PFc5ItjQLJ7tGyT5FlFOi0u0PxD1rhLohQ825XFO1gJ9tEVzXe4
 mGK9KV7ecnn8oE3fU5i2KE15FFYqg==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
 by m0380145.ppops.net (PPS) with ESMTPS id 4euthp6r7h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 02:32:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yg8shcJDkuAS8hI0nCe2rLO7OnLlx+CRPiWgyRmP4C7+suxlQqUThVf5bHuo6gy9zsWiB05e0RXHyjmzMGl/W6G132P5fkyhkE1PuIW9rKenonvIklfwLzCFSjbTNQnzI6NyBIbS8ofoxgEe14Av8zljnfVFyp6sUQMCifBlVgjHqsu4BB+RJW/ZjxVnZ2YSY/qUiuge2Fi73utljKWG2udJWIzi6PG0sDLK05cML1bCYSS1WGiONTc+HNYoPPZilnlN21P5Fb0p8ngK8DV+pfd4PvnKQhSloVRvLtr0TIUZsezSFZNo6H5GKkrybJRXD9hViJ2D9u99IcRzMdZ8fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5c8ZYbnwpyVrfJya+pLwa7l+jgD4miKaJ6tL0dkkLzU=;
 b=eRXnxVL4v25tPirXSkyRRnu7nLMI/lyMMn/nCZbCK4dm0MrOdPNYil1vkhnHaFWh/dPHeuCD4JmXz0UXgS/IKhXDYB/Jqltff1PDZr1FOkZM0aVO5Nbaqhj3SQUQzlhRQrH50KjhsQIw0k4OTg1F4BNYQfbMxu4td433cC7T40+wnpJalpv1jR/HTMzNhajo1hVAJGkzdRLQeWVgM7lkK/8KHfWXYnPPYR3plqvkQyZ5PCuMWHEZ8TulCqfGQv3E7aLzqkakOU880ar5eV2I5aHbTNfWP0kVnQ/qDNXq8Bm+7Vd1nfUpZGWQYlkBNXSfDbszQjzW/Lm0YqMX96FBlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=baylibre.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5c8ZYbnwpyVrfJya+pLwa7l+jgD4miKaJ6tL0dkkLzU=;
 b=gTpF7VVDmQbjWH5Fy6v/p+2ZD6U8HGaZRlf27xVOmcwpuBFkK/iwbAlPBeiGPIpdEyeSlUmkuQdt0ijgbjAq+BP0WbgHK2OoImxQB9ARXSuFl1c+Cg3XPuehq1igMEF23iV0locfWtXlibSgr2W2UmwvHFLDBq1xgNAMvTYiBI0=
Received: from DS7PR03CA0262.namprd03.prod.outlook.com (2603:10b6:5:3b3::27)
 by CH0PR10MB5209.namprd10.prod.outlook.com (2603:10b6:610:da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 07:32:00 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::a8) by DS7PR03CA0262.outlook.office365.com
 (2603:10b6:5:3b3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 07:32:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 07:32:00 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:31:59 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:31:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 02:31:59 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65I7Vb2e3513641;
 Thu, 18 Jun 2026 02:31:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1 1/4] arm: k3: select tifsstub via
 board_fit_config_name_match
From: Neha Malcom Francis <n-francis@ti.com>
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
Date: Thu, 18 Jun 2026 13:01:29 +0530
Message-ID: <178176788965.2536492.12578943539343378556.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781767897; l=667;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=asbtvATRBqhE9XX2F6QbczOoLV11t9c6Kf5rj8kqKRM=;
 b=toY7YHZRVS+Wrfeb5tggqzKNEo6PzKoeKgDCtn6gO8LPpk3CA2U7sREHW70jqNqcCzVIMWzKj
 h5K677cW8MHBKvqULEUBNRV5XmNf3nTOfKF8RZ30UYZNayipmxEb6Wg
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|CH0PR10MB5209:EE_
X-MS-Office365-Filtering-Correlation-Id: a47f757c-be4a-48bc-469e-08decd0baf48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|7416014|36860700016|6133799003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ww6yjvWmobHGnEd6m4tIw0Pl6oFeLeX8EokxLbNwxrt45/kMZo7i6oRNnclQx9ZwrOyc/0gFftFAeCWKFl/971+rn7+SevBLVtF6DRqzHiGOua9m7it062wj6Fc9I2nJibC/hblwJ2gRSkGBcWy0//kZV1jdbU9ZlfGXpxIXRzmMBqX7CYZ4v5y+b4Z4IhTw/I0iZknk0p/rsNj8NtUwVMp4Uo9mf9RjYxegQu21gXCpNHZKPhrK1Mb6gsG5bw8DeMKcwagj8Nwwf2ew0GczDVNad8A7Z2nfchHwOnwnHQX0nARiybUo55sow8vBSiTMnkmHBDXuxFMvgFGzioyOAFLerG+/0QULfx+STHTIls9i59WdxXaNFk4MtQvRpI9m4ET12k7lMo1LD/L8n6u1l/21HVOUVwuJoqMi9VXQYnPDz86Rhj4LRx9vhOGZqe8ifE4LzgemGxpHQG5JNy+NZnQW71CwfksXJeS7XYbyJ12FSf3+4BB3c/vthDrYx0dxVbLfHzOgNIjGk5xl0p7zCPrUEvMfi6ss9Uog7JdszgJuU+RhSyxdFdUqG62JgrA3b9vRk1SWgrY/yd3Mk7Rg5/1VBS6g+ggNxZgLIJRtimAim7fsnrsUzCTzeLPMvObsTFiJP6iDf24L+QCnosSFuCuF1MuO/+SVg/DBDu2DqVyJdB512ne9zCqsF4TE0cNaZKToLASOZIhRxnLfx76gtj/TeGvh+/3PEXVal1rmFdg=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(7416014)(36860700016)(6133799003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DjaCh2zy5PAgEAqRJkpRudnF/CNE9wyF0fCkaVNOtTRDGh5JjW9tyxQXWuP+aALrZITc4XkZtaDvNHAV8aHiZd3AsZ2rTbWVe2NXh9et8ySR3ePeAAQ5aQLi5uhwEqlAWYqA0oH+B+zuEn0BalA5XI39mTscrIr+wFC2GXi3+Mg0txDsB91CHB7XlYa01VTRHFqvxn3GrS4uVqOoU+8NPCYovcPL+26e7fz+vQ7hEcyNIyDhaQMfGw3+QShJlR6q1Z/C1sWrI5RJ/4sENBB5hCg1/ljkPGa2DaWNHesLraLPfocwkAoTw3q7RauoftuAdjEj8xb8hsQXN0d4n52e0pT8EVTN45v//Xlof9/W9RifF+KtkXIUz7tAwcUGXOZPxmYYFNaLkPih1tVIYfEE5uFRLRQtDzLQomCV0ASbIMzzXwI8AJ+/a7PbrgTxNhOc
X-Exchange-RoutingPolicyChecked: rDXhrkF6RqEk0MP5Eqmnf/wp70Q9Py/KAF+aDjLyhlbi4dfphPeAOmK9taKG640Mrswdp9sLCWFKDMqoFl1WgppioerWW4fLTfclCyAIypMIZ1gkBHqO0bVUA3hIyk9Tr7sPaq95N4zmCAKQdCy4wrktGSVvjUGUZy8s8GQZh6srrF83TLQ2QgDvdOE8JX3RrRSbTT4Z/5kHOB4bVSqrdxGHVqO2llPaZQSylN3ooTQvzvV/D1B2mdls7q5OcXJEIUqz/McaI272LBZrjuDqn4TCJ9TVIOC6ZGJM0auVVr9fEGvos3abL+9WUO11IXi21v6Yc70lbXXBI3T18kXSgg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:32:00.1296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a47f757c-be4a-48bc-469e-08decd0baf48
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5209
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2NyBTYWx0ZWRfX3D8o7c8dG+oN
 uWYsxORhWR7cXHIHtksYSnplwcQVxVWGn8ek4HNsIibXK/2CqOINrh8jCvxCv3XXgPEY8XAQwbh
 VzqCb3shJZi8P9lr9c5SlaRciWD7aGo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2NyBTYWx0ZWRfX5ctkjn5LZz7W
 ayuEp664o+vKK22FQGunqkWVnlNyQ1aGmXaU4F4VpPCadYlJ8UY9NegYzSRoXC+uzlwHSrClQPx
 KI1HO6i2g0lswiiNVXQwUsTsPXPODOewn+NMWIFd/s61EelHURCawwkQ8Rq2klAdNdfOkj9/uFA
 0vM4W8FPnDJ0Z80HaNw2jrpUH+12gcT8TcmLY89v3RdhWUk/BjgV2noyJ+Mp2Fv8mF4/Ch5FPjo
 SDT/3Zta4vdMVgiZAd86oB61Y12LdtXWNinAXX7jXITFaOVlKkSHvSZiS9qt2T4mi1UJyTjTM9g
 ldsUdFhkC8EkPtdBuERZgLHXvRkX7eT9Q2vbScxpRZG5ivsigOD+dZTUKnNpoSoD46TKV7KHMio
 skyxi2SsiT4UVINPdG4qhXCTJTaSnBiv0lGcitIc53k7kEE3N35f9Csfrr1DlOzG6+beruN83FE
 WHXD2DXNn/uXjQXMKeg==
X-Authority-Analysis: v=2.4 cv=N/wZ0W9B c=1 sm=1 tr=0 ts=6a339ef2 cx=c_pps
 a=G7eB82wliUXyOHlZhtkITg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=DfNHnWVPAAAA:8
 a=sozttTNsAAAA:8 a=ciE8ZmZkHTmXOzaml3oA:9 a=QEXdDO2ut3YA:10
 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-ORIG-GUID: kxARnAnCYHc0HTM1xTTc04cZlVTKDtyo
X-Proofpoint-GUID: kxARnAnCYHc0HTM1xTTc04cZlVTKDtyo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 impostorscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180067
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
> TI K3 AM62x/AM62Ax/AM62Px boards carry two or three mutually-exclusive
> tifsstub variants in their tispl.bin FIT images, all at the same load
> address. The existing approach loads every variant and then discards
> the wrong ones at runtime via a *p_size = 0 hack in
> board_fit_image_post_process(). Switch to selecting the appropriate
> FIT configuration up front via board_fit_config_name_match() so only
> the correct tifsstub is loaded in the first place.
> 
> [...]

Acked-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>

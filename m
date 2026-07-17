Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13A3C4451C
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 15:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82D56848BA;
	Sat, 18 Jul 2026 17:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZcN43PJq";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qiyOC8wY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F12EB8467B; Sat, 18 Jul 2026 01:24:00 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5B1E80517
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 01:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66HNFgoV2064427;
 Fri, 17 Jul 2026 18:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=x1lFsfz8zQN7cKaHBSrh9KZXqbk3wchHPVEdNenUw
 7U=; b=ZcN43PJqmyMyt2nlEMZaSXP8hUY2Y8j2Dh/b58OYUIsyUBm/wUmpfo3uY
 4G6sSxjgIMyYmUIPGE8T0L9jkmVpdLwWmejfCDUa1wKPFFjKCTNF92mM55m9vGd7
 +DgxR/icg/raGvtvS6zVBc0N9C5o/q1pL6FCl36+UZmHN7plu+TduZPza1DpqpEq
 1/PNB/CrgznhsgeB6lpNrSv3zYGRHj2VIO0i+kuJHVbd17QYTzbFZqgAxtKMod4C
 sDJz1E3hkTDEHnNHArYnQ5qJ6tb+UegD78UsICBymTlLgb4Zk8WcEOzYJkG+P43E
 5WdVTX8YujSHKTdwSmk1VnwJTYvFg==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
 by m0384305.ppops.net (PPS) with ESMTPS id 4ffgsmcspr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 18:23:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eb8MUOJmoGXNeW3EFqB+MGfx9gv5F7Ez6mLrafsf/uuD2o3yZubML2UFSFwwS1GrrTo8uIkjyo3Zdx6IkM3v53zsA1ITSFiv69JnFN1Oo/YdsELvCXyUYrVsD6gvGkxglQaBSt1hRfhcHwOaaPKVhreDUkxGbdyXTxezc/DW1PVVxGZKV5zu5XWPuiHjm3ZgSlTIXXa+TfDFV5H5W5CtsTWFyD0ln0MaozwuX9lNFyDlr7sGDKzC59byBhKfCUFhqF/lzoocbfExsK+m05zFYaUY9ebcLypVKLoGOOqU+NLP2+1Jk7oq3xfy83z5vPgzUyFKqu/Axf5qwJt7riRQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1lFsfz8zQN7cKaHBSrh9KZXqbk3wchHPVEdNenUw7U=;
 b=D2YzDpDRiQnLtEuNMNEVBsFeQC7PpGUqqNb1cPLSs9zdYH6KifySC1B3ckL9ijcSeraPXiX6/OrR+i2D1W09XEfgY7mnoCPB+upl1hs+a0M/nlAORTzn1lEhHkrhEg8PvUu4lvqhN97if7ICP1czLadpaJ+122Hs0BkdeylpsqIRNHpVmFXCHolxEFtL48QJm3/Kh3wOU1dQOlilTw08cvJbCBp60k1zxbApkiCIZbVbs4SQ9F9do0loAOzJEc2GL41/9p1F2B5x/mh775bSRaXYrJQoYz9dBCL2MUWK6WFxB9p87J1NhgbgXqa5VH64ata6StpuG2h2L9ncRHe/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1lFsfz8zQN7cKaHBSrh9KZXqbk3wchHPVEdNenUw7U=;
 b=qiyOC8wYByKcO6wOjH6t4vLyRyu86fRmQTZbth81vSAJA/P1ND17H1RL7cQxWAQnDUfOW1Fx2iH4tcwDuuicQHCdtqAeNGPTVafHgFNnOVwX7jw0371BHlqojhQ/AyE0P1bDOufj+tarZeq3RfDKbF7ISYltx9tGi6booCJUmFE=
Received: from MN0PR04CA0016.namprd04.prod.outlook.com (2603:10b6:208:52d::8)
 by SA2PR10MB4556.namprd10.prod.outlook.com (2603:10b6:806:119::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 23:23:35 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::ad) by MN0PR04CA0016.outlook.office365.com
 (2603:10b6:208:52d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 23:23:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 23:23:34 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:34 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 18:23:34 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HNNYwr745814;
 Fri, 17 Jul 2026 18:23:34 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 17 Jul 2026 18:23:38 -0500
Subject: [PATCH 08/11] configs: am62lx_evm: add initial defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260717-am62lx-v1-8-b9830633afb8@ti.com>
References: <20260717-am62lx-v1-0-b9830633afb8@ti.com>
In-Reply-To: <20260717-am62lx-v1-0-b9830633afb8@ti.com>
To: <u-boot@lists.denx.de>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SA2PR10MB4556:EE_
X-MS-Office365-Filtering-Correlation-Id: b39c8c33-19b1-4b7a-7c5e-08dee45a6c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|7416014|376014|22082099003|18002099003|56012099006|3023799007|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: ZX6wNAB4V5xV0IZ2w+ne49Rz2xIP0y4HwaCiSSjB46BsEyxNom532j62EpzPe7FiOEl+ugrpkftcVbCejWLzFuxf8uIiqME4VKxc+oKUF67m9aqBTOfcozuTrj0SfDjeKOPt+HNy0Nj1+TnfPjT8wJlKQWYNeMnkFoGgw0B2AzG+9ZgiULLRSKIwQ6ArBNUkHWpk7PGIWn4hibHwyd5+blU8f2GQffpUw6PZvjHhpb4JRV1Pfruwm7tYyS23NHzMQ/i7e5RJbglIohyjLYKFbbadfUb9eZjzBesJUDlN4gQwU4cC7PAwuwr9klBrqtshM5S0q3HG44q/rtgNMBa645o16lDZtGqyKKkqP1b3hMl6wkssgjVuPNWiQKlqqrlItLECIfQUVRvi4Cvq6MleA+4I7z2vrW2LulxP+JbcV29Kw7y0wIbUwynH55QujV9QL5piXvcw190mL7bGjdi+44eCshhA2EGZi6Bm87uvnkI9SR+deBQfjxIqKqKLMG0SQ1xVym8mXbOORHA6pRuMn8qlnEgjj9q16IrpGFOxgNSzQQVhDLdi0myTjtXa+4iaHmZ6h8YlpQBAg1lh70aTB4Q15HfZe7GnAkuFU4IDGIgE4L+INpWI+Bb9lqx/CgqMEnZoYIVTuquJyo8D1EBFuEtnbOV4ReQbaj+jU911G3Q/qrXkHKXLXp1w5NHh4sVn4wPW/UWAdcmh1NhVOPLAjw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(7416014)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1k4QFeAraA6iq6q4+aJ+c0GzRk3dqVyZ0IKZXEN2DLxEyJyx6t2dqvuhjYKHU4iKMxZaF4pvxkrKVAYH5mra5KJD4K+4OTL28sZ2zT+nCmWiAYoOWTubi104JEx8+ulV/DzbrtknKhJMd0uQ99Fvr8TMrTozVEopxHsscrOgf4cgk/XTnzloEUnArElkKNGycs4aDNNyA9itWwr2+517FCP4uiWLhAkWBx2nft2G7gJFFL6Turtms+MO1W1hvYTKsBm2Cb9O/i3GnTwxM0MnNKSQrxGhycm5LzUDVk5g4T/ZAvahOee4r702jFVKE/Ffi3A2bqW3NYu6SxbVqPV1xa4NYmmHaX7Gcr32i+vHC6MYZp/9I4w/beVOKCqEc1+8NBf8KkKGIX5kRzfs7h0sI1LSoTWbPjI1hW8tOLDk0KG29oBvjBDfY+rjRI60ndq2
X-Exchange-RoutingPolicyChecked: FRnGjDDvHWJHipFydKi4iPbKQsLvxA9KpHoGoCVURU19bneDsZZhV0raJItiSozfdgHILsJCaF0r2wCKNnyjOF3Ql5ZJ0DPdByX0Z2BKPMNlqVwhdhMIlB2x6V0xzbcQKM3ZDQZ/auKnoKpSerhN6bQQt+wcT61ipNQE3K/taxUPqhK9p0a0HwXd8z5XYQEbQlXw3CLmxpJEgRBPZ7MK5DBuj/wn8DwdzLZR2mZu7TkGl+6K1DH0bXX8WAJm36IKZ6ZcMF3jBRXEpvQGYyVA3u4s0Stzp7/OeZDIJn1Mq91P1tPcPgwyQyn8ejA/GqBKixwhwngUTHaEQaaFMQtrsQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 23:23:34.9319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b39c8c33-19b1-4b7a-7c5e-08dee45a6c6e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4556
X-Proofpoint-GUID: lEKllzI-OAExX_8hAF6MwkWWRMgGIrP8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfXyFUt06bpIhAk
 SO1t34yTE1Qwnsf2ygvBKVnrwVWIuonPNR7uOP5dX6rbkeF4aUt9iJDoyTRSZmeDCMhxxkTBpWE
 ORxCq3viy5kVuXG2nYtFgY//OAfxiebNOV2r0hLMEzzgFsoYLuJ2N69JSF85xfdTUCV1tlCX/km
 D6o6u3kBgKe57waY15r53d/PCvY2YUwBGR/RFP23TPcamNZwZ0pwjJd8FNwA6vMUEyEitIEtdrj
 ZUMhz+cj3DiCFkc/K7qhrgfHQ1dLMeuMMK6qd3A1xzc5xGzqG4dRuWd32FqdZ5ocswdPnlLGTqI
 rMtLlaer0pL2ie1qtHFBjr2tdeY2t0N9Qm8slilnJLVym1tZs6I5x7Y1aYtJ+LQqyNWGFPk3wsC
 ALRMJO8f3PP4Z3OghIE5RJi673Mv4f26jZ9gL6mvc3A2whl7M9USS3w4Bw89SyTsRC51eUhnZSo
 ucBGNfC6kblnpz2iD7w==
X-Authority-Analysis: v=2.4 cv=GJ841ONK c=1 sm=1 tr=0 ts=6a5ab97b cx=c_pps
 a=sh1HRyDNv5RGx04/W1QObA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=mgJN0jjOy1CJ0z1pLmQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lEKllzI-OAExX_8hAF6MwkWWRMgGIrP8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfXxhCuf4QQDIeB
 RE1Y/x/9x+2tIBxa0asn1szXJ8mQPeYnpe/E/zv0BZ9Mu7dhvMxMUowSx76j+3uR6wno09wbhcS
 g9oT64yAOmEkBzxD9zJqxUkH1tcGXpk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170241
X-Mailman-Approved-At: Sat, 18 Jul 2026 17:03:16 +0200
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

Add the initial minimum configuration needed to boot the AM62L3-SK
reference boards.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 configs/am62lx_evm_defconfig | 148 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/configs/am62lx_evm_defconfig b/configs/am62lx_evm_defconfig
new file mode 100644
index 000000000000..d8e708f02347
--- /dev/null
+++ b/configs/am62lx_evm_defconfig
@@ -0,0 +1,148 @@
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_TEXT_BASE=0x84000000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_TI_COMMON_CMD_OPTIONS=y
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SOC_K3_AM62L3=y
+CONFIG_TARGET_AM62L3_EVM=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82b80000
+CONFIG_SF_DEFAULT_SPEED=25000000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62l3-evm"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK_R_ADDR=0x85000000
+CONFIG_SPL_TEXT_BASE=0x82000000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x82c80000
+CONFIG_SPL_BSS_MAX_SIZE=0x80000
+CONFIG_SPL_STACK_R=y
+CONFIG_SYS_BOOTM_LEN=0x800000
+CONFIG_SYS_LOAD_ADDR=0x84000000
+CONFIG_SPL_SIZE_LIMIT=0x50000
+CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
+CONFIG_SPL_FS_FAT=y
+CONFIG_SPL_LIBDISK_SUPPORT=y
+# CONFIG_PSCI_RESET is not set
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_EFI_SET_TIME=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x83000000
+CONFIG_FIT_SIGNATURE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_CRYPTO=y
+CONFIG_SPL_HASH=y
+CONFIG_RSA=y
+CONFIG_SPL_RSA=y
+CONFIG_SPL_RSA_VERIFY=y
+CONFIG_RSA_SOFTWARE_EXP=y
+CONFIG_SPL_OF_REAL=y
+CONFIG_BOOTSTD_FULL=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_SPL_MAX_SIZE=0x58000
+CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
+# CONFIG_SPL_BINMAN_SYMBOLS is not set
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_YMODEM_SUPPORT=y
+CONFIG_CMD_BOOTEFI_SELFTEST=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_DEVICE_REMOVE=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
+CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
+CONFIG_DMA_CHANNELS=y
+CONFIG_TI_K3_NAVSS_UDMA=y
+# CONFIG_SCMI_AGENT_OPTEE is not set
+CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_DA8XX_GPIO=y
+CONFIG_DM_PCA953X=y
+CONFIG_SPL_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_OMAP24XX=y
+CONFIG_DM_MAILBOX=y
+CONFIG_K3_SEC_PROXY=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_SPL_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_SPL_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_AM654=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_S28HX_T=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_TI_AM65_CPSW_NUSS=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_PHY_FIXED=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_SINGLE=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
+CONFIG_DM_SERIAL=y
+CONFIG_SOC_DEVICE=y
+CONFIG_SOC_DEVICE_TI_K3=y
+CONFIG_SOC_TI=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_CADENCE_QSPI=y
+CONFIG_SYSRESET=y
+CONFIG_SPL_SYSRESET=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_AM62=y
+CONFIG_USB_DWC3_AM62=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0451
+CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_SPL_DFU=y
+CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+# CONFIG_TOOLS_MKEFICAPSULE is not set

-- 
2.54.0


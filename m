Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2BFC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 11:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DDE780B96;
	Tue,  4 Aug 2026 11:57:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iBGX9jslXMdQ; Tue,  4 Aug 2026 11:57:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 92D9E80BCE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785844628;
	bh=tRpTJBw/k8ApN7a3oO9tGhfxISR2MwtJ4aI8/Tb1bVM=;
	h=Date:CC:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w23F3xPpDpui5Z9m85aE4/Qb0AjM6CPX0tvE6ckqlkutNpMyJUhR9COmwRf2a0gFi
	 Ss4hkiazLhIhXMlA1O4baHDXXfxjTv4MjArFQ3gTslvHedJciprVeP1KSa+BZrF2aY
	 1D4hxGhf85QdXCoyL0/nGZJFYoReTCUv80EQ0a86yYWn5Dlp74ok4wCD0Cq4wMpOeJ
	 caCMsdCTI8wukpHskCiA1rzYZ3O+KlbHl64l1ruE1OrcYQJqMYILzKDrL1MUwCubLF
	 7hsULtujtctkDe6BukpRgtEsO9PcMbRxR+PPGM+G+aYI4PiP5Q7FjoP/3etWjfj3PO
	 TmdGJt16iEgPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92D9E80BCE;
	Tue,  4 Aug 2026 11:57:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AF2232E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 11:57:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5BDA380BCE
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 11:57:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y_ZWXvPukOP2 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 11:57:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 40D7480B96
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 40D7480B96
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 40D7480B96
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 11:57:04 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674BbAFI2364219; Tue, 4 Aug 2026 06:56:58 -0500
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012066.outbound.protection.outlook.com
 [40.107.200.66])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fufc6r3yc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 06:56:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJueNY2oCnYO39YoyANNFfNtQg+3oFG3nQ+Yo9evn1qWWQ1kxtetFG60t0n4PujiyKiE7rnNA1qRoC6NHK5dugDsGxC+uW4ct8sMZ2v1bqjUBlmNsZYk79n0ZdWzAc2reULFXfsuSp0Sp2/dxOq+89/rqRyD4BoEpReuCjZZkbFg/FpbOuGLuOE0SVdX/Vgvw4eptOEasix4cejVuVGEQZ7HBT4IvlEBScmyXmCmJkVMd+5fUoJB31asiPC5eLrIWyyLqPzNae4PPKtmLZLpebMEJSeo+8BBDTmOvhsG5GGAUSPmTWtqAePEPjgRXv9f6VbVUCi2Vr9DIHU8CagyBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRpTJBw/k8ApN7a3oO9tGhfxISR2MwtJ4aI8/Tb1bVM=;
 b=EVFrS/sIzJEma/t7lLnj8Zbacp7/bKamRSRSOjBgfCCWLflzNI+kKuQuAmxCY26y2EmXORtQXuLfEiRTbu7A6L0UbMaFvaItH1GhZ35XdqwiN/zZnW+v6rxO+U6AHy8/WMwQkceZLUmhO0Suu4pko6Dftw3mz6sHrDHJygoe4jtZyXKuw5e0XBe+MZDQGLoKZMlCZwrfPVHuFJsPxY8hodyd/G3DW0RK8E+Fs/ErfctdDTgGAffwqFw3mb7FTd8MGB9EQvcMu4XVN2m6Fzd/ZyouWOMB0a17GtYkb133De3UWi6/jZL8t32NjE10GcjJofaG1R1YMQM+OtmR0PJg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=mailbox.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from SJ0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::29)
 by IA0PR10MB6891.namprd10.prod.outlook.com (2603:10b6:208:431::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 11:56:51 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::1) by SJ0P220CA0006.outlook.office365.com
 (2603:10b6:a03:41b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Tue, 4
 Aug 2026 11:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 11:56:51 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 06:56:49 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 06:56:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 4 Aug 2026 06:56:49 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 674Bulj73629833;
 Tue, 4 Aug 2026 06:56:47 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 4 Aug 2026 17:26:46 +0530
Message-ID: <DKG52UI5DO80.3C8DJ6SO0PCJ@ti.com>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, "Dan
 Carpenter" <dan.carpenter@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, "Simon Glass" <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, Aristo Chen
 <aristo.chen@canonical.com>, Udit Kumar <u-kumar1@ti.com>, Andrew Davis
 <afd@ti.com>, Daniel Golle <daniel@makrotopia.org>, Johan Jonker
 <jbx6244@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Chintan Vankar <c-vankar@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
Subject: Re: [PATCH v3 08/11] configs: am62lx_evm: add initial defconfig
From: Anshul Dalal <anshuld@ti.com>
To: Bryan Brattlof <bb@ti.com>, <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
 <20260803-am62lx-v3-8-b4f4302b09b4@ti.com>
In-Reply-To: <20260803-am62lx-v3-8-b4f4302b09b4@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|IA0PR10MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 16db5a54-c99b-49e9-e0ce-08def21f7892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|7416014|376014|23010399003|1800799024|56012099006|10067099003|4143699003|6133799003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: +5BI8yQE1Azxsi4CmTE6vYNVT5psWITSSNEukl65xsd0vYE5auQ8etp1E7w26J6tw+vKqBydBZJP5SuAZHIvyNiV8+wD26i0YHcQWNB1T+Idr5G11iE+Naik8cMe+ppN5Y4WCT9skzxaIjWuGJ2OcUxKCHPmIC2Ca5Y8D7XDvJl6IzIJAEoiKiV4izM9UTSL9/TW8yHgMD7GVd8PbFtKjv/TLFFqSDvUYQm58/tb3DyLngRASePGutc/aTfZlIFZbl75s9KkVt0ac/BdnsfwQx47EgBBQhArK7a6rEAjxpEriTZN79nMlu3YCH2Vzw9yglanIE0AP/Xz5cgfmR0hYTFMkMRv3BKFN7FI0hDkpRmirsc8278IkQgt0x6vC0VNzJnUOAT6rwtXFvWEAG+FBTMei3p08uJBBJXko4ZHi5eAR0kYz1gxLSKEqyRvDiZhM9lpkvy0Wj4HhEQMX6tv6HacgwaQPkrisk6A41FvGlfYNkuTPmj4Srra/EUcQRHnXyA1kPEDkC17lI7ex5cEDgNIxOUDBt1HtM69jaRLwCoOzn3pDsq4cMlovTeY77+Zm6zK7mCjKXpwrD5JyGyJaJEEw3PeSEExeDGRUO1sMbgjCz4lyM/4MtR1vvGXexRrZsyThPsD5nrJQUpNBrsFoa4LzoxKuXBGsVL+9P0W5aaQmJiTHFMcUPfOZCUBj9QXVkBYTHkauKd2uaeYGChpoQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(4143699003)(6133799003)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zSmpRNdjnLOHHFRAVJHG1z6wIyfDSPahPaLSB4D5VE/Rv0KAeDI9lnMmZLLsQuQgR9H/JR4cItHZkjbFq8fkEzLRLL5c7qUch/QCmI97he4eV1KVCGakkphJZgVnJ+qNjpY841SwKmgpDaagFenbWrNNzeRJZM9NraJ8UfFddfkpsBzj3ZG6lInmjV5jSCjKkuX8Tui6ua+b7ELW33TAZ4gMbAvacY+iZ+Q7eJCPLeFhpNhWdF8CFlif8RhSwjxNRPQ4x7FWHS8tr9i62YXplrm91IyCIXVJ5Lzr1bnbQqSD7jAKNGq6WyZVcYHDhxcQEGU9L58CJWcP7s6VgHyJztBoHDdVMuMX+JIiTeAGd8RlsbbLvFP7OJW5wDN+WxjWXraK3V78PsqWvkvW9yMuq/LzG70ePcLz/iAkKDzwcQRxny+VGQ2GITzJiGN7QUWu
X-Exchange-RoutingPolicyChecked: KtWXwmlU1Ja5CMzAdigfJi07uB6GjzpCfOzJiJlfMgioIiadeC0qSdMJoAPLFBd7VVqhsynXUyiK7T5/kO/loXNYfJ5gbgU2Km99mqLmAUdrzfn+T/uEOJhbSc1ClOo0Abf2TiH8rbhOYlQkZhrPEK2UYHbw0QQfoLD5OA077bz0F716wAcI5EMFKX3lZ4FNVi68UlQSVqK0MU2Kknt6bkXh4H/xjSyaaAJWWo5OHyd/tYF+cfEE11Cl0C4ivrAhfRULplwQuec9ncSvuYMZHdhBXHiWoqOeSjDsPUVaxz62t4OaETOwEj/krjeu0pFGc4IqSY4E7vDm8QmURG1lew==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 11:56:51.2614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16db5a54-c99b-49e9-e0ce-08def21f7892
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6891
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA5NSBTYWx0ZWRfX8WiigMBmPOG8
 x3hQw3WBPWtF9ydMZboLBbOB3B6FmB9Gs8OImuUFqWlC0Prq/Hh6we8NYAu6elTmVlMvYlNWm8c
 f7uUq703ZhHiDmrc91VBwqBkR2MkcRSvmRvrqQnN1OgdxQjEkPoRdpjdR4WRreGMynzczXJeOX4
 BJrETII98L00TIuUd1XS1xY0uLMLICcB46VF8csIwFGTlpRIJ5W+H3DEzDrDgFIcNOtmAnXv6q/
 /JNRhuTovcPjNsoaMBMkz3DU2u9x33rYyGB/NTx+TLR+RtjWGquMrLkwCSDa7ETBLrOesYYXIV1
 jNjPfO08cKFaC+BjK1HPkCG/6HjbP7wq+ibFnly/TwUWoYhzeMZXfIt43u+5Cjm/alZys+0gVba
 twldO7R1qPrO2LwiixsaHMA4QVDCzdkjFWyFoHposObKA2keGAEO7/23lAqhTEtWw6wmxPQmJ3W
 5n4sLQ2XKfgyX8YrXMQ==
X-Proofpoint-GUID: -DGowV2V2KGDS1YEcT1XuMFOF8lMh7QR
X-Proofpoint-ORIG-GUID: -DGowV2V2KGDS1YEcT1XuMFOF8lMh7QR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA5NSBTYWx0ZWRfX1qd6yz9n5Ndh
 WEHftXrjICPzbreiC7rqn1cA39UZB1hZ+PGYOtYSy8gdCI2J6P2Ndv039d0EssK0hMcTarRZklK
 EG4/zTAzZIO8+2X+NvsmwuycHHiBLu8=
X-Authority-Analysis: v=2.4 cv=Va3H+lp9 c=1 sm=1 tr=0 ts=6a71d38a cx=c_pps
 a=u7VgDZIRhFIHkGP5DPkLlQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=oEgZp9kYouvtd23MWMYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040095
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=tRpTJBw/k8ApN7a3oO9tGhfxISR2MwtJ4aI8/Tb1b
 VM=; b=Ods6hzZIdvLs3OBp8lPKhbQoKBjntprJwLhbJG+Rc+8KqdxDIRrO3d6Dx
 RcReOcEFt1xUTZFa9XAGkonh5MqcFK5WirlMSfdM4Yz0wIkXKuunvEU5NECk0to6
 PC/RRpKXHqq4ZbytzXCx15WANrOcP0JUgneC/GCUVFtGJAqVrZK3MaGD9qzbtx8T
 FQy0Th7fsOcrIapeATXbfAsYM45EgAMy3r7JQEcRDR9OE2PSRjjEz9G8qlEmb/4C
 aCfIbiNsWPU1ImyhJYuxBdwzrQkTd/P6JCCT2gLBZQW7HTeLMsOtoRZ2oGWn6PJm
 HxB4OLJYmmENNELt1XDIFMG0WW72g==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRpTJBw/k8ApN7a3oO9tGhfxISR2MwtJ4aI8/Tb1bVM=;
 b=N483dBF+vHs8JEzK6ZIw6NhnQ3SkYfmM8ZA+7piboHA1fRdqYpLSjCuLIOJXDcS/fYHHiKiBv7ukxF3ggkkES8GAtevRiAH6qqQQIvW6xXMaJimQnPeiAPintZtaepwUOq2U1iLwdiTFCDSHLPpPB3Cl1MioOUBrq74IOt3pWYw=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Ods6hzZI; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=N483dBF+
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

On Tue Aug 4, 2026 at 5:39 AM IST, Bryan Brattlof wrote:
> Add the initial minimum configuration needed to boot the AM62L3-SK
> reference boards.
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
> Changes in v2:
> - removed options used for fit image signing
> - Link to v1: https://lore.kernel.org/r/20260717-am62lx-v1-0-b9830633afb8=
@ti.com
> ---
>  configs/am62lx_evm_defconfig | 139 +++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 139 insertions(+)
>
> diff --git a/configs/am62lx_evm_defconfig b/configs/am62lx_evm_defconfig
> new file mode 100644
> index 000000000000..2db07b508c2a
> --- /dev/null
> +++ b/configs/am62lx_evm_defconfig
> @@ -0,0 +1,139 @@
> +CONFIG_ARM=3Dy
> +CONFIG_ARCH_K3=3Dy
> +CONFIG_TEXT_BASE=3D0x84000000
> +CONFIG_SYS_MALLOC_F_LEN=3D0x8000
> +CONFIG_TI_COMMON_CMD_OPTIONS=3Dy
> +CONFIG_SPL_GPIO=3Dy
> +CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
> +CONFIG_SOC_K3_AM62L3=3Dy
> +CONFIG_TARGET_AM62L3_EVM=3Dy
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x82b80000
> +CONFIG_SF_DEFAULT_SPEED=3D25000000
> +CONFIG_DM_GPIO=3Dy
> +CONFIG_DEFAULT_DEVICE_TREE=3D"ti/k3-am62l3-evm"
> +CONFIG_OF_LIBFDT_OVERLAY=3Dy
> +CONFIG_DM_RESET=3Dy
> +CONFIG_SPL_MMC=3Dy
> +CONFIG_SPL_SERIAL=3Dy
> +CONFIG_SPL_STACK_R_ADDR=3D0x85000000
> +CONFIG_SPL_TEXT_BASE=3D0x82000000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> +CONFIG_SPL_BSS_START_ADDR=3D0x82c80000
> +CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> +CONFIG_SPL_STACK_R=3Dy
> +CONFIG_SYS_BOOTM_LEN=3D0x800000

Currently using the command 'spl export' throws a "Image too large:
increase CONFIG_SYS_BOOTM_LEN" warning. Steps to reproduce:

=3D> load mmc 1:2 $loadaddr boot/fitImage
=3D> spl export fdt $loadaddr

Is there any reason we are keeping it this low? I think the default of
0x8000000 should be fine for us.

Rest of the patch looks good to me,
 - Anshul

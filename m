Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BA6C4452B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 18:09:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D804D608BD;
	Tue, 21 Jul 2026 18:09:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fcx8YCuP8_Qc; Tue, 21 Jul 2026 18:09:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C2F6608D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784657357;
	bh=0GnXp9BT1d94QNoBUh8fZLxpVJClsyMl6XO+HJfPMk0=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=vQRDEq7f9Y1ZaP+JxRijHrjbP6PrTQSCLZle/emH44NcmS5lZpeM2NpGZYJcBSnKj
	 IigQ8JF7VST/tDw4JV6h8+9ABvntrUd6hxJDLGPU9L1O0V09/XzUZdH9iAcO0I7+nF
	 NDfP4duELRsnduL0mqH3aXlR2TVUmmm4rYxesZxBgOLAUI+fSgYRmlrn78y88ttCE7
	 0N9RVVWdHM3GGphLMu28KV/idKU0xcsU4G32ZvN9TclElah6E2pCCcjyIq7ryCwOlO
	 pz3zhaQVaHVTGwIXy9zUpddZw6doxmqdhkkoqhO6lbFaTxIjucV0a+/yDMRicDyDQa
	 tqXJ1KDy6WHPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C2F6608D4;
	Tue, 21 Jul 2026 18:09:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 888E042A
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:06:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 701D140071
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:06:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0GsQ7tk7dJ00 for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 16:06:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B2F9140167
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B2F9140167
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2F9140167
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:06:50 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66LDjH9v1017824;
 Tue, 21 Jul 2026 10:31:15 -0500
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fj077kve8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 10:31:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xz3kHlfA3HbA625+7RIT93yJEQE49T5kI6WVjdXINxR360bOOsVx+Dh3HQib9+MCQtIkpf8X6Idhk8NUOKpH3UJUHxU/gBYV8CkfPs34UKLSxL3HbAhwxVfohr2LQXn3Iqn77g9c4qCYF56lZQ2zbM4Bu+Jb9RY2lleZtpIcjfykk4QNykxCgyvZOj4jgGE3NanTLS8SVjsVTdn/LInSc/bCuQNrhtVsKG+mYTqo8bizycVkKxjaWm8hoD5UiLwQMH/3PDAwi/eTvX8hNTELvUuv94HD9yWvw8ywDl7CLtfV88/BfMRfBfBT2xKbYKoUOHjsFuQSLQXsjp0TOSf6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GnXp9BT1d94QNoBUh8fZLxpVJClsyMl6XO+HJfPMk0=;
 b=w409ohre4/ziOx22dsOvbdZ9DOLW4hPsc9+AyCtNBTjnscXNeJRSD79X7d7waiXsVi+0GN0tVcKAlkWKSMuJE00ewAppoYkIL2NecB+em0iBvHG7IuLriLebEahllTBOr3rc7NJ0Uqddy3RD80N49imm/o07jlPtPtKmk9kW5UxujoFNA63jzii7tWonTX/2iwQK7OW5bDUygzAfPzaFtVT9geEgpfHE43hrJLZWnMGSUZSdqB/cMUNQo4eHh6qZeu4VC0/W/qennldPtCWgNrJR8xV6x1s4zP4k4biaOc56b1wH/e6uqTY7k2Dlfze5ph3CtKW6TW9sH31npgLG3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from PH8PR22CA0007.namprd22.prod.outlook.com (2603:10b6:510:2d1::12)
 by LV3PR10MB7866.namprd10.prod.outlook.com (2603:10b6:408:1bb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 15:31:07 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:510:2d1:cafe::6a) by PH8PR22CA0007.outlook.office365.com
 (2603:10b6:510:2d1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 15:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 15:31:06 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:23 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 10:30:22 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66LFUMm31655329;
 Tue, 21 Jul 2026 10:30:22 -0500
Date: Tue, 21 Jul 2026 10:30:26 -0500
Subject: [PATCH v2 11/11] doc: board: ti: am62lx_evm: add initial docs for
 the AM62L-EVM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260721-am62lx-v2-11-33ff580c267d@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|LV3PR10MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: 0495050e-1589-4ab3-f7f6-08dee73d14e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|7416014|1800799024|82310400026|13003099007|6133799003|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: UTp/DWt2cS2/S+EZo2Li+i4NNVpB84VCIUhE9/rL53ofFvm4fMQYcoTaz7mb3U/WKxvM57GwwGlfy7CKxp27gP1QxSFHiMK9JHEDz7HtaiFLK8r8EiF95FCyFPzMtuhyqh/ju+9y2CKjt8ZY4knf0IkBIzty9AOHKTegb9WHE0V5kTGEE1aPSF1d8gb6JE+0XFdCw89aMWQeeyG8EwLR7r4zUGH/2ZhZ2kui7+v61BP9tEeUXV5C1a6xEXf3UL7zCZUFRta4R7+xRIZS9UtSqm2ncaoGMaix91X8XU+ryuKVL4wP7mpK0rZKpNkfq6RvKE0p66wyYHpoGLH9L/RaF65heelr9ahzJzKE6HC60ioRCiuJIxMXyA64BM4TgiWZia/y1ohGM0SzmPAAmHHaMeGnLOhUHX0QKwWxnLGqZExoJJ8MgtJcf9uyo8JIrFvUAOeT+vywile05EZKehLTA/0yFCRBXooQGNaGf+Ud1+RzmuwbkqqwTjgtxmh5FbNlOjIxu5sZbCJsh62Y8fX+HIrhvxBZQMunj9R7d4SjWVPVXfH9feeoBOaKbZU1yvHAY0miv5d7FTlc7yuJe0fUwcovcTuiIjufqxLe/xjMgJBMwP+qAa2DQI+q48vue7G2w5jNiP8DtuT0eg7DT+MH3A==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(7416014)(1800799024)(82310400026)(13003099007)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s/Korf3Vot4yyHaw53vY7V9ZLLibDRkzzeAf5XkL4PYQsdsSQAmghjfq/LD7dVu0zJe2KB3rMJI0LuPncuZ1dfT+TZ/eoG8lVAAp6X/Y/1w6agRovyQUP2acmumgHCIQ/eW3fp5wsV8Jv8aaBkXBsQbVr3iO8sbi/89RYyqpF3Hntf/yZSF561ckX/Rh59kZxworzywuwhtez4vmu+gdTG7q0GXSePtz0Jo1jPrRvUruKIwGI31lJ42sYC2DtFp1ulAD+eyn1ZgZXNI8dC8UcpjriuIFq6ZxsoXm9vXOTGDMiHg583WWE5EO/ISRKlOaeZKp8mOuID0MfuoO4AP9B16hN6EEsgC1bOIb8/GqmpPjJfTBJ+neHTcIND0nCjWC+6PyQO3vJVF9rLNHh2RR3BuT5hWrYDkxMYj3RMUZhMTFIYN2xBZAu3viu3lrOOnw
X-Exchange-RoutingPolicyChecked: kuspLu/qkOl7LQyAu3o7uyaQoVbW1cqka57K6VgHheGcvXzWP+0WnOtOtNz1hSYMYhCp6nswDdYZqec42q+6P9xiMhIOyyoEGi0GazMQITXArWPLxECeqSZA9GtV3n1jVLAH0P7pMgHouyLs2YAs3DNmLxGvKhmDx3Ymwq5lp946mY0r+1o3JDQU4cv1Lh1nVOUvpSArMFj1JMSb58SRITUVJeUUhZITnH8piAk1htuGO2qcMQrWA7XdwGL+oqvsu87jze6F0dQMMAOPvpbr7qmNo803q+4WUmJ58nK5JVZ2qXKUZL64we/ZQgktzzfpY/QcgOVoB72uSUbs0woMiQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:31:06.1887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0495050e-1589-4ab3-f7f6-08dee73d14e1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7866
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfX+WEqU5tbJ2Mz
 pOYxzDM0gC62rI8cYSAHvsUyNS0aFuMCpgs1+1GNYMbtS4CEcpL66TU92Gxw5fnIhhS9JwQL/ZB
 G0O9oVGe7E8f9adn9Pm9FtLBSwtXG2SbPdlTFH8dA0YNR75t4uf2Xo6mEclOkYPr+oYrR3PHI1K
 1xSFl9B5lx17bOen0IJdik4DfYO8eS/oHbquLkHiGsxgVcJfA4/L3qS2Zti+lTRGVPrU0zQqrah
 nPbF1MSubqdQWZv+P9uArxVpwpX4S4OwTOA7pZAyvLBrS794a71EO1RtePXyclF2IQoJyn0yzsU
 2Yjoxf7F5a9wmsOGYtUaLdOiLG/EGadrgLLXfoKvH57VoACucPDygGUQNdE6i8o/H/Nc0RJMmrv
 ACrDs7Ku4oIw8xh/MdT6mACTb0rBAC2C5UgeldiZCTavM4+xSozt7JtqiQey+jE9dlBLm/RZyiw
 piUZY6xc8JeIKcSIyxg==
X-Proofpoint-ORIG-GUID: hVtTmzuF5U8Nac2E_rtZqh3xfiqEG4Kr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfX52azMHYyGJav
 lKRUa5SlnUbmBETVp3XD4613uA/dv2hiY73ZnrbW5O94O86Qs+xm4ZZ92468C2Abu4cS+mLgQW3
 anO/Y2P8eo/1VW6J1QGdGcMFOhOGni0=
X-Authority-Analysis: v=2.4 cv=KabidwYD c=1 sm=1 tr=0 ts=6a5f90c2 cx=c_pps
 a=h6NrD5D8j3GnK3ckJnoRDA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=UXIAUNObAAAA:8 a=VQ9ene8lAAAA:8
 a=SSmOFEACAAAA:8 a=-sroTuYGUVUSb1OqqHcA:9 a=3xtlNZgm3yEXo+T05C31pup2r18=:19
 a=ntNXrrENjI0yAk1h:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a1s67YnXd6TbAZZNj1wK:22 a=5kMfGx23w8a0v5ansn-_:22
X-Proofpoint-GUID: hVtTmzuF5U8Nac2E_rtZqh3xfiqEG4Kr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210164
X-Mailman-Approved-At: Tue, 21 Jul 2026 18:09:10 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=0GnXp9BT1d94QNoBUh8fZLxpVJClsyMl6XO+HJfPM
 k0=; b=M0rRCwE8UTK9XhOBaNB2usNWpdfzfgnxPQNX/H+VBCHsQt888AI18v5jD
 aWPWdcvgNK2ulzPH/MsjmB1m7eNBTgTUOj6fdNSx+UXZ6EcsQcCeORuXCWn5aH+B
 ZMRBntQghY9Oyrz5QH4g2sHoOtcV2pJiMwZ/wfhfyfojNWPvZlg/+QFJ6gTdejPI
 4VENshJWIYcbXlR65NBggYKb4os/GmPKsTmEYpORj5Uc14ehkAujifGlV+cW9DZ5
 g2scnP/rTmKAIs4KJQEW03ew8Q1g1KqBjP84P+cwlxGCV5mZfkNTLL9NlOOLdA1H
 KQLiKvw07zR8rdVTQ7kWJB8/0mx/w==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GnXp9BT1d94QNoBUh8fZLxpVJClsyMl6XO+HJfPMk0=;
 b=Amqn42kMIkcNVC+G9MP3EAueDcrgZ2mkQsCJWa0WJXLXnOVexW4VaovubNDHB/UM+cDQQfphdbU7uVg39U3PQVq0QykhPagHXMLjWC1F72G8QJ72Wu040SpyXlyPGuqWZQ3oujTF0/WxWJECUc+LoTBnRf/QHSVtjt4ZXMmKgr8=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=M0rRCwE8; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=Amqn42kM
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

Add the initial documentation on the bootflow, build, and deubgging
procedures along with the relevant links to more information about the
AM62Lx processor and the reference board.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 doc/board/ti/am62lx_evm.rst                     | 222 ++++++++++
 doc/board/ti/img/am62lx_boot_diagram_phase1.svg | 450 ++++++++++++++++++++
 doc/board/ti/img/am62lx_boot_diagram_phase2.svg | 525 ++++++++++++++++++++++++
 doc/board/ti/img/am62lx_tiboot3.bin.svg         | 170 ++++++++
 doc/board/ti/img/am62lx_tispl.bin.svg           | 222 ++++++++++
 doc/board/ti/img/am62lx_u-boot.img.svg          | 143 +++++++
 doc/board/ti/k3.rst                             |   1 +
 7 files changed, 1733 insertions(+)

diff --git a/doc/board/ti/am62lx_evm.rst b/doc/board/ti/am62lx_evm.rst
new file mode 100644
index 000000000000..e6a103ab600b
--- /dev/null
+++ b/doc/board/ti/am62lx_evm.rst
@@ -0,0 +1,222 @@
+.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. sectionauthor:: Bryan Brattlof <bb@ti.com>
+
+AM62Lx Platforms
+================
+
+The AM62L is a lite, low power and performance optimized family
+of application processors that are built for Linux application
+development. The AM62L is well suited for a wide range of
+general-purpose applications with scalable ARM Cortex-A53 core
+performance and embedded features such as: Multimedia DSI/DPI support,
+integrated ADC on chip, advanced lower power management modes, and
+extensive security options for IP protection with the built-in security
+features.
+
+The AM62L is a general purpose processor, however some of the
+applications well suited for it include: Human Machine Interfaces (HMI),
+Medical patient monitoring , Building automation, Smart secure gateways,
+Smart Thermostats, EV charging stations, Smart Metering, Solar energy
+and more.
+
+Some highlights of AM62L SoC are:
+
+- Single to Dual 64-bit Arm® Cortex®-A53 microprocessor subsystem up to
+  1.25GHz Integrated Giga-bit Ethernet switch supporting up to a total
+  of two external ports
+
+- 16-bit DDR Subsystem that supports LPDDR4, DDR4 memory types.
+
+- Display support: 1x display support over MIPI DSI (4 lanes DPHY) or
+  DPI (24-bit RGB LVCMOS)
+
+- Multiple low power modes support, ex: Deep sleep and Standby
+
+- Support for secure boot, Trusted Execution Environment (TEE) &
+  Cryptographic Acceleration
+
+For more information check out our `Technical Reference Manual (TRM)`_.
+
+.. _Technical Reference Manual (TRM): https://www.ti.com/lit/ug/sprujb4/sprujb4.pdf
+
+
+Boot Flow:
+----------
+
+The AM62Lx SoCs deviate significantly from the typical boot-flow of the
+other Sitara or Jacinto class of SoCs.
+
+The first CPU released on power on will be the Security Management
+Subsystem (SMS) MCU to first secure the device like all other K3 SoCs.
+However because the lack of any MCU cores the boot ROM is located on one
+of the A53 cores which is responsible for loading TI's root-of-trust
+firmware (TIFS) along with a BL1 image generated from the
+ARM-Trusted-Firmware repository. The BL1 image is responsible for
+initializing the debug console, the DDR controller, and speeding up the
+A53 to it's maximum allowable.
+
+Once the BL1 is done, it will send a message back to the SMS core to
+reset and begin the second boot phase.
+
+.. image:: img/am62lx_boot_diagram_phase1.svg
+   :alt: First phase of the AM62L boot flow
+
+For the second boot phase, with DDR active ROM can now load the larger
+images contained in the tispl.bin (or whatever filename or offset was
+configured during the BL1 boot phase) which contains TI's root-of-trust
+firmware (TIFS) along with OP-TEE, TF-A's BL31 and U-Boot SPL images to
+initialize the root-of-trust, and the TrustZone and normal world for the
+A53s.
+
+From there the U-Boot SPL will load and authenticate U-Boot proper.
+
+.. image:: img/am62lx_boot_diagram_phase2.svg
+   :alt: Second phase of the AM62L boot flow
+
+Sources:
+--------
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_sources
+    :end-before: .. k3_rst_include_end_boot_sources
+
+Build procedure:
+----------------
+
+0. Setup the environment variables:
+
+   .. include::  ../ti/k3.rst
+       :start-after: .. k3_rst_include_start_common_env_vars_desc
+       :end-before: .. k3_rst_include_end_common_env_vars_desc
+
+   .. include::  ../ti/k3.rst
+       :start-after: .. k3_rst_include_start_board_env_vars_desc
+       :end-before: .. k3_rst_include_end_board_env_vars_desc
+
+   Set the variables corresponding to this platform:
+
+   .. include::  ../ti/k3.rst
+       :start-after: .. k3_rst_include_start_common_env_vars_defn
+       :end-before: .. k3_rst_include_end_common_env_vars_defn
+
+   .. prompt:: bash $
+
+      export UBOOT_CFG_CORTEXA=am62lx_evm_defconfig
+      export TFA_BOARD=am62lx-evm
+      export OPTEE_PLATFORM=k3-am62lx
+
+1. Build Trusted Firmware-A:
+
+   More detailed porting and build guide can be found in the `TF-A
+   documentation`_ for all AM62L based platforms. For the AM62L-EVM the
+   build command will be:
+
+   .. prompt:: bash $
+
+      make CROSS_COMPILE=aarch64-none-linux-gnu- \
+            ARCH=aarch64 \
+            PLAT=k3low \
+            TARGET_BOARD=$TFA_BOARD
+
+.. _TF-A documentation: https://trustedfirmware-a.readthedocs.io/en/latest/plat/ti-k3low-am62lx.html
+
+#. Build OP-TEE:
+
+   Depending on the application more build arguments may be needed. The
+   `OP-TEE documentation`_ has more information on this. The basic build
+   commands for the AM62L-EVM are:
+
+   .. prompt:: bash $
+
+      make CROSS_COMPILE=$CC32 \
+            CROSS_COMPILE64=$CC64 \
+            CFG_ARM64_core=y \
+            $OPTEE_EXTRA_ARGS \
+            PLATFORM=$OPTEE_PLATFORM
+
+.. _OP-TEE documentation: https://optee.readthedocs.io/en/latest/
+
+#. Build U-Boot:
+
+   .. prompt:: bash $
+
+      make $UBOOT_CFG_CORTEXA
+      make CROSS_COMPILE=aarch64-linux-gnu- \
+            BINMAN_INDIRS="$LNX_FW_PATH" \
+            TEE="$OPTEE_PATH/out/arm-plat-k3/core/tee-raw.bin" \
+            BL1="$TFA_PATH/build/k3low/$TFA_BOARD/release/bl1.bin" \
+            BL31="$TFA_PATH/build/k3low/$TFA_BOARD/release/bl31.bin"
+
+Image formats:
+--------------
+
+The final images generated and needed for booting the AM62L are:
+
+- tiboot3.bin
+
+.. image:: img/am62lx_tiboot3.bin.svg
+   :alt: tiboot3.bin image format
+
+- tispl.bin
+
+.. image:: img/am62lx_tispl.bin.svg
+   :alt: tispl.bin image format
+
+- u-boot.img
+
+.. image:: img/am62lx_u-boot.img.svg
+   :alt: u-boot.img image format
+
+Switch Setting for Boot Mode
+----------------------------
+
+Boot Mode pins provide means to select the boot mode and options before the
+device is powered up. After every POR, they are the main source to populate
+the Boot Parameter Tables.
+
+The following table shows some common boot modes used on AM62L-EVM
+
+.. list-table::
+   :widths: 16 16 8 8
+   :header-rows: 1
+
+   * - Switch Label
+     - SW4: 12345678
+     - SW2: 1234
+     - SW3: 1234
+
+   * - EMMC
+     - 11010010
+     - 0000
+     - 0000
+
+   * - SD
+     - 11000010
+     - 0100
+     - 0000
+
+   * - UART
+     - 11011100
+     - 0000
+     - 0000
+
+   * - USB DFU
+     - 11001010
+     - 0000
+     - 0000
+
+Debugging U-Boot
+----------------
+
+See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
+detailed setup information.
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
+    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
+
+To start OpenOCD and connect to the board
+
+.. prompt:: bash
+
+   openocd -f board/ti/am62levm.cfg
diff --git a/doc/board/ti/img/am62lx_boot_diagram_phase1.svg b/doc/board/ti/img/am62lx_boot_diagram_phase1.svg
new file mode 100644
index 000000000000..fe10d1a253d8
--- /dev/null
+++ b/doc/board/ti/img/am62lx_boot_diagram_phase1.svg
@@ -0,0 +1,450 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   width="123.04372mm"
+   height="102.41046mm"
+   viewBox="0 0 123.04372 102.41046"
+   version="1.1"
+   id="svg1"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg">
+  <defs
+     id="defs1">
+    <rect
+       x="138.88995"
+       y="89.244179"
+       width="82.705078"
+       height="34.694588"
+       id="rect9" />
+    <rect
+       x="138.88995"
+       y="89.244179"
+       width="83.540909"
+       height="29.679607"
+       id="rect9-9" />
+  </defs>
+  <g
+     id="layer1"
+     transform="translate(-3.2156586,-61.395067)"
+     style="display:inline">
+    <rect
+       style="fill:none;stroke:#000000;stroke-width:0.264583"
+       id="rect1-9"
+       width="1.9329573"
+       height="85.898857"
+       x="41.939594"
+       y="77.774384" />
+    <rect
+       style="fill:none;stroke:#000000;stroke-width:0.264583"
+       id="rect1-9-2"
+       width="1.9329573"
+       height="25.09384"
+       x="84.430481"
+       y="86.003517" />
+    <rect
+       style="fill:none;stroke:#000000;stroke-width:0.264583"
+       id="rect1-9-2-7"
+       width="1.9329573"
+       height="38.677994"
+       x="84.382317"
+       y="124.9362" />
+    <path
+       d="M 14.252899,77.754344 H 41.775385"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       stroke-dasharray="3.175, 3.175"
+       pointer-events="stroke"
+       id="path272"
+       style="stroke-width:0.264583" />
+    <path
+       d="m 42.840209,71.544151 0.04093,6.233026"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       stroke-dasharray="3.175, 3.175"
+       pointer-events="stroke"
+       id="path272-4"
+       style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+    <path
+       d="m 85.45604,71.406464 0.0087,14.680898"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       stroke-dasharray="3.175, 3.175"
+       pointer-events="stroke"
+       id="path272-4-6"
+       style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+    <path
+       d="m 85.443487,111.04287 0.0036,13.97812"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       stroke-dasharray="3.175, 3.175"
+       pointer-events="stroke"
+       id="path272-4-6-8"
+       style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+    <path
+       d="m 122.1225,64.792094 0.056,98.568876"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       stroke-dasharray="3.175, 3.175"
+       pointer-events="stroke"
+       id="path272-4-6-4"
+       style="display:inline;fill:#d40000;stroke-width:0.264584;stroke-dasharray:0.264584, 0.529165;stroke-dashoffset:0" />
+    <g
+       id="g17"
+       transform="translate(-0.20732502,0.70490506)">
+      <rect
+         style="fill:#ffe6cc;fill-opacity:1;stroke:#d79b00;stroke-width:0.264582;stroke-opacity:1"
+         id="rect1"
+         width="16.069794"
+         height="8.8927412"
+         x="26.988451"
+         y="78.507072" />
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="34.991573"
+         y="84.456261"
+         id="text1"><tspan
+           id="tspan1"
+           style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+           x="34.991573"
+           y="84.456261">ROM</tspan></text>
+    </g>
+    <g
+       id="g17-1"
+       transform="translate(58.456195,8.5590037)">
+      <rect
+         style="fill:#ffe6cc;fill-opacity:1;stroke:#d79b00;stroke-width:0.264582;stroke-opacity:1"
+         id="rect1-1"
+         width="16.069794"
+         height="8.8927412"
+         x="26.988451"
+         y="78.507072" />
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="34.991573"
+         y="84.456261"
+         id="text1-5"><tspan
+           id="tspan1-98"
+           style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+           x="34.991573"
+           y="84.456261">ROM</tspan></text>
+    </g>
+    <g
+       id="g21"
+       transform="translate(0.30297529,12.998616)">
+      <g
+         id="g20"
+         transform="translate(-13.448192,1.681024)">
+        <rect
+           style="fill:#d5e8d4;fill-opacity:1;stroke:#82b366;stroke-width:0.264582;stroke-opacity:1"
+           id="rect1-1-0"
+           width="16.069794"
+           height="8.8927412"
+           x="98.597946"
+           y="111.78242" />
+      </g>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="93.599792"
+         y="119.41312"
+         id="text1-5-4"><tspan
+           style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+           x="93.599792"
+           y="119.41312"
+           id="tspan19">BL1</tspan></text>
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="20.957556"
+       y="76.900803"
+       id="text1-8"><tspan
+         id="tspan1-9"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="20.957556"
+         y="76.900803">H/W Reset Release</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="64.100334"
+       y="85.26165"
+       id="text1-8-2"><tspan
+         id="tspan1-9-9"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="64.100334"
+         y="85.26165">Release A53 ROM</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="64.140884"
+       y="104.34003"
+       id="text1-8-2-6"><tspan
+         id="tspan1-9-9-9"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="64.140884"
+         y="104.34003">Authenticate</tspan><tspan
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="64.140884"
+         y="108.15002"
+         id="tspan10">tiboot3.bin</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="63.962883"
+       y="119.40052"
+       id="text1-8-2-6-0"><tspan
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="63.962883"
+         y="119.40052"
+         id="tspan10-1">Reset A53 to</tspan><tspan
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="63.962883"
+         y="123.21052"
+         id="tspan16">BL1 Entry</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="63.822987"
+       y="155.86008"
+       id="text1-8-2-6-0-9"><tspan
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="63.822987"
+         y="155.86008"
+         id="tspan10-1-6">BL1 Done</tspan><tspan
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="63.822987"
+         y="159.67007"
+         id="tspan15">Message</tspan></text>
+    <path
+       d="M 43.79186,86.012678 H 84.529679"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path292"
+       style="stroke-width:0.264582" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+       id="rect8"
+       width="29.836563"
+       height="9.8913136"
+       x="88.656013"
+       y="97.899971"
+       ry="1.8797468"
+       rx="1.8797469" />
+    <rect
+       style="display:inline;fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+       id="rect8-7"
+       width="29.836563"
+       height="9.8913136"
+       x="70.63903"
+       y="61.527359"
+       ry="1.8797468"
+       rx="1.8797469" />
+    <rect
+       style="display:inline;fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+       id="rect8-7-9"
+       width="29.836563"
+       height="9.8913136"
+       x="27.875254"
+       y="61.689301"
+       ry="1.8797468"
+       rx="1.8797469" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+       id="rect8-31"
+       width="29.836563"
+       height="9.8913136"
+       x="88.697792"
+       y="137.6286"
+       ry="1.8797468"
+       rx="1.8797469" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264583;stroke-opacity:1"
+       id="rect8-3"
+       width="29.756132"
+       height="9.9170303"
+       x="10.461226"
+       y="112.1797"
+       ry="1.8797468"
+       rx="1.8797469" />
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,55.945023,75.710672)"
+       id="text8"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;white-space:pre;shape-inside:url(#rect9);display:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-opacity:1"
+       x="0"
+       y="0"><tspan
+         x="162.65117"
+         y="101.24414"
+         id="tspan3">Load </tspan><tspan
+         x="143.97914"
+         y="115.64414"
+         id="tspan4">tiboot3.bin</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,-22.357201,90.009926)"
+       id="text8-6"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;white-space:pre;shape-inside:url(#rect9-9);display:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-opacity:1"
+       x="0"
+       y="0"><tspan
+         x="152.34912"
+         y="101.24414"
+         id="tspan5">Validate </tspan><tspan
+         x="144.39711"
+         y="115.64414"
+         id="tspan6">tiboot3.bin</tspan></text>
+    <path
+       d="m 41.982847,77.762613 -1.85208,0.92604 0.46302,-0.92604 -0.46302,-0.92604 z"
+       fill="#000000"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path294"
+       style="stroke-width:0.264583" />
+    <path
+       d="m 84.45369,86.024357 -1.85208,0.92604 0.46302,-0.92604 -0.46302,-0.92604 z"
+       fill="#000000"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path294-4"
+       style="stroke-width:0.264583" />
+    <g
+       id="g18"
+       transform="matrix(1.3039736,0,0,1,-13.367223,6.910834)"
+       style="stroke-width:0.875721">
+      <path
+         d="m 43.895114,102.59059 h 31.14238"
+         fill="none"
+         stroke="#000000"
+         stroke-miterlimit="10"
+         pointer-events="stroke"
+         id="path292-5"
+         style="stroke-width:0.231701" />
+      <path
+         d="m 44.052705,102.59467 1.85208,0.92604 -0.46302,-0.92604 0.46302,-0.92604 z"
+         fill="#000000"
+         stroke="#000000"
+         stroke-miterlimit="10"
+         pointer-events="all"
+         id="path294-8"
+         style="stroke-width:0.231701" />
+    </g>
+    <path
+       d="M 43.737375,124.94556 H 83.348064"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path292-5-4"
+       style="stroke-width:0.264583" />
+    <path
+       d="m 84.175686,124.95576 -2.115358,0.92604 0.52884,-0.92604 -0.52884,-0.92604 z"
+       fill="#000000"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path294-8-8"
+       style="stroke-width:0.264583" />
+    <path
+       d="m 122.19619,163.47482 -0.92604,-2.11535 0.92604,0.52884 0.92604,-0.52884 z"
+       fill="#000000"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path294-8-8-9"
+       style="display:inline;stroke-width:0.264583" />
+    <g
+       id="g25"
+       transform="translate(0,-5.2916669)">
+      <path
+         d="M 43.847715,167.18481 H 84.499402"
+         fill="none"
+         stroke="#000000"
+         stroke-miterlimit="10"
+         pointer-events="stroke"
+         id="path292-5-4-1"
+         style="stroke-width:0.264583" />
+      <path
+         d="m 44.02991,167.15364 1.85208,0.92604 -0.46302,-0.92604 0.46302,-0.92604 z"
+         fill="#000000"
+         stroke="#000000"
+         stroke-miterlimit="10"
+         pointer-events="all"
+         id="path294-8-8-0"
+         style="stroke-width:0.264583" />
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-opacity:1"
+       x="103.49282"
+       y="142.27876"
+       id="text12"><tspan
+         id="tspan12"
+         style="font-size:4.23333px;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="103.49282"
+         y="142.27876">Debug Console</tspan><tspan
+         style="font-size:4.23333px;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="103.49282"
+         y="146.08876"
+         id="tspan13">Init</tspan></text>
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+       id="rect8-2"
+       width="29.836563"
+       height="9.8913136"
+       x="88.51506"
+       y="149.61092"
+       ry="1.8797468"
+       rx="1.8797469" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-opacity:1"
+       x="103.45767"
+       y="156.1178"
+       id="text14"><tspan
+         id="tspan14"
+         style="font-size:4.23333px;stroke-width:0.264583"
+         x="103.45767"
+         y="156.1178">DRAM Init</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-opacity:1"
+       x="85.482224"
+       y="68.033394"
+       id="text26"><tspan
+         id="tspan26"
+         style="fill:#000000;stroke:none;stroke-width:0.264583"
+         x="85.482224"
+         y="68.033394">Cortex A53</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;display:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-opacity:1"
+       x="42.888348"
+       y="67.920227"
+       id="text26-8"><tspan
+         id="tspan26-3"
+         style="fill:#000000;stroke:none;stroke-width:0.264583"
+         x="42.888348"
+         y="67.920227">SMS M4</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:vertical-lr;direction:ltr;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529167;stroke-dashoffset:0;stroke-opacity:1"
+       x="124.44329"
+       y="115.65893"
+       id="text28"><tspan
+         id="tspan28"
+         style="writing-mode:vertical-lr;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="124.44329"
+         y="115.65893">Time</tspan></text>
+  </g>
+</svg>
diff --git a/doc/board/ti/img/am62lx_boot_diagram_phase2.svg b/doc/board/ti/img/am62lx_boot_diagram_phase2.svg
new file mode 100644
index 000000000000..bac900ebd3eb
--- /dev/null
+++ b/doc/board/ti/img/am62lx_boot_diagram_phase2.svg
@@ -0,0 +1,525 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   width="115.94852mm"
+   height="145.69476mm"
+   viewBox="0 0 115.94853 145.69477"
+   version="1.1"
+   id="svg1"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg">
+  <defs
+     id="defs1">
+    <rect
+       x="138.88995"
+       y="89.244179"
+       width="82.705078"
+       height="34.694588"
+       id="rect9" />
+    <rect
+       x="138.88995"
+       y="89.244179"
+       width="83.540909"
+       height="29.679607"
+       id="rect9-9" />
+    <rect
+       x="138.88995"
+       y="89.244179"
+       width="83.540909"
+       height="29.679607"
+       id="rect9-9-6" />
+  </defs>
+  <rect
+     style="fill:none;stroke:#000000;stroke-width:0.264583"
+     id="rect1-9"
+     width="1.9329573"
+     height="60.20092"
+     x="31.628733"
+     y="16.379316" />
+  <rect
+     style="fill:none;stroke:#000000;stroke-width:0.264583"
+     id="rect1-9-6"
+     width="1.9329573"
+     height="64.373627"
+     x="31.569685"
+     y="81.187851" />
+  <rect
+     style="fill:none;stroke:#000000;stroke-width:0.264583"
+     id="rect1-9-2"
+     width="1.9329573"
+     height="25.09384"
+     x="74.106453"
+     y="24.60845" />
+  <rect
+     style="fill:none;stroke:#000000;stroke-width:0.264583"
+     id="rect1-9-2-7"
+     width="1.9329573"
+     height="24.820444"
+     x="74.071457"
+     y="63.541138" />
+  <rect
+     style="fill:none;stroke:#000000;stroke-width:0.264583"
+     id="rect1-9-2-7-6"
+     width="1.9329573"
+     height="14.440828"
+     x="74.120178"
+     y="93.028458" />
+  <rect
+     style="fill:none;stroke:#000000;stroke-width:0.264583"
+     id="rect1-9-2-7-6-2"
+     width="1.9329573"
+     height="14.440828"
+     x="74.067307"
+     y="112.07141" />
+  <path
+     d="m 32.529347,10.149084 0.04093,6.233026"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4"
+     style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+  <path
+     d="m 75.145178,10.011397 0.0087,14.680898"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4-6"
+     style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+  <path
+     d="m 75.04042,49.654389 0.0036,13.97812"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4-6-8"
+     style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+  <path
+     d="m 32.555322,76.438013 0.0036,4.872016"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4-6-8-9"
+     style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+  <path
+     d="m 75.042581,88.228681 0.0036,4.872016"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4-6-8-9-4"
+     style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+  <path
+     d="m 75.031791,107.33222 0.0036,4.87201"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4-6-8-9-4-5"
+     style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+  <rect
+     style="fill:none;stroke:#000000;stroke-width:0.264583"
+     id="rect1-9-2-7-6-2-7"
+     width="1.9329573"
+     height="14.440828"
+     x="74.062813"
+     y="131.12164" />
+  <path
+     d="m 75.027294,126.38245 0.0036,4.87201"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4-6-8-9-4-5-0"
+     style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+  <path
+     d="m 111.81164,3.3957745 0.056,138.2673655"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4-6-4"
+     style="display:inline;fill:#d40000;stroke-width:0.264584;stroke-dasharray:0.264584, 0.529166;stroke-dashoffset:0" />
+  <g
+     id="g17"
+     transform="translate(-10.518186,-60.69016)">
+    <rect
+       style="fill:#ffe6cc;fill-opacity:1;stroke:#d79b00;stroke-width:0.264582;stroke-opacity:1"
+       id="rect1"
+       width="16.069794"
+       height="8.8927412"
+       x="26.988451"
+       y="78.507072" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="34.991573"
+       y="84.456261"
+       id="text1"><tspan
+         id="tspan1"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="34.991573"
+         y="84.456261">ROM</tspan></text>
+  </g>
+  <g
+     id="g17-1"
+     transform="translate(48.145333,-52.83606)">
+    <rect
+       style="fill:#ffe6cc;fill-opacity:1;stroke:#d79b00;stroke-width:0.264582;stroke-opacity:1"
+       id="rect1-1"
+       width="16.069794"
+       height="8.8927412"
+       x="26.988451"
+       y="78.507072" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="34.991573"
+       y="84.456261"
+       id="text1-5"><tspan
+         id="tspan1-98"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="34.991573"
+         y="84.456261">ROM</tspan></text>
+  </g>
+  <g
+     id="g21"
+     transform="translate(-10.007886,-48.39645)">
+    <g
+       id="g20"
+       transform="translate(-13.448192,1.681024)">
+      <rect
+         style="fill:#d5e8d4;fill-opacity:1;stroke:#82b366;stroke-width:0.264582;stroke-opacity:1"
+         id="rect1-1-0"
+         width="16.069794"
+         height="8.8927412"
+         x="98.597946"
+         y="111.78242" />
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="93.599792"
+       y="119.41312"
+       id="text1-5-4"><tspan
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="93.599792"
+         y="119.41312"
+         id="tspan19">BL31</tspan></text>
+  </g>
+  <rect
+     style="fill:#dbe4f4;fill-opacity:1;stroke:#8166b3;stroke-width:0.264582;stroke-opacity:1"
+     id="rect1-1-0-2"
+     width="16.069794"
+     height="8.8927412"
+     x="74.944"
+     y="94.379715" />
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+     x="82.984222"
+     y="100.36663"
+     id="text1-5-4-28"><tspan
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="82.984222"
+       y="100.36663"
+       id="tspan19-9">TEE</tspan></text>
+  <rect
+     style="fill:#f8cecc;fill-opacity:1;stroke:#b85450;stroke-width:0.264582;stroke-opacity:1"
+     id="rect1-1-0-2-9"
+     width="16.069794"
+     height="8.8927412"
+     x="75.009903"
+     y="113.30912" />
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+     x="83.459938"
+     y="119.2588"
+     id="text1-5-4-28-3"><tspan
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="83.459938"
+       y="119.2588"
+       id="tspan19-9-1">SPL</tspan></text>
+  <rect
+     style="fill:#f8cecc;fill-opacity:1;stroke:#b85450;stroke-width:0.264582;stroke-opacity:1"
+     id="rect1-1-0-2-9-5"
+     width="16.069794"
+     height="8.8927412"
+     x="75.03476"
+     y="132.62766" />
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+     x="82.852531"
+     y="138.55098"
+     id="text1-5-4-28-3-0"><tspan
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="82.852531"
+       y="138.55098"
+       id="tspan19-9-1-3">U-Boot</tspan></text>
+  <g
+     id="g21-8"
+     transform="translate(-68.661248,-30.96516)">
+    <g
+       id="g20-7"
+       transform="translate(-13.448192,1.681024)">
+      <rect
+         style="fill:#d5e8d4;fill-opacity:1;stroke:#82b366;stroke-width:0.264582;stroke-opacity:1"
+         id="rect1-1-0-9"
+         width="16.069794"
+         height="8.8927412"
+         x="98.597946"
+         y="111.78242" />
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="93.599792"
+       y="119.41312"
+       id="text1-5-4-2"><tspan
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="93.599792"
+         y="119.41312"
+         id="tspan19-0">TI-FS</tspan></text>
+  </g>
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+     x="53.789471"
+     y="23.866583"
+     id="text1-8-2"><tspan
+       id="tspan1-9-9"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="53.789471"
+       y="23.866583">Release A53 ROM</tspan></text>
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+     x="53.830021"
+     y="42.944962"
+     id="text1-8-2-6"><tspan
+       id="tspan1-9-9-9"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="53.830021"
+       y="42.944962">Authenticate</tspan><tspan
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="53.830021"
+       y="46.754951"
+       id="tspan10">tispl.bin</tspan></text>
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+     x="53.65202"
+     y="58.005455"
+     id="text1-8-2-6-0"><tspan
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="53.65202"
+       y="58.005455"
+       id="tspan10-1">Reset A53 to</tspan><tspan
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="53.65202"
+       y="61.815453"
+       id="tspan16">BL31 Entry</tspan></text>
+  <path
+     d="M 33.480998,24.617611 H 74.218817"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     pointer-events="stroke"
+     id="path292"
+     style="stroke-width:0.264582" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+     id="rect8"
+     width="29.836563"
+     height="9.8913136"
+     x="78.345154"
+     y="36.504906"
+     ry="1.8797468"
+     rx="1.8797469" />
+  <rect
+     style="display:inline;fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+     id="rect8-7"
+     width="29.836563"
+     height="9.8913136"
+     x="60.328167"
+     y="0.132292"
+     ry="1.8797468"
+     rx="1.8797469" />
+  <rect
+     style="display:inline;fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+     id="rect8-7-9"
+     width="29.836563"
+     height="9.8913136"
+     x="17.564394"
+     y="0.29423353"
+     ry="1.8797468"
+     rx="1.8797469" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+     id="rect8-31"
+     width="29.836563"
+     height="9.8913136"
+     x="78.386932"
+     y="76.233536"
+     ry="1.8797468"
+     rx="1.8797469" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264583;stroke-opacity:1"
+     id="rect8-3"
+     width="29.756132"
+     height="9.9170303"
+     x="0.15036553"
+     y="50.784637"
+     ry="1.8797468"
+     rx="1.8797469" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264583;stroke-opacity:1"
+     id="rect8-3-5"
+     width="29.756132"
+     height="9.9170303"
+     x="0.1322915"
+     y="65.710831"
+     ry="1.8797468"
+     rx="1.8797469" />
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,45.634161,14.315605)"
+     id="text8"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;white-space:pre;shape-inside:url(#rect9);display:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-opacity:1"
+     x="0"
+     y="0"><tspan
+       x="162.65117"
+       y="101.24414"
+       id="tspan3">Load </tspan><tspan
+       x="153.55515"
+       y="115.64414"
+       id="tspan4">tispl.bin</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,-32.668058,28.614859)"
+     id="text8-6"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;white-space:pre;shape-inside:url(#rect9-9);display:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-opacity:1"
+     x="0"
+     y="0"><tspan
+       x="152.34912"
+       y="101.24414"
+       id="tspan5">Validate </tspan><tspan
+       x="153.97311"
+       y="115.64414"
+       id="tspan6">tispl.bin</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,-34.238568,43.502747)"
+     id="text8-6-9"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;white-space:pre;shape-inside:url(#rect9-9-6);display:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-opacity:1"
+     x="0"
+     y="0"><tspan
+       x="145.15712"
+       y="101.24414"
+       id="tspan7">Boot TIFS </tspan><tspan
+       x="147.90111"
+       y="115.64414"
+       id="tspan8">Firmware</tspan></text>
+  <path
+     d="m 74.142828,24.62929 -1.85208,0.92604 0.46302,-0.92604 -0.46302,-0.92604 z"
+     fill="#000000"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     pointer-events="all"
+     id="path294-4"
+     style="stroke-width:0.264583" />
+  <g
+     id="g18"
+     transform="matrix(1.3039736,0,0,1,-23.678085,-54.48423)"
+     style="stroke-width:0.875721">
+    <path
+       d="m 43.895114,102.59059 h 31.14238"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path292-5"
+       style="stroke-width:0.231701" />
+    <path
+       d="m 44.052705,102.59467 1.85208,0.92604 -0.46302,-0.92604 0.46302,-0.92604 z"
+       fill="#000000"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path294-8"
+       style="stroke-width:0.231701" />
+  </g>
+  <path
+     d="M 33.426513,63.550493 H 73.037202"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     pointer-events="stroke"
+     id="path292-5-4"
+     style="stroke-width:0.264583" />
+  <path
+     d="m 73.864824,63.560693 -2.115358,0.92604 0.52884,-0.92604 -0.52884,-0.92604 z"
+     fill="#000000"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     pointer-events="all"
+     id="path294-8-8"
+     style="stroke-width:0.264583" />
+  <path
+     d="m 111.88533,142.46714 -0.92604,-2.11535 0.92604,0.52884 0.92604,-0.52884 z"
+     fill="#000000"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     pointer-events="all"
+     id="path294-8-8-9"
+     style="display:inline;stroke-width:0.264583" />
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-opacity:1"
+     x="93.181946"
+     y="82.699966"
+     id="text12">SCMI Init</text>
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-opacity:1"
+     x="75.171364"
+     y="6.6383266"
+     id="text26"><tspan
+       id="tspan26"
+       style="fill:#000000;stroke:none;stroke-width:0.264583"
+       x="75.171364"
+       y="6.6383266">Cortex A53</tspan></text>
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;display:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-opacity:1"
+     x="32.577484"
+     y="6.5251598"
+     id="text26-8"><tspan
+       id="tspan26-3"
+       style="fill:#000000;stroke:none;stroke-width:0.264583"
+       x="32.577484"
+       y="6.5251598">SMS M4</tspan></text>
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:vertical-lr;direction:ltr;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529167;stroke-dashoffset:0;stroke-opacity:1"
+     x="114.13243"
+     y="68.022209"
+     id="text28"><tspan
+       id="tspan28"
+       style="writing-mode:vertical-lr;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="114.13243"
+       y="68.022209">Time</tspan></text>
+</svg>
diff --git a/doc/board/ti/img/am62lx_tiboot3.bin.svg b/doc/board/ti/img/am62lx_tiboot3.bin.svg
new file mode 100644
index 000000000000..17b9a8538881
--- /dev/null
+++ b/doc/board/ti/img/am62lx_tiboot3.bin.svg
@@ -0,0 +1,170 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   width="62.236633mm"
+   height="85.065804mm"
+   viewBox="0 0 62.236632 85.065803"
+   version="1.1"
+   id="svg51133"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg">
+  <defs
+     id="defs51130">
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-4" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2-8" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-6" />
+  </defs>
+  <rect
+     style="fill:#ffe6cc;fill-opacity:1;stroke:#d79b00;stroke-width:0.22289;stroke-opacity:1"
+     id="rect51238"
+     width="62.013744"
+     height="84.842911"
+     x="0.11144508"
+     y="0.11144508"
+     ry="9.4566326" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195943;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478"
+     width="48.173313"
+     height="13.032638"
+     x="6.9406042"
+     y="25.645016"
+     ry="0" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195943;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478-8"
+     width="48.173313"
+     height="13.032638"
+     x="6.9406042"
+     y="12.612378"
+     ry="0" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478-9"
+     width="48.161327"
+     height="13.02805"
+     x="6.9406042"
+     y="38.677654"
+     ry="0" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478-9-1"
+     width="48.161327"
+     height="13.02805"
+     x="6.9406042"
+     y="51.705704"
+     ry="0" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478-9-1-2"
+     width="48.161327"
+     height="13.02805"
+     x="6.9406042"
+     y="64.733757"
+     ry="0" />
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.58611px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;stroke-width:0.264583"
+     x="20.600019"
+     y="7.8484602"
+     id="text53682"><tspan
+       id="tspan53680"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.58611px;font-family:Helvetica;-inkscape-font-specification:Helvetica;stroke-width:0.264583"
+       x="20.600019"
+       y="7.8484602">tiboot3.bin</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,0.52916667,17.991672)"
+     id="text79829"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831)"
+     x="56.255871"
+     y="0"><tspan
+       x="83.140137"
+       y="60.311719"
+       id="tspan1">TF-A BL1</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,0.17044751,5.285958)"
+     id="text79829-8"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-6)"
+     x="56.255871"
+     y="0"><tspan
+       x="43.948105"
+       y="60.311719"
+       id="tspan2">x509 User Certificate</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,-0.0933935,30.897375)"
+     id="text79829-6"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2)"
+     x="56.255871"
+     y="0"><tspan
+       x="38.292099"
+       y="60.311719"
+       id="tspan3">Encrypted TIFS Binary</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,-0.06460892,41.158058)"
+     id="text79829-6-8"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2-2)"
+     x="56.255871"
+     y="0"><tspan
+       x="35.4673"
+       y="60.311719"
+       id="tspan4">TIFS Board &amp; Security
+</tspan><tspan
+       x="52.220093"
+       y="80.311719"
+       id="tspan5">Configuration Files</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,0.08028719,57.131985)"
+     id="text79829-6-8-8"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2-2-8)"
+     x="56.255871"
+     y="0"><tspan
+       x="35.196075"
+       y="60.311719"
+       id="tspan6">TIFS Vendor Certificate</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,-0.98430343,17.372352)"
+     id="text79829-2"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-4)"
+     x="56.255871"
+     y="0" />
+</svg>
diff --git a/doc/board/ti/img/am62lx_tispl.bin.svg b/doc/board/ti/img/am62lx_tispl.bin.svg
new file mode 100644
index 000000000000..d2c9d7d56951
--- /dev/null
+++ b/doc/board/ti/img/am62lx_tispl.bin.svg
@@ -0,0 +1,222 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   width="62.236744mm"
+   height="111.84308mm"
+   viewBox="0 0 62.236743 111.84308"
+   version="1.1"
+   id="svg51133"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg">
+  <defs
+     id="defs51130">
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-4" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2-8" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-6" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2-8-3" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2-8-3-9" />
+  </defs>
+  <g
+     id="layer1"
+     transform="translate(5.4851174e-5,5.4851174e-5)">
+    <rect
+       style="fill:#d5e8d4;fill-opacity:1;stroke:#82b366;stroke-width:0.255676;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51238"
+       width="61.981068"
+       height="111.5874"
+       x="0.12778315"
+       y="0.12778315"
+       ry="8.4550943" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195943;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51478"
+       width="48.173313"
+       height="13.032638"
+       x="6.9406042"
+       y="25.645016"
+       ry="0" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195943;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51478-8"
+       width="48.173313"
+       height="13.032638"
+       x="6.9406042"
+       y="12.612378"
+       ry="0" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51478-9"
+       width="48.161327"
+       height="13.02805"
+       x="6.9406042"
+       y="38.677654"
+       ry="0" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51478-9-1"
+       width="48.161327"
+       height="13.02805"
+       x="6.9406042"
+       y="51.705704"
+       ry="0" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51478-9-1-2"
+       width="48.161327"
+       height="13.02805"
+       x="6.9406042"
+       y="64.733757"
+       ry="0" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51478-9-1-2-3"
+       width="48.161327"
+       height="13.02805"
+       x="6.9406042"
+       y="77.76181"
+       ry="0" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51478-9-1-2-3-7"
+       width="48.161327"
+       height="13.02805"
+       x="6.9406042"
+       y="90.789864"
+       ry="0" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.58611px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;stroke-width:0.264583"
+       x="23.345928"
+       y="7.5099988"
+       id="text53682"><tspan
+         id="tspan53680"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.58611px;font-family:Helvetica;-inkscape-font-specification:Helvetica;stroke-width:0.264583"
+         x="23.345928"
+         y="7.5099988">tispl.bin</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,0.52916667,17.991672)"
+       id="text79829"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831)"
+       x="56.255871"
+       y="0"><tspan
+         x="78.844223"
+         y="59.175719"
+         id="tspan129104">TF-A BL31</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,0.17044751,5.285958)"
+       id="text79829-8"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-6)"
+       x="56.255871"
+       y="0"><tspan
+         x="42.572357"
+         y="59.175719"
+         id="tspan129106">x509 User Certificate</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,-0.0933935,30.897375)"
+       id="text79829-6"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2)"
+       x="56.255871"
+       y="0"><tspan
+         x="36.972336"
+         y="59.175719"
+         id="tspan129108">Encrypted TIFS Binary</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,-0.06460892,41.158058)"
+       id="text79829-6-8"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2-2)"
+       x="56.255871"
+       y="0"><tspan
+         x="37.980316"
+         y="59.175719"
+         id="tspan129110">TIFS Board &amp; Security
+</tspan><tspan
+         x="50.868347"
+         y="79.175719"
+         id="tspan129112">Configuration Files</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,0.08028719,57.131985)"
+       id="text79829-6-8-8"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2-2-8)"
+       x="56.255871"
+       y="0"><tspan
+         x="34.524368"
+         y="59.175719"
+         id="tspan129114">TIFS Vendor Certificate</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,0.12491591,70.050492)"
+       id="text79829-6-8-8-8"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2-2-8-3)"
+       x="56.255871"
+       y="0"><tspan
+         x="88.596207"
+         y="59.175719"
+         id="tspan129116">OP-TEE</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,-0.31574226,83.33275)"
+       id="text79829-6-8-8-8-3"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2-2-8-3-9)"
+       x="56.255871"
+       y="0"><tspan
+         x="75.300201"
+         y="59.175719"
+         id="tspan129118">U-Boot SPL</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,-0.98430343,17.372352)"
+       id="text79829-2"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-4)"
+       x="56.255871"
+       y="0" />
+  </g>
+</svg>
diff --git a/doc/board/ti/img/am62lx_u-boot.img.svg b/doc/board/ti/img/am62lx_u-boot.img.svg
new file mode 100644
index 000000000000..b20ab1a491ed
--- /dev/null
+++ b/doc/board/ti/img/am62lx_u-boot.img.svg
@@ -0,0 +1,143 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   width="62.236744mm"
+   height="59.627434mm"
+   viewBox="0 0 62.236744 59.627435"
+   version="1.1"
+   id="svg51133"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg">
+  <defs
+     id="defs51130">
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-4" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2-8" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-6" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2-8-3" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2-8-3-9" />
+  </defs>
+  <rect
+     style="fill:#dbe4f4;fill-opacity:1;stroke:#8166b3;stroke-width:0.255676;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51238"
+     width="61.981068"
+     height="59.371758"
+     x="0.127838"
+     y="0.127838"
+     ry="8.4550943"
+     rx="8.4550943" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195943;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478"
+     width="48.173313"
+     height="13.032638"
+     x="6.9406586"
+     y="25.645071"
+     ry="0" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195943;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478-8"
+     width="48.173313"
+     height="13.032638"
+     x="6.9406586"
+     y="12.612433"
+     ry="0" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478-9"
+     width="48.161327"
+     height="13.02805"
+     x="6.9406586"
+     y="38.677708"
+     ry="0" />
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.58611px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;stroke-width:0.264583"
+     x="20.700148"
+     y="8.0392199"
+     id="text53682"><tspan
+       id="tspan53680"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.58611px;font-family:Helvetica;-inkscape-font-specification:Helvetica;stroke-width:0.264583"
+       x="20.700148"
+       y="8.0392199">u-boot.img</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,0.52922115,17.991727)"
+     id="text79829"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831);display:inline"
+     x="56.255871"
+     y="0"><tspan
+       x="92.724136"
+       y="60.311719"
+       id="tspan1">U-Boot</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,0.17050215,5.2860127)"
+     id="text79829-8"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-6);display:inline"
+     x="56.255871"
+     y="0"><tspan
+       x="77.404114"
+       y="60.311719"
+       id="tspan2">FIT Header</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,-0.09333885,30.89743)"
+     id="text79829-6"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2);display:inline"
+     x="56.255871"
+     y="0"><tspan
+       x="74.772141"
+       y="60.311719"
+       id="tspan3">U-Boot DTB</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,-0.98424885,17.372407)"
+     id="text79829-2"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-4);display:inline"
+     x="56.255871"
+     y="0" />
+</svg>
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index b7b69949af16..56df72b656bd 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -33,6 +33,7 @@ K3 Based SoCs
    am62ax_sk
    am62dx_evm
    am62x_sk
+   am62lx_evm
    am62px_sk
    am6254atl_sk
    am64x_evm

-- 
2.54.0


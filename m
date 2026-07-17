Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88357C4451B
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 15:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E286684A67;
	Sat, 18 Jul 2026 17:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ndtULkOA";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sj+5v5Aj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1047A80398; Sat, 18 Jul 2026 01:24:12 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BDCA80517
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 01:24:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HNFw0S3731091; Fri, 17 Jul 2026 18:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=z11j+I9delbtGMTOQ41AjbHC0zJPkwrl2U1Q1eRuj
 pY=; b=ndtULkOA4+dx24B2ZqgP02hUYjBxc3HCe8Pm6JgM4gZOwtmHCt700ThLC
 oxQN7n5wrhoQOcI1z1YGMot8P5DE49UH7y0gwX6UdYt4R/7/jOm1/YNwhNPYb51s
 s3V+8BI7/6vvUHAbFFS6WGsI7V373g6wNCtFiTggfjZLVNolcUBAOx17/zeqvkuo
 NcaTLzQRmVUBc7FxGgI/KSkmCH1NClkND8Ay8SCoZBUaOBBdw06QqaRPqpsgmWgS
 OTYh6ypVO3JigKKZRFS7Sr4C6exl8Zz96dAZE6vy0vEIsUGTOyZdBTfU5kzDNISx
 sXtZgV3ql/1ybjA9kdC239QpcvWrg==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ffkc3m34v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 18:23:54 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSk9T7P/R0ZeIyP44j5u8XifM3/xe485H/+QcT5uaxSMLz3qteslo5typMefxYyaSMKask5qJUTtsGngxTIXc3q0JeYCcX5XjzDBy97ipM3f6hxg+jcVAG8qGbL2KfEs1dKyOPIUSeX8l61bo9Rwm8pPee4FtXXxVlx9B7RhdXUITCCEQO1qd0eHk/0wDMy2MJSJ558/NlNCKz0CLD8YFM2ViKA/4+6YWDfoAn+0qum58aAEk/bizqhBI01EDUuHjQlJtsiCVsolrBD9jujCUOIZODLKhpAI6sPAsDox2i5CkW1lMJOXIlMQtuwJNNkNuMcApzv5LmXcCBfH7e1LXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z11j+I9delbtGMTOQ41AjbHC0zJPkwrl2U1Q1eRujpY=;
 b=FZhpNTqwrutGQXQ155OKQjOUo0RMT+9y6FJXww47EzN+TRodyXPMMH4czRb+AMBJE7ETW0kyY0l8zAH91q5urj7hMhxFcOwp7csR//GMGCObkpfAODia6wtJqumhDON+ijaS7ofP5kDt3Vf/WXaAhQsWoowtWNrGBMQH8FW6jnCkLkE6HvRTY2obzqakAHVS1qB06o/dMFxpbRPexn0GqA6J335+gWB5pZR8zL1mmzmrQlAIJxUGRLQpk+nLNs+aqFIbyo3Tx8zvLZdHU1J/y272oTOPg8+cNhrkQH3oIcPx4yormQg5GCNJ+iP86kQtjJurwsh+hMvJiSN9Uys06w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z11j+I9delbtGMTOQ41AjbHC0zJPkwrl2U1Q1eRujpY=;
 b=sj+5v5Aj9ZPJOmkN3wgseCcY/JN2EKN8R3ZLeq+t9gZ2q7O4Zdh0e2xBHP3PF71aP7VhQeUtQ9uuG04OImG9rRYc6XNX/G8qsCxsNlj4YoZRIWUjewLiFkOF5X3eYONV8eKl04I7i33MrNQfWcgZMejJ6N9egEeLyIlwp6KrK8k=
Received: from MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::35)
 by BL3PR10MB6212.namprd10.prod.outlook.com (2603:10b6:208:38c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 23:23:47 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::5) by MW4P220CA0030.outlook.office365.com
 (2603:10b6:303:115::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Fri,
 17 Jul 2026 23:23:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 23:23:46 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:34 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 18:23:34 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HNNXDH150126;
 Fri, 17 Jul 2026 18:23:33 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 17 Jul 2026 18:23:37 -0500
Subject: [PATCH 07/11] arm: dts: k3-am62lx: Add binman support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260717-am62lx-v1-7-b9830633afb8@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|BL3PR10MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cec19e0-f1b5-429c-9a26-08dee45a7318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|18002099003|22082099003|3023799007|13003099007|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 7q7CBVTT8qnctTg57GohXxFLJm18CAM8mej0anw7iN1jUj+nlJpRl3aYwPIgawWyB7jmKgNylK6fCd+n6r+Crd6aWK/ylpKX6veskOxJYFBbL7fh2atIaQgL+5r/0jeT0Cyl2nlj9c60GuMx1/Lh/ibaXjgwuhI6Ar3u/AkYRgv2fYa5QHPmQrfi6MXOYxVAnQrO1ANsIkA780nB/pqw0YprnTxf0xyQEY01E33lwQmg9Eda9s5fMLzoT9f2xkBoewk6o71G+ak+Hc7NarADa2BNRlEUGK2+H7AAoUHuGltTNAvWJvMuXWytdhjdvIgQMRUZVIb5Jvwvh0E66rlw2VOOdHs/9118CPx+7e7T4OqhCGIsp97hIRej0swvfoJ/aW2XxuGgwC4iYr5EAc7rVKs1FElxMcsfiKWjh56H/6HhsxEEy70VaxjIH7vlqXBBudy9vSU9XJ+b0sJsVYbfoJ+Xxpz66tzru0s/7sDqGEUqTcRSX8H6HQmKkavHIqiAVr3nhvhIejfmoNg339GgcEczFmempvEYalUa7IM3rA4vIyLht3LFtC1Bpo3UShPUqhegSbBU5d1ZlJZV6/MvoNlhuVqe0PUe2mFVDp0nPQIJyaEm+pmqIMD4B0uVL6iKlz9Mb0pITURWOJ72FLGXBw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(18002099003)(22082099003)(3023799007)(13003099007)(10067099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2A8Owk52gmV8AFUUOF+lD3oN3JVX6n9QqvUCX0T9O7v9x9LJv/jwySCd6oZ9p0Rt+Uk5t7eg56j6nCoYLVq3YjfKWSb9sqGkf9AVX1J6Zmlw93LcgSQ44uCvLGp1/0a+FPPhnBUKfvxI0VbnYcUV1qR3V35hpoPzX9r5xffz5AKab+605gec+HfLHCJMh5aeAeezDn3aflCmlGFyTZ0tycMIs8xtgeEupWhk2141tMaNG33NbobfcqOY+yeBZYMxfHC7XNVkSkLi5jtzI8dPIsX5HchQ6f/Lmrba2SD+N+xGzjKXGvMFDtlxpmy4G2BUt3INd7H/3whROgH/MvTRPNA5S+6szMWvSgDqsIje9Q0/Ihu/tm1d0w1IAEViPYak31DMgmRTBRr2uQziT0Pdh3Jo7Aa84yGKBI59EMFwPheiDo1oXfNVYUUK2odPvBAO
X-Exchange-RoutingPolicyChecked: fSgacS+OiNjJjBOc2guGXVaEbzXz4jQQivNz+HPlUuXZEEg5qsw0A8NjNWlnkMugZ0BCHEA87nMdgHADDs6qAig1/Mmx6YHL/HYw62ux9WqDEHu4OOFYS0QZhSUAO/DBLeqnKm49mHlGgLbS/KonwjQWgTDdbsgtIsJQ+gQqFdsDQEQOy2MdFu+/6690xc5ZHRuqLaUWnRm0iYCwZKGRCZWHr9Vj4C4joLlScwltc5/NbBersC7084DlUKioRl02yi3Nkx6bb21kC4+MMC6G4t979udos28gv9xp2u8jmN8MmKV/7j7GJaB53h6QzDb3Oq4OBqx0rhw+oS5SuD67WA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 23:23:46.1044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cec19e0-f1b5-429c-9a26-08dee45a7318
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6212
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfX68xSF/QLw+vL
 laceaQdWDpnVDCCunnyCPpS87BGstp19k6EEqt4Je0BH5/0SNZkHc4TVTHNc7rdalyQ+zJlVI4I
 lcjELr/+nzLjwfLYJTMi1TX0OCeuZC8=
X-Proofpoint-GUID: K49acG5IedFi9cO4lnHKBmfOLCJDg4Er
X-Authority-Analysis: v=2.4 cv=M7F97Sws c=1 sm=1 tr=0 ts=6a5ab98a cx=c_pps
 a=Lj9o+5Kg1g76LDS8oSCIAA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=6G3Wt455AjdQPmq9yuUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: K49acG5IedFi9cO4lnHKBmfOLCJDg4Er
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfX0wCnRfN8/mtf
 A43w2Y+3lpRKCW46WI5ISrxSwWuP6Z2Gly2s4d8oGS3lAppEcfdZu69y5e1ia+O3WE5tpY3nRDD
 yZJ2KHq8GsvIOSBR+DyhWe0Y3Ej68JC6d8d93f/LhGa6rZMfWlSI9mpDvCB7iZXvnjvFk+PqLnT
 1EVryeXCYqJG9y/SAZ5ksBleNb+gJeM9RMyY25N5VRAzZg8fsD4ZbnPQHDCrJVineuXDhfPmBV5
 +U1mezTvGRXP5wSv9P7ia5bJB/bzc4vP9giEq+2DRqyYRg9RHMH261QNdg92KgagEtxPatXms8h
 wkQIDkXh6W4DawxZqHJOzIfRNzU5aZXYop8CaBA8DyLIBNCNZQp+3yI5t7swtbSHTUBFYgWIq7q
 qVZ0PTSMiGXT7ICqw6QbE5hR9iXnry2DrXrau5eWNVRNtQFAWnklEnRcvWze/qKlVVvc3tCDOTz
 5fVpeCE5vRBinVd7UvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0
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

From: Vignesh Raghavendra <vigneshr@ti.com>

Add the initial configuration to build the boot binaries for the AM62L
family of devices

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am62l3-evm-binman.dtsi | 226 +++++++++++++++++++++++++++++++++
 arch/arm/dts/k3-am62l3-evm-u-boot.dtsi |  16 +++
 arch/arm/mach-k3/Kconfig               |  21 +++
 3 files changed, 263 insertions(+)

diff --git a/arch/arm/dts/k3-am62l3-evm-binman.dtsi b/arch/arm/dts/k3-am62l3-evm-binman.dtsi
new file mode 100644
index 000000000000..d058dfbd3881
--- /dev/null
+++ b/arch/arm/dts/k3-am62l3-evm-binman.dtsi
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0-only or MIT
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/ {
+	binman: binman {
+		multiple-images;
+	};
+};
+
+&binman {
+	custMpk {
+		filename = "custMpk.pem";
+
+		custmpk_pem: blob-ext {
+			filename = "arch/arm/mach-k3/keys/custMpk.pem";
+		};
+	};
+
+	custMpk-crt {
+		filename = "custMpk.crt";
+
+		custmpk_crt: blob-ext {
+			filename = "arch/arm/mach-k3/keys/custMpk.crt";
+		};
+	};
+
+	custMpk-key {
+		filename = "custMpk.key";
+
+		custmpk_key: blob-ext {
+			filename = "arch/arm/mach-k3/keys/custMpk.key";
+		};
+	};
+
+	board-cfg {
+		filename = "board-cfg.bin";
+
+		bcfg_yaml: ti-board-config {
+			config = "board-cfg.yaml";
+			schema = "arch/arm/mach-k3/am62lx/schema.yaml";
+		};
+	};
+
+	sec-cfg {
+		filename = "sec-cfg.bin";
+
+		sec_yaml: ti-board-config {
+			config = "sec-cfg.yaml";
+			schema = "arch/arm/mach-k3/am62lx/schema.yaml";
+		};
+	};
+
+	combined-tifs-cfg {
+		filename = "combined-tifs-cfg.bin";
+
+		ti-board-config {
+			bcfg_yaml_tifs: board-cfg {
+				config = "board-cfg.yaml";
+				schema = "arch/arm/mach-k3/am62lx/schema.yaml";
+			};
+
+			sec_yaml_tifs: sec-cfg {
+				config = "sec-cfg.yaml";
+				schema = "arch/arm/mach-k3/am62lx/schema.yaml";
+			};
+		};
+	};
+
+	tiboot3.bin {
+		filename = "tiboot3.bin";
+
+		ti-secure-rom {
+			content = <&bl1>, <&tifs_enc>, <&tifs_data>, <&tifs_cert>;
+			combined;
+			sysfw-inner-cert;
+			keyfile = "custMpk.pem";
+			sw-rev = <1>;
+			content-sbl = <&bl1>;
+			content-sysfw = <&tifs_enc>;
+			content-sysfw-data = <&tifs_data>;
+			content-sysfw-inner-cert = <&tifs_cert>;
+			load = <0x70800000>;
+			load-sysfw = <CONFIG_K3_TIFS_LOAD_ADDR>;
+			load-sysfw-data = <CONFIG_K3_TIFS_DATA_LOAD_ADDR>;
+			core-opts = <160>;
+		};
+
+		bl1: atf-bl1 {
+		};
+
+		tifs_enc: tifs-enc.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62lx-hs-enc.bin";
+			type = "blob-ext";
+		};
+
+		tifs_data: sysfw-data.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+
+		tifs_cert: tifs-cert.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62lx-hs-cert.bin";
+			type = "blob-ext";
+		};
+	};
+
+	tispl.bin {
+		filename = "tispl.bin";
+
+		ti-secure-rom {
+			content = <&atf>, <&tifs_enc2>, <&tifs_data2>,
+				  <&tifs_cert2>, <&tee>, <&spl>;
+			combined;
+			sysfw-inner-cert;
+			dm-data;
+			keyfile = "custMpk.pem";
+			sw-rev = <1>;
+			content-sbl = <&atf>;
+			content-tee = <&tee>;
+			content-sysfw = <&tifs_enc2>;
+			content-sysfw-data = <&tifs_data2>;
+			content-sysfw-inner-cert = <&tifs_cert2>;
+			content-dm-data = <&spl>;
+			load = <CONFIG_K3_ATF_LOAD_ADDR>;
+			load-sysfw = <CONFIG_K3_TIFS_LOAD_ADDR>;
+			load-sysfw-data = <CONFIG_K3_TIFS_DATA_LOAD_ADDR>;
+			load-dm-data = <CONFIG_SPL_TEXT_BASE>;
+			load-tee = <CONFIG_K3_OPTEE_LOAD_ADDR>;
+		};
+
+		atf: atf-bl31 {
+		};
+
+		tifs_enc2: tifs-enc2.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62lx-hs-enc.bin";
+			type = "blob-ext";
+		};
+
+		tifs_data2: sysfw-data2.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+
+		tifs_cert2: tifs-cert2.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62lx-hs-cert.bin";
+			type = "blob-ext";
+		};
+
+		tee: tee-os {
+		};
+
+		spl: section {
+			u-boot-spl-nodtb {
+			};
+
+			u-boot-spl-pubkey-dtb {
+				algo = "sha512,rsa4096";
+				required = "conf";
+				key-name-hint = "custMpk";
+			};
+		};
+	};
+
+	u-boot.img {
+		filename = "u-boot.img";
+		pad-byte = <0xff>;
+
+		fit {
+			description = "U-Boot fitImage for AM62Lx SK";
+			fit,sign;
+
+			images {
+				uboot {
+					description = "U-Boot for AM62Lx SK";
+					type = "firmware";
+					os = "u-boot";
+					arch = "arm";
+					compression = "none";
+					load = <CONFIG_TEXT_BASE>;
+
+					blob {
+						filename = "u-boot-nodtb.bin";
+					};
+
+					hash {
+						algo = "sha512";
+					};
+				};
+
+				fdt-0 {
+					description = "k3-am62lx-evm";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+
+					am62lx_evm_dtb: blob-ext {
+						filename = "u-boot.dtb";
+					};
+
+					hash {
+						algo = "sha512";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = "k3-am62lx-evm";
+					firmware = "uboot";
+					loadables = "uboot";
+					fdt = "fdt-0";
+
+					signature {
+						algo = "sha512,rsa4096";
+						key-name-hint = "custMpk";
+						sign-images = "firmware", "loadables", "fdt";
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/k3-am62l3-evm-u-boot.dtsi b/arch/arm/dts/k3-am62l3-evm-u-boot.dtsi
new file mode 100644
index 000000000000..dd826ce45510
--- /dev/null
+++ b/arch/arm/dts/k3-am62l3-evm-u-boot.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "k3-am62l3-evm-binman.dtsi"
+
+/ {
+	aliases {
+		mmc1 = &sdhci1;
+	};
+};
+
+&scmi {
+	bootph-all;
+};
diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index c9874fd57b8a..34ccebad769c 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -132,6 +132,26 @@ config K3_EARLY_CONS_IDX
 	  Use this option to set the index of the serial device to be used
 	  for the early console during SPL execution.
 
+config K3_TIFS_LOAD_ADDR
+	hex "Load address of TI's Foundational Security (TIFS) firmware"
+	default 0x40000
+	help
+	  The load address for TI's Foundation Security firmware. This value is
+	  used to build the x509 certificate to tell boot ROM where to place the
+	  TIFS firmware in memory.
+
+	  Unless you know what you're doing. Do not change this value.
+
+config K3_TIFS_DATA_LOAD_ADDR
+	hex "Load address of TIFS configuration data"
+	default 0x6c000
+	help
+	  The load address for TI's Foundation Security configuration data. This
+	  value is used to build the x509 certificate to tell ROM where to place
+	  the TIFS firmware.
+
+	  Unless you know what you're doing. Do not change this value.
+
 config K3_ATF_LOAD_ADDR
 	hex "Load address of ATF image"
 	default 0x80000000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S || SOC_K3_AM62L3)
@@ -151,6 +171,7 @@ config K3_ATF_RESERVED_SIZE
 
 config K3_OPTEE_LOAD_ADDR
 	hex "Load address of OPTEE image"
+	default 0x80200000 if SOC_K3_AM62L3
 	default 0x9e800000
 	help
 	  The load address for the OPTEE image. This value defaults to 0x9e800000

-- 
2.54.0


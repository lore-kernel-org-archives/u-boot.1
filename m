Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A94FC4452B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 18:09:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B131608C2;
	Tue, 21 Jul 2026 18:09:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oSYGIAx0Iq8X; Tue, 21 Jul 2026 18:09:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F110F6088B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784657352;
	bh=Kbv+tUmD+ZBAL1WpqE7Mh0FuQax0xqrA7b//ZEMZunA=;
	h=Date:Subject:To:CC:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=EULyYGi5K77Zh89M8Ln8+061NFNyvhllT5EyDNSXF4+GcxBA8Dn8nugnMfyBOyXGG
	 ROlB39q9Gn9alBUYRdKa6yd0B6HLqP5P4xcwiBQBSEOwUYyP6a4l/6lQ8hJ1VHcBfJ
	 UMJUZZttACMAw2qw8nrc9bUMWNYyBVg+VT+G4p9liqFhtkTiGYMo6w+dbLq30Kj1hG
	 3yZNACbjSI6e4+qjnfNsjOECXgFwD0ccUYxJ1oh+WifPMdEiI1Dkv8A7fG3LD/uTrg
	 4P7uRa4phj+Peyw3jZsKQVI76EkzrATXsQwK7bJeF5oBMAnv979Cs6jPic3Y4aT0E4
	 7CrJeqjqRYJGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F110F6088B;
	Tue, 21 Jul 2026 18:09:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 817BD109C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 17:28:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7337840120
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 17:28:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8EHHloEey718 for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 17:28:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=afd@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AB9604007F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB9604007F
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AB9604007F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 17:28:42 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66LDjHht1017817;
 Tue, 21 Jul 2026 12:03:23 -0500
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fj077mgef-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 12:03:22 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5d0Fus2xqYo2u+xwJFIR+ISzEnRxn2Pt9PIoOFAUTmiQ4FnECxDfJij+pFaUY/Flzt4zuy7IMFZYPi7tV9sBjw49HtbgI9z6pMqCt906U4b08zq2r0AkG9azjdjcmbepSATm9lmv9yNY9zOmSf1nMc2XKW6JG4iM1VrxpooVfkX70h1HgO0qbCJ90D3+cypwHTrxlv0IkiglleIekIxEJfokoGfatmfYFsagB9p80Z/u7GVvlKEawkfDSNKRCpnoue0x6MTA4eh9qkQIX1nSdxn4nGjib0OKIVMHxbVB2QldNIK6VStAqt9sFSVX9yPzcIqVZlLIjukPQMe/lBOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kbv+tUmD+ZBAL1WpqE7Mh0FuQax0xqrA7b//ZEMZunA=;
 b=oXUD0DUhvgGgikvyiC6A/yt9vVsL/LAM5XQLuktVcDYGg1p3hw9BY0Hmle/9/1e1UqowKuWOdVQre2zRiDZkun5nyyPsgwAFxTBXHSLaIpYg3Sg4Bp7YafciY1EHKClL9ZdupMk3MoEKnkfmnNC1B5PJyXQKwPof73aV3aIswmW9agYakl2sghXGHLWW9+m20w8vRiClxqp4IJ3Qnv4RZpz5cYjO9sn4jp1VZEpHJ+sOFJgDnCYUz85LtoeOc//4cdf0n6+u3fzJaYk0PoI30vAH8UNyShBT8p6z3GtpjTmgjz1wsfWyMqHQW5EFN+IdOH52KF/BWgd5dxTv9k4DeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from SJ0PR03CA0238.namprd03.prod.outlook.com (2603:10b6:a03:39f::33)
 by SA2PR10MB4697.namprd10.prod.outlook.com (2603:10b6:806:112::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 17:03:13 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::d) by SJ0PR03CA0238.outlook.office365.com
 (2603:10b6:a03:39f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 17:03:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 17:03:11 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 12:02:36 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 12:02:36 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 12:02:36 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66LH2Y1A1822694;
 Tue, 21 Jul 2026 12:02:34 -0500
Message-ID: <3bed7ebe-41e9-4f48-a69f-45c5b27b38fa@ti.com>
Date: Tue, 21 Jul 2026 12:02:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] soc: add data to identify the am62lx
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
 <20260721-am62lx-v2-3-33ff580c267d@ti.com>
Content-Language: en-US
In-Reply-To: <20260721-am62lx-v2-3-33ff580c267d@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|SA2PR10MB4697:EE_
X-MS-Office365-Filtering-Correlation-Id: af81c089-7511-4e73-de3d-08dee749f232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|7416014|23010399003|376014|18002099003|22082099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: q4zuEK4isvi2N2Ks2/d+W4UFUAMejHo22Apm5t9p53ZMqDRoCVexIpBM4Vet0fcq5I3VlUTZqkJaOc1aL3Bq6MvDySSKMQ9MXGWJSvOTV3/OlesxnBeisCH08RndCbgVcawTImf+/p0o2WkJ+GCQGrNx0XLUQEYa1nC9j7fAfkqwdb9wCW9Y3GmI/4X6uSa/dCowIRtrf1o8Raiy+P9MadCtqMPBKBrcD5lAcXKksGGt8rL1CnGRBx/2yEpxLPbMgDR9YPkpOVwEe//mrr43axzwqpEVIPje2F3VtvyfRBa3df0NB7Qhe4d9L2QP67H29i5A/FHBQfaNiQLscSo8g0Y+Kga/qitxUaK76r97ON3hFNw4PmRQ+k88/nhIhwYopRSONEIXYQuE5gU3Q6UBG/360dZj4c97r57x9DPNeLUujTwnXRI1eOFpNQVDqr9i4BbDAmx0qof8depuP1jP6Ks1Ze7PoEDQ0gOZPu7jypnAYHBBGNXdjd3reNPh2j+LNpXkpwbJCz+Zz6o37YurOjRlq2ZbQAwjaYKYGWbqCNOiT4ZJpComOq9R/GkwoB0JkorgixJYKYagjnUqjmM2oFRyaYEPcj3dSj2ius8OpBKpbAoyPBNZZBpM0qaCSFbgA2NM2cIBFFhY6TS2YRwcFaNdDHKhhyl90n2I2ApSAlg99ZyVnI+VcVY2/wWss6XNLp2HFdmzbusr4/dfYo6RWw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ha8iXzbggdOTz6Hap2NPzzhICdsGdi8fBJpjfFMMkSHZhNHH1dYlyva8JDoyajkaOx71c9ZIXYWcWMR20SzdpLJKTKcAzTWVKR7pP0Tpk9HSBQAVOw0lmxYNt8gNqmhwVw9j7mYfzf2hsskZqVmRQfo2W+a4ILtqEaL9BBy0X5qq+dp44a54NLKBXq8EDwNPewqZs9wSB2RrCQ/l20RSyRsZEPUC9wZ4zH4TLwHXkesjX9dpHg/SlOrRPkcac1q442a3o/wANjdd+59mrKW5eSej1a1O931YfELNdeYhwxOoWwDBbmSyUZeJNCGMhy9E+FSf4E5nA6Etkv6G+g/BT+KAsABG7A60YTH8DU41PlS/rnHe9WFmhfwHCaUirm8C4QwjnOmjPq3LFk4K3l8uX8BUOONhW9Vz4/lIlpSgDB+41uXIlouUEyIN5fIQ1mSV
X-Exchange-RoutingPolicyChecked: BoLmqS3BJ7C1Z2yco9JZ9d7N9Vr/uqNuBaRw/zCxXKL+u23DBME0LB+8WXJNEeWCoHiE6DJtIwXwuz8jpI4Y/FHphQhqI+fwiHyN0aPDiNIp4lUCOaszYarr6n4afC2R5FGjbtDKpezSaSAk11zaG3Q7OTqBWTShLaJL5fzx/Vcy/Q+ka/aivCaWfBLKLdhGKgCrJzCjoh+ITAoJd12gZ2WahXroP0Kl6KUXCcBWWlPynmeNafULWOZr3yKiSnyU7FNcxednGAKR2D3c38kSkXkYny1NEuaho010c633Or/FKsMg+B+67cmjgfPcGNJa2mOavp3LeW4NLTZDoabA3A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 17:03:11.3909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af81c089-7511-4e73-de3d-08dee749f232
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4697
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE3OSBTYWx0ZWRfX97CaQ6CjZC1e
 R3gC2aSZI5cZQd+njmk4Tk0NAUDDQE+aky7y3B7NdxNbmxsRaaLyQuBjswWLoBUz6d6O1gTRQ0b
 fCp/YrQj+scTljUAIAzY9+xZzNpHqClkgEDO38Y9jWEBGoUAqNITy2l14u98dxlAbsUvXSndZZG
 Z+AwqS/UUXcAKLY97LbU2Vk9heeE91eSTxUux8XA9iD137cP69BO5G0vswAms+v6aVlGAIR6ov/
 w61OEbvgkHbRYke0IBcdINl0YQBHlSAbROmrAmXi+z/7JJRmh8OPXiNsrZiBapbBg1cSyIl+SOj
 CiH+q9bgFLR9us8ctuwsptsL8yFZU/W9P8Ybcb1bBccdC3RTR/HaQwGpReyYW7Ths816lJ2VMd1
 bXki8xSGiYv8TfuMJKXCTkvqCOf4OxbWePcMY/SgWbF+xl1sJIQf3pa80rEXyJ+liIh8Mqm6mlX
 Y/xmOzBVQOr7rSGdPzA==
X-Proofpoint-ORIG-GUID: FY9-7evVHNTYhhhJhl2kCuncTpCOJ3-Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE3OSBTYWx0ZWRfX0NofeJsyIhkY
 5sKZSIjINZFpW0oXtGRDhxdRQhPjkNYS7pKYi7eS+1WNo33slUKZpdE1SnMtXfJ7bu+yFJGY0/h
 T5pLOOtZoGkn2fCzqKOhPwVY+CmPflU=
X-Authority-Analysis: v=2.4 cv=KabidwYD c=1 sm=1 tr=0 ts=6a5fa65a cx=c_pps
 a=XFLf1xCRaRgjZQpZvgYG5g==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=cHfVt7bAiTeVdc6EOm8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FY9-7evVHNTYhhhJhl2kCuncTpCOJ3-Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210179
X-Mailman-Approved-At: Tue, 21 Jul 2026 18:09:05 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Kbv+tUmD+ZBAL1WpqE7Mh0FuQax0xqrA7b//ZEMZu
 nA=; b=P6yLxnJUh2M92RFO9Eep7aVVfwSWSj64B8tOzfM/huB0tiP/njL1bhUuS
 cA9fiuG3PZ5pP4hQS/neOzu828IvzeuBi7e2xHye41IXNP/+ZWbM/yggQuEP21oE
 IkVvzG/WOKbKpXXfNln+8FNs+bzk111wxYWQXHZjYM7eEFF5BRH2bpWZw7aS3roy
 nOihU76v5GAR6u7t9Xr6QugruFcxNGPGLJyOuD/P8op7esJdH4YbEji8PJ0Dgeo8
 7WPzG3nLMGKtiWgKc+b2Mf8VXuTxA4NW7ytscJdregHFFY4Bt57Cpdcj4YYaJMvf
 qhz4QlYE9AX946fbd3l1HLi+ttfLg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kbv+tUmD+ZBAL1WpqE7Mh0FuQax0xqrA7b//ZEMZunA=;
 b=nYnFZXcif/19CAQWfWofdwzJjN5TvgWR2mOqsbQzutl0n8kNSOtuAF/LlgDiVKVcL60SITz9u4Rga9RjeuTFBqS3atf5uX7x6Kh/AM7JI1mKvO8VOjRcbaFHW/X/h2I8XAeh3gIta22g2X9N02/dq/WEpfZAblYFRhArQgu/Qo0=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=P6yLxnJU; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=nYnFZXci
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
> include the part number for TI's am62lx family of SoCs so we can

Commit messages are normal sentences, capitalize first letter, "." at end.

Otherwise, patch itself looks simple enough,

Acked-by: Andrew Davis <afd@ti.com>

> properly identify it during boot
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>   arch/arm/mach-k3/include/mach/hardware.h |  2 ++
>   drivers/soc/soc_ti_k3.c                  | 11 +++++++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
> index 2c771a1195f5..6b86f6ed12e6 100644
> --- a/arch/arm/mach-k3/include/mach/hardware.h
> +++ b/arch/arm/mach-k3/include/mach/hardware.h
> @@ -56,6 +56,7 @@
>   #define JTAG_ID_PARTNO_SHIFT	12
>   #define JTAG_ID_PARTNO_MASK	(0xffff << 12)
>   #define JTAG_ID_PARTNO_AM62AX   0xbb8d
> +#define JTAG_ID_PARTNO_AM62LX	0xbba7
>   #define JTAG_ID_PARTNO_AM62PX	0xbb9d
>   #define JTAG_ID_PARTNO_AM62X	0xbb7e
>   #define JTAG_ID_PARTNO_AM64X	0xbb38
> @@ -81,6 +82,7 @@ static inline bool soc_is_##id(void) \
>   }
>   K3_SOC_ID(am62x, AM62X)
>   K3_SOC_ID(am62ax, AM62AX)
> +K3_SOC_ID(am62lx, AM62LX)
>   K3_SOC_ID(am62px, AM62PX)
>   K3_SOC_ID(am64x, AM64X)
>   K3_SOC_ID(am65x, AM65X)
> diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
> index b34cbd08e073..6ffd88f22c09 100644
> --- a/drivers/soc/soc_ti_k3.c
> +++ b/drivers/soc/soc_ti_k3.c
> @@ -36,6 +36,9 @@ static const char *get_family_string(u32 idreg)
>   	case JTAG_ID_PARTNO_AM62PX:
>   		family = "AM62PX";
>   		break;
> +	case JTAG_ID_PARTNO_AM62LX:
> +		family = "AM62LX";
> +		break;
>   	case JTAG_ID_PARTNO_AM64X:
>   		family = "AM64X";
>   		break;
> @@ -72,6 +75,10 @@ static const char *get_family_string(u32 idreg)
>   	return family;
>   }
>   
> +static char *am62lx_rev_string_map[] = {
> +	"1.0", "1.1",
> +};
> +
>   static char *j721e_rev_string_map[] = {
>   	"1.0", "1.1", "2.0",
>   };
> @@ -89,6 +96,10 @@ static const char *get_rev_string(u32 idreg)
>   	soc = (idreg & JTAG_ID_PARTNO_MASK) >> JTAG_ID_PARTNO_SHIFT;
>   
>   	switch (soc) {
> +	case JTAG_ID_PARTNO_AM62LX:
> +		if (rev >= ARRAY_SIZE(am62lx_rev_string_map))
> +			goto bail;
> +		return am62lx_rev_string_map[rev];
>   	case JTAG_ID_PARTNO_J721E:
>   		if (rev >= ARRAY_SIZE(j721e_rev_string_map))
>   			goto bail;
> 


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A1DC4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 18:09:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA711608DA;
	Tue, 21 Jul 2026 18:09:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9NZunveg9ozK; Tue, 21 Jul 2026 18:09:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 34715608EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784657368;
	bh=qHmD5fMrK9tXWfqbjxTZnXhUVoGXUPu2RJPMWbjHedA=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=MtLADF/+2wJRvLiLmgu+yxmW9J//CEelNtpiupxz+HhvNcUb63RU6u457bSeC/x9e
	 8LqJVcQPyIaEp0MP3WJwq8JLhI5A0NBHHD0gXfch6fCdXy7rOJeouvbDlu6qHPzg9T
	 7vvvCvzbgxP9iJGP8+UD1/OrxYs27VQX1CsbjyJHSnZ8NmP+eeQymxhyTEOdD2M5O2
	 EdNmX5Ds3gMBvemYGteuwdyzRsE3DaLANglaqIP+3mqN1t2BiIbJ77816q93L6h8Oq
	 Y0WUTiYcPWH/EF48VE7JMt1JDgTHS5H5j7iQE+x2TnHzcTZ7gPR1PPErxIjaHQgDLr
	 8cvPlHFrhq6Ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34715608EA;
	Tue, 21 Jul 2026 18:09:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 76926109F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:27:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D04640167
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:27:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UK1T-okDcgPw for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 16:27:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E46E040277
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E46E040277
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E46E040277
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:27:55 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDjTDH986919; Tue, 21 Jul 2026 10:30:57 -0500
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012064.outbound.protection.outlook.com
 [40.107.200.64])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fj7pvsjvc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 10:30:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsQajRr502OqvmkKBn18cjaJ8zI8NYrScwdIY18c0vUwaiwKqZ1QhwMJHV+lC+/308TDGeJrksUiaOm1lFP4lbH9cNLKeUy67B6/eT1mEkv5Els4j9OQCzwGS7U8CDRCHHlMIa5TYSiPowk54bkepuQP7iq822Mgs93L6SWCMxvBkBxi2RbY1eZmfH6mkZMojtvVJfcnGLnUY2jzm3SFSvPn+3cRIFDLnmc9pUXWZIYggbG9zL36unh51FYi/xeHrme9sJ+XTTARzVt0JeloOWqFq0NA53sDOhi8XXteUBngvtFjviEtelh/aTw6mvtkQ3KJJrNUJFN0ZnbjDuYypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHmD5fMrK9tXWfqbjxTZnXhUVoGXUPu2RJPMWbjHedA=;
 b=FG2DKIKzgVAN1KnUC4HAHqj+XuP3o8innLzCyTRCeBlLlfhX03tWA4jnq2OTSKcBXHvJWn4kWidzNKQYn9LURfuAl00LPxvZlWXZOgf5l5JmUOzn45ZwEuCzePSFVi9cEKFW8e4qyNGWmSi9WslYHNqQStLv5PKirFEHXO6k23F+y3QKyaSZuhqEfOczRnkcsMVaz+hbsTfJgROStEiu4YRhaEDuNVLFLd809twpHCio+AeI4SyNnTLBc4sFriR5/1LXNFl7LtQAQqVjJKJtxGTNvybx1IcGIJBi28qdsqlFx1s+6OmEihNY7ZK/jRPcChUP4eRjLLbp7CWT7lyx3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from MW4PR04CA0337.namprd04.prod.outlook.com (2603:10b6:303:8a::12)
 by PH0PR10MB5818.namprd10.prod.outlook.com (2603:10b6:510:140::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 15:30:54 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::81) by MW4PR04CA0337.outlook.office365.com
 (2603:10b6:303:8a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 15:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 15:30:52 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:22 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 10:30:22 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66LFUMHq1655311;
 Tue, 21 Jul 2026 10:30:22 -0500
Date: Tue, 21 Jul 2026 10:30:22 -0500
Subject: [PATCH v2 07/11] arm: dts: k3-am62lx: Add binman support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-am62lx-v2-7-33ff580c267d@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|PH0PR10MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d85552a-a361-43a9-40e0-08dee73d0cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|13003099007|6133799003|22082099003|18002099003|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: OkRnIeLeuw+L87ssiaMtkxxRxxNq6Eb1GPQquBt/ZtTeOr996kpqmr4f1+lQPZroa4vuA1K91WS1cGl0mXKS8CJCZo3YAymoumIx1aZVmK5nRWPcZhozB5NSB2T0fcTr6NI2/eoDZxHoF/5qMztFz7FfrfoxebU8PwSWi1hU3X2pu+0xfm74HBBdJ9vHEyuUPoEvngC0lH5CQQa33wS3OsrgxlJMAyq7js/3TKaxUDuXHcUkPDBjaLRcM6Tzda7KYZC/J5yofam9XbFw7CgLUZeeCHsphQ/rU+9T1abcP15A1SoBFG7Ct7lfPeBXQc68TsIupoVB5e1IdnJVZrXqcqDlTeB2SnF5eH/PgSPX5zl+ycWtSEsZ9gA084M31Ea/53jFwE/Mo+vSz5M9yuv322ul+OTGPjg63DyuS8YfGu1pDDXtajgC+cOSGcMOnFhgyH8RAdHi+ZW3oXBsHFGk7FzZUkZwFcsiFcW8N2CSCYvhRSMa6CcWSJqWsOaOJgBOiFVkzR6Q4XeTtDV/pCb9rAOgcdGdGZA+PyiZI4TsKKzImiTuaJPmmp6Q9emzqBZDTeZLfj/6R+cIWJ88iM8s6XrSIGZtruljPT8iFCR/bhCiEwb0UdAY34pAKwwLzeQeO+8C3miGw1OJwOxkrfVz7g==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(13003099007)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tc4OOp9VBAAWqUR3Kck1z4KQfNrC8ynu9UyTU51ebdPjaHOnOKrvZUzIFSH/sg2pPK8czVus3+MVcD3mkt+w3sBCvscqia+iEBdl8J/q9qZK2KnIg7qm3BgpKgaf3/G/+nFFzZtdroHm5aqBaU/f5zldIt67MlsG/r2VYtYdT7D+YYqqBaMUdqWTdGa8m1l56dBKJkYqHLCZ6/901OiD5oiaQiCiu+3HDwNQt0hfSKVJ292Se0zTh5nFq1WCAFmAYpjHSGmAPvKgnhopMHl+dB2DanX7poNxWVInnYtgiyPjd77AG/SPVhV+P8lWBwafkMLerpP6BO5cj0hallj1Kpj00DyIRSQ9bg8mboJLkX/WRcQ9dUPrN9sIOZANJHP6tX7I/ELDYKkRSJHg+LRXr5xRoLGTMjNz6A3WE/a7qOAA/wYqmByjLcM9WQJWh6LV
X-Exchange-RoutingPolicyChecked: Xr6fMzC3ndIkR7Tg5/H3DGhmvoZjRlAtVaRyJ9TY1WsDvp4H0auut9850+YTNwkGwdzBBNUUhGhuGXCXeYJPF5KF0739T/O01NE55ewQxlTOro0TaPHpri2FGX9h464A9S9NY9++TZe4VKTzoXDlSdIkYgJiqyzNcHWe3WeUo1/zagXvMvPtDiDayJWjvhRUij28ctWo/e6h13oj7An7QvtnOzXpV4v9mFDFnOu2GhRoIQiMHVQGkLNCk6lI7Hv+4no3n7pXhrisSZ3+Y+pZfYndzubjbo9V4lmg14Sc1zMYefh7y+8rXkHBMDV/8ohgie8kKug/3S9iV4w3oA5Atw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:30:52.4559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d85552a-a361-43a9-40e0-08dee73d0cbd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5818
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfX0Y8ZPb08K6th
 1ODdtLt8jUvHmIQkx1C3s9aRzmsqFAXU9RoXYbe6n5ERpRlvAp0a7t8Eh/0aThO6TOJbA30WusC
 cd1ZbjDvlMskjh9furIa9xndqgUu3zA=
X-Proofpoint-ORIG-GUID: jXqwSdvwRhCoKgjvtZCGERp-6DGovp4c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfXxxnTsJJBZbJ2
 jZq73nfdIWA479hxw/NkgwPMLr0T8LoV9lAbas1J8hyd1v+wJSZX9FA4J0W+0vEYLJoNHaWG5di
 dL/EijLAp3EwsQkM84uK0asme9/L+S+6YVMevrjZ+s7N5s6WsF/J8wYYX7y7OBz/d22bl2PgoJT
 ezRYHjL0v02F7LVVwFo73IacppXfljgsAYD6S8NQuZk4Fp7IjaADL0eU/F7VfWw4rssxW+AaJ3P
 V2s/KLS5uOkefjWoiE4yRXOg+UG6oCXbvl5SDZOoW8fvXYsn6kG8zCmsRMqIz2JjSENANEHPqa5
 E/NhNwCBaqh+xqc155n7vouugApME3JV+K+VDsvLWcPneKnGGSdNqD3g8xOaetiiSsvhqjqUMsh
 oriVuDNZJ5vLo1w+F7MbVl3R5x3SuP5gtYcMoNyJHbq/8SkJfHnookK1rZBJa/9mlISKlenKl3P
 +GWAt10D2imG4eB0Evg==
X-Proofpoint-GUID: jXqwSdvwRhCoKgjvtZCGERp-6DGovp4c
X-Authority-Analysis: v=2.4 cv=MbFcfZ/f c=1 sm=1 tr=0 ts=6a5f90b1 cx=c_pps
 a=/CYSPFcZsPiriMCSbh9ShQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=6G3Wt455AjdQPmq9yuUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210164
X-Mailman-Approved-At: Tue, 21 Jul 2026 18:09:10 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=qHmD5fMrK9tXWfqbjxTZnXhUVoGXUPu2RJPMWbjHe
 dA=; b=h0QhUz1eCeTp2AaRo2UAJ9xJGDMBx1sKndTHPMW8A+FDkMPRqzuvpLXWu
 ZOzV5w25bUeDTFHzNPUUXirtuEfxXJ2Sahy/3z9gXTwMX83VdaNlL0qdfXif0XzU
 b/SeI7yZIHbUVpWsuIXhqEQEQG04ykVTJTmWAAMgJOeCoiWuCUNenQDSMfktZLYv
 o26TLfP8UY+EWPN+g0q54fBSikKKrynd3thJfeA7NE69jA1EHQ/IlCJxSSt6NCBU
 C/NSux0LMQgsROZNa9FixgRnfurpItf+GM4nqFiyuQOHpbRV52l7fLLBqNPYioow
 8gzDofx/RqrtsoBhQl71a0z+y7mWw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHmD5fMrK9tXWfqbjxTZnXhUVoGXUPu2RJPMWbjHedA=;
 b=jHROnm7kkAbMZEOha1qM3PVC3WW1l52/DL1KJOMYq8H/cOWksD4/6TochoOTjKtTWb8HZ8wqa30Lk+BFnEPOlUGUwHYU7EhNOOuV0xCW06ttczQ7rC0yxHzHYOvNd3TMkFnwyYcDYUj6dcMw7uDswRsdo9HClcrzmiSnlxSyGU0=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=h0QhUz1e; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=jHROnm7k
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

From: Vignesh Raghavendra <vigneshr@ti.com>

Add the initial configuration to build the boot binaries for the AM62L
family of devices

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v2:
- Removed bootph from scmi{} node
- Removed signatures from u-boot fit image
- Link to v1: https://lore.kernel.org/r/20260717-am62lx-v1-0-b9830633afb8@ti.com
---
 arch/arm/dts/k3-am62l3-evm-binman.dtsi | 218 +++++++++++++++++++++++++++++++++
 arch/arm/dts/k3-am62l3-evm-u-boot.dtsi |  12 ++
 arch/arm/mach-k3/Kconfig               |  21 ++++
 3 files changed, 251 insertions(+)

diff --git a/arch/arm/dts/k3-am62l3-evm-binman.dtsi b/arch/arm/dts/k3-am62l3-evm-binman.dtsi
new file mode 100644
index 000000000000..3f7e2097e521
--- /dev/null
+++ b/arch/arm/dts/k3-am62l3-evm-binman.dtsi
@@ -0,0 +1,218 @@
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
+					u-boot-dtb {
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
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/k3-am62l3-evm-u-boot.dtsi b/arch/arm/dts/k3-am62l3-evm-u-boot.dtsi
new file mode 100644
index 000000000000..d48b478b89c4
--- /dev/null
+++ b/arch/arm/dts/k3-am62l3-evm-u-boot.dtsi
@@ -0,0 +1,12 @@
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
diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 351ff3c19f1c..6e8ea2cdc7f2 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -129,6 +129,26 @@ config K3_EARLY_CONS_IDX
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
@@ -148,6 +168,7 @@ config K3_ATF_RESERVED_SIZE
 
 config K3_OPTEE_LOAD_ADDR
 	hex "Load address of OPTEE image"
+	default 0x80200000 if SOC_K3_AM62L3
 	default 0x9e800000
 	help
 	  The load address for the OPTEE image. This value defaults to 0x9e800000

-- 
2.54.0


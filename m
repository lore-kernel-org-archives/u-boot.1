Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2799FC4452B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 18:09:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08A6460872;
	Tue, 21 Jul 2026 18:09:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OGHfWEZpphdc; Tue, 21 Jul 2026 18:09:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 28D4660899
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784657348;
	bh=qsDEblI+EALURP1RhBZ5+WFyDW228EIdeL9SycuK5Os=;
	h=Date:Subject:To:CC:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=LcvDbNxBdbycLkp6sMTbVRo/W62QG412Tpbu1gAwsPI8BZMa/ZB1trBNmU/e/bs5s
	 X9ylkvKre1bugv8xNXVjM5o5h9+PYnWYlUBoW7Dpr24gGxJlbGnilS99sUuriEg9K5
	 xC1EtwJj3DhIpWNkvMCvtJ/fylgulsmQNMjePxbEkWTPVlWEo5jdEwyOM15gAvXVhy
	 WGhy//cj4M2LyxrJG/RS9B3voYlBhLowf54yxqJO06EFAXlT6AnZFNyLg0zuOhXWFL
	 8juZyNuHZLGQpCg3LIu1QWB3vk2dR9UjEiueqSfWnC8WEM1VHGnrv95qf8FTqSQds8
	 5AJNS0QPVtQyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28D4660899;
	Tue, 21 Jul 2026 18:09:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C28CE9E5
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 17:24:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B422180C44
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 17:24:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6MJVA0vL8unK for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 17:24:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=afd@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C58F580982
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C58F580982
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C58F580982
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 17:24:52 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDjTQE986919; Tue, 21 Jul 2026 11:58:29 -0500
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fj7pvt4y2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 11:58:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ezyi5768ovSrXPc+ciWYUa7bS36CDG0W1tji90AbLfNJiHPJdahblJA6Q0dsbUnLW3qSWP8wh66XZyr/LqeVat7YsUdaDDcBqLSRR0T9MDHD7tBR4erXeD7+C0P+3Ghu7zXm6p3G8gbTYoEzXfPJ12tX/lOWUDe4x4BXSMCHJvI34PFPhEKbeD5KMEyQ1aHBMnt5ti2mwVNcEcEdHxWKSWz2jCKzSEplth0FCvIXTveDb0h2/50Pc3rm3YCKr0HlEvBRFKpCJTlJ87KrtpvDzPexB/SmxjVaMQ6bcnYrWx861pTwZQYGpd1KTTeZy0H5Ymtrj9lniL4MUNXt1y9Y+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsDEblI+EALURP1RhBZ5+WFyDW228EIdeL9SycuK5Os=;
 b=CnBntQUU/Q2wH4BtoSqerdu+Auo0m2KLSZDoUUKGY4gQJcHckEOpqT9ih4bdp3sbVNMA2BcPfeGcafZX0ElY+1JlGSMDqrqk4zggVCkhT3MfeZjaSNS+CQregGlJr+J9iblnlfxf8ecXigNgKkJ0IiK0faR2yjBRnaocZ+Ai0UjQnOfXLzxkKbH8jHe8T4tH/5xrbK3RTyXBVHPrCzPmjLLJ8m0/q1N+Z17jl0XBPrD6WZMHHiaqg5QdIPGgbPzhXH8uxoN4RZdARSXB8iiEy0Y3RdJc/ugKiMRR/2LzLRFwhkbCKu9wMzFv6CPtiSQDpCbDavvITCfPEsjs+/1+5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from BL1PR13CA0080.namprd13.prod.outlook.com (2603:10b6:208:2b8::25)
 by IA3PR10MB8705.namprd10.prod.outlook.com (2603:10b6:208:583::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 16:58:23 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:2b8:cafe::a5) by BL1PR13CA0080.outlook.office365.com
 (2603:10b6:208:2b8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 16:58:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 16:58:22 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 11:58:21 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 11:58:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 11:58:21 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66LGwKd01187559;
 Tue, 21 Jul 2026 11:58:20 -0500
Message-ID: <d8c96e7f-ab22-4e85-afdf-1ae99968f2c8@ti.com>
Date: Tue, 21 Jul 2026 11:58:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] firmware: scmi: switch to dev_ofnode during bind
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
 <20260721-am62lx-v2-1-33ff580c267d@ti.com>
Content-Language: en-US
In-Reply-To: <20260721-am62lx-v2-1-33ff580c267d@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|IA3PR10MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 349db24c-931a-4431-9e7a-08dee74945e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|36860700016|82310400026|1800799024|4143699003|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: EtdLaW7hVGY968cmoRZV//NIO9udlTQPFfZsgpJ19Ni4fiAhCTI1fmYlUqQF1VhLIslsG/ITLr4/HqZKLz1uQrgNic33IUBpahQ6EjgbBw5cvnrKPy20OucSLg7nN+tcxDvMkIabHrWKbXqZvUbIKqGMkvT2h+NZpbsIQ481MWS+D45Pv00rk6gr7XF/MV/MdXMJ48Xwndu9MvGHh1ouvOQG96Ow1Ezuny6NLN/MYjP8byoja4bQ65bwH5tb0BO6KGlzi7dghp8UX9/Z2OO1FDe9jeq6x7Xwtl4ryY6ozlZQEEKnTq133oLkBka/bWTI+ILwiF0qATLtNgxalDXEgfkQNMnC9b2NDOncCQZn3OUbeLkEjyK0YP9YlwDYe/zRn+Wyh1KZvGw3aqqonTH+hUntiXFvrXMUgnO0izA0onVvUL6OyrUt1a/xNa36yYr6HUT6NkOaXGTilV5UpdtZzI4yeT/ZMKdxdOz7iNf1mkv+50yems6xrUkHrnkhFtVs9Cp9wivwXy3lS8yTgX/roPWhn5nPh0KD2a13NOK9TzqiQWsKZ2gKxEK1NcPaNYgrik32UacDgbftWnH0Qe4RN6rFGI6Sf2Wx6XLhm7TlcwDjRNGou1XYnQkeMnK+WLPFkhz3NBKy9SOov2x9l6llbN4lSMIpNAB9SU+5u56hq/TV33E3obMoJGzlEPJ6DsuNycP/RnjLjy637pQuIMnmSg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(82310400026)(1800799024)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YVLvIhKSmvhYdymDjMwR4QlApf9czDajODOrwplJxa+kcs6zMLrSLGJDcfS06uW2e+Pa31d0wV6l2vCoMgDU69wCbcjh9iygD2B/yT433Dw/Os63je684t1wMbejYAZKQd/SkUI6nNimyiQdkwzCLwamWQcXguq5Prpu5p1ZMn7Wr6HR04qUfthrHg4p9uuXFhDGxAnDXfUg6Cnh2RqPMrsD9YYuZoRtiuznjvauOgjNbbgWnVAXTJi5aSv7dZZPF7Ipq2ZoLfw519iq0YCK1pTqxus2mJO32dnDV9GhN7vx9Akd8p4nRaaDIILrkczGbmiz4uPjxQ2KiTeBqAetR5pueQVpCAolCGBDiepIWKbi8AQYA4eA2Xbvy6XfseOSleVbnm5jJIjaLpgRUvGRO5alu2Y8DQZ+SRSJV9/GYyWZuQP/2moOsT9W1vHRMHxG
X-Exchange-RoutingPolicyChecked: bL1fVCJpV7qSyk+ec4R6G8tWtWpV+uOdP0uPauCByiYUf+fng+FDpSgY2c/PV//CCmrWkpcofLjxoHrGxKJbqv/XSKfM9LWh4q06dtX5WoJjlTwwXiH3JeYbdvyOJYbmiyoV3Im+AGZiscbEW6OkG5crY6knFUy5Hr63pbCdKbccI7hTdepED4dhrFt48PR2KInAU8oosl6pTIQv4uUdidT02ZXe3GDnZJJkTPJSQFUKtIpWkoZYQFI7qruWCg1VXmJOSV3Voy/mkS7VnHN6hzJTX0fkbXMNsTMHMWKTKOcu8KhFINCx6G5O2GW7d8GJh4GfgrUXzkoVITG2XyC4fA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:58:22.3458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 349db24c-931a-4431-9e7a-08dee74945e9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8705
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE3OCBTYWx0ZWRfX4LYcUoJLXePP
 oGnSKhyZLXaVVS9pn/Ny7Lt6qQU82hek8h6yK5sbhWthVJa8jvIGiCZ/j8/Uv2fcHhNxh/m1dbF
 /B097XgN64z2emAfI2oqheEq6wNlRVU=
X-Proofpoint-ORIG-GUID: qnyisArDAvySXedgcGKyHmRaiyi-Tk4g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE3OCBTYWx0ZWRfX2hjcLuGemube
 lxbCyd2oXx7WKgTnfeb184lO3DtOjgCrlZoVutLyQxAIZjXZp+S3V/ZJGO/Ssxn7b9weHKqvZOP
 8EYlxJ4PtsP0kwNwkhriWcQ/u1vB7AKVDLwbiSAHnk9CoCfbb7ZlEHSv+Vq/M5ier9u7ogi2IDf
 X6gKO5hEgbeZ99hbaYSAsujEMm65v91Tkg9Uk4HmuZn0+XX+KGMBSPIOZmxAH4uV4gspElgYLqY
 BFavsYst22Rc+tCYZvYhzyDqz+gEMkwN0djEmKvMcpKcuI0kblRZcMEFEz8MpGWXYTyywuOuzTo
 yz7VHHEncq//GHVgIUbaO6V7YEjxYWG0OZxtLp/p4aEVhoDnzRE8g2uZDpCglDhnrslk6V8745S
 IwWmPdsstGCp4ZXo7IcU1gzSrxJU6jtrM0KJt+n91CUdAA4El9pZMs+pVQQhHwIRefKZZwyErvX
 rrTi0VMAvgKjigu7gaQ==
X-Proofpoint-GUID: qnyisArDAvySXedgcGKyHmRaiyi-Tk4g
X-Authority-Analysis: v=2.4 cv=MbFcfZ/f c=1 sm=1 tr=0 ts=6a5fa535 cx=c_pps
 a=lgH93Z6fMBj3OFKE3BLqTA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=y0WNTY8buRDf4ITlkV0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210178
X-Mailman-Approved-At: Tue, 21 Jul 2026 18:09:05 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=qsDEblI+EALURP1RhBZ5+WFyDW228EIdeL9SycuK5
 Os=; b=UhO/lVaX/IoFG4eDzGU8KxJFD8iiU7UWH4MtkofrTwf0kmqqDswsBB87l
 oXjKKUi2g5hh3tG7XFuKopweV7urgt2iEnDTH8qdBjF+uuhQHROFnM79mQGSnjox
 45tfJMQYLRrjy5RIFyyNaAcM6gKC5CvSZFc9LNzjgnyflwL6psJjYz6goGd5Ntk4
 mdq23xlhd9/P5aGoTz0JCjrgVQZjjmwIhiHnPnVvNFAhiIBFCGUfxDeFIqq6j5ZM
 oPL0bHg27xRPsrjz/bCYjEVGrJZ1SubWWt6uF81bL/a3yKa9gvw4helJp0XrZ5se
 01+LEbY4JnKj2DfzT1B9Tyx95RAxQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsDEblI+EALURP1RhBZ5+WFyDW228EIdeL9SycuK5Os=;
 b=LpVZLvqFW4Nog3Xbp3zNm6awKk6EBfE7S+UCyrf2sYHsNSMBhtMSJIfw/I/q/lYXuCaMtEKk5dNmMae2FsJonoxslys8r5nI4WLLCvAWScoig2MgsJcIepOGEKI683/ToSFLc5XkGncPzhiH+mAqVYrYfXzp00GcWuAdyol7W7c=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=UhO/lVaX; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=LpVZLvqF
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
> From: Anshul Dalal <anshuld@ti.com>
> 
> When using ofnode_null() the node offset passed to the FDT API will be
> -1 which is invalid and breaks probe. Switch to dev_ofnode()
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>   drivers/firmware/scmi/scmi_agent-uclass.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
> index cd458a7f4588..65c1ddad2b57 100644
> --- a/drivers/firmware/scmi/scmi_agent-uclass.c
> +++ b/drivers/firmware/scmi/scmi_agent-uclass.c
> @@ -437,7 +437,7 @@ static int scmi_bind_protocols(struct udevice *dev)
>   	/* initialize the device from device tree */
>   	drv = DM_DRIVER_GET(scmi_base_drv);
>   	name = "scmi-base.0";
> -	ret = device_bind(dev, drv, name, NULL, ofnode_null(), &proto);
> +	ret = device_bind(dev, drv, name, NULL, dev_ofnode(dev), &proto);

If we always used to pass null here, and that breaks probe as the commit
message states, how did this ever work for anyone else?

Looks correct, just something that might be good to add to the commit
message if you do a v2

Acked-by: Andrew Davis <afd@ti.com>

>   	if (ret) {
>   		dev_err(dev, "failed to bind base protocol\n");
>   		return ret;
> 


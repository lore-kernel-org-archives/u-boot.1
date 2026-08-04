Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F26AC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 11:29:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 403EB80899;
	Tue,  4 Aug 2026 11:29:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AfTnvJmN24W4; Tue,  4 Aug 2026 11:29:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8FC5D808A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785842967;
	bh=QrmlSbYpVfBjnQQcjFQOcdT5353J3LNRIGpmH6Uxzis=;
	h=Date:CC:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IaghGLEEiqv2NR5YtsH7QouEf8KWxlHLWXlr30f94VZWtIv0y2IH2PlcC7Rxb0DKw
	 hKZV4y7+N/8pret1xN1pJ/Xckn/TDIIPm8fI2vF2N5C4QHN+hsvcp85StDahBPpRCd
	 wa13lKdDks+Yypo3bqO7I5ATCkI2DAxWUDvMFBnUqTS96MkwPVAxhVdCY4Eq02y2ON
	 mFaorp9a6vjdqtM+OU3UQMwZ7Ku5R/EMvCkWP/aXPGl/8g8C9vpbw0T7c5n54ZvyTa
	 p7lnidMy+b6Zdpx2ypfofYf5EQ4X2fqKLS7oyS2ePjlaxskOhqY76oAuVL1uNLcn4J
	 rZ7ZX+8c+ApbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FC5D808A2;
	Tue,  4 Aug 2026 11:29:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EE4E32E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 11:29:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7EC71808A2
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 11:29:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QISCkQ5qk3LV for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 11:29:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B451980899
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B451980899
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B451980899
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 11:29:24 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67489sBf1948987; Tue, 4 Aug 2026 06:29:20 -0500
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fu75hu3b1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 06:29:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKQkmvIBHA87lDXKHPo0gmzibicx118TjTai4Mvar6Giky76N869+gCN3EaBkqvBqC1oAz8pBF+1HhKuVBz0jRrB3/T9THEgcrymtPVW9bU8KiBgOxKTnLR7WbU+QmMh6EaBElfiqd+vJPQ02zuQJw9kFXLTMZfIhqnIXBGtvXGJiRfvcFQZ3ZAftfA6KF7OrcAIC0MgBombX1ypOmTdNreXdkdEqOE4cjEV8fgKQjLO31g561vSg7InV4XYY6l8REN9dGA15lJKTmSeC9zf24yHtCgmsK1aVc0FI6yn4Be7yrrzp/hrVre2QweGGEDChBLzAdXB++7iilfM85kDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrmlSbYpVfBjnQQcjFQOcdT5353J3LNRIGpmH6Uxzis=;
 b=agamkdsavZOs24jK9iJslYzGwSxE4mZ24mzFjWSVhrpvJ5Om+sOc6wkgtxxXkxc5ftiP8t0pqQ6jcYIXT0NINE03pWwd/BqrUKlYsvTC4IxdmBWMTmQS3pz+celTDqJ/k2eCTiNckVaaga+ti6qfeCeFBdeM8DYgfVc5Wwo1smBVorxi/39UyLQIe9JuebP3/WhcLGTxFDXZGtu0UKSvbH8hUKlQexCj5I11yA1lluCwriOrFQY9DOxw0CZbdM9VDg9awlHiZQrb6vQd579i0ZmdcywilRN2def6inpPDQ0Wzs6GkgeyNsHS0+glRp+H0KfS31HFGXQfQr2mF2jZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=mailbox.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from SA1PR05CA0006.namprd05.prod.outlook.com (2603:10b6:806:2d2::10)
 by PH7PR10MB5769.namprd10.prod.outlook.com (2603:10b6:510:125::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 11:29:17 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::57) by SA1PR05CA0006.outlook.office365.com
 (2603:10b6:806:2d2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 11:29:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 11:29:16 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 06:29:15 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 06:29:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 4 Aug 2026 06:29:15 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 674BTEc9141788;
 Tue, 4 Aug 2026 06:29:14 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 4 Aug 2026 16:59:13 +0530
Message-ID: <DKG4HR3LCBQH.3T07GZZ963PZQ@ti.com>
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
Subject: Re: [PATCH v3 11/11] doc: board: ti: am62lx_evm: add initial docs
 for the AM62L-EVM
From: Anshul Dalal <anshuld@ti.com>
To: Bryan Brattlof <bb@ti.com>, <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
 <20260803-am62lx-v3-11-b4f4302b09b4@ti.com>
In-Reply-To: <20260803-am62lx-v3-11-b4f4302b09b4@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|PH7PR10MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: e266c3f4-e23c-4868-cfe4-08def21b9e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|7416014|376014|82310400026|1800799024|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jIMT0baU5JEz+TCBwDgnqKIH6wCKf01yFh8Aqd1aVMhK5/LRUuctLhKmSeP76VmLSK9HZILtey3YPFty9n5AqzP5ZvsrEm5ZoWBFfxJ8eHNkGnrIIA7ol3pFg8dAwNpGQkRz4Qw62nJvCm5h/8S1cDe8JH/dA5JOtd9gKQBBwh04WGCZR0ATTc0FnXxfg/brNK2ptpqDVGWg59WBbkfTvElIn+SGunTE8vl3zdO6DNpK+tzogRvOIUHRqN1QcDx0CYKb7/VLEK23ezAXEB0swPhHcEsAPGrHExeoILcIaEPxRjQhbahYwgGo6Ti3eZvHb7KRwsNvatsaHXqgdhxrJ+gNr3rW18CH/SV6SORBraNBdryTSBfSb/Y8hIq+6S39i2b8j46z569dMaL1AUoi+TiUr6vVOzP2r1V1lJ4MjfUnO1fOsPMBSRoplA+4DgHRK1ULg94zJStsoYi0Hq4G9paWkxj8YQvvg4Oy6/XBZWyy5gsojMi80cq7DosJjIYdx067KplimCzd+bPUgrpDecsicoMVgGpWIGIlAmmMmLk7+wPDAU1X6PTzbjUB/6xEAt2Ec7szHDr1/5J3bkPe/ElOVKRFGOxDk4oOLqHYVO/C/gGalruOI3ABNhE3TNDNyGk/BiHyYgdie9//cotZdUDPWm/SkjlM5dsPum64NUgZPFPIfRGhnki2yms9Hmb+WUSWpmCj299oWlAYlM8Gdw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(82310400026)(1800799024)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nwSCE8ova8pyDl+G5tQKFip/rkJNdxfwNlX4hBK6YBMQ9Z8/+hikgXMGqhyJXNPeE9qgYdz683A4EF1sDnoicWqtkk0cj7PDYuJkbbJGUQBZiRAVmUsatX4ZMMJfADYRDqjD76h1WmtHTTZw3jFS5HeTqEoVsywrj8WCaidk0Pqhuz3gE7f29G8E7N8qK1NCF3Znk5npuIV7oCqYJAaLXKKJZE7CzKjlelyLj8tW5+JS+6RCIRL7XbQxCdiKLxEXSIOXvnakhyikSJfKdoghCtDH8V0SqemjP+KGLK+A4piujsxRI/bTHZbUtRkaHkQFsIpAHviIrgEEWDahTdhOoqLvnrGZpGEAFKR/X6hHbZef65sFfdrE879kGes3vHIlq0w4zJQhRT11jS4CZNB8uzJWNLuBnYegYXT7yBPi6AbGNWdn5t9RaVbzp8na+nXY
X-Exchange-RoutingPolicyChecked: mgif6uY4za9nVVTl+6F6xBz47mgkjPqjs0qMMfl4RiOlqSIj8GmNme+sFfHucAm2SM0L6Gf1cqMG7dgugs++gCG7yGbjvlIVBiWs5doIICyK3+lS8JeMehjNX2PEbOTyo9P04EjIzFpfTmEDtgD24PwccFttA/LjZknWx24qi2koXRX8HcZnjFDSk0Wlah5bsuCg2OPUKU57XY/npvqRLQ0rBl5X6wtX/Lgsjp3T868NML/OzoCO1Dij/a/JwkaW7vXcctC7bONkOHta7mMVzRHmUNhGF7reI3JmTDqx5oaIV+jCa3ErF+Wc4jlEPf+6L6oUsQK2JdiIexCTUFlhjg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 11:29:16.2742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e266c3f4-e23c-4868-cfe4-08def21b9e16
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5769
X-Proofpoint-GUID: NHv3n2jcWXIxy_4R6Wy4uZVKHnJZLSn0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA5MSBTYWx0ZWRfXy80hiemnkrAm
 TNoNmyXq5nc6cSXBGaSARPiASo01sbYWfdGuVY6eC6bQb6G52GgX3OTXZH0qge5Z2/McYtHd+6K
 0BhHJVxefuhPL+F/IzAe2KUtWI+8QkJgZeOfBhRl5+y6oZ47XiKUvz8o2izt+e7OpwtNeysw/J9
 VRfv4xHGs1CKZ/yOpwhhCnmWBY3QhgaPv59Mnbl2JhXpJogiU6X+Vpf6F7AZsXMmN2zXjoBbfZA
 bygZg9/Coavtb5xPhGMu4dEBlpByo1Na9SX2L/afFDlAs1IpaEWE+viPt3RM8LUtc6BIZKSsWPL
 v1sOqmxCqXhbKb11wp/2PQWe0iqVwZEOFaKMFt7WSTpPIVjRG4ub75GDKoFovcXmUUqjKqeTMOc
 owzk9NYJ0qCI3HSnghMIzwx6czH5qI4fDo7JsWYTSwYBw7wbmAz5+HPlytYjI15AyCt+m8xjki7
 +JR+O2jGMbBGPeCnGgA==
X-Proofpoint-ORIG-GUID: NHv3n2jcWXIxy_4R6Wy4uZVKHnJZLSn0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA5MSBTYWx0ZWRfX0JPAHwoVde+1
 TGwipYBM0Wq413KovTL7zEmpnPYjUOL0bRFKGJ1V4dEibGzsQyCxMy79vDFvOZ08nABdxI+IBnI
 So36BSRFsmQAReMV9zatOBmqpXNCDBo=
X-Authority-Analysis: v=2.4 cv=UIjt2ify c=1 sm=1 tr=0 ts=6a71cd0f cx=c_pps
 a=h5F5dVrtafxD4HcxutFXpg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=Jj1Sk-gpw053PRlbI9MA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040091
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=QrmlSbYpVfBjnQQcjFQOcdT5353J3LNRIGpmH6Uxz
 is=; b=JaIR+coFk+1/AJ+km/xL2OADSPsx/s/DP4zhymNyYmdnIoj4lPJxegk6B
 to6uvOBBcJTQsPPeLGzkB6o5Oekmk/6iiUtd+DNMBTePSVmL/YoAxatqGsDIYUm7
 vTxoIp5atRI0nFaFOfFp7fS2NtHyaHSIymIEXSc12WYd/RQWqkpS5yOs95vZnaQO
 LoV+NjD/hvJ+YmjL9ikyqLfDQqRnCpqIuxC0RdvJSBSBxGwr4o1TZwpjoNpNWqk1
 dWZipPnftFPTAy1PS+9/HBCjRV4PqUoxXr/pZ6pPmnQVmppy5e0d0o6I8rII6Qat
 Ehi2fnlAIRNPuf4ZaB/0Ugrq0KX7w==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrmlSbYpVfBjnQQcjFQOcdT5353J3LNRIGpmH6Uxzis=;
 b=Ya5iEhgbJQz95yfCTsJ9IOLb/ZZUdoCH8YzfW6IxjVrhLUJD7BKFsNF44OYIGP0hCTIzPGfLjL7QLt+8uIs35JPEGCdfq9mYYuKR7uY9yKIqwY72YR+x6cHe1b9gxt+0JZjmcRMZzCjdkmQ2gHhHAzcGoqWFuuXVPE4azk4am1w=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=JaIR+coF; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=Ya5iEhgb
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
> Add the initial documentation on the bootflow, build, and deubgging
> procedures along with the relevant links to more information about the
> AM62Lx processor and the reference board.
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>

Reviewed-by: Anshul Dalal <anshuld@ti.com>

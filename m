Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342BCC55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:55:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC68260792;
	Tue,  4 Aug 2026 21:55:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6D6v9Gx9CU3f; Tue,  4 Aug 2026 21:55:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A1E9607B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785880547;
	bh=wY+qm5yda/NnzRX0AozvcR8lid2I2GFwBf2r9r/uLMo=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eCQQO9jJWXpQkqYY8WTmj/W5yLhHZ/ts0WkejX8ZFac+p2fGI9D9D0S4UNdAhIxDL
	 gscCStigm5IcmdOhbxIMBC7ED/79ZgRNEXjpLkwuN2HfAvSPrjAeDDIC9PU+xMXksX
	 5x5tpmh0HKhifcMWeUdsrkGI2reNXsJHVGrG3QjSzjDPuiSP70lNX+HMtSLjHGsgZd
	 3YEmX7Sd1zUHw9ITUvZy7xTZ4lDk/TbticdeLd5mJXpGSUIyTQV8orboGO3WGfIIHV
	 2JAkaaa3CbRssfNQuZQNxnZ28jpmOvfYJDBjTGW92DA76/7SVqAT+Wyw2roU0HGLTV
	 Tuu2IaEp/41DA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A1E9607B8;
	Tue,  4 Aug 2026 21:55:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B7CEF3FB
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9DAA080D1D
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GozPcB09JJm5 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:55:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C88FD80AC6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C88FD80AC6
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C88FD80AC6
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:35 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674JoXgG3707909; Tue, 4 Aug 2026 16:55:31 -0500
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fufckce8j-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 16:55:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbfkoKwvTV9j8So3HXkDE0YjbD6FS7qRXclBoMxTDB35irepROFpueCqi//09fpC/ArBhIqqW6SBCeFT+VVZd1qc5XwPaUl7lXrvjxxajhPTPn5b6EpIaRoTE+WmdHDTgndPDP91xzn2fpLujiy+lkcw3f4neGtfqBYm8dzMxFOd0gwZq3PY36V0aQgaV6MDgcqLGwdF7LgxNmZrqjk/+2lhOPzDTlZf0J4A61gqpA9cJPWsZaHR1OHlpNFf13ymX3Kgl8nwFjLlayKNqorQmYmdPCcz6lTHbJ5q1G6IHC2XaaSPsgW8OpW6spqs5Dv2+Hm0PjoWMo9K6lMKNJT/qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wY+qm5yda/NnzRX0AozvcR8lid2I2GFwBf2r9r/uLMo=;
 b=RQJi7aZT6fucb0KCqAiBwKeKgPKNJIfE6eX/dWDb9PiK/Q6eAqbQ8kPtMzM5K3E/oTh2UZ4uBWMg3XrgSWtG47GUpvB7zBui9GPKSD+60rFxd50/vcsT07uwX2lnMEMh4/dkfhomwpalOSwJO6rUJfCmTZttpY0YxIsRVSF89L9PAwEkSMOE0P/QZwq/uOe8TygrB9DjgQn/MT/weeasmkjuwGIwyMh+a+TGzJ134ej5maYMmPNvHd2AT7jsJwCVot0ODkl5LFaaSInH4Wu8BbN1VSTKAmAsV4rGLoANnvSZoNHEUT5egAeV7rTj1qxRzLPnbgp2eTERqSlcWdOHiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from MN2PR11CA0005.namprd11.prod.outlook.com (2603:10b6:208:23b::10)
 by DSVPR10MB244415.namprd10.prod.outlook.com (2603:10b6:8:37a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Tue, 4 Aug
 2026 21:55:26 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::81) by MN2PR11CA0005.outlook.office365.com
 (2603:10b6:208:23b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 21:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 21:55:26 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:19 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:18 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 4 Aug 2026 16:55:18 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 674LtIxj968775;
 Tue, 4 Aug 2026 16:55:18 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 4 Aug 2026 16:55:09 -0500
Subject: [PATCH v4 10/11] doc: board: ti: correct path to tcl scripts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260804-am62lx-v4-10-01746157643d@ti.com>
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
In-Reply-To: <20260804-am62lx-v4-0-01746157643d@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Anshul Dalal <anshuld@ti.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, "Bryan
 Brattlof" <bb@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Aristo Chen" <aristo.chen@canonical.com>,
 Udit Kumar <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Chintan Vankar <c-vankar@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=7049; i=bb@ti.com;
 h=from:subject:message-id; bh=NOJLvNz5Ib/qZCJ310XOKHCw8yzlDi+8XQ/TjMjf2Ko=;
 b=owNCWmg5MUFZJlNZ97PPLgAAaH///7f7fn83/l304/HNk7R+3+T7/u63vcfP8/t+uvFb698wA
 Rs1tjtTIxNDTTRoANNANNAAyGgAAGjEAMhoaeoMgBggAGmmJpkaAaGjEep6h4kQAANAAaABo9TT
 QABo0GjTQAAybakANPUAaaPUaGmgD0h6j0g9Q0aGjEPUeoG1DhMRk08oNNNNGJoGmQaNDT1BkaZ
 ADEaAxAaaGgaA0NNBpoZGgAAA0ekG1BkaAcO3CVSP11wIweCthOQCBOTMZIEaxAakwCsOK6xeQF
 h80NPSscFR5QYugN6sEAkEZNQbRTYCyhuX5NFFHAzxrHLYPtX/GD97CYO2gadDqqd/OG9wuvLaG
 rdEBcbZqFK9Lfo8xXDNPvjQa/cNMtWJQ4ou4L0FHs8hnYhEiIxlx+XqW5VoNg4gmGtzQbi2k9+S
 aMV453M4foUL87hi3a/iAzyum+uN5WcIl8DBILvCE7UONECl1rJeBy3hFkFzod1KqTHPlAP8EHe
 J/SKFoC3Qny9siT9CSyGPgblgp5vRX0BpY4L8wm1nTv08yvutmj5wttepKcD7iIkHaB+WE33RQ2
 SXdOCIEYsAKR4q/RD5dORKAmgEI05N/3yBB1ZKhjK4LUQdYgARl6nFD8Q3L0USpZSojTi2pcaYA
 7IcwymqFcKnvf8XckU4UJD3s88u
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DSVPR10MB244415:EE_
X-MS-Office365-Filtering-Correlation-Id: f5d8df48-42d4-47f3-6f40-08def27317a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|7416014|1800799024|82310400026|13003099007|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: onYJ7n8oW4z2MpZIAMStFlnqweA423h7kN0asWEBf2pIpRbvT/ttWkBmLDJM4s4noht7I86mEK1svPXC2acioiKm6YVSditc0lNUsvs6tpkHJXVy1y7igVeSLVRtSy8qB5zOnEKfiv614fV18mGARFcqfbT8r3sVgDXRoxWqSWbLulvnFST7FxYB/jjmt2py5SeCZMERqOXoizBHmGSJdLxpMeY8zex//aJNv/mya6A+3Nji9rVFNO7V8EpXDHHUoIc5cWmgVRekwjC7mx0M3mBegNl+wts2j5zeP47yMHXxIxGhBLY9LknYHjECikNcj8oVQZwrbHVfECi9oHel1WB5hyYJZgzOY1ncJoex+8CXASWeGN9y8yRjIr82S6k5nYyoD5keZj4pDDz71nQXPKHab/k5ZN7s4xD7R8bh0aVohe9odDZfMlBAI86Xa+rfBSnyU1+IMunij3VMyxVwWEAHEeSoKRyI46gVxvFFaTrEY8XqH9v1s1PaXPmBFfcKj8I1NqzOgVM8Tmg8sDq+Avqb6YHTsLLXpO7QXmVnq0X8rcdDMBglHaMiRHwBwDjVJcVJfhHsdX0i9k8Weh7j8jCZiEGJcziPBriPi+KTxsHlkpiKp9okVgpnnuVd9/pHlX3FngGRPqDErd5IASXJs5CH5Q1dUPh2PYjSxGhUg84icSBkO+UISREqDfvgkrarJkxzHjFy050eke2TgkPJXg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(1800799024)(82310400026)(13003099007)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZgUcmAu4osnylRnh3xC8H5Rhhrl4Lz32uazkiLUXtfohaXIZAlTvXr1kW6BnNoal45TK//zQq3HdRuwhvxeBMfcPfM79WsUMX4ehGDgPH2WQznOVJ2x3EOZ8xrdVxZtigGTRP0TTIxygaZPrRdWQbQFeXbdZkWy6LzqWudu8qSESbV2ZDdEGSDpOk6I4wV09wWQG1bW6j0D+pRQT5M0YPL6aqa7F8WiB2jt6pV2rlvowVldj14GaMk1dAtyZRkiWbSV3ssI7CqufibWyydclEZvGVnMr10jEjpW28MsilUK1Nn0qMxNe2r/jbQMrGIxwHuwuqGlOLZIcU/jeqmiK9cpN9u6u4SxmmiB30NnaW3Mf0pI4nzZrSS13bK/c4bOn+qHrsptJZS8UlI34Qgb32LB6yX5k66HW+cjV7kJeSJEf/3x/DeB6wvYL+ChFQM3q
X-Exchange-RoutingPolicyChecked: EmY1ruiOlwXEKW+9SsiE7XMG6ovyFswGi6P19ukQ9+Msa1L/nFJTYK/4keIcYf1THcNIgDglGERkhiw0QLF3XNU99XwwmrGAfVe4NYcf018ATsbqtNCRYhNI/8d/GFk7tzFCaXmR2mlN+d2s5ZBSeOFV2QcU+3WqY+EF0GSTcGzAgg6x7PWJdU+j7soq5JljrmQpoU/8RGvdfW46gZc+mU+IU3L6qD409TE1RgDRllcDBuv00qRZBkT6vMXxmDltu5P7BdIDXMY9NpEhVG3jEaN2MFpBjJPBtiWqumOABI7dxyho8/DLYbiO5vQE6wKAOay0IiBI7IKsvRkrrbi/gQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 21:55:26.3869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d8df48-42d4-47f3-6f40-08def27317a4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR10MB244415
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfX+g1N7CUi+/QP
 LEUvNo0TLJZOZUJGoVeJI05ehuYMR2DclbuM2qw3DKMfd1B+iekjMmsCqSo854BCUVSYQKjx5wX
 LyiBTm9Rg8QukAen4SU3DpIlBT0QOV+ZEI4mg+qumLM9dZU5TtvkSGTBVSS/ZZpdrGpv1TD4qJC
 S6f07SbMgXmoXNALeP+Cwuz7CSMlA1dc1Uc3QseuUu/mI7wvegzNvdw8ThEP/Smqv+kJanOVeIY
 RnKPrTRB+cQHh5wEgOdydOlhaPTkEcvOL11S34TPfLx8gMFuvPOJjHIsZW7XzNQhIM/t1FfZMA6
 +nhk8MjwCW84PquxlXejqV/byu3pMiHne/fqxlyjEFU8UF/ybBJqvrgcdUbKKHIEN2NgEWQHYVF
 p0BI2H27tXajCeo+//9Xd5grEVy7R9plvO+z4XOC2BSKMaC9gzo96EilvLzFwXDSZk7z+qCvgFz
 fT+IGj/StuCEeKcsO7A==
X-Proofpoint-GUID: AiegfJ_geikOO08r345O1J-cMKBo5Ioa
X-Proofpoint-ORIG-GUID: AiegfJ_geikOO08r345O1J-cMKBo5Ioa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfX7S85trA5j1vQ
 /CJIsqK3HKTAkftsmW39UJPmGc5UdDi//Z4oT5iu6hO+rnc34paNy6KJ9zCnKiueeTNOYKWNWnr
 C1YU4DqmUlHlGQblWlepXAhxF+ORNtI=
X-Authority-Analysis: v=2.4 cv=GNA41ONK c=1 sm=1 tr=0 ts=6a725fd3 cx=c_pps
 a=p5SqRtR3VJW1kgksvcX22A==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8 a=P7QV38PIZAIlP8tCo1MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040177
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=wY+qm5yda/NnzRX0AozvcR8lid2I2GFwBf2r9r/uL
 Mo=; b=cuY1KDW8aq1BwDjv4QICCj6DAjIhfeb03uj1j9XqTvNrE65JnIw3E6vGE
 GczDwqB6M4qq74aO+og2hPrAASkx5x5JrBbfYeu07RTTKpEkNUS4FcXCk4b5oXTY
 O5dirwIoP+J5nFWByVq1l/5Yu9R5Ed5X9+PK7K35jWtUTAYHA2U9p3z9zNUfVy/4
 j3Q54Atw8Z4pWmlLTZPbYZFHoNdjbvQxJMCXJP6kW4bAMcUQMTmIgF+vf3xgb1UT
 GoQnRC/M6cNBSJ2/stJ/AESLwnwcFpgoOjzZGCLisMbXVeS7lmFOYycJ3OimGJPB
 wYmYTDJ2VY8dN+BPFT+c4KBo4kj9g==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wY+qm5yda/NnzRX0AozvcR8lid2I2GFwBf2r9r/uLMo=;
 b=HfrJGp5W9i1/BU3XyLqRv/N8fXSdWCceRPYyLe8g/6FPkwmbd/W/3O8PAO3gEDDk5/7qXYP982p6kYMfhYIRHpYQg/NdzXQhX/hLajwKQF0BWL6x4G5LqIadHUbuTu6BuoriP4JKRIIxgqCSEBho+WcTEUq/eJSGPQfyJNmz++U=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=cuY1KDW8; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=HfrJGp5W
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

OpenOCD has moved where it has placed the tcl scripts for TI's reference
boards. Update their paths to the new locations.

Acked-by: Andrew Davis <afd@ti.com>
Reviewed-by: Anshul Dalal <anshuld@ti.com>
Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v4:
- s/necissary/necessary/ in tcl script update
- Link to v3: https://lore.kernel.org/r/20260803-am62lx-v3-0-b4f4302b09b4@ti.com

Changes in v3:
- Kept warning about which versions of OpenOCD have the tcl scripts
- Link to v2: https://lore.kernel.org/r/20260721-am62lx-v2-0-33ff580c267d@ti.com
---
 doc/board/ti/am6254atl_sk.rst |  2 +-
 doc/board/ti/am62ax_sk.rst    |  2 +-
 doc/board/ti/am62dx_evm.rst   | 11 ++++++-----
 doc/board/ti/am62px_sk.rst    | 12 +++++-------
 doc/board/ti/am62x_sk.rst     |  2 +-
 doc/board/ti/am64x_evm.rst    | 24 ++++++++++++++++++++++++
 doc/board/ti/am65x_evm.rst    |  2 +-
 doc/board/ti/j7200_evm.rst    |  2 +-
 doc/board/ti/j721e_evm.rst    |  2 +-
 doc/board/ti/j722s_evm.rst    |  2 +-
 doc/board/ti/j784s4_evm.rst   |  2 +-
 11 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/doc/board/ti/am6254atl_sk.rst b/doc/board/ti/am6254atl_sk.rst
index 18a3520b39c7..0df058aee157 100644
--- a/doc/board/ti/am6254atl_sk.rst
+++ b/doc/board/ti/am6254atl_sk.rst
@@ -305,4 +305,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash $
 
-  openocd -f board/ti_am625evm.cfg
+   openocd -f board/ti/am625evm.cfg
diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
index 3453ed339e7f..b04bfc991ea0 100644
--- a/doc/board/ti/am62ax_sk.rst
+++ b/doc/board/ti/am62ax_sk.rst
@@ -435,4 +435,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash
 
-  openocd -f board/ti_am62a7evm.cfg
+   openocd -f board/ti/am62a7evm.cfg
diff --git a/doc/board/ti/am62dx_evm.rst b/doc/board/ti/am62dx_evm.rst
index 0d12e3ec1476..88071b3e69d9 100644
--- a/doc/board/ti/am62dx_evm.rst
+++ b/doc/board/ti/am62dx_evm.rst
@@ -237,10 +237,6 @@ detailed setup information.
 
 .. warning::
 
-  **AM62A**: OpenOCD support since August 2023 (git master)
-
-  **AM62D**: Uses AM62A configuration (compatible due to same core architecture)
-
   Until the next stable release of OpenOCD is available in your development
   environment's distribution, it might be necessary to build OpenOCD `from the
   source <https://github.com/openocd-org/openocd>`_.
@@ -253,4 +249,9 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash
 
-  openocd -f board/ti/am62a7evm.cfg
+   openocd -f board/ti/am62a7evm.cfg
+
+.. note::
+
+   The AM62D-EVM uses the same tcl configuration as the AM62A-SK due to
+   same core architecture.
diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
index 44dae4afc870..ad98c030ab23 100644
--- a/doc/board/ti/am62px_sk.rst
+++ b/doc/board/ti/am62px_sk.rst
@@ -331,13 +331,11 @@ detailed setup information.
 
 .. warning::
 
-  **OpenOCD support after**: v0.12.0
+   **OpenOCD support after**: v0.12.0
 
-  While support for the entire K3 generation including the am62xxx
-  extended family was added before v0.12.0, the tcl scripts for the
-  am62px have been accepted and will be available in the next release of
-  OpenOCD. It may be necessary to build OpenOCD from source depending on
-  the version your distribution has packaged.
+   Until the next stable release of OpenOCD is available in your development
+   environment's distribution, it might be necessary to build OpenOCD `from the
+   source <https://github.com/openocd-org/open ocd>`_.
 
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_openocd_connect_XDS110
@@ -347,4 +345,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash
 
-  openocd -f board/ti_am62pevm.cfg
+   openocd -f board/ti/am62pevm.cfg
diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index ef9425035cb8..2e4923f7a7a1 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -867,4 +867,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash $
 
-  openocd -f board/ti_am625evm.cfg
+   openocd -f board/ti/am625evm.cfg
diff --git a/doc/board/ti/am64x_evm.rst b/doc/board/ti/am64x_evm.rst
index 65c4c456528c..6f02a1eef883 100644
--- a/doc/board/ti/am64x_evm.rst
+++ b/doc/board/ti/am64x_evm.rst
@@ -227,3 +227,27 @@ https://www.ti.com/lit/pdf/spruim2 under the `Boot Mode Pins` section.
 
   For SW2 and SW3, the switch state in the "ON" position = 1.
   Boot bits on SK is reversed bits to the bootmode signals
+
+Debugging U-Boot
+----------------
+
+See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
+detailed setup information.
+
+.. warning::
+
+   **OpenOCD support after**: v0.12.0
+
+   Until the next stable release of OpenOCD is available in your development
+   environment's distribution, it might be necissary to build OpenOCD `from the
+   source <https://github.com/openocd-org/open ocd>`_.
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
+    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
+
+To start OpenOCD and connect to the board
+
+.. prompt:: bash
+
+   openocd -f board/ti/am642evm.cfg
diff --git a/doc/board/ti/am65x_evm.rst b/doc/board/ti/am65x_evm.rst
index 73ceef2e531c..5f75c01ec65a 100644
--- a/doc/board/ti/am65x_evm.rst
+++ b/doc/board/ti/am65x_evm.rst
@@ -321,4 +321,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash $
 
-  openocd -f board/ti_am654evm.cfg
+   openocd -f board/ti/am654evm.cfg
diff --git a/doc/board/ti/j7200_evm.rst b/doc/board/ti/j7200_evm.rst
index 4fd2aff83547..e5c29c2bbb7b 100644
--- a/doc/board/ti/j7200_evm.rst
+++ b/doc/board/ti/j7200_evm.rst
@@ -232,4 +232,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash $
 
-  openocd -f board/ti_j7200evm.cfg
+   openocd -f board/ti/j7200evm.cfg
diff --git a/doc/board/ti/j721e_evm.rst b/doc/board/ti/j721e_evm.rst
index 41c8d4c72a8d..c3f3736e625a 100644
--- a/doc/board/ti/j721e_evm.rst
+++ b/doc/board/ti/j721e_evm.rst
@@ -261,4 +261,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash $
 
-  openocd -f board/ti_j721eevm.cfg
+   openocd -f board/ti/j721evm.cfg
diff --git a/doc/board/ti/j722s_evm.rst b/doc/board/ti/j722s_evm.rst
index 4b5cf0275940..3d11271613c7 100644
--- a/doc/board/ti/j722s_evm.rst
+++ b/doc/board/ti/j722s_evm.rst
@@ -255,4 +255,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash
 
-  openocd -f board/ti_j722sevm.cfg
+   openocd -f board/ti/j722sevm.cfg
diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index ec82228ab908..54b4b6031f0c 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -663,4 +663,4 @@ following.
 
 .. prompt:: bash
 
-  openocd -f board/ti_j784s4evm.cfg
+   openocd -f board/ti/j784s4evm.cfg

-- 
2.54.0


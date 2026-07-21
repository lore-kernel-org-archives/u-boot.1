Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2D7C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 18:09:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A9DD608B0;
	Tue, 21 Jul 2026 18:09:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id suxU5OtK9tEZ; Tue, 21 Jul 2026 18:09:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E8EC5608C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784657365;
	bh=La6CFNCr0fMXbVQmDlapy/a8RN4Cxn5bSEhxefx+PkI=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Hqhn4etiRHmmQXw6lYin31764Q1vI2SArbev0hIxl/oEGORHIPgo9BBq1K1GJSpVg
	 annXyOR9J/okQZ6p8O26WX6mYAsLTzmwW0gugfmsUPkVdKQJotVXdGeTEDHoHu1sDn
	 oYjOqZBpWzITMRdFfLNCoJ/pGWJgepmz8Cply//7i/kxWmqFI5JZ6zRP/+KhGiyw4N
	 n5FrflWt8DgtruZn1DhRJioSFoGeB6p7qutKnLHEcOr6JxWXCZ+baTFYBhxiQA5M5Y
	 0UKMXJl/1RIk/M6xDrdfZgyEZcCgJB2aH1nljYOk4ICbS0jwY9svwFNPmBSYzw0p6G
	 0QZSD2lYO1pmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8EC5608C4;
	Tue, 21 Jul 2026 18:09:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A8AD9E5
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:26:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C46080E6F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:26:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6wGP654oiBuI for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 16:26:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org F211A80D59
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F211A80D59
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F211A80D59
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:26:13 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDjRpQ986904; Tue, 21 Jul 2026 10:31:15 -0500
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fj7pvsjxx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 10:31:15 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UK84PUydmXft/HsdcUUTIlHOZtTKIsceUISEYM2U8Tv2+pNioSy3Ce2Bpti/aj+IUv5PolMt/HMFuVkzyEKEt3gDAzDbKZZPxoUVSscV7Ie8L7AKJHN5ie5iww43mrcfrY6GCYhdO8s2UWI4j4wpEGC+AGjnKbBrXw5Xs2uvNfpBHA+0Hkq7KnYROCDQU//wjIqPkrNOLQQq5dBfC5sN4QMFL61MivsPyrbGOjjqo/YWyj2/qwR20wEQSQdLcJ5DtHPavKY0nyDGeA8Zt7EWPa57dUU6BJIegajtoHTlEBmtJIn+WKTzJBBL6du+K4v9yobbF0pIII1sjCPcXFwYhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=La6CFNCr0fMXbVQmDlapy/a8RN4Cxn5bSEhxefx+PkI=;
 b=a2Zv+fRpXA76QaTkLlvd9jbdmplOnW4bOmBuu+oqMU6BuSTuNPe5VLDMF6bB5TixgiOWq6/P+qNbE/AgKV4G+MiqabNuW7fzbP61zk/EiiihIAckvCASFS/00wzecmoWDphyJOx88fpd4L3w1tolBm+sgZzPCzUP5KCttzTygT8GZGPMdLsU4h/2l6Wml86qRG2XIj5tgNVj1a5ceBJEceQAQSKNsrmX+0CuxO2Jv3brPVmrKMBcAYgU1VDjaFWf5mEGAqyI9+ZEPgcpVX25EkDH2MkcDYAItE4AvNL4NIsNv1ozXBvoJFW2y/PiHpSAvp8FqmNPXeKLVxOWG0YQ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from CH2PR08CA0030.namprd08.prod.outlook.com (2603:10b6:610:5a::40)
 by SA6PR10MB8136.namprd10.prod.outlook.com (2603:10b6:806:438::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 15:31:13 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::7d) by CH2PR08CA0030.outlook.office365.com
 (2603:10b6:610:5a::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 15:31:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 15:31:11 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:30 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 10:30:22 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66LFUMr81031830;
 Tue, 21 Jul 2026 10:30:22 -0500
Date: Tue, 21 Jul 2026 10:30:21 -0500
Subject: [PATCH v2 06/11] board: ti: am62lx: add initial board files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-am62lx-v2-6-33ff580c267d@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|SA6PR10MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: cf37f0a4-eddd-47c9-686c-08dee73d17d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|23010399003|56012099006|10067099003|6133799003|3023799007|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: vl//x2qtoyIJ6G69C5YmW+3y2JYRcCiOyEB95x2flfsBUZpIVPf5QR3on2wyYS9QkWJNJTXBiR1DOjaotdjxyZuyK+9YjUptDy614SPlgyaQ4tLTLT0MPo/QE3/+DqPeKzIIRLDfgCzS+vo3OaRoYGY0inqUD7qg2ArIVlPGIFaUpMxZZ9ntwsUxnoyXzIpmHrNSuZIcieh3nDvPLQUNyQvlWtywVAykf/B1rNYc+UEF0S4SHaYoU1D5NaSkoRrEf7uer9pPlvk5+Bk8SNEW38KjuhcCqd+oMiffJZoqJ/xdGsEUPxSKM32Btg2dsZIOu5YW5boHAISHB56QhDsnDhyN3sfTXxz3aEVIATuEi9fiTwS5VJD+xhFq4yMtATRuDXyMcSDKh2EHm/AcpMI1rbu3DZf+/eYdXx5lNsnaIQr85ZWbMHBPPStc0Tk6SANv7C1VMY7MUkx8X9h2RbaJzjmmaUgbeOsdZAIIh9hLEaCt7gVUWJ8dDewf+fsIIdd5QX+HjhTZ2CApEfASdRBD0C2h1YIdrC9DknV9ib5xk5qYPEckwy3BFc786bNjj9epG9MugsW1BLgP/nDvx2gCfJ9iY01X2fPXEL4r1p7Mw+YRqx4cD4Z4TF+eeDkbtojcyane3Q9Lln9T80CqqQ81mw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(23010399003)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sXbjkSoNgedMS6U6zRL5o4eZdxllsEzCkTzYq4gCzYbnTdE6BWTr+V8suLA2tq9B0Qi8e5qqRUHHjnNzNHIW6lHrntn0XZE6ZvZWWplOone+iDaJVySVWdHEXTL6ewAUQFo6Y+8JEYnySH8dtY8o3GIBnVdBbcF0sNp0M8zwFFpATJpUEqugf3hBTX4KKi3AX5AmS/7nA/XCaBqFgxso7OUcXTqgZVC7chfALHT/3qTh9ltGUY8KXMFm7t7xEx1glWu8qqWf1fIyFG8a30wKiwln8rJ69AkfSaBSOYl8B/BluDYYGzWQSt9E6AEN+4V6Tzm7MFSQXrWKLuW6tZwsZ9/6LT62/a7Lup2uQCh9ZNsfEaLTwMtJ6WfvUgKsl2wymPQEa2j6zXjiSMfm5b0XBNXdzkB1Q72vvof8IgTaqoaeVozzxQ+KL1BT1QeLLBVq
X-Exchange-RoutingPolicyChecked: D2PLYjFwLsCVosDmvolZGkY3TCKY8niDn0jb3RicDhatAt9Y1HnMRwkMZkmxaUK/S0sdP+Kq8TsuSvPA4Q0+gXVxvvVP0v+qTouJ4T1i0MzaaK46nB/wjkkHq2EEK8xlV5ZEOcYMHfXYkjag2qiu5XD4bpjzg59JdL7UKi9HJc3IINt+ToASLl4rmCvThmnKxRmKfafkskjTxoNb2gyy3QbHzpSjJInZUO57vazAbY1I8PZqhuYsYv4MSy5pLqses6aDfYTX54UacvKQqVXDOQ3qvttyapenYQtUy5SVgFn06pUTRTOhsVBkKq0sh7uciYs+7QgNS5TH93PHbmwzOQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:31:11.0963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf37f0a4-eddd-47c9-686c-08dee73d17d3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8136
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfX2j2jhBMYadKq
 4AQ87Kr1hnIr/dFXiTamRFi6SdRZnyk9VrQVlL9x6AXB8l1fni7KWNljLa11TxrKEXT+eKJl6tB
 uBoojWjJzfHlQ1mmLHA+sJe+DazVlrg=
X-Proofpoint-ORIG-GUID: _WBz7e0I_r6c-yjf8_FJxjh2A-b_dagp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfX3l950is3aQ9b
 duTzmBAFNp3qHYgtXU37CQbT5lfCwjTIZIDoZo+CDDVg0a7BZWJn4XpvFxtwit7krDnw7fPs2T3
 YNCe2VWBznQ9Hv5++KJE+wOUCpFCqq6QO7/wwRM6YFy43h7pGAWGVPXqICp3SjJ5dJYhHX6eVGQ
 /9OaZaySUo3u9EQyyDLLJl3abzWvFty7jx0AA41Jjj3e7vWTDTq5TTP8ePysMXuuE/4FYMgvBs2
 9IHktoko82IIrdO0QRsXluHxWqd6ShkbqESxt7Q6KYtTa6Nu/12/NHIOVkglepADZfk1xCJaMvX
 m4R7r1233ULqUp7Bhuky+l0YBGqHaPLrKyd5jWo8Fa+nZnOaYNHYdso4LUOHbbLWC3dzYT7qEHd
 jQBhpmvKsbztN0iYYdDhC9nT8bjJwD2vMH6acbJlSOduoUIafecjdxjJmq9sQyqX4KE+Mw4fbB2
 yYGIwjfKd1LHp8oXleA==
X-Proofpoint-GUID: _WBz7e0I_r6c-yjf8_FJxjh2A-b_dagp
X-Authority-Analysis: v=2.4 cv=MbFcfZ/f c=1 sm=1 tr=0 ts=6a5f90c3 cx=c_pps
 a=FnNH6Hr+id3EzXqhVuY+iw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=k-42gJp3AAAA:8
 a=PIOz4nRI_0vEO2-WwqMA:9 a=QEXdDO2ut3YA:10 a=uCSXFHLys93vLW5PjgO_:22
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
 proofpoint-05-2026; bh=La6CFNCr0fMXbVQmDlapy/a8RN4Cxn5bSEhxefx+P
 kI=; b=AXj1SIUECyvkpOjnt67+C6V0uyLiW8VhutrpGEvZdtXson5++HjJ+u5oi
 oA+TUcaAS1jKM27ZzHF/7iMrmhnBraZCmtlutfymnB5PwZbpW19JLJMsrHVcC4G0
 5zJanXHTY+1buicwMcAayuDoq+HI3Zf/hZ5jIZlikRwY8kRQl/ARWWK6D/lQWffK
 tgehDf0AM1yPtiMnJLCil9aVqg/hbOmEQwacGHn7P4z7WItJmTcNgOzzHnK8AET9
 4zaD5x9j9QNQWr6haZy9km2eoBWRT1SMti5WivnPiXoLZjBqUa7qvYEnzCDsl2ga
 +1rtzGmsoJRCpdvz12cNjqcgYv40g==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La6CFNCr0fMXbVQmDlapy/a8RN4Cxn5bSEhxefx+PkI=;
 b=sr70gJWLlBbCTAgJnLFWncEj5QS7OUzjZEJlh9pLP9NQo2wIRcm7hg5Bo3XoszJ+Ny22bjrnyyhx7v7Nbc52/T8ZHQooUZT92i9DGmJPTs8/LpJXRN+Ru0i0Dydc0GaQMOeMcvI9eI1CTITgzNVUydz9RqFaQGpApW9qdUqhpxc=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=AXj1SIUE; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=sr70gJWL
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

Add the initial board files to support the AM62L3-SK reference boards
for basic boot via SD and MMC

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 board/ti/am62lx/Kconfig        |  19 +++
 board/ti/am62lx/MAINTAINERS    |   8 +
 board/ti/am62lx/Makefile       |   7 +
 board/ti/am62lx/am62lx.env     |   8 +
 board/ti/am62lx/board-cfg.yaml |  32 ++++
 board/ti/am62lx/evm.c          |  19 +++
 board/ti/am62lx/sec-cfg.yaml   | 380 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 473 insertions(+)

diff --git a/board/ti/am62lx/Kconfig b/board/ti/am62lx/Kconfig
new file mode 100644
index 000000000000..2ee6d0221178
--- /dev/null
+++ b/board/ti/am62lx/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+
+if TARGET_AM62L3_EVM
+
+config SYS_BOARD
+	default "am62lx"
+
+config SYS_VENDOR
+	default "ti"
+
+config SYS_CONFIG_NAME
+	default "am62l3_evm"
+
+source "board/ti/common/Kconfig"
+
+endif
diff --git a/board/ti/am62lx/MAINTAINERS b/board/ti/am62lx/MAINTAINERS
new file mode 100644
index 000000000000..e945689a7f17
--- /dev/null
+++ b/board/ti/am62lx/MAINTAINERS
@@ -0,0 +1,8 @@
+AM62Lx BOARD
+M:	Vignesh Raghavendra <vigneshr@ti.com>
+M:	Bryan Brattlof <bb@ti.com>
+M:	Tom Rini <trini@konsulko.com>
+S:	Maintained
+F:	board/ti/am62lx/
+F:	include/configs/am62l3_evm.h
+F:	configs/am62lx_evm_defconfig
diff --git a/board/ti/am62lx/Makefile b/board/ti/am62lx/Makefile
new file mode 100644
index 000000000000..ac5f5e7e807a
--- /dev/null
+++ b/board/ti/am62lx/Makefile
@@ -0,0 +1,7 @@
+#
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+# SPDX-License-Identifier:     GPL-2.0+
+#
+
+obj-y	+= evm.o
diff --git a/board/ti/am62lx/am62lx.env b/board/ti/am62lx/am62lx.env
new file mode 100644
index 000000000000..0dd86db400ee
--- /dev/null
+++ b/board/ti/am62lx/am62lx.env
@@ -0,0 +1,8 @@
+kernel_addr_r=0x82000000
+fdt_addr_r=0x88000000
+fdtoverlay_addr_r=0x89000000
+ramdisk_addr_r=0x88080000
+pxefile_addr_r=0x80100000
+
+dfu_alt_info_ram=
+	u-boot.img ram 0x83000000 0x400000
diff --git a/board/ti/am62lx/board-cfg.yaml b/board/ti/am62lx/board-cfg.yaml
new file mode 100644
index 000000000000..ae4b0e503bd1
--- /dev/null
+++ b/board/ti/am62lx/board-cfg.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Board configuration for the emulated AM62Lx
+#
+---
+board-cfg:
+  rev:
+    boardcfg_abi_maj: 0x0
+    boardcfg_abi_min: 0x1
+
+  control:
+    subhdr:
+      magic: 0xC1D3
+      size: 7
+    main_isolation_enable: 0x5A
+    main_isolation_hostid: 0x2
+
+  bm_writer_cfg:
+    subhdr:
+      magic: 0x7D8A
+      size: 5
+    allowed_host: 10
+
+  reserved: [0, 0, 0, 0, 0, 0, 0]
+
+  debug_cfg:
+    subhdr:
+      magic: 0x020C
+      size: 8
+    trace_dst_enables: 0x00
+    trace_src_enables: 0x00
diff --git a/board/ti/am62lx/evm.c b/board/ti/am62lx/evm.c
new file mode 100644
index 000000000000..cafafb8ede87
--- /dev/null
+++ b/board/ti/am62lx/evm.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Board specific initialization for AM62Lx platforms
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#include <asm/arch/hardware.h>
+#include <asm/io.h>
+#include <dm/uclass.h>
+#include <env.h>
+#include <fdt_support.h>
+#include <spl.h>
+
+int board_init(void)
+{
+	return 0;
+}
diff --git a/board/ti/am62lx/sec-cfg.yaml b/board/ti/am62lx/sec-cfg.yaml
new file mode 100644
index 000000000000..044e8cb09dd7
--- /dev/null
+++ b/board/ti/am62lx/sec-cfg.yaml
@@ -0,0 +1,380 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Security management configuration for AM62Lx
+#
+---
+
+sec-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
+
+    processor_acl_list:
+        subhdr:
+            magic: 0xF1EA
+            size: 164
+
+        proc_acl_entries:
+            -  # 1
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 2
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 3
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 4
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 5
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 6
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 7
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 8
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 9
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 10
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 11
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 12
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 13
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 14
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 15
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 16
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 17
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 18
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 19
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 20
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 21
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 22
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 23
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 24
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 25
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 26
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 27
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 28
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 29
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 30
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 31
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 32
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+    host_hierarchy:
+        subhdr:
+            magic: 0x8D27
+            size: 68
+        host_hierarchy_entries:
+            -  # 1
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 2
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 3
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 4
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 5
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 6
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 7
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 8
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 9
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 10
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 11
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 12
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 13
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 14
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 15
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 16
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 17
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 18
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 19
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 20
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 21
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 22
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 23
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 24
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 25
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 26
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 27
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 28
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 29
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 30
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 31
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 32
+                host_id: 0
+                supervisor_host_id: 0
+    otp_config:
+        subhdr:
+            magic: 0x4081
+            size: 69
+        otp_entry:
+            -  # 1
+                host_id: 10
+                host_perms: 2
+            -  # 2
+                host_id: 10
+                host_perms: 2
+            -  # 3
+                host_id: 10
+                host_perms: 2
+            -  # 4
+                host_id: 10
+                host_perms: 2
+            -  # 5
+                host_id: 10
+                host_perms: 2
+            -  # 6
+                host_id: 10
+                host_perms: 2
+            -  # 7
+                host_id: 10
+                host_perms: 2
+            -  # 8
+                host_id: 10
+                host_perms: 2
+            -  # 9
+                host_id: 10
+                host_perms: 2
+            -  # 10
+                host_id: 10
+                host_perms: 2
+            -  # 11
+                host_id: 10
+                host_perms: 2
+            -  # 12
+                host_id: 10
+                host_perms: 2
+            -  # 13
+                host_id: 10
+                host_perms: 2
+            -  # 14
+                host_id: 10
+                host_perms: 2
+            -  # 15
+                host_id: 10
+                host_perms: 2
+            -  # 16
+                host_id: 10
+                host_perms: 2
+            -  # 17
+                host_id: 10
+                host_perms: 2
+            -  # 18
+                host_id: 10
+                host_perms: 2
+            -  # 19
+                host_id: 10
+                host_perms: 2
+            -  # 20
+                host_id: 10
+                host_perms: 2
+            -  # 21
+                host_id: 10
+                host_perms: 2
+            -  # 22
+                host_id: 10
+                host_perms: 2
+            -  # 23
+                host_id: 10
+                host_perms: 2
+            -  # 24
+                host_id: 10
+                host_perms: 2
+            -  # 25
+                host_id: 10
+                host_perms: 2
+            -  # 26
+                host_id: 10
+                host_perms: 2
+            -  # 27
+                host_id: 10
+                host_perms: 2
+            -  # 28
+                host_id: 10
+                host_perms: 2
+            -  # 29
+                host_id: 10
+                host_perms: 2
+            -  # 30
+                host_id: 10
+                host_perms: 2
+            -  # 31
+                host_id: 10
+                host_perms: 2
+            -  # 32
+                host_id: 10
+                host_perms: 2
+        write_host_id: 10
+    dkek_config:
+        subhdr:
+            magic: 0x5170
+            size: 12
+        allowed_hosts: [128, 0, 0, 0]
+        allow_dkek_export_tisci: 0x5A
+        rsvd: [0, 0, 0]
+    sa2ul_cfg:
+        subhdr:
+            magic: 0x0
+            size: 0
+        auth_resource_owner: 0
+        enable_saul_psil_global_config_writes: 0x0
+        rsvd: [0, 0]
+    sec_dbg_config:
+        subhdr:
+            magic: 0x42AF
+            size: 16
+        allow_jtag_unlock: 0x5A
+        allow_wildcard_unlock: 0x5A
+        allowed_debug_level_rsvd: 0
+        rsvd: 0
+        min_cert_rev: 0x0
+        jtag_unlock_hosts: [0, 0, 0, 0]
+    sec_handover_cfg:
+        subhdr:
+            magic: 0x0
+            size: 10
+        handover_msg_sender: 0
+        handover_to_host_id: 0
+        rsvd: [0, 0, 0, 0]

-- 
2.54.0

